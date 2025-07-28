Return-Path: <linux-kernel+bounces-747423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BAAB133AA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 06:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9890618962F8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 04:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB64215F4A;
	Mon, 28 Jul 2025 04:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xNIt4i/P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC70D1C36
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 04:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753676523; cv=none; b=NoqLTH8Q5ejGrDjJN8bK8m1SZLxk7zYrHase6Y8lltpO/etSGrgl55zi60rW/iofY/06RQjZgURENuPGtJof2feOHavlZpZdZUMXWuV1+g0fc5wOpF6YUAYaBrLXpY7Q4iicoZ5Of+aWyizZ/oNof3OIuBTYz2IXYNShYgea5/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753676523; c=relaxed/simple;
	bh=1CHNSu+rR/PEfFBzDRLDqMVnlwN8zYMliQAW/YkOQkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mAWX4Ah0oxyO4dPY0VPc9JdB8wiXLneUTgdPy7w1WrBDUWKVVsdbIjdXgPtcuJqiGeenDjdc6y6A2svkPQwd2WQW/eOhUq9GgMp8VLdx5XDydYN9izKmZ/iYy9v+HnNYiQC73nfayRx9zG3Rquj18SM3DFPB2tJ+b+guRBSvEfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xNIt4i/P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E71B6C4CEE7;
	Mon, 28 Jul 2025 04:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753676523;
	bh=1CHNSu+rR/PEfFBzDRLDqMVnlwN8zYMliQAW/YkOQkg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xNIt4i/Pi1Sjrz6PVONpG8njTlk3zJouuQds4MeWK7356l4a+z1aqyIGmyMnbB9VI
	 hLfaOkYk7yay7bjQx3YhB6qcrCmkgbIoK7dlkcNyo8G/FQN56bPb8dWL00/RP9+Y8P
	 +3PjphdUXTQGecOvyMPh34X/8CbmVJN1KFUqIAxc=
Date: Mon, 28 Jul 2025 06:21:59 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Tian <27392025k@gmail.com>
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de
Subject: Re: [PATCH] misc: cardreader: fix overwritten return value in
 RTS5260 driver
Message-ID: <2025072844-stingray-eskimo-9422@gregkh>
References: <20250727234134.26540-1-27392025k@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250727234134.26540-1-27392025k@gmail.com>

On Sun, Jul 27, 2025 at 04:41:34PM -0700, Tian wrote:
> In both rts5260.c and rtsx_pcr.c, a return value is set and then
> overwritten by a later function call, which makes the original value
> unused. This patch ensures the return value is handled properly
> to avoid ignoring possible error conditions.
> 
> Signed-off-by: Tian <27392025k@gmail.com>

Please use your ful name as per the kernel documentation.

> ---
>  drivers/misc/cardreader/rts5260.c  | 2 +-
>  drivers/misc/cardreader/rtsx_pcr.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/cardreader/rts5260.c b/drivers/misc/cardreader/rts5260.c
> index d2d3a6ccb8f7..ed8adaab54a8 100644
> --- a/drivers/misc/cardreader/rts5260.c
> +++ b/drivers/misc/cardreader/rts5260.c
> @@ -269,7 +269,7 @@ static int rts5260_card_power_off(struct rtsx_pcr *pcr, int card)
>  	rts5260_card_before_power_off(pcr);
>  	err = rtsx_pci_write_register(pcr, LDO_VCC_CFG1,
>  			 LDO_POW_SDVDD1_MASK, LDO_POW_SDVDD1_OFF);
> -	err = rtsx_pci_write_register(pcr, LDO_CONFIG2,
> +	err |= rtsx_pci_write_register(pcr, LDO_CONFIG2,
>  			 DV331812_POWERON, DV331812_POWEROFF);

How was this tested?

And why do the second write if the first one failed?


>  	if (pcr->option.ocp_en)
>  		rtsx_pci_disable_ocp(pcr);

Why do this if the write failed?

> diff --git a/drivers/misc/cardreader/rtsx_pcr.c b/drivers/misc/cardreader/rtsx_pcr.c
> index a7b066c48740..9fb22f2cedbd 100644
> --- a/drivers/misc/cardreader/rtsx_pcr.c
> +++ b/drivers/misc/cardreader/rtsx_pcr.c
> @@ -1196,7 +1196,7 @@ static int rtsx_pci_init_hw(struct rtsx_pcr *pcr)
>  		/* Gating real mcu clock */
>  		err = rtsx_pci_write_register(pcr, RTS5261_FW_CFG1,
>  			RTS5261_MCU_CLOCK_GATING, 0);
> -		err = rtsx_pci_write_register(pcr, RTS5261_REG_FPDCTL,
> +		err |= rtsx_pci_write_register(pcr, RTS5261_REG_FPDCTL,
>  			SSC_POWER_DOWN, 0);

Is this even going to ever happen?  Same for above, how was this tested?

thanks,

greg k-h

