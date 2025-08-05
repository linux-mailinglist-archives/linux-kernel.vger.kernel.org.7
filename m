Return-Path: <linux-kernel+bounces-756377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1326B1B344
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 14:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 740CD3B76B9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 12:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63CED270ED9;
	Tue,  5 Aug 2025 12:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iqEWj5G2"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC62826F44D
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 12:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754396656; cv=none; b=P62W7v0uHjckW7FJr6icmW0Uc053MG6uGX9sw8saaNP4FSmsLbfXrOEPcNZRzxuz+QyCzHIQWvMgxqQLk7T+POGbzSnKb5CcLJQxBu0Qifz4FlcrwyrxW6+/x8ZXzElGej0OoK5KEGFtrl+XznT7tGNX4WN2UBYC8QItfFIX5JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754396656; c=relaxed/simple;
	bh=vDaZ5gCH3V289ovqAD071Uy7fsKU1TED7TG1aj8iBYA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=q+6UwvwlGndz/kOVVHxhluTj9bBis7RLHnhCPLL0GXsT5WGYV8ekgVZq6s+SVIwX+d6AHweyf/AS1SR9JjUkXsaZiL+o3VuJrEdBZrsr3DrgDXrtovF8rmYS7b4WDewcykBnrbD0h2mAdkMS1hf1Dstnc7SShUIKD3DQ7rSVS9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iqEWj5G2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5755v8SS014583;
	Tue, 5 Aug 2025 12:23:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=9J1sDBql2zT++bXvQ3Qe0K
	s1kPTqGQaGnmAZYkMfQ5Y=; b=iqEWj5G2KA9yo2iz3ul8ysslgjOsoHEM+W3P3T
	gJLz8SE+ygzvcVJhimNzOV8N+T71MSGtnbJ5m42gJQ09Lg9ZL4VHlME724YwiQNg
	exp81fptrMB90oS8YppaMj86uNVDFYhg/+QWqLrT9NLilaMBq2cT24qLK1Fd9nzG
	4ovLzzLCxscNkks8AOZkM3jM6mi5xWT2Ktt9miblbgRNVCiEZ7oXxpEOw3NzA/Yo
	hqLUet//JS1Ok4Xz0JjDhmvICZgo0ph4ZVlkFsMqoh5Ma0IvFnDH7Jxdhq81cZa/
	nuxxLKr5XLSPAQZ1pn3G6ivY/hujPuktZ7ma8rOYCTgyNKqw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 489byc8dcn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 12:23:33 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 575CNWQP020802
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 5 Aug 2025 12:23:32 GMT
Received: from zhonhan-gv.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 5 Aug 2025 05:23:30 -0700
From: Zhongqiu Han <quic_zhonhan@quicinc.com>
To: <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
        <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
        <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
        <vschneid@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <quic_zhonhan@quicinc.com>
Subject: [PATCH] sched/fair: Update stale comments referencing last/skip buddy
Date: Tue, 5 Aug 2025 20:23:16 +0800
Message-ID: <20250805122316.1097085-1-quic_zhonhan@quicinc.com>
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
X-Proofpoint-ORIG-GUID: RpJIXgyQuUx3u4Q_NUwTHzoeEFKHERWp
X-Authority-Analysis: v=2.4 cv=Y6D4sgeN c=1 sm=1 tr=0 ts=6891f7c5 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=GyCI_XyKeols5dtOVpMA:9
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: RpJIXgyQuUx3u4Q_NUwTHzoeEFKHERWp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDA5MCBTYWx0ZWRfX1YUCZ2OaurwD
 oRsH0PmgsKoI5yTs2zxwAXA4ztPgFg6bIXHd49WFX3v+dO4ArXOP9QdrCgmRjA/5Pf7c67K+BxB
 8+yi0AhckRusYK8DhIC2wDzwcDIzc7w20H8YUVUyYOpzNp1LGte5lc1OhQ8qrCpjHEr9gTFpi0l
 NnS6yHsZ+HVF1+AE/gDcGQX+iUjejZ/v2pzD2W4fpZjKm/FdfyI+respmUlVS5aNPRG4K/qLGUU
 kCBzncA8N7Dowv2rO4E3qMTq/7to+tRD6LUizls858i/QLA87UxWRbc4XMt+74wL8ilz/4YJUnK
 5YfeNokO2Ll4KKAD1VNYKqcSVkJbvKEbz0aqn/sxXj36lZ9yTAlqwkmg6I8fA5HnSzZnG4Wp94Z
 2aNFohgyfIbEN6Kljuwrz1G8oux6CHsdNKBNQNjwkjrWarEik/6Kkeqs7he8cnyTinKk9oA1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_03,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 mlxlogscore=999 suspectscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 malwarescore=0 adultscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2508050090

Since the integration of EEVDF, the last/skip buddy scheduling features
have been removed. This patch updates outdated comments that still
reference these legacy behaviors to avoid inconsistencies.

Fixes: 5e963f2bd465 ("sched/fair: Commit to EEVDF")
Signed-off-by: Zhongqiu Han <quic_zhonhan@quicinc.com>
---
 kernel/sched/fair.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b173a059315c..b3618aa075ec 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5500,11 +5500,11 @@ set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags);
 
 /*
- * Pick the next process, keeping these things in mind, in this order:
- * 1) keep things fair between processes/task groups
- * 2) pick the "next" process, since someone really wants that to run
- * 3) pick the "last" process, for cache locality
- * 4) do not run the "skip" process, if something else is available
+ * Pick the next sched_entity to run from cfs_rq.
+ *
+ * Prefer ->next buddy if sched_feat(PICK_BUDDY) is enabled and it's eligible,
+ * to improve cache locality.
+ * Otherwise, pick the entity via EEVDF for fairness and latency control.
  */
 static struct sched_entity *
 pick_next_entity(struct rq *rq, struct cfs_rq *cfs_rq)
@@ -8673,9 +8673,9 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
 	 *
 	 * Note: this also catches the edge-case of curr being in a throttled
 	 * group (e.g. via set_curr_task), since update_curr() (in the
-	 * enqueue of curr) will have resulted in resched being set.  This
-	 * prevents us from potentially nominating it as a false LAST_BUDDY
-	 * below.
+	 * enqueue of curr) will have resulted in resched being set. This
+	 * prevents further preemption handling, including checks and potential
+	 * reschedule triggering.
 	 */
 	if (test_tsk_need_resched(rq->curr))
 		return;
-- 
2.43.0


