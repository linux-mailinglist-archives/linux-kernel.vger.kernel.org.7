Return-Path: <linux-kernel+bounces-864732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50486BFB6B8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AC9F483211
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB07527465C;
	Wed, 22 Oct 2025 10:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YBqaHqze"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CDE221DB5
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 10:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761129238; cv=none; b=JvenqTHF+0/kl2sV5uJLUKD6yZ+ZipFSgLe1KdeYL25NLYb2lcfeZnkVo9BZGOjX/ubuNrpNfZ9gRg3EK/Jfx7AgTBXjqiv922rV92UZUsyuo09uLJxnFTHYzX4C0HECDhuLvyYQarHUEKP5vy4+zOSMb6BFxcPOIP5jETu0PMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761129238; c=relaxed/simple;
	bh=dVsRbhfWk3HMNkr5PxHBqwMkA5dGrV/G+aybdOOnnlw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nyoAQfcd2kjcMOsmcmwaBOtAQCN+vdZKFox9ui8PcShyKg9cwudRsPiAezKY4rBYJcuKCMKVvvJxr8WtwoalV+ScYDYFcf21MQWHbwEwjypgTBrif11sANaRMnClL3pNWLKOJm+XC5/pgLIMpJfpBcoCYGy6K8Gmh79lDpY3cB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YBqaHqze; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59M7K1XC015478;
	Wed, 22 Oct 2025 10:33:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=rHDAq7dDwZ+LAzabqu2cFSHYZVRI
	WSdOvOsOVaMRZfU=; b=YBqaHqzezIFBkL8OW12F6eJHaNCV6Pveyl5eyeO1laj8
	Kw2BPWGLqABR/k9MQxR0bu9MFKld+/3xsrBSKFVCeuqAmLRNO0oQCiLwz4ev8KI4
	Lp5sKEHCr4dID2uZpP992TMyZCbl7JZD/hvI+Rj0PP4S+Uey8otQz2gjd6XcBAtS
	XinXIFW8p/HTX0u5WknUlu8CVgfH4X9nAIVAY2d0RT1cwcbDzUh0Fgx5u5lj4DxW
	QceXvcixiHZaKqbuzC/nHSG+ZO4S/fDtmCIpP0Ew/5xvM7MdNRA9vGsZcZOTC9E/
	KX5IVsyoZWHSYMTt/CiuaWnG1Y3Rqa16wWX1q5akWA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v30vtqgk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 10:33:47 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59M9XRZ0014663;
	Wed, 22 Oct 2025 10:33:46 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vn7s7ydy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 10:33:46 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59MAXjjf58458470
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Oct 2025 10:33:45 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E5E7B200A5;
	Wed, 22 Oct 2025 10:33:44 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C0A9B200A4;
	Wed, 22 Oct 2025 10:33:44 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Oct 2025 10:33:44 +0000 (GMT)
From: Gerd Bayer <gbayer@linux.ibm.com>
Subject: [PATCH v2 0/2] nvme-pci: Log failures to probe
Date: Wed, 22 Oct 2025 12:33:15 +0200
Message-Id: <20251022-nvme_probefail-v2-0-26bbdf94280e@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOuy+GgC/13Myw6CMBCF4Vchs7ZkWrkIK9/DEFNgkEmgJa02G
 MK7W4krl/9JzreBJ8fkoU42cBTYszUx1CmBbtTmQYL72KBQ5RJlLkyY6b4429KgeRLnqiykQp2
 VsoJ4WhwNvB7grYk9sn9a9z78IL/rj1L4TwUpUOhMIWZFX10GvE5sXmvK7Zx2doZm3/cPOnItD
 7AAAAA=
X-Change-ID: 20251015-nvme_probefail-3976120a4719
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chaitanya Kulkarni <kchk@nvidia.com>,
        Wilfred Mallawa <wilfred.mallawa@wdc.com>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Gerd Bayer <gbayer@linux.ibm.com>, Chaitanya Kulkarni <kch@nvidia.com>
X-Mailer: b4 0.14.2
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LhNL_wz_EbG7119_-nPbLDT_CZCp4qzV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX2prggI4Yh86S
 rg+zlIYcowWSPKMRB05OGjaHVqrOXjGw9rOlDw493gAaE5QRSDZsHPDrM1HH1zwMgzUTymo/kBq
 ccScn/2DFkYFg4WzeB1ha+/0mpFjWNCZAH3wfFe1Q+3sADJ+9HXSoS13Ueqro1nkIHCS2VYz8ex
 W48cZXM/99Y1DqEaYu1RdbDE3UReF3HPwSBk/u22F+KUSZkAuQ66umQ1L8zKJIcbtwbiO4HMsaO
 yMmy+QGnCSgk4JhYA43G73xb4Edx01PXLJupXFEp1LKH/dgR3uirLNzU3vRzR6ICcEyxFvoz9Il
 +K7c/a7hhqDMWdxwV/3f8qm4FzeW4OvfvOxKpCwFjMQ5FJ4pTqaUhIxCi3vHp8x7vXN6gEtq0ij
 GQNehe0kcwGGtYHEvxoA6XyShS35pQ==
X-Authority-Analysis: v=2.4 cv=MIJtWcZl c=1 sm=1 tr=0 ts=68f8b30b cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=4PydOPZSPFsZ0nwRxBgA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22 a=HhbK4dLum7pmb74im6QT:22 a=pHzHmUro8NiASowvMSCR:22
 a=Ew2E2A-JSTLzCXPT_086:22
X-Proofpoint-ORIG-GUID: LhNL_wz_EbG7119_-nPbLDT_CZCp4qzV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1011 impostorscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022

Hi,

occasionally, an NVMe drive fails to reply to MMIO reads despite the PCI
link being operational. In these situations (obviously not on the
boot-device :) it is preferred to have this reported in the kernel log
instead of deducing that something is wrong by comparing expectated vs.
observed number of nvme devices.

 - 1/2 adds a clear indication that the device driver failed to probe an
   NVMe drive and will not register a nvme device.
 - 2/2 adds a debug log that allows to further zoom in on the exact
   failure

I've split this into two patches, since 2/2 might be less important wrt
to back-ports, etc.

Thanks,
Gerd

Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
---
Changes in v2:
- Patch 1/2:
  - Replace dev_err() with dev_err_probe(), now last before return
  - Drop R-b from Wilfred Mallawa
- Patch 2/2: Reword as suggested by Christoph Hellwig, pick up R-b's
- Link to v1: https://lore.kernel.org/r/20251020-nvme_probefail-v1-0-a420046d98f0@linux.ibm.com

---
Gerd Bayer (2):
      nvme-pci: Print error message on failure in nvme_probe
      nvme-pci: Add debug message on fail to read CSTS

 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)
---
base-commit: 211ddde0823f1442e4ad052a2f30f050145ccada
change-id: 20251015-nvme_probefail-3976120a4719

Best regards,
-- 
Gerd Bayer <gbayer@linux.ibm.com>


