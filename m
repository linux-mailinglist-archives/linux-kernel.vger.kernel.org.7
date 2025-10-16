Return-Path: <linux-kernel+bounces-856874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6697BE54F4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 22:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C75358053E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 20:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CEFB2DF15A;
	Thu, 16 Oct 2025 20:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CGX2PH1l"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653232DAFAA
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 20:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760645064; cv=none; b=WA11HJLxS75DQSgljjA9rUILM2xXrxoAuA5dh8cG/3SSP5fhOg7aPFNqJFASP6sX2REVy35rT7BmjjF6XF8hPtteUdDjoSqRq2RsUCWgGV6UKSdaiFleZeLBWwCzBXWNKWxyz8auSIpTeH4PZvT28aKVNkze85VNw9hANdVrtXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760645064; c=relaxed/simple;
	bh=ghs0JTPXViv3gYU+802FotJFDsjdBY8OuXRfpqVMfLY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WY2D4BouTzRWHdPMAgwqDF14jqK455haqtlvwJG1nzm9vM1UV/8zkDPMdkTudsplA+mru5CNzVFoiv3XCGQWBk1z9FUG3Xkue2eYAGNsgoZ/ORL9o9AMfSIPeCl51cN+I2AA3JYk9G+WgvShKjY2PsuPJF3GSIYMwJK/9JXiwiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CGX2PH1l; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-33bcb7796d4so482549a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 13:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760645063; x=1761249863; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=Tm/qXlQLAHEXKOAgwJvK+AVS1CazgIKzCEoGFToXAKI=;
        b=CGX2PH1lgQTaTjenSrfDealGvevD1z/jDMBrFGYnbfoA4KRaLMiD+frDMH4kL7frPY
         6SMqfOzaXrZobUzQvjaDpvfc5F1zBaMhKyABVsghxVOUcX5J+T6dZq4mOYxF+kNWbR9C
         m+tp7BSQ08tJ5stqH2+NncJK1T9LPakPo1socUyhYPIrJZIY4UBQk9lKSpwB9DVPfLnJ
         UiT3iloKEMLe4Aj7UCaVIwQKuW7B//zaJmAuhZg7nGHLxovGaoGFEMGWMfiU/hKtnH4j
         I1RZaU+SuLPkn6qL6ssXgjGWfBinFZ6MCvMY+1D7y1R5swLWhkBXgX0gUD1xzaNk08+F
         zncQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760645063; x=1761249863;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tm/qXlQLAHEXKOAgwJvK+AVS1CazgIKzCEoGFToXAKI=;
        b=lPTA6AvQP1CpH8KC6evcjRdWjNiGKlcbhmb8Gw2ff8gzZUVyPNqQ81phR0fFSFVFji
         uH35LpLvPrynTr+29niItUUwxFsZNrfHdW14NcMu2+kYqmovqfd6GZ5qhlMUk/fkjnLg
         IQkJW18rNOh7klpN4hGSEI9bnhkzNAPYawQQusIq8BsM/OY7WHmGS+e7seJiIGuILw8G
         A57649oD4urpUcWeRvTkgW46Fgn9hyzerTZtGMIP9tUEtc7L/XG/OqTBJ7fHhKdg7VH+
         dD232KkmL/PCUHtvIAj96L7sSpJMMpr9cKbPBonZ2iZza3VFrGjzlsQhYPvdo0EDf7Ym
         FYCg==
X-Forwarded-Encrypted: i=1; AJvYcCXSx/Ro0dGn8Gmy1BppdoIQATfuLsf1V6xi/zO0m0gCO85M2qnHnYXXsqdBcm5Q0vy4g6PRtohYlQI92dk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBUQEbJA0mUihFX/Jjo6cVppHZ09oGs3k5Ah3cNZXRbXDMjsMk
	bn0FOvTDyt1ZD0JnVOSC9d5kNfn+WLVM3/+3kpxIpORvZb4tERxgO1YmjwhZCN7pjWrRpYFqpAN
	pn3R5Xw==
X-Google-Smtp-Source: AGHT+IGuIUJFiaFRJKV+M0sz1MHDa0oHWE72Edwvx9CfUodCWHzB70GPJHhUzQvB94hkWD6mQpKM9Yhq4pU=
X-Received: from pjg12.prod.google.com ([2002:a17:90b:3f4c:b0:32e:d644:b829])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2789:b0:32e:3686:830e
 with SMTP id 98e67ed59e1d1-33bcf8faad4mr1235069a91.23.1760645062625; Thu, 16
 Oct 2025 13:04:22 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 16 Oct 2025 13:04:14 -0700
In-Reply-To: <20251016200417.97003-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251016200417.97003-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <20251016200417.97003-2-seanjc@google.com>
Subject: [PATCH v3 1/4] KVM: VMX: Flush CPU buffers as needed if L1D cache
 flush is skipped
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="UTF-8"

If the L1D flush for L1TF is conditionally enabled, flush CPU buffers to
mitigate MMIO Stale Data as needed if KVM skips the L1D flush, e.g.
because none of the "heavy" paths that trigger an L1D flush were tripped
since the last VM-Enter.

Note, the flaw goes back to the introduction of the MDS mitigation.  The
MDS mitigation was inadvertently fixed by commit 43fb862de8f6 ("KVM/VMX:
Move VERW closer to VMentry for MDS mitigation"), but previous kernels
that flush CPU buffers in vmx_vcpu_enter_exit() are affected.

Fixes: 650b68a0622f ("x86/kvm/vmx: Add MDS protection when L1D Flush is not active")
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index f87c216d976d..ce556d5dc39b 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6663,7 +6663,7 @@ int vmx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
  * information but as all relevant affected CPUs have 32KiB L1D cache size
  * there is no point in doing so.
  */
-static noinstr void vmx_l1d_flush(struct kvm_vcpu *vcpu)
+static noinstr bool vmx_l1d_flush(struct kvm_vcpu *vcpu)
 {
 	int size = PAGE_SIZE << L1D_CACHE_ORDER;
 
@@ -6691,14 +6691,14 @@ static noinstr void vmx_l1d_flush(struct kvm_vcpu *vcpu)
 		kvm_clear_cpu_l1tf_flush_l1d();
 
 		if (!flush_l1d)
-			return;
+			return false;
 	}
 
 	vcpu->stat.l1d_flush++;
 
 	if (static_cpu_has(X86_FEATURE_FLUSH_L1D)) {
 		native_wrmsrq(MSR_IA32_FLUSH_CMD, L1D_FLUSH);
-		return;
+		return true;
 	}
 
 	asm volatile(
@@ -6722,6 +6722,7 @@ static noinstr void vmx_l1d_flush(struct kvm_vcpu *vcpu)
 		:: [flush_pages] "r" (vmx_l1d_flush_pages),
 		    [size] "r" (size)
 		: "eax", "ebx", "ecx", "edx");
+	return true;
 }
 
 void vmx_update_cr8_intercept(struct kvm_vcpu *vcpu, int tpr, int irr)
@@ -7330,8 +7331,9 @@ static noinstr void vmx_vcpu_enter_exit(struct kvm_vcpu *vcpu,
 	 * and is affected by MMIO Stale Data. In such cases mitigation in only
 	 * needed against an MMIO capable guest.
 	 */
-	if (static_branch_unlikely(&vmx_l1d_should_flush))
-		vmx_l1d_flush(vcpu);
+	if (static_branch_unlikely(&vmx_l1d_should_flush) &&
+	    vmx_l1d_flush(vcpu))
+		;
 	else if (static_branch_unlikely(&cpu_buf_vm_clear) &&
 		 (flags & VMX_RUN_CLEAR_CPU_BUFFERS_FOR_MMIO))
 		x86_clear_cpu_buffers();
-- 
2.51.0.858.gf9c4a03a3a-goog


