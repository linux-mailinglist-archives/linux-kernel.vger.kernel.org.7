Return-Path: <linux-kernel+bounces-874656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28BF8C16CA7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 21:33:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B7F74038A5
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 20:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27AB1354AC3;
	Tue, 28 Oct 2025 20:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZutlDfum"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011008.outbound.protection.outlook.com [52.101.70.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3529F32B99B;
	Tue, 28 Oct 2025 20:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761683484; cv=fail; b=lEp1k9foKTeFAN7RUACh2vB+O6vKDPEWzpmilUBSXB+M7uppURK52LjOKDPUA98zz5EGRCiLft5DNf7mhUtcXFlC/8r+FIE+K/6ujWvELeF9zo/tTuYFyrQo7Eaa7VipCZiG4H+iRH/50fyUV66PpuiV4/zg363yTc2PejmBYus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761683484; c=relaxed/simple;
	bh=NBMgGogKsPTG3/RR/QWafHMw6b7tZwZ4S9TVrsVw1yo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=m8qhYrmpxSOJGbPfrVBI3CYMARY9Y5p8m7R/XZWzYxT4VtKaRffKLBVyIbxLbp7mgjwjt23ata46YnGR01pHl4M3MNmXIpG52bLRI36S02mV19Sr2acEDFNJSWuo3B582Nrz/x5r6q97FbCkGhyBoE90/7vmGU7mkfRQJ8gpf4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZutlDfum; arc=fail smtp.client-ip=52.101.70.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mh1TTnZWvuEa+6vF+ZebsuaSszjrk5npc6FB9P1jHUlYYhIPohetU3SDw5H05E4/V2VqyzEOqtD+CSeofjTLaeZmKtR+QvrEd490GTlJLI13w0kZyhqYiF3NGXDWBbDWOP+sDg9oxPWpEOYDYFt46UjC+1HQErgHNJFi3pKXOAlPtH5I7gvTKbwm0q8hPx+TbqCiowt/AYYuTCLyvd2MRirMvzxG2WMzrFPVfftcP/a4Zp3KPRPgL5/5LctOq2621KeEjwB+5whUoaPodlPaukuXQYe9s0tpN3eM2Fhd6k7EyXEVJheUOupB3uvcnS6btt+8JI4ZpG1vmu5CUvrMNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zvaHShNoYA/8YFVvO3CDRhRLMhHpJ1CPNa7nCwfLJyM=;
 b=bZIImyRaxdqDkquaXg0Cm+8AbVhwfkcu2Nye7x/+6WfIMmcoHuVE0VIA1Y2IJ/rybPfyHIOLEmBvBNBWgRyl2oyxfEfFxB5DkxdtpUVRxMPi+RBdr9vKAnkiY+4/GBKHON7JvyI8rmwQYzftPcTDaWa5zwUf8iyQQBfTj4OPdpkYXt02mZXAuShJA5slR34FUirjkBlb/jyI2YuDVgppSyhXLtXnsZV4086Hu1slfSuzC0ZQiQBNK6WEn8b0/lbHfaYpwYk75C/9cLwkWLq5PcLS+texkgjD+UWUPw1jO51hLEQJ9h4iuGZKPBQj5khSqhvAvPvDtreVGgwY+cTsgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zvaHShNoYA/8YFVvO3CDRhRLMhHpJ1CPNa7nCwfLJyM=;
 b=ZutlDfumdTZv/B6DJAeFComErvBLh196/sD8RGm2rH41rWPK1B7GbQC2n5K1qUwviBklRw5YC987MiJJvLBiycKiTCi5IhQp2KOR2fGiIB21JtRTFZH6xYVSDyN33cmd9YOhaJw5h2qBqyhvd1jH75fYvseACDetDjD/p6QtB+9oXO7b2F9CKeutVaj0ikq+DltkWwXff9GGqx/1cf4+9LCgFo46cturtGImnBlVw+eXLQbvKFYJllzSUWU0do8wehLURWkJyNDzAmMTS5BgG+UtjlgrzqhVhOSqnqP0SyrQ63ufvxNXC3gtM14v+/cJJ9rzNah0pyLHAa9hA2wLkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AS8PR04MB8820.eurprd04.prod.outlook.com (2603:10a6:20b:42f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 20:31:19 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9275.011; Tue, 28 Oct 2025
 20:31:19 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 28 Oct 2025 16:30:49 -0400
Subject: [PATCH 8/8] arm64: dts: imx8qm-mek: replace space with tab
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-b4_qm_dts-v1-8-51ba94389c1f@nxp.com>
References: <20251028-b4_qm_dts-v1-0-51ba94389c1f@nxp.com>
In-Reply-To: <20251028-b4_qm_dts-v1-0-51ba94389c1f@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761683454; l=3371;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=NBMgGogKsPTG3/RR/QWafHMw6b7tZwZ4S9TVrsVw1yo=;
 b=C4CVPq+1sVCNA5IbA8tBtQ/1Zl0szaMsesPV14JCL+5iUEniyXpk96Z1qjXYw5gRmIqr3t4uc
 AMCbMCOYf6lDt0O7RSDtuWevNyiXdZYbUO4cYSarrbdXkbqYjUxUP0+
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
X-MS-Office365-Filtering-Correlation-Id: 82c1f02c-bee8-45aa-ece7-08de1660f3b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eC95ZW94NXN3d1pQQmd2dlJHT1lNbFF1VEF0eGwvOVR3UWpnNFVxZzZVOXFF?=
 =?utf-8?B?a2Z6OGlmcGhrYjh1L2ZNckxYd1FKVmE4dFB6OEV0MmZna3Z2TC8yWUpnb3JZ?=
 =?utf-8?B?NEYxRzBITE4vTFIzeElBQnNZQzMzUkYxa2JVbGxXZ3VtMzJEaCtuV1A3Ni94?=
 =?utf-8?B?UXVwUTBOYUpKZTdQRVYvTkpIZjd3QU9oc0xiTU8yNkRQdmZtV2lKVkVNTXc4?=
 =?utf-8?B?aldUQ0U4MTR3WDZ3T0xueU5GR3d4bFBCNlhqUFpJUFRBVlZhdjdZbDNxY1Ri?=
 =?utf-8?B?WlhGdVNDUTBJVEt3UURZS3NGQjNaTmJTUlhnRnV1TFc4c2RXblpmUnc3SSs4?=
 =?utf-8?B?aWJxQzdWd24zcng5RCtTNUFHQ3V4bithbWtNcGpqbStvU3dTb1dlQjlqUTd0?=
 =?utf-8?B?d2dSMXc4b2xITnB4cDFqRTNUVU5ldHdEQUhWdEVSY1JPT2JGdWxrRUJ3dEtH?=
 =?utf-8?B?S2NzdllHM1hVMEw0UkNMSVRobXBvd0gzYjhwTVloaDlKdkQrbjB0ZG9UY09S?=
 =?utf-8?B?ekJvMVdEU1JiR1I4U2VHbXBqdDU5bzRET1FIWm9WVXdzWVYxbUtrLzRHVmtP?=
 =?utf-8?B?eHp4L2phU2dueUYwSmZURHAxK2ViUW9LdU9FSlp6d2V1SlBDMEJ3UkEwbEV3?=
 =?utf-8?B?RjcrMmdzeFNXNUVPZ28zU01lR1RPUjVZN0ZUQ2FTcW92cGY4Q0krU3hZaHFp?=
 =?utf-8?B?MzNQUzdBUVV1SEF0S0lrYzB2SXJqK2czSFlNSGMvamtHamNNMzJSRFhwMldr?=
 =?utf-8?B?anBkcHpBdWtreXNwVXBjeWJxbk9IazU3QnRyK0VMZ08zNUdhL1RyZ0RiRGRw?=
 =?utf-8?B?RFZIWlpyekxlQjF1eGczbWkwaEN0dWlYeWYvZW1zYTNUeDA0d0RUSjh5ZCtm?=
 =?utf-8?B?NjZKbndNL3FaRm0rb0NNb0NBUERvbFBuMU81L3gwWVBuZFJQM3VMZjR4MTAz?=
 =?utf-8?B?cDRPeUFFTElyWURWeWp6d05sUSsycVM4a1VOMlNzY0dUTlhJQmNyT0d3L1lE?=
 =?utf-8?B?Y25vWFpvT3JCK3Nobk5QOURWUkN1UjVGSHdpc0lnbWhkUzJIdEFoR1o1Q3N6?=
 =?utf-8?B?NWRXbnpnQzhaTklxdnlmR2lJK3JvMjEvVTFCTmNRbnlJektRVkNDaW94V1FY?=
 =?utf-8?B?d3dZcjN6WkQ3Z2l0dUxvdHd1dWpnZDNlOW5sMzJrTDlMclFTLzFmQktBNU0r?=
 =?utf-8?B?cTYweDRNTmxWMUxzdU1kUTA3akh3eWRESHBGN3ZCWjJnME5IVnlvK2JabVF1?=
 =?utf-8?B?czdnYUJYU3pXbHdSZFB6RXRNTVZONWtNNHRmOEtja0E0MWY5YWpDRGpSWU9l?=
 =?utf-8?B?Y3NESHUxSm1ISUl5TmNHV1Q5NDdhZFk0aCs5bFJCMmttdms5c0J6amhIaUU1?=
 =?utf-8?B?bHNETmxmRWtJQVVvaldjYytPWVJqd2dCMUJSSERjYXBHMUdTMjhNeHhOQXF2?=
 =?utf-8?B?YXo3YmVudFpBVms3dk1kbitneU03UE1GY0ZWOEVOaW5vQlg5Ry9iSkFOQ1Bi?=
 =?utf-8?B?cU9MTVVEcDhQclVBWE40bHgxaEJaSWd0d1JVbWtUeGJJYU93TG9EK0RFcDRK?=
 =?utf-8?B?djJyTW5XT3ZGSE1PVENtVmZvZi9oT0NGczkyb3pSUnlLc1g0eFBXcE5HNUJy?=
 =?utf-8?B?MXAvczVQdjlhcEpRei9KZWlRcnJvMkJrQlRmSWI5Rzk2NytCRlFoQ01NT0dk?=
 =?utf-8?B?TDZrSW9LalJtTnRFSzJ6VG5uc2tVYzlJZ2VEeFQ5eDNEbFIyTStTOHV0VStj?=
 =?utf-8?B?ODVPWlZVZlRNeGlGWHdaT0VaUklocXJkUStJUFZvRlJhb3pvZ0JpaVpuWlFm?=
 =?utf-8?B?cG9hUlhRdjNwcEhjZ3VYcUhKTjlOUEtXM1dDNVBCWE1QQkZJUXhHMVhFVGIz?=
 =?utf-8?B?SStvK1pUcjBYMnVWMFhaTkg2ZWVKVlJycVBjZVk5d2xiVE03dGlrMHErR2RC?=
 =?utf-8?B?SHVQRnloclpvOW14YlhOc3NqS2h5TFZjc004aHhkQnUvR0xmeWJFL0lmRVdE?=
 =?utf-8?B?K2xZWlNUUXE4aGkrekhuUXhoNXlpY0laR29RYlhUY3FPU0h6Qm4xZ3RSQlRZ?=
 =?utf-8?Q?7tA5Ts?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VURPbG5KVXpUckV2Q2tBNERQL2NBWE5jd0VEa3p0U2dFUW1jbEhaUTNtSnAy?=
 =?utf-8?B?QzFOV1NkTW5GWFRhU1RQYVc5cWVORVQwM2hpUkNLNG03UDFuUUdqTVE2VWlo?=
 =?utf-8?B?ZHNSb251bHc4bDhUK1c3SEVCWlJSNzlzOFJuQU8xRSs5L3hSYXpWMFM4MEJm?=
 =?utf-8?B?eE93ZmViZ3BUT255bjhSdVM5ZkJva1gvQ0l0cGxTbUF6UytnaVVFeDBPTjdM?=
 =?utf-8?B?MG5WeVhMaVJaVm9BUU5vdnRsRExhYVdnUlBNTGczVGw5cXdVd0tVbjU4OGVa?=
 =?utf-8?B?UWI1ZGhXRkZvczVtUGJMYUhhOVBZSkFmbENOM1hrbTlpbGxyWi9UT1REQUkz?=
 =?utf-8?B?Vm8rVWlWbWN5azk1S0UwUm5Nc2ZoY0xuci81ZU5KaStHUW01bHZwT0dMZ0dC?=
 =?utf-8?B?OFk2Mkczb1BxdkhrMzVKcGZGSllPMWdVSTBYdjBUVkZ4cEt0M28vcllYSmgv?=
 =?utf-8?B?b2hFRDVSNEd3aGVwazNaTi9oNGNwdEw5MHdJaWRLQlREcTQ4dzJQYlI2ZWNj?=
 =?utf-8?B?NTF2VzBHbHJRRitUcVFodEFMWjN6VVUyckdFaEsxampoc0ZtYlNOeEF4My9y?=
 =?utf-8?B?OUtGVUs2eVhLSTNzdjROMGViOHgvMjIyQnVqR3ZqczQzdjA1NGxnQTZvQ1A5?=
 =?utf-8?B?QUhtRU5USlArQU0yNS9MWFRUTGxNRXRnTmxwMlRBbUtwZlVBRVdQOE1RNHNM?=
 =?utf-8?B?SFNNRmkyZTZCV012MW9BRkR1enloWThCWXRHeFNJcGlhbVdlU3Vobloyb2p6?=
 =?utf-8?B?N21VQUhjczBJWGdTVEJtTkQ2Ykh2YWlYdlM2bkxESGZTQmxFL0l4QjlVL1l1?=
 =?utf-8?B?UXMzWTIxLytMY25rZmRnOWliMEdiK1RVZjRzbHlXN0VGWExwSzhJUk9RMnJp?=
 =?utf-8?B?cmVjVjA0dDVFSXMrYk1CWm81OW4zR0RVUUdmUG43QXhveWlMNmVqUDBuMHVm?=
 =?utf-8?B?UjhpSUJPak9sbWMxNzJFQzJDNVJVTTJHeEN1TFF0dDVrT251azFHaTdmV0Vn?=
 =?utf-8?B?ZFh4QVJyMTQvNTJoRzdyZ0VqOTZBWTJFTXZqU2cwSHZja3F0UlA1RWtiUTY5?=
 =?utf-8?B?end2QjhjVkhEVEtacHRtNmM2R1BEYWJHMEh5Z2dwcWZOcDJueG0wSnAyTjBj?=
 =?utf-8?B?VStkR2podkpWOGRmWUo0N215ay9tOU91THRIbThYeU8xVUl6OTBGanZxK2NF?=
 =?utf-8?B?TTVJczlsVTFoTURwZFFOdXFGZmRSTSsxU2d1NHVyY2swNDBhMW5mS2F3Mk85?=
 =?utf-8?B?THR3SklBN1ZHK0gwVVJVTzZNTzNiREtsY1lvTmRPRmFqQlFabjE1aWtRZ3lO?=
 =?utf-8?B?dHljUGJza2lvbCs2bzZBdTFmZG8wd3dSVXIyc29BclhobzQxbkNPUU1HL0hM?=
 =?utf-8?B?T1hwelhGZGJQQ1NONnRkVDZad0pRNy9kMG9rbDBnWjJFOTZxK0NoQnNBT3hw?=
 =?utf-8?B?cCtMc3c2bVNKak53N3JQTytCenJqb2RjbXp4cStoQmhRUFN6UmgwQi9OUHZB?=
 =?utf-8?B?ZmNsdHhIbHlSNlY0T3ZsM1IrRUlMcEZzcSs3YTVsWS96WXpqOUpROUtmMEk5?=
 =?utf-8?B?U0NPV0pzTU16Y283NTZlbWVwT3BvRVB4dEE1L0cxVUtEZ1dQV3puWkllaW1n?=
 =?utf-8?B?SXdVWkZtMnloYXRDbFQ1Ly9abWdKT0lKZUg1Qm9WV2lpM3pYbHlYc2VLaGFw?=
 =?utf-8?B?cE0yeVA4a1lmR1dFTVJ5WElPNXRSNWhwVncrbi9CdnNicVllQ2UrcVVyN2lK?=
 =?utf-8?B?azdQSGFUU24ySWJOTys0cVBDVDdGL3R6K0I1NHRienJoVVFhcmZGdllUeXp1?=
 =?utf-8?B?a0crVlNON0dqNXo5b204b3Bla1dpNnJNRmZRTEtGK2VKUjRxVlBkUTczbGE0?=
 =?utf-8?B?RDNyczJWK1FrdEVCZWpWYlFyckk4aHFBY0dEejZpbVFHSjVzWWNHSzlKM0JS?=
 =?utf-8?B?c2dhaHB3c3oxZmZxcG45ckZmcjJXTjQzRE52clMxcVp5UTNtM1hXL3luKzdm?=
 =?utf-8?B?MTE2MmRzK282V1VteUZUdktLZytvZC8rS1NaUWwyN2lLbXdTejBEcko5TS9P?=
 =?utf-8?B?bkZCTnpMeEIrWFM5WmJDdExpNnlrNGZmenhGUzl4MTlVUi9QOTdkbmlPNmdm?=
 =?utf-8?Q?khMo=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82c1f02c-bee8-45aa-ece7-08de1660f3b4
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 20:31:19.5982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cyk5MRyY7P2r9V1Nej7QGYrAgqQi8S5IJ8S0u6M5ZQXbx927/DlYrUCRUC/NJ4mnVcVhrkemCXYXXwGocig73Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8820

Replace space with tab.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 44 ++++++++++++++--------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
index 64479802a6cb85adc2c817c0e605e8a1e970aa45..3fc9258758ffcee878ed2ec08162246cfb1bc773 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -1084,38 +1084,38 @@ IMX8QM_SPI2_CS0_LSIO_GPIO3_IO10		0x21
 
 	pinctrl_mipi0_lpi2c0: mipi0_lpi2c0grp {
 		fsl,pins = <
-			IMX8QM_MIPI_DSI0_I2C0_SCL_MIPI_DSI0_I2C0_SCL      0xc6000020
-			IMX8QM_MIPI_DSI0_I2C0_SDA_MIPI_DSI0_I2C0_SDA      0xc6000020
-			IMX8QM_MIPI_DSI0_GPIO0_01_LSIO_GPIO1_IO19         0x00000020
+			IMX8QM_MIPI_DSI0_I2C0_SCL_MIPI_DSI0_I2C0_SCL	0xc6000020
+			IMX8QM_MIPI_DSI0_I2C0_SDA_MIPI_DSI0_I2C0_SDA	0xc6000020
+			IMX8QM_MIPI_DSI0_GPIO0_01_LSIO_GPIO1_IO19	0x00000020
 		>;
 	};
 
 	pinctrl_mipi1_lpi2c0: mipi1_lpi2c0grp {
 		fsl,pins = <
-			IMX8QM_MIPI_DSI1_I2C0_SCL_MIPI_DSI1_I2C0_SCL      0xc6000020
-			IMX8QM_MIPI_DSI1_I2C0_SDA_MIPI_DSI1_I2C0_SDA      0xc6000020
-			IMX8QM_MIPI_DSI1_GPIO0_01_LSIO_GPIO1_IO23         0x00000020
+			IMX8QM_MIPI_DSI1_I2C0_SCL_MIPI_DSI1_I2C0_SCL	0xc6000020
+			IMX8QM_MIPI_DSI1_I2C0_SDA_MIPI_DSI1_I2C0_SDA	0xc6000020
+			IMX8QM_MIPI_DSI1_GPIO0_01_LSIO_GPIO1_IO23	0x00000020
 		>;
 	};
 
 	pinctrl_flexspi0: flexspi0grp {
 		fsl,pins = <
-			IMX8QM_QSPI0A_DATA0_LSIO_QSPI0A_DATA0     0x06000021
-			IMX8QM_QSPI0A_DATA1_LSIO_QSPI0A_DATA1     0x06000021
-			IMX8QM_QSPI0A_DATA2_LSIO_QSPI0A_DATA2     0x06000021
-			IMX8QM_QSPI0A_DATA3_LSIO_QSPI0A_DATA3     0x06000021
-			IMX8QM_QSPI0A_DQS_LSIO_QSPI0A_DQS         0x06000021
-			IMX8QM_QSPI0A_SS0_B_LSIO_QSPI0A_SS0_B     0x06000021
-			IMX8QM_QSPI0A_SS1_B_LSIO_QSPI0A_SS1_B     0x06000021
-			IMX8QM_QSPI0A_SCLK_LSIO_QSPI0A_SCLK       0x06000021
-			IMX8QM_QSPI0B_SCLK_LSIO_QSPI0B_SCLK       0x06000021
-			IMX8QM_QSPI0B_DATA0_LSIO_QSPI0B_DATA0     0x06000021
-			IMX8QM_QSPI0B_DATA1_LSIO_QSPI0B_DATA1     0x06000021
-			IMX8QM_QSPI0B_DATA2_LSIO_QSPI0B_DATA2     0x06000021
-			IMX8QM_QSPI0B_DATA3_LSIO_QSPI0B_DATA3     0x06000021
-			IMX8QM_QSPI0B_DQS_LSIO_QSPI0B_DQS         0x06000021
-			IMX8QM_QSPI0B_SS0_B_LSIO_QSPI0B_SS0_B     0x06000021
-			IMX8QM_QSPI0B_SS1_B_LSIO_QSPI0B_SS1_B     0x06000021
+			IMX8QM_QSPI0A_DATA0_LSIO_QSPI0A_DATA0		0x06000021
+			IMX8QM_QSPI0A_DATA1_LSIO_QSPI0A_DATA1		0x06000021
+			IMX8QM_QSPI0A_DATA2_LSIO_QSPI0A_DATA2		0x06000021
+			IMX8QM_QSPI0A_DATA3_LSIO_QSPI0A_DATA3		0x06000021
+			IMX8QM_QSPI0A_DQS_LSIO_QSPI0A_DQS		0x06000021
+			IMX8QM_QSPI0A_SS0_B_LSIO_QSPI0A_SS0_B		0x06000021
+			IMX8QM_QSPI0A_SS1_B_LSIO_QSPI0A_SS1_B		0x06000021
+			IMX8QM_QSPI0A_SCLK_LSIO_QSPI0A_SCLK		0x06000021
+			IMX8QM_QSPI0B_SCLK_LSIO_QSPI0B_SCLK		0x06000021
+			IMX8QM_QSPI0B_DATA0_LSIO_QSPI0B_DATA0		0x06000021
+			IMX8QM_QSPI0B_DATA1_LSIO_QSPI0B_DATA1		0x06000021
+			IMX8QM_QSPI0B_DATA2_LSIO_QSPI0B_DATA2		0x06000021
+			IMX8QM_QSPI0B_DATA3_LSIO_QSPI0B_DATA3		0x06000021
+			IMX8QM_QSPI0B_DQS_LSIO_QSPI0B_DQS		0x06000021
+			IMX8QM_QSPI0B_SS0_B_LSIO_QSPI0B_SS0_B		0x06000021
+			IMX8QM_QSPI0B_SS1_B_LSIO_QSPI0B_SS1_B		0x06000021
 		>;
 	};
 

-- 
2.34.1


