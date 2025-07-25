Return-Path: <linux-kernel+bounces-745798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73238B11EEA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 14:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 021047BDADB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 12:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D892EE28D;
	Fri, 25 Jul 2025 12:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a8fb0VNb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561C52ECD08
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 12:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753447326; cv=none; b=pEzGPHUIzimpqBCrZ3/Uo0BczOmjaeW+LoZXPWF1bpwAS/Rl4xQCSaw5423Bu3x3SMncEBqOOEUldmmJCEmvxBVR2AgF5IxMc/FfvQ/3mPhppGki2uPHBdoPzjUA5pldkKh3ZqvsWWunFsHM+Fq0RCistZFgdwMHFk9BsUVbF04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753447326; c=relaxed/simple;
	bh=HpbKDvo95agyRxLtCEKsJPtUQsdSgl9GXx/LyY8SJmk=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=EHtbIFRjc/vdWukwmGR+l3dUM2ZVLOHXod5To5jeCYZbN6NK4PVUpCq9ESkH3Jll8kaOWfrnS//5KRiEvE8QyFNNHaS1hpYbt7ZGz7gfnoPmyzS7SljX+NaP28FvOfTTWLEqEGSA7tqfgVVcIE0nEupQDBZutHhJiXHynXk6gJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a8fb0VNb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32555C4CEFA;
	Fri, 25 Jul 2025 12:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753447326;
	bh=HpbKDvo95agyRxLtCEKsJPtUQsdSgl9GXx/LyY8SJmk=;
	h=Date:From:To:Cc:Subject:References:From;
	b=a8fb0VNbJd5uGLi8XwD/dMnmlQXWUxCI0ji9N89Egws8SaDP2IMaToFVouckhFPmu
	 sAn6+pxwuxC3lQn2P2ZsS9lvefqm6zVSpUqMDTKZ4/FRuPuDqhJ4/Avq5I5PJrIiN5
	 chZ+hp898zi9BPoyvUbqRsmmCqAMAr16dVuyMi0hKK2NNGlQC6b+6UA09k8Zqlt9ex
	 iN01+tZXs+634lXFRzs+JJ0fRkTCgZ1Pv/ZJVIgpd0cWQYK8Md9PlkJfWDLRJfkQYF
	 PVGfiFSXQRYVG3hKn5evdifKSCrR1/bgg3QfpZE6HrKruCHuWXjdLqjUAh/Hixju0H
	 1jdZo8uqpIyzw==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ufHkZ-00000001Cvr-2UNc;
	Fri, 25 Jul 2025 08:42:11 -0400
Message-ID: <20250725124211.444127890@kernel.org>
User-Agent: quilt/0.68
Date: Fri, 25 Jul 2025 08:41:52 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Arve =?utf-8?b?SGrDuG5u?= =?utf-8?b?ZXbDpWc=?= " <arve@android.com>,
 Todd Kjos <tkjos@android.com>,
 Martijn Coenen <maco@android.com>,
 Joel Fernandes <joelagnelf@nvidia.com>,
 Christian Brauner <brauner@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>,
 Carlos Llamas <cmllamas@google.com>,
 Alice Ryhl <aliceryhl@google.com>
Subject: [for-next][PATCH 7/9] binder: Remove unused binder lock events
References: <20250725124145.391996103@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Trace events can take up to 5K each when they are defined, regardless if
they are used or not. The binder lock events: binder_lock, binder_locked
and binder_unlock are no longer used.

Remove them.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Arve =?utf-8?b?SGrDuG5u?= =?utf-8?b?ZXbDpWc=?= " <arve@android.com>
Cc: Todd Kjos <tkjos@android.com>
Cc: Martijn Coenen <maco@android.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>
Link: https://lore.kernel.org/20250612093408.3b7320fa@batman.local.home
Fixes: a60b890f607d ("binder: remove global binder lock")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Acked-by: Carlos Llamas <cmllamas@google.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
---
 drivers/android/binder_trace.h | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/drivers/android/binder_trace.h b/drivers/android/binder_trace.h
index 16de1b9e72f7..97a78e5623db 100644
--- a/drivers/android/binder_trace.h
+++ b/drivers/android/binder_trace.h
@@ -34,27 +34,6 @@ TRACE_EVENT(binder_ioctl,
 	TP_printk("cmd=0x%x arg=0x%lx", __entry->cmd, __entry->arg)
 );
 
-DECLARE_EVENT_CLASS(binder_lock_class,
-	TP_PROTO(const char *tag),
-	TP_ARGS(tag),
-	TP_STRUCT__entry(
-		__field(const char *, tag)
-	),
-	TP_fast_assign(
-		__entry->tag = tag;
-	),
-	TP_printk("tag=%s", __entry->tag)
-);
-
-#define DEFINE_BINDER_LOCK_EVENT(name)	\
-DEFINE_EVENT(binder_lock_class, name,	\
-	TP_PROTO(const char *func), \
-	TP_ARGS(func))
-
-DEFINE_BINDER_LOCK_EVENT(binder_lock);
-DEFINE_BINDER_LOCK_EVENT(binder_locked);
-DEFINE_BINDER_LOCK_EVENT(binder_unlock);
-
 DECLARE_EVENT_CLASS(binder_function_return_class,
 	TP_PROTO(int ret),
 	TP_ARGS(ret),
-- 
2.47.2



