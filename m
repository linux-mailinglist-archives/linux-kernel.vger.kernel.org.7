Return-Path: <linux-kernel+bounces-874121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7E6C15967
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49F4A3AD9A8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 15:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2C0341ADE;
	Tue, 28 Oct 2025 15:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Si30Bw38"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C1F273D77
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 15:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761666114; cv=none; b=irdgrmBj5hS/JL1Fqtd/gWtHNlx5X4q0h3MGc87Jai2PSX2vkQ4yhwL60Ho/GcVE+1pmhRlnMgEdvbeMgICtTr/SxQ4lIE4g4CHnUxCpiza4zHyTkG0dfLIYMyu3AtdUyVjMhmZgcmaMzD/ZJvCrQGz2oEa7uTF3jJuaX8VbgkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761666114; c=relaxed/simple;
	bh=bEbBGo6SDi3T7IlWHXIwQmSF5urPM5A7yPazEXssXV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tg2WC6TWDn1KI+ivlg/vGMXoZmDDs5qpVffjpQk0JRHuiYta5qi0+RpDntteMiQrPRoOehy4/FTQQm6yVwDsHNio6+ftX48DuVh+GMVGp3DV9Z3GWEKKmTz3+cDgu/kO7g+16DUKv2YuAATuR3X+cCOOhHgRvl31pOlwbWMbZOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Si30Bw38; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-475dab5a5acso22223145e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 08:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761666111; x=1762270911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3rER/cj499mXACNSk+6J53aPnWJLF10EoyWFEaSt4oo=;
        b=Si30Bw389g3GhWg/ZXSUIuBfJTWNR+sdZH0c8/S1/EjF3PeXWMFvmw+6jE2FeSqHFt
         dhfk36NNCa+o8lwOn/5IZFWBB7FLcTMz5sbzHbB6r/0WbPqoVVPSnq0xntuihul+1OhT
         SuTzLmC81Tye4LKtX+VCcSp89JJTUVs5RhTkY1AdnYYgezMXS9nbXvhExzXOMApkCUzs
         HBdmS3+7EGL5QbmmYRMTgqeN00jXy4Ri7CWAXlstkLWLx+NmncpxBZxcDnfahG4XZZm6
         D4HmfM/RKiHAFdR6w9gT/pTGPDMKHaknMx3VVw1RlLCYYKpfW1bJpcA5Nm6jM/f7mN8/
         YU/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761666111; x=1762270911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3rER/cj499mXACNSk+6J53aPnWJLF10EoyWFEaSt4oo=;
        b=AJuUaB8wbP4bXMng9wSku/GzcLoRF6tqOfTYx1GQKuT4gTcLlWhn0MnUzf5zjPJxny
         cOlbG29UCYtBf75VHsFkCHaDga9nmoyQOVZRm7W9RlpDchLjQyAYHU7E/oQk2yPi15BQ
         9+fbjl92umoHYpJz2WWYJSF9VWMa1GoYlHoKiEJmBD1khZr2kAZ5ghhxRSUZ3rWzXnui
         XnBh41szHXEq/mFFV8nmjX99Gcj0xmlbVOrfDID7ijbXwled/2SWkH/PMlyKRSJ5TRz6
         OtKGhwHnblecrUDg22DmAMx8jMsYn+8IeSkI/e3k0GmnW1VF/ntWRemeoL/2H6tnZnTV
         +fTw==
X-Forwarded-Encrypted: i=1; AJvYcCX87qO72JE/N0MCxMmscMuIcmawTtDkm9koArbA69DlOujD7FMv+6bmhyh3+T2reJGxnAqkHefF65QlHys=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGfDYuCd/TMZovypBCvNVw35jGXoXXdkMOHecJ7IT9uMujBc+O
	aZAPqBeMBdsf6YNkk5vL4USBpqZuMT2g2xLdXlBCarBvbgKD69QoEcxi
X-Gm-Gg: ASbGnctF9gXifIZme1YFxsxRTOlSB1j1XSdMizeUT0/syU8jw1+W0QEMBdW5YZBYf+L
	npTaKaFfRU8GjS702Wbvf2iWvfhLssh8KzCNaufQTkmf0cnQqMfBXR4Hz4anhJR+J+QGfOjGxpl
	0IP0FjMR+5MieVpkcKu7GK8XH5JGCuuJycB1OEhoL52fvwBJcALOFFZfnNZazV5+ve+o0N7psiQ
	bRWPvEbx98Ro07qBVIKiiPmRxTtKLwwYJNnhRcsqhUhfU0KsiEho8bZSUUKk58KJ9S66FmTWbGc
	M7gqFY4DtTvvd5PDaKq7rf9yAguHGnLR0NCgfq2hFRsYpO+xRPmwCmngY7EsA+jXO2KXoHBZbIL
	cEV5Y0AJoak9PzQprSoI/Wl61NZrmR1SZA2k/Sw3V8F1P0MK5dhtnO8WgO51tLDfxj+IDdy95Zo
	O4bVA8AEC1AHTSCpoVeXMFfxr1j19DQKxJTq9FZc+geWc0+H5hE4+cIVN3HQ==
X-Google-Smtp-Source: AGHT+IHebAO0DlmEIORl7j8QOrOeKPGgCfKBhqbrcWGKnJH7ybidW69hal8hNOSPewAyQmQdvtJXuA==
X-Received: by 2002:a05:600c:1d1e:b0:46e:6a6a:5cec with SMTP id 5b1f17b1804b1-47717def7b5mr42201915e9.2.1761666110720;
        Tue, 28 Oct 2025 08:41:50 -0700 (PDT)
Received: from jernej-laptop.localnet (178-79-73-218.dynamic.telemach.net. [178.79.73.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771843eabfsm23130265e9.2.2025.10.28.08.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 08:41:50 -0700 (PDT)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>,
 Richard Genoud <richard.genoud@bootlin.com>
Cc: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>,
 Wentao Liang <vulab@iscas.ac.cn>, Johan Hovold <johan@kernel.org>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, Richard Genoud <richard.genoud@bootlin.com>
Subject:
 Re: [PATCH v4 07/16] mtd: rawnand: sunxi: rework pattern found registers
Date: Tue, 28 Oct 2025 16:41:48 +0100
Message-ID: <6097267.MhkbZ0Pkbq@jernej-laptop>
In-Reply-To: <20251028073534.526992-8-richard.genoud@bootlin.com>
References:
 <20251028073534.526992-1-richard.genoud@bootlin.com>
 <20251028073534.526992-8-richard.genoud@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne torek, 28. oktober 2025 ob 08:35:00 Srednjeevropski standardni =C4=8Das=
 je Richard Genoud napisal(a):
> On H6/H616, the register ECC_PAT_FOUND is at its own address, and not
> part of ECC status register.
> So, introduce the pattern found register offset in sunxi_nfc_caps, along
> with its mask.
>=20
> Also, introduce a non compile-time field_get() because FIELD_GET() and
> u32_get_bits() don't work with non compile-time constant.
> https://lore.kernel.org/all/cover.1761588465.git.geert+renesas@glider.be

Urls should use Link: tag and be placed at the bottom.

Code itself looks fine.

Best regards,
Jernej

>=20
> No functional change.
>=20
> Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
> ---
>  drivers/mtd/nand/raw/sunxi_nand.c | 36 ++++++++++++++++++++++++++-----
>  1 file changed, 31 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sun=
xi_nand.c
> index 89495d786293..021034a761b7 100644
> --- a/drivers/mtd/nand/raw/sunxi_nand.c
> +++ b/drivers/mtd/nand/raw/sunxi_nand.c
> @@ -29,6 +29,9 @@
>  #include <linux/iopoll.h>
>  #include <linux/reset.h>
> =20
> +/* non compile-time field get */
> +#define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
> +
>  #define NFC_REG_CTL		0x0000
>  #define NFC_REG_ST		0x0004
>  #define NFC_REG_INT		0x0008
> @@ -150,7 +153,13 @@
>  /* define bit use in NFC_ECC_ST */
>  #define NFC_ECC_ERR(x)		BIT(x)
>  #define NFC_ECC_ERR_MSK		GENMASK(15, 0)
> -#define NFC_ECC_PAT_FOUND(x)	BIT(x + 16)
> +
> +/*
> + * define bit use in NFC_REG_PAT_FOUND
> + * For A10/A23, NFC_REG_PAT_FOUND =3D=3D NFC_ECC_ST register
> + */
> +#define NFC_ECC_PAT_FOUND_MSK(nfc) (nfc->caps->pat_found_mask)
> +
>  #define NFC_ECC_ERR_CNT(b, x)	(((x) >> (((b) % 4) * 8)) & 0xff)
> =20
>  #define NFC_DEFAULT_TIMEOUT_MS	1000
> @@ -227,6 +236,8 @@ static inline struct sunxi_nand_chip *to_sunxi_nand(s=
truct nand_chip *nand)
>   * @reg_io_data:	I/O data register
>   * @reg_ecc_err_cnt:	ECC error counter register
>   * @reg_user_data:	User data register
> + * @reg_pat_found:	Data Pattern Status Register
> + * @pat_found_mask:	ECC_PAT_FOUND mask in NFC_REG_PAT_FOUND register
>   * @dma_maxburst:	DMA maxburst
>   * @ecc_strengths:	Available ECC strengths array
>   * @nstrengths:		Size of @ecc_strengths
> @@ -236,6 +247,8 @@ struct sunxi_nfc_caps {
>  	unsigned int reg_io_data;
>  	unsigned int reg_ecc_err_cnt;
>  	unsigned int reg_user_data;
> +	unsigned int reg_pat_found;
> +	unsigned int pat_found_mask;
>  	unsigned int dma_maxburst;
>  	const u8 *ecc_strengths;
>  	unsigned int nstrengths;
> @@ -776,7 +789,8 @@ static void sunxi_nfc_hw_ecc_update_stats(struct nand=
_chip *nand,
>  }
> =20
>  static int sunxi_nfc_hw_ecc_correct(struct nand_chip *nand, u8 *data, u8=
 *oob,
> -				    int step, u32 status, bool *erased)
> +				    int step, u32 status, u32 pattern_found,
> +				    bool *erased)
>  {
>  	struct sunxi_nfc *nfc =3D to_sunxi_nfc(nand->controller);
>  	struct nand_ecc_ctrl *ecc =3D &nand->ecc;
> @@ -787,7 +801,7 @@ static int sunxi_nfc_hw_ecc_correct(struct nand_chip =
*nand, u8 *data, u8 *oob,
>  	if (status & NFC_ECC_ERR(step))
>  		return -EBADMSG;
> =20
> -	if (status & NFC_ECC_PAT_FOUND(step)) {
> +	if (pattern_found & BIT(step)) {
>  		u8 pattern;
> =20
>  		if (unlikely(!(readl(nfc->regs + NFC_REG_PAT_ID) & 0x1))) {
> @@ -821,6 +835,7 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct nand_ch=
ip *nand,
>  	struct sunxi_nfc *nfc =3D to_sunxi_nfc(nand->controller);
>  	struct nand_ecc_ctrl *ecc =3D &nand->ecc;
>  	int raw_mode =3D 0;
> +	u32 pattern_found;
>  	bool erased;
>  	int ret;
> =20
> @@ -848,8 +863,12 @@ static int sunxi_nfc_hw_ecc_read_chunk(struct nand_c=
hip *nand,
> =20
>  	*cur_off =3D oob_off + ecc->bytes + USER_DATA_SZ;
> =20
> +	pattern_found =3D readl(nfc->regs + nfc->caps->reg_pat_found);
> +	pattern_found =3D field_get(NFC_ECC_PAT_FOUND_MSK(nfc), pattern_found);
> +
>  	ret =3D sunxi_nfc_hw_ecc_correct(nand, data, oob_required ? oob : NULL,=
 0,
>  				       readl(nfc->regs + NFC_REG_ECC_ST),
> +				       pattern_found,
>  				       &erased);
>  	if (erased)
>  		return 1;
> @@ -930,7 +949,7 @@ static int sunxi_nfc_hw_ecc_read_chunks_dma(struct na=
nd_chip *nand, uint8_t *buf
>  	unsigned int max_bitflips =3D 0;
>  	int ret, i, raw_mode =3D 0;
>  	struct scatterlist sg;
> -	u32 status, wait;
> +	u32 status, pattern_found, wait;
> =20
>  	ret =3D sunxi_nfc_wait_cmd_fifo_empty(nfc);
>  	if (ret)
> @@ -971,6 +990,8 @@ static int sunxi_nfc_hw_ecc_read_chunks_dma(struct na=
nd_chip *nand, uint8_t *buf
>  		return ret;
> =20
>  	status =3D readl(nfc->regs + NFC_REG_ECC_ST);
> +	pattern_found =3D readl(nfc->regs + nfc->caps->reg_pat_found);
> +	pattern_found =3D field_get(NFC_ECC_PAT_FOUND_MSK(nfc), pattern_found);
> =20
>  	for (i =3D 0; i < nchunks; i++) {
>  		int data_off =3D i * ecc->size;
> @@ -981,7 +1002,8 @@ static int sunxi_nfc_hw_ecc_read_chunks_dma(struct n=
and_chip *nand, uint8_t *buf
> =20
>  		ret =3D sunxi_nfc_hw_ecc_correct(nand, randomized ? data : NULL,
>  					       oob_required ? oob : NULL,
> -					       i, status, &erased);
> +					       i, status, pattern_found,
> +					       &erased);
> =20
>  		/* ECC errors are handled in the second loop. */
>  		if (ret < 0)
> @@ -2195,6 +2217,8 @@ static const struct sunxi_nfc_caps sunxi_nfc_a10_ca=
ps =3D {
>  	.reg_io_data =3D NFC_REG_A10_IO_DATA,
>  	.reg_ecc_err_cnt =3D NFC_REG_A10_ECC_ERR_CNT,
>  	.reg_user_data =3D NFC_REG_A10_USER_DATA,
> +	.reg_pat_found =3D NFC_REG_ECC_ST,
> +	.pat_found_mask =3D GENMASK(31, 16),
>  	.dma_maxburst =3D 4,
>  	.ecc_strengths =3D sunxi_ecc_strengths_a10,
>  	.nstrengths =3D ARRAY_SIZE(sunxi_ecc_strengths_a10),
> @@ -2205,6 +2229,8 @@ static const struct sunxi_nfc_caps sunxi_nfc_a23_ca=
ps =3D {
>  	.reg_io_data =3D NFC_REG_A23_IO_DATA,
>  	.reg_ecc_err_cnt =3D NFC_REG_A10_ECC_ERR_CNT,
>  	.reg_user_data =3D NFC_REG_A10_USER_DATA,
> +	.reg_pat_found =3D NFC_REG_ECC_ST,
> +	.pat_found_mask =3D GENMASK(31, 16),
>  	.dma_maxburst =3D 8,
>  	.ecc_strengths =3D sunxi_ecc_strengths_a10,
>  	.nstrengths =3D ARRAY_SIZE(sunxi_ecc_strengths_a10),
>=20





