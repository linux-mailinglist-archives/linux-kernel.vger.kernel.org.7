Return-Path: <linux-kernel+bounces-791200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D38D5B3B352
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 08:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C5D17AAB7D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 06:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FAB241114;
	Fri, 29 Aug 2025 06:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="vVkCVG4C"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022102.outbound.protection.outlook.com [52.101.66.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6637404E;
	Fri, 29 Aug 2025 06:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756448755; cv=fail; b=YheK4phxBx+UHs+SdECLo2srzoxPc3cCUT4n3SJAqGrmKoCzoe31I+eliv7fdcXMTmJBJrL+OJCmu+qk6DXztp7Skfcb/jjSeavuQjW6/97vXIw7pfLtRlB0DHjWalnIwCpnxT9d9yBoNBsxANcr/O8kaU952onXWxN/LE38ylU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756448755; c=relaxed/simple;
	bh=Oj2CunOMitoRt+JxqK0UMArcZmJ28xH4ozOEmWRJXyY=;
	h=Message-ID:Date:From:Subject:To:CC:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PMMoIbK083XLtx11x1FuRl/rF9fsNEKkRDTDpCrKT6qLb4BoVnvjZSLmvPmOB9OFcyIQ3vCb7hrXKTwQcHlCktZgr8CVF/+umOuFDfcocJzCaZwrQyDJO2EgZSZmSUU76Tl4O178Bq2D9Qq3LEclg0u9rD0Hnsb+EZh6HjdFxqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=topic.nl; spf=pass smtp.mailfrom=topic.nl; dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=vVkCVG4C; arc=fail smtp.client-ip=52.101.66.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=topic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=topic.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JHt5gbGThLxm8PL/AP5kP5YC2RYQzV1VECE4OlGwxPZfPvqCpAgUuHkXRR/jRz97CEPlGc1PXxYfsPfCVZ+kTIZmkLCXi+8QxWNSoaB7exA0b9AzRnb2NiRBYihTi3EmG7ilhZr/lcVtGHzQH4J5c/qXRQvBe0kFSCxIK2maFhGritvwRkqUWbYrYySedd/HYTwPB0URUHXs6ygWu93lnau3LklMkvGjsLHEypb21HQCxwU8ajvY7I2ARC2TJhG8G+uuV2zdgJ89ZXOmNKCxg68cLVb2rNNmjN3uzzYcKdUAqFO44IXRjbjXimSG7nHcyDGdQwLWqJxEHkKTmJa8Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oj2CunOMitoRt+JxqK0UMArcZmJ28xH4ozOEmWRJXyY=;
 b=Mi/Z3lesgc37FnRjgzg9JASmSJwivXVAatlccxwpu0fJOl6ShFPI2F5hwEC9wTnIQaDoA9ZyFAuWXL8szcOnLcPfZxsqID/qWGTGxehR5hcwDJR+9zWJa16BHxTxI1lIiTu+lrVtdnEj/uVZRO6LGPYe6Ij2NEM7lH6o5IA9+OySlS6pe3LSXZVruQKYZzDFHCsdy4S+HLm+U9RNZcLSSDy+qLNqHUuOmEExIxH1klxElyFRIxLtpCdtFXJsSXwvAXcZ8SzlKBmi4KQWBmKXa8PrpypNNcz70n2yKubElzIOa5uwrerI4sYClfO+wj6UyxLVW3ybDDn6gslGDF3+wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=amd.com smtp.mailfrom=topic.nl; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=topic.nl;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oj2CunOMitoRt+JxqK0UMArcZmJ28xH4ozOEmWRJXyY=;
 b=vVkCVG4CXtsn4EN0jHeLE0uiYw+G81bsHCQohG5Q5JSYCZu6tleRIQ4glstz/QKTXHPaWv1DhOMhC88UZUWb1ZLZIbPOAFVMhIfMeBiLOqDwL7LM+qn8evq1B/PITMwrntOJgT6w6N5f+rrEoXuJ2cm3A2cvjnmTewVD8W+Uws3auETAlISYLMVUnNWj2eKTFO+7PIqzawfaYBrflTSAxtbJjmGKCUc+KGcHlduEFCkiF0Fp09VzxP2Mp+BxKjzZBBg/FwRTcaKoFh/gd4mdUpVc9KsKymoli6+Z4kunTx9O0ZJlhhR2bv2l2HfCKVF2ApjSVPr4AipgKFRtYKdgTQ==
Received: from DB9PR05CA0028.eurprd05.prod.outlook.com (2603:10a6:10:1da::33)
 by AM9PR04MB7492.eurprd04.prod.outlook.com (2603:10a6:20b:282::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Fri, 29 Aug
 2025 06:25:48 +0000
Received: from DB1PEPF0003922F.eurprd03.prod.outlook.com
 (2603:10a6:10:1da:cafe::e6) by DB9PR05CA0028.outlook.office365.com
 (2603:10a6:10:1da::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.13 via Frontend Transport; Fri,
 29 Aug 2025 06:25:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.93.157.195)
 smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 20.93.157.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.93.157.195; helo=westeu11-emailsignatures-cloud.codetwo.com;
 pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 DB1PEPF0003922F.mail.protection.outlook.com (10.167.8.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.11 via Frontend Transport; Fri, 29 Aug 2025 06:25:47 +0000
Received: from DUZPR83CU001.outbound.protection.outlook.com (40.93.64.12) by westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Fri, 29 Aug 2025 06:25:46 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by VI0PR04MB10568.eurprd04.prod.outlook.com (2603:10a6:800:26c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.9; Fri, 29 Aug
 2025 06:25:42 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.9073.010; Fri, 29 Aug 2025
 06:25:41 +0000
Message-ID: <5ca5b18a-96bc-41da-8784-171116d75b50@topic.nl>
Date: Fri, 29 Aug 2025 08:25:40 +0200
User-Agent: Mozilla Thunderbird
From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH] arm64: dts: xilinx: Drop undocumented "always-on"
 properties
To: Michal Simek <michal.simek@amd.com>, "Rob Herring (Arm)"
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
CC: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250828213028.2266805-1-robh@kernel.org>
 <769c2a21-15c7-4c6d-84b7-cf1153106dfb@amd.com>
Content-Language: nl, en-US
Organization: TOPIC
In-Reply-To: <769c2a21-15c7-4c6d-84b7-cf1153106dfb@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AS4P191CA0009.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d5::16) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM8PR04MB7779:EE_|VI0PR04MB10568:EE_|DB1PEPF0003922F:EE_|AM9PR04MB7492:EE_
X-MS-Office365-Filtering-Correlation-Id: 791412df-4cea-4a7a-afc1-08dde6c4e47b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?ZXN0TWFJNDRKbjlSMkovelRhbXQyRkxqMDhjZDdieEhxd1EwYWNWYi9RZ0RM?=
 =?utf-8?B?SWtHLzJ0ZFRQa3pqdFhHZVZxT0lES0VLVUN1Kzk2OEh4Zm5VUG1GTGhJeHZ5?=
 =?utf-8?B?N0YzRXdxMWhCNkcxVGFXNkJlREluL1pYNzAvNjQ5K2tpcmtYeS9YYnJNYWFB?=
 =?utf-8?B?K2gyU2N0ejZOSFZrR3J0eEVvMnVrcnFwZGhWZXVrbmtGUVg0eUVpa1l1S2tn?=
 =?utf-8?B?QzBvWmR0SWQ4UVhSWWNZOGIzRStRdnRBRFE4R0lQTE8rS2Uzd3Roc3Z4RmJv?=
 =?utf-8?B?cDkranhFN051VDlHL3lKdUlwZFdsUUhZU0xrbUs4MUhqdFQrOXQ2UEZDQkpZ?=
 =?utf-8?B?QlNBbWtSZ2pLdTc3SUphTDJVU1N5a1ZZUEhPa1Z3WURIei9oSzVqeVE0MlBZ?=
 =?utf-8?B?UCsxVEcxem9BNXplemNXSUZCTUg5Zk5uSXlIODE5UG0xRUJSR2pXYk56UHJW?=
 =?utf-8?B?bmdnUUZadXJDam5oVkplNGd6SlgydU8vWUkwTzBWS1BGVi9Wc0xWcGN0WW82?=
 =?utf-8?B?dm52a0U5eE9NWEliY2N6VjN2UkZWcTJCeUNRcW42T1BTV05QRFhXdEJENm5x?=
 =?utf-8?B?R0Fxdkx5L3BxMHdjYkhVZExaVVpjeXFENkxaMjQwRWxndkRwQUlocVQxc2py?=
 =?utf-8?B?d1ZsY3piTWxPTjJhZDMrdERrSTF4cGhoZXp1RXhqZVBMWGRHT1Y5akFRODlQ?=
 =?utf-8?B?d0VDUmxPNDVPYUVSNlhuanM1RHlFRTBvOVQwTEZXc2x4aWdTMHFkZ040TDd2?=
 =?utf-8?B?ODIvQndES0lZbEwzd1hjMlpjbzRQTEtIZmVuOFRHbDN1aWZ3c3NCQnZFNis2?=
 =?utf-8?B?amk5a0IxR2N6QWgySGJEbGljb2RHeWpWcUFoM3VxeHE5Si9CSEdua04vNTN0?=
 =?utf-8?B?Q1FlVGt6K2hIdWtPNCtjWWtWN1JhQVVsOTRCR0xCMy9aZDNnWDNJRUp2ak9O?=
 =?utf-8?B?a1BQWmZOci91R1h2cTZyKzNFNVN2R2x5OFlHSEhYYlg0U25rYjNmb0hhd2h4?=
 =?utf-8?B?TG42OGJFT09kK3FnSFJZMWVra1h3b2JNbHNHa1NTUTVGRVM1VWVtb3FOemdu?=
 =?utf-8?B?N2JiQmZDWnd3c1hhWkVjNURDYzZDRisvK1Q4bzhWOHkvRWFxZWkrcHk3NmRI?=
 =?utf-8?B?TkozTzhsSzBOc1g0Z3o5TmEzN00wekFsNlpDeU1TYjZpUFo1SmszM0RyTWxj?=
 =?utf-8?B?a1R0c0ZHcDdzT0hhMXNHK251cGhPeHNNMDFpK2lXSVBFdURpaVNxWXFFem55?=
 =?utf-8?B?TXZGZkxtUE9DeWsySE11cy9vS1duMDZlaWlPcjRkS1FxcHpHM3BhQmFFOWdv?=
 =?utf-8?B?UWp0UUljZDZxek9udk84L2xPUDB6VHorbzRLSnY1bUxpOWt4cm9Nc2duK3RH?=
 =?utf-8?B?WTMwdFVUZTJtTit1MkJwUmpSQVUvdnhXdlU4SFo4M1NUeUJRbzFIMGRSdnAr?=
 =?utf-8?B?NzdmWElsNnlHTDQ1WkpjcjNsRXZOaEJrbzlvL0RWQURHSEo1bWh5bUJLVkVT?=
 =?utf-8?B?cTk4MDZOSzJuQ1paR01uWFRMTEF2Y2FpT2trM2d3N1lpQTU0a3RJMHVEcTR1?=
 =?utf-8?B?czIyd2RNUnN1WGxQcjRqY2o2Zk01cW1UR2ZudEsrMy9YU25LUG5BTWxHMEo1?=
 =?utf-8?B?TW1RN0VrZmxrSmFLOUhmamlaVXRMbVRuMVFyK3RONEtFbHJtZ3dEODNlMG9I?=
 =?utf-8?B?V0NsbjJnQ3ZHOVdYdUlLOVRMeGpaaUdMbEYvWFRSazIzZHIvQ08vWDRxbVJn?=
 =?utf-8?B?WXJaK214bC83SHl5b3NDdGhmWnRmNURRdTRsWk56WDF0UDYvU2RldFNySmNx?=
 =?utf-8?B?NC9QSDZOUlhtK2FzRWk5emtoZDV3OWVIZnRMSmdIYmhrQU5OWXFYUERSS0Nr?=
 =?utf-8?B?YzlPZzV0b2wrN0VSK3JPanU3UUNEQWxhbmJwVXE1bG1sT0FQMHZ6c05zbWRC?=
 =?utf-8?Q?HI50w1px4eA=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10568
X-CodeTwo-MessageID: f1e5bb02-9b43-45c1-acf2-4c83a64b841a.20250829062546@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF0003922F.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	8c6d9810-5111-40cd-af15-08dde6c4e0a2
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|14060799003|36860700013|35042699022|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VlBtcGVqRmNiRWhIdlNCbXNDU3hSU1J4MFJEcjgzWDUwcUF1a3E3L1J1ZW92?=
 =?utf-8?B?NmpkQnlycDVSRWJ5cFdsM0lCTCtSTlhWQURaWi9hM0c5MzdETlcrWWJjNUVU?=
 =?utf-8?B?TG5Qb0I3aEZma0JybmhnSkE2UkxLY1dtck1GUURvUGxYeGptd2VuNlV1OG0z?=
 =?utf-8?B?Mmx2TS9wZGRpTzlTTnJ1N1pjamZkUk9ReTVZVE9naFRzT01lTURKNjEzUGRX?=
 =?utf-8?B?Vi9RL0ZLcGVCdDV5N2pOc3dva3QxZ1I5bFFKbk4yWE84UUJ2T0tmY24xYzA3?=
 =?utf-8?B?SVZ3dEZ1L2s5MUhjODNUZ1F3VGpBUjlydUV5Q1UyU3pKbDA4bURBV3ZrNUR2?=
 =?utf-8?B?U0hHTDIxYzl0STdQTzJJSnNWY2ZuaVZHTDRveHlEOE5NalBpSU5WODVqRE5y?=
 =?utf-8?B?T1dvaWh6cEZsZG1VMWVTcmVsRThiSmRnMEJGMDl6VEM1MDY0a3VlbjRYQkY4?=
 =?utf-8?B?K2dwa0pDYko0NXhrTHhSM2UwdEF1QVltZnhoZXowOCtmNkJKVFlocVloZmkz?=
 =?utf-8?B?VU42Q1lyMk5qbmRoYkNValdwWEdTSUpVK3FOZmxObm5TS3Vkd2JvR2pnTmpQ?=
 =?utf-8?B?VHhsQ09ZMXhSOVpmZkpkYzVWOWJveW5McWd5QmxKSjltOFczS01ESzh1c3B3?=
 =?utf-8?B?L0pEYU9uYm1kSWQ4RmZNd2xra3JkYUZKSnk3ZFhSMnlkVzhIQ0NiUkNvUmQ4?=
 =?utf-8?B?ZmVQdGNoV2xSUGZxNU1iOVZtcnlpejZ2RjhoWU9PeDhhZ21aTnZBaWlVS1h1?=
 =?utf-8?B?azRreHhHQ0UzZVZKMXlSaExGOWhRb2hBYWJLK2RUVEh1NXY4aEZHeGR1dEVL?=
 =?utf-8?B?TmhCVE1nb1NyaFpvUElYWkMvV0NjbFN4L0RzT0JaRmhjUkZJVmpYR3B0dGFv?=
 =?utf-8?B?aFpWKzFZOW1CT0t0c0Qzb1ZuWS85bmlzTVVEaEpRd1hDbmhmc3NIa1VDRm1O?=
 =?utf-8?B?K0R5VU94R0xEUWEvODhLcytkMXNnMjd1YUNZOU5qZEN0VEtJaU9oZTZ5QWtZ?=
 =?utf-8?B?cVlxblRLRXVBNkVIK05zQzVoS1hYV0cvQ1JzMVltaDZKTlRFRFZ3Y003YXpV?=
 =?utf-8?B?L2o1YkRnTW5FTGRMei9xUVJmS25PMlpJVDRQQno5dHBDUitxaGczMjBrbEZY?=
 =?utf-8?B?V3FqWDlVd21LVkRVN2d1RXR3TXhjNlRlMWdONXNJbjhmMTZHc0dtcFVRTUlR?=
 =?utf-8?B?Z3hUNnQzWnoza1FGVFFWb1BUd1BJRG1veENZYkZRaS9PR0RqSW5CZ0RheGp5?=
 =?utf-8?B?Q0NLeVlrcTdBYkhrdFJaTFBEVzBybjZ1UVIrV0YyTnp5bjVTSy90MFFyRXFJ?=
 =?utf-8?B?cEdCR1dPNFB3ak44L0dHNXMxUklCVEhucXM0UFNmQW5jbWlKdWRWUUtPclNt?=
 =?utf-8?B?bXVSODExbXF4RXdneEF0S0luR0kreFh5RjBqWjd6WVErTDlHQ1FBK0RxMXpt?=
 =?utf-8?B?VFpZRUNuRENkTzdtd1FTaEhxOU1CS0UyOFV3RXlJQVFBTnViQ1FWYUsrRVhu?=
 =?utf-8?B?ZG1LVGN5bS81MGJNc0FOZTFJZTZHTERxYk1ISmFDeEt5dEJiNWx0dzQ5ckNV?=
 =?utf-8?B?N3J2aHVNbWFRTDVUWjg5dmNaT2xsVzVFT01HakV3SkQ1T2tVOGhhakg0d2s5?=
 =?utf-8?B?VmVBYjNtcEdWYndWUzNZelh6bENVSytPQ2F6QUNrcDhRWGhHeUlER2pWM3hp?=
 =?utf-8?B?VC9rZHpZWWFuN2JBTHMwQVRBNUl0TzRMaW5iSlF1ZUorazR0UE5UZjhqZzky?=
 =?utf-8?B?NmdOd1JNV2V6N1F1Q1l0c1ZJdDdVeTJpQzZXLzdZbXlWdjA4ZXRuYUdBNTR3?=
 =?utf-8?B?amFvaytuanV1bUxEY09JZFh6VTRGSU1rSWt3YVpPTjc1djRNNFNJamMxZjlH?=
 =?utf-8?B?SklWeEpRcHB4QU9tRCtXMVp2M1Mra1VsdmtuVkFjMXE5aVp6L04wbytZd0w3?=
 =?utf-8?B?UHY2ZVRXM1VDT1ZvRjFnTWd0OGdaTlRUS3dSYWl4NnBBWnFlNlNZMmIzZTBi?=
 =?utf-8?B?dlp2Y1I5ckQwMmxYNDhJTjNWWjE5a1RzbjNEbGloV3A2a3dkRVhaQzI5Ynhr?=
 =?utf-8?Q?67nn+b?=
X-Forefront-Antispam-Report:
	CIP:20.93.157.195;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu11-emailsignatures-cloud.codetwo.com;PTR:westeu11-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(376014)(14060799003)(36860700013)(35042699022)(1800799024)(82310400026);DIR:OUT;SFP:1102;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 06:25:47.6249
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 791412df-4cea-4a7a-afc1-08dde6c4e47b
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[20.93.157.195];Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF0003922F.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7492

On 29-08-2025 07:46, Michal Simek wrote:
> Hi,
>
> On 8/28/25 23:30, Rob Herring (Arm) wrote:
>> The "always-on" properties are not documented for "silabs,si5341"
>> binding nor used by the Linux driver, so drop them.
>
> Binding
> Documentation/devicetree/bindings/clock/silabs,si5341.txt
> doesn't contain it
> but driver drivers/clk/clk-si5341.c is reading it.
>
> 1345=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 config[num].always_on =3D
> 1346=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 of_property_read_bool(child, "always-on");
>
> It is there from 2019 when driver has been added.
>
> If it is not standard clock property it should be moved to standard one.

Agree - either "always-on" should become a standard property, or it should =
be=20
removed from the driver.

As a standard property, akin to "regulator-always-on", maybe it should=20
probably be renamed to "clock-always-on"?

I'd be happy to provide a patch either way.


> And DT binding should be converted to yaml with all properties used today=
.
>
> Thanks,
> Michal
>
>
Mike.





