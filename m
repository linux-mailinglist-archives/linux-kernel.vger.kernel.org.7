Return-Path: <linux-kernel+bounces-782132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D95ACB31B9E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 16:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1164FB40E3A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 14:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104DC326D75;
	Fri, 22 Aug 2025 14:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lu/d3ZW4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7876311C21;
	Fri, 22 Aug 2025 14:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755872388; cv=none; b=oiJKpzPlrIb0pMWNKCY/FiRKqnajV4GYNfPID0A4VF69YCW6sKbgjgj1NjzNPHO3efQvOdB3xHowM/RT9Gre/J2v1w21Op0TsyIDGnOPy3VQ17iiArIPJ6qTW1/KDXW3dp7WZ3BrZdtp1tLrgPBiYN7QoauBLgK4yTabf0WHtCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755872388; c=relaxed/simple;
	bh=UW2xelo4TnzX16OxyxtwPo8LfwSKWCjViRI3KVdm6R4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DnAT5ufSU6x8p1hWBm/O60KHY2As637uzYyefY4moSoGK5xjILQusSZT4GgdHkoYt6vHaERC3xlPDkmR0ayuZPimdUuIRK5id4uPj0VsXzZpJKX1J1U7L6XTJkIihRnP1LQ6ODAsEiG/aQMrPfA2L/k/4lE2drZxviOS9jweWz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lu/d3ZW4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35F26C2BCB3;
	Fri, 22 Aug 2025 14:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755872388;
	bh=UW2xelo4TnzX16OxyxtwPo8LfwSKWCjViRI3KVdm6R4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lu/d3ZW4YxqP5K5h0db1aASen4oTPyXhAKssWGNSB9hYF0X2zKftJAbYuzdLI/QL7
	 qCrE7p9Ccl+MKlWAgZ0ZmknLKlGe7uEkzgdmyJrEjUvLreh3b+w7I7jEH7dV0L5XpO
	 YgAReR7HZlGPgBidfp00g03da5IGsEEWe5TBmnCsKafU5T3+ybpmOnTBGJRfFhtmba
	 lTUnMfwLhq882ezmYeqocAW8rGIsUb0eWSpeIo2e3m062DCEySs0vVm/O3oleoa5yM
	 +GVxGk8YOWSJ3wTsHIGrMuau5kAtceiIHcii9W07rWhEdJUJf5tvrtW6gWTDAvLULK
	 wQiNly3ci8XkA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1upScM-0000000CCrd-1m7g;
	Fri, 22 Aug 2025 16:19:46 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	Kees Cook <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 12/24] docs: kernel_include.py: generate warnings for broken refs
Date: Fri, 22 Aug 2025 16:19:24 +0200
Message-ID: <73be9a198746421687e2eee916ccf8bf67980b7d.1755872208.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755872208.git.mchehab+huawei@kernel.org>
References: <cover.1755872208.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

In the past, Sphinx used to warn about broken references. That's
basically the rationale for adding media uAPI files: to get
warnings about missed symbols.

This is not true anymore. So, we need to explicitly check them
after doctree-resolved event.

While here, move setup() to the end, to make it closer to
what we do on other extensions.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/sphinx/kernel_include.py | 108 ++++++++++++++++++++-----
 1 file changed, 89 insertions(+), 19 deletions(-)

diff --git a/Documentation/sphinx/kernel_include.py b/Documentation/sphinx/kernel_include.py
index fc37e6fa9d96..0a3e5377dd1e 100755
--- a/Documentation/sphinx/kernel_include.py
+++ b/Documentation/sphinx/kernel_include.py
@@ -26,7 +26,7 @@
     environment variable name. Malformed variable names and references to
     non-existing variables are left unchanged.
 
-    This extension overrides Sphinx include directory, adding two extra
+    This extension overrides Sphinx include directory, adding some extra
     arguments:
 
     1. :generate-cross-refs:
@@ -35,14 +35,20 @@
         class, which converts C data structures into cross-references to
         be linked to ReST files containing a more comprehensive documentation;
 
-        Don't use it together with :start-line: and/or :end-line:, as
-        filtering input file line range is currently not supported.
-
     2. :exception-file:
 
-        Used together with :generate-cross-refs:. Points to a file containing
-        rules to ignore C data structs or to use a different reference name,
-        optionally using a different reference type.
+        Used together with :generate-cross-refs
+
+        Points to a file containing rules to ignore C data structs or to
+        use a different reference name, optionally using a different
+        reference type.
+
+    3. :warn-broken:
+
+        Used together with :generate-cross-refs:
+
+        Detect if the auto-generated cross references doesn't exist.
+
 """
 
 # ==============================================================================
@@ -50,6 +56,7 @@
 # ==============================================================================
 
 import os.path
+import re
 import sys
 
 from docutils import io, nodes, statemachine
@@ -58,23 +65,18 @@ from docutils.parsers.rst import directives
 from docutils.parsers.rst.directives.body import CodeBlock, NumberLines
 from docutils.parsers.rst.directives.misc import Include
 
+from sphinx.util import logging
+
 srctree = os.path.abspath(os.environ["srctree"])
 sys.path.insert(0, os.path.join(srctree, "tools/docs/lib"))
 
 from parse_data_structs import ParseDataStructs
 
 __version__ = "1.0"
+logger = logging.getLogger(__name__)
 
-
-# ==============================================================================
-def setup(app):
-    """Setup Sphinx exension"""
-    app.add_directive("kernel-include", KernelInclude)
-    return {
-        "version": __version__,
-        "parallel_read_safe": True,
-        "parallel_write_safe": True,
-    }
+RE_DOMAIN_REF = re.compile(r'\\ :(ref|c:type|c:func):`([^<`]+)(?:<([^>]+)>)?`\\')
+RE_SIMPLE_REF = re.compile(r'`([^`]+)`')
 
 
 # ==============================================================================
@@ -86,6 +88,7 @@ class KernelInclude(Include):
 
     option_spec.update({
         'generate-cross-refs': directives.flag,
+        'warn-broken': directives.flag,
         'exception-file': directives.unchanged,
     })
 
@@ -103,9 +106,9 @@ class KernelInclude(Include):
         env.note_dependency(os.path.abspath(path))
 
         # return super(KernelInclude, self).run() # won't work, see HINTs in _run()
-        return self._run()
+        return self._run(env)
 
-    def _run(self):
+    def _run(self, env):
         """Include a file as part of the content of this reST file."""
 
         # HINT: I had to copy&paste the whole Include.run method. I'am not happy
@@ -151,6 +154,10 @@ class KernelInclude(Include):
 
             if "code" not in self.options:
                 rawtext = ".. parsed-literal::\n\n" + rawtext
+
+            # Store references on a symbol dict to be used at check time
+            if 'warn-broken' in self.options:
+                env._xref_files.add(path)
         else:
             try:
                 self.state.document.settings.record_dependencies.add(path)
@@ -239,3 +246,66 @@ class KernelInclude(Include):
             return codeblock.run()
         self.state_machine.insert_input(include_lines, path)
         return []
+
+# ==============================================================================
+
+reported = set()
+
+def check_missing_refs(app, env, node, contnode):
+    """Check broken refs for the files it creates xrefs"""
+    if not node.source:
+        return None
+
+    try:
+        xref_files = env._xref_files
+    except AttributeError:
+        logger.critical("FATAL: _xref_files not initialized!")
+        raise
+
+    # Only show missing references for kernel-include reference-parsed files
+    if node.source not in xref_files:
+        return None
+
+    target = node.get('reftarget', '')
+    domain = node.get('refdomain', 'std')
+    reftype = node.get('reftype', '')
+
+    msg = f"can't link to: {domain}:{reftype}:: {target}"
+
+    # Don't duplicate warnings
+    data = (node.source, msg)
+    if data in reported:
+        return None
+    reported.add(data)
+
+    logger.warning(msg, location=node, type='ref', subtype='missing')
+
+    return None
+
+def merge_xref_info(app, env, docnames, other):
+    """
+    As each process modify env._xref_files, we need to merge them back.
+    """
+    if not hasattr(other, "_xref_files"):
+        return
+    env._xref_files.update(getattr(other, "_xref_files", set()))
+
+def init_xref_docs(app, env, docnames):
+    """Initialize a list of files that we're generating cross references¨"""
+    app.env._xref_files = set()
+
+# ==============================================================================
+
+def setup(app):
+    """Setup Sphinx exension"""
+
+    app.connect("env-before-read-docs", init_xref_docs)
+    app.connect("env-merge-info", merge_xref_info)
+    app.add_directive("kernel-include", KernelInclude)
+    app.connect("missing-reference", check_missing_refs)
+
+    return {
+        "version": __version__,
+        "parallel_read_safe": True,
+        "parallel_write_safe": True,
+    }
-- 
2.50.1


