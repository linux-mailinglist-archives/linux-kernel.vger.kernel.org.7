Return-Path: <linux-kernel+bounces-734000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2AA7B07BCB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 19:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A505F7ABA68
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 17:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 818522F5C54;
	Wed, 16 Jul 2025 17:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QKAY6tBg"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2076.outbound.protection.outlook.com [40.107.101.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4682F5338
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 17:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752685894; cv=fail; b=kyFqM3aO+iA/z3Nv/uC9mUzakpcswoq36dMuCxS8Friq1zSrMZfICZcSE8u+1xg+bl2lTa1YyxFFRv6+7RsXH9jnU3zjaUS8WnUQxjqbu1IPOeV/1eKzK2sGXuQD6J6a5PKZHqBCkESZCGmsokCxB/49RY/zh22r0xZVXSA8cns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752685894; c=relaxed/simple;
	bh=BFJKseCdKlM2CWXWn5aRBKNszYWGkvlAWFfo1Xc/Snw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=CQLRok7orwr+NSa6cB7WBsRHctZ71eWzVtGyTymiXzPj/n/nc2oLh1sGgD1q7OUx9LbO7I/YvFkgno+kWBRMZjnOcYmlqVsw0EtJAtyEQGFr5e6PZj3nfhSJgwYQS1xLAx7tK3RackJt7WOUX09osNYIXbr02j0FrzFj5eojPtA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QKAY6tBg; arc=fail smtp.client-ip=40.107.101.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RByBdKh9jlbPSW51tswpqEnbpaYNW7outnRdvS7E0QUt6D5sXrR2YG2twdr9qIk/J1F3uzxyulF1NnM4JuH3zri3NOkAI4wegIrlqnKvA/aNtipbtWrSjJPGSNUllq2BNfEPkM+E3+hX497MwTa0bcXze5EBG5xBEvHw6duWy4PCuSk/4gz/1V6ireldaKAAKPqlhK998XdoFxGGCy0xKKTNfG68FbQDNJws4fyEhO3ZYA7CWLnj2/ONVu9Rswd0wk5FaR6A69kpkkX3l9pzk3fguGNVSYpcHJ9UgJcXZoR0G8/rXM/r36yFpoVP/zC3Xm60+02tgHcJUSc/qPYzKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M5Qe5nKu5EtF5UUqTKywCap7LM2iJbloC+dqKCqmN7A=;
 b=KbSYyUPdQ6VXQjB4AXKVQOIxi9U/VSw7UQOj7jxNha3WY4fx+eoBqecxPukRhDNVzWEaqCRnmwXwzGbNlhw8v8jjSILRVkcf9SzpAKTkL2lbAyegZ0CveBSqMp3YfmQIF+kJywe18wVPGqQr4MgQFisLPhZSN2alUijzIanHKKc+J4YURjzQ545An3hgHuwSpmJiWbYppof1vQ1+KJea+zgj+p+3w3g5jZuepY6Zfuq5To0crsVSU5dFCp19w+ZV9/adCghyK79W2A8jpgggPko+rVtC+ATMyfCNAMCIeOBzHzZj4DfyBxY28qhLlGzXVDokjRv3j4ehzqd9N8kKOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5Qe5nKu5EtF5UUqTKywCap7LM2iJbloC+dqKCqmN7A=;
 b=QKAY6tBgQQNrNa97Av/kCKS/IwrgmTLJXdJrJ7iNKyYMSjz3TqC/njIzhEFGtMB8g6mQkvB6UovpxbaVhNdOG2Q+MXwA0S5S5kDk1aPO7A0NpT5oPAX3no+tYKD+/rcG5HxgLeGpaopkfXwJ5veXEBvJPbvzXURYZRKCMEEuZDmG67drE4Gtxa8/gZNbeEEg3XH3Y8HKqrwGhuWH0jJT+PokTdjQur52DeXTHmXnyZR17gmXcVrC2nNcTq64hsCm1yybnFDtKKGHcPBHgL3oh0MdUL7r1VuEprQ21PCbHWUexby1RcS9t9U1CCey38+HjLoveQXMQtbUHDL5CwWD3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DM3PR12MB9350.namprd12.prod.outlook.com (2603:10b6:8:1ae::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.35; Wed, 16 Jul 2025 17:11:25 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.8922.023; Wed, 16 Jul 2025
 17:11:25 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Antonio Quartulli <antonio@mandelbit.com>,
	linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>,
	Kirill Shutemov <k.shutemov@gmail.com>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm/huge_memory: refactor after-split (page) cache code.
Date: Wed, 16 Jul 2025 13:11:12 -0400
Message-ID: <20250716171112.3666150-1-ziy@nvidia.com>
X-Mailer: git-send-email 2.47.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAP220CA0028.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::33) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DM3PR12MB9350:EE_
X-MS-Office365-Filtering-Correlation-Id: af86bc14-1f81-41f7-7443-08ddc48bcb96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r2v+bkNtzAf/QZ0/ikxxTflrBE52FC2GbgIziYq4Jcc705qSksybqLCx/3bi?=
 =?us-ascii?Q?pTPfl/pvjIy+K3Rl45eM1V+2vOxpNbpEsBXrcci+4eN3wfDe9i/MDqzwwitw?=
 =?us-ascii?Q?IS4EBkHqcuRbjsBuUyezcPpfFSURMMiiliGeheUWIySdw2CBkIUbVNMt7Had?=
 =?us-ascii?Q?HMTnTO4NTy+ExCkvsuTU1yw/s9QiO7Qn0vFuPqOlNxG9kGF5MJjQ1GqXsVx2?=
 =?us-ascii?Q?+STjbsJmdoGmErvctTlAtx2VUsr0IGna7tsUkL9k/YMPYc/Gqxp/DQtpXvnI?=
 =?us-ascii?Q?M5EnrInqrA7xmbm0VsIoFxi50uhRuUyTyA2fsTRZecYjDE7o1YDz57XFzPSJ?=
 =?us-ascii?Q?thWhXr61KtWLOAMe4TDL+8Y85sDfuY+IDbUtyLtVuA6xPkoDwKYoyf2/m/xc?=
 =?us-ascii?Q?OiBaoLhO97+ThfN+bBxztX82hqFY855YSPiCiHFN+K4FBNwDYSwGfizaTUNg?=
 =?us-ascii?Q?f41DzHeXq2YOZcZRL5F7pbhCbfNJVnSJhTrkt/gc6CextMwcj8xIT4GKu/ae?=
 =?us-ascii?Q?VTf3vInup56MR7Qcbn0DDV0ql9LI7CS1RWD0Ngn1mE2E/qtIM3LbA/tpBL34?=
 =?us-ascii?Q?HDi7L+TUmAb5+Yd0lKwlut5jhFyHln/xe/EZDqfjbNgIU4UsD1UYlaiBRIkK?=
 =?us-ascii?Q?+WxO9TcyrGLxRgYzmqmSHaQyt+N/CeRGXB4HL/NKVw7MYyDKa7IlmYwJIbPM?=
 =?us-ascii?Q?AIAuikiGK5ToAnhuhnZk8FZC/HaNK8YuBPP7a85hc+Lpm91KKHyj8bC1LToN?=
 =?us-ascii?Q?DZCWp0y0Bs/zYiAjZn2pmXuPqQAZ8FVtoP+Rfw3ScJLcbgg+mJTJO7oJQ9H3?=
 =?us-ascii?Q?76Ogzb3Yl/5ig9MN1HZD/QTelsuyANbYR/6ZuKlgW7wvv4Mx2kaUhvQANGs4?=
 =?us-ascii?Q?PPPkcy9tsk3zlwEjOWLClSyfzfIkOQmG2R7UGdHvaJHwDT+RZAgkBGzIdoFL?=
 =?us-ascii?Q?hE2gPnAX8hlEwRPNCdtr0qznTdA14vZ7LrBCz+AT4gH+pwsFdIbt9x7wlOqY?=
 =?us-ascii?Q?KotYI2xTmDl/qVNRSID25Yl/eXhUSB1QWtSv3Xv3yquCC7/rIkGBfY5wxmyJ?=
 =?us-ascii?Q?4TSafd5+qogN4VFSzv0G7u/9H6ICt/upl/A292PM14Io6hKlcNU1B7ZWdT9X?=
 =?us-ascii?Q?lGAP6Vcso3OZsFTfrNUZ8mg8ZJleLgahA83GJecc4qpdgw2bCOEdtxCDxy38?=
 =?us-ascii?Q?Y7xnLdNaVCYZlZDxcI/lqxcVy4aShZxP9K6iOwgUptpSA7a9OCK9IzKG5sgU?=
 =?us-ascii?Q?5o8UHuHiqUBM8Hgwiupy8zQ4s3IBycWQekhXgxQClxtgLQSA0xCaBKPGjh7F?=
 =?us-ascii?Q?AtZpj4Fs7+f0DoHvB3UA7H4gWoj+v4oFq9EclfgktbaofTxBGGV5x7rwjqDR?=
 =?us-ascii?Q?itfqSVQcSRUBkJG0pT1RQfRfIDiHGtoqdWPAQlfKqr+qsRdwidfh2BGC+s9c?=
 =?us-ascii?Q?Ur9Kl1GBzuw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2thiFTA0wyWBOu0kW76SS8cRQ7yQxCIlQIDGUG5Ik0JN1vmfoTSe3/HT2PyS?=
 =?us-ascii?Q?uN2OLjAEjU9q5TPIUvmKxTGXld3+6/PbfAX/fTJPe52FRsm01/KoDjxXNkn6?=
 =?us-ascii?Q?/UZ6jecF+hW7Rw5kzktxPzZrBOhKunATFvPqr/tmJHf2/LO6M/6Qqht7OuwM?=
 =?us-ascii?Q?DpRIwVt7+DmjiIIxz0rJXNMiFyHoBA/GUu/Fa5rJ0pXavyP7CB1EVdQfRbUr?=
 =?us-ascii?Q?iZAXdy0Aqga1HXCj+dfFuPKsumVePo0c/8aBMNWzb4Yd9dTAOW0QoVlPNN0Z?=
 =?us-ascii?Q?kMrV5N3e8DpWsSwLMTBV7nTD3/BioxAoUY9r0QtAWXkHy0+MAF+YAJkfN4km?=
 =?us-ascii?Q?Th9ku846VlNn/4gnXxPYiqs7IHOgfB8DlHf9/4+KnShqhCeCUl3JN4AlscfX?=
 =?us-ascii?Q?K7QSQLaEbR6Suugwpu/S4vwfL87/hZdU+aJ9+DB48JlsqcklPKThESGPYwj1?=
 =?us-ascii?Q?gQKOG0ta2poxaHFCzMdQlAeztRpyARKp5pUIGclwlwsxT6GTrwSZOkxIq2i/?=
 =?us-ascii?Q?yfYr9xkpr5L+onVjPsdYL3NX8lVhALx679UOTrP5iVeje9OAnzqZFpoaVA3P?=
 =?us-ascii?Q?wkr0r8vik8IFRuUld/8AubTf2BNgj3HFxx7vHppeNt0mooT+sYQPYYKiWQv3?=
 =?us-ascii?Q?ONKdwWt9gZwGAykLityB3tykRCXwD7MmXQOeuEybEy5y7l22jLSvGoUGdMXi?=
 =?us-ascii?Q?axZlxDm1WGTQgBjY0clYScrLyb03wYBGKzXX+TFPbU/rjAnJZitjTpyEPrp6?=
 =?us-ascii?Q?EH837Oc7v8b8ywAQQJIjdutzZ8YNkGfOwMnnaU5FU20WK/ji/yldoOlGknuE?=
 =?us-ascii?Q?OU1oxbjKpxly9cNLy7PNsAA82W+7kUPn8CqXefQSIlzaZkmSCNiZop7l3AVA?=
 =?us-ascii?Q?tSEfYv86s9UxLGeM9dIAz6Q+HSckW9WK90fQNjffCqEmb6ijR1646+zF+psg?=
 =?us-ascii?Q?jkIpVoZTb2HGc+ROct0Ea47CWvbmr5U25gId1f9+2PAhYlW1y8XiErpe+gaG?=
 =?us-ascii?Q?Bxt0IvM+SRMZfwpF6awKkDNWBvn3nm+DlXnlLigl1OpAz6EIjCIRjIi3mbec?=
 =?us-ascii?Q?kHox3AgX3iAGGJGVNiCe4P5Ezev9cQBhDwRivUXjInWqO9yjQar4JvGEEgJj?=
 =?us-ascii?Q?wj8vVU5qx4ESerCARlgTjCh32lotPM0mcec1sflddjo3OHZtsjSyay97Ud74?=
 =?us-ascii?Q?o4G6hOydXPHCr4urCPZeFatCrErVMbvrdbyMMEkslJhvFSEhB9a7PorjyNW6?=
 =?us-ascii?Q?rjqIzzgfds/MVj9jRHei/lDp1K890a9IA6KfqOuyNbQbdaiM31KOx7sG5SeU?=
 =?us-ascii?Q?nVgORRZXHlCzXcsZ2ClKud0PZL3FjG683lV4G7QAkndW6ZNI0/BbFw9YrEcY?=
 =?us-ascii?Q?zXCMR4GGnLLzDOQEfxmsg/EMyWDCT1fCsaBQmruoPrqLykDkRKivMzXIoos0?=
 =?us-ascii?Q?TohX9R3tfGm1Wp4PrKPoJ7KVd0f9AiJ3RsVXBMenW4MaSWG3igF1pPvvoxX3?=
 =?us-ascii?Q?XKkyxSOCY6N9OPr6J0yf66ARYqXcuLVsrcKM8ZBOAu48S7rsqMHoD0XY+6nb?=
 =?us-ascii?Q?aMNp8x29zQ1Qyw4QsO7ftmOL9NPKVQqNWOY0vGRX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af86bc14-1f81-41f7-7443-08ddc48bcb96
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 17:11:25.3002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ARBDZPvjkd6O19ffQ0tYIW7moAY2Nk4qcl82ka4Iy4Z1yL1Wyz/32bOmMAtRjUEA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9350

Smatch/coverity checkers report NULL mapping referencing issues[1][2][3]
every time the code is modified, because they do not understand that
mapping cannot be NULL when a folio is in page cache in the code.
Refactor the code to make it explicit.

No functional change is intended.

[1]https://lore.kernel.org/linux-mm/2afe3d59-aca5-40f7-82a3-a6d976fb0f4f@stanley.mountain/
[2]https://lore.kernel.org/oe-kbuild/64b54034-f311-4e7d-b935-c16775dbb642@suswa.mountain/
[3]https://lore.kernel.org/linux-mm/20250716145804.4836-1-antonio@mandelbit.com/

Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/huge_memory.c | 43 ++++++++++++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 15 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 31b5c4e61a57..fe17b0a157cd 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3804,6 +3804,8 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 		 */
 		for (new_folio = folio_next(folio); new_folio != next_folio;
 		     new_folio = next) {
+			unsigned long nr_pages = folio_nr_pages(new_folio);
+
 			next = folio_next(new_folio);
 
 			expected_refs = folio_expected_ref_count(new_folio) + 1;
@@ -3811,25 +3813,36 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
 
 			lru_add_split_folio(folio, new_folio, lruvec, list);
 
-			/* Some pages can be beyond EOF: drop them from cache */
-			if (new_folio->index >= end) {
-				if (shmem_mapping(mapping))
-					nr_shmem_dropped += folio_nr_pages(new_folio);
-				else if (folio_test_clear_dirty(new_folio))
-					folio_account_cleaned(
-						new_folio,
-						inode_to_wb(mapping->host));
-				__filemap_remove_folio(new_folio, NULL);
-				folio_put_refs(new_folio,
-					       folio_nr_pages(new_folio));
-			} else if (mapping) {
-				__xa_store(&mapping->i_pages, new_folio->index,
-					   new_folio, 0);
-			} else if (swap_cache) {
+			/*
+			 * Anonymous folio with swap cache.
+			 * NOTE: shmem in swap cache is not supported yet.
+			 */
+			if (swap_cache) {
 				__xa_store(&swap_cache->i_pages,
 					   swap_cache_index(new_folio->swap),
 					   new_folio, 0);
+				continue;
+			}
+
+			/* Anonymouse folio without swap cache */
+			if (!mapping)
+				continue;
+
+			/* Add the new folio to the page cache. */
+			if (new_folio->index < end) {
+				__xa_store(&mapping->i_pages, new_folio->index,
+					   new_folio, 0);
+				continue;
 			}
+
+			/* Drop folio beyond EOF: ->index >= end */
+			if (shmem_mapping(mapping))
+				nr_shmem_dropped += nr_pages;
+			else if (folio_test_clear_dirty(new_folio))
+				folio_account_cleaned(
+					new_folio, inode_to_wb(mapping->host));
+			__filemap_remove_folio(new_folio, NULL);
+			folio_put_refs(new_folio, nr_pages);
 		}
 		/*
 		 * Unfreeze @folio only after all page cache entries, which
-- 
2.47.2


