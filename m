Return-Path: <linux-kernel+bounces-835392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7B9BA6F98
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 13:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 053EA189A6BA
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 11:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2E02DE6FA;
	Sun, 28 Sep 2025 11:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rSUOVmkU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F81F29B8DB
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 11:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759057651; cv=none; b=BtGm/cd3RpQjNgV8mwySslw4oEToY2ib/XkRc9aA9loqdw6bYaI/qDp/nQSTsKPdMJMajIp7w+jjb1dKu6Ssm7rl950k2dQAs/f/rk3vfvizax0YcoTlpndBBO0RxWXIEYhhhQX/yDzYxlFKk3/h+DPa7FWW/s0+lTZBcWHgULM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759057651; c=relaxed/simple;
	bh=ewVGJq+QJP4csNVsGgOl12Ybz1EYVG1eW4tyS3tccLo=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=vB5ulMA2SvmadEjRIzedSMSN/Q7QQp45dVFN+jB/V58h1ILRlnGbhJ137ND3sxsLvRqUCdNCFc/OnwoHhVBugwgFm0CDeEBKn9DlE1Ln5kjEVxC+WxXKeSB/DYUyXHqMXHZWRwuiyviSCbS02TsQ+k5vR3zp8P32FMWr1cOUQVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rSUOVmkU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8A9EC4CEF7;
	Sun, 28 Sep 2025 11:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759057651;
	bh=ewVGJq+QJP4csNVsGgOl12Ybz1EYVG1eW4tyS3tccLo=;
	h=Date:From:To:Cc:Subject:References:From;
	b=rSUOVmkUZs8TuPyOqTtKKFD4FmSzwqSkZi09hWWYNk74gUIvqXeTcllPaO+TeYw5J
	 lV2kFE5DJ1pjMm5C7NWzBQFru20JqkGnln7rsLoCWlZ/9+VolTwIUujBCqVLU6AAWu
	 KykQD9vHskkGnyf1pKR4UCIZlscWiGTUfzaYFTUHVplVFU4uRZ39OnStaITy1pEV5Q
	 R9szgNXDM5PR6CQJJ2obHtBhh7dHzqBAXk6EQZCGSd94MxOHIKwgzd6UvuCpmXQ/lC
	 aziIjvupkI3WqbdvhsKkjtDrtgxhTjf9S124gUIdCqfNryVWWg78cmFGDWAIsE1qDE
	 isuPfAvD+AjTw==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1v2pH3-0000000D8OP-3rMt;
	Sun, 28 Sep 2025 07:09:01 -0400
Message-ID: <20250928110901.771253495@kernel.org>
User-Agent: quilt/0.68
Date: Sun, 28 Sep 2025 07:08:34 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Wang Liang <wangliang74@huawei.com>
Subject: [for-linus][PATCH 2/3] tracing: dynevent: Add a missing lockdown check on dynevent
References: <20250928110832.098564441@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>

Since dynamic_events interface on tracefs is compatible with
kprobe_events and uprobe_events, it should also check the lockdown
status and reject if it is set.

Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/175824455687.45175.3734166065458520748.stgit@devnote2
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_dynevent.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/trace/trace_dynevent.c b/kernel/trace/trace_dynevent.c
index 5d64a18cacac..d06854bd32b3 100644
--- a/kernel/trace/trace_dynevent.c
+++ b/kernel/trace/trace_dynevent.c
@@ -230,6 +230,10 @@ static int dyn_event_open(struct inode *inode, struct file *file)
 {
 	int ret;
 
+	ret = security_locked_down(LOCKDOWN_TRACEFS);
+	if (ret)
+		return ret;
+
 	ret = tracing_check_open_get_tr(NULL);
 	if (ret)
 		return ret;
-- 
2.50.1



