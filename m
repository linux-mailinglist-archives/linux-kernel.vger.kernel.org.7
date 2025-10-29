Return-Path: <linux-kernel+bounces-876151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 585EDC1AC77
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 99A3C58534B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3940E34320D;
	Wed, 29 Oct 2025 13:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="HviZ1Y9f"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDA2264A9D;
	Wed, 29 Oct 2025 13:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761743959; cv=none; b=BZmFpkToo70fltIGuRAMWtUcrjFPR3CUEpjysGOS61wu7Mh0eU4ZfvqwsoSrXXcJBpbxphsr1XtcSc/wfhKIEtm01TVx+l3PJBPeaVb3od2+RyyF5DmKCr9mxJM3rHNSDfzLh5cr8SfntHdaCFcAeuveDgC9GIqTlBfFbFOv+eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761743959; c=relaxed/simple;
	bh=fE3GI6tnC+2H8YMme5hylFf1T+W9ZUVZeAJHZpgAR1c=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=MJS7ztPvy2PtbbN6xPQoCmJgDcMmf13g6D/3HQb5MgLMkzr3aAX7TqqbccWA12xvNwov/wFOyANByTNgn1fpApoFf7gKGhQgnlROW4+NMY3ABC8jE/Lr3Jwmg6C78fUAuzPpcC0AzQCi/j/00hxQ1iOuhje/TcBoOeGAH7xLBp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=HviZ1Y9f; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:Message-ID:References:
	In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=gTY+fh4/ukja1oSr3pfFFJ7ZbrQGeiX8cxOtmfsJPd4=; b=HviZ1Y9fNLqZQLJBsqf+T5iiuZ
	VHg4Qq5Zbf3kkn2oBIkKV32E56t/jxmh8kAkCTNx9/v8IaqTbsLd+707COElupQAfkzwVm5wQgb8H
	9vS5w/DArwM4rgQaoPTo6VLw39iDXuSmLjOhmxEtWY09lHZQAm1yLZxI08zaRKWSx3iT9JK3ymeAy
	iGxc31YFFgFE2WUgao8mFzvkW/5+Facdw7ONRSCrnISwRzm4JnspiG2hfvEVANaK4j4VTYJCdBgqY
	G4qLMhiMLJeNisDW5gWdspBpX1Df8MIxpwt36HgsNBe+DEiWwYcVszxCttm4TJa6jdn6rshAHaCdd
	YRxbJP3g==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
	by fanzine2.igalia.com with esmtps 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vE64q-00Gcm4-7S; Wed, 29 Oct 2025 14:19:00 +0100
Received: from webmail.service.igalia.com ([192.168.21.45])
	by mail.igalia.com with esmtp (Exim)
	id 1vE64o-000l86-63; Wed, 29 Oct 2025 14:19:00 +0100
Received: from localhost ([127.0.0.1] helo=webmail.igalia.com)
	by webmail with esmtp (Exim 4.96)
	(envelope-from <uajain@igalia.com>)
	id 1vE64n-001UFh-1y;
	Wed, 29 Oct 2025 14:18:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 29 Oct 2025 13:18:57 +0000
From: uajain <uajain@igalia.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Broadcom internal
 kernel review list <bcm-kernel-feedback-list@broadcom.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Stefan Wahren
 <wahrenst@gmx.net>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?=
 <thomas.weissschuh@linutronix.de>, Rohit Chavan <roheetchavan@gmail.com>,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] staging: vchiq_arm: delete unnecessary check
In-Reply-To: <aQIS6Q73Ss8xyJTD@stanley.mountain>
References: <aQIS6Q73Ss8xyJTD@stanley.mountain>
Message-ID: <86db61cb04863e9799eb20962a47ecdc@igalia.com>
X-Sender: uajain@igalia.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Report: NO, Score=-2.2, Tests=ALL_TRUSTED=-3,BAYES_50=0.8,URIBL_BLOCKED=0.001
X-Spam-Score: -21
X-Spam-Bar: --

On 2025-10-29 13:13, Dan Carpenter wrote:
> Both sides of this if else statement print exactly the same thing.
> Delete the unnecessary if statement.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

LGTM,
Reviewed-by: Umang Jain <uajain@igalia.com>

> ---
>  .../staging/vc04_services/interface/vchiq_arm/vchiq_core.c   | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
> index e2cac0898b8f..130be2f58342 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c
> @@ -4001,10 +4001,7 @@ void vchiq_log_dump_mem(struct device *dev, const char *label, u32 addr,
>  		}
>  		*s++ = '\0';
>  
> -		if (label && (*label != '\0'))
> -			dev_dbg(dev, "core: %s: %08x: %s\n", label, addr, line_buf);
> -		else
> -			dev_dbg(dev, "core: %s: %08x: %s\n", label, addr, line_buf);
> +		dev_dbg(dev, "core: %s: %08x: %s\n", label, addr, line_buf);
>  
>  		addr += 16;
>  		mem += 16;

