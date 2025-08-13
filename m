Return-Path: <linux-kernel+bounces-766652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20DC8B2497A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 14:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DFE7189ADC2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 12:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05DF019DFA2;
	Wed, 13 Aug 2025 12:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GmoeVS/9"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDB218A6B0
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 12:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755087830; cv=none; b=KbQsn3kboVRBoxjOUsCs16tun02axupRFkOURd1yQHxpPK7h1KbcUlIxwkMUUiJ+Qk8msPsGSN5cVYRhsVNuV4ZNFr8lCOwPSkm4T9Ra9w6/spHAm/6vFtIo2jqqnpcNq75EvAWuMoN1nXo6DMIT0ZO1Yy+7d0RUDzFi6ggFqOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755087830; c=relaxed/simple;
	bh=nt6EiFyUXXOArQPAl6XQ5bZed2iMXAstzds1q1s2saw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J7aaWWPEr+8W4+G2gfZCcwt3mAJJ+9I6KHt98khc0iy5RUSYCxKB2xXO67RDG+MrMsh/sYCEjvJxjdsqQnqrEp/uvp8cAFxJt7n4DgTA2qW/WaouiOFA8+byLS4Kha5MIYVBbjZ2CUKvtWg5nC4Ps24q9X95AgtIdV0YgE+sLfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GmoeVS/9; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CNQNXd011109;
	Wed, 13 Aug 2025 12:23:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=8SRTaOVIdc3UEMvoKlCIo18BO7bQIksRQcjKezVHR
	/U=; b=GmoeVS/9zwNOO+RIEsmBQ1f+EunCvdKHKoH29CKofKuXUMpMAE3jU+KWM
	bJynRg3HGUW+WUvka17blhawBgo5YusoslcE2HBbUjFgZXsQQz2saHTJ92YLUOmp
	jcGx9sSiF1pGAxJxCjVsB1NLu/hDWY66M67kNjdKRv9qKQOoHbr4Ms2GqBSVmdBR
	MZ+CaO6Emo27TayeLbnPSR5LqVmbpH8qrjFdF/nc3/JW+ZotTFTmJ64Q1AhILSzl
	fAylWgdMbByANMvAGSH4hdlQnHrciblTzkp0rPdOZfTCKsynGccYQxik92olmUF1
	0xyI6volqTXTPGX3nKOGUcpXRqMGg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dx2d4c0f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Aug 2025 12:23:35 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57DCIsEV020023;
	Wed, 13 Aug 2025 12:23:34 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dx2d4c0c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Aug 2025 12:23:34 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57DAvPAe026302;
	Wed, 13 Aug 2025 12:23:33 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48eh217avp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Aug 2025 12:23:33 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57DCNS4Q34013944
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 12:23:28 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8DBFD2004B;
	Wed, 13 Aug 2025 12:23:28 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B373E20043;
	Wed, 13 Aug 2025 12:23:26 +0000 (GMT)
Received: from li-c6426e4c-27cf-11b2-a85c-95d65bc0de0e.in.ibm.com (unknown [9.204.207.58])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 13 Aug 2025 12:23:26 +0000 (GMT)
From: Gautam Menghani <gautam@linux.ibm.com>
To: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu
Cc: Gautam Menghani <gautam@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: Remove duplicate definition for ppc_msgsnd_sync()
Date: Wed, 13 Aug 2025 17:53:18 +0530
Message-ID: <20250813122319.62278-1-gautam@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDIyNCBTYWx0ZWRfX0EAJAGgcgt+A
 EfBdUfmfiICnAQY1kEEvzJk4qEuV+vdpAisCDKMQ3w0ddHsWRSfVGyNm7kGU47qNiBE229utQd6
 5odE797dXGVnLNUaFka+FKF3ogci9wRrKADmFvtVHuEmuvAFNwVEMZo7cTt/Tiv+zGyn5GrjNZv
 a0fdsSAVoa4Bjm5r4XG107iIiYlt2YhPB8jCX7oybXC71QR+PJ2CIx6PYC0UAe0l30XNVttsKg8
 Kge0616MrF+2eOimwpTgvwLEnh7bw7Rh1cRE/Y8QrAR6X5xYoqk8TT2Z/QcjPM2lYFyxaVO+PPH
 t3Og7yZvU9JzUHHIR6mTtrhwg57DpTkW1IMCE67pS04o5D4qez4MzxOrw/RhjIG1rQewtfvsYmj
 2ZT9JS15
X-Proofpoint-GUID: tPnILda0WGdoFS5WUKjFlRTAtT6kpxzh
X-Authority-Analysis: v=2.4 cv=C9zpyRP+ c=1 sm=1 tr=0 ts=689c83c7 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=4-XWpGT9Fzu9lZODdTIA:9
X-Proofpoint-ORIG-GUID: O2euuYhOb0Cw-XMmLptgIMCGEkwiKLV6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_01,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015
 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508120224

Remove duplicate definition of ppc_msgsnd_sync() introduced in commit
b87ac0218355 ('powerpc: Introduce msgsnd/doorbell barrier primitives').

No functional change intended.

Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
---
 arch/powerpc/include/asm/dbell.h | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/include/asm/dbell.h b/arch/powerpc/include/asm/dbell.h
index 3e9da22a2779..0b9ef726f92c 100644
--- a/arch/powerpc/include/asm/dbell.h
+++ b/arch/powerpc/include/asm/dbell.h
@@ -40,12 +40,6 @@ static inline void _ppc_msgsnd(u32 msg)
 				: : "i" (CPU_FTR_HVMODE), "r" (msg));
 }
 
-/* sync before sending message */
-static inline void ppc_msgsnd_sync(void)
-{
-	__asm__ __volatile__ ("sync" : : : "memory");
-}
-
 /* sync after taking message interrupt */
 static inline void ppc_msgsync(void)
 {
@@ -76,12 +70,6 @@ static inline void _ppc_msgsnd(u32 msg)
 	__asm__ __volatile__ (PPC_MSGSND(%0) : : "r" (msg));
 }
 
-/* sync before sending message */
-static inline void ppc_msgsnd_sync(void)
-{
-	__asm__ __volatile__ ("sync" : : : "memory");
-}
-
 /* sync after taking message interrupt */
 static inline void ppc_msgsync(void)
 {
@@ -91,6 +79,12 @@ static inline void ppc_msgsync(void)
 
 extern void doorbell_exception(struct pt_regs *regs);
 
+/* sync before sending message */
+static inline void ppc_msgsnd_sync(void)
+{
+	__asm__ __volatile__ ("sync" : : : "memory");
+}
+
 static inline void ppc_msgsnd(enum ppc_dbell type, u32 flags, u32 tag)
 {
 	u32 msg = PPC_DBELL_TYPE(type) | (flags & PPC_DBELL_MSG_BRDCAST) |
-- 
2.50.1


