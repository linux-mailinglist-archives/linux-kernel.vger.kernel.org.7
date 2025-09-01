Return-Path: <linux-kernel+bounces-795309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 467D5B3EFBA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 22:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DEDD1B211DD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 20:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC9F26562D;
	Mon,  1 Sep 2025 20:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="lRhvhPcQ"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFA2212545
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 20:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756758832; cv=none; b=kqIaoUPRe6uCgKKQ9KkLgYdlT+pXVLMN/JjG8GN9cNnvjnX2sk6eGdWhPhDK/YDdCWXxsXorobYzNDR+JFsyiDsAvd77aiN6beZkTOsE6jctIyksdwaH/RWZ3dAYTCdoRVBINfjK9rnRw5H3G01OhtAEhbLyVKEc6NyWhsB8uqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756758832; c=relaxed/simple;
	bh=Phlfxeds9jteAg8NpdJVSfF6KkdG4nLGi2ESSLHS1to=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E8UBxY1kggEZWv11fkeovnM9El5BNFAx/yuZlHHOlzofl0rxVBjWllztkCeDTu6UotUxey9xQ5lOvEgOePg9HtHnTnp3kM6hHtS3YDiyXGcwWLyGKKS8/qQjvVVaRvoHU/TMa0F39ndB5iZYuCW9jBjGWBxq2rXl0f+jZeOJ53A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=lRhvhPcQ; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Ha1ZIxMm0P7ZWTMQeA2q5fJSTCh3TlBQiNShrH/P17g=; b=lRhvhPcQwjCTYfkCKvS1pfn098
	m6Y4IiAxRuaHuhU8UxJ/jLZt2bIWfNnN/dBbYg+jStZWyu/IjkDiSWfJ1CHLhWtbXSwpaSMbWobHr
	DKfzQHAm48tP2u/ytA7JQrZ5fdwQkmcy2Et4kdYpPOz7mNSEgnv+qICDTg4A/7jiy5Jqq6n72PHyp
	8G4aJvEr9Ka3BY/X6GBEhIHX1t/Kxas/ynKDNvdzv7iKQsEHTHmoIl4FF557P9VBsC+w0yIIOBVK0
	fAjuEfZyCxD8ypnMLjVBdWgOuR6wtUn8G74icaty+VqhEnQehgQMVV6lxAxFwMpXg++U6SUWIwSsS
	P9J/vS3w==;
Received: from [177.139.20.31] (helo=steammachine)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1utBDn-005Qdu-Dv; Mon, 01 Sep 2025 22:33:47 +0200
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
Subject: [PATCH 2/2] selftest/futex: Reintroduce "Memory out of range" numa_mpol's subtest
Date: Mon,  1 Sep 2025 17:33:27 -0300
Message-ID: <20250901203327.53887-2-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250901203327.53887-1-andrealmeid@igalia.com>
References: <20250901203327.53887-1-andrealmeid@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Commit d8e2f919997 ("selftests/futex: Fix some futex_numa_mpol
subtests") removed the "Memory out of range" subtest due to it being
dependent on the memory layout of the test process having an invalid
memory address just after the `*futex_ptr` allocated memory.

Reintroduce this test and make it deterministic, by allocation two
memory pages and marking the second one with PROT_NONE.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
This patch is aimed for 6.18
---
 .../testing/selftests/futex/functional/futex_numa_mpol.c  | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/futex/functional/futex_numa_mpol.c b/tools/testing/selftests/futex/functional/futex_numa_mpol.c
index c84441751235..e4b840184b1d 100644
--- a/tools/testing/selftests/futex/functional/futex_numa_mpol.c
+++ b/tools/testing/selftests/futex/functional/futex_numa_mpol.c
@@ -174,10 +174,13 @@ int main(int argc, char *argv[])
 	ksft_set_plan(1);
 
 	mem_size = sysconf(_SC_PAGE_SIZE);
-	futex_ptr = mmap(NULL, mem_size, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
+	futex_ptr = mmap(NULL, mem_size * 2, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
 	if (futex_ptr == MAP_FAILED)
 		ksft_exit_fail_msg("mmap() for %d bytes failed\n", mem_size);
 
+	/* Create an invalid memory region for the "Memory out of range" test */
+	mprotect(futex_ptr + mem_size, mem_size, PROT_NONE);
+
 	futex_numa = futex_ptr;
 
 	ksft_print_msg("Regular test\n");
@@ -192,6 +195,9 @@ int main(int argc, char *argv[])
 	ksft_print_msg("Mis-aligned futex\n");
 	test_futex(futex_ptr + mem_size - 4, 22);
 
+	ksft_print_msg("Memory out of range\n");
+	test_futex(futex_ptr + mem_size, 14);
+
 	futex_numa->numa = FUTEX_NO_NODE;
 	mprotect(futex_ptr, mem_size, PROT_READ);
 	ksft_print_msg("Memory, RO\n");
-- 
2.51.0


