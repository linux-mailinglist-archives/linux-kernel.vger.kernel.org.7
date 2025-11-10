Return-Path: <linux-kernel+bounces-893050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E0CC466C3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BBC63B40D2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C63A30F80F;
	Mon, 10 Nov 2025 11:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Mk61G/TA"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7757D30C36F
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 11:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762775921; cv=none; b=jd2bf2b3P1HZNMArA/XeZOAwV3TEjowZFKTW3byOUOmC8WeCfaCK7SwEQydsW/pTdhbqGReOU60SNJkx7o5av2NEoELexeChH9yLFgSqTUnP8nNyF2QbEU4aKxx/0PvqcBN6jYZO4R+oW77yHLy2IyMUUs6l4At4LcqgZzTLmRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762775921; c=relaxed/simple;
	bh=bvzPl/K+tGdRuxnSs4jCh9Mtfh9hDwOZoQ9j5n6ecec=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=fyhImB2Wdyxke3TfkrV74U34H0uE+v8h4Uiu0cPNz6q/4zP9x+F5rRa1UgvPpS70x50dR52hZpkA3a0LCVNcRjwOVAl5RqLSNNy9TPtlp1ecppS+vkHbWQNR18MZAuZtSQ5YaqoULkHL0yEQDBPlEz1oH9Wk2JWnTsTwEuV3uhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Mk61G/TA; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=4BupnHa0sKslSms4QWZa2Ba2ZbtsDMMo1DuTgRU2pls=; b=Mk61G/TA/gq9vZyHHBw+lV3SbQ
	SAthwTHTzrccA0s2FNwbsmUnPodkbhT+sjqwRf4Oc6C8qrqP3uOnZWXOqiGvjFtW5S8kiU+y+ZZLz
	fMqudxztpKmYfWguozKAE60r4fBCfSU5MLfTePa8PosFH0a/LV0qffF+xarziUZ0wd92AmZVqWwog
	qhLo/SaFZ3jiByRYTsZWcBBYJym99kpiQhZi8HuWy2A59V8wbeiJE/K/RFodXZqFo8o1MVBrNszWE
	lq3iOdkY9I8lnrKrSUaNP/5xPc5vORIQabvhuIDtOLPBPeEexwgvl+/V6QxTc6kNyQrIuZ/sFaKtg
	14lcRSZQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIPfv-0000000AZeR-03w5;
	Mon, 10 Nov 2025 11:03:07 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 49AAC300BD1; Mon, 10 Nov 2025 12:58:33 +0100 (CET)
Message-ID: <20251110115757.457339417@infradead.org>
User-Agent: quilt/0.68
Date: Mon, 10 Nov 2025 12:46:37 +0100
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
Subject: [PATCH v2 04/12] bug: Add BUG_FORMAT_ARGS infrastructure
References: <20251110114633.202485143@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Add BUG_FORMAT_ARGS; when an architecture is able to provide a va_list
given pt_regs, use this to print format arguments.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/asm-generic/bug.h |    1 +
 lib/bug.c                 |   17 +++++++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -13,6 +13,7 @@
 #define BUGFLAG_ONCE		(1 << 1)
 #define BUGFLAG_DONE		(1 << 2)
 #define BUGFLAG_NO_CUT_HERE	(1 << 3)	/* CUT_HERE already sent */
+#define BUGFLAG_ARGS		(1 << 4)
 #define BUGFLAG_TAINT(taint)	((taint) << 8)
 #define BUG_GET_TAINT(bug)	((bug)->flags >> 8)
 #endif
--- a/lib/bug.c
+++ b/lib/bug.c
@@ -163,11 +163,23 @@ struct bug_entry *find_bug(unsigned long
 	return module_find_bug(bugaddr);
 }
 
-static void __warn_printf(const char *fmt)
+static void __warn_printf(const char *fmt, struct pt_regs *regs)
 {
 	if (!fmt)
 		return;
 
+#ifdef HAVE_ARCH_BUG_FORMAT_ARGS
+	if (regs) {
+		struct arch_va_list _args;
+		va_list *args = __warn_args(&_args, regs);
+
+		if (args) {
+			vprintk(fmt, *args);
+			return;
+		}
+	}
+#endif
+
 	printk("%s", fmt);
 }
 
@@ -193,6 +205,7 @@ static enum bug_trap_type __report_bug(u
 	once     = bug->flags & BUGFLAG_ONCE;
 	done     = bug->flags & BUGFLAG_DONE;
 	no_cut   = bug->flags & BUGFLAG_NO_CUT_HERE;
+	has_args = bug->flags & BUGFLAG_ARGS;
 
 	if (warning && once) {
 		if (done)
@@ -212,7 +225,7 @@ static enum bug_trap_type __report_bug(u
 	 */
 	if (!no_cut) {
 		printk(KERN_DEFAULT CUT_HERE);
-		__warn_printf(fmt);
+		__warn_printf(fmt, has_args ? regs : NULL);
 	}
 
 	if (warning) {



