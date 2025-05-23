Return-Path: <linux-kernel+bounces-660120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA94AC1942
	for <lists+linux-kernel@lfdr.de>; Fri, 23 May 2025 03:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97B22507CD6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 May 2025 01:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C983A27EC99;
	Fri, 23 May 2025 01:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GHgTEVAM"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4957227C150
	for <linux-kernel@vger.kernel.org>; Fri, 23 May 2025 01:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747962059; cv=none; b=rgGK6Gx9zHYnBza3JKAyGgvi7+b87awDhocW7nCub7pCHTjV/0LJQWbHVlhjuQKdi8j5HaJBk4QwKs2FdI7YzlnYCYskvvxYTkoRLGYHky3kGnQs3wXACfy0bsx2wh3W8yOjnHfkaz3WIrKtAgSl/FypPRjMXP5hgaRpyH1PnkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747962059; c=relaxed/simple;
	bh=3cDGPT4Fs5i3llYV6N7Z3zsG/IoHE6e+aDJIWGzC/ns=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Y5BaLfT319kTvZhABYbw6ToDLwzW8cYichJYILYessVmpbzfrUN3dAS6ThDWGnsX3dfZ+n8iZLmxPzfQjsqZ/9SgPPXrzAYTzUj+vnwo5DZQKk4A/RGAQlBAVLLZvd9qkRo1iCcEDcpShkLsERVYjELSPWTCqGd/526uRy63WnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GHgTEVAM; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-30e9338430eso5418587a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 May 2025 18:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747962058; x=1748566858; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=MOfqSC9jfe6qWef3o61heciDY2fzEzj3IP2K1ebfjaE=;
        b=GHgTEVAMsrItmgcDbmKrSJIfspAIPbHjwIVE+ljyk9XT4NjS4vXL9XbtTs8a2rr8L5
         qFSj/CkeTc0Q/1to1zKw4Q/VXgBL//4oGeGGrCuKuNmTURX8lH2sFvBjkr4735MeR/6y
         5B493PWkshZtLU4l65RQWvCeMSDvzicVuJkT95qKAWaUv0oMRTEkocdFFYb5YItwj6kL
         aeDUftnMppskgr3RrohQiFCA+f5Vol8/PiaV/+Jgb7Uc9p+pScihlvLOf0pDyHpwXnpO
         CS/Qel1bq1GBaWa7cAQhDgblOlpB0PCEe+vSiO/aQMcdvBNxv3r3GM07zFtTiibpWPSr
         453A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747962058; x=1748566858;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MOfqSC9jfe6qWef3o61heciDY2fzEzj3IP2K1ebfjaE=;
        b=ECQmZmRpJRCzomORxikrDO2wBELEs9nzAs1SfVDuirT9mJydRsYD+tMfGu+cG9GE1Y
         FaAcKg/MotdxkSC4JKtwpaqsY8jMcDyBxPldCxRxQlB8YK9iEkWuNxHdSyk4xDWoStAI
         4zursUl5HlFMQre4yAnbGXHB8RFgeThON/c2g4gPBVsCE2YZBOMz8NC1NAiJU9acIW0u
         tGvNW+tYcll8PdPcLVBL+ZOS09wnIGmPoMqEftBKzik1DoQfv7l6IbifNdDiIX51O/yD
         zarN+LL7R1b5AIYv9xM4dRE/L7bcntTOfM1IIP16yS/bM46ehYXD1eYO/MAVMxr3rNMf
         9gpA==
X-Forwarded-Encrypted: i=1; AJvYcCUsJm4PhfQ1ZvEc61/0VQhQk92OVjivi6szVwCnv7U97yL31CbrmqzBdHJ3HisB97BoUH9cC7wMBs4NYyA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx7SvBlz2zAFsSQ7iNm1j6FqDe0zAAA0AhKyICiR801ntsj1oE
	z7fwANG05aj8xEBSfpwyvvRAdKiSHhk8eIjI6CMADWygnuzv9RWgkYNH+vWRgxB28pVQQ6Krbly
	8ESmhoQ==
X-Google-Smtp-Source: AGHT+IGbnIYZKIV7+UM33kPe0GOe3t9BK31wvtSS50odFLwVDGUrD18GfGcmK5AWEuZ0hAkPUYG529hmiGs=
X-Received: from pja13.prod.google.com ([2002:a17:90b:548d:b0:2ef:786a:1835])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3b86:b0:30e:8c5d:8f8
 with SMTP id 98e67ed59e1d1-30e8c5d09b3mr44883074a91.14.1747962057767; Thu, 22
 May 2025 18:00:57 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 22 May 2025 17:59:33 -0700
In-Reply-To: <20250523010004.3240643-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250523010004.3240643-1-seanjc@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250523010004.3240643-29-seanjc@google.com>
Subject: [PATCH v2 28/59] KVM: SVM: Clean up return handling in avic_pi_update_irte()
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Sairaj Kodilkar <sarunkod@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	Francesco Lavra <francescolavra.fl@gmail.com>, David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

Clean up the return paths for avic_pi_update_irte() now that the
refactoring dust has settled.

Opportunistically drop the pr_err() on IRTE update failures.  Logging that
a failure occurred without _any_ context is quite useless.

Tested-by: Sairaj Kodilkar <sarunkod@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/avic.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index d8d50b8f14bb..a0f3cdd2ea3f 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -807,8 +807,6 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 			unsigned int host_irq, uint32_t guest_irq,
 			struct kvm_vcpu *vcpu, u32 vector)
 {
-	int ret = 0;
-
 	/*
 	 * If the IRQ was affined to a different vCPU, remove the IRTE metadata
 	 * from the *previous* vCPU's list.
@@ -838,8 +836,11 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 			.is_guest_mode = true,
 			.vcpu_data = &vcpu_info,
 		};
+		int ret;
 
 		ret = irq_set_vcpu_affinity(host_irq, &pi);
+		if (ret)
+			return ret;
 
 		/**
 		 * Here, we successfully setting up vcpu affinity in
@@ -848,20 +849,9 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
 		 * we can reference to them directly when we update vcpu
 		 * scheduling information in IOMMU irte.
 		 */
-		if (!ret)
-			ret = svm_ir_list_add(to_svm(vcpu), irqfd, &pi);
-	} else {
-		ret = irq_set_vcpu_affinity(host_irq, NULL);
+		return svm_ir_list_add(to_svm(vcpu), irqfd, &pi);
 	}
-
-	if (ret < 0) {
-		pr_err("%s: failed to update PI IRTE\n", __func__);
-		goto out;
-	}
-
-	ret = 0;
-out:
-	return ret;
+	return irq_set_vcpu_affinity(host_irq, NULL);
 }
 
 static inline int
-- 
2.49.0.1151.ga128411c76-goog


