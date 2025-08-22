Return-Path: <linux-kernel+bounces-782223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0506B31CE5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 16:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E67855A2E78
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 14:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D327D313547;
	Fri, 22 Aug 2025 14:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BXIA2Bu1"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011066.outbound.protection.outlook.com [52.101.70.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84DA313524;
	Fri, 22 Aug 2025 14:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755874224; cv=fail; b=Eooz8zuDZ4V1zTSaBW7cs0y299duV4dt3D/hPtY9E7Wp5QjHWnYpAZZBt8f+GHQqH+LDTuMD8JhYOFNUGTrEihAFlBArqtsJCyBDDpUgwzwrhOysPaH5VDrlmn+gOCQSjA2Y4GxRah/tEPaGW/NWZF9cIXV9ErEfYUrAlMa8LN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755874224; c=relaxed/simple;
	bh=vq4Ae0/Sqag9tkDt+c6Vcx3gnkwcz2130LnGu26D+cQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=nvYZsOpnIGbsce0RL9mv67+Uu/yGmLYcVugaWsUilGX0kCNr8vwqBhMxe51w5pqVx0X/ULpHKNMH1NRCZ+jko7uCdDTWy/3ispR3ejSVG6oLlrSQ4f6gALisERrR3Sh7hCeZ18ybzcfIxxaNF6xj2gBWfoiBeNGCtzI88yiNPCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BXIA2Bu1; arc=fail smtp.client-ip=52.101.70.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZNaEBzkooVdFYFBcyZL1nFCNvte3WnKlQ6IVLJmHdr+J8Eu0coSaev0YG/DgvXnTJyLbXQI3Wb5C6nRpUMMhL8vqtQ/Dwhz3Jc7hkNO9fulDQaBK7nhAbJsvA7Ving6hIeD1fFu7URX6B7SHNeV3AGXUeNAV1rkWPiBxNY2mSgC4hYBN/CG3oWdUQ0GJ31pbEC9lnd1Fb4darL8B7Xsx83GgXZ8I0iMSZhNMfA3P5epCB5gFc2MorsVbJdLUFnUgqeSIFqJ3/7CJYaD95Cp58x730aL4Uum5d+E/pBoJ9lOGsezHNCmTWWttBWiCfIL+fpoY1k0WG0oyzCdiRGgqXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zvWcrjrN0GO+QVzCZ3zpQvzyxUZLm8Fw5XIAnUWxtWs=;
 b=smakmNrzdndMOIXmTvHSS9nUt6Oay8qaWR1sa3oHshs/m3WPDpOWsG8vP8ZaIsYfqO6LiJS1Ja+Fi/1iloAhEaulmXG1/L9pn9WF1SUWPcEOLGjcjTThIS/LajH+KXnd7ywOkjPvWm3RZHSmt//HKq/hTFSWDPFXgj2HMLNo68Kr7WGMtHsVUp2sP9GEPiHXkmeKhAONEt4QpKQAXKemIsEBSVWZhVPsaad1fjU5o3RsdkyFI5ubvfpCLgDZCyml4nJjTK1GwcG/x9Bb/2ckfhQlXvIgZc13NgSi32NkGxdHAb8pZnZD//tNZApXGcBXHFZmdnpiA9m4jZRU6T72QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zvWcrjrN0GO+QVzCZ3zpQvzyxUZLm8Fw5XIAnUWxtWs=;
 b=BXIA2Bu1TS3poA6XjOf823KGrswE894KrPMgmrIM7KQ80sPSEgyl/4JB3GZDnw8/suRljplSQxOlVQUbFlPYnhn4UpyoQdd4I8SDi2BPgUZC++saDl0T+UqTnKC/qBJ6wtL6Mpq93pFFNimZXbS3fzlbJ4qVLar/Ocan5hlZGyluQQgkg1axrdFl3Jx6ODur5Pa+Zp/zIpPJ7pKh5VSR+t1OP2PRU4ty1Kea3KEHt0zt8svPAtzdjPFAU6CBUyF8dic1jxehWhzDJQgvZ+MKNHV5EY7jfvRBNxBw8h9YAlyFGtaKMLbCmVaJToMawJ9VqnnsU2v5m2IL1OYKW3/gXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by GV1PR04MB9086.eurprd04.prod.outlook.com (2603:10a6:150:21::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Fri, 22 Aug
 2025 14:50:20 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%5]) with mapi id 15.20.9052.012; Fri, 22 Aug 2025
 14:50:20 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 22 Aug 2025 10:50:00 -0400
Subject: [PATCH v3 3/4] ARM: dts: ls1021a: Rename esdhc@1560000 to
 mmc@1560000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-ls1021a_dts_warning-v3-3-6b611a2f23a4@nxp.com>
References: <20250822-ls1021a_dts_warning-v3-0-6b611a2f23a4@nxp.com>
In-Reply-To: <20250822-ls1021a_dts_warning-v3-0-6b611a2f23a4@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755874209; l=1037;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=vq4Ae0/Sqag9tkDt+c6Vcx3gnkwcz2130LnGu26D+cQ=;
 b=+EbuMmBjVZdXQkVUX/QwPIjaXo1bKsNHah55u1eZMjPNLSchkwCSrR99JROeRyjypDqo7Hwcp
 jLAXWDW2uTGCPlFbjT6Y9mj/aS5TbJIXpcnD9tbAoRpG5nC+ySGohGE
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR08CA0038.namprd08.prod.outlook.com
 (2603:10b6:a03:117::15) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|GV1PR04MB9086:EE_
X-MS-Office365-Filtering-Correlation-Id: ca346a26-f4b7-427c-f3c0-08dde18b372e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dnhyMHY5b0k3WnVCSXVxQXkyallyL2tlSUkvNW9SclN2UnBxWkdCUEtuWWlQ?=
 =?utf-8?B?bmgxemF6Q2xlblN0WnZhRUllUkpramlvcW5kUndYVkNJWUhYREdQZzg0WE1B?=
 =?utf-8?B?cEZ4UWtDQzlpOWk5YmlxVC9GbitaSnkyNFpjS05NSXVIT2JuWGxaL09UTGVB?=
 =?utf-8?B?REZEeDQ2VERCNUVqWnFCWlA2WnlSZ0hURlZScm90OCthdTg1OUU1QXRNTGs2?=
 =?utf-8?B?M3RnY3NtVE1UNGk5Nld1aS81VlZFZFp6dW9rcHIrQjdKODNZMVZLdGw3SjhG?=
 =?utf-8?B?TjJ5MS8xQUVyeDdiOGJKYkp5SSs3QmRPZzNVQlBIUEJLUHZYOGxaWXdMbDRL?=
 =?utf-8?B?ek5pOXJOVWMyMkFlRDNRekxTTkJuM1FIS3V0NzkxSFl4TzNabER1L3pTT2dy?=
 =?utf-8?B?aVRGekRkOXgyMDVWWlFIYklJUExVU0R2VS9uNTFxU3dHV253czB5eWJyNGdi?=
 =?utf-8?B?VDFNeEYzNUhBZDlNK1l4aFBlaDl6UFd2VUZYaCtuOHViRzFaR3B1UEllRFEx?=
 =?utf-8?B?ek5YbXYxNUdSR2lVMUdMZzQxcVZoekhMdW0va3ZLOHBqUWpTYmJMYUdWVyt4?=
 =?utf-8?B?V3g4WlpjVzgyTnREaE0wK2xWalRENW1EMUNuMVVlc3NnSm5pKzVZKzQ3UVkw?=
 =?utf-8?B?RjJCZksyMU5IanplVlNNNnhMMUxRc0NtY0kvdFl6Z21wT2l0WjMwaFZkM1lq?=
 =?utf-8?B?bVJrRkpmYkE2L1VBaW8yaFNvVkpUdTJQenpkaWFjYVNocjd2Smx4anNQbXlN?=
 =?utf-8?B?VkQvZ3pkRzdpRVB0alovY3lTM3IzV0NlYXpFeWFRTUVwbkYxQzV0cVBScm01?=
 =?utf-8?B?QXNqMVdqV1l0WXF2QXFuWWsvQ1IxSGQxcTl5RmN3TGYxSGNzelR3bHFvWTRw?=
 =?utf-8?B?RkRPUnIvb203VStmNEIxU211b0JOWVZaZUtRUE5ORTV2ekZ5RGZSL3cxN2dj?=
 =?utf-8?B?eXRObFlTbUNja253ZVM3R2wrTmFGS1hPT2N4c251V1A0SXVQQkJJYVp3YzVY?=
 =?utf-8?B?bGFmZlpVeDRxY2U5Vlp1cXZzVnViVUF4TmdoTnBCMmtJSGsyVUNBdkJJNXhu?=
 =?utf-8?B?R3Y3bW5TWHhkMlhwN1ZiWGwwL3NpSXdTUGNweDlJSHpzdVBWWmRNVkdNMk9D?=
 =?utf-8?B?SFYrR3RKZWx2ejVwOFpYTmhzalE2dk9sVnhLcDlwR1VUUFp2TWxWREN5OVp2?=
 =?utf-8?B?V09xWTNMcTVxVGt5MncybThNeFNKbUxMREdHbk9EUC9vS2RvVFV1V2U1NDVh?=
 =?utf-8?B?RE1jMXNpTWZsYU05RjZUcHRuQWNGYzdwRWthU2p6QXNDV3F4REF2amRkelpm?=
 =?utf-8?B?VEdxNmwzVnVVampnY1FWM0FxdkdEeERORWJqMDE5NytmYkZYM3IxUWZ5Mmtn?=
 =?utf-8?B?VFg5ZXdFZkgwOS9BWDRkRXVIWGEyUnhtOGV4NEkybVU4eG1ubDRhL0QySHFy?=
 =?utf-8?B?a2tyK3JJd2VNcnFYRkhsVUl4eHhQWkpXemNENktEZElud2duUmV2SEl1emsw?=
 =?utf-8?B?a3U3c3licTZBeVBCZ0VLNElERkZKV2FVZ3BVTmNCSjYwZzNoKzBYTzFyRVRp?=
 =?utf-8?B?UTNUVUlnRWxwRW43MkprQjJCdklWY21kMEQ1WjA3M3l2WkFPYXAyeGxRUDk1?=
 =?utf-8?B?YmlibFZKMzRRNmlLMXB6d1E5dkRJM2pzRHdrZmc0TktObjB4b0tuamFWSGN6?=
 =?utf-8?B?NEluMnFhdWJTd0tMSFJXbC81Z0hENUQ2a2U3M1p1cGtmQWpDRVJqUGFCV2Nu?=
 =?utf-8?B?cGxTalhBQmtvY29NeWlUTno5am1aLzRaamw1TjVGeEIwNlVwcXh0b1o3MGtq?=
 =?utf-8?B?TzZWb3FnS1hzT0dCTUc4R0Z4Z3ZHdEVkZk12dkJFUTBoL2tpRmNKajBsSnU1?=
 =?utf-8?B?OW9SL2U4QWVkSkxIcE9ZY1dCM2JIR2FTV01MMjRaUnl0bC8rb1dTNGNqZTVE?=
 =?utf-8?Q?l8N/YXy2gXM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aVh3OHRJT203Sk9oeC9jcFN5TGJSS2IzR09MV2lWMjQzZFhLR2lrYkJUQW56?=
 =?utf-8?B?b3JNc25adEZpM3BacmFlUG5DMWl3cndNUjRKblZVSmFZOEY0UCt4eFF4WjJh?=
 =?utf-8?B?YWhuek1Lb0loSlJQR3VkYUtDamk0ZGNOeFRVV1BLVzZybHozYytTVDNLODFq?=
 =?utf-8?B?ODlBcFdwUlZsaFNjZjh6SENVZGlST3FCempReVREMi9PM29uU1FhNHVaSkFV?=
 =?utf-8?B?Yy9yVVJyRG9lOEl0QjJxL2lQWWVSczU5VVRpd2FsM0hYNGhYU3FGUDdtNTdj?=
 =?utf-8?B?L0g4UTVETm1rWFdvUjN0TkpwejFEbm1jS1NxRVJwTzViaHlqK2RXQzNGbzI2?=
 =?utf-8?B?eEVvRURTcm5xRHZqK0F0TFdpc3RSVHY2SHltTVd6ckR3TzdoQklRci8vT1RU?=
 =?utf-8?B?OHMvVGlBNmlRNGVDeTY5V3dPTTNlVTZMVzRIbWJoUVR1dVJ0Sm5wU3l3WjBq?=
 =?utf-8?B?NStodlNrRFoyb3hrTXhwL295UFFXOEUxMnFUckZINEFaZjZINXU0NEplcmxw?=
 =?utf-8?B?Y1NmUXVVbFExTUNPV2s0SmFCNUlyNmhTZmhZZXVHUlV6dHcwQW02N3lSV3NJ?=
 =?utf-8?B?NC9aYVdIRjU5SnFtMFNpREEvK3gwb2VSS284cWNVc3JyenNBajJaMDhhcEdO?=
 =?utf-8?B?YzQxTGdSelNQOXVmUWVObjEwSURPQUhJTGlzMFEzc3ZQeElPMXc4cWhhYUZI?=
 =?utf-8?B?RllpakxsMnVoSW0rUWhETGxjVUJDSmxxaEk1cUIxOGdOdWFSUWFySXNWKys3?=
 =?utf-8?B?MXZrbnRocDYyTDhFcEIrVXhKMDVsZkZnMm5PbjVVR1BiWW5VS2x6LzFNYTNu?=
 =?utf-8?B?b2xyT2FFZzc4UjRFKzFVZDJjV3NjTGlNS2pldzN0cmhHK2t3ZTJudG9IR0VU?=
 =?utf-8?B?bmhCUEVRVjVLRm9SQVJhZUhXMWxDRWZTSzFLL2dPNlViMytPbVl2cXFlWkpY?=
 =?utf-8?B?em40c2g4UDFPZngyeU1LQXY0Q1hSQlpOZGFvd05qS1FyUEVGaklSVmNMSXQ1?=
 =?utf-8?B?c1NtTjFzL1pVOVdPQXNkb1VyNnhZcWUzdGVDYW9SUWdVVDRlOUt4b1RQUHdh?=
 =?utf-8?B?cjZja2YyQVJUaHdSVkExZWNuV2xsMjREY2ZxNUpVR0Q2blJTM3NtMmdHR0Jz?=
 =?utf-8?B?RDM1cm4wZWhnSzFhR254b0RmczlaaWNUVkdKQ0xrRm4xUUpqc1JDNTQxbHEx?=
 =?utf-8?B?MnNrMTdzUy9GMzhFb2RmRE9EMGtwYlFLaWdvc1FzTnRKUEpESmNla2lRbVhI?=
 =?utf-8?B?d1dTL2g4eFQ4M0FpYTJOZkVmaDBYdlRyU0xCNzlWdTZzWGY1VjI5UHR5MndD?=
 =?utf-8?B?ZnY4dFZvYnZMYytOOFMwT3oraFZNUlVpRWJzYkxOL2FBVWVqMTh5T3VnRXpQ?=
 =?utf-8?B?czYydjBFQnZEV3o2SHZUbDJYVkFUZjVNQnN0SlN5ZWsrSUhpeTN4QThxM00x?=
 =?utf-8?B?Rk9vaERKL1VUY0h5NjJRcTh5ZGhYaVRpNVNyWmM2Y04rRWVtWXJ0clBmdmJM?=
 =?utf-8?B?dTFYVFgyQk9JZmhkTDgxVW9GUFNkTE04RTlBVmMrQmJocS9uZlBHbGtIb1BV?=
 =?utf-8?B?TEYrQTZMODNNL3Y4NzBxNUlGTUhWSEpoYXRKYVpkQUh1eDZ5amxweXpZc215?=
 =?utf-8?B?TEJHaTdMcDVTdlJkL2RWcHRJeUlybkNtbDdrNFROQTlFdngwZWpxY3pSQTRz?=
 =?utf-8?B?Vy9rZnR0QVNkOGg1dlphWThBU0xaK1hSQ0IrOUN3VkMrV3ZJRUE0K0IzUUw0?=
 =?utf-8?B?ZkVncFdTc2tDbW84bnIwS01KUUk3c3E3YmtwZkN5TDVNWmI4SmhqWENQc0Vk?=
 =?utf-8?B?ZStoVXUzVFJ1TG5HYWhWeFZEYUxsN0pFdGhMYyttUHhmNWU5Vmg3eVQ1a2hV?=
 =?utf-8?B?VklkRGgxZjVsczY0VmlCWTJGZVFaMEFsZzZpSEhMOGI2Y1VNTGRuS2xuaVcy?=
 =?utf-8?B?bC9jZEdLR2RSd25HYnM4UGNpUUZmV1N5dTZxNFlTb0thYW9JMEdKOW96U2d1?=
 =?utf-8?B?ODE4YTYyanEvbzNhMTE4Y3FnaGgzVkMyOTdXYzc2bk9qVmpwMHFFVCtkT0ps?=
 =?utf-8?B?VjFTeGdTcktJZWp6MnMxOTI5L3ZTckhiVGFINytReXFFQjk1dWVHT0Z1Y0Vu?=
 =?utf-8?Q?ctuo=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca346a26-f4b7-427c-f3c0-08dde18b372e
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 14:50:19.9830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C8LI5X/egmUhcdU1Y2ceTZ0FztggasTqiafw8i0qTa5Zy0UgX+/oeQTKu+4mkT7rdHNZJMsorja3UhbANJueLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9086

Rename node name esdhc@1560000 to mmc@1560000 to fix below CHECK_DTBS
warnings:
  arch/arm/boot/dts/nxp/ls/ls1021a-tqmls1021a-mbls1021a-rgb-cdtech-fc21.dtb: esdhc@1560000 (fsl,ls1021a-esdhc): $nodename:0: 'esdhc@1560000' does not match '^mmc(@.*)?$'
	from schema $id: http://devicetree.org/schemas/mmc/fsl,esdhc.yaml#

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/ls/ls1021a.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi b/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
index 29105773add7f4da0ab1c3acee753514eaae4a62..e0b9ea6dd510057875c12037f636672a4e77d035 100644
--- a/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
+++ b/arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
@@ -154,7 +154,7 @@ qspi: spi@1550000 {
 			status = "disabled";
 		};
 
-		esdhc: esdhc@1560000 {
+		esdhc: mmc@1560000 {
 			compatible = "fsl,ls1021a-esdhc", "fsl,esdhc";
 			reg = <0x0 0x1560000 0x0 0x10000>;
 			interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;

-- 
2.34.1


