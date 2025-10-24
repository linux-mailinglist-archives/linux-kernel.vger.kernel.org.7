Return-Path: <linux-kernel+bounces-868730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A04C0602E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 13:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2C0D3B66A5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 11:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD4B3148C4;
	Fri, 24 Oct 2025 11:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Swhj3Ppo"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221183148B8
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 11:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761303987; cv=none; b=EL+Ryeh5YFHk91YqXCqPraRUNbet+KRg/vrNt/dvsweIpjCigEUNR2S1M/hriEJPpRGz7bIeVtZpgk6SlhYo0VqqV9YtbPCQJofmDzXP9bRyY4BSXDkdFbEjR26JAPgllAOkcGrbYSYENXEKKWQ+K5v6jG/33GFw22n8b4AYyKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761303987; c=relaxed/simple;
	bh=Ct3RskfS9yGio0szwRQlmSe/vn07IcVq84eKpJj1W7c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RoaRZwlAKJZB/Yokonb/iwVM4ZQ5KCORCWY4nPTjnRQNuX6JqMOWedt2/OePMGqdPq7MsxDznmbzX3mDNWVe3/hrslsw5wDXLeLGi6qHWaVZflLp93vH/TOI+Rox4VQLWH81kwDyiyDYR//vJ3BinBddBcMnxzr7Nv0zhrBpfT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Swhj3Ppo; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59NJxlxn004702;
	Fri, 24 Oct 2025 11:06:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=UeCuEQVHAnAaIsPQ3B/TgqZ/BFog
	CSgrx+enGmZQux4=; b=Swhj3PpoFveI1UPHj3szZVeLnPNi4tSkVtowA9UoW+45
	9qQeaMvgS81g7EndxMUtS3ewQtNvc/kz6eR5JBPwCgfyWuBIsQwuNRrS6ycTHIUm
	mhbPk4ZxSMtAKdOMDnxv4w/j9KPLm5VPZYPlkZpugLeO9L3DsaAi3Y6lDulmf6t9
	tQui9mg2r1SgQB3YXtf/3TrbqoyLRIwzneTaFIks2Z4gycoR3spxz8J/9PdJj43b
	i7o9S6s7EE/HZg1kL5v9X9i9sMLCOfAVPt9sGy7taWEYdn72d+KgGfDFo1ce+tqe
	NPwxshHxcnyp54rak7q18fyKkgOWsEM2bTAEmlkflQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31cnfaw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Oct 2025 11:06:08 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59O9fnNF032142;
	Fri, 24 Oct 2025 11:06:08 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vp7napec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Oct 2025 11:06:07 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59OB63Wb61800846
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Oct 2025 11:06:03 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C76852004B;
	Fri, 24 Oct 2025 11:06:03 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 94EE920043;
	Fri, 24 Oct 2025 11:06:03 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Oct 2025 11:06:03 +0000 (GMT)
From: Gerd Bayer <gbayer@linux.ibm.com>
Subject: [PATCH v3 0/2] nvme-pci: Log failures to probe
Date: Fri, 24 Oct 2025 13:05:30 +0200
Message-Id: <20251024-nvme_probefail-v3-0-5386f905378b@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHpd+2gC/2XMSwqDMBSF4a1Ixo3cXOOro+6jlGI0qRd8kbTBI
 u69UToodvgfON/CnLakHTtHC7Pak6NxCJGcIla31fDQnJrQDAFTASLlg+/1fbKj0qaijidlngm
 ESuaiZOE0WW1o3sHrLXRL7jna9+57sa1fCuFIecGBVxIBZNaUhYFLR8Nrjkn1cT32bOM8/hL4R
 2AgMFOqMaXEAvSRWNf1AxBbg+HzAAAA
X-Change-ID: 20251015-nvme_probefail-3976120a4719
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
X-Proofpoint-ORIG-GUID: V8HgxT0Kmk0Hnieurcz85xjnnblC4AIi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX/IIEL0z107Lw
 uDogcYas4xbgo1p5Xw1zS+47Gt2AV3AE/ELgJ4K0Chyk3+ZK7kxK/mkPiyzk3rJm3yScdZgFceA
 bEeC0OzRS44z27+7FqnsIdBKVrwAbisRIexhBvFPvbuMkLxB3UkQBlonQxwwdUSGmOKzkYIX09V
 VdnTxCo4P4OF8IkFaQLkXP8i82Xu1PON5oXLfz/Ixg3AmG+Eim+6reGckMeyh27xabFxgX7IZqw
 PSKK6P0oZqqT0elA3nj5ReHNd1vQuY4/PaSl6oSB+6qW7pnQfbKH+KIE4yaUjXm5mHGA5WT8OGt
 x5dHWXVBvypKZgoEId4VEFTXvAqddqTR+H4EMJLcqYyHaxhkmpA4mZvYkhbRiOneGG4OsemGT1L
 BWMyupcNb7Ztyt4gMYszxsUKDs/5Kw==
X-Proofpoint-GUID: V8HgxT0Kmk0Hnieurcz85xjnnblC4AIi
X-Authority-Analysis: v=2.4 cv=SKNPlevH c=1 sm=1 tr=0 ts=68fb5da0 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=4PydOPZSPFsZ0nwRxBgA:9 a=QEXdDO2ut3YA:10
 a=HhbK4dLum7pmb74im6QT:22 a=cPQSjfK2_nFv0Q5t_7PE:22 a=pHzHmUro8NiASowvMSCR:22
 a=Ew2E2A-JSTLzCXPT_086:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_01,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
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
Changes in v3:
- Both patches: Added Christop Helwig's R-b's
- Patch 2/2: add newline (per John Garry)
- Link to v2: https://lore.kernel.org/r/20251022-nvme_probefail-v2-0-26bbdf94280e@linux.ibm.com

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


