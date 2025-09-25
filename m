Return-Path: <linux-kernel+bounces-831556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D947EB9CFFF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 03:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 443C01BC450E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69CCD2DEA7E;
	Thu, 25 Sep 2025 01:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wbw7dCzR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00112DEA67
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 01:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758763109; cv=none; b=naxP0x2Oy//zkt092BF98kn/yn1nwbAQU7MBAi//TUyA6+s4BTPl3mjarSVX2lk4T7PABgixl6Gy5HxYnUT8u8quHwRpPAlAxAU0a6RbxxsNJiHa3Nowwa8P8wcD/DF/RZbAZdwyBtInZgyY/3d8GmhXr6Fzx6w/1NdzoHlL4lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758763109; c=relaxed/simple;
	bh=zg870Msoc1CsiWjg9XgKOgyuHQgiqznaHHZB1tdu+aU=;
	h=Date:From:To:Cc:Subject:Message-Id:Mime-Version:Content-Type; b=PVVPiFX/x8rXVoBJbTW8ZdqJwJj+XHgMASQvXgx8QjA6AEqNn4KPfsdIjZnAXA/8MvpdnuO9TaGl13FJrTF9sTov2jpGUg5AtAjnTnQklDnV9LI5sVoy7nK6LKGL02Qy9iu01YeCNW4u3ljG616c2rQZZrA/+CZYxsHYAeIR+TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wbw7dCzR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E808C4CEF8;
	Thu, 25 Sep 2025 01:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758763109;
	bh=zg870Msoc1CsiWjg9XgKOgyuHQgiqznaHHZB1tdu+aU=;
	h=Date:From:To:Cc:Subject:From;
	b=Wbw7dCzR6VTPFUjhJ52AdDzTXhpxetd0mR2bYMqgSrI2M+mu6tG11G3B1x5w9GKlP
	 lbKTAXEntueT9QVpZlfoKYJq6cqmc2bjAMY4IwsTot2gvjV9DGe+0BbWFOe0/muTL2
	 6H5PmGNN4/qQr6BM+Sek1DAy/y0iBPhgONXqxptUhcrCFQfadBKDAiD1IxKKabAWxw
	 PDPJdYT4wk44BMBPLpsCd0mVXal9ZiXIFeheXrBbJNOczdNmU/A5Gdj6FUKfI9Qj5K
	 VdWDqEHVAG9cyBjjPfLbR0IYI2KydS+IRprr0AuWQW6khKNuFD3YzJuXBTBmuwH5Nc
	 5hBO8fuVTJv9A==
Date: Thu, 25 Sep 2025 10:18:26 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masami Hiramatsu (Google) <mhiramat@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: [GIT PULL] probes: Fixes for v6.17-rc7
Message-Id: <20250925101826.671b15ad33f115bf0922aff2@kernel.org>
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

Probes fixes for v6.17-rc7

- fprobe: Even if there is a memory allocation failure, try to remove
  the addresses recorded until then from the filter. Previously we
  just skip it.
- tracing: dynevent: Add a missing lockdown check on dynevent. This
  dynevent is the interface for all probe events. Thus if there is no
  check, any probe events can be added after lock down the tracefs.


Please pull the latest probes-fixes-v6.17-rc7 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
probes-fixes-v6.17-rc7

Tag SHA1: 23003eb204ceabd753f1a937e2a34b3ed82809fc
Head SHA1: 456c32e3c4316654f95f9d49c12cbecfb77d5660


Masami Hiramatsu (Google) (2):
      tracing: fprobe: Fix to remove recorded module addresses from filter
      tracing: dynevent: Add a missing lockdown check on dynevent

----
 kernel/trace/fprobe.c         | 7 ++++---
 kernel/trace/trace_dynevent.c | 4 ++++
 2 files changed, 8 insertions(+), 3 deletions(-)
---------------------------
diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index c8034dfc1070..5a807d62e76d 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -428,8 +428,9 @@ static int fprobe_addr_list_add(struct fprobe_addr_list *alist, unsigned long ad
 {
 	unsigned long *addrs;
 
-	if (alist->index >= alist->size)
-		return -ENOMEM;
+	/* Previously we failed to expand the list. */
+	if (alist->index == alist->size)
+		return -ENOSPC;
 
 	alist->addrs[alist->index++] = addr;
 	if (alist->index < alist->size)
@@ -489,7 +490,7 @@ static int fprobe_module_callback(struct notifier_block *nb,
 	for (i = 0; i < FPROBE_IP_TABLE_SIZE; i++)
 		fprobe_remove_node_in_module(mod, &fprobe_ip_table[i], &alist);
 
-	if (alist.index < alist.size && alist.index > 0)
+	if (alist.index > 0)
 		ftrace_set_filter_ips(&fprobe_graph_ops.ops,
 				      alist.addrs, alist.index, 1, 0);
 	mutex_unlock(&fprobe_mutex);
diff --git a/kernel/trace/trace_dynevent.c b/kernel/trace/trace_dynevent.c
index 5d64a18cacac..d06854bd32b3 100644
--- a/kernel/trace/trace_dynevent.c
+++ b/kernel/trace/trace_dynevent.c
@@ -230,6 +230,10 @@ static int dyn_event_open(struct inode *inode, struct file *file)
 {
 	int ret;
 
+	ret = security_locked_down(LOCKDOWN_TRACEFS);
+	if (ret)
+		return ret;
+
 	ret = tracing_check_open_get_tr(NULL);
 	if (ret)
 		return ret;

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

