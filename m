Return-Path: <linux-kernel+bounces-821498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E3CB816A4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 21:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C06F4676AB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 19:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F4D2FF660;
	Wed, 17 Sep 2025 19:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="dkkbNyrh"
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020132.outbound.protection.outlook.com [52.101.56.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84442C0F87
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 19:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758135849; cv=fail; b=B/lKN193q0w9K3+1ohngpopxICnVOMz7mcrP4ytXtm4wC3U+4Cqo5R90J2f+37B/Q0WqVWzBRygji1OgEhZVzgyMYrJNVaZVZHHTe2Ck1x/NtaO6r1XX2rqpJLcQmpp6So+f4uU4eQ30MoQY7GZeBhqVKGEqHD0uhSHCZcSXjX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758135849; c=relaxed/simple;
	bh=+DfIBdNKM2VPTqieFSE2Mh7LL+yXvl7PvpNQU1MrsaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gvLo56QabhLBVzIZpn3skqrsh0A7YWUa9ZlB6py6vdaUv7I21Ew1APHpzIq957XWL8D/CIIGgKpX+ioDsP4Hs3tNpN3VohPQINru6UydwKPNwMh+R4pg2XYZOmudJ0LMFg1m+UQZ7jwO56SQprb/aI/XiuzbcLd5Of8O0D2IaoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=dkkbNyrh; arc=fail smtp.client-ip=52.101.56.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YuM3EbMB0TFZ1UKei2YDF41+Wk+lyvfpwGSjUCldw3d5Mvx922LQAr3ugfrE44fQhWVuJb++E7foL8UqAZHYoY+P19HOLpfh++J74cqiLIKHl8FrMNqLyT9b1eIYkzUu5oJwAoGM8Ns9gz8nxg2IVJtp+5hE7IMXy3TlM0SA80m+5F5w5AGbXccwWO4BEAUIsB4kD7LeDGnoX9+ANP2i9U97R1bGkI5ARPpZvzO6zf8C6sovMgJUkPl3LvDxw3rtz2sh33umAZifmQ/rJojrzPSkNX53GoPJczMSIwtSI0im6IykadUUmzzrwB2Rte3/GbxvtjtJlajpbuhOIB5isw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1PQuksh+R0YLef8NlvlJGXQxuWsA5z4MBi8EjtwI0y4=;
 b=XZW6SKWAcGNA1n1AROH2rEu4nPWmSzUWNvHhShRWJotNtSyOUFnJjJ7atN0VuSJKS7Pbn+vGjIKRHLluVHoZEFbXON5SALTOGm8kmOpxU7A8Wc4ATYgAuVhiRzr25nEzNxbfvmQTMi8OrZVR8k9wmk47yvcd/Gca+WPpTpbMkAl69in+quasUnFAem0lu32YdUcWzHem6HwFjZkG/IjfiR+RAVDLs8bJKdzoia16lvSEJ2eWK5hXauBlsoiZK1h2RXYmct3nq8VJTS60nfrp13NwGS0JSK83XvyRa4P8W4j906BNZv9l2XEMoHL/dr3uzSDG8Xa+yX9UEjfY3TqDMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1PQuksh+R0YLef8NlvlJGXQxuWsA5z4MBi8EjtwI0y4=;
 b=dkkbNyrh0PlgAmzNP4PaqLJkMj1bNrRYz9Ih8DtD8iE32icv5Jt/WjF+StY5SG4CPsFhQNd1+OHGeCFXkewpWMPkLNpdg1bZUIt4sc+61xv2VnXJufadfH0OJsojGBupsOSBEVYgejhvrvk+uy0nUxyDHUr4hwOqQtWdIc60Reo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 LV8PR01MB8429.prod.exchangelabs.com (2603:10b6:408:189::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.19; Wed, 17 Sep 2025 19:04:04 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%3]) with mapi id 15.20.9137.012; Wed, 17 Sep 2025
 19:04:04 +0000
From: Yang Shi <yang@os.amperecomputing.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	ryan.roberts@arm.com,
	akpm@linux-foundation.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	ardb@kernel.org,
	dev.jain@arm.com,
	scott@os.amperecomputing.com,
	cl@gentwo.org
Cc: yang@os.amperecomputing.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v8 1/5] arm64: Enable permission change on arm64 kernel block mappings
Date: Wed, 17 Sep 2025 12:02:07 -0700
Message-ID: <20250917190323.3828347-2-yang@os.amperecomputing.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250917190323.3828347-1-yang@os.amperecomputing.com>
References: <20250917190323.3828347-1-yang@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY8PR10CA0010.namprd10.prod.outlook.com
 (2603:10b6:930:4f::16) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|LV8PR01MB8429:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ffd7291-99ce-4cf9-b4bd-08ddf61cf81f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wFVs/z4QKYJkBqR1f5mCbAQBF5DCYCSsmMi1uKPTzzgykFniWGL4M2LFP2XG?=
 =?us-ascii?Q?ShGBIu0RIs216awpHytc1eB05wqV1DYQOhpDNGoh7jaQK7yBz8XLleC6A6Mg?=
 =?us-ascii?Q?9iEqzXKPfB28GS1ZFuH7jgHp7x0cUAirjndFpifa3Lh78xgPfzfclKf4Yil7?=
 =?us-ascii?Q?wwq+pAElqiCKcMQ0NhNZRFvUbr5j69K2MOYG+sW0ZnDNF5ubPhy+RJkiyrey?=
 =?us-ascii?Q?5nRPQa6GBPZTIbCUz4p5zTnMNh6hmvlFK12t4N+OoNwpr49jUmGfvnTNUNlO?=
 =?us-ascii?Q?/sv7Hn03AJVrqtoqJ92xzdGvxA6FcckMibJvU3OmIRCfNui5lroHMEYm6jd6?=
 =?us-ascii?Q?Q9q27MaxmUxWog6nZL6fT2sPVnUYqNMswq5nYfaXVFcKiKmA3wUlqf0F6L87?=
 =?us-ascii?Q?aOCe2fNz8g0k3GQFHjM8egPy3JtcYiWPHa+fc5nET52XMFfnZFSlTS+aO7iU?=
 =?us-ascii?Q?wb93J8SA+nDzHzd/K4ZydieQWaNBM0r2N+9yUrbaGkOVpBoLyc8fQUoIxE+t?=
 =?us-ascii?Q?J/UxywazUObeZHFbglscM5yGG0Z03PYc5+Fo/VUZI2a6q2NUlKHs39+VxFjM?=
 =?us-ascii?Q?BfQXbXZur+Vev3HZn3xh0ieE7Mu+D9/ckS6+7wMtPSCg6kWJRd4z9OGpbhV0?=
 =?us-ascii?Q?kkMi64XXrOHMNy1y+1hUJESCKoAKqzHyLB7qes5XyHorqKq/Ea6V5v81fF1k?=
 =?us-ascii?Q?x3oig/2DbN3aZwdslanQaOKgnYvi4ny5hekaDvr3ZPB2EoG/+WcPC/mMND91?=
 =?us-ascii?Q?g+yflCkd7mKh4JCpQJ/I75zl5YJhPc0nRTINwPSn+KvQaFwJWj+32xX5Vahq?=
 =?us-ascii?Q?2IwWzMeMHyQCzCIQ/ELWNHYuk0nMzBsDGi8U4o9Nzt0GmWuzu2Shz/N9BEaV?=
 =?us-ascii?Q?ccEK9AC2vPeycJDtL71lXrjysEOS6TYNLWwUC6gBILcBXz11a2uT6psfejKl?=
 =?us-ascii?Q?XE95X9tsgkky5yGKUIOlIfaqZQbflZmNwI6MU4AW8cBl4X9DRJpZtVIV96L0?=
 =?us-ascii?Q?hrbIf0z52AkidDDulKwCf1oPae+HM9DsoSWjinKFK5IK8M2RE8+mTjPG4NxI?=
 =?us-ascii?Q?MmrDStvxjw2VhOg99QI5PzC26VcyaixJ/Kgi+ni6E+aQXZlp7g4j1sMBsz73?=
 =?us-ascii?Q?WMV8ha/71whSpVCJNMJTW+1XXw4DufC+2i9w9E6w2zP4Hi5vVLAPMPPlmCby?=
 =?us-ascii?Q?hq3mb1kCZy0c9jGet3+i/NP/tuaWLPdlm1nsncSnvbKYX6EJ4wilf4eRjbQU?=
 =?us-ascii?Q?3D3Hb4Th1Uya1cXLeCUvs648RufMEEJmiXoZ415Lvk/rHsxha83kgNwZdDv4?=
 =?us-ascii?Q?7w/EcsX/BTtgjvcEsLkSXx1l0pDWsGQFkKdozJQaG424JJMQ3pRnTeYJx26Z?=
 =?us-ascii?Q?2JQY7aXSqWckH0nVM51AEpKFwdH8Ks3COQeXeQrgwlKBLmyuHGEerZEOwu2k?=
 =?us-ascii?Q?7jY1roKJPgS1KseuVYWdw1vn5qHPq9/BE/uiODwS8HtMf+VTstLTXWBcoJzJ?=
 =?us-ascii?Q?bW+XRCJPeQXprUM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D4/erSutQuunT/43NCnHFkA1koUgGFnqy6g7ix05x161Qdcmnjw34BdvVsJy?=
 =?us-ascii?Q?UL8Y317usqHsrWZobPj9nXljB5l6tzdW4otwsd4/tQhLTfF1AHkppvXGEhyi?=
 =?us-ascii?Q?jEMMie5QcZ2FSSBPfPruEakmIQ67kBLP+HxDYZGIQyqzgaoCdRTTGWpSIXOs?=
 =?us-ascii?Q?bMasL09AhxuUsKfWV5NEz9jPEIWcNkfFcWGnGCBM7Vg/iPWOeXM1Ji2SVQui?=
 =?us-ascii?Q?M3cSC21gPpNb7B0znJX92Yv0fo9w1ltcaoioNaBpN+dMBszgmdKi/O+R29/C?=
 =?us-ascii?Q?dM8FMEzTkFtVe4hZWHN3hJDwsySl8tk2I1k8xD6y40PNSfRAztUddzITrfRD?=
 =?us-ascii?Q?l+csyysfyL3+qAkDkpxa8+76rh7GGeL+XAjW+SaT+qcMkyfMhjLneknQevRA?=
 =?us-ascii?Q?bHOcMoR/zbks+/RPrYYhCJMOEP2YMSkhAcFyGBnohfQ3dnBmYuwgWU8ouzRl?=
 =?us-ascii?Q?QawEaj1iLx53UzVFoNmpYaBYCABKRGORxqCNvA+M4Pss7ny/pEcU/MWkNgQH?=
 =?us-ascii?Q?C4QvLZdzLfcVOncgSs1RVQQJs5L/p1pwoKz4gOe2p2galMUmC1Xmda2LKsZk?=
 =?us-ascii?Q?B5rX81get8y47fayvcUPEY0XO1EuthWdcfh0FLpMHgvJXgH8NfLDBeEJkhme?=
 =?us-ascii?Q?82klB1XGdAqyKLs2mbcGAsNX6+X9ax7kGG06nffr5SUK4uHy9JD+N1Xcqryh?=
 =?us-ascii?Q?1R1R5+3rxwnkNT77I1UKKuOejvfWUZ8LwgC1f8lNbqiKEK2w3wmWlY5GF8hn?=
 =?us-ascii?Q?pN9t2DTK+RlUvmgiFHenol6ku6ALZ7duMO7/NMtgzSn9sBuWJ5XMvqxFTd57?=
 =?us-ascii?Q?rvoR9gcCL9hGBdqklnnplnWn70rSurtqhhagwBUGVjUuT/xRc/AX4k0Z4mnb?=
 =?us-ascii?Q?4k3caJevUOrOyulH68ysXdZ9hhj7DTrdJQg7elHPB5n7Prd6oldF3S4G9W3B?=
 =?us-ascii?Q?SHPLv54SWIWXkj6RgZ4JUp4y2o+mOnJGpon/nnRqixcapeg35dYL5vPelpSo?=
 =?us-ascii?Q?2JfnsUVQKW3licVJ/d0RPo9N81rUWXa+Qfoub0fxUzFwouqJnSVX0XTF1BMp?=
 =?us-ascii?Q?pzhnswsVpm7nJj2lByuVW9AOvFXrbqi5Vlfuwqzd3oycJW0qYou0xkCFJFN+?=
 =?us-ascii?Q?AeXF+Fqiqe7iHKzPgxZyvYHelp3WiFPJuRnmB25JDnGEF3DVW3Uznjguo2J2?=
 =?us-ascii?Q?k9fCnFEeJ5T60Bv4U9XDY+lO34mJn/S9g7znFkQ28+1eVC/KrF9QYhu0Sbg7?=
 =?us-ascii?Q?Av7GwN4iArsj1dmbtyxETdR4YHS99W/kZMs5iaD/JOTAcRIpX6xxqjrSLXVD?=
 =?us-ascii?Q?4lJ75kZoN7d45JK+soGn3ny4NbT/pGApa9gEI/KvxPhvgE+VVzMCYW8V6E7Q?=
 =?us-ascii?Q?4ebipWjS5oO3DvlfnUZOTx5xzG0xT7cUK7LhHkb7gPQnAmz3PpkjtiJMyzGz?=
 =?us-ascii?Q?DLb99ohB9un2MTVuGtdXjBS9obXXGBiewD6iTtbBrmkc4oScsv/2M6B5qbys?=
 =?us-ascii?Q?heIv/CricDeBljAFfnPSl5I4VUo2h8dvvTHJFDp3xwe0nxaLcJYa/fu/sf2p?=
 =?us-ascii?Q?1aO5tadjo3RTQPN7r9bHqppiYU6chESH/wrggFeYBVRzRbccc4+uuaaByfbB?=
 =?us-ascii?Q?eXbR5uY3ldITAwxWyWWbYco=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ffd7291-99ce-4cf9-b4bd-08ddf61cf81f
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 19:04:04.0162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oRO1+O7pXIiXQnINdqBQIT4NoS6mMWTulEt5ndbo1CGvmY6CUSOyiIaZnussEtTU9CbKR+tsKIskhToXO8B4LMHnXHI3+/nf48tAp5UMdaw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR01MB8429

From: Dev Jain <dev.jain@arm.com>

This patch paves the path to enable huge mappings in vmalloc space and
linear map space by default on arm64. For this we must ensure that we
can handle any permission games on the kernel (init_mm) pagetable.
Previously, __change_memory_common() used apply_to_page_range() which
does not support changing permissions for block mappings. We move away
from this by using the pagewalk API, similar to what riscv does right
now. It is the responsibility of the caller to ensure that the range
over which permissions are being changed falls on leaf mapping
boundaries. For systems with BBML2, this will be handled in future
patches by dyanmically splitting the mappings when required.

Unlike apply_to_page_range(), the pagewalk API currently enforces the
init_mm.mmap_lock to be held. To avoid the unnecessary bottleneck of the
mmap_lock for our usecase, this patch extends this generic API to be
used locklessly, so as to retain the existing behaviour for changing
permissions. Apart from this reason, it is noted at [1] that KFENCE can
manipulate kernel pgtable entries during softirqs. It does this by
calling set_memory_valid() -> __change_memory_common(). This being a
non-sleepable context, we cannot take the init_mm mmap lock.

Add comments to highlight the conditions under which we can use the
lockless variant - no underlying VMA, and the user having exclusive
control over the range, thus guaranteeing no concurrent access.

We require that the start and end of a given range do not partially
overlap block mappings, or cont mappings. Return -EINVAL in case a
partial block mapping is detected in any of the PGD/P4D/PUD/PMD levels;
add a corresponding comment in update_range_prot() to warn that
eliminating such a condition is the responsibility of the caller.

Note that, the pte level callback may change permissions for a whole
contpte block, and that will be done one pte at a time, as opposed to an
atomic operation for the block mappings. This is fine as any access will
decode either the old or the new permission until the TLBI.

apply_to_page_range() currently performs all pte level callbacks while
in lazy mmu mode. Since arm64 can optimize performance by batching
barriers when modifying kernel pgtables in lazy mmu mode, we would like
to continue to benefit from this optimisation. Unfortunately
walk_kernel_page_table_range() does not use lazy mmu mode. However,
since the pagewalk framework is not allocating any memory, we can safely
bracket the whole operation inside lazy mmu mode ourselves. Therefore,
wrap the call to walk_kernel_page_table_range() with the lazy MMU
helpers.

Link: https://lore.kernel.org/linux-arm-kernel/89d0ad18-4772-4d8f-ae8a-7c48d26a927e@arm.com/ [1]
Signed-off-by: Dev Jain <dev.jain@arm.com>
Signed-off-by: Yang Shi <yshi@os.amperecomputing.com>
Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/mm/pageattr.c | 119 +++++++++++++++++++++++++++++----------
 include/linux/pagewalk.h |   3 +
 mm/pagewalk.c            |  36 ++++++++----
 3 files changed, 115 insertions(+), 43 deletions(-)

diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
index 667aff1efe49..c0648764c403 100644
--- a/arch/arm64/mm/pageattr.c
+++ b/arch/arm64/mm/pageattr.c
@@ -8,6 +8,7 @@
 #include <linux/mem_encrypt.h>
 #include <linux/sched.h>
 #include <linux/vmalloc.h>
+#include <linux/pagewalk.h>
 
 #include <asm/cacheflush.h>
 #include <asm/pgtable-prot.h>
@@ -20,6 +21,65 @@ struct page_change_data {
 	pgprot_t clear_mask;
 };
 
+static ptdesc_t set_pageattr_masks(ptdesc_t val, struct mm_walk *walk)
+{
+	struct page_change_data *masks = walk->private;
+
+	val &= ~(pgprot_val(masks->clear_mask));
+	val |= (pgprot_val(masks->set_mask));
+
+	return val;
+}
+
+static int pageattr_pud_entry(pud_t *pud, unsigned long addr,
+			      unsigned long next, struct mm_walk *walk)
+{
+	pud_t val = pudp_get(pud);
+
+	if (pud_sect(val)) {
+		if (WARN_ON_ONCE((next - addr) != PUD_SIZE))
+			return -EINVAL;
+		val = __pud(set_pageattr_masks(pud_val(val), walk));
+		set_pud(pud, val);
+		walk->action = ACTION_CONTINUE;
+	}
+
+	return 0;
+}
+
+static int pageattr_pmd_entry(pmd_t *pmd, unsigned long addr,
+			      unsigned long next, struct mm_walk *walk)
+{
+	pmd_t val = pmdp_get(pmd);
+
+	if (pmd_sect(val)) {
+		if (WARN_ON_ONCE((next - addr) != PMD_SIZE))
+			return -EINVAL;
+		val = __pmd(set_pageattr_masks(pmd_val(val), walk));
+		set_pmd(pmd, val);
+		walk->action = ACTION_CONTINUE;
+	}
+
+	return 0;
+}
+
+static int pageattr_pte_entry(pte_t *pte, unsigned long addr,
+			      unsigned long next, struct mm_walk *walk)
+{
+	pte_t val = __ptep_get(pte);
+
+	val = __pte(set_pageattr_masks(pte_val(val), walk));
+	__set_pte(pte, val);
+
+	return 0;
+}
+
+static const struct mm_walk_ops pageattr_ops = {
+	.pud_entry	= pageattr_pud_entry,
+	.pmd_entry	= pageattr_pmd_entry,
+	.pte_entry	= pageattr_pte_entry,
+};
+
 bool rodata_full __ro_after_init = true;
 
 bool can_set_direct_map(void)
@@ -37,32 +97,35 @@ bool can_set_direct_map(void)
 		arm64_kfence_can_set_direct_map() || is_realm_world();
 }
 
-static int change_page_range(pte_t *ptep, unsigned long addr, void *data)
+static int update_range_prot(unsigned long start, unsigned long size,
+			     pgprot_t set_mask, pgprot_t clear_mask)
 {
-	struct page_change_data *cdata = data;
-	pte_t pte = __ptep_get(ptep);
+	struct page_change_data data;
+	int ret;
 
-	pte = clear_pte_bit(pte, cdata->clear_mask);
-	pte = set_pte_bit(pte, cdata->set_mask);
+	data.set_mask = set_mask;
+	data.clear_mask = clear_mask;
 
-	__set_pte(ptep, pte);
-	return 0;
+	arch_enter_lazy_mmu_mode();
+
+	/*
+	 * The caller must ensure that the range we are operating on does not
+	 * partially overlap a block mapping, or a cont mapping. Any such case
+	 * must be eliminated by splitting the mapping.
+	 */
+	ret = walk_kernel_page_table_range_lockless(start, start + size,
+						    &pageattr_ops, NULL, &data);
+	arch_leave_lazy_mmu_mode();
+
+	return ret;
 }
 
-/*
- * This function assumes that the range is mapped with PAGE_SIZE pages.
- */
 static int __change_memory_common(unsigned long start, unsigned long size,
-				pgprot_t set_mask, pgprot_t clear_mask)
+				  pgprot_t set_mask, pgprot_t clear_mask)
 {
-	struct page_change_data data;
 	int ret;
 
-	data.set_mask = set_mask;
-	data.clear_mask = clear_mask;
-
-	ret = apply_to_page_range(&init_mm, start, size, change_page_range,
-					&data);
+	ret = update_range_prot(start, size, set_mask, clear_mask);
 
 	/*
 	 * If the memory is being made valid without changing any other bits
@@ -174,32 +237,26 @@ int set_memory_valid(unsigned long addr, int numpages, int enable)
 
 int set_direct_map_invalid_noflush(struct page *page)
 {
-	struct page_change_data data = {
-		.set_mask = __pgprot(0),
-		.clear_mask = __pgprot(PTE_VALID),
-	};
+	pgprot_t clear_mask = __pgprot(PTE_VALID);
+	pgprot_t set_mask = __pgprot(0);
 
 	if (!can_set_direct_map())
 		return 0;
 
-	return apply_to_page_range(&init_mm,
-				   (unsigned long)page_address(page),
-				   PAGE_SIZE, change_page_range, &data);
+	return update_range_prot((unsigned long)page_address(page),
+				 PAGE_SIZE, set_mask, clear_mask);
 }
 
 int set_direct_map_default_noflush(struct page *page)
 {
-	struct page_change_data data = {
-		.set_mask = __pgprot(PTE_VALID | PTE_WRITE),
-		.clear_mask = __pgprot(PTE_RDONLY),
-	};
+	pgprot_t set_mask = __pgprot(PTE_VALID | PTE_WRITE);
+	pgprot_t clear_mask = __pgprot(PTE_RDONLY);
 
 	if (!can_set_direct_map())
 		return 0;
 
-	return apply_to_page_range(&init_mm,
-				   (unsigned long)page_address(page),
-				   PAGE_SIZE, change_page_range, &data);
+	return update_range_prot((unsigned long)page_address(page),
+				 PAGE_SIZE, set_mask, clear_mask);
 }
 
 static int __set_memory_enc_dec(unsigned long addr,
diff --git a/include/linux/pagewalk.h b/include/linux/pagewalk.h
index 682472c15495..88e18615dd72 100644
--- a/include/linux/pagewalk.h
+++ b/include/linux/pagewalk.h
@@ -134,6 +134,9 @@ int walk_page_range(struct mm_struct *mm, unsigned long start,
 int walk_kernel_page_table_range(unsigned long start,
 		unsigned long end, const struct mm_walk_ops *ops,
 		pgd_t *pgd, void *private);
+int walk_kernel_page_table_range_lockless(unsigned long start,
+		unsigned long end, const struct mm_walk_ops *ops,
+		pgd_t *pgd, void *private);
 int walk_page_range_vma(struct vm_area_struct *vma, unsigned long start,
 			unsigned long end, const struct mm_walk_ops *ops,
 			void *private);
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index 648038247a8d..936689d8bcac 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -606,10 +606,32 @@ int walk_page_range(struct mm_struct *mm, unsigned long start,
 int walk_kernel_page_table_range(unsigned long start, unsigned long end,
 		const struct mm_walk_ops *ops, pgd_t *pgd, void *private)
 {
-	struct mm_struct *mm = &init_mm;
+	/*
+	 * Kernel intermediate page tables are usually not freed, so the mmap
+	 * read lock is sufficient. But there are some exceptions.
+	 * E.g. memory hot-remove. In which case, the mmap lock is insufficient
+	 * to prevent the intermediate kernel pages tables belonging to the
+	 * specified address range from being freed. The caller should take
+	 * other actions to prevent this race.
+	 */
+	mmap_assert_locked(&init_mm);
+
+	return walk_kernel_page_table_range_lockless(start, end, ops, pgd,
+						     private);
+}
+
+/*
+ * Use this function to walk the kernel page tables locklessly. It should be
+ * guaranteed that the caller has exclusive access over the range they are
+ * operating on - that there should be no concurrent access, for example,
+ * changing permissions for vmalloc objects.
+ */
+int walk_kernel_page_table_range_lockless(unsigned long start, unsigned long end,
+		const struct mm_walk_ops *ops, pgd_t *pgd, void *private)
+{
 	struct mm_walk walk = {
 		.ops		= ops,
-		.mm		= mm,
+		.mm		= &init_mm,
 		.pgd		= pgd,
 		.private	= private,
 		.no_vma		= true
@@ -620,16 +642,6 @@ int walk_kernel_page_table_range(unsigned long start, unsigned long end,
 	if (!check_ops_valid(ops))
 		return -EINVAL;
 
-	/*
-	 * Kernel intermediate page tables are usually not freed, so the mmap
-	 * read lock is sufficient. But there are some exceptions.
-	 * E.g. memory hot-remove. In which case, the mmap lock is insufficient
-	 * to prevent the intermediate kernel pages tables belonging to the
-	 * specified address range from being freed. The caller should take
-	 * other actions to prevent this race.
-	 */
-	mmap_assert_locked(mm);
-
 	return walk_pgd_range(start, end, &walk);
 }
 
-- 
2.47.0


