Return-Path: <linux-kernel+bounces-769801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2057B273DF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 02:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11E24A05079
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 00:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586621EFF96;
	Fri, 15 Aug 2025 00:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CWXGti+D"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BF61F541E
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 00:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755217564; cv=none; b=odQ/LLYTmNQkhxwkCDSltozvICyF3+f0WciLOS5oziA1aocLkRfShgdDLxXwk/a2AbK6cCdQHUOFJPU8JW9SVUHlHw8CrJiEQvr+TSNnHPm6yEf3GCQKuRfdMCLjD0Gc3VDxleT5hLy8Pt+GTphqQy+itt8wnrghzk+Qii2PSP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755217564; c=relaxed/simple;
	bh=YkeK0+sBHNvehHuXgNtAfc5wNbib/MDo60witDlyAkg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KXf7drVOQJD4pjV5ajXRPrhad9MkB/xWYM38l0QIzkMCzE1a/1fFNQ+wHYZosSfXyMsrW4T0dig/WZ/BgVwg0swNugkHLFm8SiATaQwE42u0ffPYijyrlNAV4pJHYn/fWdDahSllPOq9EGrpg1U8qiLQxkpHGf0XGZgE8XLbZCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CWXGti+D; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2445806dc88so32811395ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 17:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755217562; x=1755822362; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=PYvY2Sr9Oc1f4jEaee72DUuWJudzSEujeEG9ujSrm7g=;
        b=CWXGti+D8ZcDuhxw3XIR12QnZHGlPooENjo0EX+nTu1ErQ2V73B7EwOjNWtzv7R9gH
         ib/qzDQ12lBgTXC3f73DBvie0K8cDqGJ9mm1pkjS/lB3FAPOVR9wbnRVB7K1X4vX275w
         XHvD0u9C3ZsMY7TBYCdCK3Q28uiMJ9Ph7ej0QwO4OVRGSBxMuHFf9mUPMzTOEWN/hFdm
         5UjU3n/BsFmx1JoAbA1Sja8sKEpMdSupvBL3s/JZ9Cwp7F8l0JUS69j9cMm7hG3w9rcj
         bo2PZhnLOUSsuWHryHgsPTxkeYaxF5woF85s6iP/HIEUc7JaQTrIRfUO5Yoo/7Iz8SRh
         Sx7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755217562; x=1755822362;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PYvY2Sr9Oc1f4jEaee72DUuWJudzSEujeEG9ujSrm7g=;
        b=nbhGiXVoMWSZEKMKzw6f13uFihOGCLouRR7ixwfyR7RjVXQdbhddK6mcrYQANkwcIX
         OrGNyKngbAdYwlrHP1Wz5f56dop4f/GQKS/EMg413V8W0fxyKlB90jGIk0+OCJMjGR9d
         MwmRV6EfZSzkVk4RfHBbviiGZR1DPJQxDrmbSocAN8oEmn+EJWjzrmBvI7zXomAtIUoa
         +7AdddQIr58xVO89V0VKfKLl2pvNzQm8JGNi6gxTVWDeyPjNX1htdkyPheQmVNCYbW9T
         OX2Ri0LVfoLBSfcN6Er1a3tvck7NPxiHYlFUm+NVMjOxBQM7hsN2nQvQlB6oCMyB1uca
         NXGg==
X-Forwarded-Encrypted: i=1; AJvYcCXr4aXPR47YPWcC2/pdcGfvLk7Ve8UW0WfPNgK7nZuyA7BZMmVl67jJKemPyXragRfNBx69dvfIZuZ8w6g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtMGL3kHsph9YPxYT640B2MM8MIHBIXYqpS/EHNLA5TEIvTHsO
	BeB9UeolcZEFMQgNY5FGzU1DkIO1yg0AeNKDYhsxZxuw/kq/9LQgW3oahZqdrn3kFP4vnGclX7z
	ttZ0ACw==
X-Google-Smtp-Source: AGHT+IHsjF30T9KKGUIEbxZ0Ho5Yny/Gtu6qUWgWc0dpfdUesJGzLVo8k9vpXMQxwjUaaSSe7yJ3zq8qLk0=
X-Received: from pjc7.prod.google.com ([2002:a17:90b:2f47:b0:313:274d:3007])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:4b4c:b0:23f:f3e1:7363
 with SMTP id d9443c01a7336-2446d73e7c9mr1820395ad.23.1755217562684; Thu, 14
 Aug 2025 17:26:02 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 Aug 2025 17:25:30 -0700
In-Reply-To: <20250815002540.2375664-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250815002540.2375664-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Message-ID: <20250815002540.2375664-11-seanjc@google.com>
Subject: [PATCH 6.6.y 10/20] KVM: VMX: Handle forced exit due to preemption
 timer in fastpath
From: Sean Christopherson <seanjc@google.com>
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sasha Levin <sashal@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"

[ Upstream commit 11776aa0cfa7d007ad1799b1553bdcbd830e5010 ]

Handle VMX preemption timer VM-Exits due to KVM forcing an exit in the
exit fastpath, i.e. avoid calling back into handle_preemption_timer() for
the same exit.  There is no work to be done for forced exits, as the name
suggests the goal is purely to get control back in KVM.

In addition to shaving a few cycles, this will allow cleanly separating
handle_fastpath_preemption_timer() from handle_preemption_timer(), e.g.
it's not immediately obvious why _apparently_ calling
handle_fastpath_preemption_timer() twice on a "slow" exit is necessary:
the "slow" call is necessary to handle exits from L2, which are excluded
from the fastpath by vmx_vcpu_run().

Link: https://lore.kernel.org/r/20240110012705.506918-4-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 32b792387271..631fdd4a575a 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6027,12 +6027,15 @@ static fastpath_t handle_fastpath_preemption_timer(struct kvm_vcpu *vcpu)
 	if (unlikely(vmx->loaded_vmcs->hv_timer_soft_disabled))
 		return EXIT_FASTPATH_REENTER_GUEST;
 
-	if (!vmx->req_immediate_exit) {
-		kvm_lapic_expired_hv_timer(vcpu);
-		return EXIT_FASTPATH_REENTER_GUEST;
-	}
+	/*
+	 * If the timer expired because KVM used it to force an immediate exit,
+	 * then mission accomplished.
+	 */
+	if (vmx->req_immediate_exit)
+		return EXIT_FASTPATH_EXIT_HANDLED;
 
-	return EXIT_FASTPATH_NONE;
+	kvm_lapic_expired_hv_timer(vcpu);
+	return EXIT_FASTPATH_REENTER_GUEST;
 }
 
 static int handle_preemption_timer(struct kvm_vcpu *vcpu)
-- 
2.51.0.rc1.163.g2494970778-goog


