Return-Path: <linux-kernel+bounces-839340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2988BB16AE
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 19:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 745EC1C776F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 17:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F452D4B5E;
	Wed,  1 Oct 2025 17:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="dD3pr7mI"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024592D47FA
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 17:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759341403; cv=none; b=G5DJSD3QJZ6moM027HWqj+4JF8oqs+l0WdPOE15+klFOGIDsyRrezofI0vUS6HBhf2oJfGEKBtymKH7yiRk1fGgaS9wPlg+I+c5LmVkb20E6BjzQY+G9bUXUhRQW4KkDFnK8vF8BJGCigNmo8Nw4ib6FRSAkJVntDKiJfb87H5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759341403; c=relaxed/simple;
	bh=/JbmZP+KG/WdPRvPML4GzKCOCSPnPbKC8+lVmQbRifs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jpth0HkbAi9EVUVHXpbQ0oV6CSos50LmO5snXYw3duHAHBlt2T/icGahhmq5CnxM9ISZSoB2Lcxvj8sUMzjniaks2epsVa9DMXSHGy2+07pfn7TGKfNlZfux+k882KQdod9kZE5cHqpHvYTpiad/Ur56GXayAzBSkzri8eXxVuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=dD3pr7mI; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=sGokdKfJ/nczLFQrrcykX4jGc1e0TlOvSMvafR6R/Tw=; b=dD3pr7mIhhMXSbQjUnGdZ4gU/a
	WIt+5Qj6yv0UttvV4urtza6p349IrHhOZ0v6rGXhavI/sRq8V3HJx8wUKNY6fJMwbuI141X/hvjMz
	GsbgA5WTysJ7NLtlWWOKgtJbNbJKOtubZkSi7b7fGGRFPsG8pLb5TYqQ3Ugkmu0Rwfpf4eJv9M65R
	FWEJV1Lk9Nelf7VCvLG3uIQyq34Uij81y9B86ziWh9sn7IxKL/zwZV/2H01SV0kJQ18aQ81P7d0zj
	xGr18N+9DMT+PGVhKD+8q7eMGAVtTXKYupAyS+1wnOi43dkyqxmnzputIA88kHicQAHQYS+OC0X0H
	Gqj58U6w==;
Received: from [179.159.118.139] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1v4144-002xd4-W0; Wed, 01 Oct 2025 19:56:33 +0200
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
Subject: [PATCH v2 3/5] mm/page_owner: add debugfs file 'show_handles'
Date: Wed,  1 Oct 2025 14:56:09 -0300
Message-ID: <20251001175611.575861-4-mfo@igalia.com>
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

Add the flag STACK_PRINT_FLAG_HANDLE to print a stack's handle number
from stackdepot, and add the file 'show_handles' to show just handles
and their number of pages.

This is similar to 'show_stacks', with handles instead of stack traces.

Signed-off-by: Mauricio Faria de Oliveira <mfo@igalia.com>
---
 mm/page_owner.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/page_owner.c b/mm/page_owner.c
index e983ac21a4db..5d488fce0e3d 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -47,6 +47,7 @@ static DEFINE_SPINLOCK(stack_list_lock);
 
 #define STACK_PRINT_FLAG_STACK		0x1
 #define STACK_PRINT_FLAG_PAGES		0x2
+#define STACK_PRINT_FLAG_HANDLE		0x4
 
 struct stack_print_ctx {
 	struct stack *stack;
@@ -921,6 +922,8 @@ static int stack_print(struct seq_file *m, void *v)
 		for (i = 0; i < nr_entries; i++)
 			seq_printf(m, " %pS\n", (void *)entries[i]);
 	}
+	if (ctx->flags & STACK_PRINT_FLAG_HANDLE)
+		seq_printf(m, "handle: %d\n", stack_record->handle.handle);
 	if (ctx->flags & STACK_PRINT_FLAG_PAGES)
 		seq_printf(m, "nr_base_pages: %d\n\n", nr_base_pages);
 
@@ -992,6 +995,10 @@ static int __init pageowner_init(void)
 			    (void *)(STACK_PRINT_FLAG_STACK |
 				     STACK_PRINT_FLAG_PAGES),
 			    &page_owner_stack_operations);
+	debugfs_create_file("show_handles", 0400, dir,
+			    (void *)(STACK_PRINT_FLAG_HANDLE |
+				     STACK_PRINT_FLAG_PAGES),
+			    &page_owner_stack_operations);
 	debugfs_create_file("count_threshold", 0600, dir, NULL,
 			    &proc_page_owner_threshold);
 
-- 
2.48.1


