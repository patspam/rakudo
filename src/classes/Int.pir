## $Id$

=head1 TITLE

Int - Perl 6 integers

=head1 SUBROUTINES

=over 4

=item onload

=cut

.namespace [ 'Int' ]

.sub 'onload' :anon :init :load
    .local pmc p6meta, intproto
    p6meta = get_hll_global ['Perl6Object'], '$!P6META'
    intproto = p6meta.'new_class'('Int', 'parent'=>'parrot;Integer Any')
    p6meta.'register'('Integer', 'parent'=>intproto, 'protoobject'=>intproto)
    p6meta.'register'('BigInt', 'parent'=>intproto, 'protoobject'=>intproto)

    $P0 = get_hll_namespace ['Int']
    '!EXPORT'('abs', 'from'=>$P0)
.end


=item Scalar

This is a value type, so just returns its dereferenced self.

=cut

.sub 'Scalar' :method
    .return (self)
.end


.sub 'abs' :method :multi('Integer')
    $P0 = abs self
    .return ($P0)
.end


=item ACCEPTS()

=cut

.sub 'ACCEPTS' :method
    .param num topic
    .tailcall 'infix:=='(topic, self)
.end



=item perl()

Returns a Perl representation of the Int.

=cut

.sub 'perl' :method
    $S0 = self
    .return($S0)
.end


=item succ and pred

Increment and Decrement Methods

=cut

.sub 'pred' :method
    $N0 = self
    dec $N0
    .tailcall '!upgrade_to_num_if_needed'($N0)
.end

.sub 'succ' :method
    $N0 = self
    inc $N0
    .tailcall '!upgrade_to_num_if_needed'($N0)
.end


=item WHICH()

Returns the identify value.

=cut

.sub 'WHICH' :method
    $I0 = self
    .return ($I0)
.end


=item infix:===

Overridden for Int.

=cut

.namespace []
.sub 'infix:===' :multi(Integer,Integer)
    .param int a
    .param int b
    .tailcall 'infix:=='(a, b)
.end

=back

=cut

# Local Variables:
#   mode: pir
#   fill-column: 100
# End:
# vim: expandtab shiftwidth=4 ft=pir:
