Return-Path: <linux-kernel+bounces-776083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD638B2C853
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 17:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22A7F7A8F2B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F3128C849;
	Tue, 19 Aug 2025 15:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b="ruUSWohB"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26A328750D
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 15:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755616846; cv=none; b=Sa79YWBUCE9qKVYg7Oo/+MGhNtnpskpHxpVndCUMuQwacXG8g59mjip2ve5jN6Ui8pM28qaLmfcW58R+gjUxhBARGYbXQ3gjXt/H8wAZys+X8e/FMD/n7aKS/ONf+yta4iLupa9HBfKjN7g1BY56IXRrEPaKe1bhsLg2LtilXnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755616846; c=relaxed/simple;
	bh=eUrR4NP72EKznEUzfrQ6RmdmdpoU6ltR0MbO4Ojo8Yg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S/hSdvSQR8oPh3wsYLkK+IqJng52ZAhX+EiqLin7DqlEjKxHQBnKRJ9uJ92N5Y/VwCu72Nj0oAAN1blJIVFBrgvRpTJa9ddNVf+E7PfykfiDnLPoonxMMCs5l3YuvXERLKpjkF++ytLPTd+WIAsHAMaggL9e2R2IqQY/DcrF3Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b=ruUSWohB; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-76e2eb6d07bso4606413b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 08:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1755616843; x=1756221643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2lSDpgMZajVKYY0uCSDb90s/Pt+KK5ftnBEiQn/IXqA=;
        b=ruUSWohBwJyBmTuk07GSs/ZfoQzBcQKPYXC6uxe7QBdDDx1AGvtYLFzR9CD+Df7frS
         H8TRuvEWThWuqjJ+WagRIC7pdf4qqASgV/43dpsHNe+FCEcTlvtRalCmJXo7rF9aiLs0
         nakBLSEGBVe/ZGv1EHPNhPpTCWQ1+9D+CChpktKN2Vdy/ReMU8aHG2YwXHTNpl+3+Kgf
         s2VeJ+Zriwumk1C42Vc2Y5/UDZQLRd2iHQG6vWc+xDO1Krk/VZ1iTYtoTaY0Qp5gt2GA
         3aifJ7xl0gt0afHyRQ1Ahf5aivpjTW8LbvnZp7lesKs3Y9vW/t+TDWke12YeCowcAMit
         /shQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755616843; x=1756221643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2lSDpgMZajVKYY0uCSDb90s/Pt+KK5ftnBEiQn/IXqA=;
        b=xJJ18ePvMrSu2bEsnZtaYjYN5DhTUr9P3+XK92YN9lfTrZfc5MWZuJC5kZpAu6NBZO
         7OVKBF6KH/F5ymZ8V/f+WdmXvZLcr7QB/dQc37QpmDHC7B+KUSpPk2Z+etYkEQ05ifgW
         yVXb4Y9t3OpX9fsfTi0itpXXaoM68z00jj61886Bu2YoHIy/RH2lXtzYkG6qMk1B5vmr
         c1dzaNu4vxO/ghf7tYupo3hIwJFjqnEiE9z+KJwKMcTR7ajqCpt037pI4zXTFsT1vPMR
         QqiqTdUzdE+AMRlQdVrobqNaF2B+zF8qSOTiYj1WuUiANhDv+uBqtZDrekC9LR4fGW52
         plOg==
X-Forwarded-Encrypted: i=1; AJvYcCXrQs8CEYbbgnUOM9pay2HZlRsODgrUx2aNdm1E6P3zw0TBZ8ibyJgoZesTTVDtRlikgEDjqbEwPN+46Co=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwtlYqKbHfncoNcWw0V54YYKZbjji3QTm87S1vlxVOCi9gjWUa
	zEvzy5iuaEi0mEz2gcLnPLYeu8Qg+KhS7acydAW4pA6KKViXeZk+8V9CRugy1OcBOdY=
X-Gm-Gg: ASbGncvM1UnEBhtrbAMwkTHAkJnjHvQ5+ol/qvSyBY/hjZSealz5vRF4B7YbQ08vUAG
	gGxoqxYtW3SfMs5OfPxZSDbb01KNFBlW+bvELvRRPTLYevbouErMYV2gxiuiDPpnNXehdgJQyOb
	K/XlWOuo7tfgjy6h5PbOqCB+63bituxxM3ExJHKabiMoyzDRgWr3oxLF8KDJvqRQfD9x2fUZt4K
	xKfOloim+dQZwQbAu8/G/eMvqW4D1cI6uXllL8/0iZhaaeL/7sAX2cXLEGJVukoIM97Yf837k7E
	0PwjTSihRq9AL6qPTt4bVdtyUgPoJiIkO1OJiXBlpvOeZI6etj1zSOnYaeHyXvSjSW4jIdBzjvN
	M7C54PnvoBaHaIl5sv4M0FnWmEAyYw3YQzQeyJw==
X-Google-Smtp-Source: AGHT+IET1fYCsA43ScR7Gl7o0QqueeZxCmd7tup9t4LlIjJFy4GsUQxo56fJU5lQZ9Qa7DgyluOoXg==
X-Received: by 2002:a05:6a00:2d29:b0:76c:3751:dfbe with SMTP id d2e1a72fcca58-76e8114636cmr4179133b3a.24.1755616842845;
        Tue, 19 Aug 2025 08:20:42 -0700 (PDT)
Received: from localhost.localdomain ([193.246.161.124])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d546ce3sm2771227b3a.103.2025.08.19.08.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 08:20:42 -0700 (PDT)
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
Subject: [PATCH v1 2/3] Revert "x86: kvm: rate-limit global clock updates"
Date: Tue, 19 Aug 2025 23:20:26 +0800
Message-ID: <20250819152027.1687487-3-lei.chen@smartx.com>
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

This reverts commit 7e44e4495a398eb553ce561f29f9148f40a3448f.

Commit 7e44e4495a39 ("x86: kvm: rate-limit global clock updates")
intends to use a kvmclock_update_work to sync ntp corretion
across all vcpus kvmclock, which is based on commit 0061d53daf26f
("KVM: x86: limit difference between kvmclock updates")

Since kvmclock has been switched to mono raw, this commit can be
reverted.

Signed-off-by: Lei Chen <lei.chen@smartx.com>
---
 arch/x86/include/asm/kvm_host.h |  1 -
 arch/x86/kvm/x86.c              | 29 ++++-------------------------
 2 files changed, 4 insertions(+), 26 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index e41e4fe91f5e..0a1165f40ff1 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1435,7 +1435,6 @@ struct kvm_arch {
 	bool use_master_clock;
 	u64 master_kernel_ns;
 	u64 master_cycle_now;
-	struct delayed_work kvmclock_update_work;
 
 #ifdef CONFIG_KVM_HYPERV
 	struct kvm_hv hyperv;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 399045a384d4..d526e9e285f1 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3404,22 +3404,14 @@ uint64_t kvm_get_wall_clock_epoch(struct kvm *kvm)
  * the others.
  *
  * So in those cases, request a kvmclock update for all vcpus.
- * We need to rate-limit these requests though, as they can
- * considerably slow guests that have a large number of vcpus.
- * The time for a remote vcpu to update its kvmclock is bound
- * by the delay we use to rate-limit the updates.
+ * The worst case for a remote vcpu to update its kvmclock
+ * is then bounded by maximum nohz sleep latency.
  */
-
-#define KVMCLOCK_UPDATE_DELAY msecs_to_jiffies(100)
-
-static void kvmclock_update_fn(struct work_struct *work)
+static void kvm_gen_kvmclock_update(struct kvm_vcpu *v)
 {
 	unsigned long i;
-	struct delayed_work *dwork = to_delayed_work(work);
-	struct kvm_arch *ka = container_of(dwork, struct kvm_arch,
-					   kvmclock_update_work);
-	struct kvm *kvm = container_of(ka, struct kvm, arch);
 	struct kvm_vcpu *vcpu;
+	struct kvm *kvm = v->kvm;
 
 	kvm_for_each_vcpu(i, vcpu, kvm) {
 		kvm_make_request(KVM_REQ_CLOCK_UPDATE, vcpu);
@@ -3427,15 +3419,6 @@ static void kvmclock_update_fn(struct work_struct *work)
 	}
 }
 
-static void kvm_gen_kvmclock_update(struct kvm_vcpu *v)
-{
-	struct kvm *kvm = v->kvm;
-
-	kvm_make_request(KVM_REQ_CLOCK_UPDATE, v);
-	schedule_delayed_work(&kvm->arch.kvmclock_update_work,
-					KVMCLOCK_UPDATE_DELAY);
-}
-
 /* These helpers are safe iff @msr is known to be an MCx bank MSR. */
 static bool is_mci_control_msr(u32 msr)
 {
@@ -12698,8 +12681,6 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	kvm->arch.hv_root_tdp = INVALID_PAGE;
 #endif
 
-	INIT_DELAYED_WORK(&kvm->arch.kvmclock_update_work, kvmclock_update_fn);
-
 	kvm_apicv_init(kvm);
 	kvm_hv_init_vm(kvm);
 	kvm_xen_init_vm(kvm);
@@ -12806,8 +12787,6 @@ void kvm_arch_pre_destroy_vm(struct kvm *kvm)
 	 * is unsafe, i.e. will lead to use-after-free.  The PIT also needs to
 	 * be stopped before IRQ routing is freed.
 	 */
-	cancel_delayed_work_sync(&kvm->arch.kvmclock_update_work);
-
 #ifdef CONFIG_KVM_IOAPIC
 	kvm_free_pit(kvm);
 #endif
-- 
2.44.0


