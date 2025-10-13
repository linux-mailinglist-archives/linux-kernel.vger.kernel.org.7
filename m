Return-Path: <linux-kernel+bounces-851546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 761DEBD6BC9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 01:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7019A40166A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 23:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E572DBF5E;
	Mon, 13 Oct 2025 23:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="JVtXogSH"
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020134.outbound.protection.outlook.com [52.101.85.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531ED2C15B4
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 23:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760398118; cv=fail; b=Bl055fU/M5wo/QZlO8NBdbi19Pag9JNctovBdv+aQioeG7eo9fXlGsjC9EUAOsOIZGvZLsoqFIkRhMSOp07pNe2AtXkhG3SJd/muQbcsFghNR8foTIeGGgImZXQPxlXN7eHiq5C1xqmRgHck07O4ZqxSKuJIZvAkrkYUpvjYb0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760398118; c=relaxed/simple;
	bh=ejZ2lT1qLgBiS9Tx5GacRR8HPp2woVijysmjBIA8bcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XaIv4SFuXcHp8ZV0Mv9HULXa15/DQcqGqdvE5C4O5OyIDRDSI7KGHluKSaFie1q+YwJO4pUO/pFGLBthuhlLgbf7RXA0vVYFCxNjNfCATFI/DS8ogERfMtPVyvRy8vT4JauENV1iC+7g0d/PGVpmfyFQVGko7zOP954jbT8dBRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=JVtXogSH; arc=fail smtp.client-ip=52.101.85.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HunPnS0TkANC9ibVF0KroyG1IbgRmxrkTxbIFk3q7B5v5L8T7lZ/TfUwC3ICTOSwTn9aHgVu+K0qQ3DQhoR5DR7/Cngz5xQ4hqWoS2EM/cd2hxXyVu7YnuNZZEwfeDMB8750Txa/9c8Bcq0hkHFXYSmO8TJO0nP3GWg2K9xV4w7e0eDe2hmGVUu4tBhqPSUV0fUHX4d0vBgg1BUsKhCpwXnX1Tde5eicncPenmcR+Oub6n5WC7uDjZ+yxD8I3isVZpbwSPLnUiphlbGkhUIhXkWav3PkY7OKCEgakJ26YhxvWhgnokPUSkVo972vPUcIZk0kP9SJS7XFXj5cVspEHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VRUCapM2t+sTdxCZRFF1NwLezRUvT4nTQ4wQbl5DqXA=;
 b=qtLRZqKyUD9xPcvE1roL7Q5zI+SqFL4vg5FBOP+UNdR7tdEG2wfncAhHrXOV9mPIAJzkFTsxf9rpAqN5/hQxM9fBm/QWeMVSJoCzQkkEUMoC/PakBsXggHORaew6L2UMSaAZ+Pv9ua0TvO1zXmyAOGFqfbM/YYCq10UTqvO4rQpxrIQptXkJAmiBZ1WvrxmB2gszuZ4mzPNL+tksDb7kWAbItuy9pcp8qafXrL4QbV/QcV1PuGXKa7aseWrmrKzjdmirn5UduTNbg4IfARLkobFL/SdsNwVas9fjatGdCLIb5UcAvMTHGkDncPubfXTStNlJ4m1jSI6FaCoFiasxYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VRUCapM2t+sTdxCZRFF1NwLezRUvT4nTQ4wQbl5DqXA=;
 b=JVtXogSHXPM41Mau4jnF6ba9hnqAh0iIdBTWpYNYHqGPXf2zPchid50NjNlEji4YAbJ/MhQNLb0GegmSRZP5NTo3Nqzw1vP1lITKvDxAgAdvCItv7eKx67aRei+SRhTueV3x28wZ5lTTaQFALkIl+6XN+r/P8oWVC7lL5ny5ZJ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 PH0PR01MB7368.prod.exchangelabs.com (2603:10b6:510:10c::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.12; Mon, 13 Oct 2025 23:28:33 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%3]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 23:28:33 +0000
From: Yang Shi <yang@os.amperecomputing.com>
To: ryan.roberts@arm.com,
	dev.jain@arm.com,
	cl@gentwo.org,
	catalin.marinas@arm.com,
	will@kernel.org
Cc: yang@os.amperecomputing.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] arm64: mm: make linear mapping permission update more robust for patial range
Date: Mon, 13 Oct 2025 16:27:30 -0700
Message-ID: <20251013232803.3065100-2-yang@os.amperecomputing.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013232803.3065100-1-yang@os.amperecomputing.com>
References: <20251013232803.3065100-1-yang@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7PR17CA0031.namprd17.prod.outlook.com
 (2603:10b6:510:323::14) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|PH0PR01MB7368:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d460f17-d50d-4d53-a9eb-08de0ab039e1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uJFfb6qqNwjviyg3QnEEymP6zo/mowmdW26/syqNQdMDpy5nrmfuZU/vc+/Q?=
 =?us-ascii?Q?+hxwSa6Vr+a+abRtYUkFo8Zlx+jcB8+CqRw4ew4UC6UOjfsZDrQFJ+Cdy7wp?=
 =?us-ascii?Q?e1pZBd638FEvrAuJ3VEhCvMGawEVUsCCqgRnJGuSBP1Y1+8TXyBNWeUIgsX5?=
 =?us-ascii?Q?ko+thq6oJexfjR8YMzYSMlxY2D+SADUmGTOP2P/u+G2MvzW5VAAN9ggJfmeX?=
 =?us-ascii?Q?IQOU/++fxnEMOQ5bzagKhfP7fqqF/KK3eZww/SxuvE6weAQ4hddStgF8fdwV?=
 =?us-ascii?Q?jfF1Xh4MnTFEyz8Vj/iebJeEVtNhd7goYNQVCWlxeSNHfe9isK/BmyG1ZGx9?=
 =?us-ascii?Q?X+JqPHV8EvfqOrXJ/acOl8yYrmZf8H6q84nsyMWvsuGnEU25wK8jQdsE7KVF?=
 =?us-ascii?Q?OJy9wOD7A69uozhZSdJgr/Td2nr3w26jDYMN+I9emfxLmb3F93hGhZnTIaJN?=
 =?us-ascii?Q?TBMr5y1GOlsh28BXcE+A1oDj+UIpvlwIMETYVZQ+nZzBs5D9daIu/v+SfPW/?=
 =?us-ascii?Q?6PqgtBl0yiKpNRbM85BLX90GTn1r0O+Kx86Su4QWHTJQuruAzznkT/UgICcf?=
 =?us-ascii?Q?ovLJxSZ6mFJwKJSH4pXn/Dh3ZzEp/RrjnRW9s1HXnHZnznrR4cKRUqpRTWjH?=
 =?us-ascii?Q?yb2zi/zYdnvxZItoNCCt337j4OF8XC00lz/qQu4EF79uQ05HWfDceW4n3JqI?=
 =?us-ascii?Q?XOUZ6LFbBOAM0cSXwwT1t9FI2tI6jet8EShU/krgQQ4VXgAba7l9AGUKOTle?=
 =?us-ascii?Q?vcnv1s5pKBp3xlvn67MamZ8MavGQtY9pQIUhQch/Absm402byfHn5A6mRkDl?=
 =?us-ascii?Q?nSQSLWCjTwJ1bHLbJtjma3ywr50II8tePqeBfkfWwKxtJxAbDSCPNjcCFS/a?=
 =?us-ascii?Q?CYFss1FOJDLrdg1ePBRJwEr9+U/rRDLoeP3x2SEqO/SSOeAlxEsdtUIxjfSF?=
 =?us-ascii?Q?26MUjApbxS1EHXYwfHxP76sxY/nzCIOFumzZdF1VomjOlaJVhD4eDHZDdjAu?=
 =?us-ascii?Q?Ynq5eTlIAVD2D+SNf7UZ7WD3cyhvA/xXChnL7I1a4Y1MhIgKZ652A88nFXbK?=
 =?us-ascii?Q?hxeZMIOuRz9zQ27VPjygZqFENA8YSBaU0jbLY0fI21DfDqsqbZLXjZYQq1G/?=
 =?us-ascii?Q?3cvb5ysG4sBR8O0LDwiYrQ9vV190nvfVZvpusB8a75W3HvTyYGs7iQTFoUsw?=
 =?us-ascii?Q?p3OBPct1dQ/xm/KTsZnI9jMyzBRgFpiVDL6nbHKSjUG2g2caebKf+e/G/Y0h?=
 =?us-ascii?Q?xvkyyYvnpgcG7S4pZslmOnad9Cln3ohGpHDgkuUIPg3XMPDwVWQfTxeWCuFM?=
 =?us-ascii?Q?b59KECFjipc4iMMqE6iq1F2eVKEVp69dy9iswDXjk1Cv3aIY9UHyECqnVy7S?=
 =?us-ascii?Q?Lk9XlJ4l+w0roAv96820Z3cuPQm8LglhUPDqHRuwMQeuUSeDfuNhhBoN2evb?=
 =?us-ascii?Q?7l66YtSRZnLYu1dvphdVh5wiFchIdMjQGQcPlUPWUypPmUVEPEKf1JpuSoh0?=
 =?us-ascii?Q?cTnK78C1MHN/jJoQtNGmOCB4I5WEWVDPku0O?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TsBdh1l2Ft6hF46moFYTI2rIOz+3uc4eTMG2cmnI24I4hrogxnOAx36OPY8n?=
 =?us-ascii?Q?QK5+CQeO+xJiQTeUXWpxjU+DrGPDo1VjDughANC+uZjgWPS2fGrYHo7rlOCN?=
 =?us-ascii?Q?YYWxL889HEn9O5G+sGGO69wsB3DySiKq8myI9gBykfnWstwHzOK/nJxGu/26?=
 =?us-ascii?Q?7hZEAZnWPZJkr209SOLazxZc+fZjCMJnMw9USDN4ztYyBoaVQU1r3IPObq+j?=
 =?us-ascii?Q?dGxx//w9c78FtIkVDAbVbAILQKq7nw+e8xDhCj4Z4uWEkcLH2E2LT58iPoqM?=
 =?us-ascii?Q?GeK6KgUl+DlmOmDvljoN6WGwvQmdj5vh6AI99Hr58+LnM2CUVGFek4XegkM8?=
 =?us-ascii?Q?lv945ZXJxefFC6JGL7HDtXgI4ZSLoJRjmG4T6hGP6ib3dh7PNVs7XK4/19WR?=
 =?us-ascii?Q?KxIILxbXy8bdJyQHxm7fBjaCH1+iOQ6kA7cCMUwC0i6zweriILucD7QqONKI?=
 =?us-ascii?Q?U6c00T+VmzVS6OATbwbdehqCEYD8BQwjkbYkfBhlnDgM+o5wu5vVM+1tblpy?=
 =?us-ascii?Q?yi3KDb7rVHp+eT730HcPt7TBTuiGR9RjtJ7rpF4AMvk9xcz5A1g6ZI65RrjF?=
 =?us-ascii?Q?lZQsx1FN1KvSEWiwHxUtfncrgLzKm1rC+B9c5mqmg1ZzoyWnyDKY63Y0ebxv?=
 =?us-ascii?Q?9MQEvRzQaMPv00n8lxw41mPvyCS6ZCN+4tlxUYQWGqMqIqvo+1nbAcspr5zm?=
 =?us-ascii?Q?3UHOt5cde3jXmRpIdzS8a54EfGHRm6o3hqDNh5Y/Dm5irv4mv4aLVIWMIv+m?=
 =?us-ascii?Q?4RoXr9BKtId6kofnAGfmVyGsEIrBgj69AvYyU1QICGCx9LQJIXcZH8cBD88M?=
 =?us-ascii?Q?XTGq5fNgGHYogThTvEl+BhAM3G3XxKVQ/fJuNbaKdp+DpmjL278GWTeLvfbk?=
 =?us-ascii?Q?RTNTn+THDim60QeUNGGzh3OeW0YMkW/uLQs2fcnJhCJ1o+H7CEBB5kPRnsjC?=
 =?us-ascii?Q?+Fu9U0w15ScJMfOQPsEwBZpCTLdxDcMfDJdIL/2noitm9kHr/MfDshiBdmaU?=
 =?us-ascii?Q?gvRYZzR2EVVITye6864uETTYtVAGzGxeMsdZNE7cOawfSegJfCoGn/a+3iH5?=
 =?us-ascii?Q?AogNfO8SFE9V8wqnCmyL/nxkB6svaViHbeGZcK9fn978PcVi9TUzwl0Y3UOw?=
 =?us-ascii?Q?1k4GM2Clz26MggSA9V9zcZ6HWIyYcPH9JoToMpwpvP4hkGuINMGiXepFdUuV?=
 =?us-ascii?Q?VQDrEcBebH69nJ0RYblXGwh8o7FqbYDJJsCjq/ObDYZAdeJF4Z0GXsfVI0ts?=
 =?us-ascii?Q?YyGD/+PJ6y4zL5i6xEaFab1n0sZ1Imq7/VwpiLspuvel+s1eqTUnAU0MBPxf?=
 =?us-ascii?Q?ac/NUY4dWyUp3w1Qn2RP/7uGkjICRBvmUowl1A495DwuQHaaFCch4TUe+NKp?=
 =?us-ascii?Q?yJRb1r6Z+GB6p0VvF+FofAFyIHpVQG2xx7yVMuxOo89ePdXCuboLt2AxFApK?=
 =?us-ascii?Q?FV+M5c78L8L4TMbYGALACkEIu/IhuO/NZOH0iOiSoMLvvVZ85JVGZHIlDbch?=
 =?us-ascii?Q?1SQ9Z9Jft5DL7fG54Z3Uw4BX8VysypQ7iB7lbjxJqpXpBBY5nyg+3/T4o7cE?=
 =?us-ascii?Q?vaOwzaMDGM+Gz1z/hR4ve/M+O7hHi4+uXThthQDvM9C73DtXZbEyIM+dkOZn?=
 =?us-ascii?Q?H0JhDiOs3MzVqf5iMOyKEec=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d460f17-d50d-4d53-a9eb-08de0ab039e1
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 23:28:33.6397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JTF7aZAK1w2EFYAD5c1zV5kfGV/zljoVvwVOIjwxYDa2uL5LNUAIebVasZbaLReF9i+EQgdoCTMdYSKb840v/0SiPQbJ06mWsFr6Vu/nF4U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB7368

The commit fcf8dda8cc48 ("arm64: pageattr: Explicitly bail out when changing
permissions for vmalloc_huge mappings") made permission update for
partial range more robust. But the linear mapping permission update
still assumes update the whole range by iterating from the first page
all the way to the last page of the area.

Make it more robust by updating the linear mapping permission from the
page mapped by start address, and update the number of numpages.

Fixes: fcf8dda8cc48 ("arm64: pageattr: Explicitly bail out when changing permissions for vmalloc_huge mappings")
Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
---
 arch/arm64/mm/pageattr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
index 5135f2d66958..c21a2c319028 100644
--- a/arch/arm64/mm/pageattr.c
+++ b/arch/arm64/mm/pageattr.c
@@ -148,7 +148,6 @@ static int change_memory_common(unsigned long addr, int numpages,
 	unsigned long size = PAGE_SIZE * numpages;
 	unsigned long end = start + size;
 	struct vm_struct *area;
-	int i;
 
 	if (!PAGE_ALIGNED(addr)) {
 		start &= PAGE_MASK;
@@ -184,8 +183,9 @@ static int change_memory_common(unsigned long addr, int numpages,
 	 */
 	if (rodata_full && (pgprot_val(set_mask) == PTE_RDONLY ||
 			    pgprot_val(clear_mask) == PTE_RDONLY)) {
-		for (i = 0; i < area->nr_pages; i++) {
-			__change_memory_common((u64)page_address(area->pages[i]),
+		unsigned long idx = (start - (unsigned long)area->addr) >> PAGE_SHIFT;
+		for (int i = 0; i < numpages; i++) {
+			__change_memory_common((u64)page_address(area->pages[idx++]),
 					       PAGE_SIZE, set_mask, clear_mask);
 		}
 	}
-- 
2.47.0


