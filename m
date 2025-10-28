Return-Path: <linux-kernel+bounces-874655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF42DC16C9E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 21:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E25003B174D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 20:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0ED351FAE;
	Tue, 28 Oct 2025 20:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Q6DW1Bua"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010053.outbound.protection.outlook.com [52.101.84.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F425350D68;
	Tue, 28 Oct 2025 20:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761683479; cv=fail; b=HY67LilCxO8k8KNYN9rsyVD32oYuQt2DLkNsxyFMwPsLz1g3DGO4AdGo+MOeH/zB7JSA8OkTtkJBui4sMXjNe5GN18F+/7G4X6I5m0CpsxmUVcPSfvMhRtRSkgd/PUvgyEMmVySnXHRcZuGR7S+2asXDKhP8IhviJO9NqNTJfpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761683479; c=relaxed/simple;
	bh=fa95vAdFDghDU2tPTIfO/9WLGD4jhOvBdKoL1WB3+is=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Wj4S/qdufQ2uwyVbN8yUTL6y+GQbPwfSVgGOw62e41g4kHvs5mWBc3SnZoIaJpkI7prbrq5BbuMBzeY3868UIHUxQgBQ+Xmn0t4SFZT0Vg9pEveY3FWWLYRcY/Fb59GzVm6drHmHYpcBRuSvXGNug9ndlFBGnBTBPucIjIXaI/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Q6DW1Bua; arc=fail smtp.client-ip=52.101.84.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XT1SAW7ohfoNa7mxtheAkXHU8Vu5I8v3xpnm4X+3+ChCf3fghd2qGaMmjq0XvnnipE263Ze6pvsuT13Uw5IbK3KA3rvqTD4A8/JENeAQ+EVCt10HRdCMUjdTxudtqbBOsuSregep95c8b7+xyPKX8aHFhfwyW69GZQABihH8TBsqNBBb+aDyCgBi5uGyvS0opoMH9/8a1/tEMka7ckVfP+95j5gqepPG65HVhV+2Wh0uVlb1DU9GCOS5kOjkLMAKnPc8KTE8+yOCIHG3w91w3Ibbsx1YviavVGWzRsJUEtDIzsHKyRTSK3gkufmcOB1heazSK0JFhpjM35BLnK6MOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Uzwz8b0ngPxNtMnxJryt0AJvSwXOit9Qjd8SrhQUt4=;
 b=GjHGWDZ6wc/TfBgQB/kBSu8aedVCbC+XHBBwEADc2B/+X5/K7rW3GfoeDULR2cMqmNmH2axcDTr5m/26XW5mXy26B7iarm7AJjP6YLt6PrPsYhZyAaXg8dEbbDf/PeRd5NrsNtYouGLkDXSgFTmmah7dyvhez3PMPhL1nzjTCDCW17jqlfTmao3eXPHTMKxt5XaltOlCNtRdvcecK+hKFO7U9jUwQbqe70/ktIxz19gG1sJM4GFiqegSEL0vwB6rQEuT8p0OF96nQ2aCpxej5PRvDTqAe+VftU0unvCjcXhzdBuT5WHgqjFdKpHDRsQCfC0Xgk3XtU0tJQolmWPwvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Uzwz8b0ngPxNtMnxJryt0AJvSwXOit9Qjd8SrhQUt4=;
 b=Q6DW1BuaKOIKRaxnf27XbD9O7Cm/mJiiF4VDLf/qAt9RqYRbG5jlD8C4lu6pbiFDLJkwLymLhT2YfFHgfwWM+nQl7ezudHOkxjhc0GPvIQWOruKCVsar1clKt2pCvhU/wSxXvNsiScG1tSJhuDt5bloFOv7lGA2c8L4jYrWh2Kg6y8V5B3pXKr1in1mWR2JNfTsqt8x6Nj+v4UJat9HYiPoQU30don2oKcw1BPgW3+no3xt/vCWzqvDEFl26q/5/A3mE6/TeWuDqBOfFlrus80PTlvXSTuB7lelaE11IbERGqr5F9eNVVxSNMMfYbxVWOZW0+O2LrKeZViZuB2I21A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AS8PR04MB8820.eurprd04.prod.outlook.com (2603:10a6:20b:42f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 20:31:16 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9275.011; Tue, 28 Oct 2025
 20:31:16 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 28 Oct 2025 16:30:48 -0400
Subject: [PATCH 7/8] arm64: dts: imx8qm-mek: add supports-clkreq property
 to PCIe M.2 port
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-b4_qm_dts-v1-7-51ba94389c1f@nxp.com>
References: <20251028-b4_qm_dts-v1-0-51ba94389c1f@nxp.com>
In-Reply-To: <20251028-b4_qm_dts-v1-0-51ba94389c1f@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>, Richard Zhu <hongxing.zhu@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761683454; l=1134;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=WwZoUpH5GZ/5HHKpJGlhq+mJMEC+Byor3bDmU/rLRKY=;
 b=g+1igOTgubRPCtfH5ZgjCLxbo1r6idZZLqjehgKESaT5egH3B7KhjWywAvXnYV1dsJJLlWN/B
 trNMQgC5SE6CHgWp3RGJwANheBHveLwzY1q2mog0MCquf0Or9ZzGJYF
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH0PR07CA0031.namprd07.prod.outlook.com
 (2603:10b6:510:e::6) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AS8PR04MB8820:EE_
X-MS-Office365-Filtering-Correlation-Id: 05ed321b-aaaa-47f5-0b90-08de1660f1d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VDlyRjZ4OGlMMEJSejRZbjA4Z25DN0xuanFoZ3dubkNGUDVFMHdXSDhGUDZk?=
 =?utf-8?B?bDEyajNmeXl6aWV2NzlmdTk1WmwzeGRhMEZrMjdYVnhLNnZvcjRnaks1b3BC?=
 =?utf-8?B?UTd6YnNtczZqL1RNYzdWNGJlVnNYeU02ZXlkY29LRkpqTEhDRk52TVFLTXEw?=
 =?utf-8?B?d2lKcHJHc2RWRFk2MlNaKzNlc3NBL1VvZi9OOGtDVUdMQnBCaTY5OUpsak8x?=
 =?utf-8?B?UTJNSTE1MTRhV0c1cGNXeVloUFhQdEpGRUlWYWtIaEY4S2JUZzRhMHhKby9B?=
 =?utf-8?B?R2Vmb09KN1JNaXFBVHFrNDRkV0NBSlZTd2s1R3dnSHp4SW1yUlY0SGxWakda?=
 =?utf-8?B?clNRUnovTWtJb1MzOWNLNWdtY2dWbG50QlFsQkUwNXdMWEhaeHRPdzNrUWJY?=
 =?utf-8?B?VmNTSkdZd3NSVTA0U0YveXQzYWNHQkhxZmVYaVJVeXJ1ZmhjWElMRXhXRTl5?=
 =?utf-8?B?ckVrdjhEU0xNU2tHSnAwOVVSK3VWc1NzN3ZQWDk4NEw1a1BxOVFvcGlpalhL?=
 =?utf-8?B?YUF5dTNZY1p1anBKOEM2L3FBR3Jpb096UDRIUzhnQlRuVUhnMzlyWVlvckFm?=
 =?utf-8?B?TWRVU3BTdTI5blRZclVFZXUyN3czK3hSSmFiMCtaaVZ1ZkF4MFpNTzZLN2lv?=
 =?utf-8?B?eVJPK01DWlVreVFza29WWFFscFV5V0JxdXhLYXhSMmVSOTRiZzBQWWlhOHk3?=
 =?utf-8?B?dndsYTh5UVlqRWg4Ny9rUEo5R20yTHB4M2ppREdzbXdOUE5veGJuQ0Vqd0Vv?=
 =?utf-8?B?VmVvc0FHREtMdzhxMFBBZk5NVGpPSVo3UEhPMmZFNWtXY3lGd1dNWXhZUVZT?=
 =?utf-8?B?RlVFNmZVUVRDaXJtNnYyWXA1cTJVTU9VaFJvU2RyekRxZExHQk9mL2toTGhs?=
 =?utf-8?B?emM0Tno4WWYyUGNHUkdUT1R3eG9zaTN1MnI3UmFDTFBxcXlvZ3I5T0E5WmVM?=
 =?utf-8?B?OC9rOWVMdkxNNGhFWUlUcm93SmozQjhJZUVFU1ZCSXNpa09BVXhoMkF1Wkcw?=
 =?utf-8?B?dHgzRUVSVGxTZmhha3Q3WnJwVjF0N1Z0T3V5OXZoaHlJRU1LaldTYUlqVDRX?=
 =?utf-8?B?cGhOOFU5eGtTTXdjbGM0WTBRYlVyU1VlTS8vZmVJRk5IcUdVR1BBN3VCdFpX?=
 =?utf-8?B?NFhNYis2MEhOQ0dlVW9CVHoxTXFQZkZEbEZJTXVKRGFNOUczd1NYbm5rY1lM?=
 =?utf-8?B?YVBrYk1hVGdqTUp5R3lUZFZZSkVCbmNOc3lka05ld0hPWlg2UnBWaW5OenVX?=
 =?utf-8?B?eWpIdk0zM2dTeVYydHFvb0RRY3dJcUR1N3VVSCt6bU05U0EvVFlOTEF5QXAy?=
 =?utf-8?B?Rlc5b0dqeHpGU3V4U2kydVpCR3dHR3pGMU5PVHBXZVk5VHM1QTh4STQzSHdB?=
 =?utf-8?B?UEdtTXk2Tmk0VDVKamFldnNsbitscEZTK2JISWsrNVB1V1lDc05ScGpyY1hz?=
 =?utf-8?B?MXVZMjYyWUlBdFhkeURQWTJWRi9iK3BjcHlCNytMRytVTzIyMFVzNVlTcGQw?=
 =?utf-8?B?VFJaZEdnNWlyeG44U2o0U1N6bU5vUy8ySTl3cTVPUlpRaDlobUFHVWpFcGZy?=
 =?utf-8?B?YTlwYmVNcGRZSlZDdE1oS1h6VGR2REhBbnhlZDEyRUVNQzZncXN2STVvQ21J?=
 =?utf-8?B?VUFyZUVTQ3pSR1JsVEtvZjZ5UTFlNkF4TmhzVEd6NG5KYmJMZXllTHMyS0lh?=
 =?utf-8?B?MWgrV1VPbDVIdjFHb2hGeERaTzI3eTc0SjFBTlZSOGwrWWJkc3NmK2tQZ0p4?=
 =?utf-8?B?NmJDMTVhRWU1azZUeUdiY2FZZUtvaXFUQldVU3ZXUXRveGp0cmgwM3JmTEhB?=
 =?utf-8?B?WE5zbUxzenMrRlBmWWs4c21HYk9KWm01Y0sxcUF0OFdRSGxtYkNVeFkxWER0?=
 =?utf-8?B?RUc5dVRrdHZ4V0YvTjZleVhyYWtOWEQ3b1BMSDdGbWp4MWxEazZDOWJPOHBC?=
 =?utf-8?B?VnZ5ZCthelo1MC9qZ1drSnJ5Z21UVTg1T3BYNEt5N0tTekQ0c2JWUjdiZEpU?=
 =?utf-8?B?NkJNY0V5UXpSWG9NWkJYV2ROK1BCaWsrUk1qdlBhSklnMzFocnhzOHJ4eGZJ?=
 =?utf-8?Q?nfnZFN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VTV4ZWxHSjQwZUdmU3JhUVJTVUcrT1FTMW9YeEJoZWVWcnRuZnpzMXJmcHRs?=
 =?utf-8?B?SUhDZExQeTNqclpnSWJDQVBtbzhwb3RLMjBmbDNhWEFXZkVPQzg5ZjlCOVEw?=
 =?utf-8?B?RmxibTNVRU9jUVlHRi9ZMlhRdy93VThqZ2ZJUXViNENUb3hmZm1zRk9CYTgz?=
 =?utf-8?B?dWVzd29hMTlYWVRsVU94YmJlVHNTSWw4ckNFL1BDS1FwNFE5OWdSblBybWwz?=
 =?utf-8?B?aFBvenNCZW1qa3d3VndDMUNORlk4RGhrMzlsQld0em11NTFFVG8zanI1TUUr?=
 =?utf-8?B?WU1UMm5JR1VYeE8zaUFjY044anJlcWlnYVBkZFdLNW5oM21QTXZndWhST2ly?=
 =?utf-8?B?a0pUeUo2MnlOREpnS1RQK2hQV29Sa1RBUWUxN2ZXVFQ3YWhsTUN5WDdaaXJl?=
 =?utf-8?B?SGdaay85aHFCMXNzSk11SDh1azdvWS9XbW41eDRLa09KbVVTV2QvV1lNU3Q2?=
 =?utf-8?B?NTZkZzBwamRjQVZzYUo1Q2s3cDVKZ0RVQ2xDek1ieDJJYWp6MUdPcFMrcDNy?=
 =?utf-8?B?NzduZ2JEMi9zTWlrbldZb3REMUJiTlZWVFlaVkZrVnBaTXJPK1llTUlTb05I?=
 =?utf-8?B?b2ZUeW84MDRsRE8vMEhEM3UvM1pTdGNKZzZjcnpxdFhPdHhidFN2amlwVlhL?=
 =?utf-8?B?ZWdoZmF6NGQ4QmlvZ0VmQlVNQnN0OFZITzZVcHkraGx5MTA0SWRiREJZS0J5?=
 =?utf-8?B?NUQxaVR6UlhuZVJPb1hIOGRwajJiZVV4aHF5NVY0QXBDUkxtbnlhQTFhU3Ju?=
 =?utf-8?B?TlVGR2l4eXRBTThjSUZ6eFFYR01rN0x2U09DbGYyeCtXVll3T3BMckJUa29n?=
 =?utf-8?B?WU1VT2tsVytXNVovSWhMeEJscHEyTEt5S3laenI2UEkyVUd4ZVRvczloYmQw?=
 =?utf-8?B?MHczNjIrenNPeUpBWVdyK1AwY0tmOVZPaXhSOElaRzlDNnlWRC9ORXB1RTRT?=
 =?utf-8?B?eGtyVWdTalZhVytsZGtsQTVuWlUraldoR3JSenV6UHpFTkVmWnZQV0lzYklE?=
 =?utf-8?B?Wmd5d1Z5bDNmL0ZhaTVMYXRvbVM5QzZqdVFFc0R4QkNnTGxCQzUyaFRHTEZz?=
 =?utf-8?B?SE1ZQlE0R05kZ2ZnNEcxanh5YlZNck9mdklCeGJiaGMxZE5DMzNjZUpSWlMw?=
 =?utf-8?B?dS9lU01DbzdxN3kybU5LbVJiaFNJNXh4Sk9EdnZjRTIrNlI2THFkaHVNWTBi?=
 =?utf-8?B?M1RueDA0TmNWckN5aEF1UXZKamhmb2RjMEtySkZrUk40K1VBM1JRdGI4elZG?=
 =?utf-8?B?ellSS2liMmZLMWhUM3RPbTl5cCttTVFyd09LWkp3VUFNeVhHbXUyaG1CNVNo?=
 =?utf-8?B?a1BLL3d3TG8vZ0RjMk5hYlBZVS9sV2hzT3JYVjBneWNOSDcycXoxcWRBR0NR?=
 =?utf-8?B?UUVHMVRyeFA4UWJxZnFneUlyWFlvcUxRSmhUMmlOOWxmMlhYNVNENXg3ZHJs?=
 =?utf-8?B?Nm5GRVVWS1pUQVRPM0JkWjY0RUc4WkY1YzFqRjNoelZzby9ZdHljVjdGdHYz?=
 =?utf-8?B?Z2dqSytGOXZvd0JIQkEySDhRVm5vYkJSOFNJNWp1ZVo0WXBHcjdqR2dKS2Rq?=
 =?utf-8?B?MDJXZFNGcjJSd2RhWXhONU1jeEVjcVY2MHB6eitjR25LQjBreFdWdzNaSmxK?=
 =?utf-8?B?MEZxWW11L2szUXV5NGE4MGR0TFI2N2tBNG1tM1hkb0lPS2FoUVQ5Szd3blVB?=
 =?utf-8?B?dlNTYXpQb0JhOVRtbXJVZ3ZseHBoVXpuR296WVJWWUVlODlTMWJDSEZYNmx4?=
 =?utf-8?B?bFY2dHJtTWFPSHllT0lObWdNRXM0Q01EWTU5TGpuR3BhUEZqTE1LV0doVC9u?=
 =?utf-8?B?aXFnWWtwVE90SGFNK3I1dVR4UnJXZzdtREJPb0Jzb2wwL1ZQb1Jyb0FESTh3?=
 =?utf-8?B?SzNzVmJZajhBQWNlNUxjOWZwMUFBaHBVQ0xFS2s5WEJ4emhCYnR1N0VMMFlK?=
 =?utf-8?B?amxlM1pUUnk0MmIvVXhrMXJIY1JJbFM3clpzcGtUSTE3THc1Q2dVV0k4Yi9P?=
 =?utf-8?B?MitJR1FFVVZHZ2V3TEpGWEVIQytwSFcrbkdjc2lSc2R4K3RQaVNZY3hNU1px?=
 =?utf-8?B?VXVCUUZuTXFGdGhsTXllWmltSUIvcXRzNXJOUU1ZcW00ZXZSUWVmaXJ4djE4?=
 =?utf-8?Q?MX/U=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05ed321b-aaaa-47f5-0b90-08de1660f1d1
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 20:31:16.7514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rWrUNA38z6sAkXrHvkTxcJQRKB7OyYBj/ROvXHUME6vtPBlzgoEQKOVu5g8xsabEVMkQvxuCO6bKwacQiSidEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8820

From: Richard Zhu <hongxing.zhu@nxp.com>

According to PCIe r6.1, sec 5.5.1.

The following rules define how the L1.1 and L1.2 substates are entered:
Both the Upstream and Downstream Ports must monitor the logical state of
the CLKREQ# signal.

Typical implement is using open drain, which connect RC's clkreq# to
EP's clkreq# together and pull up clkreq#.

imx8qm-mek matches this requirement, so add supports-clkreq to allow
PCIe device enter ASPM L1 Sub-State.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
index 578bbee5a861397b4f8528d4c7746630a40f2935..64479802a6cb85adc2c817c0e605e8a1e970aa45 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -794,6 +794,7 @@ &pciea {
 	pinctrl-names = "default";
 	reset-gpio = <&lsio_gpio4 29 GPIO_ACTIVE_LOW>;
 	vpcie-supply = <&reg_pciea>;
+	supports-clkreq;
 	status = "okay";
 };
 

-- 
2.34.1


