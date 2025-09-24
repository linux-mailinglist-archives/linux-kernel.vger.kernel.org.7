Return-Path: <linux-kernel+bounces-831067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 881F3B9B6FD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 20:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1A8C3A2ACF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 18:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3E731B10D;
	Wed, 24 Sep 2025 18:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AjTofCm9"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1208E313290
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 18:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758737573; cv=none; b=Ek/ziEhyijT/13ygaHEOGCz7P/5EWgeg2IylxBman8lVn+LQPelyzv96Z4HBFlcRZ0S5j+e4h9v/eL/lutpAC5WSJAH6/dwdqzGfGyZW1inrOB0znpp6/ok4WhuPx1GTcE2cIS70YB59Q2U5TGBol9zKoYKOIguEdxSaYV0sFPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758737573; c=relaxed/simple;
	bh=r7JBx7NbfSAWh8QaUwLW3X1jDzaLu1nv6fx5qrzbnzY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XjBrcLbUdd1GdVNUfC0fm/zhVQHzoHNsiVpPtGMTgljUt8rvNjO8/OR5y+oDKMkusgsKbmgnmR5pAcfdjDKMPd4i5qPmSK/HUtMmytGKW52H3da5KNqvh+puBz71xgGTnQv9G6kVVSA63ENIKRis6yesg7utDlHQ3A0lxFFmXCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AjTofCm9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OCGQbE016438;
	Wed, 24 Sep 2025 18:12:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=O4omulLn5ZHPtQYuvLDXZ8azyeT5lmg6t82
	8yfUSfUI=; b=AjTofCm9BD6MIJMh5eDp0Y84ZOJ90EQV59K+Lfzp1xhAzYw+NHw
	pNnKC9xfE31tSM7PATWD/w4CSN6eufXg9N/HnRtb/hrbNUBTF70whL9N2oU7GDzk
	jMXvn6F54JDjc1n2THvOse7SQMjkQMTac82CEa4A0mKW+poX0aYqyDvRyZKl+6Ni
	5kd2bs8dl1JmwzSn1QOIVrX8dctRhUPsECwVErI4YC/b8+ykygSJLTYaFr3IjdHj
	3wDyY90Z1FAzKA+PygQhKnahk1/Nvr9Xh81SfundLL2mwluGXxYfsdYflWBN79eU
	XkytPJTruEj9bRGTaoyLRoUFoZWVVym3BHw==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49b3nyh64j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Sep 2025 18:12:10 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 58OIC5bY011808;
	Wed, 24 Sep 2025 18:12:05 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 499nbm3xxj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Sep 2025 18:12:05 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58OIC544011802;
	Wed, 24 Sep 2025 18:12:05 GMT
Received: from hu-devc-hyd-u22-c.qualcomm.com (hu-charante-hyd.qualcomm.com [10.213.97.134])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 58OIC4P1011797
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Sep 2025 18:12:05 +0000
Received: by hu-devc-hyd-u22-c.qualcomm.com (Postfix, from userid 389980)
	id 00BB1578; Wed, 24 Sep 2025 23:42:03 +0530 (+0530)
From: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
To: david@redhat.com, Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com,
        akpm@linux-foundation.org, shikemeng@huaweicloud.com,
        kasong@tencent.com, nphamcs@gmail.com, bhe@redhat.com,
        baohua@kernel.org, chrisl@kernel.org, zhangpeng.00@bytedance.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
Subject: [PATCH V2] mm: swap: check for stable address space before operating on the VMA
Date: Wed, 24 Sep 2025 23:41:38 +0530
Message-Id: <20250924181138.1762750-1-charan.kalla@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=EuPSrTcA c=1 sm=1 tr=0 ts=68d4347b cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=COk6AnOGAAAA:8
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=jVo6M1OS4bf5ToXj5xsA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: rAvLsWK55bo77kisLkUd92D1by63XykS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIyMDA5MCBTYWx0ZWRfXxgDJyEgOzTUT
 EhUjGS7R704IPssd/ZKTLopig+3g/IdsZJ1VQ8vOsKcSy/mEtrDdy5UopV9FFz5TRJ5wLpzHG4W
 dxG44dLLO0wYI/JHID1f9lWr+tf9Gm1m5XEsgI0p5VjRpNwPMri6H4IWUdRhp7AWyj56Zj3DV5Y
 hg9Sn1kTySAz0TUovAfbBR/vezVGqpaQs0qRSXQCSrcqmbWbZ2ae5UsX6Cn9tmXniS7rC1Scwrn
 6C5go49eC4AG+dfLng5H1E6LxxTN0/ZX9RWXGBvLH3mSOFctPVE6+Ss9xSogj9XMH8fa7qbb1Y1
 xZPqC/agUDSU4ZU4ZgqhF5dxzL1Su08veIJL7I3BsN+XPbOVzR8i//pNQP9j6oUqDuNKKxi1eTR
 byplllkY
X-Proofpoint-ORIG-GUID: rAvLsWK55bo77kisLkUd92D1by63XykS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_04,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0
 clxscore=1011 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509220090

It is possible to hit a zero entry while traversing the vmas in
unuse_mm() called from swapoff path and accessing it causes the
OOPS:

Unable to handle kernel NULL pointer dereference at virtual address
0000000000000446--> Loading the memory from offset 0x40 on the
XA_ZERO_ENTRY as address.
Mem abort info:
  ESR = 0x0000000096000005
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x05: level 1 translation fault

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

The proper fix would be around not exposing this partially-valid tree to
others when droping the mmap lock, which is being solved with [1]. A
simpler solution would be checking for MMF_UNSTABLE, as it is set if
mm_struct is not fully initialized in dup_mmap().

Thanks to Liam/Lorenzo/David for all the suggestions in fixing this
issue.

[1] https://lore.kernel.org/all/20250815191031.3769540-1-Liam.Howlett@oracle.com/

Fixes: d24062914837 ("fork: use __mt_dup() to duplicate maple tree in dup_mmap()")
Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Charan Teja Kalla <charan.kalla@oss.qualcomm.com>
---

V1:
   -- Checking for xa_zero_entry() instead of most cleaner way of
checking for MMF_UNSTABLE
   -- https://lore.kernel.org/linux-mm/20250808092156.1918973-1-quic_charante@quicinc.com/

 mm/swapfile.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 890b410d77b6..10760240a3a2 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2389,6 +2389,8 @@ static int unuse_mm(struct mm_struct *mm, unsigned int type)
 	VMA_ITERATOR(vmi, mm, 0);
 
 	mmap_read_lock(mm);
+	if (check_stable_address_space(mm))
+		goto unlock;
 	for_each_vma(vmi, vma) {
 		if (vma->anon_vma && !is_vm_hugetlb_page(vma)) {
 			ret = unuse_vma(vma, type);
@@ -2398,6 +2400,7 @@ static int unuse_mm(struct mm_struct *mm, unsigned int type)
 
 		cond_resched();
 	}
+unlock:
 	mmap_read_unlock(mm);
 	return ret;
 }
-- 
2.34.1


