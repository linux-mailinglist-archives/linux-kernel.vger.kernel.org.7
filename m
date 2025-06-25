Return-Path: <linux-kernel+bounces-703290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D65AE8E38
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 21:13:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 640307B37C6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 19:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E29D158218;
	Wed, 25 Jun 2025 19:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Gm23tVqq"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CCD2DECDA
	for <linux-kernel@vger.kernel.org>; Wed, 25 Jun 2025 19:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750878743; cv=none; b=E+wgMV8df+ilefXa3cGbT/HQMwmefJRADg8PQI5X3HZl1fqDFZzC8W0kjzsZniaBwS5z9KV16DyL5E3JEYhzoDhe0LSvVIpuYadguukxtnPtQP7j/YCx4fSZrLkOn4HOFYDKLyENmC8v06gY92BLaFFld9Lf9ow7Zzpi3UeOiRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750878743; c=relaxed/simple;
	bh=4witdsRX3wDKVOjp0xKOx/skgjm3IJjNw+HFy+FVYo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aQEU/BMB3gLvj5EYcrWt8u13crKLw1XClsx34G+RCFDp6HltnucTSqZPRomHY7h12/HjJSuBD1EjuTDK4F9OcEXz4ThQDeKyQApoGKPNJWbXNzH5OOsXQ1Wy6uoGXLpGSQnEUn58/+Hbk5H4FKYjoM8ACDapKMLqZOOT5yEB+Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Gm23tVqq; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55PJ1lxW025834;
	Wed, 25 Jun 2025 19:12:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=vAqWtTDW7YLzVxLKd
	Hr3jWP4BwqT6KkfNZ9oNmcJqWg=; b=Gm23tVqqPUCwZYA7c9+0r8AL5NR2XJlqA
	wi7bjFvN4KaA8fTs49mzUeVlkM/7hgDBEvbeGY9w5TzCr7WsqMSXPplreVE3ARRB
	P28RJX0R+r0t3w54Ni3H4SilX581ZFW1R8HSlXQHDakUxkYeljtNccFyKmLV+8wA
	F8w6DB7VM+94NvgCzpRaxXdrn6aRdQoHZLZrjMcsClhJUA91fU47E1Mx3izzafBX
	P6Nyooszzaz5q7jIoKejVkBuJqHZ4UmDuZQxH/eUSCIvPR1UOc5O/sRQbS66ZUWn
	Tc1EFnTw29lqawfaBZBQ/JBsSwj5Lr6JSJdAJhU5yt7CAuNkPDFEg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47gpwhr29r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 19:12:06 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55PJC5VI014992;
	Wed, 25 Jun 2025 19:12:05 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47gpwhr29j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 19:12:05 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55PGq7we030487;
	Wed, 25 Jun 2025 19:12:04 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47e7f030t1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 19:12:04 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55PJC0Qe46989652
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Jun 2025 19:12:00 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 36F2E20043;
	Wed, 25 Jun 2025 19:12:00 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9160420040;
	Wed, 25 Jun 2025 19:11:56 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.124.209.143])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Jun 2025 19:11:56 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, tglx@linutronix.de, yury.norov@gmail.com,
        maddy@linux.ibm.com
Cc: sshegde@linux.ibm.com, vschneid@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, kprateek.nayak@amd.com, huschle@linux.ibm.com,
        srikar@linux.ibm.com, linux-kernel@vger.kernel.org,
        christophe.leroy@csgroup.eu, linuxppc-dev@lists.ozlabs.org,
        gregkh@linuxfoundation.org
Subject: [RFC v2 8/9] sysfs: Add cpu_avoid file
Date: Thu, 26 Jun 2025 00:41:07 +0530
Message-ID: <20250625191108.1646208-9-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250625191108.1646208-1-sshegde@linux.ibm.com>
References: <20250625191108.1646208-1-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9R3I4iVQ4WPLSPQw96LAdN0D3792uqNx
X-Proofpoint-ORIG-GUID: j4Y6QWRJPhn21An-3PwHAy_SOdDGNbJI
X-Authority-Analysis: v=2.4 cv=dd+A3WXe c=1 sm=1 tr=0 ts=685c4a06 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=uVg0aEFNUgdlxJ4hOtAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDE0MSBTYWx0ZWRfX8Ner+tsBH4OV gP/bOavmT3i8icS6AqE0RyTKxJcMe1EyW54YIv7o6wGXgcLT7WFjWhFxt7Tcx+E5b6JtrxwRQEG cKb/k8TWCZbsbCdRZvg8LgJLrasUItxiVCh8Tz9E4kvoi3nlozn7weL/mvv3qUdr82rTpLP7L0I
 GpkHPFDMIK9cr9Qq/If7+7jYnpqC4sPp4jqeBZS02UmKSFHK/TiJjnonMVSeEeQlLZxc7Enl4dm qKkHDkAZLHDGfLK6rSCIQtBrljvbqpB4K7SwJYeExM95kutQMduWoWET6KYsTk7kzFwJlPhETnZ Yfh1bVli6EqC+0Ztc5Yqo3Ek9QUio7gZnbl2mX8uqabejZnm1UXd+xKWj9Luf1jYVCrt74dWWho
 c6eV85itAsXb4bZGbWRGeZ9xInpqTG5mtjGY8quJZVOFcCWurqiGZfcPsF3jNGxBDEQPrDJM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_06,2025-06-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 mlxlogscore=811 priorityscore=1501 mlxscore=0 clxscore=1015 adultscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506250141

Add a sysfs file called "avoid" which prints the current CPUs 
makred as avoid. 

This could be used by userspace components or tools such as irqbalance. 

/sys/devices/system/cpu # cat avoid 
70-479

Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 drivers/base/cpu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 7779ab0ca7ce..51c1207f6f33 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -300,6 +300,13 @@ static ssize_t print_cpus_isolated(struct device *dev,
 }
 static DEVICE_ATTR(isolated, 0444, print_cpus_isolated, NULL);
 
+static ssize_t print_cpus_avoid(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpu_avoid_mask));
+}
+static DEVICE_ATTR(avoid, 0444, print_cpus_avoid, NULL);
+
 #ifdef CONFIG_NO_HZ_FULL
 static ssize_t print_cpus_nohz_full(struct device *dev,
 				    struct device_attribute *attr, char *buf)
@@ -505,6 +512,7 @@ static struct attribute *cpu_root_attrs[] = {
 	&dev_attr_offline.attr,
 	&dev_attr_enabled.attr,
 	&dev_attr_isolated.attr,
+	&dev_attr_avoid.attr,
 #ifdef CONFIG_NO_HZ_FULL
 	&dev_attr_nohz_full.attr,
 #endif
-- 
2.43.0


