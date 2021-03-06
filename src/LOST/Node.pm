class LOST::Node is Capture;

method new (*@children, *%attrs) {
    my $self := pir::new__PP(self.HOW.get_parrotclass(self));
    $self.push(|@children);
    for %attrs -> $pair {
        $self{$pair.key} := $pair.value;
    }
    $self;
}

method attr ($name, $value?, $default?) {
    if (pir::defined__IP($value)) {
        self{$name} := $value;
    } else {
        pir::defined__IP(self{$name}) ?? self{$name} !! $default;
    }
}

method name ($value?) {
    self.attr('name', $value, '');
}

method push (*@values) {
    for @values -> $v {
        pir::push(self, $v);
    }
}
