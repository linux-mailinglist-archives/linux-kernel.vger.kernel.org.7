Return-Path: <linux-kernel+bounces-850463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A6EBD2E3D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 14:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 519983A5191
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 12:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0013D25B1CE;
	Mon, 13 Oct 2025 12:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="powh/tvt"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730501F4703
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 12:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760356906; cv=none; b=rm3ck8dArrz89V1J6sXXjW27y/qyGtlV8hHKXtGgZ8De+mPY7mN6wEDqBgifYERJ9hNPVDl/HeysXix09Fa915Izc+e3CX8igM4GZNRKIpqUwtwJJmJKS4Ff6x/q3oFYPDYOqmdKtHr4363jp4TFiyOIeN+rb7bMbd8obiEOV6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760356906; c=relaxed/simple;
	bh=DOM0o2CuYrs5IJ/vHS6B/dKgzJ0oDvoznAxAewUfzks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AoHOHSIa/rdCx7OXqXS6wh073vIS35oyHaL7BEpd+NbkZ3Gt1Rebmy8/wCeaRcWS5CX8O4iV0qim6FwTbPQPPV0JjXWP63RE6FSCj/+oU1YWJvyFIZGsZHkx8dWIDlk33za37FOJQjDZ6NyqGx25F1U7n4/AYb/580ollpSvYT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=powh/tvt; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id EC6B8C093AB;
	Mon, 13 Oct 2025 12:01:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DCC48606C6;
	Mon, 13 Oct 2025 12:01:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E0139102F225F;
	Mon, 13 Oct 2025 14:01:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760356902; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=A2Am9RxeL4qenx6LEjtOTRzh04rzYyxX+YGi6enft4I=;
	b=powh/tvtK15QeSwTgpDjrBgf4qKVSU82JLyGSof7TylTfn8rTKDJQfH9Zl6O1H3bLkgTEr
	cxzKzEqcQA6JzxWZAS5x+q/DQifiaUtL0wryyA/FsX7BZ6MYS+AkBzRqU1WXgnpIE7MvWY
	4jIkVvvx+x16BTU0xgUuTggubeLFr/Twdo/XdlONFLbu/0j64k0SZwz0dPL0hVU7wB+TD0
	7ul1OEXshqUl43MCopk4E2ptSVNHSAkZmyk6N+OzczUVC9bAOAWq6r36sYKl6uzeUIEWPx
	rI1n6jluHopzGHnwdhc+8EaC+qPyJQFdc4cJLcOUs+HPyBIyxQB3/mA2XSLfuA==
Message-ID: <bd78a5ff-d5d6-4eca-923e-5a3b5d0a0f12@bootlin.com>
Date: Mon, 13 Oct 2025 14:01:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/15] mtd: rawnand: sunxi: Add support for H616 nand
 controller
To: =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Samuel Holland <samuel@sholland.org>
Cc: Wentao Liang <vulab@iscas.ac.cn>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20251010084042.341224-1-richard.genoud@bootlin.com>
 <20251010084042.341224-16-richard.genoud@bootlin.com>
 <3373475.aeNJFYEL58@jernej-laptop>
From: Richard GENOUD <richard.genoud@bootlin.com>
Content-Language: en-US, fr
Organization: Bootlin
In-Reply-To: <3373475.aeNJFYEL58@jernej-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Le 11/10/2025 à 12:48, Jernej Škrabec a écrit :
> Dne petek, 10. oktober 2025 ob 10:40:42 Srednjeevropski poletni čas je Richard Genoud napisal(a):
>> The H616 nand controller has the same base as A10/A23, with some
>> differences:
>> - mdma is based on chained buffers
>> - its ECC supports up to 80bit per 1024bytes
>> - some registers layouts are a bit different, mainly due do the stronger
>>    ECC.
>> - it uses USER_DATA_LEN registers along USER_DATA registers.
>> - it needs a specific clock for ECC and MBUS.
>>
>> This patch introduce the basic support, without DMA/MDMA.
>>
>> Tested on Whatsminer H616 board (with and without scrambling, ECC)
>>
>> Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
>> ---
>>   drivers/mtd/nand/raw/sunxi_nand.c | 182 ++++++++++++++++++++++++++++--
>>   1 file changed, 174 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
>> index e81d74c6633a..1e1185f8d980 100644
>> --- a/drivers/mtd/nand/raw/sunxi_nand.c
>> +++ b/drivers/mtd/nand/raw/sunxi_nand.c
>> @@ -49,17 +49,40 @@
>>   #define NFC_REG_A23_IO_DATA	0x0300
>>   #define NFC_REG_ECC_CTL		0x0034
>>   #define NFC_REG_ECC_ST		0x0038
>> -#define NFC_REG_DEBUG		0x003C
>> +#define NFC_REG_H6_PAT_FOUND	0x003C
>>   #define NFC_REG_A10_ECC_ERR_CNT	0x0040
>> +#define NFC_REG_H6_ECC_ERR_CNT	0x0050
>>   #define NFC_REG_ECC_ERR_CNT(nfc, x)	((nfc->caps->reg_ecc_err_cnt + (x)) & ~0x3)
>> +#define NFC_REG_H6_RDATA_CTL	0x0044
>> +#define NFC_REG_H6_RDATA_0	0x0048
>> +#define NFC_REG_H6_RDATA_1	0x004C
>>   #define NFC_REG_A10_USER_DATA	0x0050
>> +#define NFC_REG_H6_USER_DATA	0x0080
>>   #define NFC_REG_USER_DATA(nfc, x)	(nfc->caps->reg_user_data + ((x) * 4))
>> +#define NFC_REG_H6_USER_DATA_LEN 0x0070
>> +/* A USER_DATA_LEN register can hold the length of 8 USER_DATA registers */
>> +#define NFC_REG_USER_DATA_LEN_CAPACITY 8
>> +#define NFC_REG_USER_DATA_LEN(nfc, step) \
>> +	 (nfc->caps->reg_user_data_len + \
>> +	 ((step) / NFC_REG_USER_DATA_LEN_CAPACITY) * 4)
>>   #define NFC_REG_SPARE_AREA(nfc) (nfc->caps->reg_spare_area)
>>   #define NFC_REG_A10_SPARE_AREA	0x00A0
>>   #define NFC_REG_PAT_ID(nfc) (nfc->caps->reg_pat_id)
>>   #define NFC_REG_A10_PAT_ID	0x00A4
>>   #define NFC_REG_MDMA_ADDR	0x00C0
>>   #define NFC_REG_MDMA_CNT	0x00C4
>> +#define NFC_REG_H6_EFNAND_STATUS 0x0110
>> +#define NFC_REG_H6_SPARE_AREA	0x0114
>> +#define NFC_REG_H6_PAT_ID	0x0118
>> +#define NFC_REG_H6_DDR2_SPEC_CTL 0x011C
>> +#define NFC_REG_H6_NDMA_MODE_CTL 0x0120
>> +#define NFC_REG_H6_MDMA_DLBA_REG 0x0200
>> +#define NFC_REG_H6_MDMA_STA	0x0204
>> +#define NFC_REG_H6_MDMA_INT_MAS	0x0208
>> +#define NFC_REG_H6_MDMA_DESC_ADDR 0x020C
>> +#define NFC_REG_H6_MDMA_BUF_ADDR 0x0210
>> +#define NFC_REG_H6_MDMA_CNT	0x0214
>> +
>>   #define NFC_RAM0_BASE		0x0400
>>   #define NFC_RAM1_BASE		0x0800
>>   
>> @@ -71,6 +94,7 @@
>>   #define NFC_BUS_WIDTH_16	(1 << 2)
>>   #define NFC_RB_SEL_MSK		BIT(3)
>>   #define NFC_RB_SEL(x)		((x) << 3)
>> +/* CE_SEL BIT 27 is meant to be used for GPIO chipselect */
>>   #define NFC_CE_SEL_MSK		GENMASK(26, 24)
>>   #define NFC_CE_SEL(x)		((x) << 24)
>>   #define NFC_CE_CTL		BIT(6)
>> @@ -89,6 +113,9 @@
>>   #define NFC_STA			BIT(4)
>>   #define NFC_NATCH_INT_FLAG	BIT(5)
>>   #define NFC_RB_STATE(x)		BIT(x + 8)
>> +#define NFC_RB_STATE_MSK	GENMASK(11, 8)
>> +#define NDFC_RDATA_STA_1	BIT(12)
>> +#define NDFC_RDATA_STA_0	BIT(13)
>>   
>>   /* define bit use in NFC_INT */
>>   #define NFC_B2R_INT_ENABLE	BIT(0)
>> @@ -100,6 +127,7 @@
>>   
>>   /* define bit use in NFC_TIMING_CTL */
>>   #define NFC_TIMING_CTL_EDO	BIT(8)
>> +#define NFC_TIMING_CTL_E_EDO	BIT(9)
>>   
>>   /* define NFC_TIMING_CFG register layout */
>>   #define NFC_TIMING_CFG(tWB, tADL, tWHR, tRHW, tCAD)		\
>> @@ -107,9 +135,15 @@
>>   	(((tWHR) & 0x3) << 4) | (((tRHW) & 0x3) << 6) |		\
>>   	(((tCAD) & 0x7) << 8))
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
>>   
>>   /* define bit use in NFC_WCMD_SET */
>>   #define NFC_PROGRAM_CMD_MSK	GENMASK(7, 0)
>> @@ -150,6 +186,9 @@
>>   #define NFC_RANDOM_DIRECTION(nfc) (nfc->caps->random_dir_mask)
>>   #define NFC_ECC_MODE_MSK(nfc)	(nfc->caps->ecc_mode_mask)
>>   #define NFC_ECC_MODE(nfc, x)	field_prep(NFC_ECC_MODE_MSK(nfc), (x))
>> +/* RANDOM_PAGE_SIZE: 0: ECC block size  1: page size */
>> +#define NFC_A23_RANDOM_PAGE_SIZE	BIT(11)
>> +#define NFC_H6_RANDOM_PAGE_SIZE	BIT(7)
>>   #define NFC_RANDOM_SEED_MSK	GENMASK(30, 16)
>>   #define NFC_RANDOM_SEED(x)	((x) << 16)
>>   
>> @@ -165,6 +204,9 @@
>>   
>>   #define NFC_ECC_ERR_CNT(b, x)	(((x) >> (((b) % 4) * 8)) & 0xff)
>>   
>> +#define NFC_USER_DATA_LEN_MSK(step) \
>> +	(0xf << (((step) % NFC_REG_USER_DATA_LEN_CAPACITY) * 4))
>> +
>>   #define NFC_DEFAULT_TIMEOUT_MS	1000
>>   
>>   #define NFC_MAX_CS		7
>> @@ -224,9 +266,11 @@ static inline struct sunxi_nand_chip *to_sunxi_nand(struct nand_chip *nand)
>>    * @has_mdma:		Use mbus dma mode, otherwise general dma
>>    *			through MBUS on A23/A33 needs extra configuration.
>>    * @has_ecc_block_512:	If the ECC can handle 512B or only 1024B chuncks
>> + * @has_mbus_clk:	If the controller needs a mbus clock.
>>    * @reg_io_data:	I/O data register
>>    * @reg_ecc_err_cnt:	ECC error counter register
>>    * @reg_user_data:	User data register
>> + * @reg_user_data_len:	User data length register
>>    * @reg_spare_area:	Spare Area Register
>>    * @reg_pat_id:		Pattern ID Register
>>    * @reg_pat_found:	Data Pattern Status Register
>> @@ -238,14 +282,23 @@ static inline struct sunxi_nand_chip *to_sunxi_nand(struct nand_chip *nand)
>>    * @dma_maxburst:	DMA maxburst
>>    * @ecc_strengths:	Available ECC strengths array
>>    * @nstrengths:		Size of @ecc_strengths
>> + * @max_ecc_steps:	Maximum supported steps for ECC, this is also the
>> + *			number of user data registers
>> + * @user_data_len_tab:  Table of lenghts supported by USER_DATA_LEN register
>> + *			The table index is the value to set in NFC_USER_DATA_LEN
>> + *			registers, and the corresponding value is the number of
>> + *			bytes to write
>> + * @nuser_data_tab:	Size of @user_data_len_tab
>>    * @sram_size:		Size of the NAND controller SRAM
>>    */
>>   struct sunxi_nfc_caps {
>>   	bool has_mdma;
>>   	bool has_ecc_block_512;
>> +	bool has_mbus_clk;
>>   	unsigned int reg_io_data;
>>   	unsigned int reg_ecc_err_cnt;
>>   	unsigned int reg_user_data;
>> +	unsigned int reg_user_data_len;
>>   	unsigned int reg_spare_area;
>>   	unsigned int reg_pat_id;
>>   	unsigned int reg_pat_found;
>> @@ -257,6 +310,9 @@ struct sunxi_nfc_caps {
>>   	unsigned int dma_maxburst;
>>   	const u8 *ecc_strengths;
>>   	unsigned int nstrengths;
>> +	const u8 *user_data_len_tab;
>> +	unsigned int nuser_data_tab;
>> +	unsigned int max_ecc_steps;
>>   	int sram_size;
>>   };
>>   
>> @@ -268,6 +324,7 @@ struct sunxi_nfc_caps {
>>    * @regs: NAND controller registers
>>    * @ahb_clk: NAND controller AHB clock
>>    * @mod_clk: NAND controller mod clock
>> + * @ecc_clk: NAND controller ECC clock
>>    * @reset: NAND controller reset line
>>    * @assigned_cs: bitmask describing already assigned CS lines
>>    * @clk_rate: NAND controller current clock rate
>> @@ -282,7 +339,9 @@ struct sunxi_nfc {
>>   	struct device *dev;
>>   	void __iomem *regs;
>>   	struct clk *ahb_clk;
>> +	struct clk *mbus_clk;
>>   	struct clk *mod_clk;
>> +	struct clk *ecc_clk;
>>   	struct reset_control *reset;
>>   	unsigned long assigned_cs;
>>   	unsigned long clk_rate;
>> @@ -764,6 +823,53 @@ static void sunxi_nfc_hw_ecc_get_prot_oob_bytes(struct nand_chip *nand, u8 *oob,
>>   		sunxi_nfc_randomize_bbm(nand, page, oob);
>>   }
>>   
>> +/*
>> + * On H6/H6 the user_data length has to be set in specific registers
>> + * before writing.
>> + */
>> +static void sunxi_nfc_reset_user_data_len(struct sunxi_nfc *nfc)
>> +{
>> +	int loop_step = NFC_REG_USER_DATA_LEN_CAPACITY;
>> +
>> +	/* not all SoCs have this register */
>> +	if (!nfc->caps->reg_user_data_len)
>> +		return;
>> +
>> +	for (int i = 0; i < nfc->caps->max_ecc_steps; i += loop_step)
>> +		writel(0, nfc->regs + NFC_REG_USER_DATA_LEN(nfc, i));
>> +}
>> +
>> +static void sunxi_nfc_set_user_data_len(struct sunxi_nfc *nfc,
>> +					int len, int step)
>> +{
>> +	bool found = false;
>> +	u32 val;
>> +	int i;
>> +
>> +	/* not all SoCs have this register */
>> +	if (!nfc->caps->reg_user_data_len)
>> +		return;
>> +
>> +	for (i = 0; i < nfc->caps->nuser_data_tab; i++) {
>> +		if (len == nfc->caps->user_data_len_tab[i]) {
>> +			found = true;
>> +			break;
>> +		}
>> +	}
>> +
>> +	if (!found) {
>> +		dev_warn(nfc->dev,
>> +			 "Unsupported length for user data reg: %d\n", len);
>> +		return;
>> +	}
>> +
>> +	val = readl(nfc->regs + NFC_REG_USER_DATA_LEN(nfc, step));
>> +
>> +	val &= ~NFC_USER_DATA_LEN_MSK(step);
>> +	val |= field_prep(NFC_USER_DATA_LEN_MSK(step), i);
>> +	writel(val, nfc->regs + NFC_REG_USER_DATA_LEN(nfc, step));
>> +}
>> +
>>   static void sunxi_nfc_hw_ecc_set_prot_oob_bytes(struct nand_chip *nand,
>>   						const u8 *oob, int step,
>>   						bool bbm, int page)
>> @@ -858,6 +964,8 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct nand_chip *nand,
>>   	if (ret)
>>   		return ret;
>>   
>> +	sunxi_nfc_reset_user_data_len(nfc);
>> +	sunxi_nfc_set_user_data_len(nfc, 4, 0);
>>   	sunxi_nfc_randomizer_config(nand, page, false);
>>   	sunxi_nfc_randomizer_enable(nand);
>>   	writel(NFC_DATA_TRANS | NFC_DATA_SWAP_METHOD | NFC_ECC_OP,
>> @@ -968,6 +1076,8 @@ static int sunxi_nfc_hw_ecc_read_chunks_dma(struct nand_chip *nand, uint8_t *buf
>>   		return ret;
>>   
>>   	sunxi_nfc_hw_ecc_enable(nand);
>> +	sunxi_nfc_reset_user_data_len(nfc);
>> +	sunxi_nfc_set_user_data_len(nfc, 4, 0);
>>   	sunxi_nfc_randomizer_config(nand, page, false);
>>   	sunxi_nfc_randomizer_enable(nand);
>>   
>> @@ -1100,6 +1210,8 @@ static int sunxi_nfc_hw_ecc_write_chunk(struct nand_chip *nand,
>>   
>>   	sunxi_nfc_randomizer_config(nand, page, false);
>>   	sunxi_nfc_randomizer_enable(nand);
>> +	sunxi_nfc_reset_user_data_len(nfc);
>> +	sunxi_nfc_set_user_data_len(nfc, 4, 0);
>>   	sunxi_nfc_hw_ecc_set_prot_oob_bytes(nand, oob, 0, bbm, page);
>>   
>>   	writel(NFC_DATA_TRANS | NFC_DATA_SWAP_METHOD |
>> @@ -1344,10 +1456,12 @@ static int sunxi_nfc_hw_ecc_write_page_dma(struct nand_chip *nand,
>>   	if (ret)
>>   		goto pio_fallback;
>>   
>> +	sunxi_nfc_reset_user_data_len(nfc);
>>   	for (i = 0; i < ecc->steps; i++) {
>>   		const u8 *oob = nand->oob_poi + (i * (ecc->bytes + 4));
>>   
>>   		sunxi_nfc_hw_ecc_set_prot_oob_bytes(nand, oob, i, !i, page);
>> +		sunxi_nfc_set_user_data_len(nfc, 4, i);
>>   	}
>>   
>>   	nand_prog_page_begin_op(nand, page, 0, NULL, 0);
>> @@ -2148,18 +2262,36 @@ static int sunxi_nfc_probe(struct platform_device *pdev)
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
>>   		return PTR_ERR(nfc->ahb_clk);
>>   	}
>>   
>> +	if (nfc->caps->has_mbus_clk) {
>> +		nfc->mbus_clk = devm_clk_get_enabled(dev, "mbus");
>> +		if (IS_ERR(nfc->mbus_clk)) {
>> +			dev_err(dev, "No mbus clock specified\n");
>> +			return PTR_ERR(nfc->mbus_clk);
>> +		}
>> +	}
>> +
>>   	nfc->mod_clk = devm_clk_get_enabled(dev, "mod");
>>   	if (IS_ERR(nfc->mod_clk)) {
>>   		dev_err(dev, "failed to retrieve mod clk\n");
>>   		return PTR_ERR(nfc->mod_clk);
>>   	}
>>   
>> +	nfc->ecc_clk = devm_clk_get_optional_enabled(dev, "ecc");
>> +	if (IS_ERR(nfc->ecc_clk)) {
>> +		dev_err(dev, "failed to retrieve ecc clk\n");
>> +		return PTR_ERR(nfc->ecc_clk);
>> +	}
>> +
>>   	nfc->reset = devm_reset_control_get_optional_exclusive(dev, "ahb");
>>   	if (IS_ERR(nfc->reset))
>>   		return PTR_ERR(nfc->reset);
>> @@ -2170,12 +2302,6 @@ static int sunxi_nfc_probe(struct platform_device *pdev)
>>   		return ret;
>>   	}
>>   
>> -	nfc->caps = of_device_get_match_data(&pdev->dev);
>> -	if (!nfc->caps) {
>> -		ret = -EINVAL;
>> -		goto out_ahb_reset_reassert;
>> -	}
>> -
>>   	ret = sunxi_nfc_rst(nfc);
>>   	if (ret)
>>   		goto out_ahb_reset_reassert;
>> @@ -2226,8 +2352,17 @@ static const u8 sunxi_ecc_strengths_a10[] = {
>>   	16, 24, 28, 32, 40, 48, 56, 60, 64
>>   };
>>   
>> +static const u8 sunxi_ecc_strengths_h6[] = {
>> +	16, 24, 28, 32, 40, 44, 48, 52, 56, 60, 64, 68, 72, 76, 80
>> +};
>> +
>> +static const u8 sunxi_user_data_len_h6[] = {
>> +	0, 4, 8, 12, 16, 20, 24, 28, 32
>> +};
>> +
>>   static const struct sunxi_nfc_caps sunxi_nfc_a10_caps = {
>>   	.has_ecc_block_512 = true,
>> +	.has_mbus_clk = false,
>>   	.reg_io_data = NFC_REG_A10_IO_DATA,
>>   	.reg_ecc_err_cnt = NFC_REG_A10_ECC_ERR_CNT,
>>   	.reg_user_data = NFC_REG_A10_USER_DATA,
>> @@ -2242,11 +2377,13 @@ static const struct sunxi_nfc_caps sunxi_nfc_a10_caps = {
>>   	.dma_maxburst = 4,
>>   	.ecc_strengths = sunxi_ecc_strengths_a10,
>>   	.nstrengths = ARRAY_SIZE(sunxi_ecc_strengths_a10),
>> +	.max_ecc_steps = 16,
>>   	.sram_size = 1024,
>>   };
>>   
>>   static const struct sunxi_nfc_caps sunxi_nfc_a23_caps = {
>>   	.has_mdma = true,
>> +	.has_mbus_clk = false,
>>   	.has_ecc_block_512 = true,
>>   	.reg_io_data = NFC_REG_A23_IO_DATA,
>>   	.reg_ecc_err_cnt = NFC_REG_A10_ECC_ERR_CNT,
>> @@ -2262,9 +2399,34 @@ static const struct sunxi_nfc_caps sunxi_nfc_a23_caps = {
>>   	.dma_maxburst = 8,
>>   	.ecc_strengths = sunxi_ecc_strengths_a10,
>>   	.nstrengths = ARRAY_SIZE(sunxi_ecc_strengths_a10),
>> +	.max_ecc_steps = 16,
>>   	.sram_size = 1024,
>>   };
>>   
>> +static const struct sunxi_nfc_caps sunxi_nfc_h616_caps = {
>> +	.has_mdma = false, // H6 supports only chained descriptors
> 
> H6 or H616?
Yes, it should be H616. I'll change that.

Thanks!

> 
> Fix the comment.
> 
> Best regards,
> Jernej
> 
>> +	.has_mbus_clk = true,
>> +	.reg_io_data = NFC_REG_A23_IO_DATA,
>> +	.reg_ecc_err_cnt = NFC_REG_H6_ECC_ERR_CNT,
>> +	.reg_user_data = NFC_REG_H6_USER_DATA,
>> +	.reg_user_data_len = NFC_REG_H6_USER_DATA_LEN,
>> +	.reg_spare_area = NFC_REG_H6_SPARE_AREA,
>> +	.reg_pat_id = NFC_REG_H6_PAT_ID,
>> +	.reg_pat_found = NFC_REG_H6_PAT_FOUND,
>> +	.random_en_mask = BIT(5),
>> +	.random_dir_mask = BIT(6),
>> +	.ecc_mode_mask = GENMASK(15, 8),
>> +	.ecc_err_mask = GENMASK(31, 0),
>> +	.pat_found_mask = GENMASK(31, 0),
>> +	.dma_maxburst = 8,
>> +	.ecc_strengths = sunxi_ecc_strengths_h6,
>> +	.nstrengths = ARRAY_SIZE(sunxi_ecc_strengths_h6),
>> +	.user_data_len_tab = sunxi_user_data_len_h6,
>> +	.nuser_data_tab = ARRAY_SIZE(sunxi_user_data_len_h6),
>> +	.max_ecc_steps = 32,
>> +	.sram_size = 8192,
>> +};
>> +
>>   static const struct of_device_id sunxi_nfc_ids[] = {
>>   	{
>>   		.compatible = "allwinner,sun4i-a10-nand",
>> @@ -2274,6 +2436,10 @@ static const struct of_device_id sunxi_nfc_ids[] = {
>>   		.compatible = "allwinner,sun8i-a23-nand-controller",
>>   		.data = &sunxi_nfc_a23_caps,
>>   	},
>> +	{
>> +		.compatible = "allwinner,sun50i-h616-nand-controller",
>> +		.data = &sunxi_nfc_h616_caps,
>> +	},
>>   	{ /* sentinel */ }
>>   };
>>   MODULE_DEVICE_TABLE(of, sunxi_nfc_ids);
>>
> 
> 
> 
> 


-- 
Richard Genoud, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

