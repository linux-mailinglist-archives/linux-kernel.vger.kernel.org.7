Return-Path: <linux-kernel+bounces-728086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C6CB02390
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 20:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 196C4189DA1C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136362F3647;
	Fri, 11 Jul 2025 18:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="h5sUacBw"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2050.outbound.protection.outlook.com [40.107.96.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24082F273D
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 18:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752258243; cv=fail; b=BEEDjeza2e2xduaRKtnKWs/GB5PU/WViIVZvWPrGdqiyIXxzWoeRxiRBabe0RktRZFciJdmwSR5y7ntPMcVBeFuSwbJONqn/w5gc+0BPE5FEZx2L2gwHcF96MkoQRLy6OMEIDuswYOV1lKNntdNgaikb5B6pAtJFMQNMxa7544U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752258243; c=relaxed/simple;
	bh=DchgOlb9f2l/8fj9FneJefSL3aO7GSIduwyLJCzsGSo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=N9oOxGoUzcA7CAt8T3uyY29Mf80cwUI2QbNOKovncRqJYufMxhvGDQ8HtqWRBxxUf0kdQdEyiwjwi+Ou4b+tRzn3p8qfgeM9JKFkPJeTyg3NLdL/litlEXBZ8oQN/yr76uyc836Zi+kOTE6EePe92NaD+Q1NNz8Ot2Ke9oSj3Bc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=h5sUacBw; arc=fail smtp.client-ip=40.107.96.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=idiSGwjMOxLFhzELUC+dt7ILEbCl1/Cuf+akuaGaoBlQBiAlYSR5Uq8SbRrNwHPLPX+fSSeOV4CIKSaHvdpS/FS5A3SSYBKafPczy2dlpevw742XlTULjBgOrNmPN6hBC0BI2mT5wARr0jln9dqHw8EYdMksYo3PzZjYxpzp8Ms2FKpmmBcVScMnZcar6HR1Cg5MH77yS+5AxGplOZkOJxbGl4RtIhrM2y44b7tqz8UEFsSMf0v80THvTcBi1qwC+1bYv2bBj7tZNW3z5MeeI078oTHl6A/mKCGDg8T0J2WybSfaxfDp0TZHZ267iU4cgL2tZx8lqvqHd5gq+gJn4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LVtc6RUIJmJTu3lmk4C40TYLgotyXLrSrLmpSkBkXUs=;
 b=JcQQepoTfSf3PZ0SRVhSFUwtj2jjA1IoN/37aSUKTCUdTafrQn33wRnEPERktjjdMkT/F79e2i+y9WGzHIRvNYkALlo4IpcX4TPTxAqeSWpP16LfJAZS3/BAYbLs1+wWf0t6MOPWTig5pM7q6qcw8DrNiMuTTTY/LTosGDq0DnQjqdjxQBsW3XVSvDegj+THjxNCRhUrKRMTi2IWsAyM2aEnxitwbmqRXDNFFwv6eNmW3+sOIvyGSDmfy9g1fqFux9grKkQdDmXq0V7NFbp2mIaVofDfM6lV8GY8j7kV8G5oGEDtHtc9kKCW270j/XA2NZZEgeQ9U2YV9YKhdgwutA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LVtc6RUIJmJTu3lmk4C40TYLgotyXLrSrLmpSkBkXUs=;
 b=h5sUacBwvmNwQeS2mSCNsDIKx3e5Z3dai/CHdeBjueTO6IawRpSlG9ISpVu+oagKiD0mt/uHPKJG/BhUR8uMw/AjbAgoZ7Bd846PWPkeu+LLAk+9PVkUcdlmNPa0ouyzXNV2bLvTHavVWcFK1M81OtttyX7fqhYr4qGDSXmR7IhwMyCNSB6HpXbuOwGd8ySnd0hW/otoCaZsYBGbkPFf6hkeKcfLoONIlb9LujkkPtFr/kk2CAngj+BHd6Etq/BTFsbE7fDQG3x600viVZAAVI3PDcCCFK5TPIYSyAxSUFO0PNgPwaISjCB3lc7gHzDP7dDhPC3PRzWgH8+FX0raiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CYYPR12MB9016.namprd12.prod.outlook.com (2603:10b6:930:c4::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.25; Fri, 11 Jul 2025 18:23:59 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.8922.023; Fri, 11 Jul 2025
 18:23:59 +0000
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
Subject: [PATCH v2 0/2] __folio_split() clean up.
Date: Fri, 11 Jul 2025 14:23:53 -0400
Message-ID: <20250711182355.3592618-1-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0P221CA0022.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:52a::35) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CYYPR12MB9016:EE_
X-MS-Office365-Filtering-Correlation-Id: d47a5c9c-47af-4224-f073-08ddc0a81a87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4+xt8A7wT0EbOvxwZGCHKOXbxqIRCA0e8hDi5BgejjYbT6PfHjTSUrYXBLb/?=
 =?us-ascii?Q?ptQz/vakgRm1y7TmiNbyQl63uCPm0+FFNTPAZnzB6iBffv3A20wW0ZxlZkcl?=
 =?us-ascii?Q?/DN346NmjMS5C73lCd4lWxPK+Up6DzhuG8I159kaAothHWMS9rXRrCf9kon4?=
 =?us-ascii?Q?f68LDEj+q+TzjsrdAd3+YxCS9dkA6WMq+eXzLsugY8CjA/KOO0HQYR4OtJPa?=
 =?us-ascii?Q?9iwYSMCvLmO8tH8XGFNnXqDA4Bi4Vk2zCdP3xd+R4ljMdMQOlVsQZgit7d5Y?=
 =?us-ascii?Q?WyOYwzJXWszcxli6NrbhYWCpUG7Avp1BllT9VDcvYlvuKdhZkBdEdi2zKAjw?=
 =?us-ascii?Q?1Tz1JsJ2VNLbP7ygOzOo9OxXPNhlbkKCyAl5oTE4hQ1gCUM2gp1Cp8lWsP0e?=
 =?us-ascii?Q?yVrQr0NrzN6FLr9ZUX1leE+Zd8hGpJpV4PVCRD1sn9b8doAgGbeuTmMBeFF+?=
 =?us-ascii?Q?rNsLs1g94DK8sOcXBVxdHGWApZUP0iyBqusX4vy8w53J80iwGURpbKd25rRR?=
 =?us-ascii?Q?BmGOsHK+dJMhTbo1a2q/jZvIb5BrDQE0u+PBto7xiCje7vNWZKhxuBW1/dyV?=
 =?us-ascii?Q?A+ka5MTderMowJDEIZEWe0BX19mbQo36tTKKUtcKCz49JdyzHHWHV/CqHdQg?=
 =?us-ascii?Q?OeEjhH4+01Ugw52v9gQexBSYVqJoYZbDWhunBmG0cfeT5vfgsVr2q4KtD9Kw?=
 =?us-ascii?Q?Pepqq0aGT/LY75ylQbVY3tWbSg16PgqSQ0txNBerH6ahRCH08x2kH35q7Nji?=
 =?us-ascii?Q?yk575ePJfBP1UwtTWOh+knkup9G6Bu2qD3T7jlXr3JYCKhmmniSbNyVXRctz?=
 =?us-ascii?Q?tdt+ycP9jIYhIyHCcTeaXtRxOzOqtOaSX32SukLUZM7DWP5j3eYygVgjf/UG?=
 =?us-ascii?Q?e51ZkBO9t1/XO4pBFZmmzorZK34vIcklx1qOD92sga6aMS8gmyVuoCSVIu+8?=
 =?us-ascii?Q?qnU/YLX/RkNb4FclRK3bo/vcwuP4zSaiBJO6v7hEimh95BbC2C6XXUa8CSSv?=
 =?us-ascii?Q?coMxCcIX67H8YMVzfLDwxm2TfD9NVHYPVjgJ1xfL4bswpKMBksBTmzRiIdWv?=
 =?us-ascii?Q?LZhBctd+rTYIHUDuHu9CvEr0Yvj2C6O8RK3grmS2q44T6C7DeTj0co1DZy0Y?=
 =?us-ascii?Q?Vvqk8lAdifx269XwcochbP0MevC4UinjgFZWQN6CiNiyjyVj6I4AujDs/bBt?=
 =?us-ascii?Q?SF3rSlajGnRsjqT/llhXwrZ5BMMmG+2HmHb1rbKmGlJ7/G0xKrCBR+reZoRl?=
 =?us-ascii?Q?iteBOm8ZNakgyLxRpuFWQaSQajlCbo4ch4ejpkPuxioUmIPBH48TWCsuVSWb?=
 =?us-ascii?Q?CnY/g1eLonaMvTueSw9rR7tyhviaX6eUAH6uJxIs4BhLF3BtjmgmPNJHheEJ?=
 =?us-ascii?Q?KYpopt4DVq9bOWWrJKQ5LNjSNethPUcnH5AjUgaZyYyNuCpD9wZ/ciyxqR8E?=
 =?us-ascii?Q?u2xCPo0zrB8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1srmi6zu936n4nJFj6TMqofZR75dueCJ5eWbDqbGzBvw+kPf6ZYPzLzQEhtb?=
 =?us-ascii?Q?6h9sbZXTDsb8afEmnTocTUVbc7Y7wq6KQ+JVUCYnDttyUpiuix7qprCnlsgW?=
 =?us-ascii?Q?qYMuDEXZT5aL7d8yUdVXC3CiYUHDeYPi202d/RNeyjIyGcYHuZVTJzOspjxX?=
 =?us-ascii?Q?ka2cp+1GOnhx8YIDjW6qQiuzZn7ZdEr4zjzQhq1QuMC+XsI2XvcUvkBZZB6/?=
 =?us-ascii?Q?DrkiOi6bKMiDtdb3E/HqtnsJPtP2UpT43S72VvSOnIO4P+Rb02eYjv6+inB8?=
 =?us-ascii?Q?vq9G+MHZ+rIipyGILTJLUPg68KbS6X6WbtyCDMgPaM6D6Zoxqkx9vkHPsHRs?=
 =?us-ascii?Q?Il9XTl9ZIj6p146TRW9+MLbuXid2A5hJkyjqymQinnNSv+hamd6Xu23YVj9Y?=
 =?us-ascii?Q?8nOaK528KemzAGZeDSGwMXbrG8NeDh3sBR35nj326Jap0hOxVJNvA9IduBhQ?=
 =?us-ascii?Q?jr0wyboqSejt1P2J1FslV637jpHRyCsBBxK0qAOrspKdDyd0utViMHV5WD7D?=
 =?us-ascii?Q?S/Bdiw/yu0YYbjOtU2St/3AYut//NBT38tN3ADoS6J1R3Q1vUTSQhc1zGUCd?=
 =?us-ascii?Q?Wg99T8tQ7THo1us1vgg/R8J0LL2/83wXO1GVFfvuoam3TkiN2AI2uNAzLRMA?=
 =?us-ascii?Q?g6Bhj/ZlOGO3SZMSHG6AEcO2badyVzXFj+rMe/S64Re7cUjmdAr+MfRbmL3e?=
 =?us-ascii?Q?iNyJMa9X30r3kR+XZPrcKdZkXNzB7JSr6/9VjBuGgFAC4jmTDENxmxMYSFwz?=
 =?us-ascii?Q?Gu6lvVd8X4sLR0/flqEbpvf3eAwY9xz4wswr1Z0WPWN5siWQWPNJ1yxx0kK1?=
 =?us-ascii?Q?QvxXou2jHS6x/RHnZvhVnCVJ/PQ80nF88WIp2JpAdcrkTt7mt2VakeAnld3o?=
 =?us-ascii?Q?kJS2v8dt70GJ+SK7zGOf+z3dP3DNMyzdePQdPXcrZPS+KDOyw2Gly+23LrIS?=
 =?us-ascii?Q?h07dqYzNeFXx8POtFmqR1sdLCxvmV7O65pq05aF1beQVCt6WqkHz7mQK7hPH?=
 =?us-ascii?Q?HaLAfTxtNm51GiakeMho8II2rHytSdePdtbCZbV9A7p3MbIjs19hq+9lAco5?=
 =?us-ascii?Q?Fk1vNXu3UYApcUuLeiEwAeX7l30sp5sVtVTgZ+mdifD/xqha3gaXMNfFxbgv?=
 =?us-ascii?Q?8SPBi24cVSsR9g1/KDOAGUYp845QFuln3ySgiG6eQ+u/JBOvSaNU10XdyXkU?=
 =?us-ascii?Q?an//4qmecaQhxk46bpG4QE4Tw5VK8/rCw23x/whZBO7tsx/wY/xi2G2tZcgS?=
 =?us-ascii?Q?xQXL3M3vK6oHJ5053cqOu6nrkA9Ws2/bzSnTfRoCMm6WkpIqqrGu/v8xznAp?=
 =?us-ascii?Q?9o3E3GClkbni3U2ytyZW4LshyNASZv1aLLn8/fkepQPH3oKhQcCKry+HksB9?=
 =?us-ascii?Q?HEh9mPqY5eeU6Ma3YhkEtxwlZiEKh9KqFj3C+YxtkufqiEpv69z1YwP03WQR?=
 =?us-ascii?Q?5i/ALMxMokH87ZumoifGwpUyjZ2zZbAt0MzhQsWCseZDYr6RdF23UDOr9nNc?=
 =?us-ascii?Q?XAcQCp8yLpQNFyOdCl/+dn/+3gEvm9qIhxmw0SNMFE5U5/Td00aa3t5R+Syp?=
 =?us-ascii?Q?uSoYtV3hkyYgSoi2iZiK0SHSOJTRRqyiaetBBrh7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d47a5c9c-47af-4224-f073-08ddc0a81a87
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 18:23:58.9895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: it1Mjqy9zJEi2PEP7/MJRVxINm/6Y2q/EDYpgXUMMQ6rBkxWV8X1laCgRqPZB5J9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB9016

Based on the prior discussion[1], this patch improves
__split_unmapped_folio() by making it reusable for splitting unmapped folios.
This helps avoid the need for a new boolean unmapped parameter to guard
mapping-related code.

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
From V1[2]:
1. Fixed indentations.
2. Used folio_expected_ref_count() to calculate ref_count instead of
   open coding.


[1] https://lore.kernel.org/linux-mm/94D8C1A4-780C-4BEC-A336-7D3613B54845@nvidia.com/
[2] https://lore.kernel.org/linux-mm/20250711030259.3574392-1-ziy@nvidia.com/

Zi Yan (2):
  mm/huge_memory: move unrelated code out of __split_unmapped_folio()
  mm/huge_memory: use folio_expected_ref_count() to calculate ref_count.

 mm/huge_memory.c | 271 +++++++++++++++++++++++------------------------
 1 file changed, 135 insertions(+), 136 deletions(-)

-- 
2.47.2


