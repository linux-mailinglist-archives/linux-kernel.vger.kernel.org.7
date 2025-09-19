Return-Path: <linux-kernel+bounces-825272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21991B8B79F
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 00:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E90AF1CC0B01
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 22:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E362D63E4;
	Fri, 19 Sep 2025 22:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XoErpupl"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F14E25F784
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 22:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758321186; cv=none; b=maFQBEKFnTx1BfvMBOcRHEzEWlrcvy811RjnWXZisS3xWVjCeBxB8/eOrv+9LQSyN6gAKuNpawdHTT36kzscB24Fw+OjkVNeyrbdoB/Llnl0IUHhZMoc9MeNfZvlRKYYQFAWzb8sXio4CBMOg7kOfunT7ucibBFksq0Tg/MZk1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758321186; c=relaxed/simple;
	bh=XlnjwGb/Uv8iDC4X4PssXMxOuSIkF9nMxyWo059j3B4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pSOvO4vZXWVBu+ZWz+HrE0se2baUMoR6kf4wEfgTCMFms/U0Wns6YZPgUc3lXSXgAAddej3E/9HwL1J8fzg0UOJyfVqLkCVKB1ac7SDb4RABp7UqwN/rsWRZt2Yc5cgR1+U22xC+9GbpE05fiwyK+BaEJA2RV77ndx351PRbIcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XoErpupl; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b55153c5ef2so1334385a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 15:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758321184; x=1758925984; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=cBtq0KlbJNaCLdLypdNbSmqpzS3YAzcVYonMlUie8jk=;
        b=XoErpuplShWczCMlTSNb5Jrg0rcnSzKhLV7Wabm4OuYGe35G0wkeHGLHTJuP4biesd
         QRqx7vwcsBBL4gd0FJaFsGIOY+rW5+VwZ6SBtRzYDl8gTddBZzVLp278ORFCXlc6m4I9
         Yyssg+ehJ3lCmKB/RZVUI+s3A6EOWEo/IBQaAGqhanGj38GIjm+gNFNTu/nKCdmP7s45
         sysK/a9005tzTx9CtkhcZfAkFYsLda0s6b15d2NRAXP7vPSxCy7BKW7SCm14w3q/tz1o
         IZQo/+K6QmoultAn3le5SAojOlttjGhJw9gP4g1WUGqQOHWUQaDim88uOlaoBChWBwOB
         PtPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758321184; x=1758925984;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cBtq0KlbJNaCLdLypdNbSmqpzS3YAzcVYonMlUie8jk=;
        b=UfHRjZ/Vx61LkwTt+nGcMP5i0+ZCeXblyTGi8Q7Npei1PbMnUu1VlRRi3KvhCP1MbL
         Aixyo8GUtLnBfblMv2M2m2Jyc2KC30gdeh+z756vZuX4AbOtK1NU7LS6qyZJ46R0cf6A
         TYucGhu5g0jM9CPxPemLwdkJNft/RZcTYFwb/l3Qgj4KLKZ5g4UQ7BTyhmVqCyuEsvQk
         oymiIF+M7RSoQ7Iiy2SiInb/TDjoYEm6r/qMjeYuPLp7lF2gYlYKdQ3pd5nUVwZ4EgCV
         V3Sui6Fb1yzOqfK6dcZ/nLlTtI/izVJ6bNxmv1c42alxstoI7oCKj0csc7GadA6xksND
         BKIA==
X-Forwarded-Encrypted: i=1; AJvYcCXfHvC6wLww2h0IvJALUHTSmfxoQBlPJQ3nrPc3EYukhKct1xGbFjlaAM8H4WVUL5uG8gkeqPbiHKuUhLY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+bH6DvRQv3uj/oMj17BSvxi/Z28qNKtpbtg29lc8iP1sMFV45
	9MapgoUmWs6DywECfBLFHhRRsLswO5XxDG31nNvdxzi+yqI0WSLJzXMgb/K5ggVwajWMIx1A4vM
	tb5NPZg==
X-Google-Smtp-Source: AGHT+IFc0Q3XMUJzbgN7Ff9HbAiLY51qcwkDIquE2sFhMr2ysXppYnkJ+NuTwBMNRjK9zuprNbkFBID862w=
X-Received: from pjbqx3.prod.google.com ([2002:a17:90b:3e43:b0:32b:61c4:e48b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:7d9b:b0:252:9bf:ad80
 with SMTP id adf61e73a8af0-29274fb76b1mr7728324637.54.1758321184578; Fri, 19
 Sep 2025 15:33:04 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 19 Sep 2025 15:32:08 -0700
In-Reply-To: <20250919223258.1604852-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250919223258.1604852-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
Message-ID: <20250919223258.1604852-2-seanjc@google.com>
Subject: [PATCH v16 01/51] KVM: SEV: Rename kvm_ghcb_get_sw_exit_code() to kvm_get_cached_sw_exit_code()
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Mathias Krause <minipli@grsecurity.net>, 
	John Allen <john.allen@amd.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Chao Gao <chao.gao@intel.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Maxim Levitsky <mlevitsk@redhat.com>, 
	Zhang Yi Z <yi.z.zhang@linux.intel.com>, Xin Li <xin@zytor.com>
Content-Type: text/plain; charset="UTF-8"

Rename kvm_ghcb_get_sw_exit_code() to kvm_get_cached_sw_exit_code() to make
it clear that KVM is getting the cached value, not reading directly from
the guest-controlled GHCB.  More importantly, vacating
kvm_ghcb_get_sw_exit_code() will allow adding a KVM-specific macro-built
kvm_ghcb_get_##field() helper to read values from the GHCB.

No functional change intended.

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/svm/sev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index cce48fff2e6c..f046a587ecaf 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3264,7 +3264,7 @@ void sev_free_vcpu(struct kvm_vcpu *vcpu)
 		kvfree(svm->sev_es.ghcb_sa);
 }
 
-static u64 kvm_ghcb_get_sw_exit_code(struct vmcb_control_area *control)
+static u64 kvm_get_cached_sw_exit_code(struct vmcb_control_area *control)
 {
 	return (((u64)control->exit_code_hi) << 32) | control->exit_code;
 }
@@ -3290,7 +3290,7 @@ static void dump_ghcb(struct vcpu_svm *svm)
 	 */
 	pr_err("GHCB (GPA=%016llx) snapshot:\n", svm->vmcb->control.ghcb_gpa);
 	pr_err("%-20s%016llx is_valid: %u\n", "sw_exit_code",
-	       kvm_ghcb_get_sw_exit_code(control), kvm_ghcb_sw_exit_code_is_valid(svm));
+	       kvm_get_cached_sw_exit_code(control), kvm_ghcb_sw_exit_code_is_valid(svm));
 	pr_err("%-20s%016llx is_valid: %u\n", "sw_exit_info_1",
 	       control->exit_info_1, kvm_ghcb_sw_exit_info_1_is_valid(svm));
 	pr_err("%-20s%016llx is_valid: %u\n", "sw_exit_info_2",
@@ -3379,7 +3379,7 @@ static int sev_es_validate_vmgexit(struct vcpu_svm *svm)
 	 * Retrieve the exit code now even though it may not be marked valid
 	 * as it could help with debugging.
 	 */
-	exit_code = kvm_ghcb_get_sw_exit_code(control);
+	exit_code = kvm_get_cached_sw_exit_code(control);
 
 	/* Only GHCB Usage code 0 is supported */
 	if (svm->sev_es.ghcb->ghcb_usage) {
@@ -4384,7 +4384,7 @@ int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
 
 	svm_vmgexit_success(svm, 0);
 
-	exit_code = kvm_ghcb_get_sw_exit_code(control);
+	exit_code = kvm_get_cached_sw_exit_code(control);
 	switch (exit_code) {
 	case SVM_VMGEXIT_MMIO_READ:
 		ret = setup_vmgexit_scratch(svm, true, control->exit_info_2);
-- 
2.51.0.470.ga7dc726c21-goog


