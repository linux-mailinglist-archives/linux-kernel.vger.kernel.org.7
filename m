Return-Path: <linux-kernel+bounces-754180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC21B18F62
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 18:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 439A2189BC10
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 16:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF24251799;
	Sat,  2 Aug 2025 16:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ee1n5DcT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DE9248F7A
	for <linux-kernel@vger.kernel.org>; Sat,  2 Aug 2025 16:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754152086; cv=none; b=LZcCsLL3QiflGPjcelzkDIjERBiTGUUERvAbMRCmV6NmGmll7/0R7vN6VcKhcnMh1q6zX7z6Gwm1cKMaEylNDYtBd+/vIKWzDBhf+JWKKAIbuqMdB3bTxRXgcufdly5MLUBLG7xEISHNJ+CJdAAB1t1cEDeqVafTCqtNLIZlEj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754152086; c=relaxed/simple;
	bh=/X/3LJzyJmj4yt21bKc0lShFVhAXzhSf2zE7HC3zBXI=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=M54yLDHfoVJA+HhVbiGxpW9xdhMY7fvOElhz0rxrtxW2hP5UhNmiSUokclQ2VsPx7tD69jCW0GljdepBSArONFZR0H4hmC3aDVMsMv0fuBDg4ijBv62Gh9HE6o/YMGJcEqJfxzd0FI9sj8N7yExTNZK8J5lgq/sMbZg3YzQzhgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ee1n5DcT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3155DC4CEFB;
	Sat,  2 Aug 2025 16:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754152086;
	bh=/X/3LJzyJmj4yt21bKc0lShFVhAXzhSf2zE7HC3zBXI=;
	h=Date:From:To:Cc:Subject:References:From;
	b=ee1n5DcTNsLBF5xtrz5TKrFCgLphP1UnlH7e9He+peyGKZVlBLech0qqmHr9Bgi/D
	 YXdOFJKUA7UGLGJ/EoC+BnVvEjCnon1nzkE23REhbKbHz4wEDOFeJXBBGiRcWtfyyi
	 LTJ2Z5yoMlxGzBGyFtLmjC6WqOOe1uqJQPS5D0jojp3218tDURx61Mj1Ob76efPqMK
	 /FTrLEF9el1JrVoYY5Tj4bmtPtboT32RLsi4Bh6ZsylI97pONDsYfpcObbYtZLjLN2
	 OAx9jJQMRLS/Ojtt4dNOqjGf5mD9Uiv3eljaSVpMbXGVajGHEs1/o4JzlvmW6NGuw8
	 VpSpOPl+B4Z/A==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uiF5x-00000008SY5-2rdz;
	Sat, 02 Aug 2025 12:28:29 -0400
Message-ID: <20250802162829.535471385@kernel.org>
User-Agent: quilt/0.68
Date: Sat, 02 Aug 2025 12:27:38 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 4/6] tracing: Use __free(kfree) in trace.c to remove gotos
References: <20250802162734.529626660@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

There's a couple of locations that have goto out in trace.c for the only
purpose of freeing a variable that was allocated. These can be replaced
with __free(kfree).

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Link: https://lore.kernel.org/20250801203858.040892777@kernel.org
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 36 ++++++++++++------------------------
 1 file changed, 12 insertions(+), 24 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 4299e89ed04e..d0b1964648c1 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5042,7 +5042,7 @@ tracing_cpumask_read(struct file *filp, char __user *ubuf,
 		     size_t count, loff_t *ppos)
 {
 	struct trace_array *tr = file_inode(filp)->i_private;
-	char *mask_str;
+	char *mask_str __free(kfree) = NULL;
 	int len;
 
 	len = snprintf(NULL, 0, "%*pb\n",
@@ -5053,16 +5053,10 @@ tracing_cpumask_read(struct file *filp, char __user *ubuf,
 
 	len = snprintf(mask_str, len, "%*pb\n",
 		       cpumask_pr_args(tr->tracing_cpumask));
-	if (len >= count) {
-		count = -EINVAL;
-		goto out_err;
-	}
-	count = simple_read_from_buffer(ubuf, count, ppos, mask_str, len);
-
-out_err:
-	kfree(mask_str);
+	if (len >= count)
+		return -EINVAL;
 
-	return count;
+	return simple_read_from_buffer(ubuf, count, ppos, mask_str, len);
 }
 
 int tracing_set_cpumask(struct trace_array *tr,
@@ -10739,7 +10733,8 @@ ssize_t trace_parse_run_command(struct file *file, const char __user *buffer,
 				size_t count, loff_t *ppos,
 				int (*createfn)(const char *))
 {
-	char *kbuf, *buf, *tmp;
+	char *kbuf __free(kfree) = NULL;
+	char *buf, *tmp;
 	int ret = 0;
 	size_t done = 0;
 	size_t size;
@@ -10754,10 +10749,9 @@ ssize_t trace_parse_run_command(struct file *file, const char __user *buffer,
 		if (size >= WRITE_BUFSIZE)
 			size = WRITE_BUFSIZE - 1;
 
-		if (copy_from_user(kbuf, buffer + done, size)) {
-			ret = -EFAULT;
-			goto out;
-		}
+		if (copy_from_user(kbuf, buffer + done, size))
+			return -EFAULT;
+
 		kbuf[size] = '\0';
 		buf = kbuf;
 		do {
@@ -10773,8 +10767,7 @@ ssize_t trace_parse_run_command(struct file *file, const char __user *buffer,
 					/* This can accept WRITE_BUFSIZE - 2 ('\n' + '\0') */
 					pr_warn("Line length is too long: Should be less than %d\n",
 						WRITE_BUFSIZE - 2);
-					ret = -EINVAL;
-					goto out;
+					return -EINVAL;
 				}
 			}
 			done += size;
@@ -10787,17 +10780,12 @@ ssize_t trace_parse_run_command(struct file *file, const char __user *buffer,
 
 			ret = createfn(buf);
 			if (ret)
-				goto out;
+				return ret;
 			buf += size;
 
 		} while (done < count);
 	}
-	ret = done;
-
-out:
-	kfree(kbuf);
-
-	return ret;
+	return done;
 }
 
 #ifdef CONFIG_TRACER_MAX_TRACE
-- 
2.47.2



