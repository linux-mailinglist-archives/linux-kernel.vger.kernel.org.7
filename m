Return-Path: <linux-kernel+bounces-730939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E57F9B04CB8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 02:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 242A03BD650
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 00:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA2272600;
	Tue, 15 Jul 2025 00:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="dkRDyiiR"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA06DF76
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 00:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752538512; cv=fail; b=KwBhUDR6le/GCQDmHtfAl+hnb/TU0W6CmAjLn0ZY49nHND4SvTFJF09H3SQmmL/dpYkED2xGnW+gAgCrcGJpKJjGFNYSl0n3ZU65zpxZuCXFOVQFYHt5scQdcfClzk/qrIqy9FM+u3+vyc5QZZaLg8o/iIeNr2O1xACzvdNmS4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752538512; c=relaxed/simple;
	bh=3ZEXTJc+BJxu8wWIner5EdvdclOMQTx/m4PdMVjNo+s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Vh7j3y4UNDAEqjAp0I4fIwUA10NF3mbsbIr/DfGJBH/Pjk5ao97Ltpw8DZQNX2yn/ilbdKEj+31XwjSP3q91PpjhHGNE4OS5/mQBLzQQf1ZrhsZ2At+Nhmh3qtwY6wAkyTbuhDX2YX5jkLShZHYvtuOMry0lwrlfB67alWMTqiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=dkRDyiiR; arc=fail smtp.client-ip=40.107.94.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ljZhSiCnl1G8KOD4Cf7Dq4KMEGKl1RRzveq5LPaji//NQNWkF+4e2xgT7yU80Ye2/YGNqY5wdyvLt7Q5nL0MSOALOZWOjTMD47Bi4FTh4jSaDfTRZBids1IYCa1/PCUE4n1ZkSMICloS5X6rHrQLESshlVOCNf9BetyOwxkWXEX/+GYQkUwGTeh9oNtGhdYHXktc1Ze2fQzeES6PBNhOJb2yNeqJ3KveaI4HRM8+/fw/ShiNdf5aixkDddoA1673ucKO9DJf5Y/YcmMjffhFEUPTIzR2/9s9xmnt6ic3grOkqgItIdaTpDHGn1ilADLyEFDLwemolCgMBaX2fY0OGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ENXR/9YlwsjZ8HpbJQqE6VIt/dyRNttMYZB7+yAq6o=;
 b=g7F6IoA1ZkizMkyEEh69LjL3j9dRDhINsualHE1UHDZGqURdOd4GHO+mJjgIsTxIkVNwziHBg8YTI7wLSN1lJ5u9iCEYTjVRwf1IZ8FD4Tt6qVxgOhwO1v8c1CXzNJSWn/N2aY084yeYWbiyINIZGApL/TEaGFSDMtP9u47KP+73chpHzhKcYiMl0nh0gNCCOkyJvSNkkdWtWrzTiQowSlHVEl0oFmJl60lpQHGmNQgIXWsaBemkpq+rl2aqxzDiiI8oWsO1Gdb4LSeLCQMxxW2QPhUdpZ/8N42BSCpjG86clw13DulGZwi5tj4Gy1yEjO++weUzfp/HxTwMXjbeRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ENXR/9YlwsjZ8HpbJQqE6VIt/dyRNttMYZB7+yAq6o=;
 b=dkRDyiiRtkCHpKUrJSgjrRmhGC5Lh2/npM75mxzg5UfcdUiRgRDCXwKgt5NtoYjwKz1efUOIMIycGEKtcrwo88HJovESecE10PsGptiFVlSKyhDAAKwTHAhodmWbszGs9hRa2SFD4p+pOW+5Rssnze1lr/XMqTfNkRr9+NbIkvMqVPiN7wC95EmdN1akPci3z+yIb1twFP44oXR8SAAVPm6ZLAEjjAZG5IjeMNjmtg/2bJS6I0AUtfbTxoEc9AXymfhs04CQAwPbUzBmjlcF6zBUaycXqe0VkyS8flmOogPHmEYSYdXE4ndWiIWAPuW5x16VWG/5p53TFWC6Ubmu+Q==
Received: from BY5PR03MB5299.namprd03.prod.outlook.com (2603:10b6:a03:229::12)
 by SJ0PR03MB5790.namprd03.prod.outlook.com (2603:10b6:a03:2dd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Tue, 15 Jul
 2025 00:15:06 +0000
Received: from BY5PR03MB5299.namprd03.prod.outlook.com
 ([fe80::b106:261f:6a67:9615]) by BY5PR03MB5299.namprd03.prod.outlook.com
 ([fe80::b106:261f:6a67:9615%5]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 00:15:06 +0000
From: "Romli, Khairul Anuar" <khairul.anuar.romli@altera.com>
To: Dan Carpenter <dan.carpenter@linaro.org>, "oe-kbuild@lists.linux.dev"
	<oe-kbuild@lists.linux.dev>, Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger
	<richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, "open list:SPI NOR
 SUBSYSTEM" <linux-mtd@lists.infradead.org>, open list
	<linux-kernel@vger.kernel.org>, "Gerlach, Matthew"
	<matthew.gerlach@altera.com>
CC: "lkp@intel.com" <lkp@intel.com>, "oe-kbuild-all@lists.linux.dev"
	<oe-kbuild-all@lists.linux.dev>
Subject: RE: [PATCH 1/1] mtd: spi-nor: core: Prevent oops during driver
 removal with active read or write operations
Thread-Topic: [PATCH 1/1] mtd: spi-nor: core: Prevent oops during driver
 removal with active read or write operations
Thread-Index: AQHb8HEWd6E44iO/WUekBLL20IMrdbQyCncAgABOzJA=
Date: Tue, 15 Jul 2025 00:15:06 +0000
Message-ID:
 <BY5PR03MB5299B38CB5D3A3D14428698AC657A@BY5PR03MB5299.namprd03.prod.outlook.com>
References:
 <e439e6b85e650a91607a1d02d5d432d096363315.1752024352.git.khairul.anuar.romli@altera.com>
 <2bf9baaa-e66a-40ba-96b3-44b2e5e78550@suswa.mountain>
In-Reply-To: <2bf9baaa-e66a-40ba-96b3-44b2e5e78550@suswa.mountain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR03MB5299:EE_|SJ0PR03MB5790:EE_
x-ms-office365-filtering-correlation-id: 1d7c5388-131c-48fc-6d4c-08ddc334a6fa
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?66Jy/hptczXBJ0BGE0A8QchTqBu/pI3rIl3Lfk1cnNner+ZLq823r67XQBHW?=
 =?us-ascii?Q?ei/ZZ0tq8jm9Tk9rGmcdjdlyfseH+RKZ0xmXPaExVYFzD8rlibsnt1JhDK7r?=
 =?us-ascii?Q?fQC+OXBVEWXrwaEpJp2M+bntlP020vj1zD6SV21dcybZhBhwbR2L72Nihn4U?=
 =?us-ascii?Q?9M09ajTrpKhLVm5+7AScy7yklB5UWuBuxqCKSErp2GtXo5e1YOqPysT/pW4N?=
 =?us-ascii?Q?gip8X0ydUPogREmYfiMIJHLKcvz4Db486LJiLtrjMZ9J4KUYJM+mPT934EDQ?=
 =?us-ascii?Q?Lb68JdeS10oUM3wFvKe9ryEgMwqkG3fMztwvyvkWpZwJPlgeu3rZkY+AClag?=
 =?us-ascii?Q?vL8gVZU1DIYYUJGWDmsLLobNAH2TgKNX8Z6RZZGpNALX8FsvotS1N40GTpKB?=
 =?us-ascii?Q?GxhItPbIDzumQFkBnyyIrB40SJGUQtf6kJ1vRtJSOXQo3SJdCCo8hyYKFDYN?=
 =?us-ascii?Q?g9KsPP44bBKwqGHajkK1lAdBcteuWlGYZS9DIJf2ae3BVefVJA+ygYo8AZLT?=
 =?us-ascii?Q?SvSV2Uee6BL/T5Ph1WBbD+mzmdHfMVy8HlHJLLSQkopbuGccK0+IQ6kfJDBQ?=
 =?us-ascii?Q?QAHLMcKrfUogd+SNfePZpj0q7Pxlm4Q9UgPJgx1k2so2MGF5g5COSl0JofS3?=
 =?us-ascii?Q?IGzAXCScSdxC2B0WlFynFB7RvVP/fuI9wjtFFUVDIJSyG4u4ox1YLWoxLtQ5?=
 =?us-ascii?Q?FzAcvVDeoKwC/HHrwXKb4pCpDKt9yZ6PxuprI58Xy/eDgVwl26IWaQ85c57z?=
 =?us-ascii?Q?iOvPrtdHMECbHiBM73DFl0/7GST0XTHszRvznqpoQKo47vNTr5jJ+v6F/d4+?=
 =?us-ascii?Q?aLTrJlLSvhV3LtUdjCDeOdbo8/iX4+pAlDdnKgSf4KNLw+zaB5wEMyR1TuFX?=
 =?us-ascii?Q?na/nzXmh3XYwjJzk4gYstRHgDIZtzb+F0z5br4eyBbhD143D2fmlT/gip8JX?=
 =?us-ascii?Q?HnXnuQMq5OIYXxkWIe3IL/uS0IpTxR81bJRqcZ9iQq2/3BizhTkYjryEtRdL?=
 =?us-ascii?Q?CtcDV3Q+SLn7YY2MWeiMabrLxvFDAyTqljB9UYmxzDV3WgsPh2iljfcSNbCX?=
 =?us-ascii?Q?IwNOZSPOuc7Z/xxi28urR2TrK8uC+siCopVytD2RyfD/psKXTd2lvUV0AkiA?=
 =?us-ascii?Q?NEybgaGJZXqWRFUBWlhgFi/Ap36OyrKA49GSM3w/cwUl5UQqxMwscgFju8LF?=
 =?us-ascii?Q?dHgGsgHYT75ViGrgUDDRmyKjHoz4h5+w3aVwY5wa2SfeeBLVOMxFeFgp2nop?=
 =?us-ascii?Q?h1j0su/Y9ZAL2cHpuVcLku5BJFDwQTzPifOcxXySC1MlcNlTOysomTJS9ONT?=
 =?us-ascii?Q?6PEFL4iaxSPJOdUjSgbyAq9eCQlS7iC/lmJnHelkl7SZvaHJ16SRhXBLhY0F?=
 =?us-ascii?Q?4YKY4HmjfzNWaYmh51DFN+N6CaU0DgFm5p3e3QJpnmsExWYVPPv4mHHpBUoz?=
 =?us-ascii?Q?e6x0Z/DQ9ohVX1lhiS1GK5Pq8LQqUeS4?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR03MB5299.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?vejU6IRTjKOQbLg03z1zkPMM/a3JmX2COumMRT3owPh8GbjKAI85s2JyuERv?=
 =?us-ascii?Q?shLK51ikfK4dWDeSOB8jl5HiVJGF4TOfQkFFWfr7U1G2lMdMx26TGhB5ic0L?=
 =?us-ascii?Q?d4KRxhjp6EjbpWg7TIeceQV2Ep110YPNu3Rq1vkYkav87rzQbea3RkOxVnSe?=
 =?us-ascii?Q?D5mXzBn0HKy67bqN+qYXNR1hup8lKdjjkzA9KfOEISYrXKlj/2KGBa+NlqRm?=
 =?us-ascii?Q?bv/XGtp02k2rxoT8qidzW9rTSjmX66ExDeHO7h7AMjq+OcHnwFhIg6V3ml++?=
 =?us-ascii?Q?xCcRnB0FHz+eaK/wG82UMNmTaL4g9UmHLlL+GFFf4dKxJiBVJmGz1WtxFXBw?=
 =?us-ascii?Q?ssF9lrpXTTPfepDpbbtUxI5iEn0bJ2e5Ut4AUW0OPmo+XCk/Yv8rbn4YPVFO?=
 =?us-ascii?Q?OZcJsXbbBJFHF+tpS6HbFjOrDM/ebs4j0QCHUJte23uyeObanKueK488Mahb?=
 =?us-ascii?Q?RXpDUddxcZRcWUwubBz+Uo1HRVMr4J/RW0rmMIlePxI6wp1pAlcK9KGSXc7F?=
 =?us-ascii?Q?PblZ3++vpCN6lNVTg7+ao34M9k696LV90tEtyXgCqibFD36KjxPaB6mJiLIy?=
 =?us-ascii?Q?/pbvzfVh7ELSXGFU0aDGit1oD5lA1tpPnJFL+yoGL1Vlzpcd75PItAoBp3Tv?=
 =?us-ascii?Q?mR0Eoyh3IeQ5uY86osADjOStHjTU01jv1n7XjyzsI9BYnLh5BogOMcT172mL?=
 =?us-ascii?Q?HgLgyRIVr6YPx2dvuGNZVepTgVen3QK6HANwzDwGqiyXAyWJyjIZhiGcmLle?=
 =?us-ascii?Q?Unyi5HzzLVbasrFJG7/fndI1OBdxtQz7njIlMM7J1AdbSBEyftfmhbcleELL?=
 =?us-ascii?Q?tjuu77W6GZbcS4si/zE30P2vlSge3g+urApXj/qG+GCCrvwIMgrBtto3ZXWv?=
 =?us-ascii?Q?BAMZ4o9PY8h1cWRm2SXoW5W18sQ9rdS6aZ1aDiNIVPDteK5ry2B+ns9QQSLf?=
 =?us-ascii?Q?NHai2ynqb9unb+76bzY8j1stdsXIXgEauph/d1GCVpICy0XNNJwc5jP0qnHH?=
 =?us-ascii?Q?lWJXKglwbzONdomB5jsRIb5+Uv+CzHMY6qIhI/xqqi8CsbpZZiGRiv4RcSzd?=
 =?us-ascii?Q?GEeWCk0hzNyrq3oc5iv94F2N2T8OTUH6NrpeVushID5TLAW3DY6k0jDtMA21?=
 =?us-ascii?Q?4P5jP3ZVQ+aiVqLp6Qsx2ARyZe7dZYRd4dEKXmBBbMwU5wywyqprC1+v8Xyi?=
 =?us-ascii?Q?vfkXgHaodGbf7y9ah2RTHyysEgnPRUotOGvqm7Up0lLWsP/Xx7l7QwyL8LXM?=
 =?us-ascii?Q?xTBmZbfxybVZTaSnXoQGFkXmprXmu8wqLrn74avGAjxj6kQXLXzp8nd6Y1ft?=
 =?us-ascii?Q?k/KVXJreE5F2MyGERG2jCmDfdg70cxMN+e1B/osW3C+4cC9DNpOQNXvvJIHP?=
 =?us-ascii?Q?brIzFzJJChHQm67VSy96j3ozcM5sxLrEUjr6rkP2OrXZU5GmLDMSf62+Jr/f?=
 =?us-ascii?Q?/1Pn/z3+9g2VOUAo6TNC8g7clN7XcZ2Jk8hjH5kEwWWuIm+eT+yhnRNrrlxm?=
 =?us-ascii?Q?QDOQkGu6zZKYu4SP6FLGs8GOm7pCDWPiWDpv4J1nIypSNHxYu3IVZAo52nZr?=
 =?us-ascii?Q?ZgFJxUY+eCNz3aXVyqky8s8q7yvZYNlQolf3pcZ0?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR03MB5299.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d7c5388-131c-48fc-6d4c-08ddc334a6fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2025 00:15:06.3437
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T7l9ozYHxty3WE32K3a3bsnhrI6DD6QaHWqPc0QfW/gciK2tAWOgB9rAdAprsR+hnLTfq/8dopJjykcSFBfdqOIZFNe7mlansy4Az+E6V4c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5790

> From: Dan Carpenter <dan.carpenter@linaro.org>
> Sent: Tuesday, 15 July, 2025 3:30 AM
> To: oe-kbuild@lists.linux.dev; Romli, Khairul Anuar
> <khairul.anuar.romli@altera.com>; Tudor Ambarus
> <tudor.ambarus@linaro.org>; Pratyush Yadav <pratyush@kernel.org>;
> Michael Walle <mwalle@kernel.org>; Miquel Raynal
> <miquel.raynal@bootlin.com>; Richard Weinberger <richard@nod.at>;
> Vignesh Raghavendra <vigneshr@ti.com>; open list:SPI NOR SUBSYSTEM
> <linux-mtd@lists.infradead.org>; open list <linux-kernel@vger.kernel.org>=
;
> Gerlach, Matthew <matthew.gerlach@altera.com>
> Cc: lkp@intel.com; oe-kbuild-all@lists.linux.dev
> Subject: Re: [PATCH 1/1] mtd: spi-nor: core: Prevent oops during driver
> removal with active read or write operations
>
> Hi,
>
> kernel test robot noticed the following build warnings:
>
> https://git-/
> scm.com%2Fdocs%2Fgit-format-
> patch%23_base_tree_information&data=3D05%7C02%7Ckhairul.anuar.romli%4
> 0altera.com%7Cf6c3b8bb5b844138259308ddc30cd2ae%7Cfbd72e03d4a54
> 110adce614d51f2077a%7C0%7C0%7C638881182091182847%7CUnknow
> n%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIl
> AiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sd
> ata=3DeR42SdwIvE8%2BT3uUpe1WKz%2Fn0V4DNnLHExb1IPi1Gas%3D&reserv
> ed=3D0]
>
> url:
> https://gith/
> ub.com%2Fintel-lab-lkp%2Flinux%2Fcommits%2Fkhairul-anuar-romli-altera-
> com%2Fmtd-spi-nor-core-Prevent-oops-during-driver-removal-with-active-
> read-or-write-operations%2F20250709-
> 103107&data=3D05%7C02%7Ckhairul.anuar.romli%40altera.com%7Cf6c3b8bb
> 5b844138259308ddc30cd2ae%7Cfbd72e03d4a54110adce614d51f2077a%
> 7C0%7C0%7C638881182091208992%7CUnknown%7CTWFpbGZsb3d8eyJF
> bXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiT
> WFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DKJm%2FUt2CNwr3J2
> Gsoxd2oe36gitqmmby3df73UWsZHo%3D&reserved=3D0
> base:
> https://git.k/
> ernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fmtd%2Flinux.git&dat
> a=3D05%7C02%7Ckhairul.anuar.romli%40altera.com%7Cf6c3b8bb5b8441382
> 59308ddc30cd2ae%7Cfbd72e03d4a54110adce614d51f2077a%7C0%7C0%
> 7C638881182091223786%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hc
> GkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIld
> UIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3Du3%2FCugi1Z%2BobMTJu5qWFj
> 4tkjYr%2FgC4PGVt0NJvAktA%3D&reserved=3D0 spi-nor/next
> patch link:
> https://lore/.
> kernel.org%2Fr%2Fe439e6b85e650a91607a1d02d5d432d096363315.1752
> 024352.git.khairul.anuar.romli%2540altera.com&data=3D05%7C02%7Ckhairul.
> anuar.romli%40altera.com%7Cf6c3b8bb5b844138259308ddc30cd2ae%7C
> fbd72e03d4a54110adce614d51f2077a%7C0%7C0%7C6388811820912375
> 62%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLj
> AuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%
> 7C%7C%7C&sdata=3Dsy%2BIZORvA8IgYI5BZsHEQgoIH9wKyndszhYwQ6N7vzw
> %3D&reserved=3D0
> patch subject: [PATCH 1/1] mtd: spi-nor: core: Prevent oops during driver
> removal with active read or write operations
> config: i386-randconfig-141-20250711
> (https://do/
> wnload.01.org%2F0day-
> ci%2Farchive%2F20250711%2F202507110922.btkgvYrn-
> lkp%40intel.com%2Fconfig&data=3D05%7C02%7Ckhairul.anuar.romli%40altera
> .com%7Cf6c3b8bb5b844138259308ddc30cd2ae%7Cfbd72e03d4a54110ad
> ce614d51f2077a%7C0%7C0%7C638881182091250946%7CUnknown%7CT
> WFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJX
> aW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3Dzvj
> oJvmjeQnS7dTajwXbAB6GiqNwecZtS3win3Sv7lM%3D&reserved=3D0)
> compiler: clang version 20.1.8
> (https://gith/
> ub.com%2Fllvm%2Fllvm-
> project&data=3D05%7C02%7Ckhairul.anuar.romli%40altera.com%7Cf6c3b8bb
> 5b844138259308ddc30cd2ae%7Cfbd72e03d4a54110adce614d51f2077a%
> 7C0%7C0%7C638881182091264782%7CUnknown%7CTWFpbGZsb3d8eyJF
> bXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiT
> WFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DFYcm8fzKMhihgW5At
> oVRcGTCV56qKYNlx3uJpT%2B4DPo%3D&reserved=3D0
> 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes:
> |
> https://lore/
> | .kernel.org%2Fr%2F202507110922.btkgvYrn-
> lkp%40intel.com%2F&data=3D05%7C0
> |
> 2%7Ckhairul.anuar.romli%40altera.com%7Cf6c3b8bb5b844138259308ddc3
> 0cd2a
> |
> e%7Cfbd72e03d4a54110adce614d51f2077a%7C0%7C0%7C638881182091
> 278235%7CUn
> |
> known%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAw
> MCIsIlAiOi
> |
> JXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3D
> NMmQgJov
> | ArDDW9sbKYrmIdl3lTRLvDD2SNq10pYeQ9s%3D&reserved=3D0
>
> smatch warnings:
> drivers/mtd/spi-nor/core.c:3216 spi_nor_get_device() warn: variable
> dereferenced before check 'dev' (see line 3213)
> drivers/mtd/spi-nor/core.c:3216 spi_nor_get_device() warn: variable
> dereferenced before check 'dev->driver' (see line 3213)
>
> vim +/dev +3216 drivers/mtd/spi-nor/core.c
>
> be94215be1ab19 drivers/mtd/spi-nor/core.c    Xiang Chen 2021-04-01  3202
> static int spi_nor_get_device(struct mtd_info *mtd)
> be94215be1ab19 drivers/mtd/spi-nor/core.c    Xiang Chen 2021-04-01  3203
> {
> be94215be1ab19 drivers/mtd/spi-nor/core.c    Xiang Chen 2021-04-01  3204
>       struct mtd_info *master =3D mtd_get_master(mtd);
> be94215be1ab19 drivers/mtd/spi-nor/core.c    Xiang Chen 2021-04-01  3205
>       struct spi_nor *nor =3D mtd_to_spi_nor(master);
> be94215be1ab19 drivers/mtd/spi-nor/core.c    Xiang Chen 2021-04-01  3206
>       struct device *dev;
> be94215be1ab19 drivers/mtd/spi-nor/core.c    Xiang Chen 2021-04-01  3207
> be94215be1ab19 drivers/mtd/spi-nor/core.c    Xiang Chen 2021-04-01  3208
>       if (nor->spimem)
> be94215be1ab19 drivers/mtd/spi-nor/core.c    Xiang Chen 2021-04-01  3209
>               dev =3D nor->spimem->spi->controller->dev.parent;
> be94215be1ab19 drivers/mtd/spi-nor/core.c    Xiang Chen 2021-04-01  3210
>       else
> be94215be1ab19 drivers/mtd/spi-nor/core.c    Xiang Chen 2021-04-01  3211
>               dev =3D nor->dev;
> be94215be1ab19 drivers/mtd/spi-nor/core.c    Xiang Chen 2021-04-01  3212
> be94215be1ab19 drivers/mtd/spi-nor/core.c    Xiang Chen 2021-04-01
> @3213         if (!try_module_get(dev->driver->owner))
>                                                                          =
                           ^^^^^^^^^^^^^^^^^^
> Dereference
>
> be94215be1ab19 drivers/mtd/spi-nor/core.c    Xiang Chen 2021-04-01  3214
>               return -ENODEV;
> be94215be1ab19 drivers/mtd/spi-nor/core.c    Xiang Chen 2021-04-01  3215
> 240522762fc4bc drivers/mtd/spi-nor/core.c    kromli     2025-07-09 @3216
>       if (!dev && !dev->driver && !dev->driver->owner)
>
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> These checks are done too late.  Also missing module put.

I will send the v2 revision to fix this. I don't think we need module put. =
Module put
Will cause the kernel oops if any of the nodes are null.

>
> 240522762fc4bc drivers/mtd/spi-nor/core.c    kromli     2025-07-09  3217
>               return -EINVAL;
> 240522762fc4bc drivers/mtd/spi-nor/core.c    kromli     2025-07-09  3218
> be94215be1ab19 drivers/mtd/spi-nor/core.c    Xiang Chen 2021-04-01  3219
>       return 0;
> be94215be1ab19 drivers/mtd/spi-nor/core.c    Xiang Chen 2021-04-01  3220
> }
>
> --
> 0-DAY CI Kernel Test Service
> https://gith/
> ub.com%2Fintel%2Flkp-
> tests%2Fwiki&data=3D05%7C02%7Ckhairul.anuar.romli%40altera.com%7Cf6c3
> b8bb5b844138259308ddc30cd2ae%7Cfbd72e03d4a54110adce614d51f20
> 77a%7C0%7C0%7C638881182091292007%7CUnknown%7CTWFpbGZsb3d
> 8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkF
> OIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DSSQX73%2Bm
> m3Eqb6XaYih3tHM7sL5d%2Fuodt3DggYXTBNc%3D&reserved=3D0


