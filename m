Return-Path: <linux-kernel+bounces-814893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF18B55A2A
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 01:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD27F1897738
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 23:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414762DC33F;
	Fri, 12 Sep 2025 23:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hncz5h2x"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FE92DAFBE
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 23:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757719446; cv=none; b=op9atR4LSJiptC1j2M8IokvHTcbEhl0TR433S1p/V3b/MPP5bFcmRwn3c2daHP+1mRnxskiOfoQDQle8KBwPrVcuzLehhRG3XM5UjJEgpWGnyv8rNpvD1LmWLYCkP0WIjOvqJhZL8dWkxA6ZMdJ1v+nGEDjbzk8gUgecSmU7CBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757719446; c=relaxed/simple;
	bh=+RVQicm4TK8MmrV33Gpsf9YCthCHWpRMM79XaOiiPK8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TKaXqgIigHYdHDnIVCy1/dB2o+I98u8RFphtegmkw3fF+hlCR6OpAUMBIjAwyeslzoIX9uJf+JX9TAsf/SVm+zLDvnrbiMjfPXBSZ2MHL1SzS35gxYjrwO1eQhFuDm9X/PxdfwvmYRNLVE4OoxW3rOxKU+swAjdXd97IyqdzOao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hncz5h2x; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-24c9304b7bcso25382515ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 16:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757719444; x=1758324244; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=fLo/SEqM2VBVejoE7ds3n2zise52/J9CjN3ZQw5EHn8=;
        b=Hncz5h2xZGe2PAnu1O5UjGIJHeeADLi6aJyi4xVlL3YhNwIBaEApiW3NBeVHvpntTc
         2fN+Giws4icktUhMXKG/0x4gvX6cVPhGZ5zha5COeFa3c3YtJ6m02I9KFg5cjIfewYnW
         TBgrlSFnOhM79pScXRQUhsQoUfE0KSP3rzUZ0mDu69lXvTu2JdQ23hXI4vuWbtsmsoMH
         srYZ+UHCkm9Jgap7nSk8H9LOrEx3JNJ2YshD4L8pVmt6BTpP0lvIqp4NehXIHyR99TyU
         2wkIJ5AsjTHabc8t1U3MO/8yMTl5GuPEd/Fqfif3GCwNAPpismPVB+WgRK1ibBbh6x0f
         IaQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757719444; x=1758324244;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fLo/SEqM2VBVejoE7ds3n2zise52/J9CjN3ZQw5EHn8=;
        b=iqozsmP6STBaZx1d7zb9H7HbVBQygN68JNWvpgsQ2jTEOhEB7VsqFyvH/VzgsnkAd8
         Ib3Tk9T2cFYhi+4jgqCn0y3oXR4zrGJqEN+u/KzDOT+U/SJ+7bO5yX9Q30faLn0YPoAl
         wrpbCnVqCOMcmy1K77BRulxin3tLYBK7pnmEEb9OqfnPkZqmz4ghwwXDW/dZYvO+AnIr
         drKczA4SNPOXlN1n1cyrb2XFl/HehhZKXOApB1idodyYSo0+uQAwS9+AAwIWg6sZiZyv
         nNLC+oSCM0YzD2RS5ztMrczUpCn0fs7+XP7IByrFdckflevjFZl4iR0n4Zki0PPu+mQq
         DlFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXK7O6dgrYTRvccx0CrE9W4JTSAzEZUzBKv2Cxi8ET41798yPl1gBJqfn9mwYWGt2X0Tek4+BGVsLfa3rI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwguIaUwlnrQ2db41zh2hCTvXHZCEpQ8mGiWHeymqoVG/u8vNwd
	89yrOU24p+HOH3EypmqnEtNLG7taYtesvJfvJZGshaActbqgpU0rYQtWmIYl8VojOmcEycFDmHU
	vAtHwRg==
X-Google-Smtp-Source: AGHT+IFZ66G99jqjCPVcjm61uKkUswQxYM0js2Pq9O0QazFOGhxlaYFTFHswXm9x+i/mLtHDJdlNTlwG258=
X-Received: from pldr19.prod.google.com ([2002:a17:903:4113:b0:249:140e:945a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2f85:b0:249:1f5f:f9a2
 with SMTP id d9443c01a7336-25d21112648mr41894805ad.0.1757719444289; Fri, 12
 Sep 2025 16:24:04 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Sep 2025 16:23:00 -0700
In-Reply-To: <20250912232319.429659-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250912232319.429659-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250912232319.429659-23-seanjc@google.com>
Subject: [PATCH v15 22/41] KVM: nVMX: Add consistency checks for CR0.WP and CR4.CET
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Mathias Krause <minipli@grsecurity.net>, 
	John Allen <john.allen@amd.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Chao Gao <chao.gao@intel.com>, Maxim Levitsky <mlevitsk@redhat.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Zhang Yi Z <yi.z.zhang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

From: Chao Gao <chao.gao@intel.com>

Add consistency checks for CR4.CET and CR0.WP in guest-state or host-state
area in the VMCS12. This ensures that configurations with CR4.CET set and
CR0.WP not set result in VM-entry failure, aligning with architectural
behavior.

Tested-by: Mathias Krause <minipli@grsecurity.net>
Tested-by: John Allen <john.allen@amd.com>
Tested-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Chao Gao <chao.gao@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/nested.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 51d69f368689..a73f38d7eea1 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -3111,6 +3111,9 @@ static int nested_vmx_check_host_state(struct kvm_vcpu *vcpu,
 	    CC(!kvm_vcpu_is_legal_cr3(vcpu, vmcs12->host_cr3)))
 		return -EINVAL;
 
+	if (CC(vmcs12->host_cr4 & X86_CR4_CET && !(vmcs12->host_cr0 & X86_CR0_WP)))
+		return -EINVAL;
+
 	if (CC(is_noncanonical_msr_address(vmcs12->host_ia32_sysenter_esp, vcpu)) ||
 	    CC(is_noncanonical_msr_address(vmcs12->host_ia32_sysenter_eip, vcpu)))
 		return -EINVAL;
@@ -3225,6 +3228,9 @@ static int nested_vmx_check_guest_state(struct kvm_vcpu *vcpu,
 	    CC(!nested_guest_cr4_valid(vcpu, vmcs12->guest_cr4)))
 		return -EINVAL;
 
+	if (CC(vmcs12->guest_cr4 & X86_CR4_CET && !(vmcs12->guest_cr0 & X86_CR0_WP)))
+		return -EINVAL;
+
 	if ((vmcs12->vm_entry_controls & VM_ENTRY_LOAD_DEBUG_CONTROLS) &&
 	    (CC(!kvm_dr7_valid(vmcs12->guest_dr7)) ||
 	     CC(!vmx_is_valid_debugctl(vcpu, vmcs12->guest_ia32_debugctl, false))))
-- 
2.51.0.384.g4c02a37b29-goog


