Return-Path: <linux-kernel+bounces-754382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4003BB193BA
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 13:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 755E717652F
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 11:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B3425A2D2;
	Sun,  3 Aug 2025 11:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infinidat.com header.i=@infinidat.com header.b="dRZxmvdy"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AA02405ED
	for <linux-kernel@vger.kernel.org>; Sun,  3 Aug 2025 11:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754218927; cv=none; b=r/6pSer0GmsS1u49YEZrP3sKut/aW/zkvUBxSLPVjtMzJKOXV/xtWVBFjG8cINSEvTjEQu73xPztFhhhsLAmWesVWyG+W/DeHrfkvnhgOtecuAjg1IMedrNjt9h7k9qfW5Oayfs10gvuKu7RSiw8fkroFF470VqlCKZYWulVVNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754218927; c=relaxed/simple;
	bh=C7Z58OC7OFNFczmgKyOLcQXgEOfSXmydWhhPa+vt0B4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Pt6NLhWNoX+ptpbHEgA2mDeEnajenlzHPZlrFMsLbKhn3p9UdobvgiEgQn+5Yhw6mnSy/2IlYGkEbiHBY+/LEUD7De3x9KsFs63jF2wqBdS+lCPJmMEWbTPO5WU+BCQC/vguxmQUnoURD1wb9R3w9+y2uBwwPPgIcp/va5eRGro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=infinidat.com; spf=pass smtp.mailfrom=infinidat.com; dkim=pass (2048-bit key) header.d=infinidat.com header.i=@infinidat.com header.b=dRZxmvdy; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=infinidat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infinidat.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6f8aa9e6ffdso38260296d6.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Aug 2025 04:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=infinidat.com; s=google; t=1754218924; x=1754823724; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sHJHFI8hYd2LP/vvUObzJgvGzX/H7h58j8T4oERKROw=;
        b=dRZxmvdypCDcxoA/THjPAC959YdXdwgjNUeMrkcWWsjLJWuSVje/pH8NG3p3Q8QfFM
         x8XvOTOQFY7jCqBOHszam1Isn3OaoUWX9+z6Vv8sgRWiN8haA+sibOXVIwoei3ldof+e
         3ER1mjivOjFzx8Cd0SGwRR7vzXQrflX3PTlQcfHA40M3jXj8Qz1iHKo5opgps9qpDdjA
         HL/xmMyujxTWAiRg5R4EvfXiSolwO3noubtGbs3IB81MAkqWNsf/sGO/yzs+n3ULHlRn
         Gbo+gtH8Lg5o5elmoDDKjCfGli8l/Dsc64eCsR6RyNmHlcfTgdNYCky45OXaeByxE59y
         h25g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754218924; x=1754823724;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sHJHFI8hYd2LP/vvUObzJgvGzX/H7h58j8T4oERKROw=;
        b=WbTOgJKC0GOOD5kFGM/G9S5Hb7SwIAxjyaOOAqDvRAjJp8NmwwLNsxKkOx4JlyuAE9
         1cZUJzNR8pnsh82q+W30acm6yD1mN3lTtcnkrUbm9QXQ3xQoqf0NEnCnDhkQAxM8PO1R
         ldKd338l91vU7Fe0kykBZ5Z+19HlP+8ieAuqRetdabg4qKFXwU9fQjCjkGCuNzTSCnkz
         ipqF8bZ8am46f6knuqHqHB07Si95yrE2KnyNK4doiC7EJymUlMF5kZSduTxo0py5to2O
         URSCRd5i9Up3cw48ahClmTZgxuNhgFqwWIY/57MYcE0Q7H0VhKpfcT0/hj+e7LprH6ZF
         EPRw==
X-Gm-Message-State: AOJu0Yz3mvU8S0Srbh1+4yUMev35c2QDkqNqFsFH7VcliZqJgQs/aAhY
	f19Nlr5/k+s/FOcT+xSkmmbti63yVyTWVaKtmPLadTaMjR9Qc6kfgfIBBoWbcgsXQyvRH2wMIic
	3ggzKuKC+ifxCJy4YGk71uyYLfLcbzxCDQo/ZiSYRAbKH/Xn+j6l0Ot4=
X-Gm-Gg: ASbGnctCi5U5rJW03AUA+s4vak9KmqwTnMnCtQ3ONW/chiLjmACPIz+9ShCBa6s2Znb
	T5cPeTLZwrr0S8dkvh4o5shMbb0Z1YfKBcuKJRWgw7sSq6S19dquUBWI+mn3S/rI+Y0M4cyRyit
	YPxidGb5ePmCj8yYgeFyiHYqrdGJbwWPDEUG3zXcVXh2HecbUk5LwkJSzyFGfQzphamm9fq5iCt
	Dj5mmhokQ==
X-Google-Smtp-Source: AGHT+IGRy/xMzqtf4koj2JD4SaY51BoAsV5pFfiAe7ZJi9SAx8UHLoLsdUibItxHFatFC+CPQoG6khb8yDFziTpbfMc=
X-Received: by 2002:a05:6214:f2e:b0:707:7695:eaa0 with SMTP id
 6a1803df08f44-7093629a381mr85992156d6.32.1754218924413; Sun, 03 Aug 2025
 04:02:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEHaoC2BWe+0Ps2oU-0xPDLFYYKG-o9+_ynFgh7u3qqyRDtrTg@mail.gmail.com>
In-Reply-To: <CAEHaoC2BWe+0Ps2oU-0xPDLFYYKG-o9+_ynFgh7u3qqyRDtrTg@mail.gmail.com>
From: Constantine Gavrilov <cgavrilov@infinidat.com>
Date: Sun, 3 Aug 2025 14:01:53 +0300
X-Gm-Features: Ac12FXxHIPP0kSwrKnrZ-6DQ9avAY_dlG0jN8mCC9KfQKZ-xZ_IbcCwwk9ACooQ
Message-ID: <CAEHaoC22NDpHUWovJChCx_XqchkEvUPYrFFe_L1PH9Mw2e386A@mail.gmail.com>
Subject: [PATCH 0/8] Large DMA alloc/skip 32-bit alloc if size > 32-bit
To: linux-kernel@vger.kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

This is the first patch from the set of patches that enable large IOMMU
DMA registrations. Entire work is available at the master branch of the
master branch of git@github.com:cgavrilov/linux.git repo.

Do not consider 32-bit range allocation and skip iterating the rbtree,
if the allocation size exceeds 32-bit.

commit 1c21c64befe18d626855a828c721eb786dbb69b8
Author: Constantine Gavrilov <cgavrilov@infinidat.com>
Date:   Sun Jun 22 13:05:26 2025 +0300

    iommu_dma_alloc_iova(): do not try to allocate 32-bit address if
the size is above 32-bit.

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index ea2ef53bd4fe..8280e8864ef3 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -772,7 +772,7 @@ static dma_addr_t iommu_dma_alloc_iova(struct
iommu_domain *domain,
      * some inherent bug in handling >32-bit addresses, or not all the
      * expected address bits are wired up between the device and the IOMMU.
      */
-    if (dma_limit > DMA_BIT_MASK(32) && dev->iommu->pci_32bit_workaround) {
+    if (dma_limit > DMA_BIT_MASK(32) && (size - 1) <=
DMA_BIT_MASK(32) && dev->iommu->pci_32bit_workaround) {
         iova = alloc_iova_fast(iovad, iova_len,
                        DMA_BIT_MASK(32) >> shift, false);
         if (iova)

-- 
----------------------------------------
Constantine Gavrilov
System Architect and Platform Engineer
Infinidat
----------------------------------------

