Return-Path: <linux-kernel+bounces-789510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 250AEB39688
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 10:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84CA11C26E9B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 08:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D7D2D7D2E;
	Thu, 28 Aug 2025 08:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="g/7k0MYD"
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012040.outbound.protection.outlook.com [52.101.126.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE41275872;
	Thu, 28 Aug 2025 08:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756368807; cv=fail; b=ohJqRzGQUiMdsbrdMLqx4YjHGBCykJFX6ri+xSCWD8aRvF3P54Ua3LEG8+8Gp3cCF89IPkK+R2/nwk/DAGKiognSRSjIIBhBgsOCKNCwmFXJ8tvgJBXtpBMxL5053NyCC+horWPiHXcbxn2aqQJnFUMpmqDIiRIZFLwmuIqrzGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756368807; c=relaxed/simple;
	bh=e4dCCZRVGjqVHBBsyKarrBzhkMvVyGRwHIp4mCW4zb0=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=FTeGeVT/aVOB6sOmpKuBSlypaqDWtGt5mqqLrf8ZuFoRJq4wXt2XA3gJdT9cddSUvMUoGSceDAI8/qKeH0afnDgJtnTqwgJcmHKab+Wc5EzLGQMvRvZ5hlDpKKq9DbpgCKlVoHf6imNAfP5evwnzDCKg44lFpLojm+TbNW5O8s8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=g/7k0MYD; arc=fail smtp.client-ip=52.101.126.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iuM18F+1EJ5CN10DYKN3cS6YCX0W354+wmtKYi82p80cnozX9ePewWIHzdDaEKvOs2Z31/trRTMu/9hF8E+leC0/+f0vE0QyJ7iCXsDqQpaS4lEl0ENNj99oynIUojqrOsddprw7uO56yN6ExBJQoHJabJQ/qu3eJHFFk8k3WhEPl16NepfWwXS4TVzFknkG4isXAtKFJnCyHUHOn8pMhu22EPu2rG3NqsvZ3NpAWlMidgC05eXjp6qMizEHfdA4bufQI4/f86w0Th+eVCu6oneFLqvKJ79AcJYol8di0zusJahOS9nz7xmkScPJbnCAvP47wRQ68sooTr2qDus5qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/H5jID6a1W+MV2jTYfMsOCidUS2Jtf70NtLp+iWG51k=;
 b=hdcErZARy5chxSnNaXF8h5iyXcJpczSQeEQe9aVWJZsuIc1eUADawvn9diwEnI0lbxvmFkq0HvV31ByrfLUvkmtZVd52KZ9Xff7NIq0JpEkE/V6R8nJc8l3WXK4c0c8PYNyjz6LSDhyLV26188Q/6sgi/Ukm5Za8mLIbSjUa4XUHylmdvht9Bfzt1XDQ7h9FDTKS3nB7YHT/ZHtRkcs8wvaTbHGCi2cZKLvj7iYU60na6a+gBRMQXYcbN990MLBs5jvQ8CzITvoai0GNs0dzJpiCjt+YomVgNiz1tGqc7S2l1X5Zk87EZdmiYFEnm1yOQhGmOWLVzLw2HlexJkESEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/H5jID6a1W+MV2jTYfMsOCidUS2Jtf70NtLp+iWG51k=;
 b=g/7k0MYDSWVfZFD0iHF0iUJiPwNgReXhfytLe/VD9jhGLXonM4nOtrMHJeU8uM7lq/WbiNKL0lOXeizAbCghbC43FsCtDJTyZS0A+OYW7ZwQ4OuynisN2OkfWF8LHd7qc6dnF4MkBf3XDf9pfgUwH4LA+DHtIpYG8KprdsXNAM3stvR6Ks9QArRVYYr1qOErwI4aQjFtL5N4dh9IB3LBV13iqnVJN3IUZJceKSaw9XCQrE8wpNWHJDQ/OAc6x+PMI9lVvCnTvbi3ewo4x8lio5eO6anzYDcbJqq3r4NKQCbBWKJavc/RZyjiX0pUpZpvXTkuRZF9Jae4J7d746pDkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 JH0PR06MB6602.apcprd06.prod.outlook.com (2603:1096:990:2f::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.14; Thu, 28 Aug 2025 08:13:22 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9073.010; Thu, 28 Aug 2025
 08:13:22 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Qianfeng Rong <rongqianfeng@vivo.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: lx_core: use int type to store negative error codes
Date: Thu, 28 Aug 2025 16:13:10 +0800
Message-Id: <20250828081312.393148-1-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0131.apcprd02.prod.outlook.com
 (2603:1096:4:188::6) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|JH0PR06MB6602:EE_
X-MS-Office365-Filtering-Correlation-Id: ddad0bd0-92f5-4830-a16a-08dde60ac104
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nLCin3eRv8KTfivJFzsJCq+bTyld2nFNEanR4oF7tlLMI33KvGdhEgNdBq3J?=
 =?us-ascii?Q?w6Yb0kshojVsutkqI6V/QRozi944GwfKe1+YtdOLoGw4gIUhoBSMtt71UJMW?=
 =?us-ascii?Q?bdvpWt+z3ylI84NhC1Kk6mquAs9zxIO/ECKaya51wYFiEdC0JsuyU0DtsQZw?=
 =?us-ascii?Q?jkCY2qru1PMwXee2yl3ekQzC6GT94i17ilK0D6P9BhzNwUnC+RD/XmEcJGV0?=
 =?us-ascii?Q?SoJigWRYEwboeKRpCMPsKn/xD3jrzUxOqqGv2vDg2SY8LQoNS0Z3iW4BHeNv?=
 =?us-ascii?Q?ecz5sWyKp+HumaLq4Hbn8uc0f8jWU9Hqf21Kx0Ptkpg8gPWXcX+739rVO+k5?=
 =?us-ascii?Q?Re5HZQ454zFb70FHB9uk+ChlGqZj2MAhxf/JE8lLSMcJs7i1xdnMXl2oGdWF?=
 =?us-ascii?Q?r7CukQzF2MGJ/fb8zX8oBPFObFoKtvNFfUhq4jUJw69a1jylXyHgpYXQa1tg?=
 =?us-ascii?Q?SG4vkUPTCmekgMJAIF1dm2VczGqVWrI47OAqjd09CUjSHW4mOFTjiTsnqIus?=
 =?us-ascii?Q?bKOLSzc1f6TBmkQsTl6MEp0aqaDjnVj4Tud36flws7cilvCYP1KP0q5G9jgB?=
 =?us-ascii?Q?fBkY7sVoV7tbOcxD0+a+TX6Er06lfPqWMv3vKtLOFrG6n3dyc0GO4OX/SsJq?=
 =?us-ascii?Q?0uNQZv/FGx3FKpfuvgUMeqYXSt8815YTGxsGMkAsVmg+INslKYE7IkHnhBnH?=
 =?us-ascii?Q?4LlTRw+UdQDEqYWoNMkxWVF94o19oRnLbACjko50CHMCp4J5WtHAHXJom3BD?=
 =?us-ascii?Q?+HSKexQAsWgOz4POxllMTmUg2UYvcUEf8mpIeiaq9vceys+ZdqYYBRpPEyTX?=
 =?us-ascii?Q?bAxMOG+nOctoh0BcTlobEuPgpafttR7zoMLKC9k5Nq7O2VwNi25OgwmZQosD?=
 =?us-ascii?Q?1XYzBJkGzU9p+TM3a7piJjXNKySgJWvEaeVPuKyOtIE3bDLpBomKnko7L8Xu?=
 =?us-ascii?Q?ZF+dS45vszvLklm9JXsBAV+w76sZT2+OLhi+YF6t+Gcj8pV5eduEnprCyl+c?=
 =?us-ascii?Q?Cueb6WyCAdxEIakpLf3lrDk/F8SLxVN7Tq3pASOf4UgfnAjTBkPUb6BDgjSk?=
 =?us-ascii?Q?Z789Q/9lbPzNJW4FRiZQIe21jHbNuFN72yfamCGaXOBkwncIcFb+5wnS9ajO?=
 =?us-ascii?Q?fB/PXhFV7wa4BLz3A5FbK/WP0sg9Cz7FjtIHoof8BRh15HqpITBnd8xMrzxO?=
 =?us-ascii?Q?ug7d31MShIFxU+0wlO8qHTP9kwom3PLhQVFeJFCGHKUaluwyqCruHqRDECFw?=
 =?us-ascii?Q?KQ4yY/7wLr8HkBuHoH+KfdWcbzUSE9qrx0vtPF/dmw+VqqwqtDeJbfsFm5UB?=
 =?us-ascii?Q?QT854LZ9N7NyyVIGww4v6bWHBp65GOxhNkrTJ2W8K9+0grwKzpxdKJPZX+CS?=
 =?us-ascii?Q?qjBOg60DiD0xraWkqGIETLOfjYZEeW1c3AsSmTeCAFNtvDY1T4z3lrTefRhl?=
 =?us-ascii?Q?yn9pozO5ulyJWP8fj4zO0/INnxUQtg5xgk4SEQBr6IGZp0461sUc3Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N4AdQqZpmwfKvXLYbqIANM+R1Jgb9FN4+VrnQICf7TIWj2ETm0K/1YAMqbT2?=
 =?us-ascii?Q?TC9VjSnnGhVqeBmURn28uBr8K3jRt/F+9FHo6k18HhnoPhIXI55/UMSAUOTA?=
 =?us-ascii?Q?MGdfBlMGOVZ0ZMi6FFGyMPbxWY1otuWh+eSZaYs9wXlKmSUZgyETNiupIzp+?=
 =?us-ascii?Q?2ZGu7IqofCVTHgUlxah/eVYH64TQmSbEtmchP31JOWr1DzqucR8PsENOmbkE?=
 =?us-ascii?Q?Jg+uOVW4KslpmoIbp5HTSKEV7Sp5M0vWaMBAQ+7qtA8QQciDK2CyS6Oe95N/?=
 =?us-ascii?Q?Nniq9eHt/GfDE/AGOneOFyASrEljkhfND9puPlQEguC0tki7C3ak4T+WUANL?=
 =?us-ascii?Q?5WgpolIG426775N7xW+UdiDegF13YyRQtjfVtEc51mbAu4hEoudYvGZPeFK8?=
 =?us-ascii?Q?bMRNmHsBD9WBc0/irpD1vOs/S/Apd7I0VI0ka5dYThaLQXtSaXQqkfkVDRtO?=
 =?us-ascii?Q?moY/m+1YJV3GReefYEvRLeHswDI4VzYpkyV0KjClM7xFgzI5/z5Ebg9cLj0l?=
 =?us-ascii?Q?Y4ZBy1g1FzHY2A/YBY8Ihv0LG1lXyFCd1VGnL3rH0JOSfgOfp03iV3K9P1ii?=
 =?us-ascii?Q?E+f+gt9CDW2rErRju6GcCBkbFqKI3rg/PbnqHr4rDOKsGPWuCCPml6EURikM?=
 =?us-ascii?Q?TICNbBcksckfJTN2pf7bF/9FQdclPHJuPjk9cyIgxvDINMDldjmT6ZPhTBjW?=
 =?us-ascii?Q?IsQE35i/o501nBpbIbc4JkG0hNQgsmJPgpZnX1iPD9gJoY/Gk70eksBCEwnN?=
 =?us-ascii?Q?suDi2FgMj8c4X6NSnCsNwJ51QcBHUzGcs0axTFdtPZ2a7DA9wnbGambNZ4zj?=
 =?us-ascii?Q?AY5KrgKcIafzodbeiNTqXkkRsB/Pnwc7PNJCt5uHGCGCjMKiaW71JbCbCg0M?=
 =?us-ascii?Q?6ExlhB+uDXQQd5/s9VPVsSxCSzdX5Cs0eLqCy82Ed2HolirM3nkDtiA0KUpl?=
 =?us-ascii?Q?gvbsNmZxNAwOIsjv8Nj9T8EAYkEXeGaoWIzyJYRNQtDtCXdwJ8ZbwcOKrbzm?=
 =?us-ascii?Q?mtKvHoIGj2e307cmgB82Hf11GDzmdXXT9iHBjF+guofJ2wR+m9P9sGYsx35h?=
 =?us-ascii?Q?7RRcJf2YJVLb2gUxVhYqjSSw0oMovqR/a9U7SbDGUF6yt5JZoO+7bhVAJcfl?=
 =?us-ascii?Q?P28XQQq7hoFtUaJYxj0bR8R8rLA8eiHk/JQ5D8q+dmL+m+gkXoEKK4sbywLY?=
 =?us-ascii?Q?nojn1gTArrrDUSZFrExIR8luPFyCcyhO+ihjZDHoFIVw6DhjEp6SrO0Ym128?=
 =?us-ascii?Q?00wWuLzAvUce87kYhX/dz7xh5C6pSvxkTvh3es1GvxHqb+AXhyN+tTyN2x5g?=
 =?us-ascii?Q?b2/E7LQPYh4T6nyalXZGpy5z0AUtDXBPgVynYAVMRYYMU3Vl6B8Z4RVTF59m?=
 =?us-ascii?Q?Q7lbFPqea/daj9ItnTjyoz7w1LkXhAfoORIGGERd6yFIdgMRe+5T4UXvw/yl?=
 =?us-ascii?Q?CwDHO+BI5/KwQRAh7KHwRHMiPye9K5bVCkdH10g0VhMKmR9SS+ca7WJaL+ei?=
 =?us-ascii?Q?KUVZLkjBXOD5zXBwsWZETFafW6Xkyq83hIO8xO71Vxml0csHjI+mXiHfZU9c?=
 =?us-ascii?Q?lxasWDBkAApqar3byeUhCjdKY1Rs1bYn7CvfYR+l?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddad0bd0-92f5-4830-a16a-08dde60ac104
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 08:13:22.1536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ulcO5n9kPMhFCt8JPrrw1AzG0Pkmt8qT+/AVU6ybe5OVIGzuzsnWl3n15CiFTZ193qRkYpFjrbuYtywPSnhH8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6602

Change the 'ret' variable from u16 to int to store negative error codes or
zero returned by lx_message_send_atomic().

Storing the negative error codes in unsigned type, doesn't cause an issue
at runtime but it's ugly as pants. Additionally, assigning negative error
codes to unsigned type may trigger a GCC warning when the -Wsign-conversion
flag is enabled.

No effect on runtime.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 sound/pci/lx6464es/lx_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/lx6464es/lx_core.c b/sound/pci/lx6464es/lx_core.c
index 9d95ecb299ae..a99acd1125e7 100644
--- a/sound/pci/lx6464es/lx_core.c
+++ b/sound/pci/lx6464es/lx_core.c
@@ -316,7 +316,7 @@ static int lx_message_send_atomic(struct lx6464es *chip, struct lx_rmh *rmh)
 /* low-level dsp access */
 int lx_dsp_get_version(struct lx6464es *chip, u32 *rdsp_version)
 {
-	u16 ret;
+	int ret;
 
 	mutex_lock(&chip->msg_lock);
 
@@ -330,10 +330,10 @@ int lx_dsp_get_version(struct lx6464es *chip, u32 *rdsp_version)
 
 int lx_dsp_get_clock_frequency(struct lx6464es *chip, u32 *rfreq)
 {
-	u16 ret = 0;
 	u32 freq_raw = 0;
 	u32 freq = 0;
 	u32 frequency = 0;
+	int ret;
 
 	mutex_lock(&chip->msg_lock);
 
-- 
2.34.1


