Return-Path: <linux-kernel+bounces-873180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A1451C134F6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 08:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DE0624F4ADB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 07:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C5A246327;
	Tue, 28 Oct 2025 07:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="1Y+wzb7U"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F58D1C84A0
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 07:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761636641; cv=none; b=fMv+XMOaxYp6Q6sSupCY6YNdcY8IQ8GSqxI4R3thn1ovv3n0wpoPvcT/7L83Hz+pgd10YhS+Ehx07zUIVI1ztgJScXRREGiGiDTJuyoihExxhzs61wBkz4uRa+fx+E8k7FpfoEbSCVCXUB6/9PKPu4nV2ltA9YppRYh85RDRKEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761636641; c=relaxed/simple;
	bh=tgz/rtEYPnPsQJqZHHt5kVcRM6gfdi9tPqQHwZfBnFw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=eLacrpCbXskGUEdN/fUVG/ABBVSXiQlhuBbmdd3RisS/r9rT7aVgOeXdeicGpxJrXP84EmT3PbtcT43zdmFSV4f5Y9ktXkbTY55ibpglGlg6uDC2mWBi9PibZxIGq1imQcNkmPPIX4YyHTe88vBN7UtOc+fjvF7r2jNoTKGLRH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=1Y+wzb7U; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 7FE191A16E5;
	Tue, 28 Oct 2025 07:30:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 517D5606AB;
	Tue, 28 Oct 2025 07:30:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 50BFD102F2511;
	Tue, 28 Oct 2025 08:30:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761636634; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=xs89r8H28EFiXnm/zzZ/Zym5khL0vOyiwLDrFtHPdCQ=;
	b=1Y+wzb7UUJ61PlahSm8nRwugGzVzHAklP8KvqU1naq4LkJTh6EVjdR9QB+HkyhPM/23+Ik
	8JxBOOwNk6N2aOfNDEeftgV7q2UXOSnD2/++xlMR9N0OgLLfBObu4XQccPwAmmBvQTB2bt
	t7bhmwOYUZ0nME43CU413N3RjnODMgyNWlu/TBJ53iy5bz/59mDAAqXCXF6vMeEHbENRtU
	jDgCxfC2s8YGsTesIXo++jJum/TR+Gy51avfvbU0JOWlRNOFS7izyCZxPBVbCzrXg52BWJ
	HkxL7rUGsAwxzPp/7HP3EuPQscpm7FnfKxak+X+Ug2Ul2nyWPnqy20ZXljzk4w==
Message-ID: <795aa141-e977-4628-826f-f65715afaf9d@bootlin.com>
Date: Tue, 28 Oct 2025 08:30:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Richard GENOUD <richard.genoud@bootlin.com>
Subject: Re: [PATCH v3 13/15] mtd: rawnand: sunxi: Add support for H616 nand
 controller
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
 <20251020101311.256819-14-richard.genoud@bootlin.com>
 <87ecqvthv4.fsf@bootlin.com>
Content-Language: en-US, fr
Organization: Bootlin
In-Reply-To: <87ecqvthv4.fsf@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Le 22/10/2025 à 11:18, Miquel Raynal a écrit :
> Hello Richard,
> 
> On 20/10/2025 at 12:13:09 +02, Richard Genoud <richard.genoud@bootlin.com> wrote:
> 
>> The H616 nand controller has the same base as A10/A23, with some
>> differences:
>> - mdma is based on chained buffers
>> - its ECC supports up to 80bit per 1024bytes
>> - some registers layouts are a bit different, mainly due do the stronger
>>    ECC.
>> - it uses USER_DATA_LEN registers along USER_DATA registers.
>> - it needs a specific clock for ECC and MBUS.
>>
>> Introduce the basic support, with ECC and scrambling, but without
>> DMA/MDMA.
>>
>> Tested on Whatsminer H616 board (with and without scrambling, ECC)
>>
>> Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
> 
> ...
> 
>>   
>> +#define NFC_TIMING_CFG2(tCDQSS, tSC, tCLHZ, tCSS, tWC)		\
>> +	((((tCDQSS) & 0x1) << 11) | (((tSC) & 0x3) << 12) |	\
>> +	 (((tCLHZ) & 0x3) << 14) | (((tCSS) & 0x3) << 16) |	\
>> +	 (((tWC) & 0x3) << 18))
>> +
>>   /* define bit use in NFC_CMD */
>>   #define NFC_CMD_LOW_BYTE_MSK	GENMASK(7, 0)
>> -#define NFC_CMD_HIGH_BYTE_MSK	GENMASK(15, 8)
>> +#define NFC_CMD_HIGH_BYTE_MSK	GENMASK(15, 8)  // 15-10 reserved on H6
> 
> Wrong comment type :-)
ok

> 
>> +#define NFC_CMD_ADR_NUM_MSK	GENMASK(9, 8)
>>   #define NFC_CMD(x)		(x)
>>   #define NFC_ADR_NUM_MSK		GENMASK(18, 16)
>>   #define NFC_ADR_NUM(x)		(((x) - 1) << 16)
>> @@ -122,6 +156,7 @@
>>   #define NFC_SEQ			BIT(25)
>>   #define NFC_DATA_SWAP_METHOD	BIT(26)
>>   #define NFC_ROW_AUTO_INC	BIT(27)
>> +#define NFC_H6_SEND_RND_CMD2	BIT(27)
>>   #define NFC_SEND_CMD3		BIT(28)
>>   #define NFC_SEND_CMD4		BIT(29)
>>   #define NFC_CMD_TYPE_MSK	GENMASK(31, 30)
>> @@ -133,6 +168,7 @@
>>   #define NFC_READ_CMD_MSK	GENMASK(7, 0)
>>   #define NFC_RND_READ_CMD0_MSK	GENMASK(15, 8)
>>   #define NFC_RND_READ_CMD1_MSK	GENMASK(23, 16)
>> +#define NFC_RND_READ_CMD2_MSK	GENMASK(31, 24)
> 
> ...
> 
>> @@ -858,6 +967,8 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct nand_chip *nand,
>>   	if (ret)
>>   		return ret;
>>   
>> +	sunxi_nfc_reset_user_data_len(nfc);
>> +	sunxi_nfc_set_user_data_len(nfc, 4, 0);
> 
> I'm not sure I understand this properly. Why isn't this a fixed setting?
> Also, what is 4? It is not obvious to me and my require either a comment
> or a define (or maybe a sizeof()).

Yes, indeed. There are '4' all over the place, maybe a bit of tidy up is 
needed in a separate patch.
(and some explanations)

I'll resend a v4 with that.

> 
>>   	sunxi_nfc_randomizer_config(nand, page, false);
>>   	sunxi_nfc_randomizer_enable(nand);
>>   	writel(NFC_DATA_TRANS | NFC_DATA_SWAP_METHOD | NFC_ECC_OP,
>> @@ -968,6 +1079,8 @@ static int sunxi_nfc_hw_ecc_read_chunks_dma(struct nand_chip *nand, uint8_t *buf
>>   		return ret;
>>   
>>   	sunxi_nfc_hw_ecc_enable(nand);
>> +	sunxi_nfc_reset_user_data_len(nfc);
>> +	sunxi_nfc_set_user_data_len(nfc, 4, 0);
>>   	sunxi_nfc_randomizer_config(nand, page, false);
>>   	sunxi_nfc_randomizer_enable(nand);
>>   
>> @@ -1100,6 +1213,8 @@ static int sunxi_nfc_hw_ecc_write_chunk(struct nand_chip *nand,
>>   
>>   	sunxi_nfc_randomizer_config(nand, page, false);
>>   	sunxi_nfc_randomizer_enable(nand);
>> +	sunxi_nfc_reset_user_data_len(nfc);
>> +	sunxi_nfc_set_user_data_len(nfc, 4, 0);
>>   	sunxi_nfc_hw_ecc_set_prot_oob_bytes(nand, oob, 0, bbm, page);
>>   
>>   	writel(NFC_DATA_TRANS | NFC_DATA_SWAP_METHOD |
>> @@ -1344,10 +1459,12 @@ static int sunxi_nfc_hw_ecc_write_page_dma(struct nand_chip *nand,
>>   	if (ret)
>>   		goto pio_fallback;
>>   
>> +	sunxi_nfc_reset_user_data_len(nfc);
>>   	for (i = 0; i < ecc->steps; i++) {
>>   		const u8 *oob = nand->oob_poi + (i * (ecc->bytes + 4));
>>   
>>   		sunxi_nfc_hw_ecc_set_prot_oob_bytes(nand, oob, i, !i, page);
>> +		sunxi_nfc_set_user_data_len(nfc, 4, i);
> 
> Here you use it differently, maybe a bit of explanation in a comment
> could help.
> 
yes, definitely

>>   	}
>>   
>>   	nand_prog_page_begin_op(nand, page, 0, NULL, 0);
>> @@ -2148,6 +2265,10 @@ static int sunxi_nfc_probe(struct platform_device *pdev)
>>   	if (irq < 0)
>>   		return irq;
>>   
>> +	nfc->caps = of_device_get_match_data(dev);
>> +	if (!nfc->caps)
>> +		return -EINVAL;
>> +
>>   	nfc->ahb_clk = devm_clk_get_enabled(dev, "ahb");
>>   	if (IS_ERR(nfc->ahb_clk)) {
>>   		dev_err(dev, "failed to retrieve ahb clk\n");
>> @@ -2160,6 +2281,22 @@ static int sunxi_nfc_probe(struct platform_device *pdev)
>>   		return PTR_ERR(nfc->mod_clk);
>>   	}
>>   
> 
> ...
> 
>>   static const struct sunxi_nfc_caps sunxi_nfc_a10_caps = {
>>   	.has_ecc_block_512 = true,
>> +	.has_ecc_clk = false,
>> +	.has_mbus_clk = false,
> 
> As you want, but setting these fields (and below) to false is not
> strictly required as they will be set to 0 (which means false,
> automatically).
> 
yes, I'll remove them.

>>   	.reg_io_data = NFC_REG_A10_IO_DATA,
>>   	.reg_ecc_err_cnt = NFC_REG_A10_ECC_ERR_CNT,
>>   	.reg_user_data = NFC_REG_A10_USER_DATA,
>> @@ -2242,11 +2383,14 @@ static const struct sunxi_nfc_caps sunxi_nfc_a10_caps = {
>>   	.dma_maxburst = 4,
>>   	.ecc_strengths = sunxi_ecc_strengths_a10,
>>   	.nstrengths = ARRAY_SIZE(sunxi_ecc_strengths_a10),
>> +	.max_ecc_steps = 16,
>>   	.sram_size = 1024,
>>   };
>>   
> 
>> +static const struct sunxi_nfc_caps sunxi_nfc_h616_caps = {
>> +	.has_mdma = false, // H616 supports only chained descriptors
> 
> Wrong comment type :-)
I'll drop this line also.

> 
> LGTM otherwise.
> 
> Thanks,
> Miquèl
Thanks!

-- 
Richard Genoud, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

