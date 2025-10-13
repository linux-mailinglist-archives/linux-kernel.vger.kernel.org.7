Return-Path: <linux-kernel+bounces-850047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EE147BD1B60
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 08:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8CFAB4E2B6E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 06:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D9B2E6CB3;
	Mon, 13 Oct 2025 06:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="pgLKtdLu"
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11022078.outbound.protection.outlook.com [40.107.209.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CC4EADC
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 06:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760338310; cv=fail; b=Iw9lEW+xAWc1Kz7d+bu+Rpw+1DilFyXkqeT8RQZZW8hJC5GeidGd0bUvPHhyJsPXZ7DNXZWNmgfM0NBKKJ2Jk7/1PVLE2xDHDcPetqCfYJ0SYRSy3+x/MW+5RED0KsaeM0eV1drNWxhN/dmrmvly6z8uH0fg9WRWTlJIobn26Ss=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760338310; c=relaxed/simple;
	bh=XCXHlktumJgvegarXvMOvL3SOenGNkAiW2yc5e+bcv0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=e7uEVy+hGcTRi2/KqHbL/u793dSHqLolo9IDH3Ctvg52s7DqYNO0t926YsAW+IyPQ4SgcMv4ySrXXOseSiAOlg6u5xKGDjGRMCmZ1+w3ZC362q/4p8NPq7L9PCAWflteDLJswpnJcf9Y8tq8ZAszWoJ/0Wj4lCVz/sDhD+ZtUXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=pgLKtdLu; arc=fail smtp.client-ip=40.107.209.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dbRBGnD3sIkxC+EeS+Ywbu8iaV6SBiGDD7qnG91ziXMQZGUggnH9xrW/CEkePDQN/AipLPtPk44AKkZ7osuv6s8ML9fv/BRfaySBQSoa6L4cVibe689iHfHKjJZwN/gVoeRkg7a+7aOayKG0t11aTn+RAHU3ax+hiQU8hDHXsaNjX6sbgGWYDG8ICA95tdVa7ZJ1GObLf0jJmLqBKIXrtHvTcnl4MbyOnb9bBfH4GLt63fXEvP0TJ1Nuue3pisMtd9mPh/hGO4NynBJjjhs0/8TN62yDvHGC8S4paYiI/tTwCpcFuHjoHxw68hBCaZ99H4N6DtN0frsoY0GiWp2Nsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5Tx2oDxYMSTja/sPErrZ8DfLx5X4lvxg2ZpEQxtWMpw=;
 b=OSpT7KG//kJWaLiH5qcUkiOwx2G+cREW4CovwntzueUTkXkgbOQ6LX9Xvb39G8RF9+HJYmP5HYaPmIeNDaJMmCT1/cENuHRnYwFcxsdps3veZ/QLMhA1HCJmk5mpsPRXge6fP1cOFoyVLk3cB1mX/n6uzuW/p5+ErVGBjYwILDcohhNGJz9U+EcFwufrA3RTb0yZ4C5U2SHHVJwYKWXziOuoSdyJup6CvDoQZvjQCittc7sRFq9G+98HTeDiJbdNCudzehDDYZQ2wuuACSP4EY9QKAIDFpz1MZeYGRea2dbl4BY5RqWovA26xisuM91s+781DgW77mYwu06OG9xLsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Tx2oDxYMSTja/sPErrZ8DfLx5X4lvxg2ZpEQxtWMpw=;
 b=pgLKtdLuiYyRVOc0SxcSzqy0orI/lpQdsapyiu6hgj6zVU5a0HKiVSqU7pruDjcPUNLNgFqVeJ21LpxGZLE9eDImqGNjRfnjpHgzKUTWXTG5/rvXNaFI29B93jypCLgCx+Fjoa4xjQjtfcOYEYDyPLAJ/JaCUcvdC2RFfZ1nbRI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SJ2PR01MB8101.prod.exchangelabs.com (2603:10b6:a03:4f6::10) by
 SA1PR01MB6717.prod.exchangelabs.com (2603:10b6:806:1a4::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.10; Mon, 13 Oct 2025 06:51:45 +0000
Received: from SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::292:6d9c:eb9a:95c9]) by SJ2PR01MB8101.prod.exchangelabs.com
 ([fe80::292:6d9c:eb9a:95c9%4]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 06:51:45 +0000
From: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
To: linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: maz@kernel.org,
	oliver.upton@linux.dev,
	will@kernel.org,
	catalin.marinas@arm.com,
	suzuki.poulose@arm.com,
	joey.gouly@arm.com,
	yuzenghui@huawei.com,
	darren@os.amperecomputing.com,
	cl@gentwo.org,
	scott@os.amperecomputing.com,
	gankulkarni@os.amperecomputing.com,
	gklkml16@gmail.com
Subject: [PATCH v2] KVM: arm64: nv: Optimize unmapping of shadow S2-MMU tables
Date: Sun, 12 Oct 2025 23:51:25 -0700
Message-ID: <20251013065125.767779-1-gankulkarni@os.amperecomputing.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CYZPR10CA0018.namprd10.prod.outlook.com
 (2603:10b6:930:8a::29) To SJ2PR01MB8101.prod.exchangelabs.com
 (2603:10b6:a03:4f6::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR01MB8101:EE_|SA1PR01MB6717:EE_
X-MS-Office365-Filtering-Correlation-Id: ebb97b3f-d0c2-467b-6228-08de0a24f92b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|7416014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bP/Up97vUY/f1+0L6jIxzuiv07zgRt/SjBCeX0XwDjLTi0WYaEAR8t9rZTup?=
 =?us-ascii?Q?R783sp8XrS1a7iugoY+Z7sX8iCqBC/kyhXDLrS0TfC3qzeO01M8nKSCbwcbR?=
 =?us-ascii?Q?Zqev4UDwZaWDYD97ERplItxW5XcS0+T7FYRMf3MG0KfJWsu6lrSwnNg342+4?=
 =?us-ascii?Q?arp+9mZEUu6VChr8RnscklHCiDG2kvpL9qqWugR9K2kK7gJ8JL23ZIACytOv?=
 =?us-ascii?Q?MU03L8qQfQGcd1LRrkw0zD9y+WuooHHjR5I64uPdG+Lr+FkPdyeHq2id81dl?=
 =?us-ascii?Q?hXsVnpeJRAHiWPf5r7fWSj/dwrPpdUiezLCf9ZvIeWD9mxgBzm1kVOugpFab?=
 =?us-ascii?Q?v6xy1KgH5jWEf9PQNuCf7kMzDnhqDja4tUGL98BiyLwWwV7klbmRVsvWXO53?=
 =?us-ascii?Q?PxMZfM7zJaGQmuErGMoE7O5R8+41fx/ZYKcQeD0C7esu1aGNB3mSS8VygEeg?=
 =?us-ascii?Q?H0aEka/gbF41SmlHAIjIOKWaFTL0dC2YjRAvrQonX5roVfhjtQ888rP9JlMq?=
 =?us-ascii?Q?qXRS3jZtW31WK993heA5SfjIXa1+lff/peW8SxRcNMmoQwK1gEggaDReMwNq?=
 =?us-ascii?Q?XO1TG+EO+WM7gD/X7QOPUkn0mMi0CV8Qd0beyHt6y7h7jCg2tHjvCBETJ8XS?=
 =?us-ascii?Q?Fit3qphbWQOEq76Iuslaeq0ciM348+2vaAJfq5+0vAsmLkliGAMdcGXGMdnt?=
 =?us-ascii?Q?NGV2vxhtmeUKhPHFtKhXbXi6yORT/GXvdMJG9yNJ9YhEvMkkjdWWTN0CDwEm?=
 =?us-ascii?Q?RgKgMSZLu/otg9d3hptlpzXZM+7Z9hCiH5PR+9IrIyxbwOWdsOVVdAUkQAb0?=
 =?us-ascii?Q?JLGv9nREy1j5BU/7Z+oVztsNtE4fa0w0kyRfPmUXoJuC1eWay/F1JaSjInRZ?=
 =?us-ascii?Q?RcKSoHFA0sjfK3HqXarXz6YUzXZJ4jvF8ZejPuZv0REDJRrlXDWVSWet9Pkm?=
 =?us-ascii?Q?F88nLGbQlN3/hi5XyEV8Eeq/FQK3Je0jkuYvIDADLDv2FbGiPoy+DWHSA4d+?=
 =?us-ascii?Q?ORvgUbe8SU/dkjCG7/DRDqj6KOiWBhq085+ksHP+ODXfw0hAFH68VYkjBmJ9?=
 =?us-ascii?Q?gKF5oexLsNmdttMoJN77rUKJhotRVq/beMFIoV0xlK5/S/zDapz5PmH93U7y?=
 =?us-ascii?Q?aLlvEK7fdoef15e2n8ItAak2PgQWB5ltRJh4VYjOF3TDUZ4pzOv0RBmqFFAL?=
 =?us-ascii?Q?LsWcdyYEItuie9muajMcpbvVCHgStN33Zn/mbF/NWO1rhY2MEvyX7bYL7wkv?=
 =?us-ascii?Q?o2mioUolg6BPP0b4FIxZnjJC7ZqjqhEtFPnqWfcljzxwAIPQdI81yELf+Sp3?=
 =?us-ascii?Q?eY4eV+Y6iqIfVqapF9GJJhlYdqF9CJ6a7+UKJ/vxV+Wgxxfv1q4RGvEfwAkX?=
 =?us-ascii?Q?HZ+X+03KP0Ivj/ZZY/ZEilk4JdHI1M7eqLUho5HuiJNSmc5rJNPqROcjzcS0?=
 =?us-ascii?Q?Jy7rsvBnbE7M8SMm6tmXaXaKoFH/QpFKFX0ZxXe9g6i03KCfv3zwrl37431e?=
 =?us-ascii?Q?hKDM6nTb3VzbIc/ucBZexGl3jfn0S/C9kjxa?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR01MB8101.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(7416014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4+g/oFDA5fn10J6SylMRkkelS6ew864W+egtXeP6OziUAT3Y9ZYeq6ex5doF?=
 =?us-ascii?Q?IC825DhARzU/q1A7/Y0djj+q5RgDK3o8WJko3jmSp1AXf0sQ/+uesSjvggGr?=
 =?us-ascii?Q?R2t2P1VRgscF1fsmrunPcZC7/NXKARMVZv3/ZzQCIPnvYpYdCAGvi4NCcnqi?=
 =?us-ascii?Q?aYlt5YjTHwC01RzXZpP9eQqsRE4tHOOTQgDkoo46/b2/XK6mvJ0CtpsxOhxS?=
 =?us-ascii?Q?VLkIxPCjM+RQRD0gm/gULXnH/cY+dOEJVJaoXzuvW6MMYQJgOJ2WRCFG+XYZ?=
 =?us-ascii?Q?GpmDi1tNvLwd0qDpxXcNicnTFSg7gxRv9/MR7+dppoI74vptqLsgebLRgepn?=
 =?us-ascii?Q?+D/tB44O49+PTilweUHsZq7368qGLkH1A3qnCOYXrFLkyvQFRmY/JlocXrZk?=
 =?us-ascii?Q?5hmVYNUV/QM6HHQn5A3y+wnVMWMHzzoqYeuYqkOpJRU/NBZqAuc8wUYwGtPC?=
 =?us-ascii?Q?D1o74UbwRJc/htfnalVXf+wbFYByjf9qRe+twJXW3SfZszSAif4tSvETiDsa?=
 =?us-ascii?Q?N0HSMY/ZY1VBPGlP5clz52dU+kkvnNn/PMhwAxF67ZiNCeX+4YkpW26xO+Sy?=
 =?us-ascii?Q?8I6DDmc9SLsrkfIRlBJNffVEZZohHpWeeDFplGLMJHn8LXcQbgXdd0+Kz19N?=
 =?us-ascii?Q?yw8XIkx8gYpoVZ7nzMz2NQ9ZOgi48qsyWYV6w0ElwiSKmRv3TlW+AC+36iLk?=
 =?us-ascii?Q?sxs2tRynQxX28TXuk5WXQ61sf1aNL3M8dqkG1E6CQiRcC0JchwuoKgoJt9ru?=
 =?us-ascii?Q?l25YLmBHMsAyVxAEpB+bni+m2N6fjkM7CxPEr6NadCPCs4Bm5/8mMshGR8+P?=
 =?us-ascii?Q?+2qHD2jf0QUpnUr+zYmaxS/ULQHAptLZ7LqDQonfaBGTt8PYxyvPXxTwYB78?=
 =?us-ascii?Q?pR9JiibUock8AexwriBfRwXWuqWAyU4dt30NPoST3SzrCeaxkxvyOQ5SJnd+?=
 =?us-ascii?Q?lPwXqO8nrr+38HaaE2O4Fy+M5pAtkLPOWTk/OALSI5Y4eLGsD6t0yqiTGqXw?=
 =?us-ascii?Q?anXKJwVKvdURiNcl1al9dtFVIbB1FqPOCNlh9j4qXhvzncvYXRpMTMawQ4Ml?=
 =?us-ascii?Q?Iz/DcW4HA/P9xZaxUDTRH4UTJJQynaIlDCN2MivLffAsCrUnwjueMoBmYhs0?=
 =?us-ascii?Q?dQ8WU1ED0a7nQwh8BAaJPrTz2R4FYin4DyKI1uDt2tm0PaBVaRSwGcoDv5rW?=
 =?us-ascii?Q?+UUJi5m6mc3WKJNg8Zs94LVWmAwz9w9FjnMZx38lGHU3ynvk+t3hq4+3HlCY?=
 =?us-ascii?Q?KdS4h09/Wsrg6rQdHbsAANiXsnSCMT4vra4gybqJI+IKxEmUSK0uhhemNDgT?=
 =?us-ascii?Q?MSA1ieC8S+McqJK5zW608HtaJhZGYgTZaux7K48t+QCoVPTUL3CIYeeB5q3I?=
 =?us-ascii?Q?l9E1F/U2PGr8ZA16Vs6jufauajbfch3t3hB+eOT2yCYvhKEc/u/QmBOyUtm8?=
 =?us-ascii?Q?9tGNpWqKKIFUUHj4pZp/NgpBtTrFXhFptszN4NIkqH62fCBa8ay2Yxn5P737?=
 =?us-ascii?Q?5I0xrxTQyCiD31IeBq+nrEfKPpdH9kicM8LNrqEk8akQrmgEDDzO6bmQ2C1f?=
 =?us-ascii?Q?nkofrfA0gLqTv/KAL/YXTUAN7RZmC+Nw10weRnRKy3kTFBd0jzGs7rLRJSaS?=
 =?us-ascii?Q?JnzFv6HEJyZzSJOU5VKrxLo=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebb97b3f-d0c2-467b-6228-08de0a24f92b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR01MB8101.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 06:51:45.0789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 986ehxvTCOkc7SJAQ/AjfMIqK9s+vkE1ev9oVe6zLkg2bFvkGOJMtSbw6D5mjLhrfjHoL2Hf94yW6hjYGbX/3yiX5X5gzHIsSyYbyuusqaSASe1L+mGbPkWNMNBMPFk/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB6717

As of commit ec14c272408a ("KVM: arm64: nv: Unmap/flush shadow
stage 2 page tables"), an unmap of a canonical IPA range mapped at L1
triggers invalidation in L1 S2-MMU and in all active shadow (L2) S2-MMU
tables. Because there is no direct mapping to locate the corresponding
shadow IPAs, the code falls back to a full S2-MMU page-table walk and
invalidation across the entire L1 address space.

For 4K pages this causes roughly 256K loop iterations (about 8M for
64K pages) per unmap, which can severely impact performance on large
systems and even cause soft lockups during NV (L1/L2) boots with many
CPUs and large memory. It also causes long delays during L1 reboot.

This patch adds a maple-tree-based lookup that records canonical-IPA to
shadow-IPA mappings whenever a page is mapped into any shadow (L2)
table. On unmap, the lookup is used to target only those shadow IPAs
which are fully or partially mapped in shadow S2-MMU tables, avoiding
a full-address-space walk and unnecessary unmap/flush operations.

The lookup is updated on map/unmap operations so entries remain
consistent with shadow table state. Use it during unmap to invalidate
only affected shadow IPAs, avoiding unnecessary CPU work and reducing
latency when shadow mappings are sparse.

Reviewed-by: Christoph Lameter (Ampere) <cl@gentwo.org>
Signed-off-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
---

Changes since v1:
		Rebased to 6.18-rc1.
		Fixed alignment issue while adding the shadow ipa range
		to lookup.	

Changes since RFC v1:
		Added maple tree based lookup and updated with review
		comments from [1].

[1] https://lkml.indiana.edu/2403.0/03801.html

 arch/arm64/include/asm/kvm_host.h   |   3 +
 arch/arm64/include/asm/kvm_nested.h |   9 +++
 arch/arm64/kvm/mmu.c                |  17 ++--
 arch/arm64/kvm/nested.c             | 120 ++++++++++++++++++++++++++--
 4 files changed, 138 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index b763293281c8..e774681c6ba4 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -227,6 +227,9 @@ struct kvm_s2_mmu {
 	 * >0: Somebody is actively using this.
 	 */
 	atomic_t refcnt;
+
+	/* For IPA to shadow IPA lookup */
+	struct maple_tree nested_mmu_mt;
 };
 
 struct kvm_arch_memory_slot {
diff --git a/arch/arm64/include/asm/kvm_nested.h b/arch/arm64/include/asm/kvm_nested.h
index f7c06a840963..5b7c4e7ed18f 100644
--- a/arch/arm64/include/asm/kvm_nested.h
+++ b/arch/arm64/include/asm/kvm_nested.h
@@ -69,6 +69,8 @@ extern void kvm_init_nested(struct kvm *kvm);
 extern int kvm_vcpu_init_nested(struct kvm_vcpu *vcpu);
 extern void kvm_init_nested_s2_mmu(struct kvm_s2_mmu *mmu);
 extern struct kvm_s2_mmu *lookup_s2_mmu(struct kvm_vcpu *vcpu);
+extern int add_to_shadow_ipa_lookup(struct kvm_pgtable *pgt, u64 shadow_ipa, u64 ipa,
+		u64 size);
 
 union tlbi_info;
 
@@ -95,6 +97,12 @@ struct kvm_s2_trans {
 	u64 desc;
 };
 
+struct shadow_ipa_map {
+	u64 shadow_ipa;
+	u64 ipa;
+	u64 size;
+};
+
 static inline phys_addr_t kvm_s2_trans_output(struct kvm_s2_trans *trans)
 {
 	return trans->output;
@@ -132,6 +140,7 @@ extern int kvm_s2_handle_perm_fault(struct kvm_vcpu *vcpu,
 extern int kvm_inject_s2_fault(struct kvm_vcpu *vcpu, u64 esr_el2);
 extern void kvm_nested_s2_wp(struct kvm *kvm);
 extern void kvm_nested_s2_unmap(struct kvm *kvm, bool may_block);
+extern void kvm_nested_s2_unmap_range(struct kvm *kvm, u64 ipa, u64 size, bool may_block);
 extern void kvm_nested_s2_flush(struct kvm *kvm);
 
 unsigned long compute_tlb_inval_range(struct kvm_s2_mmu *mmu, u64 val);
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 7cc964af8d30..27c120556e1b 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1872,6 +1872,10 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 		ret = KVM_PGT_FN(kvm_pgtable_stage2_map)(pgt, fault_ipa, vma_pagesize,
 					     __pfn_to_phys(pfn), prot,
 					     memcache, flags);
+
+		/* Add to lookup, if canonical IPA range mapped to shadow mmu */
+		if (nested)
+			add_to_shadow_ipa_lookup(pgt, fault_ipa, ipa, vma_pagesize);
 	}
 
 out_unlock:
@@ -2094,14 +2098,15 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu)
 
 bool kvm_unmap_gfn_range(struct kvm *kvm, struct kvm_gfn_range *range)
 {
+	gpa_t start = range->start << PAGE_SHIFT;
+	gpa_t end = (range->end - range->start) << PAGE_SHIFT;
+	bool may_block = range->may_block;
+
 	if (!kvm->arch.mmu.pgt)
 		return false;
 
-	__unmap_stage2_range(&kvm->arch.mmu, range->start << PAGE_SHIFT,
-			     (range->end - range->start) << PAGE_SHIFT,
-			     range->may_block);
-
-	kvm_nested_s2_unmap(kvm, range->may_block);
+	__unmap_stage2_range(&kvm->arch.mmu, start, end, may_block);
+	kvm_nested_s2_unmap_range(kvm, start, end, may_block);
 	return false;
 }
 
@@ -2386,7 +2391,7 @@ void kvm_arch_flush_shadow_memslot(struct kvm *kvm,
 
 	write_lock(&kvm->mmu_lock);
 	kvm_stage2_unmap_range(&kvm->arch.mmu, gpa, size, true);
-	kvm_nested_s2_unmap(kvm, true);
+	kvm_nested_s2_unmap_range(kvm, gpa, size, true);
 	write_unlock(&kvm->mmu_lock);
 }
 
diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
index 7a045cad6bdf..3a7035e7526a 100644
--- a/arch/arm64/kvm/nested.c
+++ b/arch/arm64/kvm/nested.c
@@ -7,6 +7,7 @@
 #include <linux/bitfield.h>
 #include <linux/kvm.h>
 #include <linux/kvm_host.h>
+#include <linux/maple_tree.h>
 
 #include <asm/fixmap.h>
 #include <asm/kvm_arm.h>
@@ -725,6 +726,7 @@ void kvm_init_nested_s2_mmu(struct kvm_s2_mmu *mmu)
 	mmu->tlb_vttbr = VTTBR_CNP_BIT;
 	mmu->nested_stage2_enabled = false;
 	atomic_set(&mmu->refcnt, 0);
+	mt_init_flags(&mmu->nested_mmu_mt, MM_MT_FLAGS);
 }
 
 void kvm_vcpu_load_hw_mmu(struct kvm_vcpu *vcpu)
@@ -1067,6 +1069,99 @@ void kvm_nested_s2_wp(struct kvm *kvm)
 	kvm_invalidate_vncr_ipa(kvm, 0, BIT(kvm->arch.mmu.pgt->ia_bits));
 }
 
+/*
+ * Store range of canonical IPA mapped to a nested stage 2 mmu table.
+ * Canonical IPA used as pivot in maple tree for the lookup later
+ * while IPA unmap/flush.
+ */
+int add_to_shadow_ipa_lookup(struct kvm_pgtable *pgt, u64 shadow_ipa,
+		u64 ipa, u64 size)
+{
+	struct kvm_s2_mmu *mmu;
+	struct shadow_ipa_map *entry;
+	unsigned long start, end;
+	int ret;
+
+	start = ALIGN_DOWN(ipa, size);
+	end = start + size;
+	mmu = pgt->mmu;
+
+	entry = kzalloc(sizeof(struct shadow_ipa_map), GFP_KERNEL_ACCOUNT);
+
+	if (!entry)
+		return -ENOMEM;
+
+	entry->ipa = start;
+	entry->shadow_ipa = ALIGN_DOWN(shadow_ipa, size);
+	entry->size = size;
+	ret = mtree_store_range(&mmu->nested_mmu_mt, start, end - 1, entry,
+			  GFP_KERNEL_ACCOUNT);
+	if (ret) {
+		kfree(entry);
+		WARN_ON(ret);
+	}
+
+	return ret;
+}
+
+static void nested_mtree_erase(struct maple_tree *mt, unsigned long start,
+		unsigned long size)
+{
+	void *entry = NULL;
+
+	MA_STATE(mas, mt, start, start + size - 1);
+
+	mtree_lock(mt);
+	entry = mas_erase(&mas);
+	mtree_unlock(mt);
+	kfree(entry);
+}
+
+static void nested_mtree_erase_and_unmap_all(struct kvm_s2_mmu *mmu,
+		unsigned long start, unsigned long end, bool may_block)
+{
+	struct shadow_ipa_map *entry;
+
+	mt_for_each(&mmu->nested_mmu_mt, entry, start, kvm_phys_size(mmu)) {
+		kvm_stage2_unmap_range(mmu, entry->shadow_ipa, entry->size,
+				may_block);
+		kfree(entry);
+	}
+
+	mtree_destroy(&mmu->nested_mmu_mt);
+	mt_init_flags(&mmu->nested_mmu_mt, MM_MT_FLAGS);
+}
+
+void kvm_nested_s2_unmap_range(struct kvm *kvm, u64 ipa, u64 size,
+		bool may_block)
+{
+	int i;
+	struct shadow_ipa_map *entry;
+
+	lockdep_assert_held_write(&kvm->mmu_lock);
+
+	for (i = 0; i < kvm->arch.nested_mmus_size; i++) {
+		struct kvm_s2_mmu *mmu = &kvm->arch.nested_mmus[i];
+		unsigned long start = ipa;
+		unsigned long end = ipa + size;
+
+		if (!kvm_s2_mmu_valid(mmu))
+			continue;
+
+		do {
+			entry = mt_find(&mmu->nested_mmu_mt, &start, end - 1);
+			if (!entry)
+				break;
+
+			kvm_stage2_unmap_range(mmu, entry->shadow_ipa,
+							entry->size, may_block);
+			start = entry->ipa + entry->size;
+			nested_mtree_erase(&mmu->nested_mmu_mt, entry->ipa,
+							entry->size);
+		} while (start < end);
+	}
+}
+
 void kvm_nested_s2_unmap(struct kvm *kvm, bool may_block)
 {
 	int i;
@@ -1076,8 +1171,10 @@ void kvm_nested_s2_unmap(struct kvm *kvm, bool may_block)
 	for (i = 0; i < kvm->arch.nested_mmus_size; i++) {
 		struct kvm_s2_mmu *mmu = &kvm->arch.nested_mmus[i];
 
-		if (kvm_s2_mmu_valid(mmu))
-			kvm_stage2_unmap_range(mmu, 0, kvm_phys_size(mmu), may_block);
+		if (!kvm_s2_mmu_valid(mmu))
+			continue;
+
+		nested_mtree_erase_and_unmap_all(mmu, 0, kvm_phys_size(mmu), may_block);
 	}
 
 	kvm_invalidate_vncr_ipa(kvm, 0, BIT(kvm->arch.mmu.pgt->ia_bits));
@@ -1091,9 +1188,14 @@ void kvm_nested_s2_flush(struct kvm *kvm)
 
 	for (i = 0; i < kvm->arch.nested_mmus_size; i++) {
 		struct kvm_s2_mmu *mmu = &kvm->arch.nested_mmus[i];
+		struct shadow_ipa_map *entry;
+		unsigned long start = 0;
 
-		if (kvm_s2_mmu_valid(mmu))
-			kvm_stage2_flush_range(mmu, 0, kvm_phys_size(mmu));
+		if (!kvm_s2_mmu_valid(mmu))
+			continue;
+
+		mt_for_each(&mmu->nested_mmu_mt, entry, start, kvm_phys_size(mmu))
+			kvm_stage2_flush_range(mmu, entry->shadow_ipa, entry->size);
 	}
 }
 
@@ -1104,8 +1206,16 @@ void kvm_arch_flush_shadow_all(struct kvm *kvm)
 	for (i = 0; i < kvm->arch.nested_mmus_size; i++) {
 		struct kvm_s2_mmu *mmu = &kvm->arch.nested_mmus[i];
 
-		if (!WARN_ON(atomic_read(&mmu->refcnt)))
+		if (!WARN_ON(atomic_read(&mmu->refcnt))) {
+			struct shadow_ipa_map *entry;
+			unsigned long start = 0;
+
 			kvm_free_stage2_pgd(mmu);
+
+			mt_for_each(&mmu->nested_mmu_mt, entry, start, kvm_phys_size(mmu))
+				kfree(entry);
+			mtree_destroy(&mmu->nested_mmu_mt);
+		}
 	}
 	kvfree(kvm->arch.nested_mmus);
 	kvm->arch.nested_mmus = NULL;
-- 
2.48.1


