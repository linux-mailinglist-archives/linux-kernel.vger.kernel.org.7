Return-Path: <linux-kernel+bounces-825955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7EEB8D32D
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 03:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D09D3B5287
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 01:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94A87190473;
	Sun, 21 Sep 2025 01:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="UwAxoSJ4"
Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023118.outbound.protection.outlook.com [52.101.127.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC632940D;
	Sun, 21 Sep 2025 01:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758419141; cv=fail; b=DEhX5a8b8mHIcB9NXDiQf9MJEwCBfSjO9jwCzImWrULPs/n5zKjZSSDuwCdASJ8afrwPdOQNVC7PAjfl8uKmO8+kIMUE1499V00N5GZpt7chZIEAdk/N3YAPt9nOgpO1elQ5dpQJ/SSpNXCTF0wwMxt2toX9SgLv0yqcXdX0h8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758419141; c=relaxed/simple;
	bh=kCWxCMmSxB+uiRPQ1WAawKTBapq6J8ybP1UvGLYa3Dw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Wz1nAAyOJwksPUQmIZsJZkE2XE26BB8P3nQRGk8CMIs7KLVdubIoLqx0JXR/kCGZ/Mqz9OxEA9dtBhAXx5z5AWgHxN5lrKPdSenLNS3v+uLYgHPKIFY+5n0lZ9wy6xwL4LHBwto/AiwkLcdh8RbgTkUIb95nbz9GtwW+DsKRY80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=UwAxoSJ4; arc=fail smtp.client-ip=52.101.127.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ol5b4Pa50blRYMrgrkvs+ORs1GpKJh6rUVGhwZ1XvVUIe4vs09g+Gq9ILJAXCVYn8mCjbDwfsVcOoFGULc3K9dOPSRK05DJSNGNJj1gja95Iu5Xml+ATcLzlQGOOk0ixQ3MwBrwaJTLU0oSedHCYor2njbL3eDuVmYGrMQKd0rqXY7Nq08ZZT8t0+gIl2yT5OiIf0zmRoGJx63FCAEXrl0ke3IwrAcpjFjHQ5U+tNo8y55vg+zBjjG2eSVXaEYvd4pQxWgPTCfz9GjLorp2YKKOjeK4uzrkvrlBxwpVqaGvipoQeSlPU7U5iQWxPHZWkrLQEs3N8zu3dkQAjc8/lsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EqSLvudNeExgeLJBOeJYqkYjFphWSxIb2VoXhl7Yg4c=;
 b=y48g2ms/srONhksiUWBoBheQH47Q24Gkj99NOYyMohMfDDw4v3bl5UMi4WRAjynwkevT/L9TRsjxVaql6xX1Txswkm7MbkHICzhIS/p4vymiybtc5pTxofM2oqseU/5BFguzaw47pZjupYRXMJ/CoyzjktvQMyaZbbk2huy9LcfLrJV15l3huwxzwgLjcjYyNn4EiqhBKNGq5jS2IFB3Q3Er1Luy6Far9+r3f/Hhtzn4UqsHulB69VUBRHHT9UaEOilh9wgFW3878ZhZiBinPNC+SiRTNNGqc9FCC9a6GCO1A14RoS/QHtJeAsOByzfI0pcLZaX7x2CPg8pmzJ4p9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EqSLvudNeExgeLJBOeJYqkYjFphWSxIb2VoXhl7Yg4c=;
 b=UwAxoSJ4UtOBfBpHergt47V2g2alclMgxBsvXGDgoSsN4tahsX2QfhnlQ6BbQhR3ENpRiFibq0y63Lz17UL6WxVqYiNLMWKIHYmSzBnB/Wy5aA9NtLEL7rBUUek/DEHLuSqF/3Y4ywuT+PBpmk8QIsLVRpYul5FpR24OBe2qzoBekyZroIqAKwmXTWTpJOZMQ3QcPqyBg2mYa5L2cJsCEWBftwS5ulqrzmZXyXmby9UEPhxDcXcBOx8xK7hFaE+j1Q7rm9LD7JjGHZSDa06xD83SfFXQtaCdmO/VnFdr8EAKuZzfAHxWJNjpYmMIJ2yZ9QgNXHFTww1zDby7RAWI0g==
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com (2603:1096:604:2b1::11)
 by TYZPR06MB5276.apcprd06.prod.outlook.com (2603:1096:400:1f4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.18; Sun, 21 Sep
 2025 01:45:34 +0000
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11]) by OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11%6]) with mapi id 15.20.9137.018; Sun, 21 Sep 2025
 01:45:34 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Alan Stern <stern@rowland.harvard.edu>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 2/4] usb: uhci: Add reset control support
Thread-Topic: [PATCH v3 2/4] usb: uhci: Add reset control support
Thread-Index: AQHcKREd5VlUPj0h6Ey13T7T08axA7SamuyAgAJBwnA=
Date: Sun, 21 Sep 2025 01:45:34 +0000
Message-ID:
 <OS8PR06MB75419B5722DD375F493A7902F213A@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20250919025712.719246-1-ryan_chen@aspeedtech.com>
 <20250919025712.719246-3-ryan_chen@aspeedtech.com>
 <9c867c34-047d-4771-b9a6-a2c88dd1f800@rowland.harvard.edu>
In-Reply-To: <9c867c34-047d-4771-b9a6-a2c88dd1f800@rowland.harvard.edu>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS8PR06MB7541:EE_|TYZPR06MB5276:EE_
x-ms-office365-filtering-correlation-id: 673f6fec-ae3b-4de4-7781-08ddf8b08e63
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?OEcJ6NLAfiaNgCYR/uHgrFfTBww/E9L4QyBjLMxlMgc+n7OR11SQatSTwCHo?=
 =?us-ascii?Q?mXtPCBNbw416azk2gFcZ/XBWJlR8OhQU++8qSxR7LcU45ycx1yGZ1GSBwsD/?=
 =?us-ascii?Q?AvIgxy3LGQZaq1J7iV1tUO6pGtWy7bx2FDlTmlIYHu9SKlWSfx5r7WeSdWI7?=
 =?us-ascii?Q?CWKMr2AAl9zOGlaGIZ1PAxyr3xZX1S5FaUAinB7eI8N8rJlCrcQb/aIQEgxP?=
 =?us-ascii?Q?RQLRARREFmGFUiZq4KaUcl2p9JLmRrWQFGeqOummamQp/+I9WWiH0Hz0Zcw4?=
 =?us-ascii?Q?qY5wfpEfYXp2VBhwT1+tv0HrKCl6WuANA3d+P6rvWU2foz0/REicYyC9QMFM?=
 =?us-ascii?Q?VahEsCValjwIE7p+OUC4k0qscQ2YiEFYIjS+mUCFdYp28ASDXr2XPvrRhtji?=
 =?us-ascii?Q?F3xZLquuAig0Dek7UTqKmVbkLvooZbafbN4Ndn5e9TkXMWfbNyOnkrX0pOAy?=
 =?us-ascii?Q?p5iS2tzDrdYBAGdf/mvNu89+RX1Tj4/YEYCvIUeviTEgIqsCCPRKv2OjVkvc?=
 =?us-ascii?Q?Bsl6qmCIFMgRBZp77sRyk3rxhRO64aW+m42/lDXAFdvPg1rU+8zvW2cdPLiz?=
 =?us-ascii?Q?ATOdswkRTbfbW3maRTN52qwYTDesxZFOR0zUsHq/00hVSFpwQRj2HQB36hI/?=
 =?us-ascii?Q?Hb4hm/dGmyqCWoRFD9QPPAAT+2lyh8K7mrCP2tTeux9a4cxo4NtJI6oVl/cd?=
 =?us-ascii?Q?lu+etOVDC2KBmhcqGsukci9vTZatUqchJMBVrHE+r52ICggxUU/raihzVimJ?=
 =?us-ascii?Q?sZmbFA8E7PcsswK9vRAv9Px55E+X7zzJOLRYm1D/bB6x+BFMF60QuPccY1fw?=
 =?us-ascii?Q?JyUPrFOZCTBFbbUUpXCUC7HvDvQ2McGTecO4JVPP4IpaKbgl3iD1yR4ET7PB?=
 =?us-ascii?Q?7qqXnHRyAcIaLdjX/z6usCF1NRhV+Y6JhloUZLBlXzZYIEqPsmnWzQ3H5ICL?=
 =?us-ascii?Q?oVIJX+M/q70FTD6T4LAbJt9oo+WFtasXJdKDj2LwbMK4JFqRHoPoNbX82gZf?=
 =?us-ascii?Q?XC2DrOF68pTiI0nlN+TE/yjmlCAZSY4GfOg23zpfz3WjXa6R7M258/HDaFrv?=
 =?us-ascii?Q?T2jpTaRnlS25MQBMvZ4KtE6a8oPsE9D7VU+HxhHlsyGf2PQh8a02o7ibAuak?=
 =?us-ascii?Q?JuwDSfzdLJsK5pGH5qOsvasO9BXFpHPv4gOtzOkIxb3xkRDdkYHh5HNxfwbe?=
 =?us-ascii?Q?1E/+FavFq3PEpF4cXNgMBThtX6MZ8NdfkswoJY6SlFw+tBhUJ38lRzqs7Wz2?=
 =?us-ascii?Q?6pEoX3uUdA8QahpEkK06KZDmHAjD2lF1jwkUCOAbConboFx/jkLHkjOcXaX1?=
 =?us-ascii?Q?eQCqKi/iTQVOEoJWU0SMwBWcY25eAj6O10NxH5EPOtB4LPmrg8SpXSqZbKx2?=
 =?us-ascii?Q?88EIAN/2kp6sF8xm50f+0qkwOXncwUtvu3hhDACa+6lF9O5jDTitsWKmXoZC?=
 =?us-ascii?Q?JURUOYPJ+wc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7541.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?P+mAqvkBpx11psy4W4WcVSnQLt7C5ZS32OaOEFv5KChXzUEMGlVSnh7J+QmJ?=
 =?us-ascii?Q?wxVZTnU32HU618btysZOxs6oPv2DBiG2Vfqsw6dTboKFcaMA3xe/OdlXLFr2?=
 =?us-ascii?Q?qf2FEGHmCILVShD78VGqpWa61Rfp4XkdwvdUHEZ5s+l0uZRnUzXewdWhezvM?=
 =?us-ascii?Q?739BHvOVvby1ViyVJ9lANVibwfBWolTOwTm/27hzqgh0+kNBnKoprFwjNkD1?=
 =?us-ascii?Q?4qE9sUb/IoCIc5gJoYaM8Uih+0NyYueQKuPXUXSJEsO8lDnf/PVsOdNLqg8m?=
 =?us-ascii?Q?yQ7W8eslI7J0gN0g/eEX+yxVZQBqZoSKm2Fn3VdlW4nLRF8uIX/Gblj44ODR?=
 =?us-ascii?Q?BcAv7KrQnClMBA0hEEc/2oV5Cgoq9lSVOitZNquiMhieSzUOWToPFXoXOzSi?=
 =?us-ascii?Q?dRTbWnHFIkWKr7MjVsk5vFF1wtjCa38KzATQVHEHUdpmBWz2+g5I1Jn8Wniw?=
 =?us-ascii?Q?f4pHj67d7mUEbtpZR7wHoocibjvysgB0v95AbITlVZjnJHs/hANSv6ybND/f?=
 =?us-ascii?Q?8ywH3+TY7pb/rn19tia9iDxXLoVDKjcaNNDNbHsWJEWgpgsXx56d+N5B9tBY?=
 =?us-ascii?Q?cKANMsgkcwdHEpTizkf6Imdbs3SV3U+CNnqrNrreIiIBwwf0vAzTvHzZ8oZw?=
 =?us-ascii?Q?Z7YZ63VYyWYRxn41j8wwfoEKLE5mWrlIflMnJRnEeoJ8EOW9SnoLEiGJkzxG?=
 =?us-ascii?Q?TIayhY803JhP+FKfTVX5K376doTIBNQTo6S3Zi7klxDZHK0h28txmMGLsoKt?=
 =?us-ascii?Q?1WnMBc0H7V55Xln7pzFs/uhA4wVGBH5JQLf3Czk7nDQLCRokxxTUFv2D7zXQ?=
 =?us-ascii?Q?5jm2YJM2eqOf/64UyodUl++zR44SjU6+z57DTPAS+HgqJ8h4D3Pz1v8Jev1H?=
 =?us-ascii?Q?ksa11LKNXl1+t0ZNKRHQLAnSV8HE2LvQP2hiHHAFr0ZYuyjo0902DBfrFh2x?=
 =?us-ascii?Q?BzVDnFeszniYklaqDu1NLlqQP/1fPNw5FXx3vsKsCgdSB0TlHI0r+O6e4u5Q?=
 =?us-ascii?Q?QGqUPNUYr8xc/iz/RLxFKyA6I24a3aCyQZJG726IbbqG9U5BXjWqCa6ks9Kg?=
 =?us-ascii?Q?7Aha3nHD7SJG5gG+4AjBrXeYmrZ3Z2NzhpMDapSZN9PxYXRR8bhCDYNK1/s/?=
 =?us-ascii?Q?p9e/sYA4DEbw/JkKG5SLZ8wOvB8sK/PWcjFLWdB3wM5IDoSELVs9vD5NH9Lr?=
 =?us-ascii?Q?oClQc8kIwv2EBXkBqLX9Ij00RY+JSLsxeTYExk6btct4G7j0mJ7peYfAymPX?=
 =?us-ascii?Q?AwLHDpDl2FV6ejDR8N9o1O1onzQHSPMeScEUVccCUkzADQhxC7o1tKlcPfku?=
 =?us-ascii?Q?pMPqg+nQ2Baz6GxcVNlxbfOYEluaL5x9o4sffIqBI4W5Tby6VescPoskScbS?=
 =?us-ascii?Q?HTvEfvTHD53YVpajkutdaj9Th+HzsnuxWt3RcLFUZeFBFfRhljLl5YmQeKPy?=
 =?us-ascii?Q?JaPGE0EQ5BYFt/unKx+DRQ/pepNTFd8M8dghxsT+hrv+3FCYLfY6/QdKDeWU?=
 =?us-ascii?Q?5AQAEWCf3bT/s9lnZDaVgEh6Tb/vUpAPqUYEfpWwDZVBk9tjlUwBzCNal5hu?=
 =?us-ascii?Q?vNsvUlMdVRiKbObjnwe+x5iMhnGWDr4O3d3q7yWM?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 673f6fec-ae3b-4de4-7781-08ddf8b08e63
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2025 01:45:34.2714
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kACx1IpscOuGkr6sxHRXTmbK+Rha2HZwJs94Pc6lwp/VAKkzGdCrTi/pGz7KLrloAG5Mpg6BsNFoEEO4t9Mj9gv8Edtt7coWp11lsav6vuk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5276

> Subject: Re: [PATCH v3 2/4] usb: uhci: Add reset control support
>=20
> On Fri, Sep 19, 2025 at 10:57:10AM +0800, Ryan Chen wrote:
> > Some SoCs, such as the Aspeed AST2700, require the UHCI controller to
> > be taken out of reset before it can operate. Add optional reset
> > control support to the UHCI platform driver.
> >
> > The driver now acquires an optional reset line from device tree,
> > deasserts it during probe, and asserts it again in the error path and
> > shutdown.
> >
> > Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> > ---
> >  drivers/usb/host/uhci-hcd.h      |  1 +
> >  drivers/usb/host/uhci-platform.c | 18 ++++++++++++++++--
> >  2 files changed, 17 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/usb/host/uhci-hcd.h b/drivers/usb/host/uhci-hcd.h
> > index 13ee2a6144b2..4326d1f3ca76 100644
> > --- a/drivers/usb/host/uhci-hcd.h
> > +++ b/drivers/usb/host/uhci-hcd.h
> > @@ -445,6 +445,7 @@ struct uhci_hcd {
> >  	short load[MAX_PHASE];			/* Periodic allocations */
> >
> >  	struct clk *clk;			/* (optional) clock source */
> > +	struct reset_control *rsts;		/* (optional) clock reset */
> >
> >  	/* Reset host controller */
> >  	void	(*reset_hc) (struct uhci_hcd *uhci);
> > diff --git a/drivers/usb/host/uhci-platform.c
> > b/drivers/usb/host/uhci-platform.c
> > index 62318291f566..f255358d6242 100644
> > --- a/drivers/usb/host/uhci-platform.c
> > +++ b/drivers/usb/host/uhci-platform.c
> > @@ -11,6 +11,7 @@
> >  #include <linux/of.h>
> >  #include <linux/device.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/reset.h>
> >
> >  static int uhci_platform_init(struct usb_hcd *hcd)  { @@ -132,17
> > +133,29 @@ static int uhci_hcd_platform_probe(struct platform_device
> *pdev)
> >  		goto err_rmr;
> >  	}
> >
> > +	uhci->rsts =3D devm_reset_control_array_get_optional_shared(&pdev->de=
v);
> > +	if (IS_ERR(uhci->rsts)) {
> > +		ret =3D PTR_ERR(uhci->rsts);
> > +		goto err_clk;
> > +	}
> > +	ret =3D reset_control_deassert(uhci->rsts);
>=20
> Does this work right if uhci->rsts is NULL?
>=20
> > +	if (ret)
> > +		goto err_clk;
> > +
> >  	ret =3D platform_get_irq(pdev, 0);
> >  	if (ret < 0)
> > -		goto err_clk;
> > +		goto err_reset;
> >
> >  	ret =3D usb_add_hcd(hcd, ret, IRQF_SHARED);
> >  	if (ret)
> > -		goto err_clk;
> > +		goto err_reset;
> >
> >  	device_wakeup_enable(hcd->self.controller);
> >  	return 0;
> >
> > +err_reset:
> > +	if (!IS_ERR_OR_NULL(uhci->rsts))
> > +		reset_control_assert(uhci->rsts);
>=20
> How could this code ever execute if uhci->rsts is an ERR_PTR?
>=20
> Also, why does this code test for NULL...

Will add with following.
	if (uhci->rsts) {
		ret =3D reset_control_deassert(uhci->rsts);
		if (ret)
			goto err_clk;
	}

I will test it with non-resets platform.
>=20
> >  err_clk:
> >  	clk_disable_unprepare(uhci->clk);
> >  err_rmr:
> > @@ -156,6 +169,7 @@ static void uhci_hcd_platform_remove(struct
> platform_device *pdev)
> >  	struct usb_hcd *hcd =3D platform_get_drvdata(pdev);
> >  	struct uhci_hcd *uhci =3D hcd_to_uhci(hcd);
> >
> > +	reset_control_assert(uhci->rsts);
>=20
> when this code doesn't?

Both reset_control_assert() and reset_control_deassert() already handle=20
NULL and ERR_PTR safely in the reset framework.
https://github.com/torvalds/linux/blob/master/drivers/reset/core.c#L468-L47=
2

>=20
> Alan Stern
>=20
> >  	clk_disable_unprepare(uhci->clk);
> >  	usb_remove_hcd(hcd);
> >  	usb_put_hcd(hcd);
> > --
> > 2.34.1
> >

