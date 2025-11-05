Return-Path: <linux-kernel+bounces-887051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5822C37275
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 18:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42E87665A07
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 17:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1229833B6D6;
	Wed,  5 Nov 2025 17:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="IVu3H3vk"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C827D238D5A;
	Wed,  5 Nov 2025 17:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762363690; cv=none; b=u2fovLkmc5oxe6T3M2L/GfTAsNM+kG1zV8DunqH00CS+PkCL4KrpiSfMgVWNMbZ1KR0rGHRAzaG+Ui++Pb2Xm8wzRI3bAmU8axh2562Xvq2716N3p9snpuV8DWVPdcAVzPDtor+DJytWuUxJUIQS9j5DXqtfFvnuBkTZTZJoJ4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762363690; c=relaxed/simple;
	bh=A9meDTqC5tJJ9U1Z7d2WJ+ZnrwYNX1upajzsMqtt0GA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tESJeHkDohGpgfdkibCa5nuYMad7uWNm6HmsUJed1cvOdJc1af5trJZ2HaEeJabqZoHfx+uUCsCrZTG6bRnVb5ZdM9VyZBTCXFiqpYg6qS1t4DtGnd+yjOZH4UKkiJcGOZaJmscRK960poJW0RR6FjqfVMIxewS2u2YvemIp3G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=IVu3H3vk; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (82-203-161-95.bb.dnainternet.fi [82.203.161.95])
	by perceval.ideasonboard.com (Postfix) with UTF8SMTPSA id 91ED17E0;
	Wed,  5 Nov 2025 18:26:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1762363573;
	bh=A9meDTqC5tJJ9U1Z7d2WJ+ZnrwYNX1upajzsMqtt0GA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IVu3H3vkW9ImWiDmVZWXQk25mP1UZAc5e0AIFNxJj8bJ+jylfadg6y1p31lKqCBdJ
	 DkKyukRbSJQyviLKV0480hplT/mE0jZ1CX7PSmqg13Op9pJtuOSy27QUe6d0nNeLd4
	 /G2ArQYKft0dqux/Xct+HTMnxAkqwbdvmcWrEXa0=
Date: Wed, 5 Nov 2025 19:28:03 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Guoniu Zhou <guoniu.zhou@oss.nxp.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>,
	linux-media@vger.kernel.org, devicetree@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Guoniu Zhou <guoniu.zhou@nxp.com>
Subject: Re: [PATCH v3 3/3] media: nxp: imx8-isi: Add ISI support for i.MX95
Message-ID: <20251105172803.GD6046@pendragon.ideasonboard.com>
References: <20251105-isi_imx95-v3-0-3987533cca1c@nxp.com>
 <20251105-isi_imx95-v3-3-3987533cca1c@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251105-isi_imx95-v3-3-3987533cca1c@nxp.com>

On Wed, Nov 05, 2025 at 01:55:12PM +0800, Guoniu Zhou wrote:
> From: Guoniu Zhou <guoniu.zhou@nxp.com>
> 
> The ISI module on i.MX95 supports up to eight channels and four link
> sources to obtain the image data for processing in its pipelines. It
> can process up to eight image sources at the same time.
> 
> Add ISI basic functions support for i.MX95.
> 
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Guoniu Zhou <guoniu.zhou@nxp.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

I will take this series in my tree and include it in my next pull
request.

> ---
>  drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c | 12 ++++++++++++
>  drivers/media/platform/nxp/imx8-isi/imx8-isi-core.h |  1 +
>  2 files changed, 13 insertions(+)
> 
> diff --git a/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c b/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c
> index adc8d9960bf0df87d4e475661a3439beaf5ce9f6..cf609320f19e91c9c0f57634fabd62e0ff65123b 100644
> --- a/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c
> +++ b/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c
> @@ -337,6 +337,17 @@ static const struct mxc_isi_plat_data mxc_imx93_data = {
>  	.has_36bit_dma		= false,
>  };
>  
> +static const struct mxc_isi_plat_data mxc_imx95_data = {
> +	.model			= MXC_ISI_IMX95,
> +	.num_ports		= 4,
> +	.num_channels		= 8,
> +	.reg_offset		= 0x10000,
> +	.ier_reg		= &mxc_imx8_isi_ier_v2,
> +	.set_thd		= &mxc_imx8_isi_thd_v1,
> +	.buf_active_reverse	= true,
> +	.has_36bit_dma		= true,
> +};
> +
>  static const struct mxc_isi_plat_data mxc_imx8qm_data = {
>  	.model			= MXC_ISI_IMX8QM,
>  	.num_ports		= 5,
> @@ -548,6 +559,7 @@ static const struct of_device_id mxc_isi_of_match[] = {
>  	{ .compatible = "fsl,imx8qxp-isi", .data = &mxc_imx8qxp_data },
>  	{ .compatible = "fsl,imx8ulp-isi", .data = &mxc_imx8ulp_data },
>  	{ .compatible = "fsl,imx93-isi", .data = &mxc_imx93_data },
> +	{ .compatible = "fsl,imx95-isi", .data = &mxc_imx95_data },
>  	{ /* sentinel */ },
>  };
>  MODULE_DEVICE_TABLE(of, mxc_isi_of_match);
> diff --git a/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.h b/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.h
> index e84af5127e4e7938e55e31b7063bee5e2cd4cb11..e52c7fc334b0f5624ade600914c275e7539290b4 100644
> --- a/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.h
> +++ b/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.h
> @@ -161,6 +161,7 @@ enum model {
>  	MXC_ISI_IMX8QXP,
>  	MXC_ISI_IMX8ULP,
>  	MXC_ISI_IMX93,
> +	MXC_ISI_IMX95,
>  };
>  
>  struct mxc_isi_plat_data {

-- 
Regards,

Laurent Pinchart

