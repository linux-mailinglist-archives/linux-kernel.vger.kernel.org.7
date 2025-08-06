Return-Path: <linux-kernel+bounces-758255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D404B1CCF8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 22:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC03A723E2C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 20:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFAB52D94A3;
	Wed,  6 Aug 2025 19:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wlWkR4yx"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618322BE648
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 19:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754510299; cv=none; b=nZWPwcbJijaVxgoiGin8hQwnDXfz3r+LrwdIGyVzvEook0z22uzaET0IIyKk/rQLRgUOTURmgb81p77Jhh33sNiCNI9GL/9k9Nj1DrOiovKYrYvgEg1WCn7rMbt7TTSBgTVuiXXV0Rt7oPjJfUSoS5MggozAVDa0XDb0kn3TQRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754510299; c=relaxed/simple;
	bh=wHmlJSVtwVaQD0ZM8WmfI3XDA8yD245AfBXY7EV2M10=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gbO3bkmWuT8G0aA994K+jDi/EiP9/j6iQYT1LaTxTqZ1lOT2xvwFgEustFoi4OwS58dUMHl+v20HxCiEptc+Ul+rfocMHL6EZEHidoFUoQdVPeq5T0gJdKOwBQMIzAKAJEw2iSSy1dePZRbVP98kWsqepH9yb7IoXuFqQ3EdFUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wlWkR4yx; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2424aaa9840so2089585ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 12:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754510295; x=1755115095; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=7n78nD110ztSdGmfKKJPHep+PzR1j4ORmKnKizGjxcI=;
        b=wlWkR4yxBCBKUd7FpN2J//jigQqdrrSk22OgMrzaJUZf60flb19Mo8kFL5B6Gwt/V+
         xxH4hHX8vdn0y462uePOP8nIkxez+kkJLkMJTYNTaBkHzeO9RL1qAuqMyRic2szqeqjP
         TEvYgD09Zu0QbT7oWnXj3oP8+pQH2h5bHzxq2QEl0nYdJMD1BMoiZnLQo+Zvlc2JRiUt
         wy3kJuE1Qnv5L/2fuUf1EiNkqhdQaal/8hn3ee52feH0SsPlgH1wgx42q/TGuKnURMn2
         sXfxEjqnW1xWmCYPbXeZKWV3jmIiJW9tFwmu6D/qUlO/sgwUvSLRhZN8Na5gxCqb377x
         nfZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754510295; x=1755115095;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7n78nD110ztSdGmfKKJPHep+PzR1j4ORmKnKizGjxcI=;
        b=Z9LUJVvThanW+XTrLF0KgEvs9S+Kh6N7eD4776MNYmYtv4oQPn211iiRMsdmdtt4JX
         WuOxUutFcZj3Isb7Syvh3U0pxgdM3Q4w4zx8A8wPP9Tbxf332jjDhePxGS8FqnjHXWFl
         Ao7azlYDgQ744Pkb2hvY+BMS0BS9/ulYY+/d/Briz+Ety68pO8A1qZnj1lO81bAbooua
         dCrKbgCmQJQCeoZDZdJ9tq5jRBWzZrMDV8nt322sIbTeo3JBKG/95JpwIM5bLq5diPu7
         tq1Yyjw1PYCwQ7nkh25vz8XMsNpSXl4/HYoEZl9aGsDKu+1Uyu41YsGvPGzW3jY4LScp
         wJVw==
X-Forwarded-Encrypted: i=1; AJvYcCXxhx+iocMJav7hNmbT9/QqiA4HAOaQ00cCWLe4LoglwlQLBLxwW5ELJqMj289reCMb27seJRf9XtLGI38=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKqEiHIYRv8d7S/4LOedKmLnIFwI8L6jUuM2aZ6+bQCAxx9ayc
	XsMMQr+K6VA60fuoeqnupFkG3zBnVn7pd/g1eXAH54uqLhDc5NV/FOhawWQC6C6jJIiPqu1uEPz
	AT5aLwg==
X-Google-Smtp-Source: AGHT+IFqf7ZAG29dPCj/MpatUq6hwXzWupLmSqVpNm34U7crTT1sTW/TFLrPZa6u05A4GwIlFGKGaClhUR8=
X-Received: from pjpy17.prod.google.com ([2002:a17:90a:a411:b0:321:370d:cae5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cec8:b0:242:abac:30f0
 with SMTP id d9443c01a7336-242abac3c63mr29143805ad.42.1754510294999; Wed, 06
 Aug 2025 12:58:14 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  6 Aug 2025 12:56:47 -0700
In-Reply-To: <20250806195706.1650976-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250806195706.1650976-1-seanjc@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250806195706.1650976-26-seanjc@google.com>
Subject: [PATCH v5 25/44] KVM: x86: Use KVM_REQ_RECALC_INTERCEPTS to react to
 CPUID updates
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

Defer recalculating MSR and instruction intercepts after a CPUID update
via RECALC_INTERCEPTS to converge on RECALC_INTERCEPTS as the "official"
mechanism for triggering recalcs.  As a bonus, because KVM does a "recalc"
during vCPU creation, and every functional VMM sets CPUID at least once,
for all intents and purposes this saves at least one recalc.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/cpuid.c   | 2 ++
 arch/x86/kvm/svm/svm.c | 4 +---
 arch/x86/kvm/vmx/vmx.c | 3 ---
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index e2836a255b16..cc16e28bfab2 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -448,6 +448,8 @@ void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 	 * adjustments to the reserved GPA bits.
 	 */
 	kvm_mmu_after_set_cpuid(vcpu);
+
+	kvm_make_request(KVM_REQ_RECALC_INTERCEPTS, vcpu);
 }
 
 int cpuid_query_maxphyaddr(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 3d9dcc66a407..ef7dffc54dca 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1225,7 +1225,7 @@ static void init_vmcb(struct kvm_vcpu *vcpu)
 
 	svm_hv_init_vmcb(vmcb);
 
-	svm_recalc_intercepts(vcpu);
+	kvm_make_request(KVM_REQ_RECALC_INTERCEPTS, vcpu);
 
 	vmcb_mark_all_dirty(vmcb);
 
@@ -4478,8 +4478,6 @@ static void svm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 
 	if (sev_guest(vcpu->kvm))
 		sev_vcpu_after_set_cpuid(svm);
-
-	svm_recalc_intercepts(vcpu);
 }
 
 static bool svm_has_wbinvd_exit(void)
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 2244ca074e9d..6094de4855d6 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7782,9 +7782,6 @@ void vmx_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 		vmx->msr_ia32_feature_control_valid_bits &=
 			~FEAT_CTL_SGX_LC_ENABLED;
 
-	/* Recalc MSR interception to account for feature changes. */
-	vmx_recalc_intercepts(vcpu);
-
 	/* Refresh #PF interception to account for MAXPHYADDR changes. */
 	vmx_update_exception_bitmap(vcpu);
 }
-- 
2.50.1.565.gc32cd1483b-goog


