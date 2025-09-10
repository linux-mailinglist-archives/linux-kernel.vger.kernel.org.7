Return-Path: <linux-kernel+bounces-810147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 518E5B51699
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 14:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 463A71C2803A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CC831282E;
	Wed, 10 Sep 2025 12:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IvEAkL7C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371EB30EF72;
	Wed, 10 Sep 2025 12:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757506434; cv=none; b=JJbggoRdmB9IYURZM+opkj+kjVWqRfHeJWhtSVyQHWWZldN87hznimsgKRrEYuBLNJdxP3XclPs2q9VpgNf90O8vjSKvsDHvdXjBsAsMArr3HX8joaAaK6mLhLxjz6i/kEjubdUX85YID6Wyl+dPqSZeQ/npofEU8cQGq0fpZP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757506434; c=relaxed/simple;
	bh=tL2FAdyt0zFqi+FSeV2e67Ti/XzJaCUPI8eZb2eioWg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jF46rVpS3Sj1Y+s/73Aps8pvZzcVJFBVxMN3jszXbh3gM8XJslecNDes578g7rgfwc3LmUgB01WnCHaOa7r4lcXSYmYMWIQIhDykbR+TE3L+PwfiHodO5k0rOpjvy10jajGFGOgP+8ZKUTd6odO4KVNG/ximHoeLLw6/sO3O/cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IvEAkL7C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 892F6C4CEF5;
	Wed, 10 Sep 2025 12:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757506432;
	bh=tL2FAdyt0zFqi+FSeV2e67Ti/XzJaCUPI8eZb2eioWg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IvEAkL7CpiOH4XoOuK4X57fnSBjEpGvEuvqq77/aje0fRseYep7L98lrBnr0B+7B5
	 xvdt6v1OYrvgVbWp/cj3fBMnmXX1rfZhrvkxsKjXpz0Lo/koWst52Iez+Q/pM/Ld/o
	 LXZZt9jNyCTqJEN2Mhz3a6UaFI4wrt9Am6oi2K5nd+xXva7UJRte/MbB/K8KvVETcP
	 iUrjwHn56emRu9qri4erM5j2kwEBEi9xDrzCnLXID2Rbg/v7SjcJi1M7rXiZuadw8c
	 QydDrLRqzciwMzwg3oR9HPeoHfoE6vap1l4iBiMitiDYqx0V5YSCrZ7aq7Jd01kFTD
	 WPUtFyYRn9+uA==
Date: Wed, 10 Sep 2025 14:13:48 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel-doc: add support for handling global variables
Message-ID: <20250910141348.5499bb3d@foz.lan>
In-Reply-To: <b9f8831490b9e8e3e4f6d90d6092b0b78c79137f@intel.com>
References: <80f85eacc306e62de8c9c68712c653ba290c2ff2.1757262141.git.mchehab+huawei@kernel.org>
	<b9f8831490b9e8e3e4f6d90d6092b0b78c79137f@intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Em Wed, 10 Sep 2025 12:24:47 +0300
Jani Nikula <jani.nikula@linux.intel.com> escreveu:

> On Sun, 07 Sep 2025, Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wr=
ote:
> > Specially on kAPI, sometimes it is desirable to be able to
> > describe global variables that are part of kAPI.
> >
> > Documenting vars with Sphinx is simple, as we don't need
> > to parse a data struct. All we need is the variable
> > declaration and use natice C domain ::c:var: to format it
> > for us.
> >
> > Add support for it. =20
>=20
> Bikeshedding on "global", it sort of implies visibility or linkage, but
> here it means "variable".
>=20
> You could document variables that are static, global to the module, or
> exported to the entire kernel. And you could document functions that are
> global (for some meaning of global).
>=20
> I didn't look into kernel-doc, but can't you figure the type out from
> the source, instead of having to tell it? And if you can't, why not just
> make it "var" (matching Sphinx) or "variable"?

I don't have a strong opinion here. I ended picking "global" just as a
sort of declaration of intent, in the sense that this is aimed to be
used for kAPI vars.

Now, "var" has certainly an appeal, as it matches Sphinx.

>=20
>=20
> BR,
> Jani.
>=20
> >
> > Link: https://lore.kernel.org/linux-doc/491c3022-cef8-4860-a945-c9c4a3b=
63c09@infradead.org/T/#m947c25d95cb1d96a394410ab1131dc8e9e5013f1
> > Suggested-by: Randy Dunlap <rdunlap@infradead.org>
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  scripts/lib/kdoc/kdoc_output.py | 31 +++++++++++++++++++++++++++++++
> >  scripts/lib/kdoc/kdoc_parser.py | 25 ++++++++++++++++++++++++-
> >  2 files changed, 55 insertions(+), 1 deletion(-)
> >
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
> >
> > .. c:var:: {prototype}
> >
> > "
> > +
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
> > +        self.data +=3D f"{prototype} \- {args['purpose']}
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
>=20



Thanks,
Mauro

