Return-Path: <linux-kernel+bounces-864529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C55BFAFE5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EBDA58407B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 08:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0EE930C621;
	Wed, 22 Oct 2025 08:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="sz9Wv6lq"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2C23064B7
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761123258; cv=none; b=UmgpdpLLPeA4Z2OvfvSKQe763LiuSpj0Nipt9WO40lffscTBQeANql5u+uHU6wFe/nukR67GhmSuWlgGMxKNW6ptpK+KHIlr+ZI8ONE08u0ktkD8oaCu4ZAEbTyGwrOBlWdf31sgFjK1RSlA7UfhlNnlIVsbKh4PoP3YXyLwR7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761123258; c=relaxed/simple;
	bh=DEYRFaSu1tmNBtnf/PK4zwzFUdG2RV3KAPhG/SSA4/E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QZ6hP5ZTGUhUJVdfvgVA9EEhi9iySzIAY0RRUvcXwvWLpshPoKcyfLDklEt6ebdO1j7CN8Liqg5bqsickx7wOLqgNs9m0ZvXOyDRXWAIjKsOeA17NLlHtfCMUVpr5QIHjuHQ6yKpZAMmG4MSwsFSsOyk+TS/pN6DY1JnV46XM2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=sz9Wv6lq; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 427974E41260;
	Wed, 22 Oct 2025 08:54:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0E381606DC;
	Wed, 22 Oct 2025 08:54:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 557A8102F242F;
	Wed, 22 Oct 2025 10:54:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761123251; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=UdkqHbshapC7nZY4/zFoditcNqEk/iGcG2EMytEmpUc=;
	b=sz9Wv6lqYxBw+efub1O+67sRO5hj1GJKSrnQlOg8RP6sH79keyWGAzsK4Q+4n1BMEdB7VS
	TYOlusTcal3NLBThus+SARMOan5OGVRHZIorH9GQCpJoigQOUA9yFIoEoNLMT3yx+Sjvdd
	aWFll3rPZFjgq12I1YFpGxjlTEjVrsIAMG94T945WWTouRh4oilP/lVIsQ9J9DYlk3fS0D
	RCns2kaBXugtb8nVvJoIciKphHOiT+lUAdK7dT+UZflZ4C4hdMp+ZOrBIv5J5MOX5exH06
	3pUkH8Zf3TmQhgbiLKKoyN6L/DLMNpHiQDj1Jx5+laX7Shvkj31BB/uuvktcWg==
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
Subject: Re: [PATCH v3 04/15] mtd: rawnand: sunxi: introduce reg_user_data
 in sunxi_nfc_caps
In-Reply-To: <20251020101311.256819-5-richard.genoud@bootlin.com> (Richard
	Genoud's message of "Mon, 20 Oct 2025 12:13:00 +0200")
References: <20251020101311.256819-1-richard.genoud@bootlin.com>
	<20251020101311.256819-5-richard.genoud@bootlin.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Wed, 22 Oct 2025 10:54:02 +0200
Message-ID: <87y0p3tiz9.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hi Richard,

On 20/10/2025 at 12:13:00 +02, Richard Genoud <richard.genoud@bootlin.com> =
wrote:

> The H6/H616 USER_DATA register is not at the same offset as the
> A10/A23 one, so move its offset into sunxi_nfc_caps
>
> No functional change.
>
> Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
> ---
>  drivers/mtd/nand/raw/sunxi_nand.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sun=
xi_nand.c
> index 0285e4d0ca7f..8f5d8df19e33 100644
> --- a/drivers/mtd/nand/raw/sunxi_nand.c
> +++ b/drivers/mtd/nand/raw/sunxi_nand.c
> @@ -48,7 +48,8 @@
>  #define NFC_REG_DEBUG		0x003C
>  #define NFC_REG_A10_ECC_ERR_CNT	0x0040
>  #define NFC_REG_ECC_ERR_CNT(nfc, x)	((nfc->caps->reg_ecc_err_cnt + (x)) =
& ~0x3)
> -#define NFC_REG_USER_DATA(x)	(0x0050 + ((x) * 4))
> +#define NFC_REG_A10_USER_DATA	0x0050
> +#define NFC_REG_USER_DATA(nfc, x)	(nfc->caps->reg_user_data + ((x) * 4))
>  #define NFC_REG_SPARE_AREA	0x00A0
>  #define NFC_REG_PAT_ID		0x00A4
>  #define NFC_REG_MDMA_ADDR	0x00C0
> @@ -214,6 +215,7 @@ static inline struct sunxi_nand_chip *to_sunxi_nand(s=
truct nand_chip *nand)
>   *			through MBUS on A23/A33 needs extra configuration.
>   * @reg_io_data:	I/O data register
>   * @reg_ecc_err_cnt:	ECC error counter register
> + * @reg_user_data:	User data register
>   * @dma_maxburst:	DMA maxburst
>   * @ecc_strengths:	Available ECC strengths array
>   * @nstrengths:		Size of @ecc_strengths
> @@ -222,6 +224,7 @@ struct sunxi_nfc_caps {
>  	bool has_mdma;
>  	unsigned int reg_io_data;
>  	unsigned int reg_ecc_err_cnt;
> +	unsigned int reg_user_data;
>  	unsigned int dma_maxburst;
>  	const u8 *ecc_strengths;
>  	unsigned int nstrengths;
> @@ -723,8 +726,8 @@ static void sunxi_nfc_hw_ecc_get_prot_oob_bytes(struc=
t nand_chip *nand, u8 *oob,
>  {
>  	struct sunxi_nfc *nfc =3D to_sunxi_nfc(nand->controller);
>=20=20
> -	sunxi_nfc_user_data_to_buf(readl(nfc->regs + NFC_REG_USER_DATA(step)),
> -				   oob);
> +	sunxi_nfc_user_data_to_buf(readl(nfc->regs +
> +					 NFC_REG_USER_DATA(nfc, step)),
> oob);

Minor nit, column limit is 100 now, so typically for this kind of
situation everything would fit on a single line.

Don't respin just for that if there is nothing else later, but if a v4
is needed you can change it.

Looks neat otherwise so far.

Thanks,
Miqu=C3=A8l

