Return-Path: <linux-kernel+bounces-851547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ABF5BD6BCC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 01:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 914774E3260
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 23:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64BEB2EFD95;
	Mon, 13 Oct 2025 23:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="JcglVvGB"
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11020134.outbound.protection.outlook.com [52.101.85.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D032D879F
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 23:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760398120; cv=fail; b=UahOgvJlCsurPWpwLNot/5E/cCxbZzpnpgpvXwA00n8gfGtoIE+5CxfCx1iZbaQgPQ1qn2kaA90berXieNIieqX66MnLba2TkoxpofhlZk7dEVK15MxLmWX69gETSlEFiUgfrzy14QSvcKQ0c/lYTAKh34jHsDFFX/xClX4ByAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760398120; c=relaxed/simple;
	bh=2SaFLU9tv+sl3PHyfXeTpD7Q5ETHV3yztgfMgmyb/jI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aJ6H2euEfcGizbVecO2Lr9C3XP+OTCw7p8/9+7Wq21mALEREkjPI33Mqp6AS+t8o/hqNFOXCUNRJN3BpbRg5Zuo5DHgexGUoRNi3cMeWgZepcEnJTJguSWkuXefeCckOacSO06lftlALepU9FxpGN3mc7GnS0Io/Eyd/Xroer1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=JcglVvGB; arc=fail smtp.client-ip=52.101.85.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fcjbpRwjjc4A1aSPP1EvKtbH4oBEfa1bH9Yvx1b8dQMdh4lgisMEWCHOPSzlI/aCYySsY9QrjEyIMrrkiXNiHE+GfoW6mvf25gttrGqPZPVejbM93NmASnxApbqX5cnKDYyAH4tRiS/+CGu7xSl6xn0n1QRc0PcWFvEmgmji6kE5kL9hLluy2PsQern3lCzUYb23HqJnSWtJwx8hBCq8ZVaNHowoGJum3zTlwT3JCCrKnTPJT6nlyXA633B/eIa16DFkROWBMIePTD6Ixy1ducci+F+qMjmc4pOPFG9ijmx1mGKKSiZaFTAVuXb+irYALZuuVr3xBS/+QnIhApKnQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5qUOvrlax7JuZyR8Zrn0og9hxRzSsCMx0fAYhntoNrc=;
 b=KvG9cRuRoSsFFzcEtRUcd2F/2bR3OdrVKWR/b8LC2EogwBH86zh5f3WWqgVyJ+Qm+G5BASKVjUNFE2Imh5apkSdJL+SSmCboeoKDU9mpU9PirQ1tuAAExbJvdjEV+i3ajOihqBkngS0XsQ5yQPdoj7rscmDQBpEgDH45XbD2C1uRR/BeGZtyB0Mv3m0nmUfxaaKZAVr8XpqCB5S8tHkgi/QOVkJDBgkgJ28FHYFu2dsTqNmdLCgMbr7rIerqFTiN8CyToTIbVYcbaJg7VvNpPkrqK4J3n6JsCt/4/InoF/F/gcZxrjjK2QJkasVP22Y/jGpk9XBRR8DvtPGGLx5urg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5qUOvrlax7JuZyR8Zrn0og9hxRzSsCMx0fAYhntoNrc=;
 b=JcglVvGB19/j1EDZs8Z3EP9yQ+SVdqDrQQXeukpCdFruggGEZN9OCinW7cTjMu2y16wSOyHnaIP06jWinD6Itl0UW6Bmote9rmT88WRJN/qJLplkJw8gAhK3lD3GlBZE9bQYgVQHtSjOpkDSCJl66evkDyILJvAeDHDRUAZGfvo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 PH0PR01MB7368.prod.exchangelabs.com (2603:10b6:510:10c::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.12; Mon, 13 Oct 2025 23:28:34 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%3]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 23:28:34 +0000
From: Yang Shi <yang@os.amperecomputing.com>
To: ryan.roberts@arm.com,
	dev.jain@arm.com,
	cl@gentwo.org,
	catalin.marinas@arm.com,
	will@kernel.org
Cc: yang@os.amperecomputing.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: mm: relax VM_ALLOW_HUGE_VMAP if BBML2_NOABORT is supported
Date: Mon, 13 Oct 2025 16:27:31 -0700
Message-ID: <20251013232803.3065100-3-yang@os.amperecomputing.com>
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
X-MS-Office365-Filtering-Correlation-Id: f454ebca-2179-457c-ffeb-08de0ab03a81
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GQG6NSX0YhBqQWAddZ41htnb5cfnIHBsXlEbiYzwQTFH+OWmBxkAmNYUUzyN?=
 =?us-ascii?Q?cgh2wPMs8Q0tmLdUDcNFxfRONsRHqcrT7CMDQW+HDYm/c5H52zAaIkxRjul5?=
 =?us-ascii?Q?ys6HdsUdg4tZPkIJ/QG2fxySdAZFjuLy2pIOcmMX65XRq8ZbdSTtkF05D6wc?=
 =?us-ascii?Q?HqobH+0gJ4KmH78sXt9qYZuiAlc5+6gB1RE4hlCFd2gOp/LdtnMipG4eb5v+?=
 =?us-ascii?Q?W+0djwxH7UK4KtRU7HXIJw05ig+MV0hB/I4HZaCHEJSHS7AYJLCwGW9Va54f?=
 =?us-ascii?Q?Nh/+UeODlJMpC3sln4B+1N+WOpZziXtu8D/6Ey2zZesUkmLGJ+0d+tj4cGLG?=
 =?us-ascii?Q?eur6qn6gcvp0RSZG7cN3EKAax31AyJwPtKHhbWOVLnoZ+HvHlvnwDg1ypvSm?=
 =?us-ascii?Q?y6e1d/X0vxtE4zCP68V/YTNHYYhBzin0Fw9+QeO95sPFGKu3/3UzlMROE8BU?=
 =?us-ascii?Q?iZA9n0Nu7FZ4pXF+Iq48t530O5oF8h+tV7brDcDyx5OY87+zKxiwTBNqbu1C?=
 =?us-ascii?Q?GO5WO7Ubjnhw69gVygCEbYne4+iuxM2K8G4+s0TMOY038z8u3yZ0NYUF9Vow?=
 =?us-ascii?Q?aKiae1W4fY7vA74waSAHbIj0uJlPI9TjX5apGuL59bRWo0n0sBt7QMgSkPC5?=
 =?us-ascii?Q?iEkXEJlAI7alKA33AsCjJGaLbsc0JfsISZ7qV5v/t/owlvOvGJechI859a2N?=
 =?us-ascii?Q?NMXShUiuVU/NKP+5lxV4vOM3RAS4XVCHoQFm5vL+EkvynV5L8ChE84mn3hS4?=
 =?us-ascii?Q?xbgoxYxOdhZNd6dP5OCABXlUSaGTjj9mWjFOYIExxZbvqWg5kfJUSOcVe+Ay?=
 =?us-ascii?Q?QsrXeoj8w9ejsNyfJxBcx64HbtDJsze4pmSfv6cmiLPZxmnjD6HwGm7ODNZu?=
 =?us-ascii?Q?na8pzlMu4ny9SLa3JjQcwhDzcxQ4ONnXDSyeImoZgbdjK0gcRdjsW7+6YREG?=
 =?us-ascii?Q?ZpN+oxu2fw/TFSx3LvFcOM2nzfOvjSi07ucl5aYY6IS/raKOvvr1Od6yGsYP?=
 =?us-ascii?Q?hovDsIBiWthjsMCf3LcAEHQU3QZCsPd0Ybh4NYOCn3hWtmrTc+HD8c9xNEm9?=
 =?us-ascii?Q?yi2iDBAHdVCDoBv73tdV22M2pX1hE2wjepaq5OmF9MKXlwDfpm9Yj5tizBEy?=
 =?us-ascii?Q?i0FGD85g6BbKkGONkomJNGMlmjqhPdB2Ss+mTz1F0bowTQjIz7+KAJqIu8as?=
 =?us-ascii?Q?FAYPhdOKmIXkyGstUVDtuNtcZtvruOu0C5wMKzRL4tI6+W6JpPMviTZmgZeu?=
 =?us-ascii?Q?q9ob2MPaw1OltnQGiODnstCdSipmc9aYzCEmGX2azssTNeFNyyruFSHkz+SD?=
 =?us-ascii?Q?Fqwp6jBCpBQxd0yjWEMsFQwnEV6+6n6tdF54Rp3730WYQ4u8EOe55iNGMkGw?=
 =?us-ascii?Q?jmZFs38m2+cyzOgTGgNWuhUREhwLCMguJUAdhOaVUuupQyH0rdCXCMqou+n5?=
 =?us-ascii?Q?+wptKDnGSj74krC9ZkCnnqMdK8IPzJktxFlEI8R3nr/YzEqaSlHMG0BYRGRg?=
 =?us-ascii?Q?mRHmJPQZuQhf/OFIb7VpD+//yVkM1Gur+hCo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ba7Vet4n7+2+brP8KfSVpGXUSRQ3fY8yks41YRLx6snr5AMBO/kCLMmATU9H?=
 =?us-ascii?Q?HAA71P1t5o9aKoKXxHaO3LjIG3oSrL1+x5NsOf+i3O3MlDQlb0oWNjBHHw6x?=
 =?us-ascii?Q?RY9tqFRnl8YHIULmCo6gfxQlbXnjXsc0hXmssq09dnDAS/588s6qyqBDRUrm?=
 =?us-ascii?Q?f/9IkKEpxfnDEqVzjWGQ+IeV+6eiduykiD/h89qOezI1k8MxMApTou4Km4gL?=
 =?us-ascii?Q?3mPXKd2j/0chgtLJ7iyWwthDaOejXGHFl1Q/1r+WWKR4Gs+5pe1c00Vm9HKT?=
 =?us-ascii?Q?nLTlYtl7/NJQ8bHPLdP5g/aQwjX+df+We8hD0a2XfZ6AXI8hU5UE2xo6Rfgy?=
 =?us-ascii?Q?KbGOJMt3OVZii41pkjgtl1+OUTaaZ73xtWnQbM3F96gJu1s+Zgr+PZKSqm6C?=
 =?us-ascii?Q?n/A3e2BipqBCiC8ZJZplyYcsZNnEtl8ndeEuZpTEtOL6OvI4zt5PSITI1+uf?=
 =?us-ascii?Q?xsRm4VP3h+xST01lo/Ix1FuDQck6P/wTFxmYmJUlS/aI8jmPrTvkYc2q8uFh?=
 =?us-ascii?Q?vokdZxFjpE1H6ivHZXQTYfyDfnhEGLnKdkYOUzxSLsM0rqNb5sbk0J598tEM?=
 =?us-ascii?Q?r8whvDiYIHgffFDmXxDTlcdaVzxMZ7K8MGbOw0TprBWiof4hTsyuUjhvRGXo?=
 =?us-ascii?Q?OcI6TM9KgbDylavvNbmqmnPhYA7BRbhM/DruiR8c7SqNy1QmeB6hXTTAevyp?=
 =?us-ascii?Q?HjCauvWq4OUoOKmyE6W1PFNqMfHCb+AJJnkQ1wwNGmtKqw5yDqEnopE7Ez32?=
 =?us-ascii?Q?HYigG1Ku6s7swJvDT22p3WG27u+YNuLbyzGwgfjso3/GUe3wOCTrl/3Ic9fv?=
 =?us-ascii?Q?2Kb1EJ/FvnPtHu55InjAVatLFaGWU875g72FBW99a8S7XWLPbMvoc2FnCHN3?=
 =?us-ascii?Q?pFcCARBD8L3wBsXR0SwOPtSwguUeTDhD2yN6aqhnDcECPLzH8FIfjPwshbN3?=
 =?us-ascii?Q?SbJzAxJ2T9lYWJqQ7IIBjnx48Pp5b8E+5PTnXQZUaoRSKa00YS3zSUsci/Bu?=
 =?us-ascii?Q?F9KQIP9gW+hmHn7gGfDRvAkwgW1OmGXc39/VHcs+0VrfKUpBOREiNmPYSat8?=
 =?us-ascii?Q?gTwvGg4hTPrzNZfMg+jSW1F3U6P203hyCHMgDw2aokuvbcyBf8HD88K6kg5n?=
 =?us-ascii?Q?5rilhhfJX7gA+NN/PSsTxCiFwzIresZnvaxhM8ajd4Gsy9oXrmxWNJMhPFpr?=
 =?us-ascii?Q?NVSJqFoe6vzs2A/1nXDMXdZyoMzexeb76HNI3nxIqeHcJPjKsHWxJ6V1AbKD?=
 =?us-ascii?Q?92epmx+PHjjBnzCK69H0XBJcKLNUtH5IIMALpxQ/YArGZJryUo0Iix154XqY?=
 =?us-ascii?Q?JlFONih/E41o3sF5wkUdetXah/nTUSZh1A0QrDB1Vc+UEfMiWZTGjpFXREHw?=
 =?us-ascii?Q?nhBkJzCXDpubClgZohWU7li8D2vmTnWCy9A8/Wr+YWZnLVk0ArAL/Ri/AA1+?=
 =?us-ascii?Q?iBhwyAAz4c5vaJp+2IGqfBw+DLqSquEc4im8CCnD1VjqAkhR7oK3366oEUl1?=
 =?us-ascii?Q?JVw6bHSjMdg82emqK/trHmtL09t4kW2CxN8IVRFH0sIjK61puEznLGypG3lv?=
 =?us-ascii?Q?iVSFpfyhAXHLTF2aEiOrANy9fCKVqXEc1BzyZx+1NSuIl4Bm4jS1Wtdk0UjB?=
 =?us-ascii?Q?bFkngLwSqPYO8rmtniWjwWY=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f454ebca-2179-457c-ffeb-08de0ab03a81
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 23:28:34.7002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q5lxPCPyL+dQccuo/5y2mgAjqbTmQMCnwGO6odKuyCCSSlkzAIZ6iwlm0mchhfIX/42AoeAOT9fcrcgSMutjVOpQVKmjkBrPrUnkVHQyPJk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB7368

When changing permissions for vmalloc area, VM_ALLOW_HUGE_VMAP area is
exclueded because kernel can't split the va mapping if it is called on
partial range.
It is no longer true if the machines support BBML2_NOABORT after commit
a166563e7ec3 ("arm64: mm: support large block mapping when rodata=full").
So we can relax this restriction and update the comments accordingly.

Fixes: a166563e7ec3 ("arm64: mm: support large block mapping when rodata=full")
Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
---
 arch/arm64/mm/pageattr.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
index c21a2c319028..b4dcae6273a8 100644
--- a/arch/arm64/mm/pageattr.c
+++ b/arch/arm64/mm/pageattr.c
@@ -157,13 +157,13 @@ static int change_memory_common(unsigned long addr, int numpages,
 
 	/*
 	 * Kernel VA mappings are always live, and splitting live section
-	 * mappings into page mappings may cause TLB conflicts. This means
-	 * we have to ensure that changing the permission bits of the range
-	 * we are operating on does not result in such splitting.
+	 * mappings into page mappings may cause TLB conflicts on the machines
+	 * which don't support BBML2_NOABORT.
 	 *
 	 * Let's restrict ourselves to mappings created by vmalloc (or vmap).
-	 * Disallow VM_ALLOW_HUGE_VMAP mappings to guarantee that only page
-	 * mappings are updated and splitting is never needed.
+	 * Disallow VM_ALLOW_HUGE_VMAP mappings if the systems don't support
+	 * BBML2_NOABORT to guarantee that only page mappings are updated and
+	 * splitting is never needed on those machines.
 	 *
 	 * So check whether the [addr, addr + size) interval is entirely
 	 * covered by precisely one VM area that has the VM_ALLOC flag set.
@@ -171,7 +171,8 @@ static int change_memory_common(unsigned long addr, int numpages,
 	area = find_vm_area((void *)addr);
 	if (!area ||
 	    end > (unsigned long)kasan_reset_tag(area->addr) + area->size ||
-	    ((area->flags & (VM_ALLOC | VM_ALLOW_HUGE_VMAP)) != VM_ALLOC))
+	    !(area->flags & VM_ALLOC) || ((area->flags & VM_ALLOW_HUGE_VMAP) &&
+	    !system_supports_bbml2_noabort()))
 		return -EINVAL;
 
 	if (!numpages)
-- 
2.47.0


