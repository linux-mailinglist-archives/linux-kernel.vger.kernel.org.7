Return-Path: <linux-kernel+bounces-859282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49DB4BED35F
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 18:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C422E189ACA2
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 16:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A2E24166C;
	Sat, 18 Oct 2025 16:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QKF7Si/o"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83701E9906
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 16:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760803409; cv=none; b=FPnVT/liDUhBSDOSkf1E2IBP+5zjH0gVaoS+nUhB06KfUjNGjQDV0bVALWcP5HnA/Y83/BfLV0Gh+wLpoH+pUbX/+BjxI+GJ7saBblII08RzEcDoMvFG94FNStRFngvsIinWuu9FBb7+rsEl5y7k1QhkaGiptdgCDBIQEgfmbtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760803409; c=relaxed/simple;
	bh=AqHCcWojn351gM4lS2LpJMueGLu6kVYRaIe4ZTtmHj0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RkLz86FpYs3mkVr0Y6wJiSLjhuL7kQnP6/mkThF9KtIJh9oiDyy0H74kLTbtl2LKFoe2HCEI2aXmGxkUhiwCXaSVmmP9o9LCb07tPSgflHxWBrBi7+8ugFeBpyvsfyQU3yxHFEqQVP8bCTHzrfLB0R6operDPPGjaNBJjURxw58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QKF7Si/o; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b48d8deaef9so582966766b.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 09:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760803406; x=1761408206; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3PDE1i70uMuyHnvAFVWfjyIRl/K/1UfDOKuhRPGumqU=;
        b=QKF7Si/odLOpgeq3BmCPpvM/a9SPbdeTblMmb4wrYyrJTMY+s5Dtqqj5zqpp8bxA/c
         g1JqMusvRWHMxG8omKmad7fwld03Sfg5fFttIhDE65K2q16NQI9QMpLIX51oXms7/HS6
         lnyCgNaDeVNWI6Od9CqKFuC6vLVZENC3Bm2RQIbZIVscpt5dy2zBRM8oTtMjG+99cZAw
         WoyOJXx3u6vrWVQyya40gqOsJO8rbD01HrOVGspPOk5S8vYqP837Yl2oz4trgIL+0y34
         Q4XAGREjugN6Q3FTNkcvLVybJODK15LwDN5PZWzu1KOGxSK+bNIvXsTzy4a8XY/EIh2h
         7SOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760803406; x=1761408206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3PDE1i70uMuyHnvAFVWfjyIRl/K/1UfDOKuhRPGumqU=;
        b=qBoK4Mb/crhICmecjHqdDL0p3kZ1Lvj3ff3wqdl2XirFqZWeSmikDUcRgaNyLGw85S
         DLOOd+GOrNnBi15xEbF+9ULnscgeswW5IfgHmtkjHVQcLp6A9kLANO2UZHh0qx5c3P5h
         HzuZLqrj0c1MhbyOT6vHC1KdFEL9Yyw8KXQW6C8LZvq86Dh55KNZC/xD34G381dsnXhS
         YtrqO3V170hoFZCbqim1AIDqReaNnBbmMGRia1yYzY0lJ4rf0NaHfZ0TQwnfctbPsEru
         b5Pnu+oxi15YHP5A9itUfnw7VjLH3/0W8Kpv4KJASi+suh1CHAhiLmeFaGHsxnNaY5jj
         VOig==
X-Forwarded-Encrypted: i=1; AJvYcCUUA8Pooqz0tLvhJ9ZEp4Bi4cqrw5nG02xnjeRmXP0pTDa1BJ0m6jOMmTSHL6ohG/EyuozDOCarsOlFt/I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9OKLDsPf/u8ZKPHr+HgMQlod4pC3mnEzbbNqE8Ref2L0HQ05H
	wdE4a1zShg4sKxkG3Z+eph56VPqEXs/8UUOO5dS3RitG454dSx6HosfrcKwLp/fsMe/RgBA562k
	UiOJlCOmc9KGbzR63s7DjW4Np3hWLmTl0F6aTw2WOfg==
X-Gm-Gg: ASbGncsdMgt/pUT2TqdtpwcDqfMcZrhzf0Et4dwk3xg1oV+abfEX/RbDH9MRIgfSapk
	15A+mGIulUohenbOaroW+WH22/rsnOzGveWU00VScb1K/vS5QVhEA8umZUf3L/GAPtEDNo5Ib3H
	JxtHg3dW5gcFZto6cJJFe9Evf5Hu/U8q46XyRukM9xe4peb28yrgnxKqpXEFlrQdlR8W6+YyzDZ
	Lma/bgPORA1rU6M0TybakMZTH//XzUh9cH8s0uTon041zJSCiZaL2koyfaz0zM4hJyMXiHGUUx9
	dCpiwUb/xeJJI9JDQQIfieoiYxI=
X-Google-Smtp-Source: AGHT+IHexk19IgNk6IuP2jV+2x2wF7f0unp4c1GwwYyOBf/8w9heBdr+ysi7d7B9dpzKsMkgpYC1PUK3YyRIdsL9bbA=
X-Received: by 2002:a17:907:97d4:b0:b2a:10a3:7113 with SMTP id
 a640c23a62f3a-b64725722f3mr807862966b.29.1760803406106; Sat, 18 Oct 2025
 09:03:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013-dma-buf-ecc-heap-v8-0-04ce150ea3d9@kernel.org> <CAO_48GGD8sCoQt_qWKqcbg6v7Cyi5U9QsxsvNOcqfkLRqHS7_w@mail.gmail.com>
In-Reply-To: <CAO_48GGD8sCoQt_qWKqcbg6v7Cyi5U9QsxsvNOcqfkLRqHS7_w@mail.gmail.com>
From: Sumit Semwal <sumit.semwal@linaro.org>
Date: Sat, 18 Oct 2025 21:33:14 +0530
X-Gm-Features: AS18NWCxIWZfRS3hG4C_yzteaWS7C2gP5_aCiLwTRjHCdW6sGbeW-DvFPRdxwEc
Message-ID: <CAO_48GEXC0FDkeRN57e5Yc=4WCwjh=9pDpZXjowZzEaPPsAd-w@mail.gmail.com>
Subject: Re: [PATCH v8 0/5] dma-buf: heaps: Create a CMA heap for each CMA
 reserved region
To: Maxime Ripard <mripard@kernel.org>
Cc: Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	John Stultz <jstultz@google.com>, "T.J. Mercier" <tjmercier@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, 
	Andrew Davis <afd@ti.com>, Jared Kangas <jkangas@redhat.com>, 
	Mattijs Korpershoek <mkorpershoek@kernel.org>, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 15 Oct 2025 at 13:53, Sumit Semwal <sumit.semwal@linaro.org> wrote:
>
> Hi Maxime,
>
> On Mon, 13 Oct 2025 at 14:05, Maxime Ripard <mripard@kernel.org> wrote:
> >
> > Hi,
> >
> > Here's another attempt at supporting user-space allocations from a
> > specific carved-out reserved memory region.
>
>
> Thank you for the series - I think it looks pretty decent, and with
> Marek's Acked-by for the cma patch [1], I'm inclined to merge it.
>
> I'll wait till today evening, in case there are any more comments, and
> then go ahead and merge it.


Thank you; it's merged to drm-misc-next now.
>
>
> Best,
> Sumit.
>
> >
> > The initial problem we were discussing was that I'm currently working o=
n
> > a platform which has a memory layout with ECC enabled. However, enablin=
g
> > the ECC has a number of drawbacks on that platform: lower performance,
> > increased memory usage, etc. So for things like framebuffers, the
> > trade-off isn't great and thus there's a memory region with ECC disable=
d
> > to allocate from for such use cases.
> >
> > After a suggestion from John, I chose to first start using heap
> > allocations flags to allow for userspace to ask for a particular ECC
> > setup. This is then backed by a new heap type that runs from reserved
> > memory chunks flagged as such, and the existing DT properties to specif=
y
> > the ECC properties.
> >
> > After further discussion, it was considered that flags were not the
> > right solution, and relying on the names of the heaps would be enough t=
o
> > let userspace know the kind of buffer it deals with.
> >
> > Thus, even though the uAPI part of it had been dropped in this second
> > version, we still needed a driver to create heaps out of carved-out mem=
ory
> > regions. In addition to the original usecase, a similar driver can be
> > found in BSPs from most vendors, so I believe it would be a useful
> > addition to the kernel.
> >
> > Some extra discussion with Rob Herring [1] came to the conclusion that
> > some specific compatible for this is not great either, and as such an
> > new driver probably isn't called for either.
> >
> > Some other discussions we had with John [2] also dropped some hints tha=
t
> > multiple CMA heaps might be a good idea, and some vendors seem to do
> > that too.
> >
> > So here's another attempt that doesn't affect the device tree at all an=
d
> > will just create a heap for every CMA reserved memory region.
> >
> > It also falls nicely into the current plan we have to support cgroups i=
n
> > DRM/KMS and v4l2, which is an additional benefit.
> >
> > Let me know what you think,
> > Maxime
> >
> > 1: https://lore.kernel.org/all/20250707-cobalt-dingo-of-serenity-dbf92c=
@houat/
> > 2: https://lore.kernel.org/all/CANDhNCroe6ZBtN_o=3Dc71kzFFaWK-fF5rCdnr9=
P5h1sgPOWSGSw@mail.gmail.com/
> >
> > Let me know what you think,
> > Maxime
> >
> > Signed-off-by: Maxime Ripard <mripard@kernel.org>
> > ---
> > Changes in v8:
> > - Rebased on top of 6.18-rc1
> > - Added TJ R-b
> > - Link to v7: https://lore.kernel.org/r/20250721-dma-buf-ecc-heap-v7-0-=
031836e1a942@kernel.org
> >
> > Changes in v7:
> > - Invert the logic and register CMA heap from the reserved memory /
> >   dma contiguous code, instead of iterating over them from the CMA heap=
.
> > - Link to v6: https://lore.kernel.org/r/20250709-dma-buf-ecc-heap-v6-0-=
dac9bf80f35d@kernel.org
> >
> > Changes in v6:
> > - Drop the new driver and allocate a CMA heap for each region now
> > - Dropped the binding
> > - Rebased on 6.16-rc5
> > - Link to v5: https://lore.kernel.org/r/20250617-dma-buf-ecc-heap-v5-0-=
0abdc5863a4f@kernel.org
> >
> > Changes in v5:
> > - Rebased on 6.16-rc2
> > - Switch from property to dedicated binding
> > - Link to v4: https://lore.kernel.org/r/20250520-dma-buf-ecc-heap-v4-1-=
bd2e1f1bb42c@kernel.org
> >
> > Changes in v4:
> > - Rebased on 6.15-rc7
> > - Map buffers only when map is actually called, not at allocation time
> > - Deal with restricted-dma-pool and shared-dma-pool
> > - Reword Kconfig options
> > - Properly report dma_map_sgtable failures
> > - Link to v3: https://lore.kernel.org/r/20250407-dma-buf-ecc-heap-v3-0-=
97cdd36a5f29@kernel.org
> >
> > Changes in v3:
> > - Reworked global variable patch
> > - Link to v2: https://lore.kernel.org/r/20250401-dma-buf-ecc-heap-v2-0-=
043fd006a1af@kernel.org
> >
> > Changes in v2:
> > - Add vmap/vunmap operations
> > - Drop ECC flags uapi
> > - Rebase on top of 6.14
> > - Link to v1: https://lore.kernel.org/r/20240515-dma-buf-ecc-heap-v1-0-=
54cbbd049511@kernel.org
> >
> > ---
> > Maxime Ripard (5):
> >       doc: dma-buf: List the heaps by name
> >       dma-buf: heaps: cma: Register list of CMA regions at boot
> >       dma: contiguous: Register reusable CMA regions at boot
> >       dma: contiguous: Reserve default CMA heap
> >       dma-buf: heaps: cma: Create CMA heap for each CMA reserved region
> >
> >  Documentation/userspace-api/dma-buf-heaps.rst | 24 ++++++++------
> >  MAINTAINERS                                   |  1 +
> >  drivers/dma-buf/heaps/Kconfig                 | 10 ------
> >  drivers/dma-buf/heaps/cma_heap.c              | 47 +++++++++++++++++--=
--------
> >  include/linux/dma-buf/heaps/cma.h             | 16 +++++++++
> >  kernel/dma/contiguous.c                       | 11 +++++++
> >  6 files changed, 72 insertions(+), 37 deletions(-)
> > ---
> > base-commit: 47633099a672fc7bfe604ef454e4f116e2c954b1
> > change-id: 20240515-dma-buf-ecc-heap-28a311d2c94e
> > prerequisite-message-id: <20250610131231.1724627-1-jkangas@redhat.com>
> > prerequisite-patch-id: bc44be5968feb187f2bc1b8074af7209462b18e7
> > prerequisite-patch-id: f02a91b723e5ec01fbfedf3c3905218b43d432da
> > prerequisite-patch-id: e944d0a3e22f2cdf4d3b3906e5603af934696deb
> >
> > Best regards,
> > --
> > Maxime Ripard <mripard@kernel.org>
> >
>
>
> --
> Thanks and regards,
>
> Sumit Semwal (he / him)
> Senior Tech Lead - Android, Platforms and Virtualisation
> Linaro.org =E2=94=82 Arm Solutions at Light Speed



--=20
Thanks and regards,

Sumit Semwal (he / him)
Senior Tech Lead - Android, Platforms and Virtualisation
Linaro.org =E2=94=82 Arm Solutions at Light Speed

