Return-Path: <linux-kernel+bounces-724989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1BCAFF97A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 08:16:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F025188411D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 06:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5973B28467A;
	Thu, 10 Jul 2025 06:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hBj9LBU3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A761227E7E3;
	Thu, 10 Jul 2025 06:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752127906; cv=none; b=XVkbpovHD7Zan69C0EY8e3gg3u3032hSrLXiW4WUR9P0jqCK5AERiNrYkliWj7l9HnlpMnejjuWitg7Ik5eQgtYjJhctXEXBSTZBLFVZE8eaVb1HUyRDrpGTJrWP6OMWF05F7RzhM8KxQvEnHIm+fSAWwBhnbLww/UW4SEomM48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752127906; c=relaxed/simple;
	bh=tMPabmKD0JK7+IpTuXx4qCd6dUyhKddFB+y9Wu6acEU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CMpQhBfDjt+8ceJflTvGcdUmf6J09L3fYwNBpv4soasvZwWkgC2QVbbHez6Hw8ISyFE9/LjqtJoAECUJ8u4U9NAEi/EflCxKWzP+EvqwuPq8DhcJ66LnncaQ99AoPRzlG1L6/HsceOjIdAih2RFi6kJSu2Sl52el/4ghiGjPZCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hBj9LBU3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29BF5C4CEE3;
	Thu, 10 Jul 2025 06:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752127906;
	bh=tMPabmKD0JK7+IpTuXx4qCd6dUyhKddFB+y9Wu6acEU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hBj9LBU3S9R/vLez3ADcBUAO6XoLlXxGRA5TYFGqb8j3pZx2gVsLSNwbui0pDmfMi
	 FdcDDNxb2ZTnwhmheqKMMd/SD29q7sjcCgqeoh/MoC5HDsTTc5zowO6ER627pcRb3e
	 Nbh7ffFZ6X3TBmu09kqGwTdGy3IawdsMlvKXxnS11DBse9UbrTVq44RBq0svZpWoO+
	 XncTwg0C50VMKAk6OGSD3OAjl117qxhcKuDDFAi3+pBCbrB1nG5Zew8CosPpL8AyPR
	 qwL76jfHlWrs0IONADvy4BA3X8sk+4qKbTrH7vqtCTfS8R6ONEw7aP96RXrYXI+Gxl
	 5kmQ7Sa2JQ6Sw==
Date: Thu, 10 Jul 2025 08:11:42 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>
Subject: Re: [PATCH 05/12] docs: kdoc: remove the "struct_actual" machinery
Message-ID: <20250710081142.0b0102ca@foz.lan>
In-Reply-To: <20250702223524.231794-6-corbet@lwn.net>
References: <20250702223524.231794-1-corbet@lwn.net>
	<20250702223524.231794-6-corbet@lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Wed,  2 Jul 2025 16:35:17 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> The code goes out of its way to create a special list of parameters in
> entry.struct_actual that is just like entry.parameterlist, but with extra
> junk.  The only use of that information, in check_sections(), promptly
> strips all the extra junk back out.  Drop all that extra work and just use
> parameterlist.
> 
> No output changes.

LGTM.

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

> 
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> ---
>  scripts/lib/kdoc/kdoc_parser.py | 32 ++------------------------------
>  1 file changed, 2 insertions(+), 30 deletions(-)
> 
> diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
> index 608f3a1045dc..b28f056365cb 100644
> --- a/scripts/lib/kdoc/kdoc_parser.py
> +++ b/scripts/lib/kdoc/kdoc_parser.py
> @@ -116,7 +116,6 @@ class KernelEntry:
>  
>          self._contents = []
>          self.sectcheck = ""
> -        self.struct_actual = ""
>          self.prototype = ""
>  
>          self.warnings = []
> @@ -366,15 +365,6 @@ class KernelDoc:
>          org_arg = KernRe(r'\s\s+').sub(' ', org_arg)
>          self.entry.parametertypes[param] = org_arg
>  
> -    def save_struct_actual(self, actual):
> -        """
> -        Strip all spaces from the actual param so that it looks like
> -        one string item.
> -        """
> -
> -        actual = KernRe(r'\s*').sub("", actual, count=1)
> -
> -        self.entry.struct_actual += actual + " "
>  
>      def create_parameter_list(self, ln, decl_type, args,
>                                splitter, declaration_name):
> @@ -420,7 +410,6 @@ class KernelDoc:
>                      param = arg
>  
>                  dtype = KernRe(r'([^\(]+\(\*?)\s*' + re.escape(param)).sub(r'\1', arg)
> -                self.save_struct_actual(param)
>                  self.push_parameter(ln, decl_type, param, dtype,
>                                      arg, declaration_name)
>  
> @@ -437,7 +426,6 @@ class KernelDoc:
>  
>                  dtype = KernRe(r'([^\(]+\(\*?)\s*' + re.escape(param)).sub(r'\1', arg)
>  
> -                self.save_struct_actual(param)
>                  self.push_parameter(ln, decl_type, param, dtype,
>                                      arg, declaration_name)
>  
> @@ -470,7 +458,6 @@ class KernelDoc:
>  
>                          param = r.group(1)
>  
> -                        self.save_struct_actual(r.group(2))
>                          self.push_parameter(ln, decl_type, r.group(2),
>                                              f"{dtype} {r.group(1)}",
>                                              arg, declaration_name)
> @@ -482,12 +469,10 @@ class KernelDoc:
>                              continue
>  
>                          if dtype != "":  # Skip unnamed bit-fields
> -                            self.save_struct_actual(r.group(1))
>                              self.push_parameter(ln, decl_type, r.group(1),
>                                                  f"{dtype}:{r.group(2)}",
>                                                  arg, declaration_name)
>                      else:
> -                        self.save_struct_actual(param)
>                          self.push_parameter(ln, decl_type, param, dtype,
>                                              arg, declaration_name)
>  
> @@ -499,24 +484,11 @@ class KernelDoc:
>  
>          sects = sectcheck.split()
>          prms = prmscheck.split()
> -        err = False
>  
>          for sx in range(len(sects)):                  # pylint: disable=C0200
>              err = True
>              for px in range(len(prms)):               # pylint: disable=C0200
> -                prm_clean = prms[px]
> -                prm_clean = KernRe(r'\[.*\]').sub('', prm_clean)
> -                prm_clean = attribute.sub('', prm_clean)
> -
> -                # ignore array size in a parameter string;
> -                # however, the original param string may contain
> -                # spaces, e.g.:  addr[6 + 2]
> -                # and this appears in @prms as "addr[6" since the
> -                # parameter list is split at spaces;
> -                # hence just ignore "[..." for the sections check;
> -                prm_clean = KernRe(r'\[.*').sub('', prm_clean)
> -
> -                if prm_clean == sects[sx]:
> +                if prms[px] == sects[sx]:
>                      err = False
>                      break
>  
> @@ -782,7 +754,7 @@ class KernelDoc:
>          self.create_parameter_list(ln, decl_type, members, ';',
>                                     declaration_name)
>          self.check_sections(ln, declaration_name, decl_type,
> -                            self.entry.sectcheck, self.entry.struct_actual)
> +                            self.entry.sectcheck, ' '.join(self.entry.parameterlist))
>  
>          # Adjust declaration for better display
>          declaration = KernRe(r'([\{;])').sub(r'\1\n', declaration)



Thanks,
Mauro

