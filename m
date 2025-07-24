Return-Path: <linux-kernel+bounces-743881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73CBBB104FE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 10:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FFC8AE2610
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 08:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D93286408;
	Thu, 24 Jul 2025 08:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="p7sf7qHL"
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013018.outbound.protection.outlook.com [52.101.127.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8491C285C81
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 08:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753346785; cv=fail; b=hH5D/4EPq9ZDftIP8Jetq4Dz0IO6FWBZCe5NyLF5HGf6iYZWYCM1fM30yB5TOVl24B7UCuacWZipotxfde4glmlfJe5oCse4UiZ+VL6MLq3CeaGk6aJTR2EvWdkEI+cUGIe7OzzbXaRbDhiJuRSiye5sRgrVJfeZhKLb8vziuc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753346785; c=relaxed/simple;
	bh=eegS62Ka8gOj2qFGeAupE5unbYN8yUWVik35vwn1Kjw=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KGJDYb1DK5W/wPzLcxYVmj4+tklLMRlo+/WCUqAC6CPdD8P/wqx2IDuF8OaijGkhAQrBtZ/YEdfcYsd9A07MsihxVl2FgHqXLrVdDKrzu/7FJFOLXKenrycqzJHqhTR3y/Fo+oDqJx9sJkXBAqYku3esn7hRPdRJsr83KAJdC4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=p7sf7qHL; arc=fail smtp.client-ip=52.101.127.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nabecgFGNt+4V35sh+BlWsl1zic4nCLWYB7Rkujmwa2stY7TZjejm2cvs97vCDQzEmuJiEwwOd8gRkqqWC7Xid3FPzxfNo+Wyko14OagM81Azk+0R8GeOx/dLUA/p1xbb1F4tck2sH4LLnmgN6ed7vDF8voTBjUaIYysHxIcW+kZFKbgoghl+lsLTEVh615M7oSSLCxcQK0a4PHEwU20Z3a3E43FhU9vkAdrA5Y7GdjzU1Lme6R9vDqKzTyyo3gNFyAfr0mZL4Y+dHBiCCegRW/aXkpJzY1kcWkCPNWeaSHEgTv54C+YCkF9b8TfOniw0jYwnFh83+3rL67oo80sPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HGewVQ0hIgVjWInkYlPJJ7fIWpgVBdLoeoJ178mAeo4=;
 b=n/7h0itNPBK+Irg7ZM57H8Ex24V9Q1b3f1d6uQUfigiZ2uM1di0wla5ZJGEbFM1Z/ykOo6ApoLU1Aw8guKiTcIHAXex1nUaJ9dQsiVR+lBSSRiaseH1vE+7qOl4kGfqYxWBQuzLJiblfloOiFKm1F3m1E3HwkDg2yLVAAAVeXNcDKVPcQWpC1xFT60HZvMDg3zwdLLgvZEYENXFm7PmKMWAhfZEZdxyoWV8KLUCmYGDXL3Tf9jQmVbbt5HYMIg8S5mmnXWOnl6xdASIafG+MWnfQK9Ileh1sidwXWRzW4eH7vZN4FK0Oq3lotJUP/AP4GgJ32VU/c3yJeIhpA8FV8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HGewVQ0hIgVjWInkYlPJJ7fIWpgVBdLoeoJ178mAeo4=;
 b=p7sf7qHLtC9oLPtWrSX5gbkwg6X4eze6CKO7ReB3L47+oq8/euL+nA3ZziZEKD2Qu2L43O+MIb0Cmm4xheW5DI/ToisRY2ycCbSNaHRhfNmlKU+Bz5IbsKXVu81DFhlmJXgWOVygF0HWnPBHAeu1fjejZyVR/QxGt4gKiGXWjw096I4pWyyK+dl8qTeWKbzYsgbWXSFMmj9/TJ7KeRDIgBG9yp+lCyj/aQZPpigMF3bUI7czP9V6G/NtFBacJ5veXolQnCWzLmEFwtC2hqNkHPkbEJD1qQ1alvojmwDELSsv8n4oMomhZA8CHqe2rdguNgeM4vVAaLkNUJv51J6eWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by PS1PPF2A261C07C.apcprd06.prod.outlook.com (2603:1096:308::247) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Thu, 24 Jul
 2025 08:46:21 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f%4]) with mapi id 15.20.8943.029; Thu, 24 Jul 2025
 08:46:21 +0000
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
Subject: [RFC PATCH 7/9] mm/migrate: rename rmap_walk_arg folio
Date: Thu, 24 Jul 2025 16:44:35 +0800
Message-Id: <20250724084441.380404-8-link@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 06f48bf4-07a7-4626-68a9-08ddca8e900e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yx5sOMybJdMGjKUmU7XbUpCapv3tU/fW2km2ryex7tj9XMs3Qjb2A3wuyZ6w?=
 =?us-ascii?Q?o5Dg5QqzW+vRV7OFDu6mInTEHF559mEMPTM2D8Qo8xXgch5/YsR81B1mQAMO?=
 =?us-ascii?Q?yxrJZzL1ObRD/0dvk5k3GPeyXphg9aVbC54is9lxg7KS1nrH1wFswN1rhAEk?=
 =?us-ascii?Q?/OqngHIRn5LBnySxmEnThyT5tk5p3i/p14err5nIw9p1+cPu/C/tVILzfSaY?=
 =?us-ascii?Q?hHwE8yKLD2Axwarxqd+wyc8+AgYVgPdRt8Z7BE98frbM3xahpju2Bc//NHH6?=
 =?us-ascii?Q?vDK3O03ffLOh7EtbAQADMKBKdX5+CS9C4nm0wPBw9bOmZyNoONCncsvB47vE?=
 =?us-ascii?Q?D6EdV4msewt/TKcirA0Wg1vLpFwyw28mXDAAJ2QM9WEVctODv5bONfiSmJVM?=
 =?us-ascii?Q?wwQ79wloTfEqr/OH9swWdMLaxKtdYjRovTjnqNwvJ+lcRHm/t5ZDnSrwDwEj?=
 =?us-ascii?Q?8hC4RCx0SXT+TlXa1VxMEbWjIAWJHAJq63hz0J0Z8R9hEburuf7F0q3LqdDP?=
 =?us-ascii?Q?fBvMeyTnmBijGFlHJsrn0UAMnSv25pIsR+01pniDC2sknZy9D+BG1mrNtF19?=
 =?us-ascii?Q?RhlGMrh4AEdLUdot1EXOon3vLKWiugRr+YVbggqrtNGcEFjnnVJ7XArxFfx+?=
 =?us-ascii?Q?KCgMUVI3l3Xu0K0Mh81rmLySj443p6lcYJhft2TYtwYmTO8vZz/qN/9uRnl6?=
 =?us-ascii?Q?PK4Buxo9Aun5R6XQp+YpMvSJLpCNgApH3S9/q8KPFeCMQVlOJH9JSxV+WOV/?=
 =?us-ascii?Q?ixet6Sa17K/Dbs/yOgTxHVRugNORSHNE8DTm00p0qDgK68kW2JRlDoMnZF/h?=
 =?us-ascii?Q?xCzSRmBeTw5PxTRB7mb34grIlM3kdThnlo11p/pkQEewnrK6/X6qkgTjPhs0?=
 =?us-ascii?Q?KBCMwDsp1aDA3Ngx/+N7QfkN9bGWz1dQTBEtL2l4vK6B9HZd8fUJTYY13/JF?=
 =?us-ascii?Q?X9J0DKY9KyL+9K6yTZEIS/LaMh0IG/Tc9zySmm+WHj5hvO6jta36BtDrydUp?=
 =?us-ascii?Q?W8XPBU1kmN/la0Mp7+M98Cq4tvBy8wu7M5EPX4e6Lw9JKAZt/LFhSDrIXdfV?=
 =?us-ascii?Q?4ctIIqkCsb505DrncMyOJlsoWnqo4eIZWv8G0YaH+lpqo1Z5N+vJ5lfQ0Ii8?=
 =?us-ascii?Q?FNM4RO83/V06u3IFcF4spjmIqtNYSxPlfnDImlTgAm8gSZOGYwFkNkfFuyng?=
 =?us-ascii?Q?IllOpUKeAp0FI0j5HDacHgeUz8hgf5QHCbLQB6SFU4d9zWQngSnk5FshN1O0?=
 =?us-ascii?Q?ZXB/8Nrq3ZSFDG/jGWEYgoP4iLepvEGZJvFOHLRogxvxqnXm3d490+m0C8gu?=
 =?us-ascii?Q?xQ5k/cnepRRpNMYgWB+XH0vLc6m6gHOPcmTr9wf0DLAWDXbk5n4lIa/i0Yoq?=
 =?us-ascii?Q?kt0sI1Gvpx7FVm2bTJs6AHR4/ERWqR9qENUuzdmGOWsFB8dj7IXSEKV8FG7w?=
 =?us-ascii?Q?xzZCjycbareVdHHA2O1N3qCh3iW7A4IMdbtM0i1MFFPWYk0Z+gy/w4bMcsYs?=
 =?us-ascii?Q?aPyJLdySVUZ9okI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BG7QdO07zovQh09GuPfBoUvM6Am9MI0Qr7zhXnsTdu6MJT16pfANIR12w4N5?=
 =?us-ascii?Q?EmlyiF27BNTUyApF4s6YgTEva6PZaI81Dn9+AA3u6L1w/Q4N+Gm5UPp0KoG5?=
 =?us-ascii?Q?1CPfDFtrlUNvhyRK4MN92Zxv91Y2xp2h37TG/pvoff4hML82bKB9fj53rxg6?=
 =?us-ascii?Q?fGGM0eOim5XJ23iD4Aq6W0NXw6Kg/sQCER3wr0uv/hXTL2nTWsvJB+zeClax?=
 =?us-ascii?Q?s2g7mDCRwK89Rn+upU9aeYStOSmfv0wNm+yP4MHGPyM8lAEyYCERSySfl6ve?=
 =?us-ascii?Q?ZSC5v2YAmipyAgRLIHDek6aNGZHv7nttxtRSAV7ushSVJ1UUssJ8c2KmG/TB?=
 =?us-ascii?Q?Eiyli8UzZOgiEDvXeVBGy+yJQKcl8vjks0GGNuV9h9j78krWBzJbMw0NvLVx?=
 =?us-ascii?Q?/d132b+sMz6/YuLYYxUn1fYwflF9U0xWRVlmNGatc/+b/3AQQ46PARhy3gvW?=
 =?us-ascii?Q?KWLQ3TajO3Nh7ZuHKRL5+U9tsj9YVYhO3deJfzJt/nxRWlFKB626sqkI0cj/?=
 =?us-ascii?Q?GUDE55rk1ywP0aKeqtlDhzgxXIrQesuxgOgPtCvuFrSdz/UQdCaCk/keBFih?=
 =?us-ascii?Q?q9yEruUKVD+HdLTTn4NMBJotHWiAPJf5s0y1AgVOwj46mmZ/QwVTJNxQ2WHj?=
 =?us-ascii?Q?RdXimIf8vUvV02xs55Iy+t5VIPFGhxeyaysvflRhqjPJjKEiuZDHV4jUELlU?=
 =?us-ascii?Q?/6XqakzgEcqt115Ud+FJbDM0JVsi0ENGxSBCNF2/+aCzewdaYTwcoi99XEQl?=
 =?us-ascii?Q?HvumN02T2euzcDcZlZ1s9n+e1z9vhuc8wEGraF0YbI9HDt5eDH8cvBHEpwvU?=
 =?us-ascii?Q?sUMoDD8ybUpAetc8yyh4Iw5zLvDbo2brz42qL2yIRvHA7E1YgiQu4ENfVJPn?=
 =?us-ascii?Q?ObelBCEBGXrLTNxCxv+oMHb2B/QD9iQWWj47RAOmajhYKa1Q7lMcxcC+K7/0?=
 =?us-ascii?Q?4cj+NB0/Qz9FUc2Yzszx+fLZF/REU1+8pWpTtU2vqay351OH/HRzOUk/mtSC?=
 =?us-ascii?Q?9HghVPQ4GmhGs6KwGrE1r8I9YKlfRhv8bAskNAXMJ8ybvh9Ns+U1lkBhymj9?=
 =?us-ascii?Q?gi2iDt7cbYrF9NxBRhxvdgdPuo0nTkUjj/A81byP6YnU7ISb7ViI3JKgbUmo?=
 =?us-ascii?Q?WuSrbGu10H8+rv/p6sR3r0Rwk7JpTn3ZEOsMLsomcLPBOV8GptQaH0IbVX7Y?=
 =?us-ascii?Q?36mG5kMz5ifMld+oQrG1r+l3IJcEAWy+aRX1ce8gFOqZ8ealgfFXd7hcc7wz?=
 =?us-ascii?Q?EKdqOTCWgkl1uKxGhLGppKPsLF0d54sIex9L/ia56qJUROJra/DQczsck92p?=
 =?us-ascii?Q?wFy+axecL0zKP56jALLj5YC6YqkZ97K9NKG4mMGMtvJjKLFJ0r8hjiZ3AoCy?=
 =?us-ascii?Q?3W/0DxrtWagXrYFx75GNOmqObXgiLn+FgxvE1q9kQvbnbAd/Q6kDYRloL/dt?=
 =?us-ascii?Q?eTNBpzp9lTA1KPIbyVGfBz51EA0TO8ff1Eni3UlxczgtMKKB7y2pVswkOpoI?=
 =?us-ascii?Q?oOKeS7y53skABkeIcUkZLe+d18wSsthTdB6D2LoH6a4FA+vXFz+UXTrTpm8D?=
 =?us-ascii?Q?txkhvQpQAPs97CTjKO8UlBE7pwVoQxPlCr3+K8wQ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06f48bf4-07a7-4626-68a9-08ddca8e900e
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 08:46:20.9295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +VgfJ0wgxRtrfbNBrSWFQ+ILyQLs7leIhPk+dHbGucwM5AUY+4gb19vYtMQYEI5zvR8IZo6Jpcr08d0vF3b81w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1PPF2A261C07C

The current naming of "folio" in rmap_walk_arg does not clearly reflect
the actual role of this parameter. This patch renames it to "src" to
distinguish it from the "folio" parameter in remove_migration_pte.

No functional change.

Signed-off-by: Huan Yang <link@vivo.com>
---
 mm/migrate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index a5a49af7857a..a5ea8fba2997 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -230,7 +230,7 @@ static bool try_to_map_unused_to_zeropage(struct page_vma_mapped_walk *pvmw,
 }
 
 struct rmap_walk_arg {
-	struct folio *folio;
+	struct folio *src;
 	bool map_unused_to_zeropage;
 };
 
@@ -241,7 +241,7 @@ static bool remove_migration_pte(struct folio *folio,
 		struct vm_area_struct *vma, unsigned long addr, void *arg)
 {
 	struct rmap_walk_arg *rmap_walk_arg = arg;
-	DEFINE_FOLIO_VMA_WALK(pvmw, rmap_walk_arg->folio, vma, addr, PVMW_SYNC | PVMW_MIGRATION);
+	DEFINE_FOLIO_VMA_WALK(pvmw, rmap_walk_arg->src, vma, addr, PVMW_SYNC | PVMW_MIGRATION);
 
 	while (page_vma_mapped_walk(&pvmw)) {
 		rmap_t rmap_flags = RMAP_NONE;
@@ -349,7 +349,7 @@ static bool remove_migration_pte(struct folio *folio,
 void remove_migration_ptes(struct folio *src, struct folio *dst, int flags)
 {
 	struct rmap_walk_arg rmap_walk_arg = {
-		.folio = src,
+		.src = src,
 		.map_unused_to_zeropage = flags & RMP_USE_SHARED_ZEROPAGE,
 	};
 
-- 
2.34.1


