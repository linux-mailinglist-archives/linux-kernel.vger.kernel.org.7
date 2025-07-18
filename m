Return-Path: <linux-kernel+bounces-736859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BEAB0A443
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 14:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABC09170F7E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 12:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6422D9EDE;
	Fri, 18 Jul 2025 12:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AgAkpOed"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017F523A563;
	Fri, 18 Jul 2025 12:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752841973; cv=fail; b=LR/w1impaLKuhz7nR42JXgYm7cnrEYFoGdtw34tAVT3qf2Uia4WKdqm+J+YsJ/hfIgHodBgllHwtq50UB29n2+xf+kM3fhYsNS0BaZAV/H6B3milDicqYrLBUJCw8LJCPnPUEAqfd7pUuqIKn+olPmD9Nnsws14rTS2YkuwFgVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752841973; c=relaxed/simple;
	bh=ddTOUxkqBbuhu7CTYhCdLITHWJGaX7wF8Jy4XMasvgo=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=rRsGleBik8vN3BnEFOK++jiYumsmjvmH4Z/2EBR8OeCqxoipoVcEe1QXrplLdDOJbvxkwcnqzd6DR3409iNM5ptfYsjTNiYLJEOei0VnTohdGK/eaMQd55FL9i39AaGUbwsdIgHIVZSHhQpE517CoCXNU+KHbN/oRQrpSSBwkQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AgAkpOed; arc=fail smtp.client-ip=40.107.236.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j0Um669a9suhSHpvCFz6stNcua5Uevry9ahfLT4c+K6fxHR+GzC7eVcQcS587N/1MTnFjvwcM+Qq4DMe2fb4X3/GqOEcWW2Aybp0Wx8xzUEqOk6rzuUDM3KagU6R2mNQKVCe7m05dyL75UzcF3jqVba84cEnJ8ikBcFZ+nmCsybKH8ydY3ZYidSxNEWCs6nNsub8uRrq2o+oNlOuRIy/Q+7Cs3g5ji6Gkq0IuOfMorB5APLD2QEt20fn2vilZIcc/A+a+BU79vQOzAUl5JSd0OrxZwIuC4/Sr/INyX0vaj+v3RKTxri1CMLRKWktq0UI5dMP9Hs9LQxNsyKPq/mdxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RduFvMBcWXrNNLOXTGw7H4pLQXTkV7Jbdm30XPukERo=;
 b=isBenzm1L79sB0Z/u41w36LfnCfhZeSl3D3WIoC4HShmuHx3WCz2L01s4rlpHkfNyGWTM1Hl2w7KMDnvr61vqDqMGdD/lMEWgTkLNkUySysqxPO5eWxR14rf69/rM1HkF2W312Xwh+JpnddHpmvuPSR906SU9qRpUiUwpHt5XSB2pg6yhY2wCeMh6ukXJiNEDy6P4Z1M+zMVzSTlfefphWlkH780wiQgGBL8eRZSeFTQDfdGYuILrj3vdvEN2S3zu4sPH97zcmtP3oL+7+C+jz+vUXgjFiXWFnjgJe0vXU9OabUphHyEC+G4VlbbGYitskamMxOGgCNRPGjDFfn94w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RduFvMBcWXrNNLOXTGw7H4pLQXTkV7Jbdm30XPukERo=;
 b=AgAkpOedG/8KQXKwxzBjYmL7bO/fLEd+MMM8wYHDzO3UjXS0XoD7GeZHihvM7PCvLwOXK4lI2FZHzS2oeSGX985D5BH9NiET7vJOQZLBtu78A2XquJ0uaIVrU09MhzrYbo7LJwGneY8OffwOkJyWDjfTEasLMuo8aOo+KvSt5K4XSOlqzgD3LNZiagYnzU2T1InZBtbJFcEuZBO45KcYUdnDDC/MAlCXcb39HoIDx+epbZCoMAfuN9kBFITh6QUbvudF/Hfc5RErItz8ddCisiODT/D/kkLhhByAuV9hsKmS8Z+Yxo+PHTu+MfG/82KodLDX7G8sVQLBmIWKoMGWFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by IA1PR12MB6282.namprd12.prod.outlook.com (2603:10b6:208:3e6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.37; Fri, 18 Jul
 2025 12:32:48 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%4]) with mapi id 15.20.8922.037; Fri, 18 Jul 2025
 12:32:48 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 18 Jul 2025 21:32:43 +0900
Message-Id: <DBF6M9BZUX3C.2VXBZJKQYGN84@nvidia.com>
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] device: rust: documentation for DeviceContext
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>, <gregkh@linuxfoundation.org>,
 <rafael@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
 <tmgross@umich.edu>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250717224806.54763-1-dakr@kernel.org>
 <20250717224806.54763-2-dakr@kernel.org>
In-Reply-To: <20250717224806.54763-2-dakr@kernel.org>
X-ClientProxiedBy: TYAPR01CA0129.jpnprd01.prod.outlook.com
 (2603:1096:404:2d::21) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|IA1PR12MB6282:EE_
X-MS-Office365-Filtering-Correlation-Id: 844284fc-3470-4080-cfd8-08ddc5f73322
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|376014|1800799024|7416014|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S3JaSTgrWFBmUy9WOWtrV2dQekhKU0N2TExlREdSM3BwdmxJNFRCYU1hQU1i?=
 =?utf-8?B?a0xhY29vVmxkVytEL0E4OW84UkhKR3JOL0RpWFVMNlQ4Y1JHTmUwQjBJcHE4?=
 =?utf-8?B?b0UwYXBJVnByWitqQVJ3eCtGRGhqd3VhTEtUV3FaM3BDK1dYYlpmRFNVQnJM?=
 =?utf-8?B?TUc4ZDFWeEYyMFFKYkloT2xRUmJVQUJ1RmhNQmN3bmVidlBnd3JLK21BWlRV?=
 =?utf-8?B?c3hUaW5CaHVJWWRsSXpXMVRRQ0xNR0ZzYjQwcXI0OTBqc0NpcWY0Sm1GMUJU?=
 =?utf-8?B?S05wczllS0p2MTllb1BHY3Q4QkovVnFBTnJVdkJBVFBRRURrRm1pdktmL3ln?=
 =?utf-8?B?eERtYUI1WW5FQjlhQytHN3lKRWJuY05JVEo0aThJZEdYVDhGY2U1TDk0cmhy?=
 =?utf-8?B?d0FLTXQwWE1FRzE3Z3hWM3U5cDZUNzR5MUdZWWlqcWFhTmlpWDJwaTFRdHlk?=
 =?utf-8?B?UFJ5M1hjcVZDemVJL0RiU2tjcDF1Mk9sUUFkdUFtVGxENFdDakk0Ukh4UVNm?=
 =?utf-8?B?NitIcG9uWmxsd3NReWV0dFh1bDQ2dC8xc2VVOXgvN0JVd2NZRjlWQXorL0F5?=
 =?utf-8?B?cFRGcXE2YWI0cnRqWitKMVdsbFdUZFpWNHBCcVhJamdkWmVTbVdhaDhWNmg5?=
 =?utf-8?B?N3QySGNkaWRlZkxEN0x0RS9pUUNPcUFEODZicUMzREw2NHJBLzkwQXN0ZVNX?=
 =?utf-8?B?SFBpQTZzaWFTVll4SE5kWlZrQjRhU3FONzNEYmJJRjZMWVI3RmFGYXhEa0dj?=
 =?utf-8?B?TGFjVzZvd3M4WkJSSE5ER3Qrc2hCQ2Y2MFRkalZrd2ZkcjROaEl2S0JVdmtq?=
 =?utf-8?B?S1BEYjExT1NnM0NacGFPaDA2RGVGMnhvRzJCUmtoVE9OSVpjZGR2YXh1MXRa?=
 =?utf-8?B?WjVDdVZvQkNhVGVrdmdSakNpaXgxWjdZVk9JOE1mUGhWdWtHbzBsRFR1VlIy?=
 =?utf-8?B?Nk5EckMrZ0NkeGNHRE1JaDRQMllZVzF3TVpTZWtQYnFKMENVR3VTeHU5Zm14?=
 =?utf-8?B?N2ZIQm9IRmxQVVBSN2xtbFQyZXR4L2NUYmMyVUYzbEwrbUFLVlFNODdrRkNY?=
 =?utf-8?B?RkRQWU95dUVZQVUzYjBqWTRsMkQ0UXIvRjhxM1p3OWFOV2hhWWowVzZjQldZ?=
 =?utf-8?B?VVphVUhMMlRqcFBrY2xqdFFuVEVZM25hSi8yS2x5cjl3TENCNDZ0blJlT0tX?=
 =?utf-8?B?Tm1CdTAzZ2FRVElrRVpzcFM1WnZtZTF0ZXRjZExRSVVzcUlsUkFmZytBK1lH?=
 =?utf-8?B?U1VFTThpZ2Z5ZUk0d1RMQktCUCsxaENyU0lEeVFMUEJ3TkZ6YW5iUzJXQ1Uw?=
 =?utf-8?B?TDhLVGdRalc1SHpZd1FMTTdMeHhOMFBjOG8vV3BNdVpDOTJDZmxiY0kvWVdo?=
 =?utf-8?B?WnZTTXF1RDh0UHVVS2hnbDNtM29xOVVIVW5ia2NkNVQzZEVPWjRPaVhwd2ZH?=
 =?utf-8?B?RUtyUVVxNVV2YnlJZ3p1RmpOdU5vKzNURVlDYTBONlU3dGExY2UyQlJ6U0V2?=
 =?utf-8?B?TXg1VURBTUQrNEkveUtFWDdjcCtDU0NNQ1RGRjUwRzdPdTRTbDd0WjY1TjBY?=
 =?utf-8?B?LzZ4QzhrdFhvWkZkaFJpVUlidStDNUhLZmZ1ZERkWTRPNnpHZ2I3QU0xTXNs?=
 =?utf-8?B?VGtBUHppOGdRUzJFdWk2MlI5QzNsMXV5Um5lOUp1UzBPMmNFdkJZSkdaV0h0?=
 =?utf-8?B?MUZFVEw0Z2hNekIyWXpZWXlsZUQ5SkpqWUdyZGd6SXdQdms1L3d5UUZQQ3hS?=
 =?utf-8?B?ZlFqaXpKWjhMQ1JOa2x3WGk4akJhNUJXYVRxdDJGSDV5bFFFVERXUnZVYW15?=
 =?utf-8?B?d3V2cmpLV3NWQndmYlloM0V5RWlzN2Q3My9QclE2NjFhV0lKZy9hNEhkTE9K?=
 =?utf-8?B?U2FPMEJEVlB0dXJFYUhRQm1KclNCa0FQUlBEUys1ZGY3ZVFMeFBFVXdOeGdR?=
 =?utf-8?B?QmhETTJiR3g3YXhMNWxjZG5OS1NGRDI2dkUrV3NLVWYwa1dWOWUzeUxiSWhr?=
 =?utf-8?B?M2UyYUs3Q0RnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(7416014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SDRKRzRTQlorNyttV3lOQ2t3dVViZUdrNGgvekJiVnRTTnhEOXdIb2REdUpr?=
 =?utf-8?B?cWtXMit2VWx0OTRzQ1hlMkV4MXViNFpZN05HRk5NVkExdXltN2RUQlJHYmtR?=
 =?utf-8?B?TngvMWsvSE1MUEE4STdyZWpGOVVaTFJobFg2TkFhd0QwQk1iVGgwTjZvaGxu?=
 =?utf-8?B?SSswV1NqdS9GNDhNdElZMS9MMUE5WVpyVSsrZTZxanRRT2pyTllWYy9mRXRH?=
 =?utf-8?B?b21icnJOU29lN21NcWhBQVQxZWFTWnFFVWVMbWs3SUN3VjA1RE9GTmQvSWdJ?=
 =?utf-8?B?a0NqU09FYnVOd1BtT3RUUTJwSWR1dEVMbU1IckhBbW1DVUI5YXg4QnpVZkVN?=
 =?utf-8?B?OWNYRXJycFJCMmdEbURhdDB1WjBvamk1aVR6SkF5akpHamd1QUpKYkxBZU9K?=
 =?utf-8?B?WUJmNFAzekxtV3VtVTBESUFKd1d0YitTY0VwRVRRTy9tSHNGRnlYOXc1Qi80?=
 =?utf-8?B?YlBlZnNsUlZibE41aklsM1dZT1llR2Nibk51SEpjd2RIdUovSHlBOGtaZ3dt?=
 =?utf-8?B?MlNEOEd6YmFIVElpSHpyUU41Y1NJTFFVbDhUREd4TUV1SFpIWCsycGt4aWE5?=
 =?utf-8?B?NWxZNU5FeFZCQkNlWWJkaFptckJJRlpTZ2o2eTZ3eVA1dGFrckpzQTNoek1R?=
 =?utf-8?B?eGgrekhjNHA1TmNwQVFVK21SQjdGV3BJMlIyOUxOUW9PbjFWK3cyVXlyaG5R?=
 =?utf-8?B?MndOYmpiN0RsdXJEb3Z6NlVsbXd4c0YzMVZaUVRaZWlXMFA1MEE4MkhUMHk4?=
 =?utf-8?B?ajdBVzh3MWE0WUp5L2FGYkNTMHl5cUxNa3doR09DWmt4bHBLTHJybjArU1Jp?=
 =?utf-8?B?bkt0RCtObUNISE1vcEJEdk5MekVUMHZUTjRQUW5MV0luT2FCamFRVWE3bWFP?=
 =?utf-8?B?YW9OU1V6dmFjOTZGN0NvOUtUR1R2Y0t0S0RLRllCTjdSdFhEeGVOelljQkJU?=
 =?utf-8?B?QkhadGJSV0h2QXpvZEpqT0V1UW1GY2pjT2xOaklhQ1Rzay9DTGw1eFFBem1P?=
 =?utf-8?B?WjJzUTdqTnhxbWNzbzFoMkk0QkJRbjZ1RmlaWEZsLzRrVytEVFdKbXcvdjJs?=
 =?utf-8?B?NW1ESU9ITHBDc0VwTi9yVHhFTTF0RERxVVBtRU1xK2dVZDNINFBobHZnUk9h?=
 =?utf-8?B?VTZNMkFtU3loSm1LaVNkVm1MS0kzcktmdmNrZHlUNXNGL096dmlqb2pwM0Uy?=
 =?utf-8?B?bUV6RlRHY2FrYW41dk00MTFWT3Ryc0pDVE0xT2N6cG5wRTlPeURONG4wNGtH?=
 =?utf-8?B?SHdUNi9pQWpkTUdBSm54ZnZEdUtBZHBqdytmcjMyOEtJbHc0RGRvVzZheEdr?=
 =?utf-8?B?VmpqcFV5OW11NXM3eFhyemJQN1JLNnRGK2NBRG40WlhjemZGTkpUMmp2dWlU?=
 =?utf-8?B?cnVzcUZ2TmwwOXJoR0s3anFRN3FoMys3UmdvMVVSQnViYys3dHR1cm96Wnl0?=
 =?utf-8?B?RFh0SHB4d3hKYTByaG5ja1k0dHhaSHArQW9HQjAzbjBjaDZEWWlOYWNxSFFh?=
 =?utf-8?B?Yk5IaWwwbmxsWlIzd1pxRUFxdnh3RkFJTS81UEhzTHR0MmFzdWVkK2VKV2Nn?=
 =?utf-8?B?Z2U2UGJUTVQ4VGlZNWcyTlZ5SC9wWjdPQzJMdktvM3RMVy9paGtEUGtDMHd5?=
 =?utf-8?B?VXFOeXpUd2taYjRnVEhXMU1qWi9KeGNkSHpWU3NTWFNIWndHOEYvN0VDWXdG?=
 =?utf-8?B?ekZRbHd6MUROdDVEYzZQYnVMOGhJeXFWKzYvaXNjQWRXV01PZEhCcUlaZVl0?=
 =?utf-8?B?b2FBVjZJR3NXeEpwVE93OHdUL09HL0I0cFVXSHVvdUtHWG5GQ0ZTU3VtZ3hk?=
 =?utf-8?B?d1JiR0VUN2kzQis5dUduWnFVUWpFN3JxOFhmYWxwbU1MOHNzZlY0MUdicnlL?=
 =?utf-8?B?dDN3VnJJckRFWnhxeTFVWGVQVzZVb2hjQXd5elJGejFZVXk2cy91M1hpR2ZC?=
 =?utf-8?B?dVhINFpKTXFDaVB6NlFOY2t2Y1FTNTZqSmlKZnIzQWFvVUtCMHQwWUd4NnhU?=
 =?utf-8?B?Q3p2UzBoVXpibk5pZ2RxU0VsdlhNN1FKTk9POHppbHlGRVJ4OEZGd3kza29H?=
 =?utf-8?B?U2M5M09RMVJ0ZlJVRHFKcWxpL3BzdHB4VEthRTQxY3FFOFRpdm90emVBMW5l?=
 =?utf-8?B?Z09hdDZsckMrZXpGV1pYeXRaTWY2aGk0MEN2ZWVGVnBEQWlaYmdtL1NKT3gw?=
 =?utf-8?Q?39JVqz7Kb3XF4cAvPZTnl+h0SqN6D2dO/WdWHSiOdag/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 844284fc-3470-4080-cfd8-08ddc5f73322
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2025 12:32:47.8350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jHqcOUC8xJLOeb0Li/Sdi6/hxqpjsyJW6M7TFQIo+es18WIgYjJ2WAdOhL5jCNfDKCS+TJRDLTdxABSBbZfg6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6282

On Fri Jul 18, 2025 at 7:45 AM JST, Danilo Krummrich wrote:
> Expand the documentation around DeviceContext states and types, in order
> to provide detailed information about their purpose and relationship
> with each other.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Thanks, that's a welcome clarification and I think I finally understand
the Rust device model after going through this series!

A few minor nits/questions below.

> ---
>  rust/kernel/device.rs | 63 +++++++++++++++++++++++++++++++++++--------
>  1 file changed, 52 insertions(+), 11 deletions(-)
>
> diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
> index ca82926fd67f..d7ac56628fe5 100644
> --- a/rust/kernel/device.rs
> +++ b/rust/kernel/device.rs
> @@ -311,28 +311,69 @@ unsafe impl Send for Device {}
>  // synchronization in `struct device`.
>  unsafe impl Sync for Device {}
> =20
> -/// Marker trait for the context of a bus specific device.
> +/// Marker trait for the context or scope of a bus specific device.
>  ///
> -/// Some functions of a bus specific device should only be called from a=
 certain context, i.e. bus
> -/// callbacks, such as `probe()`.
> +/// [`DeviceContext`] is a marker trait for structures representing the =
context of a bus specific
> +/// [`Device`].
>  ///
> -/// This is the marker trait for structures representing the context of =
a bus specific device.

Shall we say `types` instead of `structures`, since these are ZSTs?
`structures` carries the hint that they will contain data, when they
don't (but maybe that's only me :)).

> +/// The specific device context types are: [`CoreInternal`], [`Core`], [=
`Bound`] and [`Normal`].
> +///
> +/// [`DeviceContext`] types are hierarchical, which means that there is =
a strict hierarchy that
> +/// defines which [`DeviceContext`] type can be derived from another. Fo=
r instance, any
> +/// [`Device<Core>`] can dereference to a [`Device<Bound>`].
> +///
> +/// The following enunumeration illustrates the dereference hierarchy of=
 [`DeviceContext`] types.
> +///
> +/// - [`CoreInternal`] =3D> [`Core`] =3D> [`Bound`] =3D> [`Normal`]
> +/// - [`Core`] =3D> [`Bound`] =3D> [`Normal`]
> +/// - [`Bound`] =3D> [`Normal`]
> +/// - [`Normal`]

That graph is super helpful. The last 3 lines look redundant though,
since the graph can be followed from any node.

> +///
> +/// Bus devices can automatically implement the dereference hierarchy by=
 using
> +/// [`impl_device_context_deref`](kernel::impl_device_context_deref).
>  pub trait DeviceContext: private::Sealed {}
> =20
> -/// The [`Normal`] context is the context of a bus specific device when =
it is not an argument of
> -/// any bus callback.
> +/// The [`Normal`] context is the default [`DeviceContext`] of any [`Dev=
ice`].
> +///
> +/// The normal context does not indicate any specific scope. Any `Device=
<Ctx>` is also a valid
> +/// [`Device<Normal>`]. It is the only [`DeviceContext`] for which it is=
 valid to implement
> +/// [`AlwaysRefCounted`](kernel::types::AlwaysRefCounted) for.
>  pub struct Normal;

`Normal` as a name can be interpreted in many different ways, and in the
case of a device context it is not clear what the "normal" state is. I
think it would be helpful if we can elaborate a bit more on what this
implies (i.e. what concretely speaking are the limitations), and if
possible why this name has been chosen.

