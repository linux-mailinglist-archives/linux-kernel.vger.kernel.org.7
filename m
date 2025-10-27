Return-Path: <linux-kernel+bounces-871195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 973F9C0C9C3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 10:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49E643A2978
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65F62586E8;
	Mon, 27 Oct 2025 09:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GOib/KLc"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 437FC258EDB
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 09:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761556460; cv=none; b=RXsWUCZhmTzsS+MRfzfUXLuwECsMgROojjRTnJekMg5aFthE4bsR77VLK9jUAkbAHa/uADvgKoHaDoI4j8SkGOS2a+CVxkJtxSXad/FP6JiG2T7RQzUcQUBLGezn9AtRDbfshckSj+3zxyl9ZkQfQki4IYhbUuNxYdzqNvo9mrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761556460; c=relaxed/simple;
	bh=tsNHMFZY3PU7iLhgVuc7tAbmByrrRvjQKhA8uFowZpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=laa9hc3nebiDGZw1mTwGBf4H0CfLwNZay4nF9SuQ5cE3PBGklkwbzzlYoZGd34Oc27s65KkdjiUd94/hv4uNh3G/WZHcpG0VQQWxoYERVjLcgc75T8hWSWM7JAsdfc48xkRhLYO8Dl19hHuyiipPZMdcp4KsrzTnyIBY9D8R4os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GOib/KLc; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47710acf715so4277895e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 02:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761556456; x=1762161256; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zMfASScf5ZTOmAyQbAWxr3O4HT4xPAALH5kjKVs+B5Y=;
        b=GOib/KLcdbEj1bJ1u204LXrW1IN5r6MHIqfbReDiaFS9xkSBCFbECLX0GO4XBgzlQ7
         kljD4c2d1XyuXxayFL4Czh2rRhbTKJnW+SxHjsMBxLLjIJPkEqon0hDcVsnnyA1ow3wv
         cviqeE12v7m2jRO/5DQcQ1u51bk4d7wOZSja3tYMQQS7U0P+8U+VHphMnWm56EMTtKTs
         hvdMxmiUrUBQIPk3cNQVMY3K4PXW3OaIsJfvkYHjd5euMwy42aPPipP4+PCgSmAtY8vU
         k2FD46XGX/6s/VYwMWmSz/D2XSsKcwBKfzxDi+Z83salnnqn1BTa5pGTE2MlGqmjh7Z/
         GLOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761556456; x=1762161256;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zMfASScf5ZTOmAyQbAWxr3O4HT4xPAALH5kjKVs+B5Y=;
        b=mUz0rGCIHBH6Em7NLigz2aMRpB/zxR1uS6o/sDb0TOuU3YLVdQHjbvDNiY0Ttkwhks
         aJfkbdhIo8swzdGApRm5523+IeyQJXc+xhFyuZ2KVrvtRGYyQKGhzQYJGqXwYpGq8XxA
         rMW/CqaL83o8ysQURF4j+kN/VTvo90z1hPEl6kGmcwkfSwhcMzuIpbrMZ45cX3fPUPT9
         sEZHHav1wuC7rEzFhqsYOI9k7wHhT7/j3O2iNZhiHkExStl2903XvVHM99rdROVCrFXh
         OOMTuaaPhCJ5p2n0cs8WDSmAakJoNCwT45q8pwfa7uq0FseKg3CBEz4kj1fwsIlRTMzo
         +dlg==
X-Forwarded-Encrypted: i=1; AJvYcCXn/XGXrHPOiU3TnCKujaJDa4ZhYDT8HexDMiI69OTfAmhHZEK4b/thEKMGZWxEvgj+6VNIGDnF5cLDpTY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4HFnBkNRJ9Yn01R3d01qKj3DUR75l4FMcH/YePNNLIaK64r29
	k2g/foBanaUB6jb9OuiDuakUc0znTGu2eMk6wIdQoRWXa++GlQWwkAogexuTCyKzKVI=
X-Gm-Gg: ASbGncvCS6b+ByRC5Dp7Y/iduR1rMribXNrRE2sJwcBf9w7cJVKuOIowTCbBYkmPwg5
	zKxHL3NO0hGCUTxFHZvm2abeGosYmJVT9RVurfjp8i9StF+SnLN4l3D40iHZ4vbCLwbtBmXdqLP
	0WPTKxy8sLemkNDRwxF75jzJlZjYDvDuMYsP51q27qE6jJ1g8tCuR8DTzljV957C5QWcwdaqojM
	W5APHFRMoRgfKP0K7VJwCee+5FZI6Xlb1Rgxcug3AXtFkl0jnD0yWBCmu1Os1a4w76y1l4fPpzN
	jT8m6OIYcHrmbvQmv6lfSUJSmZNeHkD9UDrN5t6g4oi48RnTRVWRcX0pGSL0Oo3rzmpVOCeaPCv
	RFFcMh+3mo/WvWUXJF6aV2jNV9XJoULfC4qdsHEXZShHgccOGE7OFmSrio7sPTAdf8/y5txXSwE
	KVck91zGo=
X-Google-Smtp-Source: AGHT+IF01498un0tSWAnn1Di9SQ50IOxjN2AyB2jrpc+3JXFxPl0fMSWvNz6Z5oCVFiz8j55+fzQuw==
X-Received: by 2002:a05:600d:438f:b0:476:84e9:b55d with SMTP id 5b1f17b1804b1-47684e9bedbmr28893255e9.3.1761556456359;
        Mon, 27 Oct 2025 02:14:16 -0700 (PDT)
Received: from linaro.org ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475ddae2309sm60319575e9.12.2025.10.27.02.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 02:14:15 -0700 (PDT)
Date: Mon, 27 Oct 2025 11:14:14 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Wesley Cheng <quic_wcheng@quicinc.com>, linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 6/8] phy: qualcomm: qmp-combo: Update QMP PHY with
 Glymur settings
Message-ID: <j4it7mdacjnx3gocmak5nxx7bqmtxmikum7kn7qr5dh7jac7ok@oiqkbnil6lfd>
References: <20251024-glymur_usb-v6-0-471fa39ff857@oss.qualcomm.com>
 <20251024-glymur_usb-v6-6-471fa39ff857@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024-glymur_usb-v6-6-471fa39ff857@oss.qualcomm.com>

On 25-10-24 17:47:44, Wesley Cheng wrote:
> For SuperSpeed USB to work properly, there is a set of HW settings that
> need to be programmed into the USB blocks within the QMP PHY.  Ensure that
> these settings follow the latest settings mentioned in the HW programming
> guide.  The QMP USB PHY on Glymur is a USB43 based PHY that will have some
> new ways to define certain registers, such as the replacement of TXA/RXA
> and TXB/RXB register sets.  This was replaced with the LALB register set.
> 
> There are also some PHY init updates to modify the PCS MISC register space.
> Without these, the QMP PHY PLL locking fails.
> 
> Signed-off-by: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-combo.c          | 288 ++++++++++
>  drivers/phy/qualcomm/phy-qcom-qmp-pcs-aon-v8.h     |  17 +
>  drivers/phy/qualcomm/phy-qcom-qmp-pcs-misc-v8.h    |  12 +
>  .../phy/qualcomm/phy-qcom-qmp-qserdes-lalb-v8.h    | 639 +++++++++++++++++++++
>  drivers/phy/qualcomm/phy-qcom-qmp-usb43-pcs-v8.h   |  33 ++
>  .../qualcomm/phy-qcom-qmp-usb43-qserdes-com-v8.h   | 224 ++++++++
>  drivers/phy/qualcomm/phy-qcom-qmp.h                |   2 +
>  7 files changed, 1215 insertions(+)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> index 1caa1fb6a8c7..d1534ed7200b 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c

[...]

>  
> +static const unsigned int qmp_v8_n3_usb43dpphy_regs_layout[QPHY_LAYOUT_SIZE] = {
> +	[QPHY_SW_RESET]			= QPHY_V6_N4_PCS_SW_RESET,
> +	[QPHY_START_CTRL]			= QPHY_V6_N4_PCS_START_CONTROL,
> +	[QPHY_PCS_STATUS]			= QPHY_V6_N4_PCS_PCS_STATUS1,
> +	[QPHY_PCS_POWER_DOWN_CONTROL]	= QPHY_V6_N4_PCS_POWER_DOWN_CONTROL,

The patches I have for DP fixes these by adding the V8_N3E and using those instead.

The reason this hasn't created any issues is because, at least for these 4, the offsets
are the same.

You can use my patch so you don't have to add those reg offsets yourself, if you want.

> +
> +	/* In PCS_USB */
> +	[QPHY_PCS_AUTONOMOUS_MODE_CTRL]	= QPHY_V6_PCS_USB3_AUTONOMOUS_MODE_CTRL,
> +	[QPHY_PCS_LFPS_RXTERM_IRQ_CLEAR]	= QPHY_V6_PCS_USB3_LFPS_RXTERM_IRQ_CLEAR,
> +
> +	[QPHY_AON_TOGGLE_ENABLE]		= QPHY_V8_PCS_AON_USB3_AON_TOGGLE_ENABLE,
> +
> +	[QPHY_COM_RESETSM_CNTRL]		= QSERDES_V6_COM_RESETSM_CNTRL,
> +	[QPHY_COM_C_READY_STATUS]		= QSERDES_V6_COM_C_READY_STATUS,
> +	[QPHY_COM_CMN_STATUS]		= QSERDES_V6_COM_CMN_STATUS,
> +	[QPHY_COM_BIAS_EN_CLKBUFLR_EN]	= QSERDES_V6_COM_PLL_BIAS_EN_CLK_BUFLR_EN,
> +
> +	[QPHY_DP_PHY_STATUS]		= QSERDES_V6_DP_PHY_STATUS,
> +	[QPHY_DP_PHY_VCO_DIV]		= QSERDES_V6_DP_PHY_VCO_DIV,
> +
> +	[QPHY_TX_TX_POL_INV]		= QSERDES_V6_N4_TX_TX_POL_INV,
> +	[QPHY_TX_TX_DRV_LVL]		= QSERDES_V6_N4_TX_TX_DRV_LVL,
> +	[QPHY_TX_TX_EMP_POST1_LVL]		= QSERDES_V6_N4_TX_TX_EMP_POST1_LVL,
> +	[QPHY_TX_HIGHZ_DRVR_EN]		= QSERDES_V6_N4_TX_HIGHZ_DRVR_EN,
> +	[QPHY_TX_TRANSCEIVER_BIAS_EN]	= QSERDES_V6_N4_TX_TRANSCEIVER_BIAS_EN,
> +};

I'm pretty sure this is wrong. You are using the V8_LALB offsets below, which
is correct, but here you are using V6_N4. At first glance, these are quite
different.

