Return-Path: <linux-kernel+bounces-867213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B71FC01E00
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 16:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B99711A62C3E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 14:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17FBE32ED45;
	Thu, 23 Oct 2025 14:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PUReZj06"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012052.outbound.protection.outlook.com [52.101.66.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC03A1D6DA9;
	Thu, 23 Oct 2025 14:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761230809; cv=fail; b=Y96Pojs5oF+HvJfMeSC6PeGq2AcVpNj5brpjKW4oXxxXzCYSite5BaotXOI3ZRoGA/r3NxNRk2v5QqlKs8ZrbwIKb4c5Y06BjmsXZI2irrkydIxDxBCHAFhZZ7ePPyE1hev+ftTT1914mnu1I2A23ET9mnkN4K0ulBiYvd6bmxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761230809; c=relaxed/simple;
	bh=iIsk5my5VCBFqIeaw4+t+afMYDUccpxiQ6jeb6JpX30=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fvQkH8scbQqDIvDnLZetmNXt8SpZTu3RzB19mQmvCnVzmAiDYba9j9WHJOUZpRB4zpCWZWmRY9mTwyIy00xY4/RAlDqmYlgFhCtTuXo0arIjc8Sfo9S2JkquvanpaR8ymBaFiA7Ic2j6kPsR3sAT2ZSEFfajFpW2eUK0KUbvHO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PUReZj06; arc=fail smtp.client-ip=52.101.66.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eAYWQ8gn8TES7nXoyNKIPNKh1L9vGJc9oy1WUgEoCygvZMrNCWfPIMW7/MxM5eZi/HQCRl8I9UIfPvPnnuN59S1bJCVNtozCDr4MIPhevxI5ZjpszV3GDoQjsYCXSYqvZl+b/aHYSBK+lf9MEwBf/dTxHVIKT5k8x+1M2BEh/HHztMa8g8Rj4hSi/vX73X/VzmKbwI6g66AfKf1sOqzQ4PVPb7tL019I7xWlHTn/zDIrL2nTn8WF1bjTG1ejYaSOE+pWLCV3D0dwXVVlgQTu/8PXyWXLp5VFhDGFHk4GpM1trducE0a51OjBES1AVgRt9rG5uxyDYwiyN2woKiZ35g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iIsk5my5VCBFqIeaw4+t+afMYDUccpxiQ6jeb6JpX30=;
 b=Fm09i2cehZA9d2A4jkqU2C2J/Oeb/HMr0CcLX+IdJkHo8L/BBs9Vzi2IbUZhpz7BqfsO3zPa8UAgpgVBiSRueqPOvB1vFTkqolMVy/iLU6JVggFfYB+/dpaL2FSbLnS7SEKie7+qFYK9DG3k4ei/mOF6AozgQSBBvAwVkZEq8Rhb/lv+5jdPVu8THgsCK2mB/Ah1tA2ewJxJ1zmhR3MJX6mRoKnrwjMKpobXXo2naXGNq26b/rEjCHyzCR2s0Kwlp6cTu9p6ZoCeA8iMrw3DsyrJ8r/IsdW5lTWOVJpXZqJYtxIRGL3vDHtikZRKeUBccFFQ3v7uTKp7mKj6d6MiLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iIsk5my5VCBFqIeaw4+t+afMYDUccpxiQ6jeb6JpX30=;
 b=PUReZj06MhZhA5656OubmdRwljuRlA6Imt3VrCpQsQdJFpcMXYkqaJZ6fXVFI4TDuiTtIE0/qutY/xhKKt9WieUSPkO+p6MZq8xt5q4Yi/FfNo36Okj/i9+EzNKbqBoak3cQNW3St4TopzXLwuaFDHeJsC+nFlcGsJpOFTZMlB8XQJeQvfOpfevEBylWJvTSAT/LY31QdGeFThRay4RM2C3riXSVavdTVWM81EajVv1NTdl0qyFsD0VLZ1nzpQ/rLFMiMmFHw4HDgC0oipQRRCxPmXTdI+4Fv6+FCWLIWrJURtDD8tbH1NjfBXtbUztDliThDc/s7YA1APfmN0Utdw==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB8405.eurprd04.prod.outlook.com (2603:10a6:102:1c2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Thu, 23 Oct
 2025 14:46:42 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 14:46:36 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
	<sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Sudeep Holla
	<sudeep.holla@arm.com>, Cristian Marussi <cristian.marussi@arm.com>, Sebin
 Francis <sebin.francis@ti.com>, Brian Masney <bmasney@redhat.com>, Dan
 Carpenter <dan.carpenter@linaro.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "arm-scmi@vger.kernel.org"
	<arm-scmi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v5 6/6] clk: scmi: Add i.MX95 OEM extension support for
 SCMI clock driver
Thread-Topic: [PATCH v5 6/6] clk: scmi: Add i.MX95 OEM extension support for
 SCMI clock driver
Thread-Index: AQHcOM+l7sFcrdl8hEKQrktlH0f/Y7TP2KCAgAAK2lA=
Date: Thu, 23 Oct 2025 14:46:36 +0000
Message-ID:
 <PAXPR04MB8459BC290B855BFCA1C3D15E88F0A@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20251009-clk-ssc-v5-1-v5-0-d6447d76171e@nxp.com>
 <20251009-clk-ssc-v5-1-v5-6-d6447d76171e@nxp.com>
 <CAMuHMdU-UkzLnrPpBVyMH0DtgubxE_spUYbxtpO+5dmkFFqdcQ@mail.gmail.com>
In-Reply-To:
 <CAMuHMdU-UkzLnrPpBVyMH0DtgubxE_spUYbxtpO+5dmkFFqdcQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|PAXPR04MB8405:EE_
x-ms-office365-filtering-correlation-id: 95bdb4b3-8b17-473e-ca9d-08de1242f7c9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|19092799006|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?U3JmQndpWFpweTg4UlA4bEkvREh4N0dLQXc5OGVvenlDWllIekZqdGsxRVcz?=
 =?utf-8?B?SlNOcXdmVDdPTUx1UmZmc01tTFRJZ09ZL2NWMHNtNnZXeFZVREVCbU9oQVkx?=
 =?utf-8?B?K3hueTZqLzN4UGJaMEx0bWZFeE5Ba1dhbXM3S1pIMnkyeG9TSFpKNlBiZnVJ?=
 =?utf-8?B?NWEwa1B2TG1YTHdRS3FzWEVmMEVKYnc0VzRhQWc3enRBVjR3VmZJeXBRRnZV?=
 =?utf-8?B?eWphM3ZkMjlrcW1IZElpQloyNk8xOGJkTmk5U09uYzhqWjRQMVZQbDBFUVBs?=
 =?utf-8?B?bEpLd3ZFNG9KaEJNcWFqK1RVbktEVmNFNUxLRVFqek5EditHdXVVRGtkTFo1?=
 =?utf-8?B?clg1aGY4VEdSTXpXK2o3N09wNWJ5RTI4dmpVVFVIT3k5N0hGTWkyRzdhRjVH?=
 =?utf-8?B?QjBLMVlBNjNzM25IaFFlbGxMY2E5L2VNNFV6YTdDRU8vdjE5bGxpUVUxaXZ2?=
 =?utf-8?B?MW1oSEZYRFUzOFBxQ094b2JiY3lZV2VFTVlqaDBjVy9YSEw5aUF3dlZsS3FQ?=
 =?utf-8?B?WUN4Tm5kY2N1SmZUK3JqYnlnOVRDUG10Q0FVQ0RRdmUxMVJveStYbksybXVo?=
 =?utf-8?B?dURzYWJxTnlwNGdUQkNSWGdMVUx1ZkZnNUZlUWZEakFiUjBsa1pjbEJqUWFL?=
 =?utf-8?B?UUhQTlR3WEZwQ1UzcXc0N3g5eUJ5d0ZOV2NpRndZdHZtRVd2Z00yVmp0V2g3?=
 =?utf-8?B?b1hXQXYyTS9qcHQyNHA4K29FZ1kvSGljTWtVU21UWHlrWitxaURQenFXd0p6?=
 =?utf-8?B?WmFiaktwSlhyejEwajBBQ1lCQjZqOGZwN3ZkdHlqUElSeVdkL1ZlVElBc0xM?=
 =?utf-8?B?NGxkdVJIVlI4cVE2Y2xFWkFGcGQwSmVhQWdJRFZjc0FlV0NCT2RQYzdOUDRy?=
 =?utf-8?B?ZVRXMjV4NkhDeUlvbXRnSUF3dUhYOXVuL1pvNHJRUndicGJCR0VScTByaGRK?=
 =?utf-8?B?OThVOG10VGRjMEp1Zk1MUkY4T2RsZ0kzSlN1YnJtS2xMYW8xUUVnMURubllW?=
 =?utf-8?B?ZENWWHp5akZtcFRyakVLNUxINGVlU05PbW00MW9icjJjVExVeUlzYmczbjNv?=
 =?utf-8?B?MmUvNVhvUkt2N3dzaWFYNXI1TFRFc2RyTmJBMzZjRy8wTVBPSWFDTTk4Smtz?=
 =?utf-8?B?SVAxTUVtSTk4NXBuNlgxRFlhdi96Y3BVcUEybVBpVEwwYzllU2tRd1VqZ2RN?=
 =?utf-8?B?N2lwMVVvWDRNQzV3T21iMzBnMzlPU241VWNTV1JabmNWV0FBbVgzNFhIK3Vy?=
 =?utf-8?B?ZS9ieDZqUEtPcSthSnV5SDlUNjIxMktXamJXZVVwRUU1ZzM4dDRrdE0xV2Jn?=
 =?utf-8?B?UStqRG44TDRDTjhrT0h4RlNSZ3BVSitwYytFZ1RtUDhOM0tCS0FmRnhNc0Vt?=
 =?utf-8?B?MlNyWjVYZWVEVFZNRG1vZlBxMHF6NVJHRkVoT2N2RmlSeVhWc2xjV01FSWRY?=
 =?utf-8?B?MXR4aiszc3NVRUxLWHF4dmNhSDJpa0dkeVFpSG5FdTJTVWJ2eG9pR1NKNGp0?=
 =?utf-8?B?NldJWTVnME84b0FlbU1TYlJLa2tQUTgwRDc3azh6MFc5L0hBRjgrVGhzWTFG?=
 =?utf-8?B?S2hidlZzTjBOSlV1QldPOVRkSWlLdXZjS0UwbTQ2S0xvSG8rMkU1QUE0ZnRW?=
 =?utf-8?B?K3ZnakMyTUdIZ3J4T09tWHVYejVuWERnQTJ4RXhHWm1zcDF0VDczME1FZzhY?=
 =?utf-8?B?bXdKQnRvT1V0YnpJdFFBRG5PYys1T2RlRm4xZnc4Y1E5MDljU0R1VitGc3RM?=
 =?utf-8?B?MUZkaWVCaGI5c2N4WnFTcE0wcEtkblljZitoOHREdjJSQVd0UzY4bFhRa2t3?=
 =?utf-8?B?N2VJc1pnbWd1Y2F5OHRpVmQ0dGlGMmJiUEQ0MmVVVk1oY2kxZlFleFpoRFRw?=
 =?utf-8?B?TjVNYi9rcEpEc2hPMzZiaWwydjQwM2dWM1kxMUdpQUp1MllFM20vdUZhM2Ro?=
 =?utf-8?B?Q2hzTmM4N1Z5UFcxYlZZaTR3S1hHd2FBYXo0OXZjT3NBRTB5Ym84RWJyRXhM?=
 =?utf-8?B?cEVrNjIwRWxhdWJjUStkanFicnMxZEE1ME9wSUpvKzF3WFJlc1ZRR0pRVURF?=
 =?utf-8?Q?bSa02i?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(19092799006)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bzNpWEk4ajNEeVRZOEJoRUlLc05aZDhSZTlvWlQ1MVJQMDdNcFpJaEVDUFFL?=
 =?utf-8?B?Q0dUbDdzZjhCTE45SmtXS3RJc3Q2MG5MSnNvUXpmc3hHbDdPdjBwNTZhK25h?=
 =?utf-8?B?amIzc0trY2tFYTJ3bmpyMnUrV0pJaGZKdXRlcFFHSHhZdWFlMTNXOSt4WXBa?=
 =?utf-8?B?UjE4R0h4OHRCcUhMMnh3S3JhWEFEVklwblRhZzJLTnVsVnJHTldiaWt5ZzE2?=
 =?utf-8?B?OWZ1Z0d3c2pCYjFsM0ZrSkNBM1hPNGM5NDZYQVF1ekNFZklqV1g5MHVkK3JD?=
 =?utf-8?B?eER2ODY1MDMzbHozN3pRRGw2SkxSdWc2aEF1dTBVLzRIQXhDRlI1UDNjb2U2?=
 =?utf-8?B?OExWRW9FRTRRMitIVmI2SlBIOHMxSCtJL3ZqalFzbVJZNEhQN3lGMUZrRlJq?=
 =?utf-8?B?SWNqL251QUZMMlAxNHRvaFBDM2RxZk9DWEFudFFEamdOL1EvM0YzU3VVWmNE?=
 =?utf-8?B?WkZuWk90ZEl4MkF3OHdFUXFsNXJUeHhCYjJoYzRiTWxBZnNDZElwVjFHeDRC?=
 =?utf-8?B?VEhWWFh0MGVLbTlsVE9nV2d3clNTMDdoSXU2TC9KbW5qOU9oNm0yQ0kyV0dz?=
 =?utf-8?B?clVjVGlkNVBNSTNEelJ3VE1Qa0xtbzhtMDQzVWRicnJ4RExCNGltT2RDYXZi?=
 =?utf-8?B?QThLSFlsa1RPNmw4YnpPZUFhUlhKV0xUOGN5MXVLdFBuZXgyb3A4ZDNORHlU?=
 =?utf-8?B?bVo5RXJLYjE2QVFjTHBDYVpHdHA2d2xJYWR4dkxveWxuemh0OGI2ejhHTkVo?=
 =?utf-8?B?SHM1T1NpdVNqRytOdExoSTZOdldIZFFza1REMW9hdWVoZ3l2Z2NodC9xdnhU?=
 =?utf-8?B?djdudmtqWHNPenFPbXRPdE43OUVjOWwweGNlUFlLZWp4OWRaQVNKTGFYYlRC?=
 =?utf-8?B?YzB3d1BqY2ZIYjlsUG9xb1JIaXFRNVlxZnRwQm5yRUtTZmJOZjFYcG5Ta2Fr?=
 =?utf-8?B?b2pDVG16NUREcWZVSTdBMUVhNDR6QlRtaEhmTGJkQytGV1VOTE1kS29KUlE0?=
 =?utf-8?B?MkIrWU9jSjBLTFFQSEFONGZUL05pWmhMbXRKbzFDMDJIZVZTUzl1SUYwVFdt?=
 =?utf-8?B?bFZvYTVaVXovRHRVOUp5dTJpL0gwZUlkZTRRVTJTVmRFd0x3aWFMY2plVVEy?=
 =?utf-8?B?dTJhUG9zQ0xEZWh0dUcyRE9kUEhkdTZmWnRFYzljcm9CdnhUbTVDWCtoSjRl?=
 =?utf-8?B?dHZ3VWdUcHlKRlRNUzhKdk45aEswdldNVG1iSWlaK3p6cnFmcVlRdTdnVDQx?=
 =?utf-8?B?bmRPd29rcDQyM3N0elAwQmZ0V0NVZWlTQ0Z6ZHM5VTE2VTZCOFRpWHJOU2Rt?=
 =?utf-8?B?Mnl0S3MwQWdOdDhzL2sxeHhPSUI1U1hia0I3OUIvN0J4SDJlcmJoK1ppaFdF?=
 =?utf-8?B?RkY4RXZUTDFUVFZTQ0dOelVleEZHeDBLQmMrTDRsWjlFbDhTRGRiTjByU2dE?=
 =?utf-8?B?Q0crVEdoVU9pTXVCOWJIWWtlNXlIQWNldExYZ1pCZzdza0h3RzE1VVRDbFpD?=
 =?utf-8?B?T3E4OTBkQXJlVjZKTDNGbGNaYlU0SUlDSC93YUErUzNEcHVGU2xXSnJWdHY3?=
 =?utf-8?B?b1puaEU0d052ZEdRZVJvYmwwVVdqSVFzKzhtdXVtL21DWG1vNmdIVEcvSFFm?=
 =?utf-8?B?MnhPUU9uMlNieFVkTWdjOHVySThxaFFudzB4bDN3c3ZCWi8vNmkvL3RFQVlv?=
 =?utf-8?B?VjlXSGpXYzFqRkxRQSsrcTA4bEl5VG1YWTJnbHF5bnlabFduWWd4cUNiTjVu?=
 =?utf-8?B?aW5TTHRWYmJZaUZFYnVNZXZodDZsbytkR250WTBIY0h3c1BKQUdpb2o3YmhH?=
 =?utf-8?B?cThGNXJtSURzM3ZWT21JUnR5Z1dWaVhLMGhscTI4KzB1RHNBcy8zcVp6RUlH?=
 =?utf-8?B?bHJzNkN4OCtyaFUvYncvdVZFV0JZc0JwNi8wQlEydWFHcnlRM2hZSUJ6Z1RQ?=
 =?utf-8?B?VFRGcndpN3dXb1JFQ0pmb2xNUGVMUHJJUmJ6QmovMkhiQ0J5NEdKa2twelZw?=
 =?utf-8?B?SUYvZmV3OW5oRHdlRGtlS1pUeS9ibzVvVnF0RzEyRVhXeEQ5ckw0Zk5hckJF?=
 =?utf-8?B?dTVuODM4K2NzYm1tRWNFb1ZWMGVOU0dKSjRQeUxOVEM4aHdJY3lKT1FrQkY2?=
 =?utf-8?Q?+t2w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95bdb4b3-8b17-473e-ca9d-08de1242f7c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2025 14:46:36.6905
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OrOdLLcq70As2bioEkxD+ydCCfnIAFk7k4gDZEQvS/oR+qqLfn/g3kazCV8bg4E/ujCMHDNX5BtgCkwxIRE+zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8405

SGkgR2VlcnQNCg0KVGhhbmtzIGZvciB5b3VyIGZlZWRiYWNrLg0KDQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggdjUgNi82XSBjbGs6IHNjbWk6IEFkZCBpLk1YOTUgT0VNIGV4dGVuc2lvbg0KPiBzdXBw
b3J0IGZvciBTQ01JIGNsb2NrIGRyaXZlcg0KPiA+ICsNCj4gPiArICAgICAgIC8qDQo+ID4gKyAg
ICAgICAgKiBleHRDb25maWdWYWx1ZVs3OjBdICAgLSBzcHJlYWQgcGVyY2VudGFnZSAoJSkNCj4g
PiArICAgICAgICAqIGV4dENvbmZpZ1ZhbHVlWzIzOjhdICAtIE1vZHVsYXRpb24gRnJlcXVlbmN5
DQo+IA0KPiBXaGF0IGlzIHRoZSB1bml0IG9mIHRoaXM/DQo+IEFjY29yZGluZyB0byB0aGUgY29k
ZSBiZWxvdywgaXQgaXMgaW4gSHosIHNvIGl0IGlzIGxpbWl0ZWQgdG8gNjU1MzUgSHouDQoNCkl0
IGlzIEh6LCB0aGUgbW9kdWxhdGlvbiBmcmVxIHRvIGkuTVg5NSBpcyBpbiByYW5nZSAzMEtIeiAt
IDY0S0h6Lg0KDQo+IA0KPiA+ICsgICAgICAgICogZXh0Q29uZmlnVmFsdWVbMjRdICAgIC0gRW5h
YmxlL0Rpc2FibGUNCj4gPiArICAgICAgICAqIGV4dENvbmZpZ1ZhbHVlWzMxOjI1XSAtIFJlc2Vy
dmVkDQo+IA0KPiBDZW50ZXIsIHVwLCBkb3duLCBjb3VsZCBiZSBzdG9yZWQgaGVyZSwgSSBhc3N1
bWU/DQoNCk91ciBmaXJtd2FyZSBkb2VzIG5vdCBwcm92aWRlIG1vZHVsYXRpb24gbWV0aG9kDQpo
ZXJlLiBIZXJlIEkganVzdCBmb2xsb3cgd2hhdCBvdXIgZmlybXdhcmUgZGVmaW5lcy4NCkJpdFsz
MToyNV0gaXMgcmVzZXJ2ZWQgaW4gY3VycmVudCBmaXJtd2FyZS4gSXQgbWF5DQpiZSBleHRlbmRl
ZCB0byBzdXBwb3J0IG1vZHVsYXRpb24gbWV0aG9kLCBidXQgSSANCmFtIG5vdCBzdXJlLg0KDQpU
aGFua3MNClBlbmcNCg==

