Return-Path: <linux-kernel+bounces-891839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7F1C43A11
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 09:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF0193AE4B7
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 08:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C096B24469E;
	Sun,  9 Nov 2025 08:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="RHStroJO"
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8741A9FA0
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 08:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762675300; cv=none; b=PYbcYLxyXjzgZ0OKCHzRLEjLbgWvKHO+30SMVObByjKp8jZUwprCbZk78NK9CpDx5WtYMRYkKx/8e+aFY7lzOw8Rsy2pd49JyAnrjP9MkrBKi2+/a7wPVfjjea15Ll1+H9txwSRvwHGm3VeF+Y8lqLtib+qFrwLTl2p9Aua5l0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762675300; c=relaxed/simple;
	bh=uTC+PkKSK+WVl6tn9Cjr+7Zm5h0nvIfbFbJI+LFMSns=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XJ/QCxMmos9zTUk9tPcLWMvm1+45tIjnQ50OheKDCxyuziye2uakbqGGc+z+dIjeT73j7fFHsvbw84VaBbtV9IH0FQdfmyqCXdYblcgbhe9mcmMSCTPnzCBE6PqimkfltreFYDGOgzy5KN3A+dKnrNmhtLdiPab4BTwOd3Jt9QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=RHStroJO; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A97swWc2547971;
	Sun, 9 Nov 2025 00:01:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=hqKCmdP7z
	xwz+X23A5A9/L6yq/4SS8Ac005fbjv9X7Q=; b=RHStroJO+RWipWU1eSEzHwsjN
	hT/oOvGZW9mLOBGJvyYHG+DNowTehyEDsZ9MM7qQGH5MgsnPxrPy2VUC9mu6kpVC
	UcF0Ahl68oMe52g2T0S8L7QFvA6StizYpbrzC74Ltd4Ox0Pf7CvHDsdoc1J4n5aL
	1FKpcydYV/K+wT6O1k4PtrObolKr3cwB1Y5itfQmxr+HRUrqozKAHVPRdF1HCSQP
	F+BHfdIwROZdzPjajn+FXaJik0X/bBCJ9iaWcW1PFz4bPzQ29ClYkHLSJxFZxMKu
	o6eKEUCrDyQYAc+EZ75Y+XUATBZHaUjqWLbcNZB+TpLj/c3BZHjpvwkLLG2lQ==
Received: from ala-exchng02.corp.ad.wrs.com ([128.224.246.37])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4aa68jgh5k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Sun, 09 Nov 2025 00:01:17 -0800 (PST)
Received: from ala-exchng01.corp.ad.wrs.com (10.11.224.121) by
 ALA-EXCHNG02.corp.ad.wrs.com (10.11.224.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.61; Sun, 9 Nov 2025 00:01:16 -0800
Received: from pek-lpd-ccm3.wrs.com (10.11.232.110) by
 ala-exchng01.corp.ad.wrs.com (10.11.224.121) with Microsoft SMTP Server id
 15.1.2507.61 via Frontend Transport; Sun, 9 Nov 2025 00:01:14 -0800
From: Yun Zhou <yun.zhou@windriver.com>
To: <shaggy@kernel.org>, <akpm@linux-foundation.org>, <david@redhat.com>,
        <byungchul@sk.com>, <gregkh@linuxfoundation.org>,
        <yun.zhou@windriver.com>, <shivankg@amd.com>,
        <ssrane_b23@ee.vjti.ac.in>
CC: <jfs-discussion@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] jfs: add linelock->index boundary check in diWrite
Date: Sun, 9 Nov 2025 16:01:13 +0800
Message-ID: <20251109080113.236739-1-yun.zhou@windriver.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA5MDA2OSBTYWx0ZWRfX+nxJXFTVFzxm
 v1ZyFut3T0dND5GV4YayRuuERPa4UMMGzpRVZrfT5m7uq9MQRdONN6qJvpi/odhGWrNRsFmGpfa
 IzYneWhsVMpgoftBi27YSdxzwaZWqnjZJdH2+OqiVhzzp0yQ6BOt1ly/CrCQKr4EXto785h9JRr
 dpkmpZ0n1YP0ypn/SPO/rJ7IFdaElnKlcWUR1xm6oitAAU+t9NxrgU5HHxY+NiIrlypOlnJuEuy
 X52m3q8qzPkhEn6joCfjkzDnnIC12X+btJpD7jzV/Mcs4kALXHvMpWPFRgISNrQ0MLs5ISORliy
 eomPliTlTYtlF1PnIVfZllGMqQew1AuvDuDMX1VYTuIFKTiA1PIvlKafMI6DCBNBim7jl5Xo23H
 ivpqjs5bud9pEVqLXof6IF7mizMQlQ==
X-Proofpoint-GUID: BpCl5-HMoPr1VIw6Am6Gap3W_YUZkI7r
X-Proofpoint-ORIG-GUID: BpCl5-HMoPr1VIw6Am6Gap3W_YUZkI7r
X-Authority-Analysis: v=2.4 cv=ef0wvrEH c=1 sm=1 tr=0 ts=69104a4d cx=c_pps
 a=Lg6ja3A245NiLSnFpY5YKQ==:117 a=Lg6ja3A245NiLSnFpY5YKQ==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=hSkVLCK3AAAA:8 a=t7CeM3EgAAAA:8
 a=839DiVg-qJ3f83dBwJIA:9 a=cQPPKAXgyycSBL8etih5:22 a=FdTzh2GWekK77mhwV6Dw:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-09_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 clxscore=1011 spamscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511090069

This patch adds boundary checks for the dilinelock->index in the
diWrite() function of JFS to prevent out-of-bounds access to the lv
array. When dilinelock->index exceeds dilinelock->maxcnt, it calls
txLinelock() to refresh the dilinelock structure, ensuring valid access
to dilinelock->lv[] during inode data writing.

Reported-by: syzbot+9489c9f9f3d437221ea2@syzkaller.appspotmail.com
Signed-off-by: Yun Zhou <yun.zhou@windriver.com>
---
 fs/jfs/jfs_imap.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
index ecb8e05b8b84..7f93150d319f 100644
--- a/fs/jfs/jfs_imap.c
+++ b/fs/jfs/jfs_imap.c
@@ -762,6 +762,8 @@ int diWrite(tid_t tid, struct inode *ip)
 	 * copy inline symlink from in-memory inode to on-disk inode
 	 */
 	if (S_ISLNK(ip->i_mode) && ip->i_size < IDATASIZE) {
+		if (unlikely(dilinelock->index >= dilinelock->maxcnt))
+			dilinelock = txLinelock(dilinelock);
 		lv = & dilinelock->lv[dilinelock->index];
 		lv->offset = (dioffset + 2 * 128) >> L2INODESLOTSIZE;
 		lv->length = 2;
@@ -773,6 +775,8 @@ int diWrite(tid_t tid, struct inode *ip)
 	 * 128 byte slot granularity
 	 */
 	if (test_cflag(COMMIT_Inlineea, ip)) {
+		if (unlikely(dilinelock->index >= dilinelock->maxcnt))
+			dilinelock = txLinelock(dilinelock);
 		lv = & dilinelock->lv[dilinelock->index];
 		lv->offset = (dioffset + 3 * 128) >> L2INODESLOTSIZE;
 		lv->length = 1;
@@ -785,6 +789,8 @@ int diWrite(tid_t tid, struct inode *ip)
 	/*
 	 *	lock/copy inode base: 128 byte slot granularity
 	 */
+	if (unlikely(dilinelock->index >= dilinelock->maxcnt))
+		dilinelock = txLinelock(dilinelock);
 	lv = & dilinelock->lv[dilinelock->index];
 	lv->offset = dioffset >> L2INODESLOTSIZE;
 	copy_to_dinode(dp, ip);
-- 
2.34.1


