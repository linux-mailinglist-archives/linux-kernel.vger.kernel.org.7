Return-Path: <linux-kernel+bounces-807373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5135BB4A38B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 09:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B4FA64E156C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 07:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E412307AE1;
	Tue,  9 Sep 2025 07:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="S74u19D+"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012055.outbound.protection.outlook.com [52.101.66.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEF83081A3;
	Tue,  9 Sep 2025 07:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757403023; cv=fail; b=HEtlxVdaV2/fD3edgj70O1hHUVOGVIcQBaBwBALTJ6TvpShrY5jHEZPUCRPOrikRAl35v6Pt/JJAE4wQX5STGIlVvFXdYQ517hTxYFI7aOEFx87btqMA938ou2MJqj7Wc9TXDEMBzRu2ETq+L5GO6Ve7NbwZPePauRD+1WpqOeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757403023; c=relaxed/simple;
	bh=E7Hf5VCZEqNBtcwc5ArzxAvODWPipBuyS5dXfYgOyQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MjU5db3x1K2J56jqzrMpxVvxF24PUj8OMsmVnbqIqtP9Rf4lIEQRvU4PXgvzI6aS9g0nr8057+egpTAB5r9A5YOugKom58o7rxhkiK0ecH2OUcXZRxJknYAZyoYmvHY5Xc+TRJ/6so1ghlrwkYobHpScguKciZNpFMvFtIv6LT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=S74u19D+; arc=fail smtp.client-ip=52.101.66.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h3yvWZBk9r+khT0XBtHKlsTKO+BfM7w2azakPnY0Ar2E50HmQh50WqDlA/91pu8oifkihc9ojw2rvCRhXnH5QwMj/oKAVXvuZZ8TSEwClxg7KW6LLXqqES0isXUoe+IWAa4W3If1rAK8a9ypX5wX0h1bs+jegVbTKlKzVH8kDbA7TN8PY33c1dE4ngs8Lgub7b7C7wDwn/8YmuCqir1a/4eMh6XiqP8mpCzv2TdftbpToNBAkJ9o6BgwVKqh2nfM3gfiQd87J987j91R4Hh3+ip0wxXhTyGv3GAMf1GEv/9yyVs5Y9FAOTCt//bmgzg5NzfDap2ZzN/9CS9q3o1mlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fr2kPHkrILfv3jTzpfO5iIdTlYFfcSS+Dhp0VwJ0e1M=;
 b=VifW7IfX4rG6cIBGzubIERsZoRJZ6h0Ky8oNtfX7iF359hwYU4lugxnXCGf6mTLgHhZh6EyGjnGYHLwNuNJtnJ0Oj0r+TL6N87ZXZBAX5xI7uf2IMJYuHI8UGnR42BJhoW/3PrAwPz2iev/ttjznIdD+8M2iYwZyXHSUeAtcdt1cE0926VrxrgDkRcqjEwLXgfvL2HyQTN2XkbbVaL0O1e2klg5gbXqNFtLqNbnEIODEgWsMGOHn0y1zqbEe5QYFyBQrpGeEHpLK5kWw4XXELK08/DmdMmXJbX60S7HezoDGCdl885tUpTIOp6NOrciDgQUJI1+iBYnmcST8nyZq7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.206) smtp.rcpttodomain=google.com smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fr2kPHkrILfv3jTzpfO5iIdTlYFfcSS+Dhp0VwJ0e1M=;
 b=S74u19D+/MRQqPQh2Lx83G/7V37f65Jec0oyO3ueplrlalL5/uE/WPLKF8HMTMaUk+Ep+QtwziF592v850wpP6T1YZ10Jmdpt/qhmivhOeyqwv/RkucuWHD7boUzfEcjzFFPcXSNJIPg0QyqtCwRU53lRa140KquTMsjUQ9XrSJ4Jviaugs26x/p5YgrkktIZpiwNkxAEI+VtRtdkyOcF/0LX7UFRsx88xE5qt0E1CQZLfvtxqT9dy5CtB/IlQ1PpiW1eSKRbFS1kXMvH0QDQ2LA8/1fLGRwb8pl1DOMs15RWhzGUdw9SiS/Z9i3yaTK0W83VHsQnhXKBtLPzyszVA==
Received: from AM8P251CA0010.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:21b::15)
 by PA1PR10MB8642.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:440::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 07:30:11 +0000
Received: from AMS0EPF0000019D.eurprd05.prod.outlook.com
 (2603:10a6:20b:21b:cafe::69) by AM8P251CA0010.outlook.office365.com
 (2603:10a6:20b:21b::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Tue,
 9 Sep 2025 07:30:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.206)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.206 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.206; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.206) by
 AMS0EPF0000019D.mail.protection.outlook.com (10.167.16.249) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Tue, 9 Sep 2025 07:30:11 +0000
Received: from RNGMBX3003.de.bosch.com (10.124.11.208) by eop.bosch-org.com
 (139.15.153.206) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Sep
 2025 09:30:01 +0200
Received: from [10.34.219.93] (10.34.219.93) by smtp.app.bosch.com
 (10.124.11.208) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Sep
 2025 09:30:00 +0200
Message-ID: <45f6f6e0-bd1e-41e7-8c8e-bb556644a873@de.bosch.com>
Date: Tue, 9 Sep 2025 09:29:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v11 2/7] rust: debugfs: Add support for read-only files
To: Matthew Maurer <mmaurer@google.com>, Miguel Ojeda <ojeda@kernel.org>,
	"Alex Gaynor" <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
	<bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Sami
 Tolvanen <samitolvanen@google.com>, Timur Tabi <ttabi@nvidia.com>, Benno
 Lossin <lossin@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
References: <20250904-debugfs-rust-v11-0-7d12a165685a@google.com>
 <20250904-debugfs-rust-v11-2-7d12a165685a@google.com>
Content-Language: en-GB
From: Dirk Behme <dirk.behme@de.bosch.com>
In-Reply-To: <20250904-debugfs-rust-v11-2-7d12a165685a@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019D:EE_|PA1PR10MB8642:EE_
X-MS-Office365-Filtering-Correlation-Id: e1e6ac3a-47b9-4727-f918-08ddef72b601
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MlJvcTFDdk5LUXg2T0dHZXBYRW9yVXBNd0NpcWhUdk93bWhSZ0VtQXpLUnEv?=
 =?utf-8?B?NFkrQ3NyMmV2ZHJBZkg5Z2U1WUVDcHpLT0xoeFBiRzVON1N0cDJ6b0F6RlNH?=
 =?utf-8?B?WnVkTnRwUElHczl1NEdnc0J0L3NvTmxoQlZySGVnMTkySER4YlRyVWJwRmhl?=
 =?utf-8?B?Mm5nTzRLbFN4c2pGS1VxTkx6QldoY2l5Y0xkQXZIR3BBaHpYdUJrbi9Vbjkw?=
 =?utf-8?B?MkErbzdiU0FtWEEyNlRFcGNpbWJhV2VCMG9ZZDVycDVSODBZeEJOWUlMb2w5?=
 =?utf-8?B?YUo0QU5ETTlHeU93WTJFV01BZVRJTGxwVGZZRTdLUHY4STR3WEh1MkFYd01T?=
 =?utf-8?B?WmZyZFE0Qm1KM1dVRmJkcVpPRmNvUzJrQTd0cnBCLzNSUEhZdnhwUmV3Tnl1?=
 =?utf-8?B?am96UGpOVVpLK0REYXRyRU9DN2pCTEROOHQ5Qk5IMjEzanlvUEhScmdVV3Jp?=
 =?utf-8?B?dHJ2bzNZQTJINGR1Z3B6SGoyM3ZXUXVoTnZJcmdjZlpFUVh4bTQyampwZTBW?=
 =?utf-8?B?TGJQS1JqbnRpTFQvbzV3cWlWdmtZbWhKSFZZRUV5MG92T3hMeVllV3U3NVFO?=
 =?utf-8?B?azkyR1JadHJZL0ZpNkdickExNHBvanVQc2x2M2t4alBvV2dPZzBrekF2dzN1?=
 =?utf-8?B?UnRrNTQ4eVgwcDJXWTZ3NDdnUm9JTFZlWVRJN3U0QStqTW4va3J2ZE5TZzBC?=
 =?utf-8?B?dE9yV0FFNENFeE5mY2dNc1ZYdnVQUjhCekczMG9sQXBJUFZzNGZKT2ZmTEJX?=
 =?utf-8?B?b1pvL1RscVdiajliYW9wNUNScHlGdzZ5MkMzSUE0ZTBWZXVNbG9zV254eUlC?=
 =?utf-8?B?KzlIdTgrYjhhY1lUbWxFbm1KdURjWituVmpJYWFoVDB4WXRYdlJNdG4weEUy?=
 =?utf-8?B?aUtxMTNreDZtOWZVQ1JYU2RvWXByYnhIZXF2ZHJrMmZTeHdTejhJZDdVVEtk?=
 =?utf-8?B?K0NtcGtndHV4UGZTZlpRNm1ZeWo3YjFXQXF4bHRCMkZJMDljMDRXejM3R3B6?=
 =?utf-8?B?YUx4VllyL2RqSUtia1RZclh1MjlEQlRUNTlkK0NDNS9XM0hXM2R1YW4rVnpR?=
 =?utf-8?B?TTJzakxsaU1hL055YnkwMjVzQlhRNnRiNE5Ocm00ajFleEM2OUZKc2x3aFZF?=
 =?utf-8?B?c2dYUGh5MDdnZ0ZSclBhT05HRlgwOXd4TVUzaCt0Q0JGVFlxaWhmTmY0Q3M2?=
 =?utf-8?B?dVRvZlMzTDdabTRCbUFTZ0pvdzBxeXN2K1JzY0VvMTlPQU9xaWRqTXBPUWho?=
 =?utf-8?B?d2RQcHR6ZE05VnRDUExIU1k3SHpIT0NrdytNTWo0aVFEV281R3ljRjlyN3pD?=
 =?utf-8?B?QUFEb0lVV0o5K2hVWTJPZzBBUTY4Z0l5ODUzbHJva3dmWCtmY29yNGllYno3?=
 =?utf-8?B?SENiVU5yY3dsbmwwaTZULyt0SElSR3lhTjNSOUlWUVFoT3czNkhLMmJiVjNr?=
 =?utf-8?B?QzRFK2haK3p1bm5yd3hldDhETGpRWUlXcjlHY0hHeUdWSG1RMUkrdXEwK3VO?=
 =?utf-8?B?WXM5S1BkQmxMOHgxQ0g4NDFxc1E5dUg1SFk4WmlOVWUwZ0VsajE1K2p1OTB6?=
 =?utf-8?B?RFkzeFMrOGRjUDBON1gwK3prbllVYjZJR1pTOUtibGVvQmJIWmRRTWxSZDB6?=
 =?utf-8?B?T0U4QnhpajdlTzFNVkp4WWdvcjJITFJSak5saytCTG9FTVJidXNSaFBtUGZ3?=
 =?utf-8?B?dkJyK0kxUzZjNUUyZ1JHN0pERlJPZmRnRlM3ZDhKcFVYQndPTmEyWi9IdUVN?=
 =?utf-8?B?Q3lPU2UwVkFJRXE5azEyblgzQVlxTUFDeHoxWFFLREM5SmRSZ3d3Vk1ockVz?=
 =?utf-8?B?N3pBZGFVSFFPdVJXYzkvNWtWa3c2WENwUGFqWGhpYVRWdDBlYmFRWVloZWdn?=
 =?utf-8?B?QitIU216c0ZCYXhRMVFaVU13RThLeXJqUzdpUDBudmR4NENmR0MweGVEWXlF?=
 =?utf-8?B?RlJJb3VMa1NXTEw0MnY2ZkVNeE9oTUZhOVNaK01scnZaYjNxRzAxOHpVa0tz?=
 =?utf-8?B?T3k5ZVhmSlI0TWFBTVMwMFFLajQrYlhweUFTUzY0aldIVUx4OWpRUXo3RlRv?=
 =?utf-8?B?d0ZDc0JPYnZhV3BHcW1Ud2pJUU1lVUJiWHhKQT09?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.206;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013)(7053199007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 07:30:11.4640
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1e6ac3a-47b9-4727-f918-08ddef72b601
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.206];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF0000019D.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8642

On 04/09/2025 23:13, Matthew Maurer wrote:
> Extends the `debugfs` API to support creating read-only files. This
> is done via the `Dir::read_only_file` method, which takes a data object
> that implements the `Writer` trait.
> 
> The file's content is generated by the `Writer` implementation, and the
> file is automatically removed when the returned `File` handle is
> dropped.
> 
> Signed-off-by: Matthew Maurer <mmaurer@google.com>
> ---
>  rust/kernel/debugfs.rs          | 148 +++++++++++++++++++++++++++++++++++++++-
>  rust/kernel/debugfs/entry.rs    |  42 ++++++++++++
>  rust/kernel/debugfs/file_ops.rs | 128 ++++++++++++++++++++++++++++++++++
>  rust/kernel/debugfs/traits.rs   |  33 +++++++++
>  4 files changed, 350 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/debugfs.rs b/rust/kernel/debugfs.rs
> index 65be71600b8eda83c0d313f3d205d0713e8e9510..b28665f58cd6a17e188aef5e8c539f6c7433a3b0 100644
> --- a/rust/kernel/debugfs.rs
> +++ b/rust/kernel/debugfs.rs
> @@ -8,12 +8,18 @@
>  // When DebugFS is disabled, many parameters are dead. Linting for this isn't helpful.
>  #![cfg_attr(not(CONFIG_DEBUG_FS), allow(unused_variables))]
>  
> -#[cfg(CONFIG_DEBUG_FS)]
>  use crate::prelude::*;
>  use crate::str::CStr;
>  #[cfg(CONFIG_DEBUG_FS)]
>  use crate::sync::Arc;
> +use core::marker::PhantomPinned;
> +use core::ops::Deref;
> +
> +mod traits;
> +pub use traits::Writer;
>  
> +mod file_ops;
> +use file_ops::{FileOps, ReadFile};
>  #[cfg(CONFIG_DEBUG_FS)]
>  mod entry;
>  #[cfg(CONFIG_DEBUG_FS)]
> @@ -53,6 +59,34 @@ fn create(name: &CStr, parent: Option<&Dir>) -> Self {
>          Self()
>      }
>  
> +    /// Creates a DebugFS file which will own the data produced by the initializer provided in
> +    /// `data`.
> +    fn create_file<'a, T, E: 'a>(
> +        &'a self,
> +        name: &'a CStr,
> +        data: impl PinInit<T, E> + 'a,
> +        file_ops: &'static FileOps<T>,
> +    ) -> impl PinInit<File<T>, E> + 'a
> +    where
> +        T: Sync + 'static,
> +    {
> +        let scope = Scope::<T>::new(data, move |data| {
> +            #[cfg(CONFIG_DEBUG_FS)]
> +            if let Some(parent) = &self.0 {
> +                // SAFETY: Because data derives from a scope, and our entry will be dropped before
> +                // the data is dropped, it is guaranteed to outlive the entry we return.
> +                unsafe { Entry::dynamic_file(name, parent.clone(), data, file_ops) }
> +            } else {
> +                Entry::empty()
> +            }
> +        });
> +        try_pin_init! {
> +            File {
> +                scope <- scope
> +            } ? E
> +        }
> +    }
> +
>      /// Create a new directory in DebugFS at the root.
>      ///
>      /// # Examples
> @@ -79,4 +113,116 @@ pub fn new(name: &CStr) -> Self {
>      pub fn subdir(&self, name: &CStr) -> Self {
>          Dir::create(name, Some(self))
>      }
> +
> +    /// Creates a read-only file in this directory.
> +    ///
> +    /// The file's contents are produced by invoking [`Writer::write`] on the value initialized by
> +    /// `data`.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// # use kernel::c_str;
> +    /// # use kernel::debugfs::Dir;
> +    /// # use kernel::prelude::*;
> +    /// # let dir = Dir::new(c_str!("my_debugfs_dir"));
> +    /// let file = KBox::pin_init(dir.read_only_file(c_str!("foo"), 200), GFP_KERNEL)?;
> +    /// // "my_debugfs_dir/foo" now contains the number 200.
> +    /// // The file is removed when `file` is dropped.
> +    /// # Ok::<(), Error>(())
> +    /// ```
> +    pub fn read_only_file<'a, T, E: 'a>(
> +        &'a self,
> +        name: &'a CStr,
> +        data: impl PinInit<T, E> + 'a,
> +    ) -> impl PinInit<File<T>, E> + 'a
> +    where
> +        T: Writer + Send + Sync + 'static,
> +    {
> +        let file_ops = &<T as ReadFile<_>>::FILE_OPS;
> +        self.create_file(name, data, file_ops)
> +    }
> +}
> +
> +#[pin_data]
> +/// Handle to a DebugFS scope, which ensures that attached `data` will outlive the provided
> +/// [`Entry`] without moving.
> +/// Currently, this is used to back [`File`] so that its `read` and/or `write` implementations
> +/// can assume that their backing data is still alive.
> +struct Scope<T> {
> +    // This order is load-bearing for drops - `_entry` must be dropped before `data`.
> +    #[cfg(CONFIG_DEBUG_FS)]
> +    _entry: Entry,
> +    #[pin]
> +    data: T,
> +    // Even if `T` is `Unpin`, we still can't allow it to be moved.
> +    #[pin]
> +    _pin: PhantomPinned,
> +}
> +
> +#[pin_data]
> +/// Handle to a DebugFS file, owning its backing data.
> +///
> +/// When dropped, the DebugFS file will be removed and the attached data will be dropped.
> +pub struct File<T> {
> +    #[pin]
> +    scope: Scope<T>,
> +}
> +
> +#[cfg(not(CONFIG_DEBUG_FS))]
> +impl<'b, T: 'b> Scope<T> {
> +    fn new<E: 'b, F>(data: impl PinInit<T, E> + 'b, init: F) -> impl PinInit<Self, E> + 'b
> +    where
> +        F: for<'a> FnOnce(&'a T) -> Entry + 'b,

Inspired by Greg's & Danilo's discussion I tried building with
CONFIG_DEBUG_FS disabled. And get

error[E0412]: cannot find type `Entry` in this scope
   --> rust/kernel/debugfs.rs:351:37
    |
351 |         F: for<'a> FnOnce(&'a T) -> Entry + 'b,
    |                                     ^^^^^ not found in this scope

And giving it some Entry (for my 1.81.0)

error: hidden lifetime parameters in types are deprecated
   --> rust/kernel/debugfs.rs:352:37
    |
352 |         F: for<'a> FnOnce(&'a T) -> Entry + 'b,
    |                                     ^^^^^ expected lifetime parameter

Dirk

