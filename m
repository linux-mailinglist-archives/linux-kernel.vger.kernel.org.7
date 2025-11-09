Return-Path: <linux-kernel+bounces-891837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CF1C43A02
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 08:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 82AE84E3BFC
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 07:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E6823BCF0;
	Sun,  9 Nov 2025 07:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="rSFUbmmn"
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FE41BCA1C
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 07:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762675152; cv=none; b=Jkshvys2kO5P9EC/2x5r8SgD+P3WTZZ77nM4y+U9LZ5/gpKDu9AdsF/79sO7IW1koB6ZonaFqSbwSZreEd+9mH9GembuBnjvxRB+Q9ZirA6t+DZrItk6D4uGBt/VYt5PYyLmKC3QumhjuFhi9iYadPNUHDOsXk3eHTHYV36nYZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762675152; c=relaxed/simple;
	bh=ZNapXBY9qt+ndP5FzKewAowxIdsJhPRerbol68lvQSs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KZZYEotaRVeiuTTPMX3AoP6B0jdxF1FhPjedsI7RJzKyy1OYJRnC4fmQFpJxtGY0GBRnCYfy6YewGJirG8KpldtzSq3McnSYveCxk4T8QUmhCf8Px5AIARi9ldoWJ7/HlRnxIpS65iL41rw0PAyqPvto/er5kaUU9RoB6E5D+gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=rSFUbmmn; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A97tQVj3258752;
	Sat, 8 Nov 2025 23:58:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=Iq2Z7I+Jl
	B6c6uQ0YmR9PkKlSRV5E8tj8llQhJfbAio=; b=rSFUbmmn+9E3OwsQH7eHgc09W
	L9SNmosvXHahKuU4+X5p1C6yAYRo6ibBj0F2CPbXIF5o5iO/81EpCoF2oJyrheNh
	UbHc+gO7KfTmOQCQyymzuR3xYJQfrIUMXKhCn6g5zuV81THWh1lKR8cGVuXTdGn8
	QHW0K55VV0taUnV0QscMbz3Y26FN4XxiGxvofKPLpvTg+xZmz/WLeHou1pQD3T4x
	LtCX6L7ZEaGn2+gpa9msfL4cNmjl7mgF7UoaCSXNCWTsJC7+Q4kK/rqPSDmYrFfT
	jaUlOt1hKRWpmb3MJCzuX+Ht7gTmBDihJGFpn96J0HqX5Mo456Ef3nTMaxFjw==
Received: from ala-exchng02.corp.ad.wrs.com ([128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4aa2130ngj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Sat, 08 Nov 2025 23:58:22 -0800 (PST)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Sat, 8 Nov 2025 23:58:21 -0800
Received: from pek-lpd-ccm3.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Sat, 8 Nov 2025 23:58:19 -0800
From: Yun Zhou <yun.zhou@windriver.com>
To: <shaggy@kernel.org>, <akpm@linux-foundation.org>, <david@redhat.com>,
        <byungchul@sk.com>, <gregkh@linuxfoundation.org>,
        <yun.zhou@windriver.com>, <shivankg@amd.com>,
        <ssrane_b23@ee.vjti.ac.in>
CC: <jfs-discussion@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] jfs: fix corrupted list in dbUpdatePMap
Date: Sun, 9 Nov 2025 15:58:18 +0800
Message-ID: <20251109075818.229971-1-yun.zhou@windriver.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA5MDA2OCBTYWx0ZWRfX3C4cyAfBczWV
 kN6ZVuySyd0k56NdOp+xB8KThSjW+/wzb9coSW1LgDt3dvieLrvJ0kpvfJoOG4S78YwiZGd4724
 4wTiICG1wLBxhdoa9LFBGflT9jzHUBJHnjxoz/37fYxM5gGEYuUycT7VeY9UdoWu5O7cbtRSgLM
 Hdv76usQdMhpyG+nGD1b4WbHRCQVoqUnQow0M7wuWG/PuaZvocMZ1b2wRqThI7Y0OiD1oGsZ4cq
 +x6DL3fSUYe4dowhQwSGtrkZE6yRXl9yp9/v31ODtjlDJAOgMR6utA6kZ9UOEDzSxGAho2My0ln
 M8q1RPheEBSlUlWjLWP/T3xym0J9xb9d6cKpn62tBm+ZJbeH0dDnxGlIBdR+buKKCuI5UmON6Be
 vZGHIuRTadP1SoPu64cEiINfG4g5Sw==
X-Proofpoint-ORIG-GUID: mBkFQC0Y8PBPGK3CgghUQhRwWMJyXOTh
X-Authority-Analysis: v=2.4 cv=XPA9iAhE c=1 sm=1 tr=0 ts=6910499e cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8
 a=t7CeM3EgAAAA:8 a=HWOROlQ_xHIrUlYk3fIA:9 a=DcSpbTIhAlouE1Uv7lRv:22
 a=cQPPKAXgyycSBL8etih5:22 a=FdTzh2GWekK77mhwV6Dw:22 a=poXaRoVlC6wW9_mwW8W4:22
 a=cPQSjfK2_nFv0Q5t_7PE:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=SsAZrZ5W_gNWK9tOzrEV:22
X-Proofpoint-GUID: mBkFQC0Y8PBPGK3CgghUQhRwWMJyXOTh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-09_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 malwarescore=0 adultscore=0 bulkscore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511090068

This patch resolves the "list_add corruption. next is NULL" Oops
reported by syzkaller in dbUpdatePMap(). The root cause is uninitialized
synclist nodes in struct metapage and struct TxBlock, plus improper list
node removal using list_del() (which leaves nodes in an invalid state).

This fixes the following Oops reported by syzkaller.

list_add corruption. next is NULL.
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:28!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 1 UID: 0 PID: 122 Comm: jfsCommit Not tainted syzkaller #0
PREEMPT_{RT,(full)}
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
Google 10/02/2025
RIP: 0010:__list_add_valid_or_report+0xc3/0x130 lib/list_debug.c:27
Code: 4c 89 f2 48 89 d9 e8 0c 88 a4 fc 90 0f 0b 48 c7 c7 20 de 3d 8b e8
fd 87 a4 fc 90 0f 0b 48 c7 c7 c0 de 3d 8b e8 ee 87 a4 fc 90 <0f> 0b 48
89 df e8 13 c3 7d fd 42 80 7c 2d 00 00 74 08 4c 89 e7 e8
RSP: 0018:ffffc9000395fa20 EFLAGS: 00010246
RAX: 0000000000000022 RBX: 0000000000000000 RCX: 270c5dfadb559700
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00000000000f0000 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: fffff5200072bee9 R12: 0000000000000000
R13: dffffc0000000000 R14: 0000000000000004 R15: 1ffff92000632266
FS:  0000000000000000(0000) GS:ffff888126ef9000(0000)
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000056341fdb86c0 CR3: 0000000040a18000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __list_add_valid include/linux/list.h:96 [inline]
 __list_add include/linux/list.h:158 [inline]
 list_add include/linux/list.h:177 [inline]
 dbUpdatePMap+0x7e4/0xeb0 fs/jfs/jfs_dmap.c:577
 txAllocPMap+0x57d/0x6b0 fs/jfs/jfs_txnmgr.c:2426
 txUpdateMap+0x81e/0x9c0 fs/jfs/jfs_txnmgr.c:2364
 txLazyCommit fs/jfs/jfs_txnmgr.c:2665 [inline]
 jfs_lazycommit+0x3f1/0xa10 fs/jfs/jfs_txnmgr.c:2734
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---

Reported-by: syzbot+4d0a0feb49c5138cac46@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=4d0a0feb49c5138cac46
Tested-by: syzbot+4d0a0feb49c5138cac46@syzkaller.appspotmail.com
Signed-off-by: Yun Zhou <yun.zhou@windriver.com>
---
 fs/jfs/jfs_metapage.c | 3 ++-
 fs/jfs/jfs_txnmgr.c   | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/jfs/jfs_metapage.c b/fs/jfs/jfs_metapage.c
index 871cf4fb3636..0d6c40e7e551 100644
--- a/fs/jfs/jfs_metapage.c
+++ b/fs/jfs/jfs_metapage.c
@@ -270,6 +270,7 @@ static inline struct metapage *alloc_metapage(gfp_t gfp_mask)
 		mp->clsn = 0;
 		mp->log = NULL;
 		init_waitqueue_head(&mp->wait);
+		INIT_LIST_HEAD(&mp->synclist);
 	}
 	return mp;
 }
@@ -379,7 +380,7 @@ static void remove_from_logsync(struct metapage *mp)
 		mp->lsn = 0;
 		mp->clsn = 0;
 		log->count--;
-		list_del(&mp->synclist);
+		list_del_init(&mp->synclist);
 	}
 	LOGSYNC_UNLOCK(log, flags);
 }
diff --git a/fs/jfs/jfs_txnmgr.c b/fs/jfs/jfs_txnmgr.c
index 7840a03e5bcb..a5a5bc0a266d 100644
--- a/fs/jfs/jfs_txnmgr.c
+++ b/fs/jfs/jfs_txnmgr.c
@@ -275,6 +275,7 @@ int txInit(void)
 	for (k = 0; k < nTxBlock; k++) {
 		init_waitqueue_head(&TxBlock[k].gcwait);
 		init_waitqueue_head(&TxBlock[k].waitor);
+		INIT_LIST_HEAD(&TxBlock[k].synclist);
 	}
 
 	for (k = 1; k < nTxBlock - 1; k++) {
@@ -974,7 +975,7 @@ static void txUnlock(struct tblock * tblk)
 	if (tblk->lsn) {
 		LOGSYNC_LOCK(log, flags);
 		log->count--;
-		list_del(&tblk->synclist);
+		list_del_init(&tblk->synclist);
 		LOGSYNC_UNLOCK(log, flags);
 	}
 }
-- 
2.34.1


