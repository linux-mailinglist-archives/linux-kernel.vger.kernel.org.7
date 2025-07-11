Return-Path: <linux-kernel+bounces-726930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24DFCB012FA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 07:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1522C1C83410
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 05:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CABE192D83;
	Fri, 11 Jul 2025 05:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lHne3v9/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26F91A072C;
	Fri, 11 Jul 2025 05:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752213030; cv=none; b=m4kcXTxPP2txGXF0E16iMzgvAL+gYhBqnZvAoT13OMzh0ZV6iZrwmw2VYoCQQzmnReUWlvBSCV0uxqCr85w1gwrk/oE3jdxksLV5E5gzYP3sK60X1PmMAUub1Naml54euVdvVI4lQVCm9vC58ZX995VVVdU1YwzjJO56hzuDUio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752213030; c=relaxed/simple;
	bh=k9TboyNWQGCLb7YfUFfPQCgH/7NFPcVelvMeYXFAla0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NJsdyJ6BkiwjLqQJvY2gMAkVGMUaXmUBOC0bZG2JwWPEcrvcJP1q/bM0FRBDTuV0jaZ4gwc8wCNNoKz8ZsfFlSfMrFa+DtOP347+kyli/VU2LrwDt+B346yQI4Aglbl4n3fuKbCm8prPajFID0BirAdiIee+EZHVvTmyk8TJ7MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lHne3v9/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42983C4CEED;
	Fri, 11 Jul 2025 05:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752213030;
	bh=k9TboyNWQGCLb7YfUFfPQCgH/7NFPcVelvMeYXFAla0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lHne3v9/rByBSgoA7e4rhaq3dPck9ibWnGLly7fDp2rDUySAzqFudP5g9x4Emp2I+
	 LJFFWHkd0PPOxij2Vkek++QHvXEZcx35THlzqsnMGHB+mTuoSFvsZsftNMvzydG1Eu
	 0nDnLKiNs1m24Hp4vjr3LIvrqSd4TU2CisCCubXIKtpR4fJRZ9EAFGrJL9REdT1gWU
	 iZ1hIAQW1TRoA5m149vm0GTqRLg3cmWL3UY21fJQ4RC+9sWlaIeKzr+pbbbK3EvCGa
	 7Vuqbk6UKhSf/NeSVdW9gzc443MRBsaVAOxVmKLilNQekFIFQAzSTMOK6I5arwKYnt
	 1tIfAUPKcqHMw==
Date: Fri, 11 Jul 2025 07:50:26 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>
Subject: Re: [PATCH v2 03/12] docs: kdoc: drop "sectionlist"
Message-ID: <20250711075026.6da00103@foz.lan>
In-Reply-To: <20250710233142.246524-4-corbet@lwn.net>
References: <20250710233142.246524-1-corbet@lwn.net>
	<20250710233142.246524-4-corbet@lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Thu, 10 Jul 2025 17:31:33 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> Python dicts (as of 3.7) are guaranteed to remember the insertion order of
> items, so we do not need a separate list for that purpose.  Drop the
> per-entry sectionlist variable and just rely on native dict ordering.
> 
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>


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

