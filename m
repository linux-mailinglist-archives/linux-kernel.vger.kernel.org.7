Return-Path: <linux-kernel+bounces-894260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE51DC49992
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 23:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B11B3B20B0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 22:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04E2340D93;
	Mon, 10 Nov 2025 22:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rv3iYpdh"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62308340A7A
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 22:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762813804; cv=none; b=dqMdu8UzBIpmYZwMBgyhjIZ6wKOFkU1h7BtC2tQPTA3Mj7TRAr//KpAo8btKn/GDFMYlPX/rditGEYhcSMK9QQkmrbPaC0PhgnFjGoXTSqSvKn1jddqzpYthbmBNfl8uIgR006l4zcX9H/NmAccai230n/56mKp6dNGIPRIoLs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762813804; c=relaxed/simple;
	bh=SrmYL7HiCpgm4vjtAgnGlIDPHOZzMLiFMexWKIIKQI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a0bPHCmweFYeAwrVvBjoWumTOn5iClszgKvn9cM7VpngDYCjG/8eeVimmvXGAowlS/WwSnTanb8P2BTtfpePfxa6QO9bpDi3xyWm33qqQfdBJsTLanhJ+5e65+vZWATRGsdJ/Gtwb0qZ3/C5Uuj4BplG3YfoOucXQyOGnpe3Qbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rv3iYpdh; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762813800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QRChNnbAOtY4MB+fTlu6wng1ikuj7N/aEOeEGMy7akE=;
	b=rv3iYpdh4KaQaxQCo5x0yPiyHlkzW9TIqCdH+whctoMq5oQ48vB8aU+HcGhCIYIzGmZEtI
	0+DpLL7R4aBMP2IJnuAG7A5Eh3DIBvPCp4RPO9yb1a+PTBjjlEvrJrMe6hT6UhmT0fnMGp
	Do4v1nqVGGcx4nX9TraxVJF4m+C0e78=
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry.ahmed@linux.dev>
Subject: [PATCH v2 11/13] KVM: nSVM: Simplify nested_svm_vmrun()
Date: Mon, 10 Nov 2025 22:29:20 +0000
Message-ID: <20251110222922.613224-12-yosry.ahmed@linux.dev>
In-Reply-To: <20251110222922.613224-1-yosry.ahmed@linux.dev>
References: <20251110222922.613224-1-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Call nested_svm_merge_msrpm() from enter_svm_guest_mode() if called from
the VMRUN path, instead of making the call in nested_svm_vmrun(). This
simplifies the flow of nested_svm_vmrun() and removes all jumps to
cleanup labels.

Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
---
 arch/x86/kvm/svm/nested.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index a48668c36a191..89830380cebc5 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1020,6 +1020,9 @@ int enter_svm_guest_mode(struct kvm_vcpu *vcpu, u64 vmcb12_gpa, bool from_vmrun)
 
 	nested_svm_hv_update_vm_vp_ids(vcpu);
 
+	if (from_vmrun && !nested_svm_merge_msrpm(vcpu))
+		return -1;
+
 	return 0;
 }
 
@@ -1105,23 +1108,18 @@ int nested_svm_vmrun(struct kvm_vcpu *vcpu)
 
 	svm->nested.nested_run_pending = 1;
 
-	if (enter_svm_guest_mode(vcpu, vmcb12_gpa, true))
-		goto out_exit_err;
-
-	if (nested_svm_merge_msrpm(vcpu))
-		return ret;
-
-out_exit_err:
-	svm->nested.nested_run_pending = 0;
-	svm->nmi_l1_to_l2 = false;
-	svm->soft_int_injected = false;
+	if (enter_svm_guest_mode(vcpu, vmcb12_gpa, true)) {
+		svm->nested.nested_run_pending = 0;
+		svm->nmi_l1_to_l2 = false;
+		svm->soft_int_injected = false;
 
-	svm->vmcb->control.exit_code    = SVM_EXIT_ERR;
-	svm->vmcb->control.exit_code_hi = 0;
-	svm->vmcb->control.exit_info_1  = 0;
-	svm->vmcb->control.exit_info_2  = 0;
+		svm->vmcb->control.exit_code    = SVM_EXIT_ERR;
+		svm->vmcb->control.exit_code_hi = 0;
+		svm->vmcb->control.exit_info_1  = 0;
+		svm->vmcb->control.exit_info_2  = 0;
 
-	nested_svm_vmexit(svm);
+		nested_svm_vmexit(svm);
+	}
 	return ret;
 }
 
-- 
2.51.2.1041.gc1ab5b90ca-goog


