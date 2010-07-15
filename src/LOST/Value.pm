class LOST::Value is LOST::Node;

method type ($value?) {
    self.attr('type', $value, '');
}
