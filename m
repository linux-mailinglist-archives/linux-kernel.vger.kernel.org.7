Return-Path: <linux-kernel+bounces-778704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7001AB2E919
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 02:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E25F9AA4112
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 00:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7800286889;
	Thu, 21 Aug 2025 00:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aXjpn/BS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A5EF9D9
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 00:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755734411; cv=none; b=q7F9uQK+DI8/G1yY3+nGNCVIQVr0tOC7ZRN4OUPBnU6Oh5+38Rbvck6GxpUe+4x+m/zbJ2zBQEKPjadLBnbdMtbiJQDuHcqJ+Q1sxg6fjHAu9sXYA6twdmGJnMjYDZ+NRjloGMmsXGzD/Etx3xLqUa1l2ryeinz8GAR2pyB2vqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755734411; c=relaxed/simple;
	bh=qRdahZtrE1MjLGtmJge/76rAQHIUpe16QKO0WXYzzi8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ekt4t4mm6c61X9LUqd8PfSuOWFU8W5YYEJz0CtvWxPDjUV1BAK77c2nWd+XyO72xK9vyNLvNHwcreT9IY7swJEN5srWUJiUazJlNQ9VC1fsVM6KNe5wL0XaOLfs1lV+QGt6lhR3eSq0ad/OWZEQSM6NM9jjNIchZVJwgLOJmez0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aXjpn/BS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B388EC4CEE7;
	Thu, 21 Aug 2025 00:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755734411;
	bh=qRdahZtrE1MjLGtmJge/76rAQHIUpe16QKO0WXYzzi8=;
	h=Date:From:To:Cc:Subject:References:From;
	b=aXjpn/BSZzLCBIf3h/7okPkw2QhwL4Wh1VHzwRJ0M59H2+FKBtpnR1LXnBTsvErC/
	 DQETDoasMKRuUsM1UwLvt/BJHaHGUNUhqrgkOd8bAuMD8UlIE5fHga3+RU9JgP1kvH
	 9HcHSisuf3penDrVwlcxRAmlbWzrQ+216/abMm5vRAqbyJubLjK/vVFm/22Izc9gKu
	 34cK/0nmDXtjH3aqUFM1VwBnc8/27F0h8yqZqdf2hLcYAqgaUJQb4tb2g767AVKIBO
	 pMCtecl73oh6Igk4IaGYBXlLgoNnXYkf8Sglykvf0fX1vaGPu1gmXRDPBPDQZQi69i
	 9gWC3yL1KzE8A==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uosj1-000000013ei-0Xjn;
	Wed, 20 Aug 2025 20:00:15 -0400
Message-ID: <20250821000014.982314449@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 20 Aug 2025 20:00:05 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Ye Weihua <yeweihua4@huawei.com>
Subject: [for-linus][PATCH 5/6] trace/fgraph: Fix the warning caused by missing unregister notifier
References: <20250821000000.210778097@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Ye Weihua <yeweihua4@huawei.com>

This warning was triggered during testing on v6.16:

notifier callback ftrace_suspend_notifier_call already registered
WARNING: CPU: 2 PID: 86 at kernel/notifier.c:23 notifier_chain_register+0x44/0xb0
...
Call Trace:
 <TASK>
 blocking_notifier_chain_register+0x34/0x60
 register_ftrace_graph+0x330/0x410
 ftrace_profile_write+0x1e9/0x340
 vfs_write+0xf8/0x420
 ? filp_flush+0x8a/0xa0
 ? filp_close+0x1f/0x30
 ? do_dup2+0xaf/0x160
 ksys_write+0x65/0xe0
 do_syscall_64+0xa4/0x260
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

When writing to the function_profile_enabled interface, the notifier was
not unregistered after start_graph_tracing failed, causing a warning the
next time function_profile_enabled was written.

Fixed by adding unregister_pm_notifier in the exception path.

Link: https://lore.kernel.org/20250818073332.3890629-1-yeweihua4@huawei.com
Fixes: 4a2b8dda3f870 ("tracing/function-graph-tracer: fix a regression while suspend to disk")
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Ye Weihua <yeweihua4@huawei.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/fgraph.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index f4d200f0c610..2a42c1036ea8 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -1397,6 +1397,7 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 		ftrace_graph_active--;
 		gops->saved_func = NULL;
 		fgraph_lru_release_index(i);
+		unregister_pm_notifier(&ftrace_suspend_notifier);
 	}
 	return ret;
 }
-- 
2.50.1



