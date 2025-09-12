Return-Path: <linux-kernel+bounces-814882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE2BB55A0F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 01:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C9121D62E9F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 23:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7641E2D5932;
	Fri, 12 Sep 2025 23:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ryTZbXL+"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285732D3EE1
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 23:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757719428; cv=none; b=YMLyNIFM7z3gizq2B9NQ8fOgtbzQ+tirg3gmI/4EYoXQvElAQQYzodzkE0lH7KS9E6Nlax/UGXlbe2Pk9ll0KRTv4/BnPcUMyYpF1TMOCw6kGk/tNm4PK2PTYsUQz+vL1p0trBtWHo5ygzZv4B7JUVYE/uzSUhgRA4xM6wu8748=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757719428; c=relaxed/simple;
	bh=jFuG8SZ3oXYlYLdNCqg5cGDDZwBjK3vSWtK4a4ni1t0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hyMkmr5Skdx86QhuFRDMTrEa/gsoUxZXoin6yeaMOar5XXjptUDJtuzOP0fCUF7Mc6VMwQjjn1nAQeUPMr1hXyCTYLCzUTlpA+4ejeYYqIbb+9gOOEalksg7JztEGPKjEOHB3yC5vTwvDt7T0qY8xiP9qiHc+DNAR0mbgx5R7Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ryTZbXL+; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-244581ce13aso49437955ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 16:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757719426; x=1758324226; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=/p8II4kIeI0l7K05B/fK4WrVrGU6imnR3v3OJDUj/Eo=;
        b=ryTZbXL+R8/JLVJOxAzG7L6OsvE6oPs1gjY7kBUQESX1xkYC90czzet2anRpl1XKsl
         isfYP/h9+2gw6YQt/Yb5RLnQIhtfIVkeDWZak3fkvOVZVHF28yJosnx52nrBTe0+jcUW
         SnOROEw/APue8F9kYKzoqSphteBADJCaX1/ytW4v35B6cRn8Jk4wRWtXgFxCumuD3TAu
         iI0jSmjoN2QBwZSMjtgTCS7NyV6xjpDSkX79b/LA4u/Uc8wWqR0gL5ZwX9TZS0UgPNAB
         H2AoZYnQVxIbapRJwSxY7zdIiLHStUtjf9Sy9qnoWREMzKe0Cc0tqfObCHE+5Q++deuF
         jGpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757719426; x=1758324226;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/p8II4kIeI0l7K05B/fK4WrVrGU6imnR3v3OJDUj/Eo=;
        b=rzto+ocbE0yv8ukH8Qnd0DibeqUTfnBX562ZFIAz5x5SQDLEzS1yhQI2zY4UFJcps4
         W5zYr5hJe3wQg3h54ansL3Q8m/4B8khJ16mJHasI9okt1y+Un5Ivopse0K5/KVkPjS4O
         GXmJBJQQBAWYddNRgau58KahCzPGmQSQ8cjrjsSEoSoB8lb1L03TnQ3x+YBYUQccFDXI
         T+EM96RcSrLIJXFdfNuX9oRbFAc7fYnuFoZQm41E0o1WwpOEZh4th7gBTRbhsPsJUp8T
         EHJP+nUtiqvuJeA4BqSH3tGIMC8D0x2r7yhix434/u8olLO4lTqvP19NvjoQQH7vFHVj
         Vjtw==
X-Forwarded-Encrypted: i=1; AJvYcCVyi2NV1iTSSUfEpqD9F/+DihYwZmBbPzRTKOz3dfMEHGz0Zv/1g26DzPkFc7eghAhD1yLSAAZKWG+igXw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZVcAQai+QhkN3dapEo5Ys3r5bvRoV7wKw9xkmENy+bKYDmXM0
	LFh57peOLiY91ubI7qJCwJVLNo8xWYKlGnxQ2XpdKiuLEKeV3pREyLGcfXzjZGGtayjfAqL+eu5
	0Fd1UQg==
X-Google-Smtp-Source: AGHT+IGg6dmIXvzm4jTWf6m62O2N/yxsDeCk+4Uiji5QF9e6I/audnB9epImW8IR/7OE1mc+Q57D/Ute5Lo=
X-Received: from pjcc4.prod.google.com ([2002:a17:90b:5744:b0:325:a8d:a485])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:4b47:b0:246:464d:118a
 with SMTP id d9443c01a7336-25d26d4d433mr54398555ad.46.1757719426448; Fri, 12
 Sep 2025 16:23:46 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 12 Sep 2025 16:22:50 -0700
In-Reply-To: <20250912232319.429659-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250912232319.429659-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250912232319.429659-13-seanjc@google.com>
Subject: [PATCH v15 12/41] KVM: VMX: Introduce CET VMCS fields and control bits
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Mathias Krause <minipli@grsecurity.net>, 
	John Allen <john.allen@amd.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Chao Gao <chao.gao@intel.com>, Maxim Levitsky <mlevitsk@redhat.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Zhang Yi Z <yi.z.zhang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

From: Yang Weijiang <weijiang.yang@intel.com>

Control-flow Enforcement Technology (CET) is a kind of CPU feature used
to prevent Return/CALL/Jump-Oriented Programming (ROP/COP/JOP) attacks.
It provides two sub-features(SHSTK,IBT) to defend against ROP/COP/JOP
style control-flow subversion attacks.

Shadow Stack (SHSTK):
  A shadow stack is a second stack used exclusively for control transfer
  operations. The shadow stack is separate from the data/normal stack and
  can be enabled individually in user and kernel mode. When shadow stack
  is enabled, CALL pushes the return address on both the data and shadow
  stack. RET pops the return address from both stacks and compares them.
  If the return addresses from the two stacks do not match, the processor
  generates a #CP.

Indirect Branch Tracking (IBT):
  IBT introduces instruction(ENDBRANCH)to mark valid target addresses of
  indirect branches (CALL, JMP etc...). If an indirect branch is executed
  and the next instruction is _not_ an ENDBRANCH, the processor generates
  a #CP. These instruction behaves as a NOP on platforms that have no CET.

Several new CET MSRs are defined to support CET:
  MSR_IA32_{U,S}_CET: CET settings for {user,supervisor} CET respectively.

  MSR_IA32_PL{0,1,2,3}_SSP: SHSTK pointer linear address for CPL{0,1,2,3}.

  MSR_IA32_INT_SSP_TAB: Linear address of SHSTK pointer table, whose entry
			is indexed by IST of interrupt gate desc.

Two XSAVES state bits are introduced for CET:
  IA32_XSS:[bit 11]: Control saving/restoring user mode CET states
  IA32_XSS:[bit 12]: Control saving/restoring supervisor mode CET states.

Six VMCS fields are introduced for CET:
  {HOST,GUEST}_S_CET: Stores CET settings for kernel mode.
  {HOST,GUEST}_SSP: Stores current active SSP.
  {HOST,GUEST}_INTR_SSP_TABLE: Stores current active MSR_IA32_INT_SSP_TAB.

On Intel platforms, two additional bits are defined in VM_EXIT and VM_ENTRY
control fields:
If VM_EXIT_LOAD_CET_STATE = 1, host CET states are loaded from following
VMCS fields at VM-Exit:
  HOST_S_CET
  HOST_SSP
  HOST_INTR_SSP_TABLE

If VM_ENTRY_LOAD_CET_STATE = 1, guest CET states are loaded from following
VMCS fields at VM-Entry:
  GUEST_S_CET
  GUEST_SSP
  GUEST_INTR_SSP_TABLE

Co-developed-by: Zhang Yi Z <yi.z.zhang@linux.intel.com>
Signed-off-by: Zhang Yi Z <yi.z.zhang@linux.intel.com>
Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
Reviewed-by: Chao Gao <chao.gao@intel.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Tested-by: Mathias Krause <minipli@grsecurity.net>
Tested-by: John Allen <john.allen@amd.com>
Tested-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Chao Gao <chao.gao@intel.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/vmx.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/include/asm/vmx.h b/arch/x86/include/asm/vmx.h
index cca7d6641287..ce10a7e2d3d9 100644
--- a/arch/x86/include/asm/vmx.h
+++ b/arch/x86/include/asm/vmx.h
@@ -106,6 +106,7 @@
 #define VM_EXIT_CLEAR_BNDCFGS                   0x00800000
 #define VM_EXIT_PT_CONCEAL_PIP			0x01000000
 #define VM_EXIT_CLEAR_IA32_RTIT_CTL		0x02000000
+#define VM_EXIT_LOAD_CET_STATE                  0x10000000
 
 #define VM_EXIT_ALWAYSON_WITHOUT_TRUE_MSR	0x00036dff
 
@@ -119,6 +120,7 @@
 #define VM_ENTRY_LOAD_BNDCFGS                   0x00010000
 #define VM_ENTRY_PT_CONCEAL_PIP			0x00020000
 #define VM_ENTRY_LOAD_IA32_RTIT_CTL		0x00040000
+#define VM_ENTRY_LOAD_CET_STATE                 0x00100000
 
 #define VM_ENTRY_ALWAYSON_WITHOUT_TRUE_MSR	0x000011ff
 
@@ -369,6 +371,9 @@ enum vmcs_field {
 	GUEST_PENDING_DBG_EXCEPTIONS    = 0x00006822,
 	GUEST_SYSENTER_ESP              = 0x00006824,
 	GUEST_SYSENTER_EIP              = 0x00006826,
+	GUEST_S_CET                     = 0x00006828,
+	GUEST_SSP                       = 0x0000682a,
+	GUEST_INTR_SSP_TABLE            = 0x0000682c,
 	HOST_CR0                        = 0x00006c00,
 	HOST_CR3                        = 0x00006c02,
 	HOST_CR4                        = 0x00006c04,
@@ -381,6 +386,9 @@ enum vmcs_field {
 	HOST_IA32_SYSENTER_EIP          = 0x00006c12,
 	HOST_RSP                        = 0x00006c14,
 	HOST_RIP                        = 0x00006c16,
+	HOST_S_CET                      = 0x00006c18,
+	HOST_SSP                        = 0x00006c1a,
+	HOST_INTR_SSP_TABLE             = 0x00006c1c
 };
 
 /*
-- 
2.51.0.384.g4c02a37b29-goog


