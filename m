Return-Path: <linux-kernel+bounces-868252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34ADAC04B57
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 808BD3BF49C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 07:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044DB2E6CDE;
	Fri, 24 Oct 2025 07:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="puPpxBP2"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26642E5B0D
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 07:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761290486; cv=none; b=r0/MPwWVXvld1wW/r56gy5P2t2mwgX4XttRoJ2wIlsxtiK7zvka2knE+DqMOJN5PDAO796ZHm2MsG0omJNgJndhQWGIo2h/fP3vPTpNiSDXCBzap0v1y2mMDkBfSq+O1qLNjuY8Da/vERm8Rwugaxh5D5QjujyEMh+8VUi/BqNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761290486; c=relaxed/simple;
	bh=lcb3dVn0iym9zJMs4diWzppG9w2vAuX9XMaRZbiaA4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hx39zibeIWqYPU4awBLDHanIRMSX/AqkX7DctnagUcjTz0JSPIX82x0EhFPlH/vh1TEE7vhYvNW3Ad55kQDMql7wuBr9PxsCJMQwlr+ZqowYebxXt/LI8yuSF9+ig9jpDkmmguOoKFREJV7+neadf5UqKDyRLgGHSoO1atM33as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=puPpxBP2; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 0167CC0C41B;
	Fri, 24 Oct 2025 07:21:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C4F6760703;
	Fri, 24 Oct 2025 07:21:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2EB30102F244A;
	Fri, 24 Oct 2025 09:21:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761290478; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=n2SfjqX6lNSkj1H/YLHGctb/htiBAD/kfjrbeKtoNe8=;
	b=puPpxBP2v/7GBLcTgiHZwflmwE+c7IIPgQnODmI+9FPa5WOXR1bQd1A8CnbxM3Q5gmoVsN
	W11z0YLDO+Hyl0+f1X0L3BRgUfkWUSA0Nk5meqcbJoQjvbpBVFLrkmhPMY5WtbbqkVsEBb
	g3D1EP4iu7g1a4P90Fi3n8fG/OTWe3/qunL0k9zXx3auk86Ki2ksYKvUxD6D1OCs3N/B+G
	kOfBP/AWnWTknh6ErkZfBhvn30fLexAoFDqVkvGnVnzcW1Ope7DSeuv1ahBltn9ngXH36U
	agAthTSviB78yes0nszNAjig8JoB75pyIOsYrn9m+byEn2fvIXgiWILHHQCr2A==
Message-ID: <f076f6a6-372a-41ff-a78a-48d1af4ec33d@bootlin.com>
Date: Fri, 24 Oct 2025 09:20:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/15] mtd: rawnand: sunxi: introduce reg_user_data in
 sunxi_nfc_caps
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
 <vigneshr@ti.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Wentao Liang <vulab@iscas.ac.cn>, Johan Hovold <johan@kernel.org>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20251020101311.256819-1-richard.genoud@bootlin.com>
 <20251020101311.256819-5-richard.genoud@bootlin.com>
 <87y0p3tiz9.fsf@bootlin.com>
From: Richard GENOUD <richard.genoud@bootlin.com>
Content-Language: en-US, fr
Organization: Bootlin
In-Reply-To: <87y0p3tiz9.fsf@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,
Le 22/10/2025 à 10:54, Miquel Raynal a écrit :
> Hi Richard,
> 
> On 20/10/2025 at 12:13:00 +02, Richard Genoud <richard.genoud@bootlin.com> wrote:
> 
>> The H6/H616 USER_DATA register is not at the same offset as the
>> A10/A23 one, so move its offset into sunxi_nfc_caps
>>
>> No functional change.
>>
>> Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
>> ---
>>   drivers/mtd/nand/raw/sunxi_nand.c | 13 +++++++++----
>>   1 file changed, 9 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
>> index 0285e4d0ca7f..8f5d8df19e33 100644
>> --- a/drivers/mtd/nand/raw/sunxi_nand.c
>> +++ b/drivers/mtd/nand/raw/sunxi_nand.c
>> @@ -48,7 +48,8 @@
>>   #define NFC_REG_DEBUG		0x003C
>>   #define NFC_REG_A10_ECC_ERR_CNT	0x0040
>>   #define NFC_REG_ECC_ERR_CNT(nfc, x)	((nfc->caps->reg_ecc_err_cnt + (x)) & ~0x3)
>> -#define NFC_REG_USER_DATA(x)	(0x0050 + ((x) * 4))
>> +#define NFC_REG_A10_USER_DATA	0x0050
>> +#define NFC_REG_USER_DATA(nfc, x)	(nfc->caps->reg_user_data + ((x) * 4))
>>   #define NFC_REG_SPARE_AREA	0x00A0
>>   #define NFC_REG_PAT_ID		0x00A4
>>   #define NFC_REG_MDMA_ADDR	0x00C0
>> @@ -214,6 +215,7 @@ static inline struct sunxi_nand_chip *to_sunxi_nand(struct nand_chip *nand)
>>    *			through MBUS on A23/A33 needs extra configuration.
>>    * @reg_io_data:	I/O data register
>>    * @reg_ecc_err_cnt:	ECC error counter register
>> + * @reg_user_data:	User data register
>>    * @dma_maxburst:	DMA maxburst
>>    * @ecc_strengths:	Available ECC strengths array
>>    * @nstrengths:		Size of @ecc_strengths
>> @@ -222,6 +224,7 @@ struct sunxi_nfc_caps {
>>   	bool has_mdma;
>>   	unsigned int reg_io_data;
>>   	unsigned int reg_ecc_err_cnt;
>> +	unsigned int reg_user_data;
>>   	unsigned int dma_maxburst;
>>   	const u8 *ecc_strengths;
>>   	unsigned int nstrengths;
>> @@ -723,8 +726,8 @@ static void sunxi_nfc_hw_ecc_get_prot_oob_bytes(struct nand_chip *nand, u8 *oob,
>>   {
>>   	struct sunxi_nfc *nfc = to_sunxi_nfc(nand->controller);
>>   
>> -	sunxi_nfc_user_data_to_buf(readl(nfc->regs + NFC_REG_USER_DATA(step)),
>> -				   oob);
>> +	sunxi_nfc_user_data_to_buf(readl(nfc->regs +
>> +					 NFC_REG_USER_DATA(nfc, step)),
>> oob);
> 
> Minor nit, column limit is 100 now, so typically for this kind of
> situation everything would fit on a single line.
Indeed, the 80 column limit has been loosened (but braille displays are 
still 80 cells max AFAIK).
Anyway, you're right, the 80-rule could be bent here for readability.

> 
> Don't respin just for that if there is nothing else later, but if a v4
> is needed you can change it.
> 
> Looks neat otherwise so far.
> 
> Thanks,
> Miquèl

Thanks!


-- 
Richard Genoud, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

