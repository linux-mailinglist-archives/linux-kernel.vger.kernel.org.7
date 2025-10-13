Return-Path: <linux-kernel+bounces-849922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2853BD1563
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 05:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53CCA3A5B0A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 03:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9DE199935;
	Mon, 13 Oct 2025 03:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oIjSZMIy"
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010048.outbound.protection.outlook.com [52.101.85.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F03E2AD1F
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 03:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760327751; cv=fail; b=AQ1xAMAlTDaz79XTteD8bPX5kkS0/hv1MIyqmCJbcFtHVnjK+SMY2uEIjEx9Icl/QJGqpcBHgHlj7DLHx5ougDFlknD20/7qIJWkFPDuJZFO9qsNlOpKCay9PaYyWvPFt34Ss4KtazwsZCRZKvEv7TNcSRtgiPZhuJ0Slo/9P/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760327751; c=relaxed/simple;
	bh=w8b3pAJlegfB9YeuINTN2y+F/c5Zrbm3jyu36ukTSl4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=uiL526hnu9wJbWOYk6IdjTwvlrpfS/FOyVSViue82L5/91pFTKF42HoePwRnnRi6FAaDGMwOVngn8Cs/Hpt1SSBeF2Ldb0RVDIwYt/5K4odwlrBQ2dtA+hD68qUVU9YQg4qyMgOPJEynRJuZsx4pA5uSMz7ySLpQsM3A06H8jO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oIjSZMIy; arc=fail smtp.client-ip=52.101.85.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZFzhTa2agAAeeQubiaeZF9lnxZ59GvdwlOHUGjC3ghf/AsMGKCsCcTNzgMkCa6tBKNY7hKiB9On3QG/8RXBwYeQKkgyURrbvmmjskgUUkkBA7ATv38+j0sh9paARhA19WoDGK9kGgByM2UC4Y9vlmGN2gkvzhYnB9OWH58X307hPeQWwpvmDmGql5qFl0rHPZ+dTbs1uZQUPKhNQjrBD0pzy+YpmrGx2EIICqzeqjyoqOQVfYDbCG/b9loIBY9Pz7XDIc8HyYLNGkzyi7nGHyX5hU3JW0en1cmCP028BNJ3azN6fdjwVezYqXbTuW6sbmF2wOb6mgma1wZxl82IYQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4jg/8br0fHxf5U6lZCLfehvrb4LdKGHcymy478nKLKI=;
 b=n9HIqdqm096e0SKNTqCTRFav4SSecWYeCGfcGdPjcTjEz/gS0waqATGkb9JycY0p9SOyOli5q+zRVq44FPJVj31m5aV1WXb2sysHm6KpJ31mxB2bFmRxEJIV1+N4Zr8wtV9rPdxSVV1IIMhIt7klaN0Syzz3R1wCM+Lqtr+vRaX1crTyvj/lV0xoAB4rbuUiCreW1tq6+sZJ4RB/eJziiscFZ+/SwaOKo6CrJsv0yt9iJ6fvRbYBHkVcE0KIP5YUb9xREqTbBXQCLPHoOivmXFVQ8zd0TZO6GahKsV7yAzusSjkPwlB08JaVJ2ouf5fjYvnEMj9psMCqRu0zHGguMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4jg/8br0fHxf5U6lZCLfehvrb4LdKGHcymy478nKLKI=;
 b=oIjSZMIy5WiEJOJE9vQgcncjkVPmq7wCbylrkvGWgFj2rns8b2MRTYiDZXB8t79wW2weJ+hveIpXi5Y3nZ4Cr1iwZP8QipnttZsUyqT7ElKHwJsXJDWm0Hv6gqXWyCHPdDB+Oi1Yv/wUWMAjMmmBqY7QWcvOGkYwMwYrjb8ik8rAs+ki2+O3sTDd/9lYmCgAAAYPM+MbY8XbswJqeQ1y+u7srnvI9mIY2KhXyXP7vz2jAPzm3MJhUGmUAYDkcndnjFKQE76pP1url/JtRaqdQzVximMQrFLGizAg5u409h/Hzsc5thzWywj0aCs9ZHyeZLlgptq/Zt2/Q4bVmmxrDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13)
 by SA3PR12MB8437.namprd12.prod.outlook.com (2603:10b6:806:2f5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 03:55:46 +0000
Received: from PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251]) by PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251%7]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 03:55:46 +0000
From: Balbir Singh <balbirs@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Balbir Singh <balbirs@nvidia.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH] arch/arm64/mm/fault: Implement exceptions tracepoints
Date: Mon, 13 Oct 2025 14:55:32 +1100
Message-ID: <20251013035532.1793181-1-balbirs@nvidia.com>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY5P282CA0088.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:201::14) To PH8PR12MB7277.namprd12.prod.outlook.com
 (2603:10b6:510:223::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7277:EE_|SA3PR12MB8437:EE_
X-MS-Office365-Filtering-Correlation-Id: 8acbaf88-ae0e-471d-46c4-08de0a0c636c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|10070799003|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Nt/k4NpjXzuo4Wym+li22EG582+csRi2JL8I5V1Zvb0QFNJSGwNA6LwLchUt?=
 =?us-ascii?Q?YsbvK/zsAF5lZOVFb5olAYNn0ylxD9+w5C4pp9S2hk37bk4O5XGA/EUpOLmO?=
 =?us-ascii?Q?jhB/+BZM483HfF5RFkCqdnvEKYG4XikYrwPknuryYvJwjfsPoEpzNZ6nQBMz?=
 =?us-ascii?Q?dvNj19HsRZ1tBGi3KwaC7JvGJGxNSLBpEBznHO44Vn4ttxwy0VcN7EvoNZ6h?=
 =?us-ascii?Q?hVCcMCQnrbOnMU08fuZwAWZnE0aeOT/ivA9yCx9bnNMPIZbc12ci+gk7/UqD?=
 =?us-ascii?Q?p9LF/hF8glpNnfgtN6FeF28j8AXVi7Vf0R0kwyg1pSRJqdN6E78swT7m2xe2?=
 =?us-ascii?Q?oF/jh6MCzaUFB3WWYrwuIY2qaogrhudT17GwnwIPkTEwSRYLcpWfbZGmr9Rm?=
 =?us-ascii?Q?/fTFlJINgd2GXmkQAZF6ooJ38JcsFeZnef4P/QhEuDFdfGlwK9adnr79MXa7?=
 =?us-ascii?Q?7R/WFcBmkuxwNRuFO7VkS5ZpLcTGQgsH+vzCi7JobclNahGxCy5DS7iRd8xm?=
 =?us-ascii?Q?umWGeEiYcfemsuCL6FsSXhkO+m4KwHg1J4T7180qiS1NHkE8lBOIHg+yuD6h?=
 =?us-ascii?Q?1nlb+ZcWw2YWvc07SRksVLmpGoYRNOg8xO3dGXyqO+zADusLBxdQ2lQJEB0/?=
 =?us-ascii?Q?ok3RRE8/WWEvgxVk7sPKrwWNv/DPUhVMKeuoTxV2sEAS8MLt/PPdVjE6egZw?=
 =?us-ascii?Q?sA1q/N08/xDqjma4HrDrv5kYoyT1eCHmF8Fl3SVj7t9q3CIV4wydWHCm3MGs?=
 =?us-ascii?Q?tTyMxab1oDZkevuBOm0IvbKstEoi9+dyoLrTuxkAXnh9NYPk4ah9zNJBbAHQ?=
 =?us-ascii?Q?4VIVqO0pmNuzpioMqvI6AFaGk2ubUlz0jHa6IM3B7YddUm95Y0FGDSHmq+Y9?=
 =?us-ascii?Q?ybrhBAx3sYJlI9ySFtsdqK4EXsogoO15oaI8a0qKWioGJHNkfQz8xva7uDk/?=
 =?us-ascii?Q?l/34P1lxlcMK5yNQwobGMM7g846hN7i951Ij6vkhhf3aC33m97EafddVnvda?=
 =?us-ascii?Q?EZdPabsA7MeX+FjUyt1PQXTd62lCh+EsIVnfOHaDcmAeV505p2/yTMzIFB07?=
 =?us-ascii?Q?dEfj5CnPjc18ngoTtaDLuRsMFy9TvjW/b6rplDOyedzcp+n4VeE2Mz/e0dP/?=
 =?us-ascii?Q?f4zJo4zr4aFfmpoH90+FM8zEqz9O28ocEFFdz3RgD++ExKlLvLaKwyuJcnY/?=
 =?us-ascii?Q?KN4u/i3QT/GL8OdKk0Okms6Y9VQ6ILQBiJcCdR/wzZqrf4NSTEWF4OQwYK7U?=
 =?us-ascii?Q?rxQFBa/vBAHLxjE1wCh+38DvWa4tOueT0/r2cMenLBplLRpXut+xm6E/perE?=
 =?us-ascii?Q?2FbrjeOVFxbYabUMvzqOrtE0ZQs2HvwN9i/xikjxQHj68uO9vrg+SXZ8BVQv?=
 =?us-ascii?Q?8cj/JQqDzOB/JLOHeHudcL0q26Ttskg/HrO1fH1V6Q+B62UZIJpHpHSh2v4v?=
 =?us-ascii?Q?QCwo8oS4LPR9t/17GInZUSqgZjkr/LLI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7277.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uo3oZueRi6zRx9rEvvWgsaasW6Kk8xW9z47BWobIRL4tgxsr7j7WF5aeE7c3?=
 =?us-ascii?Q?Ljf4kLOgfkrZ1mjqPQ51JgIbd1yHJLovLK/w2/vL+2PzojHBNMfoSnXZcPyb?=
 =?us-ascii?Q?IIvlS4LEJSP/WY7znnTiGDdKZVzm9nX1jep9ZyinQ4NMadDrZAiTvUFTw5zk?=
 =?us-ascii?Q?TQ2b1QlAhvFyPOHZcyp1R+KAVUJ6a2o2NA4FI2wqF4xRjkO6nQNSBIgRVVte?=
 =?us-ascii?Q?GsibWoEIWMR304m2DmK91ZOxICGauweVCURqPIMP9cfMAK7l874H9HcZzzcV?=
 =?us-ascii?Q?dE8RU1yF8u48uKxf7Z+PBwNsLU1R0Fpnu8ZoblOdLNupW0VDeVhVT99RgATC?=
 =?us-ascii?Q?0eB+/EXEVpPmvQeE+89b4/peiJo5v8oh2GfBR7a+VcbGmbWMQzldNjHMgO04?=
 =?us-ascii?Q?eTY/J/a48giHBAHMILvTEmY5Ot5O9tG1jFXVlS8FnNZneeolx9gLZe9ZsX64?=
 =?us-ascii?Q?irylX4HIOPoKm+ceEPVEbeqO1MEBwb1u7wG3AKNQmVFa3BRJRkZkhmsil5Wv?=
 =?us-ascii?Q?80J6Zhi/KA03PLnGxFlK8aNYIcaVqmxDqONezQMn7Jo/Pu/IzK3vK9M+vm3E?=
 =?us-ascii?Q?X9rj8WNrnt/pcAKNXfu1M9zkaIxx39gbQkUYk03ls2XcAx+f0+LXrjc+MhsB?=
 =?us-ascii?Q?NMZzjasndg4658222Gfk/JPiquRYpLDHJiIe4XgQkyXxxRdrnwEEUoS+zUkQ?=
 =?us-ascii?Q?6pEEU6vca5RCPFh7QMl5k2+0sSTO23GiCtNAtcqraFbQjNkBRMI9u9Pv1FJT?=
 =?us-ascii?Q?WDzOagz8fb399+RMlEhCsfVl/o37I+5E4N+aX6eDNY4J5mxcoGpnWivQ+mVH?=
 =?us-ascii?Q?qjgHe7g8qz+m0LjXQ5YV3UZZiWxC8EiomDKR51w03/MZt8tIvgvAWiKR8aWP?=
 =?us-ascii?Q?X4+UUcFWFONVOevnZeGSzcUnbQ1z/GZOmWoB4ei+x49awXnD4ePZLCwmW61a?=
 =?us-ascii?Q?mj9mWqK7OBu8rRQHt0xpnAW8PvHN+XC2PxwaPN68txL/Im3VkQ+yhiLfXBLs?=
 =?us-ascii?Q?fGvV3EVoFxuTzSEGm0XsMZBSSUsBMXsNIWWwUS5lfZMx4biZNQPFjAnnO78A?=
 =?us-ascii?Q?LOVPxJqpvu+hFro1KigdjeHXT4t3xLhxm3Uuec6EPxrHOeWCUalQMy5RWR4g?=
 =?us-ascii?Q?oT7w8X5z7HmTAYRUS3Y1lQyFdOj4VpWMPkYfUmD+H0mKEdhvLMbA4jjkxVxL?=
 =?us-ascii?Q?bhoRMpVC7kpMEWi+g4yFKUchLXD3M34eFBcToWRmPuazgKqv7IKnDvCb/n38?=
 =?us-ascii?Q?UXi5kddDc6bvnfZ3Eo5YVPkSTUnNEOnxLKn7c9mm36MMfBBfHL7FLVYPv6F0?=
 =?us-ascii?Q?U5TGNkHsCexN5/E03nXjsxZYDFCRaC6L7Le0u7pujYeERr8V3alWirLsEs6G?=
 =?us-ascii?Q?yBW7Pg0eK3G9Ztb9BcoTUdbYiTaOvTLWP8G/5YWAyFg/tVlO9VbBOHkveF40?=
 =?us-ascii?Q?vgjTGl3t/JrZhEeY/NpCbnol6mpTxk8BVLMGY0Va/FgftsLpA2xkdpowYnlY?=
 =?us-ascii?Q?reHX7NJAVrlSJkQ44rStUqpuCynBzkuUUEfnOd19/wGytJ6CGIe20XFfxJZB?=
 =?us-ascii?Q?eK1zENNT9GUB5QQ1gfVh9Cx3eLPwHULWgKeCflK+e/cbgXwbAZHrbjB+C7Fw?=
 =?us-ascii?Q?xQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8acbaf88-ae0e-471d-46c4-08de0a0c636c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7277.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 03:55:45.9815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p12BkktSPT1HPr4BJ2NWgY+5D3eIaQA4ntIEGVBZmGdgEL01za3rDbxrBg/lPrg+7clRqFpkURdoYkGXEeLBLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8437

x86 and riscv provide trace points for page-faults (user and kernel
tracepoints). Some scripts [1],[2] rely on these trace points. The
tracepoint is useful for tracking faults and their reasons.

Adding the tracepoints is simple and straight-forward. For arm64
use esr as error code and untagged memory address as addr.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Paul Walmsley <pjw@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Alexandre Ghiti <alex@ghiti.fr>

[1] https://www.brendangregg.com/FlameGraphs/memoryflamegraphs.html
[2] https://taras.glek.net/posts/ebpf-mmap-page-fault-tracing/
Signed-off-by: Balbir Singh <balbirs@nvidia.com>
---

Tested at my end with a kernel-compile and running a user space
program to check that the trace points are indeed reported.

 arch/arm64/mm/fault.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index d816ff44faff..9d7b86e92434 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -44,6 +44,9 @@
 #include <asm/tlbflush.h>
 #include <asm/traps.h>
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/exceptions.h>
+
 struct fault_info {
 	int	(*fn)(unsigned long far, unsigned long esr,
 		      struct pt_regs *regs);
@@ -572,8 +575,12 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
 	if (faulthandler_disabled() || !mm)
 		goto no_context;
 
-	if (user_mode(regs))
+	if (user_mode(regs)) {
 		mm_flags |= FAULT_FLAG_USER;
+		trace_page_fault_user(addr, regs, esr);
+	} else {
+		trace_page_fault_kernel(addr, regs, esr);
+	}
 
 	/*
 	 * vm_flags tells us what bits we must have in vma->vm_flags
-- 
2.51.0


