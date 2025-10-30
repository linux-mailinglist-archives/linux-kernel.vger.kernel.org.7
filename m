Return-Path: <linux-kernel+bounces-878784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 412A4C21714
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6733D34C1FA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DC3340D84;
	Thu, 30 Oct 2025 17:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bwdsQ9Y2"
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012059.outbound.protection.outlook.com [40.107.209.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79326264F96;
	Thu, 30 Oct 2025 17:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761844751; cv=fail; b=kvbiKRrl/xbL9VQfkNugyRHOV+foiRqvOa22MrpkaKVFWqJkNHmuNehYyWp10LrLTZJKB1mFKNgDRpMCVkglAX2iss79RL1O6JhNvGEu45v/cuNv7TyEMa3KunvhREFLtlN+WqpMNoIgO4jcN7e0H2Q+K/v4SyScPFbrp3ZY4ok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761844751; c=relaxed/simple;
	bh=Ot63ZQpy4XtcM3vzTIvE0KHGd7B+pmvE7KLul8FPXJc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DQE19syNk2efUs8KTh/gY8ra4Wb206kftOao+8t3hBxsxoz1nt3ahwmxb7NlMehCS+rMCI61q8UG8y8v9RB7S32BkX/CulhFn80Xw9r8y+Hk4CqV7f2m2iQm44U7FuAwwJjmWTn35D077RFZYjzaSZj+S41O/YoAgM+NPX5cmxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bwdsQ9Y2; arc=fail smtp.client-ip=40.107.209.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dMLwHOXFiHISFc4rMnKovpx+yQjD0OY11gNe76A6p3F0bqZfw6eGq4+NlB84xlH6CX3w0VrmtLs8X2R5Mv41eqYkgasMKEHRtj/UqXbwPnsqBS2exYI3c/+T4Q6zvz2OalqTfLc7Bx4e3WopxHaB5GwdHWtzhE7ESa63A0u5dqzapwoGT308WfHSR+2Wi3z97EfKbpmyYb7puE4G2oi7rxS5OqEJFOu0Jj3uq1aHXbczTZnU6Kc//RUwcDjiEWlkdSyWvVCqHskhLsiLsRf9eX1CtmO7GiO/41CLsTRWlLfbK0QDJ91Q+9UHQ1KNtI4qhgB0S3cMsoN+OnsU/F2MSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ot63ZQpy4XtcM3vzTIvE0KHGd7B+pmvE7KLul8FPXJc=;
 b=pX7YsG/DPwhjxhmg1nCxXKIAcYGHR1+p8TAHKkbt3+WlXofRBQj4dPo0i93BG2YGiw8VlhnQXVmZ+SAu6afXgeu5rj+iGXuxUZKTcIAmn42bFj2a/p8CvDTZlTwOrbOMp1OQ9GnNeU6E5jPBAlYDEr8rggv+YaHlZFEYF5DncupTAsFmN7nGYF5wy0LAUiES7QZuQ+JzEh6Om58uPxXvtLz/59TyzXJCFHnPSnx053yLGCzXj31+0tcD/Hjlfomao0khRofHvtwWzoyM2ekxUUVzr0rxpWcuW656GCTnVjNN6F0ni0dUkjiJnCDka08tZ9y6UzWBARZl2jxdLgbttw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ot63ZQpy4XtcM3vzTIvE0KHGd7B+pmvE7KLul8FPXJc=;
 b=bwdsQ9Y2DR7+Xhs5XyjnIZNqM5+42ni45w+fPd1rNnTNCdhvGsu/sNUl2Ix7Uxo7kFL53jWOLk4ApAfg11AHeRd7Io0tde8MlQcsdxkpwkqP+SmdKieZjmfcW7KjTWRlxBn/E9cdHWxThSDOcJSY/fjHl7XBOhk7xRT1SeUMYtmnf7/l3wkxdOWICC5RfaVKSKX5J7bYNZow33ErafWG9jE9YKSkRcKXSowye0gxBsijXGxNgTePgoecG+vOqefemHmIHKHkcIWznXO1VRjVBOe30D2aWugY8I7TCeTnGKiLpJdS+DdOUz1wtQ6a3ThCUVZTpkL/twYDDN0YMr1MbQ==
Received: from SA1PR12MB6870.namprd12.prod.outlook.com (2603:10b6:806:25e::22)
 by DM6PR12MB4434.namprd12.prod.outlook.com (2603:10b6:5:2ad::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 17:19:02 +0000
Received: from SA1PR12MB6870.namprd12.prod.outlook.com
 ([fe80::8e11:7d4b:f9ae:911a]) by SA1PR12MB6870.namprd12.prod.outlook.com
 ([fe80::8e11:7d4b:f9ae:911a%3]) with mapi id 15.20.9275.011; Thu, 30 Oct 2025
 17:19:02 +0000
From: Zhi Wang <zhiw@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
	"dakr@kernel.org" <dakr@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"ojeda@kernel.org" <ojeda@kernel.org>, "alex.gaynor@gmail.com"
	<alex.gaynor@gmail.com>, "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
	"gary@garyguo.net" <gary@garyguo.net>, "bjorn3_gh@protonmail.com"
	<bjorn3_gh@protonmail.com>, "lossin@kernel.org" <lossin@kernel.org>,
	"a.hindborg@kernel.org" <a.hindborg@kernel.org>, "aliceryhl@google.com"
	<aliceryhl@google.com>, "tmgross@umich.edu" <tmgross@umich.edu>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Neo Jia
	<cjia@nvidia.com>, Surath Mitra <smitra@nvidia.com>, Ankit Agrawal
	<ankita@nvidia.com>, Aniket Agashe <aniketa@nvidia.com>, Kirti Wankhede
	<kwankhede@nvidia.com>, "Tarun Gupta (SW-GPU)" <targupta@nvidia.com>,
	"zhiwang@kernel.org" <zhiwang@kernel.org>, Alex Williamson
	<alwilliamson@nvidia.com>, Alexandre Courbot <acourbot@nvidia.com>, Joel
 Fernandes <joelagnelf@nvidia.com>, John Hubbard <jhubbard@nvidia.com>
Subject: Re: [RFC 1/2] rust: introduce abstractions for fwctl
Thread-Topic: [RFC 1/2] rust: introduce abstractions for fwctl
Thread-Index: AQHcSbbMCuQB8XLnS02OgKHCLJtvKLTa3z2AgAAP5oA=
Date: Thu, 30 Oct 2025 17:19:02 +0000
Message-ID: <4e0be534-e3d7-4c74-b8f1-51bd869b18e4@nvidia.com>
References: <20251030160315.451841-1-zhiw@nvidia.com>
 <20251030160315.451841-2-zhiw@nvidia.com>
 <20251030162207.GS1018328@nvidia.com>
In-Reply-To: <20251030162207.GS1018328@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB6870:EE_|DM6PR12MB4434:EE_
x-ms-office365-filtering-correlation-id: 439238d5-6c03-447b-b1bb-08de17d86bd3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Q2xlN0dBNlRqSTZEWVV6bWhDeG5oOEtIQVVpSlUrRzN6Lzdyd1ljaFQ0R3Rn?=
 =?utf-8?B?TUljRFhSM1NFS3ROZ3ZtSWVuWkJCdWJUV3FxT0E3eTlRMSsrVEEvNEs2emcw?=
 =?utf-8?B?UkxkZ1Z2TksyNmR3SFlua0tsWlMvVUNSTmdtdStUU2pTQXRGQ2RxL3NuOG11?=
 =?utf-8?B?SU5Takt1aFgyS1lzRHJSeHdLak5HZkR6KzJla052L3U3OXdPOFBmeUF4RHlt?=
 =?utf-8?B?NVFFRk10R256RHZhVmdlZEF1ZzdYWDZpQXdLekk3aWhHMDMyeU52R3NZZGVl?=
 =?utf-8?B?VUwxQU9xQUdzNzVYWElsTGdWNi9WMytQdlNYTlJFeW5lZzZ5K1BsZXlBSkdZ?=
 =?utf-8?B?bFRIcWFSclNYVkpEaE1HVDUvcFQveHN6Ny9ZWmduWXpsWmF5bVlYWW5FYkNU?=
 =?utf-8?B?bmhSWTRmNnpJSjF5U0hweVNCVDVOaWpoTytxRGp2VDV5WlNWbVM5V1E2QmJJ?=
 =?utf-8?B?UWZta3ZQYm4zRmFHRUJiKzRVMjBxNFpVb1A1b1h3bHVXbUxRSzZ4WDh2U3Z3?=
 =?utf-8?B?ZGMvc2lKN25OK0NIVkdOeUR5bGxuWmQ2eldXbGN5WHlHak1VN0U5Zys1QTZr?=
 =?utf-8?B?QzRNUUMwM2FHUG1CL25NMmd1SnF3by9SVWFHTlFxV3pwVHpwR1pGNG5PNFl4?=
 =?utf-8?B?cFUvc0RlN0JBcWdXNERlMmY3ZkZXTWRLYmJwTmJEcWxPV1Y3aGdyb1RTektk?=
 =?utf-8?B?YzFMSlFOKzhTZjFGWGpKMm5lWEhPNDFwM2dNbVZMWmFkQ1pYRVRncnZNbUR6?=
 =?utf-8?B?R096YXYrTWV3TFVCSS84R29aSmROYzhYRURVbHh3UTJTQUlxN2NpQjBkdnZX?=
 =?utf-8?B?THNEVHljL1FqaUJkWWNZTHY3RkZWNkFkOGdqbDZUMElqQkw5THFHcDZWeVJH?=
 =?utf-8?B?ZEpwdHB3SFhudUplTStacmZna29FOWNBU1JxVXNBcDF2QWM2TlcwYnBRZGg0?=
 =?utf-8?B?YWx2enhXZnZzdGpVbVZFcW5RazBNNllVNi9NVC90eVVyT0ZWd0tTSnR4KzAv?=
 =?utf-8?B?WERjMU5VMnR1b1h4VFg0eG1mVUVqdWlsTWdETEN4ZThGNWVYRmFXT21GdTY2?=
 =?utf-8?B?SjR6WE9kWmkwMWVUNlZ2RUI4VDhmRjFPREJ1TzJKTlhYbEJsMnpMRkVTN0x3?=
 =?utf-8?B?NHZGOEhiRnFLbytqYkpqYjFkaHhYNGZtM0t0RFp2alNmZlovL1pYNjA4bVlS?=
 =?utf-8?B?eUNKaktaN0FYa0c5NnNpMVhpQjBUdFRpTm96anp6WlpqaUVySVNzNktjR1hK?=
 =?utf-8?B?dlAyVitPMEJ3K2tKWjNHdlg5c28rS2RVSEJiVXFKT0VkYkhWV3k3cUxaeFll?=
 =?utf-8?B?azlMR01xMW1aSC81eXF6VmIzZ3BDYzRUVWxnVnZ2Z0krbktwZXNRM0dGY3Jp?=
 =?utf-8?B?RFYzSE9wTGdXRlIzQ2IwNFk5WEN0cHc1T1Rtbit6YmpzOSt3UWF4NURqeTRW?=
 =?utf-8?B?QnpBUjRtT3QwQ01DVSs2V09tbWxueXZIc1Y0citZbENrdmczWHBuSldpdzB5?=
 =?utf-8?B?a3dSaTQ1eittTVlyRVltQWY4T1R1bWk1WWlDL1pDWnNXOGNWZ2UxY0twaFVi?=
 =?utf-8?B?V3NHcU11QUNwVjB6THQ2QU4yVHV4Ym1rbzY5eHVKS1FWc2NZUHpKODBxNnNT?=
 =?utf-8?B?Q1RtUlpnMm5EQlNQTU9reW5wcmlneUNFZXFPVUswaWNoZWQ4OGpQS3hJSU1m?=
 =?utf-8?B?Z1JKM3JGeXY5TXJ6R29XU0U1clB3YjJwdkZJbDFxaVBXd01oNlF6Si9GMVZ5?=
 =?utf-8?B?Y1VQZExES2IyckswOU5JSTdyN083ZU14QzlyZVpsMDgvMEhLbHYvZktQMUJn?=
 =?utf-8?B?eTVCcXVTd3pkeDNTbllzTFVBR2xJZTJrM09QUFoxWUNZZGZjY2haUmkzcUFj?=
 =?utf-8?B?bS82WkVTMWs5ZnpXYjdFNE9CbzRUVmlzenZUNHpldm0wSjRQeG5tcXhSZk11?=
 =?utf-8?B?V3U2QllRdklOY2JVYVBKK2R0QWtzajN6ZGNKbVd3YmxwaEJ5WEo3MGMrSlpY?=
 =?utf-8?B?MkcxZVQrMzZicVl2ZDdpeHJqdzgxdUJBZmlkUTErb0RwRzNQMGc4N1hTbEFh?=
 =?utf-8?Q?gRacPC?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB6870.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bGVUangwbFppWEhGYzFKS1QwQ05IM3duQ1RuQ3I3a2p3UThqUmRlQ0pSTXBS?=
 =?utf-8?B?WnVibDBpcDN4dC9KS1BLTlFmclZtMHhZTzA1VmFMbkhrSzJSZjFkTTVKaXJO?=
 =?utf-8?B?NnRWajZkSzJXS3A4cVBteVJrRXN2ZWV1K01QZWIwVlFDQnV6ZGVROXMzbUdx?=
 =?utf-8?B?NmZnRFlLWCtzemlDbDZCczNzaElhZ3dBdXZjSEhEaGFlcEZHSnZqOFhXanpT?=
 =?utf-8?B?czdzZllzZW0wM0h0dUprNHBzWUY3WGl5SGJBbDB3OHJQbXVqdVI1b1NaYkVG?=
 =?utf-8?B?UmlxNi91S21RTFVueHZwL3hzQWthVU43bTJMUDhYdXFsVGYxbUpKSXVnYUpZ?=
 =?utf-8?B?L1BWY0VkNWI0NVNKNDRSSCtIM2FFeUhGeTdRa1BlRmxlQTNJYTBkNE1OMDNZ?=
 =?utf-8?B?RmlBRVRTcUNGZ0J5Vlo0elNWZGZsZ2lDbUFGQVk4eVV3bEVwNWZxVlZZN2hD?=
 =?utf-8?B?KzhoZW1xVVZHTVcyMFgvZVYwMDlseUJab2h5UERHRDVaWXFOR0YwSnJUcmta?=
 =?utf-8?B?d3RXbGVzdHJMTlF0a2NLYkV6K1daem5JWkJwckk1VVFQdlYzaVpiTHRja1Vv?=
 =?utf-8?B?aU5hNHNhQTl0M1FMOFBFYUxSeHlQUWdsQlZjN0lwaXNNU3pyZ3lLS2ZsYmc3?=
 =?utf-8?B?TFNWT2R0c2NsN0x5a0NnWGdvaHpUQ3cyVG1aaTgvaUx0ZG5BclFiMHlScVVs?=
 =?utf-8?B?YnZzcU80TWl6MWpqNlRxdmUwajB6djE1eFBLVkdSVS9pNFRTWDh4K3UwcUNH?=
 =?utf-8?B?KzBGUEw1bXFtVWhoMVJ6a2F1ZEhpZm1lcEprSTZ5SGFqekY3WkxRbHdLSkUv?=
 =?utf-8?B?YUJkdEEySjBZVTVteU9WTkVEWWVxbzJKQ3JpSUdaRU5zc3Q1YnVXT3NwWUpO?=
 =?utf-8?B?M1RicjdTUXJwaHZZUGZvYXMrUVhleDhKRWdYSVU2c1NKbmJMc3pkVVpJWTlN?=
 =?utf-8?B?dUVMS1BubDZUSjdXRnRKRVdjS09URUIyUG5vK3JsdVQ2ZTFsMWJEK1lBL3FB?=
 =?utf-8?B?eUZ3VVZ3RUNWM0Q2RUxNekFKcWJjZnIwLzNZZ0hmSkg2TmhiejZzV0pyaXd1?=
 =?utf-8?B?S1FwRUJ0MzFuVkkwUnRjWFkxMk9Gd1pEeFhRUThFVndOTm1GdkJjMnhvbHRO?=
 =?utf-8?B?K0xIYnl0eU8zZ2U5bHNnc1d0bHRMUjNaMjI3M3V3M0lMWlI5V1FjZTFodHAr?=
 =?utf-8?B?M2FTK0hOaWgxOWN5Y0hHczcrSWhsTWNHTmRBRkw0K2JaTk94NEtHY3BNbkVw?=
 =?utf-8?B?d21BMjFCSC9XTW1mdkUyQ2c4dnhRN0M0R1BESXNoNVU4a3Y2WXROdkw2UE55?=
 =?utf-8?B?eW9LQUNhb1ZPT1BTWndjZXIrVnY3TlhGdkt3SVpNdHEvWXI3V3ZrQ2JQNkRO?=
 =?utf-8?B?dWJYTlQrUUtBS1RzWnArSHYwLzRCUHFqM0NLRkYxTCtkZ2tvMDk1eXdwVVlr?=
 =?utf-8?B?UXNsYkcvajR0NWVmVDUwcEkzOXN3WndMY1VrQnpkdENkd0ZJSVBoK2VtYXhj?=
 =?utf-8?B?QWNTLy92SFlISWdIYXhBTmM0RmFSRHN3UDUra000dkJTSEUzRnQwdzBPQStT?=
 =?utf-8?B?djZlcGMyUWhSazFIbXF1R3dsd3dHbGlUWXRTRDEzNDR4ejFxczZkMUtHU212?=
 =?utf-8?B?eU9FU2kzT2M2Y3VSMGtMTS82YXlRV1h6ZVRaYmpjeE14eDVzN0N6RHV2dDdY?=
 =?utf-8?B?c1Vucnp0K3E5U3YzUmlneHd2UExUZlVqdXVPMGJFRWI4TTRnWkkrTDFUZjFo?=
 =?utf-8?B?NGRSNWJiVkpPd0JKck1kZjNuaENJTWRWU1pvNnpURktxQ2VVQXk2TkhMaVRt?=
 =?utf-8?B?alc0aGxxSjZYeUJ2RnM2VzhNak9GNC82VDNMSTQrS3RzQzJrbUFrK0tWbHBG?=
 =?utf-8?B?Vnh3VXpxZnViQ0xBMU5aVmNRcS9jcGNGNVc3TTRrVC9FcDVDajA4cjhFWTAx?=
 =?utf-8?B?cWVYT01NNzJ2TTB0cUVCWGNMdjZtbkwvMVY1SjdTdlNCeG1HbFdRSEpaRFBM?=
 =?utf-8?B?UHZWZ3BTZnJZRnVhdmkxbEVZOWhYa0Z1SnNBMUlGbXpweHVjZm41dnJGSlpG?=
 =?utf-8?B?Y05mZVYwSmFiVXpHcjRmVFV5QmVBZ2p1MUV3ZysxWnJuNUh0UHgzdE9uYXZy?=
 =?utf-8?Q?wcBc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <69A314742B234947AD03CCDA98D32BA0@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB6870.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 439238d5-6c03-447b-b1bb-08de17d86bd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2025 17:19:02.2179
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: utH2El1PpYjqrC3hdhvyVsVEy4tOYwgnKBFw2ZFTqii38BshEDxDcWp2mx0vV89A
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4434

T24gMzAuMTAuMjAyNSAxOC4yMiwgSmFzb24gR3VudGhvcnBlIHdyb3RlOg0KPiBPbiBUaHUsIE9j
dCAzMCwgMjAyNSBhdCAwNDowMzoxMlBNICswMDAwLCBaaGkgV2FuZyB3cm90ZToNCj4+ICtpbXBs
PFQ6IEZ3Q3RsT3BzPiBSZWdpc3RyYXRpb248VD4gew0KPj4gKyAgICAvLy8gQWxsb2NhdGUgYW5k
IHJlZ2lzdGVyIGEgbmV3IGZ3Y3RsIGRldmljZSB1bmRlciB0aGUgZ2l2ZW4gcGFyZW50IGRldmlj
ZS4NCj4+ICsgICAgcHViIGZuIG5ldyhwYXJlbnQ6ICZkZXZpY2U6OkRldmljZSkgLT4gUmVzdWx0
PFNlbGY+IHsNCj4+ICsgICAgICAgIGxldCBvcHMgPSAmRndDdGxWVGFibGU6OjxUPjo6VlRBQkxF
IGFzICpjb25zdCBfIGFzICptdXQgXzsNCj4+ICsNCj4+ICsgICAgICAgIC8vIFNBRkVUWTogYF9m
d2N0bF9hbGxvY19kZXZpY2UoKWAgYWxsb2NhdGVzIGEgbmV3IGBmd2N0bF9kZXZpY2VgDQo+PiAr
ICAgICAgICAvLyBhbmQgaW5pdGlhbGl6ZXMgaXRzIGVtYmVkZGVkIGBzdHJ1Y3QgZGV2aWNlYC4N
Cj4+ICsgICAgICAgIGxldCBkZXYgPSB1bnNhZmUgew0KPj4gKyAgICAgICAgICAgIGJpbmRpbmdz
OjpfZndjdGxfYWxsb2NfZGV2aWNlKA0KPj4gKyAgICAgICAgICAgICAgICBwYXJlbnQuYXNfcmF3
KCksDQo+PiArICAgICAgICAgICAgICAgIG9wcywNCj4+ICsgICAgICAgICAgICAgICAgY29yZTo6
bWVtOjpzaXplX29mOjo8YmluZGluZ3M6OmZ3Y3RsX2RldmljZT4oKSwNCj4+ICsgICAgICAgICAg
ICApDQo+PiArICAgICAgICB9Ow0KPj4gKw0KPj4gKyAgICAgICAgbGV0IGRldiA9IE5vbk51bGw6
Om5ldyhkZXYpLm9rX29yKEVOT01FTSk/Ow0KPj4gKw0KPj4gKyAgICAgICAgLy8gU0FGRVRZOiBg
ZndjdGxfcmVnaXN0ZXIoKWAgZXhwZWN0cyBhIHZhbGlkIGRldmljZSBmcm9tIGBfZndjdGxfYWxs
b2NfZGV2aWNlKClgLg0KPj4gKyAgICAgICAgbGV0IHJldCA9IHVuc2FmZSB7IGJpbmRpbmdzOjpm
d2N0bF9yZWdpc3RlcihkZXYuYXNfcHRyKCkpIH07DQo+IA0KPiBUaGlzIGlzIGEgQm91bmQgZGV2
aWNlLCBub3QganVzdCBhbnkgZGV2aWNlLg0KPiANCg0KV2lsbCBkbyB0aGlzIGluIHRoZSBuZXh0
IHJlLXNwaW4uIEl0IG5lZWRzIGV4dHJhIGFic3RyYWN0aW9uIGFyb3VuZCBmd2N0bF9kZXZpY2Uu
DQoNCj4+ICsgICAgICAgIGlmIHJldCAhPSAwIHsNCj4+ICsgICAgICAgICAgICAvLyBTQUZFVFk6
IElmIHJlZ2lzdHJhdGlvbiBmYWlscywgcmVsZWFzZSB0aGUgYWxsb2NhdGVkIGZ3Y3RsX2Rldmlj
ZSgpLg0KPj4gKyAgICAgICAgICAgIHVuc2FmZSB7DQo+PiArICAgICAgICAgICAgICAgIGJpbmRp
bmdzOjpwdXRfZGV2aWNlKGNvcmU6OnB0cjo6YWRkcl9vZl9tdXQhKCgqZGV2LmFzX3B0cigpKS5k
ZXYpKTsNCj4gDQo+ID8/IERvbid0IG9wZW4gY29kZSBmd2N0bF9wdXQoKSAtIGl0IHNob3VsZCBi
ZSBjYWxsZWQgZGlyZWN0bHk/DQoNCmZ3Y3RsX3B1dCgpIGlzIGEgaW5saW5lIGZ1bmN0aW9uIGFu
ZCBpdCBzZWVtIG9wZW5lZCBieSB0aGUgY29tcGlsZXIgd2hlbiBiaW5kaW5ncyBhcmUNCmdlbmVy
YXRlZC4gDQoNCiQgZ3JlcCAtUiBmd2N0bF9wdXQgKg0KJCBwd2QNCi9ob21lL2lubm8vZHJtLXJ1
c3QvcnVzdC9iaW5kaW5ncw0KJCBncmVwIC1SIHB1dF9kZXZpY2UgKg0KYmluZGluZ3NfZ2VuZXJh
dGVkLnJzOiAgICBwdWIgZm4gcHV0X2RldmljZShkZXY6ICptdXQgZGV2aWNlKTsNCg0KSGVoZS4g
SSBhbSBvcGVuIHRvIG9wdGlvbnMuDQoNClouDQo+IA0KPj4gKyAgICAgICAgICAgIH0NCj4+ICsg
ICAgICAgICAgICByZXR1cm4gRXJyKEVycm9yOjpmcm9tX2Vycm5vKHJldCkpOw0KPj4gKyAgICAg
ICAgfQ0KPj4gKw0KPj4gKyAgICAgICAgT2soU2VsZiB7DQo+PiArICAgICAgICAgICAgZndjdGxf
ZGV2OiBkZXYsDQo+PiArICAgICAgICAgICAgX21hcmtlcjogUGhhbnRvbURhdGEsDQo+PiArICAg
ICAgICB9KQ0KPj4gKyAgICB9DQo+PiArDQo+PiArICAgIGZuIGFzX3Jhdygmc2VsZikgLT4gKm11
dCBiaW5kaW5nczo6ZndjdGxfZGV2aWNlIHsNCj4+ICsgICAgICAgIHNlbGYuZndjdGxfZGV2LmFz
X3B0cigpDQo+PiArICAgIH0NCj4+ICt9DQo+PiArDQo+PiAraW1wbDxUOiBGd0N0bE9wcz4gRHJv
cCBmb3IgUmVnaXN0cmF0aW9uPFQ+IHsNCj4+ICsgICAgZm4gZHJvcCgmbXV0IHNlbGYpIHsNCj4+
ICsgICAgICAgIC8vIFNBRkVUWTogYGZ3Y3RsX3VucmVnaXN0ZXIoKWAgZXhwZWN0cyBhIHZhbGlk
IGRldmljZSBmcm9tIGBfZndjdGxfYWxsb2NfZGV2aWNlKClgLg0KPiANCj4gSW5jb21wbGV0ZSBz
YWZldHkgc3RhdGVtZW50LCB0aGUgZGV2aWNlIHBhc3NlZCB0byBmd2N0bF9hbGxvY19kZXZpY2Ug
bXVzdA0KPiBzdGlsbCBiZSBib3VuZCBwcmlvciB0byBjYWxsaW5nIGZ3Y3RsX3VucmVnaXN0ZXIN
Cj4gDQo+PiArICAgICAgICB1bnNhZmUgew0KPj4gKyAgICAgICAgICAgIGJpbmRpbmdzOjpmd2N0
bF91bnJlZ2lzdGVyKHNlbGYuYXNfcmF3KCkpOw0KPj4gKyAgICAgICAgICAgIGJpbmRpbmdzOjpw
dXRfZGV2aWNlKGNvcmU6OnB0cjo6YWRkcl9vZl9tdXQhKCgqc2VsZi5hc19yYXcoKSkuZGV2KSk7
DQo+IA0KPiBUaGVyZSBmb3IgRHJvcCBjYW4gb25seSBkbyBmd2N0bF9wdXQoKSBzaW5jZSBvdGhl
cndpc2UgdGhlcmUgaXMgbm8gd2F5DQo+IHRvIGd1YXJhbnRlZSBhIEJvdW5kIGRldmljZS4NCj4g
DQo+IHVucmVnaXN0ZXIgaGFzIHRvIGhhcHBlbiBiZWZvcmUgcmVtb3ZlKCkgY29tcGxldGVzLCBE
YW5pbG8gaGFkIHNvbWUNCj4gYXBwcm9hY2ggdG8gdGhpcyBJIHRoaW5rIGhlIHRvbGQgbWU/DQo+
IA0KPiBKYXNvbg0KDQo=

