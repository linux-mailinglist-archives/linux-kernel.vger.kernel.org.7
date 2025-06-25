Return-Path: <linux-kernel+bounces-703295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D86BAE8E47
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 21:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6CA84A4324
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 19:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703002E336A;
	Wed, 25 Jun 2025 19:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rQ23vrEl"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3037A2E11A2
	for <linux-kernel@vger.kernel.org>; Wed, 25 Jun 2025 19:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750878749; cv=none; b=KrfMjI6TfBEyl/+NzstiK50ITk0T0DDZkd/p4GsSjqzZSximpxniyscfhs3nj6tU5RyRM2xCc1MOHYgj/dXNVa5O8EjDbdUiCpWxotj7R50QJNSkmiKYeJSq6+SQ0g+Gw4tCo4f5RljfnMaH8mZSeT5lYRwZ7zF50ps+rRw7tAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750878749; c=relaxed/simple;
	bh=cUF2HGW2YZSeTGXojGUmjKkoqm89VyvPl2E8a2LQM6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aBJxaV1/rwgouPFJZhs/Zcpr8GIsRXhAD98i08JSJwCzI5XkQCgpSdASDht2p+bts1bDBZ4JHSkblXpwkrLVctmPTIQiaVF6ERWjRgHSmXUSbJ8nurSJIHu3vJTmjGVC6GRtoOu1MNfBm5oS5PnkhhJx6imUPDg/5/A1aRz8Yvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rQ23vrEl; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55PIvp0T002954;
	Wed, 25 Jun 2025 19:12:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=sj4hwpYQjyOaXXLYM
	wbz9n8YmXdOIVju/O/KyJyJKkQ=; b=rQ23vrEliBZhkHyNP6uH/NX5D/iV90lz5
	Sbzfh5xvFGQ3hhs8dranANb/CTkG5sbGz+v+0gQqHyOcPJ3OuJiXixNkwFyHAagh
	B1yDfI9X+t8/y8sagSpPYtjTmumrY/LtP3Rgb/wZ+Dc9XF7eRq3Mo3qnkjz3P3Fp
	bQCDp4A16iFQ65QD+LqMLaahVbJusXjk/KZyBP/lWSxJpfABb6xeJgLJAuchygX5
	tFbdTW2b+IrdjsSkrtUjo1Fs21RO+mfeTC9qzYEihYNBaU4CgV6CF8jcBjkuiGY4
	FbitLYvjLQq/GBQM8DHABv2PjwwlTQJb3sfIoauYmKc8FGL4KN4WQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dmf394kx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 19:12:09 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55PJ7gLb013252;
	Wed, 25 Jun 2025 19:12:09 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dmf394kt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 19:12:09 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55PHlU9B002512;
	Wed, 25 Jun 2025 19:12:08 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47e8jmasem-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 19:12:08 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55PJC4Lx45351400
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Jun 2025 19:12:04 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 47CA520043;
	Wed, 25 Jun 2025 19:12:04 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E2EB20040;
	Wed, 25 Jun 2025 19:12:00 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.124.209.143])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Jun 2025 19:12:00 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, tglx@linutronix.de, yury.norov@gmail.com,
        maddy@linux.ibm.com
Cc: sshegde@linux.ibm.com, vschneid@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, kprateek.nayak@amd.com, huschle@linux.ibm.com,
        srikar@linux.ibm.com, linux-kernel@vger.kernel.org,
        christophe.leroy@csgroup.eu, linuxppc-dev@lists.ozlabs.org,
        gregkh@linuxfoundation.org
Subject: [RFC v2 9/9] [DEBUG] powerpc: add debug file for set/unset cpu avoid
Date: Thu, 26 Jun 2025 00:41:08 +0530
Message-ID: <20250625191108.1646208-10-sshegde@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=M5FNKzws c=1 sm=1 tr=0 ts=685c4a09 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=p-EdeYucjEwV52n1TQsA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDE0MSBTYWx0ZWRfX6kykvkwcHs8Q EmPt6oNDn72P8qGY1IlDGuJMzbvzyCBdy7RFg30K1X2Pub5eNmlPEAkNPNC3r4Ls1KH0dGKp4kx Ic4mdmdcq8iX6qfIs6MnKsqfjepUfWU7p+kaGPUpkYXjdIfDrYxgdnzBUyOVQC8NvBiMiHUlwWT
 DMkpXO3LHm5JSGOQRLe5T2LB0Ll4zZpzSQL8ilXEMfdEfjM0B0e9oNbZE9Nzy0pJ5yUINItFChj 3rEKD94QUQU6PpMph0ZbC+XwYI1jj42MpIUmn/fn86acbtdP4YcAxMLTpi8lQ4Pi/ButXvqYjrR ZQW5o3BOnmeYEsfacXWM1A9MkVUpQs1YIoXXllrFVkoWGCIPWWgeT44ddGDoUz9JugGAkKaM2AZ
 en3UwsXpSDHOHw2V3g2WmylHytXmFrh4JRjlQSqXYj+aeSqKzSKP8RM4m6x6nc/bc7yqG0VT
X-Proofpoint-GUID: tSfwQunLDKfYkRT561MPEbEFGHR3E6AR
X-Proofpoint-ORIG-GUID: YFBlOehKcrciiuM9VgjlQ--IrzfvbzFB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_06,2025-06-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015 adultscore=0
 mlxscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506250141

Reference patch for how an architecture can make use of this infra. 

This is not meant to be merged. Instead the vp_manual_hint should either
come from hardware or could be derived using steal time. 

When the provided hint is less than the total CPUs in the system, it
will enable the cpu avoid static key and set those CPUs as avoid. 

Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 arch/powerpc/include/asm/paravirt.h |  2 ++
 arch/powerpc/kernel/smp.c           | 50 +++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/arch/powerpc/include/asm/paravirt.h b/arch/powerpc/include/asm/paravirt.h
index b78b82d66057..b6497e0b60d8 100644
--- a/arch/powerpc/include/asm/paravirt.h
+++ b/arch/powerpc/include/asm/paravirt.h
@@ -10,6 +10,8 @@
 #include <asm/hvcall.h>
 #endif
 
+DECLARE_STATIC_KEY_FALSE(paravirt_cpu_avoid_enabled);
+
 #ifdef CONFIG_PPC_SPLPAR
 #include <linux/smp.h>
 #include <asm/kvm_guest.h>
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 5ac7084eebc0..e00cdc4de441 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -64,6 +64,7 @@
 #include <asm/systemcfg.h>
 
 #include <trace/events/ipi.h>
+#include <linux/debugfs.h>
 
 #ifdef DEBUG
 #include <asm/udbg.h>
@@ -82,6 +83,7 @@ bool has_big_cores __ro_after_init;
 bool coregroup_enabled __ro_after_init;
 bool thread_group_shares_l2 __ro_after_init;
 bool thread_group_shares_l3 __ro_after_init;
+static int vp_manual_hint = NR_CPUS;
 
 DEFINE_PER_CPU(cpumask_var_t, cpu_sibling_map);
 DEFINE_PER_CPU(cpumask_var_t, cpu_smallcore_map);
@@ -1727,6 +1729,7 @@ static void __init build_sched_topology(void)
 	BUG_ON(i >= ARRAY_SIZE(powerpc_topology) - 1);
 
 	set_sched_topology(powerpc_topology);
+	vp_manual_hint = num_present_cpus();
 }
 
 void __init smp_cpus_done(unsigned int max_cpus)
@@ -1807,4 +1810,51 @@ void __noreturn arch_cpu_idle_dead(void)
 	start_secondary_resume();
 }
 
+/*
+ * sysfs hint to mark CPUs as Avoid. This will help in restricting
+ * the workload to specified number of CPUs.
+ * For example 40 > vp_manual_hint means, workload will run on
+ * 0-39 CPUs.
+ */
+
+static int pv_vp_manual_hint_set(void *data, u64 val)
+{
+	int cpu;
+
+	if (val == 0 || vp_manual_hint > num_present_cpus())
+		vp_manual_hint = num_present_cpus();
+
+	if (val != vp_manual_hint)
+		vp_manual_hint = val;
+
+	if (vp_manual_hint < num_present_cpus())
+		static_branch_enable(&paravirt_cpu_avoid_enabled);
+	else
+		static_branch_disable(&paravirt_cpu_avoid_enabled);
+
+	for_each_present_cpu(cpu) {
+		if (cpu >= vp_manual_hint)
+			set_cpu_avoid(cpu, true);
+		else
+			set_cpu_avoid(cpu, false);
+	}
+	return 0;
+}
+
+static int pv_vp_manual_hint_get(void *data, u64 *val)
+{
+	*val = vp_manual_hint;
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(fops_pv_vp_manual_hint, pv_vp_manual_hint_get, pv_vp_manual_hint_set, "%llu\n");
+
+static __init int paravirt_debugfs_init(void)
+{
+	if (is_shared_processor())
+		debugfs_create_file("vp_manual_hint", 0600, arch_debugfs_dir, NULL, &fops_pv_vp_manual_hint);
+	return 0;
+}
+
+device_initcall(paravirt_debugfs_init)
 #endif
-- 
2.43.0


