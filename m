Return-Path: <linux-kernel+bounces-743882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0ACB104FB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 10:57:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DCDA1883D0C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 08:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B17285C81;
	Thu, 24 Jul 2025 08:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="QmEXU/t4"
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012007.outbound.protection.outlook.com [40.107.75.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C6A2868AF
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 08:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753346791; cv=fail; b=CkBPy04rKyz9B5vEik5IrWemHs0rU9MCKI60PZVKNXSUkPnxhkbxUsJmNtdc2iKRtofvRZ+C/QSms5ICg3hlVaXiXO7gukpPTUkHs+lD2LsDbf2rBGLh6QhAKirSf2N9xL3MUByek/L2JvTf1kB9WxcGPYSBm9siY5KG9InJs9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753346791; c=relaxed/simple;
	bh=x02k+JhAVTErUrfcvKa1xU6dqi85THefOSCpcEKAMkY=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sdTFhRFqc6QscXYLFzdeCjhmKBfJRkK34OkcQ/kvEWopWTG/ImONrpboKM+xKT7jiXYR2E3egTVxHSdp54E0KhASRiWlXigWQF3FFNpFwKNW3ZD+93wrcqogkjYHxBbyEp9eFlwbnhjylcEe2mUtsOjj5pGgB0stl1PbsF0AjOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=QmEXU/t4; arc=fail smtp.client-ip=40.107.75.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BzNS9pfja8A5Bivzi3XkeUha3UHB19c0XZIqiUGU22f+zavhYlDmMhpvi0wyB6IOIol1GDNUL7i9CgrS22RMBBE0OxPTgGHWi2M/xFnTGp/MxLWcPfW8Tr3x7BsH6fwKem+McR8VgxWPLZZUrV1ObmF7YLI8gYUUoe88SBjo8wGGvolZWb4ZklJ7n4rkNIrXoVm9Zf1euShkZH2bJi6ukVU6c8MomBP9iqmNJSL4DAb45RBvxnieCo5n9Ne24hqTSL8v9B2HjY7UZ3zmdw5lkU6+JnTnn1zYMXyZF5mHyVKtNJDeCjFkMwdlpjyyqaOhhGtRrwPPKrpXzpF2KSfW0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IwNo3dl1GUwICQBnaJ0mzBgWxy8F4CLh2B/grSd7Ezo=;
 b=VD9aOaWfPiuaJpHtOmaJDPYV8xvHm8YiMKV/kJuZQvNVHHgAiYi8xh5vcYwE+AXpSc3Svf4N3Y9lpIrYawN5GBrKZFN185UASMsY8pnXp3lXeJ3ZdAPZL+HZmaaApDvwj4oSIiC/l29OQJdPh+ft2TdahCx0Qp3F6q/AswspOpktR44ZRnAtTs5aRLjURE9GLo5SeK0InlYLEKwLRVPDq6Z00ad6I+nQc6gJCbqaBnmLKOfae8A0DQ7MhhshoC6aCay/JLT1DuNX9tsxou8rRdbFH+rcf1IEUWM0iH+RFmN96/thH+X6G+0mMQvjQYiWOOotnXpseOQrycn6qjvXgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IwNo3dl1GUwICQBnaJ0mzBgWxy8F4CLh2B/grSd7Ezo=;
 b=QmEXU/t4p4AAiQd3aHt7DovSpPN0rC/UZ2DjY9VMly9YlPDCeijh++PNQhQAnr5jpP1lYMrGbIVGu/tVhbEZgg4LODqjBwqMBgHMwqSMttOqsqyip9OoMllCE2dx2RZxLFklZMV3dMB0BUq+W8GM6raVNWN0D75irhLKLD2mILAqpDo03EexzA3vnb2eBMx8+DjsicIBdGaTF7DBNAB1MZrnAcsjd4b0LogR+pDU4ZRBlKURg6prApbdEKAAq8rg+u1w0ePWINwclH/CSrcYxyJtUWLtcOycKFLHc0OvYQ7SDnHOvYUNRVr6/xQfAkLd87GsKQ8pAVCBaytMMWynLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com (2603:1096:301:f8::10)
 by PS1PPF2A261C07C.apcprd06.prod.outlook.com (2603:1096:308::247) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Thu, 24 Jul
 2025 08:46:26 +0000
Received: from PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f]) by PUZPR06MB5676.apcprd06.prod.outlook.com
 ([fe80::a00b:f422:ac44:636f%4]) with mapi id 15.20.8943.029; Thu, 24 Jul 2025
 08:46:26 +0000
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
Subject: [RFC PATCH 8/9] mm/migrate: infrastructure for migrate entry page_type.
Date: Thu, 24 Jul 2025 16:44:36 +0800
Message-Id: <20250724084441.380404-9-link@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6289bc47-4441-45c2-404d-08ddca8e9382
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G8/46DmULk/PLQUrZdUlru1KTB+wkvcDv1GBjU35g4wfydWh4908jxV8Bylv?=
 =?us-ascii?Q?J5qDX4N4VhUn3mlLwayxJ+0jLBhLhUFPlEvfbPUYJE1P9inm/gv4E4GDrJGD?=
 =?us-ascii?Q?ZiO3RiF3wmF+QhYnJMbPh2hdKZ3piMOmC70POS8icRgIGlN6XaMtuHCL+rDk?=
 =?us-ascii?Q?fV7E1xrZqd2ldCxPvF0zATZNHFH8jQXslA/CL3rKGa99PmluVfu/HswgmnDB?=
 =?us-ascii?Q?T7WxetMwt69xsX2xQBknhiRu8XMs7yDLNcE7tJ7hqpycwMLoqn8h8MiQG4yl?=
 =?us-ascii?Q?Cj1v/vjGNKvcacE3KiIGW5Zwf3brTRFVqJe6dbKMXbvHHUEx25WBrXWYWaTp?=
 =?us-ascii?Q?bjZ3XGZ3ArF6B1V5UvpdD4NIBUnDWHQkp8RUhYbkZ8fg2ObCtGyE1RQFMt2s?=
 =?us-ascii?Q?m1rTMeT2Ua3RT2XUsMk1pXGVeqfJfji0GurpKS3BNU6Y+i/APK5AJTrX5Qjp?=
 =?us-ascii?Q?3uVScwuwfXJDTS1Eu+eTKhIzbCgGyz5+BEN6uGtPlR+yeDHeoiwS2Q2ShLs/?=
 =?us-ascii?Q?38uq5M4f0mCI/eMxvHabj0sgDccONWlRSiNdKXzz9Bo1LHyt3EkHdAFpq4Bq?=
 =?us-ascii?Q?qjIxxHWTj9ayo/6UmFocBZrNKbyWV1Mj9qypRIZU7JlIJTcI+ate9ZSAvUuj?=
 =?us-ascii?Q?IzWiOtRXk4q0Dl/PELg+UIfqSECpCmvAD8c22y3pQyA7gR/qITy1NTZ6Iv9I?=
 =?us-ascii?Q?JlGN0tqnnCi32OC1tskMxkwU2+Hs1hI2F6UTbgdcK6enSW5SBHNPnQ8Okflq?=
 =?us-ascii?Q?NaopFUnV/0bHXi4+MYvHple2Dg7Lns+tx+4xVXSZnyHLvPDmZug3OqwZHBCO?=
 =?us-ascii?Q?T/pv3XKkiYf40XZpqA6E+PBuOQvI03i4bZKnOiG6aaxLS6QzHubTWoXFcbEm?=
 =?us-ascii?Q?gv50cYlTpgMytYZyyJoWDWezOvOLZLf302lq/P5YSv0NNpQE6RLRr6ekCwMs?=
 =?us-ascii?Q?ObfUatNEVfsjd3J8JbBahg2NFM51w87PFZbSzRc2aCWaKOL90YvQdz28sMRh?=
 =?us-ascii?Q?nupIankvnlSWJi7Sn2orT4GMFN1XA0ZVjSEbYQWKdz1ZzxHzHrDx743hGXSm?=
 =?us-ascii?Q?HYnpb1vX4b0e7EvVwfb3xayFXmVAc9Z8cjH5vzBCZ8MOSJ7tdI3o8gHVZqMd?=
 =?us-ascii?Q?4/KzC+4A/30huFsRB0V7yMp513kumVh+62T70X103HtrOOL9zqdkJ4GCa7bC?=
 =?us-ascii?Q?+7dfXwjyXH5DojaNqNyy77YYSlSenoCLWBo9VYN5TDf/16fjI92r5OvjrHCE?=
 =?us-ascii?Q?8LXgEZF/b0aTiJoQo8tbZ5aNgrdNdpbsabc2zO3/5zVL2X9TrVqRwcQZQvsF?=
 =?us-ascii?Q?rK4VBlLF5pWTebWYuqa4I7WTPpj4q5VgY19QDM5b2X5S6c2UoCwCm/2kRCc8?=
 =?us-ascii?Q?QBfXenxM2zFO0AqrEBPdskFiCJacZnArQuwdpyd5JV2UCWi89hn43scBWE7u?=
 =?us-ascii?Q?cXPrXCROSvNm6WA8KKCPS00fKgt3CFhDwP0xMpUv6nc+17Rz8HUtE4vKiYoz?=
 =?us-ascii?Q?rBQVdMvx6UJbTHg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5676.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Hp8gV4uRBfNCP6uFwlXAFRRJh22m+nt6h3XjWM2VO9MCJ3mnq9AWvbrRIDln?=
 =?us-ascii?Q?4SAO7TNVHqMWDqcs/pjGYO/ovXwSjrZARKAUTgZouxgR8qWAcDx8KiBwXV/O?=
 =?us-ascii?Q?PMjWUUj/1QRbATHCspEMC/lCT9IDpnH8OmWgbBFiK7Yo4W/2p/ng0FQeaJCU?=
 =?us-ascii?Q?Xqa5qKgo6LBMBzIMfYhqsONgCNKJqktc1hNFj+fXo0Zpqu/EBNLNS4qcQUnT?=
 =?us-ascii?Q?D1VVZE0tifr9/kkf63zoXPlDsEFl1Gw5ht9KZlEJPej5iUAbq4KwULAF0c59?=
 =?us-ascii?Q?j4dzVlYzf5a4mVfZDp3gg3BOJq6T5i/A9S+xC4FNBCOmGlJF1h/zb6z747eK?=
 =?us-ascii?Q?hcVhj2Ulp1y4yyCDthoxDHUb7X1GU3s841QPHPRMPx7C+UB4T2l79uS9Muzx?=
 =?us-ascii?Q?TuJECQwVEOvBu5RCDxOuXt7xwh9w2YVm0nw44eAUndGBFJnjxTuwgMKuLar7?=
 =?us-ascii?Q?azniOSFSjBBg/W/NElhhcjrL9SHdB8e7s4RrYv8GQym6U8tINSZEvgObOdnx?=
 =?us-ascii?Q?unXALvgWzdqLj92B16PUEvf5yyQpOCl8r3QpnaIWHltzBKsxC5+AlwkxhOvK?=
 =?us-ascii?Q?JsSNrP/RZlhtltEqaUrLCalkUY62o+gXI7j//ecJHX20uVCIkSvT0SkSZAcK?=
 =?us-ascii?Q?BdQmlSpsYfZQHW2mBdvYNSaKTiFbc51molUZzkB2BKHeqhqWi/S5+Xso+MIL?=
 =?us-ascii?Q?kwWheJohRW5ImFZ4ZdmcYXWvdguDqj3J9H6mMNX3X4Eo81tAFok44FZs0taP?=
 =?us-ascii?Q?TRLLFPpLJzMHCNc/+1ZVQKLRDrfKj0eBA0B8/RiNNH1vbNoejWyyZZBdAodg?=
 =?us-ascii?Q?cOeIzUkEshZ7GQe823p23/Y+iuNjP42ye5IOITWmj0f2m1uw4GAJg4S7oLmi?=
 =?us-ascii?Q?v6brA5gjFpqMuutXV7zEDxnz4oUE3/wIJIuBGBKYV1ElU0wpoEahARUcPPa7?=
 =?us-ascii?Q?JTjGGu47JzsHdhn6xYJ/uOERN6gICg0IBngim1yFus4swLXmWvpE8LyTBySh?=
 =?us-ascii?Q?FLAdOj7D/Wqb/f6C9wz0zvwVYqGr8gJlraYK+W6Ifv10gFUuszNzFHK0Zrkm?=
 =?us-ascii?Q?gtW0GWKAvReoXA9MdUGCJl2tzT5FJbrImQq0lgtJmwBHUdsel/p0Rq9jOVd1?=
 =?us-ascii?Q?2dkuG8r3KPTL6QduuNfmZAuCh3i9W7sa2qaLuQyxSkwfSHwcREY4lDsFW64f?=
 =?us-ascii?Q?XrX5KR392wcjY6hDYOAv9iEvisceAz+Vy41dntS+mCmLqyIRvEvNiWgTtNO7?=
 =?us-ascii?Q?s/t30RknnawMCFwg+f60Lhee4yv7ogbnQlPy64yztdU1ZUvf5vPlZApoHK0l?=
 =?us-ascii?Q?+2Q5ul6o+kuobm42hW4AkkJpbqAk/J0cf2Vr6ANYAHPGIMAeFlkIyEdW9IEe?=
 =?us-ascii?Q?XqTP4MyQfCW3kgz1av5W1VULcuX4+ZuSNBpBkNmilMsE2TEuo9nHMEq1sl0n?=
 =?us-ascii?Q?J806HFoWyYUJ3rrgBcggY79ko+X+pnmeVxVKVVlRrlP1OAbfP+U0lfs5jMu4?=
 =?us-ascii?Q?AkkMqzADLQTllofVe6om7sHCzauTTRXBp6R4WiQcAe0ec9RlOuMgjU7SakMr?=
 =?us-ascii?Q?RcGtpsEeQao9qVyn/xU2kEPD3oS8QK1xRLW/w+ll?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6289bc47-4441-45c2-404d-08ddca8e9382
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5676.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 08:46:26.7405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bDl93xd7PAumwmTur2508skr2X+vX/UtW2eTPWW8fQD6psth+521umlwIlhX6xrsy3rN8X4Vm1R16iI9f3NRoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1PPF2A261C07C

When a page removes all PTEs in try_to_migrate and sets up a migrate PTE
entry, we can determine whether the traversal of remaining VMAs can be
terminated early by checking if mapcount is zero. This optimization
helps improve performance during migration.

However, when removing migrate PTE entries and setting up PTEs for the
destination folio in remove_migration_ptes, there is no such information
available to assist in deciding whether the traversal of remaining VMAs
can be ended early. Therefore, it is necessary to traversal all VMAs
associated with this folio.

In reality, when a folio is fully unmapped and before all migrate PTE
entries are removed, the mapcount will always be zero. Since page_type
and mapcount share a union, and referring to folio_mapcount, we can
reuse page_type to record the number of migrate PTE entries of the
current folio in the system as long as it's not a large folio. This
reuse does not affect calls to folio_mapcount, which will always return
zero.

Therefore, we can set the folio's page_type to PGTY_mgt_entry when
try_to_migrate completes, the folio is already unmapped, and it's not a
large folio. The remaining 24 bits can then be used to record the number
of migrate PTE entries generated by try_to_migrate.

Then, in remove_migration_ptes, when the nr_mgt_entry count drops to
zero, we can terminate the VMA traversal early.

This patch solely completes the infrastructure setup for PGTY_mgt_entry,
with no actual usage implemented, the next patch will do it.

Signed-off-by: Huan Yang <link@vivo.com>
---
 include/linux/page-flags.h | 72 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 52c9435079d5..d8e80d5ae1f8 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -957,6 +957,7 @@ enum pagetype {
 	PGTY_zsmalloc		= 0xf6,
 	PGTY_unaccepted		= 0xf7,
 	PGTY_large_kmalloc	= 0xf8,
+	PGTY_mgt_entry		= 0xf9,
 
 	PGTY_mapcount_underflow = 0xff
 };
@@ -1125,6 +1126,77 @@ PAGE_TYPE_OPS(Zsmalloc, zsmalloc, zsmalloc)
 PAGE_TYPE_OPS(Unaccepted, unaccepted, unaccepted)
 FOLIO_TYPE_OPS(large_kmalloc, large_kmalloc)
 
+
+PAGE_TYPE_OPS(Mentry, mgt_entry, mgt_entry)
+
+#define PAGE_MGT_ENTRY_TYPE_MAX		PAGE_TYPE_MASK
+
+static inline void folio_remove_mgte(struct folio *folio)
+{
+	if (!folio_test_mgt_entry(folio))
+		return;
+
+	__folio_clear_mgt_entry(folio);
+}
+
+static inline void folio_init_mgte(struct folio *folio, int nr_mgt_entry)
+{
+	// PAGE_TYPE value currently do not support large folio.
+	VM_BUG_ON(folio_test_large(folio));
+	VM_BUG_ON(folio_test_mgt_entry(folio));
+
+	if (unlikely(nr_mgt_entry > PAGE_MGT_ENTRY_TYPE_MAX))
+		return;
+
+	__folio_set_mgt_entry(folio);
+	__PageSetMentryValue(&folio->page, nr_mgt_entry);
+}
+
+static inline int folio_get_mgte_count(struct folio *folio)
+{
+	if (!folio_test_mgt_entry(folio))
+		return 0;
+
+	VM_BUG_ON(folio_test_large(folio));
+
+	return __PageGetMentryValue(&folio->page);
+}
+
+static inline void folio_dec_mgte_count(struct folio *folio)
+{
+	unsigned int nr_mgte, old;
+
+	do {
+		old = READ_ONCE(folio->page.page_type);
+
+		if ((old >> PAGE_TYPE_SHIFT) != PGTY_mgt_entry)
+			return;
+
+		nr_mgte = old & PAGE_TYPE_MASK;
+		BUG_ON(nr_mgte == 0);
+	} while (cmpxchg(&folio->page.page_type, old, old - 1) != old);
+}
+
+static inline void folio_inc_mgte_count(struct folio *folio)
+{
+	unsigned int nr_mgte, old;
+
+	do {
+		old = READ_ONCE(folio->page.page_type);
+
+		if ((old >> PAGE_TYPE_SHIFT) != PGTY_mgt_entry)
+			return;
+
+		nr_mgte = old & PAGE_TYPE_MASK;
+
+		if (unlikely(nr_mgte == PAGE_MGT_ENTRY_TYPE_MAX)) {
+			// overflow, can't reuse PAGE_TYPE here.
+			folio_remove_mgte(folio);
+			break;
+		}
+	} while (cmpxchg(&folio->page.page_type, old, old + 1) != old);
+}
+
 /**
  * PageHuge - Determine if the page belongs to hugetlbfs
  * @page: The page to test.
-- 
2.34.1


