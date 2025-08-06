Return-Path: <linux-kernel+bounces-758259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F26AB1CCFF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 22:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8437C7ADAA7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 20:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3DFC2DAFCB;
	Wed,  6 Aug 2025 19:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZuuBuR/K"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423702D978D
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 19:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754510307; cv=none; b=Y6gvZLn40phrVJfBDNmsoUahovkgtOfDca/soFEioL91UhtRMQg5E3BAkJ0Qg+Rue1qhWtHVA3UjUlyQZKgT5rfpMjfMlukHMqGZXxniI5yT12uS8NzZIdS0uzLnzZzRA1AJyvOFkJ5kCvGxVWNO8UZY02j5LQ+x3ZjTktpZDok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754510307; c=relaxed/simple;
	bh=zkHffgBonSYg4vE9BMzEVoQYPuGz4X+vSu1d1oyeTYE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kbxJMMN8kDUK4bXs+XZU3EnJNJSpi1v4KxXCE+JPuV1/HNRCuoV/dxoM3uaaFggswUSlp0mxrxx0RBVr0pJEZ297kESU6fm0OwePe8Fb20KHWm7Pp+ZjqMLZLHqW/qM8bnlkdBZxvemJjSCREyoIoFp7n3V+3T24NHQfgOpGlQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZuuBuR/K; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b42218e4a59so128085a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 12:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754510302; x=1755115102; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Jn8S/sdm+8bvzWJ6gbgYYHL6yp6bRqDxs3iW0RSe7uI=;
        b=ZuuBuR/K9xLC5JhgTwjiE14avrAtBxH2Jk+Y4+23C5SI0c/HDEI33Rw6jKG0UcP2Gy
         WQ7o9+WXKlH4pC5mgzr6AKEC90AswOTgV0qqIYA7dIG9GvNC04WJwb45a29LOcJ0MoC6
         APNDsgpnxRW3Imh86119UgQEOiEJicwW38+2619PXt8+LQgJ0qmhclk6UZ4ryF33Rihk
         SEi9d4DTrZyo0m0ImmsCRn2yU0cySAoFnzaelaPns6QIkc3GEgmKaI3wVITdTlc7PGGk
         066/lq9DYjtH5GDoQffWkphn/cX3tlAlhid4fs+W4g889WZxBIAltcyR7xtyFFqYhH6U
         cgZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754510302; x=1755115102;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jn8S/sdm+8bvzWJ6gbgYYHL6yp6bRqDxs3iW0RSe7uI=;
        b=k1YL8qdAiC25XbNCCS0SjOCKTr/7GFujIBxtoMmVgk6VAPOf2LWPWJGc3cpwY/xlLa
         Fpo8VSZprPPpjQU87BkwROSvpnbmLHY8rwVCqWaTjAaDCFeNnbt7o5Ddo5DVwnPAnu8+
         GllAqr6iEMSICREnA/BEaiV4aFMXE31sKSuVjmMNf74s/WT2blLOVo9BbdzjGp3mg3QW
         /cve1caodCkH4xcxJ32t4SQvEimT1Omc/Ht7GxT2wvaRKZIERxHD51nZ7zPkGfEF+Wbv
         9eUbGInaAg35vknHb720WZKQKzKeaYftuuKBuPOKgEtWohJWcu2Zv4Jvdc16cGJqD9Ax
         O86Q==
X-Forwarded-Encrypted: i=1; AJvYcCVBgitIzPioJ9U8l5IKtgrSBqn6PGT+/F8+GPekEELQhXO9+JYHY3IcI/x2wcv8V1TT/d0YZTPFXgq4zio=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx89DaD4ylWFhH35jboav4W6CtkMlHDcg+ZzuDSt0PZZrqVrigT
	z1CDAyjWdggmrXFA/eRyiCyFxO6OKDEE1PNjoRc8bPFOYWthKrPG0IqjqDHI1MY62PNVJ1yFPw1
	2MrSHLA==
X-Google-Smtp-Source: AGHT+IFo65jEdjZGUxY/vUUE9hB8u0/Ehm65nxno4lYpqINC12VaTwhwaABlYMWVK9zS/nrWWsDoA8ThjT4=
X-Received: from plha17.prod.google.com ([2002:a17:902:ecd1:b0:23f:d0e0:7e93])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2cf:b0:240:71ad:a454
 with SMTP id d9443c01a7336-2429f2d9e92mr70108355ad.1.1754510302251; Wed, 06
 Aug 2025 12:58:22 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  6 Aug 2025 12:56:51 -0700
In-Reply-To: <20250806195706.1650976-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250806195706.1650976-1-seanjc@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250806195706.1650976-30-seanjc@google.com>
Subject: [PATCH v5 29/44] KVM: x86/pmu: Use BIT_ULL() instead of open coded equivalents
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

From: Dapeng Mi <dapeng1.mi@linux.intel.com>

Replace a variety of "1ull << N" and "(u64)1 << N" snippets with BIT_ULL()
in the PMU code.

No functional change intended.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
[sean: split to separate patch, write changelog]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/pmu.c       |  4 ++--
 arch/x86/kvm/vmx/pmu_intel.c | 15 ++++++---------
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kvm/svm/pmu.c b/arch/x86/kvm/svm/pmu.c
index 96be2c3e0d65..b777c3743304 100644
--- a/arch/x86/kvm/svm/pmu.c
+++ b/arch/x86/kvm/svm/pmu.c
@@ -199,11 +199,11 @@ static void amd_pmu_refresh(struct kvm_vcpu *vcpu)
 					 kvm_pmu_cap.num_counters_gp);
 
 	if (pmu->version > 1) {
-		pmu->global_ctrl_rsvd = ~((1ull << pmu->nr_arch_gp_counters) - 1);
+		pmu->global_ctrl_rsvd = ~(BIT_ULL(pmu->nr_arch_gp_counters) - 1);
 		pmu->global_status_rsvd = pmu->global_ctrl_rsvd;
 	}
 
-	pmu->counter_bitmask[KVM_PMC_GP] = ((u64)1 << 48) - 1;
+	pmu->counter_bitmask[KVM_PMC_GP] = BIT_ULL(48) - 1;
 	pmu->reserved_bits = 0xfffffff000280000ull;
 	pmu->raw_event_mask = AMD64_RAW_EVENT_MASK;
 	/* not applicable to AMD; but clean them to prevent any fall out */
diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
index 98f7b45ea391..6352d029298c 100644
--- a/arch/x86/kvm/vmx/pmu_intel.c
+++ b/arch/x86/kvm/vmx/pmu_intel.c
@@ -536,11 +536,10 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 					 kvm_pmu_cap.num_counters_gp);
 	eax.split.bit_width = min_t(int, eax.split.bit_width,
 				    kvm_pmu_cap.bit_width_gp);
-	pmu->counter_bitmask[KVM_PMC_GP] = ((u64)1 << eax.split.bit_width) - 1;
+	pmu->counter_bitmask[KVM_PMC_GP] = BIT_ULL(eax.split.bit_width) - 1;
 	eax.split.mask_length = min_t(int, eax.split.mask_length,
 				      kvm_pmu_cap.events_mask_len);
-	pmu->available_event_types = ~entry->ebx &
-					((1ull << eax.split.mask_length) - 1);
+	pmu->available_event_types = ~entry->ebx & (BIT_ULL(eax.split.mask_length) - 1);
 
 	if (pmu->version == 1) {
 		pmu->nr_arch_fixed_counters = 0;
@@ -549,16 +548,15 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 						    kvm_pmu_cap.num_counters_fixed);
 		edx.split.bit_width_fixed = min_t(int, edx.split.bit_width_fixed,
 						  kvm_pmu_cap.bit_width_fixed);
-		pmu->counter_bitmask[KVM_PMC_FIXED] =
-			((u64)1 << edx.split.bit_width_fixed) - 1;
+		pmu->counter_bitmask[KVM_PMC_FIXED] = BIT_ULL(edx.split.bit_width_fixed) - 1;
 	}
 
 	intel_pmu_enable_fixed_counter_bits(pmu, INTEL_FIXED_0_KERNEL |
 						 INTEL_FIXED_0_USER |
 						 INTEL_FIXED_0_ENABLE_PMI);
 
-	counter_rsvd = ~(((1ull << pmu->nr_arch_gp_counters) - 1) |
-		(((1ull << pmu->nr_arch_fixed_counters) - 1) << KVM_FIXED_PMC_BASE_IDX));
+	counter_rsvd = ~((BIT_ULL(pmu->nr_arch_gp_counters) - 1) |
+			 ((BIT_ULL(pmu->nr_arch_fixed_counters) - 1) << KVM_FIXED_PMC_BASE_IDX));
 	pmu->global_ctrl_rsvd = counter_rsvd;
 
 	/*
@@ -603,8 +601,7 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
 			pmu->pebs_data_cfg_rsvd = ~0xff00000full;
 			intel_pmu_enable_fixed_counter_bits(pmu, ICL_FIXED_0_ADAPTIVE);
 		} else {
-			pmu->pebs_enable_rsvd =
-				~((1ull << pmu->nr_arch_gp_counters) - 1);
+			pmu->pebs_enable_rsvd = ~(BIT_ULL(pmu->nr_arch_gp_counters) - 1);
 		}
 	}
 }
-- 
2.50.1.565.gc32cd1483b-goog


