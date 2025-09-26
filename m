Return-Path: <linux-kernel+bounces-834413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7387DBA4A3B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 18:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DED6F5624CB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 16:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EEB52F6164;
	Fri, 26 Sep 2025 16:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yz8qgC59"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB5B2FA0DF
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 16:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758904290; cv=none; b=bVlZoBJv0n8wvaus9r6Cn/5H5ZXyZYZ9Eqg/P2MrlBSSRhIugpCK0WUxHziiE4XqmP1aEC95/TufonXvmhBVHnZLDJ9CUxvHjq9QJcLuf3JMwzevkVd+mHhFRYEVnIwpHFo2ndbD3Es3hgIFOQ7G5vwt7rHWFwHFbBp6yTyH7iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758904290; c=relaxed/simple;
	bh=NwVBLzkycsIvNLZWFoTgP99Nti5Zw+TydW4zPHJYhTk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Z9QTtQUJKRuyz8ZPzCBIZJ9mNA6u5+x2SL4NSofBQDEMHaNlL39HfUSuA/bd5z+OL+QYgDZIiHvNgV3MBv6+w40N+o8Pmaug5hfeExnVzLb8NcqtvFvngj3KU7RD+3AFgAjGdq7zIm4CyPpvijtmuD3OIdy6dg7fSZGUJ3wm2mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Yz8qgC59; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32eb18b5659so2258499a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 09:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758904287; x=1759509087; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=l3zdqnz7hE8XrMpTHfpgLZMPiUOgmALQcu+ienriJT0=;
        b=Yz8qgC59ciQhaeKuG9m9SXxrgEFCkHrLvMHv05xxMPmuwtXliKFOyUEZ2OU94tWiDS
         UxtX5uN4/5P3DK3sb1zULpUUfR9j+aZl1xuPA2z3JaP1/d3IptAwQHa/SUdRBgMjv5Cg
         bCr1R5eFqyNjSY6hKaiHxGO2QBjTzoaLaC1C+wmSMCMu11uIRxxstAzyJ7lS8wNrXeWy
         kT8ulyHtDcBk840AxpHkp9uxEkHbzYRBnC4kQXxjZ5ISEVleMbvVNMjURBGnNNuRqvfT
         npt7TNmZbfj0Jjpb8d8wl8MHcUUajLm6GX0dQ2zAwubEKq5uU+AZDdbbUrnmgPL8knfa
         oZHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758904287; x=1759509087;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l3zdqnz7hE8XrMpTHfpgLZMPiUOgmALQcu+ienriJT0=;
        b=QeRZprQjIWfkLlgXgNWqWF8PiLTt/pI1oTWUdvvK9TUtDv/SEZ1ZjGf3Ja5TBSCAVD
         xdCC6L0NgXV3fpotEAXpRggUX3vZ7JbrYUWPt2ipJSGg8/a3aFdcq2a5i7mzD4iOxw79
         iICmASgbbwDgr/8PWe2QKUlLkhxr8W+Mro4aZQh0UYBC1yjR9Xd2vdmt5+Hl2DJqsnfW
         VXn0RvxaADriAzdVkiLm7GhNGVsckOMSdG2WNSLXrO+jIC4CQ10x3NvwuHv6vZo8PO5S
         xlFtuIQjTJLuUjByfDEOQKn21BUuxjIksh00Aq1UOKeZl5sb+sxfgMWtYDt1id+pt1kz
         l8lA==
X-Forwarded-Encrypted: i=1; AJvYcCX+JarF4fao+YgcEDMXRzCBGqFM78wP0+KFA4WbQq2ujQCtnb5LLqYjzdRLuOUh/MOu4oKQ5LR1/nFWq3s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQH7O6OPzcpYuXrgcjgKxMOIamPBIOr46HDv6VWJ0ueDB3t5ol
	ACaAmfGD7rXD4DLb/56612Pky1KdhTA9NlwjrcVmQx8PX6F6Derh1UQZJKa/PurgxITEI423z4P
	voM8BZg==
X-Google-Smtp-Source: AGHT+IFEYG6OnzBq2EM3fBSKkROXcSOcnJkIoTMS39B+6e4KnPVpK7mYOvt/GSiwhK61zdSwXPK5dS+XxSk=
X-Received: from pjxu4.prod.google.com ([2002:a17:90a:db44:b0:32e:c813:df48])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:380e:b0:32e:7270:94aa
 with SMTP id 98e67ed59e1d1-3342a2c7d99mr9343719a91.19.1758904287630; Fri, 26
 Sep 2025 09:31:27 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 26 Sep 2025 09:31:05 -0700
In-Reply-To: <20250926163114.2626257-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250926163114.2626257-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Message-ID: <20250926163114.2626257-5-seanjc@google.com>
Subject: [PATCH 4/6] KVM: selftests: Add test coverage for guest_memfd without GUEST_MEMFD_FLAG_MMAP
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Hildenbrand <david@redhat.com>, Fuad Tabba <tabba@google.com>, 
	Sean Christopherson <seanjc@google.com>, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Ackerley Tng <ackerleytng@google.com>

If a VM type supports KVM_CAP_GUEST_MEMFD_MMAP, the guest_memfd test will
run all test cases with GUEST_MEMFD_FLAG_MMAP set.  This leaves the code
path for creating a non-mmap()-able guest_memfd on a VM that supports
mappable guest memfds untested.

Refactor the test to run the main test suite with a given set of flags.
Then, for VM types that support the mappable capability, invoke the test
suite twice: once with no flags, and once with GUEST_MEMFD_FLAG_MMAP
set.

This ensures both creation paths are properly exercised on capable VMs.

test_guest_memfd_flags() tests valid flags, hence it can be run just once
per VM type, and valid flag identification can be moved into the test
function.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
[sean: use double-underscores for the inner helper]
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../testing/selftests/kvm/guest_memfd_test.c  | 30 ++++++++++++-------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
index 60c6dec63490..5a50a28ce1fa 100644
--- a/tools/testing/selftests/kvm/guest_memfd_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_test.c
@@ -239,11 +239,16 @@ static void test_create_guest_memfd_multiple(struct kvm_vm *vm)
 	close(fd1);
 }
 
-static void test_guest_memfd_flags(struct kvm_vm *vm, uint64_t valid_flags)
+static void test_guest_memfd_flags(struct kvm_vm *vm)
 {
+	uint64_t valid_flags = 0;
 	uint64_t flag;
 	int fd;
 
+	if (vm_check_cap(vm, KVM_CAP_GUEST_MEMFD_MMAP))
+		valid_flags |= GUEST_MEMFD_FLAG_MMAP |
+			       GUEST_MEMFD_FLAG_DEFAULT_SHARED;
+
 	for (flag = BIT(0); flag; flag <<= 1) {
 		fd = __vm_create_guest_memfd(vm, page_size, flag);
 		if (flag & valid_flags) {
@@ -267,16 +272,8 @@ do {									\
 	close(fd);							\
 } while (0)
 
-static void test_guest_memfd(unsigned long vm_type)
+static void __test_guest_memfd(struct kvm_vm *vm, uint64_t flags)
 {
-	uint64_t flags = 0;
-	struct kvm_vm *vm;
-
-	vm = vm_create_barebones_type(vm_type);
-
-	if (vm_check_cap(vm, KVM_CAP_GUEST_MEMFD_MMAP))
-		flags |= GUEST_MEMFD_FLAG_MMAP | GUEST_MEMFD_FLAG_DEFAULT_SHARED;
-
 	test_create_guest_memfd_multiple(vm);
 	test_create_guest_memfd_invalid_sizes(vm, flags);
 
@@ -292,8 +289,19 @@ static void test_guest_memfd(unsigned long vm_type)
 	gmem_test(file_size, vm, flags);
 	gmem_test(fallocate, vm, flags);
 	gmem_test(invalid_punch_hole, vm, flags);
+}
 
-	test_guest_memfd_flags(vm, flags);
+static void test_guest_memfd(unsigned long vm_type)
+{
+	struct kvm_vm *vm = vm_create_barebones_type(vm_type);
+
+	test_guest_memfd_flags(vm);
+
+	__test_guest_memfd(vm, 0);
+
+	if (vm_check_cap(vm, KVM_CAP_GUEST_MEMFD_MMAP))
+		__test_guest_memfd(vm, GUEST_MEMFD_FLAG_MMAP |
+				       GUEST_MEMFD_FLAG_DEFAULT_SHARED);
 
 	kvm_vm_free(vm);
 }
-- 
2.51.0.536.g15c5d4f767-goog


