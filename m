Return-Path: <linux-kernel+bounces-751755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF30B16D0B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 10:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABCC06203AF
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 08:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01869211706;
	Thu, 31 Jul 2025 08:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dbHcsVHw"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011037.outbound.protection.outlook.com [52.101.70.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198EC1D618A;
	Thu, 31 Jul 2025 08:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753948849; cv=fail; b=U4EYV4ymzzPNgrh9JJx9RZhT3kmN8OZjwKlqADBJ3iLr41qLBbjE45tkeNriU0ERhICGNfi0K90zdXUt7MpMiiBIE5pA5U2KI2Sh/ouzthIE5WWtHzyZi2LzyvZ6jzjqYhqHn60Q9+x4v9BAW34n4zsHvV5nd08iLocpg30LkCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753948849; c=relaxed/simple;
	bh=l7PYAiSNMFte9TLdCQ+TgMJkpgEUdryq5t1GO7RBPd0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hFpvXLlgRTuSpTFRLNu0B6i2t36MpKqn1B3ExcpiCJwB7zOffPktvw9neKizi23Ng7hZH3WIG55X1LQoxqRDWLzHvdjpWidEN2A6XF12WagdCxpo6UQjRePzYjow8xcnpuvyMfAYPaq2+e6MPNA4032SwJROOD4/pe5WMA9YLdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dbHcsVHw; arc=fail smtp.client-ip=52.101.70.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vekQBJcHgMeu3KDJjDtPBv2Ujl7d6OYjTFHMVnCaoW9INa+9tCyN4yU70+/LQ/thSlti6A4CufUbhfuozDv3iGPu7mjoDbjamfimB2jZnUwQofjkjXlZKIgicepd83QQBhZZExA4YJ2w6Yb9pF7NE/Wm36rBdajb0J5sceg/Auc1dD/YutKecB27JkyymdJLhU9BiARNIXV6iu/Gg16W4gIlAfvxatrmO+C9/LA5NZeboVNaoRYLtQru7IFSw+ZstwwTTuTpNiWXn6RS8i0aUArgZvv1j71JQ4g3LQHT5/RK6mkMzvjRSAFiIMUgyfmSch7rOXjt9MhPLp0VnqCVrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lbrjsetka8nXQAVSeT5sZIwxs1C7b+sGnQ+bEMXNAsU=;
 b=fnwIfcM4VOtVPnESC0c9iy5HgZiLJaIRTmStLhkBppmDtLYLkUKIgTxTrxBheS4vYBl6hCKJsRsO/fFIfpP79dj0igDwr7Yxhb0gHTZ1pxfIqBFL7aPURyOl2YNBfh5DtJ8g0O/fYzinUg0inv7hYLlnDchN48eu3HHr3uyrCGX5G1TopfGGL6iOVtqQYteR3r9qb0EF2idVvh6ULDf8WTYnRvU1ZH06Y+Qx+1shxH9yKUZbasdWeMkmI/Uyp8H9ecApZtTGlAACpU8CmsSCE4A236YNaRAkgUUXHzeju/XiP1FmZdbDfUdbIneEAtgWZm655NQrGtbqX44JWU/yUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lbrjsetka8nXQAVSeT5sZIwxs1C7b+sGnQ+bEMXNAsU=;
 b=dbHcsVHwAlLE0H82nCBcRcyIvf4ADv2gCAcFrqLrF/wtbHeUlwsIZIVka/+ZpwZ29clkjTvTYEUOtonZslVXl9Zz2sYjRQSzqHI69nYlT4e7fXN0SO1PdVaxfItubDmJSWOMEhjOe3bidbbsFNxGWCFd4utRGHEAX0jg7Fykdvyo1wbG/dqqpoTVIXGDo+e6IJMYlFkrTCOzVSyKkDr0x7otnPaCCCVOjCvpOWqr7FPM5ldc8DwGVdodJ+U3oMSvbu+eu5udYFkvCRjCxvd8tFYOENlOrWh+KLKoYlsmjMWq1dUE2OxSYGxz/hawhC7cZoxXDGcwStD32eXf5p3sIg==
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by AM9PR04MB7636.eurprd04.prod.outlook.com (2603:10a6:20b:281::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.12; Thu, 31 Jul
 2025 08:00:43 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%4]) with mapi id 15.20.8989.013; Thu, 31 Jul 2025
 08:00:42 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
To: Shawn Guo <shawnguo2@yeah.net>
CC: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Frank Li <frank.li@nxp.com>
Subject: RE: [EXT] Re: [PATCH v17 0/7] firmware: imx: driver for NXP
 secure-enclave
Thread-Topic: [EXT] Re: [PATCH v17 0/7] firmware: imx: driver for NXP
 secure-enclave
Thread-Index:
 AQHbtedVK8O607CHbE6OOXVUvXFh57P/eBgAgAAAcYCAASRIAIAKHEiwgB9Rl7CAAtSbgIAABcMggB+OgZA=
Date: Thu, 31 Jul 2025 08:00:42 +0000
Message-ID:
 <AM9PR04MB86046E4DD9AB38BFF2E429099527A@AM9PR04MB8604.eurprd04.prod.outlook.com>
References: <20250426-imx-se-if-v17-0-0c85155a50d1@nxp.com>
 <aEqMSG8k+NpQ7ROH@dragon>
 <AM9PR04MB86048A698B03E974CFD3DB489574A@AM9PR04MB8604.eurprd04.prod.outlook.com>
 <aEuB1qgd6aVl0i7i@dragon>
 <AM9PR04MB8604F77BCD3427B38CB9E664957DA@AM9PR04MB8604.eurprd04.prod.outlook.com>
 <AM9PR04MB8604BFF7161570CD464723FA9549A@AM9PR04MB8604.eurprd04.prod.outlook.com>
 <aHCihwHKVck-emEX@dragon>
 <AM9PR04MB86047F4AE8CF4B56947381D1954BA@AM9PR04MB8604.eurprd04.prod.outlook.com>
In-Reply-To:
 <AM9PR04MB86047F4AE8CF4B56947381D1954BA@AM9PR04MB8604.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8604:EE_|AM9PR04MB7636:EE_
x-ms-office365-filtering-correlation-id: 2ea0cf76-2d6f-4231-c79f-08ddd00858fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|19092799006|7416014|1800799024|38070700018|4053099003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?wzTP3wS51Xs6w8WkyaVu3ZyzyrlBGzM1dCPU8Mo5qoywIapJLtWCY23nf9dP?=
 =?us-ascii?Q?/UlH8mMtgKH3ZCw6crreHSffMcdYRbt9b90wYet5x5rrGASCvUT9Xb9bdYhn?=
 =?us-ascii?Q?GgH90CQp7qaxfFe8FaApoYof7Dme9zgn6XVrOwZ/QsMKizIC2RJH2TWeeI6D?=
 =?us-ascii?Q?+8fP9Caza+uTQq+FFb3SGNQcCW9+MDgz69v1o1ZqouZ/K6YNaBhMC72nxpF8?=
 =?us-ascii?Q?RU/Vw9JS6CxQoM+iPCnvn+TABwzKwoslAYi3EQekSdUtLeApwusU6XZ5h939?=
 =?us-ascii?Q?fHE5UcYlNn76Km8Pby66arECWsRFP9IZQBgXqT04JQQQqr3aDC0/lZ97Hcsb?=
 =?us-ascii?Q?ILjf2TOAwe/BItbXO0TtSvDh68uhM6ubXgnSwgS1G+aBTYWZL23BLJD8IDEj?=
 =?us-ascii?Q?7GsMxd48ijcW4igUOpo/z7lW+NELCo1t+KkoZ+tw1zU1lLLxAbshw/+jZ9T7?=
 =?us-ascii?Q?ZFftDSc5TUjrctwB3fIr0/Qa/H4Wa9gByb8uXN4h2EAUKDRngl7JBlRmSCPx?=
 =?us-ascii?Q?Y7pW8D+AFpvUH/PQiobdW4g7IJ1j1xrYJgjuo2WP1nr8xYfCgYG5lXMXUa7N?=
 =?us-ascii?Q?micZImAzL0GoeE1MIV5feUYd57mbM+omeeALSM015WRcf3QdCY0HZTfYd5dl?=
 =?us-ascii?Q?ACs8/fKus7ErWaXZoXMdPJtGQbdw98IBVCRLoHvRQ21gY9+Xyy7RCDhY6ofg?=
 =?us-ascii?Q?pl4kmQ96GAydmGtkGq9aY+hHk5S9qp277Pi9aYnHras9xEc2goCi8wUiC+7d?=
 =?us-ascii?Q?t3+/DslCqfTkcCgqn/wrM69HbCVlX6hyi09hEKmOBCx9BisV7/kMc5DZZBW7?=
 =?us-ascii?Q?k7JY2XPmnmMvJjpYKP8Z6XkwPSqIIKcCPLCfpPGR1hDYe5VVeKWrn7Gvmhi2?=
 =?us-ascii?Q?K/TfHigOXqbVTljrO4lLT/AntQnReuS5kBvca6dqcugD99mGBC8ISaIh/dR+?=
 =?us-ascii?Q?CFlbxuR6qmjKE3p2ROYZ8uJhsjhL2T432bMgXNzqQdaIlAGRetnvdp/NtNpR?=
 =?us-ascii?Q?5tqZ6YRtJ7cMEilM1WX4rti2LMz5mzs/dCdSEC/d8dPdbNlFiWYBOC+3aujY?=
 =?us-ascii?Q?NXaEA2ug+lmm7BY3tNY58qpk5SJI8cGLyb8QUAfeCB7XeT5D3pd7ZQw2EADY?=
 =?us-ascii?Q?L1uimFa7UP99TdS6Xn0jMa05GJDq0Gy67OZRQEDgHbkshlkQOqd138/m92/d?=
 =?us-ascii?Q?e8ex6YZ12He2pV7jW4cmzrA4/iaReKWS61bpcInr7UrGkPKBPxtW1ogJP4xH?=
 =?us-ascii?Q?ZdbWR5aKOiJM28r5FxZfPBADF0qvKBYf/pK+WLYmCYIwb81UIYNRGkZLS83X?=
 =?us-ascii?Q?1l3BQq79f3GovdAQC9tpKLsXf+QbyAl0XgnjmT+61COMmi3izE44WZVyKfIe?=
 =?us-ascii?Q?LU5RV7rw3cc/qDz7YItvRubBfKrvB0Go822mkUL53thqI53jtwXKYVTQhIlt?=
 =?us-ascii?Q?Z19FSj8LbR2q7K0rKu88P3RwUKQfqtb53UC8PQUR63BRxnfmNK19DEHt2Nrf?=
 =?us-ascii?Q?zyr4y2FjwvUPYl0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(7416014)(1800799024)(38070700018)(4053099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?8oKjQajG4rNrWaKtzFn/zoI5YAvLSpWIyAhCJqRdc1RT3wo3n/8Z8eIU1/Rl?=
 =?us-ascii?Q?RwKnanFjFmZxNUR8kfD67UDp99u9Ow6c8EjellaZKdDCSHQ3PEsYN0ynGoaD?=
 =?us-ascii?Q?iEIAsABlDeA1cIPCn4amQmf7QP6vTuIkOc71PoUgZFbTazyKVzHSktpvzGmK?=
 =?us-ascii?Q?DSv2TAsKZHOPLLogCiPhRNliJ8vYSAG5ZH21AskbsmCP/x5ZHZIfda7rtqO1?=
 =?us-ascii?Q?fJfIKT2/yNNaccEkjuN+ClJ6MbOnnEZCYBSy4/1kif81CYvfeFfyhOades6e?=
 =?us-ascii?Q?+Vq2vWN1arxaX7NBnAMGZR2O4hsK8MWQM7XPBuihm0rWtUUDo6zJug2scqlr?=
 =?us-ascii?Q?7MblPi+7o2BxosTHiUW3ppwmWOnlSUXR+fKP4MCZiCduTOdkDZMUkE2z4aAX?=
 =?us-ascii?Q?+ep1rtk3u2Q3ZwQjgADSdUs/dajNKSsJ7KGv2j8NVPaNPE9Bxzyhbsg39oDN?=
 =?us-ascii?Q?0XqfUIC4WLTjqNnUEOr6ueLLVRJh9p6QQfzgeVWkiC10yKzvWsCeNXesyKOk?=
 =?us-ascii?Q?RXq4Uypf6Oy6Q+qYUVXvzaFUgQtJlKYPRo1h1Ciq2eAVYADHa3le1b8i0Ht2?=
 =?us-ascii?Q?dOPsvXvx6QacCd+zbUmQGvP8DazqSqiQC42FGf1S4Zs/qTVzkFB1ZRWK8Zyi?=
 =?us-ascii?Q?qCdM1r9BLZ1pf4knPKJ+kxfYCrRYm0lQcshTX9FfsMhGomD79QLt+G+Tb65m?=
 =?us-ascii?Q?mnk9hIqQ9JjDPM2A1WMVsMxjbnfkDdrKhBQcBpbj7KqWd95+Akla/T9GXmtI?=
 =?us-ascii?Q?HDRC5hQvqxLuzfnPNOV6QIvnXvqWMxIa/S26fyx/FbuV8XKFBDJXpiAi+mOW?=
 =?us-ascii?Q?h4D38NTAHB2jOFUxzCHlQJL/p+S7vR2JSLyJPZeQ6VrQ/mkNY/HalAYIXVvX?=
 =?us-ascii?Q?g8x5h+4O7vcvpvvmDMU1gFsqZBGKnimEOmjU3Jx2gdnCVulr08742BhphD/f?=
 =?us-ascii?Q?o04cyLmsjSmveVpyqIQABcov21iRWQkpICGYdCZ1ZOgUEVU2CNq3ovmJzErH?=
 =?us-ascii?Q?FRBmKIxEXZ7fTnwe0SOKStb4QHMa4xTBfblN2Qa1CizdliDn9bwJOeujjBMo?=
 =?us-ascii?Q?dZJc+eo+yJIvjcC1apBax3R1DmrebL5Kepx98bgLKdZBabWxsTeLbzqWhIKV?=
 =?us-ascii?Q?YDtuVSRc0j+mmzyXFI++2PqdbkUBk9gP7y+ART1S8/zTGesaDcBrqt9AonrG?=
 =?us-ascii?Q?EpV1ipNfSY7PLQQFEGMv/D5uoC1iTcQgBMc4ZHVsUouuoAOv8PEdLvfXowUZ?=
 =?us-ascii?Q?drbU62q7YWyDMXi8q+0o5TFSqdM5F+uWM8msNXSYwL097UW4quNsLXzDeu+j?=
 =?us-ascii?Q?+Aj6L7yvPvoGCZ9PwtX8gZDIsQDXuPTkidg5mUukRetTZUtUkT9dE2bTIkix?=
 =?us-ascii?Q?dZr89LdBiZQkSMd6s1zjNC17KhEZw579Zt35lKv8dJs6Yrtug9eCQcczkdSH?=
 =?us-ascii?Q?rF5sBZ6hm95jnTjWOtNsmNQNhqDhVUtxKqLTetwYMxmjkItkmq4lzP221bbY?=
 =?us-ascii?Q?NOtE/5SXUFPGRGLrBEAFRW1wtkHIHcdliW9unhaEm5Mlo1onFzpNM/W0R9CM?=
 =?us-ascii?Q?UZzGh3OnZPQRWV9IEZolvRtEk2B8y2YsWdQtl6cs?=
Content-Type: multipart/signed;
	protocol="application/x-pkcs7-signature";
	micalg=SHA1;
	boundary="----=_NextPart_000_0049_01DC021F.4CC45810"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ea0cf76-2d6f-4231-c79f-08ddd00858fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2025 08:00:42.7249
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3XcmWHRTbGafVhsCgP9JBAKUVD0o9NnLz4O80opwTn+lQu2e5bznhjVqaYFKjMfxd8iZ3lrDKr/j4oR+DuROqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7636

------=_NextPart_000_0049_01DC021F.4CC45810
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

> > On Wed, Jul 09, 2025 at 10:23:45AM +0000, Pankaj Gupta wrote:
> >>>>> Hi Shawn,
> >>>>>
> >>>>> To test it on MX93, you need additional patches on top of these.
> >>>>>
> >>>>> The plan was to send the next patch-set to enable the support for
> >>>>> MX93, once these got merged.
> >>>>>
> >>>>> If you suggest, I can share the patche-set to enable MX93, as an
> >>>>> attachment to you only.
> >>
> >>>> Yes, please.  I would like to test the driver before it gets
> >>>> merged,
> >> thanks!
> >>
> >>> Please find attached the patches for enabling iMX93.
> >>
> >>> I have also sent v18 to dispose off the comments:
> >>> 1. documentation,
> >>> 2. updating the commit message with collected reviewed by tags.
> >>
> >> Are you able to test the driver on i.MX93?
> >> Any help needed?
> 
> > I did not expect those additional patches (except i.MX93 DTS
> > changes) for testing the series on i.MX93.  So, no, I didn't test,
sorry!
> 
> List of Patches:
> 0001: is required to call "init_fw" API, for SoC i.XM9x.
> 0002: i.MX93 do not have CAAM, ELE's RNG needs to be started, post
init_fw.
> 0003: iMX93 do not have CAAM, hence (T)RNG & hwrng, need to enabled via
> ELE.
> 0004: enforce message sequence flow to prevent any message exchange out
> of
> sequence. Required by power management API(s).
> 0005: additional API(s) required by Linux kernel management layers like
> NVMEM & power management.
> 0006: EXPORTED API to be used by other kernel management layers.
> 0007 & 0008: are DTSI & DTS changes.
> 
> 
> 1. If you add DTSI & DTS changes, i.MX93 board will come up with driver
> successfully probed.
> Logs:
> root@imx93evk:~# dmesg | grep fsl-se
> [    1.414748] fsl-se secure-enclave: assigned reserved memory node
> memory@a4120000
> [    1.427195] fsl-se secure-enclave: i.MX secure-enclave: hsm0 interface
to
> firmware, configured.

@Shawn: Are you able to test it till here.

Anyone who can help test this patch-set on i.MX8ULP; and help provide the
"tested-by".
Thanks.

> 
> root@imx93evk:~# ele_hsm_test --info
> 
> SAB Error: SAB CMD [0x10]  Resp [0x1329] - Unknown error code
> 
> hsm_open_session failed err:0x13
> 
> 2. If you want to use ELE test, you need to apply patches: 0001 & 0002.
> 
> Logs:
> root@imx93evk:~# dmesg | grep fsl-se
> [    1.414748] fsl-se secure-enclave: assigned reserved memory node
> memory@a4120000
> [    1.427195] fsl-se secure-enclave: i.MX secure-enclave: hsm0 interface
to
> firmware, configured.
> root@imx93evk:~# ele_hsm_test --info
> hsm_open_session PASS 0x376ace9e
> -----------------------------------------------------------
> Global Info:
> -----------------------------------------------------------
> i.MX93 A2
> Open Lifecycle
> Fips mode 0x0
> LIB Version: 1.1.1
> NVM Version: 1.1.1
> Build ID: 4060004597fe1bf9e84ec0804b98d855f1ed0e13
> -----------------------------------------------------------
> hsm_close_session[0] ret:0x0
> 
> 
> > Shawn


------=_NextPart_000_0049_01DC021F.4CC45810
Content-Type: application/pkcs7-signature;
	name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="smime.p7s"

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIImZTCCBaIw
ggOKoAMCAQICCE4Rpu+H69FRMA0GCSqGSIb3DQEBCwUAMGUxIjAgBgNVBAMMGU5YUCBJbnRlcm5h
bCBQb2xpY3kgQ0EgRzIxCzAJBgNVBAsMAklUMREwDwYDVQQKDAhOWFAgQi5WLjESMBAGA1UEBwwJ
RWluZGhvdmVuMQswCQYDVQQGEwJOTDAeFw0yMzA0MjEwNjQzNDVaFw0yODA0MTkwNjQzNDVaMIG2
MRwwGgYDVQQDDBNOWFAgRW50ZXJwcmlzZSBDQSA1MQswCQYDVQQLDAJJVDERMA8GA1UECgwITlhQ
IEIuVi4xEjAQBgNVBAcMCUVpbmRob3ZlbjEWMBQGA1UECAwNTm9vcmQtQnJhYmFudDETMBEGCgmS
JomT8ixkARkWA3diaTETMBEGCgmSJomT8ixkARkWA254cDETMBEGCgmSJomT8ixkARkWA2NvbTEL
MAkGA1UEBhMCTkwwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDAWrnSkYP60A8wj4AO
kATDjnbdgLv6waFfyXE/hvatdWz2YYtb1YSRi5/wXW+Pz8rsTmSj7iusI+FcLP8WEaMVLn4sEIQY
NI8KJUCz21tsIArYs0hMKEUFeCq3mxTJfPqzdj9CExJBlZ5vWS4er8eJI8U8kZrt4CoY7De0FdJh
35Pi5QGzUFmFuaLgXfV1N5yukTzEhqz36kODoSRw+eDHH9YqbzefzEHK9d93TNiLaVlln42O0qaI
MmxK1aNcZx+nQkFsF/VrV9M9iLGA+Qb/MFmR20MJAU5kRGkJ2/QzgVQM3Nlmp/bF/3HWOJ2j2mpg
axvzxHNN+5rSNvkG2vSpAgMBAAGjggECMIH/MFIGCCsGAQUFBwEBBEYwRDBCBggrBgEFBQcwAoY2
aHR0cDovL253dy5wa2kubnhwLmNvbS9jZXJ0cy9OWFBJbnRlcm5hbFBvbGljeUNBRzIuY2VyMB0G
A1UdDgQWBBRYlWDuTnTvZSKqve0ZqSt6jhedBzASBgNVHRMBAf8ECDAGAQH/AgEAMEUGA1UdHwQ+
MDwwOqA4oDaGNGh0dHA6Ly9ud3cucGtpLm54cC5jb20vY3JsL05YUEludGVybmFsUG9saWN5Q0FH
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
ggEKAoIBAQCsljsxzffby7IAt42e7cJH7K+49RL+7i56h3ORt8dS8WNVSdDlejp6uS6mLk/UX0wn
sSxDK1S5KquGJQzaT/3gxE8tdgvfFNBVdrgr48DeCVwWDr1o/UF3RmGcMdxqRz1M/oLDJ03C8n6h
L/0JXiwsNx0KZJoqDrN/48yX5TkoeKJmHFftZ5Op57xV0WkZJ/yLxSC1Om75jOG/UPdqsDzl+wi7
YVj5egV24hoaXgHBxtCeJzUgsHcJlo9nFtGe11j6H1vqFzkPzN9ydjRmhQATV/WLqpG8uot79u0m
6n7Mjwsd/HmJf+8xpovMcHPO2a0axppssKso/3APP6mR1FuVAgMBAAGjggORMIIDjTAOBgNVHQ8B
Af8EBAMCB4AwHQYDVR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMAwGA1UdEwEB/wQCMAAwHQYD
VR0OBBYEFLNr0DCWM1fCXv4ubOt/elkvcoiaMEUGA1UdEQQ+MDygJAYKKwYBBAGCNxQCA6AWDBRw
YW5rYWouZ3VwdGFAbnhwLmNvbYEUcGFua2FqLmd1cHRhQG54cC5jb20wHwYDVR0jBBgwFoAU5TJ6
9GbBR5Ykf/wngDlY3ysX4rswggFKBgNVHR8EggFBMIIBPTCCATmgggE1oIIBMYaByGxkYXA6Ly8v
Q049TlhQJTIwRW50ZXJwcmlzZSUyMENBJTIwNCxDTj1ubGFtc3BraTAwMDQsQ049Q0RQLENOPVB1
YmxpYyUyMEtleSUyMFNlcnZpY2VzLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9d2Jp
LERDPW54cCxEQz1jb20/Y2VydGlmaWNhdGVSZXZvY2F0aW9uTGlzdD9iYXNlP29iamVjdENsYXNz
PWNSTERpc3RyaWJ1dGlvblBvaW50hjFodHRwOi8vbnd3LnBraS5ueHAuY29tL2NybC9OWFAtRW50
ZXJwcmlzZS1DQTQuY3JshjFodHRwOi8vd3d3LnBraS5ueHAuY29tL2NybC9OWFAtRW50ZXJwcmlz
ZS1DQTQuY3JsMIIBEAYIKwYBBQUHAQEEggECMIH/MIG7BggrBgEFBQcwAoaBrmxkYXA6Ly8vQ049
TlhQJTIwRW50ZXJwcmlzZSUyMENBJTIwNCxDTj1BSUEsQ049UHVibGljJTIwS2V5JTIwU2Vydmlj
ZXMsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz13YmksREM9bnhwLERDPWNvbT9jQUNl
cnRpZmljYXRlP2Jhc2U/b2JqZWN0Q2xhc3M9Y2VydGlmaWNhdGlvbkF1dGhvcml0eTA/BggrBgEF
BQcwAoYzaHR0cDovL253dy5wa2kubnhwLmNvbS9jZXJ0cy9OWFAtRW50ZXJwcmlzZS1DQTQuY2Vy
MDwGCSsGAQQBgjcVBwQvMC0GJSsGAQQBgjcVCIWCwH6BjvRVhu2FOILrmUuaklY/hMbNXILljX4C
AWQCAT8wJwYJKwYBBAGCNxUKBBowGDAKBggrBgEFBQcDAjAKBggrBgEFBQcDBDANBgkqhkiG9w0B
AQsFAAOCAQEAWS4IrHXWhCGNWk5vn20xV7mlLkM7JPwltVJzB6MRzwUB438upbyUMwNHcEgAmHcs
xL9hafErN+n9rLL00wEqZsCV732s7YOxSRRjZTE3CmZQ2+TYjXR7A6AzQKo0fv/x43bpSes8ttQ6
Qtt8nzIbGBkDAcI7wfXsUPF5o0NwLOxre+Z+JCPNH0eaOj2J7EKD2ERLCClmvohrYdlmu85iXfyi
nJo42eq9g08FtnxTXVQSIZCtiETiGtXA7+t2Aa8429XXunsijRznaYw2SwI/s4sVmvaK3XHaif0D
QaUYxQp4s2ctzgz3eU6hK68OnNzbhBtF/lx6PHbifqHDzrtUbzCCB+8wggbXoAMCAQICEy0ACwRu
JYOozH+yQuYAAQALBG4wDQYJKoZIhvcNAQELBQAwgbYxHDAaBgNVBAMME05YUCBFbnRlcnByaXNl
IENBIDUxCzAJBgNVBAsMAklUMREwDwYDVQQKDAhOWFAgQi5WLjESMBAGA1UEBwwJRWluZGhvdmVu
MRYwFAYDVQQIDA1Ob29yZC1CcmFiYW50MRMwEQYKCZImiZPyLGQBGRYDd2JpMRMwEQYKCZImiZPy
LGQBGRYDbnhwMRMwEQYKCZImiZPyLGQBGRYDY29tMQswCQYDVQQGEwJOTDAeFw0yMzEyMjAwOTIw
NDdaFw0yNTEyMTkwOTIwNDdaMIGaMRMwEQYKCZImiZPyLGQBGRYDY29tMRMwEQYKCZImiZPyLGQB
GRYDbnhwMRMwEQYKCZImiZPyLGQBGRYDd2JpMQwwCgYDVQQLEwNOWFAxCzAJBgNVBAsTAklOMRYw
FAYDVQQLEw1NYW5hZ2VkIFVzZXJzMRMwEQYDVQQLEwpEZXZlbG9wZXJzMREwDwYDVQQDEwhueGEx
ODcxNzCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAL2JT+kRihW1mBdeZFOoCLGIl4DZ
VL7FWt3V1iFFJJe/bZDw/SUf5z1HeA8xv9+S8rqMyybjlSRHFLgiMm7qrGpVEDniKe8eiqP8Un4Y
3fHgK5FKZIVVn0KlaMuD5G30AMk9HyUdc2MkVRL8YSQCewkQDEVjB8gnx/e6xfbWEVHf5+dOWJoR
aket5+0JKV0l/dPV7cT4hL3BFtiBhq8976Li6rn8gxIi63u0G3qvm9Scqk+EHzemDhw/W+eMmGR4
nwKVLKzumxko8l6EOnnvqqF4vj2hKTpB+2lsEXH1giireMEsvB2RY40lnRUXVQ0FDklOIQV4Qdgi
EJfUdq/ZhCUCAwEAAaOCBA4wggQKMDwGCSsGAQQBgjcVBwQvMC0GJSsGAQQBgjcVCIWCwH6BjvRV
hu2FOILrmUuaklY/gbeCPIPthzICAWQCAT4wEwYDVR0lBAwwCgYIKwYBBQUHAwQwDgYDVR0PAQH/
BAQDAgUgMAwGA1UdEwEB/wQCMAAwGwYJKwYBBAGCNxUKBA4wDDAKBggrBgEFBQcDBDCBlAYJKoZI
hvcNAQkPBIGGMIGDMAsGCWCGSAFlAwQBKjALBglghkgBZQMEAS0wCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBGTALBglghkgBZQMEAQIwCwYJYIZIAWUDBAEFMAoGCCqGSIb3DQMHMAcGBSsOAwIHMA4G
CCqGSIb3DQMCAgIAgDAOBggqhkiG9w0DBAICAgAwHQYDVR0OBBYEFMJ81PK4p3H8Q7gn7u/5OwWx
uAwGMEUGA1UdEQQ+MDygJAYKKwYBBAGCNxQCA6AWDBRwYW5rYWouZ3VwdGFAbnhwLmNvbYEUcGFu
a2FqLmd1cHRhQG54cC5jb20wHwYDVR0jBBgwFoAUWJVg7k5072Uiqr3tGakreo4XnQcwggFGBgNV
HR8EggE9MIIBOTCCATWgggExoIIBLYaByGxkYXA6Ly8vQ049TlhQJTIwRW50ZXJwcmlzZSUyMENB
JTIwNSxDTj1ubGFtc3BraTAwMDUsQ049Q0RQLENOPVB1YmxpYyUyMEtleSUyMFNlcnZpY2VzLENO
PVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9d2JpLERDPW54cCxEQz1jb20/Y2VydGlmaWNh
dGVSZXZvY2F0aW9uTGlzdD9iYXNlP29iamVjdENsYXNzPWNSTERpc3RyaWJ1dGlvblBvaW50hi9o
dHRwOi8vbnd3LnBraS5ueHAuY29tL2NybC9OWFBFbnRlcnByaXNlQ0E1LmNybIYvaHR0cDovL3d3
dy5wa2kubnhwLmNvbS9jcmwvTlhQRW50ZXJwcmlzZUNBNS5jcmwwggEQBggrBgEFBQcBAQSCAQIw
gf8wgbsGCCsGAQUFBzAChoGubGRhcDovLy9DTj1OWFAlMjBFbnRlcnByaXNlJTIwQ0ElMjA1LENO
PUFJQSxDTj1QdWJsaWMlMjBLZXklMjBTZXJ2aWNlcyxDTj1TZXJ2aWNlcyxDTj1Db25maWd1cmF0
aW9uLERDPXdiaSxEQz1ueHAsREM9Y29tP2NBQ2VydGlmaWNhdGU/YmFzZT9vYmplY3RDbGFzcz1j
ZXJ0aWZpY2F0aW9uQXV0aG9yaXR5MD8GCCsGAQUFBzAChjNodHRwOi8vbnd3LnBraS5ueHAuY29t
L2NlcnRzL05YUC1FbnRlcnByaXNlLUNBNS5jZXIwDQYJKoZIhvcNAQELBQADggEBALwIIuww1PaF
EbpQoy5vgJ/4N3xS+niIpFTKyYNAD0Ar38FcUlSnj0FIHKRj8rUmZP9WTky3U8m5B3LOyhJ14FPh
iy1EwkhZmds9fJiZyEEFiwQWYDG/uknu6zIKOTlLmtlYPfbzfi58keGcjD3T5H8D8DpCGWI1lAwe
clR9fJCbcYnQSQnuicSCfrHjjXiDZ2O8h7WbE1CC6Cj/qwo5nmS0lMv7yoG94rTNBvYe8iqOkcav
7KiZA6SdhXms3ppvFmBukI6pTheMvT39SM0S6E0dgeqZSGSxHrM7dcxUdAL4fnYMv3Sa+GAgyXB6
rihWC11+goz2eawt5TRU2w45TmcxggSzMIIErwIBATCBzjCBtjEcMBoGA1UEAwwTTlhQIEVudGVy
cHJpc2UgQ0EgNDELMAkGA1UECwwCSVQxETAPBgNVBAoMCE5YUCBCLlYuMRIwEAYDVQQHDAlFaW5k
aG92ZW4xFjAUBgNVBAgMDU5vb3JkLUJyYWJhbnQxEzARBgoJkiaJk/IsZAEZFgN3YmkxEzARBgoJ
kiaJk/IsZAEZFgNueHAxEzARBgoJkiaJk/IsZAEZFgNjb20xCzAJBgNVBAYTAk5MAhM/AAV1goSs
wyqoLYNbAAUABXWCMAkGBSsOAwIaBQCgggK5MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJ
KoZIhvcNAQkFMQ8XDTI1MDczMTA4MDAzNlowIwYJKoZIhvcNAQkEMRYEFPIr2seRKiPLBLyDt/dB
5mcXNRBsMIGTBgkqhkiG9w0BCQ8xgYUwgYIwCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjAKBggq
hkiG9w0DBzALBglghkgBZQMEAQIwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsO
AwIaMAsGCWCGSAFlAwQCAzALBglghkgBZQMEAgIwCwYJYIZIAWUDBAIBMIHfBgkrBgEEAYI3EAQx
gdEwgc4wgbYxHDAaBgNVBAMME05YUCBFbnRlcnByaXNlIENBIDUxCzAJBgNVBAsMAklUMREwDwYD
VQQKDAhOWFAgQi5WLjESMBAGA1UEBwwJRWluZGhvdmVuMRYwFAYDVQQIDA1Ob29yZC1CcmFiYW50
MRMwEQYKCZImiZPyLGQBGRYDd2JpMRMwEQYKCZImiZPyLGQBGRYDbnhwMRMwEQYKCZImiZPyLGQB
GRYDY29tMQswCQYDVQQGEwJOTAITLQALBG4lg6jMf7JC5gABAAsEbjCB4QYLKoZIhvcNAQkQAgsx
gdGggc4wgbYxHDAaBgNVBAMME05YUCBFbnRlcnByaXNlIENBIDUxCzAJBgNVBAsMAklUMREwDwYD
VQQKDAhOWFAgQi5WLjESMBAGA1UEBwwJRWluZGhvdmVuMRYwFAYDVQQIDA1Ob29yZC1CcmFiYW50
MRMwEQYKCZImiZPyLGQBGRYDd2JpMRMwEQYKCZImiZPyLGQBGRYDbnhwMRMwEQYKCZImiZPyLGQB
GRYDY29tMQswCQYDVQQGEwJOTAITLQALBG4lg6jMf7JC5gABAAsEbjANBgkqhkiG9w0BAQEFAASC
AQBvjGlO+zePzC56k91OL8a9KjZzjJyq3kxmK1QEVdQ234InEkxpOEPH38RdrlbnPMLjBwgY4vR/
hgrFp6raRz4QPC3ufdPIavwkSTNcMtlj384u3/tg/Z/Bq8PsMyytlIWDfX9xlSiJp6feH6PK7rgI
GbU9KDkjJApQzwpJdfq7EpzV2STerghkMeWuNQasaPVW4OHIC3CTJVJ1QABjvQm8T7Ajg7Sx38hA
bOo9YSsgSzAi5o0PPzkRLN98F+AsgMLJ+5WJc1RqhdI3EOE4l050h0yYIHs8b+l4MBB3w4TjJini
BQwj7F4R09w+1DqYoP9SayUwplVDhF+km6+ronglAAAAAAAA

------=_NextPart_000_0049_01DC021F.4CC45810--

