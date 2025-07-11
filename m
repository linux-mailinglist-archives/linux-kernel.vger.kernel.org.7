Return-Path: <linux-kernel+bounces-728088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8028FB02394
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 20:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 119DFB42AE0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4E02F3626;
	Fri, 11 Jul 2025 18:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KNg6S3v8"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2085.outbound.protection.outlook.com [40.107.96.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D722F3C1C
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 18:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752258251; cv=fail; b=GGx4GtucB1VzNJ9z+VGQJpL2GMxEOYcsDsjum8TGCeBC2oQe8I47R/TeNVeprPI0bXWF+vBiDeEbCTka47eYwMR5uA/HsQ9OsDbvBFfYodCR//LXIZCXS8gtx9IITRsu8ZvNxRBwlB4N5jpJlKGTtvSC1tieI7oWqag1JiJqqCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752258251; c=relaxed/simple;
	bh=87KjgNpRzkDPfbBFvsCUfqzzQTgeoqN6hnAiMZGaZDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RISXkYezypc40Ysy/P+4POTW1SX64qZedOymzOc42Vy1W7CHDvHSWwc9HBAhxidD6Q3Vs8C9xGb5L6QlyRMl1aXK15ZkIbstvhNt2GuqkMs+/nQVyUS8V8AxhY8apcsUcgG+BSrOwhntVSz4jeuxj4bRgOyuSUxTPPxsrNKHqIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KNg6S3v8; arc=fail smtp.client-ip=40.107.96.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jTJbMa8fd+ZTh5Fyp1Gj2PND98i4RNYUiHmUGvRfmIZN3YD9dPOPsdpr0wJTAAczwV0a7njCPDux+O0dvPxutJrOltosE4e4B9vpDe+R5n8j0HuNXCu/suWnDagZQzef6aYUI/uRela8djkMyE/D1oIqawwiuKVIix9kHaoH5aWd9Ti8zkSIJrC3IzlBxBcrl1NmHUWpzC7MyLx5E1L7Z9lTYL9YeiW22Zhec7UnxVpfThYNALU9nwfz0bpRAwKlwPcajxWwmmS2uApZUMH6BSVlvLjMSKcHXKc3zQPq3DxgMeFCeWocr+f72MgjgxUCDD1po/3KIYsqm6nbCPqEWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gW7f5sOkljICYDVinO7KC+cA90y2qzq2kZI78FujKe8=;
 b=E+4uumKkOrvQlU3ctsaKvbPgiB8jD5yjL08RYK4XZjzas2orwOoS13bBeeQdcduc1K5QboIU3nNGlZeCXopzNHoiZ3qEzvPaaTFGoMfi/H9ntuJvTZUm9iB5nh+3Xo9Ec/IbWV4A41EE3PANQPjotbKlmARVK3cmqMFng4iIyhLfICTTj8Bh7DAUmiQQHhlKlyQ2MLwPSwCqUM7LTEZTZM7rnaE3r7CCu2gDf98/BplhSJZw7bU/U1yIMjYBo7YUB+HIwoPiTA+vA0BDsi3HyYPOXE8/Mlqanxa5jOQ1V7DHo41IaySJXc7Sy2DxMeVNu36LxAXAiag43t1U8WjwCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gW7f5sOkljICYDVinO7KC+cA90y2qzq2kZI78FujKe8=;
 b=KNg6S3v8EUx6J49KAPo+Xn2vynSXC9UOWs0SORgIn0PiXNBpbsV+66B7H6kkyub3YV0UV4Ql+2vjGKgiGnuotIUgAdNXns/SOueVbYdm728HaTXrQd3u4pwJPNsc36piOoKUuUILu0LMUu9XxY6evOugSZByLbUODNDCes94i1w4XV/P7d9XlcD/EU/dodexDi/9/xX3NgS1WG28Du7VxIfqVA+3fJ9kbxsVKw7a3Z1dQW1DhZ7NheCGeMWZuucvociybWTpebkDEC77jyJHGSlt7AQE27CTF7jmopz5EoGcBVgPL8eNjyc1tbD1l1UMwV4uPAfUdAuWc8U9q4UYEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CYYPR12MB9016.namprd12.prod.outlook.com (2603:10b6:930:c4::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.25; Fri, 11 Jul 2025 18:24:06 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.8922.023; Fri, 11 Jul 2025
 18:24:06 +0000
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
Subject: [PATCH v2 2/2] mm/huge_memory: use folio_expected_ref_count() to calculate ref_count.
Date: Fri, 11 Jul 2025 14:23:55 -0400
Message-ID: <20250711182355.3592618-3-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250711182355.3592618-1-ziy@nvidia.com>
References: <20250711182355.3592618-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN0P221CA0027.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:52a::21) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CYYPR12MB9016:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c5b6111-119d-4b2d-a234-08ddc0a81f39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?clwESH9m632w73DAlL/WeeyKPOyIgPrSeqcl5ewbFqRa8/xKGn1eSHNyTxBz?=
 =?us-ascii?Q?euuF5Z5Qqy6rj8zBVO64ZOuyYNKRlei3hTKpftAOKr7cA5w/MABHml8yZm5C?=
 =?us-ascii?Q?t/fXm/OH1YkWy8U+sPq31fFDbDBU5u5GTvVfABZ1MI9MUobDyvoYfMFKkgAb?=
 =?us-ascii?Q?7yt6S+ZKhVb/pkgdVjxVz9+prZ2A2C52+xTTLZdwGZagz3am/kJFqSM1hsEn?=
 =?us-ascii?Q?EH+TSctUIG5b9G54sh5WmvEAgTPgZ3n9vJRMIeH6tuiJRSemDhLjDO5NZAgY?=
 =?us-ascii?Q?kKwfZnEewlYaEP1lwq8lg1M6xgnOnjELkQWk3fKs8X5MX9+uPb2KtIg2H3QI?=
 =?us-ascii?Q?Qj44U3qEae93gtxhZzV3WKQaYhAk7DvGRsTPeVElY9yy+tRCHzNATivKZFaD?=
 =?us-ascii?Q?0+eVG0noWY0PZp4FMOxtANoAD2ueGkjgyIuSsHzalFctd39MrQcvAuIhhE1W?=
 =?us-ascii?Q?8DpSStGjBDSXzuFKyVlyXgwHNjIji/Z3W/vW3ifLMez3U5T2Tb+WESw07yna?=
 =?us-ascii?Q?eS7Q+kQF+tsV6UEchIw0EkgR27oej+bXT9tteNoOeEgiCbXn9lzIRK7EYkQT?=
 =?us-ascii?Q?5A4OWaqofmz2bE25E8uN8TDB6Fyy/Lb0ALLSFnyiyqQgcW0/+LqLaUzE4l+D?=
 =?us-ascii?Q?YpL5ahb9EPgMZHM1HM2XOvmsCrRla1KowR0lwhmi6EZHeit53joIYW3pk0e5?=
 =?us-ascii?Q?M2GitwfKV/5INuzwp9BGaR5nH2s+jTq9POluF6uJdDoS0nqqgpe496DbloE7?=
 =?us-ascii?Q?00ZBsjqdqNMo/19vIrGRiuIHpunRHhAcGPmnIHCLQqqY9omkCaml4Rfg13F8?=
 =?us-ascii?Q?xgULk49zSlEFPA/cyTgfkeF2PvhtyZNo30S6IyIpO2ndbpumaFikSHJFrflD?=
 =?us-ascii?Q?CpP2aJIDFDM0vr0s24D8zd8wU5RqFRp7fCjU32nNg77ZzJu8CvpMtXX2PICl?=
 =?us-ascii?Q?5bJnC7JWABemOUkEfiP0VPOtAqqGF1MglxeosJbRPjClO0Nxgx1VGlbVkHOD?=
 =?us-ascii?Q?hcavaypIa/Hb4KUSmffY8k2J3PKLgfg5ltMg0z/fx+dyUN32GwpemrC8l05o?=
 =?us-ascii?Q?XAD71LDfu52CSAx4WDKGzARZsfEUc/Fn6kdmbxL6IOkH3VAeK2enab4JcJN4?=
 =?us-ascii?Q?lqoE65Lg59zhcp26iIpiMMkeiMGxe8W1S9ZQ33fNYZIB1nMSENpkYw9lhWQq?=
 =?us-ascii?Q?oqohY68ilu6yMjAUeZs8Nz9UAMzV1C+bTWrszVvf18NjZrIUHcqIHQcmWqFS?=
 =?us-ascii?Q?8aUUXyu4VNyOPFOQSQVK/vwBVxBL4y/zRS4gAp6cm1whDzKp8g2Y0pg2sQRt?=
 =?us-ascii?Q?+xcz9UpN2HZKyySJz9uQ7ugNat9Hw7eLAI7GgmDIMfnYPMowYvuK+WzBW4k8?=
 =?us-ascii?Q?SEBUJ33apQDxjQzjZtT96JpDtPuMVyiN1zFAGk1kDMuLpnYSpMikVKCjTMXw?=
 =?us-ascii?Q?eRdCd4H74cg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b9aNEFJBrV33ZuKmeN8Gwy59XG7M5iDU7ibJsnRHdJP8nvZNynf3mGKAIKsf?=
 =?us-ascii?Q?I2DjkGdeIVldWSiNNNCSIWiwbnCslot7RQcfXT2Ixwc/fajlkFFBWaTiDsJQ?=
 =?us-ascii?Q?XkVw3+0s8XHLEeRde0vt/a9xdTYjIXbnrLRkaD+B9S3Suj3/bizfumZJw+06?=
 =?us-ascii?Q?a2O4JhvuHnHnVdjv061RqyQdOu8mmdMEugEJrzwaWbtBD2y4fm+t3sO6ZXh6?=
 =?us-ascii?Q?x0B9soJwSF50Rmmv8Ke7zVfrR8IydCO2Q5oEYb8btJR7oGRgFNDtp8BsnOLB?=
 =?us-ascii?Q?QsGWu0nfTOlbOCRXmZ8vn4UEpJ/sXxFRCR3w9mSvJVMXfGhUQ71XHVgjQ7Wx?=
 =?us-ascii?Q?OK2c70n1u//aJ1zZNL+bjPkHE6Kp8P1ZleMfoAY510hBYTX6Oad115csOxEF?=
 =?us-ascii?Q?wTbl/k1ourRM2QNnwbFDm0daRRhXpUtmm8z83/WbCvp91tV3wt7Y1stNd1iZ?=
 =?us-ascii?Q?71dDfmYeOkkJeJVbAmWwQKVoAyq5JohG9jwHx7DCJJJrda2Awo6WIiNMYv1q?=
 =?us-ascii?Q?gkuqEVswgVQUgRKxtskpn4GZODIsf710jOK71KQr4BNSIzgTIImJ/iDkUKaa?=
 =?us-ascii?Q?fV4vq+uFJAwWEiw0CpiXBklBX6JRqQ12UlkbyRc/2P/IGwlNWiSauQFWgBUx?=
 =?us-ascii?Q?W4dOZ+v5SEPhfjv1uH1TsG5zoMigp+yqRuUpi+YeCGY4N7I1AU7ch54Az4lW?=
 =?us-ascii?Q?/nc15yHTYNEbwp7S2vow/Xp87O02MzIk/An9FIpgRdkKN/rBtIWQLTLKXWyv?=
 =?us-ascii?Q?NhKzsn4wqUB72dQCkJBBQdnKJHK1y/8eXOqyAMXGLt539aQ2zxlDDte1iONW?=
 =?us-ascii?Q?XQLoo1tlwgYnbBSDHzM0z6MihnhEIl6irhgDqmykIUypNSn4i0ePbMc3FaWl?=
 =?us-ascii?Q?+eW5VZ5dbK+dazwXvj9p5trrpBdf3GVyyjIBDYevqyn56nWFmiSKd7q3i4+p?=
 =?us-ascii?Q?Dzss5lhFCld0XGLYBrMQfQ3EkpoBCbJT6Ici+pu1Rz+KmL4OVMU75Qh1kNl8?=
 =?us-ascii?Q?dbM+kb5uFC5nAOjFMclqKYFUukYL5/ZoqbVYAwMPamB8xTGMAGGteaAkm0Wj?=
 =?us-ascii?Q?LIakFPdqhK3UWa0PWVNbOeKGXwO66pr24hssuU1CkNT3npKPpAQUd63Sgv4c?=
 =?us-ascii?Q?VkBTTqMN24879DnCYc8xDLn8B3ist7i8xHLhcBlMTurQb5iYkWn+/B7A16mi?=
 =?us-ascii?Q?VHaVf0mTtyvfq2BpZL3+CVN4dxuVBVVVrChpa9H9PtaaNfS+M+HBVGDPA3Tx?=
 =?us-ascii?Q?Cf9Ah5eoScsbaKeA89kX1mBi7C3DajK4v/MjYXxsM7JOauVd3qpLPoakdwxb?=
 =?us-ascii?Q?TgcWYP516plIUsY4+t3/vLgHGGIsTNQ/T/CebriAA1B+y+IEIetjDmScTI8o?=
 =?us-ascii?Q?d4zAq8ULstv4NGLkQjDKqS9TRLbMmJH/l67pceycGlbd7sLWpJgO2o6urgwd?=
 =?us-ascii?Q?mwlFu5hAQWebtkCHVJjE/6NmNcd5w7X07NywUqXWwIbhLDeyxL6rwVGIXeD7?=
 =?us-ascii?Q?29bm1WsphtBZgAw6Cwnlcvyhjuttx4uIBKERiUn4VpCsFECUn6RM5ebPOHPK?=
 =?us-ascii?Q?JHDL6CKl7CrVdJpGKMvevXqCUH9IaLI9Hhlm001W?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c5b6111-119d-4b2d-a234-08ddc0a81f39
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 18:24:06.8666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6jdiFRs5mdDQxIOpvEZafQaiySA9I0iAbRXmLUMmGkD20/paMYsp6iEf+y/Xw3Nr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB9016

Instead of open coding the ref_count calculation, use
folio_expected_ref_count().

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/huge_memory.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 818a6bd9f0d4..57e5699cf638 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3739,6 +3739,7 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 	if (folio_ref_freeze(folio, 1 + extra_pins)) {
 		struct address_space *swap_cache = NULL;
 		struct lruvec *lruvec;
+		int expected_refs;
 
 		if (folio_order(folio) > 1 &&
 		    !list_empty(&folio->_deferred_list)) {
@@ -3809,11 +3810,8 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 		     new_folio = next) {
 			next = folio_next(new_folio);
 
-			folio_ref_unfreeze(
-				new_folio,
-				1 + ((mapping || swap_cache) ?
-					     folio_nr_pages(new_folio) :
-					     0));
+			expected_refs = folio_expected_ref_count(new_folio) + 1;
+			folio_ref_unfreeze(new_folio, expected_refs);
 
 			lru_add_split_folio(folio, new_folio, lruvec, list);
 
@@ -3843,8 +3841,8 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 		 * Otherwise, a parallel folio_try_get() can grab origin_folio
 		 * and its caller can see stale page cache entries.
 		 */
-		folio_ref_unfreeze(folio, 1 +
-			((mapping || swap_cache) ? folio_nr_pages(folio) : 0));
+		expected_refs = folio_expected_ref_count(folio) + 1;
+		folio_ref_unfreeze(folio, expected_refs);
 
 		unlock_page_lruvec(lruvec);
 
-- 
2.47.2


