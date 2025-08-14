Return-Path: <linux-kernel+bounces-768871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8224B266A7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 15:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADCDC626114
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 13:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C562FE05B;
	Thu, 14 Aug 2025 13:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Mqwve9Z0"
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013030.outbound.protection.outlook.com [40.107.44.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5692424293B
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 13:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755177254; cv=fail; b=Gg+uOSfGU+8xbCvEZUmZ/ieEolTPvMUdagLgk9oLaRlg5UiatykBZ3t6aXz/P0SXdKNC0sPXxYoc8gNbTgIg75AgPANrReLxq/pvsSN5NNZeBOui7BqvJ7At+lwcl+f8ALCCzEdyEvfUu5YzfTe38pGkWE4VCLm0MNf0UsK8O/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755177254; c=relaxed/simple;
	bh=ldBnv9lBj3OuWICJOyuc29yTDOkgmOa9uDF4K2KCkhQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=h7aKDF+CXlz6LexD23TjYdNB/8HQ4OlgPz6khxQQ0B8YtgHry2UCPYyTtcARFT7G4nNJD8Xk3yRW/ld9ZFCjNaN+EzLYKBosO7tNv6F3T8PtTMQKY+XijDnJGaWakpDYB0Q1aqRth905YodVAmy2mme1r/++oGIziWvtydhHI9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Mqwve9Z0; arc=fail smtp.client-ip=40.107.44.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qVJWVNQKtqa8B9m4KILOjgICWcCd829Tk96G/4vaGggEsc/IBGwF7zBfEXK8ycOFfsROHVruEbf3CabbBQGbHycrVe6cPEBeSjcJR1vtcL4ynsgtlCL5Gwd8W6aHOhcB/GwYSTgfjwyYihrDE82cpXtS49SM/Cuiep2xRGFl10j6o+aNTRvOypZXRW4Q0C0sljjaaUJi4BuXSmdEU1qnO34AyK51EDudRkgXphE3Jj0lQkz8JXBgg3Q0XBPFghqtS7ZDH3Pyrr7a6S5BrsUlNuUqYBQwjaeoMd35O0hHLMcxxAVqW18u5tsHAbmxt3BfZSNtASldiWMe1XVTJiQkgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m1FHLgLeq3n7Q6f//yrtwBxKQ9obrZqDi/eh0BlSX/M=;
 b=UU5JuURSIsfZ4YPOddknQ+hPxDtUgCh11tl9QoAS5Q0Gg0FSWdELd+0XTvwZwM3MlsPUMUktBDXEGsCi5GAePizRnHFqYM219/HP69lcsLpl8DX4J8AHDLsBGyYC3yeM/8DfmIgCgIGFh7Do/QK7LkC/0ne/Xko3FBLDHMZ7Fs1UJNS7LQMbdCDSWHW6FTiGgrtvF5VqMpEYq0v+4WAWZhCvo5tCcRu7o4fx/4Le1kP++6z30hex/e+c3LtmPmUGoK0chCFvcWI2NTa1jZUAx/YxTiDh0Y/L7hqMIBocD56wfjZH1n1cX3EbK8e+oKg5rrDc3aWA1nmXL6amdFxW8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m1FHLgLeq3n7Q6f//yrtwBxKQ9obrZqDi/eh0BlSX/M=;
 b=Mqwve9Z08Bwo39qB/E39RccSXKZ9I583TmkKn3ahcJRYUDQk5n8XdMTKHlNXAw2xLJo/wxNiRmx0sjwHtbEBcHP/Eta5+RlAanDShMYtjt2oYpjUDB9+JFE2b8vHR9lULd9id30US1V0B9UIIaM4kEj8ae8V7QdhT5a5DlJVSIh+9GAWn7llrFKqg3Ovi2zwGb2QPXQspdv9kaSFpZ+E59chncF+YP1JMblauQYlDn/yuGUcmbpsEOsPJ426KlpQ5NkttPIXtqmIT8i1gpJFnwck4t4HUNSRvsTWpgYwCz3qIDqvAVBGUscRzRrgfabwHIJjuyrLCUzmVhkp66+nUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by SE2PPFDCBF4279B.apcprd06.prod.outlook.com (2603:1096:108:1::7f0) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Thu, 14 Aug
 2025 13:14:05 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%5]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 13:14:05 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-phy@lists.infradead.org (open list:GENERIC PHY FRAMEWORK),
	linux-kernel@vger.kernel.org (open list)
Cc: Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH] phy: core: Use IS_ERR_OR_NULL() to simplify code
Date: Thu, 14 Aug 2025 21:13:53 +0800
Message-Id: <20250814131353.231276-1-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0176.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::8) To SEZPR06MB5576.apcprd06.prod.outlook.com
 (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|SE2PPFDCBF4279B:EE_
X-MS-Office365-Filtering-Correlation-Id: 14a3c03c-12df-4ba3-312f-08dddb347215
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uocBIcrDcQ1EyILW1vYdx52ACde7qmr0ShmQjn1sqOG3UI1jbrHGbitPJTXY?=
 =?us-ascii?Q?9FjQyPZkcS6kuHcz06R77yxsUbEYHNbFZ0gQK0/vMl+iz4klcGjkXoo65XeA?=
 =?us-ascii?Q?pxjoPz7USBrbN6x7Atxishku08WvkMKKL4bnPtW2awlgHpght5J2o2dss2UK?=
 =?us-ascii?Q?DvL2hC6oLbAGkoW2nS7hdr3bQMmI80NFLAUJLDOqoq2xjMQlPE/ZoiGbjNha?=
 =?us-ascii?Q?4y19UVLAJpoUyE1o3wo9HS6DrPXH7F3nbME8mnpzLY6UyT00UXm9gjNvjrY/?=
 =?us-ascii?Q?iY9tqbObZvJICWeSXVAK+6aj+98U+ToU42jqiUZYJMz4g0MMW/BY39C+aGPE?=
 =?us-ascii?Q?9CXmDJLoibT50n8+9zpxzg0q2wZaNtHAj6bIGZI1UOY+U5JcDA0jiuS6HNF0?=
 =?us-ascii?Q?zSU3ZeRsdnKL5PdWl56eb2I9tJ9/GKONWpPrvHi7W2vS1ASlw5F1welWFEBR?=
 =?us-ascii?Q?9pTZHsXtw2y40TtkC+cQHziZIjRUQf5h9bwRR7KvOwfnTEHxkk5XlxDKSBA4?=
 =?us-ascii?Q?R667VVJEgVvMAOtPE6Zpc4eN6kWNhBgJtpFAJXoBKrmLlRsH9a5WYtFeqosU?=
 =?us-ascii?Q?zTuQXCyf2BjxjMtcfknjlwLo8lzXKEjHjKhgKpvRW/jVB7PNxB7Ngv+Z4jkR?=
 =?us-ascii?Q?oBAxVfTkbP4prMhZ8cvEVVpS6IWWKxJjEM+mcqKQzowTgQcFLU4YCg4idmgS?=
 =?us-ascii?Q?A6wOIN814Iu0pSyNEvlAENa8ePpeDXc4+f5OAsryAhHUGIT7Hh93wJw7kbf0?=
 =?us-ascii?Q?LiXYIGlTDYZZOt9VoI31GT3XB8KADutAoOlbI54CdUIwnbDHTHN7GfIbTcQv?=
 =?us-ascii?Q?mkMLo0JeIozMHBjocEeVXzSfjnsunGAY+ZKsfy+l9CVnITRJ/7873zz55JfE?=
 =?us-ascii?Q?b/kTJfLfDH2jYgYXkPjkTKsbMK1YriSXE60heqq9kwYMbyaZ8IYTqvAH869J?=
 =?us-ascii?Q?MCnZqDg4tqoicmbyS/vpfR8po1sm8Wxq0wD0C33jL5cfzoPB/Qr7ap1whMql?=
 =?us-ascii?Q?eurhbONuFFhBBBVfjWNG4QxvTieKLpfZ/cQfAgAIwrMS7C1ZiBRQSn4f6Gvu?=
 =?us-ascii?Q?rqiNtPD1EjWw6H97K2UrC0GAvAU4BFWvemNWsQPrs99PnuY8TXQyXXtpwqU/?=
 =?us-ascii?Q?Q3QssSZEj1f9PgRhnCYMofTVOPgbEZ5Ig5Nb7RTMOia7fgT868JYjp6nUo34?=
 =?us-ascii?Q?5+mEVklYj0aNlYi/cLmP8O8lCxxzG091FhH2YLirxi3LBG+uTUUD9IjzTef1?=
 =?us-ascii?Q?wxdIT8P/QDi8jKT7V08e0vSgwTxX8yQysprwbLhoybAhWkRUi3ntdSGT/ynw?=
 =?us-ascii?Q?+lIhHoOCDGfRpAKSyCx1I3xUuzNwZnqEFxtmiuv+T1QlxQVXfgjGy3RVeSwM?=
 =?us-ascii?Q?05tE3CYJTvB69wGO2EHmXbSczCxIfhvJGq5+/4GOsTwU/xVCiJeLCNfOAqrx?=
 =?us-ascii?Q?zk5iGgBMaX+WTPKj1L05J21YuOpzetjQ+YBsWbrbPsg6VTdsDeQZIQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?csnOnuvZMgvyJzWPdIlxMQQeImO5C3M+fWPP2s3Ka+EPGjQaGmqFT7K+d9f6?=
 =?us-ascii?Q?Q1iYbBgoiyD66OwgN2AJq5zpYRniw61FeEup9ZIjH8OZj6gMTmcj4RL173lD?=
 =?us-ascii?Q?2X9VeAFBvCKb10HXIMhyrH2qNZ4eRz5+vveUjL/l+H2011A2xRt8kHgQhhGJ?=
 =?us-ascii?Q?LpmEgmlg04hWf3iMClVULQ33imernJDTuZQLC+0n/bLNxuxFbtIe5E+mZQpm?=
 =?us-ascii?Q?rclXRE64oWraorKTZ08dwtoDLOTd47yvAgdpqMrbJpJY16HeLjrfpdhsm93y?=
 =?us-ascii?Q?SLhxiN1BOcSoP1+fDGPYiv96+tO41xbvOkvz+9/gOChEustR/xaL/BSGhx/o?=
 =?us-ascii?Q?RwRUURrPa/uHu6cc60c3oodQfXz7SE/mOn6CUqhOELdzyRg2e+KUkrNeV/JW?=
 =?us-ascii?Q?lTxYSZ1PWobt4D4t2g0DqJYJXATiauftKuOAXsPqKqNilnfD5LGDuO2eeFSA?=
 =?us-ascii?Q?TCLflyk3+NTan6qNPUVA80cVXE9JGbG8gXRZcN6CAU5SCaOroqC27vvxLfiO?=
 =?us-ascii?Q?G72x9Ocnva6D9J9DkEqO8k7xB+b9xUEP8d0V7ccJoU/8wc3mhfk/tecaEMRv?=
 =?us-ascii?Q?j4b4zeVymHxOtYob4EdTyk/L8nd8ogtByjiNQnoY5UNnt9Ld/sp6ci0lRrSl?=
 =?us-ascii?Q?+JeLKdNSzhTmY742wgRlajF58mG8vFmWoj/bWeqQMnU/yZ5uBz+WCwSTAgcK?=
 =?us-ascii?Q?aWu2tOEeV65z3ZTFY7qhT6unavloK3hT6ragxqDxbepo14hb0aV09Y+kprh3?=
 =?us-ascii?Q?BIXY8S0xtcbR44Ih7TUifftrAGuCJsVxN6lx8KsOe3p/8Tu6xdsxBnmWxlSq?=
 =?us-ascii?Q?X2NC//oT4g6EzYaPzacWPzo0M6/gW2uiEymtcAxfupizsSzPnHV4Pxyx5xEB?=
 =?us-ascii?Q?0MBZfr1ctPqgGhO5sXMpGm/zQ8paV7RtcCFvH1Mu8KLdJVDXQBAEXf7EJgUN?=
 =?us-ascii?Q?mJ/sUp9kOhKmt3pCt5Fda/XHphtrOM3LHxgBGZ/PniEZCuwB/EGVAsfaoVRF?=
 =?us-ascii?Q?RfYLuw/Cou+foGIC3Bq1Jz6SC3OE7smxg/aPr6YGux1zu7GA+IlEhAF36X9Q?=
 =?us-ascii?Q?Gdr6UusitSvOw1xzP2yiXfyAxvO9YWGTYWuNpOHs8GYqpe13heVazLyRIVEq?=
 =?us-ascii?Q?/HxsQih5JD9sAZ51MMBOCdQHL//QAiJachQH5eK5c/wvKIcKSEPnCuEJF/lh?=
 =?us-ascii?Q?bJL0nCKGSPvr8r78ukBFKBLOsbnlsPyQrpC9UYsB4QTdsvsgbAYWbGXlA7Qx?=
 =?us-ascii?Q?QAip8tzwmxLC21Q5082FhF0ivhj9zfN2e9sAz94/s4f8cAupRAmyifgVVk0c?=
 =?us-ascii?Q?UKqIcMhFyS+J8sn1eZEy1XxGG3aF8pjFr5ffnbKO1PnibBpSL0sQ46CR3vgY?=
 =?us-ascii?Q?0Mwb/AtdpbBg/Pia9n8Ue85wvhjjZXJqrp473MFovGYMEaCEYJytCD0AHClF?=
 =?us-ascii?Q?JcMXKuToHl6DYRqwRcIm1oBg3jIhh6MUrEUBcJmjGbsR3Cb6yUtKOMUUKLon?=
 =?us-ascii?Q?eWNX08MqIVj+OisrN0XnOzYLqUKNvoBQdd+OvMZ/+38BJaanaEGiduwLh8sJ?=
 =?us-ascii?Q?UTr/XUUW/ZB3cuobzLTgMxHA4hFI2fr6Ljcj1h4P?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14a3c03c-12df-4ba3-312f-08dddb347215
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 13:14:05.7741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qpD1OMSDbP0ay5GMC2Ev/cwRsoXR7nxtDF8VM6l5MioohQMyIFGgqqQq9Y/89LY/Vk5b+6Rx4dmcPQWIl5eLzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2PPFDCBF4279B

Use IS_ERR_OR_NULL() instead of the original !xxx || IS_ERR(xxx) logic.
This will simplify the code and enhance readability.

Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
---
 drivers/phy/phy-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index 04a5a34e7a95..9248f2249849 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -677,7 +677,7 @@ EXPORT_SYMBOL_GPL(of_phy_get);
  */
 void of_phy_put(struct phy *phy)
 {
-	if (!phy || IS_ERR(phy))
+	if (IS_ERR_OR_NULL(phy))
 		return;
 
 	mutex_lock(&phy->mutex);
-- 
2.34.1


