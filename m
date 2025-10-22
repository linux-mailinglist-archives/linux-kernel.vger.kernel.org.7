Return-Path: <linux-kernel+bounces-864588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 13AC2BFB1F3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 11:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2DCF54FA1C2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 09:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1172571A0;
	Wed, 22 Oct 2025 09:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="OF2J3E5A"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C2730EF84;
	Wed, 22 Oct 2025 09:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761124704; cv=none; b=ffPJhrPNl2SAJTgPi1GhdexJImZ05xAHHzhn+ZPrUT4sUQCYgMNiiMsNarfkna4nDq1QASHYS0+qlpFEA9qRQ8TS1C4trxDB/rR6TDkAL+S7cv543lg5h3acZSGbtM5AMY5z4wRU3MB9deXloKJx2xeatyJNTUx+Lg+RZ0jUv44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761124704; c=relaxed/simple;
	bh=FGCr1siS9EZNF4C9OKmn3apBGtbCDYLUAtCd/WlrkcM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=poR9XY993drtIKc9pRzS0e8mR2UrIybThRso3B2qWLxuhmEFhe3tjqVwLuIyrrGn9niTh372ZLdFJ+8HWJ1dsgTteLmobm3emEYWjSFMMtGkTCZoGYB8IfXEUXH/0/SJWOmIalKHjn6B+ktzmdHQ4bpZ8T1ypba5AhKwyaM+ekE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=OF2J3E5A; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 4BF414E41261;
	Wed, 22 Oct 2025 09:18:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1FD07606DC;
	Wed, 22 Oct 2025 09:18:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BB8D8102F2424;
	Wed, 22 Oct 2025 11:18:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761124698; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=LNEtH9lG/yvOebKMsji3DJq4oD0CU5SvCjoqyEyuZJY=;
	b=OF2J3E5AqsRwJZUe/GRi6I4GRKXFbvqbO/tcH7qL3QxWQQyacXCI2N81rs8SHmBRk42pei
	mDcgLvkOpYtZ128tfw0QgBcbY/E2k4MUV7t/gHmWJHKhdVhNl+2JV4byn2kuJ3Fb38Zsif
	wpRUDMbFz+ApprQLi2TiA/7Lx9AvfUPkrFwOFsBlUEtUARyAwZIjKZ2yNUEO0IVZruZaFf
	6hL7qd09YkaJz04E2Nuj0oSbPtlR8xHZsN9HavVDoyhWhsS2LPUifxn/pvZzIR5unzRj2j
	YtuqYc8IuOEKk7cQUYupHAyPUGw8jaHFhFGi667+wSvG5a5gvBhR5n9ZA2yHfw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Richard Genoud <richard.genoud@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Rob Herring <robh@kernel.org>,  Krzysztof Kozlowski
 <krzk+dt@kernel.org>,  Conor Dooley <conor+dt@kernel.org>,  Chen-Yu Tsai
 <wens@csie.org>,  Jernej Skrabec <jernej.skrabec@gmail.com>,  Samuel
 Holland <samuel@sholland.org>,  Uwe =?utf-8?Q?Kleine-K=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>,  Wentao Liang <vulab@iscas.ac.cn>,  Johan
 Hovold <johan@kernel.org>,  Maxime Ripard <mripard@kernel.org>,  Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>,  linux-mtd@lists.infradead.org,
  devicetree@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
  linux-sunxi@lists.linux.dev,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 13/15] mtd: rawnand: sunxi: Add support for H616 nand
 controller
In-Reply-To: <20251020101311.256819-14-richard.genoud@bootlin.com> (Richard
	Genoud's message of "Mon, 20 Oct 2025 12:13:09 +0200")
References: <20251020101311.256819-1-richard.genoud@bootlin.com>
	<20251020101311.256819-14-richard.genoud@bootlin.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Wed, 22 Oct 2025 11:18:07 +0200
Message-ID: <87ecqvthv4.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hello Richard,

On 20/10/2025 at 12:13:09 +02, Richard Genoud <richard.genoud@bootlin.com> =
wrote:

> The H616 nand controller has the same base as A10/A23, with some
> differences:
> - mdma is based on chained buffers
> - its ECC supports up to 80bit per 1024bytes
> - some registers layouts are a bit different, mainly due do the stronger
>   ECC.
> - it uses USER_DATA_LEN registers along USER_DATA registers.
> - it needs a specific clock for ECC and MBUS.
>
> Introduce the basic support, with ECC and scrambling, but without
> DMA/MDMA.
>
> Tested on Whatsminer H616 board (with and without scrambling, ECC)
>
> Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>

...

>=20=20
> +#define NFC_TIMING_CFG2(tCDQSS, tSC, tCLHZ, tCSS, tWC)		\
> +	((((tCDQSS) & 0x1) << 11) | (((tSC) & 0x3) << 12) |	\
> +	 (((tCLHZ) & 0x3) << 14) | (((tCSS) & 0x3) << 16) |	\
> +	 (((tWC) & 0x3) << 18))
> +
>  /* define bit use in NFC_CMD */
>  #define NFC_CMD_LOW_BYTE_MSK	GENMASK(7, 0)
> -#define NFC_CMD_HIGH_BYTE_MSK	GENMASK(15, 8)
> +#define NFC_CMD_HIGH_BYTE_MSK	GENMASK(15, 8)  // 15-10 reserved on H6

Wrong comment type :-)

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

...

> @@ -858,6 +967,8 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct nand_ch=
ip *nand,
>  	if (ret)
>  		return ret;
>=20=20
> +	sunxi_nfc_reset_user_data_len(nfc);
> +	sunxi_nfc_set_user_data_len(nfc, 4, 0);

I'm not sure I understand this properly. Why isn't this a fixed setting?
Also, what is 4? It is not obvious to me and my require either a comment
or a define (or maybe a sizeof()).

>  	sunxi_nfc_randomizer_config(nand, page, false);
>  	sunxi_nfc_randomizer_enable(nand);
>  	writel(NFC_DATA_TRANS | NFC_DATA_SWAP_METHOD | NFC_ECC_OP,
> @@ -968,6 +1079,8 @@ static int sunxi_nfc_hw_ecc_read_chunks_dma(struct n=
and_chip *nand, uint8_t *buf
>  		return ret;
>=20=20
>  	sunxi_nfc_hw_ecc_enable(nand);
> +	sunxi_nfc_reset_user_data_len(nfc);
> +	sunxi_nfc_set_user_data_len(nfc, 4, 0);
>  	sunxi_nfc_randomizer_config(nand, page, false);
>  	sunxi_nfc_randomizer_enable(nand);
>=20=20
> @@ -1100,6 +1213,8 @@ static int sunxi_nfc_hw_ecc_write_chunk(struct nand=
_chip *nand,
>=20=20
>  	sunxi_nfc_randomizer_config(nand, page, false);
>  	sunxi_nfc_randomizer_enable(nand);
> +	sunxi_nfc_reset_user_data_len(nfc);
> +	sunxi_nfc_set_user_data_len(nfc, 4, 0);
>  	sunxi_nfc_hw_ecc_set_prot_oob_bytes(nand, oob, 0, bbm, page);
>=20=20
>  	writel(NFC_DATA_TRANS | NFC_DATA_SWAP_METHOD |
> @@ -1344,10 +1459,12 @@ static int sunxi_nfc_hw_ecc_write_page_dma(struct=
 nand_chip *nand,
>  	if (ret)
>  		goto pio_fallback;
>=20=20
> +	sunxi_nfc_reset_user_data_len(nfc);
>  	for (i =3D 0; i < ecc->steps; i++) {
>  		const u8 *oob =3D nand->oob_poi + (i * (ecc->bytes + 4));
>=20=20
>  		sunxi_nfc_hw_ecc_set_prot_oob_bytes(nand, oob, i, !i, page);
> +		sunxi_nfc_set_user_data_len(nfc, 4, i);

Here you use it differently, maybe a bit of explanation in a comment
could help.

>  	}
>=20=20
>  	nand_prog_page_begin_op(nand, page, 0, NULL, 0);
> @@ -2148,6 +2265,10 @@ static int sunxi_nfc_probe(struct platform_device =
*pdev)
>  	if (irq < 0)
>  		return irq;
>=20=20
> +	nfc->caps =3D of_device_get_match_data(dev);
> +	if (!nfc->caps)
> +		return -EINVAL;
> +
>  	nfc->ahb_clk =3D devm_clk_get_enabled(dev, "ahb");
>  	if (IS_ERR(nfc->ahb_clk)) {
>  		dev_err(dev, "failed to retrieve ahb clk\n");
> @@ -2160,6 +2281,22 @@ static int sunxi_nfc_probe(struct platform_device =
*pdev)
>  		return PTR_ERR(nfc->mod_clk);
>  	}
>=20=20

...

>  static const struct sunxi_nfc_caps sunxi_nfc_a10_caps =3D {
>  	.has_ecc_block_512 =3D true,
> +	.has_ecc_clk =3D false,
> +	.has_mbus_clk =3D false,

As you want, but setting these fields (and below) to false is not
strictly required as they will be set to 0 (which means false,
automatically).

>  	.reg_io_data =3D NFC_REG_A10_IO_DATA,
>  	.reg_ecc_err_cnt =3D NFC_REG_A10_ECC_ERR_CNT,
>  	.reg_user_data =3D NFC_REG_A10_USER_DATA,
> @@ -2242,11 +2383,14 @@ static const struct sunxi_nfc_caps sunxi_nfc_a10_=
caps =3D {
>  	.dma_maxburst =3D 4,
>  	.ecc_strengths =3D sunxi_ecc_strengths_a10,
>  	.nstrengths =3D ARRAY_SIZE(sunxi_ecc_strengths_a10),
> +	.max_ecc_steps =3D 16,
>  	.sram_size =3D 1024,
>  };
>=20=20

> +static const struct sunxi_nfc_caps sunxi_nfc_h616_caps =3D {
> +	.has_mdma =3D false, // H616 supports only chained descriptors

Wrong comment type :-)

LGTM otherwise.

Thanks,
Miqu=C3=A8l

