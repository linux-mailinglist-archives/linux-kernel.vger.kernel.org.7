Return-Path: <linux-kernel+bounces-899568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC34C58662
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 16:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CDDF94F5CEE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 15:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA6E359F9D;
	Thu, 13 Nov 2025 15:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A/uLrQX+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE7D359F94
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 15:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763046199; cv=none; b=l3cf2Sax6bzkc15ECCqSw0JdLXcsEhRo8LVC5u12KYAol8YylnuGEUZhzq8uNGAL6BkIlyYZwZigEXYN7TE0xBxRem0btXKpazbNJNo6ZYU6uloyPgGerjs6SPnxU0JdWxQhS5N0g4nqr4fdRnQv+rj+rMPkE2siP3PD6zcM56Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763046199; c=relaxed/simple;
	bh=LV953JMEHqN47wzSNmPrstkaETB/phIMwX6sDRExyZU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WRm7DWbcAxZwY/6nCLTLk7yJC3G2cJxkhMgsHiZgxgnmAdIotUwJvkcd77Ufv9tdT8MdhjNvm2eAAHN+vA/8P5BRKlMWtM97T5xQsGVDbwlsGpm3J0yWxhV6tOqEuh/Ecpd8MVeG70QlSefABpXX3++xgFtS47ZZ5n1dvRy/MPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A/uLrQX+; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763046198; x=1794582198;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LV953JMEHqN47wzSNmPrstkaETB/phIMwX6sDRExyZU=;
  b=A/uLrQX+h8+yARE7teKGSAMQyRqHgreIzXksEpePCKKHkEcqSAVUK/0B
   3a3h2A9hRh5Cud5/mQ4jVzNNgkSvVzE/1wlGseZveTbHKl2QtHfjV/2Kz
   ujCEKeAmpm9vbNQsVZeqGhjecpItUyAeCtjPo94TWWkcbro7I4rEvV0xX
   zhSeJax9z5bqgeNIf/tXdO7+VX1zSQE3f/qLxi9PXI104ktFu4bs82JhH
   T0Vionk5DNvHXbnNfBBeD1nnscyl4L4zgpCXsWF6lubtjFFgk80eJwPII
   +Jse88DBlPdgz9iwEFiABERfZzcOuUpKvaa9Odsttywt05wRx4NAhuz5O
   g==;
X-CSE-ConnectionGUID: 1apI8UH3SEuLjXbflk1iUg==
X-CSE-MsgGUID: Df5DvFnATT6sbNumIAfvKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="82758292"
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="82758292"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 07:03:17 -0800
X-CSE-ConnectionGUID: FjNyL3nzTGmffIfobN4rsw==
X-CSE-MsgGUID: YYxarH8jSIunvzk8rgxYEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="189165362"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa007.fm.intel.com with ESMTP; 13 Nov 2025 07:03:15 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 7740D96; Thu, 13 Nov 2025 16:03:14 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 1/1] lib/vsprintf: Deduplicate special hex number specifier data
Date: Thu, 13 Nov 2025 16:02:59 +0100
Message-ID: <20251113150313.3030700-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two functions use the same specifier data for the special hex number.
Almost the same as the field width is calculated on the size of the
given type. Due to that, make a compound literal macro in order to
deduplicate the rest.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

v2: fixed prefix in the Subject line

 lib/vsprintf.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 3f99834fd788..11dbf1023391 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -582,17 +582,18 @@ char *number(char *buf, char *end, unsigned long long num,
 	return buf;
 }
 
+#define special_hex_spec(size)					\
+(struct printf_spec) {						\
+	.field_width = 2 + 2 * (size),		/* 0x + hex */	\
+	.flags = SPECIAL | SMALL | ZEROPAD,			\
+	.base = 16,						\
+	.precision = -1,					\
+}
+
 static noinline_for_stack
 char *special_hex_number(char *buf, char *end, unsigned long long num, int size)
 {
-	struct printf_spec spec;
-
-	spec.field_width = 2 + 2 * size;	/* 0x + hex */
-	spec.flags = SPECIAL | SMALL | ZEROPAD;
-	spec.base = 16;
-	spec.precision = -1;
-
-	return number(buf, end, num, spec);
+	return number(buf, end, num, special_hex_spec(size));
 }
 
 static void move_right(char *buf, char *end, unsigned len, unsigned spaces)
@@ -1164,18 +1165,11 @@ char *range_string(char *buf, char *end, const struct range *range,
 	char sym[sizeof("[range 0x0123456789abcdef-0x0123456789abcdef]")];
 	char *p = sym, *pend = sym + sizeof(sym);
 
-	struct printf_spec range_spec = {
-		.field_width = 2 + 2 * sizeof(range->start), /* 0x + 2 * 8 */
-		.flags = SPECIAL | SMALL | ZEROPAD,
-		.base = 16,
-		.precision = -1,
-	};
-
 	if (check_pointer(&buf, end, range, spec))
 		return buf;
 
 	p = string_nocheck(p, pend, "[range ", default_str_spec);
-	p = hex_range(p, pend, range->start, range->end, range_spec);
+	p = hex_range(p, pend, range->start, range->end, special_hex_spec(sizeof(range->start)));
 	*p++ = ']';
 	*p = '\0';
 
-- 
2.50.1


