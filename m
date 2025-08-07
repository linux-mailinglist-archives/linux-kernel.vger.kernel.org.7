Return-Path: <linux-kernel+bounces-759476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB531B1DDFD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 22:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6860A00DF9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 20:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D44A279DCF;
	Thu,  7 Aug 2025 20:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="efOLIOlV"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4260274FE5
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 20:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754597821; cv=none; b=BZ8woMCxhBYs9h5akD6aSFqLmmmwXqCYkxlqj1j3L5XzgnNfG5KsUKM5HeVdPGIR0W9Td86zirkSuHcLm1N4ye9CCzIRZFoI7GJouiXGltnxLfszsFHHO3PIU55qE2CS66BMLYyP5sjs1oWT/hVDshnpQVVcCEE8zlq5R5j5Y44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754597821; c=relaxed/simple;
	bh=FXDAADzMusIlbN7uUCnCYkOeFjIxbEHc+vE0DIROQ/Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AOjLazwV0GpQwAMyZ2nn8JDmwn+5/e7Ss8geON1dQ+F60H8DrcQmg5h7Yaz78uI4f9XBeJ5KC6J7zADF5ZihFchVwoh+V80egFdt2V+QTQnHHtoCrgyQO3biI4tDavvH4wx05RSwp9IJHGNpAMGRWdZx3ayPrn4HnS4EhLPwH+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=efOLIOlV; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b4253124e77so1197706a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 13:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754597819; x=1755202619; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=opBjGbCpw5awd4Cotp1/0PR79/5V/O1FhnxLn+p7yqU=;
        b=efOLIOlVCj7m+gGYL+R9nGG03NoXaJjiqKoKeHv/3yk4A8n0PGIhs7Kc0GaEMj4lU1
         nLFhOYiZ3H8Ekhg3Phggqjtr8ismctvuaYJ+W8sMpLCkKQWOR2KGgaefPXKQ2i9ABFrm
         k9BhV04ePEUENoo0+dxctVI+XqG7E7m8fRpfCuce5nZz83CoD42Z8EA4e9EZ1gnriRyd
         G1BxU8zR8H++fwGu9fChwoGq+y01Mjki1de+783LnfI1CMwzm1GQ9rCne75bZBAl+/Fd
         lX7xsaulKaWt3xbX4Bqt3xLMRsUjKJFbHviK5E1KfsbCA1hNJ7IlaccmKo6ndTHEvrdj
         mzIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754597819; x=1755202619;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=opBjGbCpw5awd4Cotp1/0PR79/5V/O1FhnxLn+p7yqU=;
        b=SmCuKqBmFpdX5y204Ui5dNBr8Cr47Hvx0bK6MeLMhl5q60l1EFRzZmP08R7U9iP+9u
         XwHpTEqPFB7MhOQYZOxZqpg7/RVJZP2nYtWjaYxnu5WK99mPbCTZQJJdQSiXNiLo8KJz
         Ss71qj6NUUfPG4DmD88ouAyyXdNB1/bmf4F/t0WlPYD2ujkNUnvtiXuRQCnQNNT9o4VU
         O7zo/9QTZJsxDIHRwgRlTx6XhCWdN01v3+Cv0YTPU/yKxNRFW7hvq8wKFoJ+xyOigT4n
         /w44r7dK8ZFskHpQt5FCaY9S3DJN8Y3RLqVHiwTJkZ+pIZKzStgy0cdQfM6APca4XXEo
         5l0A==
X-Gm-Message-State: AOJu0Yy4IiUOiIfLC9NhSoFeJmeLWXQ/rG00XCAdXS+qSzp14TlHN3tN
	+FeLFnx+6jSMia9+WqwLVUA3woq0kEtURiYRf3e4/Yozs5ZVWJjkt89j2qnIvgvTlCNzTK683Lq
	42g==
X-Google-Smtp-Source: AGHT+IFg9IMl11uY0VA/UeYt/Ymn5WDhQiYfRt4ouUB8jhAWey7rdPY7dxuMJ50BLvXQ8lFPaeBoEOoCiA==
X-Received: from pgbdp12.prod.google.com ([2002:a05:6a02:f0c:b0:b42:306b:d8b])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:a121:b0:240:1a3a:d7ed
 with SMTP id adf61e73a8af0-24055200eb1mr348212637.41.1754597819059; Thu, 07
 Aug 2025 13:16:59 -0700 (PDT)
Date: Thu,  7 Aug 2025 13:16:10 -0700
In-Reply-To: <20250807201628.1185915-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250807201628.1185915-1-sagis@google.com>
X-Mailer: git-send-email 2.51.0.rc0.155.g4a0f42376b-goog
Message-ID: <20250807201628.1185915-15-sagis@google.com>
Subject: [PATCH v8 14/30] KVM: selftests: TDX: Add TDX IO writes test
From: Sagi Shahar <sagis@google.com>
To: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Sagi Shahar <sagis@google.com>, Roger Wang <runanwang@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The test verifies IO writes of various sizes from the guest to the host.

Signed-off-by: Sagi Shahar <sagis@google.com>
---
 .../selftests/kvm/include/x86/tdx/tdcall.h    |  3 +
 tools/testing/selftests/kvm/x86/tdx_vm_test.c | 79 ++++++++++++++++++-
 2 files changed, 81 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdcall.h b/tools/testing/selftests/kvm/include/x86/tdx/tdcall.h
index a6c966e93486..e7440f7fe259 100644
--- a/tools/testing/selftests/kvm/include/x86/tdx/tdcall.h
+++ b/tools/testing/selftests/kvm/include/x86/tdx/tdcall.h
@@ -7,6 +7,9 @@
 #include <linux/bits.h>
 #include <linux/types.h>
 
+#define TDG_VP_VMCALL_SUCCESS 0x0000000000000000
+#define TDG_VP_VMCALL_INVALID_OPERAND 0x8000000000000000
+
 #define TDX_HCALL_HAS_OUTPUT BIT(0)
 
 #define TDX_HYPERCALL_STANDARD 0
diff --git a/tools/testing/selftests/kvm/x86/tdx_vm_test.c b/tools/testing/selftests/kvm/x86/tdx_vm_test.c
index 22143d16e0d1..f646da032004 100644
--- a/tools/testing/selftests/kvm/x86/tdx_vm_test.c
+++ b/tools/testing/selftests/kvm/x86/tdx_vm_test.c
@@ -308,6 +308,81 @@ void verify_get_td_vmcall_info(void)
 	printf("\t ... PASSED\n");
 }
 
+#define TDX_IO_WRITES_TEST_PORT 0x51
+
+/*
+ * Verifies IO functionality by writing values of different sizes
+ * to the host.
+ */
+void guest_io_writes(void)
+{
+	uint64_t byte_4 = 0xFFABCDEF;
+	uint64_t byte_2 = 0xABCD;
+	uint64_t byte_1 = 0xAB;
+	uint64_t ret;
+
+	ret = tdg_vp_vmcall_instruction_io(TDX_IO_WRITES_TEST_PORT, 1,
+					   PORT_WRITE, &byte_1);
+	tdx_assert_error(ret);
+
+	ret = tdg_vp_vmcall_instruction_io(TDX_IO_WRITES_TEST_PORT, 2,
+					   PORT_WRITE, &byte_2);
+	tdx_assert_error(ret);
+
+	ret = tdg_vp_vmcall_instruction_io(TDX_IO_WRITES_TEST_PORT, 4,
+					   PORT_WRITE, &byte_4);
+	tdx_assert_error(ret);
+
+	/* Write an invalid number of bytes. */
+	ret = tdg_vp_vmcall_instruction_io(TDX_IO_WRITES_TEST_PORT, 5,
+					   PORT_WRITE, &byte_4);
+	tdx_assert_error(ret);
+
+	tdx_test_success();
+}
+
+void verify_guest_writes(void)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	uint32_t byte_4;
+	uint16_t byte_2;
+	uint8_t byte_1;
+
+	vm = td_create();
+	td_initialize(vm, VM_MEM_SRC_ANONYMOUS, 0);
+	vcpu = td_vcpu_add(vm, 0, guest_io_writes);
+	td_finalize(vm);
+
+	printf("Verifying guest writes:\n");
+
+	tdx_run(vcpu);
+	tdx_test_assert_io(vcpu, TDX_IO_WRITES_TEST_PORT, 1, PORT_WRITE);
+	byte_1 = *(uint8_t *)((void *)vcpu->run + vcpu->run->io.data_offset);
+
+	tdx_run(vcpu);
+	tdx_test_assert_io(vcpu, TDX_IO_WRITES_TEST_PORT, 2, PORT_WRITE);
+	byte_2 = *(uint16_t *)((void *)vcpu->run + vcpu->run->io.data_offset);
+
+	tdx_run(vcpu);
+	tdx_test_assert_io(vcpu, TDX_IO_WRITES_TEST_PORT, 4, PORT_WRITE);
+	byte_4 = *(uint32_t *)((void *)vcpu->run + vcpu->run->io.data_offset);
+
+	TEST_ASSERT_EQ(byte_1, 0xAB);
+	TEST_ASSERT_EQ(byte_2, 0xABCD);
+	TEST_ASSERT_EQ(byte_4, 0xFFABCDEF);
+
+	td_vcpu_run(vcpu);
+	TEST_ASSERT_EQ(vcpu->run->exit_reason, KVM_EXIT_SYSTEM_EVENT);
+	TEST_ASSERT_EQ(vcpu->run->system_event.data[12], TDG_VP_VMCALL_INVALID_OPERAND);
+
+	tdx_run(vcpu);
+	tdx_test_assert_success(vcpu);
+
+	kvm_vm_free(vm);
+	printf("\t ... PASSED\n");
+}
+
 int main(int argc, char **argv)
 {
 	ksft_print_header();
@@ -315,7 +390,7 @@ int main(int argc, char **argv)
 	if (!is_tdx_enabled())
 		ksft_exit_skip("TDX is not supported by the KVM. Exiting.\n");
 
-	ksft_set_plan(5);
+	ksft_set_plan(6);
 	ksft_test_result(!run_in_new_process(&verify_td_lifecycle),
 			 "verify_td_lifecycle\n");
 	ksft_test_result(!run_in_new_process(&verify_report_fatal_error),
@@ -326,6 +401,8 @@ int main(int argc, char **argv)
 			 "verify_td_cpuid\n");
 	ksft_test_result(!run_in_new_process(&verify_get_td_vmcall_info),
 			 "verify_get_td_vmcall_info\n");
+	ksft_test_result(!run_in_new_process(&verify_guest_writes),
+			 "verify_guest_writes\n");
 
 	ksft_finished();
 	return 0;
-- 
2.51.0.rc0.155.g4a0f42376b-goog


