Return-Path: <linux-kernel+bounces-755992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C58C7B1AE71
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 08:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEED216DF8D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 06:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5E121C19E;
	Tue,  5 Aug 2025 06:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vOetwG6w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2441B1EFF96;
	Tue,  5 Aug 2025 06:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754375761; cv=none; b=O0FDRK5iLmgxabfgz67XDgEKv/q1vmWQw3Ihe6BEs9O1F622o4AOYK/ea2no/+mFeKULjFXodpGQETPjYuznXX6h0mmdUK38WlmKZ+7BPpIrfI7IZDVpGbaA7m7Y/YvUv9u5CmO8Juzs3ral7x1XFQQ/6ntiFAnqpZcHykUC0mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754375761; c=relaxed/simple;
	bh=sIHPITH9zG/L0PbzCUmZDWaszbXx38hkA/bHt1tkCsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fKo2Q3SkqQQVFmEd7JuPAzOq0iv0O/bNfnxNLuSiaE1Jl3XuvOSUPjgnBvTMVU4C7oOwCJXdTFQRcWXJHyRaOGE9UixasiUq7OsYNYi4TQCGCGgJtsWyZq7w99Paq6WkvfBFgQXkMeMLAWlN9wY0PA+hzMWdOmet1PE3YQ7dTXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vOetwG6w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEB18C4CEF4;
	Tue,  5 Aug 2025 06:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754375760;
	bh=sIHPITH9zG/L0PbzCUmZDWaszbXx38hkA/bHt1tkCsY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vOetwG6wjPaFORrkROIrDOatq5ormVU2vdtjv/cTfRt7ABu2cGpYaG7vuXplt88PO
	 eKnp/n+o346f6/YG8oB0r+bYIfWKNkbsnmX+moad9d9FBnPPpmHy/EUXFx4NgLHNtx
	 ucu3PxmCL14qKSC1XJlI9SENNJMRxUivtYlWFKW+ongQ7WgRYC9uAtSV41x2PE8zHP
	 m/Lz5HNXUpJPaTn7ZgTHnrUFAF8qwvfwH4HGRn7Vrm+Z+7NUxXbpxVBjhaL/zzqzdc
	 IQfC4RvRWmK8w2Hq2+tZKGZ9PNcDLQCQ/t08gO4s/GcwGBq4BWIthFB+6lAEzlJ+jY
	 BGGAuyxnJFixg==
Date: Tue, 5 Aug 2025 08:35:58 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org, 
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, jernej.skrabec@gmail.com, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, 
	simona@ffwll.ch, lumag@kernel.org, dianders@chromium.org, 
	cristian.ciocaltea@collabora.com, luca.ceresoli@bootlin.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, victor.liu@nxp.com, shawnguo@kernel.org, s.hauer@pengutronix.de, 
	kernel@pengutronix.de, festevam@gmail.com, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	p.zabel@pengutronix.de, devicetree@vger.kernel.org, l.stach@pengutronix.de, 
	shengjiu.wang@gmail.com, perex@perex.cz, tiwai@suse.com, linux-sound@vger.kernel.org
Subject: Re: [PATCH v3 1/6] dt-bindings: display: imx: add HDMI PAI for
 i.MX8MP
Message-ID: <20250805-realistic-hawk-of-merriment-f84ef2@kuoka>
References: <20250804104722.601440-1-shengjiu.wang@nxp.com>
 <20250804104722.601440-2-shengjiu.wang@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250804104722.601440-2-shengjiu.wang@nxp.com>

On Mon, Aug 04, 2025 at 06:47:17PM +0800, Shengjiu Wang wrote:
> Add binding for the i.MX8MP HDMI parallel Audio interface block.
> 
> The HDMI TX Parallel Audio Interface (HTX_PAI) is a digital module that
> acts as the bridge between the Audio Subsystem to the HDMI TX Controller.
> This IP block is found in the HDMI subsystem of the i.MX8MP SoC.
> 
> Aud2htx module in Audio Subsystem, HDMI PAI module and HDMI TX
> Controller compose the HDMI audio pipeline.
> 
> In fsl,imx8mp-hdmi-tx.yaml, add port@2 that is linked to pai_to_hdmi_tx.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  .../display/bridge/fsl,imx8mp-hdmi-tx.yaml    | 12 ++++
>  .../display/imx/fsl,imx8mp-hdmi-pai.yaml      | 69 +++++++++++++++++++
>  2 files changed, 81 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx8mp-hdmi-pai.yaml

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


