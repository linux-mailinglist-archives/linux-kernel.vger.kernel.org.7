Return-Path: <linux-kernel+bounces-775436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D302B2BF1D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 12:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39E293BB274
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 10:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805DB322C84;
	Tue, 19 Aug 2025 10:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Lz96h+Mr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4167322C77
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 10:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755599966; cv=none; b=rXz9+m1MyG+jNVfZQ0ZT+XM/tQ0kBRPZYO8x6QyVcO/qKEUSHjbzpiVg4Ji05eDavt8JM30rSLU0US09zpg4CikKCDiY47AMuIFCQ+UD/hMf1DKQ3l2g+yKZgy0XTFsS9g5s9ha/pVtimiiW6GmMBQd3IPA2WzFXH/5g1005/Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755599966; c=relaxed/simple;
	bh=yFY9/FUAdVObVBIV/qsDTY57fWE84AIaJDWRAFMSWMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dzUjJAdf8qsouMBjOF0oY2VwNd4CEE+9SBzwJtz2yAmsYe+bRot8Z336qa5CYUzciL6VxtAxnJIf7AE+FVZL0ErdcMSobnMEtQxsBjp/bldo9xa4SFKlQLQmBatMC2Eq0MUL+S3D5bQy5qVIB1avkxXlFoWn7ZY1g/SK6YeH7Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Lz96h+Mr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A737EC116B1;
	Tue, 19 Aug 2025 10:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755599966;
	bh=yFY9/FUAdVObVBIV/qsDTY57fWE84AIaJDWRAFMSWMY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lz96h+Mr22mP92Wz2lhXpLNdSzreGCMB8XD3b60wKkoOvfo4bpG6lNMu+shfTyCNC
	 4HkSBIRPt/hQVZ5ydAS93G2YfuHVqld+LPqIaZailQ6SH+nnoVmi/IstsAqoWSLczc
	 cCGAsXhLbx/788zHmquhRBKSxJnRTNbukVtdIDcE=
Date: Tue, 19 Aug 2025 12:39:23 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Tian <27392025k@gmail.com>
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH misc v2] misc: cardreader: fix overwritten return value
 in RTS5260 driver
Message-ID: <2025081906-sandbar-shove-b79f@gregkh>
References: <20250729013510.34358-1-27392025k@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729013510.34358-1-27392025k@gmail.com>

On Mon, Jul 28, 2025 at 06:35:10PM -0700, Tian wrote:
> From: Tian Liu <27392025k@gmail.com>
> 
> In both rts5260.c and rtsx_pcr.c, a return value is assigned and then
> overwritten by a subsequent call, which causes the original result to be
> lost. This may result in silently ignoring errors from the first write.
> 
> This patch uses `err |=` to preserve earlier failure status.
> 
> This is an untested cleanup inspired by commit c55c7a85e02a ("um: ubd: Preserve earlier error value in ubd_user") which fixed similar error-handling logic. While this change has not been functionally tested on hardware, it is a mechanical fix and aligns with expected error-handling style.
> 
> Fixes: bede03a579b3 ("misc: rtsx: Enable OCP for rts522a rts524a rts525a rts5260")
> Fixes: c0e5f4e73a71 ("misc: rtsx: Add support for RTS5261")
> 
> Signed-off-by: Tian Liu <27392025k@gmail.com>
> 
> Changes in v2:
> - Use full name in Signed-off-by and From
> - Add Fixes: tag
> - Clarify that patch is untested, but reasoned from upstream style
> - Cc: appropriate public mailing list
> 
> ---

The "changes..." stuff goes below the --- line.

Also, please wrap your changelog text at 72 columns.

As you have not tested this, I don't think this should be taken, do you?

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

How can this write fail?  And just | all errors together really doesn't
do all that much, right?


>  	if (pcr->option.ocp_en)
>  		rtsx_pci_disable_ocp(pcr);
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

Same here, it feels odd to do that.

thanks,

greg k-h

