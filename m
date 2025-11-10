Return-Path: <linux-kernel+bounces-893048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CC30FC466B7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9E32C4E9CEF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1753B30F554;
	Mon, 10 Nov 2025 11:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WBtMvl07"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EF921B918
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 11:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762775921; cv=none; b=JJSv30k0DAxxhFfLTOxHn+2/ah2t/8VCSvff/YJAvcQOEgcG6xqujDpjwolm5hDYAK3s5Zeksx+i85yRcChYKwN9g635InxWDi0sKNl/rpn4qq5EBeQ/r0lsf2NoCG8YfUO0i3cAtHS4RQ0sOO12X9qp0hW5nVH8gvXSqXpD+w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762775921; c=relaxed/simple;
	bh=gpUkrpK6WLsk7dAjWEA0Rw7KSK8kJq1N0OJrpJ5CgbY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=h6p1mKv+ucRrx+jpHU14Xi7lBmUWyhCZw2tVR8LGXCYzXciO/OKyLwUFipgIoB7iVhl6H1d0Hn+o2ntsZtElWAUUL38XlTm6vDt9Fffn5yfo4CD1mlECfFCcAwUHhqR1isPyXzqtMofE0bNI+GqLrrMKRNDV6U8jKKi7I7PxyIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WBtMvl07; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=RXB/rxtxG13G057ERTR24i5C8ULS0BJYqSPj5oJfR8g=; b=WBtMvl07213PwHrJ7o3SrWAEuZ
	lEsSEyjFseCAeik+E/+9O5ZeezfVLl7hgyVaupj3J6BwJddnKSiOjgI/ene3zzuBLuJxd49Twppl8
	NpxXoUCt+5e7aGKcrSd/4mlC3uZ0PlvIFtGZjXr53RJWDeiq1BIKroXRDUBOhDwrMIYkHwoeb/h/G
	br4zNyU5k3xf3zIsE/Cncud8AMPvz4H/Ki2nOso/202dZZH9tBky7hYiK6xUW1Z8WGFZLc69zJwu+
	e5Z58koEgqPbrE4BCFBnMWnNRmwMw5DL/TnpXTSP+xIZbiw+JzA+afkS/DJeuhkowWC95zZ6mx2WS
	QIudPT8Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIPfv-0000000AZej-3Idt;
	Mon, 10 Nov 2025 11:03:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 5BC03303004; Mon, 10 Nov 2025 12:58:33 +0100 (CET)
Message-ID: <20251110115757.980264454@infradead.org>
User-Agent: quilt/0.68
Date: Mon, 10 Nov 2025 12:46:41 +0100
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
Subject: [PATCH v2 08/12] x86/bug: Add BUG_FORMAT basics
References: <20251110114633.202485143@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Opt-in to BUG_FORMAT for x86_64, adjust the BUGTABLE helper and for
now, just store NULL pointers.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/bug.h |   31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -50,33 +50,44 @@
 #define __BUG_ENTRY_VERBOSE(file, line)
 #endif
 
-#define __BUG_ENTRY(file, line, flags)					\
+#if defined(CONFIG_X86_64) || defined(CONFIG_DEBUG_BUGVERBOSE_DETAILED)
+#define HAVE_ARCH_BUG_FORMAT
+#define __BUG_ENTRY_FORMAT(format)					\
+	"\t" __BUG_REL(format)	"\t# bug_entry::format\n"
+#else
+#define __BUG_ENTRY_FORMAT(format)
+#endif
+
+#define __BUG_ENTRY(format, file, line, flags)				\
 	__BUG_REL("1b")		"\t# bug_entry::bug_addr\n"		\
+	__BUG_ENTRY_FORMAT(format)					\
 	__BUG_ENTRY_VERBOSE(file, line)					\
 	"\t.word " flags	"\t# bug_entry::flags\n"
 
-#define _BUG_FLAGS_ASM(ins, file, line, flags, size, extra)		\
+#define _BUG_FLAGS_ASM(ins, format, file, line, flags, size, extra)	\
 	"1:\t" ins "\n"							\
 	".pushsection __bug_table,\"aw\"\n\t"				\
 	ANNOTATE_DATA_SPECIAL						\
 	"2:\n\t"							\
-	__BUG_ENTRY(file, line, flags)					\
+	__BUG_ENTRY(format, file, line, flags)				\
 	"\t.org 2b + " size "\n"					\
 	".popsection\n"							\
 	extra
 
 #define _BUG_FLAGS(cond_str, ins, flags, extra)				\
 do {									\
-	asm_inline volatile(_BUG_FLAGS_ASM(ins, "%c0",			\
-					   "%c1", "%c2", "%c3", extra)	\
-		   : : "i" (WARN_CONDITION_STR(cond_str) __FILE__),	\
-		       "i" (__LINE__),					\
-		       "i" (flags),					\
-		       "i" (sizeof(struct bug_entry)));			\
+	asm_inline volatile(_BUG_FLAGS_ASM(ins, "%c[fmt]", "%c[file]",	\
+					   "%c[line]", "%c[fl]",	\
+					   "%c[size]", extra)		\
+		   : : [fmt] "i" (NULL),				\
+		       [file] "i" (WARN_CONDITION_STR(cond_str) __FILE__), \
+		       [line] "i" (__LINE__),				\
+		       [fl] "i" (flags),				\
+		       [size] "i" (sizeof(struct bug_entry)));		\
 } while (0)
 
 #define ARCH_WARN_ASM(file, line, flags, size)				\
-	_BUG_FLAGS_ASM(ASM_UD2, file, line, flags, size, "")
+	_BUG_FLAGS_ASM(ASM_UD2, "NULL", file, line, flags, size, "")
 
 #else
 



