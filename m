Return-Path: <linux-kernel+bounces-894266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B20BC499AD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 23:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B13C1188FF94
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 22:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B23303CAF;
	Mon, 10 Nov 2025 22:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="JW0hyjz2"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7E12FF662
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 22:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762814057; cv=none; b=VWk/e6w7Vl/Qh68f5g08jOm6TV0p8+aHAkWYNFEZHpVxQLXtxvUfyr4c0XJyziA5QejBpLQLpbIbapmxsyt1owIgA0uyLKM7adYOI07ako3KPWU5hDJlt84e/1WnNNHiesR9sGu5V+AyDJFpCOekrvaxF3LuyZW5QhJt2sO0Yio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762814057; c=relaxed/simple;
	bh=14I4aIB16T4KIUUaXCUSBKTkjgQop1n1+uPHybAKDs4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uEVn0y5aqzvBjMssKIkHMAocbJfT1CLQeeyHQgyCgYwfQ8nac4YOchdrqy0ktaSSdoD9+i61BsQeGSH6uZb1ToO7pSzpriFM2eOiBbrMzTjPOZjrb8QmWWWIr/z5iXZtHOPYoddWzretVYHl51dos1r5JMpDnvYkd1FDDQPyM/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=JW0hyjz2; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=psAp5czOwh/Ef/TdT+9EexRrIQ/N3LKUf4Z9tXpStxc=; b=JW0hyjz2KJGj9PwByCL/n95DT1
	QLPY2I+e4D80osbhTXUFtSA12DKPS1QLOzwOQRjTErWRCJYOVtRul4pes2KR/1nwWOPtQ+b2PHsid
	KUN6112dEf7fgGW//CvhgfkC3n2YYziK8whT1pfL/C2vkz9J1KQsi3ovUOJiZnX4fdQ0C7i2xyoXH
	ic9+G1Z11IUM2QygcFSUpgccD7Jy7dIOtrjbgK4ANYpXsVGcs74n8ddErthxQ9AVoeW7xYYLb6UEO
	qwpjmCmW3qkDGmeRElkQQoehIGTsTDjG3s/53w20K5MP5jSXd4otR4hTLCmh0WVLoK9sHURJBCAjd
	PBtgU+dw==;
Received: from [191.8.29.151] (helo=steammachine)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vIaSf-004meA-Qg; Mon, 10 Nov 2025 23:34:10 +0100
From: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To: linux-kernel@vger.kernel.org
Cc: Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	kernel-dev@igalia.com,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH RESEND] selftest/futex: Remove unused test_futex_mpol()
Date: Mon, 10 Nov 2025 19:34:04 -0300
Message-ID: <20251110223404.3037317-1-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Commit ed323aeda5e09 ("selftest/futex: Compile also with libnuma <
2.0.16") removed the unused function test_futex_mpol() and commit
d35ca2f64272 ("selftests/futex: Refactor futex_numa_mpol with
kselftest_harness.h") added it back by accident. Remove it again.

Fixes: d35ca2f64272 ("selftests/futex: Refactor futex_numa_mpol with kselftest_harness.h")
Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 tools/testing/selftests/futex/functional/futex_numa_mpol.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_numa_mpol.c b/tools/testing/selftests/futex/functional/futex_numa_mpol.c
index d037a3f10ee8..969c73c4b33b 100644
--- a/tools/testing/selftests/futex/functional/futex_numa_mpol.c
+++ b/tools/testing/selftests/futex/functional/futex_numa_mpol.c
@@ -131,11 +131,6 @@ static void test_futex(void *futex_ptr, int err_value)
 	__test_futex(futex_ptr, err_value, FUTEX2_SIZE_U32 | FUTEX_PRIVATE_FLAG | FUTEX2_NUMA);
 }
 
-static void test_futex_mpol(void *futex_ptr, int err_value)
-{
-	__test_futex(futex_ptr, err_value, FUTEX2_SIZE_U32 | FUTEX_PRIVATE_FLAG | FUTEX2_NUMA | FUTEX2_MPOL);
-}
-
 TEST(futex_numa_mpol)
 {
 	struct futex32_numa *futex_numa;
-- 
2.51.2


