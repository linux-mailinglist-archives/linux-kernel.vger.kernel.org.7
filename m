Return-Path: <linux-kernel+bounces-782127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60282B31B89
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 16:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3B7A175B8A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 14:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42160320CDB;
	Fri, 22 Aug 2025 14:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fnsg4Icm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE9B3101BD;
	Fri, 22 Aug 2025 14:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755872388; cv=none; b=QUKZemv+RFYjz6TidXlp8TQiBlPe0BJTE7Sp6RIM2MszJh+Sn1a4yLrBrOeqYaFMek4ZrTzZQucgN+NnGDWSb3GsXzpc2ZYPlrkWi/ZnZFQO52FD4SslONs9ucy4ypQuFug/jH+uXzwxLIJ1FCIfvhxH6MHaBbw5yP17oiyfipM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755872388; c=relaxed/simple;
	bh=DL+ejH7HzWPaC/HHDV1RfIxKyreXW8+q4TsBZyqpgb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hp6kFhikDSgX1D+E/xx1k+mhl7PA3dGL8sSiqYQvLmgqFekxYyHleOdtx/R1le0VOv6EWwHKT6eREu/dwBYm/+GXaBYTGB2MMMzT/h8KOGEkvn+LfCTzU8ClohjcyYffa/NzkVYdIqBH2kvI+crt7HFhedwrUgBM8I95IVTo2IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fnsg4Icm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37EECC2BCB4;
	Fri, 22 Aug 2025 14:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755872388;
	bh=DL+ejH7HzWPaC/HHDV1RfIxKyreXW8+q4TsBZyqpgb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fnsg4IcmGUBrbAcFRfBOHL+qHjRbTSrbcokUy+8FlKuPHdztZm4JyQvI4CqZNt/OF
	 fCYyI/sAxPU4jPwvZ0dcR4rlJoqXDdmvCK2PLu3Oc0fnOgl28+NWJEjqnNtH8a9unh
	 v8c+xKzT8QSod1iwCJF2BMNXi/7N1KVFkzjLTLUgihSHDnk00GWuOnOHTtWkPIe5nF
	 AxwPtre8Fv0qb5UPRiABQRxmxPCF0PUTu+LUEj6VvxEdEoUb/1SoS0ytsNXSnUK+6a
	 EKdXVDu8XtgU8HJK/FO+DmCDlHDPRxPNhhtkJMKxlFsqHviO/LqZ7BCi+ruQkYIIpY
	 sUPdCHBUun85w==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1upScM-0000000CCrh-1slL;
	Fri, 22 Aug 2025 16:19:46 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	Kees Cook <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 13/24] docs: kernel_include.py: move rawtext logic to separate functions
Date: Fri, 22 Aug 2025 16:19:25 +0200
Message-ID: <04776a94c85b6c931c198a149f08b299c9f571a3.1755872208.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755872208.git.mchehab+huawei@kernel.org>
References: <cover.1755872208.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

The run function is too complex. merge run() and _run() into
a single function and move the read logic to separate functions.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/sphinx/kernel_include.py | 82 ++++++++++++++------------
 1 file changed, 43 insertions(+), 39 deletions(-)

diff --git a/Documentation/sphinx/kernel_include.py b/Documentation/sphinx/kernel_include.py
index 0a3e5377dd1e..ef86ee9e79d6 100755
--- a/Documentation/sphinx/kernel_include.py
+++ b/Documentation/sphinx/kernel_include.py
@@ -92,7 +92,47 @@ class KernelInclude(Include):
         'exception-file': directives.unchanged,
     })
 
+    def read_rawtext(self, path, encoding):
+            """Read and process file content with error handling"""
+            try:
+                self.state.document.settings.record_dependencies.add(path)
+                include_file = io.FileInput(source_path=path,
+                                            encoding=encoding,
+                                            error_handler=self.state.document.settings.input_encoding_error_handler)
+            except UnicodeEncodeError:
+                raise self.severe('Problems with directive path:\n'
+                                'Cannot encode input file path "%s" '
+                                '(wrong locale?).' % SafeString(path))
+            except IOError as error:
+                raise self.severe('Problems with directive path:\n%s.' % ErrorString(error))
+
+            try:
+                return include_file.read()
+            except UnicodeError as error:
+                raise self.severe('Problem with directive:\n%s' % ErrorString(error))
+
+    def read_rawtext_with_xrefs(self, env, path):
+        parser = ParseDataStructs()
+        parser.parse_file(path)
+
+        if 'exception-file' in self.options:
+            source_dir = os.path.dirname(os.path.abspath(
+                self.state_machine.input_lines.source(
+                    self.lineno - self.state_machine.input_offset - 1)))
+            exceptions_file = os.path.join(source_dir, self.options['exception-file'])
+            parser.process_exceptions(exceptions_file)
+
+        if self.options.get("start-line") or self.options.get("end-line"):
+            raise self.severe('generate-cross-refs can\'t be used with "start-line" or "end-line"')
+
+        # Store references on a symbol dict to be used at check time
+        if 'warn-broken' in self.options:
+            env._xref_files.add(path)
+
+        return parser.gen_output()
+
     def run(self):
+        """Include a file as part of the content of this reST file."""
         env = self.state.document.settings.env
         path = os.path.realpath(os.path.expandvars(self.arguments[0]))
 
@@ -105,12 +145,6 @@ class KernelInclude(Include):
 
         env.note_dependency(os.path.abspath(path))
 
-        # return super(KernelInclude, self).run() # won't work, see HINTs in _run()
-        return self._run(env)
-
-    def _run(self, env):
-        """Include a file as part of the content of this reST file."""
-
         # HINT: I had to copy&paste the whole Include.run method. I'am not happy
         # with this, but due to security reasons, the Include.run method does
         # not allow absolute or relative pathnames pointing to locations *above*
@@ -139,47 +173,17 @@ class KernelInclude(Include):
 
         # Get optional arguments to related to cross-references generation
         if 'generate-cross-refs' in self.options:
-            parser = ParseDataStructs()
-            parser.parse_file(path)
-
-            exceptions_file = self.options.get('exception-file')
-            if exceptions_file:
-                exceptions_file = os.path.join(source_dir, exceptions_file)
-                parser.process_exceptions(exceptions_file)
+            rawtext = self.read_rawtext_with_xrefs(env, path)
 
             title = os.path.basename(path)
-            rawtext = parser.gen_output()
+
             if startline or endline:
                 raise self.severe('generate-cross-refs can\'t be used together with "start-line" or "end-line"')
 
             if "code" not in self.options:
                 rawtext = ".. parsed-literal::\n\n" + rawtext
-
-            # Store references on a symbol dict to be used at check time
-            if 'warn-broken' in self.options:
-                env._xref_files.add(path)
         else:
-            try:
-                self.state.document.settings.record_dependencies.add(path)
-                include_file = io.FileInput(source_path=path, encoding=encoding,
-                                            error_handler=e_handler)
-            except UnicodeEncodeError:
-                raise self.severe('Problems with "%s" directive path:\n'
-                                'Cannot encode input file path "%s" '
-                                "(wrong locale?)." % (self.name, SafeString(path)))
-            except IOError as error:
-                raise self.severe('Problems with "%s" directive path:\n%s.'
-                                % (self.name, ErrorString(error)))
-
-            try:
-                if startline or (endline is not None):
-                    lines = include_file.readlines()
-                    rawtext = "".join(lines[startline:endline])
-                else:
-                    rawtext = include_file.read()
-            except UnicodeError as error:
-                raise self.severe('Problem with "%s" directive:\n%s' %
-                                (self.name, ErrorString(error)))
+            rawtext = self.read_rawtext(path, encoding)
 
         # start-after/end-before: no restrictions on newlines in match-text,
         # and no restrictions on matching inside lines vs. line boundaries
-- 
2.50.1


