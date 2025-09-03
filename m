Return-Path: <linux-kernel+bounces-799375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B72B1B42AB5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 22:22:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E8993B204F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 20:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902CE3680B8;
	Wed,  3 Sep 2025 20:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="esXHmK4D"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012051.outbound.protection.outlook.com [52.101.66.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C28E36CC77;
	Wed,  3 Sep 2025 20:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756930831; cv=fail; b=ROu9mXcXsLUlX9dQgbahUJ/4TPxa1WKOUjtlT8ksjZWWFXIQelQga6BLaNMamQ9ZHFbE0txZeD1a2gStbqu1UHWkg9WwtRcsKHNiXozOJwykPiqbgcGguv7glUtNg7FkzhM5EJxNkUyOBjpMJ1mUtZxC5y2y6z5b2ujbrm1BXGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756930831; c=relaxed/simple;
	bh=dXStnozcL1VqRatql/TwcyZyiTEMroLT4GIViniXOYA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=qfxQaAEudqepcjilKHLYRftJDeLzDyIMfgjGmSSQXh7MWOIdxJDKOh91rdppcwsZ7v9B8KGOTv8nym5e737UUYCd7SID1X+xWDFXt8QKuojIDtFMLYUhmbDGiC76zZx4T9+1VcaK1yoJpb7B8xkn+LcKzZ90WT3Jg3lPmoRMdIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=esXHmK4D; arc=fail smtp.client-ip=52.101.66.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GLJZ+NJKu+XEjAhfFk2mzLoCszoPjYD8iy/KK7r7kK3AX6T+20pUREz5C+4C6myzykWf+8xculJTyBxUFBkqbmw5ZSH+ZpBEmfCgiPg+JkyZ5OzOXFNn99ubugVc7sIQ1dVBKTxx2ftQ9JyXNSZwpzYeUUXGiVE5VkrtmDviK4JH/rUyiSStk9TTF5YEtAlSyuL1wuh3tXu21z0Vku7vZxf4+SA31U1+q0Mgji+ZVxU3Be2muUk6/nEW96lcJOo4rpoIpJKva+XnJoMuXVRCsCg08lLkpUXuFPOk5L4wNlIJsw6wD8Yq8ChrWoGy5F11GypTyjhpP1yXjR7qHLX6+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZW9AuIvESOokkBVdJiwuDpgrQu/Ps5dBCWXVSh0GfgQ=;
 b=bAKlSUo0koVrUd3TEd9CB2SRqaYAlyJU6cj98s4tW4pAByxc+kO6TwuZeQBFi6nRVslJEgPtReKB9xBuAN3eSQT9bHYhSfqiL1pe8v79GYduU2gNvTZb/aTr0LAUt26/ta2VAlbhGIHD1Ft8mVbE5eMaxHZq6ixaxQFW1a0EJeCPGX4eA6kEHablY7gZSppkx01Qko4aglcHRL9T3oCszWIPcc1SFuLtonRr+tuS7/TN6XPT5mIAIfk/93RKQBQGKZdVH+jkQuGwXgvlY21kmwe/kv0rsgb66YRqHaphC+gov6IB5l54w+Io32wjOdvT1lHGi0sPb1+NIEqilz9uYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZW9AuIvESOokkBVdJiwuDpgrQu/Ps5dBCWXVSh0GfgQ=;
 b=esXHmK4Dkgn0yFZoI/q4cMmTdrICFBklaYBk43cuXfl4HiKHxDvR44QYwuQfqL4nvyJnIcbyaux3X5NvKcpD/R0E3XyTN24WWWDrDukRG28O8rQzTbPsJCOO0XG34o0YO5YPKGfCoPPbgInmL2BTG8BSr6blBIBDkA+ltvE4c91PnD9dmifvKGv7gEad0obbL5aCV7f/7+2dABryqOYIVlHBZj0dsM+px1iv8MVCaP4YUnGZvfOfPw6uPWZstlAkUWghBd0NyA2wwdaqUIM67nDrfZqqfOnOT3r4wLxE8d291BxyOM6kZP0IJ+oP6+OdbD/MEsy92K4jiGXYa0Cbzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by PR3PR04MB7337.eurprd04.prod.outlook.com (2603:10a6:102:81::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Wed, 3 Sep
 2025 20:20:24 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%7]) with mapi id 15.20.9094.015; Wed, 3 Sep 2025
 20:20:24 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 03 Sep 2025 16:19:59 -0400
Subject: [PATCH 06/16] ARM: dts: imx6: remove redundant pinctrl-names
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-imx6_dts_warning-v1-6-1e883d72e790@nxp.com>
References: <20250903-imx6_dts_warning-v1-0-1e883d72e790@nxp.com>
In-Reply-To: <20250903-imx6_dts_warning-v1-0-1e883d72e790@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Russell King <linux@armlinux.org.uk>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756930807; l=4532;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=dXStnozcL1VqRatql/TwcyZyiTEMroLT4GIViniXOYA=;
 b=uu62tU3x8qOWUXr1a7UI75BqIHIignzjdpJrOiWb23eqpx14HZPihpCaxzcAQv3QOJsdzGPXh
 I3f+g+iP9/4BBlCchHpn02o91xDyOTFiyfgONmnjV5Q+anEVDsSDn7V
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: AM4PR0302CA0016.eurprd03.prod.outlook.com
 (2603:10a6:205:2::29) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|PR3PR04MB7337:EE_
X-MS-Office365-Filtering-Correlation-Id: cd5bb799-7bf6-4562-ec83-08ddeb27506f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YVNSL2NxQnQ3ZXNuQVRSV2FYSWl2cS9JcjZmZHozaCt3QmdDVHFYNVF4Unk5?=
 =?utf-8?B?dlZOWFdZSW5sQ045RjVaUGFwa0VnZzdzSUl2WTEzWm9zcmFDNThjdFJCMStR?=
 =?utf-8?B?bDNtd1JBSjV2Slk4UE5rSkZ6RkhWaHBtUnN4cHZEUHBDQ2xwcW5XYlFKVEJk?=
 =?utf-8?B?NjhxY2RXOWJLZkwwaGsxMWdzQ2ViZWxnaG9NZEhJM3ZVc0M3cXUrWFY2S0gv?=
 =?utf-8?B?UzhZb3BjVmFZamZPREhNSkVnMDVuYm9HczJ0UGlGelNVZVR6T2puZzVjb1VV?=
 =?utf-8?B?NHhnM1Nvc0E3RXcxSDFPZTNHUmtnRzBYSGVxVHdUUWNUNkdzS1E0eXJsRllY?=
 =?utf-8?B?cGc3OXdsck5WNGorMklDQ1JmSzF4enZINWJpbk1xbWgxcUVOOEd4VmpPUTdT?=
 =?utf-8?B?ZHI3c3RNZVY4d04yMEVLb0JSZ1Z4bjE5V3o1WFMyS0RpdjYvR1U5UEVTT0gz?=
 =?utf-8?B?emk4Zlp5c3pMV2NVa0diV3dCM1YwVjlTWlh2Q0pMRTN4eE52d0hUTkQvY2Y4?=
 =?utf-8?B?MUE1Q3JqcTJ6U0I5NlRmNXZBU09BZ3VmQWp6V0szUVdYMWlUSTIxMms4dFpZ?=
 =?utf-8?B?dXZ3blZ4SFVSb2VnS1FRYmVvV1BmSGZqMlVHM1B3aWtOUnRqdnF4UlVqL01u?=
 =?utf-8?B?N2F4N2xyUmt5SElwQlRobFJZNlh4RWh6amd6VFdJNG14NXhNTGhmRmMzcEUy?=
 =?utf-8?B?bG5qTllnLzZsSDNLTFhmbmZsQTF4N1g0ZTFpbzk4WFQ3YzliblpRMWl6aVJ0?=
 =?utf-8?B?L2FJMm1Sak51TEpRWm1NVjZCK1RreTNpMks1dXdOM21FNThvU2Z2MFpEc3V5?=
 =?utf-8?B?R09VSFNXcGpFR0VOTnpadkVXMSsvV3BtWEZiR2d1a2hhL1l6NzUxSzFIaGhF?=
 =?utf-8?B?Q1NzSDRpT2Nha3M2K1dyZU40QUxmcG01YjhtK0RiY2J3RURxeHhWdmQ3bzls?=
 =?utf-8?B?Z1VMb1o4TXhNbmhyS01ERDVlRTV6YnFTbGt2ZkMyMkhwdXVNRFQ2MzRYaEFD?=
 =?utf-8?B?NXArc3M3dE9keUpSMEh4NlZ5VU0xMUV4enZLWHNzRjdzdGJLdUlJSzhtR0pw?=
 =?utf-8?B?QnhocE5VSGVNMDg1ZTcvSWFDeHVNbUs1UTgzM1Y5N01LTzBzM1hiUmFqaThJ?=
 =?utf-8?B?Y1dKd0tnSkdXRnZ4RmlhWGxYbFNJN2NWdjN3VkZaUnpTMjF4UHZlTzByNVRW?=
 =?utf-8?B?QzNYMk5XNmkvbzVkK1BFRTBnbHJNaGlJSjRHcTcwVXloYksxQXY3TFlSdjU4?=
 =?utf-8?B?c2EyQlRpWGxzNmhwZ1JybmE3eFVNSVhHblo2SnNhN01PMmtudzZRWDA5VEJB?=
 =?utf-8?B?ektVUFhrQzNmNXhha0dSbVU4ZWRyaXBxQ01FaGtreGdqajltMy8xN2w2TnFh?=
 =?utf-8?B?SFBvd0J4dkY4Z0tqYnZVNU44L3NrQzlsRnVSSGRrY29MNG9ROUJZdzM3c0ZR?=
 =?utf-8?B?c1R2K2NxUTN6YzlEY1NpdU52bURqcGNWWjBTOHlMWnlXUGtQcVA4M01iMGJn?=
 =?utf-8?B?aWdJMm5RWGdsVGFWbndyOEpBWFprdC96ZFNJVTdNYjlJeU5pbW1EcXZCS2JH?=
 =?utf-8?B?b1drY3JtSmEyWjB6SXFUS2VkWnhoL0EzYlh3TSs5azBiZXBpRk5XK2EwUS9p?=
 =?utf-8?B?QmJQd1llZlFwZUFaeElhN3VrdldXSHoramFmU1RicXFEQXFaVUVscEp1TzYv?=
 =?utf-8?B?Vm50QTNGZWdlTGZ5MGFIejZ0SUs3TldrejlTZ3N1V2FvN3dXM2FjVXBTc3ZU?=
 =?utf-8?B?TldmU3puSDFzdkxyNVBGcTgxcDlTRTFjYzNlZEpyRWtHY1NkVE9EVi83eHpZ?=
 =?utf-8?B?bGphanMwV3JBc2hSNk8rOVZET2tGd21qTy9DRWxTRUtEZHVuekkyYXdCMVJl?=
 =?utf-8?B?cU9HUHZmRzJvRmxyK2ErWXF3V25ya1pzUTNiNklUVjlqMXJQRU5JeHpZeXJZ?=
 =?utf-8?Q?rFHKKrqYUvo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QUFMSUc1Q2VSK3JlSVpxZzc3c0tsMG1mcHR4K3FDaDJtS1lnL3FiMDA1dnBW?=
 =?utf-8?B?THhmRVJtVjdCOTNoOGlJS0lQTWM3V25FOHJReWNITDhBc3hCR2lHQ0tpMnhW?=
 =?utf-8?B?UENRZ1ZWMm54TXZJWkdybEJWSDFwT0owSFdxYnV2MDI3d1NoVHhXaWJnMDl2?=
 =?utf-8?B?Yks2a0JkbVdqanNXZGM5akNQeTF2blNydVVNNCtMZEx6dnc1b2xPcDBaR0F0?=
 =?utf-8?B?UksvazRBSEFPcTNraTNRWk5POUxJcEZldTZaZUhYZDhDM04zMHgzS2dPanEr?=
 =?utf-8?B?YUNVdlBhL2hhKzhJRDJBa210UjNmanZlUHR3SktieWd0MDVKazk4cjdTM0g0?=
 =?utf-8?B?all0VG4rMjk0YUtFK3Z1VzBrQTRaOG5ZazNqOWtDSHhJeHNKSkpndU9seTlV?=
 =?utf-8?B?cFBxNTJYYzA5MUZOS2s0TXBKWnJoRlMxU3FrSGNyb21INEt2QlZaYW9CRXZ3?=
 =?utf-8?B?d2NvRnZRajFCMWUrNFByWHE1ZGNjb1dYUTJrU05GWndyOXRsUjdqOTR2Vkkr?=
 =?utf-8?B?VGY4bEhTSUFJd0gyKzROYTRJMmRyb1I5Nnh1enNEZGNRd0x2UENHaTFkMTZn?=
 =?utf-8?B?YUk4ak42em5KQlFOR0tJWWRTOWFuaHBuZU50eGh4NHRDRkxJSGJubzRJNm5m?=
 =?utf-8?B?cDE3RjRFQTZmMlV6UmdJYjhNSFhXeUhjL3RyRFpvcE5RSEdLVUYwMXVPMEw0?=
 =?utf-8?B?dVYvam80a1V4K0s2Q01uaHlSNGlGNkcyYXNuTXJkenFpRTl2bzBHbFRHbHhW?=
 =?utf-8?B?aldPYnczeDhCUFRLUS9HU1N3ZnVTV1hYZ0xwUGJTSWQyYTdHTnVFSTF0cEZU?=
 =?utf-8?B?cTRCT3ZBMTkybGJRdTRmRE1DMzdoYVpHRmd4OTBCMGNoTUNTQVFWWnZXSHk4?=
 =?utf-8?B?UFlhOEpnREdNaGdmWEhPZUpub1VBOHpRODVTL2lPNy9PRjllSEJGZlRIdEEr?=
 =?utf-8?B?bU1xVytReC9RNUEwaVZPc3l2cWFVMTFMK1VEbDBYMWY4RW90Zmd2enNhUHZh?=
 =?utf-8?B?THdWQVM3MVM4OGNTZ1c5RitpZWl0RmJ0THJnZVlsVk5iS2tFOG9mZlVKbU16?=
 =?utf-8?B?NjR0STlnVlowQlFVcXZ4azBqQWdmTjR3ZE82ZWtOOFIxTWM0Zk5QZ0djWDRy?=
 =?utf-8?B?NmlPSS9PeFN4VzgyL2pMNU5rc3Bnb0d3V0NoN3YxTnc1MVdlSXI4UkxSK01j?=
 =?utf-8?B?cTFHdUFmOEptM3l3c1F6b1BxaEl6MXRMaWNZenhMQzNEcC80V1ovSmU5c2tl?=
 =?utf-8?B?Q2pkR0owWXFwZGdLc2FsRVJUYkNvbUdhZVdqQ1dmNTJUa1p2RllWZ3JOMEdx?=
 =?utf-8?B?V2FBMndpZWRvbDRFL3ZIR0VldkpUL0FHNTQra0Mxd0pGUWxFVmcySGlkQWFn?=
 =?utf-8?B?RVRoQWFON3ZxZ1VkNU8rcGlyak13V0x1eG0wd253YU5QVnhXNHJ5OE5zUHdS?=
 =?utf-8?B?Rlo5NlBvTVVoV3NNYmdrZmp3Sm1XS2NBelNYeWZLMGRSa1RIY1B5eVR6cGJF?=
 =?utf-8?B?MWxoYU01RWF0TDFqSEdzaGMwdjltNVBMcVJtbHZLVmd5S3BGeDNJeXR1TE9Q?=
 =?utf-8?B?QmY5eWlyS09iVHBPMkFNeVMyczFxeVk2UFp3R0tKWjhaUjRaTHF2OG92dURz?=
 =?utf-8?B?aWdBald2QVNLZ0orWkpSNE94WUtvVC9lVEZkaGlNNjdVdTRHZW9RSnI1K3JE?=
 =?utf-8?B?UmpyVS9MdVREZUNwOU1RTGNqd1R2OGkvK3ZITGdONTNMYXJYcGUvMVU5Mnll?=
 =?utf-8?B?NExMVVR5YUpBcjdtbnA5cTI0NEdLQzZzeXNQcWlsbENkU1lqblZNcHlyYkU5?=
 =?utf-8?B?L2h0VHlheVNCRTIydGl6NXR5ZExBRUUwMjBIdHpJV2VsQjB2MHVHa21zeTE3?=
 =?utf-8?B?cms0cUFzV3lqSEtXZ2VxUjE0cXhob04yRTk5T1dBUCtSNjFqa1hiNFlsUkMz?=
 =?utf-8?B?b3pCczVQVm1NMy9rMUNTVWJkMHg1U2R6Q3FGVUFmTkt6WGdvaFI5Z0szNlpa?=
 =?utf-8?B?QnY0MW5UQk44RUZROVNaSllSTTlaSHdmRUNaM21ZTlEyekRpQjVMZ1FWOUln?=
 =?utf-8?B?L1NkWEY5VDlKWHAwcnp2MlNjUWt3WFluYTIrVk84WTFMMGl5L1liYWdFcDF2?=
 =?utf-8?Q?+LcaD6kuZ9M9Wg14OIbdk3EGd?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd5bb799-7bf6-4562-ec83-08ddeb27506f
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 20:20:24.3911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KXjkbmI36GnxiNd1YPXgccqqP8wbCgA0KSgP8ajAQ1MVzcISWyRQBU9eq0VbPUCKMgkeTkHxYK8taQ3exUyTkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7337

Remove redundant pinctrl-name because no pinctrl-0 existed to fix below
CHECK_DTBS warnings:
arch/arm/boot/dts/nxp/imx/imx6dl-hummingboard.dtb: pwm@2084000 (fsl,imx6q-pwm): 'pinctrl-0' is a dependency of 'pinctrl-names'
        from schema $id: http://devicetree.org/schemas/pinctrl/pinctrl-consumer.yaml#

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm/boot/dts/nxp/imx/imx6dl-prtmvt.dts         | 1 -
 arch/arm/boot/dts/nxp/imx/imx6dl-riotboard.dts      | 2 --
 arch/arm/boot/dts/nxp/imx/imx6q-mccmon6.dts         | 2 --
 arch/arm/boot/dts/nxp/imx/imx6qdl-hummingboard.dtsi | 1 -
 arch/arm/boot/dts/nxp/imx/imx6qdl-rex.dtsi          | 2 --
 arch/arm/boot/dts/nxp/imx/imx6qdl-vicut1.dtsi       | 1 -
 arch/arm/boot/dts/nxp/imx/imx6ul-14x14-evk.dtsi     | 2 --
 7 files changed, 11 deletions(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6dl-prtmvt.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-prtmvt.dts
index 0b1275a8891f796f5a2d694181e94f62be73cb1b..2160b71778355623a9f124975e2cd4dfba4be900 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6dl-prtmvt.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6dl-prtmvt.dts
@@ -557,7 +557,6 @@ &uart5 {
 
 &usbh1 {
 	vbus-supply = <&reg_h1_vbus>;
-	pinctrl-names = "default";
 	phy_type = "utmi";
 	dr_mode = "host";
 	disable-over-current;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6dl-riotboard.dts b/arch/arm/boot/dts/nxp/imx/imx6dl-riotboard.dts
index e9ac4768f36c2b911da8996669fa778f83a670d8..55b7e91d2ac051e05f176756e9ff212629e8cfbe 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6dl-riotboard.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6dl-riotboard.dts
@@ -389,8 +389,6 @@ &usdhc4 {
 };
 
 &iomuxc {
-	pinctrl-names = "default";
-
 	pinctrl_audmux: audmuxgrp {
 		fsl,pins = <
 			MX6QDL_PAD_CSI0_DAT7__AUD3_RXD		0x130b0
diff --git a/arch/arm/boot/dts/nxp/imx/imx6q-mccmon6.dts b/arch/arm/boot/dts/nxp/imx/imx6q-mccmon6.dts
index bba82126aaaa56642dffdbab4770b07cd87cefa5..ef5c0eda8b15c4afc77a535e09fc6b52d1ba7ef6 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6q-mccmon6.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6q-mccmon6.dts
@@ -292,8 +292,6 @@ flash@0,0 {
 };
 
 &iomuxc {
-	pinctrl-names = "default";
-
 	pinctrl_backlight: dispgrp {
 		fsl,pins = <
 			/* BLEN_OUT */
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-hummingboard.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-hummingboard.dtsi
index 54d4bced2395724071d9123109436b1dda4fba7a..6b737360a532a3a0fe61b05ce733645c01d566ee 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-hummingboard.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-hummingboard.dtsi
@@ -332,7 +332,6 @@ &pwm1 {
 };
 
 &pwm2 {
-	 pinctrl-names = "default";
 	 status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-rex.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-rex.dtsi
index 64ded5e5559c756a93da82db3ce6d779abebf97a..22d5918ee4d8a7326457da2d33f2322bc4f16bed 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-rex.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-rex.dtsi
@@ -23,7 +23,6 @@ reg_3p3v: regulator-3p3v {
 
 	reg_usbh1_vbus: regulator-usbh1-vbus {
 		compatible = "regulator-fixed";
-		pinctrl-names = "default";
 		regulator-name = "usbh1_vbus";
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
@@ -33,7 +32,6 @@ reg_usbh1_vbus: regulator-usbh1-vbus {
 
 	reg_usb_otg_vbus: regulator-otg-vbus {
 		compatible = "regulator-fixed";
-		pinctrl-names = "default";
 		regulator-name = "usb_otg_vbus";
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-vicut1.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-vicut1.dtsi
index 96e4f4b0b248f47ba45bd40986f45f33e0ce6a8b..de2b12dad7d8d5e6f11c7418b3b223401202949f 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6qdl-vicut1.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-vicut1.dtsi
@@ -429,7 +429,6 @@ &uart5 {
 };
 
 &usbh1 {
-	pinctrl-names = "default";
 	phy_type = "utmi";
 	dr_mode = "host";
 	disable-over-current;
diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul-14x14-evk.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul-14x14-evk.dtsi
index 911ccbd132cfb9c0c049608cbc16d1e12a5052a4..17989e6d82e6bef95d96cbdc3545eaebf648367d 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul-14x14-evk.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul-14x14-evk.dtsi
@@ -421,8 +421,6 @@ &wdog1 {
 };
 
 &iomuxc {
-	pinctrl-names = "default";
-
 	pinctrl_camera_clock: cameraclockgrp {
 		fsl,pins = <
 			MX6UL_PAD_CSI_MCLK__CSI_MCLK		0x1b088

-- 
2.34.1


