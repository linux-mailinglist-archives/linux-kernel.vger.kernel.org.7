Return-Path: <linux-kernel+bounces-828896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B19B95C77
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 14:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3B733A7112
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 12:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5F6322DAA;
	Tue, 23 Sep 2025 12:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y+FqZJ3D"
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010031.outbound.protection.outlook.com [52.101.201.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C825F25A63D;
	Tue, 23 Sep 2025 12:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758629345; cv=fail; b=UDQT0KJe7wTZHfHNvGSJfV32msOGUTinXgDdE5zmELLKKxRHu4h6YXB03S2DUFCXJYKSI5t/r25AYKXmTwcroK66eNORcmMJDPvUYA7IOld7ajl5B3H4WJHuiZ0S2RNouf6FOeB3IRsFQQT8M5paDMPh98FaJs8x3z1CANBlc8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758629345; c=relaxed/simple;
	bh=1W0PKeGyVFO7dQJy5Xh5Z3s8IUNkRg5rIqjj0vOwpcE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aLB45nFR7At5+1veIWSK55KZHvOPGiwulbcdQTnxWe3LDgJjvaeNRutmX8Sghkna8Zj6px3paLSb2CKkJQm6FaF9hf6kiKXVDjYONjLTbsjf8R1IZpei29M/6pHCocnHFotCsPv+REROqmLKn0OsyZe6kphJD7lbUxmXY2M8dXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Y+FqZJ3D; arc=fail smtp.client-ip=52.101.201.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hgHy3AhhNgqaMNu40QecQEKt6sAe9cdBA7R7wFRVtYntghtMv9HT4TT/QrxWHL84/T+mYHPmibvVrxnlOrD/fNgxqhu3RaBtkR4jk7PTGBxHT6m48yQIxBWQpATLieX7pQITEkJwJ4ddiZKgkBVJZ/dTXBSMhe82z97kWdLjh/YqxLL8zPEprmz+2iONZR65PWZuLVR88pSE7A152gxEAlms1tSHgkPLoqVPs9t9nNtXSUyICofahthefdVB9ZxTbyAmZw1FZg+aP2ZxllrCxB8lEfbdKMf/H8te7bT8pc75IzFJz74Tm05XUhCG6G8BMfYAbX7l7NbpwspWab7LKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/TRms5v59OhicR0us2xT0kRzjRDT7qjTs/LCHP+dIkI=;
 b=eM1U3mNr+z9c1oRDPJHdvvLn/qs+f1/s9o9YlWvTdiFg/DIo8yh2TxsbmdNOpjsyWXQyg0XqhBbXgYSsRoo9m6t0cyXYDmHZQlniYFePTLVEc0hUjs0oWmlaKGre1JU/2Twxm9t8BmNdujv8rX5oM5+YnwRCKL+vUE6JY2b7oGgyvcd+faQz1qSmSRrgqQboCNxGBEpPcGhdzXVKbNVYc8CZl2l0ACO2Cg1KOTFwyFbHwes6bONJOU7mI5ntR9m/ZsLwOtL9l8zfSX1TWULhMKvapMouWd7QKPUhIowzoD4gfuujCiiw//aKEye4IztQdCpyEbY9qXA3g4KF9D570g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/TRms5v59OhicR0us2xT0kRzjRDT7qjTs/LCHP+dIkI=;
 b=Y+FqZJ3DDWAHL+1WQ/aXN4sTzTAcLe0sEr3OZhxo51fIGd+oqFDxMVSugncPYNLeO5QO70bUoRrfevULJ9zaAK0w+rziD8cwRMq9y6gVR9mSxIj2jX9PLCnIZQqUvm8CCWY9+M66QGuIx9TjGdrJZycNMPY1zw8A9Sd/bm/yqfRNuXSGqCJ3ry1FrlfGlEzamF2wVaTSsWJgDt5yAWcNHkGfPGccnrS1PnwoQmDoz7d9VkOEdHWg8DI9RcsP/FTulczEnF+fuAUuQacrVEDRH1ELl4I6f0mbGfdVcQT1qt6yH1U3v31Gmfhr5El0r4r91OK83k9abFg4KFFiNhJxhg==
Received: from SN7PR12MB7324.namprd12.prod.outlook.com (2603:10b6:806:29b::12)
 by SA3PR12MB9107.namprd12.prod.outlook.com (2603:10b6:806:381::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 12:09:01 +0000
Received: from SN7PR12MB7324.namprd12.prod.outlook.com
 ([fe80::36df:d252:e8a1:b651]) by SN7PR12MB7324.namprd12.prod.outlook.com
 ([fe80::36df:d252:e8a1:b651%4]) with mapi id 15.20.9137.017; Tue, 23 Sep 2025
 12:09:00 +0000
From: Ciju Rajan K <crajank@nvidia.com>
To: =?iso-8859-1?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: "hdegoede@redhat.com" <hdegoede@redhat.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	LKML <linux-kernel@vger.kernel.org>, "christophe.jaillet@wanadoo.fr"
	<christophe.jaillet@wanadoo.fr>, "platform-driver-x86@vger.kernel.org"
	<platform-driver-x86@vger.kernel.org>, Vadim Pasternak <vadimp@nvidia.com>
Subject: RE: [PATCH platform-next v2 2/2] [PATCH platform-next 2/2]
 platform/mellanox: mlxreg-hotplug: Add support for handling interrupt storm
Thread-Topic: [PATCH platform-next v2 2/2] [PATCH platform-next 2/2]
 platform/mellanox: mlxreg-hotplug: Add support for handling interrupt storm
Thread-Index: AQHcLHcksKIrMb5WOUOEBaq8mTeD9bSgmBGAgAAT30A=
Date: Tue, 23 Sep 2025 12:09:00 +0000
Message-ID:
 <SN7PR12MB732408E54E6C19B89D891994D61DA@SN7PR12MB7324.namprd12.prod.outlook.com>
References: <20250923104452.2407460-1-crajank@nvidia.com>
 <20250923104452.2407460-3-crajank@nvidia.com>
 <066ef64c-c6e4-f070-9851-ba9358b0970e@linux.intel.com>
In-Reply-To: <066ef64c-c6e4-f070-9851-ba9358b0970e@linux.intel.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB7324:EE_|SA3PR12MB9107:EE_
x-ms-office365-filtering-correlation-id: 7e8fe40d-8104-498c-9cfa-08ddfa99fb43
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?jDulcuqaM+lbbtNustpwIQuX5abEnBDM6LNed70NblD02EEMQof0kE4Gy9?=
 =?iso-8859-1?Q?QvA7ou3eYBFtxYAVqwTUe2l4v3MK6Ezfyc1ORn+lZyIigZ1BH0ZJZPNuav?=
 =?iso-8859-1?Q?YiMma5WlpUffbvs1r3ely5xIeiUHYsF77ER8NavGECdpsfAv6ZiN4OLY2/?=
 =?iso-8859-1?Q?KjJgwOZDxPDDY4sBRWX9hugi8uVmctoy/sIobb7ZuV/ES0+huAJIYgnhQ9?=
 =?iso-8859-1?Q?gXu/F5qssZ7fyUX+0g2a1mjKAm5Lffu1dlFWPCtJztoucvsmPYrNvTfZp1?=
 =?iso-8859-1?Q?1UuXD6P2wARL5D5LQBxaN/tWZ+17NC9SDeQqI1fs3o6dXt9TLnYZlGSlr8?=
 =?iso-8859-1?Q?E6LC5mZHlWE/oLWP9reoAlLInqG6QBEfo3wOePyuxjDIvb10ObkabQhcTh?=
 =?iso-8859-1?Q?VgUPZgWxhPtrlBYP7q8QEYAkX8ikj87kSfLlVFOwmipxTLtKysmcOD/7/m?=
 =?iso-8859-1?Q?GM96QZtIOyk5JSYdikSJh+zA3g8+BiCSjnt7fH7ZXfe1jwAyzfXXYXGeMw?=
 =?iso-8859-1?Q?LH31kCZB7K/QaswWYKa8B6JZE7pEHEsWjfwlcKWTuIaLrg74MFhbWOkdZ6?=
 =?iso-8859-1?Q?15VSJ5gYodWn9e0WstykAtrKpmVaCV5Zht84Wocm/XPcZIZO3NFz58HUFj?=
 =?iso-8859-1?Q?92HumhR9zP06Ovq8f3h0xY8s8QujLSHEhkw3Xfo/5BC9u2cbk1azIJJWbT?=
 =?iso-8859-1?Q?+n76OoYnS1xUJm/zvkeUPQHl8+6zxQuKIZg6dn7EKi8D60xwBxZRIyUADk?=
 =?iso-8859-1?Q?/SFN4qZghUvjSGAAne1n8wS97k2Tjja8sEJjHo+hp6LvWWSe4ux9n1t1Mi?=
 =?iso-8859-1?Q?33PUt6SsgUgPdptO6vd9D2cv0NA+MmGgg65RXNvQOItI5SQNc/KZi8EXqm?=
 =?iso-8859-1?Q?vj+RsFgZYWeWuLdhlhuZ9spCjAQ+fq/GKPuwB+pEGAyWo6kqot1nWcbXLh?=
 =?iso-8859-1?Q?McGC2x7WZb1RZtgRofSIQV/QFVm7mwfTJOjNa2Ib6K5D+2vE3mZyp+YCht?=
 =?iso-8859-1?Q?iP86HuLB9BtVMkI/faDB4DAbTxXk79YcXtCF5z3XBhjrIl9r+s8Tjp39x+?=
 =?iso-8859-1?Q?oaxyYURtx4uaDCm/1p3dTZbt71lk15Kc+wjqAtN2saAEAY5nMC+B7d/pZn?=
 =?iso-8859-1?Q?opC2r4IOG2QDtYSaDr66F7mS3WTvheZNsPCG+BhlffEeLA4K0EYweijRKN?=
 =?iso-8859-1?Q?lejVC/H+k8w5KjhhwM37xcKV/J4xJzl1oH0d1NixCAtZhqZPr9wyFsM6Dn?=
 =?iso-8859-1?Q?DGoFm5NGjHngv5YxN2hvspGAlx5AIXQnLr1g+f9f4taG2bhbRe0QBVy+hF?=
 =?iso-8859-1?Q?QKLlaoZ1QH+bNVFqc/L1SeaQdfDl5p65bkjSr1ZsXMAwWRS010f1uE0Ymn?=
 =?iso-8859-1?Q?4+LaACPC2DU4IqejEZsiojZBfj+YP7SwAxWL2SWVV3pMtqav7voZWFMZBT?=
 =?iso-8859-1?Q?Da8KG8451osfLfirMSUFM+r2giHLb5ffIiCeBz83zJLa0/VjQXRi5rGCfb?=
 =?iso-8859-1?Q?xmk7v3bn4Jl4Du48akFNlvRzDl3awCc7FgntjwNlTH6MPKZl5Lln79uVRX?=
 =?iso-8859-1?Q?OI/Z/W0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB7324.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?ETQ5rV1zuWxmMlHvZhPVnEKvCc9qMA2VdVWxxBvzZ0q/cccRcCVyoYklX1?=
 =?iso-8859-1?Q?n3KMrkehnlMG/wl+dUlaQ+eNeQ8LhUiIVpIRqbQN/IHc7ux59PqXVsMRb6?=
 =?iso-8859-1?Q?8XJoNghZD0umAgPbzy2PsJiBHqa46ey7jXtRaAMzrNEqlRoYfo4a3aYO9K?=
 =?iso-8859-1?Q?w4mK7JM76e5ev2S2f2sTGwHjvgCNOQvDLAuLiaOV561aRDpK4YzFN4g6Tx?=
 =?iso-8859-1?Q?HmUs+j2HdTX1RVvEwVcNx+t7gdzNTsu0S08SubYkfkThsPYKMvaoKlTJQo?=
 =?iso-8859-1?Q?2dcvxxRV4m+vR2N3C+9/rUQagBax+jCYQam52cCApoNnljB2t4QXUseF1e?=
 =?iso-8859-1?Q?3Q9Zgmx0unBmnS2AC/Q1HAZzvHLZ5fO83a7QFZpsNm1uEkDd/7LMv9n0yY?=
 =?iso-8859-1?Q?ieSvWvD9F6+qvvqJ2VK9QHhWIdE+Z4hDFUmnaqVTekFr8old+J5Qo4Vdph?=
 =?iso-8859-1?Q?iDvN6w/IsQJFZ2xWfBrCne4qfBjvZcZtvCrGvDcvifFUsPGyfpJnrFoRpQ?=
 =?iso-8859-1?Q?7s9VOKR5muNPh/67citXzfd6FEoUElLNlhbEajkuhGqjS6NPLywQlAW0yl?=
 =?iso-8859-1?Q?1eM7QQZDvqngkGdy1P9H/n447+jARZmPv0BkeuUm3TCwwVI7XFw6rvopJT?=
 =?iso-8859-1?Q?dTz9xeW24U7Ns4iOEY9uAzecS0enkJtSiBFrmP1wC4XNZQ1vGV9Ol+ls+V?=
 =?iso-8859-1?Q?y+djklpcc737eNE0ngpUwgbhCTePwMrXqjBNF8Ph4AbKZchlvtdETZ1a/x?=
 =?iso-8859-1?Q?aJgZfNyDTBQVHKdJuATDO2FDsqD3muDpDzLq8Iu/AH86Jj9CoPzy5vuA0o?=
 =?iso-8859-1?Q?3LZ+P4vUDz27JYWpQi8WqOn4y1j9KFSfAyzeqrrBfAZ7hxPMqPGYtSbRCs?=
 =?iso-8859-1?Q?PuOtM1+dj1wzGKxSYlw9CModS9SU1s9eyzQvE0mIh54/X1hEStyyUpCtch?=
 =?iso-8859-1?Q?nzKM8VDFa14kuh9mT0Q1zNA117fc+zifOqCL19uY+QKRv67eNciEPDpsFS?=
 =?iso-8859-1?Q?vWky87yZHMzDZG68pDhOE/+b25CxKySVAD9pn7cI+cwmP4ivCVamzER3d8?=
 =?iso-8859-1?Q?Q0gUZLELr2cHQYrA3pfPGtV9y1kQg/ErEHRi0k/gPD1alIGZgl5qRmNBu0?=
 =?iso-8859-1?Q?cP65p5kfZ8r0wdGatgBhhyIOWVajH/+ps7wyEwH9HyHdU8tZuw229se4a3?=
 =?iso-8859-1?Q?Y3lr0PyuL2Hbw0dhI8Keb/JZtIaR2oaGkKp84+EtEyA4IFQhJcvutweXnl?=
 =?iso-8859-1?Q?Cl3zvFs7nMYtJ7nrZGct1zWjMZeDSME3SAhp1uBxEx5QP1DJBAUM/FBV03?=
 =?iso-8859-1?Q?MynG6t0CDJ99GBtX+4dJND7MAHtx/XnUU6ezCBwDJsB6wO6ToXN6ciOmQh?=
 =?iso-8859-1?Q?e42TrppH9wcKl0JWbrg4GW5QHwjaXv1mL+QTol4GvWhCwxpI2oedrCzwsX?=
 =?iso-8859-1?Q?PbjKT3z5FYrc/sZbetfttSMuSfNt3nLVU4L039N7mBHCyMWeZBjKrooG5G?=
 =?iso-8859-1?Q?LENVyYToYEz4xuSgb1L6za5tceHX3baodIQh0MfFLIzn0PZOWX3d4hgNAn?=
 =?iso-8859-1?Q?Vym3JM5unSNc9ixjVIxvyosSx0weDuOlzxYP6me3mi3dCJk9tevUc7Wm0g?=
 =?iso-8859-1?Q?Ks4ndsYhTNYSg=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB7324.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e8fe40d-8104-498c-9cfa-08ddfa99fb43
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2025 12:09:00.8891
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l2HLn7DFkFfCvQAbt5FNhMbeSHiU3Fsgo9wzXbUrXyKNINTfU67jeDhydnv3Fw4VYbFnSCDLkyHXPwr+PMVElQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9107

Hi Ilpo,

Thanks for the review.

> > +
> > +             /* Interrupt storm handling logic. */
> > +             if (data->wmark_cntr =3D=3D 0)
> > +                     data->wmark_window =3D jiffies +
> > +
> msecs_to_jiffies(MLXREG_HOTPLUG_WM_WINDOW_MS);
>=20
> Please use braces for multi-line if blocks.

Done.=20

> > +
> > +             if (data->wmark_cntr >=3D MLXREG_HOTPLUG_WM_COUNTER - 1) =
{
> > +                     if (time_after(data->wmark_window, jiffies)) {
> > +                             dev_err(priv->dev,
> > +                                     "Storming bit %d (label: %s) - in=
terrupt masked
> permanently. Replace broken HW.",
> > +                                     bit, data->label);
> > +                             /* Mark bit as storming. */
> > +                             item->storming_bits |=3D BIT(bit);
> > +                             continue;
> > +                     }
> > +                     data->wmark_cntr =3D 0;
> > +             }
> > +             data->wmark_cntr++;
>=20
> I think this should be in else block to allow recalculation of the time
> window when the counter wraps.

Good catch. Otherwise, time window will never get reset. Fixed in the next =
version (on the way).

Thanks
Ciju


