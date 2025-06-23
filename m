Return-Path: <linux-kernel+bounces-697576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5CE1AE35F2
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 08:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 768891891BC5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 06:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304301EDA02;
	Mon, 23 Jun 2025 06:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DTMs8oBy"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F461E0DE8;
	Mon, 23 Jun 2025 06:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750660892; cv=none; b=X96FaFvONTmnTcc85QsXK/LqXSPHAPWVr9xAAU5tPzHV0Gmd4gjMRZ67LQPesJn/oqeFWhoCjzCy+12GiCIshqPBhXAC5MBcBiNo4NVcesW1yv7Ip+CSRqX7h7vwcz+YzgzX6mP1QISiTYZu/snQ9gr21uuCeGoPKmHoy24VfIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750660892; c=relaxed/simple;
	bh=4dHbFjIOMcZ9BXMifHvs6v6a42mWLAyf99xloLz9V0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Deng+xK1TZ4awy7hgoZBKmvbWp7fU2hgCIYMcEFslFd3/k5vnAVqtyW4Uy9/yRjIXN6+UVq8zSx9o4DXwzb9nYxoU74uPJoD8qjC/ByuRdB/grH90F6AvgRhca59WA5Mbvaqy2Ng90hTkihy1jIiVHlOIxIRgfM3el2decVJuzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DTMs8oBy; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55N0SmjP031872;
	Mon, 23 Jun 2025 06:41:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=Lw+ns
	0UN9yZ99ex9boFZck+974RGTawmptRua0eAHf4=; b=DTMs8oBy6a0aYDSLmfEQZ
	YC56RiB64AunY+bfYoRpnc7iOR8IAfwtEWSrb5w76Ebi3EgYlczTu86WSG4bxChx
	j9alnxkPu2fStb28eiVBpDUvZtRxAue6qTT9596RwlabS1pzyOCp3t37c32jkzba
	5MzdTSSmPgoBevCY2Cs3H5ubB6A7SA17Wh4rk9XiAcieFDnYfwPFGdzaDVHH+PzM
	jlykxMuNUB98U3aqc7d/9An6GzuJYh1glzlavZrzMhlPTioU66RWaNbQWKpw6aBN
	U5En+ccRd8Fu+814J/L1doNH0rkA+9p3H/rVqsdqli7qbf0K3jHwSAOJMZcVVs5d
	g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ds7ut0gt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Jun 2025 06:41:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55N4kvFa031316;
	Mon, 23 Jun 2025 06:41:14 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ehpnfdvc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Jun 2025 06:41:14 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55N6fAk0006422;
	Mon, 23 Jun 2025 06:41:13 GMT
Received: from ca-dev110.us.oracle.com (ca-dev110.us.oracle.com [10.129.136.45])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 47ehpnfdt5-5;
	Mon, 23 Jun 2025 06:41:13 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: linux-nvme@lists.infradead.org, kbusch@kernel.org, axboe@kernel.dk,
        hch@lst.de, sagi@grimberg.me, kch@nvidia.com, nilay@linux.ibm.com,
        corbet@lwn.net
Cc: alok.a.tiwari@oracle.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] docs: nvme: fix grammar in nvme-pci-endpoint-target.rst
Date: Sun, 22 Jun 2025 23:40:23 -0700
Message-ID: <20250623064036.4187788-6-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250623064036.4187788-2-alok.a.tiwari@oracle.com>
References: <20250623064036.4187788-2-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-23_02,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506230038
X-Proofpoint-GUID: TAHSc3s3o15Aj2ZNvBDLwSRHkKnuUNQ5
X-Authority-Analysis: v=2.4 cv=CeII5Krl c=1 sm=1 tr=0 ts=6858f70a cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6IFa9wvqVegA:10 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=8xN46rftBpwEPShuBVEA:9 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19
X-Proofpoint-ORIG-GUID: TAHSc3s3o15Aj2ZNvBDLwSRHkKnuUNQ5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDAzOCBTYWx0ZWRfX5k9JVlx4Z3pY prgFut2o7uzyAD92M16HIhfDzuX479/LulCiGKqkZiZX/rsZwwYf/aA6+MvjnRlDy5P52gTDxcm HkvJrIGxsO4gmpe0tA/xLqjA1W69PNgJI4XpmYJn2c5Oxi+bW/VB1B8ALuhizrSzwAU0Oa5/Lz3
 XcXlLDGaD0gCA8RQcX764wyzo+2TPggMYhREPiwibeuYMzjQe39N3kvu+eDvvW4E4UzqPhgGoSt RqqJvKuSi5Mk0I8CafbRljfChOnICnovcALcoeU1OnwU+scJPnrZEwKvdMUQTNR6np7Vf96O7gY VyYDJ5TmpdMvWPnKWikiyCqOrU8arqIpP5UeXSbyHWj1xGqHuW9PSpdDxr+yBMEDF6CeQGQ4G3i
 DWrc66vQsTinC6gsB2ZwuTAE3m1bUBhrZghCU1wKwfadMP+GlngZxIk9vwxo2m93AZj8lOkO

Notable changes:
Use "an NVMe" instead of "a NVMe" throughout the document
Fix incorrect phrasing such as "will is discoverable" -> "is
discoverable"
Ensure consistent and proper article usage for clarity.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 Documentation/nvme/nvme-pci-endpoint-target.rst | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/nvme/nvme-pci-endpoint-target.rst b/Documentation/nvme/nvme-pci-endpoint-target.rst
index b699595d1762b..48f3b7f685945 100644
--- a/Documentation/nvme/nvme-pci-endpoint-target.rst
+++ b/Documentation/nvme/nvme-pci-endpoint-target.rst
@@ -6,20 +6,20 @@ NVMe PCI Endpoint Function Target
 
 :Author: Damien Le Moal <dlemoal@kernel.org>
 
-The NVMe PCI endpoint function target driver implements a NVMe PCIe controller
-using a NVMe fabrics target controller configured with the PCI transport type.
+The NVMe PCI endpoint function target driver implements an NVMe PCIe controller
+using an NVMe fabrics target controller configured with the PCI transport type.
 
 Overview
 ========
 
-The NVMe PCI endpoint function target driver allows exposing a NVMe target
+The NVMe PCI endpoint function target driver allows exposing an NVMe target
 controller over a PCIe link, thus implementing an NVMe PCIe device similar to a
 regular M.2 SSD. The target controller is created in the same manner as when
 using NVMe over fabrics: the controller represents the interface to an NVMe
 subsystem using a port. The port transfer type must be configured to be
 "pci". The subsystem can be configured to have namespaces backed by regular
 files or block devices, or can use NVMe passthrough to expose to the PCI host an
-existing physical NVMe device or a NVMe fabrics host controller (e.g. a NVMe TCP
+existing physical NVMe device or an NVMe fabrics host controller (e.g. a NVMe TCP
 host controller).
 
 The NVMe PCI endpoint function target driver relies as much as possible on the
@@ -181,10 +181,10 @@ Creating an NVMe endpoint device is a two step process. First, an NVMe target
 subsystem and port must be defined. Second, the NVMe PCI endpoint device must
 be setup and bound to the subsystem and port created.
 
-Creating a NVMe Subsystem and Port
+Creating an NVMe Subsystem and Port
 ----------------------------------
 
-Details about how to configure a NVMe target subsystem and port are outside the
+Details about how to configure an NVMe target subsystem and port are outside the
 scope of this document. The following only provides a simple example of a port
 and subsystem with a single namespace backed by a null_blk device.
 
@@ -234,7 +234,7 @@ Finally, create the target port and link it to the subsystem::
         # ln -s /sys/kernel/config/nvmet/subsystems/nvmepf.0.nqn \
                 /sys/kernel/config/nvmet/ports/1/subsystems/nvmepf.0.nqn
 
-Creating a NVMe PCI Endpoint Device
+Creating an NVMe PCI Endpoint Device
 -----------------------------------
 
 With the NVMe target subsystem and port ready for use, the NVMe PCI endpoint
@@ -303,7 +303,7 @@ device controller::
 
         nvmet_pci_epf nvmet_pci_epf.0: Enabling controller
 
-On the host side, the NVMe PCI endpoint function target device will is
+On the host side, the NVMe PCI endpoint function target device is
 discoverable as a PCI device, with the vendor ID and device ID as configured::
 
         # lspci -n
-- 
2.46.0


