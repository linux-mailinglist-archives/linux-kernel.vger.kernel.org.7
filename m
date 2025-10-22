Return-Path: <linux-kernel+bounces-864734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1682BFB6C1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 659BA189ABAC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F1531691F;
	Wed, 22 Oct 2025 10:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bpQn1S9v"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04183101A9
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 10:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761129251; cv=none; b=g5FHm7OfYYO3BlUak98eRJWizAksdjA+gvw8kBrq+iQjSplgwr3ZuhO3fDR6IqPMmMjznXfs0xhWWilYLHdw3KmB1Uz/0Qbt3zyvDFhH2bnt1sXL/tlOf1fgnh48lEBiPlPc8GiDuhAZrhBLa101VM8XOwHtYureUYUC0ZlZSwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761129251; c=relaxed/simple;
	bh=yYE5CNERKTz2FywTSc6GGp1KpbjkuY9QxAIOCQajP9o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j4O7sCUQJw2+BJsUKxOfGicNYGZaHeQxSofTJq+NbeFU/iEzq3gcozpCN7tOYNGDS3Piz131fPBsbrfNJq1CRIxMNmdgsk1Ffg9Ca1U0xeYq6z4ZsG5E6fx+UHtebyfL+RU68GDua4r5yEIr3RK/m/b5Mz6SyUXVIWqrSLp331o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bpQn1S9v; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59M8SFDn017546;
	Wed, 22 Oct 2025 10:33:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Od97J/
	A15Ke/ThZ/3Q1QlICKHrvcNbuW3doNnpcz9GI=; b=bpQn1S9vbWPFlpJb1Qgy9y
	J7jQ/VbaxCSNF00EMNGpSYQm/mULhKLzoMttdc+hTCnQ38S0QD2GFKtB7ikTfOzE
	fv0rQA96A7oNAanUUDeArv9wxOYh6ROQPaiWmUwhUh9DmIRd7YuMLfRfHXCGEXJf
	eTlUxloe3qvP17MrNoRWftnoRNnSJIIgTBZeONWWjSNK3owqtxbefPv+NCRxxonh
	QVXsnDGPu8o+feKL2iZ4820jnKs8LeYI7tRD8PnKnxJ7MNiM+PCj+ClNpf2wXE5m
	EWf0XhlHFpxtnEVfou6wgCKJbw5t41QTt8rnPngqU3WSR5X+PBgXvvYZW+TWvLNg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v33fc5wq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 10:33:49 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59M7kSRH002324;
	Wed, 22 Oct 2025 10:33:48 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vqejfjp0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 10:33:48 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59MAXjMF42729728
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Oct 2025 10:33:45 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 15AD3200A4;
	Wed, 22 Oct 2025 10:33:45 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E8E67200A6;
	Wed, 22 Oct 2025 10:33:44 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Oct 2025 10:33:44 +0000 (GMT)
From: Gerd Bayer <gbayer@linux.ibm.com>
Date: Wed, 22 Oct 2025 12:33:16 +0200
Subject: [PATCH v2 1/2] nvme-pci: Print error message on failure in
 nvme_probe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-nvme_probefail-v2-1-26bbdf94280e@linux.ibm.com>
References: <20251022-nvme_probefail-v2-0-26bbdf94280e@linux.ibm.com>
In-Reply-To: <20251022-nvme_probefail-v2-0-26bbdf94280e@linux.ibm.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chaitanya Kulkarni <kchk@nvidia.com>,
        Wilfred Mallawa <wilfred.mallawa@wdc.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Gerd Bayer <gbayer@linux.ibm.com>
X-Mailer: b4 0.14.2
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FMYWBuos c=1 sm=1 tr=0 ts=68f8b30d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=GWyhmD5H9okkrlSlx5YA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: ZA--MZ6P12ewBNGmzYdtBs95u6_HQSbB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX/iRSg8XHU5U5
 V5Y+Q587IR5DLtKB/WoKVQT2ZTkBj1vh0tOwY5WrCc6QU0J935RuxKemRgWrY4c9G22THB7jniN
 4dnvs1Jzy4TvdnSyvm1Ci8gOgadut6mmBmvj6Mie1G9ctxxfatS5wkhxIq5sAc6k/IXupbf09F+
 WJFKih2XvgxD2QJh0B1/CKTd3PvUHUQ/2O2Mp8FkPmfA+xXK+HdHBT0nuYe6DaEyGUYlLGJsbAe
 qBLXpfvqm7fLnUj/aCcq5iyuQNJQtyLN6SsOuk05DoPPazbjjy5WbN1hBGIcICOrYJ6uv1Kh7og
 vYaSLI7ACwdrld9LU0jkcpMqblQYp+6+Ncwy4HbGLUCfw85n4DPXjNOivP72I6XKeGE1NRF1xR/
 dyJLLHhiiukhSv1XFSTlgg5OU3Pf4Q==
X-Proofpoint-ORIG-GUID: ZA--MZ6P12ewBNGmzYdtBs95u6_HQSbB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022

Add a new error message that makes failures to probe visible in the
kernel log, like:
nvme 0008:00:00.0: error -ENODEV: probe failed

This highlights issues with a particular device right away instead of
leaving users to search for missing drives.

Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
---
 drivers/nvme/host/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c916176bd9f058b49e6e6768675711df52b15765..8c624960c9f67e0cc8409023de5e532d6ed9b3ac 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3522,6 +3522,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	nvme_uninit_ctrl(&dev->ctrl);
 out_put_ctrl:
 	nvme_put_ctrl(&dev->ctrl);
+	dev_err_probe(&pdev->dev, result, "probe failed\n");
 	return result;
 }
 

-- 
2.48.1


