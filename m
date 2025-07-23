Return-Path: <linux-kernel+bounces-742033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD50B0EC2C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 09:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68AB33BDAA1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 07:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E0B277C82;
	Wed, 23 Jul 2025 07:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DcPzTND0"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511FD276054
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 07:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753256703; cv=none; b=JIGdSj3ZpSXEhMh16tuXzdpwUof+47ZtDPnlT++lsAGenMN0fK8X3C0OCUx7z8n6HFFkBYqpmi/SnrhjMdfAnLYVBa97Xlk+BLFQZhRrqT2U5v9DbxciN9P9gOg8QuO5mef8amIWGOcw+KXX9MMwod7tvgW44l/A3GfPhIgPAQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753256703; c=relaxed/simple;
	bh=wLVzSeOhCmIXeKbin1x8rJAoQikyFlpZ8rxvKmALs/I=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=PwydTkeHrUoZRA4/mv0+sCDk/DXeQgChPseO5N03Xlc7UVghv+qdeomyHrO9WPtEPIP+lsHOsYZU4r191LQiXPweVGzlRMLc8DD4nnxDn8/U7K6zvXOCz6kHwGbMEZTGrrGg9fNmVchNBz35Q2ECWL0ZZX1zolXN0Oucfr6tIbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DcPzTND0; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56N61OE3013448;
	Wed, 23 Jul 2025 07:44:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=BY/ZzYWr4cNWW3EQSwOprqiT2o6v
	7aJDfx+9lHRlxRg=; b=DcPzTND0ux3ZdS+Pu8R+TH85QqvG4j6/GeZxgCCg0Ku2
	CZZEy4mNi6v5SqSuuM4SZPr6P1dzY9hVoy1MviMco3BPmk1y/JJHG+wgzcfS3R4C
	2v5mzLQ4OwX1/ReB/dZZjQ+BcpC2nyhzDBgZtzPILgkg9GcfSUvqUF3DKG0Btdkm
	uvktHzoqtgDlPSKdGiwxRDneW81UPhc5/ZVtcetcBvozkQJA9MKwJczxKv57T+g8
	Z/zYMNjN9tTDJPqESjWkG5kY0p6YlKLwYLONS2zVc2zPQwfZ9EUDN0i1FkR9PWT0
	4Sw91zU87vtWZhdfszHbf6NR4HrOPFI3mTCTkuX8PQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 482ffqbcy5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Jul 2025 07:44:42 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56N7iedd024964;
	Wed, 23 Jul 2025 07:44:41 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 480nptq1ws-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Jul 2025 07:44:41 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56N7idSK24117848
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Jul 2025 07:44:40 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C8FE358061;
	Wed, 23 Jul 2025 07:44:39 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 047D858056;
	Wed, 23 Jul 2025 07:44:37 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.61.252.202])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 23 Jul 2025 07:44:36 +0000 (GMT)
From: Venkat <venkat88@linux.ibm.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH v2 1/1] sched: preempt: Move dynamic keys into
 kernel/sched
Message-Id: <1D4FF009-177E-48AF-B236-F64F0FE2DCDE@linux.ibm.com>
Date: Wed, 23 Jul 2025 13:14:22 +0530
Cc: bigeasy@linutronix.de, LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        mark.rutland@arm.com, mingo@redhat.com,
        Peter Zijlstra <peterz@infradead.org>, tglx@linutronix.de,
        will@kernel.org
To: sshegde@linux.ibm.com
X-Mailer: Apple Mail (2.3774.600.62)
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDA2NCBTYWx0ZWRfX3xwWfm5j4UCF
 1dGNgSVL+AOAXDnGeuOctIGb6dfO5h1BZfswLAwsKbm/9LvgrnDFxQ8H/ByKu+RkX1aWhf9zxvV
 W5EEAtcfs8qvXFTw5jvQCAzld3baINRjkJ8jlANiddQyTGLD+6OUzalLjyTCFJzfle6nOtBXfSm
 rERVucX+HeaZiur1mjDA3WadkW5Jwfg8qLI3j7ZeOSLqmLzDWxce3wyePa11/shQ50Hhl6mowB9
 ZWoPxAo1938FvQ7QU7M6YRBXjZD3trLKDNmlpH4MbEyWoGQJHtJOzVAx4bgScQtEKe0XRZ7uVHT
 eRYyVLczAy1J81E5TSA56ESQmCX4/CsskV/K/CCLZjqPA9mFRF1fqlkhplWroSE6kT71MXAdbWJ
 JpgaaM+4Nqq0XAImdndybcV66QDiwFZJS33FY3f5ywlA7Q3RKD6trBCsGEsTXSxxMIdMRcTW
X-Proofpoint-ORIG-GUID: A3poDvbQ0D5r__m3NauW-cBgXowUkeHD
X-Proofpoint-GUID: A3poDvbQ0D5r__m3NauW-cBgXowUkeHD
X-Authority-Analysis: v=2.4 cv=eqvfzppX c=1 sm=1 tr=0 ts=688092ea cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=J52luZ3L32VaiGxZi9YA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_01,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 clxscore=1011 suspectscore=0 bulkscore=0 impostorscore=0
 mlxlogscore=605 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507230064




Tested this patch, by applying on top of mainline kernel. 

Dynamically changed the preemption modes, and its working as expected. Hence,

Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>

Regards,
Venkat.

