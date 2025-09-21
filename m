Return-Path: <linux-kernel+bounces-825957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00452B8D336
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 03:51:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0595B17CEF6
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 01:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65148198A11;
	Sun, 21 Sep 2025 01:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="InKSzoFR"
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022103.outbound.protection.outlook.com [40.107.75.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B99213D51E;
	Sun, 21 Sep 2025 01:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758419468; cv=fail; b=QaGmlj1Kv5nIaukvZbPE4bFMVnpyxV1RqH6j+JiixGVxW6Npo2bKhqVWbyoFNWwhZPsIvJNZSJ6s1YUSl8WquS8VoFIae+IjAviRG/945H82NtQw+PzMBJe8IeHYGgs59rzcx3BucFrDfhhhaGGvW0CgQn+9PKdmQkiNy8XByOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758419468; c=relaxed/simple;
	bh=DHIhstPptAjcE9eRfIOKEAM8LIMxZbkd7OlEUfxfC+A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Db92rqQJz5thkHVZ7ajCQP6SFu6J8GByZlQDiMoldfWqvzZ4UJrc81fa9I/mAT0xteDeneAM8zMh66TxSa3E4lRSkDEf1BNztfaYr3jBl3LifvtAw4P8y03C2zUEKvTOWlAzxephxIWUg10aYCf4NQK24YBw35K/cdDST8ebmHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=InKSzoFR; arc=fail smtp.client-ip=40.107.75.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uQygxuVi4pC3j3584wQIqTa+1vNQFmvQ+GjjH74kEs5CETZHQZqwbuOS6F6pqqBYErih492bqpouml0V5mEyg2QfPO0IfH56OHFMeqTd4TmpjbEJQou7botmBGutk8aj9e6Z54SSi3OhNOGTwup95b/d+6hO7pm1nTZp0Ufu9Xav6IPxSl/G5zfmSQFe8GOegqVYiNz2BUnH9UznEFVsvng6FItooKONZpNahmUiQHgVinQ9FdVx1jQwtxKS79VtdVGgjXz4IS+FgUI8RKId5+y3F32kyToKupaEoTELj1sfyfCRRsdg3d2FKDfynISTdrjySXoaF+20vxL9x04JQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z/X1JTtbcmLZnst4NACOubIObsP6KsGFDRj4KndgCm0=;
 b=L5BSO87rbDvggkAvRMjFpK/Rm5gazNdIojf6NZgb+MC9yLiIENiYhqQAZkfeqMIe/OT/lTeN4Rio6MPOdkauqLgJakgGwqep44kVc+xfv8VJv+ObFWM6lLKQT1SJJ9yZT8DkjQMC0FH/O/F/t6ftB+kZiq1KawEFuiSvDSdCuoGvByw2Lzazi0/mWUQPiTs2YX6QRKyVXH2CdSGFDMEVY8o2Nj2lvBpQIscunaltoHtLprNGQrDxu9c2JZh5X7cTmQ46Owb04bl/RAdNjNPs7otid1sqVjMJgsW/RvmkFms4CZczduzVLAl0SSEOP4sAAcPKxYgDf6+OrwIQnd1RVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z/X1JTtbcmLZnst4NACOubIObsP6KsGFDRj4KndgCm0=;
 b=InKSzoFR/800RSyQp+V1Fr/GG6qYPjkCPFP+B0OAUUuhYwwf8RnD8SgIBrk8G1ZPvxMqib3+hd3rRW8Q008VuRUpI1nEMsGXkck3wNEr3u2aJFfdOSqw2w6At/bmK/RaIUEHmlv/6gVdzo3YRx8Gp6LDRhLe8pIanl2Jqgnmo50kusOd7rqLMuEohTRm7t+MSYsV0xuJjME17PMpnE5mrgFIYz6IQtyA6FRqwwPuVvVbn6WCzmle95yVhYe+A7b460h/URduGjzXllFjQyaFrfz3kWd6eJHHAEQZDxyA/xr7TLVJKlL5ipBfFyuzUzJDyh6ga1RSW5mJhHuk1U9FkQ==
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com (2603:1096:604:2b1::11)
 by PUZPR06MB5571.apcprd06.prod.outlook.com (2603:1096:301:ea::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.18; Sun, 21 Sep
 2025 01:51:02 +0000
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11]) by OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11%6]) with mapi id 15.20.9137.018; Sun, 21 Sep 2025
 01:51:02 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Alan Stern <stern@rowland.harvard.edu>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 4/4] usb: uhci: Add Aspeed AST2700 support
Thread-Topic: [PATCH v3 4/4] usb: uhci: Add Aspeed AST2700 support
Thread-Index: AQHcKREdu1q+DmrjC0mcJ8pUu8MsWbSanHGAgAJEkfA=
Date: Sun, 21 Sep 2025 01:51:02 +0000
Message-ID:
 <OS8PR06MB75417833E3FA8E72BFE028A8F213A@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20250919025712.719246-1-ryan_chen@aspeedtech.com>
 <20250919025712.719246-5-ryan_chen@aspeedtech.com>
 <9bb18e89-13bc-469b-8c05-61f8d55a558e@rowland.harvard.edu>
In-Reply-To: <9bb18e89-13bc-469b-8c05-61f8d55a558e@rowland.harvard.edu>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS8PR06MB7541:EE_|PUZPR06MB5571:EE_
x-ms-office365-filtering-correlation-id: b53e1617-b784-4753-2cd2-08ddf8b151d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?kwkw8/Ct3RfaNwTp+3EULq1woTWWiTGNISVYmcOaKgbQU2amVGifUKWoGTVu?=
 =?us-ascii?Q?K2xEKtcGkXYAodVm67LxsHWHow8Lr7t72UZdydiAPvhWWqDhW4hcwt1UHxyA?=
 =?us-ascii?Q?V1L+g8ZMCS3cNN5kTOrv2ykmERoaTfNELFv1V4iKXWQ0BWMYeD/KWQ50vV+2?=
 =?us-ascii?Q?tXI9O4rmgkXhEpob/8N50hu7Dc07pBDDleS5dJfQM+j3EfMjrwxHMDUOhXUc?=
 =?us-ascii?Q?hPYrq4t93lMAa/03n6lsCcj7AQnDrM0O5bNVrVF10L0qZDcDhT5NPgNZDQRC?=
 =?us-ascii?Q?vUUiG4y94mBx40Y1MwjgOuPJyR/PNjxLXybRcdY+mU8/iC1Sow1R7ZtFPG5E?=
 =?us-ascii?Q?6qHqcHwGMR+CE7e3uOZ1BBVXMZRtWixjNzH4Fi2isivdB6TQfs4rjNKfXzKc?=
 =?us-ascii?Q?i32lE/FmBUu8ovxMtT2ZDdzWq/cOk5gHnE8dV1jII7zP3BDaU0CTt6AZ/1rK?=
 =?us-ascii?Q?7CmFzC9st9OHRpC2z8vEgu0KTPDZ+UG2dto/sAYfS0neqxKCWnYxHJRX/ezC?=
 =?us-ascii?Q?tymouQUJOsgrSXw4LOFupreU7u7lQp6DPJcQUULpqOxuPyX3HOpMtmd83q9t?=
 =?us-ascii?Q?mXnf7E+sptGv8MiWjcsp1V9XsW6Kyvc/qqEsadQWfT9k2RExe95Ji6HcGJsj?=
 =?us-ascii?Q?DFecLENO2W+lYUaLVSnEyuHMSc1cwv4yGF2rEiTW4x3VSoeEZvDTRK6rqzyB?=
 =?us-ascii?Q?8YESaFZVZ6WrCU/3iPK5bhygzPABkFTqcHakKh7VmzSp/x2BZBOQEISJkxbz?=
 =?us-ascii?Q?gSyKUSmcgzvTP9zkxMLf4oR+V3AEI/kkycTvqPJMphFKqjNcoxh8uPHomZs7?=
 =?us-ascii?Q?7wgt3k5EE5aZvhVAXK3f1/7iMAT5Wirs4O2JrOuEv1gJbIlPgwivGF5ptSh3?=
 =?us-ascii?Q?GSGvVFSpO5r15vZQlF+Q7m3nawkqqIxqzmhDIdEIWhrPUmXhsfLP4JKW2UJE?=
 =?us-ascii?Q?sP1y14wfQC4pbjiw0IKtYd0BOpV12cy/qLuw0S0P/LFqg6TNMb7Ox3wZ+0xd?=
 =?us-ascii?Q?DmYpdUv/zQpiUqSsgBXrXyK8IZhb/2qnGcnvvYBwVRIZwltWo5lIcCW9eIPd?=
 =?us-ascii?Q?KT1/M/T3b4x3FJ2PziLSwtsaLQoigzlRx8GCMRNCHny5IVitTgi265d6M5/U?=
 =?us-ascii?Q?58YW17hqaQ8pd7+NZRUrOr61vOihQsCRFwZpfwaZudKx5QiZY9TmFGw96eK3?=
 =?us-ascii?Q?nNIvI2sNcn/XzeDAFMsOvwdPauubRYYZ4R3QMjUTAr1LEwRW3FqURSbVy1JB?=
 =?us-ascii?Q?Eqzv2ZOWuRY0rp6gwi53ApXNdo1EwpITrCogVPnqpnGCcyyMjChF6kTMM0qi?=
 =?us-ascii?Q?aUmf9hv25SGqHaPCoyblaFQNG40qoDVonnpImazT6Jix0J32yjvyPqiswRKB?=
 =?us-ascii?Q?Jc04bIdtIFJetxZ533N2iLPG76PBCQUC72zOAeuPRQBdz72CT5exbA1CwX/h?=
 =?us-ascii?Q?rT+2B/45ngjsohvb7WS/x58DjtlxL9joq42IqCmmMdBD0a8VI1qAYg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7541.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?wxQCyz85og5w5e8D6IMk1fm/h9w607UVjF0j+UoOKDMiV1rpIDbSdkbY4W5K?=
 =?us-ascii?Q?j73DobMMkGHR5/37XqwSzCqjolbVjWepeG7c+JIpJccKOwvnZuS0206G/q+n?=
 =?us-ascii?Q?sSaBklUfG4gxjkAMyhKtkkoWIf38oW4ZAVGtBvimmNqVNvLxdUBa9vDAuRm0?=
 =?us-ascii?Q?jcmVTybqBfwEVwyzdh9DVqXuIuM9Kmgh/sCOEuMVtsF00EXsbDc1yM5l+PyX?=
 =?us-ascii?Q?v/0oG+sjPg1rPcIHcuY/uqEK3t2+RRgfNKh8ZrwFJ+v26+yb0IOkGau/BmCf?=
 =?us-ascii?Q?6u6MlzNQWJl0ooSHClMV8I5zZwFalAltQSZ3uEdaDbGkBhj/QNGbpXIBh6iw?=
 =?us-ascii?Q?M4lXWa42R/NleuzR/5e2eCgofkRxcmykMBD2ist3u44S8SCe38wOgzPr5n7X?=
 =?us-ascii?Q?bJ5aexznfvk7XlFeW/0GQQ+Dy8OO4NO86oLpj0q3CTeHriDtQSrGnzCS+Tz/?=
 =?us-ascii?Q?tJiQ2UKEF2z8gVgqCX/VPPrpeLG94sIDi1euN5ASGf6xNlzbE1tHBagLglrq?=
 =?us-ascii?Q?+xRjS6kDPJlbB6WU6e07DOJLKgOShgdkmwXyJDOsC7tL2At7P1oCKTumToEF?=
 =?us-ascii?Q?LqGereqp48i51ofm0HajuA/pInUNtelwc0PHNYMEiyRpL6aY+/ZY7/T0741y?=
 =?us-ascii?Q?QiwLA3Jpe9PrKvCssCOl0JJfXajOKlYW8eJH4FeslXRepDjLdkiU6cw2EhuP?=
 =?us-ascii?Q?lmMnyFkBmB/ntb/JU0u8aOpavDzn5gFFNwVHFN9QesXN7z2e7CsKlvsS/crs?=
 =?us-ascii?Q?Eqo7bo3IEA35IzK67CuRAfg2MWIksvYxFFCdCpNRkAOXr0LZma6WBTP2FKwn?=
 =?us-ascii?Q?mdjDs03GbWQ8hVhL/REnzkulJaOas+J7B7a8pjvDqTOF1FNHJWlSW6XPNqct?=
 =?us-ascii?Q?2lE7C/UIxKNSTwaF4PfM+fwgwFFD7h7iP6sbxa628raoWH7ccO8njVPH5Mna?=
 =?us-ascii?Q?zQ1s5PHCtPNG82OQtMie965uxtwJwefwkW+pDJtDdSw58wpDoxRg/K6XvQXs?=
 =?us-ascii?Q?3LnbK9llEBwuQqvMtZynfGIQ514Gw2aLknwVx1dxMb/aZtQxtMOSgK55ylKT?=
 =?us-ascii?Q?16MXopY72TZcfD48bR47R/dYZh8RjJyybvLdneSLTGGmjztzw0XpqJNy8+C9?=
 =?us-ascii?Q?YFev/+H7/s9FUe7ovCzpXmtdNQWfVHLRPoWtIl6Ji4KtjM/3iWafRqBMwABU?=
 =?us-ascii?Q?ApnI5WYiJszQIh+A1p6/t95IDsFr4evDWrMiWK/Q/bvmgWMQAFnZh89aym2G?=
 =?us-ascii?Q?iLu9cY8+Oi6dRqIdhMOZ1qV/wx6Tbma1H6PDzwlqapoezAlQOBoK6c4Gw8n2?=
 =?us-ascii?Q?Jngchmt1ywtLqkPyhx75BVPf+r8hLW/MRzO+Fu2vPOZp0uhiBxNU7+Ny7xk+?=
 =?us-ascii?Q?qJs9qHbe3kMgJnUsOi/pUZhe5VfSbpN26XKcpbTnAmA3x7aXbsn2ISFoqad8?=
 =?us-ascii?Q?Nj2Z5Zw2q9vuGd4xSqx2j/5dBSQuwt/TqsAnzy+GlwO6sleuoULmCKm06y22?=
 =?us-ascii?Q?ZaJ2JUc7o4DA0yjQ7KwaDC2AHTsEZqCxYLFGRVwUa2KtMZZ7V0sMBx039t6j?=
 =?us-ascii?Q?vw7djrST19oh5JGtP1fvuOt0VLiAo9/9UNqlgQw0?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b53e1617-b784-4753-2cd2-08ddf8b151d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2025 01:51:02.1617
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eX5b8Q0M7PgRUPsiQIvDT1AE+t7I2LBkrogR/zHLcWEc/LbPq4jGQcQRXB39jj7+XNBuH9f6dDEw9H5DmdsB62n+SzaZPvE9nhc8FbmzJ4w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5571

> Subject: Re: [PATCH v3 4/4] usb: uhci: Add Aspeed AST2700 support
>=20
> On Fri, Sep 19, 2025 at 10:57:12AM +0800, Ryan Chen wrote:
> > Unlike earlier Aspeed SoCs (AST2400/2500/2600) which are limited to
> > 32-bit DMA addressing, the UHCI controller in AST2700 supports 64-bit
> > DMA. Update the platform UHCI driver to select the appropriate DMA
> > mask based on the device tree compatible string.
> >
> > Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> > ---
> >  drivers/usb/host/uhci-platform.c | 15 +++++++++++----
> >  1 file changed, 11 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/usb/host/uhci-platform.c
> > b/drivers/usb/host/uhci-platform.c
> > index f255358d6242..5b4be9a5764a 100644
> > --- a/drivers/usb/host/uhci-platform.c
> > +++ b/drivers/usb/host/uhci-platform.c
> > @@ -71,6 +71,7 @@ static int uhci_hcd_platform_probe(struct
> platform_device *pdev)
> >  	struct usb_hcd *hcd;
> >  	struct uhci_hcd	*uhci;
> >  	struct resource *res;
> > +	u64 *dma_mask_ptr;
> >  	int ret;
> >
> >  	if (usb_disabled())
> > @@ -81,7 +82,8 @@ static int uhci_hcd_platform_probe(struct
> platform_device *pdev)
> >  	 * Since shared usb code relies on it, set it here for now.
> >  	 * Once we have dma capability bindings this can go away.
> >  	 */
> > -	ret =3D dma_coerce_mask_and_coherent(&pdev->dev,
> DMA_BIT_MASK(32));
> > +	dma_mask_ptr =3D (u64 *)of_device_get_match_data(&pdev->dev);
> > +	ret =3D dma_coerce_mask_and_coherent(&pdev->dev, *dma_mask_ptr);
>=20
> What will happen here if of_device_get_match_data() returns 0 or an error=
?
> Shouldn't you test for that and then use dma_mask_32 as the default mask?


I'll update the code to fall back to a 32-bit DMA mask in that case
dma_mask_ptr =3D of_device_get_match_data(&pdev->dev);
if (!dma_mask_ptr)
    dma_mask_ptr =3D &dma_mask_32;

ret =3D dma_coerce_mask_and_coherent(&pdev->dev, *dma_mask_ptr);


>=20
> And if you do this then do you need to add the .data fields to the existi=
ng
> entries in the platform_uhci_ids table below?

I've added .data =3D &dma_mask_32 for the existing generic-uhci=20
and platform-uhci entries so they also work correctly with this logic.

 +	{ .compatible =3D "generic-uhci", .data =3D &dma_mask_32},
 +	{ .compatible =3D "platform-uhci", .data =3D &dma_mask_32},
 +	{ .compatible =3D "aspeed,ast2700-uhci", .data =3D &dma_mask_64},

>=20
> Alan Stern
>=20
> >  	if (ret)
> >  		return ret;
> >
> > @@ -114,7 +116,8 @@ static int uhci_hcd_platform_probe(struct
> platform_device *pdev)
> >  		}
> >  		if (of_device_is_compatible(np, "aspeed,ast2400-uhci") ||
> >  		    of_device_is_compatible(np, "aspeed,ast2500-uhci") ||
> > -		    of_device_is_compatible(np, "aspeed,ast2600-uhci")) {
> > +		    of_device_is_compatible(np, "aspeed,ast2600-uhci") ||
> > +		    of_device_is_compatible(np, "aspeed,ast2700-uhci")) {
> >  			uhci->is_aspeed =3D 1;
> >  			dev_info(&pdev->dev,
> >  				 "Enabled Aspeed implementation workarounds\n"); @@
> -189,9
> > +192,13 @@ static void uhci_hcd_platform_shutdown(struct
> platform_device *op)
> >  	uhci_hc_died(hcd_to_uhci(hcd));
> >  }
> >
> > +static const u64 dma_mask_32 =3D	DMA_BIT_MASK(32);
> > +static const u64 dma_mask_64 =3D	DMA_BIT_MASK(64);
> > +
> >  static const struct of_device_id platform_uhci_ids[] =3D {
> > -	{ .compatible =3D "generic-uhci", },
> > -	{ .compatible =3D "platform-uhci", },
> > +	{ .compatible =3D "generic-uhci", .data =3D &dma_mask_32},
> > +	{ .compatible =3D "platform-uhci", .data =3D &dma_mask_32},
> > +	{ .compatible =3D "aspeed,ast2700-uhci", .data =3D &dma_mask_64},
> >  	{}
> >  };
> >  MODULE_DEVICE_TABLE(of, platform_uhci_ids);
> > --
> > 2.34.1
> >

