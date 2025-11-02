Return-Path: <linux-kernel+bounces-881743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0E5C28D87
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 11:46:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6E863B3BC2
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 10:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 927D5155C97;
	Sun,  2 Nov 2025 10:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b="dvYtWrnO"
Received: from mta1.formilux.org (mta1.formilux.org [51.159.59.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F5B78F29
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 10:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.59.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762080384; cv=none; b=ESfVPluCzQ3yfArVAWR1GlbepJGF+dmfW8/7xLvEUh4urH2RvAMy72tu+DPO5/fuST7lrOTlzZkNhGSaA8QRvdiFE8Yq8rVlqQMuD58794W5dgun29MfPoJmwOlzjzAB5qu1lBsV77lpdf2rrb7ZoL7brLYknUcLQ8gTWu4UELI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762080384; c=relaxed/simple;
	bh=n4kw0H2lpqCBtXvMPq7iMlv6W98+HxLSni4vqvlLjhA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=GjPqA/5AlLHUkNCruQ9YJof29A/ru1qKrfRYfr2YpHUpWc7Ag08WVVZBgmOEfRJRttohT5KZSspBDY1rK3vDTSWHQsbSUepD/J0H3VAJu4V8rtKDYOuO522TpdhobF+l82hjSQ5B/pyYnS5TXaPzTBHwDO6AShke2BLpH7AoOqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; dkim=pass (1024-bit key) header.d=1wt.eu header.i=@1wt.eu header.b=dvYtWrnO; arc=none smtp.client-ip=51.159.59.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1wt.eu; s=mail;
	t=1762080380; bh=Xr+7y5VPjzaBTsRc1pcafOBiI+MDr/5lAa5dclNG6/s=;
	h=From:Message-Id:From;
	b=dvYtWrnOqVnFRm71v9N2v3HIu1xhIVkx0Y7qLYqAsPSKbyBNt1ejF1thM8EQn5AF/
	 OnwqwxEuPc+GP80j4HCAEvFSoqCQgJvZiEtmsBEifM1ZHNKo1SuToSqPDc/1/tA+Mk
	 vtU3UMRRb/85hpjWmrDlyytm3A7FIvp2LFLmaDGQ=
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by mta1.formilux.org (Postfix) with ESMTP id F2A12C0952;
	Sun, 02 Nov 2025 11:46:19 +0100 (CET)
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 5A2AkJot024503;
	Sun, 2 Nov 2025 11:46:19 +0100
From: Willy Tarreau <w@1wt.eu>
To: linux@weissschuh.net
Cc: shuah@kernel.org, linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH v2 3/4] tools/nolibc: add missing memchr() to string.h
Date: Sun,  2 Nov 2025 11:46:10 +0100
Message-Id: <20251102104611.24454-4-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
In-Reply-To: <20251102104611.24454-1-w@1wt.eu>
References: <20251102104611.24454-1-w@1wt.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Surprisingly we forgot to add this common one. It was added with a
per-arch guard allowing to later implement it in arch-specific asm
code like was done for a few other ones.

The test verifies that we don't search past the indicated length.

Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/string.h                | 15 +++++++++++++++
 tools/testing/selftests/nolibc/nolibc-test.c |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/tools/include/nolibc/string.h b/tools/include/nolibc/string.h
index 163a17e7dd38..4000926f44ac 100644
--- a/tools/include/nolibc/string.h
+++ b/tools/include/nolibc/string.h
@@ -93,6 +93,21 @@ void *memset(void *dst, int b, size_t len)
 }
 #endif /* #ifndef NOLIBC_ARCH_HAS_MEMSET */
 
+#ifndef NOLIBC_ARCH_HAS_MEMCHR
+static __attribute__((unused))
+void *memchr(const void *s, int c, size_t len)
+{
+	char *p = (char *)s;
+
+	while (len--) {
+		if (*p == (char)c)
+			return p;
+		p++;
+	}
+	return NULL;
+}
+#endif /* #ifndef NOLIBC_ARCH_HAS_MEMCHR */
+
 static __attribute__((unused))
 char *strchr(const char *s, int c)
 {
diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 2b1fcfaaa60e..7fc937e9a4df 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -1558,6 +1558,8 @@ int run_stdlib(int min, int max)
 		CASE_TEST(abs_noop);                EXPECT_EQ(1, abs(10), 10); break;
 		CASE_TEST(difftime);                EXPECT_ZR(1, test_difftime()); break;
 		CASE_TEST(test_timespec);           EXPECT_ZR(1, test_timespec()); break;
+		CASE_TEST(memchr_foobar6_o);        EXPECT_STREQ(1, memchr("foobar", 'o', 6), "oobar"); break;
+		CASE_TEST(memchr_foobar3_b);        EXPECT_STRZR(1, memchr("foobar", 'b', 3)); break;
 
 		case __LINE__:
 			return ret; /* must be last */
-- 
2.17.5


