Return-Path: <linux-kernel+bounces-821938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C99B82A75
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 04:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9044C7AF0CD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 02:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6736523C38C;
	Thu, 18 Sep 2025 02:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="VCYz8ol+"
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022084.outbound.protection.outlook.com [52.101.126.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01ACA1C2DB2;
	Thu, 18 Sep 2025 02:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758162462; cv=fail; b=hJcY161TRwbXaOsWI6dQpofHESD4dOBXlE7qm+zz8KhA2YFf+DF2siMisVuUR/Ua5emFaZYpISxilZ/MrTTUwDnT3ssSxwRcQeQR6lgSYb5gclYefQq/jKOmR5thVqlPAj18mNBsFqk8MOP23vDyHm49RojLvCq6VccYqw6lJdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758162462; c=relaxed/simple;
	bh=HvFWgMuzsMWlPTZ2Cxi67nVIBeoFJpdjdRtaebFu48A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=et+tn+AyCRWaNN7ZpkrYO0Lu8jNdhYK4l4JvVQOwOSSPFJ67k/ZZT+gbpjD1gr+8MhM4YMFdkOSDLLYoH7M/BQ/vX9bvdIJal9DLP1JaNfF5+8SsE1Xydw2FBJ/bADNQLC6TWS8PFTNnmevzRRB/3sqiCbjdek8lOkbdvHNEO1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=VCYz8ol+; arc=fail smtp.client-ip=52.101.126.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qtr2hhwrJp5zyQvmyrjDMWHWj5MPZs5T7IWrl+KIZJDKQXk/25x2gqY/Vtr7HhIhu+WrQjmniV1DCP4F/59BWknqIfMuVROo6c7SFKoc+4v3BtpSXmKGz6gUyVqV/yhQrcvGcNuABps4O9ju5T5bg33gsQ3c5tLDwfJGezwRJQjfRMDgZqi82qrKd4aLZ01pjHGXHfW67JE18d6iU5pr3Q0LjJskm2TqAXXDmCLCfv5lwOQpCDnCJv5RBSPJ1nWS/8aL9w2ZYsqm3jVywUiVRrbyrE+NH8TXlabAixz65dUfnaz6boxbxBCjbKgapunOS0SGBKYGjKQFxqZasixoNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gq7rDFGxLmpB+BzqzO59YZb3qZyFpYjyjra9WJPtShw=;
 b=RMquQKKMdX1AR6SqRQ/4aAGXokXnXcQL/9Jc+6ZIYBL//F/syrCdkswiuU/dHJaAmWONQgPoH3LqFKdJ4bDaIrY4+WgYUkd9TZzi8gQ6s9S8l6fvmGkKGDN1PUytwt/gxYj4EwUuZ7cGPBY6Xjoo/2mMAEJbBhqTr1gJ7+oUxPDcpsU8CrfvoXwXZlUu4nf5mO1yxUcmHcFHrj0Eshw4flhPjWmvnwxZ/UkhzosrbWeFrfAPsD17hbPRu7T47MDKySVge/W4neueo2JaNUrCSj5/o9drZGS3QIv8gUqPRQnZ/BRSRnS+Z9M3D66bHNkRPttx2WLhOUCDnZpbjJfrng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gq7rDFGxLmpB+BzqzO59YZb3qZyFpYjyjra9WJPtShw=;
 b=VCYz8ol+cVVpXToxB/JC1uUBy4X2uYSPrTATXCBTQjcPbXhDOH0Ga1PTIR6oFzJeyNSnzGWUla6rq8vcmeNL3EO/jwDEB0iNZ6uB2mHNVbu7BBWvAgI3G2IMyJ0qGxJ8iZuy6GOUvfWSbXUdmjphnjmHYUd8ekcUF5lVs23a1oCmXxw0fwWbkSeq8SfDvuQi4xJnH9mBLPdydDvS330R8md+rZuJLCr3jvgwwerECV/2q56fdarONWW2FmwRXGIYh+scP+DGyzVVaWSOxTAhmTCYQ6mtjUxUsGResaY/YB3Z6x+qj1aAOvko190pVdM3giRJ3XFD0TeUM7qmmAFHXQ==
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com (2603:1096:604:2b1::11)
 by SEYPR06MB8092.apcprd06.prod.outlook.com (2603:1096:101:2d8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 02:27:36 +0000
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11]) by OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11%6]) with mapi id 15.20.9115.018; Thu, 18 Sep 2025
 02:27:36 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Alan Stern <stern@rowland.harvard.edu>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/4] usb: uhci: Add reset control support
Thread-Topic: [PATCH v2 2/4] usb: uhci: Add reset control support
Thread-Index: AQHcJ3mCyN7fGYZaMkagwapS79FKfbSXaJAAgADPhIA=
Date: Thu, 18 Sep 2025 02:27:36 +0000
Message-ID:
 <OS8PR06MB75411EC83EB88F35A7EFCD96F216A@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20250917021926.3692137-1-ryan_chen@aspeedtech.com>
 <20250917021926.3692137-3-ryan_chen@aspeedtech.com>
 <291b2bc2-6a61-44e9-91cb-56044c4277e6@rowland.harvard.edu>
In-Reply-To: <291b2bc2-6a61-44e9-91cb-56044c4277e6@rowland.harvard.edu>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS8PR06MB7541:EE_|SEYPR06MB8092:EE_
x-ms-office365-filtering-correlation-id: 5255c0c0-41dc-43b9-8747-08ddf65aee66
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?k+a6NzwCd8IStuh5bZMGN34FiBGoZ1sgiqO0PZUlDWqsHePcTChTMA+MttW2?=
 =?us-ascii?Q?Jagqlo+WXBFT91t7oiJ+lTdvD+vswjoAz3fIrBcY7fK0kF6x9cUh75Upk3R+?=
 =?us-ascii?Q?F1i+s0iv3hev1jQto2tdiKEZMcrldO0cxGeXED4u0LERPmpXhnbl8XUOUsJl?=
 =?us-ascii?Q?IRy29tczCPRa+D6LPIyMaY/mrnXOPBwiKpyvK0yaJV//bvS/YI/lke/0HQTq?=
 =?us-ascii?Q?OSDiC/FLM78JyOY/E7F0EA4uoIE1NS4ot1wZeya2Vf05mjN1AtKq1evjrJ9h?=
 =?us-ascii?Q?zsrxxeaQW6XYbzS3+rQpeIKqA9RAn2kZepnMbU/mmvuqSQgK+Qnztvj9ihUN?=
 =?us-ascii?Q?oNoicug4eI9F+/YlNUpf4prqiU4cWYckWA4faiqtnp/2UtaJyQeThImmjKaR?=
 =?us-ascii?Q?3Lbw7CnPyPZEWad9vFU4IzcvjmS99bRjmxXdh+8QdOn3s9h43ThgCyoGVg1J?=
 =?us-ascii?Q?+vp4jFIeUc04W+wyZyTbX4I/oo2KFOecDgMA1we4bGeYTH10vk4oNVb43n8+?=
 =?us-ascii?Q?3CG6gtt/G3J/oovYDc4ltE3UBtcmmA+ZKpZCJRL1xUgKuQlJ+vWhbjRrGUk7?=
 =?us-ascii?Q?GRrD1lIeV0443DCjrDLGktVFInmy8KWCbFi0Lu99TRUNqCuZrw7Wqq4Cmqpa?=
 =?us-ascii?Q?c/VnLQF6lCXMpnWhA1Qxmc8iGqv/Fa7D1djMmIDLU8D8e1P9vQvCHuoQ5IgH?=
 =?us-ascii?Q?Fz0bMrsne8mYO94VPoNPrUhi6+I7+WN5fmXO7p9wb+IrPEzrGeZysYhseF0w?=
 =?us-ascii?Q?OvxHcoKAVELpm31ZvzErYFInAWTUwoG3pjwRhBnQLxHILYTczj0nI3Wm02fM?=
 =?us-ascii?Q?aaqWjpvd+KQmuev+FrY/n9ip2KVCVxKW9RMY7riR7Epa+YBqVhBjYmz3Vjul?=
 =?us-ascii?Q?ctYdPnkUmoYxfWU4MLNOjKAP+lnXHtbgkgLFg6MSiSatWL5U3rZ6c5IIlYQ0?=
 =?us-ascii?Q?uUIvIG3/JEGSatIeQlGC7kICeuc0ikWmVusVggecpRqtYQInS6E22CvMq/JC?=
 =?us-ascii?Q?GRbMpb0T9efYgoJO6K1zTBm0uVdWExgCQUSZ0PR81kwrasYslKC0jQXb7LG/?=
 =?us-ascii?Q?1S5CQJJzAqKVZkZr+HWH0jzd3wt5J93M6WFCvi0Cpu5NtC7L8NKpIefnsmW7?=
 =?us-ascii?Q?YgnFa4XRUGNXChd2Kh7PG4Y7dw3/kQZyevWpo8wPTmz9o6PQ8qnw4jqOENNj?=
 =?us-ascii?Q?jzjyifXyUSBByPSPIPa/giKQykv9cAoCt7Z3pwEwngxqBJ3O/B/R4nHCDV/G?=
 =?us-ascii?Q?NnEJRu/souxUy8yeSjyNQAnL2Ywa7UZEEVfOV8ng9/AIDz3mcHN0k3DUrnUj?=
 =?us-ascii?Q?0O4uHt0A2j0debbiKonTDJjxFUgU2HBcQCU+kbOLgPUOb7OicvYwVOCVqIVs?=
 =?us-ascii?Q?yHgLyhzmIRKUcii/S6jQuX/V58Xq+C8HvYzSodUwscU9We5iWfzXdQ7OJXmV?=
 =?us-ascii?Q?3yXom3nYLBkrokpsDli1HRnaZC0+VNSmC3chPykJy0cU4I8ayenfQQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7541.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Qnr3JlIQfJnczRfH/sYTPKT6Uw2VQIkSm6oubiCHQQBOVNP0z8yQUxjqpvz2?=
 =?us-ascii?Q?nL1s90GKmyw21XJBVGnxL7I5bylz2G4c0GeeSw8xgUwA4u/RSe1Rzu6eiNqM?=
 =?us-ascii?Q?S+vGnqDH+E3JXGmTToVMO9XZQ86GNtm2rn3Q9SXyGuajEc1qLcCWFEgVJrjL?=
 =?us-ascii?Q?UVxfX7P27/I+Sduv+SY/iQjoppShn13O6QBlLmBOAEQpSbJfz2FWGIsr4t+i?=
 =?us-ascii?Q?Ji6Soqd7i+aM8vDcQqyciyaalCkS5aeANMZ1XcwoPr3GWrz2UWyXCoYsqkfa?=
 =?us-ascii?Q?2dPfyGvf7wL3oJgul9++lt8etClqSJ3BZdjAQ9Fd4Yzc+rsVTIkad9GxJJfK?=
 =?us-ascii?Q?KOAnNiGl/jAdX1CQbhkAsmpDSX7g+5T88cIFw8TdcddXfHD4oU8qu/mnB9XO?=
 =?us-ascii?Q?led/SNIgqQh1q8KUbDqYV/8mQwZblI1VqyMrI90cvhlZa5LJtadP+PiJLdKl?=
 =?us-ascii?Q?mRYRNNHkNyR9IggefVdETkv/aJGegYImoydu6xNqTHjeNTMA4+uTtgy0NQgu?=
 =?us-ascii?Q?nv+/mBMBQLHlONOJ5jOgFwVAgdqQFanEvLKQOpho0MGn1B+OrOw5hEOCGCxn?=
 =?us-ascii?Q?B+dNupeIVn6CLWmOuhNkn9+3E8TC28PsLuBCe/d4LGIJ0nHQRCtN6Du2Yhmt?=
 =?us-ascii?Q?cRu6YyzwRfCQ9r4aB1joQWxUhuwn4jscXsPQMmEBnDQnxCTKJLCQs58iXZaR?=
 =?us-ascii?Q?ZWaKCu7chiHFbx0DcWU5hp7juaQzS8P+FTDYLlhBybEDdXEoYy/GHLX5JtTc?=
 =?us-ascii?Q?23M29sUIgjYq1EF7O3Fzhc1hiL2Ei2vPzkyjfJgKUhiRj/HS+UHGerjikpZw?=
 =?us-ascii?Q?UuwdVKB8Z7fxxd+jy4P9VnYC4SOm4qxjXY4yt1jp4a1sTizjuaeMAZMYkQzZ?=
 =?us-ascii?Q?sygP3V4bxOuqLbsznGiPwo62eDEFPT6xAvEGVkGgyeSuQ/Tx6/i001wFe5+u?=
 =?us-ascii?Q?rg7TxZCnYczUTGHXhvmyzSxw5Tf+AhzwOJaRKUsw7hvDzh69PFFInHPFQa89?=
 =?us-ascii?Q?8ZSwG7nxXOha1Uxg3tZvSLJ089blFebqbI6rfqlC/JuxDXH3DHtDiOoB+EJX?=
 =?us-ascii?Q?Mx4UKgRUfhpD06/vAnOGs9qj5SchOsg2lyuaU0Ur3MPUmX0qdedzsHDGFzxe?=
 =?us-ascii?Q?0VY/rkWIb0rZAfF3m9af7U2N99qCiufKKyI9wYCyVbiRJL6DTx5eNGsJcm/0?=
 =?us-ascii?Q?XHcO816YMXrGUNqBZ8S2BVV7lWFc3eoauJbTz6TygnoxP7/rt7bMVzh/WAGo?=
 =?us-ascii?Q?BfoGvTGoPm+i+t4KQgTHA91m7LQbZis5Xr2cSlGiLQGcVen3wYIFFaZA+1dC?=
 =?us-ascii?Q?yJ2ECeSfxt6L4vTA2Jigp/Sc3ykSNUwhbqaRn7EKhi69f4Sd3p9+FPGFHRGz?=
 =?us-ascii?Q?7RUO27Uwlg064BvBpWXyJeW+erjWHmOUIuXq+tlCcfEA+1l1ki9o0TMvSUq9?=
 =?us-ascii?Q?XxMkob4k9wcWm5BCWo2q5/WvWOfvWl7T3VkZBG2HyTw5eWmbOzYsQwCjj/jG?=
 =?us-ascii?Q?lRCoBqCVWU0mCcibK3yJ3fxU3eucV21C4T5TCbNKvhfxf7dAn/aSKtL3B8tb?=
 =?us-ascii?Q?OX773N0Xdch1D8FP3j3M1goZUnTJu/nJUB7WLnpI?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5255c0c0-41dc-43b9-8747-08ddf65aee66
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2025 02:27:36.3312
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vIs5SfnWAgKlBCIhhLal2ajcnfQzT/k96nI4s6QlvmwjNjn4Depk/U/q05Gkk85SLCSh5NAHu6g0Ip1H/o3mAIAt2XyqxVsF6GnfKnxoOsE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB8092

> Subject: Re: [PATCH v2 2/4] usb: uhci: Add reset control support
>=20
> On Wed, Sep 17, 2025 at 10:19:24AM +0800, Ryan Chen wrote:
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
> >  drivers/usb/host/uhci-platform.c | 17 +++++++++++++++--
> >  2 files changed, 16 insertions(+), 2 deletions(-)
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
>=20
> This new field is used only in uhci_hcd_platform_probe().  Therefore it d=
oes
> not need to be stored in the uhci_hcd structure; it can simply be a local
> variable.
>=20
> Alan Stern

Sorry, I think I miss add reset_control_assert in uhci_hcd_platform_remove =
function.
So, It is needed in uhci_hcd structure, I will submit in next.
Thanks your review.
>=20
> >
> >  	/* Reset host controller */
> >  	void	(*reset_hc) (struct uhci_hcd *uhci);
> > diff --git a/drivers/usb/host/uhci-platform.c
> > b/drivers/usb/host/uhci-platform.c
> > index 62318291f566..1c1715bddc27 100644
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
> >  err_clk:
> >  	clk_disable_unprepare(uhci->clk);
> >  err_rmr:
> > --
> > 2.34.1
> >

