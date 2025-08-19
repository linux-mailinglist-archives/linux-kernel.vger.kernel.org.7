Return-Path: <linux-kernel+bounces-776082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70019B2C858
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 17:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 006A31BA706A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6E8286409;
	Tue, 19 Aug 2025 15:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b="Z+bDDOE4"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A679B2848BE
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 15:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755616841; cv=none; b=WfiNgQZhWjHPPFwxN+PUzTeKBqhwbt3lno+Fd8D6c+bMxk3Nlj3d8Z2ECO+u8eLcBt5FlNWc+Y7/X4OSfwyYTX3ZYXty70mkeXu+NiyLfmlp9dKum2Pjo0af6GplmL9CZUYHa7oiTOUZ6K9q2n5oU8BrSz2gbmhFcYYrD/DQUhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755616841; c=relaxed/simple;
	bh=Mapi4qRO18JNApuqaFmvuJzPJiuchg7jIC/0OT7vifs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rm750J0dlMJwlyIdmqjLJz5eAWsI1yl7bakeGh3GXWg9HHHHtwVlv8ZJWesFGXvwFpZUAjSmqoM+8tRlUvx0maYqcHakt+w/7mfzge8mkA5FXye/NneaevIgMdv9uHDQU4U5avzfax8jJ8T5sSuoGITPWNSzo6mdgxBsxIPRTY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b=Z+bDDOE4; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b474e8d6d04so1400702a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 08:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1755616839; x=1756221639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8j1xWi8yHO61hmZJR2yMfuKWLMhG/TRDNgL+UU0ZcBE=;
        b=Z+bDDOE4OkQ7j2GMMGtCq60C99LHGpkrUWJXg0JVbYaZ8Gge5jizq6yRAGevKCaCem
         ZpyYCSkrNEy1yLynNKtBLESZeF7dJCZCLGy5sfw4N1ugUVUQLrovUSk/LmS9mFV6HViB
         0sq75sNUsU1/97gkL8TYsHBPdjD7U7bLQ/2pZNyGggxDTnehqgOckR1ZPmyWPDBXRMko
         LRlSlutSS7kDutOgyz826TBA2Up4O225ImwgXs9j3PFL+p03VaKxIM7xrrmtbCVQqD3y
         nsFy2CaBcPQIqko2uRTLFnnjjfHk14UK1Rp+K9Mf8e7R3YpQf6ztiSsmIgGekdWFT0iE
         Hixw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755616839; x=1756221639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8j1xWi8yHO61hmZJR2yMfuKWLMhG/TRDNgL+UU0ZcBE=;
        b=GYhQMcQzCUj746mrJkg854EflxXe+9Akbvn+Ad99td/5Er779Ai1oK28grPHUOS6TY
         Gbi4ABi4o6bE6sjQ2v1LyilqM+Rk750UmsIm6tdz8KfCEHDzpzleVLZwWjvtc28M1z3W
         b/AuFUqn2AYZRy6OUDoWnhd8fmg2naIfV0chupZFq4KwooNe/MhP1aFe2uoCKl45fBgh
         zqmrVgU5q9WH38x8+WOYDim9KyRSum2iUT2yoodx4V2PJmo6JyRmOdUXk0eh6Tq8CX04
         tCa4ypB9OjQsQPVx3a6XuwZxSXSpIcZxyJXcP8oGuapxDNsWn2+XtNaH3ofH8sCypYA3
         SF2w==
X-Forwarded-Encrypted: i=1; AJvYcCWDxDu438mk5bQ3vhb701JI8rI8RM9E9iTQHm6f4YaCcYcer4JOeOlUB/wzNXG41pej+QiBOs5SJ6Bnx0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX7e7LpORsEJ97Ii93XR5XRxFp4fU8D6geg17O41oHhbyZRIo1
	0zXYEcEbYcY5J/wg54cVZlZr/QxBjUNp6B+myNpT8iNNj/NXfWBKpz87GYRSomdOM8U=
X-Gm-Gg: ASbGncsFwoxRjusuzroJ2CHAITZSpZf3bHsICAruo3CO8+pXvne2rVxtsWZUNJ1brKh
	uJDn/Sp5Xd56M9JqIB43OLFVHlExa6yme28O5iCdXGC0nyZW6B4WFWJhSr+p2jO8m+qwd0m68gP
	dxBe4Fr5agaEbIRNezODSnOYTY93dXea0GHOnvdCwJEEPbDBFbGocvIPb9jL1qBLug77Z0u1+/v
	jbPNB7quRaAxla75HQ2qIz36/o/iza5fS4TXGckBmPMmjJrjspU5rupxC+Vb5A54s5ALCuWwJOU
	q5bF4mM3PjaNonVubUKMVhA+Ahb9ZW3QE2EO6blcgAjOVp25y+6JwPo+tzGEyivb0nNyrVZXogU
	ve53/qE9fLd+6SiKjZTYgcTqyJNpc4iYqScLarjEuC3vUrSrw
X-Google-Smtp-Source: AGHT+IGQa/VvJVkJJiZS7k0VwFXOIzUvBZHkf8rJfdNj/RWnzCw/C6sQLoqqWJnZZtjkykT3dQtZDA==
X-Received: by 2002:a05:6a20:918a:b0:23f:fa6e:912a with SMTP id adf61e73a8af0-2430d395366mr4209750637.16.1755616838689;
        Tue, 19 Aug 2025 08:20:38 -0700 (PDT)
Received: from localhost.localdomain ([193.246.161.124])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d546ce3sm2771227b3a.103.2025.08.19.08.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 08:20:38 -0700 (PDT)
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
Subject: [PATCH v1 1/3] Revert "x86: kvm: introduce periodic global clock updates"
Date: Tue, 19 Aug 2025 23:20:25 +0800
Message-ID: <20250819152027.1687487-2-lei.chen@smartx.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250819152027.1687487-1-lei.chen@smartx.com>
References: <20250819152027.1687487-1-lei.chen@smartx.com>
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


