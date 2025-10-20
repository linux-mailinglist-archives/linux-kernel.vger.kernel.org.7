Return-Path: <linux-kernel+bounces-860328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A42BEFE1A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E75CB3BC49B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 08:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2AE32EA738;
	Mon, 20 Oct 2025 08:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="qLb7mYAd"
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023092.outbound.protection.outlook.com [52.101.127.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AA12D9EE1;
	Mon, 20 Oct 2025 08:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760948323; cv=fail; b=ZxGd2O5FNqX/KCGuk2V48LqeXJzTbrd14Kd/hUzymLxZSCEg4K5q1XG5EAVJ4F8mpQX6hATCCdQOqjwi0/XE60bC7Bf72WbRQjum49EB+Qcer/cAh4iohB2XwpUXJbH998rnau3P+2ruUqxImkWaNhu1+usQimBuL74Mzt/eLMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760948323; c=relaxed/simple;
	bh=FZVoYShcPyrzujqO22XGjmJhcpcELsppfMI7CbY0XEU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=umC9FIeyNo9/otcPqpRi/l8YSg4W78sIllM0YUiiw6O9LAoiLTWUDRC785JQ3lAXwMtMdYK+PpisvaItgIrgBUQA+3GY9hPUCnGpLgpk5DosKEb5iuEdo+ZViN8hzOV78guGOU2iZf09vn7nTTQI4Fdt3AgOUbU/E90ylrmqFk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=qLb7mYAd; arc=fail smtp.client-ip=52.101.127.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yErnPNHI+eCHmcFiNl2dpJGMrQM4FYVTJbVMyuYdP6F+6fKi6oyAJwzBT3TMAS4FKasmq59nr3M5HJFSXKzIXSwhXKo6AgkrElFQ6ARq0PX7XTAQ6KrKhxO7fjxdpqn1wxuikL4wl+yFIL1+f/nShcPES55K7aNPtsPzWfzEfbhuT7g6EhDm851LlYA5MCoHbIwSFMrYDgNxUJ+R3+CAwKJIWnPz/+PBxlT9srj4H2bByasJ+6q+vH1kfkFnsihzvwjzW0RPva6CE1Txd7NJN2S1E4COfjNHXizDbACjeoolsCa15vuB3ANa+PelA6RU/TehT/aipqaSMcyTZ7/Gug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FZVoYShcPyrzujqO22XGjmJhcpcELsppfMI7CbY0XEU=;
 b=OFL6zNjZg2mpBt/Z5jotKaUOFjvNyB6C935pdvIrvfJiCJRwDaca4NWAQaWWKJBu12vJCDGxPW0EWEgkpf7RRh6aDxmsWFLS31hEQA81KBK6EyFVWaF5qiClJUdQot99ABKsmZ5NhyuOAcZyuF2JO4jBo1IPcisahsYpZnI8k/arkj4cfc+FBoEzK9Nv9yB2G9nAS+jKACiYV+DuyV9SPJHBOeZisyTaMcScmGZoh8fyPDN1haARS71QeRXBAjdGn2CbB7e7FmlhWAQhPY38JMHE9CGjlp45mlOmhL4sy11pxCZh9OGA4BVuJx26QXTwSTIYeRhI7kJ69qYw0BZjrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZVoYShcPyrzujqO22XGjmJhcpcELsppfMI7CbY0XEU=;
 b=qLb7mYAdPg/VXeKVDFlUjG1Bbql/A5YBxzJshVyp5jcOdsnfIqNkIYE/q1qQ1i/xyywiGhO4B+SZ+ONftmnmx0RGA4h6NWVcPwTOEt5UynphXkfh3hr6sb+ejknv/bcdlI0lxmm8Fbv01BHx0i6F+6h5EQf4gkZMq+voFgSMdUFLuLCQ8PmYa/5oy8G4clp93ZSqZlVme02/LG3nUrOke/oBZUCc9PgYZcqq9qH850cf56JcImTlMtaN6TB31+9E65lRc2CG5nl3f6Idw1PD5a1X/WqufL6RUWnDWledE1xRRqtS/Fw6SpvYeV23rZ8BkV1dGFB+NLsyTL9x4M1s4Q==
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com (2603:1096:408::791)
 by OSQPR06MB7280.apcprd06.prod.outlook.com (2603:1096:604:295::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.15; Mon, 20 Oct
 2025 08:18:37 +0000
Received: from TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::df4f:b1a1:1825:4a80]) by TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
 ([fe80::df4f:b1a1:1825:4a80%7]) with mapi id 15.20.9228.014; Mon, 20 Oct 2025
 08:18:37 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Ryan Chen <ryan_chen@aspeedtech.com>, Krzysztof Kozlowski
	<krzk@kernel.org>, Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] dt-bindings: mfd: aspeed,ast2x00-scu: allow #size-cells
 range
Thread-Topic: [PATCH] dt-bindings: mfd: aspeed,ast2x00-scu: allow #size-cells
 range
Thread-Index:
 AQHcQWZVHXgbRjt/U0uvaTyLW9Dz6LTKj6aAgAAA+wCAAAUvAIAAAXyAgAAFsgCAABB08A==
Date: Mon, 20 Oct 2025 08:18:37 +0000
Message-ID:
 <TY2PPF5CB9A1BE658D97FEB9B56E67534DCF2F5A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
References: <20251020020745.2004916-1-ryan_chen@aspeedtech.com>
 <b38321e8-d243-460a-a9d6-6770a41627cd@kernel.org>
 <TY2PPF5CB9A1BE6CDC6F04CC0F472FE6451F2F5A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
 <6b30c646-cc52-4552-8311-86974c1459e7@kernel.org>
 <e7fec714-aa68-49a1-85e5-356115843307@kernel.org>
 <TY2PPF5CB9A1BE65E96ED9C3CE0E8C7A53EF2F5A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
In-Reply-To:
 <TY2PPF5CB9A1BE65E96ED9C3CE0E8C7A53EF2F5A@TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY2PPF5CB9A1BE6:EE_|OSQPR06MB7280:EE_
x-ms-office365-filtering-correlation-id: 18ca93e0-68cc-4d7a-6fad-08de0fb144d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?MUtvVGpLRXlaK1ZNNVFYWTNtN29WVUFGTjdlWFAwNVpRNEJqOW9lWGtROGR2?=
 =?utf-8?B?NXVTNEFSeFR5eTJ3R1pZcyt4UWRPaXlxRVRSMUpCbGtFNk9paDkyZ3N2QW9X?=
 =?utf-8?B?Y2RGV1hpd05ob0xSZmVERWJhaFhuQnFqWGZrcXUzZ3dTc2x5Wms3akpjUVdx?=
 =?utf-8?B?UnpodWwxdG5lOGQvWmRGUGovMmhXSDdqNEVzWWl3Sm5QWGdOOGdaRUlrZ2FS?=
 =?utf-8?B?ZU1JdlI4UTEwM0F2NDc4ekNzeEYyRGswWHg4VFpOdGxianZpcEM5L0ZPVUJ1?=
 =?utf-8?B?QllWeTR5aEk0ZHg4TTk0d1ZTMURhajZHdWRuWVJMVXZsSENDWnpEcVhNb2No?=
 =?utf-8?B?ejAvakFIUWpqRHJFRHNVV0MvdFJCUWJZeUhPakhnQ0ZIcUU3bjRMcXEydHlT?=
 =?utf-8?B?OFdmT0hSTE1OU0dwRXZNTEFrS1pCcEZ0MnBKalo5ZytueElmb2l1TTJrQUYx?=
 =?utf-8?B?b1VWZHNyOHNBdTNxeTFPY3hnZG9paVAzSEF1ZFM1dzE3QUVYQW1hZlB0bWpH?=
 =?utf-8?B?MXR4djM1Z1duamV1UXpBQW5PVWIzVUlhenR6OFZiRFJ4Y1luVzNmWUNRYUNI?=
 =?utf-8?B?K3Y1SkxiYWZWWjllclBmdXVBWGZST1VOYnhENGc3M0grVUEzUGdLaEEwMlVL?=
 =?utf-8?B?bUhwT0xBRVdsVHYwb1dIU0FFZThMSUk2ZEJaZmdLYUMzTjZKY1RDdkVPQytR?=
 =?utf-8?B?Q0tQT3daYUVIdFFhTzdyeHZJS2FEM3BjVTBPOEkyUFU4RlRTaGZQVlMreDlj?=
 =?utf-8?B?eFU1Ryt6Wnh3dnU0TjZLN3BOMGVjRUMvamg1eHBLaUszZWlYSk12U3dFcVMx?=
 =?utf-8?B?UjRJYi8rU0hpdG1wMFlBcW1VVEpMckQrTmMwTHMxdkY3aFFtR2FnTkJJQzdD?=
 =?utf-8?B?dGdsam5QSEYrcEczdHhLc3JTUnFNdVk5YVFsN3VDL2NCdElGdFlQWjY2dTkw?=
 =?utf-8?B?eFkyNzRpeGRuQlM1d0FUTnVyanhkL1VHRjJUckRLUU5PMTRXR0JJVTM1RW0r?=
 =?utf-8?B?MUNNVVlqaFcwYmFoS2VWOU4yM05ENmUwSWp5M054K0RIRndxT2VERWN0SGdB?=
 =?utf-8?B?d1FvcGtWS3d2WWVVUXJNU2NveEZwWWNRSWxBNEdWcXRzS3BoY3VBNTltMndJ?=
 =?utf-8?B?RnVkVk9uT01obEdtUDI4aVZCbTlkQzZKTks1WlpDMmlZME92NVUwanptZys1?=
 =?utf-8?B?RVV2SVYxc2orU2JheUJURVFlZXlWZ21CUDFhL1FrQUcvaU1odnJONHZOVzJs?=
 =?utf-8?B?RGozaytiaCtocU0vSXhFS2lOcStxL3h4R2NtaDArRXlmMnNqenVrQkwybmpG?=
 =?utf-8?B?TkxFd0VhdnJpMTBmaUhxaXdnVVlyMmFpV3lLd3g0WjltK2ovbGpRNlZ0UWZM?=
 =?utf-8?B?QmwxSzcrKyttTFE2a2ZkeEtXM2hjd04rdTJIVTY1QjRFQzdNRllIR0lmTG9J?=
 =?utf-8?B?WjZJTG9US0Zqckc4N3dyb050Y2NNcHEraU5aV1N0eVpQcndxcnNDcVQva1lJ?=
 =?utf-8?B?K01GQXcyUUpsUDBYVGpNMjd4VzJnSUgzNjIramVUL2NNbEZpRWNMclAzMDBE?=
 =?utf-8?B?RERZVk05aSs5bXRuVnRINXpaYkM5dlo4S0R6VGdCU2F4UEFWZEZ1bnRDb1dX?=
 =?utf-8?B?WEFicHVhOHlkVVordXBtY2F4MEV0SVA4dUt4R1hyaDNRRTVXOTdwbVBkcUhY?=
 =?utf-8?B?ZlpPd2hNM1RRMUtMTVR0V0Z6eG5XaXMvOWFieFI3a0N2VWx0NG82aUhqN2hO?=
 =?utf-8?B?MjhWZE9zc2RVUjVZZnZWYlJvZ205QjRlNDZOazZtUW11bFppUzZGTmdpQUc1?=
 =?utf-8?B?VjdQcm53SjJTMlFKU0p4dFdYczlpSWRZSDBDQVlsWHhBT3JEOEpBMkVPZ1NV?=
 =?utf-8?B?UU92WUxtbzR5TTRqdmtIMnl3RFNESTM3bG02Qk1WeVN0NjIyL2VoRVBmNThy?=
 =?utf-8?B?SXMxYmM3TGdnZHdrOXB6YmNOYjBLU2puSmRsRXVGS0kyQ1BrNDZla2lkOVNq?=
 =?utf-8?Q?Ycyau3G5MGr0WYESgZRjzV8yHAA6nc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021)(921020);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?clFVNE05dEk0clNDM0NOZVpvZ3VEMjNRV2lSTUpTV1QzOU5VWDR1MkdXQ1JP?=
 =?utf-8?B?T0hDakVVclpGUVYvNFpuZ2J4RTlaMWlPT0Y3S01lbzZJR0l4M2Q0U1BqcHdG?=
 =?utf-8?B?aWY5YnpWa3BoZmM1UWp0NURaRG5ISStZU3RwaG1JeFJYTVUxUHo3bDlieTJx?=
 =?utf-8?B?a1NuYU1MRnVVdlJ2Umh2TWs1cEEzVDlDd1hLWHRMZExlSVd3Ny85TlN0bFNZ?=
 =?utf-8?B?a1l5cTNCcHBhYmJEQnBvUHVFYU8wRHFLVndPYTJMZTFqbnk2RXV2UjRDdTBI?=
 =?utf-8?B?NHNIMWdUbXA2Y1dvVlBhRmZadTBXYm9xdDJkVjNuQUY0czFGN3orNmV1Y1dk?=
 =?utf-8?B?Mk1kd3dVaFY3Z2FicjhQR0V5TC9aZHRndzBNajllNmxXSTlGVkUxb05qcmE1?=
 =?utf-8?B?K2hCK3R3WmxjMnFUU3hJL21BbU5VK09CSjROampmdGM4N0pFcVpkNis4NXB6?=
 =?utf-8?B?K0NpMU1UUm5RazdlS0hCNWptNVJRTHpaRC96QzltNUFsN2YxUURoYVIyZFN0?=
 =?utf-8?B?cWxKNXd2elFyaWhOeG9mYlRHdmROZXY1WnJmck9DUWVPSEZWT25hU2lXaDNH?=
 =?utf-8?B?MGJ6ZlFaODM0cFpkMXNSNlBGOXBBdlhSMnZpUHYzamhoTDlZd1hvVTNWd1E1?=
 =?utf-8?B?YldBOVREMGpkMHdDMk54eGI5Vkd1MTdpTVVIQ3cvOG5UcWdMc09oSktabURL?=
 =?utf-8?B?OHd4ZUl0Z3p6cXRZSnVwcm9hOGhvclJFUktQdXYxWG1zRDhySnRzSTloTFJG?=
 =?utf-8?B?bFk3WjdkNS8zUjNLK1dOUUYvam1NOVplVmkzciswRTVubEd4RXREKzhvbmZY?=
 =?utf-8?B?SnB0bCt1Snl1N0FORnZJbDZiMk1La3UzMWJqaDZoclZFMURGSEVrV2RvQ2Fq?=
 =?utf-8?B?eWxOUkFjOFQzcStKc2V5QXQ5cUI4N2p2OEFJcFJiSUJwZmdRV1dDcFdKdWw5?=
 =?utf-8?B?R2VuV3FmUFg1RzJ0RUI3aVFlU08vL3ZDdU9DZmNYL3lINlVBZGUyRnQvaGdH?=
 =?utf-8?B?MzBoZmcvNmFRNkhFQ3dmODhvcTBMb0lOdGVweGRNckVSVE5ESHZrMkwzNlhG?=
 =?utf-8?B?TVV1OE9VK05VVFZ0eUZ3UlkvdlRDUEVjaDR1d2c2a0pSLzJoN3dlVVZ3OGV3?=
 =?utf-8?B?RXZwMnNRd2xiZUIva1VMVkhhTVRCU0dzbnZpd0IzZ3RiaUh1TDZNSVVsaXpB?=
 =?utf-8?B?VHpDUzNvVHFGa0VHbkN4Uy9GMGczRkhHZlk2V3NZQXovendrazNjVVV5QjR2?=
 =?utf-8?B?bk9hejdaQWQvbjl2MEd1OWE4dlR2TFM0b2U4RHg3V1A4WHpYb0F0TG1raFZG?=
 =?utf-8?B?dzNweHBCcng4TWJvMFRTeUU1cFlDNDJBK2doUUtOZWdYakwzL28razRJeVVT?=
 =?utf-8?B?R0NsVUJVU0JLOE15bGJVS1BSbUJzT1pyU2MrQk1ZNm4rLzZrUzJSYmF6OHJn?=
 =?utf-8?B?ZG1mT3NrazVmR2VUVDN2UG5lWUJCWmRKV2N1c2t0RzhKOGcwRFQxM1IrY21k?=
 =?utf-8?B?YlY5NVY1NEh5NmYyaWkvbENxTGdCVjVOVUlaZHVTT0JXMHVNZ0JlZ1pjMHlx?=
 =?utf-8?B?QVBnRjNNWXBIL1Jid1B2OGlUMG1KSVIzM2NCdThwTmxraklYU1FMVFMyYjVC?=
 =?utf-8?B?b0pZYStSbWFEV3N3UWw5dmlrK1dEaXVScmU4Mmd4Vi9NdkEveXE4a05IL0Zu?=
 =?utf-8?B?WSs3N09QUnFpZHY1U1N4aEx0ZFBsbFhNMFhmbWJTck9adVBNK0NETUlFOUph?=
 =?utf-8?B?SzdZa204bW9SRDVOUWI1SStaekFoY21hOXA4S2JvS1JPQXVmTmg3bUpqRjI2?=
 =?utf-8?B?MmJ1TTdxYVorVlE0WjdsNDNoR2kyaUFYK3J1UElsZitrdFJNM0pScjMvUFVa?=
 =?utf-8?B?VFg5TThMdUJrRzJLa0Ntb0ZlUHhSQWNRaGl0QTZhcVdkdno3MHFUSzFUVlJ1?=
 =?utf-8?B?SEg4Z1V5SXQ3aHNoZGdSOVVIVU1LMDVxZmlKMDJQTGs5QzBHVmpNQUF6cVp1?=
 =?utf-8?B?ZmE2UEM0VGlCR3RaSCtWYmhPVTVpSVUySFJRbldFZWxoRUl3Qm9xRkp3bklV?=
 =?utf-8?B?UXh0TG11V2hNa3F6eUJyYVdMTkJORjU1RWErMk5BK3krNUFXcE83OEp3WnJp?=
 =?utf-8?Q?sgZghUPhkmQ+FN9PwakWPweYJ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PPF5CB9A1BE6.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18ca93e0-68cc-4d7a-6fad-08de0fb144d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2025 08:18:37.1616
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6DHPmtQ+XHB+LMQp40Erf8DxeHkqs2MeFetbZI1QBRklZxExi/xHZO4Xmw8EWcZQ7QrXbHsN2EK79vtQj/Q5ZZMxSm7soIaK3nsII6y99Z4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR06MB7280

PiBTdWJqZWN0OiBSRTogW1BBVENIXSBkdC1iaW5kaW5nczogbWZkOiBhc3BlZWQsYXN0MngwMC1z
Y3U6IGFsbG93ICNzaXplLWNlbGxzDQo+IHJhbmdlDQo+IA0KPiA+IFN1YmplY3Q6IFJlOiBbUEFU
Q0hdIGR0LWJpbmRpbmdzOiBtZmQ6IGFzcGVlZCxhc3QyeDAwLXNjdTogYWxsb3cNCj4gPiAjc2l6
ZS1jZWxscyByYW5nZQ0KPiA+DQo+ID4gT24gMjAvMTAvMjAyNSAwODozOSwgS3J6eXN6dG9mIEtv
emxvd3NraSB3cm90ZToNCj4gPiA+IE9uIDIwLzEwLzIwMjUgMDg6MzEsIFJ5YW4gQ2hlbiB3cm90
ZToNCj4gPiA+Pj4gU3ViamVjdDogUmU6IFtQQVRDSF0gZHQtYmluZGluZ3M6IG1mZDogYXNwZWVk
LGFzdDJ4MDAtc2N1OiBhbGxvdw0KPiA+ID4+PiAjc2l6ZS1jZWxscyByYW5nZQ0KPiA+ID4+Pg0K
PiA+ID4+PiBPbiAyMC8xMC8yMDI1IDA0OjA3LCBSeWFuIENoZW4gd3JvdGU6DQo+ID4gPj4+PiBU
aGUgI3NpemUtY2VsbHMgcHJvcGVydHkgaW4gdGhlIEFzcGVlZCBTQ1UgYmluZGluZyBpcyBjdXJy
ZW50bHkNCj4gPiA+Pj4+IGZpeGVkIHRvIGEgY29uc3RhbnQgdmFsdWUgb2YgMS4gSG93ZXZlciwg
bmV3ZXIgU29DcyAoZXguIEFTVDI3MDApDQo+ID4gPj4+PiBtYXkgcmVxdWlyZSB0d28gc2l6ZSBj
ZWxscyB0byBkZXNjcmliZSBjZXJ0YWluIHN1YnJlZ2lvbnMgb3INCj4gPiA+Pj4NCj4gPiA+Pj4g
Im1heSI/IFNvIHRoZXJlIGlzIG5vIGlzc3VlIHlldD8NCj4gPiA+Pg0KPiA+ID4+IHdoaWxlIEkg
c3VibWl0IGFzdDI3MDAgcGxhdGZvcm0sDQo+ID4gPg0KPiA+ID4gU28gdGhlcmUgaXMgbm8gd2Fy
bmluZyBjdXJyZW50bHk/IFRoZW4gZG9uJ3QgbWVudGlvbi4gWW91IGNhbm5vdCB1c2UNCj4gPiA+
IGFyZ3VtZW50IG9mIHBvc3NpYmxlIGZ1dHVyZSB3YXJuaW5nIGFzIHRoZXJlIGlzIGEgd2Fybmlu
ZyBuZWVkaW5nIHRvDQo+ID4gPiBiZSBmaXhlZC4gVGhpcyBtYWtlcyBubyBzZW5zZS4gTGlrZSB5
b3UgYWRkIGJ1ZyBpbiB5b3VyIHBhdGNoc2V0IGFuZA0KPiA+ID4gdGhlbiBzZW5kICpkaWZmZXJl
bnQqIHBhdGNoIGNsYWltaW5nIHlvdSBhcmUgZml4aW5nIGEgYnVnLg0KPiA+ID4NCj4gPiA+DQo+
ID4gPj4gVGhlc2Ugd2FybmluZ3MgYXBwZWFyIHdoZW4gdmFsaWRhdGluZyB0aGUgQVNUMjcwMCBF
VkIgZGV2aWNlIHRyZWUuDQo+ID4gPj4gVGhlIFNDVSBub2RlcyBvbiBBU1QyNzAwIGhhdmUgc3Vi
ZGV2aWNlcyAoc3VjaCBhcyBjbG9jayBhbmQgcmVzZXQNCj4gPiA+PiBjb250cm9sbGVycykgdGhh
dCByZXF1aXJlIHR3byBhZGRyZXNzIGNlbGxzLCB3aGljaCBpcyBub3QgYWxsb3dlZA0KPiA+ID4+
IGJ5IHRoZSBjdXJyZW50IGBjb25zdDogMWAgY29uc3RyYWludCBpbiB0aGUgc2NoZW1hLg0KPiA+
ID4+DQo+ID4gPj4gSGVyZSBpcyB0aGUgcmVsYXRlZCByZXBvcnQ6DQo+ID4gPj4gICBodHRwczov
L2xrbWwub3JnL2xrbWwvMjAyNS85LzIvMTE2NQ0KPiA+ID4NCj4gPiA+IFRoaXMgbXVzdCBiZSB0
b2dldGhlciwgc28gd2UgY2FuIHJldmlldyBlbnRpcmUgcGljdHVyZSwgbm90IHBpZWNlcw0KPiA+
ID4gYnkgcGllY2VzLiBPcmdhbml6ZSB5b3VyIHdvcmsgY29ycmVjdGx5LCBzbyByZXZpZXdpbmcg
d2lsbCBiZSBlYXN5Lg0KPiA+ID4NCj4gPiBBbnl3YXksIEkgbWFuYWdlZCB0byBmaW5kIHlvdXIg
b3JpZ2luYWwgd29yayBhbmQgdGhlcmUgaXMgbm8gbmVlZCBmb3INCj4gPiB0aGlzIHBhdGNoIGF0
IGFsbC4gWW91IGRvbid0IGhhdmUgNjQtYml0IHNpemVzIHRoZXJlLg0KPiBUaGFua3MsIEkgd2ls
bCBrZWVwICNzaXplLWNlbGxzID0gPDE+OyBmb3IgbXkgbmV4dCBzdGVwLg0KDQpIZWxsbyBLcnp5
c3p0b2YsDQpTb3J5IGJvdGhlcnMgeW91IGFnYWluLg0KQWZ0ZXIgY2hlY2tpbmcgdGhlIEFTVDI3
MDAgcGxhdGZvcm0gbWVtb3J5IGNvbmZpZ3VyYXRpb24sIGl0IHN1cHBvcnRzIHVwIHRvDQo4R0Ig
b2YgRFJBTS4gVGhpcyByZXF1aXJlcyB1c2luZyBgI3NpemUtY2VsbHMgPSA8Mj5gIGZvciB0aGUg
bWVtb3J5IG5vZGUsIGZvcg0KZXhhbXBsZToNCg0KCW1lbW9yeUA0MDAwMDAwMDAgew0KCQlkZXZp
Y2VfdHlwZSA9ICJtZW1vcnkiOw0KCQlyZWcgPSA8MHg0IDB4MDAwMDAwMDAgMHgwIDB4NDAwMDAw
MDA+Ow0KCX07DQoNCkdpdmVuIHRoaXMsIHdoYXQgd291bGQgYmUgdGhlIHByb3BlciB3YXkgdG8g
cHJvY2VlZD8NCg0KVGhhbmtzIGFnYWluIGZvciB5b3VyIGd1aWRhbmNlLg0KPiANCj4gPg0KPiA+
IEJlc3QgcmVnYXJkcywNCj4gPiBLcnp5c3p0b2YNCg==

