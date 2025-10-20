Return-Path: <linux-kernel+bounces-861911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F74BF3FAE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 01:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20537487AC4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 23:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9A92F6906;
	Mon, 20 Oct 2025 23:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lu8NK64Y"
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012016.outbound.protection.outlook.com [40.107.209.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3F52F5328
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 23:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761001340; cv=fail; b=X3MVj103sijTKQALLMUO+QrPwQKC2SKqo7dJfyOTUJI/fAzIst43hiejdqWvuXI4Op7jJu4uYlIwwwe/GdVeH6mofm6m2hqwGpPvPybyjKk3uTUCmjCNmm65UCU/mqoRbClpdHrH7dTg2HfvU7PiCMeAhGOuq0pMjtQWotdnz3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761001340; c=relaxed/simple;
	bh=wWGsvasly/gk8kqbnvj5tzheNHTy0MOACTUwCSIufB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jKHl//vp2ZwY5qI6ElCSLjPKGYvvziozZUW78aPahd/54uHCYy25QmUwTdu1/1rbipIfORVq3trngzMJ4AExe6Nv2D1So+sLeG4eSofZw0bUpt+JBSpb2aIWTQ0KlFOsCNRh4ttZ2Zj33/D9PmG7z2SSaR6CeRm3fQov731hAtg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lu8NK64Y; arc=fail smtp.client-ip=40.107.209.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JEzLRCfHeZ7qAXZ2ynbFwfgVKRmF0zbbjoGJhTpnfmZAx97KF0ar0dFx8/Z6rtPS8oLAOd8JWme/c8GQOQfp+QCyTByhRUKH5+s+3RdKvFfgjZ30x4zbpFkWVcZh016Gjbpg73twIrlx6ioJ4h9nBLarlXnlPCW1gazBVREDofpSfeU0kZsVhn7b/uBRKYNwiS6CczojH3nVtD7xS9ecimAx07ymuoxFBCKgIgToXodfjIjmVwR+ABYsA7Q2yD6+63/4ko7kvZAwCZ3Gcj418t4/IkvgF6QQpn62o/R5WECrZC/vw0JA31rinIe7ouM5Y6hxks7ERRsL3xpTqbxzAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UC4ru6M4K9KavDSATdEHcw7K35SUPeHeyT7DBobv4ys=;
 b=B8pkWHNsqKbNzV/LhO4px4MUMBs9g37Yz6lPlGGc5ODZ7XC4u06Kurd1qN/lXcHONO5HXh1ZZpk2h3iqoZ/l2w8hd+NCYM5tj7GY4hXb45y9sFoc11CinE6MIZDIhWT7JR6R3ygWYZhMmFsp0Gf0LQiL/wqVJ6xhO4TzF6RBAPAx6Q4GZ0DfY8RIISbQ7X54V54IgqmLtkPOfRCGAtsyIZc9WAEOeSeNG3ANx83tAvwVV8qfqqGI3C62gMmExweje6cUcaVtq5AVablBNHNqxhTd43mlxsz8JZdiUCuS/TiJg8+CvBL5/cwEdjEUAb6v3IxA374yGccZWvjOm5s4AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UC4ru6M4K9KavDSATdEHcw7K35SUPeHeyT7DBobv4ys=;
 b=lu8NK64YNXo/zJ+mv/fx7baPkeoAHHdnw3JM5yOFNtxx7A2Q6AzZdLAuIngNQZKrnsEWolkrx3vHiInZRu19Pnw1yw67boMywEg0bK6EN+P/Tzn22rCB3uLV2XA3maFJWQLkyFqP25IaSy5PjhEazvTk9w1ds599L3+qRhOirby5xlwLGpD5LtEpnwXGcmE9uy82I6ImjAGBAnlosPiJPAsp2jHi2EKpWmaus2rR+EGfsdPsYAf41MitYl3EcwY6dDGNrEh7fNVlF9qyqRjH/tvYGB+ZL4nACLPfuQE641Sh51bowmfs9vumsUAa71ADGfDTzaL10LLoWDWFNMXXIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 DM4PR12MB6568.namprd12.prod.outlook.com (2603:10b6:8:8f::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.16; Mon, 20 Oct 2025 23:02:16 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 23:02:16 +0000
From: Zi Yan <ziy@nvidia.com>
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
 akpm@linux-foundation.org, vbabka@suse.cz, surenb@google.com,
 mhocko@suse.com, jackmanb@google.com, hannes@cmpxchg.org,
 David Hildenbrand <david@redhat.com>
Subject: Re: [RFC PATCH v2] page_alloc: allow migration of smaller hugepages
 during contig_alloc.
Date: Mon, 20 Oct 2025 19:02:14 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <8A6112F2-794C-4076-A6DB-F68FACCAAE93@nvidia.com>
In-Reply-To: <20251020210816.1089910-1-gourry@gourry.net>
References: <20251020210816.1089910-1-gourry@gourry.net>
Content-Type: text/plain
X-ClientProxiedBy: BN1PR12CA0009.namprd12.prod.outlook.com
 (2603:10b6:408:e1::14) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|DM4PR12MB6568:EE_
X-MS-Office365-Filtering-Correlation-Id: f366fcda-6558-47a7-204e-08de102cb6a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Xh2r/XS4gfgz9q7FxTPFULN8bzjdH6FYI2PtueooyKDrWQqOTxeluJtvaJQW?=
 =?us-ascii?Q?FMvAKXcGt3+/4WdGzPinmV0T/P3hh5p16A816An6x4SQ66mOSM0GlN9u/Cmm?=
 =?us-ascii?Q?i0psnd+Ltxop8EDQLUK6QqKxuy3sbc0roRO2itfWfrl+8H4ltc70YvtSEBtz?=
 =?us-ascii?Q?7sdnwkoR6lyZv4Mj6a0P8eZyC7gSmA8IJJwD85UhDxVc1/Hy3GW1clokeRle?=
 =?us-ascii?Q?GMfScrWjNh324J59KO+cMlqeiB7LIFI6mqfSV8+EJjy233Xx4VJeTvUKdGle?=
 =?us-ascii?Q?5jIIGR+w7qFQbOZScjbnefujUcAvLtOufS32n4W4sfwb0/NRhiAfl3UTC2qs?=
 =?us-ascii?Q?2eDpobhz8ZYktGc/ge6LTDWSK+ARA6Q14exLfJ8Qn6BceraMd/7VbtPR6Fb0?=
 =?us-ascii?Q?myHkZPgptVZVkQe1Gzwom73WTEKj5mw078gQjtToXP06nIJdg4XLCXzWrRNi?=
 =?us-ascii?Q?zJSNNcMxBZDoTOesu1P8y13pN6gZBekA7Z21DIVtltrRgf6zy844VMr5EZAV?=
 =?us-ascii?Q?EuuOQEKzJPq/cUhBFKCJAU12KqjpZ7dMVU/2bbr3/Hhmbu43U0ccS2rITNwq?=
 =?us-ascii?Q?CyDqDvkIfewqSiITH8i8SkxOAzEKgqPwnrtdOmxqXQl9trH7byQYZat7lCEN?=
 =?us-ascii?Q?EAvgCTUdB2jxEy41gvq0eNvgfCvs6VqU07JOUOMDfwSpTKR5RKUVHVdB6bxk?=
 =?us-ascii?Q?N4sEYIggS5nWINxDal3DUY82+x4vqqPExBtCHSmflSPTF8dUZztLVOe8vMxN?=
 =?us-ascii?Q?lrxav1e8fUUOtvglN4SEE2J5WgXE9LYMf12f8zoQfe0muzOxyBszir2S+saP?=
 =?us-ascii?Q?ht7v+h5HjrmwPsFcaWyfwkNxUngNh11Oryyp93Sy7Oet3igeHeHKoRgbFqNE?=
 =?us-ascii?Q?osXTBgoSnLFvSFB+GYbfbXjReBwvWvWo2LFNa6Wa3VYpsxBT3uJqc4aTu6lV?=
 =?us-ascii?Q?539o/JY0nxSnn8BGTIsXfFSHpDjX/xLJWA9jUgxV2E8kTuUvPx9+n+DUmO0B?=
 =?us-ascii?Q?eXt4i+FBiLIaX+rYvylfnmfMjqpruHku8cDkmzT0GdMj+SbEWglG0g1WMSls?=
 =?us-ascii?Q?3ClSNfnt2Px01deUij30IaWcKSQyVgoorBD26Guew/SzKou6TjKQteAskXMU?=
 =?us-ascii?Q?uehF/dHSrmM4CbuSs1A02NRUU+JnswN3BFwNlN1DNLZXp2SZyD6fuPPaVuQC?=
 =?us-ascii?Q?c2qMRDmNsbpRKf8G24qN4PDx4kR/dFJ4cyS4NmZbZN7nymnoKbZqHMZwVGZK?=
 =?us-ascii?Q?DBnNM8G5sN23c+JaeKWSZiJ37FrZfbJMvuqgjdgBpCHWlzMTXflSCISQT/iT?=
 =?us-ascii?Q?kQNLRBwSoW7NrHAicmFcie6mKpGhRP+/ytQto+RBe/fRYi8y5ehUrBUmLqO1?=
 =?us-ascii?Q?pXithx961DdrrrzGXzusgUJtafm80FkFolfgvQaGrRWbW7/gZsIW8EwsD65X?=
 =?us-ascii?Q?3de6HPdchQJ9XVeDIXkvry8hDSga1u8G?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gPg9nCCuzZtmD6SSE3v2hxwv20V3Q2jSX4kYDE91GgWyK7X3JQ6cZj0LNnku?=
 =?us-ascii?Q?Ph0NLwb9DdOYbEfJkaXb4QT6KRBojJMRGNVpzjiF3ceZAxl/G/4rP0Zo9Uop?=
 =?us-ascii?Q?1LelX8uGvcEYGrtPZo71ELT5K1fMq2DVwus843kfo9P/10FtUgMESMq2iZ1l?=
 =?us-ascii?Q?9w047sltcd4MklZsLCup+eJqLTxVMb6iMySoOLu09to+PfKFNeVT/BjpxSgT?=
 =?us-ascii?Q?KUPr2UFqit2V7s16lv3rQ/LHi19I4GV4xgemV4gdQjLRc+7dp8O8reBubdkZ?=
 =?us-ascii?Q?uDc9XdR7R5UPK8uhCS90mOlBNwoVX3ud8QLDRfrOsbPZoWE6gBReT4bTi83J?=
 =?us-ascii?Q?e7LEJNZ643YE8HD+SwvtWFBPPX3XWiT+TK/Wd/ftSLUUSg24cG8fyPfRS3KD?=
 =?us-ascii?Q?XujOSRTeKLmFNSa55QtjOcgH1B8XFkmNFBIQ6HQn+NkDmcbZS1fMfXKQBtg4?=
 =?us-ascii?Q?NtJ+OfN4JOdw6E2w/qsIRN+eU454GhoeD5xR8zyWkUoT/na+LljJN2UVBv7h?=
 =?us-ascii?Q?kklcRv8Ytr1yv8jJ8r0gBa7Mg9qpOfizGpc2UbTWxEdc36KFiDbhVhOzXG3f?=
 =?us-ascii?Q?bLM4tCP3P7x/DegkqaOXCtOCtnrkcB/EkNK4Av74NB5oH+/BwbL3ZtBVqL8l?=
 =?us-ascii?Q?GVA1zFFFTkuneK56MLlQB/VJLb57a0JgYCIlLFiO/ZCIfwmTQ2blfelLBhBH?=
 =?us-ascii?Q?1X/XT5AV3G7QBdEmGc4mF+BviIfzSPhsVFakxbejK46Eqw9lVVbiqe6LOm7L?=
 =?us-ascii?Q?VcGQTdDZ3GwjPsYtCRL5NJR2IrJMml0qwwPuf40sVbpT2EhHu/GNrJtQ+A5g?=
 =?us-ascii?Q?ZSDh3IdO7439XviiBUm5uFdc9Kp8wKREJo7088hWqtXOjH2Cg2X3BGrRP3RH?=
 =?us-ascii?Q?G2zybU9+yA1vlBXvZaEBiNjnj8w8LSAaizrCC8fzu6N6xeoj2/TCzRzDAIFU?=
 =?us-ascii?Q?e5oGta51oyhruN3GeSplYZ2/4zACkBu9+QVYS6gBwO2vYBfBs7CKPbBO8Bqo?=
 =?us-ascii?Q?esRJceMTpOfylHE7hRZtWxlWBtMvWfzlwJAT26Yp6+EXqRPaanjgykQpnYUw?=
 =?us-ascii?Q?h9yN+NbWJigiKmO92WqQZjJGPHb4KQjlf8j1P8+h3UkvD1TZE9IK8PrrCSp0?=
 =?us-ascii?Q?TfaQN6wBkjmAaGXUjurM9i4r8zQf5FnvgaymrB6WCCAWJsbO1F5DBTJkncXq?=
 =?us-ascii?Q?AWcjIh32bCUrTYNuAAAuQVFp2lsopZNrpNrb/GQxkm/lxkjvk1Yk6rG6PZvb?=
 =?us-ascii?Q?oRlu5/7jy9bcgZwP6G7ajxuXS0YCcrC8TzM1netjOWzFJCvzuPmkSTnlh6oV?=
 =?us-ascii?Q?OTXj9xqwmYzyw4O7AoW7dMVxnSgmQMJZN5S/lSzVBZ1RxR2bagdSkd3/6OfK?=
 =?us-ascii?Q?nnzU2qVrG6lW0jMTd7h5k0/t5ZczNlUVfovOGMFSTw6qCa2/VcAsH+sdnASp?=
 =?us-ascii?Q?yi6Wgh8vx9MVXr8wRwpFCAHYV0YZcUP2NB10Dn/TDeRDLYxKzlKfsWCyp1hG?=
 =?us-ascii?Q?JXqAt3D35LDSR4F5PV7GLG44Yo12E624PpKzMWLasoLKSmOKSr6/IOpxhqZ+?=
 =?us-ascii?Q?2s7CJM4Kn/63Q7pwgqC35Tu6eS5snh/o3+/Ds9XI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f366fcda-6558-47a7-204e-08de102cb6a4
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 23:02:16.3639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: udkOciQN8rX30WzBQwRoqpNQlj50/FbzYiggZH4Y61Qwe5JIxtfGlzA3wD9vlzV5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6568

On 20 Oct 2025, at 17:08, Gregory Price wrote:

> We presently skip regions with hugepages entirely when trying to do
> contiguous page allocation.  Instead, if hugepage migration is enabled,
> consider regions with hugepages smaller than the requested allocation.
>
> Compaction `isolate_migrate_pages_block()` already expects requests
> with hugepages to originate from alloc_contig, and hugetlb code also
> does a migratable check when isolating in `folio_isolate_hugetlb()`.
>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Gregory Price <gourry@gourry.net>
> ---
>  mm/page_alloc.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>

--
Best Regards,
Yan, Zi

