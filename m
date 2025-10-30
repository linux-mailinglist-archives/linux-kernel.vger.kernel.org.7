Return-Path: <linux-kernel+bounces-878800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA7AC217E6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 07E004E020F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F178936998E;
	Thu, 30 Oct 2025 17:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JCUiyhql"
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012058.outbound.protection.outlook.com [52.101.48.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D49E368F51;
	Thu, 30 Oct 2025 17:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761845352; cv=fail; b=mq1JadHyG14G5IGW8G0U6bWLyTTrkRSe03AjZKSH2FaSxT2zUZ1MHtn6MHeyJcgL6U1ZPa+qVksZYP75D+SRjLdexptLLt36va9UaqRJuvyLOhdaC7+IcCjVB7iF3waYgNlqV4yAA7hTQNX2YnHwVDyNc1xLT5F1NjKFHflsrAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761845352; c=relaxed/simple;
	bh=PHC3gtw8mT680OCu21EHsm3zEi9ECOj9XoOQUeX4htI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=moDcIPBZsGbLBXPQnQbjVMC5abvne1XTDa4R/YsoLGzgFq00JeOj3/qiJ+HAtTtxZYrJivTl+3Z62xiXlPs3l0UlP/SLmf2sf+kycWme0ZZmjcTEuzNG1WkpOh2QYrIyDvb9n02I+X1A1HuVD2UYBle5UYhGJpMh7HG7FTx+9X4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JCUiyhql; arc=fail smtp.client-ip=52.101.48.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q8DwEHvwaFjrhxc4/RCzm+9xermb6vvJXk6lOYjXebCyLF+hCtgNk/4GrAYO2TuyYNhP0mcjVozF1ymAe5dOK5+SBBGf1ZYqKBb7XSiM9Nt0W7q1sd3P9RxVRW26pa3btcZRb89uAUKn9B6mTLJw03Tko/Djvik4ZLiuh0McxIQBoO7g/WKEwQdAOzEcf8+jR/ZckxJaKFEyU4H5CVfZFrQW34HUEql0zBmJiF+ksuTpxAKlXwl2CXIv+zRb+40+BGySJr9hV2W/8VeI0C0bRlNeaG6170Uv0hGW6+Flvmmu7vTAVcNUaYIHEFoSAxYdY5OlfxmSHPphPsIx2CaBqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PHC3gtw8mT680OCu21EHsm3zEi9ECOj9XoOQUeX4htI=;
 b=gx0mSCV427L7oa3VQ3NupOgybzlfqASh7C3N9OuZtkxpgR+SDu1mGGCWySH3H8VaFNHHu9/RHJO1gRzGvZo4QBbs3Oj6xPjOiSwcf4mOoUHCML/6FIpsi8LN6RPHh5RY4JtLQFUdSGwNaUOZ43HxoXXFx8QHmypvuBe2iBmESqpDMFBTWlrtBD95dbgaZ7BlyPS6cFu0SmwcmdUywtcjBul8jeX1j4Ioyb5DXdnx2L/+T2MwbBJS5MHqJiDBW+Y//9+bhUL3NcoVF54y5oMqguuNNiOXotrlNSqUq/Asl+iKCRG9qEVIiO37u9SLcMFasBTW76ErkdtE6g/+1nt6/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PHC3gtw8mT680OCu21EHsm3zEi9ECOj9XoOQUeX4htI=;
 b=JCUiyhqlWroLovL4pFg/lLxyRZTVpHKZBQdtLn77JfgupABeZqHF9aY3zc4ba0fdGep1zoiUKeBn5pE9gsNzDNkYJKsvzBSmRQiH2LDrVt0WwhzHm3t2yUroIDsdC+np+1X/eIQiG9XPhGWOjqRxQpi+88Xk9Euf8oTrK/xSfp3ZuiSWKrpy944QLpeQ0VpPhh+RkR9I/J3/p5vYM0WPpjZPeAqbM7Wt7kQBdiELVGYnqeRvXuvojgp9x/bL7SgYQoh323wAROBnon8kWyN6+KVkTryQgmQWRr3OSSfdcacXUI7G76WyIbJdx/be1jELwgAj9n34G78IGZGja/NAXQ==
Received: from SA1PR12MB6870.namprd12.prod.outlook.com (2603:10b6:806:25e::22)
 by CY5PR12MB6348.namprd12.prod.outlook.com (2603:10b6:930:f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 17:29:06 +0000
Received: from SA1PR12MB6870.namprd12.prod.outlook.com
 ([fe80::8e11:7d4b:f9ae:911a]) by SA1PR12MB6870.namprd12.prod.outlook.com
 ([fe80::8e11:7d4b:f9ae:911a%3]) with mapi id 15.20.9275.011; Thu, 30 Oct 2025
 17:29:06 +0000
From: Zhi Wang <zhiw@nvidia.com>
To: "rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>
CC: "dakr@kernel.org" <dakr@kernel.org>, "bhelgaas@google.com"
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
 Fernandes <joelagnelf@nvidia.com>, John Hubbard <jhubbard@nvidia.com>, Jason
 Gunthorpe <jgg@nvidia.com>
Subject: Re: [RFC 0/2] rust: introduce abstractions for fwctl
Thread-Topic: [RFC 0/2] rust: introduce abstractions for fwctl
Thread-Index: AQHcSbbLcKvr0HPVKUCbR1f8uxQc97Ta8fOA
Date: Thu, 30 Oct 2025 17:29:06 +0000
Message-ID: <8e0209de-5be3-4d41-807f-1b7e73aa3d1d@nvidia.com>
References: <20251030160315.451841-1-zhiw@nvidia.com>
In-Reply-To: <20251030160315.451841-1-zhiw@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB6870:EE_|CY5PR12MB6348:EE_
x-ms-office365-filtering-correlation-id: 665362cd-d9f4-4fd7-b8d7-08de17d9d3db
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Z1RBQWcwdHl2VUZsMHZZRS9NQVQxa1BmZEtodW1UMWkwa2cwb21aQjAramRI?=
 =?utf-8?B?eUc2Zzc1US9Mc3ZHNWt0bGp2T0laS1RMc2JZSndNNUs5Znh1OEMxdHphc05X?=
 =?utf-8?B?ZExjcVpoZVM3TFF1ZU4vVFhxdCtML2ZkemxFeGdaTTN5UW5LallJT3FaOFRR?=
 =?utf-8?B?SEhQNGFUc3FEeVczeElMWXFVMHNEOW1vQUk5WWRrQ2ZKci9zS1hsS0w4SVhv?=
 =?utf-8?B?a0lQMmhxbmhBYXovSU9rbmYra3FZTXNsSXJwY1dud1FzamY2N0Zjemk2aUk1?=
 =?utf-8?B?YVBqMWJENzNBK3NXdGJrTysyZ3J4Z3kzMk0wVVRDMy9UN0w0ZXkvb0hzKzFv?=
 =?utf-8?B?UXdFcDJmQ1ZtSEdvUHdBN1ZSQVZWaUx6U1ZVSzg3UEc1R04rei9kUVlxMVRF?=
 =?utf-8?B?VWg1TFVKc3lyTzIrRVhUWGNCR3RwanZXMFdKTFg2R1I4WkZOMHBCcGZGUlFV?=
 =?utf-8?B?Wk5NRkZyQy9RUnBrZzROVFpNUjV2aGFOUzdvL1k3VEVFcnVESXBVUmk2Z1BR?=
 =?utf-8?B?QkJhdFUwbzN3RFlnd0tEVjNWVUdDYlR4TVBsTmo3Ky9MVzlvd2JQLzR2dng2?=
 =?utf-8?B?TWg4NE4yN1QxZlVidk1qS1NnRU1BQ245TndjMlQ3blNlRWhCaU44WEpLL3Nx?=
 =?utf-8?B?dmI0SC92Wmt3d0FkVzNpQlBkWDduYUhFN2R0eTdJdXRsNXhFV2tidUc1WG9F?=
 =?utf-8?B?WGdPYTFNNUVaUEdDbFpLb01reElsTlRMSUI4c1BUM3lIeGw5WU9lQ090bFR0?=
 =?utf-8?B?R045OEdtdmF0VnJjV0RlS1JGQ0tkcWlpbTB2YXlOZ2luVWpaWlUwRkdxZ2hL?=
 =?utf-8?B?M1NNTXNhU241UVBYUTZXTEJib0cxVnhwSFJha3RsNS81WWNNd0lEbituVVZV?=
 =?utf-8?B?L0pPSnJvM0VnV09UaGI0NUV1eXlFbmdQSy9Jai9MNlVZWDlleGRSZ3pWWERS?=
 =?utf-8?B?TnJ1MjNGekZ4ZHZUZ1V6bHR6b3AvazBWM1dUYnJ4MFBBczFtNkRreDUyVDJV?=
 =?utf-8?B?L0NJellieW9JZVBnU3NsMStFMitLV3hyOTBsby8rQjRWVDVuNkttaEgzVHc5?=
 =?utf-8?B?RUNuWjVGNFZ4aWUwTGpwTnR4RVcxTTZNU0dEajYrejNWS3ZCMkNDdzkxUFRv?=
 =?utf-8?B?QlVhSXljUzBlQ1pwMVRxR0hZaC9OajliQTJ5ait4Z3pUOVZQUk10RVR6Mjg5?=
 =?utf-8?B?MkI0dWNZN2ZJUEhNdGFwV25NR3dITWhrZzlWK0NCdFN6RnJ4VUxNZGJBRHpU?=
 =?utf-8?B?Z3h1VEZPQ3dxNWMyaS9GYzl4N2NwUWQ0T2IvZ0o5OU16SDZmaEVrYVVWRHNC?=
 =?utf-8?B?ZEpaNjVHbjBld2crSWtQK25Hc2RYMDVhZzBtazVWdFMvTGpIc1g2K2RmUng5?=
 =?utf-8?B?bzF0dG5oYUc4OEN6VXd6aVBWczNoSFgwbUFKREErSHRGMTdzd3kvV2E1MDQr?=
 =?utf-8?B?NEkvZ0hIcThBMFExLzE1ZmNLSGIvTEROUE5XQ1Yxa05kd3hOQ3F3R014NEl1?=
 =?utf-8?B?WkZROUc4RVEvSDNNMFN4VDUycEZjOUprenBrc1IzZFdoVGdCVVJkdGppK0lj?=
 =?utf-8?B?NG5peVpPOGs2TndwUStJVDRVQXBaaHd6MVRJcUlmcitEQ1JFdFA1MmRIRUJs?=
 =?utf-8?B?RXVLNnVMckpUQkFxWHdWTVlpSHo1M0FMdDhsT0V0c0dKL21YYmo3YzN0T29o?=
 =?utf-8?B?ZWZXc0l6TW13dkprdFB1RXhkZ0V5ZmNGWWh4Z2tQV3VheEZxV2JhdkJpaWtx?=
 =?utf-8?B?K1BXUW5Ob0VoWklua2lEeVROdTV1RzZYQmI5cXJ2bG10Yk14Mk1OSGNEd0Rl?=
 =?utf-8?B?eEpRdlJ6UWdLQWszdXNIYm5IZzVQMTk1cFlyTVRZOTFScEdYS0RvUlIzdnpy?=
 =?utf-8?B?VHVrYVNvTUFCaE1JejBEUnlSdmdXMGw3WjRid2JnWXoxb095bWk2ejRJNGR1?=
 =?utf-8?B?ME5xb1lneWlHOXRRSjVxMkVZVE9xbWg4dEpab2hYeDNSaVBrWklyQS9wSWVL?=
 =?utf-8?B?MHNHKzhBalFTUnVWeGREVUFJVUJWZFE0MTFJaTM1MXRyVG1kNktzRlNiZ1Bl?=
 =?utf-8?Q?fOkBHt?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB6870.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VlkzSEViSDBNMXpmNC94V2drSkRVdWZJYW9kN0Z4bUxoZEZTMkw1VVEwVXd1?=
 =?utf-8?B?TkNlbzE1ZDB0WTFLMzkxVlVORlZGZDhnRm8yS1FuVkpDYTFDd1RvQjdKWXNa?=
 =?utf-8?B?MUhLbVJxTDcxb2JtckxjVkEveFNhTUE3VVBwYnVNYlQxQVBTNkFrcWVoNW5k?=
 =?utf-8?B?Mzh1VnIvSk5haDFOL1VhbEJnVmZzdWJQSXF6d0h1RXhJN1B6Q3VSQ0liL0du?=
 =?utf-8?B?QnF3ak51QWplbUdEQVFUMmg4ZU9rM0FTWXRqSnVoRnRPSDUyam5MNVZuV3Fx?=
 =?utf-8?B?K2hVbjlHemt3RGRFVVNaTlBGMXNJelJPZXh4UzY2a2d4eDMrZFE5dm1ucUJJ?=
 =?utf-8?B?MHdtQlJhWW1CbnVMMUxWRGNnekRvYVgzM2VsS2p1bXd4bStDbC8wRFU1TGRy?=
 =?utf-8?B?VzJYZmxDdFlvbHlibnU4blRLaDVRVUtTeEx0Mi9oNHlWL2UxQktBaklDclpq?=
 =?utf-8?B?TWlPYXhTMFdUZTVYb040QUVWeHg3WFg3ckZtdmUyYUFzOVpyWWVYSEVNeEhy?=
 =?utf-8?B?RFJpVzBSR1RkVGxZK3gvZXFxRjNvNnZSRTdkYzlHVEhhbUNweWlab2hwUURC?=
 =?utf-8?B?Tmk4WjlPN2t4M1JOK0NlUFZIL2swblBqZnFidDJrSHFlMkhlZEV3WTk1aWcv?=
 =?utf-8?B?Z3NBd3B2NTBHVTIrVnRuR3lXbXJ0NXNrTng3VGlOSlAxdndxdUxnVG5zanQz?=
 =?utf-8?B?WXEwMHF2R0l2Tmpmdm1Tb0w4SGpUV3hhdGJDemtXajBiUG5CYS84UktBMjlq?=
 =?utf-8?B?N0pIWVFxTkxDYTFIS3JDMkR4SmJIQWJVZG1BWmpwUFdoMkxtTk5EaHRFWnFK?=
 =?utf-8?B?bkdEb3llTFZzQkhLeld3dlhRTGJvYkFJLzZiT0JSVFA3K0ZnMFo1VDNpMnlq?=
 =?utf-8?B?WEpHSmNpVGMyY01Xc0JWcWl1aDltSW1xZEtLUDR5TWpOaHErbFgrTTdlNWJw?=
 =?utf-8?B?a20xNzFZVVdXZHNJWHp0S1RmWmhyRUhTVERER3d0RDM2T3JpcUhTVkcrelJT?=
 =?utf-8?B?am4xZTQ5ZjFCcFp6WUh5RFFaUlhxOE5MVEZLUG9rN0cyZWcyMTc3Vk84ZWZB?=
 =?utf-8?B?bGMzRjdwaGwwMFRmWERFSkhkaGd3bFRKaFMvaHREMVJJVWlVN0orRDZ4cTZ4?=
 =?utf-8?B?MFRCR2Z2UkdwMndMRlRJS2U4eVRpTC9WK2ViVW9MNFF1Q1EySkpIdVk2THl0?=
 =?utf-8?B?dUpJVVRKYmFacnhBa3d0dmRVOCtsNTgzb21qVmplVTl3VnVaTmVxc1hRUWN1?=
 =?utf-8?B?MkR1bXVRY2NkS3ZCVjEvZ0l6YXV2eDR5VGs5bDUzOXBKVU9tVFBLbnk4ZlM4?=
 =?utf-8?B?TkROYUo2NFh3bWVTNzV1MkJpQ1JXVDlSME8wL3hVNUh1bmlHd2FvWE5Fak9i?=
 =?utf-8?B?Y3MwV2tBVmxXLzhxZzZiOWJUaUFTeDlJUlA0UlJ2c00veVJvUG5OWVcwTGZ5?=
 =?utf-8?B?TmlBcy9NY2srRHhLcmQxckJ1bXFGQWJkWmtPSkRZZEtMbXVhNWpUZzNaOTFl?=
 =?utf-8?B?WGxEcHdsamh3RkZPZzFxY2tUdVVvVWFmMWRGdGhYQ2w3Q2dUODRES3N0MVhx?=
 =?utf-8?B?YmsrZUNTT2gwb290Z0V1d3UxcFhuSW8zVGI0c0Q2bjI4aCtibE9qTTJqQmlQ?=
 =?utf-8?B?MCt1SVY4a2xJNFRpVm55dlRmUkFKM2tpejJzdEhiYzFoTklBbWxyc2czV0JN?=
 =?utf-8?B?T0FDNzlHbEg3ODdaTjVEZ3grWWRtTGdBMWtyWlRUK0xGUnR2SDJMbmxJS3p0?=
 =?utf-8?B?Mlh0TDUwdHFzNzhPbVdob29nNXhJL09OTk9SUFNXZ2lyV2hPcGFPUmNxRE9F?=
 =?utf-8?B?ejZ3MUx2ekFxdEh2TTUwZ2JPcUU0OTlkN3NSM0FQV1dyZFZtczJ5WXRYWTFB?=
 =?utf-8?B?dVpabnREMkU2T2VjekMrOEpTZjJQQWVsdHJBOG9OeEN0WE1yM1QwWDJvRGxM?=
 =?utf-8?B?Y0liMkR5UWJYbVp0ZXJNdWwxWDZZRXNsRVBVeE5odkhTTlpXWXJBSFBsZG9R?=
 =?utf-8?B?UDVGeEdUOGh0TGpBKzZWd3ZJb3dSQzRQdXJ3NW5XT3dFR3VIOHYzMkEydFM0?=
 =?utf-8?B?VVpFWlE2d1VZNGpMNzZqbnBZQldUeHowam5iTU94bGRNc3FCK1d0Z1BJQjlU?=
 =?utf-8?Q?uFmI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <31451BB0E1E923408969C9B912D1BCC1@namprd12.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 665362cd-d9f4-4fd7-b8d7-08de17d9d3db
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2025 17:29:06.2406
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 26bYnWJ6rHcKfLVk4XlD6I5HklmYjoD/JU672TQQaIVnGGMkb65YoOpkgpSeAnaA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6348

T24gMzAuMTAuMjAyNSAxOC4wMywgWmhpIFdhbmcgd3JvdGU6DQo+IEluIHRoZSBOVklESUEgdkdQ
VSBSRkMgWzFdLCB0aGUgdkdQVSB0eXBlIGJsb2JzIG11c3QgYmUgcHJvdmlkZWQgdG8gdGhlIEdT
UA0KPiBiZWZvcmUgdXNlcnNwYWNlIGNhbiBlbnVtZXJhdGUgYXZhaWxhYmxlIHZHUFUgdHlwZXMg
YW5kIGNyZWF0ZSB2R1BVDQo+IGluc3RhbmNlcy4gVGhlIG9yaWdpbmFsIGRlc2lnbiByZWxpZWQg
b24gdGhlIGZpcm13YXJlIGxvYWRpbmcgaW50ZXJmYWNlLA0KPiBidXQgZndjdGwgaXMgYSBtb3Jl
IG5hdHVyYWwgZml0IGZvciB0aGlzIHVzZSBjYXNlLCBhcyBpdCBpcyBkZXNpZ25lZCBmb3INCj4g
dXBsb2FkaW5nIGNvbmZpZ3VyYXRpb24gb3IgZmlybXdhcmUgZGF0YSByZXF1aXJlZCBiZWZvcmUg
dGhlIGRldmljZSBiZWNvbWVzDQo+IG9wZXJhdGlvbmFsLg0KPiANCg0KSGkgSmFzb24gYW5kIERh
bmlsbzoNCg0KVGhhbmtzIGZvciB0aGUgY29tbWVudHMuIEkgaGFkIG9uZSBtb3JlIG9wZW4gdG8g
ZGlzY3VzcywgaGFuZGxpbmcgdGhlIGJ1ZmZlcg0KYWxsb2NhdGlvbi9mcmVlIGJldHdlZW4gcnVz
dCBhbmQgQyB3b3JsZC4NCg0KVHdvIGZ3Y3RsIGlvY3RsczoNCg0KRldDVExfQ01EX0lORk86IFRo
ZSBkcml2ZXIgYWxsb2NhdGVzIHRoZSBpbmZvIG1lbW9yeSAoa21hbGxvYykgYW5kIHRoZSBmd2N0
bA0Kc3Vic3lzdGVtIGZyZWVzIGl0Lg0KDQpGV0NUTF9SUEM6DQoNCkNhc2UgMTogVGhlIGRyaXZl
ciBjYW4gY2hvb3NlIHRvIHJlLXVzZSB0aGUgaW5wdXQgYnVmZmVyIGFuZCB3cml0ZSB0aGUgKm91
dF9sZW4NCmZvciBhY3R1YWwgbGVuZ3RoIG9mIGRhdGEuDQoNCkNhc2UgMjogVGhlIGRyaXZlciBj
YW4gYWxsb2NhdGUgYSBuZXcgYnVmZmVyIChrbWFsbG9jKSBhbmQgdGhlIGZ3Y3RsIHN1YnN5c3Rl
bQ0KZnJlZXMgaXQuDQoNCi0tLS0NCk5vdyB3aXRoIHRoZSBSdXN0IGRyaXZlcjoNCg0KRldDVExf
Q01EX0lORk86IFRoZSBydXN0IHNpZGUgcmV0dXJucyBhIG5ldyBLVmVjLCB0aGUgcnVzdCBmd2N0
bCBhYnN0cmFjdGlvbg0KY29uc3VtZXMgaXQsIGdldCB2b2lkICpidWYgYW5kIHBhc3MgaXQgdG8g
ZndjdGwgc3Vic3lzdGVtIChDKS4gVGhlIG1lbW9yeQ0Kd2lsbCBiZSBmcmVlZCBieSBDIHNpZGUu
DQoNCkZXQ1RMX1JQQzoNCg0KVGhlIGlucHV0IGJ1ZmZlciB3aWxsIGJlIHdyYXBwZWQgaW4gYSBt
dXRhYmxlIHNsaWNlLg0KDQpDYXNlIDE6IFJlLXVzZSB0aGUgaW5wdXQgYnVmZmVyLiBUaGUgcnVz
dCBzaWRlIHdyaXRlcyB0aGUgbXV0IHNsaWNlIGFuZCB0aGUNCiogbXV0IG91dF9sZW4uDQoNCkNh
c2UgMjogQWxsb2NhdGUgdGhlIG5ldyBvdXRwdXQgYnVmZmVyLiBUaGUgc2FtZSBhcHByb2FjaCBh
cyBGV0NUTF9DTURfSU5GTy4NCg0KLS0tLQ0KDQpXZSBrbm93IEtWZWMgaXMgYmFja2VkIGJ5IGtt
YWxsb2MuIElmIEMgc2lkZSBjaGFuZ2VzIHRoZSByZXF1aXJlbWVudHMgb2YNCnRoZSBkcml2ZXIg
bWVtb3J5IGFsbG9jYXRpb24gc29tZWRheSwgRS5nLiBmcm9tIGtmcmVlKCkgdG8ga3ZmcmVlKCkg
b3IgdmZyZWUoKS4NCg0KRHJpdmVycyBpbiBDIHdpbGwgYmUgdXBkYXRlZCBzdXJlbHkgYXQgdGhh
dCB0aW1lLg0KDQpJcyBwb3NzaWJsZSB0aGF0IHdlIGNhbiBoYXZlIHNvbWUgYXBwcm9hY2hlcyB0
byBjYXRjaCB0aGF0IGNoYW5nZSBmcm9tIHRoZSBydXN0DQpzaWRlIHZpYSBydXN0IGNvbXBpbGVy
IGZvciBydXN0IGRyaXZlcnM/DQoNClouDQoNCj4gVGhpcyBwYXRjaCBpbnRyb2R1Y2VzIGEgUnVz
dCBhYnN0cmFjdGlvbiBvdmVyIHRoZSBmd2N0bCBzdWJzeXN0ZW0sDQo+IHByb3ZpZGluZyBzYWZl
IGFuZCBpZGlvbWF0aWMgYmluZGluZ3MuDQo+IA0KPiBUaGUgbmV3IGBmd2N0bGAgbW9kdWxlIGFs
bG93cyBSdXN0IGRyaXZlcnMgdG8gaW50ZWdyYXRlIHdpdGggdGhlIGV4aXN0aW5nDQo+IEMtc2lk
ZSBmd2N0bCBjb3JlIHRocm91Z2ggYSB0eXBlZCB0cmFpdCBpbnRlcmZhY2UuIEl0IHByb3ZpZGVz
Og0KPiANCj4gICAtIGBGd0N0bE9wc2AgdHJhaXQg4oCUIGRlZmluZXMgZHJpdmVyLXNwZWNpZmlj
IG9wZXJhdGlvbnMgc3VjaCBhcw0KPiAgICAgYG9wZW5fdWN0eCgpYCwgYGNsb3NlX3VjdHgoKWAs
IGBpbmZvKClgLCBhbmQgYGZ3X3JwYygpYC4gIA0KPiAgICAgRWFjaCBSdXN0IGRyaXZlciBpbXBs
ZW1lbnRzIHRoaXMgdHJhaXQgdG8gZGVzY3JpYmUgaXRzIG93biBwZXItRkQNCj4gICAgIHVzZXIt
Y29udGV4dCBiZWhhdmlvciBhbmQgUlBDIGhhbmRsaW5nLg0KPiANCj4gICAtIGBGd0N0bFVDdHg8
VD5gIOKAlCBhIGdlbmVyaWMgd3JhcHBlciBhcm91bmQgYHN0cnVjdCBmd2N0bF91Y3R4YA0KPiAg
ICAgZW1iZWRkaW5nIGRyaXZlci1zcGVjaWZpYyBjb250ZXh0IGRhdGEsIHByb3ZpZGluZyBzYWZl
IGNvbnZlcnNpb24NCj4gICAgIGZyb20gcmF3IEMgcG9pbnRlcnMgYW5kIGFjY2VzcyB0byB0aGUg
cGFyZW50IGRldmljZS4NCj4gDQo+ICAgLSBgUmVnaXN0cmF0aW9uPFQ+YCDigJQgc2FmZSByZWdp
c3RyYXRpb24gYW5kIGF1dG9tYXRpYyB1bnJlZ2lzdHJhdGlvbg0KPiAgICAgb2YgYHN0cnVjdCBm
d2N0bF9kZXZpY2VgIG9iamVjdHMgdXNpbmcgdGhlIGtlcm5lbOKAmXMgZGV2aWNlIG1vZGVsLg0K
PiANCj4gICAtIGBGd0N0bFZUYWJsZTxUPmAg4oCUIGEgc3RhdGljIHZ0YWJsZSBicmlkZ2luZyBD
IGNhbGxiYWNrcyBhbmQgUnVzdA0KPiAgICAgdHJhaXQgbWV0aG9kcywgZW5zdXJpbmcgdHlwZSBz
YWZldHkgYWNyb3NzIHRoZSBGRkkgYm91bmRhcnkuDQo+IA0KPiBgcnVzdC9rZXJuZWwvbGliLnJz
YCBpcyB1cGRhdGVkIHRvIGNvbmRpdGlvbmFsbHkgaW5jbHVkZSB0aGlzIG1vZHVsZQ0KPiB1bmRl
ciBgQ09ORklHX0ZXQ1RMYC4NCj4gDQo+IFsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwv
MjAyNTA5MDMyMjExMTEuMzg2NjI0OS0xLXpoaXdAbnZpZGlhLmNvbS8NCj4gDQo+IFpoaSBXYW5n
ICgyKToNCj4gICBydXN0OiBpbnRyb2R1Y2UgYWJzdHJhY3Rpb25zIGZvciBmd2N0bA0KPiAgIHNh
bXBsZXM6IHJ1c3Q6IGZ3Y3RsOiBhZGQgc2FtcGxlIGNvZGUgZm9yIEZ3Q3RsDQo+IA0KPiAgaW5j
bHVkZS91YXBpL2Z3Y3RsL2Z3Y3RsLmggICAgICAgIHwgICAxICsNCj4gIHJ1c3QvYmluZGluZ3Mv
YmluZGluZ3NfaGVscGVyLmggICB8ICAgMSArDQo+ICBydXN0L2tlcm5lbC9md2N0bC5ycyAgICAg
ICAgICAgICAgfCAyNTQgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICBydXN0L2tl
cm5lbC9saWIucnMgICAgICAgICAgICAgICAgfCAgIDIgKw0KPiAgc2FtcGxlcy9ydXN0L0tjb25m
aWcgICAgICAgICAgICAgIHwgIDExICsrDQo+ICBzYW1wbGVzL3J1c3QvTWFrZWZpbGUgICAgICAg
ICAgICAgfCAgIDEgKw0KPiAgc2FtcGxlcy9ydXN0L3J1c3RfZHJpdmVyX2Z3Y3RsLnJzIHwgMTIz
ICsrKysrKysrKysrKysrKw0KPiAgNyBmaWxlcyBjaGFuZ2VkLCAzOTMgaW5zZXJ0aW9ucygrKQ0K
PiAgY3JlYXRlIG1vZGUgMTAwNjQ0IHJ1c3Qva2VybmVsL2Z3Y3RsLnJzDQo+ICBjcmVhdGUgbW9k
ZSAxMDA2NDQgc2FtcGxlcy9ydXN0L3J1c3RfZHJpdmVyX2Z3Y3RsLnJzDQo+IA0KDQo=

