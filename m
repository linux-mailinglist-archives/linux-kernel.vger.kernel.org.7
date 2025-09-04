Return-Path: <linux-kernel+bounces-801324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FEA1B443B0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 18:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29977168098
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 16:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34892FD7CE;
	Thu,  4 Sep 2025 16:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="qzubvsDI"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2ED11C861D
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 16:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757004974; cv=none; b=s038SvQuys3EEOFuOSNCqHcCH4zfpLaeAq5i+ueBkDYkKWbi6ycRyY4YiwL3WfJutI6NFOFRXXKVGbNprfqd+okRagi0XDALrmT6pFMUSwpbpX//QXhbOTyJx6ehX1GA/aBH5iBGsv0M3yGdbw5FJiteOeKp/+lVLpovCEX4mSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757004974; c=relaxed/simple;
	bh=4Nl6HnEFlPiRyRlJLV9G+4wgjGP/E6qeShnB5uaOnig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HQcVFAwJzqrSPxhdbUCEjTjun3kcvZ0hFxi+/VO4aGIs2uI1DYlZ5vFLvkl3v1oidQTtr5GJ/Oy3S4vd1apqxfyWz+mSIOLQwhrzbq+BqzAX/pfoGgmjcNOvLU3kMtr9etfWIY5/GJ1XlagMPA6jshvTKow2RYY2bAe592r/J08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=qzubvsDI; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=xMKZAVxpaavV28QPa5/U4mmzAiHNoP6/JZaf9T+JdL0=; b=qzubvsDI2k/H6fwSt34qccpSg9
	1/LMfStcL49tNwYB8xAB6+3GQ6qHxB951nNYyqA7eofwUcDmqAuYZc4VxHvgEE8zRoKUhb/Q6Acl+
	2FxXg6sCHbxxp4JNToo/hdTe/LvMW8kcS0/YTPX9/lnaa8dwM/8tRk6pTAc9aEfHoR3dayO9Xl/tG
	xB8DTDs/9NDHoVz7HkZ59xPUIX0y1kM4+sSvbOXiTeikb4YonGeDFfYuprDz9U/rdIn1lZjIlShXS
	xkKrlWaasn4sZPKZu4HoXP0mSMj/p6QGSE+kz4COEU6novGaXrrREDEllHxsGZu/q5ptaoE5HGjUQ
	9GpcC/Tw==;
Received: from [177.139.20.31] (helo=steammachine)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uuDFo-006u4U-6R; Thu, 04 Sep 2025 18:56:08 +0200
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
Subject: [PATCH v2 2/2] selftest/futex: Reintroduce "Memory out of range" numa_mpol's subtest
Date: Thu,  4 Sep 2025 13:55:56 -0300
Message-ID: <20250904165556.56926-2-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250904165556.56926-1-andrealmeid@igalia.com>
References: <20250904165556.56926-1-andrealmeid@igalia.com>
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

Reviewed-by: Waiman Long <longman@redhat.com>
Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
Changes from v1:
- Use error code mnemonics instead of numberic values
---
 .../testing/selftests/futex/functional/futex_numa_mpol.c  | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/futex/functional/futex_numa_mpol.c b/tools/testing/selftests/futex/functional/futex_numa_mpol.c
index dd7b05e8cda4..5f4e3111269c 100644
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
 	test_futex(futex_ptr + mem_size - 4, EINVAL);
 
+	ksft_print_msg("Memory out of range\n");
+	test_futex(futex_ptr + mem_size, EFAULT);
+
 	futex_numa->numa = FUTEX_NO_NODE;
 	mprotect(futex_ptr, mem_size, PROT_READ);
 	ksft_print_msg("Memory, RO\n");
-- 
2.51.0


