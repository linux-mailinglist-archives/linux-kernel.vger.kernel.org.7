Return-Path: <linux-kernel+bounces-860960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8D6BF1771
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 15:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C23EC4F4FA6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 13:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3772F314B7F;
	Mon, 20 Oct 2025 13:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b="RndvMbwR"
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023098.outbound.protection.outlook.com [52.101.72.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0823002D8;
	Mon, 20 Oct 2025 13:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760965897; cv=fail; b=R2ULZPNlpxXxKwF+PWv0nSU8twikprEBm09UpX6RYTuJ92lX/f0ulBk07KUXg1IlgJR84Tv9RiztEuSoG2wCklAEYT1BjCQqKQwYoUx//PTvzRtzOgJzxlJWDD1ZIB9qYwyp4GsXYR0VhSH9jhW5OWm+JIPSuAlDQyHk3jEQ5I4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760965897; c=relaxed/simple;
	bh=lMfE4JC1bDMVIRhEx1K5TmxJ2qs84kxNJpPXO+0CusA=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=h/tnrr+oRT5z/Rae1UkoUyR2xcqMfitSVjTFveqUg57UrHS0LukoCWSvbGI3DJml1oBJmCJDSzcDLNabLqKmPBdG6BdxNSFvJ0cZNwJy+s1Nmhd7Fzh9Q+BhBvWF1FuelBA/lIL8nvCAupGx8XlisGPcJuMgvGJZhNw+h9HiNgM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (2048-bit key) header.d=phytec.de header.i=@phytec.de header.b=RndvMbwR; arc=fail smtp.client-ip=52.101.72.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tt+E6OrwT/uyYo162sjXIlPZTAzHr7ifIu+50TS+arGt9OFhDg/fH52GdR/xrG3+Am0V1WwCZ0oZqcw7vWQ6GwSXr85h9LUbMBOEZ4uDT1osWJAxHLkce5TpxSGMFCUU1AjVZ755Cb15+XFR0ICi55799l5GzUEq2BFbUDuWT4lR+TEIG0fohOeUm43I6ogHx7f8Zg37mjum5CSxTR+vXUuEPYNfhVKBsWbGcku6rhuCVLiIFsI2z6PI4U2+uojSdd/DORUEZuxiXN7vt56tqDB52s3eX8sSNL4vTDftq4V2CPv54eqNb3bfSVptWCLEqTvikPhtq0fqwMwQH+5oEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aOfiHmgywrk/sMl14sp2PQaS768H8dhkC0fB01AB1/E=;
 b=yYcmRUO0GaTRADvANcM4v8a83s3iLN8gUgCKagT+swG5ba+y/LA6Kpz7edvkh9brpG+/It6pyYafKqqlUPvaDtlufaqQ+vvD5E70ONFaLa5xXj1iDnbtMMvSjGfH2U/WIZjCPZDNejuPerV4CmJtAILpF3Xt32Bb4yoazSzCOXS6XYWdY7nbANJ/xhfpsQ1U3yYUq/vYv3h/DheCQchcMxQEDHnH5pMdaKBUbuewnYS3C7PJmdBlQ71k4byzrc/Hc4w40rvlHLrbrdbbi9A86Ax5gTP5TfaC9VORVbqLEugUtkbcLbuTHQtZYlj2AayKB2mJbDD/KnUkhdtdQbK7Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=kernel.org smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aOfiHmgywrk/sMl14sp2PQaS768H8dhkC0fB01AB1/E=;
 b=RndvMbwRfmgDxnO36Ri8ii3c/UFwZaGFxsuNEUKX2mFCjTfBrm853u8n+OYHZyJNTuAVcAZEPmZopbe5Z2PG9tujxQdOhr2YQACO1mIXeIl9TfuqnUKHtetYvDgPxFdB3pJ/DMLP7EU+9ZTYV9NOkD1hGVLcs6dntYulRGL4RPfwVKDlAu0DfEXZ8PoagiW9cTZKMmRJ2RSsEoqb5BHyc4wW9MZz9VIxDWQEwJ5A5XbyQFvoikUKuzmdgFzk6tsE1f/5jGfcYdnugvUWurJTSsezCXpfnz9cur938nS2t54rntXx5aptZmR+gOFZLXC/VHRBexBmbkpkF2TC8gtarA==
Received: from DU7P195CA0017.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:54d::27)
 by AS4P195MB1672.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:513::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 13:11:32 +0000
Received: from DU6PEPF0000A7E2.eurprd02.prod.outlook.com
 (2603:10a6:10:54d:cafe::b6) by DU7P195CA0017.outlook.office365.com
 (2603:10a6:10:54d::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.15 via Frontend Transport; Mon,
 20 Oct 2025 13:11:32 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 DU6PEPF0000A7E2.mail.protection.outlook.com (10.167.8.42) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Mon, 20 Oct 2025 13:11:32 +0000
Received: from [127.0.1.1] (172.25.39.168) by Postix.phytec.de (172.25.0.11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Mon, 20 Oct
 2025 15:11:31 +0200
From: Yannic Moog <y.moog@phytec.de>
Subject: [PATCH 0/4] arm64: dts: additions for phyboard-pollux
Date: Mon, 20 Oct 2025 15:11:21 +0200
Message-ID: <20251020-imx8mp-dts-additions-v1-0-ea9ac5652b8b@phytec.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPk09mgC/x2MSQqAMAwAvyI5G2hdsPgV8VCaqDmopREpiH+3e
 ByYmQeUk7DCWD2Q+BaV8yhg6wrC5o+VUagwNKbprbEdyp7dHpEuRU8kV/EVnV18MENvuA1Q0ph
 4kfxvp/l9P6TkoZtmAAAA
X-Change-ID: 20251014-imx8mp-dts-additions-81fac0750e3c
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, "Sascha
 Hauer" <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>
CC: <upstream@lists.phytec.de>, <devicetree@vger.kernel.org>,
	<imx@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Yannic Moog <y.moog@phytec.de>, "Stefan
 Riedmueller" <s.riedmueller@phytec.de>, Teresa Remmet <t.remmet@phytec.de>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7E2:EE_|AS4P195MB1672:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cb702b4-230c-47b1-29d1-08de0fda3071
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?enFFV0VwNjVFYTJBZC8rcHB6cERKZ3dNWjExODRSY0FTSFdmdUFoL0hCR0Zh?=
 =?utf-8?B?VTFKN3A5UjhvYnM2M2xET1BmNndXcDNCdzU5cnhwbFhiTVcySDZISmo1cGcy?=
 =?utf-8?B?UCtKVmFBMWdTNVBpNmN2NkZFQjFnVDA0VU5ZOGFVMmpEZDQyNVBka09nUHI4?=
 =?utf-8?B?ekxPZEFxWnJaZ3VzQVRxYWFkelE0SkxiZFpMamQ3WTA2cWd1dzFSendJclo4?=
 =?utf-8?B?RXhnNmF6aXZ6YWt4a2tzbmR4eEE1a3NQcXFoLzRDVkJmYStJR3dYTGJLS1ZK?=
 =?utf-8?B?aTNaUWlVdFloK1ppM1VJTFl0T01RakNQQ3VQSStBa28zNHlxRTIydExCRUo2?=
 =?utf-8?B?V3lncEdmd0orMHVXeVZzeVd2Ylk2djU3ZkkxYzd0WjdFdVh0SXZ1K2E5Y0l1?=
 =?utf-8?B?RVQ5WUNqOE9oSHVLejhibG5VZ0lHYUppaDI1RXFCRVcyRS9mbFd3cEpCVHZh?=
 =?utf-8?B?SnVhUHhaVFQrQkZoQS9GYjdFZlVibjN2YnVtY3Y0U003UkNkNEIvZ3pWUExP?=
 =?utf-8?B?U3E2UU5nVVY4cFFjdHVDMDZQZ24xTDRReVdvSGx5TnI1a0RFVktpdEhTZVRw?=
 =?utf-8?B?WXp0dHRINU85UVZvL09ZZ2svNFNMTHN4ZDRDaU0zUGdSNmZwWTVGU3JKZzlt?=
 =?utf-8?B?WnRDSC9EbEIwc2RCQVVaU2VkbEk5RFpCRGNnMENVNlE5WXY2ZGxUNk5La2VD?=
 =?utf-8?B?dTRpRXVhZ0NUS3FIWVNSZWFFV2EzY2JsY3RzaUM2Tkc3VXZEY1NmTXI2ZW90?=
 =?utf-8?B?KzVQUWxsR29iRThyRS9JMVRaMlhiREFYeEhjMlJRZGdMdUR3VXBjZ0tEbDUx?=
 =?utf-8?B?ODcwSzRRV3dXS0hlM3RSUlR2MndLazBsdklOZ0hLOHVvdndVd3ZXbGlLMmY0?=
 =?utf-8?B?VVNBVG41d2xRTGlkSXcvUzJ4Vk9nVkdzRzMwWEJ3VXZaR0RwUjllQytLbFdT?=
 =?utf-8?B?TXVUL29rYzE1K2VXMWNKR2JaWk1XZHVIcjhnS2NMQWNTL2NXa0hCZHdLOHpa?=
 =?utf-8?B?YytYa1JIVDlYMytXWk80cXVDMXdneVBhUGVnZHJBdm96Rnd1b3RsTFcxOU53?=
 =?utf-8?B?WjFtYkdzV0VUY2xPUGJyNFdGY3BzZXlYQlhXRTJuSGpWTGxKckMvUm5McU9P?=
 =?utf-8?B?cmViaGZPdUx0TUo1Z2ppdmRvUEdGTG1uSTNGbld6TTU0RjJaYWlOMCtPcExI?=
 =?utf-8?B?d3RRcCtvSzQ5UWwxUjhFd21FaEF5S1lnUUpac3VVVGZaNG9zaTZZR2w4UktV?=
 =?utf-8?B?bkQ1TlRqci9GOVBibzdYOU9SVXV0dHhnbWIyZlprdGdGTnlOUDdsd3dJRC9P?=
 =?utf-8?B?ZGtqcDFMeW55U1VMQWUwMjhPLzl5VU9JditYRzdlVEsxTS9aeTgrNnpRNlQ0?=
 =?utf-8?B?YmVwZ2w4REVaVFRxYlQxQUFnNWQzMXBkUDFCbXFZV01DczFsbTBuU25zRUFx?=
 =?utf-8?B?UnZYZzlDakpjRS8ya29NSVZkUVF4T2RQQ082dmxhQ2JnUFFtMlVsS2hIeGlQ?=
 =?utf-8?B?T2U0YTZSU1doRXJWQkZXbWUzU2lTYzMrSlVIVVlSNGpWY2xPams1dmVrWEhL?=
 =?utf-8?B?SEgwTHlkdytiSmt5aFVqM2crYW4zajdteVlMYmJkaWhVbkZ4ZVNiQ0xURDZB?=
 =?utf-8?B?RmVrWGQ4ZlJyWUliSkpZNlUva1RjNEgyUlVwSmJZTDBMYUhlcEdCM204Z0Ix?=
 =?utf-8?B?TlJlaTNUY3RCTWdLSVJudnNzbllUYkVRL3V3VmtSZlVCY1ZkVGllRTNSaEx5?=
 =?utf-8?B?bGl1b3JuaVVxVThzWXd6d1JOQlBCaDhLenV5by9uRFRYWXkxbmFUZFc2clNJ?=
 =?utf-8?B?M25qVUdaMy9GZlhaSC9mOE9oQ0RPSDhnSEloRU4veEtxVDBzdFJKQlB2eDR0?=
 =?utf-8?B?Y2IyWG45dXg3R3BEZ3ZRaHBQMlFMOG1lYTZzY3NzQjFBL1BwcW9KWm5XZXBB?=
 =?utf-8?B?aGR5dm1XWFVPMWZUbUhBSWx2czVHUmNLYVdWVWdMckpkeHhReUdsTEVQN1M0?=
 =?utf-8?B?cHRpbHZ5cEMwYklmaitMdFBjVlMvRThvTlVjbzMwQVNsak1lcmc3bWRQc2o2?=
 =?utf-8?B?ZWV0czdsTnNQSGU2OWtQbzhwb2tFeDZ4Qkh5SXFTMVhBeC9HL3FHU2dMZ3Mx?=
 =?utf-8?Q?oURo=3D?=
X-Forefront-Antispam-Report:
	CIP:91.26.50.189;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:Postix.phytec.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(1800799024)(376014);DIR:OUT;SFP:1102;
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 13:11:32.2503
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cb702b4-230c-47b1-29d1-08de0fda3071
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29;Ip=[91.26.50.189];Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7E2.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P195MB1672

Depends on [1]

This series adds missing miscellaneous hardware description to the
respective device tree files as well as a bluetooth/wifi expansion
board.

- i2c3 (basis for camera overlays)
- missing supply voltages
- PEB-WLBT-05 expansion board

[1] https://lore.kernel.org/r/20251020-imx8mp-pollux-display-overlays-v6-0-c65ceac56c53@phytec.de

---
Stefan Riedmueller (1):
      arm64: dts: imx8mp-phyboard-pollux: Enable i2c3

Yannic Moog (3):
      arm64: dts: imx8mp-phyboard-pollux: add fan-supply
      arm64: dts: imx8mp-phycore-som: add spi-nor supply vcc
      arm64: dts: imx8mp-phyboard-pollux: add PEB-WLBT-05 expansion board

 arch/arm64/boot/dts/freescale/Makefile             |   3 +
 .../imx8mp-phyboard-pollux-peb-wlbt-05.dtso        | 108 +++++++++++++++++++++
 .../dts/freescale/imx8mp-phyboard-pollux-rdk.dts   |  33 +++++++
 .../boot/dts/freescale/imx8mp-phycore-som.dtsi     |  10 ++
 4 files changed, 154 insertions(+)
---
base-commit: d95b54b0f1aeb6a2bf8b22836181ea8103629f87
change-id: 20251014-imx8mp-dts-additions-81fac0750e3c

Best regards,
-- 
Yannic Moog <y.moog@phytec.de>


