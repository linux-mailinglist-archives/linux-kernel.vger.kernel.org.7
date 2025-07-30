Return-Path: <linux-kernel+bounces-750771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E78B160E4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 15:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C17457ABD5B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 12:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B86299A8E;
	Wed, 30 Jul 2025 12:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="AwQCTLz3"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013046.outbound.protection.outlook.com [40.107.162.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42852299948;
	Wed, 30 Jul 2025 12:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753880388; cv=fail; b=KrRoNwEa7FSxZJqFIieQLLAq982HeV8l2gI78VRl5eHdcnBhIRrB3+o4Wtn4wQE5PcdnpdrpFUXPu+AdnQl97RfK3zi6NBoJrpJQ9+Ek1RRc32nMTb2jBv2a1vm3N/lDxCHQqyaMVC7cfXWMG4pWTfn1+/NARvkHrK8uuysow8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753880388; c=relaxed/simple;
	bh=e4nkD0femXnn3zSacotiOYscl6lcz8VxGWvdJtwEmes=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pgfdukIOXnVbuzd9806EcZwd7+dWFckl2ujizb2VrtyovGUppRS0XQWVNROY/nmYvu0s8uRZa3FrvKoqTveJS80HPXMoL3x5J5qrb9D0a0unzSJFuITyquMkDlTNUrG0HmqjPH7AiwCXmPj3g/fwvBZoQ/3wKiCF1XSs8Fz1Cd4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=AwQCTLz3; arc=fail smtp.client-ip=40.107.162.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jwIyV4h29Vt8PTjmApxk2ttaph/bl5h/RBCRTB46bzNsl/wcPv/Tt4IZr1XSTyHJV9orqhHNUmo/BuaorVFgNwrV3KUwyqGfltBHRg9jCEeKux8Mtca4bIdLlIYPB+llTtIVxq7qzZ2yQVNIX9oTHxtFKhNWajNTMyfXBOYXL06AhEW+FcK1mEW+GCmHulcGzPG/1rHkQlCr5/2prNp7QfmNrRYagTRp713JnU7MUeGSYWdZEp+pvs0ldHLLcHJEZ1aNoTcVQtuASF8dLA27NKoIx1EgapXhmiutzVTX2bQiz1JXdw/ywWTNwQb+p7Kqwl3FHT2vFKCa5ogF8vo0qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FJ5UZyfPvPThg6jjY6AtLJY4H/CjZX4mK34M8x2TYCQ=;
 b=Cp3eUgre4r5K2zFIDrHxsKbQ9zcbQLn2c/v4ebo/N3hxhlEeGYUt1SOHS4G5oRnPIGrjsk0yu20+OQniKCtFbmeAiRNKkg4XCi6Lh1Z/MXtQyyecXTMFXFaEjtj2T3Gpo7JsuHhpdWMKv4vdbhrrQm/UH5FpAEEEjovH1/OhpJldVfCE2XURVTvwpmf00vb8UcV1m/easy2iCoSIgny9batMXJGHDTxyr80Ands1ZR1uIpN3IF97wZMV3qNiAzjMwe8Jn++cp9eb6juOXb0QFkh+7cPY0KGcJl3YJfLPlOXeSKgz6/Z2L6zu4qDe2I+mp7Pzla+PdFRwnpmd17aDtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJ5UZyfPvPThg6jjY6AtLJY4H/CjZX4mK34M8x2TYCQ=;
 b=AwQCTLz3U0uqVmBbITfsRGb4sph2r8GeiLlcCPtaGb0LrnCAPMHT+y4isGkI7JvuNrxUlsEv1zAIbv3cOxb1zuN6JsJTRoiSvSnG2in45IL+81qFp9tinmj3hLjer7hmSUQh2zHbK2+/KjOHpUjPkQnPamEAgIrf7I/Sz92DbmDiWhfqT3yQu6ianl7VFNX2kiT/fHLp+oq1b7egG01kYMQpRcjPKFLWn8vMudPZMKySQ+EWbEDxEMG6k0xdAaeVsf6DMzxgo0CK/ZQjL8Pk3+aH5X9K9KyVDbPGuO+dxBc50vyaPlCG3WMV6kcYkhIQ9q36yq4ytfAYdt+kPu/dBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV1PR04MB9135.eurprd04.prod.outlook.com (2603:10a6:150:26::19)
 by GV1PR04MB10126.eurprd04.prod.outlook.com (2603:10a6:150:1a5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.27; Wed, 30 Jul
 2025 12:59:42 +0000
Received: from GV1PR04MB9135.eurprd04.prod.outlook.com
 ([fe80::b1f6:475e:de5d:8442]) by GV1PR04MB9135.eurprd04.prod.outlook.com
 ([fe80::b1f6:475e:de5d:8442%5]) with mapi id 15.20.8989.011; Wed, 30 Jul 2025
 12:59:42 +0000
From: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To: Abel Vesa <abelvesa@kernel.org>,
	Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
	linux-clk@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] clk: imx95-blk-ctl: Save/restore registers when RPM routines are called
Date: Wed, 30 Jul 2025 15:59:31 +0300
Message-Id: <20250730125932.357379-3-laurentiu.palcu@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250730125932.357379-1-laurentiu.palcu@oss.nxp.com>
References: <20250730125932.357379-1-laurentiu.palcu@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P192CA0020.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::25) To GV1PR04MB9135.eurprd04.prod.outlook.com
 (2603:10a6:150:26::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9135:EE_|GV1PR04MB10126:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f36c310-97bc-450f-a610-08ddcf68f2fe
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6PQdG1VRyc7s1WgFuJpWlp8C+JDF+XFIIvn4FH5N2UZJNqvoebAtgGruRR0T?=
 =?us-ascii?Q?gzFPBoDEN9hmrXL+QTi0fztcSMbbHvZLy+qijM1VcfqDxHn0Wewbzvr2mwRf?=
 =?us-ascii?Q?xPsjMz5GIuQsF3lWDm1sSw3KjkMHe0jQwPL72QK80seTpzzlsTvELC0tVn5y?=
 =?us-ascii?Q?hVqJ/Tgl0xQMtEoa67ffyn30O7YHatTYqQZ/BAE7qC1n/6VFaSQpHYaWWqPZ?=
 =?us-ascii?Q?nmupocvAvhYQgW3tZZEeKQ99mG1WOwpZhvaKfZgksLoWZwX/h907mKC/73DK?=
 =?us-ascii?Q?JpGv2GRcsfrr9NAtwC4j+ACSKHjZCZTajH4n6SEHkGBIkSch3agkHEQIQ5tb?=
 =?us-ascii?Q?fwQqoZ8dVj+LsnJxhv65eDCrJZIoYOqw3DUzLpZhDYfsSLLH9HGZJVBIcmxf?=
 =?us-ascii?Q?ePagm9RpvYtifvhps8741tGk/p6ubtddmScI+lb9IFziYQ0nDRydmNSempWY?=
 =?us-ascii?Q?IQZX2Hcj/msrtB09JarrJK/qprDu6HLYaUv5gag/vzmgEryeVZVzUmHBXFGY?=
 =?us-ascii?Q?DG9twjDN9XfzZQpknSB9gzHTBEhrrto7bBeHRIgjzHs1HKEMWfqMhJDArLoa?=
 =?us-ascii?Q?3HW0W4GfIWMqJ9y/656FZUqZXH5JfxNqwjNA0UcbjBGZRqaxs9A/frYu160D?=
 =?us-ascii?Q?P4D6+YqfIovlf3xPlUWhjntPOj81kDxmnypbAB2iqfP9drCqeS+i+Wq4DXJK?=
 =?us-ascii?Q?UidI66W8Ya7pW6N9NNfdYKkkflbRNQUXwz/tdk5fwN22uYkLRMJ9QDBQE0Aa?=
 =?us-ascii?Q?flbEJ9VFLp2SeTERcJvMIm6y5ocL3BIB1xieUMaLpC8L4LtP454GO+bKh0JS?=
 =?us-ascii?Q?KFtMz04DuuI0khTdzMfWOGvInoJufe5+WrigQwlzgDgQKpf1n7X+yfI1WIgM?=
 =?us-ascii?Q?khnxjedSo9PQPoG8eXBL53V03xbmVLz/E7vVVHWrdAaQEOIF3HoquCjHJDnx?=
 =?us-ascii?Q?EeXW8gf1C7eDTfPqpnsv3MtXCTP8aQYdvxhBv5qRe6Mi8PTuDXYOpv9d9Ygf?=
 =?us-ascii?Q?4gRmV2dLeu8fzzQyxHMPDBNSkDn1nZdrPoekeqYb7x2YujLaX9rhAt6NEU/o?=
 =?us-ascii?Q?LQA43aPJRNtFagY+oA7hk1H014LVVRhk95S0hsRyhDHw0EIbPgSo0i+OvOQ7?=
 =?us-ascii?Q?xgRXHvdfGmf+EVRqNMVnbbKVO7t1LgxxrCMIY72Hv5JP4VqqYGGz09/2c8dm?=
 =?us-ascii?Q?2r7p7bJ2jTrJsR6uIGpx9cuuhLZrgR/x1gx4Gu3Ced++ndbpBMAVFxlPE/CN?=
 =?us-ascii?Q?msD6FJVJA1RlB+2dfND37qUfFcLWp6NDAryMO3zlkhvg5tQNakIFtLVKVfEs?=
 =?us-ascii?Q?eF/8NSs6a73sKa7gKO31xMiTICkaXBEmFzopO0JZZ2nCqNbCWdSlFRn3JnMO?=
 =?us-ascii?Q?hrnFgijlLSl0xDEzmTgKGC4RuwqzYYJxXNk0eRKnLEluCe+V8RBEgeDpTH8M?=
 =?us-ascii?Q?oCBI9hRVw0I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9135.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KluOZeLtS96o2g/GkvUP4fk6/CrFGjaZyOr3I11d1sMpyKB3ljB+IST8MXs+?=
 =?us-ascii?Q?CV698m/yrBUb0JtSU+SsZopZVxChQEAlaq7Tsa7x7+7H/m53BgyrhEJtCVI6?=
 =?us-ascii?Q?4hInhBkIOrsAFbwa9jMc9+OyFvSHN6WyHiPJjcq6pEEuuO5ThEFYdr4w3f37?=
 =?us-ascii?Q?QIkDRoxMDfI14qhtHbYD6UPWj/SUPzkd2YdnScvN8Y7kGzQan+dwt08Y3ZFZ?=
 =?us-ascii?Q?wno38U2o0cCsVGvszdbs764+wz+dS/P0QigsnF6hNYRWZL45EiDbipDfPgWM?=
 =?us-ascii?Q?sKBhbhulylk0gUdr+/B1XbjZxLNnNReh/fBlgmXwJxU0UwWoEXnBdYmV2WHv?=
 =?us-ascii?Q?lLmvvbZHsQXfj8RXMEm0YzDu4EWjYNoqQBU2op9kBqW+KvDIHbhGLeKDj2qZ?=
 =?us-ascii?Q?QkB/TeES/OGQVc+r4wtPcTO37I2RIt3YFY4jrf2zjQMduE2oqoywKOsTQmde?=
 =?us-ascii?Q?B7I++AAxzqHKcojzzZ7ybC1b3nFOFsWdeQ2ZgNFdAuU0u1n0Wo431mzrP0pH?=
 =?us-ascii?Q?RsFJ6OIM/Ufua9i94h61lELWfj8I+hOwqJMgvVVEAE+vHtxEOVU1w+8LeoC3?=
 =?us-ascii?Q?9y/FWeU8aaOeVKJlm8ipUSXTSh951gYfpyzUJUrvuOTbhKUsQUbVa5K+LnS1?=
 =?us-ascii?Q?IC0wrLU8OlNHh+0paBunpB+uxkqbK+udlUXHE32Lw1hYTVHQu+g+SO+RGvUZ?=
 =?us-ascii?Q?RlMepCLdhpwDqGKjmIsLNgkvkfiZkCQ99zfs8JkEo1CZ4j3XS6djc6mLDd0Y?=
 =?us-ascii?Q?mrYOETix5AmChym/+rdhOBvfOVmb9bES/1r+J1BNofARH2pOhJbC3apJs/bd?=
 =?us-ascii?Q?QCX8wasHnho6Ee3TnDfdqr31uvD4Dp2ymXy2Wnvaw1wz6wkNxEH/zDWozzpJ?=
 =?us-ascii?Q?mNPKf0rj+AzJE9TTs8IvrG3QMxI3WFnuiafu9e4aYFtB8pBc7lZZ0I84V4R3?=
 =?us-ascii?Q?jNHV9c4n7xprI4dXFXIvhqRI4uXrqjdj+q475IrH7mmCQjT2tMqhBw4F2PNR?=
 =?us-ascii?Q?VP/e3E4/9RFSO9kMjyEqfnO/Zgxu5L8hOqri5NQCiFN9wLWIOyg2a1OLod7g?=
 =?us-ascii?Q?UqFf63P94DdQx7NYdYrZRohx37wVkTtVf6n30cKPbHZFcTCLXgUzDQy4hIl8?=
 =?us-ascii?Q?ZOjzdHaNLmK07rgKFxg1E+SB3OOJi1xD0xTVhxOD3uHAsZx9qQUt+yVM53S9?=
 =?us-ascii?Q?ZnxtDKdRSFsqoLLOXa3awLQe4lQbYR4EWbzp8ppOddgg4DBdtPkxieQ1iEGK?=
 =?us-ascii?Q?PRwFyxpl2DDq/W+2JF5c+disObEWfDn4JRt/Un2J0uHdp7qXua8aSvtoxcBt?=
 =?us-ascii?Q?R0TMN96WKWi6eStAfVUbJYaEQG/DyqWA0mmDVZu43FFY30xNS0p6WPW/yeHu?=
 =?us-ascii?Q?jXGM/QyDv9xQphRuu93J+YAjZyp6z2YB5eStoQS9qJibbC6628u8sFDpSYfv?=
 =?us-ascii?Q?dtEVNw0PiGpogIKuT/obWbTYYT9fhRkUUD5ESsZ1PZgmSIjKxTjF99Jgf5wM?=
 =?us-ascii?Q?JpKYSeNE3T4kmXjDr+Onde2ZQ12o+8Muqu9AO9A2pBcUPmXqiQIT2i2td/H0?=
 =?us-ascii?Q?/kf3QZhtmJGoYCWhpJ3ICBi7bLmzaFv6/rxY72P8vfuMMWPDYPnPMw3orncU?=
 =?us-ascii?Q?+Q=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f36c310-97bc-450f-a610-08ddcf68f2fe
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9135.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2025 12:59:41.9399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qO6W3Gbz1Vz5eprW8HyV196A6FXipaPEPzHZwW44zwr7Q0jI6zarlO3DHuKuDSf0GPnFNgqDl7ymv9QzYIFe7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10126

If runtime PM is used for the clock providers and they're part of a
power domain, then the power domain supply will be cut off when runtime
suspended. That means all BLK CTL registers belonging to that power
domain will be reset. Save the registers, then, before entering suspend
and restore them in resume.

Also, fix the suspend/resume routines and make sure we disable/enable
the clock correctly.

Signed-off-by: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
---
 drivers/clk/imx/clk-imx95-blk-ctl.c | 33 ++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/imx/clk-imx95-blk-ctl.c b/drivers/clk/imx/clk-imx95-blk-ctl.c
index c72debaf3a60b..56bed44719954 100644
--- a/drivers/clk/imx/clk-imx95-blk-ctl.c
+++ b/drivers/clk/imx/clk-imx95-blk-ctl.c
@@ -453,15 +453,24 @@ static int imx95_bc_runtime_suspend(struct device *dev)
 {
 	struct imx95_blk_ctl *bc = dev_get_drvdata(dev);
 
+	bc->clk_reg_restore = readl(bc->base + bc->pdata->clk_reg_offset);
 	clk_disable_unprepare(bc->clk_apb);
+
 	return 0;
 }
 
 static int imx95_bc_runtime_resume(struct device *dev)
 {
 	struct imx95_blk_ctl *bc = dev_get_drvdata(dev);
+	int ret;
 
-	return clk_prepare_enable(bc->clk_apb);
+	ret = clk_prepare_enable(bc->clk_apb);
+	if (ret)
+		return ret;
+
+	writel(bc->clk_reg_restore, bc->base + bc->pdata->clk_reg_offset);
+
+	return 0;
 }
 #endif
 
@@ -469,17 +478,12 @@ static int imx95_bc_runtime_resume(struct device *dev)
 static int imx95_bc_suspend(struct device *dev)
 {
 	struct imx95_blk_ctl *bc = dev_get_drvdata(dev);
-	int ret;
 
-	if (bc->pdata->rpm_enabled) {
-		ret = pm_runtime_get_sync(bc->dev);
-		if (ret < 0) {
-			pm_runtime_put_noidle(bc->dev);
-			return ret;
-		}
-	}
+	if (pm_runtime_suspended(dev))
+		return 0;
 
 	bc->clk_reg_restore = readl(bc->base + bc->pdata->clk_reg_offset);
+	clk_disable_unprepare(bc->clk_apb);
 
 	return 0;
 }
@@ -487,11 +491,16 @@ static int imx95_bc_suspend(struct device *dev)
 static int imx95_bc_resume(struct device *dev)
 {
 	struct imx95_blk_ctl *bc = dev_get_drvdata(dev);
+	int ret;
 
-	writel(bc->clk_reg_restore, bc->base + bc->pdata->clk_reg_offset);
+	if (pm_runtime_suspended(dev))
+		return 0;
 
-	if (bc->pdata->rpm_enabled)
-		pm_runtime_put(bc->dev);
+	ret = clk_prepare_enable(bc->clk_apb);
+	if (ret)
+		return ret;
+
+	writel(bc->clk_reg_restore, bc->base + bc->pdata->clk_reg_offset);
 
 	return 0;
 }
-- 
2.46.1


