Return-Path: <linux-kernel+bounces-770198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBAAB2785D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 07:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C056B60F22
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 05:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF5724EA8D;
	Fri, 15 Aug 2025 05:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tFFcuCjN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2ADF23ABAF;
	Fri, 15 Aug 2025 05:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755235343; cv=none; b=Z9pfD1V85fEN4N4q+pTYCkHa3zjD/os1WYzNgkE0ZwM7kvYbUIfRYCBNf3LuReDMQ/urG2LEr+f26AInniBDDYcvqzVaAPNvaxfeuy0h6ZBWfumDKnnU1ztwznRorGUGuqHRwnIWamAZaTQe7o0Ke/dYhJwbWQnt56+LvVESRPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755235343; c=relaxed/simple;
	bh=24WP+n4nQNz5wuc3FXW6b3EmG0++IqSdStKZtqhE0Jw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DZK7n93MhKp7WoUYPiJmqOIJ8+q4sKmAhwOAfav3Vzf+wuQU09gt/7V6bVI8vZV58MC8J54gkLtVLD7gHqry/EIS04PXWro+ow9SAV+4w5METg7Xrq53KuVfFU7FqzNnc8rDLPlsSedJt0ACLStwGOHZ1NVjXY5qPzJOeOGn9xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tFFcuCjN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 580DAC4CEEB;
	Fri, 15 Aug 2025 05:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755235342;
	bh=24WP+n4nQNz5wuc3FXW6b3EmG0++IqSdStKZtqhE0Jw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tFFcuCjNbXhzqBoF3ireNCTrx3PtNNkETxKOwdfvddw6thKRbz8gre6dBnT9R11CS
	 nwEuFiJtGQYoRP81N27rvsaen3s+Kb2q2/dbM7M8979ukaF1dXzwt/097E9Vs0suWt
	 wqRlIDxiesm5NAZzxx1AEJOff3mueVPYAt4bcdtk9Mk6aGQxZd3bNCgn4mkBBVVx2K
	 7jb1XedZ5QdcDwjg6JlVbWWpg8CbLoA8czSYsw9DnWRjonkxj7bvpUO6U5mvZs01Ys
	 ieQuQ7A7Nb0PHhjcqt7Ly8HWzEpMfaEv2dNrQe8PcIy/DoBMoczdRAM5K5Ze5YkQgU
	 sTYbSaDFU80VQ==
Date: Fri, 15 Aug 2025 07:22:18 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>
Subject: Re: [PATCH v2 5/7] docs: kdoc: tighten up the array-of-pointers
 case
Message-ID: <20250815072218.297083c7@foz.lan>
In-Reply-To: <20250814154035.328769-6-corbet@lwn.net>
References: <20250814154035.328769-1-corbet@lwn.net>
	<20250814154035.328769-6-corbet@lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Thu, 14 Aug 2025 09:40:33 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> Simplify one gnarly regex and remove another altogether; add a comment
> describing what is going on.  There will be no #-substituted commas in this
> case, so don't bother trying to put them back.
> 
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>

LGTM.

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

> ---
>  scripts/lib/kdoc/kdoc_parser.py | 20 +++++++++-----------
>  1 file changed, 9 insertions(+), 11 deletions(-)
> 
> diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
> index 29881757bf1c..7f4d95dd47d4 100644
> --- a/scripts/lib/kdoc/kdoc_parser.py
> +++ b/scripts/lib/kdoc/kdoc_parser.py
> @@ -527,23 +527,21 @@ class KernelDoc:
>                  dtype = KernRe(r'([^\(]+\(\*?)\s*' + re.escape(param)).sub(r'\1', arg)
>                  self.push_parameter(ln, decl_type, param, dtype,
>                                      arg, declaration_name)
> -
> +            #
> +            # The array-of-pointers case.  Dig the parameter name out from the middle
> +            # of the declaration.
> +            #
>              elif KernRe(r'\(.+\)\s*\[').search(arg):
> -                # Array-of-pointers
> -
> -                arg = arg.replace('#', ',')
> -                r = KernRe(r'[^\(]+\(\s*\*\s*([\w\[\].]*?)\s*(\s*\[\s*[\w]+\s*\]\s*)*\)')
> +                r = KernRe(r'[^\(]+\(\s*\*\s*'		# Up to "(" and maybe "*"
> +                           r'([\w.]*?)'			# The actual pointer name
> +                           r'\s*(\[\s*\w+\s*\]\s*)*\)') # The [array portion]
>                  if r.match(arg):
>                      param = r.group(1)
>                  else:
>                      self.emit_msg(ln, f"Invalid param: {arg}")
>                      param = arg
> -
> -                dtype = KernRe(r'([^\(]+\(\*?)\s*' + re.escape(param)).sub(r'\1', arg)
> -
> -                self.push_parameter(ln, decl_type, param, dtype,
> -                                    arg, declaration_name)
> -
> +                dtype = arg.replace(param, '')
> +                self.push_parameter(ln, decl_type, param, dtype, arg, declaration_name)
>              elif arg:
>                  #
>                  # Clean up extraneous spaces and split the string at commas; the first



Thanks,
Mauro

