Return-Path: <linux-kernel+bounces-791139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA6CB3B264
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 07:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC162203F06
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 05:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205FF21859A;
	Fri, 29 Aug 2025 05:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="mVXkouDg"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011048.outbound.protection.outlook.com [40.107.130.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAECD8488;
	Fri, 29 Aug 2025 05:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756445016; cv=fail; b=jd3snpWp4dwOwSifDbX/E5wAmSrlPGGUemysO+DB7kZQG/+hbbfwcM0/GdH6AvNzWvHvsWYzgOYBIitJLALiTu/e5xkmQ8Nuf0YrxIkfm+Qe/gv/9dfsr0fonUTBWWeYz4/nbHLM9ftCydRYI9jSjfmSGgEJ79TfMgCRxNZ9BFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756445016; c=relaxed/simple;
	bh=GdpLZIbcTH7C61ISYZXbRyUwAF36ob0iu72wmiuVj9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=uiJxk4W/Ua4ty30+98KJ9ka9g5GAasGG2ALAPEJ1Gr5QToVWkTleizG0cnYiM1pj3Or4gZ/EjtYoHgiWY24Xbgp1QBuXUKUuGH1txhU+NNUTef9I/JzvdEfJBxf8+JxUBfzlde0I4hkEYm2F7DFRC1LYcWieZRti/YHRxVEm2yo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=mVXkouDg; arc=fail smtp.client-ip=40.107.130.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=paMrYwPzH/ntjk1SSIXtyvBM5+pgl38O/cCPJwR639ZdjkKNDMTQZ7WpvJ2ge+5RtgSjJ5N+QXhMLYQC6dGmOxLBDTdkwbMcy/eqEKUZQs1pAKqM8AKwnKnjj+pg+ThqizfMfj1NV6+5uGdh8Ed+gwTvRVc1If32nk6SJDPYNfU57mxiYt1QepfJj1mlhyK/h295x4xCk2YbvDDl4D2wMP8iTrpFx+Nv5J00DEV4Cpn+YHiqxpp4FEe+swH+4MBK6W3Hgf5wL4kK31iLpPcqLRoagH1IAjSryVJkyjWYduF6mMVoQZSt5s6u/8KkaUDjjINrNAy5RR3R0PiD2XOrpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zbafPJKMVvVNF6mGPxz90vKugrWDeM09lxYHmXDFOUw=;
 b=PXTcTMmIn5OEAK8k8Y+xIHXrM3vdnvyLU3042jsmCIJK3yBdrjDspPyF+j1g8WWw+AkWSea59FBe4/HXnmNKHhD32xXVvWxmcHyolOZeW8D6VdzPOilEVD0MXHil7HMmPtMvJBUOREFhilOIlIP/btIoWNHIdzVdcXxnxBybiBMGqPiMQ7lXkV3nrVBor5O5W/1FUzfvqd0Qudve7RFyfZsbEdj/4pNJN8y/HG1uZcA4cI5Zntz5gO7aVY0kY3f2+JUggRfKdBKST5d2IWM+h78EABq45Cs36kLx8fjNwXFh9bXQ/e6Zyip4QKIHoE+Bqar4idVlogI6WMc25S9teg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.206) smtp.rcpttodomain=kernel.org smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zbafPJKMVvVNF6mGPxz90vKugrWDeM09lxYHmXDFOUw=;
 b=mVXkouDgKd7AXFdyPK4su0PmHVmhon+SkGfvwfFbFm4Cpej/PImcL3DrdZ05D/bFvkDVWh89NAPCSWalEBZCHHp9ezUoq81k+kBGOZji3wpuLYVkJSAg5rDiQ/zhXmkJ4G1Exqp2rp1NsnSi7RHB0WZOzMeaZSzq/yTnaRAkaT+3qdK4xb8rDdyIkdppJcOprTtxVAIeI/Nu9YIxGz8SEgKUEEloewTPaLR2Re/78tCmbHkcU4+CZwwanrLccq6EelKCLHzEDyMyQavD/J3t7NobFQht0AnEyjKHIU1PZ78LP+C4NsbEZR8ihh7vpL+NpUEdIvxMcDYvU2IAo8xaTw==
Received: from DU2PR04CA0284.eurprd04.prod.outlook.com (2603:10a6:10:28c::19)
 by AM7PR10MB3761.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:175::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.14; Fri, 29 Aug
 2025 05:23:30 +0000
Received: from DU6PEPF00009528.eurprd02.prod.outlook.com
 (2603:10a6:10:28c:cafe::b4) by DU2PR04CA0284.outlook.office365.com
 (2603:10a6:10:28c::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.17 via Frontend Transport; Fri,
 29 Aug 2025 05:23:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.206)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.206 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.206; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.206) by
 DU6PEPF00009528.mail.protection.outlook.com (10.167.8.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.11 via Frontend Transport; Fri, 29 Aug 2025 05:23:29 +0000
Received: from FE-EXCAS2001.de.bosch.com (10.139.217.200) by eop.bosch-org.com
 (139.15.153.206) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.36; Fri, 29 Aug
 2025 07:23:16 +0200
Received: from RNGMBX3003.de.bosch.com (10.124.11.208) by
 FE-EXCAS2001.de.bosch.com (10.139.217.200) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.58; Fri, 29 Aug 2025 07:23:16 +0200
Received: from [10.34.219.93] (10.34.219.93) by smtp.app.bosch.com
 (10.124.11.208) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 29 Aug
 2025 07:23:16 +0200
Message-ID: <80b7923e-78a0-4de6-bf95-ad7b45171a40@de.bosch.com>
Date: Fri, 29 Aug 2025 07:23:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v4 2/4] rust: create basic untrusted data API
To: Benno Lossin <lossin@kernel.org>, Simona Vetter <simona.vetter@ffwll.ch>,
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, "Boqun
 Feng" <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg
	<a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross
	<tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Wedson Almeida Filho
	<wedsonaf@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, "Tamir
 Duberstein" <tamird@gmail.com>, Xiangfei Ding <dingxiangfei2009@gmail.com>,
	Greg KH <gregkh@linuxfoundation.org>
CC: Benno Lossin <benno.lossin@proton.me>, <linux-kernel@vger.kernel.org>,
	<rust-for-linux@vger.kernel.org>
References: <20250814124424.516191-1-lossin@kernel.org>
 <20250814124424.516191-3-lossin@kernel.org>
Content-Language: en-GB
From: Dirk Behme <dirk.behme@de.bosch.com>
In-Reply-To: <20250814124424.516191-3-lossin@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF00009528:EE_|AM7PR10MB3761:EE_
X-MS-Office365-Filtering-Correlation-Id: 0aee4391-499f-40ef-237b-08dde6bc308c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZWVPdmQxVjA0b2F3cEFERTRBQTJZOUMyT1JwRUZuNzQ1dklzUjFBN0xuVTEx?=
 =?utf-8?B?eHozZDQ2THgyTFRRZ1FSdEpIYks2dmdSaXkzSzcwYkp5WXI3MFZ0YkRldFdP?=
 =?utf-8?B?ME1aOUtpUFdRNExlS2VxNjVmdXQ3ZEthZGRwTjlCczFGcG1ZUVRxeHhoQnVC?=
 =?utf-8?B?YWNVb2hxMlU2Mm5pTEUzZkJBWUlNcWhMQklTSTVKU2p2U0R2NjI1SjhUcVJR?=
 =?utf-8?B?UWhqUzlZcnhVVDRKVEJTbjZBdFY5b0g5QXNYT0dVSXN3YWZWeGhvTVVZOTBs?=
 =?utf-8?B?MDlGOWlFTkRMU3RFdnpPVWd6YnhhdTdoMWd4cTJEYnJzVGNKWTU1aWVQTnRi?=
 =?utf-8?B?UDY3dTIveXVCRWEzQVlFSVhWUFJEYXlRZTRIdzlYcmJtazR4TXFnWmxwYXFq?=
 =?utf-8?B?SUhnQjYxa293NEFTZHFteGcrR2RUdzZta1dWS013TGNaTWRTN09sT0lCREdE?=
 =?utf-8?B?emJDeXErMW1pdnBPMnRTd2Z5cW5aOFV2VlduV1d2bS9SVzlQQU5oL2JZZDBO?=
 =?utf-8?B?Z3FudXNkVUVabU96NEt6c1o3TFdTekNLVjRaWnpYekFRNnBBdWJMd0Jac3lU?=
 =?utf-8?B?d0xySGI5WEVUS1dZaVI1L280R3FaeXpveTVvM3lhVTJKVVQ1M25oWUZkRU1E?=
 =?utf-8?B?L1pCb05LSEFublVGQWVwbUJZY1JOMjUwa241Qm5NN3NidkFLcHVSaElveCtw?=
 =?utf-8?B?QkRRN0d3KzVRKy8xdXU5V0pwM3pIM3hrbCtKZDdMbmV0bXlrOHZkZVNpK3Na?=
 =?utf-8?B?dUQ0ZUdFTnk2Z0xKeHF6VnU4bHIxQWhuYmVRUVFSMGF6U2VabWRVbWRERDhx?=
 =?utf-8?B?Zy9BSnJmYXZOcXIwZVBBamNheHlxbTZ0TW42dzQ3eGdseHBYWVd5T0RrYTJw?=
 =?utf-8?B?U01xTU8ySmJXVzRnaEk5NVRHM1RleG5RSGd5OTU4WnZsZlI2MEtSNlYvN0Jt?=
 =?utf-8?B?TVhGUkc1STZTRERQRXVSMzFnaW95UzY3enA2K2g0UmdHYnpMYzNBUGh4VU5m?=
 =?utf-8?B?ZXZmSDNQcHExMTlzYzJNeFBmM3AvUTNxTnpwVmFocFNXbGFXZFIvWXF2SHF4?=
 =?utf-8?B?dGpzYUcrME5UOGpuRUwzeUhaUnVFWTR1NFBtNVFYSzc1eGV2R2pSSHlwT3pp?=
 =?utf-8?B?d2FUOEswZFpJMkxSTGIrNXlreC93cWFmQ0NtQ1hwK0V0YVNyT1RvcktSaStV?=
 =?utf-8?B?SndaTnpDMmE4bVBjQkFUVjdoTlo2MHVuQUsrNGZIVWJkQlMvK1c1UG1QSHJM?=
 =?utf-8?B?SXR5dllmNWhhQzRGN2Rsd0k2MFpEMUtBRkFtS3JZb1lBZDVmV0gxd1dGQTNo?=
 =?utf-8?B?d0RxTGxxZENSWmx6eWJxS0V3ek4ya0EyZ2VhSVNlVXFJYVpFT0hvUExlVHhR?=
 =?utf-8?B?TDVkN0NIL1ZwdnZoRmtaMnRnYlVBNUhCUVp3SjZFM2VUOVFDejhWaTcvdWdz?=
 =?utf-8?B?bXFPMW5vYmFkTmcwdmJoRzBjQ2h2ck5rMGcvRVRQNEJWdjl0YXNlZ3ZiMENL?=
 =?utf-8?B?YlNHY1ppeG1MZTlXODRpbEpmS1orYWdnWTA1eCtEZXFSMTBiQnJscmFBRElT?=
 =?utf-8?B?VmQzcDVsWUZXOTQyVkF2YUx5UXgwSVAyWlQ1d2ZWVzF0Zm5GbUowZTdrNTVK?=
 =?utf-8?B?TVdPY1hKOGVKTlEzQ0VNMWhKWkVJNjBtekR1Z0xwamVSTGFSUFAyOHNudUhG?=
 =?utf-8?B?dVJ5Z0dpZW5hVE1MdXBDMkJUa0VwMUtTUVFYckdtRDlZV2xmdmVkY2FMejIr?=
 =?utf-8?B?cG5wOU9UOUpMMmtjMWV5R1J0YjBZa1VWakloUVZ2eEcwZTdwQ042aFdSd2Vk?=
 =?utf-8?B?cS9LUVpPeVBUZGFWTTd2L1A4TlJ1TzdWWlJtblZMem9XSWptS0FMQnRnSjNB?=
 =?utf-8?B?U2FSYVIvOHdvRy9NMitCVnp3cnlKdkRTY21hRENlcGNxT1VmMW1RME5LcGln?=
 =?utf-8?B?OGdiaEp1ajh2NzgvUHBxdk5hVm9CYTU2VTZ2WWxuN0NnZjErN1NLQ0E5b1pC?=
 =?utf-8?B?dkpuWVl3SlZSMFgzaS8rRHBoTFpMM2xzcmtDamg1YitjWUVsUTRTSHV3a3BY?=
 =?utf-8?B?TUE2NzhMTXpPNm44N1VKTUk2Uk5FdFM5UkhLdz09?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.206;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 05:23:29.8240
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aee4391-499f-40ef-237b-08dde6bc308c
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.206];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF00009528.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3761

Hi Benno,

two minor comments:

On 14/08/2025 14:44, Benno Lossin wrote:
> From: Benno Lossin <benno.lossin@proton.me>
> 
> When the kernel receives external data (e.g. from userspace), it usually
> is a very bad idea to directly use the data for logic decision in the
> kernel. For this reason, such data should be explicitly marked and
> validated before making decision based on its value.
> 
> The `Untrusted<T>` wrapper type marks a value of type `T` as untrusted.
> The particular meaning of "untrusted" highly depends on the type `T`.
> For example `T = u8` ensures that the value of the byte cannot be
> retrieved. However, `T = [u8]` still allows to access the length of the
> slice. Similarly, `T = KVec<U>` allows modifications.
> 
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
> ---
>  rust/kernel/lib.rs      |   1 +
>  rust/kernel/validate.rs | 142 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 143 insertions(+)
>  create mode 100644 rust/kernel/validate.rs
> 
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 99dbb7b2812e..f9dcf079b903 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -128,6 +128,7 @@
>  pub mod transmute;
>  pub mod types;
>  pub mod uaccess;
> +pub mod validate;
>  pub mod workqueue;
>  pub mod xarray;
>  
> diff --git a/rust/kernel/validate.rs b/rust/kernel/validate.rs
> new file mode 100644
> index 000000000000..1f75ccb79532
> --- /dev/null
> +++ b/rust/kernel/validate.rs
> @@ -0,0 +1,142 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Untrusted data API.
> +//!
> +//! # Overview
> +//!
> +//! Untrusted data is marked using the [`Untrusted<T>`] type. See [Rationale](#rationale) for the
> +//! reasons to mark untrusted data throughout the kernel. It is a totally opaque wrapper, it is not
> +//! possible to read the data inside.
> +//!
> +//! APIs that write back into userspace usually allow writing untrusted bytes directly, allowing
> +//! direct copying of untrusted user data back into userspace without validation.
> +//!
> +//! # Rationale
> +//!
> +//! When reading data from an untrusted source, it must be validated before it can be used for
> +//! **logic**. For example, this is a very bad idea:
> +//!
> +//! ```
> +//! # fn read_bytes_from_network() -> KBox<[u8]> {
> +//! #     Box::new([1, 0], kernel::alloc::flags::GFP_KERNEL).unwrap()
> +//! # }
> +//! let bytes: KBox<[u8]> = read_bytes_from_network();
> +//! let data_index = bytes[0];
> +//! let data = bytes[usize::from(data_index)];
> +//! ```
> +//!
> +//! While this will not lead to a memory violation (because the array index checks the bounds), it
> +//! might result in a kernel panic. For this reason, all untrusted data must be wrapped in
> +//! [`Untrusted<T>`]. This type only allows validating the data or passing it along, since copying
> +//! data from userspace back into userspace is allowed for untrusted data.
> +
> +use core::ops::{Deref, DerefMut};
> +
> +use crate::{
> +    alloc::{Allocator, Vec},
> +    transmute::{cast_slice, cast_slice_mut},
> +};
> +
> +/// Untrusted data of type `T`.
> +///
> +/// Data coming from userspace is considered untrusted and should be marked by this type.


Regarding "data coming from userspace": It's not limited to userspace,
no? In the example above you use "read from network". I like the wording
from the commit message more: "external data (e.g. from userspace)". Or
"untrusted source".


> +///
> +/// The particular meaning of [`Untrusted<T>`] depends heavily on the type `T`. For example,
> +/// `&Untrusted<[u8]>` is a reference to an untrusted slice. But the length is not considered
> +/// untrusted, as it would otherwise violate normal Rust rules. For this reason, one can easily
> +/// convert that reference to `&[Untrusted<u8>]`. Another such example is `Untrusted<KVec<T>>`, it
> +/// derefs to `KVec<Untrusted<T>>`. Raw bytes however do not behave in this way, `Untrusted<u8>` is
> +/// totally opaque.
> +///
> +/// # Usage in API Design
> +///
> +/// The exact location where to put [`Untrusted`] depends on the kind of API. When asking for an
> +/// untrusted input value, or buffer to write to, always move the [`Untrusted`] wrapper as far
> +/// inwards as possible:
> +///
> +/// ```ignore
> +/// // use this
> +/// pub fn read_from_userspace(buf: &mut [Untrusted<u8>]) { todo!() }
> +///
> +/// // and not this
> +/// pub fn read_from_userspace(buf: &mut Untrusted<[u8]>) { todo!() }
> +/// ```
> +///
> +/// The reason for this is that `&mut Untrusted<[u8]>` can beconverted into `&mut [Untrusted<u8>]`


Missing space? "be converted"

Thanks!

Dirk

