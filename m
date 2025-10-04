Return-Path: <linux-kernel+bounces-841849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F45BB862E
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 01:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A01264A6D05
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 23:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 681F22DCF7C;
	Fri,  3 Oct 2025 23:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AiXfxIJP"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C4B28030E
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 23:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759533985; cv=none; b=EUWS5a6usARlmyxASD4oECnGmtQpKJpr4REC7vuBkmiDnZipJIodS2J3rx4ko+Lj/HlMC/fwT/8OJs0s+Q+5xGyb+T2kBrXbVQkrGNqeL9px3PbBO+jVrpLs9OlIqhBj430RQhhKLBd9OSK1DIom4TRgExNBjGBdDtO2vci85Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759533985; c=relaxed/simple;
	bh=YbkbnjJu+36n5SbpfKPqSJITnPmgozv3ZgDZF5G6CM8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SkucAUCgcDP5w3QW4hRBcHndAGf/aUei9U3MpLd82cAaTbXpwSHc7wyJ2kXbQnAZSakGD8g6ySbLK8X19IGPCz0P5YFkf9tfdAOkgVwu/pBZnflR8iYzignro4ySqfUC6NT8aZc7bZAxbX5/7dG9GfWukd/KdgJHfC/wsT8j1S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AiXfxIJP; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2681623f927so25886275ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 16:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759533983; x=1760138783; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=zcRpiMHDbu4Skkpi+qu52sLrguB0NGA5sLQ3sxPzJBs=;
        b=AiXfxIJPl2GCkMGlcI81DP5jcIa49jw5o2V0mPBLugW1RAO++8xASAPCQqQtDqiWh2
         Ng0+BYodObkU9XD8MVEy9iwX7RS1qH8dqdKuXBhDw42LPu1jg8tuYsqV2mfJVuwPKH5t
         fL3FjC2MJE1IX7eGbAmm167VU2c/gL+8Va4UV4EzOKPQMnuh2pkGD3vE8CoilkLcv85G
         uagYYy+d4F4thc/4PsqpsZdJ2M4xUCwXw0dcR4iWur4AZcfIGOAAin0uJFsrio8Edb21
         p3O23cjH9KjUh3ztzvIHN79rbLB7S3tcQzj6A6Yktg8BE21r8FBni0kig2xhWzVRuF5u
         paAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759533983; x=1760138783;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zcRpiMHDbu4Skkpi+qu52sLrguB0NGA5sLQ3sxPzJBs=;
        b=IT+6Dc3cupuTrtKWF7uzssZT8G5I9dTG7eNb+u5dwNK5UcyOd1xeCllreXv3doqUp/
         fVTimlq5qTyxPwBRNdRwls1hMGLa8QaZYz9NBzvg7TwQue45LMnuyfUpuYcmvghAhTwU
         x+uTAqWmaVAT+sGLXd1GUwVzy+Re3KOhlnxCLMwrvcUO/KYJEdyKfF6cMWJgtRnYzsh+
         d5AaPh3Ox9+Ci/Jz7VpdyvTX2dXmjxcllQn+3d5DamksycFXeAnVTN6G7h83XsOA5ehv
         yYUsCpKbxqEfF1XoP439lIjaZr/3A3zMYnUxDgR2PyiqlBrbw26KjIahU8N6uiVkff9e
         /dMw==
X-Forwarded-Encrypted: i=1; AJvYcCW+7UosQxYUmcW5aAUKkO1a1+vOVjCVFO5h99l+VIVRbWq4Jj/SkZEGmE/1d3DSgswlbLZujho9OB4nqhw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyytDlnvQ/2xs0eXfUl83WNoDY3KzqQAvAD6176k15FNx6ou8qt
	LFx5dBdUQFg5i1+Zo9n+u+rt12BMy/yDjjga0Tj/DHkQERupBPMpTlwcuVth2vSfM6aw8qBaxaX
	rwdLCbQ==
X-Google-Smtp-Source: AGHT+IGWmXdxDD7fXZQjTHS0JUXz4LfC+NEFLqX200bITrSDJCTeu7CuxDV5nElaqxoRNwxo8qlmJi5xu9U=
X-Received: from pjbnh7.prod.google.com ([2002:a17:90b:3647:b0:32b:95bb:dbc])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:384d:b0:246:cfc4:9a30
 with SMTP id d9443c01a7336-28e9a61a7c2mr50968355ad.35.1759533983322; Fri, 03
 Oct 2025 16:26:23 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  3 Oct 2025 16:25:59 -0700
In-Reply-To: <20251003232606.4070510-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251003232606.4070510-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251003232606.4070510-7-seanjc@google.com>
Subject: [PATCH v2 06/13] KVM: selftests: Stash the host page size in a global
 in the guest_memfd test
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Hildenbrand <david@redhat.com>, Fuad Tabba <tabba@google.com>, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

Use a global variable to track the host page size in the guest_memfd test
so that the information doesn't need to be constantly passed around.  The
state is purely a reflection of the underlying system, i.e. can't be set
by the test and is constant for a given invocation of the test, and thus
explicitly passing the host page size to individual testcases adds no
value, e.g. doesn't allow testing different combinations.

Making page_size a global will simplify an upcoming change to create a new
guest_memfd instance per testcase.

No functional change intended.

Reviewed-by: Fuad Tabba <tabba@google.com>
Tested-by: Fuad Tabba <tabba@google.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../testing/selftests/kvm/guest_memfd_test.c  | 37 +++++++++----------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
index 0de56ce3c4e2..a7c9601bd31e 100644
--- a/tools/testing/selftests/kvm/guest_memfd_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_test.c
@@ -24,6 +24,8 @@
 #include "test_util.h"
 #include "ucall_common.h"
 
+static size_t page_size;
+
 static void test_file_read_write(int fd)
 {
 	char buf[64];
@@ -38,7 +40,7 @@ static void test_file_read_write(int fd)
 		    "pwrite on a guest_mem fd should fail");
 }
 
-static void test_mmap_supported(int fd, size_t page_size, size_t total_size)
+static void test_mmap_supported(int fd, size_t total_size)
 {
 	const char val = 0xaa;
 	char *mem;
@@ -78,7 +80,7 @@ void fault_sigbus_handler(int signum)
 	siglongjmp(jmpbuf, 1);
 }
 
-static void test_fault_overflow(int fd, size_t page_size, size_t total_size)
+static void test_fault_overflow(int fd, size_t total_size)
 {
 	struct sigaction sa_old, sa_new = {
 		.sa_handler = fault_sigbus_handler,
@@ -106,7 +108,7 @@ static void test_fault_overflow(int fd, size_t page_size, size_t total_size)
 	TEST_ASSERT(!ret, "munmap() should succeed.");
 }
 
-static void test_mmap_not_supported(int fd, size_t page_size, size_t total_size)
+static void test_mmap_not_supported(int fd, size_t total_size)
 {
 	char *mem;
 
@@ -117,7 +119,7 @@ static void test_mmap_not_supported(int fd, size_t page_size, size_t total_size)
 	TEST_ASSERT_EQ(mem, MAP_FAILED);
 }
 
-static void test_file_size(int fd, size_t page_size, size_t total_size)
+static void test_file_size(int fd, size_t total_size)
 {
 	struct stat sb;
 	int ret;
@@ -128,7 +130,7 @@ static void test_file_size(int fd, size_t page_size, size_t total_size)
 	TEST_ASSERT_EQ(sb.st_blksize, page_size);
 }
 
-static void test_fallocate(int fd, size_t page_size, size_t total_size)
+static void test_fallocate(int fd, size_t total_size)
 {
 	int ret;
 
@@ -165,7 +167,7 @@ static void test_fallocate(int fd, size_t page_size, size_t total_size)
 	TEST_ASSERT(!ret, "fallocate to restore punched hole should succeed");
 }
 
-static void test_invalid_punch_hole(int fd, size_t page_size, size_t total_size)
+static void test_invalid_punch_hole(int fd, size_t total_size)
 {
 	struct {
 		off_t offset;
@@ -196,8 +198,7 @@ static void test_invalid_punch_hole(int fd, size_t page_size, size_t total_size)
 }
 
 static void test_create_guest_memfd_invalid_sizes(struct kvm_vm *vm,
-						  uint64_t guest_memfd_flags,
-						  size_t page_size)
+						  uint64_t guest_memfd_flags)
 {
 	size_t size;
 	int fd;
@@ -214,7 +215,6 @@ static void test_create_guest_memfd_multiple(struct kvm_vm *vm)
 {
 	int fd1, fd2, ret;
 	struct stat st1, st2;
-	size_t page_size = getpagesize();
 
 	fd1 = __vm_create_guest_memfd(vm, page_size, 0);
 	TEST_ASSERT(fd1 != -1, "memfd creation should succeed");
@@ -242,7 +242,6 @@ static void test_create_guest_memfd_multiple(struct kvm_vm *vm)
 static void test_guest_memfd_flags(struct kvm_vm *vm)
 {
 	uint64_t valid_flags = vm_check_cap(vm, KVM_CAP_GUEST_MEMFD_FLAGS);
-	size_t page_size = getpagesize();
 	uint64_t flag;
 	int fd;
 
@@ -265,11 +264,9 @@ static void test_guest_memfd(unsigned long vm_type)
 {
 	struct kvm_vm *vm;
 	size_t total_size;
-	size_t page_size;
 	uint64_t flags;
 	int fd;
 
-	page_size = getpagesize();
 	total_size = page_size * 4;
 
 	vm = vm_create_barebones_type(vm_type);
@@ -280,22 +277,22 @@ static void test_guest_memfd(unsigned long vm_type)
 		flags &= ~GUEST_MEMFD_FLAG_MMAP;
 
 	test_create_guest_memfd_multiple(vm);
-	test_create_guest_memfd_invalid_sizes(vm, flags, page_size);
+	test_create_guest_memfd_invalid_sizes(vm, flags);
 
 	fd = vm_create_guest_memfd(vm, total_size, flags);
 
 	test_file_read_write(fd);
 
 	if (flags & GUEST_MEMFD_FLAG_MMAP) {
-		test_mmap_supported(fd, page_size, total_size);
-		test_fault_overflow(fd, page_size, total_size);
+		test_mmap_supported(fd, total_size);
+		test_fault_overflow(fd, total_size);
 	} else {
-		test_mmap_not_supported(fd, page_size, total_size);
+		test_mmap_not_supported(fd, total_size);
 	}
 
-	test_file_size(fd, page_size, total_size);
-	test_fallocate(fd, page_size, total_size);
-	test_invalid_punch_hole(fd, page_size, total_size);
+	test_file_size(fd, total_size);
+	test_fallocate(fd, total_size);
+	test_invalid_punch_hole(fd, total_size);
 
 	test_guest_memfd_flags(vm);
 
@@ -374,6 +371,8 @@ int main(int argc, char *argv[])
 
 	TEST_REQUIRE(kvm_has_cap(KVM_CAP_GUEST_MEMFD));
 
+	page_size = getpagesize();
+
 	/*
 	 * Not all architectures support KVM_CAP_VM_TYPES. However, those that
 	 * support guest_memfd have that support for the default VM type.
-- 
2.51.0.618.g983fd99d29-goog


