Return-Path: <linux-kernel+bounces-833243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4533BA183B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 23:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 704AA188EE43
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 21:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA56277026;
	Thu, 25 Sep 2025 21:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NOdcNEnx"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B456B2D0606
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 21:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758835095; cv=none; b=NQXTei4q1BpChHIPIjtxdjB25YMUYOKY6h4ELr/7TQaHJy+5I1bz80SzwijYOX2nlF6xkZD74lMbiZ+BdFw0GmDOK0ZBNkJmjpRKi9Co89fDyQk9di2dPXexfTNUazqdlN8yR/bApHQT5zf/QsvFAQpPjXyLi5+0GQx5XyjpJso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758835095; c=relaxed/simple;
	bh=zaTm5h9yIX7z+QocQqn6mOZfuOl1NNzLZf6FbQyEhFY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DWinJO+ZnIPv7jyhLJ/Rv3np8jO4kqPjJWDs7IoWS0SiaSWMHNpbB2mKznVkAZPIGVYPqLLNSDdUb5kQThf78LkajzZC7Z4CZ6iIX9bD0Tjg3fGCaF5IM7knHzdtzJHDEqUG+2zMRLIL0DRbGboIEnWTgtiXycoZDCj1dd8ANUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NOdcNEnx; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758835081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fdOtnZuNeNCE0UcW1H6VwdYySrWH1lRBDozCjfTv1oo=;
	b=NOdcNEnxybDPkmobUeJh0SjwWIpez3gHhAPuxX6pQSzvW7aQyNJg3TUMLb4o396RXRAgzu
	H5Qm0jqmILTsyAfPjtLhRkM7x8m3TDlNkmovJ0OC1WdGSMgqQyO5evWoNZzPo3WRUvZkpL
	1zhqF9VQrX25TGq04d92gwglQRwOvRE=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2] tracing/osnoise: Replace kmalloc + copy_from_user with memdup_user
Date: Thu, 25 Sep 2025 23:17:36 +0200
Message-ID: <20250925211736.81737-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace kmalloc() followed by copy_from_user() with memdup_user() to
simplify and improve osnoise_cpus_write().

No functional changes intended.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Changes in v2:
- Rebase to apply to master and linux-next
- Explicitly include linux/string.h
- Link to v1: https://lore.kernel.org/lkml/20250905192116.554018-2-thorsten.blum@linux.dev/
---
 kernel/trace/trace_osnoise.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 337bc0eb5d71..ab0575a94be1 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -24,6 +24,7 @@
 #include <linux/sched/clock.h>
 #include <uapi/linux/sched/types.h>
 #include <linux/sched.h>
+#include <linux/string.h>
 #include "trace.h"
 
 #ifdef CONFIG_X86_LOCAL_APIC
@@ -2325,12 +2326,9 @@ osnoise_cpus_write(struct file *filp, const char __user *ubuf, size_t count,
 	if (count < 1)
 		return 0;
 
-	buf = kmalloc(count, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-
-	if (copy_from_user(buf, ubuf, count))
-		return -EFAULT;
+	buf = memdup_user(ubuf, count);
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
 
 	if (!zalloc_cpumask_var(&osnoise_cpumask_new, GFP_KERNEL))
 		return -ENOMEM;
-- 
2.51.0


