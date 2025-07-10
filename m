Return-Path: <linux-kernel+bounces-725028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68961AFF9FC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 08:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A48D3A0F8A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 06:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B544A28725D;
	Thu, 10 Jul 2025 06:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mRzIQZyN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CA1206F27;
	Thu, 10 Jul 2025 06:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752129683; cv=none; b=FJP/xV1p9sY8qnKdfHfSLPobINmuwgjKj0tEDcc6Q8CG+/FlJ8JpiyukfEUTGP73pJ8WRF9VHXMrz6ggJXu1B92R48GeUT1845YcwHrh+UE8S7PpLxa+Z6GzwrKkSLdNrN5PHD9LN98HuT71AotxjQrfntvSoQYKLaEXD4ov9xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752129683; c=relaxed/simple;
	bh=FYejiqw8iKfAj9Dn1vIoShSI1tpC8OMjMJ44REKgjUo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H1WQI2m1khwsdZ6hLFWYUeW/PeLNE+4ExOaczO2V+0l4xhd9DHlWU7naQjcBXHZEK76j3CuvP4jfwPrHTRgg19waW4CPSBxtjL63UNAt5UwSwI1/Fovbw+Cd8ju0AoMInHG1AlcslDGtGxzUuUeaK7y64yBaMDHRtcKfdnactUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mRzIQZyN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DBD4C4CEE3;
	Thu, 10 Jul 2025 06:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752129683;
	bh=FYejiqw8iKfAj9Dn1vIoShSI1tpC8OMjMJ44REKgjUo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mRzIQZyNi2682ceXUD6M42/9EIi/5J7ySNLIUjMHdsjx4Rc6jKUVnsR37El4de9eL
	 N1LQgbX7BEx7Tur0iuoxn/ntBjJphd2vA6C/ZxHa2/alZeOEbekBwHATemimSSh/CD
	 w0YtAx6RTRehfm6zw4uymyVDuck/x1rBBXMfJqQpl8yYcCWKfNp6I74KyC40LVN8zQ
	 uFEKtq6o0Qqc5YlVKb1LAZ0Nqmhc2f6s1hqtIVOb+8fhK0V+8b/YJ63qUwtBy25MZz
	 hXMxmfFG4+jEvVCeoaagLTN4LHxprl9anXglOoV+PKri30CTjuhOaZ6KV4IygVAcjt
	 xvOOiCUMOhzfg==
Date: Thu, 10 Jul 2025 08:41:19 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>
Subject: Re: [PATCH 12/12] docs: kdoc: Improve the output text accumulation
Message-ID: <20250710084119.3e5c1ced@foz.lan>
In-Reply-To: <20250702223524.231794-13-corbet@lwn.net>
References: <20250702223524.231794-1-corbet@lwn.net>
	<20250702223524.231794-13-corbet@lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Wed,  2 Jul 2025 16:35:24 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> Building strings with repeated concatenation is somewhat inefficient in
> Python; it is better to make a list and glom them all together at the end.
> Add a small set of methods to the OutputFormat superclass to manage the
> output string, and use them throughout.
> 
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>

The patch looks good to me. Just a minor nit below.

> ---
>  scripts/lib/kdoc/kdoc_output.py | 185 +++++++++++++++++---------------
>  1 file changed, 98 insertions(+), 87 deletions(-)
> 
> diff --git a/scripts/lib/kdoc/kdoc_output.py b/scripts/lib/kdoc/kdoc_output.py
> index ea8914537ba0..d4aabdaa9c51 100644
> --- a/scripts/lib/kdoc/kdoc_output.py
> +++ b/scripts/lib/kdoc/kdoc_output.py
> @@ -73,7 +73,19 @@ class OutputFormat:
>          self.config = None
>          self.no_doc_sections = False
>  
> -        self.data = ""
> +    #
> +    # Accumulation and management of the output text.
> +    #
> +    def reset_output(self):
> +        self._output = []
> +
> +    def emit(self, text):
> +        """Add a string to out output text"""
> +        self._output.append(text)
> +
> +    def output(self):
> +        """Obtain the accumulated output text"""
> +        return ''.join(self._output)

I would prefer to use a more Pythonic name for this function:

	def __str__(self)

This way, all it takes to get the final string is to use str():

	out_str = str(out)

With that:

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

>  
>      def set_config(self, config):
>          """
> @@ -180,32 +192,31 @@ class OutputFormat:
>          Handles a single entry from kernel-doc parser
>          """
>  
> -        self.data = ""
> -
> +        self.reset_output()
>          dtype = args.type
>  
>          if dtype == "doc":
>              self.out_doc(fname, name, args)
> -            return self.data
> +            return self.output()
>  
>          if not self.check_declaration(dtype, name, args):
> -            return self.data
> +            return self.output()
>  
>          if dtype == "function":
>              self.out_function(fname, name, args)
> -            return self.data
> +            return self.output()
>  
>          if dtype == "enum":
>              self.out_enum(fname, name, args)
> -            return self.data
> +            return self.output()
>  
>          if dtype == "typedef":
>              self.out_typedef(fname, name, args)
> -            return self.data
> +            return self.output()
>  
>          if dtype in ["struct", "union"]:
>              self.out_struct(fname, name, args)
> -            return self.data
> +            return self.output()
>  
>          # Warn if some type requires an output logic
>          self.config.log.warning("doesn't now how to output '%s' block",
> @@ -274,7 +285,7 @@ class RestFormat(OutputFormat):
>  
>          if self.enable_lineno and ln is not None:
>              ln += 1
> -            self.data += f".. LINENO {ln}\n"
> +            self.emit(f".. LINENO {ln}\n")
>  
>      def output_highlight(self, args):
>          """
> @@ -326,7 +337,7 @@ class RestFormat(OutputFormat):
>  
>          # Print the output with the line prefix
>          for line in output.strip("\n").split("\n"):
> -            self.data += self.lineprefix + line + "\n"
> +            self.emit(self.lineprefix + line + "\n")
>  
>      def out_section(self, args, out_docblock=False):
>          """
> @@ -343,15 +354,15 @@ class RestFormat(OutputFormat):
>  
>              if out_docblock:
>                  if not self.out_mode == self.OUTPUT_INCLUDE:
> -                    self.data += f".. _{section}:\n\n"
> -                    self.data += f'{self.lineprefix}**{section}**\n\n'
> +                    self.emit(f".. _{section}:\n\n")
> +                    self.emit(f'{self.lineprefix}**{section}**\n\n')
>              else:
> -                self.data += f'{self.lineprefix}**{section}**\n\n'
> +                self.emit(f'{self.lineprefix}**{section}**\n\n')
>  
>              self.print_lineno(args.section_start_lines.get(section, 0))
>              self.output_highlight(text)
> -            self.data += "\n"
> -        self.data += "\n"
> +            self.emit("\n")
> +        self.emit("\n")
>  
>      def out_doc(self, fname, name, args):
>          if not self.check_doc(name, args):
> @@ -389,41 +400,41 @@ class RestFormat(OutputFormat):
>  
>          self.print_lineno(ln)
>          if args.get('typedef') or not args.get('functiontype'):
> -            self.data += f".. c:macro:: {name}\n\n"
> +            self.emit(f".. c:macro:: {name}\n\n")
>  
>              if args.get('typedef'):
> -                self.data += "   **Typedef**: "
> +                self.emit("   **Typedef**: ")
>                  self.lineprefix = ""
>                  self.output_highlight(args.get('purpose', ""))
> -                self.data += "\n\n**Syntax**\n\n"
> -                self.data += f"  ``{signature}``\n\n"
> +                self.emit("\n\n**Syntax**\n\n")
> +                self.emit(f"  ``{signature}``\n\n")
>              else:
> -                self.data += f"``{signature}``\n\n"
> +                self.emit(f"``{signature}``\n\n")
>          else:
> -            self.data += f".. c:function:: {signature}\n\n"
> +            self.emit(f".. c:function:: {signature}\n\n")
>  
>          if not args.get('typedef'):
>              self.print_lineno(ln)
>              self.lineprefix = "   "
>              self.output_highlight(args.get('purpose', ""))
> -            self.data += "\n"
> +            self.emit("\n")
>  
>          # Put descriptive text into a container (HTML <div>) to help set
>          # function prototypes apart
>          self.lineprefix = "  "
>  
>          if args.parameterlist:
> -            self.data += ".. container:: kernelindent\n\n"
> -            self.data += f"{self.lineprefix}**Parameters**\n\n"
> +            self.emit(".. container:: kernelindent\n\n")
> +            self.emit(f"{self.lineprefix}**Parameters**\n\n")
>  
>          for parameter in args.parameterlist:
>              parameter_name = KernRe(r'\[.*').sub('', parameter)
>              dtype = args.parametertypes.get(parameter, "")
>  
>              if dtype:
> -                self.data += f"{self.lineprefix}``{dtype}``\n"
> +                self.emit(f"{self.lineprefix}``{dtype}``\n")
>              else:
> -                self.data += f"{self.lineprefix}``{parameter}``\n"
> +                self.emit(f"{self.lineprefix}``{parameter}``\n")
>  
>              self.print_lineno(args.parameterdesc_start_lines.get(parameter_name, 0))
>  
> @@ -432,9 +443,9 @@ class RestFormat(OutputFormat):
>                 args.parameterdescs[parameter_name] != KernelDoc.undescribed:
>  
>                  self.output_highlight(args.parameterdescs[parameter_name])
> -                self.data += "\n"
> +                self.emit("\n")
>              else:
> -                self.data += f"{self.lineprefix}*undescribed*\n\n"
> +                self.emit(f"{self.lineprefix}*undescribed*\n\n")
>              self.lineprefix = "  "
>  
>          self.out_section(args)
> @@ -445,26 +456,26 @@ class RestFormat(OutputFormat):
>          oldprefix = self.lineprefix
>          ln = args.declaration_start_line
>  
> -        self.data += f"\n\n.. c:enum:: {name}\n\n"
> +        self.emit(f"\n\n.. c:enum:: {name}\n\n")
>  
>          self.print_lineno(ln)
>          self.lineprefix = "  "
>          self.output_highlight(args.get('purpose', ''))
> -        self.data += "\n"
> +        self.emit("\n")
>  
> -        self.data += ".. container:: kernelindent\n\n"
> +        self.emit(".. container:: kernelindent\n\n")
>          outer = self.lineprefix + "  "
>          self.lineprefix = outer + "  "
> -        self.data += f"{outer}**Constants**\n\n"
> +        self.emit(f"{outer}**Constants**\n\n")
>  
>          for parameter in args.parameterlist:
> -            self.data += f"{outer}``{parameter}``\n"
> +            self.emit(f"{outer}``{parameter}``\n")
>  
>              if args.parameterdescs.get(parameter, '') != KernelDoc.undescribed:
>                  self.output_highlight(args.parameterdescs[parameter])
>              else:
> -                self.data += f"{self.lineprefix}*undescribed*\n\n"
> -            self.data += "\n"
> +                self.emit(f"{self.lineprefix}*undescribed*\n\n")
> +            self.emit("\n")
>  
>          self.lineprefix = oldprefix
>          self.out_section(args)
> @@ -474,14 +485,14 @@ class RestFormat(OutputFormat):
>          oldprefix = self.lineprefix
>          ln = args.declaration_start_line
>  
> -        self.data += f"\n\n.. c:type:: {name}\n\n"
> +        self.emit(f"\n\n.. c:type:: {name}\n\n")
>  
>          self.print_lineno(ln)
>          self.lineprefix = "   "
>  
>          self.output_highlight(args.get('purpose', ''))
>  
> -        self.data += "\n"
> +        self.emit("\n")
>  
>          self.lineprefix = oldprefix
>          self.out_section(args)
> @@ -493,7 +504,7 @@ class RestFormat(OutputFormat):
>          dtype = args.type
>          ln = args.declaration_start_line
>  
> -        self.data += f"\n\n.. c:{dtype}:: {name}\n\n"
> +        self.emit(f"\n\n.. c:{dtype}:: {name}\n\n")
>  
>          self.print_lineno(ln)
>  
> @@ -501,20 +512,20 @@ class RestFormat(OutputFormat):
>          self.lineprefix += "  "
>  
>          self.output_highlight(purpose)
> -        self.data += "\n"
> +        self.emit("\n")
>  
> -        self.data += ".. container:: kernelindent\n\n"
> -        self.data += f"{self.lineprefix}**Definition**::\n\n"
> +        self.emit(".. container:: kernelindent\n\n")
> +        self.emit(f"{self.lineprefix}**Definition**::\n\n")
>  
>          self.lineprefix = self.lineprefix + "  "
>  
>          declaration = declaration.replace("\t", self.lineprefix)
>  
> -        self.data += f"{self.lineprefix}{dtype} {name}" + ' {' + "\n"
> -        self.data += f"{declaration}{self.lineprefix}" + "};\n\n"
> +        self.emit(f"{self.lineprefix}{dtype} {name}" + ' {' + "\n")
> +        self.emit(f"{declaration}{self.lineprefix}" + "};\n\n")
>  
>          self.lineprefix = "  "
> -        self.data += f"{self.lineprefix}**Members**\n\n"
> +        self.emit(f"{self.lineprefix}**Members**\n\n")
>          for parameter in args.parameterlist:
>              if not parameter or parameter.startswith("#"):
>                  continue
> @@ -526,15 +537,15 @@ class RestFormat(OutputFormat):
>  
>              self.print_lineno(args.parameterdesc_start_lines.get(parameter_name, 0))
>  
> -            self.data += f"{self.lineprefix}``{parameter}``\n"
> +            self.emit(f"{self.lineprefix}``{parameter}``\n")
>  
>              self.lineprefix = "    "
>              self.output_highlight(args.parameterdescs[parameter_name])
>              self.lineprefix = "  "
>  
> -            self.data += "\n"
> +            self.emit("\n")
>  
> -        self.data += "\n"
> +        self.emit("\n")
>  
>          self.lineprefix = oldprefix
>          self.out_section(args)
> @@ -610,33 +621,33 @@ class ManFormat(OutputFormat):
>                  continue
>  
>              if line[0] == ".":
> -                self.data += "\\&" + line + "\n"
> +                self.emit("\\&" + line + "\n")
>              else:
> -                self.data += line + "\n"
> +                self.emit(line + "\n")
>  
>      def out_doc(self, fname, name, args):
>          if not self.check_doc(name, args):
>              return
>  
> -        self.data += f'.TH "{self.modulename}" 9 "{self.modulename}" "{self.man_date}" "API Manual" LINUX' + "\n"
> +        self.emit(f'.TH "{self.modulename}" 9 "{self.modulename}" "{self.man_date}" "API Manual" LINUX' + "\n")
>  
>          for section, text in args.sections.items():
> -            self.data += f'.SH "{section}"' + "\n"
> +            self.emit(f'.SH "{section}"' + "\n")
>              self.output_highlight(text)
>  
>      def out_function(self, fname, name, args):
>          """output function in man"""
>  
> -        self.data += f'.TH "{name}" 9 "{name}" "{self.man_date}" "Kernel Hacker\'s Manual" LINUX' + "\n"
> +        self.emit(f'.TH "{name}" 9 "{name}" "{self.man_date}" "Kernel Hacker\'s Manual" LINUX' + "\n")
>  
> -        self.data += ".SH NAME\n"
> -        self.data += f"{name} \\- {args['purpose']}\n"
> +        self.emit(".SH NAME\n")
> +        self.emit(f"{name} \\- {args['purpose']}\n")
>  
> -        self.data += ".SH SYNOPSIS\n"
> +        self.emit(".SH SYNOPSIS\n")
>          if args.get('functiontype', ''):
> -            self.data += f'.B "{args["functiontype"]}" {name}' + "\n"
> +            self.emit(f'.B "{args["functiontype"]}" {name}' + "\n")
>          else:
> -            self.data += f'.B "{name}' + "\n"
> +            self.emit(f'.B "{name}' + "\n")
>  
>          count = 0
>          parenth = "("
> @@ -649,68 +660,68 @@ class ManFormat(OutputFormat):
>              dtype = args.parametertypes.get(parameter, "")
>              if function_pointer.match(dtype):
>                  # Pointer-to-function
> -                self.data += f'".BI "{parenth}{function_pointer.group(1)}" " ") ({function_pointer.group(2)}){post}"' + "\n"
> +                self.emit(f'".BI "{parenth}{function_pointer.group(1)}" " ") ({function_pointer.group(2)}){post}"' + "\n")
>              else:
>                  dtype = KernRe(r'([^\*])$').sub(r'\1 ', dtype)
>  
> -                self.data += f'.BI "{parenth}{dtype}"  "{post}"' + "\n"
> +                self.emit(f'.BI "{parenth}{dtype}"  "{post}"' + "\n")
>              count += 1
>              parenth = ""
>  
>          if args.parameterlist:
> -            self.data += ".SH ARGUMENTS\n"
> +            self.emit(".SH ARGUMENTS\n")
>  
>          for parameter in args.parameterlist:
>              parameter_name = re.sub(r'\[.*', '', parameter)
>  
> -            self.data += f'.IP "{parameter}" 12' + "\n"
> +            self.emit(f'.IP "{parameter}" 12' + "\n")
>              self.output_highlight(args.parameterdescs.get(parameter_name, ""))
>  
>          for section, text in args.sections.items():
> -            self.data += f'.SH "{section.upper()}"' + "\n"
> +            self.emit(f'.SH "{section.upper()}"' + "\n")
>              self.output_highlight(text)
>  
>      def out_enum(self, fname, name, args):
> -        self.data += f'.TH "{self.modulename}" 9 "enum {name}" "{self.man_date}" "API Manual" LINUX' + "\n"
> +        self.emit(f'.TH "{self.modulename}" 9 "enum {name}" "{self.man_date}" "API Manual" LINUX' + "\n")
>  
> -        self.data += ".SH NAME\n"
> -        self.data += f"enum {name} \\- {args['purpose']}\n"
> +        self.emit(".SH NAME\n")
> +        self.emit(f"enum {name} \\- {args['purpose']}\n")
>  
> -        self.data += ".SH SYNOPSIS\n"
> -        self.data += f"enum {name}" + " {\n"
> +        self.emit(".SH SYNOPSIS\n")
> +        self.emit(f"enum {name}" + " {\n")
>  
>          count = 0
>          for parameter in args.parameterlist:
> -            self.data += f'.br\n.BI "    {parameter}"' + "\n"
> +            self.emit(f'.br\n.BI "    {parameter}"' + "\n")
>              if count == len(args.parameterlist) - 1:
> -                self.data += "\n};\n"
> +                self.emit("\n};\n")
>              else:
> -                self.data += ", \n.br\n"
> +                self.emit(", \n.br\n")
>  
>              count += 1
>  
> -        self.data += ".SH Constants\n"
> +        self.emit(".SH Constants\n")
>  
>          for parameter in args.parameterlist:
>              parameter_name = KernRe(r'\[.*').sub('', parameter)
> -            self.data += f'.IP "{parameter}" 12' + "\n"
> +            self.emit(f'.IP "{parameter}" 12' + "\n")
>              self.output_highlight(args.parameterdescs.get(parameter_name, ""))
>  
>          for section, text in args.sections.items():
> -            self.data += f'.SH "{section}"' + "\n"
> +            self.emit(f'.SH "{section}"' + "\n")
>              self.output_highlight(text)
>  
>      def out_typedef(self, fname, name, args):
>          module = self.modulename
>          purpose = args.get('purpose')
>  
> -        self.data += f'.TH "{module}" 9 "{name}" "{self.man_date}" "API Manual" LINUX' + "\n"
> +        self.emit(f'.TH "{module}" 9 "{name}" "{self.man_date}" "API Manual" LINUX' + "\n")
>  
> -        self.data += ".SH NAME\n"
> -        self.data += f"typedef {name} \\- {purpose}\n"
> +        self.emit(".SH NAME\n")
> +        self.emit(f"typedef {name} \\- {purpose}\n")
>  
>          for section, text in args.sections.items():
> -            self.data += f'.SH "{section}"' + "\n"
> +            self.emit(f'.SH "{section}"' + "\n")
>              self.output_highlight(text)
>  
>      def out_struct(self, fname, name, args):
> @@ -718,20 +729,20 @@ class ManFormat(OutputFormat):
>          purpose = args.get('purpose')
>          definition = args.get('definition')
>  
> -        self.data += f'.TH "{module}" 9 "{args.type} {name}" "{self.man_date}" "API Manual" LINUX' + "\n"
> +        self.emit(f'.TH "{module}" 9 "{args.type} {name}" "{self.man_date}" "API Manual" LINUX' + "\n")
>  
> -        self.data += ".SH NAME\n"
> -        self.data += f"{args.type} {name} \\- {purpose}\n"
> +        self.emit(".SH NAME\n")
> +        self.emit(f"{args.type} {name} \\- {purpose}\n")
>  
>          # Replace tabs with two spaces and handle newlines
>          declaration = definition.replace("\t", "  ")
>          declaration = KernRe(r"\n").sub('"\n.br\n.BI "', declaration)
>  
> -        self.data += ".SH SYNOPSIS\n"
> -        self.data += f"{args.type} {name} " + "{" + "\n.br\n"
> -        self.data += f'.BI "{declaration}\n' + "};\n.br\n\n"
> +        self.emit(".SH SYNOPSIS\n")
> +        self.emit(f"{args.type} {name} " + "{" + "\n.br\n")
> +        self.emit(f'.BI "{declaration}\n' + "};\n.br\n\n")
>  
> -        self.data += ".SH Members\n"
> +        self.emit(".SH Members\n")
>          for parameter in args.parameterlist:
>              if parameter.startswith("#"):
>                  continue
> @@ -741,9 +752,9 @@ class ManFormat(OutputFormat):
>              if args.parameterdescs.get(parameter_name) == KernelDoc.undescribed:
>                  continue
>  
> -            self.data += f'.IP "{parameter}" 12' + "\n"
> +            self.emit(f'.IP "{parameter}" 12' + "\n")
>              self.output_highlight(args.parameterdescs.get(parameter_name))
>  
>          for section, text in args.sections.items():
> -            self.data += f'.SH "{section}"' + "\n"
> +            self.emit(f'.SH "{section}"' + "\n")
>              self.output_highlight(text)



Thanks,
Mauro

