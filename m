Return-Path: <linux-kernel+bounces-742024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C8AB0EC0E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 09:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3516F189B269
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 07:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A4427605A;
	Wed, 23 Jul 2025 07:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="mU4mmTsX"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012069.outbound.protection.outlook.com [52.101.66.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2E917BA6;
	Wed, 23 Jul 2025 07:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753256168; cv=fail; b=iqNZvvjRBxx7yW9LpoA5jYt6K4T/4PtFcVflaPFxSyClydT5U+3fuV1/V9hw7dyy71+UMyfcwm0GDDD+kR5cUkw5KUUo9FindnYhOdGO08Nq+D5MYtqRiQFU1xEV7i5xkA7VGrySxXnjulQABw8NuWGr3+mYx7giPUHQsE3nXPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753256168; c=relaxed/simple;
	bh=gBmbBqWKAgUfTiBfsn2rNOx2HT5GEjFPLVz+iRrYPsM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UauL+15RzpD0ICH8EHV0ZOXio0iZFao6DRYisTLOL8Z4ZNTc6GunwlAKCmrSjKcu1bggM6mnvipe0TnJSzrBchYL4vC4lF9DV3yhYylY5Vk4WMcXBwqsjZLiJX7633Y7PE8hhNE7N6ZGr/jdefY8Z4Xk5Fbd1Kl9t3p74iutmcQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=mU4mmTsX; arc=fail smtp.client-ip=52.101.66.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PuPqoA6Gr7vY+rA/QfyxhAvF1BWbPJql05HjdZE4fMIOlC9LDs7H4Z/8Qgz2Fm2CTuWtx/zARNy5NrgBCycQkFVl0zj8z1VRgZ314wl6k3ul5gamPvQU40RoKwMX9K64lJD90hbmO44dzeySn/BiN4KQvm88vjqxMiGtLd0wrWkvRRr/R8OwX7ZbCmDWpZMcxhIwy9NNpfH2Eqwk1sU13wiwRT8yYDqDAtZvq0ov545ZCRMQ4OxYwpZBc+mVEGLxr4NC9Z6WANg+HZrM8Ut7Bd7MQtJp9F+un2mZyqKt1YH0aaUbJUSX6OvzBT/6dCTyNSVUVWPwYsiHic/w45kL7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2YBi8rnBrR0ACJlKEQ749Dgr70ec0UyGGBGdFqX6aIo=;
 b=jtlg7/V8xknktJZB6SGcgyjA389jD6aMWe4mOyQuvfWn9Iw9Oo5aiajLpZU3+HTTHBQC26py93rhO2hBz60wWp26MzBXmattOxNwM7PC8/kDdfwKsSaKJQ9F9exKmCYQzykWHikibOD+H35zAgd8iHtYBDKmNs80mmpAVf/BSQ9J033OvrB48Zi1g88IRwom1x71lZm5Io49lXtaxKA99GTczx37x7+gmpaZMphX92JP9nGDY8wfScOZsDPCHmYIXGn0hpBt6IVStqb38o0kPMTqjvKPo4Rd459qIsveDHc2p4MmFPT8CrFaBWRUg8QawuTbo22zp8qIp1OROTTHcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.205) smtp.rcpttodomain=collabora.com smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2YBi8rnBrR0ACJlKEQ749Dgr70ec0UyGGBGdFqX6aIo=;
 b=mU4mmTsXUXkvQBTxDVGyaParWMrFLzZRdW6glHli0OEHbTnlwiLu5xniGVWgCp0sAwxYWDb9HugQUa8+J+hRnC+Vfa3B6vxDmcYa3Qj32bIBL3TDzF2ozWcz1tSlMURdYZMbSCRjZzAdgav2V7xms6VoZIuRjwHyNRZ3ihvNR2seta+D8elyzQJPCrtpD7FEJ+K7qVwJrDBA6aPY/AhKZSrqvNL4RQAl5TqC/9NaXWlKctdWQsVTS8xCHip/hcIr2f2XfGhe+9GtAHrxwoN57oWlwZ/TSnxvUPB1TkGkFnKSqeQqg1t4Dk2Mj0hrQUIkJODHetdcDwL1qIQzmSyfeA==
Received: from AS4P250CA0017.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:5e3::6)
 by DU0PR10MB5581.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:31c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Wed, 23 Jul
 2025 07:35:59 +0000
Received: from AMS1EPF00000041.eurprd04.prod.outlook.com
 (2603:10a6:20b:5e3:cafe::32) by AS4P250CA0017.outlook.office365.com
 (2603:10a6:20b:5e3::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.21 via Frontend Transport; Wed,
 23 Jul 2025 07:35:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.205)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.205 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.205; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.205) by
 AMS1EPF00000041.mail.protection.outlook.com (10.167.16.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.20 via Frontend Transport; Wed, 23 Jul 2025 07:35:59 +0000
Received: from FE-EXCAS2000.de.bosch.com (10.139.217.199) by eop.bosch-org.com
 (139.15.153.205) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.26; Wed, 23 Jul
 2025 09:35:52 +0200
Received: from RNGMBX3003.de.bosch.com (10.124.11.208) by
 FE-EXCAS2000.de.bosch.com (10.139.217.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.57; Wed, 23 Jul 2025 09:35:51 +0200
Received: from [10.34.219.93] (10.34.219.93) by smtp.app.bosch.com
 (10.124.11.208) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 23 Jul
 2025 09:35:51 +0200
Message-ID: <6795845d-cda8-44dd-85d2-4d51364e0065@de.bosch.com>
Date: Wed, 23 Jul 2025 09:35:45 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v15 0/3] rust: platform: add Io support
To: Daniel Almeida <daniel.almeida@collabora.com>, Miguel Ojeda
	<ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng
	<boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin
	<lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl
	<aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich
	<dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael
 J. Wysocki" <rafael@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>, "Fiona
 Behrens" <me@kloenk.dev>
References: <20250717-topics-tyr-platform_iomem-v15-0-beca780b77e3@collabora.com>
Content-Language: en-GB
From: Dirk Behme <dirk.behme@de.bosch.com>
In-Reply-To: <20250717-topics-tyr-platform_iomem-v15-0-beca780b77e3@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000041:EE_|DU0PR10MB5581:EE_
X-MS-Office365-Filtering-Correlation-Id: b843fa21-d57b-4237-c39e-08ddc9bb919d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K1Q3MGxOOTJ5REpSa21STGJDUldKeUdqRmFLRlRVZVBVdWVXc1lObE9VL3Z5?=
 =?utf-8?B?ZU00dU9hUHRXYVNSRklmVnczeHM0SHN0ajNSWFZwZWVMbFh4QTluc0p0OG9v?=
 =?utf-8?B?UVRoMmZCdHN6UGVCUDdMbUJiaGl4SnRBeDFVTGNHbGFtNFg1ZUJ2REVPcmZP?=
 =?utf-8?B?OENNRHYrNlQwUFpWWURJZlJuY0w5SVQ5WU04RE5KdCtLaWU1VEd5UEtTSzFC?=
 =?utf-8?B?V0NVWXBZQkNQQnBoWlAyTWNEUWZoZEZVS0hlOWFVeXNsQmVSOWpUUnRTWUd6?=
 =?utf-8?B?MCtQS2c2R2UrL2JkNkNUTkhWd3JLZ21VbGgrTHk2UXVXeUFSeTVkLzBiRVh4?=
 =?utf-8?B?NElvdjRER08zZmRldjlOeGxvWG5LNm5tS1FkOFcycituYUVmMmR0Q0hjM2Vo?=
 =?utf-8?B?dWY4VFY4djRSN0I5RHI0QjY3VFRQNXZ2cXdNbndrOFdxVytLaENWV0R1LzVi?=
 =?utf-8?B?TklXVitEbjJQRFJQcTNSOGMzOEV0YytNMWxqOVJuTzVaWkhINUFsOWZBdWFw?=
 =?utf-8?B?cVhDMzhpcDQ0dmlEdldnc043elg1WlJFNno2dXR6TmFtUTdlSFVsektjRDds?=
 =?utf-8?B?UnR0ZlR5SURSSVo0Zk1yWHVRQ2VrRXZEZjh0TFZ4bXpwTkJlbVBUSHdENWRZ?=
 =?utf-8?B?K1VQRWVjOE5PYmQ1K2R4ZGZQVCt4Y1dsTEg1US9LUnp0N2V0QUw2WFFhZjUz?=
 =?utf-8?B?YlZWa0pwRFhuSUxreHlQWm04S1V5REN0bmNhbSt0c0lPUE53REpxNVhzSWd4?=
 =?utf-8?B?WG4yVStQNy9RQ29EaEUyQUIySTdobUlxQ2VYaENJVDIxc3lvei9jK1IwUkJQ?=
 =?utf-8?B?UTBJbG1ldVo5SzBNbTY1czNERjJNVTFFOXk5MXFXbkc1dmRoOEtoMVdwanFS?=
 =?utf-8?B?dzhwbXlZZ3hweWVncWs5NnBLVzFnaUo3dDdDQVlhZkN1Vm9VZjZtWDg5TXU2?=
 =?utf-8?B?Zng3VFJQcHEzRkVCamx0amloMmlGbDJ5WE56TXJEMEFZcWNlbDhha21JSUxT?=
 =?utf-8?B?dzl4NVByUkhFK2IzY0k5aWFidkdiMkJIZUtEeGh2a3BsNjZ1alVhOU0xdVQ5?=
 =?utf-8?B?K1I5WTRQVHZJRWcvSWw5REM0VmpGMTdhanhnQlJENks2MHdwb2UrYTlSbm0r?=
 =?utf-8?B?SDAzdXVrRjRxMER6a2tNT1YyYjNvc1p6UEp4Q2JHV1RSMHEyckcxd0FsQlpt?=
 =?utf-8?B?RXdndlllb1dCdFVKc3dVOVhJU3d2RkM5VHZPTUhrcTJDMnh3WVNMbGlmOGN4?=
 =?utf-8?B?VzczZFUyUy9rdzZBT1lXK2ZyU09Va21lckR3S2hUejZMNmRWRnJLR0VqdjNr?=
 =?utf-8?B?b0E4dmlaV0cyM0RnY1FhSWY4TU5PL2Fmb1ZjakhPRjRwVVJiSDhONVNxM2NZ?=
 =?utf-8?B?RlhFN245ejkyanNjQmVwUXhqSzhzMWpENHVjbmVQTzFuNC9pVm1kZVl4UXN2?=
 =?utf-8?B?M0E0N25BZldjT3BoOTIvaFgvMTFNN1Z4bXZmTDV4K0dHWElPUENzRUkyOGJU?=
 =?utf-8?B?KzRKMG5zaHVEYTJyOHJwM1FSdVZNRExya2UwUFQ4Z01kbTZYRjlxR25Ldndw?=
 =?utf-8?B?TDErZHd1MEdybCtqT0JaWXpSVlR3b0RLaERGdFFwTC9WbGhKQjhOUldXYnRG?=
 =?utf-8?B?QVhsZXRuYWk0dFVBUTRqbXErRXowS2tRWjJFQ1ZvNmRlbU5CZDlidDdSYjl0?=
 =?utf-8?B?QjFjdGpnRXNqa08rQ2ZQNHZZd3ZxbUcxTnZCc2l0TldxUXBKSHNxRk5raGJI?=
 =?utf-8?B?V3packhLN1dFK1EwUVF6bHNVV0tEYlhQZlhHeTI2QjRMeVVoMURaZitPeW5n?=
 =?utf-8?B?ZTc2ckFLOFdnRGw5Z1VKWThtelVjaEZndzEwemozajhrQllMam9TUlE5WUZ4?=
 =?utf-8?B?T01DMit1L045cmFEMEZVQWl3VGV4SDJic3RZZTdac09MTlZ0T3BrZ2diT2dG?=
 =?utf-8?B?ZlN5WFN4SXhIWmVSTlR5cjBTWnZ5ODhKN3ZGMktzSUFlWjFjRms5NFBjVWpr?=
 =?utf-8?B?UG9QcDdLRlZhd0tYNWN5VVlhZWtHY0tPcG0wOGFjMldaUHdBMWNEZy9BQ0R4?=
 =?utf-8?B?NGhOM3NuamYyS05PVUJDL3dsdkpaS29QbElQZz09?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.205;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 07:35:59.4915
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b843fa21-d57b-4237-c39e-08ddc9bb919d
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.205];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000041.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5581

On 17/07/2025 17:55, Daniel Almeida wrote:
> Changes in v15:
> - Use a default string in ioremap() if the resource doesn't have a name
> - Fix the doctests in mem.rs to use the new name for io_request_by_*
> - Link to v14: https://lore.kernel.org/r/20250716-topics-tyr-platform_iomem-v14-0-2c2709135cb2@collabora.com


I'm not sure if it is too late for this (already applied?) but with

https://lore.kernel.org/rust-for-linux/dd34e5f4-5027-4096-9f32-129c8a067d0a@de.bosch.com/

in case it helps:

Tested-by: Dirk Behme <dirk.behme@de.bosch.com>

Thanks!

Dirk


> Changes in v14:
> - Changed Resource::size() to return ResourceSize instead of u64 (Alice)
> - Changed Resource::name() to return a non-static lifetime (i.e.: the
>   lifetime of &self). It turns out that although this value tends to often
>   point to string literals, this value is not necessarily static  in C.
>   (Thanks for bringing this up, Alice)
> - "name" is now owned by the Region. We were storing Resource::name()
>   previously as that was 'static, but that is not the case anymore. The
>   string is now copied from Resource::name() instead. If there is no name,
>   we fail.
> - Changed Resource::name() to return an Option, as the name may be NULL in
>   C (see the DEFINE_RES_* family of macros in C)
> - Added a TODO to the "size" cast in IoMem::ioremap(), noting that we
>   should fix this in C in the future (Thanks, Alice)
> - Casting "size" in IoMem::ioremap() only once now (thanks, Alice)
> - Introduced Flags::new(), which derives from a comment in the request_irq
>   series. This introduces a build_assert to reduce the number of casts.
> - Added Alice's r-b to patches 1-2
> - Added Miguel's a-b to patches 1-3 (Given in v11 and forgotten)
> - Link to v13: https://lore.kernel.org/r/20250711-topics-tyr-platform_iomem-v13-0-06328b514db3@collabora.com
> 
> Changes in v13:
> - Change ResourceSize to just be bindings::phys_addr_t (Danilo)
> - Mention that ResourceSize can be 32bits even on 64bit architectures (Alice)
> - Use the deref impl for Resource to avoid unsafe (Alice)
> - Change Resource::as_ref() to Resource::from_raw() (Alice)
> - Mention that it's ok for __request_region to store the name as we require
>   it to be 'static
> - Remove all instances of core::ffi::* as these are in the prelude already
>   (Alice)
> - Resource::start() and Resoruce::flags() do not copy &self anymore (Alice)
> - Define the resource::Flags constants within impl Flags itself (Alice)
> - Apply the diff from Danilo to return impl PinInit<...> instead of
>   Result<impl PinInin<...>> from the iomap() functions.
> - Fix the docs in patch 2 (Alice)
> - Use try_into() instead of blindly casting ResourceSize to usize (Alice)
> - Rename request_io_by{index,name} to io_request_by{index,name} (Danilo)
> - Link to v12: https://lore.kernel.org/rust-for-linux/20250704-topics-tyr-platform_iomem-v12-0-1d3d4bd8207d@collabora.com/
> 
> Changes in v12:
> - Fixed the typos that Miguel pointed out in resource.rs
> - Fixed a typo where thread was written as thead
> - Removed ioport_resource() and iomem_resource() (Danilo)
> - Created IoRequest<'a> and gave it an unsafe constructor (Danilo)
> - Moved all the logic to map resources from platform.rs to IoRequest.
> - Dropped the last patch as a result of the above.
> - Link to v11: https://lore.kernel.org/r/20250701-topics-tyr-platform_iomem-v11-0-6cd5d5061151@collabora.com
> 
> Changes in v11:
> - Rebased on top of driver-core-next (to get the latest Devres changes)
> - Changed the order between requesting the resource and mapping it
>   (Danilo)
> - Link to v10: https://lore.kernel.org/r/20250623-topics-tyr-platform_iomem-v10-0-ed860a562940@collabora.com
> 
> Changes in v10:
> - Rebased on driver-core-next
> - Fixed examples (they were still using try_access())
> - Removed map_err() from the examples, as it was not needed.
> - Added a pub use for Resource in io.rs
> - Reworked the platform code to make use of the pub use above
> - Link to v9: https://lore.kernel.org/r/20250603-topics-tyr-platform_iomem-v9-0-a27e04157e3e@collabora.com
> 
> Changes in v9:
> - Rebased on top of nova-next (for Devres::access())
> - Reworked the documentation to add more markdown.
> - Converted to &raw mut instead of addr_of_mut!()
> - Renamed 'from_ptr' to 'as_ref' for consistency
> - Changed the IoMem examples to use the signature for probe()
> - Changed resource() to resource_by_index(). It's a better fit given
>   the existance of resource_by_name().
> - Created a separate patch for the resource accessors above.
> - Moved the accessors into the generic impl block, so they work with all
>   Device contexts.
> - Take Device<Bound> where applicable
> - Renamed "ioremap_*" to "iomap_*", in order to be consistent with the code
>   in pci.rs
> - Switched to Devres::access()
> - Link to v8: https://lore.kernel.org/r/20250509-topics-tyr-platform_iomem-v8-0-e9f1725a40da@collabora.com
> 
> rust: platform: add Io support
> 
> Changes in v8:
> - Rebased on driver-core-next
> - Opted to wait for 'rust/revocable: add try_with() convenience method' to
>   land instead of using the suggested closure (let me know if we should
>   just switch to the closure anyways)
> - Cc'd more people
> - Link to v7: https://lore.kernel.org/r/20250318-topics-tyr-platform_iomem-v7-0-7438691d9ef7@collabora.com
> 
> Changes in v7:
> 
> - Rebased on top of rust-next
> - Fixed a few Clippy lints
> - Fixed typos (Thanks Daniel!)
> - "struct Flags" now contains a usize (thanks Daniel)
> - Fixed "Doc list without indentation" warning (thanks, Guangbo)
> 
> Thanks, Fiona {
> - Removed RequestFn, as all functions simply used request_region and RequestFn
>   had issues. Only request_region() is exposed now.
> - Gated iomem_resource on CONFIG_HAS_IOMEM
> - Require that the name argument be 'static
> }
> 
> - Correctly check for IORESOURCE_MEM_NONPOSTED. We now call ioremap_np if that
>   is set (thanks, Lina!)
> - Remove #[dead_code] attribute from ExclusiveIoMem::region.
> 
> Changes in v6:
> 
> - Added Fiona as co-developer in the first patch, as I merged part of her code
> from the LED driver series (thanks, Fiona)
> 
> - (Fiona) added the ResourceSize type, thereby fixing the u32 vs u64 issues
>   pointed out by Christian
> 
> - Moved the request_region, release_region and friends to resource.rs
> 
> - Added the Region type. This type represents a resource returned by
>   `request_region` and friends. It is also owned, representing the fact
>   that the region remains marked as busy until release_region is called on
>   drop. (Thanks Alice, for pointing out this pattern)
> 
> - Rewrote the IoMem abstraction to implement a separate type for exclusive
>   access to an underlying region. I really disliked the `EXCLUSIVE` const
>   generic, as it was definitely not ergonomic, i.e.:
> 
>   `IoMem<0, false>`
> 
>   ...doesn't really say much. In fact, I believe that boolean parameters
>   hurt readability in general.
> 
>   This new approach lets users build either regular IoMem's, which basically
>   call ioremap under the covers, and ExclusiveIoMem's , which also call request_region
>   via the Region type.
> 
> - Added access to the ioresource_port and ioresource_mem globals.
> 
> Link to v5: https://lore.kernel.org/rust-for-linux/20250116125632.65017-1-daniel.almeida@collabora.com/
> 
> Changes in v5:
> 
> - resend v5, as the r4l list was not cc'd
> - use srctree where applicable in the docs (Alice)
> - Remove 'mut' in Resource::from_ptr() (Alice)
> - Add 'invariants' section for Resource (Alice)
> - Fix typos in mem.rs (Alice)
> - Turn 'exclusive' into a const generic (Alice)
> - Fix example in platform.rs (Alice)
> - Rework the resource.is_null() check (Alice)
> - Refactor IoMem::new() to return DevRes<IoMem> directly (Danilo)
> 
> link to v4: https://lore.kernel.org/rust-for-linux/20250109133057.243751-1-daniel.almeida@collabora.com/
> 
> Changes in v4:
> 
> - Rebased on top of driver-core-next
> - Split series in multiple patches (Danilo)
> - Move IoMem and Resource into its own files (Danilo)
> - Fix a missing "if exclusive {...}" check (Danilo)
> - Fixed the example, since it was using the old API (Danilo)
> - Use Opaque in `Resource`, instead of NonNull and PhantomData (Boqun)
> - Highlight that non-exclusive access to the iomem might be required in some cases
> - Fixed the safety comment in IoMem::deref()
> 
> Link to v3: https://lore.kernel.org/rust-for-linux/20241211-topic-panthor-rs-platform_io_support-v3-1-08ba707e5e3b@collabora.com/
> 
> Changes in v3:
> - Rebased on top of v5 for the PCI/Platform abstractions
> - platform_get_resource is now called only once when calling ioremap
> - Introduced a platform::Resource type, which is bound to the lifetime of the
>  platform Device
> - Allow retrieving resources from the platform device either by index or
>  name
> - Make request_mem_region() optional
> - Use resource.name() in request_mem_region
> - Reword the example to remove an unaligned, out-of-bounds offset
> - Update the safety requirements of platform::IoMem
> 
> Changes in v2:
> - reworked the commit message
> - added missing request_mem_region call (Thanks Alice, Danilo)
> - IoMem::new() now takes the platform::Device, the resource number and
>  the name, instead of an address and a size (thanks, Danilo)
> - Added a new example for both sized and unsized versions of IoMem.
> - Compiled the examples using kunit.py (thanks for the tip, Alice!)
> - Removed instances of `foo as _`. All `as` casts now spell out the actual
>  type.
> - Now compiling with CLIPPY=1 (I realized I had forgotten, sorry)
> - Rebased on top of rust-next to check for any warnings given the new
>  unsafe lints.
> 
> ---
> Daniel Almeida (3):
>       rust: io: add resource abstraction
>       rust: io: mem: add a generic iomem abstraction
>       rust: platform: add resource accessors
> 
>  rust/bindings/bindings_helper.h |   1 +
>  rust/helpers/io.c               |  41 ++++++
>  rust/kernel/io.rs               |   5 +
>  rust/kernel/io/mem.rs           | 283 ++++++++++++++++++++++++++++++++++++++++
>  rust/kernel/io/resource.rs      | 229 ++++++++++++++++++++++++++++++++
>  rust/kernel/platform.rs         |  60 ++++++++-
>  6 files changed, 618 insertions(+), 1 deletion(-)
> ---
> base-commit: f5d3ef25d238901a76fe0277787afa44f7714739
> change-id: 20250318-topics-tyr-platform_iomem-1710a177e1df
> 
> Best regards,



