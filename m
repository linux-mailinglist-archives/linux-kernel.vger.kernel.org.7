Return-Path: <linux-kernel+bounces-891208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D92C42268
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 01:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D781E4EBEF6
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 00:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A737F28A72B;
	Sat,  8 Nov 2025 00:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uMS1n4ZF"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BE323BD1F
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 00:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762562757; cv=none; b=qM9WQjIBXWAtPiXMmqUD99DupqW5lugx8DAHAEbD/qWs6S1GXOdXqL6sFXkeQtt2b+O+oJaNRlcf6ojrQ8uJEZOpiBA+udTBfYiIHfYCLA+ngxTpjHeSTHhaIeTRgkkJay9fORONbeUzYSUf6XUM1ADOcW6F/bntbMNhOl8qXmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762562757; c=relaxed/simple;
	bh=x85JRd3eoh4Fmbm0hw42uUNA1ySyfDcR++08WBtPvAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YBAc+xdW3QmhVjOR3RY+NR7l4I0lY+vuLlmLQWrrxowKrGkqN6nWhHwdHQSTUi96x0MLHNgHUHg5xdxxQT1kM1dmLV2QOvlHxB/dO75QRD16QDuCGPg4eCpcI9PXD9JNbfdGrOgSbRqHjd25kS4cc1PNi3WhIGrQNzRO1dsmf0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uMS1n4ZF; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762562751;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dqxsukY6YvoTOTLjaVVpP8tsHHl1y/4M81vp3qGNAj8=;
	b=uMS1n4ZFUiK46BRYuOJuLrtZiJU2mpDTu4SgcqddDGtQc2V31e7+h9DIQ0WDcvT0Bweihi
	ftPnMmy3y1Dz8w5KNmkhH3VqKPZabohnTCjKFppzy3L4qLTixb9P88szrfwvr5Xi5WcHes
	BqGCFbKe9Jd9/Bx6ub79Dq/o5oyCSAw=
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	Maxim Levitsky <mlevitsk@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Matteo Rizzo <matteorizzo@google.com>,
	evn@google.com
Subject: [PATCH 1/6] KVM: SVM: Mark VMCB_LBR dirty when MSR_IA32_DEBUGCTLMSR is updated
Date: Sat,  8 Nov 2025 00:45:19 +0000
Message-ID: <20251108004524.1600006-2-yosry.ahmed@linux.dev>
In-Reply-To: <20251108004524.1600006-1-yosry.ahmed@linux.dev>
References: <20251108004524.1600006-1-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Clear the VMCB_LBR clean bit when MSR_IA32_DEBUGCTLMSR is updated, as
the only valid bit is DEBUGCTLMSR_LBR.

The history is complicated, it was correctly cleared for L1 before
commit 1d5a1b5860ed ("KVM: x86: nSVM: correctly virtualize LBR msrs when
L2 is running"), then the latter relied on svm_update_lbrv() to clear
it, but it only did so for L2. Go back to clearing it directly in
svm_set_msr().

Fixes: 1d5a1b5860ed ("KVM: x86: nSVM: correctly virtualize LBR msrs when L2 is running")
Reported-by: Matteo Rizzo <matteorizzo@google.com>
Reported-by: evn@google.com
Co-developed-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
---
 arch/x86/kvm/svm/svm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 55bd7aa5cd743..d25c56b30b4e2 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3009,7 +3009,11 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
 		if (data & DEBUGCTL_RESERVED_BITS)
 			return 1;
 
+		if (svm_get_lbr_vmcb(svm)->save.dbgctl == data)
+			break;
+
 		svm_get_lbr_vmcb(svm)->save.dbgctl = data;
+		vmcb_mark_dirty(svm->vmcb, VMCB_LBR);
 		svm_update_lbrv(vcpu);
 		break;
 	case MSR_VM_HSAVE_PA:
-- 
2.51.2.1041.gc1ab5b90ca-goog


