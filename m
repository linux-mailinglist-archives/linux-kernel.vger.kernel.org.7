Return-Path: <linux-kernel+bounces-892418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC78C450C2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 06:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 319C94E7E81
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 05:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0A22E8B95;
	Mon, 10 Nov 2025 05:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="m2+uO5C6"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012063.outbound.protection.outlook.com [52.101.66.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADC61EF092;
	Mon, 10 Nov 2025 05:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762754086; cv=fail; b=ZBpcxut2W8zGdW+xoS/tDkSBFsKaNXU4pWBGrGRV3fD8AJ9mHvaeLDvyZYmdvmdWSaDupXE+Cgi6U5usxKyPj8n+tEcCMY1CGd3ZCnNJB8Q3nJA8l+Kg4P/6oeM4gN3EgBHbABuOt69BRkIyydwd5D/pyj90SXydGMBVIJxW/gE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762754086; c=relaxed/simple;
	bh=O0LjH9/x8DOGsG+mEhk/vyxsoJbD8fVwHmsSk7zV+G8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YIbDyl5yXvJxXxn2iWaOl+wZkJz0MKcDjZbHwg77kSPvPCuYNX5EKwDglJAPnkGaAFbcKh9U72qKTkq3jkqeE+dqZ5SVbFpufqDeMXP3MOkxdQoAhoBlTS+HhoN1B1PoqNfS4inDHgYBW1RdCxiSWAYRYLe7jR/pRqRetDrvfkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=m2+uO5C6; arc=fail smtp.client-ip=52.101.66.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NQZrtQ6Z2kX/hKUJp+s2PqQH1yu1CDX8UxakMp9v0AHYKSE/H3Y7edlHSh7q110wR1qK2fU1eLPIg+fAGXom7SEwAa7gwN7dUJizthhvG2z5NVUIG+hL9z7TG/lqop4tMMKx8TzBd661dDyk9CPIs1pvb5YNnSDE4JmvCbMINnhE8lTiHNnmZXLgUIMt7g3U+0X9em/VwAwya75twu+fX8yVIpWo+2cc5UmXuN1KtRpy10mFu3Qoy5LMq7t8Ej2ya0GfpICfpnABUp3TlOgbTgsxfTk4HvBH+3OA6XqsCN5KAJ1dUB1D0BgPiu+QagwQIdJn8Me3FaU6QQTKbRt+aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nEsc2s1ueWABbli9JFXKA1x0ZaGSCX8R3V7jB2zIJ/4=;
 b=m+/4Z5atSmf6DR++QRjpJ36alrfRKcQT2YDLoJNW55CVv1hhgANL9eyJBYjQKItjA6fkhd5deJscc4hRUAn0QoUnAanFD2mf3KGV2DzQWGDn/OD8Lfp4WQQe1uZXv3IA0lh9aHr1z38Y8U0wgkyaflptqFLZPOD+YYKEIqZ5oQKpFfSr5CXSYrnZMYdIkrStWltzKP6DcKjGaZ065944dA1uP3TXg6JFj845RL6NidlrtcjV7ym77vSWn8IZpDIALWH718PNBBm9nIlXN7BLGEQTzvs3wLvQYVfCWiMjCXBURzppeYZokuh0Z/3R2sjB656sOXY2gQuTEJJ7ydQ4og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nEsc2s1ueWABbli9JFXKA1x0ZaGSCX8R3V7jB2zIJ/4=;
 b=m2+uO5C6iyu8N+XhLpbuD4kH2e//KNt+W59P+YC0v/fY88rcbxhSqaBAI2jfaB4AneRcQ8VOY94x7h4/V+/9h5tl6+ZARQzqIJRTnTlZtn3writmVHTU2YsD2DHiaRxPShi/HOs8OYqHXn1q5GJkpqLIPoP+vQMAk0MiqVLxDenEXvHW835xIFKKGpS4T8viGmLmrleWlPAhqxyF60PNfx4fR2oEgkZZM+tF2iaGlJAFjYxLYMqHYygGFgwMhadJQK1m5rwm6aafAr/w8EvNbfy4sudwlrdldHszZsLMdZal+gMPh7j+6U8STN2Tk+ibYXKWnI4KLNb7tvqwIs8QCw==
Received: from AM7PR04MB7013.eurprd04.prod.outlook.com (2603:10a6:20b:116::18)
 by GVXPR04MB10021.eurprd04.prod.outlook.com (2603:10a6:150:112::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 05:54:39 +0000
Received: from AM7PR04MB7013.eurprd04.prod.outlook.com
 ([fe80::6f59:bb3:6440:a4a0]) by AM7PR04MB7013.eurprd04.prod.outlook.com
 ([fe80::6f59:bb3:6440:a4a0%4]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 05:54:39 +0000
From: Joseph Guo <qijian.guo@nxp.com>
To: Joseph Guo <qijian.guo@nxp.com>, Francesco Valla <francesco@valla.it>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Fabian Pflug
	<f.pflug@pengutronix.de>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Tom Zheng <haidong.zheng@nxp.com>,
	Danwei Luo <danwei.luo@nxp.com>, Lei Xu <lei.xu@nxp.com>, Justin Jiang
	<justin.jiang@nxp.com>
Subject: RE: [PATCH v3 2/2] arm64: dts: freescale: add support for NXP i.MX93
 FRDM
Thread-Topic: [PATCH v3 2/2] arm64: dts: freescale: add support for NXP i.MX93
 FRDM
Thread-Index: AQHcUgNEViQzu+2P9kegZQBwJV6317TraKhw
Date: Mon, 10 Nov 2025 05:54:39 +0000
Message-ID:
 <AM7PR04MB7013221705AF2AE771B8342A94CEA@AM7PR04MB7013.eurprd04.prod.outlook.com>
References: <20251022-fpg-nxp-imx93-frdm-v3-0-03ec40a1ccc0@pengutronix.de>
 <20251022-fpg-nxp-imx93-frdm-v3-2-03ec40a1ccc0@pengutronix.de>
 <7192181.9J7NaK4W3v@fedora.fritz.box>
 <aRF4pYXtMMMO0NZg@lsvm11u0000395.swis.ap-northeast-2.aws.nxp.com>
In-Reply-To: <aRF4pYXtMMMO0NZg@lsvm11u0000395.swis.ap-northeast-2.aws.nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR04MB7013:EE_|GVXPR04MB10021:EE_
x-ms-office365-filtering-correlation-id: 169693e3-f544-4acf-aa04-08de201da340
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|19092799006|7416014|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?hFOObvG37St/iZIgsaakLTE5JSy5qX8Hup5JCXP+M24Mmc3pcDzrwV5FwJ/P?=
 =?us-ascii?Q?c070gGDkuKHpnkUSKSuaAOORxFr8f+hz5JhLNliMj/OgENQdyjm+c7TczHPz?=
 =?us-ascii?Q?gFLkjXacuC+YNsa9k2QjRHdE7eKXG6OlTP1TcOtmdBvOiWaITNMQx2JymloV?=
 =?us-ascii?Q?hYy3sAL84v35KXLRZNnpFJk9BApg+TpwBq0z2TYDz8iCbrSEV6NfIfsdZqoT?=
 =?us-ascii?Q?bYfvG8i5I25Zw7hVQlW1bHNvg+S7s/z8LkmhOOQiafnOq8jD0CJp7pD8kY5s?=
 =?us-ascii?Q?wfhQZyyB7uYBQUAxqUpFbzjd326fvKQFsgvPNlhUicL7fxp0TJsXkPN+jD1+?=
 =?us-ascii?Q?UbMhr4N3EH8TtxxUn2napICroRGI+gqXbBHB+BhK7sELcB/GI7OvSbvL48/l?=
 =?us-ascii?Q?7s82nxeAGeR8NMjIgGdxtjQxgVZrjMIpjjqWLLwfWl9mlD62MY0mr6UBo12/?=
 =?us-ascii?Q?BfRRC0KJPHfAS0Nj8eb0eIFFKBpyt/SKhYI+KDhvJYn243uslrvA98SAPzla?=
 =?us-ascii?Q?frd/sgtDIfeObdyQIRtBejp6shzJ0Eypwq9bCf2R6MJwcYTWpOMzuoWObR0h?=
 =?us-ascii?Q?bRpcJXUdNclv4mGzRxYNhtf+d1dUWY7YAbsQcmiDcvNDuFOgcYu4D4BsuhxP?=
 =?us-ascii?Q?OVmzaYLtStUC3nAig488+/7ZTcj+JCAB728hjm+GlteTjjSqusq8A/BBwtJP?=
 =?us-ascii?Q?GNtdkVVHcI0qUycjM6yL+wAfCDJVeL9dsv7rMouAeCC/WzOpxDgrLkCv6swu?=
 =?us-ascii?Q?sW+7Dl6M9sjYEmTSsVjDiWRHQdMgSGEIG0sPqJpNmsZXnhoW8S/dagXw8pVI?=
 =?us-ascii?Q?b6aqzcPZPbDwjNMNy7ipze5sQJ1KW6WoCTzJKBolilIh7UXVb5QMLvSBYLqW?=
 =?us-ascii?Q?yn9/JhFj3ojGbAI24gneYWuG/Qfk1DLbCi5vgANgRIqCWOqNU/fZNLL5NvMQ?=
 =?us-ascii?Q?VFn8yENKFUMouM0O67VycDuS05bnlT8Kqu6u3LsYo4TVz8OSLOl0dj36I/fR?=
 =?us-ascii?Q?pce1wU4O3ree6BiuF8wRGilOxcseUFZMC3NMlM9fg+a1zLNnPwd0pC61/2LU?=
 =?us-ascii?Q?ntsN5sR31kfAHo4D8gSJxA4paX9qUrZeAwNCY7Mhq4BqGgI+TdIrTFN94Ivk?=
 =?us-ascii?Q?TJxCVIo89oZ+8JaTLxWgvJEhl6Z+jTG/WJ7WF1BKM/MhxXMxoS7UWOo8LkQy?=
 =?us-ascii?Q?uDNqB6+z8fvCj3kg81Dg1RXu6oml9WA2jZL0nNctLfWRArEnoIOZywou9d+j?=
 =?us-ascii?Q?LBxQ6Igu6Nycpn6ojP63knX11J3llLo4avTNld+D6lAFayED+BuGeT1GUbkC?=
 =?us-ascii?Q?saM8Yh2Iz25W+l1mSxd4MtPvxFHGahTuBfRrcC1Vox0JdHHSER6jCUMAN/Jj?=
 =?us-ascii?Q?fu4nX34/v/yEiu2m/iz6LCbkuUNSGb+U3YdIWP/D1ORpUeRGBvbYLfQElaQD?=
 =?us-ascii?Q?MTtyQphdVJ5hHS4MwXVAsy9HfHvvXlehYf4stYzg30ZWsEtcohvBd3CCnKuZ?=
 =?us-ascii?Q?3G2kMnSi7uk+V/zwyrzcAjccjgY8btaKHELd?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7013.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(7416014)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?dPPGzPW1BDjzfXqa9wxQZ5hlDIUfNndCV8zNRdWTAHZm26XraGsYD/eXyHgF?=
 =?us-ascii?Q?gyUHT3SW1bhGsCAYscJQjXc0PLcSbqDaMxmn6jdlSbSANcPg0++g5OWGWzxR?=
 =?us-ascii?Q?giLa5LVk1r3PJ5Sp+7qK0T8Q+Rwf0M7mIUikwNbo1yCF/6+VXpQSDLXAvez+?=
 =?us-ascii?Q?L+h1rkiqhm8ru8ncJrgjaUwEYakYEh/KfiyciEIi+t2vRg+6uLcofdmOpk9t?=
 =?us-ascii?Q?nkJgKO3oK8j6qmTsZo99bkDWXafMr976Mmf7Yj1QkIqS7if7IalrwevJaoUi?=
 =?us-ascii?Q?qU+Aq6xXcDbnpN7qE74zDJUz0CZ7IrEm6UYhMejyPqC8MDdLY0ahB6FPt/tI?=
 =?us-ascii?Q?ieSLPAmkvR72Ap8w6Rn6H5k3a0HGLFy0gDOldXPWrmcbKCPo7HaBiPSFNooM?=
 =?us-ascii?Q?jqQiyKYO2qtcC+hmDbBkz3XAM+yZhjWE4eGOE4lk95BcTemFF0Q5XaPPzk+q?=
 =?us-ascii?Q?L2L/+0jGTBA6llhcOoMICNmiU90wxFsB3LblKDSarGbzo7+64T+461YVZhiL?=
 =?us-ascii?Q?38Vho+03AYX/WMq+LsgTQJPTH8glwH1ycGru3mMj8vu864/rnNcKBL2JnP59?=
 =?us-ascii?Q?Ya7cJzoZCy/b7NMNH7t2UA5v8hl+aYIVoRgLjjrwi0qkSmGE4dmirTAiU+lX?=
 =?us-ascii?Q?2MoQWGpvzSRyR0irNYsHsLEX5N31xk9dMUdFmWCgsQRvIBjtpVfiM4azdWHK?=
 =?us-ascii?Q?evNspyk8uGbmm1IdcXrAZcwSjO63H4mIze2wQauQPTlOdDKs/lK0r7p/4y7W?=
 =?us-ascii?Q?72OrBatwSM/L6IHccniKvUjHUs/7c9/y2KET1MP69oUOACVBCdHbI8HvQ8bR?=
 =?us-ascii?Q?GrNzOjjhCM+vs3t5ERmOXVtTsx0uGtr8xnojY0HUzZMonnvTKha8T94L/6AB?=
 =?us-ascii?Q?MAd80gYgxgFzHEYe2gKDgSEfnxjqy7/MBsUqD7Qm9dbH/jCDiCP/D/xN1HPb?=
 =?us-ascii?Q?TjGUnBeiNmRXAJBGDzTOkv4jzn2E8LkTJJAHEZDd2UWgPvnIn8FZSL+1Czrd?=
 =?us-ascii?Q?nejCQ3t+eE/QcZxMLhu364k3bd0Ro7/d5Kj6NiXVfzAWtT53nUIWVJebGOGW?=
 =?us-ascii?Q?BQdQnuKVG8fRxpmEO85e8B2tfTIsOObUae2cE3bj6SybggZ1GKW+oZKGAHXK?=
 =?us-ascii?Q?yG14NM3XwMGYpW6JrMKtjtjPcEvjMfbHkjSRsXqWkxQpMmR+3Kob2+g6JDch?=
 =?us-ascii?Q?nCubb00jhXQVj7aArGkF2g4SP1fg2ReSZgEn2HF2ltutSpQGeqS/Sz1jIEq/?=
 =?us-ascii?Q?j/decWMStbHk5y5aIMpFn4Rhtdi7By9MeCycZmR4fDjwjNlREPsvRR1qd+9B?=
 =?us-ascii?Q?IoGcWsMFqmse0h3BX7PE7VmTEVDiBEyAdVHugq1xm9bflc9e7gv8N/wPsoVh?=
 =?us-ascii?Q?YYoee29lG/+a/ms27uP6L82MrE0QoqKHy5jB1nIYK8HhmfdU5TZIlOUSoMR7?=
 =?us-ascii?Q?3D19uEiVcOGjlUMbJJN7mH8eU6lOhI5Sc9AAwScwn+1bbhsPmPJP6Eom3bk5?=
 =?us-ascii?Q?d+tSGVu06NMFN3JjtE5aeeKPN8/uMquXbk6ofEdy1AUM/Ju/a4U8HyjFF+4g?=
 =?us-ascii?Q?efe6jTrjgBxUGOzTvPEkxPlG4Wr6nUMuQFVhWeQq?=
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
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7013.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 169693e3-f544-4acf-aa04-08de201da340
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2025 05:54:39.8100
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x+MiHIQSrNSM7+/WkkH8KbBr4urjMxv2V4fwsMoJ2rXOWlKJDPDTthdcXMChGn17csV2NgV+RsdFoHWOufqwaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10021

> -----Original Message-----
> From: Joseph Guo <qijian.guo@nxp.com>
> Sent: Monday, November 10, 2025 1:31 PM
> To: Francesco Valla <francesco@valla.it>
> Cc: Rob Herring <robh@kernel.org>; Krzysztof Kozlowski
> <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>; Shawn Guo
> <shawnguo@kernel.org>; Sascha Hauer <s.hauer@pengutronix.de>;
> Pengutronix Kernel Team <kernel@pengutronix.de>; Fabio Estevam
> <festevam@gmail.com>; Fabian Pflug <f.pflug@pengutronix.de>;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
> imx@lists.linux.dev; linux-arm-kernel@lists.infradead.org; Tom Zheng
> <haidong.zheng@nxp.com>; Danwei Luo <danwei.luo@nxp.com>; Lei Xu
> <lei.xu@nxp.com>; Joseph Guo <qijian.guo@nxp.com>; Justin Jiang
> <justin.jiang@nxp.com>
> Subject: Re: [PATCH v3 2/2] arm64: dts: freescale: add support for NXP
> i.MX93 FRDM
>=20
> On Wed, Oct 22, 2025 at 10:28:22PM +0200, Francesco Valla wrote:
> > Hi Fabian,
> >
> > I restarted working on my FRDM just a couple of days ago, so this will
> > probably feel like a late review for the v2. Anyhow...
> >
> > On Wednesday, 22 October 2025 at 16:05:23 Fabian Pflug
> <f.pflug@pengutronix.de> wrote:
> > > The FRDM i.MX 93 development board is a low-cost and compact
> > > development board featuring the i.MX93 applications processor.
> > >
> > > It features:
> > > - Dual Cortex-A55
> > > - 2 GB LPDDR4X / LPDDR4
> > > - 32 GB eMMC5.1
> > > - MicroSD slot
> > > - GbE RJ45 x 2
> > > - USB2.0 1x Type C, 1x Type A
> > >
> > > This file is based upon the one provided by nxp in their own kernel
> > > and yocto meta layer for the device, but adapted for mainline.
> > >
> > > Signed-off-by: Haidong Zheng <haidong.zheng@nxp.com>
> > > Signed-off-by: Danwei Luo <danwei.luo@nxp.com>
> > > Signed-off-by: Lei Xu <lei.xu@nxp.com>
> > > Signed-off-by: Fabian Pflug <f.pflug@pengutronix.de>
> > > ---
> > >  arch/arm64/boot/dts/freescale/Makefile             |   1 +
> > >  arch/arm64/boot/dts/freescale/imx93-11x11-frdm.dts | 658
> > > +++++++++++++++++++++
> > >  2 files changed, 659 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/freescale/Makefile
> > > b/arch/arm64/boot/dts/freescale/Makefile
> > > index 525ef180481d3..a7e5fdd6faff1 100644
> > > --- a/arch/arm64/boot/dts/freescale/Makefile
> > > +++ b/arch/arm64/boot/dts/freescale/Makefile
> > > @@ -351,6 +351,7 @@ imx93-9x9-qsb-i3c-dtbs +=3D imx93-9x9-qsb.dtb
> > > imx93-9x9-qsb-i3c.dtbo
> > >  dtb-$(CONFIG_ARCH_MXC) +=3D imx93-9x9-qsb-i3c.dtb
> > >
> > >  dtb-$(CONFIG_ARCH_MXC) +=3D imx93-11x11-evk.dtb
> > > +dtb-$(CONFIG_ARCH_MXC) +=3D imx93-11x11-frdm.dtb
> > >  dtb-$(CONFIG_ARCH_MXC) +=3D imx93-14x14-evk.dtb
> > >  dtb-$(CONFIG_ARCH_MXC) +=3D imx93-kontron-bl-osm-s.dtb
> > >  dtb-$(CONFIG_ARCH_MXC) +=3D imx93-phyboard-nash.dtb diff --git
> > > a/arch/arm64/boot/dts/freescale/imx93-11x11-frdm.dts
> > > b/arch/arm64/boot/dts/freescale/imx93-11x11-frdm.dts
> > > new file mode 100644
> > > index 0000000000000..1f21eeb15b721
> > > --- /dev/null
> > > +++ b/arch/arm64/boot/dts/freescale/imx93-11x11-frdm.dts
> > > @@ -0,0 +1,658 @@
> > > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT) /dts-v1/;
> > > +
> > > +#include <dt-bindings/usb/pd.h>
> > > +#include "imx93.dtsi"
> > > +
> > > +/ {
> > > +	compatible =3D "fsl,imx93-11x11-frdm", "fsl,imx93";
> > > +	model =3D "NXP i.MX93 11X11 FRDM board";
> > > +
> > > +	aliases {
> > > +		ethernet0 =3D &fec;
> > > +		ethernet1 =3D &eqos;
> > > +		i2c0 =3D &lpi2c1;
> > > +		i2c1 =3D &lpi2c2;
> > > +		i2c2 =3D &lpi2c3;
> > > +		mmc0 =3D &usdhc1; /* EMMC */
> > > +		mmc1 =3D &usdhc2; /* uSD */
> > > +		rtc0 =3D &pcf2131;
> > > +		serial0 =3D &lpuart1;
> > > +	};
> > > +
> > > +	chosen {
> > > +		stdout-path =3D &lpuart1;
> > > +	};
> > > +
> > > +	reg_usdhc2_vmmc: regulator-usdhc2 {
> > > +		compatible =3D "regulator-fixed";
> > > +		off-on-delay-us =3D <12000>;
> > > +		pinctrl-0 =3D <&pinctrl_reg_usdhc2_vmmc>;
> > > +		pinctrl-names =3D "default";
> > > +		regulator-min-microvolt =3D <3300000>;
> > > +		regulator-max-microvolt =3D <3300000>;
> > > +		regulator-name =3D "VSD_3V3";
> > > +		vin-supply =3D <&buck4>;
> > > +		gpio =3D <&gpio3 7 GPIO_ACTIVE_HIGH>;
> > > +		enable-active-high;
> > > +	};
> > > +
> > > +	reg_usdhc3_vmmc: regulator-usdhc3 {
> >
> > This is not used - maybe it should be disabled?
> >
> > > +		compatible =3D "regulator-fixed";
> > > +		regulator-min-microvolt =3D <3300000>;
> > > +		regulator-max-microvolt =3D <3300000>;
> > > +		regulator-name =3D "WLAN_EN";
> > > +		vin-supply =3D <&buck4>;
> > > +		gpio =3D <&pcal6524 20 GPIO_ACTIVE_HIGH>;
> >
> > This does not seem to match the design files available for the FRDM on
> > the NXP website. The WiFi chip connected to the usdhc3 port is in fact
> > powered by the
> > VPCIe_3V3 power rail, which is enabled by the EXT1_PWREN signal that
> > is in turn connected to GPIO 13 of the pcal6524 expander.
> >
> > GPIO 20 of the pcal6524 expander should be driving M2_nDIS1 and then
> > W2_nDIS1 and finally PDn/PCAL6408_RST, which is connected to the reset
> > signal for a
> > PCAL6408 GPIO expander (U748).
> >
> > This is at least what I understood, but you may have more information
> > on the DNP (Do Not Populated) madness inside the schematic.
> >
>=20
> Hi Francesco,
>=20
> This regulator should keep. It has same design as imx93-11x11-evk.
> The reg_usdhc3_vmmc and usdhc3_pwrseq is used to keep the right power
> on sequence of the wifi bt module.
>=20

Sorry I didn't notice the author didn't enable USDHC3 in this dts, it can b=
e dropped momentarily.

Regards,
Joseph

> Regards,
> Joseph
> > > +		enable-active-high;
> > > +		/*
> > > +		 * IW612 wifi chip needs more delay than other wifi chips to
> complete
> > > +		 * the host interface initialization after power up, otherwise
> the
> > > +		 * internal state of IW612 may be unstable, resulting in the
> failure of
> > > +		 * the SDIO3.0 switch voltage.
> > > +		 */
> > > +		startup-delay-us =3D <20000>;
> > > +	};
> > > +
> > > +	reserved-memory {
> > > +		ranges;
> > > +		#address-cells =3D <2>;
> > > +		#size-cells =3D <2>;
> > > +
> > > +		linux,cma {
> > > +			compatible =3D "shared-dma-pool";
> > > +			alloc-ranges =3D <0 0x80000000 0 0x30000000>;
> > > +			reusable;
> > > +			size =3D <0 0x10000000>;
> > > +			linux,cma-default;
> > > +		};
> > > +
> > > +		rsc_table: rsc-table@2021e000 {
> > > +			reg =3D <0 0x2021e000 0 0x1000>;
> > > +			no-map;
> > > +		};
> > > +
> > > +		vdev0vring0: vdev0vring0@a4000000 {
> > > +			reg =3D <0 0xa4000000 0 0x8000>;
> > > +			no-map;
> > > +		};
> > > +
> > > +		vdev0vring1: vdev0vring1@a4008000 {
> > > +			reg =3D <0 0xa4008000 0 0x8000>;
> > > +			no-map;
> > > +		};
> > > +
> > > +		vdev1vring0: vdev1vring0@a4010000 {
> > > +			reg =3D <0 0xa4010000 0 0x8000>;
> > > +			no-map;
> > > +		};
> > > +
> > > +		vdev1vring1: vdev1vring1@a4018000 {
> > > +			reg =3D <0 0xa4018000 0 0x8000>;
> > > +			no-map;
> > > +		};
> > > +
> > > +		vdevbuffer: vdevbuffer@a4020000 {
> > > +			compatible =3D "shared-dma-pool";
> > > +			reg =3D <0 0xa4020000 0 0x100000>;
> > > +			no-map;
> > > +		};
> > > +	};
> > > +
> > > +	usdhc3_pwrseq: usdhc3_pwrseq {
> >
> > This is also not used.
> >
> > > +		compatible =3D "mmc-pwrseq-simple";
> > > +		reset-gpios =3D <&pcal6524 12 GPIO_ACTIVE_LOW>;
> > > +	};
> > > +};
> > > +
> > > +&adc1 {
> > > +	vref-supply =3D <&buck5>;
> > > +	status =3D "okay";
> > > +};
> > > +
> > > +&mu1 {
> > > +	status =3D "okay";
> > > +};
> > > +
> > > +&cm33 {
> > > +	mboxes =3D <&mu1 0 1>,
> > > +		 <&mu1 1 1>,
> > > +		 <&mu1 3 1>;
> > > +	mbox-names =3D "tx", "rx", "rxdb";
> > > +	memory-region =3D <&vdevbuffer>, <&vdev0vring0>, <&vdev0vring1>,
> > > +			<&vdev1vring0>, <&vdev1vring1>, <&rsc_table>;
> > > +	status =3D "okay";
> > > +};
> > > +
> > > +&eqos {
> > > +	pinctrl-names =3D "default", "sleep";
> > > +	pinctrl-0 =3D <&pinctrl_eqos>;
> > > +	pinctrl-1 =3D <&pinctrl_eqos_sleep>;
> > > +	phy-handle =3D <&ethphy1>;
> > > +	phy-mode =3D "rgmii-id";
> > > +	status =3D "okay";
> > > +
> > > +	mdio {
> > > +		compatible =3D "snps,dwmac-mdio";
> > > +		#address-cells =3D <1>;
> > > +		#size-cells =3D <0>;
> > > +		clock-frequency =3D <5000000>;
> > > +
> > > +		ethphy1: ethernet-phy@1 {
> > > +			reg =3D <1>;
> > > +			reset-assert-us =3D <10000>;
> > > +			reset-deassert-us =3D <80000>;
> > > +			reset-gpios =3D <&pcal6524 15 GPIO_ACTIVE_LOW>;
> > > +			realtek,clkout-disable;
> > > +		};
> > > +	};
> > > +};
> > > +
> > > +&fec {
> > > +	pinctrl-names =3D "default", "sleep";
> > > +	pinctrl-0 =3D <&pinctrl_fec>;
> > > +	pinctrl-1 =3D <&pinctrl_fec_sleep>;
> > > +	phy-mode =3D "rgmii-id";
> > > +	phy-handle =3D <&ethphy2>;
> > > +	fsl,magic-packet;
> > > +	status =3D "okay";
> > > +
> > > +	mdio {
> > > +		#address-cells =3D <1>;
> > > +		#size-cells =3D <0>;
> > > +		clock-frequency =3D <5000000>;
> > > +
> > > +		ethphy2: ethernet-phy@2 {
> > > +			reg =3D <2>;
> > > +			eee-broken-1000t;
> >
> > eee-broken-1000t should not be required, see:
> >
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flor=
e
> > .kernel.org%2Fall%2F20250901103632.3409896-6-
> joy.zou%40nxp.com%2F&data
> >
> =3D05%7C02%7Cqijian.guo%40nxp.com%7C51468e73709542a6053f08de201a616
> f%7C6
> >
> 86ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638983494907825583%7CU
> nknown
> > %7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsI
> lAiOiJXaW4
> >
> zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3Dw43JxH
> qpr2hiU
> > 4c2ha72aMOgZ7vpJ1Vj%2Bz7P568C97E%3D&reserved=3D0
> >
> > > +			reset-assert-us =3D <10000>;
> > > +			reset-deassert-us =3D <80000>;
> > > +			reset-gpios =3D <&pcal6524 16 GPIO_ACTIVE_LOW>;
> > > +			realtek,clkout-disable;
> > > +		};
> > > +	};
> > > +};
> > > +
> > > +&lpi2c1 {
> > > +	clock-frequency =3D <400000>;
> > > +	pinctrl-0 =3D <&pinctrl_lpi2c1>;
> > > +	pinctrl-names =3D "default";
> > > +	status =3D "okay";
> > > +
> > > +	it6263: hdmi@4c {
> > > +		compatible =3D "ite,it6263";
> > > +		reg =3D <0x4c>;
> > > +		ivdd-supply =3D <&buck5>;
> > > +		ovdd-supply =3D <&buck4>;
> > > +		txavcc18-supply =3D <&buck5>;
> > > +		txavcc33-supply =3D <&buck4>;
> > > +		pvcc1-supply =3D <&buck5>;
> > > +		pvcc2-supply =3D <&buck5>;
> > > +		avcc-supply =3D <&buck4>;
> > > +		anvdd-supply =3D <&buck5>;
> > > +		apvdd-supply =3D <&buck5>;
> > > +	};
> > > +};
> > > +
> > > +&lpi2c2 {
> > > +	clock-frequency =3D <400000>;
> > > +	pinctrl-0 =3D <&pinctrl_lpi2c2>;
> > > +	pinctrl-names =3D "default";
> > > +	status =3D "okay";
> > > +
> > > +	pcal6524: gpio@22 {
> > > +		compatible =3D "nxp,pcal6524";
> > > +		reg =3D <0x22>;
> > > +		#interrupt-cells =3D <2>;
> > > +		interrupt-controller;
> > > +		interrupt-parent =3D <&gpio3>;
> > > +		interrupts =3D <27 IRQ_TYPE_LEVEL_LOW>;
> > > +		#gpio-cells =3D <2>;
> > > +		gpio-controller;
> > > +		pinctrl-0 =3D <&pinctrl_pcal6524>;
> > > +		pinctrl-names =3D "default";
> > > +		/* does not boot with supplier set, because it is the bucks
> interrupt parent */
> > > +		/* vcc-supply =3D <&buck4>; */
> > > +	};
> > > +
> > > +	pmic@25 {
> > > +		compatible =3D "nxp,pca9451a";
> > > +		reg =3D <0x25>;
> > > +		interrupt-parent =3D <&pcal6524>;
> > > +		interrupts =3D <11 IRQ_TYPE_EDGE_FALLING>;
> > > +
> > > +		regulators {
> > > +
> > > +			buck1: BUCK1 {
> > > +				regulator-name =3D "VDD_SOC_0V8";
> > > +				regulator-min-microvolt =3D <650000>;
> > > +				regulator-max-microvolt =3D <950000>;
> > > +				regulator-always-on;
> > > +				regulator-boot-on;
> > > +				regulator-ramp-delay =3D <3125>;
> > > +			};
> > > +
> > > +			buck2: BUCK2 {
> > > +				regulator-name =3D "LPD4_x_VDDQ_0V6";
> > > +				regulator-min-microvolt =3D <600000>;
> > > +				regulator-max-microvolt =3D <670000>;
> > > +				regulator-always-on;
> > > +				regulator-boot-on;
> > > +				regulator-ramp-delay =3D <3125>;
> > > +			};
> > > +
> > > +			buck4: BUCK4 {
> > > +				regulator-name =3D "VDD_3V3";
> > > +				regulator-min-microvolt =3D <3300000>;
> > > +				regulator-max-microvolt =3D <3300000>;
> > > +				regulator-always-on;
> > > +				regulator-boot-on;
> > > +			};
> > > +
> > > +			buck5: BUCK5 {
> > > +				regulator-name =3D "VDD_1V8";
> > > +				regulator-min-microvolt =3D <1800000>;
> > > +				regulator-max-microvolt =3D <1800000>;
> > > +				regulator-always-on;
> > > +				regulator-boot-on;
> > > +			};
> > > +
> > > +			buck6: BUCK6 {
> > > +				regulator-name =3D "LPD4_x_VDD2_1V1";
> > > +				regulator-min-microvolt =3D <1100000>;
> > > +				regulator-max-microvolt =3D <1100000>;
> > > +				regulator-always-on;
> > > +				regulator-boot-on;
> > > +			};
> > > +
> > > +			ldo1: LDO1 {
> > > +				regulator-name =3D "NVCC_BBSM_1V8";
> > > +				regulator-min-microvolt =3D <1620000>;
> > > +				regulator-max-microvolt =3D <1980000>;
> > > +				regulator-always-on;
> > > +				regulator-boot-on;
> > > +			};
> > > +
> > > +			ldo4: LDO4 {
> > > +				regulator-name =3D "VDD_ANA_0V8";
> > > +				regulator-min-microvolt =3D <800000>;
> > > +				regulator-max-microvolt =3D <840000>;
> > > +				regulator-always-on;
> > > +				regulator-boot-on;
> > > +			};
> > > +
> > > +			ldo5: LDO5 {
> > > +				regulator-name =3D "NVCC_SD";
> > > +				regulator-min-microvolt =3D <1800000>;
> > > +				regulator-max-microvolt =3D <3300000>;
> > > +				regulator-always-on;
> > > +				regulator-boot-on;
> > > +			};
> > > +		};
> > > +	};
> > > +
> > > +	eeprom: eeprom@50 {
> > > +		compatible =3D "atmel,24c256";
> > > +		reg =3D <0x50>;
> > > +		pagesize =3D <64>;
> > > +		vcc-supply =3D <&buck4>;
> > > +	};
> > > +};
> > > +
> > > +&lpi2c3 {
> > > +	clock-frequency =3D <400000>;
> > > +	pinctrl-0 =3D <&pinctrl_lpi2c3>;
> > > +	pinctrl-names =3D "default";
> > > +	status =3D "okay";
> > > +
> > > +	ptn5110: tcpc@50 {
> > > +		compatible =3D "nxp,ptn5110", "tcpci";
> > > +		reg =3D <0x50>;
> > > +		interrupt-parent =3D <&gpio3>;
> > > +		interrupts =3D <27 IRQ_TYPE_LEVEL_LOW>;
> > > +
> > > +		typec1_con: connector {
> > > +			compatible =3D "usb-c-connector";
> > > +			data-role =3D "dual";
> > > +			label =3D "USB-C";
> > > +			op-sink-microwatt =3D <15000000>;
> > > +			power-role =3D "dual";
> > > +			self-powered;
> > > +			sink-pdos =3D <PDO_FIXED(5000, 3000,
> PDO_FIXED_USB_COMM)
> > > +					PDO_VAR(5000, 20000, 3000)>;
> > > +			source-pdos =3D <PDO_FIXED(5000, 3000,
> PDO_FIXED_USB_COMM)>;
> > > +			try-power-role =3D "sink";
> > > +
> > > +			ports {
> > > +				#address-cells =3D <1>;
> > > +				#size-cells =3D <0>;
> > > +
> > > +				port@0 {
> > > +					reg =3D <0>;
> > > +
> > > +					typec1_dr_sw: endpoint {
> > > +						remote-endpoint =3D
> <&usb1_drd_sw>;
> > > +					};
> > > +				};
> > > +			};
> > > +		};
> > > +	};
> > > +
> > > +	pcf2131: rtc@53 {
> > > +		compatible =3D "nxp,pcf2131";
> > > +		reg =3D <0x53>;
> > > +		interrupt-parent =3D <&pcal6524>;
> > > +		interrupts =3D <1 IRQ_TYPE_EDGE_FALLING>;
> > > +	};
> > > +};
> > > +
> > > +&lpuart1 { /* console */
> > > +	pinctrl-0 =3D <&pinctrl_uart1>;
> > > +	pinctrl-names =3D "default";
> > > +	status =3D "okay";
> > > +};
> > > +
> > > +&usbotg1 {
> > > +	adp-disable;
> > > +	disable-over-current;
> > > +	dr_mode =3D "otg";
> > > +	hnp-disable;
> > > +	srp-disable;
> > > +	usb-role-switch;
> > > +	samsung,picophy-dc-vol-level-adjust =3D <7>;
> > > +	samsung,picophy-pre-emp-curr-control =3D <3>;
> > > +	status =3D "okay";
> > > +
> > > +	port {
> > > +
> >
> > This white line should probably be removed.
> >
> > > +		usb1_drd_sw: endpoint {
> > > +			remote-endpoint =3D <&typec1_dr_sw>;
> > > +		};
> > > +	};
> > > +};
> > > +
> > > +&usbotg2 {
> > > +	disable-over-current;
> > > +	dr_mode =3D "host";
> > > +	samsung,picophy-dc-vol-level-adjust =3D <7>;
> > > +	samsung,picophy-pre-emp-curr-control =3D <3>;
> > > +	status =3D "okay";
> > > +};
> > > +
> > > +&usdhc1 {
> > > +	bus-width =3D <8>;
> > > +	non-removable;
> > > +	pinctrl-0 =3D <&pinctrl_usdhc1>;
> > > +	pinctrl-1 =3D <&pinctrl_usdhc1_100mhz>;
> > > +	pinctrl-2 =3D <&pinctrl_usdhc1_200mhz>;
> > > +	pinctrl-names =3D "default", "state_100mhz", "state_200mhz";
> > > +	vmmc-supply =3D <&buck4>;
> > > +	status =3D "okay";
> > > +};
> > > +
> > > +&usdhc2 {
> > > +	bus-width =3D <4>;
> > > +	cd-gpios =3D <&gpio3 00 GPIO_ACTIVE_LOW>;
> > > +	no-mmc;
> > > +	no-sdio;
> > > +	pinctrl-0 =3D <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
> > > +	pinctrl-1 =3D <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
> > > +	pinctrl-2 =3D <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
> > > +	pinctrl-3 =3D <&pinctrl_usdhc2_sleep>, <&pinctrl_usdhc2_gpio_sleep>=
;
> > > +	pinctrl-names =3D "default", "state_100mhz", "state_200mhz", "sleep=
";
> > > +	vmmc-supply =3D <&reg_usdhc2_vmmc>;
> > > +	status =3D "okay";
> > > +};
> > > +
> > > +&wdog3 {
> > > +	pinctrl-names =3D "default";
> > > +	pinctrl-0 =3D <&pinctrl_wdog>;
> > > +	fsl,ext-reset-output;
> > > +	status =3D "okay";
> > > +};
> > > +
> > > +&iomuxc {
> > > +
> > > +	pinctrl_eqos: eqosgrp {
> > > +		fsl,pins =3D <
> > > +			MX93_PAD_ENET1_MDC__ENET_QOS_MDC
> 		0x57e
> > > +			MX93_PAD_ENET1_MDIO__ENET_QOS_MDIO
> 		0x57e
> > > +			MX93_PAD_ENET1_RD0__ENET_QOS_RGMII_RD0
> 			0x57e
> > > +			MX93_PAD_ENET1_RD1__ENET_QOS_RGMII_RD1
> 			0x57e
> > > +			MX93_PAD_ENET1_RD2__ENET_QOS_RGMII_RD2
> 			0x57e
> > > +			MX93_PAD_ENET1_RD3__ENET_QOS_RGMII_RD3
> 			0x57e
> > > +
> 	MX93_PAD_ENET1_RXC__CCM_ENET_QOS_CLOCK_GENERATE_RX_
> CLK	0x58e
> > > +
> 	MX93_PAD_ENET1_RX_CTL__ENET_QOS_RGMII_RX_CTL
> 	0x57e
> > > +			MX93_PAD_ENET1_TD0__ENET_QOS_RGMII_TD0
> 			0x57e
> > > +			MX93_PAD_ENET1_TD1__ENET_QOS_RGMII_TD1
> 			0x57e
> > > +			MX93_PAD_ENET1_TD2__ENET_QOS_RGMII_TD2
> 			0x57e
> > > +			MX93_PAD_ENET1_TD3__ENET_QOS_RGMII_TD3
> 			0x57e
> > > +
> 	MX93_PAD_ENET1_TXC__CCM_ENET_QOS_CLOCK_GENERATE_TX_
> CLK	0x58e
> > > +
> 	MX93_PAD_ENET1_TX_CTL__ENET_QOS_RGMII_TX_CTL
> 	0x57e
> > > +		>;
> > > +	};
> > > +
> > > +	pinctrl_eqos_sleep: eqossleepgrp {
> > > +		fsl,pins =3D <
> > > +			MX93_PAD_ENET1_MDC__GPIO4_IO00
> 		0x31e
> > > +			MX93_PAD_ENET1_MDIO__GPIO4_IO01
> 		0x31e
> > > +			MX93_PAD_ENET1_RD0__GPIO4_IO10
> 	0x31e
> > > +			MX93_PAD_ENET1_RD1__GPIO4_IO11
> 	0x31e
> > > +			MX93_PAD_ENET1_RD2__GPIO4_IO12
> 	0x31e
> > > +			MX93_PAD_ENET1_RD3__GPIO4_IO13
> 	0x31e
> > > +			MX93_PAD_ENET1_RXC__GPIO4_IO09
> 	0x31e
> > > +			MX93_PAD_ENET1_RX_CTL__GPIO4_IO08
> 	0x31e
> > > +			MX93_PAD_ENET1_TD0__GPIO4_IO05
> 	0x31e
> > > +			MX93_PAD_ENET1_TD1__GPIO4_IO04
> 	0x31e
> > > +			MX93_PAD_ENET1_TD2__GPIO4_IO03
> 	0x31e
> > > +			MX93_PAD_ENET1_TD3__GPIO4_IO02
> 	0x31e
> > > +			MX93_PAD_ENET1_TXC__GPIO4_IO07
> 	0x31e
> > > +			MX93_PAD_ENET1_TX_CTL__GPIO4_IO06
> 	0x31e
> > > +		>;
> > > +	};
> > > +
> > > +	pinctrl_fec: fecgrp {
> > > +		fsl,pins =3D <
> > > +			MX93_PAD_ENET2_MDC__ENET1_MDC
> 		0x57e
> > > +			MX93_PAD_ENET2_MDIO__ENET1_MDIO
> 		0x57e
> > > +			MX93_PAD_ENET2_RD0__ENET1_RGMII_RD0
> 	0x57e
> > > +			MX93_PAD_ENET2_RD1__ENET1_RGMII_RD1
> 	0x57e
> > > +			MX93_PAD_ENET2_RD2__ENET1_RGMII_RD2
> 	0x57e
> > > +			MX93_PAD_ENET2_RD3__ENET1_RGMII_RD3
> 	0x57e
> > > +			MX93_PAD_ENET2_RXC__ENET1_RGMII_RXC
> 	0x58e
> > > +			MX93_PAD_ENET2_RX_CTL__ENET1_RGMII_RX_CTL
> 	0x57e
> > > +			MX93_PAD_ENET2_TD0__ENET1_RGMII_TD0
> 	0x57e
> > > +			MX93_PAD_ENET2_TD1__ENET1_RGMII_TD1
> 	0x57e
> > > +			MX93_PAD_ENET2_TD2__ENET1_RGMII_TD2
> 	0x57e
> > > +			MX93_PAD_ENET2_TD3__ENET1_RGMII_TD3
> 	0x57e
> > > +			MX93_PAD_ENET2_TXC__ENET1_RGMII_TXC
> 	0x58e
> > > +			MX93_PAD_ENET2_TX_CTL__ENET1_RGMII_TX_CTL
> 	0x57e
> > > +		>;
> > > +	};
> > > +
> > > +	pinctrl_fec_sleep: fecsleepgrp {
> > > +		fsl,pins =3D <
> > > +			MX93_PAD_ENET2_MDC__GPIO4_IO14
> 		0x51e
> > > +			MX93_PAD_ENET2_MDIO__GPIO4_IO15
> 		0x51e
> > > +			MX93_PAD_ENET2_RD0__GPIO4_IO24
> 	0x51e
> > > +			MX93_PAD_ENET2_RD1__GPIO4_IO25
> 	0x51e
> > > +			MX93_PAD_ENET2_RD2__GPIO4_IO26
> 	0x51e
> > > +			MX93_PAD_ENET2_RD3__GPIO4_IO27
> 	0x51e
> > > +			MX93_PAD_ENET2_RXC__GPIO4_IO23
> 	0x51e
> > > +			MX93_PAD_ENET2_RX_CTL__GPIO4_IO22
> 	0x51e
> > > +			MX93_PAD_ENET2_TD0__GPIO4_IO19
> 	0x51e
> > > +			MX93_PAD_ENET2_TD1__GPIO4_IO18
> 	0x51e
> > > +			MX93_PAD_ENET2_TD2__GPIO4_IO17
> 	0x51e
> > > +			MX93_PAD_ENET2_TD3__GPIO4_IO16
> 	0x51e
> > > +			MX93_PAD_ENET2_TXC__GPIO4_IO21
> 	0x51e
> > > +			MX93_PAD_ENET2_TX_CTL__GPIO4_IO20
> 	0x51e
> > > +		>;
> > > +	};
> > > +
> > > +	pinctrl_flexcan2: flexcan2grp {
> > > +		fsl,pins =3D <
> > > +			MX93_PAD_GPIO_IO25__CAN2_TX
> 	0x139e
> > > +			MX93_PAD_GPIO_IO27__CAN2_RX
> 	0x139e
> > > +		>;
> > > +	};
> > > +
> > > +	pinctrl_lpi2c1: lpi2c1grp {
> > > +		fsl,pins =3D <
> > > +			MX93_PAD_I2C1_SCL__LPI2C1_SCL
> 	0x40000b9e
> > > +			MX93_PAD_I2C1_SDA__LPI2C1_SDA
> 	0x40000b9e
> > > +		>;
> > > +	};
> > > +
> > > +	pinctrl_lpi2c2: lpi2c2grp {
> > > +		fsl,pins =3D <
> > > +			MX93_PAD_I2C2_SCL__LPI2C2_SCL
> 	0x40000b9e
> > > +			MX93_PAD_I2C2_SDA__LPI2C2_SDA
> 	0x40000b9e
> > > +		>;
> > > +	};
> > > +
> > > +	pinctrl_lpi2c3: lpi2c3grp {
> > > +		fsl,pins =3D <
> > > +			MX93_PAD_GPIO_IO28__LPI2C3_SDA
> 	0x40000b9e
> > > +			MX93_PAD_GPIO_IO29__LPI2C3_SCL
> 	0x40000b9e
> > > +		>;
> > > +	};
> > > +
> > > +	pinctrl_pcal6524: pcal6524grp {
> > > +		fsl,pins =3D <
> > > +			MX93_PAD_CCM_CLKO2__GPIO3_IO27
> 		0x31e
> > > +		>;
> > > +	};
> > > +
> > > +	pinctrl_reg_usdhc2_vmmc: regusdhc2vmmcgrp {
> > > +		fsl,pins =3D <
> > > +			MX93_PAD_SD2_RESET_B__GPIO3_IO07
> 	0x31e
> > > +		>;
> > > +	};
> > > +
> > > +	pinctrl_uart1: uart1grp {
> > > +		fsl,pins =3D <
> > > +			MX93_PAD_UART1_RXD__LPUART1_RX
> 		0x31e
> > > +			MX93_PAD_UART1_TXD__LPUART1_TX
> 		0x31e
> > > +		>;
> > > +	};
> > > +
> > > +	/* need to config the SION for data and cmd pad, refer to ERR052021
> */
> > > +	pinctrl_usdhc1: usdhc1grp {
> > > +		fsl,pins =3D <
> > > +			MX93_PAD_SD1_CLK__USDHC1_CLK
> 	0x1582
> > > +			MX93_PAD_SD1_CMD__USDHC1_CMD
> 	0x40001382
> > > +			MX93_PAD_SD1_DATA0__USDHC1_DATA0
> 	0x40001382
> > > +			MX93_PAD_SD1_DATA1__USDHC1_DATA1
> 	0x40001382
> > > +			MX93_PAD_SD1_DATA2__USDHC1_DATA2
> 	0x40001382
> > > +			MX93_PAD_SD1_DATA3__USDHC1_DATA3
> 	0x40001382
> > > +			MX93_PAD_SD1_DATA4__USDHC1_DATA4
> 	0x40001382
> > > +			MX93_PAD_SD1_DATA5__USDHC1_DATA5
> 	0x40001382
> > > +			MX93_PAD_SD1_DATA6__USDHC1_DATA6
> 	0x40001382
> > > +			MX93_PAD_SD1_DATA7__USDHC1_DATA7
> 	0x40001382
> > > +			MX93_PAD_SD1_STROBE__USDHC1_STROBE
> 	0x1582
> > > +		>;
> > > +	};
> > > +
> > > +	/* need to config the SION for data and cmd pad, refer to ERR052021
> */
> > > +	pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp {
> > > +		fsl,pins =3D <
> > > +			MX93_PAD_SD1_CLK__USDHC1_CLK
> 	0x158e
> > > +			MX93_PAD_SD1_CMD__USDHC1_CMD
> 	0x4000138e
> > > +			MX93_PAD_SD1_DATA0__USDHC1_DATA0
> 	0x4000138e
> > > +			MX93_PAD_SD1_DATA1__USDHC1_DATA1
> 	0x4000138e
> > > +			MX93_PAD_SD1_DATA2__USDHC1_DATA2
> 	0x4000138e
> > > +			MX93_PAD_SD1_DATA3__USDHC1_DATA3
> 	0x4000138e
> > > +			MX93_PAD_SD1_DATA4__USDHC1_DATA4
> 	0x4000138e
> > > +			MX93_PAD_SD1_DATA5__USDHC1_DATA5
> 	0x4000138e
> > > +			MX93_PAD_SD1_DATA6__USDHC1_DATA6
> 	0x4000138e
> > > +			MX93_PAD_SD1_DATA7__USDHC1_DATA7
> 	0x4000138e
> > > +			MX93_PAD_SD1_STROBE__USDHC1_STROBE
> 	0x158e
> > > +		>;
> > > +	};
> > > +
> > > +	/* need to config the SION for data and cmd pad, refer to ERR052021
> */
> > > +	pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
> > > +		fsl,pins =3D <
> > > +			MX93_PAD_SD1_CLK__USDHC1_CLK
> 	0x15fe
> > > +			MX93_PAD_SD1_CMD__USDHC1_CMD
> 	0x400013fe
> > > +			MX93_PAD_SD1_DATA0__USDHC1_DATA0
> 	0x400013fe
> > > +			MX93_PAD_SD1_DATA1__USDHC1_DATA1
> 	0x400013fe
> > > +			MX93_PAD_SD1_DATA2__USDHC1_DATA2
> 	0x400013fe
> > > +			MX93_PAD_SD1_DATA3__USDHC1_DATA3
> 	0x400013fe
> > > +			MX93_PAD_SD1_DATA4__USDHC1_DATA4
> 	0x400013fe
> > > +			MX93_PAD_SD1_DATA5__USDHC1_DATA5
> 	0x400013fe
> > > +			MX93_PAD_SD1_DATA6__USDHC1_DATA6
> 	0x400013fe
> > > +			MX93_PAD_SD1_DATA7__USDHC1_DATA7
> 	0x400013fe
> > > +			MX93_PAD_SD1_STROBE__USDHC1_STROBE
> 	0x15fe
> > > +		>;
> > > +	};
> > > +
> > > +	pinctrl_usdhc2_gpio: usdhc2gpiogrp {
> > > +		fsl,pins =3D <
> > > +			MX93_PAD_SD2_CD_B__GPIO3_IO00		0x31e
> > > +		>;
> > > +	};
> > > +
> > > +	pinctrl_usdhc2_gpio_sleep: usdhc2gpiosleepgrp {
> > > +		fsl,pins =3D <
> > > +			MX93_PAD_SD2_CD_B__GPIO3_IO00		0x51e
> > > +		>;
> > > +	};
> > > +
> > > +	/* need to config the SION for data and cmd pad, refer to ERR052021
> */
> > > +	pinctrl_usdhc2: usdhc2grp {
> > > +		fsl,pins =3D <
> > > +			MX93_PAD_SD2_CLK__USDHC2_CLK
> 	0x1582
> > > +			MX93_PAD_SD2_CMD__USDHC2_CMD
> 	0x40001382
> > > +			MX93_PAD_SD2_DATA0__USDHC2_DATA0
> 	0x40001382
> > > +			MX93_PAD_SD2_DATA1__USDHC2_DATA1
> 	0x40001382
> > > +			MX93_PAD_SD2_DATA2__USDHC2_DATA2
> 	0x40001382
> > > +			MX93_PAD_SD2_DATA3__USDHC2_DATA3
> 	0x40001382
> > > +			MX93_PAD_SD2_VSELECT__USDHC2_VSELECT	0x51e
> > > +		>;
> > > +	};
> > > +
> > > +	/* need to config the SION for data and cmd pad, refer to ERR052021
> */
> > > +	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
> > > +		fsl,pins =3D <
> > > +			MX93_PAD_SD2_CLK__USDHC2_CLK
> 	0x158e
> > > +			MX93_PAD_SD2_CMD__USDHC2_CMD
> 	0x4000138e
> > > +			MX93_PAD_SD2_DATA0__USDHC2_DATA0
> 	0x4000138e
> > > +			MX93_PAD_SD2_DATA1__USDHC2_DATA1
> 	0x4000138e
> > > +			MX93_PAD_SD2_DATA2__USDHC2_DATA2
> 	0x4000138e
> > > +			MX93_PAD_SD2_DATA3__USDHC2_DATA3
> 	0x4000138e
> > > +			MX93_PAD_SD2_VSELECT__USDHC2_VSELECT	0x51e
> > > +		>;
> > > +	};
> > > +
> > > +	/* need to config the SION for data and cmd pad, refer to ERR052021
> */
> > > +	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
> > > +		fsl,pins =3D <
> > > +			MX93_PAD_SD2_CLK__USDHC2_CLK
> 	0x15fe
> > > +			MX93_PAD_SD2_CMD__USDHC2_CMD
> 	0x400013fe
> > > +			MX93_PAD_SD2_DATA0__USDHC2_DATA0
> 	0x400013fe
> > > +			MX93_PAD_SD2_DATA1__USDHC2_DATA1
> 	0x400013fe
> > > +			MX93_PAD_SD2_DATA2__USDHC2_DATA2
> 	0x400013fe
> > > +			MX93_PAD_SD2_DATA3__USDHC2_DATA3
> 	0x400013fe
> > > +			MX93_PAD_SD2_VSELECT__USDHC2_VSELECT	0x51e
> > > +		>;
> > > +	};
> > > +
> > > +	pinctrl_usdhc2_sleep: usdhc2-sleepgrp {
> > > +		fsl,pins =3D <
> > > +			MX93_PAD_SD2_CLK__GPIO3_IO01		0x51e
> > > +			MX93_PAD_SD2_CMD__GPIO3_IO02		0x51e
> > > +			MX93_PAD_SD2_DATA0__GPIO3_IO03
> 	0x51e
> > > +			MX93_PAD_SD2_DATA1__GPIO3_IO04
> 	0x51e
> > > +			MX93_PAD_SD2_DATA2__GPIO3_IO05
> 	0x51e
> > > +			MX93_PAD_SD2_DATA3__GPIO3_IO06
> 	0x51e
> > > +			MX93_PAD_SD2_VSELECT__GPIO3_IO19	0x51e
> > > +		>;
> > > +	};
> > > +
> > > +	pinctrl_wdog: wdoggrp {
> > > +		fsl,pins =3D <
> > > +			MX93_PAD_WDOG_ANY__WDOG1_WDOG_ANY
> 	0x31e
> > > +		>;
> > > +	};
> > > +};
> > >
> > >
> >
> >
> > Just FYI: there is a open bug on v6.18-rc2 which prevent the Bluetooth
> > chip to work correctly. Just a heads up, as I wasted some _hours_ chasi=
ng it
> yesterday:
> >
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flor=
e
> > .kernel.org%2Fall%2F6837167.ZASKD2KPVS%40fedora.fritz.box%2F&data=3D
> 05%7
> >
> C02%7Cqijian.guo%40nxp.com%7C51468e73709542a6053f08de201a616f%7C6
> 86ea1
> >
> d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638983494907849056%7CUnkno
> wn%7CTW
> >
> FpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXa
> W4zMiIs
> >
> IkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DIHZxgaznT%2
> BaZnx6u
> > KrXN%2B6wuTHWkC8xeG2Wt9Ijepvs%3D&reserved=3D0
> >
> >
> > Thank you!
> >
> > Regards,
> > Francesco
> >
> >
> >
> >

