Return-Path: <linux-kernel+bounces-893055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 65175C466CC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 454254EA4C0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60411311C3F;
	Mon, 10 Nov 2025 11:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XJZD/75H"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFC1310782
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 11:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762775926; cv=none; b=PLsGSWLTaRT1665cLS2Od0RqnH5uPzQXCvotsEPS5VY7lJ5xyez//6MbfuK7oW3kYm4APZlYVg3EE3t05UCoFackQFgNAD6ll9BhcMbm+rs5MyMz8SkTmiM3oL84CjnZmFJUNHcbafomthrymYeJCfPNbFGR0nxizDSxsjR1aos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762775926; c=relaxed/simple;
	bh=hygQNXQ+xhB4b9/63ywu2opaPSkxb9cfn8zgZzY10U0=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=fEtUHU7pte/gG+t3bE1B9TvTYUrZyjHope68QG5lU/1Y6FIFtClIzLPQnDVaiNt1VEV35Ls8D4OgOuA9FgVdpvfM8L4LE7cHT7qF0s7ppIMb9q3h6AsXNiY6Rh2+FPm6Yzpsw2wbNBtvl4zQ3sxUWyW1Zar6goF2UVdmktzxiYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XJZD/75H; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=o64h18BSiLruIN1YC6ldxQoJNaHV4cyR4p9OeFqd4Ag=; b=XJZD/75H/9GlsxrlMmoq1TbpLz
	gOs9yQjPRRFzvXt295DXIingtUrQ7U35GDIYL1kgYkBGuyyo1ER8fst7SleiodsSEcLmipWiCmchu
	DNoD6k3u5zpgdU7q3bWTcUyqHDpjEEu7xHwxQG3//BDOCiaTtOAz2oiuoaVjEXN39WeQkwTsV5UBq
	vbSuPALHsDjYJ/ymBmRKY4Nj1GrswmBRe4KMpGghfBn13S5Mf3bkKYVx26bXA6ynNUs8WcBxyJr7B
	OQ+ub4tKv5TQA5togF/J78o38KD9PvD5adP71h7NJPPEv1hHsJuh+5cbGurg0w4ju/euYtW8EbrAo
	tvgRco7w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIQXb-0000000EPAj-2c6a;
	Mon, 10 Nov 2025 11:58:35 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 4EC98301185; Mon, 10 Nov 2025 12:58:33 +0100 (CET)
Message-ID: <20251110115757.575795595@infradead.org>
User-Agent: quilt/0.68
Date: Mon, 10 Nov 2025 12:46:38 +0100
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
Subject: [PATCH v2 05/12] bug: Add report_bug_entry()
References: <20251110114633.202485143@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Add a report_bug() variant where the bug_entry is already known. This
is useful when the exception instruction is not instantiated per-site.
But instead has a single instance. In such a case the bug_entry
address might be passed along in a known register or something.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/bug.h |    1 +
 lib/bug.c           |   32 +++++++++++++++++++++++---------
 2 files changed, 24 insertions(+), 9 deletions(-)

--- a/include/linux/bug.h
+++ b/include/linux/bug.h
@@ -42,6 +42,7 @@ void bug_get_file_line(struct bug_entry
 struct bug_entry *find_bug(unsigned long bugaddr);
 
 enum bug_trap_type report_bug(unsigned long bug_addr, struct pt_regs *regs);
+enum bug_trap_type report_bug_entry(struct bug_entry *bug, struct pt_regs *regs);
 
 /* These are defined by the architecture */
 int is_valid_bugaddr(unsigned long addr);
--- a/lib/bug.c
+++ b/lib/bug.c
@@ -183,18 +183,20 @@ static void __warn_printf(const char *fm
 	printk("%s", fmt);
 }
 
-static enum bug_trap_type __report_bug(unsigned long bugaddr, struct pt_regs *regs)
+static enum bug_trap_type __report_bug(struct bug_entry *bug, unsigned long bugaddr, struct pt_regs *regs)
 {
 	bool warning, once, done, no_cut, has_args;
 	const char *file, *fmt;
 	unsigned line;
 
-	if (!is_valid_bugaddr(bugaddr))
-		return BUG_TRAP_TYPE_NONE;
-
-	bug = find_bug(bugaddr);
-	if (!bug)
-		return BUG_TRAP_TYPE_NONE;
+	if (!bug) {
+		if (!is_valid_bugaddr(bugaddr))
+			return BUG_TRAP_TYPE_NONE;
+
+		bug = find_bug(bugaddr);
+		if (!bug)
+			return BUG_TRAP_TYPE_NONE;
+	}
 
 	disable_trace_on_warning();
 
@@ -244,13 +246,25 @@ static enum bug_trap_type __report_bug(u
 	return BUG_TRAP_TYPE_BUG;
 }
 
+enum bug_trap_type report_bug_entry(struct bug_entry *bug, struct pt_regs *regs)
+{
+	enum bug_trap_type ret;
+	bool rcu = false;
+
+	rcu = warn_rcu_enter();
+	ret = __report_bug(bug, 0, regs);
+	warn_rcu_exit(rcu);
+
+	return ret;
+}
+
 enum bug_trap_type report_bug(unsigned long bugaddr, struct pt_regs *regs)
 {
 	enum bug_trap_type ret;
 	bool rcu = false;
 
 	rcu = warn_rcu_enter();
-	ret = __report_bug(bugaddr, regs);
+	ret = __report_bug(NULL, bugaddr, regs);
 	warn_rcu_exit(rcu);
 
 	return ret;



