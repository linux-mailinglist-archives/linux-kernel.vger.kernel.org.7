Return-Path: <linux-kernel+bounces-728158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C96B02426
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 20:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAE50B614DC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD962FCE11;
	Fri, 11 Jul 2025 18:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="F8Fj2Oii"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF70B2FC3AD
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 18:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752259137; cv=none; b=m3/wdmVqBYfm3f/lUbNqAyK2kryfAC+FoLXBAZ7Gix5EFuyiUsCM/Ny51zFsKQWuF+HS4rWjrZ+BQgd0NEa9zCxIzLJA+P8KCvOXfT8n6txCj+0kvbQZAKLdAau/Db8Fcw2R7sUnL8gf/Sthb5XrBSpJ6ZgeTYynmd1uoouXDqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752259137; c=relaxed/simple;
	bh=h4W3cQp+TtmS0aGmcxVT5XdwRqSpxAq9CwXvrr3v8JQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=VlMwLxI9sk0iXlDqW9KCulIB3dFMOsTGOvO+bYB0TkOmHGFDam+eKCdckVfnahpUkXWJA6IKrFYALZnGSqlskx7UmL3FPIMj2Cq1bCnHhzhSAy9/ufbaUxDQEnCWQIdv4v595EP9zXXFtrZLeoObTl3VzVngPOkP7F7krcrJwsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=F8Fj2Oii; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BB1Y8c005759;
	Fri, 11 Jul 2025 18:38:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dVm2mEmkYwfztpM3N9zWYd/1ThH+3xOMrRcm7lERDx0=; b=F8Fj2OiiBLX98bfG
	pbEZKR6ELfLahrRUcJkUTRXeDLYn1OWxR0w7R2T5pP/8iJD/MIxMsNW6hSPlN8O6
	f0XjanRpBvjqnyqvqd5Xc2AqdV+eNgp+2Ro2C994f/H7CVM6WvRXBbVJSPcvx8sR
	4Os3ZffhFAngPdYKEi+a+NeGBWDl9yDgynNcFGUvKcyVqF5BXgBgXUBkTBZ4/MoV
	/457xQbryT4asJZ9h1uiv3flgQNj7u8tS5UO3e4tzh69jfnXwE8xeYJhVnOWPp62
	zAVtg0Wqt0GY227DVANFhebBd4xPdbH6zggeHjtOyESQgUY5LFqJr2llhPQlVY1u
	L8gOmg==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47u1c597nb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Jul 2025 18:38:51 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56BIcocO018746
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Jul 2025 18:38:50 GMT
Received: from hu-achillar-hyd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 11 Jul 2025 11:38:48 -0700
From: Aditya Chillara <quic_achillar@quicinc.com>
Date: Sat, 12 Jul 2025 00:01:48 +0530
Subject: [PATCH v2 1/2] tracing/perf: Prevent double unregister of perf
 probes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250712-fix-double-perf-probe-unregister-v2-1-328b275672c5@quicinc.com>
References: <20250712-fix-double-perf-probe-unregister-v2-0-328b275672c5@quicinc.com>
In-Reply-To: <20250712-fix-double-perf-probe-unregister-v2-0-328b275672c5@quicinc.com>
To: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: <linux-kernel@vger.kernel.org>,
        Aditya Chillara
	<quic_achillar@quicinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752259126; l=2268;
 i=quic_achillar@quicinc.com; s=20250630; h=from:subject:message-id;
 bh=h4W3cQp+TtmS0aGmcxVT5XdwRqSpxAq9CwXvrr3v8JQ=;
 b=T5InSNJ6BLhMSfjyejFthJn1WR2fOz5APDavRmEBC7J6voK5Tn4mVVXN3u7C4SVLKPleufVp+
 u74qnuzCjmGCmodBzNmmHb8/FmHBSMkjtQlZ8KlODMfz3VxnhNN2E40
X-Developer-Key: i=quic_achillar@quicinc.com; a=ed25519;
 pk=n9YdZ9C822pphDmKHNwLKAFOJBiDCIOL/n1Mzy7/lg4=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: iXJE2-wt696bkeKCCSc58cvKHgJhb2rM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDEzOCBTYWx0ZWRfX2ESPk3Bvne2X
 vSDiNeIvlIR40ms13730dGOJEvJP1Rd+tVzG7ULgUrjxPbHh43osSb61DgTOxbWY7dXInNTHIRG
 tZ0tiWfqevbkDPWU8vN+fyD0GdNntktic3g0bYZxprjxHZas+E/tusbPaeO8m5JDqK5jVCkHIqH
 re9FqBVr8QXYJZWs455a3R2mm5Yqh1wadngbDt4VwXZfhMOl/ynXBBFQdi3ow5ztaydwDTriCKg
 2KLnM/xAVUjfvdebdDKFfRs0wNX3Pfn7bgfOyHcmxBIBCGCiEcULsYyMqHRB8QH2dnYleMDTZmj
 BEIQ2b+qgAtJKUTuFxXRu9UIIEpnna1TItGRgz4MzVeH9Xtu3Ua/tvkdgIyRp8sXsL+OwDu5WVI
 UDYTqVK8kyl7mF6H1vq29qDFL8EcnwfxMzxpXby9soEv7Eh7woj4panwQKdhY4000lWdThc9
X-Proofpoint-GUID: iXJE2-wt696bkeKCCSc58cvKHgJhb2rM
X-Authority-Analysis: v=2.4 cv=N9MpF39B c=1 sm=1 tr=0 ts=68715a3b cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8
 a=nA_d3Nbw2aago_QP_ScA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_05,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 mlxscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 suspectscore=0 adultscore=0
 mlxlogscore=609 clxscore=1011 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507110138

Double perf_trace_event_unreg is allowed causing perf_refcount to go
negative. total_ref_count also goes negative because the return value
of tracepoint_probe_unregister is ignored.

Once total_ref_count is negative, the next call to perf_trace_event_reg
will register perf_probe but will not allocate perf_trace_buf and sets
it to NULL instead.

The subsequent trace_##call() will mem abort in perf_trace_buf_alloc
because memset will be called on the NULL perf_trace_buf.

Gracefully handle the error in perf_trace_event_unreg to prevent
double unregister.

Signed-off-by: Aditya Chillara <quic_achillar@quicinc.com>
---
 kernel/trace/trace_event_perf.c | 8 ++++++--
 kernel/trace/trace_events.c     | 3 +--
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_perf.c
index 61e3a2620fa3c9417ac23cf5a18aeb86e7393dcc..247db88accd88eb0acf3692ea593d576519ce8b1 100644
--- a/kernel/trace/trace_event_perf.c
+++ b/kernel/trace/trace_event_perf.c
@@ -154,12 +154,16 @@ static int perf_trace_event_reg(struct trace_event_call *tp_event,
 static void perf_trace_event_unreg(struct perf_event *p_event)
 {
 	struct trace_event_call *tp_event = p_event->tp_event;
-	int i;
+	int i, ret;
 
 	if (--tp_event->perf_refcount > 0)
 		return;
 
-	tp_event->class->reg(tp_event, TRACE_REG_PERF_UNREGISTER, NULL);
+	ret = tp_event->class->reg(tp_event, TRACE_REG_PERF_UNREGISTER, NULL);
+	if (ret) {
+		++tp_event->perf_refcount;
+		return;
+	}
 
 	/*
 	 * Ensure our callback won't be called anymore. The buffers
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 0356cae0cf74e79075f607bc841df05568688baa..50e0e08b29aa6617a04b191419ad1e587adf69fe 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -530,10 +530,9 @@ int trace_event_reg(struct trace_event_call *call,
 						 call->class->perf_probe,
 						 call);
 	case TRACE_REG_PERF_UNREGISTER:
-		tracepoint_probe_unregister(call->tp,
+		return tracepoint_probe_unregister(call->tp,
 					    call->class->perf_probe,
 					    call);
-		return 0;
 	case TRACE_REG_PERF_OPEN:
 	case TRACE_REG_PERF_CLOSE:
 	case TRACE_REG_PERF_ADD:

-- 
2.34.1


