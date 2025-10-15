Return-Path: <linux-kernel+bounces-854023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB5CBDD5ED
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 10:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 99CE64EF74A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 08:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5013E2F9D82;
	Wed, 15 Oct 2025 08:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tPOndvGx"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73DE2DD5F3
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 08:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760516636; cv=none; b=rvdo0yTyIsLY92vX/kB8gUcgxy5W+tnMB0Oh8wJm0GPShyVPkN4a//DRroI/t2VtOK0QHy2/rh/oNgQqhr/xwTdDeg0PAPvweSWlw4K36hLxPuB1ybBaDC+2k0fZe3JNHkVo3Z2yCeBNrjCwiShdg7Wx58sW/gNOKCSKQUPD0o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760516636; c=relaxed/simple;
	bh=L4v+wbz2Zpp087ZFicCGoOduYIcUD7gEgZ+FObJmfG0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oeUaprMZlMHQv/OrV8VFLXwYeobNtIqQJsh1zzEyLtimp3g7y8Q1x/kQpCUaaOWZ8XPwvkEB6mSRODQT3H5jEFp5JconCuRcRawXcjE0gcieKjwFZeyQlxG0Gz9otdeXVhzbFWWlaaRYWLpOowkN9p819Z4BFRp5mP3md0zag0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tPOndvGx; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b4736e043f9so988105566b.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 01:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760516633; x=1761121433; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UxCnKzSY0s+V96p4DaVIhmKltF/rpU8DxvPCKFc7GWY=;
        b=tPOndvGxk5RqaHiJZ5As/3Sb10NWYC6HFSo9NpaOwcO9Rvr2yWzfSIsorh/RVEP0AA
         sDaFRQ+hvprUVI/aPjJyI0FzGztGmMc2GqN4KFIjmwDtrKkp6O7yh3zPmD3TbWtWA14n
         ROmHGcARrXIusHPFMX5KHEIlbJtwp3iQJTtInJZF3cgpRqCN2t5YePs2R77t28oC6/58
         i4F+iT5hBP2MUX1XmzSMYjBmUIVMPfbtxwodtn5c3+Y4w+QUPLw6V9DG7ESEvMuvQ7Di
         tsD6DJ1bua0dshFrujD6cj84ic2slrlld144jUAopjtvKK31KZgD7Aa3sc8upFa1qZNL
         +y5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760516633; x=1761121433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UxCnKzSY0s+V96p4DaVIhmKltF/rpU8DxvPCKFc7GWY=;
        b=BJU4838n1z3CoXtX2rh1e1rM/Vhr9TqE7J9C9wfg4TG70NUQ7Grql8h0XmummRBncc
         eGpAyOPSrXDsdwHf6fcbDuMHIpvd0jec+ObAyD1CMfzuY+83HXavvKbqsbkV2VgBw4Lu
         u1yeXZlDXw5qXRCEgSy4l+FIlwKv7LJz2riY57a5ZCEQuBMt7+snb3KU14LjVsEf1G9c
         PKcaW4dW25yYHxCMeVJl7vMeGYiTgLuyB+C23asV9LNpVICT9z6X8QR7xxuTigwfZ6AZ
         xBLcxa2BE/4H0gO95drzbOzgZ+961aNY/OrtZyQOrVX6COHLJswnmo5JUQ4JJzlxXEun
         TabQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnquaTLzR2gbOkItc+HuRRbJCk7mm+vSOzKnIg5rOxO/WvY1cPlmvsf6Rq0tQVWodA3XrM4QZuFxotGbo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmvwFDGjTOgaQxBp3qXM6FJzXCX8/TUWotJjFgKYOz2xMr9GL2
	BGowH9X3xKwVxrIGPbQMgI9RmA5URKVqCc4McD+pWEsVZJxqNP1aDRSvnsjm0g04y042ImNhpnl
	vur+l3ZYK+kDSsPPkjYLJBf3cQ0x2aZJIHcdWVnxH/w==
X-Gm-Gg: ASbGncv7URBXzA9AbzUocUegYzn0zafFbL/n4V7hSy6onhOxASc9GVoLzVb7PxePC7p
	hcvns2TBTo+fUe8xOxYj8/g9M3SSpMm1uZxQD+/ZJ34St5LGLTdx2yeK71vRbQs2JjjFKdK0WLW
	NZu87jSs/uFS9cXOYzr+50CdhIFaT4BWMJlcxK5C61ENn2hT5nk9K1czaVwS8almTaA+5OoKv7X
	gri5SbxdbyFkn3tB/zoU02gs454jyX4QfIAPMqqcvMEsLD+gg/ixR1IjLOuoVHQ
X-Google-Smtp-Source: AGHT+IF6fAVbXX5F8RGBoYgvm1Rcu+YjAOh+2j+dceV3zwu5sKBKQXJ/9P1xM6qaFTcMjvhyJod16WrMFs6xq1ISgV0=
X-Received: by 2002:a17:907:3cc9:b0:b2a:5fe5:87c7 with SMTP id
 a640c23a62f3a-b50aa48d5f8mr3002756066b.12.1760516633022; Wed, 15 Oct 2025
 01:23:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013-dma-buf-ecc-heap-v8-0-04ce150ea3d9@kernel.org>
In-Reply-To: <20251013-dma-buf-ecc-heap-v8-0-04ce150ea3d9@kernel.org>
From: Sumit Semwal <sumit.semwal@linaro.org>
Date: Wed, 15 Oct 2025 13:53:41 +0530
X-Gm-Features: AS18NWAaxKRo-h7l2MFnUyuTRslFKXoRyt0fRoMbHV7S75RfcyEniVSpQAqfMSo
Message-ID: <CAO_48GGD8sCoQt_qWKqcbg6v7Cyi5U9QsxsvNOcqfkLRqHS7_w@mail.gmail.com>
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

Hi Maxime,

On Mon, 13 Oct 2025 at 14:05, Maxime Ripard <mripard@kernel.org> wrote:
>
> Hi,
>
> Here's another attempt at supporting user-space allocations from a
> specific carved-out reserved memory region.


Thank you for the series - I think it looks pretty decent, and with
Marek's Acked-by for the cma patch [1], I'm inclined to merge it.

I'll wait till today evening, in case there are any more comments, and
then go ahead and merge it.

Best,
Sumit.

>
> The initial problem we were discussing was that I'm currently working on
> a platform which has a memory layout with ECC enabled. However, enabling
> the ECC has a number of drawbacks on that platform: lower performance,
> increased memory usage, etc. So for things like framebuffers, the
> trade-off isn't great and thus there's a memory region with ECC disabled
> to allocate from for such use cases.
>
> After a suggestion from John, I chose to first start using heap
> allocations flags to allow for userspace to ask for a particular ECC
> setup. This is then backed by a new heap type that runs from reserved
> memory chunks flagged as such, and the existing DT properties to specify
> the ECC properties.
>
> After further discussion, it was considered that flags were not the
> right solution, and relying on the names of the heaps would be enough to
> let userspace know the kind of buffer it deals with.
>
> Thus, even though the uAPI part of it had been dropped in this second
> version, we still needed a driver to create heaps out of carved-out memor=
y
> regions. In addition to the original usecase, a similar driver can be
> found in BSPs from most vendors, so I believe it would be a useful
> addition to the kernel.
>
> Some extra discussion with Rob Herring [1] came to the conclusion that
> some specific compatible for this is not great either, and as such an
> new driver probably isn't called for either.
>
> Some other discussions we had with John [2] also dropped some hints that
> multiple CMA heaps might be a good idea, and some vendors seem to do
> that too.
>
> So here's another attempt that doesn't affect the device tree at all and
> will just create a heap for every CMA reserved memory region.
>
> It also falls nicely into the current plan we have to support cgroups in
> DRM/KMS and v4l2, which is an additional benefit.
>
> Let me know what you think,
> Maxime
>
> 1: https://lore.kernel.org/all/20250707-cobalt-dingo-of-serenity-dbf92c@h=
ouat/
> 2: https://lore.kernel.org/all/CANDhNCroe6ZBtN_o=3Dc71kzFFaWK-fF5rCdnr9P5=
h1sgPOWSGSw@mail.gmail.com/
>
> Let me know what you think,
> Maxime
>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
> Changes in v8:
> - Rebased on top of 6.18-rc1
> - Added TJ R-b
> - Link to v7: https://lore.kernel.org/r/20250721-dma-buf-ecc-heap-v7-0-03=
1836e1a942@kernel.org
>
> Changes in v7:
> - Invert the logic and register CMA heap from the reserved memory /
>   dma contiguous code, instead of iterating over them from the CMA heap.
> - Link to v6: https://lore.kernel.org/r/20250709-dma-buf-ecc-heap-v6-0-da=
c9bf80f35d@kernel.org
>
> Changes in v6:
> - Drop the new driver and allocate a CMA heap for each region now
> - Dropped the binding
> - Rebased on 6.16-rc5
> - Link to v5: https://lore.kernel.org/r/20250617-dma-buf-ecc-heap-v5-0-0a=
bdc5863a4f@kernel.org
>
> Changes in v5:
> - Rebased on 6.16-rc2
> - Switch from property to dedicated binding
> - Link to v4: https://lore.kernel.org/r/20250520-dma-buf-ecc-heap-v4-1-bd=
2e1f1bb42c@kernel.org
>
> Changes in v4:
> - Rebased on 6.15-rc7
> - Map buffers only when map is actually called, not at allocation time
> - Deal with restricted-dma-pool and shared-dma-pool
> - Reword Kconfig options
> - Properly report dma_map_sgtable failures
> - Link to v3: https://lore.kernel.org/r/20250407-dma-buf-ecc-heap-v3-0-97=
cdd36a5f29@kernel.org
>
> Changes in v3:
> - Reworked global variable patch
> - Link to v2: https://lore.kernel.org/r/20250401-dma-buf-ecc-heap-v2-0-04=
3fd006a1af@kernel.org
>
> Changes in v2:
> - Add vmap/vunmap operations
> - Drop ECC flags uapi
> - Rebase on top of 6.14
> - Link to v1: https://lore.kernel.org/r/20240515-dma-buf-ecc-heap-v1-0-54=
cbbd049511@kernel.org
>
> ---
> Maxime Ripard (5):
>       doc: dma-buf: List the heaps by name
>       dma-buf: heaps: cma: Register list of CMA regions at boot
>       dma: contiguous: Register reusable CMA regions at boot
>       dma: contiguous: Reserve default CMA heap
>       dma-buf: heaps: cma: Create CMA heap for each CMA reserved region
>
>  Documentation/userspace-api/dma-buf-heaps.rst | 24 ++++++++------
>  MAINTAINERS                                   |  1 +
>  drivers/dma-buf/heaps/Kconfig                 | 10 ------
>  drivers/dma-buf/heaps/cma_heap.c              | 47 +++++++++++++++++----=
------
>  include/linux/dma-buf/heaps/cma.h             | 16 +++++++++
>  kernel/dma/contiguous.c                       | 11 +++++++
>  6 files changed, 72 insertions(+), 37 deletions(-)
> ---
> base-commit: 47633099a672fc7bfe604ef454e4f116e2c954b1
> change-id: 20240515-dma-buf-ecc-heap-28a311d2c94e
> prerequisite-message-id: <20250610131231.1724627-1-jkangas@redhat.com>
> prerequisite-patch-id: bc44be5968feb187f2bc1b8074af7209462b18e7
> prerequisite-patch-id: f02a91b723e5ec01fbfedf3c3905218b43d432da
> prerequisite-patch-id: e944d0a3e22f2cdf4d3b3906e5603af934696deb
>
> Best regards,
> --
> Maxime Ripard <mripard@kernel.org>
>


--=20
Thanks and regards,

Sumit Semwal (he / him)
Senior Tech Lead - Android, Platforms and Virtualisation
Linaro.org =E2=94=82 Arm Solutions at Light Speed

