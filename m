Return-Path: <linux-kernel+bounces-853696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA94EBDC5A7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 05:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37E903C0282
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 03:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE4E2E2DFE;
	Wed, 15 Oct 2025 03:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SZ9CyUU2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD20B2BE7D9
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 03:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760499193; cv=none; b=aTL2WWNEFa7EcoT0kQV/SBEAo3UbIwT9KF1trQ4oGhPPqIE1jiz/08gaF8eXGMvP53nOLiFYfXB0hoy/zZqDgJXEFoebAnFCcgQzfTVk/U6qurgjwAf63XAIeI1tkvw/5j7XU9Ky7UnqLSZtLi6LSDNpdLBPEru95zBvhG0CJuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760499193; c=relaxed/simple;
	bh=7Lc7gahgBxQVrfIRlEfFKZkRDdoglayt0dU9uKfIWkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NDVbg5YLsxSK0Q6fzDxElj/qVGoHtZSvfbSb+17piYmEmIlUKOZgl5B7lY/Q2tu2BK/cSqGStpusuLzk7g8KlOiYqV9Dfo8bwFjPWBa+QKL5QYVwArBcpoT6J6fFhdxkEvSipD3Nl3DL/4+wVwDOA/IH4Uvm/dQ5oV7l/hdp7bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SZ9CyUU2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760499190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XodsAQ9nLFa5bqjuqQ0w2yOtFTPpjVmvjRgcW2yd9Ms=;
	b=SZ9CyUU2LHpJWW+jPl3mPHtpxBjZFwE+vfwt61OxCfRWq/jVY3MQi+qlqTT5cpvL7kGi4o
	EhhiALXJXOP6ZKOLk360TUp99WaZR/cSmRWtsHoajdNmW/A93nx0DX1I06sIRFYpQO36mU
	g2lzWpofcmxupHBZ+B/oGkmqYnaLywE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-586-lfHcwgXFMHWgWgyebGZMfQ-1; Tue,
 14 Oct 2025 23:33:09 -0400
X-MC-Unique: lfHcwgXFMHWgWgyebGZMfQ-1
X-Mimecast-MFC-AGG-ID: lfHcwgXFMHWgWgyebGZMfQ_1760499188
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BDDD318002F5;
	Wed, 15 Oct 2025 03:33:07 +0000 (UTC)
Received: from intellaptop.redhat.com (unknown [10.22.80.16])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CAB981800452;
	Wed, 15 Oct 2025 03:33:05 +0000 (UTC)
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
Subject: [PATCH v2 3/3] KVM: x86: Fix the interaction between SMM and the asynchronous pagefault
Date: Tue, 14 Oct 2025 23:32:58 -0400
Message-ID: <20251015033258.50974-4-mlevitsk@redhat.com>
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

Currently a #SMI can cause KVM to drop an #APF ready event and
subsequently causes the guest to never resume the task that is waiting
for it.
This can result in tasks becoming permanently stuck within the guest.

This happens because KVM flushes the APF queue without notifying the guest
of completed APF requests when the guest exits to real mode.

And the SMM exit code calls kvm_set_cr0 with CR.PE == 0, which triggers
this code.

It must be noted that while this flush is reasonable to do for the actual
real mode entry, it is actually achieves nothing because it is too late to
flush this queue on SMM exit.

To fix this, avoid doing this flush altogether, and handle the real
mode entry/exits in the same way KVM already handles the APIC
enable/disable events:

APF completion events are not injected while APIC is disabled,
and once APIC is re-enabled, KVM raises the KVM_REQ_APF_READY request
which causes the first pending #APF ready event to be injected prior
to entry to the guest mode.

This change also has the side benefit of preserving #APF events if the
guest temporarily enters real mode - for example, to call firmware -
although such usage should be extermery rare in modern operating systems.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/kvm/x86.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0fc7171ced26..ec96328634ed 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1046,6 +1046,13 @@ bool kvm_require_dr(struct kvm_vcpu *vcpu, int dr)
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_require_dr);
 
+static bool kvm_pv_async_pf_enabled(struct kvm_vcpu *vcpu)
+{
+	u64 mask = KVM_ASYNC_PF_ENABLED | KVM_ASYNC_PF_DELIVERY_AS_INT;
+
+	return (vcpu->arch.apf.msr_en_val & mask) == mask;
+}
+
 static inline u64 pdptr_rsvd_bits(struct kvm_vcpu *vcpu)
 {
 	return vcpu->arch.reserved_gpa_bits | rsvd_bits(5, 8) | rsvd_bits(1, 2);
@@ -1138,15 +1145,17 @@ void kvm_post_set_cr0(struct kvm_vcpu *vcpu, unsigned long old_cr0, unsigned lon
 	}
 
 	if ((cr0 ^ old_cr0) & X86_CR0_PG) {
-		kvm_clear_async_pf_completion_queue(vcpu);
-		kvm_async_pf_hash_reset(vcpu);
-
 		/*
 		 * Clearing CR0.PG is defined to flush the TLB from the guest's
 		 * perspective.
 		 */
 		if (!(cr0 & X86_CR0_PG))
 			kvm_make_request(KVM_REQ_TLB_FLUSH_GUEST, vcpu);
+		/*
+		 * Re-check APF completion events, when the guest re-enables paging.
+		 */
+		else if (kvm_pv_async_pf_enabled(vcpu))
+			kvm_make_request(KVM_REQ_APF_READY, vcpu);
 	}
 
 	if ((cr0 ^ old_cr0) & KVM_MMU_CR0_ROLE_BITS)
@@ -3651,13 +3660,6 @@ static int set_msr_mce(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	return 0;
 }
 
-static inline bool kvm_pv_async_pf_enabled(struct kvm_vcpu *vcpu)
-{
-	u64 mask = KVM_ASYNC_PF_ENABLED | KVM_ASYNC_PF_DELIVERY_AS_INT;
-
-	return (vcpu->arch.apf.msr_en_val & mask) == mask;
-}
-
 static int kvm_pv_enable_async_pf(struct kvm_vcpu *vcpu, u64 data)
 {
 	gpa_t gpa = data & ~0x3f;
-- 
2.49.0


