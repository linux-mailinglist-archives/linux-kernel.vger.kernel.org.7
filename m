Return-Path: <linux-kernel+bounces-839338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2C3BB16A8
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 19:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DE213A1BD9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 17:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3BEF2D3EEE;
	Wed,  1 Oct 2025 17:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="JQDFI9If"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CC02D0C9F
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 17:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759341395; cv=none; b=ZdOd8svksH5GEh1LtP9va1JnzvLX4wYdheyAs4ndbZl9Bq85GA7fPgkkFUil9E7LbKJ4eKVqaUvgKK8oGLkZcfsGMWWmKNklUYlZHFDYoe6JV6nUEHLP+5hcOBhLAnyBU9Wlgod4cJuR0Y1oVBZ1RfkdNIcHuj72GKU8Z7wirCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759341395; c=relaxed/simple;
	bh=DGHrA71q9LC2gqZCNU5YsojWnUP7S7smVpWqz558TCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Loryi602SJ3ffqFt2n1f6pmQSpyKlKwuzc0N+LjdmwCqkqnJW/kfklWbWtykjlirQktYH17wP4O8zSwUfR6gLCmYHGU7vXFrzxJtktw/X07OxupxSFomaJVAi2zCU1i8y44iGRfnmgNn6VcXrJxIkoXt2Hb2wihwWt53jjLK50Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=JQDFI9If; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=aJLopUjdg6abKCdBvFBz2DgGEx0e5f4MfKDCPhNtEqM=; b=JQDFI9IfVzCldlJpfK4bDQaE2h
	QPZss9dMFj0eA7iTfB27+w6qVnSPeygo5lxNEtyUrgPhoiaOlidBrxoosMvgoF3FO/bI2rtzmdfip
	3udzdqkBWoOX/Y+ZMYGBGH2DwwYHgA5zlhvSEtFEzfGf/cMc/tJfbtv6bWWGvimPOFA7Kz5NV5AdK
	CxDZx7EX7SLzc8HPsfwez15Np4eY4ZG9wPb7wVKCP1RVEyWxtzXu9Wzk+LQ25EvOl0vf/0pJ3N6tZ
	VP2qp4U09BusUl12XBDA1JMhjkfyIK3S8x9Gw0HLPq5bJPNkNuW6Kmjz+Kvs8Fu1PsZKx0+ejvSk8
	3HZjscww==;
Received: from [179.159.118.139] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1v413v-002xd4-Lk; Wed, 01 Oct 2025 19:56:24 +0200
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
Subject: [PATCH v2 1/5] mm/page_owner: introduce struct stack_print_ctx
Date: Wed,  1 Oct 2025 14:56:07 -0300
Message-ID: <20251001175611.575861-2-mfo@igalia.com>
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

Currently, struct seq_file.private is used as an iterator in stack_list
by stack_start|next(), for stack_print().

Create a context struct for this, in order to add another field next.

No behavior change intended.

P.S.: page_owner_stack_open() is expanded with separate statements for
variable definition and return just in preparation for the next patch.

Signed-off-by: Mauricio Faria de Oliveira <mfo@igalia.com>
---
 mm/page_owner.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/mm/page_owner.c b/mm/page_owner.c
index c3ca21132c2c..c1a7d7afe945 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -45,6 +45,10 @@ static struct stack failure_stack;
 static struct stack *stack_list;
 static DEFINE_SPINLOCK(stack_list_lock);
 
+struct stack_print_ctx {
+	struct stack *stack;
+};
+
 static bool page_owner_enabled __initdata;
 DEFINE_STATIC_KEY_FALSE(page_owner_inited);
 
@@ -856,6 +860,7 @@ static const struct file_operations proc_page_owner_operations = {
 static void *stack_start(struct seq_file *m, loff_t *ppos)
 {
 	struct stack *stack;
+	struct stack_print_ctx *ctx = m->private;
 
 	if (*ppos == -1UL)
 		return NULL;
@@ -867,9 +872,9 @@ static void *stack_start(struct seq_file *m, loff_t *ppos)
 		 * value of stack_list.
 		 */
 		stack = smp_load_acquire(&stack_list);
-		m->private = stack;
+		ctx->stack = stack;
 	} else {
-		stack = m->private;
+		stack = ctx->stack;
 	}
 
 	return stack;
@@ -878,10 +883,11 @@ static void *stack_start(struct seq_file *m, loff_t *ppos)
 static void *stack_next(struct seq_file *m, void *v, loff_t *ppos)
 {
 	struct stack *stack = v;
+	struct stack_print_ctx *ctx = m->private;
 
 	stack = stack->next;
 	*ppos = stack ? *ppos + 1 : -1UL;
-	m->private = stack;
+	ctx->stack = stack;
 
 	return stack;
 }
@@ -926,7 +932,10 @@ static const struct seq_operations page_owner_stack_op = {
 
 static int page_owner_stack_open(struct inode *inode, struct file *file)
 {
-	return seq_open_private(file, &page_owner_stack_op, 0);
+	int ret = seq_open_private(file, &page_owner_stack_op,
+				   sizeof(struct stack_print_ctx));
+
+	return ret;
 }
 
 static const struct file_operations page_owner_stack_operations = {
-- 
2.48.1


