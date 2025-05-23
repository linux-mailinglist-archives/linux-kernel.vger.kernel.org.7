Return-Path: <linux-kernel+bounces-660096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26414AC1911
	for <lists+linux-kernel@lfdr.de>; Fri, 23 May 2025 03:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B93804E83FA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 May 2025 01:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD05212B2B;
	Fri, 23 May 2025 01:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ciLt02Hg"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963AD204C0F
	for <linux-kernel@vger.kernel.org>; Fri, 23 May 2025 01:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747962023; cv=none; b=YvheuGLuxQG2i5UxaVJVRYfPRFnLxqJkJa/V0JL1jZSDljCDTEwM0xwf9uX732+9H6DrjYVJqadKdvM5GuHtJZFiiq7wu3VK1Ft4qHwRh6HcToJmHNAI4bb4ce8JzHEg1j7rAzbJBKL4Xm9/6BEKW5YSULK58yubUJXrO4iuRrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747962023; c=relaxed/simple;
	bh=xtpaD7HVsJFlh7tiOLocGEu9Ud8v7ZkKhAZvNZl2KIA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VdMgme7CbetWiOvQ5mlO4b/WTq4qhmpLPPTnrQbosB4S2KmmHZN0BUTJZmN6hOn4kf4eKSer3VZndMOF2Z2duKegT7byCcKwc0fAyA041W7gh0zyhs08wCOdk/+0PALw1cFYXw0tUH8a0a2JElNVVWMB21dQ9nRKLB9iPe5rNjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ciLt02Hg; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-73dcce02a5cso5495074b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 May 2025 18:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747962019; x=1748566819; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Y8ehtQMuf6IARUqP5Cyf64+dJov4SLh6VlRU3VKIIQ8=;
        b=ciLt02HgPiHJRw6qX2Apjld6eBoa5n3mYLT5FRj3un8UEcUV3X1Rckh74XtHUc+A+4
         3vPUZH9LffAtwjwHXNnb1ICph2p3uFPsZhKcwD83OkKJwQlPdBMvA9zkYKBKss80nJvN
         QJDlZUsmyuEEqwXhvT02pU4+BdIHAAu2nf+iamghw8+13crn5qen+a7gWtP7DSqME4/m
         zerJZUSGx4F89rL3EO2zvBYryL7Penu9aOUFDz5s90MK/kRngKXtvt26a+FMVEYerDwD
         VIsVQXKoFQPKouPBWRB0piPMR/5ualHJwWDq/zeO1Ye4DQU1WDN9oulWHFWc4xfR7Gn5
         Bdng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747962019; x=1748566819;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y8ehtQMuf6IARUqP5Cyf64+dJov4SLh6VlRU3VKIIQ8=;
        b=VJsqWs/vikkeCvOMchSiut4n7Zv1MzktYj6YcEDUZnr81CNuLPvHbJv79QKNChJIJm
         e9ngrm7VEiKqT5f9XtI+XGsdTF56NtGYmC2RmN4bgP8Pfm3tj6qOpbbjby6IujN2+1aw
         sEix1wMyR2Qq7nSMiw11CXjdYyiTKVXIqtwMUJH7wmO5e35C8MQKNwQjwNl4v3M5F5ep
         fMuJ1DItx79isoaNqd14IL/P5tqB56DqT2NPmW7tgUSOb2gg2arikcwHocvmhh6u2aJm
         QUiA3x/u/u6zALhI9cb8leNHRm68KAaYF9K7Vb8jkCVwxz58P7dg/nfAAjiOxds+n0Kk
         pL/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWg6phmxSeDycelTua/a+lV9+I1JooZh5odR8pauXOqR4twa5Jlp7gp/sTHS+gGN0KTnvgVYBKGG+tIe2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ2JcCTK2K22/kTHeGIAxx0/1b4XiFn78pEeDLA5Xmk/TGrfD6
	29CjXM/gS99qw6kXlgiP5WNU2OMX8cm4dz8Cb/eL1f0rC9nuiWcFn2NSo5qgf7XHpr7tjgDPQhu
	IiouIig==
X-Google-Smtp-Source: AGHT+IEHm61pElXc5o66L35Mfu9cWxQa9x3UMSXO1VOYhFDjyuiVflcnZ6ZC6JzEj6wH5WWXGFCHISdtxs8=
X-Received: from pfoi12.prod.google.com ([2002:aa7:87cc:0:b0:73e:665:360])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:9144:b0:736:4d05:2e2e
 with SMTP id d2e1a72fcca58-742accc2342mr33071193b3a.6.1747962018848; Thu, 22
 May 2025 18:00:18 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 22 May 2025 17:59:10 -0700
In-Reply-To: <20250523010004.3240643-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250523010004.3240643-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523010004.3240643-6-seanjc@google.com>
Subject: [PATCH v2 05/59] KVM: SVM: Delete IRTE link from previous vCPU
 irrespective of new routing
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
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
2.49.0.1151.ga128411c76-goog


