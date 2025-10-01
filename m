Return-Path: <linux-kernel+bounces-839564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18001BB1E8B
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 00:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD04319C2F69
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 22:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10654265629;
	Wed,  1 Oct 2025 22:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="ZeGIVa28"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FFB145355
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 22:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759356298; cv=none; b=oLpHVQ7/Zl8KnVLwq6D94HGV2JlJqHi6HmADkscGRwwixTj1P4foav19N+Pv8AWUkc9G4QFznorXpYoijxQvZAi8Q5932fup5td8WIDzlj0z7WaSgc5Pe21iKBzBjbqL3VC0tzs2qr7DqFZq8MdorsVN/JIuPCzsankA9miMNAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759356298; c=relaxed/simple;
	bh=WFu+wNWp1EpN0yrDzhgDWphjzXcwxlpQS6MfeQAMzGI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FNcqn9qCNxrjEAvMtx3nkFybqLWXexEFAFmS3UDTWmjHiY9v5las+nxhweVC+v4WkhV3txyKspbuToqHHA8odCaPz2jfduWMpGZT+rpU5U7yE9eNw7n5wnv/Clnzqlx7inUDH5rKaxfBdyYBg/HaQgYguP3VwbE/WFNEQAx22m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=ZeGIVa28; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=TRQ/6bp34zikwsreCtPq521inyOtmtUcBctZkIXu1BM=; b=ZeGIVa28A4ztYqhzwzdnFrd+7o
	SS8tskvNktZSTKLVuvboVZ9NCTo4829a3jU1NneVkFAry3m3T16cdGdyJH40srPxqQhAknesSE5hn
	bmEdB8BMC8Wm3lx95soneS9larF5HdVr59ZIxOHFA8gJlmpE/9ocgBBg7zA/8jFy8njMK8NIMjPwR
	RzVk9/B5mPq2fuCMIt/hnkpkiYxdqpq2SkjzHI4FpwZysBo0lCSGkH7NBZaIqRERZA4fU8C+tcBQJ
	sH/9GaG57WbLFiuvphoUu6puU7yq7qBi7EOv7UyLclg+mySlDduoB1VOjIzRLNKJFw5JEPjBVOBjh
	h0Fl4EbQ==;
Received: from 201-69-111-7.dial-up.telesp.net.br ([201.69.111.7] helo=steammachine)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1v44wK-0033Yw-Hl; Thu, 02 Oct 2025 00:04:48 +0200
From: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	kernel-dev@igalia.com,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH RESEND] selftest/futex: Remove unused test_futex_mpol()
Date: Wed,  1 Oct 2025 19:04:38 -0300
Message-ID: <20251001220438.66227-1-andrealmeid@igalia.com>
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


