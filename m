Return-Path: <linux-kernel+bounces-868275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ACD9C04C2F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 914F63ABBDA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 07:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922CD2E8B76;
	Fri, 24 Oct 2025 07:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NIdQ+BPc"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C712E764E
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 07:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761291495; cv=none; b=obhCA70s+Z/ESaL8kOMf/bwPtVngMSI99/J9jEC0U2HgSAMeBVE86h4H1d8Dxo5vInXCMxkU5x+PWpxXLjOVb8UvvpTg6+jO5GDpL797lLRmPaxK7crn1sI9a4+Qi3R++NYN/gvl6zgReOhcuMq6A4Qr0hQI2sIOu+7wWp9a3cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761291495; c=relaxed/simple;
	bh=FZmghaQw1LNdqilBOlckL5iL5N3eVvjOSrNsiCUFDkU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BCrfW5gkUdVdJRM6p9Oy829IZLtdHJVV0G//gob22eIAAEGKFw29IIzJqf4TCmEO/LlOOW3flO11E6y11ur3gBaqz5gRAkKHdOU7u5Wm7ESmHaC+RkvMu0nS2Ji9kmpAXhhh/HrIN9CdpF4Rm6I8GaljFRA184IdfpPDDVfG9dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NIdQ+BPc; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id D3E9BC0C41E;
	Fri, 24 Oct 2025 07:37:50 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 99DD260703;
	Fri, 24 Oct 2025 07:38:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A3F96102F2479;
	Fri, 24 Oct 2025 09:38:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761291490; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=bSxkL8tqpmau1y40dLrlfJlYOSTGg2m4G4hoDQyfFxM=;
	b=NIdQ+BPcDwivkk6mu/Uj8PloSozMcblTIs22nAAXkgjjy/C0nngIwm+V6vDbCYdDY8sKFN
	4ra6t1bwXgb7PxcU+5xsTUpbTmIwDplzLcJl/27S2KeZI51XqdBMjrY8/2rIFLYKKhFlFD
	Udo4LQzYyeWxt868RXtkCDTkYl0JYLu296yZVM9G6hLNLo3Ii6l7TuHzuALcdK8c/qHWg0
	aQuf6hgFTbV7OlOS+atUeNOIsREUm0DGhd3iPSkZ2lu2SXrxirT8c9lDSy6fhsHLLb+Sql
	aLvGYbVtMT8JA2zuThiWVEFxU0wEH0V0S8QxqxPYgbmhRgJC3vOYXPjuB6warg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: niravkumarlaxmidas.rabara@altera.com
Cc: richard@nod.at,  vigneshr@ti.com,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: rawnand: cadence: Add support for NV-DDR interface
 mode
In-Reply-To: <20251024071306.242227-1-niravkumarlaxmidas.rabara@altera.com>
	(niravkumarlaxmidas rabara's message of "Fri, 24 Oct 2025 15:13:06
	+0800")
References: <20251024071306.242227-1-niravkumarlaxmidas.rabara@altera.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Fri, 24 Oct 2025 09:38:02 +0200
Message-ID: <87bjlwrbqd.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hi Niravkumar,

On 24/10/2025 at 15:13:06 +08, niravkumarlaxmidas.rabara@altera.com wrote:

> From: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
>
> Add support for NV-DDR mode in the Cadence NAND controller driver.
>
> Signed-off-by: Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
> ---

Thanks for the patch, very happy to see people implementing this
interface!

[...]

> +	if (dll_phy_gate_open_delay > NVDDR_GATE_CFG_MIN)
> +		ie_start =3D NVDDR_GATE_CFG_MIN;

Can you double check here? I would expect < instead of > given that you
compare with something you named "minimum". Maybe it is legitimate, just
warning.

> +	else
> +		ie_start =3D dll_phy_gate_open_delay;
> +
> +	dll_phy_rd_delay =3D ((nvddr->tDQSCK_max + board_delay) +
> +				(clk_period / 2)) / clk_period;
> +	if (dll_phy_rd_delay <=3D NVDDR_PHY_RD_DELAY)
> +		rd_del_sel =3D dll_phy_rd_delay + 2;
> +	else
> +		rd_del_sel =3D NVDDR_PHY_RD_DELAY_MAX;
> +

[...]

> +static int
> +cadence_nand_setup_interface(struct nand_chip *chip, int chipnr,
> +			     const struct nand_interface_config *conf)
> +{
> +	int ret =3D 0;
> +
> +	if (nand_interface_is_sdr(conf)) {
> +		const struct nand_sdr_timings *sdr =3D nand_get_sdr_timings(conf);
> +
> +		if (IS_ERR(sdr))
> +			return PTR_ERR(sdr);
> +
> +		ret =3D cadence_nand_setup_sdr_interface(chip, sdr);
> +	} else if (chipnr >=3D 0) {

This isn't very clear. Please make it a separate condition if you think
you must handle this case. Otherwise you're mixing it with the SDR
vs. NVDDR choice, and that's misleading.

> +		const struct nand_nvddr_timings *nvddr =3D nand_get_nvddr_timings(conf=
);
> +
> +		if (IS_ERR(nvddr))
> +			return PTR_ERR(nvddr);
> +
> +		ret =3D cadence_nand_setup_nvddr_interface(chip, nvddr);
> +	}
> +	return ret;
> +}
> +
>  static int cadence_nand_attach_chip(struct nand_chip *chip)
>  {
>  	struct cdns_nand_ctrl *cdns_ctrl =3D to_cdns_nand_ctrl(chip->controller=
);

Otherwise looks good to me!
Miqu=C3=A8l

