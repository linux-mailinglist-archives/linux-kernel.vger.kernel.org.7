Return-Path: <linux-kernel+bounces-636446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4481AACBA1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 18:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 591FC4E2B33
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 16:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282CA285414;
	Tue,  6 May 2025 16:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AM6VtBmN"
Received: from mail-lf1-f74.google.com (mail-lf1-f74.google.com [209.85.167.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B33289E34
	for <linux-kernel@vger.kernel.org>; Tue,  6 May 2025 16:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746550143; cv=none; b=poQxPgxF3el06NCHGlCer2adjPIs4FuI4u3GGMF8LStGiwflg3RGaTOesA2K29ZJcRhj+GtYKxkteMFH4Zyl7OqvClDWicJNVjDyf6H5UQ4jX922o1+4f7kU9cqmM+C7E5GHf83XMWMfBKRQkZU9i34ftBvfoAAxRw9KDjm3+Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746550143; c=relaxed/simple;
	bh=TjaTEjsg0+DXvyUXwwBtev0LdVcHX9+wqh45SuZo7+Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qhddExnKquRd6Smb+zNZjQNQKVRz8GkwpHafXD2Q26FmRcCH9T750o4oBH0XceFWIIDOf9ai6lfqe9i16mCV7irqulm3E7govtWn+D0EZPwO2vScG8lpnMeBe5Kt/cPNXf6wmepTcQx+03dMO/uLGxgcpX45tMA3PekoIYxopxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AM6VtBmN; arc=none smtp.client-ip=209.85.167.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Received: by mail-lf1-f74.google.com with SMTP id 2adb3069b0e04-5498963ebc3so3057873e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 May 2025 09:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746550140; x=1747154940; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/Jp1lLJLaGjaKoXy64OEgzLoF8SWUPuFbMZNzmgUGvY=;
        b=AM6VtBmNZzshHyEtMTlaoOzEyKyt3H4x3kTHf38DaA4oJXpqK/L7DckswcTrzanOu2
         FC6CWt6LlwuiAN0CgAD7dQ+LhVHWLSjx4oYSfhIKgaJieTqzSt4PCaP+Am2bsa1AfCxF
         j015/Rirk3Xj7vRDW9wOy3d0cGQsxDRxzJrcnnTzCXb0lJJOtmUN/DRjRagiAWGn3L8m
         d+j7LRlybIbmKbrKIyrmyvj6FLXzNIim8fr9EO/rw0u8fGC0V62ennUja4ziSxJjhrWw
         joU84LeW53wmwXtWJ+KQTRlXNbDLA/xePwC1EVGWHJmeXc99BJ9nP4l+ULWx9HgCdB5r
         xhww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746550140; x=1747154940;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/Jp1lLJLaGjaKoXy64OEgzLoF8SWUPuFbMZNzmgUGvY=;
        b=nK7c9NgE9eN/LJ2l0EexEBO8lpUon/ZKZkfMhhadG/uh1dNzEO7mSyWtPx5eUnc0bd
         6KiV9liS4Y4bp3oIc32KdxmPPSPHtEw098KFjsNHaucdtAdnaNcX3ZZAdC8bziCxS+zy
         wXQJl95q3KVtaY1Jh0hRxJF3CDr5XYkZltmLXXFrkWFVf8U4N/3yXumGNi8uERH+9xqv
         E65pI3xsznuWgetdkE9RLfD/p0yLcGBgeBGWec1/3q7rhJAPuInUHgOwjrrN6jc6Flt1
         MW/89g/37w5Fes6eSZiE5xsMwvmwDcicu8Rb6kCha+iGVELlxxR2dyQs+aSd9hbzmjb6
         LTeA==
X-Forwarded-Encrypted: i=1; AJvYcCVGI5p+Oc86g08+iINaAgEWbxfSMHpah45th3ohKp6vFg7Ot4MgFgUR83J8SgOR9Cfna1MelgxoJ+59n6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiWjYKa4VK1rDcpXyrzn4lNLd+0gSGFC+DmRPDiXssuqWoWGVG
	ppITeEyDzRAHURAnfpMitXzBallSUAOlS/A22zOUXpZc3eTlpNdBKK/GbfAK0mkXhckaeEPfBVf
	XkUUFh5SOh4TGPzUnTQ==
X-Google-Smtp-Source: AGHT+IGiXAgVMRbfLIS8SOyIvtLGncb5XoCWTw3YHC2KCY3kpynNJbuNPStX2fauF3TpS7pG9j8sT4PCVtP6V84+
X-Received: from wmbdq15.prod.google.com ([2002:a05:600c:64cf:b0:441:d228:3918])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600d:1c:b0:43c:fda5:41e9 with SMTP id 5b1f17b1804b1-441c4933d05mr112672305e9.31.1746550129253;
 Tue, 06 May 2025 09:48:49 -0700 (PDT)
Date: Tue,  6 May 2025 17:48:02 +0100
In-Reply-To: <20250506164820.515876-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250506164820.515876-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.49.0.967.g6a0df3ecc3-goog
Message-ID: <20250506164820.515876-7-vdonnefort@google.com>
Subject: [PATCH v4 06/24] tracing: Add events/ root files to trace remotes
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
index a96a0b231fee..cff1e700d4b7 100644
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
index 00ef80da043b..5c9f2b07941f 100644
--- a/kernel/trace/trace_remote.c
+++ b/kernel/trace/trace_remote.c
@@ -707,10 +707,118 @@ static int remote_event_callback(const char *name, umode_t *mode, void **data,
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
@@ -726,7 +834,8 @@ static int trace_remote_init_eventfs(const char *remote_name, struct trace_remot
 	bool eventfs_create = false;
 
 	if (!eventfs) {
-		eventfs = eventfs_create_events_dir("events", remote->dentry, NULL, 0, NULL);
+		eventfs = eventfs_create_events_dir("events", remote->dentry, dir_entries,
+						    ARRAY_SIZE(dir_entries), remote);
 		if (IS_ERR(eventfs))
 			return PTR_ERR(eventfs);
 
-- 
2.49.0.967.g6a0df3ecc3-goog


