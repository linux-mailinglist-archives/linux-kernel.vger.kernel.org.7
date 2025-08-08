Return-Path: <linux-kernel+bounces-760009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88583B1E591
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 11:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AADC3A9606
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 09:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE3726CE3E;
	Fri,  8 Aug 2025 09:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="itt6dD8W"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A4F25A353
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 09:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754644984; cv=none; b=TyXf5LDOMRUQ2NWLMFbzvh95QY6fSgF7gai/f9/k0s7nM+aOKVXJC28AKkBlzzr/yp+nGft67DpbmncL+SpNsNdVJB3mljoCrSO23OOYIu0viDV+ZdHpGS04hPtP3YWH1QMeQCr6d2+bAOEajLIVHy8Fy5AsEWpPuTkXuxeYH9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754644984; c=relaxed/simple;
	bh=Ed6X04z5sLO+iFOvHnO72uLOYkuJLhdGCjH5cukTOjc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jiN7TEXDgFSMqaTM5G9XQ6sqD+fEmMpLPIvzLzoshdC2U8zIjcPHnOoXdmtB3hNCeEaHCLrFltctf53EDKeNa5D7Nx8oNcGEZtTPyiHHQ8szIqdEiQbCNdP5Qx0aMzEuATGCQ280oUmPPHX8gX/VX0UTNDA9/LX0nOSSxDu7A04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=itt6dD8W; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5786uOUr022560;
	Fri, 8 Aug 2025 09:22:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=rADHQ2onuJoaMUQ4Gf6jGp
	gSR531YEDNO1qihPw7vMk=; b=itt6dD8WfUk4+pl/jWNaWJ3hnIMz1M0TWHliyv
	j/Po7k1OiT6i+YXCMcjzaQqTj6yme9DKibQ1WjdDz4SnFDxsvzswmk2WPFI10StZ
	xlR558LatVB9ht6/vvSIOI2ImPlNWjeGXJS7Z/CimK2FBmIS7l388x3tjU+vvxD1
	87HvtXMzpdTBP8HiP039Cn7vh23GazL7Fw6gNveUynf7Saz0Mv5zxvk9YPh/inCv
	10W7rY1v3PR0NTjYbBvswYyurTiiFl5EVGe3pMReQes9iHFHjdxRdaT/QJYXjwVw
	71YNXGtG4dE/lhxAVsWbTEyBdIM5Tl0gpe/nxXYVxoXU11Cw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48cs5nbsmy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Aug 2025 09:22:41 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5789MeJV015029
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 8 Aug 2025 09:22:40 GMT
Received: from hu-charante-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 8 Aug 2025 02:22:37 -0700
From: Charan Teja Kalla <quic_charante@quicinc.com>
To: <akpm@linux-foundation.org>, <shikemeng@huaweicloud.com>,
        <kasong@tencent.com>, <nphamcs@gmail.com>, <bhe@redhat.com>,
        <baohua@kernel.org>, <chrisl@kernel.org>, <david@redhat.com>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Charan Teja Kalla
	<quic_charante@quicinc.com>
Subject: [PATCH] mm: swap: check for xa_zero_entry() on vma in swapoff path
Date: Fri, 8 Aug 2025 14:51:56 +0530
Message-ID: <20250808092156.1918973-1-quic_charante@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=Q+XS452a c=1 sm=1 tr=0 ts=6895c1e1 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=cHbpGygnT8J20diWkpEA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: RrDrs7NntZPuiiyarxSr-9jkJetaHlJU
X-Proofpoint-ORIG-GUID: RrDrs7NntZPuiiyarxSr-9jkJetaHlJU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA3MDA2OSBTYWx0ZWRfX6nl+HntHDx2g
 3tNKtu68JV+0+m2fuG9u+8CD2st9vk7aiNIaZP6v6fG/BTM2DNTVQoG/NOqVfcPOyBQwZnx+fOM
 x4DqHE86D7zqwfNxAdBkfPORrRU5ITECD7ACa6xIwnE3F4MVMLvKv4nwuEf/TmWTAKDs1vYi2PW
 Plj6foQJhBz39frsw7cQzS7qlnqn3yXbI//Tj2wuTFl/q2r3qxNVPabQUOYUsjGeYu1xKPIjBVa
 ykps7F+Ws7Lcfc0eQnWI8cNwNup9NTJurT3QyRhTsKSm9FGgeGCNZHin/tR70JdM/Pf8RObOLHX
 fjeaOwHn4F6WeH57MC43A8WEd/V0j7BwEgiFKPaGzbFG5ja1IpthKHWBwCliFITC5cXozOWZ6/V
 ls5/8+Nr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 impostorscore=0 phishscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508070069

It is possible to hit a zero entry while traversing the vmas in
unuse_mm(), called from the swapoff path. Not checking the zero entry
can result into operating on it as vma which leads into oops.

The issue is manifested from the below race between the fork() on a
process and swapoff:
fork(dup_mmap())			swapoff(unuse_mm)
---------------                         -----------------
1) Identical mtree is built using
   __mt_dup().

2) copy_pte_range()-->
	copy_nonpresent_pte():
       The dst mm is added into the
    mmlist to be visible to the
    swapoff operation.

3) Fatal signal is sent to the parent
process(which is the current during the
fork) thus skip the duplication of the
vmas and mark the vma range with
XA_ZERO_ENTRY as a marker for this process
that helps during exit_mmap().

				     4) swapoff is tried on the
					'mm' added to the 'mmlist' as
					part of the 2.

				     5) unuse_mm(), that iterates
					through the vma's of this 'mm'
					will hit the non-NULL zero entry
					and operating on this zero entry
					as a vma is resulting into the
					oops.

Crash reported:
--------------
Unable to handle kernel NULL pointer dereference at virtual address
0000000000000446--> Loading the memory from offset 0x40 on the
XA_ZERO_ENTRY as address.
Mem abort info:
  ESR = 0x0000000096000005
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x05: level 1 translation fault

 pc : try_to_unuse+0x188/0x79c
 lr : try_to_unuse+0x440/0x79c
 Call trace:
  try_to_unuse+0x188/0x79c
  __arm64_sys_swapoff+0x248/0x4d0
  invoke_syscall+0x58/0x10c
  el0_svc_common+0xa8/0xdc
  do_el0_svc+0x1c/0x28
  el0_svc+0x38/0x88
  el0t_64_sync_handler+0x70/0xbc
  el0t_64_sync+0x1a8/0x1ac

Fix this by checking if vma is zero entry before operating on it.

Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>
---
 mm/swapfile.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 68ce283e84be..91513830ef9c 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2245,6 +2245,12 @@ static int unuse_mm(struct mm_struct *mm, unsigned int type)
 
 	mmap_read_lock(mm);
 	for_each_vma(vmi, vma) {
+		/*
+		 * zero entries in mm_struct->mm_mt is a marker to stop
+		 * looking for vma's. see comment in exit_mmap().
+		 */
+		if (xa_is_zero(vma))
+			break;
 		if (vma->anon_vma && !is_vm_hugetlb_page(vma)) {
 			ret = unuse_vma(vma, type);
 			if (ret)
-- 
2.34.1


