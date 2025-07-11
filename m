Return-Path: <linux-kernel+bounces-726962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C6E4B0136E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 08:21:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B8ED1C2377D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 06:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9933F1D618C;
	Fri, 11 Jul 2025 06:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GhxNRSN5"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011060.outbound.protection.outlook.com [52.101.70.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C3FA92E;
	Fri, 11 Jul 2025 06:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752214899; cv=fail; b=cbuwRh+wJcZhDLbuWk9yCi//XT0yAe9PupwWb703FaXC+kJyqn/gjkLeGZQjmy2sbTcgSyqXc/RhOlDUvc0WwM/A33nJth5NJTdVv0L7ClJiT/kyCDXCC4zRpzPYU+yJiaCQcgN7h9Tt+O8k4ZOO1FWFdIkbH9GK1tlwhq8XOD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752214899; c=relaxed/simple;
	bh=3dDYFe3gkYWpXM2wo6iR/SN2NYQwss1CWVeIK+o3bBo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S6zLY2DSfvPxwYNhT7QoqJbq5QUHpTKHGqYuwC0qTMDYs61PC06a8i+lfugUi4Gs6bxfFdwS50PaufxBvNImyPNAvsfIFLAXIHQDNVLI5q7V5CkRSUbA4rCUic6UofID+mI0FrEum7tw6E0mGW2CXi0q6VC85HnNmUSMQeeyN6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GhxNRSN5; arc=fail smtp.client-ip=52.101.70.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vc4Ik8OcVK0jjCRydkaHjAL7w+7Clo4vWQnk4jnvUwFsFTquQ85dQbhi2+xLmCpucKJ/5A4yTiSFzCD2oKIS3shbghFpgN3/jgLWcwGTr1rp/d9eCesTGUax4CJiR942LSrsi/MGdptUNWBZasgzI1Vx3yQAmTNeJ5i7OkwxoxwBQz83mDYjqrVLbi+StsYytmovc+D9alESeTlbqF3+EE1I0MD47+32WVT2+XZdKIEInn7wAUo4wV3QhdXSKYHT2ZP/cM0hWONHhEoJFNZklYFXnXLylBZlyeal7ETt4z7b8u4K4ECCkzdTIDfJYQsTgmFydJICYW+D4M51MXKo9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h5jWKlloZJU5wtCV5IB757BU3V6bofHoEzw+AN5XMm4=;
 b=LdTaqZ9ZRenHFVR+2EtqftUox3A/LbUV3c0L8jkFekgAePxsK0v9X08nna1jS4T8ti5L6kQG2wygw3uf3B1J8DeR6Xg7PZtFC3WE4A0n1embN4pxyWpJi4va7W4YgFvyBKEh6hK7TutY/BSBM26KNxysHXMIMmaTrLFxjZgmq11nxcYSMhDzKIOCO/FMFQ3Ps8a95h4VloNHZjm+a1ssXQyUc2HCB8X7XQgceYu2MZS+D57uIB6e9NU9wTECvc3vqFXeWwx3ck/PJ6ega/UkXG7i/8YdQi83Xg/0SY0NOkPL9eM1kBehssIA1Na+TCGVZpgMaBQAXfF78YVkQf9jcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h5jWKlloZJU5wtCV5IB757BU3V6bofHoEzw+AN5XMm4=;
 b=GhxNRSN5GghgBNZmxuGcxmtiEVXTNDd2ObwJY9A5xiDjvW+HcFZG0ua7zSj1WvYlARbDgfJjSsOMYLig/H+BP+VKL/tC6LHA2aa5G+3PDn7WWXyCx7OQ/yiYaivv8ZtnTLFV90Vekc+ZlGgDEYTadgS0Li6ed3qn4X3gQlafDvL/yDTvWsvzpLVgYs/C4UBCdeV8wT2/36ayD7k6Y7tvaxgmZ6bO1cGcik0EiIUnel6xc2/E5AahXSDtq9Fk+Y+UfKB3qm+pfMljl4XhGVWF7fIjDZMzdbWnJGVWLaZg8xF6Np1m/E3FxU8wz8etxL1HS1KgAizvdxZ6ENJr7CsyUg==
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by GVXPR04MB10151.eurprd04.prod.outlook.com (2603:10a6:150:1b7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.25; Fri, 11 Jul
 2025 06:21:33 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%4]) with mapi id 15.20.8922.023; Fri, 11 Jul 2025
 06:21:33 +0000
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
 AQHbtedVK8O607CHbE6OOXVUvXFh57P/eBgAgAAAcYCAASRIAIAKHEiwgB9Rl7CAAtSbgIAABcMg
Date: Fri, 11 Jul 2025 06:21:33 +0000
Message-ID:
 <AM9PR04MB86047F4AE8CF4B56947381D1954BA@AM9PR04MB8604.eurprd04.prod.outlook.com>
References: <20250426-imx-se-if-v17-0-0c85155a50d1@nxp.com>
 <aEqMSG8k+NpQ7ROH@dragon>
 <AM9PR04MB86048A698B03E974CFD3DB489574A@AM9PR04MB8604.eurprd04.prod.outlook.com>
 <aEuB1qgd6aVl0i7i@dragon>
 <AM9PR04MB8604F77BCD3427B38CB9E664957DA@AM9PR04MB8604.eurprd04.prod.outlook.com>
 <AM9PR04MB8604BFF7161570CD464723FA9549A@AM9PR04MB8604.eurprd04.prod.outlook.com>
 <aHCihwHKVck-emEX@dragon>
In-Reply-To: <aHCihwHKVck-emEX@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8604:EE_|GVXPR04MB10151:EE_
x-ms-office365-filtering-correlation-id: ac13edaf-48f2-4b23-045e-08ddc0432e88
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|7416014|19092799006|4053099003|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?LTmF0kylToYKqjFqZoyEKjkqs7i4mqPUwudP6oyVi1qK0q+IyPew0JQxsIsf?=
 =?us-ascii?Q?mlwQVChqzQ62Xnqr80KULIgesa99Lvnp68TJlNpkwJIk5u1OGXKXDc4KTtyi?=
 =?us-ascii?Q?XRQ0slksjgnvTYpwM8jwWAqijKqjtnHeJdE1qSjEgSDSs9cW9MlAzVmAnJGR?=
 =?us-ascii?Q?0TkkW7SjwALCqmq53bAHtPjih+JQpQX/fP1g2uPnPGM07qjTFmlY3kACFW20?=
 =?us-ascii?Q?vzt+LUvVDGY2JW3B24gTpzeuQmvCHniJ0sT9XciArSG0hSw4nnFLHynoq+tL?=
 =?us-ascii?Q?boWp054mMsQZk9wm68iE+Uy+RVE4EhraJmT/2sah2vodHJsd/H2bG4mGZxjd?=
 =?us-ascii?Q?DQDUMjCeMfqAE/H0nAPWIuxraYS34zieAoK8aGy8wsPo6dizrg7ivyjTAEDh?=
 =?us-ascii?Q?SsVyVWYRTf50zAdofOi+xJD6HW9+R0zXyb0ys2TzMdaZGj5ARogIETNG0NsL?=
 =?us-ascii?Q?71qnW/W7hvw+Uv94hzotD49R56krlxqRjOoqJEd7x4iOTM1t73oIui4eLzBc?=
 =?us-ascii?Q?1kZCPgSfkPM86qQLQLNfOT9euioHmuDsZO42dUdBpeD6hRSr9DL587zRx5t8?=
 =?us-ascii?Q?ZM4sAGa0w/HblbE1GGhRK6AuQQGiKFWh/SFOvU2nCnUIQfnjMyv0hAoJ/DZH?=
 =?us-ascii?Q?wmbvlVcdjPfgrirQCqU73/61+gva2qmy0llk9k3Lr4xIwBj2KRNfWSW3kqC0?=
 =?us-ascii?Q?83MXQOpLBsiw94no6Fru8KzxgWn1tlcn6zFOEu5MANtCG3/kQKZMwnGWb4li?=
 =?us-ascii?Q?msCYGI2n99X6BnhMB88dc3xLqaFBwoplAusuwEhxzB1fDVOMwZXtpMMXI0lG?=
 =?us-ascii?Q?GZdBsRhnm1oTBnIwe6ynUcEGMkvYqnP8WJaxfY988FC3Rwpl1q6GUOvA78M1?=
 =?us-ascii?Q?1MPlxvy0lOJDxCO7EZjsLQMfHSJJ7nz6kcgSot1wDEo05oPo6T529hJNvqVn?=
 =?us-ascii?Q?b8R0scN4t7Kw4pBdqW3ZR+Q0nTRTxWyqdoZpU/YDkKSUmVF4XEt9E89xMFdL?=
 =?us-ascii?Q?5hpWMVnGpvffCet0drJcYbgUDRnc7PFlSVLPCMOl0TeGj0MoWed4yfhbBZlz?=
 =?us-ascii?Q?UOPXgpIKDs8EYgYUGEaQoq5zK6JtKmAGg28iCjlpg4wEGw5uRSFV5Wz+4GIM?=
 =?us-ascii?Q?lz2V9SNoGveHJG23XQ4zKFM9YZSQg6o85ed34t6WnCKqD9jgEcWpNd/cmixk?=
 =?us-ascii?Q?NPk01yhrnmUmX8hauMhE4s3PX89OfhwP6+9Mu8BKbEUZype50+fPyCUS+V5f?=
 =?us-ascii?Q?WtmCFgeVz8bChhGnIJlqRTFPxifztbW3BOu9VH9FzvQmZWOTtJS664iYxWtO?=
 =?us-ascii?Q?Xffd2zCMnZOSZjaxr/3jgJCVhkcqZ89DGCu7YroFHyZQsYRFIA6GOxxhDluF?=
 =?us-ascii?Q?OLKaqwa9nSm7xBpVuhu0mDApQs3R6KBBL+RoDPNkDn9EC4f6GO1g8sKfwRDr?=
 =?us-ascii?Q?CGXLbF/HidAlynyux7q79dFsmegLOrLYRj2kqy+5URMZ47RszQBAi01MmpH2?=
 =?us-ascii?Q?5NES/L4oo96FZL0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(19092799006)(4053099003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+K9igOyqpgsAhE8QzmLBV3CBIqDttUSdXHT5pdajp5rd3zmYSiuFXeV2Z90D?=
 =?us-ascii?Q?WjkpL1PcvIrxTs3W9/dVzuzw56eFXbf0LxHJ1ANHhamk88jtDXirPy4Z8OA6?=
 =?us-ascii?Q?K9WKUGd1x4Q0MXXnTTFlO+bYKTqWJCMLWIhoY2092WFyVG5GChoOp0D5CfI9?=
 =?us-ascii?Q?Mt8ZyFuY218sT/jIAT6GS9P5clgAVX4gWk6aJgZhZslTEfJigOJCIfRgrvRg?=
 =?us-ascii?Q?TwLgQNe5NiyL1SNbAwQJlvHgxr3enPq2GLeWwe23GqNagRmaYT0TNEaQKk9q?=
 =?us-ascii?Q?CbeGUxCMI6yMJNJ1pKxBfoThSPtZIW2mWiy6EMzFCgx0dIFaeg1Lbze8bjoY?=
 =?us-ascii?Q?h7kwCqQXuszrYuuOHw6+21MKBjH4qbC9LESj/ZawZCfE7EIxji+VfSV4gnoy?=
 =?us-ascii?Q?cqS8Gsa6JMxXhmMWcbfsrfxUJzbokYPHhanm7OWp+e4LGD3FbTbSBxKlzbzV?=
 =?us-ascii?Q?hcipWvzg92iRnAu9VWUlwj2XpLH40zh+Tyxy8rpeoxwzHNbh6qYzZ2HohqdA?=
 =?us-ascii?Q?+upJDq19JgufppcSdd658y+/GNtb5Jmdl3OPsop2X/TdmWjxtxhsGRe3kssm?=
 =?us-ascii?Q?NzOrQ8rxH8EvAAsjegmXYryCHw9L2+ZcE1I2i6Eaba9fOMB98cqBbtO5M5+a?=
 =?us-ascii?Q?Pu5wF3WTZjJptS6Jfh6fdKqGQPzLxA5m/DdmVEyZN6MQGiV+IA6QQPdMSnVa?=
 =?us-ascii?Q?dFfjEx19NGWNcMt2SphT7TRDaejALOF6Agp5TgOw0//4NRtHIX6qVcnL0x5G?=
 =?us-ascii?Q?L10AVVkjbpRTpz/14eIH8n/GTERmQaRUDu9JrxBdolqpVCqH9GhfRcfcCeC6?=
 =?us-ascii?Q?ELFj/s8lDB2hG+3yxNDy+PxkmzsnBEGBqmvukWr8cIyRRae3Up/bFSa3Yj0K?=
 =?us-ascii?Q?yKr6+yUNKzon4VNO0pGLRlFipyKJqWkTZWyfTCcasyPCHJqtUDNuk7jo0g8b?=
 =?us-ascii?Q?X+LfbI49fA26rSUeSW7HFXzZAaiYqF+O2/0bhfkW0q8qp6YTtYtbAgCYR6iD?=
 =?us-ascii?Q?p5mLYFGZsjpjly6KIxSCBe8iV1EzVkXSk3YQ0pjqr8MBowHqbCMGcstoE8xr?=
 =?us-ascii?Q?U6zi2hNJJUj3xB9tQLRKTlwEnU5Ol+W8J4Q7Le77FVt/fcqoccM+78MwYzjJ?=
 =?us-ascii?Q?RAHh0CFWNC1jGQrSOSQlM3MFXupgzBhpcg5MFbgrA7KTtquK8SJhpGHVabx4?=
 =?us-ascii?Q?tVbcfD9vhA0xwyFUEiEtUKkaI+05KjWJFyk/0kSyEH202Kw7J4lR3lNVXMnr?=
 =?us-ascii?Q?OcDoDsrBQpqXFvRHMlehj8JKsucmAdjuNoVcwtq39VrHeN7yBPpmLK9ceWl5?=
 =?us-ascii?Q?wi8q04tlj2dSQ3DTcAZukXeXir/50QOM8oKguAEiMmORcQc2RwzCoJ/+Cs03?=
 =?us-ascii?Q?+ESMpzp5MH6XSUaCX0inBooY1oAOHLq8EywC8uTGCaeZhZPzmpVQdgSNkqQk?=
 =?us-ascii?Q?ZDklLT2mK5uO52fGsp9RCwzk4htjCKkS46mH8w8pk1xNZgnJ0tRMTRvqJDI/?=
 =?us-ascii?Q?pT8xtGQOtMFuogegfuhBlyY8hhrc1z6D5dbEtdM3pd9kD224aUZq0DUXwanM?=
 =?us-ascii?Q?IY0byWxzg6LceEUuv44=3D?=
Content-Type: multipart/signed;
	protocol="application/x-pkcs7-signature";
	micalg=SHA1;
	boundary="----=_NextPart_000_004C_01DBF25A.248B9EF0"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac13edaf-48f2-4b23-045e-08ddc0432e88
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2025 06:21:33.2036
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PdleZWDNb9eVBRVtSdk6E9lF4M/B+/GkA1A7fX4PXQCCIUiTx11UKQdb5Po/TJXW+ts7d+Lm7Wg4MUWUt4cfGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10151

------=_NextPart_000_004C_01DBF25A.248B9EF0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit


> On Wed, Jul 09, 2025 at 10:23:45AM +0000, Pankaj Gupta wrote:
>>>>> Hi Shawn,
>>>>>
>>>>> To test it on MX93, you need additional patches on top of these.
>>>>>
>>>>> The plan was to send the next patch-set to enable the support for 
>>>>> MX93, once these got merged.
>>>>>
>>>>> If you suggest, I can share the patche-set to enable MX93, as an 
>>>>> attachment to you only.
>>
>>>> Yes, please.  I would like to test the driver before it gets 
>>>> merged,
>> thanks!
>>
>>> Please find attached the patches for enabling iMX93.
>>
>>> I have also sent v18 to dispose off the comments:
>>> 1. documentation,
>>> 2. updating the commit message with collected reviewed by tags.
>>
>> Are you able to test the driver on i.MX93?
>> Any help needed?

> I did not expect those additional patches (except i.MX93 DTS
> changes) for testing the series on i.MX93.  So, no, I didn't test, sorry!

List of Patches:
0001: is required to call "init_fw" API, for SoC i.XM9x.
0002: i.MX93 do not have CAAM, ELE's RNG needs to be started, post init_fw.
0003: iMX93 do not have CAAM, hence (T)RNG & hwrng, need to enabled via ELE.
0004: enforce message sequence flow to prevent any message exchange out of
sequence. Required by power management API(s).
0005: additional API(s) required by Linux kernel management layers like
NVMEM & power management.
0006: EXPORTED API to be used by other kernel management layers.
0007 & 0008: are DTSI & DTS changes.


1. If you add DTSI & DTS changes, i.MX93 board will come up with driver
successfully probed.
Logs: 
root@imx93evk:~# dmesg | grep fsl-se
[    1.414748] fsl-se secure-enclave: assigned reserved memory node
memory@a4120000
[    1.427195] fsl-se secure-enclave: i.MX secure-enclave: hsm0 interface to
firmware, configured.

root@imx93evk:~# ele_hsm_test --info

SAB Error: SAB CMD [0x10]  Resp [0x1329] - Unknown error code

hsm_open_session failed err:0x13

2. If you want to use ELE test, you need to apply patches: 0001 & 0002.

Logs: 
root@imx93evk:~# dmesg | grep fsl-se
[    1.414748] fsl-se secure-enclave: assigned reserved memory node
memory@a4120000
[    1.427195] fsl-se secure-enclave: i.MX secure-enclave: hsm0 interface to
firmware, configured.
root@imx93evk:~# ele_hsm_test --info
hsm_open_session PASS 0x376ace9e
-----------------------------------------------------------
Global Info:
-----------------------------------------------------------
i.MX93 A2
Open Lifecycle
Fips mode 0x0
LIB Version: 1.1.1
NVM Version: 1.1.1
Build ID: 4060004597fe1bf9e84ec0804b98d855f1ed0e13
-----------------------------------------------------------
hsm_close_session[0] ret:0x0


> Shawn


------=_NextPart_000_004C_01DBF25A.248B9EF0
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
KoZIhvcNAQkFMQ8XDTI1MDcxMTA2MjEzMVowIwYJKoZIhvcNAQkEMRYEFFzlebkH69JsSLqhp37V
Q1jT1pTQMIGTBgkqhkiG9w0BCQ8xgYUwgYIwCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjAKBggq
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
AQCVm1xDwM5y3HFZsLa7I7P7DHm/b0Dz/oZTgryfxapdSfsAVCGMKWP3jbVPdsPYXkyVGnPNS+rO
9swpARESfPyF69t6FawBCf3yzZEGOTIVLNXlBxYy2q9xgtn5YvBtM4KGS8EegsSYioATnrg7bqxL
WcSpzU+9ALQqz6q27ospHmoE+C3ek34GuePaf7BnVT4StLZ9fMig1a4m16Pp7ZUzpaMDsl9C8w5o
QHw3/6U5B1F3ccr/yARTDIGNH+9f8AvonYXX3DcDjJDTXNjWnp7MSNsum6KBQTExvn8prtiwgJ6B
r0ClQ0vvUtqK1bb6ZNhwoZXBc3UIPBtSuqH+mnFMAAAAAAAA

------=_NextPart_000_004C_01DBF25A.248B9EF0--

