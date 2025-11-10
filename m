Return-Path: <linux-kernel+bounces-893056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93204C466DB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CC973BDB8B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B063126A2;
	Mon, 10 Nov 2025 11:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qWvIwGa2"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1793112C9
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 11:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762775926; cv=none; b=CyXZJ6zx3kSX1LDp0zWKsAoFZidJn+nwYnuUD/X+5FwlCee6UiAR10d5bw+Mfskl+LGHbpsYD7CIl4Gltuf2ZvVobt3EUt5y7s+2X1KY6QKsP4LVqefkb6SbSWBVnO1QdMF+vM+D6ov3uZIdGKfG2nTVQY8ZPBZAdYe0ir+Nwg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762775926; c=relaxed/simple;
	bh=LP6wuQEXYX4QjbUpdcvxVSBFfEtJ0I/6g9QorY7tuR8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Gej1xsHzu6fPdPW3uLuhRfV+BkCaCNK2FfSZUyA4K4bnMF7i94a1sH2fPS4VZU6QhYZHOn8tj4+3PFcNnytWaCNbiKMrnTKa405kZVtj3K+lVZlN4hTjjG9RWAvTk0cPEG12tcYPXs3CpncWpSTzWtFe5jHtaJEiQ3VKjAiJUWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qWvIwGa2; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=N+AZaDtRc8FPTpKgpo1rqntKZ+vvKgrVjj5UuVMZhVM=; b=qWvIwGa2syYDxURinepOKWa5xA
	6cI/cutfJveBXJLWZDszW6ZVAz1EU14MhlohVchYszU3iNHdQ9yjJIZGLZkEjasE4JhrwKpRUy+i3
	qpgbhYSxlTuKaJS+UuDgko7U8Rw/itlNOgI7TjH0D1kljHxWbwI/6xgVYRnNK5YajiaVAx+ZAIC2e
	hDlZUWBGEqaDQ3u1cqNZcbO4XjbN/GSyzRdxsyRHNnf+xFUTLJEzi/U0IBy4gSflt+UuD1UZsljlz
	PHqyN0pjHqv+Q5H5aC+jWGJi9XVZfkAlWxeT2IyThUepzTpL6vXCQ9NW/gwBVu7HZ6F7ZNQTSlTM2
	+Rg0XYAA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIQXb-0000000EPAp-2fVp;
	Mon, 10 Nov 2025 11:58:35 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 60365303031; Mon, 10 Nov 2025 12:58:33 +0100 (CET)
Message-ID: <20251110115758.097401406@infradead.org>
User-Agent: quilt/0.68
Date: Mon, 10 Nov 2025 12:46:42 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
 peterz@infradead.org,
 kees@kernel.org,
 acarmina@redhat.com,
 jpoimboe@kernel.org,
 mark.rutland@arm.com,
 torvalds@linuxfoundation.org,
 maciej.wieczor-retman@intel.com
Subject: [PATCH v2 09/12] x86/bug: Use BUG_FORMAT for DEBUG_BUGVERBOSE_DETAILED
References: <20251110114633.202485143@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Since we have an explicit format string, use it for the condition string
instead of frobbing it in the file string.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/bug.h |   10 ++++++++--
 include/asm-generic/bug.h  |    8 +++++---
 2 files changed, 13 insertions(+), 5 deletions(-)

--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -74,13 +74,19 @@
 	".popsection\n"							\
 	extra
 
+#ifdef CONFIG_DEBUG_BUGVERBOSE_DETAILED
+#define WARN_CONDITION_STR(cond_str) cond_str
+#else
+#define WARN_CONDITION_STR(cond_str) NULL
+#endif
+
 #define _BUG_FLAGS(cond_str, ins, flags, extra)				\
 do {									\
 	asm_inline volatile(_BUG_FLAGS_ASM(ins, "%c[fmt]", "%c[file]",	\
 					   "%c[line]", "%c[fl]",	\
 					   "%c[size]", extra)		\
-		   : : [fmt] "i" (NULL),				\
-		       [file] "i" (WARN_CONDITION_STR(cond_str) __FILE__), \
+		   : : [fmt] "i" (WARN_CONDITION_STR(cond_str)),	\
+		       [file] "i" (__FILE__),				\
 		       [line] "i" (__LINE__),				\
 		       [fl] "i" (flags),				\
 		       [size] "i" (sizeof(struct bug_entry)));		\
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -18,11 +18,13 @@
 #define BUG_GET_TAINT(bug)	((bug)->flags >> 8)
 #endif
 
+#ifndef WARN_CONDITION_STR
 #ifdef CONFIG_DEBUG_BUGVERBOSE_DETAILED
-# define WARN_CONDITION_STR(cond_str) cond_str
+# define WARN_CONDITION_STR(cond_str) "[" cond_str "] "
 #else
 # define WARN_CONDITION_STR(cond_str)
 #endif
+#endif /* WARN_CONDITION_STR */
 
 #ifndef __ASSEMBLY__
 #include <linux/panic.h>
@@ -106,7 +108,7 @@ extern __printf(1, 2) void __warn_printk
 #define WARN_ON(condition) ({						\
 	int __ret_warn_on = !!(condition);				\
 	if (unlikely(__ret_warn_on))					\
-		__WARN_FLAGS("["#condition"] ",				\
+		__WARN_FLAGS(#condition,				\
 			     BUGFLAG_TAINT(TAINT_WARN));		\
 	unlikely(__ret_warn_on);					\
 })
@@ -114,7 +116,7 @@ extern __printf(1, 2) void __warn_printk
 #define WARN_ON_ONCE(condition) ({					\
 	int __ret_warn_on = !!(condition);				\
 	if (unlikely(__ret_warn_on))					\
-		__WARN_FLAGS("["#condition"] ",				\
+		__WARN_FLAGS(#condition,				\
 			     BUGFLAG_ONCE |				\
 			     BUGFLAG_TAINT(TAINT_WARN));		\
 	unlikely(__ret_warn_on);					\



