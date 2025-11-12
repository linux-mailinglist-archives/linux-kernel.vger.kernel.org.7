Return-Path: <linux-kernel+bounces-896587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 069D1C50BAC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 07:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 112873B66B3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 06:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A702DC349;
	Wed, 12 Nov 2025 06:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="i8zOiqGT"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013002.outbound.protection.outlook.com [52.101.83.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AED426A1B6
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 06:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762929371; cv=fail; b=M5qJL+LIlB9hnbWBD8n0T/yknsopSxWJPv/d4A5DXObeypHrrucLET/Rke9Qsivzqt3g45OlR3OHzo7486Sf9mlAjS8rFQCpY5frjUDXC1f25NTyJH4zdER59nCEkakySGAKEENMFGM+SoDgc+rR935qhpKz89X2jhiv4yNCXIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762929371; c=relaxed/simple;
	bh=tJY7AVNNl5T88n9uz/J9xO3NAfGSxNcus++1DqGMeoQ=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=pC/5kKt1KF90z3hJ3zA5lLY3mDxU7BNcXJexSXRTOQvISlwApRvln5t9DGMjZoxzELqLQGhzkNWNaSdXe64rGy9HaYeGM6h7D5ypBmL+MrKylkZwlk34gSdxjgO9hb8vCMNxCs6+F5KVPu12fhraRFtPI+HIfx2jRQqNMcEnMiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=i8zOiqGT; arc=fail smtp.client-ip=52.101.83.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GVn3leOzWPXyLx2P0TRxSAFhw1Xd5SEeUZneJDSAuu6gbHvjVxbNMbJjmq8Hz6Qq3xUEbUAxlED6Cq54pUqnum2vL5biMy8U1CraSXMhEKzmr6W1ASwPIpEDUL+O1X75r6m4EkkfBNOoDOgkMwGvypU1LcYKuz1d0syAlSTIfV7wxyukLn1rXWXT1Z5jGQc40bkBKr3Ld7rRX7eZHXLT9pXUggnGDVTwkglWrXI2XdUPvjuIxPiiL9F2iM4NWzZG9tUqf3oKPpxnNWx6YOnfkbbdIK8/ztcQKRsukSJhRDW6bYjZH9cMQxCx+Lv56nmfzKdo0ZkTWLGva307Wmysdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gxKjt1Z1Bq4CyI3t483Ol76T8TEBAGt4AcYGWCyMI98=;
 b=xMc/4bOVMa/k+MFw6+SPnkiqkKSr7ad/wNvLpM10uam/SU0yxiPy1paKznMY08PD8OF2QGAbSXbFxOampWuQShiB7FIHAfUK3DfffmzXsWH0LjcxoA/Bxufm/FUAeASdSv7nw3Jn+HSsbpCyP400aase8LiHbcUgMosGMv9I6hRyr3piBcwXPRJnC2LoenpHvsBWiY4tybNCmq9gQ7FRIXepYtzd0fNaOKcfyIO18+/WZCW02wqvamB4QGDjF7mE0TlPKdAOoc/nUNvt9XooNjel+vGHlPlw7KZBMR0O5KOhrsRDv6KWXefMGuHAsFitg3lyY0hxBtFR7TLR9BBtrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gxKjt1Z1Bq4CyI3t483Ol76T8TEBAGt4AcYGWCyMI98=;
 b=i8zOiqGTNkg3OjcXB6UQJtAWivSvMNZHkywWp8K+i8cOF17PEqDvCTdXke0K2RVdO4A6RAJFler0qfBfKPsrfVFnHzgntM6k/8lLpfUbcdeeukHu0yZBUPPTm6lTPa6OPySJQU/UfKXVs2Mf5vWzuC9ADSSqwblyO9pH13ZdhKdOccXDAVRHssi9vw05+QZUdunpiWa8S9f35qfZqNRqritI4blGj7W6uVmpK0xXQuUlw3QC3USH3Kqgv9Sb9orYgNI4UOQkOdPoeU9iYqRdShQO/WsRWWLYMqIploPDfOCc8fFhVEjgJzXAvP+AUqal1J2uYdXqKh2Re+szrQCA4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by DB9PR04MB8187.eurprd04.prod.outlook.com (2603:10a6:10:24a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 06:36:05 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33%6]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 06:36:05 +0000
From: Haibo Chen <haibo.chen@nxp.com>
Subject: [PATCH v2 0/5] mtd: spi-nor: micron-st: few clean up for micron
 spi nor chip
Date: Wed, 12 Nov 2025 14:36:18 +0800
Message-Id: <20251112-nor-v2-0-8699383714b9@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOIqFGkC/y2MQQ7CIBBFr9LMWsxMEdu48h6mC4WpnYXQgCE1D
 XcXicv389/bIXEUTnDpdoicJUnwFfpDB3a5+ycrcZWhx94Q4aB8iGo8zYwDW63PGupzjTzL1iq
 3qfIi6R3ip0Uz/da/T9j8TAqVdWzQjuQeaK5+W482vGAqpXwB+P6oU5QAAAA=
X-Change-ID: 20251107-nor-84fe07ec3363
To: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Haibo Chen <haibo.chen@nxp.com>, imx@lists.linux.dev
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762929419; l=2078;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=tJY7AVNNl5T88n9uz/J9xO3NAfGSxNcus++1DqGMeoQ=;
 b=Q76sohqWMokSU4/B9rRKw1mdJCxIEDE88FgP/TOoww2xdzxzXO/eLPVP2a1zhQX6UVji3OkkH
 QsdcWz2cENfAdEnNGnnVC2mpouc+2NnvxnP5XEN6lcPw0erc4tVnh4i
X-Developer-Key: i=haibo.chen@nxp.com; a=ed25519;
 pk=HR9LLTuVOg3BUNeAf4/FNOIkMaZvuwVJdNrGpvKDKaI=
X-ClientProxiedBy: SG2PR02CA0075.apcprd02.prod.outlook.com
 (2603:1096:4:90::15) To DU0PR04MB9496.eurprd04.prod.outlook.com
 (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|DB9PR04MB8187:EE_
X-MS-Office365-Filtering-Correlation-Id: 66a5c639-aae7-4440-ca6b-08de21b5c12f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bDVwSkN2enZDS2ZCYVc5V2hubHZJdkxUV1h3aHpYejA5N1pXVVF3ZHZ4c3Zm?=
 =?utf-8?B?c0ZRejR3M1BlYmxrNERVVktBalBJTXFoT0JWbG9lSklyNjZLUDQwQmErM1V6?=
 =?utf-8?B?ZmNTSnBnVGFLMDIzWFg1QkFjVFdKbGJyblVkeGdJbklrWEd1TFpGMHB5WVdM?=
 =?utf-8?B?VTdEbFJRRE9WTzRhSGRURnJLSDJIUmNXeDZHU3JFQ2l1ejZheW9JMGpielZL?=
 =?utf-8?B?NjR4T1NCYXpXTDRGRDRYOVN4ZWhtbURmdUJRSXMrZmtrSndKWUgxZlRScHMy?=
 =?utf-8?B?UXJNRlgzUi9nVVJKUkV6M1l1N3hnL2QxdjhTcTYwbGwzeTJPbUR6djhKMDNh?=
 =?utf-8?B?a2hualhYNnhWcmxBNTlJaGhNd1hESmpOVFNKRnpyNzB5bCt4dTIzQXNyaFls?=
 =?utf-8?B?V0tlK0Y5bFNhUEtHcGk2aXdkeDRERVJ0QXBPVlZjNjI0czhEY3lDZFBvTUY1?=
 =?utf-8?B?cXg4a3JSR1plcXFkN3ExWm5rVk5PaENsUjJ6WllrNW5HY1ZKUmJlUXo1Ritm?=
 =?utf-8?B?eUtoTXMxTG1ZV2JTeURLSE9HbW1Ed2JuWjRCdGQ1cDhrdC9kT0s0SWtGaiti?=
 =?utf-8?B?Wm91bjNjRDUySElSUnF2ME44NWJwYVVpemxEeWJsM29kRmd5T0w3VW1vSWpy?=
 =?utf-8?B?ckswUndXOWt2NnlMZGEvUmRNVDM1L2IrM0YrRytHVTNBdnA5Y3pVTWNCdnBM?=
 =?utf-8?B?SWdUeUpFeml6TWxMWXI4bmlBT0g2QVBEQTE0NnI1SFRPRUlGVjdIQm8ydjJ6?=
 =?utf-8?B?SDZDN1NNSlVGM0tjYTE1ejYrYlhIZHNRL2d0MlJTZjh1cERiK3hneis5d3BO?=
 =?utf-8?B?RmJpVHloaXFsMXhhTnFEejNzREVxUnJyWFZOcXczSEJNdU5qaDR0TDNTT0li?=
 =?utf-8?B?Rmcrd2laRWl0bUtBbzVpVWFMWEdmbWtBc2VIaFNpb1FmcTM0UWJ1ZENSNTM1?=
 =?utf-8?B?MTdSVjNrZ0o2TTA0bVBLMWFZN3ZrSTVGeDFBbm0vMmFZazhpQzBla3dWTGY5?=
 =?utf-8?B?aFcrN1VaTkZXKzdjTk9vR1BhWHpudmdLM1VkdnNid042LzNRNEx6ZmJYYWI3?=
 =?utf-8?B?T3dVYVNQcUJpaGk4anVCZnNBQ1J6OHFyblVFZ0xDWXRpL1AzR0RIeDZMYXhr?=
 =?utf-8?B?YnhqRGpFNGFKbi9LZG5HMWVKRzg4WnA1NmsyMGFHQmVXZy9TdjlmYnUxVnJ6?=
 =?utf-8?B?anU5S09GNXVobHUwVUlxT2x3a3dNRkFqU3BjbE5Zdy9CYTNrbmlSZ3NqRGdG?=
 =?utf-8?B?Z3dxWnVPbmpjRTNSUWNwcVI3dTFGdVc5QWp2dnIwa2ZFbnk2am0rQ1pPNmly?=
 =?utf-8?B?T25MVTFHUStBQ2xodC9wdHBGcnRHNzdITGdSY2pxeVhBVmM0RFJsWncwRWJa?=
 =?utf-8?B?VDJqaC95cVNjRzB4aUZ6Yys4ZmVIN1RoQUhZSlpWS2VnTVIwaitxVkpteFVQ?=
 =?utf-8?B?RU9LZVllaTJTQmcrbVNFU3VCbXpNemxUNkVrTi9obmZudHVseE1GMG9PSzYz?=
 =?utf-8?B?S2o0S2Zsek53bDI4SzZ1d2tpeS9LVVJ1VkJLY09VcTdKS05JdzJkbldTbGE3?=
 =?utf-8?B?NjFMd1ZWTks5bFpvRkNJSnl0MDRxL04rcDR3K2w2TVI0RDhaOUVjU211SE4y?=
 =?utf-8?B?dE95VnRMOEh4YVJwZHF5RG13MnA5Zk9INkl5c3RzeUY5Mm9HeUFjdDhPMTZt?=
 =?utf-8?B?RnV0SlU4NTV3UjZXYWlab3NUTWhhVlk5U1NudU02OU5qUHVkczM1SjBlRFZz?=
 =?utf-8?B?ajU4dHpHYWI2TnBmbURWNGJBeUFGQ2JuM1FmRDJZN1pNN1h2S3ZyNHhlM3Jp?=
 =?utf-8?B?MC9BSHlSSVREY1ZOVE51bDNJa0xqSDBSaFE3T2tKVVBBRlB1NWJKS1RpV3VP?=
 =?utf-8?B?dEJJTzRkYmlMaU5LaklFclhVTjAzQmNtVHJMN0twc3NWZWpaT0hIOHM4ZHg1?=
 =?utf-8?B?OUFUQTgzYjhoVkU1QkJmQjFYbmhlUXFWc0NnbDZOZE01anhsU2hBemNtOXlQ?=
 =?utf-8?B?N00vc3pXNitnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a2VxckdUY3ZxT2NJZS9WZFpGYUlMVHAzWGhkSzVZdENrVHJ2aU5KWVhWbk5u?=
 =?utf-8?B?Zks4MmhsM3JrZ2NHVW54YytYOEdPNmJDNFlFSlhnR1hDVHZvcEVwK2VDTWla?=
 =?utf-8?B?NkRJZFpGOWprT012WE9lcjAyRW83WTNBdnBENG5CS3R0UW1jdkdZaWE4dmt6?=
 =?utf-8?B?WUU5S3FMMzdXL2RSMXBpdjE1WVJRQm5iWnIyMFpEeFVWK2xscE85Zm9Fc0Ez?=
 =?utf-8?B?UkYxdHUzTzlheVArUy9DNWJOTTUza1VaRThhbnU2dVBRd1VSRUVkd05OZjdX?=
 =?utf-8?B?aW1FNi9TRnhLaSs5d25oS1JhNi9uaDdiVHRJWjltWnNKK01nTzN2SmNSUkVq?=
 =?utf-8?B?Ung4VGhqUytwcmdCcEhaY0ViclVZQmo2WDZSL01WbzJmb0ZwR0ZYTW0vVUtk?=
 =?utf-8?B?MmUxdVViYWxrdng3MlNja3V6R0szTDg0SHptMEtFL0QwSU4yQ0VOV1IxTWF5?=
 =?utf-8?B?TmJ2aGlyS2lCaXVLdFhxUXNGemdWY3BVVVVYaXFDNEw5elJzTzFQWlJ3cyth?=
 =?utf-8?B?L1dJM2FMdmZSdlZUMjg4ZVRTSHJGbXlQY1NqaDk1eE5YSzJTcVpXR2VxT2pD?=
 =?utf-8?B?dmxGWmlNTWVQblZJK0ZsUWdyNW1Hbi9tZXBqTWdlZHp4cVhkMURiMHNtVnhU?=
 =?utf-8?B?bTNxZGpxUFRRblRCdWZ2MmdacTBOUUJ2Nld5V2x6SndveVh3SFVJUk1uM2dr?=
 =?utf-8?B?QjdRQzc2OXVyM2EwUEVYV21WN3RTYjdUUnJQem9BT1ZhQ3ZtQjNtTkdUaDhY?=
 =?utf-8?B?R0c5SUpqNk1WZVJTWE0wclZzdU9RSXVjckJlbGVhaTRVR3gvb0Fyai9LUFV3?=
 =?utf-8?B?d3RoWnBCWEd6WDN0bnRTUVpxbnJkZC9HNVdDY2xjUkRxNUtNRWY0R0JLNmZR?=
 =?utf-8?B?WkxRT1pqcUpmMnNtOHg2UTczcXBKbktZQk5ma0EyU2xMNWtwTlp3RS9xYUx4?=
 =?utf-8?B?bm5ka1Q2M2J1dEtzYU9Vd2ZwMTVoYWtaY0d3NFBuRkpJY1NtR3UxTklSdXFh?=
 =?utf-8?B?aS9leGlWN2FnVWhMeGFlV29oVEdQVXdkei8rOVcxbXVENUNGa2JXNHdaNUV3?=
 =?utf-8?B?VlRwZmFwQkcvU0NqQnBWRUxuaHN2Q3djbnNTTEZqdHZ4aS9kaU1PMzVmbS8r?=
 =?utf-8?B?YW82TjRrMW1UUVdmbTBYb1dGOGZwbnBscVNMRVZISEpWNnIzSmMyKzB1RDlS?=
 =?utf-8?B?Z2Z6c1hEeXo2a1NKOGh5T245Ri9WcFh5S25tSGVEd29UMlphK0M2cGFHVDNj?=
 =?utf-8?B?Tnp2RzdybUUvWUpjcmlCeW12ZTNLU0FSWFByUEdYUm9BaVhtZG9zOGI2SnF4?=
 =?utf-8?B?bktLNTF6VW9Eb0tTcVBrN296TmN1VDNWT1JSU2RVQ3FpMi95d1NIM0R0L3Nu?=
 =?utf-8?B?MW42Wjcvd1BIRS9kM3Azc3VFaDlxeVluN2NVeFBlUHo1c0VET3ZRb2svTVRt?=
 =?utf-8?B?TmR4cHpqYnU1K0lKeWZReXZnb0hOTU5uS2hvMHVVT2k0bW9SZW9kN2JGdTVC?=
 =?utf-8?B?VTRQeGRFNEZhM3FZbmdnNFJJR1g3U2ZYTnFrMks2cEE2cFhsQmNiSnhMUGho?=
 =?utf-8?B?Y0ZyYzJVTFBNcFVwOStrcDdtYkNvZTZkTkQwTUVDS3hMNStmVnNOcStqbzlN?=
 =?utf-8?B?WmFnNC9LWGdHanpidFQ1VDFMeTZDQ25BOGwxZ0sydGNQTVFFaGhINE9MTFRO?=
 =?utf-8?B?QlVIb2FPWlpnaU1lQytTRFZPYkY0VjVwbnFQUlhGWWwzMzNPMHhCeENUNUpC?=
 =?utf-8?B?c0R4a09SazZlY3gwLzBwTWlQMU9DOVhZeVdkN0NodW9FdzBmcndUSVJzbXAr?=
 =?utf-8?B?dU5tRGlNNGx1QzlvTzZSQ1E0a3dJMk0xSzVwdi9NLzN3b2ZJYm1rekdERGJr?=
 =?utf-8?B?cG1xWFdhdWY0N2tpKzhxMmQxKzdnL05JamM4blFuRHFxcU5GWEw5ZUhDc0dt?=
 =?utf-8?B?UzVKanNOKzgranZpSk9SeTFqM3RJSHV2TkYrMTZzT2R5K0xhN1hPT1QxeEFn?=
 =?utf-8?B?TTc4bHprWng1cWdnOGhGeTd3TVhqODUrZmtOT3p4Tm8xVzVLYU42T2IwRjFU?=
 =?utf-8?B?WTIrdy9GZE9yRlord3ZyTmJ5VnV2RW9lbXlsZGNlTlIrM1Exald5NnllZHc1?=
 =?utf-8?Q?6KY+QmHlDJ0tR1enXw15UkPqx?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66a5c639-aae7-4440-ca6b-08de21b5c12f
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 06:36:04.9401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mm15LEGNhzCfei6Sk/CII8v30VUvKCQIU1fns57IrF48aq6XLM3/5TXakj1QQ+cyFcHz0AjcKKgBMiZ6OWqgUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8187

mt35xu02gcba, mt35xu01gbba and mt35xu512aba are similar, but with
different number of dies. According to the datasheet:
https://datasheet.octopart.com/MT35XU02GCBA1G12-0AAT-Micron-datasheet-138896808.pdf
these chips all support die erase command, but do not support chip
erase. But accroding to test, mt35xu512aba support chip erase, do not
support die erase. mt35xu01gbba do not support chip erase, but support
die erase. 
This patch set clean up the mt35xu512aba, and add mt35xu01gbba.
since do not have mt35xu02gcba to do the test, just add some comment
under mt35xu02gcba for further work.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
Changes in v2:
- PATCH 1: edit the commit message, mention the function move a bit up,
           and add Tudor's ack.
- PATCH 2: new involved in v2, move set_octal_dtr to late_init() to benifit
           all micron/st chips.
- PATCH 3: v1 add die erase for mt35xu512aba, but find it is wrong after test.
           mt35xu512aba can support chip erase, but not die erase.
	   v2 also remove some fixup flags and size, because mt35xu512aba has
	   SFDP.
- PATCH 4: V2 use SFDP, remove some fixup flags and size.
- PATCH 5: V2 remove the code change for mt35xu02gcba, because has no chip to
           test, just add some comment to remider a code change in future if
	   has a chance to test on this chip.
- Link to v1: https://lore.kernel.org/r/20251110-nor-v1-0-cde50c81db05@nxp.com

---
Haibo Chen (5):
      mtd: spi-nor: micron-st: rename the die_late_init functions
      mtd: spi-nor: micron-st: move set_octal_dtr to late_init()
      mtd: spi-nor: micron-st: use SFDP of mt35xu512aba
      mtd: spi-nor: micron-st: add mt35xu01gbba support
      mtd: spi-nor: micron-st: add comment for mt35xu02gcba

 drivers/mtd/spi-nor/micron-st.c | 97 +++++++++++++++++++++++------------------
 1 file changed, 54 insertions(+), 43 deletions(-)
---
base-commit: 9c0826a5d9aa4d52206dd89976858457a2a8a7ed
change-id: 20251107-nor-84fe07ec3363

Best regards,
-- 
Haibo Chen <haibo.chen@nxp.com>


