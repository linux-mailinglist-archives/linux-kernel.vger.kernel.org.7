Return-Path: <linux-kernel+bounces-749834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C29CFB15376
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 21:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC4594E6F7A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 19:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75518255F4C;
	Tue, 29 Jul 2025 19:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cAIeG4DQ"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582DE255F5C
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 19:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753817631; cv=none; b=kZUxZGiLFMTGCy2X8VdmHLBEUJlqcKTSFFAv9p6yLHI+SzI/o9a8FW5aTtSBDWCAlO8tZaOad2aHW7Al7lIzXjphgGsEl7NjpFmR2LAYKFzs+WmasA21QQwyLoP9bGLOfCpOQ+qYYgW02ucv+kassBXBsgBKcX8lBiAUViuSMLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753817631; c=relaxed/simple;
	bh=L+2rXbfnP5UHLH6J8UIbSI41QWjZkhL1tyySVaOK3Ek=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Y7das+qUVLOpLfw0V14HyKpb+EPdTw2W/Tx8xRP5LwASWQC4x0JoGFvT3X7C6wJ84yk8xGjCxPXJTdymd2k6hVfxT/CXjwxWHEWEJqiz1cnrszGbXuqgyQA++7o/p6CwmDf9v97K5gIHBSQ5bKRN3BFyCHD3OTlm8BrWniScprk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cAIeG4DQ; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-74ae13e99d6so140343b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 12:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753817629; x=1754422429; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=nK97iU3U8P3+PseGfflZpbVtPQJIWPB5aDB6ZsfbPi4=;
        b=cAIeG4DQv2bCnZtYJeyxx7gR0jV9adUofUysQDi6b84n3r+ASEU/Xdchc0t2VZ143p
         1d//X8/CtoZECr9B6+p2Y9vU+odLylKXoJqdIEnCk4RTBZSWk/oAiSEQMCLakl160dNN
         0c9OA4j4jnJbp2/v1LRF1U1eI2pR8quVaq1pnPPQKkdTSDWqA9eHsgDPd69F6IlgoMe6
         M/TTbzU3sFPhfBJGjeaE6wKrjDx4VmGRg82UGe2NyaRNWz40q9rm+CDl1HhoNyELiQHK
         bnDv+0P9yQK/0lmtl1TxBRaol6SjoTfqqHO/L6P45YcCEVI2iNe+HjtV5DyQ9xAw2+9P
         Idfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753817629; x=1754422429;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nK97iU3U8P3+PseGfflZpbVtPQJIWPB5aDB6ZsfbPi4=;
        b=tZpsekAZZSiEi7Ljaluvi+eKdTz4j3GpU16fkPBz2cHlHtaIUGNmysZAFuRlIDZHfF
         7232Qz2gaJaFxGGEy0qSrDSPQ152qwYcRcpvd7hAvlY3wBiqCi4Z457dcWqgXXkb5zso
         qSzroJggMYoEsYnVunctG0adY3j/I/uuBcO1bh/uUgAVPReeRnccEckQYAy1R9qDgdPg
         LBxPZbBqmrHfCSiyF7/E6vOIjI63A8y5R6PAK+3Jsmbusp3fS2wExtLe8AdYLLofvkF1
         Y1WRirErXwxv75zij0jSrvG1Cjpmij/6pXEWDWBMDUKC0YR6L6Ah2CvAssGPx1x4LFwv
         uY4w==
X-Forwarded-Encrypted: i=1; AJvYcCWJDBu3Gx5Nm/7k2TwHwIoddlHC7NC1U1XHUx23xC17J80raQ6HxtLn5jXtAyp1j4J33VuuBWTFum37AOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YylJ3NkXqHFLQoR7WJM1PEq4+QzNeLt2exs1RC38x/woPdKnkWg
	qcJyAOrWCgWZ7/E3qD8bGYUM3EYSFRt8EbniOUCK/6ZCqsiQ1cN3airLie8OzTwaGFtyZE3+KYe
	RfKE7qQ==
X-Google-Smtp-Source: AGHT+IH4QbqgK/rjqLq7feIazM0nAtyNNAHCeByH/06YNfkwg9k7lbaoNX81vVU/L2yD55+9XIqmw/waN38=
X-Received: from pgac7.prod.google.com ([2002:a05:6a02:2947:b0:b36:36f4:9862])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:914f:b0:23d:659c:aadd
 with SMTP id adf61e73a8af0-23dadeb68c0mr7268679637.22.1753817628625; Tue, 29
 Jul 2025 12:33:48 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue, 29 Jul 2025 12:33:36 -0700
In-Reply-To: <20250729193341.621487-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250729193341.621487-1-seanjc@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250729193341.621487-2-seanjc@google.com>
Subject: [PATCH 1/5] KVM: Never clear KVM_REQ_VM_DEAD from a vCPU's requests
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Adrian Hunter <adrian.hunter@intel.com>, Vishal Annapurve <vannapurve@google.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Nikolay Borisov <nik.borisov@suse.com>
Content-Type: text/plain; charset="UTF-8"

Use kvm_test_request() instead of kvm_check_request() when querying
KVM_REQ_VM_DEAD, i.e. don't clear KVM_REQ_VM_DEAD, as the entire purpose
of KVM_REQ_VM_DEAD is to prevent the vCPU from enterring the guest ever
again, even if userspace insists on redoing KVM_RUN.

Ensuring KVM_REQ_VM_DEAD is never cleared will allow relaxing KVM's rule
that ioctls can't be invoked on dead VMs, to only disallow ioctls if the
VM is bugged, i.e. if KVM hit a KVM_BUG_ON().

Opportunistically add compile-time assertions to guard against clearing
KVM_REQ_VM_DEAD through the standard APIs.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/arm64/kvm/arm.c     | 2 +-
 arch/x86/kvm/mmu/mmu.c   | 2 +-
 arch/x86/kvm/vmx/tdx.c   | 2 +-
 arch/x86/kvm/x86.c       | 2 +-
 include/linux/kvm_host.h | 9 +++++++--
 5 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index f946926716b0..2fdc48c0fc4d 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1013,7 +1013,7 @@ static int kvm_vcpu_suspend(struct kvm_vcpu *vcpu)
 static int check_vcpu_requests(struct kvm_vcpu *vcpu)
 {
 	if (kvm_request_pending(vcpu)) {
-		if (kvm_check_request(KVM_REQ_VM_DEAD, vcpu))
+		if (kvm_test_request(KVM_REQ_VM_DEAD, vcpu))
 			return -EIO;
 
 		if (kvm_check_request(KVM_REQ_SLEEP, vcpu))
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 6e838cb6c9e1..d09bd236a92d 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4915,7 +4915,7 @@ int kvm_tdp_map_page(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code, u8 *level
 		if (signal_pending(current))
 			return -EINTR;
 
-		if (kvm_check_request(KVM_REQ_VM_DEAD, vcpu))
+		if (kvm_test_request(KVM_REQ_VM_DEAD, vcpu))
 			return -EIO;
 
 		cond_resched();
diff --git a/arch/x86/kvm/vmx/tdx.c b/arch/x86/kvm/vmx/tdx.c
index 66744f5768c8..3e0d4edee849 100644
--- a/arch/x86/kvm/vmx/tdx.c
+++ b/arch/x86/kvm/vmx/tdx.c
@@ -2010,7 +2010,7 @@ static int tdx_handle_ept_violation(struct kvm_vcpu *vcpu)
 		if (kvm_vcpu_has_events(vcpu) || signal_pending(current))
 			break;
 
-		if (kvm_check_request(KVM_REQ_VM_DEAD, vcpu)) {
+		if (kvm_test_request(KVM_REQ_VM_DEAD, vcpu)) {
 			ret = -EIO;
 			break;
 		}
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index a1c49bc681c4..1700df68f12a 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -10649,7 +10649,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 	bool req_immediate_exit = false;
 
 	if (kvm_request_pending(vcpu)) {
-		if (kvm_check_request(KVM_REQ_VM_DEAD, vcpu)) {
+		if (kvm_test_request(KVM_REQ_VM_DEAD, vcpu)) {
 			r = -EIO;
 			goto out;
 		}
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 15656b7fba6c..627054d27222 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2261,13 +2261,18 @@ static inline bool kvm_test_request(int req, struct kvm_vcpu *vcpu)
 	return test_bit(req & KVM_REQUEST_MASK, (void *)&vcpu->requests);
 }
 
-static inline void kvm_clear_request(int req, struct kvm_vcpu *vcpu)
+static __always_inline void kvm_clear_request(int req, struct kvm_vcpu *vcpu)
 {
+	BUILD_BUG_ON(req == KVM_REQ_VM_DEAD);
+
 	clear_bit(req & KVM_REQUEST_MASK, (void *)&vcpu->requests);
 }
 
-static inline bool kvm_check_request(int req, struct kvm_vcpu *vcpu)
+static __always_inline bool kvm_check_request(int req, struct kvm_vcpu *vcpu)
 {
+	/* Once a VM is dead, it needs to stay dead. */
+	BUILD_BUG_ON(req == KVM_REQ_VM_DEAD);
+
 	if (kvm_test_request(req, vcpu)) {
 		kvm_clear_request(req, vcpu);
 
-- 
2.50.1.552.g942d659e1b-goog


