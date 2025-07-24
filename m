Return-Path: <linux-kernel+bounces-744654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5823B10F8A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 18:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9DB0175F5F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 16:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6878A2ED87C;
	Thu, 24 Jul 2025 16:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Zm7l2r+g"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380AF2ED859
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 16:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753373822; cv=none; b=Xb1KhS8xdOhxh8Kvv50GJuHsLxvTk9imCxRUtPgl8w7pw1gukAP+Qw80KMrTGe/jD4kTPkViml3lwa2P0B5to8Zp05lOX9eqiIZT7H7P3mt0eAAMpsCy9aWLuAe0nCqRL3D9Vgxi8a96QiUTxJ1qHa9IGN3P6YaksKguiS+7mqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753373822; c=relaxed/simple;
	bh=p7BICrBXt18Q5mn56gsDeVJElBImXEVjdFKPj1y2d+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iSUhtKqrozFgmGlnY2cl9h+uKcWorUXfPuRzJJwAtyN7bBDOByf3sq3Z6Vd/JZhXCpFz+QRerlc+a12cij+v/pgnB/5KumlczC1lKZWCyVkr5zWOkADP+GdntxUXnbS8zEYN0c9gh5Yqbi5UJW974X6cLLBfB0Pqc92T3l6JAEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Zm7l2r+g; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56ODROF0022324;
	Thu, 24 Jul 2025 16:16:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=Rxzbr
	XG6TMluERJ7iS9k/2q5owET8hmYAVD2ax9w6MY=; b=Zm7l2r+gggwMbEXaPpVS4
	TVikEUtBa02J5iqVZBxK+SwQgSXTZCaoVCYj0aNdXPiTf950cojwymZHn8UuHgpj
	R5IxUlo8/GdJeuSweo7UV1op6/4fuviO7OS//uobfXnAF6agQZMBUDDqSbxxdN4a
	SMh5WhYplhfnqoupa2ZpoVQwn9aHh8iIUhJYQ6GDZiswci+lgwuCZvGfRBCvt4Hq
	XHq6KH6QHXh4orNSKuo5lpSMWlWihsSoHHbzRMLVexUIEZgNidmBaEyC7kZ5uBSK
	hMXPuXusiUm6fubAJmr7cJH3KqLVpslfMG9EW4qJd4xyxwKgVe++f6HfCzDLaWlK
	Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4805e9syck-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Jul 2025 16:16:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56OFiYlc014492;
	Thu, 24 Jul 2025 16:16:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801tjcfru-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 24 Jul 2025 16:16:31 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56OGGRNU034466;
	Thu, 24 Jul 2025 16:16:30 GMT
Received: from psang-work.osdevelopmeniad.oraclevcn.com (psang-work.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.253.35])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801tjcfne-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 24 Jul 2025 16:16:30 +0000
From: Prakash Sangappa <prakash.sangappa@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        tglx@linutronix.de, bigeasy@linutronix.de, kprateek.nayak@amd.com,
        vineethr@linux.ibm.com, prakash.sangappa@oracle.com
Subject: [PATCH V7 07/11] sched: Add API to indicate not to delay scheduling
Date: Thu, 24 Jul 2025 16:16:21 +0000
Message-ID: <20250724161625.2360309-8-prakash.sangappa@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250724161625.2360309-1-prakash.sangappa@oracle.com>
References: <20250724161625.2360309-1-prakash.sangappa@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507240123
X-Authority-Analysis: v=2.4 cv=eqbfzppX c=1 sm=1 tr=0 ts=68825c60 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=Wb1JkmetP80A:10 a=yPCof4ZbAAAA:8 a=xGzrbLGfahxIBTsCyEoA:9 cc=ntf
 awl=host:12061
X-Proofpoint-GUID: _qVD9nUPXC0Uv4aUR5V7ymW9OJv8kQxb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDEyMyBTYWx0ZWRfX5idxh2+P0Di7
 v0ungqGPyA2dkieZ7krOSAN0BH8q3BbDSHDVag0/y+0+XtmWICnnBrv60x8g+GYmxWp5R+OtHxN
 uDChuSzHCqDw6R6kUbDsa1SZaABMxRsxjcKLz4VCZp8kAF3IS3U+L5deO4y0lkfbqSN9Us6u7Gw
 s3yW6YwQOe3Z5M0hty6k3qoe0G/A8pB7fN9RWgkt1/wLTo9WFj5Cy1f1cFL3JT81Zn0vbgKczlU
 rb8D62aHKF2GCK1EUyoJiz3wKrr0TO4taVarmdZiDYmVvAXlFFbfy4tcmKYcFY9yLgnxzdtiGG+
 1CphUgi8IZk7HM9F9g3gVcbZAz/kRHUY7J7DwXmW9K6ZeBamoCTu9jmZgZd3VYigHGgUdCxdiyH
 sR48IULXEa3Gkk4OZU6bjQmY5KTOEsgeT25zF6xQkOLPRNWLRxL0k8/SNAB/5JO6yRy9KiEE
X-Proofpoint-ORIG-GUID: _qVD9nUPXC0Uv4aUR5V7ymW9OJv8kQxb

Add an API for user threads to request scheduler to not delay
scheduling it when woken up to run. This is allowed only for RT threads.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Prakash Sangappa <prakash.sangappa@oracle.com>
---
 include/linux/sched.h      |  1 +
 include/uapi/linux/prctl.h |  3 +++
 kernel/sys.c               | 18 ++++++++++++++++++
 3 files changed, 22 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 5c5868c555f0..3e8eb64658d1 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1062,6 +1062,7 @@ struct task_struct {
 #endif
 	unsigned			in_nf_duplicate:1;
 	unsigned			rseq_delay_resched:2;
+	unsigned			sched_nodelay:1;
 #ifdef CONFIG_PREEMPT_RT
 	struct netdev_xmit		net_xmit;
 #endif
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 6f9912c65595..907300cd4469 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -379,4 +379,7 @@ struct prctl_mm_map {
 # define PR_FUTEX_HASH_GET_SLOTS	2
 # define PR_FUTEX_HASH_GET_IMMUTABLE	3
 
+/* TASK sched nodelay request */
+#define PR_SET_SCHED_NODELAY		79
+#define PR_GET_SCHED_NODELAY		80
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/sys.c b/kernel/sys.c
index a088a6b1ac23..2f8b4512c6e4 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2890,6 +2890,24 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 	case PR_FUTEX_HASH:
 		error = futex_hash_prctl(arg2, arg3, arg4);
 		break;
+	case PR_SET_SCHED_NODELAY:
+		if (arg3 || arg4 || arg5)
+			return -EINVAL;
+		if (current->sched_class != &rt_sched_class)
+			return -EINVAL;
+		if (arg2)
+			current->sched_nodelay = 1;
+		else
+			current->sched_nodelay = 0;
+		break;
+	case PR_GET_SCHED_NODELAY:
+		if (arg2 || arg3 || arg4 || arg5)
+			return -EINVAL;
+		if (current->sched_class != &rt_sched_class)
+			return -EINVAL;
+		error = (current->sched_nodelay == 1);
+		break;
+
 	default:
 		trace_task_prctl_unknown(option, arg2, arg3, arg4, arg5);
 		error = -EINVAL;
-- 
2.43.5


