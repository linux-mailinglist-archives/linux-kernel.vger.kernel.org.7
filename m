Return-Path: <linux-kernel+bounces-837952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30695BAE1EE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 19:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31EDC189253A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 17:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C58A30DEDD;
	Tue, 30 Sep 2025 17:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQyADnxj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBBE30BF62
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 17:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759251686; cv=none; b=Y6vFuv4rjUzZqKgT8sutCcqLxygFYYDjIsfR16JJYWawt8M3SJKeUZJQWvlnlTOLBjCKBDBrMLGgYflvskUptMfNxbB9/9KHACDLB6aDv88YZ9ucFgAPUlpCPgOe/goF6XzMESEiImE5BEpC6GPrHg3BpmmqQQ56EcozsduqQtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759251686; c=relaxed/simple;
	bh=HeSHLMhtFrWa6uet7G3GDqFuRbBCaqAnnR7g3BuXQrw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=p8QIrSDaaKtPKYq9KJmnptcoLRwkTai2/7jRHiq2G0MgBBLi7jTcyHNB3vK+9CzPGccw6tNeiMDegFZHdfrF9OmWFfTsjYB2GLmYhMYXrKnaiuAe5KVz9bpOcnYw61LsYu3bTECaRVArAp8aTCkiqQRQRO+BURqN6QEMMMQerJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQyADnxj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49CD7C4CEF0;
	Tue, 30 Sep 2025 17:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759251686;
	bh=HeSHLMhtFrWa6uet7G3GDqFuRbBCaqAnnR7g3BuXQrw=;
	h=Date:From:To:Cc:Subject:References:From;
	b=YQyADnxj+o0mcPyYlC12dUrHXVsDeJ4LwDKGHGnAjHSrmmb4bFC8Rc5RyiWREZ8ox
	 61pZedp3pL1/nktgVAA1FGwgHLtUG422IuTkxlmrI2eKnJ7sttirQ08OrrPxH63L8K
	 DWnB0GojUbli5Oj4wVaj9m093oa/KFi9YnnoOXwY0QCcrpC9ISuQ1omctXsIE9c/Vs
	 7agQJhybYN6xZbh670Oi//Va/LXH1GjSooyNOgZRmTXF4FyAELHhbi/nHVxFyEuw5b
	 KbrZ/Xtcz4wSe/qwFWdChC30XCbS918GX/nTxfsXF9MqygSucQj/Ii75DxB/UnjosR
	 qqYvhCmduJyrg==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1v3dkk-0000000DIII-1U8z;
	Tue, 30 Sep 2025 13:03:02 -0400
Message-ID: <20250930170302.206716475@kernel.org>
User-Agent: quilt/0.68
Date: Tue, 30 Sep 2025 13:01:41 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [for-next][PATCH 06/11] tracing: Remove redundant 0 value initialization
References: <20250930170135.285740909@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Liao Yuanhong <liaoyuanhong@vivo.com>

The saved_cmdlines_buffer struct is already zeroed by memset(). It's
redundant to initialize s->cmdline_idx to 0.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/20250825123200.306272-1-liaoyuanhong@vivo.com
Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_sched_switch.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/trace/trace_sched_switch.c b/kernel/trace/trace_sched_switch.c
index cb49f7279dc8..518dfc74347a 100644
--- a/kernel/trace/trace_sched_switch.c
+++ b/kernel/trace/trace_sched_switch.c
@@ -224,7 +224,6 @@ static struct saved_cmdlines_buffer *allocate_cmdlines_buffer(unsigned int val)
 	/* Place map_cmdline_to_pid array right after saved_cmdlines */
 	s->map_cmdline_to_pid = (unsigned *)&s->saved_cmdlines[val * TASK_COMM_LEN];
 
-	s->cmdline_idx = 0;
 	memset(&s->map_pid_to_cmdline, NO_CMDLINE_MAP,
 	       sizeof(s->map_pid_to_cmdline));
 	memset(s->map_cmdline_to_pid, NO_CMDLINE_MAP,
-- 
2.50.1



