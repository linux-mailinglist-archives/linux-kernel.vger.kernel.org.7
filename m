Return-Path: <linux-kernel+bounces-794957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38990B3EB45
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 17:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B0F61B22A29
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 15:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5832C341ACF;
	Mon,  1 Sep 2025 15:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MIU2oK7F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DF92DF148;
	Mon,  1 Sep 2025 15:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756740838; cv=none; b=FaR0FWYc/v4uXn93TDrmsj8yX+sHgKEZfEWIuExj0TiokbThb9fxA8NG+jE+0JyODJ3OQWCrl0RJ9gAqp6QTHJP2fCx7UeNjc6bK8edRzKAroWax30z/t6h7DnMT4myVGv6omG9dPznxFInseum2vp4NgXFK4ZLbvNPMPrBZ/5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756740838; c=relaxed/simple;
	bh=1FRpUhH3DzXvOpNlH048jo5QLbWCpi5DkMX7KuwIFPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QnzwgtAblN17pmd4viG2PsDDmeCxkq2Rq5pvUidjw3KNfH2FAz+xBGhUGWmI1kxchXw3QnR1hbyKrozAJtpVUccZ363fUcgfnq78pSLL9GBh842MLPPdX7o84H4C2nt/O5de2MXLZ+/Iznxp5Y170pwnDn7fYtMDVCJpr4Hq0VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MIU2oK7F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FCA3C4AF09;
	Mon,  1 Sep 2025 15:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756740837;
	bh=1FRpUhH3DzXvOpNlH048jo5QLbWCpi5DkMX7KuwIFPs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MIU2oK7FNFmWAsXzNPXYoyMyn30sHy9i44QrBBnIwLfaFZm7M1SxfViyHPWYOrkZ6
	 X1BEhOXk/dtc5oFKkVtZKKz5uh8pZnEPSLR4VShIcqhDHHPWyVoLP2DjGXuHSU5Fl9
	 Xvkny/CyfHBhq1fnb1eiCgMmy2S+hzJ2ARthyrs+Nirz8FT4a+4DMPpVLr/oVk6BdC
	 KqEOx6FUlu4x133m1op7j2dlY2sDd/uOBkUZDXa8VE1EkE+GvM4N24EeY2McpB1IoR
	 9JBvDg3pVA1lTz30p1VIAbkeSqeXhi3Uc+69odMjMXKPy5fPuGr8yTLL0+zImuHTWP
	 fNOThFPpS5cVQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1ut6Xb-00000003HMY-3yMN;
	Mon, 01 Sep 2025 17:33:55 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v3 15/15] tools: kernel-doc: add a see also section at
  man pages
Date: Mon,  1 Sep 2025 17:33:50 +0200
Message-ID: <2c5ede8d8bf6ea87e82555eb072eb64c1cf7afab.1756740314.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1756740314.git.mchehab+huawei@kernel.org>
References: <cover.1756740314.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

While cross-references are complex, as related ones can be on=0D
different files, we can at least correlate the ones that belong=0D
to the same file, adding a SEE ALSO section for them.=0D
=0D
The result is not bad. See for instance:=0D
=0D
	$ tools/docs/sphinx-build-wrapper --sphinxdirs driver-api/media -- mandocs=
=0D
	$ man Documentation/output/driver-api/man/edac_pci_add_device.9=0D
=0D
	edac_pci_add_device(9)  Kernel Hacker's Manual  edac_pci_add_device(9)=0D
=0D
	NAME=0D
	       edac_pci_add_device  - Insert the 'edac_dev' structure into the=0D
	       edac_pci global list and create sysfs entries  associated  with=0D
	       edac_pci structure.=0D
=0D
	SYNOPSIS=0D
	       int  edac_pci_add_device  (struct  edac_pci_ctl_info *pci , int=0D
	       edac_idx );=0D
=0D
	ARGUMENTS=0D
	       pci         pointer to the edac_device structure to be added to=0D
	                   the list=0D
=0D
	       edac_idx    A unique numeric identifier to be assigned to the=0D
=0D
	RETURN=0D
	       0 on Success, or an error code on failure=0D
=0D
	SEE ALSO=0D
	       edac_pci_alloc_ctl_info(9),          edac_pci_free_ctl_info(9),=0D
	       edac_pci_alloc_index(9),  edac_pci_del_device(9), edac_pci_cre=E2=
=80=90=0D
	       ate_generic_ctl(9),            edac_pci_release_generic_ctl(9),=0D
	       edac_pci_create_sysfs(9), edac_pci_remove_sysfs(9)=0D
=0D
	August 2025               edac_pci_add_device   edac_pci_add_device(9)=0D
=0D
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>=0D
---=0D
 scripts/lib/kdoc/kdoc_files.py  |  5 +-=0D
 scripts/lib/kdoc/kdoc_output.py | 84 +++++++++++++++++++++++++++++++--=0D
 2 files changed, 83 insertions(+), 6 deletions(-)=0D
=0D
diff --git a/scripts/lib/kdoc/kdoc_files.py b/scripts/lib/kdoc/kdoc_files.p=
y=0D
index 9e09b45b02fa..061c033f32da 100644=0D
--- a/scripts/lib/kdoc/kdoc_files.py=0D
+++ b/scripts/lib/kdoc/kdoc_files.py=0D
@@ -275,7 +275,10 @@ class KernelFiles():=0D
                 self.config.log.warning("No kernel-doc for file %s", fname=
)=0D
                 continue=0D
 =0D
-            for arg in self.results[fname]:=0D
+            symbols =3D self.results[fname]=0D
+            self.out_style.set_symbols(symbols)=0D
+=0D
+            for arg in symbols:=0D
                 m =3D self.out_msg(fname, arg.name, arg)=0D
 =0D
                 if m is None:=0D
diff --git a/scripts/lib/kdoc/kdoc_output.py b/scripts/lib/kdoc/kdoc_output=
.py=0D
index ea8914537ba0..1eca9a918558 100644=0D
--- a/scripts/lib/kdoc/kdoc_output.py=0D
+++ b/scripts/lib/kdoc/kdoc_output.py=0D
@@ -215,6 +215,9 @@ class OutputFormat:=0D
 =0D
     # Virtual methods to be overridden by inherited classes=0D
     # At the base class, those do nothing.=0D
+    def set_symbols(self, symbols):=0D
+        """Get a list of all symbols from kernel_doc"""=0D
+=0D
     def out_doc(self, fname, name, args):=0D
         """Outputs a DOC block"""=0D
 =0D
@@ -577,6 +580,7 @@ class ManFormat(OutputFormat):=0D
 =0D
         super().__init__()=0D
         self.modulename =3D modulename=0D
+        self.symbols =3D []=0D
 =0D
         dt =3D None=0D
         tstamp =3D os.environ.get("KBUILD_BUILD_TIMESTAMP")=0D
@@ -593,6 +597,68 @@ class ManFormat(OutputFormat):=0D
 =0D
         self.man_date =3D dt.strftime("%B %Y")=0D
 =0D
+    def arg_name(self, args, name):=0D
+        """=0D
+        Return the name that will be used for the man page.=0D
+=0D
+        As we may have the same name on different namespaces,=0D
+        prepend the data type for all types except functions and typedefs.=
=0D
+=0D
+        The doc section is special: it uses the modulename.=0D
+        """=0D
+=0D
+        dtype =3D args.type=0D
+=0D
+        if dtype =3D=3D "doc":=0D
+            return self.modulename=0D
+=0D
+        if dtype in ["function", "typedef"]:=0D
+            return name=0D
+=0D
+        return f"{dtype} {name}"=0D
+=0D
+    def set_symbols(self, symbols):=0D
+        """=0D
+        Get a list of all symbols from kernel_doc.=0D
+=0D
+        Man pages will uses it to add a SEE ALSO section with other=0D
+        symbols at the same file.=0D
+        """=0D
+        self.symbols =3D symbols=0D
+=0D
+    def out_tail(self, fname, name, args):=0D
+        """Adds a tail for all man pages"""=0D
+=0D
+        # SEE ALSO section=0D
+        if len(self.symbols) >=3D 2:=0D
+            cur_name =3D self.arg_name(args, name)=0D
+=0D
+            self.data +=3D f'.SH "SEE ALSO"' + "\n.PP\n"=0D
+            related =3D []=0D
+            for arg in self.symbols:=0D
+                out_name =3D self.arg_name(arg, arg.name)=0D
+=0D
+                if cur_name =3D=3D out_name:=0D
+                    continue=0D
+=0D
+                related.append(f"\\fB{out_name}\\fR(9)")=0D
+=0D
+            self.data +=3D ",\n".join(related) + "\n"=0D
+=0D
+        # TODO: does it make sense to add other sections? Maybe=0D
+        # REPORTING ISSUES? LICENSE?=0D
+=0D
+    def msg(self, fname, name, args):=0D
+        """=0D
+        Handles a single entry from kernel-doc parser.=0D
+=0D
+        Add a tail at the end of man pages output.=0D
+        """=0D
+        super().msg(fname, name, args)=0D
+        self.out_tail(fname, name, args)=0D
+=0D
+        return self.data=0D
+=0D
     def output_highlight(self, block):=0D
         """=0D
         Outputs a C symbol that may require being highlighted with=0D
@@ -618,7 +684,9 @@ class ManFormat(OutputFormat):=0D
         if not self.check_doc(name, args):=0D
             return=0D
 =0D
-        self.data +=3D f'.TH "{self.modulename}" 9 "{self.modulename}" "{s=
elf.man_date}" "API Manual" LINUX' + "\n"=0D
+        out_name =3D self.arg_name(args, name)=0D
+=0D
+        self.data +=3D f'.TH "{self.modulename}" 9 "{out_name}" "{self.man=
_date}" "API Manual" LINUX' + "\n"=0D
 =0D
         for section, text in args.sections.items():=0D
             self.data +=3D f'.SH "{section}"' + "\n"=0D
@@ -627,7 +695,9 @@ class ManFormat(OutputFormat):=0D
     def out_function(self, fname, name, args):=0D
         """output function in man"""=0D
 =0D
-        self.data +=3D f'.TH "{name}" 9 "{name}" "{self.man_date}" "Kernel=
 Hacker\'s Manual" LINUX' + "\n"=0D
+        out_name =3D self.arg_name(args, name)=0D
+=0D
+        self.data +=3D f'.TH "{name}" 9 "{out_name}" "{self.man_date}" "Ke=
rnel Hacker\'s Manual" LINUX' + "\n"=0D
 =0D
         self.data +=3D ".SH NAME\n"=0D
         self.data +=3D f"{name} \\- {args['purpose']}\n"=0D
@@ -671,7 +741,9 @@ class ManFormat(OutputFormat):=0D
             self.output_highlight(text)=0D
 =0D
     def out_enum(self, fname, name, args):=0D
-        self.data +=3D f'.TH "{self.modulename}" 9 "enum {name}" "{self.ma=
n_date}" "API Manual" LINUX' + "\n"=0D
+        out_name =3D self.arg_name(args, name)=0D
+=0D
+        self.data +=3D f'.TH "{self.modulename}" 9 "{out_name}" "{self.man=
_date}" "API Manual" LINUX' + "\n"=0D
 =0D
         self.data +=3D ".SH NAME\n"=0D
         self.data +=3D f"enum {name} \\- {args['purpose']}\n"=0D
@@ -703,8 +775,9 @@ class ManFormat(OutputFormat):=0D
     def out_typedef(self, fname, name, args):=0D
         module =3D self.modulename=0D
         purpose =3D args.get('purpose')=0D
+        out_name =3D self.arg_name(args, name)=0D
 =0D
-        self.data +=3D f'.TH "{module}" 9 "{name}" "{self.man_date}" "API =
Manual" LINUX' + "\n"=0D
+        self.data +=3D f'.TH "{module}" 9 "{out_name}" "{self.man_date}" "=
API Manual" LINUX' + "\n"=0D
 =0D
         self.data +=3D ".SH NAME\n"=0D
         self.data +=3D f"typedef {name} \\- {purpose}\n"=0D
@@ -717,8 +790,9 @@ class ManFormat(OutputFormat):=0D
         module =3D self.modulename=0D
         purpose =3D args.get('purpose')=0D
         definition =3D args.get('definition')=0D
+        out_name =3D self.arg_name(args, name)=0D
 =0D
-        self.data +=3D f'.TH "{module}" 9 "{args.type} {name}" "{self.man_=
date}" "API Manual" LINUX' + "\n"=0D
+        self.data +=3D f'.TH "{module}" 9 "{out_name}" "{self.man_date}" "=
API Manual" LINUX' + "\n"=0D
 =0D
         self.data +=3D ".SH NAME\n"=0D
         self.data +=3D f"{args.type} {name} \\- {purpose}\n"=0D
-- =0D
2.51.0=0D
=0D

