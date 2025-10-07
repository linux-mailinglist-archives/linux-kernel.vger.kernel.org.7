Return-Path: <linux-kernel+bounces-844597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D170ABC251C
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 20:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ADF464E4F8C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 18:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03816CA4B;
	Tue,  7 Oct 2025 18:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="tmwKodxh"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C52020C461
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 18:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759860373; cv=none; b=eYx8l/3m8oaopuvSC5UFicpA1MYH9t2azEO5Q1pISTPCKcYpcJz/ajWt8I8iO5tbmsjizfb9XCffp69lovZVhHB/8vK8R+yuzBqP7uTy5oSIjXl8nAyZv6eqYEUvbqyiwwulH5Am3yC6lpBnavH8+ZB7LJE5XT1m99w3GNKC5+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759860373; c=relaxed/simple;
	bh=jtt1r2V4Z3YHNsWmjgCrTd5nGu1x0RVKYwRh9BZVydc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q0WqbnIDFp8P+CCpbwdZwXWlSHYcYASMFAr9jDgr2eki4RWEy89lgBGfj1Wjyl1Tizsl2TODnZYMTLyKcVtV/PLdcInerCefF1loKfIxIaD4BhNrHuqeNR0e0pyYhVB19uuj5W3JdnMkSioK9kyjOqkXdFaroR3eu2wV/IuzWSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca; spf=pass smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=tmwKodxh; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ndufresne.ca
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-85780d76b48so642591385a.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 11:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1759860369; x=1760465169; darn=vger.kernel.org;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ch7TyWwa1EZJeBseqB4xaWFqVYs5eXriLyyqsfuTad8=;
        b=tmwKodxhKLxCZYU1bKztQUiQvW1cN6JGv7MOO3JkEdQs1C+FQJqcViflu7dLNkfKk2
         8HW3Xcd6twaeiFgZrtXl71m+j6f+fPzdfYcQdQXrKF4/HaqvDkSprtvnHGAp+xyRxq+1
         MetEVc4zmm32KSLjqsz8ND4DGb1uNcqdYVQi1zyHF8nTz0d8dE5/iU+YSDHxWAcY/vcl
         30jXkF84yC5I5hMJvkUmfu3Ol3JCxvh/x8HAt1FXbw3yvJCd5g4K2Elts3oSjTdE3Tf6
         ZFvbI3B5mwI6zoXNTNN5fEBA4YvmMPSbRDm62R7bHH700uX7gW1COfzBiMMiymi0FktA
         3zQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759860369; x=1760465169;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ch7TyWwa1EZJeBseqB4xaWFqVYs5eXriLyyqsfuTad8=;
        b=lhJa01vlgvw7aP9guj7WWlfyniJ+BUQxYajve8cn6AkyBIB/eBDpoNTAAeKCktI+ny
         IUNfc8kl55aB4AnpMKnx+eHevnndVCCszVWn63Rvj+RbVABeLDonn4S+GsWE/8exq3rq
         L1X9/SLi4MWmaIo6pSCIJUwPCzvPmVnKHhaCHq7JmmMfH+b5LP/ogHh2yVWjhfzB3hp3
         GmSQwTEicWiPufYj0PB+F20VHAVrKJb90RlBya66v16w/XYbwkgHbLC4KqfDuh963LDf
         ZpAXj+vnExzQM2oISETzUoyMaJRKayq/nmm5U7QzAaBTWTNU3FeyI89kJihmF8rb9SYm
         eBdg==
X-Forwarded-Encrypted: i=1; AJvYcCXVfnu0qlSCQ8cjD0iKar/Pw1xMU2CT16EuX5+4BsBDRjnPOknn1qzf1+gz4goxRK85JiQQgMfhckHfboM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza05sQYE6lFYNsgrOAzvy7QelLJqdozNkfSjtfzMV1lbFnoyEd
	FjRsnpz61jaerCmeApMALEl0oOSSyn2ptMjaiCKQe9bmuxl56HvU4Vj78k94UOYu8qY=
X-Gm-Gg: ASbGncvyqYU8WbpQ1TwLEaBvuiZ9hLvfHrJ3gnERqwmPqpyvGhpABJNHRkiHTTu5R9I
	Mo47f6sEzJYWyBZ5Dv+vWl7XMD9At5SkAGNaa/FNeiL/kx/rG3/d3rvYz2qHr5whtc74E3zrSnz
	w1cPwRTyDTkjkEpAuqLOyfk71FcUKuP+BBZoHEg7MqHc+Nfmc/Pdy98bzyDglKVGIyKkmRgKbf1
	CdnsXVcrL2+hS6ssv41xwdOx277OrItJywcrHRAoFPz85EdnZlirYPC9FjpmM0CoKQsWSW2qIBA
	erj5xEdukx/vRb0OzpoRKeBqGIY/vpGIcBbwmOwxA/GTL6jqkKucowP9IBg0Q4Vzvt5GhOZrz+y
	EFG0fGfjMMbhLFljEv/SfUD3iC/mwMdGePue4Ci7yfEalgYPlYk9TymTZLPirpvI=
X-Google-Smtp-Source: AGHT+IEd8+PaBlkFCf4TWlgW17RetR7onOYSu6eacanLHMSo1S6DckxwyV/Bqe+3v64BuZQrTcO0Vg==
X-Received: by 2002:a05:620a:4891:b0:860:a923:c114 with SMTP id af79cd13be357-8835088d4e8mr120315085a.26.1759860369140;
        Tue, 07 Oct 2025 11:06:09 -0700 (PDT)
Received: from ?IPv6:2606:6d00:17:ebd3::c41? ([2606:6d00:17:ebd3::c41])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-877796a1de6sm1488995285a.49.2025.10.07.11.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 11:06:08 -0700 (PDT)
Message-ID: <3c62e3c837d534ef5bc21a95ec1dc408c38cb8a0.camel@ndufresne.ca>
Subject: Re: [PATCH 00/16] media: platform: rga: Add RGA3 support
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Sven =?ISO-8859-1?Q?P=FCschel?= <s.pueschel@pengutronix.de>, Jacob Chen
	 <jacob-chen@iotwrt.com>, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, 
 Mauro Carvalho Chehab
	 <mchehab@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Rob Herring
	 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	 <conor+dt@kernel.org>
Cc: linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, kernel@pengutronix.de
Date: Tue, 07 Oct 2025 14:06:06 -0400
In-Reply-To: <20251007-spu-rga3-v1-0-36ad85570402@pengutronix.de>
References: <20251007-spu-rga3-v1-0-36ad85570402@pengutronix.de>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-IcsCjmyMK96ZjT/TchVY"
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-IcsCjmyMK96ZjT/TchVY
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Le mardi 07 octobre 2025 =C3=A0 10:31 +0200, Sven P=C3=BCschel a =C3=A9crit=
=C2=A0:
> This series adds support for the Raster Graphic Acceleration 3 (RGA3)
> peripheral, which is included in the RK3588 SoC. Unlike the RGA2 it
> can use the existing rockchip-iommu-v2 driver to handle iommu mappings.
> Also the RK3588 contains two independent RGA3 cores.

Thanks for working on this.

>=20
> Only scaling and format conversions between common 8bit RGB/YUV formats
> are implemented. Also the color space conversion is fixed to BT601F.
> This already allows a practical usage of the RGA3.

This seems quite limiting, can we expect an update on this, can't be that h=
ard
to fully implement.

>=20
> This was tested on a Radxa Rock 5T. With the increased clock speeds in
> the devicetree around 160 fps were measured when scaling and converting

This is quite vague, I've checked the patch and you didn't extend either th=
ere.
Is that an overclock or was it miss-configured ? Does RK implement a devfre=
q ?
Should that be moved with a voltage adjustement ? Is there any thermal near=
by we
should monitor ?

> from RGBA 480x360 to NV12 3840x2160. Without the clock speed scaling a
> default clock division factor of 2 is used and only around 80 fps are
> reached with one core. The v4l2-compliance tests only complain about
> the already failing colorspace propagation:


Did you do any more format testing to validation all supported combinations=
 ?
This is a tool [0] you can use to test this using GStreamer and how to use =
it
[1].


[0] https://gitlab.collabora.com/mediatek/aiot/lava-test-definitions/-/tree=
/main/avvideocompare?ref_type=3Dheads
[1] https://gitlab.collabora.com/mediatek/aiot/linux/-/blob/mediatek-next/.=
gitlab-ci.yml?ref_type=3Dheads#L282
>=20
> =C2=A0 v4l2-compliance 1.28.1, 64 bits, 64-bit time_t
> =C2=A0 ...
> =C2=A0=C2=A0		fail: v4l2-test-formats.cpp(923): fmt_cap.g_colorspace() !=
=3D
> col
> =C2=A0=C2=A0	test VIDIOC_S_FMT: FAIL
> =C2=A0 ...
> =C2=A0 Total for rockchip-rga device /dev/video0: 47, Succeeded: 46, Fail=
ed: 1,
> Warnings: 0
>=20
> =C2=A0 v4l2-compliance 1.28.1, 64 bits, 64-bit time_t
> =C2=A0 ...
> =C2=A0=C2=A0		fail: v4l2-test-formats.cpp(923): fmt_cap.g_colorspace() !=
=3D
> col
> =C2=A0=C2=A0	test VIDIOC_S_FMT: FAIL
> =C2=A0 ...
> =C2=A0 Total for rockchip-rga device /dev/video1: 47, Succeeded: 46, Fail=
ed: 1,
> Warnings: 0
>=20
> =C2=A0 v4l2-compliance 1.28.1, 64 bits, 64-bit time_t
> =C2=A0 ...
> =C2=A0=C2=A0		fail: v4l2-test-formats.cpp(923): fmt_cap.g_colorspace() !=
=3D
> col
> =C2=A0=C2=A0	test VIDIOC_S_FMT: FAIL
> =C2=A0 ...
> =C2=A0 Total for rockchip-rga device /dev/video2: 47, Succeeded: 46, Fail=
ed: 1,
> Warnings: 0
>=20
> Each RGA core is a separate /dev/video device. To distinguish the RGA2
> core from the RGA3 cores the Card type is set accordingly. Combining all
> cores into a single device and scheduling tasks to the best core might
> be a future improvement, if it is desired by upstream to handle the
> scheduling and selection in kernel space.

It took me some time to understand why you spoke about multicore here. You
forgot to say here that you add RGA3 into RGA2 driver. Some information on =
why
you went that path instead of a separate driver.

=46rom high level view, I don't think its a good idea to multi-plex over
heterogeneous core. They may not even produce the exact same pixels for the=
 same
operation. They also don't share the same MMU, and at first glance, the use=
 of
rkiommu in RGA3 means it can no longer handle CPU cache (though I don't kno=
w if
this is implemented/supported in upstream RGA2 driver).

>=20
> Patch 1-2 are general cleanups
> Patch 3-12 prepare the rga driver for the RGA3
> Patch 13 documments the RGA3 compatible value
> Patch 14 adds the RGA3 cores to the rk3588 dtsi
> Patch 15 increases the RGA3 core clock speeds
> Patch 16 adds RGA3 support to the rga driver
>=20
> Signed-off-by: Sven P=C3=BCschel <s.pueschel@pengutronix.de>
> ---
> Sven P=C3=BCschel (16):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 media: rockchip: rga: use clk_bulk api
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 media: rockchip: rga: use stride for offse=
t calculation
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 media: rockchip: rga: align stride to 16 b=
ytes
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 media: rockchip: rga: move hw specific par=
ts to a dedicated struct
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 media: rockchip: rga: use card type to spe=
cify rga type
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 media: rockchip: rga: change offset to dma=
_addresses
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 media: rockchip: rga: support external iom=
mus
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 media: rockchip: rga: remove size from rga=
_frame
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 media: rockchip: rga: remove stride from r=
ga_frame
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 media: rockchip: rga: move rga_fmt to rga-=
hw.h
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 media: rockchip: rga: add iommu restore fu=
nction
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 media: rockchip: rga: handle error interru=
pt
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 media: dt-bindings: media: rockchip-rga: a=
dd rockchip,rk3588-rga3
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 arm64: dts: rockchip: add rga3 dt nodes
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 arm64: dts: rockchip: increase rga3 clock =
speed
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 media: rockchip: rga: add rga3 support
>=20
> =C2=A0.../devicetree/bindings/media/rockchip-rga.yaml=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0 1 +
> =C2=A0arch/arm64/boot/dts/rockchip/rk3588-base.dtsi=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 50 +++
> =C2=A0drivers/media/platform/rockchip/rga/Makefile=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +-
> =C2=A0drivers/media/platform/rockchip/rga/rga-buf.c=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 78 ++--
> =C2=A0drivers/media/platform/rockchip/rga/rga-hw.c=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 356 ++++++++++++---
> =C2=A0drivers/media/platform/rockchip/rga/rga-hw.h=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 15 +-
> =C2=A0drivers/media/platform/rockchip/rga/rga.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 404 ++++++-----------
> =C2=A0drivers/media/platform/rockchip/rga/rga.h=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 74 ++--
> =C2=A0drivers/media/platform/rockchip/rga/rga3-hw.c=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 490
> +++++++++++++++++++++
> =C2=A0drivers/media/platform/rockchip/rga/rga3-hw.h=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 186 ++++++++
> =C2=A010 files changed, 1246 insertions(+), 410 deletions(-)
> ---
> base-commit: afb100a5ea7a13d7e6937dcd3b36b19dc6cc9328
> change-id: 20251001-spu-rga3-8a00e018b120
>=20
> Best regards,

--=-IcsCjmyMK96ZjT/TchVY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTvDVKBFcTDwhoEbxLZQZRRKWBy9AUCaOVWjgAKCRDZQZRRKWBy
9MYwAQDAFCIsXy2vnCz1b/y+9mKp3XI/R9oRTPcTXia35pLGywD/SLpU/azQOYuj
Eq4VTAEBMAbKxVFBtmRPL+5Gb/F4cAg=
=pSPZ
-----END PGP SIGNATURE-----

--=-IcsCjmyMK96ZjT/TchVY--

