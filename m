Return-Path: <linux-kernel+bounces-834914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A71CBA5D34
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 11:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BD6E163779
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 09:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C662D6E54;
	Sat, 27 Sep 2025 09:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="l35Yh+D4"
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5353D19D8A8
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 09:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758966993; cv=none; b=ZLIysmWj8fjXYyDitFX7iZ2V5qf8pXinV29p86jnHDSE/qEOVEl14Pl7pBYYm1zrD5XLJsB56oD8DzIMEOenlr4utJlQVEjlvgpDH9DEiEAFoUugK4DV1ja9Xmjs2YWmgP0F/hcjXUV7j5KcwhlD29X0hOxF4sw5mI6wMlI1ANc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758966993; c=relaxed/simple;
	bh=b35t56y4UDt8FwfT9zL1LJiLMU447oDw7O6y/WQjZ2Y=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=YeRIFho8ru+IOOu6NnfAbxu5ts9PJtnU29mqI53HcueVQF7hycsqNeTDT9/+Vqz7jplkAUZFQQAiLYyQyDwQTR7dJqudqWswn6QL5md7T7kDpO0BojjlNVPM4WxVqNk22jzRBS0DBabZ1ZtYqi10LbGm+J0PiF3WCKNEC3rolRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=l35Yh+D4; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1758966978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y3x1Sed9F8EalDsModwxtm1c+k2dv0YDnCmwsZS/B5g=;
	b=l35Yh+D4Q2oNYPZGHMcBntinmXfzF0w9i3ouEm37VXZ6knq0Ae65AveIxo7DWlUXX/i+rI
	v6MxMPbMJ69e4NgfYM1fErKz9U+zPUoHg9qcQQGzTGnGhNuhn8VNyiR/v8eoJYFvOlxK4Y
	KjRvxgJZyCyx7E0M9e9Leluq2Jxzt5PDE9IF3IVZJiJxiEoUIfMlU4xQx+T4a5vAyldUuW
	xpgjM3TksXpYjr5OtjfXp/88vr82N5V4yaXWtn2OL8UyF6wW7MXKEBgJ1VWpwCLl4kYShC
	7PvMeOhNe/2T65bMjiZ4DNMOdt6L97L4945a/yit58jOIvnWucwvWBwc8Dqk1g==
Content-Type: multipart/signed;
 boundary=009f252ba09693b5e8abec8ec687c59ee2a383ff22d9e36d8a97ad51c14e;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Sat, 27 Sep 2025 11:56:07 +0200
Message-Id: <DD3HR1AGS7HT.2D858FUG2L2YB@cknow.org>
Cc: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-msm@vger.kernel.org>, <freedreno@lists.freedesktop.org>,
 <linux-arm-kernel@lists.infradead.org>,
 <linux-rockchip@lists.infradead.org>, <linux-sunxi@lists.linux.dev>
Subject: Re: [PATCH 8/9] drm/rockchip: inno-hdmi: handle unsupported
 InfoFrames
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Liu Ying"
 <victor.liu@nxp.com>, "Andrzej Hajda" <andrzej.hajda@intel.com>, "Neil
 Armstrong" <neil.armstrong@linaro.org>, "Robert Foss" <rfoss@kernel.org>,
 "Laurent Pinchart" <Laurent.pinchart@ideasonboard.com>, "Jonas Karlman"
 <jonas@kwiboo.se>, "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Rob Clark"
 <robin.clark@oss.qualcomm.com>, "Dmitry Baryshkov" <lumag@kernel.org>,
 "Abhinav Kumar" <abhinav.kumar@linux.dev>, "Jessica Zhang"
 <jessica.zhang@oss.qualcomm.com>, "Sean Paul" <sean@poorly.run>, "Marijn
 Suijten" <marijn.suijten@somainline.org>, "Sandy Huang"
 <hjc@rock-chips.com>, =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 "Andy Yan" <andy.yan@rock-chips.com>, "Chen-Yu Tsai" <wens@csie.org>,
 "Samuel Holland" <samuel@sholland.org>
References: <20250927-limit-infoframes-2-v1-0-697511bd050b@oss.qualcomm.com>
 <20250927-limit-infoframes-2-v1-8-697511bd050b@oss.qualcomm.com>
In-Reply-To: <20250927-limit-infoframes-2-v1-8-697511bd050b@oss.qualcomm.com>
X-Migadu-Flow: FLOW_OUT

--009f252ba09693b5e8abec8ec687c59ee2a383ff22d9e36d8a97ad51c14e
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Sat Sep 27, 2025 at 3:04 AM CEST, Dmitry Baryshkov wrote:
> Make write_hdmi_infoframe() and clear_infoframe() callbacks
> return -EOPNOTSUPP for unsupported InfoFrames and make sure that
> atomic_check() callback doesn't allow unsupported InfoFrames to be
> enabled.
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/rockchip/inno_hdmi.c | 46 +++++++++++++++++++++++++++---=
------
>  1 file changed, 35 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockc=
hip/inno_hdmi.c
> index f24827dc1421cf5e0c1be63a80da23d645cf3f24..dc2d68b9c87f7ae7b06ecbeae=
bc82b9689c1abfd 100644
> --- a/drivers/gpu/drm/rockchip/inno_hdmi.c
> +++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
> @@ -641,11 +641,8 @@ static int inno_hdmi_disable_frame(struct drm_connec=
tor *connector,
>  {
>  	struct inno_hdmi *hdmi =3D connector_to_inno_hdmi(connector);
> =20
> -	if (type !=3D HDMI_INFOFRAME_TYPE_AVI) {
> -		drm_err(connector->dev,
> -			"Unsupported infoframe type: %u\n", type);
> -		return 0;
> -	}
> +	if (type !=3D HDMI_INFOFRAME_TYPE_AVI)
> +		return -EOPNOTSUPP;
> =20
>  	hdmi_writeb(hdmi, HDMI_CONTROL_PACKET_BUF_INDEX, INFOFRAME_AVI);
> =20
> @@ -659,11 +656,8 @@ static int inno_hdmi_upload_frame(struct drm_connect=
or *connector,
>  	struct inno_hdmi *hdmi =3D connector_to_inno_hdmi(connector);
>  	ssize_t i;
> =20
> -	if (type !=3D HDMI_INFOFRAME_TYPE_AVI) {
> -		drm_err(connector->dev,
> -			"Unsupported infoframe type: %u\n", type);
> -		return 0;
> -	}
> +	if (type !=3D HDMI_INFOFRAME_TYPE_AVI)
> +		return -EOPNOTSUPP;
> =20
>  	inno_hdmi_disable_frame(connector, type);
> =20
> @@ -673,6 +667,36 @@ static int inno_hdmi_upload_frame(struct drm_connect=
or *connector,
>  	return 0;
>  }
> =20
> +static int inno_hdmi_connector_atomic_check(struct drm_connector *connec=
tor,
> +					    struct drm_atomic_state *state)
> +{
> +	struct drm_connector_state *conn_state =3D
> +		drm_atomic_get_new_connector_state(state, connector);
> +	int ret;
> +
> +	ret =3D drm_atomic_helper_connector_hdmi_check(connector, state);
> +	if (ret)
> +		return ret;
> +
> +	/* not supported by the driver */
> +	conn_state->hdmi.infoframes.spd.set =3D false;
> +
> +	/* FIXME: not supported by the driver */
> +	conn_state->hdmi.infoframes.hdmi.set =3D false;
> +
> +	/* should not happen, HDR support not enabled */
> +	if (drm_WARN_ON_ONCE(connector->dev,
> +			     connector->hdmi.infoframes.audio.set))
> +		return -EOPNOTSUPP;
> +
> +	/* should not happen, audio support not enabled */
> +	if (drm_WARN_ON_ONCE(connector->dev,
> +			     conn_state->hdmi.infoframes.hdr_drm.set))
> +		return -EOPNOTSUPP;

Looks like the comments are on the wrong line? Also in patch 7.

Cheers,
  Diederik

> +
> +	return 0;
> +}
> +
>  static const struct drm_connector_hdmi_funcs inno_hdmi_hdmi_connector_fu=
ncs =3D {
>  	.clear_infoframe	=3D inno_hdmi_disable_frame,
>  	.write_infoframe	=3D inno_hdmi_upload_frame,
> @@ -1029,7 +1053,7 @@ static const struct drm_connector_funcs inno_hdmi_c=
onnector_funcs =3D {
>  };
> =20
>  static struct drm_connector_helper_funcs inno_hdmi_connector_helper_func=
s =3D {
> -	.atomic_check =3D drm_atomic_helper_connector_hdmi_check,
> +	.atomic_check =3D inno_hdmi_connector_atomic_check,
>  	.get_modes =3D inno_hdmi_connector_get_modes,
>  	.mode_valid =3D inno_hdmi_connector_mode_valid,
>  };


--009f252ba09693b5e8abec8ec687c59ee2a383ff22d9e36d8a97ad51c14e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCaNe0uwAKCRDXblvOeH7b
bn7bAPwJebDnI2AKKmrsKb1ukF91oehuobCOe5iej/is8fNtcwD/U9U72TebO6mY
b18goM6s7bCYCHVCztoR8gN8bUTvIgo=
=dph3
-----END PGP SIGNATURE-----

--009f252ba09693b5e8abec8ec687c59ee2a383ff22d9e36d8a97ad51c14e--

