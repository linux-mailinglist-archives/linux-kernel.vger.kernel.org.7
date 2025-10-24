Return-Path: <linux-kernel+bounces-868735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19154C05FFE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 13:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB6CF1C22EF6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 11:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB460314D08;
	Fri, 24 Oct 2025 11:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nGpAI4lI"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4273126B2
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 11:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761304290; cv=none; b=CjlcStgHlE0sffNP/ndeJPTrbhsU5Mdb9uMSAxovcLhMfokRrj0pf8gHs6H9QbXGKshTsqYJhPpEy87Nv+GLdfE7CbSIZjAKBufmiFc8UAPXy2qQAVNCbGrZEEV5kBOyvCCsU667/0upb7j+1ABqMTUrcWNwX3lNKTAT85aeJzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761304290; c=relaxed/simple;
	bh=rFPhCY/ukX6a4h68qvCO7frethsQHcRKNBZhFGoQHTY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=negyaHtCm4Dr97GZN9JPrzTik8MFqx4s3k0tlc7VWv1asfsyamRTyg9JcbGEvnQZalO7WNuFt5zYsulwZsoJM6W4iz0BY0FZ7QoIb19vyv9nGL9aNQfBR8fcAE/226YA7d1ma9yGvswpVJvlK0P/V3wCkdA9qyJirZH1BKsoDDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nGpAI4lI; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59O6eIZo016484;
	Fri, 24 Oct 2025 11:06:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=dWQe5S
	gBSZKw/FVpvQxSwXcNW18bjrtIqGvxWNRuQpI=; b=nGpAI4lIpeztF9hVoP4sA4
	VVaUlLI+i4UZaHDacCcRblz1dvgRmmI8v65DICuPHm0m4OdQ/JFoWtRCEAbp3Hvv
	LFtHtZ27Q3Hy4w92Ppn/3+/obYh8Dk+C3WpSb3w32odFyqsTPdM1D4mlC2T0phYA
	bvckMEL0MqmXhcQymNzC/0g3bNcrXHooLSkAjR7C8lkfrFyJdoXehEe9pWy18uRa
	QFYwQIsPX2NKdhLVmVM3TI0njuNL4yzwjl1clzYDnawFSEvbh3ncRVBgzI89+1zg
	8U/44AuPT82MvDBGWFcDBbXT5RCt15C/rAAocZgnb6lsgJrWeHO+65YGpESrVrpA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31sex5s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Oct 2025 11:06:09 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59O9Vn4v032166;
	Fri, 24 Oct 2025 11:06:08 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vp7naped-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Oct 2025 11:06:08 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59OB64Dd28180842
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Oct 2025 11:06:04 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3DB1620043;
	Fri, 24 Oct 2025 11:06:04 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E90520040;
	Fri, 24 Oct 2025 11:06:04 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Oct 2025 11:06:04 +0000 (GMT)
From: Gerd Bayer <gbayer@linux.ibm.com>
Date: Fri, 24 Oct 2025 13:05:32 +0200
Subject: [PATCH v3 2/2] nvme-pci: Add debug message on fail to read CSTS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-nvme_probefail-v3-2-5386f905378b@linux.ibm.com>
References: <20251024-nvme_probefail-v3-0-5386f905378b@linux.ibm.com>
In-Reply-To: <20251024-nvme_probefail-v3-0-5386f905378b@linux.ibm.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Wilfred Mallawa <wilfred.mallawa@wdc.com>,
        John Garry <john.g.garry@oracle.com>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, Gerd Bayer <gbayer@linux.ibm.com>
X-Mailer: b4 0.14.2
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: O_OJ63j7a13bHnHitNQDMxdmib5S23j0
X-Proofpoint-GUID: O_OJ63j7a13bHnHitNQDMxdmib5S23j0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX//mJ/yW1/5sE
 rqvR72fxLOnouaUpZ5k7kKTcgM8sPlcIFwYhx9t/d36YuuM0M+ZNTBLG6owTK1uYygWOagLVAp3
 dkCWCwgMqAjGaPH2QEsYU74OYu57pY2QNnybkZ4Hriwo2jdPSpKbnbH52VRZVlxwToE0Y3lnsAh
 8JxIM348LVO7bhjrq8Xv0i+wCPCNbO2BLjphvikAUo1RfCX+ufpK1GLNv4Z6rP7N04bBxpMrU5l
 glYuTYJemxHVV3DQcYlNN/4YAgg5IzeNAzOHwJybbFgl2fiBAYtqFhz1MstkR5R1BiwCxZHqLGI
 JVZDo5f8QCOknTsHDeCaj3kIWQqevra898XEs6L84Z9VztAozsteirdqYo3EA+yaiGFoB1XLwqd
 Y4H8GE3AFfo4WaxgWeVX7ilNAx8KdA==
X-Authority-Analysis: v=2.4 cv=IJYPywvG c=1 sm=1 tr=0 ts=68fb5da1 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=JF9118EUAAAA:8 a=Ikd4Dj_1AAAA:8 a=VnNF1IyMAAAA:8 a=Gwek0BahB5A2Lshf9EwA:9
 a=QEXdDO2ut3YA:10 a=xVlTc564ipvMDusKsbsT:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_01,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022

Add a debug log spelling out that reading the CSTS register failed - to
distinguish this from other reasons for ENODEV.

Reviewed-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
---
 drivers/nvme/host/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 8c624960c9f67e0cc8409023de5e532d6ed9b3ac..15c12e6cba884a9bb5248f70d75490254014b9f9 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2906,6 +2906,7 @@ static int nvme_pci_enable(struct nvme_dev *dev)
 	pci_set_master(pdev);
 
 	if (readl(dev->bar + NVME_REG_CSTS) == -1) {
+		dev_dbg(dev->ctrl.device, "reading CSTS register failed\n");
 		result = -ENODEV;
 		goto disable;
 	}

-- 
2.48.1


