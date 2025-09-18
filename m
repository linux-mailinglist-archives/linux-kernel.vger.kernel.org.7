Return-Path: <linux-kernel+bounces-781290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2126B31096
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E6051CE4C08
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 07:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE95F2E88B5;
	Fri, 22 Aug 2025 07:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="N3QEeur6";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="N3QEeur6"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013028.outbound.protection.outlook.com [40.107.159.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337A122DA1F;
	Fri, 22 Aug 2025 07:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.28
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755848224; cv=fail; b=cZCVoSvGEVayV8U8yIcteUSYuAwTFaY4nN5SMQwwLs1Eo7w7OCJ7MIunzQjqY5KHtTZFlChitrAWFw2tSxfKbvpU7tLfEYku8QYgwg3mEOVs5o50Itea3BRpyqnyb5cVdM7MM78x/PISKOS+tFNaatXcyjScZlBRaKzsDMBOYmo=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755848224; c=relaxed/simple;
	bh=UuhkDxDA4hSQebwqEcbDXSNx6Rl/lVFMx39HoNKEUmQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HUwndHVlRIa1ac18Qz0yFbcp5fzFn4Or8Qh24oc4WLOJouLUigESSHOI/soV4jdW8uqCzmWuQSgeDVZZoop3ziviqzjsN9vpvg9vgJJWB37vKoHikgJC6L80P4blkjYW54TsggW9Ulk7sLcgqDYD6HQIl7iMkeyEZ8ihIMLYpKo=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=N3QEeur6; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=N3QEeur6; arc=fail smtp.client-ip=40.107.159.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Ab0uywKGctqlpANnBZAD3SsmSl+ollrKSg31RgaXoUUKQD657a/HPrp4lciq1IEkdXmrdyZQy3DWIqmj7q8BC5AaxFKnyikDVG8GuS6ICSXq80I8GLDs63lsngOdhqz6YXIPucxpmjnEjR/ukXMd0X6c/QmzqL2Qr1vQc7ZKOJOV7YWcIw9ddj55BH6ShCVS5ChHQEhyMnMKEf/i0FhE+IBzrvj4d1CxLACO6Hm00OS6//V9QAkhbeYqzFFmTwA15C9oPtKi09v2W+CnxWI36j+0uQwQ+sfcGXeBu31pEfa/c/gK0JTUwjY3mK9kdyS5HLgF1AN1OGAuyZfBCmZ4KQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pZafry/YiyDWe2iDoSTP1oOzSWK9H8nU0j9RQsZo6wc=;
 b=ejKJzXFW5Fn9i2G3jxsOxk3edv6Io2zgeSmeLOZnXNuKj7V6iZDYO08lNSe4MzFrSc/bKFBjR0xVoZj8eOP3lqqQKW8whub0l3iNhIHx+h3MI3NWyE20FiIYaUlyP+Fj06vqT8zeUduxFZAE+S+8ovDxPxGcIi2dJr54QfWvGRn4riqQkUgvDMztw+2Q284c0egKPQEcKPkYtW+v/NtCrZzjLzveGMCaVVkKnp7clOYwloaBUoV660Yrm8bRxyOJkUbKarb8MN00wYFpYzzfQ8fTFMjdzq+v0JV/2b5lBbpw5VoNMAd0S2OlJeAFBIo2Usjr8m4Y+ZjTVD9+CJK3kw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linux.alibaba.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZafry/YiyDWe2iDoSTP1oOzSWK9H8nU0j9RQsZo6wc=;
 b=N3QEeur6CN6b8NDoVIZZCIH1a4HbCCYFttglXMQffdaoqYlJ6sb99BwYThqknqBV3xKBiUAU8Tb4DsVKvl/nPWxzNLdD3JYoTSAEmv6s15uP7mQDEwKp0b4KBmrM9gEy3IAkqgjHQAWzwvna/vz7j3ecmwOcNeyGWum7AfOf0B4=
Received: from AS9PR05CA0088.eurprd05.prod.outlook.com (2603:10a6:20b:499::33)
 by AM9PR08MB6180.eurprd08.prod.outlook.com (2603:10a6:20b:2d4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Fri, 22 Aug
 2025 07:36:57 +0000
Received: from AM4PEPF00027A5D.eurprd04.prod.outlook.com
 (2603:10a6:20b:499:cafe::4d) by AS9PR05CA0088.outlook.office365.com
 (2603:10a6:20b:499::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.16 via Frontend Transport; Fri,
 22 Aug 2025 07:36:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM4PEPF00027A5D.mail.protection.outlook.com (10.167.16.69) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.8
 via Frontend Transport; Fri, 22 Aug 2025 07:36:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h2nPzJ+MtvKgyTEb4aw+r80BWn02JT+Wc+AV6o6iT9szoZ+nBlCNFxh54idNJJGQCMpTuF53Uq7X6snOw79v/BAP/yxArrjqS02hdaP/iKj4hWuRZPbjsFIrHDRFHTA2w2HPJ0qcs5Xy+YT5yrw8Ql0nYoEvIbquQ27iFmmW87dupCjNAdFWuNbTqOsDbeVN/p8KYqUXMESYEFmbraUNTDZG7+ah8gGUulRUtDbsIekFq6pcNEVW7/SJjVT7YyGIZoDanCgk82HqVievHBMf/Q1bW7/QVMPytphMj+QbFRVBWYi9Hy+7YvXXVIZdfzejlh86Ezq1/8zECL1LdCnBcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pZafry/YiyDWe2iDoSTP1oOzSWK9H8nU0j9RQsZo6wc=;
 b=WaOcNxdYYtV5That9i+NQXcsfSxbi90JGEGDfSDTmONdChuc+B5vXC2uk2MtCXnO594PppgFtdUKBUyn9KpnwCUYNBUQgz6Te/oeCyHiCbVYdBc6bl9zM/c3UBQLxgIubeWVm4pofrVUeqMBDKZEi5YQ7Bl5+CCOcGy4AHGXpkUsxCz53XJZoof+GbaX9gJuALTiyWSzbIln+rVVCmR96GNwopkPwL603BI2rRX0KtWXzXnRcazhwukXc05lsUkMEOwmYhcFpVguvoPaHSCB8tBh/ZEbg/zqKDIkRTJt6J5VT1DD278AP/9SK8vAMnS1IJiy9wedUgoRp5bT5l8Slw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZafry/YiyDWe2iDoSTP1oOzSWK9H8nU0j9RQsZo6wc=;
 b=N3QEeur6CN6b8NDoVIZZCIH1a4HbCCYFttglXMQffdaoqYlJ6sb99BwYThqknqBV3xKBiUAU8Tb4DsVKvl/nPWxzNLdD3JYoTSAEmv6s15uP7mQDEwKp0b4KBmrM9gEy3IAkqgjHQAWzwvna/vz7j3ecmwOcNeyGWum7AfOf0B4=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by AM9PR08MB6660.eurprd08.prod.outlook.com (2603:10a6:20b:305::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Fri, 22 Aug
 2025 07:36:24 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%5]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 07:36:24 +0000
Message-ID: <2fdeeb22-e511-4495-b4ad-2b26a5fcbb00@arm.com>
Date: Fri, 22 Aug 2025 13:06:12 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 10/13] khugepaged: kick khugepaged for enabling
 none-PMD-sized mTHPs
To: Baolin Wang <baolin.wang@linux.alibaba.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Nico Pache <npache@redhat.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 david@redhat.com, ziy@nvidia.com, Liam.Howlett@oracle.com,
 ryan.roberts@arm.com, corbet@lwn.net, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 akpm@linux-foundation.org, baohua@kernel.org, willy@infradead.org,
 peterx@redhat.com, wangkefeng.wang@huawei.com, usamaarif642@gmail.com,
 sunnanyong@huawei.com, vishal.moola@gmail.com,
 thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com,
 kirill.shutemov@linux.intel.com, aarcange@redhat.com, raquini@redhat.com,
 anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de,
 will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org,
 jglisse@google.com, surenb@google.com, zokeefe@google.com,
 hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com,
 rdunlap@infradead.org, hughd@google.com
References: <20250819134205.622806-1-npache@redhat.com>
 <20250819134205.622806-11-npache@redhat.com>
 <d9a02ed5-0d6e-41e6-985d-23f5a2de093d@lucifer.local>
 <0269b6d4-23ce-416f-8c44-907478c3d6dd@linux.alibaba.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <0269b6d4-23ce-416f-8c44-907478c3d6dd@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0006.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::10) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|AM9PR08MB6660:EE_|AM4PEPF00027A5D:EE_|AM9PR08MB6180:EE_
X-MS-Office365-Filtering-Correlation-Id: adf1a0f3-f40e-44ec-3406-08dde14eabbf
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?L05Jc3I3MUo1Y3BFWXR1VVdLY0I5Nm1oY211TlBKZU8wZWJsVndralhuNDl6?=
 =?utf-8?B?UUdvV1B1Qm9Sc3l3aHpQc0hMUHduZkxMa0k1dmJIeEFGUXBENlkxc1F4OGhs?=
 =?utf-8?B?Y1VhdVkvbjF6TGVDaVZuN0J2NGtwMEVIMkhUMkZ1eWR3YkFYQ2ZGc01QWlk1?=
 =?utf-8?B?cTRkM0Q5WlZYdy9BZ1cxenZFcFFaR1RPaW5zQk83UlM0a3lnbzNLRmY0ejUv?=
 =?utf-8?B?aXR0OHBnREs4MHNtdW90MlJlTTdCYmFqaCt0YXhwZ1VlWk13Q3ZLOU5oYkVC?=
 =?utf-8?B?M3NES2IzTmtaZ3F5ZXlVM3c5OGtMWlNQQS9YaVNqTzUxWUwzQ3cxa2tEWmZL?=
 =?utf-8?B?ejhoOWJ3M2lTb2dNRmUweEFEb25NRnM1bzY5UXVsQ0tyRHpyUityR0RiKzc3?=
 =?utf-8?B?bytTWU1ST0FZNzBiUGZxbGJqZ2piWGVuaDJHem5CTUlOTkhXRFhGRkpIWUZM?=
 =?utf-8?B?VENlSysyS0I4dWs5YmIvdU9IRkF1aTNpeFFkMFVsKzZ6NkFCMlhhMjBFSFNW?=
 =?utf-8?B?c2V4SVRDd2dlcHFmN1RrREU0QlFKQ0t1NUNJbHNUNGNjQjc4cWpoUDRlc2NL?=
 =?utf-8?B?N1NrY1pCaFhFUnJSM2N1WFdoRFVlVU1VSTVTd3YrcnhMVVlDcm0wajVybUNs?=
 =?utf-8?B?VmE4bHpXcndvV0JMSFFxR1NnRU1tQVRUNmZhOUdIejNwK2FlQW9TWkVLM1Vm?=
 =?utf-8?B?V2xyeTFYaGdFbVBRejU3bjFOZkRQdzlReWgvNm1XNW9COFU0aVFtcVlLKzlT?=
 =?utf-8?B?ZEE0QzdDQ1F3aXFYbW41cFlFTVk4UEt4azl1MWdKczE4Yzg5NXBKcDRNeDhy?=
 =?utf-8?B?NmdjN2FNNlZWUWloMmtpbFBBcWZ6aVA5SmNBM3FpWmJCdVN6Wk9jazJ2elhy?=
 =?utf-8?B?SVI5RUlvNTI5cWNTZEljSThHSGkxY2EvV1hJaXUwbXdzVVJ0c1JaUndaOTEz?=
 =?utf-8?B?KzZvVkZYYmx4TGpiZnZnUW4vdHNoT1ZDa3NXdW1XclZERVdGVHNCQ2g0Wjhu?=
 =?utf-8?B?dFRKamlINE4rVGVqWTVPV05QTm5OQmJsUURBRUs3Nk1DMGwzNWtQdVQ0SVRr?=
 =?utf-8?B?Ty9la3gwN0lDV3gvSFY5U2Z5K0hGT0JYU2Jib29EM1VNeVNYVHhBaktGVzV6?=
 =?utf-8?B?UkRYZ1JLZ21JTHI4SkxaaGFDR0ZxdVNsVXdhbFJzQVcvRFY1NnBYaEE1eU91?=
 =?utf-8?B?WmZ2Y1dqQmtmQWk5bzlOUzFhdWUwVzhONDRCb0hBSDRYV2pCaWV3NkQwU1Fq?=
 =?utf-8?B?cmt5WVdhSjg0aWM4Sm5GaW5lRFovWFBsT1VqYkpCWFBwTC9QMWFQVnRnZjRC?=
 =?utf-8?B?VVVQeFpFb3d1RVpJbnpJUlNaOWFyaWQ5b1BwVjZmU0FOR2ZaUnd3YnhWYTVX?=
 =?utf-8?B?Q3k1ZkhsWGtoVGZmMndsbTNsMzFZMWpjTzNqUGlLZzlTVHFzVEQ3V0ZwcG5R?=
 =?utf-8?B?YWJGRytHVmlJWG9obkNqSDZIMktwM1dEWXZTTWlsNS9zSGhuSnlibkI0NlA3?=
 =?utf-8?B?VmlqR2FXajBtTE45dFNMVUtiMmtxaEdoMkt4Sk02dGhJT3FTamdrVVl3V2Rw?=
 =?utf-8?B?QWMveS9RQmJOblFoN0ZTdlBuZjRDcHJ0SkpBK2EvTThYcFVRTlJBNUtvSlE3?=
 =?utf-8?B?WFlGRExVd0FpdHRySEJsVTNuSlZ5M0dDRDBoZG80WGtDUk1jKzg3Y0djS2N5?=
 =?utf-8?B?TUp6MlYwdHNCblliQ3dGT0QxdDR6SU51bSt1R1k3Q3hDOTVnY2pMd2ltNHNv?=
 =?utf-8?B?WThvR3J4bEZoWE5pMlRYVGNxWHNFYU5EV0lueGFQSzNpZXl1djY4eVdsWVV5?=
 =?utf-8?B?a1J4N2ptdHBPY2hiVVQyQml5N21Xc0NJNjdsOXExb2UyOTBaZDJBenRYT2R3?=
 =?utf-8?B?bzk0NWhySm9rUUhoVVpRRmlSM0JvaWtBRHcyWmhkc3dSK0NPV0J1T2MySGN3?=
 =?utf-8?Q?HTcZbACmOoA=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6660
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM4PEPF00027A5D.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	bde6a0cd-7d71-4974-aa21-08dde14e9898
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|14060799003|82310400026|35042699022|36860700013|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UEZiQXY2NEU2bU03Z2NIWHRVUGNUamhqOTBsUzBqYm5jMzlNSTcyUGtWZEMv?=
 =?utf-8?B?Q0hTc1lmYm1PM1BJb1NadFVyaVN3c1NZczdsV3lEaXAzT1Q3WTdmZjNTN1Bk?=
 =?utf-8?B?amUrMUp3L2pXS0ozdXlxU3NTYm5TNDczZm8yZnZaU3FPTVVDYWdTV000Nnh3?=
 =?utf-8?B?V2NaNFBIbGpWdkNndlhXSk9ZVG4vdW1KVGtPRlg2dHBUdm5SVnVCc21qa2Fu?=
 =?utf-8?B?N2hDZUVJN2tvTTlsWnp2dXJGeUhoemNUYURHcmQvVmRDMjUvUThjTU1FT1Qx?=
 =?utf-8?B?SDNweEhGWXN3QlZuZVM5ODNzV1k1UHl4bnVhNzhIRGpPSnJROSsySlVyUlJ0?=
 =?utf-8?B?UWt0V2VLVFdabW5TMUNGUDRCdVh6dW1Ga3hmOEFLVHg3SmdRZk5FVERTd2JD?=
 =?utf-8?B?cm5vc2x4cDZlRkxNcmJybzBaS2lpR09QVi9UOS85QXYxa3ExbmtQd1ZFYXNI?=
 =?utf-8?B?SER0M0NBM2FRTzhiQnl3MjV3elFPeFZUbFVnaGtFYld1c1prb1czRjc0ODdQ?=
 =?utf-8?B?WkdUY0dpTy9Oc2pHY2NQcC8wM25JaHp0MFYvOVErbDM3aHhKaFpJWHNFT0lL?=
 =?utf-8?B?M2Y5eW5hZE5CalVJUlpzYmtFU05na1pqRWNSMm1mc3lxbEM0WVpPMlA0bjdF?=
 =?utf-8?B?dHJtNDFZTmJtWEM2RGlmUDhCRUxDTWpneFlHOU0rWUhWSjVmVFgwdlZON2ht?=
 =?utf-8?B?djhvWWwyc2VwM3ZqclN6Y3BQdjFIMUlNcWkzbkdKdFJFNXdKNXNWQ1JwdWRm?=
 =?utf-8?B?OElZUHc5NkpRMDE2U05wYmVocGpzNnBzb3JGUGZtNE1oV2dyQjdmVWUyeUZG?=
 =?utf-8?B?dlVEQmp3M3dLSSsrTGJVQ0VHZEdJRzlab3ZQYnVpb3RrNGVBV0lOYzByMlFx?=
 =?utf-8?B?bm9FbnBoQ2NjT3NaVGZuNVpyYit4cmhhWjlOckxua0YrS0ZwUUUxcDdraGwz?=
 =?utf-8?B?UEViQXhUcWIyTUFrMTNpbHR1cHZ3RlBBRjI5OUlrcnlrSHBRbkMzRDdrMEh4?=
 =?utf-8?B?TFNuLzN3dHdyQU5BbzhTaVRBQkRpYjlhZmp5NWVjblhPc1FCUGRBUjBaakJl?=
 =?utf-8?B?Yk50NjZqSTM1a3BDdndOVmZBSlpSTWxrejdpMkVkMjdXaFlkMkhtNmNWTEhC?=
 =?utf-8?B?SEhvY2hRa0RnczcwZms5U0lJRUhPWHRkdjl3SGEyMmFySTFnZVU5ZmxwU25K?=
 =?utf-8?B?M2VwRFVUWjh3a0x0MVlDd3BzREZVTy9mT2RYc0hONXRLQ2E5aU8vQWkzUmhZ?=
 =?utf-8?B?QnJoTXY5YXAwNjRxUEl5cW5pNGE5WGdCdHd4Y2wvcFpVN0RTRzNSekxQSzl5?=
 =?utf-8?B?ZjNNc2JpRHY5dzltT3hzeUp0YlhGaWVZV1ZyZ0hpT0tkeDlIS002ZXk0VHZT?=
 =?utf-8?B?TXQwbWJuQXZLYVhmTGZUWTJxV0hZR2I1TGszNXlyVENvMGJ4WnF1R3JVd3NP?=
 =?utf-8?B?d1plcENSVUFsL0R0UEswaXo1bVl6bVQ1ZXVXRjVSOGxiZmMzWHEzcWpxUmtP?=
 =?utf-8?B?ektTazAvMyt6Z2JuSzN4RG84bzFhMTc1bmJyUXViMUpZRnVrSlBOK3BoWDd1?=
 =?utf-8?B?RUMxTCtwZUR5UXR4WFZJSCtoYk8rWmZVeXp0Z0hWZ3dLSDc4Y2JqMDllcDhi?=
 =?utf-8?B?WTRqL2tPMXJiWXhGWEVyWHV4bndOTzF3dVFtUnhPVEVWT28yTTFnYlpXZVZO?=
 =?utf-8?B?SU9nQk12UVVoR2YwK05TdTAyVjBOUEptVGV2V1hDYVptNlRTRGdlcDVOVWpN?=
 =?utf-8?B?TktoNDRxZnBmNUVsaUx1b1BJb0FSN1UvZU5OM0xFeERqcC9hVU5IUG9mMGJ3?=
 =?utf-8?B?MERZV3RlYkJ3VUV2NGJmaklDbjNxeDZXUjErblorKzk5d05TeTZ1M0tJYVlj?=
 =?utf-8?B?eUtmYlFwWE9zSDNyUlFtMUFTU0g4eDJZUjdETmEzc3p0MTcyQnlBZTNFUFBO?=
 =?utf-8?B?dE1FdFdnNmdmQ1NLZFlldmRlUmI1a3BQNUx0VVZzbkVvbVlTVnFTQUZyb3Nu?=
 =?utf-8?B?cWtydkNWc01KRTM4QytjRVB5aEdVTWQvdGw2UjlScy9iQmZxUVJUaDlZcER1?=
 =?utf-8?Q?exhxLQ?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(14060799003)(82310400026)(35042699022)(36860700013)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 07:36:56.0976
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: adf1a0f3-f40e-44ec-3406-08dde14eabbf
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A5D.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6180


On 22/08/25 12:29 pm, Baolin Wang wrote:
>
>
> On 2025/8/21 22:18, Lorenzo Stoakes wrote:
>> On Tue, Aug 19, 2025 at 07:42:02AM -0600, Nico Pache wrote:
>>> From: Baolin Wang <baolin.wang@linux.alibaba.com>
>>>
>>> When only non-PMD-sized mTHP is enabled (such as only 64K mTHP 
>>> enabled),
>>
>> I don't think this example is very useful, probably just remove it.
>>
>> Also 'non-PMD-sized mTHP' implies there is such a thing as PMD-sized 
>> mTP :)
>>
>>> we should also allow kicking khugepaged to attempt scanning and 
>>> collapsing
>>
>> What is kicking? I think this should be rephrased to something like 
>> 'we should
>> also allow khugepaged to attempt scanning...'
>>
>>> 64K mTHP. Modify hugepage_pmd_enabled() to support mTHP collapse, and
>>
>> 64K mTHP -> "of mTHP ranges". Put the 'Modify...' bit in a new 
>> paragraph to
>> be clear.
>>
>>> while we are at it, rename it to make the function name more clear.
>>
>> To make this clearer let me suggest:
>>
>>     In order for khugepaged to operate when only mTHP sizes are
>>     specified in sysfs, we must modify the predicate function that
>>     determines whether it ought to run to do so.
>>
>>     This function is currently called hugepage_pmd_enabled(), this
>>     patch renames it to hugepage_enabled() and updates the logic to
>>     check to determine whether any valid orders may exist which would
>>     justify khugepaged running.
>
> Thanks. This looks good to me.
>
>>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>> Signed-off-by: Nico Pache <npache@redhat.com>
>>
>>> ---
>>>   mm/khugepaged.c | 20 ++++++++++----------
>>>   1 file changed, 10 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>>> index 2cadd07341de..81d2ffd56ab9 100644
>>> --- a/mm/khugepaged.c
>>> +++ b/mm/khugepaged.c
>>> @@ -430,7 +430,7 @@ static inline int 
>>> collapse_test_exit_or_disable(struct mm_struct *mm)
>>>           mm_flags_test(MMF_DISABLE_THP_COMPLETELY, mm);
>>>   }
>>>
>>> -static bool hugepage_pmd_enabled(void)
>>> +static bool hugepage_enabled(void)
>>>   {
>>>       /*
>>>        * We cover the anon, shmem and the file-backed case here; 
>>> file-backed
>>> @@ -442,11 +442,11 @@ static bool hugepage_pmd_enabled(void)
>>
>> The comment above this still references PMD-sized, please make sure 
>> to update
>> comments when you change the described behaviour, as it is now 
>> incorrect:
>>
>>     /*
>>      * We cover the anon, shmem and the file-backed case here; 
>> file-backed
>>      * hugepages, when configured in, are determined by the global 
>> control.
>>      * Anon pmd-sized hugepages are determined by the pmd-size control.
>>      * Shmem pmd-sized hugepages are also determined by its pmd-size 
>> control,
>>      * except when the global shmem_huge is set to SHMEM_HUGE_DENY.
>>      */
>>
>> Please correct this.
>
> Sure. How about:
>
> /*
>  * We cover the anon, shmem and the file-backed case here; file-backed
>  * hugepages, when configured in, are determined by the global control.
>  * Anon hugepages are determined by its per-size mTHP control.
>  * Shmem pmd-sized hugepages are also determined by its pmd-size control,
>  * except when the global shmem_huge is set to SHMEM_HUGE_DENY.
>  */

Looks good, had done something similar in my version.


>
>>>       if (IS_ENABLED(CONFIG_READ_ONLY_THP_FOR_FS) &&
>>>           hugepage_global_enabled())
>>>           return true;
>>> -    if (test_bit(PMD_ORDER, &huge_anon_orders_always))
>>> +    if (READ_ONCE(huge_anon_orders_always))
>>>           return true;
>>> -    if (test_bit(PMD_ORDER, &huge_anon_orders_madvise))
>>> +    if (READ_ONCE(huge_anon_orders_madvise))
>>>           return true;
>>> -    if (test_bit(PMD_ORDER, &huge_anon_orders_inherit) &&
>>> +    if (READ_ONCE(huge_anon_orders_inherit) &&
>>>           hugepage_global_enabled())
>>
>> I guess READ_ONCE() is probably sufficient here as memory ordering isn't
>> important here, right?
>
> Yes, I think so.

