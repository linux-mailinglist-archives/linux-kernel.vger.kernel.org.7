Return-Path: <linux-kernel+bounces-820341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ACB4B7F8E6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C10B1C03E58
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 09:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD5A343D91;
	Wed, 17 Sep 2025 09:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b="x/EcPSuU"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800DA3451D7
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 09:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758101321; cv=none; b=p38oCERUdXYtbdgZEU4BBqlEH+PHLcnTtbG7Pbj2hA4+nWg278Bp6i/TafQ6dRQjRtycmgqWS0m5zAYgWE0gkbSV5RKPDilM7ep5XJD4koil5B2krh/B+rOEtRnx85qUYUhFuRkPCMZLs1kqkAYDxiAO/DmoLp6yDLRikJlt4JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758101321; c=relaxed/simple;
	bh=Mapi4qRO18JNApuqaFmvuJzPJiuchg7jIC/0OT7vifs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DlAfiMuJYl5rJiS6G4dTUq/jndJ6AiIfQH0n4GuAaqZmgxBYKwI8Cv2zkEl12H8mJXMkdhEpxyDy+kVTUsp0IZbCVYMFQs7hhOhp3Qo6JXfwCe+wiIWgZK4RmRSuXR+HiNJPdbT7+ZO5zuW3UEAH9YYSSF1t2SoNIjdyvlz5iQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b=x/EcPSuU; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-251fc032d1fso72712155ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 02:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1758101318; x=1758706118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8j1xWi8yHO61hmZJR2yMfuKWLMhG/TRDNgL+UU0ZcBE=;
        b=x/EcPSuU+lAPQL78GTrl1pLUr5KZEhTRcU0MB58zX/PfF3F9bIFaSwLSUUnIOCIJnU
         xnHDihNrJqNp2k+LUuqspEk/lHSjDPIW3BtCa866rY11mUYR2hN4coQpftxS6oTXzcaW
         qSaM3C1bUlOz5HrY/9UX4FCeTYqMK7ciol7n3E2/Pd1j67RAEbqaF3xIZKHay6UY5ebY
         eSvbrMmj5cBJhMcmLKUN4Eta5ESAwyYfGYbfugbUO2yuWfqybVegQhjRQ+aXIinqP7dL
         dLL4cm9akoWhNBJ+6Yx3awmFZEnFXfMisRcwb63fNuCsP4m9PDFYklPab3QFYnP5ZWxx
         jyhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758101318; x=1758706118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8j1xWi8yHO61hmZJR2yMfuKWLMhG/TRDNgL+UU0ZcBE=;
        b=k2mNXV6cGovR/F5Uxnv4/wlPObtJiomqfWNsERsAUx6UEg8zWvKFh77h9JbCBgxU/Z
         2GX/9dHImD+rw934iBl+ezis3O1gDXGtI4fqM3y/VJIPQW8dRrrn6IWKr3HOlORAuvqg
         g9Op+mJNyadJCa1F14JqstU3v3YZgU+/hkhA3CYTjjV3JQxlbHVVTB0khvL0FNgg0jOh
         i+JydkZCkpUitsBgqkhuNWkFzfknu9ldhyiHd60su9/12c+yuOZIKR41MIT0liWM/drk
         W9C5ekOzLmRKoMktMv6eeEqnhApcq9SIwkOZeXS/+km9S0fFmQbRsriZOQ5gZ+DIsQba
         YtMg==
X-Forwarded-Encrypted: i=1; AJvYcCVlw+7VinUzO7OzFrck2YvobiwNmzmh3GGzdf4HC7DBhvxkK8z6z+7bbqBnluzWkC9gls2GNnWvlCMbFe4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ+ZuXJR3J2yLGr+RQKYMC3qv2blq7QroFQ/0BifwqIsVBd4se
	BofBZUcHVepxaqcKjHv3XyBt1UYHKNtVPHJgiP4CW4Fs2xAFY+1biL0HnCrqBNKAKps=
X-Gm-Gg: ASbGncu0xbWThR759EHs2IvjZ9q7bd1RKG+9wwHIgtf66CGOS7diCwTrhGHxQO85Q6m
	qKRUGDNhtoVppEvQJkLzsTcBeUZmOEZfRF/HRq6rAlRiRPtbzNy+j6LXiMvRbNrdhuzL9X/SBkr
	AoajcW4F1Pb2Y1LKuemaWNb0e+Mk9+fpnQa1w8owGoUdtd0ARpSRXlhhPtERR46HE7+ehi9I5Vb
	hXNYjTPITiM1AizL2EL1+BNkhbS/dqs0+aavwX0lLnnhg3kKyQXSQiakPwQ93DYwMdhBO+/mDXs
	U+/lXcipOuBrAIMbEaulO4YCLs+oPekm6boYFjL60k9iJsaRuxPAY07kVZf9FAGoFYPq6+C7cF5
	L7pc/JAQm+hJfv2zAEY2lt2Ed4kbukgwU+Jx82Lm4okqjTCHs0jo=
X-Google-Smtp-Source: AGHT+IGrUlWL0tzfLtquvrJRbqTi99ooOO3SYsnEAMGANiYtwIWUXXJnYFIYJ1snMKEuZ1H2K+q1RA==
X-Received: by 2002:a17:903:3585:b0:259:5284:f87b with SMTP id d9443c01a7336-26811e87273mr18453755ad.16.1758101317378;
        Wed, 17 Sep 2025 02:28:37 -0700 (PDT)
Received: from localhost.localdomain ([193.246.161.124])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25f4935db09sm137047885ad.61.2025.09.17.02.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 02:28:37 -0700 (PDT)
From: Lei Chen <lei.chen@smartx.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v1 1/3] Revert "x86: kvm: introduce periodic global clock updates"
Date: Wed, 17 Sep 2025 17:28:22 +0800
Message-ID: <20250917092824.4070217-2-lei.chen@smartx.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250917092824.4070217-1-lei.chen@smartx.com>
References: <20250917092824.4070217-1-lei.chen@smartx.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit 332967a3eac06f6379283cf155c84fe7cd0537c2.

Commit 332967a3eac0 ("x86: kvm: introduce periodic global clock
updates") introduced a 300s interval work to sync ntp corrections
across all vcpus.

Since commit 53fafdbb8b21 ("KVM: x86: switch KVMCLOCK base to
monotonic raw clock"), kvmclock switched to mono raw clock,
we can no longer take ntp into consideration.

Signed-off-by: Lei Chen <lei.chen@smartx.com>
---
 arch/x86/include/asm/kvm_host.h |  1 -
 arch/x86/kvm/x86.c              | 25 -------------------------
 2 files changed, 26 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index f19a76d3ca0e..e41e4fe91f5e 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1436,7 +1436,6 @@ struct kvm_arch {
 	u64 master_kernel_ns;
 	u64 master_cycle_now;
 	struct delayed_work kvmclock_update_work;
-	struct delayed_work kvmclock_sync_work;
 
 #ifdef CONFIG_KVM_HYPERV
 	struct kvm_hv hyperv;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index a1c49bc681c4..399045a384d4 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -157,9 +157,6 @@ EXPORT_SYMBOL_GPL(report_ignored_msrs);
 unsigned int min_timer_period_us = 200;
 module_param(min_timer_period_us, uint, 0644);
 
-static bool __read_mostly kvmclock_periodic_sync = true;
-module_param(kvmclock_periodic_sync, bool, 0444);
-
 /* tsc tolerance in parts per million - default to 1/2 of the NTP threshold */
 static u32 __read_mostly tsc_tolerance_ppm = 250;
 module_param(tsc_tolerance_ppm, uint, 0644);
@@ -3439,20 +3436,6 @@ static void kvm_gen_kvmclock_update(struct kvm_vcpu *v)
 					KVMCLOCK_UPDATE_DELAY);
 }
 
-#define KVMCLOCK_SYNC_PERIOD (300 * HZ)
-
-static void kvmclock_sync_fn(struct work_struct *work)
-{
-	struct delayed_work *dwork = to_delayed_work(work);
-	struct kvm_arch *ka = container_of(dwork, struct kvm_arch,
-					   kvmclock_sync_work);
-	struct kvm *kvm = container_of(ka, struct kvm, arch);
-
-	schedule_delayed_work(&kvm->arch.kvmclock_update_work, 0);
-	schedule_delayed_work(&kvm->arch.kvmclock_sync_work,
-					KVMCLOCK_SYNC_PERIOD);
-}
-
 /* These helpers are safe iff @msr is known to be an MCx bank MSR. */
 static bool is_mci_control_msr(u32 msr)
 {
@@ -12327,8 +12310,6 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 
 void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
 {
-	struct kvm *kvm = vcpu->kvm;
-
 	if (mutex_lock_killable(&vcpu->mutex))
 		return;
 	vcpu_load(vcpu);
@@ -12339,10 +12320,6 @@ void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
 	vcpu->arch.msr_kvm_poll_control = 1;
 
 	mutex_unlock(&vcpu->mutex);
-
-	if (kvmclock_periodic_sync && vcpu->vcpu_idx == 0)
-		schedule_delayed_work(&kvm->arch.kvmclock_sync_work,
-						KVMCLOCK_SYNC_PERIOD);
 }
 
 void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
@@ -12722,7 +12699,6 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 #endif
 
 	INIT_DELAYED_WORK(&kvm->arch.kvmclock_update_work, kvmclock_update_fn);
-	INIT_DELAYED_WORK(&kvm->arch.kvmclock_sync_work, kvmclock_sync_fn);
 
 	kvm_apicv_init(kvm);
 	kvm_hv_init_vm(kvm);
@@ -12830,7 +12806,6 @@ void kvm_arch_pre_destroy_vm(struct kvm *kvm)
 	 * is unsafe, i.e. will lead to use-after-free.  The PIT also needs to
 	 * be stopped before IRQ routing is freed.
 	 */
-	cancel_delayed_work_sync(&kvm->arch.kvmclock_sync_work);
 	cancel_delayed_work_sync(&kvm->arch.kvmclock_update_work);
 
 #ifdef CONFIG_KVM_IOAPIC
-- 
2.44.0


