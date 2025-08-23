Return-Path: <linux-kernel+bounces-783009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CDE3B3284F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 13:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B8945665DC
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 11:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025E6253931;
	Sat, 23 Aug 2025 11:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iAziMHSm"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2073.outbound.protection.outlook.com [40.107.100.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49F4393DE3;
	Sat, 23 Aug 2025 11:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755947437; cv=fail; b=D20v0AeBHTRYvSEA+0DkkHGSv4Vx3nDqik6cSttiVqex+lpImTwVBBOlnBqhdFoeCQxrzd3FqRjLdQqDue2IZ39DhTd2Pji0JdOuHpZw9XQoYrh+/k2DWu/YmOTGLynnp6yvnU2S6JYdi+u1qTsZ2geARHjDciPGRSSiri/Ji+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755947437; c=relaxed/simple;
	bh=lvyGjwIKfqOUx1Mtd+skt9CZy2Iy+Z8uroVyr0H0byI=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=GS5q8VG0rgDvE0zGEEgZF1lYot/M98EttbegUazS1CFcHQKPCKRYBg5D/jA3M9XCrk+21Cdo3IVSwYotLV+JvQmpvYv38FfY2kg1EWEtf1eaz5Kko3hbo4W5mCN6xe12srG/NbkPtDpO9k/wTLZhu21hkG0nWMlJN+LLzZK+4So=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iAziMHSm; arc=fail smtp.client-ip=40.107.100.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xWWCcPEpOb0/aCSwyh/LMSx6hrx6Ft2kncQIw5FyiUNZoornXXFus6Gdqp+bgRnKKk8n+8KzIUM75C1tcVkDxN+RiyLjODT3WNALSxyiBaUvj3r3aVQi23/DcNCK3K7SzMwAzZDUJCDhUdfO1BB8hhXIljCl6pqd5LFam1hoX3ffuxWzahH0nJrIoQ31NOPepnqA2obp1vV8J5kysTEl8Zhc6+QOKnfSWnCxhNF3OdzpwQ/ZtZeTIW2rM/ruRKhogsasa6S2z/6Pf5K6vJvnAfyZaf6mNdgWjsrC/D23jnTegGXPT8mtKXjpnRO+80NpmCO+7LBbJKql8B9mAqBbUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lvyGjwIKfqOUx1Mtd+skt9CZy2Iy+Z8uroVyr0H0byI=;
 b=SZg7Ep55S6qnHWdXCjBq+ynrICiPhbf1xdy21HeOc8SYFLXudw4y923nKRy1dQ7IY/F217v0VoZL841ecVMNSjttYKy+BTqmnjL9gcBBlrlZVztzWgUuhdm4Pbm/RoZdOjZKDn7Pm9mzm2W0xT6QA68Siw1kufSnxRgxMkDFjILHDUk8pNqTsdktXZItlEv/Qzm7wvYJE9gIlLFhTSQrtxhqlppaLwdyz6oqThRj1J0ylwSx/1zuTVl0kcSuL8p+BPzgArNsJvzJM64uXwGyziJYlXCowpqkLSLBONJJpB1HWGeAejmFBBzFZQVKrJ+VK7QRfAiem8KgSqINiu3mFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lvyGjwIKfqOUx1Mtd+skt9CZy2Iy+Z8uroVyr0H0byI=;
 b=iAziMHSm4x/RYGNBwNRK0ThOQQpI6ydeVKDrDtv4X1NWEWYa887HwrrGB8SmwPQ8nx5Qp1tRI8LxdRGL2kJe6bmzasHLd1/PYQcsKhAqiWuVrkFQeq5yestQknlF4ptNI3uzV7Jr5aHhKEQGocqX9T12kV8ywJ/tsHwursuhW3yIhtOvAcs/CfrtdciR/RsJl1E7W409GadJsWiYloT2pO/MK97//qUw/yVXryHH4chPSFG8GVicFcurHn84Yy1dA8eQLApeMb/7o08toZVOvuQ7jLRppk0VpAr7cXZC96lKwPgAuSYjq2cJBXDZ8G+YcptRGQ2DtAfd9+5eu/cVYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by BL4PR12MB9478.namprd12.prod.outlook.com (2603:10b6:208:58e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Sat, 23 Aug
 2025 11:10:33 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%3]) with mapi id 15.20.9052.014; Sat, 23 Aug 2025
 11:10:32 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 23 Aug 2025 20:10:28 +0900
Message-Id: <DC9REWIDTAS3.153CJSRWIT05I@nvidia.com>
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>, <akpm@linux-foundation.org>,
 <ojeda@kernel.org>, <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <aliceryhl@google.com>, <tmgross@umich.edu>,
 <abdiel.janulgue@gmail.com>, <jgg@ziepe.ca>, <lyude@redhat.com>,
 <robin.murphy@arm.com>, <daniel.almeida@collabora.com>
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/5] rust: dma: add type alias for
 bindings::dma_addr_t
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250820165431.170195-1-dakr@kernel.org>
 <20250820165431.170195-3-dakr@kernel.org>
In-Reply-To: <20250820165431.170195-3-dakr@kernel.org>
X-ClientProxiedBy: TYCP286CA0276.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c9::13) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|BL4PR12MB9478:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f8fff18-a448-4e11-3c22-08dde235ad24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|376014|7416014|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MzBzSkFjQ3Q4Z1ZlTC9PRG9lS3NuOXl1Nk1sYkU2Z3Exdk1tRUdjbitZN0dk?=
 =?utf-8?B?ZUNRWHh3dXoxTHhhcmVoSHZiYlBNN2h4enM5V1pBR2lSc2w2em1uc2FkUGFI?=
 =?utf-8?B?L3h3SFRTeXBRcHlEalk5OVVPZWxaU0lQK1hteHY5T0Y5anZzUVF4UGtBWSsw?=
 =?utf-8?B?ZnpDVWFxQ3JNWE9GM09LWFB5UDhkWUFodE5INFF2VmZoai84c0pJZTc4eW5M?=
 =?utf-8?B?a3NJL1V1czhmNXlGZ1dxYURubExDejhrUUJuR1ZkVG1DMG05ZGZONU8vTmNP?=
 =?utf-8?B?eTR2SDdPK0x6c1ZidXA0Ti9JU3dJOXZPY000TGFZc0tMUXIxTnZYWkxrbk5Q?=
 =?utf-8?B?ZzlKWFB4QXcyeGpWQjZCcE5TYVZ1MG9XT1ROelNNQnpMT3J2ZjVhY0c4S094?=
 =?utf-8?B?djJNSzV2czl1cTlHL0lpRVplbWRjY2FlR1lQbHBuVGVMck5JdWlFZzlHTjlE?=
 =?utf-8?B?Yk15QWhNTmhMUzdZajZ3NEVsYUc2STFxWGJDRkVuU3Y2OWlVMkp2YmhRbGRZ?=
 =?utf-8?B?U1BvWnhyYm9BWEV2a0RiWG9UcUtDL3NuZEtBUlBXQTNGbnVieFJ6QytuMjJa?=
 =?utf-8?B?THFqbUlFSys3MDVyRFBxN09DMzllNzRFTHRrZXFSd3UyUlkzWmVXOENqZUli?=
 =?utf-8?B?R2dmOTNJdTlHYmNIOE5qbHltUEJRWGFjeHJ5MmpoZWYrNURiL24ybWIvTEJ3?=
 =?utf-8?B?SHZmUkxSZVBIVnRxdjJoaHZhTitBeGdPUFdhdHJLYTJvS1JJaEs0K3VqNVZh?=
 =?utf-8?B?MVliZURYSk0vTlJhT1BrRktMKzRUdzAvYk8rVCtJVUpJTWNCOXc3YXl5T2JZ?=
 =?utf-8?B?ZG1jVSs4K2s2cXdUNkxBc0YraThNaE5udkhLelQrUkxYT1ZVOGV1WEFwT1hT?=
 =?utf-8?B?K25Ha2N6THdqWkYyZEx0VjZDQUxnWU1jRmJmaDRzS2dMWko5YXpiZEpoTnJ0?=
 =?utf-8?B?MmxwVlpWTzdRRWN2VlBVTkRYQldGVkFtWUJBUmZPYU1lQkVqc3JrUmREck1H?=
 =?utf-8?B?VXEvWkJFMEE3VFJLTzFIY3ZaSUhzSGRpcm5KeER6T2tqVjk5MnJIcjFrYzhr?=
 =?utf-8?B?SldzaFdPZmxGekV6TTdEYkpwdDA3MWZwZlRrNXE1bG9KbDc1Zm4xcEc4NTVY?=
 =?utf-8?B?M0FBWmI2QmwwQUJtS2dCdlZrWGNkNkg3VFpWZmpOTjdRck00cCtweWxxNm5p?=
 =?utf-8?B?aEVtMkhhTldUcHZiTGZQcjYzamQxbDBrYkRYd2s2VHpGNVFpUzh5TTR5ZHhE?=
 =?utf-8?B?OFVpb3ZyeGZ0dkJiNlhyN3RuU1lCZ0hpc0N4eEhqMzNTM0Nmc1MybWJ1T3pa?=
 =?utf-8?B?QXNsWUU0NDlEbExEZXFqQWlkWkxRbUVyd0VmWEsxSXFDcElIYkpYODFqTjlo?=
 =?utf-8?B?UjNPakszR2g2dUlOclZIOUFnZ1dFUkhVbkZvR2d6YXVsdjlVY2RObGJ3cUhs?=
 =?utf-8?B?bDBqOU1NNk1LUkxxdjFpdHROeDlqdGxMVXVxY1Y4ODNQRmRmMmtmOTZUWU8r?=
 =?utf-8?B?VDFneUhKVUVMaWV0UnowTXVPb1EvcEZxZXA2cFN2amhCdVJXa2I2YXBOV0V6?=
 =?utf-8?B?ajZYMXF3U0hlejI5WnNlK2tkaVdPYkVxMm5jYTlzdkRsTVlVN0xjQ09UVmZn?=
 =?utf-8?B?UURnb1k3aFpmakd1bW1IZk5xWFdpQkJIWUdZMHRRN1NKbTFQMDhEZjNmZUJF?=
 =?utf-8?B?dzNUK0lxT0Y4b0k0VWV0TVVvcEZiNm9SbVQwTUVMdW90N2VBeTVyNDBTbFkz?=
 =?utf-8?B?Z0Z5VGxOR2tLRDlwcWZsVk1EdUFIQkRaL0pnSXY1UmZaL2xMTTJvM2tCNnRI?=
 =?utf-8?B?Tm52TGtwYnR0WFZ3NWREUWl6cyt5cFhibWwwSEl3QUNMdzM1TUhmajIxT0ph?=
 =?utf-8?B?bEhtNUxXU2pXNjZIT2dqUnRLbSsyc1NhSWppUFErL3E5d3N5TUx6cWcxVFJF?=
 =?utf-8?B?Mjh0dkw4WGo0N1d3RzNFaHM4Yzc0cCtzVERWRmhBNHVTT1pBL1BodEFFY1NV?=
 =?utf-8?B?czgwNC81UnFnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7416014)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cnljYnRiVzdHQVJDNXJsRmpGSGt2K0VncXlPTDVsNVlDMUF3MmhpVzBSbGQ0?=
 =?utf-8?B?UU5oYUo2V0Z6UVF1TzgzL1ZubW12aVE5MkRaOUtTZTh4V2VuVHptUWFWVytn?=
 =?utf-8?B?RFNpTnlYR09URmV6RlJMSG5VN0wvdVRPNnMvdlo3SlZDSjZnZ3FMc2xTaFdS?=
 =?utf-8?B?ME5iVHBXNEk3VmR4VnpsdG53VUxqcmd5WjBQeVg0TGZmWjJSd0RMMEVDUjVu?=
 =?utf-8?B?amdtaGY5ME9tZjB0ZDNDby9LRlBTMWtDQ1R1YTg3d1VkMXhMUUFZQnBjN1gx?=
 =?utf-8?B?RURPS1ZFYjU2cXF0VTVMeW8zY2pZRnF0R3BtU0FLNnVTWm5CL0hBVHp0OVlZ?=
 =?utf-8?B?TUQrVHgvMk80OGo5OWlPODdhSkNMT0VRamx2bUZLMURJV0VRY2tHcXk3OTlH?=
 =?utf-8?B?bTdidW1ZOFlBcVRiTmlHSEJNZHB4RXpWUjdGa1p4dlJMWnNYbmRLSndIMjYw?=
 =?utf-8?B?S0F1TUgyd3I0Q0NJM3AxdEVJWWs3UVVSeXZTcjVsdGY0eVU5Umo2YSsvOG1r?=
 =?utf-8?B?QVpScGdTNEQweVdDcVhQemY5M3h5a3NOS05vMkhGQkdWQ3FvbkhlQStON1dB?=
 =?utf-8?B?MDZUSW9za2lDajljOHNzeXZGSm9JcitVd3dzMVE0MWUrZmh0Q3VyZytjSXd1?=
 =?utf-8?B?LzE1Y2tHWFUycjNTMXY4YlNrWkhBb1JrVU9sTzVlOVdCYmZ5TS8xNWNxMTRt?=
 =?utf-8?B?NU9kcXpNcDVpWGVNSWk0Ujd6eXh5dkJ0dFdwcVQyNHRZSzRVeklBWTNXTVZD?=
 =?utf-8?B?QkxhN0ptOVl6S0JlVjVnVjdZdk5rTWs0SWYwVi9hNDh6dEExNlJVQ1Vtb0Vp?=
 =?utf-8?B?K3BnMEJZK1dmcWJJbW03N3VEMkpSY0JlWkh0T2FvNFY3YjBZQWFhQWZKcnhk?=
 =?utf-8?B?Z1BxUG9LbVk2MGxSRnJpanpBdHhrUnRHR1pKQ1E5NEtMQUVKTG1oTS9QRUg0?=
 =?utf-8?B?YzhmdnRSSFhrRHdOT0ZocE5ITXFBNlFTbTFYRUZHdWdQVnhOaFNWWmVCVnRv?=
 =?utf-8?B?SDQ4S2psT2dwYk5lVUZoRVdxMG9EbDBsSFBxZUQveldXMXF5T2ZhZzlERFhx?=
 =?utf-8?B?UDMxS1VQWUdKK1dieWVFM21EbmlORkk5aGdQRWU5bTlvRG1PTGRueno4Z3dF?=
 =?utf-8?B?RnliZUo0SnVwdTNMOFRNZlRlWmwvTktnaDZZTlNjRFkxZTBydUhZb0NjaFBK?=
 =?utf-8?B?SVZaM0gyT0U3M3IzaGpPUWJPcHFkcmRiMjJBNXBpcGQ5NmpkN1hub3ZtLzRw?=
 =?utf-8?B?N1hneHgwb3dlSkJpczJYZlpRS3RoRkZQcTc5bkVxeTdQSlJVbytUSStESGNo?=
 =?utf-8?B?SVVLU2ttRjZpNVFxeERBR1h6ZllaMFJUOFZ6RUo1bGFRUCtxaHpOUnFEaXR4?=
 =?utf-8?B?TFNsNkhkTVU2dmd3TFhhcU9WSnJVMDUxT2xzWmt4NkcwbFRLTjlKaEF2ZzND?=
 =?utf-8?B?WmRHc0thYXRqMmFpT0NwT0p0bWNGcktXK0FELzYwL21rVGNKa05Sc2lFVldI?=
 =?utf-8?B?K1E5Q2FDckhmZzV3WHhQQ0tyMmRPL0IyNGdJZkJ6Zk1xRlNHRHladFhZZGdF?=
 =?utf-8?B?RXFGbisvMHZyUC81Q2duZUZ1SXgzZTlBeFN6RjhLZ2ZBOTFOKzFiV0wvbmN3?=
 =?utf-8?B?SGJQeUdEb0VsWllPQ0hWeTN6dTZvcC9EdmVwNXV1WjIyQkt4bmlUaWRlb2g4?=
 =?utf-8?B?aVFSa3hsdUl4MVJRbDhjY2dodlNkZWtNMVNucWluaHZxV2Ntb3RpMUkyS2VT?=
 =?utf-8?B?eE12S2JLVlB2a1VkTTE5SzV1b0hGMk1wVDlaUFJSWlBqR1cvcHRLdzZydTlh?=
 =?utf-8?B?YllxdWZqN0YvclRvUlNJZlpZK3ZsVFZvNnZqTlg4eldDM0Q1T3RyQlRTQUwv?=
 =?utf-8?B?UnRNNEkzcXpVTE5tZHA0QXoxM3ZKUmlTV3BNYlNMRXFFQmdvaWNwbDlxZGha?=
 =?utf-8?B?U0VpZGQ5TU9uRXFnTXBMWkhFQk8yTnQzVTd4dUhJVTV4L2s2WEZVWmcxcE9x?=
 =?utf-8?B?YjlxeTkrTDFsUE1DcG9ZYTcxUzJOeVdTbE0rcHZqVUdIaE16SkFWRmNLMlM5?=
 =?utf-8?B?WWVoMDlNL2V6akZPNGNISVZjZXdkNGp0U3JSWDFXSnAySlhpcXNKOWJpMGsr?=
 =?utf-8?B?Z0hOWjZxVDlLaTdrNTN2WlNEUzh4dnJnNmc3S29mWmJ0MFFWc0FSN2N3MDkr?=
 =?utf-8?Q?mkKJDO7WQR5tZAzHMpE99P1qljCEdbl23a2vXybUc+LX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f8fff18-a448-4e11-3c22-08dde235ad24
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2025 11:10:32.3553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7uHQmaMmVRq6ja80NWsjT/EgfI5c8m2PFNqn/miknVVa+K4tnLoZnyJAlc+sktB4B57W6pI/v0B/OYQewbOoDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9478

On Thu Aug 21, 2025 at 1:52 AM JST, Danilo Krummrich wrote:
> Add a type alias for bindings::dma_addr_t (DmaAddress), such that we do
> not have to access bindings directly.
>
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

