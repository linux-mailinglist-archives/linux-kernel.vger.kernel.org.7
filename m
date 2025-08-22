Return-Path: <linux-kernel+bounces-782099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC052B31B08
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 16:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13D1B1C87C8B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 14:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39EC2FDC59;
	Fri, 22 Aug 2025 14:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RzcrFXje"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE9418027
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 14:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755871979; cv=fail; b=GSNZVI44PZb5kDMxC8vL412a1yRGdqgIbueDwpDYBev7zRpklZghG42BLZ88is8Haa52e4I/qI0TS4ifEVgr9SYR8KGt7blH4gmDCvNKMIQpX7g6uhoDCdmHjfBZFbtXg6sNAfGJeOfQoqsYPDB/sLgiwfTRaYpcmVpgrVcfsIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755871979; c=relaxed/simple;
	bh=qgc284T/+vC1gWb9nlrNjCf2fH3mRxZI5ETkoUCV/mY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PRhgE0/ZsKWL6EksxD8HCZfK/5qTMvr2rdo+ufkQx8YmAotQbe6wuQNE6rDG0YqTmm0QLKXW3SpZ36dlO/TBdw9i4Ix34hm2SmP4P5bBNTXmCC9Mw5Frp4rW85NuyWzgM7rzgYsYe9+hN0m4hiYnaZmZJh6GzR0a1X7GNrzxrIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RzcrFXje; arc=fail smtp.client-ip=40.107.244.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jPepSJRd7Pu3XVko8AHDN4yPHyNyOnyEv+BzbSLZwojtGAQcyh+svRuWURhmEkX+ScCHe8/1TXfB3TOu85pB5kMMC9HfWkDIL0ON1ALNpc01gAiPVXvVTpj4EBR8HbP9UNg5wM8JX5lwQu7Mzb//I+D7DBVjherIWpd/y/kshVh2CG6mxEQxDwYQhvawS6bWdUWRjHcJ05ldK+O6giJ9OYl/mWgwVVcKaVJhoLa1JwDwIXqsp/yK9rEBmMN11+byx0ZoysiQpxG15OJyKL3yYuWFAxE0tkOhtUScJdqKo8HDXKmgNuCf+oDHiwEUydbYHX1STHwZThlsAanemF32Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qgc284T/+vC1gWb9nlrNjCf2fH3mRxZI5ETkoUCV/mY=;
 b=t15t1+tMtD27Z6szIcf4AsFg6y+Holw5KiHmZKoVWC9n/L+wiPogPYihlOMpDp9jT55u1fQHbTKPUpSc+RtoZkAnI4RFKfz56c1tzadtUw5VimeejkpPG5UAyHgzL8FQ9oKShSBd1aDmYEtkmN+EixApznfiEZWTp2vv6XEMjUf5UcsvgWZv3dN9o7gB0/ZXjF8ZQhCbDFr24LI08PFIzee+nm3heiCBJFmKErJHCVY2uJ91+RjjzEGvwCsWgA67OLIf/7mZGuBmNCaP3GhwF2Lq4bhZ3ztXcnoIEE6RtkzwAAwArcfviY1YQBz7m5PoTWsuJzT4Q8LeINmSlwYX9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qgc284T/+vC1gWb9nlrNjCf2fH3mRxZI5ETkoUCV/mY=;
 b=RzcrFXjee6x4Xfs9U53faTZ6Wk5E+FsG7ZGyr7r52Zj8zBslpaKiabqFoJtcW0Cs6qy76Hbjzs8bVtR4rqfXDkLICdX/2ynos9nqIkBUnPOiaDkHbfcrYyZVrdFUqnEffr3u1JORy0ZBX4/bMBj62HRJZ65krRJJU5pf2xfcBNU=
Received: from LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 by DM4PR12MB5866.namprd12.prod.outlook.com (2603:10b6:8:65::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.17; Fri, 22 Aug 2025 14:12:55 +0000
Received: from LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427]) by LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427%5]) with mapi id 15.20.9052.013; Fri, 22 Aug 2025
 14:12:55 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Borislav Petkov <bp@alien8.de>
CC: Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra
	<peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>, Pawan Gupta
	<pawan.kumar.gupta@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Dave
 Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "H .
 Peter Anvin" <hpa@zytor.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/5] x86/bugs: Use early_param for spectre_v2
Thread-Topic: [PATCH v2 2/5] x86/bugs: Use early_param for spectre_v2
Thread-Index: AQHcE1reQABwsv3XzUmOUufzJ3QV8rRus+ww
Date: Fri, 22 Aug 2025 14:12:55 +0000
Message-ID:
 <LV3PR12MB9265EFE40F2C8EB7C15BBD06943DA@LV3PR12MB9265.namprd12.prod.outlook.com>
References: <20250819192200.2003074-1-david.kaplan@amd.com>
 <20250819192200.2003074-3-david.kaplan@amd.com>
 <20250822114918.GQaKhZPrvA7zP33TX4@fat_crate.local>
In-Reply-To: <20250822114918.GQaKhZPrvA7zP33TX4@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-22T14:01:54.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9265:EE_|DM4PR12MB5866:EE_
x-ms-office365-filtering-correlation-id: 08b64f08-0d7f-4733-93ed-08dde185fd47
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aVJRV0RzdDVHUFBtN05keEFqcE5rODdRYjR6VWFJYTRoTGNERS8xME50ckNn?=
 =?utf-8?B?Mm4zWW4wNFJ2NUdlamxuTjlha0dUTGR5c2N1OVRpVzlWUkZPN1g5NUR3NzRa?=
 =?utf-8?B?R3N4RWhDbzZvaXpaR3BNQVE5VitCWHB0NWpEOW1RL0hacUIxVzRUYlRRaTYv?=
 =?utf-8?B?dE1XaTBKUEF4VkdKcFJjbmtjU2haRyt0eDAzZ2I0ZTFoOWZtZjBPQzRmTktL?=
 =?utf-8?B?di9yN1JvRzRTWXRxNlVSR0UrTVJtRENsZ3NCNjJ0di9Vd3hVbHFRZGpaT3hZ?=
 =?utf-8?B?WHB3YXpOT3JrbkQ2S2doRWJHeWdGUFIwaGQ4bEdhLzNYTUkrSUhZdThlUEg1?=
 =?utf-8?B?N1pKL0NhZFhrejNoT2xHeXJVaS83T2lhN2h4YmJMelRVVnpLWjJHVkhFQ0Y2?=
 =?utf-8?B?Sk9iUkRIUE5VRE9lZW0zaTUzZWhoNkdRdStjU3RIRlBwcldHTkswNHB2VzZu?=
 =?utf-8?B?TkNmajk5NTUxRnFMNVRYQkNwSEQ5NnlxZE1YRk92eDBkcTFJRkNHMXQrL0Z1?=
 =?utf-8?B?MmZEazhrSjB2QVJtcHZHVTNzVk5WaHBrSzIwRDhKdGRyVU9rYmVHdi9FNk9z?=
 =?utf-8?B?N0JyeXQvZVNjUWVpZ3NZTzFyM2NwL2dxcFJRVUhqeGF3N0tIQW5sdkFtK0lq?=
 =?utf-8?B?NWJuWFlXTDJBNXhSWVVWcHhJQ3ppWHR1bmVWYmh6WFRZQjlSRGxaWjdlWnVY?=
 =?utf-8?B?OGtsMTNGQ3UrSldZeEUwd09DUFd5QTZEelhSa1FJb1RLREZISnM3UDl2enA2?=
 =?utf-8?B?SFVyR1lSR0diVDByL3ZhNVg5a2JmLzJzN1huOVl6SUdqQlplL0EvVXZoODNO?=
 =?utf-8?B?T29XZS9JSytrMnRVbDNUeiswVHFnZUdmS1NvMHdpM1pnRzk0YVN3TW41WTU5?=
 =?utf-8?B?V3ZUM1FrbnVTcmRaTlF5NjJKdWpGU1J0SDlFT29JazAvK3hjNVVaZDcvdmFC?=
 =?utf-8?B?NnJqOHBBMmtMMjZxQXZ0M3o4ZUFPN3VxNmY4ckZDaHRlM3JnSkF5UE91amRH?=
 =?utf-8?B?c2YzNStYbUVaUk5udlZTcG9XYnVnMXlOY0p1aDl3M2dKdHdNNFRhcENabFdl?=
 =?utf-8?B?QUZaYnpMSzkrQkEwRFFkRVhVcVNWMk44R0xSd1ptYU9UK2hkV0wvb0drWWxr?=
 =?utf-8?B?aDlqOC9xMlhZRzZ2eVpSYStsV3pkZFRveVZsQzlTV1d0czJzcHNNbmd6M2J3?=
 =?utf-8?B?b08zcHhMdHljRnZZRGk0K2ZqOXJoVUdKdkpRd3RXbGwyYmxYZ1ZvQzFKTEdk?=
 =?utf-8?B?SE10RHNKOTkzdTBCTEhrNkxWVzZPTWdMR3JEVmxFdHI4bm1jdEdhL0VScXFM?=
 =?utf-8?B?cE04NXhnaVNEd3lnQzlxNTZiVUhFbkpGU3pYSzE2MjJXUUExcHpvZVRjNFVw?=
 =?utf-8?B?d25zcnBGQnpYUjdSbHNLcVlIU1dLQ1V3VnljVXpoRkJCak9idEdGd0xoMWVB?=
 =?utf-8?B?bHphOW1UeHNKekN0Sk9kaXQzUVVBME1KaE1qbDh0bmQ1V1U4RnN2clpmWXF2?=
 =?utf-8?B?NjBIRFBDcHNGbTdWcUpySGpRZFZvRmYzNmpReTROamllMFBEeDNZMUlWTVFO?=
 =?utf-8?B?ZUxZb2RrSjFNUzZoQjArblhkcjZOMWhBKzluTG9rVEpVVHpDL3BYbHRCVTh6?=
 =?utf-8?B?ZVpEbUg2KzZLUDd1M0hsVjBGaEUya0pBYXBta3JFcktYNWVqMEdRN01QM1lY?=
 =?utf-8?B?cloxMEN1YS9kVlJFRlg4L21MZGFXbmxNUExVUTA3RVMybzU4aS8veGdGZXpR?=
 =?utf-8?B?RUhPTDFDRG1yUDAxTVE4ZUIrTHNnVGNXNzFGNDliRnA4OTE3M3MrMlg3Q0t3?=
 =?utf-8?B?MXdSNDlJZ2xGcUlFMnpJV3BvcjNYa1JaTHJkSTdpRjJqRXVTMjhSd003OTE3?=
 =?utf-8?B?WlpaR0lCYnZxT21BOEdCT2RZdGlKb2NZK3R2TWtRaVRWcHEwZmlIdWVSVVJS?=
 =?utf-8?B?RVlpNnUvQVlvY3kzR0daaUI0UFJCaFpxdmdKL0pUWjE0bkduL3ZkeTh4Z3Ji?=
 =?utf-8?Q?3vjQXIVnavdZ2dJuFqyfCEN6p7yz2Q=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SVRid2Q3a3ZaRGJrZWM2eHJIRzVub1IwU2ZxVHE1VERXVFVCaTdwYlJDR1pZ?=
 =?utf-8?B?bUpTc1pxUnhlNGplRXVsUUN4OXdObHhGL2YrUS9HeTZDVHhBUFllNWtRMmVC?=
 =?utf-8?B?WGtTcWFrbzNnMUhBd3l4Y3pkSnpackUrRkRlUXFqZWwySFBtZnF6aTZZN1J6?=
 =?utf-8?B?S3FQWW1IYTNHampKQ1NWRk5oRkQ2SmIwSUFUYW9ibVVKK05SckI3TWcxWkFN?=
 =?utf-8?B?NEtLWXFGbDJzbDNiQ3YrWXkwWktoNGo3bWQ0R0gvWHpQQ3FOR3NUNi9heVN6?=
 =?utf-8?B?QWhTMktrQU5kRDN2dGl4UnZ6TXZYU3ptMUZDeFRxZVdmdUhyWExkSXFiNDlZ?=
 =?utf-8?B?ZEFZTWQ0MFY3eUxjYk42OVpPZEJNSklBeVkrQUhkSkg0ZDN2ZkdmN0xnL0cy?=
 =?utf-8?B?d0l0NWFkT0ZFckNOUXE3bkVhRmlZSmhUMXp1SjVLODQrL3VQRiswbUI1djlo?=
 =?utf-8?B?NlRuOUt2Z1ZZNmN1NWF5ZnFCNGVTaUxMSllHcXc4aUxOa1VZV1crVFpabXRs?=
 =?utf-8?B?ODdhaWFpM0ZJVjJ3YjNiemZpUTh4ZU5JYkJGc082U3owVVlkakFHQkxUWFVF?=
 =?utf-8?B?WDdmQm40L05DSjVza1I0cDVjY3hYY1FxS1JKTFZPVitGOEhtZHRVREFqOXds?=
 =?utf-8?B?bEhqc3hsU3ZUakpUS3hudEpjclg0NVFJQTJBQitLNFpGR2NPelB6M256R2JS?=
 =?utf-8?B?enZFM1RMZS84RER3VDQxUE1hZDlMdFlldDJGWHpyL0JtY3IvR1BYM0FaWC9H?=
 =?utf-8?B?bHVnUW04V2U1NVdQS09DSTUydk5pc0NoTjd1K242dFp0N1FHV1pFSnArT1Vy?=
 =?utf-8?B?TzUvMnlkdzF6M1hxWmtKN3N3QTVRTEJscGJKbGlkMGl2eENXYXhSSXZyR1FJ?=
 =?utf-8?B?WGlUaFJqTENJUHBGeUk2WlI4eXBNZjc3WFhrUVV0MWlzUWk3cjh3QmhvUWRo?=
 =?utf-8?B?M0pzUjEzVU9Sbmw5NmJVSTZyWi9NcHd5TXhsNnRqTHU3L0hpWCtpUTlTbTYv?=
 =?utf-8?B?SXhRcXJqbzlRK1ZxTEZITGloM2FWQ292NmRoOThHU2tPekpTL3p4QTFDVnhl?=
 =?utf-8?B?SkhUb3J2N0tmNTl4anh4L0xyblkvSVJYWndYM2pZZ2ZTL3pNcGxsNlRmQmZY?=
 =?utf-8?B?Z3BBaWRjMkNPcGJjbHhHWkRkV2YwbTlsRGpwdzBlZUs2VEZHSG5Tc1hzS0Rk?=
 =?utf-8?B?Zlc0blQ1RWE1MHk3V1JVQW43UDFsdGtmY3pkNDhNMURNMUpFNlRMaTZ2SGlq?=
 =?utf-8?B?MWFCU3E0cHEvUzk3MWdTbWJWTjFRb1BwY0ZJL3lLOU9hVlh6RkZmTGZmZmc0?=
 =?utf-8?B?aC9lNytRRzR4U3FGeWE2WlZoRDI2RWhjOFc5Y3Bxc2pXYU40OVEyZHBSVnRx?=
 =?utf-8?B?ckFNSGVnVDd0eWQ0QmFEelk4dmMwQzhxajJRRXA1V08wd1pzalB2OXpkcTF2?=
 =?utf-8?B?N2ovMUFRaXRUUUZ4d09qUmh2dkFDNXhMMXl1TktLZXlaL2pLVytQTkduVTRk?=
 =?utf-8?B?KzRnY1ozVUovbCtOZ0hpQkdLU2t3bXpjN0FCaWJEOUJzcWdyMVB1ZGZSZHB0?=
 =?utf-8?B?a1R2OHdpcHRFbHhCd3QxYUdNam9jZ3Mra0ZOVWVjenR2RmdrU1pyWXhWK1gv?=
 =?utf-8?B?WGYyaWlwZy9EbWpWbjdGQ0Fxc285ZlllbVBZVlJQU0lhU1V4LzlJbVhYZXRE?=
 =?utf-8?B?RUxxT2ducmkzT1pJQTlhUU5WREZHY1BnNUc3a0lZa3E3djJsZWNlcXc5OFQ3?=
 =?utf-8?B?c0ZaZ2FXT3FFYzdRd0REUkcvRXBOOThKWW5XOUFWZHNWbUdLQ2xQbTBQeDFF?=
 =?utf-8?B?dEtyUzBjZUdldU0rTWN1Yk1VZTgrSkhmUGFtK1JlaSttZ0h6NkJYRUkwT2lV?=
 =?utf-8?B?K2I1WEZkS0xUSHJHZEdjYytoTzlYTUh3dnpQYzI0dmk0WFpIYzdkUUdPWm1a?=
 =?utf-8?B?UnlFcEIwVEp5MWoxbHRoSExHVURSSFJRdWw3Y1dNQnpUZ1U0bm9FWDdNeFhj?=
 =?utf-8?B?RUl6em00TnNZcG5uWDRCWUtNQlBIVFlsSisvRjN1S3JDMGZTZE1SeWtlRi9R?=
 =?utf-8?B?N3d5NHJ6bE1qdVo2MUxSM2VKOUJoRXdNNSt2WXFSWHN0TjBtVzNCQW9HNjZN?=
 =?utf-8?Q?d/Xw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 08b64f08-0d7f-4733-93ed-08dde185fd47
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2025 14:12:55.2519
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: usunFV1Bu48E/r5uf8eZPmKmB9XWQhALHkrmvhYZJ8lfR4ENTrwgSyhTgJyGM1gM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5866

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCb3Jpc2xhdiBQZXRrb3Yg
PGJwQGFsaWVuOC5kZT4NCj4gU2VudDogRnJpZGF5LCBBdWd1c3QgMjIsIDIwMjUgNjo0OSBBTQ0K
PiBUbzogS2FwbGFuLCBEYXZpZCA8RGF2aWQuS2FwbGFuQGFtZC5jb20+DQo+IENjOiBUaG9tYXMg
R2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT47IFBldGVyIFppamxzdHJhIDxwZXRlcnpAaW5m
cmFkZWFkLm9yZz47DQo+IEpvc2ggUG9pbWJvZXVmIDxqcG9pbWJvZUBrZXJuZWwub3JnPjsgUGF3
YW4gR3VwdGENCj4gPHBhd2FuLmt1bWFyLmd1cHRhQGxpbnV4LmludGVsLmNvbT47IEluZ28gTW9s
bmFyIDxtaW5nb0ByZWRoYXQuY29tPjsgRGF2ZQ0KPiBIYW5zZW4gPGRhdmUuaGFuc2VuQGxpbnV4
LmludGVsLmNvbT47IHg4NkBrZXJuZWwub3JnOyBIIC4gUGV0ZXIgQW52aW4NCj4gPGhwYUB6eXRv
ci5jb20+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggdjIgMi81XSB4ODYvYnVnczogVXNlIGVhcmx5X3BhcmFtIGZvciBzcGVjdHJlX3YyDQo+DQo+
IENhdXRpb246IFRoaXMgbWVzc2FnZSBvcmlnaW5hdGVkIGZyb20gYW4gRXh0ZXJuYWwgU291cmNl
LiBVc2UgcHJvcGVyIGNhdXRpb24NCj4gd2hlbiBvcGVuaW5nIGF0dGFjaG1lbnRzLCBjbGlja2lu
ZyBsaW5rcywgb3IgcmVzcG9uZGluZy4NCj4NCj4NCj4gT24gVHVlLCBBdWcgMTksIDIwMjUgYXQg
MDI6MjE6NTdQTSAtMDUwMCwgRGF2aWQgS2FwbGFuIHdyb3RlOg0KPiA+ICtzdGF0aWMgdm9pZCBf
X2luaXQgc3BlY3RyZV92Ml9jaGVja19jbWQodm9pZCkNCj4NCj4gV2h5IHRoZSBzZXBhcmF0ZSBm
dW5jdGlvbj8NCj4NCj4gVGhpcyBjYW4gc2ltcGx5IGdvIGluIHNwZWN0cmVfdjJfc2VsZWN0X21p
dGlnYXRpb24oKSBiZWZvcmUgdGhlIHN3aXRjaC1jYXNlDQo+IGxpa2Ugd2l0aCBhbGwgdGhlIG90
aGVycyAqX3NlbGVjdF9taXRpZ2F0aW9uKCkgZnVuY3Rpb25zLi4uDQoNCkl0IGNvdWxkLCBidXQg
SSBmZWx0IHRoaXMgd2FzIGEgd2F5IHRvIGxvZ2ljYWxseSBzZXBhcmF0ZSB0aGUgY29kZSB2cyBo
YXZpbmcgb25lIGdpYW50IGZ1bmN0aW9uLiAgQWxsIHRoZSBjb2RlIGluIHNwZWN0cmVfdjJfY2hl
Y2tfY21kKCkgZG9lcyBvbmUgdGhpbmc6IHZlcmlmaWVzIGlmIHRoZSBjaG9zZW4gY29tbWFuZCBp
cyBwb3NzaWJsZSBvbiB0aGlzIHN5c3RlbS4gIFRoZSByZXN0IG9mIHNwZWN0cmVfdjJfc2VsZWN0
X21pdGlnYXRpb24oKSB0aGVuIHVzZXMgdGhlIGNtZCB0byBhY3R1YWxseSBwaWNrIGEgbWl0aWdh
dGlvbi4NCg0KU2luY2UgdGhlc2Ugd2VyZSB0d28gZGlzdGluY3QgZmxvd3MsIEkgdGhvdWdodCBo
YXZpbmcgYSBzZXBhcmF0ZSBmdW5jdGlvbiBtYWRlIHNlbnNlIHRvIG1ha2UgdGhlIGNvZGUgbW9y
ZSByZWFkYWJsZS4gIEJ1dCB0aGF0IHdhcyBqdXN0IG15IG9waW5pb24sIEkgd29uJ3Qgb2JqZWN0
IGlmIHlvdSB3YW50IHRvIGlubGluZSBpdC4NCg0KLS1EYXZpZCBLYXBsYW4NCg==

