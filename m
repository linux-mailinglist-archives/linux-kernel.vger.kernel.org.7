Return-Path: <linux-kernel+bounces-789470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2232AB395FE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 09:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A7081881BDC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 07:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5532C3242;
	Thu, 28 Aug 2025 07:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="SxMKloxU"
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012062.outbound.protection.outlook.com [52.101.126.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589DC277C94;
	Thu, 28 Aug 2025 07:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756367671; cv=fail; b=cBa3lAyoagd/fdRDw1MOlAIlgI061s3CY+6gFhDJ/fF7YI5AwIbBfKDyBbJf1eI2pMlKjYVLjm37LOASNiNLK5aaiTENKKZ3yK7+AP2td2hoo2ZEhWfn0gKTvvfMOGJfNP7p7WV48ycBR7hORW0cMEkgATidLjaPGyNXEfUeOFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756367671; c=relaxed/simple;
	bh=lO91waDNWtZDwT0V5LwsrE3t3/bMmgClZ6tFToSp0IA=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R3adCeFKnKztEHm/w7+Z3sV62DzYWk/FIufzSdbVT+3HW8u6dXqFFomVwnDlAexLhnghm9WbU5ckSO1pBX4fpeqnXe1Y9IZkqH/FJXCBAU0ndEIlncDdjX146U/xgEjMrFmPTW8pAYZt9tFaMrPbsS8hvaIs1L01tLy3TZ3kf+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=SxMKloxU; arc=fail smtp.client-ip=52.101.126.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AWxH5B25MK49WPIPjwzuSbsNk2gdWFfgiU2IhziAyIaVg1/5yqDCHj4JC2pD8YUR5xuPMdAiG+DnW10w3XHhzVPwQNw5fs4adbpXWYREJP/xTuVyb9cikNBSTeLjDva3jKxCP3TluNEKXADuL8DDvdS4vgC3IZQk1wgEdRFr3i2gm28bv0cRq1YjIhtClIwec1LGCsSsCHqlCIayVuCRhn05YJ4jnf3JP29TFNsCr2gv6jLm6CFmn+flsA+frnbgiXAvqKeqxtnHjIK7IToC5q9IB617PF0ssCvtZxadAFSjJW+o8hayQ0rAYLnpXIUkDb0IKfJeaDWSB4pATRvSGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2JzJN8TyWIHMhYc0+grtQD1CJ/mPU4UlaZgyQr2oi9E=;
 b=ChSdO1HN5M1TzFSq6cf/ZxdXGYmJ2nKtmUhrupVfM3FMWaUVqMqOIW4laU/MCKhpembUQ9tdBMe29Mqh3IekCPps2QXjV/L7tOW3o+m8fmS6vRHAVlJD7CMj+gc7rZsBXkwfauMGQ203ouOEgsSl4eVp/JZb4LzqwfdOrWtP+EOAvYsb478GB+kkyGMQCAEthLW7YJbqsVGf9hBvvyqKK+7bJBXc5/ABfWywPH+pKe6EL+62Tey9UHwuXXAabhlFWAC1n379qEX2GFHi3MiW4bvcK9L5RbFiuKFxidZ+IaXL2DNIjhCs2AupUzbWw6BtQQLv0zapj5aD9/WtXZ1a/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2JzJN8TyWIHMhYc0+grtQD1CJ/mPU4UlaZgyQr2oi9E=;
 b=SxMKloxUpiv2SYgbub2vHTp7BLjiNffYlI1GyBzXBzjNOijjT6mqd3x721u32oJaNfHpo1JZ1RQN37BTNQ27V45KlyNWGgTC1FLHEPLEs2Bp2MZzEO/UuNiKoDgFZ2nDiP8EOA9NUj9JKE+ZnxBe6ElqJN/mtmLz0BiQAWAwCmWYAidDUqFA5pikNCa45ObnCGViLF+jlrFTqhAtwB6mXD8cnQT4e8KCXzZt56q63a6vitGqrQ7V0mWtGJxWzVXX71gG8yKCinzICYDJMjsqymcnhVIPB6LUsnZdU1tYH3hHBH0qna/WeBtzsRZULWjQgjUPMDJr3erzZ+IAJ0KYow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 KL1PR06MB7035.apcprd06.prod.outlook.com (2603:1096:820:11b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.16; Thu, 28 Aug
 2025 07:54:26 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9073.010; Thu, 28 Aug 2025
 07:54:26 +0000
From: Qianfeng Rong <rongqianfeng@vivo.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Qianfeng Rong <rongqianfeng@vivo.com>,
	linux-sound@vger.kernel.org (open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM...),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/3] ASoC: amd: use int type to store negative error codes
Date: Thu, 28 Aug 2025 15:53:57 +0800
Message-Id: <20250828075406.386208-2-rongqianfeng@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250828075406.386208-1-rongqianfeng@vivo.com>
References: <20250828075406.386208-1-rongqianfeng@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0019.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2b1::13) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|KL1PR06MB7035:EE_
X-MS-Office365-Filtering-Correlation-Id: 573a232a-b4c2-4c08-b00f-08dde6081c2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ci9jvH74zncq47/vWqGQEZdA+Sl7i4tZBScvMGfuo2nYzGjXTGIdjFkD7i7Y?=
 =?us-ascii?Q?AUFVAC6z7/Y96yEH+0h5j6zPk+MnX0lVaKoH2I8SHSmPehcNhqjTRFnnyfWW?=
 =?us-ascii?Q?eAEHapmtL3y92ObaPh6wW2qW9+xibr5G9RPR/hmBazM8FYypDXUlD4jEUMJh?=
 =?us-ascii?Q?/ZcsiH4dUyMScyns3Sg1gYcx9wn6ZFzmAXLPjzThJTyKdQ3JMU9YGlrk/l76?=
 =?us-ascii?Q?WEj1Oh6ZOFH21ayKsODwSo6zJZF/9yJGlJ7dp3Y8ucF7VxXdXKccYvqi0EZU?=
 =?us-ascii?Q?xbd4x6v+0mBMkz1kyxJ7ipMys+6EvykkUWtbM9MYuKFhp9bcq4DmTHqajNZD?=
 =?us-ascii?Q?eWnOxuoz8bMoQmKiHO9thBw6JH3mWwv4SqKj/zppuH2OTSXFUqmbDrewabtA?=
 =?us-ascii?Q?MP4OWQzlIDGeCn3tuCPnp4CPSp4qwBtq8Qj91jSIobOXnYRap9RF5VghD/nw?=
 =?us-ascii?Q?sEyBbObB4r9ycTqEcEz8GKgrQF3jSkzjoy9+Me4pOjoTPtwn2NZU4RZKWqV7?=
 =?us-ascii?Q?8jJxxlPkurCDu5LbBnfQjQvNRVoKRdwJpa7rDjmXElzRe6+FGWrLkQmL9Y6U?=
 =?us-ascii?Q?+8tlMaY7ob77UHefaASD4TggZWitD8kawwM/YOX2qPtBYAQvmM8KeQ8sbLYW?=
 =?us-ascii?Q?nWj9SyrhK19M2GLaCr/34ia8nEPone1yd+6GunxyC0kG6phkTEqI2yp+Be+A?=
 =?us-ascii?Q?YsK5gMMuodh62fWiljDgEUreGjsgOuXdW6zpCSaIv5Fxl4uoiTBvRat+aeSK?=
 =?us-ascii?Q?oyrpcED8zq4G4rgGFwmCgKRoDt4Afk3zYETnioG5kfMr8LO4MzNjDw2SAXS6?=
 =?us-ascii?Q?jFwjtHcSB6NFvKwlnCS3TV+ALd3jtJfSi7UR9EL9ntn1eZuVB7V9/RKqfnOD?=
 =?us-ascii?Q?WLVNfKtfKq8WQCBxU9q8B1bnPNalm7vc37zDAIdp/9MIhSsn3F5Kb4scqhVv?=
 =?us-ascii?Q?VohfKStJLCsXr9BwQJNBJ27x3bc1d1CoNS8R40tzl+zAIHf+EHLGuRxsGWiP?=
 =?us-ascii?Q?JYUu5uGFyAj8iG12WvNSzrgPBdadPScPKxkCecVJBZBa2WFANsv6w1chSD/v?=
 =?us-ascii?Q?wtgEOg+lo8p96ny6Fm2Ro9NM0ZKCt1meX/D5n+AF0O3nw+ZimenxDPsulVw8?=
 =?us-ascii?Q?GoIeRitxQeUbk/RY+Qhk2aQW/z/daIiJu9DxN3nqKjX8u0XmO3RP2MFQMWKo?=
 =?us-ascii?Q?rf3NQPBvBtCLZ0WS+peFrys5IEN0D8cWloju+zA1ovG+fqWsUlrkKth5vg7j?=
 =?us-ascii?Q?32xwVKI1OA5i0pFKEVMhvWnhct39J7DYeKQhgErNh1E23+n7K0DY9iUH0DVN?=
 =?us-ascii?Q?eX3PePEd8Mj4jIRF/k2nVCHgmmdk+GkWr8OH5oY1mM8LwKGt9GwUA3B2QLPS?=
 =?us-ascii?Q?mjhAiw1vPoN1ZisZiaBikYxz22+jFIPrkeRfW3bJMaSzZEIBSEcYdoavfcab?=
 =?us-ascii?Q?75XttNRzDmtb5UJryvDMa0tnnpvaQBW/ofuI0o/brQCpfPfZSqKA8McEqalE?=
 =?us-ascii?Q?aqeTiE6B1sQSNAI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ViQJp06GtOCu+YCGComEA7YoJ2nw4b1ycGfGnO3kXpXirjQBcz0vgxaz1EeP?=
 =?us-ascii?Q?n81eWiOaEmm5HzagKyT3Ssw0nXzBZd6spqXf8zZrO9LgtzEReovohuDzbkjM?=
 =?us-ascii?Q?JuUPNJbywpxBfSqKHXBpHidWFwR6eu9rSFRRgEG/7bARCkYTGUgNisnlNEgW?=
 =?us-ascii?Q?UJlwr+2tUJyC0JINBwQ2R4qTBwA5weLJsSFSXrpgIif4iOT9U4KJX5QbO2C0?=
 =?us-ascii?Q?d9Vhp4zieZb9WwYad8weE61irhAeDQ9s+UhTXEzkacOMU3s8TjUsSru6gGAG?=
 =?us-ascii?Q?f9wlLdutdKkB1J/iGtpfJg10kgK0P7yBuYTItLfwmZIkG8QqN362JW3nfi/p?=
 =?us-ascii?Q?9oCh+POklXt0kM/PWAgzmaO3UoWyTytw2b6cwf19PIfwjQHIeEncz2ytGgij?=
 =?us-ascii?Q?sDUKxbqoPDumB1cNGdK0LuX+FF5CIeg9fb+sxMarlp/QiGUq2KTgQ7FKTahX?=
 =?us-ascii?Q?Xiswdoj3i0PM1VNPjYRVFhx99Hx1pehgYMjUNb1Nmzlg2jeJv99TT1wmV2QD?=
 =?us-ascii?Q?5Z9iSexRUid0ozbQpDzdS54YXFC2cETBufrwZHTODyQ+c/gzzOrqWB39tmm0?=
 =?us-ascii?Q?XNfeI9mulOsDRjPR183e7K+dAnwwP74rQiSfkVkjTsTefRp7fUNaZ1s3l1v3?=
 =?us-ascii?Q?Qwa0Jjfq3UnOwsgQeSoIr/xthtD18z83VD8q69hBLF1Hi+tnOTSIYo0N3fX7?=
 =?us-ascii?Q?qloNLQlEgpLC7Xub8PA/vXzaIwjiGkE6jF2WO0GJKmtqsq03NMKnYFsygv/A?=
 =?us-ascii?Q?E/U7Ixitj/GpI15v2ysZvoRiIKn/XtxUZE9yz8YwSHhehOTB8VSAjx/B7rP3?=
 =?us-ascii?Q?KL29WqMMoG8qeiqreAgxReP+5wIicOy1eRcC+jtV7zb5zbduuFPvhGlL4kbv?=
 =?us-ascii?Q?/7LQjc76YsoudMjrlwTHLT8V1TO1PC0iginOk4XvvurasioQJC3UlrpkkGmK?=
 =?us-ascii?Q?5U3YZe0oVblY8QRT6OLPNhuBSM7P6Ifd4N20jTGi+T5NIQh5Y6tbhrJJkjuW?=
 =?us-ascii?Q?TquKYqDkcnsKYM+4FhA6KobdhrDsgYiDixQqhY5FE7hc64qpqBK5W97PhnrX?=
 =?us-ascii?Q?EP7iSmyalNbC6s288gkCjViiWFh7l8Nm3uI8e0sA8d+xx2ahpLBIrArv3F88?=
 =?us-ascii?Q?aUwKQJFLAVwhNGPJRkoUh+HS+yZ+/B7ecHryPiQyAoxMou34okxLeKvjhUkV?=
 =?us-ascii?Q?P8Sl51EJyIZ5vCDKsPCgp/0KjLdl+QtciF2NQKtXEClvxn7WVMzXvAtb71iG?=
 =?us-ascii?Q?Yezy8Jq/myS/rEDDP8Ac4kQSrI9TSzsssrGd1pCoKfCUbmzfQG4RcUf6aZak?=
 =?us-ascii?Q?SstOdZqXdhWj3hEc/J+O4cL8wY6ZW3daciO56PfW1g1kLYW0Prh+bn/lpwm+?=
 =?us-ascii?Q?VJCuDKB4/++blJwsqgdoD8ptQbTkEA7FG1DsNukeiJL/Fv36TicLBCGRTMF3?=
 =?us-ascii?Q?hWjw+wPt3eOicjFJs5WZ4hwG3GXX1RSdvtshlmWJwT9MiZgnj2n7EoKp5BJs?=
 =?us-ascii?Q?+ls6Xj3QYFWAxRqndUkHzo8oRTBVz0TOkkkdgWKyAJyDDPbdPgu0lNmrb/6A?=
 =?us-ascii?Q?3mvcEGo7NpEF1z1POchd+Y6Uq+IHuq9ZA8Qmu8jW?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 573a232a-b4c2-4c08-b00f-08dde6081c2a
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 07:54:26.6297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oMKs0nbVmZLjLDEv+HkMm6qWCQWQalxS6zKifpsybJmwCGykXl+GJJmYXN4wUdRMhi8IqK7gsnDRq6w0EZLRMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB7035

Change the 'ret' variable from u32 to int to store negative error codes
directly or returned by other functions.

Storing the negative error codes in unsigned type, doesn't cause an issue
at runtime but it's ugly as pants. Additionally, assigning negative error
codes to unsigned type may trigger a GCC warning when the -Wsign-conversion
flag is enabled.

No effect on runtime.

Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
---
 sound/soc/amd/acp/acp-rembrandt.c | 2 +-
 sound/soc/amd/raven/acp3x-i2s.c   | 3 ++-
 sound/soc/amd/vangogh/acp5x-i2s.c | 3 ++-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/soc/amd/acp/acp-rembrandt.c b/sound/soc/amd/acp/acp-rembrandt.c
index aeffd24710e7..7e9c07488dcc 100644
--- a/sound/soc/amd/acp/acp-rembrandt.c
+++ b/sound/soc/amd/acp/acp-rembrandt.c
@@ -147,7 +147,7 @@ static int rembrandt_audio_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct acp_chip_info *chip;
-	u32 ret;
+	int ret;
 
 	chip = dev_get_platdata(&pdev->dev);
 	if (!chip || !chip->base) {
diff --git a/sound/soc/amd/raven/acp3x-i2s.c b/sound/soc/amd/raven/acp3x-i2s.c
index e7f2a05e802c..352485dd98b1 100644
--- a/sound/soc/amd/raven/acp3x-i2s.c
+++ b/sound/soc/amd/raven/acp3x-i2s.c
@@ -149,8 +149,9 @@ static int acp3x_i2s_trigger(struct snd_pcm_substream *substream,
 				int cmd, struct snd_soc_dai *dai)
 {
 	struct i2s_stream_instance *rtd;
-	u32 ret, val, period_bytes, reg_val, ier_val, water_val;
+	u32 val, period_bytes, reg_val, ier_val, water_val;
 	u32 buf_size, buf_reg;
+	int ret;
 
 	rtd = substream->runtime->private_data;
 	period_bytes = frames_to_bytes(substream->runtime,
diff --git a/sound/soc/amd/vangogh/acp5x-i2s.c b/sound/soc/amd/vangogh/acp5x-i2s.c
index 7dbe33f4b867..bf719f628617 100644
--- a/sound/soc/amd/vangogh/acp5x-i2s.c
+++ b/sound/soc/amd/vangogh/acp5x-i2s.c
@@ -234,8 +234,9 @@ static int acp5x_i2s_trigger(struct snd_pcm_substream *substream,
 {
 	struct i2s_stream_instance *rtd;
 	struct i2s_dev_data *adata;
-	u32 ret, val, period_bytes, reg_val, ier_val, water_val;
+	u32 val, period_bytes, reg_val, ier_val, water_val;
 	u32 buf_size, buf_reg;
+	int ret;
 
 	adata = snd_soc_dai_get_drvdata(dai);
 	rtd = substream->runtime->private_data;
-- 
2.34.1


