Return-Path: <linux-kernel+bounces-825743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F53B8CB55
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 17:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E13874610D4
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 15:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756042FB975;
	Sat, 20 Sep 2025 15:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z63LQ3N7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9579B46B5;
	Sat, 20 Sep 2025 15:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758381737; cv=none; b=tBBzJfeW6nE3Kk2/yBBF2oi0kBcWvKQnFk+R6sosjdjpGFaZfYvv9TEK8ScJY7S0LZoQ4W7WMMkxL54hcj5nXmYFHQ/MMMxsU9u6W1ZIRNit7zJ/hwEDchdo5s6GmHckcFY8ck9yu3x+tyWmBnCy4iupPJjSsxsx9eytR/D2duU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758381737; c=relaxed/simple;
	bh=y/05L68HFhCOdUFay00Is5k7QAARtGz8H6f7Wjc5d0A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bY4jUnOqpIRCAnBtFYEA7tCS3g8gaGQpqbJnolQW3ahNIgSxqxxOlzcg0GCK+7IwKytykIlFDoPa7e6tLCwkTMu7JtoUdTVY5b4bxI0D142DBc8lNm6tI4elsaAwfT0PzaRVSSz26VNvz7y4fjBYDgtgbrYNcFM1F31dqcVR48w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z63LQ3N7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2A8FC4CEEB;
	Sat, 20 Sep 2025 15:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758381737;
	bh=y/05L68HFhCOdUFay00Is5k7QAARtGz8H6f7Wjc5d0A=;
	h=From:To:Cc:Subject:Date:From;
	b=Z63LQ3N7sarjtILGsqWAAL8g6tlVDm5UozVdPE5jJfFeho9gw0hAGI/MkcUwDieVk
	 PNEG1rcp+rE3mXHKIWl4V9LoOrn2mRY1iNo/gtJ/Q5ousbPOWMrUH2JNWdM0mHRUCj
	 Qa48O9qcHOhZT9QiZmvFefDvvjXXy6lxyQfswgHbxaH+GO97JomAXSbOLhcfub/P68
	 QyEFNW58RYxutkccekHcCu4i90aXCL2dR3ebKQGNCivYJA15gKZCBOVFdob0QCAjnC
	 G8OsDIhkoVSLuh+mL8gSlp1gbux+a9CWJmv2GN9SooZuiNcVDHVecqv6GtkAFvNW/p
	 P3kdJORcIBYiQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uzzPi-00000004iMX-3SC8;
	Sat, 20 Sep 2025 17:22:14 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Jonathan Corbet" <corbet@lwn.net>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	Kees Cook <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] docs: remove cdomain.py
Date: Sat, 20 Sep 2025 17:22:09 +0200
Message-ID: <3b86d236c64af17924e4cfedbbfb8bc60059802f.1758381727.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

This is not used anymore, as it was a logic we had to support
pre Sphinx 3.x, as shown at:

    afde706afde2 ("Make the docs build "work" with Sphinx 3.x")

Remove it.

Fixes: b26717852db7 ("docs: conf.py: drop backward support for old Sphinx versions")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/sphinx/cdomain.py | 247 --------------------------------
 1 file changed, 247 deletions(-)
 delete mode 100644 Documentation/sphinx/cdomain.py

diff --git a/Documentation/sphinx/cdomain.py b/Documentation/sphinx/cdomain.py
deleted file mode 100644
index 3dc285dc70f5..000000000000
--- a/Documentation/sphinx/cdomain.py
+++ /dev/null
@@ -1,247 +0,0 @@
-# -*- coding: utf-8; mode: python -*-
-# SPDX-License-Identifier: GPL-2.0
-# pylint: disable=W0141,C0113,C0103,C0325
-"""
-    cdomain
-    ~~~~~~~
-
-    Replacement for the sphinx c-domain.
-
-    :copyright:  Copyright (C) 2016  Markus Heiser
-    :license:    GPL Version 2, June 1991 see Linux/COPYING for details.
-
-    List of customizations:
-
-    * Moved the *duplicate C object description* warnings for function
-      declarations in the nitpicky mode. See Sphinx documentation for
-      the config values for ``nitpick`` and ``nitpick_ignore``.
-
-    * Add option 'name' to the "c:function:" directive.  With option 'name' the
-      ref-name of a function can be modified. E.g.::
-
-          .. c:function:: int ioctl( int fd, int request )
-             :name: VIDIOC_LOG_STATUS
-
-      The func-name (e.g. ioctl) remains in the output but the ref-name changed
-      from 'ioctl' to 'VIDIOC_LOG_STATUS'. The function is referenced by::
-
-          * :c:func:`VIDIOC_LOG_STATUS` or
-          * :any:`VIDIOC_LOG_STATUS` (``:any:`` needs sphinx 1.3)
-
-     * Handle signatures of function-like macros well. Don't try to deduce
-       arguments types of function-like macros.
-
-"""
-
-from docutils import nodes
-from docutils.parsers.rst import directives
-
-import sphinx
-from sphinx import addnodes
-from sphinx.domains.c import c_funcptr_sig_re, c_sig_re
-from sphinx.domains.c import CObject as Base_CObject
-from sphinx.domains.c import CDomain as Base_CDomain
-from itertools import chain
-import re
-
-__version__  = '1.1'
-
-# Namespace to be prepended to the full name
-namespace = None
-
-#
-# Handle trivial newer c domain tags that are part of Sphinx 3.1 c domain tags
-# - Store the namespace if ".. c:namespace::" tag is found
-#
-RE_namespace = re.compile(r'^\s*..\s*c:namespace::\s*(\S+)\s*$')
-
-def markup_namespace(match):
-    global namespace
-
-    namespace = match.group(1)
-
-    return ""
-
-#
-# Handle c:macro for function-style declaration
-#
-RE_macro = re.compile(r'^\s*..\s*c:macro::\s*(\S+)\s+(\S.*)\s*$')
-def markup_macro(match):
-    return ".. c:function:: " + match.group(1) + ' ' + match.group(2)
-
-#
-# Handle newer c domain tags that are evaluated as .. c:type: for
-# backward-compatibility with Sphinx < 3.0
-#
-RE_ctype = re.compile(r'^\s*..\s*c:(struct|union|enum|enumerator|alias)::\s*(.*)$')
-
-def markup_ctype(match):
-    return ".. c:type:: " + match.group(2)
-
-#
-# Handle newer c domain tags that are evaluated as :c:type: for
-# backward-compatibility with Sphinx < 3.0
-#
-RE_ctype_refs = re.compile(r':c:(var|struct|union|enum|enumerator)::`([^\`]+)`')
-def markup_ctype_refs(match):
-    return ":c:type:`" + match.group(2) + '`'
-
-#
-# Simply convert :c:expr: and :c:texpr: into a literal block.
-#
-RE_expr = re.compile(r':c:(expr|texpr):`([^\`]+)`')
-def markup_c_expr(match):
-    return '\\ ``' + match.group(2) + '``\\ '
-
-#
-# Parse Sphinx 3.x C markups, replacing them by backward-compatible ones
-#
-def c_markups(app, docname, source):
-    result = ""
-    markup_func = {
-        RE_namespace: markup_namespace,
-        RE_expr: markup_c_expr,
-        RE_macro: markup_macro,
-        RE_ctype: markup_ctype,
-        RE_ctype_refs: markup_ctype_refs,
-    }
-
-    lines = iter(source[0].splitlines(True))
-    for n in lines:
-        match_iterators = [regex.finditer(n) for regex in markup_func]
-        matches = sorted(chain(*match_iterators), key=lambda m: m.start())
-        for m in matches:
-            n = n[:m.start()] + markup_func[m.re](m) + n[m.end():]
-
-        result = result + n
-
-    source[0] = result
-
-#
-# Now implements support for the cdomain namespacing logic
-#
-
-def setup(app):
-
-    # Handle easy Sphinx 3.1+ simple new tags: :c:expr and .. c:namespace::
-    app.connect('source-read', c_markups)
-    app.add_domain(CDomain, override=True)
-
-    return dict(
-        version = __version__,
-        parallel_read_safe = True,
-        parallel_write_safe = True
-    )
-
-class CObject(Base_CObject):
-
-    """
-    Description of a C language object.
-    """
-    option_spec = {
-        "name" : directives.unchanged
-    }
-
-    def handle_func_like_macro(self, sig, signode):
-        """Handles signatures of function-like macros.
-
-        If the objtype is 'function' and the signature ``sig`` is a
-        function-like macro, the name of the macro is returned. Otherwise
-        ``False`` is returned.  """
-
-        global namespace
-
-        if not self.objtype == 'function':
-            return False
-
-        m = c_funcptr_sig_re.match(sig)
-        if m is None:
-            m = c_sig_re.match(sig)
-            if m is None:
-                raise ValueError('no match')
-
-        rettype, fullname, arglist, _const = m.groups()
-        arglist = arglist.strip()
-        if rettype or not arglist:
-            return False
-
-        arglist = arglist.replace('`', '').replace('\\ ', '') # remove markup
-        arglist = [a.strip() for a in arglist.split(",")]
-
-        # has the first argument a type?
-        if len(arglist[0].split(" ")) > 1:
-            return False
-
-        # This is a function-like macro, its arguments are typeless!
-        signode  += addnodes.desc_name(fullname, fullname)
-        paramlist = addnodes.desc_parameterlist()
-        signode  += paramlist
-
-        for argname in arglist:
-            param = addnodes.desc_parameter('', '', noemph=True)
-            # separate by non-breaking space in the output
-            param += nodes.emphasis(argname, argname)
-            paramlist += param
-
-        if namespace:
-            fullname = namespace + "." + fullname
-
-        return fullname
-
-    def handle_signature(self, sig, signode):
-        """Transform a C signature into RST nodes."""
-
-        global namespace
-
-        fullname = self.handle_func_like_macro(sig, signode)
-        if not fullname:
-            fullname = super(CObject, self).handle_signature(sig, signode)
-
-        if "name" in self.options:
-            if self.objtype == 'function':
-                fullname = self.options["name"]
-            else:
-                # FIXME: handle :name: value of other declaration types?
-                pass
-        else:
-            if namespace:
-                fullname = namespace + "." + fullname
-
-        return fullname
-
-    def add_target_and_index(self, name, sig, signode):
-        # for C API items we add a prefix since names are usually not qualified
-        # by a module name and so easily clash with e.g. section titles
-        targetname = 'c.' + name
-        if targetname not in self.state.document.ids:
-            signode['names'].append(targetname)
-            signode['ids'].append(targetname)
-            signode['first'] = (not self.names)
-            self.state.document.note_explicit_target(signode)
-            inv = self.env.domaindata['c']['objects']
-            if (name in inv and self.env.config.nitpicky):
-                if self.objtype == 'function':
-                    if ('c:func', name) not in self.env.config.nitpick_ignore:
-                        self.state_machine.reporter.warning(
-                            'duplicate C object description of %s, ' % name +
-                            'other instance in ' + self.env.doc2path(inv[name][0]),
-                            line=self.lineno)
-            inv[name] = (self.env.docname, self.objtype)
-
-        indextext = self.get_index_text(name)
-        if indextext:
-            self.indexnode['entries'].append(
-                    ('single', indextext, targetname, '', None))
-
-class CDomain(Base_CDomain):
-
-    """C language domain."""
-    name = 'c'
-    label = 'C'
-    directives = {
-        'function': CObject,
-        'member':   CObject,
-        'macro':    CObject,
-        'type':     CObject,
-        'var':      CObject,
-    }
-- 
2.51.0


