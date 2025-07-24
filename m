Return-Path: <linux-kernel+bounces-743878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1EAEB104F4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 10:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9A7917528C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 08:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426FB283FE5;
	Thu, 24 Jul 2025 08:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Ok2DuZGl"
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012056.outbound.protection.outlook.com [52.101.126.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D2028152A
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 08:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753346768; cv=fail; b=Q2hz9rbyAQT9+yo33iTyZtmFbyqZQMiAwA891inozfxFKBDy8oZ86elGKh/O5A/iizoGRNToarZT+fAzqewIgg/FfM9i2Tj0u6nRIphqhNfO9ON1Us2US8KNP3L8Vq16k3J/14hLE3HYzUZXBo9LwATI+BInj1NwQHUGXbrR4fY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753346768; c=relaxed/simple;
	bh=zbs4M0deY81qjCh63ZjWZFu9HGageoIZ+PArrh2vjQc=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tYsXeDFGVwt2NOtSS9qhLmxTg2mc81F5ixvPACAIRt86LrXHvbaBUD9XfsDFb8mSyN9uyrnlg8roCKJjzcFXfYp1AOg6GuachP0JnVcE4Y4IahIr25WwUw8/dVdVtD8V3cTrBsEcdA6BDLSXU2/jzlt58tvpi4PrP2jDPIukLfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Ok2DuZGl; arc=fail smtp.client-ip=52.101.126.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TxMnukXvjlDkflzWm2lzH4lMZjx7kfy4aV5j9SbN2uKAFK56gYtZ5Wlx+5L/tXAok1LbnWzN/J6ZHfWc4PO3z6E00QQAwphauKZbboZe99pY8FbFgym5Nfh9v08zcat53ijVKhSUB9KyRowFToEz0vTeVzAHsXG1kgutrK+60FJpejcQJQ42Lny/LTlOA9w6d04PlFqjYaj6+qJxidecgcg2u5Q11iqL+fxI1wjtODa+tf2/jq5jJTqanjMpeihvNcWPZuxQhMyN96zoyoJetJnBch+tR8phWnUXIy0cRutfMzy7gZZBChWavinG8mOB6+UHY0GU0TlIQZZC+ES29Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w8vNQTxEiBGsHHcBYGEaSLVl0jn54V4X6W24zQBAnVM=;
 b=iyCJYsGD5YlNHBnIUb1WGFAAazxezQedXcryYGlHNiTSqlj+a/CLCKNDjlqwU8iIany2jJA1iPBtQpje0T2QsG0UyqWbNWHexp2v6pVB1fl6vrTTAavRiD2dFjBm+6sGsWp1dz0iQRWNoy2U40TPArfVqQhIlMoPEj4KzF5h15g5zAleLe9FHW2XCLzPdm5udH9rCq9BNZXMBPqRQVODJqMvSrKU7tZRpHANgt6E1BRmtqgV7cTH/qyb1ieT8s18HB7BtmovfqDGvDZFiunP5p9AKCwza22d27qx9NnjIuwcr+C3TsWYpHr3GZPcNN16F/KJnZOEQrVDYbThTdVBtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w8vNQTxEiBGsHHcBYGEaSLVl0jn54V4X6W24zQBAnVM=;
 b=Ok2DuZGlCPsbloDfKDT92UGrd3Km6BD1pNapSX/zafSmHI6RjHHoR7sEr5tDYPeZ9+m9xr2LNO2GnL6oM0xgFspww2nrvVeTsxEmgd85AG36o6H6UKZSoyxKVNoYWUBKJUxkrcTyEaJf7BVdOfLQwbncbZJsAI0Pphp90KSxPWtP1r7mdI4tRpaq4cXg1Nz3rI74mIwI2NvOFV1AGxCNtc1I+Gd7yzs2nh4FlhVnDW5ST1lvvlHMP62/ArYhVW2O5NIStb4igCkoE1eqYqA9nPBQ4c3QcQMGI8bAt4HIGH/F58OGCfP02eULJzSZ6NXByqHdX6uJxeyJuiuAfhJgxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by PS1PPF2A261C07C.apcprd06.prod.outlook.com (2603:1096:308::247) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Thu, 24 Jul
 2025 08:46:03 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f%4]) with mapi id 15.20.8943.029; Thu, 24 Jul 2025
 08:46:03 +0000
From: Huan Yang <link@vivo.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Rik van Riel <riel@surriel.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Harry Yoo <harry.yoo@oracle.com>,
	Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Zi Yan <ziy@nvidia.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Huan Yang <link@vivo.com>,
	Christian Brauner <brauner@kernel.org>,
	Usama Arif <usamaarif642@gmail.com>,
	Yu Zhao <yuzhao@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 4/9] mm/rmap: add args in rmap_walk_control done hook
Date: Thu, 24 Jul 2025 16:44:32 +0800
Message-Id: <20250724084441.380404-5-link@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250724084441.380404-1-link@vivo.com>
References: <20250724084441.380404-1-link@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWP286CA0006.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::16) To PUZPR06MB5676.apcprd06.prod.outlook.com
 (2603:1096:301:f8::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5676:EE_|PS1PPF2A261C07C:EE_
X-MS-Office365-Filtering-Correlation-Id: d183e51c-7cee-4c71-8519-08ddca8e85b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/mk8Pl1J4w5kYorFEYxfDIsY2FtGd/4Prk65Ms3W1PKsrR2Y6zzcenEysLBV?=
 =?us-ascii?Q?BGhgkh6hhSIrlQndvhFemj3UjZaXhigBthFjl972aYez4FEW47I5lod9NKXu?=
 =?us-ascii?Q?ZESLq/QTXLXHXJqbHiVC/pXo4F6+Zqgq58RlSaHK+VfCne1DUWauRe0jqvl3?=
 =?us-ascii?Q?tD5hIm4y1P0gTDuJTvju5t1tYCBw1FbNPVDhUzTtdqEuDK+PKImiNTQzwGW3?=
 =?us-ascii?Q?ifwVS3E73dG+T79Jkj9c7SDqAIxT+hnk/rSJ6X4fNpwVKqCg8IKbOCmUgf5h?=
 =?us-ascii?Q?uy/0nGXOdO4ogaJ7qBBBBovM2FC+DSHhSdQ9WKrxeqBYTRIn2eGmhV8/x/z+?=
 =?us-ascii?Q?hvyWx26w3JtYa8nKOweZzkkIPk4pFfm3nG8hlUSkm3BQFz3kCrmD8rEndxOB?=
 =?us-ascii?Q?QNmGXPzCDfugJtGo4spj3hLyc7/Nz02T/98nIqR/yVJjbR5l2M/3ReoVQMwH?=
 =?us-ascii?Q?BqnpOHnYll/CrFJ7dM431xuz8xaPH0XoKkOhXcipphy9p3vjs+U3WGOAtJ/Q?=
 =?us-ascii?Q?92Jg1JjpL1gsXuPW+y9Gun6R4rJY0UHHA8lURSw7Yljr23z7q6dQQlmodlky?=
 =?us-ascii?Q?CDu3u9Lw7shMv6WG72ave4xlO9eIcCzIZCq3PwNL9HArdW4Mztl/ZZvU6ANq?=
 =?us-ascii?Q?yf701oXAiXVrxI+MfNZPRisBvVIF0O/YuyE1opSgWAxmie6MObGLDZ9Q7/Ok?=
 =?us-ascii?Q?9lULxPScvddSk94fPdhcT8ppPX8l915qUzhIv3JaIR255CLn7lDe56qECTTL?=
 =?us-ascii?Q?JUOzBt1Q/utUA1KgdMaUld8NR81U29LUwbhfu9ZxTLP0fhJzlyYgqkSjEtpv?=
 =?us-ascii?Q?ONMwd2w/fwAQ3Z4W6ZGsy2iIzxOhguFkidxXNGrShgkAt/3oANywWvg35fqA?=
 =?us-ascii?Q?f22kjzm3su3/Zekdi71Y91phSNuHkm69dI3E44qEO5vHrS0ZtGuTCOwhPwwS?=
 =?us-ascii?Q?0YQVf4KXRjr8U+ZBXw7T5O6sk1T6RjempWN5NITnfS7PnFbLCtg16cfWy+kZ?=
 =?us-ascii?Q?3NCZzfTzhijeQxknvfc5y6HybpJQ+2BJUY6F6eoqI9ALg/igU86gV4i3MqnL?=
 =?us-ascii?Q?ccQNZWJW2whJRownuNAoSuct/AcHkV9BrukalZ5BPmpYToad0LUbmJCHVEK0?=
 =?us-ascii?Q?/LpP/M+2Vh8aFCS830oblVCj7GIwGOxpkeF3etVjTatPAQ2QKZMtcoGezplU?=
 =?us-ascii?Q?lbFTd46vR6xh0QbO8fWfxksy3snB9uahxUVH852KX0aKI0CfiV4xzxWEGeKX?=
 =?us-ascii?Q?5i1qQqNjuqowfbOKryAEURoGGxELFnw8maT6goUiU0mJFpe+8TmaBNkhKZlW?=
 =?us-ascii?Q?Oya1J5BfNW+j45ImTBMwsqeVvPKGxmvfLbM/35WuyCInET/9tMaLPOhjC7Ng?=
 =?us-ascii?Q?k43kkrcm5Xc11IQF9hFsZCeSmskCHbBcCU866piSYgEgXLRzhwLyM8zexwtf?=
 =?us-ascii?Q?m1s+Jkoqwm5fkbRY0A51uBhZ8efQrQ8sd0VBvJCDIdFOsmBmYyRIy2RSuDNG?=
 =?us-ascii?Q?1K5JGZXtjQUkIMk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9hNSVi4irf+Kp6C68XbqqOzdATIREJn0CrnuW16r9wkHrqFLqL4xbPdR9ex1?=
 =?us-ascii?Q?oEq0iOnQF0xV1K9HSKbLRXf0mBCecZmAp9SX+bN5ES2Ivh6IQn6z80bTnMgM?=
 =?us-ascii?Q?WwHA0PwSBTSKPRC1sPyHCpUPHWLsh+Zod4XIyIcxnNTnPwkmblJLSjF5oJGS?=
 =?us-ascii?Q?6K6ZbkkuVtsB8UdiLiQ3jUujZz462dOfd1XLkSSBRSMDQrMU3jBTNqlNm3Gu?=
 =?us-ascii?Q?tiAGOGxkH+NVANqzBZ1pI2Py6KSSCKxCnDkbW0mpTcol7fwyrZZzBXwqzRcO?=
 =?us-ascii?Q?ttqlv96iBOzMzRhzip6XNzxdQZ2Fz1a/PXTU7Im5SA6l540/M9Xv7M72uAAq?=
 =?us-ascii?Q?4UO1ObA6hnDk6voKiG/gO0HJQIRe+mGACj9zXyyW5hG4KkZCcUD0nLxu3iZ9?=
 =?us-ascii?Q?GQB5ntAKbadQ7yIoeihdYfSyNpGLCVms8+t/s3jln5104DqsbFwj7Idb+wTA?=
 =?us-ascii?Q?A7pAl16W7dBgR9MTlBWmQzU/LLnPctGxa//gGCvw4pOejJXZDyAsRJoTl03K?=
 =?us-ascii?Q?jTreFeqmMMlFm51Wvcg4bMDb3KQNEMuXZ0AOND3RvKp0YaRP5ygekZ7ICS7m?=
 =?us-ascii?Q?6HbZby8qCgfDDE3/NxI+QSf3qlrwykbD+S8skRPSDv1NcRsDdBeZs90XHTMV?=
 =?us-ascii?Q?Vrf/Z81KgUzFRn1cXgJeokGNv43IcZ7EoaglZ+/d39F/niGVo0wKq2G51SkS?=
 =?us-ascii?Q?JLTfnO1xMSTVyOE4ozG6LV7E4LF2ZCBtPfRO9GquzAjss10k4Ckf7oZUCMIB?=
 =?us-ascii?Q?rImftFMl2DU7VxTsvdWmyEuT/800IPMh9tdgpuhNRq6noKlQ+AMGGYDiqEQt?=
 =?us-ascii?Q?H/ZcxskbjHaEJIjeEIbBBOfQSRUbkUTrOMkwcthvfSY7rwAMBpgHZjRcirBO?=
 =?us-ascii?Q?ZlH7M0pzQ+SDU/xp7Axvvw1hiQ0FkAGKt4j71S72AAcnwdUuFTGfhwzjkaEJ?=
 =?us-ascii?Q?kXtXM6LXddmYZdw36DyPHoHRjFYywI71+FKkvEidLp5pUWbTEklEow5QSYQq?=
 =?us-ascii?Q?Qa7gF+2eMYRKhCNjvID/mpglvmQGLqngCBbTS2fFnDm7B9MsgRQe5BorG56S?=
 =?us-ascii?Q?91trxW+QRxek5fIVofuNIMTHYLpKQnPgz9VkqaMlP8ugpQHJIjLa2cVy7J/Q?=
 =?us-ascii?Q?QmskvqikrJFyghn9TTibsU0Az0zFnA5rU3j5lvKdYlYEDMy076YaLxUUaAuB?=
 =?us-ascii?Q?u6wNUsmAC2fn0E5E3m/m0GHyeB7bvJib5CwgiK24k+kPS8N3oU8UKxd0as1J?=
 =?us-ascii?Q?ZWumi4ybdMoax8V6+eHDklNNR/lkv2pE6Lw5kJDHeJiGJeHkgxcY7Zo3X1fe?=
 =?us-ascii?Q?wVlimTljVwWtubUdAbrWE0j4TARmloSBGQS0gSSrBlVW5mJeF9XWE8Y7NVWU?=
 =?us-ascii?Q?oC2DAXWIRtCE+U4jv9hAEemswpGq4ca/n+au6O0CZmB7gbRZvmpsm36Zhg+c?=
 =?us-ascii?Q?cWW7PTVlX80e4pdlTWscBqYF/GHNnABcoGaUWPTtM0OMLLM6Us6XHAs7l81z?=
 =?us-ascii?Q?wcLElPmbh+Cc7NqIY+2Z+9cgzNV3rCwdcsudx5WnBnGPoeGV+XvdHWbZ0Igg?=
 =?us-ascii?Q?rut0OITfW+5O+31w9iGdsnjXQKbyOV/3/ODtJHmK?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d183e51c-7cee-4c71-8519-08ddca8e85b6
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 08:46:03.6028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jTWFXfafncaAwJrHO+omnMZkO5PzwKh9+A76IrwpPmGZ8TIbMkdBhcg41xw0b/SKzXOJLKSdeCSd7+CAert/aA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1PPF2A261C07C

In the done hook that determines whether rmap_walk can terminate the
traversal early, we may need to read parameters from rmap_walk_control
to assist in this decision.

This patch adds the rmap_walk_control as a parameter to the done hook.

Signed-off-by: Huan Yang <link@vivo.com>
---
 include/linux/rmap.h | 2 +-
 mm/ksm.c             | 2 +-
 mm/rmap.c            | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index f0d17c971a20..a305811d6310 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -1013,7 +1013,7 @@ struct rmap_walk_control {
 	 */
 	bool (*rmap_one)(struct folio *folio, struct vm_area_struct *vma,
 					unsigned long addr, void *arg);
-	int (*done)(struct folio *folio);
+	int (*done)(struct folio *folio, struct rmap_walk_control *rwc);
 	struct anon_vma *(*anon_lock)(const struct folio *folio,
 				      struct rmap_walk_control *rwc);
 	bool (*invalid_vma)(struct vm_area_struct *vma, void *arg);
diff --git a/mm/ksm.c b/mm/ksm.c
index ef73b25fd65a..635fe402af91 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -3072,7 +3072,7 @@ void rmap_walk_ksm(struct folio *folio, struct rmap_walk_control *rwc)
 				anon_vma_unlock_read(anon_vma);
 				return;
 			}
-			if (rwc->done && rwc->done(folio)) {
+			if (rwc->done && rwc->done(folio, rwc)) {
 				anon_vma_unlock_read(anon_vma);
 				return;
 			}
diff --git a/mm/rmap.c b/mm/rmap.c
index bae9f79c7dc9..e590f4071eca 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -2232,7 +2232,7 @@ static bool invalid_migration_vma(struct vm_area_struct *vma, void *arg)
 	return vma_is_temporary_stack(vma);
 }
 
-static int folio_not_mapped(struct folio *folio)
+static int folio_not_mapped(struct folio *folio, struct rmap_walk_control *rwc)
 {
 	return !folio_mapped(folio);
 }
@@ -2828,7 +2828,7 @@ static void rmap_walk_anon(struct folio *folio, struct rmap_walk_control *rwc)
 
 		if (!rwc->rmap_one(folio, vma, address, rwc->arg))
 			break;
-		if (rwc->done && rwc->done(folio))
+		if (rwc->done && rwc->done(folio, rwc))
 			break;
 	}
 
@@ -2891,7 +2891,7 @@ static void __rmap_walk_file(struct folio *folio, struct address_space *mapping,
 
 		if (!rwc->rmap_one(folio, vma, address, rwc->arg))
 			goto done;
-		if (rwc->done && rwc->done(folio))
+		if (rwc->done && rwc->done(folio, rwc))
 			goto done;
 	}
 done:
-- 
2.34.1


