Return-Path: <linux-kernel+bounces-878979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB03C21E5A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 20:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8046418882DC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 19:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8C22F5469;
	Thu, 30 Oct 2025 19:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q0p8a6bX"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE6C2E9EAD
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 19:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761851740; cv=none; b=pNBLonWq+WVtOAuM0g8AG2OPnA4MAS14lSsdPApw5/FtJn4oEtmhYFqhpJ7NxP5HgaIVDlC92cN1Xc0JbFpGrxO094rL1PwQ9QX2eKVTpJY7n/b2M88tR8ftfIqsHq7fkyww+TSv1AP9ORQd7hl0UDovhzaaLwwPlROwamOeq0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761851740; c=relaxed/simple;
	bh=njD7vVo3RY8sZ4uT4oO36OjUKcILGJX+/8k/St9xxG0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eOKkGZ4sjhyqqs8S3KBLkAHGEhNuDE5c2quHfGnYhBDYAGmC2yUIHKlmUHUMgSQioV4g1U+X7GAUCnLQ0qFZcgdsOjYa0iGxTVOcVu6GcwfpiIOegVKg2NtxJifYRxQNG9/PjtvLKZpixF62yQwHlAJZ/j+NyCk1OqkP7cdmCiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q0p8a6bX; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-290cd61855eso14947735ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 12:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761851738; x=1762456538; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=FNqfEfJoqSYUvF/W9hXgR/MQkgj3qF/GVzyQVpyWACQ=;
        b=Q0p8a6bX6FhCDfnRiY+kedgbEYtJoMDcd5rTgLIPOUO8GIzgV62l4O/v1YN7HAiNr0
         FjqqLR524t6rCgPBM1uaRYsXo5QGxfMrthq87BcmMklmxPAgORCUCLbwkoNVFkNZEV/7
         S+ME7ugHnm2910Xnt8WCFnyfkyjVPalZASDfxsfNPkj/AWzdXaxNo+OwQklH+X4bohMf
         rbKwGjbatc0vYevb2SspE/+QEwsYmFoY64YO66nWMUuH94C9BZVHnxrQSlnvMOBfHQVj
         WGmuTKgd2q7cL2orj2r7znJ+HnngeO+E5vFs0B777F/plIKTsPd+O5UagXAXLcmCfee/
         qdBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761851738; x=1762456538;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FNqfEfJoqSYUvF/W9hXgR/MQkgj3qF/GVzyQVpyWACQ=;
        b=aP5tv3tA0ShrPGQO37neF1rXasTxoNgK+Z4HHNVlsABDFMoUFjWL+MJNdTpiDNLq+e
         TJ7pGQmuHNSV2Vc/c6LPPAmZ0VXeiPejKftJHM9kgkJOUwCNblwa04NLtzvUBDHBqRKm
         6RP+w9pP3X833brGC+h3AsN0oX1Zr+6tnX8HGy0DpLdEyoM6xHz2IoPf25kWR7sH6iwE
         nKA5mNX8NVILzXlsaQes3ZG/zuegwEGvdKMzTP9QFGzRSym0UmRcf9V0g/85Z2C3aMQg
         5OGZ1U3XIn2JItXVWPjOCrQsHLwTG1lHu9BSoZaqUlpPtyxR73iGJ4wZ7onVJ4nHJwKQ
         cAww==
X-Forwarded-Encrypted: i=1; AJvYcCVlxh8xhmhGrMfX19YQMyBZU7iUbjrPRHOHXCgs+Q3179HgHT1tYyMDvn+rTiPl6jpwCplBK3xvfyuQ3/4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5xCJTUJDC93w/KL3SpvUq/mlmgx9SJ1fkRhDpVJQ/o3wAMqcq
	nXIVxNpoxjrgdnJDmXrx6OFWorV5uVlxfuFCqpv0Je2QPkWOwW3io4Ah+DNCD/ae9Y1Q2+AjvB2
	9qiK5ZA==
X-Google-Smtp-Source: AGHT+IFBdKayTTHDRLc1XeLTBMS4cU/1mdOhxtVsleqZOp+VTYxxaZOIKtrD0iyEKzZHky8RcgnIOTS6Ng8=
X-Received: from plch11.prod.google.com ([2002:a17:902:f2cb:b0:290:be3d:aff6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3202:b0:294:b758:76b2
 with SMTP id d9443c01a7336-2951a58890cmr12319815ad.43.1761851737922; Thu, 30
 Oct 2025 12:15:37 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 30 Oct 2025 12:15:27 -0700
In-Reply-To: <20251030191528.3380553-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251030191528.3380553-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.1.930.gacf6e81ea2-goog
Message-ID: <20251030191528.3380553-4-seanjc@google.com>
Subject: [PATCH v5 3/4] KVM: x86: Leave user-return notifier registered on reboot/shutdown
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
 arch/x86/kvm/x86.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index bb7a7515f280..c927326344b1 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -13086,7 +13086,21 @@ int kvm_arch_enable_virtualization_cpu(void)
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
-- 
2.51.1.930.gacf6e81ea2-goog


