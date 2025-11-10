Return-Path: <linux-kernel+bounces-893058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B9CC466CF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 994D43481F1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785B631282D;
	Mon, 10 Nov 2025 11:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BwVmIbTp"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0AE3112C4
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 11:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762775927; cv=none; b=pyrQHeyRR2+KuIWTCAGVRLn/JIjM2hxoiOx62zGT90J37RLKexoMLGlOazG2tb/dXp3rlVKX4qMyIZzhaE5lMTK0gMosznAtQIq+zDFB4qI9MhfbNQLkRfJdm9h7tQ7uqIOThnV1gNJpDVqDR3T6EYGonKP8uXMOUdqUjgUeozw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762775927; c=relaxed/simple;
	bh=IoMasXSjoGE6KxKLUtaZikrwv5hFbj5+u+bcqqIO1gM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=gnpDCFL+J0WUQHppKpneCC7xefSd/2rCSyZcPZhyrFG2P0VjZSDZsqnXh+q/0yJbReD88GwUfzK4fLs1dDdqc1ocGFqnsD2R7jFAUiXUhKEXxrwbddBBu88LeiEJawVHPUtIiaf9KzyvZNaCGmrkgH0v9j8m0yxHr9J54KMUHqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BwVmIbTp; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=VA1KlApxh8zgmd9WY7nC8+VHpN+PuUfxe0ZBfHHHypo=; b=BwVmIbTp6mZyP71S+GyKiemLNX
	m7oagC+6aeS5USJmV3VRBnq9hEXJD3/+anFJmgaGYxYpIDN3BAZArpYql+QUzgTATwNvRrnsn55lr
	feKu1U1jkl2F7DAtj/Vqrv/kqtE9X1+tSgGfJ35wXRc0N+RPRPFmsgvGoaS0gOyrynWh2RpISl1ye
	x8xL25rhHc56w/ZIFho7gXSumhSLhLML1rNjpMXfROs2fCU9hLNV8lnzdLhGAb3/4pNPZ2BwfAogr
	iOnqfc/Sov08uCa+aRD/6yXWGCha88lj0aMV4HWHR/99V6b7HTVnjerO+ZhXl2ZbCZYP4OOJEmETk
	WcEm1SOQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIQXa-0000000EP7Y-3z4z;
	Mon, 10 Nov 2025 11:58:35 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 3BA3F3002BE; Mon, 10 Nov 2025 12:58:33 +0100 (CET)
Message-ID: <20251110115757.111187573@infradead.org>
User-Agent: quilt/0.68
Date: Mon, 10 Nov 2025 12:46:34 +0100
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
Subject: [PATCH v2 01/12] x86: Rework __bug_table helpers
References: <20251110114633.202485143@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Rework the __bug_table helpers such that extension becomes easier.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/bug.h |   37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -37,39 +37,42 @@
 #ifdef CONFIG_GENERIC_BUG
 
 #ifdef CONFIG_X86_32
-# define __BUG_REL(val)	".long " val
+#define __BUG_REL(val)		".long " val
 #else
-# define __BUG_REL(val)	".long " val " - ."
+#define __BUG_REL(val)		".long " val " - ."
 #endif
 
 #ifdef CONFIG_DEBUG_BUGVERBOSE
-#define __BUG_ENTRY(file, line, flags)					\
-	"2:\t" __BUG_REL("1b") "\t# bug_entry::bug_addr\n"		\
+#define __BUG_ENTRY_VERBOSE(file, line)					\
 	"\t" __BUG_REL(file)   "\t# bug_entry::file\n"			\
-	"\t.word " line        "\t# bug_entry::line\n"			\
-	"\t.word " flags       "\t# bug_entry::flags\n"
+	"\t.word " line        "\t# bug_entry::line\n"
 #else
-#define __BUG_ENTRY(file, line, flags)					\
-	"2:\t" __BUG_REL("1b") "\t# bug_entry::bug_addr\n"		\
-	"\t.word " flags       "\t# bug_entry::flags\n"
+#define __BUG_ENTRY_VERBOSE(file, line)
 #endif
 
+#define __BUG_ENTRY(file, line, flags)					\
+	__BUG_REL("1b")		"\t# bug_entry::bug_addr\n"		\
+	__BUG_ENTRY_VERBOSE(file, line)					\
+	"\t.word " flags	"\t# bug_entry::flags\n"
+
 #define _BUG_FLAGS_ASM(ins, file, line, flags, size, extra)		\
 	"1:\t" ins "\n"							\
-	".pushsection __bug_table,\"aw\"\n"				\
+	".pushsection __bug_table,\"aw\"\n\t"				\
 	ANNOTATE_DATA_SPECIAL						\
+	"2:\n\t"							\
 	__BUG_ENTRY(file, line, flags)					\
 	"\t.org 2b + " size "\n"					\
 	".popsection\n"							\
 	extra
 
-#define _BUG_FLAGS(cond_str, ins, flags, extra)						\
-do {											\
-	asm_inline volatile(_BUG_FLAGS_ASM(ins, "%c0",					\
-					   "%c1", "%c2", "%c3", extra)			\
-		     : : "i" (WARN_CONDITION_STR(cond_str) __FILE__), "i" (__LINE__),	\
-			 "i" (flags),							\
-			 "i" (sizeof(struct bug_entry)));				\
+#define _BUG_FLAGS(cond_str, ins, flags, extra)				\
+do {									\
+	asm_inline volatile(_BUG_FLAGS_ASM(ins, "%c0",			\
+					   "%c1", "%c2", "%c3", extra)	\
+		   : : "i" (WARN_CONDITION_STR(cond_str) __FILE__),	\
+		       "i" (__LINE__),					\
+		       "i" (flags),					\
+		       "i" (sizeof(struct bug_entry)));			\
 } while (0)
 
 #define ARCH_WARN_ASM(file, line, flags, size)				\



