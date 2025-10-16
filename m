Return-Path: <linux-kernel+bounces-857029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E3CBE5AE7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 00:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ED0744FA6B5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 22:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33ADD2E7F39;
	Thu, 16 Oct 2025 22:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IbUv9tYg"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40AC2E6CC6
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 22:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760653708; cv=none; b=mQiyrFo3nLZdI8k8e+fSnlOPrxvLefOO+4CLhh/9iI80ZjyM0oD+gu4TT+sfbVorO5IoV71IoiwpLxSv0flvU43d3psTwT9pW5imHuhcL2AdZXppFDGew36Rw5At59V56cxXaREEMTRjrCjqKxv0iT/mpUr1xDLJSwla+3GJAmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760653708; c=relaxed/simple;
	bh=Jokj5W6CeBHblVuzEDrKOj9gCUGQHizkOYZDNZwqk7w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qKlb6Vuz+MtFjhnhpVc8jpyHMV5zvcZeo4dzTq25SwoUqTRJTiwr8aMrN1AiVE6ahi9Hhr6DC89275wAEsPQy7tH/vtzWKV7Nu6RBjmgvTd7fRv4qumdwt24TOKO97GibWfRo/qqZ6DIHiecPHDy0oO4y4IkpH/rLQ7NbanbR40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IbUv9tYg; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-28c58e009d1so23636395ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 15:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760653704; x=1761258504; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=WFE7ffxV7H5+bRxN9E59RGE5SAa+1gI5/mtGB/K+Eb4=;
        b=IbUv9tYgoxaNV4K2D3PEmJ7enAVht6dizUt4s5zKC684vP0F1K3XqWr20DfIarPyh5
         VN7gCjEsKDQD9vIf0yAqkQVJDW/cQ6tmcpHT5IQITDO8BaIHa1aIE2l4Qt1B+ugFSggZ
         kuie3Wf4QXqXk3jIW4UylMbGhdZb7ty8Q9FNLDIj7YP/ASW4fndNi03sbGfe75pu07fh
         jZDaZuSRUVSUTLNRBc8n33fLhZi75ada3+1KxQ2Oq8O5aujrTDPrIkRxMY3Xt18sYuaz
         2Y/Z5ugGhPoTKoeTA9BtE4Fnhws+xAns5otiz3GlBWBrpSX7uxQBHhAQEBqZCy+2aoot
         vNbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760653704; x=1761258504;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WFE7ffxV7H5+bRxN9E59RGE5SAa+1gI5/mtGB/K+Eb4=;
        b=PuIEl+VPJlRXMX2zP58BRp3+iclPKQgrzC8wtK03tdIujpEKXomTq5pRQGUZCLv3v3
         MoayJwCJ/OGPFmdqmIJkDnOFx7w4o1IlxbsK1sFqJIDcAKqRZ9oUN/+DFcA4dusT6elt
         e8tcJGAKnF3EaenuCJ9CcJi1MIH36+2WCL3pd6tNdwdPc9p+dK/G69DRoLZK89/Z69S3
         s3U7nA0seiKHqmrFKYS3Hz6sZqEZIp/zvekSANKDXqVHCWc9m63wfb6c2tcbuQgNdolf
         65p7TOsaOGFfomZmwfIGmGBgfQM0dbn9xSKKSGsS1hM2BuoWalA4ErwJr49G+wTw+H7L
         sqjw==
X-Forwarded-Encrypted: i=1; AJvYcCWLxBWVGZhOe56c1GkPN2sVYpS/CnWymaY2BsVZywcUv3qG7ohaoxU085mhKMuPOW6FwXBPZS4rUUCl4Ak=@vger.kernel.org
X-Gm-Message-State: AOJu0YzccKjvgUSRjvi5kAHACugYjyxBseAIADKLcVyCIHP/CCFNgxtg
	HT38ojA5upxnoSxuxbnS5eiihwemCoALBgKwmQRzs0sahN6hscoWht1LtUgsYwMf28F5PGCvuc0
	Ww/+bfA==
X-Google-Smtp-Source: AGHT+IGINGWujUT8LVwPimS5S002MFmsaGhgV7mzPv8hsrQ2NJzNz7OV/D0bncxkEoFK3d9dOhVqOg/GBnE=
X-Received: from pjsc23.prod.google.com ([2002:a17:90a:bf17:b0:33b:51fe:1a7a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d508:b0:28a:2e51:9272
 with SMTP id d9443c01a7336-290cbc3f200mr19594825ad.48.1760653704234; Thu, 16
 Oct 2025 15:28:24 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 16 Oct 2025 15:28:14 -0700
In-Reply-To: <20251016222816.141523-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251016222816.141523-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.858.gf9c4a03a3a-goog
Message-ID: <20251016222816.141523-3-seanjc@google.com>
Subject: [PATCH v4 2/4] KVM: x86: Leave user-return notifier registered on reboot/shutdown
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	"Kirill A. Shutemov" <kas@kernel.org>
Cc: kvm@vger.kernel.org, x86@kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Yan Zhao <yan.y.zhao@intel.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Hou Wenlong <houwenlong.hwl@antgroup.com>
Content-Type: text/plain; charset="UTF-8"

Leave KVM's user-return notifier registered in the unlikely case that the
notifier is registered when disabling virtualization via IPI callback in
response to reboot/shutdown.  On reboot/shutdown, keeping the notifier
registered is ok as far as MSR state is concerned (arguably better then
restoring MSRs at an unknown point in time), as the callback will run
cleanly and restore host MSRs if the CPU manages to return to userspace
before the system goes down.

The only wrinkle is that if kvm.ko module unload manages to race with
reboot/shutdown, then leaving the notifier registered could lead to
use-after-free due to calling into unloaded kvm.ko module code.  But such
a race is only possible on --forced reboot/shutdown, because otherwise
userspace tasks would be frozen before kvm_shutdown() is called, i.e. on a
"normal" reboot/shutdown, it should be impossible for the CPU to return to
userspace after kvm_shutdown().

Furthermore, on a --forced reboot/shutdown, unregistering the user-return
hook from IRQ context doesn't fully guard against use-after-free, because
KVM could immediately re-register the hook, e.g. if the IRQ arrives before
kvm_user_return_register_notifier() is called.

Rather than trying to guard against the IPI in the "normal" user-return
code, which is difficult and noisy, simply leave the user-return notifier
registered on a reboot, and bump the kvm.ko module refcount to defend
against a use-after-free due to kvm.ko unload racing against reboot.

Alternatively, KVM could allow kvm.ko and try to drop the notifiers during
kvm_x86_exit(), but that's also a can of worms as registration is per-CPU,
and so KVM would need to blast an IPI, and doing so while a reboot/shutdown
is in-progress is far risky than preventing userspace from unloading KVM.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index b4b5d2d09634..386dc2401f58 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -13078,7 +13078,21 @@ int kvm_arch_enable_virtualization_cpu(void)
 void kvm_arch_disable_virtualization_cpu(void)
 {
 	kvm_x86_call(disable_virtualization_cpu)();
-	drop_user_return_notifiers();
+
+	/*
+	 * Leave the user-return notifiers as-is when disabling virtualization
+	 * for reboot, i.e. when disabling via IPI function call, and instead
+	 * pin kvm.ko (if it's a module) to defend against use-after-free (in
+	 * the *very* unlikely scenario module unload is racing with reboot).
+	 * On a forced reboot, tasks aren't frozen before shutdown, and so KVM
+	 * could be actively modifying user-return MSR state when the IPI to
+	 * disable virtualization arrives.  Handle the extreme edge case here
+	 * instead of trying to account for it in the normal flows.
+	 */
+	if (in_task() || WARN_ON_ONCE(!kvm_rebooting))
+		drop_user_return_notifiers();
+	else
+		__module_get(THIS_MODULE);
 }
 
 bool kvm_vcpu_is_reset_bsp(struct kvm_vcpu *vcpu)
@@ -14363,6 +14377,11 @@ module_init(kvm_x86_init);
 
 static void __exit kvm_x86_exit(void)
 {
+	int cpu;
+
+	for_each_possible_cpu(cpu)
+		WARN_ON_ONCE(per_cpu_ptr(user_return_msrs, cpu)->registered);
+
 	WARN_ON_ONCE(static_branch_unlikely(&kvm_has_noapic_vcpu));
 }
 module_exit(kvm_x86_exit);
-- 
2.51.0.858.gf9c4a03a3a-goog


