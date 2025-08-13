Return-Path: <linux-kernel+bounces-767407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DFEB253E3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 21:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03BA15A2A95
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 19:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3182F998B;
	Wed, 13 Aug 2025 19:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e5hzWv1a"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD14D2F9992
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 19:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755113007; cv=none; b=fdf+J6NdqErghsTihYeQJawLGMtBEk5dIS9j6/8fMKdUm5iDsWyNgNm3wQEQRNeS44rXNuUoCek09u36Tc23dXU5U5S/GDhkU5Lqjd9VXeX2GKVh0L7v2eNc9QDDUWM/W8hDu+NIuN+c60eUMqjC97uG1+E5esplQFKHIJRbErg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755113007; c=relaxed/simple;
	bh=odDD8SbrUA/Us8WVd664Wi2+XyRFRFLnt1lNe/4JBsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hdEBLHw/t57lkir3ebAd+s1YjX4b9h9eiVySO1AojHbYrKD3WFbMhOEvmZQVpSFLmPoKhZYoQZ7eYRSgUPXR0sR4Pp/GdsgEmsIh+EoV2uCHhskrq798Jl5BiLa3Tn+XiQ/c0pizkYOUW3UUkp/pYL8l/63pxZou7Onv67dxgvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e5hzWv1a; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755113004;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jgbMTcNiqkXJF3R6x+5VhGOD4G8jt3bfqCPXMbYMCOY=;
	b=e5hzWv1ajXhsgr59jpQvCMtpPQHTRvLf7J/jBLijZEP0h/Fg/mcK9jX8Wgr+R3vT2mdRUA
	wjXNZJ1Uk+fN1ww3qWIDNoJki2D6I6gqYyZCvQrs2E7cF343D6/XuUctMjDQ5ipj0mY56k
	0BDqR40erIONzMbH/h1X/eC0QDWZeo4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-274-mZkleHuzP5SvVYQcUEruWg-1; Wed,
 13 Aug 2025 15:23:21 -0400
X-MC-Unique: mZkleHuzP5SvVYQcUEruWg-1
X-Mimecast-MFC-AGG-ID: mZkleHuzP5SvVYQcUEruWg_1755112999
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CA0D9195608E;
	Wed, 13 Aug 2025 19:23:18 +0000 (UTC)
Received: from intellaptop.redhat.com (unknown [10.22.81.148])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CED181955F16;
	Wed, 13 Aug 2025 19:23:16 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: kvm@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Paolo Bonzini <pbonzini@redhat.com>,
	x86@kernel.org,
	Borislav Petkov <bp@alien8.de>,
	linux-kernel@vger.kernel.org,
	Maxim Levitsky <mlevitsk@redhat.com>
Subject: [PATCH 1/3] KVM: x86: Warn if KVM tries to deliver an #APF completion when APF is not enabled
Date: Wed, 13 Aug 2025 15:23:11 -0400
Message-ID: <20250813192313.132431-2-mlevitsk@redhat.com>
In-Reply-To: <20250813192313.132431-1-mlevitsk@redhat.com>
References: <20250813192313.132431-1-mlevitsk@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

KVM flushes the APF queue completely when the asynchronous pagefault is
disabled, therefore this case should not occur.

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 arch/x86/kvm/x86.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index a1c49bc681c4..9018d56b4b0a 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -13466,7 +13466,7 @@ void kvm_arch_async_page_present_queued(struct kvm_vcpu *vcpu)
 
 bool kvm_arch_can_dequeue_async_page_present(struct kvm_vcpu *vcpu)
 {
-	if (!kvm_pv_async_pf_enabled(vcpu))
+	if (WARN_ON_ONCE(!kvm_pv_async_pf_enabled(vcpu)))
 		return true;
 	else
 		return kvm_lapic_enabled(vcpu) && apf_pageready_slot_free(vcpu);
-- 
2.49.0


