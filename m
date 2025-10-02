Return-Path: <linux-kernel+bounces-839867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF47FBB29C2
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 08:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9363D3AD1EA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 06:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 847E728C84F;
	Thu,  2 Oct 2025 06:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="hdqpTeA8"
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D9034BA47;
	Thu,  2 Oct 2025 06:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759385585; cv=none; b=WLk8M0nQneVPo/uBsohY+wATxdQC7I1XHhx7QO2Lj8bAk3zx2xjU4VtfGfe21h8rRLTek1O0JRAhYP6STM12nATDzPlC1wwMtSp3G+z12Ms0ArBZ0e/JuOIMzhzjFd2XHLIFTVZFa5HJyK2Gq5dbrRgsgkkMPiynx6lvXCi09CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759385585; c=relaxed/simple;
	bh=GjLK0p+izySXHz7kEOe4+iLKCXhXiT5g3d28CfE/DE4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jfoExMDNdBan558CHAJxrKcLkugCm2Bwt/twqx0Py2azL1RoBmR5qEMva/t6hQO01hn0117MjNw67/QMs5t3bf0i+9JIHqm7xNlOYItM9BcjtQjf3djhl26n2oK7msADnpX/jkoKn/309t6RMdCzV7uybnAG33LWulc2WUtQGRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=hdqpTeA8; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59268fMg3849820;
	Thu, 2 Oct 2025 06:12:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=kAMh6joK6
	HOtEonNKtVBdVyO8wKGvRGr0L0AuFQk6Is=; b=hdqpTeA85gz2vvFfN9YzS5JvX
	W1GhGsIYihw5+8E1ajl9esp1iXneMSgvXdaKPSi8umO011PaWJ7mO+dYi3VCUaT+
	k7MM9QtY25D1OE4BVHVTOsS25e7gDM6NGifLcC+KUK3K7p6dhsKgchFUraLQoM1h
	WGMAMJdHUZgSPnuNLWc66WZZbNFioq9JLyZG1uipZMH1gLPhgdwGWtn7IZJqctex
	yhbQOAzKjIA4Af7klIsRYrzVXIeG6Wzd2c0GmIxBdfZCN6gRadrWGdVFIW0pS15X
	R0mWpdtM640PQlFDCbXYCc+kAdRFFTpaOuJnRHjM7dA7jedRtOZjDfszozo/Q==
Received: from ala-exchng01.corp.ad.wrs.com ([128.224.246.36])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 49e54wwye8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 02 Oct 2025 06:12:20 +0000 (GMT)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.59; Wed, 1 Oct 2025 23:12:18 -0700
Received: from pek-lpd-ccm5.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.59 via Frontend Transport; Wed, 1 Oct 2025 23:12:16 -0700
From: Yun Zhou <yun.zhou@windriver.com>
To: <bmasney@redhat.com>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <dianders@chromium.org>, <yun.zhou@windriver.com>
CC: <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] [v2] clk: fix slab-use-after-free when clk_core_populate_parent_map failed
Date: Thu, 2 Oct 2025 14:12:15 +0800
Message-ID: <20251002061215.1055185-1-yun.zhou@windriver.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDAyMDA1MSBTYWx0ZWRfX2UDiLL7D+B7T
 dmv+ksyoMZiyrPAVQvvEUkpl/Tjzj5C94CRWUsm/ZeSdF1r6hOwkf/68uJVn7seSf2SuGztdUE3
 fNfaW9R22+xczViaB4BQU9Qqirtb6TySDiWIwRiRpkgMOrZBXPV8YTq30/6Z+3JdaSoNxRIxp+d
 R37eb3H35bXLCwLaiCgAaARfJ/yg4uzRoxWIpbhQDA9CquipYvkGOOqDag2JFMSgiqOdFDCeWF6
 JpABaFescSky/dO6JKkEouX35gnpgaKyPwpkQtibZT7mlNAbYOqfHmOK7wDOIsI1xhzDFX3EVhG
 uJVR8FdBnjM9PsfzOUBkq4BEBm6h9roj8fvKicvDM1y9i0IOoSApQNbzMBq+jaxNazNvotH4nk/
 bbr/1Hx6AAszSDBoUixosVZ0JeAKmg==
X-Authority-Analysis: v=2.4 cv=ZNPaWH7b c=1 sm=1 tr=0 ts=68de17c4 cx=c_pps
 a=AbJuCvi4Y3V6hpbCNWx0WA==:117 a=AbJuCvi4Y3V6hpbCNWx0WA==:17
 a=x6icFKpwvdMA:10 a=t7CeM3EgAAAA:8 a=20KFwNOVAAAA:8 a=DMPQ43qBQR3bOjbsdysA:9
 a=FdTzh2GWekK77mhwV6Dw:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: UYpdVda9EF2249JbDxzTjG9sMesolJu_
X-Proofpoint-GUID: UYpdVda9EF2249JbDxzTjG9sMesolJu_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-02_02,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 bulkscore=0 suspectscore=0 spamscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2509150000
 definitions=main-2510020051

If clk_core_populate_parent_map() fails, core->parents will be immediately
released within clk_core_populate_parent_map(). Therefore it is can't be
released in __clk_release() again.

This fixes the following KASAN reported issue:

==================================================================
BUG: KASAN: slab-use-after-free in __clk_release+0x80/0x160
Read of size 8 at addr ffffff8043fd0980 by task kworker/u6:0/27

CPU: 1 PID: 27 Comm: kworker/u6:0 Tainted: G        W          6.6.69-yocto-standard+ #7
Hardware name: Raspberry Pi 4 Model B (DT)
Workqueue: events_unbound deferred_probe_work_func
Call trace:
 dump_backtrace+0x98/0xf8
 show_stack+0x20/0x38
 dump_stack_lvl+0x48/0x60
 print_report+0xf8/0x5d8
 kasan_report+0xb4/0x100
 __asan_load8+0x9c/0xc0
 __clk_release+0x80/0x160
 __clk_register+0x6dc/0xfb8
 devm_clk_hw_register+0x70/0x108
 bcm2835_register_clock+0x284/0x358
 bcm2835_clk_probe+0x2c4/0x438
 platform_probe+0x98/0x110
 really_probe+0x1e4/0x3e8
 __driver_probe_device+0xc0/0x1a0
 driver_probe_device+0x110/0x1e8
 __device_attach_driver+0xf0/0x1a8
 bus_for_each_drv+0xf8/0x178
 __device_attach+0x120/0x240
 device_initial_probe+0x1c/0x30
 bus_probe_device+0xdc/0xe8
 deferred_probe_work_func+0xe8/0x130
 process_one_work+0x2a4/0x698
 worker_thread+0x53c/0x708
 kthread+0x1b4/0x1c8
 ret_from_fork+0x10/0x20

Allocated by task 27:
 kasan_save_stack+0x3c/0x68
 kasan_set_track+0x2c/0x40
 kasan_save_alloc_info+0x24/0x38
 __kasan_kmalloc+0xd4/0xd8
 __kmalloc+0x74/0x238
 __clk_register+0x718/0xfb8
 devm_clk_hw_register+0x70/0x108
 bcm2835_register_clock+0x284/0x358
 bcm2835_clk_probe+0x2c4/0x438
 platform_probe+0x98/0x110
 really_probe+0x1e4/0x3e8
 __driver_probe_device+0xc0/0x1a0
 driver_probe_device+0x110/0x1e8
 __device_attach_driver+0xf0/0x1a8
 bus_for_each_drv+0xf8/0x178
 __device_attach+0x120/0x240
 device_initial_probe+0x1c/0x30
 bus_probe_device+0xdc/0xe8
 deferred_probe_work_func+0xe8/0x130
 process_one_work+0x2a4/0x698
 worker_thread+0x53c/0x708
 kthread+0x1b4/0x1c8
 ret_from_fork+0x10/0x20

Freed by task 27:
 kasan_save_stack+0x3c/0x68
 kasan_set_track+0x2c/0x40
 kasan_save_free_info+0x38/0x60
 __kasan_slab_free+0x100/0x170
 slab_free_freelist_hook+0xcc/0x218
 __kmem_cache_free+0x158/0x210
 kfree+0x88/0x140
 __clk_register+0x9d0/0xfb8
 devm_clk_hw_register+0x70/0x108
 bcm2835_register_clock+0x284/0x358
 bcm2835_clk_probe+0x2c4/0x438
 platform_probe+0x98/0x110
 really_probe+0x1e4/0x3e8
 __driver_probe_device+0xc0/0x1a0
 driver_probe_device+0x110/0x1e8
 __device_attach_driver+0xf0/0x1a8
 bus_for_each_drv+0xf8/0x178
 __device_attach+0x120/0x240
 device_initial_probe+0x1c/0x30
 bus_probe_device+0xdc/0xe8
 deferred_probe_work_func+0xe8/0x130
 process_one_work+0x2a4/0x698
 worker_thread+0x53c/0x708
 kthread+0x1b4/0x1c8
 ret_from_fork+0x10/0x20

The buggy address belongs to the object at ffffff8043fd0800
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 384 bytes inside of
 freed 512-byte region [ffffff8043fd0800, ffffff8043fd0a00)

The buggy address belongs to the physical page:
page:fffffffe010ff400 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffffff8043fd0e00 pfn:0x43fd0
head:fffffffe010ff400 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0x4000000000000840(slab|head|zone=1)
page_type: 0xffffffff()
raw: 4000000000000840 ffffff8040002f40 ffffff8040000a50 ffffff8040000a50
raw: ffffff8043fd0e00 0000000000150002 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffffff8043fd0880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffffff8043fd0900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffffff8043fd0980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffffff8043fd0a00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffffff8043fd0a80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================

Fixes: fc0c209c147f ("clk: Allow parents to be specified without string names")
Signed-off-by: Yun Zhou <yun.zhou@windriver.com>
Reviewed-by: Brian Masney <bmasney@redhat.com>
---
 drivers/clk/clk.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index b821b2cdb155..b93f38de4cac 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -4254,7 +4254,6 @@ static int clk_core_populate_parent_map(struct clk_core *core,
 	 * having a cache of names/clk_hw pointers to clk_core pointers.
 	 */
 	parents = kcalloc(num_parents, sizeof(*parents), GFP_KERNEL);
-	core->parents = parents;
 	if (!parents)
 		return -ENOMEM;
 
@@ -4295,6 +4294,8 @@ static int clk_core_populate_parent_map(struct clk_core *core,
 		}
 	}
 
+	core->parents = parents;
+
 	return 0;
 }
 
@@ -4302,7 +4303,7 @@ static void clk_core_free_parent_map(struct clk_core *core)
 {
 	int i = core->num_parents;
 
-	if (!core->num_parents)
+	if (!core->parents)
 		return;
 
 	while (--i >= 0) {
-- 
2.27.0


