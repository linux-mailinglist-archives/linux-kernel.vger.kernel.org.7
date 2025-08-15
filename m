Return-Path: <linux-kernel+bounces-770357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A788B279F8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 09:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88E7EBA081C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 07:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9559D259CA1;
	Fri, 15 Aug 2025 07:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="WGzONB7y"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AD32D0C81
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 07:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755242081; cv=none; b=JaJGyfCS/iLF/g8RKlWD4dg8k9jTa9YXQH51LNFuvZ3+juYhKrdYlCk+o4Y7mqOjDCa65WOyj//EuQm8pPo+aM4Phs5p7ITPriPNglztBGfjbFMC9YMFdSpBvJ/o+clb9kRKDR5rCVA1rZKusB1BBKN2qoEoVAe/pI2cqgAOF0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755242081; c=relaxed/simple;
	bh=8iCGFRXdjEcgH8jFuaZvEErSEaJbgl0fzstP/xAk8B0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=exol1xBTu0Fl+LRRZXC4olDHvJtF4+E5qVJkVusG41KvTfgrnDbo71IM13UGHgm6TpfRMVrIynMwCHvA2F9rQEMIRSt7P3+lho2E8eDSI882LzkUjK2SwgBVJWXg1aCcK0cwh7XmCFP9D1uIcddv0ufLkza0Q3NrVryu9WJR7zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=WGzONB7y; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1755242071; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=uMCX/8fDc/68HLhW5LBxhhq0Ib6EqFg3uQ/2lz4dZcc=;
	b=WGzONB7yBrw4Yit5ezgd+ZyifkEyUHleG/gktnJe5vDbDjZfmntM3VAqK0eswZ6BqbjwfcW+MeyjZT54LvdhnpTaehOCb/Rvv362sKkRVGC0JffhsdrrtkmVPCrBP7HBKQcgr+oNbiiFbNZEs7Im2CdBmLYXY1H08pH8JBojlM8=
Received: from localhost(mailfrom:feng.tang@linux.alibaba.com fp:SMTPD_---0WloF6Li_1755242070 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 15 Aug 2025 15:14:30 +0800
From: Feng Tang <feng.tang@linux.alibaba.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Lance Yang <lance.yang@linux.dev>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-kernel@vger.kernel.org
Cc: paulmck@kernel.org,
	john.ogness@linutronix.de,
	Feng Tang <feng.tang@linux.alibaba.com>,
	Askar Safin <safinaskar@zohomail.com>
Subject: [PATCH 2/3] panic: refine the document for 'panic_print'
Date: Fri, 15 Aug 2025 15:14:27 +0800
Message-Id: <20250815071428.98041-3-feng.tang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250815071428.98041-1-feng.tang@linux.alibaba.com>
References: <20250815071428.98041-1-feng.tang@linux.alibaba.com>
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
2.43.5


