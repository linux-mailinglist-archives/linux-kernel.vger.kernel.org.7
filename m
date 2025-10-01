Return-Path: <linux-kernel+bounces-839341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1E0BB16B1
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 19:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75D7A19C03C1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 17:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3ED2D47FA;
	Wed,  1 Oct 2025 17:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Qf+EB3vI"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FF92D5930
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 17:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759341408; cv=none; b=tZxcbpWhEL6UJ86Ri3itZgtu+Y4S1RJ71eKNwFRh0acwKlZlXKU5IcRvbn0w5k56UH+sgl1SBJ/kBwnRhIw4fLb3HQbJ8aocGAJC6puvLN2H2ZKZrVdqSvW0dlEzJOiwFqypP3BXUr/HluivquAI4nKfAniRY76itgRpXBmT5SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759341408; c=relaxed/simple;
	bh=O2QhPRG5ehYwpVdSphmEdNTxp8pMZwchEjuB62NnGiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d3w3KSPQXMuv2oHlGh6cUD4HRrkaFaCWzGaIhLUCQDIQnAN4MgY2JAdIQr8GzJpmxTFnsM3r8KAyrgLT3q6bAI28VjVlju21+z83RwPPoyQAiFvlrM5Vyuzn4KY0lK09AUpWQezaFf6mikJ0/yE3A7A5fI0IjV8qRId6RaQZ7sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Qf+EB3vI; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=d2BHJMm4sslHyidALeIjAD23MeiVl6ZlrbLv4A2t1ZM=; b=Qf+EB3vIvufdgNxjmGXzOvYobp
	89qmQvFn2SwESes+rePGkq4Zc6twetH21Kap3KonAlEcE0lfMmviZPuedwyZ+Jp6rGzOce5QxpJMP
	8Jq9ORB7euMY65AZZQuVrV3H0cYq8QjHG6+y44t+ceTbzuE2KUvTkI38NZJViOzkIxm7pUPwNB3aE
	6NsIBon2W35uyqWj3UFqKdgvXNNannhLwvbNGqzt8P8L6kKM18r+RiRBxt0ZGeA2EKJqFdO3MUtTo
	BN5eOTHoutn9Zz3GF+vV5qGXGcnhsh/Y48n/4YgoZaWrG9nqTEosA61IT3MolHld4xgt8xDWXZtuI
	H6D4dHig==;
Received: from [179.159.118.139] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1v4149-002xd4-NQ; Wed, 01 Oct 2025 19:56:38 +0200
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
Subject: [PATCH v2 4/5] mm/page_owner: add debugfs file 'show_stacks_handles'
Date: Wed,  1 Oct 2025 14:56:10 -0300
Message-ID: <20251001175611.575861-5-mfo@igalia.com>
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

Add the file 'show_stacks_handles' to show just stack traces and their
handles, in order to resolve stack traces and handles (i.e., to identify
the stack traces for handles in previous reads from 'show_handles').

All stacks/handles must show up, regardless of their number of pages, that
might have become zero or no longer make 'count_threshold', but made it in
previous reads from 'show_handles' -- and need to be resolved later.

P.S.: now, print the extra newline independently of the number of pages.

Signed-off-by: Mauricio Faria de Oliveira <mfo@igalia.com>
---
 mm/page_owner.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/mm/page_owner.c b/mm/page_owner.c
index 5d488fce0e3d..0e5c7bb3e4e8 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -913,7 +913,8 @@ static int stack_print(struct seq_file *m, void *v)
 
 	nr_base_pages = refcount_read(&stack_record->count) - 1;
 
-	if (nr_base_pages < 1 || nr_base_pages < page_owner_pages_threshold)
+	if (ctx->flags & STACK_PRINT_FLAG_PAGES &&
+	    (nr_base_pages < 1 || nr_base_pages < page_owner_pages_threshold))
 		return 0;
 
 	if (ctx->flags & STACK_PRINT_FLAG_STACK) {
@@ -925,7 +926,8 @@ static int stack_print(struct seq_file *m, void *v)
 	if (ctx->flags & STACK_PRINT_FLAG_HANDLE)
 		seq_printf(m, "handle: %d\n", stack_record->handle.handle);
 	if (ctx->flags & STACK_PRINT_FLAG_PAGES)
-		seq_printf(m, "nr_base_pages: %d\n\n", nr_base_pages);
+		seq_printf(m, "nr_base_pages: %d\n", nr_base_pages);
+	seq_putc(m, '\n');
 
 	return 0;
 }
@@ -999,6 +1001,10 @@ static int __init pageowner_init(void)
 			    (void *)(STACK_PRINT_FLAG_HANDLE |
 				     STACK_PRINT_FLAG_PAGES),
 			    &page_owner_stack_operations);
+	debugfs_create_file("show_stacks_handles", 0400, dir,
+			    (void *)(STACK_PRINT_FLAG_STACK |
+				     STACK_PRINT_FLAG_HANDLE),
+			    &page_owner_stack_operations);
 	debugfs_create_file("count_threshold", 0600, dir, NULL,
 			    &proc_page_owner_threshold);
 
-- 
2.48.1


