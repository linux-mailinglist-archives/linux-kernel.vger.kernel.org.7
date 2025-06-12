Return-Path: <linux-kernel+bounces-682652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35791AD630E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jun 2025 00:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6076F1BC4792
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 22:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49EC026057B;
	Wed, 11 Jun 2025 22:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pi2VYJ5W"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE4425DD05
	for <linux-kernel@vger.kernel.org>; Wed, 11 Jun 2025 22:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749682030; cv=none; b=t1gUytusUs3k2s1YSg6rtE9TOxs3ET2k8VnnUSdY9LbQA9V1jQY17gSYZA8LHHokzf2xO2gvZRsaJSDsnx5Vdn/ltRhbOYVe/W2bH3/WSdHOYvDKSM+X8s8OyIOgqBLncXSXnxA7gg+0lO3hUCEHuQD2IcZzHq/8IOEsLVrqMew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749682030; c=relaxed/simple;
	bh=veIQi8e0iCtzXQM8NcdDzO8ccwAXQEovrCAVSPv1kJ4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ya/CQT7vU3RDuqVkjZnHZR2az6EeRqJlkuZIiE9JJyiUxXSintvJ8PqxES+h8HzxBThRVRWjZBl9Mqv0Dy/uXDeI27xn9EpwzHYAATiOL45ShTNym4w3W8juknRbCg/5c2OxzC6Gwl7S2NZyKoCSGlo3Yf1pGCphigxhmK8ykhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Pi2VYJ5W; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-747ddba7c90so265232b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jun 2025 15:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749682028; x=1750286828; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=tDZohEtmrHKYD6EovcSC8/ZzfIWWO2Pel/+WswkGVp8=;
        b=Pi2VYJ5W9n5OOGnU0KlvTDsPZ5rNyJN2cw5CKIHSMAhC5stobddUEW2/k/BygJhaXW
         WE/YdnJgVs1zGFemZkGg5vW2jNZQk2M2a0lL0m1mlKDYqiCSceC64XFQWZualjSzd5x6
         3k09b3pm+tTPi7WkKcPrBuF8fAecG+iIruriGqYROJpRVF3t6+1qM2WQvp8Gc9Gy1axc
         mG5O75tVHaCP437YgnG/XJhVMUr4bqpV0vNAGmWxYH7SMC/T/qSyNx8VTrhTy+wGwUCP
         nkRMb3U/mMCwF3z3GKKw9l9jYIqX9Txt8pyFrY3dRnCuRigBn/GqZSjOdHRKOMI8mh89
         YoBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749682028; x=1750286828;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tDZohEtmrHKYD6EovcSC8/ZzfIWWO2Pel/+WswkGVp8=;
        b=eCIST/Ybcnx1dH0i2GTTHPHVgE10rfe0LTL9cLu/M6FEZVSXZyGP/yiKnU7vgFj5FX
         UNTba3EBwlcKj3XldrA1x31tEK06nRBUzZ0vW4RzpMROD/IuF53J60ctdO22+4Kak0Y4
         cRZofAbfQyYLZaBeHrZRHuW419wjyoGe4EshNGFsbd7ncgMaHJHygFAJSjTEl3SJogin
         ffuIDJmcXAht4Vq580pU9GxGNqdWEwksrC85Q00xcGxMzxlFi0ww7jTODz4zF2NxUyZP
         Oah8HFxHxzh5IRdpPFIc0h8wB87wH/Ewb6zSuQZ88Bxgsuz+3PXVHWNtI3M8StYTrlU/
         KaVA==
X-Forwarded-Encrypted: i=1; AJvYcCXp9jk1+uivmtGdIZOgFZPbEw2qVvA9a5WT67xrer1lSDFlJ6D5yt3rBp8ml/Jajg4kLURoeGEWFGXIpFc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx5WPCkaTTHkBHrII0g2BFphP79sIFuyJ+AYuDvI7T2e0cbCYf
	vYGWtsmpcX/A1wLhOS14EHnHshOpLYE3KdQV/x07wO316kjCA1AAhxS31rOA+iTJwNp9IuxKmaE
	g54J39Q==
X-Google-Smtp-Source: AGHT+IHgXSfJU2sxyG9OW4VojMH2BSFfhS8bYIS64Jcg4Y6OGr2dvtrGuU93NG67KzexoKMXwohALrIyyio=
X-Received: from pfic6.prod.google.com ([2002:a62:e806:0:b0:746:2117:6f55])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2294:b0:742:a111:ee6f
 with SMTP id d2e1a72fcca58-7487c21ba8bmr1432295b3a.10.1749682028151; Wed, 11
 Jun 2025 15:47:08 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 11 Jun 2025 15:45:10 -0700
In-Reply-To: <20250611224604.313496-2-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250611224604.313496-2-seanjc@google.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250611224604.313496-9-seanjc@google.com>
Subject: [PATCH v3 07/62] KVM: SVM: Delete IRTE link from previous vCPU
 irrespective of new routing
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, Joerg Roedel <joro@8bytes.org>, 
	David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Sairaj Kodilkar <sarunkod@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	Francesco Lavra <francescolavra.fl@gmail.com>, David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Delete the IRTE link from the previous vCPU irrespective of the new
routing state, i.e. even if the IRTE won't be configured to post IRQs to a
vCPU.  Whether or not the new route is postable as no bearing on the *old*
route.  Failure to delete the link can result in KVM incorrectly updating
the IRTE, e.g. if the "old" vCPU is scheduled in/out.

Fixes: 411b44ba80ab ("svm: Implements update_pi_irte hook to setup posted interrupt")
Tested-by: Sairaj Kodilkar <sarunkod@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 4e8380d2f017..c981ce764b45 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -861,6 +861,12 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 	if (!kvm_arch_has_assigned_device(kvm) || !kvm_arch_has_irq_bypass())
 		return 0;
 
+	/*
+	 * If the IRQ was affined to a different vCPU, remove the IRTE metadata
+	 * from the *previous* vCPU's list.
+	 */
+	svm_ir_list_del(irqfd);
+
 	pr_debug("SVM: %s: host_irq=%#x, guest_irq=%#x, set=%#x\n",
 		 __func__, host_irq, guest_irq, set);
 
@@ -883,8 +889,6 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 
 		WARN_ON_ONCE(new && memcmp(e, new, sizeof(*new)));
 
-		svm_ir_list_del(irqfd);
-
 		/**
 		 * Here, we setup with legacy mode in the following cases:
 		 * 1. When cannot target interrupt to a specific vcpu.
-- 
2.50.0.rc1.591.g9c95f17f64-goog


