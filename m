Return-Path: <linux-kernel+bounces-754182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F03B18F65
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 18:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EF2A64E0531
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 16:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE91259CA0;
	Sat,  2 Aug 2025 16:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GrkrbGjl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D1F24EA90
	for <linux-kernel@vger.kernel.org>; Sat,  2 Aug 2025 16:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754152086; cv=none; b=uyzRehfpxOjGojkB/VlzqRQXnk5sCQU3hyUZX78cJihI/p688vahww27tPPp6IE/NbBUA0qrKz+zRhBszeiHcwJWVr0m0pIo9VoPBA8a17SwB+IW/MQoCNyWa5tqME219XPikIjwHiO5JJMO0wqvxCv7H9W+PBoPwKqT5rV9tGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754152086; c=relaxed/simple;
	bh=aNxb/w71zKLtiJLZXZgqTtiWzyS5SfOcqnyHy7m43hM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=JCyhRXH3HQxGH8X4HF+yNIB52Dw8fWlWzbi3tauL04Rdfcm8FRJcjA3Eft3KO7mbVC/bOjOxPhbGRcizRkVZ187xm8fEL60TBnRCiWF80lvgv70Y48kH6a1jdeYw5Wrh/CfH3lyvQC1S/OqDUFuERTA5MnTrxec8cvPMum+uCAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GrkrbGjl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ABCAC4CEFC;
	Sat,  2 Aug 2025 16:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754152086;
	bh=aNxb/w71zKLtiJLZXZgqTtiWzyS5SfOcqnyHy7m43hM=;
	h=Date:From:To:Cc:Subject:References:From;
	b=GrkrbGjlH21mkaPauHlUyRaU400xdYzQq7FQcQBjMWY4dcWiXaUFnIl59IS/s5gWs
	 ThGjwe8Fkgrgy2lrcP29zAnesPLX1DlxxTj2Q3g29C5mE/ww+DqtLQi7HOj+xvQn08
	 NBrZiv5ivWfB6Mz/Adgy70xzebl7HipMpu9lHKZGfTHjSIS/GJboGQpoAx2Xd6xHGN
	 DD2OB2Gb+ahBlGOEzf4Wx35LsIUmYlNzz9i6szZ+ouOpsQd+M0AlnK67UHsSOhp4rg
	 zzn/EOXGTqe2adyIeGy+34Vo84Knv9syZU7B804SVIniAyMpYAXTLQQUzrJwKPq2cz
	 d/AEqb3bD/qvA==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uiF5x-00000008SYa-3YHw;
	Sat, 02 Aug 2025 12:28:29 -0400
Message-ID: <20250802162829.701657120@kernel.org>
User-Agent: quilt/0.68
Date: Sat, 02 Aug 2025 12:27:39 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 5/6] ring-buffer: Convert ring_buffer_write() to use
 guard(preempt_notrace)
References: <20250802162734.529626660@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The function ring_buffer_write() has a goto out to only do a
preempt_enable_notrace(). This can be replaced by a guard.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Link: https://lore.kernel.org/20250801203858.205479143@kernel.org
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 00fc38d70e86..9d7bf17fbfba 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -4714,26 +4714,26 @@ int ring_buffer_write(struct trace_buffer *buffer,
 	int ret = -EBUSY;
 	int cpu;
 
-	preempt_disable_notrace();
+	guard(preempt_notrace)();
 
 	if (atomic_read(&buffer->record_disabled))
-		goto out;
+		return -EBUSY;
 
 	cpu = raw_smp_processor_id();
 
 	if (!cpumask_test_cpu(cpu, buffer->cpumask))
-		goto out;
+		return -EBUSY;
 
 	cpu_buffer = buffer->buffers[cpu];
 
 	if (atomic_read(&cpu_buffer->record_disabled))
-		goto out;
+		return -EBUSY;
 
 	if (length > buffer->max_data_size)
-		goto out;
+		return -EBUSY;
 
 	if (unlikely(trace_recursive_lock(cpu_buffer)))
-		goto out;
+		return -EBUSY;
 
 	event = rb_reserve_next_event(buffer, cpu_buffer, length);
 	if (!event)
@@ -4751,10 +4751,6 @@ int ring_buffer_write(struct trace_buffer *buffer,
 
  out_unlock:
 	trace_recursive_unlock(cpu_buffer);
-
- out:
-	preempt_enable_notrace();
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(ring_buffer_write);
-- 
2.47.2



