Return-Path: <linux-kernel+bounces-722817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C26EAFDF5A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 07:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C640C56750C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 05:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ABB126A1BE;
	Wed,  9 Jul 2025 05:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="K7DsPA6d"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2E925EF89
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 05:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752039717; cv=none; b=D5VrPgeNXlLKD0SDxonXQG/wJ1Nz0nWSpc/j5/0wcHeqOr8OLum3G898fkfSw+VX6T35K2JBsJd3i5G/oo2oUTLXosVXfcS6FOo3pYThvA8wsfP+FZeuksjDNawNLHm5xkqoaTjgfNSEr/xZ9WyTcWGfiiWIpRWbWz2ouvO++/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752039717; c=relaxed/simple;
	bh=h4W3cQp+TtmS0aGmcxVT5XdwRqSpxAq9CwXvrr3v8JQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=f5KELOv2q9qqXAHMrGPAp5K0Q9b9ixXJT3sNN4kMOaXn0D/t/wxf2nCVOGqcX20gV9mIkgTDjLyDa3ilXb40AE5nLEHUjLmIy/jFFJpLrAX9H2OtcNCrbY7osplaGDr4nw3SRyN9IN1Y3wI/nXRH6mOeJ6vrVD06ugOnJSVz8Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=K7DsPA6d; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568J5FxS000495;
	Wed, 9 Jul 2025 05:41:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dVm2mEmkYwfztpM3N9zWYd/1ThH+3xOMrRcm7lERDx0=; b=K7DsPA6d21NR+VhH
	HCcRvxzrde9NxrTMPoQZqmAJODFgLW8dZah0p3JjaQXaboTb8Rr4SKsutMqwUCX6
	fGl34tGWiYrfcPQZB8QlLXjH4ezyEKjx7br4TJh/F4cAHMpUU4Ndhfwb2Vg1duDn
	UpgZoQEPQu1BoiWcVAsNo+EDlw6iaIVnHZO9/SD8VClTfY/Ga2s1Q1SmBIppt/wr
	7Suvcbp5YhWrxzcRkYb50OMd09rjeo8lCLUAB13C+t8BaKCWTOW4eAgwbZgtMjib
	7AhGQ9kK0dM98xtOreNsSJkzT4iyF63HOaONlW4m6zMTdU5zUAoZOIwGCl+3H7pq
	hLyBVA==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47psrkttcs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Jul 2025 05:41:50 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5695fo3v006351
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 9 Jul 2025 05:41:50 GMT
Received: from hu-achillar-hyd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 8 Jul 2025 22:41:48 -0700
From: Aditya Chillara <quic_achillar@quicinc.com>
Date: Wed, 9 Jul 2025 11:11:09 +0530
Subject: [PATCH 1/2] tracing/perf: Prevent double unregister of perf probes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250709-fix-double-perf-probe-unregister-v1-1-2b588b3c0140@quicinc.com>
References: <20250709-fix-double-perf-probe-unregister-v1-0-2b588b3c0140@quicinc.com>
In-Reply-To: <20250709-fix-double-perf-probe-unregister-v1-0-2b588b3c0140@quicinc.com>
To: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>
CC: <linux-kernel@vger.kernel.org>,
        Aditya Chillara
	<quic_achillar@quicinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752039707; l=2268;
 i=quic_achillar@quicinc.com; s=20250630; h=from:subject:message-id;
 bh=h4W3cQp+TtmS0aGmcxVT5XdwRqSpxAq9CwXvrr3v8JQ=;
 b=9TJMXIaOsVLK95Q4G9K0Dp2gOGYJbPMGOohxFKH4BAKAZMWcARDIjHqSHqxY/735gb3ZWvWx+
 f4iEGBXmbYPB+lcjz5gqqxeNdh8zbSxvHTQ6Cu2TNwpiBhEQkEu+YES
X-Developer-Key: i=quic_achillar@quicinc.com; a=ed25519;
 pk=n9YdZ9C822pphDmKHNwLKAFOJBiDCIOL/n1Mzy7/lg4=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Nh5qEpGY224x6RKI3FiQJghdmEOfoxsI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDA0OSBTYWx0ZWRfX+GihBuuF0d5K
 PFKPT68FRWIoYQNj1XhganIPTKuhW+ifQnzhICcGoEde5zKuoJz0Xdcy/nLluL40z828qedKRNC
 9GMqhswVr6bTuqEC1he2XhvkiBidYh/WX7IFPnFNwppJxhp+Xusxf05P4TKJiLUe4G0BHVcsKf4
 XahazUI5t1/2nd11Ol75UYiIPK/MQ1yU77hB623HCXwccgSymvFhINwZXveYV04ah8qO6uVYLE/
 WJ8k8cPMSVljiZwWgK6CbtNxTSOAXNPbBoVNIkZawZNqcnKX+kHjI4AmIMykTy2O1iDgzqwOZWH
 RZUZTSvGue2y+xWpf6yVN44JYmK5yI2CUCq7vAliQ/wGjLm60x0zZR/QloWgcmsZId4kTX+6DGo
 Le6K1APf11g0pGI1b96q1yhJvWTi85lpufqCDpa2HCLMsb55uFjL7PCJAce/lMnKBaCrSfht
X-Proofpoint-GUID: Nh5qEpGY224x6RKI3FiQJghdmEOfoxsI
X-Authority-Analysis: v=2.4 cv=GtBC+l1C c=1 sm=1 tr=0 ts=686e011e cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8
 a=nA_d3Nbw2aago_QP_ScA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_01,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1015 spamscore=0 adultscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 suspectscore=0
 impostorscore=0 mlxlogscore=608 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507090049

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


