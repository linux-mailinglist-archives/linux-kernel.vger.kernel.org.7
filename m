Return-Path: <linux-kernel+bounces-818017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ECEB5B58BA8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 04:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A093A4E000F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 02:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272B620F079;
	Tue, 16 Sep 2025 02:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="qjuek8yx"
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022123.outbound.protection.outlook.com [52.101.126.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56041367;
	Tue, 16 Sep 2025 02:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757988267; cv=fail; b=CLtYEWWh59M+UeboojJBEjhlkqpK0UncTTQwFIv2INmfO/CrU3bnY0KW66VfcFKaBSBQ9pNoz/OpQ7psv203IBtBfd/EclNRxdCNF+5o6WhOXgUZgAh2tMbE1XlMf3ecoM7lTKxXVQ4I2rGs7s2EJTLK2Q2d51wORZ8lhnvQAbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757988267; c=relaxed/simple;
	bh=ps4uTmMjDs9NITxgBkpwD01Y+o7lfN0Ub6Ht0xF4JeY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dbTbu9MmtzrdEzTawJCNTSWMEYaezQ0PKmDoA1g99OQd2GqSpzeQfI409Bn8OhkhAO+zLsGFa3Dzw3DcipKI+psTiWrdyJtdTyYRDH5RmA/OHlnqzlujdsO3kvjo7joSWXeN7GUmIcNTlfjLdqqRt9IMZ/Tlg0dtoLTP5HZSynQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=qjuek8yx; arc=fail smtp.client-ip=52.101.126.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oW30yu6lifxsQ46eUPCB317uH97seRDQt/MM31DbQoVsAEM4wh87eS/sfFDGpxdVX2GzGJ6e1kzKbTqVQWIGV31JkfmwUDdd9pGRyYN6TVbpX6zrfBHe06MYmhZWsSaeJoipSfrccHPzl3ZyBVD22EJkViE45SVseJe3tlVto+7pM/o8TVusOyULtvUEJAKLOtRf5lRZ0TsWGT8JNkAEuNe1DZbG0xswf70nKhqYey2cw4I15W3OFyrJtEYCQ/0Iy70Cyo84UvrGejra9hV/HBIuemOb9jRBoUo9QRv2zKxDkJV4I/EPwkldDfDXfZkiGX9lC89q+nqMvpyAr/rZKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8/O3jMUaKXiDlqJpHuvY4zPzKmtckjADwp5DUqbHZiw=;
 b=tDVP1CtQ8iamaqYTzG29T5+ywAA6EkEu8sXClZ+qpeIsM3mZJjvIbnCWVLdGIaYWCHBNtM2qVmfHsKbu9f38mRMDsinEw5xFoVh4jQXUH4Nzd+mDFPL92fQTuuF9pBwzGXDGk6f5O85QGV1gX88/ouEvq+zbOurxMNX76CbEqlKFtW9WeFW0bBxkaRsGFVX8zAAyubLk5PVWGKdgUumodTvwbvX1qLuOg7lQyvi/lt15WhHAnuXVcDiGSpx++BB2ijgeHSJyJ1D5sPD6OlM1ERq8dv/0u9CWDtSeLt2f6nZg4eZCluoKsivR0sSs0DkGOmkEtLfCCOs27WHtYFH80Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8/O3jMUaKXiDlqJpHuvY4zPzKmtckjADwp5DUqbHZiw=;
 b=qjuek8yxBdW9LIWTW4P0O2F44ltKxVQ+4l7trRHHvcUc0moN0VtZhCVAzoAch+C44tnwuIBqusgWeJ1IpE1V+819TPPU5ZE/DUOCHwg9ketsb/tQXkZt91VYgmvZ/HB70tOO+oBxX6dm92GvKra+Q9dvYGlhX5Af5nDU6Ap57k7Bqs+VmOrA3a5btKZ5jLM5g2POpUcF0VT2JCxvoTxFIS0qbyHz2E1H46UG1rstGhukYSziGdUYqdH3tyKNC6hEFvtVevRi9DxvDmo/CCqEKs1Ci0j/ufMNBqVvvqzsdUcGz2SzT/WHbQDVN9BYwzVN4F2m6ngKhyD1ivYDNdYkjQ==
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com (2603:1096:604:2b1::11)
 by TYZPR06MB6328.apcprd06.prod.outlook.com (2603:1096:400:363::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Tue, 16 Sep
 2025 02:04:20 +0000
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11]) by OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11%6]) with mapi id 15.20.9115.018; Tue, 16 Sep 2025
 02:04:20 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Conor Dooley <conor@kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Philipp Zabel
	<p.zabel@pengutronix.de>, "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/4] dt-bindings: usb: uhci: Add Aspeed AST2700 compatible
Thread-Topic: [PATCH 3/4] dt-bindings: usb: uhci: Add Aspeed AST2700
 compatible
Thread-Index: AQHcJhPiKmhtXybkdUGOA1Z2FmFS6bSUggUAgACOBYA=
Date: Tue, 16 Sep 2025 02:04:20 +0000
Message-ID:
 <OS8PR06MB7541EEFF4F1F9BA788F2BF13F214A@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20250915073926.3057368-1-ryan_chen@aspeedtech.com>
 <20250915073926.3057368-4-ryan_chen@aspeedtech.com>
 <20250915-whoopee-badass-a748ee552ae0@spud>
In-Reply-To: <20250915-whoopee-badass-a748ee552ae0@spud>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS8PR06MB7541:EE_|TYZPR06MB6328:EE_
x-ms-office365-filtering-correlation-id: ec92c092-8208-4a0b-2841-08ddf4c559b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Kzrhto681mI01fhs4ScVF6yl72bU6dayIq5EEpT5gFAP5cDsvjE7SzPX1bEK?=
 =?us-ascii?Q?DqriJ84fyi/mdq8JY+oPPJmjpLXK64UxhiVyREipRWDWx8G0DEQxwWci5fnc?=
 =?us-ascii?Q?T/wbICLtcMpY+AiBLU4/4I1GNxmx0RomAxVEEP8NXRkDtV8fOxUxbuyJzjXP?=
 =?us-ascii?Q?S4e3FqWmxof67gpEMyU8CHKDo1lD/4Q0wkpI1EMB/91n9VI8bTQ4FYJa/Osy?=
 =?us-ascii?Q?h/KxCZY9pZLkNfOoZ7qOpOTGZ4FN5EzGDJB5vvgd1gFYd+vg4O1NcLHfRon8?=
 =?us-ascii?Q?2qQ5+oVdWbPOuplOiJ4FMfH9mGw3kxr3/pHrB9i+B59vvqK81c3gsbztMeBE?=
 =?us-ascii?Q?ynk2+OlSFun8rXmbR4v3AJNFEchUTje8OI9gFUMqRgCEtU0utcwwbyIPYpYG?=
 =?us-ascii?Q?AHXFhfJke6V3a0BVsf0/iWaXwFNGqHWQ+fzPwAMILDKHy9NU0QiDBvwMTM6B?=
 =?us-ascii?Q?7wesl4c9mqeKis1tcIFnGMHuaYxL75x8OUq64NGBsbkscc5xmaPErlOLsRo1?=
 =?us-ascii?Q?CwkbhHuXNkya1WFPj606W5KrQDEb50oYjXtVwYBvv5eM7sxV5Ll5E2wc0mem?=
 =?us-ascii?Q?4YGr9ulUDflY/Mf2jGYSAABE2u5YxcMKCFVjodyavTpNjNbpVmd67YVtKYum?=
 =?us-ascii?Q?s6mkHS1TQp08+6K9dtq3OVljdflya4AYjpJsok6xZ3wuxuOI4BsRFTxDJUXM?=
 =?us-ascii?Q?2tJ+oPn2dSCHMxxfhguPSSLLFI1YY0rvanMlAB3y6qok/RyxSharTWh1RAaf?=
 =?us-ascii?Q?T8c9ERwCHrOf/poOcbq1ewbUmZS5kuNwbtU65LOqPuJXkpOjRyrSmav+pM/w?=
 =?us-ascii?Q?XifEIEyJ0djVGKXYy7sxus+31F6NPVQdKtB9eTbx+U4LVFJylSw8OOjp3bUO?=
 =?us-ascii?Q?2zQIeu7Q/0AVVl+iRIKUe1s690yyhhYsHcqtNoD9z2466/HQ8d/dNHwwZQTc?=
 =?us-ascii?Q?BobTtWwwNrVqOj3iRaOlgRwLnO6jJ2QH4v2vyfSLKE48aV9VjLbizvgNvfVO?=
 =?us-ascii?Q?T7Ns70R7oevgbgq9y896UcVBtYUfPtlvmKpFKAI/oLLViU+t8BHgpzgzjCdt?=
 =?us-ascii?Q?5HIIXmT3ZT1MdlCy08FbpGqhbfp0TG5cp8stc4/ZT7JmTWDmwIx0by3xlTCP?=
 =?us-ascii?Q?M5AUQrngcunyT7XR7xwJN2WMlIEVxou9hR70N3q4Xwsf1n0uO5uU/WnyNZAt?=
 =?us-ascii?Q?1PNje3lxjLAKZcbjjzQvXGxxtpHeq6XO+kWIdwpdoz8SR3jCXrvaPCSL+jXe?=
 =?us-ascii?Q?4g7fkus7ybD8oK8M/NEkddOoaqUejcQIXzxxjygLDmvu8eqmlXzK/n45v+9i?=
 =?us-ascii?Q?zGxqegFkwj8exMICPVIs8lmyTSuuxrPWsPQjSLV2Ha4LBVwbXjY8HH31LvQi?=
 =?us-ascii?Q?z0D6qCM7t3CFZzfAHR2lGKCKaRLLxJH6GtPqc+UuLrAX+kCD6de93V7DG/44?=
 =?us-ascii?Q?J+Wd2hirVuA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7541.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?cjYQ8XPKz6nLue3U4C368i5HTc3CwrdrwwuTwLoMitem/Qj5Uu+ZALvJVrWN?=
 =?us-ascii?Q?WTK76suNChmjG/U9XXMDkC7EbZj4t7u2B8w8dGHTLIOz2sc1WSPRdbZSfg3Z?=
 =?us-ascii?Q?49yrPD+B9HBWkVvrWAyRfVtvr+VJ6OIyRrZQ8odDP6dEdBvMn0cZUYu6g6ao?=
 =?us-ascii?Q?ppk5tbESSRzK72OlC9aZgfin6wfomZo9ZqoixlHPrs1+yMziJ1AI4T3MvF1n?=
 =?us-ascii?Q?JozL4Qf6jO5IhcgJaEmCUpUl5Ft8FJx7/4p1hnVCeOxuX1kKMUwMX6nYQuEk?=
 =?us-ascii?Q?hvKvviwtrycu1QRm8q6WT8QNn7FcfgffpBKel//wvz6UkG4x+NXV/u8aoCXt?=
 =?us-ascii?Q?52c/2I95I6ZTPuOdQLKtnV1vCxOW/Zy12KWiXRL6Qk/1MxBJTbfUpcTDINb5?=
 =?us-ascii?Q?nQkB4WpCqXHcCUgNoB8uQZ3cmObP3NOM3rBheuOnw3RBz84bdOZiYwBE9q2Z?=
 =?us-ascii?Q?NRoWyMMGzqrook7GOKJRGqWWf4BgIHIq/Oq8X1rEl6bmC6vfJzJdioto3h8V?=
 =?us-ascii?Q?4iTsig2uosczKEA6mD1Q4y/rVy6ewKw9+0a4zu2LoHJD1bZTmeTD/XIf6WjA?=
 =?us-ascii?Q?8BMcgnNEm/iKINYLni4Ly9FR+7mBJP6dyonM4gpL/rDcU/VMfRKmDXPFgQfa?=
 =?us-ascii?Q?tNW2vVnZ2bGc9reORLXSSjWm/GGxKawHL1L7wwdYuibvKxMzAHKhcjN9zCSs?=
 =?us-ascii?Q?uTf/Ej0+UotkPc32RpTkjZ7sIATjTqoK/IKa/tOdOs7P/2M6Etz0eTOI7Oa/?=
 =?us-ascii?Q?qaTI4TiL3gLoux+mnu5df1Bx0G2d2n5SzM8kcTH/q4wd1d2y5j8iWyq7bwB4?=
 =?us-ascii?Q?CaeGc+PbcYYL/XK4GMmpYBdPlG0Da2mFm66fCANBaW9B2KOGUkKqG6VFHDbq?=
 =?us-ascii?Q?oSC8t3TTyvYy+MFawA/Mzb1aNOZ6/KmcYz686jDSvPXy7ifxRYsD3cmJhfKa?=
 =?us-ascii?Q?6au4zVBZVyXUA0z80929L7QfwShxgYf0O/eE75CBIeEPoUlygwfLMjTQDjSL?=
 =?us-ascii?Q?iVf/c4nZz9KU7Nzl5ZcawJQ4yW/87tx04CS2m4nLEOYKg9T/hK3Za4zoMhqq?=
 =?us-ascii?Q?r6sYHNzcmAt/0l5PgMfk8pCxpsrma7PYxhkc5vDgwYTGuyK8pbTwcPZ53PJy?=
 =?us-ascii?Q?OiNepz9X8TZky6jJXbv3b+5H5rtvq1211Re3xLMBZgNDpDvyA//uVRJOyXQw?=
 =?us-ascii?Q?uqu5UJBdKG5Umt7M2HuKYmOXrZ6kvXV89LOpuzb72adY+T7IcrPEdzljTpBM?=
 =?us-ascii?Q?4xf1+shUznO/CYy77SCFI+8sY/Ohm1dycrbwrsDNxETdQtqCkKe1BMXN30sS?=
 =?us-ascii?Q?3yQOvrjPWcjy5Q9A3SgKiO2aN/95EXKuUWGaXuuFSsVFFzi3rv0afK9BHG+r?=
 =?us-ascii?Q?q9bLwSpoi13EW0us/FoEQkwZXl+wZG58q0DmPo2zY2GdwvyzQqykbYQYIYFw?=
 =?us-ascii?Q?sNFvvgq14HAQ3cdBmmiwxxFMURmhE1/7zVR10cvu0VzOX5nQfhHZciJMSXCI?=
 =?us-ascii?Q?UCio3GA4m6FTucQw7jWFyrdPrxUMYyR+JyVgz/XkuWXUIFt0lElNjHePWakS?=
 =?us-ascii?Q?kLG8S//UNkYtEYdh/vmdSgSx+zuV69WnLgGrJsUF?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ec92c092-8208-4a0b-2841-08ddf4c559b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2025 02:04:20.7443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G10VbzW5Qk5z1zpicSllu3zQKf9CTEMMO1iFRcDWjUVWXm5J8lqUcseZiWBrNCtsBp16m0kJCDfHR7meny39kxR7Sm7tBLDmVJRa9LNqoSE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6328

> Subject: Re: [PATCH 3/4] dt-bindings: usb: uhci: Add Aspeed AST2700
> compatible
Hello Conor,
	I will add resets required in this patch at next send patch, is this ok fo=
r you?
https://lore.kernel.org/all/OS8PR06MB75419B97CDB5EA24560FB9ECF214A@OS8PR06M=
B7541.apcprd06.prod.outlook.com/

>=20
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

