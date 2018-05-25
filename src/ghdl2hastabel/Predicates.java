package ghdl2hastabel;

public class Predicates
{
   public static void add_entry
   (
      final String predicate_name,
      final IDs... params
   )
   {
      add_entry(Main.get_main_output(), predicate_name, params);
   }

   public static void add_entry
   (
      final OutputFile output,
      final String predicate_name,
      final IDs... params
   )
   {
      boolean is_first;

      is_first = true;

      output.write(predicate_name);
      output.write("(");

      for (final IDs param: params)
      {
         if (is_first)
         {
            is_first = false;
         }
         else
         {
            output.write(", ");
         }

         output.write(param.get_value());
      }

      output.write(")");
      output.insert_newline();
   }
}
