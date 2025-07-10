Return-Path: <linux-kernel+bounces-724990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 620A0AFF989
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 08:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED601585A8F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 06:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA24287278;
	Thu, 10 Jul 2025 06:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R0R+LxDM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90E727E7E3;
	Thu, 10 Jul 2025 06:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752127969; cv=none; b=sAzuWwnN1da3+IIP/Ll2U/58LdhVZTNwv4HPFqE0sb81g3fC0QHnTt1wLql8TVum2C55OiCq5z5q+LteCvaLvhk1zIuTvYd8K8i1fEa7464BhTw8NbKRyJfnYeis84hrTcAT2cYaMWFifFvwifOGrCfxKzV5aH6vL8xEgH4OCdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752127969; c=relaxed/simple;
	bh=FuAjb751TK5oePN9ryLflL1YZIS8AMNdO88i6bWOzz8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cn4aZIXhwmtAFkFa5/gEeQCSZUPWBGhla6wzR07Nz5s+UKMwtfQDwzyz/qh/UdkHMBQoAAguuDucgiwMbg8ZvHwy23iGlWnzUOAwDJhi3TV0VekeSeewmkCkVM5reqlttK/oubFc/yHS+jsDejlhwTJyxQp9e5U+mN1cYdYIhcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R0R+LxDM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D50AC4CEE3;
	Thu, 10 Jul 2025 06:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752127969;
	bh=FuAjb751TK5oePN9ryLflL1YZIS8AMNdO88i6bWOzz8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R0R+LxDMiGn0CVIwxkMi4TGMxsjoUtyYPeq72zXU+Uicynw2JLfxuJ2ppmYuSoHuw
	 MGVuT6c81lIhrN9R8HeXd8vQkl9UiEDpZz68c4sxYHzqLrhmHRAAQVgyyo0hpEZgQA
	 3vW4oIbC1UBMfb0JyOsoWVY/VXXccxpAdRwpDQ4AlTEfWpbJh/cGlKY3ZxkVMJ4CSY
	 6SS44Q2kYVBZ0hCFePiEOlZmNFfnf1yDA9aEAl/fRrfnOV+oLOOKYVdIaUjBYJN2mC
	 k15nIiXuFaTCyHJutLXC+CTh4jFGfJY/gNM9qIh2Wlg21kcgXdJgi0X5QVcR1D5DwM
	 N6Ho+XwT4n8iQ==
Date: Thu, 10 Jul 2025 08:12:45 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>
Subject: Re: [PATCH 06/12] docs: kdoc: use self.entry.parameterlist directly
 in check_sections()
Message-ID: <20250710081245.516339b0@foz.lan>
In-Reply-To: <20250702223524.231794-7-corbet@lwn.net>
References: <20250702223524.231794-1-corbet@lwn.net>
	<20250702223524.231794-7-corbet@lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Wed,  2 Jul 2025 16:35:18 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> Callers of check_sections() join parameterlist into a single string, which
> is then immediately split back into the original list.  Rather than do all
> that, just use parameterlist directly in check_sections().
> 
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>

LGTM.
Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

> ---
>  scripts/lib/kdoc/kdoc_parser.py | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
> index b28f056365cb..ffd49f9395ae 100644
> --- a/scripts/lib/kdoc/kdoc_parser.py
> +++ b/scripts/lib/kdoc/kdoc_parser.py
> @@ -476,19 +476,18 @@ class KernelDoc:
>                          self.push_parameter(ln, decl_type, param, dtype,
>                                              arg, declaration_name)
>  
> -    def check_sections(self, ln, decl_name, decl_type, sectcheck, prmscheck):
> +    def check_sections(self, ln, decl_name, decl_type, sectcheck):
>          """
>          Check for errors inside sections, emitting warnings if not found
>          parameters are described.
>          """
>  
>          sects = sectcheck.split()
> -        prms = prmscheck.split()
>  
>          for sx in range(len(sects)):                  # pylint: disable=C0200
>              err = True
> -            for px in range(len(prms)):               # pylint: disable=C0200
> -                if prms[px] == sects[sx]:
> +            for param in self.entry.parameterlist:
> +                if param == sects[sx]:
>                      err = False
>                      break
>  
> @@ -753,8 +752,7 @@ class KernelDoc:
>  
>          self.create_parameter_list(ln, decl_type, members, ';',
>                                     declaration_name)
> -        self.check_sections(ln, declaration_name, decl_type,
> -                            self.entry.sectcheck, ' '.join(self.entry.parameterlist))
> +        self.check_sections(ln, declaration_name, decl_type, self.entry.sectcheck)
>  
>          # Adjust declaration for better display
>          declaration = KernRe(r'([\{;])').sub(r'\1\n', declaration)
> @@ -1032,9 +1030,7 @@ class KernelDoc:
>                            f"expecting prototype for {self.entry.identifier}(). Prototype was for {declaration_name}() instead")
>              return
>  
> -        prms = " ".join(self.entry.parameterlist)
> -        self.check_sections(ln, declaration_name, "function",
> -                            self.entry.sectcheck, prms)
> +        self.check_sections(ln, declaration_name, "function", self.entry.sectcheck)
>  
>          self.check_return_section(ln, declaration_name, return_type)
>  



Thanks,
Mauro

