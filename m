Return-Path: <linux-kernel+bounces-861224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 97684BF2204
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 17:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8C5DF4F8A0A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 15:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1E7266B52;
	Mon, 20 Oct 2025 15:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Zqmj8Arv"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC04264A92
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 15:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760974187; cv=none; b=eXw3LaixYwV+mYkD5O8AnWmUC67PnK5rZ48wXYuazIVYqGm4BABb47H0RAYmwKXsX6E1Eqa0y1WrA4zrHoGHGOZ415PcGVlridKHe6gj5BpIBYEwEjOzfrGalyOi2DYVdfNt21kouo2ev8aZg7ytMLM1xQlyedLid9vhNnhkOIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760974187; c=relaxed/simple;
	bh=G9eA+Cwy/jEvBPp8mx09wja5/gMPdT65MVo5rYxfcIc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cIlPhsh15s7lsnSYQkl9Zrr+G+i6vi3pRGCK3wxMrKPhulUuYwmHRqvm91xCiKg3Bstpbem7y6Dy5DY/xs3scwdjq7SsT3gjl7ggEFHT5xN22CuQT6n4bCcNhlM4ondWhwzoHDK/SlGvGxgXsf7RYPuewROac7yf85sbW8FqNmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Zqmj8Arv; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59KCRb1V023459;
	Mon, 20 Oct 2025 15:29:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=kZjdwl
	7FnEi2lU6bCDHKVt6bQ30THwLTs+JaHvcqT0s=; b=Zqmj8ArvkCMFSl10VgFpBZ
	PrXDfYx3gKblkJHqCdMOYPXClpXegB0ma6xZ8ZGqJvkQEIhHppw2DGCajhXMupjP
	7vsf0RnRbdbdFAMprjzCpfn6TMBY9FEVTsFMPv/C+LLJluEna30NoHBY5uSl06Xs
	l0yOur4dHCbJQa7tzpiKgnrALOBbSW3Bq1IVYViG7L3yA6hKzO0VXUjGV8XJM9eY
	WsrsJSwFmuoU9B2gzW4qfdiA0JIeWW1Ml4ykqijy3Hj+GPbpC19IiE9J1s9Odr2o
	DiPCRnn8gmqTjEd2hzk09Y1wBxWkm3vVaLXpdqg0r/8yKNkd7KZs+TJn4BXVuHlg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31rt925-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Oct 2025 15:29:29 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59KEJJWI017066;
	Mon, 20 Oct 2025 15:29:28 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vnkxpemb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Oct 2025 15:29:28 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59KFTOFZ51577090
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Oct 2025 15:29:24 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 83F0620040;
	Mon, 20 Oct 2025 15:29:24 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 602F420043;
	Mon, 20 Oct 2025 15:29:24 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Oct 2025 15:29:24 +0000 (GMT)
From: Gerd Bayer <gbayer@linux.ibm.com>
Date: Mon, 20 Oct 2025 17:29:08 +0200
Subject: [PATCH 2/2] nvme-pci: Add debug message on fail to read CSTS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251020-nvme_probefail-v1-2-a420046d98f0@linux.ibm.com>
References: <20251020-nvme_probefail-v1-0-a420046d98f0@linux.ibm.com>
In-Reply-To: <20251020-nvme_probefail-v1-0-a420046d98f0@linux.ibm.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, Gerd Bayer <gbayer@linux.ibm.com>
X-Mailer: b4 0.14.2
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CKnkR60__oQPb3_NoV8ArCyH0KmX-7tT
X-Proofpoint-GUID: CKnkR60__oQPb3_NoV8ArCyH0KmX-7tT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX68Eo7iBx4JUL
 mNLBpM1iRy0P9SFa/kbvpWFTPQ+TA66WwTcGg8Enfu0NxUCv1tHlM3zNnGiRAT8eagT+oWIHA0j
 nnRI0HH+R2ucqBt8jWGxny6J8pm/BrGrXUL3WWCGus5mRpi3UPdfq6u5bvnmZfyH4jh6OJ7QkaC
 29NrIYpUMY2eWUZj7oFFO8T4FEsoLigyeaxa8+cXCakWKwSVw5ecWoa+J/KTmbV1f2BKIJWmdDW
 F7z9aMh2fYMMztXGRlimjypdsp91UZdXfVNsvgTpES0AyCZufg4N757WFQMYuX8vF/bRG7zVzTM
 BL7IoFhc6V8+lfYFNM+o1/uBqRL/uw7yB9Hx3E8KhHQRfl5V5JHgQgpu4MYrtUy4lwl3U2Z2Bcj
 kCQZCrk6aAtesR9Z8ZfTXnOVXVAc8g==
X-Authority-Analysis: v=2.4 cv=IJYPywvG c=1 sm=1 tr=0 ts=68f65559 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=Gwek0BahB5A2Lshf9EwA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1011 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022

Add a debug log spelling out that reading the CSTS register failed - to
distinguish this from other reasons for ENODEV.

Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
---
 drivers/nvme/host/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 7544c4bac2c4a230d32cf729abb9e94bf93a921f..c3b0a9d56ac1f32f67ce0890becd6425eb80ebad 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2906,6 +2906,7 @@ static int nvme_pci_enable(struct nvme_dev *dev)
 	pci_set_master(pdev);
 
 	if (readl(dev->bar + NVME_REG_CSTS) == -1) {
+		dev_dbg(dev->ctrl.device, "Read CSTS register failed");
 		result = -ENODEV;
 		goto disable;
 	}

-- 
2.48.1


