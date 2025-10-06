Return-Path: <linux-kernel+bounces-842926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A514CBBDFD4
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 14:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BEB5C4EBC05
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 12:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2FE27A907;
	Mon,  6 Oct 2025 12:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YR8Tpz9h";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ig7iECdV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C6C215767;
	Mon,  6 Oct 2025 12:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759752826; cv=none; b=mLqDJgDgKA4pBefVxPJpeRQ2nQZAlZEKFLCC7YN0+ePIAir4mLhr+A4fOsLjoUeVewqNCE/aH6oN987+wp7ATtDYq5001Vob8DR6haNap0cmUdmvhtgVBs3KlFUmnlBLmOU57bf2nhFUjmhhjBHqIrknBVYGuBBTWlqzUG1DqkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759752826; c=relaxed/simple;
	bh=LDR9a9ULhxlDIaBk/QjSVwAXh4VF0B9MnIO+B6ZQ05w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qUhw1MwCDo8V7J3wH8mirFv8Bftw+2Ykpw8rZffXWjGCKAJLDDgGPMP/g4EP9f+T2z5k2yyXXqKU6hFrojlPK4PT/S4Uq2o+UTqAeBU0TN8mH2FqzFJxVZMNUWa+nTHYDCj0FOE1hIRvdXbipczba57fNYHVjHkboKWDw2g0PYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YR8Tpz9h; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ig7iECdV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1759752823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+1qM9XnyhGcWy5bQsWfGBfC1Y2+qK2VH0b2MgdrgnRw=;
	b=YR8Tpz9hgOJ34cKs6Z9+znJQtZwrkO61LG2NrqLgeBmpkOfo0+IntSXTrGHc5c+Edng6gV
	kzPgGhOiSN67Gwn45g2vMn2u98mf7AVZkYuh0ivm7IsIACtlRj72uS2EnPGuEaZlP31zuE
	4PoDtjiLWj521FCK64yMahrh3/eb+01PdKdaOTVthpiRCp1/NdDRwv7hkHmafc8rlx20kT
	phdK9SRTOa+HlpDhISksr5OYfNaQUaw0VzPuQU+KGBpmGZqqy/ja7csE2Brj1OUzf8ckV5
	S9KcWIH5MWl+yNjqs/u26/9d1g4H2GqFL62pqwvo6H0qQ4xhyu/o1sg1t2M8gQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1759752823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+1qM9XnyhGcWy5bQsWfGBfC1Y2+qK2VH0b2MgdrgnRw=;
	b=ig7iECdV+lH4vMNwl2GxMdwQmv6FTt+DtbgMoeAUx+jJHV7thnOKVWk9N88QPQA3frOujE
	Zk3GWUkABUqpWpCQ==
Date: Mon, 06 Oct 2025 14:13:37 +0200
Subject: [PATCH] csky: abiv2: Adapt to new folio flags field
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251006-csky-folio-flags-v1-1-a91dcbdbf988@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAHCy42gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDAwMz3eTi7ErdtPyczHzdtJzE9GJdQ2NzM0sDi8TkpNREJaC2gqLUtMw
 KsJHRsbW1AHw19zpiAAAA
X-Change-ID: 20251006-csky-folio-flags-1376908acbea
To: Guo Ren <guoren@kernel.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Zi Yan <ziy@nvidia.com>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-csky@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759752822; l=1201;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=LDR9a9ULhxlDIaBk/QjSVwAXh4VF0B9MnIO+B6ZQ05w=;
 b=Qd7y8pyrjQEnMng7CrIHb2m4Dhbe4/r+UMf6cDcodKICTs0DSRvZyUbm3k9Q6Bw1qBwbBDD+3
 HDjCo3dujasB6YDRgyo6IiXz7vCpgMI46f6hbzR1WFl99FQ6uytUxq7
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Recent changes require the raw folio flags to be accessed via ".f".
The merge commit introducing this change adapted most architecture code
but forgot the csky abiv2.

Fixes: 53fbef56e07d ("mm: introduce memdesc_flags_t")
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/csky/abiv2/inc/abi/cacheflush.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/csky/abiv2/inc/abi/cacheflush.h b/arch/csky/abiv2/inc/abi/cacheflush.h
index 6513ac5d257888fbd41385c9263305dfefd18de6..da51a0f02391f7d391ce26a2b11ca82b8c0b6755 100644
--- a/arch/csky/abiv2/inc/abi/cacheflush.h
+++ b/arch/csky/abiv2/inc/abi/cacheflush.h
@@ -20,8 +20,8 @@
 
 static inline void flush_dcache_folio(struct folio *folio)
 {
-	if (test_bit(PG_dcache_clean, &folio->flags))
-		clear_bit(PG_dcache_clean, &folio->flags);
+	if (test_bit(PG_dcache_clean, &folio->flags.f))
+		clear_bit(PG_dcache_clean, &folio->flags.f);
 }
 #define flush_dcache_folio flush_dcache_folio
 

---
base-commit: fd94619c43360eb44d28bd3ef326a4f85c600a07
change-id: 20251006-csky-folio-flags-1376908acbea

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


