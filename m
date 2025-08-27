Return-Path: <linux-kernel+bounces-788350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2034B3834A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 15:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D962F7BBFBC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 13:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3BA35691D;
	Wed, 27 Aug 2025 13:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wgn52CyE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JRXfaBpH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47F6352072
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 13:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756299626; cv=none; b=EP9rjHjSKi6+SlXocWDg42ZBR6cufGHNf8w87AS5Li1MEpEm4XcHCOWEgTT3md+6aHEIqotrrzh0zaD4t03Y2Ay9qwJrLlcwQ6e83Qf6OsbUwbZcUmEzam0tsR5qU/Vetmr+qa5QZV8cjd1jX7tlwUhsRNCbABWIgQk+YOboBHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756299626; c=relaxed/simple;
	bh=TfFEfr5s064S3vJCTGQQHgqn9d+T4y0vFjYbEftXXqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G/JF7hwCYweVB0pkRbeCcXSAa1C8tTvKAmrFVk2laWWVK3Y0UsckO0eW7t23vLNf5hQo18MYYSb4j4ISpXP0CmuNMCzEXXgkw3pROhl6RrbEYjljJBec2NHZuSlKcecjZy+K6Ezpxg1pnOTiwfgvsq8QsdrmITXrEVV06SzF+FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wgn52CyE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JRXfaBpH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756299622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mDGRB9Y+2+cEKCn+VJWaTdBnPH653Bxj7PgTKgx67QY=;
	b=wgn52CyEi2JAth9QiC7hYJQVqGgoYu6NxcjTypJb9nf4xs2oialhgaJoOYPIS7DGwPu8oo
	6KydDjUAKZbGnezATHGO3p3Emirz5sP2kpdA9VNmQKNPAeqkWIMe23NSlAkAqPKNPT1KFM
	W0eD8pJCL7uLrUIZMjTYjj2a4c39fJ/Pi/AyGYUf8a6mrYykyryQVEEDdVxPYqe5Qha2E9
	rHt40FIBDQJet136pGjCgRJKriX/EjUf94Oj0HcG2L1B2ToBwwXXZpKtuZxSDSsVpSU4dD
	j9ufmmQTDB41ksHEYBb/w91bjD0tbGIoVKXPhPF9w4Ex0fdcKP7FVsqJQyKEqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756299622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mDGRB9Y+2+cEKCn+VJWaTdBnPH653Bxj7PgTKgx67QY=;
	b=JRXfaBpHP9J9/8ZgDF6kxQmp6hDlm+LcBFmVTcAcddNIKt2uOjSUA/pWKvdM0sxHZMPmee
	pPEDZ+P16uS8WwAg==
To: linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Waiman Long <longman@redhat.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Anders Roxell <anders.roxell@linaro.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 5/5] selftests/futex: fix futex_wait() for 32bit ARM
Date: Wed, 27 Aug 2025 15:00:11 +0200
Message-ID: <20250827130011.677600-6-bigeasy@linutronix.de>
In-Reply-To: <20250827130011.677600-1-bigeasy@linutronix.de>
References: <20250827130011.677600-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Dan Carpenter <dan.carpenter@linaro.org>

On 32bit ARM systems gcc-12 will use 32bit timestamps while gcc-13 and
later will use 64bit timestamps.  The problem is that SYS_futex will
continue pointing at the 32bit system call.  This makes the futex_wait
test fail like this:

waiter failed errno 110
not ok 1 futex_wake private returned: 0 Success
waiter failed errno 110
not ok 2 futex_wake shared (page anon) returned: 0 Success
waiter failed errno 110
not ok 3 futex_wake shared (file backed) returned: 0 Success

Instead of compiling differently depending on the gcc version, use the
-D_FILE_OFFSET_BITS=3D64 -D_TIME_BITS=3D64 options to ensure that we are
building with 64bit timestamps.  Then use ifdefs to make SYS_futex point
to the 64bit system call.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Tested-by: Anders Roxell <anders.roxell@linaro.org>
Link: https://lore.kernel.org/r/ebd4a415169f9a3153bbd3c1fe6244511c9d1cb3.17=
56217858.git.dan.carpenter@linaro.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 tools/testing/selftests/futex/functional/Makefile |  2 +-
 tools/testing/selftests/futex/include/futextest.h | 11 +++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/futex/functional/Makefile b/tools/test=
ing/selftests/futex/functional/Makefile
index 8cfb87f7f7c50..ddfa61d857b9b 100644
--- a/tools/testing/selftests/futex/functional/Makefile
+++ b/tools/testing/selftests/futex/functional/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 INCLUDES :=3D -I../include -I../../ $(KHDR_INCLUDES)
-CFLAGS :=3D $(CFLAGS) -g -O2 -Wall -pthread $(INCLUDES) $(KHDR_INCLUDES)
+CFLAGS :=3D $(CFLAGS) -g -O2 -Wall -pthread -D_FILE_OFFSET_BITS=3D64 -D_TI=
ME_BITS=3D64 $(INCLUDES) $(KHDR_INCLUDES)
 LDLIBS :=3D -lpthread -lrt -lnuma
=20
 LOCAL_HDRS :=3D \
diff --git a/tools/testing/selftests/futex/include/futextest.h b/tools/test=
ing/selftests/futex/include/futextest.h
index 7a5fd1d5355e7..3d48e9789d9fe 100644
--- a/tools/testing/selftests/futex/include/futextest.h
+++ b/tools/testing/selftests/futex/include/futextest.h
@@ -58,6 +58,17 @@ typedef volatile u_int32_t futex_t;
 #define SYS_futex SYS_futex_time64
 #endif
=20
+/*
+ * On 32bit systems if we use "-D_FILE_OFFSET_BITS=3D64 -D_TIME_BITS=3D64"=
 or if
+ * we are using a newer compiler then the size of the timestamps will be 6=
4bit,
+ * however, the SYS_futex will still point to the 32bit futex system call.
+ */
+#if __SIZEOF_POINTER__ =3D=3D 4 && defined(SYS_futex_time64) && \
+	defined(_TIME_BITS) && _TIME_BITS =3D=3D 64
+# undef SYS_futex
+# define SYS_futex SYS_futex_time64
+#endif
+
 /**
  * futex() - SYS_futex syscall wrapper
  * @uaddr:	address of first futex
--=20
2.50.1


