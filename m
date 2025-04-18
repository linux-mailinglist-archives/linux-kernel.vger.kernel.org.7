Return-Path: <linux-kernel+bounces-611095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77978A93CD4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Apr 2025 20:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CEB21B64046
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Apr 2025 18:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B842225A4F;
	Fri, 18 Apr 2025 18:33:47 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65C4224894
	for <linux-kernel@vger.kernel.org>; Fri, 18 Apr 2025 18:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745001226; cv=none; b=PKyoLHK1sAg8I9xB545s9TsD854ENaSvlaC+X8bJI2yZmF/ox9iq4kMqkpsGIYq6oi5P5MR9zrE+geB4yoDkYrfWjdwSTla3uFO4Q4pKVaDFtiUVyOu8hKb62tlC54hN9KzI6BId3SmFBhet1QpdSvmVARr4cavIqNc6FOtvz0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745001226; c=relaxed/simple;
	bh=S6+Kixs9MzJQRJqyOL1vA5/PhSdO6rHl/th6ek9UFsE=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=TmbBi8SQJj6o3FFk9GkJg/UH0+Il+TJ22eDM+yazKp235vPxDS6b4DWWR3L+Ns2ebPzUUmUDRq15ZfIcIO3Lana1/p1SB09l77+MYVF4t694B3z2ApwtQkXG3uG8EzmifN82MxFLZkpaPW9RH2x5iTLj3spmfFfE81JEXJRwWuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4707DC4CEEA;
	Fri, 18 Apr 2025 18:33:46 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1u5qYi-0000000Db7E-1AHc;
	Fri, 18 Apr 2025 14:35:28 -0400
Message-ID: <20250418183528.128091434@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 18 Apr 2025 14:34:47 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [for-linus][PATCH 1/7] ftrace: Initialize variables for ftrace_startup/shutdown_subops()
References: <20250418183446.383784216@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The reworking to fix and simplify the ftrace_startup_subops() and the
ftrace_shutdown_subops() made it possible for the filter_hash and
notrace_hash variables to be used uninitialized in a way that the compiler
did not catch it.

Initialize both filter_hash and notrace_hash to the EMPTY_HASH as that is
what they should be if they never are used.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/20250417104017.3aea66c2@gandalf.local.home
Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Fixes: 0ae6b8ce200d ("ftrace: Fix accounting of subop hashes")
Closes: https://lore.kernel.org/all/1db64a42-626d-4b3a-be08-c65e47333ce2@linux.ibm.com/
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index a8a02868b435..43394445390c 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -3490,8 +3490,8 @@ static int add_next_hash(struct ftrace_hash **filter_hash, struct ftrace_hash **
  */
 int ftrace_startup_subops(struct ftrace_ops *ops, struct ftrace_ops *subops, int command)
 {
-	struct ftrace_hash *filter_hash;
-	struct ftrace_hash *notrace_hash;
+	struct ftrace_hash *filter_hash = EMPTY_HASH;
+	struct ftrace_hash *notrace_hash = EMPTY_HASH;
 	struct ftrace_hash *save_filter_hash;
 	struct ftrace_hash *save_notrace_hash;
 	int ret;
@@ -3625,8 +3625,8 @@ static int rebuild_hashes(struct ftrace_hash **filter_hash, struct ftrace_hash *
  */
 int ftrace_shutdown_subops(struct ftrace_ops *ops, struct ftrace_ops *subops, int command)
 {
-	struct ftrace_hash *filter_hash;
-	struct ftrace_hash *notrace_hash;
+	struct ftrace_hash *filter_hash = EMPTY_HASH;
+	struct ftrace_hash *notrace_hash = EMPTY_HASH;
 	int ret;
 
 	if (unlikely(ftrace_disabled))
-- 
2.47.2



