Return-Path: <linux-kernel+bounces-814872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5633B559FC
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 01:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76550567088
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 23:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FD0285C9E;
	Fri, 12 Sep 2025 23:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kGFKMnVB"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120E0285073
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 23:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757719410; cv=none; b=ntSTaYOsnDvIESKFLEp1KzF7whO4RKA9s1OjDFmQuvnZDEaChZzJUnn7UrDKOQH+nqv4w+pGF24VdEq0TylBuVyVNrSr2TMbHB4tY3RbHApf1JyIJJA4BOR3z6JDMHRaFEkLAOPV15knA5MnD4jNyiPKn6DXiLVTEGFjIGijVfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757719410; c=relaxed/simple;
	bh=RfnrgBKDc/OWIfYX9gHpCwT3SRJavCRaCXwq1r24noI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gtI+0LvDfzHGnUYmUpYfedfLSGeO2snGokrX7jrqZnaVXobA1wSFe2hHzHAm9s5vMezFBvLSVFwZLw1XMv2tR/q5X7VhWWJNLDOTvnXVnXk/YKlKsrwMrhQVbaPjKbozLsgCsCXQMvk4rBI9SpQ+VTkKVKHP4NjXo76SQTyTCGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kGFKMnVB; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32dc9827f5bso2068643a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 16:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757719408; x=1758324208; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=NmaivxQVEFe0XO5/nxLfM/KLjMYMuYOEm/PE5vzh3LQ=;
        b=kGFKMnVBG9T55+Lr2DMRNn948eGl4O62VpI1k432qw0I/F7uqyypA7r2hXP32AXt53
         wCSCbtXzgxjfD8IR7c1rYblZpkGf7r4cy9QqbGeIy34rpR8qNnQG9bmCLV2LaW3sym7u
         iWaQJOI4UkcTXSF89w1ra9Yn6yN6dwWECNqy2ZsCTk8wUiWrxMGPD1u/z9zevipe73Q4
         /rOFaEpbh6j7AqGLmyjg1YN5mIaMcAfxyApv5iPZgXWW7NTo0qkGpbSi3O9+NR8DdpE9
         WisxfH8x+AWafYj4pQ4wTkcyZ0Kbv0kM7tWHYir+mkFaxsiQWmGhTfD+JD3hZ5ibPngM
         EK/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757719408; x=1758324208;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NmaivxQVEFe0XO5/nxLfM/KLjMYMuYOEm/PE5vzh3LQ=;
        b=hPj1/bWVtMK96N+TO9+zVyXeogIwbUdW2Z/iRVQEwlfC9Js5krEG3qL6THeH/5FLLR
         P4JsuRIP0xuwAhl9WumTaxZ8UwEsoAFoURGHyhkZWWbm6tar00FxZcF/CwFpD/rAUKIO
         AnnNYQFwWM2C89SGeJJSnpIzyJy0LcmojswjteLQTg7xoAsrzUIFkPXI7xC7yFL2PMWc
         vuu4/nlfG+yq20+lkPKTnKXmKUiFEMaXUwqSSBynu0DFSf8gUiCEFXS0XmKzeqO7c41K
         7axLe7Rw/yMtRT0hhNtaWqtQqu0LHrwuv014hkM6BKgJ5feBycXEtft6mAKsKaVOUrqE
         0y8A==
X-Forwarded-Encrypted: i=1; AJvYcCUuVik3wLSyjkzb0s9KnL08yetBTpE01+cwJxb92VzFIRSz6qLqezkH0Xp64VHCOF/422OIdk/RaaGpKW8=@vger.kernel.org
X-Gm-Message-State: AOJu0YywOmflF1IGpZIVg2CafCVNv07ASdo/w5rhJVypZQFffj2eO5VU
	FyFUn0OHIs9FEFdGEMnIzfuTtARLh5AbonggAQOQLECEF/Mf+9AYhjtg7XxBjXPjbb6KyJiGoT4
	XPHsb/g==
X-Google-Smtp-Source: AGHT+IEtFQQ6WoNpVHIEeKbNxUulKYbOustADM2+6byBPG/dE7g3o+WPUD48P0jF3XjgyBxyABZti1EuuNo=
X-Received: from pjh11.prod.google.com ([2002:a17:90b:3f8b:b0:327:dcfb:4ee1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1986:b0:249:1234:9f7c
 with SMTP id d9443c01a7336-25d2772a4damr41539885ad.60.1757719408305; Fri, 12
 Sep 2025 16:23:28 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Sep 2025 16:22:40 -0700
In-Reply-To: <20250912232319.429659-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250912232319.429659-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250912232319.429659-3-seanjc@google.com>
Subject: [PATCH v15 02/41] KVM: SEV: Read save fields from GHCB exactly once
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Mathias Krause <minipli@grsecurity.net>, 
	John Allen <john.allen@amd.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Chao Gao <chao.gao@intel.com>, Maxim Levitsky <mlevitsk@redhat.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Zhang Yi Z <yi.z.zhang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

Wrap all reads of GHCB save fields with READ_ONCE() via a KVM-specific
GHCB get() utility to help guard against TOCTOU bugs.  Using READ_ONCE()
doesn't completely prevent such bugs, e.g. doesn't prevent KVM from
redoing get() after checking the initial value, but at least addresses
all potential TOCTOU issues in the current KVM code base.

Opportunistically reduce the indentation of the macro-defined helpers and
clean up the alignment.

Fixes: 4e15a0ddc3ff ("KVM: SEV: snapshot the GHCB before accessing it")
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c |  8 ++++----
 arch/x86/kvm/svm/svm.h | 26 ++++++++++++++++----------
 2 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index fe8d148b76c0..37abbda28685 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3304,16 +3304,16 @@ static void sev_es_sync_from_ghcb(struct vcpu_svm *svm)
 	svm->vmcb->save.cpl = kvm_ghcb_get_cpl_if_valid(svm, ghcb);
 
 	if (kvm_ghcb_xcr0_is_valid(svm)) {
-		vcpu->arch.xcr0 = ghcb_get_xcr0(ghcb);
+		vcpu->arch.xcr0 = kvm_ghcb_get_xcr0(ghcb);
 		vcpu->arch.cpuid_dynamic_bits_dirty = true;
 	}
 
 	/* Copy the GHCB exit information into the VMCB fields */
-	exit_code = ghcb_get_sw_exit_code(ghcb);
+	exit_code = kvm_ghcb_get_sw_exit_code(ghcb);
 	control->exit_code = lower_32_bits(exit_code);
 	control->exit_code_hi = upper_32_bits(exit_code);
-	control->exit_info_1 = ghcb_get_sw_exit_info_1(ghcb);
-	control->exit_info_2 = ghcb_get_sw_exit_info_2(ghcb);
+	control->exit_info_1 = kvm_ghcb_get_sw_exit_info_1(ghcb);
+	control->exit_info_2 = kvm_ghcb_get_sw_exit_info_2(ghcb);
 	svm->sev_es.sw_scratch = kvm_ghcb_get_sw_scratch_if_valid(svm, ghcb);
 
 	/* Clear the valid entries fields */
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 5d39c0b17988..c2316adde3cc 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -913,16 +913,22 @@ void __svm_sev_es_vcpu_run(struct vcpu_svm *svm, bool spec_ctrl_intercepted,
 void __svm_vcpu_run(struct vcpu_svm *svm, bool spec_ctrl_intercepted);
 
 #define DEFINE_KVM_GHCB_ACCESSORS(field)						\
-	static __always_inline bool kvm_ghcb_##field##_is_valid(const struct vcpu_svm *svm) \
-	{									\
-		return test_bit(GHCB_BITMAP_IDX(field),				\
-				(unsigned long *)&svm->sev_es.valid_bitmap);	\
-	}									\
-										\
-	static __always_inline u64 kvm_ghcb_get_##field##_if_valid(struct vcpu_svm *svm, struct ghcb *ghcb) \
-	{									\
-		return kvm_ghcb_##field##_is_valid(svm) ? ghcb->save.field : 0;	\
-	}									\
+static __always_inline u64 kvm_ghcb_get_##field(struct ghcb *ghcb)			\
+{											\
+	return READ_ONCE(ghcb->save.field);						\
+}											\
+											\
+static __always_inline bool kvm_ghcb_##field##_is_valid(const struct vcpu_svm *svm)	\
+{											\
+	return test_bit(GHCB_BITMAP_IDX(field),						\
+			(unsigned long *)&svm->sev_es.valid_bitmap);			\
+}											\
+											\
+static __always_inline u64 kvm_ghcb_get_##field##_if_valid(struct vcpu_svm *svm,	\
+							   struct ghcb *ghcb)		\
+{											\
+	return kvm_ghcb_##field##_is_valid(svm) ? kvm_ghcb_get_##field(ghcb) : 0;	\
+}
 
 DEFINE_KVM_GHCB_ACCESSORS(cpl)
 DEFINE_KVM_GHCB_ACCESSORS(rax)
-- 
2.51.0.384.g4c02a37b29-goog


