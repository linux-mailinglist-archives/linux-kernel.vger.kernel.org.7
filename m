Return-Path: <linux-kernel+bounces-810780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A4CB51F51
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 19:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B4D97BEA28
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 17:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9AB83375D0;
	Wed, 10 Sep 2025 17:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QEVPANdV"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2733375CF
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 17:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757526290; cv=none; b=PYgop0YRubvrCJkxacsE6AMIPBEXsNpZ6GXPaJloDkiip0LwIdS3mAmQNhcPAMhb6dalKPW8Q4rANgUq3p3CIFLJUtbcupqfG5u9CQxGnl3l9Zg8AhIo5nlvp3rroprMbdCIpqEmWsr+6TeZqHkpwGRzZb+iZUBh/K9oOgtfKaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757526290; c=relaxed/simple;
	bh=vXsZaH6gQjd7+ZjVcF0bJ/hj8sb4sf+sH8dG02ouYOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gex9J3YTKMsvmFdb5F/nydVd6mhdWK0hxoANaAIVgFiPnKBpl3bPhzMsSnKG2saJaHdf67Buyz7+RWwPspm+A6iK1e29klFqTfdL3XF8IlU3R3y4mUr3x/0ygpBTxTUnA+6USBHKRUXMGjuEP+moA6q0GBlkhWZuEvqxEljo2Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QEVPANdV; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58AElKSj024268;
	Wed, 10 Sep 2025 17:44:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=4z62H3/dUq5jAYTi2
	vBs82WKWvZqNRrPBP4kbBya9IQ=; b=QEVPANdVCm81fNMqVx0aq5NNJqkUm8hl1
	QjfOskV94E6HuMERG15pITMgjP3Af9amCT8QtVWcn5zQ8Rwr0GCRd6WLBxJzJC1I
	sPDW5ev/FSTDR954RedZOIO/3YAUy+9Yw0O3jnKSdkhM0wBGWM6PX3cZWWyWmX4k
	OWKRLINbfSdJSowcgevPYm/EOIvqfmdBeCso0V30Tw4l/DX4SB/xuoGIONcdn0zO
	rasz3LIbe8x5+iWjmhpERlsEK5ylRsQ5ZtxwGdquEDYIDpC01KIiWISvdpMaaFgw
	GHQFmYcmCkyJkRymj/lCVf6umLyCSr8aNZaSwZVPPeUCZnssJ8NXQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490bcsycp7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Sep 2025 17:44:34 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58AHiYnH007324;
	Wed, 10 Sep 2025 17:44:34 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490bcsycp3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Sep 2025 17:44:34 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58AHRVB4010613;
	Wed, 10 Sep 2025 17:44:33 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4910sn1pb9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Sep 2025 17:44:33 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58AHiTQG49348896
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Sep 2025 17:44:29 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 884A320043;
	Wed, 10 Sep 2025 17:44:29 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8FBBC20040;
	Wed, 10 Sep 2025 17:44:22 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.124.208.171])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 10 Sep 2025 17:44:22 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, tglx@linutronix.de, yury.norov@gmail.com,
        maddy@linux.ibm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, gregkh@linuxfoundation.org
Cc: sshegde@linux.ibm.com, vschneid@redhat.com, iii@linux.ibm.com,
        huschle@linux.ibm.com, rostedt@goodmis.org, dietmar.eggemann@arm.com,
        vineeth@bitbyteword.org, jgross@suse.com, pbonzini@redhat.com,
        seanjc@google.com
Subject: [RFC PATCH v3 08/10] sysfs: Add paravirt CPU file
Date: Wed, 10 Sep 2025 23:12:08 +0530
Message-ID: <20250910174210.1969750-9-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250910174210.1969750-1-sshegde@linux.ibm.com>
References: <20250910174210.1969750-1-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAxMCBTYWx0ZWRfXxx+8TpVUyyu4
 LwXUvqIaAM6dKRZCNw9AiVSdvlEwek6zOAqU+ayp+Y+LmOkey+LOsZMJyQGKOZ0WZpjZZbfTvU2
 I4iciEIBguhNOiwUcW+bc39mTnh7lPN4v5iSfvSfq+dThc/kZKI6idCom7Xa+BwTY74BK7JGUG0
 S+h3+hiiEtqAymMTCPBP+ElbGOt14YzPwBJ6W+Te3LTjLrQMeY/WxHO/44BqACicIpVs+lucUJ3
 mwNZvyUXsynwo6THyWzvsC/tDhaqh1YMv8EqYDW33y54W2rd0q136tiGDRLGkLTfY1a80Ee1PQu
 CXLPP0FF8MD4g6HjVSjx02qzr9lfSMS6Yo3VA13UGu6Ii5mE7yzJtij8TGpsjUH6r8Sn3CstYob
 DW+mfs+5
X-Authority-Analysis: v=2.4 cv=SKNCVPvH c=1 sm=1 tr=0 ts=68c1b902 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=a_zpyIc2HxMjbloCHkAA:9
X-Proofpoint-GUID: Lmcawx-SnNuLwMeaFBXvlprFfMb7lrJl
X-Proofpoint-ORIG-GUID: azK_oQvvshpQd4tv_KZ6wKj2lSbMOwKd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_03,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 adultscore=0 suspectscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060010

Add paravirt file in /sys/devices/system/cpu.

This offers
- User can quickly check which CPUs are marked as paravirt.
- Userspace algorithm such as sched_ext or with isolcpus could
  use the mask and make decision.
- daemon such as irqbalance could use this mask and don't spread
  irq's into paravirt CPUs.

For example:
cat /sys/devices/system/cpu/paravirt
600-719      <<< arch marked these are paravirt.

cat /sys/devices/system/cpu/paravirt
             <<< No paravirt CPUs at the moment.

Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 Documentation/ABI/testing/sysfs-devices-system-cpu |  9 +++++++++
 drivers/base/cpu.c                                 | 12 ++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index ab8cd337f43a..6701e97d3f8d 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -776,3 +776,12 @@ Date:		Nov 2022
 Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
 Description:
 		(RO) the list of CPUs that can be brought online.
+
+What:		/sys/devices/system/cpu/paravirt
+Date:		Sep 2025
+Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
+Description:
+		(RO) the list of CPUs that are current marked as paravirt CPUs.
+		These CPUs are not meant to be used at the moment due to
+		contention of underlying physical CPU resource. Dynamically
+		changes to reflect the current situation.
diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index efc575a00edd..902747ff4988 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -374,6 +374,15 @@ static int cpu_uevent(const struct device *dev, struct kobj_uevent_env *env)
 }
 #endif
 
+#ifdef CONFIG_PARAVIRT
+static ssize_t print_paravirt_cpus(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpu_paravirt_mask));
+}
+static DEVICE_ATTR(paravirt, 0444, print_paravirt_cpus, NULL);
+#endif
+
 const struct bus_type cpu_subsys = {
 	.name = "cpu",
 	.dev_name = "cpu",
@@ -513,6 +522,9 @@ static struct attribute *cpu_root_attrs[] = {
 #endif
 #ifdef CONFIG_GENERIC_CPU_AUTOPROBE
 	&dev_attr_modalias.attr,
+#endif
+#ifdef CONFIG_PARAVIRT
+	&dev_attr_paravirt.attr,
 #endif
 	NULL
 };
-- 
2.47.3


