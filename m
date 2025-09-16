Return-Path: <linux-kernel+bounces-819155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A43B59C39
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 17:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6E8A3220D6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 15:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B6D35691E;
	Tue, 16 Sep 2025 15:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="d5njewlx";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="d5njewlx"
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013019.outbound.protection.outlook.com [52.101.83.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72098237172
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 15:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.19
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758036994; cv=fail; b=osyvKVo+cYP53FcJt5nSMKHopxCv0ynxKeQyl4Yd8wN8m2OD+/IcwS+2qThGq2Jlz1jyEHj6g6AZYe+wpMIBMcDHTiGM8mkceTcGinsM9wqF4DIDui6NiYe5wmsBZZtu6QGZDe7t34pRv16M9hUtUsDfyItVQg5JWC70SV/sIUM=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758036994; c=relaxed/simple;
	bh=5cYMj3ZvTbqLa/uZlB1CswJw0ZeHM4zgO9EnDltU6Sk=;
	h=From:To:CC:Subject:Date:Message-ID:References:Content-Type:
	 MIME-Version; b=p61g4nwhmivUZLH8nttKtIT4GP9I9Mt0LdZc7SbbiJVxjqrC7M1BEoOzDNb7APWnsSzSfG6ELLNpMLCqoxK+5rHqR0/xuhfVpF74K50X3/N9jL9OsKBoDIUEM9dQaT2u4jTltZa+2kPz0oIqHMaZT9MMs3QT6wGTcnLuTr0bZk0=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=d5njewlx; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=d5njewlx; arc=fail smtp.client-ip=52.101.83.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=rEYZ8S0jPNgl2BSpktfATFooSUJ6NwnqClJV2GNcRMmQ8+IMAsShGopJb4zeX3lgebHQTMyMFOhdATL67kSbTZFfNtewFrcQZ0wUi0hqE8K0la3ldq1vCt7sSs+NEcb0o9UUhl/kBzMd5yEemJTLDY/Zk+hW69h7fPw1oA76e4j8KLVfVZ90L3ZtvnMZsl4WQoGlM+pK1P+HXrgK8Ao/bA6K4MHR16XEl1kkIawBPezmjScfxK8XGSrmJ577ggbBf+0CJ8gU9/KSI2j2xnlPucGS0KaLUgok9DJkeGhhxI70hMzCs5qo6kDGC6TcT47/M+fccQlCW+lWRi2YFGgK1A==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5cYMj3ZvTbqLa/uZlB1CswJw0ZeHM4zgO9EnDltU6Sk=;
 b=CAJlMnniF9KxhwCwYIeYNYbYfODlugeSBXa+GWBKZs4nkNx8J8By4psFfrXcfFaOCRdrz7VyEOQC2NldUgVHsuF1qFi3Ue61x9hX2u8FgbNNPjrfxS4ndMyNShTPMUPL0y1WJdkEQxIBT7oswcjuEYffznDnRPM1YZlcezjXyS46oY1pkUYLqbgGIJNcQZUeXO1Lcid1CXBLJjtgYSA0swGDl2PK5VoVI2pSRAvLSnJN8UGg7yKSH0ZSCuM35X9sLPgqshfmI81iNcNq6zDS1aYH/bLjqxM4NCiQVVxFeiwtZvx0rGrXEdnxee5LINQxmHP+t1k+GkHWrzumhUw4rg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5cYMj3ZvTbqLa/uZlB1CswJw0ZeHM4zgO9EnDltU6Sk=;
 b=d5njewlxo560qhConni0clzJlZyXeG5x8ffZZ7RQz34pJ5D2PAyE0TS2KrNA97QzPUn1Vc5hjsAjM9uNHeT4DgF7yDcI7rfroyM242AXnr3NqN8T0mvh7L9JNohVu6hjfsE81qMXxnGQrYJK7GM5rdQHWeVwFOTCMAB+8n37WYU=
Received: from PA7P264CA0176.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:36f::13)
 by AS2PR08MB9834.eurprd08.prod.outlook.com (2603:10a6:20b:605::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Tue, 16 Sep
 2025 15:36:24 +0000
Received: from AMS1EPF00000046.eurprd04.prod.outlook.com
 (2603:10a6:102:36f:cafe::31) by PA7P264CA0176.outlook.office365.com
 (2603:10a6:102:36f::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.12 via Frontend Transport; Tue,
 16 Sep 2025 15:36:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS1EPF00000046.mail.protection.outlook.com (10.167.16.43) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.12
 via Frontend Transport; Tue, 16 Sep 2025 15:36:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YlgdBTO9ue9VeAdS6Z+pFJY5G/K6OJacIIatPjuKBvziA9PLbQxQulAVw1m2muQefHAu+uth8D9xMECOZjPPj8rUKz+8Ax1sppRzNdasJ5AUzJ7DfS7EbOtEwAaaNK4GgI0bcaDRMhUN//6DabwZM4zu5U3yJYWakLz9f9XFElgEkZO26ukmWy61O2eFHMtNIUV1fV+QBovUcs2/PyhLonrYYIjJuGwX5G8X1HZU55RsOZOaw+o8NWiApQjEdLHCZfxCZuQJymXoFoaSvHdDVoELoCmTQCpu0sRfKM7V8GEIzmv8CkbOtZwLmGKHWzBZ3vJUSpYkR73RcySsLcKlQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5cYMj3ZvTbqLa/uZlB1CswJw0ZeHM4zgO9EnDltU6Sk=;
 b=vWfjP0HGK35V1K0OzDQfieojAx0K2vS7u+N+LaUa5SsZNt+kMBYWNTWVGlbS/l7rEWFwd6Bksch8e3hhRAwvVhh/Jn1sAcnFPz5fGcToJ1gJ4cI+KdN7TTlhbp5+E1mLDKwBKnH2J4SD5lFni3va7o6xoqOU72ELueqb+FHk2RiIMsnot2wuT8OjDGKebjOVEFvxkgwvX3LbRxjByAe1QwqpAsqVnSScSWgQBxUfZB4G5ViytMQFItzT0du1cOThiHySczW89uWjBz0IBfw3VbEEnXe93EXsAlH9zA7lRv/Q6EEOD63woDpfmaV3vu+PHYb2lJ/Md3fSXh+o4riYNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5cYMj3ZvTbqLa/uZlB1CswJw0ZeHM4zgO9EnDltU6Sk=;
 b=d5njewlxo560qhConni0clzJlZyXeG5x8ffZZ7RQz34pJ5D2PAyE0TS2KrNA97QzPUn1Vc5hjsAjM9uNHeT4DgF7yDcI7rfroyM242AXnr3NqN8T0mvh7L9JNohVu6hjfsE81qMXxnGQrYJK7GM5rdQHWeVwFOTCMAB+8n37WYU=
Received: from AS8PR08MB6806.eurprd08.prod.outlook.com (2603:10a6:20b:39b::12)
 by PAXPR08MB7622.eurprd08.prod.outlook.com (2603:10a6:102:240::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 15:35:52 +0000
Received: from AS8PR08MB6806.eurprd08.prod.outlook.com
 ([fe80::3935:6d9d:93a2:cbf3]) by AS8PR08MB6806.eurprd08.prod.outlook.com
 ([fe80::3935:6d9d:93a2:cbf3%7]) with mapi id 15.20.9115.020; Tue, 16 Sep 2025
 15:35:52 +0000
From: Sami Mujawar <Sami.Mujawar@arm.com>
To: Suzuki Poulose <Suzuki.Poulose@arm.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>, Catalin Marinas
	<Catalin.Marinas@arm.com>, "will@kernel.org" <will@kernel.org>,
	"gshan@redhat.com" <gshan@redhat.com>, "aneesh.kumar@kernel.org"
	<aneesh.kumar@kernel.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Steven Price
	<Steven.Price@arm.com>, Suzuki Poulose <Suzuki.Poulose@arm.com>
Subject: Re: [PATCH v2 0/3] arm64: realm: Add support for encrypted data from
 firmware
Thread-Topic: [PATCH v2 0/3] arm64: realm: Add support for encrypted data from
 firmware
Thread-Index: AQHcIRDnAIRty/Ez2E2GqevKxjo2H7SV/AiP
Date: Tue, 16 Sep 2025 15:35:52 +0000
Message-ID:
 <AS8PR08MB6806596A37AEE88C32FFE3A68414A@AS8PR08MB6806.eurprd08.prod.outlook.com>
References: <20250908223519.1759020-1-suzuki.poulose@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Microsoft-MacOutlook/16.100.25090553
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	AS8PR08MB6806:EE_|PAXPR08MB7622:EE_|AMS1EPF00000046:EE_|AS2PR08MB9834:EE_
X-MS-Office365-Filtering-Correlation-Id: 942d40d9-d699-4a4d-fbcd-08ddf536cb4c
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|7053199007;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?UkdHVE9NU2JWbnROMitIa0tjNEZRZTdjY2F3TzNQbXBYOW95TDdXTHVBa0hZ?=
 =?utf-8?B?ZU5ZcDBrUDhxYTB5eWxlMTRoQStidmdkd3JwVmN4amtzZFdPbmg4alhyQUFa?=
 =?utf-8?B?RnVaSU0wY2orT21yN2pjL25hMm5kTUFCSXd0THdlMGltR0VqN1duM1k0b3NI?=
 =?utf-8?B?WDI4VWJaZERGVUU1eWd6aFVvRDlKaU9TSTdJaGVuT1RuOGczRVFtZHdrdC9a?=
 =?utf-8?B?Yjd4OFNVc24zcVI1ZEorMHJnTlVNcXZ0UWJzSWNLUDVCdHFvM2J5NTM0bVBs?=
 =?utf-8?B?cDBpK21LZmVTb2Q3UXp2S3JUU25raDFOdWNPMnJCdElZanRzQ0hPTWt2TDhr?=
 =?utf-8?B?VW9GU05vK2dSMEorWGFpK2pleUJBb3Y0YTBZSFlHVGYvT1l1TkZ3UHZpeEhG?=
 =?utf-8?B?c2o1dUptS25pd005OEpVNHFQWkdrN3N6YlFkSkZweHlURFVHVWlobFFJYXZp?=
 =?utf-8?B?anVMNnZoMU4wUWxDTXhFMjRLY1FMd2tCdERuVHhmRUIyNFFIQmUycDc5QjJE?=
 =?utf-8?B?RkZKcjBiRWJuY2kxTkxJVXNvWXJVMDBub0prM0dRVmpRTkYxeXRzM0g0TFNE?=
 =?utf-8?B?QzVkS01Md3NUVi9qSjZ4YVlOM2FCTWNrOVNhaTdOSitBZjk3ZzE3V01YbHZD?=
 =?utf-8?B?MmtJSWdnQnFlWEh4d1AwMWhtVzFaNGJTZG9rQ3p3WUxwcHpUb1dOc01XdWV6?=
 =?utf-8?B?VDRVYkVIR3FMcUxCZDVlTmJ0b2t6MmpGbmZaUVhYMlNzdUxWUG14cUpMbjRL?=
 =?utf-8?B?VzliQ2FSSW5iclFpTWRUamt1UDd1K2x3MnVobDF2aUE4dEtPSG1VYUtzU0RJ?=
 =?utf-8?B?aVRoMzJOTFcxcWNoTkxuUjYzRWFCMEpXMENCeFp1ajdBVlFnV2hvNVNieUoz?=
 =?utf-8?B?VnBxc3FUTmdIUTc2WXFKb1JYTUR6ajA4Qm9ibEhwSzFuMSt2SWNHczlwME9C?=
 =?utf-8?B?MmlBQ3BVUy9mRDRGNmZDZE1yNmFuSi81aCs3ZjZjZjVMZzNwTWorR1VlNXZy?=
 =?utf-8?B?bXlMeFNDV2pUVWpWMFlmVGlwV1puRm9RVXdoUHlRSEdIcEd1MjdoM2ZqQWtw?=
 =?utf-8?B?Yy83dVpsSUo1RC9TSkJEdG9GZEVDUHdUQXNLLzNpenhoUmQvaWt1bjV4aTlU?=
 =?utf-8?B?c0R1c3lOYWp2cU5OTnhlTHdQZll2OVBnTmg0dzJQOHJzekdPY3ROR3ZFU05u?=
 =?utf-8?B?NVFNcWpRZkpLRlpiVUNVQkdXODRPeGwyZ05BTDYxRm9tdk1pc2czR09OMEpo?=
 =?utf-8?B?cFAvWnlHN2pJNEhBS0ROWFR6YlduZzA2a29VaWQ5NFdVUVJhOUR0ZEovSkpO?=
 =?utf-8?B?WDYvQm5XaG9BTGwzSE9jMW5KQ2hKa2JsU1pITXlOR2FBZkZaSzVycjQ1VFFq?=
 =?utf-8?B?bWFBKy9lMitPU1VLbkJ4TFR0Ny9Dd29MeXNQRWx4ZmJHaWh2RWVzR2ZGbDZa?=
 =?utf-8?B?ZWZmRkVlSTBxQ3J6R0ZGQlZaQWhXZExCa2ROc25UQkRWYVRESUIwQnNvMVRU?=
 =?utf-8?B?eno1bnBXeXpXSFVyMkVIRjJoTTdMU0Q2MVZIbmVCbFRuUHBRUGxVNktPYkJm?=
 =?utf-8?B?QVAvakR6NzdxUGQ5MzJxVHl6ZDJjWFk0OU5GMGY5UGdSRWVWbnFXWit3Yno5?=
 =?utf-8?B?K0FsVGd1amFOMWRERkt2Q3hYTGVDZ3p4MnNLNy9nNng2a3BjZTJVWG83Tzg5?=
 =?utf-8?B?bVMzSnpqay9ZVEVVN3hzWWtuL3p5aC9ZbFRlSkhRYTJQaldnKzRCaVRWV3Nx?=
 =?utf-8?B?MGlUL2tPSUwrUDRCUHhQUmF0N2pHQnFIaiszMkRRTmVpRGtwSlhVcUR6YVVS?=
 =?utf-8?B?ZXNwUVBoMnRBQUpMaDRENVd0WHNyQjZCeWJPNEhBckxVZzcvK3ZYSjA1UGtJ?=
 =?utf-8?B?TVJXVldncGFHYjFNOGR2cmt1bFZsTWFDNEhCS3VGaXF6aUg1eVUzVkphdy9X?=
 =?utf-8?Q?7GcaUcg8kVs=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR08MB6806.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(7053199007);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <DE07494A6AD47647A3B5764DCE332283@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB7622
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS1EPF00000046.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	1a2e289e-f708-4229-f1f8-08ddf536b816
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|82310400026|14060799003|36860700013|1800799024|376014|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TCtydXBRZUdJeFQ4RmxJSVlhbWloWWwza3hZdGczT29EQVJVVVgwTCtOYzBS?=
 =?utf-8?B?Y2lic3pMZXZKdyt3MkZLRzZ4K25ENDFRODF4Q3hyc0I2ZkZUNDloNWYrT0tD?=
 =?utf-8?B?eDJzMUszaW9BMXh3YnJkYWwxNHJhTEJwSjJiNXhPL3p0eml1Mmk2QUJHNnVh?=
 =?utf-8?B?RngwUXlObzNtcmIxcFJtYkVwcGtZMzMvb0V1YmFmRDY3YWdZSnNUT2FmNURo?=
 =?utf-8?B?cXBzaVRjcENjK3JVRlQvZ3laQzgrSzRSU3VmUkVpcjNMd3VmT3FadHBsRjFt?=
 =?utf-8?B?bGV1US9ydld4Qi84U0ZwdC9Udmw2QWNERzBCbW5WdG9qWUI4cXdHSzBlVWZF?=
 =?utf-8?B?UWtNOE5WYWFBSWQxWUJhR1BUTFZZMjhDOEVSamM1ZGJldGVONDNKb2FUQ0Vp?=
 =?utf-8?B?Ri9zSms2Lzl6Z0NlVFBXNWdNK0lrK2RQcy90QnlsNVcwNDBOVXZZRVNscGtQ?=
 =?utf-8?B?cEwySTdSZlR0QUxpMElzdlZ4VE95R2tBcnFoUjRkbVp3NExxYlVxdGlLVkpS?=
 =?utf-8?B?QUx4enlmYkFJdU8yM0xXRms4Tk1mdUd5U0EvOHZUR3JiOHRUOU1wdkppekU5?=
 =?utf-8?B?UmFhd0dWSlV4Nkk4ck5SdTRsWGFrQ3FYMGlMNnFWTTh5MTBDOTFEQStlTklj?=
 =?utf-8?B?b0UrWWltYW1TVmwrWFErSUJ4L29BWVV0RlNPdW4rWHRXUGoyaDUzV1BIMDNU?=
 =?utf-8?B?WDByREt1QXBRaEFqQk1YcDhxWWtKR0FER01WZExmU000MlBWMWdrWmQ1Zks1?=
 =?utf-8?B?b1pFc0s0MUI4bUdxLzRIZjVNTTZsK2pQbFlOcHlNR09tZ01oamVMd0dXNmVp?=
 =?utf-8?B?cUdlTFdpTnMvc2tmangwcVplWXk2b2hobnRHeXBhMDZicEg3QTE3bG1PVG9Q?=
 =?utf-8?B?VFdLdW9YVllUU2JqbzNmd09HRWN0SWhlaFhUWVljRWgxdXlpYTVMZmtsMkJU?=
 =?utf-8?B?T2RwUGRGbXZPSER5QW9tcm5pcmJYelNRZWs2cGZ6QzVIc21rVVkrWjIraDk1?=
 =?utf-8?B?Uk4waGhFcitjL1hHakpiZkQ0dXRDcHdSTDY3WWpHdDRLWTRZWG92aG9pZ3c4?=
 =?utf-8?B?NlRPNG04Y0t1ZXROQXQ4M3QydEJNN1F3R2dBSVlpZTB0MUViVHE0Z3A5NUZV?=
 =?utf-8?B?bm1iQ1duR2I4VTFHWUMzMDMyYU9KRXI4MjdjUU4zNVJjNWFWZ3gyTUY0YnpS?=
 =?utf-8?B?RmZwRXF3a2REcGJaYVFUam1FN2xpRnBmQzhKeDZ6RS9TZzl5Vmp6ZndGSGt6?=
 =?utf-8?B?eEFOcVg5MkF0bUVGR0tNNTlIdjdJd1NsS3dzWEp4RlMxdU1kaW1BcUhjcFNZ?=
 =?utf-8?B?SzR1VmZZaHRsSmE5WHduWXE1eEtnc2NIUzlHdzBJbG5FTDVzR2kzYjdqK0Zp?=
 =?utf-8?B?ZDFtUFJQYWZSdUdoUEMwR0N0Tk9VTnBEY3AwUlBIUy9JRHc4bXJ1am03b1d6?=
 =?utf-8?B?UjB4a2JaR0I4ZjBjcVk5WEZVSDBkZkQrMFoyVnBoMGhZWlZxTWtCRlNnRnFQ?=
 =?utf-8?B?ZU5zT0JycDNNT3NRSUt4UmF0VHMrZEhMVTdJNmtzRTMrNDJpL0l1cnIzTW52?=
 =?utf-8?B?R1JUT2lkQjFXYjJHUHQ1STA2UUVUcEZSN1F4SDZHSkkvNXE5STdQYkI4L2FZ?=
 =?utf-8?B?WkNRWGlRODErcnF2alVnbUFpMTAyOFlMbmNYb29idG5RRmZSWi9YeTBJLzQv?=
 =?utf-8?B?bjhBSS9GZHBCdzdRbGo3b0t2cG1lM3M1dG5EL2F1UVNnYVRCK2lSekFoL0hI?=
 =?utf-8?B?VWdtc3ZJcGYxRllJZ05aenNBTE92ZGlIMmZHYWdkT1VIa3lkU1MvQWdKMGUz?=
 =?utf-8?B?M01FUndYdnF5VENRejFkUmZCT0FzS2dFcklyeHoxS2M5aHpwTXhzRWtwaGl3?=
 =?utf-8?B?YU1PTDJLa3dnbkY5MHY5TmdEbGtnMEJ1R29hMEluT2lQWTYwanhJUmY3U3Nm?=
 =?utf-8?B?MXNZcW1kaFdqNTNrcmlwZTRlcXBIYm5rU1ZCa3JZT2tyMVhtTW9pOFJCTEVB?=
 =?utf-8?B?MkZwQkN1ZzVRPT0=?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(82310400026)(14060799003)(36860700013)(1800799024)(376014)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 15:36:24.3157
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 942d40d9-d699-4a4d-fbcd-08ddf536cb4c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9834

Rm9ywqB0aGlzIHNlcmllcy4NCg0KVGVzdGVkLWJ5OiBTYW1pIE11amF3YXIgPHNhbWkubXVqYXdh
ckBhcm0uY29tPg0KDQpUaGFua3MuDQoNClJlZ2FyZHMsDQoNClNhbWkgTXVqYXdhcg0KDQpGcm9t
OiBTdXp1a2kgSyBQb3Vsb3NlIDxzdXp1a2kucG91bG9zZUBhcm0uY29tPg0KRGF0ZTogTW9uZGF5
LCA4IFNlcHRlbWJlciAyMDI1IGF0IDIzOjM1DQpUbzogbGludXgtYXJtLWtlcm5lbEBsaXN0cy5p
bmZyYWRlYWQub3JnIDxsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc+DQpDYzog
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZyA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
Zz4sIGxpbnV4LWNvY29AbGlzdHMubGludXguZGV2IDxsaW51eC1jb2NvQGxpc3RzLmxpbnV4LmRl
dj4sIENhdGFsaW4gTWFyaW5hcyA8Q2F0YWxpbi5NYXJpbmFzQGFybS5jb20+LCB3aWxsQGtlcm5l
bC5vcmcgPHdpbGxAa2VybmVsLm9yZz4sIGdzaGFuQHJlZGhhdC5jb20gPGdzaGFuQHJlZGhhdC5j
b20+LCBhbmVlc2gua3VtYXJAa2VybmVsLm9yZyA8YW5lZXNoLmt1bWFyQGtlcm5lbC5vcmc+LCBT
YW1pIE11amF3YXIgPFNhbWkuTXVqYXdhckBhcm0uY29tPiwgU3VkZWVwIEhvbGxhIDxTdWRlZXAu
SG9sbGFAYXJtLmNvbT4sIFN0ZXZlbiBQcmljZSA8U3RldmVuLlByaWNlQGFybS5jb20+LCBTdXp1
a2kgUG91bG9zZSA8U3V6dWtpLlBvdWxvc2VAYXJtLmNvbT4NClN1YmplY3Q6IFtQQVRDSCB2MiAw
LzNdIGFybTY0OiByZWFsbTogQWRkIHN1cHBvcnQgZm9yIGVuY3J5cHRlZCBkYXRhIGZyb20gZmly
bXdhcmUNCkNvbmZpZGVudGlhbCBjb21wdXRlIGZpcm13YXJlIG1heSBwcm92aWRlIHNlY3JldCBk
YXRhIHZpYSByZXNlcnZlZCBtZW1vcnkgcmVnaW9ucw0KKGUuZy4sIEFDUEkgQ0NFTCwgRUZJIENv
Y28gc2VjcmV0IGFyZWEpLiBUaGVzZSBtdXN0IGJlIGlvcmVtYXAnZWQoKSBhcyBlbmNyeXB0ZWQu
DQpBcyBvZiBub3csIHJlYWxtIG9ubHkgbWFwcyAidHJ1c3RlZCBkZXZpY2VzIiAoUklQQVMgPSBS
U0lfUklQQVNfREVWKSBhcyBlbmNyeXB0ZWQuDQpUaGlzIHNlcmllcyBhZGRzIHN1cHBvcnQgZm9y
IG1hcHBpbmcgYXJlYXMgdGhhdCBhcmUgcHJvdGVjdGVkDQooaS5lLiwgUklQQVMgPSBSU0lfUklQ
QVNfUkFNKSBhcyBlbmNyeXB0ZWQuIEFsc28sIGV4dHJhcG9sYXRpbmcgdGhhdCwgd2UgY2FuIG1h
cA0KYW55dGhpbmcgdGhhdCBpcyBub3QgUklQQVNfRU1QVFkgYXMgcHJvdGVjdGVkLCBhcyBpdCBp
cyBndWFyYW50ZWVkIHRvIGJlICJwcm90ZWN0ZWQiLg0KDQpXaXRoIHRoaXMgaW4gcGxhY2UsIHdl
IGNhbiBuYXR1cmFsbHkgbWFwIGFueSBmaXJtd2FyZSBwcm92aWRlZCBhcmVhIGJhc2VkIG9uIHRo
ZQ0KUklQQVMgdmFsdWUuIElmIHRoZSBmaXJtd2FyZSBwcm92aWRlcyBhIHNoYXJlZCByZWdpb24g
KG5vdCB0cnVzdGVkKSwgaXQgbXVzdCBoYXZlDQpzZXQgdGhlIFJJUEFTIGFjY29yZGluZ2x5LCBi
ZWZvcmUgcGxhY2luZyB0aGUgZGF0YSwgYXMgdGhlIHRyYW5zaXRpb24gaXMgYWx3YXlzDQpkZXN0
cnVjdGl2ZS4NCg0KQ29uZmlkZW50aWFsIENvbXB1dGUgRXZlbnQgTG9nIGlzIGV4cG9zZWQgYXMg
RUZJX0FDUElfTUVNT1JZX05WUywgd2hpY2ggaXMNCnJlc2VydmVkIGZvciBmaXJtd2FyZSB1c2Ug
ZXZlbiBhZnRlciB0aGUgZmlybXdhcmUgZXhpdHMgdGhlIGJvb3Qgc2VydmljZXMgWzBdLg0KVGh1
cyBtYXAgdGhlIHJlZ2lvbiBhcyBSRUFEIG9ubHkgaW4gdGhlIGtlcm5lbC4NCg0KWzBdIGh0dHBz
Oi8vdWVmaS5vcmcvc3BlY3MvVUVGSS8yLjEwLzA3X1NlcnZpY2VzX0Jvb3RfU2VydmljZXMuaHRt
bCNtZW1vcnktdHlwZS11c2FnZS1iZWZvcmUtZXhpdGJvb3RzZXJ2aWNlcw0KDQpDaGFuZ2VzIHNp
bmNlIHYxOiANCsKgIGh0dHBzOi8vbGttbC5rZXJuZWwub3JnL3IvMjAyNTA2MTMxMTExNTMuMTU0
ODkyOC0xLXN1enVraS5wb3Vsb3NlQGFybS5jb20vDQrCoC0gQ29sbGVjdCB0YWdzDQrCoC0gTWFw
IEVGSV9NRU1PUllfQUNQSV9OVlMgYXMgUkVBRC1PTkxZLCB1cGRhdGUgY29tbWVudCBhbmQgY29t
bWl0IGRlc2NyaXB0aW9uDQoNCg0KU3V6dWtpIEsgUG91bG9zZSAoMyk6DQrCoCBhcm02NDogcmVh
bG06IGlvcmVtYXA6IEFsbG93IG1hcHBpbmcgbWVtb3J5IGFzIGVuY3J5cHRlZA0KwqAgYXJtNjQ6
IEVuYWJsZSBFRkkgc2VjcmV0IGFyZWEgU2VjdXJpdHlmcyBzdXBwb3J0DQrCoCBhcm02NDogYWNw
aTogRW5hYmxlIEFDUEkgQ0NFTCBzdXBwb3J0DQoNCsKgYXJjaC9hcm02NC9pbmNsdWRlL2FzbS9p
by5owqDCoMKgwqDCoMKgwqDCoMKgIHzCoCA2ICsrKysrLQ0KwqBhcmNoL2FybTY0L2luY2x1ZGUv
YXNtL3JzaS5owqDCoMKgwqDCoMKgwqDCoCB8wqAgMiArLQ0KwqBhcmNoL2FybTY0L2tlcm5lbC9h
Y3BpLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCAxMSArKysrKysrKysrKw0KwqBhcmNoL2Fy
bTY0L2tlcm5lbC9yc2kuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMjYgKysrKysrKysr
KysrKysrKysrKysrKy0tLS0NCsKgZHJpdmVycy92aXJ0L2NvY28vZWZpX3NlY3JldC9LY29uZmln
IHzCoCAyICstDQrCoDUgZmlsZXMgY2hhbmdlZCwgNDAgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlv
bnMoLSkNCg0KLS0gDQoyLjQzLjANCg0K

