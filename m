Return-Path: <linux-kernel+bounces-742511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 840C4B0F29E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 14:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B77E3A4EC4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 12:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467BF2E7178;
	Wed, 23 Jul 2025 12:54:26 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BC02E6106;
	Wed, 23 Jul 2025 12:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753275265; cv=none; b=K27NOg78HCmIR+U1gAUX6i2xBTJcfl2bDJTbSvyyldraoYbW0uoGnLDOCVmAS2wuLH+z8JgVoqjziXKdVEGUurXKD0ptDymxAVGsMqfTbgDPKrvcmGrYj0zG53KC66wa0wj0bAE8DXOVbE34B8+8LUKoFZQSPPfI+LZVG/F8iLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753275265; c=relaxed/simple;
	bh=Kerz7Zsk0nf3PTKd3glROZF305DbaeWJZ18IC/WXhzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fOLWVZjJVSZtqsOKB2LEon4G7EqRVJiIjWq3M4YgOd3v1Fy4PoVSux9+/OnH1taiGqFn3FzUrYJbT4Oa7tGPIzUMh+ffG+UBkJKYNmepj3Y69HgPYRQriV0rdmXGZ8haONmBqGwagvUzG0xPNcObF9jsD42MkqiWLkTh+jqRmDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.48.207])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id BC9C5335CDD;
	Wed, 23 Jul 2025 12:54:22 +0000 (UTC)
Date: Wed, 23 Jul 2025 20:54:16 +0800
From: Yixun Lan <dlan@gentoo.org>
To: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
Cc: sboyd@kernel.org, skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev, linux-clk@vger.kernel.org,
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: spacemit: fix resource leak in
 spacemit_ccu_reset_register
Message-ID: <20250723125416-GYA738759@gentoo>
References: <20250723124020.60897-1-hendrik.hamerlinck@hammernet.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723124020.60897-1-hendrik.hamerlinck@hammernet.be>

Hi Hendrik, 

On 14:40 Wed 23 Jul     , Hendrik Hamerlinck wrote:
> The function spacemit_ccu_reset_register() allocates memory for an
> auxiliary device. If auxiliary_device_add() fails, it skips cleanup of
> these resources, resulting in leaks.
> 
> Fix this by using the appropriate error handling path.
> 
> Signed-off-by: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
> Fixes: 988543522ebd ("clk: spacemit: set up reset auxiliary devices")
Can you put Fixes tag before SoB? I'd suggest to follow tip tree's docs

https://docs.kernel.org/process/maintainer-tip.html
4.2.6. Ordering of commit tags

otherwise, looks good

Reviewed-by: Yixun Lan <dlan@gentoo.org>

> ---
>  drivers/clk/spacemit/ccu-k1.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/spacemit/ccu-k1.c b/drivers/clk/spacemit/ccu-k1.c
> index 65e6de030717..5bb85e32c6cf 100644
> --- a/drivers/clk/spacemit/ccu-k1.c
> +++ b/drivers/clk/spacemit/ccu-k1.c
> @@ -1059,7 +1059,7 @@ static int spacemit_ccu_reset_register(struct device *dev,
>  	ret = auxiliary_device_add(adev);
>  	if (ret) {
>  		auxiliary_device_uninit(adev);
> -		return ret;
> +		goto err_free_aux_id;
>  	}
>  
>  	return devm_add_action_or_reset(dev, spacemit_adev_unregister, adev);
> -- 
> 2.43.0
> 

-- 
Yixun Lan (dlan)

