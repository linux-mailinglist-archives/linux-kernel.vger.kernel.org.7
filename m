Return-Path: <linux-kernel+bounces-839342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F015BBB16B4
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 19:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD7EA7B2AFA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 17:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2952D5930;
	Wed,  1 Oct 2025 17:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="jo4lfrDb"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77EC22D592C
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 17:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759341411; cv=none; b=kH1Xtxm/MGpp+UdEFWm9haw4foqnYXE5OzNIliEqqgdrCK2ayFi2XUkofD/KoQr6a9fjlo6uPmRP/PHUzre7pBbxHkcEKNhC7lxhKmLqaKN/cq42qpaGFOg0fPbbyL30RkVY8VJ+sigyQ+9BaBK9t2sadfVgEhNke85RENzM004=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759341411; c=relaxed/simple;
	bh=T2XPE/MC4hQ1H6ThFy0YB5n4tbezjalvg27FOt+AOwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qwwh8cOF/fnv21oQr2/kkdXYEUcCZ4oYkCJfER1VooRla0dQJR7xUq8JG8MEpR3M0EuAaeufeWn+MwbxOyH5YUhIa/LW792GPDhxgWnpFAWlBliy4MAghjhyboq9hv+fAc5lBwwL9EEbj2dHHM5nWHkUDE49T4wvJV7qcNeVzBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=jo4lfrDb; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=pFGrw9AJtqB09g7OZrEbnRk6JGZDUVaKcZE3piDe3Pg=; b=jo4lfrDb7Ln2/ekILrcZTwpfHy
	ovbXmao2JZNNpAUTrE4TW71cJIenl9mkQPyMufLmibgYOnkD4vbFyB9vgDiawMZpvJa2PzWjrmCV2
	y2luluqHqYGX+pBCFLuB1omuC7KUjIdsD/L5LY8+WFYrZaah5JqcODcnIUoals4FvmMXVzb7YKY8R
	GB6QZAPxELiecJKph7kxb5KiONOEhiqRjcn+WQ7hNmCe7sV5vKtyfzKISls4Zz5pdKtsMdPG7Mk9K
	0XCVIVJpZOdPL4PAVwW59CLEiCpWltbNqy8CA4Rl2jxgxYnxN+tI9xXXYeF7YgpM3j1s1y6kre/np
	vBbhq2Aw==;
Received: from [179.159.118.139] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1v414E-002xd4-DL; Wed, 01 Oct 2025 19:56:43 +0200
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
Subject: [PATCH v2 5/5] mm/page_owner: update Documentation with 'show_handles' and 'show_stacks_handles'
Date: Wed,  1 Oct 2025 14:56:11 -0300
Message-ID: <20251001175611.575861-6-mfo@igalia.com>
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

Describe and provide examples for 'show_handles' and 'show_stacks_handles'.

Signed-off-by: Mauricio Faria de Oliveira <mfo@igalia.com>
---
 Documentation/mm/page_owner.rst | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/Documentation/mm/page_owner.rst b/Documentation/mm/page_owner.rst
index 3a45a20fc05a..6b12f3b007ec 100644
--- a/Documentation/mm/page_owner.rst
+++ b/Documentation/mm/page_owner.rst
@@ -27,7 +27,10 @@ enabled. Other usages are more than welcome.
 It can also be used to show all the stacks and their current number of
 allocated base pages, which gives us a quick overview of where the memory
 is going without the need to screen through all the pages and match the
-allocation and free operation.
+allocation and free operation. It's also possible to show only a numeric
+identifier of all the stacks (without stack traces) and their number of
+allocated base pages (faster to read and parse, eg, for monitoring) that
+can be matched with stacks later (show_handles and show_stacks_handles).
 
 page owner is disabled by default. So, if you'd like to use it, you need
 to add "page_owner=on" to your boot cmdline. If the kernel is built
@@ -116,6 +119,33 @@ Usage
 	nr_base_pages: 20824
 	...
 
+	cat /sys/kernel/debug/page_owner_stacks/show_handles > handles_7000.txt
+	cat handles_7000.txt
+	handle: 42
+	nr_base_pages: 20824
+	...
+
+	cat /sys/kernel/debug/page_owner_stacks/show_stacks_handles > stacks_handles.txt
+	cat stacks_handles.txt
+	 post_alloc_hook+0x177/0x1a0
+	 get_page_from_freelist+0xd01/0xd80
+	 __alloc_pages+0x39e/0x7e0
+	 alloc_pages_mpol+0x22e/0x490
+	 folio_alloc+0xd5/0x110
+	 filemap_alloc_folio+0x78/0x230
+	 page_cache_ra_order+0x287/0x6f0
+	 filemap_get_pages+0x517/0x1160
+	 filemap_read+0x304/0x9f0
+	 xfs_file_buffered_read+0xe6/0x1d0 [xfs]
+	 xfs_file_read_iter+0x1f0/0x380 [xfs]
+	 __kernel_read+0x3b9/0x730
+	 kernel_read_file+0x309/0x4d0
+	 __do_sys_finit_module+0x381/0x730
+	 do_syscall_64+0x8d/0x150
+	 entry_SYSCALL_64_after_hwframe+0x62/0x6a
+	handle: 42
+	...
+
 	cat /sys/kernel/debug/page_owner > page_owner_full.txt
 	./page_owner_sort page_owner_full.txt sorted_page_owner.txt
 
-- 
2.48.1


