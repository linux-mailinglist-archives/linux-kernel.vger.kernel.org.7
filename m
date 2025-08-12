Return-Path: <linux-kernel+bounces-765652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA38B23BF4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 00:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC7E01AA00A0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 22:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595FE2D0622;
	Tue, 12 Aug 2025 22:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q9stgKG0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FD31A9F9A;
	Tue, 12 Aug 2025 22:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755038346; cv=none; b=bIWg+l/27R5CQ1n/YfCKkSY+jDlqUsoM4lLULsKqB/LnuKdG+7NI9wev+mwkLBhoLz7GEZ3cF/G6ZypdC0ukRt4zJsZOWOKN2svJDcXm0Wa9ZjJP8nGtZ4zZkJjYMdL9AHlI2By1kdw0ryrG7yF0FX3cZGfzfW3uD1Hm11h1GgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755038346; c=relaxed/simple;
	bh=zBLOdm+92gEjPKvOs7yrSjtIDseJ9HloWYSWxpDP+AQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kSjJaQ9pm9UJoQBjlUjXOoZalluqN8L/kXVl29iaxceVbdsSbE+vhmi7ns/A0rQJXZ4WJFA63898CH7DH3fisTaqdLQuWOFQU1VG9QZN9C07YOR66/8QX/iEvF88gIM20TeEXA0K9lvhG1oIdSPELeSaKmNTGBS7yvEfX+9Qzco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q9stgKG0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FCC1C4CEF0;
	Tue, 12 Aug 2025 22:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755038346;
	bh=zBLOdm+92gEjPKvOs7yrSjtIDseJ9HloWYSWxpDP+AQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Q9stgKG02jgzChio9R11ImFMLmJWPrCcFBIaQgPV/DOLd2FkDaVSiFs5N64KzHiC2
	 HQKKXCrRCFPxZsBqSdeK2vRGSXL0juE8zchC/W40Kn3rWLHKvwSpB5+55WPHeeYlhK
	 3NIev4fnjUn1PRtbY+j+RIcmBkINRZdotSA0zYeYT01qjYrb9fQJolOBCph6w95Qlf
	 py9N68whkQVZH9+Efc9Na+9+vl7fxsaF8oZjzbWNG8vEaMt8I9MzB8LdFI1cVKOvA3
	 xJ9FLFKpKx2tRFDxLg72iZ1DzaV9HwfWB6YFc44860QbefIlwp80RPGqz9wZ0v5Rkw
	 Z13p/5/hrRaTg==
Date: Wed, 13 Aug 2025 00:39:02 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>
Subject: Re: [PATCH 6/7] docs: kdoc: tighten up the pointer-to-function case
Message-ID: <20250813003902.2fc82b54@foz.lan>
In-Reply-To: <20250812195748.124402-7-corbet@lwn.net>
References: <20250812195748.124402-1-corbet@lwn.net>
	<20250812195748.124402-7-corbet@lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Aug 2025 13:57:47 -0600
Jonathan Corbet <corbet@lwn.net> wrote:

> Tighten up the code and remove an unneeded regex operation.
> 
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> ---
>  scripts/lib/kdoc/kdoc_parser.py | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
> index d7fb79a64487..ceb38b59fb4c 100644
> --- a/scripts/lib/kdoc/kdoc_parser.py
> +++ b/scripts/lib/kdoc/kdoc_parser.py
> @@ -511,22 +511,19 @@ class KernelDoc:
>                  # Treat preprocessor directive as a typeless variable
>                  self.push_parameter(ln, decl_type, arg, "",
>                                      "", declaration_name)
> -
> +            #
> +            # The pointer-to-function case.
> +            #
>              elif KernRe(r'\(.+\)\s*\(').search(arg):
> -                # Pointer-to-function
> -
>                  arg = arg.replace('#', ',')
> -
> -                r = KernRe(r'[^\(]+\(\*?\s*([\w\[\].]*)\s*\)')
> +                r = KernRe(r'[^\(]+\(\*?\s*' r'([\w\[\].]*)' r'\s*\)')

Heh, it took me a couple of seconds to understand this concat, as I haven't
seem concat pattern like that before (maybe except for some old C book
I read a millennium ago that I barely remember).  So, IMO, it became harder
to understand this way. I would either remove the extra two ' r' from the
string or write it as:

               r = KernRe(r'[^\(]+\(\*?\s*' 
			  r'([\w\[\].]*)'
			  r'\s*\)')

Eventually adding a comment for the capture group. 

With that, feel free to add:

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

>                  if r.match(arg):
>                      param = r.group(1)
>                  else:
>                      self.emit_msg(ln, f"Invalid param: {arg}")
>                      param = arg
> -
> -                dtype = KernRe(r'([^\(]+\(\*?)\s*' + re.escape(param)).sub(r'\1', arg)
> -                self.push_parameter(ln, decl_type, param, dtype,
> -                                    arg, declaration_name)
> +                dtype = arg.replace(param, '')

Nice cleanup. 

> +                self.push_parameter(ln, decl_type, param, dtype, arg, declaration_name)
>              #
>              # The array-of-pointers case.  Dig the parameter name out from the middle
>              # of the declaration.



Thanks,
Mauro

