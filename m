Return-Path: <linux-kernel+bounces-769775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5F4B27390
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 02:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AF05189878A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 00:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082D11FF5EC;
	Fri, 15 Aug 2025 00:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g1OB//JM"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B23721ABD5
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 00:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755216765; cv=none; b=jWqBd9VAj2xWtvPUfFNjmeSRsB80ue+TWhnc6T1Ti/vd9XqRfxhahevA1wVMJZ6kr/jxSsefI8FtkfdqaPM4C61PvEjLkeXT7H6Eti6EFweAH3Wr8d+dzRy3Hg9lodCXnPwoVAUUjJTte5TGl+tDdhUt+Yc4nP+NGt1MzvyKlKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755216765; c=relaxed/simple;
	bh=ZNUgVI46E0OBePkY8rZgCoXXPCeoOFlmMiH7qcC5XD0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XnGOjOVQayan+0N/UO+amurR5ZBTFcpkA2/pkWZ39+gJ+odzMQpEFCuhhb15iW3jWeiaGtz0nzN6QrXcUbEeIc32jJLqrnGNr6PlsSy7zqDpDBIjwSuNXoKbAk4mdUxuaGMGdnhXjQIwhELcfYrR/3ryQ1Zy1mEJxrgEqc6a+2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g1OB//JM; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-321cf7549afso2074721a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 17:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755216762; x=1755821562; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=R2pN41pL9/2mODdo8yvh5+ZzvaLNu8BCBG5lgJlQkBA=;
        b=g1OB//JMiHaGKTPF/ppT7jhcgprpcJoJmhppeO0G8IsgIGFbuunWILVAnhzjUViZHH
         kQVj0vDOjI9mT/ZCgWdY2qQqrylIuUdpd5Wfh7lQKwbg999IjXpv/irS5alEtutfTIC3
         MhK2Ln597eRuN5MTvwayIXIZ4hB6sUmYE/ms8HTaPGhggxouJBhAjgyQSOE5wuogFFHY
         Em8/xdKNKk20eFgmnkvnmA/5JMD475Jb7Qpnw66s84IAjVCfn3ugrXexi0QJxybl+GcZ
         PpWYDPupUeFe4ObHQPSqQatFCkGKeqk9j9ij3ehG/tlZe6gW7KeTOOazz2EibcyL8TDI
         vLcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755216762; x=1755821562;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R2pN41pL9/2mODdo8yvh5+ZzvaLNu8BCBG5lgJlQkBA=;
        b=b+sO3PoBLfyIhM6qWq6ACJyXrn6/P7N8zI/oABgkBwnUBbYM2nVQzjOge825hhtSxa
         slZJh31d1c31UuWVRUknGz6tY93GTUDbnhP8dSk/0m3nvQ1KKB3dsCMqOX8koPTh4YvF
         Zpg4GPdZFXuDClVYJDB0LUYYyntsSWsIBsWn2lqan4Zgzy1cEu8VmN0SurVuzYVEEUNQ
         1Y4SAcRN8mEKunqWA0944U0KEUhuPI+SD4sohd7Nc4B0mqB87stdPlwCcaE9M2AyAaqw
         z9LmrsFz07vc4/2D/Z9AT+jJMCg+lmmMcdDVDIYzsAn16j03ViGsHJcsANrEkA/kWzs9
         qDQw==
X-Forwarded-Encrypted: i=1; AJvYcCXFvhsAcYtup1FEmgtNEwI55uwgBHnHWuH6N86xdyBPWpLRK4m1X5A2wBUyCfiuLyioQ4csMC/9VthEQVA=@vger.kernel.org
X-Gm-Message-State: AOJu0YycBA02zDiEZKAdQJUXaGFQZDiaHbj+2+6f7tm1xMS/CW4KPpJa
	j4hFcUTO5ee+OnDRGenOQCRRfiEB6a3qgqcfA5e18rLjMFeitg6AXSVsf59nOrvZyT6KxAfQKR+
	gM5fCrA==
X-Google-Smtp-Source: AGHT+IED/dB3BvLeWzmXrmh6dopVdFx3W31DTAGoQRFRaiqxSY4V+FoKnuxqrBvFDmZBctuTt5QJjgSBCfE=
X-Received: from pjbsd8.prod.google.com ([2002:a17:90b:5148:b0:321:c9cf:de39])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2681:b0:321:c9cf:deaa
 with SMTP id 98e67ed59e1d1-323297bdeb6mr7052059a91.17.1755216762510; Thu, 14
 Aug 2025 17:12:42 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 Aug 2025 17:12:01 -0700
In-Reply-To: <20250815001205.2370711-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250815001205.2370711-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Message-ID: <20250815001205.2370711-18-seanjc@google.com>
Subject: [PATCH 6.1.y 17/21] KVM: VMX: Allow guest to set DEBUGCTL.RTM_DEBUG
 if RTM is supported
From: Sean Christopherson <seanjc@google.com>
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sasha Levin <sashal@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"

[ Upstream commit 17ec2f965344ee3fd6620bef7ef68792f4ac3af0 ]

Let the guest set DEBUGCTL.RTM_DEBUG if RTM is supported according to the
guest CPUID model, as debug support is supposed to be available if RTM is
supported, and there are no known downsides to letting the guest debug RTM
aborts.

Note, there are no known bug reports related to RTM_DEBUG, the primary
motivation is to reduce the probability of breaking existing guests when a
future change adds a missing consistency check on vmcs12.GUEST_DEBUGCTL
(KVM currently lets L2 run with whatever hardware supports; whoops).

Note #2, KVM already emulates DR6.RTM, and doesn't restrict access to
DR7.RTM.

Fixes: 83c529151ab0 ("KVM: x86: expose Intel cpu new features (HLE, RTM) to guest")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20250610232010.162191-5-seanjc@google.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/msr-index.h | 1 +
 arch/x86/kvm/vmx/vmx.c           | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 727947ed5e5e..afd65c815043 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -379,6 +379,7 @@
 #define DEBUGCTLMSR_FREEZE_PERFMON_ON_PMI	(1UL << 12)
 #define DEBUGCTLMSR_FREEZE_IN_SMM_BIT	14
 #define DEBUGCTLMSR_FREEZE_IN_SMM	(1UL << DEBUGCTLMSR_FREEZE_IN_SMM_BIT)
+#define DEBUGCTLMSR_RTM_DEBUG		BIT(15)
 
 #define MSR_PEBS_FRONTEND		0x000003f7
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 60d1ff3fca45..9445def2b3d2 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2064,6 +2064,10 @@ static u64 vmx_get_supported_debugctl(struct kvm_vcpu *vcpu, bool host_initiated
 	    (host_initiated || intel_pmu_lbr_is_enabled(vcpu)))
 		debugctl |= DEBUGCTLMSR_LBR | DEBUGCTLMSR_FREEZE_LBRS_ON_PMI;
 
+	if (boot_cpu_has(X86_FEATURE_RTM) &&
+	    (host_initiated || guest_cpuid_has(vcpu, X86_FEATURE_RTM)))
+		debugctl |= DEBUGCTLMSR_RTM_DEBUG;
+
 	return debugctl;
 }
 
-- 
2.51.0.rc1.163.g2494970778-goog


