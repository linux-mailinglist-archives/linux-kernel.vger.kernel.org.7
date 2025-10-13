Return-Path: <linux-kernel+bounces-850461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E24A1BD2E31
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:00:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B8B63A5B23
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 12:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF18266B41;
	Mon, 13 Oct 2025 12:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="PON+IrG2"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071141514DC;
	Mon, 13 Oct 2025 12:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760356826; cv=none; b=ZEJAQbZuS1WESF4o/Tf0cnY+KQkdHoGu4xeJlqYxu3Qna/Wp0+4opjZCwaKmmm3kn7/2yQaBBijtvbIFfSQ6TzbQucl9AXJmsAQOSIiNRWQJHBcv5u9okGxJAMzTU42rmV4fJW+zimM8I/C7bXTLDJ81fCyNlpMA3LEZOevh0kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760356826; c=relaxed/simple;
	bh=Sa/75UHBs4RX4OvWkXA4txcr6Kg+Ozmx3zrtf7h9Wps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nUvYpNFs6Tj6q+KelVupmdd3uRE2R+HHL1ygpu8rOGordHXvWftBDb/cNUCc3MxWFBtPCsqeapiRa/4+AojfWV+GoIsBo8apr/ev1lRAUZnZ31owZ2/fbDY5CEzfaLvtRG23/UsErl8o4gdhD3wq52QFgnuZ8Vt+qXLZetTWvkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PON+IrG2; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 4A1D6C093AB;
	Mon, 13 Oct 2025 12:00:04 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3AAB3606C6;
	Mon, 13 Oct 2025 12:00:23 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 820F8102F2263;
	Mon, 13 Oct 2025 14:00:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760356822; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=KEly2LZ/ci8gWOTL9VFmSwxUpRyknITeUsfSdfjGXWc=;
	b=PON+IrG2YZZ0AQmxmKPBPmPxWfanJoZDq1KF1fXAZ8TfV8PpVQIGisX1y8TfAvY9gmI00e
	1hsO9q5JUnDEZCuZiuOCJp28t26rxy196nvxKtuakWafldeVBVvQQ3oFlQCX9qIAUqANJC
	Juiq/PGau5tF2xD6qVCMuSG3FwE12oRqWxGIVu+44H8BSvMP6zyZf/LLk4T4Ka3iGLn6tK
	VBfZW5GkpbLCGzuqn8+YDdKV+WRYnnY45i8BJE20v+q7Bji934nQRuhni+s/qpslGpt6aV
	bpfT95+bUr9rBci+SfTQn52zqQegF+LBMCb8z83UstmxzOACvRNPwn4u4Mp6kQ==
Message-ID: <7add8d87-0909-45f2-973c-299d86e26d58@bootlin.com>
Date: Mon, 13 Oct 2025 14:00:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/15] mtd: nand: sunxi: move ecc strenghts in
 sunxi_nfc_caps
To: =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>
Cc: Wentao Liang <vulab@iscas.ac.cn>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20251010084042.341224-1-richard.genoud@bootlin.com>
 <20251010084042.341224-5-richard.genoud@bootlin.com>
 <13861163.uLZWGnKmhe@jernej-laptop>
From: Richard GENOUD <richard.genoud@bootlin.com>
Content-Language: en-US, fr
Organization: Bootlin
In-Reply-To: <13861163.uLZWGnKmhe@jernej-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Le 11/10/2025 à 12:41, Jernej Škrabec a écrit :
> Hi!
> 
> Dne petek, 10. oktober 2025 ob 10:40:31 Srednjeevropski poletni čas je Richard Genoud napisal(a):
>> H6/H616 has more ecc strenghts.
>> This commit prepares the change.
>> No functional change.
> 
> Format looks weird. Reword message to something like moving ecc to caps which
> will allow expand support for newer cores.
> 
> Also, there should be empty line before "No functional change."

I'll reword that

Thanks!

> 
> Best regards,
> Jernej
> 
>>
>> Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
>> ---
>>   drivers/mtd/nand/raw/sunxi_nand.c | 20 ++++++++++++++++----
>>   1 file changed, 16 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
>> index 10a48e0d361f..198dd40f9220 100644
>> --- a/drivers/mtd/nand/raw/sunxi_nand.c
>> +++ b/drivers/mtd/nand/raw/sunxi_nand.c
>> @@ -213,11 +213,15 @@ static inline struct sunxi_nand_chip *to_sunxi_nand(struct nand_chip *nand)
>>    *			through MBUS on A23/A33 needs extra configuration.
>>    * @reg_io_data:	I/O data register
>>    * @dma_maxburst:	DMA maxburst
>> + * @ecc_strengths:	Available ECC strengths array
>> + * @nstrengths:		Size of @ecc_strengths
>>    */
>>   struct sunxi_nfc_caps {
>>   	bool has_mdma;
>>   	unsigned int reg_io_data;
>>   	unsigned int dma_maxburst;
>> +	const u8 *ecc_strengths;
>> +	unsigned int nstrengths;
>>   };
>>   
>>   /**
>> @@ -1619,9 +1623,9 @@ static int sunxi_nand_hw_ecc_ctrl_init(struct nand_chip *nand,
>>   				       struct nand_ecc_ctrl *ecc,
>>   				       struct device_node *np)
>>   {
>> -	static const u8 strengths[] = { 16, 24, 28, 32, 40, 48, 56, 60, 64 };
>>   	struct sunxi_nand_chip *sunxi_nand = to_sunxi_nand(nand);
>>   	struct sunxi_nfc *nfc = to_sunxi_nfc(nand->controller);
>> +	const u8 *strengths = nfc->caps->ecc_strengths;
>>   	struct mtd_info *mtd = nand_to_mtd(nand);
>>   	struct nand_device *nanddev = mtd_to_nanddev(mtd);
>>   	int nsectors;
>> @@ -1645,7 +1649,7 @@ static int sunxi_nand_hw_ecc_ctrl_init(struct nand_chip *nand,
>>   
>>   		ecc->strength = bytes * 8 / fls(8 * ecc->size);
>>   
>> -		for (i = 0; i < ARRAY_SIZE(strengths); i++) {
>> +		for (i = 0; i < nfc->caps->nstrengths; i++) {
>>   			if (strengths[i] > ecc->strength)
>>   				break;
>>   		}
>> @@ -1666,7 +1670,7 @@ static int sunxi_nand_hw_ecc_ctrl_init(struct nand_chip *nand,
>>   	}
>>   
>>   	/* Add ECC info retrieval from DT */
>> -	for (i = 0; i < ARRAY_SIZE(strengths); i++) {
>> +	for (i = 0; i < nfc->caps->nstrengths; i++) {
>>   		if (ecc->strength <= strengths[i]) {
>>   			/*
>>   			 * Update ecc->strength value with the actual strength
>> @@ -1677,7 +1681,7 @@ static int sunxi_nand_hw_ecc_ctrl_init(struct nand_chip *nand,
>>   		}
>>   	}
>>   
>> -	if (i >= ARRAY_SIZE(strengths)) {
>> +	if (i >= nfc->caps->nstrengths) {
>>   		dev_err(nfc->dev, "unsupported strength\n");
>>   		return -ENOTSUPP;
>>   	}
>> @@ -2167,15 +2171,23 @@ static void sunxi_nfc_remove(struct platform_device *pdev)
>>   		dma_release_channel(nfc->dmac);
>>   }
>>   
>> +static const u8 sunxi_ecc_strengths_a10[] = {
>> +	16, 24, 28, 32, 40, 48, 56, 60, 64
>> +};
>> +
>>   static const struct sunxi_nfc_caps sunxi_nfc_a10_caps = {
>>   	.reg_io_data = NFC_REG_A10_IO_DATA,
>>   	.dma_maxburst = 4,
>> +	.ecc_strengths = sunxi_ecc_strengths_a10,
>> +	.nstrengths = ARRAY_SIZE(sunxi_ecc_strengths_a10),
>>   };
>>   
>>   static const struct sunxi_nfc_caps sunxi_nfc_a23_caps = {
>>   	.has_mdma = true,
>>   	.reg_io_data = NFC_REG_A23_IO_DATA,
>>   	.dma_maxburst = 8,
>> +	.ecc_strengths = sunxi_ecc_strengths_a10,
>> +	.nstrengths = ARRAY_SIZE(sunxi_ecc_strengths_a10),
>>   };
>>   
>>   static const struct of_device_id sunxi_nfc_ids[] = {
>>
> 
> 
> 
> 


-- 
Richard Genoud, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

