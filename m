Return-Path: <linux-kernel+bounces-843623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 01763BBFDB2
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 02:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A2DE534C2BA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 00:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8571B5EB5;
	Tue,  7 Oct 2025 00:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vOO0yupP"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FB41A9FB8
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 00:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759797358; cv=none; b=FQzG58psGnhWcHa82w7DbBA/Dc56YRET1pAgKsmrhlSfBfllKSJ4Zm/dYdK/8CpA95DaNvxhV3gngtroP5THYZeJnPjLgpMKcjWIRmbGpZ8MqoX0yEDXw9ASaywvPWA7yNC8Y98cYljrAFk+Rbq9oUCxnUBWVARXzjzx/jtPHwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759797358; c=relaxed/simple;
	bh=eaYVbAhT4lR/ZZ5Jro1HbUESdMb7AvVKpDnCTSt+6g8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=se1fuvE+W32Ewua2EYuwZVaADnucS3DAfo6g8GZFfaTobZrh9O9v1svKDwQLqh1sf2Sj9UpK0LLZVfyafbcixjr7tv4TuZJCmuSiBZijq3TArH3mTZ8Yv4rM7Z0t+cc87BfJAfnGx8nJM1/FxCEplrtxNEJIOLzDGOjZQtLJSy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--runpinglai.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vOO0yupP; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--runpinglai.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2711a55da20so34174285ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 17:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759797356; x=1760402156; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Y6HSIAmMJUhDqfzrB/fS5/kaQRYPRIDkYIlVlDXHnEY=;
        b=vOO0yupPgSf8x/G82WTBytGAtwDlFEcwxaMKzjZf+tykD1yE9LqICuSeXdoVUcp7bT
         lJLNHMSbS9S+KXY2jUqv3JmHPfqN/2qtD3TKMHwydv1yZaQzgiUVyZdC0z6pWGoAjNZC
         lzTrTKyNhUfDdHjKVeDgdKapx6TE8HqIL6PhfnvVTIOQqNyIpJIkzDWCWFoaWYwsmudV
         OTRvAV0kbNK7MXhrzRbNmHo0pLRnQbSA7dtRl/q7XtMoohqPGfkcCnNl4m4gxlsdlSAp
         BsFVUNYZcC/CywEb3iBvthTs5FFKzdmQAnURVcAth+PppETMegLEhMWR9iZ77uBsR2gN
         BRtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759797356; x=1760402156;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y6HSIAmMJUhDqfzrB/fS5/kaQRYPRIDkYIlVlDXHnEY=;
        b=WqT+rEdkHGLDvNUJjrhEKc3mVirqLaYp1HtKJrr0YCb07jbEbZFU2OfjtMxwr998L0
         N7Mg4/3vPopemdxGWWrqLY6tirtuwWwWMPYvbxczO1EAZC2dP62cvchj9w+vtufYoV+G
         UcELsZT2fdCBF+vv9+KtyyEckpTCyJj0VfVj5omHXctQXYuGetCHGo3k4v2ymqSX65MS
         7QprxE0rYB1nhwb40EXeM+i9V45bzDSjnRg6TN8rq5zkdtjuzuWGFs7P5dQjMSj2wpL1
         3+dYDclRJ164Xa7uMXZLCswlc5DhMa5LHGjaN1wjl0FFJA6LH+cqs2rmccVRkM1sO9em
         UW3w==
X-Forwarded-Encrypted: i=1; AJvYcCXpFabcq5w1/WVM1/Q6LXO1ih5KlaLQg6KmuYABYHtMtJUrPg43snnVBJYf72+mEqlZiZ1T90HAEDfJyVc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAfiP47f4uoF0drbs3hlW7P0cVtCZ4+xvinYDH+cQoWJmnNrQ/
	KXDzx4r7/LbTr/pqDiIk3Gxd5HYxp7YP6vDrz9nRO3izcwQSbw3CVVWl8nMyaNKKD3Xtsvwf2/1
	bLzF8QGPIOVDR7OhuWGyMpQ==
X-Google-Smtp-Source: AGHT+IGrHmHhj30VeewmLKDwaHhCJ86g6aH0nKGtqdD2dWGpbW474Z1gxjM8uvB35pCImQIRal7TzTHgTluIfL0A
X-Received: from plhy5.prod.google.com ([2002:a17:902:d645:b0:264:d7d1:2748])
 (user=runpinglai job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:1b4f:b0:28e:8c3a:fb02 with SMTP id d9443c01a7336-28e9a566888mr176712275ad.14.1759797356148;
 Mon, 06 Oct 2025 17:35:56 -0700 (PDT)
Date: Tue,  7 Oct 2025 00:34:17 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251007003417.3470979-2-runpinglai@google.com>
Subject: [PATCH v1] Revert "tracing: Fix tracing_marker may trigger page fault
 during preempt_disable"
From: Runping Lai <runpinglai@google.com>
To: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Runping Lai <runpinglai@google.com>, Wattson CI <wattson-external@google.com>, 
	kernel-team@android.com, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This reverts commit 3d62ab32df065e4a7797204a918f6489ddb8a237.

It's observed on Pixel 6 that this commit causes a severe functional
regression: all user-space writes to trace_marker now fail. The write
does not goes through at all. The error is observed in the shell as
'printf: write: Bad address'. This breaks a primary ftrace interface
for user-space debugging and profiling. In kernel trace file, it's
logged as 'tracing_mark_write: <faulted>'. After reverting this commit,
functionality is restored.

Signed-off-by: Runping Lai <runpinglai@google.com>
Reported-by: Wattson CI <wattson-external@google.com>
---
 kernel/trace/trace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 156e7e0bf559..bb9a6284a629 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -7213,7 +7213,7 @@ static ssize_t write_marker_to_buffer(struct trace_array *tr, const char __user
 	entry = ring_buffer_event_data(event);
 	entry->ip = ip;
 
-	len = copy_from_user_nofault(&entry->buf, ubuf, cnt);
+	len = __copy_from_user_inatomic(&entry->buf, ubuf, cnt);
 	if (len) {
 		memcpy(&entry->buf, FAULTED_STR, FAULTED_SIZE);
 		cnt = FAULTED_SIZE;
@@ -7310,7 +7310,7 @@ static ssize_t write_raw_marker_to_buffer(struct trace_array *tr,
 
 	entry = ring_buffer_event_data(event);
 
-	len = copy_from_user_nofault(&entry->id, ubuf, cnt);
+	len = __copy_from_user_inatomic(&entry->id, ubuf, cnt);
 	if (len) {
 		entry->id = -1;
 		memcpy(&entry->buf, FAULTED_STR, FAULTED_SIZE);
-- 
2.51.0.618.g983fd99d29-goog


