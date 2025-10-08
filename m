Return-Path: <linux-kernel+bounces-845417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AD097BC4CC9
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 14:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 31BCA351D49
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 12:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4582472BB;
	Wed,  8 Oct 2025 12:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TqEkxnMq"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011019.outbound.protection.outlook.com [52.101.70.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A126713957E;
	Wed,  8 Oct 2025 12:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759926684; cv=fail; b=IC79oY1185SIolniGcp0czEjZwYwlKv36+vG+1tnUZOOaD/pmk2Oa6FTJen3g5IX1HvUsSHa0V2VHOiRjUxcGEJp1g7FVInkU/foQRVTUDoVK1Hy5QooadQRJcYd6o+SbWnxnykUwMehF22liNi5HR1jcylpj2QUpnBmXY7HhhA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759926684; c=relaxed/simple;
	bh=c9Pd2qFHMNT9kOblIK2sfbwvvliaQcEIVmHAw4ny43w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=j13V1AmpzY0QmZ2qRSaHRaArGjOypeGL1NRSe7SLzAn8OSKsaIezQ/douqvCyq7KVPQzFd+pKbxtotx/+mpNSJ8nXKCiVf+UJugKQJCUfXJRhvpJCrhZqI37Zgq3/Z39qHmGSfTlbyEmkYHJM6A4ZdYkr5sdgA6KHUdZ6LwZSk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TqEkxnMq; arc=fail smtp.client-ip=52.101.70.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OMAT31X3owePsLw8GUMiZh+SNLwP1nakbByibB3e+/IM3ntAgMasTTY3dwHDB6sgenWajSaqZ+F/u/NgkJtQx/tHyDWFrd3SraZ/2eWWqPfXsZ0k1bP5EgiEVj5QmPno4NYC11APfCMJOkBWkJBt8AGypkAPlPoYh4BSr8Bmv5FsBNHkPnAPqjtuMCSFAlMPgA87MO37jfaBjoi9MyX5Mx7LTd/ZWPWlaXdveHO7Ha0WSQL5ps7v0UYBoabPITzlPeJifdInfIwk90nTbbclz5amnjwFSatzxKwycFUl8VCUk8hX3KqxHlgc9JQwIyx/lr4bnzcQf/2h5Z31b978pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c9Pd2qFHMNT9kOblIK2sfbwvvliaQcEIVmHAw4ny43w=;
 b=xcAOiQ91kziH46561iUC2Rfx3djyG3s4QohErTFC2NGKSQ3ypNxeu9xOyjB2EITNWfl3rI6tHevSfXrSarsCWACVCZnGA88/GyxvkmIuJ9d+kd2sHqOY9Au1tGlPRnAjP/ZMxu2dXiJWtrlUAdel7yFGcxqO3aAlUakUjkjZb+m5bXyWkYAnuth3+1TsUu9NXEP8nxUrGo4KvVwr22K14iofnf8EwM/kJWBw6o5iFDK+c87hF3/qzraZcrkR2WYCGUHeZU0zMCZTzx3R8Yz/VfnBNKhMG64CRciyI8s/rR99Sv1hBjM6QoCxfkbtUrmZ4PKN72SjpdsusuZIQiudkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c9Pd2qFHMNT9kOblIK2sfbwvvliaQcEIVmHAw4ny43w=;
 b=TqEkxnMqueFdc9dTMt5oddBo5/btQ6kkiuekfLmz+kvNXA+SDGJoUqq9tcaSRkX+lH/J/HgZjwaFj1jsFtsgAoUyc7ExEbZxVlQxQzlCYezwdNwJvwXUSXj0PTlePqGX5689R4i8nZS143Vt3TNInhYu2pDR8uIn9gEJ1yj9B+EnyDSIPdGACv7HpJZrqnZepS0yt2f5YGYKpwduE+T2v3KoYdxJomioDi0d1+2Lv4r7u4j+1uwoVWn3qOWpYkiAHow89DHGJaiL9Lk/M6DBSHiX68qod6RSf7uo/DScje2Dj/ee/uSas9ivHiQmeBgpCCab21HQOc1kuQ/V4P/vAg==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM8PR04MB7332.eurprd04.prod.outlook.com (2603:10a6:20b:1db::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 8 Oct
 2025 12:31:14 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9203.007; Wed, 8 Oct 2025
 12:31:14 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Sebin Francis <sebin.francis@ti.com>, Michael Turquette
	<mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Sudeep Holla
	<sudeep.holla@arm.com>, Cristian Marussi <cristian.marussi@arm.com>, Marco
 Felsch <m.felsch@pengutronix.de>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Brian
 Masney <bmasney@redhat.com>, Dhruva Gole <d-gole@ti.com>
CC: Dan Carpenter <dan.carpenter@linaro.org>, Geert Uytterhoeven
	<geert@linux-m68k.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "arm-scmi@vger.kernel.org"
	<arm-scmi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: RE: [PATCH v4 3/5] clk: conf: Support assigned-clock-sscs
Thread-Topic: [PATCH v4 3/5] clk: conf: Support assigned-clock-sscs
Thread-Index: AQHcJhr8i1ojkZicfEuPE8OTKy/6jLS1ECKAgANBA/A=
Date: Wed, 8 Oct 2025 12:31:14 +0000
Message-ID:
 <PAXPR04MB845901FCD95CFEBCF22AB34588E1A@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250915-clk-ssc-version1-v4-0-5a2cee2f0351@nxp.com>
 <20250915-clk-ssc-version1-v4-3-5a2cee2f0351@nxp.com>
 <98d588bd-7b46-4df4-b31c-2bb53a47c279@ti.com>
In-Reply-To: <98d588bd-7b46-4df4-b31c-2bb53a47c279@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AM8PR04MB7332:EE_
x-ms-office365-filtering-correlation-id: 15f52814-1185-4f13-83f2-08de06669279
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|7416014|19092799006|38070700021|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?NzFoRHdyUmVtWTVOVjZJRE1DaDNqd2xXSlRuV2RTSHh2L1crdlQ0NVRkUE1t?=
 =?utf-8?B?aFpwdFhXaFc2WFltbHpPMTVpRm85RCt4MEdSOE5DUFlONUNFNWM0c0JSNlZP?=
 =?utf-8?B?MXdySEVDMDFUdnU0TW9zWkhwbUtteE9qYitMRkpZN0NtYjFwU05Xb0hqb2lS?=
 =?utf-8?B?Yzg5YUVyRE1VWEg2Tkg5RncwWm1FVS9wRFBPWG1XZkRqSVBWM3J0R2lROTFy?=
 =?utf-8?B?OWlSYlUvOUR2YWtTT0plT0x4dVByOGR1WXJ1YnpUTlNUZ3loNkljMjYxeWdS?=
 =?utf-8?B?cERRUEhZSjUyeDBrN1BUUUd2UmlmdEtmNHUyV21ValBGdTllWmNMUHNySmJ0?=
 =?utf-8?B?M0J1aWFTNnlCenRMR29jMmx1cmExenozdzA2VnowcjliZW1CMFk5NXlhbmp2?=
 =?utf-8?B?c3FCRW0vMGpaeEMyTks2bkNwWEI0ZWtKSnpNdjhZTkIwVW12ekNrdndDZ2VW?=
 =?utf-8?B?Qm1Ob2NQZHoxeE5uQ1E3dER0RXdmaitWOHE5VG1rb2VsQnExYU5mUk5XZEV6?=
 =?utf-8?B?MlNwV2I4NDEvNnBFS0ZhdWROaHRXQ1ltdU1VZFcwS2E0dWxacGk1WHZHdjJ5?=
 =?utf-8?B?WWxxdTg5V3R3T2xLeFB1WGx4RUlDanZSeFc4bjY0NnZZbHBBa2t2RWZBU2U2?=
 =?utf-8?B?NVhBWlFUaFpKcnR2WENMeGpLY1N0SDRQdVJaWFhwMHlHdTY1TlgwQzZtaVcy?=
 =?utf-8?B?N0c0SmxrY1N2YXB2WHdzTFEzUjM5TU5DcW1lUGo3TnVKU0JJNU5qZDJ2UmJk?=
 =?utf-8?B?ZVFFZGRISmxkQmw5aXQxM1JVYjR3bEUrMGlnYzBJM0tQQTJMY2g5cDhoVEw0?=
 =?utf-8?B?aDZoaEQwTFpVdEZMS0VHNTB4ajdQOTFsZzZNdkFlUjlBQ0FHOU9hMnBSQVFQ?=
 =?utf-8?B?L2h1NndpMk9oTSs0WjV0Sy9yWEM4dEYzV3VOOGZ5UU1xelpQeUVQdHpvQlE0?=
 =?utf-8?B?T1EvdjY5dWV1bzJQUXJIT0pYRU9TVXZaM3hTbWVrQ3BiU0dlS3JiSUtaMlRj?=
 =?utf-8?B?RXpmSHFKMHAzZ015TENaME5zOUlzZVJyMjJlc0FVcHZmR2VyWHFoOFFZaUJN?=
 =?utf-8?B?K01rdmIwZ0YyR3NwdjM5SSt2ZW4yTXBXK3Q2MXdHNUhWWFpHSk9FS2w4eDFw?=
 =?utf-8?B?L3BPczlNN2x1OEFsNkpKcVBRNUVtdjZOcUNjLzVISEhZb1QxNUwxd2p1MUJr?=
 =?utf-8?B?SGxldlk1eW5EUUovSTRTTTRZWVFMNnAzWEYyM2FkcVJaQUFtVS9LMmNRazJU?=
 =?utf-8?B?ZWdVbHZQcGJPVzhFRU9RZTVhM1NmMDMzbkFGUzNWOEFpbEVTeVpDRVQzOHBm?=
 =?utf-8?B?ajVJNzFtT2hyTGhWQXMvMnlJTW9ORmdwZGpoOG9PUUpaSHEzREpQb1MrYlBN?=
 =?utf-8?B?Yk9wWStvNHZFVG9PbVlHbzVYaHhUenVkUVJWc2dKcU85TVlzQ0lqVTYvdHZj?=
 =?utf-8?B?c0tHcXFyWG1yL2Z4NWhPR0xxMlIveU1meHRWMWd4eEtCQWlySHA2SGwwTzdl?=
 =?utf-8?B?bFUxNjdjVDBIUm0xK1hUTkFlUGRJNk9QNFJEQmxIUE50MkJWTDk0dndQdC9M?=
 =?utf-8?B?RU9OQ3FKelZpbW95bm9PanIrZVdMNk1IME1zK2ZoWnlTMlNjKzhGYi9uakxx?=
 =?utf-8?B?aWVwcGRBOTFVckQ2N1RTdXNWa1BwVjIva3ZrUW0vektzaENxaXJ6YUd3eTNK?=
 =?utf-8?B?bHdQbHVlV2tSTEZKNlpPV0xyL1JabFBVRVdMMkV1M0xqaGsybzVNcEw2bnhR?=
 =?utf-8?B?SzN6aUtEN0lrSmdDeG91SWF2YjIzMy9nUzdKVUNGYkFNZkFaSmZ1dEFhYk5w?=
 =?utf-8?B?RGVTWk5SaG1BekNIcXpycDdTRVRzSjY2Y3E2LzB2WHRDenlYMlFJWGQvTWRD?=
 =?utf-8?B?N3hZWHNKYTNwMDhnQjNsQUFXVE94T3RBdnZvT0wxRnBqalhVazF5ZlV3WnpU?=
 =?utf-8?B?S2t4VDZ4L1RxaDJVSDlMVVdvQ1ZpN2dMTThDdVBaa3V4UWYxb1BLM3VDZUI0?=
 =?utf-8?B?cmswVjA4SVBZWUk0K1AwanZleExmdTVKWlB4anhmajdFekZBalpxaEFFZml6?=
 =?utf-8?B?a2k1MUJIS0hrNUpyNThtdUdGUk54R1VkU21Cdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(19092799006)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L01aOGZvVFQ5a1VvdnFOUVVaeWMxc1NENWlwWnRDVnZKd1ZibDUzUW9Tc2ly?=
 =?utf-8?B?b3EzbStyMFg0Zit3cjlHZUpxTlZNUWNOdS8veUJyZkJrNklPamdNbzRWWHBU?=
 =?utf-8?B?THhGdUtXOUUvMjRnaXRtK0R3d2o5eGJPa2o1M0U5VkRHdHFwQys5REdPdVhm?=
 =?utf-8?B?QWs1cnhSc0V0NFM5YTl0RmNtQnhKNWd3bWlSazJzUE96bmlLc0JISDNDaHNX?=
 =?utf-8?B?UzVXb0I4Y1lBVThCNVNBcENkNE5YZlA2SEpwNHFmRlY0UDI1SzhQeWlJS1E0?=
 =?utf-8?B?OUROT1pSR1JOTVYvUUZNZ1BNM3VDZE1NUGxDYWRFSnJwcTlVR05qZ0dyc1lN?=
 =?utf-8?B?MUtScFRReDNvd1BXb0pIN3M2NmhEWjh1Q09wMHZhTFVDbjhuOXNCeWJvejBw?=
 =?utf-8?B?cDVxeGZVWVRMNERGTklTdk5QNFh1VlR2YUNhLy96Mm5lb09OdDBkSy9IWGQr?=
 =?utf-8?B?NXEzOHlUN1VyVUVDL2kveGxKa2hnVWtqNjlVSWdiQWQxRG0ya01qV0JlRE1Q?=
 =?utf-8?B?L2xSVkhXcWlJWXUxKzF1YWxFMU1CZkZEdnhRRmdnYXRhT3FSVmxhaSsvM1NR?=
 =?utf-8?B?T3BtYkVCbVc0WHppTzR6alR1Y05qNGh5aGRMQVZZbGtRM0JFN0QrQkNhbU5F?=
 =?utf-8?B?SXV3QVhHbDhKR2lqNDhPaE5mdnZrWWYzclBJMkJPOGRlV0hPK2tMMzFPUld5?=
 =?utf-8?B?N1JBZUF1aFordHZRTTJ6cTJOYWFtQ3paRzR3cFhadDVoMEt1KzZELzdML0NE?=
 =?utf-8?B?SW9kL1d1S0JEbnMrRG1VNjk0RmpSVXRjam5FM2dIcU8yNElOdHpjN1NVaUht?=
 =?utf-8?B?SlQ3VWpTdVhWaWp6eXFyL0VocWlVdHUvRHBTMTZlZCtkSkpqL1ZGbXJ5VVI3?=
 =?utf-8?B?QWlpMjNNOE9mNU13UTdqL1NCWkx0WGpPWmpHaGJlYnk4R2tUVUV6SDN5c3NW?=
 =?utf-8?B?R2hoRmFyR250a1ROSUhsZTF1NGFyaFFhK3hhRTFQdDNndWRLeEpqL0ZRMUtC?=
 =?utf-8?B?d3FOdHRyMUlHUXUxRXRaNm5rSUFDUWE5cmUyQ3hGYUkxZjlMZTc5Y3M5R2Ev?=
 =?utf-8?B?aUd0M2Vza1RWYXVZcTVoMWtHQUVROTlyRGxpQ0xRT3VxdjNPZ2xORXovMmoy?=
 =?utf-8?B?NmY2RnQzdUhOemR0aXpZb3dSbVpPVmg2U0VoMFlsaEhWOVRSTWJiVXc4OEFB?=
 =?utf-8?B?WGhtLytuNlZndnk5S1hERkVyZG9jS1ZocW5xaEJlUWFVSDlYUTlmTUZycTJK?=
 =?utf-8?B?aDdsRm5RdFdaMWM4RDlyVXZlVUROS0RGL0dNRHR1ZUNOalE2S1AyZU8vc085?=
 =?utf-8?B?WWdWVldBbmJIeUpnWjZWUXB5dGs2TVlBN2hHbnNGN09XWVdzcHJ0dzlFbG5p?=
 =?utf-8?B?Y0RIUGJFaVVpbFBCazhTdUdtWjJpdlRoOSt4WXk2RC8vUThydHRKV0ZBcVZh?=
 =?utf-8?B?NTZKNnpKbnJzWm9lVVVybElJWkI1Tzd3Skp1R1hmQXltamV2YnBkR3cvZ3Vo?=
 =?utf-8?B?LzBTc2VPcE55cll2T3ZQYWVqdHpNRndVQm5QZlhxdXQ2TXlieUVEc1lrM3Jz?=
 =?utf-8?B?TlpEK3NpeTF3ZE1UZDd2VFkyaFJjZ3M0M0JXNzJRYURPdUtiaG9MSGxLYW9a?=
 =?utf-8?B?T0JzblJHaGg4d25vWWNCMkh1cVJON1VRd1VBMFBlYU8rd0lhanJ2RG95djdy?=
 =?utf-8?B?Mmo5dnd5bGRDOG5DbDJiaTV0a0hjL01HYlJxdTVvUm5mUmRpZ2ZJY21xaE5h?=
 =?utf-8?B?b2Q1MEhEM1dUUlBJNmd2WDBBMXkyYTZuMUNPZUJ0WFI5VyttQ0hyZ0ZTMmdj?=
 =?utf-8?B?RGl0QVNObHB1YlQ1V01tWkxoaExWWUQ0bnBPUHZkRStKTXVUVW1KTUg3VStM?=
 =?utf-8?B?anoyVlFwdXFYaVZ1L2NhNDZLSEpKSFR4ZTdHWXhYL3Q5S01pNHlQdUtQdExn?=
 =?utf-8?B?bTdaV2htK0x5WU1pNjlvYTYzVWx4TERXeStMWmxxbkM2dGRuVHozd2QrZkNi?=
 =?utf-8?B?TisrQytOc29MSGowMEpKSFZScWdzaEVzcTE2TWtHc0tFTGNVaGZPVFFOeWl0?=
 =?utf-8?B?TEVZMXRBRStkaytnUXdWT3NrR3MwZzFRN2EzREszUHhLaXVsdTBPQWtHVkZm?=
 =?utf-8?Q?3sZw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15f52814-1185-4f13-83f2-08de06669279
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2025 12:31:14.7030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l75jlRFCVwI6F4UE+t4aY3nBcFKKO9CEjjJPLlFUBP/D55Z2D1G5d8QU3Dpul9WGui3DkarWVZUoNz1P4vH0Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7332

PiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDMvNV0gY2xrOiBjb25mOiBTdXBwb3J0IGFzc2lnbmVk
LWNsb2NrLXNzY3MNCi4uLg0KPiA+ICAgICogb2ZfY2xrX3NldF9kZWZhdWx0cygpIC0gcGFyc2Ug
YW5kIHNldCBhc3NpZ25lZCBjbG9ja3MgY29uZmlndXJhdGlvbg0KPiA+ICAgICogQG5vZGU6IGRl
dmljZSBub2RlIHRvIGFwcGx5IGNsb2NrIHNldHRpbmdzIGZvciBAQCAtMTc0LDYNCj4gKzIzOSwx
MA0KPiA+IEBAIGludCBvZl9jbGtfc2V0X2RlZmF1bHRzKHN0cnVjdCBkZXZpY2Vfbm9kZSAqbm9k
ZSwgYm9vbA0KPiBjbGtfc3VwcGxpZXIpDQo+ID4gICAJaWYgKCFub2RlKQ0KPiA+ICAgCQlyZXR1
cm4gMDsNCj4gPg0KPiA+ICsJcmMgPSBfX3NldF9jbGtfc3ByZWFkX3NwZWN0cnVtKG5vZGUsIGNs
a19zdXBwbGllcik7DQo+ID4gKwlpZiAocmMgPCAwKQ0KPiA+ICsJCXJldHVybiByYzsNCj4gPiAr
DQo+ID4gICAJcmMgPSBfX3NldF9jbGtfcGFyZW50cyhub2RlLCBjbGtfc3VwcGxpZXIpOw0KPiA+
ICAgCWlmIChyYyA8IDApDQo+ID4gICAJCXJldHVybiByYzsNCj4gPg0KPiANCj4gSGVyZSB5b3Ug
YXJlIHNldHRpbmcgdGhlIGNsb2NrJ3Mgc3NjIGJlZm9yZSB0aGUgc2V0dGluZyB0aGUgcGFyZW50
IGFuZA0KPiByYXRlLCBpcyBpdCBwb3NzaWJsZSB0byBtb3ZlIGl0IGJlbG93IHNldHRpbmcgb2Yg
cGFyZW50IGFuZCByYXRlPw0KPiBiZWNhdXNlIHRoZSBzc2MgaXMgZW5hYmxlZCBhZnRlciB0aGUg
cGFyZW50IGFuZCByYXRlIGlzIHNldCB0byBhIGNsb2NrLg0KDQpUaGUgaWRlYSBpcyBzZXR0aW5n
IHNzYyBpcyB0byBsZXQgZHJpdmVyL2Zpcm13YXJlIGxhdGNoIHRoZSBjb25maWd1cmF0aW9uLA0K
YW5kIHdoZW4gc2V0IHJhdGUsIHRoZSBkcml2ZXIvZmlybXdhcmUgd2lsbCBjb25maWd1cmUgdGhl
IHJhdGUNCndpdGggc3NjIHNldHRpbmdzLiBBbmQgdGhpcyBpcyB3aGF0IGkuTVggU0NNSSBmaXJt
d2FyZSBpbXBsZW1lbnRzLg0KDQpQZXIgbXkgdW5kZXJzdGFuZGluZywgZnJvbSBoYXJkd2FyZSBw
ZXJzcGVjdGl2ZSwgd2hlbiBzZXR0aW5nIHJhdGUsDQpzc2Mgc2hvdWxkIGJlIHNldCB0b2dldGhl
ciBpZiBuZWVkIHRvIGVuYWJsZSBzc2MuDQoNClNvIFRJJ3MgZnV0dXJlIHBsYXRmb3JtIG1heSB0
YWtlIE5YUCBmaXJtd2FyZSdzIGFwcHJvYWNoLg0KDQpUaGFua3MsDQpQZW5nLiANCg0KPiANCj4g
VGhhbmtzDQo+IFNlYmluDQo=

