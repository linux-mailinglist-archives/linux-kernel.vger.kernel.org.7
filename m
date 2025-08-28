Return-Path: <linux-kernel+bounces-789014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37ECEB38FCA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 02:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E5EF7B436A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 00:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B930A199920;
	Thu, 28 Aug 2025 00:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1L5Baxdr"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A390814885D
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 00:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756341012; cv=none; b=qKdkS9IPhF9jeNHCljzexmpdbOrPuYg2jFfX1GNhrLiBcq4pM88gDa8OCVjnvr/orVEzyzIrm1nzV84lVhhD53gfuBt7+Ybe1rtoSSq/FNsHjmKFBO0ZZYJiChDY/gF6e3y4Zn+pgsrgg7o7DVTcqcXHlJhHLOsL8Xd59uw6i8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756341012; c=relaxed/simple;
	bh=eXOBXpkZ02+fsWzn0bIQcLlUn2dEHSjQIN6wZt8ejTs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=RxjvrsHSRRcCjO7lMEcT3rWqBfXRVVBIu/SHaYhLzWdhz4ESnovAlCatzHXxGnHe19FcHbPmks2aQ6MFSNzUGnBi5nAjbnLlRV5P+dhlBrn7UJwa7G9tDHhuTbd1V1ggyItfVBYAbyHjozAMhrN2ZqYZsKIsNK+0Z/iGUiL090U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1L5Baxdr; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-324e41e946eso702306a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 17:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756341010; x=1756945810; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JQQriFihIdlgv6YMIws6gyaIkwUMDRppRrS82dBz+Zw=;
        b=1L5BaxdrMV1oSDcbl8iut2OLp2Zv0zQ4x2L0w1cI1+2XlHEku+KHhkW10OaMYTSc2W
         DZIqZpWihnSkU/77eCnQcBibH73tA+jdKz2K/Jtkxo8znqAQy0pyd1E4IxLdUXHhMRcf
         6p+nNBZYv0lRjX5Z+EFVe1juhgEbmSyp7cEsmyI5v6EG4kVwi9wD98CrEgakZegi42YI
         gzrYtH/0HRWoAK+5WYfwmVV1NpYrNp5gS6mnJHTwS2JRIEI214mVmHyI7yi1rd53q+W4
         3FqOAqM6imY4ONbFq2RhhcV0gQdRgW2GbF82RjfFbHI6zp1x2NgcTEs9MFweu0f9/1Ii
         aUdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756341010; x=1756945810;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JQQriFihIdlgv6YMIws6gyaIkwUMDRppRrS82dBz+Zw=;
        b=eoWfclKf7GvuNiB2SwefXUnv3ExaaW+8hRULJ/9zPk9H9mJ+qPQSN8Ik8w5E5AbmAK
         QFZmKjzFcF832MN4FKEMTpoqy2H7ryRUf3u2B3NZ8T3m2ycHlV5oqQ2k4p7WSzIvBfT7
         T7XjAXvVlx7381GSd4sxUSel0TUZ8tYPVCxfsxopifmi7rERoCbcz5VU62HzSCLuJS1s
         bmUWl3tkBa5Aapdwz2nRqJ+gJbm+EOWB87tO8lojsokXuklLPVtMjRvbGNlGPA5Ybt5N
         /VdCJlxM84M9dGcalexS0GCK939homyDsGQEOdNq5JopZ1a/NhbeyseAvPSPtf8DCr/J
         L+5Q==
X-Gm-Message-State: AOJu0YyzvK4gdHf9kBcZASaqbsv44TZOrer6FM92t12aikLV80tfeaxt
	vxeqWrOvBO5/bloGjpJ+oE/K0uDjx9OQ4aboSC3RulHteIpI/3IBvZbw8AKKxLSRn8ooy6ehHCj
	j+Q==
X-Google-Smtp-Source: AGHT+IFB42iFf2X16dB5SpgPtPk8Ckez+NS6FJ8J1tyo8xQjf3Jv1HlXEL4rw9Bc9NB7vz3ZZqmTTwZ/CQ==
X-Received: from pjbok3.prod.google.com ([2002:a17:90b:1d43:b0:321:abeb:1d8a])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1642:b0:31f:104f:e4b1
 with SMTP id 98e67ed59e1d1-32515e3c8f4mr27001654a91.7.1756341009888; Wed, 27
 Aug 2025 17:30:09 -0700 (PDT)
Date: Wed, 27 Aug 2025 17:30:06 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
Message-ID: <20250828003006.2764883-1-sagis@google.com>
Subject: [PATCH v3] KVM: TDX: Force split irqchip for TDX at irqchip creation time
From: Sagi Shahar <sagis@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, x86@kernel.org, 
	Sagi Shahar <sagis@google.com>, Xiaoyao Li <xiaoyao.li@intel.com>
Content-Type: text/plain; charset="UTF-8"

TDX module protects the EOI-bitmap which prevents the use of in-kernel
I/O APIC. See more details in the original patch [1]

The current implementation already enforces the use of split irqchip for
TDX but it does so at the vCPU creation time which is generally to late
to fallback to split irqchip.

This patch follows Sean's recommendation from [2] and adds a check if
I/O APIC is supported for the VM at irqchip creation time.

[1] https://lore.kernel.org/lkml/20250222014757.897978-11-binbin.wu@linux.intel.com/
[2] https://lore.kernel.org/lkml/aK3vZ5HuKKeFuuM4@google.com/

Suggested-by: Sean Christopherson <seanjc@google.com>
Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
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
2.51.0.268.g9569e192d0-goog


