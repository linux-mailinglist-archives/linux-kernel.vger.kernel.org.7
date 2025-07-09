Return-Path: <linux-kernel+bounces-724518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78396AFF3E5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 23:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 784D71C84A65
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 21:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43551251795;
	Wed,  9 Jul 2025 21:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="X+l8f5UO"
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DEA23E344
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 21:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.69.130.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752096367; cv=none; b=Y37XzYoJzckJ9OUiXW+x91AgDkBheHhDBfhFOk8oJMK/BaL7Ew1IG43YiHTTpyeVpnI0I9ze3DQZ1Lpn/D2tPynglppdeY178qB0YZhNNo5vMIaBP4dVNSXTb+BzfheSjxFmN9lWaEBEWwdeUvVvse3foho+5H/+oshOzlrkflE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752096367; c=relaxed/simple;
	bh=fNYzOa+t+y0015VU0hzy4JOUsTLiP1Gd7gv1nGC/GQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uWvi865P73YpyG2yG6k4yNfhMgZW0+2Xy1H/Pcje67BKDRsQQZEJC/G1x/NvrZo6Z0BEgh+0SobWZN00u0bRNBHiCgZkGQSdoJ0hVBmuLYEw1l/0kXP4/Tm/i6HfBWjZoe0ffCEwmoUHpBbyoKOTQ/Bbn6xa5r6vnftSqsrqvsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=X+l8f5UO; arc=none smtp.client-ip=158.69.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1752096363;
	bh=fNYzOa+t+y0015VU0hzy4JOUsTLiP1Gd7gv1nGC/GQo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X+l8f5UOdfFWGRjvK54kUCHSjcGwg8FyZFkR+Na3MCocG/EvQ77Ar2WPRmLLacSrf
	 1x/tDCip2Snl5lRqDk95MxAPgibfA0Ta469gnlRmXudWQbuA9bPwQuDBxlQjfzOiB3
	 KMK2TxnE/ewlIOwhWdHai0xeLu1sTB+0OvPi6hmk99qoFmbWymqfS6ei+oDttZt1ZD
	 +whVC8c7OqHtaTuyEo2e0zSMn6Rq8nioCWbGgdQiEuv1kDiisifgRL2rLF3hS3Jhqc
	 HJd5wOaVlH5cWSoh/qh/BkUXpHobEBDgSTvPPkxPd89+ccjWfbssbxQrN8kUoF6ZKz
	 TvKiPmVOdfWbQ==
Received: from compudjdev.. (192-222-132-26.qc.cable.ebox.net [192.222.132.26])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4bcrcq2dn7zPtn;
	Wed,  9 Jul 2025 17:26:03 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrii Nakryiko <andrii@kernel.org>,
	Indu Bhagat <indu.bhagat@oracle.com>,
	"Jose E. Marchesi" <jemarch@gnu.org>,
	Beau Belgrave <beaub@linux.microsoft.com>,
	Jens Remus <jremus@linux.ibm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [RFC PATCH 5/5] unwind: Introduce unwind user entry type
Date: Wed,  9 Jul 2025 17:25:52 -0400
Message-ID: <20250709212556.32777-6-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250709212556.32777-1-mathieu.desnoyers@efficios.com>
References: <20250709212556.32777-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a unwind user entry type to allow unwind iterator users to
know which method was used to obtain each of the stack frames.

This allows iterator users to know whether they can trust the
information provided by the stack trace. For instance, on a system with
binaries built with frame pointers omitted, the stack frames fetched
using the frame pointer method should be considered unreliable, whereas
those fetched using sframe should be reliable.

Note that the "none" entry type denotes the first address (start of
iteration), which is present in the pt_regs, and therefore is always
reliable.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt (Google) <rostedt@goodmis.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Indu Bhagat <indu.bhagat@oracle.com>
Cc: "Jose E. Marchesi" <jemarch@gnu.org>
Cc: Beau Belgrave <beaub@linux.microsoft.com>
Cc: Jens Remus <jremus@linux.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 include/linux/unwind_deferred_types.h | 6 ++++--
 include/linux/unwind_user_types.h     | 9 +++++++--
 kernel/unwind/user.c                  | 7 +++++--
 3 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/include/linux/unwind_deferred_types.h b/include/linux/unwind_deferred_types.h
index db6c65daf185..ef9818456fd5 100644
--- a/include/linux/unwind_deferred_types.h
+++ b/include/linux/unwind_deferred_types.h
@@ -2,9 +2,11 @@
 #ifndef _LINUX_UNWIND_USER_DEFERRED_TYPES_H
 #define _LINUX_UNWIND_USER_DEFERRED_TYPES_H
 
+#include <linux/unwind_user_types.h>
+
 struct unwind_cache {
-	unsigned int		nr_entries;
-	unsigned long		entries[];
+	unsigned int			nr_entries;
+	struct unwind_user_entry	entries[];
 };
 
 
diff --git a/include/linux/unwind_user_types.h b/include/linux/unwind_user_types.h
index 860f84cd7998..ab29c419099c 100644
--- a/include/linux/unwind_user_types.h
+++ b/include/linux/unwind_user_types.h
@@ -28,9 +28,14 @@ enum unwind_user_type {
 	UNWIND_USER_TYPE_FP =			(1U << UNWIND_USER_TYPE_FP_BIT),
 };
 
+struct unwind_user_entry {
+	enum unwind_user_type type;
+	unsigned long ip;
+};
+
 struct unwind_user_stacktrace {
-	unsigned int	nr;
-	unsigned long	*entries;
+	unsigned int nr;
+	struct unwind_user_entry *entries;
 };
 
 struct unwind_user_frame {
diff --git a/kernel/unwind/user.c b/kernel/unwind/user.c
index dfe7bf50d8f6..9a88fe757327 100644
--- a/kernel/unwind/user.c
+++ b/kernel/unwind/user.c
@@ -180,8 +180,11 @@ int unwind_user(struct unwind_user_stacktrace *trace, unsigned int max_entries)
 		return 0;
 
 	for_each_user_frame(&state) {
-		trace->entries[trace->nr++] = state.ip;
-		if (trace->nr >= max_entries)
+		unsigned int i = trace->nr++;
+
+		trace->entries[i].type = state.current_type;
+		trace->entries[i].ip = state.ip;
+		if (i >= max_entries)
 			break;
 	}
 
-- 
2.43.0


