Return-Path: <linux-kernel+bounces-804499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA32BB477F7
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 00:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 688C3A40392
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 22:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90D62D948D;
	Sat,  6 Sep 2025 22:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s+u/DdSe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFE82D7DD5
	for <linux-kernel@vger.kernel.org>; Sat,  6 Sep 2025 22:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757197051; cv=none; b=YdtB8soS6kekxkAqPXNg6kM8kn6UcqR/zGl45lPpyQ7e07NVSlvkiN9lrpoaVpx6HHr9PfE4z435Z8lsZUqOyeoOuwvfSIvfY76xCNAYOpMvo14WhoQE+Qch3QlV8S6cNqv04lAHCIwFL85IwgQYp/vblkCbSCF+wQVh4A5ilW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757197051; c=relaxed/simple;
	bh=r4x5U9mBOCyJQpMNl8PcYf/G+baGUxDY9xHx07V6xVM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=p6cFS61GbM7gwMIt7VBbYJJekDPeXaGHXB7P/Tw+6Q56WHll/ItiURsdzu7QVWc6UH+1EgOuArJ+Tss+/zpWLvWqTuBh8ubHJ2NRI5cC+k98VQcibYd7YNta9+mSkjwhbDvniKBFGK5xtf5d3tmHtIx94sFwkcsdPgq8Y8JYMeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s+u/DdSe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65FB4C113D0;
	Sat,  6 Sep 2025 22:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757197051;
	bh=r4x5U9mBOCyJQpMNl8PcYf/G+baGUxDY9xHx07V6xVM=;
	h=Date:From:To:Cc:Subject:References:From;
	b=s+u/DdSesrSs+WrhDFQdR0/GjQVQKi27CoZ7UUcnFcwEGC+EvKSLV00ePWn3YlIya
	 tUiF6lyXRWo7kCsbuDDGIZpHhgaty8tgC8h1PY2bXJoDMGv1hy36F6DhtOCNmLlBLG
	 MtBWeP3JXURvXnmtZ1bdC3UlpFDkuG05QDrINdxG/OH0s8Msq11Qd53ePXqegXCnAP
	 a3RGIq5NWSPfjJ0z0oZM/LA/++7IMIuNtYiS6WVAhzzq6xR61VnOYLzzj6tf0fn7vz
	 BwLnDVCzTjFe8xs2zL75Ac4kzBXpRYd7fX68ihHWPhPb4lCOhsf4kSytmMnErdfaPl
	 3Pgf2oWWS1GsQ==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uv1Eb-00000006Uj9-1H1i;
	Sat, 06 Sep 2025 18:18:13 -0400
Message-ID: <20250906221813.158065018@kernel.org>
User-Agent: quilt/0.68
Date: Sat, 06 Sep 2025 18:17:56 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
  <tglozar@redhat.com>,
 Wang Liang <wangliang74@huawei.com>
Subject: [for-linus][PATCH 5/5] tracing/osnoise: Fix null-ptr-deref in bitmap_parselist()
References: <20250906221751.054623340@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Wang Liang <wangliang74@huawei.com>

A crash was observed with the following output:

BUG: kernel NULL pointer dereference, address: 0000000000000010
Oops: Oops: 0000 [#1] SMP NOPTI
CPU: 2 UID: 0 PID: 92 Comm: osnoise_cpus Not tainted 6.17.0-rc4-00201-gd69eb204c255 #138 PREEMPT(voluntary)
RIP: 0010:bitmap_parselist+0x53/0x3e0
Call Trace:
 <TASK>
 osnoise_cpus_write+0x7a/0x190
 vfs_write+0xf8/0x410
 ? do_sys_openat2+0x88/0xd0
 ksys_write+0x60/0xd0
 do_syscall_64+0xa4/0x260
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
 </TASK>

This issue can be reproduced by below code:

fd=open("/sys/kernel/debug/tracing/osnoise/cpus", O_WRONLY);
write(fd, "0-2", 0);

When user pass 'count=0' to osnoise_cpus_write(), kmalloc() will return
ZERO_SIZE_PTR (16) and cpulist_parse() treat it as a normal value, which
trigger the null pointer dereference. Add check for the parameter 'count'.

Cc: <mhiramat@kernel.org>
Cc: <mathieu.desnoyers@efficios.com>
Cc: <tglozar@redhat.com>
Link: https://lore.kernel.org/20250906035610.3880282-1-wangliang74@huawei.com
Fixes: 17f89102fe23 ("tracing/osnoise: Allow arbitrarily long CPU string")
Signed-off-by: Wang Liang <wangliang74@huawei.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_osnoise.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index fd259da0aa64..337bc0eb5d71 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -2322,6 +2322,9 @@ osnoise_cpus_write(struct file *filp, const char __user *ubuf, size_t count,
 	int running, err;
 	char *buf __free(kfree) = NULL;
 
+	if (count < 1)
+		return 0;
+
 	buf = kmalloc(count, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
-- 
2.50.1



