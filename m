Return-Path: <linux-kernel+bounces-854856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D480BDF952
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 18:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A12101A21087
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 16:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDEC732F77D;
	Wed, 15 Oct 2025 16:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="C0UoLuQs"
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012038.outbound.protection.outlook.com [40.107.200.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE8F261B91
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 16:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760544646; cv=fail; b=aFWvONkIAqMF5i0HnTs7L2Js43QrSVHZaWmrFavPlZXkeG99I66CL8mLNdf1AJezDS+XjaMbL8zU5/HxWnff0V47MR22OnPBv0avZh2BNRFj3UmsGkbokAjg4MD0RS9UTLFvtl+Kkwi2uLkKp5tmrscFprxCzX44zbci+4xUNyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760544646; c=relaxed/simple;
	bh=abxMTNUAXdMgfpA+A1AQhBxKf7tNhOkxHqEUjlrN1SE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Rrlib+HHj6Y6hxt/Vh2rmBDwzu2XWR7YcmT4jq/yGTBsKcXRGfrtbHmGWdpn5DARaC0KuNHH2V9NEU1XPIq9up5VosJpfb76RI2t5ST2wgjkLo/ak+/smHhyLhh7x6PmEdJ2L6vnAf9uj0nysvQN0XaQXfuB3YgdTfRI4LctCNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=C0UoLuQs; arc=fail smtp.client-ip=40.107.200.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ACJxg6O/UzE35NyttyHxrkqvb5MTIbKjSmRGjZmoPewp3C5VRFUGYiC7glBS1w2mPuEPSp0SmPc/xxz8xiWUPj607XYgy0u5fX6ImfquW9F0sNU9UFd7kpSj1YtNz9qkQfNJFb1mX4MCJQ9Peb7ozyUp3s0OGgS1iSbqpQBWctaKUt5YherNBf9eq6AhkPMZSw/EFxggzGqvxOMOplix2PFqLN5pjosC5MA8ORY7McY34cBVnzolKdVk9eM9tVvXyY60qOLbtm4F9k27liNFM6bLEyXA7HQwtS0STmp4okAnOJtZtM4uQfpnVLCKWJij32i7WicykAQ5QTxXMJMwSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=abxMTNUAXdMgfpA+A1AQhBxKf7tNhOkxHqEUjlrN1SE=;
 b=gNXPzH7CuVF94YBhsDycxC57bOnJL1/DUZ6wdVgB5DN2Br9TdLXRt5DJxxHNegv4zsmRbY3ahvR2QZcBqqyxiB2SCd5MBeMFHPRTvLM/Em2ineK8Nu6ZZ8VznucEggrf3bCc9GUgK6o2aAYG0S8kCosGlMK8IwBYF5Otz+un6KTDIIes9HXp/4migT9KZ45VsD8T4b6xO4szToyM1rwdtP25rL0mmXmLLIBoOwkXLqHwHaFZmltpbEYTZ/s9gETumzrFlTO1bwaU9n1pQE45VsGH4+p4w+QQnh8omRylD3zbPmj4YhuSNsNH43fFl6ONfqU9cF0yglJmDxzMkF4l0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=abxMTNUAXdMgfpA+A1AQhBxKf7tNhOkxHqEUjlrN1SE=;
 b=C0UoLuQsswLimob8EWSF8ewegjtTjEOsH8s0M9KUwdbsNXeqaoLIy2MK+MXo0da+TYMuRUs4UCzHHp5FFUJrc+upbWo+Mmwv9wniA7zbUsgNMzrFHO7mRkhzLGn3XzqfVXwrU7/taLuBQRV6+f7yLCDBJdQ1yCZN+SBdTysbbsY=
Received: from LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 by IA0PR12MB9048.namprd12.prod.outlook.com (2603:10b6:208:408::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Wed, 15 Oct
 2025 16:10:40 +0000
Received: from LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::2202:1a7e:2dd:ad1d]) by LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::2202:1a7e:2dd:ad1d%4]) with mapi id 15.20.9228.009; Wed, 15 Oct 2025
 16:10:39 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
CC: Aaron Rainbolt <arraybolt3@gmail.com>, Thomas Gleixner
	<tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra
	<peterz@infradead.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Ingo
 Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
	Alexander Graf <graf@amazon.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH 00/56] Dynamic mitigations
Thread-Topic: [RFC PATCH 00/56] Dynamic mitigations
Thread-Index: AQHcPYmqb7qd0BZyXkK7jo/Wse1167TDOpgwgAAfIoCAAACCsIAABNuAgAABaAA=
Date: Wed, 15 Oct 2025 16:10:38 +0000
Message-ID:
 <LV3PR12MB926513717F67A02278659F5094E8A@LV3PR12MB9265.namprd12.prod.outlook.com>
References: <20251013143444.3999-1-david.kaplan@amd.com>
 <20251014231039.6d23008f@kf-m2g5>
 <LV3PR12MB926564CC5E88E16CE373185694E8A@LV3PR12MB9265.namprd12.prod.outlook.com>
 <cnwawavsdedrp6yyylt2wqiglekwsgrofimkvh32fknj676xsh@4vyzzoky5hzd>
 <LV3PR12MB9265837FA51DFD9D2F11474D94E8A@LV3PR12MB9265.namprd12.prod.outlook.com>
 <a5kvnas7cttg3pxqdxye7qhyesbtyulhhdiunl2hr5tfmecpbz@y4ggjfafqawn>
In-Reply-To: <a5kvnas7cttg3pxqdxye7qhyesbtyulhhdiunl2hr5tfmecpbz@y4ggjfafqawn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-15T16:07:20.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9265:EE_|IA0PR12MB9048:EE_
x-ms-office365-filtering-correlation-id: 8547c7ad-6336-43a2-fc7b-08de0c0561e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?V1hLQjRsRHRpYzI4bTB5Z0IxSmpxMVRXZ2xFN0JZZ2pvaVlkSzJhcklzaThz?=
 =?utf-8?B?dzViMDJpbDQ0MDBxMFBNUitpMnF1MXFnSUxXWXhKU2w4a1RCTnVEU2pqQTc1?=
 =?utf-8?B?WW1MNTEwTjhuNmlvV0hvZlVocUkyUEIzRzFReTdyTGZwQXE4dThMbFF3UW92?=
 =?utf-8?B?WCtZeGN4WEFCV042bWZMRVhBMDd2Vzg1VFU3cUhjK01nUy9DQU4wOHNUSWRw?=
 =?utf-8?B?cFZvZzhibVNzSFFvMmFEWWlmRVZ1RHlQeG9VOGFjZDd4eW42NVh5VjM0Yy8w?=
 =?utf-8?B?S055a2ZFU3dQWmJEU1dBWmUxc1oranR6b0hXSDB3blJEZ2piUjRUN25qSU9R?=
 =?utf-8?B?am1vZ3h6bU9pQm5FaWdmTy9xa3NDak8vWVp5QUpaQXVYSFpVbWo5QzdQSzNk?=
 =?utf-8?B?QTlwUHljVW5JeVJUdk9KQzJ6aGl4Q1ZRUmowNjVXbkhPMkhnWUV4NHJxOFhw?=
 =?utf-8?B?a29ZWmdqcy9lWjQzeXc0MFlSSTQ5L1pwMThLNlJwYkEzTndBMDdEZ1RBNGow?=
 =?utf-8?B?blVYQWV3NWpZU2lJV08rTTk5NVZraU9jNnlJeWxkNCsrTU9RWVBKOXJhQzJx?=
 =?utf-8?B?c1ZaMkU1My9nMVZBVjB3dU1pWWJaZmg3VWhmNkhISEo2NU1ZVG54N1Fjd0U2?=
 =?utf-8?B?MVFGaEtlOE5xNzVJSXVLTmRSb1gwaHMyUVFkdTlkckFoT1VSVlpmNURYZkFp?=
 =?utf-8?B?eDhTWWZZNG1qMjJmQzNrbVRNalFaUnVWNHk2cENxVW9tenk0Z0YzRS80N0RI?=
 =?utf-8?B?QVdVOU81UkJXb3oyTWtQbjJQZlBKdkRvaGdvTCtrSWVyL3ZhczEwYkFOd0g0?=
 =?utf-8?B?RUZhMGNrLzdDYXFTMUdyYlFLalU5Nm1oL0VEZ0d3SVFYdi9QM1ZqUWQ3WjJa?=
 =?utf-8?B?c3YwaVhsSXJWZmtGeTBYOWdZbGtDbHZNbzlsNmdycUhmblhIeER3dzVpVWhk?=
 =?utf-8?B?OGhETkk0eGhIU0ZhTm5BRjcxSXhGR2JSblVPcUdEeWIzcGJhWko1cWRhY0Z3?=
 =?utf-8?B?WUt3SDZ0V2wzOWhkRlN6cnQySmV3ZG1qWmxta0YxVTJMSXNkZW0xRGVudjlG?=
 =?utf-8?B?RCtIdUE5REI1dUJDb2Z4YnlHVCtnZUVjRjV4b3FlbmxuT3ErbmdQZzRqeUp3?=
 =?utf-8?B?R3BJQ1krY2VNckJPZ1ZEQXA0SUJiWlBtNWVjdWZ1NmZqdThITlZJdG9neW9m?=
 =?utf-8?B?ckU0OUpmeWpSTmh3b254enJ5aVExcktFbDFtVEM0NExBTHhHejdIYy9raGls?=
 =?utf-8?B?cm1HNjJHQVQ1aVRWUXVTVVlrWS80RjczTnJHQm1KOUNWa1l4Yy9WNEowTzEz?=
 =?utf-8?B?RXZ6UGJpakJpK0FGV2d6R1BlRzdKYlplVmFueWVZMHZKMFozazVZb01GOHZy?=
 =?utf-8?B?TnJ4U0dsc2pINU8xdXozSUZseU10MXprbFZJZVFDdXhMMjlwMExaWS9heWxu?=
 =?utf-8?B?cFBUVG83MGd3RWMreHJjT0FWQnUrNUFQQzBuYWMzdVlBM0JKaGwwaEQ0Z1A0?=
 =?utf-8?B?dkJ6azJaT3FoRXRpSzAweTNaUWRZMUxEbzhJc2VDaXVjOVpoc2VZRFFIaGRu?=
 =?utf-8?B?RUZzZ3M2bjBXeUdCemk1SjBIa2ZTWnBYOThRSVJGRzF5aWNCeFhzdnVJSzVC?=
 =?utf-8?B?c1dqNzdnSnplZUdlSlNlOVVCTHBJcUs2bTk1enNHWkJOazR0ZDRGQm0rMUFC?=
 =?utf-8?B?MzVOQ1R3WUVkZVlNNWRiQ25TYUw4SGJYZEFwc0xjOTVCTjNCMlovZXV4aHBy?=
 =?utf-8?B?UU0zM0RtTEs4VHlpTUUzdG54TXJ3Vk1KbnZlemlibDh0dXQ4SGY1SE9LTVZv?=
 =?utf-8?B?ME9NcGkrSTR4RGpMbXlDZjIrN0F3VVNzQWVsd0N4RnMzb2E1dlIxS21meGZW?=
 =?utf-8?B?eXU5WEJLd0RpVzNpcklJZmhQVktLZ05pOWVsZHFKRDgyZDQ3eDVFL1dXU0Js?=
 =?utf-8?B?TzRPK1FCMlZJdHVTRlBITFh0eExZWmpndEFiQ1pIYUhUTXlaeHVkcDJnTS8z?=
 =?utf-8?B?Y25hODR1ZUo4SmFzT2tHS1lGVFI2ZDBkN1Jzc0pwOEdmTHhQNHVpWW5vN1Fj?=
 =?utf-8?Q?IEA2zp?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K1U1TGZDT2c1UkxYb1J1SEhTQ2ZVdlczZnRVUVNldUw4Q05EWEJKOWh1QVhy?=
 =?utf-8?B?bndOaU43N1pHT3VxVWZuQk9Pd2llSmZvQmV1Qis4RkJqTTY3TituT3BkZDJQ?=
 =?utf-8?B?Z0l1Y01FVWwxRTJGUlk4SG8wMkpkOXZrOUp4a2tMS1RDUC91SVh2MUhGMWVz?=
 =?utf-8?B?ZjFZcGFVWnEyVmh1ZDc3YncycUxMcWptZ241cmtqd3RLUTJTb1hKSVpvL203?=
 =?utf-8?B?bExGdloxMHg3M09kRTA2ZkJjWDVTWDhKTFpxdmx2VU16eUY3WjRmWHpZWDRC?=
 =?utf-8?B?NlM0RWxzazdUUFhsZzJPN2t3MEovMjNmQ0tYYlN2ZEtZMitOVksyR1NRaTdT?=
 =?utf-8?B?U0FjN2ZSK1NzanZGMHVFeDlLK2REUHlobEwxczN0OGFkNk5ocWI4QUg0cHgw?=
 =?utf-8?B?bHgzZUtoKzUyd3Fjb0h5NklmMXIzbUtvOHpOQ1lFc2xqRVc4OGZRVi9UZFpz?=
 =?utf-8?B?OVZQNWIxOFJ5YjJibCtaNldjSS9ZSVZ5dm0yV040RXEycC83N3hDSUdPZEhQ?=
 =?utf-8?B?UXNUSlRTSCt2bnEvQnVyU2FtdjBQREZoNVA1VURsdDQ2ZkZEVzVnd3hwM1Nl?=
 =?utf-8?B?aFRqYjVvUXVxUHdTQy9HRkpId3I3WUNrK1l5VG9KVVI2TDd4eWtOVFgxSGgz?=
 =?utf-8?B?WjE0dzdqcmVuWDc3TjlhbTVKNUJ5dFVpTnJBaTFWNEIzbHJQalkyL3hWVFNM?=
 =?utf-8?B?Y21DamthZnZqdHpWK00xN3VTNllTanlIUmhvbVhzMHJHaE1NY2M1Y3U4UlNV?=
 =?utf-8?B?amFrRitPeDJPVTRNOHRqVDUwUHFnOEVPOWZkQXVqa1VLSzAvdHJ6RitWVkxD?=
 =?utf-8?B?Y3JFWTkrRnFmL1h4eDl1VUpMU2ZwUEhJcmtDN1NFLzFUejlqUVpCQmVnZm93?=
 =?utf-8?B?YWJ4RmxCc3dHSW1aNXc3ZExQQ2NtdWlFQjJqM1FnY2l0cFlSNlEwSmc5RC9x?=
 =?utf-8?B?dzlrUjJBbHlSeENUSkNPTVAvV1NwTy9EaWFXRThuZWUrZURheFk2STE1N25j?=
 =?utf-8?B?cHZtWkZhcWtWVnFPNHB0dW1ZbUZHOW9FTzN4dFIzUnh3ckMvUW5Bc1ZxZkRL?=
 =?utf-8?B?N2lybzdzckFRcFVoZjJvNTVBWTRMWjZ3UHk4SXNwYXZDVnBLSE1GY1JoY2gz?=
 =?utf-8?B?UkhzOXhQTlhzdVVWcUNvUlVZazBXYy9zV2JBa1ZhZFIzaVNYV3V6UFBkTElC?=
 =?utf-8?B?NmxYempZWWhVdGlwSlZJTTZHeUsrWlRGenIwOHZZREdEWGZqeGZKdi9oamww?=
 =?utf-8?B?VDlNbXVqbUhwanRsbnUvZ1JtRU1rRWpvRGg3N0dKOG9JTjJ1ME9mU3M2WVA2?=
 =?utf-8?B?WG1nc0ZoYWZkaWR1cWxsVEMyZDZoSWdGZFdyR1R5K0hlOUE3aCtTNzBtcUxS?=
 =?utf-8?B?bkNWYmQ5emVsNTdUMnRNaDBMVjFVUkRHSTVNNzJvV0xlL1JnY2p3eWw1OFNB?=
 =?utf-8?B?U0RwMGxlcFFyNW9xMDZUNWYzdmxCRHVINHRxZ0hLTE1rT25OWHkvT3prTmc3?=
 =?utf-8?B?cVQ3aTFkd29CWmFibWFkUGdPZWhnZWI4WS9rVWFzdVNNNDBYYWVyWml1bGxk?=
 =?utf-8?B?WitLcHYzdDBNUFVsbVFWdXppMlYzYUJ2SE9CZm5ZeUZPdnRXRC9RZ3l1Mmx0?=
 =?utf-8?B?MkhsS2ZZZmR2d1hCSUw1eUxJVURHa3F5d3FrMGFxc1N2UGQ5RmpSUXlnSk8w?=
 =?utf-8?B?anJSdzZmYmtqMUJCSDJxNlVYWm1HcWxjMnU1ZzFEa2JBNGhKOHZNa2hnbyth?=
 =?utf-8?B?bzJUYllnWU9BNWRsazdRcXRWNSsrNGF1MnJ2SEsxSytLanBXSDRUeXI3cDdt?=
 =?utf-8?B?aXEzVmFuOFNWbXQySk54T1phU0lFaktaWXdFcjIwZlRpWDl3a1d3cFNBb3RM?=
 =?utf-8?B?TTYzNUJTSGxtZWt3cCtLdWZReTdkL2FxOU8wLy90TEgzM2ZPTTJUalM4YTI4?=
 =?utf-8?B?dDFWR2M5bFl3MjZBSnFydlB0RHc0b3RKdVBSWDdFTytVWUc0d1RBWHFGTU4x?=
 =?utf-8?B?NHlDcHNhUFFpMDk2MlB5NmdJOWhGY0JnalFsVUpaaTY0Rk5DM1RYTVdQZkU4?=
 =?utf-8?B?T1RhVnNIdHJMM2lRNVloNVR4am42R0UxYzNxMGtROFZwcDJaVU8zZTNvWnoy?=
 =?utf-8?Q?LDrI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8547c7ad-6336-43a2-fc7b-08de0c0561e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2025 16:10:38.9302
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rf7PAxTnGUJeEVx734L5QrrXPOgbE18sgUgP9U4w/scsQ9f9cMPeK+NaKuctIgIh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9048

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKb3NoIFBvaW1ib2V1ZiA8
anBvaW1ib2VAa2VybmVsLm9yZz4NCj4gU2VudDogV2VkbmVzZGF5LCBPY3RvYmVyIDE1LCAyMDI1
IDExOjAyIEFNDQo+IFRvOiBLYXBsYW4sIERhdmlkIDxEYXZpZC5LYXBsYW5AYW1kLmNvbT4NCj4g
Q2M6IEFhcm9uIFJhaW5ib2x0IDxhcnJheWJvbHQzQGdtYWlsLmNvbT47IFRob21hcyBHbGVpeG5l
cg0KPiA8dGdseEBsaW51dHJvbml4LmRlPjsgQm9yaXNsYXYgUGV0a292IDxicEBhbGllbjguZGU+
OyBQZXRlciBaaWpsc3RyYQ0KPiA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+OyBQYXdhbiBHdXB0YSA8
cGF3YW4ua3VtYXIuZ3VwdGFAbGludXguaW50ZWwuY29tPjsNCj4gSW5nbyBNb2xuYXIgPG1pbmdv
QHJlZGhhdC5jb20+OyBEYXZlIEhhbnNlbiA8ZGF2ZS5oYW5zZW5AbGludXguaW50ZWwuY29tPjsN
Cj4geDg2QGtlcm5lbC5vcmc7IEggLiBQZXRlciBBbnZpbiA8aHBhQHp5dG9yLmNvbT47IEFsZXhh
bmRlciBHcmFmDQo+IDxncmFmQGFtYXpvbi5jb20+OyBCb3JpcyBPc3Ryb3Zza3kgPGJvcmlzLm9z
dHJvdnNreUBvcmFjbGUuY29tPjsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4g
U3ViamVjdDogUmU6IFtSRkMgUEFUQ0ggMDAvNTZdIER5bmFtaWMgbWl0aWdhdGlvbnMNCj4NCj4g
Q2F1dGlvbjogVGhpcyBtZXNzYWdlIG9yaWdpbmF0ZWQgZnJvbSBhbiBFeHRlcm5hbCBTb3VyY2Uu
IFVzZSBwcm9wZXIgY2F1dGlvbg0KPiB3aGVuIG9wZW5pbmcgYXR0YWNobWVudHMsIGNsaWNraW5n
IGxpbmtzLCBvciByZXNwb25kaW5nLg0KPg0KPg0KPiBPbiBXZWQsIE9jdCAxNSwgMjAyNSBhdCAw
Mzo1MTowMVBNICswMDAwLCBLYXBsYW4sIERhdmlkIHdyb3RlOg0KPiA+ID4gT24gV2VkLCBPY3Qg
MTUsIDIwMjUgYXQgMDE6NTM6MzFQTSArMDAwMCwgS2FwbGFuLCBEYXZpZCB3cm90ZToNCj4gPiA+
ID4gPiBJZiBgcm9vdGAgaXMgY2FwYWJsZSBvZiBzZXR0aW5nIGBtaXRpZ2F0aW9ucz1vZmZgIHZp
YSB0aGlzIGludGVyZmFjZSwNCj4gPiA+ID4gPiBkb2Vzbid0IHRoYXQgc29tZXdoYXQgZGVmZWF0
IHRoZSBwdXJwb3NlIG9mIGRlbnlpbmcgYC9wcm9jL2tjb3JlYA0KPiA+ID4gPiA+IGFjY2VzcyBp
biBsb2NrZG93biBjb25maWRlbnRpYWxpdHkgbW9kZT8gQXNzdW1pbmcgb25lIGlzIHJ1bm5pbmcg
b24gYQ0KPiA+ID4gPiA+IENQVSB3aXRoIHNvbWUgZm9ybSBvZiBzaWRlLWNoYW5uZWwgbWVtb3J5
IHJlYWQgdnVsbmVyYWJpbGl0eSAod2hpY2ggdGhleQ0KPiA+ID4gPiA+IHZlcnkgbGlrZWx5IGFy
ZSksIHRoZXkgY2FuIHR1cm4gb2ZmIGFsbCBtaXRpZ2F0aW9ucywgdGhlbiByZWFkIGtlcm5lbA0K
PiA+ID4gPiA+IG1lbW9yeSB2aWEgb25lIG9mIHRob3NlIGV4cGxvaXRzLg0KPiA+ID4gPiA+DQo+
ID4gPiA+ID4gVGhlcmUgc2hvdWxkIGJlIGEgb25lLXdheSBzd2l0Y2ggdG8gYWxsb3cgZGVueWlu
ZyBhbGwgZnVydGhlciB3cml0ZXMgdG8NCj4gPiA+ID4gPiB0aGlzIGludGVyZmFjZSwgc28gdGhh
dCBvbmNlIHRoZSBzeXN0ZW0ncyBtaXRpZ2F0aW9ucyBhcmUgc2V0IHByb3Blcmx5LA0KPiA+ID4g
PiA+IGFueSBmdXJ0aGVyIGF0dGVtcHRzIHRvIGNoYW5nZSB0aGVtIHVudGlsIHRoZSBuZXh0IHJl
Ym9vdCBjYW4gYmUNCj4gPiA+ID4gPiBwcmV2ZW50ZWQuDQo+ID4gPiA+ID4NCj4gPiA+ID4NCj4g
PiA+ID4gVGhhdCdzIGEgZ29vZCBpZGVhLCB0aGVyZSBjb3VsZCBiZSBhIHNlcGFyYXRlIG1pdGln
YXRpb25fbG9jayBmaWxlDQo+ID4gPiA+IHBlcmhhcHMgdGhhdCBvbmNlIHdyaXR0ZW4gdG8gMSBk
ZW5pZXMgYW55IGZ1cnRoZXIgY2hhbmdlcy4NCj4gPiA+DQo+ID4gPiBXb3VsZG4ndCB0aGUgZW5h
YmxlbWVudCBvZiBsb2NrZG93biBtb2RlIGVmZmVjdGl2ZWx5IGZ1bmN0aW9uIGFzIHRoYXQNCj4g
PiA+IG9uZSB3YXkgc3dpdGNoPw0KPiA+ID4NCj4gPg0KPiA+IEknbSBub3QgdG9vIGZhbWlsaWFy
IHdpdGggbG9ja2Rvd24gbW9kZSwgYnV0IHRoYXQgZ2V0cyBlbmFibGVkICh3aXRoDQo+ID4gcmln
aHQgY21kbGluZSBvcHRpb25zKSBkdXJpbmcgYm9vdCByaWdodD8gIEkgZ3Vlc3MgdGhlIHF1ZXN0
aW9uIGlzDQo+ID4gd291bGQgd2Ugd2FudCB0byBhbGxvdyBhbnkgd2luZG93IGZvciB1c2Vyc3Bh
Y2UgdG8gcmVjb25maWd1cmUgdGhpbmdzDQo+ID4gYW5kIHRoZW4gbG9jayB0aGluZ3MgZG93biwg
b3Igc2F5IHRoYXQgaWYgeW91IGVuYWJsZSBsb2NrZG93biB0aGVuDQo+ID4gdGhpcyBpbnRlcmZh
Y2UgaXMgY29tcGxldGVseSBkaXNhYmxlZCBhbmQgeW91IG5lZWQgdG8gc3BlY2lmeSB5b3VyDQo+
ID4gbWl0aWdhdGlvbiBvcHRpb25zIG9uIHRoZSBjbWRsaW5lIG9ubHkuDQo+DQo+IFllYWgsIEkg
d291bGQgc2F5IHRoZSBsYXR0ZXIsIG90aGVyd2lzZSBpdCBkZWZlYXRzIHRoZSBwb2ludCBvZiBs
b2NrZG93bg0KPiBtb2RlLiAgTm90ZSB0aGF0IGxvY2tkb3duIG1vZGUgY2FuIGFsc28gYmUgZW5h
YmxlZCBhdCBydW50aW1lLg0KPg0KDQpPay4gIFNvIHRoYXQncyB1c2luZyB0aGUgc2VjdXJpdHlf
bG9ja2VkX2Rvd24oKSBBUEkgcHJlc3VtYWJseS4gIEFuZCB3aGF0IHJlYXNvbiB3b3VsZCB3ZSB3
YW50IHRvIGNoZWNrIGZvcj8gIFNob3VsZCBpdCBiZSBMT0NLRE9XTl9ERVZfTUVNIChzaW5jZSB3
ZSdyZSBwb3RlbnRpYWxseSBsZWFraW5nIGFyYml0cmFyeSBtZW1vcnkpPyAgT3IgYSBuZXcgbG9j
a2Rvd24gcmVhc29uPw0KDQotLURhdmlkIEthcGxhbg0K

