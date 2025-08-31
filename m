Return-Path: <linux-kernel+bounces-793259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4562B3D142
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 09:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E4D03BF8E1
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 07:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C7B241690;
	Sun, 31 Aug 2025 07:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ghgsVbYu"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011068.outbound.protection.outlook.com [52.101.70.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D447A202F9C;
	Sun, 31 Aug 2025 07:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756626186; cv=fail; b=tG8OsfclcIj3RCVulfv0Y91rdVwDsyKTvUmy29Nch/riAns2aLA+0XP/+dDXSIZBBFQmz7OBkkuu6cl+l6C8hGqFWsdchjlMsY89f/M++QnCQD55dIRWTWcvrXONP6NUFKR8vHWFbSiSUWbbN1Bk1W64nhiNKJEXuu88eAOaCCQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756626186; c=relaxed/simple;
	bh=jUsR0mgnjmtLIExjnp31rbSalwSWUoHVXnN2czQIoJk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i1bnJrfWwUYWoq1Xohjgkg8LakNc77FTtodKq5EqfBfYwBLNu973NWFsiOWfqmb81hXSFTR6o4A2eTIEZHq6LRb+BHGH511PefHClptgTXQZjmkDgAtPyV2ukvmzPvIWQthJdG/qtjv7b6gEibs2SzXdc92sKg5QelIX3ryXW1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ghgsVbYu; arc=fail smtp.client-ip=52.101.70.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gxv6muaWFHG13ZKzAiwzHT1YDssuzBA9MApuSoG2hVKNAw6Zz0TtfqVQnDZemYS5t9hm9m9ligSAet/7jZ7PTzeLisAVoSn5lkOefspRtHjn7ylZu9TwilAe27W39+uMH+ohmA75bmYEacrMFZf9LmYd1hQQ5JSLJ905AouTA8LARwHMlJlzkK1jNs07LoXdIPtJ84DHKwr5jy/vjFS3Tz68N5yrWSnH1qUnw3cWxyDiQh2aTqLCd82FUdPfE3uHrlSf9+NFoLtNEQMJt3DfH5+VOkHBvlXs1EIhyKCkcTGMG6yMTpXc4MimF/vOEjIylyJJIoKBnB3xIUbd2kCUvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E5vJTHvc92SQeXFktPfdXwF7voQcwovF+SvKuLo17LI=;
 b=fnGlg1M+PG98G5AjkquwLOK+pVoALB3WE+9FDxLT8Mv7JxWQNW48pk0NwHs4W6bGhGZr+wrVNjKFFLaO9GdFvOX8UlB4ivQgdmeYLvhX5pEk6efVm4PidDW57Udn9l8+zl/NisbRmXFm1kHfkqYWi0ILuvt2YWKQl+yMyRfuAA29yLV9tkTckMCj9i5Tglb+2k6XeG5HFxJBD/RXbCPnAPvy88QMzuoDN62X0vR7Tkr5Z8rUcrWF2mrZX5E0CLUWE5KgyzU1H8blhdWBSJikPYbmvKB1OQUE3mikxmg2BE+AfTjV4vzroilwQhAjmhQXCJqwt4tFhKJ/H5uxZ8MYGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E5vJTHvc92SQeXFktPfdXwF7voQcwovF+SvKuLo17LI=;
 b=ghgsVbYuVOkFpT59vcRCv0zju08/arL8m5R4OcEktP+mfHEAZ90DMvYHHm6s78D7knNFkOyv/CdLkAn+34WsZCiItEW4L2ODsHlk3D75Q7uQotRlRndkRms9wD+/rbdesIxfythj6lJukZ6YISevYN4EAmyvqUZlBy8rhddN0+NUxnAiDkr1ps855jFgU086/a0G+/gPDAH5w3iYl9QTeJXXeukcV0+4lKtss/Y4oA1IvWPw4zZici+A0B/SQybz/YPeRsXnEyG079QrgfeohHF8Vs+y9uClghPIeplvB6GN5CAsnOYdJeHWu1vkLEnheI+H5XuEJmKwVLC1M+uD/Q==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI0PR04MB10783.eurprd04.prod.outlook.com (2603:10a6:800:267::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.12; Sun, 31 Aug
 2025 07:43:00 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9094.011; Sun, 31 Aug 2025
 07:43:00 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>
CC: Cristian Marussi <cristian.marussi@arm.com>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	"arm-scmi@vger.kernel.org" <arm-scmi@vger.kernel.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 5/6] firmware: arm_scmi: imx: Support getting syslog of
 MISC protocol
Thread-Topic: [PATCH v3 5/6] firmware: arm_scmi: imx: Support getting syslog
 of MISC protocol
Thread-Index: AQHcFw9q55oSNfn4YUK28YlYd171XLR5gC+AgALjypA=
Date: Sun, 31 Aug 2025 07:43:00 +0000
Message-ID:
 <PAXPR04MB8459173FFB7E99C478BA1B378804A@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250827-sm-misc-api-v1-v3-0-82c982c1815a@nxp.com>
 <20250827-sm-misc-api-v1-v3-5-82c982c1815a@nxp.com>
 <20250829-ludicrous-giga-bison-aa8ace@sudeepholla>
In-Reply-To: <20250829-ludicrous-giga-bison-aa8ace@sudeepholla>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|VI0PR04MB10783:EE_
x-ms-office365-filtering-correlation-id: 51b55e74-c072-47c9-a3cc-08dde862029a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|19092799006|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?aoToWfP5Bd/UyT0nzyaIzoIgNgaz+bChwTQZhq4lQUU6ABfq9hJjn+RNNXv2?=
 =?us-ascii?Q?pHKiZIMT469S6/eSyr25jTLpCWVXwju7Qha9YVLb1Fb9iN5l0LwNDQ5mcohW?=
 =?us-ascii?Q?5uVhOeWa9F3U+oGfu7bR1XM9ZBLvdCgQ2trBA0uIbIgodiSZM0jq2cHKqIcP?=
 =?us-ascii?Q?ywneD4kojSdxA2aTG8WqIDud1W6Ay724FZyFptc+2dWnSSPqFakZGW+Tlok1?=
 =?us-ascii?Q?Lax6Nhez/88sGFvcRfXuQ4QrmlhrqfnoCbGLBoohVJdOWHNGIBoA+AFQoFMD?=
 =?us-ascii?Q?gde90/PtWNhSYqXL0mIct39hvIDvCk29hLBHzc3zGH2Wh0rhIVJD9xucjGw4?=
 =?us-ascii?Q?/nI0fImuMXpsrYWaZCNN5JffVx8sAF00e6rokDteWvcR5olUvaIh4c6g/cWH?=
 =?us-ascii?Q?uhuil6Q9J36QwSx7VuSckoejXFn0t1gUv8a3IdOENFTVpaMyvVaxk04ZBqUN?=
 =?us-ascii?Q?vAVKiZEXPIlChx0FsgRuBAfuFiO7J4F2ziDIfpniWroWW0f3A7vpuaFPoFZO?=
 =?us-ascii?Q?I/SOcsvys/Ht1rklyPw0l9aggiFrk6jQJ6VClp/nAyR0X27NLBsXc+rn6KK+?=
 =?us-ascii?Q?nmpVBVPjQEONEEFie9X1HZ1eM2ymTYX0ebR8pmyK1Hlyts0vbI2bCIIcSgCr?=
 =?us-ascii?Q?L8ByuPqFUeEAkH0HI3pNDqAtz7m90Y7dvao34Gf1q8rXmvy7Qy6dk4abpEvt?=
 =?us-ascii?Q?1hYGDTKITmzu6ViYIVUVrIOb7NZg81zS3ps2fqxFhX1fAWK2GpF1u/q5D/NN?=
 =?us-ascii?Q?E4Chi4rV8B5a17x8jGqbfKzY+8qW1J7y03ou2V/1p6ehP29VwMePdmqEo04H?=
 =?us-ascii?Q?Ru/zHdFvvvVrv9qCuU5mwwXta03+la3m9jol6Laxoif4A45I4LD1mwnSosgy?=
 =?us-ascii?Q?lY/S7IoFJcb2Xo+BB3cIs2vOUvPin/ea4/hLXhyy0FR9W8FggLOmuYcUpeJc?=
 =?us-ascii?Q?dKToEpad2Fa7HGFeP6XdaVglKJxubCjJ7QlqgOR9bNcuF9wuGg909GJTVm1F?=
 =?us-ascii?Q?277zFCYGnzTnyvqnLHffPHyxSTTy9jnzrUYT4kxs7bSSyZ2xNJnFDG+2uaxe?=
 =?us-ascii?Q?uhO2cYAHv7R9IZGk7eTCPEHFAz2+f/FzfHeJLLjVeW0GIFiL3i2ZE2275Sew?=
 =?us-ascii?Q?IZMdp+Ic6EEHf2Z4XFo7d/vhEM4HWxPzRAP0ryQT5WIzgg7PofsH92ybgfKn?=
 =?us-ascii?Q?JU49RCl1enFlLypEij0CAw2OmB9tM8od4Uyh/Vg0LbZmkt26w53rKp1HOTpH?=
 =?us-ascii?Q?Wu+XKTvufwwLSxUJLwXs2LGYmQyg4cZW3pF7smruhs99UiCr2Ke9IBquC5+U?=
 =?us-ascii?Q?G5ruDRBvurYtr3OoTz4IusLUvGfkF7C7XKGrt7N6+uwptFwxlhsMXUuuTG6R?=
 =?us-ascii?Q?fefTpnoOf/O2ktHBN/kOPpkdJsZ7LViVliGJ/o+4f75OBus8jrCEZ7m4niI2?=
 =?us-ascii?Q?WKTSMLwfPlDVc6PJ6W6J65rWJgjc086jn9nWSQ9WTQBsMvoiBP382g=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(19092799006)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?s3EOep2IbEYQfFWAneOYjrb3HardnIosvt0jTzas0poJHGf9uAsBkZ0YvyRQ?=
 =?us-ascii?Q?zA1jmaGXNiil8e2kLniSK5fQV3uw5K4CMI9FO994pp0Jqatt18WXFiUA7yxa?=
 =?us-ascii?Q?6bRgBzyLhIUeO7doYiSWhpt5E7nWRxWcMBgaigUdJI6N8w0nq0g584/inQdw?=
 =?us-ascii?Q?kCwK/oLhzH2ey4prephuXL7IgHEHoq0iLxuqCId+8i/6rvhvgZ/qf9RtkftT?=
 =?us-ascii?Q?yEdYhWEtoH1Qt4ix+3lYxwrKe2QyRUVljssO8sr6jlsNT1EiIhJU8fbHPMKi?=
 =?us-ascii?Q?WQMbZT12tAFFmN8eBQ8EvFuDdL+dCxkAeTShiH49GNMgRFDUyAeEkwENXdfm?=
 =?us-ascii?Q?cU3fAnjX6On6gr8FG575s+eFWXaRKXCstjUsXuDGuvIfeJd+/hMb9WQ+TVac?=
 =?us-ascii?Q?RazmyGTM28to0hmZBy8egR3j2MI1jo8Ih7WrB6HvxzFlRqPJQVL5S30dtdR4?=
 =?us-ascii?Q?7mnBGccRAcEBO5WF/aJTOsvRJhrojn2E1PVXeglYLxYf2vHb1c0h6EtINQBw?=
 =?us-ascii?Q?If/JVnObANC1ODkogFn2fjuhAwwK1j3E+WOmi3D3mJJ42qdvEx1ZJEIbqNyB?=
 =?us-ascii?Q?kR1hTifgDAVFWYLoB6NY2vtbDylkROpoQCGj3YZUbQNXnltAQVCk6q9FeJ6p?=
 =?us-ascii?Q?rutvyJ1voR+Q3oExF1cs/Y6kZIAt9FqeJoVUew/U1ZlIgZBZkkZH+IDcMHV4?=
 =?us-ascii?Q?WpcMMT2jAEdWl9ke1j+tUCKb8x5xsrpOcCAU9H731iwnHCqTGO1xRQks3OBE?=
 =?us-ascii?Q?HL0XuDDbCw1z0LLLGl1vf7kYOMmVx3LANFM74pz3IojWmKqp4mfEn8UUGqAr?=
 =?us-ascii?Q?YfNjQdxhLcTwwzE8W0aLBd5dnKZ9lpe/Avyav9dxdOnj9SmICpCOFXidHJwo?=
 =?us-ascii?Q?0FjThi6YxsOuQTM2V7qhndDO75cKqnsVzwLFoDlqNXk0ghJ+BZ2DTGFV2cGy?=
 =?us-ascii?Q?0AvNeSqUPYRln6z+uFAYynkaPvulzvrfTtnopK/mnmWN6eodqvcWCR8e2eKp?=
 =?us-ascii?Q?FYI6kiaoeDoDWpnHjJDlCYwJRzICobZAobQc+q5iFSECrd6ueGgH0XCYNFjP?=
 =?us-ascii?Q?SJ92VKrHvCwvbj3Oxkt43YSScZTV60nl4OTne5NTYjS+6Dn4L6MKYByJKiwr?=
 =?us-ascii?Q?48v12+92lG5PCjOp/YRkqIj2CedWGe4VRZxBHjTIEqPwwx2pzN6tW1D7Lks1?=
 =?us-ascii?Q?IsLsmiHfMSD7TNS83Pv2Ht5rPp4prVIU7W4o97lnNhqUmqQOT2Y5obWUxWqp?=
 =?us-ascii?Q?GQJhpyaXmsSJZUEc7+u2rdXZKMAU3KC0OGLCwG7Rmzoh6C2+zG0D27QgdY7G?=
 =?us-ascii?Q?Yi6NRHiiTs3n2W835tQeR27nSIC6q1851Bpd0k38u4fcTm3rTt1OfQc8agFa?=
 =?us-ascii?Q?lHSI+W0D4DQr1Y5fqmCjuRWw3aoKo2mJL16lpAmP+0s+oF384GeNnEKbeyH4?=
 =?us-ascii?Q?mWdLdkOdas5Fok/v1oXggLdduF0fBvFByFH7ju1N/23r6mLs7km5KZZZvAZU?=
 =?us-ascii?Q?dtwkRPGmJc6GrS4OeG57FjaWkhS1fvnK4NPlQwwP/snGFzoH96P1qDGMgFyy?=
 =?us-ascii?Q?B2qjBT6gdQGC2aEzj+Y=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 51b55e74-c072-47c9-a3cc-08dde862029a
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2025 07:43:00.4188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5R+lstD5DtRDwTT9AYSyiCFx/U4d68YXB000LqnDAzc2gJxw0czCI09qo8cciPyHVXHXkBt0Le+PqZmy2FkarQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10783

Hi Sudeep,

> Subject: Re: [PATCH v3 5/6] firmware: arm_scmi: imx: Support getting
> syslog of MISC protocol
>=20
> On Wed, Aug 27, 2025 at 12:59:17PM +0800, Peng Fan wrote:
>=20
> [...]
>=20
> >  static int scmi_imx_misc_protocol_init(const struct
> > scmi_protocol_handle *ph) diff --git
> > a/include/linux/scmi_imx_protocol.h
> > b/include/linux/scmi_imx_protocol.h
> > index
> >
> 27bd372cbfb142b6acb0b1cf4b82f061529d0d45..6e18920aac56de67d
> 388e985e330
> > 5745d3798c3e 100644
> > --- a/include/linux/scmi_imx_protocol.h
> > +++ b/include/linux/scmi_imx_protocol.h
> > @@ -52,6 +52,23 @@ struct scmi_imx_misc_ctrl_notify_report {
> >  	unsigned int		flags;
> >  };
> >
> > +struct scmi_imx_misc_sys_sleep_rec {
> > +	u32 sleepentryusec;
> > +	u32 sleepexitusec;
> > +	u32 sleepcnt;
> > +	u32 wakesource;
> > +	u32 mixpwrstat;
> > +	u32 mempwrstat;
> > +	u32 pllpwrstat;
> > +	u32 syssleepmode;
> > +	u32 syssleepflags;
> > +};
>=20
> And since the document/spec doesn't cover details on above, better to
> add comment for this to explain each of it.=20

ok. I will add comment for each entry.

How do you ensure the
> backward compatibility if you are assigning a structure to a log buffer
> that is not so structured the spec/document. Will be end up with one
> structure for each version if f/w screws up the structure ?

What I could do is to ask firmware developer not to change
the structure to keep backward compatibility and add comment in
imx-sm firmware to note this structure should be kept backward
compatible.

>=20
> Can it be a raw dump of man 4KB instead ? Sorry just realised it now.

4KB is quite a large area to dump, and current imx-sm only supports
to dump 40 bytes for syslog. The syslog size may expand in future,
but I think it may not reach to 4KB that large.

For raw dump, not sure you mean not parsing the data and just
export the raw data through sysfs interface or else.

But I would avoid user to directly get raw data. For
"diagnose message", raw data should be ok if future imx-sm
firmware supports diagnose from linux.

I am thinking to do a v4 in early next week if no big issues.
Then this patchset should have chance to catch your PR
in rc5 or rc6. Hope this is ok for you.

Thanks,
Peng.

>=20
> --
> Regards,
> Sudeep

