Return-Path: <linux-kernel+bounces-874654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DF9C16CB9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 21:34:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC3071C2527C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 20:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA3A350D71;
	Tue, 28 Oct 2025 20:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="b8VkYXok"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010053.outbound.protection.outlook.com [52.101.84.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E142350D52;
	Tue, 28 Oct 2025 20:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761683477; cv=fail; b=b8czd9MwF9IziXm3GEYdXKVQkJJZUaaRpdYsy8hTdgYkPLaF1CECh/oPGP0RkZq0CUKuggCypLOAopUZ3mX2fhFrN9TQm2fq97S8NUn/bZ/T4kxzaqC3MxXtD0MX4CuYHqe/AABW/OkOQBYCxCiONtwEPMbOAKwweTCWBraXIEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761683477; c=relaxed/simple;
	bh=g4MPJbvSX1jChSo3Yiyd+oaLAioixg6pl+n9neF1Sjw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=YWbqdZ5O87yTYYHrts3K7mHSY7ABgKw4hrPtmpmF1vZJo3Je1uVKeOxzP8U8Q08EOgdfPC92r8ZObs5XnPD0e/prtLBpfwWf2efm9W6MYn+PH1qIR1pfJhorEBMkLvrFRI6wxCeQ9FoqOtTAVlJALsKXcnzSwujjP7OQuAGbS8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=b8VkYXok; arc=fail smtp.client-ip=52.101.84.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vqDvM6dEqra2HW0qrqfmlLN4K2YnnUbzguUFrexIJ4WNBShNbdlPesv/Hx1ljj9aEiIlfG8chzodS7jeuY/EF22c2bndxaNiWtmAuGHLcHAmABtaBV8/ufp+lFnsB7YsOWyeEwSMQry04huOJaKcczbpbMpXY/typy2g1yjN6K0y6EGuRVC5wocMlmZHGQZ3eVrrZSifkWC/q37ZkyX1kB72p2g0X7UgxfsefWSd30iQnJhVFw+QdHtRruzQcbm+TaEgq/2BBbq2Z01o9i7LtdQcFRXQYBKkChMxWcLwbH9pTp4ZDX4PheMwhfXwYyu9r1aYw/nf16RhJhSNWFxYpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CPIuogbu9LGJwA5CQVtK0vOcOD6pesKk954GIHGKSIQ=;
 b=eGgCpPszUCOnDOYleNb/SZ32GKPrgfPxaPxL9mhd9YXapSg02m1Cngi3O7NJZbpwQvqktCq5+tnNKEL+VMC09jXVzm0krJ+VgMclEgAznO6iupkDtiNxEmrXt8zppYW/grwANmA8CCJy9DRPonmle2OHdClOW2E1w7YzFQ5fHSk6pi5D6CJrg0ninyBYddvFtv5FvIpHdKVeIQmBGFESweyBOB6vMWjTnB6RDFbXnWIFTiI1CXI3iLDRVIGtuyrmA3moTFc6Jj2AWleb2HMLL6C5g4ktzmaAwvgjbg0qRR3QctuSXDKQnO+e1sPPsinQVFtT4iNCwaV/MES6ROuHiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CPIuogbu9LGJwA5CQVtK0vOcOD6pesKk954GIHGKSIQ=;
 b=b8VkYXokvTw/yOSp4dnA52WRpmFiwLwl8xm33VcWxhZ9aJeKcPv23AoN807CcNGv8TBwbf8Jh742w6N29x/PWYl+4YKFZ8uWJEunEMsY0+ELmnHfrVPEZNiYnEoUSCIinCxvYkaRlJvopsO1CeqMkt5pQIfmXxnjAwy0zEvTw/UrFV2m5K1gQRp3K5URwrPHvm93j50xZt8gnS2wfrTCJHEyQCtbKCbMDoJgQe0CEieVi4FtO8wv3H1J+ZLRnEmVTcVUppyx7pP9qGe3DMuLzqrq8ah9HU8Vbk4FbTG7D6YkWoSzNmQd4jt17rcFsq9u+fJs6/YulVPfSCS0ji9eWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AS8PR04MB8820.eurprd04.prod.outlook.com (2603:10a6:20b:42f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 20:31:13 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9275.011; Tue, 28 Oct 2025
 20:31:13 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 28 Oct 2025 16:30:47 -0400
Subject: [PATCH 6/8] arm64: dts: imx8qm-mek: add usbotg1 and related nodes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-b4_qm_dts-v1-6-51ba94389c1f@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761683454; l=1692;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=g4MPJbvSX1jChSo3Yiyd+oaLAioixg6pl+n9neF1Sjw=;
 b=NZyQxAOdw/uW5FhWwBjMJMKQAAqyh8f+C6Xh2k+Q5Q44gNdpP30dKUC+siqlwjtIzZ/1di3HN
 YhFc4P68excBmC/8T46JSXKSUichBzMa/JlhQyMC79ZhORI1jvl0ws1
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
X-MS-Office365-Filtering-Correlation-Id: 80ec7333-a0e9-42e2-b6f7-08de1660f018
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N2M1eHVNZEVtMndyL2ZFNXMxNWEyWTQ1SS9EODUxK3haN2plNVVZalJtSVFY?=
 =?utf-8?B?YWNNdDZaY0dQa3VyRGpnZDJEVWFxem53WDZSL21yRU5ZRFNJQ0p0YVcxQnZP?=
 =?utf-8?B?TE5uYmU4R0Nwd1Nwa1NKZTlDWWlLZzBrQ1I3Y1hWaEN6Skl0TnVCRG0zRnNs?=
 =?utf-8?B?cVdXSk1lWU9WVUNVSFJ1cjdKVkpmZGJBOXB4TFBsQzZzU01PTllCSWJhNlFa?=
 =?utf-8?B?RDFWeUl0Q2xCeUsrOUZaTXdicVpYMFNZWFMvQVE1eit6V3ZjZ2c2Mm1qWVdv?=
 =?utf-8?B?TE1nWTRscEZ1SVlOcXNEQ3ZQZDVMY0hsaUs4K0YvVE0rQ05ENUxIRDA4Uk5V?=
 =?utf-8?B?S1hJUVZSajcwcDFHdHc3eTVWR2xxdkc3RlhGOVMveHVKeWFmTlp6RTdYMjNz?=
 =?utf-8?B?QTd4ZmkyTzI1SzRHVVRGb2tiOUdmMCtPVk5Zb043d2VZNmRLc284YUNkdk5F?=
 =?utf-8?B?NEhMRDRxbHB4SEh6V1RpejIzZlNzNXlQM2N6MFNSWUpNeGIwMVFJSEJrWXBh?=
 =?utf-8?B?YUVETGlncUNUVEZBUUJtMEFQNWp2eWFmczB1V1NxVzlScTFXbW5ya0tyczBy?=
 =?utf-8?B?Z3B6RlZoYWJRekxJSXZFc0lpUmhJTFpDTG94WXpNdElDeWdmeENORW1QWXZo?=
 =?utf-8?B?ZkEwUmFBendUclRRZ2hTRi9MaTg4QjhndE1valkrTGJKZUphc3ZJQkl3SnRV?=
 =?utf-8?B?dG5qZkttVjNvcUxzT2dEeXpKc291aTF3OHBkWHVVS1ZHOXFMaWIyYTV6Q2ls?=
 =?utf-8?B?U3BNT3ZucENURldSbVZCdzZyMjA0N1NsNkRuTFRWNDVmK014VlRublhaUWw5?=
 =?utf-8?B?UGY0eTlKZTcvbGtiZjZPZjhvRUszand3MkNOamJMZHc0NFc2NkJVUHhFU01j?=
 =?utf-8?B?K2RjM3dBWlZpeWF3OG1jWXNVeDJYVGdmbHpvcnBhalBPd3dQMzYrSFAwRjNp?=
 =?utf-8?B?cUo5MUE3YmFjaGFRK0dadzZGdUthR3ZISjVVaFlndFFnWTVOMG5PTmNNMDNt?=
 =?utf-8?B?YnZRYkVkZmtmY2duWllseXdDNWtRaW1oRWpRMjhtUDJJeGU0RnM5VS85SWFy?=
 =?utf-8?B?dURmRzZNMXFwc1ZBUmtoQWVWKzRtVnZTZmszSS85a0Nodm5KVlpVZTROUXVU?=
 =?utf-8?B?WStNdTNYcGVaNllYRCttV2lLZzBDQU9KS3FVUFVhV09KMjlkeHFiT0tFajJx?=
 =?utf-8?B?ODRHM05rcmxZWWdhUWY2M1dneGRuUHovaVV6RSsvS0xyQ1phRjQ1RmRYRHJG?=
 =?utf-8?B?TncyOFR1c3BkSzA4T3Y0Wm9nckJJdDI3aHI5Q3ArQlN2cUdTQzc4RVJNVHcz?=
 =?utf-8?B?a2RWUThCc1pIMlFQd3UwN3NlQmEyQkR4VXdDMExTTTEzUnBycms2OUo4b005?=
 =?utf-8?B?eDZkRUVwWGg2V0hUYUNhMmFFQWZzMnNOMFNlNDV4SGFEZmdYWmoxSk9LOERi?=
 =?utf-8?B?RzBqUDFrUXJpR3lNbkZ1K29rS0RNTmZYMmJCTFdqWmdMYW5IZ2cvVzF0bktD?=
 =?utf-8?B?a0IyczZZYyttekdwd0dLbGpFTHFUTEtxZ2xYMlh6aW5nOWdoQWZBOEpseTdU?=
 =?utf-8?B?SVRrdHg2RzFibXdZSUNZT2FkOTNWWHVWZmdVTnlHS1ZQZVdPMHV0V28yNkZH?=
 =?utf-8?B?M3g5L2crNVJJS2wvQmFqNzBBQXRUL1lpdUxzOGxPZlZab1hNcEdaR21ONFhF?=
 =?utf-8?B?UlpHSHhwQ2dQTFFwV2ZYVnBCTFVlaVNmMDB4dys4eFZkR3NKRXpoZm45VGpK?=
 =?utf-8?B?MXpPNXEvbHZSN252WDBlSWdJWjMzZ1g1RHZsR1Bza09ndVJDb1JBbzNEZUlG?=
 =?utf-8?B?VWh1a2lQYWg0RXJtejdheTFQL2p2d1dkcnpkOERGUjk3VytEcGl1bmR1eWN0?=
 =?utf-8?B?YjFrSWtQcDRGTFhlLzVidnVLSFFZS2ZVeGc3SEpMQWRoYVZqRHJsRmlGcFlj?=
 =?utf-8?B?dHZPZEF1NmU5bUlzMVIvVzBNWVdxcnhFZFRPSmdiZi9acjVQV09DbDkyOXB2?=
 =?utf-8?B?dXNjMSs4ZUVEODUyTVZYazRpdWswckp1ajhuZ3FEbjdiMWIwTVpFemFZZThQ?=
 =?utf-8?Q?BTyyF9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UVNzUEVHeHNRZXJHcGcvTXhEbGNGYVF0Rm9TUmtiT2FQRWpLcFFIYUQ5WG1T?=
 =?utf-8?B?UDJ5R0NLa0ZSVkh4RzhxZzBONHR3aXBXbVV4SkRmTUpvYWplMG54RTk0Mitv?=
 =?utf-8?B?NHVha2ZnNWJZUzE4VGU0UDF0VENVWE1PK1cxazg2WVZ1MmV3T0ZiRGo4TXpZ?=
 =?utf-8?B?dGFEMEt2ci9EWXhaRHJwR3hMQTJjQzk4LzZuOVpCRndZd0REQmJLa1BTbi9o?=
 =?utf-8?B?N1oxTjNucE1RSy9wM2Q1bmlkYWhRanFnSGRqNVdCSDFhNG5Ja21LS052WkF5?=
 =?utf-8?B?b3l1RTJ1QkxtY3NYalhUV3ZGUUN4bVpidDhVeFNITmhGYmVuTjRGcnpjQkhC?=
 =?utf-8?B?emFWMVVuQTE1bjJxWEtQdGkvUG9iLzRnRm5KN1JqQ0tIbHpuaFRTSHBIM0x5?=
 =?utf-8?B?NXYvLzRBRWlQN3RWbWllclViZ3ZxRVNPQkRRUkZ2ZEU4elJLT21FaGQ3aTU2?=
 =?utf-8?B?MGpvT1h2N3dySnVLRG90cmFFaEg0OGllWUEzZ3ZiM280VlRudkpFVGtVUXI2?=
 =?utf-8?B?UmIxWlFnakdvcTRoS2pYM2hLNDhtdXcra1l0ZGNWVElCTzZJM29CWTVyTTlV?=
 =?utf-8?B?T05DS0lVeGtBZzk0UmJPbjlaOHRCUXpMdGN3dEpKTFZ3L2w4WXFwc010aWRx?=
 =?utf-8?B?aWZlelNaUExGL3dNU1NYVGIveGdUaTcrNHZWY0ZIV1NvZ25Sb2NwNjYvbFVh?=
 =?utf-8?B?Y0tKUWRCWjYyendEVGZhMFk4SUxwWmxhUi92ZjRyM3dwdTllMnpxeEVLWUF5?=
 =?utf-8?B?WlFWQnZpc1RRWUllSVJzT2FMWXlCenZyQW9hNURlcVQySEp2dFVvQmVzTWhm?=
 =?utf-8?B?ZDZ3WEIwK3pqYWVaWXhyUW0xeUErOVEyUy9tS2RiQTZRTHBKSzRYNU1Ld1lM?=
 =?utf-8?B?QnEvdmNhYkFSeU9Xa0NZNFdWd0NtREsxeHJTTkdtZ0NBeDFVK3NUNGdrM1NZ?=
 =?utf-8?B?ckg4U1VZTnRWaVRLR3hqQ2Y4MGZrcDhlcjJsYU45My9XN1NlSStSelA0RE5O?=
 =?utf-8?B?dUwwQTRYRyszNVlxR0hSeUszSVZoZDVDNWQreWVyclJiaG43ZGoxZGJXYzZl?=
 =?utf-8?B?MmxUOHRCRjhvdnRKYUVOaDdYMElhdzVkd3pqOVRsNnVGd0dOYThZVDU1Tk0x?=
 =?utf-8?B?dncwa01Hb09PUGdkaklvbG5vdVBoYW9laVI2UEx4R1M5cGxsa3h6d2NGNlhR?=
 =?utf-8?B?Z1RIZldiUnc3YlQwUUFvWWhpQ09PMWR1VXdWRWtDVXdLem9uYklwQXRjTFVn?=
 =?utf-8?B?R2tiRFhpb1BybEVtdFVHWVdXeE1tWDJJODZQLzBoMy9JZ0Jienp4cjB2UVZC?=
 =?utf-8?B?bnpScEVzWEsrK1o0QWs5S1B3bzc1ZUpDeWVIeWlkN3l1Rnh2NTl5YVRacWsy?=
 =?utf-8?B?eTZLYzIrSUk3b041YkM2RlFLSnNrMUxOTUkraStScGFXVU5yRjR3RTBWWi9L?=
 =?utf-8?B?WW0vMS9nUEp4anRPK2p6K3lyRjI0M1pjdjFYRXBvL1h1RllNS3JFOHdFajVo?=
 =?utf-8?B?ZWJPZGhUL1JoZG1tbGZqUTV5ZThRajJBeHIzUkovbEVaVXZDQlB0QXlMZEhj?=
 =?utf-8?B?ci9aZmFieHVEZ0dyZFFFVE00UTdlbVBlaXA0cktManFTT1NsSy9QOUUxYldI?=
 =?utf-8?B?dUY1TE5Fc0srdElDc0o1ektvbGZxN3dzUEw0OUllRXFqRGh1blZNMy9LN2h2?=
 =?utf-8?B?MndDMGpGTGlpdkVTQUhGWnlWaU4wR1B6NzdnN0tuNHJucVRxNThUOElTQ2xo?=
 =?utf-8?B?NnYyNys3THF3Y0d5T3ZBeFAwYUZYUHRmRnplZ2lqTko3REo2bE5pRjE5aGpK?=
 =?utf-8?B?dTNQL2NGOWJxaU02anhRb1F0YTd6QzgzRzFvY2I3Vi9hUW5VSzR5RUQvZXZS?=
 =?utf-8?B?WkpjTVd5aERlTUFhUWRPTkpiWGhUV2cybjl0SVA1OWpRZFYxbGlhdXFuY1Ji?=
 =?utf-8?B?UmN2cGorUGRobXN0UWtCZHkwcnFJZlFQWnh6Rk9rQ0pHZy80d0JDOVJUNE1R?=
 =?utf-8?B?MG81V213T29FaFF2OUN4TG50SEFKbXZtUE1zVnRsTy9Dck5JY1lxalpPa3ds?=
 =?utf-8?B?ZFhVbU8wd2xVMlpEYTlITlZYbW1MNElYck51MENGSGVJajBKUnh6YUJDdUtr?=
 =?utf-8?Q?2daI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80ec7333-a0e9-42e2-b6f7-08de1660f018
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 20:31:13.5310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NiKrn3Owla0OJ228S/1d5P+Hc/d6xBx64WerElUkwj/ivGtPyvS+oUCOh8n/pOuft7A221NyAhCLw2ZbEW1EhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8820

Add usbotg1 and related nodes.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 30 ++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
index 90daa3de24c6697554a75ab5176682ba8fbf5ada..578bbee5a861397b4f8528d4c7746630a40f2935 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -323,6 +323,15 @@ reg_pciea: regulator-pcie {
 		enable-active-high;
 	};
 
+	reg_usb_otg1_vbus: regulator-usbotg1-vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usb_otg1_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		gpio = <&lsio_gpio4 3 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
 	reg_vref_1v8: regulator-adc-vref {
 		compatible = "regulator-fixed";
 		regulator-name = "vref_1v8";
@@ -835,10 +844,25 @@ &usdhc2 {
 	status = "okay";
 };
 
+&usbphy1 {
+	status = "okay";
+};
+
 &usb3_phy {
 	status = "okay";
 };
 
+&usbotg1 {
+	vbus-supply = <&reg_usb_otg1_vbus>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usbotg1>;
+	srp-disable;
+	hnp-disable;
+	adp-disable;
+	disable-over-current;
+	status = "okay";
+};
+
 &usbotg3 {
 	status = "okay";
 };
@@ -1258,6 +1282,12 @@ IMX8QM_USB_SS3_TC3_LSIO_GPIO4_IO06		0x60
 		>;
 	};
 
+	pinctrl_usbotg1: usbotg1grp {
+		fsl,pins = <
+			IMX8QM_USB_SS3_TC0_LSIO_GPIO4_IO03		0x06000021
+		>;
+	};
+
 	pinctrl_usdhc1: usdhc1grp {
 		fsl,pins = <
 			IMX8QM_EMMC0_CLK_CONN_EMMC0_CLK				0x06000041

-- 
2.34.1


