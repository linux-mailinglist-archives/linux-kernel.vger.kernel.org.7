Return-Path: <linux-kernel+bounces-826568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7926B8ED3B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 04:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1C5016878A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 02:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840362ECD23;
	Mon, 22 Sep 2025 02:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="nW/dBaAj"
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023135.outbound.protection.outlook.com [40.107.44.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E382836F;
	Mon, 22 Sep 2025 02:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758509552; cv=fail; b=MoteuHiiqqMFPqgws2vQdDGy1XOtIY26K3wi6uNIKxEd07BB78wMp2b17TOX+Dmc/MBeH1Hb8rtmz7tEbn+DYV46AIcNPJ8pWhTMfBdoH8lZUIqBkbm3lPd/yH+/IksVBuCTHF8nfx3GY7nFaHx9Iv728i6oVhkRaLBmTO128O0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758509552; c=relaxed/simple;
	bh=mVJ4KSkCa6Gq56cJvR5Sp8pGkijGJbwGq+EEPHr2/3Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tNOlrzaSa7toUkbrIhUb6wyOO4Aj1ccEhF0xckD5hiRhXOuxOeByIetmAibvSKTzGurY+Q95acNfh2LgHDpuoCQkSCCffZdPv+jZiDtbBMj1E1r9xrZKaGQXwg2JFAOiqJiXVw/EMFxulWpODAKBjEVgtnDrXmgm/uVfUgcoJ64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=nW/dBaAj; arc=fail smtp.client-ip=40.107.44.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r35S/MIbX7mycn920JGsxWDH/S+KQSOSszE/EJ0RBhFWl8JL6eBpZ64ChedNQzpi00lrnV40IW1m+miUVUP9M/j1yJTB77Cfa8DBqYIFDaICI6ibqhfsPjKCM4FbBgmwEtHEE0w91/50xkfnNxDMv2/XgIuDAbDQPhySB2fdN4tYrEytPTv3ks38zag3JANsgLs1JCPNRpL5WdYKWdFzLXS5ascpFw1jxbSd+4yvByfO5KjI0ppbS18m/qzhEXcftW+i8vBXIsQdIta6eemEJa4QZdBHotwimNOtVV+fxLDqn8de7QcH8D4TgtbY2X9UbmuKVgG05k0oXZMmZKG4bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rzTDU9ONZYKF/8M7xOZu2SXozFqYdE1tQ+MMS2ALaU4=;
 b=Njb9nNi11OJvXRhs7Ol3hzxiHcpuZ+HYXkH3TC8c8Cc8GieS3tmXxCasGdbOxzjcviFv45t1enKebyF1tCDSh3pEXBXei6W5aERpzbS1ZFueXgAzvCb35J5HxPXzaZc0k5gtaZXdupN2M7KovHNeuhUu2lJ2vfdfXDSc7qe1108sVtzOl4PhmWcVtei1UIuf301lYOKuzqmrsSV2mG69BefOcnYGYoDYfF8+5cZh0Lj+arkHscXnSmTB2BHt6+GwQ7YMFMXxs6LL4IZvkv1axhITWg3vtC7yPzEA2WhmvkoKajIDqpIm1BTm5pEAcyRU+m6bXgzhgP6PK49WglnNag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rzTDU9ONZYKF/8M7xOZu2SXozFqYdE1tQ+MMS2ALaU4=;
 b=nW/dBaAjUmDZVWFUloRU2HCYUiSCXnnFdvR0L/OK2zj1Jaz2zFrJz31oNOnfpqRhL15LogkYi0pUq9Md0D/oujlKWv9z70NqgDQYGRzB9YROcNrqZHeziyVgQRCEasTQvNrzVMDaESb7OwM1oqIJegzsJYWBVCRahwJzIj5KLPA9bn2dA/XivIp/cxOGidYUe8PK+8iO95CCwzW63065NUm5W7rBedoz9KRgvmrXLZXR9JPupHmnxAnMT0ytTSlPLIgQAkfanwOYOjc2yZiu9t/QzJV6iAKevTrc9liEoSZ0a+b9CQ7sHtiYqfYMFdjFlJRAjR7+kMUlBWHwVM+0Iw==
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com (2603:1096:604:2b1::11)
 by SEYPR06MB5768.apcprd06.prod.outlook.com (2603:1096:101:b3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 22 Sep
 2025 02:52:25 +0000
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11]) by OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11%6]) with mapi id 15.20.9137.018; Mon, 22 Sep 2025
 02:52:25 +0000
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
Thread-Index: AQHcKREdu1q+DmrjC0mcJ8pUu8MsWbSanHGAgAJEkfCAAaQPgA==
Date: Mon, 22 Sep 2025 02:52:25 +0000
Message-ID:
 <OS8PR06MB7541A49CB2ADBBA1BC4B3139F212A@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20250919025712.719246-1-ryan_chen@aspeedtech.com>
 <20250919025712.719246-5-ryan_chen@aspeedtech.com>
 <9bb18e89-13bc-469b-8c05-61f8d55a558e@rowland.harvard.edu>
 <OS8PR06MB75417833E3FA8E72BFE028A8F213A@OS8PR06MB7541.apcprd06.prod.outlook.com>
In-Reply-To:
 <OS8PR06MB75417833E3FA8E72BFE028A8F213A@OS8PR06MB7541.apcprd06.prod.outlook.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS8PR06MB7541:EE_|SEYPR06MB5768:EE_
x-ms-office365-filtering-correlation-id: 67e5485a-4f72-4998-2925-08ddf9830fc5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?wqLfuSK+KOVSNHD3IBeEW449EVaXn0OU3gnNN3pYfyGxqcDSmc5sjH2Jb2n3?=
 =?us-ascii?Q?UtXykLIbSEkH6cl2bjYkHlO/IlXvN/3kP28EcQcK4z9qsNDebE+0BECA1e0x?=
 =?us-ascii?Q?vpUkAztBxCEuq5alGZd0uzPEcOmHB4dzgMehECOo/OAX56gMLXfM0NM0nUYu?=
 =?us-ascii?Q?xK1Kq8C8iLRXPaGSUcMx6JS45b99XKB7XXZy29Fi/9uvMwBcEuN83kVU9/i/?=
 =?us-ascii?Q?ASPTlDwVWn7NPopY4c5mP7B6QwcKTy/7gkvy71y6M+uPP9pmoX/nWdSySose?=
 =?us-ascii?Q?efaqVGOD0ZPsvivh5ffd7lv555uwcrrN+0iRaMFLGyaN6HMXLOx+sliX0ukI?=
 =?us-ascii?Q?mAh2JawI8N2Vh8QRkrjC2TChtkr9ry1ngq97C0/VpEAoxaKUiCsag6FoCx4x?=
 =?us-ascii?Q?u2BZP/XX9Cu+HGEvMbpt7mSDw5alqGkiCBDP7+Ii9Yvvbap250efc4j6Ruyg?=
 =?us-ascii?Q?Sd72aAvxKmaKnD3DM2a9G4CR43lIZuLVFdlTYy2Sx4uF+F+3bg7vCoVkztbf?=
 =?us-ascii?Q?xgkl7is+ff1QPQzGQLrbvR5egYBxazqwDDR1Qj7drKm9NoN5u2ntfc/q5OXC?=
 =?us-ascii?Q?KitkD2ptx/cH/XCtuyRunvaHZ9Wjenk6J9R5YTySlnRSyfL15jhKY0Qvqjhb?=
 =?us-ascii?Q?9aVNYADVI97/cskcTE8fJG99KabUdFaNg1G4qGENTuhfPNkUgWWmhM0eBXJJ?=
 =?us-ascii?Q?i6XKVzkwW2LUi9oERkMWJPti1mid6rEyH5Xtr2qz/kO1s3PXOslxoaZ8NgFZ?=
 =?us-ascii?Q?rP8crphOzseQKl2g5af/1haztd6PKQ+9sndNRt6V/brgHcOeUZjShPBtuiIN?=
 =?us-ascii?Q?rp2ZCE5mnIgoJVpgI18rt5QeI6yFdPada0hGYrjzo11ja/PIFicy9IQkUu7s?=
 =?us-ascii?Q?rA5NW7p+IlySTNWr++p6Qrqkg73Oy1tAT6LdhSBy95Ydk/3U/Hj7z8WR9YQx?=
 =?us-ascii?Q?9YHZUuYursbBs46uBo8Eb/kVJowwYFyVawk0n1n2aXaRRLeGkys7Usa1QwqE?=
 =?us-ascii?Q?1Sl627MW7yL8KRj7rDgbKs3W2wwDIf8r/HF/F+S+fS1Tmil2FSjPiOO9NTZO?=
 =?us-ascii?Q?212UmnLyKgRm6wKhbabIM1Jbv4lrsqF2C7pMteoZcyUruh5OLfC+YX//G7PG?=
 =?us-ascii?Q?EtMpYTi9IrhlyzVBtQ4TN4Z9NfMa+9Nj1oHVyWEORpaey16HZ0cw/30G0X8j?=
 =?us-ascii?Q?9uAcTSQGiGthGJD9mQUEkK8DJGmVTOSotA0zSWyXXkAwaBxjTCnTtLr+iAGm?=
 =?us-ascii?Q?BSDlTZtYAwPZ9n9yrG2cUCqvHSZ6my4MtOgV2NSDHKSv4gQxSzCA8Q3NXOns?=
 =?us-ascii?Q?LqtNOP0uDYCGtuKtjE4mZc0QZUdSBA6GpU5HVdhYd02lf/rU75JX1y2Lc+Us?=
 =?us-ascii?Q?eWvarEEuIfIcVbP/AaoGO3tHT03NIs37uo8te6+lK9YOTuU3zFp8cc2txK4F?=
 =?us-ascii?Q?C5Hl8z4OK2fyF5L/3JKs7r+4Bm3gGd3oBYUTHN5Ssi1Qs8IluSEBlg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7541.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?7D4vtfT+nSnW5GNRLwkytgMn/gUfD+pVriRjTCOn71c4ueN7mypU2dhxTJsQ?=
 =?us-ascii?Q?DG1n+AgJA4ZHgnIoCtxEbAi/zo/GQTjYn7mUcPotSGWgFLh3fYTjf9UTqd7t?=
 =?us-ascii?Q?ilTU3YyKK6CHF1VMxsLv2RplfxF7B2BP9gjXtVvJ73Sv0EP60bksjjSRJRc2?=
 =?us-ascii?Q?4nFyz4lgvek1NYDegsNwmU9dSkA9SQ8bSXLmS60VijFk9a8xLXvhzmAkGZSe?=
 =?us-ascii?Q?2Z4OM3DAGgRhrd+WNYWvqP0FubegFId1iyQkfEgnOdn2/OPAzd5cx3QPSZo1?=
 =?us-ascii?Q?lkrzV8Xn+iae9VN738cS+SQzRuz3kP1/cgbTQJgVzKdGPVVmsn0ZeBFJGPNm?=
 =?us-ascii?Q?BzUIaQquvrAATcxk4rag64u6/sbptExiHydWzdB/+RcSGgboGLqi6qNWtsQV?=
 =?us-ascii?Q?tvmyx2hJgr0wg0dUdcr50fMv2jS6aSt60vPuBqCUP1pi7Q6FWLoLRtrgMViB?=
 =?us-ascii?Q?aVCPnwq9e43ArUd/akvKLcAELI3mru709Y7KpL/skdVe2ZXrHB9/b+Ak+OXF?=
 =?us-ascii?Q?d6ziIIegqJRREHN4YV4rn+LUWsWShYyF38igDO8r71gKAn7ttx8P67tq88UA?=
 =?us-ascii?Q?Ix8IXIwBbn5fRzPg1ODCl8G1JZ0vwAoNnWFLsylrgeUSfm2GKSjUsfpSP1OB?=
 =?us-ascii?Q?kLkcsDmFRlDJoDtqGSgfBuPVu5gnpsdWgg756XUjNQ9DkYro/5IjoXb52Jkt?=
 =?us-ascii?Q?D/AOG0hXKbVSajTr2M6+p2XcW19NNBZ2jcW/xpeZr+PlzXds2DzX5MNDGTnh?=
 =?us-ascii?Q?errcC36j5Owwnbr+WrAwGTGV6Ui/SLD5I6Q7kX1p2xJhgKDjQhzCtVDphjJE?=
 =?us-ascii?Q?ezxHAk1Kdtd2esvv5aU4JXrK9k8CJtUx21EeYr7jodq8yTBCT71o5pSymtcC?=
 =?us-ascii?Q?4M1Qul58y5wmBhgnUWte9KTty06gpUfuxvPjd6/pLz7afHxMoAoJBuXuHzo4?=
 =?us-ascii?Q?5NhMV7CgBGFn0+j+FGhk+O/alvwWewbr/y1e8QHAsdyaVWU+pf+qZlGlf/lk?=
 =?us-ascii?Q?v0j6WQlo11IHLfXnGFeFI3C68zdQo+hFQQ2ebERANaQlEmX9sOGzoliXavIT?=
 =?us-ascii?Q?uMrJf1NBf+o632Ekuq4tPPHZbVXU0AmhX5bL3P6tKqaeE6yHUsFwtaaiuzaV?=
 =?us-ascii?Q?ANdCD4JJLTHlDb76d43OuKCVwC9cUBrYR5PUhkoCx6JTiP3p3yclHiq/RE5X?=
 =?us-ascii?Q?SlS3Mkaihvwt00mlwiwElujguaWJFza8qCE7bxe1EZNsT/7r01iJ2xJu0uGt?=
 =?us-ascii?Q?oEDlacz8ft+HNPE/PmK/sPNcKuKxipe17gJ5C4UWmvT1e2hWbgwgnhm6NdER?=
 =?us-ascii?Q?4EXT2G9qtxy1iaBTtVfjar8uEDDtB6hfaOzac/CN67sTqk/+LIFZ6WcKpU5v?=
 =?us-ascii?Q?9NP3+9n+iD0bBMg4y8kSXBEiCJEJmPZJK+oNQD/ZCrca9BR1ILapyZgTwhyu?=
 =?us-ascii?Q?n7+WpKrnM+az9x6vymMKJQIepAUkdzk0EGnsNx0RHp4sqRg7pfe2DH4CYuFk?=
 =?us-ascii?Q?7V1xFdejfTG4/iNytzZJC+6zJ+NuPqj6uXdoGa5aWsWzJtc90mBMylK8Z7wI?=
 =?us-ascii?Q?BfZxLemmdDPSo8KVZbJvAEyawDA4mnpx+xAdmWWW?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 67e5485a-4f72-4998-2925-08ddf9830fc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2025 02:52:25.6917
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t9ynjFIJZik29pMrwckabIOLICDnqaeZHJ/7CrXYuS1lYabzIFxgJErriAhXg/vhFU2mPVTYhyg0mwlpMu+B4eACyylysMi4gXCa1l94mkA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5768

> Subject: RE: [PATCH v3 4/4] usb: uhci: Add Aspeed AST2700 support
>=20
> > Subject: Re: [PATCH v3 4/4] usb: uhci: Add Aspeed AST2700 support
> >
> > On Fri, Sep 19, 2025 at 10:57:12AM +0800, Ryan Chen wrote:
> > > Unlike earlier Aspeed SoCs (AST2400/2500/2600) which are limited to
> > > 32-bit DMA addressing, the UHCI controller in AST2700 supports
> > > 64-bit DMA. Update the platform UHCI driver to select the
> > > appropriate DMA mask based on the device tree compatible string.
> > >
> > > Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> > > ---
> > >  drivers/usb/host/uhci-platform.c | 15 +++++++++++----
> > >  1 file changed, 11 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/usb/host/uhci-platform.c
> > > b/drivers/usb/host/uhci-platform.c
> > > index f255358d6242..5b4be9a5764a 100644
> > > --- a/drivers/usb/host/uhci-platform.c
> > > +++ b/drivers/usb/host/uhci-platform.c
> > > @@ -71,6 +71,7 @@ static int uhci_hcd_platform_probe(struct
> > platform_device *pdev)
> > >  	struct usb_hcd *hcd;
> > >  	struct uhci_hcd	*uhci;
> > >  	struct resource *res;
> > > +	u64 *dma_mask_ptr;
> > >  	int ret;
> > >
> > >  	if (usb_disabled())
> > > @@ -81,7 +82,8 @@ static int uhci_hcd_platform_probe(struct
> > platform_device *pdev)
> > >  	 * Since shared usb code relies on it, set it here for now.
> > >  	 * Once we have dma capability bindings this can go away.
> > >  	 */
> > > -	ret =3D dma_coerce_mask_and_coherent(&pdev->dev,
> > DMA_BIT_MASK(32));
> > > +	dma_mask_ptr =3D (u64 *)of_device_get_match_data(&pdev->dev);
> > > +	ret =3D dma_coerce_mask_and_coherent(&pdev->dev,
> *dma_mask_ptr);
> >
> > What will happen here if of_device_get_match_data() returns 0 or an err=
or?
> > Shouldn't you test for that and then use dma_mask_32 as the default mas=
k?
>=20
>=20
> I'll update the code to fall back to a 32-bit DMA mask in that case
> dma_mask_ptr =3D of_device_get_match_data(&pdev->dev);
> if (!dma_mask_ptr)
>     dma_mask_ptr =3D &dma_mask_32;
>=20
> ret =3D dma_coerce_mask_and_coherent(&pdev->dev, *dma_mask_ptr);
>=20
>=20
> >
> > And if you do this then do you need to add the .data fields to the
> > existing entries in the platform_uhci_ids table below?
>=20
> I've added .data =3D &dma_mask_32 for the existing generic-uhci and
> platform-uhci entries so they also work correctly with this logic.
>=20
>  +	{ .compatible =3D "generic-uhci", .data =3D &dma_mask_32},
>  +	{ .compatible =3D "platform-uhci", .data =3D &dma_mask_32},
>  +	{ .compatible =3D "aspeed,ast2700-uhci", .data =3D &dma_mask_64},
>=20
Sorry, I think I mis-understood your request.
I will update use 32-bit as default.
	dma_mask_ptr =3D (u64 *)of_device_get_match_data(&pdev->dev);
	if (!dma_mask_ptr)
	    dma_mask_ptr =3D &dma_mask_32; --> default

	ret =3D dma_coerce_mask_and_coherent(&pdev->dev, *dma_mask_ptr);
	if (ret)
		return ret;

And only add for aspeed,ast2700-uhci dma_mask_64 in platform_uhci_ids

Thanks a lot.
Ryan

> >
> > Alan Stern
> >
> > >  	if (ret)
> > >  		return ret;
> > >
> > > @@ -114,7 +116,8 @@ static int uhci_hcd_platform_probe(struct
> > platform_device *pdev)
> > >  		}
> > >  		if (of_device_is_compatible(np, "aspeed,ast2400-uhci") ||
> > >  		    of_device_is_compatible(np, "aspeed,ast2500-uhci") ||
> > > -		    of_device_is_compatible(np, "aspeed,ast2600-uhci")) {
> > > +		    of_device_is_compatible(np, "aspeed,ast2600-uhci") ||
> > > +		    of_device_is_compatible(np, "aspeed,ast2700-uhci")) {
> > >  			uhci->is_aspeed =3D 1;
> > >  			dev_info(&pdev->dev,
> > >  				 "Enabled Aspeed implementation workarounds\n");
> @@
> > -189,9
> > > +192,13 @@ static void uhci_hcd_platform_shutdown(struct
> > platform_device *op)
> > >  	uhci_hc_died(hcd_to_uhci(hcd));
> > >  }
> > >
> > > +static const u64 dma_mask_32 =3D	DMA_BIT_MASK(32);
> > > +static const u64 dma_mask_64 =3D	DMA_BIT_MASK(64);
> > > +
> > >  static const struct of_device_id platform_uhci_ids[] =3D {
> > > -	{ .compatible =3D "generic-uhci", },
> > > -	{ .compatible =3D "platform-uhci", },
> > > +	{ .compatible =3D "generic-uhci", .data =3D &dma_mask_32},
> > > +	{ .compatible =3D "platform-uhci", .data =3D &dma_mask_32},
> > > +	{ .compatible =3D "aspeed,ast2700-uhci", .data =3D &dma_mask_64},
> > >  	{}
> > >  };
> > >  MODULE_DEVICE_TABLE(of, platform_uhci_ids);
> > > --
> > > 2.34.1
> > >

