Return-Path: <linux-kernel+bounces-724318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8D0AFF13F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 20:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACD681C8382C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 18:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3E823C38C;
	Wed,  9 Jul 2025 18:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="YKTpj/Jj"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782DB1CD1E4
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 18:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752087569; cv=none; b=LN1zW132UGZYnqG6m1V/11z48NYikz7msqVGMoo+cvURHJFwmqzip2cqXhLrACAb+TQ4ZdA4omV3CUbtVdkxlM1J8RQaxJ9nCunmFH44znd762BnMboLFbwcqigPZnewWFuTdNj9KNwSixhvEfA74B7GZNcvksMx1NnZZ8Fzld0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752087569; c=relaxed/simple;
	bh=XGAkAjqXaeQxQyulCGR3tIaiucKhABUC5GXTck/wb3k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Rg4+21Uzu6kAjXaiea7afbZYobPJzE7n8ffIHc25njaXrp+FLb1sNLdtXWQKlOmnfmxZu0fPOWfuf9UU/5y1L5ZB2LPBZmEpAk8i7Mo211ns7T7ClF0aQPad8AO5oaCh7s3xp+Q+t+0NbsWzC7BYb0N9agOG3e9WC8Ze9km5CTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca; spf=pass smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=YKTpj/Jj; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ndufresne.ca
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-70478ba562aso15165206d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 11:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1752087566; x=1752692366; darn=vger.kernel.org;
        h=mime-version:user-agent:autocrypt:references:in-reply-to:date:cc:to
         :from:subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hah8xMwtrntwfJmxq5xanQiqWRLwCEWuJJkLlImKYlo=;
        b=YKTpj/JjN7fgTbN08ADDsNCATVFlC0Txf1VmkVXSod9Dpc9Y0PSDpRF4qwVqEWPD6D
         q2MEkWe9PAUcFCSZoUZjJ+//5BX2cjyy0Ff3mvD1ypj3Q9fKFLkoLfQagbgvnSRmCmjo
         Dpn9Nsh8vDFP+y2Ojs30L1I486Qw3SsPsTGoVOcn86SFsoSvT+lY3OPtGBWoR/I4daMW
         byrcU3lzjPOLUMbGXkzl9judU5VLEy3YvhjhHLNgZ7Q5QTTZIb7BvTvwPN4CFx6yY7Mu
         g3c0G7e1cPVsAqZS8gz1vQKsYhbkId4+7CxuOVidRngHhvnfuTBKdNc/uSmOpGg+M2gI
         nRsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752087566; x=1752692366;
        h=mime-version:user-agent:autocrypt:references:in-reply-to:date:cc:to
         :from:subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hah8xMwtrntwfJmxq5xanQiqWRLwCEWuJJkLlImKYlo=;
        b=TD6mWCK4gvkiU/cV1hK2QBYfxnJ00/TYER/vGlfvkTfsUtWzgplWuPY0DhxkRt7qsQ
         EwTR5LkGwSNYm/KvF2NPqlwgain626MhAAXJlzBydjNZMpJ7cg8Pk1Gv83BjcqN6QPIO
         6Jv4gJak4S4y05xsIEAveiNTvYTyl1C5mWswg0pT4UUVXxrNFcSE9xYKBNqxi0g6e6OY
         n0WJCLSL4yb6tQ/3z/4oEERxdL94T45+FapDo/wLxRm8lClLOTQFnuSMPoU7Xg+BN7B4
         wYt/Aw3379+8vQDB5NhQMjU29yd1PessvlZbilLX+9Q4kdmI9gWfbEP7BwAlBwOouXWE
         niiA==
X-Gm-Message-State: AOJu0YxteqnqLEMYuZdBsrv3KPLNZIn+zpzKtPE04sLRcqRe4NZ5Zzmx
	hEd2ehxbKIeTP5xXZEABNDU/Wg0y4VGpfPLkEo/0EJKNZzGGHrEPDNXwYjToVcVhLPI=
X-Gm-Gg: ASbGncsrOy90O7XW9+tgXGX8WEXwhbeGDB5jzmxyokjYZ/nDCQbOdNxsWRrJNQ6q4RI
	ymLshpniG0lUKTw5I0gjCG2381lzA40XO+QAiuPZJEUEXArq6Ju+w5cqY6FeScFiLilc8haY6M0
	tXnUIiRI3YrAkHg/eIB+SX6Ulpdi++JTgeDXcpV8qavXUwhy9ZsR0R1TWErbe4aAd3q0fpclCd4
	/WWMnKprUik2aaE2NWaxoSi9ZLBMx5ekXFDmh590mkRdL5X3FRD/O77CyBQbY954wXz37EEZveF
	YKew9/HSBPKlcQ7i9+cOnc6EeuTRrTy+xmuQGJwdRMU587EP6vYN0O3cRMaPqr+mmeB+Xj1ETVA
	MTg==
X-Google-Smtp-Source: AGHT+IEsmXyVdEbnWdXGnl0jejitKG8pR37Z+42TY6cq1R1SWQIVZRAxicjh2OAHwFA4l3xkXwgkCA==
X-Received: by 2002:a05:6214:5f82:b0:704:886b:72dc with SMTP id 6a1803df08f44-704959cbf6emr8146366d6.2.1752087566238;
        Wed, 09 Jul 2025 11:59:26 -0700 (PDT)
Received: from ?IPv6:2606:6d00:17:b699::5ac? ([2606:6d00:17:b699::5ac])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-702c4cc7407sm96838676d6.8.2025.07.09.11.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 11:59:25 -0700 (PDT)
Message-ID: <b45e0cabadac5d2d9dbdc467b1c29f8eaae72c9c.camel@ndufresne.ca>
Subject: Re: [PATCH 1/8] media: uapi: Introduce V4L2 extensible params
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Jacopo Mondi <jacopo.mondi@ideasonboard.com>, Dafna Hirschfeld	
 <dafna@fastmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
  Keke Li <keke.li@amlogic.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 Heiko Stuebner	 <heiko@sntech.de>, Dan Scally
 <dan.scally@ideasonboard.com>, Sakari Ailus	 <sakari.ailus@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Date: Wed, 09 Jul 2025 14:59:23 -0400
In-Reply-To: <20250708-extensible-parameters-validation-v1-1-9fc27c9c728c@ideasonboard.com>
References: 
	<20250708-extensible-parameters-validation-v1-0-9fc27c9c728c@ideasonboard.com>
	 <20250708-extensible-parameters-validation-v1-1-9fc27c9c728c@ideasonboard.com>
Autocrypt: addr=nicolas@ndufresne.ca; prefer-encrypt=mutual;
 keydata=mDMEaCN2ixYJKwYBBAHaRw8BAQdAM0EHepTful3JOIzcPv6ekHOenE1u0vDG1gdHFrChD
 /e0MU5pY29sYXMgRHVmcmVzbmUgPG5pY29sYXMuZHVmcmVzbmVAY29sbGFib3JhLmNvbT6ImQQTFg
 oAQQIbAwULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBO8NUoEVxMPCGgRvEtlBlFEpYHL0BQJ
 oLLLGBQkJZfd1AAoJENlBlFEpYHL0BEkA/3qkWYt99myYFSmTJUF8UB/7OroEm3vr1HRqXeQe9Qp2
 AP0bsoAe6KjEPa/pJfuJ2khrOPPHxvyt/PBNbI5BYcIABLQnTmljb2xhcyBEdWZyZXNuZSA8bmljb
 2xhc0BuZHVmcmVzbmUuY2E+iJkEExYKAEECGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AWIQ
 TvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaCyy+AUJCWX3dQAKCRDZQZRRKWBy9FJ5AQCNy8SX8DpHbLa
 cy58vgDwyIpB89mok9eWGGejY9mqpRwEAhHzs+/n5xlVlM3bqy1yHnAzJqVwqBE1D0jG0a9V6VQI=
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-qC+6NnOKYiwDd0VA7yXp"
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-qC+6NnOKYiwDd0VA7yXp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mardi 08 juillet 2025 =C3=A0 12:40 +0200, Jacopo Mondi a =C3=A9crit=C2=
=A0:
> Introduce v4l2-extensible-params.h in the Linux kernel uAPI.
>=20
> The header defines two types that all drivers that use the extensible
> parameters format for ISP configuration shall use to build their own
> parameters format.
>=20
> The newly introduce type v4l2_params_block represent the
> header to be prepend to each ISP configuration block and the
> v4l2_params_buffer type represent the base type for the configuration
> parameters buffer.
>=20
> The newly introduced header is not meant to be used directly by
> applications which should instead use the platform-specific ones.
>=20
> Signed-off-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
> ---
> =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 6 ++
> =C2=A0include/uapi/linux/media/v4l2-extensible-params.h | 106 +++++++++++=
+++++++++++
> =C2=A02 files changed, 112 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 658543062bba3b7e600699d7271ffc89250ba7e5..49a9329e5fe8874bdbaca1394=
6ea28bd80134cb3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -25968,6 +25968,12 @@ F:	drivers/media/i2c/vd55g1.c
> =C2=A0F:	drivers/media/i2c/vd56g3.c
> =C2=A0F:	drivers/media/i2c/vgxy61.c
> =C2=A0
> +V4L2 EXTENSIBLE PARAMETERS FORMAT
> +M:	Jacopo Mondi <jacopo.mondi@ideasonboard.com>
> +L:	linux-media@vger.kernel.org
> +S:	Maintained
> +F:	include/uapi/linux/media/v4l2-extensible-params.h
> +
> =C2=A0VF610 NAND DRIVER
> =C2=A0M:	Stefan Agner <stefan@agner.ch>
> =C2=A0L:	linux-mtd@lists.infradead.org
> diff --git a/include/uapi/linux/media/v4l2-extensible-params.h b/include/=
uapi/linux/media/v4l2-extensible-params.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..ed37da433c6b1a34523b6a9be=
fde5c0dee601cfb
> --- /dev/null
> +++ b/include/uapi/linux/media/v4l2-extensible-params.h
> @@ -0,0 +1,106 @@
> +/* SPDX-License-Identifier: ((GPL-2.0+ WITH Linux-syscall-note) OR MIT) =
*/
> +/*
> + * Video4Linux2 extensible configuration parameters base types
> + *
> + * Copyright (C) 2025 Ideas On Board Oy
> + * Author: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
> + */
> +
> +#ifndef _UAPI_V4L2_PARAMS_H_
> +#define _UAPI_V4L2_PARAMS_H_
> +
> +#ifndef _UAPI_V4L2_EXTENSIBLE_PARAMS_GUARD_
> +/*
> + * Note: each ISP driver exposes a different uAPI, where the types layou=
t
> + * match (more or less strictly) the hardware registers layout.
> + *
> + * This file defines the base types on which each ISP driver can impleme=
nt its
> + * own types that define its uAPI.
> + *
> + * This file is not meant to be included directly by applications which =
shall
> + * instead only include the ISP-specific implementation.
> + */
> +#error "This file should not be included directly by applications"
> +#endif
> +
> +#include <linux/types.h>
> +
> +/**
> + * struct v4l2_params_block - V4L2 extensible parameters block header
> + *
> + * This structure represents the common part of all the ISP configuratio=
n
> + * blocks. Each parameters block shall embed an instance of this structu=
re type
> + * as its first member, followed by the block-specific configuration dat=
a. The
> + * driver inspects this common header to discern the block type and its =
size and
> + * properly handle the block content by casting it to the correct block-=
specific
> + * type.
> + *
> + * The @type field is one of the values enumerated by each platform-spec=
ific ISP
> + * block types which specifies how the data should be interpreted by the=
 driver.
> + * The @size field specifies the size of the parameters block and is use=
d by the
> + * driver for validation purposes.
> + *
> + * The @flags field is a bitmask of platform-specific control flags.
> + *
> + * Userspace shall never use this type directly but use the platform spe=
cific
> + * one with the associated data types.
> + *
> + * - Rockchip RkISP1: :c:type:`rkisp1_ext_params_block_type`
> + * - Amlogic C3: :c:type:`c3_isp_params_block_type`
> + *
> + * @type: The parameters block type (platform-specific)
> + * @flags: A bitmask of block flags (platform-specific)
> + * @size: Size (in bytes) of the parameters block, including this header
> + */
> +struct v4l2_params_block {
> +	__u16 type;
> +	__u16 flags;
> +	__u32 size;
> +} __attribute__((aligned(8)));
> +
> +/**
> + * struct v4l2_params_buffer - V4L2 extensible parameters configuration
> + *
> + * This struct contains the configuration parameters of the ISP algorith=
ms,
> + * serialized by userspace into a data buffer. Each configuration parame=
ter
> + * block is represented by a block-specific structure which contains a
> + * :c:type:`v4l2_params_block` entry as first member. Userspace populate=
s
> + * the @data buffer with configuration parameters for the blocks that it=
 intends
> + * to configure. As a consequence, the data buffer effective size change=
s
> + * according to the number of ISP blocks that userspace intends to confi=
gure and
> + * is set by userspace in the @data_size field.
> + *
> + * The parameters buffer is versioned by the @version field to allow mod=
ifying
> + * and extending its definition. Userspace shall populate the @version f=
ield to
> + * inform the driver about the version it intends to use. The driver wil=
l parse
> + * and handle the @data buffer according to the data layout specific to =
the
> + * indicated version and return an error if the desired version is not
> + * supported.
> + *
> + * For each ISP block that userspace wants to configure, a block-specifi=
c
> + * structure is appended to the @data buffer, one after the other withou=
t gaps
> + * in between nor overlaps. Userspace shall populate the @data_size fiel=
d with
> + * the effective size, in bytes, of the @data buffer.
> + *
> + * Each ISP driver using the extensible parameters format shall define a
> + * type which is type-convertible to this one, with the difference that =
the
> + * @data member shall actually a memory buffer of platform-specific size=
 and

There is some word(s) missing here, "shall actually <> a memory buffer".

Nicolas

>=20
> + * not a pointer.
> + *
> + * Userspace shall never use this type directly but use the platform spe=
cific
> + * one with the associated data types.
> + *
> + * - Rockchip RkISP1: :c:type:`rkisp1_ext_params_cfg`
> + * - Amlogic C3: :c:type:`c3_isp_params_cfg`
> + *
> + * @version: The parameters buffer version (platform-specific)
> + * @data_size: The configuration data effective size, excluding this hea=
der
> + * @data: The configuration data
> + */
> +struct v4l2_params_buffer {
> +	__u32 version;
> +	__u32 data_size;
> +	__u8 data[];
> +};
> +
> +#endif /* _UAPI_V4L2_PARAMS_H_ */

--=-qC+6NnOKYiwDd0VA7yXp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaG68DAAKCRDZQZRRKWBy
9N4QAQDuYZURTpzmoJglyeKORvbV7cP8/jDhLqozIEG7DMDUPAD9GBadfAg5f3J/
wIhi7od+eQPA7nxYjDzWzOxYbIsriAE=
=qXwV
-----END PGP SIGNATURE-----

--=-qC+6NnOKYiwDd0VA7yXp--

