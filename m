Return-Path: <linux-kernel+bounces-896143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63071C4FBF7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 21:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21E943AEC47
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 20:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53FD53A5E9B;
	Tue, 11 Nov 2025 20:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="No13vpAF"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43958361DD6
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 20:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762894513; cv=none; b=LjwdubtyCWq1G1N/HSUu4a8eNe8968zHhID/OfIK1pcJ6MHye0rAI5MLXAmMk+HAh9Oxg7XTUXtB6aD91FcL7MMQ/r9MntBcVx1RBTbp7xPZRBG3tjAJYZ/xDgwvaFNCWTqOyKcSs3S9xQR/6bkxkDL7hv+1MSkNffs6jc2VW6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762894513; c=relaxed/simple;
	bh=EeKmYYyqEcmvfED0FbU/MKRN8rnFixpLLEPgHxtZ24Q=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=gAjPmSKvTckffJ/cgEi04W415K3n+M3pkWOLyBDpr4sAWanIzn/Fm/PMCMl94WnXMW0wL4xF7XP0s+SwWKMynWFEN+NP6TQxDdvml8K/6INGwSxNmHspRTsMisqArUyuOOOhioNN4DSwf0dTpx6PCbsb7ysvlFS42HVUpcuUKNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=No13vpAF; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ABKF2e7020797;
	Tue, 11 Nov 2025 20:26:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=xC+ZSF9n1po8poKVO7VUqJWqsxklw
	mpjOkv7AHvwk8U=; b=No13vpAF/iKz0wJaHWNI5OgxAgEA1Nh1Gv2QrtIZJ2zW4
	xww73uDWd2nnaZHNRNY+Pdytp8294a2puSGGtvGfb0Fxh79W1QSjvksfbKDb0deF
	wyJNg4IUvrbrQPZZXqUbiOcaE3sxot5SXWf5vWMfO0r6RgX8RTUI34nalAopVKr7
	XobxxZVRsanVqZI/7vJMrstrQqPWbtj8ddiUFe1PECycTpmvl2+oA52WX45uLTt4
	TfktIwVgS2n/lKfhulfT9EHUtHhswJnk9kY0zAYLvhmWV3XTYMckcnz+xfHFfKiZ
	K68xicmGOctXBwYNBBslhi2TOpeQ63MuQCatx4CIw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acaptr3mk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Nov 2025 20:26:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ABJ1VET039952;
	Tue, 11 Nov 2025 20:26:20 GMT
Received: from brm-x62-16.us.oracle.com (brm-x62-16.us.oracle.com [10.80.150.37])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a9va9wdu3-1;
	Tue, 11 Nov 2025 20:26:20 +0000
From: Jane Chu <jane.chu@oracle.com>
To: gregkh@linuxfoundation.org, tj@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs/kernfs: raise sb->maxbytes to MAX_LFS_FILESIZE
Date: Tue, 11 Nov 2025 13:26:06 -0700
Message-ID: <20251111202606.1505437-1-jane.chu@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_04,2025-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511110166
X-Authority-Analysis: v=2.4 cv=BYrVE7t2 c=1 sm=1 tr=0 ts=69139bed b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=XZXHcWFAyepS9mc2pJsA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDE1MiBTYWx0ZWRfXwiwcz0oRCjCB
 50uEUy/4rKC4dPFYA6x2iOoT1fdOHZ8vhka8ihoijU2Jcat/IQ6/G0/nxdV4Tf02+3JzQDd0Ezg
 2AoDCaq3tPEVVyAo3Qm0IV/NVXBlftbOT4DHkUjA8djzZzeY2Mpsn8WkPeG2TJ6RzHoQnDMAOGP
 YFjO3qR5gVecuhibuCElQzVaK5U9UtzTnQiuGhqrcMKWf2dbLK666i6d4g8VOBHAL5NswNmOg46
 hTpnFnZMfCAKz5L7UYC2JIru3ZUPx/bbTLZueM/qPB4BdaOqvXZdf3YlHLsvUdVuT8WX2ypWV0g
 5NX3aNd+5MOgK06iooWkehLMDlNN7y+m/zti1OHSsWkBY3Nnd6LGiw7gB+jr2mMtfME8T9MiI7L
 ZVjmi/XjjUV9aAkl+6fmqdPO0KSiOA==
X-Proofpoint-GUID: lvI11MFomyWjyqLxxpzot5QeXYKdMiaJ
X-Proofpoint-ORIG-GUID: lvI11MFomyWjyqLxxpzot5QeXYKdMiaJ

On an ARM64 A1 system, it's possible to have physical memory span
up to the 64T boundary, like below

$ lsmem -b -r -n -o range,size
0x0000000080000000-0x00000000bfffffff 1073741824
0x0000080000000000-0x000008007fffffff 2147483648
0x00000800c0000000-0x0000087fffffffff 546534588416
0x0000400000000000-0x00004000bfffffff 3221225472
0x0000400100000000-0x0000407fffffffff 545460846592

So it's time to extend /sys/kernel/mm/page_idle/bitmap to be able
to account for >2G number of pages, by raising the kernfs file size
limit.

Signed-off-by: Jane Chu <jane.chu@oracle.com>
---
 fs/kernfs/mount.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index 76eaf64b9d9e..3ac52e141766 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -298,6 +298,7 @@ static int kernfs_fill_super(struct super_block *sb, struct kernfs_fs_context *k
 	if (info->root->flags & KERNFS_ROOT_SUPPORT_EXPORTOP)
 		sb->s_export_op = &kernfs_export_ops;
 	sb->s_time_gran = 1;
+	sb->s_maxbytes  = MAX_LFS_FILESIZE;
 
 	/* sysfs dentries and inodes don't require IO to create */
 	sb->s_shrink->seeks = 0;
-- 
2.43.5


