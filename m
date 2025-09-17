Return-Path: <linux-kernel+bounces-820009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02722B7C4F4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 13:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 561CC17C14D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 05:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7D41C5F23;
	Wed, 17 Sep 2025 05:56:40 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E1C72614
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 05:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758088600; cv=none; b=S18jQj4XS9UqMXR7aAaWCExHPtjqHMH/NSjDq4RRyCxbfY6A4+6BgdVi/DKy9wga3pFBNgKkH+OXf3m4/0iV8rKYyuicQUy6gc5OsZvhU4cel5oIbgzbR9rBYRNvWXGp84hSHtwFr1I7nuP/Wr0YA5zUhGUbcPqmV3kgt1E/4RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758088600; c=relaxed/simple;
	bh=HEAtg16SjSSpTPSJTLyQUgy2jQeNKW9e6mUD3MY3hAM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NtkPpbQ3MkD00SWwHP1xqCxciX6/xaJwgAK3fgsQK5xkYIeGk3UMO+t5mVWVLgB+23R1Il1ixFSUM7C4q12Ev9zH8FlVvMUZTYUa93SMpYW5FfC10NWrjgr5f19UQdXiU8WOTguN+bNW+IzqKPUvi5F+7qRqoW631lSXpe4tNYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45f29dd8490so32412125e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 22:56:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758088596; x=1758693396;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4rL2rlM29fREnsY3UP4GCd3w0RbbtqI2tzuuAuaZNNM=;
        b=WERZa59YndEt1mHQ3+KLJuRtGumC4buH6QrECr2ego1huzOaTcqi5WCootsY3PeIwr
         dnYhDn9kMx0dVvg5CTFPmB+H43WrMIDXAD1KbxzsBxKRa/MgzFGrcqF0uiXw8cK4TFEY
         FaZnvf90Gu4SnX50NjsCbGJjRpCGEjiZH7pTgC2yDX1kR8V7oxORRGs4H8SM96+OK84G
         Vm4CbU8ytv76SYCFWqXYN+KOU/OtyRJ3dKdnmGxW4RA0TEeVtCA5mtkqMQosf/ainQnF
         PLGRFMClvpws8pQemmISpkzL81br/Y/N70CexhtuYa2BXVmn5TJtkBVuWpkp6woDjl3Z
         ZGZA==
X-Forwarded-Encrypted: i=1; AJvYcCU0bYZRm8hv4DG459FhVPNEs3yxl9Uhf0BmiffVD2XWt/biwXbbcdl2Y+2GE1VtwHEZU0XK1IiMKLWSMBs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn7mpb8MPaYVmUA5e19kj+Fz/1m40XUQQJrefXpEKzxxiTyin/
	V6cCZHjf1vcGz0qitCiz2rPngzTtDVB8z6Tuf+a+vTJre1rj2k5ogD13
X-Gm-Gg: ASbGncvGmp2zEA6WICQP8j2fgLQk+4V27rVTxDtIwEZNNlLaFmtg0Ek6LCb0tnbU0+h
	bxelXGHlurGWZKv6/zj9p9rRivgqU0HwoeBGOfuBcjPOvBaR4L3vmyl8eN29Ag68ILBhUuzizIm
	Z+IIh1YHYQHSAwpbTHKnGG+tyTwY8hNOfupb+zMjjSXkxJM5hHvYXwoTXDnhW1T0P0PEeT7v8pG
	kqpQPJdxVZ9gn3NH4AEjlRoFD7I6YdV0/URB2c9OO2TXm1YZhK8Hi/d8K+oTz+yQv+2S96x1UNx
	1kpP+GiqVbBexcnT0bp1UYuaP2GK9bJq3CnviSAFluEcxqmHiL1t1epCnUOOz+ouRiw13IuDab5
	ejYMtkhI7
X-Google-Smtp-Source: AGHT+IGjxHPHG8T6fPu431Ka9rSzcuna7td6QNzojHq1qsMru8NT7pUxzrEnuuQd7KWe/4SL2weFmQ==
X-Received: by 2002:a5d:64c8:0:b0:3ea:e0fd:28ea with SMTP id ffacd0b85a97d-3ecdfa0d2e6mr682457f8f.39.1758088595501;
        Tue, 16 Sep 2025 22:56:35 -0700 (PDT)
Received: from EBJ9932692.tcent.cn ([2a09:0:1:2::3086])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ecdf0bbf24sm1433237f8f.63.2025.09.16.22.56.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 16 Sep 2025 22:56:34 -0700 (PDT)
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
Subject: [PATCH 1/1] selftests/mm: skip soft-dirty tests when CONFIG_MEM_SOFT_DIRTY is disabled
Date: Wed, 17 Sep 2025 13:56:22 +0800
Message-ID: <20250917055622.46564-1-lance.yang@linux.dev>
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


