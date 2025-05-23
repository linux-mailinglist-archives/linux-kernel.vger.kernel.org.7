Return-Path: <linux-kernel+bounces-660129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F873AC1951
	for <lists+linux-kernel@lfdr.de>; Fri, 23 May 2025 03:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 782D71C05E4B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 May 2025 01:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7198128C86A;
	Fri, 23 May 2025 01:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UlyUrYEj"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B69219A90
	for <linux-kernel@vger.kernel.org>; Fri, 23 May 2025 01:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747962074; cv=none; b=CjIetZggVtLiLYXegKI7ptGcQLYv9fJ+haxih4A9xztd8qUSoHb3Rl515YZdJ9+5tPpLRWDtK4JSSh7I8VyA48y4qUuZcL5Kc7WJBX+SyOBu/so+wrs0i0Z5BN3j975CPfxnQ234HH9YT/iWXqgXgE3gzH23sLl5a77ftHeNMrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747962074; c=relaxed/simple;
	bh=OoaKuYJuGBNrzRs4FOlcqG4EfEZ0eKgNguock8Nm660=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mYfwv3bQ7lAFtYgjzQRwFtWJhedH0QFl+MdP9HSGVX11HySheUriJ9ftXJxFoDWjYtOia4Z416G8S/cy/ckfEkjZneACxpa3ldf88qptpuU/Sqgf7MytwMLR0cM3e24aUOAfIS9khVGd45Cuh8D4Pov3cXBsBvjLoi37im3uHEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UlyUrYEj; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-310a0668968so2255193a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 May 2025 18:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747962072; x=1748566872; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=QZ/HVVcKE1D9F/RksSitv8YykybKRfr9scegH3bUh2Y=;
        b=UlyUrYEjdVZunsrh+BToNNWHq4fLxFgLdK47+ZROj1lhq4xu+f2Jh7zpXsgtSRQneM
         8VwXh5Pbas0WvMpjThAyf5tojMoxmneOk76DK98z6UlDVDPTzibZZ1yRkWeFPq8w2+0i
         LcQ+wJCmsnDmCw9AkxX71fHfK0TpJI250QJ+o5F9u6yAIeRIFl3xj0mcz6zkiPGJVdFr
         hNz2T5T7Ydi2+xI8JTqyTu9e5fCWtWn46A2US6GD8bPDvnqw9aETkRk37rLQL3hOGUIH
         n1M1iUh4l/lBJ83Rcxj67qv2YNapTTf820bhVL2nGMrWGw/vXA2xc26CF3DrouLaHuNj
         zJUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747962072; x=1748566872;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QZ/HVVcKE1D9F/RksSitv8YykybKRfr9scegH3bUh2Y=;
        b=m0JWdbY/3nVvP7HdhTIEpreFXgIVyOkz3q/2yMEdjkYVUrI7cxbHNbLhEQDf/h7Vs0
         UoBFaBYABLtqE1FYTBNuM+olQarNpM7rmmf5CiiPteduaN4X9VHxbBDsoEnCbA7C0nmc
         X9hCJ9xf1c+5LjQGnAtKL/OEs1iAtsleFRIOJvltq42UYrh5msPxzdaPYpNTLMe/o+jb
         A4e1DZZUoA8ZnvpH9C5D6RqL9Fy7H8mlUpJfZGv+wG9Nqd+8V1uMqkvPzjItnyaJ1nHM
         OtGXL78TxhW+7D+HmqKxJ/igIwC3YMjHF08Fsq1wlmyGJ8JxOGycAYuhlUFxuD4fm+ty
         HS3g==
X-Forwarded-Encrypted: i=1; AJvYcCXBOzYqbkWdur+82vX8p5QrUf+6Bt6pwPzmFqPRemh6m4RW96fubWgtoQY5Vwidr0/UX6s5dF7xl6M7xmk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcW1YraU2mAeXeCGiVDk7VEqiIZzXPk8wpy6IVR2TdFdREtvKo
	B7/2InYA1S42RvKFe/fybUTLldDuz/psjHPeA8aSZ6hQQdUaALs9glLZ4BxpoixwoU8oAr3rl9O
	izl7hLg==
X-Google-Smtp-Source: AGHT+IEivPKszStQSfYiwNpJ7/umbLGOogBna7x7mx10TTJkqWGmqjwZ44z3FVYVN+th/LcfZ1pWsae8+lg=
X-Received: from pja14.prod.google.com ([2002:a17:90b:548e:b0:2ef:d283:5089])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3b86:b0:30e:8c5d:8f8
 with SMTP id 98e67ed59e1d1-30e8c5d09b3mr44884823a91.14.1747962072336; Thu, 22
 May 2025 18:01:12 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 22 May 2025 17:59:42 -0700
In-Reply-To: <20250523010004.3240643-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250523010004.3240643-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523010004.3240643-38-seanjc@google.com>
Subject: [PATCH v2 37/59] iommu/amd: Document which IRTE fields
 amd_iommu_update_ga() can modify
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Sairaj Kodilkar <sarunkod@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	Francesco Lavra <francescolavra.fl@gmail.com>, David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Add a comment to amd_iommu_update_ga() to document what fields it can
safely modify without issuing an invalidation of the IRTE, and to explain
its role in keeping GA IRTEs up-to-date.

Per page 93 of the IOMMU spec dated Feb 2025:

  When virtual interrupts are enabled by setting MMIO Offset 0018h[GAEn] and
  IRTE[GuestMode=1], IRTE[IsRun], IRTE[Destination], and if present IRTE[GATag],
  are not cached by the IOMMU. Modifications to these fields do not require an
  invalidation of the Interrupt Remapping Table.

Link: https://lore.kernel.org/all/9b7ceea3-8c47-4383-ad9c-1a9bbdc9044a@oracle.com
Cc: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 drivers/iommu/amd/iommu.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 36749efcc781..5adc932b947e 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3986,6 +3986,18 @@ int amd_iommu_create_irq_domain(struct amd_iommu *iommu)
 	return 0;
 }
 
+/*
+ * Update the pCPU information for an IRTE that is configured to post IRQs to
+ * a vCPU, without issuing an IOMMU invalidation for the IRTE.
+ *
+ * This API is intended to be used when a vCPU is scheduled in/out (or stops
+ * running for any reason), to do a fast update of IsRun and (conditionally)
+ * Destination.
+ *
+ * Per the IOMMU spec, the Destination, IsRun, and GATag fields are not cached
+ * and thus don't require an invalidation to ensure the IOMMU consumes fresh
+ * information.
+ */
 int amd_iommu_update_ga(int cpu, bool is_run, void *data)
 {
 	struct amd_ir_data *ir_data = (struct amd_ir_data *)data;
-- 
2.49.0.1151.ga128411c76-goog


