Return-Path: <linux-kernel+bounces-889844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55729C3EA9B
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 07:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A57F4188B1DA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 06:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426D4305044;
	Fri,  7 Nov 2025 06:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PQiMcq8m"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011014.outbound.protection.outlook.com [52.101.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAF1304BA3;
	Fri,  7 Nov 2025 06:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762498642; cv=fail; b=XC4WNcBsmsMYN7WSK6Twkyl6wxjWeVUxkrXTxwWAoWyR2JHG8Iv8M+P4i2hW7nxpW+CM14nv/O0B8Ripd8YwLiLf+FvtVz8Nr4drsgbuJ3axtMclHHXtiUWPXF+MzQ75jdgYhE4tdgqVInSlN9MEcQN+IGkpfyDEVMZ0aXl7OM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762498642; c=relaxed/simple;
	bh=CPkzYfykJ0IP51cvklM2w9JunoAUEbeBgzY16ZGb2Zk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iAuoqE120LcPoG/8y+hXHl87ocbGuF+009+lEbajK5UgvFVw1OYCj1EzVTvB03yBxEjPSxabpsXJbRmEGmdb4ETfYBDcxNnZiBam6q23C3aPUYxzfOLxlD4vDOImDOQ6DitmKDipA0y3clzPlSJDETZttt8/wrv2h1C5k/QZfoI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PQiMcq8m; arc=fail smtp.client-ip=52.101.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t6TwObJkDkA9GJ/fse6MXYE6Z9xeSk8bxnAJmb3wDEwk2XH06RueC4GFwadgJcZ+h9JBgaCB1gMx3gFVuJX2Z0LGuwH/yF1XaxipfmnXNehnqTxFT3b2V6y2l+28MTlfkL9zfJkrqfAc/0eYKEY/+srmrUb9NeEgm1SuaBaaX4ikpPDHoRPN6CdMF9X1HDg+jrOKRwPQiIlYyNlUa1mNfEn0szmUQyR/G7xbCltL8w619jzngZ3dD0HlsLtoK2+3WcUCT5guLqhajLZstollOehNGuytaSwoOCJH5fUuKFSAS/jwN8APQD2kMCZ2UrumH0NoKRwi1Lc5iOl1kxh2Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=isv4S9vs8Yx9G66uhRTZIAXk+HFhHR8GTIdATy4ildw=;
 b=Sc0xmYQwhh2zdRdlV4ho6XXoPj2bj7luZDvrXlH0FBaHUrsXAilPXsdWtuw9RlpzTaVSPyeEyERdit6XP8jGjWX9mPOdREi6xS3SLW+Sz8zBvnriK4MYTYRUwZpg+F1qXkyYX+azGA15uM7KzFs59sJ++8yUA/8eEKLGiv7ek53MJToBVsbzbraepuCvimwYfBb76Wimn8OzmXONHTWHsdAKXYoyYvhHXtmJoW65AVEjODsgnvttIviI4egNTxqfvlh71ALAF71Ni30fVZamPT/JwyY1+Gosf1YU4TwEQbtxJS4i7J5yvs7Jub01xNkHd67P2be4qsOmLSmKgylBEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=isv4S9vs8Yx9G66uhRTZIAXk+HFhHR8GTIdATy4ildw=;
 b=PQiMcq8mpsIEQzgrBB5JhDLf6ubmx9uNE3TNVgEVFdSwO0ux9udkfqorpY0zZmfWpyV2ZovSaRZ8vOtvsS9FVlvntxgkeXXSS6Hds5LDzYRJPzHzrJtW5uMDUtsAh+uaJ4FwYEncxotMA/h5dHKBBdlb04N2aTUnGDr7ecaROEBAmMcZ5xFZQ0sfXUd7YvmWUnGVTdd2SJZOpy/qDmkGvuJCXpSD99s5fDcLSO4PyWWX7sNmcqgkB6gfem/fvDn6+s2WpyMPLaTl+giG/zZ4dzTVCB8sYNYNZGqZIwiRagCg461kDf/KPI5K39oaxo3oG0e8PVXEtjHMSxS5dSkERg==
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by PA4PR04MB9272.eurprd04.prod.outlook.com (2603:10a6:102:2a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 06:57:12 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%3]) with mapi id 15.20.9298.006; Fri, 7 Nov 2025
 06:57:12 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
To: Marco Felsch <m.felsch@pengutronix.de>
CC: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, Frank Li <frank.li@nxp.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH v19 0/7] firmware: imx: driver for NXP
 secure-enclave
Thread-Topic: [EXT] Re: [PATCH v19 0/7] firmware: imx: driver for NXP
 secure-enclave
Thread-Index: AQHcLvztIykpoCx+vU2TOsTcO77HnbTExb+AgBDxjcGAC9UegIAFbnEA
Date: Fri, 7 Nov 2025 06:57:12 +0000
Message-ID:
 <AM9PR04MB8604AA80EC97E06AADBF334695C3A@AM9PR04MB8604.eurprd04.prod.outlook.com>
References: <20250927-imx-se-if-v19-0-d1e7e960c118@nxp.com>
 <20251016114151.jzmapaecsmmnkpt3@pengutronix.de>
 <AM9PR04MB8604C2AAA70406883320C5C995FCA@AM9PR04MB8604.eurprd04.prod.outlook.com>
 <20251103190811.wp4o7hlnus6ynn32@pengutronix.de>
In-Reply-To: <20251103190811.wp4o7hlnus6ynn32@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8604:EE_|PA4PR04MB9272:EE_
x-ms-office365-filtering-correlation-id: 95e25270-412a-406c-53e8-08de1dcae0f1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|19092799006|38070700021|13003099007;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?o8zi7LHdvHyGnkL519B4l4RedWwQS+mBMEbfpKg8YFW7iU685K6t4riKzvkB?=
 =?us-ascii?Q?gRIrL4TZKu3tYASAtzgg1Dusb2maHLYKwxp0hf5VJCSgG3qxHG9Hjk2+G6LC?=
 =?us-ascii?Q?JtVPPtNm5jYfb16VT6Hg4mKN3Xn87JEdpvNKSEwY9k+b56N3V8/lHyXacJ9T?=
 =?us-ascii?Q?0fcZRzjMczPOHbRh0+Q80LS+/uGt/CxiAKjlgA3aog2Ub/Ac5TKPXqYxXfNX?=
 =?us-ascii?Q?Zj+Qe9clSPB8GvXD4XWjmTSurIVCpZMmkbNMYGFO+v3HOVj039iC3GJj2Dhb?=
 =?us-ascii?Q?qY56WBKlaMTO+boQ6lJUyvO4zD8PTJtoQFILJfpBBwQuvTYCwz3B/+rxeDWt?=
 =?us-ascii?Q?C9CDXguURsvgbECe41rx9yme0U5dompTIeJ6cahPOTM1VoAWTIG+G29+27D7?=
 =?us-ascii?Q?rJrmvguxReDOb4zDOtle1ImE3r5PRG4G5g9KFdGTDtwodgbN3SLFkylgtJJc?=
 =?us-ascii?Q?4BH2D93dqmfCOdt3udd5j1Ead17C1zpTZdz89HxiDBmasEoVCnPPc32muMSx?=
 =?us-ascii?Q?i17iYJFYvTXJ1yGniNP6npI8/OgQ24aiue5U9HDjfXc3sWGfWxOtg8ekXrUw?=
 =?us-ascii?Q?LhhOJU5wOGnS2csmWwRrd/1xZP45Z2hNLgWe86VOBGdKqMUdb+zbr2et8E10?=
 =?us-ascii?Q?DZIgZwBRl2lBOOYqUYXUlYgfFTYhBMfanBU+OOfHlAy6Wm90x/VF/okssM/B?=
 =?us-ascii?Q?UCvGQ/DTSKOEMm5IJK/cGV7v6/NfUva7mFTsywxxmO4CIrMrjBxzc9G/l2fp?=
 =?us-ascii?Q?hBddUUdZZtwxxSi2vf+rNHB/VUKD1VjtaCu53UYWMPKgTw4lx7we7Ttq3j2X?=
 =?us-ascii?Q?vw7bNogHyQas05wXxbC7XA8OaR4WC1x0ZW+ll4QYbTyPsPmx8rQ1kJPIGbSS?=
 =?us-ascii?Q?hVzejnYLKFmDOwKybc2MOqjEeMS9PhFy8iopreVH2MVDBaq7E8j7C4s8W3Xm?=
 =?us-ascii?Q?VS2VyrLbS+WbZqRyG5hHvRCqn5p5ja7Advq/5NolHp/pte0dJDB+jdaJxTja?=
 =?us-ascii?Q?Ki5s7cNoyQfFLgMUCusvJR7TKuap55F714MAF0ytMTPL8X6k/5L2jujNK0Ib?=
 =?us-ascii?Q?dxNqY1BMK9mOUW7n11CMRT3J8V5XWA/YP/GnvJd2zVFpSLkwQB2m6PPwWAhn?=
 =?us-ascii?Q?S/wbJbnsJCVuoE3RSVEqLn5mUe57om2d0AN/bwxs8s3T/jXlpleJSc7CT1Ho?=
 =?us-ascii?Q?SAsdoy9sO/IgBkJiVT/TNBAWRbF4nxqiobfiYQvSQqhUKUmTryWbEZxA6hI5?=
 =?us-ascii?Q?R1Or2F8crlvbYvQKFGTbpvIPBNUqGH0goUdUYWg2CeVNoI/0zSNScy0m+nY6?=
 =?us-ascii?Q?nrUL1pSsshXWMKWoGQI9SwbwyN7nDZ0QIIYoY03V7UvxriPel+pOTlpCxZoP?=
 =?us-ascii?Q?+NN2O12KXxIh4aGciXrUaJkpj88FcuGK/ufPjzKVonBMBFnaNkTyjArctgUr?=
 =?us-ascii?Q?ow33doEuAJOD/Z2OwNIxOsZ2n3xINSmD1Ch8aB+r/qwjuxW9VXycXA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(19092799006)(38070700021)(13003099007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Ni2EaIIaRY+17ZIbP/TZ3qSCrHXItag0u4VlifxcF6BWVxZtDECUSNTEuYLp?=
 =?us-ascii?Q?FoVCVxAQWj1lPD8/Xu7LjLqozx8m9ylPz5G3tUq3OGYiBApUOxQplmPpf/lQ?=
 =?us-ascii?Q?gY79W2Xj/1WIQqH+Q45Iaw7li+r2I5aCA4+HrX5m57FkZwgRysrYCDFWOLyF?=
 =?us-ascii?Q?g8/1WBYNbc/OGIAgUeDGHUjVDA/RZz+BxGiVzidCeF4aOLH0lwumoBcPSSb6?=
 =?us-ascii?Q?PrsVl/ZzD/Ku0a/765CwgrCdqvwMm4Hz+Xh8D3W98eQV+t1UO6nk0PT9VkpM?=
 =?us-ascii?Q?qo7pXMRBCOA+jm7Vtoss9JvHGarCmdmUtuzZ/xiqJjg0nw7mXUCtAx7d6EbC?=
 =?us-ascii?Q?Ij6wdTFLejCpPRl7IlC4kqi2nNahpIlJDCWDXPMNHACYon/G6U7tpnmgtl8H?=
 =?us-ascii?Q?JzDqIm7E9aRC6QFxz8UF7L78KW0fq+bnwBG3PQkLI2emUM2iX55AimJwhlQz?=
 =?us-ascii?Q?zyHU5jyh2qDyO7ejyTd+N+iSntWnYWI92uDA+ui7NBD8sRgkWdSZFORAGXuI?=
 =?us-ascii?Q?rlnhnBCkrKLHxpcCMm8sZu0nZKTCaaUSnC0xuvnpBxJx+x15JSbV/DGQIRN4?=
 =?us-ascii?Q?aqX8yx/Ykf42TLRhIMRrVuUzxjUS75R9px7vTvAEusY8awvBMHxtVKhqKkPq?=
 =?us-ascii?Q?fMXnAAlwblN/EzV3dXhIJ/d/6l6x8Sd3dIR7Le8iq9AKYkdWlygLGRIBjQe7?=
 =?us-ascii?Q?pF/ufbQY4ZhO+zQER3sJQ+S+jQMpwhLoACJy5YMkpXDfobmrfXL0nAINxzuW?=
 =?us-ascii?Q?4f5HuIRSdfd6U6hKcVh4uKGRS05PDMJmKN6stthl5asfOYU9pj2gfsU8oEpG?=
 =?us-ascii?Q?k7AvCnniTKm2sVo5JfUld9J7dbk+2ndtlQkuKf7u5hP6nu88Crc88oqf2BF7?=
 =?us-ascii?Q?y0BHaQtzPMPyO+QiZ5S8+2gDEX+y3gc+aRz4hKc4JgAwR4kbs5eTEpa0mGLn?=
 =?us-ascii?Q?KgRkct5gf5fZI8MyZ31UcQseVAIZcjbktZ3PY0ijcDdjOFc/m/Izi+PTuuIB?=
 =?us-ascii?Q?5NyNBn59NZ9P36Yfhm1t7Uh4qYLZTPVe+cmyX5YE95H4KTDvyq8H5YwGy68e?=
 =?us-ascii?Q?xuUdq+/Ey7Ncy/KHfqUTGO1HOjslLo7i8FZexVi8CYdWvJBzPlf5bPq9wX1s?=
 =?us-ascii?Q?GitzIf5LkfZjlm2aOxSlGIklybZOskRjbbPNGSV5h+4p3Mb3NuRtyFajEzx6?=
 =?us-ascii?Q?sXYsBhE9I+nWo0ZYTJbKJnsxK/vRMdGFaKGdCduusU2PREF9+2Y6F6GPcS8D?=
 =?us-ascii?Q?2PqIanh2sSZ2R9Exq6MC7Mn82J9ctG0YvzYy8YzA5CnQ/qCacPGp5byyp4Ys?=
 =?us-ascii?Q?SJUij/WYWXLW5y11KfhQqu8/NmH7OFwVXbmT/3XFw+ocu5jOlNt0l7Qp1bWo?=
 =?us-ascii?Q?KnzW3wYgeH+Gz5ysYNU8jN2Lg+V2JPaqyGpAz4GXlCq1wsS3zOC9SWzIKYdx?=
 =?us-ascii?Q?MYWh/uU0171pG5G84QG8Rm0kMjSyCfM9tnRcpks+ljMOFev0o+pir7ipq9Jo?=
 =?us-ascii?Q?SpaSwkH7DBjgGJRVthpWrcZzVhyiFZwtulgPR/KVFSxg4GUaWNBa43FtIer8?=
 =?us-ascii?Q?BTfwvUgq77M55zZfG5MHk1JxwhEF7+IxGwHUgANE?=
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
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95e25270-412a-406c-53e8-08de1dcae0f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2025 06:57:12.7389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iTDL1GlETVcgXutpFJQ1art+81iGyZqefeik5hllLT15e34e44W5ojOHsRIXAEMIkLeWoiN4kgEaFloZkrlQkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9272

>> On 25-10-27, Pankaj Gupta wrote:
>>> On 25-09-27, Pankaj Gupta wrote:
>> > >> Highlight:
>> > >>
>> > >> There are long discussion at V18 with Marco Felsch.
>> > >> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%
>> > >> 2Fl
>> > >>
>> ore.kernel.org%2Fimx%2FAM9PR04MB8604F5A7DD8B1E41FDAD09039501
>> A%40AM9
>> > >>
>> PR04MB&data=3D05%7C02%7Cpankaj.gupta%40nxp.com%7C853f73b919714
>> 8e3c4ea
>> > >>
>> 08de1b0c6148%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6
>> 38977937
>> > >>
>> 182676166%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUs
>> IlYiOiIwL
>> > >>
>> jAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0
>> %7C%
>> > >>
>> 7C%7C&sdata=3D2LXQbwdgb4Sb3PaYMUhn3gmSaJZW3%2FNXAJOX6d%2Fh%
>> 2BwI%3D&re
>> > >> served=3D0
>> > >> 8604.eurprd04.prod.outlook.com/
>> > >>
>> > >> The key point is about using OP-TEE OS.
>> > >>
>> > >> Marco's questions:
>> > >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > >> Q1. Both MU(s) from each world - Secure & Non-secure, cannot be use=
d
>> > >>     simultaneously. Why?
>> > >> A1. ELE FW fix is available, where concurrent access to ELE from bo=
th the
>> > >>     world is working. This fix is not required for the current patc=
h-set for
>> > >>     i.MX8ULP.
>> > > According
>> > > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2
>> > > Fgi
>> > > thub.com%2FOP-
>> TEE%2Foptee_os%2Fpull%2F7268%2Fcommits%2F83b516edc0270
>> > >
>> ca8300ce524a0c3d560e67a0f48%23r1955899462&data=3D05%7C02%7Cpan
>> kaj.gupt
>> > >
>> a%40nxp.com%7C853f73b9197148e3c4ea08de1b0c6148%7C686ea1d3bc2
>> b4c6fa92
>> > >
>> cd99c5c301635%7C0%7C0%7C638977937182705340%7CUnknown%7CT
>> WFpbGZsb3d8e
>> > >
>> yJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIj
>> oiT
>> > >
> WFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3Dk30VGVc%2BEYsHw3
> QOABgFZw6
> > > v%2F5oSZx7%2FekHCDaZjbH8%3D&reserved=3D0
> > > there is no fix yet. Can you please point me to the fixed version?
> >
> > It is not yet up-streamed to OPTEE-OS repo.
>=20
> My intention of adding the above OP-TEE discussion link was to point=20
> out that an ELE-FW bug exists which needs to be fixed.
>=20
> > Fix version is part of NXP LF Q3 released on 30 September.
> > Commit can be found on this URL:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgith
> u
> b.com%2Fnxp-imx%2Fimx-optee-os%2Fcommits%2Flf-
> 6.12.34_2.1.0%2F&data=3D05%7C02%7Cpankaj.gupta%40nxp.com%7C853f7
> 3b9197148e3c4ea08de1b0c6148%7C686ea1d3bc2b4c6fa92cd99c5c30163
> 5%7C0%7C0%7C638977937182721931%7CUnknown%7CTWFpbGZsb3d8e
> yJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIj
> oiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DU6Rh%2Be1CTBdJ
> PGGyfm5hF4mqylkBcSQp6KNzE9cL%2FUo%3D&reserved=3D0.
>=20
> I assume you meant the following commit:
>  -
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgith
> u
> b.com%2Fnxp-imx%2Fimx-optee-
> os%2Fcommit%2F039f15017cea38c401f908e0e1662ba8806ed4e3&data=3D0
> 5%7C02%7Cpankaj.gupta%40nxp.com%7C853f73b9197148e3c4ea08de1b
> 0c6148%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6389779
> 37182737561%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydW
> UsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D
> %3D%7C0%7C%7C%7C&sdata=3D5mxtHM9Fy0i94lRNn1itWJcTWU4Ca%2F0ZR
> ZUDRTl9WxQ%3D&reserved=3D0
>=20
> This adapts the timeout value to 100ms and seems more like an workaround.
>=20
There are additional fixes in OPTEE-OS, that will be part of LF Q4'25.

> However, can NXP confirm that the ELE concurrent access is possible=20
> without a previous ELE FW update?

Fix in the ELE FW, released as part of LF Q3 2025,  is a must to include. O=
PTEE fixes are also needed.
OPTEE fixes will be up-streamed soon.

>=20
> > One more fix is coming in LF Q4. After that, these patches will=20
> > up-streamed to OP-TEE-OS.
> >
> > Then you will be able locate it in OPTEE-OS git repo.
>=20
> Thanks for the sharing the links :)
>=20
> > Since the current Patch-set is for i.MX8ULP, where concurrent access=20
> > from both the world is not possible.
>=20
> > In context to i.MX93, for OPTEE-OS patches, request you to please=20
> > discuss in OPTEE community. Not here.
>=20
> Sure, as said above, my intention was to point out that concurrent=20
> access is not possible with the current ELE-FW. At least my knowledge=20
> was that it was/is a ELE FW issue and not an OP-TEE issue.
>=20
> > > Also, can you please outline why the fix is not required for i.MX8ULP=
?
> > > Unfortunately I can't remember.
> >
> > There is no Trust-MU for OPTEE-OS in i.MX8ULP. The ELE driver in=20
> > OPTEE, is disabled for i.MX8ULP.
>=20
> Hm.. I thought there will be always two communication MUs one for the=20
> secure-world and one for the non-secure world? Or what did you mean by:
>=20
> """
> From i.MX9x & onwards, SoC(s) has at least one dedicated ELE MU(s) for=20
> each world - Linux(one or more) and OPTEE-OS (one or more).
> """
>=20
> (ref.:https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%
> 2Fl ore.kernel.org%2Fall%2FAM9PR04MB8604C05882605EDB4913DA089549A
> %40AM9PR04MB8604.eurprd04.prod.outlook.com%2F&data=3D05%7C02%7
> Cpankaj.gupta%40nxp.com%7C853f73b9197148e3c4ea08de1b0c6148%7C
> 686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6389779371827527
> 25%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLj
> AuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%
> 7C%7C%7C&sdata=3DPhXXih6UnalGUPveMZPaS2EVAd2SMR%2FyblcjyuHRUrw
> %3D&reserved=3D0)
>=20
> Does this mean that all i.MX9x, i.MX10x and so on do have the the=20
> secure and non-secure MU setup? Or is it based on the SoC release date?
> Because regarding the datasheet the i.MX8ULP is newer than the i.MX93,=20
> therefore I assumed that the i.MX8ULP has two MUs as well.

From i.MX93 and onward, there is only one RoT. Hence , it is designed to ha=
ve dedicated MU for each world.

>=20
> I checked the the NXP OP-TEE source code and found the following commit:
>=20
> 8<----------------
> commit 44388d37e68000ee50a9b1d656e0a60ae6614977
> Author: Sahil Malhotra <sahil.malhotra@nxp.com>
> Date:   Tue Apr 1 20:04:44 2025 +0200
>=20
>     core: imx: disable ELE on i.MX8ULP by default
>=20
>     On i.MX8ULP, there is only one MU to communicate with ELE,
>     which cannot be dedicated on OP-TEE side all the time.
>     There may be ELE services running on Linux side, which can
>     cause conflict with OP-TEE, So disabling ELE by default.
>     Moreover i.MX8ULP also has CAAM, so HUK and Random number
>     are coming from CAAM.
>=20
>     Signed-off-by: Sahil Malhotra <sahil.malhotra@nxp.com>
>     Acked-by: Jens Wiklander <jens.wiklander@linaro.org>
> 8<----------------
>=20
> So it's possible to configure the XRDC (configured in the TF-A) in a=20
> way to map the ELE access to the secure world. If I got the TF-A and OP-T=
EE commits right.
>=20
> To me this sound more like a NXP design decision to move the ELE to=20
> the non- secure and the CAAM to the secure world.
>=20
As per the i.MX8ULP boot-up sequence and ELE's initial role in boot-up, wit=
h CAAM co-exists, ELE is logical to be with Linux.
Another point here that CAAM has 4 JR(s) and hence CAAM can be shared betwe=
en Linux and OPTEE-OS.

> > Moreover, there is CAAM in i.MX8ULP, which is used for security=20
> > services, in OPTEE-OS.
>=20
> i.MX8ULP is getting really interesting, though.
>=20
> May I ask what RoT is used by this SoC if there are two?
>=20
ELE is Root of Trust during secure boot.
For OPTEE-OS, CAAM is RoT.

>=20
> > >> Q2. How is the secure and non-secure world talk to the ELE if there =
is only
> > >>     one MU?
> > >> A2. From i.MX9x & onwards, SoC(s) has at least one dedicated ELE=20
> > >> MU(s)
> for
> > >>     each world - Linux(one or more) and OP-TEE OS (one or more).=20
> > >> Has
> updated
> > >>     the commit message of 3/7.
> >
> > > Does apply to the i.MX8ULP SoC as well?
> >
> > No. Since there is no trust-MU for OPTEE-OS, on i.MX8ULP, to=20
> > communicate with ELE.
>=20
> As said above it would be possible to move the ELE communication to=20
> the secure world.
>=20
> > > The NXP name scheme isn't very easy to follow.
> >
> > >> Q3. How exactly do the eFuse write access after the device was=20
> > >> locked
> down,
> > >>     will be provided with single path; for the following case?
> > >>     - For a verified boot setup, you need to burn an eFuse at some p=
oint,
> > >>     to tell the bootROM to boot only correct verified firmware image=
s.
> > >>     - After this lockdown, it's no longer possible to burn eFuses fr=
om the
> > >>     REE, while the production line setup still requires the support.
> > >> A3. OP-TEE OS supports read fuses, currently as part of our=20
> > >> quarterly
> release.
> > >>     Write fuse will be in coming release. Please note that the curre=
nt patch-
> > >>     set does not contain any read/write eFuse feature.
> >
> > > But one of your patches is mention it, right? So there will be=20
> > > still two paths.
> > Due to lack of trusted-mu, there is no way to read/write fuse on=20
> > i.MX8ULP,
> from OPTEE-OS.
> > For current patch-set, it is the single path.
>=20
> How does the i.MX8ULP fuse flow work, after the LOCK_DOWN fuse is blown?
There is no such issue on i.MX8ULP
>=20
> This was one of my main concers why having OP-TEE required in the=20
> first place, because the i.MX93 requires the that the fuse-request=20
> comes from the secure-world if the device is in LOCK_DOWN state.
>=20
> Is this also the case for the i.MX8ULP?
>=20

No, this is not a valid case for i.MX8ULP.

> > > Also according your IOCTL docuementation you want to expose the=20
> > > whole device to the user-space?
> >
> > > | What:          /dev/<se>_mu[0-9]+_ch[0-9]+
> > > | Date:          Mar 2025
> > > | KernelVersion: 6.8
> > > | Contact:       linux-imx@nxp.com, pankaj.gupta@nxp.com
> > > | Description:
> > > |                NXP offers multiple hardware IP(s) for secure=20
> > > | enclaves like
> EdgeLock-
> > > |                Enclave(ELE), SECO. The character device file descri=
ptors
> > > |                /dev/<se>_mu*_ch* are the interface between=20
> > > | userspace NXP's
> secure-
> > > |                enclave shared library and the kernel driver.
> > > |
> > > |                The ioctl(2)-based ABI is defined and documented in
> > > |                [include]<linux/firmware/imx/ele_mu_ioctl.h>.
> > > |                ioctl(s) are used primarily for:
> > > |                        - shared memory management
> > > |                        - allocation of I/O buffers
> > > |                        - getting mu info
> > > |                        - setting a dev-ctx as receiver to=20
> > > | receive all the commands
> from FW
> > > |                        - getting SoC info
> > > |                        - send command and receive command=20
> > > | response
> >                                 ^
> > > This is a rather uncommon approach. The kernel has interfaces to=20
> > > abstract hardware. You completely bypass this if you expose=20
> > > everything to the userspace.
> >
> > It is in-correct.
> > Not everything, just exposed file-operation. and ioctl(s) for=20
> > DMA(eable)
> buffer allocation from reserved lower memory region.
> > Things managed by Kernel:
> > * Send/receive path to ELE, is managed by Kernel.
> > * Receive/send patch to the ELE's slave NVM-manager, is managed by kern=
el.
> > * Low power management handled by kernel driver. In case of=20
> > low-power
> state, ELE driver re-init the V2X IP as part of resume.
> > * Other kernel management layers like NVMEM, kernel HWRNG, will use=20
> > the
> api(s) exposed by this driver.
>=20
> But you also expose an uAPI which allows the user to bypass everything=20
> via sending arbitrary commands, right?

Yes. But it's not unusual at all. The pattern of userspace sending commands=
 directly to the kernel, is quite common
>=20
> > * Loading the runtime FW.
> > >
> > >> Q4. What is the ELE behavior if the secure-world stresses the ELE? I=
s there
> > >>     a MU priority so the normal-world MU may get blocked (never
> addressed)
> > >>     or are both MUs scheduled in round-robin?
> > >> A4. ELE will pick the message from Both MU(s), based on FIFO.
> >
> > > This doesn't answer my question. How gets the FIFO filled? If the=20
> > > one of both worlds aways keep the MU busy?
> >
> > If both the world is keeping the MU busy. ELE will pick the first=20
> > incoming message, let's say on MU#1, While acknowledge and queueing=20
> > the incoming message on the other MU#2, to be picked once the=20
> > handling of the current message at hand is completed. Despite the=20
> > MU#1, is bombarded With next message, but it will process the=20
> > message from MU#2,
> while acking the incoming message from MU#1. And add it to its queue.=20
> This way FIFO is maintained by ELE.
>=20
> :) Thanks for the explanation.
>=20
> > >> Q5. Why ELE performance matters?
> > >>     - On i.MX8M, which uses the CAAM (the ELE predecessor), It can b=
e
> > >>     verified that the ARMv8 CE are much faster than the=20
> > >> crypto-engine
> itself.
> > >>     Therefore the CAAM is mostly unused.
> > >> A5. User looks for both type of implementation based on their usecas=
e:
> > >>     - Certain users still offload to CAAM, to save their ARM CPU cyc=
les for
> > >>     other priority tasks.
> >
> > > I have never seen such designs but okay.
> > I assure you, there are several such cases with our system-engineering =
team.
> >
> > >>     - While certain customer choose ARM-CE for the crypto=20
> > >> offloads for
> better
> > >>     performance.
> > >>     As far as ELE is concerned, it is not a crypto accelerator like =
CAAM.
> > >>     Performance hungry crypto-ops are not recommended to be=20
> > >> offloaded
> to ELE.
> >
> > > I don't get this point. So NXP doesn't recommend to use the ELE=20
> > > for crypt-ops?
> > NXP does not recommend to offload the Crypto-Op to ELE, for=20
> > performance
> cases.
>=20
> Good to know, thanks.
>=20
> > >> Q6. For the IOT-cases where real-time encrypted feed from=20
> > >> sensors, will
> take
> > >>     latency hit, Does the ELE support inline en-/decryption?
> > >> A6. Yes, ELE support Inline Encryption Engine (IEE), starting=20
> > >> i.MX95
> onwards.
> >
> > > May I ask, how is this connected and which interfaces are=20
> > > connected to the IEE? I would have checked it by myself but=20
> > > unfortunately NXP doesn't provide a TRM for the i.MX95 yet.
> > We can discuss this in greater depth on one-one email, where I will=20
> > touch
> upon the IEE and its interfaces.
> > But, like to inform that there is not IEE on i.MX8ULP or even on i.Mx93=
.
>=20
> Sure, thanks.
>=20
> > >> Marco's Suggestions/NXP response:
> > >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >> S1. Below listed ELE access requirements, can be done from OP-TEE=20
> > >> OS in
> all
> > >>     the Life-Cycle states. then Why to use Linux?
> > >>     - eFuse access (done via  OP-TEE OS i.MX specific PTA): OTP=20
> > >> eFuse R/W
> access
> > >>     after doing the LOCK_DOWN fuse is no longer possible without =20
> > >> OP-TEE
> OS. This
> > >>     involves general purpose (GP) eFuses too.
> > >>     - ELE ping every 1 day (kernel SMC WDG driver, OP-TEE OS wd driv=
er).
> > >>     - HW-RNG (kernel HWRNG driver + OP-TEE OS HWRNG PTA).
> > >> R1. There are i.MX9* users, that are not using OP-TEE OS, but still =
want
> > >>     to use ELE features from Linux. So, these users are requesting f=
or this
> > >>     driver in Linux.
> >
> > > Which ELE features?
> > All the features from Linux, when OPTEE-OS is not present like:
> > * Read/write efuses. (eg NVMEM Kernel driver). Where there is no
> requirement to chenge the eFuse, during SoC in provision lifecycle.
>=20
> Some features require the device to be in LOCK_DOWN mode, which=20
> requires secure-world eFuse write path only afterwards. But it seems=20
> like NXP really wants to maintain two write paths.
>=20
> > * Low power management at Linux driver.
>=20
> The power-modes are selected via the ELE?

Voltage regulation for i.MX93 in Linux kernel, is done by ELE.
During Linux suspend-resume, Secure-enclave (V2X on i.MX95) part of wake-up=
 domain, will be managed by secure-enclaves(ELE) part of always-on domain.
>=20
> > * Linux HWRNG.
> > * Loading the secondary runtime fw.
>=20
> What is a secondary runtime-fw?
ELE FW size is larger than the size of ELE internal secure memory.
Hence FW is split into two.

Primary FW, is the FW, that enables features that helps for SoC boot-up.
Secondary runtime FW, is the FW, that enables features like HSM.

>=20
> > >>     As suggested by you, writing to eFuse after life-cycle closed st=
ate, the
> > >>     driver in OP-TEE OS is needed.
> > >>     Though there are other OP-TEE OS features too, that needs to=20
> > >> be
> offloaded
> > >>     to HSM, for security reasons, like:
> > >>     - Hardware Unique Key(HUK) getting generated.
> > >>     - OP-TEE OS's ASLR seed generation.
> >
> > > We're talking about features the normal world wants to have access=20
> > > too, since you said ".. but still want to use ELE feature from=20
> > > Linux ..". The HUK and the TEE ASLR seed is clearly not something=20
> > > Linux wants to have access too.
> > You misunderstood my point. I was stressing that there is a need for=20
> > two paths, each from Linux and OPTEE-OS, in order to expose=20
> > different feature-set required by respective worlds, where 1 or 2=20
> > overlaps, while maximum are utilized by respective worlds.
> >
> > >> S2. Having one implementation is beneficial in the following ways:
> > >>     - Multiple paths also requires more maintain- and testing effort=
.
> > >>     - FW files with having +1 FW for the new i.MX9*, where there are=
 plenty
> > >>       already eg.: bootloader, TF-A, ele-fw, scu-fw (i.MX95), increa=
ses the
> > >>       maintenance on both the paths.
> > >>     - TEE code could be reused by other OSes.
> > >>     - TEE is used anyway for new projects due to CRA and friends=20
> > >> R2. As conveyed in R1, there are Linux only users, that are=20
> > >> dependent on
> SE
> > >>     Linux kernel driver.
> >
> > > What difference does it make if these Linux-only users get the ELE=20
> > > access via OP-TEE? It's just one binary more.
> > If the User does not choose to include optional OPTEE-OS, then ELE=20
> > access must be from Linux driver.
>=20
> Okay, I think we're going in circles here.
>=20
> > >> S3. Having one implementation is beneficial in the following ways:
> > >>     - Adding the support for it to  OP-TEE OS do not requires ELE-FW=
.
> >
> > > I never said that this requires no ELE FW! I said it requires no=20
> > > ELE-FW update! Was the update already rolled out?
> > Yes, the updated FW is already release part of LF Q3 released on=20
> > September
> 30, 2025.
> > It is not released as part any open repo.
>=20
> So there is no ELE-FW update required to have both worlds running=20
> concurrently.

As mentioned below "But not for i.MX8ULP", concurrent access case is not a =
valid case for i.MX8ULP & current patch-set.

>=20
> > >>     - Concurrent access handling is done by the TEE core.
> > >> R3. As already mentioned that ELE FW fix is available, for=20
> > >> concurrent
> access.
> > >>     Please note that FW fix is not required for the current patch-se=
t.
> >
> > > Can you provide us a link to the fix please? The fix should fix=20
> > > the concurrent normal-world <-> secure-world MU access issue. Why=20
> > > is this fix not required if I have a running OP-TEE?
> > The fix is very much required to run concurrent access for i.XM93=20
> > and
> onwards.
> > But not for i.MX8ULP and current patch-set is based on i.MX8ULP.
>=20
> I see, the i.MX8ULP has only on MU. As said above my assumption was=20
> that all ELE SoCs do have at least 2-MUs."

As mentioned above "But not for i.MX8ULP", concurrent access case is not a =
valid case for 8ULP & current patch-set.

>=20
> > >> S4. This series causes more confusions till the ELE FW fix is availa=
ble to
> > >>     allow concurrent access to ELE from both the worlds.
> > >> R4. FW fix is already available, and concurrent access is enabled by=
 default
> > >>     in LF Q3'25, release. Please note that FW fix is not required fo=
r the
> > >>     current patch-set.
> >
> > > Please provide a link to the new FW and why is the fix nor=20
> > > required for this patchset?
> > Again. The fix is very much required to run concurrent access for=20
> > i.XM93 and
> onwards.
> > But not for i.MX8ULP and current patch-set is based on i.MX8ULP.
>=20
> My bad, as said: my assumption was that all ELE SoCs do have at least=20
> two MUs.
>=20
> > >> S5. Suggesting to add the  OP-TEE OS support for the required=20
> > >> features
> e.g. eFuses,
> > >>     watchdog, HWRNG. The whole Linux part is mostly in place.
> > >> R5. Yes, the secure world features like eFuse read/write will be add=
ed
> > >>     to OP-TEE OS. Please note that this patch-set does not=20
> > >> contain any
> read/write
> > >>     eFuse feature.
> >
> > > I see, instead it expose the whole ELE to the userspace if I got=20
> > > it correct according to your IOCTL documentation. This would be even =
worse.
> > No, it is not a correct interpretation. As mentioned above, ELE=20
> > driver abstract all the hw interaction to have easy and simple file bas=
es operations.
>=20
> But still, the user can send arbitrary commands to the ELE right?
>=20
> To conclude this longly discussion:
>=20
> My main concern was the concurrent access for the 2-MUs cases. This=20
> can be closed, as it turns out NXP fixed/workarounded this by=20
> increasing the ELE communication timeout to 100ms.
>=20
This will be not only the fix. There are other fixes like atomic write to t=
rusted-MU.
Let's discuss in OPTEE-forum.

> I still have mixed feeling about the fusing (including the 1-MU case),=20
> since it requires a secure-world OS in place once the LOCK_DOWN fuse was =
burned.
> It's fine by me if NXP wants to have and wants to maintain a multi-path h=
ere.
>=20
Write fuse API will be added, to allow writing fuses from secure world too.

> Last but least, the uAPI which can be used to send arbitrary ELE=20
> commands seems unusual. But I don't know how secure-enclaves are=20
> abstracted within the kernel, so these are just my two cents.

it's not unusual at all. The pattern of userspace sending commands directly=
 to the kernel via a queue is quite common like:
GPUs: As you mentioned, userspace drivers (like those in Vulkan or CUDA) of=
ten build command buffers and submit them directly to the kernel or hardwar=
e.
Secure Enclaves: In systems like Intel SGX or AMD SEV, userspace applicatio=
ns interact with enclaves via ioctl or mmap interfaces, often sending struc=
tured commands or messages.

The uAPI (userspace API) for sending ELE (Enclave Lifecycle Engine?) comman=
ds likely follows this same model - abstracting the enclave as a device or =
subsystem and exposing a command queue or ioctl interface for userspace to =
interact with it.

>=20
> I'm looking forward to the maintainers feedback.
>=20
> Regards,
> Marco
>=20
>=20
>>
>>> Regards,
>>> Marco
>>
> > Regards,
>> Pankaj

