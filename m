Return-Path: <linux-kernel+bounces-749997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB593B155B9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 01:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 102A616AE77
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 23:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4D6285418;
	Tue, 29 Jul 2025 23:06:47 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7BB246BA4
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 23:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753830406; cv=none; b=gq8ZuGteApXtW/17kyGQeu4bPoy07bYHcUkknxBzr/MU/qBKI1kAhpscVsrZ/vK6fbe0Z4rSX0YgliMzqiRJunfFiOm8or9nS13v96zh6CHd+QdFBIJ8acGhY1HQ6TP30OEs2ulKoVGf22aNMYdsun1X3ufgX65FVxZFxm0mYuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753830406; c=relaxed/simple;
	bh=CF6l3dxPlEPmk5QYxUOTFG1R2tkkhbXVBC4nUALLm6M=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=myAHeoRdzHQb9dnjT9UeRajU9QaVCFmjX0LzprG7aFETb0bd8foiye0v3CaZhImgRBLl2++OhcdxMuLajfhvNAu0bIbVS41f+FT63P2SNq6rU+3wRvqiiqrJ5WE/GoEPhS0qssPelzh0h6rb7Y1wucwSsuEUrkvogZLEFF74mgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 72FE510FA9C;
	Tue, 29 Jul 2025 23:06:42 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id F0EAF20025;
	Tue, 29 Jul 2025 23:06:40 +0000 (UTC)
Date: Tue, 29 Jul 2025 19:06:55 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: [PATCH][for-next] tracing: Remove "__attribute__()" from the type
 field of event format
Message-ID: <20250729190655.49040a46@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: k7c5d1z3h593sjmgu16hy7yrkd4i97w3
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: F0EAF20025
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18gTF4VBn5le6WA6Fgi/Tula9/hOB9d1ig=
X-HE-Tag: 1753830400-748331
X-HE-Meta: U2FsdGVkX1+iXZ4EPxyj45fcMUxGLQv0cZIIkr75bZkxeuYe6DwWIepPogP4dXas2c3/fvjUMlBOBA4P7DAOcPnCjkAAs57YwpPYqWDmdNaiBwH3fyD2234NaOE4MJBVKPX2MGE3j3rmc7jxDQMMZ2rFUNGVvHiFq3B8KQbCSfLgAMMngmtqEgZx2HnLQ/CjswQIX0DKb1KiJUSfPG9ELq6+uuPCE3YvjL+iL57kNbOttSboxbMVffdexJyeDVRjfS+TMmhmjL9U8DCHQWGxX+sfMpeOwcngTfHhWNVjhoanKsI+TuRfy3Rlhs0y8G4KvSUKrwMZddCR9U4LXBJeOXwzAVWAAJD+1caTCsZ0gM8wv1tKBA0SH8mjEsjxO5Z+oclpK5QSt/NTe4ixWdeuPqPAb9Xo9mYtnBrOlcx/+Uy6MYNqOX0bylGAXA2fKG2h57skRkLZCq00Zme0gVeS7l9hQipQa4YaW+ihquD57Yk=

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace/for-next

Head SHA1: 1a967e92bf47cf5170336b88d748117c700edc47


Masami Hiramatsu (Google) (1):
      tracing: Remove "__attribute__()" from the type field of event format

----
 kernel/trace/trace.c        |  28 ++++++----
 kernel/trace/trace.h        |   4 +-
 kernel/trace/trace_events.c | 128 ++++++++++++++++++++++++++++++++++++--------
 3 files changed, 127 insertions(+), 33 deletions(-)
---------------------------
commit 1a967e92bf47cf5170336b88d748117c700edc47
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Date:   Tue Jul 29 14:10:35 2025 +0900

    tracing: Remove "__attribute__()" from the type field of event format
    
    With CONFIG_DEBUG_INFO_BTF=y and PAHOLE_HAS_BTF_TAG=y, `__user` is
    converted to `__attribute__((btf_type_tag("user")))`. In this case,
    some syscall events have it for __user data, like below;
    
    /sys/kernel/tracing # cat events/syscalls/sys_enter_openat/format
    name: sys_enter_openat
    ID: 720
    format:
            field:unsigned short common_type;       offset:0;       size:2; signed:0;
            field:unsigned char common_flags;       offset:2;       size:1; signed:0;
            field:unsigned char common_preempt_count;       offset:3;       size:1; signed:0;
            field:int common_pid;   offset:4;       size:4; signed:1;
    
            field:int __syscall_nr; offset:8;       size:4; signed:1;
            field:int dfd;  offset:16;      size:8; signed:0;
            field:const char __attribute__((btf_type_tag("user"))) * filename;      offset:24;      size:8; signed:0;
            field:int flags;        offset:32;      size:8; signed:0;
            field:umode_t mode;     offset:40;      size:8; signed:0;
    
    Then the trace event filter fails to set the string acceptable flag
    (FILTER_PTR_STRING) to the field and rejects setting string filter;
    
     # echo 'filename.ustring ~ "*ftracetest-dir.wbx24v*"' \
        >> events/syscalls/sys_enter_openat/filter
     sh: write error: Invalid argument
     # cat error_log
     [  723.743637] event filter parse error: error: Expecting numeric field
       Command: filename.ustring ~ "*ftracetest-dir.wbx24v*"
    
    Since this __attribute__ makes format parsing complicated and not
    needed, remove the __attribute__(.*) from the type string.
    
    Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
    Link: https://lore.kernel.org/175376583493.1688759.12333973498014733551.stgit@mhiramat.tok.corp.google.com
    Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
    Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 06ab5b7a8711..945a8ecf2c62 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5930,17 +5930,27 @@ static inline void trace_insert_eval_map_file(struct module *mod,
 			      struct trace_eval_map **start, int len) { }
 #endif /* !CONFIG_TRACE_EVAL_MAP_FILE */
 
-static void trace_insert_eval_map(struct module *mod,
-				  struct trace_eval_map **start, int len)
+static void
+trace_event_update_with_eval_map(struct module *mod,
+				 struct trace_eval_map **start,
+				 int len)
 {
 	struct trace_eval_map **map;
 
-	if (len <= 0)
-		return;
+	/* Always run sanitizer only if btf_type_tag attr exists. */
+	if (len <= 0) {
+		if (!(IS_ENABLED(CONFIG_DEBUG_INFO_BTF) &&
+		      IS_ENABLED(CONFIG_PAHOLE_HAS_BTF_TAG) &&
+		      __has_attribute(btf_type_tag)))
+			return;
+	}
 
 	map = start;
 
-	trace_event_eval_update(map, len);
+	trace_event_update_all(map, len);
+
+	if (len <= 0)
+		return;
 
 	trace_insert_eval_map_file(mod, start, len);
 }
@@ -10334,7 +10344,7 @@ static void __init eval_map_work_func(struct work_struct *work)
 	int len;
 
 	len = __stop_ftrace_eval_maps - __start_ftrace_eval_maps;
-	trace_insert_eval_map(NULL, __start_ftrace_eval_maps, len);
+	trace_event_update_with_eval_map(NULL, __start_ftrace_eval_maps, len);
 }
 
 static int __init trace_eval_init(void)
@@ -10387,9 +10397,6 @@ bool module_exists(const char *module)
 
 static void trace_module_add_evals(struct module *mod)
 {
-	if (!mod->num_trace_evals)
-		return;
-
 	/*
 	 * Modules with bad taint do not have events created, do
 	 * not bother with enums either.
@@ -10397,7 +10404,8 @@ static void trace_module_add_evals(struct module *mod)
 	if (trace_module_has_bad_taint(mod))
 		return;
 
-	trace_insert_eval_map(mod, mod->trace_evals, mod->num_trace_evals);
+	/* Even if no trace_evals, this need to sanitize field types. */
+	trace_event_update_with_eval_map(mod, mod->trace_evals, mod->num_trace_evals);
 }
 
 #ifdef CONFIG_TRACE_EVAL_MAP_FILE
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index bd084953a98b..1dbf1d3cf2f1 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -2125,13 +2125,13 @@ static inline const char *get_syscall_name(int syscall)
 
 #ifdef CONFIG_EVENT_TRACING
 void trace_event_init(void);
-void trace_event_eval_update(struct trace_eval_map **map, int len);
+void trace_event_update_all(struct trace_eval_map **map, int len);
 /* Used from boot time tracer */
 extern int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set);
 extern int trigger_process_regex(struct trace_event_file *file, char *buff);
 #else
 static inline void __init trace_event_init(void) { }
-static inline void trace_event_eval_update(struct trace_eval_map **map, int len) { }
+static inline void trace_event_update_all(struct trace_eval_map **map, int len) { }
 #endif
 
 #ifdef CONFIG_TRACER_SNAPSHOT
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 6c0783fc4c2c..05447b958a1a 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -3264,43 +3264,120 @@ static void add_str_to_module(struct module *module, char *str)
 	list_add(&modstr->next, &module_strings);
 }
 
+#define ATTRIBUTE_STR "__attribute__("
+#define ATTRIBUTE_STR_LEN (sizeof(ATTRIBUTE_STR) - 1)
+
+/* Remove all __attribute__() from @type. Return allocated string or @type. */
+static char *sanitize_field_type(const char *type)
+{
+	char *attr, *tmp, *next, *ret = (char *)type;
+	int depth;
+
+	next = (char *)type;
+	while ((attr = strstr(next, ATTRIBUTE_STR))) {
+		/* Retry if "__attribute__(" is a part of another word. */
+		if (attr != next && !isspace(attr[-1])) {
+			next = attr + ATTRIBUTE_STR_LEN;
+			continue;
+		}
+
+		if (ret == type) {
+			ret = kstrdup(type, GFP_KERNEL);
+			if (WARN_ON_ONCE(!ret))
+				return NULL;
+			attr = ret + (attr - type);
+		}
+
+		/* the ATTRIBUTE_STR already has the first '(' */
+		depth = 1;
+		next = attr + ATTRIBUTE_STR_LEN;
+		do {
+			tmp = strpbrk(next, "()");
+			/* There is unbalanced parentheses */
+			if (WARN_ON_ONCE(!tmp)) {
+				kfree(ret);
+				return (char *)type;
+			}
+
+			if (*tmp == '(')
+				depth++;
+			else
+				depth--;
+			next = tmp + 1;
+		} while (depth > 0);
+		next = skip_spaces(next);
+		strcpy(attr, next);
+		next = attr;
+	}
+	return ret;
+}
+
+static char *find_replacable_eval(const char *type, const char *eval_string,
+				  int len)
+{
+	char *ptr;
+
+	if (!eval_string)
+		return NULL;
+
+	ptr = strchr(type, '[');
+	if (!ptr)
+		return NULL;
+	ptr++;
+
+	if (!isalpha(*ptr) && *ptr != '_')
+		return NULL;
+
+	if (strncmp(eval_string, ptr, len) != 0)
+		return NULL;
+
+	return ptr;
+}
+
 static void update_event_fields(struct trace_event_call *call,
 				struct trace_eval_map *map)
 {
 	struct ftrace_event_field *field;
+	const char *eval_string = NULL;
 	struct list_head *head;
+	int len = 0;
 	char *ptr;
 	char *str;
-	int len = strlen(map->eval_string);
 
 	/* Dynamic events should never have field maps */
-	if (WARN_ON_ONCE(call->flags & TRACE_EVENT_FL_DYNAMIC))
+	if (call->flags & TRACE_EVENT_FL_DYNAMIC)
 		return;
 
+	if (map) {
+		eval_string = map->eval_string;
+		len = strlen(map->eval_string);
+	}
+
 	head = trace_get_fields(call);
 	list_for_each_entry(field, head, link) {
-		ptr = strchr(field->type, '[');
-		if (!ptr)
-			continue;
-		ptr++;
-
-		if (!isalpha(*ptr) && *ptr != '_')
-			continue;
+		str = sanitize_field_type(field->type);
+		if (!str)
+			return;
 
-		if (strncmp(map->eval_string, ptr, len) != 0)
-			continue;
+		ptr = find_replacable_eval(str, eval_string, len);
+		if (ptr) {
+			if (str == field->type) {
+				str = kstrdup(field->type, GFP_KERNEL);
+				if (WARN_ON_ONCE(!str))
+					return;
+				ptr = str + (ptr - field->type);
+			}
 
-		str = kstrdup(field->type, GFP_KERNEL);
-		if (WARN_ON_ONCE(!str))
-			return;
-		ptr = str + (ptr - field->type);
-		ptr = eval_replace(ptr, map, len);
-		/* enum/sizeof string smaller than value */
-		if (WARN_ON_ONCE(!ptr)) {
-			kfree(str);
-			continue;
+			ptr = eval_replace(ptr, map, len);
+			/* enum/sizeof string smaller than value */
+			if (WARN_ON_ONCE(!ptr)) {
+				kfree(str);
+				continue;
+			}
 		}
 
+		if (str == field->type)
+			continue;
 		/*
 		 * If the event is part of a module, then we need to free the string
 		 * when the module is removed. Otherwise, it will stay allocated
@@ -3310,14 +3387,18 @@ static void update_event_fields(struct trace_event_call *call,
 			add_str_to_module(call->module, str);
 
 		field->type = str;
+		if (field->filter_type == FILTER_OTHER)
+			field->filter_type = filter_assign_type(field->type);
 	}
 }
 
-void trace_event_eval_update(struct trace_eval_map **map, int len)
+/* Update all events for replacing eval and sanitizing */
+void trace_event_update_all(struct trace_eval_map **map, int len)
 {
 	struct trace_event_call *call, *p;
 	const char *last_system = NULL;
 	bool first = false;
+	bool updated;
 	int last_i;
 	int i;
 
@@ -3330,6 +3411,7 @@ void trace_event_eval_update(struct trace_eval_map **map, int len)
 			last_system = call->class->system;
 		}
 
+		updated = false;
 		/*
 		 * Since calls are grouped by systems, the likelihood that the
 		 * next call in the iteration belongs to the same system as the
@@ -3349,8 +3431,12 @@ void trace_event_eval_update(struct trace_eval_map **map, int len)
 				}
 				update_event_printk(call, map[i]);
 				update_event_fields(call, map[i]);
+				updated = true;
 			}
 		}
+		/* If not updated yet, update field for sanitizing. */
+		if (!updated)
+			update_event_fields(call, NULL);
 		cond_resched();
 	}
 	up_write(&trace_event_sem);

