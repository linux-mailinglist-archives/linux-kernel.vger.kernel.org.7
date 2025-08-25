Return-Path: <linux-kernel+bounces-784682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC67B33F8F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 14:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A17B1A84349
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 12:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94AA12701CE;
	Mon, 25 Aug 2025 12:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="K2wUK5Ah"
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012025.outbound.protection.outlook.com [40.107.75.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EDCBA45
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 12:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756125214; cv=fail; b=TJkq46a6PXGF57malyQyp/A3u0PaxrDfQM8N3qmNr4zdPaVcK9hjhY0pDZq/slYQWfLlF93n4w+/e8Gt7xPEprR12yGqwQa9GPvz59SKMXA1hiS/AGisJY3s8GUxm4ddzYDO65vyKAobHLA5hbHgENshI3yWykoeT/ZMEMdLkLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756125214; c=relaxed/simple;
	bh=VqXsnSZ5wmRGKGKrnyb4IIApm9yx7lwl8bSsSlwxtUI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=cSh6Xq/kXBKdmErMt6jgu1VJFB9ZlhOweis8dMFUdfS46Cdi3PAYyelpKhtDyAZ9yKu5c/pGgdmzvDSs45cNP+3Ljgj9K0lwIHQrTcp9IS8oRLxif0P4KtPLhC8Voq9VpZcQn7qYSY9CQ8f5VXKN2Bart/ryTuT0Y0nK+7p8MMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=K2wUK5Ah; arc=fail smtp.client-ip=40.107.75.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cR6BKUtMySvgvoAz8H9yhZ7O2WJjfuMn5KyQ2f8uIs9JA3A40yHHtYusAejCoWEEo1dzNRVqwHFMa0nLNpJx+gPgoPzXcEU9mtHqqYp4lfZsTzVFuCOgph0Y39G3uo9RI5eir8dMBF8RltbNTKbHoyOvk2vFTl2sH5oKcmRZYQw650ei8soqH+ReGBCECDUd18X47EwC82ezE8olM9MZO9pGVzeQ8g7hpPVpL2QOFiUyxo0L88ZexwdNuRoi3sqwZ6yCXzBfh/yAXrNY9ad7wSJLfbwmgpcAQVBX0xCnT/ZEjfq8wBXHccDKBng7OYba7G6bLQp9lgh4T/T2M3i2Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XgvMGIoWHc4776YEjG+OF6tSd5s6eUizTv0SG8/eZ2Q=;
 b=XJOnFEJQzvACdqUB6Rnmrl0N4lHdbBhbVGT49bUwsVDQgm+roAXsr0+GnEM5b55oOTxjxQZofF8Qlh4vX/8OwZM8ZXIBINwuCknZwRt7IR3iGkY3p7fTrB3fm0W56Xt8aT20UDGf27RHf78xLnmj8wqdIG1bOPP2HtWwA43ZpyrYu0Koo0rBlWAXF4lswtUvj07lzr+Skni3cjCNk/z/5TVa7h47XLrOYouXt62Wakk6c2kgyMnHPz7K1hGXiEOxTx+1qropy5g7litHHbyeJmvh0UO6dJqUTiYXha3wm2smJ6K5Ogm6N25jsG0FFPWNmHSylCBCcI/gr6Oww1aELA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XgvMGIoWHc4776YEjG+OF6tSd5s6eUizTv0SG8/eZ2Q=;
 b=K2wUK5Ah+RayGjypW5h+nwg4/CpyEkEDhLY8gfV6lPKBVMnIQt0eq2h6JdVpCHU5vKW4cwo+4Chl32LZs8L/osksvhE+xLt7GSDS5aCpAay2Jy1oIZjkNxJAYkaeZKJk5SVtUQ56SM33WDj2cKECmVajaJVWuk3pLIqP0GJ968mc3pnx4iD97hVvC4T9ATuHZjVtKN421ox/SMv/PPW292HWiNKoKKGABgSCMI4MC85USQnG59MC9rtR279SGV7h4IvLOYJ9LchIFD2v/38YbHqHFDl3wYIGIQ9oMr6Yj5ewJCcwxX6L/6Yta2+sNqeC0i78AnukanO+C3tIsxh/sg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by SE1PPFAAD10C5E4.apcprd06.prod.outlook.com (2603:1096:108:1::425) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Mon, 25 Aug
 2025 12:33:19 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%7]) with mapi id 15.20.9052.019; Mon, 25 Aug 2025
 12:33:19 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Petr Mladek <pmladek@suse.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Marcos Paulo de Souza <mpdesouza@suse.com>,
	Joel Granados <joel.granados@kernel.org>,
	Steven Chen <chenste@linux.microsoft.com>,
	Alexander Graf <graf@amazon.com>,
	Yan Zhao <yan.y.zhao@intel.com>,
	kexec@lists.infradead.org (open list:KEXEC),
	linux-kernel@vger.kernel.org (open list)
Cc: Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH] kexec_core: Remove redundant 0 value initialization
Date: Mon, 25 Aug 2025 20:33:05 +0800
Message-Id: <20250825123307.306634-1-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0156.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::36) To SEZPR06MB5576.apcprd06.prod.outlook.com
 (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|SE1PPFAAD10C5E4:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b558ac6-5d39-4ef3-aa81-08dde3d39256
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|52116014|376014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WjLFGobbhM0IX0uWSGLZ0NBa/ujwbxvVzstyjHBtONqXm0K+Vt+MD5gvd22P?=
 =?us-ascii?Q?MaQqbpgo2tyIU31qN2OKW6npl/lRF4pBnpmptCiYonQuh8e3qbsgu4vbYClP?=
 =?us-ascii?Q?p8bBquOJvjJEkvVLG9DhZYejZATJ41fmWYB0zAnX8sW2hJSQo+ZO5KuOBcbQ?=
 =?us-ascii?Q?SXlmt2/J79hSrev4AwuLqOfmBFP3kHLfwjYMLejY0qpV5zZ4h6dKpvf0jxqH?=
 =?us-ascii?Q?YqK2yM4QacRQq/ZEpYcZZlL99oU4dezIfu2OyvgGwfdATphYxk7+bJer/fnv?=
 =?us-ascii?Q?Yj0UFInDJA9xH5rPHLNYBRR9L69H2w6VYqEVTomkEGTQTSUo46aA+c9m+RrM?=
 =?us-ascii?Q?cYJ/oqU34IsbQjhPvZN0f/uGut8FhP0uPSXzhBbxkn/tPKCSnZ3XUF1oyUCN?=
 =?us-ascii?Q?pJjOsQDdJmDonkj5BiY7091g25DkZrexb0GMkXsOwAW3ea7DUiEYiggc4RTo?=
 =?us-ascii?Q?5uATR6GNH3vi1duF87cssR2HCK71ardoup5s7CZYT6eYp8pEn/hrNzA6JZ0N?=
 =?us-ascii?Q?Twp9zlb5wk8qKh7fvnpzQhAy+95o4JfsiECzqn+swGE0QmOJJPr2DpoAeJOs?=
 =?us-ascii?Q?4otdlnYpzr6NB854chhE/fdl8VBdzJiqGhUJ31rc8kmrQ6JXQ5Y40EbwzWY1?=
 =?us-ascii?Q?yu1XLJlIyPjeJczGGM9hp8Bj/U/2Ue+7SRdMeqJgCOb4SFiu3FlP/QxkYKLK?=
 =?us-ascii?Q?YeS0otc7bs5SmZaD5pHVzl4RgUJPYeYWU3bI29jTbeQapKnmihnYb8gMsZw5?=
 =?us-ascii?Q?qbJAjE44ncHENDe7iwksjRLGcmgtibZNFpfuAtOHDf/3lxf2ixdFzi+8aRj+?=
 =?us-ascii?Q?uwApC/CXohkEl9cyclZzor8A33Ey/Xn5oc/ZUTOUuCM8YGouzuGw9ziJm9vd?=
 =?us-ascii?Q?Ug0VW/3AMAZ4e2WELSmMu9uxNKdhMUmtw9fASPtGS+gQRyez7kbRm/zT83E/?=
 =?us-ascii?Q?3HDK9IIQhsIBgfRVESlgAYrndPzX3DjpX9MDeLrLPpNCQS0GMSfYt5sm9lgj?=
 =?us-ascii?Q?Xx9YinCqWQsHXHVjg/EiIoavqM1QysgBO06iOGyLfJeug6JiHWWbT1CUY7ld?=
 =?us-ascii?Q?ogAGILSLbamyar8RIWZoQ9cnv8DriqVtr9ITZglVHmlfXrD+1DkBh9PJATuR?=
 =?us-ascii?Q?iJI2PWxp1Gv7v2aUbZLoBHCGA1Do7C9Z74LdZrVq9oLWPy1EmZV4E3/ZtXFr?=
 =?us-ascii?Q?pJrbNWwDqvlekDgFfNJh3/ctUswc5GbL4CXZuyGjBVR0sSbpR7kD4pehOobq?=
 =?us-ascii?Q?vlIuGsDnadhldfPmWRXzICZEfVXUNsGBKRZgd7GPddojAR8S32tnoV0t/3Sw?=
 =?us-ascii?Q?NY0tCthB68Jbr50CXEXPef/zUIrc2hOD8PskG4zcFmloC5zHSsaerpT1eT94?=
 =?us-ascii?Q?akNvXwSSW3qmMJKO21u9hFfefyViM5fR4D9dwNF7QYH1YSyClfBkF/cJFi17?=
 =?us-ascii?Q?Bi4qT8DEwoufOjoT2whSJAH97+Q+8kz6/d59joAEXAnRy/7kDl2+iDzsY7fT?=
 =?us-ascii?Q?xvmy6Jp7tBvvqck=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(52116014)(376014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RaIWCc5nuNKjBxfrlRvk0JmcgAMy8HvC4jEBNTn41kkwxUkp5URAzeUgGyEn?=
 =?us-ascii?Q?WmIxSlCnUV23l6lHHA7Orv6U1UXQkilXZLiqyLgyQd/uQONi014wOX8i31zT?=
 =?us-ascii?Q?hB2fL6CZzWkwmFBqnvk83tA1Faon/nbt9xE2vuYLBTHZCrZsD3ypAVU0BNl+?=
 =?us-ascii?Q?q7+P9M4KzWZYotj+sqwjrH5az9C/g3FX3cCUJaJG5/E5yWyV+Ri4Z8UliDmN?=
 =?us-ascii?Q?HKwuNOHh58v6MoVpGRSj3VMEgY5ZYkQ5R8/u2vdM8kK6dkRp1Fo9tK8LIDRN?=
 =?us-ascii?Q?PwH053C9+ko3PFFYnYAdqQjSpJhXUa/Db8EcfPzMdU1Eix6j5zVhs2/BisIo?=
 =?us-ascii?Q?vPWvuV1r9jw4lGVinvyXxqbIRy4P/PRU8CwLNztqH5G/kD0izAUI54v8iS5m?=
 =?us-ascii?Q?3WleDKY1KoxXpWSmFNNWuWp0RmZ4MENcKrBMBnZ03lhy3w/SNR7B8MpUS/55?=
 =?us-ascii?Q?sxgmiz2Okohom4AIp17jU0rpqQwi1RfLBzLEXWXUdc5tNDz8Wim56nMK8VdU?=
 =?us-ascii?Q?a8wwEufQASY8ii473oFWCvjTuLVkgGTIFYunpVfM1lBQl45NH3dXvYLFsk1k?=
 =?us-ascii?Q?oQolSag5xier2geucoZ+plWXYa7O9HmIfDQXzKrxmoxH5d6Pnw4Y58J9l29S?=
 =?us-ascii?Q?DLKHuG1PFnYRCIAZFWwJT8oBzYIyBNZgNP5tEmwz6QLn+G7o7UenRElA8HnF?=
 =?us-ascii?Q?Yv3h3Pkf6ODf4y3G8hFzaG9woUSJ2OfxydQbsYMNtexSPHQo5TjCuuIqAoRQ?=
 =?us-ascii?Q?TjQjUgFFmYWYkTNH88KiY6/NHHHbsvB8/GlsQv9lU342ks/2ulprOBD40eDV?=
 =?us-ascii?Q?xL6vuWV/BnzmTabWi5YDIo2PdoTJrmc35mzK8sncWQF3kE6m9o9tTWpIIvuq?=
 =?us-ascii?Q?klwg/ZE8FIrELNV/9K7L/aOehB6cAuQeU4JxvfriN4aWw8xsodykKC/087aM?=
 =?us-ascii?Q?HBnANhjAvcZn+FjHdE/Gzl637IqKIFdl9J8vrscJhKKVtiiGzHQLROb0VGcd?=
 =?us-ascii?Q?h1mOPv5vPlWoVOFjgEgKHgLXj+vN7NrOIGtKYntHypjGnNUtRhqGGknnmlEO?=
 =?us-ascii?Q?dy+bT15byjK3g5HEzyeHg10due4uFMNEBXOF5408yDqrPHs1N44f1vL4OLV6?=
 =?us-ascii?Q?mQt+AlOm83ReypXHEcaRUXr+8Q7nvEDL49BKu8xXEgG/P6V7cXck7OIaKB53?=
 =?us-ascii?Q?zPAAGcIfSyu4zQZq69k5xjC6Dslp+tgr6Ayqx95aRlz2iXPgtm26cWLLSXHQ?=
 =?us-ascii?Q?Jh1Bv4dPllhzCrgHx8a+mN2suNW8El2wwN3lpNy8qPv+NVQVKdncP/d73G7R?=
 =?us-ascii?Q?jtzmu8FX8T2rRhsjVhMOisXD3WRrrgBF9KzXjB62+ilGrWlFGiezP9eryDsS?=
 =?us-ascii?Q?WhtArZpoLLqV1GVLHpRAdhl+ua+E8YM9GG7uBXzLHGLczbSXA+9J2m/TkYZW?=
 =?us-ascii?Q?+OJwSNih3JcgdA7LrQHGzqd3V+3X2C4EsZEScf66NydAjpqB4hqj2oVWG7yL?=
 =?us-ascii?Q?DBEL7lkHwx1ZHEdFYhCp/4a0CoeZwZ/VK4gl4HUVtKLqb40CvM4pPImuOgCg?=
 =?us-ascii?Q?+wJxido4dmxAd2b7EMowDhdXUcc4sp5RwM9+cXh1?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b558ac6-5d39-4ef3-aa81-08dde3d39256
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 12:33:19.0927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8N6PwMl4aIPss2Tl+mHefJmQziBjXME7t9zaioKH81NF4VCxUdDbSFN5wg2bk1EtQZqCu+JzKs6IbsOYvSoDKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE1PPFAAD10C5E4

The kimage struct is already zeroed by kzalloc(). It's redundant to
initialize image->head to 0.

Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
---
 kernel/kexec_core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 31203f0bacaf..fa00b239c5d9 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -233,7 +233,6 @@ struct kimage *do_kimage_alloc_init(void)
 	if (!image)
 		return NULL;
 
-	image->head = 0;
 	image->entry = &image->head;
 	image->last_entry = &image->head;
 	image->control_page = ~0; /* By default this does not apply */
-- 
2.34.1


