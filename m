Return-Path: <linux-kernel+bounces-806007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62268B490A5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15D9E342E67
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87ED130C636;
	Mon,  8 Sep 2025 14:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="UAuH/hEk";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="UAuH/hEk"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021123.outbound.protection.outlook.com [52.101.70.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDF2C8E6;
	Mon,  8 Sep 2025 14:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.123
ARC-Seal:i=4; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757340171; cv=fail; b=RQpTMqP4Li20KbaswITaxH+8NWZeLbOQNQniwuxEGA2QSLjclZSAgUFgP3oRepofWiWh0aaqmyY4uspC0t5E4M4KMD3I4Is0P4tI35CCUQRuLO5r3zuWlKW2hDHeLNdp0dwuGrxZgj3xtRajF4IE+YjySeqGhH4jUkE0nwsGNfM=
ARC-Message-Signature:i=4; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757340171; c=relaxed/simple;
	bh=mx68ElQuM9hODGYtg9FTTYvfTaAVB4j01P56xmjwPzk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TAODUS83xcFooyxCj/mPfxidLM55FtVtnuTANmFxxP46FDGLlacGd3ksgLXE+MusXWwhSGVFWkJnEyyiiKC7LSfAZeAJXWgCRcOEaKUlfI2F4ipQ5k0L4wh0RGQUrdwo2eu7dtZmfm2YBaqqPyfX5Udu67g5HpKnRJXVjMrRmAk=
ARC-Authentication-Results:i=4; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=UAuH/hEk; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=UAuH/hEk; arc=fail smtp.client-ip=52.101.70.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=3; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=QwddZOWo9hmtBnI7iO1ucNDUwH6/VwB7Zod6SyDDxMtFXtLyYqpzZyPKZTMnt4G1jPZzerVgKX2Roytm96jI9UP1SgJGPXNO/gr99vbKuEWGND73JEg0SOitT//77xtpPseIbuc35Xeqjz35J9dTcQmee37OW25X40w/258ZQJNirY7lTVX+U+5mk53HNjmq/50bJWR/DyTChDZMnql3hnGn+gj9tzztoa8jAmzjFAdsxew98H5+3siL+ZOoJmcysgJTzES8DoAzcf+fGgcO7xsKlrsJHDpG1zE4i6tXeJTfOAhlZ0k87zTSbfYD/3iO3wSghwxlx57VyOUGm1bBbg==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mx68ElQuM9hODGYtg9FTTYvfTaAVB4j01P56xmjwPzk=;
 b=aKxXyjNkjxwFrvf40p9Cl1eup/rZNNlkkj+mq+4V0nEeXtV+HNsb5a54B1pr9UAohnGgH2xtz1gOtc+VtvM8f1EmSUljPTcAPr8SZLbswjZyDzMEM9o6Atu5fLM7BeBv4pM9rrh4f9WMA1/Pe0wpwPQkZ8pX93r/ECUFPDA3mRvGhikLxNWmdEar7Zotigb2kgVK/54FA/onFr0bjCbFL3z9X4P0X/zKEvvecocSnw0zA4hlCJWrvChlJWqIb5srbGRZXJ654Hr5CYJ6/kqoq6gHtPFFjGo6AIoWIJABiZB9xnQRD7NGc84GEHCsygtUsXQQxVcTSV6Qe3DgT5BayQ==
ARC-Authentication-Results: i=3; mx.microsoft.com 1; spf=fail (sender ip is
 52.17.62.50) smtp.rcpttodomain=kernel.org smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mx68ElQuM9hODGYtg9FTTYvfTaAVB4j01P56xmjwPzk=;
 b=UAuH/hEkt+6HyQxfyHoS81dR2m1tBZzOxuP3BLwstHjLMatIdIllz2uNXeRrw6ZdbKtnaVKvoQOo4wBjt4Tn1mdTIS3Q+PEHbG7bZNKhmDi+v+/2TE2nHFM7WNj1jlhb3xK1dYJhtan3wesWsNEN/YudW+TgdntUSFzLyzg6TtQ=
Received: from DU2PR04CA0274.eurprd04.prod.outlook.com (2603:10a6:10:28c::9)
 by DBBPR04MB7708.eurprd04.prod.outlook.com (2603:10a6:10:20d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.14; Mon, 8 Sep
 2025 14:02:45 +0000
Received: from DU6PEPF0000A7E4.eurprd02.prod.outlook.com
 (2603:10a6:10:28c:cafe::b3) by DU2PR04CA0274.outlook.office365.com
 (2603:10a6:10:28c::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 14:02:45 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 DU6PEPF0000A7E4.mail.protection.outlook.com (10.167.8.43) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.13 via
 Frontend Transport; Mon, 8 Sep 2025 14:02:45 +0000
Received: from emails-1080002-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-6-93.eu-west-1.compute.internal [10.20.6.93])
	by mta-outgoing-dlp-431-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 11508801A8;
	Mon,  8 Sep 2025 14:02:45 +0000 (UTC)
ARC-Authentication-Results: i=2; mx.checkpointcloudsec.com; arc=pass;
  dkim=none header.d=none
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed;
 d=checkpointcloudsec.com; s=arcselector01; t=1757340165; h=from : to :
 subject : date : message-id : content-type : mime-version;
 bh=mx68ElQuM9hODGYtg9FTTYvfTaAVB4j01P56xmjwPzk=;
 b=eZ+1qVu7+dzWXLtMK/t3QMTpEkoPgyxzIkULUnIeDIeQeIalAxNmB6EmfvmuE6E19GilL
 6GSE1sXAjf/gm44BwEhUzwHSjZNMO/ymTqyaK7nTgbI72KDiVBAEylOSJxUOCWUQUva+ZA9
 x1M87YwmW4/0cKptVTF9xoDlplbinPk=
ARC-Seal: i=2; cv=pass; a=rsa-sha256; d=checkpointcloudsec.com;
 s=arcselector01; t=1757340165;
 b=DXaRj90uEXo10T8ibIqYMN3cAyg1f9hCezOA7A9Bu4g1ll/gA2/5qx8+ArsSlgbOontpE
 Vx8vv4A5nqvPVBcgV99+Q3CnyJvVo40BecUFa+ajNqSl+GcCwQq+Z1KqeTgK1FFUGZE3L6r
 1opVQ3wJde2pA8JTqy+wRQBcEhg0xjw=
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BFmV1F90GB6G8ahf2KkA4X95mzy/Ld9hGIajEvPZUYlBxtChCrJSWlam+qYyz4hgnX5vpJJU9g3Wr7UkwYH89Uxr3MqNmF3fpLXESAhfCHIYvKdk60PaBdjvEe2NSZcetcSBXlQORAaneKo76KgXYFWZ/g0mhT+DqWR06bORARqKyHYZz5Qb2+hWYoOEn+CX6u6mSYJwdys9uG6E74rnWaoDc3TVk5Gk9HU7lsJc11DLaznDSLGyrHW11/BBaEuYCqFA30U4OZFm7a288CVQ0eMaH3aOTTKJ3fPE4jQ/QQXRzGuT7x7uwZMtrwTL6gMlIhY3LIaW1Zso4qf55eXiFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mx68ElQuM9hODGYtg9FTTYvfTaAVB4j01P56xmjwPzk=;
 b=g8llU6luwLsvU6iNu+g2NGFvuswKBxMZdAcPX2Z/RE57yt17onPKrmA4z4fsSuETzKpuyofJ7mC/n86o2pErYJji7C3NWBQiu3f7t2EP9PHQo/nClX/Ob9uityiihUkhELAbgMt7cJsdDed8ccw2NvCM/kRxgvtjrRvmajEwMZolJ6CHLc/n7BKU26/VSDZb/mnnODfcWS/6ATWCwLh8WI1E2lC5iPsfMh9EvtBoJiaHCoXyc79N28XZb5XIeZUPndZ4p4j/N6GXVMd/yj/M8jS0PDsHVmA1pujn0YiP6UnhGAgcXN2ipfP0v9mEW7NLIZgf7lPTWni4t0Xhg0rlMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mx68ElQuM9hODGYtg9FTTYvfTaAVB4j01P56xmjwPzk=;
 b=UAuH/hEkt+6HyQxfyHoS81dR2m1tBZzOxuP3BLwstHjLMatIdIllz2uNXeRrw6ZdbKtnaVKvoQOo4wBjt4Tn1mdTIS3Q+PEHbG7bZNKhmDi+v+/2TE2nHFM7WNj1jlhb3xK1dYJhtan3wesWsNEN/YudW+TgdntUSFzLyzg6TtQ=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by VI1PR04MB7087.eurprd04.prod.outlook.com (2603:10a6:800:12a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.14; Mon, 8 Sep
 2025 14:02:35 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::aa83:81a0:a276:51f6%4]) with mapi id 15.20.9115.010; Mon, 8 Sep 2025
 14:02:35 +0000
From: Josua Mayer <josua@solid-run.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>, Conor Dooley
	<conor@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>
CC: Krzysztof Kozlowski <krzk@kernel.org>, "linux-phy@lists.infradead.org"
	<linux-phy@lists.infradead.org>, Ioana Ciornei <ioana.ciornei@nxp.com>, Vinod
 Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring
	<robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH phy 13/14] dt-bindings: phy: lynx-28g: add compatible
 strings per SerDes and instantiation
Thread-Topic: [PATCH phy 13/14] dt-bindings: phy: lynx-28g: add compatible
 strings per SerDes and instantiation
Thread-Index: AQHcHnuYJtm9dj7MPUeeCk+9PJYwF7SE8myAgAQY54CAAEooAA==
Date: Mon, 8 Sep 2025 14:02:35 +0000
Message-ID: <2b1f112e-d533-46ae-a9a0-e5874c35c1fc@solid-run.com>
References: <20250904154402.300032-1-vladimir.oltean@nxp.com>
 <20250904154402.300032-14-vladimir.oltean@nxp.com>
 <20250905-bulky-umber-jaguarundi-1bf81c@kuoka>
 <20250905154150.4tocaiqyumbiyxbh@skbuf>
 <20250905-pamperer-segment-ab89f0e9cdf8@spud>
 <20250908093709.owcha6ypm5lqqdwz@skbuf>
In-Reply-To: <20250908093709.owcha6ypm5lqqdwz@skbuf>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-traffictypediagnostic:
	PAXPR04MB8749:EE_|VI1PR04MB7087:EE_|DU6PEPF0000A7E4:EE_|DBBPR04MB7708:EE_
X-MS-Office365-Filtering-Correlation-Id: 822e3aab-5116-4574-53da-08ddeee062e2
x-cloud-sec-av-info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?RXlob3NoWVFtWHpIZWJzY1QvYS9qWllZOTBhL202YzFhblg5a0Nuc0N3bis5?=
 =?utf-8?B?L003RXNJcXVDTmdWNWlDdjNJblNhdGNVaE4rRzVoS2k3ZXkvMi96b3FEckxo?=
 =?utf-8?B?NzVJQWpyWUJoNmdxUk8wcXBsSERqbVh2TERJbjhOak4zY0N2akhTenkxcE1W?=
 =?utf-8?B?bFVkTEVRYXlRUjN5bUhHaW9yRDY5SGJMQlk2U2R4UDc2bUJMK0tHdTJLZjBR?=
 =?utf-8?B?N0hqVmpIQVZob3BBbHlXSVpYWUVWVzhVVXFiMlRJdnJBU21QUGo2Umk5bG1k?=
 =?utf-8?B?UzZxQ1N1VnFUQmxmeWFmU1NQMXlwMEVaQ3ZtWVc4d3g5bUIwbDdwSEVueEor?=
 =?utf-8?B?b3ZwUjJvMVRUYTIyVHhreXVQeHZvUFA0Z1dsZlJPL1BZc1RPMG5DNWJ2bkMw?=
 =?utf-8?B?cTNRQ0l6SnM4UVZEZjF4ZmdBQ3oxZzlHOTB1NHpkU28za2djbDEzbUY4LzBn?=
 =?utf-8?B?ZnVQeWFlL0tBdWpLZHkxZW5MQmdTcVJEd1V2dlpreGQ3OGMyR1hSaHBTeWtu?=
 =?utf-8?B?aEMwcHUrSUEwK0tsMW5BVGlVWldiQjVVOG9wZ2FCSkhnaVB5alFqcmZ3Vjl1?=
 =?utf-8?B?cHJlYktGankxSnQ3TE5NcndKT0RqT2RteEluTlpyQS96ZVgwM0VHaDhoVndQ?=
 =?utf-8?B?K00vbVlDM2x2TW5TNzNBTVJOeXY2WUc5YlVHZlFVZTluQWV6azNhYURTcFpm?=
 =?utf-8?B?czBUalFwMVYxd3EvWUhIeVd4dThMY1hSS1lWMWNNS2I0Um9KWkJSWVJhRldN?=
 =?utf-8?B?Uk1Qek1Gd0UzcFl0NTE5eTRsR1VJNW9rSWZIYVVsZWc2dVN2dGtic1hhTUtP?=
 =?utf-8?B?YzVPalN2QXhLYmxET09pSGFmQ0V4TEhSaTYzb1VteTBWU3BSMVlTN1BUT1Ft?=
 =?utf-8?B?Rks2V21ySDYwdjNGRVVYZ3M3d2ZScGlhTnY1TzlVYXJhK1dncVBieFFsaFJJ?=
 =?utf-8?B?N0cwd3p0cmNjcUlEd0hhNnJ0SG9QZkNNRmR0blhBa1lSaytPcU5nckdtWlhv?=
 =?utf-8?B?Wk1POENhbjFWZ2doajU4UGFZV1hZQlNndEx5M2NKL05TVFJyN2gzZWhRSktw?=
 =?utf-8?B?MEw4c09ESElsT0Q4MWxUUlNxcUlQUjdkTmpiQ0lPSFI0UFlNbVBRNTZEUkxX?=
 =?utf-8?B?Y3A5WFBaL1o1eFpQZ3pjVnpXbENpUFB3L2xIaWZMTmVPclp1QzdhTHBGM3Bo?=
 =?utf-8?B?aENpWFZibmpoZWhkd3JWa0l0cGNYcURkT2RtakJudTJ1Wjc3VVZwZGh0V254?=
 =?utf-8?B?N3FIaG5hZnpNN3RoejBTVnB6c3RtMkRxU0x6WCt6dTRpZkd6VUVCVm5oTG96?=
 =?utf-8?B?WnVKTkIxZFRIZ1k0LzRkeml3VFdDdG50MlFsc2FjMFZjNFFsc2ZVcnlHeTJK?=
 =?utf-8?B?amo3M1plUWU0ejRhUDRNVC9ZMVBtRmRNalRkWWJJNENDMGtGQXhsUmNKWXpC?=
 =?utf-8?B?dmVta1ZndksxOUlsbG1OOG5oUVRiM1FlS2ZBTCtHR09Vb3RJZUNDNkFmUUhH?=
 =?utf-8?B?U05TVTVvN3U2VExaem5uWEgwL3Q4elJQQ0prY0NGMHdvbFRXd00xWGxGdENO?=
 =?utf-8?B?Tmh5K1JpdG1ldDRrK2hrcC9RQXNTd2VoeTFSMzYweEF6MVQ0TC9JaElxQ0tU?=
 =?utf-8?B?ZVdteTlEUEhpaTFsSno0VlV4Q3IrY1k0azBpdlovRmpVTERMRThOQ1JPNzdJ?=
 =?utf-8?B?NHFpK1lmcnpnQjk1UU9EZmpPcjhHalNZcnZuWEZBUWdEWUZEN2RreHVIMEZB?=
 =?utf-8?B?WEVPU09NQjZyTUpwb0Y4RC9vMzRVUm5mbWRmN0VNNnpkRGRvNC83N2xuWWQ2?=
 =?utf-8?B?ZzZDV1BkSk5PVTlWNWRCQW9JUTNFLzBDTGsxcGo5T1hsZU1YWVdSUnFGUnBt?=
 =?utf-8?B?cDk5NDJ6dlVEb3dpOXdBS3V3bmVtcE5YSWM1QjErbFMvOW1RVlU5dWhnQzYx?=
 =?utf-8?B?Y0Rsa3RVb0pyL2V0enZwQ1J3dVk0TDBnUXJabHdoWE5DS29FeS96R0I5d041?=
 =?utf-8?B?TkZKWjFrb0RRPT0=?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-ID: <FB6DE7B8CBE0ED478B4C8C903ACBA156@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7087
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 1874f76400aa401aaaf00533c09a6c2b:solidrun,office365_emails,sent,inline:934066ba694f68175f9369834bf36a69
Authentication-Results-Original: mx.checkpointcloudsec.com; arc=pass;
 dkim=none header.d=none
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF0000A7E4.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	81ff373e-39ba-45f7-8bde-08ddeee05caa
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|14060799003|35042699022|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U0FVSTBPNWhHZTUyU3Y3YjRieUkvM2lnZTBmVWpLNjBSSzVwaHRLa0RrcDEy?=
 =?utf-8?B?SEhpZ3NrakU3SzBCM0NzQUt4MWFld0VyN05SVDRuVS9SOStMdERGZS9pcEtF?=
 =?utf-8?B?MGZrdVdURk16c3h2aUR3UEJlcjBuMnlQY1M1WFFDOEVBSERTVkpZZ3hVS1Bh?=
 =?utf-8?B?UUtzSG85Uk1PcG5CNmNyWVJIS2hYWU9EamF6aVdVOStGVy8wVDMxUVBlTXR4?=
 =?utf-8?B?U1FER21CNGRlVGViUENxcURJOGhidUEzY3VIV3dRZlg5bXFDanFKMm5YVHY2?=
 =?utf-8?B?cU41c1FmR3RqRU8yT3Z3YUhkd040K2krcXMxQ3ZlYSt3elh4bDZ0NndEUzht?=
 =?utf-8?B?WkxHTDk3Wng4d0ZyRytpMDlhS3VmcG1QL0ttakk4RWlJMmJsLzZ4ZDhnbHhW?=
 =?utf-8?B?UXpRS2s3OFpxWW9IT2xzVnZJMXdYS0M4MUNqNFFHS1hYVTU0SlVCdVlRMVA3?=
 =?utf-8?B?c1lDazJ2VExIVmNBZzZOeVhpVEFlWFkzb0NYakRMN1V1aThqenZzZnE1ZHVB?=
 =?utf-8?B?bk92bXRGR2Z2OTU3bmFtbXludittZmFoTmlKcVM1d2oxR2NjOFdGTWtSUVYx?=
 =?utf-8?B?dVh3aWlqQ3d2dHJpc2d1TlcycmE0M1Y3OVU5SkxPTmltMzFJTVpzakFmdWdu?=
 =?utf-8?B?MW40ek1QeU12RjVJYVBLQXI1OGNZUk9laFFEc0NoODJudWFtbHNNZzhrUjZt?=
 =?utf-8?B?ZVhWMEtaVDJUUXNkN3JTK3lwSnphUE1FUHM3WGk3WXdWSFZseGN6MEZwZmJu?=
 =?utf-8?B?UUVoMHY5ZlRzbVgzaXlLbkp4YU9vWnJvWGdSOHhXQzB1T21Kd1hkOHdKcitB?=
 =?utf-8?B?N3dSMjVtYXBCRzJoK2ZMMCsyVC9OQWc1K01qc2EwWUx0dktHc1VKY3NzbmpO?=
 =?utf-8?B?b3Z2STJKWWdJVHFWMG5qNFUwZVFkd1o5aXVqdlR6ZTB3eENadWpJSVplVVFO?=
 =?utf-8?B?VFZWOG5ycFE1N2hNQUFvbTFtN1lHV3BKVHZtTTg4Tk5VNS9YeXNUbFdNNDlF?=
 =?utf-8?B?WWpmUEVxcWpXVHVGWDZSbEdBbkU4clB1STZrTWNodlg4OXR1L1k3a2FjbTNa?=
 =?utf-8?B?ZkU0c0swdFhCZTl5R0Z1MXhGVmdLeEsybUFqS2M3cFFZTER6TmhMQUR1K2tq?=
 =?utf-8?B?elErb0pPc2ltYlRKVHZNTzFRbUN1cjVBM240M0d4bXlxWkYvKzlONUd2ZzZQ?=
 =?utf-8?B?b25MM2oxOGxpZGlnK0ZoSGs3dVMrbDBjaXlRVDlLdUpabzVzV003ZzJhOU16?=
 =?utf-8?B?TTh6ZGxCUDd6M2crRExDMXhwQ1o3WVpWUEdibmJRRXlkQW5GRXBkUDRTdGZu?=
 =?utf-8?B?N3orMk9paTJYandJR2FQN2JQTDdGbUFNemVZRk1QaGdpK0ZsbEJYTUFTcFN3?=
 =?utf-8?B?ZFlhLzhBUlJLSzRjTzFtdVkxUVJBc3FkeXFjcGxWV1luY0F0eWh2MlBLaWVI?=
 =?utf-8?B?Zi9zRVdFZExVV3AzYVNRRVNRT09ZcUlzZjU4NGZpMGFVUndrZ0d4Nko2TElj?=
 =?utf-8?B?WGpqWXhad24wNHlKQm1vd05UTWRrTldaT1MwQmN4VmpYYU9MMlZwRkFkNlZL?=
 =?utf-8?B?WmlSQVc2MGVTVmIrdTVRaU1iY2JJVGZCMFRieXNzV2gvOEh4ZGp5MWt1UzlR?=
 =?utf-8?B?U0Y4Y3RML2JyeDdPbVVZMnllYVc0d2tBMzRid2FxbzMvbmVQQ0N0QzZhOWNm?=
 =?utf-8?B?Tm5uM3oyWnZrQVAyN3RHeEQ3RS9sKzRic1VsQlhPWm9Vc1RQZ1NzSGNOZDRt?=
 =?utf-8?B?V3IyR01kdVJBdVdrTVJxcjROdkpBOU1aemlaYjNoYnhSSVhrNlVCUzBKVS9K?=
 =?utf-8?B?NFNUbmErclo2MVVBOHViWXdPMFcwWnZhbTd4bkZlclF6MFd5d1ZsTUhQcmpD?=
 =?utf-8?B?RVJLMy94b3JwcGdaRk0xcTdDVFdpaUk3d3AwS3lyaEk1QitYYUgvUFoxM0RM?=
 =?utf-8?B?bmJlVTA2QTBHQnBxZkhXa3dtTVRwYThQNmo0VHNJakQ1dHM2bVZVWFdQTFQ0?=
 =?utf-8?B?SXY3UVBoN2RjQlBzVVRJM0dDTnpLMjlNVjhzRUwzTmp3anN3Ris3eURCaUo1?=
 =?utf-8?Q?zEYlWE?=
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(14060799003)(35042699022)(7416014)(376014)(36860700013);DIR:OUT;SFP:1102;
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 14:02:45.5120
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 822e3aab-5116-4574-53da-08ddeee062e2
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7E4.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7708

DQpBbSAwOC4wOS4yNSB1bSAxMTozNyBzY2hyaWViIFZsYWRpbWlyIE9sdGVhbjoNCj4gT24gRnJp
LCBTZXAgMDUsIDIwMjUgYXQgMDg6MDI6NTlQTSArMDEwMCwgQ29ub3IgRG9vbGV5IHdyb3RlOg0K
Pj4gT24gRnJpLCBTZXAgMDUsIDIwMjUgYXQgMDY6NDE6NTBQTSArMDMwMCwgVmxhZGltaXIgT2x0
ZWFuIHdyb3RlOg0KPj4+IE9uIEZyaSwgU2VwIDA1LCAyMDI1IGF0IDEwOjI5OjMzQU0gKzAyMDAs
IEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+Pj4+PiAgcHJvcGVydGllczoNCj4+Pj4+ICAg
IGNvbXBhdGlibGU6DQo+Pj4+PiAtICAgIGVudW06DQo+Pj4+PiAtICAgICAgLSBmc2wsbHlueC0y
OGcNCj4+Pj4+ICsgICAgb25lT2Y6DQo+Pj4+PiArICAgICAgLSBpdGVtczoNCj4+Pj4+ICsgICAg
ICAgICAgLSBjb25zdDogZnNsLGx5bngtMjhnDQo+Pj4+IERvbid0IGNoYW5nZSB0aGF0IHBhcnQu
IFByZXZpb3VzIGVudW0gd2FzIGNvcnJlY3QuIFlvdSB3YW50IG9uZU9mIGFuZA0KPj4+PiBlbnVt
Lg0KPj4+IENvbWJpbmluZyB0aGUgZmVlZGJhY2sgZnJvbSBDb25vciBhbmQgSm9zdWEsIEkgc2hv
dWxkIG9ubHkgYmUgcGVybWl0dGluZw0KPj4+IHRoZSB1c2Ugb2YgImZzbCxseW54LTI4ZyIgYXMg
YSBmYWxsYmFjayB0byAiZnNsLGx4MjE2ezAsMn1hLXNlcmRlc3sxLDJ9IiwNCj4+PiBvciBzdGFu
ZGFsb25lLiBUaGUgZGVzY3JpcHRpb24gYmVsb3cgYWNoaWV2ZXMganVzdCB0aGF0LiBEb2VzIGl0
IGxvb2sgb2sNCj4+PiB0byB5b3U/DQo+Pj4NCj4+PiBwcm9wZXJ0aWVzOg0KPj4+ICAgY29tcGF0
aWJsZToNCj4+PiAgICAgb25lT2Y6DQo+Pj4gICAgICAgLSBlbnVtOg0KPj4+ICAgICAgICAgICAt
IGZzbCxseDIxNjBhLXNlcmRlczENCj4+PiAgICAgICAgICAgLSBmc2wsbHgyMTYwYS1zZXJkZXMy
DQo+Pj4gICAgICAgICAgIC0gZnNsLGx4MjE2MGEtc2VyZGVzMw0KPj4+ICAgICAgICAgICAtIGZz
bCxseDIxNjJhLXNlcmRlczENCj4+PiAgICAgICAgICAgLSBmc2wsbHgyMTYyYS1zZXJkZXMyDQo+
Pj4gICAgICAgLSBjb25zdDogZnNsLGx5bngtMjhnDQo+Pj4gICAgICAgICBkZXByZWNhdGVkOiB0
cnVlDQo+Pj4gICAgICAgLSBpdGVtczoNCj4+PiAgICAgICAgICAgLSBjb25zdDogZnNsLGx4MjE2
MGEtc2VyZGVzMQ0KPj4+ICAgICAgICAgICAtIGNvbnN0OiBmc2wsbHlueC0yOGcNCj4+PiAgICAg
ICAgIGRlcHJlY2F0ZWQ6IHRydWUNCj4+PiAgICAgICAtIGl0ZW1zOg0KPj4+ICAgICAgICAgICAt
IGNvbnN0OiBmc2wsbHgyMTYwYS1zZXJkZXMyDQo+Pj4gICAgICAgICAgIC0gY29uc3Q6IGZzbCxs
eW54LTI4Zw0KPj4+ICAgICAgICAgZGVwcmVjYXRlZDogdHJ1ZQ0KPj4+ICAgICAgIC0gaXRlbXM6
DQo+Pj4gICAgICAgICAgIC0gY29uc3Q6IGZzbCxseDIxNjJhLXNlcmRlczENCj4+PiAgICAgICAg
ICAgLSBjb25zdDogZnNsLGx5bngtMjhnDQo+Pj4gICAgICAgICBkZXByZWNhdGVkOiB0cnVlDQo+
Pj4gICAgICAgLSBpdGVtczoNCj4+PiAgICAgICAgICAgLSBjb25zdDogZnNsLGx4MjE2MmEtc2Vy
ZGVzMg0KPj4+ICAgICAgICAgICAtIGNvbnN0OiBmc2wsbHlueC0yOGcNCj4+PiAgICAgICAgIGRl
cHJlY2F0ZWQ6IHRydWUNCj4+IFRoaXMgZG9lc24ndCByZWFsbHkgbWFrZSBzZW5zZSwgbm9uZSBv
ZiB0aGVzZSBhcmUgY3VycmVudGx5IGluIHVzZQ0KPj4gcmlnaHQ/IEV2ZXJ5dGhpbmcgaXMganVz
dCB1c2luZyBmc2wsbHlueC0yOGcgcmlnaHQ/DQo+PiBBZGRpbmcgbmV3IHN0dWZmIGFuZCBpbW1l
ZGlhdGVseSBtYXJraW5nIGl0IGRlcHJlY2F0ZWQgaXMgYQ0KPj4gY29udHJhZGljdGlvbiwganVz
dCBkb24ndCBhZGQgaXQgYXQgYWxsIGlmIHlvdSBkb24ndCB3YW50IHBlb3BsZSB1c2luZw0KPj4g
aXQuIEFueSB1c2VycyBvZiBpdCB3b3VsZCBiZSBzb21ldGhpbmcgeW91J3JlIGdvaW5nIHRvIHJl
dHJvZml0IGluIG5vdywNCj4+IHNvIHlvdSBtYXkgYXMgd2VsbCBqdXN0IHJldHJvZml0IHRvIHVz
ZSB3aGF0IHlvdSB3YW50IHBlb3BsZSB0byB1c2UNCj4+IGdvaW5nIGZvcndhcmQsIHdoaWNoIGhh
cyBubyBmYWxsYmFja3MuDQo+IFlvdSdyZSByaWdodCB0aGF0IGl0IGRvZXNuJ3QgbWFrZSBzZW5z
ZSB0byBkZXByZWNhdGUgYSBuZXdseSBpbnRyb2R1Y2VkDQo+IGNvbXBhdGlibGUgc3RyaW5nIHBh
aXIgLSBteSBtaXN0YWtlIGZvciBtaXN1bmRlcnN0YW5kaW5nICJkZXByZWNhdGVkIi4NCj4NCj4+
IEkgZGlkbid0IHJlYWQgdGhlIGJhY2sgYW5kIGZvcnRoIHdpdGggSm9zdWEgKHNvcnJ5ISkgYnV0
IGlzIHRoZSBmYWxsYmFjaw0KPj4gZXZlbiB2YWxpZD8gRG8gdGhvc2UgZGV2aWNlcyBoYXZlIGEg
Y29tbW9uIG1pbmltdW0gc2V0IG9mIGZlYXR1cmVzIHRoYXQNCj4+IHRoZXkgc2hhcmU/DQo+IEkn
bGwgdHJ5IHRvIG1ha2UgYW4gYXJndW1lbnQgYmFzZWQgb24gdGhlIGZhY3RzIHByZXNlbnRlZCBi
ZWxvdy4NCj4NCj4gVGhlIGN1cnJlbnQgTGludXggZHJpdmVyLCB3aGljaCByZWNvZ25pemVzIG9u
bHkgImZzbCxseW54LTI4ZyIsIHN1cHBvcnRzDQo+IG9ubHkgMUdiRSBhbmQgMTBHYkUuIFRoZXJl
IGFyZSBvdGhlciBTZXJEZXMgcHJvdG9jb2xzIHN1cHBvcnRlZCBieSB0aGUNCj4gU2VyRGVzLCBi
dXQgdGhleSBhcmUgaXJyZWxldmFudCBmb3IgdGhlIHB1cnBvc2Ugb2YgZGlzY3Vzc2luZw0KPiBj
b21wYXRpYmlsaXR5LiBBbHNvLCBMWDIxNjBBIFNlckRlcyAjMyBpcyBhbHNvIGlycmVsZXZhbnQs
IGJlY2F1c2UgaXQgaXMNCj4gbm90IGN1cnJlbnRseSBkZXNjcmliZWQgaW4gdGhlIGRldmljZSB0
cmVlLg0KPg0KPiAxR2JFIGNvbXBhdGliaWxpdHkgdGFibGUNCj4NCj4gU2VyRGVzICAgICAgICAg
ICAgICBMYW5lIDAgIExhbmUgMSAgTGFuZSAyICBMYW5lIDMgIExhbmUgNCAgTGFuZSA1ICBMYW5l
IDYgIExhbmUgNyAgIENvbW1lbnRzDQo+IExYMjE2MEEgU2VyRGVzICMxICAgeSAgICAgICB5ICAg
ICAgIHkgICAgICAgeSAgICAgICB5ICAgICAgIHkgICAgICAgeSAgICAgICB5DQo+IExYMjE2MEEg
U2VyRGVzICMyICAgeSAgICAgICB5ICAgICAgIHkgICAgICAgeSAgICAgICB5ICAgICAgIHkgICAg
ICAgeSAgICAgICB5DQo+IExYMjE2MkEgU2VyRGVzICMxICAgbi9hICAgICBuL2EgICAgIG4vYSAg
ICAgbi9hICAgICB5ICAgICAgIHkgICAgICAgeSAgICAgICB5ICAgICAgICBMWDIxNjJBIGN1cnJl
bnRseSB1c2VzIGx4MjE2MGEuZHRzaQ0KPiBMWDIxNjJBIFNlckRlcyAjMiAgIHkgICAgICAgeSAg
ICAgICB5ICAgICAgIHkgICAgICAgeSAgICAgICB5ICAgICAgIHkgICAgICAgeSAgICAgICAgTFgy
MTYyQSBjdXJyZW50bHkgdXNlcyBseDIxNjBhLmR0c2kNCj4NCj4gMTBHYkUgY29tcGF0aWJpbGl0
eSB0YWJsZQ0KPg0KPiBTZXJEZXMgICAgICAgICAgICAgIExhbmUgMCAgTGFuZSAxICBMYW5lIDIg
IExhbmUgMyAgTGFuZSA0ICBMYW5lIDUgIExhbmUgNiAgTGFuZSA3ICAgQ29tbWVudHMNCj4gTFgy
MTYwQSBTZXJEZXMgIzEgICB5ICAgICAgIHkgICAgICAgeSAgICAgICB5ICAgICAgIHkgICAgICAg
eSAgICAgICB5ICAgICAgIHkNCj4gTFgyMTYwQSBTZXJEZXMgIzIgICBuICAgICAgIG4gICAgICAg
biAgICAgICBuICAgICAgIG4gICAgICAgbiAgICAgICB5ICAgICAgIHkNCj4gTFgyMTYyQSBTZXJE
ZXMgIzEgICBuL2EgICAgIG4vYSAgICAgbi9hICAgICBuL2EgICAgIHkgICAgICAgeSAgICAgICB5
ICAgICAgIHkgICAgICAgIExYMjE2MkEgY3VycmVudGx5IHVzZXMgbHgyMTYwYS5kdHNpDQo+IExY
MjE2MkEgU2VyRGVzICMyICAgbiAgICAgICBuICAgICAgIG4gICAgICAgbiAgICAgICBuICAgICAg
IG4gICAgICAgeSAgICAgICB5ICAgICAgICBMWDIxNjJBIGN1cnJlbnRseSB1c2VzIGx4MjE2MGEu
ZHRzaQ0KPg0KPiBBcyBMWDIxNjBBIFNlckRlcyAjMiBpcyB0cmVhdGVkIGxpa2UgIzEsIHRoZSBk
ZXZpY2UgdHJlZSBpcyB0ZWxsaW5nIHRoZQ0KPiBkcml2ZXIgdGhhdCBhbGwgbGFuZXMgc3VwcG9y
dCAxMEdiRSAod2hpY2ggaXMgZmFsc2UgZm9yIGxhbmVzIDAtNSkuDQo+DQo+IElmIG9uZSBvZiB0
aGUgU2VyRGVzIFBMTHMgaGFwcGVucyB0byBiZSBwcm92aXNpb25lZCBmb3IgdGhlIDEwR2JFIGNs
b2NrDQo+IG5ldCBmcmVxdWVuY3ksIGFzIGZvciBleGFtcGxlIHdpdGggdGhlIFJDV1tTUkRTX1BS
VENMX1MyXT02IHNldHRpbmcsDQo+IHRoaXMgd2lsbCBtYWtlIHRoZSBkcml2ZXIgdGhpbmsgdGhh
dCBpdCBjYW4gcmVjb25maWd1cmUgbGFuZXMgMC01IGFzDQo+IDEwR2JFLg0KPg0KPiBUaGlzIHdp
bGwgZGlyZWN0bHkgYWZmZWN0IHVwcGVyIGxheWVycyAocGh5bGluayksIHdoaWNoIHdpbGwgYWR2
ZXJ0aXNlDQo+IDEwR2JFIG1vZGVzIHRvIGl0cyBsaW5rIHBhcnRuZXIgb24gcG9ydHMgd2hpY2gg
c3VwcG9ydCBvbmx5IDFHYkUsIGFuZA0KPiB0aGUgbm9uLWZ1bmN0aW9uYWwgbGluayBtb2RlIG1p
Z2h0IGJlIHJlc29sdmVkIHRocm91Z2ggbmVnb3RpYXRpb24sIHdoZW4NCj4gYSBsb3dlciBzcGVl
ZCBidXQgZnVuY3Rpb25hbCBsaW5rIGNvdWxkIGhhdmUgYmVlbiBlc3RhYmxpc2hlZC4NCj4NCj4g
WW91IG1lbnRpb24gYSBjb21tb24gbWluaW11bSBmZWF0dXJlIHNldC4gVGhhdCB3b3VsZCBiZSBz
dXBwb3J0aW5nIDEwR2JFDQo+IG9ubHkgb24gbGFuZXMgNi03LCB3aGljaCB3b3VsZCBiZSBkaXNh
ZHZhbnRhZ2VvdXMgdG8gZXhpc3RpbmcgdXNlcyBvZg0KPiAxMEdiRSBvbiBsYW5lcyAwLTUgb2Yg
U2VyRGVzICMxLiBJbiBzb21lIGNhc2VzLCB0aGUgY2hhbmdlIG1pZ2h0IGFsc28gYmUNCj4gYnJl
YWtpbmcgLSB0aGVyZSBtaWdodCBiZSBhIFBIWSBhdHRhY2hlZCB0byB0aGVzZSBsYW5lcyB3aG9z
ZSBmaXJtd2FyZQ0KPiBpcyBoYXJkY29kZWQgdG8gZXhwZWN0IDEwR2JFLCBzbyB0aGVyZSB3b24n
dCBiZSBhIGdyYWNlZnVsIGRlZ3JhZGF0aW9uDQo+IHRvIDFHYkUgaW4gYWxsIGNhc2VzLg0KPg0K
PiBXaXRoIEpvc3VhJ3MgcGVybWlzc2lvbiwgSSB3b3VsZCBjb25zaWRlciBjb21taXQgMmYyOTAw
MTc2YjQ0ICgiYXJtNjQ6DQo+IGR0czogbHgyMTYwYTogZGVzY3JpYmUgdGhlIFNlckRlcyBibG9j
ayAjMiIpIGFzIGJyb2tlbiwgZm9yIGJlaW5nIGFuDQo+IGluY29ycmVjdCBkZXNjcmlwdGlvbiBv
ZiBoYXJkd2FyZSAtIGl0IGlzIHByZXNlbnRlZCBhcyBpZGVudGljYWwgdG8NCj4gYW5vdGhlciBk
ZXZpY2UsIHdoaWNoIGhhcyBhIGRpZmZlcmVudCBzdXBwb3J0ZWQgZmVhdHVyZSBzZXQuIEkgd2ls
bCBub3QNCj4gdHJ5IHRvIGtlZXAgU2VyRGVzICMyIGNvbXBhdGlibGUgd2l0aCAiZnNsLGx5bngt
MjhnIi4gVGhpcyB3aWxsIHJlbWFpbg0KPiBzeW5vbnltb3VzIG9ubHkgd2l0aCBTZXJEZXMgIzEu
IFRoZSB1c2VycyBvZiB0aGUgZnNsLWx4MjE2MmEtY2xlYXJmb2cuZHRzDQo+IHdpbGwgbmVlZCB1
cGRhdGluZyBpZiB0aGUgInVuZGV0ZWN0ZWQgbGFjayBvZiBzdXBwb3J0IGZvciAxMEdiRSIgYmVj
b21lcw0KPiBhbiBpc3N1ZS4NCj4NCj4gTXkgdXBkYXRlZCBwbGFuIGlzIHRvIGRlc2NyaWJlIHRo
ZSBzY2hlbWEgcnVsZXMgZm9yIHRoZSBjb21wYXRpYmxlIGFzDQo+IGZvbGxvd3MuIElzIHRoYXQg
b2sgd2l0aCBldmVyeW9uZT8NCj4NCj4gcHJvcGVydGllczoNCj4gICBjb21wYXRpYmxlOg0KPiAg
ICAgb25lT2Y6DQo+ICAgICAgIC0gY29uc3Q6IGZzbCxseW54LTI4Zw0KPiAgICAgICAgIGRlcHJl
Y2F0ZWQ6IHRydWUNCj4gICAgICAgLSBpdGVtczoNCj4gICAgICAgICAgIC0gY29uc3Q6IGZzbCxs
eDIxNjBhLXNlcmRlczENCj4gICAgICAgICAgIC0gY29uc3Q6IGZzbCxseW54LTI4Zw0KPiAgICAg
ICAtIGVudW06DQo+ICAgICAgICAgICAtIGZzbCxseDIxNjBhLXNlcmRlczINCj4gICAgICAgICAg
IC0gZnNsLGx4MjE2MGEtc2VyZGVzMw0KPiAgICAgICAgICAgLSBmc2wsbHgyMTYyYS1zZXJkZXMx
DQo+ICAgICAgICAgICAtIGZzbCxseDIxNjJhLXNlcmRlczINCldlYWsgb2JqZWN0aW9uLCBJIHRo
aW5rIHRoaXMgaXMgbW9yZSBjb21wbGV4IHRoYW4gaXQgc2hvdWxkIGJlLg0KUGVyaGFwcyBpdCB3
YXMgZGlzY3Vzc2VkIGJlZm9yZSB0byBrZWVwIHR3byBjb21wYXRpYmxlIHN0cmluZ3MgLi4uOg0K
DQpwcm9wZXJ0aWVzOg0KwqAgY29tcGF0aWJsZToNCsKgIMKgIGl0ZW1zOg0KwqAgwqAgwqAgLSBl
bnVtOg0KwqAgwqAgwqAgwqAgwqAgLSBmc2wsbHgyMTYwYS1zZXJkZXMyDQrCoCDCoCDCoCDCoCDC
oCAtIGZzbCxseDIxNjBhLXNlcmRlczMNCsKgIMKgIMKgIMKgIMKgIC0gZnNsLGx4MjE2MmEtc2Vy
ZGVzMQ0KwqAgwqAgwqAgwqAgwqAgLSBmc2wsbHgyMTYyYS1zZXJkZXMyDQrCoCDCoCDCoCAtIGNv
bnN0OiBmc2wsbHlueC0yOGcNCg0KVGhpcyB3aWxsIGNhdXNlIHRoZSBkdGJzX2NoZWNrIHRvIGNv
bXBsYWluIGFib3V0IGFueW9uZSBpbiB0aGUgZnV0dXJlDQp1c2luZyBpdCB3cm9uZy4NCg0KVGhl
IGRyaXZlciBjYW4gc3RpbGwgcHJvYmUgb24gZnNsLGx5bngtMjhnIGFsb25lIGZvciBiYWNrd2Fy
ZHMgY29tcGF0aWJpbGl0eSwNCmFuZCB5b3UgY2FuIGxpbWl0IHRoZSBmZWF0dXJlLXNldCBhcyB5
b3Ugc2VlIGZpdCBpbiBzdWNoIGNhc2UuDQoNCk1haW4gYXJndW1lbnQgZm9yIGFsd2F5cyBzcGVj
aWZ5aW5nIGx5bngtMjhnIGlzIHRoYXQgdGhlIHNlcmRlcyBibG9ja3MNCmRvIHNoYXJlIGEgY29t
bW9uIHByb2dyYW1taW5nIG1vZGVsIGFuZCByZWdpc3RlciBkZWZpbml0aW9ucy4NCg0KPg0KPiBB
bHNvLCBJIHdpbGwgbGltaXQgdGhlIGRyaXZlciBzdXBwb3J0IGZvciB0aGUgImZzbCxseW54LTI4
ZyIgY29tcGF0aWJsZQ0KPiB0byBqdXN0IDFHYkUgYW5kIDEwR2JFLiBUaGUgMjVHYkUgZmVhdHVy
ZSBpbnRyb2R1Y2VkIGJ5IHRoaXMgc2VyaWVzIHdpbGwNCj4gcmVxdWlyZSBhIG1vcmUgcHJlY2lz
ZSBjb21wYXRpYmxlIHN0cmluZy4NCk9rYXkNCg==

