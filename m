Return-Path: <linux-kernel+bounces-824425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB04B892D0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 13:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BEC658630E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 11:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774093093A5;
	Fri, 19 Sep 2025 11:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IvISChoI"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CD119755B
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 11:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758279743; cv=none; b=mga2WKTSHGSsfNOTFSmuigD+JLLtUte6L7ZGHJ8tn7JK98e7v+j13bzpE6nTVohBDrLlrm6J8MXWpMQFvr7slkBmCCQYZsP1FE6fgT8Yap//DzDpwMLicjGM0366kYF5ua1ZJ/NG/ASP1f3z2p+BWMoPVLtT1tr+qydKZ5fgn3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758279743; c=relaxed/simple;
	bh=DMCaAdrM0iJ/a493sS7cg4Tb2ciW6M68+j/honBH2IQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fkIIWHHKROWDtOIF1azQfvZBpycNlfbDDOta+rNBckKfj09GLPVUFPPSpnnpMAnz+w4JiFlwvgdI7XZSQMNtikGMnIvSJvUm8+9EiTrUQr3Z6fDbwcTVxAIijTzcBCwnZhL9hSj11Qq4EIfc9F9/F4c5XGZHbIpPIYk2sS+QXwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IvISChoI; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <dbfe6e10-f7f1-4a79-abc1-37151235bc5c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758279728;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hhzxfG7cjXwgON863eIP76FtEayQp7q6bAEfRNlUZAM=;
	b=IvISChoIUAIGIvSkT8rjV5NjUggLeHa931OhW1LluXBXZ019yTkVBmBTUpI+cu5Je9myd1
	O37yZPdxYVfAu4sDSsoRpWPszzN2I3Slc7oi9dJecXXyPrJP+2Wx/Edx9kqfpuk9UErQoH
	ugipUP3spN70fM90vBqN7+IeKoGhhxQ=
Date: Fri, 19 Sep 2025 12:02:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net 1/3] broadcom: fix support for PTP_PEROUT_DUTY_CYCLE
To: Jacob Keller <jacob.e.keller@intel.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Kory Maincent <kory.maincent@bootlin.com>
Cc: Richard Cochran <richardcochran@gmail.com>,
 Yaroslav Kolomiiets <yrk@meta.com>, James Clark <jjc@jclark.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250918-jk-fix-bcm-phy-supported-flags-v1-0-747b60407c9c@intel.com>
 <20250918-jk-fix-bcm-phy-supported-flags-v1-1-747b60407c9c@intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250918-jk-fix-bcm-phy-supported-flags-v1-1-747b60407c9c@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 19/09/2025 01:33, Jacob Keller wrote:
> The bcm_ptp_perout_locked() function has support for handling
> PTP_PEROUT_DUTY_CYCLE, but its not listed in the supported_perout_flags.
> Attempts to use the duty cycle support will be rejected since commit
> d9f3e9ecc456 ("net: ptp: introduce .supported_perout_flags to
> ptp_clock_info"), as this flag accidentally missed while doing the
> conversion.
> 
> Drop the unnecessary supported flags check from the bcm_ptp_perout_locked()
> function and correctly set the supported_perout_flags. This fixes use of
> the PTP_PEROUT_DUTY_CYCLE support for the broadcom driver.
> 
> Reported-by: James Clark <jjc@jclark.com>
> Fixes: d9f3e9ecc456 ("net: ptp: introduce .supported_perout_flags to ptp_clock_info")
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>   drivers/net/phy/bcm-phy-ptp.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/net/phy/bcm-phy-ptp.c b/drivers/net/phy/bcm-phy-ptp.c
> index eba8b5fb1365..1cf695ac73cc 100644
> --- a/drivers/net/phy/bcm-phy-ptp.c
> +++ b/drivers/net/phy/bcm-phy-ptp.c
> @@ -597,10 +597,6 @@ static int bcm_ptp_perout_locked(struct bcm_ptp_private *priv,
>   
>   	period = BCM_MAX_PERIOD_8NS;	/* write nonzero value */
>   
> -	/* Reject unsupported flags */
> -	if (req->flags & ~PTP_PEROUT_DUTY_CYCLE)
> -		return -EOPNOTSUPP;
> -
>   	if (req->flags & PTP_PEROUT_DUTY_CYCLE)
>   		pulse = ktime_to_ns(ktime_set(req->on.sec, req->on.nsec));
>   	else
> @@ -741,6 +737,7 @@ static const struct ptp_clock_info bcm_ptp_clock_info = {
>   	.n_pins		= 1,
>   	.n_per_out	= 1,
>   	.n_ext_ts	= 1,
> +	.supported_perout_flags = PTP_PEROUT_DUTY_CYCLE,
>   };
>   
>   static void bcm_ptp_txtstamp(struct mii_timestamper *mii_ts,
> 

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

