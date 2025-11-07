Return-Path: <linux-kernel+bounces-889574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0048CC3DF0B
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 01:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C298188D77C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 00:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79AD7C13B;
	Fri,  7 Nov 2025 00:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SK86zsrn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A5B28F5
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 00:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762473884; cv=none; b=olPj3X4yhQu/n4shxc+4pYGmx5vADNfrqPv5vdp5vUXKGFqZ/BAXK3rtGCws5cf1NX6ERcYdzc+Dd+7gvl/r3GFmFh1CwRu+fmygWQX2GnBXe2AtShzQzFcOGQi5SnGhRVwZVh90mAyHMorRfTmOlCcuP8QbY2u10PHLcFpuGeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762473884; c=relaxed/simple;
	bh=Ddyy+JqJXXOPQA0GjAtdTla8OfD3JAI3h8S9cXQoVZY=;
	h=Date:From:To:Cc:Subject:Message-Id:Mime-Version:Content-Type; b=dIJ2pVkyE4qtRS7nlZMrM+fpXIerXGnReMpwUh0feIYp6UrykqTwBDP7AJkTArF9dXeCVm6KTJMxxQA7PrSf4gGqd/28hSZeZcwhbzoNVGVWQ0l1W80qMvUC2Ry0xjh9fsJC6XAN8RBhwy26qIKXUo9mMmzfzqTa5MU3G2iXOmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SK86zsrn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1292C116D0;
	Fri,  7 Nov 2025 00:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762473884;
	bh=Ddyy+JqJXXOPQA0GjAtdTla8OfD3JAI3h8S9cXQoVZY=;
	h=Date:From:To:Cc:Subject:From;
	b=SK86zsrnrRn6q4qsTwTXibqEjBYm9ZzmqX4u76m6w7WRllW7HXhgvQWoHBS1OoPHg
	 FnGyAA1wi8/Dx4Y8Gp4ZaO0OmLtNeqrsyhcWIFdAZql4Cx134yZ5j7pIxJ+jiauz9s
	 C1Xx1chHd5A8Y5f96ZtcerbiCx9Fxs2DBTNOarLrk05v0SrzMOGGWoPXH5cXeBlSLA
	 kPku3qIDHDJo+XVaQdcBkRM6SMBzW9zJJEGjDCuu/Y4o2gmrju26x7o3jUXUVgQSCZ
	 bCq+ZNW4BCDXFGSoYmTbQiFi7b7wqckUnGSEhwE0BLFez/+VytyyRMV3th6rkwMjnC
	 rLcytJPbLdIAw==
Date: Fri, 7 Nov 2025 09:04:40 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masami Hiramatsu (Google) <mhiramat@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 linux-kernel@vger.kernel.org, Beau Belgrave <beaub@linux.microsoft.com>
Subject: [GIT PULL] probes: Fixes for v6.18-rc4
Message-Id: <20251107090440.388a9fe7b54cfc7264788f12@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Linus,

Probes fixes for v6.18-rc4

- tprobe-events: Fix to register tracepoint correctly
  tprobe-events missed to set tracepoint data structure before
  registering callback when enabling it. This sets it correctly.
- tprobe-events: Fix to put tracepoint_user when disable the event.
  tprobe-events missed to unregister tracepoint callback when the
  event is disabled. This ensures to unregister it.


Please pull the latest probes-fixes-v6.18-rc4 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
probes-fixes-v6.18-rc4

Tag SHA1: f0e218db626a4af0f5a6e8ee7fefabb7deeb5370
Head SHA1: c91afa7610235f89a5e8f5686aac23892ab227ed


Masami Hiramatsu (Google) (2):
      tracing: tprobe-events: Fix to register tracepoint correctly
      tracing: tprobe-events: Fix to put tracepoint_user when disable the tprobe

----
 kernel/trace/trace_fprobe.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)
---------------------------
diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
index ad9d6347b5fa..8001dbf16891 100644
--- a/kernel/trace/trace_fprobe.c
+++ b/kernel/trace/trace_fprobe.c
@@ -106,13 +106,14 @@ static struct tracepoint_user *__tracepoint_user_init(const char *name, struct t
 	if (!tuser->name)
 		return NULL;
 
+	/* Register tracepoint if it is loaded. */
 	if (tpoint) {
+		tuser->tpoint = tpoint;
 		ret = tracepoint_user_register(tuser);
 		if (ret)
 			return ERR_PTR(ret);
 	}
 
-	tuser->tpoint = tpoint;
 	tuser->refcount = 1;
 	INIT_LIST_HEAD(&tuser->list);
 	list_add(&tuser->list, &tracepoint_user_list);
@@ -1513,6 +1514,10 @@ static int disable_trace_fprobe(struct trace_event_call *call,
 	if (!trace_probe_is_enabled(tp)) {
 		list_for_each_entry(tf, trace_probe_probe_list(tp), tp.list) {
 			unregister_fprobe(&tf->fp);
+			if (tf->tuser) {
+				tracepoint_user_put(tf->tuser);
+				tf->tuser = NULL;
+			}
 		}
 	}
 
-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

