Return-Path: <linux-kernel+bounces-788588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88DFAB386DF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 17:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 468AD680BE2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 15:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4CF32D24B7;
	Wed, 27 Aug 2025 15:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="I13VXSyI"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E831EDA1B
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 15:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756309483; cv=none; b=cMJnlaUeXvSKA2mFHtPbVhqsktnl3s0GqGX43ZR1S8pDTaRmWcMdhSJAsqxeRgQbHstw4ryJrxj06Px0aZf5RPOw3ruOv7GYL24eNKNgOYvbTKGqNPgiGsSxT0ZZ3oT9ut1KK6IzZ5gAHV3mfL/+fDvVDpxVMHtysp5gXKR/bh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756309483; c=relaxed/simple;
	bh=rOeeqnagp/kimBo7niDZKaNkGgfAol231nv+Qe0ju68=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gwxqVXu8IHwylE1RbVMYNSj4zAqWH5vfMnJ3Qmt6TVx/bB48vLo0n2MxcprMauES5qk2jIgfizoJYtfhs3C/y6xDH6Hahfk9kVWSgmtOP/rntF7dOSFI/Rz58ZT09CzAoN5AW7l0QEr6MZFh4CcWgJbEiPnzc9/hb9BCf2mqstM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=I13VXSyI; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Nx0NfdZIXd3w2ztZfHLlGP0CZq+OgC0+TPI1KTMVEjo=; b=I13VXSyIbKJYLdfN+wGQEy8/nx
	L+AQuUQTdDduTAl7KATddG8t40cktKPpdoMNiX5mLIcmU19L/8QBSJH8WloneHPzP66SehT339IkR
	T5aAn3mEIzypvvw9Dl2YJIdkjNr9ihr3dJdpBTMUWVRdCe6v/xS/mXVTloYyF0ACYW03jGV5O2kka
	JHsCNw12+oDAMJwdUHtmXHOTATD2HL+wGD5VC2VJhdlRviSIkUBlU00ZsX7Foryz87ykY1cYCyUhv
	nkuvf5lRj5zeNzZQm7qG8vAwXUUJOPLFIWVPyxJK+6vu7ZE4drkRWPppGn6u5gzGWxsCvstTC4EC8
	KAsX/DuA==;
Received: from [187.57.78.222] (helo=steammachine)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1urIKD-002VQb-E5; Wed, 27 Aug 2025 17:44:37 +0200
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
Subject: [PATCH] selftests/futex: Fix futex_numa_mpol's memory out of range subtest
Date: Wed, 27 Aug 2025 12:44:20 -0300
Message-ID: <20250827154420.1292208-1-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The "Memory out of range" subtest works by pointing the futex pointer
to the memory exactly after the allocated map (futex_ptr + mem_size).
This address is out of the allocated range for futex_ptr, but depending
on the memory layout, it might be pointing to a valid memory address of
the process. In order to make this test deterministic, create a "buffer
zone" with PROT_NONE just before allocating the valid futex_ptr memory,
to make sure that futex_ptr + mem_size falls into a memory address that
will return an invalid access error.

Fixes: 3163369407ba ("selftests/futex: Add futex_numa_mpol")
Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
This patch comes from this series:
https://lore.kernel.org/lkml/20250704-tonyk-robust_test_cleanup-v1-13-c0ff4f24c4e1@igalia.com/
---
 .../futex/functional/futex_numa_mpol.c          | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/futex/functional/futex_numa_mpol.c b/tools/testing/selftests/futex/functional/futex_numa_mpol.c
index a9ecfb2d3932..1eb3e67d999b 100644
--- a/tools/testing/selftests/futex/functional/futex_numa_mpol.c
+++ b/tools/testing/selftests/futex/functional/futex_numa_mpol.c
@@ -143,7 +143,7 @@ int main(int argc, char *argv[])
 {
 	struct futex32_numa *futex_numa;
 	int mem_size, i;
-	void *futex_ptr;
+	void *futex_ptr, *buffer_zone;
 	int c;
 
 	while ((c = getopt(argc, argv, "chv:")) != -1) {
@@ -168,6 +168,17 @@ int main(int argc, char *argv[])
 	ksft_set_plan(1);
 
 	mem_size = sysconf(_SC_PAGE_SIZE);
+
+	/*
+	 * The "Memory out of range" test depends on having a pointer to an
+	 * invalid address. To make this test deterministic, and to not depend
+	 * on the memory layout of the process, create a "buffer zone" with
+	 * PROT_NONE just before the valid memory (*futex_ptr).
+	 */
+	buffer_zone = mmap(NULL, mem_size, PROT_NONE, MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
+	if (buffer_zone == MAP_FAILED)
+		ksft_exit_fail_msg("mmap() for %d bytes failed\n", mem_size);
+
 	futex_ptr = mmap(NULL, mem_size, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
 	if (futex_ptr == MAP_FAILED)
 		ksft_exit_fail_msg("mmap() for %d bytes failed\n", mem_size);
@@ -229,6 +240,10 @@ int main(int argc, char *argv[])
 			}
 		}
 	}
+
+	munmap(buffer_zone, mem_size);
+	munmap(futex_ptr, mem_size);
+
 	ksft_test_result_pass("NUMA MPOL tests passed\n");
 	ksft_finished();
 	return 0;
-- 
2.50.1


