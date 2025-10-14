Return-Path: <linux-kernel+bounces-852313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E941BD8AD0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B77B548398
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 10:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6DD305958;
	Tue, 14 Oct 2025 10:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XCYO3Kxv"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AE92FE580
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 10:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760436249; cv=none; b=EcE5znP62SF2jm7cD/kZbDVCrVxGHlzcpxlZiG7fNsUYkY2E5nNWmXAuOe7Na1aER4zsp0AiTg9Oi/+dxjLdAenV5l+84JlaNMcuQpf/B/4OcGflJyxBV6l0fp/aMPCihsh4drGERMIpc3yGPBMMKoFbZS2p9GUoSyEGDQguSo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760436249; c=relaxed/simple;
	bh=/A/5z2rLDttpZz4Yf97JVAzaahcS14gJUuHXKw8FYsw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Srz5/w5Ld9j5gPFRzK2pYylu5pbdSM7nKHtFfCwSjFY9CPd7daYMCcPHG1gclHNXTjGRbodLn3ZJK+2cvSG7lyEaSCMvOWZGbEHYDccW3gzO9kbGaYlpTJRu7aT05PqEab+C36CmxdCSGccKLqHN6nfR7dhvoJNaRG+DECy6fVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XCYO3Kxv; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59E1XnOL006319;
	Tue, 14 Oct 2025 10:03:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=JXooj/zZVBd1B5ycaMeR8rFKXWYWTTQTJjrMEhHJv
	uw=; b=XCYO3KxvJZZL3IeU2dUfkgSt0sXPBL6EfpNDB25uSfMKRJzAHCSUZtlT3
	0VDVsJ8iS1qqtmdgfDfhG1x8DtX5sKR+GU5HdH1bIyWEiJdbAWv4dXxaeHPQJIE9
	wI9gjqtEw9bXVX+Mvu3xe6+zWHZNotp9HvB9TAEHXuzyVq8OHdOAEKrZLRtItMTa
	iPgtXP0PHels5pSGu5QCwXpPPZ4hkImNOL+UfHc+UVXPC3hIp8g6BonDFsurpbf/
	KGjv9HJx2VbAhNVqpEK1mYQ65SylCCod3ZJoQbhAFhLu8z2kA81MvGqsWwONcNE5
	vF5U3VlIov9A6Top8kvk+gRp1XhBQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qdnpdk8a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Oct 2025 10:03:54 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59E7oRcC016756;
	Tue, 14 Oct 2025 10:03:54 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49r32jt7g3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Oct 2025 10:03:54 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59EA3q0H51052854
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Oct 2025 10:03:52 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 51DB5200AE;
	Tue, 14 Oct 2025 10:03:52 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1373C200AD;
	Tue, 14 Oct 2025 10:03:50 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.39.23.219])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 14 Oct 2025 10:03:49 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: peterz@infradead.org, juri.lelli@redhat.com, mingo@redhat.com,
        vincent.guittot@linaro.org
Cc: sshegde@linux.ibm.com, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        dietmar.eggemann@arm.com, nico@fluxnic.net
Subject: [PATCH 0/2] sched/deadline: minor code cleanups
Date: Tue, 14 Oct 2025 15:33:40 +0530
Message-ID: <20251014100342.978936-1-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAwNSBTYWx0ZWRfX8y6oABGrQUNa
 jflCYTfFYhlRe3n1X7cEFGf5cqWRQIODFJOzOp3lvWYeYvUV3TCw5oo42bMn/XZxWi9nbxOkJfP
 PVXmneFtZYmurIDdOlkgpWhgH91zKLFLE9qIfTAWQxBsZukTDo0/9OIfGXw3X9P0sDAth2EGY6n
 P/T08H43rM0KNUoJn7Fve3ko7qAWJImltNNaVKUPanKfTqzAbnO1zLZM3teKM59iByMfs7l+WMf
 K+mwAkk1yAwd61mH16d4fI6t79+1w0zwbiK1KAg0te8aQmmG3WR/qzHE1w75eObBORHOMl6NVTS
 en6og60kXdt9I8bQUaIOekf7UVVLo/ayyykkjLJGsiQxb5J+aX3iglmZRz08ACMqpE+vgBiVhFF
 h4YYfa4bE+cfhSKVsGzwUdUozJmovQ==
X-Proofpoint-ORIG-GUID: oGL3qmllGYbFEVwxfQZzu5EKf-0M-b00
X-Proofpoint-GUID: oGL3qmllGYbFEVwxfQZzu5EKf-0M-b00
X-Authority-Analysis: v=2.4 cv=MoxfKmae c=1 sm=1 tr=0 ts=68ee200a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=AGApWG6EFqRsq9RNHTYA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 clxscore=1011 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110005

While trying to understand the dl_server changes, noticed these minor
code optimizations/cleanups possible. 

Let me know if these should be squashed into one patch. Kept is separate
as of now.

No change in functionality. Could save a few cycles.

Shrikanth Hegde (2):
  sched/deadline: minor code cleanups
  sched/deadline: Use cpumask_weight_and in dl_bw_cpus

 kernel/sched/deadline.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

-- 
2.47.3


