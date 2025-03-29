Return-Path: <linux-kernel+bounces-580514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43928A752CC
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Mar 2025 00:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B26F188FC9B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Mar 2025 23:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72D41F4716;
	Fri, 28 Mar 2025 23:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="peZbvp+u"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF15B1F4289;
	Fri, 28 Mar 2025 23:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743203428; cv=none; b=Z8TVqo3iivPSIK0Vbyd8Xbv3cmoRutIlQALyDlTG/8/17oEawMmpR4w8JejLRStdtvMoczIqyZ/XGg3bDyeAQjF7ofX3PlUSGYrxaP2nwRoyDoi7MjJoIcX4H+TiH39DwqcL73gGYfnNxMbMM7kOZKp6GTmVgF8NjuGo62ZQhRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743203428; c=relaxed/simple;
	bh=ZtFrf+mzUkTrV1Qx3IOHEMKDoqy5hET8ni7VLNqWj8Q=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=tl7eqBsCKDXuJI+hYx6g4fTA9bHB+irlZMag7jFu6dGnxv4vzNJLoxH/3U2USpO4f719jpeXgQqwtBmiZbkRhrjr721zGqEHdRKIyMMsnwLZ874gRa7mwISn/KxP0CmRSC8805uUupsh7w6MJSunVm/SSl+P/5mTLG+TUExVHp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=peZbvp+u; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1743203414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=STZ5FqUicffkrJ/L4Iet8L5svtmsV0SOVrQ2kmJ0+Bs=;
	b=peZbvp+uX7RO7KoL4c5LkiMV9GUERmSid94u0cMFjbQaGFwSN2DSW1OpH1skNxvhkURo1A
	jkRtr5yBcOCnJmSgWrw9Co3B0VdJ6u8y2RHP1+vpYoxZFStx1ZFVVelXjAe3Ngy7GVdL8c
	sU5xd+qeBvnfJUH68MmOS8Qlx/oHez74A2izAtEDSVJfTD4Jj3VsTM3KLmrdP59ofcc/ig
	MvkIz9QP/dgniHvjNifvgwaikCR1ZLkpxMPaQxn/bFsSgSO1BW6cvNDU7bDm3zPyTS5rcq
	2m7l6bOb01EHQ4Jr7Bk80AsAO/1IfMSt2m9MUCzpb1As6R477TQ1Rsiq21gCmA==
Content-Type: multipart/signed;
 boundary=7c928e379149c708ec657bfbf13635c86dc30623af4f2b5a98f0c352d1dd;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Date: Sat, 29 Mar 2025 00:09:37 +0100
Message-Id: <D8SA0W2ZEAQ3.3BO4NMONFJCRC@cknow.org>
Cc: "Ezequiel Garcia" <ezequiel@vanguardiasur.com.ar>, "Mauro Carvalho
 Chehab" <mchehab@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Heiko Stuebner" <heiko@sntech.de>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Hans Verkuil" <hverkuil@xs4all.nl>, "Nicolas
 Dufresne" <nicolas.dufresne@collabora.com>, "Andrzej Pietrasiewicz"
 <andrzej.p@collabora.com>, "Jonas Karlman" <jonas@kwiboo.se>, "Sebastian
 Reichel" <sebastian.reichel@collabora.com>, "Niklas Cassel"
 <cassel@kernel.org>, "Alexey Charkov" <alchark@gmail.com>, "Dragan Simic"
 <dsimic@manjaro.org>, "Jianfeng Liu" <liujianfeng1994@gmail.com>, "Jacopo
 Mondi" <jacopo.mondi@ideasonboard.com>, "Sakari Ailus"
 <sakari.ailus@linux.intel.com>, "Kieran Bingham"
 <kieran.bingham@ideasonboard.com>, "Laurent Pinchart"
 <laurent.pinchart@ideasonboard.com>, "Umang Jain"
 <umang.jain@ideasonboard.com>, "Naushir Patuck" <naush@raspberrypi.com>,
 "Jean-Michel Hautbois" <jeanmichel.hautbois@ideasonboard.com>, "Dmitry
 Perchanov" <dmitry.perchanov@intel.com>, "Tomi Valkeinen"
 <tomi.valkeinen@ideasonboard.com>, <devicetree@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-staging@lists.linux.dev>,
 <kernel@collabora.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/6] media: v4l2: Add NV15 and NV20 pixel formats
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Diederik de Haas" <didi.debian@cknow.org>
To: "Detlev Casanova" <detlev.casanova@collabora.com>,
 <linux-media@vger.kernel.org>, <linux-rockchip@lists.infradead.org>
References: <20250325213303.826925-1-detlev.casanova@collabora.com>
 <20250325213303.826925-2-detlev.casanova@collabora.com>
In-Reply-To: <20250325213303.826925-2-detlev.casanova@collabora.com>
X-Migadu-Flow: FLOW_OUT

--7c928e379149c708ec657bfbf13635c86dc30623af4f2b5a98f0c352d1dd
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Detlev,

On Tue Mar 25, 2025 at 10:22 PM CET, Detlev Casanova wrote:
> From: Jonas Karlman <jonas@kwiboo.se>
>
> Add NV15 and NV20 pixel formats used by the Rockchip Video Decoder for
> 10-bit buffers.
>
> NV15 and NV20 is 10-bit 4:2:0/4:2:2 semi-planar YUV formats similar to
> NV12 and NV16, using 10-bit components with no padding between each
> component. Instead, a group of 4 luminance/chrominance samples are
> stored over 5 bytes in little endian order:
>
> YYYY =3D UVUV =3D 4 * 10 bits =3D 40 bits =3D 5 bytes
>
> The '15' and '20' suffix refers to the optimum effective bits per pixel
> which is achieved when the total number of luminance samples is a
> multiple of 8 for NV15 and 4 for NV20.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Tested-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> Tested-by: Christopher Obbard <chris.obbard@collabora.com>
> ---
>  .../media/v4l/pixfmt-yuv-planar.rst           | 128 ++++++++++++++++++
>  drivers/media/v4l2-core/v4l2-common.c         |   2 +
>  drivers/media/v4l2-core/v4l2-ioctl.c          |   2 +
>  include/uapi/linux/videodev2.h                |   2 +
>  4 files changed, 134 insertions(+)
>
> diff --git a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst =
b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
> index b788f69338554..22cad8c9726bf 100644
> --- a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
> +++ b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
> @@ -79,6 +79,13 @@ All components are stored with the same number of bits=
 per component.
>        - Cr, Cb
>        - Yes
>        - Linear
> +    * - V4L2_PIX_FMT_NV15
> +      - 'NV15'
> +      - 10
> +      - 4:2:0
> +      - Cb, Cr
> +      - Yes
> +      - Linear

In your cover letter you mentioned:
Imported improvements from [1]
[1]: https://lore.kernel.org/linux-media/20250225-rkvdec_h264_high10_and_42=
2_support-v7-2-7992a68a4910@collabora.com/

The changelog of "media: rkvdec: Add H.264 High 10 and 4:2:2 profile
support" v7 had this:
- Move V4L2_PIX_FMT_NV15/V4L2_PIX_FMT_NV20 documentation as suggested

Following a comment on v6 of that series.

But it seems these blocks are now placed at the location as it was in
the v6 series, thus NOT importing its improvements?

>      * - V4L2_PIX_FMT_NV12M
>        - 'NM12'
>        - 8
> @@ -172,6 +179,13 @@ All components are stored with the same number of bi=
ts per component.
>        - Cr, Cb
>        - Yes
>        - Linear
> +    * - V4L2_PIX_FMT_NV20
> +      - 'NV20'
> +      - 10
> +      - 4:2:2
> +      - Cb, Cr
> +      - Yes
> +      - Linear
>      * - V4L2_PIX_FMT_NV16M
>        - 'NM16'
>        - 8

The same thing seemed to have happened here?

Cheers,
  Diederik

> @@ -302,6 +316,57 @@ of the luma plane.
>        - Cr\ :sub:`11`
> =20
> =20
> +.. _V4L2-PIX-FMT-NV15:
> +
> +NV15
> +----
> +
> +Semi-planar 10-bit YUV 4:2:0 format similar to NV12, using 10-bit compon=
ents
> +with no padding between each component. A group of 4 components are stor=
ed over
> +5 bytes in little endian order.
> +
> +.. flat-table:: Sample 4x4 NV15 Image (1 byte per cell)
> +    :header-rows:  0
> +    :stub-columns: 0

--7c928e379149c708ec657bfbf13635c86dc30623af4f2b5a98f0c352d1dd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZ+csSwAKCRDXblvOeH7b
bnEaAQDRs0XJAsCh5SV9NORF9yiBN4xK9/ksqMZ7dptPRBqK+wEA6MAvdIFDX8KV
IsH2OmXqqcmhBEjMEtZRNbYrv/vtFQM=
=JnIi
-----END PGP SIGNATURE-----

--7c928e379149c708ec657bfbf13635c86dc30623af4f2b5a98f0c352d1dd--

