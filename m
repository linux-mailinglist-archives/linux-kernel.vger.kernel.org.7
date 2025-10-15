Return-Path: <linux-kernel+bounces-853694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C80BBDC596
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 05:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C80B3351591
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 03:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011632C029C;
	Wed, 15 Oct 2025 03:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bO2RUFsG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89D7186E40
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 03:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760499191; cv=none; b=bJw++ryA+xqpuO/PnpVDKbIpv1YU+O3TpDPb/Uw/kQHYRhKF2wVh6lxkNw/GYhA0WZZw1VQwbPaZQjNRjk/kmMJeBv8RFzUplamAJ7fUNi2QzvUZ+Jz7/amyAAjXSCc9+gVv5eHzYUUrlfvOfhq0/lVlhaftHuKft3YWjiMpXu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760499191; c=relaxed/simple;
	bh=mw7TGY0Xv8+iKkhM8M/JttJ8g/t1n5LN+OhsmZ8c5Xg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FiuicpaDGRr01BrhP5KM1iLa6mFGAbkQtD1appLEFMs/FWVyLAa7cuYog315rfIgrie7MeX474mLLLz27+fhgWQjJcvG6xEZo6iaFrnmyBQWbtxuS+D+kksw0p11AgWHY8ADmz3EMVZdzeK8uxvV8Bjg4K8SjNyn5U9DQ9DmBD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bO2RUFsG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760499188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aBMe1HD5P3C7TJ6RCjcRCnllQM6K3Wm1i1grp8EBeR8=;
	b=bO2RUFsG8n0EO4oT5r6PJNAYGYXfvvKAQQOhOBhLjm02q2Q0mJWfngGCQGdWqttjMRA7EX
	eAGb0jaMxCgY7hAL7YapQvBlBN5JSb80HrqBctuxmn2IyM3OGD/ieO1jI/wTLnYgByaftK
	kRfZJ8wBwx853+SV8bSx9Ey3xbga01k=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-363-SFu7NNpAPD63VNAn-I4kKA-1; Tue,
 14 Oct 2025 23:33:05 -0400
X-MC-Unique: SFu7NNpAPD63VNAn-I4kKA-1
X-Mimecast-MFC-AGG-ID: SFu7NNpAPD63VNAn-I4kKA_1760499183
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B7C9B1800654;
	Wed, 15 Oct 2025 03:33:03 +0000 (UTC)
Received: from intellaptop.redhat.com (unknown [10.22.80.16])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ACDA61800451;
	Wed, 15 Oct 2025 03:33:01 +0000 (UTC)
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
Subject: [PATCH v2 1/3] KVM: x86: Warn if KVM tries to deliver an #APF completion when APF is not enabled
Date: Tue, 14 Oct 2025 23:32:56 -0400
Message-ID: <20251015033258.50974-2-mlevitsk@redhat.com>
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

KVM flushes the APF queue completely when the asynchronous pagefault is
disabled, therefore this case should not occur.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/kvm/x86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 4b8138bd4857..22024de00cbd 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -13896,7 +13896,7 @@ void kvm_arch_async_page_present_queued(struct kvm_vcpu *vcpu)
 
 bool kvm_arch_can_dequeue_async_page_present(struct kvm_vcpu *vcpu)
 {
-	if (!kvm_pv_async_pf_enabled(vcpu))
+	if (WARN_ON_ONCE(!kvm_pv_async_pf_enabled(vcpu)))
 		return true;
 	else
 		return kvm_lapic_enabled(vcpu) && apf_pageready_slot_free(vcpu);
-- 
2.49.0


