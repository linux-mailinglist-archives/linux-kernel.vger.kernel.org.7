Return-Path: <linux-kernel+bounces-742048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79723B0EC62
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 09:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 265023A85D5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 07:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E903D277C9A;
	Wed, 23 Jul 2025 07:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Hc90CJx/"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF561274B3B;
	Wed, 23 Jul 2025 07:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753257121; cv=none; b=E4+TH73U2/P46YhNrbSTqoagZnedCUVDqfPE89vJNZxsVj5ldQhP9aQFXdRrEiQhuOaFkMFRUyDZw3SdkOPYNDomb+cIkqwDuPVm5E+DISBI0p3cmOHjaBRJoN+TleJVMIcYYqRsAIsYbLJMH7IjxDB9j/XctPNUa1HtDTE636w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753257121; c=relaxed/simple;
	bh=zw1STi0lPoyoRIXR6telLdKLBhhkkjpnUKh9MBBnVFc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Az2enikJIb82g0hpk55ciJwx1xC6puM2ml+qXrySjeLXBUTa2oMPaU1KdZIhvMM3g3Mvx8aZSH/3umRbiQPJ4dPXxq8JvFiRTtPntX2JNxXQeDVxe1V37MXA1VwWauaviGJKuyhfwiSzUY2cxP6tAIQJxvYmU0PWuI6+IIYxxfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Hc90CJx/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56N4xP4o013664;
	Wed, 23 Jul 2025 07:51:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=S4ewZR3Eious6hRrAcgTDHckfXzSw0pc8RFOGOSIc
	Pw=; b=Hc90CJx/BSmQSZaPaVf893gAoIPIA84NLjVo/fB5W3STkx0bcGD7+bkJu
	m5tFeH2r03crb19baX32ilyIAuUEmRLN1jsJPqZaXFUOaAJSYI0qHFR3IlGe2QgB
	hvscaAgRrzPJ/APthJvXxz/+2bY/RIevHipAZQTuij0VRxgoHW2fOf3dd3T8RyXM
	IYLpg4jPB2kH/6vZyoI6vIHiiGvmkmrIXH5xTuglSmAyAZmvK6LHdmFkk6x0IUbk
	tDu2i/WKtjaKC7ReHLv1LHyLTdmAtobkpEAqRh9L0frr2RaJw9bYSvHSrOrk0Vfm
	ILHvP/iGwgeJo8FAsmn6cOOCkm4Hw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 482ffqbe4v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Jul 2025 07:51:52 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56N3eDkB004735;
	Wed, 23 Jul 2025 07:51:51 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 480u8fx1yv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Jul 2025 07:51:51 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56N7poWj31195678
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Jul 2025 07:51:50 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0EDC85805B;
	Wed, 23 Jul 2025 07:51:50 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7EDF158059;
	Wed, 23 Jul 2025 07:51:47 +0000 (GMT)
Received: from jarvis.j0t-au.ibm.com (unknown [9.90.171.232])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 23 Jul 2025 07:51:47 +0000 (GMT)
From: Andrew Donnellan <ajd@linux.ibm.com>
To: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Saenz Julienne <nsaenz@amazon.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH] Documentation: core-api: entry: Replace deprecated KVM entry/exit functions
Date: Wed, 23 Jul 2025 17:51:34 +1000
Message-ID: <20250723075134.105132-1-ajd@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDA2NCBTYWx0ZWRfX10HM08yGjH8d
 XoMpZSrcsZsEIpyxbgF9JAZHRRtxmigqjPeHZpTfYYuv+Vqay1BcKJXv/f/Te1+BBPm0gjyvVMz
 PexHjh9W5UpwBZEbDoYejeXiWQNb8Cfwmoxg/6tEXMpnNdFnx4IeF6G3yGzh6jMMN4N7B/XaDMz
 tGv+BafhVvcLk15vyMWgtFbLRg868q5SfXGmc62Z2TNqLr5iufxTMSoxYEQ0dKlRCoOGUrVk0Kh
 ANHr2s24KtukdPuQ/PWXxfVz7/t4Ut9lREgbwHyrCVoHX7Kkl2rOTO1jYDO98Aber/sqTKZSLfl
 0nNkIj2G4QuEMoUYmdsD6Jfjm2kIcIBAbEptq79whjXvop9SiihvPH5ZGotgEFaH7GGh/mGRyvW
 0tFrIm5xsuT85mhxoNyQ9IEwa84BLxbaVguuvyHfqjmnQDx+b0P17mi0VUVl7tUEOIrOVZz4
X-Proofpoint-ORIG-GUID: -kOmI1F7v1YOGjV2LkgiUX7mkgYTtQ_3
X-Proofpoint-GUID: -kOmI1F7v1YOGjV2LkgiUX7mkgYTtQ_3
X-Authority-Analysis: v=2.4 cv=eqvfzppX c=1 sm=1 tr=0 ts=68809498 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Wb1JkmetP80A:10 a=vggBfdFIAAAA:8 a=7CQSdrXTAAAA:8 a=VnNF1IyMAAAA:8
 a=mKjUxEumf1aeAB0LphwA:9 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_01,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 clxscore=1011 suspectscore=0 bulkscore=0 impostorscore=0
 mlxlogscore=982 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507230064

The x86-specific functions kvm_guest_{enter,exit}_irqoff() were removed
and replaced by the generic guest_state_{enter,exit}_irqoff() in commit
ef9989afda73 ("kvm: add guest_state_{enter,exit}_irqoff()") and commit
b2d2af7e5df3 ("kvm/x86: rework guest entry logic").

Update the references in the entry/exit handling documentation.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Nicolas Saenz Julienne <nsaenz@amazon.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Andrew Donnellan <ajd@linux.ibm.com>
---
 Documentation/core-api/entry.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/core-api/entry.rst b/Documentation/core-api/entry.rst
index a15f9b1767a2..286a5ecf7cae 100644
--- a/Documentation/core-api/entry.rst
+++ b/Documentation/core-api/entry.rst
@@ -115,8 +115,8 @@ Entering or exiting guest mode is very similar to syscalls. From the host
 kernel point of view the CPU goes off into user space when entering the
 guest and returns to the kernel on exit.
 
-kvm_guest_enter_irqoff() is a KVM-specific variant of exit_to_user_mode()
-and kvm_guest_exit_irqoff() is the KVM variant of enter_from_user_mode().
+guest_state_enter_irqoff() is a KVM-specific variant of exit_to_user_mode()
+and guest_state_exit_irqoff() is the KVM variant of enter_from_user_mode().
 The state operations have the same ordering.
 
 Task work handling is done separately for guest at the boundary of the
-- 
2.50.1


