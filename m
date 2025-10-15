Return-Path: <linux-kernel+bounces-855096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E2CBE0366
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 20:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDCCC487699
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 18:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D6E2FF171;
	Wed, 15 Oct 2025 18:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vDSc+bur"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092B43002D3
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 18:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760553428; cv=none; b=LkAqb2t68qTxkyRaOC402se6N5FEOE+j/9w+RGbxx8WCc04POh0kMWCRmctWL5FuUKd8dafB/ojXhtM6VrhxqHBV4kuHvuaMUUDpKPvkXPvv86muj0OfG47ioPt3ZCHngYC9jardQDZ4CC/ad6NFiKz7d00q2o5JepPFWUBU2x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760553428; c=relaxed/simple;
	bh=1H/TAjStyaI6entLwQUNBGgnkdgglmJ5EvafY9K9xl4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LVHy4ab5nKxsfmudLI+ol4rsaqmMAzuKrx1mIJCmy1UMtTQ8/bLrd1LRIvBQhkBhezoUGKNRnwjz0W3XWv+FMlkCq674t3CaYOnB3Ei5nIHBkxzriCjwq1bQv/JAj0tkQ9VmG0YsTUML8DqS9PryBXZ8f6/Gs2WXwniuDgqZEes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vDSc+bur; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b6325a95e44so1155711a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 11:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760553426; x=1761158226; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=r/50hzPJcz2Tgtv5Q95r1Wz9trycmcqvXu8eukDbYxw=;
        b=vDSc+burVVff7zgcEyAcpSyPTgFBVU+oIVMjEidkDB3m7fBUVM9Su+4+MhP9MGjS6T
         goS5Njp3SjoQEKqfXKpyDst0mgYblI7fOaR+o0YrTs4GVBcf3ujpOV3qxdSylJKmaih3
         pELznx9N+Qx7rOal4ykkbi1rJVZqnezfZL9ttF68UKU20zcadl6KMBElZCS0DL12FaR1
         2mu6R8j8RjDKOcZyJW8plJHz024EXOe3gvdAZY4FMCEJHzlJmMMEpjzGGXaVYP/x+A7V
         IRwAhylJPuvsV+CSJ+6y6wlUa3zdvz47JRofiHlDDawUYvQONyc6G7vHiOM5iYtAJG7B
         tkzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760553426; x=1761158226;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r/50hzPJcz2Tgtv5Q95r1Wz9trycmcqvXu8eukDbYxw=;
        b=mx7SF2h5sWSWN4gbkpEoQ+KVJPz0kBbNmBg0Mcm8oKgqIaBn6GmNHELLcHNonG6HAy
         78Eh2GtqCu+VNkfHcPl42Y4DBGVLkV0LHxucpJb9KogFxMhLZBRcgJ/Y4JRzRVNg5n6C
         RblhAOvvd6P7UlwF6xPau9okDNZlnKeVaXA+JxHVgKqnDb1cACiRE3aAKj8akupo722W
         ij5pt7Fo7rqFo5eS2n7t3fga8fvA8lcQlFGZk9+OO/6f/+w6JBJ3uTcVcyqrEGf0D/u+
         YlORSNImpcunYaKw0cBcDCtNSM5oP4le/sQJ3QK2JS7HhQTovXLEggCUNG7mHQUyi3xl
         W/ug==
X-Forwarded-Encrypted: i=1; AJvYcCWAQ/zVjo+YE2O7+9tTlSX6sfqt27ZCE35Gs14SrrKdoMwh3Vtpk1CFijccuoOQYEhOP9FYShR9Rht8AeA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6Tt5wULJwvw7RrppEP7RNckbeUe751UppKzpBx5i/W7sJhBGm
	zGbtO0TDmjLw9q25umY3HtnpOLkwOdk2eEg4LlIE/58hjOFZYOvotHJfwInsckcY8NowkILsiwb
	GMkUZKQ==
X-Google-Smtp-Source: AGHT+IH/6fHMrWMV8yp+8Ppnbbm83SfdopptQSAUB91QvYTFNTxXFVFSpf5U8i3i7fNPRxzlbwQGpMJ/fbA=
X-Received: from pfbei17.prod.google.com ([2002:a05:6a00:80d1:b0:772:3537:d602])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:1593:b0:2f3:3e1b:de66
 with SMTP id adf61e73a8af0-33495d4ea9cmr1351247637.7.1760553426186; Wed, 15
 Oct 2025 11:37:06 -0700 (PDT)
Date: Wed, 15 Oct 2025 18:35:54 +0000
In-Reply-To: <cover.1760551864.git.wyihan@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1760551864.git.wyihan@google.com>
X-Mailer: git-send-email 2.51.0.788.g6d19910ace-goog
Message-ID: <0ec7349858142439ed0a250e6c04edf84cb0f488.1760551864.git.wyihan@google.com>
Subject: [RFC PATCH 3/3] KVM: selftests: Test guest_memfd behavior with
 respect to stage 2 page tables
From: Lisa Wang <wyihan@google.com>
To: linmiaohe@huawei.com, nao.horiguchi@gmail.com, akpm@linux-foundation.org, 
	pbonzini@redhat.com, shuah@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.or, 
	linux-kselftest@vger.kernel.org
Cc: david@redhat.com, rientjes@google.com, seanjc@google.com, 
	ackerleytng@google.com, vannapurve@google.com, michael.roth@amd.com, 
	jiaqiyan@google.com, tabba@google.com, dave.hansen@linux.intel.com, 
	Lisa Wang <wyihan@google.com>
Content-Type: text/plain; charset="UTF-8"

Test that
+ memory failure handling results in unmapping of bad memory from stage
  2 page tables, hence requiring faulting on next guest access
+ when the guest tries to fault a poisoned page from guest_memfd, the
  userspace VMM informed with EHWPOISON

Co-developed-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Lisa Wang <wyihan@google.com>
---
 .../testing/selftests/kvm/guest_memfd_test.c  | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
index 7bcf8d2d5d4d..dc3398e22edd 100644
--- a/tools/testing/selftests/kvm/guest_memfd_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_test.c
@@ -539,6 +539,70 @@ static void test_guest_memfd_guest(void)
 	kvm_vm_free(vm);
 }
 
+static void __guest_code_read(uint8_t *mem)
+{
+	READ_ONCE(*mem);
+	GUEST_DONE();
+}
+
+static void guest_read(struct kvm_vcpu *vcpu, uint64_t gpa, int expected_errno)
+{
+	vcpu_arch_set_entry_point(vcpu, __guest_code_read);
+	vcpu_args_set(vcpu, 1, gpa);
+
+	if (expected_errno) {
+		TEST_ASSERT_EQ(_vcpu_run(vcpu), -1);
+		TEST_ASSERT_EQ(errno, expected_errno);
+	} else {
+		vcpu_run(vcpu);
+		TEST_ASSERT_EQ(get_ucall(vcpu, NULL), UCALL_DONE);
+	}
+}
+
+static void test_memory_failure_guest(void)
+{
+	const uint64_t gpa = SZ_4G;
+	const int slot = 1;
+
+	unsigned long memory_failure_pfn;
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	uint8_t *mem;
+	size_t size;
+	int fd;
+
+	if (!kvm_has_cap(KVM_CAP_GUEST_MEMFD_FLAGS))
+		return;
+
+	vm = __vm_create_shape_with_one_vcpu(VM_SHAPE_DEFAULT, &vcpu, 1, __guest_code_read);
+
+	size = vm->page_size;
+	fd = vm_create_guest_memfd(vm, size, GUEST_MEMFD_FLAG_MMAP | GUEST_MEMFD_FLAG_INIT_SHARED);
+	vm_set_user_memory_region2(vm, slot, KVM_MEM_GUEST_MEMFD, gpa, size, NULL, fd, 0);
+
+	mem = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+	TEST_ASSERT(mem != MAP_FAILED, "mmap() for guest_memfd should succeed.");
+	virt_pg_map(vm, gpa, gpa);
+
+	/* Fault in page to read pfn, then unmap page for testing. */
+	READ_ONCE(*mem);
+	memory_failure_pfn = addr_to_pfn(mem);
+	munmap(mem, size);
+
+	/* Fault page into stage2 page tables. */
+	guest_read(vcpu, gpa, 0);
+
+	mark_memory_failure(memory_failure_pfn, 0);
+
+	guest_read(vcpu, gpa, EHWPOISON);
+	munmap(mem, size);
+
+	close(fd);
+	kvm_vm_free(vm);
+
+	unmark_memory_failure(memory_failure_pfn, 0);
+}
+
 int main(int argc, char *argv[])
 {
 	unsigned long vm_types, vm_type;
@@ -559,4 +623,5 @@ int main(int argc, char *argv[])
 		test_guest_memfd(vm_type);
 
 	test_guest_memfd_guest();
+	test_memory_failure_guest();
 }
-- 
2.51.0.788.g6d19910ace-goog


