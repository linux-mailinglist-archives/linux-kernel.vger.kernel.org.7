Return-Path: <linux-kernel+bounces-854915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C58BDFBCF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 18:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1092B506445
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 16:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FD7340DAE;
	Wed, 15 Oct 2025 16:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ERbUK55i"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013055.outbound.protection.outlook.com [40.107.162.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A870340D98;
	Wed, 15 Oct 2025 16:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760546728; cv=fail; b=p4/DSzeMIgvU7e7i0D+HI7Oiqz5W/kaMC2v87qVDWwja6kbft0ALXVSzjOvjh7R6kvHYbS4aOtSVjM6bjpQsIV7UkEtQ4j8UzvendEvBzE98OUhGTSGs/iYMBYv2xR2THvyeyh6yingUqGU8ul/LMgrxlM3xgl4VVMBAA8FJfew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760546728; c=relaxed/simple;
	bh=8iUChnDAGpyRnCKC3p1a/l2BH4aQI/W8Jnom8LWPUxs=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=VzeUWsldNpyDZhr8IO9nzMgC36q3SmconM5geA/PPPTJtORQWd5eXIdcPAmxTKRXvbtYDjU1Xfn+rw8fAuByKbmRBCiWrPhxH7/sGDXoh5mRSxzPwkpNFNuxv2LoXmWX9RKBH1EYPZ3LdI/xZE8SJm7G3knbxi69a6MeM7YwiYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ERbUK55i; arc=fail smtp.client-ip=40.107.162.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HYU+Bb+/vJ9uo13uixhJGO/xsv1aw/BZ6i+xA778jwBOSYoNDekiQHFpRbQxrX7gGOa/Mfv8Up24vEF2rPeCXPGehKbsSICXOVQbfh5OT+MLbt1iHFbD9w1ixWOAJoihDKllaVh1Ok2kKFqzOuOCA3dEr6PE5XbYkImLG0rZ+XQYLB4EVQSbt+vVa8QvQRmgKsGfTi960LA76mz/muuyJcgvMKgp/+Ot6vSP1KbQ3bdURw8iRwGlpV4bl+ggXspfU1TMj+fz5I7igPyUVRJ0M20nyjHAOJgDINhwUyK7G/ZtsyukQzMCKbpdAUmXLjCl23UgX3G91scrw6yZ7lcdTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=10eIN9B5ATbGfjwqCdpK0oVg9mZ+w9ks5BHSBlyTF9s=;
 b=anLw3CvhkiVBfpRgyiX2kaHTbYQIWXuJpxy7AnUVCc9wGTqoZ8kMpHb+jAvuusOjja6vIj36f2jb8L4MjilhIm4Fu/67PLZt+ajFqz4/bJoTxAeqJtFqvq7e4rlBmXr46wCNt4WRvBsC01o+RMRMG33cY8/bxlVkcUmsLWcMxl3lW9Udqg05QpmvRxjQbfERO1FfhEsPYnmLRqIqgtCqZrfDPvLk+clchMqbe77vbRf0o6wT+rFs/juFHL4KykLrzqUADSaU6PdVDEDEduPn7YCpUicHsoP5B/AeHCUcXDShd7huDX49bKmxCPCngHMG8vEjs4371X2RjzypZsoLLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=10eIN9B5ATbGfjwqCdpK0oVg9mZ+w9ks5BHSBlyTF9s=;
 b=ERbUK55iQbwsLULWVUURPaF6qLM54UqUAVWbXjwlKpot1zdZ1MvNrtYQr50OZzYGfJ/2ThgTLdsYsuqWsHtxFZxWmMYFhts/JLmEejzmnAjJDCclYeCZAfdx00jX6T66jzN+wRm4UotVQjUbgn22I+WFyBoWF7xuT85IZLPz/+3Gvm3GpK/uNnZm9xsHUb5mmOZf5BvYJTsreI4q2mZVTnpScx8gK+TvKn5hMag41F+Tk0Z5z+/QFC74rto7WbABk9N6+H6flN1DU/WBT3R9lLOV9kRtT4A9/5S+MWqXQgjGz2R5PeYutj/CC0bMMVXXuZlLnCnF1HrZ5AYitGKrMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by PA4PR04MB9248.eurprd04.prod.outlook.com (2603:10a6:102:2a3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Wed, 15 Oct
 2025 16:45:23 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9228.010; Wed, 15 Oct 2025
 16:45:23 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 15 Oct 2025 12:44:36 -0400
Subject: [PATCH v2 11/11] ARM: dts: imx6qdl-nitrogen6_max: rename i2c<n>mux
 to i2c
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-imx6_dts_cleanup-v2-11-41a7281b98c6@nxp.com>
References: <20251015-imx6_dts_cleanup-v2-0-41a7281b98c6@nxp.com>
In-Reply-To: <20251015-imx6_dts_cleanup-v2-0-41a7281b98c6@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760546680; l=1176;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=8iUChnDAGpyRnCKC3p1a/l2BH4aQI/W8Jnom8LWPUxs=;
 b=KhqjGxto2gn5587XZqlhCqtEwAVPbquTasy9bSQ+pP7tjphDR0fjOnj4GpQkO9GuR53DI4q4j
 de8coc1kVVZBTb/ArEkdyL5Hbxbuk69UpCZO4z5dIUZv7uVW3EOvJfJ
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0113.namprd05.prod.outlook.com
 (2603:10b6:a03:334::28) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|PA4PR04MB9248:EE_
X-MS-Office365-Filtering-Correlation-Id: e49371b3-7a3b-446a-29fc-08de0c0a3bfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|7416014|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MWc2WTU4YUFGMTlISHJueVphWTByeVlOWHhXOTUwSTFyODBVMXAwdW1VWFdr?=
 =?utf-8?B?cTJOb3NMYUExQWNua3VFS0d1elcrcm1IZW5Sc2dReUczazA5d1hFOVdQVWFa?=
 =?utf-8?B?Uks5VzFRK0NLQ2lZUFZSV3I4dUFRczhRN3RRMmFHdlpCSjJJa0RaajdveDdF?=
 =?utf-8?B?blVCODFjOWJFaWNFQXREWjJBS3ZDZWZ4MDVVTjhhbE4yR2hDcEhNVUlXUG9M?=
 =?utf-8?B?TzVRd0JzRlVXd3dpZ2NHRWRtRXFLR2FTdVY2dUozNU1nRDNQcC9ZNzdpZVRX?=
 =?utf-8?B?bnRyVXN2MGNPY3RwTis5OFc3STdJZXdCMmlqNzRCU0UzQ3cyajg0R1ZZSWEr?=
 =?utf-8?B?NzJsWGFCYllnT29oN1NDdmZJSjQrRDFsMUF3T3cyMnB4OFg4eTcwbGZmNWhI?=
 =?utf-8?B?NE81UW9IbHY5M0l6UGpjRFVRUmhNOXFWd1JySDFuQ20wbDc5WEF2YzdGK1Qy?=
 =?utf-8?B?NDV3YnJ5YU92NzdjeXB6dFp3Q3JWa2Y1a0pkd01kZVYxam5hMjhYYWJhKy9z?=
 =?utf-8?B?VFZteXJuY0MvMEVja3ZrQ3hMbWdvNVZtYUl4M0tHM1RMeXFqdFlTc3JtUTN0?=
 =?utf-8?B?MzQrSDluR2RQVmE2RDNmaDBUU0tLUlBSZTI0dUdieGZiY3RKMDZKRXFPYjVo?=
 =?utf-8?B?NkFXT29QTFAzenp1MkJrQ29QbU42c1hsczNNOXJNaEZYQWVnYml5NGVXZWVT?=
 =?utf-8?B?NFBhSXA4eDZXNUhCUVhBOHpLN3RhQ3Z6TDlKdVg1SEgvYmlQTlEvZ1JHY2h6?=
 =?utf-8?B?ZDlHbVh2ZmNNM1VlbDR6aDFFZTcxSkgxTElHaGhZMXBDWFdyNlo0SXczUDlD?=
 =?utf-8?B?U3ZGUzY0SE9Yc1dsWkc0VTJTa1lnZHBremVRVU5iMEhMclZoWmoxNlZ5Mk9V?=
 =?utf-8?B?dStlWlUzc0xGc2dua0RaTlA0czBEa3Jjblh4QWw4dzVsY3krRDA5SjJvMFFh?=
 =?utf-8?B?QzVBM2tJZG1QV0x1UmdzTm9ienpUOTFsTnhsd3lHZXRLTmRpN0h1SXRZbDI4?=
 =?utf-8?B?ZG1ieC9WalZqaDQzNjQ2Q2tscEJRWXg0NDJWU0JiYlhGV3kvRmZwVVlrV2cy?=
 =?utf-8?B?aTNKZU9rZEdFak94ZWFDdEN5dStiQjg2Qy9lWFRMZ3BMTTBkdVNRalB2N3Fu?=
 =?utf-8?B?aUF1NkZaUytVVS9hWUFDcDY5dkJQK0o3ZmN0KzZteEpiUTNMQjBTczg2blZ3?=
 =?utf-8?B?YkpGMGRLdm5oNkpvRWhCZVo5QzM1L25naVJJczE4Tit3Q2tVamVUSGErbkJJ?=
 =?utf-8?B?d1o5MU9EelZQUVBRMXhObmMvVXFZbDg1RzdtRkZtR2NJQjZNa0hkR3BtSU90?=
 =?utf-8?B?b1ZvQ2tWUk96U05GKzFlSlg3Q0l0cjZMd1h1R0h0RHBNdTZnb0s4Z1lvZlZI?=
 =?utf-8?B?SFBTUm5yWnZSNVlkVU8wRnIxU3FwVnp5dkRnSHY2Q2NjSnFPSFR5OXZMT3RJ?=
 =?utf-8?B?YW1NVDRTUUFDbGhNc1doc3NyYWc5Umt0ZHVJa2liSXNHcXdEdHJucEFya0ND?=
 =?utf-8?B?OUd0OFZvS2YzdlhVZVRZNDRrL0FNMFlZbDA1Q0ZsZGdzSThsOEZ1ZkNxS1p1?=
 =?utf-8?B?YmVKcTViUHRzMzhLSjBZbG1LTS9BZTE2MG0vOUt6YmJPbWpGTFVFM1hFOEF3?=
 =?utf-8?B?QXQrRnBoaFRVam9NSWRXaWgrWVIycnZsS2x4Q1VPRFduMjVCWndqNkRhRzQz?=
 =?utf-8?B?Vk9yN0RKdy85V0lVWEhvc2FIU2Q1a1FhcFpRVHM2d1hnNkhnT3ZRcnJ3WHpO?=
 =?utf-8?B?cVlyejdaaDg1dTcyTy9PSXF2WVJkc1M5cC9DWThSc2wydjh2M3oxZ0NkLzVW?=
 =?utf-8?B?eWdaK3hXNkY0a2ZsRUhKRVZjK1RjZTZOY2VnT3BhcWdEVllQbXhSTEk2LzQr?=
 =?utf-8?B?YmdrbGcxSWpXWTJVNkw2UWhhdCtaeWFkWCtQQVNoUm9XQ3ZvcjlSUzVnVWsx?=
 =?utf-8?B?NG1aU2VBc1YrM2lhWDZIcTloK1pvZ3Q1WjlTdVJ0QjdrOGRreXM0WXp3bUlp?=
 =?utf-8?B?NTdGYXdiMGZXbFdpYmpYaklKd2lEc2NRM0ZUWW03TzJvRG4zOStwaUZsYkdM?=
 =?utf-8?Q?xy27OB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QzBuLzVsVVRKVmNmL09DYlMxRnpoeHg0RUZFSjdWc3RjOXRNckdORzNBeXlU?=
 =?utf-8?B?Q09YbG12MVRiMkMvYzZBUjdUenN3RUFwWnkwUkRLU0s2c0ZKcTVjY2l5Qmln?=
 =?utf-8?B?QmVLeldaUWZPSS91WEtPamtWNTFDUDlxYVFRcSsxYS9vS3lCRVpmaXpiQ0Zv?=
 =?utf-8?B?MERCWG5MbUJraExyT1hvTUs1K0JROW1pVDE2d0hucndneHZMSHc1dDlLZ2ow?=
 =?utf-8?B?S3dUY3V1aVVrdDVGSWFtSVYwNWpUcEwwemk2RlVuZjZZR0ROUi9WWExySmMz?=
 =?utf-8?B?cXJ4TnRrMndhK2tiTFZBUHFjMnY1NFZ5aVkvYTJGRDZTTG5HNkczbmVUdXYx?=
 =?utf-8?B?MmFNbEkzN0ZTbG1lQUV0aVB2d0hHZmVNQjhkRHR6NkJmSnRtRHYvaExkOTFz?=
 =?utf-8?B?ME1rclpwN2RhOTU3S1VmNWJjODVGbmVkTFhWaWZFaWJYdTNDRU0zUUt0R2Vi?=
 =?utf-8?B?Q0ptUjhmQ25NelpzK2NNbUFkWGFiVXVuMHlhZVhpUEFjNXc4cGwwOEtIV3Ew?=
 =?utf-8?B?c1ZKbXZvV0pOSExGWmwyeWNwcnorRUFDL0M0cHpSUGVwU08rMDZSY21nc0VK?=
 =?utf-8?B?UnVteExhWnczK2x4eFlnMVlOeC83cFJtcktycm5uR3RtYmhBMHpScW5wdjFu?=
 =?utf-8?B?eUgvazV0Rk9WbC91QjNGQktYcStrWmRXbVJ6NEFFYnVqdFk0N0F2NkRVOUJC?=
 =?utf-8?B?SGRPVEYrbUJCVDhLT1hXUjI2Rmg5MjhOenh2MFVIWURZOWNNTTFUSWlZSmtm?=
 =?utf-8?B?Y0ZDYXBoL0xlZy9PazVMcTJaUzFNOVFmaDhlNVVyL2lMQnZwYTJmYmJuNGZN?=
 =?utf-8?B?WmdIUzZCTEpabkV0VGF6a1dyQ0xCNmV4OENyTisvREs1UytNN2kzc0luQnNG?=
 =?utf-8?B?bS9TeExrVk42MXc0aEJpZ2o5UE9zdDF5b2dJNDdrbHBXTHNPQ3R6em5adHJ0?=
 =?utf-8?B?UHhGWDVMb0ZLczNNd2dOcHRsQUsyODBSS1BNSWlMa0RQYWgrY1RZelVEdDZi?=
 =?utf-8?B?TUFnR1FpdmZnNy81RmE0RzE3QWwySkRlTmFhN2dUaFltbnEzdWppeHFOWGRi?=
 =?utf-8?B?NWk2c3BSdDYzT0ozRG0xdHFxL2ZCMnZJYVB2amVTQXc2eEpIL0dBSVJqeFB5?=
 =?utf-8?B?NlluaDFFWnBRUWxlemdGbFlzcHFOamVtbnF6eHF4Zy8xSmVzeFFXSmNCeDFm?=
 =?utf-8?B?eDFMUXNqM2p0NHFKZFRRVmhYejltMUF5RnpiY0xMRTFpYVhneDNINnhBMDR0?=
 =?utf-8?B?UnZmbURtQzRNb1JLY3dkV3MvUFRQWXdDaSs4MElTMVA4aVNCQVlIT2NabXA1?=
 =?utf-8?B?ay9wc05lS2RuT3ZGQUFxcGovTFdhNVlqT3BQUGVobXBWZlZzZTFsRUpQdHFG?=
 =?utf-8?B?STlVWWVrclNVY2g5Q3NiZE1ITHhHeGYrYTNCZCtLR3orMWp4Y1ZBVU1WUEx6?=
 =?utf-8?B?SktUWWtMRVhwNHhOTUEyNHZlKy9tMTZHeDc0SGpkTUt4YTVkQVZBR3dHQm5R?=
 =?utf-8?B?QXUxZ2dXaWlsQ282WjhwZUhFSWRPeElXK3oxc2E0OWZHbHZHV093dElXc014?=
 =?utf-8?B?RUI3RGtvL3k2c3pGTmJkVjM2YnpMV1RIWUJyaFJSY2pKSmQycHJFQklFdWxl?=
 =?utf-8?B?ZC9OVHRzZ3NYQVpuSWt2bjlUQ3lrSnR3ZE5ZeEdybUY0RVhybEFta3dlRkNZ?=
 =?utf-8?B?WWhveUlSMm1Vam5WbFpZYTBDOVE3Y1JBYVZlVDRTVDQrRE5lRHhEdW9Iaklz?=
 =?utf-8?B?S2xLblpEbExkYmF5K3hIdVBZYWJ6M09xUFJkaHM0dFhZcGVYak95cTlxbyth?=
 =?utf-8?B?U2dhQ2VHRitOUkduNnhVR2g3TDJaa2FmSHdhR1JwNXh0eGdOZm56ck52UW9X?=
 =?utf-8?B?U1p1NjJHVjM5b2VYQ3VaemMxN1FaZ3BkTnNMRWxJYkxaWTNVVEtwanYrd3pj?=
 =?utf-8?B?dFIrR3dHdmdSV2ZBZVhPNFdxUFRSVStMUzFoZXpGQ3huWjAxWTZlL3lDMDE3?=
 =?utf-8?B?djhUNzdWU0ZaeER6ekZiV0ZzSmxHMitxN0hEWHBWK2JQd2tvZ2h4NWRuNENJ?=
 =?utf-8?B?TWE3bW0zdWVjV2R0YWhnYzJ5aFFWRDgzNllKZCsvcG4vdHZxc0dacFZDV21K?=
 =?utf-8?Q?/5hl63JdLuBkrxunnGTAkhnh7?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e49371b3-7a3b-446a-29fc-08de0c0a3bfc
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 16:45:23.5138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mMsO+ZwYqDk6tojDO0rCfVCl06zPSGNWv8nho6azzwl6XhECX4Ow1OJMS2yJlAUb1FAK28BhQZPdqv/LL7RSZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9248

Rename i2c<n>mux to i2c to fix below CHECK_DTBS warnings:
arch/arm/boot/dts/nxp/imx/imx6q-nitrogen6_max.dtb: i2c2mux (i2c-mux-gpio): $nodename:0: 'i2c2mux' does not match '^(i2c-?)?mux'

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx6qdl-nitrogen6_max.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-nitrogen6_max.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-nitrogen6_max.dtsi
index c727aac257f9c3a1f16dc357fce355ad46a3f699..531110d405d0de9bc2dc926d550c00030d3aaa30 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-nitrogen6_max.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-nitrogen6_max.dtsi
@@ -135,13 +135,13 @@ i2c-mux-2 {
 		i2c-parent = <&i2c2>;
 		idle-state = <0>;
 
-		i2c2mux@1 {
+		i2c@1 {
 			reg = <1>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
 
-		i2c2mux@2 {
+		i2c@2 {
 			reg = <2>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -158,7 +158,7 @@ i2c-mux-3 {
 		i2c-parent = <&i2c3>;
 		idle-state = <0>;
 
-		i2c3mux@1 {
+		i2c@1 {
 			reg = <1>;
 			#address-cells = <1>;
 			#size-cells = <0>;

-- 
2.34.1


