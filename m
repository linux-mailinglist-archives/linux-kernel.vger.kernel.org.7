Return-Path: <linux-kernel+bounces-779985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91228B2FBF9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 16:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8277AC1E18
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 14:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2799323C51D;
	Thu, 21 Aug 2025 14:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZydnE2SV"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5741F463B
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 14:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755785082; cv=fail; b=g5zPLSBnAX4VhyonsH9cl9wCkAAtypdNlPgE7BhrbNhfvdTgdsNYWIRQjy0bXP/C4Kr0zW4rDmmlXnrCjksZzT59FXWKOmKbPuLylKvnWo5dInTwCi89ST3UOyFA6WqoN1Mhp/XI3x8V5Uwqyjvw0NTVkYbzeM4C92UH8FqRH7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755785082; c=relaxed/simple;
	bh=tEq5jAavmsF13aEPBFWNHLqPVhQVFNjtTkzQ6t6cPJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kx/1HxAZe6U/4n9SS3b5uq3+IBr4J7dRAueu95F1SwD1bcfHn77dNOvHTknnlJn+cMBsUSsD/hbr2zkLVSi+/kTerKfhj5P+kHhg/UHy/RvyPL0qQBUHvQ2rIpZ1dTm3TKP1CQYaBKZjXYCr6q9rjg3GjNmGSJ+3z7BnAJj9ano=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZydnE2SV; arc=fail smtp.client-ip=40.107.237.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yvenVXoZuMhOrOWHeqDfreXuDCjxWDbuzYtlWIVJG6Bx2/L9+Vek4D/mtIqutFMhT40VKihFv57jYAmbjqYGUXGWrIJElUpK/65vnYsO0+MtMMpaZGPih1CjE4pyrqcO+MIan54Q+PnxuPkGIlW04p3U7qYGP4A1hdV4cQWtJ39nlYW2vt6NXmGvMbixOhX1M67SOPvDC23VAXEX4kjE1LNU0bfDyg5N9NC8VJPUmWENfNO9w53IhiI6XmYdFPaiu5q40/3cUW2Q4igwE+ezFBWtyacEOrgJGnAejxB9k/KgnKFVsRVXVp02SLXWWgjwcvH4d/8gEQUT1pmW3VUZdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ekt0SyVL0zhGwfCWr9Xp5Xj7oEj3veLe6mrnkmTejTk=;
 b=jKPJO51GxzMl34Qw3WyOm8Q9jslv3LjNCOOFBU43ihjRDDjHd4/2KutmpwoWVfP2wB2UeDaw/73JqrVlk4/+8agwyrq+ODioUcimEvGfNpDSFI1Bf6tPYWnabnKyfMpYxrhVIZQCjxo8jIRKg7nwUU7/Wwi6u1Ri6r+ZwyPmou/PMcL6Rvq+PwLgyQVKJyPPC6G79mKyMDFrcdJ1vfbuFlfxCOn2fLUAIBEniTiGwRH1dJAk6Wse1njExqzCGZcTTfMhBwywcTIzrZ1eEI4PFyZb+bzZuKxD2sVpLNhpBv1zIPEmlQ8jDIDh04XJLUq3sV2dIoHmT4TgBm15lqoJGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ekt0SyVL0zhGwfCWr9Xp5Xj7oEj3veLe6mrnkmTejTk=;
 b=ZydnE2SVCgmPjTETNREmrcDkz3vjH42Kr5/yl/S8+ogeVkwSX8n7jXl0TRcjWG0N3vm12m0AGXGb9mEOAC8NpqNO4MqsqnG/8oo1nqaxHM/Iw1AWP3IvU5AnaaXzHU27MqLlSy7NY3t5PfrOi7qhe6IMMdANG/4bYkz8hs7e4j/faKR4KNrObHwtCkDKfgqYapIRcB2IliN6mEaaWO/D54V+4a//BxrBzBSxTKSinnJjGvizTuTQObbEZig4O2/ZypBdNp8w3VKBxJkakmdXzpuwW/HbJpnfDwqDxHMUgifAd6q7bG67ljNtTzOFxHPB2fl/w1OOsolvVIRtuw0LEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SJ0PR12MB7006.namprd12.prod.outlook.com (2603:10b6:a03:486::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 14:04:36 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.9052.013; Thu, 21 Aug 2025
 14:04:36 +0000
From: Zi Yan <ziy@nvidia.com>
To: Brendan Jackman <jackmanb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Remove is_migrate_highatomic()
Date: Thu, 21 Aug 2025 10:04:33 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <C0F291DF-60B2-4662-834F-162AEFB10E0B@nvidia.com>
In-Reply-To: <20250821-is-migrate-highatomic-v1-1-ddb6e5d7c566@google.com>
References: <20250821-is-migrate-highatomic-v1-1-ddb6e5d7c566@google.com>
Content-Type: text/plain
X-ClientProxiedBy: BN1PR10CA0027.namprd10.prod.outlook.com
 (2603:10b6:408:e0::32) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SJ0PR12MB7006:EE_
X-MS-Office365-Filtering-Correlation-Id: 14f94106-4bcd-4e88-b50a-08dde0bba947
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Z6fU4RW25QD3A5+Cn30BrOV+CnFe4AmPqdmH9GoGfc779M6JkbbWFQpVSMNS?=
 =?us-ascii?Q?L1Kg3/1MF+cF0Ne2Ju8szcP7sDjx6RhwtcoNpV/d9bMGV3T1+uLPp/tQxvSG?=
 =?us-ascii?Q?kwKZ4mDLEcPB7miWZfsWq+uv88DXxvYxgu+PtE0A0GRnlH/IKWWgsIHAcZpf?=
 =?us-ascii?Q?m2BjrhUaUmDjLHLMHeZyuOJkvT9qQ2AoPicaGDjzHid5aJKUD2UM9wIgXgKA?=
 =?us-ascii?Q?kAwlCUvU6K+9a2SjkC2TLGPfb0PCbnjTOVF7G497LN7jV9ww1BAx2AIj8azi?=
 =?us-ascii?Q?SUVJPSyHC45VlZqUyTuBTTpHuC3hPM6SxhfYL4APuVk8WPKOHaZtN5Z+9BqR?=
 =?us-ascii?Q?2R9AG3FoVxh5TZxSyUjWeGMdNgvqZkFi6TifBozZJk6icv5oYB4Sav9cUwS5?=
 =?us-ascii?Q?e/1BTXmTkNIiFaAR4J0TsPGyDDYDi0F69EDEW01lZEDrVempZ6cAiajZ8dV/?=
 =?us-ascii?Q?+nIw19/C2ycUaUvercZdX4FI1dbLrzO8cqQ2ucsXKx6bfY9n+naQgShrHC+G?=
 =?us-ascii?Q?xfiEFKXCUjuxXdwPomTWfwqNQRUw+KFnzX81ZmaC147Pj7wwk0oPG3pUPjXF?=
 =?us-ascii?Q?LcblZ8q5Qa974vPnHoFakHFeaPVGdLhuK0LtkMIUxdsbpIdmY0+hVq3+qinA?=
 =?us-ascii?Q?Inx2alaDNWE1YdQqmb/ohl9SHa6nJhkJm+aEopltnjO09YXYo74aUYybfYW/?=
 =?us-ascii?Q?G8yNLOZsrDEo6dKu+KiCUWAy7t+xe/QJMZ9zjJ3EkqdX9ONkjDM9xPkFnl8Q?=
 =?us-ascii?Q?p6MIBB8utCPZAzo/PX06X6hlFHGdP87eKWZZSZrMPp7DOnX5f0JPHR3/d6+j?=
 =?us-ascii?Q?vVD4C0e874vehCYUMUn3PXedvSi3pqfy0fRNzFk6HZOdYLXwbZjPjUj25ATH?=
 =?us-ascii?Q?e6AAxiGErLWyMV7fFWXL4Zugo5r4riappgl24KHuqeqnyyJVuCUsImPwWVTn?=
 =?us-ascii?Q?y0drF8zaqHfQbNjLpVMOthoBbrQ5v95pDuH8sV+szE5Eb7YP/5xIbBq2l7SE?=
 =?us-ascii?Q?RDyQXPssSzNqC+nT+v5WFJcs4DDR447QZ2SX57fyWs8Zi4BBbuisTaKlW5L/?=
 =?us-ascii?Q?1zyYAOdO4B8KKPCn5fo5JsgpK0Jj9LJ32tspm0FTpbJM2sL8vAgeLXYEns+9?=
 =?us-ascii?Q?atotjyI7YR0Fo3LXJD+S324H3cInKs7pJJT7J1tU2c0aVsVyrZJrG6iJP47C?=
 =?us-ascii?Q?ejfr0fDhOW+r4mrdY6VIb3LPJvY/P5P7sXkYAySYMHTLI5rdmndmC1JriZJb?=
 =?us-ascii?Q?K1WwsS+7warflhJ+C23AvPmFdt0pRxIubXdbImqdmZSmYOGq/r0tTEoNDioT?=
 =?us-ascii?Q?ZVgn8/ppYqQT+BurYEx5mhHuXA0NK1RrGU5CeHZjmxA0dGGPT8g3AxWDYY7V?=
 =?us-ascii?Q?jWU5OIfesybB7XQS2qAjYO+snPPwEIROb+JHZX021RK1tmsi9g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5zVZDQRX5+iJYGB5i4zW+v/gbjN5BdVm6xbFLZuYzq3aA2P2WshmYbzjnHLu?=
 =?us-ascii?Q?66pty45nL+NC9oT6sQcL49z32T32LNz3CmMaRpXBu8+2WxvSoxTHIvAtZXsm?=
 =?us-ascii?Q?J0ucok54zns9WiNhJGnM9KDARswob8q/3a4er21YG+mAXKNAaca3UOGoLsIo?=
 =?us-ascii?Q?316IARh6VTD/C99CqROfuSSJuIeoFtyj1IHHYbI47YxAYZfRpz4AawrBM3np?=
 =?us-ascii?Q?vxrVRDoLpDHaE176GVvQbFf1M31M1qh+dlktXNaB3OvXlybh82N1XZTadtdu?=
 =?us-ascii?Q?IQO0gZBVChZHKKofKFb6wsfS+rFSju3aF9hS45p5m/YN/sQM4hpbm2MlxJzm?=
 =?us-ascii?Q?f/nkMIghAxb4Soei1SPm/ePTMiLGfpICFs0FVZeLhoB6q2Sml3CKaiU+h4l4?=
 =?us-ascii?Q?8pYmcoY/OegRnu8Wz9fKLPZ7qha2zZpvtDG6X+OPN8aAjCYqL80BE/MFe0Xa?=
 =?us-ascii?Q?A14zodilRDD9uyZWAjNAsPQAMGZfYxoWMGKY0xkhaHjbpu4u4FMSd50c0/yy?=
 =?us-ascii?Q?IUBz6d9uVhjMM6VfewLkDkpGK6/03vR2++rZx12nvMa1Ra7zZtWgg/SsYtZ9?=
 =?us-ascii?Q?411uz2aIhIyXKF/tsVnXKcIW5nHIItvdOFx8ZXYZMIWV/7ckqb/WD3qC9HHf?=
 =?us-ascii?Q?wuPHaoOBLdDlj8huE81yHFe2CEJ64OiHrivqWgUPg3ccfZt/pWXaJFwu4ahE?=
 =?us-ascii?Q?EMaIB9nY6p65mfpqY23Olr3EoR7JRN96kzODTGWO5BbgTp6wqdSirOmDDK5C?=
 =?us-ascii?Q?5Iv6F40bqugPO3AKzo5NREYU785cAJTYSEj2HSuSqdrb2G8QVuHoXTMExkdk?=
 =?us-ascii?Q?+gFRHcWOgsX3jjKu4ZN5GPcURzdWzgKZh8L/tW4TIsip6SNg10kzE+Y9gNeo?=
 =?us-ascii?Q?GOImrq0Y5hl4DwrwElZtOR8bw8e/vKOWmN1ZM6krNl9AYs6FDneo1HMx3mrN?=
 =?us-ascii?Q?t5SKNancoHKkXcLTXZNJ8OMaG6/PIpSQ1w4c+DdGZW9EJ8zs4chBS6n/ALLc?=
 =?us-ascii?Q?yv/9pulFiRPd7330VK+Gqc5VDTwtuRyYtDAf/DRywIMOU4AutwTZIgMtpGVE?=
 =?us-ascii?Q?xP6zALUTwFPZon9v2dRFAWc+nh5OrccVjPGfxzGefi9VOK6+MGHDdppCp19i?=
 =?us-ascii?Q?cwzTAnYjuVXeu7hDeJqeUQVF+tXruznNEuxw6sEWV/mREZ6p/zTzsfI7uzvJ?=
 =?us-ascii?Q?28DKivUUhNTjwI5NI5Vy8kN35mhZqZ2HFmlq8oSJvoN59xj2sMnVjWsSczqW?=
 =?us-ascii?Q?G5jTAzrrLqfjf8evtiRnJDlOJsbVSpXU7lmZrQR3iexMVhm/WMoTlkPrXEOI?=
 =?us-ascii?Q?1RpTRI+Qa8WIaWPO1490jRsWfuvyGP60zOcYmnejGKTTBWQRFUZ30AZ3dYC0?=
 =?us-ascii?Q?4IFnZ9ZKkd8lnEqJ8B1AMHht/qONo/cVqjyzA+mA+zswv2ilscP2HzmnbCXf?=
 =?us-ascii?Q?P16wgo2ZgS9iVkTJ9cytaM0V73/rzq/1C3wXsN7cR4UD1gZf88Tc2lERhezV?=
 =?us-ascii?Q?DauMJw8Bv0Z+Tx+v1XhW8Gip4tMz+6MHKFXzsMOls5TPtwjuLMo7SuLefoVY?=
 =?us-ascii?Q?MfbvCAa52Ik1aPOEiWfJsBxXemrCqg7JHST2au1K?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14f94106-4bcd-4e88-b50a-08dde0bba947
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 14:04:36.1244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: inGjRMI+uiC/EZYvE4u+Ce9ou7/K1Q05YEaNKooz1hNez6t4YSWc6DgwkIB2zcpN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7006

On 21 Aug 2025, at 9:29, Brendan Jackman wrote:

> There are 3 potential reasons for is_migrate_*() helpers:
>
> 1. They represent higher-level attributes of migratetypes, like
>    is_migrate_movable()
>
> 2. They are ifdef'd, like is_migrate_isolate().
>
> 3. For consistency with an is_migrate_*_page() helper, also like
>    is_migrate_isolate().
>
> It looks like is_migrate_highatomic() was for case 3, but that was
> removed in commit e0932b6c1f94 ("mm: page_alloc: consolidate free page
> accounting").
>
> So remove the indirection and go back to a simple comparison.
>
> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
>  mm/internal.h   | 5 -----
>  mm/page_alloc.c | 2 +-
>  2 files changed, 1 insertion(+), 6 deletions(-)
>

LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>

--
Best Regards,
Yan, Zi

