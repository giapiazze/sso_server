module ActionView
  module Helpers
    class FormBuilder

      def fa_check_box(name, *args)
        options = args.extract_options!.symbolize_keys!
        checked = nil

        if options[:multiple]
          value = options[:value]
          obj_name = @object_name.to_s + '[' + name.to_s + ']' + '[]'
          obj_id = obj_name.gsub('][', '_').gsub(']', '').gsub('[', '_') + value.to_s
          checked = 'checked' if options[:checked]
        else
          value = nil
          obj_name = @object_name.to_s + '[' + name.to_s + ']'
          obj_id = obj_name.gsub('][', '_').gsub(']', '').gsub('[', '_')
          @object.attributes[name.to_s] ? checked = 'checked' : checked = nil
        end

        label_name = options[:label]
        data_str = options[:data]
        data_str ||= options[:data_input]

        if options[:inline]
          str_class = 'checkbox_exasat checkbox-inline'
          str_class += ' ' + options[:item_wrapper_class] if options[:item_wrapper_class]
          content_tag(:div, class: str_class) do
            content_tag(:input, '', type: 'checkbox', value: value, name: obj_name, id: obj_id)+
                label(name, label_name, value: value)
          end
        else
          str_class = 'checkbox'
          str_class += ' ' + options[:class] if options[:class]
          if value
            content_tag(:div, class: str_class) do
              content_tag(:input, '', type: 'checkbox', value: value, checked: checked, name: obj_name, id: obj_id,
                          data: data_str, disabled: options[:disabled]) +
                  label(name, label_name, value: value, data: options[:data_label])
            end
          else
            content_tag(:div, class: 'form-group') do
              content_tag(:div, class: str_class) do
                content_tag(:input, '', type: 'hidden', value: '0', name: obj_name) +
                    content_tag(:input, '', type: 'checkbox', value: '1', checked: checked, name: obj_name,
                                id: obj_id, data: data_str, disabled: options[:disabled]) +
                    label(label_name, ' ', class: 'label-single-checkbox', data: options[:data_label])
              end
            end
          end
        end
      end

      def es_collection_check_boxes(*args)
        html = inputs_collection(*args) do |name, value, options|
          options[:multiple] = true
          options[:value] = value
          options[:checked] = true if @object.send(name) and @object.send(name).include?(value)
          es_check_box(name, options)
        end
        hidden_field(args.first,{value: '', multiple: true}).concat(html)
      end

    end
  end
end