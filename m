Return-Path: <linux-kernel+bounces-823829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02FCFB87881
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 02:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95E3B7C0D53
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 00:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F481258ED1;
	Fri, 19 Sep 2025 00:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HqA7K8aD"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0BE231845
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 00:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758242723; cv=none; b=rND+Pv11gCTN3tNfMuRcQ2k4tUyVhwmZYuQHeXrSqhbmpSOaBXHZp75bKccEwTh+83WR8ows13trJv9qMCYE1yVhqg6twk7QmaxVi+OSUgY5adg0tzqVbnNRcp8uy9+WJ+zFRUGDxroZ5xcvhCFf7WtJN4xVMERs/oV7XVETgIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758242723; c=relaxed/simple;
	bh=y/seMVy+n2WKrkuRdFkuPjRdrwjTyV6rxc7KmBNyaEc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=N0yDf18Qc/98JQWu4Lm7ct8q/bzBKK3kjMCJQH1/DEuAisnnSEJxrySKYQaaB5b1BpL1SLkNz+HN75KRgqSsgIt43ArRoWwOFRfb9W+rFf+LnwWZntS4Y6oqK98zZ2ASS9984F5ypYEnmq447Jv44rivt2qmU0IBtxGLxJd+G5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HqA7K8aD; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32ecab3865dso2106593a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 17:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758242721; x=1758847521; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=8XWRINSrfIHcCfIWgI9zyBD2U4gnpJ5y2a7/S7VF5Jc=;
        b=HqA7K8aDCuCDuIc5Hqn0PvTcF63u7dl7zHYy9PGcekkdgle6B1JeZTPR3E3JG0tzgm
         Il8UHSdZPCmVJzF97B/OH79wp1a9Fk6b8vIdE5i7mDcyHQOlyEpyFpk1oDjRr4Lg0844
         uwzISz0Ij4Cults8VpbcVwtlHaDKyFjcapekKX+HvasQmW/n6mTeU35/jDgfJa770cwS
         y+VRleKW3njkK/sWILD+i0oKhZRfzrXcOxNphZRIXKYlLyBZpwBmysl2t+DUAl3Dcjb+
         QMxhOW7rq0fW7gbg3eEtPAx4+yGQbdqf+V339SCiARZlqNRsn1f6bvjjmPVMS2J+gbyH
         N/bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758242721; x=1758847521;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8XWRINSrfIHcCfIWgI9zyBD2U4gnpJ5y2a7/S7VF5Jc=;
        b=RNbBrTqh8zrH/Z8Dv/X2RMM3TnRvurNYiCDL9JkhoJcakKxpybkLMhOnNxDu+Aqrmm
         vm6SOLLcNita3LQpH8ICp8DIGDHOxoTp2lhdbqEY8gQK/ruWvkckePEKGnJ4ORHqH/WM
         tC5l4RX4Mq/KvIzRGfEKBDDyVY/fqdyBLCPa8sU6kYFJy9Mx5SNDstG5cCC1tXE3Blvs
         WJVm1KW/6vkkVxBh65+NmZ3mHzRoveR29FEy/4vCzLdxLacRO72uQ75gmhmjV2nwyCyG
         uCTcspY9ZU3xIZ0/NyKQFckf9cMBSAjNuEWiMc/UCpe76sbRbQWd2Eu/KmlfMMKy/20S
         iY2w==
X-Forwarded-Encrypted: i=1; AJvYcCUdGFs+SvPrSnaHNSRKCHGZkF5T3hhJws97Mw4ZappTxgwZhCp/jM+x2FzsgdZ+Ulwzyzb1YMToLQYuPwo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+h7Vsf4eujLPRHGhU+e9Vj8jQVdMoLyPdBUQZMpdxjvvwX1I7
	D+FKayB5x1BQvFh5a+c61ftaoG/c8Z8MU+YMic+MlnC2+7e1IQz0mlc8x9UB7kpmu+BAmgdgAyn
	Reg2iLg==
X-Google-Smtp-Source: AGHT+IFlqFSE78I8H6DoSdEJHGBpeUjI/fKspB93yw3fdiNtIsVir90ZwUjXmIvbS26m1ju3QrxoTab4tXE=
X-Received: from pjbpq15.prod.google.com ([2002:a17:90b:3d8f:b0:32e:d03b:ade9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:164d:b0:32e:e150:8937
 with SMTP id 98e67ed59e1d1-33097fd4137mr1950022a91.6.1758242721467; Thu, 18
 Sep 2025 17:45:21 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 18 Sep 2025 17:45:11 -0700
In-Reply-To: <20250919004512.1359828-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250919004512.1359828-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
Message-ID: <20250919004512.1359828-5-seanjc@google.com>
Subject: [PATCH v3 4/5] KVM: selftests: Validate more arch-events in pmu_counters_test
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Yi Lai <yi1.lai@intel.com>, 
	dongsheng <dongsheng.x.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"

From: Dapeng Mi <dapeng1.mi@linux.intel.com>

Add support for 5 new architectural events (4 topdown level 1 metrics
events and LBR inserts event) that will first show up in Intel's
Clearwater Forest CPUs.  Detailed info about the new events can be found
in SDM section 21.2.7 "Pre-defined Architectural  Performance Events".

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Tested-by: Yi Lai <yi1.lai@intel.com>
[sean: drop "unavailable_mask" changes]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/testing/selftests/kvm/include/x86/pmu.h       | 10 ++++++++++
 tools/testing/selftests/kvm/include/x86/processor.h |  7 ++++++-
 tools/testing/selftests/kvm/lib/x86/pmu.c           |  5 +++++
 tools/testing/selftests/kvm/x86/pmu_counters_test.c |  8 ++++++++
 4 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/include/x86/pmu.h b/tools/testing/selftests/kvm/include/x86/pmu.h
index 3c10c4dc0ae8..2aabda2da002 100644
--- a/tools/testing/selftests/kvm/include/x86/pmu.h
+++ b/tools/testing/selftests/kvm/include/x86/pmu.h
@@ -61,6 +61,11 @@
 #define	INTEL_ARCH_BRANCHES_RETIRED		RAW_EVENT(0xc4, 0x00)
 #define	INTEL_ARCH_BRANCHES_MISPREDICTED	RAW_EVENT(0xc5, 0x00)
 #define	INTEL_ARCH_TOPDOWN_SLOTS		RAW_EVENT(0xa4, 0x01)
+#define	INTEL_ARCH_TOPDOWN_BE_BOUND		RAW_EVENT(0xa4, 0x02)
+#define	INTEL_ARCH_TOPDOWN_BAD_SPEC		RAW_EVENT(0x73, 0x00)
+#define	INTEL_ARCH_TOPDOWN_FE_BOUND		RAW_EVENT(0x9c, 0x01)
+#define	INTEL_ARCH_TOPDOWN_RETIRING		RAW_EVENT(0xc2, 0x02)
+#define	INTEL_ARCH_LBR_INSERTS			RAW_EVENT(0xe4, 0x01)
 
 #define	AMD_ZEN_CORE_CYCLES			RAW_EVENT(0x76, 0x00)
 #define	AMD_ZEN_INSTRUCTIONS_RETIRED		RAW_EVENT(0xc0, 0x00)
@@ -80,6 +85,11 @@ enum intel_pmu_architectural_events {
 	INTEL_ARCH_BRANCHES_RETIRED_INDEX,
 	INTEL_ARCH_BRANCHES_MISPREDICTED_INDEX,
 	INTEL_ARCH_TOPDOWN_SLOTS_INDEX,
+	INTEL_ARCH_TOPDOWN_BE_BOUND_INDEX,
+	INTEL_ARCH_TOPDOWN_BAD_SPEC_INDEX,
+	INTEL_ARCH_TOPDOWN_FE_BOUND_INDEX,
+	INTEL_ARCH_TOPDOWN_RETIRING_INDEX,
+	INTEL_ARCH_LBR_INSERTS_INDEX,
 	NR_INTEL_ARCH_EVENTS,
 };
 
diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index efcc4b1de523..e8bad89fbb7f 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -265,7 +265,7 @@ struct kvm_x86_cpu_property {
 #define X86_PROPERTY_PMU_NR_GP_COUNTERS		KVM_X86_CPU_PROPERTY(0xa, 0, EAX, 8, 15)
 #define X86_PROPERTY_PMU_GP_COUNTERS_BIT_WIDTH	KVM_X86_CPU_PROPERTY(0xa, 0, EAX, 16, 23)
 #define X86_PROPERTY_PMU_EBX_BIT_VECTOR_LENGTH	KVM_X86_CPU_PROPERTY(0xa, 0, EAX, 24, 31)
-#define X86_PROPERTY_PMU_EVENTS_MASK		KVM_X86_CPU_PROPERTY(0xa, 0, EBX, 0, 7)
+#define X86_PROPERTY_PMU_EVENTS_MASK		KVM_X86_CPU_PROPERTY(0xa, 0, EBX, 0, 12)
 #define X86_PROPERTY_PMU_FIXED_COUNTERS_BITMASK	KVM_X86_CPU_PROPERTY(0xa, 0, ECX, 0, 31)
 #define X86_PROPERTY_PMU_NR_FIXED_COUNTERS	KVM_X86_CPU_PROPERTY(0xa, 0, EDX, 0, 4)
 #define X86_PROPERTY_PMU_FIXED_COUNTERS_BIT_WIDTH	KVM_X86_CPU_PROPERTY(0xa, 0, EDX, 5, 12)
@@ -332,6 +332,11 @@ struct kvm_x86_pmu_feature {
 #define X86_PMU_FEATURE_BRANCH_INSNS_RETIRED		KVM_X86_PMU_FEATURE(EBX, 5)
 #define X86_PMU_FEATURE_BRANCHES_MISPREDICTED		KVM_X86_PMU_FEATURE(EBX, 6)
 #define X86_PMU_FEATURE_TOPDOWN_SLOTS			KVM_X86_PMU_FEATURE(EBX, 7)
+#define X86_PMU_FEATURE_TOPDOWN_BE_BOUND		KVM_X86_PMU_FEATURE(EBX, 8)
+#define X86_PMU_FEATURE_TOPDOWN_BAD_SPEC		KVM_X86_PMU_FEATURE(EBX, 9)
+#define X86_PMU_FEATURE_TOPDOWN_FE_BOUND		KVM_X86_PMU_FEATURE(EBX, 10)
+#define X86_PMU_FEATURE_TOPDOWN_RETIRING		KVM_X86_PMU_FEATURE(EBX, 11)
+#define X86_PMU_FEATURE_LBR_INSERTS			KVM_X86_PMU_FEATURE(EBX, 12)
 
 #define X86_PMU_FEATURE_INSNS_RETIRED_FIXED		KVM_X86_PMU_FEATURE(ECX, 0)
 #define X86_PMU_FEATURE_CPU_CYCLES_FIXED		KVM_X86_PMU_FEATURE(ECX, 1)
diff --git a/tools/testing/selftests/kvm/lib/x86/pmu.c b/tools/testing/selftests/kvm/lib/x86/pmu.c
index f31f0427c17c..5ab44bf54773 100644
--- a/tools/testing/selftests/kvm/lib/x86/pmu.c
+++ b/tools/testing/selftests/kvm/lib/x86/pmu.c
@@ -19,6 +19,11 @@ const uint64_t intel_pmu_arch_events[] = {
 	INTEL_ARCH_BRANCHES_RETIRED,
 	INTEL_ARCH_BRANCHES_MISPREDICTED,
 	INTEL_ARCH_TOPDOWN_SLOTS,
+	INTEL_ARCH_TOPDOWN_BE_BOUND,
+	INTEL_ARCH_TOPDOWN_BAD_SPEC,
+	INTEL_ARCH_TOPDOWN_FE_BOUND,
+	INTEL_ARCH_TOPDOWN_RETIRING,
+	INTEL_ARCH_LBR_INSERTS,
 };
 kvm_static_assert(ARRAY_SIZE(intel_pmu_arch_events) == NR_INTEL_ARCH_EVENTS);
 
diff --git a/tools/testing/selftests/kvm/x86/pmu_counters_test.c b/tools/testing/selftests/kvm/x86/pmu_counters_test.c
index e805882bc306..baa7b8a2d459 100644
--- a/tools/testing/selftests/kvm/x86/pmu_counters_test.c
+++ b/tools/testing/selftests/kvm/x86/pmu_counters_test.c
@@ -75,6 +75,11 @@ static struct kvm_intel_pmu_event intel_event_to_feature(uint8_t idx)
 		[INTEL_ARCH_BRANCHES_RETIRED_INDEX]	 = { X86_PMU_FEATURE_BRANCH_INSNS_RETIRED, X86_PMU_FEATURE_NULL },
 		[INTEL_ARCH_BRANCHES_MISPREDICTED_INDEX] = { X86_PMU_FEATURE_BRANCHES_MISPREDICTED, X86_PMU_FEATURE_NULL },
 		[INTEL_ARCH_TOPDOWN_SLOTS_INDEX]	 = { X86_PMU_FEATURE_TOPDOWN_SLOTS, X86_PMU_FEATURE_TOPDOWN_SLOTS_FIXED },
+		[INTEL_ARCH_TOPDOWN_BE_BOUND_INDEX]	 = { X86_PMU_FEATURE_TOPDOWN_BE_BOUND, X86_PMU_FEATURE_NULL },
+		[INTEL_ARCH_TOPDOWN_BAD_SPEC_INDEX]	 = { X86_PMU_FEATURE_TOPDOWN_BAD_SPEC, X86_PMU_FEATURE_NULL },
+		[INTEL_ARCH_TOPDOWN_FE_BOUND_INDEX]	 = { X86_PMU_FEATURE_TOPDOWN_FE_BOUND, X86_PMU_FEATURE_NULL },
+		[INTEL_ARCH_TOPDOWN_RETIRING_INDEX]	 = { X86_PMU_FEATURE_TOPDOWN_RETIRING, X86_PMU_FEATURE_NULL },
+		[INTEL_ARCH_LBR_INSERTS_INDEX]		 = { X86_PMU_FEATURE_LBR_INSERTS, X86_PMU_FEATURE_NULL },
 	};
 
 	kvm_static_assert(ARRAY_SIZE(__intel_event_to_feature) == NR_INTEL_ARCH_EVENTS);
@@ -171,9 +176,12 @@ static void guest_assert_event_count(uint8_t idx, uint32_t pmc, uint32_t pmc_msr
 		fallthrough;
 	case INTEL_ARCH_CPU_CYCLES_INDEX:
 	case INTEL_ARCH_REFERENCE_CYCLES_INDEX:
+	case INTEL_ARCH_TOPDOWN_BE_BOUND_INDEX:
+	case INTEL_ARCH_TOPDOWN_FE_BOUND_INDEX:
 		GUEST_ASSERT_NE(count, 0);
 		break;
 	case INTEL_ARCH_TOPDOWN_SLOTS_INDEX:
+	case INTEL_ARCH_TOPDOWN_RETIRING_INDEX:
 		__GUEST_ASSERT(count >= NUM_INSNS_RETIRED,
 			       "Expected top-down slots >= %u, got count = %lu",
 			       NUM_INSNS_RETIRED, count);
-- 
2.51.0.470.ga7dc726c21-goog


