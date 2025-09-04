Return-Path: <linux-kernel+bounces-800850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CA5B43CF3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 15:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00F563BD6C3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 13:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87AD52FF166;
	Thu,  4 Sep 2025 13:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Oq3c5gxC"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2040.outbound.protection.outlook.com [40.107.243.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2BF2E175C
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 13:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756992089; cv=fail; b=nkUzCA5oWwAD1Rk9QjJ+UkjbBbFifW5r59BtdI/qaP1bo9O5DBjgwkLYFJ/WNfb/qU7rEdwybtYn7IqB5m4g9zlI9h0zonD0HnHY60g0s1ANBzNjViviE/IXTr/w9yTMgX/aOm6TScjP0WhQhLzGCB7iJpoBS5qmwvppUyeDkVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756992089; c=relaxed/simple;
	bh=PeaZRg7+FLdavRJoU0uENAbLwESFwE0PPOevk3AEWlk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LyLNPy9HYcQuXGmqilqvHL8vVtakOI5CAV+3JlK5iYvi+bZCFmYYivFS3WsNQXbPGhHXGh4RthCxNPslQHKiZlvuR3FwYMlwMf6cG7uoPmQoRIszHONuLa8mJ+/RyJnc3ZMkAv0GBJ+dCGzwoNbC+lL93GkdtiEEPfmbpuUOmWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Oq3c5gxC; arc=fail smtp.client-ip=40.107.243.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fJrobyP/AJd6K81z5+mAH9mWMNfahdj67nkY/Gf/EmtIXLThqj8IX/gdXRPHLC1nc5IQVkwe9w312tvm0+JYlCVC4+rBPPm8piBCZNKz0F7g//dyuP0+b4A6ZRieksi3YnIOEjStLw6mnwMq3uBYXbMHGBmdv95F0roYC2iAEdD1bwjnP2XDblscLDceiT2heBHcfKZ0BPrT2Js8n5vM1tjG7Bi+LN2ymzBVwvtk/XBk7msYHhlCQNr1x2FpF0e82NqibEqznLS/eFzRoHXKM3SBwFC47yEcn0czS3r0uE9mX1+9YmbFayIy5A2Gti8JtncqVGiz300AcJBomkvVMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mMqYG2KyVOW8jqus7gOLWxPeGNzP+GYnML2NFZLUd6U=;
 b=ZSjXm6/2y7JuTyjJ2watF2DmBYLGtz8JTEs+FRS0wAc5UOwQXXfJvW18FLYetyPhj5VoZy5r+rqw7SAfiIVzsqTn0e0yC+qRGS705aiPLzsOVCcNbUJzevbR1YxiiwEV4lNJEyZ5SH/mKRZQwSikFGGLQeLQj+udYDnx4CruLuI2bd/Edztvh5bF9blc1wHzx2XEM+5ylULHWOByIPoA3TBaiXuaUjnCDW7KIpSKGtZFuwGCMxthsptjasffHqJJL9PQ7yO2EIeMxZ/8ER4vmnOLDfmmEdlarifcOs99As56cbUuzS6ULIqwH5pUA4K+gBLVkrTTh9TA0CNoW86aXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mMqYG2KyVOW8jqus7gOLWxPeGNzP+GYnML2NFZLUd6U=;
 b=Oq3c5gxC4MnScUr+Wdea/bbhDCTsj3gyCatOhGMHhJBgYtNg5LFyTCX2vYCxNEbaqWfSWtpBv5VbYRZFKqyvytCRc4RHhU/2Z1fxRPEA8H9/66fjmVsZ9887GHqXu24OXs99XdV1OQMvJ+cZyVRucSJhI6cIBdV7sRXWGT84oMtKsRW15PTHwIytKOQ65Qe0wRQv1HFby/J3eWVsN1PkW00qwY/Q6+WAWAeywT/O/gfDL8l/yBZw4f9oj+G9xjpJ4c2y7sZLUte9NvmSk75yTOA7KRMIWfZMI1puHGvC6+Z9CQUYFsid26Fv0671ppl15QXoXbxLQFU/9cCNfopygA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CH3PR12MB9122.namprd12.prod.outlook.com (2603:10b6:610:196::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.18; Thu, 4 Sep
 2025 13:21:23 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.9094.016; Thu, 4 Sep 2025
 13:21:23 +0000
From: Zi Yan <ziy@nvidia.com>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <baohua@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Nico Pache <npache@redhat.com>,
 Dev Jain <dev.jain@arm.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 linux-kernel@vger.kernel.org, willy@infradead.org, linux-mm@kvack.org,
 mcgrof@kernel.org, gost.dev@samsung.com, Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v2] huge_memory: return -EINVAL in folio split functions
 when THP is disabled
Date: Thu, 04 Sep 2025 09:21:20 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <74886543-6038-4444-8E2F-3F3169171837@nvidia.com>
In-Reply-To: <20250904095129.222316-1-kernel@pankajraghav.com>
References: <20250904095129.222316-1-kernel@pankajraghav.com>
Content-Type: text/plain
X-ClientProxiedBy: BN9P223CA0021.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:408:10b::26) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CH3PR12MB9122:EE_
X-MS-Office365-Filtering-Correlation-Id: 153265f5-48e9-4b06-c487-08ddebb5f176
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6lx/jrmREEgwtUke19I4n8rIW4JfLaGG0vUM4qsB5QKHCaGDlWSHAPfUp0ZB?=
 =?us-ascii?Q?nasBLixtWj3RgX3BJDbWevNZ5rpOmPfNTl2L9r+vq1eQvi34Sw0DnCAoXq2V?=
 =?us-ascii?Q?5X3yTCPbbkTX3S8N3gmmJXVvNpqB3/HXc5IKC276wx1frTDth65kjI7IJHI1?=
 =?us-ascii?Q?d8RfuhUfHpHgHiEp97p9wIRnEXGyEE0uiQmjok0sQ8GHtaoE9tc87b4nGlPJ?=
 =?us-ascii?Q?ZH+Y550hDWHhVDH1z+1A9mnOb6SFCG8nUOGRQ6GAnmKeJb2yq50bAEeaNs55?=
 =?us-ascii?Q?hQrBbFT31cp5iBJgotuMfLkH0xNwXD7zjTrvcTnbt19MJMP5daqZkoMmSSTD?=
 =?us-ascii?Q?qAgIPgMf2kTJ9m3q2aUcyyoFBZDNBCgtP0Weu3QrePgNXjh8lqYSBw7yWY1Y?=
 =?us-ascii?Q?ML2elXXLJrpnGJrkDjsp8Ea0NmrhKZSmioxWD+AYSYbuorcXwxZjKaaWCUfy?=
 =?us-ascii?Q?dackGgaTmnN5NU3AYgo37phf3iOLbGyWEKfNQYofBDaj1LA4Q1CSuNRbqRdC?=
 =?us-ascii?Q?Bib1MH0DCwgwkEB+M1bslLnr0i5rSWNvGDaNuac3GK8/Msm/3nHnG+URR5aM?=
 =?us-ascii?Q?1ennNjQsNDQdtCNMyxUiggvVFBjQjF+mRZX2e9RgcHMoNC5okQHy3rFxoCDU?=
 =?us-ascii?Q?iI5qPBGukNOOsO+FgGJq1baC1mh+QohYoyaPx2LX57L2nw0dqJI+96xPKYoE?=
 =?us-ascii?Q?aLXdUxhaFx8DR6FAgVe5LmYzQJ+Vq79FhH2cxhP850Uh6zUJ6hzaYR+Wr4XT?=
 =?us-ascii?Q?IzVWZs+mYSgdWYufu5K8QOwwCEkjIjNeGuHroCZEF1XwfgZEjOUBA0D9XkEn?=
 =?us-ascii?Q?KkruTWUcBLy+WbbQVaesltrKq2AxrXTF60YbhHGiu5LPySsV9gv4BpNGQ+hz?=
 =?us-ascii?Q?etSi3X27D6mgpszHaMyso4tduyThGDLnb9waXA+YBvGzdEKFQLeGEZDk2MDM?=
 =?us-ascii?Q?MYd+edg4sMiHVwZhI6qWUXDCd+Ce8QKBa3R5iBazzUu2ftGq0mTTLu5bZoOH?=
 =?us-ascii?Q?YD2ZjSQhBk0wZvuQExDjznFRpJdwkpyr6tqBWIQ/1d5Ys9JuRht3omWcjjMq?=
 =?us-ascii?Q?PG3hdvyMqiIRaZyq+EBDmUNH1w73hhlr7hwBGSLmDWxNzYlnbFGb2ALC6P8g?=
 =?us-ascii?Q?GznMHufhyQPk3srGMN90wAO7N7fpiFA/BODB/wHupQPspo8vZ56cFVYHMTMl?=
 =?us-ascii?Q?d+g5MeZXeQ0ppJpAxzME/VyYgREG5KqFiiBlXJiMJlvWygz9U07oJYvHX0c3?=
 =?us-ascii?Q?KVXZPq5D7PxDBnc5QP5XjCG+oECjBPfXMJOcI7gMbjHn3InIKMKFA+BPg5c/?=
 =?us-ascii?Q?bTGPBub72M5h5Upf0QT5uBts6fjYXMGGxrOqIvVoQxql2BOaMnMyd+cp+TQA?=
 =?us-ascii?Q?9XT5XBEdk468drDpC+jZ90S/zq6deYblQCCsGS6qMCSsqNthUzDV7DVpFrtO?=
 =?us-ascii?Q?q+kOiIkhDjY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zGSs7957Fkgafw9LqQBnbS0VTsJMCFnSvSZB9Oq4Lon/Wy60GzM/z/wrwjoS?=
 =?us-ascii?Q?E2fIUKzSqdfjlCXztyDrst3WtGpRYW8NYhxM67C5uhPGm6H+XWSbQJLfpl3S?=
 =?us-ascii?Q?FlXTG37wyevVYxzKcqkiHv1rbEiECrFvdmuWZNaNXDFIu6UPUufHDfYijacq?=
 =?us-ascii?Q?/788gUhUqOOSsxX04uniRiX35y5IVV7nk/5ygAlkXjsdIyh/3ZpAUPbpQTM+?=
 =?us-ascii?Q?5WIJr+bXC+1fpxCdtn/9cEUOyar6IglRXNa/epMhGCf1oWZZNb/qqRaAWVhh?=
 =?us-ascii?Q?KR+4clEHONqNMg6hWphB5R9qTmR+Q3Umr2cdbIByD0OJtF6HGWsV5aMcbcbz?=
 =?us-ascii?Q?Ac9eYrUY8xwoY8xdNPisyd3ucwZ/23/4yDZgU9dxmSYM66Ytaaz9txQwl3qK?=
 =?us-ascii?Q?Dnt8bXee4WUdGy7nlH3cEJ/E+3DUhcpxgd+UqXkWRW9O/byFYLz3BFxwO5gQ?=
 =?us-ascii?Q?PV+xz/GtyLa275/a2XgW6oaHAn2mnZOlO+r+EeY2w5eekXuQmxKwqMFM+wfH?=
 =?us-ascii?Q?hE6ybZ2Cy8S4t9uwZLpBLMcBXy9odkfFCZt/D8mHo4xQzmKsQAa9gfTbxtWE?=
 =?us-ascii?Q?/yZC1Q22BWWoIJB549ywxftKFYbWDza4mgBeb/2buz4A7Gvnc/CG3y0AlMUL?=
 =?us-ascii?Q?qYBgBmYarG5SEticMvNnoVxJRiuIWrgixMxfwte17lR6PtEoRJc46Xwyro3W?=
 =?us-ascii?Q?ZiGA/wCTRGHF3fJ3sMzdj9/phw0zAk8Z4QATJ7NuOq6hHIr2MxVB5GwBIU/q?=
 =?us-ascii?Q?MdLcInx5UptQAupP/acYfhFsEdXB0SD0Sq0igEpzv0IfDChKFSRRVgKGvney?=
 =?us-ascii?Q?ZTTxsRFzp69XsGCKN/JdI6eLTu0b+QC+fIW5224qP9tRkEgx6z+y0rNTFIue?=
 =?us-ascii?Q?JYGy4lMX6LTIHttR1jOZ2Uk+xsr7mOrKZpSKLNzv5PxmXJrOThxEU0zet7yv?=
 =?us-ascii?Q?nKZmN7PktWJHiptqYb2OA6wZPyOJP7uk/AokC2D/FSER9IhgDJwkXF0ows2q?=
 =?us-ascii?Q?VnYn4A680lKE54txk3hfLTf+JB1X+hq8yHl19PJAfU/6bx0NTwkw87Icf+TX?=
 =?us-ascii?Q?EFoLKU6p6m4tK01lP2Dm4Pxki5TFheWeoy286W+TOxCQXQs0h/R42Wbf08Dx?=
 =?us-ascii?Q?hiRbKsszMvj7sL3eiLtAfx21knL95ZJa0Y59sVTxs0RrhqE3hK0DhhA6sZwa?=
 =?us-ascii?Q?4dSxxIyV2e0GnFbLSDJx5g40LFprJqR4+xlq5nm8ITzpYc2i/7msXh8BrHqM?=
 =?us-ascii?Q?CELDAcYJ8RZKlLMVEJRTVF33DzuMZwVg6IlO0bYfdH/cDICSQ1PtNEVdfz9u?=
 =?us-ascii?Q?sgRW/onqSOaXRpf3uFWXnfaFsgox0uFF+TC2WzcRh1eDRXCCWTPlPL+BmDIU?=
 =?us-ascii?Q?nHqmETLv9gwNQQFtvMD/5jx1qBMFOqm80tLrJCTcZkMFfsdKlWPRxQassDsU?=
 =?us-ascii?Q?Nkx974YgW3eDPo7PaOgXQ+lEwD06mI1X9sxhYrf/lGpY50U/80cW82BmN4K5?=
 =?us-ascii?Q?vAO4ofUY+6RnkzvxorMVNoA7fm7w8bK1Dlqd0Napdcl2i37J+YSCMuEtWMJC?=
 =?us-ascii?Q?fvHpJqkzthwcF1uJJ3ux9wHM9xlmjQp3FB6nRkAo?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 153265f5-48e9-4b06-c487-08ddebb5f176
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 13:21:23.0791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dnoF175FlP5Zsqx6Fb1a7FbsQ+rQo9mTRFwHT3o9oyIg6PdT8JsAmhpwRCbln9FT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9122

On 4 Sep 2025, at 5:51, Pankaj Raghav (Samsung) wrote:

> From: Pankaj Raghav <p.raghav@samsung.com>
>
> split_huge_page_to_list_[to_order](), split_huge_page() and
> try_folio_split() return 0 on success and error codes on failure.
>
> When THP is disabled, these functions return 0 indicating success even
> though an error code should be returned as it is not possible to split a
> folio when THP is disabled.
>
> Make all these functions return -EINVAL to indicate failure instead of
> 0. As large folios depend on CONFIG_THP, issue warning as this function
> should not be called without a large folio.
>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
> This issue was discovered while experimenting enabling large folios
> without THP and found that returning 0 in these functions is resulting in
> undefined behavior in truncate operations. This change fixes the issue.
>
>  include/linux/huge_mm.h | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>
Acked-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi

