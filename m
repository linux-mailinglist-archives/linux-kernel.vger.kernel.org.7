Return-Path: <linux-kernel+bounces-787511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 355D4B3774D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 03:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8EBA7A6422
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 01:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA90C1E51EC;
	Wed, 27 Aug 2025 01:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CBLssEVc"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E681D63F5
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 01:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756258984; cv=fail; b=e/lbrN5srO4NZO5zanseKqUqp8uJm97om8SkwChQSaOv9DrXPJs0yeVbPB0EPc76xGzJIlduq+fRJalsBvurzRNR0zERE+WBtl575z2f1JBKc+oC1yQ2PuQi0qvyXhu5n2nO3i9D13Gzf7rZfLerJMvisGMJPllmChLhTEntIGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756258984; c=relaxed/simple;
	bh=7UFPOatTfKz4o8A1D7LtNj/cYeIM0PqVCM+92GDkNQo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jHq778iIuXBI1nnr2HlH6ikxJWBqJ2DzWhQWd3V0YVj3avZctCA2Bo5ZT+lZlNhXTUINJkAZEvjuoadPXeGui5h9wRMhnh0JEo3R/tQ7D81e/dT9Es/NBQBfLhs0jAHnuscMuQdmlmZ2wyJHaI0ln1OxhDtPXahT6AvKnHHFgJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CBLssEVc; arc=fail smtp.client-ip=40.107.220.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y2LppdDqjtpu/XD2HMwD/cB6b7N1LKum+LWLggxJlJcmPh3ztv5f8Ge/rbrzX2IY3oWSeghn861TdolKrrDLqccVLnv9ozvsCaAmoqS0PW5qnU/Pm8JT7lVAYwr8tMYN/TCDufOtvNtz0cZ2nC0Tlk+bZ1CQrkw9FQWSWmbSfivumLJMjPVJLjPcRGXGkEgjQZKPbIIadgLVF0LHIBrtRbrz4TaQOeK2jHNSenqBNgA4nEMiQlQ5MkCwS0w5yzUjIdGFHlRrPRSvS/UNaMyL78OWACeky5ejWSTWriTFy9yUh9bdRX6s/Ig22h0rZTQeOfMo1fJQ8ZfCbI41rGTIiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hf9uzvMnGBBRhveWpqmnyt8zWtjJbxZuByT5Xmwvjdo=;
 b=ssOYWR9vaGVm6wD27YppJhv+kxJby9VkfUfb/X5Y0fG2PSyDPKoU74idoOx5JtqtsaYrJEUvf+sbMf3OBMJy/J7pBFGEutxU31ehMChMb5bPnh1bd5fOQKmDKvBj24K1N0pTbCvWiievqr7g2aDoJVmdfjLeBEjcrcQFB5K6U1LCavXDjDQdfS+e45qvHUNQpgTjZZ0lT7YZlpehcQ8KUOz9YH6OY8G3YPabSSDjSmSvzeVfgwyXrta/vdLiiOawS6nAaYvwQcIgFEodkknf6UC9euMWzirU+zMGn3tar7lnw2CUq+Vjb3vQrCHrCAEvLhZIxSmCdcc0QV6Io8aJCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hf9uzvMnGBBRhveWpqmnyt8zWtjJbxZuByT5Xmwvjdo=;
 b=CBLssEVcRL0GOC7NZI+w3nd0doa1pNX8jSkLq2LR9dbf4w/kXBT3a0ffK9I9Akr/zMSA7DaR47mbXI9abUX7+Yj5Gc5bD3s6+gW3A+nsBmPOHCVAAx/S1V1VDVkUVghnRX9IvHzG5ywaWgye3VCVNSAEPOqk8sQ0xvAA1B5nn62bPlsEemoFLxNbDol2R0SzWnvJiuQa64c2/ESjpFJErOeY0V/DsP1G58at5lPzWNDpQaAbfUUTEJIdmU0KIZak7FMkn9D3FwXCyfFtxuu9cN/xQMtUrli5ArTHuVk/4mWJ903CzOsZ4YYslEwwCnranjKMve+m8MwmDilOce/zqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 IA0PR12MB8748.namprd12.prod.outlook.com (2603:10b6:208:482::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Wed, 27 Aug
 2025 01:42:59 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 01:42:59 +0000
From: Zi Yan <ziy@nvidia.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
 shikemeng@huaweicloud.com, kasong@tencent.com, nphamcs@gmail.com,
 bhe@redhat.com, chrisl@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm/swap: add BUG_ON(folio==NULL) to folios_put_refs()
Date: Tue, 26 Aug 2025 21:42:56 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <BA16C3BF-C843-4976-8FCC-159324B2E477@nvidia.com>
In-Reply-To: <20250826231626.218675-2-max.kellermann@ionos.com>
References: <20250826231626.218675-1-max.kellermann@ionos.com>
 <20250826231626.218675-2-max.kellermann@ionos.com>
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0519.namprd03.prod.outlook.com
 (2603:10b6:408:131::14) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|IA0PR12MB8748:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a35b73e-829d-4cdc-ae5c-08dde50b0de6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AC2yFEfISXUn5+E5NQiYYOyZ/yC77rUOIfD/5NF58qPxVM0DxQNuTF0EPz5B?=
 =?us-ascii?Q?iJioUEGYTX6PWmdFvY4lBgJxzPxebXQA0tsn2bQvVQf/DIjj7aUAkX3Glnv1?=
 =?us-ascii?Q?/TliEwxcw5+9ezjh35bqt46urWXLuH9Dl7uSTevxGZzOc3p3xvycckKyuGYH?=
 =?us-ascii?Q?I4Q22TvNa2CTT1TcNG4uwx3AsDehz4RwBISotiIo+Jmvo2+obsoDm4L/r13M?=
 =?us-ascii?Q?GjdTQWC+xLdy8RTwz/P8MWVP8NE5EzyesN1YM+FmiO9X6u7/hIGj5zwGU3KE?=
 =?us-ascii?Q?76P8rHnyjPsf9ExPNLURtEG/6LrLGce0PcIvsSMBQ5J6szoI6psu3yAlHCxf?=
 =?us-ascii?Q?3NWo8V4heN5Hy4NQoxxQ3ODZe7HEFHxHHL++VyTCsyv7kdQWTRG7CLFk6mpQ?=
 =?us-ascii?Q?eM2p3kq9+BlmYMaaCEF4XYcMNL+5k9OH/ojUVPxqE6FOLxBPHiweAbovSVI2?=
 =?us-ascii?Q?ryykNHnI5L8dw0fUt7/oj9L/HJvJP4L6iDNrEFSBHq8BmzWRtjQ9Vj2EWWTD?=
 =?us-ascii?Q?Xtejeq1T7b6QIPymyavuMmY7sMNFW6Ch7kN1ehshehpRsm6BDv4FB30bXDYH?=
 =?us-ascii?Q?WwtUKLHebnMQXV4Awq8S2XV1JgUTzuQU03Kcj/A/NtcJGL1YmvO9FQPVAZfs?=
 =?us-ascii?Q?Vq5n4MnYd084Z+inIYk3N7eVUEEhkuibYfOPA1qCYwuCgsVYzdgHjzWetRB+?=
 =?us-ascii?Q?4KKZKSyl58lijtzbXsag3b1pnH6Ily3X1tfyI029HpqzrUFwihc7nt6SQR2N?=
 =?us-ascii?Q?q/NuKPMZYILDxlNjWX42tHBaC/Cs/HpPmTOS5hrvN9IX3QVlYZsnhxy2WQMw?=
 =?us-ascii?Q?4M75VZaT7pVIEIKVoWTAPYiBBawn8U2W57WbXmMgUGegOxB56EMMzITW9kt3?=
 =?us-ascii?Q?vKFOd8hZYBh9PUvG14NxiUCz+ueJOp9pVPmxeKrCYDkBUsKwKF0ORoakT80c?=
 =?us-ascii?Q?CFNVFEtqXMbGyaopqBDYnEgOEbprW/Eo+LcjayevoPK1V+7TUfsszDxvmnNl?=
 =?us-ascii?Q?jnT3hIT84KDj30LpUva8wi2+/oNSOFz7tdLk3DCa1NfCPPrErU5xVqNkPo6J?=
 =?us-ascii?Q?tpNGWXxDiV7y91At0cM+BtWLWwB2rkFVFf+RMKegwzq88sTXY46MW2Ar5z0r?=
 =?us-ascii?Q?b0u8L87jdAOQMXXU9lvtfv3EK0F90lmF/edIuzvXBTiOeXLFn3ZPyf+wQMAf?=
 =?us-ascii?Q?DZXL/DQdfpRVO2gsqSDTHiRCY4qOqxgd8+4b3JynyuyAreyhR7UwWRjuH2UI?=
 =?us-ascii?Q?OkuKOEs1cSRuG4ujoHstrmGHtAZPvK9UeBgKZh41kcuqTjBqX8vCeMI3EyVv?=
 =?us-ascii?Q?pwT/dZHTIMlQfbZ7tPVlcANzG95PFQH0xsV+kVFfiZf/uuyM9prSK8j6vc6e?=
 =?us-ascii?Q?Vm/aqTWNcOqOh5Bwx4DCrWN6z4UwbeM1YqkhiSW6wEEUxyps43WinY5v7nQQ?=
 =?us-ascii?Q?xi7hH7FFFz4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GFQEGCUn/juzeS+oecjzyC42he3EdoguIdMJHhX1b9WpL08cdtXIfui6yAku?=
 =?us-ascii?Q?1uG9zpkc4lUNRP7oPrznkvwPij+dKOnq0PKk1u+E12YZVgeA4+HCGn1Oofba?=
 =?us-ascii?Q?KQYLOmHDhde+epPZAgn7pETHuzNPn/LR86SaOYsXR0xLdaII8dr5DTsslLa3?=
 =?us-ascii?Q?Mb9aBQj4yNaf1kHNpuhIo2B14btVO/wI5zwO+5C/VMBbvVRF6u53J3cDcdwX?=
 =?us-ascii?Q?5im8zQpQbPDqgAfNwTLA9F4VSvpWG2k8doYvj26pDnVJ7Qpmya9b9pWxG2J8?=
 =?us-ascii?Q?huV5H8krdXIk/Skt982ZAHcxqI72W/gbJiGvOg6WAQt9PWYnaC7uw53LfFep?=
 =?us-ascii?Q?hdyLd+p3xeq+yjecp+yiD8o80yu7UHB3Mx3gfsRsR0mOaXq5TJmZMAi2jL2h?=
 =?us-ascii?Q?tmoCXyOedFCvFWW+yEQn0GUwNApAiVxKBv3TD+UJIjqUrU7SgCKsXbfuhMAU?=
 =?us-ascii?Q?wb9QFInHJ3+ujdXyyN1kmT/dVFaA9GgcQ4X/VVW2D46qq47ZUeaeGrw5WGZe?=
 =?us-ascii?Q?ZggCnIKTMgd8b5a+tXDv2kcMHQu/S8B6BxOZsFJ7T1yY5kXZAXqODQL6YCfb?=
 =?us-ascii?Q?2IUE+APaLdAc2ML1fZ64R6gVYpiQ3HoQj4HVLv3xu7hiN92PnPA+aX8xdlKn?=
 =?us-ascii?Q?utCnSNm8nosU9MLeMDCK/tlZ7j36XhvTIdNIMCTTM6wP09XekY7Cim4IKVEd?=
 =?us-ascii?Q?C+S9MaXs5BncEMc3FrGN/kyPjc3t95+Y7TE5aUGJ5ZzDi1fwBtC9mr3ffgkf?=
 =?us-ascii?Q?mVbNWhdqFzfZlCbT4TEKWZZ7uT75oUPhF2UaZGZwKumMsJeUD1mp/b55YnEU?=
 =?us-ascii?Q?8uLjQdw3KEypq4Od9pK0+9qgFqBj9cHAzLCwL6YsWIZ697UCJHOYHFRqxWFw?=
 =?us-ascii?Q?kGLu+iPNCUkkN8l4TrnZJIbVu0Z5QnheeBJGWusm3YI5vjq14sC4YK/csbrx?=
 =?us-ascii?Q?H3d4tG0LFLC6yvwoCPl10qwNr60VyGT74HzFzhX4mg4hh3vjeMGFKCLGIBbc?=
 =?us-ascii?Q?nmrPrOUOzVmov3h0Q3tnyRY4uHr5PF1mrqFZgXAGYldyjR8GDtDHOFpasVZE?=
 =?us-ascii?Q?OoGplZbaN/xrPW/v8DJgNhF8HZtE0mbW3dEGzUzegLi4uu3bA2moz+UD4R5G?=
 =?us-ascii?Q?+G4bS9pw8TFrlyfXRr9UK28DDuqKdyBMbigqed/Jlkx+6JVIT/4oTtU2xuEJ?=
 =?us-ascii?Q?VKVXUE8C6GL12N9bs1RuoVVODVqmf0+f3gwC+o82Vb+0djENLbCT0jLzC4SC?=
 =?us-ascii?Q?Q8XPj9t+ew8Vpl9vYo5c2tRusO+rj+uIh7Iq8bqY2QhmwiXqsMjd0EIbQVUA?=
 =?us-ascii?Q?dEswH1pGgYkFv49nDPK1dySxqnStby0nHEDnZBWHMKXHARYtL8ZubNKwzcQ2?=
 =?us-ascii?Q?5xWra5PgA45esXLgXJXKl0tn1vNqSHrwphJXZZ+K/WtS8DnQbAq6aGhpcv/1?=
 =?us-ascii?Q?JGLlq6eikEJ7BiC+FnobuzYuFNYXfMbkgYwK/yA8j2pHCS6quCidl1kqrOh1?=
 =?us-ascii?Q?3ZMA3/0U2k0wdf36zzxVelFqpUoQjE2GA1+m5ijIV21lHmKFktKAT/zIcUQ4?=
 =?us-ascii?Q?uWcTJk6xRqfUfFNZgE74rgcsCmMdHKUPYuTiLky+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a35b73e-829d-4cdc-ae5c-08dde50b0de6
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 01:42:59.8339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ljXErer7hNbjB0fZE7tN3y0FiRqEf3kocRDFjk5TIJFagmkwFhIZGDwoclC1JSDZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8748

On 26 Aug 2025, at 19:16, Max Kellermann wrote:

> It is not legal to have NULL pointers in a folio_batch.
>
> However, the Ceph code does exactly this, and a refactoring patch gone
> wrong has exposed this to folios_put_refs(), see
> https://lore.kernel.org/ceph-devel/aK4v548CId5GIKG1@swift.blarg.de/
>
> I believe this should Oops instead of crashing due to NULL pointer
> reference (guarded by is_huge_zero_folio(), which may silently hide
> the bug).
>
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> ---
>  mm/swap.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/mm/swap.c b/mm/swap.c
> index 3632dd061beb..07ccda00e7ee 100644
> --- a/mm/swap.c
> +++ b/mm/swap.c
> @@ -952,6 +952,7 @@ void folios_put_refs(struct folio_batch *folios, unsigned int *refs)
>  	for (i = 0, j = 0; i < folios->nr; i++) {
>  		struct folio *folio = folios->folios[i];
>  		unsigned int nr_refs = refs ? refs[i] : 1;
> +		BUG_ON(folio == NULL);
>
>  		if (is_huge_zero_folio(folio))
>  			continue;

We are moving away from BUG_ON. It is better to use WARN_ON_ONCE and skip
NULL values:

if (WARN_ON_ONCE(!folio))
	continue;


--
Best Regards,
Yan, Zi

