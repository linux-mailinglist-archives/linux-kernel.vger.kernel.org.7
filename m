Return-Path: <linux-kernel+bounces-808930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC13B506A8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 21:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41312447CB5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 19:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E264350835;
	Tue,  9 Sep 2025 19:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SH+2Sgb0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDB3225415;
	Tue,  9 Sep 2025 19:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757447910; cv=none; b=Ybzdb0D63i9Cl78rBEcJN1x+B4SGL3Q1VYY55yNiGph/MqWj0md4Iz6LOfqj+MAI4ygmR657JVZ3QKEHSD4NsqGGUg09TPvlmTBp46WQj9gXWmN5+f7OaqXI9ptyUkWSc3k29pQ80jL5P3zmTtsct5a0BQadLqt25FGLUbO+dAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757447910; c=relaxed/simple;
	bh=NPlLFhNLm1isWU09Xa7rRZYUu6BLaJ8Ssbg819LDxOY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fCAYV5J0dlrGk/+kPIIA6DRRgyErCGC99uZHDbMB84WXoqDdTu6m+jxQS74pJsxecm44GLCh0j71/X29Iv6V7CIeZL5+locrmjCVinIHD7FM9W8mf9De/A5rzUkMwPRkACmfS4Hgwf6UMb+PF5BMGWpNoaNp1V0L5+RYJ4CUnLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SH+2Sgb0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78F6AC4CEFA;
	Tue,  9 Sep 2025 19:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757447908;
	bh=NPlLFhNLm1isWU09Xa7rRZYUu6BLaJ8Ssbg819LDxOY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SH+2Sgb0URvZ96XobVR9LKK6cNIS3j+SBo8OmIN028V7bI5fFuG/pJZ6QneHf+MFA
	 afIIJ5bqU15+UUC0HMteW71TO0Y94UkWdFNB2K8AIv0yQUvwjVLSJKl3lqPUosTnh0
	 YAzKR2aXJ62JZ3gtDLC1gaYj+CSkvwzhmRzLCzbYHiWO4+k11Pt6LbvUWTRRVklsRz
	 RI2Q/jqoY4DMZHqd+XTYxyXUutbL5ALbO4hR3grDhgVsTvadqy8UHlTZRsMMKCkiwM
	 V0zBHQ8hVgAQRHi3EDR6/tATS/SYnkaLeBeAsGWOX0l+L1b22guiBggJktHUL3gx0C
	 /s2UICv7pI8QA==
Date: Tue, 9 Sep 2025 21:58:24 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel-doc: add support for handling global variables
Message-ID: <20250909215824.1968220c@foz.lan>
In-Reply-To: <d85e3f24-dbcd-4f28-b31f-a77661fc66fb@infradead.org>
References: <80f85eacc306e62de8c9c68712c653ba290c2ff2.1757262141.git.mchehab+huawei@kernel.org>
	<d85e3f24-dbcd-4f28-b31f-a77661fc66fb@infradead.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Em Tue, 9 Sep 2025 00:27:20 -0700
Randy Dunlap <rdunlap@infradead.org> escreveu:

> Hi Mauro,
>=20
> I have a few patch nits below, then some testing info.
>=20
>=20
> On 9/7/25 9:22 AM, Mauro Carvalho Chehab wrote:
> > Specially on kAPI, sometimes it is desirable to be able to
> > describe global variables that are part of kAPI.
> >=20
> > Documenting vars with Sphinx is simple, as we don't need
> > to parse a data struct. All we need is the variable
> > declaration and use natice C domain ::c:var: to format it
> > for us.
> >=20
> > Add support for it.
> >=20
> > Link: https://lore.kernel.org/linux-doc/491c3022-cef8-4860-a945-c9c4a3b=
63c09@infradead.org/T/#m947c25d95cb1d96a394410ab1131dc8e9e5013f1
> > Suggested-by: Randy Dunlap <rdunlap@infradead.org>
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  scripts/lib/kdoc/kdoc_output.py | 31 +++++++++++++++++++++++++++++++
> >  scripts/lib/kdoc/kdoc_parser.py | 25 ++++++++++++++++++++++++-
> >  2 files changed, 55 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/scripts/lib/kdoc/kdoc_output.py b/scripts/lib/kdoc/kdoc_ou=
tput.py
> > index 1eca9a918558..405a5c407522 100644
> > --- a/scripts/lib/kdoc/kdoc_output.py
> > +++ b/scripts/lib/kdoc/kdoc_output.py
> > @@ -199,6 +199,10 @@ class OutputFormat:
> >              self.out_enum(fname, name, args)
> >              return self.data
> > =20
> > +        if dtype =3D=3D "global":
> > +            self.out_global(fname, name, args)
> > +            return self.data
> > +
> >          if dtype =3D=3D "typedef":
> >              self.out_typedef(fname, name, args)
> >              return self.data
> > @@ -227,6 +231,9 @@ class OutputFormat:
> >      def out_enum(self, fname, name, args):
> >          """Outputs an enum"""
> > =20
> > +    def out_global(self, fname, name, args):
> > +        """Outputs a global variable"""
> > +
> >      def out_typedef(self, fname, name, args):
> >          """Outputs a typedef"""
> > =20
> > @@ -472,6 +479,18 @@ class RestFormat(OutputFormat):
> >          self.lineprefix =3D oldprefix
> >          self.out_section(args)
> > =20
> > +    def out_global(self, fname, name, args):
> > +        oldprefix =3D self.lineprefix
> > +        ln =3D args.declaration_start_line
> > +        prototype =3D args.other_stuff["var_type"]
> > +
> > +        self.data +=3D f"
> >=20
> > .. c:var:: {prototype}
> >=20
> > " =20
>=20
> Are the 5 lines above supposed to be on one line?  Did git send-email spl=
it that up for you?
> There are a few others like this below.
> patch(1) complains when I try to apply the patch from this email.

Weird. I'm testing a new mailbomb script... perhaps it is
causing those issues. Yeah, the code snippet is:

+    def out_global(self, fname, name, args):
+        oldprefix =3D self.lineprefix
+        ln =3D args.declaration_start_line
+        prototype =3D args.other_stuff["var_type"]
+
+        self.data +=3D f"\n\n.. c:var:: {prototype}\n\n"
+
+        self.print_lineno(ln)
+        self.lineprefix =3D "  "
+        self.output_highlight(args.get('purpose', ''))
+        self.data +=3D "\n"

It sounds the mailbomb script replaced "\n" with a new line :-(

> > +        self.print_lineno(ln)
> > +        self.lineprefix =3D "  "
> > +        self.output_highlight(args.get('purpose', ''))
> > +        self.data +=3D "
> > "
> > +
> >      def out_typedef(self, fname, name, args):
> > =20
> >          oldprefix =3D self.lineprefix
> > @@ -772,6 +791,18 @@ class ManFormat(OutputFormat):
> >              self.data +=3D f'.SH "{section}"' + "
> > "
> >              self.output_highlight(text)
> > =20
> > +    def out_global(self, fname, name, args):
> > +        out_name =3D self.arg_name(args, name)
> > +        prototype =3D args.other_stuff["var_type"]
> > +
> > +        self.data +=3D f'.TH "{self.modulename}" 9 "{out_name}" "{self=
.man_date}" "API Manual" LINUX' + "
> > "
> > +
> > +        self.data +=3D ".SH NAME
> > "
> > +        self.data +=3D f"{prototype} \- {args['purpose']} =20
>=20
> Python complains about the "\-" above. Other places nearby use "\\-"
> so I changed it to that instead. Hope that's OK.
>=20

Yes. Again, mailbomb script mangled it. The original code is:

+        self.data +=3D f"{prototype} \\- {args['purpose']}\n"

I'm pasting the full patch at the end.

> > "
> > +
> > +        self.data +=3D ".SH SYNOPSIS
> > "
> > +        self.data +=3D f"enum {name}" + " {
> > "
> > +
> >      def out_typedef(self, fname, name, args):
> >          module =3D self.modulename
> >          purpose =3D args.get('purpose')
> > diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_pa=
rser.py
> > index 574972e1f741..e2a3f4574894 100644
> > --- a/scripts/lib/kdoc/kdoc_parser.py
> > +++ b/scripts/lib/kdoc/kdoc_parser.py
> > @@ -64,7 +64,7 @@ type_param =3D KernRe(r"@(\w*((\.\w+)|(->\w+))*(\.\.\=
.)?)", cache=3DFalse)
> >  # Tests for the beginning of a kerneldoc block in its various forms.
> >  #
> >  doc_block =3D doc_com + KernRe(r'DOC:\s*(.*)?', cache=3DFalse)
> > -doc_begin_data =3D KernRe(r"^\s*\*?\s*(struct|union|enum|typedef)=08\s=
*(\w*)", cache =3D False)
> > +doc_begin_data =3D KernRe(r"^\s*\*?\s*(struct|union|enum|typedef|globa=
l)=08\s*(\w*)", cache =3D False)
> >  doc_begin_func =3D KernRe(str(doc_com) +			# initial " * '
> >                          r"(?:\w+\s*\*\s*)?" + 		# type (not captured)
> >                          r'(?:define\s+)?' + 		# possible "define" (not=
 captured)
> > @@ -886,6 +886,27 @@ class KernelDoc:
> >          self.output_declaration('enum', declaration_name,
> >                                  purpose=3Dself.entry.declaration_purpo=
se)
> > =20
> > +    def dump_global(self, ln, proto):
> > +        """
> > +        Stores global variables that are part of kAPI.
> > +        """
> > +        VAR_ATTRIBS =3D [
> > +            "extern",
> > +        ]
> > +        OPTIONAL_VAR_ATTR =3D "^(?:" + "|".join(VAR_ATTRIBS) + ")?"
> > +
> > +        r=3D KernRe(OPTIONAL_VAR_ATTR + r"(\w.*)\s+([\w_]+)[\d\]\[]*\s=
*;(?:#.*)?$")
> > +        if not r.match(proto):
> > +           self.emit_msg(ln,f"{proto}: can't parse variable")
> > +           return
> > +
> > +        declaration_name =3D r.group(2)
> > +        var_type =3D r.group(0)
> > +
> > +        self.output_declaration("global", declaration_name,
> > +                                var_type=3Dvar_type,
> > +                                purpose=3Dself.entry.declaration_purpo=
se)
> > +
> >      def dump_declaration(self, ln, prototype):
> >          """
> >          Stores a data declaration inside self.entries array.
> > @@ -897,6 +918,8 @@ class KernelDoc:
> >              self.dump_typedef(ln, prototype)
> >          elif self.entry.decl_type in ["union", "struct"]:
> >              self.dump_struct(ln, prototype)
> > +        elif self.entry.decl_type =3D=3D "global":
> > +            self.dump_global(ln, prototype)
> >          else:
> >              # This would be a bug
> >              self.emit_message(ln, f'Unknown declaration type: {self.en=
try.decl_type}') =20
> So, I grabbed some global data from 6-8 places in the kernel and put them=
 intoinit/kdoc-globals-test.c. Then I modified Documentation/core-api/kerne=
l-api.rst
> like this at the end of that file:
>=20
> +
> +Kernel Globals
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> +
> +.. kernel-doc:: init/kdoc-globals-test.c
> +   :identifiers:
>=20
> The html output says
> "Kernel Globals"
> but nothing else.

I usually don't add :identifiers: on kernel-doc entries. If you use
identifiers, you need to explicitly tell what symbols you want.

As a reference, kerneldoc.py logic for identifiers is:

	if 'identifiers' in self.options:                                         =
                                                                           =
                                                 =20
            identifiers =3D self.options.get('identifiers').split()        =
                                                                           =
                                                            =20
            if identifiers:
                for i in identifiers:
                    i =3D i.rstrip("\\").strip()
                    if not i:
                        continue

                    cmd +=3D ['-function', i]
                    self.msg_args["symbol"].append(i)

without it, it will pick the entire set of symbols.=20

> My test files are attached. I dumbed down (simplified) a few
> of the globals from fancy types to just unsigned long, but that
> didn't help the output results any.

Looking on your attachment, you can either drop :identifiers:
or list all of them:

	.. kernel-doc:: init/kdoc-globals-test.c
	   :identifiers: ROOT_DEV loop_per_jiffy
	   :identifiers: preset_lpj

(here, it should only show those 3 symbols)

see, having this:

	.. kernel-doc:: init/kdoc-globals-test.c
	   :identifiers: ROOT_DEV=20

will run:

	$ ./scripts/kernel-doc init/kdoc-globals-test.c -function ROOT_DEV=20


	.. c:var:: unsigned long ROOT_DEV;

	  system root device




> What's happening?
> Thanks.





Thanks,
Mauro

---


=46rom 80f85eacc306e62de8c9c68712c653ba290c2ff2 Mon Sep 17 00:00:00 2001
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Date: Sat, 6 Sep 2025 23:30:43 +0200
Subject: [PATCH] kernel-doc: add support for handling global variables

Specially on kAPI, sometimes it is desirable to be able to
describe global variables that are part of kAPI.

Documenting vars with Sphinx is simple, as we don't need
to parse a data struct. All we need is the variable
declaration and use natice C domain ::c:var: to format it
for us.

Add support for it.

Link: https://lore.kernel.org/linux-doc/491c3022-cef8-4860-a945-c9c4a3b63c0=
9@infradead.org/T/#m947c25d95cb1d96a394410ab1131dc8e9e5013f1
Suggested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

diff --git a/scripts/lib/kdoc/kdoc_output.py b/scripts/lib/kdoc/kdoc_output=
.py
index 1eca9a918558..405a5c407522 100644
--- a/scripts/lib/kdoc/kdoc_output.py
+++ b/scripts/lib/kdoc/kdoc_output.py
@@ -199,6 +199,10 @@ class OutputFormat:
             self.out_enum(fname, name, args)
             return self.data
=20
+        if dtype =3D=3D "global":
+            self.out_global(fname, name, args)
+            return self.data
+
         if dtype =3D=3D "typedef":
             self.out_typedef(fname, name, args)
             return self.data
@@ -227,6 +231,9 @@ class OutputFormat:
     def out_enum(self, fname, name, args):
         """Outputs an enum"""
=20
+    def out_global(self, fname, name, args):
+        """Outputs a global variable"""
+
     def out_typedef(self, fname, name, args):
         """Outputs a typedef"""
=20
@@ -472,6 +479,18 @@ class RestFormat(OutputFormat):
         self.lineprefix =3D oldprefix
         self.out_section(args)
=20
+    def out_global(self, fname, name, args):
+        oldprefix =3D self.lineprefix
+        ln =3D args.declaration_start_line
+        prototype =3D args.other_stuff["var_type"]
+
+        self.data +=3D f"\n\n.. c:var:: {prototype}\n\n"
+
+        self.print_lineno(ln)
+        self.lineprefix =3D "  "
+        self.output_highlight(args.get('purpose', ''))
+        self.data +=3D "\n"
+
     def out_typedef(self, fname, name, args):
=20
         oldprefix =3D self.lineprefix
@@ -772,6 +791,18 @@ class ManFormat(OutputFormat):
             self.data +=3D f'.SH "{section}"' + "\n"
             self.output_highlight(text)
=20
+    def out_global(self, fname, name, args):
+        out_name =3D self.arg_name(args, name)
+        prototype =3D args.other_stuff["var_type"]
+
+        self.data +=3D f'.TH "{self.modulename}" 9 "{out_name}" "{self.man=
_date}" "API Manual" LINUX' + "\n"
+
+        self.data +=3D ".SH NAME\n"
+        self.data +=3D f"{prototype} \\- {args['purpose']}\n"
+
+        self.data +=3D ".SH SYNOPSIS\n"
+        self.data +=3D f"enum {name}" + " {\n"
+
     def out_typedef(self, fname, name, args):
         module =3D self.modulename
         purpose =3D args.get('purpose')
diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser=
.py
index 574972e1f741..e2a3f4574894 100644
--- a/scripts/lib/kdoc/kdoc_parser.py
+++ b/scripts/lib/kdoc/kdoc_parser.py
@@ -64,7 +64,7 @@ type_param =3D KernRe(r"@(\w*((\.\w+)|(->\w+))*(\.\.\.)?)=
", cache=3DFalse)
 # Tests for the beginning of a kerneldoc block in its various forms.
 #
 doc_block =3D doc_com + KernRe(r'DOC:\s*(.*)?', cache=3DFalse)
-doc_begin_data =3D KernRe(r"^\s*\*?\s*(struct|union|enum|typedef)\b\s*(\w*=
)", cache =3D False)
+doc_begin_data =3D KernRe(r"^\s*\*?\s*(struct|union|enum|typedef|global)\b=
\s*(\w*)", cache =3D False)
 doc_begin_func =3D KernRe(str(doc_com) +			# initial " * '
                         r"(?:\w+\s*\*\s*)?" + 		# type (not captured)
                         r'(?:define\s+)?' + 		# possible "define" (not cap=
tured)
@@ -886,6 +886,27 @@ class KernelDoc:
         self.output_declaration('enum', declaration_name,
                                 purpose=3Dself.entry.declaration_purpose)
=20
+    def dump_global(self, ln, proto):
+        """
+        Stores global variables that are part of kAPI.
+        """
+        VAR_ATTRIBS =3D [
+            "extern",
+        ]
+        OPTIONAL_VAR_ATTR =3D "^(?:" + "|".join(VAR_ATTRIBS) + ")?"
+
+        r=3D KernRe(OPTIONAL_VAR_ATTR + r"(\w.*)\s+([\w_]+)[\d\]\[]*\s*;(?=
:#.*)?$")
+        if not r.match(proto):
+           self.emit_msg(ln,f"{proto}: can't parse variable")
+           return
+
+        declaration_name =3D r.group(2)
+        var_type =3D r.group(0)
+
+        self.output_declaration("global", declaration_name,
+                                var_type=3Dvar_type,
+                                purpose=3Dself.entry.declaration_purpose)
+
     def dump_declaration(self, ln, prototype):
         """
         Stores a data declaration inside self.entries array.
@@ -897,6 +918,8 @@ class KernelDoc:
             self.dump_typedef(ln, prototype)
         elif self.entry.decl_type in ["union", "struct"]:
             self.dump_struct(ln, prototype)
+        elif self.entry.decl_type =3D=3D "global":
+            self.dump_global(ln, prototype)
         else:
             # This would be a bug
             self.emit_message(ln, f'Unknown declaration type: {self.entry.=
decl_type}')

