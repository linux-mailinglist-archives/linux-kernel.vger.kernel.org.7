Return-Path: <linux-kernel+bounces-799996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84AE2B43231
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 08:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04EC11C21690
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498C325B2FA;
	Thu,  4 Sep 2025 06:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xXhFRW3z"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4CB259CA5
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 06:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756966815; cv=none; b=UCEQk1kEkev5af/2yKe/dj+iuLhtvV4KQzSVJ1owj+qIkSKYAyTY03UrOr9C6XzdnpRb8J63GC6yLFnvVHneG7va6rNBn3g/Z0uYDemL/P+n+ZLYud6h0kcaiioekoI4g6KaX3G9fElEJYjV95wEq1gPdAVPAiNANyCXKbhzpA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756966815; c=relaxed/simple;
	bh=L9IbDpl9YeAPbkNWRMRMo/b2Utf7GwlhkdtfUevFjGc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=puUhBsZjMEzR2tWAcA/Z2HHjn3KU5MP1dMqsRd/BVjqCiZtI8giEozxoo9QV22sULh3VJVW+2pP5mcL0XBE1T76b3ReDwOetVDMFFIGLN7A8ZozdKCSm2Z6dqtR+A9sBObWk9sntS3kpleYTwtyBqLIXKRGkO0Q50KLUmeOOmzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xXhFRW3z; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-24cb39fbd78so9627385ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 23:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756966813; x=1757571613; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5quzDayhtAriGJg7zaAaFURysSpqDdXw5doHq+jt5QU=;
        b=xXhFRW3zykPGgerALfhOn9ooK2CNuKN7k7Yi9gnSkT2iMfAJKCZvEgyl2zl2kJwe0B
         p2xiu0fbl46cc1T+89aoeOdtjqeJ1MORxBdTWJlEBZDkg/TvXGOAQHubLy3Q8S6nr7m2
         yWrAJPxqH9XFh8QpoY6psNclGwYgTTuxcSom78jFzLsHjyOjoGt7XwgOKu+2ww2JLIX9
         i+d2GM+VdjyWsAvN5SxdOECR8Xk81UsHfTObGO+q+k3wJTl6WC9YWav7CFtT+L+pHdpf
         B68D7ulIUfybbAWQ/vXPS0eUHz0/Nzm6WFeS/sFU88/RuD4b2srdVsl6n8JgSCldQpah
         vT+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756966813; x=1757571613;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5quzDayhtAriGJg7zaAaFURysSpqDdXw5doHq+jt5QU=;
        b=t/uthZhrcnY714HS+ntOdx8Prvtyh99glpWs2VpeMk5TYqHZ3BVrn0lI2OjQvEeZJF
         WOpsHG8gkaw0yGzxwiJLa4CMQvvsFFAf0my5CaO4NpaiHt6JmaiMAKvb3o/ZA5RCl6Ql
         4xFh5gt4R2NoPAINQh8I3EH3d2HHDzOlpnEk85DoC6x+jcm1qle1+PuaalE9TCp4jWxb
         7sb8bfGbu1iaPVKi2OzwDUehpaMsOcMCsEvTPs2bVJTFUjWPUFkLtnrYRIq3PZgT/a45
         0UKvteBcCOScG7DZRktNguWzcGVcnyWwE+y5dCsf6szUoLH+csqgfVUqRxQ4VHZXnkX7
         24Qw==
X-Gm-Message-State: AOJu0YxiRSEMyqm2xmj9JdGsUYiDAG4ZlmtPddpg9NLV4J/K4pY7+ilg
	/v2uSIG1R5d0OQWM56LuUkuyc5mMknNmslJm+1UU7lDhoFh0DsN6DoFTT6AJXicc2S41IinzvV4
	G/A==
X-Google-Smtp-Source: AGHT+IF1Km48eiSONTRaLAhk/LxIal+ixyPLftV6nKQfAlBvSe8kiyLsI8+e4CycXRiD5UG9VK7pSCprOg==
X-Received: from pjbst15.prod.google.com ([2002:a17:90b:1fcf:b0:327:5082:ca1b])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ec8b:b0:249:113c:b676
 with SMTP id d9443c01a7336-249448d6991mr229945645ad.16.1756966813490; Wed, 03
 Sep 2025 23:20:13 -0700 (PDT)
Date: Wed,  3 Sep 2025 23:20:07 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904062007.622530-1-sagis@google.com>
Subject: [PATCH v4] KVM: TDX: Force split irqchip for TDX at irqchip creation time
From: Sagi Shahar <sagis@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Kai Huang <kai.huang@intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, x86@kernel.org, 
	Sagi Shahar <sagis@google.com>, Xiaoyao Li <xiaoyao.li@intel.com>
Content-Type: text/plain; charset="UTF-8"

TDX module protects the EOI-bitmap which prevents the use of in-kernel
I/O APIC. See more details in the original patch [1].

The current implementation already enforces the use of split irqchip for
TDX but it does so at the vCPU creation time which is generally too late
to fallback to split irqchip.

This patch follows Sean's recommendation from [2] and adds a check if
I/O APIC is supported for the VM at irqchip creation time.

[1] https://lore.kernel.org/lkml/20250222014757.897978-11-binbin.wu@linux.intel.com/
[2] https://lore.kernel.org/lkml/aK3vZ5HuKKeFuuM4@google.com/

Suggested-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Acked-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
---
 arch/x86/include/asm/kvm_host.h | 1 +
 arch/x86/kvm/vmx/tdx.c          | 1 +
 arch/x86/kvm/x86.c              | 9 +++++++++
 3 files changed, 11 insertions(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index f19a76d3ca0e..6a4019d3a184 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1357,6 +1357,7 @@ struct kvm_arch {
 	u8 vm_type;
 	bool has_private_mem;
 	bool has_protected_state;
+	bool has_protected_eoi;
 	bool pre_fault_allowed;
 	struct hlist_head *mmu_page_hash;
 	struct list_head active_mmu_pages;
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 66744f5768c8..6daa45dcbfb0 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -630,6 +630,7 @@ int tdx_vm_init(struct kvm *kvm)
 
 	kvm->arch.has_protected_state = true;
 	kvm->arch.has_private_mem = true;
+	kvm->arch.has_protected_eoi = true;
 	kvm->arch.disabled_quirks |= KVM_X86_QUIRK_IGNORE_GUEST_PAT;
 
 	/*
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index a1c49bc681c4..57b4d5ba2568 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6966,6 +6966,15 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 		if (irqchip_in_kernel(kvm))
 			goto create_irqchip_unlock;
 
+		/*
+		 * Disallow an in-kernel I/O APIC if the VM has protected EOIs,
+		 * i.e. if KVM can't intercept EOIs and thus can't properly
+		 * emulate level-triggered interrupts.
+		 */
+		r = -ENOTTY;
+		if (kvm->arch.has_protected_eoi)
+			goto create_irqchip_unlock;
+
 		r = -EINVAL;
 		if (kvm->created_vcpus)
 			goto create_irqchip_unlock;
-- 
2.51.0.338.gd7d06c2dae-goog


