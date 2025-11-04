Return-Path: <linux-kernel+bounces-884329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7DEC2FE56
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 09:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8585F3B5B8B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 08:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235531F5435;
	Tue,  4 Nov 2025 08:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EBXHeENp"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912D61DFF0
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 08:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762244884; cv=none; b=OM8t0pKtGie1wokFQ5How1t7eIPUKzDAHoZkl9Y7iBBbhyETB+Yx7aQHFye/nbP36//sz/cm6taPkfHpU8k5ma10dX68DbMB1yNYf3daF8op9mYV/6P+PlLCPM56VZ20cx1/f2BYuZB39TaJpZIHpcxuKC3ltXxQ7fllFz7gNW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762244884; c=relaxed/simple;
	bh=5qCNQE09zpEn4WStJ4qyccwE/q0L5x3RPPiImVkBpCE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CY4Pnln26MmptKA+uL4RqiBUnADs1fJ/LU7gejWgUn+IF2zBY6MoOzl1kiNb0znETv7Nh3cvjXCYlzTs/RTLShRSNEvs7CaNmO2B01y0CyOZdRijxEg1X3LTqq7IxabQIygRQgzVXENeLeGlRZvgfQLzA8tK0GVa/Q2EnFNn+JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EBXHeENp; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id A37ACC0E604;
	Tue,  4 Nov 2025 08:27:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6937E606EF;
	Tue,  4 Nov 2025 08:27:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3101E10B50096;
	Tue,  4 Nov 2025 09:27:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762244875; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=+TfhXHUSw3+oJhe7TatHLLAgu2372no2ChD3eKy/l5s=;
	b=EBXHeENpL10W0F4oCmAVTOvzdSsmtfVjnvaAroBm8VttjnVHcjXb/WGl/w75922sMk7AQt
	lHtJfqbXyq9DJ0SqVQhmvCy3LcbEDJcnkCbMZ9nmUZciFDquW9SUtVP1zEsveKzE68tpt7
	wDrrbjJnR1ECFRllShwir2ZobUoR6HwPU9EASh+bjRRC6DHDyWD6BzcaHbLKZNTPsvXuKb
	NLUN5TGAlU+x3zDcd8VH7m9UgcMHPkzolvkaEuytnCzR+H9VYKgxTOUEut6xc4LAQSt1k0
	DOPPzhQ7fW0hEAe9r6Mkvn1yDotU0jYcQTKY/yw0IJ7gdrg06oisVUtR/zqJdA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Vladimir Zapolskiy <vz@mleia.com>
Cc: Haotian Zhang <vulab@iscas.ac.cn>,  richard@nod.at,  vigneshr@ti.com,
  piotr.wojtaszczyk@timesys.com,  dmitry.torokhov@gmail.com,
  linux-mtd@lists.infradead.org,  linux-arm-kernel@lists.infradead.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: rawnand: lpc32xx_slc: fix GPIO descriptor leak on
 probe error and remove
In-Reply-To: <57f7989d-6f05-4b1b-a31b-4b1dca308ffb@mleia.com> (Vladimir
	Zapolskiy's message of "Mon, 3 Nov 2025 18:21:47 +0200")
References: <20251028094747.1089-1-vulab@iscas.ac.cn>
	<57f7989d-6f05-4b1b-a31b-4b1dca308ffb@mleia.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Tue, 04 Nov 2025 09:27:51 +0100
Message-ID: <871pmeb3so.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hello,

On 03/11/2025 at 18:21:47 +02, Vladimir Zapolskiy <vz@mleia.com> wrote:

> On 10/28/25 11:47, Haotian Zhang wrote:
>> The driver calls gpiod_get_optional() in the probe function but
>> never calls gpiod_put() in the remove function or in the probe
>> error path. This leads to a GPIO descriptor resource leak.
>> The lpc32xx_mlc.c driver in the same directory handles this
>> correctly by calling gpiod_put() on both paths.
>> Add gpiod_put() in the remove function and in the probe error path
>> to fix the resource leak.
>> Fixes: 6b923db2867c ("mtd: rawnand: lpc32xx_slc: switch to using gpiod
>> API")
>> Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
>
> The problem is well identified, thank you for the fix.
>
>> ---
>>   drivers/mtd/nand/raw/lpc32xx_slc.c | 2 ++
>>   1 file changed, 2 insertions(+)
>> diff --git a/drivers/mtd/nand/raw/lpc32xx_slc.c
>> b/drivers/mtd/nand/raw/lpc32xx_slc.c
>> index b54d76547ffb..fea3705a2138 100644
>> --- a/drivers/mtd/nand/raw/lpc32xx_slc.c
>> +++ b/drivers/mtd/nand/raw/lpc32xx_slc.c
>> @@ -937,6 +937,7 @@ static int lpc32xx_nand_probe(struct platform_device=
 *pdev)
>>   	dma_release_channel(host->dma_chan);
>>   enable_wp:
>>   	lpc32xx_wp_enable(host);
>> +	gpiod_put(host->wp_gpio);
>>     	return res;
>>   }
>> @@ -962,6 +963,7 @@ static void lpc32xx_nand_remove(struct platform_devi=
ce *pdev)
>>   	writel(tmp, SLC_CTRL(host->io_base));
>>     	lpc32xx_wp_enable(host);
>> +	gpiod_put(host->wp_gpio);
>>   }
>>     static int lpc32xx_nand_resume(struct platform_device *pdev)
>
> The fix can be greatly improved though, I kindly ask you to send v2 by sw=
itching
> from gpiod_get_optional() to resource managed
> devm_gpiod_get_optional().

I've already applied this fix, however I will welcome a follow-up patch.

Thanks,
Miqu=C3=A8l

