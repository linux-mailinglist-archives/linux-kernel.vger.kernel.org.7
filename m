Return-Path: <linux-kernel+bounces-788631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ECACB3879C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 18:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34A613B4CB9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 16:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0861D86FF;
	Wed, 27 Aug 2025 16:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="J0/61eWa"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3200D17B505
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 16:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756311324; cv=fail; b=Hu73bUeTTQR/RVcsJZYMm/JOYBdxkd8kEDOVsiuIIva/2hsrmhsi3QIikeIskbLWwABHEjzlzUAf8Ig/f6r5uky67Ek1scUZLk3x8QoV+KXuaZSL/7xRdeKUoBZsopT7TFHKxU9API9pZnMZR5VqyxyY32Yfwdnab8L7g820B5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756311324; c=relaxed/simple;
	bh=ebs0IJHvWaul9AqeT9W7QJeIXzGf54frMyVYI5IGodg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i0kAVlDnc5jwZ+ItBj7VoNpfBHg1Vr6fLLyvRRt+24WzxdjF1ZqI9BpFyhuir23qiDds3WocZcI0Ho0XcN/2jcXVu2trhpAedQid9yeNkJ2gUtViC1OFt7NFm8pyZR8+9UqHWFAz018FZEZK2EQwd/lfzULLCUNuMbE0QxLAgp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=J0/61eWa; arc=fail smtp.client-ip=40.107.237.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p+ttQnHxWlc0BuSvuJRgHQgD+g1F2dTMWmE6J2HFcmiaa6KKMpd7tjgi4YWED6gEtuAltKXGPAR+YOPc31D68sY7rIlU6vJSAnmwKprAiSdwr4XJxkDBJh9BA8/PMG9khTrDphVxFzytZf9MJ8PxyplkgyYtJOuKUPLVDD7urhGP/0P10Y2Ca5EaX4kDrwxVDO3YEvnZA0SGfRIMnKmSnUtSgL1WlRFb8X7uwrVHZKK5GHWf7GmsR233vHkOu5yVb6PKCFo+LvaClKqawCZMjzSI4YtzUzWIVTEKKbAk8NJIEgqD1/+jXhFtwxNmlBmzRMwkqSltujiMRrGXwDMMvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ebs0IJHvWaul9AqeT9W7QJeIXzGf54frMyVYI5IGodg=;
 b=Fr0rlJB6sk8NhTBDxl/MxKgbVzqCWPKNLM1ewgPWW1G5315LcTYD0FTrJYv4XjMKc8c1YSGhi2hLoweYFcf0jVZaMcV1pJkA93QiT2ciN2do8OjGThUfpEOHeGsXf9KkGjpewEGasPSvI2GUEX4dEBKWQG+jZetZV7KTTcOpHY8EwbpBDyjJHxAOTjR5McMBoQ6FBrkFnJgAnaIYiEfyrcw4QufH4/+pX5ipVe831C3QLcw22zPFZCZGDY+4006qOgMAQS1rcGYYG9StMam1vgMG8DNfRjLsuKTpmbdQ3Yf8GSZkz7jJOrSO1WYU02wwDbeK83jvAYT42EyGBaZDmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ebs0IJHvWaul9AqeT9W7QJeIXzGf54frMyVYI5IGodg=;
 b=J0/61eWalwNk6zsqaq6ocbbPCrayzH7R+a0SYye2NQ+tw35zEtGsa9LQVCk4SZ7lZPMqOfhyZkbseOdV6B8Eb0JIOFq3rid+M+2uQ7CdYnIZJ+1rFqRwgRVe3UhUZf2p2isP/mc9KQMqk89DgsZROgYHwgV2RtYss9YzccTzAAk=
Received: from LV3PR12MB9265.namprd12.prod.outlook.com (2603:10b6:408:215::14)
 by SA1PR12MB6800.namprd12.prod.outlook.com (2603:10b6:806:25c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.13; Wed, 27 Aug
 2025 16:15:18 +0000
Received: from LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427]) by LV3PR12MB9265.namprd12.prod.outlook.com
 ([fe80::cf78:fbc:4475:b427%5]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 16:15:18 +0000
From: "Kaplan, David" <David.Kaplan@amd.com>
To: Borislav Petkov <bp@alien8.de>
CC: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Thomas Gleixner
	<tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf
	<jpoimboe@kernel.org>, Ingo Molnar <mingo@redhat.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "H . Peter
 Anvin" <hpa@zytor.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 4/5] x86/bugs: Add attack vector controls for SSB
Thread-Topic: [PATCH v2 4/5] x86/bugs: Add attack vector controls for SSB
Thread-Index:
 AQHcEmNJ5LXItfJ3EEGTlLKvZSsitbR2VbgAgAAKGoCAADDXIIAABpWAgAAAcnCAABOMAIAAAq2AgAAH8oCAAACcoA==
Date: Wed, 27 Aug 2025 16:15:18 +0000
Message-ID:
 <LV3PR12MB926507DF8A992FA953F22E099438A@LV3PR12MB9265.namprd12.prod.outlook.com>
References: <20250819192200.2003074-1-david.kaplan@amd.com>
 <20250819192200.2003074-5-david.kaplan@amd.com>
 <7vo33zwvn2wz74fg7wuflrr2gnhlkn7hwaziuzkk7brrp2morh@ltbtredcwb5x>
 <20250827102754.GHaK7dqivnNnQsWGeS@fat_crate.local>
 <20250827110403.GFaK7mIxwsQ9IF7ML8@fat_crate.local>
 <LV3PR12MB92655023C50A92BE30D7A8049438A@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20250827142225.GIaK8UoYo-rnR9T2OD@fat_crate.local>
 <LV3PR12MB9265934929BC29E635C39EDD9438A@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20250827153358.GJaK8lZm3cggYDbw2C@fat_crate.local>
 <LV3PR12MB9265ABD1B81D759A618A20029438A@LV3PR12MB9265.namprd12.prod.outlook.com>
 <20250827161159.GKaK8uTy8aW6Xl7UCr@fat_crate.local>
In-Reply-To: <20250827161159.GKaK8uTy8aW6Xl7UCr@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-08-27T16:14:10.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9265:EE_|SA1PR12MB6800:EE_
x-ms-office365-filtering-correlation-id: 6caaaff8-2516-47bf-fb23-08dde584ea52
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?aWI0YmloRTBNUmpNd2ZvWU9zd0ZkbWlDdVpwZkw0UFBERzBiblRqbWM4OUlR?=
 =?utf-8?B?WWgvTi96T3dvUXpRTW1qekZnYjZJRGJPaURneUVKZldYSWthMml6YTk4ZWUz?=
 =?utf-8?B?ZnZUY0F2cmZtaGRJbUFFUGM5YW1ENGh4M3ZtMFdnclhiY21PRmJ1M1F3ajBZ?=
 =?utf-8?B?dHhNN3NQM1dhcHNEcDJYZXhJN2N0Mm1MWGJleU5QY0M4WExMdVFsN3lkV1ZS?=
 =?utf-8?B?eUc4QmFFQVNRZDVrZDVhbFV3MkRFNHI4Q3NSZnJ3ODhrdk1HOFNVc0l6UlAv?=
 =?utf-8?B?Vno5aXp6MWkybXZwYTBPOWNDd2NlREppaDV5VmRJNWV4SXNkUzl1VENtbXhE?=
 =?utf-8?B?eDJsb1R3SXlsZ2Z3MmhyZDYzK0pjZUg4bWJLaWNCMjV5RmxzRWtueUkvODBF?=
 =?utf-8?B?ZHVxWStRVXZaSzRZU2pXYnFTTjA4M1VGZzd6TG9aVkVKTlh1bUJPQk84dkEx?=
 =?utf-8?B?TFVLbXBvQy8renlMa0thU2lkeVFDNmxDUEtDaWxpTXgyMmpkQjNMa00yUENS?=
 =?utf-8?B?ekRiUmd2bEpveXd6ZzNmVDVsN1o3S1NCUnRHeXZ0RUhuVEUvL21UTGZnWXRq?=
 =?utf-8?B?V3JsblV3RXhwanZLZWpGVEVtK3JlRFVuRXBxUDNjV1cyNEtXU0RtMHJpY0Qx?=
 =?utf-8?B?SjYyR0N4c29WUmVWMDJtakZ3NUhUc1g1aEtvRjdnV2FkVGVkc1ZyRkQzNzNy?=
 =?utf-8?B?R1NhQTRZOGowYVNPUTNlNjZML1JyUU1XRndsRWlPWTFxRjNTWjhtYXZCblhh?=
 =?utf-8?B?bFFPQ05aUjZUS3A5UUZHOW1GYVN6QWJyNEsvTWozWm11dGFGSzZDekh0bnN3?=
 =?utf-8?B?SExQZExkT2dQMXBNL0JEQnhoQ01sVXJGZ3AwRnVmTTlrTFRLZXk2OCtTSUZk?=
 =?utf-8?B?V2NFcEd2VUhLK3B5QWhSWndmMnVzK2hUY1NnaStOaitjZVByemI3dGlYamJl?=
 =?utf-8?B?ZXpHTjIvSGFjOXhFWU9PcHdLWTdkeklRVGJBQU9ZTURhT0VqV2lLTmxkTmJT?=
 =?utf-8?B?SCtNZUMzekw0WHpuMkx4ZnVmcm1FZ1AzQkNjblF2TTJJVkd5dG9jWjhMSXlX?=
 =?utf-8?B?ZXo3UngwWnI1ejdLcmdPdnlZZjVWOWRJclZsK3ZnUWxXazE2QWpyK2JuYjVV?=
 =?utf-8?B?RUhneWZxVkVNK0NHdHBTV3pJSUZIdG85TmYrekF0Z2lKRlh3RVF6TGFjM3ZC?=
 =?utf-8?B?RWo1cEFsVElBWStCWWlpUmtaTGZpQ2U2Mmg0eVBUS3pPbjJjbUs0UTJ3RCtR?=
 =?utf-8?B?VVBrZ213RWxPQ1Y0N1pCcWRUUVlCRStNdFd5d01zUzlCWTRuYXBGZjZVUlMy?=
 =?utf-8?B?WmpPMzY0b1E4WkpOMUNyYlBRdng1TSsrVXZOVXdOaVNLQjJCbzhHT1ZwZHpm?=
 =?utf-8?B?UXFudGNVQjRJU1JiUFNqZ0pPWjdRRUI5YU1LbGRZalVsQjQzaVlRTkZBR2c2?=
 =?utf-8?B?UllLYzA4TXhjdlJTWE81dE5Pa3oydVhZMzkzNW52YS9iTzlBNXRlYWlFT1J5?=
 =?utf-8?B?NC9QK040S1pKNzJEcExBN2xkVUJpd052cUZrWU1LcmtmQmZTOWZkdUtxY01Q?=
 =?utf-8?B?SXZ3SDVQN21BWmxkbDIwSGp4Z1ZuNVNVYnpZZ3VSRVBrcVJiYTdtV1d0RUZq?=
 =?utf-8?B?RVdoY3JPZkVUYzRncm9KYk9JRHFlZURXY3hYSldYNjBKZDhtQ01uR0xKNTN2?=
 =?utf-8?B?c1RWYXMwT1ZxUkgxbEdvbm16a1Q5ek1IS3NzNzIzVTJRNmYxVUVkMlJpYWN5?=
 =?utf-8?B?VkkzUmVicWZRZVE0alBFd284RmJaSkFmczBSbXk3UWEycjl5Q05hcUhXZGRk?=
 =?utf-8?B?Q05EL2tpOEh4OWRJd3F0N3NacVl5RzlQczZVVFhTbERVVW9zS3FIUDU0VlVr?=
 =?utf-8?B?VkFPV053SWNjaU1kSXd5ZTk5WDRkSjhmK3F4RDk5Ui9wUkZjcXZsMlpxaGNy?=
 =?utf-8?B?QVBMelgrd203eXpsTjBDOXhtdHhzWXBvcHBWMmV3R2tSRTFTc0JqeGdtSFh2?=
 =?utf-8?Q?MBqRQs4S3XQtopVbXidJJbjL4S4+Vw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TnpSNnI0ei9URUU1N1cxMjVPUkF6MHVDd2s3RnlxQU04OU5DS2NuNnhSM1Nq?=
 =?utf-8?B?R2NrV29EaDFOaUk5RTlaWnBrUXJuVEFlZkY0cTUvUkhuZVVUWUxqcGs5ZWV3?=
 =?utf-8?B?MXdFWkZiSFhtZUQ0YUNOVEE3NUFNbUxjOEc1OUdKamxCQXFSSUQwYmVJWXho?=
 =?utf-8?B?NGlVVnRKWUZ2UXdsYm9CclJ4UjVUckd4RWxOdHNxd2tVR1J6dHdpVU15VEVK?=
 =?utf-8?B?V1Z2LzcySTU3OEJlNzhtYmNqUVE5SEt5bEdEZlpObUNzSXdlK1RsbG0xRlh3?=
 =?utf-8?B?UXV5Z2RxMHNIYkcxdFVqNDZZdlJ6K1R2V0JHNS9zRUdTL2hENjlrTTd0V2g5?=
 =?utf-8?B?cXFSZXhOa2JsRTZSYlZlZUsrMGJ0UWJ6RUtsZTBxV2NNaEJWZFQrWEFUck0y?=
 =?utf-8?B?OTBralhWNmRSWjEyWWdOekNJN3oxQmdtUDdCbFlydVkrdVhmMUZHbEkreTNH?=
 =?utf-8?B?YWJOUDVlQ2ZvZXVheVZFVDhTb2swcWo0TzRuMytIS2xIZld6b3lqbWtlZUky?=
 =?utf-8?B?aUZhVlZrT1Rud2RVTHlkNGtRV2prMFVsT2F4ZUcyYkR5TDVtU2NBd3ZyREgz?=
 =?utf-8?B?MldhSFp4cjB4K2NaMlRYNDNEYUhWV29hQ291OVl2aG0zbEV0T0VYc2wveW1L?=
 =?utf-8?B?ZGFkWFVtbXpVaFM4UUp4NHJHTHdDc0ZVM002Z3dYeFhFWUl5R2w4RUw3WEdT?=
 =?utf-8?B?Mk9BcFN1RUhISVRIREhJd0dsQS9ISGZRVXZ3TWxKbVgrc0dSeGljczkxUDBl?=
 =?utf-8?B?UkxhMWowY2VSZWtUMjJpUjVJcDF6Mk12OUZ6cENkYnhINmY1YVBnaStVTE5L?=
 =?utf-8?B?dHRCZFpucVBiUFFqRmo3R3hPV2E5ODRjNTJCdjFNejE0UFR0RDJFcmFCZ2VN?=
 =?utf-8?B?UmpHQ0RjdWN3bjZQTjJ0aFFYb3VNZmk5N2VwOTFVMnplcjA1RzZGc0twRjlm?=
 =?utf-8?B?QWNqVE5KZXNyanF5UTNUd2UrT3NNSXcrZVl3czJ1M1M0bmduZ1VxVy8rUnRy?=
 =?utf-8?B?MVJ5bzk0V3JpbnpzVmNsV0REY0hrckcxRE8zQzlpby81NTgvaHZONXFpUlZR?=
 =?utf-8?B?SUx0VkxGTVJFQVRqTnFyS3I1VHFBSVNKL1NpZk9QK0dxanJ2N2VvMHFuWHp3?=
 =?utf-8?B?enRpeUYwQ0UxT2pQRkhCaWNQc0RSNUtOOS9CL0RwYjBJWGtMdzA0a3lHYjM0?=
 =?utf-8?B?ZnZVYUJPYlgzU0Y4NE5LOWNET0pmdXZxaW03SFFLY3d5ekNaNTZyTVhKT0dE?=
 =?utf-8?B?aDY4UmxmdWhyLzFDV3VzcTdGUnNHU083SlFMU0NrWXJJY1hJeFNGOFRCZ0FK?=
 =?utf-8?B?WmhQVFBKdHRVT2NjQ0NReGV6dDlhRjcveTU2aHNaS3IzcWlCTFpLSWo0NG0y?=
 =?utf-8?B?b3d0WmphZEk4bG92bmNMcnJzc3Z1VlBLNnBaR0FLWW1ndGxrR081ZTh6TVJJ?=
 =?utf-8?B?dVVOWkljaXBZaFBGSC9VNWk3UVVNTnk5bTZqWWpHdlV3Q0ZzR3hpVlpXbXpS?=
 =?utf-8?B?VkROUmN1VE85dTlJamRZNHRjU2gveVFiNUltTjdhQWpqNUNMYnRwN0w4V0t1?=
 =?utf-8?B?MXgxMi9wRDJzZElmeVpmYTBsZEZKN0toQi9VelJXVCs4WVl5OHI0VEt3TkFZ?=
 =?utf-8?B?VUNmVjBGQTdwUUJDWVNubWFveHRkWjdBV2pGK0txVUY1OVUwTnF4Q3RmYlh6?=
 =?utf-8?B?K2s3eHFwbkJHSVRxN09YeGtnVTlaNS90K3ZYZzlDMkJrMTJJUFNDQ2pwU3FR?=
 =?utf-8?B?aGZiTS9rNHo2dGtPY0xXYUhPU1JVMTRMN01Nbjl4eGNGVS9OUWg1NENaa0VB?=
 =?utf-8?B?eXYrejBZQzRXTE5Ga3BzNXhTSzNYUWtBbUgwb2dqSmI4Rm40RlJzQUprOGp3?=
 =?utf-8?B?N3cvV21kUjFMcXdyNHcxM2dXTnVibHF5WWVMcS9JMFN4bE9EU25MYWdjaHBX?=
 =?utf-8?B?dmV6eUxBbjFmNldYL3ZuMUoraHdQSllVTjBRcHloVWhWVCtvWU1nWG85Zk5U?=
 =?utf-8?B?UFZPZ0ZveHd3Nmw5SmFKR0xrZ1hTOEFhd2IzR01hQVloL21rdGJpbysxWEdp?=
 =?utf-8?B?U0ZFaTczRHlteG5BUlFPL3hhSXMreTZVeGsybFdEaWp3Z2JGRFpkSmx2WGpv?=
 =?utf-8?Q?5Afw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6caaaff8-2516-47bf-fb23-08dde584ea52
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2025 16:15:18.5495
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TeWqJ8ipb+HfgTaf0IJHdpkxL7oPgypAIbomFCCy4U5Lx35zLwAu3zRmU1xc4EnG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6800

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEFNRCBJbnRlcm5hbCBEaXN0cmlidXRpb24gT25seV0N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCb3Jpc2xhdiBQZXRrb3Yg
PGJwQGFsaWVuOC5kZT4NCj4gU2VudDogV2VkbmVzZGF5LCBBdWd1c3QgMjcsIDIwMjUgMTE6MTIg
QU0NCj4gVG86IEthcGxhbiwgRGF2aWQgPERhdmlkLkthcGxhbkBhbWQuY29tPg0KPiBDYzogUGF3
YW4gR3VwdGEgPHBhd2FuLmt1bWFyLmd1cHRhQGxpbnV4LmludGVsLmNvbT47IFRob21hcyBHbGVp
eG5lcg0KPiA8dGdseEBsaW51dHJvbml4LmRlPjsgUGV0ZXIgWmlqbHN0cmEgPHBldGVyekBpbmZy
YWRlYWQub3JnPjsgSm9zaCBQb2ltYm9ldWYNCj4gPGpwb2ltYm9lQGtlcm5lbC5vcmc+OyBJbmdv
IE1vbG5hciA8bWluZ29AcmVkaGF0LmNvbT47IERhdmUgSGFuc2VuDQo+IDxkYXZlLmhhbnNlbkBs
aW51eC5pbnRlbC5jb20+OyB4ODZAa2VybmVsLm9yZzsgSCAuIFBldGVyIEFudmluDQo+IDxocGFA
enl0b3IuY29tPjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTog
W1BBVENIIHYyIDQvNV0geDg2L2J1Z3M6IEFkZCBhdHRhY2sgdmVjdG9yIGNvbnRyb2xzIGZvciBT
U0INCj4NCj4gQ2F1dGlvbjogVGhpcyBtZXNzYWdlIG9yaWdpbmF0ZWQgZnJvbSBhbiBFeHRlcm5h
bCBTb3VyY2UuIFVzZSBwcm9wZXIgY2F1dGlvbg0KPiB3aGVuIG9wZW5pbmcgYXR0YWNobWVudHMs
IGNsaWNraW5nIGxpbmtzLCBvciByZXNwb25kaW5nLg0KPg0KPg0KPiBPbiBXZWQsIEF1ZyAyNywg
MjAyNSBhdCAwMzo0NzoxMFBNICswMDAwLCBLYXBsYW4sIERhdmlkIHdyb3RlOg0KPiA+IEFmdGVy
IHJldmlld2luZyB0aGlzIGZ1cnRoZXIsIHRoaXMgY2hhbmdlIHNob3VsZCBiZSByZW1vdmVkLiAg
VGhlIEFVVE8gbWl0aWdhdGlvbg0KPiBpcyBpbnRlbmRlZCB0byBzYXkgJ2Nob29zZSBiYXNlZCBv
biBhdHRhY2sgdmVjdG9yJywgYnV0IHdpdGggdGhpcyBwYXRjaCB5b3UncmUgbm90DQo+IGxvb2tp
bmcgYXQgc3NiX21vZGUgdG8gZGVjaWRlIHRvIGRvIHRoYXQuICBZb3UncmUgbG9va2luZyBhdCB0
aGUgc3NiIG1pdGlnYXRpb24gY21kDQo+ICh3aGljaCBhbHJlYWR5IGRlZmF1bHRzIHRvIFNQRUNf
U1RPUkVfQllQQVNTX0NNRF9BVVRPKS4gIFRoZXJlZm9yZSB0aGVyZQ0KPiBpcyBubyBuZWVkIGZv
ciBhIFNQRUNfU1RPUkVfQllQQVNTX0FVVE8gc2V0dGluZyBvZiBzc2JfbW9kZS4NCj4gPg0KPiA+
IChUaGUgY2xlYW4tdXAgcGF0Y2ggcmVtb3ZlcyBzc2JfbWl0aWdhdGlvbl9jbWQgZW50aXJlbHks
IHNvIGl0IG5lZWRzIGFuIEFVVE8NCj4gc2V0dGluZyBvZiBzc2JfbWl0aWdhdGlvbikNCj4NCj4g
Li4uDQo+DQo+ID4gQnV0IG1vcmUgaW1wb3J0YW50bHksIHBsZWFzZSByZW1vdmUgdGhpcy4gIFRo
YXQncyBiZWNhdXNlIGluIHRoZSBjdXJyZW50IHBhdGNoLCBpZg0KPiB0aGUgdXNlciBzYXlzICdu
b3NwZWNfc3RvcmVfYnlwYXNzX2Rpc2FibGUnIHRoZW4gdGhlIHNzYl9zZWxlY3RfbWl0aWdhdGlv
bigpDQo+IGZ1bmN0aW9uIGRvZXMgbm90IGNoYW5nZSBzc2JfbW9kZS4gIFNvIGl0IG5lZWRzIHRv
IGRlZmF1bHQgdG8gTk9ORS4NCj4NCj4gWWFoLCBhZ3JlZWQgd2l0aCBib3RoLiBIZXJlJ3MgYSBt
aW5pbWFsIHRoaW5nLg0KPg0KPiAtLS0NCj4gRnJvbTogRGF2aWQgS2FwbGFuIDxkYXZpZC5rYXBs
YW5AYW1kLmNvbT4NCj4gRGF0ZTogVHVlLCAxOSBBdWcgMjAyNSAxNDoyMTo1OSAtMDUwMA0KPiBT
dWJqZWN0OiBbUEFUQ0hdIHg4Ni9idWdzOiBBZGQgYXR0YWNrIHZlY3RvciBjb250cm9scyBmb3Ig
U1NCDQo+DQo+IEF0dGFjayB2ZWN0b3IgY29udHJvbHMgZm9yIFNTQiB3ZXJlIG1pc3NlZCBpbiB0
aGUgaW5pdGlhbCBhdHRhY2sgdmVjdG9yIHNlcmllcy4NCj4gVGhlIGRlZmF1bHQgbWl0aWdhdGlv
biBmb3IgU1NCIHJlcXVpcmVzIHVzZXItc3BhY2Ugb3B0LWluIHNvIGl0IGlzIG9ubHkNCj4gcmVs
ZXZhbnQgZm9yIHVzZXItPnVzZXIgYXR0YWNrcy4gIEFkZCBhbiBBVVRPIG1pdGlnYXRpb24gZm9y
IFNTQiBhbmQgdXNlIHRoaXMNCj4gYXR0YWNrIHZlY3RvciBjb250cm9sIHRvIHNlbGVjdCB0aGUg
U1NCIG1pdGlnYXRpb24uDQo+DQo+IEZpeGVzOiAyZDMxZDI4NzQ2NjMgKCJ4ODYvYnVnczogRGVm
aW5lIGF0dGFjayB2ZWN0b3JzIHJlbGV2YW50IGZvciBlYWNoIGJ1ZyIpDQo+IFNpZ25lZC1vZmYt
Ynk6IERhdmlkIEthcGxhbiA8ZGF2aWQua2FwbGFuQGFtZC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6
IEJvcmlzbGF2IFBldGtvdiAoQU1EKSA8YnBAYWxpZW44LmRlPg0KPiBMaW5rOiBodHRwczovL2xv
cmUua2VybmVsLm9yZy8yMDI1MDgxOTE5MjIwMC4yMDAzMDc0LTUtZGF2aWQua2FwbGFuQGFtZC5j
b20NCj4gLS0tDQo+ICAuLi4vYWRtaW4tZ3VpZGUvaHctdnVsbi9hdHRhY2tfdmVjdG9yX2NvbnRy
b2xzLnJzdCAgICAgICB8IDUgKy0tLS0NCj4gIGFyY2gveDg2L2tlcm5lbC9jcHUvYnVncy5jICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgOSArKysrKysrKysNCj4gIDIgZmlsZXMgY2hh
bmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBh
L0RvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUvaHctdnVsbi9hdHRhY2tfdmVjdG9yX2NvbnRyb2xz
LnJzdA0KPiBiL0RvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUvaHctdnVsbi9hdHRhY2tfdmVjdG9y
X2NvbnRyb2xzLnJzdA0KPiBpbmRleCA2ZGQwODAwMTQ2ZjYuLjU5NjQ5MDFkNjZlMyAxMDA2NDQN
Cj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9ody12dWxuL2F0dGFja192ZWN0b3Jf
Y29udHJvbHMucnN0DQo+ICsrKyBiL0RvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUvaHctdnVsbi9h
dHRhY2tfdmVjdG9yX2NvbnRyb2xzLnJzdA0KPiBAQCAtMjE1LDcgKzIxNSw3IEBAIFNwZWN0cmVf
djIgICAgICAgICAgICBYICAgICAgICAgICAgICAgICAgICAgICAgICAgWA0KPiAgU3BlY3RyZV92
Ml91c2VyICAgICAgICAgICAgICAgICAgICAgIFggICAgICAgICAgICAgICAgICAgICAgICAgICBY
ICAgICAgICAgICAgKiAgICAgICAoTm90ZSAxKQ0KPiAgU1JCRFMgICAgICAgICAgICAgICAgIFgg
ICAgICAgICAgICAgIFggICAgICAgICAgICBYICAgICAgICAgICAgICBYDQo+ICBTUlNPICAgICAg
ICAgICAgICAgICAgWCAgICAgICAgICAgICAgWCAgICAgICAgICAgIFggICAgICAgICAgICAgIFgN
Cj4gLVNTQiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKE5vdGUgNCkNCj4gK1NTQiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBYDQo+ICBUQUEgICAgICAgICAgICAgICAgICAgWCAg
ICAgICAgICAgICAgWCAgICAgICAgICAgIFggICAgICAgICAgICAgIFggICAgICAgICAgICAqICAg
ICAgIChOb3RlIDIpDQo+ICBUU0EgICAgICAgICAgICAgICAgICAgWCAgICAgICAgICAgICAgWCAg
ICAgICAgICAgIFggICAgICAgICAgICAgIFgNCj4gID09PT09PT09PT09PT09PSA9PT09PT09PT09
PT09PSA9PT09PT09PT09PT0gPT09PT09PT09PT09PQ0KPiA9PT09PT09PT09PT09PSA9PT09PT09
PT09PT0gPT09PT09PT0NCj4gQEAgLTIyOSw5ICsyMjksNiBAQCBOb3RlczoNCj4gICAgIDMgLS0g
IERpc2FibGVzIFNNVCBpZiBjcm9zcy10aHJlYWQgbWl0aWdhdGlvbnMgYXJlIGZ1bGx5IGVuYWJs
ZWQsIHRoZSBDUFUgaXMNCj4gICAgIHZ1bG5lcmFibGUsIGFuZCBTVElCUCBpcyBub3Qgc3VwcG9y
dGVkDQo+DQo+IC0gICA0IC0tICBTcGVjdWxhdGl2ZSBzdG9yZSBieXBhc3MgaXMgYWx3YXlzIGVu
YWJsZWQgYnkgZGVmYXVsdCAobm8ga2VybmVsDQo+IC0gICBtaXRpZ2F0aW9uIGFwcGxpZWQpIHVu
bGVzcyBvdmVycmlkZGVuIHdpdGggc3BlY19zdG9yZV9ieXBhc3NfZGlzYWJsZSBvcHRpb24NCj4g
LQ0KPiAgV2hlbiBhbiBhdHRhY2stdmVjdG9yIGlzIGRpc2FibGVkLCBhbGwgbWl0aWdhdGlvbnMg
Zm9yIHRoZSB2dWxuZXJhYmlsaXRpZXMNCj4gIGxpc3RlZCBpbiB0aGUgYWJvdmUgdGFibGUgYXJl
IGRpc2FibGVkLCB1bmxlc3MgbWl0aWdhdGlvbiBpcyByZXF1aXJlZCBmb3IgYQ0KPiAgZGlmZmVy
ZW50IGVuYWJsZWQgYXR0YWNrLXZlY3RvciBvciBhIG1pdGlnYXRpb24gaXMgZXhwbGljaXRseSBz
ZWxlY3RlZCB2aWEgYQ0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL2NwdS9idWdzLmMg
Yi9hcmNoL3g4Ni9rZXJuZWwvY3B1L2J1Z3MuYw0KPiBpbmRleCA0OWVmMWI4MzJjMWEuLmFmODM4
YjhkODQ1YyAxMDA2NDQNCj4gLS0tIGEvYXJjaC94ODYva2VybmVsL2NwdS9idWdzLmMNCj4gKysr
IGIvYXJjaC94ODYva2VybmVsL2NwdS9idWdzLmMNCj4gQEAgLTQxNiw2ICs0MTYsMTAgQEAgc3Rh
dGljIGJvb2wgX19pbml0IHNob3VsZF9taXRpZ2F0ZV92dWxuKHVuc2lnbmVkIGludCBidWcpDQo+
ICAgICAgICAgICAgICAgICAgICAgICAgY3B1X2F0dGFja192ZWN0b3JfbWl0aWdhdGVkKENQVV9N
SVRJR0FURV9VU0VSX1VTRVIpIHx8DQo+ICAgICAgICAgICAgICAgICAgICAgICAgY3B1X2F0dGFj
a192ZWN0b3JfbWl0aWdhdGVkKENQVV9NSVRJR0FURV9HVUVTVF9HVUVTVCkgfHwNCj4gICAgICAg
ICAgICAgICAgICAgICAgICAoc210X21pdGlnYXRpb25zICE9IFNNVF9NSVRJR0FUSU9OU19PRkYp
Ow0KPiArDQo+ICsgICAgICAgY2FzZSBYODZfQlVHX1NQRUNfU1RPUkVfQllQQVNTOg0KPiArICAg
ICAgICAgICAgICAgcmV0dXJuIGNwdV9hdHRhY2tfdmVjdG9yX21pdGlnYXRlZChDUFVfTUlUSUdB
VEVfVVNFUl9VU0VSKTsNCj4gKw0KPiAgICAgICAgIGRlZmF1bHQ6DQo+ICAgICAgICAgICAgICAg
ICBXQVJOKDEsICJVbmtub3duIGJ1ZyAleFxuIiwgYnVnKTsNCj4gICAgICAgICAgICAgICAgIHJl
dHVybiBmYWxzZTsNCj4gQEAgLTI3MTAsNiArMjcxNCwxMSBAQCBzdGF0aWMgdm9pZCBfX2luaXQg
c3NiX3NlbGVjdF9taXRpZ2F0aW9uKHZvaWQpDQo+ICAgICAgICAgICAgICAgICBzc2JfbW9kZSA9
IFNQRUNfU1RPUkVfQllQQVNTX0RJU0FCTEU7DQo+ICAgICAgICAgICAgICAgICBicmVhazsNCj4g
ICAgICAgICBjYXNlIFNQRUNfU1RPUkVfQllQQVNTX0NNRF9BVVRPOg0KPiArICAgICAgICAgICAg
ICAgaWYgKHNob3VsZF9taXRpZ2F0ZV92dWxuKFg4Nl9CVUdfU1BFQ19TVE9SRV9CWVBBU1MpKQ0K
PiArICAgICAgICAgICAgICAgICAgICAgICBzc2JfbW9kZSA9IFNQRUNfU1RPUkVfQllQQVNTX1BS
Q1RMOw0KPiArICAgICAgICAgICAgICAgZWxzZQ0KPiArICAgICAgICAgICAgICAgICAgICAgICBz
c2JfbW9kZSA9IFNQRUNfU1RPUkVfQllQQVNTX05PTkU7DQo+ICsgICAgICAgICAgICAgICBicmVh
azsNCj4gICAgICAgICBjYXNlIFNQRUNfU1RPUkVfQllQQVNTX0NNRF9QUkNUTDoNCj4gICAgICAg
ICAgICAgICAgIHNzYl9tb2RlID0gU1BFQ19TVE9SRV9CWVBBU1NfUFJDVEw7DQo+ICAgICAgICAg
ICAgICAgICBicmVhazsNCj4gLS0NCj4gMi41MS4wDQo+DQoNCkxHVE0uICBKdXN0IG1ha2Ugc3Vy
ZSB0byB1cGRhdGUgdGhlIGNvbW1pdCBkZXNjcmlwdGlvbiBzaW5jZSBpdCBubyBsb25nZXIgaXMg
YWRkaW5nIGFuIEFVVE8gbWl0aWdhdGlvbi4NCg0KVGhhbmtzIC0tRGF2aWQgS2FwbGFuDQo=

