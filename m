Return-Path: <linux-kernel+bounces-758369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCCBB1CE21
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 22:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D4F0627CCE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 20:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BEA621FF29;
	Wed,  6 Aug 2025 20:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mjn/KwJD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F3A1C5F23
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 20:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754513913; cv=none; b=MZoSvo49kLRwtOMCZL2Ksw4FjpXStI/9b9C2D+MJj4yaSQAzKhKWOXpUC4PEpUiVflX59XKPlDSd3dksyNskJScmh/jgDKml2gIH9k4fN5/DVyRTAZXsy9Wo9vNBOcwZ8xobYLPqtowGJj3LnUYvmQghR1ecF1pJIPSXxUunVP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754513913; c=relaxed/simple;
	bh=U1FeQRtLiG+q4sfmdpJ9bCgp5uUUcwrffLKyNe3Rxms=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cuPyF32K0X8YMZbRsh8mUvFV+GfECTrGX+/K/IE5z1oDD7B32wWSa9mBk2KEnHTPgqmQBgNyhCsgWcW3+3rYGorXv8zhVmGWiQdAtkXV9ywG9hyPeHxn/dBpeAaoi+eAy0LV1pG0qLXiJ4YOC8t5Jlw1eDW13Tv1qfApB1GTXCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mjn/KwJD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754513911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XL3JtSDnypcZCdbt3A90Mr99TpavO/k4/VrpLyiBez8=;
	b=Mjn/KwJDx4NWLHwmUop1Nqv4WAyrfRGGPQ6VLWLppjTzE2fHxEDvXhWKsDEjLYkfuCFLbn
	AjIl1GJZS0YnG13/Xqcrhdvw0jy+6kR8Pn5RnfUDpi25BypfqRn7oCyHUidd0u0p1gFlYn
	ROE/bZzCah4n6hvqXHras3zGrMdDY0Q=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-JWu8XBMAOveOUJpejklzKA-1; Wed, 06 Aug 2025 16:58:30 -0400
X-MC-Unique: JWu8XBMAOveOUJpejklzKA-1
X-Mimecast-MFC-AGG-ID: JWu8XBMAOveOUJpejklzKA_1754513909
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3e3fdfa4b39so512585ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 13:58:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754513909; x=1755118709;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XL3JtSDnypcZCdbt3A90Mr99TpavO/k4/VrpLyiBez8=;
        b=l5ppCDNUXODnrg5fSda9bOOwIhU5UqV2guCHY58WANl+VfrfXbtDoYgwJh3IB1kNZx
         QzytZYO/e9819fv3/T8eMHF8j6XTZu333ScgjZPrgmonOGG9ghpGtSzD6o9BunUrT+gT
         SdecyYD4HjDgLXW76q5fqgOBkx1YqpmkwniRaCzaGo3UlgEMtHsORAjHAm3nq/J1Nj4j
         KQeoN2r7Hn1k6rm+usM1lFdb/OGHGFqACdZFbATJFVjRBOWInR18MDPNKsoK5K0npsVO
         JZPGLpWTWayC7n3luQ2AvzOAmqvChk+AveuGAWsJgRheKUzZ2hOnYp4oQPufE8R6kvBL
         YMaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUADxAIL+Tdn+yAiM1uKt/BkYn5eMUplxlLcv/LBNyZyXCrD2CmX1wVDerJrIzRsC02pTGGtdFS53JZXFI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/uDIVg+BMxCO/GYyj57O0PqAG+W6qIgUjT3FU5Fs5tIybu3w+
	9fLGIADf3DL3vG5AyWpOMe/FAAn/tFytV/nhn1GelSW5XO1MGD0oW2xNyh6taZbGG/1Xz27Rl5N
	ir/xRv5qbDsFC11zhNGZXF0ZIjvOxf6mTkauSxToG32h7Vrem+yIfb2G4hCuGtfQu8g==
X-Gm-Gg: ASbGnctq47D5ou70QEaQvPEU/GG/bcaPAPoKjyjWvEgHIkQYwvfNDeWvTKg0ik5frkg
	Wh8KvUeFwrd8Wqh4s80dz0JfiR4AhFcgz3WJLOS/ohGZCeONG4tRJOBT26xB2bXH9hKTJbrUdAd
	Nk6mfP3ToEYoV7KpCiVbBVyncYIfUtPwEC6hdKEQk0ayfMlK4tx2n9fbIhL5N25Rk0yRnSexN4h
	9jZQgp5iMGRGiwaTfiM7wJ68wbWYRg5RoPj3ZSD/1kYhYq+bbLymV+kTl35lOMPvVS5dydSdYcz
	n8x+h1ONVbM0IbxDF3yZHu3iHdh1IYCIbw8h+PY4gP0=
X-Received: by 2002:a05:6e02:152e:b0:3e3:d2eb:52db with SMTP id e9e14a558f8ab-3e51b79eae2mr20687165ab.0.1754513909043;
        Wed, 06 Aug 2025 13:58:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvMHObcGautLtJ7984K/wyyriLvMdPXmyUUT5V0nwJ7vFbNm7fOcxZIXtiLyBYuGHd6raZZQ==
X-Received: by 2002:a05:6e02:152e:b0:3e3:d2eb:52db with SMTP id e9e14a558f8ab-3e51b79eae2mr20686945ab.0.1754513908609;
        Wed, 06 Aug 2025 13:58:28 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50ab01e84desm2049992173.51.2025.08.06.13.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 13:58:27 -0700 (PDT)
Date: Wed, 6 Aug 2025 14:58:25 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Leon Romanovsky <leonro@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Andrew Morton <akpm@linux-foundation.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, Christoph Hellwig <hch@lst.de>,
 dri-devel@lists.freedesktop.org, iommu@lists.linux.dev, Jens Axboe
 <axboe@kernel.dk>, Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linux-mm@kvack.org, linux-pci@vger.kernel.org, Logan Gunthorpe
 <logang@deltatee.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin
 Murphy <robin.murphy@arm.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v1 01/10] PCI/P2PDMA: Remove redundant bus_offset from
 map state
Message-ID: <20250806145825.2654ee59.alex.williamson@redhat.com>
In-Reply-To: <c9b6237964b9606418af400bb6bec5178fcffff2.1754311439.git.leon@kernel.org>
References: <cover.1754311439.git.leon@kernel.org>
	<c9b6237964b9606418af400bb6bec5178fcffff2.1754311439.git.leon@kernel.org>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon,  4 Aug 2025 16:00:36 +0300
Leon Romanovsky <leon@kernel.org> wrote:

> From: Leon Romanovsky <leonro@nvidia.com>
>=20
> Remove the bus_off field from pci_p2pdma_map_state since it duplicates
> information already available in the pgmap structure. The bus_offset
> is only used in one location (pci_p2pdma_bus_addr_map) and is always
> identical to pgmap->bus_offset.
>=20
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/pci/p2pdma.c       | 1 -
>  include/linux/pci-p2pdma.h | 3 +--
>  2 files changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index da5657a020074..274bb7bcc0bc5 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -1009,7 +1009,6 @@ void __pci_p2pdma_update_state(struct pci_p2pdma_ma=
p_state *state,
>  {
>  	state->pgmap =3D page_pgmap(page);
>  	state->map =3D pci_p2pdma_map_type(state->pgmap, dev);
> -	state->bus_off =3D to_p2p_pgmap(state->pgmap)->bus_offset;
>  }
> =20
>  /**
> diff --git a/include/linux/pci-p2pdma.h b/include/linux/pci-p2pdma.h
> index 075c20b161d98..b502fc8b49bf9 100644
> --- a/include/linux/pci-p2pdma.h
> +++ b/include/linux/pci-p2pdma.h
> @@ -146,7 +146,6 @@ enum pci_p2pdma_map_type {
>  struct pci_p2pdma_map_state {
>  	struct dev_pagemap *pgmap;
>  	enum pci_p2pdma_map_type map;
> -	u64 bus_off;
>  };
> =20
>  /* helper for pci_p2pdma_state(), do not use directly */
> @@ -186,7 +185,7 @@ static inline dma_addr_t
>  pci_p2pdma_bus_addr_map(struct pci_p2pdma_map_state *state, phys_addr_t =
paddr)
>  {
>  	WARN_ON_ONCE(state->map !=3D PCI_P2PDMA_MAP_BUS_ADDR);
> -	return paddr + state->bus_off;
> +	return paddr + to_p2p_pgmap(state->pgmap)->bus_offsetf;
>  }
> =20
>  #endif /* _LINUX_PCI_P2P_H */

Looks like you're relying on this bogus code getting resolved in the
next patch...

In file included from kernel/dma/direct.c:16:
./include/linux/pci-p2pdma.h: In function =E2=80=98pci_p2pdma_bus_addr_map=
=E2=80=99:
./include/linux/pci-p2pdma.h:188:24: error: implicit declaration of functio=
n =E2=80=98to_p2p_pgmap=E2=80=99 [-Wimplicit-function-declaration]
  188 |         return paddr + to_p2p_pgmap(state->pgmap)->bus_offsetf;
      |                        ^~~~~~~~~~~~
./include/linux/pci-p2pdma.h:188:50: error: invalid type argument of =E2=80=
=98->=E2=80=99 (have =E2=80=98int=E2=80=99)
  188 |         return paddr + to_p2p_pgmap(state->pgmap)->bus_offsetf;
      |                                                  ^~
./include/linux/pci-p2pdma.h:189:1: error: control reaches end of non-void =
function [-Werror=3Dreturn-type]
  189 | }
      | ^

to_p2p_pgmap() is a static function and struct pci_p2pdma_pagemap
doesn't have a bus_offsetf member.  Thanks,

Alex


