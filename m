Return-Path: <linux-kernel+bounces-830992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D816B9B175
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 19:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 077607B7A23
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2103191CA;
	Wed, 24 Sep 2025 17:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Iz9bi393"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1073168F6
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 17:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758735651; cv=none; b=gXVsbZLhOsI5MK2vFEZSf21plbAK1+nioap+xDEEiIDY8vOwjETevwvB8Wo1bKH7bHosAYbQQ0GmsRbrAnafZ4M8h4IZLF47eF2l6/ACq5W2CAbe7fyBVVJsmUL9MbPk6WhDlm8A2kQjZhgW19mHDwDnfPv73ofcAi0c9vDKU/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758735651; c=relaxed/simple;
	bh=QV/TqYJW+wg31JdMqf4BdzmFIUmXjr6AVr1ejb5bYFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=epvEsBAdzLzMSbjmA/0tnzDZ9AlwM2IY+c3BATJwBtfL7V6LNT12VhoZD6wdGGWPTd6iBPZ4IZUtoEH8RbOxlqBNCxHDTkReYVblDsuaOiu3nAiirmRsto/cd19nxYdgTxZyv3wEPIh9xB37vkH22vhH/XpQaokgglJma0rqs34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Iz9bi393; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=LvNuFgAVsZu6pshvnPqZ/JYaqtoCuId1tC+yF0PREAA=; b=Iz9bi393GJHzqEoSUbMwy9X0s9
	dlx8nTvyw7L+cGGykkkZwZmjG4NgYk/0VNUsBtNFfpn25HCvykxUJgyhp84vHM5or0c6W36FaUJ/q
	J6nG/3uNmkXmow7RjKAN3KgrBrU44jcIPRsgVG/eDSy/fhSEzAn6Fh3hZc9CgmOPVxNBcwJLzavIK
	IUncTU3jGLCiAoDr+WiFoOkjyqUnh1VkUQPJ0IGEunwskwClQSGm/WgMoqvLjihFTPXHecI2EwrPi
	WGvCsBBNTncGQyJBt7qbbkW3P6OJXZ7nYpoN17ZwwIYXwgFjRct0URtAJPv+7kVJNtq7mVgAt5QE6
	ZcV/tnJQ==;
Received: from [179.159.118.139] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1v1TTs-00Gz9Z-D7; Wed, 24 Sep 2025 19:40:41 +0200
From: Mauricio Faria de Oliveira <mfo@igalia.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>
Cc: Oscar Salvador <osalvador@suse.de>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Zi Yan <ziy@nvidia.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com
Subject: [PATCH 2/3] mm/page_owner: add option 'print_stack' for 'show_stacks'
Date: Wed, 24 Sep 2025 14:40:22 -0300
Message-ID: <20250924174023.261125-3-mfo@igalia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250924174023.261125-1-mfo@igalia.com>
References: <20250924174023.261125-1-mfo@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For monitoring the memory usage per stack trace, it is more efficient to
read _just_ the handle number of the stack traces _without_ stack traces
themselves, and their number of base pages.

The stack traces are required only at the time to associate memory usage
of a handle number with its stack trace (eg, see top-consuming handles).
Before that, it is sufficient to have just the handle number, as it can
be matched with a stack trace later (possible with the previous patch).

This patch adds the option 'print_stack' option (enabled by default) to
print stack traces in 'show_stacks'.

Testing:

  - Enable handle numbers:
  # echo 1 >/sys/kernel/debug/page_owner_stacks/print_handle

  - With stacks (default):
  # cat /sys/kernel/debug/page_owner_stacks/show_stacks > f1

  - Without stacks (new option):
  # echo 0 >/sys/kernel/debug/page_owner_stacks/print_stack
  # cat /sys/kernel/debug/page_owner_stacks/show_stacks > f2

  - Differences:

  # cat f1
   get_page_from_freelist+0x14ab/0x16a0
   ...
   do_syscall_64+0xa4/0x290
  handle: 15728651
  nr_base_pages: 2

   get_page_from_freelist+0x14ab/0x16a0
   ...
   do_sys_openat2+0x8a/0xe0
  handle: 8388619
  nr_base_pages: 16

  ...

  # cat f2
  handle: 15728651
  nr_base_pages: 2

  handle: 8388619
  nr_base_pages: 16

  ...

Signed-off-by: Mauricio Faria de Oliveira <mfo@igalia.com>
---
 mm/page_owner.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/mm/page_owner.c b/mm/page_owner.c
index 420426749239..25221676676d 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -888,6 +888,7 @@ static void *stack_next(struct seq_file *m, void *v, loff_t *ppos)
 
 static unsigned long page_owner_pages_threshold;
 static bool page_owner_print_handle;
+static bool page_owner_print_stack = true;
 
 static int stack_print(struct seq_file *m, void *v)
 {
@@ -900,15 +901,17 @@ static int stack_print(struct seq_file *m, void *v)
 	if (!stack->stack_record)
 		return 0;
 
-	nr_entries = stack_record->size;
-	entries = stack_record->entries;
 	nr_base_pages = refcount_read(&stack_record->count) - 1;
 
 	if (nr_base_pages < 1 || nr_base_pages < page_owner_pages_threshold)
 		return 0;
 
-	for (i = 0; i < nr_entries; i++)
-		seq_printf(m, " %pS\n", (void *)entries[i]);
+	if (page_owner_print_stack) {
+		nr_entries = stack_record->size;
+		entries = stack_record->entries;
+		for (i = 0; i < nr_entries; i++)
+			seq_printf(m, " %pS\n", (void *)entries[i]);
+	}
 	if (page_owner_print_handle)
 		seq_printf(m, "handle: %d\n", stack_record->handle.handle);
 	seq_printf(m, "nr_base_pages: %d\n\n", nr_base_pages);
@@ -973,6 +976,8 @@ static int __init pageowner_init(void)
 			    &proc_page_owner_threshold);
 	debugfs_create_bool("print_handle", 0600, dir,
 			    &page_owner_print_handle);
+	debugfs_create_bool("print_stack", 0600, dir,
+			    &page_owner_print_stack);
 
 	return 0;
 }
-- 
2.48.1


