Return-Path: <linux-kernel+bounces-883219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D689C2CB76
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 16:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 12C143482AC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 15:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4A0A314A63;
	Mon,  3 Nov 2025 15:16:46 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73507314D22
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 15:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762183006; cv=none; b=efaqCc6BT7+K/QE8vkDVQgECDHhD+ggcLtc4x06AFeYsVaeVRSv9PKG4AiYu9/I7ZgOKPVr85je85KEX3/Usf3dhEqEMtroBE0UT2NgietXxT0bFnj92KzDHmIWQ7M7je1XQOLNSTtClmgkJizsffrwL9WJSeLeSLDAd96RB4ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762183006; c=relaxed/simple;
	bh=pADs+ANzABl5ZP+R7AR8DpUTqrj2vdTwNCo4b4IKsgE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hg+jMW1p87F+wdaTrAQcrP1lvvHeV5wNKpSqsaQHfwOw1TR3yBLf71cLoo8QoN3E3XkWYNityTO9x3rpKzfD8o1r3XsjLFiwwMTqqudyrs8vVcmPMBLcFRKRf/ShyEExAvORi7DaeDVZ/w5AbMICPAFd/8UwxF8fp2l91lxe5fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 14e5d814b8c811f0a38c85956e01ac42-20251103
X-CID-CACHE: Type:Local,Time:202511032251+08,HitQuantity:2
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:5cd7ec91-f5f2-4c96-b1aa-b797f97772ad,IP:0,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:25
X-CID-META: VersionHash:a9d874c,CLOUDID:7d6a208332026c949c4bd8ab3bc26033,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|15|50,EDM:5,IP:nil,
	URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LE
	S:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 14e5d814b8c811f0a38c85956e01ac42-20251103
X-User: xialonglong@kylinos.cn
Received: from kylin-pc.. [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xialonglong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 603311868; Mon, 03 Nov 2025 23:16:33 +0800
From: Longlong Xia <xialonglong@kylinos.cn>
To: david@redhat.com,
	linmiaohe@huawei.com
Cc: lance.yang@linux.dev,
	markus.elfring@web.de,
	nao.horiguchi@gmail.com,
	akpm@linux-foundation.org,
	wangkefeng.wang@huawei.com,
	qiuxu.zhuo@intel.com,
	xu.xin16@zte.com.cn,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Longlong Xia <xialonglong@kylinos.cn>
Subject: [PATCH v3 0/2] mm/ksm: try recover from memory failure on KSM page by migrating to healthy duplicate
Date: Mon,  3 Nov 2025 23:15:59 +0800
Message-ID: <20251103151601.3280700-1-xialonglong@kylinos.cn>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <a675d644-38d0-43d7-be42-8bc3753c74ee@redhat.com>
References: <a675d644-38d0-43d7-be42-8bc3753c74ee@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a hardware memory error occurs on a KSM page, the current
behavior is to kill all processes mapping that page. This can
be overly aggressive when KSM has multiple duplicate pages in
a chain where other duplicates are still healthy.

This patch introduces a recovery mechanism that attempts to
migrate mappings from the failing KSM page to a newly
allocated KSM page or another healthy duplicate already
present in the same chain, before falling back to the
process-killing procedure.

The recovery process works as follows:
1. Identify if the failing KSM page belongs to a stable node chain.
2. Locate a healthy duplicate KSM page within the same chain.
3. For each process mapping the failing page:
   a. Attempt to allocate a new KSM page copy from healthy duplicate
      KSM page. If successful, migrate the mapping to this new KSM page.
   b. If allocation fails, migrate the mapping to the existing healthy
      duplicate KSM page.
4. If all migrations succeed, remove the failing KSM page from the chain.
5. Only if recovery fails (e.g., no healthy duplicate found or migration
   error) does the kernel fall back to killing the affected processes.

The original idea came from Naoya Horiguchi.
https://lore.kernel.org/all/20230331054243.GB1435482@hori.linux.bs1.fc.nec.co.jp/


Real-world Application Testing:
-------------------------------
Workload: 10 QEMU VMs (1 vCPU, 256MB RAM each) with KSM enabled
Platform: x86_64, Kernel 6.6.89

Testcase1: Single VM and enable KSM

- VM Memory Usage:
    * RSS Total  = 275028 KB (268 MB)
    * RSS Anon   = 253656 KB (247 MB)
    * RSS File   = 21372 KB (20 MB)
    * RSS Shmem  = 0 KB (0 MB)

a.Traverse the stable tree
b. pages on the chain
2 chains detected
Chain #1: 51 duplicates, 12,956 pages (~51 MB)
Chain #2: 15 duplicates, 3,822 pages (~15 MB)
Average: 8,389 pages per chain
Sum: 16778 pages (64.6% of ksm_pages_sharing + ksm_pages_shared)
c. pages on the chain
Non-chain pages: 9,209 pages
d.chain_count = 2, not_chain_count = 4200
e.
/sys/kernel/mm/ksm/ksm_pages_sharing = 21721
/sys/kernel/mm/ksm/ksm_pages_shared = 4266
/sys/kernel/mm/ksm/ksm_pages_unshared = 38098


Testcase2: 10 VMs and enable KSM
a.Traverse the stable tree
b.Pages on the chain
8 chains detected
Chain #1: 458 duplicates, 117,012 pages (~457 MB)
Chain #2: 150 duplicates, 38,231 pages (~149 MB)
Chain #3: 10 duplicates, 2,320 pages (~9 MB)
Chain #4: 8 duplicates, 1,814 pages (~7 MB)
Chain #5-8: 4, 3, 3, 2 duplicates (920, 720, 600, 260 pages) 

Surprisingly, although chains are few in number, they contribute
significantly to the overall savings. In the 10-VM scenario, only 8 chains
produce 161,877 pages (44.5% of total), while thousands of non-chain groups
contribute the remaining 55.5%. 

Functional Testing (Hardware Error Injection):
----------------------------------------------
test shell script
modprobe einj 2>/dev/null
echo 0x10 > /sys/kernel/debug/apei/einj/error_type
echo $ADDRESS > /sys/kernel/debug/apei/einj/param1
echo 0xfffffffffffff000 > /sys/kernel/debug/apei/einj/param2
echo 1 > /sys/kernel/debug/apei/einj/error_inject

FIRST WAY: allocate a new KSM page copy from healthy duplicate
1. alloc 1024 page with same content and enable KSM to merge
after merge (same phy_addr only print once)
virtual addr = 0x71582be00000  phy_addr =0x124802000
virtual addr = 0x71582bf2c000  phy_addr =0x124902000
virtual addr = 0x71582c026000  phy_addr =0x125402000
virtual addr = 0x71582c120000  phy_addr =0x125502000


2. echo 0x124802000 > /sys/kernel/debug/apei/einj/param1
virtual addr = 0x71582be00000  phy_addr =0x1363b1000 (new allocated)
virtual addr = 0x71582bf2c000  phy_addr =0x124902000
virtual addr = 0x71582c026000  phy_addr =0x125402000
virtual addr = 0x71582c120000  phy_addr =0x125502000

kernel-log:
mce: [Hardware Error]: Machine check events logged
ksm: recovery successful, no need to kill processes
Memory failure: 0x124802: recovery action for dirty LRU page: Recovered
Memory failure: 0x124802: recovery action for already poisoned page: Failed

SECOND WAY: Migrate the mapping to the existing healthy duplicate KSM page
1. alloc 1024 page with same content and enable KSM to merge
after merge (same phy_addr only print once)
virtual addr = 0x79a172000000  phy_addr =0x141802000
virtual addr = 0x79a17212c000  phy_addr =0x141902000
virtual addr = 0x79a172226000  phy_addr =0x13cc02000
virtual addr = 0x79a172320000  phy_addr =0x13cd02000

2 echo 0x141802000 > /sys/kernel/debug/apei/einj/param1
a.virtual addr = 0x79a172000000  phy_addr =0x13cd02000
b.virtual addr = 0x79a17212c000  phy_addr =0x141902000
c.virtual addr = 0x79a172226000  phy_addr =0x13cc02000
d.virtual addr = 0x79a172320000  phy_addr =0x13cd02000 (share with a) 

kernel-log:
mce: [Hardware Error]: Machine check events logged
ksm: recovery successful, no need to kill processes
Memory failure: 0x141802: recovery action for dirty LRU page: Recovered
Memory failure: 0x141802: recovery action for already poisoned page: Failed
ksm: recovery successful, no need to kill processes

Thanks for review and comments!

Changes in v3:

Patch 1/2 [New]: Preparatory refactoring
- Extract alloc_init_stable_node_dup() helper
- Refactor write_protect_page() and replace_page() to expose _addr variants
- No functional changes

Patch 2/2:
- Refactored to use alloc_init_stable_node_dup() helper from patch 1/2
  and stable_node_chain_add_dup()
- Fix locking: unlock failing_folio before mmap_read_lock to avoid deadlock
- Extracted find_stable_node_in_tree() as separate helper
- Removed redundant replace_failing_page(), using write_protect_page_addr()
  and replace_page_addr() instead
- Changed return type to 'struct folio *' for consistency
- Fixed code style issues

Changes in v2:

- Implemented a two-tier recovery strategy: preferring newly allocated
  pages over existing duplicates to avoid concentrating mappings on a 
  single page suggested by David Hildenbrand
- Remove handling of the zeropage in replace_failing_page(), as it is 
  non-recoverable suggested by Lance Yang 
- Correct the locking order by acquiring the mmap_lock before the page 
  lock during page replacement, suggested by Miaohe Lin
- Add protection using the ksm_thread_mutex around the entire recovery 
  operation to prevent race conditions with concurrent KSM scanning
- Separated the logic into smaller, more focused functions for better
  maintainability
- Update patch title

Longlong Xia (2):
  mm/ksm: add helper to allocate and initialize stable node duplicates
  mm/ksm: try recover from memory failure on KSM page by migrating to
    healthy duplicate

 mm/ksm.c | 304 ++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 278 insertions(+), 26 deletions(-)

-- 
2.43.0


