Return-Path: <linux-kernel+bounces-861225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1137FBF21DA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 17:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49B82188D5AE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 15:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B602676F4;
	Mon, 20 Oct 2025 15:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="L9xIGcs3"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E126264A97
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 15:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760974187; cv=none; b=R8ZerDsk21wdKy39413DZdY0XJ59LYIENtalfZzgbCfDxd/y0a81cAwNLyiJtuJPLIOZ3sufVgy4mc3daBqxR9AhamYDDA3BTj1RUEZQjsYirTVszRP7n0q4BlRMLzhqq7gxX2i+qFLwyCwYFHocbqyQPnz/X+n6XydzcaQm7Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760974187; c=relaxed/simple;
	bh=ExY4yzFBCVb9UlwD8j5eek4U55bdWqOS88hLDmbLaPo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EH7nrIYtESKJ+ojsmZ3VBoXHX5fcJfci1nsd7wNOV1jk/nDmRO2BY/ChUrq3tFsAYCpCgwGj6zwtb3jbyOFpkK/DbUcfo9uW4T/f0hrIVvecovNf8S9Cv2XFqMoywyyKn0dbcudL4oqhmA6p8y4mJfiF7sD+I2rxzR3bkEI+dwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=L9xIGcs3; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59KFIggr022111;
	Mon, 20 Oct 2025 15:29:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=pSEjYy
	sYWWk1LsD3k2FDaPqGqJOySS8AEodVfCUxJ9M=; b=L9xIGcs3aaTGHax3ymNMai
	ac5cR4j5QO12jDhXGgZtaPaAtLOaZv5FdA9eTT3poIbdYb6kJPY21zkKt/ySNLPW
	xjlW2ZWG8Z1D19qa1AG7j1H2mFQkzVhAtABm+Q2PIlWxPNG3LrTqB0OYUPGIVFvC
	KhZtkoB9hdE47vOCwpro4nsC6ZigsFVqI1xBlkExsJApPKRa/dqvadLF8m5FcyiA
	rGflTylusntwWMgT47k5JN/GAmT6+nXux7Sy6pu18oKsgdK/xZLQE6qCm4mKTJWA
	PyES6Mnab2We1G24QpEBqeZ/JavvRuDpXK0hA94c14HDSxO4BH4SIaFqdhXe4UQg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v30vh57t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Oct 2025 15:29:28 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59KDe8U2014658;
	Mon, 20 Oct 2025 15:29:28 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vn7rxjby-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Oct 2025 15:29:27 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59KFTO3N41550174
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Oct 2025 15:29:24 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5B2A620040;
	Mon, 20 Oct 2025 15:29:24 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 368772004B;
	Mon, 20 Oct 2025 15:29:24 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Oct 2025 15:29:24 +0000 (GMT)
From: Gerd Bayer <gbayer@linux.ibm.com>
Date: Mon, 20 Oct 2025 17:29:07 +0200
Subject: [PATCH 1/2] nvme-pci: Print error message on failure in nvme_probe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251020-nvme_probefail-v1-1-a420046d98f0@linux.ibm.com>
References: <20251020-nvme_probefail-v1-0-a420046d98f0@linux.ibm.com>
In-Reply-To: <20251020-nvme_probefail-v1-0-a420046d98f0@linux.ibm.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, Gerd Bayer <gbayer@linux.ibm.com>
X-Mailer: b4 0.14.2
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: QV0Lo_aqbuu3TJx3KLkVJAFe_NN75plv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX85EqlEsug4/c
 pSv9LOWErJV1G7aHSVurEVI4olnGULoP7T+UpKl0S9pbaTBvN2TYIIcLP6QeYMYfxudQ1i5fqlV
 dufQVHjMzxxT2r1E+sgKTHWTfRy/o1/lQ8WI2ZZQBCa6MHQg5eQB7ThcgFDBPZthV6cgWWwQzmE
 iOLMNgVsCcxP6/WvB3o0OGAnU3xM9fR4HHQJonsg3u6h6X4rXQSPO7izXIdp6yoI4TpfcwjPNLV
 GIGS3PylGXaz+SI87XawqxlMzf1/9apRt+ziYlW8l5MnXOEk/Wv/r5wGB+O+V3HqJnccZNi1wTg
 ruT4pkxwmiG8r0GA9uUsx435cSLhHAg97kl4QmCFyMPdB5qFoJjY+lFbUIWz5ihjEExMj2PbsGI
 hTU4yT7opxEo9OH2TtfZEKXnG9tJaQ==
X-Authority-Analysis: v=2.4 cv=MIJtWcZl c=1 sm=1 tr=0 ts=68f65558 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=53zO2tGsVP_itq-8s-4A:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: QV0Lo_aqbuu3TJx3KLkVJAFe_NN75plv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1011 impostorscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022

Add a new error message like
nvme nvme0: probe failed on 2004:00:00.0 (result: -19)
that makes failures to probe visible in the kernel log.

Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c916176bd9f058b49e6e6768675711df52b15765..7544c4bac2c4a230d32cf729abb9e94bf93a921f 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3519,6 +3519,8 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 out_dev_unmap:
 	nvme_dev_unmap(dev);
 out_uninit_ctrl:
+	dev_err(dev->ctrl.device, "probe failed on %s (result: %d)\n",
+		dev_name(&pdev->dev), result);
 	nvme_uninit_ctrl(&dev->ctrl);
 out_put_ctrl:
 	nvme_put_ctrl(&dev->ctrl);

-- 
2.48.1


