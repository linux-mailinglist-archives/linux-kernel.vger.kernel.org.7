Return-Path: <linux-kernel+bounces-850856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C709BD42F7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 17:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8742234E83C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 15:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DD53128A4;
	Mon, 13 Oct 2025 15:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BgnmrADV"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB9630E835
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 15:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760368550; cv=none; b=d2djzQuW5MX1hEmQIt9tlQSTCb/nZc0AnK314cepYg1pXt75TZ6ks/6Y7DYAQSl4WwzLEl3EUUBX7WFrd5psvUOzyLrzrCSbEZYVH1kb5TjO2xJqCcbErkgkCu8QbdYeYrk6cLjR1t/bwCnysEn+ZsE4ZW5bTWjoFKz25btO2kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760368550; c=relaxed/simple;
	bh=AfUKt9Y64nk4DJCkkE4xk0dAPQmcJX1fmTUpYECF7XQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gc/cJLK0xlk/GOKfmM8BxjFchhrQ6wQXSdcq0h7HEUsla3tVa8DMeBBj3K4UzzituRc+oqYWRzadj1K5a8fyo/HUUQ1Kqc+VRZ+vBztE1bgOsCVmI9MygFIE6QDd9XFLU0wxbbwiLPXi+RR37Xp/OGz9uVr6n3HONY41E0euMTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BgnmrADV; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-46e6c8bc46eso28134505e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760368547; x=1760973347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mzQnDluOQWqcbRXyu07+4Pf89SEymkI9ph5TfK7+5co=;
        b=BgnmrADVG8gUrQACGHOnlAuw3ZUzfD5DdKxuFfhmStZ6yxMKplWDpwZnCFRgcGG8yu
         tkAbRXxegbx1xF3+VVzCWjJnr82WRf/oiU6+qrvGdC2eoMFVWjNw0AVneVmmIVG4hCyp
         +3JZ+jyeVhm8X/CJCkutqaFfYGC0j0XxLXnvNSphOdrMhvNaTmdEJRZLu6dlWAQBjEiX
         e3cJIjGNgZBWi80wN6N3NMg9CaIqFgyqF1ytintQt3Rtg9BODNXLkiY7kZ6hsw9XnduD
         WHaPBDy7rKK0mUT720K8uTsDZ65QThBssvARIT7pY/ZLPL0euKwbnU3ftczS7JOY1j3f
         yl9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760368547; x=1760973347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mzQnDluOQWqcbRXyu07+4Pf89SEymkI9ph5TfK7+5co=;
        b=HcBdwqdPsozUK81JNSOYhF9WaLRtIZm73u2/v/VZCdv56dlZgDx8TN9J3GjdnKP1HI
         NTlpsf1Ujt9/HfeaJNT00wvmqGWUAWvkhq5+lY9DzhpwlXhFMQhIsHTRHmj3qfGj9VEa
         B2hstYvr6PjoPBg6p1XUEjfAeKI9qnuF0tH3KefdLVugWaJZ00/RYs1qv+A1hIUQA8me
         U5deR4Ihn8XDbfu8mZU1++lVh3RULNox4wdBItKz/AKoY5bN8lO6HffG76QDPg6Dafo3
         7OUYJ5jt0r/vewmU3MaKwtn3h0+3q1BaqtMlWIf6lEEVg9FgfwxPD6I1W4A0srnO/ip5
         Q/ug==
X-Forwarded-Encrypted: i=1; AJvYcCVJ77yUk0s0sHK1Go5LzuiurW6BkU+WBK0GzwcSi03K/ooberwDPrRdDVU82w0R6tGOH6TJE+uwBFcf7CA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpRMyokFL1AF2kvHLN6ojFSNL4TyOEXSExUVh0BK2BCUqOLyk2
	yrhcpKHP0q47mmxC45Hs7/70OSA0otkQZHZDd3tY5MJlRADtl93yXYO4
X-Gm-Gg: ASbGncv97nzOr0SRBXOyh3AWIhHawRHwhlEe+DvvsSNhZYCLOAhIvNUmWwaNO62zfUs
	sOaes31CmSNMXOn88rAmCGdkEs1+7UNiM5j5hmH4obuRrCb+bm4pWyHZ0azMvzjkCQDmjxAeYC5
	9xHiqA/0WkQAHKMkQ7IJs5vnC/+W2a0kJD4PVKlD9/LGDIf+TCb6ewmWdN7NjvN3fULnQ8OePOf
	rN4KSqlHj1Ajp9LG4dDZKf9owYiSIhlWCkh3EvY0oNMPu+eYPjf0NjPxKqYUDfNl7Gw0hUPmcgO
	Qpfxfo7zKWDuvPzMPJl8g2C2hgJt9wrW7hKJMHEXoiaDr3jQC30GhZgyQZhw+aE1dDS7qBlha2g
	zd1WppjbpBFwEPn0nu4P9QVWjvyoupaedHsw/1XVuFbd2vfzs6ImVcN13k9PXM2B/4/LE0c29Bk
	8uqr91SiqI7Df/CZc5shQdLhZ43w==
X-Google-Smtp-Source: AGHT+IHgTeXKHH2vcpsvzOcBDeWFCxx7j6NWXF765EtO+25xvlfpvrezTIu3A7FfM3RO5CiMYA9Vog==
X-Received: by 2002:a05:600c:1e85:b0:46e:39e4:1721 with SMTP id 5b1f17b1804b1-46fa9aa261amr141333095e9.12.1760368546663;
        Mon, 13 Oct 2025 08:15:46 -0700 (PDT)
Received: from f4d4888f22f2.ant.amazon.com.com ([15.248.3.91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fab36a773sm135545825e9.0.2025.10.13.08.15.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Oct 2025 08:15:46 -0700 (PDT)
From: Jack Thomson <jackabt.amazon@gmail.com>
To: maz@kernel.org,
	oliver.upton@linux.dev,
	pbonzini@redhat.com
Cc: joey.gouly@arm.com,
	suzuki.poulose@arm.com,
	yuzenghui@huawei.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	shuah@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	isaku.yamahata@intel.com,
	roypat@amazon.co.uk,
	kalyazin@amazon.co.uk,
	jackabt@amazon.com
Subject: [PATCH v2 4/4] KVM: selftests: Add option for different backing in pre-fault tests
Date: Mon, 13 Oct 2025 16:15:01 +0100
Message-ID: <20251013151502.6679-5-jackabt.amazon@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251013151502.6679-1-jackabt.amazon@gmail.com>
References: <20251013151502.6679-1-jackabt.amazon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jack Thomson <jackabt@amazon.com>

Add a -m option to specify different memory backing types for the
pre-fault tests (e.g., anonymous, hugetlb), allowing testing of the
pre-fault functionality across different memory configurations.

Signed-off-by: Jack Thomson <jackabt@amazon.com>
---
 .../selftests/kvm/pre_fault_memory_test.c     | 31 ++++++++++++++++---
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kvm/pre_fault_memory_test.c b/tools/testing/selftests/kvm/pre_fault_memory_test.c
index ed9848a8af60..22e2e53945d9 100644
--- a/tools/testing/selftests/kvm/pre_fault_memory_test.c
+++ b/tools/testing/selftests/kvm/pre_fault_memory_test.c
@@ -76,6 +76,7 @@ static void pre_fault_memory(struct kvm_vcpu *vcpu, u64 gpa, u64 size,
 struct test_params {
 	unsigned long vm_type;
 	bool private;
+	enum vm_mem_backing_src_type mem_backing_src;
 };
 
 static void __test_pre_fault_memory(enum vm_guest_mode guest_mode, void *arg)
@@ -94,7 +95,11 @@ static void __test_pre_fault_memory(enum vm_guest_mode guest_mode, void *arg)
 	uint64_t guest_test_virt_mem;
 	uint64_t alignment, guest_page_size;
 
+	size_t backing_src_pagesz = get_backing_src_pagesz(p->mem_backing_src);
+
 	pr_info("Testing guest mode: %s\n", vm_guest_mode_string(guest_mode));
+	pr_info("Testing memory backing src type: %s\n",
+		vm_mem_backing_src_alias(p->mem_backing_src)->name);
 
 	vm = vm_create_shape_with_one_vcpu(shape, &vcpu, guest_code);
 
@@ -110,10 +115,11 @@ static void __test_pre_fault_memory(enum vm_guest_mode guest_mode, void *arg)
 #else
 	alignment = SZ_2M;
 #endif
+	alignment = max(alignment, backing_src_pagesz);
 	guest_test_phys_mem = align_down(guest_test_phys_mem, alignment);
 	guest_test_virt_mem = guest_test_phys_mem & ((1ULL << (vm->va_bits - 1)) - 1);
 
-	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS,
+	vm_userspace_mem_region_add(vm, p->mem_backing_src,
 				    guest_test_phys_mem, TEST_SLOT, test_config.test_num_pages,
 				    p->private ? KVM_MEM_GUEST_MEMFD : 0);
 	virt_map(vm, guest_test_virt_mem, guest_test_phys_mem, test_config.test_num_pages);
@@ -155,7 +161,8 @@ static void __test_pre_fault_memory(enum vm_guest_mode guest_mode, void *arg)
 	kvm_vm_free(vm);
 }
 
-static void test_pre_fault_memory(unsigned long vm_type, bool private)
+static void test_pre_fault_memory(unsigned long vm_type, enum vm_mem_backing_src_type backing_src,
+				  bool private)
 {
 	if (vm_type && !(kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(vm_type))) {
 		pr_info("Skipping tests for vm_type 0x%lx\n", vm_type);
@@ -165,6 +172,7 @@ static void test_pre_fault_memory(unsigned long vm_type, bool private)
 	struct test_params p = {
 		.vm_type = vm_type,
 		.private = private,
+		.mem_backing_src = backing_src,
 	};
 
 	for_each_guest_mode(__test_pre_fault_memory, &p);
@@ -174,10 +182,23 @@ int main(int argc, char *argv[])
 {
 	TEST_REQUIRE(kvm_check_cap(KVM_CAP_PRE_FAULT_MEMORY));
 
-	test_pre_fault_memory(0, false);
+	int opt;
+	enum vm_mem_backing_src_type backing = VM_MEM_SRC_ANONYMOUS;
+
+	while ((opt = getopt(argc, argv, "m:")) != -1) {
+		switch (opt) {
+		case 'm':
+			backing = parse_backing_src_type(optarg);
+			break;
+		default:
+			break;
+		}
+	}
+
+	test_pre_fault_memory(0, backing, false);
 #ifdef __x86_64__
-	test_pre_fault_memory(KVM_X86_SW_PROTECTED_VM, false);
-	test_pre_fault_memory(KVM_X86_SW_PROTECTED_VM, true);
+	test_pre_fault_memory(KVM_X86_SW_PROTECTED_VM, backing, false);
+	test_pre_fault_memory(KVM_X86_SW_PROTECTED_VM, backing, true);
 #endif
 	return 0;
 }
-- 
2.43.0


