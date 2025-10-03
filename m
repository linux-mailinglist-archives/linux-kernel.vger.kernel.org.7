Return-Path: <linux-kernel+bounces-841854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B1ACCBB864C
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 01:29:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 939494EA390
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 23:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDAE32E0B55;
	Fri,  3 Oct 2025 23:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2tvIZou5"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4962E0402
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 23:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759533993; cv=none; b=lsjsydoexQ9i1towXkMd2z8iwF4F1B4BZcT6BHjUacbhogONz/EYUJOSr5wQddBsAMpih0m/RyOuKrlxWHJYQVAqGspEeAev6E8xL6FOag4pOj0PEopp+uV1GQGi1qMx3ACHZdwfHPMNOCWuM2FWtn4gL0GJ+jRLBr/5OhDRgmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759533993; c=relaxed/simple;
	bh=T5q/Pstt8Hv+p0rfhTZOtrB7/+T9mv44yI3DvCahIdQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jm5HoOTLAEmQ97uTpgD0g4ujzORe87FfGBtIHk/HRga9rfBxz8vPLFjLUvxwjzrgiMKhdVNkljae8b4LMLnUU1tARPMph6CQ0+2h2+N7AYGCww7oXY5vfjbB5rnP+KtzF6zIMRBj7XHHwHX+jRrk4s8Mb8hDzlIxFgRfjtYBSaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2tvIZou5; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-277f0ea6fc6so61831045ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 16:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759533991; x=1760138791; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=XjUM2sV954KpwJC6RI6Tq+jgNrfIi8qlx+Hwldv2z30=;
        b=2tvIZou5Veo7nHVtnbAFD1W3q2qrxgaAD+0H80e7snVMglQcH9TkK4IO7DtRZsK8Xj
         k9ssSA0okiB5vYYv3yEsTvoWxDr/rH9WSllVoOMpEDKP643lDSwHvT0mDqsFAX1xFwnU
         jCMrMxWFwBb0GtmOLiMgDUu+Mi+ELl5tfR8WOXL2JoZSRN7NmuvUlz5r5awaXFDmMAv4
         pLX8Xb0zRhvOYpts2MaSe9j8I6owTD8+s4Mo9sq1liRkFiMygoYPKWyrvKw/QX5z0mTs
         1XrITDqkFSSYjTiWDXEFdZW7jQGywxqOOSm3XSDMO/fR2xPzbXi8pdJ5QMOR2j0rEBUE
         EbbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759533991; x=1760138791;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XjUM2sV954KpwJC6RI6Tq+jgNrfIi8qlx+Hwldv2z30=;
        b=qdLlUf9jY4p6/QjGF8xPhs+ZFUUbB+f30stYGMh9k1xWlAMx8yU/1M6Brp/jtppxLk
         w1DVRe96WCea4bO+J84Q9SDtEUEm1Rg79BwsjpiDVXEuCAptVGFvH+7x/9WeQKxFGTCL
         WxtsdpB3l4A6ZMJB/0RYkqZtXQsKLYnC3M2K+sHwV8jk++Ibr8aJh4jtTFJTCLVRiAAz
         HH02GNgztBWKSL0AAXcxw4LAd3gDRlUn2WYqWzDZd7sZUDSM1iHSbRKTe4ieiwo2nJ1S
         t5ysJwSN+6BBorKOIRor+JTYM7H4mnnfKiM5is6wx7KSDqH8Bdxc1D/W/9xpeZuk3dvG
         eIbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQaXiClrDMyxgg3WWLkCeCzEzL6NCD4chBevtcOX8LiD/eo8wqPvhASc/A8SIr/eX+5qQYU1ukGDLtBWs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9bogt6zAcs+z4kWsktopm6enu4h9IB+tlOmKz/4ry1Nl5Uhbt
	Mv1/Z3XYQBmyBZz0aMeJeZATiiM4Yoh9VliJC6jcp4pt//Ecm5MUdyEYu1FPV2EXs3PzsBVHoE8
	LyiL8LA==
X-Google-Smtp-Source: AGHT+IG19O7ZXl8Fqd0uSmvKGqwgXKh9WcLOSUacVFErRjkEmb6o30mwo4Gc5YaiZFYjkErDhhmG9M5dZaM=
X-Received: from plde13.prod.google.com ([2002:a17:902:d38d:b0:27e:ea91:acb6])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2f84:b0:267:d2f9:2327
 with SMTP id d9443c01a7336-28e9a60cf7dmr61383055ad.27.1759533991556; Fri, 03
 Oct 2025 16:26:31 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri,  3 Oct 2025 16:26:04 -0700
In-Reply-To: <20251003232606.4070510-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251003232606.4070510-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251003232606.4070510-12-seanjc@google.com>
Subject: [PATCH v2 11/13] KVM: selftests: Add wrapper macro to handle and
 assert on expected SIGBUS
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Hildenbrand <david@redhat.com>, Fuad Tabba <tabba@google.com>, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

Extract the guest_memfd test's SIGBUS handling functionality into a common
TEST_EXPECT_SIGBUS() macro in anticipation of adding more SIGBUS testcases.
Eating a SIGBUS isn't terrible difficult, but it requires a non-trivial
amount of boilerplate code, and using a macro allows selftests to print
out the exact action that failed to generate a SIGBUS without the developer
needing to remember to add a useful error message.

Explicitly mark the SIGBUS handler as "used", as gcc-14 at least likes to
discard the function before linking.

Suggested-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../testing/selftests/kvm/guest_memfd_test.c  | 18 +-----------------
 .../testing/selftests/kvm/include/test_util.h | 19 +++++++++++++++++++
 tools/testing/selftests/kvm/lib/test_util.c   |  7 +++++++
 3 files changed, 27 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
index 640636c76eb9..73c2e54e7297 100644
--- a/tools/testing/selftests/kvm/guest_memfd_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_test.c
@@ -14,8 +14,6 @@
 #include <linux/bitmap.h>
 #include <linux/falloc.h>
 #include <linux/sizes.h>
-#include <setjmp.h>
-#include <signal.h>
 #include <sys/mman.h>
 #include <sys/types.h>
 #include <sys/stat.h>
@@ -77,17 +75,8 @@ static void test_mmap_supported(int fd, size_t total_size)
 	kvm_munmap(mem, total_size);
 }
 
-static sigjmp_buf jmpbuf;
-void fault_sigbus_handler(int signum)
-{
-	siglongjmp(jmpbuf, 1);
-}
-
 static void test_fault_overflow(int fd, size_t total_size)
 {
-	struct sigaction sa_old, sa_new = {
-		.sa_handler = fault_sigbus_handler,
-	};
 	size_t map_size = total_size * 4;
 	const char val = 0xaa;
 	char *mem;
@@ -95,12 +84,7 @@ static void test_fault_overflow(int fd, size_t total_size)
 
 	mem = kvm_mmap(map_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd);
 
-	sigaction(SIGBUS, &sa_new, &sa_old);
-	if (sigsetjmp(jmpbuf, 1) == 0) {
-		memset(mem, 0xaa, map_size);
-		TEST_ASSERT(false, "memset() should have triggered SIGBUS.");
-	}
-	sigaction(SIGBUS, &sa_old, NULL);
+	TEST_EXPECT_SIGBUS(memset(mem, val, map_size));
 
 	for (i = 0; i < total_size; i++)
 		TEST_ASSERT_EQ(READ_ONCE(mem[i]), val);
diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
index c6ef895fbd9a..b4872ba8ed12 100644
--- a/tools/testing/selftests/kvm/include/test_util.h
+++ b/tools/testing/selftests/kvm/include/test_util.h
@@ -8,6 +8,8 @@
 #ifndef SELFTEST_KVM_TEST_UTIL_H
 #define SELFTEST_KVM_TEST_UTIL_H
 
+#include <setjmp.h>
+#include <signal.h>
 #include <stdlib.h>
 #include <stdarg.h>
 #include <stdbool.h>
@@ -78,6 +80,23 @@ do {									\
 	__builtin_unreachable(); \
 } while (0)
 
+extern sigjmp_buf expect_sigbus_jmpbuf;
+void expect_sigbus_handler(int signum);
+
+#define TEST_EXPECT_SIGBUS(action)						\
+do {										\
+	struct sigaction sa_old, sa_new = {					\
+		.sa_handler = expect_sigbus_handler,				\
+	};									\
+										\
+	sigaction(SIGBUS, &sa_new, &sa_old);					\
+	if (sigsetjmp(expect_sigbus_jmpbuf, 1) == 0) {				\
+		action;								\
+		TEST_FAIL("'%s' should have triggered SIGBUS", #action);	\
+	}									\
+	sigaction(SIGBUS, &sa_old, NULL);					\
+} while (0)
+
 size_t parse_size(const char *size);
 
 int64_t timespec_to_ns(struct timespec ts);
diff --git a/tools/testing/selftests/kvm/lib/test_util.c b/tools/testing/selftests/kvm/lib/test_util.c
index 03eb99af9b8d..8a1848586a85 100644
--- a/tools/testing/selftests/kvm/lib/test_util.c
+++ b/tools/testing/selftests/kvm/lib/test_util.c
@@ -18,6 +18,13 @@
 
 #include "test_util.h"
 
+sigjmp_buf expect_sigbus_jmpbuf;
+
+void __attribute__((used)) expect_sigbus_handler(int signum)
+{
+	siglongjmp(expect_sigbus_jmpbuf, 1);
+}
+
 /*
  * Random number generator that is usable from guest code. This is the
  * Park-Miller LCG using standard constants.
-- 
2.51.0.618.g983fd99d29-goog


