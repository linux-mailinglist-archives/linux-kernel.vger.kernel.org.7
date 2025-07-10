Return-Path: <linux-kernel+bounces-724922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B559DAFF894
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 07:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B28B189D3DF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 05:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FBA4286410;
	Thu, 10 Jul 2025 05:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NoKPThNQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5C522154B;
	Thu, 10 Jul 2025 05:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752126348; cv=none; b=k8b0MsMDTarbnBBVrpVsSwQIAKf1A+OcfdCl+6NsLiPEu7YTXAIUqWpBeG2+1xXtTVF8UJSWS9GHAKv/doXz5HGhEMwenylHtKWK/kMoqrpYmVczHDIj0/QQ8dmFqkpt5Pr9lxGbPFh8cldfMHzqdmdk2d3IXhCz7KXn4qEVYaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752126348; c=relaxed/simple;
	bh=LqYPBrbfE8Cba8IPSNY5pWNkJYaTs7Jun0idPVbdbOI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UhKEpB2TRZUvBthmJ85xzQyfdrQQD5fZX6lB+jXEaWppfUL9AZMqXI3jjXxcXohqhxvROh+rXldH9NQYKsr7wX939ild2cSKyDgOlCTt9tog/tbmNEjuL6khO6S2qWq0QFVaANP9gyFDb2Qbf8VBA1vmdmR0E04tuK+jMJ5G4EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NoKPThNQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAF1BC4CEE3;
	Thu, 10 Jul 2025 05:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752126347;
	bh=LqYPBrbfE8Cba8IPSNY5pWNkJYaTs7Jun0idPVbdbOI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NoKPThNQn4rofB3yBRmnXcsbUmOK4gNDIyM9L6zfTQkepaVl17XL0idPqqQwYCZ5Z
	 i+PItJjSA1GcVQjbMjoDLWp8xRi071cYg14Lbe0wsTlsj2cPeX6jiQF+xzMH0e7uTb
	 4zp+qeqXZtpBZm7ZtaKj89rZ9fx7apGnVFUFFG4+IaH0zt1dzlF1TjGVbTrcRRBpqg
	 0AZ0NT0g99q/ir26vUUytQzFIvkdDvpgzuhXNzdTWMQLl7j7P7VH0LQ2bX/Dv39K5V
	 AD2IhH744OGikmFGRdlfXtDFhiHJ//TH4JWLj6gIvLSsmk09u7FEzZKHjjKdL38z0J
	 8t2RAD16JCXmA==
Date: Thu, 10 Jul 2025 07:45:43 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>
Subject: Re: [PATCH 04/12] docs: kdoc: Centralize handling of the item
 section list
Message-ID: <20250710074543.31b909d8@foz.lan>
In-Reply-To: <20250702223524.231794-5-corbet@lwn.net>
References: <20250702223524.231794-1-corbet@lwn.net>
	<20250702223524.231794-5-corbet@lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Wed,  2 Jul 2025 16:35:16 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> The section list always comes directly from the under-construction entry
> and is used uniformly.  Formalize section handling in the KdocItem class,
> and have output_declaration() load the sections directly from the entry,
> eliminating a lot of duplicated, verbose parameters.
> 
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> ---
>  scripts/lib/kdoc/kdoc_item.py   |  8 ++++++++
>  scripts/lib/kdoc/kdoc_output.py | 36 ++++++++++++---------------------
>  scripts/lib/kdoc/kdoc_parser.py | 20 +++---------------
>  3 files changed, 24 insertions(+), 40 deletions(-)
> 
> diff --git a/scripts/lib/kdoc/kdoc_item.py b/scripts/lib/kdoc/kdoc_item.py
> index add2cc772fec..c8329019a219 100644
> --- a/scripts/lib/kdoc/kdoc_item.py
> +++ b/scripts/lib/kdoc/kdoc_item.py
> @@ -9,6 +9,7 @@ class KdocItem:
>          self.name = name
>          self.type = type
>          self.declaration_start_line = start_line
> +        self.sections = self.sections_start_lines = { }

Nitpicks:
- to make coding-style uniform, please use "{}" without spaces;
- Please place one statement per line, just like we (usually) do in Kernel. 

  In this specific case, I strongly suspect that what you coded is not
  implementing the semantics you want. See:

	1. are you creating a single dict and placing the same dict on two
	   variables?
  or:
	2. are you initializing two different vars with their own empty
	   dict?

The subsequent code assumes (2), but a quick check with python3 command
line:

	>>> a = b = {}
	>>> a["foo"] = "bar"
	>>> print(b)
	{'foo': 'bar'}

Shows that Python is doing (1) here: it basically creates a single
dict and assign pointers to it for both self.declaration_start_line
and self.sections. Clearly, this is not what we want. 

This is not a problem in practice with the current code, as 
set_sections will replace both at the same time, but if we ever
handle them using different functions, this will become a problem.

The rest of the code looks sane to me.

>          #
>          # Just save everything else into our own dict so that the output
>          # side can grab it directly as before.  As we move things into more
> @@ -24,3 +25,10 @@ class KdocItem:
>  
>      def __getitem__(self, key):
>          return self.get(key)
> +
> +    #
> +    # Tracking of section information.
> +    #
> +    def set_sections(self, sections, start_lines):
> +        self.sections = sections
> +        self.section_start_lines = start_lines
> diff --git a/scripts/lib/kdoc/kdoc_output.py b/scripts/lib/kdoc/kdoc_output.py
> index 4895c80e4b81..15cb89f91987 100644
> --- a/scripts/lib/kdoc/kdoc_output.py
> +++ b/scripts/lib/kdoc/kdoc_output.py
> @@ -338,11 +338,7 @@ class RestFormat(OutputFormat):
>          starts by putting out the name of the doc section itself, but that
>          tends to duplicate a header already in the template file.
>          """
> -
> -        sections = args.get('sections', {})
> -        section_start_lines = args.get('section_start_lines', {})
> -
> -        for section in sections:
> +        for section, text in args.sections.items():
>              # Skip sections that are in the nosymbol_table
>              if section in self.nosymbol:
>                  continue
> @@ -354,8 +350,8 @@ class RestFormat(OutputFormat):
>              else:
>                  self.data += f'{self.lineprefix}**{section}**\n\n'
>  
> -            self.print_lineno(section_start_lines.get(section, 0))
> -            self.output_highlight(sections[section])
> +            self.print_lineno(args.section_start_lines.get(section, 0))
> +            self.output_highlight(text)
>              self.data += "\n"
>          self.data += "\n"
>  
> @@ -635,23 +631,20 @@ class ManFormat(OutputFormat):
>                  self.data += line + "\n"
>  
>      def out_doc(self, fname, name, args):
> -        sections = args.get('sections', {})
> -
>          if not self.check_doc(name, args):
>              return
>  
>          self.data += f'.TH "{self.modulename}" 9 "{self.modulename}" "{self.man_date}" "API Manual" LINUX' + "\n"
>  
> -        for section in sections:
> +        for section, text in args.sections.items():
>              self.data += f'.SH "{section}"' + "\n"
> -            self.output_highlight(sections.get(section))
> +            self.output_highlight(text)
>  
>      def out_function(self, fname, name, args):
>          """output function in man"""
>  
>          parameterlist = args.get('parameterlist', [])
>          parameterdescs = args.get('parameterdescs', {})
> -        sections = args.get('sections', {})
>  
>          self.data += f'.TH "{args["function"]}" 9 "{args["function"]}" "{self.man_date}" "Kernel Hacker\'s Manual" LINUX' + "\n"
>  
> @@ -692,15 +685,14 @@ class ManFormat(OutputFormat):
>              self.data += f'.IP "{parameter}" 12' + "\n"
>              self.output_highlight(parameterdescs.get(parameter_name, ""))
>  
> -        for section in sections:
> +        for section, text in args.sections.items():
>              self.data += f'.SH "{section.upper()}"' + "\n"
> -            self.output_highlight(sections[section])
> +            self.output_highlight(text)
>  
>      def out_enum(self, fname, name, args):
>  
>          name = args.get('enum', '')
>          parameterlist = args.get('parameterlist', [])
> -        sections = args.get('sections', {})
>  
>          self.data += f'.TH "{self.modulename}" 9 "enum {args["enum"]}" "{self.man_date}" "API Manual" LINUX' + "\n"
>  
> @@ -727,24 +719,23 @@ class ManFormat(OutputFormat):
>              self.data += f'.IP "{parameter}" 12' + "\n"
>              self.output_highlight(args['parameterdescs'].get(parameter_name, ""))
>  
> -        for section in sections:
> +        for section, text in args.sections.items():
>              self.data += f'.SH "{section}"' + "\n"
> -            self.output_highlight(sections[section])
> +            self.output_highlight(text)
>  
>      def out_typedef(self, fname, name, args):
>          module = self.modulename
>          typedef = args.get('typedef')
>          purpose = args.get('purpose')
> -        sections = args.get('sections', {})
>  
>          self.data += f'.TH "{module}" 9 "{typedef}" "{self.man_date}" "API Manual" LINUX' + "\n"
>  
>          self.data += ".SH NAME\n"
>          self.data += f"typedef {typedef} \\- {purpose}\n"
>  
> -        for section in sections:
> +        for section, text in args.sections.items():
>              self.data += f'.SH "{section}"' + "\n"
> -            self.output_highlight(sections.get(section))
> +            self.output_highlight(text)
>  
>      def out_struct(self, fname, name, args):
>          module = self.modulename
> @@ -753,7 +744,6 @@ class ManFormat(OutputFormat):
>          purpose = args.get('purpose')
>          definition = args.get('definition')
>          parameterlist = args.get('parameterlist', [])
> -        sections = args.get('sections', {})
>          parameterdescs = args.get('parameterdescs', {})
>  
>          self.data += f'.TH "{module}" 9 "{struct_type} {struct_name}" "{self.man_date}" "API Manual" LINUX' + "\n"
> @@ -782,6 +772,6 @@ class ManFormat(OutputFormat):
>              self.data += f'.IP "{parameter}" 12' + "\n"
>              self.output_highlight(parameterdescs.get(parameter_name))
>  
> -        for section in sections:
> +        for section, text in args.sections.items():
>              self.data += f'.SH "{section}"' + "\n"
> -            self.output_highlight(sections.get(section))
> +            self.output_highlight(text)
> diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
> index 2e00c8b3a5f2..608f3a1045dc 100644
> --- a/scripts/lib/kdoc/kdoc_parser.py
> +++ b/scripts/lib/kdoc/kdoc_parser.py
> @@ -272,13 +272,13 @@ class KernelDoc:
>          item = KdocItem(name, dtype, self.entry.declaration_start_line, **args)
>          item.warnings = self.entry.warnings
>  
> -        sections = item.get('sections', {})
> -
>          # Drop empty sections
>          # TODO: improve empty sections logic to emit warnings
> +        sections = self.entry.sections
>          for section in ["Description", "Return"]:
>              if section in sections and not sections[section].rstrip():
>                  del sections[section]
> +        item.set_sections(sections, self.entry.section_start_lines)
>  
>          self.entries.append(item)
>  
> @@ -824,8 +824,6 @@ class KernelDoc:
>                                  parameterdescs=self.entry.parameterdescs,
>                                  parametertypes=self.entry.parametertypes,
>                                  parameterdesc_start_lines=self.entry.parameterdesc_start_lines,
> -                                sections=self.entry.sections,
> -                                section_start_lines=self.entry.section_start_lines,
>                                  purpose=self.entry.declaration_purpose)
>  
>      def dump_enum(self, ln, proto):
> @@ -908,8 +906,6 @@ class KernelDoc:
>                                  parameterlist=self.entry.parameterlist,
>                                  parameterdescs=self.entry.parameterdescs,
>                                  parameterdesc_start_lines=self.entry.parameterdesc_start_lines,
> -                                sections=self.entry.sections,
> -                                section_start_lines=self.entry.section_start_lines,
>                                  purpose=self.entry.declaration_purpose)
>  
>      def dump_declaration(self, ln, prototype):
> @@ -1079,8 +1075,6 @@ class KernelDoc:
>                                      parameterdescs=self.entry.parameterdescs,
>                                      parametertypes=self.entry.parametertypes,
>                                      parameterdesc_start_lines=self.entry.parameterdesc_start_lines,
> -                                    sections=self.entry.sections,
> -                                    section_start_lines=self.entry.section_start_lines,
>                                      purpose=self.entry.declaration_purpose,
>                                      func_macro=func_macro)
>          else:
> @@ -1092,8 +1086,6 @@ class KernelDoc:
>                                      parameterdescs=self.entry.parameterdescs,
>                                      parametertypes=self.entry.parametertypes,
>                                      parameterdesc_start_lines=self.entry.parameterdesc_start_lines,
> -                                    sections=self.entry.sections,
> -                                    section_start_lines=self.entry.section_start_lines,
>                                      purpose=self.entry.declaration_purpose,
>                                      func_macro=func_macro)
>  
> @@ -1137,8 +1129,6 @@ class KernelDoc:
>                                      parameterdescs=self.entry.parameterdescs,
>                                      parametertypes=self.entry.parametertypes,
>                                      parameterdesc_start_lines=self.entry.parameterdesc_start_lines,
> -                                    sections=self.entry.sections,
> -                                    section_start_lines=self.entry.section_start_lines,
>                                      purpose=self.entry.declaration_purpose)
>              return
>  
> @@ -1159,8 +1149,6 @@ class KernelDoc:
>  
>              self.output_declaration('typedef', declaration_name,
>                                      typedef=declaration_name,
> -                                    sections=self.entry.sections,
> -                                    section_start_lines=self.entry.section_start_lines,
>                                      purpose=self.entry.declaration_purpose)
>              return
>  
> @@ -1642,9 +1630,7 @@ class KernelDoc:
>  
>          if doc_end.search(line):
>              self.dump_section()
> -            self.output_declaration("doc", self.entry.identifier,
> -                                    sections=self.entry.sections,
> -                                    section_start_lines=self.entry.section_start_lines)
> +            self.output_declaration("doc", self.entry.identifier)
>              self.reset_state(ln)
>  
>          elif doc_content.search(line):



Thanks,
Mauro

