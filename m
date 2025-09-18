Return-Path: <linux-kernel+bounces-810783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 040E5B51F52
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 19:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A12774602EB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 17:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA56C205E3B;
	Wed, 10 Sep 2025 17:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Hlnol447"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A312834164A
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 17:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757526305; cv=none; b=qmaGuYcnxXtzHDRvGL/W/9r3phJ+u3WyoFHwOO7m9IXbjVWIVQQolfhW9Ysv89lQqqw4/Wd3TMRg15jNqdzG7U7Z6Vl8Zx9vFsjN4zu8cmzM77UvmF5yNyqi5K3UTyxB6AX6IRSXogURpqhyBAyR2MYgzj1qHJE7mHtFJOK81UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757526305; c=relaxed/simple;
	bh=iVAsp8qEuGbdNZHLXAbc2lkWeVf27QoVgSrG092m6WI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LQXLVBkJVV5983t2R93aqXnzh6LitOj8vj81WTkrjBEBtdplussbJGF5JkFA0nT8h3+KPdSFJx0FS9K7Lwo0I9WxKJ+Sp/H2nuScFUiav9BFy3sZZYo2KTRlduC39xeEWI6s0VNBMuG3p64bh5tvUfauE1Ve78e6ZGMrDYmnbYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Hlnol447; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58AGxWBb022908;
	Wed, 10 Sep 2025 17:44:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=pWnY6x0dhUtbDJ5O2
	ZYRjeNVPeRHQ8+KZd7THg2oo6I=; b=Hlnol4472RO8JFDXP1nWeDopkFjfgHIWp
	McCYLt2B99EBfmrgmjH1WqZhGn6E8wn3iyrFyd4RUKe7UvmgSBiUMHNqCmWZtcIh
	4TX8i2e0TVbPRAJqMDarmKJI7RY/DumXnGBPOV+9Fu9xOAGLNGI9g+ucdjQFs432
	PkyTc4qwZRp3e0kvOzQhSy7AAgGgOws6BXRTq9Z+S3YlCaUZ/LHKOlYlMs/9Am2k
	q9m+82U3oWT4JiEqWOLxCyKm/pvZT5WBC40ZrUHOR2+awPFU1r5ac/8FmEd/+CvR
	XdXGuwZDROd8SBmMXsh2Xh/H31Y8oznJcAU4sM6nQfG87B+4mGzIA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cfffx6j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Sep 2025 17:44:48 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58AHiC36013900;
	Wed, 10 Sep 2025 17:44:48 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cfffx6e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Sep 2025 17:44:47 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58AGfaG1020700;
	Wed, 10 Sep 2025 17:44:46 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 490yp11vn0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Sep 2025 17:44:46 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58AHig1W57016654
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Sep 2025 17:44:42 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 90D5420043;
	Wed, 10 Sep 2025 17:44:42 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 814EB20040;
	Wed, 10 Sep 2025 17:44:36 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.124.208.171])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 10 Sep 2025 17:44:36 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, tglx@linutronix.de, yury.norov@gmail.com,
        maddy@linux.ibm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, gregkh@linuxfoundation.org
Cc: sshegde@linux.ibm.com, vschneid@redhat.com, iii@linux.ibm.com,
        huschle@linux.ibm.com, rostedt@goodmis.org, dietmar.eggemann@arm.com,
        vineeth@bitbyteword.org, jgross@suse.com, pbonzini@redhat.com,
        seanjc@google.com
Subject: [HELPER PATCH] sysfs: Provide write method for paravirt
Date: Wed, 10 Sep 2025 23:12:10 +0530
Message-ID: <20250910174210.1969750-11-sshegde@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: XT3ksZmm9QlEKIkodWb63ERvrS0E7n_h
X-Proofpoint-GUID: ZB_Bn-8CmcrKQNtpeQwPHXsYm5HCug7w
X-Authority-Analysis: v=2.4 cv=EYDIQOmC c=1 sm=1 tr=0 ts=68c1b910 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=QYAN427j3e14qLe-yhwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyMCBTYWx0ZWRfX+cgA+CNx7dSY
 DghYLUJKuqy2XQvTjeRiqsiikngHVgziVOVSHk9iEP1hL6sQVANCDlqR5SJRJujBAV3WMBfJ2dR
 HPZzGbT3BwtSb0d5VTajjwcQXexXsJC+wW9uu9GWgLdH1H6+nYArOJmZNap3ZNYOKOcreqYbjof
 SQyEyT2hgRZD1GELMQnrFiJXhpspQjh9Oi//PgCNCBypeQViCqDbBMjEHjBxriRNJ5Qq6aJQeeH
 6IAQPAQ7iAKCwf79l9tuLIZeIEJILGRkm1NGwoZJEIaZuSa/+Y/kHG96CwDtIo7dtMIkNh7I/zx
 7eGX5k+j/dmt9HQ6/QgdXq1eyvqnm835prdrppMUOgwHtEfmkQAYdIyMahI28dsJ+9S524W9cXG
 h8RNjg8M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_03,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060020

This is helper patch which could be used to set the range of CPUs as
paravirt. One could make use of this for quick testing of this infra
instead of writing arch specific code.

This is currently not meant be merged, since paravirt sysfs file is meant
to be Read-Only.

echo 100-200,600-700 >  /sys/devices/system/cpu/paravirt
cat /sys/devices/system/cpu/paravirt
100-200,600-700

echo > /sys/devices/system/cpu/paravirt
cat /sys/devices/system/cpu/paravirt

Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
Idea was borrowed from Ilya's patch shared to me internally.

It is up for debate to have something like this or like powerpc patch.

 drivers/base/base.h |  4 ++++
 drivers/base/cpu.c  | 43 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index 123031a757d9..bd93b2895b24 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -264,3 +264,7 @@ static inline int devtmpfs_delete_node(struct device *dev) { return 0; }
 
 void software_node_notify(struct device *dev);
 void software_node_notify_remove(struct device *dev);
+
+#ifdef CONFIG_PARAVIRT
+DECLARE_STATIC_KEY_FALSE(cpu_paravirt_push_tasks);
+#endif
diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 902747ff4988..d66cbd0c3060 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -375,12 +375,53 @@ static int cpu_uevent(const struct device *dev, struct kobj_uevent_env *env)
 #endif
 
 #ifdef CONFIG_PARAVIRT
+static ssize_t store_paravirt_cpus(struct device *dev,
+				   struct device_attribute *attr,
+				   const char *buf, size_t count)
+{
+	cpumask_var_t temp_mask;
+	int retval = 0;
+
+	if (!alloc_cpumask_var(&temp_mask, GFP_KERNEL))
+		return -ENOMEM;
+
+	retval = cpulist_parse(buf, temp_mask);
+	if (retval)
+		goto free_mask;
+
+	/* ALL cpus can't be marked as paravirt */
+	if (cpumask_equal(temp_mask, cpu_online_mask)) {
+		retval = -EINVAL;
+		goto free_mask;
+	}
+	if (cpumask_weight(temp_mask) > num_online_cpus()) {
+		retval = -EINVAL;
+		goto free_mask;
+	}
+
+	/* No more paravirt cpus */
+	if (cpumask_empty(temp_mask)) {
+		static_branch_disable(&cpu_paravirt_push_tasks);
+		cpumask_copy((struct cpumask *)&__cpu_paravirt_mask, temp_mask);
+
+	} else {
+		static_branch_enable(&cpu_paravirt_push_tasks);
+		cpumask_copy((struct cpumask *)&__cpu_paravirt_mask, temp_mask);
+	}
+
+	retval = count;
+
+free_mask:
+	free_cpumask_var(temp_mask);
+	return retval;
+}
+
 static ssize_t print_paravirt_cpus(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
 	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpu_paravirt_mask));
 }
-static DEVICE_ATTR(paravirt, 0444, print_paravirt_cpus, NULL);
+static DEVICE_ATTR(paravirt, 0644, print_paravirt_cpus, store_paravirt_cpus);
 #endif
 
 const struct bus_type cpu_subsys = {
-- 
2.47.3


