Return-Path: <linux-kernel+bounces-836469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D11D5BA9C6A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 17:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C42B16F017
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 15:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1186930B511;
	Mon, 29 Sep 2025 15:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lj6pInSp"
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011038.outbound.protection.outlook.com [40.107.208.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22D43090C9
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 15:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759159181; cv=fail; b=JwJ/iWJKxU77QL6XgDf4KOvEf4WPxS+1QeRn37iW3Gg45+MlKNEqEyFTNv2TbDMigMN81wecQnecpCoZKssa78b6/zB11jhkF3W9ggK3+LM2QB/B5JCtGtOiiL9HqOT8IpCpYZcPACtoTiupEfAdGgQRzCiOasYLTQY3mMSwVVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759159181; c=relaxed/simple;
	bh=AkW9Q/oecBwcpc05iQF48KJBkS2r5WvMVmKgle2sKgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lLLDm9SYw7PRz3Be1tDGrOsB9Ha6jcvjHGb0X/xyLqUV42Kst+tRQJwSLlOVY7atTNtCraCi+4Gos+jx+xiluT1lEpu46rJ6Lvf3MAozyN3odtrWCbKixBWYlcqM0nEhjbAtuZDxpjnkIQLRIq6fFXhOKeumw5fpjbe0LQH9e0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lj6pInSp; arc=fail smtp.client-ip=40.107.208.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vp8v+lQMMtcY8Julvs4HNvcEqhv1OABvmAERbpnNW8Ah0k2syTnjVat8rLGpZ8MqDOJqvH8HPo4WHAcOz4NYxzYA59NSgnMDHUGH/m7Dg4NtSOPwgU3SllTCnHA4DQVILUQbdPingsB78VIYskVRuj9h703c5E4vLHXimEMwWvl8mQBqwwxzOZaU3X9SZga/QJ+r3P6em5mzQ47SWt2+OYs4Y0hNiGiNNqzKnrHguEy6cl6R7LhMqTT+lEs4FLo7MGWp6atPmJae7TAYyIu+OBFbS9RxD5eU0B6XMk/9/gKfFOSMaR3CNaDeIdcoqvls0Qt3w/2KjGfdlwINSopJBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ycvlcv0f++1J6FnOCBxziW/v/y8Q47j5L6dIIaLkKRo=;
 b=ZNS9Y0cX7CcsSX2Af2Ifvc3KNWlstSgnOcG2+FqY935QA0OgmAfjGXy7eRBuBCUr2Daj1qLG7VWqC5cDAmlcUl8iGGv5DIbJ6raNCm621pHX07iMCwS+cZof7yN/8JdpfGuT+MuZ0wIwBEE8+O7PYNJLT0rFY/znzp7BFR39wTpwWEQSXJd6tVHA2NFQVE55VQH0KCkil7kooeXy5rU9JgECnUvpLz8+1rtdy5Ym62gP5Hi/X37nLQtyeVka9mDxsqBwH62FZN5WpHTiXgObE5/pxW2aErJTDgzN+CwgSv6FJMlGAckKx3ikEX3U4Oy0/iZDnfz+lkSLxMfwpINsrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ycvlcv0f++1J6FnOCBxziW/v/y8Q47j5L6dIIaLkKRo=;
 b=lj6pInSpnbyO20qPt5c0eLtVZmKhwCZrAwxd5hZrBLesj93R12taQ7o9s3gB82lLBTpYPoIh8tzq/yX4jeWyKxGq9TLot5/54KRPauJbqXud9ev6qWuDfx2ur1ybULqZtDXhV2NdOSQO4j8TE/DSwoGlcUsTPs6TED5692byzs+GdIrc9KE1veQgcO8qPCdNlBKpZBXNtOmRprKRJLM7lXYkhHzMHdJXdTgegobhSsLpRAJJtb3lVfJQyKS7kxGyeWydGariSFdzQKxkSstvm5D1wN4wtFXCesKlH/J6x2vE195y38x69p5PbBN2ZZb3y0GxU3CF8I6PzuitJu95Rw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 PH7PR12MB8123.namprd12.prod.outlook.com (2603:10b6:510:2bb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.16; Mon, 29 Sep
 2025 15:19:32 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9160.015; Mon, 29 Sep 2025
 15:19:31 +0000
From: Zi Yan <ziy@nvidia.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/thp: Drop follow_devmap_pmd() default stub
Date: Mon, 29 Sep 2025 11:19:29 -0400
X-Mailer: MailMate (2.0r6283)
Message-ID: <FE3C99C5-08B2-4D8D-A11F-6492AA67D739@nvidia.com>
In-Reply-To: <20250929104643.1100421-1-anshuman.khandual@arm.com>
References: <20250929104643.1100421-1-anshuman.khandual@arm.com>
Content-Type: text/plain
X-ClientProxiedBy: CH2PR16CA0010.namprd16.prod.outlook.com
 (2603:10b6:610:50::20) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|PH7PR12MB8123:EE_
X-MS-Office365-Filtering-Correlation-Id: ea538d04-e8f8-426a-f5d6-08ddff6b96c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k8ElWqebBAESiVuXFP1lPO6ChQRlOCKzmurG5Ri8TWkL2MjBYZzrP4x06E3h?=
 =?us-ascii?Q?cvvLri/BdhYWL0/xOUrfDFr7CfC8qE4Fr9m5E/P3HphJ27crYkz9reQ5iSjG?=
 =?us-ascii?Q?hiJoW21xCs3bMnZFfbnh+chhbEXriRfLCxaS2bny5fOrykIJSTa21ldi5rez?=
 =?us-ascii?Q?HoLGzE0VetXNnBp6khYwQJp8go+v7LPHBOvOd+znqaQhXwQ/1lNd3gc5r0Do?=
 =?us-ascii?Q?hdIo6Dbs46Kar6tkCg7A697UXjMYycXFt7BeLiq9ThPsKM7NIR8WILYYFH9V?=
 =?us-ascii?Q?61aLm0C/h8K6ZQOyDk9HO2xG4wTa0zo0OZjjiZxuNM8bQkwqE+XUBDvKVihN?=
 =?us-ascii?Q?bW0/tr3pcsbUGIF3JQgiWWGfKLCxoruXWud2Yl4xKzxjYouLOFu9ObKfczeu?=
 =?us-ascii?Q?WFHOKZ0YZzwB7IS1xEesqVyn1xwdMXrTO5GdHPvD1s2UDVk2qejh+6SjRTYc?=
 =?us-ascii?Q?jQyj11nsKwGvjEWfBVfhgqzuJNr8/Pw8JyhCEfu8VJL7yX3smHmGUqukQG5h?=
 =?us-ascii?Q?8dWlzCAKYRqWdd5B4xQDMoAlIgNWM3Vevx4SRVLELHaCsle/Ol97v6tl+Sth?=
 =?us-ascii?Q?+tDy1a5QCw6VqlnPNQOyierjrq1l5/xG/ZLq5ohnwM/Lcf4ZJ2DDXNZr8UnR?=
 =?us-ascii?Q?ec2iu0wfWCvY/jljxryGLeTo5Qs+9/AeRwxLCzaQLUL0QVhqX5cbXWIMy7NA?=
 =?us-ascii?Q?Krb5mpO0km8iDAyYht29XY6dq+HsCQYEgxJODOm2iGrOWuvtsoJ87wSM23MV?=
 =?us-ascii?Q?J+uSqzC5Ro6Y8IjQSuf++nuKZI3Y/eX/L2hwikmAOKdLrA5sB0MGD64ODxRl?=
 =?us-ascii?Q?CjXsrUitPMAABZBtTdUeXdVWKn4KfkxBBFgoi3uVJ20uuKphrA1Bn0PZZnR/?=
 =?us-ascii?Q?jrdSKirnXIb6uyv5HZdbDO38Cbaay8Gcf7ydYxbeOcZ40dziJaZ6E81wfirB?=
 =?us-ascii?Q?P4rnliMuygOxKtrsGCWMmUpADb/zUVe0FJ6YJZGR7gMKTVhju/zP2ecW/YAK?=
 =?us-ascii?Q?NDedbIMXkS/mg6nwPcYR0Bwb9xxAmKU4+D3RKLJlbctR9MY+IKh0mbjrRgDv?=
 =?us-ascii?Q?7mCaVPqaAw4NGm5a3ceRKWTfuMtBNQPVlSwWCyjS/F6+AolVAQFKGnh/rnZO?=
 =?us-ascii?Q?cE0Fw2XziCarfY234rGdcEKfKQu4AVBJ8/LHDIUA8cG6inP3z3UY4NzaZurK?=
 =?us-ascii?Q?bC8MNswuAH7j4c3D7Gn+6nEvscLsfuGu/OcOTS+3+zMpRQ8S/3GqVCkKHi7k?=
 =?us-ascii?Q?wzKASjEQD4qYpBTWXnTAXXGxiONpcI3QqgSwQcvmuZzZkFxyX4E4ADj8aFF+?=
 =?us-ascii?Q?vBp7tPC7C7lLh6z6rY/CGbvk78vVEfU2xnuxclhQfE2JCYbomb5l8o6cJRm1?=
 =?us-ascii?Q?UBjYQ8aA+f4I0eoQ2QYXgEa/gnzj1SXOxMs9MHzNkz7Zsf0pvoQ7ISxhpUvc?=
 =?us-ascii?Q?pcGjF/HGr3qwQW45R+W4puB8NclW29PL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cCVhLe9pyG+UbLnLkKL+pT+3gTE3qCunYiQQRFgf3u9VCKO7BVSpQB56B6Zq?=
 =?us-ascii?Q?OBgCGUYaDbceInYhWyQauCnTko5qBICxSn/UNaqbYOUO57pS5B8r6EO7n/Hl?=
 =?us-ascii?Q?tGtbH0RG9yFgM3OCYRTlVL0wmlvUhSYBekqSUXgcPfF95i9bprNxvJROqlTL?=
 =?us-ascii?Q?86XHHmOOnXDN7vEzxWukAZdXvqf4+8wYn5dISSe/tRBvy20Metyu2o5dc63G?=
 =?us-ascii?Q?mLzXiWwsI4Wfo7Xue+r0cd5mPLAp7YUQIDXujQdZ17Qvp90JoIRVI+JSsxmq?=
 =?us-ascii?Q?Cz8hqnBmuxSHUYXS6uRQ3alOLxKNOeFl7NoOJBe474hUxZ31NfQNLKuA5X3n?=
 =?us-ascii?Q?dZ5+Tb9EWTKs9ZgR7ywCgy/0l9uGLidYZnSdOtSnPU5mAzgk8SBRLz3ItsWv?=
 =?us-ascii?Q?p8woBKPJWDKnWJv+ZEEfkQqyRdYh8/t1ZFHFILSQeUZTroPWHuYg8V2WeEv6?=
 =?us-ascii?Q?rcnHC506Mt9EkdDufAgZa5vM5on4guF5dZArBXU1gz7UVwIiimX9DpWrrWKx?=
 =?us-ascii?Q?eo7Bo/JYyq3RChytU0gnqD65oZaRvBjsVWL3u18HOzxtznOxbJA0ymLEp3Uw?=
 =?us-ascii?Q?7SpqVd0BWlXosMrON7+EEcmJguLr/zj6TOiI/1NXpvyF3vmTR744TgcvHReX?=
 =?us-ascii?Q?sOMMFSNLgnNO1/yVwmBUOwv7vZwqdr8yMRGa64REXjb1ri6Mk3/sVaWhFj3n?=
 =?us-ascii?Q?BEU1fYU11LhtUKPXwqZ2ODpGv630qgiHazhVtH50P8lEmTwZtNwKj7HUFODX?=
 =?us-ascii?Q?Q427FfwS4tlOKuVwW9teLMPDXZiAUCKbmfMd7+j9RJ6FJEZSPDCb3+s7FRIP?=
 =?us-ascii?Q?AGlDpMWk5lRtZXX6HdlMdvk/A+6foEGcGlzVYpSjZfvFOhGO/NuDHWhDuGSJ?=
 =?us-ascii?Q?tl7Yzz9ix1BiB0k5crIErflf3rAT9vVTsJ3kO6PsYWYqKK5P7CuWz33WB3wu?=
 =?us-ascii?Q?woMYIR1RVm3Ld2jAcmaAu1iamQ3IS+aQ33rWeu/+asK5+9W1Bpww04a1vRJ3?=
 =?us-ascii?Q?iaCmUV2D9faWHj8+I4NX1rY+82IawSQOYjt2D6/K/D/rp8EMZOzDm5QK6FLU?=
 =?us-ascii?Q?ysVr/KHJuk1mODtuZ//TTtLcSUysir+zb2BvCifYimRftAEg4vMcPfTd7bQz?=
 =?us-ascii?Q?5l1tdXXOfKaQ4pboXVBxuKZauet1Qw/XXEW4Bkt4hGXo+c1QHz+JMKYPd8ID?=
 =?us-ascii?Q?DH+K60Q1NwkXUTJVsLB7oZZVHmL8Jyt88pYwRTZvarGF7FDGidiCvbAK6ZUi?=
 =?us-ascii?Q?84AzihkRgCL3VyHDSgcs4Bfz34ZTuQmgUV+DGjoJrh/2PlfOQkAPeWZbDaJ7?=
 =?us-ascii?Q?yB7vxf5HaASp7ePNFfVoDfbB0bU34I42BTSlOZrC2hugy6LkFWZfzF/J6amH?=
 =?us-ascii?Q?9K4ug/ljqrFiGzs50CQOh8BYKUlyTnOHqszAjOfJh6pN8elu8wSw+v1evLpk?=
 =?us-ascii?Q?Kfon/sGtPmMOOPRDq0wAYaJmI0vFQEyG7rzBu5amQc/t6RcRkK3FekueH3t+?=
 =?us-ascii?Q?Gk6c9xNDUgRYAhMqPuzIo29io2timlN0h9bXdCRddhvJL4eQ7Tu3EF8KFs/b?=
 =?us-ascii?Q?iTDiV6DLcRqqWzGGnY/0I/+TceMV2u3usBNF8o9N?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea538d04-e8f8-426a-f5d6-08ddff6b96c6
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 15:19:31.4320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fv2KyYkmrwCOCdCa0Y1AS918H0Twp7OxDBFjh72q+3UZDMOYq7oVoGoulgYD3MEX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8123

On 29 Sep 2025, at 6:46, Anshuman Khandual wrote:

> follow_devmap_pmd() has already been dropped by the commit fd2825b0760a
> ("mm/gup: remove pXX_devmap usage from get_user_pages()"). The fallback
> stub in the header which is now redundant, can be dropped off as well.
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  include/linux/huge_mm.h | 6 ------
>  1 file changed, 6 deletions(-)
>

Reviewed-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi

