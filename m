Return-Path: <linux-kernel+bounces-835777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EEF6BA808F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 07:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC863167A22
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 05:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA2029C343;
	Mon, 29 Sep 2025 05:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="oBcQ8Zml"
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022121.outbound.protection.outlook.com [52.101.126.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B832BB17;
	Mon, 29 Sep 2025 05:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759125381; cv=fail; b=Wsh8AJPjCd24ww7smdQN8mHmO2E/7R3vs8ByQR8Oo6Svmjc11/btWgPwiOv23dxfGLOVylqn9D2kUKBRlhpxY9hvvNohaRDUl2HN4MMeAH/JpbLrhRr37imhZlWPOqlXmIe5CE8fQlxj4PshcHekM1UVBrZfnSi68g/G/+mYmuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759125381; c=relaxed/simple;
	bh=ita1241nKupI4WHsyB5fQaSXjpzf6ZBUrujwbSb3SJ0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o0tNxmfvF5Hvox3SkPbbhqx+otIM3kJcxQ0Sv4IIlNAssCW4XxKp0pgQFmetKpFqnMf6Z4ShT5a5f77f/ozeAdybPT/UZnqQ0NgilMJIoBmDYKErk53qd1s9gK5CSkv1G+QKYEmDWDBXufSyDxh43HHZIg5zG4Rrs/xY1QnK3AQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=oBcQ8Zml; arc=fail smtp.client-ip=52.101.126.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W+gE15DUFd8TB3iYYq9jvhw819Ly1uMBnXQfSQZEYdeB9LGagtGf0DVV/KAExzt5G3MbQ0OoW8gxy9C1N6ZtnraQ4sBH9dKVbKHZbhQJxyEboDn3oY0iUuZ735y4ljfPGPQmGuH4GOLFfGMhB4EdwxXbgIporBoFk3sfXKiT/r2AC0SoKF478hvR29Fyp5qkszJddIrGor5KRmQ65gLOPat9057B8LbjYrIYkr9YXazpgzd8rHXOuzLp80UOqwkzkk0WsNEv7v3OJfXusqBlbtGZWUaJBOFZr8X7iJU02rkUOj62tItRMGbgS0dE7ibU8nDqBH4XbGqdichGEHGJIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dln8O8zDBcMTPEMIxWaGQgJ7rRN6Ju8wVJRjKgn3d9E=;
 b=NtZZ6PuTPC392HMv8ruPvMVDDg79DQh5rBEWH5gcaxOiwIB8prOJMTNwtb3k3d5uixcfrQqXfEST+6RXW+kDXqk0zyQjtFDA8fl9XVbpuTA5KVLvs9dFXGcQXJMVgXiVNZ+rL1aHm3YdbKtaL5xrMg/secIyC8SWyozuo6x/hUJ8H7b38JQuXAr96qSajyJZOZqWSELst3Apg3WnL3vhydZM14KVLc/NyFHviY7rG8saTVHvmfGAgpoVRE2EX3EtiV59DM6D2OsQDZfl2+y4KQM/C1fVc+psPPjZS3lsAXT0QqyI9Qy5PBppvrG7VwIj/a16hOhrkVf4dY1jbUyDeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dln8O8zDBcMTPEMIxWaGQgJ7rRN6Ju8wVJRjKgn3d9E=;
 b=oBcQ8ZmlxaUQubdxO/gPGftQgub0LAJsGTFTbw0d5w5oxz9t4RrYF3Ss9FlMBnDYFwPbZHXCWmj8Ypt+9frTZOi9V/fYlPKD0Kf9FQaaRjw34I8aj1fMYn1b5mtfufYHr5+IHGmQRbYQcmDnGs6a7I/N4T+Jbpx+IADWSrPepUz7tbexoo63xh9k39m8/KMYiuFsb/9YnaSSV0W+k8Qqjn5UMjXtE2ygGPuJdI8GtM+Dnx4wxWegbLtMRIdEOVKZjx5FTLa2WVodwhEs9LcL+ECjvB8yXqdpiURJEfp8+gMbgGAO4tY2yDxYq89MZ3lEE24znyAlt05YTr2VfpOAnw==
Received: from KUZSPRMB0005.apcprd06.prod.outlook.com (2603:1096:d10:2d::7) by
 SEZPR06MB7240.apcprd06.prod.outlook.com (2603:1096:101:22b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.16; Mon, 29 Sep
 2025 05:56:14 +0000
Received: from KUZSPRMB0005.apcprd06.prod.outlook.com
 ([fe80::5145:1a84:4b73:f8cc]) by KUZSPRMB0005.apcprd06.prod.outlook.com
 ([fe80::5145:1a84:4b73:f8cc%5]) with mapi id 15.20.9160.013; Mon, 29 Sep 2025
 05:56:13 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Alan Stern <stern@rowland.harvard.edu>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 2/2] usb: ehci: Add Aspeed AST2700 support
Thread-Topic: [PATCH v3 2/2] usb: ehci: Add Aspeed AST2700 support
Thread-Index: AQHcMCddF4ITLdJQAEi3Dh2gsBLdrbSouQGAgADw4EA=
Date: Mon, 29 Sep 2025 05:56:13 +0000
Message-ID:
 <KUZSPRMB0005CC6A87F6FFC5A08F12BFF21BA@KUZSPRMB0005.apcprd06.prod.outlook.com>
References: <20250928032407.27764-1-ryan_chen@aspeedtech.com>
 <20250928032407.27764-3-ryan_chen@aspeedtech.com>
 <0a12f3ac-2600-4ede-a738-f4ab43ad4bee@rowland.harvard.edu>
In-Reply-To: <0a12f3ac-2600-4ede-a738-f4ab43ad4bee@rowland.harvard.edu>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KUZSPRMB0005:EE_|SEZPR06MB7240:EE_
x-ms-office365-filtering-correlation-id: ac682733-9c90-415b-1b1f-08ddff1ce5db
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?RoardFcnCL03IIJYiOfxIoOJYHE7J9pdRFIqEbyau+mvD5MB38J+w5r9V3tU?=
 =?us-ascii?Q?IdUogAWff5WC+7jg0ko38UhLv3e5WtHHvnQhbHD8kd4lI7H+FdAnTs1meeuo?=
 =?us-ascii?Q?9ueHsDjSjCG502ra4djDe8sUGi/WlLk0Lt3ZXi/B5V3Ktv80bekgSFaDaFvb?=
 =?us-ascii?Q?eSJd2NHRrHzc3Z92A1+bGXsoP6EUVaLGV/1madPfKFwqcW2Q3LHEQOq6BGEO?=
 =?us-ascii?Q?o8U4gN27qJXl9+38wseBtstItaLvgSAX29myOur20W0edaXUXj7/54EwOIpM?=
 =?us-ascii?Q?YR7HRmV4AMVSkHZzrg+HAJVw66vED5ioqSSkQrYq69u+CsnBevuX41P4UGI3?=
 =?us-ascii?Q?5wm/fi2T4360PjPjEET1msoNcA1NfxnsmagxIdAV82LNqIhGNQgQ6CjhyQe/?=
 =?us-ascii?Q?N7Oxh5YDXBVnvlMVr3vW4QRDsBfQBvtwSqarL5H2wFjcoGRcGHe18KbULlgv?=
 =?us-ascii?Q?xX/QaDJn57ZYQ1nkkV26Fmrb+c0yIyVbrnQ052KIaznL//M4wrNtWk2fdZ34?=
 =?us-ascii?Q?+nNrNfl1iLUjamBGo/vM0f8KqTFigT8/4Y3gF4XDerizEHKFJSv7lWFVZozW?=
 =?us-ascii?Q?w69a/HTLjGBnhuwkoFkZXxnm0uIqsz8IyWhUGsMfDT0ekN/2f04RCGk1MhiQ?=
 =?us-ascii?Q?FMqFeIiA2En8M09J0ogri6HhsNfynt9sGdrFejQAjqBpXOP5ivap+SJNVWWH?=
 =?us-ascii?Q?/sJUQo0KJPa1pcY/OhJjyVHC5n8+TOSdGJa+DDaBz5HMZwgdbG3QDWLoQec+?=
 =?us-ascii?Q?cGIIgsbcBbrsVvGeWmyHYMRP4n8+tC+eJqzURQDfxZVAjX1bhXr1gf6EKz4h?=
 =?us-ascii?Q?70TbnJBxfppvmyb29nfGZmFU+pP7kZDm2+KB4LvNksqT0V0ADgwlcJrRQESj?=
 =?us-ascii?Q?TDjTH0x81JRjCMDbkt4izYgd6/muOzv9Gm0DZrT7eDycsfYd0Ct+WJXM3O/t?=
 =?us-ascii?Q?8QRZ+zN9UzXiOv81BLy6QdD7CuAe+ZTBO5UG5NmOtVKw+q7FzT44dV+hlmzp?=
 =?us-ascii?Q?St0cz5XwUIBJDDHTdRp4Hf17Bh99qj9UhGpCrXmMqHr0ocsNj51Nr9+4ijqO?=
 =?us-ascii?Q?e0ZVrdrx33qthHB36zmSSRfKTO/ORQc8DDRwLuDzWaOEc2psM1RMDloTUevP?=
 =?us-ascii?Q?cc9ekTUDorQkkA9c2Ne9tBfEXDXlsfNgKMy1jeLq9xDDb9h3x5MFGIdAO/TG?=
 =?us-ascii?Q?sfYlsqG7OooYLCP6iar77Rgz4rzgB+Ow06OlZc0/DrE+44crCEJ3jZM25OuM?=
 =?us-ascii?Q?VcWsPimEoiRZND7fZ2A+tLghQVdMxSN4he7xlSJ8QknhdjnVQqJabd+bcXTg?=
 =?us-ascii?Q?Trx+89JeeTX4i4PSKsNMdjYaMrlaN7K1Dzyl0YY5n5mQbouYI1UifXsGn77c?=
 =?us-ascii?Q?BwHho9N/ORZKBwlGMyUqxtYxeq60QpmzvBBp5834RxleTGaQWApGQ3uyIAOc?=
 =?us-ascii?Q?hF7SQT8rjk/0G5AjcUBPgS4mM/WY9SZ/50DrwL6LYGLuCyfbPW1EMX+dAe5s?=
 =?us-ascii?Q?JeDoPecVUmPMZrixXo5pDI7QjCEzVa8XWjuI?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KUZSPRMB0005.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?7mSIn79Bw2gHgw7dYvahx1KxXRd6eymqddGXu7KGL0YwhfAF7J94O7gCqVB1?=
 =?us-ascii?Q?PD+Prre5/tvByPd2MWykJrf22gMesuu43NDHccU8Ix+uOQC7T46aUoej1ObF?=
 =?us-ascii?Q?WJgeWZ5/WSiwq6tuOhwnDkLKZmBB2baYh2UrCc5FzFDTi+iVTUgvvSa3PwPL?=
 =?us-ascii?Q?d+etp/rztnRjlsS1sCsAWNU90YGePtvCBrsOaM3zwwf1plJz2qkpOdLdjGy+?=
 =?us-ascii?Q?uqK6piYHf+7rWPo4b2+9yi3hz3kATp3hwve7FiSivm2nASzHmaVe+AyYTBZk?=
 =?us-ascii?Q?vNyuZVT2mC9iTAl+1qlLEqZC3Iob5WTwvodsmyi/ISjBdUc0F1m9EaYjKeN3?=
 =?us-ascii?Q?vKUQtzpVQYrqDDLCBSxV53llMBR62AluWNkl8iWVhyucCr5MQxOFHIFahNCv?=
 =?us-ascii?Q?4u8Lz4g7Tj9HNFQesBCArTkijeqSZB5NsxotMxwPYdhvBbCFHTMviwgXODAO?=
 =?us-ascii?Q?My4rYQUv8CcwltKruvLj1/sXYLUuRXo5nkS0U3eyxiLgh6kf8YAzJktgJ/tN?=
 =?us-ascii?Q?OQ30SRej1s3vzxQ5FmKqnia0ukQ5LvI2JOgcV0BrW+utDHbNXuy5PaFamhbZ?=
 =?us-ascii?Q?Et3BbwUUdqI6sT6oGm8nYnfjte4J/vCRclSbTXaN17GQFXAUuLHzwa4MOYLO?=
 =?us-ascii?Q?/ueZljlwQF9IYe2fcoWrAcd/DoKaF7J3UvJ64D0uA4LmBeZ7Ws99Eh432/CN?=
 =?us-ascii?Q?+MNDGaEyec34rI+EuvgljvHZPbHi533i1kJpSj/+pwCxZEAg8FXs3Vqmp/yq?=
 =?us-ascii?Q?nkKNH201jU/4keGsPjXN2PubthgMGm5PFvrpoXSCyftK55EgGzLOpqM+UxGS?=
 =?us-ascii?Q?IZJ3NTdMVa5gdZ+i+5qhZH/BtNfKaj2QyhUYt1NFR35nA2owg2rEl3WQjVjw?=
 =?us-ascii?Q?2tGCBlhk8uOsS4ies7OqNi5d/8HYxZ8gylVbsI9uMM0z0XMe4AfDJmmzJyTX?=
 =?us-ascii?Q?W9RcrPuEXQOqzRIg2yfFzhb5kXh0hlMZPjUzcJnl7RnT8EoPElelFF2WdiQg?=
 =?us-ascii?Q?l88ZTCXa46Nq9kLQK5IJdxLqwiBv2Ll+FPMoApZy+MvJwYD0PaNd+j6nM2uj?=
 =?us-ascii?Q?1cSDTICp5PfEv1j6BGps5Y6+cA1FdUOXNY15QIZbg0Gxq6I+u+RmsqfUxBqr?=
 =?us-ascii?Q?ZJbyQqjYldnkG3vkL/OZ5rXNkeTrgnbBE2nQt3hcTtqcS9M8IEyjTANpxutR?=
 =?us-ascii?Q?a9wZX0DYnJbrH8Kkju9UQWNkxfbo+qtHUG/ckOAmAQprbYk5MYFz3bfqAi45?=
 =?us-ascii?Q?wndaLdWSb7ayj9nf8jA7Hzkqh5/YWkNLocM8xJEp7Y61QxccRoBvqVCW3rUV?=
 =?us-ascii?Q?Vx0obisoZEWERH5CX6u/gdZ5DAr51qs04u5ev5iLHsb44aensEMYSkHt2XuT?=
 =?us-ascii?Q?dzR+gxjJRTdbJwS6d6xgKRb0F77PpOWRuz+lW9DdQDw8lLJWT18g/5w9YUHt?=
 =?us-ascii?Q?egEkEOYX29no0zNbaeVa64kfnGu2Zy5qFk+GBbHDab0Q3lMg558yNVpbc2uw?=
 =?us-ascii?Q?Lii0YPb1fuN8A71+APela0FyWUCazkm/DC59iaU2NfS3JNcJ1IOm4Zf1WsiI?=
 =?us-ascii?Q?/+N9z+Cv+8Hj6rDT2vSKSWV+zfKH6dChPnOskd7v?=
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
X-MS-Exchange-CrossTenant-AuthSource: KUZSPRMB0005.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac682733-9c90-415b-1b1f-08ddff1ce5db
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2025 05:56:13.6707
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +yeH0XixTw+hqAX6lDQ1WbXbFBxB8vBvhS4uF1P7gxYT/QlbSPYmtPDW0rPfHVHAZplVCx4q9vTwfPab0KhOb40lGMBvXPAmCePPZ4Xe2Eo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB7240

> Subject: Re: [PATCH v3 2/2] usb: ehci: Add Aspeed AST2700 support
>=20
> On Sun, Sep 28, 2025 at 11:24:07AM +0800, Ryan Chen wrote:
> > Unlike earlier Aspeed SoCs (AST2400/2500/2600) which are limited to
> > 32-bit DMA addressing, the EHCI controller in AST2700 supports 64-bit
> > DMA. Update the EHCI platform driver to make use of this capability by
> > selecting a 64-bit DMA mask when the "aspeed,ast2700-ehci" compatible
> > is present in device tree.
> >
> > Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> > ---
>=20
> This is basically good and it can be merged.  However...
>=20
> >  drivers/usb/host/ehci-platform.c | 15 +++++++++++++--
> >  1 file changed, 13 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/usb/host/ehci-platform.c
> > b/drivers/usb/host/ehci-platform.c
> > index 6aab45c8525c..bcd1c9073515 100644
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
> > @@ -239,9 +240,11 @@ static int ehci_platform_probe(struct
> platform_device *dev)
> >  	struct usb_hcd *hcd;
> >  	struct resource *res_mem;
> >  	struct usb_ehci_pdata *pdata =3D dev_get_platdata(&dev->dev);
> > +	const struct of_device_id *match;
> >  	struct ehci_platform_priv *priv;
> >  	struct ehci_hcd *ehci;
> >  	int err, irq, clk =3D 0;
> > +	bool dma_mask_64;
> >
> >  	if (usb_disabled())
> >  		return -ENODEV;
> > @@ -253,8 +256,13 @@ static int ehci_platform_probe(struct
> platform_device *dev)
> >  	if (!pdata)
> >  		pdata =3D &ehci_platform_defaults;
> >
> > +	dma_mask_64 =3D pdata->dma_mask_64;
> > +	match =3D of_match_device(dev->dev.driver->of_match_table, &dev->dev)=
;
>=20
> (I just noticed this.)  The "dev->dev.driver->of_match_table" part looks =
odd.
> Why not just write "vt8500_ehci_ids"?  Do you expect that this could ever
> have a different value?
>=20
> Alan Stern
Thanks your feedback.
I used dev->dev.driver->of_match_table rather than hard-coding vt8500_ehci_=
ids
to keep the probe code generic and tied to the driver model, not to a speci=
fic symbol.
Functionally it's the same here, but this pattern avoids coupling the probe=
 to a=20
particular table name.

How you think ?

Ryan.

>=20
> > +	if (match && match->data)
> > +		dma_mask_64 =3D true;
> > +
> >  	err =3D dma_coerce_mask_and_coherent(&dev->dev,
> > -		pdata->dma_mask_64 ? DMA_BIT_MASK(64) : DMA_BIT_MASK(32));
> > +		dma_mask_64 ? DMA_BIT_MASK(64) : DMA_BIT_MASK(32));
> >  	if (err) {
> >  		dev_err(&dev->dev, "Error: DMA mask configuration failed\n");
> >  		return err;
> > @@ -298,7 +306,9 @@ static int ehci_platform_probe(struct
> platform_device *dev)
> >  		if (of_device_is_compatible(dev->dev.of_node,
> >  					    "aspeed,ast2500-ehci") ||
> >  		    of_device_is_compatible(dev->dev.of_node,
> > -					    "aspeed,ast2600-ehci"))
> > +					    "aspeed,ast2600-ehci") ||
> > +		    of_device_is_compatible(dev->dev.of_node,
> > +					    "aspeed,ast2700-ehci"))
> >  			ehci->is_aspeed =3D 1;
> >
> >  		if (soc_device_match(quirk_poll_match))
> > @@ -485,6 +495,7 @@ static const struct of_device_id vt8500_ehci_ids[] =
=3D {
> >  	{ .compatible =3D "wm,prizm-ehci", },
> >  	{ .compatible =3D "generic-ehci", },
> >  	{ .compatible =3D "cavium,octeon-6335-ehci", },
> > +	{ .compatible =3D "aspeed,ast2700-ehci",	.data =3D (void *)1 },
> >  	{}
> >  };
> >  MODULE_DEVICE_TABLE(of, vt8500_ehci_ids);
> > --
> > 2.34.1
> >

