Return-Path: <linux-kernel+bounces-809818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5C2B5126A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 11:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8616560123
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 09:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF00F3128DC;
	Wed, 10 Sep 2025 09:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X+w3maF6"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC2E30CD92;
	Wed, 10 Sep 2025 09:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757496297; cv=none; b=sX8mzuvn3YqKAsrLTUKbfYPW7DQLmk0boBo8YJE5ro5BvS+bCDVU6eRmPL6mIvzcUeVcXq1my4YlobdoQgDp6itNkE6xWjWMobYkRYK7Jx8YvQo+osF4VFjA58YWFRU3Cv/Xi+seByyAkYRTAhl6ouI11f8/69OFxmIHB3a6h4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757496297; c=relaxed/simple;
	bh=2tjya5D9cnGgRanoRcp4aCC6LMSjB7GbonEFWYPcVQw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B5JtZYejqKBpaBrySCQz9aVJ41M2+BuntogXr7x7UIjmqGYnxyfmdOHC5nDRXahzVwomZJxW5BEEcQK0ZBx28hVE3ua1YURVaAK+BqL1b1h7hrn/FBkrtvY3q3QhMnNDnskmD0Jss5Vm2qjsfk9fo7Mgd00SHP1hTGJQT3zwY3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X+w3maF6; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757496295; x=1789032295;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=2tjya5D9cnGgRanoRcp4aCC6LMSjB7GbonEFWYPcVQw=;
  b=X+w3maF6vNxlLFTHr+NuZRNgk660MpToMFungA91Np3yZ1dBhjTmcSu9
   i+VjDIOuGe5btH8wioB+mRaEvB7X1qxUD/0BwdChEN4lQC/2amctSzS3V
   gxy8aZoHngat/GURMZ+f9FD6fHCZD60d04VDd/eJ2fQvjPADF4AIybHSH
   dkAwN5rWDull27sRKhj4dtVGBjnLzTkjHAEg8JU61limuM0mabyP18JPp
   ML8R3oh0VZqnzU8XoX+MogSN6zy/tgvZggGWxDBYkcmxHrB5IxwRSm95d
   eRYZ0HBXv+UmxQ9qU/pAfhlLtEu8rTaHQrGxvXqR7xQy2XWXYe/OdePxF
   A==;
X-CSE-ConnectionGUID: Qinbj0XkToWrKGUqBfAmnw==
X-CSE-MsgGUID: 06YrZWfTSXKAFQqk8ItK+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="59863477"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="59863477"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 02:24:54 -0700
X-CSE-ConnectionGUID: OaUDq58OQe+zMr6Fwn87cA==
X-CSE-MsgGUID: +Blb/w1USVa6gV6E7GjzoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,253,1751266800"; 
   d="scan'208";a="172626775"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.72])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2025 02:24:51 -0700
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Linux Doc Mailing
 List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Randy
 Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel-doc: add support for handling global variables
In-Reply-To: <80f85eacc306e62de8c9c68712c653ba290c2ff2.1757262141.git.mchehab+huawei@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <80f85eacc306e62de8c9c68712c653ba290c2ff2.1757262141.git.mchehab+huawei@kernel.org>
Date: Wed, 10 Sep 2025 12:24:47 +0300
Message-ID: <b9f8831490b9e8e3e4f6d90d6092b0b78c79137f@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, 07 Sep 2025, Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> Specially on kAPI, sometimes it is desirable to be able to
> describe global variables that are part of kAPI.
>
> Documenting vars with Sphinx is simple, as we don't need
> to parse a data struct. All we need is the variable
> declaration and use natice C domain ::c:var: to format it
> for us.
>
> Add support for it.

Bikeshedding on "global", it sort of implies visibility or linkage, but
here it means "variable".

You could document variables that are static, global to the module, or
exported to the entire kernel. And you could document functions that are
global (for some meaning of global).

I didn't look into kernel-doc, but can't you figure the type out from
the source, instead of having to tell it? And if you can't, why not just
make it "var" (matching Sphinx) or "variable"?


BR,
Jani.

>
> Link: https://lore.kernel.org/linux-doc/491c3022-cef8-4860-a945-c9c4a3b63c09@infradead.org/T/#m947c25d95cb1d96a394410ab1131dc8e9e5013f1
> Suggested-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  scripts/lib/kdoc/kdoc_output.py | 31 +++++++++++++++++++++++++++++++
>  scripts/lib/kdoc/kdoc_parser.py | 25 ++++++++++++++++++++++++-
>  2 files changed, 55 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/lib/kdoc/kdoc_output.py b/scripts/lib/kdoc/kdoc_output.py
> index 1eca9a918558..405a5c407522 100644
> --- a/scripts/lib/kdoc/kdoc_output.py
> +++ b/scripts/lib/kdoc/kdoc_output.py
> @@ -199,6 +199,10 @@ class OutputFormat:
>              self.out_enum(fname, name, args)
>              return self.data
>  
> +        if dtype == "global":
> +            self.out_global(fname, name, args)
> +            return self.data
> +
>          if dtype == "typedef":
>              self.out_typedef(fname, name, args)
>              return self.data
> @@ -227,6 +231,9 @@ class OutputFormat:
>      def out_enum(self, fname, name, args):
>          """Outputs an enum"""
>  
> +    def out_global(self, fname, name, args):
> +        """Outputs a global variable"""
> +
>      def out_typedef(self, fname, name, args):
>          """Outputs a typedef"""
>  
> @@ -472,6 +479,18 @@ class RestFormat(OutputFormat):
>          self.lineprefix = oldprefix
>          self.out_section(args)
>  
> +    def out_global(self, fname, name, args):
> +        oldprefix = self.lineprefix
> +        ln = args.declaration_start_line
> +        prototype = args.other_stuff["var_type"]
> +
> +        self.data += f"
>
> .. c:var:: {prototype}
>
> "
> +
> +        self.print_lineno(ln)
> +        self.lineprefix = "  "
> +        self.output_highlight(args.get('purpose', ''))
> +        self.data += "
> "
> +
>      def out_typedef(self, fname, name, args):
>  
>          oldprefix = self.lineprefix
> @@ -772,6 +791,18 @@ class ManFormat(OutputFormat):
>              self.data += f'.SH "{section}"' + "
> "
>              self.output_highlight(text)
>  
> +    def out_global(self, fname, name, args):
> +        out_name = self.arg_name(args, name)
> +        prototype = args.other_stuff["var_type"]
> +
> +        self.data += f'.TH "{self.modulename}" 9 "{out_name}" "{self.man_date}" "API Manual" LINUX' + "
> "
> +
> +        self.data += ".SH NAME
> "
> +        self.data += f"{prototype} \- {args['purpose']}
> "
> +
> +        self.data += ".SH SYNOPSIS
> "
> +        self.data += f"enum {name}" + " {
> "
> +
>      def out_typedef(self, fname, name, args):
>          module = self.modulename
>          purpose = args.get('purpose')
> diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
> index 574972e1f741..e2a3f4574894 100644
> --- a/scripts/lib/kdoc/kdoc_parser.py
> +++ b/scripts/lib/kdoc/kdoc_parser.py
> @@ -64,7 +64,7 @@ type_param = KernRe(r"@(\w*((\.\w+)|(->\w+))*(\.\.\.)?)", cache=False)
>  # Tests for the beginning of a kerneldoc block in its various forms.
>  #
>  doc_block = doc_com + KernRe(r'DOC:\s*(.*)?', cache=False)
> -doc_begin_data = KernRe(r"^\s*\*?\s*(struct|union|enum|typedef)\s*(\w*)", cache = False)
> +doc_begin_data = KernRe(r"^\s*\*?\s*(struct|union|enum|typedef|global)\s*(\w*)", cache = False)
>  doc_begin_func = KernRe(str(doc_com) +			# initial " * '
>                          r"(?:\w+\s*\*\s*)?" + 		# type (not captured)
>                          r'(?:define\s+)?' + 		# possible "define" (not captured)
> @@ -886,6 +886,27 @@ class KernelDoc:
>          self.output_declaration('enum', declaration_name,
>                                  purpose=self.entry.declaration_purpose)
>  
> +    def dump_global(self, ln, proto):
> +        """
> +        Stores global variables that are part of kAPI.
> +        """
> +        VAR_ATTRIBS = [
> +            "extern",
> +        ]
> +        OPTIONAL_VAR_ATTR = "^(?:" + "|".join(VAR_ATTRIBS) + ")?"
> +
> +        r= KernRe(OPTIONAL_VAR_ATTR + r"(\w.*)\s+([\w_]+)[\d\]\[]*\s*;(?:#.*)?$")
> +        if not r.match(proto):
> +           self.emit_msg(ln,f"{proto}: can't parse variable")
> +           return
> +
> +        declaration_name = r.group(2)
> +        var_type = r.group(0)
> +
> +        self.output_declaration("global", declaration_name,
> +                                var_type=var_type,
> +                                purpose=self.entry.declaration_purpose)
> +
>      def dump_declaration(self, ln, prototype):
>          """
>          Stores a data declaration inside self.entries array.
> @@ -897,6 +918,8 @@ class KernelDoc:
>              self.dump_typedef(ln, prototype)
>          elif self.entry.decl_type in ["union", "struct"]:
>              self.dump_struct(ln, prototype)
> +        elif self.entry.decl_type == "global":
> +            self.dump_global(ln, prototype)
>          else:
>              # This would be a bug
>              self.emit_message(ln, f'Unknown declaration type: {self.entry.decl_type}')

-- 
Jani Nikula, Intel

