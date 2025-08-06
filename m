Return-Path: <linux-kernel+bounces-758262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B44BAB1CD03
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 22:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD50616DE35
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 20:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508D52DC34C;
	Wed,  6 Aug 2025 19:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UZQ82rAB"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51F02D9ED1
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 19:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754510309; cv=none; b=IArXL1WQhauSUc2ifOqd0kAq5KQQd+o3Xs8hqMSnZ9TubH6HdROyL4t1Vj5BMtVWuXxa1as7LwCwMImMfOZYf27GAo2hPz8Kq5uMjS6DXysq2b2Nibcvj2dIcJssGz1AmFaYt/ZCoI51H7YRmuAVu9lVHYiPcV0XIznHsV6DtbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754510309; c=relaxed/simple;
	bh=ukS/hePPonycrg9r313f+paqDEVzP34VnPUrCOh2p4I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bYXpP/uHmXTV59ZgSjoVIIDfqGAulx4ezz5j0rBYO9T4yam8VPnhkPYBi7fqHHg/X5nsSYb7SHOtgL/L2a55nJNdsOxY089LTilD4uCpB8zAzCLijIckoSlpSfEf3APIogmebmXMpoohF/Tt1dCRVN+SdZihQOLf0xWs3BBGKu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UZQ82rAB; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-76bcf2cac36so317096b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 12:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754510304; x=1755115104; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=aHvZdAUvNaaZFmbhTqFilDj1JXSRU8dLYlLgEZc/oCw=;
        b=UZQ82rAB1aW4wkzuRy+h0nrLTn6mywb7qRTYMXVmXs0Lw14scF1TgenREk4buW9P7V
         3BI8YRbSMnxk5iu0066XjcYPmnapZifV6BOxUrPm12WCvJj9BgtzRkOKBYhj5BntbB9l
         RktHo5YDSGZYH4+LCxJ2Lv6TPm93RblA9g87h+W+gm4LMgGVMght3Y1CRYT/QZCkQQ5g
         HUogfMR/aqU0KuUg7rw/F7csjvHk/JXJ47/7FFFu9XTsy8L4XvQ2sqBK7VdJWgOjwOqa
         eZMuKAZybT0ET+ZRXf+8ZJ8oCDX+wm+fyRa5jm+pyuYsT+AMTDq7DPP5sES4cDpFiUfz
         1+mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754510304; x=1755115104;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aHvZdAUvNaaZFmbhTqFilDj1JXSRU8dLYlLgEZc/oCw=;
        b=PU+cmxdGV2gN6ljixIgOzYO4ki2UmuxC6f7yV/BwSLz3p+VoiR93RKTciqZJByYpkb
         9snQ/f+KDyOqq9rUqTV8RcYEhVxfUg/J6xy1VRg5kNTV0CFy1dc2bvKmbWWNJO2nLb3G
         NODlf8zAFY4lwVZhZdNasF0cW9Y/fbKgLgEV4jLSn2boZvD9XuGDpgxGogfcpcJ9Aipq
         gtWxm4+ZR8/6J3h+HZ0rJtj1ZEyk4YHroQ9P/G4i3BfxezsYdrrof8IT0axJD9f+Dmxx
         ajIieFl1cWQQ7fLbDQWxt6fuiNSDOeYfNcKTtIa4ADjFvHAWfNvkmPZoJ+NjcEQkx+IG
         eIrg==
X-Forwarded-Encrypted: i=1; AJvYcCXPUhwuC7BThlwcB1ODvGSCfrf9vr5wlo/M8kws6B8jxtGICw+WtXop/HFkC+JRMzJr/zIZ3W6LbKyhzQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlKah/sE0thavT+reNxp/9Xu24m2vMTuqxdDRC6/iLWYO5YyHR
	Ra+66IsYataXWndkR3PRSNIuRL05/qlWtKhBGU7/Yrwrt0zPLC4F1Ow8FSc/PVX/Mso3nqkQP0t
	GuwXUUw==
X-Google-Smtp-Source: AGHT+IGfcxFcqE+WO40f0G1jJJ785vOiC3NUhX/6TGZEyq4CvV1J0auJAX6NhvanreP79iKSuzsragVBkJw=
X-Received: from pfvf15.prod.google.com ([2002:a05:6a00:1acf:b0:746:3162:8be1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:999f:b0:220:78b9:f849
 with SMTP id adf61e73a8af0-240331272admr5902393637.24.1754510303927; Wed, 06
 Aug 2025 12:58:23 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  6 Aug 2025 12:56:52 -0700
In-Reply-To: <20250806195706.1650976-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250806195706.1650976-1-seanjc@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250806195706.1650976-31-seanjc@google.com>
Subject: [PATCH v5 30/44] KVM: x86/pmu: Move initialization of valid PMCs
 bitmask to common x86
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Xin Li <xin@zytor.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, loongarch@lists.linux.dev, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Kan Liang <kan.liang@linux.intel.com>, 
	Yongwei Ma <yongwei.ma@intel.com>, Mingwei Zhang <mizhang@google.com>, 
	Xiong Zhang <xiong.y.zhang@linux.intel.com>, Sandipan Das <sandipan.das@amd.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

Move all initialization of all_valid_pmc_idx to common code, as the logic
is 100% common to Intel and AMD, and KVM heavily relies on Intel and AMD
having the same semantics.  E.g. the fact that AMD doesn't support fixed
counters doesn't allow KVM to use all_valid_pmc_idx[63:32] for other
purposes.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/pmu.c           | 4 ++++
 arch/x86/kvm/svm/pmu.c       | 1 -
 arch/x86/kvm/vmx/pmu_intel.c | 5 -----
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index a4fe0e76df79..4246e1d2cfcc 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -932,6 +932,10 @@ void kvm_pmu_refresh(struct kvm_vcpu *vcpu)
 		if (kvm_vcpu_has_mediated_pmu(vcpu))
 			kvm_pmu_call(write_global_ctrl)(pmu->global_ctrl);
 	}
+
+	bitmap_set(pmu->all_valid_pmc_idx, 0, pmu->nr_arch_gp_counters);
+	bitmap_set(pmu->all_valid_pmc_idx, KVM_FIXED_PMC_BASE_IDX,
+		   pmu->nr_arch_fixed_counters);
 }
 
 void kvm_pmu_init(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
index b777c3743304..9ffd44a5d474 100644
--- a/arch/x86/kvm/svm/pmu.c
+++ b/arch/x86/kvm/svm/pmu.c
@@ -209,7 +209,6 @@ static void amd_pmu_refresh(struct kvm_vcpu *vcpu)
 	/* not applicable to AMD; but clean them to prevent any fall out */
 	pmu->counter_bitmask[KVM_PMC_FIXED] = 0;
 	pmu->nr_arch_fixed_counters = 0;
-	bitmap_set(pmu->all_valid_pmc_idx, 0, pmu->nr_arch_gp_counters);
 }
 
 static void amd_pmu_init(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 6352d029298c..1de94a39ca18 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -579,11 +579,6 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 		pmu->raw_event_mask |= (HSW_IN_TX|HSW_IN_TX_CHECKPOINTED);
 	}
 
-	bitmap_set(pmu->all_valid_pmc_idx,
-		0, pmu->nr_arch_gp_counters);
-	bitmap_set(pmu->all_valid_pmc_idx,
-		INTEL_PMC_MAX_GENERIC, pmu->nr_arch_fixed_counters);
-
 	perf_capabilities = vcpu_get_perf_capabilities(vcpu);
 	if (intel_pmu_lbr_is_compatible(vcpu) &&
 	    (perf_capabilities & PERF_CAP_LBR_FMT))
-- 
2.50.1.565.gc32cd1483b-goog


