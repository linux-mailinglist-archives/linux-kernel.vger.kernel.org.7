Return-Path: <linux-kernel+bounces-769844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5C0B2745B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 02:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 383575E027A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 00:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0E915C15F;
	Fri, 15 Aug 2025 00:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="drO4Nayo"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984441C5F10
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 00:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755219459; cv=none; b=nre1D/BQs5KpMBcnf40bfy3lgD8vW3N41EeKpY6e5UocbRPwlrd3qxAq8XHVtJfRguO1TE17aP9O5sKBMaSY7iUrG2G+MF/r1oD5H4X/jFXsZrQSr40wYF25yXj/BWgb5NzPQJTrTsNsVjUm/JvqcTSvFoZAwyJcxZINMOvm91Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755219459; c=relaxed/simple;
	bh=j/1Lr+UronIgRZzRhuMgqCzyJ+s+Y1BrEcIfq0eFCQ8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qPxuIzlkwuDWNgrmirk5XzYcP8aoxyrHII+bMMRzM7Q/KcVLB7Wr9EYtCF1y59T70RtbZC1POHvqSYfECr3qaVCOQJasE+shDs44c/n1g1m4soSz9QrHSFORGsWINVj8G1BWOta3ALr4jbdzewJ1KckVO6N41y1ouoOkoD8IMJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=drO4Nayo; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-76e2e8b4ab7so1257538b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 17:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755219456; x=1755824256; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=yn2/hQHtLRcblfHHYK8i9PorExs5KUNMzDzB5HQI7e0=;
        b=drO4Nayo3eiKFeBnW8i0c8OW9xBwxe4t8szIpNQuoSj7DpPIU8qjwOM/Smy6uHXqTa
         T9UBBgu3s6du9Wqt8QMwZtP2NeeiFEX9ha8XfwBIHPSOab1wjyUg+2jZ9fBlxuEHcjsj
         +tqdS3ng1Fjw64I8HHmCJLjMJcYVfqjy6+vRvFugt6RXT2dYoaRFno+j0WVdCL1ffNDI
         fb9iqq8szs36vemosCAQp6nWwiYtqxmPG1YXcaBknDort/c0gFV7PIbyRkf+Fm4RKJHR
         HcUKIZR6qXITFBk/izxKjOdh6/5CjHtRxVy+ONZIW1XVws6DGumgN3PYD94jxbPkv4dr
         C7iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755219456; x=1755824256;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yn2/hQHtLRcblfHHYK8i9PorExs5KUNMzDzB5HQI7e0=;
        b=c5d/9+WdoUvWsLrs6MnsDjg4bEkFdgcpRAIgi5VosXGyyk4qF9lmHq4QiBnSS081WC
         GgI2RdUBGt277MBvTacOoqVUoO+l6xwa2dhqKwHJIvSXi7GWuYIR8p2VCqtUtBUGNv7p
         5arUQ/oRx5JhRfvIstXfHy6ur1WnvdnT2Rrojny1ljT0u8f1RyJ7CcpyfjWp9x9oyYkt
         N8QzQSMnpt+63ijP7cJp+C+NREIZK6b14JVGAwpzi4Yo1wRa1cJOgt+217QDRACT3iw7
         LvsAMmWoEX4x9K7dKQjA8It0Urx9i2gefURYYaEhcbHd7yY0Q55d8Pdoik7O5Rh2VMU8
         mDmA==
X-Forwarded-Encrypted: i=1; AJvYcCUxxuh4Nwax7WfXsnTnBR/euVfvSHScTb01mmgoU8yzJMsN59F6rKR0Tv+n5kHgRKInj15FP8Oup/uPzco=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdbgPlYoC1U6EuahE6JfM5xdHjPZJJbjJwVFXD9zQfoYxDx2L1
	Ahida5LDGJBKTEf3a5ld6X9yTQU43hBQX4/vcrYIBL7KNPoSI2v4TQHikUSo7rNoWRcFuHX8Fwf
	xxFbQlw==
X-Google-Smtp-Source: AGHT+IFZL2tPxvArwSPUwK98zfaa8xkAH1W3s5f0rydb+BXhSEJ8YZvFix+N5zVp7GN4wzi4lQHdrQKHjGY=
X-Received: from pglv6.prod.google.com ([2002:a63:1506:0:b0:b47:4ef:fcee])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6d85:b0:23d:c4c6:f406
 with SMTP id adf61e73a8af0-240d2f43f2emr449311637.43.1755219455963; Thu, 14
 Aug 2025 17:57:35 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 Aug 2025 17:57:22 -0700
In-Reply-To: <20250815005725.2386187-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250815005725.2386187-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Message-ID: <20250815005725.2386187-5-seanjc@google.com>
Subject: [PATCH 6.12.y 4/7] KVM: VMX: Extract checking of guest's DEBUGCTL
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
index 529a10bba056..ff61093e9af7 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2192,6 +2192,19 @@ static u64 vmx_get_supported_debugctl(struct kvm_vcpu *vcpu, bool host_initiated
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
@@ -2260,19 +2273,12 @@ int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
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
@@ -2282,7 +2288,6 @@ int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		    (data & DEBUGCTLMSR_LBR))
 			intel_pmu_create_guest_lbr_event(vcpu);
 		return 0;
-	}
 	case MSR_IA32_BNDCFGS:
 		if (!kvm_mpx_supported() ||
 		    (!msr_info->host_initiated &&
-- 
2.51.0.rc1.163.g2494970778-goog


