Return-Path: <linux-kernel+bounces-888717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D0EC3BC2E
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 15:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68E9E565A2D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 14:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53388343D9B;
	Thu,  6 Nov 2025 14:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="F/zcqDeY";
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="F/zcqDeY"
Received: from mail.mleia.com (mleia.com [178.79.152.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69089329C79
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 14:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.79.152.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762438906; cv=none; b=dDv2tfFhFjw00u9Laz9Uy/ASmTKAfozK4f0gGozLaqZ3H1hq2kuAhA59ap50icba9teLsNMonpZvO2uid6AW3l/7Py4dAb3Z7+9Z5iR3zSgkTUhx80IymgLoCWdlsP/2g2AHUTL6FY3HTQqaP3tF300LX70e8P1Zv/qIh73fhC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762438906; c=relaxed/simple;
	bh=/gqnxohTzecfr3QbwlBSQI2vHR/UDx9rUe02QDDlnhU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OrNSdiKaASCu/Zq5hy5OCSJeGjAvAq1L6nXu0OdbRI+5V73aBNAySAhrkS4T5sLeh/wtG3Om9MWfSeFtztXRMOZA08uhTRpNuksJBTbtUlDBd2Eixx2TjLCXl2Cv2L1HB8kDwdtBrXJm9VJpAc2afd6xuXFCv0mS6qPvfEu+7UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com; spf=none smtp.mailfrom=mleia.com; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=F/zcqDeY; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=F/zcqDeY; arc=none smtp.client-ip=178.79.152.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mleia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1762438896; bh=/gqnxohTzecfr3QbwlBSQI2vHR/UDx9rUe02QDDlnhU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=F/zcqDeY83kg2SLHuBCftSmclw4vcyHLyXVgw+Y7RBiJql0PRsiBYHJcMGk+R+v7R
	 B9VHPfVmg3WwLe2seTcARp9tZ72hGRsy0Y1LLmMeYEUQ85jKWkoTk4vgPFtSptH8WM
	 WfXAduWq7dzOr4sqnd6mHdJaUcJ7146u9o05GbG0Vbd4vwqlkAE2wwCEC3cOw4aCgd
	 a3P87Vz3bH7b1W0BOOjgag9stDXSugaIGVcZmmF9atFRU8T93oH83+f9g3OTJQ/v68
	 OFm9BybHFl7SvY21K9qqMXv1l7+q9NDl8HUpMbKehaS5oN3JhRqwa7PuvYp4+7ecsj
	 8DWDfmDlmlP7g==
Received: from mail.mleia.com (localhost [127.0.0.1])
	by mail.mleia.com (Postfix) with ESMTP id B56C73DF743;
	Thu,  6 Nov 2025 14:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1762438896; bh=/gqnxohTzecfr3QbwlBSQI2vHR/UDx9rUe02QDDlnhU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=F/zcqDeY83kg2SLHuBCftSmclw4vcyHLyXVgw+Y7RBiJql0PRsiBYHJcMGk+R+v7R
	 B9VHPfVmg3WwLe2seTcARp9tZ72hGRsy0Y1LLmMeYEUQ85jKWkoTk4vgPFtSptH8WM
	 WfXAduWq7dzOr4sqnd6mHdJaUcJ7146u9o05GbG0Vbd4vwqlkAE2wwCEC3cOw4aCgd
	 a3P87Vz3bH7b1W0BOOjgag9stDXSugaIGVcZmmF9atFRU8T93oH83+f9g3OTJQ/v68
	 OFm9BybHFl7SvY21K9qqMXv1l7+q9NDl8HUpMbKehaS5oN3JhRqwa7PuvYp4+7ecsj
	 8DWDfmDlmlP7g==
Received: from [172.20.148.102] (unknown [87.213.113.147])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.mleia.com (Postfix) with ESMTPSA id 5E60B3DF425;
	Thu,  6 Nov 2025 14:21:36 +0000 (UTC)
Message-ID: <8b2197ea-d110-4693-8683-5e8b12860922@mleia.com>
Date: Thu, 6 Nov 2025 16:21:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: rawnand: lpc32xx_slc: Convert to use
 devm_gpiod_get_optional()
To: Haotian Zhang <vulab@iscas.ac.cn>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
Cc: linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20251104100842.369-1-vulab@iscas.ac.cn>
From: Vladimir Zapolskiy <vz@mleia.com>
In-Reply-To: <20251104100842.369-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20251106_142136_766134_492B555A 
X-CRM114-Status: GOOD (  15.69  )

On 11/4/25 12:08, Haotian Zhang wrote:
> The initial fix for a GPIO descriptor leak added manual gpiod_put()
> calls in the error path and remove function.
> 
> This follow-up patch improves upon the fix by switching to the
> resource-managed devm_gpiod_get_optional() API.
> 
> Suggested-by: Vladimir Zapolskiy <vz@mleia.com>
> Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
> ---
>   drivers/mtd/nand/raw/lpc32xx_slc.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/lpc32xx_slc.c b/drivers/mtd/nand/raw/lpc32xx_slc.c
> index fea3705a2138..3ca30e7dce33 100644
> --- a/drivers/mtd/nand/raw/lpc32xx_slc.c
> +++ b/drivers/mtd/nand/raw/lpc32xx_slc.c
> @@ -854,7 +854,7 @@ static int lpc32xx_nand_probe(struct platform_device *pdev)
>   	}
>   
>   	/* Start with WP disabled, if available */
> -	host->wp_gpio = gpiod_get_optional(&pdev->dev, NULL, GPIOD_OUT_LOW);
> +	host->wp_gpio = devm_gpiod_get_optional(&pdev->dev, NULL, GPIOD_OUT_LOW);
>   	res = PTR_ERR_OR_ZERO(host->wp_gpio);
>   	if (res) {
>   		if (res != -EPROBE_DEFER)
> @@ -937,7 +937,6 @@ static int lpc32xx_nand_probe(struct platform_device *pdev)
>   	dma_release_channel(host->dma_chan);
>   enable_wp:
>   	lpc32xx_wp_enable(host);
> -	gpiod_put(host->wp_gpio);
>   
>   	return res;
>   }
> @@ -963,7 +962,6 @@ static void lpc32xx_nand_remove(struct platform_device *pdev)
>   	writel(tmp, SLC_CTRL(host->io_base));
>   
>   	lpc32xx_wp_enable(host);
> -	gpiod_put(host->wp_gpio);
>   }
>   
>   static int lpc32xx_nand_resume(struct platform_device *pdev)

Thank you so much for the change!

Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>

-- 
Best wishes,
Vladimir


