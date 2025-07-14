Return-Path: <linux-kernel+bounces-730034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7041CB03F6C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E1491A62466
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 13:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6951F24E4C3;
	Mon, 14 Jul 2025 13:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O3FjRptO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA2B42065
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 13:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752499039; cv=none; b=qUvauvUhq7eQPZeCj7zIXRZsi+ic8gYnHX6Miqe48cb9IyXbW/8XS6LZKhqfWhaqsntBnmoRhj+USgvC7E/vTcXz7gNlnY4USi61478KJ1NTZAGwPUNiC6JBN2O2EOeHlkIkJd4wfg2EK5WcV13VYWaXKNb8KJGaXiL2ZpGtZx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752499039; c=relaxed/simple;
	bh=NQlEC12/PkcNog6rAzPE2sHwLIdyRd0D6p4x1t2tCAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WUcpNVl/lbPqI/8bxEinAqRU7VmXN6uzy3xAeJKEpzxg96m437lnuRan5Hv7C2V4aT3/4Kh6XXaGJ4etJeqg5kxp23a9eEgDXjHsXXkPGuhRhGmDb8xZZrHPtO/Elr7Xw+PoxgyqYX/CklJOSvYuF5V1XNlSGaAT1u5geVRbQaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O3FjRptO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752499037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FTJc9bWtRtDIBfHbDRnLppWXtJs9xo9JkdcLfIZxo/I=;
	b=O3FjRptOftNiUEhhBdrihSHo4nfmfDTZ6xnqsYvTz7j7bIEjYEOqZvNyrBpVqPn7jmOSkU
	q68PUgrJBvk2JNLTNbAlzMF15NN8PO9+oUbBFjiJTvhlW68Mv49fnJLbkPqdD2G95Bhrm/
	hpm+mMO+luTp2M5lL1Qok2QyCyWa6Yg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-418-Hz-OqUGIOJylB5NjZspXLQ-1; Mon,
 14 Jul 2025 09:17:15 -0400
X-MC-Unique: Hz-OqUGIOJylB5NjZspXLQ-1
X-Mimecast-MFC-AGG-ID: Hz-OqUGIOJylB5NjZspXLQ_1752499034
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DDF8C1800268;
	Mon, 14 Jul 2025 13:17:13 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.80.96])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 71FCF18002B5;
	Mon, 14 Jul 2025 13:17:12 +0000 (UTC)
From: Luiz Capitulino <luizcap@redhat.com>
To: david@redhat.com,
	willy@infradead.org,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	shivankg@amd.com,
	sj@kernel.org,
	harry.yoo@oracle.com
Subject: [PATCH v3 3/4] proc: kpagecount: use snapshot_page()
Date: Mon, 14 Jul 2025 09:16:53 -0400
Message-ID: <1c05cc725b90962d56323ff2e28e9cc3ae397b68.1752499009.git.luizcap@redhat.com>
In-Reply-To: <cover.1752499009.git.luizcap@redhat.com>
References: <cover.1752499009.git.luizcap@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Currently, the call to folio_precise_page_mapcount() from kpage_read()
can race with a folio split. When the race happens we trigger a
VM_BUG_ON_FOLIO() in folio_entire_mapcount() (see splat below).

This commit fixes this race by using snapshot_page() so that we
retrieve the folio mapcount using a folio snapshot.

[ 2356.558576] page: refcount:1 mapcount:1 mapping:0000000000000000 index:0xffff85200 pfn:0x6f7c00
[ 2356.558748] memcg:ffff000651775780
[ 2356.558763] anon flags: 0xafffff60020838(uptodate|dirty|lru|owner_2|swapbacked|node=1|zone=2|lastcpupid=0xfffff)
[ 2356.558796] raw: 00afffff60020838 fffffdffdb5d0048 fffffdffdadf7fc8 ffff00064c1629c1
[ 2356.558817] raw: 0000000ffff85200 0000000000000000 0000000100000000 ffff000651775780
[ 2356.558839] page dumped because: VM_BUG_ON_FOLIO(!folio_test_large(folio))
[ 2356.558882] ------------[ cut here ]------------
[ 2356.558897] kernel BUG at ./include/linux/mm.h:1103!
[ 2356.558982] Internal error: Oops - BUG: 00000000f2000800 [#1]  SMP
[ 2356.564729] CPU: 8 UID: 0 PID: 1864 Comm: folio-split-rac Tainted: G S      W           6.15.0+ #3 PREEMPT(voluntary)
[ 2356.566196] Tainted: [S]=CPU_OUT_OF_SPEC, [W]=WARN
[ 2356.566814] Hardware name: Red Hat KVM, BIOS edk2-20241117-3.el9 11/17/2024
[ 2356.567684] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[ 2356.568563] pc : kpage_read.constprop.0+0x26c/0x290
[ 2356.569605] lr : kpage_read.constprop.0+0x26c/0x290
[ 2356.569992] sp : ffff80008fb739b0
[ 2356.570263] x29: ffff80008fb739b0 x28: ffff00064aa69580 x27: 00000000ff000000
[ 2356.570842] x26: 0000fffffffffff8 x25: ffff00064aa69580 x24: ffff80008fb73ae0
[ 2356.571411] x23: 0000000000000001 x22: 0000ffff86c6e8b8 x21: 0000000000000008
[ 2356.571978] x20: 00000000006f7c00 x19: 0000ffff86c6e8b8 x18: 0000000000000000
[ 2356.572581] x17: 3630303066666666 x16: 0000000000000003 x15: 0000000000001000
[ 2356.573217] x14: 00000000ffffffff x13: 0000000000000004 x12: 00aaaaaa00aaaaaa
[ 2356.577674] x11: 0000000000000000 x10: 00aaaaaa00aaaaaa x9 : ffffbf3afca6c300
[ 2356.578332] x8 : 0000000000000002 x7 : 0000000000000001 x6 : 0000000000000001
[ 2356.578984] x5 : ffff000c79812408 x4 : 0000000000000000 x3 : 0000000000000000
[ 2356.579635] x2 : 0000000000000000 x1 : ffff00064aa69580 x0 : 000000000000003e
[ 2356.580286] Call trace:
[ 2356.580524]  kpage_read.constprop.0+0x26c/0x290 (P)
[ 2356.580982]  kpagecount_read+0x28/0x40
[ 2356.581336]  proc_reg_read+0x38/0x100
[ 2356.581681]  vfs_read+0xcc/0x320
[ 2356.581992]  ksys_read+0x74/0x118
[ 2356.582306]  __arm64_sys_read+0x24/0x38
[ 2356.582668]  invoke_syscall+0x70/0x100
[ 2356.583022]  el0_svc_common.constprop.0+0x48/0xf8
[ 2356.583456]  do_el0_svc+0x28/0x40
[ 2356.583930]  el0_svc+0x38/0x118
[ 2356.584328]  el0t_64_sync_handler+0x144/0x168
[ 2356.584883]  el0t_64_sync+0x19c/0x1a0
[ 2356.585350] Code: aa0103e0 9003a541 91082021 97f813fc (d4210000)
[ 2356.586130] ---[ end trace 0000000000000000 ]---
[ 2356.587377] note: folio-split-rac[1864] exited with irqs disabled
[ 2356.588050] note: folio-split-rac[1864] exited with preempt_count 1

Reported-by: syzbot+3d7dc5eaba6b932f8535@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/67812fbd.050a0220.d0267.0030.GAE@google.com/
Signed-off-by: Luiz Capitulino <luizcap@redhat.com>
---
 fs/proc/page.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/fs/proc/page.c b/fs/proc/page.c
index 999af26c7298..936f8bbe5a6f 100644
--- a/fs/proc/page.c
+++ b/fs/proc/page.c
@@ -43,6 +43,22 @@ static inline unsigned long get_max_dump_pfn(void)
 #endif
 }
 
+static u64 get_kpage_count(const struct page *page)
+{
+	struct page_snapshot ps;
+	u64 ret;
+
+	snapshot_page(&ps, page);
+
+	if (IS_ENABLED(CONFIG_PAGE_MAPCOUNT))
+		ret = folio_precise_page_mapcount(&ps.folio_snapshot,
+						  &ps.page_snapshot);
+	else
+		ret = folio_average_page_mapcount(&ps.folio_snapshot);
+
+	return ret;
+}
+
 static ssize_t kpage_read(struct file *file, char __user *buf,
 		size_t count, loff_t *ppos,
 		enum kpage_operation op)
@@ -75,10 +91,7 @@ static ssize_t kpage_read(struct file *file, char __user *buf,
 				info = stable_page_flags(page);
 				break;
 			case KPAGE_COUNT:
-				if (IS_ENABLED(CONFIG_PAGE_MAPCOUNT))
-					info = folio_precise_page_mapcount(page_folio(page), page);
-				else
-					info = folio_average_page_mapcount(page_folio(page));
+				info = get_kpage_count(page);
 				break;
 			case KPAGE_CGROUP:
 				info = page_cgroup_ino(page);
-- 
2.50.0


