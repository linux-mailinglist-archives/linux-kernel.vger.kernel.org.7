Return-Path: <linux-kernel+bounces-835391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 996ECBA6F95
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 13:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24C9217B63B
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 11:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA59D2DCF7D;
	Sun, 28 Sep 2025 11:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oCOg9QzB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BD32367CD
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 11:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759057651; cv=none; b=K+P6sob280CElo6bvUhxa0MQCC7Zw0PyH/ADDu8CLHGjKMY6xA56padAbRPk0F3fkP6ivhVc0Cgyh5GR2vkKRWzomFfkvgYLmHjyU/lgUaQzVcGMlUCkK2+oFiZ9MbUBNTI+8jcjNypnce0GM7iikOCQRnEI3bhTXXWb1p2Xcy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759057651; c=relaxed/simple;
	bh=w0jY2GiWIKqpl4Xo1guhgWUkz5f967BVVQYVYTFIcT0=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=HKU36XsLlc05z2DIR9h0SBQgDQZjkaRM/r3nV5MsEsXqlPBWXE5rh2t8wsv459tlvPkUtXYKb3AfXuguOjF0yPZlhNHiE6shat3Mo6NziMvC7LrBgBNJ9cR096M+aouk4PJqjEL6gzOqDSt8DBmtslzs36dwrhKC4Vlr3I6eaDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oCOg9QzB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D86C6C116B1;
	Sun, 28 Sep 2025 11:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759057650;
	bh=w0jY2GiWIKqpl4Xo1guhgWUkz5f967BVVQYVYTFIcT0=;
	h=Date:From:To:Cc:Subject:References:From;
	b=oCOg9QzBy1AsHTluIFWUpDl6ZVQz2BUAETvTeKjoaiBH0Qy3lND6N5mxXg5SmZLf8
	 PcqA1GreWunLzdZgbqnxnDUEq9+JGHhpC/YeYK6Ql+u+1Cl/AEO34v7H6n9CycHg7m
	 CVXSs8vP1dukzHtZONOJvIOPmDw3UBSyx7X29vF0nQmES+qz9tsriYh/kSD+eRk2Ly
	 8SGvEoDHMv+bQDseTC+/JodOu6o7JQv/VxLLamk8xLvxh6j7psNHIPVtfH+a0bAE+w
	 rjfSFcVjMhCv2KXjrZ11mYk4EAXV86cLbbNmrkmLos19oSJQrM1XCR//G5lJrXhKL2
	 UG/SOeh7nfasg==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1v2pH3-0000000D8Nt-39G0;
	Sun, 28 Sep 2025 07:09:01 -0400
Message-ID: <20250928110901.602250662@kernel.org>
User-Agent: quilt/0.68
Date: Sun, 28 Sep 2025 07:08:33 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Wang Liang <wangliang74@huawei.com>,
  <tglozar@redhat.com>
Subject: [for-linus][PATCH 1/3] tracing/osnoise: Fix slab-out-of-bounds in _parse_integer_limit()
References: <20250928110832.098564441@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Wang Liang <wangliang74@huawei.com>

When config osnoise cpus by write() syscall, the following KASAN splat may
be observed:

BUG: KASAN: slab-out-of-bounds in _parse_integer_limit+0x103/0x130
Read of size 1 at addr ffff88810121e3a1 by task test/447
CPU: 1 UID: 0 PID: 447 Comm: test Not tainted 6.17.0-rc6-dirty #288 PREEMPT(voluntary)
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x55/0x70
 print_report+0xcb/0x610
 kasan_report+0xb8/0xf0
 _parse_integer_limit+0x103/0x130
 bitmap_parselist+0x16d/0x6f0
 osnoise_cpus_write+0x116/0x2d0
 vfs_write+0x21e/0xcc0
 ksys_write+0xee/0x1c0
 do_syscall_64+0xa8/0x2a0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
 </TASK>

This issue can be reproduced by below code:

const char *cpulist = "1";
int fd=open("/sys/kernel/debug/tracing/osnoise/cpus", O_WRONLY);
write(fd, cpulist, strlen(cpulist));

Function bitmap_parselist() was called to parse cpulist, it require that
the parameter 'buf' must be terminated with a '\0' or '\n'. Fix this issue
by adding a '\0' to 'buf' in osnoise_cpus_write().

Cc: <mhiramat@kernel.org>
Cc: <mathieu.desnoyers@efficios.com>
Cc: <tglozar@redhat.com>
Link: https://lore.kernel.org/20250916063948.3154627-1-wangliang74@huawei.com
Fixes: 17f89102fe23 ("tracing/osnoise: Allow arbitrarily long CPU string")
Signed-off-by: Wang Liang <wangliang74@huawei.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_osnoise.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 337bc0eb5d71..dc734867f0fc 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -2325,12 +2325,13 @@ osnoise_cpus_write(struct file *filp, const char __user *ubuf, size_t count,
 	if (count < 1)
 		return 0;
 
-	buf = kmalloc(count, GFP_KERNEL);
+	buf = kmalloc(count + 1, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 
 	if (copy_from_user(buf, ubuf, count))
 		return -EFAULT;
+	buf[count] = '\0';
 
 	if (!zalloc_cpumask_var(&osnoise_cpumask_new, GFP_KERNEL))
 		return -ENOMEM;
-- 
2.50.1



