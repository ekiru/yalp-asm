class LOST::Register is LOST::Value;

method number ($value?) {
    self.attr('number', $value, '');
}
