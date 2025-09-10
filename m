Return-Path: <linux-kernel+bounces-809771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FFBB511D8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F9173A05C6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 08:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6AF53115AE;
	Wed, 10 Sep 2025 08:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hbIocpzC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37AD266595;
	Wed, 10 Sep 2025 08:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757494498; cv=none; b=r5/PEFgupCSL3mev4kyJJ5LBI1WpXW64GSYlfIcxFiS2jhWfLBN5380uYFkAVz59inlnt2K6kEcG1p9QOu83p53vh5FvaV+3omagHZWf9KG5yz7IC8ldlNT8DMQDgQUAwrnkyJ4BPMqYHqX0ilI30XngBHWRZGf3LaNrmyGoUQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757494498; c=relaxed/simple;
	bh=xWW7B6je9AYEXYw2of7F8kAV8RVAO7+9xjaJ9u+nM7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s4756yCgF5GNjdk/P+lfGOE2qd8JzPNC3vb+mOCGkBkZj1TkMzd6hnUF+FdkadZXj6rzvZdv/Ilq6setNG+z1IvTGE8kMuYEqC9eI0CxtMSAl8ulsdviakl902utwWZDVcpVgteh2iF/webGB7Pir4THiWiep7wdQB4biIugySs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hbIocpzC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44AB3C4CEF0;
	Wed, 10 Sep 2025 08:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757494498;
	bh=xWW7B6je9AYEXYw2of7F8kAV8RVAO7+9xjaJ9u+nM7Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hbIocpzCj3EazV0oCQe8vbWSkYLxbROL0jd1BiFqYlEoURHCTidd2OuSfWEpcRRMK
	 DT9xGvwQt7MnnUgmmMXW9NMUF3T4raV7Vy75ZagH531oFjuh8G+/xdsOrIwauslQKd
	 S5tJ8KNgBN/u3zsApQ08l08cce73pbUl1SxIwJzvSawWfXI/EUjp5xsLaG9L2wZ1Bf
	 T9FpOP2x10XoOcaBEeJjJ/QFZbpIQ6ixEEGQyYJQ2JjCEkchS+hw/0AiaDUDwcRo8U
	 zwvaKmqgT4wgmMmOyS2ovMJ5arruHrSfCZBEsp75f+wHCnskk/7uUpBNc4nDAh3EIG
	 nG9meZ53yavKQ==
Date: Wed, 10 Sep 2025 10:54:54 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel-doc: add support for handling global variables
Message-ID: <20250910105454.6a6c57e6@foz.lan>
In-Reply-To: <c5262290-38e3-4c48-af00-b91f03a065a8@infradead.org>
References: <80f85eacc306e62de8c9c68712c653ba290c2ff2.1757262141.git.mchehab+huawei@kernel.org>
	<d85e3f24-dbcd-4f28-b31f-a77661fc66fb@infradead.org>
	<20250909215824.1968220c@foz.lan>
	<5dc41508-43e8-4e80-b4e0-149af7bbdf19@infradead.org>
	<20250910010903.5388bffc@foz.lan>
	<0d190bf0-b9d4-4d5c-a1cc-6d5d79be3886@infradead.org>
	<656591ff-fa7d-4763-8759-0a0af3a4039a@infradead.org>
	<c195c68f-e815-4428-9134-8746198a4611@infradead.org>
	<20250910062323.059bb078@foz.lan>
	<14133b75-a984-4244-a18d-f02f0b81d1b7@infradead.org>
	<c5262290-38e3-4c48-af00-b91f03a065a8@infradead.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Em Tue, 9 Sep 2025 23:13:24 -0700
Randy Dunlap <rdunlap@infradead.org> escreveu:

> On 9/9/25 10:59 PM, Randy Dunlap wrote:
> > Hi Mauro,
> >=20
> > On 9/9/25 9:23 PM, Mauro Carvalho Chehab wrote: =20
> >> Em Tue, 9 Sep 2025 17:02:00 -0700
> >> Randy Dunlap <rdunlap@infradead.org> escreveu:
> >> =20
> >>> On 9/9/25 4:50 PM, Randy Dunlap wrote: =20
> >>>>
> >>>>
> >>>> On 9/9/25 4:49 PM, Randy Dunlap wrote:   =20
> >>>>>
> >>>>>
> >>>>> On 9/9/25 4:09 PM, Mauro Carvalho Chehab wrote:   =20
> >>>>>> Em Tue, 9 Sep 2025 14:06:43 -0700
> >>>>>> Randy Dunlap <rdunlap@infradead.org> escreveu:
> >>>>>>   =20
> >>>>>>> On 9/9/25 12:58 PM, Mauro Carvalho Chehab wrote:   =20
> >>>>>>>> Em Tue, 9 Sep 2025 00:27:20 -0700
> >>>>>>>> Randy Dunlap <rdunlap@infradead.org> escreveu:   =20
> >>>>>>   =20
> >>>>>>>>> +.. kernel-doc:: init/kdoc-globals-test.c
> >>>>>>>>> +   :identifiers:
> >>>>>>>>>
> >>>>>>>>> The html output says
> >>>>>>>>> "Kernel Globals"
> >>>>>>>>> but nothing else.     =20
> >>>>>>>>
> >>>>>>>> I usually don't add :identifiers: on kernel-doc entries. If you =
use
> >>>>>>>> identifiers, you need to explicitly tell what symbols you want. =
    =20
> >>>>>>>
> >>>>>>> Well, it worked/works without using having any identifiers listed=
, and
> >>>>>>> the docs in Documentation/doc-guide/kernel-doc.rst says that they=
 are
> >>>>>>> optional:
> >>>>>>>
> >>>>>>> identifiers: *[ function/type ...]*
> >>>>>>>   Include documentation for each *function* and *type* in *source=
*.
> >>>>>>>   If no *function* is specified, the documentation for all functi=
ons
> >>>>>>>   and types in the *source* will be included.
> >>>>>>>   *type* can be a struct, union, enum, or typedef identifier.   =
=20
> >>>>>> =20
>=20
>=20
>=20
> >>>>> Anyway, does this take away something that currently works?   =20
> >>>
> >>> The output looks the same with this patch AFAICT. =20
> >>
> >> run it in verbose mode to see what command line was passed to
> >> the file:
> >>
> >> 	$ make SPHINXDIRS=3Dyour_test_dir V=3D1 htmldocs
> >>
> >> This should be printing how the kernel-doc.py command line would be(*):
> >>
> >> 	scripts/kernel-doc.py -rst -enable-lineno ./include/linux/peci.h
> >> 	./include/linux/peci.h:20 Scanning doc for struct peci_controller_ops
> >> 	./include/linux/peci.h:32 Scanning doc for struct peci_controller
> >> 	./include/linux/peci.h:58 Scanning doc for struct peci_device
> >> 	./include/linux/peci.h:88 Scanning doc for struct peci_request
> >>
> >> (*) the kerneldoc.py extension doesn't call kernel-doc.py, but instead
> >>     run directly the Python classes from the library. Yet, to help one
> >>     to debug it, the command line is displayed. =20
> >=20
> > I see. Thanks.
> >=20
> > I get this if I list all of them (on 2 separate identifiers lines):
> >=20
> > ../scripts/kernel-doc.py -rst -enable-lineno -function ROOT_DEV -functi=
on system_state -function saved_command_line -function diskseq ../init/kdoc=
-globals-test.c
> > ../init/kdoc-globals-test.c:5 Scanning doc for global ROOT_DEV
> > ../init/kdoc-globals-test.c:15 Scanning doc for global system_state
> > ../init/kdoc-globals-test.c:27 Scanning doc for global saved_command_li=
ne
> > ../init/kdoc-globals-test.c:33 Scanning doc for global loops_per_jiffy
> > ../init/kdoc-globals-test.c:40 Scanning doc for global preset_lpj
> > ../init/kdoc-globals-test.c:49 Scanning doc for global linux_proc_banner
> > ../init/kdoc-globals-test.c:63 Scanning doc for global linux_banner
> > ../init/kdoc-globals-test.c:72 Scanning doc for global diskseq
> > ../init/kdoc-globals-test.c:80 Scanning doc for global rtnl_mutex
> > ../scripts/kernel-doc.py -rst -enable-lineno -function loops_per_jiffy =
-function preset_lpj -function linux_proc_banner -function linux_banner ../=
init/kdoc-globals-test.c
> >=20
> > or this is I don't use the identifiers line at all:
> >=20
> > ../scripts/kernel-doc.py -rst -enable-lineno ../init/kdoc-globals-test.c
> > ../init/kdoc-globals-test.c:5 Scanning doc for global ROOT_DEV
> > ../init/kdoc-globals-test.c:15 Scanning doc for global system_state
> > ../init/kdoc-globals-test.c:27 Scanning doc for global saved_command_li=
ne
> > ../init/kdoc-globals-test.c:33 Scanning doc for global loops_per_jiffy
> > ../init/kdoc-globals-test.c:40 Scanning doc for global preset_lpj
> > ../init/kdoc-globals-test.c:49 Scanning doc for global linux_proc_banner
> > ../init/kdoc-globals-test.c:63 Scanning doc for global linux_banner
> > ../init/kdoc-globals-test.c:72 Scanning doc for global diskseq
> > ../init/kdoc-globals-test.c:80 Scanning doc for global rtnl_mutex
> >=20
> >=20
> > And then both of them report these warnings (already discussed):
> >=20
> > Documentation/core-api/kernel-api:435: ../init/kdoc-globals-test.c:10: =
WARNING: Invalid C declaration: Expected end of definition. [error at 32]
> >   enum system_states system_state __read_mostly;
> >   --------------------------------^
> > Documentation/core-api/kernel-api:435: ../init/kdoc-globals-test.c:20: =
WARNING: Invalid C declaration: Expected end of definition. [error at 25]
> >   char *saved_command_line __ro_after_init;
> >   -------------------------^
> >=20
> > and the 3 globals with initialization values are skipped/omitted.
> >=20
> > So to get "all identifiers," I should just omit the :identifiers:
> > line completely. kernel-doc.rst could use some clarification on that
> > point. =20
>=20
>=20
> Oh darn, the html output is different:
>=20
> when I omit the :identifiers: line, I see:
>=20
> Kernel Globals
> dev_t ROOT_DEV;
> system root device
>=20
> enum system_states system_state __read_mostly;
> system state used during boot or suspend/hibernate/resume
>=20
> char *saved_command_line __ro_after_init;
> kernel=E2=80=99s command line, saved from use at any later time in the ke=
rnel.
>=20
> unsigned long preset_lpj;
> lpj (loops per jiffy) value set from kernel command line using =E2=80=9Cl=
pj=3DVALUE=E2=80=9D
>=20
> static atomic64_t diskseq;
> unique sequence number for block device instances
>=20
> and when I list all 8 identifiers (on 2 separate lines), I see:
>=20
> Kernel Globals
> dev_t ROOT_DEV;
> system root device
>=20
> static atomic64_t diskseq;
> unique sequence number for block device instances
>=20
> unsigned long preset_lpj;
> lpj (loops per jiffy) value set from kernel command line using =E2=80=9Cl=
pj=3DVALUE=E2=80=9D
>=20
> so for some reason, system_state, saved_command_line, and diskseq are
> skipped/omitted when I list all 8 identifiers.

It is because of the regex we're using:

+        VAR_ATTRIBS =3D [
+            "extern",
+        ]
+        OPTIONAL_VAR_ATTR =3D "^(?:" + "|".join(VAR_ATTRIBS) + ")?"
+
+        r=3D KernRe(OPTIONAL_VAR_ATTR + r"(\w.*)\s+([\w_]+)[\d\]\[]*\s*;(?=
:#.*)?$")
...
+        declaration_name =3D r.group(2)
+	 var_type =3D r.group(0)

the above stores the entire line as var_type, and the last string
as declaration_name. The output logic will use var_type as function
prototype, and declaration_name as the key to check for identifiers.

Here:

	enum system_states system_state __read_mostly;
	char *saved_command_line __ro_after_init;

the regex would pick __read_mostly and __ro_after_init as=20
identifiers.

Once we fix the regex to pick the actual var name, both ways should work
equally.

Btw, the best way to test complex regular expressions is, IMHO, to use:

	https://regex101.com/

Don't forget to select first <Python> as the default is pcre2.

there, you can place the regex on the top and several test strings and
see if everything is working.

Anyway, I did some changes at the code for it to better parse your
examples. I'm also storing two additional fields captured at parsing
time:

1. full_proto: the prototype before any transformation;
2. default_val: if not None, contains the initialized value.

Right now, I'm using only default_val ato output, but, with both,
we can play with printing them or not at kdoc_output logic.

Thanks,
Mauro

[PATCH v2] kernel-doc: add support for handling global variables

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
index 1eca9a918558..469f01a74724 100644
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
@@ -472,6 +479,24 @@ class RestFormat(OutputFormat):
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
+        if args.other_stuff["default_val"]:
+            self.data +=3D f'{self.lineprefix}**Initialization**\n\n'
+            self.output_highlight(f'default: ``{args.other_stuff["default_=
val"]}``')
+
+        self.out_section(args)
+
     def out_typedef(self, fname, name, args):
=20
         oldprefix =3D self.lineprefix
@@ -772,6 +797,26 @@ class ManFormat(OutputFormat):
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
+        if args.other_stuff["default_val"]:
+            self.data +=3D f'.SH "Initialization"' + "\n"
+            self.output_highlight(f'default: {args.other_stuff["default_va=
l"]}')
+
+        for section, text in args.sections.items():
+            self.data +=3D f'.SH "{section}"' + "\n"
+            self.output_highlight(text)
+
     def out_typedef(self, fname, name, args):
         module =3D self.modulename
         purpose =3D args.get('purpose')
diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser=
.py
index 574972e1f741..93a2fcebec28 100644
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
@@ -886,6 +886,57 @@ class KernelDoc:
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
+        sub_prefixes =3D [
+            (KernRe(r"__read_mostly"), ""),
+            (KernRe(r"__ro_after_init"), ""),
+            (KernRe(r"(?://.*)$"), ""),
+            (KernRe(r"(?:/\*.*\*/)"), ""),
+            (KernRe(r";$"), ""),
+        ]
+
+        #
+        # Store the full prototype before modifying it
+        #
+        full_proto =3D proto
+
+        #
+        # Drop comments and macros to have a pure C prototype
+        #
+        for search, sub in sub_prefixes:
+            proto =3D search.sub(sub, proto)
+
+        proto =3D proto.rstrip()
+
+        #
+        # Variable name is at the end of the declaration
+        #
+
+        r=3D KernRe(OPTIONAL_VAR_ATTR + r"\w.*\s+([\w_]+)\s*[\d\]\[]*\s*(=
=3D.*)?")
+        if not r.match(proto):
+           self.emit_msg(ln,f"{proto}: can't parse variable")
+           return
+
+        var_type =3D r.group(0)
+        declaration_name =3D r.group(1)
+        default_val =3D r.group(2)
+        if default_val:
+            default_val =3D default_val.lstrip("=3D").strip()
+
+        self.output_declaration("global", declaration_name,
+                                full_proto=3Dfull_proto,
+                                var_type=3Dvar_type,
+                                default_val=3Ddefault_val,
+                                purpose=3Dself.entry.declaration_purpose)
+
     def dump_declaration(self, ln, prototype):
         """
         Stores a data declaration inside self.entries array.
@@ -897,6 +948,8 @@ class KernelDoc:
             self.dump_typedef(ln, prototype)
         elif self.entry.decl_type in ["union", "struct"]:
             self.dump_struct(ln, prototype)
+        elif self.entry.decl_type =3D=3D "global":
+            self.dump_global(ln, prototype)
         else:
             # This would be a bug
             self.emit_message(ln, f'Unknown declaration type: {self.entry.=
decl_type}')


