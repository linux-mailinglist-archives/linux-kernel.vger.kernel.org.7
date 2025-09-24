Return-Path: <linux-kernel+bounces-831102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0DFB9B8B9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 20:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 613FB4E3123
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 18:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE9131A568;
	Wed, 24 Sep 2025 18:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eiaXysNV"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C78F31A068
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 18:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758739305; cv=none; b=p2mH/991CSaBffws1sfWhclyvHEONp4X1BkDglw2gK7JPScVvvGcVyyy8DkViPgKZblGhQEH2y58CF5GvE0l4+LnKkGeeMhw7idvrPsiSaJYTnU6GUEV1FSEagw2v0/x2bb+z561gnS9XHJwcvMPwtaEO2B31VJxP17bX8ifeSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758739305; c=relaxed/simple;
	bh=xLizdTHkQ3BucQ9+tUE3CUQArQrvw0fqNtQDnFBieeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b6IQAWvXfq40V+ROXgt0mNwFxjVPf7RNagHMatSIlC2nuhc09TUIdi1rQ0TqJr/Fh6UPB4CuJcitdxp6eYmQIHzOlYt9iYr8DVaCLz/8kH8urpsOmmXIW/6xuyKAwsXEXcRzUXYhB/RWlx2FNKOWGCKrfHjU7Qe5PrDoEHo2VM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eiaXysNV; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ODJW4k018428;
	Wed, 24 Sep 2025 18:41:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=PHCLozNs8XzpOCtAz
	+k9sPOC3h5UT0PplDyJSKTs6KU=; b=eiaXysNVGMMjCsw2yqwL2NrHEZseoY7m+
	5x0QXOff0iKT9a0F0tdHN1mjTko/uYDcB9GbWHDDZb3Fps0wx/56pWV1ioRTDY7s
	9EQklTbL0zpPoWDKY1/I0wX4P32F5+N1cx5fb/rGx7MAyxduRnzt45mj5O/N59Q4
	MXBkejaf3kEBXnXh09C3YOfONLtwIYuw/LQnN1icpkdcmrbXuSZFZ2wiqPIe8zWD
	jB74gzEaiHnxfWzw/noWj2jT+wyPkcX9N0ONEbqC646zXew49LQu7OqOFYru1zlP
	xIXiKqApnCuxr2wjNkpF8Ud4g2EWAa/3Zl/oyafQ0w6w5g7M/hcMg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499kwyrjxw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Sep 2025 18:41:25 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58OIeGjU030341;
	Wed, 24 Sep 2025 18:41:25 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499kwyrjxs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Sep 2025 18:41:25 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58OHEY4v019709;
	Wed, 24 Sep 2025 18:41:24 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49a83ka0cp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Sep 2025 18:41:24 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58OIfKEJ23068968
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Sep 2025 18:41:20 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 009C320043;
	Wed, 24 Sep 2025 18:41:20 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C0FB620040;
	Wed, 24 Sep 2025 18:41:15 +0000 (GMT)
Received: from li-218185cc-29b5-11b2-a85c-9a1300ae2e6e.ibm.com.com (unknown [9.39.28.85])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 24 Sep 2025 18:41:15 +0000 (GMT)
From: Donet Tom <donettom@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>
Cc: Ritesh Harjani <ritesh.list@gmail.com>,
        Aboorva Devarajan <aboorvad@linux.ibm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Danilo Krummrich <dakr@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>, Donet Tom <donettom@linux.ibm.com>
Subject: [PATCH 2/2] drivers/base/node: merge unregister_one_node() and unregister_node() to a single function.
Date: Thu, 25 Sep 2025 00:10:51 +0530
Message-ID: <c99d97e253378455f1b3b7bec5b0c830d4e73074.1758736423.git.donettom@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758736423.git.donettom@linux.ibm.com>
References: <cover.1758736423.git.donettom@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=J5Cq7BnS c=1 sm=1 tr=0 ts=68d43b55 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=sw-la1bpkcxN7rInSZYA:9
X-Proofpoint-GUID: 8z-p1hcRXPahib9S9HXeS57-bo1XE31D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxNSBTYWx0ZWRfX3psyah9vGzdF
 uGK2zJuP1W5l8Et2tLHmn/Y521Z6H3+76RoP0GPGB69mMb34qjvJVDHfCZBw08troUzQW8RPsWk
 Tdk7ekxgo50w6DKFZLm1tSp/c2P5CgMVAYutoNxufhwTYGuP9aHeN3UsG0oogIGtQgQfp5M0jVd
 7xA2tbWPGiV+OfrT+5eazGbephUXNlISC2BAr7zOAlwLICF+Y3zw7x5Hu0woaIVf3Ndhu4Gw/Zj
 bvifJCXIJNFszFpKQ11FRx21T036Zc3PvcSBVV58Mh0uKssGNnTuflfcX+szCwm5JralgUC8S7O
 6jz86Bq//CJ/IV894jjyMPuS5EtpNBz+c4ipsqvImXQIiTU2G5smwWQ8/Z6lAIyzrA+3huKX1dQ
 lrniVGl1
X-Proofpoint-ORIG-GUID: mwJEkKJ0QQId_Sm7pkbfjDCvGd3WXx2e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_04,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0
 phishscore=0 clxscore=1011 adultscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509200015

unregister_one_node() and unregister_node() are small functions.
This patch merges them into a single function named unregister_node()
to improve code readability.

No functional changes are introduced.

Signed-off-by: Donet Tom <donettom@linux.ibm.com>
---
 drivers/base/node.c  | 37 +++++++++++++++++--------------------
 include/linux/node.h |  6 ++----
 mm/memory_hotplug.c  |  4 ++--
 3 files changed, 21 insertions(+), 26 deletions(-)

diff --git a/drivers/base/node.c b/drivers/base/node.c
index eab620e29c78..d460c1675c77 100644
--- a/drivers/base/node.c
+++ b/drivers/base/node.c
@@ -638,23 +638,6 @@ static void node_device_release(struct device *dev)
 	kfree(to_node(dev));
 }
 
-/**
- * unregister_node - unregister a node device
- * @node: node going away
- *
- * Unregisters a node device @node.  All the devices on the node must be
- * unregistered before calling this function.
- */
-void unregister_node(struct node *node)
-{
-	hugetlb_unregister_node(node);
-	compaction_unregister_node(node);
-	reclaim_unregister_node(node);
-	node_remove_accesses(node);
-	node_remove_caches(node);
-	device_unregister(&node->dev);
-}
-
 struct node *node_devices[MAX_NUMNODES];
 
 /*
@@ -887,12 +870,26 @@ int register_node(int nid)
 	return error;
 }
 
-void unregister_one_node(int nid)
+/**
+ * unregister_node - unregister a node device
+ * @nid: nid of the node going away
+ *
+ * Unregisters the node device at node id  @nid.  All the devices on the
+ * node must be unregistered before calling this function.
+ */
+void unregister_node(int nid)
 {
-	if (!node_devices[nid])
+	struct node *node = node_devices[nid];
+
+	if (!node)
 		return;
 
-	unregister_node(node_devices[nid]);
+	hugetlb_unregister_node(node);
+	compaction_unregister_node(node);
+	reclaim_unregister_node(node);
+	node_remove_accesses(node);
+	node_remove_caches(node);
+	device_unregister(&node->dev);
 	node_devices[nid] = NULL;
 }
 
diff --git a/include/linux/node.h b/include/linux/node.h
index 4dcf876cd0b4..d721127964b3 100644
--- a/include/linux/node.h
+++ b/include/linux/node.h
@@ -124,8 +124,6 @@ static inline void register_memory_blocks_under_nodes(void)
 }
 #endif
 
-extern void unregister_node(struct node *node);
-
 struct node_notify {
 	int nid;
 };
@@ -169,7 +167,7 @@ static inline int hotplug_node_notifier(notifier_fn_t fn, int pri)
 extern void node_dev_init(void);
 /* Core of the node registration - only memory hotplug should use this */
 extern int register_node(int nid);
-extern void unregister_one_node(int nid);
+extern void unregister_node(int nid);
 extern int register_cpu_under_node(unsigned int cpu, unsigned int nid);
 extern int unregister_cpu_under_node(unsigned int cpu, unsigned int nid);
 extern void unregister_memory_block_under_nodes(struct memory_block *mem_blk);
@@ -185,7 +183,7 @@ static inline int register_node(int nid)
 {
 	return 0;
 }
-static inline int unregister_one_node(int nid)
+static inline int unregister_node(int nid)
 {
 	return 0;
 }
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 6c050d867031..94a8f6e8811a 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1596,7 +1596,7 @@ int add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
 error:
 	if (new_node) {
 		node_set_offline(nid);
-		unregister_one_node(nid);
+		unregister_node(nid);
 	}
 error_memblock_remove:
 	if (IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK))
@@ -2201,7 +2201,7 @@ void try_offline_node(int nid)
 	 * node now.
 	 */
 	node_set_offline(nid);
-	unregister_one_node(nid);
+	unregister_node(nid);
 }
 EXPORT_SYMBOL(try_offline_node);
 
-- 
2.51.0


