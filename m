Return-Path: <linux-kernel+bounces-632899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67375AA9E01
	for <lists+linux-kernel@lfdr.de>; Mon,  5 May 2025 23:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52B2D17F643
	for <lists+linux-kernel@lfdr.de>; Mon,  5 May 2025 21:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED49279334;
	Mon,  5 May 2025 21:22:31 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13816276046;
	Mon,  5 May 2025 21:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746480150; cv=none; b=DRnALTZN6L6xHnnG+mZKkGr0s+8fUMNilKa/8/JMeTWSrWHT0U/db859DSj1oMnoNSwiCCB4gIQWDd0EnjsVIhYQKqW+6M2uqmL9b04dMqWn+jyuTBStf4y8ktb5K7FbXld1oZ52sg9KCHO7dqV9VjloS3UD0sL4Dqw+68WzouY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746480150; c=relaxed/simple;
	bh=DBxt4t6Rrj4G2JNo0WXoN5xIbZVuiCWQuVMsCr/1jl4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=S+a0VIQFh69dcl8K3HVIGtRebr6jUt+qv3DGKL50HI7KeT4eXAuX57M5YkDqkFXKDQufHiM+1ugh9icOgRU5iLJXV9p+0fhTT0XDwAYA7rEFv7Z3UlvvuiG7r1zdpeqaaKWuDre8hoHYMwHOGwqGqO9d4rU2oFkjWC2KMvLKlY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3EF4C4CEED;
	Mon,  5 May 2025 21:22:29 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uC3Gm-00000000yHF-3ipV;
	Mon, 05 May 2025 17:22:36 -0400
Message-ID: <20250505212236.738849456@goodmis.org>
User-Agent: quilt/0.68
Date: Mon, 05 May 2025 17:21:17 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 13/13] tracing: Remove unused buffer_page field from trace_array_cpu
 structure
References: <20250505212104.986494754@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The trace_array_cpu had a "buffer_page" field that was originally going to
be used as a backup page for the ring buffer. But the ring buffer has its
own way of reusing pages and this field was never used.

Remove it.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 188032d4ab69..4e67ee92e05c 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -184,7 +184,6 @@ struct trace_array;
  */
 struct trace_array_cpu {
 	local_t			disabled;
-	void			*buffer_page;	/* ring buffer spare */
 
 	unsigned long		entries;
 	unsigned long		saved_latency;
-- 
2.47.2



