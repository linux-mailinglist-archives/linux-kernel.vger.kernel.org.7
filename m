Return-Path: <linux-kernel+bounces-892642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 59785C4581D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D0BE4347B0D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA2E2FD684;
	Mon, 10 Nov 2025 09:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R79pN4G7"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D166F2F7AA6
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 09:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762765519; cv=none; b=gylRBHZKSIjAWDAI0n+0jI9KaQ53E2CTwc1p8Pbm/ZIOImdKjU+RQqQiDFZJXqHjJDNuMXWtA2NjzB5gmAq5dgeIRAhEetYVcdwq75RFxK1THnpEhjYmiIQV/yHboJ93ZdmpkxgfbSISZhRguc3PA/W+hmipiKkmjrWxIGy2gdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762765519; c=relaxed/simple;
	bh=FibnNY3rLzXeYPxd3Rrzvn14XnHeVUhzvurH2wd38Ec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PS+L49I+Vkdc97sX4ssWx3KWWxosXWEkmHZk3cHbtL8R3aQ8Koj+Kg6tWLh7JOFo2zviHplf8cQzKuSv9fQXx4JPN1YgntUyFNjxyfjUGXar+YCXymnUWXxFpBC0i4/efdPoqSONQ8m8hS5UKsgBEvSQi+Ek9owBFulofLUGjtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R79pN4G7; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-59445ee9738so2181867e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 01:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762765515; x=1763370315; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nqciFDSqnLy9jkuBMsgahobg3NxRSzw/2FJr1jOeUsg=;
        b=R79pN4G7SpCGkCq8nebic5CZCv2b+fzntzcNEQOoHlaaziC1GOmuKIsrp8XiSyH5sB
         axw11GfBuGvOsYouxxN1CjRyiSoNEikCgaMdFq20OAZQnm6BPMQZD/E0zEenFvSggJqt
         m5KKqRemlgR/IEnzogQ0Ckg9kGqZGKkCcjJbTPbJ1FtPKEgwpkKmsIh0NPFnU+jl4Ikk
         /UhCg56WCMTAr08RrZXKFH37MtSFUIG52xEE54q0QMdT6b+sV5LezMQdvJX3XTL353vn
         Jkh4yWMPQlgMB+CDjBPG0ch91TOJbY77KjNQHfUTNtNnY+P1PtK+omfxirGM2o8JXMVv
         Tx6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762765515; x=1763370315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nqciFDSqnLy9jkuBMsgahobg3NxRSzw/2FJr1jOeUsg=;
        b=M6RqyLxLY9Sv9cA2xrwFtQOLZK01Ec1IYRugFmRB/8ke2mINt2GSVFEAjKeo+fh/ho
         Cll8mJZj2xw2LA0y39SYtqlJyMgYk9kOrUZCgVRwJpnedgQimmG5Pjc2IrtxTTArIu7t
         Jku1lJ+48fCTKIteLv0kGKAXaNUp0oOdPVFBzT+DN7DVPzXTzwZBw5sRPeTrY5D4wO6z
         wE2dbvN7gT8WmonH2NQXHRQTtPyhh2DQmhmk+8/7WKIp4Ghqf10sDO1hBgd3e5Ktoef+
         T30bOXPW1tEGbA6UE8B0VFOIntP4KM38zS7/Canu33xKouw0aYSgmvhDkBltGg13G+On
         AQ6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVLig+UrDMFKV6mAK4iW+/iQFXIay/9sg4zPe5k0brbOp8jncj7HKuhkNZXr6B8xjoIQN+OFsSVScOpkkw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTOZ1H9ZqvGhvgtq7iAVk76B50TVTryzSRmQ397cpjbTuOQOni
	3X5joLsyIsi6JfAWHDn//d9JVF2sBWMD+gf6sWxRVbLkD1TmkpOSCC7G5CYjaQ==
X-Gm-Gg: ASbGncvTjPtWtOzu+awjbSeVn8oNX/iCiePc/ZaElQ/O6qyrewvuh99F07fAJEVufqv
	0cxnZpjO/MnAv49u4jWUHNTy99VylFQPK1k8AjjgLxj8SkzZGR4CzIW+MBQinHPEdJl6b4g4Juh
	yJNyAJLcQRmAP/PBUgp23NT32ntoB/5E/kZiCsS9zbt7EQsbwC4uFztZa1tPhoeD80Hb9AKTcc1
	fODJCOHy0gaW8lg6Qa9R+eaW9OhwnUCOQ6TIgW1bNQAr3qOISMy/b4k9kDa/1PrSBXbdPaD/fAJ
	1jVrZ424+5eJIkWTrFzFOxHJgUfrjXcoyNpFjGD0jqWkYqEI3eckRtY8Ccld48JbNo1dAUtHN9y
	1IGJsFT/E6ea2yU54xhGB5d/kXBoV6ZaqTPZ9N14Qn05JFsSGt9cGQg/ow4TJTnYpcMP7OGjh4Q
	N9eWPqDflQyD1g+YGpjPLYas+3Ite0wTIyReQA
X-Google-Smtp-Source: AGHT+IHlT7p1xPZPwDzNrMkeYdBcwqrNZRMnOg07nKvN1/mHuyt/BB9fEQpcBJ5qJ7azHTuwvrCc8g==
X-Received: by 2002:a05:6512:318f:b0:594:2cdf:1941 with SMTP id 2adb3069b0e04-5945f1dba9bmr2218203e87.31.1762765514601;
        Mon, 10 Nov 2025 01:05:14 -0800 (PST)
Received: from gmail.com (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-594549b4cc6sm3148451e87.15.2025.11.10.01.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 01:05:13 -0800 (PST)
Date: Mon, 10 Nov 2025 10:05:11 +0100
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] drm/sitronix/st7571: split up driver to support
 both I2C and SPI
Message-ID: <aRGqx6BDCYw_z206@gmail.com>
References: <20251027-st7571-split-v2-0-8352fb278d21@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lzylSUmEWLw12z5/"
Content-Disposition: inline
In-Reply-To: <20251027-st7571-split-v2-0-8352fb278d21@gmail.com>


--lzylSUmEWLw12z5/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Friendly ping on this series.

Best regards,
Marcus Folkesson


On Mon, Oct 27, 2025 at 09:05:40AM +0100, Marcus Folkesson wrote:
> This series splits up the driver and finally implements
> support for ST7571/ST7561 connected to a SPI bus.
>=20
> I've not tested the SPI interface myself as I lack HW, but the
> implementation should be okay from what I've read in the datasheet.
>=20
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---
> Changes in v2:
> - Add MODULE_IMPORT_NS to st7571-i2c.c st7571-spi.c (Kernel test robot)
> - Link to v1: https://lore.kernel.org/r/20251024-st7571-split-v1-0-d3092b=
98130f@gmail.com
>=20
> ---
> Marcus Folkesson (6):
>       drm/sitronix/st7571-i2c: rename 'struct drm_device' in st7571_device
>       drm/sitronix/st7571-i2c: add 'struct device' to st7571_device
>       drm/sitronix/st7571-i2c: move common structures to st7571.h
>       drm/sitronix/st7571-i2c: make probe independent of hw interface
>       drm/sitronix/st7571: split up the driver into a common and an i2c p=
art
>       drm/sitronix/st7571-spi: add support for SPI interface
>=20
>  MAINTAINERS                           |    3 +
>  drivers/gpu/drm/sitronix/Kconfig      |   38 +-
>  drivers/gpu/drm/sitronix/Makefile     |    2 +
>  drivers/gpu/drm/sitronix/st7571-i2c.c | 1003 ++-------------------------=
------
>  drivers/gpu/drm/sitronix/st7571-spi.c |   76 +++
>  drivers/gpu/drm/sitronix/st7571.c     |  918 +++++++++++++++++++++++++++=
+++
>  drivers/gpu/drm/sitronix/st7571.h     |   91 +++
>  7 files changed, 1162 insertions(+), 969 deletions(-)
> ---
> base-commit: 07a4844f2ef49f352ef46d0a4774ad63576a6694
> change-id: 20251024-st7571-split-c734b06106a4
>=20
> Best regards,
> --=20
> Marcus Folkesson <marcus.folkesson@gmail.com>
>=20

--lzylSUmEWLw12z5/
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAmkRqsMACgkQiIBOb1ld
UjLp/g//Wx8Zi8J9ICoijzYuUwNfbXTHvgCr93+F4ailefBExI9+zdkZW7BhG+05
6Gy5wbhj62B5uOQDW7OCqZnkNoky80cir5MrL+340kiBM7GBVTgdYLQhxi4MaW2+
ekcpY3hvm5gtADlp1pwt1Uzm75sC2mQmUlJY3Ld0F4ycdmKDiBRf5ErpbS5U499A
AEXXuoo6cMU0rETR+fgwkP+zzM24OIwD52AukXnwdQ/bSkQc85fhcnYO8f2tll5D
DdMsNdH7JTQNXbLzk4VBkwAokbepRGVEHCO4tHtDKwTsU4bMgocPBD8XANYu3xsS
gfhzVcTEi9HUy5ZMZPZ6RrUL3COCLt/v4Hxrs3CHtjccEmTzJqHVGl7pOaKtHxgM
k4jHvqHUb15LuTraDirkIehgS11AGjhJ1r01SmEM9jp8v5AbpaqMh4ifTDpJHJK5
MR0T7F/pWvE5EkxlkT7SdT0bJP5PgS1EGyVUX+sFNz5hYOJNAIkU8CseXzBwunAB
fq4gfwbOmDbzywDim+sxoKccDDn6nTuGV26X86seadGDmA6fhdtqVkvjbxSnICkL
N+SJzSySyjd8lFD4+oONJ3AASfBwQ6EA8M867v738rJh97hNYI8Y2HgdZme0SHGu
I995QZGM284vJ2Wkel/kUKhpJYFvChkwjA1zEXcPnckMiO4FoCU=
=DbrE
-----END PGP SIGNATURE-----

--lzylSUmEWLw12z5/--

