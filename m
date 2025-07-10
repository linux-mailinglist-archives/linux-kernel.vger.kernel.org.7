Return-Path: <linux-kernel+bounces-725021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 560CCAFF9DB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 08:29:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90C62542616
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 06:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999CC287258;
	Thu, 10 Jul 2025 06:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uA93EhAp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C6243AA1;
	Thu, 10 Jul 2025 06:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752128973; cv=none; b=MbSkYVtIfaOzTRnZjEPxp7jOtkMgE52moYHpFXnQPTNMuZkvee0IhdB03rx4eyRRJf1mrkECv+VPCFMJ/2AJCxZGlD7SXHW4u6S6WgONzT647f6AzRXX/YlBmC+GYEj2CaDwRmu9lCDurfq2Lz+90TRQcQ1dfmJ6T5Y5F8Jb3yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752128973; c=relaxed/simple;
	bh=ffM5skOHJyuqemBuXSUWFaQh2Zi0Kcb5KVfxZLvWKoY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ejTyTXiUaGMdkl4t4VVC09f/OKs4WC7FuWpdVyd4SCZfIwRB7OEUPfzCynwhSpupAAQWeko8e6TduNBhTAoblcUpFdNdUEz1CBh1d0SyL5pdOX/muhNXAAN4E8SiZIn1i171WBsMGrQUbSEnSefIwor7GO9mBo6mmdC6aLgeIRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uA93EhAp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E6B6C4CEF5;
	Thu, 10 Jul 2025 06:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752128972;
	bh=ffM5skOHJyuqemBuXSUWFaQh2Zi0Kcb5KVfxZLvWKoY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uA93EhApmzRMr3l2azxesncXsGYG3NlPfIJ0FIGkOK31aTyKEW9a8yzrtauCxNvjv
	 qsbXk2WTnUygbpQ6/ezpaTyzBo0vMCxqMRtHrOcd/0nRUwEKepfngcl7QmPQn502qu
	 m22Bb1JvMogCpVrHXoX51tWyHR3qcN3Qt0JoaEmduhrzytUEyVTl4z8T1AzXRjfjWV
	 0VN0hx2xEPHCSZLYjz5wt/sFNAAGhpGAOkXFfpoms3+7SuSrWrTJzLOutudN6Hye7E
	 ozYt+rIqfsiLzwmXgUDhjtcZFw9CkWcPf7ce0U6SmwcaPkc3XDqjUYu+fPaOif//V/
	 Ceo9qFVshi9xA==
Date: Thu, 10 Jul 2025 08:29:27 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>
Subject: Re: [PATCH 11/12] docs: kdoc: clean up check_sections()
Message-ID: <20250710082927.10b13862@foz.lan>
In-Reply-To: <20250702223524.231794-12-corbet@lwn.net>
References: <20250702223524.231794-1-corbet@lwn.net>
	<20250702223524.231794-12-corbet@lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Wed,  2 Jul 2025 16:35:23 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> entry.sectcheck is just a duplicate of our list of sections that is only
> passed to check_sections(); its main purpose seems to be to avoid checking
> the special named sections.  Rework check_sections() to not use that field
> (which is then deleted), tocheck for the known sections directly, and
> tighten up the logic in general.
> 
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>

LGTM.
Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

> ---
>  scripts/lib/kdoc/kdoc_parser.py | 31 +++++++++++--------------------
>  1 file changed, 11 insertions(+), 20 deletions(-)
> 
> diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
> index 7191fa94e17a..fdde14b045fe 100644
> --- a/scripts/lib/kdoc/kdoc_parser.py
> +++ b/scripts/lib/kdoc/kdoc_parser.py
> @@ -42,9 +42,11 @@ doc_decl = doc_com + KernRe(r'(\w+)', cache=False)
>  #         @{section-name}:
>  # while trying to not match literal block starts like "example::"
>  #
> +known_section_names = 'description|context|returns?|notes?|examples?'
> +known_sections = KernRe(known_section_names, flags = re.I)
>  doc_sect = doc_com + \
> -            KernRe(r'\s*(\@[.\w]+|\@\.\.\.|description|context|returns?|notes?|examples?)\s*:([^:].*)?$',
> -                flags=re.I, cache=False)
> +    KernRe(r'\s*(\@[.\w]+|\@\.\.\.|' + known_section_names + r')\s*:([^:].*)?$',
> +           flags=re.I, cache=False)
>  
>  doc_content = doc_com_body + KernRe(r'(.*)', cache=False)
>  doc_inline_start = KernRe(r'^\s*/\*\*\s*$', cache=False)
> @@ -115,7 +117,6 @@ class KernelEntry:
>          self.config = config
>  
>          self._contents = []
> -        self.sectcheck = ""
>          self.prototype = ""
>  
>          self.warnings = []
> @@ -187,7 +188,6 @@ class KernelEntry:
>              self.parameterdescs[name] = contents
>              self.parameterdesc_start_lines[name] = self.new_start_line
>  
> -            self.sectcheck += name + " "
>              self.new_start_line = 0
>  
>          else:
> @@ -478,29 +478,20 @@ class KernelDoc:
>                          self.push_parameter(ln, decl_type, param, dtype,
>                                              arg, declaration_name)
>  
> -    def check_sections(self, ln, decl_name, decl_type, sectcheck):
> +    def check_sections(self, ln, decl_name, decl_type):
>          """
>          Check for errors inside sections, emitting warnings if not found
>          parameters are described.
>          """
> -
> -        sects = sectcheck.split()
> -
> -        for sx in range(len(sects)):                  # pylint: disable=C0200
> -            err = True
> -            for param in self.entry.parameterlist:
> -                if param == sects[sx]:
> -                    err = False
> -                    break
> -
> -            if err:
> +        for section in self.entry.sections:
> +            if section not in self.entry.parameterlist and \
> +               not known_sections.search(section):
>                  if decl_type == 'function':
>                      dname = f"{decl_type} parameter"
>                  else:
>                      dname = f"{decl_type} member"
> -
>                  self.emit_msg(ln,
> -                              f"Excess {dname} '{sects[sx]}' description in '{decl_name}'")
> +                              f"Excess {dname} '{section}' description in '{decl_name}'")
>  
>      def check_return_section(self, ln, declaration_name, return_type):
>          """
> @@ -754,7 +745,7 @@ class KernelDoc:
>  
>          self.create_parameter_list(ln, decl_type, members, ';',
>                                     declaration_name)
> -        self.check_sections(ln, declaration_name, decl_type, self.entry.sectcheck)
> +        self.check_sections(ln, declaration_name, decl_type)
>  
>          # Adjust declaration for better display
>          declaration = KernRe(r'([\{;])').sub(r'\1\n', declaration)
> @@ -1018,7 +1009,7 @@ class KernelDoc:
>                            f"expecting prototype for {self.entry.identifier}(). Prototype was for {declaration_name}() instead")
>              return
>  
> -        self.check_sections(ln, declaration_name, "function", self.entry.sectcheck)
> +        self.check_sections(ln, declaration_name, "function")
>  
>          self.check_return_section(ln, declaration_name, return_type)
>  



Thanks,
Mauro

