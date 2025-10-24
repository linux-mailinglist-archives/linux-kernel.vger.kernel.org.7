Return-Path: <linux-kernel+bounces-868731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C173C05EF1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 13:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E916F344272
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 11:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA9331A055;
	Fri, 24 Oct 2025 11:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YBqc7QCw"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B5323C50F
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 11:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761303988; cv=none; b=IJTdqHNE/9BiM9Y6CH513fU0PRhxqymJ1F72Xm7MOS01ro5C2mc4pxJRegTHTcyoBk0ztMt+7VpnlH180QFpNoqcS6WopaMipkH+CwEYinUgQQwbY+bqczRaQ01qK1BvbG49z6a6tB3YJlwOn2jluCHicaX5ArFTLEn3l7OFeB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761303988; c=relaxed/simple;
	bh=iA+ZOuVyeS1NWvvYtS6oSqbX7Ifv3weo7mBB0kP16r4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=drQCDyP1vcK4AAaDBg3HthL568trM5xnP7glJzY9h3VnhS+1tJm8uzLdP4sXeseqiCsrpRAWbSiW7wwvWYYZ2FItUibU6LHYKbByXN6ONbBrNHDEpqENKOffo4gtLR2FYxSCsknxXsAUnpMagzcTb2E9R6ovcJdDpc2WnsaM/wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YBqc7QCw; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59NKABxU017956;
	Fri, 24 Oct 2025 11:06:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=62ZZuM
	IVEcT23AMveUzBFI4vn/NnpbNP1HCzXrArEq4=; b=YBqc7QCwpq7mOhPxRvaGqN
	mPn5CLuWLVzL8TTZjYjNOIjfMCvAJWgGMrN6K80vpWGcCn/6AukLISfXqpOMXSMu
	U68Of5RHXxlsmddVWxtBPzMmw8XPSSG5Z+GENujBUkFEtazC69CtuPYhiG4edpXW
	nDNaJ2Gdzh7+RKzudkQSybBd5mJ/KHru8t1+EgCyrAAcwNqUKqo1mCHp3j4HjCOA
	HHP9IX7+upBwhmVqgLpyEP9YxxNUU5fKgbt2C/1272i1mZO2PoNwWg3wCfl03zpR
	eLzO9M44AYfgtRTM40zizG/h0j3HJyOAy0UpCjvocvZpgTP1Gmv8NFkWIRNmvpvg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31sex5r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Oct 2025 11:06:09 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59O9TFIu024303;
	Fri, 24 Oct 2025 11:06:08 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vpqkand6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Oct 2025 11:06:07 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59OB64j228180838
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Oct 2025 11:06:04 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 09AE52004B;
	Fri, 24 Oct 2025 11:06:04 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CCE5A2004E;
	Fri, 24 Oct 2025 11:06:03 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Oct 2025 11:06:03 +0000 (GMT)
From: Gerd Bayer <gbayer@linux.ibm.com>
Date: Fri, 24 Oct 2025 13:05:31 +0200
Subject: [PATCH v3 1/2] nvme-pci: Print error message on failure in
 nvme_probe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-nvme_probefail-v3-1-5386f905378b@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: tf749bEYkwCIIOD-VHiQeGhjr2Gcb92X
X-Proofpoint-GUID: tf749bEYkwCIIOD-VHiQeGhjr2Gcb92X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX9VLfkZ/J8HUz
 hgiaqBByLIPKTFjtEsL3CRSOL8AEF5uEGjDLmKsqsTdwoa4DOxRKlrfjy67xQQkiDKrinWFf9v3
 Lu/EQ7E7rXeKzzxUvgIN4uU6svUh2PdRFRLhlwYx4wgIhiVNatvVLGkZng31EOrOdz0RWySe3ly
 mrUXf81TAbOZHAEJWHDNW/vMjDBGqjXFa1fHGY9LtJC5KSEGXjuLeZ1qZjcyYpPSWeFOpPxrIjh
 haBYpGJjrJKDNk6M2/mEgSB9naEGMD5yCqv1ETo0QjtIFUpxEnh+cn0Io636iKlVP1iOxL8XmiT
 nVAtLs/MtR0WIoZDuoPcT5mgs7V4EdsM9L0fH53iSAZvbsnr45uSbaNNGbDuEX7ukLzBpdn1mqc
 gu/QzWp0wibX1VrSQ1/a8TjCfEEcOQ==
X-Authority-Analysis: v=2.4 cv=IJYPywvG c=1 sm=1 tr=0 ts=68fb5da1 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=GWyhmD5H9okkrlSlx5YA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_01,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022

Add a new error message that makes failures to probe visible in the
kernel log, like:
nvme 0008:00:00.0: error -ENODEV: probe failed

This highlights issues with a particular device right away instead of
leaving users to search for missing drives.

Reviewed-by: Christoph Hellwig <hch@lst.de>
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


