Return-Path: <linux-kernel+bounces-825738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B27B8CB33
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 17:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D03343AACD5
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 15:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B98A2FC008;
	Sat, 20 Sep 2025 15:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="xYmhn1gQ"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB4234BA39
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 15:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758380839; cv=none; b=oAmMU8WhhysB+RPLTFC1AW3cuz3lW9bpU2e1hbs7nGfk2qy5VtMeaoeAAkt04L33WxATmHk0HBT6lCoLmzKkoz1ZH5cs/V790QzluZM1hONBb4GO1PsFgfKSp3nrzhMU7lzNG4YHYJUbMuc4QaSlZDhU/sna0P0g3cbqOe4JlpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758380839; c=relaxed/simple;
	bh=91APnykdZchFIudtyLUh1J2uLm4j7j1h+1orgJ9EdAQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=N7YVePIZctFqF6gMY7NrgAVkDhN01/9Ba+Kfr8VUUgK8g7wf4dL2TtlJbkeGTScZUrxjE6LnLT3ujtBKjmWegyrwReWvd5wYSHlxajxYH5PjTQttH08DluDmzA2+u5msbO1L7C2on7HXeC9DWPvzjrg1GCK7TUW6wiBxctcu0UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=xYmhn1gQ; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1758380825;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tazBSl0jd+mP1TMg25eHU6IE9QcZYplcuue2Sdbi124=;
	b=xYmhn1gQuHXk2Y5ndkayQBk1aidB8jkravF60B2/1gfQnEqXoGXO8ZB+5QkvJN9nOiRV6T
	BiGhlH1C2LgbGTDZn+yEwLU19Gn0QmqU20V+QIohfbCJ5wtbYYv1I7Ixtk2eahjqjyoLAQ
	/B2du8rflGPqZeGVaaf4Btgt3ynt8LCZ07nYuOuBhe4ZLPjtAJnIwbxDNHW6kRfUM3n9/k
	4LFrcYh4R+hBgeC6GBqGeQ0IieQOL/1q+51WkWrucCoptGRtxBoy3dbJgCJOVYHjgUZ7ne
	Nc/i/GMR24cEQJVb4ycZHp9nhlaA2Acsz8aH5VAJs+pgq3O9Km39EepojlGNsw==
Content-Type: multipart/signed;
 boundary=d83a747f469b673037b2ddac5c4b1b006e570ceeb9bf13c9d6e293c89318;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Sat, 20 Sep 2025 17:07:01 +0200
Message-Id: <DCXPZ9JSN7H2.3B76IQI8N4O6H@cknow.org>
Cc: "Mauro Carvalho Chehab" <mchehab@kernel.org>, "Heiko Stuebner"
 <heiko@sntech.de>, <linux-media@vger.kernel.org>,
 <linux-rockchip@lists.infradead.org>,
 <linux-arm-kernel@lists.infradead.org>, <kernel@collabora.com>
Subject: Re: [PATCH v2 11/12] media: rkvdec: Add HEVC support for the
 VDPU381 variant
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
To: "Detlev Casanova" <detlev.casanova@collabora.com>,
 <linux-kernel@vger.kernel.org>
References: <20250808200340.156393-1-detlev.casanova@collabora.com>
 <20250808200340.156393-12-detlev.casanova@collabora.com>
In-Reply-To: <20250808200340.156393-12-detlev.casanova@collabora.com>
X-Migadu-Flow: FLOW_OUT

--d83a747f469b673037b2ddac5c4b1b006e570ceeb9bf13c9d6e293c89318
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi again,

I think I've found a similar issue here as I did for H264.

On Fri Aug 8, 2025 at 10:03 PM CEST, Detlev Casanova wrote:
> The VDPU381 supports HEVC decoding up to 7680x4320@30fps.
> It could double that when using both decoder cores.
>
> It support YUV420 (8 and 10 bits) as well as AFBC (not implemented
> here)
>
> The fluster score is 146/147 for JCT-VC-HEVC_V1, tested on ROCK 5B.
> None of the other test suites works.
>
> Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> ---
>  .../media/platform/rockchip/rkvdec/Kconfig    |    1 +
>  .../media/platform/rockchip/rkvdec/Makefile   |    2 +
>  .../platform/rockchip/rkvdec/rkvdec-cabac.c   | 3435 +++++++++++++++++
>  .../rockchip/rkvdec/rkvdec-hevc-common.c      |  546 +++
>  .../rockchip/rkvdec/rkvdec-hevc-common.h      |  101 +
>  .../rockchip/rkvdec/rkvdec-vdpu381-hevc.c     |  596 +++
>  .../media/platform/rockchip/rkvdec/rkvdec.c   |   81 +
>  .../media/platform/rockchip/rkvdec/rkvdec.h   |    1 +
>  8 files changed, 4763 insertions(+)
>  create mode 100644 drivers/media/platform/rockchip/rkvdec/rkvdec-hevc-co=
mmon.c
>  create mode 100644 drivers/media/platform/rockchip/rkvdec/rkvdec-hevc-co=
mmon.h
>  create mode 100644 drivers/media/platform/rockchip/rkvdec/rkvdec-vdpu381=
-hevc.c
>
> diff --git a/drivers/media/platform/rockchip/rkvdec/Kconfig b/drivers/med=
ia/platform/rockchip/rkvdec/Kconfig
> index 5f3bdd848a2cf..3303b0ce32809 100644
> --- a/drivers/media/platform/rockchip/rkvdec/Kconfig
> +++ b/drivers/media/platform/rockchip/rkvdec/Kconfig
> @@ -8,6 +8,7 @@ config VIDEO_ROCKCHIP_VDEC
>  	select VIDEOBUF2_VMALLOC
>  	select V4L2_MEM2MEM_DEV
>  	select V4L2_H264
> +	select V4L2_HEVC
>  	select V4L2_VP9
>  	help
>  	  Support for the Rockchip Video Decoder IP present on Rockchip SoCs,
>
> ...
>
> diff --git a/drivers/media/platform/rockchip/rkvdec/rkvdec.c b/drivers/me=
dia/platform/rockchip/rkvdec/rkvdec.c
> index dab34a2322c95..cd01f1e41beb5 100644
> --- a/drivers/media/platform/rockchip/rkvdec/rkvdec.c
> +++ b/drivers/media/platform/rockchip/rkvdec/rkvdec.c
> @@ -257,6 +257,60 @@ static const struct rkvdec_ctrls rkvdec_h264_ctrls =
=3D {
>  	.num_ctrls =3D ARRAY_SIZE(rkvdec_h264_ctrl_descs),
>  };
> =20
> +static const struct rkvdec_ctrl_desc rkvdec_hevc_ctrl_descs[] =3D {
> +	{
> +		.cfg.id =3D V4L2_CID_STATELESS_HEVC_DECODE_PARAMS,
> +	},
> +	{
> +		.cfg.id =3D V4L2_CID_STATELESS_HEVC_SPS,
> +		.cfg.ops =3D &rkvdec_ctrl_ops,
> +	},
> +	{
> +		.cfg.id =3D V4L2_CID_STATELESS_HEVC_PPS,
> +	},
> +	{
> +		.cfg.id =3D V4L2_CID_STATELESS_HEVC_SCALING_MATRIX,
> +	},
> +	{
> +		.cfg.id =3D V4L2_CID_STATELESS_HEVC_DECODE_MODE,
> +		.cfg.min =3D V4L2_STATELESS_HEVC_DECODE_MODE_FRAME_BASED,
> +		.cfg.max =3D V4L2_STATELESS_HEVC_DECODE_MODE_FRAME_BASED,
> +		.cfg.def =3D V4L2_STATELESS_HEVC_DECODE_MODE_FRAME_BASED,
> +	},
> +	{
> +		.cfg.id =3D V4L2_CID_STATELESS_HEVC_START_CODE,
> +		.cfg.min =3D V4L2_STATELESS_HEVC_START_CODE_ANNEX_B,
> +		.cfg.def =3D V4L2_STATELESS_HEVC_START_CODE_ANNEX_B,
> +		.cfg.max =3D V4L2_STATELESS_HEVC_START_CODE_ANNEX_B,
> +	},
> +	{
> +		.cfg.id =3D V4L2_CID_MPEG_VIDEO_HEVC_PROFILE,
> +		.cfg.min =3D V4L2_MPEG_VIDEO_HEVC_PROFILE_MAIN,
> +		.cfg.max =3D V4L2_MPEG_VIDEO_HEVC_PROFILE_MAIN_10,
> +		.cfg.menu_skip_mask =3D
> +			BIT(V4L2_MPEG_VIDEO_HEVC_PROFILE_MAIN_STILL_PICTURE),
> +		.cfg.def =3D V4L2_MPEG_VIDEO_HEVC_PROFILE_MAIN,
> +	},
> +	{
> +		.cfg.id =3D V4L2_CID_MPEG_VIDEO_HEVC_LEVEL,
> +		.cfg.min =3D V4L2_MPEG_VIDEO_HEVC_LEVEL_1,
> +		.cfg.max =3D V4L2_MPEG_VIDEO_HEVC_LEVEL_6_1,
> +	},
> +	{
> +		.cfg.id =3D V4L2_CID_STATELESS_HEVC_EXT_SPS_ST_RPS,
> +		.cfg.dims =3D { 65 },
> +	},
> +	{
> +		.cfg.id =3D V4L2_CID_STATELESS_HEVC_EXT_SPS_LT_RPS,
> +		.cfg.dims =3D { 65 },
> +	},
> +};
> +
> +static const struct rkvdec_ctrls rkvdec_hevc_ctrls =3D {
> +	.ctrls =3D rkvdec_hevc_ctrl_descs,
> +	.num_ctrls =3D ARRAY_SIZE(rkvdec_hevc_ctrl_descs),
> +};
> +
>  static const struct rkvdec_decoded_fmt_desc rkvdec_h264_decoded_fmts[] =
=3D {
>  	{
>  		.fourcc =3D V4L2_PIX_FMT_NV12,
> @@ -276,6 +330,17 @@ static const struct rkvdec_decoded_fmt_desc rkvdec_h=
264_decoded_fmts[] =3D {
>  	},
>  };
> =20
> +static const struct rkvdec_decoded_fmt_desc rkvdec_hevc_decoded_fmts[] =
=3D {
> +	{
> +		.fourcc =3D V4L2_PIX_FMT_NV12,
> +		.image_fmt =3D RKVDEC_IMG_FMT_420_8BIT,
> +	},
> +	{
> +		.fourcc =3D V4L2_PIX_FMT_NV15,
> +		.image_fmt =3D RKVDEC_IMG_FMT_420_10BIT,
> +	},
> +};
> +
>  static const struct rkvdec_ctrl_desc rkvdec_vp9_ctrl_descs[] =3D {
>  	{
>  		.cfg.id =3D V4L2_CID_STATELESS_VP9_FRAME,
> @@ -354,6 +419,22 @@ static const struct rkvdec_coded_fmt_desc vdpu381_co=
ded_fmts[] =3D {
>  		.decoded_fmts =3D rkvdec_h264_decoded_fmts,
>  		.subsystem_flags =3D VB2_V4L2_FL_SUPPORTS_M2M_HOLD_CAPTURE_BUF,
>  	},
> +	{
> +		.fourcc =3D V4L2_PIX_FMT_HEVC_SLICE,
> +		.frmsize =3D {
> +			.min_width =3D 16,
> +			.max_width =3D 65472,
> +			.step_width =3D 16,
> +			.min_height =3D 16,
> +			.max_height =3D 65472,
> +			.step_height =3D 16,
> +		},

In the RK3588 TRM Part 1 paragraph 5.4.3, I see "Supported image size" :
64x64 to 65472x65472; step size 16 pixels

So I think .min_width and .min_height should be 64, not 16.

Cheers,
  Diederik

> +		.ctrls =3D &rkvdec_hevc_ctrls,
> +		.ops =3D &rkvdec_vdpu381_hevc_fmt_ops,
> +		.num_decoded_fmts =3D ARRAY_SIZE(rkvdec_hevc_decoded_fmts),
> +		.decoded_fmts =3D rkvdec_hevc_decoded_fmts,
> +		.subsystem_flags =3D VB2_V4L2_FL_SUPPORTS_M2M_HOLD_CAPTURE_BUF,
> +	},
>  };
> =20
>  static const struct rkvdec_coded_fmt_desc vdpu383_coded_fmts[] =3D {
> diff --git a/drivers/media/platform/rockchip/rkvdec/rkvdec.h b/drivers/me=
dia/platform/rockchip/rkvdec/rkvdec.h
> index acb9d72b130bb..df56bc0516ac9 100644
> --- a/drivers/media/platform/rockchip/rkvdec/rkvdec.h
> +++ b/drivers/media/platform/rockchip/rkvdec/rkvdec.h
> @@ -173,6 +173,7 @@ extern const struct rkvdec_coded_fmt_ops rkvdec_vp9_f=
mt_ops;
> =20
>  /* VDPU381 ops */
>  extern const struct rkvdec_coded_fmt_ops rkvdec_vdpu381_h264_fmt_ops;
> +extern const struct rkvdec_coded_fmt_ops rkvdec_vdpu381_hevc_fmt_ops;
> =20
>  /* VDPU383 ops */
>  extern const struct rkvdec_coded_fmt_ops rkvdec_vdpu383_h264_fmt_ops;


--d83a747f469b673037b2ddac5c4b1b006e570ceeb9bf13c9d6e293c89318
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYKAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCaM7DGQAKCRDXblvOeH7b
bo2VAPQMUnZKNwyoh8eJCiuJeyNNWbjCSZjmhTeAzULYb42SAP9IqjAdwsQOflEd
uruWgWvgX9tV9ctpTnHu54AujGmYAA==
=/x+y
-----END PGP SIGNATURE-----

--d83a747f469b673037b2ddac5c4b1b006e570ceeb9bf13c9d6e293c89318--

