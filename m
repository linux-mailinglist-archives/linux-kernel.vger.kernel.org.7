Return-Path: <linux-kernel+bounces-878955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4968C21D8E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 19:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62B584051C9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3BE374AC5;
	Thu, 30 Oct 2025 18:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HWs9Lyz5"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6721436E371
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 18:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761850690; cv=none; b=t7Zm3KSCgguAdu/eiSm1q8zOxLOSNwfCeKBX4Gch5mJOhhkJPPxghwAvlnl9+S6ubQ4WowYelw+XnagsvnfxdRYMMfAHqhCQpAYKtRk7+SByfG6dqo1a8ykUjyiDD1+9MQSi5cYslJRpSwfHq2u6Mj+/H31zIu0V9ZbWFsxn+B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761850690; c=relaxed/simple;
	bh=gBhNaafHCGkv+teWASnFAg94iaqRXR4iTaEf314TGQw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SlrA0mcnyAycBxLnkD8c2dr7F0bFg5AeswSExs1QRSHI/bH477wgKgEhdtQ2c4Rt8NDRp1lFKYXtufPsnDNmykuy8bRqrTM8aZHStKMQZvscqsKwRBi7FGuSnnZl1m+wN6qcFTCO9eRLKva0+kvsPmSyJf9F9nXSEEg/zd1i47c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HWs9Lyz5; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3405e02ff45so1077305a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 11:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761850688; x=1762455488; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=qjjFGFuC/i6bzqqoHJlMMUDjmHoXRQt84ZbrHXQbM7E=;
        b=HWs9Lyz5OCyyh3garUoE71nuAbQkfTfhXvZxE767LyOADb6ZHldXCl+V+Lka5Itmqn
         DkHc0lw6yju9GQUcXOPOhw9n5hvcCVaehr6+LDcrd7X4UrcKQV0Jn5tTmSGVwLtQbclf
         cy28DxlQ3ztPcxk7LEXKbpjGkyiXMPEG6z1rPXMEP8Ft3Z/DmJkZnazha0T4nJYl5bto
         lPkibCei09hYZHBXBg5jLPAPQB6LMPliJmEM8O9ODYYYCHXirSNQ3h6EPd1Xrjln6BCj
         1wQgAfLQwnpGmPMJi0v8drOuvSxvN9ulSsiR0DxGkugLmCyg55RVZulHHddjlz6dKQ/7
         Bq8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761850688; x=1762455488;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qjjFGFuC/i6bzqqoHJlMMUDjmHoXRQt84ZbrHXQbM7E=;
        b=fqGTnffKGmxvvEhVqWVvrmRxzXtb/zlR+W6AddS7cjgzGTsDx7wzTU/akAzw37EIH2
         gTDLoOs7P0qIHm/YkD2wKyYW3pEbHoteMAlmZkjQf0iT6VtsY/W4BaMNn1XVh5+QH0c8
         vZjDKFZkbp7KW3dF2tz5BbfLF/qrgkDQ/UNhzoH+CaK5+CeOeCr2TktD5texdA7JspEy
         h8W06GvxIHXcvzDZ8zo4eqizfJ5Xi8aHlk9v5XmXIh1x11l5Py2PsL3TGGb1QR+CpWGB
         gGAExcQZ8elTvPPTRX01k6amYsX25TqaAJu4VpUc0YozC2ccYk3hel970nt9mDpgLXyT
         023Q==
X-Forwarded-Encrypted: i=1; AJvYcCViUJuHuftU+w8uj1GPogRBlOF+M+vpsPca4MqCZGcTjHu78AZjaWGN2mXWS7BbUNtDBJAWFyWRqLyw1d0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxecXdiez5Rc5AMFRYDxb44CcHfmVdmioBf/JWH+QFkCS5/3YXU
	nIePRhF90p6j1XJW3rMk6fVn6XQJ8uXOl0/iztNujPDtw+Ll+z7rf7BCHqXtPd4OAAJiW1HuXKy
	Xn4bybg==
X-Google-Smtp-Source: AGHT+IEKgvy0wUgCv5T8CNLcmWcQSEO5ENvBe1HV5y63XOGG6rep4wBvG0goTUcSpE7EICJuck+LW8gP5+Y=
X-Received: from pjbqd11.prod.google.com ([2002:a17:90b:3ccb:b0:339:ae3b:2bc7])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:134e:b0:33b:dec9:d9aa
 with SMTP id 98e67ed59e1d1-3408308c667mr906032a91.25.1761850688619; Thu, 30
 Oct 2025 11:58:08 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu, 30 Oct 2025 11:58:02 -0700
In-Reply-To: <20251030185802.3375059-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251030185802.3375059-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.1.930.gacf6e81ea2-goog
Message-ID: <20251030185802.3375059-3-seanjc@google.com>
Subject: [PATCH 2/2] KVM: x86: Harden KVM against imbalanced load/put of guest
 FPU state
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"

Assert, via KVM_BUG_ON(), that guest FPU state isn't/is in use when
loading/putting the FPU to help detect KVM bugs without needing an assist
from KASAN.  If an imbalanced load/put is detected, skip the redundant
load/put to avoid clobbering guest state and/or crashing the host.

Note, kvm_access_xstate_msr() already provides a similar assertion.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index d1e048d14e88..67e5f735adf2 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -11807,6 +11807,9 @@ static int complete_emulated_mmio(struct kvm_vcpu *vcpu)
 /* Swap (qemu) user FPU context for the guest FPU context. */
 static void kvm_load_guest_fpu(struct kvm_vcpu *vcpu)
 {
+	if (KVM_BUG_ON(vcpu->arch.guest_fpu.fpstate->in_use, vcpu->kvm))
+		return;
+
 	/* Exclude PKRU, it's restored separately immediately after VM-Exit. */
 	fpu_swap_kvm_fpstate(&vcpu->arch.guest_fpu, true);
 	trace_kvm_fpu(1);
@@ -11815,6 +11818,9 @@ static void kvm_load_guest_fpu(struct kvm_vcpu *vcpu)
 /* When vcpu_run ends, restore user space FPU context. */
 static void kvm_put_guest_fpu(struct kvm_vcpu *vcpu)
 {
+	if (KVM_BUG_ON(!vcpu->arch.guest_fpu.fpstate->in_use, vcpu->kvm))
+		return;
+
 	fpu_swap_kvm_fpstate(&vcpu->arch.guest_fpu, false);
 	++vcpu->stat.fpu_reload;
 	trace_kvm_fpu(0);
-- 
2.51.1.930.gacf6e81ea2-goog


