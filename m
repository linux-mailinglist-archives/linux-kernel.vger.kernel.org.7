Return-Path: <linux-kernel+bounces-884065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B85C2F482
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 05:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0749E3B76D2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 04:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4387285CB6;
	Tue,  4 Nov 2025 04:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ATL71r9G"
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azhn15010054.outbound.protection.outlook.com [52.102.136.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE3F26CE3B;
	Tue,  4 Nov 2025 04:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.102.136.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762229639; cv=fail; b=p7aUh/ypbPH/IDTgimeYS/1N0CTaF10t2p8jXt8wlJw010bV2x0PygMTQPjvzr9fVULs5ZZu9p+x4TjFDU42WZOf/l0O6Rh1oT6j2KYXZP/BOywSDYeB5eY+hXDILIluHQsfqA2gceXfGF+RrCsM/TIRCBmbc/eOWfchIz2xjMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762229639; c=relaxed/simple;
	bh=MqZccHEhfNBkrGwkUH1MDF98e0x7CovbTTFMfEZDl7o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=j9XTTcymrImm+MX3bnIJmUwEFXdsm/8U4X94nlAhBf7c5QCdKF84CTsLxSa+GICQU5Bu0jF5IqdHzDxtKjwDuAlsiAo+8kduzveHUfPldCITFHY3FywQUpzJkHcngWkBkM5/utxQwkm/n/W4osLRUupn5beREtp4dZQ8OfEe6G4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ATL71r9G; arc=fail smtp.client-ip=52.102.136.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QMirQhOA7JACRzfqeiydULSP26U8u2SQrrBhLsqnX3fczx6JeX2IMaxav/qRXXsg7+fZSgpRuVH17xwMvaEcOWsN6FT4ZjZzMWejEIxTvWMck8Ygs2bwhiLjsaaTIXdXVeU6wU3enXu4xZCi8GJLd+tawiaoxjraymgL8ODXhu/9/YLtJRWKE7P1cNYqjUHeRga7W6Vv+Pb4YapjljEFbD7L54EDJIJqkEWU0ZiOjwgDoD2BQVHHHECUiV7V5As2ahHqiAnbtzXLXcMtAvAa+iaaqkiDDxFSDR3EE6UG65hoBlv6z/yNdj3qL7IausE59NCRmXuLUnWUP4BleIbgIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x5DxdrPnkQZSuNmeGpqfl6IhjNEWOA23IBnLO0AtZs8=;
 b=Tpy22VONmwBkJTHiqX4fvAPLyJe6uKhPrl5Hzs3OXXNrldC8E8Ck9Gd5gpofd4Ip+8o52hMhOyXuoKRVgKkiIlDLPrg2Of8YJQa5hOszZW7myHKcplk1zbmZqXScbyXpaEIE/dr4hU1ujvrdBbWegLPBokc6rmMNsRDNl9gFHQvqiqL1Z8DMOAvo+VqhEZzMpkQ5C/xQ2h9Yr4r6v7wpL/ik2qavnEWdsw/JtseKua88x/CnYWL8KC1gorLXo233HtIxLQ7Wvr3JOQ4ImBCsnNuWwoNXxivrNDNLswSaLMF7rko0/baoceEJBZMWy7rQ+maxr1cZF/VcXfPJdQ/p0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=google.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x5DxdrPnkQZSuNmeGpqfl6IhjNEWOA23IBnLO0AtZs8=;
 b=ATL71r9GB67QjZP7nT05rccI+5+4sxG5UxEZjMTxEUHoQvJGVRnR6vzNI4krad3ZtLNWfk2ApXysGUI06IITNdqMcz8gD/iBT/0jzuAzQZ9kdiqETnjTpbOOs+WaIDNX1VqUOGrRG/sb5qcqD+k+/FCGqXm2NZoQRoxkqAYoUjI=
Received: from BLAP220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::8)
 by SJ0PR10MB5670.namprd10.prod.outlook.com (2603:10b6:a03:3ed::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 04:13:54 +0000
Received: from BL02EPF0001A0FA.namprd03.prod.outlook.com
 (2603:10b6:208:32c:cafe::dc) by BLAP220CA0003.outlook.office365.com
 (2603:10b6:208:32c::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Tue,
 4 Nov 2025 04:13:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BL02EPF0001A0FA.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 04:13:52 +0000
Received: from DFLE211.ent.ti.com (10.64.6.69) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 3 Nov
 2025 22:13:51 -0600
Received: from DFLE201.ent.ti.com (10.64.6.59) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 3 Nov
 2025 22:13:50 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 3 Nov 2025 22:13:50 -0600
Received: from lelvem-mr05.itg.ti.com ([10.250.165.138])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5A44DgBT1277888;
	Mon, 3 Nov 2025 22:13:43 -0600
From: Baojun Xu <baojun.xu@ti.com>
To: <broonie@kernel.org>, <tiwai@suse.de>
CC: <andriy.shevchenko@linux.intel.com>, <13916275206@139.com>,
	<shenghao-ding@ti.com>, <baojun.xu@ti.com>, <linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lgirdwood@gmail.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
	<k-yi@ti.com>, <henry.lo@ti.com>, <robinchen@ti.com>, <jesse-ji@ti.com>,
	<will-wang@ti.com>, <jim.shil@goertek.com>, <toastcheng@google.com>,
	<chinkaiting@google.com>
Subject: [PATCH v1 1/2] ASoC: tas2781: Add tas5822 support
Date: Tue, 4 Nov 2025 12:13:12 +0800
Message-ID: <20251104041314.792-1-baojun.xu@ti.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FA:EE_|SJ0PR10MB5670:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ecac680-1a7d-438a-bf66-08de1b589058
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|82310400026|34020700016|36860700013|12100799066;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Oa+oKhV1w0NG8RZiyz23BOd7p8K4jugJanh2Vc/t165n2B+F+AP/frJEdtFz?=
 =?us-ascii?Q?Tvo2DeOwMZxSSb2i5NBK1cQLypa1sVzz5t4MEPvr6TeZ3N9qwqtmASshRHOr?=
 =?us-ascii?Q?mY3y6aeGNfzvTlbYVjpYXAcrfZ+8FuFiUh6pM36EPxk0ti9axUXwR9AKii0o?=
 =?us-ascii?Q?WgtyLFeyXArW0ZWfluEvupHdonqZQIvaXbeVOwKvrgSf6G+MYS+82208v28j?=
 =?us-ascii?Q?lE77wb28/izboJgUSkGTx8xbgiuJzvHT/qkqAlO3AIQgl+dnYk2cFUei+oZJ?=
 =?us-ascii?Q?wvbJBGscH1jIjSnsKhgu7u2Rl6A7/CmFrP5kwlE7kUpZZnIYpZ4SpHwDlnDC?=
 =?us-ascii?Q?bI9b3recAihnuggIpwBxkNH/Och9aVsKJD6NGs/eND5mSHXyH0HEP21Cly43?=
 =?us-ascii?Q?ED+6dRdIaVDp1ZHxQ2ct5a+tQuzjgCZ0Fwjgr5KW+lPOJdifYYCHEWWbUJ4T?=
 =?us-ascii?Q?RObEIe1nGDCZF/qVPfOA2TBG4iy8hAYD1h8siVoO7ml4GT+86EdHiid/RtpR?=
 =?us-ascii?Q?wg9Js/CXHiOCQP9g/3WSGPtvaOGSvxAQD79FX1y6Tke4UejOvkxYCPvlbF9i?=
 =?us-ascii?Q?OaxgEjs/IblTWTAqaxxKQHHK2aqfouWZRUG16Am6g52e9rUnDmzl96fb9IBc?=
 =?us-ascii?Q?GgxXmCztp0IdTuCHsF2Ot9ASnQ9wLczNKpQeQle54uJuIjaqTa3J9daa4Zm2?=
 =?us-ascii?Q?c3rHWw9v2sjebazVmrKuq7ajaMJeMH57GpANwAIoZcPpUJEho4r5XOrFlIMy?=
 =?us-ascii?Q?spyHW5mZq2G06K0yliNRfNYOz4ICoTVYZSMSW3aLFO2LzxI7FFEkg2owEQ9i?=
 =?us-ascii?Q?OGvP+A7WZrxFYfFzcQay7KF2sIId1U4YGSK+aK2wsdz8hj5ckDboj77NdJ0S?=
 =?us-ascii?Q?+cGm0+2C0CrOHwzAFvp52HaK5Qs/mG13c60LrqZwzPBFZJqstdKNks31Em5y?=
 =?us-ascii?Q?9cmCDgeOGC6knpIwuAMYZdeAg/yn/J46OhaL/nYJMhkF98JTMK1hrnPCqFVS?=
 =?us-ascii?Q?RGrjxAmm0w4Gu+RtUWGdNw3MtiMY5ksAeAF/nnrXu8L2s5/l2a5nXZBeFU+P?=
 =?us-ascii?Q?5F89u3zMOktiRipmiJBM5VynVFBv1jdcYMOuOz8002LzUQEFzf4bw8MSRgie?=
 =?us-ascii?Q?cnY5GeRKENV44jbv8I7ILy9q/IRnVfEg4qWpVpMl6gdc5fMX5sT+7GS3sFFA?=
 =?us-ascii?Q?6Qx/pMD3H59AE2q81hyru1JeM5YufSOXJWkSVlxkMRqf4NBj5PZZWC9SD8yN?=
 =?us-ascii?Q?E/HbfZuGhAM59tBPfIlptyw1V/moK77enoJqg6YllF8XawA0wVY2T+FlhC5T?=
 =?us-ascii?Q?Bpjkr3XGSRB0keiiepAjebHCTXJ2b24myAW1Duuy6Rvji3vPvCAx6XNfNKaE?=
 =?us-ascii?Q?Z9bTVCEaVpvewvBcysvoQu0CATEJWZcspb2G7TyiNqEETMglRhw6efIxrnKJ?=
 =?us-ascii?Q?nCbnIBXpy5jFsYbMe9lpwK53qrhVkkRGWXVEAyS+vNy11liwkHFPJWNjkPEn?=
 =?us-ascii?Q?iDPkbJZmelJvNRzL4K9zsW+hevFL1bcbQuwNSmGMxrabgW1JU6lzv+n4azWw?=
 =?us-ascii?Q?qudoRdhcYPFA57w6sfY=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(82310400026)(34020700016)(36860700013)(12100799066);DIR:OUT;SFP:1501;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 04:13:52.4823
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ecac680-1a7d-438a-bf66-08de1b589058
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5670

TAS5822 has on-chip DSP without current/voltage feedback.

Signed-off-by: Baojun Xu <baojun.xu@ti.com>
---
 include/sound/tas2781.h        | 1 +
 sound/soc/codecs/tas2781-i2c.c | 7 ++++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/sound/tas2781.h b/include/sound/tas2781.h
index 0fbcdb15c74b..c3b4c43dd2bf 100644
--- a/include/sound/tas2781.h
+++ b/include/sound/tas2781.h
@@ -122,6 +122,7 @@ enum audio_device {
 	TAS2781,
 	TAS5802,
 	TAS5815,
+	TAS5822,
 	TAS5825,
 	TAS5827,
 	TAS5828,
diff --git a/sound/soc/codecs/tas2781-i2c.c b/sound/soc/codecs/tas2781-i2c.c
index ba880b5de7e8..ebc7f4395f2e 100644
--- a/sound/soc/codecs/tas2781-i2c.c
+++ b/sound/soc/codecs/tas2781-i2c.c
@@ -110,6 +110,7 @@ static const struct i2c_device_id tasdevice_id[] = {
 	{ "tas2781", TAS2781 },
 	{ "tas5802", TAS5802 },
 	{ "tas5815", TAS5815 },
+	{ "tas5822", TAS5822 },
 	{ "tas5825", TAS5825 },
 	{ "tas5827", TAS5827 },
 	{ "tas5828", TAS5828 },
@@ -129,6 +130,7 @@ static const struct of_device_id tasdevice_of_match[] = {
 	{ .compatible = "ti,tas2781" },
 	{ .compatible = "ti,tas5802" },
 	{ .compatible = "ti,tas5815" },
+	{ .compatible = "ti,tas5822" },
 	{ .compatible = "ti,tas5825" },
 	{ .compatible = "ti,tas5827" },
 	{ .compatible = "ti,tas5828" },
@@ -1672,7 +1674,7 @@ static void tasdevice_fw_ready(const struct firmware *fmw,
 	tas_priv->fw_state = TASDEVICE_DSP_FW_ALL_OK;
 
 	/* There is no calibration required for
-	 * TAS5802/TAS5815/TAS5825/TAS5827/TAS5828.
+	 * TAS5802/TAS5815/TAS5822/TAS5825/TAS5827/TAS5828.
 	 */
 	if (tas_priv->chip_id < TAS5802) {
 		ret = tasdevice_create_cali_ctrls(tas_priv);
@@ -1730,6 +1732,7 @@ static void tasdevice_fw_ready(const struct firmware *fmw,
 		case TAS2781:
 		case TAS5802:
 		case TAS5815:
+		case TAS5822:
 		case TAS5825:
 		case TAS5827:
 		case TAS5828:
@@ -1895,6 +1898,7 @@ static int tasdevice_codec_probe(struct snd_soc_component *codec)
 		break;
 	case TAS5802:
 	case TAS5815:
+	case TAS5822:
 	case TAS5825:
 	case TAS5827:
 	case TAS5828:
@@ -2070,6 +2074,7 @@ static const struct acpi_device_id tasdevice_acpi_match[] = {
 	{ "TXNW2781", TAS2781 },
 	{ "TXNW5802", TAS5802 },
 	{ "TXNW5815", TAS5815 },
+	{ "TXNW5822", TAS5822 },
 	{ "TXNW5825", TAS5825 },
 	{ "TXNW5827", TAS5827 },
 	{ "TXNW5828", TAS5828 },
-- 
2.25.1


