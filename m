Return-Path: <linux-kernel+bounces-835417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D98BA708C
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 14:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BF2A171D2A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 12:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 235652C21D4;
	Sun, 28 Sep 2025 12:46:59 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5CD1547F2
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 12:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759063618; cv=none; b=EAP3kadzX+Sxcd2s3F7NhPN3pxy055s2a4YWidnQ022W48jhN4s4kg7lX6Nu5Znuy/4BBYjuSGxnmih3vKeUuPRsU5WEtIV2O7jE1+FBDCj2LVKExDDDOo2067eIKfFMjNjRX8uEzbpQ1kuCqkB7gYkhxxmL3p4KNMEmmv/ljDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759063618; c=relaxed/simple;
	bh=6BTs4Cm7wKXvhNym4ewXDwxa/VVq9ZMe/4CGRZQtbOc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=WJdy0lRyy+8bj1HOT04WxWKynGcJk8Q4uco3OED0N14ajcU4DYS5bP3OVlRy4VTwg8iVyp/k91jrCVrtw8H9a37QQ6kXuMbrBbS7lzRE1qlOrNF9D7pZuu2owXkRQkEgajQS3dNCzMRtiG2CJeK0iVDWiExBYYBHNhxNMUgq3Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id A11E1442A3;
	Sun, 28 Sep 2025 12:46:48 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id EEC6917;
	Sun, 28 Sep 2025 12:46:45 +0000 (UTC)
Date: Sun, 28 Sep 2025 08:46:41 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Mark Rutland <mark.rutland@arm.com>, Wang Liang <wangliang74@huawei.com>
Subject: [GIT PULL] tracing: Fixes for v6.17
Message-ID: <20250928084641.7f90db4f@batman.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: ekhi1bwzh4991e4sz3oau3t4eocsk6zc
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: EEC6917
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/FxszMhfpXV7skJr0Tc8oQBxetxbYC97Y=
X-HE-Tag: 1759063605-524384
X-HE-Meta: U2FsdGVkX1/33nACOoL7JnoUH5kAWGuvFwMkJT2kbtslN+UhlUAX4+eHrTeCsqX9MXkZr76LLpyVuiRxKjshbT/SMrKhF3KlIIKhqyzGkT/5lXJOtgj2x9e7b5jKB1nIXGrPr7MD9Z/f5bApdHIlJP+2AD89xN4JZxmsgrcEvSkNhv0fG3IRlClXv5vWh6Rii8vP2R8l6S5eLZkMBtqpej+/SJ+U/qBtjrwDDrXm72qnFlxmzgJukJF3q93rBwSDzGn+oxRPulxztFkDKSRkZ0FBkJHfOVs/oWteNF8t7p5J7fKdzVtD/7awfjSs8o5AOZI0CNlVQ1vCaBKG9baqN12oATVTwwL/


Linus,

tracing fixes for v6.17

- Fix buffer overflow in osnoise_cpu_write()

  The allocated buffer to read user space did not add a nul terminating byte
  after copying from user the string. It then reads the string, and if user
  space did not add a nul byte, the read will continue beyond the string.
  Add a nul terminating byte after reading the string.

- Fix missing check for lockdown on tracing

  There's a path from kprobe events or uprobe events that can update the
  tracing system even if lockdown on tracing is activate. Add a check in the
  dynamic event path.

- Add a recursion check for the function graph return path

  Now that fprobes can hook to the function graph tracer and call different
  code between the entry and the exit, the exit code may now call functions
  that are not called in entry. This means that the exit handler can possibly
  trigger recursion that is not caught and cause the system to crash.
  Add the same recursion checks in the function exit handler as exists in the
  entry handler path.


Please pull the latest trace-v6.17-rc7 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-v6.17-rc7

Tag SHA1: 4bafc20386cc1bdcbd421fdf2e171b3943547b5b
Head SHA1: 0db0934e7f9bb624ed98a665890dbe249f65b8fd


Masami Hiramatsu (Google) (2):
      tracing: dynevent: Add a missing lockdown check on dynevent
      tracing: fgraph: Protect return handler from recursion loop

Wang Liang (1):
      tracing/osnoise: Fix slab-out-of-bounds in _parse_integer_limit()

----
 kernel/trace/fgraph.c         | 12 ++++++++++++
 kernel/trace/trace_dynevent.c |  4 ++++
 kernel/trace/trace_osnoise.c  |  3 ++-
 3 files changed, 18 insertions(+), 1 deletion(-)
---------------------------
diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 1e3b32b1e82c..484ad7a18463 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -815,6 +815,7 @@ __ftrace_return_to_handler(struct ftrace_regs *fregs, unsigned long frame_pointe
 	unsigned long bitmap;
 	unsigned long ret;
 	int offset;
+	int bit;
 	int i;
 
 	ret_stack = ftrace_pop_return_trace(&trace, &ret, frame_pointer, &offset);
@@ -829,6 +830,15 @@ __ftrace_return_to_handler(struct ftrace_regs *fregs, unsigned long frame_pointe
 	if (fregs)
 		ftrace_regs_set_instruction_pointer(fregs, ret);
 
+	bit = ftrace_test_recursion_trylock(trace.func, ret);
+	/*
+	 * This can fail because ftrace_test_recursion_trylock() allows one nest
+	 * call. If we are already in a nested call, then we don't probe this and
+	 * just return the original return address.
+	 */
+	if (unlikely(bit < 0))
+		goto out;
+
 #ifdef CONFIG_FUNCTION_GRAPH_RETVAL
 	trace.retval = ftrace_regs_get_return_value(fregs);
 #endif
@@ -852,6 +862,8 @@ __ftrace_return_to_handler(struct ftrace_regs *fregs, unsigned long frame_pointe
 		}
 	}
 
+	ftrace_test_recursion_unlock(bit);
+out:
 	/*
 	 * The ftrace_graph_return() may still access the current
 	 * ret_stack structure, we need to make sure the update of
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

