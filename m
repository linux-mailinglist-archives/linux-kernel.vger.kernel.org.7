Return-Path: <linux-kernel+bounces-854813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71200BDF750
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 17:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9466188E2CC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 15:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4CD326D77;
	Wed, 15 Oct 2025 15:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="VT7Jvr/J"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13302D0627
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 15:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760543082; cv=none; b=r/z/gfwwBii76C3TueOoC68ou8XOlwjLXJiK05Aha04+zAf4m6BaRqAE6VyE16n7ve3bd411gxKs1DIJe/Mljg1T1mOA/aR/7Oe7vuoetlHJHbooAGeTEhKnyrwCWuRp6OFfhtGdjGBQEGgDSYHuMczkeH1mkZkf0aMVrI02iTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760543082; c=relaxed/simple;
	bh=wt2p1xOwcMbfWc4oLyElzL+d7q2D5aki5+5k+z6LTnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OMhhzoRwoff7NYgiD9KCdQW0PpEjh8z6vvyLYX2W8zdCXNHYYKw3KiSSCJW8Ikd2USuuWxJ1OkDDyysu7pRsMwfMI/GdZYKtjmsQ0pdXghTfisPZY2bMMPHnVFAf8bCLNJGOy96nEtuzK2zhprUyA3aUALAB9i6FZLou0wAUm3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=VT7Jvr/J; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=Z3Pe//Qk7uVwriRUdY4wfxnM3En9QGZArVfkpKWTETw=; b=VT7Jvr/JW5SCZv7ZUvwOgcbo/g
	2x2kVvVveSt62dZgaSzTtz/ZFXzdFZ+IsI0zH/pXxedf0xetmuqojHfkO8pNYhQlFsAEorXt0WzHv
	OIelmGR8D9Ez1vEk+XTrL444HjScJR1LEjc2DrsVf+T+FfPKX4zx93he2kOpYKQRx8F2vZSjq0FRW
	iEmh+xDa2o0twA3Wm6o8fMubNruHKE3XQ3Abf767QyBwY9aYjXAGASi4Jy0tJgSid5t0HP2HYtdCb
	9tHuH5aH4kwG6+WjbDuk+kVdcN1/is0dZwZk9Zo9uIaAeSVFm5JMwYX9I7IuDMl8h2MNlPpSKmYWJ
	pQSvBPpw==;
Received: from i53875a40.versanet.de ([83.135.90.64] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1v93fX-0000Ye-0q; Wed, 15 Oct 2025 17:44:03 +0200
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Sandy Huang <hjc@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/6] drm/bridge: dw-hdmi-qp: Fixup timer base setup
Date: Wed, 15 Oct 2025 17:44:01 +0200
Message-ID: <2753758.X9hSmTKtgW@diego>
In-Reply-To: <20250903-rk3588-hdmi-cec-v4-2-fa25163c4b08@collabora.com>
References:
 <20250903-rk3588-hdmi-cec-v4-0-fa25163c4b08@collabora.com>
 <20250903-rk3588-hdmi-cec-v4-2-fa25163c4b08@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Mittwoch, 3. September 2025, 20:51:00 Mitteleurop=C3=A4ische Sommerzeit =
schrieb Cristian Ciocaltea:
> Currently the TIMER_BASE_CONFIG0 register gets initialized to a fixed
> value as initially found in vendor driver code supporting the RK3588
> SoC.  As a matter of fact the value matches the rate of the HDMI TX
> reference clock, which is roughly 428.57 MHz.
>=20
> However, on RK3576 SoC that rate is slightly lower, i.e. 396.00 MHz, and
> the incorrect register configuration breaks CEC functionality.
>=20
> Set the timer base according to the actual reference clock rate that
> shall be provided by the platform driver.  Otherwise fallback to the
> vendor default.
>=20
> While at it, also drop the unnecessary empty lines in
> dw_hdmi_qp_init_hw().
>=20
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

This _does_ look ok to me, but as that touches the main bridge, could
we get a 2nd set of eyes?

Thanks
Heiko

> ---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c | 12 +++++++++---
>  include/drm/bridge/dw_hdmi_qp.h              |  1 +
>  2 files changed, 10 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c b/drivers/gpu/d=
rm/bridge/synopsys/dw-hdmi-qp.c
> index fc98953672b6fb388d05201e280d24b8f214498a..4ba7b339eff62592aa748429a=
3bfca82494679d1 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
> @@ -161,6 +161,7 @@ struct dw_hdmi_qp {
>  		void *data;
>  	} phy;
> =20
> +	unsigned long ref_clk_rate;
>  	struct regmap *regm;
> =20
>  	unsigned long tmds_char_rate;
> @@ -1210,13 +1211,11 @@ static void dw_hdmi_qp_init_hw(struct dw_hdmi_qp =
*hdmi)
>  {
>  	dw_hdmi_qp_write(hdmi, 0, MAINUNIT_0_INT_MASK_N);
>  	dw_hdmi_qp_write(hdmi, 0, MAINUNIT_1_INT_MASK_N);
> -	dw_hdmi_qp_write(hdmi, 428571429, TIMER_BASE_CONFIG0);
> +	dw_hdmi_qp_write(hdmi, hdmi->ref_clk_rate, TIMER_BASE_CONFIG0);
> =20
>  	/* Software reset */
>  	dw_hdmi_qp_write(hdmi, 0x01, I2CM_CONTROL0);
> -
>  	dw_hdmi_qp_write(hdmi, 0x085c085c, I2CM_FM_SCL_CONFIG0);
> -
>  	dw_hdmi_qp_mod(hdmi, 0, I2CM_FM_EN, I2CM_INTERFACE_CONTROL0);
> =20
>  	/* Clear DONE and ERROR interrupts */
> @@ -1262,6 +1261,13 @@ struct dw_hdmi_qp *dw_hdmi_qp_bind(struct platform=
_device *pdev,
>  	hdmi->phy.ops =3D plat_data->phy_ops;
>  	hdmi->phy.data =3D plat_data->phy_data;
> =20
> +	if (plat_data->ref_clk_rate) {
> +		hdmi->ref_clk_rate =3D plat_data->ref_clk_rate;
> +	} else {
> +		hdmi->ref_clk_rate =3D 428571429;
> +		dev_warn(dev, "Set ref_clk_rate to vendor default\n");
> +	}
> +
>  	dw_hdmi_qp_init_hw(hdmi);
> =20
>  	ret =3D devm_request_threaded_irq(dev, plat_data->main_irq,
> diff --git a/include/drm/bridge/dw_hdmi_qp.h b/include/drm/bridge/dw_hdmi=
_qp.h
> index b4a9b739734ec7b67013b683fe6017551aa19172..76ecf31301997718604a05f70=
ce9eab8695e26b5 100644
> --- a/include/drm/bridge/dw_hdmi_qp.h
> +++ b/include/drm/bridge/dw_hdmi_qp.h
> @@ -24,6 +24,7 @@ struct dw_hdmi_qp_plat_data {
>  	void *phy_data;
>  	int main_irq;
>  	int cec_irq;
> +	unsigned long ref_clk_rate;
>  };
> =20
>  struct dw_hdmi_qp *dw_hdmi_qp_bind(struct platform_device *pdev,
>=20
>=20





