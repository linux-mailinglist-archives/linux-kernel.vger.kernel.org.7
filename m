Return-Path: <linux-kernel+bounces-725001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88758AFF99F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 08:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66EA23B4873
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 06:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0E62857FF;
	Thu, 10 Jul 2025 06:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C7H2EAJG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D3827FD4A;
	Thu, 10 Jul 2025 06:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752128526; cv=none; b=O1QwbekeGjtP8FVuxmOK3sS4wiHE7FNy2OupRhbyVd+7TeQmfUtp/i5uI2xqv/+qRrUMRz6IwK0eYYu1W34I38D0V9w/ERByPX/doFXKseMEYJNIF74NPUF0X7FbeFWDi7H/ZPWUDhuO5yQOfKxahgpp5se3PACONtR8yuLtH/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752128526; c=relaxed/simple;
	bh=F7IPP3+v5+yxFwd4x9NFi1Xh15+8h2Kg9anbcfSMzko=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KzGIDaSHf5d7qynAyyP+osPJDbDeSuzguHKHxea1oo+lIIwy70ZMTxUuMWh1UUv1HZaYWw3BNcb5WuKqZeNP561/gsFsAtsJx9phntBmCHlxmypl7ShvCbRmnb30NvLk396AVvnGlpRHy2KCc2+6MaIIZJEQcINRx6Pls702kP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C7H2EAJG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7019C4CEE3;
	Thu, 10 Jul 2025 06:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752128525;
	bh=F7IPP3+v5+yxFwd4x9NFi1Xh15+8h2Kg9anbcfSMzko=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=C7H2EAJGY/Dzmahul98jnr0SJGHUEfAM7mJs40hQIxn9I/bYnwYDYRcs2GJ0bQa8d
	 RHZL3OsKwE5+ESDQAi2CfDin/7dlIfAUiH2uDif9abqp0+UKvMHmVoljnEc9YSwziS
	 ykEJBA5/Su3jYmwNizPcenaFp+HxvqIKzO8ZCsECSY484osXiUQDwjWXmrllozKfX0
	 4x6A/hUWL2BQ1t1iNfvmQmQHFJBv3HcEPmRbJkEBviR4zNMJUlrNpfvXHna2EVmyzo
	 al6P4xfq3knjtnThkdmJZtHiGbhRkysyNvbnxHMV+zrk5Zf2lfiYMKq7hM6aL/17T9
	 adEBNd0xbxSxw==
Date: Thu, 10 Jul 2025 08:22:01 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>
Subject: Re: [PATCH 08/12] docs: kdoc: Regularize the use of the declaration
 name
Message-ID: <20250710082201.3a4aa762@foz.lan>
In-Reply-To: <20250702223524.231794-9-corbet@lwn.net>
References: <20250702223524.231794-1-corbet@lwn.net>
	<20250702223524.231794-9-corbet@lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Wed,  2 Jul 2025 16:35:20 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> Each declaration type passes through the name in a unique field of the
> "args" blob - even though we have always just passed the name separately.
> Get rid of all the weird names and just use the common version.
> 
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>

LGTM.
Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

> ---
>  scripts/lib/kdoc/kdoc_output.py | 39 +++++++++++++--------------------
>  scripts/lib/kdoc/kdoc_parser.py |  6 -----
>  2 files changed, 15 insertions(+), 30 deletions(-)
> 
> diff --git a/scripts/lib/kdoc/kdoc_output.py b/scripts/lib/kdoc/kdoc_output.py
> index d6f4d9e7173b..8a31b637ffd2 100644
> --- a/scripts/lib/kdoc/kdoc_output.py
> +++ b/scripts/lib/kdoc/kdoc_output.py
> @@ -367,11 +367,11 @@ class RestFormat(OutputFormat):
>  
>          func_macro = args.get('func_macro', False)
>          if func_macro:
> -            signature = args['function']
> +            signature = name
>          else:
>              if args.get('functiontype'):
>                  signature = args['functiontype'] + " "
> -            signature += args['function'] + " ("
> +            signature += name + " ("
>  
>          ln = args.get('declaration_start_line', 0)
>          count = 0
> @@ -391,7 +391,7 @@ class RestFormat(OutputFormat):
>  
>          self.print_lineno(ln)
>          if args.get('typedef') or not args.get('functiontype'):
> -            self.data += f".. c:macro:: {args['function']}\n\n"
> +            self.data += f".. c:macro:: {name}\n\n"
>  
>              if args.get('typedef'):
>                  self.data += "   **Typedef**: "
> @@ -445,7 +445,6 @@ class RestFormat(OutputFormat):
>      def out_enum(self, fname, name, args):
>  
>          oldprefix = self.lineprefix
> -        name = args.get('enum', '')
>          ln = args.get('declaration_start_line', 0)
>  
>          self.data += f"\n\n.. c:enum:: {name}\n\n"
> @@ -475,7 +474,6 @@ class RestFormat(OutputFormat):
>      def out_typedef(self, fname, name, args):
>  
>          oldprefix = self.lineprefix
> -        name = args.get('typedef', '')
>          ln = args.get('declaration_start_line', 0)
>  
>          self.data += f"\n\n.. c:type:: {name}\n\n"
> @@ -492,7 +490,6 @@ class RestFormat(OutputFormat):
>  
>      def out_struct(self, fname, name, args):
>  
> -        name = args.get('struct', "")
>          purpose = args.get('purpose', "")
>          declaration = args.get('definition', "")
>          dtype = args.get('type', "struct")
> @@ -632,16 +629,16 @@ class ManFormat(OutputFormat):
>      def out_function(self, fname, name, args):
>          """output function in man"""
>  
> -        self.data += f'.TH "{args["function"]}" 9 "{args["function"]}" "{self.man_date}" "Kernel Hacker\'s Manual" LINUX' + "\n"
> +        self.data += f'.TH "{name}" 9 "{name}" "{self.man_date}" "Kernel Hacker\'s Manual" LINUX' + "\n"
>  
>          self.data += ".SH NAME\n"
> -        self.data += f"{args['function']} \\- {args['purpose']}\n"
> +        self.data += f"{name} \\- {args['purpose']}\n"
>  
>          self.data += ".SH SYNOPSIS\n"
>          if args.get('functiontype', ''):
> -            self.data += f'.B "{args["functiontype"]}" {args["function"]}' + "\n"
> +            self.data += f'.B "{args["functiontype"]}" {name}' + "\n"
>          else:
> -            self.data += f'.B "{args["function"]}' + "\n"
> +            self.data += f'.B "{name}' + "\n"
>  
>          count = 0
>          parenth = "("
> @@ -676,16 +673,13 @@ class ManFormat(OutputFormat):
>              self.output_highlight(text)
>  
>      def out_enum(self, fname, name, args):
> -
> -        name = args.get('enum', '')
> -
> -        self.data += f'.TH "{self.modulename}" 9 "enum {args["enum"]}" "{self.man_date}" "API Manual" LINUX' + "\n"
> +        self.data += f'.TH "{self.modulename}" 9 "enum {name}" "{self.man_date}" "API Manual" LINUX' + "\n"
>  
>          self.data += ".SH NAME\n"
> -        self.data += f"enum {args['enum']} \\- {args['purpose']}\n"
> +        self.data += f"enum {name} \\- {args['purpose']}\n"
>  
>          self.data += ".SH SYNOPSIS\n"
> -        self.data += f"enum {args['enum']}" + " {\n"
> +        self.data += f"enum {name}" + " {\n"
>  
>          count = 0
>          for parameter in args.parameterlist:
> @@ -710,13 +704,12 @@ class ManFormat(OutputFormat):
>  
>      def out_typedef(self, fname, name, args):
>          module = self.modulename
> -        typedef = args.get('typedef')
>          purpose = args.get('purpose')
>  
> -        self.data += f'.TH "{module}" 9 "{typedef}" "{self.man_date}" "API Manual" LINUX' + "\n"
> +        self.data += f'.TH "{module}" 9 "{name}" "{self.man_date}" "API Manual" LINUX' + "\n"
>  
>          self.data += ".SH NAME\n"
> -        self.data += f"typedef {typedef} \\- {purpose}\n"
> +        self.data += f"typedef {name} \\- {purpose}\n"
>  
>          for section, text in args.sections.items():
>              self.data += f'.SH "{section}"' + "\n"
> @@ -724,22 +717,20 @@ class ManFormat(OutputFormat):
>  
>      def out_struct(self, fname, name, args):
>          module = self.modulename
> -        struct_type = args.get('type')
> -        struct_name = args.get('struct')
>          purpose = args.get('purpose')
>          definition = args.get('definition')
>  
> -        self.data += f'.TH "{module}" 9 "{struct_type} {struct_name}" "{self.man_date}" "API Manual" LINUX' + "\n"
> +        self.data += f'.TH "{module}" 9 "{args.type} {name}" "{self.man_date}" "API Manual" LINUX' + "\n"
>  
>          self.data += ".SH NAME\n"
> -        self.data += f"{struct_type} {struct_name} \\- {purpose}\n"
> +        self.data += f"{args.type} {name} \\- {purpose}\n"
>  
>          # Replace tabs with two spaces and handle newlines
>          declaration = definition.replace("\t", "  ")
>          declaration = KernRe(r"\n").sub('"\n.br\n.BI "', declaration)
>  
>          self.data += ".SH SYNOPSIS\n"
> -        self.data += f"{struct_type} {struct_name} " + "{" + "\n.br\n"
> +        self.data += f"{args.type} {name} " + "{" + "\n.br\n"
>          self.data += f'.BI "{declaration}\n' + "};\n.br\n\n"
>  
>          self.data += ".SH Members\n"
> diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
> index 298abd260264..6e35e508608b 100644
> --- a/scripts/lib/kdoc/kdoc_parser.py
> +++ b/scripts/lib/kdoc/kdoc_parser.py
> @@ -790,7 +790,6 @@ class KernelDoc:
>                  level += 1
>  
>          self.output_declaration(decl_type, declaration_name,
> -                                struct=declaration_name,
>                                  definition=declaration,
>                                  purpose=self.entry.declaration_purpose)
>  
> @@ -870,7 +869,6 @@ class KernelDoc:
>                                f"Excess enum value '%{k}' description in '{declaration_name}'")
>  
>          self.output_declaration('enum', declaration_name,
> -                                enum=declaration_name,
>                                  purpose=self.entry.declaration_purpose)
>  
>      def dump_declaration(self, ln, prototype):
> @@ -1031,14 +1029,12 @@ class KernelDoc:
>  
>          if 'typedef' in return_type:
>              self.output_declaration(decl_type, declaration_name,
> -                                    function=declaration_name,
>                                      typedef=True,
>                                      functiontype=return_type,
>                                      purpose=self.entry.declaration_purpose,
>                                      func_macro=func_macro)
>          else:
>              self.output_declaration(decl_type, declaration_name,
> -                                    function=declaration_name,
>                                      typedef=False,
>                                      functiontype=return_type,
>                                      purpose=self.entry.declaration_purpose,
> @@ -1077,7 +1073,6 @@ class KernelDoc:
>              self.create_parameter_list(ln, decl_type, args, ',', declaration_name)
>  
>              self.output_declaration(decl_type, declaration_name,
> -                                    function=declaration_name,
>                                      typedef=True,
>                                      functiontype=return_type,
>                                      purpose=self.entry.declaration_purpose)
> @@ -1099,7 +1094,6 @@ class KernelDoc:
>                  return
>  
>              self.output_declaration('typedef', declaration_name,
> -                                    typedef=declaration_name,
>                                      purpose=self.entry.declaration_purpose)
>              return
>  



Thanks,
Mauro

