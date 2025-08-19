Return-Path: <linux-kernel+bounces-774650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4EBB2B58D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 02:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06E28189009E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 00:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754B318DF89;
	Tue, 19 Aug 2025 00:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LvSJ/BHK"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2089.outbound.protection.outlook.com [40.107.95.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBA42F32;
	Tue, 19 Aug 2025 00:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755564587; cv=fail; b=ZAVJLrjy4PyhRqUWMeTxrePMg8bNSUA+0X0Rm68srRduJBtZ0efxEW18UlOVWXOLctWDCQFqzOufylhlsd8jypD2WBNdYLRiFSiTspi3vf+d6eJMliWMOuX3jCRPww4fzhsB1AFYbw5Z2h1yZ2YDgAGbKqkmBDWmIg4stUxsDl4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755564587; c=relaxed/simple;
	bh=0BS1UiEZGNidoEMSMCT69q7S1QsIu712aaklhHvQpNc=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=F8TGsov2FfEs1V8FTk3JGhCHZ/nLJCSF3lNSzh2OhFb6I+OAhuxXFxFCESAQOVoGe3xF+xQkylQfnKrFuE4T7WWJ9yTxvGNrSMqQug6XmONi7alkuGsqutx5LxNW+gB1+b7of5nOxp73/P2NEGry2PSoKIOcPmgBc4kz2hWuDsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LvSJ/BHK; arc=fail smtp.client-ip=40.107.95.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zvh4krBtso7c1oQDXrxqU1wQ/10Ar1U3CBp5o97aWvlmS+tz8TOmIIDRCck4nP2xxe5qADJEeWT4iNkIYKT+jeFo9IPgscViTdfGbgJ/kks9Lc+2MtrOLGNwE3Ec2EN3K23T/OAfUE0LVbCkTVFvJNM/P80/gbaMWvZkc+xLlcEyEcz2XtZnPD6DEIuN+tflmwakMphYHHgR2nw1cIkwhqV9upcGFRTUDaHDB2LqbEmWJQHX8SCfu/g0BLq5e0dUl8H3/obl1Ywuaf+yEpRGhlZ8PycSIyA05I1Iif6TS1SjidRPXXg6Ux1fDgoM1TmPg7G6p++wtEbzNrXWTouy3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g6+SxsGC2RPh1ioOgiMzheFFEpushxXFBdrRGPqbXgI=;
 b=u13h9mRGGZjDwDyoyUN0Xj7vj1BZxcZXJFy5otn7hWd3Sd+OVC+y94X7PInWlFCch1sOm9zDiAmduVDd4iG8j93oG0Idyr+ojeJ5rd0pLB9jKdcc0oqJuTnQYH8Hxt6yAvO/EtGe+4I+OvH7LU2F7fPA+YANiNPsVNia5rRuK9cywJTwr95SHH5x9DDaJZRcEIEOA8wFHdm6KeX3BsqZNgurO981lvVEnQNztT8N+OmvklRZF4XjycuCaTkOkFsJ05almy1QspOmUwlfkthDDBdlABfPBqDu469FfRoD1eCskKY7+XL+wXPnrGlVx8d/k8uQhnfqCzVwm0C65XyS6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g6+SxsGC2RPh1ioOgiMzheFFEpushxXFBdrRGPqbXgI=;
 b=LvSJ/BHKcnZNYXogP/kisrlD3cKRcs4lV/ZXBZtX8JIuNbyD/E/9bipctBvKLvGuzEnQLdTw0yddF99rj9/6g3DVO1Zsv2gADWoneNlNBDDmLQUXoaT6Jd/EaeAs2V/X12DdzLUVEhq71VM84UcSyCjDVoh0kslFK17TmcdtQs+3alzaRekhAg/jMRcwKq6vH9+t08bj34ESOLzyl2G3U4Dxjmu/rYgLz8SxxBAJEa60hNhjjPFPARihXzgg90DcifiZhrb1MHgfzq5Ycts73sY6y1oqPZx6cpbCXKXGJcyHyXJV4GHJHbhXzZiJCTYP2dLIWorvDHDL0HbXrTR9gQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by BL1PR12MB5707.namprd12.prod.outlook.com (2603:10b6:208:386::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 00:49:42 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%3]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 00:49:42 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 Aug 2025 09:49:38 +0900
Message-Id: <DC5ZPDQADDJT.32SFK2OHDRGTG@nvidia.com>
Cc: <aliceryhl@google.com>, <anna-maria@linutronix.de>,
 <bjorn3_gh@protonmail.com>, <boqun.feng@gmail.com>, <dakr@kernel.org>,
 <frederic@kernel.org>, <gary@garyguo.net>, <jstultz@google.com>,
 <linux-kernel@vger.kernel.org>, <lossin@kernel.org>, <lyude@redhat.com>,
 <rust-for-linux@vger.kernel.org>, <sboyd@kernel.org>, <tglx@linutronix.de>,
 <tmgross@umich.edu>, <daniel.almeida@collabora.com>, "Fiona Behrens"
 <me@kloenk.dev>
Subject: Re: [PATCH v2 2/2] rust: Add read_poll_timeout functions
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "FUJITA Tomonori" <fujita.tomonori@gmail.com>, <a.hindborg@kernel.org>,
 <alex.gaynor@gmail.com>, <ojeda@kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250817044724.3528968-1-fujita.tomonori@gmail.com>
 <20250817044724.3528968-3-fujita.tomonori@gmail.com>
In-Reply-To: <20250817044724.3528968-3-fujita.tomonori@gmail.com>
X-ClientProxiedBy: TY2PR06CA0012.apcprd06.prod.outlook.com
 (2603:1096:404:42::24) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|BL1PR12MB5707:EE_
X-MS-Office365-Filtering-Correlation-Id: d79be166-9ef3-4f82-ef8c-08dddeba4883
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cTNLQzc1MVBZS3d6ZFFUdW5BaHFLUytzdlhsSXNwSGZoZ2pISjh2anRQckdq?=
 =?utf-8?B?S2VuZXV5d2N5RjA2MzhabWRRRHpLbFA4RWVOdGVXOTEwSEpkTzZDNEV0TlZj?=
 =?utf-8?B?RnQremtKMmhBVVlhdVFvSEcxMFBSWi9zQTB0Rlg5aUhJMGl4eXFRT3F5MFhC?=
 =?utf-8?B?OVVuVEd0WkNzOW83aEJyODlNSEgyVHZrNVZKbFQxOTFESk9iak9KZ1UrbHYv?=
 =?utf-8?B?U29nbzVtNXNIaC9sWStMYkQ1eVEwQ0d1OC9veEVvdXgxaHBjdnNYOHdQbEYr?=
 =?utf-8?B?Wmt4d2UyS21ydklnZnVkQ2VGeGYyaDN1VkhzTFpRSDRLTmdzLzVwb2VZNmtK?=
 =?utf-8?B?SXBZTWlENDJ3YzJ6b3NJcDNVRFNtUlhQdW9YMEFlSnRWbDhENFpKSG1KUit3?=
 =?utf-8?B?UCtWLzVndGIwNGNrVzJZaUlHL0V2d2EvWW5lc0lreUY3NmJqQkNOcDd2Wm5l?=
 =?utf-8?B?MWplZkNybXRSd1hwbmE2eEo1ZjhWTG5QQXlMamVRQjQyaGhWbTRHYnU2Q1Jk?=
 =?utf-8?B?NlNycWkvdGRaeVZvMGVqd2JIRm1PR01vZ2tNd3pSMXVmZjJRSUFPMy9aQ0hI?=
 =?utf-8?B?Z1hsMFdlbGc0VkdUbU45MVUwMmhmMVNlR3lWa2NWTUJoVGdSM0tuM2pzc0VO?=
 =?utf-8?B?K2lsbEdaQVczNFYxWjExSmtXd3ZCUUlYanJVR3hJMEE4UzNYNXRoVmdkK2M2?=
 =?utf-8?B?Zlh0NmNHdGVUalB3WVdQTWFCb1p5MCswOGs0V3NKZ1Jubnl0M0xGT1Y5TFAv?=
 =?utf-8?B?OE9lbWsxaHgxQklWSktTN0g4TGdhVjk4K0tLRk5TdDlIT1o1TWRPcSs2cGV6?=
 =?utf-8?B?TXA2eU5TbHhPWHk1RW5qRHUvcWk4ZDFoQVZJRGRHeFRLdUxLM2QydDBUT0Q1?=
 =?utf-8?B?S0FkaGNIcGhwNmFaQ1FRd0NqNTZ5UEl2aDcybjBZWjV5cWk3YmFJZmhaQW9L?=
 =?utf-8?B?Umw1VFd1TFoyeXAxZmJWejhQVS9naFpsRzArZkhDZkdyQVM1LzE5bFF4QzV4?=
 =?utf-8?B?aHJPM1VyTDd5anFtMWtyU1RYdkhlMTVQcU16Wm9HNnV6K0JLRkVRaHJOcDZU?=
 =?utf-8?B?eTNxYnQ3RkZDUWtzWlZmajBwY3lNb0tWdXdPT1g4S1YvTkpWKzcxRFpZVmUx?=
 =?utf-8?B?ZHdFS1pQd2txTnd0M0IzWFdRbkttYm9iMDJjc0NHbkFVWVA2bVdLRnVGc21r?=
 =?utf-8?B?bEE4b2FQeU45M2RXQWhkaEtYendoRnJFWDV2cG9QR0NkUHk4WjY2RGxac2Ev?=
 =?utf-8?B?QWpUbDAyQ1ppRXRmM0tud2YwcEpBeGJSM1hWL3hjTThIaDB6L0h1Sm5HemhQ?=
 =?utf-8?B?elFxMnFhVVNETXIvWEtYRWU3U082K3MxdytOOVBYN0F1NmlabERXTnd2RWNm?=
 =?utf-8?B?akZjZXRXR0RGQkZ1WHRNL3JNZkx2d1dTNmFoVjltM3p2SDRrbGNISDdCVmlC?=
 =?utf-8?B?cXAzKzBNanZ2VVN0M3Y0VVRHc2NNTWRYNUUxQTdaQlNROEYrU2dVU1F2aFNk?=
 =?utf-8?B?L3BQT09sYWl1a3VIWmROMVFtR3BaYjRqRXVENDluNjcyYUlPbnlGOG1GZ3Nj?=
 =?utf-8?B?SFJLaUIxZC9lQ3FMMXJPQVpSYjBEam5vcm1JbnN4VHU1RUhabmxIR2VyMFNa?=
 =?utf-8?B?S25mbkhsQjZWeXJWT0VuTmZlS25JZlBwYUJGMWFMSzJUcXNsazVrTGJtekFB?=
 =?utf-8?B?UnlmR01CSmFjR0R0WG50Y0ZjMnZrc3RWTDN5a2RJTXhIQzB2ZjBWYU9yU3VR?=
 =?utf-8?B?dTd3d3JrVTBEdGdSUlQ1UVhrbm1LMjFINkg3UFFLRWNDK2RCM3ByU29oalZW?=
 =?utf-8?B?aTgyZU81SUJlR045b3BlSW1JMEZrYVdlN0x6Vnk4Vk40MmhOMXh1Qzg1WVFo?=
 =?utf-8?B?bXV5bFJzdUdQR09xVWYzV0pLdXhIU3FwZys5UWVqSXk1dnV5UjJSVkphSis3?=
 =?utf-8?Q?rD6Jd71xDJI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K3dXTTA2MWh2YmYwSnRHZnNWVjR0bjgwaXNQUm16dHliSnZUQitVSkxsanFF?=
 =?utf-8?B?R3ZUYzdKWW02aTNwYUdKZmhTOW1lc1ZtTS9ySjRubkhEK01kZXVmaFJpeTV5?=
 =?utf-8?B?RC9RK3Q0b2Iva2NwM3pWTkxCUUdpdFMrVkhaSERKRUVkQVNxQ0ljV1dHbTMv?=
 =?utf-8?B?RnA1aWI1aHdjcGswZHI1Q3E0dzVPTjZ0MXlQaTZ4Wk4vdjZNQXN0UDVTenU5?=
 =?utf-8?B?aCtSQWlMNmdScUJwamhGYTRYOVAyVVlZbmRJK2dobllSSzBxa01mNEdNRERq?=
 =?utf-8?B?RFR2eW5TQTdra0kzUCt5RjAxazVZc1Y4bmxjTjY1Yk5iTVA5YVZhcGVxcFB5?=
 =?utf-8?B?a3gzdHlncWVtbGs2bWk0WWF3eDNBSFM5U25VSVU4ZGtWc1NuZWVFR1d0eXVY?=
 =?utf-8?B?SzE5aVl6a1lYL0ZkK2IzUlZKZlFLNkhRTk5oVFdvR0hXaFVQWkZXMmdxMXpk?=
 =?utf-8?B?bXpRV0ZrSXZmdnlwZkRvK2YzUnNOaE5ublRiYTlkWk00STc4bHEwVmhBU0FM?=
 =?utf-8?B?cUtsQVZGblBOZ28wVUROZUFIVEovd2hjQitoTjJKM2tCRExib2JzRmZZSS93?=
 =?utf-8?B?SE9ZaXBlVHU0VVp5aVVRTjhxMk5Lck44cUFpYkFRUitodEIzTEVCcmRYci9F?=
 =?utf-8?B?OURIRjJ5bUpXQy9Hak1kYlloQlM1MzdwQzFwK2hyeUlmTnlGOFNlTWZycVND?=
 =?utf-8?B?SmhzU05BcWdJOGpSbW9HejlSMEc2Q21HU3lOZGVGV3pHWERUNnc4R3YzYklG?=
 =?utf-8?B?RmhoYkgwNEhoUHFGT21xZnNSaDFZWmU2eTh1blBtbHVjNTVXaUxWaEVxWlZB?=
 =?utf-8?B?TGh4eCs5N2pNaXFrMFFmRHhIdXJpcnRjV1doZkdmcjhVUGYwaGFXaUdzNG9s?=
 =?utf-8?B?d0Q1dTg2Z2RzWCtJemxSaGlDZGpQZExZa243QlBWcVZuOGZIR0VHczFYS1ZY?=
 =?utf-8?B?V3VQaTFuUXp5OFhxMWYreWFrQThUVGRGcUUyc0NweFh0S0tJM3hDL1QvWE1T?=
 =?utf-8?B?Q1hPMzJ0TU9SQjlmbXd4bit1akVIekFRSUxSeWZsRVN6bWQ3OUlOM25tandu?=
 =?utf-8?B?Si9BOGhQU1dxQ1QrN2dKNk42Nmo1SXFVSGlMUmhySURXV3dMU003d0k5ckd1?=
 =?utf-8?B?MnhoRHJKOTdvbG90S216Z25mQkhxYVNjc0o3V0JvY3lIVHIwV245dHM0b1lY?=
 =?utf-8?B?QkUyVDVRS21yVk1IOExHczU3c1pXdG1NM2xhRjZhS2xVK3NWWW5zdzdLR2ZJ?=
 =?utf-8?B?d1hzcFBsMHpHMVVFenRSMkJLOFhwQjRscHkwSWI1SjVHeFUwLzByaGU4UDFU?=
 =?utf-8?B?bzBMKzFXVDlYY1JIdU1WNkZkbzRHSzFEbHE1OEc2cGFzSzRTRk9TRFZKeitP?=
 =?utf-8?B?czJqT0JKSGVqN3NvUDYyNCtMWWdYN0ExVGUvazJpYWMvOVFVWHVDMU9HZ2hw?=
 =?utf-8?B?TU1yclNHazNqNnBYZnVHOXZMYmdVSUtUbGFNc2hjcGJFVnNtYWRWdjBiNU04?=
 =?utf-8?B?WlNkajdmQk1PMWlPWVJ3a1FDNUZpV0todTNlL0cwUVlLb1JVWkh2WnFQYnhJ?=
 =?utf-8?B?TXRtSzJsYmJsanhLR0NwcGlNS1FDbVMrQ21jWHk1b09yMThnaDAzYUd5MmRo?=
 =?utf-8?B?ZGE2Ny9NcVJrMmJYZ0tORmRPbVBqdjZjb3h6LzNNakxHZ2RieTBBcnhKZWJT?=
 =?utf-8?B?T0h4K2Nzdk1JSzVrajVrMUlWTmZ6bGxyTGY1V3loMmV0ZEFXanpFMysveTRW?=
 =?utf-8?B?MXl6ZHJ1YmU3S3F0MGhOTVdyejlRbWoyYmJwaUc4NllTK21yVlZSQktBcnkr?=
 =?utf-8?B?Mk80bEFDRTVwODhTK09UZ0F4Y0hPSzQxcHVydUtBQjdzNEYrS3U3UFAxcW84?=
 =?utf-8?B?Rm1taHFiWVo0dlBmUHhwRkFSRlFWWWl4RUFvS3czYWN3dUJNaWlzekEyb0dH?=
 =?utf-8?B?RnYvR1JIOC9odUhzaXhNdGg4aysxZWo5TlIyYzJGSlloRHBhbzVNUlZuNU9n?=
 =?utf-8?B?MEFNYWxybSszQnorVnlLVXZXTndsUk1nRGlPbWF1aW1XSmVZdTF5bE9mdFBP?=
 =?utf-8?B?cUVEQzlkWnNnTUtpQXVaWmpJY0h2endpUXQvSVZKdzhZZUN2MHNtanZweUww?=
 =?utf-8?B?YjdsbUR0WFRYald6QlJaaWxtYXRNbHhicysrSzZxVlkySUpNQTA0ZkV5bTl5?=
 =?utf-8?Q?UpWjsjMTWIuC+QUNiWzPswKr6Wstxrjgl86eRBFAmf/v?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d79be166-9ef3-4f82-ef8c-08dddeba4883
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 00:49:42.0461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DCBW9VrcRvAig9b8JDFV88a3bGlpXviRneFYyCTXQTqQHwpXfvKynLwB77/NRKQhQJ6jZOWkcPFN8qYo2+PQHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5707

On Sun Aug 17, 2025 at 1:47 PM JST, FUJITA Tomonori wrote:
> Add read_poll_timeout function which poll periodically until a
> condition is met or a timeout is reached.
>
> The C's read_poll_timeout (include/linux/iopoll.h) is a complicated
> macro and a simple wrapper for Rust doesn't work. So this implements
> the same functionality in Rust.
>
> The C version uses usleep_range() while the Rust version uses
> fsleep(), which uses the best sleep method so it works with spans that
> usleep_range() doesn't work nicely with.
>
> The sleep_before_read argument isn't supported since there is no user
> for now. It's rarely used in the C version.
>
> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Reviewed-by: Fiona Behrens <me@kloenk.dev>
> Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

Tested this with nova-core, and it seems to work fine!

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Tested-by: Alexandre Courbot <acourbot@nvidia.com>

Just one last comment about the documentation below.

<snip>
> +/// Polls periodically until a condition is met or a timeout is reached.
> +///
> +/// The function repeatedly executes the given operation `op` closure an=
d
> +/// checks its result using the condition closure `cond`.
> +///
> +/// If `cond` returns `true`, the function returns successfully with the=
 result of `op`.
> +/// Otherwise, it waits for a duration specified by `sleep_delta`
> +/// before executing `op` again.
> +///
> +/// This process continues until either `cond` returns `true` or the tim=
eout,
> +/// specified by `timeout_delta`, is reached. If `timeout_delta` is `Non=
e`,

For precision: "This process continues until either `op` returns and
error, `cond` returns `true`, or the timeout specified by
`timeout_delta` is reached."

> +/// polling continues indefinitely until `cond` evaluates to `true` or a=
n error occurs.
> +///
> +/// This function can only be used in a nonatomic context.

Here I'd add an errors section:

# Errors

If `op` returns an error, then that error is returned directly.

If the timeout specified by `timeout_delta` is reached, then
`Err(ETIMEDOUT)` is returned.

> +///
> +/// # Examples
> +///
> +/// ```no_run
> +/// use kernel::io::{Io, poll::read_poll_timeout};
> +/// use kernel::time::Delta;
> +///
> +/// const HW_READY: u16 =3D 0x01;
> +///
> +/// fn wait_for_hardware<const SIZE: usize>(io: &Io<SIZE>) -> Result<()>=
 {
> +///     match read_poll_timeout(
> +///         // The `op` closure reads the value of a specific status reg=
ister.
> +///         || io.try_read16(0x1000),
> +///         // The `cond` closure takes a reference to the value returne=
d by `op`
> +///         // and checks whether the hardware is ready.
> +///         |val: &u16| *val =3D=3D HW_READY,
> +///         Delta::from_millis(50),
> +///         Delta::from_secs(3),
> +///     ) {
> +///         Ok(_) =3D> {
> +///             // The hardware is ready. The returned value of the `op`=
 closure
> +///             // isn't used.
> +///             Ok(())
> +///         }
> +///         Err(e) =3D> Err(e),
> +///     }
> +/// }
> +/// ```
> +#[track_caller]
> +pub fn read_poll_timeout<Op, Cond, T>(
> +    mut op: Op,
> +    mut cond: Cond,
> +    sleep_delta: Delta,
> +    timeout_delta: Delta,
> +) -> Result<T>
> +where
> +    Op: FnMut() -> Result<T>,
> +    Cond: FnMut(&T) -> bool,
> +{
> +    let start: Instant<Monotonic> =3D Instant::now();
> +
> +    // Unlike the C version, we always call `might_sleep()` unconditiona=
lly,
> +    // as conditional calls are error-prone. We clearly separate
> +    // `read_poll_timeout()` and `read_poll_timeout_atomic()` to aid
> +    // tools like klint.
> +    might_sleep();
> +
> +    loop {
> +        let val =3D op()?;
> +        if cond(&val) {
> +            // Unlike the C version, we immediately return.
> +            // We know the condition is met so we don't need to check ag=
ain.

nit: this comment looks superfluous to me, this is a different
implementation from the C version anyway.

> +            return Ok(val);
> +        }
> +
> +        if start.elapsed() > timeout_delta {
> +            // Unlike the C version, we immediately return.
> +            // We have just called `op()` so we don't need to call it ag=
ain.

Same here.

