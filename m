Return-Path: <linux-kernel+bounces-808586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32DC7B501E7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 17:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA1D6172D00
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 15:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59DA2750E3;
	Tue,  9 Sep 2025 15:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C9nxcqyh"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C5A2571C2
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 15:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757433053; cv=fail; b=lcuAUqkWOVmRIAqmOFIKGQHHix2U6rZaUV4aceKM83fMlUmG8+8A0rTXUtG9D64sDYSQFLopOOXYO68KX2P7wkJ5f9xncDQPC3ohncFX6gRuOtvECTw0VhQ7a5KcKPIF4r3LBAiudSj+D7xkbrA6JtyN+PX+MTGiiJz+gefLRN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757433053; c=relaxed/simple;
	bh=oNpWfkwqjjtRlt61YpQWpZJLcy5IyvoDowLEv3mBNIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=l0eWlKv3SoE9gEVoDNCsrTnfQJvZuuYC8I2ARLLqq2BW4BV5kXj3eqgzYKd9Tc+6LUtq8IzDX16zG02XnJUHxv/ABOlHlYNteq5szhWaGUKJaQPj6ZyWZoXFuBbol/mJ7DYaruWKqAPpB18RdeqF6xjtXhQ32VllOISNHoKJgzk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C9nxcqyh; arc=fail smtp.client-ip=40.107.243.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gqm5QPrXsWpgNwrYH3skTOZtvQpwyg640dSoJHDLD4R18wluC1yaazK7fec06BI/0Lotbop6qP+3WzWhtvqIvPfdIxOzjs/eGa+lhGH9QaOw8DBqOKvcV066nfCaqAwGqoy6fvszFXeGWpXp9OJ/FBCZHgPZZ7eE5oj1ioIomvwIZCcpejpwBX6KS8I5PSJHaeZhpiubqgNv+0EUE3VuVhKFw/ZuVjiR/D2H/GB0tcjs8mPMaTNVmDzUkBkGQlSSax3WvDsuZ05D++ohu4Fa9UeVfSlyTdUOrYqqEO/e79h1hC1hFi15aPAx0+jD9hUZEx/1Awl6XLnuamGP3497wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oNpWfkwqjjtRlt61YpQWpZJLcy5IyvoDowLEv3mBNIQ=;
 b=LzcpON8eZyQdL97TqlBBpAYMKVF7anZFsP9KQqKI3lzfdx2R2/c1gDNLUTwAuv2GzM4yhENdlNGf4ftQrGd36mLTv+Wu9MXWiz3V/mX/l3t41MmsGXPJXPquauwyw1QAtTz8DcrWR1NFmRu/qz9OBHQG99EfsnrsTdUCA8SIbrzGz+MWVNZCQsI6yaI8xHtCJLoMuhhdIPdchMC5KHZv8t3cngTMcFMD6RQKOf1RU5oWfMXEiu3HxdZoL04jqeBkROPPRAkZaCg3UxZYJzbhQHeRw9N9+ffHC07AsDZPBn6f98g6/DXqY4UT2zUjRZ70Pv2HmbynEC9EV1GHGyZPuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oNpWfkwqjjtRlt61YpQWpZJLcy5IyvoDowLEv3mBNIQ=;
 b=C9nxcqyhZpD7XaHhdnXjWWjyhsPEPo584PNObF0IWgYw8ywHmaJgrj9JT18uR+Je1DGNdKAFxWvWLQnP74EykXpy7p+0EpvIsrhXX54BlD2A6P1ryyLCQgrOSakF3aWASNKLsywSmyJrqcTpF8sSh0P6zd2AUE6iIt1hegAJSa+wSrHYfsEvwQ8Ku2nz54Is6Da3dquBJ1SZxsTWoCpB09aSULsiRicYPGbz/oOPjWKrupQe4mJ7Z3RFSELxNKjVXQg+/jDDTkbGbdpBIat47R+DIeR9hHZsckkoG7tzu1H/ROVqi42EmVh+RAhaG7G3p4t7VQae/sC9/T57Bf/6Uw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by DM4PR12MB5746.namprd12.prod.outlook.com (2603:10b6:8:5d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 15:50:46 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 15:50:46 +0000
Date: Tue, 9 Sep 2025 12:50:44 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Chris Li <chrisl@kernel.org>, Jason Miu <jasonmiu@google.com>,
	David Matlack <dmatlack@google.com>,
	David Rientjes <rientjes@google.com>, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH 1/4] kho: introduce the KHO array
Message-ID: <20250909155044.GN789684@nvidia.com>
References: <20250909144426.33274-1-pratyush@kernel.org>
 <20250909144426.33274-2-pratyush@kernel.org>
 <20250909152814.GL789684@nvidia.com>
 <mafs0ldmnk522.fsf@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mafs0ldmnk522.fsf@kernel.org>
X-ClientProxiedBy: YT4PR01CA0451.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10d::17) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|DM4PR12MB5746:EE_
X-MS-Office365-Filtering-Correlation-Id: ba4e8c0d-3dce-46f9-a4db-08ddefb8a3d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q1ChjAwzF2bMXsFpLjDzomA/dWTpvvi9lLliwvvghsfPPJxjaht/2aO3ZJUz?=
 =?us-ascii?Q?pnLvzuufG7+3td6f6hnDPw9zLz3bBYrn2GgIN+ek6clDDBKeElZL+rSqLqW/?=
 =?us-ascii?Q?Ep99mwYpMFt4cv4cNh8xuMQekVKj2gY8Oo2Sd8VNnU92YRmWBWgGS9wOSbbu?=
 =?us-ascii?Q?Opcn+gxPehW8G3S4i1Xw3Xle5SmeTsSzzlrxwvLo72NkvBVsSDlOy6qlB9l3?=
 =?us-ascii?Q?zWoE3ntuCzFCWEy7yXgWHP87GLAEAxu7cBi+xsLn38GguXdVmJ3VjQq8m5I6?=
 =?us-ascii?Q?nWcMcJyhd6Wf6dQSkrWebA0hVaLhSa8JHlHRL/7jqlRK4jsI/nA83gRd071Z?=
 =?us-ascii?Q?zS0nitMpGD0OLUE/Et5xsEhe6DKZjwEcCnZ3cNgMUfO9yjJ1JIJE8fomUX9v?=
 =?us-ascii?Q?iwT5v9/JmXToOeNlKo2z7OM83gWEJQw5FQ8ZFXs9JWvHCIc+DvlLgwDehxj5?=
 =?us-ascii?Q?R/jaHw6KMe3vSz/KNl+0qzhmjOc+BexBCq3rwq9Omz2KM9EZ8bKKPL01eseH?=
 =?us-ascii?Q?lvplPKOO5G4KuUzCI0xuJ9zGbK7BBPEik+2BgZt27t5FO6A9HR6VGg8fUs0X?=
 =?us-ascii?Q?sDCcAWN4en8rnqkahf7hWt4K2ZkM0ZV//y8yp/ae3z3V1JrypQzoob/Wfu6a?=
 =?us-ascii?Q?sdgT6aj53CMhNPv39XKw6LejQAsdnupqBP5ojSLVIphEexzPmH+9OcxJksfR?=
 =?us-ascii?Q?PMyidsLW7CI3AFnqp4nE9eZfkVO1dHf9EE9zVsTGQYpu7zcXqFDn8rPLaRui?=
 =?us-ascii?Q?Cm+ImgIBW0LUdPLMNnmnMGhEYpKx/1AHRkX0IiqNZyDkOcRZU4T08NT/vqvT?=
 =?us-ascii?Q?SPweT5Z22reVfoyXGLU2beowXvpuV+ubq67b3F195KYU6afTkGocZJbukOEn?=
 =?us-ascii?Q?hqi5AQdolHCsQ/IuCFfM/qfHpLHfbYTx5u657c66s7h30s5UpFX6TTNXZRS8?=
 =?us-ascii?Q?n51ac4Mc+3IjvoFq3IZi2PHd2TIICYjgL+U1VrgFzbGBTcxrtdp0Zy3W7mZW?=
 =?us-ascii?Q?wzl4K7+KtI0QSBeJODQHTlspSWcUgRQHAygWRD1EHx1cvnsaRxvfkAMP9UED?=
 =?us-ascii?Q?z5+XMoX8788x9Dn1+BdPzgt6NlWI73vgkxq7QKnhVoGtHBdjizS3ZTZdaz6O?=
 =?us-ascii?Q?LKeUR2f+k8MF6wYh+4YHYnxb9k1HDgBPiPKb2koX6sMCRkcHFfmlrr4daDbZ?=
 =?us-ascii?Q?dTMiMi1V+VKN5S2ew/CH2s2oZ5/Ka0ci5YOOkWt9j53LeJhOCY8AHwhRYee6?=
 =?us-ascii?Q?ZFeZVX4KKNl1oZxRUiZR230cIheOjmRGSaz7OjB8JB34hUFUaB/ShJHWt4xs?=
 =?us-ascii?Q?7BjIm4mA+sDE6yfByuHPkufcqhrLZrknCnu8MKjKjWpBWmhUENkbzzfhthfv?=
 =?us-ascii?Q?Bnhb2Yc/Tq8qBgsQSftSNI9lxEWMECP1b0r6JLtEgsQgVdjiB3a+RoZZgeg0?=
 =?us-ascii?Q?2mdqgYCK0Ak=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XBmxCuzQ/v0LB0pyJeaGVCLSGJgVGRe2pfvzNif9JBkow9LQIPbsaK07wGvZ?=
 =?us-ascii?Q?pHsFmDn1CjpgxjkHUxCrWLiDQ1YuUms0xqMKXrG4RP+w0M2CnL4aUiVeR5zI?=
 =?us-ascii?Q?5TWRKOj8wYj5FOoObSIvPSaTIUyuwqJ1HdR5a+gYNF4X4ImTg46ZiC1uAj26?=
 =?us-ascii?Q?UlCd4AtI+tcMQI3aaImZVDk1NRdQepcT/FRRwzpNMHIXfKdBkfu/p45c7EtI?=
 =?us-ascii?Q?6aKiwDfXKuj/1RUBLtdnBEAGFTgk6Ux8wjHQ4TaiPv+O4KdNUWX0U8rooLOy?=
 =?us-ascii?Q?oCYsI7d8bBvbVnRvJXM6iSZx+MogZTy0Mdo3szaX3ykSWCSDTl9PQ83IBCU/?=
 =?us-ascii?Q?datXGkFvWpn0oIRO2PNEONcM54u0kXJuo+lj28dkTjLN1WgHqOku8L0PZgSJ?=
 =?us-ascii?Q?SjI5kDF2QNsDaqkBbGckGBYhIUCEi3mDlReFBzi77DKv03SEDjj61RX3A1eS?=
 =?us-ascii?Q?45JPavfqZWoJTpmK2pbi5LduIbsXW5LZG1ajyaENdiXr1u+xRTwsYRncMAu7?=
 =?us-ascii?Q?yJeDs/WVwsQO2GY2cuvfn+84BrNW+6ukwQ7a5yNUnQ8rfgBpwMULYViqhRjS?=
 =?us-ascii?Q?SCwL37XIfpCgMHqE7qWX2BPFOkUN/SRmBVfJjY4psb0u0lJJQ0XRUUjgbkRJ?=
 =?us-ascii?Q?uT86RHwqNt34mHzh7N7DWGPf/0kMyk5BO6ALlB+MNkieuPPd02Cj3MNzzdLE?=
 =?us-ascii?Q?AAajval6HUOigysc8qM/CCyh/gpxUxCpSYCzwfWegn1kCeoWc6jMX0rLVMSO?=
 =?us-ascii?Q?7pZtzwCzwa1P2RUVdrJfCRwkcnI8nAu3QBRA775ILWb13MmzOYEPw8bEcnBb?=
 =?us-ascii?Q?gLbj0DFFeXN//FZOIyEOidfJgDELfO8zj62ciulfhbd70HIvxo0rxXRXuOGj?=
 =?us-ascii?Q?mjYhWCneCja/jtTczufCiPKbHQY+rhDVzA2KSW59QaqSwKPJaFcARZYmuJZ9?=
 =?us-ascii?Q?CaOU9d0qhziCg0i8n6xnwGhRN0B6McY074G4ISbcDp+hBn+yWU9ikmfk/10l?=
 =?us-ascii?Q?XE39dP2I5E3H2QSf2eS5EWnKdwFI7QExvwVPF2hHAoZ2ZhfY3BIJc8tIueVf?=
 =?us-ascii?Q?sHX2SJZ8Dz/uWhgbbOurH8948y532Fu2c1KzMi5bV9muFajhKxAlDF7WZ+Gs?=
 =?us-ascii?Q?qiA1+Lcvivso6xUgKl9LjTpuOAjMAFw2H4tI6o3DBvKBghvB2pMoyFuRmMtz?=
 =?us-ascii?Q?XBNXaagvifTqNCxI9hPvfLSWWJ3mChLZ1Y0Y4VIdOBQ0eod228Caog3gsmdP?=
 =?us-ascii?Q?KvrvnQCp77MJEHfxRHoaReMUK+IjXarsTPf94vhsRPhN7P6m4j5Z5ir0LEdd?=
 =?us-ascii?Q?TZ0Yk2XBnnMr2ut+1YijaaVWtT824a+0weYrj0QBe6mI83X4dngskhtv/mE1?=
 =?us-ascii?Q?UFwjputNqPXzyn/KRvSMQcU4r8W4YDRJv1auIdCqD9e7kNjgZYkRbBDAdxGp?=
 =?us-ascii?Q?YWrusdtZ5Vl4PEv/RlkxBxvIcpj44TQX6EHdovNcgNSQxEYZodq83JKuhHEQ?=
 =?us-ascii?Q?NuwIP/G2Hk0ZWy8C9t7d8voVGDkJj3HVOEpPWmysBZ22LD8W16lXEYxipQgo?=
 =?us-ascii?Q?evuKN15z5JhFNKaj2hE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba4e8c0d-3dce-46f9-a4db-08ddefb8a3d4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 15:50:45.9603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AO5uDoByN1Dn2b4OrgtW27caXC9iZz/puSNtGTtVF3cAb9WaevnPHNdrkveYMU2/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5746

On Tue, Sep 09, 2025 at 05:40:21PM +0200, Pratyush Yadav wrote:
> PS: do you know if bitfield layout is reliable for serialization? Can
> different compiler versions move them around? I always thought they can.
> If not, I can also use them in memfd code since they make the code
> neater.

It is specified by the SYSV ABI, compilers are not free to change it.

https://gitlab.com/x86-psABIs/x86-64-ABI/-/blob/master/x86-64-ABI/low-level-sys-info.tex?ref_type=heads#L337

I didn't check ARM64 but would be shocked to find it is not specified.

Jason

