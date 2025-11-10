Return-Path: <linux-kernel+bounces-893053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EE9C466D6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 509243BDF50
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A99F8311975;
	Mon, 10 Nov 2025 11:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Re/t147S"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EDA310627
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 11:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762775925; cv=none; b=G2sRBNXfsLzBpswN2Ni4+1wTf2p/lDlg3/BaePph30BSCL83k2PPydOoDWHfRC6qnYNrHN4j9IOOJ8yQs/DKVZ03Rteqz/suFGKf+u1MTCIm0hBa25538JOHHyj3tQzfXhg4SWlkm9A/2VQzLDNrHJPR2kdzHlUkvACubY6OkSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762775925; c=relaxed/simple;
	bh=y/ROBjRr11C2c2LyZsNZnTDY8QeuGoouvKdG48e3kxw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=TKGuPsTttxK6Pzhllw9ba7tHrNOw1CykiYwY+tgwiefJNmhNygHiQu2LGK8Hlnjyeks0Qh8Uie557WaeR3zrRSSP/5wWYgXMYGuItphaRJnHb76KwNS3/yEyekWmZkEVFGu00s1MBWZOtJi2mKi5dKr/OQF+xLCsONQndk5FFyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Re/t147S; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=pR5La9IbimsFE5rS0LQqtTCVTAHz0m5FmUgLJFwqOCA=; b=Re/t147SCChaJwCC8YCd32hAxH
	P8FSeirdy8ol0aUQW78gqe5CgsMFvYeiHfyeC/PLjV5ee8u3IJ6EbUPX/z69wPZV02/UBhFMJ44FU
	LS3sKgpErFZLDpgXFVVi9sRghJFI92UuIcmv70u3rFYEH7NqPqxZGZT2vGlwWivOcxphRqxgpVSCq
	K8P6Q/tmd86cEvh0BbiNQJqWm9gcA/rztpg+YuzXByLZTLP9KQI5XpqnR3u2/JvnLvxJ93AniMg0M
	stV5F7Xg/c5oYOnkjhON/tuXbfwjacS4bkF9gN/+qzrRj2LMFAsUACncKMMofrnGvC4EuURZWzY1R
	r8TsqZhQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIQXb-0000000EPAo-2dlo;
	Mon, 10 Nov 2025 11:58:35 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 57BE6302FD9; Mon, 10 Nov 2025 12:58:33 +0100 (CET)
Message-ID: <20251110115757.807154591@infradead.org>
User-Agent: quilt/0.68
Date: Mon, 10 Nov 2025 12:46:40 +0100
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
Subject: [PATCH v2 07/12] bug: Allow architectures to provide __WARN_printf()
References: <20251110114633.202485143@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

In addition to providing __WARN_FLAGS(), allow an architecture to also
provide __WARN_printf().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/asm-generic/bug.h |   37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -100,23 +100,9 @@ void warn_slowpath_fmt(const char *file,
 		       const char *fmt, ...);
 extern __printf(1, 2) void __warn_printk(const char *fmt, ...);
 
-#ifndef __WARN_FLAGS
-#define __WARN()		__WARN_printf(TAINT_WARN, NULL)
-#define __WARN_printf(taint, arg...) do {				\
-		instrumentation_begin();				\
-		warn_slowpath_fmt(__FILE__, __LINE__, taint, arg);	\
-		instrumentation_end();					\
-	} while (0)
-#else
+#ifdef __WARN_FLAGS
 #define __WARN()		__WARN_FLAGS("", BUGFLAG_TAINT(TAINT_WARN))
 
-#define __WARN_printf(taint, arg...) do {				\
-		instrumentation_begin();				\
-		__warn_printk(arg);					\
-		__WARN_FLAGS("", BUGFLAG_NO_CUT_HERE | BUGFLAG_TAINT(taint));\
-		instrumentation_end();					\
-	} while (0)
-
 #define WARN_ON(condition) ({						\
 	int __ret_warn_on = !!(condition);				\
 	if (unlikely(__ret_warn_on))					\
@@ -135,6 +121,27 @@ extern __printf(1, 2) void __warn_printk
 })
 #endif
 
+#if defined(__WARN_FLAGS) && !defined(__WARN_printf)
+#define __WARN_printf(taint, arg...) do {				\
+		instrumentation_begin();				\
+		__warn_printk(arg);					\
+		__WARN_FLAGS("", BUGFLAG_NO_CUT_HERE | BUGFLAG_TAINT(taint));\
+		instrumentation_end();					\
+	} while (0)
+#endif
+
+#ifndef __WARN_printf
+#define __WARN_printf(taint, arg...) do {				\
+		instrumentation_begin();				\
+		warn_slowpath_fmt(__FILE__, __LINE__, taint, arg);	\
+		instrumentation_end();					\
+	} while (0)
+#endif
+
+#ifndef __WARN
+#define __WARN()		__WARN_printf(TAINT_WARN, NULL)
+#endif
+
 /* used internally by panic.c */
 
 #ifndef WARN_ON



