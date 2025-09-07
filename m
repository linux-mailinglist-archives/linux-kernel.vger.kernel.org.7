Return-Path: <linux-kernel+bounces-804828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F615B48071
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 23:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FCF41889CB1
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 21:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E192285056;
	Sun,  7 Sep 2025 21:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DP+kvv6m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6127B281375;
	Sun,  7 Sep 2025 21:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757280892; cv=none; b=FFm8CpgZBJ48dKmU+D0smHDx1nfi15dx5Iok1NWZD0F/VOrF+MBoruZF7ccf/tz6NRWOhCSyphjRm6i8eothLKqQYjNbFTPGQK2iIgWtXR2pnDSFVVNQpD2HM+uMvFdC3GAGuKPjpYrtYSjLkuM4PJzYcOpq1WzZBjvdRXSyABU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757280892; c=relaxed/simple;
	bh=4GLTK42u1xgHu2eKl0YpNDnqKeGGsdnuGD7g65JXcCo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T61WTIywCjN9PgG9IbplNJPEEKOFCXRmU66yHmxU4/MYX+wtb5NLGvC3Ojv3ACxrV6n1L+nopfYvVjoiakzAjiwxA/DthUjhI/QPKVk7Ick38cdL07pIc1ozxjdn2Q1yW7gbYyF3QZcIv5YXxKumeBx9Mw2FpiyAmvn+aTjK+eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DP+kvv6m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFA7AC4CEF0;
	Sun,  7 Sep 2025 21:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757280892;
	bh=4GLTK42u1xgHu2eKl0YpNDnqKeGGsdnuGD7g65JXcCo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DP+kvv6mFaZ20G6vnId5eCIyji7kpHgUAzez8opO4MEf120gTzJjokjIu5ZKle11V
	 L+u4Nt6EGJaWIPMwAsDgsY2tWR3+rCz3RGRFAAtkJNVhwTN4OSQ4QzCcZMvkbr5duJ
	 ce12U44jLlPK0x3XNXGtoNNoSp/O8IET6zwNu3BOMdA0rtYLHAunV1FbSVJgGpcyri
	 jsh1/J4i25ur4bFB828zLrMeAvIgD8cb9F/5uFPHbR4X8J7IgBliA+8pI/HZ3F6SLM
	 cKmqGQb4WFeS3GW2OT5h7AbwFgCkj0JJUlde362gGoQu24PECEV+lcPbWm8lGnJ92n
	 sU/6dDAdQJ1Sw==
Date: Sun, 7 Sep 2025 23:34:47 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Randy Dunlap
 <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel-doc: add support for handling global variables
Message-ID: <20250907233447.0cbe9954@foz.lan>
In-Reply-To: <80f85eacc306e62de8c9c68712c653ba290c2ff2.1757262141.git.mchehab+huawei@kernel.org>
References: <80f85eacc306e62de8c9c68712c653ba290c2ff2.1757262141.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Em Sun,  7 Sep 2025 18:22:22 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:

> Specially on kAPI, sometimes it is desirable to be able to
> describe global variables that are part of kAPI.
>=20
> Documenting vars with Sphinx is simple, as we don't need
> to parse a data struct. All we need is the variable
> declaration and use natice C domain ::c:var: to format it
> for us.
>=20
> Add support for it.
>=20
> Link: https://lore.kernel.org/linux-doc/491c3022-cef8-4860-a945-c9c4a3b63=
c09@infradead.org/T/#m947c25d95cb1d96a394410ab1131dc8e9e5013f1
> Suggested-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Btw, this is still at RFC level, as, for the final version we need:

- to document this new kernel-doc feature;
- to suppress (or keep) the end ";";
- do some cleanups/improvements at the regex to ensure that it is generic
  enough. For instance, the way it was defineded, it doesn't handle yet
  variables with assigned values like:
	extern int foo =3D 5;
- if it has a default non-zero value, should it be documented or not,
  and, if so, how;
- to decide if we add "extern" to all outputs, to none of them or if we
  just follow what is at the documented declaration (the current
  implementation does the latter;
- to decide weather use "global"/"var" or something else.

Also, it would be interesting to have a real case where we want
to document kAPI variables.

Randy,

if you have some real case examples, perhaps you could pick this patch
and add on a patch series after taking the above into consideration.

> ---
>  scripts/lib/kdoc/kdoc_output.py | 31 +++++++++++++++++++++++++++++++
>  scripts/lib/kdoc/kdoc_parser.py | 25 ++++++++++++++++++++++++-
>  2 files changed, 55 insertions(+), 1 deletion(-)
>=20
> diff --git a/scripts/lib/kdoc/kdoc_output.py b/scripts/lib/kdoc/kdoc_outp=
ut.py
> index 1eca9a918558..405a5c407522 100644
> --- a/scripts/lib/kdoc/kdoc_output.py
> +++ b/scripts/lib/kdoc/kdoc_output.py
> @@ -199,6 +199,10 @@ class OutputFormat:
>              self.out_enum(fname, name, args)
>              return self.data
> =20
> +        if dtype =3D=3D "global":
> +            self.out_global(fname, name, args)
> +            return self.data
> +
>          if dtype =3D=3D "typedef":
>              self.out_typedef(fname, name, args)
>              return self.data
> @@ -227,6 +231,9 @@ class OutputFormat:
>      def out_enum(self, fname, name, args):
>          """Outputs an enum"""
> =20
> +    def out_global(self, fname, name, args):
> +        """Outputs a global variable"""
> +
>      def out_typedef(self, fname, name, args):
>          """Outputs a typedef"""
> =20
> @@ -472,6 +479,18 @@ class RestFormat(OutputFormat):
>          self.lineprefix =3D oldprefix
>          self.out_section(args)
> =20
> +    def out_global(self, fname, name, args):
> +        oldprefix =3D self.lineprefix
> +        ln =3D args.declaration_start_line
> +        prototype =3D args.other_stuff["var_type"]
> +
> +        self.data +=3D f"
>=20
> .. c:var:: {prototype}
>=20
> "
> +
> +        self.print_lineno(ln)
> +        self.lineprefix =3D "  "
> +        self.output_highlight(args.get('purpose', ''))
> +        self.data +=3D "
> "
> +
>      def out_typedef(self, fname, name, args):
> =20
>          oldprefix =3D self.lineprefix
> @@ -772,6 +791,18 @@ class ManFormat(OutputFormat):
>              self.data +=3D f'.SH "{section}"' + "
> "
>              self.output_highlight(text)
> =20
> +    def out_global(self, fname, name, args):
> +        out_name =3D self.arg_name(args, name)
> +        prototype =3D args.other_stuff["var_type"]
> +
> +        self.data +=3D f'.TH "{self.modulename}" 9 "{out_name}" "{self.m=
an_date}" "API Manual" LINUX' + "
> "
> +
> +        self.data +=3D ".SH NAME
> "
> +        self.data +=3D f"{prototype} \- {args['purpose']}
> "
> +
> +        self.data +=3D ".SH SYNOPSIS
> "
> +        self.data +=3D f"enum {name}" + " {
> "
> +
>      def out_typedef(self, fname, name, args):
>          module =3D self.modulename
>          purpose =3D args.get('purpose')
> diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_pars=
er.py
> index 574972e1f741..e2a3f4574894 100644
> --- a/scripts/lib/kdoc/kdoc_parser.py
> +++ b/scripts/lib/kdoc/kdoc_parser.py
> @@ -64,7 +64,7 @@ type_param =3D KernRe(r"@(\w*((\.\w+)|(->\w+))*(\.\.\.)=
?)", cache=3DFalse)
>  # Tests for the beginning of a kerneldoc block in its various forms.
>  #
>  doc_block =3D doc_com + KernRe(r'DOC:\s*(.*)?', cache=3DFalse)
> -doc_begin_data =3D KernRe(r"^\s*\*?\s*(struct|union|enum|typedef)=08\s*(=
\w*)", cache =3D False)
> +doc_begin_data =3D KernRe(r"^\s*\*?\s*(struct|union|enum|typedef|global)=
=08\s*(\w*)", cache =3D False)
>  doc_begin_func =3D KernRe(str(doc_com) +			# initial " * '
>                          r"(?:\w+\s*\*\s*)?" + 		# type (not captured)
>                          r'(?:define\s+)?' + 		# possible "define" (not c=
aptured)
> @@ -886,6 +886,27 @@ class KernelDoc:
>          self.output_declaration('enum', declaration_name,
>                                  purpose=3Dself.entry.declaration_purpose)
> =20
> +    def dump_global(self, ln, proto):
> +        """
> +        Stores global variables that are part of kAPI.
> +        """
> +        VAR_ATTRIBS =3D [
> +            "extern",
> +        ]
> +        OPTIONAL_VAR_ATTR =3D "^(?:" + "|".join(VAR_ATTRIBS) + ")?"
> +
> +        r=3D KernRe(OPTIONAL_VAR_ATTR + r"(\w.*)\s+([\w_]+)[\d\]\[]*\s*;=
(?:#.*)?$")
> +        if not r.match(proto):
> +           self.emit_msg(ln,f"{proto}: can't parse variable")
> +           return
> +
> +        declaration_name =3D r.group(2)
> +        var_type =3D r.group(0)
> +
> +        self.output_declaration("global", declaration_name,
> +                                var_type=3Dvar_type,
> +                                purpose=3Dself.entry.declaration_purpose)
> +
>      def dump_declaration(self, ln, prototype):
>          """
>          Stores a data declaration inside self.entries array.
> @@ -897,6 +918,8 @@ class KernelDoc:
>              self.dump_typedef(ln, prototype)
>          elif self.entry.decl_type in ["union", "struct"]:
>              self.dump_struct(ln, prototype)
> +        elif self.entry.decl_type =3D=3D "global":
> +            self.dump_global(ln, prototype)
>          else:
>              # This would be a bug
>              self.emit_message(ln, f'Unknown declaration type: {self.entr=
y.decl_type}')



Thanks,
Mauro

