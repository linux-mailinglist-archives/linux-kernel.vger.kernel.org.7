Return-Path: <linux-kernel+bounces-733380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C61B073E1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 12:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46FD050136A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 10:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799A32C3274;
	Wed, 16 Jul 2025 10:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HWZ4n1he"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39DB2E36F4
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 10:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752662849; cv=none; b=a9ukWXkemYx3zKzcchnai0T3rlJbdjhsHOCeCP7VDdBgZNv4yg04E7eppsXMTAztOUZj3YelJNHvrOo/880/8g9Wp3PxGjWSzuwiyZ8ZPuDnnXtrdpkunw/ArX7HyFDtczRoxeRVNJ1zbBS0y6aeprIdi3DLSJWFbCPHoOzQ3dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752662849; c=relaxed/simple;
	bh=pY0LYIeH1itQS/PhhR1ivcARsjEu/6MVsHH/LEeStt0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uOMHnowNHI7LxyAn04grWudUpFHyaxfMnBW6zJJchiamqLA5Jtyki7HhvKHyoBTOAhk5XEHjkegnzD6ii0WPe1RaUDT3g9PDaCa4hMrQNsZPUIWqWncKDZZkMoiOCQv1zFNfEX7mMGeQ4df6Dcd/kyvrg20ajYXPeY53aY4GRew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HWZ4n1he; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56G8Gi8U028287;
	Wed, 16 Jul 2025 10:46:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=gTLtMIRnm3xKdTc7YIn7pSNPhtbi
	xs4uEBIQM0PQafQ=; b=HWZ4n1heLluAYo3G48ZQGlm0hER4Ns3fGu/JhzthKmeN
	Fk5vgh6ZfXCEX1QnPXchebD3ElaRgL/OqmxNf/VL+3ihWPjHQdeK88hSLIqV5qQT
	5SQl/c/zCSJ3EkdqrB6vX73r+vfZocJlYfH8RMx7yYlic74sl+IsP3oNr0lsLpdY
	M56sZcr9XItLzWepGTOcNAViNmCWXraqWTTplNJJWVmBwznuXFnWOoA7fnCOIigu
	/f+jANhD7W3RZVsxL5tFr7hZqfTpobtBEFXJj1fdiqpqHdTMethhgFm80PRC5m0B
	qLVQBQPPyeJpcWmxwTe80ZewvDp8swMu0zNG30pjdA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47vamtyund-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Jul 2025 10:46:46 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56GAb9Nv029275;
	Wed, 16 Jul 2025 10:46:45 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47vamtyun8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Jul 2025 10:46:45 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56G85IN6032758;
	Wed, 16 Jul 2025 10:46:44 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 47v48m6qm7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Jul 2025 10:46:44 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56GAkfkM56033622
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Jul 2025 10:46:41 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0802520040;
	Wed, 16 Jul 2025 10:46:41 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9ACAF2004F;
	Wed, 16 Jul 2025 10:46:28 +0000 (GMT)
Received: from sapthagiri.in.ibm.com (unknown [9.124.218.71])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 16 Jul 2025 10:46:28 +0000 (GMT)
From: Srikar Dronamraju <srikar@linux.ibm.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Naveen N Rao <naveen@kernel.org>
Cc: Srikar Dronamraju <srikar@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
        Tyrel Datwyler <tyreld@linux.ibm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] pseries/lparcfg: Add resource group monitoring
Date: Wed, 16 Jul 2025 16:15:56 +0530
Message-ID: <20250716104600.59102-1-srikar@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SU0_NJGuHiCeTmK2NL1oRzJx4xm1-C_1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDA5NyBTYWx0ZWRfX4VqNS/585M8m g81yN2OLm+9NEUAKsakJQCVOayG7HLeVmfVEJBj96JA1j6VinKRULrftA/kqk/EGm/UIKipUaFR FVu2vEVG/N3ZW2XKCCHmrYPz+NPXBmDHglLX7a3OfHWqHmdRhZWIKK9OSgLN1uMhsY7Raswp6TY
 IzHPqDFp+01SQidxLuiAXSsAArgChT4U9GjWLAdaTyMrPvgwmWcvEFF79npJgpdgXOmnurpfkuh a3qMcVmJQRWgwChzRPHzLdEpXAB0rO0CbYhfVMHQY8FMmAS0ds4TKZVjfXX8L5qltFLwoBRYFMP 9LcyxXUZr0zxDZsclOjKQUERS9xzVXKHvxqidd6CeaH3GAAslS83wvADJGida/CQBWWtgpNtUGC
 TLTG1tTZ0C+jPXIAY39VoVCaubDltarJ1zTSwyNyM8VaO+WKmDVU0/u7jHlk8QSJVbqA37sb
X-Proofpoint-ORIG-GUID: TN-bvG1558SMrA6g5EhXibK3QgUoh9Iy
X-Authority-Analysis: v=2.4 cv=dNSmmPZb c=1 sm=1 tr=0 ts=68778316 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=1UX6Do5GAAAA:8 a=voM4FWlXAAAA:8 a=VwQbUJbxAAAA:8
 a=RM_-vzHYNNEx3VRC2tQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=Et2XPkok5AAZYJIKzHr1:22 a=IC2XNlieTeVoXbcui8wp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_01,2025-07-15_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 clxscore=1011 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0
 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507160097

Systems can now be partitioned into resource groups. By default all
systems will be part of default resource group. Once a resource group is
created, and resources allocated to the resource group, those resources
will be removed from the default resource group. If a LPAR moved to a
resource group, then it can only use resources in the resource group.

So maximum processors that can be allocated to a LPAR can be equal or
smaller than the resources in the resource group.

lparcfg can now exposes the resource group id to which this LPAR belongs
to. It also exposes the number of processors in the current resource
group. The default resource group id happens to be 0. These would be
documented in the upcoming PAPR update.

Example of an LPAR in a default resource group
root@ltcp11-lp3 $ grep resource_group /proc/powerpc/lparcfg
resource_group_number=0
resource_group_active_processors=50
root@ltcp11-lp3 $

Example of an LPAR in a non-default resource group
root@ltcp11-lp5 $ grep resource_group /proc/powerpc/lparcfg
resource_group_number=1
resource_group_active_processors=30
root@ltcp11-lp5 $

Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: "Thomas Weißschuh" <thomas.weissschuh@linutronix.de>
Cc: Tyrel Datwyler <tyreld@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Srikar Dronamraju <srikar@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/lparcfg.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/lparcfg.c b/arch/powerpc/platforms/pseries/lparcfg.c
index cc22924f159f..6554537984fb 100644
--- a/arch/powerpc/platforms/pseries/lparcfg.c
+++ b/arch/powerpc/platforms/pseries/lparcfg.c
@@ -78,6 +78,8 @@ struct hvcall_ppp_data {
 	u8	capped;
 	u8	weight;
 	u8	unallocated_weight;
+	u8      resource_group_index;
+	u16     active_procs_in_resource_group;
 	u16	active_procs_in_pool;
 	u16	active_system_procs;
 	u16	phys_platform_procs;
@@ -86,7 +88,7 @@ struct hvcall_ppp_data {
 };
 
 /*
- * H_GET_PPP hcall returns info in 4 parms.
+ * H_GET_PPP hcall returns info in 5 parms.
  *  entitled_capacity,unallocated_capacity,
  *  aggregation, resource_capability).
  *
@@ -94,11 +96,11 @@ struct hvcall_ppp_data {
  *  R5 = Unallocated Processor Capacity Percentage.
  *  R6 (AABBCCDDEEFFGGHH).
  *      XXXX - reserved (0)
- *          XXXX - reserved (0)
+ *          XXXX - Active Cores in Resource Group
  *              XXXX - Group Number
  *                  XXXX - Pool Number.
  *  R7 (IIJJKKLLMMNNOOPP).
- *      XX - reserved. (0)
+ *      XX - Resource group Number
  *        XX - bit 0-6 reserved (0).   bit 7 is Capped indicator.
  *          XX - variable processor Capacity Weight
  *            XX - Unallocated Variable Processor Capacity Weight.
@@ -120,9 +122,11 @@ static unsigned int h_get_ppp(struct hvcall_ppp_data *ppp_data)
 	ppp_data->entitlement = retbuf[0];
 	ppp_data->unallocated_entitlement = retbuf[1];
 
+	ppp_data->active_procs_in_resource_group = (retbuf[2] >> 4 * 8) & 0xffff;
 	ppp_data->group_num = (retbuf[2] >> 2 * 8) & 0xffff;
 	ppp_data->pool_num = retbuf[2] & 0xffff;
 
+	ppp_data->resource_group_index = (retbuf[3] >> 7 *  8) & 0xff;
 	ppp_data->capped = (retbuf[3] >> 6 * 8) & 0x01;
 	ppp_data->weight = (retbuf[3] >> 5 * 8) & 0xff;
 	ppp_data->unallocated_weight = (retbuf[3] >> 4 * 8) & 0xff;
@@ -236,6 +240,13 @@ static void parse_ppp_data(struct seq_file *m)
 	seq_printf(m, "unallocated_capacity=%lld\n",
 		   ppp_data.unallocated_entitlement);
 
+	if (ppp_data.active_procs_in_resource_group)  {
+		seq_printf(m, "resource_group_number=%d\n",
+				ppp_data.resource_group_index);
+		seq_printf(m, "resource_group_active_processors=%d\n",
+				ppp_data.active_procs_in_resource_group);
+	}
+
 	/* The last bits of information returned from h_get_ppp are only
 	 * valid if the ibm,partition-performance-parameters-level
 	 * property is >= 1.
-- 
2.43.0


