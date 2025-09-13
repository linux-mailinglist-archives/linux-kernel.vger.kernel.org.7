Return-Path: <linux-kernel+bounces-815369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C238B56358
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 23:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD8C9189EFD5
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 21:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF258283130;
	Sat, 13 Sep 2025 21:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="x5RHNGv6"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7248280334;
	Sat, 13 Sep 2025 21:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757799626; cv=none; b=BgzCC7hrt3NxcPgAX7FHsnE176o4ulxwlGJXF5ikEdGeoJQLfVSNWhS6IW1E4IdD6492YacNDKDlyfX6QI9XERHG8zBaZ1g7PzHMlYkaXS0lv0OTvyvw8bXIXyFKOp6zmgIVthOYc39IP1vhT2SaL6rTORiBn1vNQ6shqjtO6Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757799626; c=relaxed/simple;
	bh=PXuEdQp+sPuuU3k/AUeTzWmC1/zgVchKaMJ7e0y0pdI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DYR5UTcHWQDj5Y89q94O92J4uGoKIo+7QVeH+AIybOtxxg8Sk6dQVsfEs8SZOy1CQKLDaqxp3gIgcjhBp18hZUkh9/QsHdqKT5w5eJcBgLitv8eWuzqrhA0mfZ/dUxNucBSymHL8w8EoewIxMAosKSysNljM2f6AfiSpOpmBEJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=x5RHNGv6; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=DesQCvhIPbsAoNe4dQegXKB46nbZTJPZCdl6OnyhbYg=; b=x5RHNGv6Y1E6KoT1atLQ6pZXTJ
	5otAxcpEIpKbGuN5V+/FZIElS7mbgIkNrQqsoL5B1qCxGjMLaPRx8bJ26AcUAyjuvA4+NF4I8LiQx
	f8KO5kcOnEDxUikD/gS/pHMaRenJFysnayX70WTlKSqxUZe9Q4UVL7GXPssRo8sVHyzGR9RGnf0r6
	4HQ2k3NbR6IIM1cRvKl01irhKHlG96i3yBJ/OEbAeCnDlSNMDsTZuDPlt1hgLkqavVTkNfY6DGre7
	r9HgaZqqtfEqVteM4U6UUQ9oY+2SBKKaw2JRtgw9+6N4diQCciXyN54ThBLJkW03G/mgAZQ7T9oW5
	Lz5ba0vA==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxXyn-0000000GP4t-0l68;
	Sat, 13 Sep 2025 21:40:21 +0000
Message-ID: <61249b3d-3996-4d9f-814b-3794aa42c40b@infradead.org>
Date: Sat, 13 Sep 2025 14:40:20 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: process: Do not hardcode kernel major
 version number
To: Bagas Sanjaya <bagasdotme@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Linux Kernel Workflows <workflows@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Dante Strock <dantestrock@hotmail.com>
References: <20250913015147.9544-1-bagasdotme@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250913015147.9544-1-bagasdotme@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/12/25 6:51 PM, Bagas Sanjaya wrote:
> The big picture section of 2.Process.rst currently hardcodes major
> version number to 5 since fb0e0ffe7fc8e0 ("Documentation: bring process
> docs up to date"). As it can get outdated when it is actually
> incremented (the recent is 6 and will be 7 in the near future), replace
> it with the placeholder.
> 
> Note that the version number examples are kept to illustrate the
> numbering scheme.
> 
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  Documentation/process/2.Process.rst | 40 ++++++++++++-----------------
>  1 file changed, 17 insertions(+), 23 deletions(-)
> 
> diff --git a/Documentation/process/2.Process.rst b/Documentation/process/2.Process.rst
> index ef3b116492df08..668d5559ded039 100644
> --- a/Documentation/process/2.Process.rst
> +++ b/Documentation/process/2.Process.rst
> @@ -13,24 +13,18 @@ how the process works is required in order to be an effective part of it.
>  The big picture
>  ---------------
>  
> -The kernel developers use a loosely time-based release process, with a new
> -major kernel release happening every two or three months.  The recent
> -release history looks like this:
> +Linux kernel uses a loosely time-based, rolling release development model.

   The Linux kernel

> +A new major kernel release (a.x) [1]_ happens every two or three monts, which

I'm much more used to x.y                                           months,

> +comes with new features, internal API changes, and more. A typical release
> +can contain about 13,000 changesets with changes to several hundred thousand
> +lines of code. Recent releases, along with their dates, can be found at
> +`Wikipedia <https://en.wikipedia.org/wiki/Linux_kernel_version_history>`_.
>  
> -	======  =================
> -	5.0	March 3, 2019
> -	5.1	May 5, 2019
> -	5.2	July 7, 2019
> -	5.3	September 15, 2019
> -	5.4	November 24, 2019
> -	5.5	January 6, 2020
> -	======  =================
> -
> -Every 5.x release is a major kernel release with new features, internal
> -API changes, and more.  A typical release can contain about 13,000
> -changesets with changes to several hundred thousand lines of code.  5.x is
> -the leading edge of Linux kernel development; the kernel uses a
> -rolling development model which is continually integrating major changes.
> +.. [1] Strictly speaking, Linux kernel do not use semantic versioning

                             the Linux kernel does not

> +       number scheme, but rather a.x pair identifies major release

x.y ?
m.n ?
                             rather the a.x

> +       version as a whole number. For each release, x is incremented,
> +       but a is incremented only if x is deemed large enough (e.g.
> +       Linux 5.0 is released following Linux 4.20).
>  
>  A relatively straightforward discipline is followed with regard to the
>  merging of patches for each release.  At the beginning of each development
> @@ -48,9 +42,9 @@ detail later on).
>  
>  The merge window lasts for approximately two weeks.  At the end of this
>  time, Linus Torvalds will declare that the window is closed and release the
> -first of the "rc" kernels.  For the kernel which is destined to be 5.6,
> +first of the "rc" kernels.  For the kernel which is destined to be a.x,
>  for example, the release which happens at the end of the merge window will
> -be called 5.6-rc1.  The -rc1 release is the signal that the time to
> +be called a.x-rc1.  The -rc1 release is the signal that the time to
>  merge new features has passed, and that the time to stabilize the next
>  kernel has begun.
>  
> @@ -99,13 +93,13 @@ release is made.  In the real world, this kind of perfection is hard to
>  achieve; there are just too many variables in a project of this size.
>  There comes a point where delaying the final release just makes the problem
>  worse; the pile of changes waiting for the next merge window will grow
> -larger, creating even more regressions the next time around.  So most 5.x
> -kernels go out with a handful of known regressions though, hopefully, none
> -of them are serious.
> +larger, creating even more regressions the next time around.  So most kernels
> +go out with a handful of known regressions though, hopefully, none of them

I would add another comma:        regressions,

> +are serious.
>  
>  Once a stable release is made, its ongoing maintenance is passed off to the
>  "stable team," currently Greg Kroah-Hartman. The stable team will release

and Sasha Levin:
STABLE BRANCH
M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
M:	Sasha Levin <sashal@kernel.org>

> -occasional updates to the stable release using the 5.x.y numbering scheme.
> +occasional updates to the stable release using the a.x.y numbering scheme.
>  To be considered for an update release, a patch must (1) fix a significant
>  bug, and (2) already be merged into the mainline for the next development
>  kernel. Kernels will typically receive stable updates for a little more
> 
> base-commit: f44a29784f685804d9970cfb0d3439c9e30981d7

thanks.
-- 
~Randy


