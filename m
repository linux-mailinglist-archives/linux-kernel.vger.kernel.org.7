Return-Path: <linux-kernel+bounces-623341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D7C6A9F458
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Apr 2025 17:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F042F3BA25B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Apr 2025 15:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9120B269B0B;
	Mon, 28 Apr 2025 15:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PFZphABG"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3BC2798EB
	for <linux-kernel@vger.kernel.org>; Mon, 28 Apr 2025 15:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745853859; cv=none; b=eRI0JZPwVNRSfVkercQJBKWY644JFeifkc0jRFSPTaeeWGqWTi5y3gAoN/Hv9rrwT2bX+191K1kNV9iKpCGsthN6nfJbzUoBsm17tSbpOU2bgsHg1wP9ToGUUL3waqRI5vhs3/B1gADNlZvmuWT2FUJ3kwcSScOTb6qjFFf28Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745853859; c=relaxed/simple;
	bh=xmJt5ypLgnB9weP/iHo25LC63UKAGen6G9NfY4FMaWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HKrpxZVvtLZLRB9sjd+T0WHhPMbEFGndnvHbYPuDSZyetVHDQ6bPM6c4A4h42Yx4Eki1N40m3uQWbcHUYz9FC2Fkfd4lph1cQjb9w04oSrxLZbi+A+ftq6SX+zECIcmlCWSllekhYeKMmqGK2lO12SVA+nfxYGpUUTSYEFCmaTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PFZphABG; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53SCuQ5X001912;
	Mon, 28 Apr 2025 15:23:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=fwHaxczBR7yQD6/R7
	nlEMeprDyL/dgd7UkBYm4zCmSs=; b=PFZphABGPhOdbuAfSId0VtvZaDZ9Rmx5+
	BjXhCbowZjcQGURoOvlqstm5+sQCHVCPYWjOV7OtoZ6qpkob3C2C8uZc42Zuu9BF
	mn5cFHzQ17pu1D2qKYYbY82USvFhRFex+7H4TZ9eJaRhNVSisywb7aBe8iZMkXAI
	xrHLkGtq2GE9Qrk8ZDfaQ7wMjNcrQ0uMZaPeS5h5rF+ebcwqAl5jQW24z9NeZeij
	psrlHfQSQySixhPlAilYUDRwoze0zCaclf0rbQaGgKRCkUWdwlwdgOijmMe8pbgD
	4La1whAcLVPIP5cDOJOQepkuqSaOKmBgyhREv9dfq6Lyhi5uximLQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 469xj0unem-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Apr 2025 15:23:54 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 53SFE18H015303;
	Mon, 28 Apr 2025 15:23:53 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 469xj0uneg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Apr 2025 15:23:53 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53SCnbPu008518;
	Mon, 28 Apr 2025 15:23:52 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 469ch2xq93-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Apr 2025 15:23:52 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53SFNmG020971838
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Apr 2025 15:23:48 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BA50A20040;
	Mon, 28 Apr 2025 15:23:48 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D822620043;
	Mon, 28 Apr 2025 15:23:42 +0000 (GMT)
Received: from li-e1dea04c-3555-11b2-a85c-f57333552245.ibm.com.com (unknown [9.39.30.54])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 28 Apr 2025 15:23:42 +0000 (GMT)
From: Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, naveen@kernel.org,
        neeraj.upadhyay@kernel.org, vschneid@redhat.com, tglx@linutronix.de,
        frederic@kernel.org, ankur.a.arora@oracle.com, sshegde@linux.ibm.com,
        bigeasy@linutronix.de, kees@kernel.org, oleg@redhat.com,
        peterz@infradead.org, tzimmermann@suse.de, namcao@linutronix.de,
        kan.liang@linux.intel.com, mcgrof@kernel.org, rppt@kernel.org,
        atrajeev@linux.vnet.ibm.com, anjalik@linux.ibm.com,
        coltonlewis@google.com, linuxppc-dev@lists.ozlabs.org,
        Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>
Subject: [RFC V1 4/6] powerpc: Add flag in paca for register restore state
Date: Mon, 28 Apr 2025 20:52:25 +0530
Message-ID: <20250428152225.66044-7-mchauras@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250428152225.66044-2-mchauras@linux.ibm.com>
References: <20250428152225.66044-2-mchauras@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: O5prXhxbgXtqtZqsDc8dN7eMM6GyMqI7
X-Authority-Analysis: v=2.4 cv=GJYIEvNK c=1 sm=1 tr=0 ts=680f9d8a cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=Kj5IoVDe1b0y73Rl6aEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI4MDEyNCBTYWx0ZWRfX3z+ZrzZTIW9M 0SDDaMiu35cTYgSpqCmtsVuG3W5eho6YoeLFf9sPMzNfDuHUH0zAHzR5DEgqhdPUldsoB2qKl2J IWp3evivlyzAbWlyEx8rk4shVVtocD6yVuwNkV0PLjc3Q5U6D3q4t7R7wSLxfAaWsk5Bw+tjXd7
 5damFaTR4KNq8F6OPKSjstBv0valRMsRFCAJ3Ilma7kmKlRBeU/EL73fTXkCyn50FyaH7y1UcKq yXAFCv30/Cp6cSZ31HmL8sA/kHJmvtFac53ZE+idA9OR7eU6adwwpAT0cyavPjcmaaDmnzSxV2/ D+UxMtfxNeJZTrgeGM2x3nbBDT+io3UnuhkH3p2IQNgkHLfp6Wz45ok+fHF0uLIvjPD2w7T2iJJ
 GI7nuv7u0e0IYdYbEiRv/ZJeVL3lTs/JwIA6srnqJ9jD+DV2/dvkmrMApElne7SQWquOwfzM
X-Proofpoint-ORIG-GUID: Nu1XezD8osXlo9WblDfB_6U8i7CFyL2a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_05,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 mlxscore=0 phishscore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0 mlxlogscore=898
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504280124

In case of signal being processed we want to restore the GPRS. To save the state
of whether we need to restore the registers or not a flag is introduced so that
we can save the state for that cpu in case we want to save the register state.

Signed-off-by: Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>
---
 arch/powerpc/include/asm/paca.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index 1d58da9467396..215cafd64d8f5 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -174,6 +174,7 @@ struct paca_struct {
 	u8 irq_soft_mask;		/* mask for irq soft masking */
 	u8 irq_happened;		/* irq happened while soft-disabled */
 	u8 irq_work_pending;		/* IRQ_WORK interrupt while soft-disable */
+	u8 generic_fw_flags;		/* Flags for generic framework */
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
 	u8 pmcregs_in_use;		/* pseries puts this in lppaca */
 #endif
-- 
2.49.0


