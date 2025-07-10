Return-Path: <linux-kernel+bounces-724705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1B7AFF609
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 02:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B211658262D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 00:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0806051022;
	Thu, 10 Jul 2025 00:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ofaMpMMO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D583148FE6
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 00:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752107697; cv=none; b=Eu/Y2FAH+yQc+YG6Yo5JgdU7wSE9FLjG1ARIijjYuaX+2R2e8Z/jYcoELlZ4q5ezmR6FOCvCSINgz9cit2pknQpSvnOLzxANuJlfm3UqGDKqn/gPlms31c50qaHxnVnwXsBCuL3KynMB1YZj67d52zCXFcUJTAcDOQSKg5oO90A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752107697; c=relaxed/simple;
	bh=s4Nmof7rTdITh+6kUle4dTnOGGbKHVQPxgZCLbxQbng=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ZWJssCynjmptM31QkyeG12HkaMMebvZ9mhAbmveo/jOSo3M4cuVbRrWC0rwnZgArG0wy470ajh6mUQXDVjBUHWx5tmP/+GC0avm4UawYw2x4GablErfhIzvrLMtq/MltDNvzSBIqyBBmM6U0tYWtiknWLPBI2EDzwPYZZO/Jc4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ofaMpMMO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C78D4C4CEF1;
	Thu, 10 Jul 2025 00:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752107697;
	bh=s4Nmof7rTdITh+6kUle4dTnOGGbKHVQPxgZCLbxQbng=;
	h=Date:From:To:Cc:Subject:References:From;
	b=ofaMpMMO6+vxf7OfameQ8cRfTvza8PAqXSSA3JC/NroluuEfxusnvtkRnwmPER/nZ
	 8ZAYlDlsgP2y5Wmcr/i0+gu6a/SIxUxCZdBuITCES8t7xgvAAI9STBKCZsONsAtkyy
	 iQniZkVgM2IMtBxj2On2u7HgjNJkB073xQsDHbHsgqCoGSLF0eorXXu6UxwaBgYQCc
	 63D06ERua/74LMPIUqhLUJ70T9PaPS4Z8semZErF7iuyq299UVRSq7WRakxPGZ+QFm
	 OE/b0PR+aslnZ9EjKhXL03who0ztgUZgxIX6qXgfCecwqpK9ynLcxbcTgqHb0pEpVf
	 YzZHr0kPTdknw==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uZfFd-00000001WjQ-1vnI;
	Wed, 09 Jul 2025 20:35:01 -0400
Message-ID: <20250710003501.310797033@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 09 Jul 2025 20:34:45 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Gabriele Monaco <gmonaco@redhat.com>,
 Nam Cao <namcao@linutronix.de>
Subject: [for-next][PATCH 8/9] verification/rvgen: Add support for linear temporal logic
References: <20250710003437.191509804@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Nam Cao <namcao@linutronix.de>

Add support for generating RV monitors from linear temporal logic, similar
to the generation of deterministic automaton monitors.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Gabriele Monaco <gmonaco@redhat.com>
Link: https://lore.kernel.org/f3c63b363ff9c5af3302ba2b5d92a26a98700eaf.1751634289.git.namcao@linutronix.de
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/verification/rvgen/.gitignore           |   3 +
 tools/verification/rvgen/Makefile             |   2 +
 tools/verification/rvgen/__main__.py          |   3 +-
 tools/verification/rvgen/rvgen/ltl2ba.py      | 540 ++++++++++++++++++
 tools/verification/rvgen/rvgen/ltl2k.py       | 252 ++++++++
 .../rvgen/rvgen/templates/ltl2k/main.c        | 102 ++++
 .../rvgen/rvgen/templates/ltl2k/trace.h       |  14 +
 7 files changed, 915 insertions(+), 1 deletion(-)
 create mode 100644 tools/verification/rvgen/.gitignore
 create mode 100644 tools/verification/rvgen/rvgen/ltl2ba.py
 create mode 100644 tools/verification/rvgen/rvgen/ltl2k.py
 create mode 100644 tools/verification/rvgen/rvgen/templates/ltl2k/main.c
 create mode 100644 tools/verification/rvgen/rvgen/templates/ltl2k/trace.h

diff --git a/tools/verification/rvgen/.gitignore b/tools/verification/rvgen/.gitignore
new file mode 100644
index 000000000000..1e288a076560
--- /dev/null
+++ b/tools/verification/rvgen/.gitignore
@@ -0,0 +1,3 @@
+__pycache__/
+parser.out
+parsetab.py
diff --git a/tools/verification/rvgen/Makefile b/tools/verification/rvgen/Makefile
index cca8c9ba82e8..cfc4056c1e87 100644
--- a/tools/verification/rvgen/Makefile
+++ b/tools/verification/rvgen/Makefile
@@ -21,5 +21,7 @@ install:
 	$(INSTALL) rvgen/dot2k.py -D -m 644 $(DESTDIR)$(PYLIB)/rvgen/dot2k.py
 	$(INSTALL) rvgen/container.py -D -m 644 $(DESTDIR)$(PYLIB)/rvgen/container.py
 	$(INSTALL) rvgen/generator.py -D -m 644 $(DESTDIR)$(PYLIB)/rvgen/generator.py
+	$(INSTALL) rvgen/ltl2ba.py -D -m 644 $(DESTDIR)$(PYLIB)/rvgen/ltl2ba.py
+	$(INSTALL) rvgen/ltl2k.py -D -m 644 $(DESTDIR)$(PYLIB)/rvgen/ltl2k.py
 	$(INSTALL) __main__.py -D -m 755 $(DESTDIR)$(bindir)/rvgen
 	cp -rp rvgen/templates $(DESTDIR)$(PYLIB)/rvgen/
diff --git a/tools/verification/rvgen/__main__.py b/tools/verification/rvgen/__main__.py
index 63ecf0c37034..fa6fc1f4de2f 100644
--- a/tools/verification/rvgen/__main__.py
+++ b/tools/verification/rvgen/__main__.py
@@ -12,6 +12,7 @@ if __name__ == '__main__':
     from rvgen.dot2k import dot2k
     from rvgen.generator import Monitor
     from rvgen.container import Container
+    from rvgen.ltl2k import ltl2k
     import argparse
     import sys
 
@@ -44,7 +45,7 @@ if __name__ == '__main__':
             if params.monitor_class == "da":
                 monitor = dot2k(params.spec, params.monitor_type, vars(params))
             elif params.monitor_class == "ltl":
-                raise NotImplementedError
+                monitor = ltl2k(params.spec, params.monitor_type, vars(params))
             else:
                 print("Unknown monitor class:", params.monitor_class)
                 sys.exit(1)
diff --git a/tools/verification/rvgen/rvgen/ltl2ba.py b/tools/verification/rvgen/rvgen/ltl2ba.py
new file mode 100644
index 000000000000..d11840af7f5f
--- /dev/null
+++ b/tools/verification/rvgen/rvgen/ltl2ba.py
@@ -0,0 +1,540 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Implementation based on
+# Gerth, R., Peled, D., Vardi, M.Y., Wolper, P. (1996).
+# Simple On-the-fly Automatic Verification of Linear Temporal Logic.
+# https://doi.org/10.1007/978-0-387-34892-6_1
+# With extra optimizations
+
+from ply.lex import lex
+from ply.yacc import yacc
+
+# Grammar:
+# 	ltl ::= opd | ( ltl ) | ltl binop ltl | unop ltl
+#
+# Operands (opd):
+# 	true, false, user-defined names
+#
+# Unary Operators (unop):
+#       always
+#       eventually
+#       not
+#
+# Binary Operators (binop):
+#       until
+#       and
+#       or
+#       imply
+#       equivalent
+
+tokens = (
+   'AND',
+   'OR',
+   'IMPLY',
+   'UNTIL',
+   'ALWAYS',
+   'EVENTUALLY',
+   'VARIABLE',
+   'LITERAL',
+   'NOT',
+   'LPAREN',
+   'RPAREN',
+   'ASSIGN',
+)
+
+t_AND = r'and'
+t_OR = r'or'
+t_IMPLY = r'imply'
+t_UNTIL = r'until'
+t_ALWAYS = r'always'
+t_EVENTUALLY = r'eventually'
+t_VARIABLE = r'[A-Z_0-9]+'
+t_LITERAL = r'true|false'
+t_NOT = r'not'
+t_LPAREN = r'\('
+t_RPAREN = r'\)'
+t_ASSIGN = r'='
+t_ignore_COMMENT = r'\#.*'
+t_ignore = ' \t\n'
+
+def t_error(t):
+    raise ValueError(f"Illegal character '{t.value[0]}'")
+
+lexer = lex()
+
+class GraphNode:
+    uid = 0
+
+    def __init__(self, incoming: set['GraphNode'], new, old, _next):
+        self.init = False
+        self.outgoing = set()
+        self.labels = set()
+        self.incoming = incoming.copy()
+        self.new = new.copy()
+        self.old = old.copy()
+        self.next = _next.copy()
+        self.id = GraphNode.uid
+        GraphNode.uid += 1
+
+    def expand(self, node_set):
+        if not self.new:
+            for nd in node_set:
+                if nd.old == self.old and nd.next == self.next:
+                    nd.incoming |= self.incoming
+                    return node_set
+
+            new_current_node = GraphNode({self}, self.next, set(), set())
+            return new_current_node.expand({self} | node_set)
+        n = self.new.pop()
+        return n.expand(self, node_set)
+
+    def __lt__(self, other):
+        return self.id < other.id
+
+class ASTNode:
+    uid = 1
+
+    def __init__(self, op):
+        self.op = op
+        self.id = ASTNode.uid
+        ASTNode.uid += 1
+
+    def __hash__(self):
+        return hash(self.op)
+
+    def __eq__(self, other):
+        return self is other
+
+    def __iter__(self):
+        yield self
+        yield from self.op
+
+    def negate(self):
+        self.op = self.op.negate()
+        return self
+
+    def expand(self, node, node_set):
+        return self.op.expand(self, node, node_set)
+
+    def __str__(self):
+        if isinstance(self.op, Literal):
+            return str(self.op.value)
+        if isinstance(self.op, Variable):
+            return self.op.name.lower()
+        return "val" + str(self.id)
+
+    def normalize(self):
+        # Get rid of:
+        #   - ALWAYS
+        #   - EVENTUALLY
+        #   - IMPLY
+        # And move all the NOT to be inside
+        self.op = self.op.normalize()
+        return self
+
+class BinaryOp:
+    op_str = "not_supported"
+
+    def __init__(self, left: ASTNode, right: ASTNode):
+        self.left = left
+        self.right = right
+
+    def __hash__(self):
+        return hash((self.left, self.right))
+
+    def __iter__(self):
+        yield from self.left
+        yield from self.right
+
+    def normalize(self):
+        raise NotImplementedError
+
+    def negate(self):
+        raise NotImplementedError
+
+    def _is_temporal(self):
+        raise NotImplementedError
+
+    def is_temporal(self):
+        if self.left.op.is_temporal():
+            return True
+        if self.right.op.is_temporal():
+            return True
+        return self._is_temporal()
+
+    @staticmethod
+    def expand(n: ASTNode, node: GraphNode, node_set) -> set[GraphNode]:
+        raise NotImplementedError
+
+class AndOp(BinaryOp):
+    op_str = '&&'
+
+    def normalize(self):
+        return self
+
+    def negate(self):
+        return OrOp(self.left.negate(), self.right.negate())
+
+    def _is_temporal(self):
+        return False
+
+    @staticmethod
+    def expand(n: ASTNode, node: GraphNode, node_set) -> set[GraphNode]:
+        if not n.op.is_temporal():
+            node.old.add(n)
+            return node.expand(node_set)
+
+        tmp = GraphNode(node.incoming,
+                        node.new | ({n.op.left, n.op.right} - node.old),
+                        node.old | {n},
+                        node.next)
+        return tmp.expand(node_set)
+
+class OrOp(BinaryOp):
+    op_str = '||'
+
+    def normalize(self):
+        return self
+
+    def negate(self):
+        return AndOp(self.left.negate(), self.right.negate())
+
+    def _is_temporal(self):
+        return False
+
+    @staticmethod
+    def expand(n: ASTNode, node: GraphNode, node_set) -> set[GraphNode]:
+        if not n.op.is_temporal():
+            node.old |= {n}
+            return node.expand(node_set)
+
+        node1 = GraphNode(node.incoming,
+                          node.new | ({n.op.left} - node.old),
+                          node.old | {n},
+                          node.next)
+        node2 = GraphNode(node.incoming,
+                          node.new | ({n.op.right} - node.old),
+                          node.old | {n},
+                          node.next)
+        return node2.expand(node1.expand(node_set))
+
+class UntilOp(BinaryOp):
+    def normalize(self):
+        return self
+
+    def negate(self):
+        return VOp(self.left.negate(), self.right.negate())
+
+    def _is_temporal(self):
+        return True
+
+    @staticmethod
+    def expand(n: ASTNode, node: GraphNode, node_set) -> set[GraphNode]:
+        node1 = GraphNode(node.incoming,
+                          node.new | ({n.op.left} - node.old),
+                          node.old | {n},
+                          node.next | {n})
+        node2 = GraphNode(node.incoming,
+                          node.new | ({n.op.right} - node.old),
+                          node.old | {n},
+                          node.next)
+        return node2.expand(node1.expand(node_set))
+
+class VOp(BinaryOp):
+    def normalize(self):
+        return self
+
+    def negate(self):
+        return UntilOp(self.left.negate(), self.right.negate())
+
+    def _is_temporal(self):
+        return True
+
+    @staticmethod
+    def expand(n: ASTNode, node: GraphNode, node_set) -> set[GraphNode]:
+        node1 = GraphNode(node.incoming,
+                          node.new | ({n.op.right} - node.old),
+                          node.old | {n},
+                          node.next | {n})
+        node2 = GraphNode(node.incoming,
+                          node.new | ({n.op.left, n.op.right} - node.old),
+                          node.old | {n},
+                          node.next)
+        return node2.expand(node1.expand(node_set))
+
+class ImplyOp(BinaryOp):
+    def normalize(self):
+        # P -> Q === !P | Q
+        return OrOp(self.left.negate(), self.right)
+
+    def _is_temporal(self):
+        return False
+
+    def negate(self):
+        # !(P -> Q) === !(!P | Q) === P & !Q
+        return AndOp(self.left, self.right.negate())
+
+class UnaryOp:
+    def __init__(self, child: ASTNode):
+        self.child = child
+
+    def __iter__(self):
+        yield from self.child
+
+    def __hash__(self):
+        return hash(self.child)
+
+    def normalize(self):
+        raise NotImplementedError
+
+    def _is_temporal(self):
+        raise NotImplementedError
+
+    def is_temporal(self):
+        if self.child.op.is_temporal():
+            return True
+        return self._is_temporal()
+
+    def negate(self):
+        raise NotImplementedError
+
+class EventuallyOp(UnaryOp):
+    def __str__(self):
+        return "eventually " + str(self.child)
+
+    def normalize(self):
+        # <>F == true U F
+        return UntilOp(ASTNode(Literal(True)), self.child)
+
+    def _is_temporal(self):
+        return True
+
+    def negate(self):
+        # !<>F == [](!F)
+        return AlwaysOp(self.child.negate()).normalize()
+
+class AlwaysOp(UnaryOp):
+    def normalize(self):
+        # []F === !(true U !F) == false V F
+        new = ASTNode(Literal(False))
+        return VOp(new, self.child)
+
+    def _is_temporal(self):
+        return True
+
+    def negate(self):
+        # ![]F == <>(!F)
+        return EventuallyOp(self.child.negate()).normalize()
+
+class NotOp(UnaryOp):
+    def __str__(self):
+        return "!" + str(self.child)
+
+    def normalize(self):
+        return self.child.op.negate()
+
+    def negate(self):
+        return self.child.op
+
+    def _is_temporal(self):
+        return False
+
+    @staticmethod
+    def expand(n: ASTNode, node: GraphNode, node_set) -> set[GraphNode]:
+        for f in node.old:
+            if n.op.child is f:
+                return node_set
+        node.old |= {n}
+        return node.expand(node_set)
+
+class Variable:
+    def __init__(self, name: str):
+        self.name = name
+
+    def __hash__(self):
+        return hash(self.name)
+
+    def __iter__(self):
+        yield from ()
+
+    def negate(self):
+        new = ASTNode(self)
+        return NotOp(new)
+
+    def normalize(self):
+        return self
+
+    def is_temporal(self):
+        return False
+
+    @staticmethod
+    def expand(n: ASTNode, node: GraphNode, node_set) -> set[GraphNode]:
+        for f in node.old:
+            if isinstance(f, NotOp) and f.op.child is n:
+                return node_set
+        node.old |= {n}
+        return node.expand(node_set)
+
+class Literal:
+    def __init__(self, value: bool):
+        self.value = value
+
+    def __iter__(self):
+        yield from ()
+
+    def __hash__(self):
+        return hash(self.value)
+
+    def __str__(self):
+        if self.value:
+            return "true"
+        return "false"
+
+    def negate(self):
+        self.value = not self.value
+        return self
+
+    def normalize(self):
+        return self
+
+    def is_temporal(self):
+        return False
+
+    @staticmethod
+    def expand(n: ASTNode, node: GraphNode, node_set) -> set[GraphNode]:
+        if not n.op.value:
+            return node_set
+        node.old |= {n}
+        return node.expand(node_set)
+
+def p_spec(p):
+    '''
+    spec : assign
+         | assign spec
+    '''
+    if len(p) == 3:
+        p[2].append(p[1])
+        p[0] = p[2]
+    else:
+        p[0] = [p[1]]
+
+def p_assign(p):
+    '''
+    assign : VARIABLE ASSIGN ltl
+    '''
+    p[0] = (p[1], p[3])
+
+def p_ltl(p):
+    '''
+    ltl : opd
+        | binop
+        | unop
+    '''
+    p[0] = p[1]
+
+def p_opd(p):
+    '''
+    opd : VARIABLE
+        | LITERAL
+        | LPAREN ltl RPAREN
+    '''
+    if p[1] == "true":
+        p[0] = ASTNode(Literal(True))
+    elif p[1] == "false":
+        p[0] = ASTNode(Literal(False))
+    elif p[1] == '(':
+        p[0] = p[2]
+    else:
+        p[0] = ASTNode(Variable(p[1]))
+
+def p_unop(p):
+    '''
+    unop : ALWAYS ltl
+         | EVENTUALLY ltl
+         | NOT ltl
+    '''
+    if p[1] == "always":
+        op = AlwaysOp(p[2])
+    elif p[1] == "eventually":
+        op = EventuallyOp(p[2])
+    elif p[1] == "not":
+        op = NotOp(p[2])
+    else:
+        raise ValueError(f"Invalid unary operator {p[1]}")
+
+    p[0] = ASTNode(op)
+
+def p_binop(p):
+    '''
+    binop : opd UNTIL ltl
+          | opd AND ltl
+          | opd OR ltl
+          | opd IMPLY ltl
+    '''
+    if p[2] == "and":
+        op = AndOp(p[1], p[3])
+    elif p[2] == "until":
+        op = UntilOp(p[1], p[3])
+    elif p[2] == "or":
+        op = OrOp(p[1], p[3])
+    elif p[2] == "imply":
+        op = ImplyOp(p[1], p[3])
+    else:
+        raise ValueError(f"Invalid binary operator {p[2]}")
+
+    p[0] = ASTNode(op)
+
+parser = yacc()
+
+def parse_ltl(s: str) -> ASTNode:
+    spec = parser.parse(s)
+
+    rule = None
+    subexpr = {}
+
+    for assign in spec:
+        if assign[0] == "RULE":
+            rule = assign[1]
+        else:
+            subexpr[assign[0]] = assign[1]
+
+    if rule is None:
+        raise ValueError("Please define your specification in the \"RULE = <LTL spec>\" format")
+
+    for node in rule:
+        if not isinstance(node.op, Variable):
+            continue
+        replace = subexpr.get(node.op.name)
+        if replace is not None:
+            node.op = replace.op
+
+    return rule
+
+def create_graph(s: str):
+    atoms = set()
+
+    ltl = parse_ltl(s)
+    for c in ltl:
+        c.normalize()
+        if isinstance(c.op, Variable):
+            atoms.add(c.op.name)
+
+    init = GraphNode(set(), set(), set(), set())
+    head = GraphNode({init}, {ltl}, set(), set())
+    graph = sorted(head.expand(set()))
+
+    for i, node in enumerate(graph):
+        # The id assignment during graph generation has gaps. Reassign them
+        node.id = i
+
+        for incoming in node.incoming:
+            if incoming is init:
+                node.init = True
+            else:
+                incoming.outgoing.add(node)
+        for o in node.old:
+            if not o.op.is_temporal():
+                node.labels.add(str(o))
+
+    return sorted(atoms), graph, ltl
diff --git a/tools/verification/rvgen/rvgen/ltl2k.py b/tools/verification/rvgen/rvgen/ltl2k.py
new file mode 100644
index 000000000000..92e713861d86
--- /dev/null
+++ b/tools/verification/rvgen/rvgen/ltl2k.py
@@ -0,0 +1,252 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0-only
+
+from pathlib import Path
+from . import generator
+from . import ltl2ba
+
+COLUMN_LIMIT = 100
+
+def line_len(line: str) -> int:
+    tabs = line.count('\t')
+    return tabs * 7 + len(line)
+
+def break_long_line(line: str, indent='') -> list[str]:
+    result = []
+    while line_len(line) > COLUMN_LIMIT:
+        i = line[:COLUMN_LIMIT - line_len(line)].rfind(' ')
+        result.append(line[:i])
+        line = indent + line[i + 1:]
+    if line:
+        result.append(line)
+    return result
+
+def build_condition_string(node: ltl2ba.GraphNode):
+    if not node.labels:
+        return "(true)"
+
+    result = "("
+
+    first = True
+    for label in sorted(node.labels):
+        if not first:
+            result += " && "
+        result += label
+        first = False
+
+    result += ")"
+
+    return result
+
+def abbreviate_atoms(atoms: list[str]) -> list[str]:
+    def shorten(s: str) -> str:
+        skip = ["is", "by", "or", "and"]
+        return '_'.join([x[:2] for x in s.lower().split('_') if x not in skip])
+
+    abbrs = []
+    for atom in atoms:
+        for i in range(len(atom), -1, -1):
+            if sum(a.startswith(atom[:i]) for a in atoms) > 1:
+                break
+        share = atom[:i]
+        unique = atom[i:]
+        abbrs.append((shorten(share) + shorten(unique)))
+    return abbrs
+
+class ltl2k(generator.Monitor):
+    template_dir = "ltl2k"
+
+    def __init__(self, file_path, MonitorType, extra_params={}):
+        if MonitorType != "per_task":
+            raise NotImplementedError("Only per_task monitor is supported for LTL")
+        super().__init__(extra_params)
+        with open(file_path) as f:
+            self.atoms, self.ba, self.ltl = ltl2ba.create_graph(f.read())
+        self.atoms_abbr = abbreviate_atoms(self.atoms)
+        self.name = extra_params.get("model_name")
+        if not self.name:
+            self.name = Path(file_path).stem
+
+    def _fill_states(self) -> str:
+        buf = [
+            "enum ltl_buchi_state {",
+        ]
+
+        for node in self.ba:
+            buf.append("\tS%i," % node.id)
+        buf.append("\tRV_NUM_BA_STATES")
+        buf.append("};")
+        buf.append("static_assert(RV_NUM_BA_STATES <= RV_MAX_BA_STATES);")
+        return buf
+
+    def _fill_atoms(self):
+        buf = ["enum ltl_atom {"]
+        for a in sorted(self.atoms):
+            buf.append("\tLTL_%s," % a)
+        buf.append("\tLTL_NUM_ATOM")
+        buf.append("};")
+        buf.append("static_assert(LTL_NUM_ATOM <= RV_MAX_LTL_ATOM);")
+        return buf
+
+    def _fill_atoms_to_string(self):
+        buf = [
+            "static const char *ltl_atom_str(enum ltl_atom atom)",
+            "{",
+            "\tstatic const char *const names[] = {"
+        ]
+
+        for name in self.atoms_abbr:
+            buf.append("\t\t\"%s\"," % name)
+
+        buf.extend([
+            "\t};",
+            "",
+            "\treturn names[atom];",
+            "}"
+        ])
+        return buf
+
+    def _fill_atom_values(self):
+        buf = []
+        for node in self.ltl:
+            if node.op.is_temporal():
+                continue
+
+            if isinstance(node.op, ltl2ba.Variable):
+                buf.append("\tbool %s = test_bit(LTL_%s, mon->atoms);" % (node, node.op.name))
+            elif isinstance(node.op, ltl2ba.AndOp):
+                buf.append("\tbool %s = %s && %s;" % (node, node.op.left, node.op.right))
+            elif isinstance(node.op, ltl2ba.OrOp):
+                buf.append("\tbool %s = %s || %s;" % (node, node.op.left, node.op.right))
+            elif isinstance(node.op, ltl2ba.NotOp):
+                buf.append("\tbool %s = !%s;" % (node, node.op.child))
+        buf.reverse()
+
+        buf2 = []
+        for line in buf:
+            buf2.extend(break_long_line(line, "\t     "))
+        return buf2
+
+    def _fill_transitions(self):
+        buf = [
+            "static void",
+            "ltl_possible_next_states(struct ltl_monitor *mon, unsigned int state, unsigned long *next)",
+            "{"
+        ]
+        buf.extend(self._fill_atom_values())
+        buf.extend([
+            "",
+            "\tswitch (state) {"
+        ])
+
+        for node in self.ba:
+            buf.append("\tcase S%i:" % node.id)
+
+            for o in sorted(node.outgoing):
+                line   = "\t\tif "
+                indent = "\t\t   "
+
+                line += build_condition_string(o)
+                lines = break_long_line(line, indent)
+                buf.extend(lines)
+
+                buf.append("\t\t\t__set_bit(S%i, next);" % o.id)
+            buf.append("\t\tbreak;")
+        buf.extend([
+            "\t}",
+            "}"
+        ])
+
+        return buf
+
+    def _fill_start(self):
+        buf = [
+            "static void ltl_start(struct task_struct *task, struct ltl_monitor *mon)",
+            "{"
+        ]
+        buf.extend(self._fill_atom_values())
+        buf.append("")
+
+        for node in self.ba:
+            if not node.init:
+                continue
+
+            line   = "\tif "
+            indent = "\t   "
+
+            line += build_condition_string(node)
+            lines = break_long_line(line, indent)
+            buf.extend(lines)
+
+            buf.append("\t\t__set_bit(S%i, mon->states);" % node.id)
+        buf.append("}")
+        return buf
+
+    def fill_tracepoint_handlers_skel(self):
+        buff = []
+        buff.append("static void handle_example_event(void *data, /* XXX: fill header */)")
+        buff.append("{")
+        buff.append("\tltl_atom_update(task, LTL_%s, true/false);" % self.atoms[0])
+        buff.append("}")
+        buff.append("")
+        return '\n'.join(buff)
+
+    def fill_tracepoint_attach_probe(self):
+        return "\trv_attach_trace_probe(\"%s\", /* XXX: tracepoint */, handle_example_event);" \
+                % self.name
+
+    def fill_tracepoint_detach_helper(self):
+        return "\trv_detach_trace_probe(\"%s\", /* XXX: tracepoint */, handle_sample_event);" \
+                % self.name
+
+    def fill_atoms_init(self):
+        buff = []
+        for a in self.atoms:
+            buff.append("\tltl_atom_set(mon, LTL_%s, true/false);" % a)
+        return '\n'.join(buff)
+
+    def fill_model_h(self):
+        buf = [
+            "/* SPDX-License-Identifier: GPL-2.0 */",
+            "",
+            "/*",
+            " * C implementation of Buchi automaton, automatically generated by",
+            " * tools/verification/rvgen from the linear temporal logic specification.",
+            " * For further information, see kernel documentation:",
+            " *   Documentation/trace/rv/linear_temporal_logic.rst",
+            " */",
+            "",
+            "#include <linux/rv.h>",
+            "",
+            "#define MONITOR_NAME " + self.name,
+            ""
+        ]
+
+        buf.extend(self._fill_atoms())
+        buf.append('')
+
+        buf.extend(self._fill_atoms_to_string())
+        buf.append('')
+
+        buf.extend(self._fill_states())
+        buf.append('')
+
+        buf.extend(self._fill_start())
+        buf.append('')
+
+        buf.extend(self._fill_transitions())
+        buf.append('')
+
+        return '\n'.join(buf)
+
+    def fill_monitor_class_type(self):
+        return "LTL_MON_EVENTS_ID"
+
+    def fill_monitor_class(self):
+        return "ltl_monitor_id"
+
+    def fill_main_c(self):
+        main_c = super().fill_main_c()
+        main_c = main_c.replace("%%ATOMS_INIT%%", self.fill_atoms_init())
+
+        return main_c
diff --git a/tools/verification/rvgen/rvgen/templates/ltl2k/main.c b/tools/verification/rvgen/rvgen/templates/ltl2k/main.c
new file mode 100644
index 000000000000..f85d076fbf78
--- /dev/null
+++ b/tools/verification/rvgen/rvgen/templates/ltl2k/main.c
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/ftrace.h>
+#include <linux/tracepoint.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/rv.h>
+#include <rv/instrumentation.h>
+
+#define MODULE_NAME "%%MODEL_NAME%%"
+
+/*
+ * XXX: include required tracepoint headers, e.g.,
+ * #include <trace/events/sched.h>
+ */
+#include <rv_trace.h>
+%%INCLUDE_PARENT%%
+
+/*
+ * This is the self-generated part of the monitor. Generally, there is no need
+ * to touch this section.
+ */
+#include "%%MODEL_NAME%%.h"
+#include <rv/ltl_monitor.h>
+
+static void ltl_atoms_fetch(struct task_struct *task, struct ltl_monitor *mon)
+{
+	/*
+	 * This is called everytime the Buchi automaton is triggered.
+	 *
+	 * This function could be used to fetch the atomic propositions which
+	 * are expensive to trace. It is possible only if the atomic proposition
+	 * does not need to be updated at precise time.
+	 *
+	 * It is recommended to use tracepoints and ltl_atom_update() instead.
+	 */
+}
+
+static void ltl_atoms_init(struct task_struct *task, struct ltl_monitor *mon, bool task_creation)
+{
+	/*
+	 * This should initialize as many atomic propositions as possible.
+	 *
+	 * @task_creation indicates whether the task is being created. This is
+	 * false if the task is already running before the monitor is enabled.
+	 */
+%%ATOMS_INIT%%
+}
+
+/*
+ * This is the instrumentation part of the monitor.
+ *
+ * This is the section where manual work is required. Here the kernel events
+ * are translated into model's event.
+ */
+%%TRACEPOINT_HANDLERS_SKEL%%
+static int enable_%%MODEL_NAME%%(void)
+{
+	int retval;
+
+	retval = ltl_monitor_init();
+	if (retval)
+		return retval;
+
+%%TRACEPOINT_ATTACH%%
+
+	return 0;
+}
+
+static void disable_%%MODEL_NAME%%(void)
+{
+%%TRACEPOINT_DETACH%%
+
+	ltl_monitor_destroy();
+}
+
+/*
+ * This is the monitor register section.
+ */
+static struct rv_monitor rv_%%MODEL_NAME%% = {
+	.name = "%%MODEL_NAME%%",
+	.description = "%%DESCRIPTION%%",
+	.enable = enable_%%MODEL_NAME%%,
+	.disable = disable_%%MODEL_NAME%%,
+};
+
+static int __init register_%%MODEL_NAME%%(void)
+{
+	return rv_register_monitor(&rv_%%MODEL_NAME%%, %%PARENT%%);
+}
+
+static void __exit unregister_%%MODEL_NAME%%(void)
+{
+	rv_unregister_monitor(&rv_%%MODEL_NAME%%);
+}
+
+module_init(register_%%MODEL_NAME%%);
+module_exit(unregister_%%MODEL_NAME%%);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR(/* TODO */);
+MODULE_DESCRIPTION("%%MODEL_NAME%%: %%DESCRIPTION%%");
diff --git a/tools/verification/rvgen/rvgen/templates/ltl2k/trace.h b/tools/verification/rvgen/rvgen/templates/ltl2k/trace.h
new file mode 100644
index 000000000000..49394c4b0f1c
--- /dev/null
+++ b/tools/verification/rvgen/rvgen/templates/ltl2k/trace.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Snippet to be included in rv_trace.h
+ */
+
+#ifdef CONFIG_RV_MON_%%MODEL_NAME_UP%%
+DEFINE_EVENT(event_%%MONITOR_CLASS%%, event_%%MODEL_NAME%%,
+	     TP_PROTO(struct task_struct *task, char *states, char *atoms, char *next),
+	     TP_ARGS(task, states, atoms, next));
+DEFINE_EVENT(error_%%MONITOR_CLASS%%, error_%%MODEL_NAME%%,
+	     TP_PROTO(struct task_struct *task),
+	     TP_ARGS(task));
+#endif /* CONFIG_RV_MON_%%MODEL_NAME_UP%% */
-- 
2.47.2



