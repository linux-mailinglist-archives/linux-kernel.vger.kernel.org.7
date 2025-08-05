Return-Path: <linux-kernel+bounces-756886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5086CB1BAB7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 21:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D22981886F1A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 19:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB022C324A;
	Tue,  5 Aug 2025 19:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QFxEOMC1"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8DC2C1596
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 19:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754420764; cv=none; b=N5sTcvpS8k9HnaOtQwnLcclY8oCfXzvPRMarDD0vE6IL62SFzK2ybUyf00KgAfFuiQCLbFjS9W7IQXGnnQUUUyNr1PpltASBc3ih+lL/yfEoYdJ2MMm/gEjfkwZWh//3oiPhWQdqmFvhwWMoW/bUKBcFUSByYbNKulzWS9egFk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754420764; c=relaxed/simple;
	bh=6eCmSKhIpszLUkxsSJHASWeflETYxy1FzP1/dimvvmQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e1J/OfwKsc1C/nmk1OXJeTQ9ZkRrn8W6rDOn4qD0V25qeO/B2po0QEZoS0RLPkC25QOVCpKTuu3joeWBU2H+WLVr1c1Ak1LBr+yQ5oWFh0A6b3gtzct6/bQpE8Vu6nfBzRrR8bL8/laMQIri8oXqbuLEJiU+ne6XZbMXMA+nYUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QFxEOMC1; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-23fd8c99dbfso47145795ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 12:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754420762; x=1755025562; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=jYPOGKxz/YMagjLqc/SXFdXBFj+5MGEvuF5f/vLTJD0=;
        b=QFxEOMC1jWlIZ7oAvYjs9TX2WLj4RaTOngtBRRXK1YJbbbvwahutSqPS3Kll1HXCa7
         11s59NiOKf9bsdsUDpzzUE1/NvWCD+RGu+/mU6Vo0kL2EJKvDIsJAahdPIajDQ2iHAV6
         UtLtUt5S8+ScV/4O1Bf2X+0lxnR0ulmPvxcJWnRr3qWWsvRBlexaRGkDE54jgCKaiEdO
         vV7mQy38ltvQ4aDuRHUYqVlfjpu7QYoieo6T6Ui4ZBD6mdUd8ZynnJy+UqcC2etxd4E1
         l1yVEOZS8avkclYc8hdoYFNdXkF3PUwnK7dqUOJznYv/E/tGOzw9LzFgaQdT+LnQU1pN
         7P9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754420762; x=1755025562;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jYPOGKxz/YMagjLqc/SXFdXBFj+5MGEvuF5f/vLTJD0=;
        b=klxMNkLTcmKw09V7LNGz4yL1xmqThGxgtHErA+S/IAEIKlKJtkw2MKcZii1Chs1chN
         DUh9IbWzoW9K3UwiO4z4u5IAe/Kltt9+wFG9I6688JuJDk8cPtnNFhXhIkaC0soToKnq
         3uxkQZyLzUj5MKem6TKpNy9c0cTIKS878IMhRlyPJ6KLnJwqkOszz6qwrOfgj9QBHqy+
         7tvrDLpoOOooneFY1pLI1SUnbNf7xbHPqu+WCrsU0HvzGqrKnrK4EFJrdGWayo0GFMaZ
         bOcJ1xLQesTOy9faxZ0BKPo7MmqhxT+JYFcsywrRT47Deo7mJeFryURYP8RCHU/eCyNv
         xzSw==
X-Forwarded-Encrypted: i=1; AJvYcCWwkStOrOBiljiPzZr5Qi81oZLQrtZuHvzWkicn3IHt9i85VOWKOsOJB5dnQi05NbL6nzuu18SXN6FQBY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUzc9BRPzrz2dL4WbsQwcNzkXqyOqQOw6c41j4iSpzNxDFbFPO
	ciXRCsDincgJ1UvBS5cWqgxT1ZieauPRX/kwQNNR9w2h8mMcozGeS+y/4X6xHZHfSO0RLhmz7Ji
	24jheBA==
X-Google-Smtp-Source: AGHT+IHbdxTlG7hgheXP+mYT9oIu4lCPyl255ao0Ex9Ybo3KzljkvgO/MKcbZ0k0rRO+Jid7Q1iCdyPOclQ=
X-Received: from plcx21.prod.google.com ([2002:a17:903:d5:b0:240:8fa2:15c3])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:1b30:b0:240:11be:4dd3
 with SMTP id d9443c01a7336-2429f521ac4mr2366575ad.3.1754420762334; Tue, 05
 Aug 2025 12:06:02 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  5 Aug 2025 12:05:26 -0700
In-Reply-To: <20250805190526.1453366-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250805190526.1453366-1-seanjc@google.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Message-ID: <20250805190526.1453366-19-seanjc@google.com>
Subject: [PATCH 18/18] KVM: x86: Add a fastpath handler for INVD
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Xin Li <xin@zytor.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Sandipan Das <sandipan.das@amd.com>
Content-Type: text/plain; charset="UTF-8"

Add a fastpath handler for INVD so that the common fastpath logic can be
trivially tested on both Intel and AMD.  Under KVM, INVD is always:
(a) intercepted, (b) available to the guest, and (c) emulated as a nop,
with no side effects.  Combined with INVD not having any inputs or outputs,
i.e. no register constraints, INVD is the perfect instruction for
exercising KVM's fastpath as it can be inserted into practically any
guest-side code stream.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/svm.c | 2 ++
 arch/x86/kvm/vmx/vmx.c | 2 ++
 arch/x86/kvm/x86.c     | 9 +++++++++
 arch/x86/kvm/x86.h     | 1 +
 4 files changed, 14 insertions(+)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 829d9d46718d..f7e1e665a826 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4200,6 +4200,8 @@ static fastpath_t svm_exit_handlers_fastpath(struct kvm_vcpu *vcpu)
 		return handle_fastpath_set_msr_irqoff(vcpu);
 	case SVM_EXIT_HLT:
 		return handle_fastpath_hlt(vcpu);
+	case SVM_EXIT_INVD:
+		return handle_fastpath_invd(vcpu);
 	default:
 		break;
 	}
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index aa157fe5b7b3..95765db52992 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7175,6 +7175,8 @@ static fastpath_t vmx_exit_handlers_fastpath(struct kvm_vcpu *vcpu,
 		return handle_fastpath_preemption_timer(vcpu, force_immediate_exit);
 	case EXIT_REASON_HLT:
 		return handle_fastpath_hlt(vcpu);
+	case EXIT_REASON_INVD:
+		return handle_fastpath_invd(vcpu);
 	default:
 		return EXIT_FASTPATH_NONE;
 	}
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index a56f83b40a55..5af2c5aed0f2 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2086,6 +2086,15 @@ int kvm_emulate_invd(struct kvm_vcpu *vcpu)
 }
 EXPORT_SYMBOL_GPL(kvm_emulate_invd);
 
+fastpath_t handle_fastpath_invd(struct kvm_vcpu *vcpu)
+{
+	if (!kvm_emulate_invd(vcpu))
+		return EXIT_FASTPATH_EXIT_USERSPACE;
+
+	return EXIT_FASTPATH_REENTER_GUEST;
+}
+EXPORT_SYMBOL_GPL(handle_fastpath_invd);
+
 int kvm_handle_invalid_op(struct kvm_vcpu *vcpu)
 {
 	kvm_queue_exception(vcpu, UD_VECTOR);
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index bcfd9b719ada..46220b04cdf2 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -439,6 +439,7 @@ int x86_emulate_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 			    int emulation_type, void *insn, int insn_len);
 fastpath_t handle_fastpath_set_msr_irqoff(struct kvm_vcpu *vcpu);
 fastpath_t handle_fastpath_hlt(struct kvm_vcpu *vcpu);
+fastpath_t handle_fastpath_invd(struct kvm_vcpu *vcpu);
 
 extern struct kvm_caps kvm_caps;
 extern struct kvm_host_values kvm_host;
-- 
2.50.1.565.gc32cd1483b-goog


