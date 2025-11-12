Return-Path: <linux-kernel+bounces-896843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 510D1C515DD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 10:33:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3B4034F4B25
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 09:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9229B2FE571;
	Wed, 12 Nov 2025 09:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HJ3KmewF"
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011005.outbound.protection.outlook.com [52.101.62.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA402F7AC2;
	Wed, 12 Nov 2025 09:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762939607; cv=fail; b=KWIu/7QnmpgDQ3uqgD1ksSdbLsbcHgQx9TEIP/6LOFgGrZLEqV1U+ajeZWpIsXd6hzetNfAHh4os+LKO2zagp8toVFxpEJ2wa8a5UPR3CFjLB2KUhOZH2fG8Cnm0dVdOV7yDp3tC+E4WWEnOtbcDLDrgkxt68ERZTfKHiVyOgD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762939607; c=relaxed/simple;
	bh=ZlVqiWqMuHX2yZE1L5L2f1qAOTNGLe4PTBPNPPmONRA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jb7Fa15A+XO5FKpb5EY9i0ZDiiGuOoKcAWQZ4Ge5YrZ1BCJXXx9iAr/T1aJEUMcpOF5WLsVeQUZIEMHT3/BDIYtD53WvWSZ1TAsvEZby1KQwMEZN0rmuvruortG8Lt46nV1cCuGT35+YS8KlvH4KQyM9jjrwu7qW2GUWI5UxVtI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=HJ3KmewF; arc=fail smtp.client-ip=52.101.62.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tu/4KB67NzKHLFnu1AC+nsH8ZCxMy/pXwykpKTi7hBV6V7GbOQrumqsVQCavNYWlHLK9s9XHg5BN5VC3nCbIt6KtIVeNCN3TAGKCRx6hsb47QTva28Vo4dt0Qao6sT0UzQN49XNCx+lMSRqsTCpvkEQQlX6HZmDs7DoA6Nb0h6nRPKu1dzYREvxLX6SRTVGPOhNIws7/fL73zMHh7sOYRsOOZ4dJTAei0tzsNVXoJWqTCihvtzNdNNiwMj5Y6ThCLK64tgwqbrBv7AQFg0/ZhUXsWmLPGRGA8z1UrYf7V+k9HCAFvtn01cXGw26hhb+9RpLfOVcodgVxy4kYAF/IKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uf2VGhHJKsSBiy7DSR4Q1l9I/rwjue9ZJ9LA+SDYAwc=;
 b=H/44Aj3lC5se6zgyrqqQdHs3FnfEJYwyBlfHyFQ8tWKU/whYynkvRnUtvh7xgU02rG4zaB0tOJS5PN+sWpMlcuOmOtVWiO/cuL3W0nkUwdXgtdWcH7PD287L/O8qITChfrMtHGmfFq9Ssgvxzyewinz9vmPkPnCPJlP2ViNipHOI2F97qj33/kdd5ht2TPqcHqbmmk27hFdq7TzYbdJWUJxiwue0Iaj09g8tx/ck7djtFIGAeveG6rQLsPHDPj1R/e9kjYnpBIvEra4HVjasfGpW1B6NE6zh9ixKdEReljZgU1tYGH3RyGcOYPk6CFsOjUEuliiuJanNe/je7igZfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=linaro.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uf2VGhHJKsSBiy7DSR4Q1l9I/rwjue9ZJ9LA+SDYAwc=;
 b=HJ3KmewFANvHKMqUZT8bVsnfqILuzMKaYZcny9o4y+BAhRNdhR4PEz6Ylb18W52+JLpSPKUYK06XtO4zLwKHCPNHrfoBLiebt49wG6QKAmjXKGI9jP/MvyKp1zABpFKLLTskT1Fdu1fMkdavO2Et1O0xs+AlAFS9D+8/kr1Y/Qw=
Received: from CH2PR20CA0015.namprd20.prod.outlook.com (2603:10b6:610:58::25)
 by SJ5PPFA7DBF91DC.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7c1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Wed, 12 Nov
 2025 09:26:41 +0000
Received: from CH1PEPF0000AD78.namprd04.prod.outlook.com
 (2603:10b6:610:58:cafe::d4) by CH2PR20CA0015.outlook.office365.com
 (2603:10b6:610:58::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Wed,
 12 Nov 2025 09:26:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CH1PEPF0000AD78.mail.protection.outlook.com (10.167.244.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 09:26:40 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 03:26:38 -0600
Received: from DFLE201.ent.ti.com (10.64.6.59) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 03:26:38 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 12 Nov 2025 03:26:38 -0600
Received: from lelvem-mr05.itg.ti.com ([10.250.165.138])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5AC9QUV62424783;
	Wed, 12 Nov 2025 03:26:31 -0600
From: Baojun Xu <baojun.xu@ti.com>
To: <tiwai@suse.de>
CC: <robh+dt@kernel.org>, <andriy.shevchenko@linux.intel.com>,
	<lgirdwood@gmail.com>, <perex@perex.cz>, <shenghao-ding@ti.com>,
	<navada@ti.com>, <13916275206@139.com>, <v-hampiholi@ti.com>, <v-po@ti.com>,
	<linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<liam.r.girdwood@intel.com>, <yung-chuan.liao@linux.intel.com>,
	<baojun.xu@ti.com>, <broonie@kernel.org>, <antheas.dk@gmail.com>,
	<stuart.a.hayhurst@gmail.com>, <dan.carpenter@linaro.org>
Subject: [PATCH v1] ALSA: hda/tas2781: Correct the wrong project ID
Date: Wed, 12 Nov 2025 17:26:09 +0800
Message-ID: <20251112092609.15865-1-baojun.xu@ti.com>
X-Mailer: git-send-email 2.43.0.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD78:EE_|SJ5PPFA7DBF91DC:EE_
X-MS-Office365-Filtering-Correlation-Id: d70843da-40e6-4503-ef5d-08de21cd967f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6ZH6NbUb1XwxCePNz8hpbTgED6nzWI9gBE0VcP8eyeDP5u+kSNRrmdvWlx4p?=
 =?us-ascii?Q?/W6F7zBBY96mEoj030wnR+BS11cCnag+yYEzJmsQ+5pCoqQN48INmji0+XLX?=
 =?us-ascii?Q?cjda8rMtjJhq0AxkZY8o3EaIPom0Qz2q9qDNShvWztckzBE708T8MSacP0Kh?=
 =?us-ascii?Q?PX6Q0+gJhngi/2wAkzf8Cax/W0WkWID2LOYHoDFh9IYm3WLHu9kgWPj+wNne?=
 =?us-ascii?Q?s3ZH800/Uwk9uOP+qZ9O6uytIgrvZLNWubDjgmuLZu+5WJ/WYi9qMmTBmq9/?=
 =?us-ascii?Q?bubmGEf5tv3DBWZ0XEHkOPCjOZUE91lgQgOqAK5Wo09gnVcbOG2swYAfy5AZ?=
 =?us-ascii?Q?eyNy+1fqlBHZEf5ILZmxUW5H6cfmDzEvsTLVgFezQeDgEpANBF95Pv3qpJ+t?=
 =?us-ascii?Q?vWcxzRP+nptEP1rWSWnKzCBRROd77ezKo/AnrqNjBNbZKKriNC0R/F2rLov7?=
 =?us-ascii?Q?+e5r1XvuY4DDMOnG+ZL7Aq000R0RJludvbXwsm7mz5UlRrlFyiCXCgO8oohO?=
 =?us-ascii?Q?DX/Pv/kv/I5a+9lq8P9nuVymzskpe8Wpc5wg2ZK7mKbt3tYb9iHdTOgE1AMi?=
 =?us-ascii?Q?F0q2s3bw5PO4pdJ04MdzLRyPaTZh8yThj2EedjwalGHXmLoEisuAsk2PJjKj?=
 =?us-ascii?Q?LM0PPIGsLHohjOD8aqeiotK7RNMcxjHpII+Z3lPTqsYOwYrblFBcskbK+9kC?=
 =?us-ascii?Q?oG2kdlxSOZaqOgPGJ1dUkE3RjjsvomvLNkq2U8lF7yy23sBcANd0tFzIHl5L?=
 =?us-ascii?Q?J0BsGfnVpXGloXraz9Gvv7NMj1xHmkLc2Uh8DO7EGuqb6Qp+6kY7bNdzfYVw?=
 =?us-ascii?Q?XJ57iuKXYbMNR4C1U5ddE9owC2wpzkO5aFmukBvIdLdqgNLU9xNce/nYc8Ix?=
 =?us-ascii?Q?tNwmJgG7oifZEBfBHfA8I2zEPYqCay/yq6t5lhi4OVJp/bokfkqygyzOK8n7?=
 =?us-ascii?Q?GqDXwVh12ldvR9YnVC2wh9yXQW8KS/LHvrohH+jQkNafjDINU+MVjZLwtTBs?=
 =?us-ascii?Q?r5pyPNXvPg7QAeZEuJVJ+KJ15DH5cyq5SiBSnRBydvZrUNqcaxawuJIurKSk?=
 =?us-ascii?Q?XLKoSo39/zUKJ3rCy9yvNJS7pR8y1An7qVCX+08XXyEduww6xINjj9RxUp/D?=
 =?us-ascii?Q?RD2RERIG7YCHjXpMBoZtVxO2Tc8OtqG0HjRtgbl2W/8R+6tfcMN3KRzQEC+S?=
 =?us-ascii?Q?E+BoCiZ1rSJhq/zNYQtywrZhadwk9b6M/yjamvAGE/TCSH6fgAyqAyjeNYR7?=
 =?us-ascii?Q?ZXyl8hsnhCsWjw8Dn4o8GMnNMKzdlpg5jOn9czB31QAjdvfii6MQZIYRuiWg?=
 =?us-ascii?Q?uaxCargrQtWxYWZD0Bt9CSr+ugMhpaQTcS2wkOFa4h7zXGyWPTbwiMg6npne?=
 =?us-ascii?Q?dB5BfJmQIxwBOdZ6f6L2s5VheRuhAhuxbwK7sa8UqO7anIFEci8S8wOySf9V?=
 =?us-ascii?Q?4RZxCxduBq9hR6llHdaPJX38TCxLMbPzJWfRBZmuD8ZpG2/aBkqXEcazzNX7?=
 =?us-ascii?Q?QTHy3b6feAULyQ3RKzmfE8f0MIZyYMRs6D3lYV4EVMZy+YtcisqID1goMqrj?=
 =?us-ascii?Q?2vnljoGYyhXJ6kE6Voo=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 09:26:40.9370
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d70843da-40e6-4503-ef5d-08de21cd967f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD78.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFA7DBF91DC

The project hardware ID should be ALC287_FIXUP_TXNW2781_I2C,
not ALC287_FIXUP_TAS2781_I2C for HP Lampass projects.

Fixes: 7a39c723b747 ("ALSA: hda/tas2781: Add new quirk for HP new projects")
Signed-off-by: Baojun Xu <baojun.xu@ti.com>
---
 sound/hda/codecs/realtek/alc269.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index a9698bf26887..269b6c1e3b6d 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -6700,9 +6700,9 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8ed8, "HP Merino16", ALC245_FIXUP_TAS2781_SPI_2),
 	SND_PCI_QUIRK(0x103c, 0x8ed9, "HP Merino14W", ALC245_FIXUP_TAS2781_SPI_2),
 	SND_PCI_QUIRK(0x103c, 0x8eda, "HP Merino16W", ALC245_FIXUP_TAS2781_SPI_2),
-	SND_PCI_QUIRK(0x103c, 0x8f40, "HP Lampas14", ALC287_FIXUP_TAS2781_I2C),
-	SND_PCI_QUIRK(0x103c, 0x8f41, "HP Lampas16", ALC287_FIXUP_TAS2781_I2C),
-	SND_PCI_QUIRK(0x103c, 0x8f42, "HP LampasW14", ALC287_FIXUP_TAS2781_I2C),
+	SND_PCI_QUIRK(0x103c, 0x8f40, "HP Lampas14", ALC287_FIXUP_TXNW2781_I2C),
+	SND_PCI_QUIRK(0x103c, 0x8f41, "HP Lampas16", ALC287_FIXUP_TXNW2781_I2C),
+	SND_PCI_QUIRK(0x103c, 0x8f42, "HP LampasW14", ALC287_FIXUP_TXNW2781_I2C),
 	SND_PCI_QUIRK(0x1043, 0x1032, "ASUS VivoBook X513EA", ALC256_FIXUP_ASUS_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x1034, "ASUS GU605C", ALC285_FIXUP_ASUS_GU605_SPI_SPEAKER2_TO_DAC1),
 	SND_PCI_QUIRK(0x1043, 0x103e, "ASUS X540SA", ALC256_FIXUP_ASUS_MIC),
-- 
2.25.1


