Return-Path: <linux-kernel+bounces-672781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C73ACD76E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jun 2025 07:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBCC71773A3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jun 2025 05:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8989265CAC;
	Wed,  4 Jun 2025 05:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PV4Yjq9A"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3B226462B
	for <linux-kernel@vger.kernel.org>; Wed,  4 Jun 2025 05:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749013754; cv=none; b=omTHnagDD9c4EgNA1IMdO0It30yh0GaA2s9cU7bj9XKvVT7/iyU+l7G6Pd2Phhg63vp6KmNntBDLnR9iWkvJQCC9agD8qOoqJ8VwPav5/XrwsEPhyQ/cgzFY3PKlAhGjEvWGNpmmgRJQl4d/ibPbzTaLG3b9ryz8waJdNL05NJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749013754; c=relaxed/simple;
	bh=eU3yapsGWA2+7vXxKVhKcdiYurD0MP5WlF1wcLUeT3c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OXyyMi06zV5od5ZjPKRuW54a6VqYb4gb1r6P/Lz1GdhTQYhXLjrQeNIr+daJJR8cFDGAVGHKd3x6OVqomwjtEMDtM7SguPX5FDW7uWElUSo7bGOmwQxO8a23YT3jX3CSqhCo2xP8QVSH2CKaVqKY5+MXwnsDOu04lPAtOBZJ4F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PV4Yjq9A; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-747d394f45fso2841096b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jun 2025 22:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749013752; x=1749618552; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ca5XEEBBkHI7wnxKesidI9Ic1vb2lLJagV9Bw44j+oc=;
        b=PV4Yjq9Ab486yPrzuVBzJ07KNJ6zVwAIOmZxQaTbwrPKz7byGqUoBU8MU+LkTYsIrS
         tQONGo51cr1YFSayXj9d2lm0YeMK9La4brPpuJIr+M/NY+9p+gtidzAptWQdQoNspuHF
         PSgLJr3J5X7TVRNMYmDcidtaoxApJoPGMBC2n+XltfAuy7xXNOtMSj4MXGW/4bY/QCow
         sNV6ekawPlCDA0b18hmft1964dZrLYl51ZH8hrvDc2h4TJIjTjdfq15amFZngpQLoKTv
         DlcyjWQX+5xaa083AQLF7xMxoU8puHurI/ic1Nm+EK70wcLg5l8zPE6mFVCQCcQLtbIz
         sISg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749013752; x=1749618552;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ca5XEEBBkHI7wnxKesidI9Ic1vb2lLJagV9Bw44j+oc=;
        b=Tfi6j5wpt4WS19dib/zH6oowk7p3AMEGSzI2tdL3tMD087SkuogAO/ECxUuP+sdV9F
         qnNmw37o1Quk5IT8fSMRKK8CqYLUGt+9uo3F/+PTp64FtsqgKcGsJ76wA+fVCpegCUqb
         V84PAdR6s6q9WSrBNZnCCmQDmw/W8nKXwfK7KHgZnVzAJzei21mHANgjdY6oo2JMmgQW
         9KEAVYfBioVjaf4pGIJAljIVfoN8OpCweHCSqRct19rEp9d1NwHvH/b7fT0/+AA01fBZ
         XR6aNssLVaF1SpY+cUZ7+/GaxNRc6UHc2JP3a2KQzvk8boxVKdNp+8IhR0Mqg+664NA3
         jbzA==
X-Forwarded-Encrypted: i=1; AJvYcCWIDpe8xYOJ8BNGpyRDxUXPLa0cn9kybMVIBFMb6gShu/kieJBkFGYtiTE+TnDQ1qgqU10IRhvn4u3PkLs=@vger.kernel.org
X-Gm-Message-State: AOJu0YySzRettUoIDdwF42w3QZ11ilhne6FBJw7Y7bMy4DXu0Lwiw2R3
	s19aZxwvauONGRTl0Gs/v4OlEt5FLMxAHDhwCQrevRVZ/x1TFTtJMClrOY6nU57bhYh/92n7mWu
	jHGkuUQBdRQws7w==
X-Google-Smtp-Source: AGHT+IGY9FewZRutQWX3kPabe7vpLnmhGCzy5qRwLJrwts22IIPU9KOO/oVkiPw3lXzpgoETazm1TXUFA3gKDg==
X-Received: from pfblr56.prod.google.com ([2002:a05:6a00:73b8:b0:747:a8ac:ca05])
 (user=jiaqiyan job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2e18:b0:730:9946:5973 with SMTP id d2e1a72fcca58-7480b200bf5mr2177985b3a.5.1749013751697;
 Tue, 03 Jun 2025 22:09:11 -0700 (PDT)
Date: Wed,  4 Jun 2025 05:09:00 +0000
In-Reply-To: <20250604050902.3944054-1-jiaqiyan@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250604050902.3944054-1-jiaqiyan@google.com>
X-Mailer: git-send-email 2.50.0.rc0.604.gd4ff7b7c86-goog
Message-ID: <20250604050902.3944054-6-jiaqiyan@google.com>
Subject: [PATCH v2 5/6] KVM: selftests: Test for KVM_CAP_INJECT_EXT_IABT
From: Jiaqi Yan <jiaqiyan@google.com>
To: maz@kernel.org, oliver.upton@linux.dev
Cc: joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	catalin.marinas@arm.com, will@kernel.org, pbonzini@redhat.com, corbet@lwn.net, 
	shuah@kernel.org, kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	duenwen@google.com, rananta@google.com, jthoughton@google.com, 
	Jiaqi Yan <jiaqiyan@google.com>
Content-Type: text/plain; charset="UTF-8"

Test userspace can use KVM_SET_VCPU_EVENTS to inject an external
instruction abort into guest. The test injects instruction abort at an
arbitrary time without real SEA happening in the guest VCPU, so only
certain ESR_EL1 bits are expected and asserted.

Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
---
 tools/arch/arm64/include/uapi/asm/kvm.h       |  3 +-
 tools/testing/selftests/kvm/Makefile.kvm      |  1 +
 .../testing/selftests/kvm/arm64/inject_iabt.c | 98 +++++++++++++++++++
 3 files changed, 101 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/kvm/arm64/inject_iabt.c

diff --git a/tools/arch/arm64/include/uapi/asm/kvm.h b/tools/arch/arm64/include/uapi/asm/kvm.h
index af9d9acaf9975..d3a4530846311 100644
--- a/tools/arch/arm64/include/uapi/asm/kvm.h
+++ b/tools/arch/arm64/include/uapi/asm/kvm.h
@@ -184,8 +184,9 @@ struct kvm_vcpu_events {
 		__u8 serror_pending;
 		__u8 serror_has_esr;
 		__u8 ext_dabt_pending;
+		__u8 ext_iabt_pending;
 		/* Align it to 8 bytes */
-		__u8 pad[5];
+		__u8 pad[4];
 		__u64 serror_esr;
 	} exception;
 	__u32 reserved[12];
diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 9eecce6b8274f..e6b504ded9c1c 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -149,6 +149,7 @@ TEST_GEN_PROGS_arm64 += arm64/arch_timer_edge_cases
 TEST_GEN_PROGS_arm64 += arm64/debug-exceptions
 TEST_GEN_PROGS_arm64 += arm64/host_sve
 TEST_GEN_PROGS_arm64 += arm64/hypercalls
+TEST_GEN_PROGS_arm64 += arm64/inject_iabt
 TEST_GEN_PROGS_arm64 += arm64/mmio_abort
 TEST_GEN_PROGS_arm64 += arm64/page_fault_test
 TEST_GEN_PROGS_arm64 += arm64/psci_test
diff --git a/tools/testing/selftests/kvm/arm64/inject_iabt.c b/tools/testing/selftests/kvm/arm64/inject_iabt.c
new file mode 100644
index 0000000000000..0c7999e5ba5b3
--- /dev/null
+++ b/tools/testing/selftests/kvm/arm64/inject_iabt.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * inject_iabt.c - Tests for injecting instruction aborts into guest.
+ */
+
+#include "processor.h"
+#include "test_util.h"
+
+static void expect_iabt_handler(struct ex_regs *regs)
+{
+	u64 esr = read_sysreg(esr_el1);
+
+	GUEST_PRINTF("Handling Guest SEA\n");
+	GUEST_PRINTF("  ESR_EL1=%#lx\n", esr);
+
+	GUEST_ASSERT_EQ(ESR_ELx_EC(esr), ESR_ELx_EC_IABT_CUR);
+	GUEST_ASSERT_EQ(esr & ESR_ELx_FSC_TYPE, ESR_ELx_FSC_EXTABT);
+
+	GUEST_DONE();
+}
+
+static void guest_code(void)
+{
+	GUEST_FAIL("Guest should only run SEA handler");
+}
+
+static void vcpu_run_expect_done(struct kvm_vcpu *vcpu)
+{
+	struct ucall uc;
+	bool guest_done = false;
+
+	do {
+		vcpu_run(vcpu);
+		switch (get_ucall(vcpu, &uc)) {
+		case UCALL_ABORT:
+			REPORT_GUEST_ASSERT(uc);
+			break;
+		case UCALL_PRINTF:
+			ksft_print_msg("From guest: %s", uc.buffer);
+			break;
+		case UCALL_DONE:
+			ksft_print_msg("Guest done gracefully!\n");
+			guest_done = true;
+			break;
+		default:
+			TEST_FAIL("Unexpected ucall: %lu", uc.cmd);
+		}
+	} while (!guest_done);
+}
+
+static void vcpu_inject_ext_iabt(struct kvm_vcpu *vcpu)
+{
+	struct kvm_vcpu_events events = {};
+
+	events.exception.ext_iabt_pending = true;
+	vcpu_events_set(vcpu, &events);
+}
+
+static void vcpu_inject_invalid_abt(struct kvm_vcpu *vcpu)
+{
+	struct kvm_vcpu_events events = {};
+	int r;
+
+	events.exception.ext_iabt_pending = true;
+	events.exception.ext_dabt_pending = true;
+
+	ksft_print_msg("Injecting invalid external abort events\n");
+	r = __vcpu_ioctl(vcpu, KVM_SET_VCPU_EVENTS, &events);
+	TEST_ASSERT(r && errno == EINVAL,
+		    KVM_IOCTL_ERROR(KVM_SET_VCPU_EVENTS, r));
+}
+
+static void test_inject_iabt(void)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
+
+	vm_init_descriptor_tables(vm);
+	vcpu_init_descriptor_tables(vcpu);
+
+	vm_install_sync_handler(vm, VECTOR_SYNC_CURRENT,
+				ESR_ELx_EC_IABT_CUR, expect_iabt_handler);
+
+	vcpu_inject_invalid_abt(vcpu);
+
+	vcpu_inject_ext_iabt(vcpu);
+	vcpu_run_expect_done(vcpu);
+
+	kvm_vm_free(vm);
+}
+
+int main(void)
+{
+	test_inject_iabt();
+	return 0;
+}
-- 
2.49.0.1266.g31b7d2e469-goog


