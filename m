Return-Path: <linux-kernel+bounces-886984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B13DC371D2
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 18:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F102683637
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 17:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F6431A80D;
	Wed,  5 Nov 2025 16:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="oE/whaAM"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011021.outbound.protection.outlook.com [52.101.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C36F34F270;
	Wed,  5 Nov 2025 16:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762361763; cv=fail; b=Nw2/EQjabrz+ARw6zOLGeau9JdESZkcS+lYT36z+YSN+sJPi75afo1Mo/48nbNM3jV8VayJ3TDDmlHTFNYxNyuAcsHwQ5YK8SVbO+qtaSE0ZjhG2bILNQrc+h5KzRxbPsN6p+q/63AbCAbee63fa17armhaLczPKHbNfQ+RyyD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762361763; c=relaxed/simple;
	bh=rAtyZBzhFZbF3QVYBdwCrbzXgP0KJGgnqL4rRVycGKM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=SVJqiORL+iB21Ql4xdO2q01awKKg4pklWUz5IHlgF/59ILWKcKIs4RvPdlmaZU9q65JydljrXi8b7RLEuOvw8DA77kpM9P73lBVx8YvkdjWIDN/fjEBu4dWlf1tq1f3AI3xAIUljssPeLK5IDsfIhx9jLq4oFyc5/Y8Vk5E2kSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=oE/whaAM; arc=fail smtp.client-ip=52.101.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HY0q/VtZVYS6xXEWYBk1bdwGXtykR8E19S6ToHacACA1lxaPSYwaIR9BF9DPaGNbEgNFJOBXAwvKsGP48282fpgnYA2IDwxowpEZUsBlasKoIqqiqnKUA1NZOoSGyq9WAtdHe43s5gJnvRWqR93v5IyznaLZqdhzJP8fO7HpboKMy75kekB7221qsBIo2xGgtmPtYFLCG42STdQM6PNSQDNnJhKuqpxT6JoRWfLESd42lMQZ9c+HLZqESDYrvsT3ucbOmXRSZvwVuSdKWCTiM2Bnks+ptaDAUXpIGUf+DyrDcPvybrCbnJBJGuNwOaYt98LIwT79AUbIaudyH49thg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pf2uRhz7Q5dJCigBYXvCdtgaw5KCrTd7jxaOVIDgo/8=;
 b=tjcuGG4zvCHSfisxd8b5BaKFqzu46VcKRCfPzGu0EFbo/LdGY9SHXlO4c6j7H22z1/ZMwNyHwSsyMgM/lHyqchcxl50zzkHbGOasQBjw54LTfpdhiRkcvjBjFhUtDD0zw9vUPxU36ErX/UH+vagiHD10pD/sfW07ad+UdOk9uaJbp2EgmnJmTl2GRLpPe2LmkdT7syoYo0Z5vCyHOLnDmNcYPYBqEPg5kB35LNcx1leU86QlfLO7A1BRmRhCNacrNwQwGUybMhZDK3wMRRj5wqqadlfwFo0jAIKeSI21kvS6QjZb864L0F3ajbKs49TNLB7AVgbNQ9+lV9Nr3y5Eqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pf2uRhz7Q5dJCigBYXvCdtgaw5KCrTd7jxaOVIDgo/8=;
 b=oE/whaAMX8M4K3iIo0ze8/dZY7iNdgfSe62pMeTMI0lbot9uftcEkWYnIFVgufBIWVnCjw2GLO+ylCRM3pE/AtA4V/3kuaWxQFleADh5YcpQUu7//ftzzXiVJmVyYPv6KmUanRoIxxaufIShe8d6MMp0MLttCibQQBXOFcQtEwfltyiHIM+KNEsxI2cQT4UMi3jsrM25wfB2UN3myGiKuooDxlpOJyGJK3SqJj3LeoG2UBd63M31S6rS0jv1baBGsWasOl5zZSe+R210ufhmSQNmFuD7IAgKpLH9vtGTLImnOvSJiA1ooCxFNhWmQ3rFlYh1GUSlv840mONZRrDWig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by PAXPR04MB8877.eurprd04.prod.outlook.com (2603:10a6:102:20c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Wed, 5 Nov
 2025 16:55:57 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9298.006; Wed, 5 Nov 2025
 16:55:56 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 05 Nov 2025 11:55:29 -0500
Subject: [PATCH 2/3] ARM: dts: imx6qdl: add label for system clocks
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-ccm_dts-v1-2-6aadcdf97cb8@nxp.com>
References: <20251105-ccm_dts-v1-0-6aadcdf97cb8@nxp.com>
In-Reply-To: <20251105-ccm_dts-v1-0-6aadcdf97cb8@nxp.com>
To: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-clk@vger.kernel.org, imx@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762361743; l=1281;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=rAtyZBzhFZbF3QVYBdwCrbzXgP0KJGgnqL4rRVycGKM=;
 b=AIzn+KA+nwT2hIoaToZ/MhhmbUqlTn3MLW7VwYMNdMnnFlo2BBlT1MZUDBsR3oM6d9XGIzSA0
 rB23d9k+huIAcl4Wwhq6IOqjYEmVdcLnbuYdwHqHNdMayUEajJF9Ikd
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY5PR13CA0007.namprd13.prod.outlook.com
 (2603:10b6:a03:180::20) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|PAXPR04MB8877:EE_
X-MS-Office365-Filtering-Correlation-Id: a0d3d71a-9281-41b6-c79e-08de1c8c2fff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|52116014|7416014|376014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SXhUZlNzYnNISDRUaDFzVk5rSnlKNkNhTkVpb3pJTkhnSHRhc3p0TVJvZ01v?=
 =?utf-8?B?aTJkem5EcE03VUJkenp3bzJ1SnZ3Um9yWlFZdWF5S3MzeUYyL2tUc3dSZzVT?=
 =?utf-8?B?ZXVQRHlLdEwvS3pqVVBzYk0wMGlQcnZ2UktBOEZsK0ZwaXhlUVo5VGZKN05z?=
 =?utf-8?B?UGR2LzRzYkxnSWo4VXNYTlZKWTdCVEdNb2JONFNnQ3J5dDN2WjE0MEFhaGpH?=
 =?utf-8?B?Wjh4MUxVZnM5dkFCTFJuWXp1VkVhbEtQeVJkdzI5L1ZCeHJWakdKRmtrUmZs?=
 =?utf-8?B?R1ZyYkhJUDZXMldESm9IZDlqWk9iUlUyNyt1ZkFydXhMRUVOd3BwbFYvS1ly?=
 =?utf-8?B?dzl4NzcvL0ZMN0tHWEZOQVJJcXc2WmljZ054TXVDdHg5amh1YzZoc0NZNFVC?=
 =?utf-8?B?QU1wMEpFazAveDk4cndNaUlSZnBwanZDLzNvRkgrUXY3WTQ4OXlkamhSbmc0?=
 =?utf-8?B?VjZtcEVzbTMyRFN4ejY2Q0NhcS9oS1hyU0RtTWxEaUFWR3dFN0NWWVByQ01M?=
 =?utf-8?B?b2RYTGsxNGxlU3ArZmRnRVEzWWlPYmNQNm5lTjZYT3YwVlA4K1pscWVhNXZ5?=
 =?utf-8?B?ZVVmZGlkVHVvK2xaL3R1MkRTRDF4VzJUUVNWUWRxTmdrRFBuMFJTRDVSdnUz?=
 =?utf-8?B?YUhQdEhMSEFBYU1zbENwMzJyVVJFWWpqZmRtZXRqbmVtSFRZeGVxZ2xzcXlj?=
 =?utf-8?B?NHVJMmp3Y0VYc3VZMHVpOFpNUWcyUGZ3VVlzK2pONUVRYysxUWlrc2ZkbWRo?=
 =?utf-8?B?enUrT2xwWTVTRFNRTmJQdkZqd3FZVUNvTjJXdUJtaWRBU1NXS1JvTVlkRkM5?=
 =?utf-8?B?S2pnOXBENFRtV3BXVHNhM2pBY3RhUzJsN0MzQTJ6c2pLWGx3a1FXeHNMNHNo?=
 =?utf-8?B?UFZWay92YjR4VElmeVN1Uk0wVlJZaSs1U1piZ1R0aVZpSGQyeXhVdnFyM2hD?=
 =?utf-8?B?czJUOEVYMkt6TnEra1dibUhCdE42TWpkbisxSEFEVHg2ZURzWjNXYkw2SFYr?=
 =?utf-8?B?ZTFLUU55aWRsNXpoNUtNcGRQWDIzVmpPeExBUjI3ekpsQWRBS1dFNGc3b1FP?=
 =?utf-8?B?azVQeDBxalpQSlJGKzRsMzNrN1h2cCthNTZvUnNCNkNnYkhvYzBxT2xIWEF3?=
 =?utf-8?B?MGhEd3ZISGF4WHF3amdRcSttREppWUFSelNJSHAxK2ZLVGFpQ2tXakRzZmRm?=
 =?utf-8?B?dW5qNVp0cm5iQnNqNWlFaFdrcjRYTmhkaTJpcUhrWXhHSDhTdmZlN0ZMbmpn?=
 =?utf-8?B?eVgyY3B3STErT0cyUWlaNnJsV1Vrb3lsRTJqTGhIOEoxSjF4aVBpT0Zkakc4?=
 =?utf-8?B?cjdKRmZCdmNPd0ZjdVlxQlFjNXZQQ1V3SmpvVlZPY1ZTOS9ZYmdJVXU4bTVv?=
 =?utf-8?B?dkhzbklBQ01ybWxaTXJnQmpiNXdZUEVFdm5EOVhtQkwvK2FOajhRNm9WWGdZ?=
 =?utf-8?B?akwreGtxOTd3SHhKaklpQ2J5dDVYcXpidml5Q0JWRG9NRTdrdzdYSnhRbzV0?=
 =?utf-8?B?VTBIZDg4SkRIZjdLNEN4UXJ0SGwyZU5oNTEycVNndExEVk40d0k3SlVUVnNL?=
 =?utf-8?B?cS95R0l5SUY2SW5ZNjE1dVh5RlUxNnVDTVFZYnhZVitRdDlrampSNmtvbkVk?=
 =?utf-8?B?dGFsSHBuNWl5OFB0c0xTWnIxRVA1NmlkamVNbEd3Y2pDZVd2RGhlNXdZbHdu?=
 =?utf-8?B?VThEd3lmTExrL1FkTFF3YUg3YVRmM2FxTUsvL1M5Q0hmdy9QYUhXdEcwN2dU?=
 =?utf-8?B?NFRISE1NeGFEbGFtaVVjQU03MVFpc1lsMTlJUnBTNGliVUNoUE1LdEVsclJZ?=
 =?utf-8?B?V1d5SWs5SUhnQUdNclMzL09NdWk1ZWhINE5PdEdzbis0NnlTL01XTGhSUlFz?=
 =?utf-8?B?dU1RYTFjL1dqMmh4S2oyM0FDYVhXSDNFL1FIeUF5MFFqc0lMMGFKM1AvUStx?=
 =?utf-8?B?OVZvY2l2TWpaZlFmS1Bqdzhac3MxaGFaS3RISEJiY3FrRFBjU2ZQeWZlQnJ0?=
 =?utf-8?B?L1JFc1QzMjNtOHBrY2sxYzdUZkJ2eGkrKytPeTcrVmxSMUozV054N2FrYmV3?=
 =?utf-8?B?L1FHbjJ2eU50WFR3bGZvU0Q4YmY0WkN1bS9Xdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(52116014)(7416014)(376014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RkFqYmV2em52UjQxbVR5K054b0VFZW5BZlhoOUt4c3FWZVNTM0duTmxkOGtx?=
 =?utf-8?B?RzRuWHlrTW1KY2hKcXFOa016clB0WDJ4QWNmbFBsbDlINWFkdE5OTlRDSXor?=
 =?utf-8?B?aTdPUnFrdVR0cVJHWUxLRWdUNkM4V3FkbUpPSFZxUytJb3BURzRoUVl3RDFk?=
 =?utf-8?B?Z2RwNUVDWmUvRm1VS1VEUGdCeFY0WGE0bUl5U252bEJkeEgwcFFqNnl5alZM?=
 =?utf-8?B?NVd3Wm5FZGgzVVNVbTB0UnhOM3k1SmZiZEo2ZXJBUEJaNi9qSHFveVo2WHBQ?=
 =?utf-8?B?dXU1NG9rQ2xRL25WNkx3V2o1S0ttcU5VTXAxMkJ0OXFYcjM3d1ZqL1BMdlVR?=
 =?utf-8?B?NFZuTW9EbG05ZC91RWZ6QUM1SU5zUFRlZ01CV2ppeXZzLzFzbDd5blpGS0hE?=
 =?utf-8?B?RnZLS3dDL2tGWTg5TDNlbmVFZXFQL3VJQkZZdFpNZjhuNW80K3hMZ0l6UXR3?=
 =?utf-8?B?Rm03OEgvTVlSakU3WlFHbGVtZjRiVDEvN3dIMFRYTEh0QzdQL3d0dEpBWXFK?=
 =?utf-8?B?QkMzbEx3OHdDL0Q0MHZFelNXczBkamdnQVNIcEIyWnZjMFVJbHNvSlM3N3A4?=
 =?utf-8?B?Ty8reHdLQnQ5MGlpMVFCbjlkZXJIMHNjNmNjd0k4WDR1cDlnTStPYVdLZS8z?=
 =?utf-8?B?Y1g1K1B0NnVSLzRmNjRXRXJ2bGZNbElVTU5jdDdLMmZhWUp0VlgyNG9IWHRr?=
 =?utf-8?B?aXRNOGZXbUtVN3NDQUlWWW5rcmQ4OHlpTVExS0dtSHpDa2lvL2xoRzFvVnJ0?=
 =?utf-8?B?SUErelJKemEraVMwYlpmQWF3eGZmZXphS21UdVdabUxDQkkvVDA2WW5jUDJP?=
 =?utf-8?B?c1NBdGExMFRLQXdNTlNMbzhlTEtNOFpYV1FHdGFrTGs2SVM3Ymd4SU9wbXp1?=
 =?utf-8?B?bWd1OE0zSkhNck1jWWN5ZXl4QmxSMDNtLzhuYXQzVm5najIzTG1vVHJHQmFn?=
 =?utf-8?B?U01vTDRLN3FjZUwwY3ZmK0paNkJzMkhrQjZJaHo5dXRmc3hIZWZUeDd3K0tx?=
 =?utf-8?B?WWFQcDQ0ZW1LYno4Ui92ZFhoOHk1c295VEJVZFdvWk8rc2RGVUVISHM3TGtR?=
 =?utf-8?B?WTBQTFpINEFiYytCRC9kZXZiYU11dGNOenJIMDF4NW9GaGJlSkVQcTJab00x?=
 =?utf-8?B?ZnE1WTBWdkFHdXNUWGQwYmVXNnpHdlRvZEx1NWk3MWdST1V3Yy92ai9lUncx?=
 =?utf-8?B?aWNVMi9nK2Z2WjF4aXp5c1BIMjhHMUdDS3pETkprSDFDUVBFb3N2U2d3Rkwz?=
 =?utf-8?B?dlJZTmVNVWJuQ3BwYmg2MTlXbzNnbzU1TXg1U3l4QXR5KzhLT25wbkd4NUl0?=
 =?utf-8?B?S0lKQTV6cWdSSHUrMkJDR0N3dER3MGR2Tk9NallWMFc3bVkxbURVSm5hUlhm?=
 =?utf-8?B?OElsNUtLZTVZZm1oK0JMYXkwZXJPeXo3cnN5TmtyYzJCYVg0NGhyOXppa3c2?=
 =?utf-8?B?YUI2bW0zS2lsOVQwUFdLR0xQNmQ0REhMVjcwUUJpZ2t3Vk9TZDh1VS9KSUtr?=
 =?utf-8?B?YnVZRXcza1hmblJRRW4wSXNVbXFKZUxmMkVvc0RSTi9CalJYY09uVlhSREFU?=
 =?utf-8?B?OHNNWWFGNUFlYWk2TDhsVGdNWTBlb09wSU02dzNaNkIwb3RHVEZXd2ZFOGZn?=
 =?utf-8?B?Sy94T2tpUEFnSnMrMFNic2ZqYXQxMmZ4M2dRVloyZVpZaUwyR01CYTRubElC?=
 =?utf-8?B?MlUxYVVXNGNjRXZaUEJXSlRETmxaWlJ3bXUwUzBSdWlUSlFxR1JMSWx1U1BC?=
 =?utf-8?B?RlMvVW9vVDlsSXhaRmR6c1U5Y3didHJNaE41ZzBsUG5ITGtOSFE5enF2V1BV?=
 =?utf-8?B?RXo5R0J2aUFPT0lsTUYwUkxnUmJSRDRudkRjbzhVZWJWdFlmZWw5UUViQXNk?=
 =?utf-8?B?T0dvbExDbUxvd2FHZC9QTFVzQ1p1eDQxUXdsbkxhTjR1NDZWVklUTzBpcFhD?=
 =?utf-8?B?bUMvSVRnSUIzL1lyVGxrWmJZWkZnM0VEaTVkRVpFUGV0bm8xWXRXam9XbS9L?=
 =?utf-8?B?QmtzZVJVOWs3ZlVEamNFRG8rSk9vdlF0UEMvLzdENnFQdjVoNitaOXVkZHVO?=
 =?utf-8?B?N3RXbzNLTjIwUGVLM3dHOS85SXN4aFFEcWtNYXRZaGZJZ2Q1YXNRcVp4Z3Vi?=
 =?utf-8?Q?Sbmti52eW1Xs2K7jRzAnVQvFn?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0d3d71a-9281-41b6-c79e-08de1c8c2fff
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 16:55:56.0690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VKZLvLD7s60Bt0p5Wp0rVHf7tK/WN8+GzxKHBIsBxeSSXaWQ+dCcZA2C576D8Ie8psxDZC4nTFslU8YTJj32Gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8877

Add label for system clocks and add two missing clocks anaclk[1,2]. Prepare
for fixing ccm related CHECK_DTB warnings.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi
index 45bcfd7faf9db628479359b5c0a26e1011a7c2d3..fde8a60dc297a71646b53b355c57c885745805ba 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi
@@ -54,23 +54,35 @@ aliases {
 	};
 
 	clocks {
-		ckil {
+		ckil: ckil {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
 			clock-frequency = <32768>;
 		};
 
-		ckih1 {
+		ckih1: ckih1 {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
 			clock-frequency = <0>;
 		};
 
-		osc {
+		osc: osc {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
 			clock-frequency = <24000000>;
 		};
+
+		anaclk1: anaclk1 {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <0>;
+		};
+
+		anaclk2: anaclk2 {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <0>;
+		};
 	};
 
 	ldb: ldb {

-- 
2.34.1


