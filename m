Return-Path: <linux-kernel+bounces-839339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E602BBB16AB
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 19:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 993364E05D4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 17:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B24286889;
	Wed,  1 Oct 2025 17:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="joDiFQJ/"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BDE2D46D1
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 17:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759341400; cv=none; b=soI0VCvzN/mMZyLoBjlt1GCiB6ppTHwFSyQUCpH5FBN3Zy5YO7ulKcHmu38khuhFxxQ4hLDuUOkdVEpBS9i0pdUmJTLT0PhJr+jofga/73PZpmPmAT7DHipItaASnFj3IuaskdrXvD9Y0OnusHXscRK3RsTNxMbdThmEJZ672l8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759341400; c=relaxed/simple;
	bh=9mbyqCPUNLXPsjbK/czsQqoVyLEqgKEu2DRsdIHtI4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MrvFi/Dn0XhQLS6wEe8O1AWAnndM+F/hJNBKF+oIIdwDe7CHgO5pqsRZluIxkB3tKQ/Ig0a2O2Yj91MKchYUepnrTBWhU1ghwDnEKKsjcsxMYQVh2TjwTc16OIEC9iwmBC4Z8GpYc2Fu1OsI0R6+fS5U2CDZ7qC4cQ6FcggAT4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=joDiFQJ/; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=8Yt1tx1hSW4BERbOPJZtMQAF71fcPnG6q+/M6LLWaWU=; b=joDiFQJ/fpMabMXZVaNDK8vUS1
	kyoFyUPQkwqGmJ8AnV01uDW0mP9zJhCegyxoIqbcvlFQjbL3eK9ToZsGdrl/bUKzHB0sJidvkWQvR
	k07yWhlMGjQdCYrX3wDJMspzuxxERLLkmZhrIpUqXNnvSIaBMheFkV6jqPlt7QFByjszvqkPbRO6b
	4JnVfwuXwf2Ue0Rx4faKUXDH6kg3hFRK1PCEe/RNLDJE3ZMH3bAzX0JnWDuChz2AMjnsnKFuNSsHJ
	P79SOeZBnJshgVzCV40ejsUqFauAyBo775lddWTbVTz8Z15JxWclrl4fkIOfEE5KPbnJUD9siWGl6
	rJH11IGg==;
Received: from [179.159.118.139] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1v4140-002xd4-CN; Wed, 01 Oct 2025 19:56:28 +0200
From: Mauricio Faria de Oliveira <mfo@igalia.com>
To: Michal Hocko <mhocko@suse.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Oscar Salvador <osalvador@suse.de>,
	Suren Baghdasaryan <surenb@google.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zi Yan <ziy@nvidia.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com
Subject: [PATCH v2 2/5] mm/page_owner: add struct stack_print_ctx.flags
Date: Wed,  1 Oct 2025 14:56:08 -0300
Message-ID: <20251001175611.575861-3-mfo@igalia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251001175611.575861-1-mfo@igalia.com>
References: <20251001175611.575861-1-mfo@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the flags field to stack_print_ctx, and define two flags for current
behavior (printing stack traces and their number of base pages).

The plumbing of flags is debugfs_create_file(data) -> inode.i_private ->
page_owner_stack_open() -> stack_print_ctx.flags -> stack_print().

No behavior change intended.

Signed-off-by: Mauricio Faria de Oliveira <mfo@igalia.com>
---
 mm/page_owner.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/mm/page_owner.c b/mm/page_owner.c
index c1a7d7afe945..e983ac21a4db 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -45,8 +45,12 @@ static struct stack failure_stack;
 static struct stack *stack_list;
 static DEFINE_SPINLOCK(stack_list_lock);
 
+#define STACK_PRINT_FLAG_STACK		0x1
+#define STACK_PRINT_FLAG_PAGES		0x2
+
 struct stack_print_ctx {
 	struct stack *stack;
+	u8 flags;
 };
 
 static bool page_owner_enabled __initdata;
@@ -901,20 +905,24 @@ static int stack_print(struct seq_file *m, void *v)
 	unsigned long *entries;
 	unsigned long nr_entries;
 	struct stack_record *stack_record = stack->stack_record;
+	struct stack_print_ctx *ctx = m->private;
 
 	if (!stack->stack_record)
 		return 0;
 
-	nr_entries = stack_record->size;
-	entries = stack_record->entries;
 	nr_base_pages = refcount_read(&stack_record->count) - 1;
 
 	if (nr_base_pages < 1 || nr_base_pages < page_owner_pages_threshold)
 		return 0;
 
-	for (i = 0; i < nr_entries; i++)
-		seq_printf(m, " %pS\n", (void *)entries[i]);
-	seq_printf(m, "nr_base_pages: %d\n\n", nr_base_pages);
+	if (ctx->flags & STACK_PRINT_FLAG_STACK) {
+		nr_entries = stack_record->size;
+		entries = stack_record->entries;
+		for (i = 0; i < nr_entries; i++)
+			seq_printf(m, " %pS\n", (void *)entries[i]);
+	}
+	if (ctx->flags & STACK_PRINT_FLAG_PAGES)
+		seq_printf(m, "nr_base_pages: %d\n\n", nr_base_pages);
 
 	return 0;
 }
@@ -935,6 +943,13 @@ static int page_owner_stack_open(struct inode *inode, struct file *file)
 	int ret = seq_open_private(file, &page_owner_stack_op,
 				   sizeof(struct stack_print_ctx));
 
+	if (!ret) {
+		struct seq_file *m = file->private_data;
+		struct stack_print_ctx *ctx = m->private;
+
+		ctx->flags = (uintptr_t) inode->i_private;
+	}
+
 	return ret;
 }
 
@@ -973,7 +988,9 @@ static int __init pageowner_init(void)
 	debugfs_create_file("page_owner", 0400, NULL, NULL,
 			    &proc_page_owner_operations);
 	dir = debugfs_create_dir("page_owner_stacks", NULL);
-	debugfs_create_file("show_stacks", 0400, dir, NULL,
+	debugfs_create_file("show_stacks", 0400, dir,
+			    (void *)(STACK_PRINT_FLAG_STACK |
+				     STACK_PRINT_FLAG_PAGES),
 			    &page_owner_stack_operations);
 	debugfs_create_file("count_threshold", 0600, dir, NULL,
 			    &proc_page_owner_threshold);
-- 
2.48.1


