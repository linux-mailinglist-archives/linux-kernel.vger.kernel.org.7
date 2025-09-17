Return-Path: <linux-kernel+bounces-820263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5DB7B7D22E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E582B4E0B99
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 08:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3ADE30BBAE;
	Wed, 17 Sep 2025 08:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CCpmleVj"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010045.outbound.protection.outlook.com [52.101.84.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B4930C606;
	Wed, 17 Sep 2025 08:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758098557; cv=fail; b=tu036xyb4RuuILzbEF5qidSaZggAY44DufnPOn9IFZ9kjGSTc0vNzdIqh/2OFE0/7xcdJYDXuMKNru5GGLGX3zrfF/KjqhHrh7AMi02eZ0iqsp7n2/IWbgCXydK6yoUTXyYJddC5e6455KGSGomiHeCkoH7qc2I/V84W8D9BQxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758098557; c=relaxed/simple;
	bh=Qp+ybvx6rGo8AF8Qqgho9cmoEnaHO6FoU98rFa7dqd8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=tWrdlc6pM6I2/uwfQzsHWU7SQc43vdC9GNCaY4HnrVgCHT+k9v241uWSSqqViodiROdBa8UyIoHDyqzV4pvzasFIOEHTyodQtfvr5VUwWzYf3azGmK4a03nk2MaOjWsFXWuBZnAwoIrepn3JNHeJxw9HsGpuHbmEWsxACp7OUv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CCpmleVj; arc=fail smtp.client-ip=52.101.84.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j4yhbAhrdWqUQ5WWBPle5uNCtROHxKVv0oA5iW8ovyWWwfXpnbwVs47WgsbspS1VrEYnNBAN0SGK3KB/xfmfP1WV0RgRvv0DPdL6/0WDxxvyV0oIWkxfkwU1dsOhHSGXFO5O6NU1nq6CkBNHeqE/cfrrzedHa0h+NbCPBcYuz284vV5dL1PpJMDHKoEK85Pm2Wns/85/E5aFlo6AVzkf5Npupxw8FGpMOGbifTZV1Jk2TtUSUpxBtBhWTxZ1+NvWF1oh/ObrNiU4bS7IYp+EMD03SEG1zh7I7uyxD4qdegVcn0V8f0GGCucVxwPnqOWe24EI0M4VNvXbsVOjvoWwMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JJJ7PJPnD0PnOchzemxfbqS8fcgECepFBdnsF+T5fVI=;
 b=CS75WoTQ5R5olzHgrEHTI2mrvOxAq93HdYqAXUnvYybwm8ufgLVevNFfNfWrfFSbvSmKStKSwGcm9ftyF7ro61h8WuvXQxW22NAdXiYcOAc6ZgGk0yd5Khvw3iic3gg22Ez/fwFQmBwj2M4A1WJiqvScVwSwBOWqzEYnawYkjkVV5aAigPHtSNri0Q40UhN47cSiN3yrUFzbXzoq/D9c7AGaCPZ0l/dt1+QY4AGVmRDawbKt9cHp/77kxU9mP8IwFuJ/QMUi+FnyT4zusq9BNcFTM4CHIO5l1ZAn4wl4FDbCwkavDk+2PHa5FGKJ7t6LjBlIWA0GPxh91Meol9orKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJJ7PJPnD0PnOchzemxfbqS8fcgECepFBdnsF+T5fVI=;
 b=CCpmleVjb+QZiWvclra8CpF0dgxkJatIakTTBScxxWPmQWFV0OEsQLF+nOsZXPQzKTceRh93NzyYDcgtS6ia/MJnNozc+0UcViv3ubopFBqNmzSLZPP/ATlm4sgPdyVlAjM0prEOzkOE2IQ2SD0/Hs4hs2mbxEd7pTN+fbHe0lhTSjRLFfY2MBN0UH540UyyfpFKh7wx6S00fqaTfPz1PLJf3fTre/rDaVTm/bd++Z8Z86P/9Kvaun0mN1qiOGlHJ/CDp+MvVGoKg00c7o5F3qAfpvm3Ys3lrtm7O5WIJAGLBwGyVqi771P1BBXwX+J5xW71B/LUWj91Pt9eGHwBqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by PA1PR04MB10818.eurprd04.prod.outlook.com (2603:10a6:102:48d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.12; Wed, 17 Sep
 2025 08:42:33 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::868b:3935:5e0f:6a33%4]) with mapi id 15.20.9137.010; Wed, 17 Sep 2025
 08:42:33 +0000
From: Haibo Chen <haibo.chen@nxp.com>
Date: Wed, 17 Sep 2025 16:42:27 +0800
Subject: [PATCH v2 1/4] arm64: dts: correct the flexspi compatible string
 to match with yaml
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-flexspi-dts-v2-1-7e2a95e3cf4d@nxp.com>
References: <20250917-flexspi-dts-v2-0-7e2a95e3cf4d@nxp.com>
In-Reply-To: <20250917-flexspi-dts-v2-0-7e2a95e3cf4d@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Michael Walle <michael@walle.cc>, 
 Peng Fan <peng.fan@nxp.com>, Frank Li <frank.li@nxp.com>, 
 Marco Felsch <m.felsch@pengutronix.de>, Han Xu <han.xu@nxp.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Haibo Chen <haibo.chen@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758098561; l=1648;
 i=haibo.chen@nxp.com; s=20250421; h=from:subject:message-id;
 bh=Qp+ybvx6rGo8AF8Qqgho9cmoEnaHO6FoU98rFa7dqd8=;
 b=PqZZVfc8AYaLq8Mu9WgFaSHgGhOWrTipbnM3NS1PPv6M77yvMTq0K8YAnY2Eb8Kfw04HqYv1/
 01cTU3GXcpMCX3RnWaDSw49zorJr/VpnxTK/d+PqOr+o+0wOgDybIrM
X-Developer-Key: i=haibo.chen@nxp.com; a=ed25519;
 pk=HR9LLTuVOg3BUNeAf4/FNOIkMaZvuwVJdNrGpvKDKaI=
X-ClientProxiedBy: SG2PR01CA0144.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::24) To DU0PR04MB9496.eurprd04.prod.outlook.com
 (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|PA1PR04MB10818:EE_
X-MS-Office365-Filtering-Correlation-Id: d4cb9ff0-7c48-440c-ddca-08ddf5c62513
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|52116014|376014|7416014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?REVIWktrQ3hmV3greFVHQmt0QjdRTDRBdklIT2Roa1U3MENIMjZiNnk5elhl?=
 =?utf-8?B?YVF2KzZ5S3N6N0dHSmtBMHBlcDFKOXJ1ZmxJU2ZBM3llZkRiemd6cUtTYm94?=
 =?utf-8?B?NkVGbUZvMTc1b0ZSTlJmNm5MYWhrcWgvWjJOTCt1TVA5MDEyNGdRQUZHdWFU?=
 =?utf-8?B?OStJSUFxNm1xRW9wZmEwS3dNTkR5OXdhanEyRDNJZGE0K0FUYW95VjBlVnF5?=
 =?utf-8?B?MlZMNk9CdGgyMmFvbTBOOGVZbWwxTFp4OFVPQ0V1bmxMZXBScUw4VzVyc0Na?=
 =?utf-8?B?bXlrR2FQc25kcUp5ckRleHF3cEVGVlZyRlp1TVVvTmkxT3NITmE0NmdPMkR6?=
 =?utf-8?B?cENLd3V5ZE9GUmNwaEhjS1E3VkQrcStrTThZVFVzOXZaRjRiN1RPQ21QTWlT?=
 =?utf-8?B?RkhJR0dNSzlVR3A1RWFrV0pheGRmVFYzS09CeEp6RkIyM2RkNE1xLzNod2s5?=
 =?utf-8?B?eXFqc2N4VXBCVHlPZHRhRzcrNFpWTkNGM2J2MkdXYzB5a1Riamxpdmh1Z1FU?=
 =?utf-8?B?WGRoOGRvclVsOUFQc3ZrLzluSlpWQlFLVFpmTm1UVzVkTzZabk50SnlYVXBY?=
 =?utf-8?B?QjVvNkVza0d2VUVjdjZUTktYZE13QVUraFlHWi9jM0ZsczBlSVlQOWpKaHls?=
 =?utf-8?B?dTZyaTB6cmVoSkpNcmlxbGJUZzc3WElpYVBkOGljellEcVVXWWVaSjV1bjN0?=
 =?utf-8?B?L2ZZc1ZFd3B5K0M5TzVwdkZxRDZZL1B1L0dRNHZMa2JLV1RSbmlwMGRpT3JT?=
 =?utf-8?B?NlZMOVhEb0hoU1dlWjYramlDZmhLb3VZZXdCMkJONm90THlYeGkvVjNmQ2d0?=
 =?utf-8?B?K0ZhL3NnS09hK2NKemxyMFFEWXF1SWRiOFBMRytQbVI2S1dZelI3WmVjd2pj?=
 =?utf-8?B?eWNNZENMTjg2b2tnMXpGcWZtRnY5QkZza0UzVDd4NkhEOTlNVGRVSHBkOXBj?=
 =?utf-8?B?OVlYcEFZeWFvTitYUGtlK3AyWXhzNUwvdjZCUWgveXYzRjczd1loTCtGNE9r?=
 =?utf-8?B?WHc0dnZFTVB3c2wyczZtTkFyY1hsUFdoMVgwNzN4ODFCNUdmWVdPcXg3cXNI?=
 =?utf-8?B?SkFLRW9KSmMzeE8vazFydkNXOXFkQ3d1ZlBvYkZubWVBR1M3YjhodU5BNmtz?=
 =?utf-8?B?SW5pUURTdlJEZG04OFdJSUREY3k2cE4vbVRGZFdUWlQ0ZVV2ZkZYei9DWDZo?=
 =?utf-8?B?ZGNia0txZlNWdDJFbkRaeXMrRitwSlcxeGdUQ1JMc1VYL2RSeUg2SHhudFhC?=
 =?utf-8?B?UHk2eEtpVjNxNEpKVGIyazZyU1JUcmxwMUpZRmtOMFN5MVVSdlR1R3Q3ZjNh?=
 =?utf-8?B?NTFYNGtBWFZ1NGNiaSsyQlN5WWpuTGk1Wkpkalc3bi9Gb2Z2a3VMM2I1QWYy?=
 =?utf-8?B?Wm1hNWJlYU5oY2JLRkZnbzNncGE3K1U0VEZoRkNOcTFPR1kxMEw4c3Z4b1B6?=
 =?utf-8?B?WmxNK2FTeXVYeERCbi83MEFpVldER1B0RjAwU09LRVJKTytqdFkxVHI1MnY0?=
 =?utf-8?B?M0lvQTRybzFmNjNvSnM1UEVlc1BLaE52TUhoVEJCc09YOWJGeU11NmdKR0tE?=
 =?utf-8?B?SVRXcmwwMlFnbCs0S09iOUxnMGI4QU4yUmhZOTJsbHlIeUNqbFNpZ0U1eGpB?=
 =?utf-8?B?SFk2SUNZTFFvbFVObFJlSU9Oazh3RTk3SGdMSmZSR0ZxV3o1UTBJKzQ3S2R0?=
 =?utf-8?B?Z1ViWE5CU0FJZWFCMUFmZlJNNkNEcVpsclBiU3BXdFkwbVlScHJrVjRSSWFi?=
 =?utf-8?B?cDlKeG5wejg1WHVUaHhiZnFKVGZrL2lLT0FROEY3UGlsZU1RayswM2hraE1L?=
 =?utf-8?B?eVAwN0ZOazR4UkxHZ3kvbkNIOXVCa3ZkdTFpWXBQYmZwVUxRRWs5NmdaZlRD?=
 =?utf-8?B?R21JMGZ0MGE3VWhDWjRYei9NWDRWUFk3dHRFUXZIQURhUHlSTm9RelBqNE4w?=
 =?utf-8?B?OFpqc3JBTFh6VVhIeC9JMkZVT2xSM1BUWDMwc2lXZFBXVHc3Tkc1MHJWOEJJ?=
 =?utf-8?Q?1uxPgkUqMbZHTdFv7m7/+vq3hdWT0g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(52116014)(376014)(7416014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TGxtOWw5TjF3bjZQRFNaUkE5bEtLV3VNSjV1NlRjRjdBS3k3V2JWQk96aHE0?=
 =?utf-8?B?VHVmdmkrQlFTMDUrOXFHZ2Z2RkFtcHRRYkhmUFZIVEpzUFJWTHVXSFhOV1pT?=
 =?utf-8?B?Z3pwNzRCR0tqSG5OM3pNdnJHOC9aY1doNnJpcG5HYkdLQTh2bStIMXJSeGY2?=
 =?utf-8?B?dmViY0lRYXNlZkpobWllUC9XRUFXSnBVV3h2dmM1eEUxUi9Kc2N1aGlrVFI4?=
 =?utf-8?B?MVltbG1NZ1BMTjhQOGhHT1hSdlQxbTlBOXFML2hBUHp6UWtqamp2L0wwcWd0?=
 =?utf-8?B?aHFnb0tXbDk2TjllR1RXNzFvT1V0M1lod3BKalZtOXNRZk9reExneDZ1bkJy?=
 =?utf-8?B?TGZwOW9TYTZXUHZ4MmJpOUFtUkpBdW1hSTBVNitPTWJ4b0o4eG1MUHM0Z0tH?=
 =?utf-8?B?WE5GbGhTUmlqZGxYb1Z2d2FpTEtIWVlLeVdCazlJS0pYbTlpY2RpcnBTNHo4?=
 =?utf-8?B?M1V6ZUcyYzkwMHlOVm1LdzJmQldUM3dJQWMxR04rOEQvSlorQ0xtU0RWRWZ1?=
 =?utf-8?B?b2laRkgzcjZxVXBrUEpFTTI0UTZvNHJjTXhNVEJLU0IySXdJWEE1ck5WSjBE?=
 =?utf-8?B?bnVHZnMxUXlYZHRkMmFaRSt4eFNSaWhXL3hXeVcweGlub1EyK2RUeGdETjJq?=
 =?utf-8?B?WkdFelBGc3ZFNGswSmpiVXVxUGJyaVlqMUg5VXNQTUJuS1dHeW9PMEdxRm54?=
 =?utf-8?B?blZucWJkME50bnViaTRlWE5RSkhwVEFVTnhOdVNCNkNqNmRYdEV1eXVkdmRZ?=
 =?utf-8?B?YkZPZEdjaVRSL0FPMkVqZnd6UUR5bXRQWTNNR1pWaTlsWCtvUVdYY0FyUXBK?=
 =?utf-8?B?RWF5RnAvUzlTWnpDQ0tKT3YxcnVvVTltUXh6WHNvelVNcWpEOURhYVQ1YmVL?=
 =?utf-8?B?Y1pYZ21BTk1DZG9HaktsT3J3NHlPcW9pZXpKSXhJc001bmpuaW9TNXRNUXhw?=
 =?utf-8?B?Rmk2d3QyeTNNZVJPRWRqRG1OaS9CalNJYnlsVTVROUNwTEU3WCs2cEU5S3BC?=
 =?utf-8?B?cnptMWh3OVM1ODJGbGhjS2FSalp5aldMZ2VrKytnd3d5ejQxN2I0MXhjWmZM?=
 =?utf-8?B?OFNqMWJEMzZPL0lYbWJHR2s2TWowRjEzUDVoMnZPbGtkTUxJQUxyZGI2dG1p?=
 =?utf-8?B?RDAxTHUrM1JpZ3R6bXYrOU9HK0dDS29SdjdaTDlBelBZR1FJQWZiT3lZbFVy?=
 =?utf-8?B?S2dIay9wYlJaWDUvVEFzeWFFL2grSmtzR0dwVnNtejh3QWdXOER0NjVDZzUv?=
 =?utf-8?B?VG8yNUlKT2F4c1F5UzYrVFl0cXdBYy9rSVkrK01sNkNJb09PeStUWkExNU96?=
 =?utf-8?B?UENVdkowOHFuZGp3NGI2SSsrSTFyNEpwQ2pVU1EySGM0end5Z0dTaUYyL3hp?=
 =?utf-8?B?OE9KVUowekNIQ0FmZWs2UDJRakwwcVB1MnlQa0R0ampxVGFnNW4vMzhaOUdy?=
 =?utf-8?B?RzYzWlBVNWltamIvVi9jSTl5U3dUUnpMYU5oU1BNWDEzbTVvWlY1U3VPQi83?=
 =?utf-8?B?NnRLN0RWMEIwVUVGQ3BIUlZ6VkJuWU9CRU9WTTZsZGxHM3YvTmhsYlhEeWpH?=
 =?utf-8?B?YWRnQjFZUEQ5VjRkdGI5TXZ2c2llc24veEhyVkJXaXdNYlJFQ2tmSSt1Q0pB?=
 =?utf-8?B?RjM4KzkrVUtvV2JXdGF2eWpFcXlIMWlucXcwMG5sU1NxTndQSFVxcXFyb1N3?=
 =?utf-8?B?MGNwMFVFeWdMREs1WVFlMmloS2Ruc2JSSEpxdS9DUDVqd1ZuSk5Pc0hNT0hs?=
 =?utf-8?B?SjRjbHQrVEVudlRPWUNhR0g5VWoxNHZNaDlZdlpHaVZldDhtOTdoZ3VKeTZT?=
 =?utf-8?B?UTV6b3lUeENUY056dHlxSFoyZ2ZOZ0RxSDl3ZlhBbU40V3ZsVldsalB4aVVj?=
 =?utf-8?B?dVZ0emx2ZkhLUTQrdEptQ2QvaUFic0xWSEhTZXI0OVBwckd0QXovYXhZUXcv?=
 =?utf-8?B?VVN0YXRVVFFFU29vaUhqaFhyU1doQUhVY2tjYkJCZWVaTk1TbHBmdWlvZ0RI?=
 =?utf-8?B?eEl3NC9GenpVRXVrRHE5aW12RzZkQlVsUmw0WDJUd0tmVSsxMi9GK3VFdnBs?=
 =?utf-8?B?QW1hYjRXYUNQYUdiMzdBbTN4TTdMUzZmNisyVmplUVVSRTNHa2IwczFoQlk2?=
 =?utf-8?Q?+nsAvReFwMZwgFxHPztAhe9FH?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4cb9ff0-7c48-440c-ddca-08ddf5c62513
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 08:42:33.3180
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 00b1HcZLG57XxuI/EFoBQdBBMeKOTbBTlvSX89HBfBZX16KIQORpYSlnyO8XGcIYuf1Wx0jkeXJZDlxDXIRWiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10818

According to Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml,
imx93/imx95 should use it's own compatible string and fallback
compatible with imx8mm.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx91_93_common.dtsi | 2 +-
 arch/arm64/boot/dts/freescale/imx95.dtsi           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx91_93_common.dtsi b/arch/arm64/boot/dts/freescale/imx91_93_common.dtsi
index 52da571f26c4e8a2703e4476b5541fa7aca52f10..7958cef353766a430df5e626ff2403dc05a974b1 100644
--- a/arch/arm64/boot/dts/freescale/imx91_93_common.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx91_93_common.dtsi
@@ -706,7 +706,7 @@ flexcan2: can@425b0000 {
 			};
 
 			flexspi1: spi@425e0000 {
-				compatible = "nxp,imx8mm-fspi";
+				compatible = "nxp,imx93-fspi", "nxp,imx8mm-fspi";
 				reg = <0x425e0000 0x10000>, <0x28000000 0x10000000>;
 				reg-names = "fspi_base", "fspi_mmap";
 				#address-cells = <1>;
diff --git a/arch/arm64/boot/dts/freescale/imx95.dtsi b/arch/arm64/boot/dts/freescale/imx95.dtsi
index 1292677cbe4eb8c5f3ec2874a17ad6efd0111192..a0ff7002be9fa0529ba5712df4c056c56f0e3242 100644
--- a/arch/arm64/boot/dts/freescale/imx95.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx95.dtsi
@@ -945,7 +945,7 @@ flexcan3: can@42600000 {
 			};
 
 			flexspi1: spi@425e0000 {
-				compatible = "nxp,imx8mm-fspi";
+				compatible = "nxp,imx95-fspi", "nxp,imx8mm-fspi";
 				reg = <0x425e0000 0x10000>, <0x28000000 0x8000000>;
 				reg-names = "fspi_base", "fspi_mmap";
 				#address-cells = <1>;

-- 
2.34.1


