Return-Path: <linux-kernel+bounces-749973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71AB8B15585
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 00:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55F307B25D3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 22:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F12D28D849;
	Tue, 29 Jul 2025 22:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KyUDf0s0"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4175E289358
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 22:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753829740; cv=none; b=UQ8n3+Pl05JU3xzDCOorcQ0hLxKTCoTmlU+jn4ZJkcuRKRy/1P8FqcQS+yYd/Bxnc8E1+UzyYsIYxsivM66ng/ZhpFCYglpdCqPM5Mhpo+3HkdlGo7tHPAujU43AmF8sQOmiJ7Wa8VeY11ri93IIXy7Fp6SWfKcY5b5jCA+U+P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753829740; c=relaxed/simple;
	bh=1G471Ztcvd9/EAbr4zfSr/Pr5YCZ5sKUbrndZzoQZd4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OicUnRX9rWR/WCaH5RZq9y1v/hCl9tTbyY+UGxXIKkmZUjJ2wsGqT1zMO2p4ircyTZEpbo1ngynMME9o0tUk7DWeRHBkUWf9j0LnC0CIgINy6GNyGKozD4ynTw+cUPdW/kSj2ggHcvZ8SIESZ9TkPhjYkSWK2l2KhIyhmRQNYQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KyUDf0s0; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-74928291bc3so273965b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 15:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753829738; x=1754434538; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=c+/NMJmsylkoBC4gWvcEbFQsUKJfGfTOY8uMnbEW6yY=;
        b=KyUDf0s06ujqQk4L9p5Ti0L/wUVVDdTLz2Wh9UVhJ0p3zMAUlcAeFK8f7uBJeJqjTC
         5+DfNJw2ULMH+WoiIfktqHb9jyknIKLrva+BOKwGc+8jhnCt2Cl/vH5jgLKYIxKEzi46
         vHjMspaIn8w8KMjbtsSB2P08s1v2NF5jrrSqOumdlf3VbhczRNvlCl9KUml0WsBl8WNr
         zoRc4XogBSoef4vyPeKFh8FA26dxlWO7hq95106jpynuz4f4dRlKx8XuItDGl4bZR6Ju
         tLc8fMWzJnCXQ3u2IafS39pGhbFoDZl0i7mUjul4IuFkhiM2LVm1yP6SSeXC9gQnkStj
         ZB7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753829738; x=1754434538;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c+/NMJmsylkoBC4gWvcEbFQsUKJfGfTOY8uMnbEW6yY=;
        b=BhG21uepPrFsyl7TKdPiyyjLpI2ERi64dV29rHb6NUb6Zq0Mlgs2QtfkSrXNfTwC5B
         qkuuFLowYKlMqo1fnnFuVneOaURnI4adD7OWbayPvWl18wSigfYf7Sn4i1JfyE4ZKdCo
         V+ari9Zn+VIyeemx1auwH3MZe7N6jPw/aPrkn28XqjZXVLx5V6N+aTHF40fmbOdt/Jdt
         4STZhuI8ODS8ospj9X9JC7UmW9hXBCp4xGSzdr1mzy3NLPgMAbh47nKzmCXPC4KjUWya
         Ne96U0yHYA8oHCGEPc37yxvCBwLTMTI+HVv1wF4PEI8IHD+m/yWOi+7Ca5BdScTC9Cpp
         T01g==
X-Forwarded-Encrypted: i=1; AJvYcCWwfYsv7wDXIVwVK3d53kQYf1LFbweo2JCdJVLCRCTYJpYiX1t4Xgmh11pMgZvKGC3b3B6KUCeM6yAYKQg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy8izjrwp0QXAfUdtliZQOvBWcrRuNc/zjqPt8FCMITpl5CEAt
	LbZHWsT2od1vg4L7WilI3vipGweRhcCh6pAAL/0v16T6U2f/wZkx4QMAmUFyzr8QFk61/WZr+XP
	w3GTJdg==
X-Google-Smtp-Source: AGHT+IH4iSr5KwLJmRVqnNug5aDy8pe70mqGviSCJM20Gbtyqe1yxZEdeYq4VIFoxas+vnB8AcFiz0D+NEw=
X-Received: from pfbhm20.prod.google.com ([2002:a05:6a00:6714:b0:748:f270:c438])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:aa7:88d1:0:b0:74b:4d96:d159
 with SMTP id d2e1a72fcca58-76aad77f4d6mr1711853b3a.0.1753829738459; Tue, 29
 Jul 2025 15:55:38 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 29 Jul 2025 15:54:36 -0700
In-Reply-To: <20250729225455.670324-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250729225455.670324-1-seanjc@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250729225455.670324-6-seanjc@google.com>
Subject: [PATCH v17 05/24] KVM: Rename CONFIG_KVM_GENERIC_PRIVATE_MEM to CONFIG_HAVE_KVM_ARCH_GMEM_POPULATE
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Ira Weiny <ira.weiny@intel.com>, Gavin Shan <gshan@redhat.com>, Shivank Garg <shivankg@amd.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Xiaoyao Li <xiaoyao.li@intel.com>, 
	David Hildenbrand <david@redhat.com>, Fuad Tabba <tabba@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Tao Chan <chentao@kylinos.cn>, 
	James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Fuad Tabba <tabba@google.com>

The original name was vague regarding its functionality. This Kconfig
option specifically enables and gates the kvm_gmem_populate() function,
which is responsible for populating a GPA range with guest data.

The new name, HAVE_KVM_ARCH_GMEM_POPULATE, describes the purpose of the
option: to enable arch-specific guest_memfd population mechanisms. It
also follows the same pattern as the other HAVE_KVM_ARCH_* configuration
options.

This improves clarity for developers and ensures the name accurately
reflects the functionality it controls, especially as guest_memfd
support expands beyond purely "private" memory scenarios.

Temporarily keep KVM_GENERIC_PRIVATE_MEM as an x86-only config so as to
minimize churn, and to hopefully make it easier to see what features
require HAVE_KVM_ARCH_GMEM_POPULATE.  On that note, omit GMEM_POPULATE
for KVM_X86_SW_PROTECTED_VM, as regular ol' memset() suffices for
software-protected VMs.

As for KVM_GENERIC_PRIVATE_MEM, a future change will select KVM_GUEST_MEMFD
for all 64-bit KVM builds, at which point the intermediate config will
become obsolete and can/will be dropped.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Shivank Garg <shivankg@amd.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Co-developed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Fuad Tabba <tabba@google.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/Kconfig     | 14 ++++++++++----
 include/linux/kvm_host.h |  2 +-
 virt/kvm/Kconfig         |  9 ++++-----
 virt/kvm/guest_memfd.c   |  2 +-
 4 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index 13ab7265b505..c763446d9b9f 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -79,11 +79,16 @@ config KVM_WERROR
 
 	  If in doubt, say "N".
 
+config KVM_X86_PRIVATE_MEM
+	select KVM_GENERIC_MEMORY_ATTRIBUTES
+	select KVM_GUEST_MEMFD
+	bool
+
 config KVM_SW_PROTECTED_VM
 	bool "Enable support for KVM software-protected VMs"
 	depends on EXPERT
 	depends on KVM_X86 && X86_64
-	select KVM_GENERIC_PRIVATE_MEM
+	select KVM_X86_PRIVATE_MEM
 	help
 	  Enable support for KVM software-protected VMs.  Currently, software-
 	  protected VMs are purely a development and testing vehicle for
@@ -133,8 +138,8 @@ config KVM_INTEL_TDX
 	bool "Intel Trust Domain Extensions (TDX) support"
 	default y
 	depends on INTEL_TDX_HOST
-	select KVM_GENERIC_PRIVATE_MEM
-	select KVM_GENERIC_MEMORY_ATTRIBUTES
+	select KVM_X86_PRIVATE_MEM
+	select HAVE_KVM_ARCH_GMEM_POPULATE
 	help
 	  Provides support for launching Intel Trust Domain Extensions (TDX)
 	  confidential VMs on Intel processors.
@@ -157,9 +162,10 @@ config KVM_AMD_SEV
 	depends on KVM_AMD && X86_64
 	depends on CRYPTO_DEV_SP_PSP && !(KVM_AMD=y && CRYPTO_DEV_CCP_DD=m)
 	select ARCH_HAS_CC_PLATFORM
-	select KVM_GENERIC_PRIVATE_MEM
+	select KVM_X86_PRIVATE_MEM
 	select HAVE_KVM_ARCH_GMEM_PREPARE
 	select HAVE_KVM_ARCH_GMEM_INVALIDATE
+	select HAVE_KVM_ARCH_GMEM_POPULATE
 	help
 	  Provides support for launching encrypted VMs which use Secure
 	  Encrypted Virtualization (SEV), Secure Encrypted Virtualization with
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 8cdc0b3cc1b1..ddfb6cfe20a6 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2534,7 +2534,7 @@ static inline int kvm_gmem_get_pfn(struct kvm *kvm,
 int kvm_arch_gmem_prepare(struct kvm *kvm, gfn_t gfn, kvm_pfn_t pfn, int max_order);
 #endif
 
-#ifdef CONFIG_KVM_GENERIC_PRIVATE_MEM
+#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_POPULATE
 /**
  * kvm_gmem_populate() - Populate/prepare a GPA range with guest data
  *
diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
index e4b400feff94..1b7d5be0b6c4 100644
--- a/virt/kvm/Kconfig
+++ b/virt/kvm/Kconfig
@@ -116,11 +116,6 @@ config KVM_GUEST_MEMFD
        select XARRAY_MULTI
        bool
 
-config KVM_GENERIC_PRIVATE_MEM
-       select KVM_GENERIC_MEMORY_ATTRIBUTES
-       select KVM_GUEST_MEMFD
-       bool
-
 config HAVE_KVM_ARCH_GMEM_PREPARE
        bool
        depends on KVM_GUEST_MEMFD
@@ -128,3 +123,7 @@ config HAVE_KVM_ARCH_GMEM_PREPARE
 config HAVE_KVM_ARCH_GMEM_INVALIDATE
        bool
        depends on KVM_GUEST_MEMFD
+
+config HAVE_KVM_ARCH_GMEM_POPULATE
+       bool
+       depends on KVM_GUEST_MEMFD
diff --git a/virt/kvm/guest_memfd.c b/virt/kvm/guest_memfd.c
index 7d85cc33c0bb..b2b50560e80e 100644
--- a/virt/kvm/guest_memfd.c
+++ b/virt/kvm/guest_memfd.c
@@ -627,7 +627,7 @@ int kvm_gmem_get_pfn(struct kvm *kvm, struct kvm_memory_slot *slot,
 }
 EXPORT_SYMBOL_GPL(kvm_gmem_get_pfn);
 
-#ifdef CONFIG_KVM_GENERIC_PRIVATE_MEM
+#ifdef CONFIG_HAVE_KVM_ARCH_GMEM_POPULATE
 long kvm_gmem_populate(struct kvm *kvm, gfn_t start_gfn, void __user *src, long npages,
 		       kvm_gmem_populate_cb post_populate, void *opaque)
 {
-- 
2.50.1.552.g942d659e1b-goog


