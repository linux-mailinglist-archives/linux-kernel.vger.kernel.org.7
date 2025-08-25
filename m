Return-Path: <linux-kernel+bounces-783925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB2AB33462
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 05:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0715E1707C5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 03:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6188D38DD8;
	Mon, 25 Aug 2025 03:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="QjGdK763"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851C1393DCC
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 03:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756090951; cv=none; b=Fnb/gVzlwon2pdAZkFD6yaz9gQoPP4ioViLba4f1Pawu52xELKssyAkSaFaPOLu2f51CMnq5RPE554rHx7VBvdHIWk67r8RlaLLIYqso7C9iHFR6CMoJWSLV7l76vhaYGQNFVwC/zTctVfdX9MwkQrlaXF4fA+j0GWyQkbv5tCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756090951; c=relaxed/simple;
	bh=R6KmWkGVXNO5WRrr5YpP2XcZK6tqzKdp71H2IrZyk6U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QFhPFl4Si/OpwiBhGmggH3tfluDQB5I1iLFZJoYoL8z5LPF0z5QfKuzH8Q/Nf3pBxRAA7QoY8YwCCePrcgXh52YcpAjv/OAmCR4Kqr2Ci4qGvHIBpxC3y4LbGIsJZP8caDCaTRl7UlMS7qa82BwrR2plaA1jmcnhhil2jHNcgUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=QjGdK763; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1756090941; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=tUn2iYdBZOhBQjTOKqXwBVKONJFvUr1wfQQXdvlwzF8=;
	b=QjGdK7638HtUuh2Hhrt1rvHGTWodfGBJx53dLFjVZ1HIcyeiLO5iZdQe6bhOOg1vdH28xk50j2ht3fQxnn+YFw+fEyx0D40A/njYHWq3tZ/0VQIs0ZWwnvum7aG7EF16HwaclQbdlSQytxQQZmARvFX1Do4jivhz3YerCcUUitY=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0WmPuXGx_1756090623 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 25 Aug 2025 10:57:04 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lance Yang <lance.yang@linux.dev>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-kernel@vger.kernel.org
Cc: Askar Safin <safinaskar@zohomail.com>,
	paulmck@kernel.org,
	john.ogness@linutronix.de,
	Feng Tang <feng.tang@linux.alibaba.com>
Subject: [PATCH v2 2/4] panic: refine the document for 'panic_print'
Date: Mon, 25 Aug 2025 10:56:59 +0800
Message-Id: <20250825025701.81921-3-feng.tang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250825025701.81921-1-feng.tang@linux.alibaba.com>
References: <20250825025701.81921-1-feng.tang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

User reported current document about SYS_INFO_PANIC_CONSOLE_REPLAY
is confusing, that people could expect all user space console messages
to be replayed.

Specify that only 'kernel' messages will be replayed to solve the confusion.

Reported-by: Askar Safin <safinaskar@zohomail.com>
Signed-off-by: Feng Tang <feng.tang@linux.alibaba.com>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 2 +-
 Documentation/admin-guide/sysctl/kernel.rst     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 747a55abf494..86f395f2933b 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4589,7 +4589,7 @@
 			bit 2: print timer info
 			bit 3: print locks info if CONFIG_LOCKDEP is on
 			bit 4: print ftrace buffer
-			bit 5: replay all messages on consoles at the end of panic
+			bit 5: replay all kernel messages on consoles at the end of panic
 			bit 6: print all CPUs backtrace (if available in the arch)
 			bit 7: print only tasks in uninterruptible (blocked) state
 			*Be aware* that this option may print a _lot_ of lines,
diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index 8b49eab937d0..f3ee807b5d8b 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -890,7 +890,7 @@ bit 1  print system memory info
 bit 2  print timer info
 bit 3  print locks info if ``CONFIG_LOCKDEP`` is on
 bit 4  print ftrace buffer
-bit 5  replay all messages on consoles at the end of panic
+bit 5  replay all kernel messages on consoles at the end of panic
 bit 6  print all CPUs backtrace (if available in the arch)
 bit 7  print only tasks in uninterruptible (blocked) state
 =====  ============================================
-- 
2.39.5 (Apple Git-154)


