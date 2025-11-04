Return-Path: <linux-kernel+bounces-884066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42EAAC2F488
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 05:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34DCA3BE9F0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 04:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362A7286887;
	Tue,  4 Nov 2025 04:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bJv0ERNO"
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazhn15012019.outbound.protection.outlook.com [52.102.137.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13FB27E1A1;
	Tue,  4 Nov 2025 04:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.102.137.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762229650; cv=fail; b=oySpPRbdyEO4HjvJ0DoSnUkB/wnhuorGV9PpJ/NzbaRDexxGpIQxjyXdXTOwe1S189Xn+GcN4YDWXC8Gw/WV1ftDu7IhLyzaHxL6xkO/WydTnl9CDBcSjmTM/RVtx6QdDF7dSpX9zKV5wSXvkbTmoFCarZT1h5Mq9zI3j5FyZtg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762229650; c=relaxed/simple;
	bh=sBLguI3nxFOho3JEnG876EzVwBwGMkufSW4I42zn2yw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b/xOuLwhagZbVlezh95FTYlHgd5PEXl0LcXlYdpsiIrc2wMcvLfoJWVn9nTGV+4UO/iOrw45gkm5q9rbQZbs/iKVURvTRvyGM5DAU7PrFwdikrYNQaI5BlB6vZq3W5SGdz603bpZu5wxK8h29YMPOcNsMeYWBZZ3Y6TgvL7MoLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=bJv0ERNO; arc=fail smtp.client-ip=52.102.137.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qe31BSodsK1cMfmk3wdOrEE6sOD6QYlwfcdpTsE2iE/1Int0kvCXQusxrjvLLA3Apaa7KdM5ibbBEInuPDiaZprMqywQGcUheLNqeJsW0Xywm//HkuPoezj+iFWeOUSj9xR/D2vtekV5t2WovC26Fv52K4NwhnGbMqOhukZnceza7Yig9EiTvUrGr3csxLHnW/5Avk6+gNlQ89eJwzz/cm64fSBM9lgOh3k979tYGgPv47QRNDK3mv5cNDpDfRAFiGYx/AK2tI64BYpcOQ4zugsUDolWd8E50kbRU05bVRRQWyDb/6mXHd9LHgkKvx4BaO7S2HqJDzaLMrDoZSPMeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zc0SfSHveOOe8rfGYUvmwfbZStxc9/SSLzfI2xd/N2w=;
 b=DV97xuUyeUwFMyYufnNJQbbVIR2c4ejhTbu5Bv73HXNcon1eGLIbxmDc3fVS3UpfZEqelB3O8naVOBXu+KUnvBuA56nLFc+1WLcA7vaCII+gEuQpIthFi+WZ827coU9heSfcxD1TrpdWu9YfScv3ClOkYk8vQKBj6UDw7+nREN6elcKnkknVeB3Mid5fhm5ZJyskau642LnR5Gm2naMASx59r1yxXP96qFWXxWtd7BjD+ZD1NwPYcs0dqpH36Eq6okEbsoXqVgzMaakH/7wDNoCBrSIkImmL2TzKHughPRznKLHht+Q/Pz9E9bFSugJ6wfilXJMrdF+RXO5Vo0lIDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=google.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zc0SfSHveOOe8rfGYUvmwfbZStxc9/SSLzfI2xd/N2w=;
 b=bJv0ERNO8syUucjYOb0a+hXzZU4hoVeIu4akShiJyhea9Ysdp4/glU4L1P8VNT16A8htz8N/2nat9LTcNJUBQ/r/2uJ1/+y86ZIXr0R+k8uXWOSBnAGXwIjJJh2WgxAnQKEeFXgo03LsWZQxB+QQseYhal72Qj0xDmTEwU8jMV0=
Received: from MN2PR20CA0012.namprd20.prod.outlook.com (2603:10b6:208:e8::25)
 by PH7PR10MB6252.namprd10.prod.outlook.com (2603:10b6:510:210::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Tue, 4 Nov
 2025 04:14:04 +0000
Received: from BL02EPF0001A100.namprd03.prod.outlook.com
 (2603:10b6:208:e8:cafe::fc) by MN2PR20CA0012.outlook.office365.com
 (2603:10b6:208:e8::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Tue,
 4 Nov 2025 04:14:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BL02EPF0001A100.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 04:14:02 +0000
Received: from DFLE210.ent.ti.com (10.64.6.68) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 3 Nov
 2025 22:13:59 -0600
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 3 Nov
 2025 22:13:59 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 3 Nov 2025 22:13:59 -0600
Received: from lelvem-mr05.itg.ti.com ([10.250.165.138])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5A44DgBU1277888;
	Mon, 3 Nov 2025 22:13:51 -0600
From: Baojun Xu <baojun.xu@ti.com>
To: <broonie@kernel.org>, <tiwai@suse.de>
CC: <andriy.shevchenko@linux.intel.com>, <13916275206@139.com>,
	<shenghao-ding@ti.com>, <baojun.xu@ti.com>, <linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lgirdwood@gmail.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
	<k-yi@ti.com>, <henry.lo@ti.com>, <robinchen@ti.com>, <jesse-ji@ti.com>,
	<will-wang@ti.com>, <jim.shil@goertek.com>, <toastcheng@google.com>,
	<chinkaiting@google.com>
Subject: [PATCH v1 2/2] ASoC: dt-bindings: ti,tas2781: Add TAS5822 support
Date: Tue, 4 Nov 2025 12:13:13 +0800
Message-ID: <20251104041314.792-2-baojun.xu@ti.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20251104041314.792-1-baojun.xu@ti.com>
References: <20251104041314.792-1-baojun.xu@ti.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A100:EE_|PH7PR10MB6252:EE_
X-MS-Office365-Filtering-Correlation-Id: 74ec1b43-9667-4539-bbd6-08de1b589678
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|34020700016|1800799024|12100799066;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?18cUIbMg0piKhcImkzZknABlHl+YVLUj/C/HO5HXtuRxQfUwLAoljqfbJTxF?=
 =?us-ascii?Q?XBP8a3pKpW97N9Q21kKPK0tLuHRBzAsek8J8k541r8oNvfZ4CzBE61JhCzgz?=
 =?us-ascii?Q?dDUoM92gdcXWCTgTMfqcKbH4XlufvbiV2/EkWwIYPgSlaKwwJNapZMC2gL2w?=
 =?us-ascii?Q?8zEy6iBva7GQCG9PIlGu+K848FI4EZd8NHxlhoci6giVzpeytaeK2HwRflbp?=
 =?us-ascii?Q?yeoQnw25P9gvdjZ1yowrcXPcAXiD8P+DiV3S6WB3KasrKmcYDCt3MVHbAHy0?=
 =?us-ascii?Q?bwccUIdVbHwlJMK+p8tfAfKY9IqcIBWzkmlhtExZEyvUqTxut6lkgAfJUHFw?=
 =?us-ascii?Q?kfhKdUwRVa4Ud74LQNcd3LkiByek0gwi1r3BsvYDn3+iR0TkichGbUTI6ZLn?=
 =?us-ascii?Q?fnVv8Ena4nH5TCNaqvvkcQwQFtf2bxnCt2NR9WZLLl2t0Yb4QAEcT8qYstfN?=
 =?us-ascii?Q?9DqkfrxWe+xn2rcCKOnDVpf2Z0/eBO0aDTxzwoI9p02Uc3ediiL6d1rxj22r?=
 =?us-ascii?Q?sb0RfZuGR+t4Ul3dCQWSG80/pauLggxbdAdL7PdkO1KezOcScEVKqmNHa7wC?=
 =?us-ascii?Q?MFXNm+hJZroOowSfuDdgYifC0KTaD/sfkbkTdUJl8/bVr4q32TDu2P/fANNJ?=
 =?us-ascii?Q?9/pqC8/swpTVOXGW8r7x1yjMB33LezA2eQ3cTO4JFEhGho5LkT3SLz/XZ7Hk?=
 =?us-ascii?Q?3wpx6sCDSRbokpPdGA8pT/lbTq12hf69Gq2u1y78pkm5EZvSAPBCuvgXPwu8?=
 =?us-ascii?Q?OyArBPM1yvt7SUFd5KcMwieIooMOwbuCI0iXoyAKT9yU22I5YYlkaMedB8JT?=
 =?us-ascii?Q?ewXmmSBXiBsymrO5W/0HgAzhco2tp8SZTAc2f7GPmKL5ZChJtSQsn9kPJMcd?=
 =?us-ascii?Q?Cww5ob76PQLrCdvIzCbxxH+jAI86HC2rZtUiKtDbde/ic3n9sUohdp+1WfFT?=
 =?us-ascii?Q?SdmC1yWzDunuEMLuz275mrlT7ybHIWeeNVHtukAOwaUYfIWGHgQYwtNEp0nA?=
 =?us-ascii?Q?zn0/uNWXsPyOre+V8sJoI7NW0OE6t3jmwiqA0EUMuywy6isdh5che3DFJuW3?=
 =?us-ascii?Q?p6D1ts9j6XqNISqbblkv6XNAM4WvPWnEAVINfxvnd9WYl7fFNBTu3WVd867f?=
 =?us-ascii?Q?8UzxaSCpmUUUiuWUR32/+MQMC5xqP0hFcoYgld2msBb163beHrENt+v14Ggy?=
 =?us-ascii?Q?6fh2s8CWpOqvooQjTZsLhLDO+18VpSohA3aPbG7onDRumrK4MhugsZD2tjrb?=
 =?us-ascii?Q?timi+aXqHRk2pkEbByPE5O/bQ0bUEw0i1the28Dh3hPjBZlG31eQzKQGpKHc?=
 =?us-ascii?Q?3zfrs0oAra5iXtpAMSYdMmltzIUqmNya8TmZwi1PedcORQmZmIBP+EFST27D?=
 =?us-ascii?Q?v5bciNCUfNHEyZ43313ITIZcHKjYmMEobfmd3iXIK3UjBVLWOBS+T9g4lHBc?=
 =?us-ascii?Q?KmWh2DpFrLH2oUIvk+1qptikGJA0O8PYZkIKQOb2pufBluan05yvbTaxVeXW?=
 =?us-ascii?Q?85Rqn1vvV0o5e14jU1DWexroh3xry6SfTrpEVovN2sL8ZpSepbVL69BkxSKE?=
 =?us-ascii?Q?o9T1cJXCCRbODTtNT+Y=3D?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(34020700016)(1800799024)(12100799066);DIR:OUT;SFP:1501;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 04:14:02.7582
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74ec1b43-9667-4539-bbd6-08de1b589678
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A100.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6252

TAS5822 is in same family with TAS58XX.

Signed-off-by: Baojun Xu <baojun.xu@ti.com>
---
 .../devicetree/bindings/sound/ti,tas2781.yaml | 27 ++++++++++++++++---
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/ti,tas2781.yaml b/Documentation/devicetree/bindings/sound/ti,tas2781.yaml
index 7f84f506013c..f0bb5faf55c8 100644
--- a/Documentation/devicetree/bindings/sound/ti,tas2781.yaml
+++ b/Documentation/devicetree/bindings/sound/ti,tas2781.yaml
@@ -24,10 +24,10 @@ description: |
   Instruments Smart Amp speaker protection algorithm. The
   integrated speaker voltage and current sense provides for real time
   monitoring of loudspeaker behavior.
-  The TAS5802/TAS5815/TAS5825/TAS5827/TAS5828 is a stereo, digital input
-  Class-D audio amplifier optimized for efficiently driving high peak
-  power into small loudspeakers. An integrated on-chip DSP supports
-  Texas Instruments Smart Amp speaker protection algorithm.
+  The TAS5802/TAS5815/TAS5822/TAS5825/TAS5827/TAS5828 is a stereo,
+  digital input Class-D audio amplifier optimized for efficiently driving
+  high peak power into small loudspeakers. An integrated on-chip DSP
+  supports Texas Instruments Smart Amp speaker protection algorithm.
 
   Specifications about the audio amplifier can be found at:
     https://www.ti.com/lit/gpn/tas2120
@@ -36,6 +36,7 @@ description: |
     https://www.ti.com/lit/gpn/tas2572
     https://www.ti.com/lit/gpn/tas2781
     https://www.ti.com/lit/gpn/tas5815
+    https://www.ti.com/lit/gpn/tas5822m
     https://www.ti.com/lit/gpn/tas5825m
     https://www.ti.com/lit/gpn/tas5827
     https://www.ti.com/lit/gpn/tas5828m
@@ -74,6 +75,9 @@ properties:
       ti,tas5815: 30-W, Digital Input, Stereo, Closed-loop Class-D Audio
       Amplifier with 96 kHz Enhanced Processing
 
+      ti,tas5822: 35-W, Digital Input, Stereo, Closed-Loop Class-D Audio
+      Amplifier with 96 kHz Enhanced Processing
+
       ti,tas5825: 38-W Stereo, Inductor-Less, Digital Input, Closed-Loop 4.5V
       to 26.4V Class-D Audio Amplifier with 192-kHz Extended Audio Processing.
 
@@ -94,6 +98,7 @@ properties:
               - ti,tas2572
               - ti,tas5802
               - ti,tas5815
+              - ti,tas5822
               - ti,tas5825
               - ti,tas5827
               - ti,tas5828
@@ -207,6 +212,20 @@ allOf:
             minimum: 0x54
             maximum: 0x57
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - ti,tas5822
+    then:
+      properties:
+        reg:
+          maxItems: 4
+          items:
+            minimum: 0x2c
+            maximum: 0x2f
+
   - if:
       properties:
         compatible:
-- 
2.25.1


