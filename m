Return-Path: <linux-kernel+bounces-769776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 901D6B273A4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 02:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36EAB720442
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 00:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26EDB224B09;
	Fri, 15 Aug 2025 00:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V5GnQYN5"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E2C21C161
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 00:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755216767; cv=none; b=lJCd14w7N3MJ8zVnpstjbDe94E0iC9TuyFqpf2j8WyRngAmJnDvAuPRbkoPaqKJIl9sKHM+jaBt0iSeSRPgRGnD86cUDOVHbaGoDg3dIP67Ro+wIFTfWDYzpI0bqOk6ZmTFqGzluczlbd+PTQn+Vg5v1iPWatJBeIVCogGm0+Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755216767; c=relaxed/simple;
	bh=d4VZkPw4RAyHIWRZJDzABU/cEq7qkdsgmjzT5CLiyGI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kCunBlAP1YDj32mQ5b6BvQMFl7mhjg8alz6onqNw0ZeMsOXE8wXw199rvQU8ABqqsPzK+M06xsaTkanz24Az7H4z2NEIQw0Jt8k4ctP5uzpJyQbHnip71gbG/ZY37UoPCJhR7PXPCSLrloYqSL6C2/TJp82NLVle1T8bMgYwvz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V5GnQYN5; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b471758845dso1034603a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 17:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755216764; x=1755821564; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=eQfmi+GnDIrdp8ejQz7KjH8qWzqOpQFlk46cwdVc498=;
        b=V5GnQYN53x+sZZPDcYocLWwx8Jaa9cxT8zEbXf+PiDqEAAJuHOetTvS5Yb3PO03l4+
         gsULL0/Tv2uQ5eAYgDQ1e9oyWboJlb3kYM9dBBxiiDAcC1iPYp+Y4wJUkABpZLReCC2B
         pOxOPRm2Ue8+hUxs8i/stjZ90l+HAjZQWFGHch3fmUtO6DCQxzNdADkaS8MuS6ucV03k
         iRDwjby7Bmk1q+gROtO33562B/NUZoj5RTBdA+9RdzXndOwOSpvlD+esgwSa7bv3rPqr
         w+w0DXqHIYwHP57Q3n+S5rVqWOGAKz7DMNSW7czJclEm4nccENGApCryp5PPNgeF9R1C
         8NKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755216764; x=1755821564;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eQfmi+GnDIrdp8ejQz7KjH8qWzqOpQFlk46cwdVc498=;
        b=grLOqYRTu7v645e2iEwmiiLD9VjeXvlIhBcb8kIaoWpQWiD/QLWu26yw8bGpg5ka6X
         vylUAUhpOJE02I/zFwZM9eDl+fC1k0/7gug25b6fWaGmdG/bh0J5+e+O7slbuBdEgyOM
         EmL0f/dm69JbktyIMmrVwwQ3Ek0Q0ZlQ09ypxqCPpJx8J2HY4im64VdM/x8+cGc0AL7A
         A8iGyXyeetspfIzffrQb5Dt9kKiPL7A+7OC7JdgpyKhxZGx5t9LpgWtsqzEbRG/lKzF3
         dhax1nligCz+xTI3xZsIzqpxYPoTHAwT3zqZuRYrcad5xrG96Bva7s9r1WWhENGotacf
         5JvA==
X-Forwarded-Encrypted: i=1; AJvYcCVuRgfGDV58fdz/CTVtEGuDyYp2aCJxefLyPOhGMucqUGeVYCDWgQ1PkfKreZxYkTW5Oz7qPGNsyelTvGs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/GEUiDUKqpK4JlMCF/WjgX4dsrdGYuAGbEk7HoSWe2HxD+0N7
	bL/+E6elngGhINeNGairdgsJp+cb80Gg+JtEdTRWQQhI/0v1WR/TcG/72WjOlaX2FP27l9iPlm5
	4/QHiDw==
X-Google-Smtp-Source: AGHT+IFtuPHuUUf2dGJRUA8RXNywCif+lc9d/kdwZ3rsFPF10o+G2qnMZNWB7mcc8Bbok7Ll5v8EWWQ9YSk=
X-Received: from pjbqn6.prod.google.com ([2002:a17:90b:3d46:b0:31f:1a3e:fe3b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cccb:b0:235:7c6:ebdb
 with SMTP id d9443c01a7336-2446d6dc1bemr1642285ad.10.1755216764117; Thu, 14
 Aug 2025 17:12:44 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 Aug 2025 17:12:02 -0700
In-Reply-To: <20250815001205.2370711-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250815001205.2370711-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Message-ID: <20250815001205.2370711-19-seanjc@google.com>
Subject: [PATCH 6.1.y 18/21] KVM: VMX: Extract checking of guest's DEBUGCTL
 into helper
From: Sean Christopherson <seanjc@google.com>
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sasha Levin <sashal@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"

[ Upstream commit 8a4351ac302cd8c19729ba2636acfd0467c22ae8 ]

Move VMX's logic to check DEBUGCTL values into a standalone helper so that
the code can be used by nested VM-Enter to apply the same logic to the
value being loaded from vmcs12.

KVM needs to explicitly check vmcs12->guest_ia32_debugctl on nested
VM-Enter, as hardware may support features that KVM does not, i.e. relying
on hardware to detect invalid guest state will result in false negatives.
Unfortunately, that means applying KVM's funky suppression of BTF and LBR
to vmcs12 so as not to break existing guests.

No functional change intended.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Link: https://lore.kernel.org/r/20250610232010.162191-6-seanjc@google.com
Stable-dep-of: 7d0cce6cbe71 ("KVM: VMX: Wrap all accesses to IA32_DEBUGCTL with getter/setter APIs")
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 9445def2b3d2..6517b9d929bf 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2071,6 +2071,19 @@ static u64 vmx_get_supported_debugctl(struct kvm_vcpu *vcpu, bool host_initiated
 	return debugctl;
 }
 
+static bool vmx_is_valid_debugctl(struct kvm_vcpu *vcpu, u64 data,
+				  bool host_initiated)
+{
+	u64 invalid;
+
+	invalid = data & ~vmx_get_supported_debugctl(vcpu, host_initiated);
+	if (invalid & (DEBUGCTLMSR_BTF | DEBUGCTLMSR_LBR)) {
+		kvm_pr_unimpl_wrmsr(vcpu, MSR_IA32_DEBUGCTLMSR, data);
+		invalid &= ~(DEBUGCTLMSR_BTF | DEBUGCTLMSR_LBR);
+	}
+	return !invalid;
+}
+
 /*
  * Writes msr value into the appropriate "register".
  * Returns 0 on success, non-0 otherwise.
@@ -2139,19 +2152,12 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		}
 		vmcs_writel(GUEST_SYSENTER_ESP, data);
 		break;
-	case MSR_IA32_DEBUGCTLMSR: {
-		u64 invalid;
-
-		invalid = data & ~vmx_get_supported_debugctl(vcpu, msr_info->host_initiated);
-		if (invalid & (DEBUGCTLMSR_BTF|DEBUGCTLMSR_LBR)) {
-			kvm_pr_unimpl_wrmsr(vcpu, msr_index, data);
-			data &= ~(DEBUGCTLMSR_BTF|DEBUGCTLMSR_LBR);
-			invalid &= ~(DEBUGCTLMSR_BTF|DEBUGCTLMSR_LBR);
-		}
-
-		if (invalid)
+	case MSR_IA32_DEBUGCTLMSR:
+		if (!vmx_is_valid_debugctl(vcpu, data, msr_info->host_initiated))
 			return 1;
 
+		data &= vmx_get_supported_debugctl(vcpu, msr_info->host_initiated);
+
 		if (is_guest_mode(vcpu) && get_vmcs12(vcpu)->vm_exit_controls &
 						VM_EXIT_SAVE_DEBUG_CONTROLS)
 			get_vmcs12(vcpu)->guest_ia32_debugctl = data;
@@ -2161,7 +2167,6 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		    (data & DEBUGCTLMSR_LBR))
 			intel_pmu_create_guest_lbr_event(vcpu);
 		return 0;
-	}
 	case MSR_IA32_BNDCFGS:
 		if (!kvm_mpx_supported() ||
 		    (!msr_info->host_initiated &&
-- 
2.51.0.rc1.163.g2494970778-goog


