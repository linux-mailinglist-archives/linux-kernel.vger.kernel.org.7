Return-Path: <linux-kernel+bounces-825291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 099FDB8B805
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 00:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 793C91749A5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 22:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937332F39A7;
	Fri, 19 Sep 2025 22:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O0kig3pp"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345962D739A
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 22:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758321223; cv=none; b=J6dEdW5dmrmODNJWMCvYvHIzPPdtlx1ZKR4NOvb23mk18qN2jRle9rjtV7aXL/+SaqGirrCeP/SynttGxKXa+zmFd9Scklh8tMnPlpxrOGcegHyp/8QvgGB3BLmOhTVaHYHH0LgaLlo1mFf+AOaN/TErqnIHX8ed/c50abOiItw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758321223; c=relaxed/simple;
	bh=wgYw8ozkadV8sXS3nZIwTZqPK/YSRs0FDT9dSwL/FF8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q/druNKZE+WxI7Bn52rRsMEQhNPO0zH5XOg3pxZ73MdqYywRvpYMRNoPcYLQivG/XMZVdkWuclxjnJb9NACLhe91xwdFGZGmW74kLvBj9Qc4U/+fMW2bZG6G7DNJTM95/K+TLIsBO7Lyr4N1JrnZac0Fk+lDaE9fLFEQ4luac7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O0kig3pp; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b5515a1f5b8so1212902a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 15:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758321221; x=1758926021; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=bCIuuIHnaL0fIYMIiIbisfqCMaEn93EQb+W1xCqgz9Q=;
        b=O0kig3ppSMhe9rB839/Bqb/SnSmg8o8azSCkuLlfnPDx4gR/fi008jLTkh6meGT/wg
         T5LxYyM+eKnL77oUE5ilmrwqSYBGNaWLipDMN2TLjMAz4wHCUtCRN/ZLVMrK2vEtZlnX
         0mwT05DN42SCvFgb9aMTc9ovVs7ZbqKSLzUTCvGd6LyDUfBAZjLxwEbSudt0Kiaq7vLw
         4o3RuceQK0II83FkWJq8x+07FtHDZjuO0lq3d2mkw3mWw21PKLgvn4iDaYzRPD9/qEoD
         lcrvFvAMTtFxYMaMwqzcebLRkrzYOKpyub+IbljTpiP/UpmxfosuuiG1Qcv9CCeKouGr
         oN9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758321221; x=1758926021;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bCIuuIHnaL0fIYMIiIbisfqCMaEn93EQb+W1xCqgz9Q=;
        b=IdWOEKosXvatshkKrBOsqd7UoavpIpNjvOJquN50r64m6BUEk+MxPf8SHSKJclpdVH
         xh3LNyH1twIp6iypDvB+vcJ5IRJXozatTZ7x1wzt7MgJcPMoOL5S0VhIucarMMEWqsHS
         j4rTysD+vlnUQpndBvtQaeNc+Pwnqer79KaQigt7psA1cW8ryDTwyitFKITsc22oOaX3
         DDz3fZS5ifHCADiYbSyCwjLne7JLTLwU6jfeyIAIvrarQiGg9KOiiPuGOse8i0Pg9NpO
         94aml/VgvNvUI2i8XMjxjFVEm6050fpGsQagfx5RXCqwQBPiMn68Geazi3vjnRgrf366
         w8tg==
X-Forwarded-Encrypted: i=1; AJvYcCW/kNfindCtoK0imie66WTg/5qjB0DtEUuLgjxXyBO4kgHmqNqtbK8I1NKovbS+DLyv7GKsBylVcJDK9EY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/PeW/aEOPgUl89PUj8HnZQ6vEp//gEIxaOXppNh31AQhLE3c0
	2e3CFGNrnlaJXBeWgfG4yxHXGBcw/hinr+bcKUeM9HZpHwUROr7ynp1nX2gJvbV0TqKVKf2ehh7
	3MqyuSA==
X-Google-Smtp-Source: AGHT+IELLZM/jwk7FC1E3YNdiVUktTtTGDXXOG0EsAH4gahBIguSEvIoz5oJuiX5uW4836VqNGg9D748hx8=
X-Received: from pjh16.prod.google.com ([2002:a17:90b:3f90:b0:32f:d1f3:646f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1b11:b0:32d:f352:f764
 with SMTP id 98e67ed59e1d1-33097feda1cmr4993404a91.2.1758321221548; Fri, 19
 Sep 2025 15:33:41 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 19 Sep 2025 15:32:27 -0700
In-Reply-To: <20250919223258.1604852-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250919223258.1604852-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
Message-ID: <20250919223258.1604852-21-seanjc@google.com>
Subject: [PATCH v16 20/51] KVM: x86: Emulate SSP[63:32]!=0 #GP(0) for FAR JMP
 to 32-bit mode
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Mathias Krause <minipli@grsecurity.net>, 
	John Allen <john.allen@amd.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Chao Gao <chao.gao@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Maxim Levitsky <mlevitsk@redhat.com>, 
	Zhang Yi Z <yi.z.zhang@linux.intel.com>, Xin Li <xin@zytor.com>
Content-Type: text/plain; charset="UTF-8"

Emulate the Shadow Stack restriction that the current SSP must be a 32-bit
value on a FAR JMP from 64-bit mode to compatibility mode.  From the SDM's
pseudocode for FAR JMP:

  IF ShadowStackEnabled(CPL)
    IF (IA32_EFER.LMA and DEST(segment selector).L) = 0
      (* If target is legacy or compatibility mode then the SSP must be in low 4GB *)
      IF (SSP & 0xFFFFFFFF00000000 != 0); THEN
        #GP(0);
      FI;
    FI;
  FI;

Note, only the current CPL needs to be considered, as FAR JMP can't be
used for inter-privilege level transfers, and KVM rejects emulation of all
other far branch instructions when Shadow Stacks are enabled.

To give the emulator access to GUEST_SSP, special case handling
MSR_KVM_INTERNAL_GUEST_SSP in emulator_get_msr() to treat the access as a
host access (KVM doesn't allow guest accesses to internal "MSRs").  The
->get_msr() API is only used for implicit accesses from the emulator, i.e.
is only used with hardcoded MSR indices, and so any access to
MSR_KVM_INTERNAL_GUEST_SSP is guaranteed to be from KVM, i.e. not from the
guest via RDMSR.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/emulate.c | 35 +++++++++++++++++++++++++++++++++++
 arch/x86/kvm/x86.c     |  9 +++++++++
 2 files changed, 44 insertions(+)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index dc0249929cbf..5c5fb6a6f7f9 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -1605,6 +1605,37 @@ static int write_segment_descriptor(struct x86_emulate_ctxt *ctxt,
 	return linear_write_system(ctxt, addr, desc, sizeof(*desc));
 }
 
+static bool emulator_is_ssp_invalid(struct x86_emulate_ctxt *ctxt, u8 cpl)
+{
+	const u32 MSR_IA32_X_CET = cpl == 3 ? MSR_IA32_U_CET : MSR_IA32_S_CET;
+	u64 efer = 0, cet = 0, ssp = 0;
+
+	if (!(ctxt->ops->get_cr(ctxt, 4) & X86_CR4_CET))
+		return false;
+
+	if (ctxt->ops->get_msr(ctxt, MSR_EFER, &efer))
+		return true;
+
+	/* SSP is guaranteed to be valid if the vCPU was already in 32-bit mode. */
+	if (!(efer & EFER_LMA))
+		return false;
+
+	if (ctxt->ops->get_msr(ctxt, MSR_IA32_X_CET, &cet))
+		return true;
+
+	if (!(cet & CET_SHSTK_EN))
+		return false;
+
+	if (ctxt->ops->get_msr(ctxt, MSR_KVM_INTERNAL_GUEST_SSP, &ssp))
+		return true;
+
+	/*
+	 * On transfer from 64-bit mode to compatibility mode, SSP[63:32] must
+	 * be 0, i.e. SSP must be a 32-bit value outside of 64-bit mode.
+	 */
+	return ssp >> 32;
+}
+
 static int __load_segment_descriptor(struct x86_emulate_ctxt *ctxt,
 				     u16 selector, int seg, u8 cpl,
 				     enum x86_transfer_type transfer,
@@ -1745,6 +1776,10 @@ static int __load_segment_descriptor(struct x86_emulate_ctxt *ctxt,
 			if (efer & EFER_LMA)
 				goto exception;
 		}
+		if (!seg_desc.l && emulator_is_ssp_invalid(ctxt, cpl)) {
+			err_code = 0;
+			goto exception;
+		}
 
 		/* CS(RPL) <- CPL */
 		selector = (selector & 0xfffc) | cpl;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0c060e506f9d..40596fc5142e 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8741,6 +8741,15 @@ static int emulator_set_msr_with_filter(struct x86_emulate_ctxt *ctxt,
 static int emulator_get_msr(struct x86_emulate_ctxt *ctxt,
 			    u32 msr_index, u64 *pdata)
 {
+	/*
+	 * Treat emulator accesses to the current shadow stack pointer as host-
+	 * initiated, as they aren't true MSR accesses (SSP is a "just a reg"),
+	 * and this API is used only for implicit accesses, i.e. not RDMSR, and
+	 * so the index is fully KVM-controlled.
+	 */
+	if (unlikely(msr_index == MSR_KVM_INTERNAL_GUEST_SSP))
+		return kvm_msr_read(emul_to_vcpu(ctxt), msr_index, pdata);
+
 	return __kvm_emulate_msr_read(emul_to_vcpu(ctxt), msr_index, pdata);
 }
 
-- 
2.51.0.470.ga7dc726c21-goog


