Return-Path: <linux-kernel+bounces-651359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BBF7AB9DB5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 May 2025 15:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DD6D505934
	for <lists+linux-kernel@lfdr.de>; Fri, 16 May 2025 13:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10771A23A9;
	Fri, 16 May 2025 13:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Psz7bA37"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF911190072
	for <linux-kernel@vger.kernel.org>; Fri, 16 May 2025 13:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747402850; cv=none; b=dv8ZDuqqzsSiZViNSG1KETo6k3j6Oryr1QU83PeZLLoJbauV9DVhMHopJXyvPpzreER5Ivsy/j9dZnxQWNcDpRm9UZbKMn13DRk2s5ecaewTUz1tcQbkm1ARC63bTf5L3J8S7cRCtFks+lz5+EGXugXI9BoBd2syGIzD54wDjZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747402850; c=relaxed/simple;
	bh=KH25AJTJC+5nYO4msKcbQW9YOSJcLDaN3X5UGto+bf8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Wpnn7o0VK57WZrt/u1WHCByPODUh/5mccFzYunsVqvNLS6UDm+3Un8RXUVEYpblPAR5FMqwNtvQCcqtI0LXGvyx6zynbUeK/RaWGDXeDdMjILsDPbwv4iuL/nrlNgmU730BiKbKeC9PvRboDY6tHxMw+MiVaFKe5c13tWZ7SCZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Psz7bA37; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43d0830c3f7so14932155e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 May 2025 06:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747402847; x=1748007647; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vbxz6VgsYQpmquuEf48m6ENRRnMX9gVzHugVlK3Ks6k=;
        b=Psz7bA37I7ISEiMXkwoqGD+sedDdOy38JEeh15rppzr18JkCIYV44LUChzeHCEXMya
         twk2VyXiky42TORTh6LfLRrIigt60J1hFbdrg41z6Ng9V+pdsRzcDELAJUUvT68CQmsT
         feP/g0RvPXo7QtNX7se9jylZdl3zK78FvUHGHiqMvEQotDjtR/vxdsIerOekXJJ0rCFH
         yg4CVVwuEm386XHOtWqcDxNgeFvOphxgi3pquzwThvxRGTJatJC+5vGZtI1MWXbcydD0
         0ND5vjjGE1WQ/LQTFvnTchqgqNwIeaITXn7oQUQKRzoBNI0clXMRMElcgVqQ0pcCUSKj
         Z/Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747402847; x=1748007647;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vbxz6VgsYQpmquuEf48m6ENRRnMX9gVzHugVlK3Ks6k=;
        b=kmeV0BAhMrwyM7sY9k03kCnn0ibRQhd04qh4cldByoKCyizij6udjT/J3oFAs3CDRA
         S37R8XgMaLJtZatoDEE9H+QVPeTlXUnRor8Xx12043nftJ3bJoVFxJFjLFjD99ZclkWZ
         e1ySMCfyFDvoiuQ3qs4gYQKjCVBuFDJKgxuZLEgwOTIx+fp9Nj2aYnfFOAUS8CHsdbqu
         j6LwTFpiIMv7DmWSsfp9pgsmT6PPELWu6+IzhUibDnTwdCtCw0g/jLS22Pp9ofs/iGiM
         rAP2HT3wic9ZZtbrf0n1Bs2gUWg9FvgdESzszBR6zBfwOAYc73izF8AvOnNbxH20pou9
         +iTA==
X-Forwarded-Encrypted: i=1; AJvYcCU6tC1FO0290g8MlJpQoWklKSFxkhSX1VJOKsDQ2DnSGwIwgxufM/badvfN5DuFJcNg2ZXNToXb+UcSL6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3wpPU6oMTAdmusy+8uEMP11zkyUKfc35IWvXYaiFgHwiHzDTL
	6x+EZckPH+a6IPapVMOs+ZFxi74Q9478uaGeA/ndg4pBIF96N2zXcwuCZkfY/vkpQG/z0zhKc/v
	3AxhgD8pZcz3e6y1dabysSA==
X-Google-Smtp-Source: AGHT+IEWs6z+aMdfnt/Nqv3/4XuvEER4z+Swr38ZCWgw9ZBInJe9N03F0hUkQVLXcRXpp3jXiSL7a/+YBquu8pJE
X-Received: from wmbfl14.prod.google.com ([2002:a05:600c:b8e:b0:43d:4ba5:b5d6])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:6748:b0:441:b698:3431 with SMTP id 5b1f17b1804b1-442fd67205fmr30489785e9.28.1747402847441;
 Fri, 16 May 2025 06:40:47 -0700 (PDT)
Date: Fri, 16 May 2025 14:40:13 +0100
In-Reply-To: <20250516134031.661124-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250516134031.661124-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.49.0.1101.gccaa498523-goog
Message-ID: <20250516134031.661124-8-vdonnefort@google.com>
Subject: [PATCH v5 07/25] tracing: Add events/ root files to trace remotes
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	jstultz@google.com, qperret@google.com, will@kernel.org, 
	kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Just like for the kernel events directory, add 'enable', 'header_page'
and 'header_event' at the root of the trace remote events/ directory.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 2aa7f77bdba0..8f94ccf3f55e 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -604,7 +604,8 @@ int ring_buffer_print_page_header(struct trace_buffer *buffer, struct trace_seq
 	trace_seq_printf(s, "\tfield: char data;\t"
 			 "offset:%u;\tsize:%u;\tsigned:%u;\n",
 			 (unsigned int)offsetof(typeof(field), data),
-			 (unsigned int)buffer->subbuf_size,
+			 (unsigned int)(buffer ? buffer->subbuf_size :
+						 PAGE_SIZE - BUF_PAGE_HDR_SIZE),
 			 (unsigned int)is_signed_type(char));
 
 	return !trace_seq_has_overflowed(s);
diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
index 822cdd76e334..5065b162c8ef 100644
--- a/kernel/trace/trace_remote.c
+++ b/kernel/trace/trace_remote.c
@@ -710,10 +710,118 @@ static int remote_event_callback(const char *name, umode_t *mode, void **data,
 	return 0;
 }
 
+static ssize_t remote_events_dir_enable_write(struct file *filp, const char __user *ubuf,
+					      size_t count, loff_t *ppos)
+{
+	struct trace_remote *remote = file_inode(filp)->i_private;
+	u8 enable;
+	int i, ret;
+
+	ret = kstrtou8_from_user(ubuf, count, 10, &enable);
+	if (ret)
+		return ret;
+
+	guard(mutex)(&remote->lock);
+
+	for (i = 0; i < remote->nr_events; i++) {
+		struct remote_event *evt = &remote->events[i];
+
+		trace_remote_enable_event(remote, evt, enable);
+	}
+
+	return count;
+}
+
+static const struct file_operations remote_events_dir_enable_fops = {
+	.write = remote_events_dir_enable_write,
+};
+
+static ssize_t
+remote_events_dir_header_page_read(struct file *filp, char __user *ubuf, size_t cnt, loff_t *ppos)
+{
+	struct trace_seq *s;
+	int ret;
+
+	s = kmalloc(sizeof(*s), GFP_KERNEL);
+	if (!s)
+		return -ENOMEM;
+
+	trace_seq_init(s);
+
+	ring_buffer_print_page_header(NULL, s);
+	ret = simple_read_from_buffer(ubuf, cnt, ppos, s->buffer, trace_seq_used(s));
+	kfree(s);
+
+	return ret;
+}
+
+static const struct file_operations remote_events_dir_header_page_fops = {
+	.read = remote_events_dir_header_page_read,
+};
+
+static ssize_t
+remote_events_dir_header_event_read(struct file *filp, char __user *ubuf, size_t cnt, loff_t *ppos)
+{
+	struct trace_seq *s;
+	int ret;
+
+	s = kmalloc(sizeof(*s), GFP_KERNEL);
+	if (!s)
+		return -ENOMEM;
+
+	trace_seq_init(s);
+
+	ring_buffer_print_entry_header(s);
+	ret = simple_read_from_buffer(ubuf, cnt, ppos, s->buffer, trace_seq_used(s));
+	kfree(s);
+
+	return ret;
+}
+
+static const struct file_operations remote_events_dir_header_event_fops = {
+	.read = remote_events_dir_header_event_read,
+};
+
+static int remote_events_dir_callback(const char *name, umode_t *mode, void **data,
+				      const struct file_operations **fops)
+{
+	if (!strcmp(name, "enable")) {
+		*mode = 0200;
+		*fops = &remote_events_dir_enable_fops;
+		return 1;
+	}
+
+	if (!strcmp(name, "header_page")) {
+		*mode = TRACEFS_MODE_READ;
+		*fops = &remote_events_dir_header_page_fops;
+		return 1;
+	}
+
+	if (!strcmp(name, "header_event")) {
+		*mode = TRACEFS_MODE_READ;
+		*fops = &remote_events_dir_header_event_fops;
+		return 1;
+	}
+
+	return 0;
+}
+
 static int trace_remote_init_eventfs(const char *remote_name, struct trace_remote *remote,
 				     struct remote_event *evt)
 {
 	struct eventfs_inode *eventfs = remote->eventfs;
+	static struct eventfs_entry dir_entries[] = {
+		{
+			.name		= "enable",
+			.callback	= remote_events_dir_callback,
+		}, {
+			.name		= "header_page",
+			.callback	= remote_events_dir_callback,
+		}, {
+			.name		= "header_event",
+			.callback	= remote_events_dir_callback,
+		}
+	};
 	static struct eventfs_entry entries[] = {
 		{
 			.name		= "enable",
@@ -729,7 +837,8 @@ static int trace_remote_init_eventfs(const char *remote_name, struct trace_remot
 	bool eventfs_create = false;
 
 	if (!eventfs) {
-		eventfs = eventfs_create_events_dir("events", remote->dentry, NULL, 0, NULL);
+		eventfs = eventfs_create_events_dir("events", remote->dentry, dir_entries,
+						    ARRAY_SIZE(dir_entries), remote);
 		if (IS_ERR(eventfs))
 			return PTR_ERR(eventfs);
 
-- 
2.49.0.1101.gccaa498523-goog


