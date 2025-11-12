Return-Path: <linux-kernel+bounces-897015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52535C51C7F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E3DA1899E60
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 10:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554E63054F0;
	Wed, 12 Nov 2025 10:53:40 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2099.outbound.protection.partner.outlook.cn [139.219.17.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C3D2741C6;
	Wed, 12 Nov 2025 10:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762944819; cv=fail; b=QJnTGT4n6OyQa9r1aBSnmbcNn+cl9Q22w9Xba1PSQNIrSBgfyZcWqBx3doJBMfQP/J1++/ZtIq2JLyxsFi1B7B11VFu9dl3NPMjvvf4qr0kCRpvrmuyF3eIT8lwCLlyZ2poBIucg+xK70855EfHAkMfFbRHgJHxJc0H5nMK/6BU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762944819; c=relaxed/simple;
	bh=I28qNwq8yFwnJSSHfcphiOswMwz+cYBZSwX0CYd8dF0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VE+2js/c8SChC/5YgOZbLQ2QPI1XkxOQtYW2NyMC/AvNG/oOSRRRSdNOW21cr0wJWtsBJjkXi/mfCrUGf+4lSueTt/82Dtr7mluvI5dXbjvGB3UW0LJxjZRfjdQEh6g5BC0GeEO2C+ZbsaqHfUoF6HKRRZUfPMngYoaNo/9VLZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
Received: from ZQ2PR01MB1211.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::11) by ZQ0PR01MB1206.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:1b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 10:53:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IG5hl5Hl/u2urY+R0yasb7m+Gi72U7FBEFKSJmlsQoboNoWsvIujYbYwHpa3DmbZlfzc0KFTxTSIda0jkEUFpvLJm4zam4Ak3fIzh8q1qx8tcAq7P/v92Rhcpy3GFZxISdthJ1Me+R1r0iB7Tk+DNFr+e2SiqRZhhXkeQexswPITE/9jfPAhokSObVwiwNgCSCKnk7MMAfz9pg1KQnmWCib/ylXkgFIqwDjHpRayJa0yykO8ef5kVcainekaapydzAzds2Zb3Sv4c38MKN/P5eSZNGm4iEVli3NG6jKgXoNoGITKi6Z14VhF1rMrJDQRT4SnpGCmAfD2F8BxRGDKRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bBbOeJTR6AVKavC8ST7uaExoY3E5mqF+VX4qawM8sfQ=;
 b=S2FBam9zt9aHsfBIcJwAoNMA6708/rSSCH/IzPQqkhmdxk7a/3aLW5Lay/O421tfo9zzNV5OBlZd0rq1Nbd56+Wo/eTeIm4luvFnzlEQsdGilhocQ5H5l1MNagkuhQ+sg/Z850yxKmp/LcBDqlmQ3kIQKCzlptvhMMsrlSnD/rsX4U8zNl/w9QBs8R6zzyAqUMi7+I6kRp2hSEjefr4GuQvrW9WVSk7Qz9SyyYGBjRj0WwPQ/VvD7sfaA25ihWDkiI1aJ1wcspgVxmVAchw7FzqoW5pE3yGHCdRB+Gu51SmZOlt64jWcJJZb3s/4f2FBq3rAILsA9KUAOCcXyqSmJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1211.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 07:47:08 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%6]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 07:47:08 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Conor Dooley <conor@kernel.org>, Heinrich Schuchardt
	<heinrich.schuchardt@canonical.com>
CC: E Shattow <e@freeshell.de>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Conor Dooley <conor+dt@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Palmer
 Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>, Albert Ou
	<aou@eecs.berkeley.edu>, "Rafael J . Wysocki" <rafael@kernel.org>, Viresh
 Kumar <viresh.kumar@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, Lorenzo
 Pieralisi <lpieralisi@kernel.org>, =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?=
	<kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Emil
 Renner Berthing <emil.renner.berthing@canonical.com>
Subject: RE: [PATCH v2 0/8] Add support for StarFive VisionFive 2 Lite board
Thread-Topic: [PATCH v2 0/8] Add support for StarFive VisionFive 2 Lite board
Thread-Index: AQHcT8yr76WB0y2LYU6wjdN+ecXGd7TnDtcAgAAC9gCAAGQugIAHNaLg
Date: Wed, 12 Nov 2025 07:47:08 +0000
Message-ID:
 <ZQ2PR01MB13079F7073193A2C64BD83F4E6CC2@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
References: <20251107095530.114775-1-hal.feng@starfivetech.com>
 <c05d8bcc-3024-45cd-8630-b0595682e778@freeshell.de>
 <6d0fb6aa-6d88-4069-a5e5-9e910523888e@canonical.com>
 <20251107-frenzy-cloning-4b279cfe932c@spud>
In-Reply-To: <20251107-frenzy-cloning-4b279cfe932c@spud>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic:
	ZQ2PR01MB1307:EE_|ZQ2PR01MB1211:EE_|ZQ0PR01MB1206:EE_
x-ms-office365-filtering-correlation-id: 0127c9a6-60a7-4b8b-ed3c-08de21bfae56
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|41320700013|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 bEbC9FFDfl2rLcAv41Hezg9mxl09FJHmQMr/4moydaZnE4zCHm0h2vGvhT1kEKVt0JrR62QL2YZVceQ3Mfh4HnGyaxOt0BnGzsDcQplGOFGQ66tpRhvGmWCbXOKlfxc8krdPi0NUDp91/syvsrKc5+NVJI4D6RKEyxTE1Hlvqx7Ay9r9M+2bc1EgQxHycQZAg6DmmX+JSk5pGzeqqE4jxTBQnhpFwP65yKPjMOn86kBXq/lpMZowyAaa3Sc08ub/biwu9Yqp/tmapqyGWmYDDavWyeJ0IiUYKu7bZLJIrRyUG29mt7i7/pxNNYvxAfgrl2KiLIQicydbcpIRA1bPXIFYTkR2VsrTC9JDA+5g3jmIpBkiqPbzm4eJsSoHtqqfvKhtsWGgoYV98SeBjvV45yJyQnxmb204705vD7Zg+Qo3eqp6zlU4sJTXKlxuP+/hjQAFtMeN4toyMS08tE7f7m/7voyV5hIOVIR6hg1Ebr4k4QuJl5MbiBR1VUWIwTPij7msw9KwzoKC0cTWMkT9tXeY2lmL/YfpgHOUAggJ3SONXKQklbgfBHzAPN+fwvBxgdGGmc9NIBAF1gIt5Ns0WPyhGivkMIH8YWvPJxJQtT8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(7416014)(41320700013)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?LhrZHLzdetYE2lYsTeWxSgNSX5SgNLTcQHEiubXoJKWuFOu/OJkGVZtodO?=
 =?iso-8859-2?Q?5vpw7F5ZP/jyM6VAfcTS55p/3SimXTrth6PrHTj38dw5qIrgoXw1xZnGb6?=
 =?iso-8859-2?Q?BWjEJXaOAn0Xnh1psj+WmYaXi+6p1zS/7cCGbBZTErdTE7KmDRh172x2uG?=
 =?iso-8859-2?Q?ke9AqntGfHFZcuRV5hv7KOdJcCfUfDaL04ZJDuHPXHV97QaIhUVzYPPv6W?=
 =?iso-8859-2?Q?4+P7rVi30tBqu+cjOpnL9lZb7OrGnbQSsuNRtXNmoyzNr/FbNavnGFcVnk?=
 =?iso-8859-2?Q?Bqb4lWXUA/FpmvqUjdWcHBhabLM0Q45NKLT/PYS6Z5kRAy2bjgmAN/Bi0z?=
 =?iso-8859-2?Q?2EVKqZAaJjDORUnzf/Iboy6WfwUtutVcsdTV6qTAPxwwQck65orvr2Wzem?=
 =?iso-8859-2?Q?lQ6KMbgTXDJoHhT+RuE4Ie/7DZuDS6N6dlgoFl0p8qjyYpIalAWFQdjC7Z?=
 =?iso-8859-2?Q?gfQVv1CI5QUHritv3FN9sfXlZhCImpzG7Pruig4IMSlP8y/SgJai8/ApIY?=
 =?iso-8859-2?Q?UEMkNnCgvUElaBlQhOzVPZE3UT8g7iSySky2M/nRIXTpqDLY6WSouBAD7I?=
 =?iso-8859-2?Q?0/lGl11c/ESby/6mZcHXNvdmR5ZBMWt1QpXTR6OfbOeOpmN3+wo+wc5pwX?=
 =?iso-8859-2?Q?2yu7f4TucCKNNaSNUQkn6gNVIq2G7k/07GHGNfZngVp2b0/bPymw1Ac9Hi?=
 =?iso-8859-2?Q?UxbqiNsun4AfhIpIKoSGA0v9GSN6+17keid0tOJ74RNOGGi+ejLhthZf0/?=
 =?iso-8859-2?Q?zJRs7S9u9wzyrAUcjpjP8abQxeom6yrpwUi/CZNvIe0fK/27LotShzogRI?=
 =?iso-8859-2?Q?msSMIJCXdteQpNg4kkqOZB74mgfLODMH+2G6HkLy0L3IHRwulwiYyQ6rjz?=
 =?iso-8859-2?Q?vhTpJ94DS934odVV1kXi1YwSTxW0xUVZcOMd404Pkxoof/uQnsPsDYTayV?=
 =?iso-8859-2?Q?7cZLOH9DB8CYJeNNmJD6OGiUo/3ppXt/6nGwDf1roCdM9GxcESBos6hHAG?=
 =?iso-8859-2?Q?puKo0FoGGG/svMJzMRhKGcMOm+ziJ7B1Wk4KoZ4c5QzAEZKigY8d2UCTDE?=
 =?iso-8859-2?Q?ZJMIs6KxTE4dvhlUw4kTXk3b4K75ekO4+xneWHcfU0ux2PaWcdLJtXn7Wv?=
 =?iso-8859-2?Q?pntZSqr/xRZYryUr7n0R4a/WJgKIoF7VmniyjrAWhcpADMYszlS3aKQI2C?=
 =?iso-8859-2?Q?ZNBbe7EB3IAjfDdg0BmzdvLxYfcUTKQTB9Nm1T6+uDU+DvhgwKWO01Cgg1?=
 =?iso-8859-2?Q?UG7IF7kA/MiT/fKdJu/E6f31UB8uYFyKcmu9tioJ/WKlLb2tNvAQhE1h7B?=
 =?iso-8859-2?Q?StWq0NM2zpzp2m5X1+GR3koH/JyoGCfZfK27vG6zo5XX7+m6HzUs8YPKQN?=
 =?iso-8859-2?Q?ZKSNbpDFzga5vqWDwn+O4L4ik2qfwsYiLEqnXj6u+O+zmRB3oWyWWALMAh?=
 =?iso-8859-2?Q?PUwwtyfRK8196HDtlEvIBbj7Y4tBpA1DdJK2uuLYuFJksn7dCFheBO+SB+?=
 =?iso-8859-2?Q?eR/fjhMOJBZlbzBq9ZqyZBBa21v1X1nlsTuFas2Bf2EJ4EBGYwuwHrw6AI?=
 =?iso-8859-2?Q?RVhfEbXPWHGTutrs1ZhuGscsX68zpEdx0dDYzJjjpCWO5Uj7jGbTQJT/pJ?=
 =?iso-8859-2?Q?dVbCe26Zezxovz1HrY0RKBbq59CfpVHGLB?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 0127c9a6-60a7-4b8b-ed3c-08de21bfae56
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2025 07:47:08.0267
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K0gFinm2L9wHeqFJCPmbr/EE8xOr8vlbCXMR5PjnnlJ1hqROez1KsEkWcg6G3w33sQqHhfNkKghHmIXx3a+oChlGE5abAMo2JyV97fqAVHk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1211
X-OriginatorOrg: starfivetech.com

> On 08.11.25 01:20, Conor Dooley wrote:
> On Fri, Nov 07, 2025 at 12:21:46PM +0100, Heinrich Schuchardt wrote:
> > On 11/7/25 12:11, E Shattow wrote:
> > >
> > >
> > > On 11/7/25 01:55, Hal Feng wrote:
> > > > VisionFive 2 Lite is a mini SBC based on the StarFive JH7110S
> > > > industrial SoC which can run at -40~85 degrees centigrade and up to
> 1.25GHz.
> > > >
> > > > Board features:
> > > > - JH7110S SoC
> > > > - 4/8 GiB LPDDR4 DRAM
> > > > - AXP15060 PMIC
> > > > - 40 pin GPIO header
> > > > - 1x USB 3.0 host port
> > > > - 3x USB 2.0 host port
> > > > - 1x M.2 M-Key (size: 2242)
> > > > - 1x MicroSD slot (optional non-removable 64GiB eMMC)
> > > > - 1x QSPI Flash
> > > > - 1x I2C EEPROM
> > > > - 1x 1Gbps Ethernet port
> > > > - SDIO-based Wi-Fi & UART-based Bluetooth
> > > > - 1x HDMI port
> > > > - 1x 2-lane DSI
> > > > - 1x 2-lane CSI
> > > >
> > > > VisionFive 2 Lite schematics:
> > > > https://doc-en.rvspace.org/VisionFive2Lite/PDF/VF2_LITE_V1.10_TF_2
> > > > 0250818_SCH.pdf VisionFive 2 Lite Quick Start Guide:
> > > > https://doc-en.rvspace.org/VisionFive2Lite/VisionFive2LiteQSG/inde
> > > > x.html More documents:
> > > > https://doc-en.rvspace.org/Doc_Center/visionfive_2_lite.html
> > > >
> > > > Changes since v1:
> > > > - Drop patch 1 because it is applied.
> > > > - Rename jh7110.dtsi to jh711x.dtsi.
> > > > - Move the content of jh7110-common.dtsi to the new file
> > > >    jh711x-common.dtsi and move opp table to jh7110-common.dtsi.
> > > > patch 4:
> > > > - Move the uncommon nodes to jh7110-common.dtsi instead of board
> dts.
> > > > patch 5:
> > > > - Add jh7110s-common.dtsi and include it in jh7110s-starfive-vision=
five-
> 2-lite.dtsi.
> > > >
> > > > Changes since RFC:
> > > > - Add jh7110s compatible to the generic cpufreq driver.
> > > > - Fix the dtbs_check error by adding the missing "enable-gpios" pro=
perty
> > > >    in jh7110 pcie dt-bindings.
> > > > - Rebase on the latest mainline.
> > > > - Add VisionFive 2 Lite eMMC board device tree and add a common
> board dtsi
> > > >    for VisionFive 2 Lite variants.
> > > > - Add usb switch pin configuration (GPIO62).
> > > > - Improve the commit messages.
> > > >
> > > > History:
> > > > v1:
> > > > https://lore.kernel.org/all/20251016080054.12484-1-hal.feng@starfi
> > > > vetech.com/
> > > > RFC:
> > > > https://lore.kernel.org/all/20250821100930.71404-1-hal.feng@starfi
> > > > vetech.com/
> > > >
> > > > Hal Feng (8):
> > > >    dt-bindings: PCI: starfive,jh7110-pcie: Add enable-gpios propert=
y
> > > >    dt-bindings: riscv: Add StarFive JH7110S SoC and VisionFive 2 Li=
te
> > > >      board
> > > >    riscv: dts: starfive: Rename jh7110.dtsi to jh711x.dtsi
> > > >    riscv: dts: starfive: Split jh7110-common.dtsi and move opp tabl=
e to
> > > >      it
> > > >    riscv: dts: starfive: jh711x-common: Move out some nodes to jh71=
10
> > > >      common dtsi
> > > >    riscv: dts: starfive: Add common board dtsi for JH7110s and Visi=
onFive
> > > >      2 Lite variants
> > > >    riscv: dts: starfive: Add VisionFive 2 Lite board device tree
> > > >    riscv: dts: starfive: Add VisionFive 2 Lite eMMC board device
> > > > tree
> > > >
> > > >   .../bindings/pci/starfive,jh7110-pcie.yaml    |   4 +
> > > >   .../devicetree/bindings/riscv/starfive.yaml   |   6 +
> > > >   arch/riscv/boot/dts/starfive/Makefile         |   3 +
> > > >   .../boot/dts/starfive/jh7110-common.dtsi      | 653 +------------=
----
> > > >   .../boot/dts/starfive/jh7110s-common.dtsi     |  27 +
> > > >   ...h7110s-starfive-visionfive-2-lite-emmc.dts |  22 +
> > > >   .../jh7110s-starfive-visionfive-2-lite.dts    |  20 +
> > > >   .../jh7110s-starfive-visionfive-2-lite.dtsi   | 126 ++++
> > > >   .../boot/dts/starfive/jh711x-common.dtsi      | 656
> ++++++++++++++++++
> > > >   .../dts/starfive/{jh7110.dtsi =3D> jh711x.dtsi} |  16 -
> > > >   10 files changed, 879 insertions(+), 654 deletions(-)
> > > >   create mode 100644 arch/riscv/boot/dts/starfive/jh7110s-
> common.dtsi
> > > >   create mode 100644 arch/riscv/boot/dts/starfive/jh7110s-starfive-
> visionfive-2-lite-emmc.dts
> > > >   create mode 100644 arch/riscv/boot/dts/starfive/jh7110s-starfive-
> visionfive-2-lite.dts
> > > >   create mode 100644 arch/riscv/boot/dts/starfive/jh7110s-starfive-
> visionfive-2-lite.dtsi
> > > >   create mode 100644 arch/riscv/boot/dts/starfive/jh711x-common.dts=
i
> > > >   rename arch/riscv/boot/dts/starfive/{jh7110.dtsi =3D> jh711x.dtsi=
}
> > > > (99%)
> > > >
> > > >
> > > > base-commit: df5d79720b152e7ff058f11ed7e88d5b5c8d2a0c
> > >
> > > Small nit that "lite-emmc" is confusing together. In patches to
> > > U-Boot dev mailing list the EEPROM product id is demonstrated to be w=
ith
> "SL"
> > > suffix when compared to VisionFive 2 (JH7110) so I suggest avoid
> > > confusion in upstream and use for VisionFive 2 Lite (JH7110S) these
> > > compatible names:
> > >
> > > starfive,visionfive-2sl-lite
> > > starfive,visionfive-2sl-emmc
> > >
> > > Also filenames:
> > >
> > > jh7110s-starfive-visionfive-2sl-lite.dts
> > > jh7110s-starfive-visionfive-2sl.dtsi
> > > jh7110s-starfive-visionfive-2sl-emmc.dts
> > >
> > > What do you think?
> > >
> >
> > This is a serial number for the Lite board:
> > VF7110SL-2310-D002E000-xxxxxxxx
> >
> > Here E000 encodes that we have no eMMC.
> >
> > The S is part of 7110S which we already have in 'jh7110s'. And the L
> > is already decoded as 'lite' in this patch series. Duplicating this
> > information as 'sl' as you suggested provides no benefit.
> >
> > Let's just stick with Hal's suggestion.
>=20
> The marketing materials etc call it the visionfive 2 lite, for example on
> kickstarter: https://www.kickstarter.com/projects/starfive/visionfive-2-l=
ite-
> unlock-risc-v-sbc-at-199
> I'm happy enough with what Hal has here as a result.

Hi, Conor,

Thanks for your review. VisionFive 2 Lite is the official name of this prod=
uct,
so it is appropriate to use "starfive,visionfive-2-lite" as the compatible =
and
"jh7110s-starfive-visionfive-2-lite.dts" as the device tree filename.

Best regards,
Hal

