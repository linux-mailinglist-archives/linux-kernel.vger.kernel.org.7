Return-Path: <linux-kernel+bounces-817963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C28ADB58A03
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 02:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75C893AD9B0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 00:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FAD1C8621;
	Tue, 16 Sep 2025 00:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="lXPrNVdu"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2125.outbound.protection.outlook.com [40.107.117.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0143A1D2;
	Tue, 16 Sep 2025 00:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757983689; cv=fail; b=j6oQZknmj++FIZcpxDS+4ilw55OVBVnKEwdMQPKzob3ESDt8uUeIcQKTM3PbDNowchIpt/3UUiuSgQQOBYjDHMwxxzIuDSLRSHK5VyOOCLo4c8I99h4Ejf55mpORrteB0y8aIx3Lpc1h9IlgMmSKeeixDVH8yDMf2RgB4BeHkRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757983689; c=relaxed/simple;
	bh=ZwHJBYZz5iKMb4RlZUYPQBBNZnaLyo/Bf0iPv3yiZxw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L4cOxJEJ3BHkm9PedZf56IHXd+o1vBy4OytpzkbY68o907tgSm++qIDcaCiIoOmDxhauIM3Qg5Vo4QVdHbgfZyqKXuwxd2muNStiyXgRFNF0hxOIl1OiVGVKxnVWAAxt3V2TQAEGhRw9bX0jXMNjIXL+MkASWPvxOA+JEnTrC2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=lXPrNVdu; arc=fail smtp.client-ip=40.107.117.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HsDa3DhRyyKuQvThJxQVE8HaKQ/2rb1qWDuHCnPG9TI7IJGncvGZbmFTq7B55GFq8BKkAzZc8QFoImbdBtn+wGRanILy+BhutqMZqtlno+vwQRW5LOFrq5rVOE9DfXLUestB7AhbCfK9k95toh7w2Q8sej0KxTeeJh7otIZz5NaAN0zS0yl1ovQ/zczFHoQqmkiuzF9diO/ObDmmb3DJcJW9QdeqUNaW21mLznuWYrRIQL+9KcIx7H+79C8/iQYd2Qqp95LSHSqipwapUH2oaAwxzjSRMOamGN4y4+NUah6Q59+lE9KcZpnFoCs9+dxRwZjZT98jOfizymvcTi8b2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3pTSd1DVJctFQ0D5zpJi0dbq1Qy/abJ/vXQKSZzdiZM=;
 b=CZ/+HFC6hKhD4jYOrGjM68po9qWZG+tZ8InIIGLzhQQsFced5gJ/xYmz24OKZZLweVA9MfFSa9jrTpKOEIpwiXrUZRsmo6KoBQ+Gw1+PPDf6vysE3Quzn+mJBDU9ACgtYApYC0eFhNwXVrbrfy1x9WwHCu4SsncojcA9nkTIHGkfynJz70cq2J2AOBzOmdLr24ndlbLB3k++WfxGEDe7RTy5iaOc0ZsZtGKWC5xMR2b0NlBojQx/PifPe4S8EfgVpmQg0t4cDJUngQonH62Woi2Ul3EZPUKPZ5vf9sHYqX7IEhEShayzJLOaR4VxQcS5Unu3pCAfy4EgZQWQ0wypWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3pTSd1DVJctFQ0D5zpJi0dbq1Qy/abJ/vXQKSZzdiZM=;
 b=lXPrNVdus19sI9LrMuZo+9+mVsBZM5qxAOO8spa79DLaO6+sI6WoTWaTkgFY2/GJLQJkjVh87g445m3///EoQ+gRV85WbOe0X+LFfgsk1kycIRdGh/GqZaQbzC1bZXUEpnDaIp0H5yb0HZuMhYm4qDAOpdCi3rZu9UyXODMrrycLI6mwAsgr8la3lN49ZgPOBRP5mpEsq2D3ZTxXQgEejh6bVCXGf3XeOVeIqiPxtN3pkd9JmahjwUPgUmjm4SfX4PXIkHRQ2IdC1AkO1xjYZJ7BgeOZOAvA5h5Tm9oZXBXVW6Mfsqa8LUQUB4ihyCblrEYe/oW9ppBrgkpJDajzhw==
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com (2603:1096:604:2b1::11)
 by KL1PR0601MB5447.apcprd06.prod.outlook.com (2603:1096:820:c4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 00:48:03 +0000
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11]) by OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11%6]) with mapi id 15.20.9115.018; Tue, 16 Sep 2025
 00:48:02 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Alan Stern <stern@rowland.harvard.edu>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/4] usb: uhci: Add reset control support
Thread-Topic: [PATCH 2/4] usb: uhci: Add reset control support
Thread-Index: AQHcJhPhbbHslUEF6kON960PS3sCXbSUSFmAgACyfHA=
Date: Tue, 16 Sep 2025 00:48:02 +0000
Message-ID:
 <OS8PR06MB7541673C83BA9B189F04538AF214A@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20250915073926.3057368-1-ryan_chen@aspeedtech.com>
 <20250915073926.3057368-3-ryan_chen@aspeedtech.com>
 <3cf94df2-48e1-4cbe-8f0a-84f05cb9760d@rowland.harvard.edu>
In-Reply-To: <3cf94df2-48e1-4cbe-8f0a-84f05cb9760d@rowland.harvard.edu>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS8PR06MB7541:EE_|KL1PR0601MB5447:EE_
x-ms-office365-filtering-correlation-id: facea6f3-1ac4-441e-5252-08ddf4bab0b7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?xLiZ4D0DUEQWZOcTSv+gTqYAOZQ410NCTTRFP4Tv1plZejPu1J7WFULm4O6C?=
 =?us-ascii?Q?eE9alfRpYKlF4eZ1uU7b9yAGzOP33P24yiuCYKk1NkZsrRDBrvg48oCwA7Km?=
 =?us-ascii?Q?rfe/mPiXVc1pFPc8l0o6qVRQT/oP0Sp4p/yiwgHqGUaJSKz4DowIPcQXLZRF?=
 =?us-ascii?Q?HKZAM/MLo8+DoZ8saOicBp2Sh4FfAbRZs/NkwhCCGbXNy4F1fKrfM17Uzuev?=
 =?us-ascii?Q?pFdy6Y4hhOGgLwQgwheGg4Sgz90VHLnEWxTVu9RvZUeVEc1+l2rwgNFhaDmY?=
 =?us-ascii?Q?ngSd5n7I7+7+utScNCzVzBbGOsVCjEd+xxTzxtZbtYKvtN4tIlwxOsP8x2cF?=
 =?us-ascii?Q?4gPz5MUaujSSqmqDjMJDoq2iifSJEZAwM9Jjf2V2Syq6Jf0cHiFmNCPSL2lH?=
 =?us-ascii?Q?p5qOO/l2sB+19doSb8ZNdeFDywgGEhEvtiC9gXfB5akofYqvd70zfB+XkpTW?=
 =?us-ascii?Q?N3O83dXe5Umh9MW1Qv4xyl4mp/l1tYJMw0YejFHjgRXcXco6+cLKarFJQTvK?=
 =?us-ascii?Q?cskdnfcIClwN6KCkYCBOVjMFhtqyVaWwLu2dwhw6dmguKtItveIi5K00Kc3K?=
 =?us-ascii?Q?IO9PReV7M/LpvgkF0fZkY17EIONLv3VczxLVsKAV/+7DFdPk/b8vCIyR7Cyy?=
 =?us-ascii?Q?NS5m42My3qk9HvMWM0Zn44oBjreHrcEkGJRM03uGMEMC5/elErAMlxpckMzT?=
 =?us-ascii?Q?QVFDyBGqeNB87Yl7JV/2uScw4iCoJwpeS7hND2EJooB696BlZS4uzETZ9b2N?=
 =?us-ascii?Q?couMUET5Rdg/r2nWYVkGEiOXsmSvQPJXc3TAJwkAULjGozfR2TB/0DvMVeGn?=
 =?us-ascii?Q?v4kXdgEKdmU2hrjqxmZf/X8yc08SB2x4rD6KrNWbo7Odw4rD0GukAd5EwrqS?=
 =?us-ascii?Q?GodbpVIFj1Y72W6laN7syYOmyFRNFv3eEDJJtojfzeVq6z7BaUBsdsqhTplH?=
 =?us-ascii?Q?RbVUtkU5I5wOTQRlVsboIcTWmeuEnJ4Ripqysj9hQcf+WTyBncWKO/X+BymE?=
 =?us-ascii?Q?HMZ+37UdcosNXBchAhqXD4BdxzWYpoTSAeBw76DcjsxaLj8zy7EDjendanFk?=
 =?us-ascii?Q?DoOdQrMqgIWRMiYoSn6phdQYjXljt1ERoYWxVVAJPZtiO5o4L2mKk60Q4Avs?=
 =?us-ascii?Q?3XkE8qAFvrO1R/VdxopO1IzxhrhcBIK7Uf3vXF4N+7x6KbhCmUIjPDlB7NMu?=
 =?us-ascii?Q?7DDP+CJ3xvuGYSVW9h3UmKFKYSm4jCcX/wgfm8NYEeyatYrXDIxzjccBeAhU?=
 =?us-ascii?Q?97Z9m9+eAMz42sbMnakIdiJ029NFuk01unTOYSmu+zQelg7r5BIVPRCPoZFt?=
 =?us-ascii?Q?61v67MJnKPwTD+bdmIS/bWhs52RJYPRw2YeXg6iuj04aH64Rld0D835yi/9H?=
 =?us-ascii?Q?Zvr3Q0fj2fm59zpX+30w7z4eHcZT7KmpKvYrAaQBuQieAEFHw/dfiOBjF24R?=
 =?us-ascii?Q?z9viRtwjOBR2081hD88hT32hcdRu6AWwMncQFphckcR6P7NY5QJaJQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7541.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?tT1d5JWBFqaYqe7AZk6Um0/DpxihEOS+LEd6iHOTdQ5LuV7TsnYTZrXFhqQ1?=
 =?us-ascii?Q?I2LjNsc+uTALHqpDBM5GZOPQOHm4gaoi6Hb5Fvd/ZjmGPGLCuObb7CFYqH4E?=
 =?us-ascii?Q?TLs2y6Qj/IA0+NrA3GCIFa0iyz92a1jBR96TkHBAReY3ijULgsylWK274X7m?=
 =?us-ascii?Q?chQdFGmo/NVz6bOnu7Mx2Ft8uV97Wy0xMfjPCJ40nFcg2BJ6/laZh8bGQODe?=
 =?us-ascii?Q?1vmDMbAaGU7KKFdGOE+neMxw0aKO0cxPV+/StTaj5bHIswEjQqHrgYhtCCUV?=
 =?us-ascii?Q?CwCnJaoQqwEwICMX9reslnyOo4rjcTDLUfgnbBtBHKpkfD7FJJPAlkpzukns?=
 =?us-ascii?Q?n5ky11AMYc6IK9LGxijxeCTp5E8ha0RxClhqPai2YwwA/WCz+xtsDpZpzETv?=
 =?us-ascii?Q?7NIpFQ9w+zFtL3JtxLS0G2LCRMusT0XMh/ww+jxUXBMbTlJ7pKMK6Y3lI1hq?=
 =?us-ascii?Q?utYDg7DdQ/h63XNXmWA/6qy7i4i8yymLUmXLBCVY3RHOArFOhtpozZrIvrf0?=
 =?us-ascii?Q?LKmSP2iHxCCAxGwYquvWjaSvryxh3TFlXRHojULK7KCqs3LzfWnsi7WnFKnC?=
 =?us-ascii?Q?65uZIyeZE/w9KTXHYWuO0z0ftW3oPBVJN6aVbjnmqIMM3b6PPkOyAyaa1djC?=
 =?us-ascii?Q?V4nEQQGMMBLgziX1GbgEaXz/1tKA/1tW/ZjOYiwyZNUfxpKDmO1lLKDhr8fO?=
 =?us-ascii?Q?T3JPH+BRSl9whEidQS+ByzdfywiR2DpvGltPxkziJGZAkEmJT1jd6hNOYs+o?=
 =?us-ascii?Q?/K6XxtdVtZSLZFoWJlYW6O+EZm0y5ApIsvwiJjMNVhjlEc3p2b9n6TSFSl3Z?=
 =?us-ascii?Q?dTlgiw5w971y9y3iwWA1CfzZYffqZFJDwn9ENFENg4GyGHtWry4v+QV4k0Wq?=
 =?us-ascii?Q?i4g3USK84cuWwHh72Uuop01POEMVsBlEQeJmmNvqsA4/Scii1igSXRhxlXcX?=
 =?us-ascii?Q?2iYFb3EeMCtgimhj2vWrpjyfBOmdLmQJXVlYZRvOkyPtsph8RsrYhjZBKIyq?=
 =?us-ascii?Q?1FG0lor4gAveuJdklY6LxT9WzBFKUQlQTcWNxQjDlOS7s6NZLoRdoWen2e8x?=
 =?us-ascii?Q?EXJKPFqNukT0A/FK8Ytey/Ow9yNOJzjp95LlZUsN7sUTSTu0J3Slg5uTC6B5?=
 =?us-ascii?Q?vPqfDonWIyhKsy9ubE2GoBhpebk5BIEVxqDNARz3KnMPS9WsFGsapjconySu?=
 =?us-ascii?Q?mi7k9j/4ETSm+EsFpEBUCgTdMZHtG3LZ07IIdV2gS2762M1f6DLzmwOw75b4?=
 =?us-ascii?Q?/EAsyVJtdv9ZXpSUBC9bMQfATXaAErSQGyRz2UJLkAIRnBXJKMFQEvT4Kbq6?=
 =?us-ascii?Q?NhXQUu3m3mV01RQvX1ntsbaI0ka7KjsxndnhYj/jhs+B0lGyScr1MJYREt9S?=
 =?us-ascii?Q?S2ayKa4YagXckJMAgOk0jR1AoZN037l63I3iDqRKQKdJnpwddy+t01/Nubrh?=
 =?us-ascii?Q?VK+d2tqiymLvxiV3gWbBqQLxQ9MFQ27/tP1zHyBEoT5fdpEBynbLIJal8gXs?=
 =?us-ascii?Q?WR+tJ2CxK4ZSHEXiJM2zeBOi0BB0l3sA3PAuh03lvsEkkJ6gkfkj6FVQPXKB?=
 =?us-ascii?Q?PXsGbDiP3+R+P6JwunMFiOt3aEJd11mk6xrNd+Eg?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: facea6f3-1ac4-441e-5252-08ddf4bab0b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2025 00:48:02.2040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zje7r+H/1aE6Zb5HtxSmXEFaS7f/zFeElffp76LdP0BnHI8E3AJRjnUT2JReh5FqNPEtJVzaQ7vRvok/sOkrXaVKOLSx+FRrporZsqT0OEE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB5447

> Subject: Re: [PATCH 2/4] usb: uhci: Add reset control support
>=20
> On Mon, Sep 15, 2025 at 03:39:24PM +0800, Ryan Chen wrote:
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
> >  drivers/usb/host/uhci-platform.c | 19 +++++++++++++++++--
> >  2 files changed, 18 insertions(+), 2 deletions(-)
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
> > index 62318291f566..010c458e7d8f 100644
> > --- a/drivers/usb/host/uhci-platform.c
> > +++ b/drivers/usb/host/uhci-platform.c
> > @@ -11,6 +11,7 @@
> >  #include <linux/of.h>
> >  #include <linux/device.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/reset.h>
> >
> >  static int uhci_platform_init(struct usb_hcd *hcd)  { @@ -132,19
> > +133,33 @@ static int uhci_hcd_platform_probe(struct platform_device
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
> >  err_clk:
> >  	clk_disable_unprepare(uhci->clk);
> > +
> > +err_reset:
> > +	if (!IS_ERR_OR_NULL(uhci->rsts))
> > +		reset_control_assert(uhci->rsts);
>=20
> This error handler was added in the wrong place.  It should come before
> err_clk, so that if an error occurs in platform_get_irq(), the clock will=
 be
> unprepared and disabled.

Thanks, will update in next version.

>=20
> Alan Stern
>=20
> > +
> >  err_rmr:
> >  	usb_put_hcd(hcd);
> >
> > --
> > 2.34.1

