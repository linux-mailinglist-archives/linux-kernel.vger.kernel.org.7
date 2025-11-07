Return-Path: <linux-kernel+bounces-890081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59361C3F341
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 10:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AC4A3B17CC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 09:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8BB331813F;
	Fri,  7 Nov 2025 09:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H98l2CrB"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D35304BD3
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 09:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762508342; cv=none; b=gEcjmK1SJxi0fg/BZ9wasJY3nrae0GdTK7Rb62Oovg/JmkzanIsvWkNfbzUji2F3Hd6QcRWtMYLyvHggVzkNGZEckaI8rgvFBM0U8DI6ZRI7e9hG/w2Ur/0l4XcPfhUm+G3RabpqqS1N70sg5P7kQN9dS1XHHk2pY1Dh/Xwqt8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762508342; c=relaxed/simple;
	bh=20KZ/x5nrqsEIirl5ZplFAB6PraCZm59OdztjlsBQWs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Nhj3Mb1m7bE1qGawJAThvbJ0ahw2oC/P487C/KaiNlWWrPOJ02Wua0p+Z3n1p5pofqhMKx6PM/PHj41VLYFwX0A6+mQN7JtkAc+KZOwnxj5XUvQ7rq9Bi0EFzpnmRfz0JDCaXEf24EpxaIZXu3OJHfV2o7gTUzQvLHBQitILHno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H98l2CrB; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-429cdb0706aso366882f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 01:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762508338; x=1763113138; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iJcchofQoVMS00YA2MOITdHnNd8nQYavzgR4H5PvjU8=;
        b=H98l2CrB9FktGzBAuzKid6JtEtM03jSetQfwQqeg0XBmsRyJ1KWF4AM9RYzGMnik/3
         7IgFIyaOeU0NO/35V96GdYcNRCWIgFgQxIa4C/0XBJKW/ZXCPWbb5Lrr2uWGB58HO5tQ
         +cYR6f2bPAf+FB5Ufbm+lp1tTUVJ47Ksd9f+5FpD4TKXy8s3YoLqErxNmeTAyz72Ts2n
         fqqprTd/uBLfRgFGUXJo/52DcstbOTItTRF9Er4OAXa9O42flWzz8LzLC+3Rvfl1poYG
         BcK+CQKhRbtfYXTF6VPLij1AwfzKih4a4M4fKiKFJrgAzr1Abyg1rzfwJvtmw/kt9HC7
         nx0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762508338; x=1763113138;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iJcchofQoVMS00YA2MOITdHnNd8nQYavzgR4H5PvjU8=;
        b=R96sfUeDnIq+BZmhHT4iC+RcynivFZLobWXSK+XEITvpJ2m8lWXa5DJzBXTTX1rx7x
         7Y23YD8BQMab5OTJ2QfHguZsa+Wu0JSPt1JN5ORft29o1dXwfbPe6WKuY5P9wqN4YkSR
         AcFR2E7PzatlubTtDLf7c3ny5KQDVHrIbLcOhruNTfVl5Ws6l7ngZvtaXHkTUQoG7J1B
         pgtYKeAEgRRerPdWdVXNo/pzF+s1Gxl5SRzIrdCkhMdddMY64KaOAfmwSB+CkHNgkhox
         p/sW+1nKkeh6sLKIzLINy4RyMHnvjKrBiZb5a5rN1ts7MzZ4EkCEdRvn0Rt3VL50BvVs
         SsAw==
X-Forwarded-Encrypted: i=1; AJvYcCXr1hWZ3D99XrHz8ARrdMVrSTS5dQGN8jUVGlcRJGUDVjmt6Z/oYW5D0XsCJDout/+gZLYOIjCl+81GpoE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU51aHFzgQ49HQeGMcxNIazAOXVyLOAZ1+Evb7Fgxh3nxvBXl9
	c9Joir+TZd0mGID8bm2CSqEmwDQza+5W/aZnq7dbzVWlO1bZ6r9Ra/3/HqbiQXhj2mwDmdxE3qe
	a6JjB9cMEWhjuZLh7UV3Ezg==
X-Google-Smtp-Source: AGHT+IFZC5BqbrsKWQKCQ336VVxlGCY+mQ6LwsxcCpJ4Gtknluos4raBCaFp3StIQwp/OhM1qMb5B7Y9hxL0l4eT
X-Received: from wma14.prod.google.com ([2002:a05:600c:890e:b0:477:10f8:4597])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:46ce:b0:45b:80ff:58f7 with SMTP id 5b1f17b1804b1-4776bcceb98mr20269535e9.36.1762508338137;
 Fri, 07 Nov 2025 01:38:58 -0800 (PST)
Date: Fri,  7 Nov 2025 09:38:22 +0000
In-Reply-To: <20251107093840.3779150-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251107093840.3779150-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251107093840.3779150-11-vdonnefort@google.com>
Subject: [PATCH v8 10/28] tracing: Add events/ root files to trace remotes
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	jstultz@google.com, qperret@google.com, will@kernel.org, 
	aneesh.kumar@kernel.org, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Just like for the kernel events directory, add 'enable', 'header_page'
and 'header_event' at the root of the trace remote events/ directory.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 4cc5da5cdc87..41975b92a960 100644
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
index 0131fa8e177a..4f2b67d1bfec 100644
--- a/kernel/trace/trace_remote.c
+++ b/kernel/trace/trace_remote.c
@@ -1078,10 +1078,145 @@ static int remote_event_callback(const char *name, umode_t *mode, void **data,
 	return 0;
 }
 
+static ssize_t remote_events_dir_enable_write(struct file *filp, const char __user *ubuf,
+					      size_t count, loff_t *ppos)
+{
+	struct trace_remote *remote = file_inode(filp)->i_private;
+	int i, ret;
+	u8 enable;
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
+static ssize_t remote_events_dir_enable_read(struct file *filp, char __user *ubuf, size_t cnt,
+					     loff_t *ppos)
+{
+	struct trace_remote *remote = file_inode(filp)->i_private;
+	const char enabled_char[] = {'0', '1', 'X'};
+	char enabled_str[] = " \n";
+	int i, enabled = -1;
+
+	guard(mutex)(&remote->lock);
+
+	for (i = 0; i < remote->nr_events; i++) {
+		struct remote_event *evt = &remote->events[i];
+
+		if (enabled == -1) {
+			enabled = evt->enabled;
+		} else if (enabled != evt->enabled) {
+			enabled = 2;
+			break;
+		}
+	}
+
+	enabled_str[0] = enabled_char[enabled == -1 ? 0 : enabled];
+
+	return simple_read_from_buffer(ubuf, cnt, ppos, enabled_str, 2);
+}
+
+static const struct file_operations remote_events_dir_enable_fops = {
+	.write = remote_events_dir_enable_write,
+	.read = remote_events_dir_enable_read,
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
+		*mode = TRACEFS_MODE_WRITE;
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
@@ -1097,7 +1232,8 @@ static int trace_remote_init_eventfs(const char *remote_name, struct trace_remot
 	bool eventfs_create = false;
 
 	if (!eventfs) {
-		eventfs = eventfs_create_events_dir("events", remote->dentry, NULL, 0, NULL);
+		eventfs = eventfs_create_events_dir("events", remote->dentry, dir_entries,
+						    ARRAY_SIZE(dir_entries), remote);
 		if (IS_ERR(eventfs))
 			return PTR_ERR(eventfs);
 
-- 
2.51.2.1041.gc1ab5b90ca-goog


