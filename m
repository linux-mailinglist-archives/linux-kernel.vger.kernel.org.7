Return-Path: <linux-kernel+bounces-818939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC5EB59850
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 15:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0E204627B6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 13:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B220F31D75F;
	Tue, 16 Sep 2025 13:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="R1NtoAI/"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBB42D7388
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 13:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758030966; cv=none; b=Mje/iD248otctMMu80TLeEl75oCvgsgFDMUROV1CSpShi56tQukFcySA/4Ql9DMRAtoFPX+hU4JX99nOVvnDJpejtAv+YamQvfdjAMWfza4ta/a8oo6fTl2bRf3ukPikDRo9IKvxbkjxdGV+rYcj6t0iv+uU2lsuKhqoaXWfSWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758030966; c=relaxed/simple;
	bh=URlBLibXpyD/4Ie/Ft1JBCH9nzE0MwRF5O71LIMAx6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NYaXSxkFwX74BCyo0zAYoYpt+ekE6/5DVPpTUhtg6Z1vGJ+CI+FiRr4ZNC9avTRuCdDfJgLZ/BVHv6bOZptWrmaTF7iRzUWCsULRl9Wkz5F9Q9QRzL8rbcc93ABfyqgfE6MHAGRw2hAnl62YiDUI1PyOQrtXQY1IGAVjexjtFbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=R1NtoAI/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58G7q0qN023608;
	Tue, 16 Sep 2025 13:55:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=GKoLW8QWGyZYvaw9OFW/yxgF/N7sLAhPMXtzeM8Wf
	W4=; b=R1NtoAI/kmUNLZDf1Te9GHGLiK/qNdx0LgH0pJyVPxyKFz572+MHGc2d2
	V/SjNCZTmDmH7c37mdXpSPie8/fpp6ssGFD6910yBB92giWTXu45QmdqWY+Vthgz
	t8lSKLfEfBxOQgXJbaAHxi7VvzCbxXjDVe633rA7rIjn1H/BTHiUxgAuTuw4rdZ5
	SKgl7WDAP8XOUZ9zvBV2KcdhEOW3pGC45ew/A8+QzA2U8xTQ0WbwcVHw8eZ5tQTM
	rxolxZrpdiIaQZo1YMiCLR4yFVyWQ+o0U+FZAzTe+z+JuBxLUZK3UJB6eqkeBUx3
	d8A4Zyj/xWETENeSBTUb9WojhX8IQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 494x1tgs1c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Sep 2025 13:55:51 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58GBRjrU018629;
	Tue, 16 Sep 2025 13:55:51 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 495n5mbwyh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Sep 2025 13:55:51 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58GDtnuX31850820
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Sep 2025 13:55:49 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 66F512004B;
	Tue, 16 Sep 2025 13:55:49 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C36F020043;
	Tue, 16 Sep 2025 13:55:46 +0000 (GMT)
Received: from vishalc-ibm.ibm.com (unknown [9.39.20.135])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 16 Sep 2025 13:55:46 +0000 (GMT)
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org,
        hpa@zytor.com, bp@alien8.de, mingo@redhat.com,
        dave.hansen@linux.intel.com
Cc: Vishal Chourasia <vishalc@linux.ibm.com>
Subject: [PATCH] x86/kernel/smpboot: fix typo about notify_cpu_starting
Date: Tue, 16 Sep 2025 19:25:25 +0530
Message-ID: <20250916135524.483752-2-vishalc@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=OMsn3TaB c=1 sm=1 tr=0 ts=68c96c68 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=FKb8m_DH3KGIUYsSbUgA:9
X-Proofpoint-ORIG-GUID: J2__58A5EX_rH--eBH4b3JMHXI5y3AJY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAwMSBTYWx0ZWRfX8KmqD/URr5O1
 wbIQNlHDT+T4NlHkHKKsVnx8/3XU6swkkn4DAwlpVwRNTKl9xR9SqZL4kfo16wHX50bYs18kAt+
 lORRMHzVelFoh4+nIAiHVUyte35XDXWKO0huKskIdKVnQox3hyjd2xwqT7VVrSWQnOkiNoBnSj1
 0eRXe56CqfopstZ95Xs0qQQx+svQQOGmzEsAtK+JvcyHcj682ve9uZ0s6xzkKZ0kfAPFjcR4r8K
 fXiIBSH/3BCo+Mgx9hb7ZDw9a8X3WDflNmyi6UJQ17sl+l+SDMOIsriV4u2VQF4OZYi2kh98B5S
 sBtqDdb8mgVRE5W5H9kwNRjf8qil2+rgSvHF+tFDnS5qdXAIOxZKDte8FTnEu9ru6gspKI5DDko
 FB9rn+f4
X-Proofpoint-GUID: J2__58A5EX_rH--eBH4b3JMHXI5y3AJY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 spamscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 clxscore=1011 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509130001

`notify_cpu_starting()` takes the min of the target state and
CPUHP_AP_ONLINE

Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
---
 arch/x86/kernel/smpboot.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 33e166f6ab12..3561b5ed6ab0 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -204,10 +204,7 @@ static void ap_starting(void)
 
 	wmb();
 
-	/*
-	 * This runs the AP through all the cpuhp states to its target
-	 * state CPUHP_ONLINE.
-	 */
+	/* This runs the AP up to the CPUHP_AP_ONLINE state */
 	notify_cpu_starting(cpuid);
 }
 
-- 
2.51.0


