Return-Path: <linux-kernel+bounces-774669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7ABAB2B5D0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 03:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E03E1962BC9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 01:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41DA813B280;
	Tue, 19 Aug 2025 01:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kIPLp4rq"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010015.outbound.protection.outlook.com [52.101.69.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FF62110;
	Tue, 19 Aug 2025 01:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755566362; cv=fail; b=AyJAGpl01Qwo61EvuFNqtTq4PDCJc5xKLoknojqerqp4ucVs+jtRmUI9O4hKM6FgA48T/3yCGA6VZ1A3WLwpXlQN+TAxpuDhWgVMygf/x0JTZ4PQ/wq3j7SwYsrbsx+3h8emBimGZ+1D/QAugF1V92aGrgtPx1VaBJk3n2VXvrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755566362; c=relaxed/simple;
	bh=qL55Zh7nJi/IFjkXXcUaApui3a8wFTJJctppqvtuGNA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=e6CTtEDyfz6+cWX2eWwHKtrRgeXt5UL7P9hD9IZW5y/ZgkH2PLyQSdDlLFoqD3nCdYNF0oOwb/3KzEE3WKMjd9xWwaUqgRnSGI4ObmJkysC6aOgM3r6AkY6T/ReU6z+OAgbZrvaaFnoCvbU1CHBZYqodtx3GsqunBTjRZOy5Ch0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kIPLp4rq; arc=fail smtp.client-ip=52.101.69.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OhNA//yO4YvEby/njML7FS4/5bCnmoyVfubXSczSGn3zfAy3+gIf9pj/UYTI1zKAq0nznajTZ8qq1w1cELmvYy32PtEj1c/RV8va6zhdzJ94wHXDCQW0LOjgKMvVeyI9pHhIzRHa20owvjkrSF33hprl/DlH+l6t41WdncrjsJKqktDY91VmkjbMaHz4U/mz264KBSd02aL7sCRM30SGLp5XQlRj8mMPK/R2T7GhyrDlQTanT4FKoToOZ0cOSn5qWYpAmdO+2lmP48rV/P58nowi13Ts/5xBN/S2V5QaJ4NFFUZr4/2Ph4eKf8eQfG4yEpZsLvgbXKdxXAa81y+qmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cljtIQe/Xd/aKrTek2PcjTLp5wJt21Oraw4C7KX8T+I=;
 b=B2ImnivNU4NUQ67vHWSoc+6WwlP95M0Cvi79xs9um5fl109XtDw3sSF4lr9MGWgysKJDvmSYg6qoMXUBwKEObyxfU74RPK+bN/Cq/3EU7DMQPKMmB7tEZ2z62v2qZLJeiIh7snWjkJuDKbW7Pb5HTzw9or987ygwE0udY2K+OOLJwM1s7sngoZxc4klak6RsHUJFxUeJAExlsbs7CcRSH2Ht0UfiPf0bDs8yKuZa18M5Jc9VIlUwVTRAYAM1SQKvJkvSk5sDdVPInhZ/cScXnkWhkK2gb3zSORsaqoF9oi74XTmnCmcU15IFiFBTxa0Btlb5qPopNCWZghumK+ecqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cljtIQe/Xd/aKrTek2PcjTLp5wJt21Oraw4C7KX8T+I=;
 b=kIPLp4rqqxtAFOZiWGl71rnrI6e7ZxgA1lKeCEKtF5u7jdXLbd2nBTjKRZUVpWu/qCkNIu/Tb54bB5+2ZH6hm+ciHhnti+avgYLtxygqQ8Fvh5sAA8LYfok0qDMIwfeBe5R9eOBqVtRasXtWT2WU/+gOAzLI6IyYYD7xJbFUGJp31KK20ZnOB3LOCzFdIemzuCbl1z5iv54ISQYZmM7SRdGx/iECPtkFf7d8cTp8K8aNUhC+3Lpb9PF2vHvMq5ReoIcEZxdNe2AApIOSICkGWcWYCnvEJwPRkCGzvAy4RGl6IlJ93xqfdh0SWbOdNvfSyyK1PNqE9/6A6/vmDLfH1Q==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU4PR04MB10550.eurprd04.prod.outlook.com (2603:10a6:10:586::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Tue, 19 Aug
 2025 01:19:15 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9052.011; Tue, 19 Aug 2025
 01:19:15 +0000
From: Peng Fan <peng.fan@nxp.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Hongxing Zhu <hongxing.zhu@nxp.com>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Luke
 Wang <ziniu.wang_1@nxp.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Fabio Estevam <festevam@gmail.com>,
	Joy Zou <joy.zou@nxp.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, Sascha Hauer
	<s.hauer@pengutronix.de>, Frank Li <frank.li@nxp.com>
Subject: RE: [PATCH v2 00/11] arm64: dts: imx95: various updates
Thread-Topic: [PATCH v2 00/11] arm64: dts: imx95: various updates
Thread-Index: AQHcD98H/RVvj3k3dkG98qh30tWXibRouv6AgABzJ7A=
Date: Tue, 19 Aug 2025 01:19:14 +0000
Message-ID:
 <PAXPR04MB845987CC13AFC435D4D620648830A@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250818-imx9-dts-v2-0-8ba787fb5280@nxp.com>
 <175554055785.1719742.4035330946121256179.robh@kernel.org>
In-Reply-To: <175554055785.1719742.4035330946121256179.robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|DU4PR04MB10550:EE_
x-ms-office365-filtering-correlation-id: 0cac14a2-69bd-4c4e-3ff0-08dddebe6969
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|19092799006|7416014|13003099007|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?dKBQVJ/flKz1y/TcUlq9vNyDfHoeNZ+ddob3sjFMbjxNLFI9K7KYZJOatpqG?=
 =?us-ascii?Q?QhmFBK53kI2WGuk6gw2EK/Z3P5zWoEfXOpQtDfP/sW/+olaY0bbn47qeJDYc?=
 =?us-ascii?Q?h6V4qnquafDJXXIKglRZZJnx7IFfzANPm11G89bFoqcbDH7roQyaFP1aiIbn?=
 =?us-ascii?Q?7XrJBjy5BmjQhndqfuFFgNfVnRS22Nm9SubGCo6+cU3tr/uocxw0dkN8ywET?=
 =?us-ascii?Q?2gG8DKDFauq1FKhYk7onPeijWAyt8T2I9FmIw79LpLlSsQUPTEuhv1FqM3cW?=
 =?us-ascii?Q?4JNt1G2YxqVTcR1BVPFatq15LFhdKWxanEo6oY7ahCTNMwJhgwnGUWTzUmrP?=
 =?us-ascii?Q?Qu6R9RE6mgEn2owVn5vlNWGf4QcYnSO6xQ7Ca1o5O5XjbuTT+7xWrArolv0q?=
 =?us-ascii?Q?bEhynl/kBYw6KaHelDvc64O4yQHhst/lFtl0qszCyQHfwoGi3JDkGTya+RSk?=
 =?us-ascii?Q?S6AqpglYKBxaSWMVlm1drk9BN3QAVyrQCF+8TlyjSH+liJLW0NAHKYusclnw?=
 =?us-ascii?Q?sT/e0xVCCvaJu5iWYhuzYf7Hl1q0r5WM4lmpI/QOxJglIV80rtYftToFxzfz?=
 =?us-ascii?Q?FmDiuzLxpiZpBgvn4vzrGlaOUcoMm8xuJW1ImemSbi28Of4BJNJrrW6W123R?=
 =?us-ascii?Q?2RMUvrbhi0uB7IJpfdUVtob6LOwA0ZHwdCYj8lmGznnMl3EEEC8mDdXjC5n6?=
 =?us-ascii?Q?qWO/FBlyMLAKn5RZ5o4bsoiEiSLsYsIYy+wHbVhciwcz6Vnu2YBlvM+il8TR?=
 =?us-ascii?Q?bJ6KHUZZfEFtgqPxmYgzMmZFboFiDlkOzktAwALU1Ha1M7Z/pIIWHFJ6QqZC?=
 =?us-ascii?Q?Q3hHjq7Xyooe/tctjx2Ifz1YKQncSNqZAblBwhAwiPR1cz3O/uxe5TU7FQwY?=
 =?us-ascii?Q?L+GU46C0Y6ljsBjNtiePQCk0dcZ7zZx7LdsuGBH0aMu23SXJbUP5IGuN4cyV?=
 =?us-ascii?Q?7CNWhkxnMoY1InKZoa85PZpnwsq4i2cKs0Bjs2ZJOYNu68LYYZPel/MCA+Ew?=
 =?us-ascii?Q?X29kW6pijoo3uw7DLhymHvJwi7gWzZaE9CwULffss4aR/PY/MoU1pA4oIrTV?=
 =?us-ascii?Q?JBtmxDgbPaw4bXBXryxPV2pl5gdKejaF54wOVo2Vzwv805x/l2pKsUj2S9uq?=
 =?us-ascii?Q?F7eq4XF/NrkIkPktLDeEUfbwWXrCDqxnTCkruH/LyCp8FpXyFxyinEOvZC5P?=
 =?us-ascii?Q?ec/wqLsHjHrg9PShvf4B1PtQep33D2j7/s2CEISVFwLbRH43Y9nz7yDMNm31?=
 =?us-ascii?Q?/70ZLO9VLCb+mDz3sTEnka2EXB64csMPq3PLwy8PmD9/jFnNZd7fSzhjdd9O?=
 =?us-ascii?Q?9bpMbO2S+Dl0xmPVj1jfaJ647FWKrecQqHOUgecbF27v1/piuShO0U9dc2eF?=
 =?us-ascii?Q?tgL1yXNRQ2vA87isyPMYzeNZ1AFqknQ1IQQRYTm41CTtz9tGetPIUunSEaQY?=
 =?us-ascii?Q?edxmZfovsgc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(7416014)(13003099007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?YDIl3eG7a4+GFUSi1JEKHSG3WeUz0j6EhT/VDVRkKehijzdU3WIQNuXgKgSb?=
 =?us-ascii?Q?RmCYOWQd4WSs3CRyIDWROCGv56QZburRFW6sReMAgatbD/5fwwyFpyk+bxwB?=
 =?us-ascii?Q?SdPgEGDWNeQX4aidoF+UnaBlBkkfBZqikIex5zEcVbdPgO2YF5Frfq49Atva?=
 =?us-ascii?Q?pHMtG1Ygb1cfzLOvGQpVLtGvQZdOH7HOw5F0GsPNN6kASYxVzQVnbe3PYYz6?=
 =?us-ascii?Q?XAEji9rMN/OEwipTSseaDfzRkbrUjkrqvTMjbjPJBmqENB1KThbJcOcTa8ru?=
 =?us-ascii?Q?HaX9gAPdkGmr+Nfv27/89pZHEmbZRxHPCvdF0vCbnz57nO4nOAJW4D48+X1A?=
 =?us-ascii?Q?mJ7vzdc22576reyUOftNjIc+zfYVHX06cbSO1EIgLgJX8Oq2S9mnswKRPvE5?=
 =?us-ascii?Q?A0SU0q/rrk39uidzzhsJpw9H/5Yua2vzwenv3/HBNaEeWJgRuAZK4g0qjvj5?=
 =?us-ascii?Q?WQ5VNUnwTaXygPzi5oP3YDEZIWZbND4f7CTSU14BdqW1FSVYlCiicezpL7UV?=
 =?us-ascii?Q?sVnRAE2VyOEkdT582lnBYMc9n1zCuOoNSeF8aFSe0JQR+adwfo/M3/mmqHBh?=
 =?us-ascii?Q?wqYS9eDL7k91m2FA4OKha2ZVIK1g3cCZWWbxXeel0pstjwqGoHeaSDl2frTA?=
 =?us-ascii?Q?fCLHb1JY/Nvnm+ahTA11D6C3DpSPO9IiEAKJP7y4gwWqyDDluLKTVWB6qFRt?=
 =?us-ascii?Q?A/mEQTHG5KcpolRlmWvv7TQarr9lMiRHWSLIZlGHeoElW8VCiXBS7oW2Ipui?=
 =?us-ascii?Q?jm6DMs+L/KBMkMhQNmyxLd3kxvOiMuz7JzesyUUOSXbbD//7ZNX/CbU5B9Jp?=
 =?us-ascii?Q?mD7DAY/5bBX4hNJ3Jqr1Aif2bO3lE1k7wTfD5/bywXU5kdkfMglpjoPLFii1?=
 =?us-ascii?Q?8LFe2xnDpyt/+8CAG4wMQsa1hjVY7q6OM2dyXMYPTKeQ3lzBoh0xtRiFFKLs?=
 =?us-ascii?Q?aiURtuSNnavx5eJYDcKzVrpWM0W8HhRydJvSlIsshjVqadmSbp9SuzMROZsL?=
 =?us-ascii?Q?jVTJRTvnZC3f4sNhAqGUZvCOUz8zUXTA32+7fA8sBGiFJc2ty9IBG49eUu8e?=
 =?us-ascii?Q?Z0Un7MR/6EY6VrjyglgN6P6UAskjQ14bYpqs6x33IFrPPzx70ZiCUjHXAw5N?=
 =?us-ascii?Q?2SNW/9R1yPQZBA7GjtApOqmHnLtDrMy/tenIBsvXIYnZ+FZst3jP85XSm382?=
 =?us-ascii?Q?kDPgV0kgRyg4ezoYIgKjYBJ1SdSmoZxnOI9BrNTPS4oteuuv6wdJ/GI4KaLc?=
 =?us-ascii?Q?pmEdxHNAygc6z83XaDW/vwiI08eCDV2ai6ylivqbc1JPsz74VA+iveCHf52w?=
 =?us-ascii?Q?A6NbN8S+8GycqovMIGyB5O4l/J+eaWSfufDaIkLQXslBubRuQGE1EtmErxUb?=
 =?us-ascii?Q?NIaex1GQQza3cRyYFa3MUuzc26OklLK7WxDlLnwBnE9N92HE94LveTPaAtuo?=
 =?us-ascii?Q?LhOz3lLYVWAg4ZqtdFmgNIGKFGUtRb6nACOI2OrgxIepTqfcaR6BfLO06czE?=
 =?us-ascii?Q?G0RPgh0VMU4zvo1mncn0ncalEW0/Clgm/NA29kEaI9eJfv48Fnk9uT1VwiIs?=
 =?us-ascii?Q?/ttbyfC3zhmB/V2xPZs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cac14a2-69bd-4c4e-3ff0-08dddebe6969
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2025 01:19:14.9922
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P5/0zqMf1eRbx+dB7fIb/FoM8SYneW8rBL/j2VtOMwZI6CJRIqp20O+67LLSTxh744SIZ6i8xPoC9Pv3lO60Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10550

> Subject: Re: [PATCH v2 00/11] arm64: dts: imx95: various updates
>=20
>=20
> On Mon, 18 Aug 2025 09:25:30 +0800, Peng Fan wrote:
> > This patchset is to upstream various downstream changes.
> > - Correct edma channel for lpuart7/8
> > - Add System Counter, SCMI LMM/CPU, V2X MU, coresight nodes
> > - Update alias
> > - Add pca9632, pf09/pf53 thermal and etc.
> >
> > dtbs_check will report a few failures, such as linux,code, db suffix.
> > The failures are not related to this patchset.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> > Changes in v2:
> > - Drop patch 8 because dt-bindings not ready, and patch 12
> > - Per Frank's comments: Typo fixes, node name updates, sort
> properties
> > - Add R-b from Frank
> > - There is still dtbs_check error, but not related to this patchset,
> > it is because
> >
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F
> lore
> > .kernel.org%2Fimx%2F20250718094723.3680482-1-
> peng.fan%40nxp.com%2F&dat
> >
> a=3D05%7C02%7Cpeng.fan%40nxp.com%7Cdc5a5e6a80884995523d08d
> dde8482f9%7C68
> >
> 6ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63891138289855
> 9682%7CUnknown%
> >
> 7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMC
> IsIlAiOiJXaW4z
> >
> MiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DUf
> %2Fftx%2Fo1D
> > 9K5ev%2F57Q2ib5k1eCXbw2bJv7CoF2fNNM%3D&reserved=3D0
> > not applied.
> > - Link to v1:
> >
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F
> lore
> > .kernel.org%2Fr%2F20250815-imx9-dts-v1-0-
> e609eb4e3105%40nxp.com&data=3D0
> >
> 5%7C02%7Cpeng.fan%40nxp.com%7Cdc5a5e6a80884995523d08ddde
> 8482f9%7C686ea
> >
> 1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63891138289859878
> 0%7CUnknown%7CT
> >
> WFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIl
> AiOiJXaW4zMiI
> >
> sIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DlKYrW
> kLP9HAcsuBgT
> > NZr24y51QJKZe6Z5HyTvw6d1pI%3D&reserved=3D0
> >
> > ---
> > Joy Zou (1):
> >       arm64: dts: imx95: Correct the lpuart7 and lpuart8 srcid
> >
> > Luke Wang (1):
> >       arm64: dts: imx95-15x15-evk: Change pinctrl settings for usdhc2
> >
> > Peng Fan (8):
> >       arm64: dts: imx95: Add System Counter node
> >       arm64: dts: imx95: Add LMM/CPU nodes
> >       arm64: dts: imx95: Add more V2X MUs
> >       arm64: dts: imx95: Add OCOTP node
> >       arm64: dts: imx95: Add coresight nodes
> >       arm64: dts: imx95-evk: Update alias
> >       arm64: dts: imx95-19x19-evk: Add pca9632 node
> >       arm64: dts: imx95-19x19-evk: Add pf09 and pf53 thermal zones
> >
> > Richard Zhu (1):
> >       arm64: dts: imx95-19x19-evk: Add Tsettle delay in m2 regulator
> >
> >  arch/arm64/boot/dts/freescale/imx95-15x15-evk.dts |  29 +++-
> > arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts |  94
> ++++++++++++
> >  arch/arm64/boot/dts/freescale/imx95.dtsi          | 165
> +++++++++++++++++++++-
> >  3 files changed, 280 insertions(+), 8 deletions(-)
> > ---
> > base-commit: ff837884a4642382a24d10fd503acf2c3a472f10
> > change-id: 20250813-imx9-dts-664f7ba66ae7
> >
> > Best regards,
> > --
> > Peng Fan <peng.fan@nxp.com>
> >
> >
> >
>=20
>=20
> My bot found new DTB warnings on the .dts files added or changed in
> this series.
>=20
> Some warnings may be from an existing SoC .dtsi. Or perhaps the
> warnings are fixed by another series. Ultimately, it is up to the platfor=
m
> maintainer whether these warnings are acceptable or not. No need to
> reply unless the platform maintainer has comments.
>=20
> If you already ran DT checks and didn't see these error(s), then make
> sure dt-schema is up to date:
>=20
>   pip3 install dtschema --upgrade
>=20
>=20
> This patch series was applied (using b4) to base:
>  Base: base-commit ff837884a4642382a24d10fd503acf2c3a472f10
> not known, ignoring
>  Base: attempting to guess base-commit...
>  Base: tags/next-20250818 (exact match)
>=20
> If this is not the correct base, please add 'base-commit' tag (or use b4
> which does this automatically)
>=20
> New warnings running 'make CHECK_DTBS=3Dy for
> arch/arm64/boot/dts/freescale/' for 20250818-imx9-dts-v2-0-
> 8ba787fb5280@nxp.com:
>=20
> arch/arm64/boot/dts/freescale/imx95-tqma9596sa-mb-smarc-2.dtb:
> scmi (arm,scmi): Unevaluated properties are not allowed
> ('protocol@80', 'protocol@81', 'protocol@82', 'protocol@84' were
> unexpected)
> 	from schema $id:

This is not introduced by this patchset as written in cover-letter.

The error will disappear after https://lore.kernel.org/imx/20250718094723.3=
680482-1-peng.fan@nxp.com/   being accepted.

Thanks,
Peng
>=20
>=20
>=20
>=20


