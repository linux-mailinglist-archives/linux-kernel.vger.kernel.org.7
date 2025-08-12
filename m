Return-Path: <linux-kernel+bounces-764689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F68DB2260C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 13:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E3E17B72F9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 11:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3732B2ED876;
	Tue, 12 Aug 2025 11:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="IiWWpGcn"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041F82E62D8
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 11:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754998862; cv=none; b=bQH32WajcvvvqBsxfaJPoX4UOtjJ2Ca/32LDgW0gzWU6n3v4n6s5GOAuo7XN+KSxdP/CyikfSXnyxIuX1Y8bf6O9if1okMWWw4baeYSUhvZ42Lk+vEaolSNBe753yIr8Uz2sbbeSsiLVrjsmGFtnaTziir053Qf/rCjeiY9aIk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754998862; c=relaxed/simple;
	bh=QDEVnIFOpRgQbSJ7F66p3yrRtdHBD9mJdaDei1IK1U4=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Sd4RjnOcEfgeWERGs39tYceDiMsO91nts+9lTEr4pgvc7bJHcO6ZeuKhrxeQwUBtcgaXYZYJhyH/OUCuDbQxvZ8xup5V7dKK0chWhuaoW9UA8BjzMK8Uze7Db168SVTtImxQ7pHCWvrzrAoLlnNUwJV/nMt1X/+YW+W3AyiSmuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=IiWWpGcn; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57BM1C7K021106;
	Tue, 12 Aug 2025 04:40:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	pfpt0220; bh=QDEVnIFOpRgQbSJ7F66p3yrRtdHBD9mJdaDei1IK1U4=; b=IiW
	WpGcn9mi42DRx0DDeQW8/wY6gDQXxkZ7+uZPxRCC7tHsaJzIom6WMbU9H5oqNIRl
	DUIDmZ8/Unu4bmKfXGio0wfFGTgmHPxLzCZxEIpOqSOLAzuwkIAVlik9p2/uPwGt
	P7P+tm6sQ+/ogofferwetCU8LwPPb+iXu23mLcPFO5UMmR5HPRgVssmjFKuUwQ5x
	s1yNwOjTHqy3Cxr2m9xSPsICseLXaAG2Ok0jMxV/ymFY1lakjYVYltoUGRood59m
	51QW082vIVU9tOzde4f7AADQDrVBGxsU5lgr1RCI4oJe+gMAcx9oK5ZzWRcpxHQK
	/yXZnD4v7hsYd/LjIJw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 48frxm9f23-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Aug 2025 04:40:41 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 12 Aug 2025 04:40:43 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 12 Aug 2025 04:40:43 -0700
Received: from opensource (unknown [10.29.8.22])
	by maili.marvell.com (Postfix) with SMTP id ADD023F709F;
	Tue, 12 Aug 2025 04:40:35 -0700 (PDT)
Date: Tue, 12 Aug 2025 11:40:34 +0000
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
        <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
        <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
        <vschneid@redhat.com>, <tj@kernel.org>, <jiangshanlai@gmail.com>
CC: <linux-kernel@vger.kernel.org>
Subject: Query regarding work scheduling
Message-ID: <aJsoMnkoYYpNzBNu@opensource>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDExMiBTYWx0ZWRfX6PMjv0a6ahnn jvNj3CY49pC9h8CMWlYCf97sDzlc8dwgIorPMT59XciMtDLHf7puZ/+MDMAtyibcJnDKEkoj5S+ 7LjXAsSUpcJADQ1a18rAp2KXpqkJWVo+eTDFgI7Jn/cxiQTn9FsqXpl397FymDIyuEXFBClxef9
 5f0702d3T9F51xzC6s53O+bdrTMv+wKqzrP6KGYP4ci2LoGLxQ1XnfZKD5ebPy3rfxiH7sjG6KN LZVo5fWXqDChLp7WvR48AMDL5BY7k7gEh2GD+QCBE4iXmLY/7b8C7gxyakTN4gBinKR24tNeTY3 Z0Dp+dCH4sUXU3iuRK/lpGsMCH0xEMju30RRKJlrDLwtRWlfmRMGwtLly+eS7tdgJsJPA6IzGJE
 I/wUh7r6RoUcINelFNuU/DDNj1bt1TTqjNJkk7WrqHOzloNsIji0a7iOZK9Gs4Dt+HqOc12v
X-Authority-Analysis: v=2.4 cv=eKQTjGp1 c=1 sm=1 tr=0 ts=689b2839 cx=c_pps a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=p-_z3_PlOOELHAIJOVoA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: wdKJ41bwX_icAPto2JO5QAHU1BRHq_5X
X-Proofpoint-GUID: wdKJ41bwX_icAPto2JO5QAHU1BRHq_5X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_06,2025-08-11_01,2025-03-28_01

Hi,

One of our customers reported that when their kernel upgraded from 6.1 to 6.6 then they
see more delay in their applications shutdown time.
To put in simple terms, dataplane applications are run with SRIOV VFs attached to them and
apps send number of mailbox messages to kernel PF driver (PF receives an mbox interrupt).
During interrupt handler work is queued and messages are processed in work handler.
I calculated the latencies (time between work queued and work execution start) of 6.1
and 6.16 and below are the observations


6.1 mainline
------------
Total samples: 4647
Min latency: 0.001 ms
Max latency: 0.195 ms
Total latency: 7.797 ms

Latency Histogram (bucket size = 0.01 ms):
0.00 - 0.01 ms: 4644
0.01 - 0.02 ms: 1
0.03 - 0.04 ms: 1
0.19 - 0.20 ms: 1

==================

6.16 mainline
-------------
Total samples: 4647
Min latency: 0.000 ms
Max latency: 4.880 ms
Total latency: 158.813 ms

Latency Histogram (bucket size = 0.01 ms):
0.00 - 0.01 ms: 4573
0.03 - 0.04 ms: 1
0.19 - 0.20 ms: 1
0.70 - 0.71 ms: 1
0.72 - 0.73 ms: 1
0.92 - 0.93 ms: 3
0.93 - 0.94 ms: 1
0.95 - 0.96 ms: 2
0.97 - 0.98 ms: 2
0.98 - 0.99 ms: 6
0.99 - 1.00 ms: 8
1.00 - 1.01 ms: 14
1.08 - 1.09 ms: 1
1.41 - 1.42 ms: 1
1.79 - 1.80 ms: 1
1.80 - 1.81 ms: 1
1.81 - 1.82 ms: 1
1.92 - 1.93 ms: 1
1.99 - 2.00 ms: 1
2.34 - 2.35 ms: 1
2.61 - 2.62 ms: 1
2.99 - 3.00 ms: 1
3.14 - 3.15 ms: 1
3.62 - 3.63 ms: 1
3.70 - 3.71 ms: 1
3.71 - 3.72 ms: 1
3.75 - 3.76 ms: 1
3.87 - 3.88 ms: 4
3.90 - 3.91 ms: 1
3.91 - 3.92 ms: 2
3.92 - 3.93 ms: 2
3.94 - 3.95 ms: 2
3.95 - 3.96 ms: 1
3.98 - 3.99 ms: 2
3.99 - 4.00 ms: 3
4.87 - 4.88 ms: 2

==================

As seen from histograms above, latency is more with 6.16 kernel.
Above is tested on uniprocessor system. SMP is fine since work is
scheduled to all cores. Please let me know what is going on and
provide some pointers if am missing very basic here.
I changed only kernel images. Application and rootfs are same in
both cases (to ensure no additonal daemons or load in 6.16 case)
Let me know if there is any knob in 6.16 to have same
behavior as 6.1.

Scheduler features of 6.16 are as below:
# cat /sys/kernel/debug/sched/features
PLACE_LAG PLACE_DEADLINE_INITIAL PLACE_REL_DEADLINE RUN_TO_PARITY PREEMPT_SHORT
NO_NEXT_BUDDY PICK_BUDDY CACHE_HOT_BUDDY DELAY_DEQUEUE DELAY_ZERO
WAKEUP_PREEMPTION NO_HRTICK NO_HRTICK_DL NONTASK_CAPACITY TTWU_QUEUE
SIS_UTIL NO_WARN_DOUBLE_CLOCK RT_PUSH_IPI NO_RT_RUNTIME_SHARE NO_LB_MIN
ATTACH_AGE_LOAD WA_IDLE WA_WEIGHT WA_BIAS UTIL_EST NO_LATENCY_WARN

Thanks,
Sundeep

