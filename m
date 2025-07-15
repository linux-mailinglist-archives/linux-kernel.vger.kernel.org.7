Return-Path: <linux-kernel+bounces-731404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB9CB053C7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 09:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D628516B126
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 07:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1CA272801;
	Tue, 15 Jul 2025 07:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="FGez9D4H"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2059.outbound.protection.outlook.com [40.107.100.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD02271456
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 07:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752566033; cv=fail; b=Rh44qFYbRA9K7iPSA1zV5D/9rWWf6cb4zMPpKvp35OK219/xP2pm9UxOjlONN0sHYqkLyeMR3GUDYAw+42VuP2vaDrpBPKgVlEQbnqAlrwo41+XARZ7dXOjYzKvZJuOyAyxV9ZbgOZBKebCl6dDU5T7RlqdHnr6gFISgYyVc60k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752566033; c=relaxed/simple;
	bh=5tcOnKH8918SNqcedEekgL8Ao8ttk+1mLLXY0KIppRI=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q7OYxTQ0b9byriS+worPwWfKA0r87ccfVRJXvIhZTsIfVjEj+71pkmd9iacmb5Fq4ra+4QwWAiGvGIoXzYBkFNrAdrg2HpCcCEWKv5yvLul9z3SFrAAX8k85StY4pCbbUKYE4OBgGrAe7o79chSc/OXiIidRurtAhixVzWhLQHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=FGez9D4H; arc=fail smtp.client-ip=40.107.100.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jstqQvKowU7XBpNCcUDRwgis09wXmdvdwBCWzi6DH/QBKp1zpO3dqlj8MFnQksGr2BNk9xwGbPxnyMoS6deENPdgg177Gq2nkRDR/f/vqAxTxYVVSC9XXRfVaEWdVV78SHsUkm5+AFs97pxWLfpYelRhbRoa2M7moYnr2DcBkGc3RjhHyLJqm51DPgKqVd0yYaZnLGaKG2O6l05Bi+5DpeJ9ubFZQr0uobAl5/hFofFeQ6cZXWoHb5PV7ZfUBSnnFpMkC+sju1W8eht4JfGwjC+Q5Qbhg4g86SIiJ5FSI7eId8SFVL+I36n2n5P/F27Q0Wqc7+6TgP14BKy/UZPoCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DiBZ4AnVMrWBppeCuGbncR/qJ3CfVfcWeqUSzdvnwcw=;
 b=RIsVkPPP/L6Lq1kbrB7zo2WdbZJZuxrhPVMxaBvZY8wc9QlU0mYdaMA7pPi5IxCHjgGu8QXRymmbKvShkBYrlkWjr59ycYzdAeAdxDc5J3cIpD6JDeWkQPGGCLZQpz4LgGQsqJMhgd59CyeYzlsNePgvZZZ0JHCBdJ69ximgS5qu9++/iGHG26CuBMjf+dXwvtCR0OTuZSFHhnGe3MxxQ7w2dfVpuBO+FLml/qVAI/cu0ea+BzlFkpgZuVCYv4PGZl+mIm3Eg3BtL27tx6sXHtDPMJivw6Z1Eo8owwALZrttYvRg5LbRYkracY69AbHUgltMY2lAWaRzbWZGIuSHLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DiBZ4AnVMrWBppeCuGbncR/qJ3CfVfcWeqUSzdvnwcw=;
 b=FGez9D4HaBRscs34fS+ABLgSnaSZyJ1W8wm0rzKPV9ItbMdbzK8njeKJoHkYv/2d9i44h4i/A3443kWB93K3fu1bVvxMvggkwkDD7SRkCHcnHjsr3wV1/tjV8Nk8+7lcJN4OpUBPaGndfrxEhOK+6w4CRPBu/v0hXySUdnG5WtHbJfWfGPhXGnFjcD/8RkA2m/WgJwrT6LkgB/4mC5I2t1bh7/LVyD9qS5zWt1xdRhYf0/UICWZoAbwH2Za2UCrNykvWallWRVYjWvdD2b7UctfHnaq4FVVn7wG28bqEF/QS3kvJDpWsFUP1S1RD/7D/OT9arzBL5P4JrxVpSuNDYw==
Received: from BY5PR03MB5299.namprd03.prod.outlook.com (2603:10b6:a03:229::12)
 by DS1PR03MB7992.namprd03.prod.outlook.com (2603:10b6:8:21b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Tue, 15 Jul
 2025 07:53:48 +0000
Received: from BY5PR03MB5299.namprd03.prod.outlook.com
 ([fe80::b106:261f:6a67:9615]) by BY5PR03MB5299.namprd03.prod.outlook.com
 ([fe80::b106:261f:6a67:9615%5]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 07:53:48 +0000
From: "Romli, Khairul Anuar" <khairul.anuar.romli@altera.com>
To: Michael Walle <mwalle@kernel.org>, Tudor Ambarus
	<tudor.ambarus@linaro.org>, Pratyush Yadav <pratyush@kernel.org>, Miquel
 Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>, "open list:SPI NOR SUBSYSTEM"
	<linux-mtd@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>,
	"Gerlach, Matthew" <matthew.gerlach@altera.com>
Subject: RE: [PATCH 1/1] mtd: spi-nor: core: Prevent oops during driver
 removal with active read or write operations
Thread-Topic: [PATCH 1/1] mtd: spi-nor: core: Prevent oops during driver
 removal with active read or write operations
Thread-Index: AQHb8HEWd6E44iO/WUekBLL20IMrdbQp3AyAgAj8m3A=
Date: Tue, 15 Jul 2025 07:53:48 +0000
Message-ID:
 <BY5PR03MB5299D68304D916F466837E6BC657A@BY5PR03MB5299.namprd03.prod.outlook.com>
References: <cover.1752024352.git.khairul.anuar.romli@altera.com>
 <e439e6b85e650a91607a1d02d5d432d096363315.1752024352.git.khairul.anuar.romli@altera.com>
 <DB7LJZF3AZQJ.2I5EWYORV6K33@kernel.org>
In-Reply-To: <DB7LJZF3AZQJ.2I5EWYORV6K33@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR03MB5299:EE_|DS1PR03MB7992:EE_
x-ms-office365-filtering-correlation-id: a838cf45-aff7-4c0f-f3f8-08ddc374bb5d
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?xoiFbSULF5FHA9jls5JLRFq/83gxVv8h0ZVaD6Qm57biHPkh9D3UBEFsS5Dk?=
 =?us-ascii?Q?rlNWf8VwpdaAijn58ekKcKW3hvSBZMFqk+BDOEb7oOPHviLCsipbEjVpRBhy?=
 =?us-ascii?Q?Pu5+YxS9keXARFeg+cY9uWPd0PV4/TlsqNpewtXH7pHpxcVqshRsR//YlGJ5?=
 =?us-ascii?Q?wl/6k99OINLPR+RTTGQYK2Cs60f7bHmX1feUc7Vn+uG4dJBtUMhTTYg0Fub2?=
 =?us-ascii?Q?KB56tfvi+dOr/E2Pt52sKvSUp/m/EWfa7RqxkfaM/zKto/lufRRemA1gi+AO?=
 =?us-ascii?Q?Cnq55QlTrizOtM4HYwym0jdtbTYDf2NbVrkBpJHUBzLQN8x1yfGYqsPFCQhd?=
 =?us-ascii?Q?vHapcXzzkv28vEx0LJTKgW3QfOHbKzPQ+mu7e5bN7cyP4KAcENZs6y14YXFK?=
 =?us-ascii?Q?EDiRlepMdH94V8tRvgHUjdTrMtkfiWiTELxNYLM+L9jXtbo9Nw6jaFZ4nh8t?=
 =?us-ascii?Q?+tx4B28nBxvFoxu08QMln11E9jISoJj/gQb8aizcAztg2ONfgaacS8oW+Z5n?=
 =?us-ascii?Q?CpapY6Xi3rNQ1wLQnQuDJYCsIc0WkFNUNidjbhUfBVhlvXi7ki73x9GbAEJO?=
 =?us-ascii?Q?bJwzSsdLopUEEqlX+gKG6WSsBj5Yrv8gB/tFWwIYq7duuYkiFpkYOqBMeDlQ?=
 =?us-ascii?Q?C+KFHdFC4e3WuPOFaIuEk1o1N/C0m2UdrpUB9JRy6sngNT0okCZ8/m9Q19Wl?=
 =?us-ascii?Q?Dq5SImAFjeEGlsaNArlaZKI8UaLPqm0p11Z6U5X7LnrSf2HuhAwdRP7rE05C?=
 =?us-ascii?Q?XkIJwm4F4Xkzv7nZPdC6VayFwTncnfC2idRI0FPZmLFyUzytSdyXeZRAERbn?=
 =?us-ascii?Q?E6il6wwIYUWfPpsI0wJgI032eNtEhs/6q/M0pLd6jdd+blNFT8MPhlTooFso?=
 =?us-ascii?Q?P5vyfnB1nCoqPF4J2rqk+P+LVcxO3qhoq6EEReadrENBW1UwAjWlncnM3pdO?=
 =?us-ascii?Q?dZFRXN1QxjxHKK9rP6yb1PO6kpjBIl/YLOdDTxkDeBGQmM+hjPToIin+L1mU?=
 =?us-ascii?Q?5fSLLiE4n7SGM4uebQSb437d5VP4abUKwe8UoltMbIY46aNhkj3tHy81l3mO?=
 =?us-ascii?Q?LtwZKcS3n1/YlOdwki65yapA4h1k28rWYOIIWkqMko8rE17Z0D8LPiDaOmO0?=
 =?us-ascii?Q?nt5dr5GJBog4Ao5ci/gKiREdnpL8K6NFzuM72dQo7TuIsCdPUz8Y+quwwkBJ?=
 =?us-ascii?Q?dM1NuifDX2DEUeYq61vLIOeMeZTmnjc4XshtTGJmPaEBwG6Jwc986e1ujzEi?=
 =?us-ascii?Q?joLUZ+N1CbbLTXVJpevvhOXLo6nOyYpjHDbfumk1ATn/qrJLSzepAtP/Qxf8?=
 =?us-ascii?Q?5/1aXijoJpXodFsxiS47CVXVExOjiKPBVzxxp0gRioXRmwzZsgIFty9tR4fh?=
 =?us-ascii?Q?Q7XZJfkS6ZPjZGm5ez9zWMXOmkDBqLyFjyT4YI+a8ERpfKvl5Gum+KADhpIs?=
 =?us-ascii?Q?0rKpf4BaNiujxro5+zPEJMTLkA3JuXssWr3AY9Omqp6ujyBUnmTK7YZlEX/O?=
 =?us-ascii?Q?8PVhedWBX7NXFwg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR03MB5299.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ZJum+wkfoYgphxn6aLYsxDDM1gyduRF0qMkQnx1IMUM12Zt6soSGxTZRpoa0?=
 =?us-ascii?Q?iRgtXir3ojdJr3WuVmI7ACs5P5U6NvNY/cVXwlfPbMcgljqBB9uC69CVtmei?=
 =?us-ascii?Q?8RupSIb3yWKZXnvl5v93fe0EUL/R9KoIxFI0vduFTJmi/1n1bjvoZ7sw/4Y1?=
 =?us-ascii?Q?RhEoSX3tLERq43vS2loUliGom10jDJ8rzwqbKyRLnVUfAMfoSEg+/EI6RMXk?=
 =?us-ascii?Q?+1scyiL4LjWqphIDSthPhfDNhhMmPbdDbD3L8uNcQzTzamGGumYC3quDOiL4?=
 =?us-ascii?Q?Bmgutws9R5F6rsjuj7drwhCXRsHjwFPtMwsDK1KV9BS+FEJrueNiAeQVwQRV?=
 =?us-ascii?Q?n/zYPAzoQvZRcmZaAOuRkg0crUKgcnboWJtUgEtwrCfs0uN2nBL59mP/9vqw?=
 =?us-ascii?Q?SFEHu61ceZ3DX2p3nUqPtph4V0Bv2+ECLpBeVBKskPnb50DaCyzjzLAqveLn?=
 =?us-ascii?Q?JN9KwxQPbWB8IeWTy87YNVdPUyr1ce8PvrT3mnWrpZu01X4E5gbTJP9e6tvF?=
 =?us-ascii?Q?BCZPfC5TALN0Y9xgfZnT0pkIaGZoUTFZx6FZ5O8EHQWefmx7Y7fgGptNi+le?=
 =?us-ascii?Q?UL8Diked3C3ummeXZHSUHuIMnktxOtjljQVxqlVDURNDKGrhETncKm4/G2dE?=
 =?us-ascii?Q?WHD3gCti5pMk0VxJST6MOqii8wdy8XpegY2HKQDa5LqkHemC9AiUE3t9xAfi?=
 =?us-ascii?Q?ORUy8VHVTPEaGIzxJvlLQKThlmq8fBDmofbpVcCaYSfrUHqQ5AsQ52DDIT3f?=
 =?us-ascii?Q?zWJyqHdjT8lts0Si65UnF0tR1pfgBBvtTNsVzmoJEyghCS25qwXaJCsu6F1b?=
 =?us-ascii?Q?d1GmD0tmyJqqVZ5Dcm1DjoPvTaEfoHb8Y4SYbf1/0SaMIGALBD6dr8Fz2m5h?=
 =?us-ascii?Q?Mf4KFBCoCVa7QK8ulP0KMUHJEjX1qT5aLbGCnnR5jjj9u02o5AYuZuLMnyTX?=
 =?us-ascii?Q?rYIYJBN6LtfdXX/Pt/rDVTHAj3MsKNnvk107sM2pGEvPtyJQ66oeUIVef9As?=
 =?us-ascii?Q?MjMplqgyVE2j6Ok2QRVowDOCZgo+4W82gR3mwa/9zek9AbI5s5Fj5bBIk+51?=
 =?us-ascii?Q?d5y0BTcly8aLcQ4AYwjRBBpksVU8/DeSxSUkc6OtCvhCeggE41Nl56lMiWio?=
 =?us-ascii?Q?1tgq1ajib4jdkKEgaGsIOe6+lL7D/wS+WfjA9Wlj5NXpRa9XuAq2x9Rgc0Jv?=
 =?us-ascii?Q?HtsUKwhLmTpqQOUzdRqdc8fJ3/wo4NLRnZbMyHTLRjEv9gLfSgXGVh+76Q1M?=
 =?us-ascii?Q?U5M0iyySF/MyFbH9FOheGOZ6HyYjHzBFpINbtswF5RdsuTDoOfKtkbO3CVRW?=
 =?us-ascii?Q?9nUT+Xt/TjVEth5Rd+9MqI5IaWQUjLpnXbc7qO3KR61sJXeFTnBk8Gd7kx7F?=
 =?us-ascii?Q?RTJBX4suKX41BpvI6qnykqU7f4V7zOXwniekE7IyBZKoTEk2oaHpOL4/LtnW?=
 =?us-ascii?Q?Qnc5rfmybEcqexRlN+TswhK5l93MFI8rTOlAB6KlHhMGNvwBBTKpkVMcJuDg?=
 =?us-ascii?Q?WLTDTSSKfvPhvyW/XObL/mqv0td/x52Smzcul2sh3NUc/2qn1mug8re9W20Y?=
 =?us-ascii?Q?ywUHtYJxD2N2m+eT/PCPiok0YHLjNx2UMqvs+RsFzfKkyogGdzFQAWhNkitS?=
 =?us-ascii?Q?Tg=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a838cf45-aff7-4c0f-f3f8-08ddc374bb5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2025 07:53:48.3137
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rjftNah78RWzk6xWDPjIl3xw9i81zq4ReXNuYGxnOBBSu4EqoNWB5wOklg5SXcaEXcBEUG7pFrGdT1G2dP/aphloapAK05l1ByBmLNKy1LI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR03MB7992


> From: Michael Walle <mwalle@kernel.org>
>=20
> Hi,
>=20
> > Ensure that the pointer passed to module_put() in spi_nor_put_device()
> > is not NULL before use. This change adds a guard clause to return
> > early, preventing the kernel crash below when the cadence-qspi driver
> > is removed during a dd operation:
> >
> > [  200.448732] Unable to handle kernel NULL pointer deref erence at
> > virtual address 0000000000000010 [  200.457576] Mem abort info:
> > [  200.460370]   ESR =3D 0x0000000096000004
> > [  200.464136]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> > [  200.469527]   SET =3D 0, FnV =3D 0
> > [  200.472609]   EA =3D 0, S1PTW =3D 0
> > [  200.475904]   FSC =3D 0x04: level 0 translation fault
> > [  200.480786] Data abort info:
> > [  200.483659]   ISV =3D 0, ISS =3D 0x00000004, ISS2 =3D 0x00000000
> > [  200.489141]   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
> > [  200.494189]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
> > [  200.499500] user pgtable: 4k pages, 48-bit VAs,
> > pgdp=3D0000000185df8000 [  200.505932] [0000000000000010]
> > pgd=3D0000000000000000, p4d=3D0000000000000000 [  200.512720]
> Internal
> > error: Oops: 0000000096000004 [#1] PREEMPT SMP [  200.518968]
> Modules
> > linked in: 8021q garp mrp stp llc bluetooth ecdh_generic ecc rfkill
> > crct10dif_ce rtc_ds1307 at24 stratix10_soc soc64_hwmon gpio_altera of
> > _fpga_region fpga_region fpga_bridge uio_pdrv_genirq uio fuse drm
> > backlight ipv6 [  200.540016] CPU: 0 UID: 0 PID: 372 Comm: dd Not
> > tainted 6.12.19-altera-gb6b26
> > c4179a6 #1
> > [  200.547996] Hardware name: SoCFPGA Stratix 10 SoCDK (DT) [
> > 200.553292] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS
> > BTYPE=3D--) [  200.560234] pc : spi_nor_put_device+0x30/0x60 [
> > 200.564594] lr : __put_mtd_device+0x8c/0x120 [  200.568856] sp :
> > ffff80008411bc20 [  200.572161] x29: ffff80008411bc20 x28:
> > ffff000185e2c500 x27: 0000000000000000 [  200.579282] x26:
> > 0000000000000000 x25: ffff000185e2cb00 x24: ffff000185e2cc88 [
> > 200.586404] x23: ffff00018034c620 x22: 0000000000000001 x21:
> > ffff00018873e080 [  200.593524] x20: 0000000000000000 x19:
> > ffff00018873e080 x18: ffffffffffffffff [  200.600645] x17:
> > 0030393d524f4a41 x16: 4d0064746d3d4d45 x15: ffff000185757700 [
> > 200.607767] x14: 0000000000000000 x13: ffff000180045010 x12:
> > ffff0001857576c0 [  200.614888] x11: 000000000000003a x10:
> > ffff000180045018 x9 : ffff000180045010 [  200.622009] x8 :
> > ffff80008411bb70 x7 : 0000000000000000 x6 : ffff000181325048 [
> > 200.629129] x5 : 00000000820001cf x4 : fffffdffc60095e0 x3 :
> 0000000000000000 [  200.636250] x2 : 0000000000000000 x1 :
> ffff00018873e080 x0 : 0000000000000000 [  200.643371] Call trace:
> > [  200.645811]  spi_nor_put_device+0x30/0x60 [  200.649816]
> > __put_mtd_device+0x8c/0x120 [  200.653731]
> put_mtd_device+0x30/0x48 [
> > 200.657387]  mtdchar_close+0x30/0x78 [  200.660958]
> __fput+0xc8/0x2d0
> > [  200.664011]  ____fput+0x14/0x20 [  200.667146]
> > task_work_run+0x70/0xdc [  200.670718]  do_exit+0x2b4/0x8e4 [
> > 200.673944]  do_group_exit+0x34/0x90 [  200.677512]
> > pid_child_should_wake+0x0/0x60 [  200.681686]
> > invoke_syscall+0x48/0x104 [  200.685432]
> > el0_svc_common.constprop.0+0xc0/0xe0
> > [  200.690128]  do_el0_svc+0x1c/0x28
> > [  200.693439]  el0_svc+0x30/0xcc
> > [  200.696454] dw_mmc ff808000.mmc: Unexpected interrupt latency [
> > 200.696485]  el0t_64_sync_handler+0x120/0x12c [  200.706552]
> > el0t_64_sync+0x190/0x194 [  200.710213] Code: f9400000 f9417c00
> > f9402000 f9403400 (f9400800) [  200.716290] ---[ end trace
> > 0000000000000000 ]--- [  200.720948] Fixing recursive fault but reboot
> > is needed!
> >
> > Fixes: be94215be1ab ("mtd: spi-nor: core: Fix an issue of releasing
> > resources during read/write")
> > CC: stable@vger.kernel.org # 6.12+
> > Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
> > Reviewed-by: Matthew Gerlach <matthew.gerlach@altera.com>
> > ---
> >  drivers/mtd/spi-nor/core.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> > index ac4b960101cc..501e48a342ad 100644
> > --- a/drivers/mtd/spi-nor/core.c
> > +++ b/drivers/mtd/spi-nor/core.c
> > @@ -3213,6 +3213,9 @@ static int spi_nor_get_device(struct mtd_info
> *mtd)
> >       if (!try_module_get(dev->driver->owner))
> >               return -ENODEV;
> >
> > +     if (!dev && !dev->driver && !dev->driver->owner)
> > +             return -EINVAL;
> > +
> >       return 0;
> >  }
> >
> > @@ -3227,7 +3230,8 @@ static void spi_nor_put_device(struct mtd_info
> *mtd)
> >       else
> >               dev =3D nor->dev;
> >
> > -     module_put(dev->driver->owner);
> > +     if (dev && dev->driver && dev->driver->owner)
> > +             module_put(dev->driver->owner);
>=20
> Why is dev->driver or dev->driver->owner NULL in the first place?

When we remove/unbind the the spi node during busy, we will hit with dev->d=
river and dev->driver->owner NULL derefence.
This eventually leads to the oops that I included in the commit message bod=
y.

>=20
> -michael

