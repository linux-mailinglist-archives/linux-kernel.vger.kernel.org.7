Return-Path: <linux-kernel+bounces-752941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F45CB17CC9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 08:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57F2F7A84A9
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 06:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0831F3B8A;
	Fri,  1 Aug 2025 06:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d3vk68vk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877B12E36EA;
	Fri,  1 Aug 2025 06:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754028587; cv=none; b=L9yp53jcsNp1NNVnIMzleaApEZOwRnvP4zX6TavWhRc4+CgNJI9628lbvgTnk2sWboznXecNf9Uduybd4dlqaAyB23zKaTx5gJkJnsvRqpcfUW8rGtA2F1PKZIWjEnU+AJef7OsnPpGQNQugJAstnJ+NZP64cD05XiX0laZhRJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754028587; c=relaxed/simple;
	bh=w1Tw1x//ZViVcWHOCnR7IGO/WiJYwDrDDW5fFhsjRGU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WwBPrTBsMTKBlNjHdVf3ChsNaxOBXFVRtD1WcV0PiHq8v8S4++8kC4RrVHmgCq9aWnskkfM1Y50JHJmku9Xhva12b6AYBIMpYSbCDUQa3HzrmtNPTkxrbijrlkjJ9lkKlcCupEmvf6ldr1vEuu4L77m81DscLRZeU/W/dY005M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d3vk68vk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E02C2C4CEE7;
	Fri,  1 Aug 2025 06:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754028587;
	bh=w1Tw1x//ZViVcWHOCnR7IGO/WiJYwDrDDW5fFhsjRGU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=d3vk68vk5J8IbqsiFOSRchDgg4rgSEbIBCHJKeROdGZ9fwORMXG70GATIJLDFMgNc
	 8Jz74dHlHTostNOYcxmNU8JTVr4vNEju1VM4+rby5yISHTU10PjO6+vbdS1INpIl2F
	 opbRXIZ3iJxF74GqlmWmQnSC+1kgmcHpvsOOXiyNPXy0nGJtUavv4rqJAD1mYr+jnx
	 e5CGJ1qbjjfqeEXzaMhV2ulgC82gVR/m3OZFvCgFicM/5pNZWNMXp2FdPUHzbox2b8
	 aMcBa/gjf0kZF1AlS2RwhrPeGi3+Ay8Ij18Ko+tJrDdD2H5taDW8eKpOVFMc7xfGHT
	 q72xI9WPBrT3Q==
Date: Fri, 1 Aug 2025 08:09:43 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>
Subject: Re: [PATCH 11/12] docs: kdoc: extract output formatting from
 dump_struct()
Message-ID: <20250801080943.63c64bc8@foz.lan>
In-Reply-To: <20250801001326.924276-12-corbet@lwn.net>
References: <20250801001326.924276-1-corbet@lwn.net>
	<20250801001326.924276-12-corbet@lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Thu, 31 Jul 2025 18:13:25 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> The last thing done in dump_struct() is to format the structure for
> printing.  That, too, is a separate activity; split it out into its own
> function.
> 
> dump_struct() now fits in a single, full-hight editor screen.
> 
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>

Splitting it on a separate function LGTM. 

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

> ---
>  scripts/lib/kdoc/kdoc_parser.py | 72 +++++++++++++++++----------------
>  1 file changed, 37 insertions(+), 35 deletions(-)
> 
> diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
> index 2b7d7e646367..131956d89f84 100644
> --- a/scripts/lib/kdoc/kdoc_parser.py
> +++ b/scripts/lib/kdoc/kdoc_parser.py
> @@ -738,6 +738,42 @@ class KernelDoc:
>              tuples = struct_members.findall(members)
>          return members
>  
> +    #
> +    # Format the struct declaration into a standard form for inclusion in the
> +    # resulting docs.
> +    #
> +    def format_struct_decl(self, declaration):
> +        #
> +        # Insert newlines, get rid of extra spaces.
> +        #
> +        declaration = KernRe(r'([{;])').sub(r'\1\n', declaration)
> +        declaration = KernRe(r'\}\s+;').sub('};', declaration)
> +        #
> +        # Format inline enums with each member on its own line.
> +        #
> +        r = KernRe(r'(enum\s+\{[^}]+),([^\n])')
> +        while r.search(declaration):
> +            declaration = r.sub(r'\1,\n\2', declaration)
> +        #
> +        # Now go through and supply the right number of tabs
> +        # for each line.
> +        #
> +        def_args = declaration.split('\n')
> +        level = 1
> +        declaration = ""
> +        for clause in def_args:
> +            clause = KernRe(r'\s+').sub(' ', clause.strip(), count=1)
> +            if clause:
> +                if '}' in clause and level > 1:
> +                    level -= 1
> +                if not clause.startswith('#'):
> +                    declaration += "\t" * level
> +                declaration += "\t" + clause + "\n"
> +                if "{" in clause and "}" not in clause:
> +                    level += 1
> +        return declaration
> +
> +
>      def dump_struct(self, ln, proto):
>          """
>          Store an entry for an struct or union
> @@ -776,42 +812,8 @@ class KernelDoc:
>          self.create_parameter_list(ln, decl_type, members, ';',
>                                     declaration_name)
>          self.check_sections(ln, declaration_name, decl_type)
> -
> -        # Adjust declaration for better display
> -        declaration = KernRe(r'([{;])').sub(r'\1\n', declaration)
> -        declaration = KernRe(r'\}\s+;').sub('};', declaration)
> -
> -        # Better handle inlined enums
> -        while True:
> -            r = KernRe(r'(enum\s+\{[^}]+),([^\n])')
> -            if not r.search(declaration):
> -                break
> -
> -            declaration = r.sub(r'\1,\n\2', declaration)
> -
> -        def_args = declaration.split('\n')
> -        level = 1
> -        declaration = ""
> -        for clause in def_args:
> -
> -            clause = clause.strip()
> -            clause = KernRe(r'\s+').sub(' ', clause, count=1)
> -
> -            if not clause:
> -                continue
> -
> -            if '}' in clause and level > 1:
> -                level -= 1
> -
> -            if not KernRe(r'^\s*#').match(clause):
> -                declaration += "\t" * level
> -
> -            declaration += "\t" + clause + "\n"
> -            if "{" in clause and "}" not in clause:
> -                level += 1
> -
>          self.output_declaration(decl_type, declaration_name,
> -                                definition=declaration,
> +                                definition=self.format_struct_decl(declaration),
>                                  purpose=self.entry.declaration_purpose)
>  
>      def dump_enum(self, ln, proto):



Thanks,
Mauro

