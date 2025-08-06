Return-Path: <linux-kernel+bounces-758270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B25B1CD15
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 22:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48BD57A7E2F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 20:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC4B2E0B6D;
	Wed,  6 Aug 2025 19:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OlE6BvYM"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B2C2E0415
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 19:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754510322; cv=none; b=qyFjnhJiPFa+T9HZS+qZaUOBSvaF3qRVpbWfWnRHC4Lok7rZqVMWC1YHN3i7OTZIHDcrfpL3AlOnq1QlQj2xYGW4fDTRevLXQWR/FmiA79VvO1YG4JOf+Jueec1w7W+4foMqJUR1rgsYYV5CM8el8hDfbPIY1fQMSo1J6N30hLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754510322; c=relaxed/simple;
	bh=eowlj8R0vSVTi/YxsD+P1ORI9OIx1rmOow0uWDRXpQc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KBysBp5EA31Qihztjxj2wnfO1ApkfQm6jo+NUwMc3siAB55w0cDvGPTp4w4hj5k/KPNEIerm/V/gDbvR2aL/bwkER1w3omjHxw78YAZIxLjVlesNO0EaciXmcjvd8hJ78AyUJ4ZyHMs4U/pI3iAXbhWj4YqYt0OIeVtZME0pMQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OlE6BvYM; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-31f32271a1fso373507a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 12:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754510319; x=1755115119; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=AlJpQpYzAXA8yQUaTEjcLu5rmW1zUT5mjcWEtsvn+qY=;
        b=OlE6BvYMbK2ZPWrZUD9pGLXrsiqhSrga2a6dSdgOddGyNn90KL5UA6HYAP0Ttr7K4B
         tNTx5s5HBl/2k/jm83UC+6gGbgPXyM0SG8HzuXMCGcBa2WB9Dc91JgXi/2eDxHqCLSn/
         aevWZ+Obqfw6yn84zCdjTV2ntOUIfnU0zpnSWC+XFt+xTOSm/ovxGpoOxehdvpUNhwCS
         2f8W3yWuxSNkAS+CH0Q16sh0k8LU9Su0cjpVl3Bhmlx6mWmIgnLfos7i/0rHghMv0787
         chIb9RgtUE+mJPs0UdmjJa+a1uOSEc75aqwJwz25Z6iyavLDIKJO8YZrYUtiSA/iLoOK
         gx6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754510319; x=1755115119;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AlJpQpYzAXA8yQUaTEjcLu5rmW1zUT5mjcWEtsvn+qY=;
        b=OdNpIVNSHyJTdVHzuxkznO7eJXdAoeWAesCf5TXisyS7EpoyGmGo1hj5cv0iD8WV6z
         bgyIr9l2BxpXXRPVyZ3gocsYB5TIhMOhkCCi9jZKlKJHyx3/6mO875HrUL/fQ4aVbI0W
         9zULle0y1SZqKg4eD9+hVJU3cN3gzz/339+Q0V1FNpJRJlMo3eNFTM2S12sf6ZmE2eg+
         uHfCluqhAyA7LIwSXm683Os3yMgEwDnzORVn/Lwj3bYGd0VGt+fQ6CRayBFH75YJglYL
         ej6+8gC72Ek7A7DZiov0oZjLjAQq3uQM4qLkHsUWBn+p2hzHQeaXLFkvXYwBKv6FJip4
         RClA==
X-Forwarded-Encrypted: i=1; AJvYcCWnIF/XMD357qCoGsqYvQ1C4pHTdm+u4GPLq7Vou+f7NteF4wCGIzARV6yh8VJktKjsalKG/rn+M1mwf0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSBtQrk9ZXKqVOSjxPHIr+gU0zG8htnn2W+UvX+vCZ8gYgAtT6
	qDIy/ncbK35x0xzXOZrkXG/hD9sMrAmrnvEc8L1PlhG1UVNADrNnZY6E+OlgZUSm1P3YsI+cViA
	qrUM8ng==
X-Google-Smtp-Source: AGHT+IFAT6PWSjUL0hLa4l6orw0CuXbesqbqOENgS6V/LUSfRrl7M4gZLDmaQmAh4Zg14qO5rj6Zp5FZNJo=
X-Received: from pjx15.prod.google.com ([2002:a17:90b:568f:b0:31c:32f8:3f88])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5110:b0:31f:4e9b:7c6a
 with SMTP id 98e67ed59e1d1-3217562accemr1061143a91.15.1754510319397; Wed, 06
 Aug 2025 12:58:39 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  6 Aug 2025 12:57:01 -0700
In-Reply-To: <20250806195706.1650976-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250806195706.1650976-1-seanjc@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250806195706.1650976-40-seanjc@google.com>
Subject: [PATCH v5 39/44] KVM: x86/pmu: Handle emulated instruction for
 mediated vPMU
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

Mediated vPMU needs to accumulate the emulated instructions into counter
and load the counter into HW at vm-entry.

Moreover, if the accumulation leads to counter overflow, KVM needs to
update GLOBAL_STATUS and inject PMI into guest as well.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/pmu.c | 39 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index 77042cad3155..ddab1630a978 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -1018,10 +1018,45 @@ void kvm_pmu_destroy(struct kvm_vcpu *vcpu)
 	kvm_pmu_reset(vcpu);
 }
 
+static bool pmc_is_pmi_enabled(struct kvm_pmc *pmc)
+{
+	u8 fixed_ctr_ctrl;
+
+	if (pmc_is_gp(pmc))
+		return pmc->eventsel & ARCH_PERFMON_EVENTSEL_INT;
+
+	fixed_ctr_ctrl = fixed_ctrl_field(pmc_to_pmu(pmc)->fixed_ctr_ctrl,
+					  pmc->idx - KVM_FIXED_PMC_BASE_IDX);
+	return fixed_ctr_ctrl & INTEL_FIXED_0_ENABLE_PMI;
+}
+
 static void kvm_pmu_incr_counter(struct kvm_pmc *pmc)
 {
-	pmc->emulated_counter++;
-	kvm_pmu_request_counter_reprogram(pmc);
+	struct kvm_vcpu *vcpu = pmc->vcpu;
+
+	/*
+	 * For perf-based PMUs, accumulate software-emulated events separately
+	 * from pmc->counter, as pmc->counter is offset by the count of the
+	 * associated perf event. Request reprogramming, which will consult
+	 * both emulated and hardware-generated events to detect overflow.
+	 */
+	if (!kvm_vcpu_has_mediated_pmu(vcpu)) {
+		pmc->emulated_counter++;
+		kvm_pmu_request_counter_reprogram(pmc);
+		return;
+	}
+
+	/*
+	 * For mediated PMUs, pmc->counter is updated when the vCPU's PMU is
+	 * put, and will be loaded into hardware when the PMU is loaded. Simply
+	 * increment the counter and signal overflow if it wraps to zero.
+	 */
+	pmc->counter = (pmc->counter + 1) & pmc_bitmask(pmc);
+	if (!pmc->counter) {
+		pmc_to_pmu(pmc)->global_status |= BIT_ULL(pmc->idx);
+		if (pmc_is_pmi_enabled(pmc))
+			kvm_make_request(KVM_REQ_PMI, vcpu);
+	}
 }
 
 static inline bool cpl_is_matched(struct kvm_pmc *pmc)
-- 
2.50.1.565.gc32cd1483b-goog


