Return-Path: <linux-kernel+bounces-730559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F943B0464C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 19:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52FF11A62362
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 17:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA5A26462A;
	Mon, 14 Jul 2025 17:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ChWSVnvI"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15E1263C9B
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 17:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752513517; cv=fail; b=uhJSVmaSswD6boK1nevkAhNHCxdcgizeMsmmgl69lHgPOhGqbc6ndlDSc+8Wi8yiN+9vz6MQSTsZwMBeZeUtj4KBP5UGhmJ6C4U9Nyfv1G/LdCxZQyXSGcQBIL1pXGqNT2tKPh8sDhUm1Vc9Cq0yFs37qiwylNYMoine5WJzVFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752513517; c=relaxed/simple;
	bh=l/2bYxe3gW1MhcNNo3MuVZLLrvoODvZyFmuFXI6T6vs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZUQhSIP/cfvfze+xpmDb/4DGXhcckxIUsv/TO7YB7Bs1SOxqlxt64z/JerjNVTylC4UKW4zhCnVwVD3M0LiM9bGWWoyoSXa2aWWyhCD9tPaVGeEmY6Cr70nPdXjujWNtzx2wits9Uk2iBfQRMwt/FxyD+Yyv9QfnnVmJY1VLWaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ChWSVnvI; arc=fail smtp.client-ip=40.107.244.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b3EyHdSlwLRZdvV8HkdYgtwqIByjEZLAO+PQmYfJHFRHyu7iI/U5eGp3ofEvOSaeKQl4H+3U7la3hH2nsmRH7R+aAyjDu7g9WwRNd60Q/LGGRXMamj94k1d2RqbMwhiHMEOULt1QR+2qYpYS53zUQVX0dbhjq2R0/rR/RR5MMewOcwv2ZtZj1l4OgEzl9G1lzfXGlCfI2rD3IDt6NA6gEixA3VuBxX0F41MkSG8izzruhnp5meRgmMcFxx0sO06C03Nf/KqBPCXVU0t+85ldUJb0yNyIluxASrQC/jAI4WYV3B9b+avWefjd4OZzCSCH3Szdt0vjoI4FrSbyqz20cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q2esnnW38LLW5ObEtwopD/ey0Uzj7cjgwq2nhxOYlGI=;
 b=c6c1D52hlMsWlt4VEHKlaJqkrk+IeeFEzfqtiTJidTmqgvRiZ7iAHLTiTKlYZemu4MpyIQ+7XL6q8lIqjxFgx4S+4jbPhNOGsj/X0JFKPld75lCwo4ZO1ki1v5ingxWhsv187EmLbsovO42+Y1juH47zkBOXOs2UqfbV0580Ppo5tNAaZ5mmf2Wwb4sv9ZbzkjJ6/IWrMlUow7XP7tYe2b5MJZHLzstJTymI2RSXpLPfBApdDx5gYqGLkbAg31VwpKe/ahsTHuxJTDnw5ny2j4wR181zviF9EIuuboee/r+jKQSUz+zgVWyBq2tUU8kjKFSNzGiT3PeRqcA+YQtOIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q2esnnW38LLW5ObEtwopD/ey0Uzj7cjgwq2nhxOYlGI=;
 b=ChWSVnvIzthGO2lNBkxa8WY1xBqmnX98E73jzFY7c2nEQZmwWiJ8hw9UaE7UqvGtlyuQ5DlqcDhjYHF0zAwPHdKhqRI29Pjbn+BfmUrAnNJ6E8TEy2dS3UzUNXL73zBAavDZZXUcF0tKTOg0FXtG8/nhDKtUlQJMxMtIhJAod0uh07JeftF8VXqWhxuwwUKVmMJq/GrsmsciA0CQOuF2U3ImcJywq4SFLCd9z8rJFsQlmQpRGV117y8tU9dvcDp4sZqPeJODi9kFGCzKskLPWZ2r/o0qt4iTEMfEJkjd5ZaZBDN535LJdrabHQ+EnGvT++e4F7XAUnTOXqJLZ279EQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SA3PR12MB9225.namprd12.prod.outlook.com (2603:10b6:806:39e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Mon, 14 Jul
 2025 17:18:32 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.8922.023; Mon, 14 Jul 2025
 17:18:32 +0000
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
Subject: [PATCH v3 2/2] mm/huge_memory: use folio_expected_ref_count() to calculate ref_count.
Date: Mon, 14 Jul 2025 13:18:23 -0400
Message-ID: <20250714171823.3626213-3-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250714171823.3626213-1-ziy@nvidia.com>
References: <20250714171823.3626213-1-ziy@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1P222CA0014.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::19) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SA3PR12MB9225:EE_
X-MS-Office365-Filtering-Correlation-Id: d320fc66-6a54-45ec-0244-08ddc2fa7552
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l4qEzjd7z7viyCs4u2xchN5RWvbKFlsLu52JRutj0lH4zILtJex+1tA+JlLt?=
 =?us-ascii?Q?MgmPN+XokoA+A9Gmf20eg80k6z2lv77lvP4f6uToZE89/7P8+cJ/z7en6D8c?=
 =?us-ascii?Q?P0548Ohcskp4dHx+zuavmcm25HFQZGbLvVQfHw6gnauOEoZi3kNSKJUW30WT?=
 =?us-ascii?Q?3ryYMMhDD0sEfOf+q4BtTjVBuutlZRVV2PUMjGSQfWpzb9hqICxwwSy6VVO3?=
 =?us-ascii?Q?SHv4CmA22uDWoYCtmsiONLGNxAmrULZlRNyYa22HcMT6kTRj5LhTO8XEWF/2?=
 =?us-ascii?Q?i0IwV2LD5AcHv61Zmk6kEC709FKVRZglWrGM98JI+nPeMEmfKo4/PJvcK7Ro?=
 =?us-ascii?Q?TmfgkGUzEwIqTUg5jqZDmgYbKaQ3onrFJfG1GdLiwsmpwuEWM7YKqGvZsBxj?=
 =?us-ascii?Q?D78cSCZ5d4bK23Iq82KMt/0MMpyVhamuTvuG0PCG0bOsZL9y9xNz2Cq72sfr?=
 =?us-ascii?Q?bDASfIDdkOv5iB+zwzpGetuczyDXl86xMCgEiIcoHs2Cv3EzHK3mGjCIfkCn?=
 =?us-ascii?Q?R4T9ylyS5D8GBXFrcmj9UNHo9FOYG/n/P4xJV2wkUHXGhNUVJLz1Ai2Cx9HR?=
 =?us-ascii?Q?WpyVlJCFK8ZhvDvlcXt+Jq9nbH/KIK0XrOoZLJXPtSE2gD3vqEJzz+SVRJzZ?=
 =?us-ascii?Q?cwAnobY4iCDjOI1Ef/f+7WrI+P0s6knJduxxlqupWp7Hwu5FUWnCkB1XLaCK?=
 =?us-ascii?Q?80hd6sn/wkIY/GPr5VOAUpWsour89uWcYnVinCbQKC7XgVfyV6OpeQmtSEK3?=
 =?us-ascii?Q?ulZm0XTSjkMTMR32Q/5weBgE3RToJ7iHk/aNiJMWHmBNDH3mo7ogPkzZaktp?=
 =?us-ascii?Q?ZkuhwiJP7sbPMAy+XB8VepPM/z6li+sMiEeqqN7KoCMUE8SLPmySW7Wg1MF+?=
 =?us-ascii?Q?3g3Q7cAYuhPLD5TThAqyh1xf9ffKfGdluRhR3jC/+fVFhPfPr47I2ySpAies?=
 =?us-ascii?Q?XsAi13TB0RaGk/q5m+Xgpsss6GX1qu8A1YohqNJdcBFh2R+dj2XkrrqHjULR?=
 =?us-ascii?Q?g0STf1cqIfzBdV4cpm0IgeUO5bkRRFbKhdQ4xifsnr4g3dCgEro3PPB5gR6B?=
 =?us-ascii?Q?f67UORVJME1j0YNjsoN3T6s6OelTs2xAnYK4UjnIh8+xBMkSvWyASEuESPRv?=
 =?us-ascii?Q?nU0W/piSIUvnv562z2MRTBP3WXxhTPWqmULBLRIHtJ36GfHW5S+wHThU3cnY?=
 =?us-ascii?Q?A8aFBseClPTUm+hYkn8OKhC0DllgFXa4Euwl2wRwLdbyEf2nhpBrBK/vLjMA?=
 =?us-ascii?Q?19R1DuYcD39nqIOnGYBCsBJDdBVWskc29xShJWxHIlfRQrI6qyVT9k+uodfy?=
 =?us-ascii?Q?utyoChmXYXqX7OEEX8kOst1EaMs24uS8yr//QJ7e8AYG1BjpgIr0WGyuvNFF?=
 =?us-ascii?Q?0gziljMF6YOJ8AmTxAqH14fVIQ/ksuoxT4DjY7u46RMhSABBuwMwxAZAAfMH?=
 =?us-ascii?Q?R3wt+xr98y0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gP89Lk+eu++wJm+7YSpvJQ38b+Zcye/bNCLkBFwRw7KqQvLySn+9hTcMdYNm?=
 =?us-ascii?Q?UnsRPc4M2/QnS+D6laGrz4cXWRIcFI0Eh8XlfdyoU76eMvrhaxwwRWXKgs8m?=
 =?us-ascii?Q?VIney7t2d4npxuYCsy6/0MwZm8T7Th+thLr/tCd82RsoZUMrWjje98FQn685?=
 =?us-ascii?Q?lhZSYHAXH4EoYW1wYrzuTpT3QjMXHSWJ265sAYl6b5Vh5jiU4XcxywdpwACq?=
 =?us-ascii?Q?X6YKk8DXtih/dkzubg5mB7Uh/TYJcmNy4YXnTzc0nLOcfV88TTUId3Se7qKN?=
 =?us-ascii?Q?DAnBHlBWyWg68cUiUXvuG2pq4Jelo00BZ1IWXPaJQ/cWQdWW9GFuGouA2TdV?=
 =?us-ascii?Q?wCbHrlRotEmZTaBcvIOG22Op0DBDncIDd/3tozb7vUu6E7gQU6T9ygk90zc+?=
 =?us-ascii?Q?9Xt0b+1osKNI+MGlHfkATwtSOiDJjvImDL6aVRVh8D/3LJFPK0NbflVKIzcn?=
 =?us-ascii?Q?EHmLitVOJHJGThZKER73+VIjfOGIyTAKohWEdp0vrTU8OZIT7cNzv7jTX1mO?=
 =?us-ascii?Q?R8xF4Ugv7ZW572dIysfJ8lydD99hp65HZAZbVlXPs3tjnaChQ2dNbc6nOSRK?=
 =?us-ascii?Q?AL8lfzutzliTjUR5TQJUhEbMIZyv5FXjp7BHTK8VzjrPX8SnplFhr95IlHlP?=
 =?us-ascii?Q?hhvClCKMgoMGI/wm8M70pG3X+H9gY7qEQ/WABV0VukaBvSmfY9AtLFNcT9vf?=
 =?us-ascii?Q?1VqCtw95RYvX2C5goDf3kWTw9vKfqjxFIlYgar4Ha74G1bFZGpSc+CTfj7R4?=
 =?us-ascii?Q?cH4qyqzEUhbM+gZZjo35AAzZ/ABU8r8Inx0AcLoY7w9hvfIvCQ2lT+FD1du5?=
 =?us-ascii?Q?3GW8oPbI9LeWRSuRF5dWQFvC3vs9mR4ecG1xYO3zDoSP193KXSgKAOZctRFj?=
 =?us-ascii?Q?UH5TCWcBKyChBE3AzLxHsMwfJVF/nU4KirhYTV35xplraAy7rRjnAyTiAdHT?=
 =?us-ascii?Q?01QJvOF02b81gWnGWgLA7Nj7mgwrPoDAmQBuvk8ChDzpPSzNHOcHX/2sOJoI?=
 =?us-ascii?Q?vDC0jujYDPMnmQWYorMob/dzVPEklpiBZszGoj9xb5V+gtpdm9ImVMJvoXL8?=
 =?us-ascii?Q?WgU4lPsYIwVnl6sispxomPFejjvY5FaEUSZFM9kIMm5srGNz11I3lu0s1AKi?=
 =?us-ascii?Q?pJoYIlbpXAuY4FDJUkhdcvJNHPl9dF9k3XKND3vuAF0D2NGC5r/4GjEUKm9+?=
 =?us-ascii?Q?uATk98oEPMaAKkDPk5EDGq+p/l25kPbeDqJyhxR7r6Ma9BXCbJPC9xVoxa02?=
 =?us-ascii?Q?gkZr8oNzbvvI6TGCfzkAPHNZagrz9An+TacArEMvEiDPRwzAEgARFCrUvs0E?=
 =?us-ascii?Q?rBgucqZ5SX7WrsbCF7C+xRTaS/J7kyYdEKSCqvWufXkf4IBknY6/Jcg+O0Ga?=
 =?us-ascii?Q?N2EdO2q/yCQGqjw+n+CQLRJ/P/crxZLA1EdjswGgySeYaGI1bFxa6uXu80Yf?=
 =?us-ascii?Q?xCL+I0lUC7oQNf65lOFIAi9KPHwT+JChc+ZpagK9rDBl1qiwZ50vZBkcRaI5?=
 =?us-ascii?Q?W72fxtB70wvg2sdPTdo1tLWH0MPUEQ/cDY415Hn4OVB+70TbgMDjUkMGOpoB?=
 =?us-ascii?Q?25ywoh9+vubBu/kloTnkUOUC4GnFtBdLM+qSTvwI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d320fc66-6a54-45ec-0244-08ddc2fa7552
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 17:18:32.3548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 61vl1D8tmaN2ZMZfOGLDDY4wfADnjnZm7uw+PdibIDerYodQ5Lx3IoayGCnJ9EGC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9225

Instead of open coding the ref_count calculation, use
folio_expected_ref_count().

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Zi Yan <ziy@nvidia.com>
Acked-by: Balbir Singh <balbirs@nvidia.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
 mm/huge_memory.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index a7ee731f974f..31b5c4e61a57 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3735,6 +3735,7 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 	if (folio_ref_freeze(folio, 1 + extra_pins)) {
 		struct address_space *swap_cache = NULL;
 		struct lruvec *lruvec;
+		int expected_refs;
 
 		if (folio_order(folio) > 1 &&
 		    !list_empty(&folio->_deferred_list)) {
@@ -3805,11 +3806,8 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
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
 
@@ -3839,8 +3837,8 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
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


