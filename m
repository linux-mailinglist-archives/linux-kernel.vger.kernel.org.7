Return-Path: <linux-kernel+bounces-849115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC71BCF3C9
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 12:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B956D19A1055
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 10:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F9A1B6D08;
	Sat, 11 Oct 2025 10:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DG9KgU7v"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5A322157F
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 10:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760179741; cv=none; b=jZE8+HeLL1YpbeG7pI0j5pfMdFtZQvcJPnoQz6kJ/MGPBEjoV5VgevBipslWnHftlsdcSt3TYMaBT+bMgo2NvvuD/O++2iyrDUobFx+ybYCKbSRcAA5Bbvzx0nz+4ph8Y+uSMGNjgYiDMfNvjEbjra48wW2JjuUxnlp9vKqxeE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760179741; c=relaxed/simple;
	bh=2G8iY+NBmkOOlBVfsSQX08v5CiSjtN47+o5YkrRUDR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J/yXxVpVVZ0bcwZD+5FxZV4F0UwT/iTbzikqsXhHl1YjFc7/5FcLePPeWU0Lvcafno7VScBs8vm7uyy1BPAWCi/ctmMZ8jZlu/5dFl1QO6/QqoWNSO6zslP+FCqRMJV2D/HOgzty4UudPz3xyqfVohhd6A0q0pgnSm2Pc7Dj0UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DG9KgU7v; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b3e9d633b78so493969466b.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 03:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760179733; x=1760784533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2I91w0Qs2bshI+j4YNRRyIMhvWlTFvUnbZnwMWPdg+Q=;
        b=DG9KgU7v7shOy9vGwNQfUO0AY2Euy0npjUmnOOhDxsr29zXA1W1isD3oJupObjW1Ly
         s6xN52MzaGalotLHk5vEs7RzoDqChul5ld+zisQKVj05aRTmH+Rap9ZTBdzntZB5GiiM
         hscXYcyqkiJtQfDnF1RzMC1VKtPWFEJQ6CRhebtK0Z3C290rq74fzqEgd3XXNuu/Gar2
         /QUCR/tX/4AwPRpO78qO7dyljf+DPT0VNFyMN7fIHD8gEJrCv186X2gfFNdMbXarQ6cH
         L6hmZN4738RQZjX2e4vU2ScrBCRwznTY6A7OPvstqjP4f78tdhJlsDxtnYz1maGWwELc
         nB8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760179733; x=1760784533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2I91w0Qs2bshI+j4YNRRyIMhvWlTFvUnbZnwMWPdg+Q=;
        b=gJBuDFVpFGNIVp5I4q79MyPpz2ulHDHulVgvrPx0+MIzNRWVpBbG2npTGo6asL9kGA
         yk1Yrs+dRXlUlPkofYXbWDILzFz1Vc00hiJZGoLs/iY5AswqEoVeLce9rSMw7YgxP0ev
         L2bbNSrgou5fgipszDrS32MKmObyATdJ6ECWOEtDGoxPrXv0jGEkJVIGJ9CRxEShy97G
         dP1KZKCqgBbesOHu0wXmkGkldyo9gyhshMLnhEhWGs9VYpcOGUDbhuoyEXRxz8IkxZOI
         IECeKNpJawpJ12I1bxrXcTuh/uKc8vmlpJC1uxKU4vCPj04IcZXRAzfE2FaqtKSsexmg
         p0WQ==
X-Forwarded-Encrypted: i=1; AJvYcCVITYTDU8Hl228+1VF5YJaWzIkEjmYR8raoJ0BO1ULf2lvC3a3Xp8K/5286Is3wQHbsGiBL68MXpY0UX7k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8KA38/n4CBWKPHMkRoUsFSTAN6S3n8Yyj0UzEh9rMRcAKL245
	CTj/sCQ7uhvONFn+EUE6srBLMKOnnEGIfE2mivdy9IIKPb+cI1HIDVRt
X-Gm-Gg: ASbGncs+nhbldsax0BnSfJyAivZngOFx2oiKfKlHoXVE2LBIQeU+1huggnxrxYQnypZ
	XGfWPXCwN9ZgOD0ZJKrTbcLPuEjR1fllUR0K66EFe6RcIYvl5qSvQvGSEO4q3q06R60so1C6dp9
	r2wPLPa+pwU5YoLbowJG0YQ6ZdTOmCYWcUYo+CPHRLjfHhYyLrAGcA9euFTeeJiMDTdMeg0fnBE
	s/u74G5Ve60Q2R64wuJPC9oqiIydryojiP7o6bWUQ5xUm7RT2f8JqIZIeKZznfXnxHakx0y5YnU
	qoqNhmgTCMHpDjkWPrcxpmMkBWNTXSgc0t4gDoccOb1Q/1TZQldNneGezbwRXZ8SUxzPRnEio8n
	dM2jRVqqLGNHbiB+dHwe4AwdKo2rX7GxM5PjxxYIkomyPlV0jvE92EK02yZ8Of60=
X-Google-Smtp-Source: AGHT+IFP5/4Tzd0trGXX0JnOU4Fhkm8XDoJ2gR7XxP4LMoc1aNDyuHK+ENXSYJWjGXz+Zc2MO378Yw==
X-Received: by 2002:a17:907:94c1:b0:afe:159:14b1 with SMTP id a640c23a62f3a-b50bd049ba7mr1631347666b.9.1760179733213;
        Sat, 11 Oct 2025 03:48:53 -0700 (PDT)
Received: from jernej-laptop.localnet ([188.159.248.16])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d951ceb4sm453411166b.72.2025.10.11.03.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Oct 2025 03:48:52 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>,
 Richard Genoud <richard.genoud@bootlin.com>
Cc: Wentao Liang <vulab@iscas.ac.cn>,
 Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, Richard Genoud <richard.genoud@bootlin.com>
Subject:
 Re: [PATCH 15/15] mtd: rawnand: sunxi: Add support for H616 nand controller
Date: Sat, 11 Oct 2025 12:48:51 +0200
Message-ID: <3373475.aeNJFYEL58@jernej-laptop>
In-Reply-To: <20251010084042.341224-16-richard.genoud@bootlin.com>
References:
 <20251010084042.341224-1-richard.genoud@bootlin.com>
 <20251010084042.341224-16-richard.genoud@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne petek, 10. oktober 2025 ob 10:40:42 Srednjeevropski poletni =C4=8Das je=
 Richard Genoud napisal(a):
> The H616 nand controller has the same base as A10/A23, with some
> differences:
> - mdma is based on chained buffers
> - its ECC supports up to 80bit per 1024bytes
> - some registers layouts are a bit different, mainly due do the stronger
>   ECC.
> - it uses USER_DATA_LEN registers along USER_DATA registers.
> - it needs a specific clock for ECC and MBUS.
>=20
> This patch introduce the basic support, without DMA/MDMA.
>=20
> Tested on Whatsminer H616 board (with and without scrambling, ECC)
>=20
> Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
> ---
>  drivers/mtd/nand/raw/sunxi_nand.c | 182 ++++++++++++++++++++++++++++--
>  1 file changed, 174 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sun=
xi_nand.c
> index e81d74c6633a..1e1185f8d980 100644
> --- a/drivers/mtd/nand/raw/sunxi_nand.c
> +++ b/drivers/mtd/nand/raw/sunxi_nand.c
> @@ -49,17 +49,40 @@
>  #define NFC_REG_A23_IO_DATA	0x0300
>  #define NFC_REG_ECC_CTL		0x0034
>  #define NFC_REG_ECC_ST		0x0038
> -#define NFC_REG_DEBUG		0x003C
> +#define NFC_REG_H6_PAT_FOUND	0x003C
>  #define NFC_REG_A10_ECC_ERR_CNT	0x0040
> +#define NFC_REG_H6_ECC_ERR_CNT	0x0050
>  #define NFC_REG_ECC_ERR_CNT(nfc, x)	((nfc->caps->reg_ecc_err_cnt + (x)) =
& ~0x3)
> +#define NFC_REG_H6_RDATA_CTL	0x0044
> +#define NFC_REG_H6_RDATA_0	0x0048
> +#define NFC_REG_H6_RDATA_1	0x004C
>  #define NFC_REG_A10_USER_DATA	0x0050
> +#define NFC_REG_H6_USER_DATA	0x0080
>  #define NFC_REG_USER_DATA(nfc, x)	(nfc->caps->reg_user_data + ((x) * 4))
> +#define NFC_REG_H6_USER_DATA_LEN 0x0070
> +/* A USER_DATA_LEN register can hold the length of 8 USER_DATA registers=
 */
> +#define NFC_REG_USER_DATA_LEN_CAPACITY 8
> +#define NFC_REG_USER_DATA_LEN(nfc, step) \
> +	 (nfc->caps->reg_user_data_len + \
> +	 ((step) / NFC_REG_USER_DATA_LEN_CAPACITY) * 4)
>  #define NFC_REG_SPARE_AREA(nfc) (nfc->caps->reg_spare_area)
>  #define NFC_REG_A10_SPARE_AREA	0x00A0
>  #define NFC_REG_PAT_ID(nfc) (nfc->caps->reg_pat_id)
>  #define NFC_REG_A10_PAT_ID	0x00A4
>  #define NFC_REG_MDMA_ADDR	0x00C0
>  #define NFC_REG_MDMA_CNT	0x00C4
> +#define NFC_REG_H6_EFNAND_STATUS 0x0110
> +#define NFC_REG_H6_SPARE_AREA	0x0114
> +#define NFC_REG_H6_PAT_ID	0x0118
> +#define NFC_REG_H6_DDR2_SPEC_CTL 0x011C
> +#define NFC_REG_H6_NDMA_MODE_CTL 0x0120
> +#define NFC_REG_H6_MDMA_DLBA_REG 0x0200
> +#define NFC_REG_H6_MDMA_STA	0x0204
> +#define NFC_REG_H6_MDMA_INT_MAS	0x0208
> +#define NFC_REG_H6_MDMA_DESC_ADDR 0x020C
> +#define NFC_REG_H6_MDMA_BUF_ADDR 0x0210
> +#define NFC_REG_H6_MDMA_CNT	0x0214
> +
>  #define NFC_RAM0_BASE		0x0400
>  #define NFC_RAM1_BASE		0x0800
> =20
> @@ -71,6 +94,7 @@
>  #define NFC_BUS_WIDTH_16	(1 << 2)
>  #define NFC_RB_SEL_MSK		BIT(3)
>  #define NFC_RB_SEL(x)		((x) << 3)
> +/* CE_SEL BIT 27 is meant to be used for GPIO chipselect */
>  #define NFC_CE_SEL_MSK		GENMASK(26, 24)
>  #define NFC_CE_SEL(x)		((x) << 24)
>  #define NFC_CE_CTL		BIT(6)
> @@ -89,6 +113,9 @@
>  #define NFC_STA			BIT(4)
>  #define NFC_NATCH_INT_FLAG	BIT(5)
>  #define NFC_RB_STATE(x)		BIT(x + 8)
> +#define NFC_RB_STATE_MSK	GENMASK(11, 8)
> +#define NDFC_RDATA_STA_1	BIT(12)
> +#define NDFC_RDATA_STA_0	BIT(13)
> =20
>  /* define bit use in NFC_INT */
>  #define NFC_B2R_INT_ENABLE	BIT(0)
> @@ -100,6 +127,7 @@
> =20
>  /* define bit use in NFC_TIMING_CTL */
>  #define NFC_TIMING_CTL_EDO	BIT(8)
> +#define NFC_TIMING_CTL_E_EDO	BIT(9)
> =20
>  /* define NFC_TIMING_CFG register layout */
>  #define NFC_TIMING_CFG(tWB, tADL, tWHR, tRHW, tCAD)		\
> @@ -107,9 +135,15 @@
>  	(((tWHR) & 0x3) << 4) | (((tRHW) & 0x3) << 6) |		\
>  	(((tCAD) & 0x7) << 8))
> =20
> +#define NFC_TIMING_CFG2(tCDQSS, tSC, tCLHZ, tCSS, tWC)		\
> +	((((tCDQSS) & 0x1) << 11) | (((tSC) & 0x3) << 12) |	\
> +	 (((tCLHZ) & 0x3) << 14) | (((tCSS) & 0x3) << 16) |	\
> +	 (((tWC) & 0x3) << 18))
> +
>  /* define bit use in NFC_CMD */
>  #define NFC_CMD_LOW_BYTE_MSK	GENMASK(7, 0)
> -#define NFC_CMD_HIGH_BYTE_MSK	GENMASK(15, 8)
> +#define NFC_CMD_HIGH_BYTE_MSK	GENMASK(15, 8)  // 15-10 reserved on H6
> +#define NFC_CMD_ADR_NUM_MSK	GENMASK(9, 8)
>  #define NFC_CMD(x)		(x)
>  #define NFC_ADR_NUM_MSK		GENMASK(18, 16)
>  #define NFC_ADR_NUM(x)		(((x) - 1) << 16)
> @@ -122,6 +156,7 @@
>  #define NFC_SEQ			BIT(25)
>  #define NFC_DATA_SWAP_METHOD	BIT(26)
>  #define NFC_ROW_AUTO_INC	BIT(27)
> +#define NFC_H6_SEND_RND_CMD2	BIT(27)
>  #define NFC_SEND_CMD3		BIT(28)
>  #define NFC_SEND_CMD4		BIT(29)
>  #define NFC_CMD_TYPE_MSK	GENMASK(31, 30)
> @@ -133,6 +168,7 @@
>  #define NFC_READ_CMD_MSK	GENMASK(7, 0)
>  #define NFC_RND_READ_CMD0_MSK	GENMASK(15, 8)
>  #define NFC_RND_READ_CMD1_MSK	GENMASK(23, 16)
> +#define NFC_RND_READ_CMD2_MSK	GENMASK(31, 24)
> =20
>  /* define bit use in NFC_WCMD_SET */
>  #define NFC_PROGRAM_CMD_MSK	GENMASK(7, 0)
> @@ -150,6 +186,9 @@
>  #define NFC_RANDOM_DIRECTION(nfc) (nfc->caps->random_dir_mask)
>  #define NFC_ECC_MODE_MSK(nfc)	(nfc->caps->ecc_mode_mask)
>  #define NFC_ECC_MODE(nfc, x)	field_prep(NFC_ECC_MODE_MSK(nfc), (x))
> +/* RANDOM_PAGE_SIZE: 0: ECC block size  1: page size */
> +#define NFC_A23_RANDOM_PAGE_SIZE	BIT(11)
> +#define NFC_H6_RANDOM_PAGE_SIZE	BIT(7)
>  #define NFC_RANDOM_SEED_MSK	GENMASK(30, 16)
>  #define NFC_RANDOM_SEED(x)	((x) << 16)
> =20
> @@ -165,6 +204,9 @@
> =20
>  #define NFC_ECC_ERR_CNT(b, x)	(((x) >> (((b) % 4) * 8)) & 0xff)
> =20
> +#define NFC_USER_DATA_LEN_MSK(step) \
> +	(0xf << (((step) % NFC_REG_USER_DATA_LEN_CAPACITY) * 4))
> +
>  #define NFC_DEFAULT_TIMEOUT_MS	1000
> =20
>  #define NFC_MAX_CS		7
> @@ -224,9 +266,11 @@ static inline struct sunxi_nand_chip *to_sunxi_nand(=
struct nand_chip *nand)
>   * @has_mdma:		Use mbus dma mode, otherwise general dma
>   *			through MBUS on A23/A33 needs extra configuration.
>   * @has_ecc_block_512:	If the ECC can handle 512B or only 1024B chuncks
> + * @has_mbus_clk:	If the controller needs a mbus clock.
>   * @reg_io_data:	I/O data register
>   * @reg_ecc_err_cnt:	ECC error counter register
>   * @reg_user_data:	User data register
> + * @reg_user_data_len:	User data length register
>   * @reg_spare_area:	Spare Area Register
>   * @reg_pat_id:		Pattern ID Register
>   * @reg_pat_found:	Data Pattern Status Register
> @@ -238,14 +282,23 @@ static inline struct sunxi_nand_chip *to_sunxi_nand=
(struct nand_chip *nand)
>   * @dma_maxburst:	DMA maxburst
>   * @ecc_strengths:	Available ECC strengths array
>   * @nstrengths:		Size of @ecc_strengths
> + * @max_ecc_steps:	Maximum supported steps for ECC, this is also the
> + *			number of user data registers
> + * @user_data_len_tab:  Table of lenghts supported by USER_DATA_LEN regi=
ster
> + *			The table index is the value to set in NFC_USER_DATA_LEN
> + *			registers, and the corresponding value is the number of
> + *			bytes to write
> + * @nuser_data_tab:	Size of @user_data_len_tab
>   * @sram_size:		Size of the NAND controller SRAM
>   */
>  struct sunxi_nfc_caps {
>  	bool has_mdma;
>  	bool has_ecc_block_512;
> +	bool has_mbus_clk;
>  	unsigned int reg_io_data;
>  	unsigned int reg_ecc_err_cnt;
>  	unsigned int reg_user_data;
> +	unsigned int reg_user_data_len;
>  	unsigned int reg_spare_area;
>  	unsigned int reg_pat_id;
>  	unsigned int reg_pat_found;
> @@ -257,6 +310,9 @@ struct sunxi_nfc_caps {
>  	unsigned int dma_maxburst;
>  	const u8 *ecc_strengths;
>  	unsigned int nstrengths;
> +	const u8 *user_data_len_tab;
> +	unsigned int nuser_data_tab;
> +	unsigned int max_ecc_steps;
>  	int sram_size;
>  };
> =20
> @@ -268,6 +324,7 @@ struct sunxi_nfc_caps {
>   * @regs: NAND controller registers
>   * @ahb_clk: NAND controller AHB clock
>   * @mod_clk: NAND controller mod clock
> + * @ecc_clk: NAND controller ECC clock
>   * @reset: NAND controller reset line
>   * @assigned_cs: bitmask describing already assigned CS lines
>   * @clk_rate: NAND controller current clock rate
> @@ -282,7 +339,9 @@ struct sunxi_nfc {
>  	struct device *dev;
>  	void __iomem *regs;
>  	struct clk *ahb_clk;
> +	struct clk *mbus_clk;
>  	struct clk *mod_clk;
> +	struct clk *ecc_clk;
>  	struct reset_control *reset;
>  	unsigned long assigned_cs;
>  	unsigned long clk_rate;
> @@ -764,6 +823,53 @@ static void sunxi_nfc_hw_ecc_get_prot_oob_bytes(stru=
ct nand_chip *nand, u8 *oob,
>  		sunxi_nfc_randomize_bbm(nand, page, oob);
>  }
> =20
> +/*
> + * On H6/H6 the user_data length has to be set in specific registers
> + * before writing.
> + */
> +static void sunxi_nfc_reset_user_data_len(struct sunxi_nfc *nfc)
> +{
> +	int loop_step =3D NFC_REG_USER_DATA_LEN_CAPACITY;
> +
> +	/* not all SoCs have this register */
> +	if (!nfc->caps->reg_user_data_len)
> +		return;
> +
> +	for (int i =3D 0; i < nfc->caps->max_ecc_steps; i +=3D loop_step)
> +		writel(0, nfc->regs + NFC_REG_USER_DATA_LEN(nfc, i));
> +}
> +
> +static void sunxi_nfc_set_user_data_len(struct sunxi_nfc *nfc,
> +					int len, int step)
> +{
> +	bool found =3D false;
> +	u32 val;
> +	int i;
> +
> +	/* not all SoCs have this register */
> +	if (!nfc->caps->reg_user_data_len)
> +		return;
> +
> +	for (i =3D 0; i < nfc->caps->nuser_data_tab; i++) {
> +		if (len =3D=3D nfc->caps->user_data_len_tab[i]) {
> +			found =3D true;
> +			break;
> +		}
> +	}
> +
> +	if (!found) {
> +		dev_warn(nfc->dev,
> +			 "Unsupported length for user data reg: %d\n", len);
> +		return;
> +	}
> +
> +	val =3D readl(nfc->regs + NFC_REG_USER_DATA_LEN(nfc, step));
> +
> +	val &=3D ~NFC_USER_DATA_LEN_MSK(step);
> +	val |=3D field_prep(NFC_USER_DATA_LEN_MSK(step), i);
> +	writel(val, nfc->regs + NFC_REG_USER_DATA_LEN(nfc, step));
> +}
> +
>  static void sunxi_nfc_hw_ecc_set_prot_oob_bytes(struct nand_chip *nand,
>  						const u8 *oob, int step,
>  						bool bbm, int page)
> @@ -858,6 +964,8 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct nand_ch=
ip *nand,
>  	if (ret)
>  		return ret;
> =20
> +	sunxi_nfc_reset_user_data_len(nfc);
> +	sunxi_nfc_set_user_data_len(nfc, 4, 0);
>  	sunxi_nfc_randomizer_config(nand, page, false);
>  	sunxi_nfc_randomizer_enable(nand);
>  	writel(NFC_DATA_TRANS | NFC_DATA_SWAP_METHOD | NFC_ECC_OP,
> @@ -968,6 +1076,8 @@ static int sunxi_nfc_hw_ecc_read_chunks_dma(struct n=
and_chip *nand, uint8_t *buf
>  		return ret;
> =20
>  	sunxi_nfc_hw_ecc_enable(nand);
> +	sunxi_nfc_reset_user_data_len(nfc);
> +	sunxi_nfc_set_user_data_len(nfc, 4, 0);
>  	sunxi_nfc_randomizer_config(nand, page, false);
>  	sunxi_nfc_randomizer_enable(nand);
> =20
> @@ -1100,6 +1210,8 @@ static int sunxi_nfc_hw_ecc_write_chunk(struct nand=
_chip *nand,
> =20
>  	sunxi_nfc_randomizer_config(nand, page, false);
>  	sunxi_nfc_randomizer_enable(nand);
> +	sunxi_nfc_reset_user_data_len(nfc);
> +	sunxi_nfc_set_user_data_len(nfc, 4, 0);
>  	sunxi_nfc_hw_ecc_set_prot_oob_bytes(nand, oob, 0, bbm, page);
> =20
>  	writel(NFC_DATA_TRANS | NFC_DATA_SWAP_METHOD |
> @@ -1344,10 +1456,12 @@ static int sunxi_nfc_hw_ecc_write_page_dma(struct=
 nand_chip *nand,
>  	if (ret)
>  		goto pio_fallback;
> =20
> +	sunxi_nfc_reset_user_data_len(nfc);
>  	for (i =3D 0; i < ecc->steps; i++) {
>  		const u8 *oob =3D nand->oob_poi + (i * (ecc->bytes + 4));
> =20
>  		sunxi_nfc_hw_ecc_set_prot_oob_bytes(nand, oob, i, !i, page);
> +		sunxi_nfc_set_user_data_len(nfc, 4, i);
>  	}
> =20
>  	nand_prog_page_begin_op(nand, page, 0, NULL, 0);
> @@ -2148,18 +2262,36 @@ static int sunxi_nfc_probe(struct platform_device=
 *pdev)
>  	if (irq < 0)
>  		return irq;
> =20
> +	nfc->caps =3D of_device_get_match_data(dev);
> +	if (!nfc->caps)
> +		return -EINVAL;
> +
>  	nfc->ahb_clk =3D devm_clk_get_enabled(dev, "ahb");
>  	if (IS_ERR(nfc->ahb_clk)) {
>  		dev_err(dev, "failed to retrieve ahb clk\n");
>  		return PTR_ERR(nfc->ahb_clk);
>  	}
> =20
> +	if (nfc->caps->has_mbus_clk) {
> +		nfc->mbus_clk =3D devm_clk_get_enabled(dev, "mbus");
> +		if (IS_ERR(nfc->mbus_clk)) {
> +			dev_err(dev, "No mbus clock specified\n");
> +			return PTR_ERR(nfc->mbus_clk);
> +		}
> +	}
> +
>  	nfc->mod_clk =3D devm_clk_get_enabled(dev, "mod");
>  	if (IS_ERR(nfc->mod_clk)) {
>  		dev_err(dev, "failed to retrieve mod clk\n");
>  		return PTR_ERR(nfc->mod_clk);
>  	}
> =20
> +	nfc->ecc_clk =3D devm_clk_get_optional_enabled(dev, "ecc");
> +	if (IS_ERR(nfc->ecc_clk)) {
> +		dev_err(dev, "failed to retrieve ecc clk\n");
> +		return PTR_ERR(nfc->ecc_clk);
> +	}
> +
>  	nfc->reset =3D devm_reset_control_get_optional_exclusive(dev, "ahb");
>  	if (IS_ERR(nfc->reset))
>  		return PTR_ERR(nfc->reset);
> @@ -2170,12 +2302,6 @@ static int sunxi_nfc_probe(struct platform_device =
*pdev)
>  		return ret;
>  	}
> =20
> -	nfc->caps =3D of_device_get_match_data(&pdev->dev);
> -	if (!nfc->caps) {
> -		ret =3D -EINVAL;
> -		goto out_ahb_reset_reassert;
> -	}
> -
>  	ret =3D sunxi_nfc_rst(nfc);
>  	if (ret)
>  		goto out_ahb_reset_reassert;
> @@ -2226,8 +2352,17 @@ static const u8 sunxi_ecc_strengths_a10[] =3D {
>  	16, 24, 28, 32, 40, 48, 56, 60, 64
>  };
> =20
> +static const u8 sunxi_ecc_strengths_h6[] =3D {
> +	16, 24, 28, 32, 40, 44, 48, 52, 56, 60, 64, 68, 72, 76, 80
> +};
> +
> +static const u8 sunxi_user_data_len_h6[] =3D {
> +	0, 4, 8, 12, 16, 20, 24, 28, 32
> +};
> +
>  static const struct sunxi_nfc_caps sunxi_nfc_a10_caps =3D {
>  	.has_ecc_block_512 =3D true,
> +	.has_mbus_clk =3D false,
>  	.reg_io_data =3D NFC_REG_A10_IO_DATA,
>  	.reg_ecc_err_cnt =3D NFC_REG_A10_ECC_ERR_CNT,
>  	.reg_user_data =3D NFC_REG_A10_USER_DATA,
> @@ -2242,11 +2377,13 @@ static const struct sunxi_nfc_caps sunxi_nfc_a10_=
caps =3D {
>  	.dma_maxburst =3D 4,
>  	.ecc_strengths =3D sunxi_ecc_strengths_a10,
>  	.nstrengths =3D ARRAY_SIZE(sunxi_ecc_strengths_a10),
> +	.max_ecc_steps =3D 16,
>  	.sram_size =3D 1024,
>  };
> =20
>  static const struct sunxi_nfc_caps sunxi_nfc_a23_caps =3D {
>  	.has_mdma =3D true,
> +	.has_mbus_clk =3D false,
>  	.has_ecc_block_512 =3D true,
>  	.reg_io_data =3D NFC_REG_A23_IO_DATA,
>  	.reg_ecc_err_cnt =3D NFC_REG_A10_ECC_ERR_CNT,
> @@ -2262,9 +2399,34 @@ static const struct sunxi_nfc_caps sunxi_nfc_a23_c=
aps =3D {
>  	.dma_maxburst =3D 8,
>  	.ecc_strengths =3D sunxi_ecc_strengths_a10,
>  	.nstrengths =3D ARRAY_SIZE(sunxi_ecc_strengths_a10),
> +	.max_ecc_steps =3D 16,
>  	.sram_size =3D 1024,
>  };
> =20
> +static const struct sunxi_nfc_caps sunxi_nfc_h616_caps =3D {
> +	.has_mdma =3D false, // H6 supports only chained descriptors

H6 or H616?

=46ix the comment.

Best regards,
Jernej

> +	.has_mbus_clk =3D true,
> +	.reg_io_data =3D NFC_REG_A23_IO_DATA,
> +	.reg_ecc_err_cnt =3D NFC_REG_H6_ECC_ERR_CNT,
> +	.reg_user_data =3D NFC_REG_H6_USER_DATA,
> +	.reg_user_data_len =3D NFC_REG_H6_USER_DATA_LEN,
> +	.reg_spare_area =3D NFC_REG_H6_SPARE_AREA,
> +	.reg_pat_id =3D NFC_REG_H6_PAT_ID,
> +	.reg_pat_found =3D NFC_REG_H6_PAT_FOUND,
> +	.random_en_mask =3D BIT(5),
> +	.random_dir_mask =3D BIT(6),
> +	.ecc_mode_mask =3D GENMASK(15, 8),
> +	.ecc_err_mask =3D GENMASK(31, 0),
> +	.pat_found_mask =3D GENMASK(31, 0),
> +	.dma_maxburst =3D 8,
> +	.ecc_strengths =3D sunxi_ecc_strengths_h6,
> +	.nstrengths =3D ARRAY_SIZE(sunxi_ecc_strengths_h6),
> +	.user_data_len_tab =3D sunxi_user_data_len_h6,
> +	.nuser_data_tab =3D ARRAY_SIZE(sunxi_user_data_len_h6),
> +	.max_ecc_steps =3D 32,
> +	.sram_size =3D 8192,
> +};
> +
>  static const struct of_device_id sunxi_nfc_ids[] =3D {
>  	{
>  		.compatible =3D "allwinner,sun4i-a10-nand",
> @@ -2274,6 +2436,10 @@ static const struct of_device_id sunxi_nfc_ids[] =
=3D {
>  		.compatible =3D "allwinner,sun8i-a23-nand-controller",
>  		.data =3D &sunxi_nfc_a23_caps,
>  	},
> +	{
> +		.compatible =3D "allwinner,sun50i-h616-nand-controller",
> +		.data =3D &sunxi_nfc_h616_caps,
> +	},
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(of, sunxi_nfc_ids);
>=20





