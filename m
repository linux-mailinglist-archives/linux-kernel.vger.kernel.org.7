Return-Path: <linux-kernel+bounces-876412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53DEFC1B6DB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CC131886EEE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CFB35471F;
	Wed, 29 Oct 2025 14:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WZck+EXT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDCD334C10
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761748844; cv=none; b=RcEx4mOv/q6V2KSPfd5xOkZrr84Our9ZWUNoJMe/YOmxhYddy18DQnGhsNLs4EQY0szVFUWL+5s5comIYUtKhA1s8OjWWE4bwrkq01JYAfrQb47uLEkG8wyr0nowhuQZq2CZgdHm2SwVFrbCs+LIMXqpCPAut3hOJYnhrRVDsKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761748844; c=relaxed/simple;
	bh=alfYw/p8bOUa+Gg/w3r1+y5k7YJzf/w9htpvP4PF8vY=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=rfFhJEXwXKqSYN2EjOoUL+PEQaZHcgCDQNp+qfRwlyD75x6oa3WmxPxLcD+SGzQXdsJ2h1vAQcXD0MULuQe7zJ6ZSWlYbM2cRLVe9htq+SHFC+D4jwtcdfxh/DcZsQZHxhb/3eUwxGhOz744I0une70cMC7xcPzjF1652KZEBLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WZck+EXT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B99A4C116D0;
	Wed, 29 Oct 2025 14:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761748843;
	bh=alfYw/p8bOUa+Gg/w3r1+y5k7YJzf/w9htpvP4PF8vY=;
	h=Date:From:To:Cc:Subject:References:From;
	b=WZck+EXTmk5oGHB3zjKYVDwaC4FqBgWCg0ZL9vN6sHNWLaxf6VE0mJDLcBeqfIlDR
	 RXjh0UPm+iCV9kB94UMQM6cFUwFQ7t/mXFCBZcqDWIeampyBUgH6VeZgT3qaIVq38k
	 DNFr+70FsQ77tjWwT1IxFAhnw8JlOhtJ5bMglk1u4lCqqd65e6Q97JnB2zu4R0bH5n
	 qJJQU8zLZh2pyl8d7l1IMzRFC0MZ4KbyLoNF2o5O68vUUK6cuBQPKfLIUmh5RWGe+X
	 EJyxpvPuvARL86NqLcmf7y7x92PzXymXdFnNLUS23bHvn14gFjs0JJKUEVuPecPi6a
	 D/DOeIBgWIq7w==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1vE7Ma-000000052wh-2SzN;
	Wed, 29 Oct 2025 10:41:24 -0400
Message-ID: <20251029144124.436727459@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 29 Oct 2025 10:40:47 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Takaya Saeki <takayas@google.com>,
 Tom Zanussi <zanussi@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Ian Rogers <irogers@google.com>,
 Douglas Raillard <douglas.raillard@arm.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Ingo Molnar <mingo@redhat.com>
Subject: [for-next][PATCH 06/13] tracing: Display some syscall arrays as strings
References: <20251029144041.475297995@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Some of the system calls that read a fixed length of memory from the user
space address are not arrays but strings. Take a bit away from the nb_args
field in the syscall meta data to use as a flag to denote that the system
call's user_arg_size is being used as a string. The nb_args should never
be more than 6, so 7 bits is plenty to hold that number. When the
user_arg_is_str flag that, when set, will display the data array from the
user space address as a string and not an array.

This will allow the output to look like this:

  sys_sethostname(name: 0x5584310eb2a0 "debian", len: 6)

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Takaya Saeki <takayas@google.com>
Cc: Tom Zanussi <zanussi@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ian Rogers <irogers@google.com>
Cc: Douglas Raillard <douglas.raillard@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Link: https://lore.kernel.org/20251028231147.930550359@kernel.org
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/trace/syscall.h       |  4 +++-
 kernel/trace/trace_syscalls.c | 22 +++++++++++++++++++---
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/include/trace/syscall.h b/include/trace/syscall.h
index 9413c139da66..0dd7f2b33431 100644
--- a/include/trace/syscall.h
+++ b/include/trace/syscall.h
@@ -16,6 +16,7 @@
  * @name: name of the syscall
  * @syscall_nr: number of the syscall
  * @nb_args: number of parameters it takes
+ * @user_arg_is_str: set if the arg for @user_arg_size is a string
  * @user_arg_size: holds @arg that has size of the user space to read
  * @user_mask: mask of @args that will read user space
  * @types: list of types as strings
@@ -27,7 +28,8 @@
 struct syscall_metadata {
 	const char	*name;
 	int		syscall_nr;
-	u8		nb_args;
+	u8		nb_args:7;
+	u8		user_arg_is_str:1;
 	s8		user_arg_size;
 	short		user_mask;
 	const char	**types;
diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index 3f3cdfc9958e..b8e9774a8abd 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -184,7 +184,7 @@ print_syscall_enter(struct trace_iterator *iter, int flags,
 		ptr = (void *)ent + (val & 0xffff);
 		len = val >> 16;
 
-		if (entry->user_arg_size < 0) {
+		if (entry->user_arg_size < 0 || entry->user_arg_is_str) {
 			trace_seq_printf(s, " \"%.*s\"", len, ptr);
 			continue;
 		}
@@ -249,6 +249,7 @@ print_syscall_exit(struct trace_iterator *iter, int flags,
 static int __init
 __set_enter_print_fmt(struct syscall_metadata *entry, char *buf, int len)
 {
+	bool is_string = entry->user_arg_is_str;
 	int i;
 	int pos = 0;
 
@@ -266,7 +267,7 @@ __set_enter_print_fmt(struct syscall_metadata *entry, char *buf, int len)
 			continue;
 
 		/* Add the format for the user space string or array */
-		if (entry->user_arg_size < 0)
+		if (entry->user_arg_size < 0 || is_string)
 			pos += snprintf(buf + pos, LEN_OR_ZERO, " \\\"%%s\\\"");
 		else
 			pos += snprintf(buf + pos, LEN_OR_ZERO, " (%%s)");
@@ -279,7 +280,7 @@ __set_enter_print_fmt(struct syscall_metadata *entry, char *buf, int len)
 		if (!(BIT(i) & entry->user_mask))
 			continue;
 		/* The user space data for arg has name __<arg>_val */
-		if (entry->user_arg_size < 0) {
+		if (entry->user_arg_size < 0 || is_string) {
 			pos += snprintf(buf + pos, LEN_OR_ZERO, ", __get_str(__%s_val)",
 					entry->args[i]);
 		} else {
@@ -781,6 +782,21 @@ static void check_faultable_syscall(struct trace_event_call *call, int nr)
 		sys_data->user_mask = BIT(1);
 		sys_data->user_arg_size = 2;
 		break;
+	/* user arg 0 with size arg at 1 as string */
+	case __NR_setdomainname:
+	case __NR_sethostname:
+		sys_data->user_mask = BIT(0);
+		sys_data->user_arg_size = 1;
+		sys_data->user_arg_is_str = 1;
+		break;
+#ifdef __NR_kexec_file_load
+	/* user arg 4 with size arg at 3 as string */
+	case __NR_kexec_file_load:
+		sys_data->user_mask = BIT(4);
+		sys_data->user_arg_size = 3;
+		sys_data->user_arg_is_str = 1;
+		break;
+#endif
 	/* user arg at position 0 */
 #ifdef __NR_access
 	case __NR_access:
-- 
2.51.0



