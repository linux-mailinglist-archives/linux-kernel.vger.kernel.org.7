Return-Path: <linux-kernel+bounces-794937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D7DB3EB10
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 17:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ED64188F0E2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 15:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5917830648F;
	Mon,  1 Sep 2025 15:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="OQVBkv8q"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2AF2EC0A7;
	Mon,  1 Sep 2025 15:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756740508; cv=fail; b=UWEzwyfnRenfNrUlIVrBe3sGQLugGchMs+8utS9Hk8VDCoqRD4JHB4aBapTP1xz1e+Ag92bT1u7ZxElNjRVhR4p8RJ1E/7g/nx43ht1zphPXnLbUBD+y5XWxvUc/YwMURRwBcgXaluRjfCEUkRLWc3nLgFyFjuh1K48ZtRuQaBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756740508; c=relaxed/simple;
	bh=WtoAS/zksehuwGPxmCEira71C3k5M7idrNq5u716AZw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UpyAVO6ZLs1ARB9Kr10W0h5tcYlv74jZhlY8E3ti1OxHOOZwezq9XDV476xuFGsk58pEL7/6ixWKm2yM3WpKTWxM6dG09lQUW37uot/WHnliznSl878J/418gIkmtBXWacKlw4C2BdUnTJWJTGmrW+MOk1Y/fg+oHWtnPBLQOcM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=OQVBkv8q; arc=fail smtp.client-ip=40.107.93.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v51dFgkkq980vg5Ee3ePniz/orN9kmGwkbmwH63heIoFZgPK8u9r6sEdjq3++Brzj1eMwR2IpGRRXL1wuhTZhFlzyOiB0qfi+Ev2pmVsMuysq5gNHxYyb8C9G+uhjzKWoMKrScqZZLtZzOCM2GwQezel93ijm8hWy7AaoZOeSwtezD5rIM//L5+/QZJYhVBz+Si77quH1QEiVq6Vn/DQ6lbiA5msQrluUlfqtZnXNTqR2oKtszmL61Qwwm5IRuSpHyAbNuwV0dU/rdUoAiMGeH78rCDJCYkdjbeX8hhndPYb1FlUWTMF3x7M0Z6hWhK4MABfPGqJF0+HcUuG1BrnwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WtoAS/zksehuwGPxmCEira71C3k5M7idrNq5u716AZw=;
 b=Z1navI6jd3TU6gYQoaLy35IeXsQwieCIrAF4MCPQ7AviVq/123x+fN8mJ0LOXMmTfThv38X1Ul1aM2xxDD18KbFfL9qjRzSaomRF4VMyw2Pw0zaW53xLqdJGK2wkGS3M94NK78+8wjJX1C086m8BR8f6diOKR1DZkKKJKkRYszufVMHQ8bze1GJI81HRfAbaawb0/X4SFRuRtNwL6ZaaA7DnUynY455O52UAqAwtDOCWdDnYY0nHFUOT1Ra7MnvTQx+3fVBqzO/pluPXKq3rZ03ABbR2BrRKfM1A4BAFoCXllJSWZIZX4pH944R+DbBrF43p5WQ7zoWaMkTRoXYWkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WtoAS/zksehuwGPxmCEira71C3k5M7idrNq5u716AZw=;
 b=OQVBkv8qYvh/Wa8ujWPKaIhzeCY0iKaLah0kD1rBL+k1C1y19A/0ZBauaRI6O6QHkDVt999Mo8OM2UrdrnRpoX1d+TeQSX4OfaIUOKikTqnzOzWyOBUEf7k5jjPtk5QlZtpM8Nkl5+pU44JcWQE84MpUoecXexkI2rZ3XXkarEse/hkvIGbkEcWBENr8XkDECRf5K6CMdL9h2LmRN6p9wk9RzjE3dhEU9xsKFu4EfHTYdTwsKs82QExLFzwYTri19UoNmWddXBJyTKEBIzOVd3jKgoQRlsb7DqUz2D32lyBFMheMJKd35YhxGa1FX/kh0aAUmHg7x8Vw1hLai4CELQ==
Received: from DS0PR11MB8739.namprd11.prod.outlook.com (2603:10b6:8:1bb::19)
 by CO1PR11MB5041.namprd11.prod.outlook.com (2603:10b6:303:90::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Mon, 1 Sep
 2025 15:28:23 +0000
Received: from DS0PR11MB8739.namprd11.prod.outlook.com
 ([fe80::f0f:4a3f:e3a3:d3ad]) by DS0PR11MB8739.namprd11.prod.outlook.com
 ([fe80::f0f:4a3f:e3a3:d3ad%5]) with mapi id 15.20.9073.026; Mon, 1 Sep 2025
 15:28:23 +0000
From: <Valentina.FernandezAlanis@microchip.com>
To: <krzk@kernel.org>, <Conor.Dooley@microchip.com>,
	<Daire.McNamara@microchip.com>, <paul.walmsley@sifive.com>,
	<palmer@dabbelt.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<aou@eecs.berkeley.edu>, <alex@ghiti.fr>,
	<Valentina.FernandezAlanis@microchip.com>
CC: <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH v1 5/5] riscv: dts: microchip: add a device tree for
 Discovery Kit
Thread-Topic: [PATCH v1 5/5] riscv: dts: microchip: add a device tree for
 Discovery Kit
Thread-Index: AQHcFdxZ+gegSJP6cUq8DodaBl6a1LR4W8SAgAYinQA=
Date: Mon, 1 Sep 2025 15:28:22 +0000
Message-ID: <bb5b0d71-41b1-48a0-82fc-bdb362cc3db1@microchip.com>
References: <20250825161952.3902672-1-valentina.fernandezalanis@microchip.com>
 <20250825161952.3902672-6-valentina.fernandezalanis@microchip.com>
 <2b1eb8fd-2a64-4745-ad93-abc53d240b69@kernel.org>
In-Reply-To: <2b1eb8fd-2a64-4745-ad93-abc53d240b69@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB8739:EE_|CO1PR11MB5041:EE_
x-ms-office365-filtering-correlation-id: 36e235e2-cd79-4d95-3d54-08dde96c3021
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018|921020;
x-microsoft-antispam-message-info:
 =?utf-8?B?NXdYdU1MTzI4dHUzb2ZUVTZZNzBrYWZoTHVnZzdQNTd6VmhTalhGK1dmT3Yy?=
 =?utf-8?B?a1ppRittVDRvL0V6VGVHcGwwSENtUWdIM0tMN3czNXpiY0UxcjFuclQyenhh?=
 =?utf-8?B?NFFESXhoMSt3ZmFYS3htYWxTelRQSE03WmdTRWFFcXpIcWwxR2lXKzVjNWE4?=
 =?utf-8?B?ZGRPb21IT0JLN1FyTG41b2VqZ0syVngwY1dIeW16WGthQlNEZnpKK3JQbWMx?=
 =?utf-8?B?QS9SL3ZaNHZUbC9BdTR4NlVFck1uaFhRRHlTdkR3L2lRZUNyUXhjSjNCYlFn?=
 =?utf-8?B?amowYmRZZk1nR1FUcU4zTGtCWWVZTnAxOElYNkhDU0Q0UkczazhKQkhNaVZV?=
 =?utf-8?B?U21ac0RvMHJJYUJySVUwYWRJTGJaZXJrS1luQTVaVng2b0RHcTBINVl5SWJ6?=
 =?utf-8?B?cCtJSkRrQzFuVzJhOExDaGtKRWRJVlNicU50UjFQSk5SLy9aZlFraWNtWmNx?=
 =?utf-8?B?L3AwUGNVeXEwRlVUUG1rV2x2K3hIaVMxMGhtVktYR1ArL0E2RUlrNys1Wnpy?=
 =?utf-8?B?eUVmUlpLWkVwMlJSUGpGTUVCVWhnd0ZVa0tTcThKeGhockd0NHVzWFBtMm96?=
 =?utf-8?B?SHRKN3RvdTlxZk92UVZ6MnBpRGRMZDVMTlhZNHNMSWhaRG5mTU85cDNvTXZx?=
 =?utf-8?B?eHdyY1QxbmFkell6M0UrZE1RYTh3eSt1V3cweE9rSzA5OHRXTDVXcXhYS3hz?=
 =?utf-8?B?aVpxTjNLVUQrVmM0OWdlQzNNTVdycUY4K2RrV1N1WSs5Y1dKa1ZpWkZ0NmQw?=
 =?utf-8?B?empjdklYT2c2VXYySG1mTXd4WitRaFZ4MFp0amhuSjFpamFFeWhhWUVuT2JJ?=
 =?utf-8?B?eXdLTDBZaWhoVnpDSUxnNlVDOXB5ZzFBR003OE0yTEVVZDJ6Kzk4T3FhcTMz?=
 =?utf-8?B?VFdqUkt0UkVYSEdPcUNKTjhTWVFUVDdqY1dGcjRkaW14TkFTZnpDR0VxaDVY?=
 =?utf-8?B?UG43dTV5WHJMeHJ3aVd3M0lablJQQmJwY2N5WG1Vdyt3TDNKZG9hak5hcXo5?=
 =?utf-8?B?aE9KUkdLZ2Q0Vy9pOUxIMEgyZ1F6SWs4ZmIyMmJpMDF5VXdXb0pLektFWWla?=
 =?utf-8?B?OWVWb3RRQWxsWXZpdlFQdFlBUXVNYy9EZ1ltVHYxWFZkWm01VFFhYnZEYUpV?=
 =?utf-8?B?bWtiOE5DQnNZUURrVEZ6eVZNam5oeGFhMUR2dEdNamdCUlczVkc1UldzM1Nt?=
 =?utf-8?B?Tnp6OTZtaTRyb0NSNm9XOFFqVEJSSWZIQ3AzQUhQVlc2U20rUk9DQXdzQXVJ?=
 =?utf-8?B?cG9IUnQ5RWdtUk1EZHhqaTVqYlhiazZVOEFKZTFwQjk1em9nWnZaSGNyTnJE?=
 =?utf-8?B?UUpRdjRNU1diNUJBeXk4UitKTXZrcnhPYzRJTDB3Y2pBTHJrUFc3UVhlZ053?=
 =?utf-8?B?Uk5LZHBEcjAwUWc5UXE1NWcveUMxdWNVeE5JMnJLa0JOREJ1dW03TktjdjI2?=
 =?utf-8?B?SzBVZFc4aXpQdTgvSG1KSDlXRDBucHVuNzFNNUxQTFQ2bEQzcm5JUVJlbGE2?=
 =?utf-8?B?R3JpbExtTnJ2VktRUCthUDJWb0xxZXM5SkJLL2ZKVXlrOXY4VjZvayt1VWZs?=
 =?utf-8?B?ZWphU2RwdXFFUktpbWlsZUNVYkFuWmcyT2pTVE5XbWc0NDh5emxXeVlPdkto?=
 =?utf-8?B?R1BWVC84YnJsei9CY01XYnpWR1lFNDBYdk1JVE80WkhiNFJ5TEFJSFNnU2pw?=
 =?utf-8?B?STZNU1NnK1M4bnFFcEFOQS9nRXBONlhacms3NHJvWEdjVVFXakNrZDdiRmYy?=
 =?utf-8?B?S0llVEpMeTNYdXN6TW5DQTkwTTlJMWNZQTNBOGd6cXZybFlINUV2U0FoLzE3?=
 =?utf-8?B?ZGMza0NGZTV3UER4eHVzWXJISkpvSU9XZ01OUlUrK01GR3B0azBoMjlLejdZ?=
 =?utf-8?B?bVZrYlJwb3NLRGhjZ3ZaZ05YVjYvbHMyS0V6enlMUzcwUzcremdLV0E3NTdh?=
 =?utf-8?Q?iDTHR2dLLQo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8739.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?amRJanprK0o3M1N0QUU0NHA5SGNuVUVHOEZuU2tHaTN2VG1mL2wrWDdSY0hJ?=
 =?utf-8?B?ejR3aTRFdlZqSnM2cVFjK3JzdStyM2MrZkpnMjZTbEJJNGlnbnpXMkd3RzQw?=
 =?utf-8?B?TGNvWGhUd2g2ejdHYXdSejZvUHdWOU0rQnNoK21sQk1sYVdwd254UGdOZnFJ?=
 =?utf-8?B?bHVsYURXTWtaRVRWZGpZOUVvdVp3RFp6Zm1qVUYwRWN1UGVXUSs5YVZWa05t?=
 =?utf-8?B?MTlnaW9tU1NRL2NhVGRRR28zdWIyZXBCR3M3cnc1cTR3R24wUDkrNnZheXk0?=
 =?utf-8?B?djlWSHI5ajVEb0l4MnhaN0JMWTc3eTdPWDR1MzJqMjNGZDcxSkxzcCtabEhV?=
 =?utf-8?B?VmNPYnRZSTlCalZObWZEbmxZS2tHWlZRMDJuZ29VZ2R5bjVZdUNBWWxxWG9M?=
 =?utf-8?B?ZG1NT3NhMmpDYkEzeWxtaTF5Z0VVb2FJR0o3Q281RnpSaFpYSUtXOE1PUVBP?=
 =?utf-8?B?TmJUanphaWVEUFJ4NkxjcGNQSEhhNDFhNDNUazBnUjFMaFNjL3BqOVBPV3U1?=
 =?utf-8?B?aWF5V3dLbjJpUGNtcXVUeGVnL3F6MllwUmlVTGJYV2lFYlV2emdJbm9iSHFz?=
 =?utf-8?B?NllaZ2d2MDlCUGI1MmU1L2NCQjBsSGtBNVNEd0ZwQ3hiUlo0MUQ5NVpZak1H?=
 =?utf-8?B?TnhISzRQQ0o4MDJtSEJIY1JnNU95dmZrWGhwaTFuZlIyUFg2NVRFcFp3MS9n?=
 =?utf-8?B?dE9NRU9raFM2aWdwWWM2UUg2ZDl4QU52bzF2blJIcC9meHpjT2VUNE9LSGlR?=
 =?utf-8?B?Q04wZzNxbXB5Ynl5UHJlcTc0aFJtdVFObndiaTAxVTArc0RMbW5xNk1sVUxV?=
 =?utf-8?B?QWtTMENLdzU3U2hxRnFvYlJrS1VORGVoVjVOaFkwMXhjRVFZVTNWRzZUK3cx?=
 =?utf-8?B?SmZVUDhLd0QrSjFMVzNCZHlIa3NRSzg2VlRaUThiczUxK2hmR2s5S1M1aFEr?=
 =?utf-8?B?TW5kdGtOYkNlTlpDRzdxVlFvTzNqL3BTVE04ZnJuay9qL3VHOVpJYlNnRENU?=
 =?utf-8?B?NHJqSWNRYWxsMyttRHlpMS9zNW15OVlRMGx2bnlCMlpITGhxaUdnVUJnTUU1?=
 =?utf-8?B?d08wOGw4R2lqR3FPT1VSWWE5UkF0bk1Xd0xhRE83dlptOFdQbU51Q2lnWFVE?=
 =?utf-8?B?TVhmdll5OU1LcFlRVlZJVVJRUDEySllSNVNsQVBHZXlGekJISUNPZkFwdkhM?=
 =?utf-8?B?aVRrQzlNUFpwdUZsTEJtNTRHbFQybzRJdkE2QzRpckhjZWdzdk55SUVmNG1M?=
 =?utf-8?B?SXpBeHhqRzNwZ0t3eVBENzhWSm40THJQSUVldTM4Rk5GT0tkbnZzcmxFc0ZY?=
 =?utf-8?B?cFR0MHc0Umt6NlVsZm5YWHVaVytESWhJTjNLY1kydkN1cFBWM3VtV29lWG1Y?=
 =?utf-8?B?cEk3Rjc5aVFCUlJ4LzcwSWp6N3g5TUNFd2dSa1g5bStRdjM0Q0pKUnF0V3B6?=
 =?utf-8?B?ZWRHRzdWamQ5UGMzZ0lNK3JUUy96WllIVU1mN0lWNmZCc1ZqVnpNMHQySkZU?=
 =?utf-8?B?bU1lbWU2L3BEWEpENXp6YzlGa0NLeFN1OHg3UWsvYm5QOG9UVS9YUlhzaENo?=
 =?utf-8?B?UjM2aWIyeWlFcnAwSWxhNDNtNkhLQUJ6alErcm5LUmd4dDFrN1R0M2hPUDBk?=
 =?utf-8?B?V3FrWGwwL2JlWDdRZnlFVFRiSkR6MHZ3MytoUzdoc2RVbDNTRHNSeDRLMnAv?=
 =?utf-8?B?RXVmZVMzcnpnYlc3cXRIOU1lNnBqVzlyQ1dmOHRHa21ZbGFMOTlIZzNtY3k2?=
 =?utf-8?B?OEhQUTM2VzZ2TE1TR3hrYU52cE1wMFA2cXJwTThraG1lM25IdTVRRXhEWCtU?=
 =?utf-8?B?bm5KNDI1VEo0bUJBQ1hRS1lYVWhTMnhrNDFqeVdvUDdhRG1TallwZXJKQ0sx?=
 =?utf-8?B?L3ptREQxd09JTlRPQUEwRlBFM3ZjSHFEeGhnYlVYNUJHcnNmY2VMczJWUkpv?=
 =?utf-8?B?bVorN3RhTytuV2VEbC9wV2NjR25tdUp0WUViVUJuaXlnTEVDUVBvWlc5OGFo?=
 =?utf-8?B?bXVhWCt3NGtOai9kZkhQSWRWYjM4V1BuSXJPQVJ6bk5ueUJaa1V6Q2l5cFdR?=
 =?utf-8?B?a3B0MVVpWWprc2QyVlFuWDNnL245TFIrWFhkV1RyNkY2NGJlWlF6QWZMVWJa?=
 =?utf-8?B?K2YxeXBwbnE2TzJOdWdyWGIxb3ZuYmlkajVOSldXUnZOcVFTYmNMZk9BNjFF?=
 =?utf-8?Q?bljKwIyhh2wTo6lxQrvOS5c=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6EDC2666C8BE1541A4635CF379B587FA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8739.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36e235e2-cd79-4d95-3d54-08dde96c3021
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2025 15:28:22.9353
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XgT7sE4vL3XHSIHhyi4Tvs/PfJoYUVoWZVgL2y5R5hgAHdM6+W3aaC34hgylHB8pS3KRCETqAuT07/Ynoy77QnHEM4HiDovob1aAClSVeiy4DjxY+e1xsBMo6kTmglab
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5041

T24gMjgvMDgvMjAyNSAxODo0NiwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gRVhURVJO
QUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiAyNS8wOC8yMDI1IDE4OjE5LCBW
YWxlbnRpbmEgRmVybmFuZGV6IHdyb3RlOg0KPj4gKysrIGIvYXJjaC9yaXNjdi9ib290L2R0cy9t
aWNyb2NoaXAvbXBmcy1kaXNjby1raXQtZmFicmljLmR0c2kNCj4+IEBAIC0wLDAgKzEsNTggQEAN
Cj4+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogKEdQTC0yLjAgT1IgTUlUKQ0KPj4gKy8q
IENvcHlyaWdodCAoYykgMjAyMC0yMDI1IE1pY3JvY2hpcCBUZWNobm9sb2d5IEluYyAqLw0KPj4g
Kw0KPj4gKy8gew0KPj4gKyAgICAgY29yZV9wd20wOiBwd21ANDAwMDAwMDAgew0KPj4gKyAgICAg
ICAgICAgICBjb21wYXRpYmxlID0gIm1pY3JvY2hpcCxjb3JlcHdtLXJ0bC12NCI7DQo+PiArICAg
ICAgICAgICAgIHJlZyA9IDwweDAgMHg0MDAwMDAwMCAweDAgMHhGMD47DQo+PiArICAgICAgICAg
ICAgIG1pY3JvY2hpcCxzeW5jLXVwZGF0ZS1tYXNrID0gL2JpdHMvIDMyIDwwPjsNCj4+ICsgICAg
ICAgICAgICAgI3B3bS1jZWxscyA9IDwzPjsNCj4+ICsgICAgICAgICAgICAgY2xvY2tzID0gPCZj
Y2Nfc3cgQ0xLX0NDQ19QTEwwX09VVDM+Ow0KPj4gKyAgICAgICAgICAgICBzdGF0dXMgPSAiZGlz
YWJsZWQiOw0KPj4gKyAgICAgfTsNCj4+ICsNCj4+ICsgICAgIGkyYzI6IGkyY0A0MDAwMDIwMCB7
DQo+PiArICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAibWljcm9jaGlwLGNvcmVpMmMtcnRsLXY3
IjsNCj4+ICsgICAgICAgICAgICAgcmVnID0gPDB4MCAweDQwMDAwMjAwIDB4MCAweDEwMD47DQo+
PiArICAgICAgICAgICAgICNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPj4gKyAgICAgICAgICAgICAj
c2l6ZS1jZWxscyA9IDwwPjsNCj4+ICsgICAgICAgICAgICAgY2xvY2tzID0gPCZjY2Nfc3cgQ0xL
X0NDQ19QTEwwX09VVDM+Ow0KPj4gKyAgICAgICAgICAgICBpbnRlcnJ1cHQtcGFyZW50ID0gPCZw
bGljPjsNCj4+ICsgICAgICAgICAgICAgaW50ZXJydXB0cyA9IDwxMjI+Ow0KPj4gKyAgICAgICAg
ICAgICBjbG9jay1mcmVxdWVuY3kgPSA8MTAwMDAwPjsNCj4+ICsgICAgICAgICAgICAgc3RhdHVz
ID0gImRpc2FibGVkIjsNCj4+ICsgICAgIH07DQo+PiArDQo+PiArICAgICBpaGM6IG1haWxib3gg
ew0KPj4gKyAgICAgICAgICAgICBjb21wYXRpYmxlID0gIm1pY3JvY2hpcCxzYmktaXBjIjsNCj4+
ICsgICAgICAgICAgICAgaW50ZXJydXB0LXBhcmVudCA9IDwmcGxpYz47DQo+PiArICAgICAgICAg
ICAgIGludGVycnVwdHMgPSA8MTgwPiwgPDE3OT4sIDwxNzg+LCA8MTc3PjsNCj4+ICsgICAgICAg
ICAgICAgaW50ZXJydXB0LW5hbWVzID0gImhhcnQtMSIsICJoYXJ0LTIiLCAiaGFydC0zIiwgImhh
cnQtNCI7DQo+PiArICAgICAgICAgICAgICNtYm94LWNlbGxzID0gPDE+Ow0KPj4gKyAgICAgICAg
ICAgICBzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPj4gKyAgICAgfTsNCj4+ICsNCj4+ICsgICAgIG1h
aWxib3hANTAwMDAwMDAgew0KPj4gKyAgICAgICAgICAgICBjb21wYXRpYmxlID0gIm1pY3JvY2hp
cCxtaXYtaWhjLXJ0bC12MiI7DQo+PiArICAgICAgICAgICAgIG1pY3JvY2hpcCxpaGMtY2hhbi1k
aXNhYmxlZC1tYXNrID0gL2JpdHMvIDE2IDwwPjsNCj4gDQo+IERvZXMgbm90IGxvb2sgbGlrZSBm
b2xsb3dpbmcgRFRTIGNvZGluZyBzdHlsZSAtIG9yZGVyIG9mIHByb3BlcnRpZXMuDQo+IA0KPj4g
KyAgICAgICAgICAgICByZWcgPSA8MHgwIDB4NTAwMDAwMDAgMHgwIDB4MWMwMDA+Ow0KPj4gKyAg
ICAgICAgICAgICBpbnRlcnJ1cHQtcGFyZW50ID0gPCZwbGljPjsNCj4+ICsgICAgICAgICAgICAg
aW50ZXJydXB0cyA9IDwxODA+LCA8MTc5PiwgPDE3OD4sIDwxNzc+Ow0KPj4gKyAgICAgICAgICAg
ICBpbnRlcnJ1cHQtbmFtZXMgPSAiaGFydC0xIiwgImhhcnQtMiIsICJoYXJ0LTMiLCAiaGFydC00
IjsNCj4+ICsgICAgICAgICAgICAgI21ib3gtY2VsbHMgPSA8MT47DQo+PiArICAgICAgICAgICAg
IHN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+PiArICAgICB9Ow0KPj4gKw0KPj4gKyAgICAgcmVmY2xr
X2NjYzogY2NjcmVmY2xrIHsNCj4gDQo+IFBsZWFzZSB1c2UgbmFtZSBmb3IgYWxsIGZpeGVkIGNs
b2NrcyB3aGljaCBtYXRjaGVzIGN1cnJlbnQgZm9ybWF0DQo+IHJlY29tbWVuZGF0aW9uOiAnY2xv
Y2stPGZyZXE+JyAoc2VlIGFsc28gdGhlIHBhdHRlcm4gaW4gdGhlIGJpbmRpbmcgZm9yDQo+IGFu
eSBvdGhlciBvcHRpb25zKS4NCj4gDQo+IGh0dHBzOi8vd2ViLmdpdC5rZXJuZWwub3JnL3B1Yi9z
Y20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvdHJlZS9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvY2xvY2svZml4ZWQtY2xvY2sueWFtbA0KVGhlIGZhYnJpYyBk
dHNpIGRlc2NyaWJlcyBlbGVtZW50cyBjb25maWd1cmVkIGJ5IHRoZSBGUEdBIGJpdHN0cmVhbS4g
DQpUaGlzIG5vZGUgaXMgbmFtZWQgYXMgc3VjaCBiZWNhdXNlIHRoZSBDbG9jayBDb25kaXRpb25l
ciBDaXJjdWl0IENDQydzIA0KcmVmZXJlbmNlIGNsb2NrIHNvdXJjZSBpcyBzZXQgYnkgdGhlIEZQ
R0EgYml0c3RyZWFtLCB3aGlsZSBpdHMgZnJlcXVlbmN5IA0KaXMgZGV0ZXJtaW5lZCBieSBhbiBv
bi1ib2FyZCBvc2NpbGxhdG9yLg0KDQpIb3BlIHRoaXMgY2xhcmlmaWVzIHRoZSByYXRpb25hbGUg
YmVoaW5kIHRoZSBub2RlIG5hbWUuDQoNClRoYW5rcywNClZhbGVudGluYQ0KDQo+IA0KPiBPciBh
bnl0aGluZyBtb3JlIHJlYXNvbmFibGUgdGhhbiBqdXN0IGJ1bmNoIG9mIGxldHRlcnMuDQo+IA0K
Pj4gKyAgICAgICAgICAgICBjb21wYXRpYmxlID0gImZpeGVkLWNsb2NrIjsNCj4+ICsgICAgICAg
ICAgICAgI2Nsb2NrLWNlbGxzID0gPDA+Ow0KPiANCj4gDQo+PiArICAgICB9Ow0KPj4gK307DQo+
PiArDQo+PiArJmNjY19zdyB7DQo+PiArICAgICBjbG9ja3MgPSA8JnJlZmNsa19jY2M+LCA8JnJl
ZmNsa19jY2M+LCA8JnJlZmNsa19jY2M+LCA8JnJlZmNsa19jY2M+LA0KPj4gKyAgICAgICAgICAg
ICAgPCZyZWZjbGtfY2NjPiwgPCZyZWZjbGtfY2NjPjsNCj4+ICsgICAgIGNsb2NrLW5hbWVzID0g
InBsbDBfcmVmMCIsICJwbGwwX3JlZjEiLCAicGxsMV9yZWYwIiwgInBsbDFfcmVmMSIsDQo+PiAr
ICAgICAgICAgICAgICAgICAgICJkbGwwX3JlZiIsICJkbGwxX3JlZiI7DQo+PiArICAgICBzdGF0
dXMgPSAib2theSI7DQo+PiArfTsNCj4+IGRpZmYgLS1naXQgYS9hcmNoL3Jpc2N2L2Jvb3QvZHRz
L21pY3JvY2hpcC9tcGZzLWRpc2NvLWtpdC5kdHMgYi9hcmNoL3Jpc2N2L2Jvb3QvZHRzL21pY3Jv
Y2hpcC9tcGZzLWRpc2NvLWtpdC5kdHMNCj4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+PiBpbmRl
eCAwMDAwMDAwMDAwMDAuLjc0MjM2OTQ3MGFiMA0KPj4gLS0tIC9kZXYvbnVsbA0KPj4gKysrIGIv
YXJjaC9yaXNjdi9ib290L2R0cy9taWNyb2NoaXAvbXBmcy1kaXNjby1raXQuZHRzDQo+PiBAQCAt
MCwwICsxLDE5MSBAQA0KPj4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMCBP
UiBNSVQpDQo+PiArLyogQ29weXJpZ2h0IChjKSAyMDIwLTIwMjUgTWljcm9jaGlwIFRlY2hub2xv
Z3kgSW5jICovDQo+PiArDQo+PiArL2R0cy12MS87DQo+PiArDQo+PiArI2luY2x1ZGUgIm1wZnMu
ZHRzaSINCj4+ICsjaW5jbHVkZSAibXBmcy1kaXNjby1raXQtZmFicmljLmR0c2kiDQo+PiArI2lu
Y2x1ZGUgPGR0LWJpbmRpbmdzL2dwaW8vZ3Bpby5oPg0KPj4gKyNpbmNsdWRlIDxkdC1iaW5kaW5n
cy9sZWRzL2NvbW1vbi5oPg0KPj4gKw0KPj4gKy8gew0KPj4gKyAgICAgbW9kZWwgPSAiTWljcm9j
aGlwIFBvbGFyRmlyZS1Tb0MgRGlzY292ZXJ5IEtpdCI7DQo+PiArICAgICBjb21wYXRpYmxlID0g
Im1pY3JvY2hpcCxtcGZzLWRpc2NvLWtpdC1yZWZlcmVuY2UtcnRsLXYyNTA3IiwNCj4+ICsgICAg
ICAgICAgICAgICAgICAibWljcm9jaGlwLG1wZnMtZGlzY28ta2l0IiwNCj4+ICsgICAgICAgICAg
ICAgICAgICAibWljcm9jaGlwLG1wZnMiOw0KPj4gKw0KPj4gKyAgICAgYWxpYXNlcyB7DQo+PiAr
ICAgICAgICAgICAgIGV0aGVybmV0MCA9ICZtYWMwOw0KPj4gKyAgICAgICAgICAgICBzZXJpYWw0
ID0gJm1tdWFydDQ7DQo+PiArICAgICB9Ow0KPj4gKw0KPj4gKyAgICAgY2hvc2VuIHsNCj4+ICsg
ICAgICAgICAgICAgc3Rkb3V0LXBhdGggPSAic2VyaWFsNDoxMTUyMDBuOCI7DQo+PiArICAgICB9
Ow0KPj4gKw0KPj4gKyAgICAgbGVkcyB7DQo+PiArICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAi
Z3Bpby1sZWRzIjsNCj4+ICsNCj4+ICsgICAgICAgICAgICAgbGVkLTEgew0KPj4gKyAgICAgICAg
ICAgICAgICAgICAgIGdwaW9zID0gPCZncGlvMiAxNyBHUElPX0FDVElWRV9ISUdIPjsNCj4+ICsg
ICAgICAgICAgICAgICAgICAgICBjb2xvciA9IDxMRURfQ09MT1JfSURfQU1CRVI+Ow0KPj4gKyAg
ICAgICAgICAgICAgICAgICAgIGxhYmVsID0gImxlZDEiOw0KPj4gKyAgICAgICAgICAgICB9Ow0K
Pj4gKw0KPj4gKyAgICAgICAgICAgICBsZWQtMiB7DQo+PiArICAgICAgICAgICAgICAgICAgICAg
Z3Bpb3MgPSA8JmdwaW8yIDE4IEdQSU9fQUNUSVZFX0hJR0g+Ow0KPj4gKyAgICAgICAgICAgICAg
ICAgICAgIGNvbG9yID0gPExFRF9DT0xPUl9JRF9SRUQ+Ow0KPj4gKyAgICAgICAgICAgICAgICAg
ICAgIGxhYmVsID0gImxlZDIiOw0KPj4gKyAgICAgICAgICAgICB9Ow0KPj4gKw0KPj4gKyAgICAg
ICAgICAgICBsZWQtMyB7DQo+PiArICAgICAgICAgICAgICAgICAgICAgZ3Bpb3MgPSA8JmdwaW8y
IDE5IEdQSU9fQUNUSVZFX0hJR0g+Ow0KPj4gKyAgICAgICAgICAgICAgICAgICAgIGNvbG9yID0g
PExFRF9DT0xPUl9JRF9BTUJFUj47DQo+PiArICAgICAgICAgICAgICAgICAgICAgbGFiZWwgPSAi
bGVkMyI7DQo+PiArICAgICAgICAgICAgIH07DQo+PiArDQo+PiArICAgICAgICAgICAgIGxlZC00
IHsNCj4+ICsgICAgICAgICAgICAgICAgICAgICBncGlvcyA9IDwmZ3BpbzIgMjAgR1BJT19BQ1RJ
VkVfSElHSD47DQo+PiArICAgICAgICAgICAgICAgICAgICAgY29sb3IgPSA8TEVEX0NPTE9SX0lE
X1JFRD47DQo+PiArICAgICAgICAgICAgICAgICAgICAgbGFiZWwgPSAibGVkNCI7DQo+PiArICAg
ICAgICAgICAgIH07DQo+PiArDQo+PiArICAgICAgICAgICAgIGxlZC01IHsNCj4+ICsgICAgICAg
ICAgICAgICAgICAgICBncGlvcyA9IDwmZ3BpbzIgMjEgR1BJT19BQ1RJVkVfSElHSD47DQo+PiAr
ICAgICAgICAgICAgICAgICAgICAgY29sb3IgPSA8TEVEX0NPTE9SX0lEX0FNQkVSPjsNCj4+ICsg
ICAgICAgICAgICAgICAgICAgICBsYWJlbCA9ICJsZWQ1IjsNCj4+ICsgICAgICAgICAgICAgfTsN
Cj4+ICsNCj4+ICsgICAgICAgICAgICAgbGVkLTYgew0KPj4gKyAgICAgICAgICAgICAgICAgICAg
IGdwaW9zID0gPCZncGlvMiAyMiBHUElPX0FDVElWRV9ISUdIPjsNCj4+ICsgICAgICAgICAgICAg
ICAgICAgICBjb2xvciA9IDxMRURfQ09MT1JfSURfUkVEPjsNCj4+ICsgICAgICAgICAgICAgICAg
ICAgICBsYWJlbCA9ICJsZWQ2IjsNCj4+ICsgICAgICAgICAgICAgfTsNCj4+ICsNCj4+ICsgICAg
ICAgICAgICAgbGVkLTcgew0KPj4gKyAgICAgICAgICAgICAgICAgICAgIGdwaW9zID0gPCZncGlv
MiAyMyBHUElPX0FDVElWRV9ISUdIPjsNCj4+ICsgICAgICAgICAgICAgICAgICAgICBjb2xvciA9
IDxMRURfQ09MT1JfSURfQU1CRVI+Ow0KPj4gKyAgICAgICAgICAgICAgICAgICAgIGxhYmVsID0g
ImxlZDciOw0KPj4gKyAgICAgICAgICAgICB9Ow0KPj4gKw0KPj4gKyAgICAgICAgICAgICBsZWQt
OCB7DQo+PiArICAgICAgICAgICAgICAgICAgICAgZ3Bpb3MgPSA8JmdwaW8xIDkgR1BJT19BQ1RJ
VkVfSElHSD47DQo+PiArICAgICAgICAgICAgICAgICAgICAgY29sb3IgPSA8TEVEX0NPTE9SX0lE
X1JFRD47DQo+PiArICAgICAgICAgICAgICAgICAgICAgbGFiZWwgPSAibGVkOCI7DQo+PiArICAg
ICAgICAgICAgIH07DQo+PiArICAgICB9Ow0KPj4gKw0KPj4gKyAgICAgZGRyY19jYWNoZV9sbzog
bWVtb3J5QDgwMDAwMDAwIHsNCj4+ICsgICAgICAgICAgICAgZGV2aWNlX3R5cGUgPSAibWVtb3J5
IjsNCj4+ICsgICAgICAgICAgICAgcmVnID0gPDB4MCAweDgwMDAwMDAwIDB4MCAweDQwMDAwMDAw
PjsNCj4+ICsgICAgICAgICAgICAgc3RhdHVzID0gIm9rYXkiOw0KPiANCj4gV2h5PyBEaWQgeW91
IGRpc2FibGUgaXQgYW55d2hlcmU/DQo+IA0KPj4gKyAgICAgfTsNCj4+ICsNCj4+ICsgICAgIHJl
c2VydmVkLW1lbW9yeSB7DQo+PiArICAgICAgICAgICAgICNhZGRyZXNzLWNlbGxzID0gPDI+Ow0K
Pj4gKyAgICAgICAgICAgICAjc2l6ZS1jZWxscyA9IDwyPjsNCj4+ICsgICAgICAgICAgICAgcmFu
Z2VzOw0KPj4gKw0KPj4gKyAgICAgICAgICAgICBoc3NfcGF5bG9hZDogcmVnaW9uQEJGQzAwMDAw
IHsNCj4gDQo+IERvbid0IG1peCBjYXNlcy4gU2hvdWxkIGJlIGxvd2VyY2FzZSBoZXggZXZlcnl3
aGVyZS4NCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQoNCg==

