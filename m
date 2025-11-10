Return-Path: <linux-kernel+bounces-893054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0AFC466D5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 13:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFA003BE731
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 12:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A997C311960;
	Mon, 10 Nov 2025 11:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="D7HJqHTy"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29F6D310629
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 11:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762775925; cv=none; b=iYxw1sG3LxOs9/y6yMO6Z4EUWbGSyG49f8XoTPzjS3vitTi48r35bG4qMo9qY/Mjy8uTo3bOTbajoEDP7ejt70TtqVKrZ0N8vYsjvr5smzDPBAx+FcI4Q3t0wqPpf3LazFzmjO7qt8QcKq8jloR3A6FtKyEiYZPOIKGP3T9s02k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762775925; c=relaxed/simple;
	bh=v8zMrrx+Vd9rz29sYzyrTFcl+yNwirp1jzZuIPvgIiA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=sPHQNBLt0oSIf5/zCYj6ze+5/OhMTLlkRMpz1hw2g8MDkUUavxCBlnLuDNRFg4elsWp3sLODBMYd0+0Tm1RM4nohfyCfKh3ufo1AgYBH45JsNQkWUaE6lBEwPkEZx3z1k5FgSvUS9qje7QSBRmxOMZIk7Yzo+Zn5/hT2KN3MjxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=D7HJqHTy; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=43gEQOf5Sh+lovVXtaC9R0dz67eHKXNxBmPliUUAKWs=; b=D7HJqHTyzxmV97s+/s+Y3vE+Dy
	829a9WLcm2j5fR5SXD88l1tSmTEeTs/eyGt9q6l5kTC+Q+DHRdM4Xj4nr0TUQGhIgkrhdNA0c5Vhp
	jSHGxlPV1B+sr7RYAly9tg/i14qlMukJKl3iFH2j9kMV2x4g7uE8VqMNAJ+ZYYZdcQIIdXJwbKzab
	xueeK7jAmoXRmeJZCCaPtiiNaaYqZEWS0ClG8YDmVheJ0lfJQ38MZfy1J782CcYbSff8Ywcd7EeGm
	1TS2yYwUptxi0H8wWWFpdQnjWOcJWXxUBVKedN1RT1rOpYjqOH8K9THJ341pWEuWgJ0S+cCckHmLv
	S08usosg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIQXa-0000000EP7W-3tkC;
	Mon, 10 Nov 2025 11:58:35 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id 4092C300323; Mon, 10 Nov 2025 12:58:33 +0100 (CET)
Message-ID: <20251110115757.223371452@infradead.org>
User-Agent: quilt/0.68
Date: Mon, 10 Nov 2025 12:46:35 +0100
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
Subject: [PATCH v2 02/12] bug: Add BUG_FORMAT infrastructure
References: <20251110114633.202485143@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Add BUG_FORMAT; an architecture opt-in feature that allows adding the
WARN_printf() format string to the bug_entry table.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/asm-generic/bug.h |    7 +++++++
 lib/bug.c                 |   39 ++++++++++++++++++++++++++++++++-------
 2 files changed, 39 insertions(+), 7 deletions(-)

--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -36,6 +36,13 @@ struct bug_entry {
 #else
 	signed int	bug_addr_disp;
 #endif
+#ifdef HAVE_ARCH_BUG_FORMAT
+#ifndef CONFIG_GENERIC_BUG_RELATIVE_POINTERS
+	const char	*format;
+#else
+	signed int	format_disp;
+#endif
+#endif
 #ifdef CONFIG_DEBUG_BUGVERBOSE
 #ifndef CONFIG_GENERIC_BUG_RELATIVE_POINTERS
 	const char	*file;
--- a/lib/bug.c
+++ b/lib/bug.c
@@ -139,6 +139,19 @@ void bug_get_file_line(struct bug_entry
 #endif
 }
 
+static const char *bug_get_format(struct bug_entry *bug)
+{
+	const char *format = NULL;
+#ifdef HAVE_ARCH_BUG_FORMAT
+#ifdef CONFIG_GENERIC_BUG_RELATIVE_POINTERS
+	format = (const char *)&bug->format_disp + bug->format_disp;
+#else
+	format = bug->format;
+#endif
+#endif
+	return format;
+}
+
 struct bug_entry *find_bug(unsigned long bugaddr)
 {
 	struct bug_entry *bug;
@@ -150,11 +163,19 @@ struct bug_entry *find_bug(unsigned long
 	return module_find_bug(bugaddr);
 }
 
+static void __warn_printf(const char *fmt)
+{
+	if (!fmt)
+		return;
+
+	printk("%s", fmt);
+}
+
 static enum bug_trap_type __report_bug(unsigned long bugaddr, struct pt_regs *regs)
 {
-	struct bug_entry *bug;
-	const char *file;
-	unsigned line, warning, once, done;
+	bool warning, once, done, no_cut, has_args;
+	const char *file, *fmt;
+	unsigned line;
 
 	if (!is_valid_bugaddr(bugaddr))
 		return BUG_TRAP_TYPE_NONE;
@@ -166,10 +187,12 @@ static enum bug_trap_type __report_bug(u
 	disable_trace_on_warning();
 
 	bug_get_file_line(bug, &file, &line);
+	fmt = bug_get_format(bug);
 
-	warning = (bug->flags & BUGFLAG_WARNING) != 0;
-	once = (bug->flags & BUGFLAG_ONCE) != 0;
-	done = (bug->flags & BUGFLAG_DONE) != 0;
+	warning  = bug->flags & BUGFLAG_WARNING;
+	once     = bug->flags & BUGFLAG_ONCE;
+	done     = bug->flags & BUGFLAG_DONE;
+	no_cut   = bug->flags & BUGFLAG_NO_CUT_HERE;
 
 	if (warning && once) {
 		if (done)
@@ -187,8 +210,10 @@ static enum bug_trap_type __report_bug(u
 	 * "cut here" line now. WARN() issues its own "cut here" before the
 	 * extra debugging message it writes before triggering the handler.
 	 */
-	if ((bug->flags & BUGFLAG_NO_CUT_HERE) == 0)
+	if (!no_cut) {
 		printk(KERN_DEFAULT CUT_HERE);
+		__warn_printf(fmt);
+	}
 
 	if (warning) {
 		/* this is a WARN_ON rather than BUG/BUG_ON */



