Return-Path: <linux-kernel+bounces-749521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB19AB14F6C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 16:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F385617BB36
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 14:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D151E51FA;
	Tue, 29 Jul 2025 14:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oAWh7y1c"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36B71C2335
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 14:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753800087; cv=fail; b=f+PEU2quFc9KOm6MNNNr6uYEUNS8tz8FGleGaxOenTddS9vAVSG+vZVyFMbkGe5o5KdJJWZe8W2Syk9FHOkv74MdcZlI8muUX2Vk20VGn/n0+Q+oI4+TmLFJeowCGnBMWIA8B49xIMdHSfaFroBXozHKnpLuIcTX7o+eQfNmNVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753800087; c=relaxed/simple;
	bh=zVRk6MY0E5BdpNkaiialS0jAQLrU+rCRJQXfWtPnORk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=blVnuJiAz5gbJy0aE0lcRmaZ3hSEQg3ltI7tqxMBF1hCH1F5Bky0w8/48mHJBUuAOEE4OqKZlxPgszWk7WDFg9monLo4LyikAn8mQ4sJhn5AhwU+FcVy3+3LXPQvAE5ioD3OAE5jxNz65mZ/fF+u9EIt0BA7zqkgmY72EQADoBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oAWh7y1c; arc=fail smtp.client-ip=40.107.93.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DIKNMxGjmLaUXMORwxxaWl7vgRzEzT4oxvpPyVxme4TCh8UG5jIkqaqRI4f0t5jYZHaZ0JKGZ+9hUbLt99m6rGADbILB5dr0uIwrwdiVL1qG5wSeHBdX+Vtx7vfgmlYBLur6GeG8nvWeRD27fy1Vl8bbzD86B3SU0Gj2V4SaFzkmEZ0YRVH+80eA1yPsoOseZtbcWt5P+MVYr/Kmhk3Q59mT26gTtBakA9lKTygN+P0mxWNUEhQPo9b+KjmwPE5oD1fSE5wLqO79GWcwpSHgSu6GisTTqf7RzA88fhRZ5cor0dYKX8Drxpjs9e3XoOMNHNZZR1rCIJibLZpsK7C05A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kcLN90sal5QDtq4Xk1T4Ib5asaNHBgiFmT4BuztAnFk=;
 b=bljbVASpSjlxRJq98Zk+zCHmAsjxinazrEVVc6XdAx4nA6BOkMuWhl2EAbIurREFFXbf5LwB8k2zjTPtRQwT9LfrNCOdmtHRCDCjiOIFUELxMxCkUBPW9ja/gNSdqUOw/dMH3jgzBFxH9Y3VjvYvFRIeiZqL4A/g1oW2TA6/2tQ9ousiauzt1dq+VDhCFKrn1dQuhhTS2w+fX8Ntl7upOBELDdD9ei0BsKEuQr7kJ3Gj7fi3dj/coEm9nBVupiNu3sUkZRvipisjGTixehHcbT5icJvpuDRnKIIwMlhCm4Gbnab6u9GFlS16jSys+Db8JlfsERyuFPKjWfEac5/nSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kcLN90sal5QDtq4Xk1T4Ib5asaNHBgiFmT4BuztAnFk=;
 b=oAWh7y1cAQKynZ2VSrv2uqAnm37Nh93yY6UUGcWm8OKohpe0ZPk+cPEB3grKWETy53WVjcr8Ri9Zj7okQyOeLkVbBuvDfBWkokLRBztybcr3fP6XsVVd6MFhreEizE4ugosGSV67u0Ha27MDpaMiDQoF5yo4xzQwAOE91iUzkXCb5ngbOwgzCJdZcYnVeuuzs27uwE3XFfew/xmzye4GSRJyss4DwzplavUSkei8GwMX+8Vtwmqvk+KmzSTHEcbSVl6vj5rnK2WSBAC5vf75qXjv5s7B7tcvp9wg14ugAhsYai/42+AQszLpo5CZG210GZIhuUtY0gEUzwd72W2AoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL4PR12MB9478.namprd12.prod.outlook.com (2603:10b6:208:58e::9)
 by PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Tue, 29 Jul
 2025 14:41:22 +0000
Received: from BL4PR12MB9478.namprd12.prod.outlook.com
 ([fe80::b90:212f:996:6eb9]) by BL4PR12MB9478.namprd12.prod.outlook.com
 ([fe80::b90:212f:996:6eb9%4]) with mapi id 15.20.8964.026; Tue, 29 Jul 2025
 14:41:21 +0000
From: Zi Yan <ziy@nvidia.com>
To: Dev Jain <dev.jain@arm.com>
Cc: akpm@linux-foundation.org, david@redhat.com,
 baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 baohua@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] khugepaged: Optimize collapse_pte_mapped_thp() by
 PTE batching
Date: Tue, 29 Jul 2025 10:41:16 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <87D756B5-3D64-4CC9-BDCE-9FC9DC04B8BC@nvidia.com>
In-Reply-To: <20250724052301.23844-4-dev.jain@arm.com>
References: <20250724052301.23844-1-dev.jain@arm.com>
 <20250724052301.23844-4-dev.jain@arm.com>
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0202.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::27) To BL4PR12MB9478.namprd12.prod.outlook.com
 (2603:10b6:208:58e::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9478:EE_|PH0PR12MB7982:EE_
X-MS-Office365-Filtering-Correlation-Id: 932673dd-71e9-476e-27bb-08ddceadfc84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uBccsb+Lw0jeV1Sj5GzzePglVkLQcSiOPVjZ3tJrB6ryYnyIzidg4+ujdtXx?=
 =?us-ascii?Q?KYExELiOE7fSnWZP+LKoXXyIzyxO4E49A6miSAuN7Q2KWTFvNw+LnyJO0y3L?=
 =?us-ascii?Q?m/F1qdn8gIbpZUQrFvBtQA386b7bdy6JaL6nPV5tvQj2TLV9a+cLKoYE2lZX?=
 =?us-ascii?Q?BGibq7acQuVMlR87JiSPbIZr0+EUDztgtEhwgUt5+O1TZ2uKfsxdYZ+5agVO?=
 =?us-ascii?Q?lzU5IPX7uUqgnraWRYH+K11wIVNJwITBfJ+4LFNB06vaR+9g2HkTNgEL4xGJ?=
 =?us-ascii?Q?7Vn0oMRzk2QwkRGYDoNz6270iOFDLD4Rwr3AnTgBqRGbhAq2XY0suWB8AfgX?=
 =?us-ascii?Q?8tMSRAzM5vpMtxOzi7MDLscYQ74usr4S+5RIYeFUqlpsGYhZeVzCwL842+PM?=
 =?us-ascii?Q?Ft2sgQr+Q0A3xU4xmUgL6uLTbnF20k9dyeHKpp7IS8FSS3iwOFGuGc7hcUKa?=
 =?us-ascii?Q?VGx7ZWLAqcHFkdgq5Hj6k+xUQ7oZ75syUfspL0WUh3vN5Fpl11xTcKGqwDOB?=
 =?us-ascii?Q?cRWQKnzOITKQvZbiKg24SdZJg5NoiVw19Yv7M4QhOLiLVH4K9FwNgc9Bs8OH?=
 =?us-ascii?Q?1XFpCFAv6SWK6ql04MfH8drEAlzVI6HoLE+YDYNT36DyBWX2f79kIALYlF29?=
 =?us-ascii?Q?7eixEP0IV6bgWJfaiFPq6Ng6KqnWwhHRZv+2Na/x6ZNIPVxGvfYnMwgeL69n?=
 =?us-ascii?Q?56ke4yRwOcC65A0ydoVejA2inYYD8sZA2wHuSBDKn7D+kR7fkOhtFg3UXJRj?=
 =?us-ascii?Q?vAjUJmuHOyStklCW0SiUYxqBu8srJqo1N8uMePfiYbssyhRJ5dgkRO4R0FjC?=
 =?us-ascii?Q?tVzuHl6REfcxggW7sUNnKz4P5Xj86qTmaO7aEwZNe6IA0iacer/xOAO5M+Re?=
 =?us-ascii?Q?LEbzOFMJUwRw/rnRAn84cBXtom1XmcuqMGpNGXyC5k7l0PLIEiTVUFDy2X4m?=
 =?us-ascii?Q?kL1l+z24S72DrkLlnMonhWHnwvAa3+tSoW5n0ToBZBIpjpfqOcKBxS/w1INI?=
 =?us-ascii?Q?id30tlBdSCmZW8MYwDFzFr6u1ukWprnDSvE1wuu15icTrJATBF1KSushCnYN?=
 =?us-ascii?Q?/IIs2HLhZouaRkLnmB9b2mEDbGrggqciNc975a8x7Gsio5hfQst+K+jWgSrb?=
 =?us-ascii?Q?3LLAfdMMO17zfN70ehEzJEXv+d/OzGR72jHZqAuX6bgFVKymlPV4oZVL41Dl?=
 =?us-ascii?Q?xXOPdIVjJxUQPYCKUA0uVK8yhMpHJW8Oe9Mvb0bcnq0e/PIcmWEnMxD8ryWu?=
 =?us-ascii?Q?ALA0UBO9bY9PWuxbyrgYeHMUBCoAhehzRn56wYAwFBUh23m+8l1rjVnR2i7o?=
 =?us-ascii?Q?de/jTh2wRpr+8pl6pjtDyQm+a6R/wqzI3PUfh5okMZHROHSmGMwGQIvz0w/6?=
 =?us-ascii?Q?WQJcvCkBcVXDMnTew2NIkxm3LgLFXaHTFhYaevNzjE3fxJgBMc9Kj35VC2hv?=
 =?us-ascii?Q?19Sjc+PcUzA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9478.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f8nAJ58Ys9mQuDbeHcmtFO2CIEZeTEkofzW5AQNZZ1ZsZkSYTBInFlRX/xVd?=
 =?us-ascii?Q?jgfieThC9VZpESoHRI34vItojeAYPTzOqdmUi8awLKJ18i31x8I6LqSKKZrC?=
 =?us-ascii?Q?FkKEPVi2KeRUhYhbm3/Gle9T2Eiv9M+3xTdU9JJ3ajErjGphurlr0gtkUz5k?=
 =?us-ascii?Q?JzjHlLQ8yqEQE6jxTiiI49NV3/1QEmIrwhf1xeY6Dd5LSQRnfnVn1Kcm1xDy?=
 =?us-ascii?Q?MUIAjpErHC9ngh0Pk0AfkJgs4wX48uo0g692pwlHU6TmpZuUb7wFvfaQrHvB?=
 =?us-ascii?Q?O2LfKket9Dyn2WkWTcsAAJ7muxvmrcsZNPvFhZqUd/ChfmCDNBhHeqr1m9Js?=
 =?us-ascii?Q?XZz2YzBctsulzWXAFcidZTuvPle3U+Sx+utnFxx0DuZpNTUFynsRp3Td/PXW?=
 =?us-ascii?Q?UpuZgcKBHjC7Owrs9VI52T2Z8Yfe1n0T2deQ6Ct6twi0YTlrEh4qxTxdPlTC?=
 =?us-ascii?Q?3ERQwHDWRRWjEBFsol/S+WeR1cZBLkyRLNPCyKkCitlBX2aJufObId9HZnq/?=
 =?us-ascii?Q?gaCfKNo6ZKCKum4rleUR24BLJ8enBfbPvCns8BJnhHxA42Mr//qvvHOFejgV?=
 =?us-ascii?Q?zY57N7dMmeMSWpk0tgKuP/5ZEmRFMO8vuUuyVUIyylommzciNTYwsvpUPH3D?=
 =?us-ascii?Q?VkUQreHbdsnJB3rBom2Y//p0LEmh8bI7tDh289X7nGcnokZTMR/WiLbRxWTf?=
 =?us-ascii?Q?EYgNiltsTEjS3pKikBG8BwACt3FjJBxdZ3Tai8cQssdoWN6bf5oYP5S3ERxA?=
 =?us-ascii?Q?qfswLBpumbfOsfUeia+uQOWSigX0eXBFuxlHcEqCZ241gGQBZYdnXtaIHF9/?=
 =?us-ascii?Q?jVVWPrR0PLzguBbqYvKOkB6d4+xJ/0la5T+FqWuiXbcbhP8y1mcaNAl1xMj7?=
 =?us-ascii?Q?1N3oeAK3AwZXDlwHUHVdrM0qVPIdDQLSQHyr/YLp6dhOYJgP6FqKmLm2UHwi?=
 =?us-ascii?Q?zUn4K+PDJe+BhV1T/eQ9H+gkC31/k+QftwajATcd2FJcuhyMAR70lngxsdTe?=
 =?us-ascii?Q?jqskSVR+FyhnXNEvBf+YyFP9lORMRDHck7vHmEl9Rx4BvkmnetSaLnavOT75?=
 =?us-ascii?Q?vKEzunknS9UHO6QvZYFUJEMzk30s3zwsooLiEjUC9dEomFTMeR6ihloNOxQe?=
 =?us-ascii?Q?+3Wu6S2T7+gKm5flCe527Fqto4+XTdaBRLyTW2EqYOZRCKmZoF36pmSnP9rT?=
 =?us-ascii?Q?9gTHN0u10VZVpMlh2UvJvzzghfsQPwVBmBQAO1CMuDziMA9vcRD+vYIWCXVi?=
 =?us-ascii?Q?GipY9ydfxvWjoEqyG8vdHNSkKSPma3ol6mAc+eGCBc+BfQqb9+nmNc0TKJRD?=
 =?us-ascii?Q?8AdipKsvmcVlSNywYp/08K8n6THAF0tJG95xXvVfYS8baRA07vYd/ZyhKqxa?=
 =?us-ascii?Q?pGxuVMR3PdSQGymyOQVgC7/4ci+plk6nDkh6lwjrb/3g4JioR4kSqsG6ZFzs?=
 =?us-ascii?Q?OikNnHnahkK4AHXqPLKGE+SuTjuPNIZ170po3S5ltTEROQB1klzm2H6vDXAJ?=
 =?us-ascii?Q?TXKYY6Ih7dPl9YDjhO/H833TGZA+1wXxxezG93qBUgxa5HczmY2EdOXS/lLy?=
 =?us-ascii?Q?DhykjYHsXP1RC636vH4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 932673dd-71e9-476e-27bb-08ddceadfc84
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9478.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 14:41:21.8826
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4VeO2R00A33Ql5gcHiITOExXpaBto2yJ5qXKCUiss1xiuD7PG2sm1AwFo0/gvGdc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7982

On 24 Jul 2025, at 1:23, Dev Jain wrote:

> Use PTE batching to batch process PTEs mapping the same large folio. An
> improvement is expected due to batching mapcount manipulation on the
> folios, and for arm64 which supports contig mappings, the number of
> TLB flushes is also reduced.
>
> Note that we do not need to make a change to the check
> "if (folio_page(folio, i) != page)"; if i'th page of the folio is equal
> to the first page of our batch, then i + 1, .... i + nr_batch_ptes - 1
> pages of the folio will be equal to the corresponding pages of our
> batch mapping consecutive pages.
>
> Acked-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---
>  mm/khugepaged.c | 33 +++++++++++++++++++++------------
>  1 file changed, 21 insertions(+), 12 deletions(-)
>
Reviewed-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi

