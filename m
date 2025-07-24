Return-Path: <linux-kernel+bounces-744239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4318B109F2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 14:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98D714E3CF8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 12:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA012C327A;
	Thu, 24 Jul 2025 12:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JCqHw0zv"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6359D283FF5
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 12:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753359217; cv=none; b=MzrmnpesERN1Lh7CyU2N2JcvrrEHfT3OqpGs7BYTUjPCUmfHLVJYxTy5CrkJqmguOaADRyGfYgVfEFtSl90puW9nTYQqpJAXXwqef+gETNNlJlb1r9YrATJ7vZmWMeOnN/2SIzR0qsuvEihu+Wzr2e52v5jXT8Qvio++oOWY2IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753359217; c=relaxed/simple;
	bh=m+rERM4PIccNiDAG3uGTWmtWBw+eGdmGbRk72H2Z/zI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T59A6jF0utfnoXjcYHRtxdp3ZnqihAnnp2jiwkRKQSPHs4Xqv7ntOJqNyXXS0LG+pgQOvuIg2EWW9M7uk4wLVUBrTesZGFtl/pEG/t8GRE7ZM6NRNpaH3uxeetRlWYVwRw8efR/MTd80XgsjV6Itoc2aqRRQaUrHH9SroJNFkGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JCqHw0zv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56O9fxnO014992;
	Thu, 24 Jul 2025 12:13:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=aR+2Uw441+d7uzknu3k9h1
	arpk/SRErkMxx3Wdl5x58=; b=JCqHw0zvznxbsSOQ11jBsJ7GyDPk6PDMa8JINk
	CzP/a1GsltPA1t04Z06l7+ejhXVGw67WwrWp6XGjECEWwHfpfAuqT2ZeEwb/2naX
	U2B6j4whD6JJFTjMz8W1WhadZASPyKAlIJFC/c0yriA5gT+Vt5SK7PMEFH045B50
	q/ect6T+NlK26T2+iQrzA/RLEHp07sxDXwVMbq8xWDVPHCg9LZ4RaGcb40ZgQ+rd
	FbbtUzpNlJf5TlMSnv5O2RhHSaR0XLgbFCLV4ryVQUdMjZBXFGhvd4gdPyeJmL0B
	LwW/zU4NZjqPi5/zVAB0Xwq8BiXJE5pgDllMC8FkBveNCB0Q==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 483379tt80-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Jul 2025 12:13:18 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56OCDHlY025062
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Jul 2025 12:13:17 GMT
Received: from zhonhan-gv.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 24 Jul 2025 05:13:15 -0700
From: Zhongqiu Han <quic_zhonhan@quicinc.com>
To: <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
        <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
        <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
        <vschneid@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <quic_zhonhan@quicinc.com>
Subject: [PATCH] sched: Combine ENQUEUE_MIGRATED check in activate_task()
Date: Thu, 24 Jul 2025 20:12:58 +0800
Message-ID: <20250724121258.1826487-1-quic_zhonhan@quicinc.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _ujvgS51YF_CMuSrpzoMvxF5XKPGugFO
X-Authority-Analysis: v=2.4 cv=btxMBFai c=1 sm=1 tr=0 ts=6882235e cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=SeSF_3wNJrZcFQq4b1oA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDA5MiBTYWx0ZWRfX5ru/GHgXxLq5
 jpOFU6C4G5GXeyOElYkErQCErPeJli6py6wvxwx6MKAvnMjyPt1QMz/8zPtpcvRulu+LDMXswws
 i3M3Xju5llT/+a8UhkecV/4VoOj6jUERdlDdDGXjP7HVWa4ujYECiYbFM0kVoG6zh5qzC6Q2KIf
 0NHQvB0veAD69dPu3yDQpmL7Plt9djTfygMRU5CzinHuS4RrckzRApTsW7zgtor5irINwHhk35j
 AoELIO82nyFFYtu/ZZWAso6sSlC+cPo6H1+L0wgI6C8gKMu8gh2j8m5zrnPhBi0AAlaxFirR7pX
 UbMRy7ytvJ6goBh2/1GuioIs9BRwHcA5Cg39jx93a7HL9ho8t4ates2hNE+kPkpXTlvfkqFJc66
 jA6hhNSYLghMJ+MdpJVe6PhHm1xnu3SBdnZNOqgNsuBRj/Od/MSnK73nFXlNDSAaqdc7/e3I
X-Proofpoint-ORIG-GUID: _ujvgS51YF_CMuSrpzoMvxF5XKPGugFO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxlogscore=830 impostorscore=0 mlxscore=0 clxscore=1011
 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507240092

Combine the task_on_rq_migrating() check and the sched_mm_cid_migrate_to()
invocation into a single conditional block. This removes a redundant flag
check and slightly reduces the instruction count in a hot path.

Signed-off-by: Zhongqiu Han <quic_zhonhan@quicinc.com>
---
- This is a slight optimization and code cleanup, please let me know if you'd prefer to keep the current structure.
- Thanks

 kernel/sched/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2343f5691c54..d6063cf503ee 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2118,10 +2118,10 @@ inline bool dequeue_task(struct rq *rq, struct task_struct *p, int flags)
 
 void activate_task(struct rq *rq, struct task_struct *p, int flags)
 {
-	if (task_on_rq_migrating(p))
+	if (task_on_rq_migrating(p)) {
 		flags |= ENQUEUE_MIGRATED;
-	if (flags & ENQUEUE_MIGRATED)
 		sched_mm_cid_migrate_to(rq, p);
+	}
 
 	enqueue_task(rq, p, flags);
 
-- 
2.43.0


