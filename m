Return-Path: <linux-kernel+bounces-730558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8569CB0464B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 19:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A41DB1A6233B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 17:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4B12620EE;
	Mon, 14 Jul 2025 17:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uqb9co0u"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95943FD4
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 17:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752513514; cv=fail; b=DBP+egX0UI2m++f896yulhqa+jc6VBsRnArtOe5UmmYnxFebhXcvEnXrF0Nsbyk8tXW+m74I74fG6yAlZfkAQbov8hviNB99xKglD3Ziz1qqozqc4YUA5FG1beLH8hqf04a+t1cGubWllNd2/28aa8MhlxRFIiPk52d5jT3kTlI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752513514; c=relaxed/simple;
	bh=cOz9xI4gloDbZj/szDqZIU2gTFfJ4iOLNqVwdZ+ofdA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=DHNZm/UHMH9/VFO4iENAOrlo38kW+p3UjGOfECkeW0gclgeuoQGZnDsrqlD09xLVzQDFCu+W4Rqj307/EaF4s8kj8+G9m7qtiW+l8IWVccqcYqYM4xnR0AY1M5Evq5CXNBN+mbOf7WIEYtnDYksd//vmWoUIDncaz+JD5RB7Kqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uqb9co0u; arc=fail smtp.client-ip=40.107.93.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pY+SU+FofnklO1lgAff1sOhUf/gIM4DasvRZxYvTgabWTAq0iZx3/BID5kmPOAxSFKSxORAkPtjQW7HfjyQW1cE2XoESgF89rpJSpc7tcg4epyit4/KCy4pJbSB2GSircKp+ANLQD+2ipfMuyTsMI1YOtE3MYI7sG4wyDHL2hMVoko3kaqJcnm941T0hRIjO3ljwGYfCFI04W+RNYsivtBI2YqZtjHDRKp2ZGEsOTr2IcS0NzvmxRQtHOjMATGJz28hzTXjos4gHUJAwUicfMf1nTL9qp7/9/XFb/HX9Q5UyLlXNwQKppWAJv9qUTh2xZH4SH6dN6MK+tqwCsUCTOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nEI8SLBGgld3UlayCuyh6P1c0zJCasNO4jDkZHvh3AQ=;
 b=rsKkWqEfx18mrjXaV5yI6wpDPYN8o5uoGR3WA8NIiy5SyDQAsJ0wuJR/gGrpzzDubUu3fRWwvaSSyQ/HSYEAUHekd7i8L7axSdFtVj/ixyPoc/ndNwUW87ykOTfXOyi+X1nwifyOm4zK/wUdqUMc2AipDdaBi4XUXefBf7C2EtRpCDg2N5y6A5X+504XcLDJgr7IlQ1Dl8gE8REvCuUbJaSt5h7MCEbT1lOW5wml/uw+XeCRg+jiupjDwwWn+M06ji6wQLktuZWnH8YragwWUcoCqsVc0tUiU4py9Xpd2C848S1tQwsOThki0ez0AAt9UHsBqYcF/7U98UQgbTeyUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nEI8SLBGgld3UlayCuyh6P1c0zJCasNO4jDkZHvh3AQ=;
 b=uqb9co0u8Scgg8/pskxEdvywGdh41b2VvKflXOfId6o/91h1lXvJ3hfkej/kVSM0IX9CuEny3UQa+iewP8r+tiYYG0d5qeXF2ha01edSz0KTy+rSsUb/6G8yJlLrZwoyiWWAjGQrgSOFnRHb1mdwrh5T6OufM+YaKru27T8YafYEdSY7Kji+/2WRQ5jKTJ6DFn0aXg4t8tCNwZ5nPEQfpXl5sA/JvZ2c8ebiKNMi828r02PBpM+rsO0JmWIpJvgyqDL0L/cy0JK6li0St+h5BN6XPIE7azMjM/Fc0ET/o8ryjT5fQNV6HIM2Z29iPVd5YjNN1xxIEGAGmGOmN2qNyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 PH7PR12MB7817.namprd12.prod.outlook.com (2603:10b6:510:279::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Mon, 14 Jul
 2025 17:18:29 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.8922.023; Mon, 14 Jul 2025
 17:18:29 +0000
From: Zi Yan <ziy@nvidia.com>
To: Balbir Singh <balbirs@nvidia.com>,
	David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>,
	Kirill Shutemov <k.shutemov@gmail.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] __folio_split() clean up.
Date: Mon, 14 Jul 2025 13:18:21 -0400
Message-ID: <20250714171823.3626213-1-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1P222CA0009.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::14) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|PH7PR12MB7817:EE_
X-MS-Office365-Filtering-Correlation-Id: f64304ef-229a-47e4-99af-08ddc2fa73ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7DrGOrcPavVxybDbsUnihJ1O0is9rLjKGBxVkPVKBxawoaytzAu+jhnZPFAa?=
 =?us-ascii?Q?NidQ9tRGHQofOCdfaFZsOrczfNAawXu5rpfde3t34nG6S/MzuNO/Bej+TN7E?=
 =?us-ascii?Q?082WXLdr3lIxUWjkok2K8/ambZKrn79YEiDVwf9RV8C75+MP7JL4CpHhN2WL?=
 =?us-ascii?Q?GTzs4yP6Zm3kBZ9YwVWjEIzT7KFp8AyOvX2gsQ+jsBWLuBZYVVYFhHxTULfU?=
 =?us-ascii?Q?vvrjtVJ/DBObDCPgikbjJqSE3hG1Z3KusK8QlMYb4B4MZP8pUZoFnbAwaleR?=
 =?us-ascii?Q?TcWG1Dem3nrgcEoNHO92r3TZkkxUYf29Sqf+4m7Hz950/r/s/imgFLzRsXjB?=
 =?us-ascii?Q?6YmUIK3dTcbDP2wRN87vDs0R4SEuGWQ4KlhywxE+SEfqg24cul/OnwQU3erP?=
 =?us-ascii?Q?8Uok2tghWBggYO5alpFiBT9M+7RXkqMly6FWbXTS+hu8msLLvESFaN9CMKRf?=
 =?us-ascii?Q?f/H7LrjTFZD/XI4F6ruDNsomxfMxwDS0t4mLAFE3NDY34nbLEZffl7JXp1rY?=
 =?us-ascii?Q?/7+LH8ttisiCxt6+a+lSyA/jXjEvV7SMo7cSa8NRhflqPgdUf5UHRnHNnwzC?=
 =?us-ascii?Q?aqFql+/GdMcIbtmOZOFBb/LrRzGBSQb1PNUUqa4wK16aF8AksPPMxXZyYkEd?=
 =?us-ascii?Q?Vx1kni0gkE02O6b01aKaFsExJdOmeBh0fLzB/zlUg5VMVnnpyZsLNqXXvnzD?=
 =?us-ascii?Q?3N/ydVETmobap5nRNCJS2x2Afw4KO//TdpU5jdnM4Xf0N+NJ23aFwO7Q8Nq0?=
 =?us-ascii?Q?cQT7FbP3OEwhLsqnmOA5WI2Ki3KqV6DhIGm5SaAl0P2ZTcf3v0GJHp+nV0Rm?=
 =?us-ascii?Q?dLW8EvLxAO1NfQBfXvO8Jl5asyq5drMdAlCWSOcBbl4yhiQI+qRbEbH0Kk6x?=
 =?us-ascii?Q?JMFqYFRV7AxAKdyECv5uXPZQxjl3kq8csVkHwNGjBrPJfpiEJq9ptyrVu7J0?=
 =?us-ascii?Q?Hbzjsz5CLc//jd+4FaRFB3VH0lw/LgDJOLNu3kHEbyEw4+CQdbmbP1CGStpj?=
 =?us-ascii?Q?B0XtmhLANmeBrZK5mXcNliYhzJr35PZRzOBRXCPF4D2meLtbIpC8MGjrCqKj?=
 =?us-ascii?Q?qsmKIMRfA58zToVqGOeqnzdXC/yhTAmQKwkNvr1s0ttR682nwXcVq4003vQJ?=
 =?us-ascii?Q?XAMdZaihyZMu52ZKnYcwO4W8bX0vQ6PcwxzPvuJsmv4b5KkjOONWfBZVn+Gn?=
 =?us-ascii?Q?39+Q7S4hsRoPUeYqhqaFhVvsa0pvGg+SkQFuuupOJpgftMLt5MW4g+VzkvJ0?=
 =?us-ascii?Q?Yk2G0YGHgq0KIctxuyyd9NEkN5KV1N5oZ9okLoZobpe7amXYT59sXl+Iflui?=
 =?us-ascii?Q?leRHLI39AR/SnOh0+vh9C5RnqUCAI7HJtUSbxy1k2qC8qx60G5bWYu//WDi8?=
 =?us-ascii?Q?t7/7n6tPj4/Adeypz0Utby+oc3HlAQBcqg7DBGQEIbtTjUV09//dtAUJ39w7?=
 =?us-ascii?Q?32rzMnwt5aM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+X7sVY2gi/3muZwKTuxmdhMdzy/6XJ89zcIHmYungJvQFU/484zjlIuUzbya?=
 =?us-ascii?Q?8QTCEkxnEjwi5USIIx+1nTl2lO8J7ULJD7lhig+uULPYZRl8VBS61TwBLs3y?=
 =?us-ascii?Q?Q1B+TrrK/1gv5UNZZr3c02sgTXPlNDrxWJPu+2Wpsrt3AAFQdEUey0VS1YJk?=
 =?us-ascii?Q?f6sKjOmzEdzM0V+zUKwGIdbcKDJB78NCD+peaZCaIiQSxMQEn+0DGyQ0/LnY?=
 =?us-ascii?Q?5CwXnDimrjl5MSnnVh74O4i0oxh3lXnhkQ5s3uHvdEgxc/nc8SI6fcUteaRZ?=
 =?us-ascii?Q?YTLnVJGpVEmb+3uW4ZG76QINbZa3HrmftsYZSXcYA6GDjRACqPCpwHy057dS?=
 =?us-ascii?Q?cWaLQF41F02xcxZQRtBsPlkWvWqa9xSDvOh7Y8lqREhZkc62da39G4uEqDqy?=
 =?us-ascii?Q?MkuWr082iVr5O6EFknDIFFfK4bMk3z9OvFP0PcXLvwH/+AimtnUIVok7tUlt?=
 =?us-ascii?Q?SlRofUq+CwlRuPecbew8mB79QaXv7eoaZeR5eoV7tO4TiSFFWjb/214UNaJP?=
 =?us-ascii?Q?0LRDYRJcp8htlMxkm3h7sVjqK2bU/SKJ1bINIsdpVweKQgkSn2Mr14+DpPDp?=
 =?us-ascii?Q?3VkeSdMzILfJKJ2p5T1VlJ2MQuh/yZY+9NV+Nsuzu9Rdq+RtJqAEbqjDS0LZ?=
 =?us-ascii?Q?eX8MPw/dZyQUvkWrHPSb2FkowFz2sKVcdjRdxgBucUHBiBVrUQ1vDHWsz5Dq?=
 =?us-ascii?Q?DKCSebKS9JMZ7ms8RfRFrB95fu1bGxSwviDyDUprK2o5RUaPNAugce3YVscs?=
 =?us-ascii?Q?q37m/GkwQuppVxzkAmSm2lfVXTi1ld1T3o3OuIflapVXUjdoWzkmy+f1jlKO?=
 =?us-ascii?Q?nJ0DSQfwFE+HJ5qACvKoVwrpZny5aznS3wHFOt/YoSVaV560S8JVZTknPebw?=
 =?us-ascii?Q?5IdzdyJxP9Pgy6tXlwIZx8EVxw4M0czWyPAlPlMHPV4Sf5hansr1jhdq9RoF?=
 =?us-ascii?Q?OX1JIosguOf4fXCnXKeiiryG+HMvoR7smsxtKz4P6NgCIZXgi+ZTmQ/vDyCL?=
 =?us-ascii?Q?q005jo0k9BjM2s6w/tq7pClsGKUThx7RXF16oGWdnz2RAsDyeY2XP3sDrFPP?=
 =?us-ascii?Q?U0lDZPwc8l/KFsg+PT8LbvRUoosJu2gwKBZ9PtyBqEplHbFEN336xyxFAEgT?=
 =?us-ascii?Q?7iJMIQhuZpm5xY4b4zTD4qRpkG7zfvJyFFahzTYrdo9zjEdnjc4bnA1czChd?=
 =?us-ascii?Q?na4U2FbHZAjjJ2qYJol8/+w102mOqL8a+U6pUZCdo1qiNzckefaiAjVVgJcV?=
 =?us-ascii?Q?ABONgnsAnDhYDimcskNpe8Y/qgrArl9SNDoLvS4c8Ta6rTFou65YuqcgB8sL?=
 =?us-ascii?Q?iKL3rO2lhnwfqR+GXtlvDpGonXO78vEM7hqcbRGD3fMqRdiORAxxaEx+X3Lg?=
 =?us-ascii?Q?F0A4WBtlExFBbhzLe7oOkxbvfftawyOQATEjmrubTlLZZ6ZfXQ8zCVaDjfDm?=
 =?us-ascii?Q?eO/DBqG2c1DVSTI+7Q6NQUgcV3bi/C95+gx/NWmiPycR0Rrc3he671Ec7bIK?=
 =?us-ascii?Q?fxV4L4wEeq11bdRws32DpTo7xUw9en4JgvF+FGxJASMXf2GENsobNPK6Cx6a?=
 =?us-ascii?Q?Q0xnQmxp/MQXFShxttrMAvYQc1leCtfuAvcK1wJ0?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f64304ef-229a-47e4-99af-08ddc2fa73ad
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 17:18:29.6183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OvL9Cv7mCiU5N3P65mSplbN78Nj/UAVbFp6rOmsZcbd23rHjnlrqjKMAgVMljKrj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7817

Based on the prior discussion[1], this patch improves
__split_unmapped_folio() by making it reusable for splitting unmapped
folios. This helps avoid the need for a new boolean unmapped parameter
to guard mapping-related code.

An additional benefit is that __split_unmapped_folio() could be
called on after-split folios by __folio_split(). It can enable new split
methods. For example, at deferred split time, unmapped subpages can
scatter arbitrarily within a large folio, neither uniform nor non-uniform
split can maximize after-split folio orders for mapped subpages.
The hope is that by calling __split_unmapped_folio() multiple times,
a better split result can be achieved.

It passed mm selftests.


Changelog
===
From V2[3]:
1. Code format fixes
2. Restructured code to remove after_split goto label.

From V1[2]:
1. Fixed indentations.
2. Used folio_expected_ref_count() to calculate ref_count instead of
   open coding.


[1] https://lore.kernel.org/linux-mm/94D8C1A4-780C-4BEC-A336-7D3613B54845@nvidia.com/
[2] https://lore.kernel.org/linux-mm/20250711030259.3574392-1-ziy@nvidia.com/
[2] https://lore.kernel.org/linux-mm/20250711182355.3592618-1-ziy@nvidia.com/

Zi Yan (2):
  mm/huge_memory: move unrelated code out of __split_unmapped_folio()
  mm/huge_memory: use folio_expected_ref_count() to calculate ref_count.

 mm/huge_memory.c | 289 +++++++++++++++++++++++------------------------
 1 file changed, 142 insertions(+), 147 deletions(-)

-- 
2.47.2


