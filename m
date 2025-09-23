Return-Path: <linux-kernel+bounces-828886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED792B95C1B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 13:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A779148424A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 11:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FDC7322C8C;
	Tue, 23 Sep 2025 11:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CquEd3lz"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011019.outbound.protection.outlook.com [40.107.130.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39D5322C65;
	Tue, 23 Sep 2025 11:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758628675; cv=fail; b=aMZSRf6Q3LuMp2YP40KCServ0ojBgSCh8C84da3wllZAEpdW9vAS7ZtYtVfSrxHuVrwOwjPtIrGbb7y07NgEac733hghhLSh8BCJasDrHOV8CVGfoY13fF3KSvBrQNXhHvdynlWRYR6NSwFjf9YsB591/CIxTVls1YApr6joCCY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758628675; c=relaxed/simple;
	bh=XvlTItsOaIrJw96VFPanvKd5UjX7x9J/rnR7Hn872jY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SMwJyiRYR3HnV0JF3aNkuTPp71SCMB1eWs6TzvizxR0RwDfGy28WLrdBLbZOIk8DkxF1rQipruIoRYZQEp/pk+NEnleVZ4xWswSfk6q3ZNob93kD2ZicahppOdoUvIqmePjCUNhkpfhG3b3kCuRWwBCrednB1u1nNm/yXPg/sgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CquEd3lz; arc=fail smtp.client-ip=40.107.130.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YUIYpikSd+OAzIA/vQREZmHHVqmC8XrvE2SpNR5H6dWxD4csEbE1lpDiQi4ICWjh5sHFQhgFpypZy35ZoG5Mfs88HlFVXwUJRpnJR2709AOxTAi8zAq/sJD+LTdItZcBsy3IibTqwF+3S0loG87jOmwYW1Q/vsNF2uHlupaNEJmpGIXMKVLCGlI7cl46VdWTzkS+aX5sP/H2kOqkIAq6qZejpj9S9Qszx8JgdRmlD1vTwSOor96ks6QCjrd7yODlZIFfGSCx9qRMZhGPBILwJpQhqR8F8E0y1NgICWGXm8UFSHqyhLLCYwgpO8DibJY1d+My9oScqtzJQjCniVvMNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rWhggMy8zwU72EjbNJ24ImOpFmaU+R/sdggF9MLMwCA=;
 b=e1bqFLKMWs7nqrDwqXCTs22q2YUB2r6J1IJVlUOU+GEkn703eOL1Vgtw5zuR0uXg8bY8dnFQ6q1y2IXDisC05thXmBsUOFU4M7mp6nzH62bh5wV7mIJn09MhA5r+fyI5Mk5GEs5LzixFQ/d7iE/iHZ25x9ct+ExDMnefV6fZ19SGapzLGEo9WNJmdL9xrLjlR0Zj4+7wTZglEd/Kg+uaeBgUXejG+HBvsLDzPThTzLPwbUXhbOcLv+wVVPoI1N0FmR2+68UF9e7qdgGDqNOG+HR4QJnueN6kHL848Kvzy87lNV9KqdCpNkVmTXPe1SiZNglQIUR0mVgXmxu1UwALDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rWhggMy8zwU72EjbNJ24ImOpFmaU+R/sdggF9MLMwCA=;
 b=CquEd3lztp3RVKidlSR/bHWnj0BfTqLXD0M/dvN4CPcA+plKEiwaqpyGwbFeUF+hDmvbWsyXnCLQ0xPSdto6w+Jlpf+ZKS0vaQnthHTCHvZj3YEqNTlimbl7yeOo/PQpl21NEDsb/FwjzMLzT514GIn5nnYP5p1Lk0JXDTc8+3eHMES7w1gYKvg8HS04G3T7mgBz2crVKWcYQWd3yu29bWQAJELbBbHwbMNS9INHX24xpUsaLRELrwvKGKAYNb5cgDV783pjfTy1DjeX3oGTl4Pk5FIH0+HvG0sSU3v630daG4aZkYUIcShkSigxiez8FBQsrWZwIzIeDpavIoVLYw==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV1PR04MB10274.eurprd04.prod.outlook.com (2603:10a6:150:1ac::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Tue, 23 Sep
 2025 11:57:49 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 11:57:49 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Sebin Francis <sebin.francis@ti.com>, Michael Turquette
	<mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Sudeep Holla
	<sudeep.holla@arm.com>, Cristian Marussi <cristian.marussi@arm.com>, Marco
 Felsch <m.felsch@pengutronix.de>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Brian
 Masney <bmasney@redhat.com>
CC: Dan Carpenter <dan.carpenter@linaro.org>, Geert Uytterhoeven
	<geert@linux-m68k.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "arm-scmi@vger.kernel.org"
	<arm-scmi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: RE: [PATCH v4 5/5] clk: scmi: Support Spread Spectrum for NXP i.MX95
Thread-Topic: [PATCH v4 5/5] clk: scmi: Support Spread Spectrum for NXP i.MX95
Thread-Index: AQHcJhsCzmRSrEp0oEyqjCzMN4tqC7SgpByAgAAO97A=
Date: Tue, 23 Sep 2025 11:57:48 +0000
Message-ID:
 <PAXPR04MB8459CE9F22CD56A9BFDB5E78881DA@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250915-clk-ssc-version1-v4-0-5a2cee2f0351@nxp.com>
 <20250915-clk-ssc-version1-v4-5-5a2cee2f0351@nxp.com>
 <5f508f1d-2d08-4687-86cd-d1944caa0a49@ti.com>
In-Reply-To: <5f508f1d-2d08-4687-86cd-d1944caa0a49@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|GV1PR04MB10274:EE_
x-ms-office365-filtering-correlation-id: a643c369-05bc-4ad6-1257-08ddfa986ad0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|7416014|1800799024|376014|366016|921020|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?BzfvtKV6uGnYyP7hYo99FJ9axH3WX0OxSa9p9HjDmdB5eptnikirjvyS9FkG?=
 =?us-ascii?Q?uW2VQUHOfS2TX/v9nFeacEV2WY7dsDU8hDB73f7g+huTV8ymFG6+tUUMspkB?=
 =?us-ascii?Q?7jlATZKoeeGivHbGah5sG8X6dlHXJ4eZxssIBgQG+M0wKDRVqPBSU7BVvmjW?=
 =?us-ascii?Q?5TwqtG2/7QX1Z65g+mqVpG/MwFD25IOll9yowad/7D9YmMliwPbRV1B95KCM?=
 =?us-ascii?Q?XoKTj85CYJ2Nb5DGNRjSrDeDTA43FTA4xTLZMAjK/bEfA8XlJebB1ihOMrv3?=
 =?us-ascii?Q?CkfNHgeXvTHcO8w4fQyChvYRMEiu0JjvkmZQc+rNOTiDuR2U46jGjnegVcyI?=
 =?us-ascii?Q?6qvUBsE5JL5N3bcsHbO04Zjl0Vxx2y4a/00nvK1wHuaP1b4a5TjK8ehGic7e?=
 =?us-ascii?Q?nqdkkqHICYA4S/5BbFmrVE+yDeGCiYa7OZoXCt1DVt94WKb2LNDoqoQ/4smN?=
 =?us-ascii?Q?SD32qt22hGXAqv6+IDBxeWMh7u/D8JEk9zZr50dugnezeHLgzVDX22dz4BTg?=
 =?us-ascii?Q?enC5P5OYyow7MDDst5rViN8D5Zv/ZRzEysEhd7/itMy6H9akmS+zGv1A1MLf?=
 =?us-ascii?Q?MQWv2nIxvYJlZV0J1SNe4onZM3GSs3fcImWCzesp3p7cZI3iJnA3fqJzzEg+?=
 =?us-ascii?Q?unN+ZQMQMFFpta973sI0Lcvo5bwdIJ9McctiWX+/fvi0ulcgtxENsJO8WAYx?=
 =?us-ascii?Q?C3Gu+mgQyawPubfBJoU4xQ3q0BHz8X4Dp1dkyDMuLrKrGfOsL5OIX8vmYbWM?=
 =?us-ascii?Q?elcH7H6QH+xbHTksznJPHjPn6BSOY7CS35KhNSCbP5fT80QRfVPLzAHSHK98?=
 =?us-ascii?Q?IAhfCeeV3+UsGntL13lSoeyOHhQrJbLhv99U42YjdaAO2EqK3lZhTbbR64Ci?=
 =?us-ascii?Q?A6A74UhlgpKf6kmtjaah/uX/pVFSnCIyXtbXNXBLtJ9dJwFaRyKa23B/BD5I?=
 =?us-ascii?Q?jOOke4zgBq2LZmWxJCbzqm+K8XDoLDFebCAFNlvA9PINCarmh0IqbXZG1fcu?=
 =?us-ascii?Q?dV++fzJJOxx6iq5PeweWUJ7tozY8le0LJM62peIYG5l0kMJe+3+iLR9jZbQL?=
 =?us-ascii?Q?8la6e+dKCTw/Uy4rYf0jQYKUIcRKn4JlfLSIx+py2hgMBvI3+IDB8K0EQ88I?=
 =?us-ascii?Q?alGXf1KDVCg/GBT0ypMfLynGxiyDUw4yFRqDSr/1P/RclD+u80D+BJtsEPj3?=
 =?us-ascii?Q?W5GPOS0EsmfiMdSXfIoP7XXvTX7tsNIpaIkVdgurHt8zTYzGyn00XPMM0vJo?=
 =?us-ascii?Q?vhsu5aH9m8+9elQA4c/tkCTrLBNzDRY78M/V6QpuZPyhIK9oqbldqQPMLwh6?=
 =?us-ascii?Q?bzmdeucM+GXnODixIfoLbDuVQIZLCR0iSUY2NHc0Qy80UKbGjfP9xD1fkioe?=
 =?us-ascii?Q?ke2a3Xe/9xG31SQDbTas+Eg/6EJmZNhofHt6POUwIb0rddflYuKzVTG4j+k/?=
 =?us-ascii?Q?trgsg52NxCSSlwSbNGuJKBFr00xiUo5O6TNG/ReV9WJ3RXJv8B5YGOP5c/Ma?=
 =?us-ascii?Q?mnA5AGlM5cd9zdNcJ7druqaj67qmIDBctih5?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(1800799024)(376014)(366016)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?XRXC4DAXvkAFrxCKUYBQsGr5QiOAwXIBi2XCIcexOisBR4QBfRfLIkP4SL7M?=
 =?us-ascii?Q?w7WaT7ekNM3hEBJlclXVg1rHxqIeIA3d5/NQ+seMWBMarZDThET8We2y/9bl?=
 =?us-ascii?Q?u0dnbKenH7/9rxBjByI3gyZlWENjZ1O8FXB36mV6ucr/J2WQLHh/u+9sKSxn?=
 =?us-ascii?Q?qiF0Gg+/47fWLeoy+2bHsVMVt57WX/knN4l1Sb81U5gHrjaxxVPxGJJpz9Cd?=
 =?us-ascii?Q?bouOPWEpDXbwiDJeXw/1uvy93HdAYcg5BkTbvod3kmd8NjJEButyDXfGEs1+?=
 =?us-ascii?Q?1yCyaoI8VWeP2bm/mKAKu2Y7syvnA1JFzoj/pJ7YKKYOq9kYaosWwMYkDu6N?=
 =?us-ascii?Q?RzaLoOChBC+nMu926GpoHCtkKjFGJC4gCvnl+BJEp1YE46lY/2aH40BygIQr?=
 =?us-ascii?Q?DsSPg0AH3wo0frvoiWM/HbV8OKq+M051KcRPEjksOiL4HiuIrs4uaWVRTvE/?=
 =?us-ascii?Q?YkuI4R9lMAUI5rKSnpLG25NmohPsQsdBg7jh2BSqKd9L3Cx7OilI2lBSwNww?=
 =?us-ascii?Q?ydAShhm21tsMfsoARPCC/ScT02a4tqo398wvn4n3bty1wSOf9vsV5H3FwJ6F?=
 =?us-ascii?Q?bVV+F0qRTcaa5JQxunn/n3+hKUAi+rfhoiLX3nEAQMhrEewWyNABZwTGe7i4?=
 =?us-ascii?Q?kM5clxbww0qmsqvo5i3d4i9BtCOOkDaSrl1Ni+0V7OATzufLrDsYbH8TT8V9?=
 =?us-ascii?Q?ER/9X+P8DN4VxKLGRJ+QgpB8aAGaaW3WJNN4zAZ/PnQxcOzsqdPp6q8RxTYu?=
 =?us-ascii?Q?+spF6xSPuL4QUpxlxdLqNttxzb+MIeryhWlUQH+ybnUQsB5zhQ4pRV1zgUvB?=
 =?us-ascii?Q?fIPAJtaQ41gUAVnJIMi246zXnbq8sDXyqILGjRhOlXsYN3Zf2c2d5yrBJepn?=
 =?us-ascii?Q?UJZEcjF4tzqnngLaTcuObBOqgN+AiV9fVI7+drvcouBiRB/AD2opJ56rdR5D?=
 =?us-ascii?Q?BfiB3F0F1C3DCkFgV+tT9p7CNdjW9AuEJB8oAU0rz+cD//UBqphxNf+hPxxc?=
 =?us-ascii?Q?uDVM86/6Q2MzE960H+6Z8DU6cCQpK6tVxDEy4fXwG1201ST0lSEQHtXwsU8X?=
 =?us-ascii?Q?usbYbi1SAYV0iLrnfH3zSEJYi/suacLYEUV+9a0Zgu3V20lfUHnmU1CyezO3?=
 =?us-ascii?Q?qLBtX4ue5jkmCm55/cyLdV0U7jdiIRDlDUp9k2A6wG7iR5lsbJ+w5rkDG/36?=
 =?us-ascii?Q?VgShNf6Znz0n1f08hOqU2ouOB53bXT+QXc3b8OUejbjIodE1vXtCLgW+ytuq?=
 =?us-ascii?Q?XqnJv4Iu1p6yCIsTD4mq+lhWmjDXpBlWBRhdO8jnD6pmXa6q2Ip6sys4oUsQ?=
 =?us-ascii?Q?gH6a0vH+okZWQQD8xKORwZLmCFqJHY9QAdDRnvIabC5rrJ/egqzJ8mOon2hN?=
 =?us-ascii?Q?lt+z//AdaM91gasf8LmlhNNMUNELKT7DMBOLY2rG6JeYI4zEAXiTKZaUnHYu?=
 =?us-ascii?Q?Tz8Sbse0BnfxZL/PvG5+HCaqqig9SG9SwBZgk11Lhe7xm47pUfeW+WGF0BS0?=
 =?us-ascii?Q?KHtGTwq8bSWmCKCqeofwi7YZt3ddXXkqJSql4xucBPACdKSMcX3Nx8cgBFcH?=
 =?us-ascii?Q?BTL/5wsjZkCmTPmP7tk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a643c369-05bc-4ad6-1257-08ddfa986ad0
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2025 11:57:48.9843
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qf1PqUjOUALvuDBSZ1RKkh3EgL6XUimUkJ2hcHQKIrhvAuHwdkPgx4EjclFw2f9gJ8HbVYWF6PZhwygF4KFa1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10274

Hi Sebin,

> Subject: Re: [PATCH v4 5/5] clk: scmi: Support Spread Spectrum for
> NXP i.MX95
>=20
> > --- a/include/linux/scmi_protocol.h
> > +++ b/include/linux/scmi_protocol.h
> > @@ -80,9 +80,14 @@ enum scmi_clock_oem_config {
> >       SCMI_CLOCK_CFG_DUTY_CYCLE =3D 0x1,
> >       SCMI_CLOCK_CFG_PHASE,
> >       SCMI_CLOCK_CFG_OEM_START =3D 0x80,
> > +     SCMI_CLOCK_CFG_IMX_SSC =3D 0x80,
>=20
> TI is also planning to implement the same in our upcoming platform. so
> can we use a generic ID instead of vender specfic message ID?

I tried to push to new generic ID [1] in half a year ago, but in the end AR=
M
decided not to add generic ID for spread spectrum support.

To i.MX, it is too late to use a generic ID and waiting spec, i.MX firmware
has been public for quite some time and passed several external releases.
So I need to use what our firmware adds and spec allows: vendor
extension.

[1] https://lore.kernel.org/arm-scmi/Z8iKErarE0lHWxEy@pluto/

Regards,
Peng.

