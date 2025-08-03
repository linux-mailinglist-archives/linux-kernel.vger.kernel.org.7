Return-Path: <linux-kernel+bounces-754396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DFBB193D1
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 13:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDA6D3A8D96
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 11:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91BAF258CFF;
	Sun,  3 Aug 2025 11:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infinidat.com header.i=@infinidat.com header.b="Z0UWOSpC"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553DB21422B
	for <linux-kernel@vger.kernel.org>; Sun,  3 Aug 2025 11:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754219631; cv=none; b=LUBIfQIBmIGeJyNS9Qy6t8Ml0sdXmJHxnPGJ9pWW15TfZAinlVGyhMRSMMLlZu8LCevz4zWI/u11pjlodKpKAxK+6As1tHbFBfTgjopBtACMVsesJWDwzjvupOVeitBUpbbTyNGDRbd53xjCMQv3kmn0Mv98mj4Yk4Vw/GnG5oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754219631; c=relaxed/simple;
	bh=O+g8CxkQPuLesApubC8IAJLYwASoA8Ig8vnN1L8Il2E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=IksnXSN8Snih5lwZG4WpG4ilSRlXimXKOpVdePMWk3b4n4I+RX9uvS+bl3Mc7683a+COpNa+pGIl1/AdqJvBKyjoRz3p6n8M47dtd6PO00TiyunhKOH09mI4wa48AK22LbHEa+FT0G/1tGDaHP/Ha79n3VmM3S+XXCwkcjKTObo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=infinidat.com; spf=pass smtp.mailfrom=infinidat.com; dkim=pass (2048-bit key) header.d=infinidat.com header.i=@infinidat.com header.b=Z0UWOSpC; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=infinidat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infinidat.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-7076eaa5febso9298846d6.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Aug 2025 04:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=infinidat.com; s=google; t=1754219628; x=1754824428; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GEUjqEm9tcGU+yKMIokzl2jHHPWYnk7whteuYDv/T20=;
        b=Z0UWOSpCSfVDEiVaJowARbNs7zVoETedG5WZu0uWclOX33DiQ9uIzoGyu49aIKTlNQ
         bHZyK7Z3OWIsnqydXI4gv8dyP/CHIKShZAqammmAHqw3QGpuw3QVHKma/8cs2NpmhcV6
         82gOph3QS4O6jHCJl2z3O65BTAhqLufvbIuKIxkwj39PO8BlF8bhwe30QNOr6jruGA7x
         2l0Qm2Iq+cIjVIWqj1MT+whS5SWFG7vvscI2R6mrtNt1cyr+73rFVJ8yG/DoBM49w2v6
         ljGVj1RF7rxtnoi0NA4RyDssGOGFruypmfIuajs2y+YInomxSOwXsQ9asku1gJMfcB8I
         NSMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754219628; x=1754824428;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GEUjqEm9tcGU+yKMIokzl2jHHPWYnk7whteuYDv/T20=;
        b=aQVbrGsUSFYea5CjgVuVtDXb6oA7PBQKg8miA9SqCLFOtq3rUqzOM1HGuLz5vBKOX3
         MujGG/WadBPgLdk1JHjxtAv1mWeoeWM2zuhBlems7+zfcVUFW2LiIwLV/NtfT1i0ZAJw
         DFjtaQEdcRULGIbllpwbMVKZ2ZYWJk2ZKeHxew1QwHwse5iYENeh2dbBIo0bU8i0/cYZ
         OzkSH4r8x9vwKBboUJll2oeZoFanjDO2vzI8RQTmIjayqZWHOD2qXFEWeuYnmpmV9Ytl
         gwQ9fAD8QbJgjyuutS1PacWSrvdFaBf2r4ArB/xeBCOjXvC68pbzlJ6/hgdXAM17tMsk
         D+vg==
X-Gm-Message-State: AOJu0YxqFelBRX679V+JqOHBWg0OkyS+iNqnRID6hbUBJ7FOvoaLAF2p
	UKl5DXC2a0oHnrJ/xdkiTtpQYpibp3j0+9+b9s20MTOro3jGrPwe8r3dUuw+7zRwBhB9+eMXC4z
	ZaBHtkpptqjd5Kg6apDCFc+JH9HXQsCpiJ1oWbveiBp2xTBkXW1BrlSo=
X-Gm-Gg: ASbGnctKtX4e2ko7srHkhuwfDS9+dE4h7JZ3wdHM6CjSZUVqaddSJOoxsjg8TatXy6i
	MqvYZId0ASuG9DST+JVPkk08ggUf3HO062OwkDjK6ZPeFvPPEb5Xjy5DFEmU4tDLx5/F+lNSAAY
	PMKhOXQ1g2n/W+CymOkYd3pQIihh+I6+ft92/bJ2RTE5kGS3CyCWOaSVcxo8GXFImx3tIWOmjKd
	8rBUoiXfA==
X-Google-Smtp-Source: AGHT+IHMQDvRCofDDloJvGjiEeerEIY/Gk/pqXHt4400cKQ1iuLYdaI7mko2AdwujXEATtF9h/5fBrg4fLW3hXab0IE=
X-Received: by 2002:a05:6214:478c:b0:709:49a4:885f with SMTP id
 6a1803df08f44-70949a49a0dmr40803926d6.22.1754219628138; Sun, 03 Aug 2025
 04:13:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEHaoC2BWe+0Ps2oU-0xPDLFYYKG-o9+_ynFgh7u3qqyRDtrTg@mail.gmail.com>
 <CAEHaoC22NDpHUWovJChCx_XqchkEvUPYrFFe_L1PH9Mw2e386A@mail.gmail.com>
 <CAEHaoC2bi3VUEuoWKgHbgUFfdxmACrhkjaQ9Jni-4-ByP5tYJg@mail.gmail.com>
 <CAEHaoC3ZMvHe7D-JX9bfM9hfSPs0QV-og=om5eKFFqSL=tpjcw@mail.gmail.com>
 <CAEHaoC0Au_0yLRKSnDg=_qjnmDMmbJ=Nff+W1feEBTib0Jb_gA@mail.gmail.com> <CAEHaoC2ZQAd+h=7mKPOuMfAMex-41soD8=kx2vR_em+i71oBRw@mail.gmail.com>
In-Reply-To: <CAEHaoC2ZQAd+h=7mKPOuMfAMex-41soD8=kx2vR_em+i71oBRw@mail.gmail.com>
From: Constantine Gavrilov <cgavrilov@infinidat.com>
Date: Sun, 3 Aug 2025 14:13:37 +0300
X-Gm-Features: Ac12FXyc_haSATZmshA1lIscPRg0h10RAjFcZPKYQTbpgA8tGl5MqqjtHPhJ2Y4
Message-ID: <CAEHaoC3t8nFhR4MAYV1AaR5mjN4ndkkWrKUyBY_smbtpDykAEA@mail.gmail.com>
Subject: [PATCH 5/8] Large DMA alloc/remove max32_alloc_size field
To: linux-kernel@vger.kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

This is the sixth patch from the set of patches that enable large IOMMU
DMA registrations. Entire work is available at the master branch of the
master branch of git@github.com:cgavrilov/linux.git repo.

This patch removes max32_alloc_size field from the iova_domain structure.
This field was introduced to optimize the path of allocation failure (return
failed allocation without checking for available regions), but was not
implemented correctly, resulting in failed allocations when the space maybe
available.

commit cfdad4eb84e8c5dc7aa3f868575007de2e1fc1e4
Author: Constantine Gavrilov <cgavrilov@infinidat.com>
Date:   Tue Jul 1 10:05:11 2025 +0300

    Removed max32_alloc_size field from the iova_domain structure.

    This field exists for the purpose of optimizing a path of failed
    allocations in 32-bit DMA space, when the 32-bit range is depleted.
    There are a number of issues:

    1. max32_alloc_size is updated in __alloc_and_insert_iova_range()
       without checking the size after allocation of the range fails. This
       will cause a wrong failed small allocation after a "big" allocation
       fails.
    2. max32_alloc_size is updated in __cached_rbnode_delete_update()
       without checking the top bound of the released range and the size
       of the released range. This defeats the purpose of the intended
       "optimization".
    3. Alignment constraints and DMA  address limits are not taken into account
       when updating this field after the allocation fails. This results in
       future allocation failures that can succeed if looking for available
       ranges is not skipped.

    Rather than fixing this "optimization", remove it altogether. We shall
    not optimize for failed allocation path that is rare, and the optimizing
    affect of this feature is questionable.

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index aba58630be12..0c436dd35404 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -52,7 +52,6 @@ init_iova_domain(struct iova_domain *iovad, unsigned
long granule,
     iovad->granule = granule;
     iovad->start_pfn = start_pfn;
     iovad->dma_32bit_pfn = 1UL << (32 - iova_shift(iovad));
-    iovad->max32_alloc_size = iovad->dma_32bit_pfn;
     iovad->anchor.pfn_lo = iovad->anchor.pfn_hi = IOVA_ANCHOR;
     rb_link_node(&iovad->anchor.node, NULL, &iovad->rbroot.rb_node);
     rb_insert_color(&iovad->anchor.node, &iovad->rbroot);
@@ -88,9 +87,6 @@ __cached_rbnode_delete_update(struct iova_domain
*iovad, struct iova *free)
          free->pfn_lo >= cached_iova->pfn_lo))
         iovad->cached32_node = rb_next(&free->node);

-    if (free->pfn_lo < iovad->dma_32bit_pfn)
-        iovad->max32_alloc_size = iovad->dma_32bit_pfn;
-
     cached_iova = to_iova(iovad->cached_node);
     if (free->pfn_lo >= cached_iova->pfn_lo)
         iovad->cached_node = rb_next(&free->node);
@@ -182,9 +178,6 @@ static int __alloc_and_insert_iova_range(struct
iova_domain *iovad,

     /* Walk the tree backwards */
     spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
-    if (limit_pfn <= iovad->dma_32bit_pfn &&
-            size >= iovad->max32_alloc_size)
-        goto iova32_full;

     curr = __get_cached_rbnode(iovad, limit_pfn);
     curr_iova = to_iova(curr);
@@ -207,7 +200,6 @@ static int __alloc_and_insert_iova_range(struct
iova_domain *iovad,
             curr_iova = to_iova(curr);
             goto retry;
         }
-        iovad->max32_alloc_size = size;
         goto iova32_full;
     }

diff --git a/include/linux/iova.h b/include/linux/iova.h
index 30ce5ad499d2..2800bdc203b1 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -33,7 +33,6 @@ struct iova_domain {
     unsigned long    granule;    /* pfn granularity for this domain */
     unsigned long    start_pfn;    /* Lower limit for this domain */
     unsigned long    dma_32bit_pfn;
-    unsigned long    max32_alloc_size; /* Size of last failed allocation */
     struct iova    anchor;        /* rbtree lookup anchor */

     struct iova_rcache    *rcaches;


-- 
----------------------------------------
Constantine Gavrilov
System Architect and Platform Engineer
Infinidat
----------------------------------------

