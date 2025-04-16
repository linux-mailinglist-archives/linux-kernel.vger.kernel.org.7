Return-Path: <linux-kernel+bounces-603959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D13F9A88E86
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 23:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 587EF16764A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Apr 2025 21:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8779E238156;
	Mon, 14 Apr 2025 21:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VlTjPlFR"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F685236446
	for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 21:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744667365; cv=none; b=ZN34k12k1GmtmWRGr4joutETdvO4oOjxZ61Cc4bX27UJfA04JFJS25d1bSpsclj5SlQ16FEuUBAd3N612A0Z+KShp1vElmaQWPOsvYZRwyQgCW05EQAHcTp/LuuuPxnaEVdFZkhic5nbGQC1+o06XqisBClIvMbov054jkQzqoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744667365; c=relaxed/simple;
	bh=IBStaTeDaDQ6GUlKg2laZWWFE7XHAicz2hARrJ6ISzg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mZai6rePXs3fhDiBCEpb/lr9jBMg2NkhIUP+JZZntgz86s77RkUDJo++IhWQ+b5o48fSVyephMIuIzYNsi6QViqQxIZ/MGmeiX/KAs0IvOG/iAP0kGlxRkDcC8/FZ9XDzvwaKm7Fdrm2S1w6hpcXWyqG9qfkQ3fBUWKOI3R4+tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VlTjPlFR; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2240c997059so55070045ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Apr 2025 14:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744667363; x=1745272163; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WB19BLup/h6PdTV2of5TaUwRHavbTLj/BteqXQD/MTo=;
        b=VlTjPlFR1M3nLY2vzoK6Uzmkt2oMsNtf70LFoDlifV1IoX7/0ZPHNcVqPSlTX92lfo
         CY5/CQOg6ZB6/a3ulE1+QcEF6UPlf2KPMzDE4OYtEig/hVFbDZjNizMaf5F09YUEIDH/
         acQLNJY4vNbfWg7NpvHzXEhgbFXt3u6RT3g/XFEpqQIg23/l803j9kLENlDqLUlBMDQ8
         sBsX4i3gsUfpbOLj51DPf9UqTD8pm2oNoiukrew2u6G01Zy5LRd2MjsOXwSgeh4+k194
         Mhv9opvjTL1M29Hb1TDncZdALiyuUmHMYqfg6SIMkkVj++hM/ys7wJmX8GWnKGoJeLOE
         cv4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744667363; x=1745272163;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WB19BLup/h6PdTV2of5TaUwRHavbTLj/BteqXQD/MTo=;
        b=ZGLtK4v7Y1yxYUNb68o1djEoUyXxHMGl0dQi14Hvp5y4UHEwDs+jUQ/Hz2sQ72hddL
         1x6XJTt7MM4ThdhZCxySfjGJcnJ/SBd0AN3Qa6z7aH/BXzqaFQMFX3EI6yDyhhChJGJ7
         BE38PEXf6c4BdwPbbPo2UyFcXy1O3bI5v3iTaNEK6OaSCsNYjD2MJmT16KNRDIJB59da
         u6rmT+2hxafEV48/Updky1Gx5iyHnJJCq2Wrv1ESLH5T7c0FWJpfpssMqAZnYo4XOC/J
         CpEHxhvQwWNC2YyjW0sO0IsckJ+/ZP4vl5wng9ejdiy9XlVgKKMzWovUF9khpauhhm7V
         k8cA==
X-Gm-Message-State: AOJu0YwQOr4/p/U++xL6T3Hu/N17qsmno0UU0PTRuLymOINZHQ6vKsl2
	qIAizb9bPMB62rGBGZ8OSPIAf7ZfAY2wj3wq2ZSF7cDFz9SnX1psyGqdDDwVOZII1ALnnOfdXQ=
	=
X-Google-Smtp-Source: AGHT+IGjltHoBvlF2nLQv32Emq8OMBVhYDnu7s/iQ/0ggipnndMo8DMTsCTVXdf/NZcacnKHJFEUlR4zTw==
X-Received: from pfuv18.prod.google.com ([2002:a05:6a00:1492:b0:736:5b36:db8f])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f547:b0:210:f706:dc4b
 with SMTP id d9443c01a7336-22bea4aadd3mr146690265ad.13.1744667362699; Mon, 14
 Apr 2025 14:49:22 -0700 (PDT)
Date: Mon, 14 Apr 2025 14:47:58 -0700
In-Reply-To: <20250414214801.2693294-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250414214801.2693294-1-sagis@google.com>
X-Mailer: git-send-email 2.49.0.777.g153de2bbd5-goog
Message-ID: <20250414214801.2693294-30-sagis@google.com>
Subject: [PATCH v6 29/30] KVM: selftests: TDX: Add TDX UPM selftests for
 implicit conversion
From: Sagi Shahar <sagis@google.com>
To: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Sagi Shahar <sagis@google.com>, Roger Wang <runanwang@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ackerley Tng <ackerleytng@google.com>

This tests the use of guest memory without explicit TDG.VP.VMCALL<MapGPA>
calls.

Provide a 2MB memory region to the TDX guest with a 40KB focus area at
offset 1MB intended to be shared between host and guest. The guest does
not request memory to be shared or private using TDG.VP.VMCALL<MapGPA> but
instead relies on memory to be converted automatically based on its
access via shared or private mapping. The host automatically
converts the memory when guest exits with KVM_EXIT_MEMORY_FAULT.

The 2MB region starts out as private with the guest filling it with a
pattern, followed by a check from the host to ensure the host is not able
to see the pattern. The guest then accesses the 40KB focus area via
its shared mapping to trigger implicit conversion followed by checks that
the host and guest has the same view of the memory. Finally the guest
accesses the 40KB memory via its private mapping to trigger the implicit
conversion to private followed by checks to confirm this is the case.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
---
 .../testing/selftests/kvm/x86/tdx_upm_test.c  | 88 ++++++++++++++++---
 1 file changed, 76 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/tdx_upm_test.c b/tools/testing/selftests/kvm/x86/tdx_upm_test.c
index 387258ab1a62..2ea5bf6d24b7 100644
--- a/tools/testing/selftests/kvm/x86/tdx_upm_test.c
+++ b/tools/testing/selftests/kvm/x86/tdx_upm_test.c
@@ -150,10 +150,10 @@ enum {
  * Does vcpu_run, and also manages memory conversions if requested by the TD.
  */
 void vcpu_run_and_manage_memory_conversions(struct kvm_vm *vm,
-					    struct kvm_vcpu *vcpu)
+					    struct kvm_vcpu *vcpu, bool handle_conversions)
 {
 	for (;;) {
-		vcpu_run(vcpu);
+		_vcpu_run(vcpu);
 		if (vcpu->run->exit_reason == KVM_EXIT_HYPERCALL &&
 		    vcpu->run->hypercall.nr == KVM_HC_MAP_GPA_RANGE) {
 			uint64_t gpa = vcpu->run->hypercall.args[0];
@@ -164,6 +164,13 @@ void vcpu_run_and_manage_memory_conversions(struct kvm_vm *vm,
 						  KVM_MAP_GPA_RANGE_ENCRYPTED);
 			vcpu->run->hypercall.ret = 0;
 			continue;
+		} else if (handle_conversions &&
+			vcpu->run->exit_reason == KVM_EXIT_MEMORY_FAULT) {
+			handle_memory_conversion(vm, vcpu->id, vcpu->run->memory_fault.gpa,
+						 vcpu->run->memory_fault.size,
+						 vcpu->run->memory_fault.flags ==
+						  KVM_MEMORY_EXIT_FLAG_PRIVATE);
+			continue;
 		} else if (vcpu->run->exit_reason == KVM_EXIT_IO &&
 			   vcpu->run->io.port == TDX_UPM_TEST_ACCEPT_PRINT_PORT) {
 			uint64_t gpa = tdx_test_read_64bit(vcpu,
@@ -241,8 +248,48 @@ static void guest_upm_explicit(void)
 	tdx_test_success();
 }
 
+static void guest_upm_implicit(void)
+{
+	struct tdx_upm_test_area *test_area_gva_private =
+		(struct tdx_upm_test_area *)TDX_UPM_TEST_AREA_GVA_PRIVATE;
+	struct tdx_upm_test_area *test_area_gva_shared =
+		(struct tdx_upm_test_area *)TDX_UPM_TEST_AREA_GVA_SHARED;
+
+	/* Check: host reading private memory does not modify guest's view */
+	fill_test_area(test_area_gva_private, PATTERN_GUEST_GENERAL);
+
+	tdx_test_report_to_user_space(SYNC_CHECK_READ_PRIVATE_MEMORY_FROM_HOST);
+
+	TDX_UPM_TEST_ASSERT(check_test_area(test_area_gva_private, PATTERN_GUEST_GENERAL));
+
+	/* Use focus area as shared */
+	fill_focus_area(test_area_gva_shared, PATTERN_GUEST_FOCUS);
+
+	/* General areas should not be affected */
+	TDX_UPM_TEST_ASSERT(check_general_areas(test_area_gva_private, PATTERN_GUEST_GENERAL));
+
+	tdx_test_report_to_user_space(SYNC_CHECK_READ_SHARED_MEMORY_FROM_HOST);
+
+	/* Check that guest has the same view of shared memory */
+	TDX_UPM_TEST_ASSERT(check_focus_area(test_area_gva_shared, PATTERN_HOST_FOCUS));
+
+	/* Use focus area as private */
+	fill_focus_area(test_area_gva_private, PATTERN_GUEST_FOCUS);
+
+	/* General areas should be unaffected by remapping */
+	TDX_UPM_TEST_ASSERT(check_general_areas(test_area_gva_private, PATTERN_GUEST_GENERAL));
+
+	tdx_test_report_to_user_space(SYNC_CHECK_READ_PRIVATE_MEMORY_FROM_HOST_AGAIN);
+
+	/* Check that guest can use private memory after focus area is remapped as private */
+	TDX_UPM_TEST_ASSERT(fill_and_check(test_area_gva_private, PATTERN_GUEST_GENERAL));
+
+	tdx_test_success();
+}
+
 static void run_selftest(struct kvm_vm *vm, struct kvm_vcpu *vcpu,
-			 struct tdx_upm_test_area *test_area_base_hva)
+			 struct tdx_upm_test_area *test_area_base_hva,
+			 bool implicit)
 {
 	tdx_run(vcpu);
 	tdx_test_assert_io(vcpu, TDX_TEST_REPORT_PORT, TDX_TEST_REPORT_SIZE,
@@ -260,7 +307,7 @@ static void run_selftest(struct kvm_vm *vm, struct kvm_vcpu *vcpu,
 	TEST_ASSERT(check_test_area(test_area_base_hva, PATTERN_CONFIDENCE_CHECK),
 		    "Host should read PATTERN_CONFIDENCE_CHECK from guest's private memory.");
 
-	vcpu_run_and_manage_memory_conversions(vm, vcpu);
+	vcpu_run_and_manage_memory_conversions(vm, vcpu, implicit);
 	tdx_test_assert_io(vcpu, TDX_TEST_REPORT_PORT, TDX_TEST_REPORT_SIZE,
 			   PORT_WRITE);
 	TEST_ASSERT_EQ(*(uint32_t *)((void *)vcpu->run + vcpu->run->io.data_offset),
@@ -276,7 +323,7 @@ static void run_selftest(struct kvm_vm *vm, struct kvm_vcpu *vcpu,
 	TEST_ASSERT(check_focus_area(test_area_base_hva, PATTERN_HOST_FOCUS),
 		    "Host should be able to use shared memory.");
 
-	vcpu_run_and_manage_memory_conversions(vm, vcpu);
+	vcpu_run_and_manage_memory_conversions(vm, vcpu, implicit);
 	tdx_test_assert_io(vcpu, TDX_TEST_REPORT_PORT, TDX_TEST_REPORT_SIZE,
 			   PORT_WRITE);
 	TEST_ASSERT_EQ(*(uint32_t *)((void *)vcpu->run + vcpu->run->io.data_offset),
@@ -322,17 +369,19 @@ static void guest_ve_handler(struct ex_regs *regs)
 	TDX_UPM_TEST_ASSERT(!ret);
 }
 
-static void verify_upm_test(void)
+static void verify_upm_test(bool implicit)
 {
 	struct tdx_upm_test_area *test_area_base_hva;
 	vm_vaddr_t test_area_gva_private;
 	uint64_t test_area_npages;
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
+	void *guest_code;
 
 	vm = td_create();
 	td_initialize(vm, VM_MEM_SRC_ANONYMOUS, 0);
-	vcpu = td_vcpu_add(vm, 0, guest_upm_explicit);
+	guest_code = implicit ? guest_upm_implicit : guest_upm_explicit;
+	vcpu = td_vcpu_add(vm, 0, guest_code);
 
 	vm_install_exception_handler(vm, VE_VECTOR, guest_ve_handler);
 
@@ -373,15 +422,28 @@ static void verify_upm_test(void)
 
 	td_finalize(vm);
 
-	printf("Verifying UPM functionality: explicit MapGPA\n");
+	if (implicit)
+		printf("Verifying UPM functionality: implicit conversion\n");
+	else
+		printf("Verifying UPM functionality: explicit MapGPA\n");
 
 	vm_enable_cap(vm, KVM_CAP_EXIT_HYPERCALL, BIT_ULL(KVM_HC_MAP_GPA_RANGE));
 
-	run_selftest(vm, vcpu, test_area_base_hva);
+	run_selftest(vm, vcpu, test_area_base_hva, implicit);
 
 	kvm_vm_free(vm);
 }
 
+void verify_upm_test_explicit(void)
+{
+	verify_upm_test(false);
+}
+
+void verify_upm_test_implicit(void)
+{
+	verify_upm_test(true);
+}
+
 int main(int argc, char **argv)
 {
 	ksft_print_header();
@@ -389,9 +451,11 @@ int main(int argc, char **argv)
 	if (!is_tdx_enabled())
 		ksft_exit_skip("TDX is not supported by the KVM. Exiting.\n");
 
-	ksft_set_plan(1);
-	ksft_test_result(!run_in_new_process(&verify_upm_test),
-			 "verify_upm_test\n");
+	ksft_set_plan(2);
+	ksft_test_result(!run_in_new_process(&verify_upm_test_explicit),
+			 "verify_upm_test_explicit\n");
+	ksft_test_result(!run_in_new_process(&verify_upm_test_implicit),
+			 "verify_upm_test_implicit\n");
 
 	ksft_finished();
 }
-- 
2.49.0.504.g3bcea36a83-goog


