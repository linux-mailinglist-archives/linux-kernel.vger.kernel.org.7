Return-Path: <linux-kernel+bounces-899037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A10C56A0A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0F5344E40E0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 09:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9252D9786;
	Thu, 13 Nov 2025 09:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z0XOw9o6"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B178321C17D
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 09:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763026232; cv=none; b=ZIgTHEn/0ncC8Iv+jJUoH+/wXFAkXcYle5DOIt2o/tvSBlNlIGCy55rXIm8CB7yySJTLaAiCg4W2FlyDxUxpevgw6eNTZeTuXXzpEjgfZ/FB5RIxpW1P8N2ryiG76hSmoWp0svy1nW31/Yq5rfB9YUWLEE2THYvF1yufnE2fXrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763026232; c=relaxed/simple;
	bh=FRnbaGSieU431nkmboZKxJ5kKxXIDomk8uGwPiBNw80=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZycuqOYV1TYRmALyBhdbDpkTUGQwW6GHYTDRtLY9lPO7f0SU+sW9J9TSzjwXkhppLG2Ge0Wr5zorLxVGNbqyREIyLTYb8uvDtpeWc0NwUUc64mDrsYAIbZmJFF0FE0wQswfVsBgtv+T8F2dDoyphMoP5CQNHY08DkDo+ViZ/b4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z0XOw9o6; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763026231; x=1794562231;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FRnbaGSieU431nkmboZKxJ5kKxXIDomk8uGwPiBNw80=;
  b=Z0XOw9o66Qp8L6DAMH4oNeZphDSnW7DNevY+4pa0bBkM1J6vvX2b9+jc
   o/T6NXyDBhaf8hofryhpC2PwhR3/ilOHN2anFno4o75rw3rUR6cdpT/bf
   HzIYKyzOATH1AuDZxoCN5QWEVG0T7sBMdr0hu0U2JznSyqK16hOCpKo+I
   NVOL7IeNW8QpaOj6uSAgRvUSH2TvvSLzjt7MJW/VA00LYnbUUBUSwwOnD
   QhiNI0iZCZ0LEB1d21YXnSDN08Y2hwXVKcZgqH+LsgKRVV0eKbWSBna4F
   DgnSe1zHmi9J9rCaDhSFj4DAReePqouXmlGoir+pt25o4NdfwiSfqCJET
   A==;
X-CSE-ConnectionGUID: VOOsJvqBTgq2quK6i0R0fg==
X-CSE-MsgGUID: RMKfgGTGTRCKJoCcQkfVsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="64809577"
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; 
   d="scan'208";a="64809577"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 01:30:30 -0800
X-CSE-ConnectionGUID: Ju+lzKo1SDiWiXUApegF2Q==
X-CSE-MsgGUID: FIiVUKkJRUqvvgkoyQoA+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; 
   d="scan'208";a="189109758"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa007.fm.intel.com with ESMTP; 13 Nov 2025 01:30:24 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id AA10E95; Thu, 13 Nov 2025 10:30:22 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v1 1/1] lib/vsprinf: Deduplicate special hex number specifier data
Date: Thu, 13 Nov 2025 10:30:15 +0100
Message-ID: <20251113093015.2283883-1-andriy.shevchenko@linux.intel.com>
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
 lib/vsprintf.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 3143496f6bf8..51a88b3f5b52 100644
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


