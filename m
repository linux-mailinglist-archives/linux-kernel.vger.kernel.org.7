Return-Path: <linux-kernel+bounces-651831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F88ABA393
	for <lists+linux-kernel@lfdr.de>; Fri, 16 May 2025 21:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77EDF507A32
	for <lists+linux-kernel@lfdr.de>; Fri, 16 May 2025 19:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB688280A3A;
	Fri, 16 May 2025 19:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hC5C1MpO"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9380B280031
	for <linux-kernel@vger.kernel.org>; Fri, 16 May 2025 19:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747423198; cv=none; b=pw+uzq/9kU1DAZREnePuIHZic/LQTOGy0lE0ENE6pEIAo7CRzcbp4qD3Y/jqqYKwAFvSEgv9/clTleAazINHrn6+HNWV5UKNw1ooj/Yj5Ur4Ee/wnEtEeIsyEpu5zjHMT1fEHixshA9w6WB30NSwbE3z3b9gk5eipZWLS1P7Juc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747423198; c=relaxed/simple;
	bh=bfcQAMQ9jjnW3Lu5W8t13tUmLA+8UB1NqYqKNZ64Ov0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VkwkTxCGaV3E8lpzQduPQUya3bDiJH2brgiWkIwkL2S79XJ8JwJGiZqBz13noryTU9Cc7I4kKKbuvCczsegQrR+MJwItjxhelqiSJxzD6neMf34uYY+WF6t+ftWiIYcDFmQhP4o+z6lCntfOWqbF62qdzxK4AijC7HkXTn2CoQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--afranji.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hC5C1MpO; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--afranji.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7370e73f690so2830626b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 May 2025 12:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747423196; x=1748027996; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fhioi7Gcj72mRexvdqlPLPc4DSIey+OidUjZOy0mNj0=;
        b=hC5C1MpOB3pSC/CggDkn/nuGVcxPM+7bQ7ENWFHCYJL7tRFOkfTE3cpLIH7lXfdyZg
         81Rilrtd4HIrTlQXj8h/7IQ4ksRFt9PV/GdvDXSWKkTsfEatUE+DWkUthj5Bjp05NGii
         GU3FjHHMzcAkiaK4Zle/+3/AGOw17YPl7DTXzt5RNbEH9MCKGNiSTfdEIuByQWyVUXbt
         HRCBl5fWUys0wTRnIsMleRjdXPlYLsjTKMp1zf1mZV4vnvxz+snFCZAyw0jVoX+U3NQ8
         ak2bgLK7ZBErh1wFVL67QG5GuWm+kAuZPRrkgbD/Kjs09Ssy3kxgFklNpIds89MzUybe
         OyZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747423196; x=1748027996;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fhioi7Gcj72mRexvdqlPLPc4DSIey+OidUjZOy0mNj0=;
        b=lJ+W38g2YdkOSXllqffoUgB+0DoLKyz628ZC0gKMp5HOrlkSyFB/yVYU2NOrtzetzT
         Znf+7ajl/S8eVTOFibkGd8B1wwTYTFwiUQ51LubsVvHndfv6rtF0gQObm89F+O2krEGu
         bM0nrxluDH68Hd5768/QB/Ql0jxcVQNh/+YNqyYC+FXeNG08wdKwZDo0YgEUoZi597bb
         SXEjkPShwxypMuuvXhL+ZV5ySAfIwx0II4CgU4OTUJNXWY5I0RkreSh8ZaJdFkaFRV8M
         vNIbnSyzLwgdvcTcrv6rGbcle6YF7fZzM2NYZ6UefAiLmjgnux3pBRHuiY34tOsnic83
         7Dng==
X-Forwarded-Encrypted: i=1; AJvYcCXHRprMFzeuQVLTEquDrXdrC4La4a8GfTKTJz2lA1qXGcUPsGoBARqgSDZhsvrXpHhpg22gv9vkWzQSs64=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBPSVaDzbTzTyMHd6MvWAMzxMAw+VAPgYb5bnku3pLGvGczRF0
	qqfa3cF0++SnntNII1TPGUA82laKKn6+k80xNigR3iWHr0v+8uMie5v5UdzxMpnuIZ542fJENyQ
	bvewGWDC18w==
X-Google-Smtp-Source: AGHT+IEfkAWU/U59zbcJcvSExnx+OOOVI8NlhezCdt4M6QGEKDcwIKgF2uEEwit281pMZ3Ls6GbeSRldOOqo
X-Received: from pfdf22.prod.google.com ([2002:aa7:8b16:0:b0:742:a71a:ea85])
 (user=afranji job=prod-delivery.src-stubby-dispatcher) by 2002:aa7:88cc:0:b0:742:a02e:dd82
 with SMTP id d2e1a72fcca58-742a98dce7fmr5684560b3a.22.1747423195895; Fri, 16
 May 2025 12:19:55 -0700 (PDT)
Date: Fri, 16 May 2025 19:19:25 +0000
In-Reply-To: <cover.1747368092.git.afranji@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1747368092.git.afranji@google.com>
X-Mailer: git-send-email 2.49.0.1101.gccaa498523-goog
Message-ID: <1ade7750adbfe39ca5b8e074ad5edb37a7bc7e54.1747368092.git.afranji@google.com>
Subject: [RFC PATCH v2 05/13] KVM: selftests: Add tests for
 KVM_LINK_GUEST_MEMFD ioctl
From: Ryan Afranji <afranji@google.com>
To: afranji@google.com, ackerleytng@google.com, pbonzini@redhat.com, 
	seanjc@google.com, tglx@linutronix.de, x86@kernel.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	tabba@google.com
Cc: mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	shuah@kernel.org, andrew.jones@linux.dev, ricarkol@google.com, 
	chao.p.peng@linux.intel.com, jarkko@kernel.org, yu.c.zhang@linux.intel.com, 
	vannapurve@google.com, erdemaktas@google.com, mail@maciej.szmigiero.name, 
	vbabka@suse.cz, david@redhat.com, qperret@google.com, michael.roth@amd.com, 
	wei.w.wang@intel.com, liam.merwick@oracle.com, isaku.yamahata@gmail.com, 
	kirill.shutemov@linux.intel.com, sagis@google.com, jthoughton@google.com
Content-Type: text/plain; charset="UTF-8"

From: Ackerley Tng <ackerleytng@google.com>

Test that

+ Invalid inputs should be rejected with EINVAL
+ Successful inputs return a new (destination) fd
+ Destination and source fds have the same inode number
+ No crash on program exit

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ryan Afranji <afranji@google.com>
---
 .../testing/selftests/kvm/guest_memfd_test.c  | 43 +++++++++++++++++++
 .../testing/selftests/kvm/include/kvm_util.h  | 18 ++++++++
 2 files changed, 61 insertions(+)

diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
index ce687f8d248f..9b2a58cd9b64 100644
--- a/tools/testing/selftests/kvm/guest_memfd_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_test.c
@@ -170,6 +170,48 @@ static void test_create_guest_memfd_multiple(struct kvm_vm *vm)
 	close(fd1);
 }
 
+static void test_link(struct kvm_vm *src_vm, int src_fd, size_t total_size)
+{
+	int ret;
+	int dst_fd;
+	struct kvm_vm *dst_vm;
+	struct stat src_stat;
+	struct stat dst_stat;
+
+	dst_vm = vm_create_barebones();
+
+	/* Linking with a nonexistent fd */
+	dst_fd = __vm_link_guest_memfd(dst_vm, 99, 0);
+	TEST_ASSERT_EQ(dst_fd, -1);
+	TEST_ASSERT_EQ(errno, EINVAL);
+
+	/* Linking with a non-gmem fd */
+	dst_fd = __vm_link_guest_memfd(dst_vm, 0, 1);
+	TEST_ASSERT_EQ(dst_fd, -1);
+	TEST_ASSERT_EQ(errno, EINVAL);
+
+	/* Linking with invalid flags */
+	dst_fd = __vm_link_guest_memfd(dst_vm, src_fd, 1);
+	TEST_ASSERT_EQ(dst_fd, -1);
+	TEST_ASSERT_EQ(errno, EINVAL);
+
+	/* Linking with an already-associated vm */
+	dst_fd = __vm_link_guest_memfd(src_vm, src_fd, 1);
+	TEST_ASSERT_EQ(dst_fd, -1);
+	TEST_ASSERT_EQ(errno, EINVAL);
+
+	dst_fd = __vm_link_guest_memfd(dst_vm, src_fd, 0);
+	TEST_ASSERT(dst_vm > 0, "linking should succeed with valid inputs");
+	TEST_ASSERT(src_fd != dst_fd, "linking should return a different fd");
+
+	ret = fstat(src_fd, &src_stat);
+	TEST_ASSERT_EQ(ret, 0);
+	ret = fstat(dst_fd, &dst_stat);
+	TEST_ASSERT_EQ(ret, 0);
+	TEST_ASSERT(src_stat.st_ino == dst_stat.st_ino,
+		    "src and dst files should have the same inode number");
+}
+
 int main(int argc, char *argv[])
 {
 	size_t page_size;
@@ -194,6 +236,7 @@ int main(int argc, char *argv[])
 	test_file_size(fd, page_size, total_size);
 	test_fallocate(fd, page_size, total_size);
 	test_invalid_punch_hole(fd, page_size, total_size);
+	test_link(vm, fd, total_size);
 
 	close(fd);
 }
diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 373912464fb4..68faa658b69e 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -571,6 +571,24 @@ static inline int vm_create_guest_memfd(struct kvm_vm *vm, uint64_t size,
 	return fd;
 }
 
+static inline int __vm_link_guest_memfd(struct kvm_vm *vm, int fd, uint64_t flags)
+{
+	struct kvm_link_guest_memfd params = {
+		.fd = fd,
+		.flags = flags,
+	};
+
+	return __vm_ioctl(vm, KVM_LINK_GUEST_MEMFD, &params);
+}
+
+static inline int vm_link_guest_memfd(struct kvm_vm *vm, int fd, uint64_t flags)
+{
+	int new_fd = __vm_link_guest_memfd(vm, fd, flags);
+
+	TEST_ASSERT(new_fd >= 0, KVM_IOCTL_ERROR(KVM_LINK_GUEST_MEMFD, new_fd));
+	return new_fd;
+}
+
 void vm_set_user_memory_region(struct kvm_vm *vm, uint32_t slot, uint32_t flags,
 			       uint64_t gpa, uint64_t size, void *hva);
 int __vm_set_user_memory_region(struct kvm_vm *vm, uint32_t slot, uint32_t flags,
-- 
2.49.0.1101.gccaa498523-goog


