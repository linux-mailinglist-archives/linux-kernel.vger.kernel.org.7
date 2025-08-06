Return-Path: <linux-kernel+bounces-757256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9CDB1BFED
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 07:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB91F3BAFD6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 05:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E111F416B;
	Wed,  6 Aug 2025 05:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="AgwMTj+W"
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022104.outbound.protection.outlook.com [40.107.75.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1DA1114;
	Wed,  6 Aug 2025 05:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754458149; cv=fail; b=Jd4BPjLCvD+xAEOQEV65x0IP/OetCGHVj4S36dUFKso4tGO9kmfAfMWntSbZEEqsUeykXA6wbC5Su40kP2u250dZ0kM7I9UfnTz55scUdbcL7VkuzPPtBP7JqW/3xRmsO6wL3D5YwPXra0lKmEe7CKK5NBLxvFNrcQjrKTOk7wU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754458149; c=relaxed/simple;
	bh=87BNvRiAdS4Fizpni9I64yQcm30fBOgBSRQDqdMmUkY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rBZRex7v5NIbHi067aeFG3Z2pn4IG5WhnbLhd+YCrx4/Dt4LLoeFqCOSVHG2TCC9U/wecCJgbKivKtstjYOd0VTt7/tOm6WJdb7FDciio+sdyiL6TTembSfUXhiRYWPXJV2DL5eqwJycZ+IHKL1l6coalvQHqJrhAZqkM6DOcIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=AgwMTj+W; arc=fail smtp.client-ip=40.107.75.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PlPT5c7yoQZLTOqcBn6ADgOS/pYsPHNn7RCWfwpFoOMamugB2Wrru7z5T/MC6toNjPg4CZ12N2g0dU2crW3+YeWNlB6EjtR81J7Rz3hb2/xKxkI8t+B8zS8ibXWYp4MWPBEa5zZkXAK1XqdsgfK8fMaAFokO/YmT5PpEGvlhRYfrr0GpXL0VZoR47ns0kbiEbeS99A1BHmk99n651Q+5adP/bQvUkzKNGrTQhOtPw34DwDkzf8AJWEmFS7jjUV6vsHcCy8zMjiCO2RTVp6R2eXShBb7eyg/F0p8gQz1MDzJzW+dE2xBLg12ifVhx369W4KlAPvvxfl+LIvJ+P5MUKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ajEWCkfkrNwFKGSlzfURYMOwPUkQHHFcwjKKSb4R6M=;
 b=WkYmej8WWEG3OlJk8qzgPMB0N+rX9PyEn/4mWgTGg0rlu8dZr8m1dVWGT8H2/jiI7yBmMHy/e7cj/VgQ+9/NAWPwd4NoULsnUW8heoNccJ9McmOfMAtQHziAM8+FsgwkirdWVLAMAvlXir4Dq+Sdli0fP28pP92Z7LyQaWqvvp2r2Y/+YnFQy8NAZipf0IqybYL4841zE3crYoqMj97dphiQl/eBXDYo0xfsMmNSPN2xtocIXa9YikJXME210kckOFp6ZlT1xoxkTU4t41ChxwWX5ZSwzsMqjGHbnMZuoLvmal7c1d4qfMz1hhBJtp6WZ8FV47ld59jAeX9BA4QPyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ajEWCkfkrNwFKGSlzfURYMOwPUkQHHFcwjKKSb4R6M=;
 b=AgwMTj+WuAsCVFsuswNftgXJ1N4jZFtTDL8gRqWO76KZW6Fk2IvgpAjeQWyunRQvw0Js9XFcXQFoVLPG10GdAgLvETbEObM2MTmdJJeoVJFx3f2hT8qfV1sFtoMOfPrGnqitvikX3/c9BeY5fT2tupL+ahYksR2cO5btsiRnTzWPb4Rv2Ld8Day68NUyAk/U4tEnshPvMuSKDY6D3QyIYCmYIKE86yOLQ4r12m+uHHl1yL4ffpGU6HbBgTuHTY9bZIsgu51AquQZ06WvB49FCsWLVp1e85FDEhigMsAgY8EEywJi3r40GhNI5EGHpm9mGgUtsaKjdAk2+F0RigEHSw==
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com (2603:1096:604:2b1::11)
 by SE1PPF675EC9542.apcprd06.prod.outlook.com (2603:1096:108:1::41b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Wed, 6 Aug
 2025 05:29:01 +0000
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11]) by OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11%5]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 05:29:01 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Andrew Lunn <andrew@lunn.ch>, Mo Elbadry <elbadrym@google.com>, Jacky Chou
	<jacky_chou@aspeedtech.com>
CC: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
	<sboyd@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Rom Lemarchand <romlem@google.com>, William
 Kennington <wak@google.com>, Yuxiao Zhang <yuxiaozhang@google.com>,
	"wthai@nvidia.com" <wthai@nvidia.com>, "leohu@nvidia.com" <leohu@nvidia.com>,
	"dkodihalli@nvidia.com" <dkodihalli@nvidia.com>, "spuranik@nvidia.com"
	<spuranik@nvidia.com>
Subject: RE: [PATCH v12 3/3] clk: aspeed: add AST2700 clock driver
Thread-Topic: [PATCH v12 3/3] clk: aspeed: add AST2700 clock driver
Thread-Index: AQHb78lA+IAukcGqZkm+EFuCwOI247QpWPIAgCuzSYCAABGMgIAAJ8CA
Date: Wed, 6 Aug 2025 05:29:01 +0000
Message-ID:
 <OS8PR06MB75412CE3A7A3DB8E6D6A1A55F22DA@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20250708052909.4145983-1-ryan_chen@aspeedtech.com>
 <20250708052909.4145983-4-ryan_chen@aspeedtech.com>
 <OS8PR06MB7541E7FCB367AE610EBBE121F249A@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <CAOO6b=tEigCRXZ47BMgsTvxiZdO0P32+jFhQ313O044VALgaWA@mail.gmail.com>
 <e53edafb-bfb0-45ab-8224-7b393af4e0ad@lunn.ch>
In-Reply-To: <e53edafb-bfb0-45ab-8224-7b393af4e0ad@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS8PR06MB7541:EE_|SE1PPF675EC9542:EE_
x-ms-office365-filtering-correlation-id: 5d22ba08-4f46-4871-82e5-08ddd4aa26c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?eZ8bxxUaNkuUGIYN9NvEZozVokZR0EJ6nmRF9aj/N04hJ0bqypo7LUV3SNzE?=
 =?us-ascii?Q?DU5uB6yaO0iqE3BMkjnxvEpeflYS1o7Ckmf25T+7hfJNvH1Je5+6gS/ZcHo0?=
 =?us-ascii?Q?QcB1uQgB9K6WEypdIVE7/yvYEFBnNtUVuA1wp4v0+hxzMPeAVeJzTDrShTuQ?=
 =?us-ascii?Q?GqHVxc8FlqgSYqsjGN8gn6c1b7KwI8rBfipgNo+urW6h5foBI3b7A1xoN9gN?=
 =?us-ascii?Q?VljSUR56TfBG2vj7ALUo6zpM9hd9U7H6qTDrTGFexhxJ1O67q8/5DAOBiWYc?=
 =?us-ascii?Q?viEzcT9hYefLjJVAntpGxd48RPAeVGS78BENKRSToXVTdtiaGxoPFSa33BRo?=
 =?us-ascii?Q?k8/sbtmuu+YgF+uCK1m1IjESYlRyXhEFbztnlGUjnIWT2XL11baDnPXwHTkU?=
 =?us-ascii?Q?S/lPlINr7gOtX0IraTNHZ5oudT0t/9EzjMdtYPLqLIsYC5jvcJ72PWECr0qw?=
 =?us-ascii?Q?1ACCaFviNCLOmSsU77601XPS/pEcmfp5U4Ay5LNorH28AkQbYcaQu4MGwYrM?=
 =?us-ascii?Q?FZvJPeqHm7zxVeIh8Q5J8qsfiTtr0bV9PT4Lb0BOoWAuJDQPlsvnZf/WI5E9?=
 =?us-ascii?Q?YWx2XkVNycVCw1n9OwjII9ET9KejGCMDwXHNpGc/QMbA0VjgpF9rB8pZyNjq?=
 =?us-ascii?Q?5nlRmZhR7y3kmxzcjdhUYrqb2IpLhf+8oHTaKAGXkHPFP/Cbf9tFsz8nITaf?=
 =?us-ascii?Q?ZHs/4MlkrVtRr4LSXyFz35LtxkSvR/IP5DzxpdjZfqV7thtk5oMIsO9Tp9DR?=
 =?us-ascii?Q?6ONoOkWvb+uEGDeo8L6OMD7f2mWJlBtxEAQyJf4JwK/47p4kbYZmJtZySm8q?=
 =?us-ascii?Q?oXsCFbXgNOZaQLl1R0n3QcgP0Ab9+SQbapjCUFrHd77axex6Kp6vPEwiBzT7?=
 =?us-ascii?Q?P/2Z73tqaxtJx3nsRV1X774SsGcSPymWinFPGFHlmF78TKH5AV7KfJasf31P?=
 =?us-ascii?Q?aAflU2nKYnv199fzT5niafUZNNjBV3gYbI5Fz31E/88n3IXnmxKzdJI/Q/q9?=
 =?us-ascii?Q?W1IYEDRTkWKfeyE4iH6HzTXk3A8q89F4ExDD8mpkyveSlRDsEy7LY4g2X73a?=
 =?us-ascii?Q?TnrUMxYr5kNeXNw66OBeUpw+YKrjgqNephZDP8MAdekzJptvHt1rErpw7+mE?=
 =?us-ascii?Q?OfcUFikH0XBhLH01iImcGfYMPmZJ9acrTsdCFJEIQxv5wHkI1JXb7VgMCRDC?=
 =?us-ascii?Q?wQ0B+3HxUNsGnYc574Qh3COQXH6oc9TfmYZN+dFeoztzLxiSzSqMcfifo0/X?=
 =?us-ascii?Q?c04yu5XKDNudXus7c0ZuHHO8RNX91O4wCJPNt2LDZOTb6fds/Oll+Y9Trp2R?=
 =?us-ascii?Q?sFOZok/CW1JObv/XM9orrBwyMmn2/RolR96LOoVUqATTknP29Usk93WFRLem?=
 =?us-ascii?Q?QjxItV03vdR9o51y7pH8AFglB/MVvrViDK08PY0exjaIed5dNrbX/CL6hvbd?=
 =?us-ascii?Q?4V/PZPCyVj81f2+RY6RNqMI8+DtIF+lNznYhXBk9Fk8lehfAW0AWsg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7541.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?gYSZV/MpOx9yxAvqCfMAsb68AEOP4CGY4EOJY28X7zwvyP9qA7OrAGprJVaY?=
 =?us-ascii?Q?keG3cXIwtasQwKteITJd5vXx+KMQVbAgYfVEwtQkkGx4jDqDKv6IN/BN216m?=
 =?us-ascii?Q?eEniymkleRw5b9lpvbJ5qFsOiBJcGgvP4UKrpt6iR41JCkjcyZ7aphHeXW1e?=
 =?us-ascii?Q?vb+s9LYeAjh1ZutFq7zXw6JIfpW9x6Dvz/IQhp7fI64QfRPM5LaV+nfDyOOa?=
 =?us-ascii?Q?L3uASrU/pW3aHlugaTBcQjXOlE825xjPUg48YTIsOv9B2ma04/23P2+KLWf+?=
 =?us-ascii?Q?weChezz++O2/iqpNV3c6+CzoyxGPzNVZYvr//nBRtQXGTJBeJim9zvi2+9e3?=
 =?us-ascii?Q?Q/oCe4vlji5x5H7r2qrdhhbVsfBFS9gYWTMDp7JQ/BhwIAvNPLkqoqMa1ROu?=
 =?us-ascii?Q?iL/znryUHj3tgl5tG9xZQ4uGnhjQpxdcsYzMc5F7w7jv0iSZdVfDyPt5Iz3/?=
 =?us-ascii?Q?PzL0T9Rl6g/ZUpnIEumDUciOs2S3UQyzJSwPEeCAWHFQhwgmyrcT8e3docbH?=
 =?us-ascii?Q?Q/OV6vwsg1h30SkimMBNKOC9RI7RGehJpOTZnlWAh12TWggr6D2dCZMarx2z?=
 =?us-ascii?Q?DNcJQb4DJhyeXj6xFbZXRTZRMNR6W0t6OwxIFomtSuG02U35r+bUp/DeKYRj?=
 =?us-ascii?Q?kbkVoJxgJKJVuUnNg+I6cJaIbbBt7NM5gB1E9V2aJiUWytuYJhbb3Q4JZ/sM?=
 =?us-ascii?Q?mcJMjLUzAT3S0SfBP7kc4qauMgt2qcJLPfuYkS1/QCC1s+C7HLazo6fLLoDr?=
 =?us-ascii?Q?FTlhPz6JzVqBfx79Fagt++0g/uQrccyBsgckk1Qvwsq7th0o6Ji+wXs6mKsf?=
 =?us-ascii?Q?WL7WfC6QAtP8PdFWMdW2up5sCqYXPlYndYcmjyY+YVwsuGHP5aW89mAIkZzZ?=
 =?us-ascii?Q?jVkIkMZa1qJboyWXTwwiYnikIIcUWnwBePcf6objrmpHwXuol76qNxtpP1lU?=
 =?us-ascii?Q?K5Mrmudp2euwWeoCb8xHeCvYKm5BahAtUjmTPhE2Mlhsalep7vqHK6hMZgFy?=
 =?us-ascii?Q?XPVSwq5RCrllVDWeP7PvGVnmD8BLHcffnGPiRvdNS43X7JlqKTdh426CFxVs?=
 =?us-ascii?Q?DABt0DFvf8mChMyfOJ5H58n6u/T9bxdpfTbivSHdwhGYl2HXPwTctjIi/7qL?=
 =?us-ascii?Q?HgiC3AgrDeQ7y1pGJZD3jpOiN5/wbgmyHsyZjH8KtscDsaqOyqyiEuynLPTQ?=
 =?us-ascii?Q?hQv1yjMBZQGF7S0sftoR3ZdxMVF1bVP6nWV89l+4QJn/lu/xvBa+eQi9Rouu?=
 =?us-ascii?Q?wiEfFR3jta+fZrYzNjO7UhgH6+sOsSA5Dq5JFfJzEUSO/f/5K/A09606umAJ?=
 =?us-ascii?Q?eSQMJoxVhx2Bp06T4SuGg7XeJqiWmUXUMGb+lz9GecAaAV9/xXfn3vcNcZLO?=
 =?us-ascii?Q?pMUimf3H/0pzeViL3qACgnruwUwnGICDJN/wA1u8iLxkq8/8fU9y+WvE3Tyu?=
 =?us-ascii?Q?2Itcb7sfaGXzH+K878bmMZ5kx5Md6Goar6ELBUS6Obt/dzw09iBVklsq6NsA?=
 =?us-ascii?Q?MLgD9VNP1kEoTEF9CDeQZt7Vz0d015ojSlwulkumdmhX5H1UetTk1zcP3FRx?=
 =?us-ascii?Q?3fQFWDUfQbN9QafCSa6AP6Zzv1TdRdcgroB5kxOE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS8PR06MB7541.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d22ba08-4f46-4871-82e5-08ddd4aa26c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2025 05:29:01.5870
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DP4oAwGRubtvf1MkEuHqb8U8Bypz/CrMlTy9SE70T+NJb9uFA4YpMKhj4MUZpiYwU+IxadZogKjhO8Rt/D0jJy2KignMj9wIAVAMqn+LUCk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE1PPF675EC9542

> Subject: Re: [PATCH v12 3/3] clk: aspeed: add AST2700 clock driver
>=20
> > > > +static const struct clk_div_table ast2700_rgmii_div_table[] =3D {
> > > > +     { 0x0, 4 },
> > > > +     { 0x1, 4 },
> > > > +     { 0x2, 6 },
> > > > +     { 0x3, 8 },
> > > > +     { 0x4, 10 },
> > > > +     { 0x5, 12 },
> > > > +     { 0x6, 14 },
> > > > +     { 0x7, 16 },
> > > > +     { 0 }
> > > > +};
>=20
> > > > +     DIVIDER_CLK(SCU1_CLK_RGMII, "rgmii", soc1_hpll,
> > > > +                 SCU1_CLK_SEL1, 25, 3, ast2700_rgmii_div_table),
>=20
>=20
> Historically, aspeed has got RGMII delays wrong. Could you confirm this h=
as
> nothing to do with the 2ns delay needed by RGMII.

It is nothing to do with this delay cell.
>=20
> What exactly is this clock used for? RGMII needs 2.5MHz, 25MHz and 125MHz=
,
> which none of these dividers seems to provide.

It is RGMII clk source for MAC controller.
The clock tree is hpll-> div -> mac rgmii, and MAC controller will generate=
 2.5, 25,
125Mhz depend on mode.=20

>=20
> 	Andrew

