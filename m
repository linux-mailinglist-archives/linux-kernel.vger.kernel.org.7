Return-Path: <linux-kernel+bounces-827549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73754B920E5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 17:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CABFB3B2BED
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73C127F010;
	Mon, 22 Sep 2025 15:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="I63e6fwB"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664102E0B71
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 15:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758556243; cv=none; b=Gj1Obhr1ydAGUgnRecQ8mNOB4ez/vgkKBVM/w72N8IEc8rFP/vy+OV/yR6REJq8jg2fLfzD9wsR+ToxjEF6PaZUySTosJXio6Fc+m42okKLMHx8p50viVgsWbUpqDAYxBNCv6CFibdAIaoxv/E7vFWqT9YOevcmT+KjBj9VUctE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758556243; c=relaxed/simple;
	bh=jw+2aYwn20giNoREYGN4iibx4w7T6quEiuXyjUvpKcw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pixk234MkIavUqXncqFJEfyMBXpBjLBQKiMZlFKQGnRWas9km1y5sTgBIC5dg8mBAYMofS52O2xhOHW/tDWYwO+3bs3on4EMhNY7pIdkJ/H5FpiKAZW+usVcTxMYqtwGHN6fBAxfmi/oY1wb5m+Z+I4pzX/33IzL9vDL7eZ0sEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=I63e6fwB; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=5IWgs0XKh+w2JNRbMc6dp45o91tr27qgeKnaJnRCIUM=; b=I63e6fwBDMz3IbdB/WCwYShfhs
	sEthOB9yIXlJpyum1GTw7y9fKOvYu06nh4P+xuXleJrUUmsNk9btQNrLR3R5CSbBICZfX73EzBpJ5
	F0+bxAnxxRypkAHgHbTrq2nFRGWbPDIzUe7ot1UiqFYE7wV6uam0IUZ984VjzqfvrpdQLLv3A6WYw
	5wyXPJhDd7rWh0BDMEnkGEXI262/CIpWt6qUyLP6Pk37cO/zc5rCtpu5rkkZlMhWfuJwItGx76riy
	vRRoCpJM/9cGmr9xYLETrjnRnqJb5z4qwoe/EjqWF4KTEfh+x5K2hqSsa36ioelyY1TuFaGT5oOP8
	TqmNTC8A==;
Received: from 201-69-111-249.dial-up.telesp.net.br ([201.69.111.249] helo=steammachine)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1v0ioG-00FoFq-8L; Mon, 22 Sep 2025 17:50:36 +0200
From: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org
Cc: Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	kernel-dev@igalia.com,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH] selftest/futex: Remove unused test_futex_mpol()
Date: Mon, 22 Sep 2025 12:50:28 -0300
Message-ID: <20250922155028.21181-1-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.51.0
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
Hi Thomas,

I added this function back by accident when rebasing in the Sebastian
patch. Fell free to fixup the original commit if you prefer to. Sorry
about the noise.
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
2.51.0


