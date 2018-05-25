package ghdl2hastabel.vhdl;

import ghdl2hastabel.OutputFile;
import ghdl2hastabel.Predicates;
import ghdl2hastabel.ParsableXML;
import ghdl2hastabel.IDs;

import java.util.ArrayList;
import java.util.List;

import javax.xml.xpath.XPathExpressionException;

public abstract class Node extends ParsableXML
{
   protected final IDs next_node;
   protected final int depth;
   protected final String[] attributes;
   protected final OutputFile output;

   public Node
   (
      final OutputFile output,
      final IDs parent_id,
      final org.w3c.dom.Node xml_node,
      final IDs next_node,
      final int depth,
      final String[] attributes
   )
   {
      super(parent_id, xml_node);

      this.output = output;
      this.next_node = next_node;
      this.depth = depth;
      this.attributes = attributes;
   }

   protected void handle_read_expr_predicates
   (
      final IDs local_id,
      final org.w3c.dom.Node expr_node
   )
   throws XPathExpressionException
   {
      final List<IDs> elements;
      final StringBuilder structure;
      final int elements_count;

      elements = new ArrayList<IDs>();
      structure = new StringBuilder();

      Expressions.process(elements, structure, expr_node);

      Predicates.add_entry
      (
         output,
         "is_read_structure",
         local_id,
         IDs.get_id_from_string
         (
            structure.toString()
         )
      );

      elements_count = elements.size();

      for (int i = 0; i < elements_count; ++i)
      {
         Predicates.add_entry
         (
            output,
            "is_read_element",
            local_id,
            IDs.get_id_from_string(Integer.toString(i)),
            elements.get(i)
         );

         Predicates.add_entry
         (
            "is_accessed_by",
            elements.get(i),
            parent_id
         );
      }
   }

   protected void handle_written_expr_predicates
   (
      final IDs local_id,
      final org.w3c.dom.Node expr_node
   )
   throws XPathExpressionException
   {
      final List<IDs> elements;
      final StringBuilder structure;
      final int elements_count;

      elements = new ArrayList<IDs>();
      structure = new StringBuilder();

      Expressions.process(elements, structure, expr_node);

      Predicates.add_entry
      (
         output,
         "is_written_structure",
         local_id,
         IDs.get_id_from_string
         (
            structure.toString()
         )
      );

      elements_count = elements.size();

      for (int i = 0; i < elements_count; ++i)
      {
         Predicates.add_entry
         (
            output,
            "is_written_element",
            local_id,
            IDs.get_id_from_string(Integer.toString(i)),
            elements.get(i)
         );

         Predicates.add_entry
         (
            "is_accessed_by",
            elements.get(i),
            parent_id
         );
      }
   }
}
