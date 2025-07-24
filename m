Return-Path: <linux-kernel+bounces-745002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C520CB113A2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 00:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E5E61CE0A14
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 22:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E921237704;
	Thu, 24 Jul 2025 22:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="vgMp5Pj1"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2108.outbound.protection.outlook.com [40.107.236.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1BD19B5A7
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 22:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753395175; cv=fail; b=n9lXCeOI6qmxlRD2u6AL9LQwrIpKfFJAc7/DVlYXg+IZ4xMbRFdypmE0K4KD4TizOjsuX2GAhgb55PVbpxeRJ+vT9LXpAg34DQMBRExlX54wMZ/pD2f+PVfS93/qS5s8oqcxkcBgloU0m3G0Pxl8AH+2nvGQUxDRpZjfKvqv6lo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753395175; c=relaxed/simple;
	bh=+qwKG1rby2LIPfkzW1c7Vppv+xXO6GQff7SMEs1GSik=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=pF9VUvfM+nTL0a/EIiHB97FpAJ9QqlmJMOFQUAQtYMkTS1JmFzyRp2GtO9OQqIJqY2kHCWEGH4R6q9qcRNkTlrOhaIs+yKIyTrntXUv8crGspAPslI9K6G67S+LFEu3UtK1dRT1x7OnN8VJh8wd008Q8gY9tFFZWfUxngPJHK+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=vgMp5Pj1; arc=fail smtp.client-ip=40.107.236.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NzMKMp2c0G3A8HrCjTc6w6w2jD7d/Cbh2uQXatriDSGgKPFlHHdzZlGf3AZ0jm3gLUUciE8c3pn7O4yoxrllmcGINhA5+/HTbicwmuU4oea7dkoC+ZvSDlbtrDjFTMqvGHNLfYCw9VMnwlXnmqmArmjt2oYpQXZ8UI0moKAWgECuYKnqM+YAyNe6DRzFrRHSw5HSI4zIyf0xaAMoMJyVovKFDaCEbXN97g96xUU9PD+Z35IqOgcxLXomhVxIPBGEoyaJDbQUls3eP+VcyYdK0dZIrd3kD02x88xi1DwHCozN7OBpR4+b1ePdsaNcre29n6Z6fI6M387IIyQ8YyffJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ev7HhyPztgJ5UsmV8KW1yc3wGVsHTuWCaPkCHSvZljM=;
 b=qMoHifn0xLd/fnB7DXLjt+CCcevERy2Hx5lqoZTBzxPFjVNDs0nwqgayJI3N3IA/DrqXkW+iFFWYlU6AZwyUZmVuD/I1/W2qkbJdVfDUpbNfxNf70Sk2n72lt18ZVLejaRDjgU/kTarur7HaXV7u8lji3oZyJZ1lLK+YVM2plDCiwUdf1Q8ZRVO/ircT0CUHu5DtAiFeoZN92cPRnMcoOYDUWn0quCIU24iED7Sf3bH3kSow56Nmek6yrlTFHMvVzkeWsqWIyVvrUcsK4rGVIAHqJZAJr367mHkX46YwVEtZ6Ah3QHH/vYzDJbZ7ITMfwkjmAh8bPrEkPaGH4dyAGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ev7HhyPztgJ5UsmV8KW1yc3wGVsHTuWCaPkCHSvZljM=;
 b=vgMp5Pj1PvBlr0c3ruGQxYCdQ7+1hUYymoxZ4qaiaLUpHcpt0x89Vvfbr+hvQK5g2UkhCFWFoiwXyMBB5jO5x6cOZn3CK+zTinh0Og4vn7tbb2iWY9o1e0mERA6V3LvfcqMQU+WZxus3A5BIdKP3Dbzm7dXHghy6rk/iV3Kc1yM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 SN7PR01MB8089.prod.exchangelabs.com (2603:10b6:806:32f::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.21; Thu, 24 Jul 2025 22:12:49 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%2]) with mapi id 15.20.8964.019; Thu, 24 Jul 2025
 22:12:49 +0000
From: Yang Shi <yang@os.amperecomputing.com>
To: ryan.roberts@arm.com,
	will@kernel.org,
	catalin.marinas@arm.com,
	akpm@linux-foundation.org,
	Miko.Lenczewski@arm.com,
	dev.jain@arm.com,
	scott@os.amperecomputing.com,
	cl@gentwo.org
Cc: yang@os.amperecomputing.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [v5 PATCH 0/4] arm64: support FEAT_BBM level 2 and large block mapping when rodata=full
Date: Thu, 24 Jul 2025 15:11:02 -0700
Message-ID: <20250724221216.1998696-1-yang@os.amperecomputing.com>
X-Mailer: git-send-email 2.50.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY5PR15CA0236.namprd15.prod.outlook.com
 (2603:10b6:930:66::8) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|SN7PR01MB8089:EE_
X-MS-Office365-Filtering-Correlation-Id: 80b8c238-faf7-4a06-12a9-08ddcaff39ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bFfkFjmB8AmEchEd3M4gIR9bX4orSUm/t/eKxwUgTxN/8cLaF2vMC5lqpsTf?=
 =?us-ascii?Q?HWwQWu+T0hLpKi3C26chLuMbP1MdwFLV+GxzyIIb+W7yqXKqiYFbdqxWy2x3?=
 =?us-ascii?Q?xMc6lf+x+owtplxucRiLSDSpRsep36pESpEogD3cvToluLxzMCe7xXafa0ve?=
 =?us-ascii?Q?o0tsOOTM0f0pim1aiBTuJPCHjYN9tLgHWlKAI+uTx58VEZDjIlNezmtECdSm?=
 =?us-ascii?Q?/bQpPcDEgsYaV/tzBf35lPjZyw3kH+Yu6i6xiIr/j+W2/63SrixDY2S+R3MC?=
 =?us-ascii?Q?FcZv2iIoXc15jQrOHMgvS0/6dAr3/KsxSceOLLkScGAJyt7qbJWs4wIhB45p?=
 =?us-ascii?Q?6P3JXv5N7m7mbhzvukZzUMgih71zSyLijmF3f0vPOr+E1qKt37sNaGVvLAPI?=
 =?us-ascii?Q?clu7SSEAWm5IItJ38LMPxRfKQ6yDkRvTJL6UXb3d5tFBdSLr/k7mEOgRrdLB?=
 =?us-ascii?Q?V211UtVGLAy34RD0yCiREbtRZvFoEPkbr2IBuYBaSB87dekGTBocM3KBZrIh?=
 =?us-ascii?Q?92QTjqf8sfaukGIMHO1SWocrU0dQMm0VgLan5e459trKbjh/eFy47fcKdtzq?=
 =?us-ascii?Q?XwFWcycgPmZoz6qJ0axEAgIcQTIvt9I/6a+frm7bJoJ5N3lKeeCGcbIUBHeI?=
 =?us-ascii?Q?uBgmzLlb90OvgmHHlWHGWRbCAp6zrxXaDpKmD73Hjc4nL2AbPe9nGm3LaSWs?=
 =?us-ascii?Q?o0qqAYmTCa64KtaRd7d7PxQREt9M7ZEiA8gWPfM88TXOkr091nW/++m9o6Gh?=
 =?us-ascii?Q?rauNcCxvgcjC9MiQbwfi8nChlPoQWTO66g9Qd0unMEKBdZ93nXWzaWX6AAJQ?=
 =?us-ascii?Q?QuJL1tZTbL8u02QwVddOsM0un5Yf8LxaBUh/YbmkvlAC2bX65p+bonAiruwF?=
 =?us-ascii?Q?mtCtGRyvWAwGzUXz6e3q85h/hvfHqdsZp/QMqopxaYwADg6sjuxOqcnPtoGx?=
 =?us-ascii?Q?AJkZ3bOSR49hkCeByGvrjSzYMC00ELb12E6Eof3+IfVj06rlBlKOiFV9xxAc?=
 =?us-ascii?Q?gSw8gQX7J3KmHorMg4g5Q2Yl/j1VuHAJEy1VwKBQBoanJMaQo+WqbNPYUaC2?=
 =?us-ascii?Q?B71EuFh0NRpoxX7NI1A2YbjBFIFRYcLDXMnm/q7yRunN37h75MmEB9QkmThu?=
 =?us-ascii?Q?dbR5qATswQ8n6KPOl8bQjRkknqKaPNE05SLVqJ0FDFFkrJD1l7eUS2YJX/y4?=
 =?us-ascii?Q?VLARtl1gzXcqjGRH4agewx2ilgUPvVrDlrR8zfH9zmI0gb9+k1cZ5F3zW2WS?=
 =?us-ascii?Q?5ymTYG7uUI/qkRcjSuSA5ITkLERLH5H1VB3ASptABOqjS3gjBCIcjZzd1Gb1?=
 =?us-ascii?Q?XySDMtxUXhZtkAVow4QwebVTnRstSGEdoZzP9A5wAptH10FTzYxMZuV2xuBR?=
 =?us-ascii?Q?W8ijDloEbETfQhvnVJigTkl5EBpWqa0M7kf+RGRRPExZM1N2aZaK8szx8XTW?=
 =?us-ascii?Q?Co/wFP7YzpFUcnqKpfhZZFGVGuCcb2a31viZLAphZ6VvElUfWeQff0JjNcUe?=
 =?us-ascii?Q?5P3FgnoKXCHPF1M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014)(13003099007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2gm+29eJyM6oIW0+UFapEq2OcX3X7tXjlRvAv4CRBywDxz0Op1a0xEj3kUtC?=
 =?us-ascii?Q?hgeiest1Ae9UwN6pUvsRPlDsUkA7evfXsroDFINVzd5rVjuaTj/yNsvCYA+p?=
 =?us-ascii?Q?JNd+UG+Px3XLHNCrN2pXGD6eNNgkEUFI3mNz8Ag33k+mSTrRhP0tQKad4scs?=
 =?us-ascii?Q?gdsHrM4P+DihRh9Rkta83mqFyM/N8qSPMFLv9d3Wtb8LosN9aeSEYGGJHoKE?=
 =?us-ascii?Q?pc5NOnfc9eMhlFG/NAn/jY6vt5UOFNywDgMKBDC+MX8ot63q5i1qvmdx7z4R?=
 =?us-ascii?Q?8+RAI0uEh8vwA9Yww2u2S59WwXorklyXAXv3P4T1NI3dBJctj+oZSv7Q6Xqk?=
 =?us-ascii?Q?Po6ThwSCyGiGsGccLZQklj33rng0nfYlZG+ZYyAeKWEYGFw6RaFjyXnrQwSw?=
 =?us-ascii?Q?xvFkEVNxa2TqhQJdJlgF8LyFq/W0LPW5OxHOiKBbQzO5aX95D4x2nR5eC99K?=
 =?us-ascii?Q?/YA9dejUZM88w7wpryUVpB8kXZaUW0CqWqTSWkXJI7tqUKKavV9+VgZW/D6Y?=
 =?us-ascii?Q?NvE9xDo6tyUoVKSdJzRxYxxEp9S4iIINyPJ8k8lMHhMjto1Tht79LmqEDVZs?=
 =?us-ascii?Q?jmvjzDPTuDF5Hg/JFEaL+sZOmUk6qTDok5EShHUPOLgFEkTvWJ/80kyBaJlc?=
 =?us-ascii?Q?IeAvIWp4j1AwfH86Aa9aKONiDJir8JFDgP5fZv0jQ4m8Lcvxi79w0jEOQ5DP?=
 =?us-ascii?Q?kEOOzID3XHS1nWtf2P2YqcpknJqbVHzL0N7yihmZ1M2Zpap7BOCOaN1j3u5H?=
 =?us-ascii?Q?7kTAnLeOCVwOwEdOIDoHWOh/b0+cp8YtoC2UEnP6ZzKBsbVjb/M+AS5zR0I4?=
 =?us-ascii?Q?x1s5qvcbBcR5u0Zwk7ehTpwsvnhxih7Pr20bZ6LSErKuwaXPmt0z+fIPm+xP?=
 =?us-ascii?Q?arXVIAd/HVCKkQO8r+EMYp2Nl0O0eC7dZAj51kyOd78ix6AyPyZrm10X0hWV?=
 =?us-ascii?Q?apDfXEMpck/6LKfI+xWTCv3zUX/Ak2ABI7TuUpPAWMZL0VJyXb7Abw/y9AHN?=
 =?us-ascii?Q?a25TEpMdaevx1n/bGlf9FQqaiwOtGTDopWswV3gGAV33jfo1Vd7f6KegVJNZ?=
 =?us-ascii?Q?23f8wI0i32cJ+ItGi4ukGhWq/lPUH7fX6giYPQypOGsKo/GRv1d1kWmPcBeY?=
 =?us-ascii?Q?xmfTXK+N19nzKUPzHPWhd8le9ta9s2W15DcHiPqE7U+7Yn7ectSz1krlzTyO?=
 =?us-ascii?Q?QOvGloBMnM1cWX+dC7rThPMqZSYdMcB4FlMIbS+RSEQe9E45LJjbQ5MFo4r0?=
 =?us-ascii?Q?k4forNp49CZz0gIKUMPhnX9pPKWplQq6xbVqe2n9npZvVYLjyrqny/b2BRZR?=
 =?us-ascii?Q?NJvTgtFlN0k9oxNGUTj8Yvz+UZnHusdMqZG6vkN73YMk46yuPhXIJz8v5Jvu?=
 =?us-ascii?Q?tpPKUnrQ2Vt263PNdIS8rRTQUHiRrh7AVw1i5/FyWYogz+BxCcS1cLuhN8sA?=
 =?us-ascii?Q?1Ngkd2Q8GEwI9Z9jKXrHn1QPCIgmIMHwpaVrvcBEUGXeqpXXOUitq8qF7Ak/?=
 =?us-ascii?Q?PU3qyBooLkAS8zRqOUccjMAOzrZw6zPBFd3ljEFb7Ou3a3zuIqITt9w4yLW/?=
 =?us-ascii?Q?pxYhW0lP5PzZr4+L4gS9aEY0R0hG/RF4EndB0bXiDJuV9J693fxSHFsyPi+c?=
 =?us-ascii?Q?nniMlfe+aMxOAxvh2k+iC2s=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80b8c238-faf7-4a06-12a9-08ddcaff39ea
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 22:12:49.5826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AqmaGHruGy3Bu4+6SOTxuHcCPqCfzUEC2QxO6PY6gVEInZO/HF8f8KRR3QRQ05HuP3Bl+PJlZwY+kcXPUSlZ47fqCfKNACkgtNzJDYIzT24=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR01MB8089


Changelog
=========
v5:
  * Rebased to v6.16 rc.
  * Based on Miko's v8 BBML2 cpufeature patch (https://lore.kernel.org/lkml/20250625113435.26849-3-miko.lenczewski@arm.com/).
  * Based on Dev's "v4 enable permission change on kernel block mapping" patch (https://lore.kernel.org/lkml/20250703151441.60325-1-dev.jain@arm.com/),
    also included this patch in this series per the sugestion from Catalin.
    Andrew had some nits on the generic mm part for that patch, but I didn't change anything.
  * Implemented split in dedicated function per Ryan.
  * Dropped "make __create_pgd_mapping() and helpers non-void" patch. It is not
    needed anymore.
  * Optimized page table walk to reduce loop overhead if the range spans
    multiple leaf mappings.
  * Used dedicated lock to serialize split instead of init_mm's mmap_lock
    per Ryan.
  * Allowed split page table for kfence and realm per Ryan.
  * Used lazy mmu to reduce unnecessary barriers per Ryan.
  * Removed unnecessary TLB flush per Ryan.
  * Cleaned up "wait for boot cpu" logic for repainting per Ryan.
  * Misc clean up.
v4:
  * Rebased to v6.15-rc4.
  * Based on Miko's latest BBML2 cpufeature patch (https://lore.kernel.org/linux-arm-kernel/20250428153514.55772-4-miko.lenczewski@arm.com/).
  * Keep block mappings rather than splitting to PTEs if it is fully contained
    per Ryan.
  * Return -EINVAL if page table allocation failed instead of BUG_ON per Ryan.
  * When page table allocation failed, return -1 instead of 0 per Ryan.
  * Allocate page table with GFP_ATOMIC for repainting per Ryan.
  * Use idmap to wait for repainting is done per Ryan.
  * Some minor fixes per the discussion for v3.
  * Some clean up to reduce redundant code.

v3:
  * Rebased to v6.14-rc4.
  * Based on Miko's BBML2 cpufeature patch (https://lore.kernel.org/linux-arm-kernel/20250228182403.6269-3-miko.lenczewski@arm.com/).
    Also included in this series in order to have the complete patchset.
  * Enhanced __create_pgd_mapping() to handle split as well per Ryan.
  * Supported CONT mappings per Ryan.
  * Supported asymmetric system by splitting kernel linear mapping if such
    system is detected per Ryan. I don't have such system to test, so the
    testing is done by hacking kernel to call linear mapping repainting
    unconditionally. The linear mapping doesn't have any block and cont
    mappings after booting.

RFC v2:
  * Used allowlist to advertise BBM lv2 on the CPUs which can handle TLB
    conflict gracefully per Will Deacon
  * Rebased onto v6.13-rc5
  * https://lore.kernel.org/linux-arm-kernel/20250103011822.1257189-1-yang@os.amperecomputing.com/

v4: https://lore.kernel.org/lkml/20250531024545.1101304-1-yang@os.amperecomputing.com/
v3: https://lore.kernel.org/linux-arm-kernel/20250304222018.615808-1-yang@os.amperecomputing.com/
RFC v2: https://lore.kernel.org/linux-arm-kernel/20250103011822.1257189-1-yang@os.amperecomputing.com/
RFC v1: https://lore.kernel.org/lkml/20241118181711.962576-1-yang@os.amperecomputing.com/

Description
===========
When rodata=full kernel linear mapping is mapped by PTE due to arm's
break-before-make rule.

A number of performance issues arise when the kernel linear map is using
PTE entries due to arm's break-before-make rule:
  - performance degradation
  - more TLB pressure
  - memory waste for kernel page table

These issues can be avoided by specifying rodata=on the kernel command
line but this disables the alias checks on page table permissions and
therefore compromises security somewhat.

With FEAT_BBM level 2 support it is no longer necessary to invalidate the
page table entry when changing page sizes.  This allows the kernel to
split large mappings after boot is complete.

This patch adds support for splitting large mappings when FEAT_BBM level 2
is available and rodata=full is used. This functionality will be used
when modifying page permissions for individual page frames.

Without FEAT_BBM level 2 we will keep the kernel linear map using PTEs
only.

If the system is asymmetric, the kernel linear mapping may be repainted once
the BBML2 capability is finalized on all CPUs.  See patch #4 for more details.

We saw significant performance increases in some benchmarks with
rodata=full without compromising the security features of the kernel.

Testing
=======
The test was done on AmpereOne machine (192 cores, 1P) with 256GB memory and
4K page size + 48 bit VA.

Function test (4K/16K/64K page size)
  - Kernel boot.  Kernel needs change kernel linear mapping permission at
    boot stage, if the patch didn't work, kernel typically didn't boot.
  - Module stress from stress-ng. Kernel module load change permission for
    linear mapping.
  - A test kernel module which allocates 80% of total memory via vmalloc(),
    then change the vmalloc area permission to RO, this also change linear
    mapping permission to RO, then change it back before vfree(). Then launch
    a VM which consumes almost all physical memory.
  - VM with the patchset applied in guest kernel too.
  - Kernel build in VM with guest kernel which has this series applied.
  - rodata=on. Make sure other rodata mode is not broken.
  - Boot on the machine which doesn't support BBML2.

Performance
===========
Memory consumption
Before:
MemTotal:       258988984 kB
MemFree:        254821700 kB

After:
MemTotal:       259505132 kB
MemFree:        255410264 kB

Around 500MB more memory are free to use.  The larger the machine, the
more memory saved.

Performance benchmarking
* Memcached
We saw performance degradation when running Memcached benchmark with
rodata=full vs rodata=on.  Our profiling pointed to kernel TLB pressure.
With this patchset we saw ops/sec is increased by around 3.5%, P99
latency is reduced by around 9.6%.
The gain mainly came from reduced kernel TLB misses.  The kernel TLB
MPKI is reduced by 28.5%.

The benchmark data is now on par with rodata=on too.

* Disk encryption (dm-crypt) benchmark
Ran fio benchmark with the below command on a 128G ramdisk (ext4) with disk
encryption (by dm-crypt with no read/write workqueue).
fio --directory=/data --random_generator=lfsr --norandommap --randrepeat 1 \
    --status-interval=999 --rw=write --bs=4k --loops=1 --ioengine=sync \
    --iodepth=1 --numjobs=1 --fsync_on_close=1 --group_reporting --thread \
    --name=iops-test-job --eta-newline=1 --size 100G

The IOPS is increased by 90% - 150% (the variance is high, but the worst
number of good case is around 90% more than the best number of bad case).
The bandwidth is increased and the avg clat is reduced proportionally.

* Sequential file read
Read 100G file sequentially on XFS (xfs_io read with page cache populated).
The bandwidth is increased by 150%.


Dev Jain (1):
      arm64: Enable permission change on arm64 kernel block mappings

Yang Shi (3):
      arm64: cpufeature: add AmpereOne to BBML2 allow list
      arm64: mm: support large block mapping when rodata=full
      arm64: mm: split linear mapping if BBML2 is not supported on secondary CPUs

 arch/arm64/include/asm/cpufeature.h |  34 ++++++++++++++
 arch/arm64/include/asm/mmu.h        |   5 +++
 arch/arm64/include/asm/pgtable.h    |   5 +++
 arch/arm64/kernel/cpufeature.c      |  37 ++++-----------
 arch/arm64/mm/mmu.c                 | 408 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 arch/arm64/mm/pageattr.c            | 159 +++++++++++++++++++++++++++++++++++++++++++++++++++-------------
 arch/arm64/mm/proc.S                |  57 ++++++++++++++++-------
 include/linux/pagewalk.h            |   3 ++
 mm/pagewalk.c                       |  24 ++++++++++
 9 files changed, 648 insertions(+), 84 deletions(-)


