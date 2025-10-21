Return-Path: <linux-kernel+bounces-862880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFC1BF66D9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 14:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0CCCF3557EC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D66432ED37;
	Tue, 21 Oct 2025 12:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V+24LYlZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA681624DF;
	Tue, 21 Oct 2025 12:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761049490; cv=none; b=uFVo3Sv3uyg2tC/4Slw7vkeqlr5gp63XSukzaCd2fWhACu4e4AvkHCcPP0YydJRk0mhdf/T5Jh9Up5WuyClWrM67mo03/43oiNtLdYTdEOBms9l9ULy80R5qBG0nMPDJuPhfi2IaLuOOuTt6o/GJSAbrv07tYgnFCmJ7aeF5UMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761049490; c=relaxed/simple;
	bh=WTwCxXhyf3l6LHnurbDVNOc2H94EiEBW7MvtPFkctKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nb2tSXzQiLtlWYv9WRr966cXswaEAYhk0MTayZChn/vRd9HVIw4iZQAKiNOpUtfmyGOJbpRB+uYjXhzlGjlWdHtaVVjiYYlQptHwrLthtxWawy8syODEG1FbvqYYBmIFgb7U8L5nW/0RQubHrY8LVbeUEwi/NxefULHDYu24owY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V+24LYlZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7393C4CEF1;
	Tue, 21 Oct 2025 12:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761049490;
	bh=WTwCxXhyf3l6LHnurbDVNOc2H94EiEBW7MvtPFkctKI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V+24LYlZPV06a4J85K5fAD/qI7DbdEKC3xQf1BUZG1qbco28dYO/tLSm7Q8g144Vi
	 ldK38HrQR9hrPzB5pZv3wrMcwZmVfnXx4lb3g1wXH3maNBveyfiTatayzaXUuir/+A
	 9MB89714EsWvM2qC4EmTaibD9FII3NZvXvZGA1Ro=
Date: Tue, 21 Oct 2025 14:24:47 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Olle Lukowski <olle@lukowski.dev>
Cc: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
	Christian Gromm <christian.gromm@microchip.com>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] staging: most: i2c: replace BUG_ON() with
 WARN_ON_ONCE() and return error
Message-ID: <2025102130-siberian-rut-3a96@gregkh>
References: <20251021-staging-most-warn-v1-0-4cdd3745bbdc@lukowski.dev>
 <20251021-staging-most-warn-v1-1-4cdd3745bbdc@lukowski.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021-staging-most-warn-v1-1-4cdd3745bbdc@lukowski.dev>

On Tue, Oct 21, 2025 at 03:16:27PM +0300, Olle Lukowski wrote:
> Replace BUG_ON() checks for invalid channel indices with WARN_ON_ONCE()
> and return -EINVAL to avoid crashing the kernel unnecessarily.
> 
> Signed-off-by: Olle Lukowski <olle@lukowski.dev>
> ---
>  drivers/staging/most/i2c/i2c.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/most/i2c/i2c.c b/drivers/staging/most/i2c/i2c.c
> index 184b2dd11..b9267c3fc 100644
> --- a/drivers/staging/most/i2c/i2c.c
> +++ b/drivers/staging/most/i2c/i2c.c
> @@ -71,7 +71,8 @@ static int configure_channel(struct most_interface *most_iface,
>  	struct hdm_i2c *dev = to_hdm(most_iface);
>  	unsigned int delay, pr;
>  
> -	BUG_ON(ch_idx < 0 || ch_idx >= NUM_CHANNELS);
> +	if (WARN_ON_ONCE(ch_idx < 0 || ch_idx >= NUM_CHANNELS))
> +		return -EINVAL;

If this is something that can actually ever happen, this change really
doesn't do anything well.  Many systems (i.e. the HUGE majority of Linux
instances in the world, billions) are running with panic-on-warn set, so
that means this will still reboot the box.

So please, just properly handle the issue and return an error and do not
panic the system.

Same for the other patches in this series.

thanks,

greg k-h

