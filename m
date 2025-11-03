Return-Path: <linux-kernel+bounces-883346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C30C2D31C
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 17:39:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAB1A3BB555
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 16:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47FE43161B3;
	Mon,  3 Nov 2025 16:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="LYVLh+u3";
	dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b="LYVLh+u3"
Received: from mail.mleia.com (mleia.com [178.79.152.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA8931354B
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 16:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.79.152.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762187288; cv=none; b=ZMg/KrLyaDt6GuGlLtnryzeM9X5w3okWjBN3JbA5vLoDGA5gh0Tucb7aGTdi1PXb0ejh18c8pBpYU5FERob1gzfcoy3Lr/yDEnAXcwf1K2nmJkDiyZ9dlv/af4HyDc4tnxICkVZ2udis60W+rWlpEztgEElw0Hyoik1Wr+1Zt/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762187288; c=relaxed/simple;
	bh=/VbFNPsAjPx/Ya9C7TeCbLeOU9I9kKRA46UQ/FZCv0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IDKNpg9O0kjDs7gBOmbDQHE7sa8+mxxrW8vYOJ9tyFHJL/zDC0pbri9I5IpGT7g7aQTrkR4xuY1DDHQuZq3qGti2b5oAdmLQ+YgkO0MacqMIMQqRBXqvbYlVXPsz599xFbNjAXSb3nidfhy1LM+zU2NNuxUHqxkEYJdDmNU4wMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com; spf=none smtp.mailfrom=mleia.com; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=LYVLh+u3; dkim=pass (2048-bit key) header.d=mleia.com header.i=@mleia.com header.b=LYVLh+u3; arc=none smtp.client-ip=178.79.152.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mleia.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mleia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1762186908; bh=/VbFNPsAjPx/Ya9C7TeCbLeOU9I9kKRA46UQ/FZCv0g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LYVLh+u39IoJPjE7h4ucaYQtPP5UtRleC7wsXbxDs/X8oXA49K2AMexgppGuxcVvF
	 if3KHi0zHKd8bAZ9yZ7NoeczEN6uD5hYVBctF37oy77JA93Jkca8pH4norti5ZwKJr
	 vAUiq3u3R05G3bmL1u0SKLg9BsbzNbyxA9Yb6XLF79LNksnF7J8/kLqqOYvUCENuR6
	 M5UGa5XuJ3yxFeJFzpT+GJZKakaXsKHFo0m+sQkimO2AmFEa6f/HmXAJJFGvcsipNc
	 vQlY0D9sNNOSxsY6WfXdXg612H8Rfsbr3Io0TxmicLIuPmtiWXrzKZ3dZAq7CCI1r1
	 F30zLfWbo6SDw==
Received: from mail.mleia.com (localhost [127.0.0.1])
	by mail.mleia.com (Postfix) with ESMTP id 241B13DE8CC;
	Mon,  3 Nov 2025 16:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mleia.com; s=mail;
	t=1762186908; bh=/VbFNPsAjPx/Ya9C7TeCbLeOU9I9kKRA46UQ/FZCv0g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LYVLh+u39IoJPjE7h4ucaYQtPP5UtRleC7wsXbxDs/X8oXA49K2AMexgppGuxcVvF
	 if3KHi0zHKd8bAZ9yZ7NoeczEN6uD5hYVBctF37oy77JA93Jkca8pH4norti5ZwKJr
	 vAUiq3u3R05G3bmL1u0SKLg9BsbzNbyxA9Yb6XLF79LNksnF7J8/kLqqOYvUCENuR6
	 M5UGa5XuJ3yxFeJFzpT+GJZKakaXsKHFo0m+sQkimO2AmFEa6f/HmXAJJFGvcsipNc
	 vQlY0D9sNNOSxsY6WfXdXg612H8Rfsbr3Io0TxmicLIuPmtiWXrzKZ3dZAq7CCI1r1
	 F30zLfWbo6SDw==
Received: from [172.20.4.186] (unknown [185.60.252.187])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.mleia.com (Postfix) with ESMTPSA id D514A3DE66A;
	Mon,  3 Nov 2025 16:21:47 +0000 (UTC)
Message-ID: <57f7989d-6f05-4b1b-a31b-4b1dca308ffb@mleia.com>
Date: Mon, 3 Nov 2025 18:21:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: rawnand: lpc32xx_slc: fix GPIO descriptor leak on
 probe error and remove
To: Haotian Zhang <vulab@iscas.ac.cn>, miquel.raynal@bootlin.com,
 richard@nod.at, vigneshr@ti.com, piotr.wojtaszczyk@timesys.com
Cc: dmitry.torokhov@gmail.com, linux-mtd@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251028094747.1089-1-vulab@iscas.ac.cn>
From: Vladimir Zapolskiy <vz@mleia.com>
In-Reply-To: <20251028094747.1089-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-49551924 
X-CRM114-CacheID: sfid-20251103_162148_170040_1F9A61DE 
X-CRM114-Status: GOOD (  17.85  )

On 10/28/25 11:47, Haotian Zhang wrote:
> The driver calls gpiod_get_optional() in the probe function but
> never calls gpiod_put() in the remove function or in the probe
> error path. This leads to a GPIO descriptor resource leak.
> The lpc32xx_mlc.c driver in the same directory handles this
> correctly by calling gpiod_put() on both paths.
> 
> Add gpiod_put() in the remove function and in the probe error path
> to fix the resource leak.
> 
> Fixes: 6b923db2867c ("mtd: rawnand: lpc32xx_slc: switch to using gpiod API")
> Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>

The problem is well identified, thank you for the fix.

> ---
>   drivers/mtd/nand/raw/lpc32xx_slc.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mtd/nand/raw/lpc32xx_slc.c b/drivers/mtd/nand/raw/lpc32xx_slc.c
> index b54d76547ffb..fea3705a2138 100644
> --- a/drivers/mtd/nand/raw/lpc32xx_slc.c
> +++ b/drivers/mtd/nand/raw/lpc32xx_slc.c
> @@ -937,6 +937,7 @@ static int lpc32xx_nand_probe(struct platform_device *pdev)
>   	dma_release_channel(host->dma_chan);
>   enable_wp:
>   	lpc32xx_wp_enable(host);
> +	gpiod_put(host->wp_gpio);
>   
>   	return res;
>   }
> @@ -962,6 +963,7 @@ static void lpc32xx_nand_remove(struct platform_device *pdev)
>   	writel(tmp, SLC_CTRL(host->io_base));
>   
>   	lpc32xx_wp_enable(host);
> +	gpiod_put(host->wp_gpio);
>   }
>   
>   static int lpc32xx_nand_resume(struct platform_device *pdev)

The fix can be greatly improved though, I kindly ask you to send v2 by switching
from gpiod_get_optional() to resource managed devm_gpiod_get_optional().

Thank you in advance.

-- 
Best wishes,
Vladimir

