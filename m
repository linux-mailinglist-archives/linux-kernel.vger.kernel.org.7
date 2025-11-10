Return-Path: <linux-kernel+bounces-892352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD2FC44E92
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 05:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E740C346110
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 04:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5376299AB5;
	Mon, 10 Nov 2025 04:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CbfXH5ZB"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005A5285CA7
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 04:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762749137; cv=none; b=cx5ewdo0det9WF+qShlRsKGjjQHoDn1dBNqmNWANDxfIztAVthsMc1HpyDf4LpGawf22/AF/AD0zzl8eJxBZp1jNEX6Jda6qKiqFMfCuqUNn7qmJ+3qFXFzlCzp6GYY6eBGrXYJJ7t/iNmrS11sB8VfIiSOrCgAcnbHEVnUhk4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762749137; c=relaxed/simple;
	bh=+BSVoCPuFO+9f+Rl7AJvqWuTKBdsWo5Z0wK7kY5x6Aw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ozVXNzRjR9nKu+Qc03gfhfmqj/Ozc6yVxq1CVLI6yuegMseLsENwId2D6kxRASZNBPjctE60B1ykCRARfvRXVKWK30WQtbF6P9ICWxPQl++Ektf/I5opoDvRwFSMz2jxDXtFD2TJcICwzbNuGAAzAhYVoJ43nGmNmItJ8Z/rIEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CbfXH5ZB; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A97dPso003484;
	Mon, 10 Nov 2025 04:32:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=S6OO7d8PsReVOPyVi
	Qjm7XY6GPM6jTkMHSYKECMZ4fk=; b=CbfXH5ZBC+FZA6APSnLdWnELKXl6rL45G
	I0E7sUOSv07l7m4zOv45QAHRwsE8ngNP3fItT+hrUrwveoQTUX8ESLiUmieTRDe7
	iE742j+E8Pq1COCmbcp2KPSPZ77CMR7vipc56LNVVAO6Wo0aZ3ElFEnylaaaZSfC
	gdz7uL3XKiCbKyITEphNrl+TldFhYGHfHf62O3OsGi5oZoNugrNeE7HIuYXVBXv8
	QVWVCVknYvQK7fa/wR0uqPVgPVZhZRnoMzuEmY4TOl7X8kJXx8c9EqmFouq+moXr
	L/0HdeFwx51Y25oI8gpaI6qj66COiKHaC+jGOrQ+JUJSECTWvfuLQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a9wgwnexc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 04:32:05 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5AA4W4kx021672;
	Mon, 10 Nov 2025 04:32:04 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a9wgwnexb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 04:32:04 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A9NJaOd028978;
	Mon, 10 Nov 2025 04:32:03 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aag6s40y8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 04:32:03 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AA4W0uX40173848
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 04:32:00 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2633A2004D;
	Mon, 10 Nov 2025 04:32:00 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CAD7D20040;
	Mon, 10 Nov 2025 04:31:56 +0000 (GMT)
Received: from li-4f5ba44c-27d4-11b2-a85c-a08f5b49eada.in.ibm.com (unknown [9.109.204.116])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Nov 2025 04:31:56 +0000 (GMT)
From: Sourabh Jain <sourabhjain@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>,
        Aditya Gupta <adityag@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, Baoquan he <bhe@redhat.com>,
        Dave Young <dyoung@redhat.com>, Hari Bathini <hbathini@linux.ibm.com>,
        Jiri Bohac <jbohac@suse.cz>, Madhavan Srinivasan <maddy@linux.ibm.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Pingfan Liu <piliu@redhat.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Shivang Upadhyay <shivangu@linux.ibm.com>,
        Vivek Goyal <vgoyal@redhat.com>, linuxppc-dev@lists.ozlabs.org,
        kexec@lists.infradead.org
Subject: [PATCH v3 2/5] kexec: move sysfs entries to /sys/kernel/kexec
Date: Mon, 10 Nov 2025 10:01:40 +0530
Message-ID: <20251110043143.484408-3-sourabhjain@linux.ibm.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251110043143.484408-1-sourabhjain@linux.ibm.com>
References: <20251110043143.484408-1-sourabhjain@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JYoI4CsjW4u0EtFknkyhWGhdtUwikUVp
X-Proofpoint-ORIG-GUID: UhrL0SI_cbTnNs8kn0lPsE5Y9KJmDOJr
X-Authority-Analysis: v=2.4 cv=VMPQXtPX c=1 sm=1 tr=0 ts=69116ac5 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8 a=Z4Rwk6OoAAAA:8
 a=20KFwNOVAAAA:8 a=pGLkceISAAAA:8 a=voM4FWlXAAAA:8 a=JfrnYn6hAAAA:8
 a=_1xw4giDfGel_dwv_FAA:9 a=HkZW87K1Qel5hWWM3VKY:22 a=IC2XNlieTeVoXbcui8wp:22
 a=1CNFftbPRP8L7MoqJWF3:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDAyMiBTYWx0ZWRfXxB89aUOUGjDQ
 a0wrFKtwp5kJfW0rvscxxDCpedd2kwQWeIk7NFkYk9R7Ty5iiXzrTrP8X+URULdrxq06v7o48Gr
 b7o2gVABm1rcCrlYh13ydCAG5w5Z7JdPo913E5g5ws675yB4mMocRgu3+LUiU9RzTwvG7suo7AH
 4G8A3DsPs1V9sUFD9YnG1gGhLBQr/4OCY3ckPVO9+MpyP/vOWbrpIvQmyaGOT7R3Awf3Yg+ZkWS
 4zT9AvWXLwR4AfvAmMKaP1jIu0x890hP1vO2AmogXXiZb481vNEN9TqaWL08kbO1mzLYmNR6yko
 IVRxVc4qtVXx/tSuVMaYhGhlG+ni4Pzx/CkqAG0kBiN8fC0Xsouh5P185h+h3bpqJi3Dx2KLuwz
 DJ/AIysmGzMJaFWtwh1IyMczPygZLg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_01,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 clxscore=1015 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511080022

Several kexec and kdump sysfs entries are currently placed directly
under /sys/kernel/, which clutters the directory and makes it harder to
identify unrelated entries. To improve organization and readability,
these entries are now moved under a dedicated directory,
/sys/kernel/kexec.

For backward compatibility, symlinks are created at the old locations
so that existing tools and scripts continue to work. These symlinks can
be removed in the future once users have switched to the new path.

While creating symlinks, entries are added in /sys/kernel/ that point
to their new locations under /sys/kernel/kexec/. If an error occurs
while adding a symlink, it is logged but does not stop initialization
of the remaining kexec sysfs symlinks.

The /sys/kernel/<crash_elfcorehdr_size | kexec/crash_elfcorehdr_size>
entry is now controlled by CONFIG_CRASH_DUMP instead of
CONFIG_VMCORE_INFO, as CONFIG_CRASH_DUMP also enables
CONFIG_VMCORE_INFO.

Cc: Aditya Gupta <adityag@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan he <bhe@redhat.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Hari Bathini <hbathini@linux.ibm.com>
Cc: Jiri Bohac <jbohac@suse.cz>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
Cc: Pingfan Liu <piliu@redhat.com>
Cc: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Cc: Shivang Upadhyay <shivangu@linux.ibm.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: kexec@lists.infradead.org
Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
---
Changelog:

v2 -> v3:
 - Declare kexec_kobj static

---
 kernel/kexec_core.c | 118 ++++++++++++++++++++++++++++++++++++++++++++
 kernel/ksysfs.c     |  68 +------------------------
 2 files changed, 119 insertions(+), 67 deletions(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index fa00b239c5d9..7476a46de5d6 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -41,6 +41,7 @@
 #include <linux/objtool.h>
 #include <linux/kmsg_dump.h>
 #include <linux/dma-map-ops.h>
+#include <linux/sysfs.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -1229,3 +1230,120 @@ int kernel_kexec(void)
 	kexec_unlock();
 	return error;
 }
+
+static ssize_t loaded_show(struct kobject *kobj,
+				 struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%d\n", !!kexec_image);
+}
+static struct kobj_attribute loaded_attr = __ATTR_RO(loaded);
+
+#ifdef CONFIG_CRASH_DUMP
+static ssize_t crash_loaded_show(struct kobject *kobj,
+				       struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%d\n", kexec_crash_loaded());
+}
+static struct kobj_attribute crash_loaded_attr = __ATTR_RO(crash_loaded);
+
+static ssize_t crash_size_show(struct kobject *kobj,
+				       struct kobj_attribute *attr, char *buf)
+{
+	ssize_t size = crash_get_memory_size();
+
+	if (size < 0)
+		return size;
+
+	return sysfs_emit(buf, "%zd\n", size);
+}
+static ssize_t crash_size_store(struct kobject *kobj,
+				struct kobj_attribute *attr,
+				const char *buf, size_t count)
+{
+	unsigned long cnt;
+	int ret;
+
+	if (kstrtoul(buf, 0, &cnt))
+		return -EINVAL;
+
+	ret = crash_shrink_memory(cnt);
+	return ret < 0 ? ret : count;
+}
+static struct kobj_attribute crash_size_attr = __ATTR_RW(crash_size);
+
+#ifdef CONFIG_CRASH_HOTPLUG
+static ssize_t crash_elfcorehdr_size_show(struct kobject *kobj,
+			       struct kobj_attribute *attr, char *buf)
+{
+	unsigned int sz = crash_get_elfcorehdr_size();
+
+	return sysfs_emit(buf, "%u\n", sz);
+}
+static struct kobj_attribute crash_elfcorehdr_size_attr = __ATTR_RO(crash_elfcorehdr_size);
+
+#endif /* CONFIG_CRASH_HOTPLUG */
+#endif /* CONFIG_CRASH_DUMP */
+
+static struct attribute *kexec_attrs[] = {
+	&loaded_attr.attr,
+#ifdef CONFIG_CRASH_DUMP
+	&crash_loaded_attr.attr,
+	&crash_size_attr.attr,
+#ifdef CONFIG_CRASH_HOTPLUG
+	&crash_elfcorehdr_size_attr.attr,
+#endif
+#endif
+	NULL
+};
+
+struct kexec_link_entry {
+	const char *target;
+	const char *name;
+};
+
+static struct kexec_link_entry kexec_links[] = {
+	{ "loaded", "kexec_loaded" },
+#ifdef CONFIG_CRASH_DUMP
+	{ "crash_loaded", "kexec_crash_loaded" },
+	{ "crash_size", "kexec_crash_size" },
+#ifdef CONFIG_CRASH_HOTPLUG
+	{ "crash_elfcorehdr_size", "crash_elfcorehdr_size" },
+#endif
+#endif
+
+};
+
+static struct kobject *kexec_kobj;
+ATTRIBUTE_GROUPS(kexec);
+
+static int __init init_kexec_sysctl(void)
+{
+	int error;
+	int i;
+
+	kexec_kobj = kobject_create_and_add("kexec", kernel_kobj);
+	if (!kexec_kobj) {
+		pr_err("failed to create kexec kobject\n");
+		return -ENOMEM;
+	}
+
+	error = sysfs_create_groups(kexec_kobj, kexec_groups);
+	if (error)
+		goto kset_exit;
+
+	for (i = 0; i < ARRAY_SIZE(kexec_links); i++) {
+		error = compat_only_sysfs_link_entry_to_kobj(kernel_kobj, kexec_kobj,
+							     kexec_links[i].target,
+							     kexec_links[i].name);
+		if (error)
+			pr_err("Unable to create %s symlink (%d)", kexec_links[i].name, error);
+	}
+
+	return 0;
+
+kset_exit:
+	kobject_put(kexec_kobj);
+	return error;
+}
+
+subsys_initcall(init_kexec_sysctl);
diff --git a/kernel/ksysfs.c b/kernel/ksysfs.c
index eefb67d9883c..a9e6354d9e25 100644
--- a/kernel/ksysfs.c
+++ b/kernel/ksysfs.c
@@ -12,7 +12,7 @@
 #include <linux/sysfs.h>
 #include <linux/export.h>
 #include <linux/init.h>
-#include <linux/kexec.h>
+#include <linux/vmcore_info.h>
 #include <linux/profile.h>
 #include <linux/stat.h>
 #include <linux/sched.h>
@@ -119,50 +119,6 @@ static ssize_t profiling_store(struct kobject *kobj,
 KERNEL_ATTR_RW(profiling);
 #endif
 
-#ifdef CONFIG_KEXEC_CORE
-static ssize_t kexec_loaded_show(struct kobject *kobj,
-				 struct kobj_attribute *attr, char *buf)
-{
-	return sysfs_emit(buf, "%d\n", !!kexec_image);
-}
-KERNEL_ATTR_RO(kexec_loaded);
-
-#ifdef CONFIG_CRASH_DUMP
-static ssize_t kexec_crash_loaded_show(struct kobject *kobj,
-				       struct kobj_attribute *attr, char *buf)
-{
-	return sysfs_emit(buf, "%d\n", kexec_crash_loaded());
-}
-KERNEL_ATTR_RO(kexec_crash_loaded);
-
-static ssize_t kexec_crash_size_show(struct kobject *kobj,
-				       struct kobj_attribute *attr, char *buf)
-{
-	ssize_t size = crash_get_memory_size();
-
-	if (size < 0)
-		return size;
-
-	return sysfs_emit(buf, "%zd\n", size);
-}
-static ssize_t kexec_crash_size_store(struct kobject *kobj,
-				   struct kobj_attribute *attr,
-				   const char *buf, size_t count)
-{
-	unsigned long cnt;
-	int ret;
-
-	if (kstrtoul(buf, 0, &cnt))
-		return -EINVAL;
-
-	ret = crash_shrink_memory(cnt);
-	return ret < 0 ? ret : count;
-}
-KERNEL_ATTR_RW(kexec_crash_size);
-
-#endif /* CONFIG_CRASH_DUMP*/
-#endif /* CONFIG_KEXEC_CORE */
-
 #ifdef CONFIG_VMCORE_INFO
 
 static ssize_t vmcoreinfo_show(struct kobject *kobj,
@@ -174,18 +130,6 @@ static ssize_t vmcoreinfo_show(struct kobject *kobj,
 }
 KERNEL_ATTR_RO(vmcoreinfo);
 
-#ifdef CONFIG_CRASH_HOTPLUG
-static ssize_t crash_elfcorehdr_size_show(struct kobject *kobj,
-			       struct kobj_attribute *attr, char *buf)
-{
-	unsigned int sz = crash_get_elfcorehdr_size();
-
-	return sysfs_emit(buf, "%u\n", sz);
-}
-KERNEL_ATTR_RO(crash_elfcorehdr_size);
-
-#endif
-
 #endif /* CONFIG_VMCORE_INFO */
 
 /* whether file capabilities are enabled */
@@ -255,18 +199,8 @@ static struct attribute * kernel_attrs[] = {
 #ifdef CONFIG_PROFILING
 	&profiling_attr.attr,
 #endif
-#ifdef CONFIG_KEXEC_CORE
-	&kexec_loaded_attr.attr,
-#ifdef CONFIG_CRASH_DUMP
-	&kexec_crash_loaded_attr.attr,
-	&kexec_crash_size_attr.attr,
-#endif
-#endif
 #ifdef CONFIG_VMCORE_INFO
 	&vmcoreinfo_attr.attr,
-#ifdef CONFIG_CRASH_HOTPLUG
-	&crash_elfcorehdr_size_attr.attr,
-#endif
 #endif
 #ifndef CONFIG_TINY_RCU
 	&rcu_expedited_attr.attr,
-- 
2.51.1


