Return-Path: <linux-kernel+bounces-853010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 23169BDA77F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 17:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A6F80505373
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9858F3002DB;
	Tue, 14 Oct 2025 15:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="s+Vgw+ku"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF3E3009C3
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 15:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760456398; cv=none; b=VuGRGlgoPga6rGmqAL9JFKaAd71Eu2EjeGldXlndC1mFUI5Y0Wg5nA+u0r0tEFblfGOcYX++7OjxIqLbLbR2jDUQ+gITPI0xR9m4i2EEvYDetNA+I0UT13++uIdQviLoYlfNUHlqypVMvLDhwMlNfWY9NYWk1eLI5xbcBabr/Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760456398; c=relaxed/simple;
	bh=rk+aJJJEXbjTHLnke1yw0+GMbhI53oCscjfgR830NnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MdFLNtvCn5oCTBc3sG0qPcg5xSpfw9W1YQdAGmRnIkbG6T7QekEGN7vFtU0v15c72DbC5VICGbWzRY/hS+nn6HmcwRkx0C6yQSe441609N6DoWjQDtSI92j2cIK5LIb/STizf5nI81wGRMsEJ+TQtRxxY/o7zbkRWRQ6bxuMeXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=s+Vgw+ku; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59E7VB7v003920;
	Tue, 14 Oct 2025 15:39:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=gvxPlkHyNN4Ev5gVw
	dQJWsjGxQipg71xBw6FqJLZhTs=; b=s+Vgw+kujD7UJ+KsoqEcaOaFNiell3E+j
	O/4+UTYOrGgymLOhKbWDHmwrrtK9tk7rCajzBDCIZiHX9m31a4/c/XWjoHkwJ69E
	E6IDOyOoU86AwnmduuFULDdb4dxXtA+ZnKEZWN4S7l/iIBTXc63TL2otgeMYCUpd
	du74BSyyDE5h4kwBMKk/pcotAVlBF5EAn8p4UrARfvssNyt+3K5csIfCV4VPbyGS
	KsNftS3JXSC5OTIzhRKjCipvBhwsJS8E0kjAVnSon7tAY4XXdApZjt3C99Tm6e3K
	EW1pIneV4cNBJNYnIcqxUlujFvxQkMvDFaL4ebvjmDeh9JHYs+fRA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qdnpf5yy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Oct 2025 15:39:37 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59EFagnO026314;
	Tue, 14 Oct 2025 15:39:36 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qdnpf5yv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Oct 2025 15:39:36 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59EFJC0F016705;
	Tue, 14 Oct 2025 15:39:35 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49r32juk80-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Oct 2025 15:39:35 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59EFdVCV25363010
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Oct 2025 15:39:31 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B547220063;
	Tue, 14 Oct 2025 15:39:31 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 766D02004D;
	Tue, 14 Oct 2025 15:39:28 +0000 (GMT)
Received: from li-218185cc-29b5-11b2-a85c-9a1300ae2e6e.in.ibm.com (unknown [9.109.215.183])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 14 Oct 2025 15:39:28 +0000 (GMT)
From: Donet Tom <donettom@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>
Cc: Ritesh Harjani <ritesh.list@gmail.com>,
        Aboorva Devarajan <aboorvad@linux.ibm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rafael@kernel.org, Danilo Krummrich <dakr@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>, Donet Tom <donettom@linux.ibm.com>
Subject: [PATCH v2 1/2] drivers/base/node: Fold register_node() into register_one_node()
Date: Tue, 14 Oct 2025 21:09:16 +0530
Message-ID: <910853c9dd61f7a2190a56cba101e73e9c6859be.1760097207.git.donettom@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1760097207.git.donettom@linux.ibm.com>
References: <cover.1760097207.git.donettom@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAwNSBTYWx0ZWRfX6GjH7wqcz2zp
 /D+UekZgPJq2hB9+MnN9YhX6lI9/fCVcjxfkufO6cf4Hnm2uKk7rpeCG9Tq08lxz/SIohOtVWTT
 WEgW0Y6lc2dyE51H+LG6rZdN7o/yktTid9KkbHxKaUqWtgM5/eqvNyelkDCAgYvUulFMvq3cqFF
 OzIiYLE/JGlAcLQyt4bfvY57xJpGX4WHrVPr51sbFstzSUoTKZW2RraxVNExz2V3OZc8n9iWYMV
 IQrswSXM4jycgHMBRAHN0GFKkWTUGGqYBvFFgiKWGneqojgvg6qhPxY4iWIGjolaHk4xbU5OSCr
 wufqmTfMjPzwwITOREIR3BdduZW0mPZBZoSIttLKhCj1hCpxpO9fP5sXcVSJsGjks68U/w7FC7P
 VsRWj/KYvvtV4tTl60xExsNt5x50UQ==
X-Proofpoint-ORIG-GUID: l_I2HrfiHWEnvMKBjXDGi9IWrPwWedBN
X-Proofpoint-GUID: LQUticiJ96BWNad8aIbiIvHuVJLWPtDE
X-Authority-Analysis: v=2.4 cv=MoxfKmae c=1 sm=1 tr=0 ts=68ee6eb9 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=TH3b8Etr9zJLuk16028A:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110005

The function register_node() is only called from register_one_node().
This patch folds register_node() into its only caller and renames
register_one_node() to register_node().

This reduces unnecessary indirection and simplifies the code structure.
No functional changes are introduced.

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Donet Tom <donettom@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/pci_dlpar.c |  2 +-
 arch/x86/mm/numa.c                         |  4 +-
 drivers/base/node.c                        | 52 +++++++++-------------
 include/linux/node.h                       |  4 +-
 mm/memory_hotplug.c                        |  4 +-
 mm/mm_init.c                               |  2 +-
 6 files changed, 28 insertions(+), 40 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/pci_dlpar.c b/arch/powerpc/platforms/pseries/pci_dlpar.c
index aeb8633a3d00..8c77ec7980de 100644
--- a/arch/powerpc/platforms/pseries/pci_dlpar.c
+++ b/arch/powerpc/platforms/pseries/pci_dlpar.c
@@ -29,7 +29,7 @@ struct pci_controller *init_phb_dynamic(struct device_node *dn)
 	nid = of_node_to_nid(dn);
 	if (likely((nid) >= 0)) {
 		if (!node_online(nid)) {
-			if (register_one_node(nid)) {
+			if (register_node(nid)) {
 				pr_err("PCI: Failed to register node %d\n", nid);
 			} else {
 				update_numa_distance(dn);
diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index c24890c40138..7a97327140df 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -262,7 +262,7 @@ void __init init_gi_nodes(void)
 	 * bringup_nonboot_cpus
 	 *  cpu_up
 	 *   __try_online_node
-	 *    register_one_node
+	 *    register_node
 	 * because node_subsys is not initialized yet.
 	 * TODO remove dependency on node_online
 	 */
@@ -303,7 +303,7 @@ void __init init_cpu_to_node(void)
 		 * bringup_nonboot_cpus
 		 *  cpu_up
 		 *   __try_online_node
-		 *    register_one_node
+		 *    register_node
 		 * because node_subsys is not initialized yet.
 		 * TODO remove dependency on node_online
 		 */
diff --git a/drivers/base/node.c b/drivers/base/node.c
index 83aeb0518e1d..4bcaa8006cd6 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -676,33 +676,6 @@ static void node_device_release(struct device *dev)
 	kfree(to_node(dev));
 }
 
-/*
- * register_node - Setup a sysfs device for a node.
- * @num - Node number to use when creating the device.
- *
- * Initialize and register the node device.
- */
-static int register_node(struct node *node, int num)
-{
-	int error;
-
-	node->dev.id = num;
-	node->dev.bus = &node_subsys;
-	node->dev.release = node_device_release;
-	node->dev.groups = node_dev_groups;
-	error = device_register(&node->dev);
-
-	if (error) {
-		put_device(&node->dev);
-	} else {
-		hugetlb_register_node(node);
-		compaction_register_node(node);
-		reclaim_register_node(node);
-	}
-
-	return error;
-}
-
 /**
  * unregister_node - unregister a node device
  * @node: node going away
@@ -907,7 +880,13 @@ void register_memory_blocks_under_node_hotplug(int nid, unsigned long start_pfn,
 }
 #endif /* CONFIG_MEMORY_HOTPLUG */
 
-int register_one_node(int nid)
+/**
+ * register_node - Initialize and register the node device.
+ * @nid - Node number to use when creating the device.
+ *
+ * Return: 0 on success, -errno otherwise
+ */
+int register_node(int nid)
 {
 	int error;
 	int cpu;
@@ -918,14 +897,23 @@ int register_one_node(int nid)
 		return -ENOMEM;
 
 	INIT_LIST_HEAD(&node->access_list);
-	node_devices[nid] = node;
 
-	error = register_node(node_devices[nid], nid);
+	node->dev.id = nid;
+	node->dev.bus = &node_subsys;
+	node->dev.release = node_device_release;
+	node->dev.groups = node_dev_groups;
+
+	error = device_register(&node->dev);
 	if (error) {
-		node_devices[nid] = NULL;
+		put_device(&node->dev);
 		return error;
 	}
 
+	node_devices[nid] = node;
+	hugetlb_register_node(node);
+	compaction_register_node(node);
+	reclaim_register_node(node);
+
 	/* link cpu under this node */
 	for_each_present_cpu(cpu) {
 		if (cpu_to_node(cpu) == nid)
@@ -1018,7 +1006,7 @@ void __init node_dev_init(void)
 	 * to already created cpu devices.
 	 */
 	for_each_online_node(i) {
-		ret =  register_one_node(i);
+		ret =  register_node(i);
 		if (ret)
 			panic("%s() failed to add node: %d\n", __func__, ret);
 	}
diff --git a/include/linux/node.h b/include/linux/node.h
index 866e3323f1fd..b7028d3ec3b4 100644
--- a/include/linux/node.h
+++ b/include/linux/node.h
@@ -176,7 +176,7 @@ static inline int hotplug_node_notifier(notifier_fn_t fn, int pri)
 #ifdef CONFIG_NUMA
 extern void node_dev_init(void);
 /* Core of the node registration - only memory hotplug should use this */
-extern int register_one_node(int nid);
+int register_node(int nid);
 extern void unregister_one_node(int nid);
 extern int register_cpu_under_node(unsigned int cpu, unsigned int nid);
 extern int unregister_cpu_under_node(unsigned int cpu, unsigned int nid);
@@ -189,7 +189,7 @@ extern int register_memory_node_under_compute_node(unsigned int mem_nid,
 static inline void node_dev_init(void)
 {
 }
-static inline int register_one_node(int nid)
+static inline int register_node(int nid)
 {
 	return 0;
 }
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 0be83039c3b5..6c050d867031 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1311,7 +1311,7 @@ static int __try_online_node(int nid, bool set_node_online)
 
 	if (set_node_online) {
 		node_set_online(nid);
-		ret = register_one_node(nid);
+		ret = register_node(nid);
 		BUG_ON(ret);
 	}
 out:
@@ -1542,7 +1542,7 @@ int add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
 		goto error_memblock_remove;
 	if (ret) {
 		node_set_online(nid);
-		ret = register_one_node(nid);
+		ret = register_node(nid);
 		if (WARN_ON(ret)) {
 			node_set_offline(nid);
 			goto error_memblock_remove;
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 3db2dea7db4c..d9ef05c4dc5b 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1909,7 +1909,7 @@ void __init free_area_init(unsigned long *max_zone_pfn)
 		free_area_init_node(nid);
 
 		/*
-		 * No sysfs hierarchy will be created via register_one_node()
+		 * No sysfs hierarchy will be created via register_node()
 		 *for memory-less node because here it's not marked as N_MEMORY
 		 *and won't be set online later. The benefit is userspace
 		 *program won't be confused by sysfs files/directories of
-- 
2.47.1


