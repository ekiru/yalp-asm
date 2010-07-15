class LOST::Constant is LOST::Value;

method value ($value?) {
    self.attr('value', $value, '');
}
