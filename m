Return-Path: <linux-kernel+bounces-758485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5C2B1CFCA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 02:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14E653B5D05
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 00:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0BC3B280;
	Thu,  7 Aug 2025 00:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="UGERFPDU"
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023115.outbound.protection.outlook.com [40.107.44.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5716F9461;
	Thu,  7 Aug 2025 00:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754526216; cv=fail; b=qu/QGidjCCk1jxBn4Z7ihxtS3y8I9kylW99vdyDTuY7nIiay5r6bgH1dGniKGjOu1IUzUoVBHESZZ8DtpIPVvz34OBbo1zvZOq03Y4yodgjE4t2mLD3p3dFrL4SQwUfE51DE161jcFVoXP3LJllL4+5IHzJwzU6o55dv3LTspj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754526216; c=relaxed/simple;
	bh=NO9JZueEcZdBajxKEFh68i1LcagX+IkBNh6wXZF/Bec=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OBstGaJpqc/e9Exuyaeb6V3nlaK4Yc02lowVnyhLCGHl9+9l1esOwiyFWNfa2jDOjJlPai2OeHzwrUcGad+dQNUNPdVxWHhHXmI/lba9eRiLT99DyANJcEF8q85GULtO+7RGvSX4npop3f5z5Gl26WYIFsBwqoZKUqppF6gHaWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=UGERFPDU; arc=fail smtp.client-ip=40.107.44.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U3CmWjuFyF5AaVM8rh8ycg9PMFrbCokTFpEPqQ6GC5jLs++sf0A9Uxw9zTtodCuT6uGYAb95fM6IFKiOj7xgeH1Vgnxq9esR9pIFo6cCrdhkqmsG5A4Lyr4auKfLYRY/JooW8UDTdFsZGgNnE2McV/LjTKDAryK4lIo6LUBnyXdf6qmFKuQgiLg6/jWeTov5DZZCG42gXLEUKOjZ/4WD1v+Oa/bzYmEIUpZ1Bv+pB6BBqdpnSAwgdRmCEPFjTG34szsRtBQECvGffivIAGzeSpuMOIEjf5WwNdTFxNsF0w7nfK1ueu4EEGuEPdkDUJ/k/ssnxeKgUZYlju0A4yJiXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NO9JZueEcZdBajxKEFh68i1LcagX+IkBNh6wXZF/Bec=;
 b=As/tTLee7c9WQ1Ra+ER6hEm+FzeTQJh8651IMXO7w16x9H3DJQLPkM89lzDuqYgasfaG42NvXTDmaw5AEChtxW2x+GQBaJP2ef22THhf+tK81MXo/A3qgOAovRaGw0KLeaMPJ1i5ivvWFnIOvrFYJwa8gjR0PnEOUh0N/kYCuhWzqqR+CQTm1ckdA0UisG7M5v4oZEnHLAxgyaQIgjG4E9EBSbZ3NwZVfl0zLD8loCjZSFl7ZZfYwgqo3nEipA8kWf/9lzXBtl1Mp8lSbLpc4xljyazP2eL0a+dFJ/2NlwvlgvfTMc6Mda3kIfIcuWDABe++d3ZKDw1g3lmWUt8aSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NO9JZueEcZdBajxKEFh68i1LcagX+IkBNh6wXZF/Bec=;
 b=UGERFPDU78i0DkiOKjQbNA+nAtyrnZ2OTq6SYXtFy0pmXYX89LnrnQ5ErbRYAblyLxAK1S0+hSdvajqg5HPmIKWLkN1LhHhijsvq/Z34/LuOXFqSkBnxPzoHiQOFjJZtrPaNSKjZjvlKn5EUeFqcY5+DQghEcVyQfXQYElLPNUOXtu3Em4xpXcsVrkwjD7VfWZqBJ8tdDisqfp5Pi9718drARRxWYaTH6DIU0XY1Tk2CELBNnAbUALOoZCTMUnC+ZWOacls2TKuTpBvswz64/a92QxQMu00+CfB71jJ0Z8sMnkco9wYlke8xbTngyKrbHp3xai6ESg5bN09avLsXjg==
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com (2603:1096:604:2b1::11)
 by SEZPR06MB6088.apcprd06.prod.outlook.com (2603:1096:101:ef::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Thu, 7 Aug
 2025 00:23:30 +0000
Received: from OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11]) by OS8PR06MB7541.apcprd06.prod.outlook.com
 ([fe80::9f51:f68d:b2db:da11%5]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 00:23:30 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Thomas Gleixner <tglx@linutronix.de>, Eddie James <eajames@linux.ibm.com>,
	Rob Herring <robh@kernel.org>
CC: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery
	<andrew@codeconstruct.com.au>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 2/2] irqchip/aspeed-scu-ic: Add support for AST2700 SCU
 interrupt controllers
Thread-Topic: [PATCH 2/2] irqchip/aspeed-scu-ic: Add support for AST2700 SCU
 interrupt controllers
Thread-Index: AQHcBQGAHPbqy57A20e2dQZRkDylV7RUNCYAgAECPsCAAG85AIAAEbcAgAChi1A=
Date: Thu, 7 Aug 2025 00:23:30 +0000
Message-ID:
 <OS8PR06MB7541E8D33688BA44E4EE988BF22CA@OS8PR06MB7541.apcprd06.prod.outlook.com>
References: <20250804053445.1482749-1-ryan_chen@aspeedtech.com>
 <20250804053445.1482749-3-ryan_chen@aspeedtech.com>
 <20250805153908.GA1807801-robh@kernel.org>
 <OS8PR06MB75414ECA0290018D5D113B62F22DA@OS8PR06MB7541.apcprd06.prod.outlook.com>
 <5c46082a-c31b-4d12-a1d6-f315c8ce7aaa@linux.ibm.com> <8734a4ecgp.ffs@tglx>
In-Reply-To: <8734a4ecgp.ffs@tglx>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS8PR06MB7541:EE_|SEZPR06MB6088:EE_
x-ms-office365-filtering-correlation-id: b73c685e-6199-4978-bda5-08ddd548a2b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?5lfsI8wOPY2qeW9HBZ66gpUy6DegxES8NeYljdlBsFoIVqaIaXp43z6LRGd8?=
 =?us-ascii?Q?Rcye9Obl5/UTfZ+MOoDOKme4SJliOZSwccQ859lYT4b60SPk4xGYBHhtmQYW?=
 =?us-ascii?Q?8QGOVocLcB8OjTSG21jxn34WF3EOn6usBZS7/GJxNz+GoRxyc+JJcWG/Ub/L?=
 =?us-ascii?Q?rIeFS7e/PDLB8/tIxjd4Mv+IdiR++S+t1aHwrnmR3uYhsO84Jijrb0CkI1EC?=
 =?us-ascii?Q?8KePK2MK5FmjS5L2XFJ4QRIcSUCSuxfW5VsMRFJjv2JQZJlj523LLxV1kwRd?=
 =?us-ascii?Q?IP5e55zYsfSVFksI/ePvQ2wteDfbuDzmHBs6n4wRhA1XLyhEZWfld/lnMBlG?=
 =?us-ascii?Q?28+JfFoEoUow6AXhmOcoUYFqwdZi0HZ9y5L/GMS1RpweGMHvUvNQUzgaTTsC?=
 =?us-ascii?Q?duOuFCsouLzeytKTyowTzeuulVIbnIrLL3FpqUbJByZbYpUIBZ8vmluRWuQs?=
 =?us-ascii?Q?AYc5Jpg/Ebxudjq3kz0NZ342LURXPtdLNzN24lM1tJPv28LJ1JqYBiv3TRca?=
 =?us-ascii?Q?I8VTKeWfwCL0HT+zBD0DcEAFfmgptGhvEWBylrTPXK6xjuVdRmFYve1t0wu6?=
 =?us-ascii?Q?+tispMKwOXIXR3f5FqUUHrkUUa6FUzaWTx4idn3P2SrMY15NLzfjxjPGGVGS?=
 =?us-ascii?Q?9BzFi5TI3ra+4BREbWlentInrWvov8dsbLPGhVDXPOphfXl5VgMzoGUlRMDH?=
 =?us-ascii?Q?mn8xM8ljBdvFK5m9UBMlz9NUogCIWPsnzckFIny1rWGT9ky5p5K/MpiFEW0w?=
 =?us-ascii?Q?dD6+4SvNOe82bDunoKCRr/9YkQf1EIQU76c1aOmwHGO4Pn9rWZA2MIJwReSV?=
 =?us-ascii?Q?IX+2bi9rwgDDmB1tPfJCgA3KPuacyUhS0KUXQt5xAizdWiLULo2jVdJQQqaK?=
 =?us-ascii?Q?e2NWab0EQDdxEpPZsC0SgwO/2iX/uYSqnWB6vYoJiKIOB2p9OvrEWlKevzJg?=
 =?us-ascii?Q?zY2nnfxqfD34vB+8FPDZSMU25+0/SqahTozoRDQmuZZ/gsyRVPrnuqIxiLpl?=
 =?us-ascii?Q?cVfXc1Inp9gtAKrn+7gAJW+YMDmEvySAFpKQ9qlgof4yWsXAGrLpKNuXGG2l?=
 =?us-ascii?Q?4t3wwffHQ6waKn55aU2j8CdFrUrtpr10CqMfbmKayYNeup1AaZOo1onNsSmU?=
 =?us-ascii?Q?Ltnqsmnv/7wqdcM0elAl6H+xt8BZ14XsUNR6Tssf2LBQd1SlawcUESdWVTcp?=
 =?us-ascii?Q?N50m+Gm7sw79LgtUMI5dD5WbwS0dJOiLp2CpsHSK2WnkaSclXY5flcf+oquf?=
 =?us-ascii?Q?p4Vyywhx4apH1OnZmldRbGdjM+1acAuNJOZnbLFRGrKnQJGC45Kx4bZ2/JiA?=
 =?us-ascii?Q?Bvjs4XPRZiqHuTusXjML9V7MrcfdZheHqkWC+xjGJBuxwedWLikgkdDf4zzB?=
 =?us-ascii?Q?kZ2rpCcvLHhSpsRmvEL3vysuow9k1vJHRnj8BPSKw8x1QS3mIDf5HpfZ6+iI?=
 =?us-ascii?Q?gZ6UnnulvutBe28xuRfgd8q7YIBo+4Mym/CYlrT8zlx+Zot8Xu/sUA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS8PR06MB7541.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Evo+mQ0gkOcjvUSIezLhM7OK/H3w3/Mpgkm357HuZZtyGX/wfpAI1zrEhNzQ?=
 =?us-ascii?Q?F/jmkDepqJnTCTXOjgfiDkDzOwXSFW2QFWGTgi++z9zgIJcrrKRbO6Q5FKm2?=
 =?us-ascii?Q?5DlYKRbbwr9B5oE3PoisA4pNXXxG7kkjtVE6B7RyQAWcU+lqmdVjO6znwPrW?=
 =?us-ascii?Q?2IqnbTTLxRhd1VyHKsAiyqP/XpNDLocn4Bn7KA3nNVTXsVLR3rkD5FH1qxvV?=
 =?us-ascii?Q?ZFG+bWqTk04hH57D6wyKaqmXA/mHHcFIb6bsWJB/ro8DrW40m+glSaBFaOo/?=
 =?us-ascii?Q?LKz7elQX5iJZiHmiY3qKsL/eT4muJS5p6bVNliFwGR6rMx5eqgaFPBu40u1p?=
 =?us-ascii?Q?PXWloixc/RWKSeuL8fL6YbzVn23mSg8TWa+MteDEoofss/RBorqFKSOtA+GZ?=
 =?us-ascii?Q?1ayNRtltQ8Pi6ucJ2rhTgYcVb6q/PFRNNKP7/kRFZlwCgvCF5an5QRl+Zaz5?=
 =?us-ascii?Q?CwLy/DzfFtosQziHEU3AjkeXY/mgz0OWK5EvlKQRoizgXRmLeKNRfsmIPaBb?=
 =?us-ascii?Q?UpDHf7LGojJ06FCDmCnc14HN3HffJbSSzJM4/8y1fszWUSEnOknLuZ2HFdgz?=
 =?us-ascii?Q?TV8NXVtLZXE6nRf+AovBehRLAOZAT3jfuj7mpkuuTUuEXL9fb8XBtBc3NJAa?=
 =?us-ascii?Q?T6jMv8kn7A+/141+Q/029N5DqAWJj6MUca2tQbjL/NbSAKnGNtzXVBMmwD5l?=
 =?us-ascii?Q?s+c7hDDp5TSbDVXk1FGf/TFdjWtKvMa8C7L3bDiP6ghOENPFvxfIO6zqDzv8?=
 =?us-ascii?Q?ZuLSZuSicpfvVvR+6tuTslu+/8TycvHokHVs6JKuRYoj5wl26SRHmXBpmPaX?=
 =?us-ascii?Q?AJuBZ0hQThf+Jswf10XFguwxBGoBu7Snqi2JVr90GZnk2RdKxuTSKPjQe6Yk?=
 =?us-ascii?Q?Ntf7kiNuirfhpdXb3e2TEnImf2oKJjI568BisnhkFnYaJNWNtuDy5CB/pvWf?=
 =?us-ascii?Q?o5YZ792qpxqyW+Uv9xCA9QHYHLmLo+pvSJd7ZbMCV48mSBx/eNGNU3lddKj/?=
 =?us-ascii?Q?bowQoDjjw/sz0RZzvmsOrF+eXN6Xj+DKFD9cmFRvCoV7qqmGzqgq/0t5ZGOn?=
 =?us-ascii?Q?+SX54hM34PybCrtBmNueMu1P7MQTEAPugJl+ERLPjxc5+5JQT3T2vNM6biGJ?=
 =?us-ascii?Q?xIS1PWczUSBDdx6zpHaEQWDVpY8PNVh05VkmyV3m9K8lUpa7gErGY2+YcMCe?=
 =?us-ascii?Q?QpOj3+4gdAbtvf6//i6PJzlCTrezJr7yiTBc0nbj8/4F1KyXZ3rY81E8qGfr?=
 =?us-ascii?Q?YgoYjiYVKnhErPycwANLNeWfGxmwxvt9yDOWwl3awpw1Jdu7HKc6BmRTGpi+?=
 =?us-ascii?Q?Me1vbry2rsrlMiwVTqziiTjzu77AzZiFdmAa3UPWxpEAqAHx2OOPzOQ6q3FD?=
 =?us-ascii?Q?zW0SmiatHG1tUZZ3Ciz+qpxr61dk1/Iz2EwrkSDHZgsBdyj+W+8EvtY7QDY7?=
 =?us-ascii?Q?uBGxndEbGpgFZyElMToxrClpyIy/jB82aXAtZJjupVbrFohfaf7oNmCDka4P?=
 =?us-ascii?Q?aSu7SYmk52XsZK2fvhQojWM03bdLAXdEvDJBYNh6DxZWuH/Up2f2tRUnZiPP?=
 =?us-ascii?Q?gML+1bpkN/Ak7Xa3bY16YW4mpxbJWyj97LlnkPVP?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b73c685e-6199-4978-bda5-08ddd548a2b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2025 00:23:30.0230
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f8yy6QyHYNBCfd1JBV4nbWgWUdYrN2UN1ucFxZz8z/rr9+squaUnJnBmGk7q3JbBjNC8yhXYjejtud11PHdO8FaXjmpqLb1CVJn7AV/nx5Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6088

> Subject: Re: [PATCH 2/2] irqchip/aspeed-scu-ic: Add support for AST2700 S=
CU
> interrupt controllers
>=20
> On Wed, Aug 06 2025 at 08:41, Eddie James wrote:
> > On 8/6/25 2:14 AM, Ryan Chen wrote:
> >
> > How much is common with 2500/2600? I wonder if it would be easier to
> > just create a new driver only for AST2700, instead of all in the same
> > file/driver?
>=20
> There is enough consolidation potential to keep them in the same file.

Yes, I will keep the same file.

