Return-Path: <linux-kernel+bounces-870919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 576A5C0BFBE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 07:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B42474EF5FD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 06:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2FDE198A11;
	Mon, 27 Oct 2025 06:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ksU6nFRU"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012011.outbound.protection.outlook.com [52.101.66.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE402222AA;
	Mon, 27 Oct 2025 06:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761547425; cv=fail; b=bsNmVH/M5MUh/HGtWxQk/nRxj0r0idRnVGFDlAvaDg7gCt39leC0PvClvKI+W3Gk+/7O+DaWXy1ddEL6QN6nXc3QIjaoYCHD7ZhE4h/CpqOyZPNJPiD7ojYkazmd2EX1Y7ocAKnSmrwtKBWc/CSY8NxkewoSRpdOgoflNZ64DHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761547425; c=relaxed/simple;
	bh=zyK5fQRlY1LIfAxC9KaXMXb5QDm6s/v+AeLRjMNvIYA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DxUsyheaVcUPdK6RMMzSfSaWutSyHaTWwCaDH5NdjZJHrtPwy3A3WdbxhF9CnxpgYYY5JBS0TT6PBcbmvKmQxQv45f/zh1Bni4r0RdOuXQoTwuANhwZOK6W0sypBR3O4xZG/CbFosqmK4ETV2jtRE6Vdu8xE5oXz5F6Ohjqd8uU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ksU6nFRU; arc=fail smtp.client-ip=52.101.66.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uh6zwIwmooFPJh5mpYEgwm5u1b4OjMhwj8R1zuofG9+WnMrSCL9NAhJluDDI+mu159LhdOnMieMN+LCARL2fCOdL1aPIfWmzauq72veHCSraR5Vmc6UcUlH0q2orf5cgZ2/B0frYQHShF2qDSNdn8mp5iNIlDn2e9XZTWQBY6dHmbpa0lZzL2DY8cn2+xmNhlexodPQuwXJby5nSrLctXGqnfnYCq9R3Ogoa8rblwo5amNgqxu6tbIKz/X5sgfxRz1xqapZbZQ50miXhWnLq76C91U2Bpk3GBSnVG96sPvsB2tXCbmmFCLSror9e5JDi/5KPe2a4b+tmhPNA/S6RWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KA+wnICLTIm6+c7834nS0UibrOg70lxNjObmnFsoAGY=;
 b=Dj4r41h7FsfSkrusg2wMtb1hnmHBJPr0YvmW8cK8cblXPkxB+uXW1WVN5Y2YkoxOb4JAOeI6N9FOAtEeA1tNJwLaBtFMXvjtz3qy/PUxEM+l/Yy5RBqBlTbOKNg12KTYcKuf5YpHw3nB3bHtgeGL8+QTLMzWZxVHRuoHtAnFBAb7xpzAJJXi0NRYcNimzh9iARmUrr1wEcD7tNs+o/zGSVCd6zW1nAAK9w1Dj9rIjCVtWdfYk6eu/SgNYvXC/kn5jyWg2DEWarl9cEjjEjDwSOadaKEpbBbMlKRwfdGgKxq9n9tFAYFPexxzVjPzBzqkVK1mWT+SPYMYYs9x4znC3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KA+wnICLTIm6+c7834nS0UibrOg70lxNjObmnFsoAGY=;
 b=ksU6nFRUo6oJgIfaQx0UDKGZUItSWTiejGJuIfUtMQQLHJvqvU6Fc/BI88EVYayg0EFFApTDNIyWq6TiNqXC7ZLa41NTLZX/WwO94aplgwAgpp7oKAEdqin1IK+ofO71lSQz8Wd7PmeU5htG9+b8tNIHx460xbkdR0/xArleyaPxOOGu9xC1juOaGPwgTi+z40GazPeNj09l2GQHdSbqRsF7XJsRk5ao8JJtYbmUfChY/KxxmSzp0JOc+WsBqfQ5ocQwNx8SPMZQ5Nn6E63O2UJPvxFSeGiKsB3Fzc5nxAvIRC8YN8t00atvP3HFymBob0XaQ9qIRajfth8vrwd3vg==
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by PA2PR04MB10506.eurprd04.prod.outlook.com (2603:10a6:102:41e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.16; Mon, 27 Oct
 2025 06:43:40 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%3]) with mapi id 15.20.9253.018; Mon, 27 Oct 2025
 06:43:40 +0000
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
Subject: Re: [EXT] Re: [PATCH v19 0/7] firmware: imx: driver for NXP
 secure-enclave
Thread-Topic: [EXT] Re: [PATCH v19 0/7] firmware: imx: driver for NXP
 secure-enclave
Thread-Index: AQHcLvztIykpoCx+vU2TOsTcO77HnbTExb+AgBDxjcE=
Date: Mon, 27 Oct 2025 06:43:39 +0000
Message-ID:
 <AM9PR04MB8604C2AAA70406883320C5C995FCA@AM9PR04MB8604.eurprd04.prod.outlook.com>
References: <20250927-imx-se-if-v19-0-d1e7e960c118@nxp.com>
 <20251016114151.jzmapaecsmmnkpt3@pengutronix.de>
In-Reply-To: <20251016114151.jzmapaecsmmnkpt3@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8604:EE_|PA2PR04MB10506:EE_
x-ms-office365-filtering-correlation-id: 655a02ae-aea6-44a8-ceef-08de152429fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|19092799006|376014|7416014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?2FW4JniE9J1W6F7AizezNbZt7+H+fJCx6dMMJdiT/NIVgEq7nk+zaXJtYw?=
 =?iso-8859-1?Q?YkJDfKgnFm53Gbpc+d9WbSTRuI9IAlNnBOos2w9yCwCHF3aeVefA8KVHPB?=
 =?iso-8859-1?Q?0xRBXobPiFlJWk3yFSOe0nVvp6cZ9R0UNT6ejF6EkysrxAcPDmWgtQcyG6?=
 =?iso-8859-1?Q?kGG3WjVPNZ27V1XzEcRh1m/taQNj5+BtiIExfYiLng3L/rfrSWnumt4xyL?=
 =?iso-8859-1?Q?P+v0ErMlJ1cJ4fBimuY+yjc9uTGK4+MfQHzkQ6RkljIoXaw/CxvxboPcb+?=
 =?iso-8859-1?Q?OQXDKUKhKKM/cblvAL8GsWaWIeYMATYmHFFZpmHHp+1xTOK+gStTKqsh+z?=
 =?iso-8859-1?Q?53ViY4L5kK7A39SxzewrgrDh2S5O0LHTviGSKyOY1uRzSE4t+u23XmSwcp?=
 =?iso-8859-1?Q?pDKEnD1Egrx0MKIT1Nez6dVQgf38GxhbF8qeH6o4lZczq+6M8OHfKTDJ08?=
 =?iso-8859-1?Q?GjdBB+d0+DFzDFNTRjMJUjUdwczQsCom/VjfbgfHKf6IWi7bXb4FB92lso?=
 =?iso-8859-1?Q?npfz0IqEyrK3a+RvPF/+EhBrARKVp8RGIUulGxCOJLAW1yxTcVyZsZdHs+?=
 =?iso-8859-1?Q?qX7caPlaR/rigJT7BQIix6egtlDIS+b+h8Jn2MPCPUshfIRcDe/QZ1tnul?=
 =?iso-8859-1?Q?t22SUdcSPh3O+2mjw+APUexU0RiPostGbxJmK2P/F+pv1Gp1BHOk3CQSyx?=
 =?iso-8859-1?Q?UQ/elUF9M9UZZ7t1PdHUgjz5bhjSA0QAcdiXWNbRLgTZWSAuuNW7myoBD+?=
 =?iso-8859-1?Q?J0U4V8ZMDKt96O2FvgSJFmNokOuqdU5o5qa9T6Wzj9kWBHqDskbeyb5aKV?=
 =?iso-8859-1?Q?JwzKZaLJJzL568pyBgXa/79admiRuRezsgMubv6U8RgD4xXD0dGo3YKiVm?=
 =?iso-8859-1?Q?OaWdoe391nKlTC4kcbt0PgILfgYfT/Cxasb+nlGKYQnqpY42Mp37t0pEzF?=
 =?iso-8859-1?Q?KuM66xqUYH3iIT6DwSifFErycgtA3pzcH0lP7fbv2dNw8JEiWS8DFkZjqk?=
 =?iso-8859-1?Q?L+KE/igjYDp2TcN0QvzGgNH8FZwwuEwmzn8Pu6cGLaOcPzKXyTA1Koyk1s?=
 =?iso-8859-1?Q?4SmR9nrQ/sd+3zcxNaErGjACdM8t5Q+n0eGu+TxL86EhbboPzpEFVz3J9d?=
 =?iso-8859-1?Q?MAN8lyufmp487K7+cMFqithqUvW4RjGo22ydzS5Mkhc/LPfaZwpsm1jwl2?=
 =?iso-8859-1?Q?h3z5vpYbJjzbFfI3wBOL+FcjaxdnhQpm8qNbYGZPECizhnasUu/+iTa9F8?=
 =?iso-8859-1?Q?2vYRTcn9XpSIhh6UAZsvSma10ayLBbIx9EQEL5R5CX3rqAIetoHdEpv8ou?=
 =?iso-8859-1?Q?Pjm2Po6CBhYFkv0tXN0ZtGLWeVvU1Oedk6i63V8yvwiyKxYxRDvTIVp5Sf?=
 =?iso-8859-1?Q?ouFJf8J52bgjRtmZKwAjaW1S1K3p8x+0R4Mtj10lNBV6oEGlx5//964Qzm?=
 =?iso-8859-1?Q?EpdDwozNv5VxVIC+ZJPOZmbT2Ovh1BK/+YvDAO7AJSiQ7JFCstPGrJ1Q0l?=
 =?iso-8859-1?Q?9HBFEQXA/+wZV/7bxLXkPjWFCGd6AJdyHhKsfe21hXcw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(7416014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?6ps6HgS7z75n7ZaIP7MrYwEFRWNDfBOT6nriIlFNchzjAipXP25sjKfBAV?=
 =?iso-8859-1?Q?MGC9+A226jT+Bgsq4Yk9RWq8EoojRkzQIr6zWeOgiAltYL0yOoI8tvKLlv?=
 =?iso-8859-1?Q?uSwpC7kWn6Mp5NFtjJXXu94ALo/dw4lixtu3wzJDuIdf4kVMxjkxnI23J+?=
 =?iso-8859-1?Q?xFD3JoXJ3w6Df8THT3pSQO3QOElVAsFz8SSBMvsTEFomk24A80/CAJbq0+?=
 =?iso-8859-1?Q?3IR+GYjpEQ454uQMT+QOVSqU37QPiWLagnZxrxYpX9DVHMmAX4+jodG8qx?=
 =?iso-8859-1?Q?EORjrf9YkPJCx3gI6gwrwfJiTKTTLpzVq9Qg9cg0AlfN07/pJiNPd3/vuQ?=
 =?iso-8859-1?Q?IB2HODkle012Q/N8juKu2UC2aHZHnXj6eRX76KsZfkOKJbfLPWB54w2ZhN?=
 =?iso-8859-1?Q?OebYkCCEDGXsjWZEUMTobL35EkTQ8DjtnLAs79H0eVVnJ4pfPfkAPJhfmj?=
 =?iso-8859-1?Q?SHdilTE54KbPbfsJ4YusL/FaHcgDyH2czrqtlJCe3EIeHSR22m/YQI/Omn?=
 =?iso-8859-1?Q?Lkm9p2Hd2W9qwEAiYtLTQCk+K56aN0v9TBmANR023EBgDdGAUtLBTbFMmx?=
 =?iso-8859-1?Q?G3Uqy/zJikqFlDDGmIRGIXtA207BZiSixV44lfsBjZ4GxCxohLnwyFkF/c?=
 =?iso-8859-1?Q?woR1c4tNhXpfhuVT/BTVOCmsRtJP2PiFl3I6vldYSDjsQtmi32+dffzJS5?=
 =?iso-8859-1?Q?DkukSWkGspgxt/AMlKhK7LWzsAc/YD9gtNrCxL5yl4cm19969g2xtFtN9f?=
 =?iso-8859-1?Q?N88TFRW3Lh9aRpLsGXFcIWmQMTnTiFgczMWKSsxajwmHqSiSIDbuzMVciq?=
 =?iso-8859-1?Q?7j7nv6u6oKaVjO8xQLvGRZ2Zr9d+y9v3vXN16DOuo7zULFGQoefyc8ZJd0?=
 =?iso-8859-1?Q?8JSmywNXTk/ehdaBAxzA5/Y89WcCXumXyBsKrGx6sPbY+H4Aka31t3z/Cv?=
 =?iso-8859-1?Q?SZQwcDkIP3pQVm3c/Qjc603PrrGruxaOQJMHa3Lx/LL0LnuMfgOA6pjrnV?=
 =?iso-8859-1?Q?MTZsL+iuB3SCFcAltli5xsDrQp3gUiY9CylRWeQWej/mhmin4gWGRIGxcL?=
 =?iso-8859-1?Q?gIBlpmZX9yo1TOztf6b0exjY+VdE0Wijku5IQFWtgkHiaVi+6y2KH4jCVQ?=
 =?iso-8859-1?Q?1k28QnupOxVXWiIV+IUjdg5yMBc12OZxXyjaiADPjmXf5wSZy24RgPXVqO?=
 =?iso-8859-1?Q?Cr3cUuH72FV+3ynBaEjh5bG54zAUFMKH6HSK1zk4doTNRzYfzKiEnDVHgF?=
 =?iso-8859-1?Q?f9hmzgRqqrWuDPr1cQApRT5c8b/wW/V+hANzVyrIiTWW64N2T3YFFry2DC?=
 =?iso-8859-1?Q?J9r1aTeUlus4/Pp/+z/EhTKRqIrG722vFhwi6ha5uUok+Lk8NmlKb8Nkkt?=
 =?iso-8859-1?Q?KEICTHhlbcoLxkSJNSE2/6cZrNo3fZjdyYEMmPAJPaLm2FsB7v5oUMVFdC?=
 =?iso-8859-1?Q?Flsg27kUkh1eLOVXbMZQOosivVxZ+g+mN+nZ49hrf/TB+jGh+iRoPN3KeX?=
 =?iso-8859-1?Q?xuVTQQW/XO0nSa5RTjeBT8iWrX0twN+spTcBA711GyaFan5bhU0xeGwuhz?=
 =?iso-8859-1?Q?yx2NGxRpGYu0d46Ju9jf0RbrIArtROjWFa4vJ8seqltwXb11W4ZDQ/dg0F?=
 =?iso-8859-1?Q?mtFcAE75P1G5KUEzteQvvsaefaiV9vzr+w?=
Content-Type: text/plain; charset="iso-8859-1"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 655a02ae-aea6-44a8-ceef-08de152429fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2025 06:43:40.0297
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jKaiH/Wt2Spe23YLpN4qL6Owv5jyhBpjyI/1LNPRJDHyf6mV6nFGlvLgC9Oy3gkhkjFnp3/LXHKk8oVVdbZCtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10506

On 25-09-27, Pankaj Gupta wrote:
>> Highlight:
>>
>> There are long discussion at V18 with Marco Felsch.
>> https://lore.kernel.org/imx/AM9PR04MB8604F5A7DD8B1E41FDAD09039501A@AM9PR=
04MB
>> 8604.eurprd04.prod.outlook.com/
>>
>> The key point is about using OP-TEE OS.
>>
>> Marco's questions:
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> Q1. Both MU(s) from each world - Secure & Non-secure, cannot be used
>>     simultaneously. Why?
>> A1. ELE FW fix is available, where concurrent access to ELE from both th=
e
>>     world is working. This fix is not required for the current patch-set=
 for
>>     i.MX8ULP.
> According https://github.com/OP-TEE/optee_os/pull/7268/commits/83b516edc0=
270ca8300ce524a0c3d560e67a0f48#r1955899462
> there is no fix yet. Can you please point me to the fixed version?

It is not yet up-streamed to OPTEE-OS repo.
Fix version is part of NXP LF Q3 released on 30 September.
Commit can be found on this URL: https://github.com/nxp-imx/imx-optee-os/co=
mmits/lf-6.12.34_2.1.0/.

One more fix is coming in LF Q4. After that, these patches will up-streamed=
 to OP-TEE-OS.
Then you will be able locate it in OPTEE-OS git repo.

Since the current Patch-set is for i.MX8ULP, where concurrent access from b=
oth the world is not possible.
In context to i.MX93, for OPTEE-OS patches, request you to please discuss i=
n OPTEE community. Not here.

> Also, can you please outline why the fix is not required for i.MX8ULP?
> Unfortunately I can't remember.
There is no Trust-MU for OPTEE-OS in i.MX8ULP. The ELE driver in OPTEE, is =
disabled for i.MX8ULP.
Moreover, there is CAAM in i.MX8ULP, which is used for security services, i=
n OPTEE-OS.

>> Q2. How is the secure and non-secure world talk to the ELE if there is o=
nly
>>     one MU?
>> A2. From i.MX9x & onwards, SoC(s) has at least one dedicated ELE MU(s) f=
or
>>     each world - Linux(one or more) and OP-TEE OS (one or more). Has upd=
ated
>>     the commit message of 3/7.

> Does apply to the i.MX8ULP SoC as well?
No. Since there is no trust-MU for OPTEE-OS, on i.MX8ULP, to communicate wi=
th ELE.

> The NXP name scheme isn't very easy to follow.

>> Q3. How exactly do the eFuse write access after the device was locked do=
wn,
>>     will be provided with single path; for the following case?
>>     - For a verified boot setup, you need to burn an eFuse at some point=
,
>>     to tell the bootROM to boot only correct verified firmware images.
>>     - After this lockdown, it's no longer possible to burn eFuses from t=
he
>>     REE, while the production line setup still requires the support.
>> A3. OP-TEE OS supports read fuses, currently as part of our quarterly re=
lease.
>>     Write fuse will be in coming release. Please note that the current p=
atch-
>>     set does not contain any read/write eFuse feature.

> But one of your patches is mention it, right? So there will be still two
> paths.
Due to lack of trusted-mu, there is no way to read/write fuse on i.MX8ULP, =
from OPTEE-OS.
For current patch-set, it is the single path.

> Also according your IOCTL docuementation you want to expose the whole
> device to the user-space?

> | What:          /dev/<se>_mu[0-9]+_ch[0-9]+
> | Date:          Mar 2025
> | KernelVersion: 6.8
> | Contact:       linux-imx@nxp.com, pankaj.gupta@nxp.com
> | Description:
> |                NXP offers multiple hardware IP(s) for secure enclaves l=
ike EdgeLock-
> |                Enclave(ELE), SECO. The character device file descriptor=
s
> |                /dev/<se>_mu*_ch* are the interface between userspace NX=
P's secure-
> |                enclave shared library and the kernel driver.
> |
> |                The ioctl(2)-based ABI is defined and documented in
> |                [include]<linux/firmware/imx/ele_mu_ioctl.h>.
> |                ioctl(s) are used primarily for:
> |                        - shared memory management
> |                        - allocation of I/O buffers
> |                        - getting mu info
> |                        - setting a dev-ctx as receiver to receive all t=
he commands from FW
> |                        - getting SoC info
> |                        - send command and receive command response
                                ^
> This is a rather uncommon approach. The kernel has interfaces to
> abstract hardware. You completely bypass this if you expose everything
> to the userspace.

It is in-correct.
Not everything, just exposed file-operation. and ioctl(s) for DMA(eable) bu=
ffer allocation from reserved lower memory region.
Things managed by Kernel:
* Send/receive path to ELE, is managed by Kernel.
* Receive/send patch to the ELE's slave NVM-manager, is managed by kernel.
* Low power management handled by kernel driver. In case of low-power state=
, ELE driver re-init the V2X IP as part of resume.
* Other kernel management layers like NVMEM, kernel HWRNG, will use the api=
(s) exposed by this driver.
* Loading the runtime FW.
>
>> Q4. What is the ELE behavior if the secure-world stresses the ELE? Is th=
ere
>>     a MU priority so the normal-world MU may get blocked (never addresse=
d)
>>     or are both MUs scheduled in round-robin?
>> A4. ELE will pick the message from Both MU(s), based on FIFO.

> This doesn't answer my question. How gets the FIFO filled? If the one of
> both worlds aways keep the MU busy?

If both the world is keeping the MU busy. ELE will pick the first incoming =
message, let's say on MU#1,
While acknowledge and queueing the incoming message on the other MU#2, to b=
e picked once
the handling of the current message at hand is completed. Despite the MU#1,=
 is bombarded
With next message, but it will process the message from MU#2, while acking =
the incoming message
from MU#1. And add it to its queue. This way FIFO is maintained by ELE.

>> Q5. Why ELE performance matters?
>>     - On i.MX8M, which uses the CAAM (the ELE predecessor), It can be
>>     verified that the ARMv8 CE are much faster than the crypto-engine it=
self.
>>     Therefore the CAAM is mostly unused.
>> A5. User looks for both type of implementation based on their usecase:
>>     - Certain users still offload to CAAM, to save their ARM CPU cycles =
for
>>     other priority tasks.

> I have never seen such designs but okay.
I assure you, there are several such cases with our system-engineering team=
.

>>     - While certain customer choose ARM-CE for the crypto offloads for b=
etter
>>     performance.
>>     As far as ELE is concerned, it is not a crypto accelerator like CAAM=
.
>>     Performance hungry crypto-ops are not recommended to be offloaded to=
 ELE.

> I don't get this point. So NXP doesn't recommend to use the ELE for
> crypt-ops?
NXP does not recommend to offload the Crypto-Op to ELE, for performance cas=
es.

>> Q6. For the IOT-cases where real-time encrypted feed from sensors, will =
take
>>     latency hit, Does the ELE support inline en-/decryption?
>> A6. Yes, ELE support Inline Encryption Engine (IEE), starting i.MX95 onw=
ards.

> May I ask, how is this connected and which interfaces are connected to
> the IEE? I would have checked it by myself but unfortunately NXP doesn't
> provide a TRM for the i.MX95 yet.
We can discuss this in greater depth on one-one email, where I will touch u=
pon the IEE and its interfaces.
But, like to inform that there is not IEE on i.MX8ULP or even on i.Mx93.

>> Marco's Suggestions/NXP response:
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
>> S1. Below listed ELE access requirements, can be done from OP-TEE OS in =
all
>>     the Life-Cycle states. then Why to use Linux?
>>     - eFuse access (done via  OP-TEE OS i.MX specific PTA): OTP eFuse R/=
W access
>>     after doing the LOCK_DOWN fuse is no longer possible without  OP-TEE=
 OS. This
>>     involves general purpose (GP) eFuses too.
>>     - ELE ping every 1 day (kernel SMC WDG driver, OP-TEE OS wd driver).
>>     - HW-RNG (kernel HWRNG driver + OP-TEE OS HWRNG PTA).
>> R1. There are i.MX9* users, that are not using OP-TEE OS, but still want
>>     to use ELE features from Linux. So, these users are requesting for t=
his
>>     driver in Linux.

> Which ELE features?
All the features from Linux, when OPTEE-OS is not present like:
* Read/write efuses. (eg NVMEM Kernel driver). Where there is no requiremen=
t to chenge the eFuse, during SoC in provision lifecycle.
* Low power management at Linux driver.
* Linux HWRNG.
* Loading the secondary runtime fw.

>>     As suggested by you, writing to eFuse after life-cycle closed state,=
 the
>>     driver in OP-TEE OS is needed.
>>     Though there are other OP-TEE OS features too, that needs to be offl=
oaded
>>     to HSM, for security reasons, like:
>>     - Hardware Unique Key(HUK) getting generated.
>>     - OP-TEE OS's ASLR seed generation.

> We're talking about features the normal world wants to have access too,
> since you said ".. but still want to use ELE feature from Linux ..". The
> HUK and the TEE ASLR seed is clearly not something Linux wants to have
> access too.
You misunderstood my point. I was stressing that there is a need for two pa=
ths,
each from Linux and OPTEE-OS, in order to expose different feature-set requ=
ired
by respective worlds, where 1 or 2 overlaps, while maximum are utilized by =
respective
worlds.

>> S2. Having one implementation is beneficial in the following ways:
>>     - Multiple paths also requires more maintain- and testing effort.
>>     - FW files with having +1 FW for the new i.MX9*, where there are ple=
nty
>>       already eg.: bootloader, TF-A, ele-fw, scu-fw (i.MX95), increases =
the
>>       maintenance on both the paths.
>>     - TEE code could be reused by other OSes.
>>     - TEE is used anyway for new projects due to CRA and friends
>> R2. As conveyed in R1, there are Linux only users, that are dependent on=
 SE
>>     Linux kernel driver.

> What difference does it make if these Linux-only users get the ELE
> access via OP-TEE? It's just one binary more.
If the User does not choose to include optional OPTEE-OS, then ELE access
must be from Linux driver.

>> S3. Having one implementation is beneficial in the following ways:
>>     - Adding the support for it to  OP-TEE OS do not requires ELE-FW.

> I never said that this requires no ELE FW! I said it requires no ELE-FW
> update! Was the update already rolled out?
Yes, the updated FW is already release part of LF Q3 released on September =
30, 2025.
It is not released as part any open repo.

>>     - Concurrent access handling is done by the TEE core.
>> R3. As already mentioned that ELE FW fix is available, for concurrent ac=
cess.
>>     Please note that FW fix is not required for the current patch-set.

> Can you provide us a link to the fix please? The fix should fix the
> concurrent normal-world <-> secure-world MU access issue. Why is this
> fix not required if I have a running OP-TEE?
The fix is very much required to run concurrent access for i.XM93 and onwar=
ds.
But not for i.MX8ULP and current patch-set is based on i.MX8ULP.

>> S4. This series causes more confusions till the ELE FW fix is available =
to
>>     allow concurrent access to ELE from both the worlds.
>> R4. FW fix is already available, and concurrent access is enabled by def=
ault
>>     in LF Q3'25, release. Please note that FW fix is not required for th=
e
>>     current patch-set.

> Please provide a link to the new FW and why is the fix nor required for
> this patchset?
Again. The fix is very much required to run concurrent access for i.XM93 an=
d onwards.
But not for i.MX8ULP and current patch-set is based on i.MX8ULP.


>> S5. Suggesting to add the  OP-TEE OS support for the required features e=
.g. eFuses,
>>     watchdog, HWRNG. The whole Linux part is mostly in place.
>> R5. Yes, the secure world features like eFuse read/write will be added
>>     to OP-TEE OS. Please note that this patch-set does not contain any r=
ead/write
>>     eFuse feature.

> I see, instead it expose the whole ELE to the userspace if I got it
> correct according to your IOCTL documentation. This would be even worse.
No, it is not a correct interpretation. As mentioned above, ELE driver abst=
ract
all the hw interaction to have easy and simple file bases operations.

> Regards,
> Marco

Regards,
Pankaj

