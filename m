Return-Path: <linux-kernel+bounces-724120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA169AFEED7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 18:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 075475A7D42
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 16:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C104A21578D;
	Wed,  9 Jul 2025 16:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PmG4vEEa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE181213224;
	Wed,  9 Jul 2025 16:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752078441; cv=none; b=Yl2/PgVjTsrql9dUjpOJ4eID+ze2OQxRWlqeheMiNGV1/1OZenDttGjQfR8No0BCsgQdVACPt8x42gLiCrxZkQLZd4QpgGa4kgnD40Ppa6fNMqcznNfiamTl+KHPCaw3z+mRNhpsWpFs1ZJY74plwkXRKdvz/lRdnHsWVuMw8Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752078441; c=relaxed/simple;
	bh=LufykrmPmFiDv6rSZ5SjveJtbCIc10X9JUpxLXz4FmI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jCjt/hywii/2jL6Mby/72jUy1aNrb8T/8Q+cgINDCekTdI6fSoau8zoaJIV9v/pAxT8jF4n+RdLv1ynCoHVX9BoWpbXUEYVpXxVuZ8QYxP2tzLg2Zz0zfThNuXrHjV6WSMOv00Jh14SZ33loinJsn5y2tAjpiNHnLx7VhX/bF0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PmG4vEEa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D5EDC4CEF0;
	Wed,  9 Jul 2025 16:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752078440;
	bh=LufykrmPmFiDv6rSZ5SjveJtbCIc10X9JUpxLXz4FmI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PmG4vEEaBHRlHBRUBx0fCJjmXzIq5j32oX3CU/GY2H97jEGgw6KWsiG8G7oJmRPlj
	 0P7CPFhe8qrBqvSzWsLRrhCAeNCkIOXyiVxqc9kRuq4W1jin4G3v7tl41DzC9FZx+b
	 YNmPt5GxzIIrlP3KHKG2jZJFsorc+RVNTJxTYDq+WVi2Ssq3oLYPYF6mawbbDdWEy2
	 Vp4fT4AqKewSOfrzuToG3JZMlTDeLevwN7bmugJhDbpyfE29lT+WwEclb8NZKSQ/GB
	 CuXvvCfu7ICCpfa8pDi993ur9ICHLszWfIIwS8o81vyvbSKLKKYiYMFIfmcMUj6jWe
	 8xvQglIBnEDYQ==
Date: Wed, 9 Jul 2025 18:27:16 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>
Subject: Re: [PATCH 03/12] docs: kdoc: drop "sectionlist"
Message-ID: <20250709182716.42140656@foz.lan>
In-Reply-To: <20250702223524.231794-4-corbet@lwn.net>
References: <20250702223524.231794-1-corbet@lwn.net>
	<20250702223524.231794-4-corbet@lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Wed,  2 Jul 2025 16:35:15 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> Python dicts (as of 3.7) are guaranteed to remember the insertion order of
> items, so we do not need a separate list for that purpose.  Drop the
> per-entry sectionlist variable and just rely on native dict ordering.

I avoided doing such assumption, as, when I wrote, our minimal version
were below that ;-)

Sounds OK to me, but please add a notice somewhere, to let it clear or
raise an error if < 3.7, as this is the type of API changes that
scares me a lot, as there's no way to detect that the script relies
on Python dict >= 3.7.


> 
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> ---
>  scripts/lib/kdoc/kdoc_output.py | 18 ++++++------------
>  scripts/lib/kdoc/kdoc_parser.py | 13 +------------
>  2 files changed, 7 insertions(+), 24 deletions(-)
> 
> diff --git a/scripts/lib/kdoc/kdoc_output.py b/scripts/lib/kdoc/kdoc_output.py
> index 86102e628d91..4895c80e4b81 100644
> --- a/scripts/lib/kdoc/kdoc_output.py
> +++ b/scripts/lib/kdoc/kdoc_output.py
> @@ -339,11 +339,10 @@ class RestFormat(OutputFormat):
>          tends to duplicate a header already in the template file.
>          """
>  
> -        sectionlist = args.get('sectionlist', [])
>          sections = args.get('sections', {})
>          section_start_lines = args.get('section_start_lines', {})
>  
> -        for section in sectionlist:
> +        for section in sections:
>              # Skip sections that are in the nosymbol_table
>              if section in self.nosymbol:
>                  continue
> @@ -636,7 +635,6 @@ class ManFormat(OutputFormat):
>                  self.data += line + "\n"
>  
>      def out_doc(self, fname, name, args):
> -        sectionlist = args.get('sectionlist', [])
>          sections = args.get('sections', {})
>  
>          if not self.check_doc(name, args):
> @@ -644,7 +642,7 @@ class ManFormat(OutputFormat):
>  
>          self.data += f'.TH "{self.modulename}" 9 "{self.modulename}" "{self.man_date}" "API Manual" LINUX' + "\n"
>  
> -        for section in sectionlist:
> +        for section in sections:
>              self.data += f'.SH "{section}"' + "\n"
>              self.output_highlight(sections.get(section))
>  
> @@ -653,7 +651,6 @@ class ManFormat(OutputFormat):
>  
>          parameterlist = args.get('parameterlist', [])
>          parameterdescs = args.get('parameterdescs', {})
> -        sectionlist = args.get('sectionlist', [])
>          sections = args.get('sections', {})
>  
>          self.data += f'.TH "{args["function"]}" 9 "{args["function"]}" "{self.man_date}" "Kernel Hacker\'s Manual" LINUX' + "\n"
> @@ -695,7 +692,7 @@ class ManFormat(OutputFormat):
>              self.data += f'.IP "{parameter}" 12' + "\n"
>              self.output_highlight(parameterdescs.get(parameter_name, ""))
>  
> -        for section in sectionlist:
> +        for section in sections:
>              self.data += f'.SH "{section.upper()}"' + "\n"
>              self.output_highlight(sections[section])
>  
> @@ -703,7 +700,6 @@ class ManFormat(OutputFormat):
>  
>          name = args.get('enum', '')
>          parameterlist = args.get('parameterlist', [])
> -        sectionlist = args.get('sectionlist', [])
>          sections = args.get('sections', {})
>  
>          self.data += f'.TH "{self.modulename}" 9 "enum {args["enum"]}" "{self.man_date}" "API Manual" LINUX' + "\n"
> @@ -731,7 +727,7 @@ class ManFormat(OutputFormat):
>              self.data += f'.IP "{parameter}" 12' + "\n"
>              self.output_highlight(args['parameterdescs'].get(parameter_name, ""))
>  
> -        for section in sectionlist:
> +        for section in sections:
>              self.data += f'.SH "{section}"' + "\n"
>              self.output_highlight(sections[section])
>  
> @@ -739,7 +735,6 @@ class ManFormat(OutputFormat):
>          module = self.modulename
>          typedef = args.get('typedef')
>          purpose = args.get('purpose')
> -        sectionlist = args.get('sectionlist', [])
>          sections = args.get('sections', {})
>  
>          self.data += f'.TH "{module}" 9 "{typedef}" "{self.man_date}" "API Manual" LINUX' + "\n"
> @@ -747,7 +742,7 @@ class ManFormat(OutputFormat):
>          self.data += ".SH NAME\n"
>          self.data += f"typedef {typedef} \\- {purpose}\n"
>  
> -        for section in sectionlist:
> +        for section in sections:
>              self.data += f'.SH "{section}"' + "\n"
>              self.output_highlight(sections.get(section))
>  
> @@ -757,7 +752,6 @@ class ManFormat(OutputFormat):
>          struct_name = args.get('struct')
>          purpose = args.get('purpose')
>          definition = args.get('definition')
> -        sectionlist = args.get('sectionlist', [])
>          parameterlist = args.get('parameterlist', [])
>          sections = args.get('sections', {})
>          parameterdescs = args.get('parameterdescs', {})
> @@ -788,6 +782,6 @@ class ManFormat(OutputFormat):
>              self.data += f'.IP "{parameter}" 12' + "\n"
>              self.output_highlight(parameterdescs.get(parameter_name))
>  
> -        for section in sectionlist:
> +        for section in sections:
>              self.data += f'.SH "{section}"' + "\n"
>              self.output_highlight(sections.get(section))
> diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
> index 97380ff30a0d..2e00c8b3a5f2 100644
> --- a/scripts/lib/kdoc/kdoc_parser.py
> +++ b/scripts/lib/kdoc/kdoc_parser.py
> @@ -127,7 +127,6 @@ class KernelEntry:
>          self.parameterdesc_start_lines = {}
>  
>          self.section_start_lines = {}
> -        self.sectionlist = []
>          self.sections = {}
>  
>          self.anon_struct_union = False
> @@ -202,7 +201,6 @@ class KernelEntry:
>                  self.sections[name] += '\n' + contents
>              else:
>                  self.sections[name] = contents
> -                self.sectionlist.append(name)
>                  self.section_start_lines[name] = self.new_start_line
>                  self.new_start_line = 0
>  
> @@ -275,14 +273,12 @@ class KernelDoc:
>          item.warnings = self.entry.warnings
>  
>          sections = item.get('sections', {})
> -        sectionlist = item.get('sectionlist', [])
>  
>          # Drop empty sections
>          # TODO: improve empty sections logic to emit warnings
>          for section in ["Description", "Return"]:
> -            if section in sectionlist and not sections[section].rstrip():
> +            if section in sections and not sections[section].rstrip():
>                  del sections[section]
> -                sectionlist.remove(section)
>  
>          self.entries.append(item)
>  
> @@ -828,7 +824,6 @@ class KernelDoc:
>                                  parameterdescs=self.entry.parameterdescs,
>                                  parametertypes=self.entry.parametertypes,
>                                  parameterdesc_start_lines=self.entry.parameterdesc_start_lines,
> -                                sectionlist=self.entry.sectionlist,
>                                  sections=self.entry.sections,
>                                  section_start_lines=self.entry.section_start_lines,
>                                  purpose=self.entry.declaration_purpose)
> @@ -913,7 +908,6 @@ class KernelDoc:
>                                  parameterlist=self.entry.parameterlist,
>                                  parameterdescs=self.entry.parameterdescs,
>                                  parameterdesc_start_lines=self.entry.parameterdesc_start_lines,
> -                                sectionlist=self.entry.sectionlist,
>                                  sections=self.entry.sections,
>                                  section_start_lines=self.entry.section_start_lines,
>                                  purpose=self.entry.declaration_purpose)
> @@ -1085,7 +1079,6 @@ class KernelDoc:
>                                      parameterdescs=self.entry.parameterdescs,
>                                      parametertypes=self.entry.parametertypes,
>                                      parameterdesc_start_lines=self.entry.parameterdesc_start_lines,
> -                                    sectionlist=self.entry.sectionlist,
>                                      sections=self.entry.sections,
>                                      section_start_lines=self.entry.section_start_lines,
>                                      purpose=self.entry.declaration_purpose,
> @@ -1099,7 +1092,6 @@ class KernelDoc:
>                                      parameterdescs=self.entry.parameterdescs,
>                                      parametertypes=self.entry.parametertypes,
>                                      parameterdesc_start_lines=self.entry.parameterdesc_start_lines,
> -                                    sectionlist=self.entry.sectionlist,
>                                      sections=self.entry.sections,
>                                      section_start_lines=self.entry.section_start_lines,
>                                      purpose=self.entry.declaration_purpose,
> @@ -1145,7 +1137,6 @@ class KernelDoc:
>                                      parameterdescs=self.entry.parameterdescs,
>                                      parametertypes=self.entry.parametertypes,
>                                      parameterdesc_start_lines=self.entry.parameterdesc_start_lines,
> -                                    sectionlist=self.entry.sectionlist,
>                                      sections=self.entry.sections,
>                                      section_start_lines=self.entry.section_start_lines,
>                                      purpose=self.entry.declaration_purpose)
> @@ -1168,7 +1159,6 @@ class KernelDoc:
>  
>              self.output_declaration('typedef', declaration_name,
>                                      typedef=declaration_name,
> -                                    sectionlist=self.entry.sectionlist,
>                                      sections=self.entry.sections,
>                                      section_start_lines=self.entry.section_start_lines,
>                                      purpose=self.entry.declaration_purpose)
> @@ -1653,7 +1643,6 @@ class KernelDoc:
>          if doc_end.search(line):
>              self.dump_section()
>              self.output_declaration("doc", self.entry.identifier,
> -                                    sectionlist=self.entry.sectionlist,
>                                      sections=self.entry.sections,
>                                      section_start_lines=self.entry.section_start_lines)
>              self.reset_state(ln)



Thanks,
Mauro

