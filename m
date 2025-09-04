Return-Path: <linux-kernel+bounces-801323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B71B443AF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 18:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27C4F1C864DD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 16:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BB72D46AF;
	Thu,  4 Sep 2025 16:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="WxfIbJ7j"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FF8161302
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 16:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757004971; cv=none; b=BJRpuRpr+OjNqGOZV6KoeqtWDcrRNtqyos4xjvW9qRjZi+UC/aex3hFdbCNwf/u4eulQ/S1GDTuEYEJoSBBqe7Tg7Dy35bl8OdytbYIl4xi/Uk1QTST52b93s4kPgupIXyGytVinOb8vig6xtgaBOKVYjPnc+gBVZu6r+l4s+IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757004971; c=relaxed/simple;
	bh=aoD+MBjrKIgdT2AWKdWTOG5JIdsk/xEsHD5kYrPKeBI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eyTwZRTgWow7xhfZLmmQoaLu8pzql/4MZ6OiLSmoaifSW2AgIY9d+Y2amGC89UK9tTiuzzuH6WulKUZzv/1qh52LbamlhvsSqAcTEL/IIiyDg+/lqYz+QweiZZCU2wdrzXBDPA7x0tEQkDutbZrkTESFZW+He9Gm6ejyNW4xxXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=WxfIbJ7j; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=rk/COguMuYnRRQV0CB5TGt6IIZp501SRA26ssZTzS8k=; b=WxfIbJ7jdofP2yggf5XEwBHXj5
	008hB5KvUsLqaHw+nRj0Ae9ErCrkVO+TycMmcFvaudl1zYfny41YGkuJFo5VibJmUhgiPSK+qptsW
	SRKsRHsr5oLdG/0IXUGqR7td/w9hfOztoK3yCLl3ydWFENr+hpBBhgt86VEApfb+/neotbxxFsJdJ
	eJ2zLSTfOdqU6gtEE+850Kk3mZ5BL4HTcvC6ur7t8e6Eo2rcTj5OKvrIgYuh8nvM1R/p+HiEdaF4/
	k7n+YDs764nHjz86kmkEDIo9daqxN3+rXo0D/vWzP0Wfp4AsJopcGG1g1CzyH5AW/tQFtrTO19Ec+
	aSAdENAw==;
Received: from [177.139.20.31] (helo=steammachine)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uuDFk-006u4U-Vb; Thu, 04 Sep 2025 18:56:05 +0200
From: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org
Cc: Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Waiman Long <longman@redhat.com>,
	kernel-dev@igalia.com,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v2 1/2] selftest/futex: Make the error check more precise for futex_numa_mpol
Date: Thu,  4 Sep 2025 13:55:55 -0300
Message-ID: <20250904165556.56926-1-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Instead of just checking if the syscall failed as expected, check as
well what is the error code returned, to check if it's match the
expectation and it's failing in the correct error path inside the
kernel.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
Changes from v1:
- Use error code mnemonics instead of numberic values
---
 .../futex/functional/futex_numa_mpol.c        | 36 +++++++++++--------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_numa_mpol.c b/tools/testing/selftests/futex/functional/futex_numa_mpol.c
index 802c15c82190..dd7b05e8cda4 100644
--- a/tools/testing/selftests/futex/functional/futex_numa_mpol.c
+++ b/tools/testing/selftests/futex/functional/futex_numa_mpol.c
@@ -77,7 +77,7 @@ static void join_max_threads(void)
 	}
 }
 
-static void __test_futex(void *futex_ptr, int must_fail, unsigned int futex_flags)
+static void __test_futex(void *futex_ptr, int err_value, unsigned int futex_flags)
 {
 	int to_wake, ret, i, need_exit = 0;
 
@@ -88,11 +88,17 @@ static void __test_futex(void *futex_ptr, int must_fail, unsigned int futex_flag
 
 	do {
 		ret = futex2_wake(futex_ptr, to_wake, futex_flags);
-		if (must_fail) {
-			if (ret < 0)
-				break;
-			ksft_exit_fail_msg("futex2_wake(%d, 0x%x) should fail, but didn't\n",
-					   to_wake, futex_flags);
+
+		if (err_value) {
+			if (ret >= 0)
+				ksft_exit_fail_msg("futex2_wake(%d, 0x%x) should fail, but didn't\n",
+						   to_wake, futex_flags);
+
+			if (errno != err_value)
+				ksft_exit_fail_msg("futex2_wake(%d, 0x%x) expected error was %d, but returned %d (%s)\n",
+						   to_wake, futex_flags, err_value, errno, strerror(errno));
+
+			break;
 		}
 		if (ret < 0) {
 			ksft_exit_fail_msg("Failed futex2_wake(%d, 0x%x): %m\n",
@@ -106,12 +112,12 @@ static void __test_futex(void *futex_ptr, int must_fail, unsigned int futex_flag
 	join_max_threads();
 
 	for (i = 0; i < MAX_THREADS; i++) {
-		if (must_fail && thread_args[i].result != -1) {
+		if (err_value && thread_args[i].result != -1) {
 			ksft_print_msg("Thread %d should fail but succeeded (%d)\n",
 				       i, thread_args[i].result);
 			need_exit = 1;
 		}
-		if (!must_fail && thread_args[i].result != 0) {
+		if (!err_value && thread_args[i].result != 0) {
 			ksft_print_msg("Thread %d failed (%d)\n", i, thread_args[i].result);
 			need_exit = 1;
 		}
@@ -120,14 +126,14 @@ static void __test_futex(void *futex_ptr, int must_fail, unsigned int futex_flag
 		ksft_exit_fail_msg("Aborting due to earlier errors.\n");
 }
 
-static void test_futex(void *futex_ptr, int must_fail)
+static void test_futex(void *futex_ptr, int err_value)
 {
-	__test_futex(futex_ptr, must_fail, FUTEX2_SIZE_U32 | FUTEX_PRIVATE_FLAG | FUTEX2_NUMA);
+	__test_futex(futex_ptr, err_value, FUTEX2_SIZE_U32 | FUTEX_PRIVATE_FLAG | FUTEX2_NUMA);
 }
 
-static void test_futex_mpol(void *futex_ptr, int must_fail)
+static void test_futex_mpol(void *futex_ptr, int err_value)
 {
-	__test_futex(futex_ptr, must_fail, FUTEX2_SIZE_U32 | FUTEX_PRIVATE_FLAG | FUTEX2_NUMA | FUTEX2_MPOL);
+	__test_futex(futex_ptr, err_value, FUTEX2_SIZE_U32 | FUTEX_PRIVATE_FLAG | FUTEX2_NUMA | FUTEX2_MPOL);
 }
 
 static void usage(char *prog)
@@ -184,16 +190,16 @@ int main(int argc, char *argv[])
 
 	/* FUTEX2_NUMA futex must be 8-byte aligned */
 	ksft_print_msg("Mis-aligned futex\n");
-	test_futex(futex_ptr + mem_size - 4, 1);
+	test_futex(futex_ptr + mem_size - 4, EINVAL);
 
 	futex_numa->numa = FUTEX_NO_NODE;
 	mprotect(futex_ptr, mem_size, PROT_READ);
 	ksft_print_msg("Memory, RO\n");
-	test_futex(futex_ptr, 1);
+	test_futex(futex_ptr, EFAULT);
 
 	mprotect(futex_ptr, mem_size, PROT_NONE);
 	ksft_print_msg("Memory, no access\n");
-	test_futex(futex_ptr, 1);
+	test_futex(futex_ptr, EFAULT);
 
 	mprotect(futex_ptr, mem_size, PROT_READ | PROT_WRITE);
 	ksft_print_msg("Memory back to RW\n");
-- 
2.51.0


