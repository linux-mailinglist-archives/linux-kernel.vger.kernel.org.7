Return-Path: <linux-kernel+bounces-703288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D929AE8E34
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 21:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 956FA1C268B3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 19:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3AB82DAFDB;
	Wed, 25 Jun 2025 19:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cU4u2gwf"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A6315278E
	for <linux-kernel@vger.kernel.org>; Wed, 25 Jun 2025 19:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750878740; cv=none; b=QxglORiIcaF68s8gvJf+2oCWSjl6oUAqINWuFK0P9rw089YZHKGyIqVezHtrkRysOuJW1UJ89fSPecsqq+3U5M3B84wl1nK+/olTTMkHtd5gx14gkOyRU1IOjX7dYHNhiP/n4JiZYNQbe7phle8o46vJxwQPr+ZhBhGVDWimQzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750878740; c=relaxed/simple;
	bh=NSp1Y4sKYSoZQ63/fETjABsUDokgxoiH8EZwfXgFRzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gwrPHwRXbXqjEmosEpXGJDVu3mjbAyvnUJdJID8HDmdxiTmtLoSycIQ3lSfpg0hITEqKNAx1XhxzuUXXNjDTCiXNcR/rNUudu1gKvjyD05pIGU3Tookq05+r60PMdmFhpm5I9J0UjmYcioKfinfUvpQLYCGHof8ZhazbAtRDn/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cU4u2gwf; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55PIjF8F021390;
	Wed, 25 Jun 2025 19:11:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=GHer5xhnBVAf9AAcF
	jfq5ZgcgMov2g/1t4b6uVEZ2sg=; b=cU4u2gwfrbwbmauS1L3Q0hP6pCxUk7jQQ
	8pN39+2FEXcwhQYesPmYz9aBmg7ic/4ydYy1dyyVs/3Ij4gEiqi4auyket/diAEG
	RguLIn1QMf1qSQVWWhOqvxeAyLHKJP5rjU3/jX6k4NQ6S17vaKNEpklnrxLy40Ci
	I7v1EwIqTgwntX1EPCSiOtTFGum767xpaDu90l0KDNVOE1rewZO7cbXGNdqmf1hz
	WOC4JFK8kzwukIB9UUOwCPOU5YPKDpqFSH6CK62/0FXdyqgx+XHd8ls9f7QCvlNB
	xI8uAW5V4VFxcfnCEOTDir2MJbQvg8A3dm9HY3AKRuAxDou5LItPg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dj5u1e83-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 19:11:41 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55PJ3HWZ012306;
	Wed, 25 Jun 2025 19:11:41 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dj5u1e7y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 19:11:40 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55PHm8qK002502;
	Wed, 25 Jun 2025 19:11:40 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47e8jmasck-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 19:11:40 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55PJBajD43581934
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Jun 2025 19:11:36 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 07D7520043;
	Wed, 25 Jun 2025 19:11:36 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 67E0420040;
	Wed, 25 Jun 2025 19:11:32 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.124.209.143])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Jun 2025 19:11:32 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, tglx@linutronix.de, yury.norov@gmail.com,
        maddy@linux.ibm.com
Cc: sshegde@linux.ibm.com, vschneid@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, kprateek.nayak@amd.com, huschle@linux.ibm.com,
        srikar@linux.ibm.com, linux-kernel@vger.kernel.org,
        christophe.leroy@csgroup.eu, linuxppc-dev@lists.ozlabs.org,
        gregkh@linuxfoundation.org
Subject: [RFC v2 2/9] cpumask: Introduce cpu_avoid_mask
Date: Thu, 26 Jun 2025 00:41:01 +0530
Message-ID: <20250625191108.1646208-3-sshegde@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: dE9UtAVDRPTezjRgirKRyHN9rZp5_v0i
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDE0MSBTYWx0ZWRfX/UKBIUdc5CFJ npscVWmTiaWEZb8I2RHf2qPH94MOtjHrFraxwYledlw9DYyJ1xA3JHiG6MmvG0E9RcaCblO23MI gC9ec4PIWBGZZz0BSyqbOOPqRbm+aUwxoAn/cckUrEHdm3LS/lHSGQqWkG//+oo6uqrCWVz4TZB
 N+AaYwjzrEbS0B2vbJMlQWDnpECM0GDj/Fo4AINce6WDhVgo1QFqA8h8XjX5An+19MR1a5C1NzM QBygdnjcGXDNbgRkwIpLgyCce5YxPJ49PkAfZziZGlI8zkXyyxvcAbSQt0nuQPaVdsO3xmVINK8 LmVZGHbRRcNFDB+w+pIMeMZ+qWgAypP/BGVgxqtZQkrdixQylTbuiqpqAKs0uHU5OyULvI6g40Z
 WTclGm8WuvAXJmuluZQB+0oIx3eP8Y+2wnRSWwcFD6oyOBmsAzXwRzYN2FC/Fwxp7ba2lbel
X-Authority-Analysis: v=2.4 cv=MshS63ae c=1 sm=1 tr=0 ts=685c49ed cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=43edTZbtrg5bJSvecBcA:9
X-Proofpoint-GUID: 1B4I5-iUm_Kdo6JFcyZtVd6UUixFXvlq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_06,2025-06-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 impostorscore=0
 clxscore=1011 phishscore=0 malwarescore=0 suspectscore=0 adultscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506250141

Introduce cpu_avoid_mask and get/set routines for it.

By having the mask, it is easier for other kernel subsystem to consume
it as well. One could quickly know which CPUs are currently marked as
avoid.
 
Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
There is a sysfs patch later in the series which prints this mask. If it 
should be sqashed into this patch, let me know. 
 
include/linux/cpumask.h | 17 +++++++++++++++++
 kernel/cpu.c            |  3 +++
 2 files changed, 20 insertions(+)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 7ae80a7ca81e..6394c67a4fb3 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -84,6 +84,7 @@ static __always_inline void set_nr_cpu_ids(unsigned int nr)
  *     cpu_enabled_mask - has bit 'cpu' set iff cpu can be brought online
  *     cpu_online_mask  - has bit 'cpu' set iff cpu available to scheduler
  *     cpu_active_mask  - has bit 'cpu' set iff cpu available to migration
+ *     cpu_avoid_mask  - has bit 'cpu' set iff cpu is to be avoided now
  *
  *  If !CONFIG_HOTPLUG_CPU, present == possible, and active == online.
  *
@@ -101,6 +102,10 @@ static __always_inline void set_nr_cpu_ids(unsigned int nr)
  *  (*) Well, cpu_present_mask is dynamic in the hotplug case.  If not
  *      hotplug, it's a copy of cpu_possible_mask, hence fixed at boot.
  *
+ *  A CPU is said to be avoided when there is contention for underlying
+ *  physical CPU resource in paravirtulized environment. It is recommneded
+ *  not run anything on that CPU though it is online.
+ *
  * Subtleties:
  * 1) UP ARCHes (NR_CPUS == 1, CONFIG_SMP not defined) hardcode
  *    assumption that their single CPU is online.  The UP
@@ -118,12 +123,14 @@ extern struct cpumask __cpu_enabled_mask;
 extern struct cpumask __cpu_present_mask;
 extern struct cpumask __cpu_active_mask;
 extern struct cpumask __cpu_dying_mask;
+extern struct cpumask __cpu_avoid_mask;
 #define cpu_possible_mask ((const struct cpumask *)&__cpu_possible_mask)
 #define cpu_online_mask   ((const struct cpumask *)&__cpu_online_mask)
 #define cpu_enabled_mask   ((const struct cpumask *)&__cpu_enabled_mask)
 #define cpu_present_mask  ((const struct cpumask *)&__cpu_present_mask)
 #define cpu_active_mask   ((const struct cpumask *)&__cpu_active_mask)
 #define cpu_dying_mask    ((const struct cpumask *)&__cpu_dying_mask)
+#define cpu_avoid_mask    ((const struct cpumask *)&__cpu_avoid_mask)
 
 extern atomic_t __num_online_cpus;
 
@@ -1133,6 +1140,7 @@ void init_cpu_possible(const struct cpumask *src);
 #define set_cpu_present(cpu, present)	assign_cpu((cpu), &__cpu_present_mask, (present))
 #define set_cpu_active(cpu, active)	assign_cpu((cpu), &__cpu_active_mask, (active))
 #define set_cpu_dying(cpu, dying)	assign_cpu((cpu), &__cpu_dying_mask, (dying))
+#define set_cpu_avoid(cpu, avoid)       assign_cpu((cpu), &__cpu_avoid_mask, (avoid))
 
 void set_cpu_online(unsigned int cpu, bool online);
 
@@ -1222,6 +1230,11 @@ static __always_inline bool cpu_dying(unsigned int cpu)
 	return cpumask_test_cpu(cpu, cpu_dying_mask);
 }
 
+static __always_inline bool cpu_avoid(unsigned int cpu)
+{
+	return cpumask_test_cpu(cpu, cpu_avoid_mask);
+}
+
 #else
 
 #define num_online_cpus()	1U
@@ -1260,6 +1273,10 @@ static __always_inline bool cpu_dying(unsigned int cpu)
 	return false;
 }
 
+static __always_inline bool cpu_avoid(unsigned int cpu)
+{
+	return false;
+}
 #endif /* NR_CPUS > 1 */
 
 #define cpu_is_offline(cpu)	unlikely(!cpu_online(cpu))
diff --git a/kernel/cpu.c b/kernel/cpu.c
index a59e009e0be4..44e8c66d2839 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -3107,6 +3107,9 @@ EXPORT_SYMBOL(__cpu_active_mask);
 struct cpumask __cpu_dying_mask __read_mostly;
 EXPORT_SYMBOL(__cpu_dying_mask);
 
+struct cpumask __cpu_avoid_mask __read_mostly;
+EXPORT_SYMBOL(__cpu_avoid_mask);
+
 atomic_t __num_online_cpus __read_mostly;
 EXPORT_SYMBOL(__num_online_cpus);
 
-- 
2.43.0


