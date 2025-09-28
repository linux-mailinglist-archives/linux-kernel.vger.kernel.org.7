Return-Path: <linux-kernel+bounces-835159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D417BA6696
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 04:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B02E189BD12
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 02:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B7524DCE8;
	Sun, 28 Sep 2025 02:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="MW5pm26f"
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022091.outbound.protection.outlook.com [52.101.126.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3870B70809;
	Sun, 28 Sep 2025 02:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759028098; cv=fail; b=Pt+zodz1bd5sopTrLbU+exbko9O8UdaDt9kcow1Yn8FwI3wGHkM0w+S5Ay/eWboIvhNbS0OiJa4iIK0YX44EntBGkMZQpXvhGSEBDi+cK3YjY0yaaBPpSe/7oa3EHrp3V1gs+uDIUFUS6qYcco3kFZQfVpmw4Fh+CM4ay897RRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759028098; c=relaxed/simple;
	bh=cJmOkS/p3wOJh8fmR+aIYlP1B+fKtGS/zfNynSTUkwI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OPaUd0w/NHdohLnT8+KbYxghH779kof/+PUQtJ5EUtR6F0+ro4ahxdVJ8EPX1mPswCi+VekPmXLH8iVtdPuLXuJlGrpejECyZSlKF35Bz86+0an8AzxQ1xDxKtnAxvOWxoxoy4+BrxFercf3oAtvvoDwKAJvme051hhEzF5tbak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=MW5pm26f; arc=fail smtp.client-ip=52.101.126.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EuWcAqsanpnvstdDlFJ0Qv2IJ2s2LXtybW++bgJ/RAKpPfwlO2RHhJYkb6fqZTADYH/on0BP9d+VoXUXH2cWrBn15WaR3maEDmrQWtCqbrSb2WDHXSmEpEQppVh+50u4eM6CPLwDdPLzScIEltzUBPazrmWdPFGO9Wo9+B9v3G5laVrZ4g9KpClY9CgrO2BxyA4SOTVhv0D50XasIsvqN7ywRwNmbpkl2DcGzPUXe3+5KWHO5ZIAtU/YgYJSxgE/IWN+Aq2JooGYTp93FAP2xnMPgE0eV0tZpih1b01EZbx3hJ2uztG1Igg6MIYIilbqK4ZkbIE3XbD+vmVUZMIROQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aVg5KBDm6ugeiyTOllHXPp5GhmLZ20bEIf6Fl/jDLfQ=;
 b=kYGRHX70joCFLhLTdPTR/+wgMHxq2n2HvLa3WTrhhSzZmjJDOJEpkZx2QAgM6BR3h73cuhNHvrOtb56r1mfJXThG0JWF1v1yMwcz0p/AvVjRsketOe2/Hd+Mx78RfDAyqHYU+pIZz9+v/f9TccEfGT1LbBJsMOJankXUFo7EzQl3FT43O/9tOEcPh14SteD+y98pVUBWgDt/7fl2cJHT0MaZRNE0J7Mw0ZOYoZwL+XtBe2m+TUrS1e/INcwiyZtKlLHwqEUfBMu6AQQarwPfRHPqn1IU+1QzLEMXpyLLYT3JIBQS+xruJnHn0CzfPKPd/Slz274GI9KrGnozamPFtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aVg5KBDm6ugeiyTOllHXPp5GhmLZ20bEIf6Fl/jDLfQ=;
 b=MW5pm26fajOa9K1Fcs1Dsv+mPPWDgvMKwK5pX8T8sAM1nK63KZFJfsDX9gZBuqgKqu0xj5u/fEiK4fQmswbxqblf0oi79jv3Zc9QNNr0KtqxV/rX8HXwR4INzp3ThCQGJTdXWEyZn/JUAHIGgUh4UwTtgK5+b5rr1aVkVs8E6gI73UQXdx/po7NfK+mc7Y9yweUzibSxvPtrIbsBqXiDZHAYWkq2BkejoZ02nUBV6KnZzQ+/jk5M4qeF9o2VHVsh6DNW12IAJ7Z1wtjogbOezzj/sOPvSTHXLqcbPwo7BNaSBt5JkXDNy+RByU6yjIspFuJ2JcAhofi56J4LQ6PmTA==
Received: from PS1PPF63C81D79D.apcprd06.prod.outlook.com (2603:1096:308::252)
 by PUZPR06MB6221.apcprd06.prod.outlook.com (2603:1096:301:118::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.15; Sun, 28 Sep
 2025 02:54:52 +0000
Received: from PS1PPF63C81D79D.apcprd06.prod.outlook.com
 ([fe80::23ba:68b9:bbb7:57d]) by PS1PPF63C81D79D.apcprd06.prod.outlook.com
 ([fe80::23ba:68b9:bbb7:57d%7]) with mapi id 15.20.9115.017; Sun, 28 Sep 2025
 02:54:52 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Alan Stern <stern@rowland.harvard.edu>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] usb: ehci: Add Aspeed AST2700 support
Thread-Topic: [PATCH v2 2/2] usb: ehci: Add Aspeed AST2700 support
Thread-Index: AQHcLo3oil2sZj6Gf0WoLWfVly274rSlk7UAgAJVZbA=
Date: Sun, 28 Sep 2025 02:54:52 +0000
Message-ID:
 <PS1PPF63C81D79D349C89DFE6D73F74B1EFF218A@PS1PPF63C81D79D.apcprd06.prod.outlook.com>
References: <20250926023308.2890607-1-ryan_chen@aspeedtech.com>
 <20250926023308.2890607-3-ryan_chen@aspeedtech.com>
 <69e6fd9c-6020-4caf-b6e4-644ae794d421@rowland.harvard.edu>
In-Reply-To: <69e6fd9c-6020-4caf-b6e4-644ae794d421@rowland.harvard.edu>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PS1PPF63C81D79D:EE_|PUZPR06MB6221:EE_
x-ms-office365-filtering-correlation-id: bf8429b2-eef9-4bad-8d0b-08ddfe3a658e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?eitzxb4QmHPtMVSDmoGwL6LxdSJQsG3QvriY2eoS0m0Os4bsPgwfi3xtPDqS?=
 =?us-ascii?Q?rR4QXJ7Fdd1Jt5aTqjKjc3DBVBUci4VeJ+VAh2xpxzJqeFg1Uih/AWXI/6ba?=
 =?us-ascii?Q?6JP2GKSXlFLSZ9ifaPxi4xQg/TmpguIGs58MO0Qgl9j62skvt6Ll6fNRotwJ?=
 =?us-ascii?Q?xi3PF+55ZTaLt6nBheAHXrQ8oU5S/j2FrgxuuQBviKw8aCDSKBT2ybuYm/++?=
 =?us-ascii?Q?AXEVovJUCUo9zticmNKsKGXgQJbIKQ9a7S5m22Kqt0/BOw95LJUq5MS46mLw?=
 =?us-ascii?Q?1QAV0PH3EdQ19SCX3pKkXagiQ+J1D+3kICG566sZnb9yuvCb0RCkIGiLf8Lo?=
 =?us-ascii?Q?9depCSlBm9E9XEg0wHr57+WhCzYcHgN1mDIiujQQmx0HX1XyCVemfVjZXQBN?=
 =?us-ascii?Q?gaJgsiV5iJmbrSncGrB8HHlQHEK4+0DodPm5F6ZuLSu+tKxXedRZEiSIqpea?=
 =?us-ascii?Q?iBL9PijIBbZ/dujIXwzKXjdFsoleOgTp8ZLvRaD+/ijMnSM8E3fZrikJrxr6?=
 =?us-ascii?Q?b68pzIJK3SAV1rc/KEiQJa+Ss++h76bF81dHE3zyAjKfQJcKV3J5NjDI8hFV?=
 =?us-ascii?Q?JUhaiy4s3iskwXtmDd0n2Jz9y00OyueGsZrdeLByxuQnknYDTrUaoEbTr5m/?=
 =?us-ascii?Q?z2k/g9tSw0oPTFBhuAQ4RPQy8MYkL5Brs8w/S8u5P24u3aJqg9pkvR5rteXd?=
 =?us-ascii?Q?Grsu1RTaGCjLnRA5x0kdzrFHTmWph5kSz8IaILIDDGf0mEDzEqxlogwBSKTp?=
 =?us-ascii?Q?i1V3LtaBNdrrfZ7R2dKvSraJghVIGfw2i7FgCIFL4iWKiyi5Bjl1FsUE2nsF?=
 =?us-ascii?Q?3mqvNHVkOjfxO7JwmznP6ea62ILeLl4dyy1nYS4uYsILAjvXMMPY2cl2mwIM?=
 =?us-ascii?Q?tfsnbj5mbhj+KhO2rTRAgDdPAF8GhdEMOWjWAQSNfEVyPJm8oBMukOT0jLh6?=
 =?us-ascii?Q?Cj1OSTqawbOy/uvPrHSBZTAc8PSbu8LT2cuR14WrjcCUQuj1iX1bD3Mk3NbZ?=
 =?us-ascii?Q?vQtt7DLbqAwL8f5OQH3KXfcai8th54EDMnwURxYX0PgYEC9v2HXYrS4MBSlP?=
 =?us-ascii?Q?qDqdtSR4GTIstRckfdlp1PnQbJDoHv667GCTL0RNzBCFTDd8DGs1SqZQVPDQ?=
 =?us-ascii?Q?OivWNZFwwA8/A5nOS8+A59G67r72v+d5ZQ9WLlokeAN6E4AyLt1swf4CbtdR?=
 =?us-ascii?Q?pQbAtDuvmhlqLj+OxnAqTkAku0vCSpOkOF6oAaO6iFIYEihsH9Rd7alGWLr/?=
 =?us-ascii?Q?xLELGZX5wWH8pOTWiL0PfZUhmxjqWoCy6JJ3iomqvxYj+WlZnze8MnucfxSu?=
 =?us-ascii?Q?4T0uLPDbcXHELDh00rJe05YuqLdiWIptJsXIV2+9WCR/90W2EJAVvH2Ah3zp?=
 =?us-ascii?Q?6teTkeokQhVhN3oMgm4PBl2AfY+yemIhqFnzz9eBJ+HRCAc+7RMkHql0FxhN?=
 =?us-ascii?Q?FLU/8TtlKC6uOS8u/mp+bJ14k94riXu9dQXhb6dcVgBucDheTlZ65259ZmFG?=
 =?us-ascii?Q?Wthj+MUSg5F6ocLuEV0Jq3xpLohsjyeChdHZ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PS1PPF63C81D79D.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?as4QHRWrt2IuKy5JXbdTEbpw8+H1UdLsiOjCGq3YGAQwfjw1sw59w9AfGVHp?=
 =?us-ascii?Q?7etpevuXmBUOOK1jWgh/u/l75ERD/Ngucj6rKrEiCNxSJXtkCnIDT+TYw2t9?=
 =?us-ascii?Q?Q4MIMNN0G2bUUY2uFYmWF0VvrVQRujnX/pUVAtDZdb+ZW+7ZgYlYc/tVejhX?=
 =?us-ascii?Q?vGVTBD4pPv01pQQiiAZwh+l2gZOp7CC78/NgrZk+OgW5seNfiP7hPOmE6nGH?=
 =?us-ascii?Q?yfiVd/ftZBnO5QsfDRYpkZ3+PVwOhuUhcMQkcYq+TiI5svgbOMiK/b9o8KAa?=
 =?us-ascii?Q?sf7mJrWWC03hmft7+4phRpCFaoDcnMUa76ooqH1G+pWs0pu1wEpiVySBXJ4+?=
 =?us-ascii?Q?GBuZLO3AJj2rJoFNgHG7bbjgqsh6gJYV96+1KojfwOl+pOusv+HmsU+H4adl?=
 =?us-ascii?Q?fEPdn9zv+VqwWI3aBVZnh/cRJfHZLQjriEXB+ZkRi5d0ZN5zy1SmBnZm6HZK?=
 =?us-ascii?Q?r3s6qXI/Vr5Kj0WxRGf4PEA/MVCTj3SMEupxEgetyaLWP2J5HURVDe5RasXv?=
 =?us-ascii?Q?fK5d0IUFxW4+wyXCiZl/EU+7tkWfr16X9OioxHZ6KcxUcjT4rHWCG1CYp2gS?=
 =?us-ascii?Q?FHLTp0YFjxkSN9nOFn/hRLdVm4Ojq6tRNgSgTRtCbBZhY1seFK+dM6Jvxrjc?=
 =?us-ascii?Q?3b5RI1ESARamTsPuvEyBBvrNfT4/gki1vei6smTu/R+/+oFhd8WeFMw77/hE?=
 =?us-ascii?Q?6pIA/34QKsKpo8jcaiQoFEcEDdq7qwNKgUUHo7kEF2nURMubMqb4HmZdaqno?=
 =?us-ascii?Q?xWKZWV3pBTRL7r6vCGTMK/QBu/MLDKscWtWx4oBzEmPUthtZWbj/1jlSthjP?=
 =?us-ascii?Q?IWNe9lq4HE9QEkFD8vJsQStF5DQhoj5QDlEZPjAlknUljmL9l5ANJBDblNk3?=
 =?us-ascii?Q?28MS9yXOpYJiLPlt0MLAjT5N5cN59CiPuIh4gxeBYp02qX7sS+GteGjmemeZ?=
 =?us-ascii?Q?YvkeA+0HQbE4Fct/pp8PU7VDRJFqXo7mkQjL8dGtMibmyxWmlHYCDEnd1LLX?=
 =?us-ascii?Q?B5wr8WvDjtIP1ZfaQ3CZnAFTE8jLtgcF5rhgI1YwmuEx7hfVdrF+H3FlYo09?=
 =?us-ascii?Q?QtNpRDTyugyL89Tk08xFySz0+Dlo075zwSqMcze3l9adXSmzDUtYhr0VJbtA?=
 =?us-ascii?Q?msERTLRZQYbhmD9prk8q5u6b86VUqj065FiAIpgdQ8vaCn78PhZVBNEKwJSD?=
 =?us-ascii?Q?U7Ig2pFz9qma8QQnC4cg5KpmS+rVxlFohc9TAXQ3v1T35yMKnVPwNTRb3y/z?=
 =?us-ascii?Q?5EhkestWtydwocFI7tyVe5lLtQi4E+w+kT5QKuvg/MkcpGJRCumlGaWDF3xm?=
 =?us-ascii?Q?LrIL5+NNBLxDZVyYdZzlq4jxv529QZqITdGTW7s9Ykx7POthreBR81yszB+c?=
 =?us-ascii?Q?B1WWLtbFyTW4/OqGDmPAT7WP2uljMDTkuge2wK3+SIR22/ZBNDut8Eh9LLA2?=
 =?us-ascii?Q?5a62q9+gYkPkdhYAqeEcoAEbnftfZWmXqLvechLDXp+WyWTE7EBobw7z34Ik?=
 =?us-ascii?Q?F3ezGkTvOACXHpJ/O7z2UcWRwZK1+cGtO94y9D7hVPtpPiYvSheGnF300Azd?=
 =?us-ascii?Q?Pg2PRDdvA4JnYQClNARTq+UqqJXF26qSq/fmbVHY?=
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
X-MS-Exchange-CrossTenant-AuthSource: PS1PPF63C81D79D.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf8429b2-eef9-4bad-8d0b-08ddfe3a658e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2025 02:54:52.1812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PIlm2pzeFMSqzKM+2fhyd4+96RQ1o6KMtoh1Rbe+M7Ubh25saAglt74NmIAV+fjIlPwxgaFHtPitm8E0XfKXs2fuW9/j+o+kRdMo2IqYu7M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB6221

> Subject: Re: [PATCH v2 2/2] usb: ehci: Add Aspeed AST2700 support
>=20
> On Fri, Sep 26, 2025 at 10:33:08AM +0800, Ryan Chen wrote:
> > Unlike earlier Aspeed SoCs (AST2400/2500/2600) which are limited to
> > 32-bit DMA addressing, the EHCI controller in AST2700 supports 64-bit
> > DMA. Update the EHCI platform driver to make use of this capability by
> > selecting a 64-bit DMA mask when the "aspeed,ast2700-ehci" compatible
> > is present in device tree.
> >
> > Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> > ---
> >  drivers/usb/host/ehci-platform.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/usb/host/ehci-platform.c
> > b/drivers/usb/host/ehci-platform.c
> > index 6aab45c8525c..18e231d345d0 100644
> > --- a/drivers/usb/host/ehci-platform.c
> > +++ b/drivers/usb/host/ehci-platform.c
> > @@ -27,6 +27,7 @@
> >  #include <linux/io.h>
> >  #include <linux/module.h>
> >  #include <linux/of.h>
> > +#include <linux/of_device.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/reset.h>
> >  #include <linux/sys_soc.h>
> > @@ -239,6 +240,7 @@ static int ehci_platform_probe(struct
> platform_device *dev)
> >  	struct usb_hcd *hcd;
> >  	struct resource *res_mem;
> >  	struct usb_ehci_pdata *pdata =3D dev_get_platdata(&dev->dev);
> > +	const struct of_device_id *match;
> >  	struct ehci_platform_priv *priv;
> >  	struct ehci_hcd *ehci;
> >  	int err, irq, clk =3D 0;
> > @@ -253,6 +255,10 @@ static int ehci_platform_probe(struct
> platform_device *dev)
> >  	if (!pdata)
> >  		pdata =3D &ehci_platform_defaults;
> >
> > +	match =3D of_match_device(dev->dev.driver->of_match_table, &dev->dev)=
;
> > +	if (match && match->data)
> > +		pdata->dma_mask_64 =3D 1;
>=20
> You must not do this, since pdata may be pointing to the static
> ehci_platform_defaults structure.  Instead, set a local variable to the v=
alue of
> pdata->dma_mask_64, and if match->data is set then update the local
> variable.
>=20
> > +
> >  	err =3D dma_coerce_mask_and_coherent(&dev->dev,
> >  		pdata->dma_mask_64 ? DMA_BIT_MASK(64) : DMA_BIT_MASK(32));
>=20
> Then use the local variable here to select which DMA mask is used.
>=20
> Alan Stern
Thanks, I will modify by following.

if (!pdata)
    pdata =3D &ehci_platform_defaults;

match =3D of_match_device(dev->dev.driver->of_match_table, &dev->dev);

bool dma_mask_64 =3D pdata->dma_mask_64;
if (match && match->data)
    dma_mask_64 =3D true;

err =3D dma_coerce_mask_and_coherent(&dev->dev,
    dma_mask_64 ? DMA_BIT_MASK(64) : DMA_BIT_MASK(32));
if (err) {
    dev_err(&dev->dev, "Error: DMA mask configuration failed\n");
    return err;
}

