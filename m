Return-Path: <linux-kernel+bounces-771393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8048B28664
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 21:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50A993B0609
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 19:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8EA276049;
	Fri, 15 Aug 2025 19:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F/19KR41"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051F118FC91
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 19:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755286075; cv=none; b=uomvZB7RIEgDTS0F5UBTBxbKvp/bQKC0LKiXVluYimETstyy3CcoSOQFMAAN9lU68LEvTzdwKmXtOpBL49ApcYQjoBU4W0r6opEujAnWOifFTtF5pR2K35EEc/nHTFaIViaGM1OC4rlduPbJK2b+Y+KdBLiQrIOHdNC3PL6mjpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755286075; c=relaxed/simple;
	bh=dm9hGRQRuU3Ti61KlLjxam3MN99K/XV9ylHs6j08/Mo=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=K3a4XgHFZlWOj03sy/iYz7FyAsd/VNa42ro8p+rXiN9j4EXeonexNw7qAKL3xo2DxyjiXrZ1MoI5vJnoNskM+WLoRFtwP4Hi7DmpVTtgVb/etf/ADY7Afw+LtC9WZgpkeTyhrdWZmtQfgKIcV02KnRaAPyCFLXS1mhUmypOlCWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F/19KR41; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C228CC4CEEB;
	Fri, 15 Aug 2025 19:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755286074;
	bh=dm9hGRQRuU3Ti61KlLjxam3MN99K/XV9ylHs6j08/Mo=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=F/19KR41w+KuAPKXxMLrfZZRYJyND95hDItIfiduIAqJG0OoBvI790PweQcnsTcyT
	 EH5AQAjZVX4qBNoXQ1n89tUI4CoIoZqbH4sBbLhhtsVJq+DGS0pUkjJ68XPuG+VJaC
	 YR4gyfaFduYM3xYUaiiKyWA7Ty0Q0zqVWm8WUgYnrR9Ts4Q+XfhhpH4vpboJb8g5Hs
	 aSv9IAvtZTu2oLeXtP8Xsc5ABZxsDbwUYvyT6H04DVIL1QBuSkGvL1rIvEjRPgDuVF
	 a763Mr6va+Y4UZ27SZ2btpSUM14tWe/v0wpR+e++UkliyWo2Tc+nz7KJTGX6LinS5H
	 T2RiqM/Ga8Lgg==
Date: Fri, 15 Aug 2025 12:27:51 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: Juergen Gross <jgross@suse.com>
cc: linux-kernel@vger.kernel.org, Stefano Stabellini <sstabellini@kernel.org>, 
    Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, 
    xen-devel@lists.xenproject.org
Subject: Re: [PATCH] drivers/xen/xenbus: remove quirk for Xen 3.x
In-Reply-To: <20250815074052.13792-1-jgross@suse.com>
Message-ID: <alpine.DEB.2.22.394.2508151227420.10166@ubuntu-linux-20-04-desktop>
References: <20250815074052.13792-1-jgross@suse.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 15 Aug 2025, Juergen Gross wrote:
> The kernel is not supported to run as a Xen guest on Xen versions
> older than 4.0.
> 
> Remove xen_strict_xenbus_quirk() which is testing the Xen version to be
> at least 4.0.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>

Acked-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
>  drivers/xen/xenbus/xenbus_xs.c | 23 -----------------------
>  1 file changed, 23 deletions(-)
> 
> diff --git a/drivers/xen/xenbus/xenbus_xs.c b/drivers/xen/xenbus/xenbus_xs.c
> index 3c9da446b85d..528682bf0c7f 100644
> --- a/drivers/xen/xenbus/xenbus_xs.c
> +++ b/drivers/xen/xenbus/xenbus_xs.c
> @@ -718,26 +718,6 @@ int xs_watch_msg(struct xs_watch_event *event)
>  	return 0;
>  }
>  
> -/*
> - * Certain older XenBus toolstack cannot handle reading values that are
> - * not populated. Some Xen 3.4 installation are incapable of doing this
> - * so if we are running on anything older than 4 do not attempt to read
> - * control/platform-feature-xs_reset_watches.
> - */
> -static bool xen_strict_xenbus_quirk(void)
> -{
> -#ifdef CONFIG_X86
> -	uint32_t eax, ebx, ecx, edx, base;
> -
> -	base = xen_cpuid_base();
> -	cpuid(base + 1, &eax, &ebx, &ecx, &edx);
> -
> -	if ((eax >> 16) < 4)
> -		return true;
> -#endif
> -	return false;
> -
> -}
>  static void xs_reset_watches(void)
>  {
>  	int err;
> @@ -745,9 +725,6 @@ static void xs_reset_watches(void)
>  	if (!xen_hvm_domain() || xen_initial_domain())
>  		return;
>  
> -	if (xen_strict_xenbus_quirk())
> -		return;
> -
>  	if (!xenbus_read_unsigned("control",
>  				  "platform-feature-xs_reset_watches", 0))
>  		return;
> -- 
> 2.43.0
> 

