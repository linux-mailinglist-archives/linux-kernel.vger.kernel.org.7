Return-Path: <linux-kernel+bounces-841332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F754BB70B1
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 15:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F99C19E27AD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 13:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA3D230BD9;
	Fri,  3 Oct 2025 13:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cy0Txtut"
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BD721ABB1
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 13:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759498750; cv=none; b=l4YUYrNxdBjTEkZfyj6vHzIcOvZ34GpDMXnRmfaKNZmAwd0ufS5+kZhRzgJkHiwxVC6U45z7hxV/t8Z9Icvxv/QHnBZWrStAxraaGIOOpXb4RURpumlUNB+zVVW0u9bj88n/3gBaBgMaGTo2e2SuEgGvmW8O767Zw/kvSUOLoiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759498750; c=relaxed/simple;
	bh=UlV2P8HE6UloPyjMWwbeS4xK7drRiIoRCBgpbZbrDM4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hc2N2iP94y11PuNfXX2JVNU/t5J8gt2pmeXTEbz4i1aeB6O+n3238T3npoG80e/iglnyrXebyc09O3HSMZWjRmJyvTRl3pHuLytEATmSLJn2Nc/Im30TQr9ZA9jk3Pq6PL7nGpb3oG6kSNjd40o1nyCIMbi+5ye9NyjTwvhRTYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Cy0Txtut; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-b07c2924d53so198665466b.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 06:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759498746; x=1760103546; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FnIs6mkC8461WxAdM06cuKij/sR9Wa7LFhPzklSO9gg=;
        b=Cy0TxtutQ29hb38mR24bS3cHmjyhTJaB88640kY/+ghe6e0MrmsdmOxGqxczqOs6i9
         6jaxAW/MnjYWXK0JqKij0DWPLXmXHlmXMUBRiOUKonJHW2GzWJYX1LKsr9P6vP5pO/bH
         xLtGcxv1H04tI3NKgYmCmqSIOyTruifbK0x6oiQY8YIaEKtv3Hb/k+HYeAymzYW4HyqT
         acDThz5LR93yMz6qtagYoZG89DwR+yQP2SDQUmmS38vXnY4Law1737Afhv/JvsUQDWTB
         z0YHkVUjYT3SPO5KzJWzJO8VicB1pn8IMJHZlSb0sHRLVTidTZ/TxXQllN4LzspkwbD2
         EiAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759498746; x=1760103546;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FnIs6mkC8461WxAdM06cuKij/sR9Wa7LFhPzklSO9gg=;
        b=ThC98ckRpOOhT7lHLXivGfA7VyYh7XMFmNHG7Jjmd9eIiZHJj4PYQlvwsI3pw9JYDe
         /Et+3VC+squhzPUHl2hTi3VACaQ0jVYQ/iMi6mszL3htNr8WPINhFxsCORLc0KILJJHg
         BRvuldbszweUitl4i4q2lcCEW5pI+DKXYvIb3R+LXdm7oHg1JAp/zkfKuxQYVQqZQj1J
         fHVYtIvcKEZiYB06wyJrn1lnclYRuO7roavrqx75v2/j5iCmdcBOIib0tGVU5VjpiwIC
         y8zHu8qYG7DEqu0PVxsNSvwk0wLpjwpPhGNuDA6D7PUUAPQsPnG+JmlAXvAcvK+TRAVt
         1wZw==
X-Forwarded-Encrypted: i=1; AJvYcCXBaww43zbYPjs3aERkYCp440Cr6BFtcTKQZVwKMFOqxz7qq3SEJBclX4EpcPMyiz6oYzSgJIp+j4frFdE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR/fnCmy74zHzcNpgEGc8pW5i/WA3vtrKckBYRmyK5puPclQ9I
	aeeCTkETv7R2NsgQgla9zZlbzUVEqb5MNXGDSmsOrQOgjFumnfszZEuoecrqtWfaI5BL/JTdOtT
	+ZryEDrs3OSHZjuEyCndl7Q==
X-Google-Smtp-Source: AGHT+IFD3HeWIoToYX0mtY54yQekjj5b06NSm6nMjymXtmA/dEJabOncQXjfK7kXo3lD7+6n6IxKIVzX9L5JzG25
X-Received: from ejbdx26.prod.google.com ([2002:a17:906:a85a:b0:b45:b254:8e03])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:d90:b0:b43:2a3c:c74a with SMTP id a640c23a62f3a-b49c48a8de0mr380223366b.60.1759498745977;
 Fri, 03 Oct 2025 06:39:05 -0700 (PDT)
Date: Fri,  3 Oct 2025 14:38:06 +0100
In-Reply-To: <20251003133825.2068970-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251003133825.2068970-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251003133825.2068970-10-vdonnefort@google.com>
Subject: [PATCH v7 09/28] tracing: Add events to trace remotes
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	jstultz@google.com, qperret@google.com, will@kernel.org, 
	aneesh.kumar@kernel.org, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

An event is predefined point in the writer code that allows to log
data. Following the same scheme as kernel events, add remote events,
described to user-space within the events/ tracefs directory found in
the corresponding trace remote.

Remote events are expected to be described during the trace remote
registration.

Add also a .enable_event callback for trace_remote to toggle the event
logging, if supported.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/include/linux/trace_remote.h b/include/linux/trace_remote.h
index 15a579633123..456df837fc6b 100644
--- a/include/linux/trace_remote.h
+++ b/include/linux/trace_remote.h
@@ -5,6 +5,7 @@
 
 #include <linux/dcache.h>
 #include <linux/ring_buffer.h>
+#include <linux/trace_remote_event.h>
 
 /**
  * struct trace_remote_callbacks - Callbacks used by Tracefs to control the remote
@@ -24,6 +25,8 @@
  * @reset:		Called on `echo 0 > trace`. It is expected from the
  *			remote to reset all ring-buffer pages.
  *			new reader-page from the @cpu ring-buffer.
+ * @enable_event:	Called on events/event_name/enable. It is expected from
+ *			the remote to allow the writing event @id.
  */
 struct trace_remote_callbacks {
 	int	(*init)(struct dentry *d, void *priv);
@@ -32,6 +35,7 @@ struct trace_remote_callbacks {
 	int	(*enable_tracing)(bool enable, void *priv);
 	int	(*swap_reader_page)(unsigned int cpu, void *priv);
 	int	(*reset)(unsigned int cpu, void *priv);
+	int	(*enable_event)(unsigned short id, bool enable, void *priv);
 };
 
 /**
@@ -53,7 +57,8 @@ struct trace_remote_callbacks {
  *
  * Return: 0 on success, negative error code on failure.
  */
-int trace_remote_register(const char *name, struct trace_remote_callbacks *cbs, void *priv);
+int trace_remote_register(const char *name, struct trace_remote_callbacks *cbs, void *priv,
+			  struct remote_event *events, size_t nr_events);
 
 /**
  * trace_remote_alloc_buffer() - Dynamically allocate a trace buffer
diff --git a/include/linux/trace_remote_event.h b/include/linux/trace_remote_event.h
new file mode 100644
index 000000000000..a4449008a075
--- /dev/null
+++ b/include/linux/trace_remote_event.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _LINUX_TRACE_REMOTE_EVENTS_H
+#define _LINUX_TRACE_REMOTE_EVENTS_H
+
+struct trace_remote;
+struct trace_event_fields;
+
+struct remote_event_hdr {
+	unsigned short	id;
+};
+
+#define REMOTE_EVENT_NAME_MAX 30
+struct remote_event {
+	char				name[REMOTE_EVENT_NAME_MAX];
+	unsigned short			id;
+	bool				enabled;
+	struct trace_remote		*remote;
+	struct trace_event_fields	*fields;
+	char				*print_fmt;
+	void				(*print)(void *evt, struct trace_seq *seq);
+};
+#endif
diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
index 55ba3fd9e002..9504d9c04bef 100644
--- a/kernel/trace/trace_remote.c
+++ b/kernel/trace/trace_remote.c
@@ -33,6 +33,7 @@ struct trace_remote_iterator {
 		struct ring_buffer_iter	**rb_iters;
 		struct ring_buffer_iter *rb_iter;
 	};
+	struct remote_event_hdr		*evt;
 	int				cpu;
 	int				evt_cpu;
 	loff_t				pos;
@@ -44,6 +45,10 @@ struct trace_remote {
 	void				*priv;
 	struct trace_buffer		*trace_buffer;
 	struct trace_buffer_desc	*trace_buffer_desc;
+	struct dentry			*dentry;
+	struct eventfs_inode		*eventfs;
+	struct remote_event		*events;
+	unsigned long			nr_events;
 	unsigned long			trace_buffer_size;
 	struct ring_buffer_remote	rb_remote;
 	struct mutex			lock;
@@ -168,7 +173,8 @@ static void trace_remote_reset(struct trace_remote *remote, int cpu)
 static ssize_t
 tracing_on_write(struct file *filp, const char __user *ubuf, size_t cnt, loff_t *ppos)
 {
-	struct trace_remote *remote = filp->private_data;
+	struct seq_file *seq = filp->private_data;
+	struct trace_remote *remote = seq->private;
 	unsigned long val;
 	int ret;
 
@@ -197,7 +203,8 @@ DEFINE_SHOW_STORE_ATTRIBUTE(tracing_on);
 static ssize_t buffer_size_kb_write(struct file *filp, const char __user *ubuf, size_t cnt,
 				    loff_t *ppos)
 {
-	struct trace_remote *remote = filp->private_data;
+	struct seq_file *seq = filp->private_data;
+	struct trace_remote *remote = seq->private;
 	unsigned long val;
 	int ret;
 
@@ -484,16 +491,19 @@ __peek_event(struct trace_remote_iterator *iter, int cpu, u64 *ts, unsigned long
 static bool trace_remote_iter_read_event(struct trace_remote_iterator *iter)
 {
 	struct trace_buffer *trace_buffer = iter->remote->trace_buffer;
+	struct ring_buffer_event *rb_evt;
 	int cpu = iter->cpu;
 
 	if (cpu != RING_BUFFER_ALL_CPUS) {
 		if (ring_buffer_empty_cpu(trace_buffer, cpu))
 			return false;
 
-		if (!__peek_event(iter, cpu, &iter->ts, &iter->lost_events))
+		rb_evt = __peek_event(iter, cpu, &iter->ts, &iter->lost_events);
+		if (!rb_evt)
 			return false;
 
 		iter->evt_cpu = cpu;
+		iter->evt = (struct remote_event_hdr *)ring_buffer_event_data(rb_evt);
 		return true;
 	}
 
@@ -505,7 +515,8 @@ static bool trace_remote_iter_read_event(struct trace_remote_iterator *iter)
 		if (ring_buffer_empty_cpu(trace_buffer, cpu))
 			continue;
 
-		if (!__peek_event(iter, cpu, &ts, &lost_events))
+		rb_evt = __peek_event(iter, cpu, &ts, &lost_events);
+		if (!rb_evt)
 			continue;
 
 		if (ts >= iter->ts)
@@ -513,6 +524,7 @@ static bool trace_remote_iter_read_event(struct trace_remote_iterator *iter)
 
 		iter->ts = ts;
 		iter->evt_cpu = cpu;
+		iter->evt = (struct remote_event_hdr *)ring_buffer_event_data(rb_evt);
 		iter->lost_events = lost_events;
 	}
 
@@ -533,8 +545,11 @@ static void trace_remote_iter_move(struct trace_remote_iterator *iter)
 	}
 }
 
+static struct remote_event *trace_remote_find_event(struct trace_remote *remote, unsigned short id);
+
 static int trace_remote_iter_print_event(struct trace_remote_iterator *iter)
 {
+	struct remote_event *evt;
 	unsigned long usecs_rem;
 	u64 ts = iter->ts;
 
@@ -548,6 +563,12 @@ static int trace_remote_iter_print_event(struct trace_remote_iterator *iter)
 	trace_seq_printf(&iter->seq, "[%03d]\t%5llu.%06lu: ", iter->evt_cpu,
 			 ts, usecs_rem);
 
+	evt = trace_remote_find_event(iter->remote, iter->evt->id);
+	if (!evt)
+		trace_seq_printf(&iter->seq, "UNKNOWN id=%d\n", iter->evt->id);
+	else
+		evt->print(iter->evt, &iter->seq);
+
 	return trace_seq_has_overflowed(&iter->seq) ? -EOVERFLOW : 0;
 }
 
@@ -821,6 +842,8 @@ static int trace_remote_init_tracefs(const char *name, struct trace_remote *remo
 			goto err;
 	}
 
+	remote->dentry = remote_d;
+
 	return 0;
 
 err:
@@ -834,7 +857,11 @@ static int trace_remote_init_tracefs(const char *name, struct trace_remote *remo
 	return -ENOMEM;
 }
 
-int trace_remote_register(const char *name, struct trace_remote_callbacks *cbs, void *priv)
+static int trace_remote_register_events(const char *remote_name, struct trace_remote *remote,
+					struct remote_event *events, size_t nr_events);
+
+int trace_remote_register(const char *name, struct trace_remote_callbacks *cbs, void *priv,
+			  struct remote_event *events, size_t nr_events)
 {
 	struct trace_remote *remote;
 	int ret;
@@ -855,6 +882,13 @@ int trace_remote_register(const char *name, struct trace_remote_callbacks *cbs,
 		return -ENOMEM;
 	}
 
+	ret = trace_remote_register_events(name, remote, events, nr_events);
+	if (ret) {
+		pr_err("Failed to register events for trace remote '%s' (%d)\n",
+		       name, ret);
+		return ret;
+	}
+
 	ret = cbs->init ? cbs->init(remote->dentry, priv) : 0;
 	if (ret)
 		pr_err("Init failed for trace remote '%s' (%d)\n", name, ret);
@@ -926,3 +960,220 @@ int trace_remote_alloc_buffer(struct trace_buffer_desc *desc, size_t desc_size,
 	trace_remote_free_buffer(desc);
 	return ret;
 }
+
+static int
+trace_remote_enable_event(struct trace_remote *remote, struct remote_event *evt, bool enable)
+{
+	int ret;
+
+	lockdep_assert_held(&remote->lock);
+
+	if (evt->enabled == enable)
+		return 0;
+
+	ret = remote->cbs->enable_event(evt->id, enable, remote->priv);
+	if (ret)
+		return ret;
+
+	evt->enabled = enable;
+
+	return 0;
+}
+
+static int remote_event_enable_show(struct seq_file *s, void *unused)
+{
+	struct remote_event *evt = s->private;
+
+	seq_printf(s, "%d\n", evt->enabled);
+
+	return 0;
+}
+
+static ssize_t remote_event_enable_write(struct file *filp, const char __user *ubuf,
+					 size_t count, loff_t *ppos)
+{
+	struct seq_file *seq = filp->private_data;
+	struct remote_event *evt = seq->private;
+	struct trace_remote *remote = evt->remote;
+	u8 enable;
+	int ret;
+
+	ret = kstrtou8_from_user(ubuf, count, 10, &enable);
+	if (ret)
+		return ret;
+
+	guard(mutex)(&remote->lock);
+
+	ret = trace_remote_enable_event(remote, evt, enable);
+	if (ret)
+		return ret;
+
+	return count;
+}
+DEFINE_SHOW_STORE_ATTRIBUTE(remote_event_enable);
+
+static int remote_event_id_show(struct seq_file *s, void *unused)
+{
+	struct remote_event *evt = s->private;
+
+	seq_printf(s, "%d\n", evt->id);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(remote_event_id);
+
+static int remote_event_format_show(struct seq_file *s, void *unused)
+{
+	size_t offset = sizeof(struct remote_event_hdr);
+	struct remote_event *evt = s->private;
+	struct trace_event_fields *field;
+
+	seq_printf(s, "name: %s\n", evt->name);
+	seq_printf(s, "ID: %d\n", evt->id);
+	seq_puts(s,
+		 "format:\n\tfield:unsigned short common_type;\toffset:0;\tsize:2;\tsigned:0;\n\n");
+
+	field = &evt->fields[0];
+	while (field->name) {
+		seq_printf(s, "\tfield:%s %s;\toffset:%zu;\tsize:%u;\tsigned:%d;\n",
+			   field->type, field->name, offset, field->size,
+			   !field->is_signed);
+		offset += field->size;
+		field++;
+	}
+
+	if (field != &evt->fields[0])
+		seq_puts(s, "\n");
+
+	seq_printf(s, "print fmt: %s\n", evt->print_fmt);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(remote_event_format);
+
+static int remote_event_callback(const char *name, umode_t *mode, void **data,
+				 const struct file_operations **fops)
+{
+	if (!strcmp(name, "enable")) {
+		*mode = TRACEFS_MODE_WRITE;
+		*fops = &remote_event_enable_fops;
+		return 1;
+	}
+
+	if (!strcmp(name, "id")) {
+		*mode = TRACEFS_MODE_READ;
+		*fops = &remote_event_id_fops;
+		return 1;
+	}
+
+	if (!strcmp(name, "format")) {
+		*mode = TRACEFS_MODE_READ;
+		*fops = &remote_event_id_fops;
+		return 1;
+	}
+
+	return 0;
+}
+
+static int trace_remote_init_eventfs(const char *remote_name, struct trace_remote *remote,
+				     struct remote_event *evt)
+{
+	struct eventfs_inode *eventfs = remote->eventfs;
+	static struct eventfs_entry entries[] = {
+		{
+			.name		= "enable",
+			.callback	= remote_event_callback,
+		}, {
+			.name		= "id",
+			.callback	= remote_event_callback,
+		}, {
+			.name		= "format",
+			.callback	= remote_event_callback,
+		}
+	};
+	bool eventfs_create = false;
+
+	if (!eventfs) {
+		eventfs = eventfs_create_events_dir("events", remote->dentry, NULL, 0, NULL);
+		if (IS_ERR(eventfs))
+			return PTR_ERR(eventfs);
+
+		/*
+		 * Create similar hierarchy as local events even if a single system is supported at
+		 * the moment
+		 */
+		eventfs = eventfs_create_dir(remote_name, eventfs, NULL, 0, NULL);
+		if (IS_ERR(eventfs))
+			return PTR_ERR(eventfs);
+
+		remote->eventfs = eventfs;
+		eventfs_create = true;
+	}
+
+	eventfs = eventfs_create_dir(evt->name, eventfs, entries, ARRAY_SIZE(entries), evt);
+	if (IS_ERR(eventfs)) {
+		if (eventfs_create) {
+			eventfs_remove_events_dir(remote->eventfs);
+			remote->eventfs = NULL;
+		}
+		return PTR_ERR(eventfs);
+	}
+
+	return 0;
+}
+
+static int trace_remote_attach_events(struct trace_remote *remote, struct remote_event *events,
+				      size_t nr_events)
+{
+	int i;
+
+	for (i = 0; i < nr_events; i++) {
+		struct remote_event *evt = &events[i];
+
+		if (evt->remote)
+			return -EEXIST;
+
+		evt->remote = remote;
+
+		/* We need events to be sorted for efficient lookup */
+		if (i && evt->id <= events[i - 1].id)
+			return -EINVAL;
+	}
+
+	remote->events = events;
+	remote->nr_events = nr_events;
+
+	return 0;
+}
+
+static int trace_remote_register_events(const char *remote_name, struct trace_remote *remote,
+					struct remote_event *events, size_t nr_events)
+{
+	int i, ret;
+
+	ret = trace_remote_attach_events(remote, events, nr_events);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < nr_events; i++) {
+		struct remote_event *evt = &events[i];
+
+		ret = trace_remote_init_eventfs(remote_name, remote, evt);
+		if (ret)
+			pr_warn("Failed to init eventfs for event '%s' (%d)",
+				evt->name, ret);
+	}
+
+	return 0;
+}
+
+static int __cmp_events(const void *id, const void *evt)
+{
+	return (long)id - ((struct remote_event *)evt)->id;
+}
+
+static struct remote_event *trace_remote_find_event(struct trace_remote *remote, unsigned short id)
+{
+	return bsearch((const void *)(unsigned long)id, remote->events, remote->nr_events,
+		       sizeof(*remote->events), __cmp_events);
+}
-- 
2.51.0.618.g983fd99d29-goog


