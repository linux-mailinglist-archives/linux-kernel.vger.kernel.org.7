Return-Path: <linux-kernel+bounces-837957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30320BAE1F4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 19:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 113F819247C2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 17:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A434730E0D5;
	Tue, 30 Sep 2025 17:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJxa7Xig"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D19C30C605
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 17:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759251687; cv=none; b=E6oCD9EvVQC4x3xmsqdKruL2Muyz5mglvLg2UDaRHJ1Z2qexX1ehngOxR8Pp4ucv0/aK65BrM3e7bMo1d1yQCh0TD3wgwN/eGfADjsmzApk4HDw/Z6XmMlVbnTKo4CwISGtFlmHImwjt4zCSwTE8qDG9GjQmxA5CNmmfN9f4uh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759251687; c=relaxed/simple;
	bh=4WO7FoqGFohz7g21DYiHjK+J4HuZtWXe3wwp/JlD4sA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=S20ev5Gzh/6PAzONfgG3Ka72Ns/VAlWI2J/qX4yDffxZ9Lz0XclNLAPQpYufTev85cmMLwAiNumkdDczi5YXxqFx2fo3rwKrMSZa9qGSBd/4b1rOJz8dFtpEmG/0NV3JWchDp44QNOophl/xPsSuky1VxH9DJU9XGBfw8AoU0fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJxa7Xig; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20AF2C113D0;
	Tue, 30 Sep 2025 17:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759251687;
	bh=4WO7FoqGFohz7g21DYiHjK+J4HuZtWXe3wwp/JlD4sA=;
	h=Date:From:To:Cc:Subject:References:From;
	b=VJxa7XigX5CtShF+YJgYosNo6mbXSN3DO+rHrcTrukJnVLsS3Boll/dO8WEoL1Fcg
	 iCu1GU0qiG1i6Q4/2CiVYeGT7jJ5dbl37maUpRkH5WoN+rZdFMAWLBOj+A3XImdGzF
	 W2Z9zghxaBGQXLZD1pQL10VFvmcf2ByyooQuqL1G9kfV+h+/dj6oU9M3HdnOahK6dF
	 MQxEf1QsIQEwxI9J1bbLSTJNgtLN8m3NTZ2wBvjDZ5IBrxBQfAE1IHB/LM5Cj0AkHv
	 0UcRXoFxp/WTV0dZ0eDB8cBkr0DnrBuGfbMgHY5Dd8jF8MxnEDjz0z3j1ZHiFXTaoy
	 vJQBJMAcRsxfg==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1v3dkl-0000000DIKo-0pUc;
	Tue, 30 Sep 2025 13:03:03 -0400
Message-ID: <20250930170303.049610095@kernel.org>
User-Agent: quilt/0.68
Date: Tue, 30 Sep 2025 13:01:46 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sasha Levin <sashal@kernel.org>
Subject: [for-next][PATCH 11/11] tracing: Fix lock imbalance in s_start() memory allocation failure
 path
References: <20250930170135.285740909@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Sasha Levin <sashal@kernel.org>

When s_start() fails to allocate memory for set_event_iter, it returns NULL
before acquiring event_mutex. However, the corresponding s_stop() function
always tries to unlock the mutex, causing a lock imbalance warning:

  WARNING: bad unlock balance detected!
  6.17.0-rc7-00175-g2b2e0c04f78c #7 Not tainted
  -------------------------------------
  syz.0.85611/376514 is trying to release lock (event_mutex) at:
  [<ffffffff8dafc7a4>] traverse.part.0.constprop.0+0x2c4/0x650 fs/seq_file.c:131
  but there are no more locks to release!

The issue was introduced by commit b355247df104 ("tracing: Cache ':mod:'
events for modules not loaded yet") which added the kzalloc() allocation before
the mutex lock, creating a path where s_start() could return without locking
the mutex while s_stop() would still try to unlock it.

Fix this by unconditionally acquiring the mutex immediately after allocation,
regardless of whether the allocation succeeded.

Link: https://lore.kernel.org/20250929113238.3722055-1-sashal@kernel.org
Fixes: b355247df104 ("tracing: Cache ":mod:" events for modules not loaded yet")
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 9f3e9537417d..e00da4182deb 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -1629,11 +1629,10 @@ static void *s_start(struct seq_file *m, loff_t *pos)
 	loff_t l;
 
 	iter = kzalloc(sizeof(*iter), GFP_KERNEL);
+	mutex_lock(&event_mutex);
 	if (!iter)
 		return NULL;
 
-	mutex_lock(&event_mutex);
-
 	iter->type = SET_EVENT_FILE;
 	iter->file = list_entry(&tr->events, struct trace_event_file, list);
 
-- 
2.50.1



