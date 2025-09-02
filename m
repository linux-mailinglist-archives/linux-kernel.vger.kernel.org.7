Return-Path: <linux-kernel+bounces-796523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72EF7B401E5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 15:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42F44188CB4F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 13:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10122DA757;
	Tue,  2 Sep 2025 13:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AEkVv/jw"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013038.outbound.protection.outlook.com [40.107.162.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B932D3ECF
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 13:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756818103; cv=fail; b=oKutdht3t9CuLHkqS4aZHoS292kpuuHShreurZAZqkrdXnJHRGZzWKVUhSHavop5mTQQF2WORG9ikBqEB0szpQI59vhTxMSiX2FVkaRHby3exkqSpT2FVd0iWtsc5pPPIHyZiRpHegPabpvcgza0raHcswV8LnaZaS2OJRM9m54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756818103; c=relaxed/simple;
	bh=x7cDelXlhSiiYiYvHuutrAKjXkosimBtsJ8K198UDbo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iedp/rg5LKSuJ6LpPo3L8UFKpFgO9194yOQVTnDy+fmsKfsJ8Xsjl6tIen+Yqh266F9baMW7cNdYZJn71TU4sR5cLk4FFZkD0g/yaXZVEG8NaHRt+8mLr7VGtZtMvJUkkPSeRthnBRAEd/DqBUaBPVnAbMzGVjglKwbNQXxfxmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AEkVv/jw; arc=fail smtp.client-ip=40.107.162.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YgM5rnCJalqqeqPl9/AVPcciMVtjUf1zAyYjfqtaUNclgNO4zXwRhzeBRUgM5yLOEL8YHpGnK7VWcwaG/rAT26DOy9+SasU1VPeeSXLt1vPOmcm8yzIeQHlTpRfIaVTMzQ7tj/qLwW2eSS3/KbJCChYSPn4vlYU+II4Xct6ecKE/5KO8dmwarwq6TtTmE6a9sgI2TckY3Ux3LQLhGVFHgYcvL253JxQ/eiFdYQ/WbydBc/Ob3LvY6CJWQ1zaOcSJIPnFtrLK8axw9y5yUEnmCm0AHvqMLQ1cGH5YzLG1yDVoxiEl02z32XHDiAM4+xSXNO57YPeumkA9a6Uh4YlbJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x7cDelXlhSiiYiYvHuutrAKjXkosimBtsJ8K198UDbo=;
 b=bydzW6CYEKUO82yFwd/W5tXI0soqPL9Se0BVdHgW7g468qtuMEPvMtscBHBIgRMu9EFFH2fZPzCP/U/mHGVPljXb8bWpu16RTzwU66BfiU/C9c+vFfXFOWhtyGE4RZvwhDWiBdG4r+T8HRuQv8O5M2LXMIrcHgUMn2+UcjuRyfndL4pJM08C0JFBAB79yPlbNRts7ahIEYwmdE5JnJZ3CZiWlnT57x5HWgPObRuBMrG/ea5YSTlLjKoIDly9Dwefxdrb3o23SX096Cs+q+9EvtocBSFoxpwala/UuM/y7S1zjzJxUXA82of0jzJ7Xqnuxlta+7h8sxjyKydwnhDBaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x7cDelXlhSiiYiYvHuutrAKjXkosimBtsJ8K198UDbo=;
 b=AEkVv/jwU0XEavpvcXsoTpcRvZTnRLW0SBHPr5f73XBhnJvBnafod/Vk11N0JuKOntrrAB+p4toJuwbnHPLeJRV/sONNcW+7XSNIzItXfkjP/tF8E7qCYwy8po7zlL23+qFIjvW9v79APrybCrPDDMSJx7wExoIxJDvYnY7acaSJtZiTMDBM+KtaNsyuWLNnqwoXHn6AwDkHJXbOZ85he+9ergszX35CFefUDaPyYkIyOpkaliOWhOko0TRIucPSMjnJo36olKAuLhU8hsyNRJQOV7sHzyyKmIQrkJ+orVz5jnskDL1UYb4MS3Qg2zSSGZ9KlXjWhSkmGSv2vLVdbQ==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS5PR04MB11393.eurprd04.prod.outlook.com (2603:10a6:20b:6c8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Tue, 2 Sep
 2025 13:01:39 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9094.015; Tue, 2 Sep 2025
 13:01:39 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
	<festevam@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Sudeep Holla
	<sudeep.holla@arm.com>, Cristian Marussi <cristian.marussi@arm.com>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 0/3] firmware: imx: Add stub functions for MISC/CPU/LMM
 APIs
Thread-Topic: [PATCH v2 0/3] firmware: imx: Add stub functions for
 MISC/CPU/LMM APIs
Thread-Index: AQHcFY3715Y6RKM3aEivvywWZpe6MrR/58Ng
Date: Tue, 2 Sep 2025 13:01:39 +0000
Message-ID:
 <PAXPR04MB845910056A522BC1DD5D0F168806A@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250825-imx9-sm-v2-0-0bae0265e66a@nxp.com>
In-Reply-To: <20250825-imx9-sm-v2-0-0bae0265e66a@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AS5PR04MB11393:EE_
x-ms-office365-filtering-correlation-id: a216206b-fa72-4622-1fc2-08ddea20db06
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|19092799006|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SFRENTkwcjdsemhaQW9QZ3IzTllobE5OMnUzdjFrWFhKeC85ek1BMVBHUjlC?=
 =?utf-8?B?VDBkejZDVVVDRkczRmtua3h5dXI1ZWl3YnU4clV1d1RGK2tIMnFpc08wNDJS?=
 =?utf-8?B?OGRsNmt2blpodWJaUStHNEhYUUVqa0x4WUFiR2tpVGdneGkxTEs4ZXJNOVp1?=
 =?utf-8?B?UHlGbFJhbzFYMTE1bTVkUmxWMUQyMHY0TiswRXRvd21paERYMzVOTzJtclhz?=
 =?utf-8?B?KzBGNGYzWjA0OFJaMElqMzZDaWNhZWpLYktaOXArVW10MXpnSHViQ0VIS0FF?=
 =?utf-8?B?UGx6ZGN0VXZTZzZVOHdxNXJSbHR4QWtQdzFreG1XU0dIMzBqSDl0TWp1bHls?=
 =?utf-8?B?dGlUdDNsZHNhRFllMEl6QndFSit2ZytYN3dTZjJFVUtURXVkQzdRSU9MSzd5?=
 =?utf-8?B?YXhaT01PMG16ZHYydDN5U0tkWFJSQlEwNGtGamN0RmlDLzltcCtuczNIVGh3?=
 =?utf-8?B?c05yVWNZUmhUMGxhLzBkeVJvcS9zMjdDbktuQXNrVjlJUXV3L0hPYytYV0dk?=
 =?utf-8?B?eFdieXJnYTdMSXpySWJLZDh0eUZVdi80SXlORDFHMUlHQlkvRFlUMys4emhX?=
 =?utf-8?B?Mk5yelNkVUVqWUlSVjVmM3RwUWNJTDhqZFd6aEFESllHQ1QxbU1tNUVSWFJP?=
 =?utf-8?B?eFgwVE55NDYrVStWeTJLZHpaSGZGNDh0Y1RoMFN4YjBUb0dUbWRaUVFoR2Zx?=
 =?utf-8?B?R0FCbEFEakNCMUJpeTdWZjhSclA4bENqNXBkcHZ3c0gyaVF4NmhVTTlJY1Y1?=
 =?utf-8?B?VmlwTXR1cmhZL3puVGxkaE91OWhDcWMvN2sxUDdMc1BsNDc2NEVpVEM3ZTJy?=
 =?utf-8?B?MVJFZyswSm1oeWtDQkNucUFlZS9PbHBWc3hoK3ZmN0lSS1g4L1FORHU3ZWNx?=
 =?utf-8?B?UEE0cWdZYUhXQmFMTW5qR3pJWkRKRjREanIzNHBtRjg4VFZBRy9XTkJMOU51?=
 =?utf-8?B?TDZRYmxOZGgvUm9GM2ZHUmJBelBVSExDSE01anBMT3hTMDZRS1ZNd1crakRS?=
 =?utf-8?B?a25DZ05iZ05oV1BuZGF5R0RicW9GWEVKS29hbDlHcDhRaHl3ZUQ5OWFERlpE?=
 =?utf-8?B?R1FkY0lNcjRjZ1U3ODhTaEJoeVRadWg4aHdCT0VmcE9JR055Mkl3NUNkdmp0?=
 =?utf-8?B?QUFaRWN6TlRHVGlrejBWN3VzaGVBT2VpYnB6MjFpaHZwcVh5N3dHRkRRK0hO?=
 =?utf-8?B?emQwL0J5ay9XQ04zZ0wvb1NaREhSM2d2eTFGVGpQakE4eEdOd3ZBeWZCeTFO?=
 =?utf-8?B?Ri9KaXh6elEzdVNsOXFqSmw0NkVzYllsVitJbmd5TW45aTArTjdzUmNnakdJ?=
 =?utf-8?B?MnFrREJBZnRFa21PM2h4Q29DQXFnVlhhL1o4c21UN05PL0ZOdEYwVG13aU5V?=
 =?utf-8?B?VGVqcmtlT3RZeWRDV2dYaVREbWo0NjMrZ0pUYXZORkxNeVI0YVRBbytBRGJI?=
 =?utf-8?B?bWRtRUl2NkR2a3hBWVlQa00zVHMrQVdlQXpqbzU2WURXajZpN08wN0xrc0JY?=
 =?utf-8?B?N3h3UnoyZWlCRHVLN1k2czhUdzhjemo3WVo4Y05GSnVDaXB6aVR2NXE2ZVds?=
 =?utf-8?B?OHZNUnNlemN6azVOUEdkbkRLZkRBMmkyMlM3SVcyVGhvSXBOK2tzS0h5cXU0?=
 =?utf-8?B?VFBHUmkrNnpRdTV1Z0FhU1RvQzJ5ZmN0VDVFbGNDK0NBNXlYR0pFby9sZFZZ?=
 =?utf-8?B?d1NkZExWU1RoNFZLMTZWUlF6dUJGMkJTTE5ocE9GekRkZzl3SGZScDk0V1RB?=
 =?utf-8?B?WXVndTM4dHF1alBpaEFVcTJXRVlRa2M1RG1kbWJDMEVob1kzZDJsL3lyQ1cw?=
 =?utf-8?B?bjN6N1lVZnA4eGZYVGhoQ2lWQmt1N0FlckxzcU5HTWFTa2YwNE5oWHFJdDFa?=
 =?utf-8?B?VXhBRWpFTWZUVnBmbnlUK3VYcHBqV2YwdUpxQzVkdnEvQzBSMFNicWZVbEpH?=
 =?utf-8?B?SHJ1RnllMFozOTZEN3hadVZDR1ZEUVJtdXN2QUNBUFVnaDZyMFJ0YXlSbk9h?=
 =?utf-8?B?SFIyY01JNnZRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(19092799006)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SENUUU1JZ28zVDBXdGJ3Yk92aWpXcktYYUVENVcxYVRzTkVzaXFMN3Exb09W?=
 =?utf-8?B?NGlWRS95anI5VHRlVnZPeVJKR0psbVIxMmxSTHVvTVprSEoxaSt3MDBER0Y4?=
 =?utf-8?B?UG4zWnNSdlRTZnd4UFBtZ0lMTWZqUGd4QnRHZGhtd3hQV3lodkZmRHlGd1JI?=
 =?utf-8?B?V3FRM3RrcmZmREJudXhGV3Y4YzltMHhQVmdXaTlsZXZXQXFwd1NSc2lKZCtQ?=
 =?utf-8?B?cjdjb3NkbVZDNVFFRjdla2g5dHJRdzZkQkFRZDlFSnM4ZjFUaFR5czYxTmlO?=
 =?utf-8?B?SEpJTzNmaUZMUFRRbDhrVXAxTjI4OHV1cG1kSHBhb1ZkRU41ZVpjbFJlNWZm?=
 =?utf-8?B?a0dqN0NRMlQxSXMwaWRQY0hndVBNZW5YSDhzamp3WXFIR1QwVjJQNXpjUU9P?=
 =?utf-8?B?VGVhd3NQdmZFeVFUNVRmNEVHdHhBMmo0b1o5TWc3NzMxNDdNTnl2ckt3N2Vi?=
 =?utf-8?B?amNUS1JHNmZ2K2VTbTBRNENwQWpSY01CbEVZcWpjVWw3RUgwb3IvRzFQMi9o?=
 =?utf-8?B?TmY0RGVLTU5hWDRxUzVUcUF0T1UwUUJrT1Nwekl4UGYxS2UrYTVuRmx0OGZS?=
 =?utf-8?B?bk5XcG11d3Y1blJJRU9oL2N5SmFzdWxFa3o2V2hqRFVma0xBeXhRM3BuUjRT?=
 =?utf-8?B?QUExVERXUEx3TlZZZ0RCRUYzdGdHd3I1NE85MVpXQU40Rk9OVUJhcStmOEFl?=
 =?utf-8?B?M1pGWnZLLzNObVJkRFV6UFlwaEhqNXdQc1JTeDV0T2xOeHBMSzk0YjJPbHp4?=
 =?utf-8?B?S3NhcUk1YW1jR0dIa016VFZSL3Z5V0dnTjV2aGdOS3lYd2x2L1piOW5nQ2ds?=
 =?utf-8?B?b1pTb3dqZDhnTWtjeGowNk5HZDQza3RDeCtoU1Z5SDFSTGNtalpMSndxU1k5?=
 =?utf-8?B?ZGhWNHd2Z1N4RkhFemJXSlF0YXRDeHBEbStOZlVHcXQxL1d5SDNHNW1iQldk?=
 =?utf-8?B?RzlHci9tRHhDdE05SWV5R3dZdzRpSzdiR2c5bitCNVlYZDdOcFZVVkJESTNM?=
 =?utf-8?B?aUNFZzV0VEcvdVNxU2w3QlIzZ3ZaUmNtYWk2MzdLN3RtRUVNcmhhUmx2Uzgy?=
 =?utf-8?B?K1RkUFlOaEl6czVGRnNRQzBtaHlaeFJKZnZUMkJjQU9rUUpMZXF3S0d5RE5D?=
 =?utf-8?B?dWhmN1YwL3RmNTVwVFdJbVZHRW9xNlFFQVdEMCtET3dTZDlsc1ZTc1NuK0lp?=
 =?utf-8?B?UzF0dXJpc2htYWNZaEtKdjl0a09UVEF4MmE0RXc3U2lPell6RFlCU0VibUV0?=
 =?utf-8?B?ZmQwSVRJVkc4SWJ0RisvbkRKcUIrbnVxTERFMGUySEkzNFJ1QVZxMnhGcXZy?=
 =?utf-8?B?MTBkWlhqb2NnYTc1VHBWWVZPTGgyNVQ0d1FjQ2lzMjVGc2JJYU9Gcy95VWoz?=
 =?utf-8?B?MHBnRWt2WVhrT2IxNU1rYldseVdxcWc0OTN1YjBvanh5Ty9SUUIyVGsyMmZ2?=
 =?utf-8?B?SmZRdnhMSWdWOUVDbWYzOGdhUWJVdEtsVEtWdWdyNG4xdFZhSDVBSW1jdk1I?=
 =?utf-8?B?Q2wvK0VyZHhLYWVEWUE4N1JaZnN0OGNtL3N6YmRXSUNqcXF5alkybVZJQlMw?=
 =?utf-8?B?R0w2bGcycU1RQnB5a2YwZDVCbzFCUWFORC9vWmRNL2VQazNSZFc0cklEc1Ev?=
 =?utf-8?B?eVBRU1FnMDdsZ09XU0l1dEk2M2wyclhYNHhSQ3hpRi94VGxkUUZkUHlEdmp1?=
 =?utf-8?B?ekkrTnNySzJZVWxtRWE3cFY2OW85ekpNVzRkMUJYc3Q4U2ljWGJrQk5MM1Zn?=
 =?utf-8?B?RnNaVFkycUdOVG1QbC8vbXZoOGZIeXBCdXg5WGdIY0VEbnE3WnVKU1lsZDlQ?=
 =?utf-8?B?YmdSTFFHSStuVTR4VWp3aXIvc0JXeGdOakZqWVV5dVg5VER2cko1MTRzTnVj?=
 =?utf-8?B?R1FBcnU0TTV4UVluVGZDYVdaZ2p4RkVPMkI4ajVNUlM2cnFOT3RQcFgreCtN?=
 =?utf-8?B?L2FQZFhUeFhOYzgyUjJTYWUxRlRXdFZmdFFFbFExS0xNaWtoeGl3MHBTM3Rr?=
 =?utf-8?B?WHlGV3JVZHNLTWdQTWsvTkhicVV0OG9BdFhNL0diWjBkTElqbG11RWVRTytI?=
 =?utf-8?B?OFJENitTblNDYjJ4MHBQcVpFVVZwUzlwajA3S0ZkSWJqcTFPdUpWcWU1VjY2?=
 =?utf-8?Q?gNcY=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a216206b-fa72-4622-1fc2-08ddea20db06
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2025 13:01:39.0812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7EPMf2u1IUZtkcsXTHno4j+NyBR4DsrAMmJGb87/TeuNNXFFK/4uLeZEO41k77MMQGHSZrpR89oic6RrVF2wNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB11393

SGkgU2hhd24sDQoNCj4gU3ViamVjdDogW1BBVENIIHYyIDAvM10gZmlybXdhcmU6IGlteDogQWRk
IHN0dWIgZnVuY3Rpb25zIGZvcg0KPiBNSVNDL0NQVS9MTU0gQVBJcw0KDQpJcyB0aGlzIHBhdGNo
c2V0IGdvb2QgZm9yIHlvdSB0byBwaWNrIHVwPw0KDQpUaGFua3MsDQpQZW5nLg0KDQo=

