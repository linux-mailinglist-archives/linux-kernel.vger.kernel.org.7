Return-Path: <linux-kernel+bounces-728156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3632CB02402
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 20:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBED8540152
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9357F2FC3C6;
	Fri, 11 Jul 2025 18:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nk/xfI7A"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C097B2F3C13
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 18:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752259136; cv=none; b=L46nGgIQPvdrvqSngxjPpQCWmPLQackYI7YD3nesxRsM58+KY+u3LFIjgLHkzvrer+1pEnGkQh4cdagH1ndzMGE33dcGpIALue1hifecgEoVDct2aSOqb/vbAXowq5Kj9GQt73xbX9hEhlFi3JIz0AujD8+iJlEE4dQiNC1h0PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752259136; c=relaxed/simple;
	bh=k6/nYX+L5Uiqma8PSaRi5fhgx96TOIleEh+r07CrN/8=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=ZM3+85r8Pw2hC6uPz8dm3J/SGsgD1cdASoTGbd6cUOxbNW+LzIQxlpQwLUmv82G0HA0dlYs/LC0J7PmPBvH/7KL1bnMGXzPKRD8uXZLBOQiKjefxTwkotNLvUI+SlhFm7E9wFWuLm8LTxTNWro1zcpWFiJEiwlzWdQlqocAzIYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nk/xfI7A; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BB2OD8007058;
	Fri, 11 Jul 2025 18:38:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=JVydeG3MvF/As8ldMd4ivq
	uXQxJdjd4Weuau4SpjlPE=; b=nk/xfI7AD+s1Kp8ZVTx31KlvlKt+wzZtA/02R5
	VJzXHxH4Hsorg3NNIjnaNGQzDnuagVBx7F/eLtqmohwfGcAr+jG/9bBKtY95xEYj
	QTm3yLDQRRdaBaxAFx7XLX9PoO6ZGTyhsFmm66C7S3u8yjw6oPjImarb9I3GKMbn
	lUB5NPo2Aaxqn/WJekFj1ZzIwfAGdsl502ad6FVdKKn6l62eRWT7CB+fyoRnvoL5
	Sqn7vnT5+JtB7y6asK5Xpye0tJNA+3RvD6ELwxcfA6se2FbDsi1J1o0H48L/dIvr
	jAqtD0P8GHI4mWpZeiiA+k/z5315q6Q8nFtdmdCRMbxdTkWg==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47u1c597n8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Jul 2025 18:38:49 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 56BIcmo0027373
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Jul 2025 18:38:48 GMT
Received: from hu-achillar-hyd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 11 Jul 2025 11:38:46 -0700
From: Aditya Chillara <quic_achillar@quicinc.com>
Subject: [PATCH v2 0/2] tracing/perf: Prevent double unregister of perf and
 tracepoint probes
Date: Sat, 12 Jul 2025 00:01:47 +0530
Message-ID: <20250712-fix-double-perf-probe-unregister-v2-0-328b275672c5@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJNYcWgC/4WNwQ6CMBBEf4Xs2TVthQie/A/DgZYFNtEWtkI0h
 H+3knj2+CYzb1aIJEwRLtkKQgtHDj6BOWTghsb3hNwmBqNMoc4qx45f2IbZ3glHkg5HCZZw9kI
 9xycJNrYqK226wmgLSTMKpc1+casTD6kW5L0/Lvqb/uTVf/miUaGxRVnak1M6V9dpZsfeHV14Q
 L1t2wdOBXd50gAAAA==
X-Change-ID: 20250704-fix-double-perf-probe-unregister-ab98912f521b
To: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: <linux-kernel@vger.kernel.org>,
        Aditya Chillara
	<quic_achillar@quicinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752259126; l=3312;
 i=quic_achillar@quicinc.com; s=20250630; h=from:subject:message-id;
 bh=k6/nYX+L5Uiqma8PSaRi5fhgx96TOIleEh+r07CrN/8=;
 b=slijVISpzdkaLcaPyvPQJIxFVEP21zOBesIXRgWNq1jBAYoLtGwdrIxYvSJpkr1TBa4WJrpkk
 uHOqiXE8pT+DSou4bw3Ul62ZuFaPFuBLfOmueY6NVZmHpb8eJ1i/40h
X-Developer-Key: i=quic_achillar@quicinc.com; a=ed25519;
 pk=n9YdZ9C822pphDmKHNwLKAFOJBiDCIOL/n1Mzy7/lg4=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: DUNvA-0c89LfYG12cocGbAOBAEuIDVIn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDEzOCBTYWx0ZWRfX9Ud5sF+XVpRv
 kRwA2+D/JwwNGGbPt5vI9f/JlakE3XI3hqUqsd6MGqepQS4g2uQlZsJRgadkUY78bK4v5ZkpktW
 wUggEdd2sxIlyX+ar5znbBrybLCpCQAvHi344d2rneZUJ0ddmvHbWCis52X9vP7KNLIAQLsoi2e
 uw5G/vOyukBTFTXIDHMxnTm4jYjDiv2p+7nf0QU6M2JjqT2pcJkEWqdpj4LQo5uNgSVy2fI7lfI
 Xy7nUsX6zk+bJxwfdqlf5Y9xupDYeWoHeMI7AzZ4Q5wPJ2e7d+nWL7HFyoN//v6lrJMzIb69RkY
 4HAHANLmNVd9TYztduTdZnHkOcxFIONZmEfC6bC7sgHGrosk8yORe9gXBNQmwwFkWKqaJw8xFv/
 55iOsMaph0eTTqb32AKXN4x7Fnu/5eSbahT6ehXT6vifv3r4bCSraUTHndZ5p4KYtagzB9/S
X-Proofpoint-GUID: DUNvA-0c89LfYG12cocGbAOBAEuIDVIn
X-Authority-Analysis: v=2.4 cv=N9MpF39B c=1 sm=1 tr=0 ts=68715a39 cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8
 a=COk6AnOGAAAA:8 a=j8Ow4tO7Sss0TC48ArMA:9 a=QEXdDO2ut3YA:10
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_05,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 mlxscore=0 bulkscore=50 impostorscore=0
 lowpriorityscore=50 spamscore=0 malwarescore=0 suspectscore=0 adultscore=0
 mlxlogscore=368 clxscore=1011 classifier=spam authscore=0 authtc=n/a authcc=
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

tracepoint_remove_func returns error after the warning:

[  111.552262][ T8418] WARNING: CPU: 4 PID: 8418 at kernel/tracepoint.c:405 tracepoint_probe_unregister+0xb0/0x468
.
.
[  111.552831][ T8418] CPU: 4 UID: 1779017056 PID: 8418 Comm: trinity-c19 Tainted: G        W  OE 6.12.23-android16-5-maybe-dirty-debug #1   2362fed3965ed146e5e20aa901c0fae1990ed57d
.
.
[  111.552881][ T8418] Call trace:
[  111.552882][ T8418]  tracepoint_probe_unregister+0xb0/0x468
[  111.552885][ T8418]  trace_event_reg+0x5c/0xa4
[  111.552887][ T8418]  perf_trace_event_unreg+0x58/0xd4
[  111.552889][ T8418]  perf_trace_destroy+0x5c/0x94
[  111.552891][ T8418]  tp_perf_event_destroy+0x10/0x20
[  111.552895][ T8418]  __free_event+0x90/0x154
[  111.552896][ T8418]  perf_event_alloc+0x478/0x684
[  111.552898][ T8418]  __arm64_sys_perf_event_open+0x278/0x7d8
[  111.552900][ T8418]  invoke_syscall+0x58/0x10c

and then mem abort on trace_##call():

[  189.790824][    C4] CPU: 4 UID: 8388678 PID: 8422 Comm: trinity-c23 Tainted: G        W  OE      6.12.23-android16-5-maybe-dirty-debug #1 2362fed3965ed146e5e20aa901c0fae1990ed57d
.
.
[  189.790862][    C4] Call trace:
[  189.790863][    C4]  perf_trace_buf_alloc+0xb4/0x104
.
.
[  189.790894][    C4]  trace_preempt_off+0x138/0x140
[  189.790895][    C4]  preempt_count_add+0xa8/0x13c
[  189.790897][    C4]  copy_page_from_iter_atomic+0xa4/0x7e4
[  189.790900][    C4]  generic_perform_write+0x170/0x350
[  189.790904][    C4]  f2fs_file_write_iter+0x268/0xb64
[  189.790908][    C4]  vfs_write+0x340/0x3ac
[  189.790910][    C4]  ksys_write+0x78/0xe8
[  189.790911][    C4]  __arm64_sys_write+0x1c/0x2c
[  189.790912][    C4]  invoke_syscall+0x58/0x10c
.
.
[  189.797921][    C4] ---[ end trace 0000000000000000 ]---
[  189.797923][    C4] Kernel panic - not syncing: Oops: Fatal exception
in interrupt

Fix the issue by preventing double remove in tracepoint_remove_func
and gracefully handling the error in perf_trace_event_unreg.

Signed-off-by: Aditya Chillara <quic_achillar@quicinc.com>
---
---
Changes in v2:
- Updated the tracepoint patch to add the cleanups suggested.
- Link to v1: https://lore.kernel.org/r/20250709-fix-double-perf-probe-unregister-v1-0-2b588b3c0140@quicinc.com

---
Aditya Chillara (2):
      tracing/perf: Prevent double unregister of perf probes
      tracing: Prevent double unregister of tracepoint probes

 kernel/trace/trace_event_perf.c |  8 ++++++--
 kernel/trace/trace_events.c     |  3 +--
 kernel/tracepoint.c             | 15 +++++++++++----
 3 files changed, 18 insertions(+), 8 deletions(-)
---
base-commit: 70575e77839f4c5337ce2653b39b86bb365a870e
change-id: 20250704-fix-double-perf-probe-unregister-ab98912f521b

Best regards,
-- 
Aditya Chillara <quic_achillar@quicinc.com>


