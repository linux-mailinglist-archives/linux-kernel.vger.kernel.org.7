Return-Path: <linux-kernel+bounces-789941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C006B39D2D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 14:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F61B17CD4C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 12:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E2830F935;
	Thu, 28 Aug 2025 12:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="hDZFU0zJ"
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013058.outbound.protection.outlook.com [40.107.44.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1ECC30F547
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 12:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756383860; cv=fail; b=uJspEmLM3Zxve39wzFgLNl6NtZq0JGrl3vzZXrFtEjIMVfNqmWYazDiQHhJnowU85hfrErR0JIhTxrNckcE5ho4SxaBriJRW+DDrHPFQ4CGGEcL2q3vOswdmgQqrVeN65Ns+3NZ4MQprxQWDuofy1Wx0gAHE2mmqxB3H3m/0Bz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756383860; c=relaxed/simple;
	bh=VabzfEzN2Gi8mwFabn3d9e0ONkXY3N9o4wFWsmZgy7Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J9nYC34Mei2yEksnX58g+f6cp0AlvXrMOrLz/lUUksjkQmQwKLY7616UYEYSLu+O6Xcxw1o0uDx+We3uEAUBusYSkyUrmbogYkmvQsQhSSs3LrFOBKeOq8T7Lkmi9VLdmOpO3c8MEmYzVtU8HjDJ7feXj1isTfGa+Z225aFcZSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=hDZFU0zJ; arc=fail smtp.client-ip=40.107.44.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UWnOC7XJx6ogEGe9/mSkOCAN//zeR3N20EWV5UKzMRbQkIxF+oPYKjjRUPhx4U/6i/xkLMtaarbyKMq8zuer9uuSwCusPFA+rDwM9M6AlXD2OXp0wKAHWOD6QpKMwP7jxRFNJi3dPjwNXokNvfWYC//wji0Vl86nVrI3IXf/wFtyukCmqLryto68YnkMx2uF0S6fFNYBLRDGdEuPgMELGDy7+fKZd3FaB83mxxM/Srv1sRUD/ijn+LFRj6GCZe0+41QrGIFbVO/ArcP1tSmtCEKWw5d2W6N+Ep8p7ABYR6EjALy60mV5qnOsqdCk5kpDe2Cka0URp2jPlNlLrKkNvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K9jK9THu/wZvl4j+OhEsV045sXj2Q3lIJM6VIcnRTSM=;
 b=zJ8h69f6ghQOM/o3MOdddDxg3Nujhcr87G8I8w+IbwdOqC1xS/n59yNngLyGBP+f+rK1FH+fx7X3AnfyxG8b3ATgLbx7L+NKRzt+ckOKQibpbULz7cf0EWSBTT9Yh7G6sFqJ+U6Sznjz+a2A3rv/C2CT7XLGruD8MvhBW2GqPvw307iillpE+4AVwuK7sL78wlAIJZA6+UKY2A/2Sj23w41+01qqwcWy0sA2nfqL/QId+alRRqw4lbBr+b7JIComoaCvKOfZYGh0mZoKzBjsmKw2gUBDgJXIKEyExvjWoHbhC4AkLQWB+cXa6gpGEtB+qZXhfiDSE1ChgA3LbLIZSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K9jK9THu/wZvl4j+OhEsV045sXj2Q3lIJM6VIcnRTSM=;
 b=hDZFU0zJQKGVq/q5v0wvJ9wXtGxBlOZBBl/E2BKnktKraIlRqi2W3l9or4E5ue6NxYqj7lVUUCe53uD/wQhhXh6Lic526kYO+cxEXk8XUTXxJ991ObK3nQPyRbBf8Yg0deTp6+wQzcYke7/ArBtw0NPKluAT2rRMKT7GEqTcuC631tZ9pnfF8zJUgy9xNlsGiYZZsNOItHxAacj0eIyvsHiqhhTXZH0tZW2p3h+0SlS23S24FPxjrY2wpsEGCLRLRB7j6P29AzbFAqoYBglNOPzeb8ETVDvo7/HRekg+qXR8RU3B3BbqA/zrUB4HmmHUTamrH5tgL7Y5g8BWW/1/ZA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by KL1PR06MB7287.apcprd06.prod.outlook.com (2603:1096:820:143::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.15; Thu, 28 Aug
 2025 12:24:17 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%7]) with mapi id 15.20.9073.014; Thu, 28 Aug 2025
 12:24:16 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-phy@lists.infradead.org (open list:GENERIC PHY FRAMEWORK),
	linux-kernel@vger.kernel.org (open list)
Cc: Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH 1/3] phy: hisilicon: Remove redundant ternary operators
Date: Thu, 28 Aug 2025 20:23:55 +0800
Message-Id: <20250828122401.17441-2-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250828122401.17441-1-liaoyuanhong@vivo.com>
References: <20250828122401.17441-1-liaoyuanhong@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0127.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::9) To SEZPR06MB5576.apcprd06.prod.outlook.com
 (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|KL1PR06MB7287:EE_
X-MS-Office365-Filtering-Correlation-Id: ee36725b-d2d0-470d-fe52-08dde62dce57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/2HacF1NURRYDqW1ckf8jw3dUelPA4oqyKrAWTVIGRFPOBf9afvwuzEgFCCI?=
 =?us-ascii?Q?akLKg82Z2+c8x4g25Kee78GqqWksEmjmcXgb+vI5Bl7a3VZliXz7T3HaG8YF?=
 =?us-ascii?Q?UEdUBinh/McGMbObywl8bQrIPxM92C4+J4KbIqLsnsbKfjRmUYMJKPZHOIFA?=
 =?us-ascii?Q?WVXQnCJVuHFvdO8x7BOwI/kmRjJ2xJqtKZ/VaTjjsag3AJ/mrIvp4RGrSsZW?=
 =?us-ascii?Q?4G/Fp/7OgGgOPSkfk34vcwPAhgTfm9YVvZ2lj7aSt8fCEcBvQ1YQ+1cB5k7p?=
 =?us-ascii?Q?iRTuvBQRbmJR48XYZw5iWQh7GtecfCZRJmlKnidrtvPnhlMp+H8HuQlVRHcC?=
 =?us-ascii?Q?97YrDT03K2+r2w43pMkDgzTJNobM3B6lbVtkM+c+i3GcDZy1gvUstTLO4wEr?=
 =?us-ascii?Q?2UI28Kdb5oca6lb8dPOzQjCHHbGGPwj7ww6h4HNQOebbXAbFXFrvgsivDSRD?=
 =?us-ascii?Q?3DFGyLqA1+uvQO/tVr70HDCrfyXR5Hsd39UUhvL6+d0n/+uUf/Aij43A78u3?=
 =?us-ascii?Q?KzrwFRDzShi9C2Y26UmT8GOiSf3o2LFZoUxuRMhmYqkyzrfnLiLIDwqTi6yG?=
 =?us-ascii?Q?ds5hwiwcTJaer1KDyJgyJjj06eIC125Wr4zI87LIVIRsltGrP8tBQnoKiGGU?=
 =?us-ascii?Q?NFHq5i6sVLOwatlHd8pfbCN0TXL22TXoHWsalwqJ3zk26xoncSvQhrod1AcW?=
 =?us-ascii?Q?Dhb+adGNsoZpb40wq9/NeTCHdbCJtRpn6NNOtR6380lu93X11CQS9OhJk7TY?=
 =?us-ascii?Q?hZe/QkoyPUOJNshARbypt5YoyFPDu32syj+UNv9BU6ikBYTJswc9hok3CgsL?=
 =?us-ascii?Q?c09E1TlTJHRcVWwA6cNiOkpPoZO1D6YxANP7MYn9cq54r4kzGAGwiHJppjj+?=
 =?us-ascii?Q?nbeptrghdaBbPvdKWCV5RhXzztgD8t4YaxTWRlkvg6yKL7EWz2vE+elh6MRE?=
 =?us-ascii?Q?PzcrR4GdQtBgsBXn2/l2F56vvEAPc2njwC84/j0SQt9kczxli8BT4y+kZhgX?=
 =?us-ascii?Q?iRdZg8YiyQvdPNXUmt1yxT8ckztSrdhopz3PvLIuCm9N3jmp0fJECJvhKREq?=
 =?us-ascii?Q?n+DyIfJghg8iwpT+NOkEDNIbKYaQxtJ7KJEOqMPpNyVQWFCvZLqQpP6X6+Gk?=
 =?us-ascii?Q?pgakXFG0UN0KiVQHPxS9xyNISkWVBMHQXIBMmv8ZN8QhHCAO3xrX1FdHE1CG?=
 =?us-ascii?Q?wUg2vrYXUMe0UQFXPoCJGTqFOvrC8N+VKtxr0eMEyusN4u2BpyGT1/+ulqqP?=
 =?us-ascii?Q?nkLrybfhzzi5Yhlr+1Zmjdvdr+x267Ap7F8sjShaWqy/0YNYUCQuk84ClAFW?=
 =?us-ascii?Q?cmkDFqiDr6lanXKrmkhwxSR0X617zfheuodDx7veZa8woh4JAJabyzOYwXFJ?=
 =?us-ascii?Q?8+UjDnuL4HbEPv7xolDZqqSYxx0DroNP6OuV6enqpl1/tDVIj1s115NLpM/Q?=
 =?us-ascii?Q?82KzdivGG9W9pDXnj2VaV1UuzBZ+9QDrc27OHuFzZ/itCtPq0i6LsA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R2Tj8RilkACeo+PGj2n0A0w2+gLjiBgwVvDR1RXULY91ixBgynpeTdiH4LJj?=
 =?us-ascii?Q?qWGKkcs7of4YPgMTFva1LTcw1maoyJ+VyIqymuNg18zEnElxVXMS+rBvhTlM?=
 =?us-ascii?Q?7wyP/79AFyjYFi9fZTifcELzXA1lQo4DXMUJbCgSO+m+oRS/IaYMmVp1u0j5?=
 =?us-ascii?Q?04TlXg3lTEyHRgOGM1z+NSP9S55dgyIXUhZ7jzB7cgLkuA8mInIHEKOuCZtU?=
 =?us-ascii?Q?e/jkEBtnByy+Lm4KpPSRbPzoON4m1GEt6BlH9h3kAKYXKau6d78dta6xrCMB?=
 =?us-ascii?Q?85sOziq5z3FD9BC7DWCsiru2H1p5rQSmAP5ON10hdrUZGsfKvxZbHssAPHiC?=
 =?us-ascii?Q?a06ZkG9cVKH5PUrkkRINy04dy9opKfEOcfLt16W6Egs+uZv052oG0kcld3Ih?=
 =?us-ascii?Q?Sa+B6NFRRHP8s7615EWQgA0ghYC4krz4UDSkw5uLewLHljRIbjYCuEuHVEa9?=
 =?us-ascii?Q?J6PJW9ulFKQFLTt512/O/jaF2ZrhrnN4bFsUjv/ZHRIuGiCVRsirDxeewYV0?=
 =?us-ascii?Q?+T5JTnqfUTXr3yYOc6Y51vZY9KAPtblIDpxodv006znfnzizdC6xQkX2YVQc?=
 =?us-ascii?Q?k3Uznlet+gtVtj3fMoAbci5yHOMIo671TFmDnhPoB4uYEHJ7rFbw4LOAbOEc?=
 =?us-ascii?Q?m9H5snZlcoBnSoSZej4LC3xd+iDwg1Co+G0MYNhk0MkCP4rBHlmFfQ2rJlFS?=
 =?us-ascii?Q?1zJ/5juk3EpSRlGIHy6jPAWtNFOB/VYrwMQQNd23xUoq6cLdAHJXTPL8fKvv?=
 =?us-ascii?Q?JrH8iQSFjSACIvPc4kaQOnSwqITvi28EvqXCc/wm9ZOkEjULjF2be+VFK3t8?=
 =?us-ascii?Q?jJmF4l3PxuNFfa537WbkdTtphWd8r9WvH/RDH1/MyrIhA7YEjN9Yp7NwbdXH?=
 =?us-ascii?Q?a7CjEhLPzWCgjf7Fw2xn0QwYJ1vXVmZmY4u1qAs9aliv92zfi8AfA41YtcsX?=
 =?us-ascii?Q?Sm1FLx1cFBA/0yhT48H5593ILKoT85wjsgS2cpGBPRGsQxlZun2r7V2sVTBk?=
 =?us-ascii?Q?ur2N1SeSzkvO5HQIoo+fbUY9jEaobVr8KKEr/MHOx5iA60nwyLOzAVI43RFn?=
 =?us-ascii?Q?Bipw4F4/R+Q1i3TXsPp8U8KDd7XEVr/hqPo4tXlUyfx96bVsZLYJESW/tJg/?=
 =?us-ascii?Q?EtCMYQrr3YAfAKaLc88sQIU3UOYdBu0jYNDt4IP2TazSFe1Y9k/GjdBVlGub?=
 =?us-ascii?Q?4ffdxboNAfYYneHJC7Pvug9rlU9GA5Ldha/OHrCxyG21MVPxhECQ6EhK6bJc?=
 =?us-ascii?Q?6VwG+PYXgMngRN6Rv4FTxgIo0R9WPL4tPlz8CEqvxlMMIK1WiKuibAt66uhr?=
 =?us-ascii?Q?RISNeesJkyi3pFOaLSdk0RwTj27e0ybtf2yzAeUPshqo+dwHj4Slr9KBKeNx?=
 =?us-ascii?Q?y6kA2zOTe6rOQuNBo0OBQ3KrIrjStuP4BlJoTX4PO0tKhOmaQHqZY8ZoLyeC?=
 =?us-ascii?Q?iHIijwLbgcfH5gMc+C9RAkc81Nija4tA09amdE2833MyeUzeG0fskT/OeBcm?=
 =?us-ascii?Q?kIvVdDO1MmY/epgT/vZWbtd6ZP0MEzdnciSU9N2lGA5MY1gMMtB79rA0mxgK?=
 =?us-ascii?Q?FsouYmQQ0XO87cHFg6GuBqCYOg4PjKhFY3E8weHG?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee36725b-d2d0-470d-fe52-08dde62dce57
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 12:24:16.8232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ccmHcav++6wL/CYupm/XdEL+CdOyQQSBDDVXLs9c7QdkJm0JljQyaqApAFkfRACUrx9Nt1sAL0GunGeAWxOonQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB7287

Remove redundant ternary operators to clean up the code.

Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
---
 drivers/phy/hisilicon/phy-histb-combphy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/hisilicon/phy-histb-combphy.c b/drivers/phy/hisilicon/phy-histb-combphy.c
index 7436dcae3981..9dd0bd00b4e4 100644
--- a/drivers/phy/hisilicon/phy-histb-combphy.c
+++ b/drivers/phy/hisilicon/phy-histb-combphy.c
@@ -73,7 +73,7 @@ static void nano_register_write(struct histb_combphy_priv *priv,
 
 static int is_mode_fixed(struct histb_combphy_mode *mode)
 {
-	return (mode->fixed != PHY_NONE) ? true : false;
+	return mode->fixed != PHY_NONE;
 }
 
 static int histb_combphy_set_mode(struct histb_combphy_priv *priv)
-- 
2.34.1


