Return-Path: <linux-kernel+bounces-820012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D7E1B8005C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 16:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA11B1C001D3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 05:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22FD27FD48;
	Wed, 17 Sep 2025 05:59:25 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E83270EBC
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 05:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758088765; cv=none; b=rfRJBJSX6X6IZ8sGZ+uXVqY4zxohFGtYQPy30aNZCPW+G1U5w5yQEKYlWtjoyRZTiFepzhj35p7Bsqrhuk/ZHJzXAEbX7H1iDdCFcThLXFReaFj+7YHwbQqBI53x7t1QWKefWKy4qHEkvBuQEDhmqFVbRKEaKkAm2JplyF544do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758088765; c=relaxed/simple;
	bh=8R658MgjSKQ6OjkgZybldgeN9jzE69wFj18W4yvtA1k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NjmH5V/h3BtivTaBDM51XUsPQwnFr6Rty2tu1jaCj8x95vHxsVhHA/hoTryZ519VTmKx3zn/6k+HdO+Yjbi5ynTUr8KH8Ka5xtFjhzwtGLKpRAF6auk1gxhJvAYnv4ekSTfAvzC0DqDXMzTKKeouVn/8HV26NwA23axK4Y+c2fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45df0cde41bso44942085e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 22:59:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758088762; x=1758693562;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XlrrbpNOChtNjzl9J83pPts581jGsxoyMpwY2SqwJY4=;
        b=DwCOT9Nl8PNjflvEIuZASUhmMfcJozQWvkGHTaBxN2i5l8RxGaVFyZo7wFwuoasa1x
         TcLt8TbQjYKU/5PJ2Lsj5DgIojavPdowIzZQMFIJfWcWHSM0/9tHg2qnvlgzjKIWN2kX
         JNNl0HL0hS95BwN4gH1PeuR5J3HiUoij7AWjf5vfZUskJFv5SKihLL8zVUv+JnyK2hlI
         Nn2QCHPoRHL3kpOfKwaFE7ki7MBuJk/aJLKCvDjVEz0w989SY7zpLYjvbtNwV/KBRvZq
         Yidq6WFomQz1OLyZPMR6/ng4fn8JtjHFqT1+otKHQl0dW4W1J5vaWtoKwIPn41BVEQgm
         FM9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWYKFm54f2Fq0sixxoZ/J/dvhl6ic6mXP9ZkBQzBbYUHEvLdtBB45RmoGP+AxAuScbhwNhvE9HRviWsFZU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywccg5pUD7dQ54goWP0o63rOH5wPQNFom/ENlpAOLOQCgVsgBvF
	WoQjncPRC+dbZ7dUng5QPG2EgN+ULfW9ZDCB2ejyZ3S/CLpQ+mGC3YNh
X-Gm-Gg: ASbGncsEhSlpOZiBCTYdhJ/AZ/yEVs0Rdt7c9k9w2LRw8OqwzcwRvr2ZofAgt7pmkGO
	8TWtioacpd8gGPZsNDlIkQUc6/+EGBYNW5fI+zWtCqzzJ/6aiwWEesxuwG3fJWjQXgE8eEF1tO0
	T4TuPuxyL8ajYhkz+amw4oszbuLq4xjYk2uE/4+qJhbIDGMtzvbK6wHm65KWUVJtvP0KKbCbg0A
	vOOVWMem9gAtWQLmR9KB1fPfx6eS9a8jNw9plUR7tG577TPeU5hEAyFo1FHd7urKnmBASfwfn6S
	oCNkMiJCa6AyQ0rfI5ZY2FbhfLVdrVb4WA1mi1CrSRDoJpYOg6gErOg/LuCOUoZn3dNy+8VXazI
	PsYmBGRzIJ92y2a8vouk=
X-Google-Smtp-Source: AGHT+IH9W7esOzFT5IkroJVMwtaxdDK6d7E9R4NeEsWdBedzAfyvLtUnHVT1+OGn9VtvheonzXFrmg==
X-Received: by 2002:a05:6000:1863:b0:3e7:6474:1b63 with SMTP id ffacd0b85a97d-3ecdfa3d20fmr589203f8f.63.1758088761975;
        Tue, 16 Sep 2025 22:59:21 -0700 (PDT)
Received: from EBJ9932692.tcent.cn ([2a09:0:1:2::3086])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7c778f764sm19485191f8f.57.2025.09.16.22.59.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 16 Sep 2025 22:59:21 -0700 (PDT)
From: Lance Yang <lance.yang@linux.dev>
To: akpm@linux-foundation.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com
Cc: shuah@kernel.org,
	ioworker0@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	Lance Yang <lance.yang@linux.dev>
Subject: [PATCH RESEND 1/1] selftests/mm: skip soft-dirty tests when CONFIG_MEM_SOFT_DIRTY is disabled
Date: Wed, 17 Sep 2025 13:59:13 +0800
Message-ID: <20250917055913.49759-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lance Yang <lance.yang@linux.dev>

The madv_populate and soft-dirty kselftests currently fail on systems where
CONFIG_MEM_SOFT_DIRTY is disabled.

Introduce a new helper softdirty_is_supported() into vm_util.c/h to ensure
tests are properly skipped when the feature is not enabled.

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Lance Yang <lance.yang@linux.dev>
---
 tools/testing/selftests/mm/madv_populate.c | 21 ++--------------
 tools/testing/selftests/mm/soft-dirty.c    |  5 +++-
 tools/testing/selftests/mm/vm_util.c       | 28 ++++++++++++++++++++++
 tools/testing/selftests/mm/vm_util.h       |  1 +
 4 files changed, 35 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/mm/madv_populate.c b/tools/testing/selftests/mm/madv_populate.c
index b6fabd5c27ed..43dac7783004 100644
--- a/tools/testing/selftests/mm/madv_populate.c
+++ b/tools/testing/selftests/mm/madv_populate.c
@@ -264,23 +264,6 @@ static void test_softdirty(void)
 	munmap(addr, SIZE);
 }
 
-static int system_has_softdirty(void)
-{
-	/*
-	 * There is no way to check if the kernel supports soft-dirty, other
-	 * than by writing to a page and seeing if the bit was set. But the
-	 * tests are intended to check that the bit gets set when it should, so
-	 * doing that check would turn a potentially legitimate fail into a
-	 * skip. Fortunately, we know for sure that arm64 does not support
-	 * soft-dirty. So for now, let's just use the arch as a corse guide.
-	 */
-#if defined(__aarch64__)
-	return 0;
-#else
-	return 1;
-#endif
-}
-
 int main(int argc, char **argv)
 {
 	int nr_tests = 16;
@@ -288,7 +271,7 @@ int main(int argc, char **argv)
 
 	pagesize = getpagesize();
 
-	if (system_has_softdirty())
+	if (softdirty_is_supported())
 		nr_tests += 5;
 
 	ksft_print_header();
@@ -300,7 +283,7 @@ int main(int argc, char **argv)
 	test_holes();
 	test_populate_read();
 	test_populate_write();
-	if (system_has_softdirty())
+	if (softdirty_is_supported())
 		test_softdirty();
 
 	err = ksft_get_fail_cnt();
diff --git a/tools/testing/selftests/mm/soft-dirty.c b/tools/testing/selftests/mm/soft-dirty.c
index 8a3f2b4b2186..98e42d2ac32a 100644
--- a/tools/testing/selftests/mm/soft-dirty.c
+++ b/tools/testing/selftests/mm/soft-dirty.c
@@ -200,8 +200,11 @@ int main(int argc, char **argv)
 	int pagesize;
 
 	ksft_print_header();
-	ksft_set_plan(15);
 
+	if (!softdirty_is_supported())
+		ksft_exit_skip("soft-dirty is not support\n");
+
+	ksft_set_plan(15);
 	pagemap_fd = open(PAGEMAP_FILE_PATH, O_RDONLY);
 	if (pagemap_fd < 0)
 		ksft_exit_fail_msg("Failed to open %s\n", PAGEMAP_FILE_PATH);
diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
index 56e9bd541edd..3173335df775 100644
--- a/tools/testing/selftests/mm/vm_util.c
+++ b/tools/testing/selftests/mm/vm_util.c
@@ -449,6 +449,34 @@ bool check_vmflag_pfnmap(void *addr)
 	return check_vmflag(addr, "pf");
 }
 
+bool softdirty_is_supported(void)
+{
+	char *addr;
+	int ret = 0;
+	size_t pagesize;
+
+	/* We know for sure that arm64 does not support soft-dirty. */
+#if defined(__aarch64__)
+	return ret;
+#endif
+	pagesize = getpagesize();
+	/*
+	 * __mmap_complete() always sets VM_SOFTDIRTY for new VMAs, so we
+	 * just mmap a small region and check its VmFlags in /proc/self/smaps
+	 * for the "sd" flag.
+	 */
+	addr = mmap(0, pagesize, PROT_READ | PROT_WRITE,
+		    MAP_ANONYMOUS | MAP_PRIVATE, 0, 0);
+	if (!addr)
+		ksft_exit_fail_msg("mmap failed\n");
+
+	if (check_vmflag(addr, "sd"))
+		ret = 1;
+
+	munmap(addr, pagesize);
+	return ret;
+}
+
 /*
  * Open an fd at /proc/$pid/maps and configure procmap_out ready for
  * PROCMAP_QUERY query. Returns 0 on success, or an error code otherwise.
diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
index 07c4acfd84b6..87ad8e0d92c0 100644
--- a/tools/testing/selftests/mm/vm_util.h
+++ b/tools/testing/selftests/mm/vm_util.h
@@ -104,6 +104,7 @@ bool find_vma_procmap(struct procmap_fd *procmap, void *address);
 int close_procmap(struct procmap_fd *procmap);
 int write_sysfs(const char *file_path, unsigned long val);
 int read_sysfs(const char *file_path, unsigned long *val);
+bool softdirty_is_supported(void);
 
 static inline int open_self_procmap(struct procmap_fd *procmap_out)
 {
-- 
2.49.0


