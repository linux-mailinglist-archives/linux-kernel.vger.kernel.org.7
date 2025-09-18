Return-Path: <linux-kernel+bounces-799009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5AC1B425CA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 17:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90AC83AF6D9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09841286419;
	Wed,  3 Sep 2025 15:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QN3JxMwo"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E1A1FA272
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 15:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756914452; cv=fail; b=BzVFbNiiI+n8r9rixVQ35vv0nTH6+PN84E9+75wEKxPYQDBl7G35pow3eXwHRaL+tmjTawQXanQOkOBbjcMmSJSuTLR0EjZodLawcb09yEZBivt5hYL4czWNCFTJtI9TBwXegLDRQzIRsiZww+4BBwp9MRgah0qAgy6/q1VkEV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756914452; c=relaxed/simple;
	bh=yTV5Tt5ZfgAWyb6dhoSc+fbsnMv7RByoWwD6gY/GG3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QNilk3S8SAcTbuloLVqH0vLriMoq+ITtTSl/FPOC/uONc+HGfWgPzU6NU+nWoSCSAuuuH6gTBOWnfMFVd2cWiR7GFHWesN5uaNSDuyU+NW5v15WUjQw6+UUrSI8A+QfkIn2zuSJIrURULz78fGmicBFaTbJF5S8M4omhYq7z35E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QN3JxMwo; arc=fail smtp.client-ip=40.107.220.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xbaJU4ZY43wfIAG/eoX1rqH00ay3vl41EasP4ZEYPLp4YDXBDyds68vBj3/Aa77mp1EYJUgQoPs006vEXeKD7CTlQMgwGBCS77hXDd0Gjuncmt+qU/+P4INW2HivEwgPzN2O4QAy5VDD4wN5nxBEI+aWcH9/yUIUgX0IcZ7+HuF5j4Ql2xuUzXOTb7aJpiaBZekX0GYBBof+lZyl6rQd16pvTbKNduXpkNcwd9Fo5K5e2cDUk/h7pdXbd7y4Vi9yDWI9M6aqNMhRdjLudgP7LOvMmcHdNjAE8f/JPs3PjLbLb1FoFc2xhbqVb6zJ2fBZGBEHXacESqxhl9+VqEo4rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P0L3RIOigInXVvCIQ8BP4Idwwi1dEDAQs6WJ8tdOoAA=;
 b=RBfMy0Ky2wNf6aSs/v2lKkgu3Xf3+qMbM7T8I0KbNjdPcHH0zpo8Hhw5v2LCclygimvaX8QHdtRu7x1wZk3zgM6ZJhUNwJfa7ppKPPAFfjkVYt8SDDuB7WYNNnRqfwNuo3cyVTi17bYzQzZBGAl7lSq4A5ayzD/Yxy34VRDPqz67uD04+4QqMPRdM7jisawOcpfZonuDdEbpkJnbU0mB9tltS6CFLoRziUG+Ysgcreu6Wy1fdfmn/+EnqHijcODF2uKLUZRaZJYnZfuYw8AUBrv9GISD8Nl1Ns90u9GFUQGYBW7i4vyZhrDYBPRvdsw3rCH+SHcZjC8xLLOfLwUbCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P0L3RIOigInXVvCIQ8BP4Idwwi1dEDAQs6WJ8tdOoAA=;
 b=QN3JxMwoPoBIGaZpzhqSqA6j8HbQ3PbDXfFfxcSh6hpnTlRTazh19+x30bCo7a4AjVG0ku+huWte2zcGtSwkZiEp7KOfFVm77Qy/CxfKCawasWIB9VdpxCvH0fkKmxUwJ5imxU7BZSLQKCCmrKE9nWE89NDQFuNp1fA/KpYwf1L/21ELXqnW6FR3cjQ6TSgFHTOIbrJO0+V/Uhxbu4aj8S/my47rCI2lGmZC4WEoC6naB7qSG1vBAaO37jW35uYhNsmAoGCNzHudD3yY7bEJTUS4RwUFczn+Bo3MoU1HkIA4Y7HEgXNoScjDMdPkEtYBHTfcB/BpiHFdrL2keVmR4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 LV8PR12MB9232.namprd12.prod.outlook.com (2603:10b6:408:182::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 15:47:18 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.9094.016; Wed, 3 Sep 2025
 15:47:18 +0000
From: Zi Yan <ziy@nvidia.com>
To: Dev Jain <dev.jain@arm.com>
Cc: akpm@linux-foundation.org, david@redhat.com, kas@kernel.org,
 willy@infradead.org, hughd@google.com, baolin.wang@linux.alibaba.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, baohua@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm: Drop all references of writable and SCAN_PAGE_RO
Date: Wed, 03 Sep 2025 11:47:14 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <EE308B13-E049-443D-8807-049132C34B8C@nvidia.com>
In-Reply-To: <20250903054635.19949-2-dev.jain@arm.com>
References: <20250903054635.19949-1-dev.jain@arm.com>
 <20250903054635.19949-2-dev.jain@arm.com>
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0169.namprd04.prod.outlook.com
 (2603:10b6:408:eb::24) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|LV8PR12MB9232:EE_
X-MS-Office365-Filtering-Correlation-Id: e4f4eed8-1aa4-4edf-f70f-08ddeb0129aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lOmHwUdF5GpVYFTyuCg7yGERw7c1WhwX1GoiuY7XorIyr7FqMT/uoGOvlkBW?=
 =?us-ascii?Q?1mAIJ3goXoorKTi6Dj8IKJKOYkv0qDCAwRX39E9W165/7qonU8k35lx2ct/B?=
 =?us-ascii?Q?U0avtNbgRQPzVqpZyHJItKSIJt/yZViKQgbzthNvGdrudTxOm57AInMI25k6?=
 =?us-ascii?Q?zq0YjFbmlD5Otb4S0/NcfvAwDjaVoPaJeSLCbK/ifJIaqKi1oL1ADc9duSeg?=
 =?us-ascii?Q?aVaH1ZaTgi6ziCv8rMIEW/46BHiNravHKlcMtCpW/ONhMosHJdyr5USluX0l?=
 =?us-ascii?Q?J4Y2uCdob1iNotNeyG2qGQ9bY5G2ybGaHcjtlkAP8rBLiK+5FVFaGtn7IVta?=
 =?us-ascii?Q?C7dwtiquOwHQjim83E8YuxqsjHnlV2LK8ztLWpS0jYNSY7KFb/kOW6dDEwQV?=
 =?us-ascii?Q?O5CMZY0EwbJYJpVgboEtcJ/LpJG1CIB6Wt6QD7/fF7DOCZpXtXL0jOiPtYuH?=
 =?us-ascii?Q?p72Wk/KJ6INe4k8Vcqgm6r9CeroWJlcWAJEPDNesEWsry82AfQ4YOWBggL4N?=
 =?us-ascii?Q?ifN9B5lsIhD0dyyYFgYaQAxlL70LalK/J9nJaSLNFwpoq+AoGoDOFGDrmfYf?=
 =?us-ascii?Q?QwN1RO3dnru8GTaLnTa4M3/QzI6iYtzU86DpY9x0HW0Lf+ycjd9l1ssWNMKc?=
 =?us-ascii?Q?UhNdLYqEfXWSyoEJ/sT5ECwq6/wvR07/9JgvPtRThJ3Y8fA8y3ivFL7oAljt?=
 =?us-ascii?Q?mLGVgvXh9lM2vQKBEL/gq9kxfF5LGCtuz/8Vm291cJm1yKmo+Al+zMtsarP8?=
 =?us-ascii?Q?vYieCt+Rg+Nj4FDpA+lFZ6Lcia8NyZsgkj33C0JEMhGPfpJ/km4GK2dPbbU2?=
 =?us-ascii?Q?PIlbRYvppw6GulhWzOEw7LnuhX4/R8YFPCenqGaCKiw5KlImf84r2wYO7QzZ?=
 =?us-ascii?Q?Ib716WgYyLw/aIub8wxB3NogiNbXYi7l3MMKbfiHNR6CLrMN1hyvyymGxZGZ?=
 =?us-ascii?Q?OykZ6wb/9GyllXj+pN1YjKY4RgGRzoDrN4RK6fWDotIy+ibpCMuUe/RKIZ7I?=
 =?us-ascii?Q?Ngdk/3nrtX6jwOx/9DllnzEVpFU+s05AmigFU4fNiBUuK9HiOJLvjCp8PqaY?=
 =?us-ascii?Q?0BNm2/qgJnfZlGG9ju9+aYOjfkt8cQGyGN3Wy96WvZlEdCnbgYz/yPrtIvlB?=
 =?us-ascii?Q?gV3m46VFOM5QMGZQDypqgwUkVvU2FR0fwVcliOp8XcRawEzpFegey04zYuHi?=
 =?us-ascii?Q?PdK+ZV1ncZ8dxts02i4xlLvc+OrllVsL4PTybfMy+vVp9DRgXQU5DLuzHwrG?=
 =?us-ascii?Q?m/bsLy8u27+bqdXVMGNUEC9CEemF0rI8EjaDrNk+x8O+B1IYj/N8/Op7cybM?=
 =?us-ascii?Q?7nOOk14KpUPQlryUxS3G+vhKxxYeFkYfoaqOQzgptj+pS6kCJJOShoB5K0BB?=
 =?us-ascii?Q?+NquM+0GwAyUwiwggBDzKuP1cZTlsoHwcmYahnuZ5wWpoDnLc/GGmL6j21RT?=
 =?us-ascii?Q?mXWrBBvxGdk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zB+ISWdgPsaaTT+RTyUfMwKfbM/+VbXAb800bJBVsefpSCgi2gZ3T1PyvBMg?=
 =?us-ascii?Q?w9wdd3fc3aaqY/OMjGhUJfQDU/b8tsZQnQPRcNjcP39jmt7baid4vGZjvGHM?=
 =?us-ascii?Q?HEgs1LnRcDYZGzV3gyfkpU2ya0/Lf6Dyf3ZvJl81tz12AkN5taj50Y+v5KJ3?=
 =?us-ascii?Q?QCozxuTBl/M1lbZInKktonA5FftTD8JG8iRlk1xH7QFYEF5OP83YasSVbkkq?=
 =?us-ascii?Q?r8G0OljWjfN4FesC6aEkmG3JZ+sVDcJRhlqcOaYSkhttDfKtpMyyUodeCnn2?=
 =?us-ascii?Q?vXdScxsrZV4NnopmkfaI2bNu/MyFMAnvUF8zVF8VS9VYIysq9KDnW5YANRuz?=
 =?us-ascii?Q?/N8/3XgG35UpZnXYUPzPmzVMVupNtLuubwsAfeTovR+ZwsU4lt81bN+8zl9e?=
 =?us-ascii?Q?ml1qE2Ztw021vHK7pbvdQVppEdmzw7Pbpx1Blz+36EMaJsk6oZom8M/VOOQA?=
 =?us-ascii?Q?h3oVeMjjcDNp6UZFMHeKqHoRZ66hd9nWabLYk0Ix2nYWDXDyodanWfpztDzT?=
 =?us-ascii?Q?RKy67GeDY9IqKWSM6zUQT8M6NDsicdLpfKfT1xjSrgSo//st9geM/HdOiayR?=
 =?us-ascii?Q?54Rth3hQWg4i5nd59hLnbEzhucq2L3En3Dy/3tQpzTIJQbh3BN0qtVjq3KVo?=
 =?us-ascii?Q?YAWxOylAB186Q0xXPtshO+/o4lF5kLXlph9bpEXytEtq32C5848joG4QOiCO?=
 =?us-ascii?Q?jgPFztK077lJnVclN8mWLRWkrTBmHZGW5r0+eUSKl/bdlFOGPHSEay/10yXz?=
 =?us-ascii?Q?cwhT6+4FUPwPvX8XJX0OE6UjX8MzSaKRuXEppTBlgSSx2Qn0BD59lcZd9oQ1?=
 =?us-ascii?Q?7ATcY0Cw0Rw3EXI45gbvrBy92YmdHSokCJGgMZ2zUBZOD9iR7BjqJ72bpau1?=
 =?us-ascii?Q?jEUdfj1UF7dQZLV+aDhgUiAhHSO7bh8imZ9NPZxvQJUij+Asj3SC2rz5Jt1p?=
 =?us-ascii?Q?3wRMOrl8qtcjmNkHt+SBsRkB47rv871JlwE9DQRDxqHBh6e9+Vlbvgi+Wa5b?=
 =?us-ascii?Q?U8w0kulRdlbuxrtnslp96nFdT1vv3cNsWz3fsfADhuFDwtviz/d8qLRAEbsJ?=
 =?us-ascii?Q?KP4uYvwegQ7mesHpOc0bCZmJNWuKfTULtoeUhtjeVWTK3WyL47b683X9xt/F?=
 =?us-ascii?Q?HFm/QWfT2LxpTjgQJJ1ELnBQElXt2KhOijZ1CC1N3sU8IjOIWZXfG6SPZcco?=
 =?us-ascii?Q?P+Mb6wACXtEWa3OeC0LqqTjTs6NL/60amkivZRKlIJkHSqQFVuQgZ2r60/G/?=
 =?us-ascii?Q?m+oN6jjzSiXtpHy4VgY9iZyyZI0hTOsI8qmzzHVOebA6CTvVQLL6oFaM6/k5?=
 =?us-ascii?Q?H6oacwdt/Hq27CiBNszAOJWS/n1p1JbZ11W7YWJPZ2rGiCIm9O4Tgrw2HHKO?=
 =?us-ascii?Q?ZemlQOQacNcgT1ppJ9IPiAuGEAd/OAhSlQly5EX1pz+GG1XBQaK08Mvic77/?=
 =?us-ascii?Q?qEW1ohw5eizHCX74dJzsqVfl7it32aG5xBYpnD6D0k7MkK36nVDFABI5A3pm?=
 =?us-ascii?Q?3dDchC9LBGvLC751/hzqOJ/27xvTqnRYnNQXxw5HwXHq96kPhUVcpTIVa2TC?=
 =?us-ascii?Q?P5G5gubeRZJ5oslFdodxrVpg0Wyjjh4wr9xWBJ5W?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4f4eed8-1aa4-4edf-f70f-08ddeb0129aa
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 15:47:18.4180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mf+bk+RCf90lfdKBzADN//0SP4MOY9dk+K/Q2bkzjfUsHWwi8QP21xGCbC3+fGJY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9232

On 3 Sep 2025, at 1:46, Dev Jain wrote:

> Now that all actionable outcomes from checking pte_write() are gone,
> drop the related references.
>
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---
>  include/trace/events/huge_memory.h | 19 ++++++-------------
>  mm/khugepaged.c                    | 14 +++-----------
>  2 files changed, 9 insertions(+), 24 deletions(-)
>

Acked-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi

