Return-Path: <linux-kernel+bounces-853695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E60BDC5A1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 05:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E41F1928218
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 03:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121052E283B;
	Wed, 15 Oct 2025 03:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KOCXAO/h"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1912BE647
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 03:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760499193; cv=none; b=KkPqdy9LlsAErCcdIxVu7jXUgXcZdc4ou1UMeGX8VRRCpxFB/L11oeVkCbgzZo1GGtgAd8zNPVJMh7yc4o7A82N1itK1+AsX/oegr9lCG4wikLJi/NmCk4/lEA6KKCbBuVXfRoHRK+2EYAtGM3iGDzHT9W0J1wKjRrnVs0k3z5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760499193; c=relaxed/simple;
	bh=lt/Ccq3EasYpmnoIY3Dqr32J6BxUvLuUtOm/K/FJNUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e04mZZcH9dh9T9QniLPlEYtY40QSiA83jAFE4bPmbuCvPJCjNLc+L/6ez5NnoBKS9+vLhMdLpnFh1/7acO0aUCDqWk2UvKfN7UDS2e6OQytiIF0UpwIm8wAWyFxP6oX3WRZkYSogP9+3GrZG8czrSVyG2uUGCtIg9x3iayqDpzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KOCXAO/h; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760499190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AEnOwSVuWAWAL/347w/YmsTI1jFv0LM89DYqW+RqkiQ=;
	b=KOCXAO/hO1/lJ9tGaCoe/I9GZAUmrq3gcRa5m5ikYIYUgBwuRtf1PaRAFvqv6oglmVgP7C
	xcuiStah9mUKiiEQUUzOCnf1VG8Y0aTUHHSBleaei3XZblBDXaCqlyqqsEwph1cWM1+rrq
	UpKF55cvYs49fuedMiT1obgnyt3moeo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-RI-f0PJgOoGZv70syzfb7A-1; Tue,
 14 Oct 2025 23:33:07 -0400
X-MC-Unique: RI-f0PJgOoGZv70syzfb7A-1
X-Mimecast-MFC-AGG-ID: RI-f0PJgOoGZv70syzfb7A_1760499186
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 94A1B19540D6;
	Wed, 15 Oct 2025 03:33:05 +0000 (UTC)
Received: from intellaptop.redhat.com (unknown [10.22.80.16])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F15B91800451;
	Wed, 15 Oct 2025 03:33:03 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: kvm@vger.kernel.org
Cc: x86@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	linux-kernel@vger.kernel.org,
	Sean Christopherson <seanjc@google.com>,
	Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Maxim Levitsky <mlevitsk@redhat.com>
Subject: [PATCH v2 2/3] KVM: x86: Fix a semi theoretical bug in kvm_arch_async_page_present_queued
Date: Tue, 14 Oct 2025 23:32:57 -0400
Message-ID: <20251015033258.50974-3-mlevitsk@redhat.com>
In-Reply-To: <20251015033258.50974-1-mlevitsk@redhat.com>
References: <20251015033258.50974-1-mlevitsk@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Fix a semi theoretical race condition related to a lack of memory barriers
when dealing with vcpu->arch.apf.pageready_pending.

We have the following lockless code implementing the sleep/wake pattern:

kvm_arch_async_page_present_queued() running in workqueue context:

    kvm_make_request(KVM_REQ_APF_READY, vcpu);
    /* memory barrier is missing here*/
    if (!vcpu->arch.apf.pageready_pending)
        kvm_vcpu_kick(vcpu);

And vCPU code running:

kvm_set_msr_common()
    vcpu->arch.apf.pageready_pending = false;
    /* memory barrier is missing here*/

And later, the vcpu_enter_guest():

    if (kvm_check_request(KVM_REQ_APF_READY, vcpu))
         kvm_check_async_pf_completion(vcpu)

Add missing full memory barriers in both cases to avoid theoretical
case of not kicking the vCPU thread.

Note that the bug is mostly theoretical because kvm_make_request
already uses an atomic bit operation which is already serializing on x86,
requiring only for documentation purposes the smp_mb__after_atomic()
after it, which is NOP.

The second missing barrier, between kvm_set_msr_common and
vcpu_enter_guest isn't strictly needed because KVM executes several
barriers in between calling these functions, however it still makes
sense to have an explicit barrier to be on the safe side.

Finally, also use READ_ONCE/WRITE_ONCE.

Thanks a lot to Paolo for the help with this patch.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/kvm/x86.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 22024de00cbd..0fc7171ced26 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4184,7 +4184,10 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 		if (!guest_pv_has(vcpu, KVM_FEATURE_ASYNC_PF_INT))
 			return 1;
 		if (data & 0x1) {
-			vcpu->arch.apf.pageready_pending = false;
+
+			/* Pairs with a memory barrier in kvm_arch_async_page_present_queued */
+			smp_store_mb(vcpu->arch.apf.pageready_pending, false);
+
 			kvm_check_async_pf_completion(vcpu);
 		}
 		break;
@@ -13879,7 +13882,7 @@ void kvm_arch_async_page_present(struct kvm_vcpu *vcpu,
 	if ((work->wakeup_all || work->notpresent_injected) &&
 	    kvm_pv_async_pf_enabled(vcpu) &&
 	    !apf_put_user_ready(vcpu, work->arch.token)) {
-		vcpu->arch.apf.pageready_pending = true;
+		WRITE_ONCE(vcpu->arch.apf.pageready_pending, true);
 		kvm_apic_set_irq(vcpu, &irq, NULL);
 	}
 
@@ -13890,7 +13893,11 @@ void kvm_arch_async_page_present(struct kvm_vcpu *vcpu,
 void kvm_arch_async_page_present_queued(struct kvm_vcpu *vcpu)
 {
 	kvm_make_request(KVM_REQ_APF_READY, vcpu);
-	if (!vcpu->arch.apf.pageready_pending)
+
+	/* Pairs with smp_store_mb in kvm_set_msr_common */
+	smp_mb__after_atomic();
+
+	if (!READ_ONCE(vcpu->arch.apf.pageready_pending))
 		kvm_vcpu_kick(vcpu);
 }
 
-- 
2.49.0


