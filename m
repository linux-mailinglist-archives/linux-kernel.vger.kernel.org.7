Return-Path: <linux-kernel+bounces-769770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A8AB27382
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 02:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D3229E3FAE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 00:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0BB20299B;
	Fri, 15 Aug 2025 00:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K5iFbDKN"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BF71F561D
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 00:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755216755; cv=none; b=hScMG0kj0KibRi9KajNO2QtlippALKq3tZeue6YvdhQ35YhvTHwhESm8fV3mrwL7tKjS7wlnpCSALL1YUz+Rx4mxMR9H72LKzB8luR5rNvEmcHNWfjlfA/RFi+OBxfHMFIz2C+10wm8ehxYwF2CtBaMixZR5z1qd9FnKzm1+XO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755216755; c=relaxed/simple;
	bh=J5bjGgVJv9hmsbY0pSYL5E2uFR0Opy+IWAryQkIYkd0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qetrvaIrweOkacnLGEFt3Jx+a/wCtleefPbNMUGzwbPA++22etPT4ZXYgMcvORqt04epN73+Es41oalfVnfyduXVcpqdHbaEkWrPpZA4f3u620HyrRBCdeSlEik9sXoYAjzU567H5JJgJy5NDK56kYkw4OC4iMcJQtNOdBNBNEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K5iFbDKN; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b4716fb7f2aso983219a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 17:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755216753; x=1755821553; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=2wMy9TJhpZES3QcM2QFYJyQalMsJ3q38AGM7XgsPeU0=;
        b=K5iFbDKNiuvqtn2yUuJONz8cPEPByRqTrosxRvmAVp/RUDlzbr7WWcVlQ76mL1wKPs
         N9JSPirjGDQC9tpGRlv0H2+gI4bZKN4F6nyFc2CtDLT0pXw+jCWRxwzMGjlKmsx5c1fh
         qqBtPezgy2ptM1KbEdhI5952rG0g3csv+o15i7ZiYTRKEYlzmX5rAsHCjb3drF/gxDlT
         ikFi1WfbDN75GKFmrxTu9oSxfq/kNPciBwUNcvMs+Y5VYj7sLOu6WPNEHhXtqQ08CwEW
         3r9Xafi2LVQiMWZEudmujWpbvwCjeQGdaFM6WSZ49VTQ5dfq4wlzADV8EDqgKdeaKMYt
         IUkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755216753; x=1755821553;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2wMy9TJhpZES3QcM2QFYJyQalMsJ3q38AGM7XgsPeU0=;
        b=Vqrb9PbVeCp30v0lrspDWBstPHvzQjpqItqDhC8/unF9ZioWkNL7Uzf2+sLEs3rX1K
         kAQiTKvbFn71GAkpiXe16ddoezViaV/KqiU7OEp/P3o0gPkR9C8QBk8/FJELwVOwErp7
         VEDl4Vl/Bt1PjFWs8x+5YboUsNPZjwPmYl9C4fTt4n1+/jC25q6vQhtrH6+XU9qKfNSZ
         TT0EokvBDtTKdbTdyYthglfPKicUjfVWXBd6/4ltDFZOJs4MrKLItJ8TSSx3Igan3pHR
         dap/I8QmK/EUaeEIUqcPlK2CDavRq6mnSGebbnT3MV26IfACZ0DEGUsWN4jSdRL20xhH
         8nyw==
X-Forwarded-Encrypted: i=1; AJvYcCXlqmYyzdIpXD4Hmr27tz1QfrmR/QpGHZdOVk9g2FkCAzwSlhZ3aBHS/6jyat6QAd4rWrW+qp/VVlGs7Q8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyblWlyirbkLw2UInAopYhK3z6ZrhMLdvQr3SxIFB5uZ8MafLAo
	n5xSi9iMLX9j7c15RY05KaIf0AZloKI/8RPdvLi6JLya2eaB8Z6iXyIGOFPLiPajW7SnbaJgsQ0
	e/FHH7g==
X-Google-Smtp-Source: AGHT+IEgo7vJgzcLT1RHaYoSqGTHO6Al4/b0zR+cP3g/V7QzZ9vp0b/qWYdJWt1FD0Lbuih760/NY1kEXkU=
X-Received: from pjbnc16.prod.google.com ([2002:a17:90b:37d0:b0:312:dbc:f731])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3c6f:b0:23f:df56:c74c
 with SMTP id d9443c01a7336-2446d715b0bmr1607785ad.14.1755216753639; Thu, 14
 Aug 2025 17:12:33 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 14 Aug 2025 17:11:56 -0700
In-Reply-To: <20250815001205.2370711-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250815001205.2370711-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
Message-ID: <20250815001205.2370711-13-seanjc@google.com>
Subject: [PATCH 6.1.y 12/21] KVM: x86: Move handling of is_guest_mode() into
 fastpath exit handlers
From: Sean Christopherson <seanjc@google.com>
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Sasha Levin <sashal@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"

[ Upstream commit bf1a49436ea37b98dd2f37c57608951d0e28eecc ]

Let the fastpath code decide which exits can/can't be handled in the
fastpath when L2 is active, e.g. when KVM generates a VMX preemption
timer exit to forcefully regain control, there is no "work" to be done and
so such exits can be handled in the fastpath regardless of whether L1 or
L2 is active.

Moving the is_guest_mode() check into the fastpath code also makes it
easier to see that L2 isn't allowed to use the fastpath in most cases,
e.g. it's not immediately obvious why handle_fastpath_preemption_timer()
is called from the fastpath and the normal path.

Link: https://lore.kernel.org/r/20240110012705.506918-5-seanjc@google.com
Signed-off-by: Sean Christopherson <seanjc@google.com>
[sean: resolve syntactic conflict in svm_exit_handlers_fastpath()]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 6 +++---
 arch/x86/kvm/vmx/vmx.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index b4283c2358a6..337a304d211b 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3964,6 +3964,9 @@ static fastpath_t svm_exit_handlers_fastpath(struct kvm_vcpu *vcpu)
 {
 	struct vmcb_control_area *control = &to_svm(vcpu)->vmcb->control;
 
+	if (is_guest_mode(vcpu))
+		return EXIT_FASTPATH_NONE;
+
 	/*
 	 * Note, the next RIP must be provided as SRCU isn't held, i.e. KVM
 	 * can't read guest memory (dereference memslots) to decode the WRMSR.
@@ -4127,9 +4130,6 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu,
 
 	svm_complete_interrupts(vcpu);
 
-	if (is_guest_mode(vcpu))
-		return EXIT_FASTPATH_NONE;
-
 	return svm_exit_handlers_fastpath(vcpu);
 }
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index c804ad001a79..18ceed9046a9 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7138,6 +7138,9 @@ void noinstr vmx_spec_ctrl_restore_host(struct vcpu_vmx *vmx,
 
 static fastpath_t vmx_exit_handlers_fastpath(struct kvm_vcpu *vcpu)
 {
+	if (is_guest_mode(vcpu))
+		return EXIT_FASTPATH_NONE;
+
 	switch (to_vmx(vcpu)->exit_reason.basic) {
 	case EXIT_REASON_MSR_WRITE:
 		return handle_fastpath_set_msr_irqoff(vcpu);
@@ -7337,9 +7340,6 @@ static fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu, bool force_immediate_exit)
 	vmx_recover_nmi_blocking(vmx);
 	vmx_complete_interrupts(vmx);
 
-	if (is_guest_mode(vcpu))
-		return EXIT_FASTPATH_NONE;
-
 	return vmx_exit_handlers_fastpath(vcpu);
 }
 
-- 
2.51.0.rc1.163.g2494970778-goog


