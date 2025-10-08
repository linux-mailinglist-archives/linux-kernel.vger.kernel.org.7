Return-Path: <linux-kernel+bounces-845629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20DF4BC58E9
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 17:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEFF9405144
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 15:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB982F3607;
	Wed,  8 Oct 2025 15:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="s7Gz18eG"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62D92F0C7E
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 15:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759936934; cv=none; b=UumOO1RbBBB3E3zdzzvdhsMdSRBfk0ikrA0bghBftf915M+nOP9xRQiTmaxU5HdvAVA3WiaVE0r6RQIzVD+T9pH7woypzsHdsFe56dmTjA1nKgHvZYCU9soz1WAmadSkpztt4yOLurHHPF0aEtK0eEmgUfmjPr4vqc/oPTR+TZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759936934; c=relaxed/simple;
	bh=9kxjRMOIUo1Pn63bWj03jhOAGDC+43cf/+PwSN4qMYI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M0+mfKcGraTPvVhWQbsH82NdZU+6cZKV4sgL4vOy+eIKRlFyM+XS4ZiVq1WCqvgaSWkdU5wcr1diwdEygx1A9amwMZ1B3fjDHBwmiuxXVW9t/impOX5DoTaHqPbtBuJAkOBUGfanWxJE/U8MvbMT9mcBU69WSbbHTshV1FJ7kI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=s7Gz18eG; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5989m0Gd023738;
	Wed, 8 Oct 2025 15:22:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=HoSjTgF7kxgyx27i2UD/lNXuKMHGGTMDrp+33a0hp
	/8=; b=s7Gz18eGGTJIo65mYPaOy1jpeEppsTuxwf2E04U7r0togjkwVc0Hq1p0D
	OLDcuMm/11taFNdNnVsbnpckOLd7d2izwT6npbCpPRLNRndZfnZua+d6gfmxaUrY
	p1M2095r4knkxWJPvneMFtMeGe7UhtG1HzRvIxIt/PxnnHSo72vICKv6TSYQxQNu
	V1aqjCi9ruQDvL+k0LpNRXuUGYqTOHNyEhPCivo22kAySV0M1t9FdNQ5kj9kwxbs
	dDabjbE7Vx/4DSHbHbq+56Z7VgjZg+G8wuGk5Hy6r0dQumA2tGscmeGZu25hsXbN
	H9qxkh1Dpa2D2nVZHmMnOq59UJtTA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49jt0pn9xn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Oct 2025 15:22:06 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 598E5tTI028463;
	Wed, 8 Oct 2025 15:22:06 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49kewn94w7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Oct 2025 15:22:06 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 598FM45g4129292
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Oct 2025 15:22:04 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 77F6A5805A;
	Wed,  8 Oct 2025 15:22:04 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 27FE35805F;
	Wed,  8 Oct 2025 15:22:04 +0000 (GMT)
Received: from slate16 (unknown [9.61.25.218])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  8 Oct 2025 15:22:04 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: linux-fsi@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, ninad@linux.ibm.com,
        gregkh@linuxfoundation.org, Eddie James <eajames@linux.ibm.com>
Subject: [PATCH] fsi: occ: Update response size to 8kb
Date: Wed,  8 Oct 2025 10:21:57 -0500
Message-ID: <20251008152157.1387182-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XvT3+FF9 c=1 sm=1 tr=0 ts=68e6819e cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=x6icFKpwvdMA:10 a=VnNF1IyMAAAA:8 a=BGEI4LeKWJWrEHHieJQA:9
X-Proofpoint-ORIG-GUID: 79DBqFNqAHcOAnbqWpZrf-vtaGmVNxAt
X-Proofpoint-GUID: 79DBqFNqAHcOAnbqWpZrf-vtaGmVNxAt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAwOSBTYWx0ZWRfX9qTd3flEXHex
 MPUnhkTcwCXbETfxBv0e4dt5ECKUV60PHTXZcqBn7GVCOJy33wP50uI7dcL9dTxkpVpVxaBphSF
 5GdOxa9XwbofqkLU35HSAhgrNvWQuTkq/uzH4c8aCklNmBbaWZiB7BiSU60Mn5BUUI94c+TdR/r
 8RFqfqnheztVHpaK9FGA3+VIjRFXv9xKaGYxT4CI1KE6bZR2C0YYLV4Saqz5AVNxmYlWVWPXY77
 WF3QBsTmw1ZtrPK+/u4IMsf2o+CI4v42zSLVae7rJrfONQFlrK9sGSdfDlCeA+64iVp6Cxb7Vmm
 5n2rLo77WWijXqOdZ+y6oAfIKRszypUEFPFz+5sfRHu0S4m7V4lWsM93AdmD9F7LFpFtdFttSH4
 2amHZ0wSe2UnE7kO8mUzUIm/kJWukA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 priorityscore=1501 clxscore=1011 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040009

Newer OCCs return more data.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/fsi/fsi-occ.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/fsi/fsi-occ.c b/drivers/fsi/fsi-occ.c
index d3e6bf37878a7..e41ef12fa0959 100644
--- a/drivers/fsi/fsi-occ.c
+++ b/drivers/fsi/fsi-occ.c
@@ -22,9 +22,9 @@
 #include <linux/uaccess.h>
 #include <linux/unaligned.h>
 
-#define OCC_SRAM_BYTES		4096
-#define OCC_CMD_DATA_BYTES	4090
-#define OCC_RESP_DATA_BYTES	4089
+#define OCC_SRAM_BYTES		8192
+#define OCC_CMD_DATA_BYTES	8186
+#define OCC_RESP_DATA_BYTES	8185
 
 #define OCC_P9_SRAM_CMD_ADDR	0xFFFBE000
 #define OCC_P9_SRAM_RSP_ADDR	0xFFFBF000
@@ -86,7 +86,7 @@ static int occ_open(struct inode *inode, struct file *file)
 	if (!client)
 		return -ENOMEM;
 
-	client->buffer = (u8 *)__get_free_page(GFP_KERNEL);
+	client->buffer = kvmalloc(OCC_SRAM_BYTES, GFP_KERNEL);
 	if (!client->buffer) {
 		kfree(client);
 		return -ENOMEM;
@@ -97,10 +97,6 @@ static int occ_open(struct inode *inode, struct file *file)
 	file->private_data = client;
 	get_device(occ->dev);
 
-	/* We allocate a 1-page buffer, make sure it all fits */
-	BUILD_BUG_ON((OCC_CMD_DATA_BYTES + 3) > PAGE_SIZE);
-	BUILD_BUG_ON((OCC_RESP_DATA_BYTES + 7) > PAGE_SIZE);
-
 	return 0;
 }
 
@@ -176,7 +172,7 @@ static ssize_t occ_write(struct file *file, const char __user *buf,
 	}
 
 	/* Submit command; 4 bytes before the data and 2 bytes after */
-	rlen = PAGE_SIZE;
+	rlen = OCC_SRAM_BYTES;
 	rc = fsi_occ_submit(client->occ->dev, cmd, data_length + 6, cmd,
 			    &rlen);
 	if (rc)
@@ -200,7 +196,7 @@ static int occ_release(struct inode *inode, struct file *file)
 	struct occ_client *client = file->private_data;
 
 	put_device(client->occ->dev);
-	free_page((unsigned long)client->buffer);
+	kvfree(client->buffer);
 	kfree(client);
 
 	return 0;
-- 
2.51.0


