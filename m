Return-Path: <linux-kernel+bounces-728586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D60FBB02A56
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 12:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 238181BC7F65
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 10:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9719F274B2A;
	Sat, 12 Jul 2025 09:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="VgJFNz+R"
Received: from smtp.smtpout.orange.fr (smtp-27.smtpout.orange.fr [80.12.242.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B581E18E25;
	Sat, 12 Jul 2025 09:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752314396; cv=none; b=TLAJwkta5LtD9cQedk1U1Deu0HW0U5YvPIlhWoekjKXWPO+gUGCHguhk3fB9hwuvjCMP77ZUg7Egy3y4BVaEv3IesKGA8FT9aHXAOlYkIQz1HrV+tEEm9IWGL38bpO/0blwbRez3UuYqdVsaaoZq6rzp8WRdcj4uOAIb3R9X5zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752314396; c=relaxed/simple;
	bh=sdZjt0hnbzRR/HZ5/d69CQVdSgSCV06bK/CT9m4dYE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bu54oNPp/4trrzR+FDzIR7joiMBEu0wAj+pEoHLs4vufxnMTChTwuUUqrAKt/plU+09QR2kCxVMEfvSHm1xrf0g1qMjP2ntqZ4u2BG4/30KpSHNqEj4ojpFQuBDAjv2pCrfTZ6Y61ZIOOj47RUI9Jkga7APJiBdebp/a6OyIk54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=VgJFNz+R; arc=none smtp.client-ip=80.12.242.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
 ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id aX07uAwtYRF46aX07ugsjT; Sat, 12 Jul 2025 11:58:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1752314319;
	bh=xQzMwgCfXpTyf1wtWNBrErz9vPRbDl5e57j3qLO1Pqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=VgJFNz+RGbZ2n1SBwCe5aTpcGhugr2JpkJksiZS3iEx6hGiJNMez1hSOEOnb174VY
	 DtRMg3T0ByHGJO0akeSx2NRjEgiyZxZfcXZb98whoVtvccQj2bC1hIpUZX6q27lp3x
	 ROgki1ZmcV48O/e+Awtd06N9K15Kmt2y2xrZ2UN1a7RvuE/W1QB+28rBaSq0dzN5gI
	 OLsfumb75D6kyx++NrB3QgIYBD5SRiji7Radb0TAOK+XJx/DhdAD4ERr1TC7jkOUaU
	 x90aqw+4Rcf+s9t5PrWWYO7Dh+4UdI22a02P3frf+KaFrc54RQhNxsDTJKQcOmsu/x
	 4T+GfdL0leIMg==
X-ME-Helo: [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Sat, 12 Jul 2025 11:58:39 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
Message-ID: <a0e9473f-81a4-4933-aa63-e66fbeaf0824@wanadoo.fr>
Date: Sat, 12 Jul 2025 11:58:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] irqchip/imx-irqsteer: Fix irq handling if an error occurs
 in imx_irqsteer_irq_handler()
To: Thomas Gleixner <tglx@linutronix.de>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Lucas Stach <l.stach@pengutronix.de>,
 Marc Zyngier <maz@kernel.org>, Aisheng Dong <aisheng.dong@nxp.com>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org
References: <ad6514c771fef0ac2d1b3c050c6db5d5e0fd034d.1731842478.git.christophe.jaillet@wanadoo.fr>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <ad6514c771fef0ac2d1b3c050c6db5d5e0fd034d.1731842478.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 17/11/2024 à 12:21, Christophe JAILLET a écrit :
> chained_irq_enter(() should be paired with a corresponding
> chained_irq_exit().
> 
> Here, if (hwirq < 0), a early return occurs and chained_irq_exit() is not
> called.

After several month without any feedback, this is a polite ping.
Is this patch correct?

CJ


> 
> Add a new label and a goto for fix it.
> 
> Fixes: 28528fca4908 ("irqchip/imx-irqsteer: Add multi output interrupts support")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Compile tested only.
> 
> Review with care, irq handling is sometimes tricky...
> ---
>   drivers/irqchip/irq-imx-irqsteer.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-imx-irqsteer.c b/drivers/irqchip/irq-imx-irqsteer.c
> index 75a0e980ff35..59abe5a8beb8 100644
> --- a/drivers/irqchip/irq-imx-irqsteer.c
> +++ b/drivers/irqchip/irq-imx-irqsteer.c
> @@ -135,7 +135,7 @@ static void imx_irqsteer_irq_handler(struct irq_desc *desc)
>   	if (hwirq < 0) {
>   		pr_warn("%s: unable to get hwirq base for irq %d\n",
>   			__func__, irq);
> -		return;
> +		goto out;
>   	}
>   
>   	for (i = 0; i < 2; i++, hwirq += 32) {
> @@ -153,6 +153,7 @@ static void imx_irqsteer_irq_handler(struct irq_desc *desc)
>   			generic_handle_domain_irq(data->domain, pos + hwirq);
>   	}
>   
> +out:
>   	chained_irq_exit(irq_desc_get_chip(desc), desc);
>   }
>   


