Return-Path: <linux-kernel+bounces-818585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E354B5939A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 12:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97FBE7B05A8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 10:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDFC730DECC;
	Tue, 16 Sep 2025 10:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uMzy4O0L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AFD306D4A;
	Tue, 16 Sep 2025 10:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758018219; cv=none; b=jp/BIBf0UzT/3t9kBxHfyA7vz/c1/n2Oeb+vE0MTmYqQxxOOYIkJZ0IRsTIPLBYMB4UCJVtpObCLMtBViJ+9lKHKHXHkXqKHyH33sUIDFAKlCmJSfYVomG77NWCC5nk3DHRTFnV9b6xDjJr7Se6rVBpHiQhTiWOi/lr/4Cq5t/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758018219; c=relaxed/simple;
	bh=EC9zNFD3K6ZCtBCNddP12wyzv5HLm4GWdUQophs5958=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bh/RPxpfBMfjjZ9fQGiRKWVUMk+t+QqUhSeUFL16ZMcw2KfHZTIPGG6O+IKjPhdxbY7//gAagzlfy1WTf7aSF7O6huOkZ7eyrs6BTJ7wmvAhLkG5x9AC6rQqHQLMOiHDYXMdoMSA5UsUcN+Wm0fXFSWvA117/bWJ2+jgU8XJZ/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uMzy4O0L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 428FEC4CEFA;
	Tue, 16 Sep 2025 10:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758018218;
	bh=EC9zNFD3K6ZCtBCNddP12wyzv5HLm4GWdUQophs5958=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uMzy4O0L1yVPLdu4MquivMGtSoHcfvz023aW8ayZU9hkIYtlXEy+P79pxmztDnXHq
	 lNhyAxmkMD5OrF2hmx890yhuVMQN2Psq1bIQD342ZMQ90Q620zmDf2s9wU7IQ5gtKy
	 cdOZEMLU/8W9snPsQgWfXfYnte9zYMWIJKKOBzdrzNuC9i8owCxctygLfo226Tx1t/
	 fRKINUUsCuW07LTYLkofJLobZSD2huZ6Z6BCVxI8fiM0Zemutis8oEuAQ7VAGDUhDg
	 698IndreeaY5+4rSYhRyn7VibGk6AQ8U8Mops0D7IQIqup67zYhUysErtqJy5XwjaZ
	 Vjg6a7qW9bXUg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uySqT-0000000BBPv-0qyv;
	Tue, 16 Sep 2025 12:23:33 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 18/21] tools: kernel-doc: add a see also section at man pages
Date: Tue, 16 Sep 2025 12:22:54 +0200
Message-ID: <057a16ff473f2f91267b5969f66d6618f2562221.1758018030.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758018030.git.mchehab+huawei@kernel.org>
References: <cover.1758018030.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

While cross-references are complex, as related ones can be on
different files, we can at least correlate the ones that belong
to the same file, adding a SEE ALSO section for them.

The result is not bad. See for instance:

	$ tools/docs/sphinx-build-wrapper --sphinxdirs driver-api/media -- mandocs
	$ man Documentation/output/driver-api/man/edac_pci_add_device.9

	edac_pci_add_device(9)  Kernel Hacker's Manual  edac_pci_add_device(9)

	NAME
	       edac_pci_add_device  - Insert the 'edac_dev' structure into the
	       edac_pci global list and create sysfs entries  associated  with
	       edac_pci structure.

	SYNOPSIS
	       int  edac_pci_add_device  (struct  edac_pci_ctl_info *pci , int
	       edac_idx );

	ARGUMENTS
	       pci         pointer to the edac_device structure to be added to
	                   the list

	       edac_idx    A unique numeric identifier to be assigned to the

	RETURN
	       0 on Success, or an error code on failure

	SEE ALSO
	       edac_pci_alloc_ctl_info(9),          edac_pci_free_ctl_info(9),
	       edac_pci_alloc_index(9),  edac_pci_del_device(9), edac_pci_cre\u2010
	       ate_generic_ctl(9),            edac_pci_release_generic_ctl(9),
	       edac_pci_create_sysfs(9), edac_pci_remove_sysfs(9)

	August 2025               edac_pci_add_device   edac_pci_add_device(9)

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/lib/kdoc/kdoc_files.py  |  5 +-
 scripts/lib/kdoc/kdoc_output.py | 84 +++++++++++++++++++++++++++++++--
 2 files changed, 83 insertions(+), 6 deletions(-)

diff --git a/scripts/lib/kdoc/kdoc_files.py b/scripts/lib/kdoc/kdoc_files.py
index 9e09b45b02fa..061c033f32da 100644
--- a/scripts/lib/kdoc/kdoc_files.py
+++ b/scripts/lib/kdoc/kdoc_files.py
@@ -275,7 +275,10 @@ class KernelFiles():
                 self.config.log.warning("No kernel-doc for file %s", fname)
                 continue
 
-            for arg in self.results[fname]:
+            symbols = self.results[fname]
+            self.out_style.set_symbols(symbols)
+
+            for arg in symbols:
                 m = self.out_msg(fname, arg.name, arg)
 
                 if m is None:
diff --git a/scripts/lib/kdoc/kdoc_output.py b/scripts/lib/kdoc/kdoc_output.py
index ea8914537ba0..1eca9a918558 100644
--- a/scripts/lib/kdoc/kdoc_output.py
+++ b/scripts/lib/kdoc/kdoc_output.py
@@ -215,6 +215,9 @@ class OutputFormat:
 
     # Virtual methods to be overridden by inherited classes
     # At the base class, those do nothing.
+    def set_symbols(self, symbols):
+        """Get a list of all symbols from kernel_doc"""
+
     def out_doc(self, fname, name, args):
         """Outputs a DOC block"""
 
@@ -577,6 +580,7 @@ class ManFormat(OutputFormat):
 
         super().__init__()
         self.modulename = modulename
+        self.symbols = []
 
         dt = None
         tstamp = os.environ.get("KBUILD_BUILD_TIMESTAMP")
@@ -593,6 +597,68 @@ class ManFormat(OutputFormat):
 
         self.man_date = dt.strftime("%B %Y")
 
+    def arg_name(self, args, name):
+        """
+        Return the name that will be used for the man page.
+
+        As we may have the same name on different namespaces,
+        prepend the data type for all types except functions and typedefs.
+
+        The doc section is special: it uses the modulename.
+        """
+
+        dtype = args.type
+
+        if dtype == "doc":
+            return self.modulename
+
+        if dtype in ["function", "typedef"]:
+            return name
+
+        return f"{dtype} {name}"
+
+    def set_symbols(self, symbols):
+        """
+        Get a list of all symbols from kernel_doc.
+
+        Man pages will uses it to add a SEE ALSO section with other
+        symbols at the same file.
+        """
+        self.symbols = symbols
+
+    def out_tail(self, fname, name, args):
+        """Adds a tail for all man pages"""
+
+        # SEE ALSO section
+        if len(self.symbols) >= 2:
+            cur_name = self.arg_name(args, name)
+
+            self.data += f'.SH "SEE ALSO"' + "\n.PP\n"
+            related = []
+            for arg in self.symbols:
+                out_name = self.arg_name(arg, arg.name)
+
+                if cur_name == out_name:
+                    continue
+
+                related.append(f"\\fB{out_name}\\fR(9)")
+
+            self.data += ",\n".join(related) + "\n"
+
+        # TODO: does it make sense to add other sections? Maybe
+        # REPORTING ISSUES? LICENSE?
+
+    def msg(self, fname, name, args):
+        """
+        Handles a single entry from kernel-doc parser.
+
+        Add a tail at the end of man pages output.
+        """
+        super().msg(fname, name, args)
+        self.out_tail(fname, name, args)
+
+        return self.data
+
     def output_highlight(self, block):
         """
         Outputs a C symbol that may require being highlighted with
@@ -618,7 +684,9 @@ class ManFormat(OutputFormat):
         if not self.check_doc(name, args):
             return
 
-        self.data += f'.TH "{self.modulename}" 9 "{self.modulename}" "{self.man_date}" "API Manual" LINUX' + "\n"
+        out_name = self.arg_name(args, name)
+
+        self.data += f'.TH "{self.modulename}" 9 "{out_name}" "{self.man_date}" "API Manual" LINUX' + "\n"
 
         for section, text in args.sections.items():
             self.data += f'.SH "{section}"' + "\n"
@@ -627,7 +695,9 @@ class ManFormat(OutputFormat):
     def out_function(self, fname, name, args):
         """output function in man"""
 
-        self.data += f'.TH "{name}" 9 "{name}" "{self.man_date}" "Kernel Hacker\'s Manual" LINUX' + "\n"
+        out_name = self.arg_name(args, name)
+
+        self.data += f'.TH "{name}" 9 "{out_name}" "{self.man_date}" "Kernel Hacker\'s Manual" LINUX' + "\n"
 
         self.data += ".SH NAME\n"
         self.data += f"{name} \\- {args['purpose']}\n"
@@ -671,7 +741,9 @@ class ManFormat(OutputFormat):
             self.output_highlight(text)
 
     def out_enum(self, fname, name, args):
-        self.data += f'.TH "{self.modulename}" 9 "enum {name}" "{self.man_date}" "API Manual" LINUX' + "\n"
+        out_name = self.arg_name(args, name)
+
+        self.data += f'.TH "{self.modulename}" 9 "{out_name}" "{self.man_date}" "API Manual" LINUX' + "\n"
 
         self.data += ".SH NAME\n"
         self.data += f"enum {name} \\- {args['purpose']}\n"
@@ -703,8 +775,9 @@ class ManFormat(OutputFormat):
     def out_typedef(self, fname, name, args):
         module = self.modulename
         purpose = args.get('purpose')
+        out_name = self.arg_name(args, name)
 
-        self.data += f'.TH "{module}" 9 "{name}" "{self.man_date}" "API Manual" LINUX' + "\n"
+        self.data += f'.TH "{module}" 9 "{out_name}" "{self.man_date}" "API Manual" LINUX' + "\n"
 
         self.data += ".SH NAME\n"
         self.data += f"typedef {name} \\- {purpose}\n"
@@ -717,8 +790,9 @@ class ManFormat(OutputFormat):
         module = self.modulename
         purpose = args.get('purpose')
         definition = args.get('definition')
+        out_name = self.arg_name(args, name)
 
-        self.data += f'.TH "{module}" 9 "{args.type} {name}" "{self.man_date}" "API Manual" LINUX' + "\n"
+        self.data += f'.TH "{module}" 9 "{out_name}" "{self.man_date}" "API Manual" LINUX' + "\n"
 
         self.data += ".SH NAME\n"
         self.data += f"{args.type} {name} \\- {purpose}\n"
-- 
2.51.0


