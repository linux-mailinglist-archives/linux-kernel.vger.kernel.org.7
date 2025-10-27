Return-Path: <linux-kernel+bounces-872591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB7FC1186E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 22:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 282474EC7CD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 21:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7944732A3C1;
	Mon, 27 Oct 2025 21:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nBl+hOJt"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0728A314A8D;
	Mon, 27 Oct 2025 21:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761599999; cv=none; b=aghSMD/d3sasozkGg2G5vfZ1JJrBsY4O7Nzm7ilNi2MiJ0ymRIfS7sTrkL1+DUDsB4dilgWAYv9P6es7R5oDD4mA3Hd8d9WjuFnIVyOVyybam2bIXXM8UJRr55AP/OO3+5JoVpxxz3s10zi6Ybr7HSP8wCyiwHQrxRucxEx6p5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761599999; c=relaxed/simple;
	bh=IaKAlAq36x6FQovo76KHJGi2+lwcn8LjsjjqBNZdne4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f32cqM9Az41qCLB78G/Dih5kLqcL3GXNdkX4QhKIE3UVCpmaG7q0wYB5y18pZyyhsM/jm3I90yJAQDImcfhC8UT9SeBrz/fr3StTJA4eS+YWBg6HejX9M8vYfZhfZYbSoiApr1SE744LtnA2gtUcZJC4y2y6Klrn+/wINYmMkHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nBl+hOJt; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=9Iv+ffZpjEZjAYosvgj1AxYfj8Ex0TWhrhWzH//VRvQ=; b=nBl+hOJtJiTxm7KhGiNJ/Q71dn
	T9DUH3zO9MGalAUW4ruw7kg0OdrzIJoDdR5Egq17KkEjUo0tdXIp3flaqD5ZKGjhqpn27Qj3/ehpC
	FcRYP6yofjDMNPd0VycSu6PaJurniVxvcYo43iWQwGpDDcxmPtmC0r+qqg7Yr7Im5R6RChjNTIgiK
	ALQ194/8LCHUjX8neIBt/tdRkr+/Q/7oXGoANAtNxkziBF8kayvNFYbj18ENYhlhGwQyvWm6NjncX
	zF7KHIvIlSlxpiNZjeqmh+u5aOh7Jpv65BFnJUYly7U53K4m71Ks6rj+6tSlu6hVGtbHxC9bSLNCz
	OAkFcj5g==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDUd8-0000000EmzQ-37s7;
	Mon, 27 Oct 2025 21:19:54 +0000
Message-ID: <09faee6c-4075-4eb7-bb2b-1c6650e3f053@infradead.org>
Date: Mon, 27 Oct 2025 14:19:54 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 01/30] docs: reporting-issues: mention text is best
 viewed rendered
To: Thorsten Leemhuis <linux@leemhuis.info>, Jonathan Corbet <corbet@lwn.net>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 regressions@lists.linux.dev, linux-kernel@vger.kernel.org
References: <cover.1761481839.git.linux@leemhuis.info>
 <4f7e2de2a2336c52e55cc49dcda627a4e86b8793.1761481839.git.linux@leemhuis.info>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <4f7e2de2a2336c52e55cc49dcda627a4e86b8793.1761481839.git.linux@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/26/25 5:41 AM, Thorsten Leemhuis wrote:
> Add a comment before the step-by-step guide explaining that the document
> is best viewed in the rendered form, as there the internal links will
> work that later patches will add.
> 
> While at it change the double quotes in the license hint at the end of
> the document into single quotes, which is the preferred style.
> 
> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
> ---
>  Documentation/admin-guide/reporting-issues.rst | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/admin-guide/reporting-issues.rst b/Documentation/admin-guide/reporting-issues.rst
> index a68e6d90927471..3bc47afaf85ea0 100644
> --- a/Documentation/admin-guide/reporting-issues.rst
> +++ b/Documentation/admin-guide/reporting-issues.rst
> @@ -48,6 +48,16 @@ Once the report is out, answer any questions that come up and help where you
>  can. That includes keeping the ball rolling by occasionally retesting with newer
>  releases and sending a status update afterwards.
>  
> +..
> +   Note: If you see this note, you are reading the text's source file. You
> +   might want to switch to a rendered version: It makes it a lot easier to
> +   read and navigate this document -- especially when you want to look something
> +   up in the reference section, then jump back to where you left off.
> +..
> +   Find the latest rendered version of this text here:
> +   https://docs.kernel.org/admin-guide/reporting-issues.html
> +
> +
>  Step-by-step guide how to report issues to the kernel maintainers
>  =================================================================
>  
> @@ -1748,13 +1758,13 @@ art will lay some groundwork to improve the situation over time.
>     you spot a typo or small mistake, feel free to let him know directly and
>     he'll fix it. You are free to do the same in a mostly informal way if you
>     want to contribute changes to the text, but for copyright reasons please CC
> -   linux-doc@vger.kernel.org and "sign-off" your contribution as
> -   Documentation/process/submitting-patches.rst outlines in the section "Sign
> -   your work - the Developer's Certificate of Origin".
> +   linux-doc@vger.kernel.org and 'sign-off' your contribution as
> +   Documentation/process/submitting-patches.rst outlines in the section 'Sign
> +   your work - the Developer's Certificate of Origin'.

Can you have a single quote (Developer's) inside single quotes?
Anyway, nack on the quote marks changes.

>  ..
>     This text is available under GPL-2.0+ or CC-BY-4.0, as stated at the top
>     of the file. If you want to distribute this text under CC-BY-4.0 only,
> -   please use "The Linux kernel developers" for author attribution and link
> +   please use 'The Linux kernel developers' for author attribution and link
>     this as source:
>     https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/Documentation/admin-guide/reporting-issues.rst
>  ..

-- 
~Randy


