Return-Path: <linux-kernel+bounces-722818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 277FAAFDF5B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 07:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 034A13B8EAD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 05:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B66626AAB7;
	Wed,  9 Jul 2025 05:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="m9eV+5e+"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB061EEA40
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 05:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752039718; cv=none; b=cNpIWlixFOEVMy6V2CEK4gAxYhMF/n09RI7W03rkq4yHFsOt2J5C5hyDd1upctF14gjLQC93/O+c0mIksZTWyJofFhZp8LeROoBY1AdlAflniuVU2wSKa8p2fgcnl++iJWmVpO2gdPMVNkpvNCARnjrhm6Ioi9p7FFbkQrZTLf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752039718; c=relaxed/simple;
	bh=L3kmTbG0zYoKPiGmvkzgDQQrMbirCPt/C/YZYr1Kbz4=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=C283afxXGxKsHI5wMHRu/8pF8xIXPX8gK+/wTPI2l3AJB/snKSgMBPev6XN2X2zQLXReCtHMdifVoH0yGhSX/1OCkL/jSy837OKQ1OKx63UntvyRJdljGJZFKZDc5k9SzTDF9UUTrMT02gN8JONjLPTM3B6T/tLZB2xbZN3VVag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=m9eV+5e+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568MwC7Y018872;
	Wed, 9 Jul 2025 05:41:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=P21n8af/E+fy5rZIw+jwu4
	o+p3kvQXSzN4R5qbFxXI4=; b=m9eV+5e+qnCIr9cC+s+6X6PIpoQJlG613CQXXS
	jzB185Wg5j2G0upCGV6tx+PyDbQmV/mthkdJbJlFaWJ5T1/ZRunq2T9L7NQZZ0Au
	NgWINek0h2aTLOMqH8mOw2w++CjWHPxiupU+9eya/C1O5HvjJD9uFpG1fyMX62Ya
	2B3k5GfhZzRWl2tkDIPDuqYFb/rKmCFSh9hfgOcswJOzcjpBGnUDPqg1ISZUz2fN
	sbenw9h1XKC7DQRtKvWgwWJUFlTtKagnhaTecNdqDPTrYoD5Szq3DB26bYj6LB/w
	/jt0xc6eQZ6iialoRB5K2TBxNatZzRh7XHERlcoCNdJHq4Bg==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47pucn3882-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Jul 2025 05:41:49 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5695fm1h032083
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 9 Jul 2025 05:41:48 GMT
Received: from hu-achillar-hyd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 8 Jul 2025 22:41:47 -0700
From: Aditya Chillara <quic_achillar@quicinc.com>
Subject: [PATCH 0/2] tracing/perf: Prevent double unregister of perf and
 tracepoint probes
Date: Wed, 9 Jul 2025 11:11:08 +0530
Message-ID: <20250709-fix-double-perf-probe-unregister-v1-0-2b588b3c0140@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPQAbmgC/x2N0QrCMBAEf6XcswdJsGj9FfGhsZv2QJJysaKU/
 LunjwO7MztVqKDSpdtJ8ZIqJRv4Q0f3ZcwzWCZjCi707uSOnOTNU9niA7xCE69aInjLilnqE8p
 jHM6DD6kPPpJpVoV9/onrzXixWdHPr9ha+wI4jvC7gQAAAA==
X-Change-ID: 20250704-fix-double-perf-probe-unregister-ab98912f521b
To: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>
CC: <linux-kernel@vger.kernel.org>,
        Aditya Chillara
	<quic_achillar@quicinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752039707; l=3109;
 i=quic_achillar@quicinc.com; s=20250630; h=from:subject:message-id;
 bh=L3kmTbG0zYoKPiGmvkzgDQQrMbirCPt/C/YZYr1Kbz4=;
 b=DdwRhP4shILy2G13gl2gOJAGgpvL5qaTH5TDqxPagvwhDEJ3BjAgqVP4tfeDBDnvp6Is6B8S4
 bSd2di9ah85CpCT59Jq2ONmfLT5E/G3ieP4PO6pYt0+jS6dLA7nyBhy
X-Developer-Key: i=quic_achillar@quicinc.com; a=ed25519;
 pk=n9YdZ9C822pphDmKHNwLKAFOJBiDCIOL/n1Mzy7/lg4=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=GdQXnRXL c=1 sm=1 tr=0 ts=686e011d cx=c_pps
 a=JYp8KDb2vCoCEuGobkYCKw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8
 a=j8Ow4tO7Sss0TC48ArMA:9 a=QEXdDO2ut3YA:10 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 8f47EfbvN3rcp3IutRuUGio47gSdmn0V
X-Proofpoint-ORIG-GUID: 8f47EfbvN3rcp3IutRuUGio47gSdmn0V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDA0OSBTYWx0ZWRfX//KNV29prtiY
 1ch8ATt01Wj11CQkcTJiWA2dirX/dUBaOTXlfE8VzfodbOU7+rBQM6WTQfAjiB0LXgfxu2rGr/W
 KhTJjZFobUv3s4eKHRYQgqj9No+R3XaeE4YSr3Ktdu7OtHQLERIazncXBtbEtmHUKtecrt6DcTe
 EeOrld4H3ET1agmXuFri58EmTvGkhCMQob2TylqQXy6p/xuBOC7Z0pYwBBGTH3zvTPrvHp0H9JP
 3b8diSNQRiIYzOosaXM0QMUCL1K85MJ+u7ZNvQVRU1Rsj3ReGFnDAcR0aBdavtYJqn1anTPmHi7
 I8w1RJHrBO1F+wmkDPgKM1cKYx4GxeEgkaii+Ry5dMnmoZB3bqtgs3WHvZO/AP8IBZDTiL5HzUR
 gfVx6l/MeYS2Iso7vIHSBTxweF9gHBiZND2wuC6ucobZ7IF6RF76U0Jb+z/cS2tVCZ+HYmIu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_01,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=1
 lowpriorityscore=52 phishscore=0 adultscore=0 bulkscore=52 clxscore=1015
 spamscore=1 suspectscore=0 mlxlogscore=199 priorityscore=1501 impostorscore=0
 malwarescore=0 mlxscore=1 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507090049

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
Aditya Chillara (2):
      tracing/perf: Prevent double unregister of perf probes
      tracing: Prevent double unregister of tracepoint probes

 kernel/trace/trace_event_perf.c |  8 ++++++--
 kernel/trace/trace_events.c     |  3 +--
 kernel/tracepoint.c             | 11 +++++++++--
 3 files changed, 16 insertions(+), 6 deletions(-)
---
base-commit: 70575e77839f4c5337ce2653b39b86bb365a870e
change-id: 20250704-fix-double-perf-probe-unregister-ab98912f521b

Best regards,
-- 
Aditya Chillara <quic_achillar@quicinc.com>


