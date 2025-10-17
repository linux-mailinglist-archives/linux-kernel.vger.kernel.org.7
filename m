Return-Path: <linux-kernel+bounces-858137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBF8BE9181
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C11B24F7515
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 14:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3EBB36997B;
	Fri, 17 Oct 2025 14:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="taKVWPXc"
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012021.outbound.protection.outlook.com [40.107.209.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0682F6926
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 14:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760709856; cv=fail; b=S13amFBOuSWnM/WkszSrXjF9QrIAWBkyC2yu4XyUJJ/jHaqayI5n0pMXrv7ubl70y2njl3Y3n7CuJwVlLNiVbQdlRLzQf2Lq8TS3Ioj9x3AzbMw2uz1gcBKvZSrPbfPpZX8AzQNgONHjJGN4KEARY4KzKmus1h/0v8W5yAkvquM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760709856; c=relaxed/simple;
	bh=5hWoBuPJ3WoazG8EukHQTjxn+R99czoelzmhPGuW+h4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=e9xYGUl9594DRT4PqDismx3sojjlwtjZSajAqxnGhl9KOEvy/Rmx8V9m/lCanSrkhID4DO3uuOexOYTTTQwHroTGUYBvHI84dNDnG+eXO9npg2W0aj5oa3hsSpfWaByAl6x+DBb/S8Oph5pqlDZZqhw4AFQAm7cla8ToSysDCoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=taKVWPXc; arc=fail smtp.client-ip=40.107.209.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aOgeo2GcruFvZ0n1rCENRU1AjogPQmnLHVg4gpj+J7960VJtIemzhrRgVBYcVTnGUfnTVFTVVRJ73C5BfzdP4oWlwD3fp4ViWT/MiFZ52OKe0U1wMB8Fm4r+Ihc207YJt6mVScPzPgVom96ku2KeLl5pnCCwVJZnVo15KDCEgsQY5azn1O5Lx1tC7OM7Uiu+7SCcu/LWHPWh06KTMxsYjVrfpdApObhcLrA8fsEIO14FRrmTXfUiuYay+7mLDomiviX9z445Jxs6QdWQ6l19qQHJyIq8tLa/CAiTjS977AtRhkrRdzWlYOSjIKJpjPkTpdGcRPkX39q8dV62Ybkmng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5hWoBuPJ3WoazG8EukHQTjxn+R99czoelzmhPGuW+h4=;
 b=AxQCu58gV1dSXYrXC0bWJE8rCgJ1AkPb7dhWgUHuU3tIfv6LpeqSsDSOeYG8QQHeG0rOBI7FNAjFhK9z6DndfcWyp3wqT3d/uU2OGiM1d56tpAPv5THYYAga0aCc0XZmc+6/7foWINXVFoTxpc3t9xAF89cCHiVFNkFD30VrklphT/Y9NmVGRsyzhSsxWYVSusCcjk3fk1wAIwJGxAEmpwpRYiPIvwQHpIHHpaptJ47+Dp48yDfjc1R1Uug0v7Y+Ct7qAH9rNh8aH1zaXawLOjqAretFxWXPFA99CaarwTx/FYTXaW0qgxqimWQZuLlJn6M9vneQg7pWDNDj5KJb7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5hWoBuPJ3WoazG8EukHQTjxn+R99czoelzmhPGuW+h4=;
 b=taKVWPXcUm3UNt5/QA5RD7X+dskGE8z78Z1Mqd9dcOfR9qZJI1i9lv3vT5oqcfduQJ2dDTOw+n85xax7whTDXPnGA+p5WzKHlpmiUJZ93kCQFRByOosPRztRhMU4+SMxm6W+14m9QrXb6ZYEP4L+6TqLX93Ku73acibMCLQGm/8=
Received: from LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 by IA1PR12MB7759.namprd12.prod.outlook.com (2603:10b6:208:420::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Fri, 17 Oct
 2025 14:04:11 +0000
Received: from LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427]) by LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427%5]) with mapi id 15.20.9228.011; Fri, 17 Oct 2025
 14:04:10 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>, Pawan Gupta
	<pawan.kumar.gupta@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Dave
 Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "H .
 Peter Anvin" <hpa@zytor.com>, Alexander Graf <graf@amazon.com>, Boris
 Ostrovsky <boris.ostrovsky@oracle.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 01/56] Documentation/admin-guide: Add documentation
Thread-Topic: [RFC PATCH 01/56] Documentation/admin-guide: Add documentation
Thread-Index: AQHcPuNS5c8pgJt5hkmBzm7RrZp2d7TGXz5g
Date: Fri, 17 Oct 2025 14:04:10 +0000
Message-ID:
 <LV3PR12MB92652DD7F888DE1AC839F76194F6A@LV3PR12MB9265.namprd12.prod.outlook.com>
References: <20251013143444.3999-1-david.kaplan@amd.com>
 <20251013143444.3999-2-david.kaplan@amd.com>
 <yyzwkqzv2njelf3uhuy5x22hl7p3nvl6nilcakyjvxscccrpcm@zqnol2wanwey>
In-Reply-To: <yyzwkqzv2njelf3uhuy5x22hl7p3nvl6nilcakyjvxscccrpcm@zqnol2wanwey>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-17T14:01:18.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9265:EE_|IA1PR12MB7759:EE_
x-ms-office365-filtering-correlation-id: e45841fb-2cbb-4d1f-5413-08de0d860be0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?cDhaWW5pT1lpRjRWMGVUWVNiZkxzam0vd3FKei9FcUdQV1FsZUVFMXZhQ0Z4?=
 =?utf-8?B?aFZWQ2JNQ21PbUg1Zk4ycmFNV25QT05HT3B3V0lmalNDbkx3Smx6S2ZxSndW?=
 =?utf-8?B?dVBKVG4wdjdJSkdpVTl5WTlJbGVxM21mbDlqbk5WazNBNHJLWmphd3FsSWR2?=
 =?utf-8?B?UTBFY1RwN25zcVhXSVluNTRzdjlsdm1Ebk1BZUt3Nko2L2EvRGtHcXJxYXhS?=
 =?utf-8?B?TUd2THBIa3dkSVdaZnQ2cmRpWndrUVFkOUxvV1ZZYWdKc01PZTFlUTY5VFZY?=
 =?utf-8?B?c3MraEo2ZEVTN0VqWi9STWNDVmU1Y2YwQnM5SHBmSFRkYTJxZWpqbzExbTcr?=
 =?utf-8?B?RVlxVFBUQWZSc0VJMDBrUHdXdjZ5L0ZOclMyRWk3ZlpiZys4V1ZEZFJiL2dw?=
 =?utf-8?B?UHRRTmlBSFhWeTV6ZC9mbnNVZHg2VnJtVEdzZW1jdGJRdU0yVjAvMWJ2NHFi?=
 =?utf-8?B?bUtTckdWZEpMUjJYakk4eGNBTGRxdEpIU1E3RUFvVG14U1JYajlpQ0EwdC82?=
 =?utf-8?B?RXBaOWhxYStyS1BtMFFzMUExanQrVE1DOTcrUlJIazZLNndRRnEwaHBCKzBy?=
 =?utf-8?B?V0tRakNFbmdNZnZ6anRpNk5uNFh6QjRqL2dkMSt4RW05Q0x0b0RWUW9iRVBq?=
 =?utf-8?B?UEZFb3llNWNoU05BeFpWSVhoaHltU0dLWkY5dWJCeVFYdWFIdkNnWVpXQ0tN?=
 =?utf-8?B?MTF3ZVovQmpwUXBHa3VnL1RRMFJIeVE0R2FXUFZjcUExcG9pVzl4SXJPdk8r?=
 =?utf-8?B?Rm03RkM5bkdCWUQvUnpvd0NsY0h5R3E1amR5YWFYRTc3Q2xhSVB6MmN1QTBo?=
 =?utf-8?B?aHozakdZVU5obnNHaTl6aEl1U21ZVG41MGJJamlMSUlOZnJJNW94UFVSOHQx?=
 =?utf-8?B?VXlYdlp0bThnRUFQUTR2eHdyMWlxUHU5WmdUK0VpWmp5aEQ2akhhWFJpb2Nt?=
 =?utf-8?B?UHFyNkFvTXZYVGJSV2R6RS9XalRDQzlMOE1rODNucjgyaUs3Q2Y5c0ZXTmJG?=
 =?utf-8?B?SUUwWGRpMFIwZ1pURjNjY1pGU3V3WEI1aTdia2ZYTGFKOVZNZ3MrdmZZY2h4?=
 =?utf-8?B?YTRXYkZ5VUZLN3pIdUZLTU9tRStkR1VKaHNIZ09QaitsdCsvbmpCOGRud0E4?=
 =?utf-8?B?ZFpscU15NkVBNmxXQ1JnL3dVTmFqTHRzT3NJU0tsaW5uUjZBaDM3TzFqNldh?=
 =?utf-8?B?bEpkcXVzOG5rSkZ6T3ppdVBZMW1nT2xEZmJ4MUY4K3Q3TWFkVmRzQk5PU3h4?=
 =?utf-8?B?SXJjZ3pjMUs1Y3hpZzRqd21rbkJEKzR1c3oySDczazRrQlh3MEMraGhiWWdI?=
 =?utf-8?B?bFQwNFE1dml3cnI3QWxMajFuemVJWlFUWXl6enh5SjA3VjBDOGFFOEJDM09y?=
 =?utf-8?B?R0VoZTlZL1ZvRi9Ud0liaU9GOENaVWJncDVGMk52RzBRS1E1WDJrV2RjOGJw?=
 =?utf-8?B?QWN1WEZva2VwTm5jQk1rYjlxSHR6VTZDc095RGNtd2YzNmI0L1BMTGo1QkJn?=
 =?utf-8?B?V3RpZjJRUDZVa3o4UzVEeWF6V2NpcWoxMlFnME5zQW9GVy9mdjlISlQ1THJJ?=
 =?utf-8?B?MDFYNmM1RFNJeExTK2NYMkQvUlVSS0N6TjVaSyswdjNiMWE2L2FZMExlbjVD?=
 =?utf-8?B?N3BpU1BpWllpcU1pbStzTzMwUFlQeU1yS1d1VEUvMHBkZzkxbXBrTVVYay9x?=
 =?utf-8?B?eHdpNTB0SVVzMU1zRXhKMmV6c0hHNlgyaWRnVXZsSUt0ZXBXMUVETjBvQXZv?=
 =?utf-8?B?dXFaRzdGRENwdWo5ajZDZ2R4cDRsZVR6UGxKcGZ6aWptMUF6aCtOejQzdHlL?=
 =?utf-8?B?RTZMOWpxajNaNWtDZGNpczQ3MlJZRGd5RUJmblR2WWtJTnQrY0JuR3U1R2VV?=
 =?utf-8?B?NEpSaUM2bmkyN0ZOb0d1UGM4Uk9TQlM3aWp3ZlE4NGc2dk5PSnlBL2dxZm5q?=
 =?utf-8?B?emZ5cnI3dVJnTjlSQ0FzNSszUS8rdFFLNzEvOXFVQUxoR0JyMFE2ckhNSS9k?=
 =?utf-8?B?TGZxMkI1cmg1Vk1GbFpzeG44RWVUbVFEWS9LL2hPcTcvWVRuZTU0SUY2TTU3?=
 =?utf-8?Q?/zmJ25?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S2VQUkJtNGRNOWdwTi9NZitLajVFQjJIUkhPb3JhOEV6VXYrc1ZLaHJYRVJ4?=
 =?utf-8?B?bWJ2YkwvRGl2Y3p0QnJDVVhDSEU4SGNWVTFjWlloKzg1dXh6K0R5N3EwYlVN?=
 =?utf-8?B?Z0ZkK1FEQW8zdXQ3R014V0RqVnBydVNlV3JwRndUMHh6eHc1YTJUREtOSmZv?=
 =?utf-8?B?RzA0d2NMa042TzNSdmxYMzVXT3JHaTl2eHlNVEZ6ZTdUNXlpUVh5N210UmtG?=
 =?utf-8?B?djNndmxma2VLZGtCOWFURm4xdU14Q2ZTQWNyT3pUb0ltd1ozQ3hONXZuUVYy?=
 =?utf-8?B?bG9MQStHZDJQQmI5VFJaV0I2ZWYvNGV1V0lSbmtPc1c5WHZtVFFONU1PUTZ4?=
 =?utf-8?B?Nm5ETUUxZU0rSXpxWW1FWWlTTFdyZ3VVVExBMU14ZkQwNjNmRVBSUmZla1Zs?=
 =?utf-8?B?bHhwaXZ1a2R0cGNwRWFTbTdqR1d1VTNRTjErS3cwdGZZZWQxTm5uQUZ6Nzg0?=
 =?utf-8?B?SzhwN3VyUDZlaTNvbUlvd3BKOUxJZmFiSkxleGh5bFdJWExERGJpOFZtcm5L?=
 =?utf-8?B?WUNjT0hXY2t1L2o2anFQVDdpZW9OZi9kQTFtcWl1aHBGNzJrMU1zMlNkQml3?=
 =?utf-8?B?NWJsRHlsdlV4WFdGdXN4ekdtS1BXajd3MEdEQzNDUUhQZk9UZGhFN3UvRXMw?=
 =?utf-8?B?NjB3Z2J5dWFML1VleWZZN3pQd3pnVDMwQzNkdHl6RElhTHZvL3BJa004Q2Q4?=
 =?utf-8?B?T1BTNkdqMTZOYkpzWHdhY1pJalI3KzNUbjlaeTdIdFowZWUyQmlJVWJyaE00?=
 =?utf-8?B?dVV3a09VT1R6NUpXcGZwaTI3cnhGTldDODZaRVlEQXEwWFVyOHYwbWMzM0hR?=
 =?utf-8?B?eDBvcEJmbFV5WDc1NTdBcmhqeDJScjdxL2hsZHR2SWlnZ01LTHlzQ2pIdE1B?=
 =?utf-8?B?MVlPMVVsWGNRUGJxMUg0NzhuZFh3UkxqTXlySWMrSUZ6dnR5T0RMRW44MVBP?=
 =?utf-8?B?T0JJRXZqcldGNDFQOU9RUllWNTlESWQ4RHBDa2djbzBMeXJaMklvSW1TNVI4?=
 =?utf-8?B?dWE3RStNZGV5alF3aUFRaExHUFp3TS9BR3lRVGlLYlIwNGtJWEp0STBXVml3?=
 =?utf-8?B?bVZySWhQM2tMR0tmL1pid280dzByTVFLR20rNkdqeGpDSFdrUkt3MnZHcVRE?=
 =?utf-8?B?cjBkVmV2NGxTSU50WDI2N3Q5cXFlOE9JRFdQdFFjeVM2TFp5aVRrOU1qRXVK?=
 =?utf-8?B?WXp3QlZQbUVnK1NDeXRuNGlYYTlrcXZVQnRNNzRodnlid3d0WlZRNVFqZURL?=
 =?utf-8?B?aVZyejlQTnpXUlhHUW8wQjNlN2FySmQxeUhoanByblUzamxrUlhWa2tNcFh4?=
 =?utf-8?B?TzBhT3N0U1RUQ05jYkRyTVg1eEFwSUdpbXloZzNUTEdRcitNQ3pUUnQ3VnBL?=
 =?utf-8?B?MDFZQVNhQU8wZ1IzWUdWcVh2dnNPQkNXVWRhU0g3MERBWGErUU9zeEtYNEsr?=
 =?utf-8?B?Z0ZzUnhYd29XOEY1R3R2cG56VHQ1QWt0a01PSHZzaHVxV2RrN3lyNnhOaWlF?=
 =?utf-8?B?MUR6QW9kS05KSjN2aURqTU8xWDg2WGd2ejEyYXRKTmZRTnZMM21NUmtGay9Q?=
 =?utf-8?B?SDZSNGVSbGx3MkNIZlJZSnYxNU9YUzkyRHdYWDZ6bnF6UnA4WUdVWFFOTzVj?=
 =?utf-8?B?ZmtYMVArS2g5VEltbTdDYnFlS0hDVWFnMS9oSHlJR2RZcWJ4QWhMcWZQcnUw?=
 =?utf-8?B?eGlkcGdNNjJzZDdwdW5EUXZoOTVKTGVOUHdwVGZoWXFXcjFIUGl4YTQ2dm1h?=
 =?utf-8?B?eFk4blVxMUFaSzcvVWtTb0swZ0FMU1FyLzhJbHViclF2VUlVbkRtVzhZZEN4?=
 =?utf-8?B?cWg0aHNPNUhqZiswVG1ibnBuZDlyWXExM3VRbzh2Q293ZU0xQ0pPbXMwTFpy?=
 =?utf-8?B?am9jdUpNdmZ6WU1VZ0N2LzAvRzdqY1hTMnJUZnAxeUpMa0d6cFAxODNvb2VF?=
 =?utf-8?B?cXltU3dpdUgzeWRyajB3cjgvLzBwS1VHRytwdVk3Mnc3eGhKL0JxekZ1UHBB?=
 =?utf-8?B?OFl5ZFBpWjdzVUptN1ZiT2VMY01YRmgzRFZGS2NocUJZZjhIOHFZa29XUFhC?=
 =?utf-8?B?alRCZFJVdXhuV3JwVmczM1dXUzFJajk5OFFhTnl5N1JpY3J6MGxNRUNKeWd2?=
 =?utf-8?Q?PoBM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9265.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e45841fb-2cbb-4d1f-5413-08de0d860be0
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2025 14:04:10.9040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4ip+QyARWBL4nvvHuXk5tYeSkrC1bZphbYyeIp5c+5j95ZIMVGh9bicunRcrM8c2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7759

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKb3NoIFBvaW1ib2V1ZiA8
anBvaW1ib2VAa2VybmVsLm9yZz4NCj4gU2VudDogVGh1cnNkYXksIE9jdG9iZXIgMTYsIDIwMjUg
NDoyNSBQTQ0KPiBUbzogS2FwbGFuLCBEYXZpZCA8RGF2aWQuS2FwbGFuQGFtZC5jb20+DQo+IENj
OiBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT47IEJvcmlzbGF2IFBldGtvdiA8
YnBAYWxpZW44LmRlPjsgUGV0ZXINCj4gWmlqbHN0cmEgPHBldGVyekBpbmZyYWRlYWQub3JnPjsg
UGF3YW4gR3VwdGENCj4gPHBhd2FuLmt1bWFyLmd1cHRhQGxpbnV4LmludGVsLmNvbT47IEluZ28g
TW9sbmFyIDxtaW5nb0ByZWRoYXQuY29tPjsgRGF2ZQ0KPiBIYW5zZW4gPGRhdmUuaGFuc2VuQGxp
bnV4LmludGVsLmNvbT47IHg4NkBrZXJuZWwub3JnOyBIIC4gUGV0ZXIgQW52aW4NCj4gPGhwYUB6
eXRvci5jb20+OyBBbGV4YW5kZXIgR3JhZiA8Z3JhZkBhbWF6b24uY29tPjsgQm9yaXMgT3N0cm92
c2t5DQo+IDxib3Jpcy5vc3Ryb3Zza3lAb3JhY2xlLmNvbT47IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtSRkMgUEFUQ0ggMDEvNTZdIERvY3VtZW50YXRpb24v
YWRtaW4tZ3VpZGU6IEFkZCBkb2N1bWVudGF0aW9uDQo+DQo+IENhdXRpb246IFRoaXMgbWVzc2Fn
ZSBvcmlnaW5hdGVkIGZyb20gYW4gRXh0ZXJuYWwgU291cmNlLiBVc2UgcHJvcGVyIGNhdXRpb24N
Cj4gd2hlbiBvcGVuaW5nIGF0dGFjaG1lbnRzLCBjbGlja2luZyBsaW5rcywgb3IgcmVzcG9uZGlu
Zy4NCj4NCj4NCj4gT24gTW9uLCBPY3QgMTMsIDIwMjUgYXQgMDk6MzM6NDlBTSAtMDUwMCwgRGF2
aWQgS2FwbGFuIHdyb3RlOg0KPiA+ICtSdW50aW1lIExpbWl0YXRpb25zDQo+ID4gK15eXl5eXl5e
Xl5eXl5eXl5eXl4NCj4gPiArDQo+ID4gK1RoZXJlIGFyZSBhIGZldyBtaXRpZ2F0aW9ucyB0aGF0
IGNhbm5vdCBiZSB0b2dnbGVkIGF0IHJ1bnRpbWUgZHVlIHRvIHRoZSB3YXkNCj4gPiArdGhleSBh
cmUgc3RydWN0dXJlZC4gIFNwZWNpZmljYWxseSwga2VybmVsIFBUSSAocGFnZSB0YWJsZSBpc29s
YXRpb24pIGNhbm5vdCBiZQ0KPiA+ICt0b2dnbGVkIGJlY2F1c2Ugb2YgdGhlIGNvbXBsZXhpdHkg
b2YgdGhpcyBtaXRpZ2F0aW9uLiAgQWRkaXRpb25hbGx5LCBTTVQgY2Fubm90DQo+ID4gK2JlIGRp
c2FibGVkIGF0IHJ1bnRpbWUuICBUaGVyZWZvcmUsIGlmIGEgYnVnIG1pdGlnYXRpb24gcmVxdWly
ZXMgZGlzYWJsaW5nIFNNVCwNCj4gPiArYSB3YXJuaW5nIG1lc3NhZ2Ugd2lsbCBiZSBwcmludGVk
Lg0KPg0KPiBJcyB0aGVyZSBhIHBhcnRpY3VsYXIgcmVhc29uIFNNVCBjYW4ndCBiZSBkaXNhYmxl
ZD8gIFRoZXJlJ3MgZGVmaW5pdGVseQ0KPiBhIHdheSB0byBkbyBpdCwgc2VlIC9zeXMvZGV2aWNl
cy9zeXN0ZW0vY3B1L3NtdC97YWN0aXZlLGNvbnRyb2x9Lg0KPg0KDQpSZWFzb24gd2FzIEkgZGlk
bid0IHJlYWxpemUgeW91IGNvdWxkIGRvIHRoYXQgOikNCg0KVGhlIGV4aXN0aW5nIGJ1Z3MuYyBs
b2dpYyB1c2VkIGNwdV9zbXRfZGlzYWJsZSgpIHdoaWNoIGlzIGFuIF9faW5pdCBmdW5jdGlvbi4g
IEJ1dCBub3cgSSBzZWUgdGhhdCBpZiB5b3UgaGF2ZSBDT05GSUdfSE9UUExVR19TTVQgdGhlbiBj
cHVocF9zbXRfZW5hYmxlKCkvY3B1aHBfc210X2Rpc2FibGUoKSBsb29rIGxpa2UgdGhleSBzaG91
bGQgYmUgYWJsZSB0byBoYW5kbGUgdGhpcy4NCg0KSSB3aWxsIGxvb2sgaW50byBzdXBwb3J0aW5n
IHRoaXMsIGlmIENPTkZJR19IT1RQTFVHX1NNVCBpcyBlbmFibGVkLg0KDQpUaGFua3MNCi0tRGF2
aWQgS2FwbGFuDQo=

