Return-Path: <linux-kernel+bounces-862355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C1ABF512E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCC003A4D17
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 07:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84E828D829;
	Tue, 21 Oct 2025 07:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KRP1DvZy"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106E027A107
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 07:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761032920; cv=none; b=Wb0HC0NOvLIVdrnLy04SdVjFs8/zZvaary4QIoWGmINdbJ+f7BpjM79Ly9CoTm7k0cT7s48Fv75BSwp6kB6DdPPy+7WF1v3n7AqzfbGXTT8ZUn324XR2tHpDteK+GBvu6NZ5UrHVux4bTO+qBZ4DhRUQ4ojZpN6rhWrtmSzUe3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761032920; c=relaxed/simple;
	bh=AuvEhvIJR3xZSW/fboQgnttC+/rNhF/c1gYAcgwTFic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oPrllAEdw3EdD67qOdIW9Lru7r/O/a6+HRMZMNvjKidyIORl4eBScRUEJvkGg0/9MO4wSWeSjy/ovoazEaSaveDY/3nx0V2fK3MUcsvD6sQl6LwTFpewgOgpCgy79rp5NNr8hjJ/tpiOhViF/dbnXRw0zVYg/+PrYmU1AjYdIes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KRP1DvZy; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761032913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TVpVX05niv4fkQ2AMp5Au3Rmh+KHdWv7OtN3c3soNew=;
	b=KRP1DvZyXBtXBEO1mUafQoINxkKSqK1QOimkIrGPK3goW4V6oZwVdy03sjnBnXzyai5lRd
	0Iy3A2j9qeTC0h2QUMN5KfKP8RFWaRGjqRVSI0wJnpuxI6pQvjFiKAztCr4E5X1X1FDmQ3
	wyg/fLeacWtYezcEOfsunUTHrbo4Ox4=
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	Jim Mattson <jmattson@google.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yosry Ahmed <yosry.ahmed@linux.dev>
Subject: [PATCH v2 06/23] KVM: selftests: Extend nested_invalid_cr3_test to cover SVM
Date: Tue, 21 Oct 2025 07:47:19 +0000
Message-ID: <20251021074736.1324328-7-yosry.ahmed@linux.dev>
In-Reply-To: <20251021074736.1324328-1-yosry.ahmed@linux.dev>
References: <20251021074736.1324328-1-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add SVM L1 code to run the nested guest, and allow the test to run with
SVM as well as VMX.

Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>
---
 .../kvm/x86/nested_invalid_cr3_test.c         | 43 +++++++++++++++++--
 1 file changed, 40 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/nested_invalid_cr3_test.c b/tools/testing/selftests/kvm/x86/nested_invalid_cr3_test.c
index b9853ab532cfe..2a472440cb962 100644
--- a/tools/testing/selftests/kvm/x86/nested_invalid_cr3_test.c
+++ b/tools/testing/selftests/kvm/x86/nested_invalid_cr3_test.c
@@ -9,6 +9,7 @@
  */
 #include "kvm_util.h"
 #include "vmx.h"
+#include "svm_util.h"
 #include "kselftest.h"
 
 
@@ -19,6 +20,28 @@ static void l2_guest_code(void)
 	vmcall();
 }
 
+static void l1_svm_code(struct svm_test_data *svm)
+{
+	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
+	uintptr_t save_cr3;
+
+	generic_svm_setup(svm, l2_guest_code,
+			  &l2_guest_stack[L2_GUEST_STACK_SIZE]);
+
+	/* Try to run L2 with invalid CR3 and make sure it fails */
+	save_cr3 = svm->vmcb->save.cr3;
+	svm->vmcb->save.cr3 = -1ull;
+	run_guest(svm->vmcb, svm->vmcb_gpa);
+	GUEST_ASSERT(svm->vmcb->control.exit_code == SVM_EXIT_ERR);
+
+	/* Now restore CR3 and make sure L2 runs successfully */
+	svm->vmcb->save.cr3 = save_cr3;
+	run_guest(svm->vmcb, svm->vmcb_gpa);
+	GUEST_ASSERT(svm->vmcb->control.exit_code == SVM_EXIT_VMMCALL);
+
+	GUEST_DONE();
+}
+
 static void l1_vmx_code(struct vmx_pages *vmx_pages)
 {
 	unsigned long l2_guest_stack[L2_GUEST_STACK_SIZE];
@@ -45,16 +68,30 @@ static void l1_vmx_code(struct vmx_pages *vmx_pages)
 	GUEST_DONE();
 }
 
+static void l1_guest_code(void *data)
+{
+	if (this_cpu_has(X86_FEATURE_VMX))
+		l1_vmx_code(data);
+	else
+		l1_svm_code(data);
+}
+
 int main(int argc, char *argv[])
 {
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
 	vm_vaddr_t guest_gva = 0;
 
-	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_VMX));
+	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_VMX) ||
+		     kvm_cpu_has(X86_FEATURE_SVM));
+
+	vm = vm_create_with_one_vcpu(&vcpu, l1_guest_code);
+
+	if (kvm_cpu_has(X86_FEATURE_VMX))
+		vcpu_alloc_vmx(vm, &guest_gva);
+	else
+		vcpu_alloc_svm(vm, &guest_gva);
 
-	vm = vm_create_with_one_vcpu(&vcpu, l1_vmx_code);
-	vcpu_alloc_vmx(vm, &guest_gva);
 	vcpu_args_set(vcpu, 1, guest_gva);
 
 	for (;;) {
-- 
2.51.0.869.ge66316f041-goog


