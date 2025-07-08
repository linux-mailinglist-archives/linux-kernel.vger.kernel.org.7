Return-Path: <linux-kernel+bounces-722478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC846AFDB18
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 00:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4777B7B5A81
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 22:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4769725A2C7;
	Tue,  8 Jul 2025 22:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QOCUOTpe"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041AD14EC73
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 22:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752013568; cv=none; b=dX0y7nOv9156gpRdETdqWoJpgxVZsZNRc4d5rteTbVa9wl9lYmUB+09wB6dZfeSCrLlbHhfpO7qvkzGqCcCl7hcAQtz/aWocnsGXE5F3uYrxyJvItfAjbbGqyQorZP4ajPRWr0Ybh0iXNEaiAht4VX1jX66kPSZhQUAd4N0KmxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752013568; c=relaxed/simple;
	bh=hwVKfnkkcD0PFLenk7LeZVIo56XKgWXEip4EBHun/+s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D0JEMqT91aSsukV/LGy1nvlinhYjfxoiFMVFAcwnf4tnjxyQOeESH3Mou/wEGoXV3C+gBma9qRZkeL4W9AyOyRL7vN8BYhZEVOS7qbREgs82p/yv946mW7FK/T205mBlh/G0TswubAyjQrdWZVH00bqJMZ6J57qpQbskYKorHHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QOCUOTpe; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568Ld25Y026590;
	Tue, 8 Jul 2025 22:25:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=sRrwsDxc5jjO1RB40RwPCAeSOXBzC
	ncBhkVV8FKBV9g=; b=QOCUOTpegt4FmdzQ2GtElLRfwBNp+AjzbjMBd7DTz2oNR
	1ef8XGVOG4PrwzABQ0Z1wjFeB0ZZamSQOIgUXLJ0D390U0PQiLoa3rSws4DPOjjJ
	T9U3+ri6IyxLmfIe8Sp574C3sns2Cs5yWVn7Tu0zPkeMbDBlHSy13PeNF4UWw518
	IA4odk6gJuttgdmdD5Ko1z0Sx4dopcnQlpfSFtqRB+QRO22OJJCbiCsHPi0LN1e4
	qNhUfUiZRiOZbG0ucOCxkXhKXecufL9W29BrZBzSFKjOMwsamo2THvida+dqDoXE
	L6fSQk7NmVPyiTgByPxzOfYMqRccS588gsKFEN3HQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47sbd981ug-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Jul 2025 22:25:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 568KW1eS013997;
	Tue, 8 Jul 2025 22:25:44 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ptga7ctx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Jul 2025 22:25:44 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 568MPhoP031646;
	Tue, 8 Jul 2025 22:25:43 GMT
Received: from hmadhani-upstream.osdevelopmeniad.oraclevcn.com (hmadhani-upstream.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.255.48])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 47ptga7ctn-1;
	Tue, 08 Jul 2025 22:25:43 +0000
From: himanshu.madhani@oracle.com
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, Himanshu Madhani <himanshu.madhani@oracle.com>,
        Jorge Lopez <jorge.jo.lopez@oracle.com>
Subject: [PATCH] PCI/THP: Fix hang due to incorrect guard lock
Date: Tue,  8 Jul 2025 22:25:30 +0000
Message-ID: <20250708222530.1041477-1-himanshu.madhani@oracle.com>
X-Mailer: git-send-email 2.41.0.rc2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_06,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507080190
X-Proofpoint-GUID: lyBUCNQET5bwI1lGd6CHOvoz85_AYV3Q
X-Proofpoint-ORIG-GUID: lyBUCNQET5bwI1lGd6CHOvoz85_AYV3Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDE5MCBTYWx0ZWRfXwjpjwq/jNuxl gKlu/cI03E1/Rhczk96zVbth6g8X+VvKale4cd6e+9etEZ/qYqe+MKCN+YN0XzotvRxc/70ydYD o0XR2AWi4ez03RyYDITNfIz344px/ulmGGKdcQIVET5vSYe6vbHcbSnKf5Pw/GludWJB6WHklcp
 kAbo4lKWax6h0lZO19Rt842VjWPtaHO1kNu2SKvRJaByQ2bJkMGbzMPsG/94GlTtPK3CKqrbQhy ERwaDG9YPkdZaqXifBefJgVHOjU6CaYKoiMq7VSeLnz/rAfrlR3Qlvjt4TJU4Q80L2tF1wdoYkB nc3tX8CoRoX/mk8E+cY1qRlEGyJ4uUyCe8pCdp8i9XSpkIVz8/zkoLmOySskOp1WhJkgd6pSkLH
 mFdOoj+N/lTxeG0x+IhTIF1EMMONpEcxy0E7pV0wQZBIxpAB88ck2LVfhs6BwmbeUz29wuTO
X-Authority-Analysis: v=2.4 cv=IdSHWXqa c=1 sm=1 tr=0 ts=686d9ae9 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=Wb1JkmetP80A:10 a=yPCof4ZbAAAA:8 a=CrPlAlOk08TLbAMXQ7cA:9 cc=ntf awl=host:12058

From: Himanshu Madhani <himanshu.madhani@oracle.com>

Fix system hang due to incorrect mutex lock placement.

following stack trace will be seen on system boot

[  525.664681] task:systemd-shutdow state:D stack:0     pid:1     tgid:1     ppid:0      task_flags:0x400100 flags:0x00004002
[  525.796878] Call Trace:
[  525.826116]  <TASK>
[  525.851195]  __schedule+0x2d1/0x730
[  525.892917]  schedule+0x27/0x80
[  525.930478]  schedule_preempt_disabled+0x15/0x30
[  525.985718]  __mutex_lock.constprop.0+0x4be/0x8a0
[  526.041993]  msi_domain_get_virq+0xcc/0x110
[  526.092031]  pci_msix_write_tph_tag+0x3c/0x100
[  526.145186]  pcie_tph_set_st_entry+0x125/0x1d0
[  526.198346]  bnxt_irq_affinity_release+0x35/0x50 [bnxt_en]
[  526.264015]  irq_set_affinity_notifier+0xe0/0x130
[  526.320291]  bnxt_free_irq+0x6e/0x110 [bnxt_en]
[  526.374507]  __bnxt_close_nic.isra.0+0x1eb/0x220 [bnxt_en]
[  526.440175]  bnxt_close+0x3a/0x100 [bnxt_en]
[  526.491264]  __dev_close_many+0xae/0x220
[  526.538179]  dev_close_many+0xc2/0x1b0
[  526.583014]  netif_close+0x9d/0xd0
[  526.623693]  bnxt_shutdown+0xb1/0xe0 [bnxt_en]
[  526.676874]  pci_device_shutdown+0x35/0x70
[  526.725871]  device_shutdown+0x118/0x1a0
[  526.772788]  kernel_restart+0x3a/0x70
[  526.816588]  __do_sys_reboot+0x150/0x250
[  526.863504]  do_syscall_64+0x84/0x940
[  526.907300]  ? __put_user_8+0xd/0x20
[  526.950059]  ? rseq_ip_fixup+0x90/0x1e0
[  526.995937]  ? task_mm_cid_work+0x1ad/0x220
[  527.045971]  ? __rseq_handle_notify_resume+0x35/0x90
[  527.105367]  ? arch_exit_to_user_mode_prepare.isra.0+0x98/0xb0
[  527.175166]  ? do_syscall_64+0xba/0x940
[  527.221040]  ? do_filp_open+0xd7/0x1a0
[  527.265882]  ? alloc_fd+0xba/0x110
[  527.306556]  ? do_sys_openat2+0xa4/0xf0
[  527.352434]  ? __x64_sys_openat+0x54/0xb0
[  527.400389]  ? arch_exit_to_user_mode_prepare.isra.0+0x9/0xb0
[  527.469150]  ? do_syscall_64+0xba/0x940
[  527.515023]  ? do_user_addr_fault+0x221/0x690
[  527.567141]  ? clear_bhb_loop+0x30/0x80
[  527.613017]  ? clear_bhb_loop+0x30/0x80
[  527.658895]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  527.719332] RIP: 0033:0x7fc3ec504777
[  527.762091] RSP: 002b:00007ffecd62c4f8 EFLAGS: 00000202 ORIG_RAX: 00000000000000a9
[  527.852685] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fc3ec504777
[  527.938085] RDX: 0000000001234567 RSI: 0000000028121969 RDI: 00000000fee1dead
[  528.023485] RBP: 00007ffecd62c700 R08: 0000000000000000 R09: 00007ffecd62b8e0
[  528.108878] R10: 0000000000000001 R11: 0000000000000202 R12: 00007ffecd62c568
[  528.194273] R13: 00007ffecd62c548 R14: 00007ffecd62c568 R15: 0000000000000000
[  528.279672]  </TASK>

Fixes: d5124a9957b2 ("PCI/MSI: Provide a sane mechanism for TPH")
Fixes: 71296eae5887 ("PCI/TPH: Replace the broken MSI-X control word update")
Reported-by: Jorge Lopez <jorge.jo.lopez@oracle.com>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Jorge Lopez <jorge.jo.lopez@oracle.com>
Signed-off-by: Himanshu Madhani <himanshu.madhani@oracle.com>
---
 drivers/pci/msi/msi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index 6ede55a7c5e6..d686488f4111 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -934,10 +934,12 @@ int pci_msix_write_tph_tag(struct pci_dev *pdev, unsigned int index, u16 tag)
 	if (!pdev->msix_enabled)
 		return -ENXIO;
 
-	guard(msi_descs_lock)(&pdev->dev);
 	virq = msi_get_virq(&pdev->dev, index);
 	if (!virq)
 		return -ENXIO;
+
+	guard(msi_descs_lock)(&pdev->dev);
+
 	/*
 	 * This is a horrible hack, but short of implementing a PCI
 	 * specific interrupt chip callback and a huge pile of
-- 
2.41.0.rc2


