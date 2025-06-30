Return-Path: <linux-kernel+bounces-709654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0009FAEE08A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jun 2025 16:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16F5D16AF8E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jun 2025 14:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B6328C2C4;
	Mon, 30 Jun 2025 14:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jQ5wqecQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B0028FAAC
	for <linux-kernel@vger.kernel.org>; Mon, 30 Jun 2025 14:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751293246; cv=none; b=UvENn6dwKxvSWOexY4NlCS8s32rPH3PetsteJjSeulRD4ybwszmlbzO/OlQYyFttPUFRkWQd4yZH1gbqIUkq5RwEvrZOBxEx1dvVxyZp8nwss8A04pXDAFR/QNw2F5HPFRX05Nq9bWchn6NbAi1Gv50lhp3jIQ/KNY6i6AuRdiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751293246; c=relaxed/simple;
	bh=z+vrdGt+E7vi7zWe8/QRIdf6JmwA3MGFwbNW8p1J80w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lQ9vMP2ebWqgsof9Tks+Ahc33PUc8giMi3y3eaV0cKzw2WxXYccid+8BqnLx81YBg8HhN7ecE6hPtl5Xi5QmzqsKb6TnFnTGuNg9GEWigpdd23i0jcO4wGruE8CJspOtUiy/k/4xHqMyiO2o8ThPxlT4EgCegQNqp3g2n2K6+tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jQ5wqecQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751293242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pOU168osJCt4Z5drZRRfb6m13pzDoAsHwXIgB0F76VE=;
	b=jQ5wqecQHVWw78XO5gWW7eD64CMj58po0neywh+JL0sZ+u3c801RqZMPIw2yJTjmeO0WRC
	9NiejHWjDZWhq8NWRyqnEqV3AM6/fqv2E7eKM/zYIrx90YbinBD/iZLNK3ptMjmoLTttRn
	MSS3yXw0aS2/mJvcudQa9Kc2/Ry0r94=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-161-qHuLkgCzNyanoNZtrUvFeg-1; Mon,
 30 Jun 2025 10:20:41 -0400
X-MC-Unique: qHuLkgCzNyanoNZtrUvFeg-1
X-Mimecast-MFC-AGG-ID: qHuLkgCzNyanoNZtrUvFeg_1751293240
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D1B5018DA5D2;
	Mon, 30 Jun 2025 14:20:39 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.22.9])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3542D19560A7;
	Mon, 30 Jun 2025 14:20:36 +0000 (UTC)
From: Gabriele Paoloni <gpaoloni@redhat.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Gabriele Paoloni <gpaoloni@redhat.com>
Subject: [RFC PATCH v3] tracing: add testable specifications for event_enable_write/read
Date: Mon, 30 Jun 2025 16:20:32 +0200
Message-ID: <20250630142032.3322-1-gpaoloni@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

This patch implements the documentation of event_enable_write and
event_enable_read in the form of testable function's expectations.

Signed-off-by: Gabriele Paoloni <gpaoloni@redhat.com>
---
Following the discussion in v1 (see [1]), v3 adds improvements with
the "Context" specifications and the definition of the assumptions
of use for the correct invocation of the documented functions.

[1] https://lore.kernel.org/linux-trace-kernel/20250612104349.5047-1-gpaoloni@redhat.com/

v3 has been sent as in v2 there is a mistake in the return value
specifications of event_enable_read
---
 kernel/trace/trace_events.c | 80 +++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 120531268abf..aa9992b0f43c 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -1771,6 +1771,51 @@ static void p_stop(struct seq_file *m, void *p)
 	mutex_unlock(&event_mutex);
 }
 
+/**
+ * event_enable_read - read from a trace event file to retrieve its status.
+ * @filp: file pointer associated with the target trace event;
+ * @ubuf: user space buffer where the event status is copied to;
+ * @cnt: number of bytes to be copied to the user space buffer;
+ * @ppos: the current position in the buffer.
+ *
+ * This is a way for user space executables to retrieve the status of a
+ * specific event
+ *
+ * Function's expectations:
+ * - This function shall lock the global event_mutex before performing any
+ *   operation on the target event file and unlock it after all operations on
+ *   the target event file have completed;
+ * - This function shall retrieve the status flags from the file associated
+ *   with the target event;
+ * - This function shall format the string to report the event status to user
+ *   space:
+ *   - The first character of the string to be copied to user space shall be
+ *     set to "1" if the enabled flag is set AND the soft_disabled flag is not
+ *     set, else it shall be set to "0";
+ *   - The second character of the string to be copied to user space shall be
+ *     set to "*" if either the soft_disabled flag or the soft_mode flag is
+ *     set, else it shall be set to "\n";
+ *   - The third character of the string to be copied to user space shall b
+ *     set to "\n" if either the soft_disabled flag or the soft_mode flag is
+ *     set, else it shall be set to "0";
+ *   - Any other character in the string to be copied to user space shall be
+ *     set to "0";
+ * - This function shall invoke simple_read_from_buffer() to perform the copy
+ *   of the kernel space string to ubuf.
+ *
+ * Assumptions of Use:
+ * - The caller shall  pass cnt equal or greater than the length of the string
+ *   to be copied to user space;
+ * - Any read operation on a file descriptor, unless it is the first operation
+ *   following a trace event file open, shall be preceded by an lseek
+ *   invocation to reposition the file offset to zero.
+ *
+ * Context: process context, locks and unlocks event_mutex.
+ *
+ * Return: the number of copied bytes on success, -ENODEV if the event file
+ * cannot be retrieved from the input filp, any error returned by
+ * simple_read_from_buffer.
+ */
 static ssize_t
 event_enable_read(struct file *filp, char __user *ubuf, size_t cnt,
 		  loff_t *ppos)
@@ -1801,6 +1846,41 @@ event_enable_read(struct file *filp, char __user *ubuf, size_t cnt,
 	return simple_read_from_buffer(ubuf, cnt, ppos, buf, strlen(buf));
 }
 
+/**
+ * event_enable_write - write to a trace event file to enable/disable it.
+ * @filp: file pointer associated with the target trace event;
+ * @ubuf: user space buffer where the enable/disable value is copied from;
+ * @cnt: number of bytes to be copied from the user space buffer;
+ * @ppos: the current position in the buffer.
+ *
+ * This is a way for user space executables to enable or disable event
+ * recording.
+ *
+ * Function's expectations:
+ * - This function shall copy cnt bytes from the input ubuf buffer to a kernel
+ *   space buffer and shall convert the string within the kernel space buffer
+ *   into a decimal base format number;
+ * - This function shall lock the global event_mutex before performing any
+ *   operation on the target event file and unlock it after all operations on
+ *   the target event file have completed;
+ * - This function shall check the size of the per-cpu ring-buffers used for
+ *   the event trace data and, if smaller than TRACE_BUF_SIZE_DEFAULT, expand
+ *   them to TRACE_BUF_SIZE_DEFAULT bytes (sizes larger than
+ *   TRACE_BUF_SIZE_DEFAULT are not allowed);
+ * - This function shall invoke ftrace_event_enable_disable to enable or
+ *   disable the target trace event according to the value read from user space
+ *   (0 - disable, 1 - enable);
+ * - This function shall increase the file position pointed by ppos by the
+ *   number of bytes specified by cnt;
+ *
+ * Context: process context, locks and unlocks event_mutex.
+ *
+ * Return: the number of written bytes on success, any error returned by
+ * kstrtoul_from_user, -ENODEV if the event file cannot be retrieved from the
+ * input filp, any error returned by tracing_update_buffers, any error returned
+ * by ftrace_event_enable_disable, -EINVAL if the value copied from the user
+ * space ubuf is different from 0 or 1.
+ */
 static ssize_t
 event_enable_write(struct file *filp, const char __user *ubuf, size_t cnt,
 		   loff_t *ppos)
-- 
2.48.1


