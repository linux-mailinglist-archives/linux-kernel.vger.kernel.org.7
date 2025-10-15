Return-Path: <linux-kernel+bounces-855120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0F0BE04B4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 21:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3C6E75056C0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 19:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00FF530498F;
	Wed, 15 Oct 2025 19:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xUJizDzo"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A61E21B1BC
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 19:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760554851; cv=none; b=Ta+9mIwvOHwZmgYvc59XG4xFhgbpNi5xt8VTFs8TVPCmfCfSrLruxsjr7BI+qBcIZ6JTzJYj45rqEAJcxUng5ydZ0ZayshiJ4MuJ40iCU2vDGu1Tpg4CaVUJTIam2dNxOtkVm6GyMio5BtCRRa6rc02hn3QKqiniKEYVuyn0Hx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760554851; c=relaxed/simple;
	bh=s+zsTwKD/SG5cJlWDm5wtx2rbuyWZfGs6xCG4OUXHuc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eypz9N5kZZS2EKFf1mwLFmalB0t+mRYqmstjErX8rS3K3Wo1Bj1DANS6qj+nUAK+BUKvVN6hpsauj2G3Ax9AXQZrxFwV/nhmlEThvxrho/XhaHjbA8itbILGt3IcYy0viDnZ5mDSQ3debAdMY/ctL1EtD9l4xqFJSCkPqXoaC/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xUJizDzo; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wyihan.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-780f914b5a4so9291415b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 12:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760554848; x=1761159648; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pNUm5TxoGqq4kCj6yXsKowaihB2Pt1TXPKBWeL6tI2k=;
        b=xUJizDzo5b+0ortW+QNhWG4l6wcM6g43E9Fk+kBCXypUH3elaXTAsxSlgrg94Ngptj
         DJlg4Og3AZgy2Kc1pTKhkI1KS0ftgJOVKLpefAjd9c5MKEFg/fo6fmPNXnQshUXsjmgX
         51tiLJlFPQe5yzl6/gnAHcJwzQut55PDp2ArP23PVG7cEb3Mu2lUloicZSg2/bXhz1cF
         E7FQC0yD9Q1uAKOpW0bFZNqn1BECryJ9aiwtzrMIQy6SFmT9cu4Ko3UnqwpnjQYFEejb
         ibAxnRPT0EkUCuB3A8DAwVCFic2w6ZUP3/ywl6T/TBHK0ZJPz6QTAebY1U2a4kpu+0j3
         tIvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760554848; x=1761159648;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pNUm5TxoGqq4kCj6yXsKowaihB2Pt1TXPKBWeL6tI2k=;
        b=NkE2NNBJBnCUXHDKjDcWU9SN8fe5eHl/oVdm0Kd0kxwmufsTTofSNBtZGAOfMai7sU
         NC083wyeJyklYvKq5yu5aLqiM7nL17jMYBpFZfoJnzl8BuhqHgILPMgrwUgK0JWNB8/k
         MfqmKNfiUswjAFqh/gNO6MJX9FIQN2yil++FXsxaAPBWtCF+87ZOQ/PpsRUqThdqVXBu
         NQszMEeH3bHAR7T+QK23wMppu3/p9bcEDr5ZvFoJwguWrxUtdMXmaBGJnQyG5rdV/FIO
         N1QqLZn6ajAOGZ+LMOh+mHiyrWGGDWgqgYTxPePMmHZ5R3d6khfZfqMQxT+DUYQmKzD7
         uwiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQ8yB/EZBPASJqD724qjGdKidtcGRlL4nS0zJ7p/IRVKRZvSxRVzBvH0P/YjR/SFCWi0j2JpONaGAhuKM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWjyLqMZ1nbXiwNFikys3iyvuDbY50a44wehyHqvwO2cX6g49G
	jCnbsErbDMywki3Z5U0yAW5pX1ScOE38fM0AKjC18aHEA9jmGvq4+M95ENQVn6SIN9HetXzu8zN
	S3U/6mA==
X-Google-Smtp-Source: AGHT+IH9eWZybGubZq7sC/zD/yq1mEc57rW2Po4y9Ynk1gkxwdxeFsmL8u9gpOHhlAY2ESNOv+PJBInMrH8=
X-Received: from pfdb3.prod.google.com ([2002:a05:6a00:94e3:b0:7a1:f3d3:6658])
 (user=wyihan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:17a7:b0:781:8832:9159
 with SMTP id d2e1a72fcca58-79385709429mr33327665b3a.4.1760554847426; Wed, 15
 Oct 2025 12:00:47 -0700 (PDT)
Date: Wed, 15 Oct 2025 18:58:56 +0000
In-Reply-To: <cover.1760551864.git.wyihan@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1760551864.git.wyihan@google.com>
X-Mailer: git-send-email 2.51.0.788.g6d19910ace-goog
Message-ID: <cc4764476c69139866d8baba84b4eff6de85b8fb.1760551864.git.wyihan@google.com>
Subject: [RFC PATCH RESEND 2/3] KVM: selftests: Add memory failure tests in guest_memfd_test
From: Lisa Wang <wyihan@google.com>
To: linmiaohe@huawei.com, nao.horiguchi@gmail.com, akpm@linux-foundation.org, 
	pbonzini@redhat.com, shuah@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: david@redhat.com, rientjes@google.com, seanjc@google.com, 
	ackerleytng@google.com, vannapurve@google.com, michael.roth@amd.com, 
	jiaqiyan@google.com, tabba@google.com, dave.hansen@linux.intel.com, 
	Lisa Wang <wyihan@google.com>
Content-Type: text/plain; charset="UTF-8"

After modifying truncate_error_folio(), we expect memory_failure() will
return 0 instead of MF_FAILED. Also, we want to make sure memory_failure()
signaling function is same.

Test that memory_failure() returns 0 for guest_memfd, where
.error_remove_folio() is handled by not actually truncating, and returning
MF_DELAYED.

In addition, test that SIGBUS signaling behavior is not changed before
and after this modification.

There are two kinds of guest memory failure injections - madvise or
debugfs. When memory failure is injected using madvise, the
MF_ACTION_REQUIRED flag is set, and the page is mapped and dirty, the
process should get a SIGBUS. When memory is failure is injected using
debugfs, the KILL_EARLY machine check memory corruption kill policy is
set, and the page is mapped and dirty, the process should get a SIGBUS.

Co-developed-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Lisa Wang <wyihan@google.com>
---
 .../testing/selftests/kvm/guest_memfd_test.c  | 168 ++++++++++++++++++
 1 file changed, 168 insertions(+)

diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
index e7d9aeb418d3..7bcf8d2d5d4d 100644
--- a/tools/testing/selftests/kvm/guest_memfd_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_test.c
@@ -10,6 +10,8 @@
 #include <errno.h>
 #include <stdio.h>
 #include <fcntl.h>
+#include <linux/prctl.h>
+#include <sys/prctl.h>
 
 #include <linux/bitmap.h>
 #include <linux/falloc.h>
@@ -97,6 +99,171 @@ static void test_fault_overflow(int fd, size_t total_size)
 	test_fault_sigbus(fd, total_size, total_size * 4);
 }
 
+static unsigned long addr_to_pfn(void *addr)
+{
+	const uint64_t pagemap_pfn_mask = BIT(54) - 1;
+	const uint64_t pagemap_page_present = BIT(63);
+	uint64_t page_info;
+	ssize_t n_bytes;
+	int pagemap_fd;
+
+	pagemap_fd = open("/proc/self/pagemap", O_RDONLY);
+	TEST_ASSERT(pagemap_fd > 0, "Opening pagemap should succeed.");
+
+	n_bytes = pread(pagemap_fd, &page_info, 8, (uint64_t)addr / page_size * 8);
+	TEST_ASSERT(n_bytes == 8, "pread of pagemap failed. n_bytes=%ld", n_bytes);
+
+	close(pagemap_fd);
+
+	TEST_ASSERT(page_info & pagemap_page_present, "The page for addr should be present");
+	return page_info & pagemap_pfn_mask;
+}
+
+static void write_memory_failure(unsigned long pfn, bool mark, int return_code)
+{
+	char path[PATH_MAX];
+	char *filename;
+	char buf[20];
+	int ret;
+	int len;
+	int fd;
+
+	filename = mark ? "corrupt-pfn" : "unpoison-pfn";
+	snprintf(path, PATH_MAX, "/sys/kernel/debug/hwpoison/%s", filename);
+
+	fd = open(path, O_WRONLY);
+	TEST_ASSERT(fd > 0, "Failed to open %s.", path);
+
+	len = snprintf(buf, sizeof(buf), "0x%lx\n", pfn);
+	if (len < 0 || (unsigned int)len > sizeof(buf))
+		TEST_ASSERT(0, "snprintf failed or truncated.");
+
+	ret = write(fd, buf, len);
+	if (return_code == 0) {
+		/*
+		 * If the memory_failure() returns 0, write() should be successful,
+		 * which returns how many bytes it writes.
+		 */
+		TEST_ASSERT(ret > 0, "Writing memory failure (path: %s) failed: %s", path,
+			    strerror(errno));
+	} else {
+		TEST_ASSERT_EQ(ret, -1);
+		/* errno is memory_failure() return code. */
+		TEST_ASSERT_EQ(errno, return_code);
+	}
+
+	close(fd);
+}
+
+static void mark_memory_failure(unsigned long pfn, int return_code)
+{
+	write_memory_failure(pfn, true, return_code);
+}
+
+static void unmark_memory_failure(unsigned long pfn, int return_code)
+{
+	write_memory_failure(pfn, false, return_code);
+}
+
+enum memory_failure_injection_method {
+	MF_INJECT_DEBUGFS,
+	MF_INJECT_MADVISE,
+};
+
+static void do_test_memory_failure(int fd, size_t total_size,
+				   enum memory_failure_injection_method method, int kill_config,
+				   bool map_page, bool dirty_page, bool sigbus_expected,
+				   int return_code)
+{
+	unsigned long memory_failure_pfn;
+	char *memory_failure_addr;
+	char *mem;
+	int ret;
+
+	mem = mmap(NULL, total_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+	TEST_ASSERT(mem != MAP_FAILED, "mmap() for guest_memfd should succeed.");
+	memory_failure_addr = mem + page_size;
+	if (dirty_page)
+		*memory_failure_addr = 'A';
+	else
+		READ_ONCE(*memory_failure_addr);
+
+	/* Fault in page to read pfn, then unmap page for testing if needed. */
+	memory_failure_pfn = addr_to_pfn(memory_failure_addr);
+	if (!map_page)
+		madvise(memory_failure_addr, page_size, MADV_DONTNEED);
+
+	ret = prctl(PR_MCE_KILL, PR_MCE_KILL_SET, kill_config, 0, 0);
+	TEST_ASSERT_EQ(ret, 0);
+
+	ret = 0;
+	switch (method) {
+	case MF_INJECT_DEBUGFS: {
+		/* DEBUGFS injection handles return_code test inside the mark_memory_failure(). */
+		if (sigbus_expected)
+			TEST_EXPECT_SIGBUS(mark_memory_failure(memory_failure_pfn, return_code));
+		else
+			mark_memory_failure(memory_failure_pfn, return_code);
+		break;
+	}
+	case MF_INJECT_MADVISE: {
+		/*
+		 * MADV_HWPOISON uses get_user_pages() so the page will always
+		 * be faulted in at the point of memory_failure()
+		 */
+		if (sigbus_expected)
+			TEST_EXPECT_SIGBUS(ret = madvise(memory_failure_addr,
+							 page_size, MADV_HWPOISON));
+		else
+			ret = madvise(memory_failure_addr, page_size, MADV_HWPOISON);
+
+		if (return_code == 0)
+			TEST_ASSERT(ret == return_code, "Memory failure failed. Errno: %s",
+							strerror(errno));
+		else {
+			/* errno is memory_failure() return code. */
+			TEST_ASSERT_EQ(errno, return_code);
+		}
+		break;
+	}
+	default:
+		TEST_FAIL("Unhandled memory failure injection method %d.", method);
+	}
+
+	TEST_EXPECT_SIGBUS(READ_ONCE(*memory_failure_addr));
+	TEST_EXPECT_SIGBUS(*memory_failure_addr = 'A');
+
+	ret = munmap(mem, total_size);
+	TEST_ASSERT(!ret, "munmap() should succeed.");
+
+	ret = fallocate(fd, FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE, 0,
+			total_size);
+	TEST_ASSERT(!ret, "Truncate the entire file (cleanup) should succeed.");
+
+	ret = prctl(PR_MCE_KILL, PR_MCE_KILL_SET, PR_MCE_KILL_DEFAULT, 0, 0);
+	TEST_ASSERT_EQ(ret, 0);
+
+	unmark_memory_failure(memory_failure_pfn, 0);
+}
+
+static void test_memory_failure(int fd, size_t total_size)
+{
+	do_test_memory_failure(fd, total_size, MF_INJECT_DEBUGFS, PR_MCE_KILL_EARLY, true, true, true, 0);
+	do_test_memory_failure(fd, total_size, MF_INJECT_DEBUGFS, PR_MCE_KILL_EARLY, true, false, false, 0);
+	do_test_memory_failure(fd, total_size, MF_INJECT_DEBUGFS, PR_MCE_KILL_EARLY, false, true, false, 0);
+	do_test_memory_failure(fd, total_size, MF_INJECT_DEBUGFS, PR_MCE_KILL_LATE, true, true, false, 0);
+	do_test_memory_failure(fd, total_size, MF_INJECT_DEBUGFS, PR_MCE_KILL_LATE, true, false, false, 0);
+	do_test_memory_failure(fd, total_size, MF_INJECT_DEBUGFS, PR_MCE_KILL_LATE, false, true, false, 0);
+	/*
+	 * If madvise() is used to inject errors, memory_failure() handling is invoked with the
+	 * MF_ACTION_REQUIRED flag set, aligned with memory failure handling for a consumed memory
+	 * error, where the machine check memory corruption kill policy is ignored. Hence, testing with
+	 * PR_MCE_KILL_DEFAULT covers all cases.
+	 */
+	do_test_memory_failure(fd, total_size, MF_INJECT_MADVISE, PR_MCE_KILL_DEFAULT, true, true, true, 0);
+	do_test_memory_failure(fd, total_size, MF_INJECT_MADVISE, PR_MCE_KILL_DEFAULT, true, false, false, 0);
+}
+
 static void test_fault_private(int fd, size_t total_size)
 {
 	test_fault_sigbus(fd, 0, total_size);
@@ -273,6 +440,7 @@ static void __test_guest_memfd(struct kvm_vm *vm, uint64_t flags)
 		if (flags & GUEST_MEMFD_FLAG_INIT_SHARED) {
 			gmem_test(mmap_supported, vm, flags);
 			gmem_test(fault_overflow, vm, flags);
+			gmem_test(memory_failure, vm, flags);
 		} else {
 			gmem_test(fault_private, vm, flags);
 		}
-- 
2.51.0.788.g6d19910ace-goog


