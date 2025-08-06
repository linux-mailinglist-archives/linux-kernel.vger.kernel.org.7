Return-Path: <linux-kernel+bounces-758274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC64B1CD22
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 22:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2C561880A22
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 20:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14032E2F16;
	Wed,  6 Aug 2025 19:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fXpA5j26"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286142E1754
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 19:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754510329; cv=none; b=BxpL0/Bta3BuDN2o6oC71mo+NmxgPvy2PkDXYUVGs9s5dr4EEV1ENWsOr8jAh76RouAYpGbZeFSxjM3hZxhL3vDxljgGkCLEEaRG7ZAGNLSh146o0miwbL2vQ3KSLahT9frxOLz++22nGGgOV4kS+bljXD+t2VBW0ba4MhorSro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754510329; c=relaxed/simple;
	bh=mktiJzkM34N6Zf3/nCj8gPSMPc22J/Q3PSgyAnIfDJg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BHcL3ThwU2M6A1q7IjhQFpLEtwQsnFnka4wkbAboRpWNdINiimyM5t1oT29Kr1ZhlQ+3oOpzjglymM91kNqgNphAFkTL98fiAohIK727wvgeUnUcCwejfqW35QVbmY/hU+NExQUcfzQ+cj9PSFAx2IVfKcXXrmXyA6Z0q3mYRr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fXpA5j26; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b427c287cdfso272212a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 12:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754510324; x=1755115124; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=aIwiS3b08lZbnfZBzBRHsRLYuS/hl5WgYmD0pyHBLVw=;
        b=fXpA5j26IVK6dc9rtP00kkCEtvN2bqVStiB/w8fOy12s9JAtL+3eaGIEN0E3zRCEpF
         PB3xnRRQ7u1/ZEdLfYH4/2FLCNwESlB2Cc++/dfTWBjt0Y1aDY/a6162vkv8DudCjTKy
         y9FKqOhFjiD5kjvq1gDrDG7gCAcoag/+U+L6PisuV457jMx9oKdwVhF0knKU2TMZnCZT
         aISWWeRj88t0BXWJ/gSngCEF9dChvgrgu8i3tKgdvqaHjc1FBADtS3qLsgemZByv1hMM
         Hb35zir3S358snxgHky/ncSHxxhbaG+ryusJJeANTjNNH5HYdVcVNu6KHjWnGGsWfrq8
         cRlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754510324; x=1755115124;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aIwiS3b08lZbnfZBzBRHsRLYuS/hl5WgYmD0pyHBLVw=;
        b=LCskU5dOBxyU1LlwPNs+lsRl7bthkm3NirR6BankL+bh1uB9sEZWgYL+eSWCPSzHr/
         I8nMZZCuuSKExG4wkK+8iRGthPrWXeZJLVhyJKoSd4q5ykI4zZHAkBD1ufsPD7YzNOsw
         lJvxNTu2Dytf3Sr27F3WblDADS2JL5xtjCo0Z2sQMkd6H0SCWggGElrHEOIdJru2neWL
         SjGJ6GuP/7hxjUP3lh9VmFOHvxIJWlT+jlA0As9c4b/JTzm+pB7M5N6sVGIGo4Z8x7J/
         hZiiUOtqkYpmAhc+8dkRVH0rQBZx71Azjsos9ewuPhCZ1TNcAA0wxpXawPwcfqYItCAT
         n6sQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8TeX+iMOG9AxyyQhDbebQNHCM+P14U0LDyC3bwzQBlckMul7neBooDeWq7/uW/VKT/hC4Q/mtuPvpysU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbck8bXk7UDz3jSXTKxFJe2OMQo0TiRgum+tqOP1tEIs9ZuCdk
	OtAbMG8CzR2Qn8RORNnwzdiSNXNvbZOqk0vWGSCRY1vPdzZuLr/OYEso+PlCur434gWlDuB60G0
	vLcuh3A==
X-Google-Smtp-Source: AGHT+IEQR+T9dam/zfnLIV/i5izf3PHRRWb6ka2239rbCk7AqXY3VxMNYGaiVe7zhD28m3tT7rq7DHc261E=
X-Received: from pjzd15.prod.google.com ([2002:a17:90a:e28f:b0:312:151d:c818])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f645:b0:240:150e:57ba
 with SMTP id d9443c01a7336-242a0a90e7amr55806795ad.3.1754510324526; Wed, 06
 Aug 2025 12:58:44 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  6 Aug 2025 12:57:04 -0700
In-Reply-To: <20250806195706.1650976-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250806195706.1650976-1-seanjc@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250806195706.1650976-43-seanjc@google.com>
Subject: [PATCH v5 42/44] KVM: nSVM: Disable PMU MSR interception as
 appropriate while running L2
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

Add MSRs that might be passed through to L1 when running with a mediated
PMU to the nested SVM's set of to-be-merged MSR indices, i.e. disable
interception of PMU MSRs when running L2 if both KVM (L0) and L1 disable
interception.  There is no need for KVM to interpose on such MSR accesses,
e.g. if L1 exposes a mediated PMU (or equivalent) to L2.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/nested.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index b7fd2e869998..de2b9db2d0ba 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -194,7 +194,7 @@ void recalc_intercepts(struct vcpu_svm *svm)
  * Hardcode the capacity of the array based on the maximum number of _offsets_.
  * MSRs are batched together, so there are fewer offsets than MSRs.
  */
-static int nested_svm_msrpm_merge_offsets[7] __ro_after_init;
+static int nested_svm_msrpm_merge_offsets[10] __ro_after_init;
 static int nested_svm_nr_msrpm_merge_offsets __ro_after_init;
 typedef unsigned long nsvm_msrpm_merge_t;
 
@@ -222,6 +222,22 @@ int __init nested_svm_init_msrpm_merge_offsets(void)
 		MSR_IA32_LASTBRANCHTOIP,
 		MSR_IA32_LASTINTFROMIP,
 		MSR_IA32_LASTINTTOIP,
+
+		MSR_K7_PERFCTR0,
+		MSR_K7_PERFCTR1,
+		MSR_K7_PERFCTR2,
+		MSR_K7_PERFCTR3,
+		MSR_F15H_PERF_CTR0,
+		MSR_F15H_PERF_CTR1,
+		MSR_F15H_PERF_CTR2,
+		MSR_F15H_PERF_CTR3,
+		MSR_F15H_PERF_CTR4,
+		MSR_F15H_PERF_CTR5,
+
+		MSR_AMD64_PERF_CNTR_GLOBAL_CTL,
+		MSR_AMD64_PERF_CNTR_GLOBAL_STATUS,
+		MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR,
+		MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_SET,
 	};
 	int i, j;
 
-- 
2.50.1.565.gc32cd1483b-goog


