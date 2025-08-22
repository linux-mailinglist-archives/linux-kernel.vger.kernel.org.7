Return-Path: <linux-kernel+bounces-782473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D95E4B320C8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 18:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C9B16225FE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 16:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814A0302740;
	Fri, 22 Aug 2025 16:49:41 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1D6222593
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 16:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755881380; cv=none; b=WwE98m42uvNrsvmsJq8EzejGVxjWAk4x1WMEY4+F6nLHW2ppwftxLAMWGSeJ9qeqhuzOMZjC5CatBzBm55PA6IyeDpk42tEUl2UZyQBVc2hmJBLm5dTubUQimvR6HFp8LQEeH2UbV2Zte6ndyT7EyP0viNkGvUoescZvZwX1Qkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755881380; c=relaxed/simple;
	bh=5i7wiKBO+SRU6NsjkH8B8cYa7PQXcxj15HFgmVAA/zY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=n6LWn3iw93iIveOmT/JcE1+9OHEwOTenR2y+vKjYpBxKPp/zOxCFhafef9J1dl0hf1gYbi5ojwCcpBqaAEtCt2vDy7E5wE8kgeIRPu1JzAkuhA3RN/QTM8gQXGnWm9tixGCJOSazs33UJXsFB9+QrDwZY2JkUajIc3If+ZeTh0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 6D8F21DBC6F;
	Fri, 22 Aug 2025 16:49:30 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id 2A9382000E;
	Fri, 22 Aug 2025 16:49:28 +0000 (UTC)
Date: Fri, 22 Aug 2025 12:49:33 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Mark Rutland <mark.rutland@arm.com>, Andrew Morton
 <akpm@linux-foundation.org>, Liao Yuanhong <liaoyuanhong@vivo.com>, Pu
 Lehui <pulehui@huawei.com>, Tao Chen <chen.dylane@linux.dev>, Tengda Wu
 <wutengda@huaweicloud.com>, Ye Weihua <yeweihua4@huawei.com>
Subject: [GIT PULL] tracing: Fixes for v6.17
Message-ID: <20250822124933.74965607@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: qb4d5hgs4h8kmemsokrdebhxisooxikm
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 2A9382000E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+RwzOO4jZk8fW6WjIL97/RvyvM7NqFS8k=
X-HE-Tag: 1755881368-953416
X-HE-Meta: U2FsdGVkX18RS9gCHuPRxpka88ffgQkOuEMLEoOZHyMyElRP7gptLwt66N5ILEzKhWlX14NWQGmNFK+o5hjwbvGP4r7zQYTuRy7IEYH+Of0tK2E1ncHCr30smUnCSkwoNAfqNzWBRqhHi424NtVUdQ62d/G3NvB5j+4wZFQ5Hz4NhUVNF2CgjF6BghT/E4XDlM3qkC4UW6kq8Jps7kn7Yo7kGbZyEu/6D3ISkq/fuxsstYQRrLc8PAHFX8idZJaaW5BAi56/ZyaP+jQ00QeXyg3VKz7KGJQCscVztpfOEf+3hqdbvX2ersm5jH7zjnAYOzIFpTbSvx8fySWcPhxqmuV6Xy4WA/9r


Linus,

tracing fixes for v6.17-rc2:

- Fix rtla and latency tooling pkg-config errors

  If libtraceevent and libtracefs is installed, but their corresponding '.pc'
  files are not installed, it reports that the libraries are missing and
  confuses the developer. Instead, report that the pkg-config files are
  missing and should be installed.

- Fix overflow bug of the parser in trace_get_user()

  trace_get_user() uses the parsing functions to parse the user space strings.
  If the parser fails due to incorrect processing, it doesn't terminate the
  buffer with a nul byte. Add a "failed" flag to the parser that gets set when
  parsing fails and is used to know if the buffer is fine to use or not.

- Remove a semicolon that was at an end of a comment line

- Fix register_ftrace_graph() to unregister the pm notifier on error

  The register_ftrace_graph() registers a pm notifier but there's an error
  path that can exit the function without unregistering it. Since the function
  returns an error, it will never be unregistered.

- Allocate and copy ftrace hash for reader of ftrace filter files

  When the set_ftrace_filter or set_ftrace_notrace files are open for read,
  an iterator is created and sets its hash pointer to the associated hash that
  represents filtering or notrace filtering to it. The issue is that the hash
  it points to can change while the iteration is happening. All the locking
  used to access the tracer's hashes are released which means those hashes can
  change or even be freed. Using the hash pointed to by the iterator can cause
  UAF bugs or similar.

  Have the read of these files allocate and copy the corresponding hashes and
  use that as that will keep them the same while the iterator is open. This
  also simplifies the code as opening it for write already does an allocate
  and copy, and now that the read is doing the same, there's no need to check
  which way it was opened on the release of the file, and the iterator hash
  can always be freed.

- Fix function graph to copy args into temp storage

  The output of the function graph tracer shows both the entry and the exit of
  a function. When the exit is right after the entry, it combines the two
  events into one with the output of "function();", instead of showing:

  function() {
  }

  In order to do this, the iterator descriptor that reads the events includes
  storage that saves the entry event while it peaks at the next event in
  the ring buffer. The peek can free the entry event so the iterator must
  store the information to use it after the peek.

  With the addition of function graph tracer recording the args, where the
  args are a dynamic array in the entry event, the temp storage does not save
  them. This causes the args to be corrupted or even cause a read of unsafe
  memory.

  Add space to save the args in the temp storage of the iterator.

- Fix race between ftrace_dump and reading trace_pipe

  ftrace_dump() is used when a crash occurs where the ftrace buffer will be
  printed to the console. But it can also be triggered by sysrq-z. If a
  sysrq-z is triggered while a task is reading trace_pipe it can cause a race
  in the ftrace_dump() where it checks if the buffer has content, then it
  checks if the next event is available, and then prints the output
  (regardless if the next event was available or not). Reading trace_pipe
  at the same time can cause it to not be available, and this triggers a
  WARN_ON in the print. Move the printing into the check if the next event
  exists or not.


Please pull the latest trace-v6.17-rc2 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-v6.17-rc2

Tag SHA1: 287d6057ddf2299a17a90c35fbeec04a5ea88fe5
Head SHA1: c1e730442be2902ad5f9acc244ffc6e6400b981a


Liao Yuanhong (1):
      ring-buffer: Remove redundant semicolons

Pu Lehui (1):
      tracing: Limit access to parser->buffer when trace_get_user failed

Steven Rostedt (2):
      ftrace: Also allocate and copy hash for reading of filter files
      fgraph: Copy args in intermediate storage with entry

Tao Chen (2):
      tools/latency-collector: Check pkg-config install
      rtla: Check pkg-config install

Tengda Wu (1):
      ftrace: Fix potential warning in trace_printk_seq during ftrace_dump

Ye Weihua (1):
      trace/fgraph: Fix the warning caused by missing unregister notifier

----
 kernel/trace/fgraph.c                 |  1 +
 kernel/trace/ftrace.c                 | 16 +++++++---------
 kernel/trace/ring_buffer.c            |  2 +-
 kernel/trace/trace.c                  | 22 ++++++++++++++--------
 kernel/trace/trace.h                  |  8 +++++++-
 kernel/trace/trace_functions_graph.c  | 22 ++++++++++++++++------
 tools/tracing/latency/Makefile.config |  8 ++++++++
 tools/tracing/rtla/Makefile.config    |  8 ++++++++
 8 files changed, 62 insertions(+), 25 deletions(-)
---------------------------
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
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 00b76d450a89..f992a5eb878e 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -4661,13 +4661,14 @@ ftrace_regex_open(struct ftrace_ops *ops, int flag,
 	        } else {
 			iter->hash = alloc_and_copy_ftrace_hash(size_bits, hash);
 		}
+	} else {
+		iter->hash = alloc_and_copy_ftrace_hash(hash->size_bits, hash);
+	}
 
-		if (!iter->hash) {
-			trace_parser_put(&iter->parser);
-			goto out_unlock;
-		}
-	} else
-		iter->hash = hash;
+	if (!iter->hash) {
+		trace_parser_put(&iter->parser);
+		goto out_unlock;
+	}
 
 	ret = 0;
 
@@ -6543,9 +6544,6 @@ int ftrace_regex_release(struct inode *inode, struct file *file)
 		ftrace_hash_move_and_update_ops(iter->ops, orig_hash,
 						      iter->hash, filter_hash);
 		mutex_unlock(&ftrace_lock);
-	} else {
-		/* For read only, the hash is the ops hash */
-		iter->hash = NULL;
 	}
 
 	mutex_unlock(&iter->ops->func_hash->regex_lock);
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index bb71a0dc9d69..43460949ad3f 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -7666,7 +7666,7 @@ static __init int test_ringbuffer(void)
 	rb_test_started = true;
 
 	set_current_state(TASK_INTERRUPTIBLE);
-	/* Just run for 10 seconds */;
+	/* Just run for 10 seconds */
 	schedule_timeout(10 * HZ);
 
 	kthread_stop(rb_hammer);
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 4283ed4e8f59..1b7db732c0b1 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1816,7 +1816,7 @@ int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 
 	ret = get_user(ch, ubuf++);
 	if (ret)
-		return ret;
+		goto fail;
 
 	read++;
 	cnt--;
@@ -1830,7 +1830,7 @@ int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 		while (cnt && isspace(ch)) {
 			ret = get_user(ch, ubuf++);
 			if (ret)
-				return ret;
+				goto fail;
 			read++;
 			cnt--;
 		}
@@ -1848,12 +1848,14 @@ int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 	while (cnt && !isspace(ch) && ch) {
 		if (parser->idx < parser->size - 1)
 			parser->buffer[parser->idx++] = ch;
-		else
-			return -EINVAL;
+		else {
+			ret = -EINVAL;
+			goto fail;
+		}
 
 		ret = get_user(ch, ubuf++);
 		if (ret)
-			return ret;
+			goto fail;
 		read++;
 		cnt--;
 	}
@@ -1868,11 +1870,15 @@ int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 		/* Make sure the parsed string always terminates with '\0'. */
 		parser->buffer[parser->idx] = 0;
 	} else {
-		return -EINVAL;
+		ret = -EINVAL;
+		goto fail;
 	}
 
 	*ppos += read;
 	return read;
+fail:
+	trace_parser_fail(parser);
+	return ret;
 }
 
 /* TODO add a seq_buf_to_buffer() */
@@ -10632,10 +10638,10 @@ static void ftrace_dump_one(struct trace_array *tr, enum ftrace_dump_mode dump_m
 			ret = print_trace_line(&iter);
 			if (ret != TRACE_TYPE_NO_CONSUME)
 				trace_consume(&iter);
+
+			trace_printk_seq(&iter.seq);
 		}
 		touch_nmi_watchdog();
-
-		trace_printk_seq(&iter.seq);
 	}
 
 	if (!cnt)
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 1dbf1d3cf2f1..be6654899cae 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1292,6 +1292,7 @@ bool ftrace_event_is_function(struct trace_event_call *call);
  */
 struct trace_parser {
 	bool		cont;
+	bool		fail;
 	char		*buffer;
 	unsigned	idx;
 	unsigned	size;
@@ -1299,7 +1300,7 @@ struct trace_parser {
 
 static inline bool trace_parser_loaded(struct trace_parser *parser)
 {
-	return (parser->idx != 0);
+	return !parser->fail && parser->idx != 0;
 }
 
 static inline bool trace_parser_cont(struct trace_parser *parser)
@@ -1313,6 +1314,11 @@ static inline void trace_parser_clear(struct trace_parser *parser)
 	parser->idx = 0;
 }
 
+static inline void trace_parser_fail(struct trace_parser *parser)
+{
+	parser->fail = true;
+}
+
 extern int trace_parser_get_init(struct trace_parser *parser, int size);
 extern void trace_parser_put(struct trace_parser *parser);
 extern int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
diff --git a/kernel/trace/trace_functions_graph.c b/kernel/trace/trace_functions_graph.c
index 66e1a527cf1a..a7f4b9a47a71 100644
--- a/kernel/trace/trace_functions_graph.c
+++ b/kernel/trace/trace_functions_graph.c
@@ -27,14 +27,21 @@ struct fgraph_cpu_data {
 	unsigned long	enter_funcs[FTRACE_RETFUNC_DEPTH];
 };
 
+struct fgraph_ent_args {
+	struct ftrace_graph_ent_entry	ent;
+	/* Force the sizeof of args[] to have FTRACE_REGS_MAX_ARGS entries */
+	unsigned long			args[FTRACE_REGS_MAX_ARGS];
+};
+
 struct fgraph_data {
 	struct fgraph_cpu_data __percpu *cpu_data;
 
 	/* Place to preserve last processed entry. */
 	union {
-		struct ftrace_graph_ent_entry	ent;
+		struct fgraph_ent_args		ent;
+		/* TODO allow retaddr to have args */
 		struct fgraph_retaddr_ent_entry	rent;
-	} ent;
+	};
 	struct ftrace_graph_ret_entry	ret;
 	int				failed;
 	int				cpu;
@@ -627,10 +634,13 @@ get_return_for_leaf(struct trace_iterator *iter,
 			 * Save current and next entries for later reference
 			 * if the output fails.
 			 */
-			if (unlikely(curr->ent.type == TRACE_GRAPH_RETADDR_ENT))
-				data->ent.rent = *(struct fgraph_retaddr_ent_entry *)curr;
-			else
-				data->ent.ent = *curr;
+			if (unlikely(curr->ent.type == TRACE_GRAPH_RETADDR_ENT)) {
+				data->rent = *(struct fgraph_retaddr_ent_entry *)curr;
+			} else {
+				int size = min((int)sizeof(data->ent), (int)iter->ent_size);
+
+				memcpy(&data->ent, curr, size);
+			}
 			/*
 			 * If the next event is not a return type, then
 			 * we only care about what type it is. Otherwise we can
diff --git a/tools/tracing/latency/Makefile.config b/tools/tracing/latency/Makefile.config
index 0fe6b50f029b..6efa13e3ca93 100644
--- a/tools/tracing/latency/Makefile.config
+++ b/tools/tracing/latency/Makefile.config
@@ -1,7 +1,15 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
+include $(srctree)/tools/scripts/utilities.mak
+
 STOP_ERROR :=
 
+ifndef ($(NO_LIBTRACEEVENT),1)
+  ifeq ($(call get-executable,$(PKG_CONFIG)),)
+    $(error Error: $(PKG_CONFIG) needed by libtraceevent/libtracefs is missing on this system, please install it)
+  endif
+endif
+
 define lib_setup
   $(eval LIB_INCLUDES += $(shell sh -c "$(PKG_CONFIG) --cflags lib$(1)"))
   $(eval LDFLAGS += $(shell sh -c "$(PKG_CONFIG) --libs-only-L lib$(1)"))
diff --git a/tools/tracing/rtla/Makefile.config b/tools/tracing/rtla/Makefile.config
index 5f2231d8d626..07ff5e8f3006 100644
--- a/tools/tracing/rtla/Makefile.config
+++ b/tools/tracing/rtla/Makefile.config
@@ -1,10 +1,18 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
+include $(srctree)/tools/scripts/utilities.mak
+
 STOP_ERROR :=
 
 LIBTRACEEVENT_MIN_VERSION = 1.5
 LIBTRACEFS_MIN_VERSION = 1.6
 
+ifndef ($(NO_LIBTRACEEVENT),1)
+  ifeq ($(call get-executable,$(PKG_CONFIG)),)
+    $(error Error: $(PKG_CONFIG) needed by libtraceevent/libtracefs is missing on this system, please install it)
+  endif
+endif
+
 define lib_setup
   $(eval LIB_INCLUDES += $(shell sh -c "$(PKG_CONFIG) --cflags lib$(1)"))
   $(eval LDFLAGS += $(shell sh -c "$(PKG_CONFIG) --libs-only-L lib$(1)"))

