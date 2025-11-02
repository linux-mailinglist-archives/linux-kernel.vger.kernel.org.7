Return-Path: <linux-kernel+bounces-881745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E869C28D90
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 11:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3397A3B3BAD
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 10:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55EC726D4DF;
	Sun,  2 Nov 2025 10:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b="WFuFja4l"
Received: from mta1.formilux.org (mta1.formilux.org [51.159.59.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FB113AA2F
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 10:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.59.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762080384; cv=none; b=VmbAPPCBWpwaWu4SQlM/M6Bz8DoRG/YTPXVwsz3RSErcjtIjSMkLPzAbHV9E9xYbqqBUwSKpg4b7WlrgCvfg2ADiuvJgJ39bjU7bQXXwhsPo+dGXBQXYXEUBi4L4kWlxRNS0D8JpaoeZx6q1GF5rbzomsl4O0zgNIz3hweYnG/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762080384; c=relaxed/simple;
	bh=KcSxWvaTfgiPznYBJjhM24Y/zlBKF8QAUvPo0Ohw+sM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=mfBWR08l4qBLr4cvITQ/NHOJsAKTHhTU6SYRb4M4r4qJGfsqDRiRQaPaEOcdMCY0wAAL78QBbviqz94fmPktXeshmElESm/V1WZXMU0cMBH66fe569QkmzPCBnOmmZYP0gdcsR7+C1epQcZNou0xpQpq0pbrT6ZJrQAWxQFITdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b=WFuFja4l; arc=none smtp.client-ip=51.159.59.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1762080380; bh=fZvOR2fDFMyEG2JJ7YKCTsBH/z2SenLZ1zI+0eNrGLA=;
	h=From:Message-Id:From;
	b=WFuFja4lSiVOUtvfQhNfSxZ1MwST1GDE8F47xWS/QTPeg6ZTYaSb8bEvGvyVJ/R2l
	 lBdcCtiguK8y/CAlCvcZ6DTQm4jP5uFW7LAhfPiU2HfBfTJOM+8nJkpG0xZQVd8AqT
	 bWaoVNLxJ3qpKR14kAIfBBW35Bv4IMzmWQJ7T9qs=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id 0EC0AC0953;
	Sun, 02 Nov 2025 11:46:20 +0100 (CET)
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 5A2AkJC9024504;
	Sun, 2 Nov 2025 11:46:19 +0100
From: Willy Tarreau <w@1wt.eu>
To: linux@weissschuh.net
Cc: shuah@kernel.org, linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH v2 4/4] tools/nolibc: provide the portable sys/select.h
Date: Sun,  2 Nov 2025 11:46:11 +0100
Message-Id: <20251102104611.24454-5-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
In-Reply-To: <20251102104611.24454-1-w@1wt.eu>
References: <20251102104611.24454-1-w@1wt.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Modern programs tend to include sys/select.h to get FD_SET() and
FD_CLR() definitions as well as struct fd_set, but in our case it
didn't exist.

The definitions were moved from types.h to sys/select.h, which is
now included from nolibc.h, and the sys_select() definition moved
there as well from sys.h.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/Makefile     |   1 +
 tools/include/nolibc/nolibc.h     |   1 +
 tools/include/nolibc/sys.h        |  45 -------------
 tools/include/nolibc/sys/select.h | 103 ++++++++++++++++++++++++++++++
 tools/include/nolibc/types.h      |  47 --------------
 5 files changed, 105 insertions(+), 92 deletions(-)
 create mode 100644 tools/include/nolibc/sys/select.h

diff --git a/tools/include/nolibc/Makefile b/tools/include/nolibc/Makefile
index 0d312f1159ec..ff0e646acda9 100644
--- a/tools/include/nolibc/Makefile
+++ b/tools/include/nolibc/Makefile
@@ -57,6 +57,7 @@ all_files := \
 		sys/random.h \
 		sys/reboot.h \
 		sys/resource.h \
+		sys/select.h \
 		sys/stat.h \
 		sys/syscall.h \
 		sys/sysmacros.h \
diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index d2f5aa085f8e..91e2795ae49c 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -104,6 +104,7 @@
 #include "sys/random.h"
 #include "sys/reboot.h"
 #include "sys/resource.h"
+#include "sys/select.h"
 #include "sys/stat.h"
 #include "sys/syscall.h"
 #include "sys/sysmacros.h"
diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index aeb57bb68e92..dc8a83c716ab 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -752,51 +752,6 @@ int sched_yield(void)
 }
 
 
-/*
- * int select(int nfds, fd_set *read_fds, fd_set *write_fds,
- *            fd_set *except_fds, struct timeval *timeout);
- */
-
-static __attribute__((unused))
-int sys_select(int nfds, fd_set *rfds, fd_set *wfds, fd_set *efds, struct timeval *timeout)
-{
-#if defined(__ARCH_WANT_SYS_OLD_SELECT) && !defined(__NR__newselect)
-	struct sel_arg_struct {
-		unsigned long n;
-		fd_set *r, *w, *e;
-		struct timeval *t;
-	} arg = { .n = nfds, .r = rfds, .w = wfds, .e = efds, .t = timeout };
-	return my_syscall1(__NR_select, &arg);
-#elif defined(__NR__newselect)
-	return my_syscall5(__NR__newselect, nfds, rfds, wfds, efds, timeout);
-#elif defined(__NR_select)
-	return my_syscall5(__NR_select, nfds, rfds, wfds, efds, timeout);
-#elif defined(__NR_pselect6_time64)
-	struct __kernel_timespec t;
-
-	if (timeout) {
-		t.tv_sec  = timeout->tv_sec;
-		t.tv_nsec = timeout->tv_usec * 1000;
-	}
-	return my_syscall6(__NR_pselect6_time64, nfds, rfds, wfds, efds, timeout ? &t : NULL, NULL);
-#else
-	struct timespec t;
-
-	if (timeout) {
-		t.tv_sec  = timeout->tv_sec;
-		t.tv_nsec = timeout->tv_usec * 1000;
-	}
-	return my_syscall6(__NR_pselect6, nfds, rfds, wfds, efds, timeout ? &t : NULL, NULL);
-#endif
-}
-
-static __attribute__((unused))
-int select(int nfds, fd_set *rfds, fd_set *wfds, fd_set *efds, struct timeval *timeout)
-{
-	return __sysret(sys_select(nfds, rfds, wfds, efds, timeout));
-}
-
-
 /*
  * int setpgid(pid_t pid, pid_t pgid);
  */
diff --git a/tools/include/nolibc/sys/select.h b/tools/include/nolibc/sys/select.h
new file mode 100644
index 000000000000..71cdadde32b5
--- /dev/null
+++ b/tools/include/nolibc/sys/select.h
@@ -0,0 +1,103 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+
+#include "../nolibc.h"
+
+#ifndef _NOLIBC_SYS_SELECT_H
+#define _NOLIBC_SYS_SELECT_H
+
+#include <linux/time.h>
+#include <linux/unistd.h>
+
+/* commonly an fd_set represents 256 FDs */
+#ifndef FD_SETSIZE
+#define FD_SETSIZE     256
+#endif
+
+#define FD_SETIDXMASK (8 * sizeof(unsigned long))
+#define FD_SETBITMASK (8 * sizeof(unsigned long)-1)
+
+/* for select() */
+typedef struct {
+	unsigned long fds[(FD_SETSIZE + FD_SETBITMASK) / FD_SETIDXMASK];
+} fd_set;
+
+#define FD_CLR(fd, set) do {						\
+		fd_set *__set = (set);					\
+		int __fd = (fd);					\
+		if (__fd >= 0)						\
+			__set->fds[__fd / FD_SETIDXMASK] &=		\
+				~(1U << (__fd & FD_SETBITMASK));	\
+	} while (0)
+
+#define FD_SET(fd, set) do {						\
+		fd_set *__set = (set);					\
+		int __fd = (fd);					\
+		if (__fd >= 0)						\
+			__set->fds[__fd / FD_SETIDXMASK] |=		\
+				1 << (__fd & FD_SETBITMASK);		\
+	} while (0)
+
+#define FD_ISSET(fd, set) ({						\
+			fd_set *__set = (set);				\
+			int __fd = (fd);				\
+		int __r = 0;						\
+		if (__fd >= 0)						\
+			__r = !!(__set->fds[__fd / FD_SETIDXMASK] &	\
+1U << (__fd & FD_SETBITMASK));						\
+		__r;							\
+	})
+
+#define FD_ZERO(set) do {						\
+		fd_set *__set = (set);					\
+		int __idx;						\
+		int __size = (FD_SETSIZE+FD_SETBITMASK) / FD_SETIDXMASK;\
+		for (__idx = 0; __idx < __size; __idx++)		\
+			__set->fds[__idx] = 0;				\
+	} while (0)
+
+/*
+ * int select(int nfds, fd_set *read_fds, fd_set *write_fds,
+ *            fd_set *except_fds, struct timeval *timeout);
+ */
+
+static __attribute__((unused))
+int sys_select(int nfds, fd_set *rfds, fd_set *wfds, fd_set *efds, struct timeval *timeout)
+{
+#if defined(__ARCH_WANT_SYS_OLD_SELECT) && !defined(__NR__newselect)
+	struct sel_arg_struct {
+		unsigned long n;
+		fd_set *r, *w, *e;
+		struct timeval *t;
+	} arg = { .n = nfds, .r = rfds, .w = wfds, .e = efds, .t = timeout };
+	return my_syscall1(__NR_select, &arg);
+#elif defined(__NR__newselect)
+	return my_syscall5(__NR__newselect, nfds, rfds, wfds, efds, timeout);
+#elif defined(__NR_select)
+	return my_syscall5(__NR_select, nfds, rfds, wfds, efds, timeout);
+#elif defined(__NR_pselect6_time64)
+	struct __kernel_timespec t;
+
+	if (timeout) {
+		t.tv_sec  = timeout->tv_sec;
+		t.tv_nsec = timeout->tv_usec * 1000;
+	}
+	return my_syscall6(__NR_pselect6_time64, nfds, rfds, wfds, efds, timeout ? &t : NULL, NULL);
+#else
+	struct timespec t;
+
+	if (timeout) {
+		t.tv_sec  = timeout->tv_sec;
+		t.tv_nsec = timeout->tv_usec * 1000;
+	}
+	return my_syscall6(__NR_pselect6, nfds, rfds, wfds, efds, timeout ? &t : NULL, NULL);
+#endif
+}
+
+static __attribute__((unused))
+int select(int nfds, fd_set *rfds, fd_set *wfds, fd_set *efds, struct timeval *timeout)
+{
+	return __sysret(sys_select(nfds, rfds, wfds, efds, timeout));
+}
+
+
+#endif /* _NOLIBC_SYS_SELECT_H */
diff --git a/tools/include/nolibc/types.h b/tools/include/nolibc/types.h
index 3b086f68b2be..e2216d1e2c3f 100644
--- a/tools/include/nolibc/types.h
+++ b/tools/include/nolibc/types.h
@@ -77,11 +77,6 @@ struct timespec {
 #define DT_LNK         0xa
 #define DT_SOCK        0xc
 
-/* commonly an fd_set represents 256 FDs */
-#ifndef FD_SETSIZE
-#define FD_SETSIZE     256
-#endif
-
 /* PATH_MAX and MAXPATHLEN are often used and found with plenty of different
  * values.
  */
@@ -122,48 +117,6 @@ struct timespec {
 #define EXIT_SUCCESS 0
 #define EXIT_FAILURE 1
 
-#define FD_SETIDXMASK (8 * sizeof(unsigned long))
-#define FD_SETBITMASK (8 * sizeof(unsigned long)-1)
-
-/* for select() */
-typedef struct {
-	unsigned long fds[(FD_SETSIZE + FD_SETBITMASK) / FD_SETIDXMASK];
-} fd_set;
-
-#define FD_CLR(fd, set) do {						\
-		fd_set *__set = (set);					\
-		int __fd = (fd);					\
-		if (__fd >= 0)						\
-			__set->fds[__fd / FD_SETIDXMASK] &=		\
-				~(1U << (__fd & FD_SETBITMASK));	\
-	} while (0)
-
-#define FD_SET(fd, set) do {						\
-		fd_set *__set = (set);					\
-		int __fd = (fd);					\
-		if (__fd >= 0)						\
-			__set->fds[__fd / FD_SETIDXMASK] |=		\
-				1 << (__fd & FD_SETBITMASK);		\
-	} while (0)
-
-#define FD_ISSET(fd, set) ({						\
-			fd_set *__set = (set);				\
-			int __fd = (fd);				\
-		int __r = 0;						\
-		if (__fd >= 0)						\
-			__r = !!(__set->fds[__fd / FD_SETIDXMASK] &	\
-1U << (__fd & FD_SETBITMASK));						\
-		__r;							\
-	})
-
-#define FD_ZERO(set) do {						\
-		fd_set *__set = (set);					\
-		int __idx;						\
-		int __size = (FD_SETSIZE+FD_SETBITMASK) / FD_SETIDXMASK;\
-		for (__idx = 0; __idx < __size; __idx++)		\
-			__set->fds[__idx] = 0;				\
-	} while (0)
-
 /* for getdents64() */
 struct linux_dirent64 {
 	uint64_t       d_ino;
-- 
2.17.5


