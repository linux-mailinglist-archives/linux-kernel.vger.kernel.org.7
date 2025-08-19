Return-Path: <linux-kernel+bounces-774900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 876CBB2B8F6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 07:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 059CC189DC25
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 05:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4745221FA0;
	Tue, 19 Aug 2025 05:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b="N3HE1RoS"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010037.outbound.protection.outlook.com [52.101.69.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEC1225390;
	Tue, 19 Aug 2025 05:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755582763; cv=fail; b=Dqa7jdN6HMNwTZIaj0X4rpkG4wTMJ5zdwGpgk32d/FS7dYwzA8oD1bFhdKmHPqlWsROzkx4v7OCgR5XPZQKTp+0sPPlPUdb8aQ5flPNoGZJ06nQyYKcW4X0V7ZV0EOkjpyYuef/j3kUHqcmyxex5BKy6LQ/h+pnAOEuFjdW5pvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755582763; c=relaxed/simple;
	bh=VapXdJBYEyAcMKDIjks0vKNNNWEMjHVPGGMzfeYb7n4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NPQrXPNGEGtzaGsbD3nehP9GtU6F5eFjgoGwUh/e1ejkJPrbTHWWEy3Y3RMFrrunmQAP5W35X41oW6CbP3EhaxDLndoUQpLuD9bf0kVY1rz6VqFfJO5g9WvVn+EixtwAsRympHfvw1G61eMQlNhFICMLjhm4lJjrd8jGYa1fJmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com; spf=pass smtp.mailfrom=de.bosch.com; dkim=pass (2048-bit key) header.d=de.bosch.com header.i=@de.bosch.com header.b=N3HE1RoS; arc=fail smtp.client-ip=52.101.69.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PIeyEoJsdjpo7VrpyTEwzQ/VDeFFBLamktXhHLeon6gSZDMMD3MDScxdxHFbYXsdpukMqP0YW3VLc//zkmPFfDnV+vx2rv+D5fqJZRZP81ZtCNdYkMUEa+EbT/ZrMHF3kFQy550KSHOVlAPV0keJxs64L2wujwbOszrTo7/WF5z8+v0ZYY4vp9sJNC9gTWVAbHAEV72j3at5K87nPbKO28wwYQTulNOIDv4iuJoAQuMiTYZJBxPv1I/VTNczgWzSIdm2Bz/dhtZxAmsla4zf0gqIsxGJcrQHpkRjcCCSqgV0NcmebBdnkLMU61GYtB/JeHf0KcAkmQnn+FmC1ZHXdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NHpUSsTnHqAict/pKHkctdMw8++RG7fIDARYo5lFmdw=;
 b=VmTQDliXBFAzZFsd9NwF07MdFmj97L/JJm92/ozVCvCTFakSCNtmAUJYMZOWo405pPjR5pgDCCiYS+/88up+kQoKrCeQB5avd3ixcBrm8PM+RqlW9fkwe824zycbePO5KcokrzLcVFgYVC37KQ54tNMwnTtDdlsXnUo+fW2wyVch9J0ETszsJrk1Cai3h5KsKLrZCZLtTZMQ+kUiXliMiGAV7Lyd0gpkOc44zYXndjb9IOjXdvAEGE/IkU99Ob/sGAHdG78pWK+Y2bFyfmMaCIBpixjAjYdfxch9FpxE2hhaVqVHdD6OQay0Y/jrkKZnzTyz3zOIcMyq1L2zH7Kfwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.206) smtp.rcpttodomain=google.com smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NHpUSsTnHqAict/pKHkctdMw8++RG7fIDARYo5lFmdw=;
 b=N3HE1RoSINTKVHbljNFCcIRV/MGHhnYYAd/ezU3iIfe8Tt5MZTWlrxMLuBK5Z0EkgkYlbi6sD/zhI4rS03NU2C3EeIwi0Xrd+XBjo1Rivl0c/CCv+MGVFU22wJR+6topnbxDAQ/eBWkB7JsOsLz4gOERHpZ4TwiWSkZ+zUuhMeSXvtqbkS5labjxwMRO7lYfvt6eHKH9cLtNFimEM1vO3MhL3NaZ4DgqWQC92jp9EAsosumgMxaWizjmmwRY5puapB5SH0io8DnaodkedN+1ciiZ1HAxs3RJvuOkDfpAjbODFlyNa61MWF4kiy742O5OycVFLpdDwqipHR1YSRc0/A==
Received: from DB7PR05CA0043.eurprd05.prod.outlook.com (2603:10a6:10:2e::20)
 by AM7PR10MB3875.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Tue, 19 Aug
 2025 05:51:44 +0000
Received: from DB1PEPF000509EE.eurprd03.prod.outlook.com
 (2603:10a6:10:2e:cafe::f0) by DB7PR05CA0043.outlook.office365.com
 (2603:10a6:10:2e::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.22 via Frontend Transport; Tue,
 19 Aug 2025 05:51:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.206)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.206 as permitted sender) receiver=protection.outlook.com;
 client-ip=139.15.153.206; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.206) by
 DB1PEPF000509EE.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Tue, 19 Aug 2025 05:51:44 +0000
Received: from SI-EXCAS2001.de.bosch.com (10.139.217.202) by eop.bosch-org.com
 (139.15.153.206) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.36; Tue, 19 Aug
 2025 07:51:43 +0200
Received: from RNGMBX3003.de.bosch.com (10.124.11.208) by
 SI-EXCAS2001.de.bosch.com (10.139.217.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.58; Tue, 19 Aug 2025 07:51:43 +0200
Received: from [10.34.219.93] (10.34.219.93) by smtp.app.bosch.com
 (10.124.11.208) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 Aug
 2025 07:51:42 +0200
Message-ID: <2a0f2965-af37-4ffe-8806-3bb469361b1d@de.bosch.com>
Date: Tue, 19 Aug 2025 07:51:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v9 3/5] rust: debugfs: Support `PinInit` backing for
 `File`s.
To: Matthew Maurer <mmaurer@google.com>, Miguel Ojeda <ojeda@kernel.org>, Alex
 Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo
	<gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
	<bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, "Sami
 Tolvanen" <samitolvanen@google.com>, Timur Tabi <ttabi@nvidia.com>, "Benno
 Lossin" <lossin@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
References: <20250709-debugfs-rust-v9-0-92b9eab5a951@google.com>
 <20250709-debugfs-rust-v9-3-92b9eab5a951@google.com>
Content-Language: en-GB
From: Dirk Behme <dirk.behme@de.bosch.com>
In-Reply-To: <20250709-debugfs-rust-v9-3-92b9eab5a951@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509EE:EE_|AM7PR10MB3875:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f484411-1836-46ed-706e-08dddee47a88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|1800799024|376014|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RWZGV0l4aEJaalAybjJTQlQvOXZOQUJNbVZtc01xeVEvMnRpMmkyUG5EbzRy?=
 =?utf-8?B?Ujg0ZXRaYXY5RzFRSFdCZG5mVVh2WTk5UDlmNGJnK1dVMkJ1a2s3OVVreUd6?=
 =?utf-8?B?aGJOaEViWFdaMjVIaldKb0tHTTdMeEZNSER3U05LajVkMXliM2lkTFloaHpp?=
 =?utf-8?B?WVlOaVJKcDY0ODlBUnZPZy9Uam1ScWpUY2lnNU84T0dFcFlQU2JxTE9zOEhi?=
 =?utf-8?B?UDFPY3RkV2tMWElHczRwWGw0QnBFamJoTnhMQXhyTlZSV041bE1RczRndTNF?=
 =?utf-8?B?S3ZQb21ETzFFMjhUTCtRV04yN0oyN2Ywa1NoeUNqdU12NmxCSFpHSXoxNFlp?=
 =?utf-8?B?R2QvSlpqMXhPQVBSWjdwTlhIRFZXNEJiMGplWE51aHdkN2hoSjlrc3hQZUdV?=
 =?utf-8?B?eU54aXJPN2pOVGkzU2VubHIzVG1TOGNGTy9IZis5NUVvZldlaWg0RmZ1cVUr?=
 =?utf-8?B?TkRxMTJ1YVFlM0gwYjhobUI1bnlKTXVqai9ubGpSRGNNZFJhMVQySytpN2x0?=
 =?utf-8?B?WXBvc3R2Ny9QUlBYMGJlVFlLdks3a2twa214UzlMMFd1dmVUOWNSR1ZGOVho?=
 =?utf-8?B?a0g5ejEzb3J6aXR0TEZGU1AzeXcvcjRmYTl5SUtHbEJvcUc0QXhqS3Fhb1lr?=
 =?utf-8?B?NEFCWExjSGJ2ZTd0dC9GVzV4d2NLUUVsbFhDMjRoeGhYOURsYXFibkhKTk41?=
 =?utf-8?B?U0xjaktSSnlpdkZDZXZ1bTFCZUgyeHlnbTRJeGtzd1JWaGFtRXhTYWdicEFQ?=
 =?utf-8?B?eW14L2ZtY1VNYjZqVVRiaGFOSFAwRFRucmErN3VhQ29tTzRONDZtMHZNQ3VP?=
 =?utf-8?B?enE3YklLcTVuclJBQ2w1MUxXb2FMLzMzRVlIM0EzRElJYWt3bjdJcFFTSEV3?=
 =?utf-8?B?dElqZnFYQ0ZjNEI2dWJTa3NUdE5kNGhEd3ZRRy9hM3ZERmxtV1RTTG9XT1Z3?=
 =?utf-8?B?VTEyallEK2creFMwUFl4OXpBN1dTemcvZUEzUUdNd3p3OGpGb3pJY200dnZS?=
 =?utf-8?B?MnpMN0J0eUFWK1NVYm4zQ1pjWjhFbVh0SXA1VnV3QnVMZXY4MXRjT084TXlv?=
 =?utf-8?B?c3VrMmNLUWs5aDBwQ1BaWXdyZThDd003VklFY0J3MmhaYVBVemhuTkg1dklQ?=
 =?utf-8?B?dHYrUEZtWFYwQmh5MjJnam9iSGh2VDFvUEdid2tBcEhCOWFxeC9QY3BUd1Fw?=
 =?utf-8?B?RlQzSW8zTUNMcFIzRW1kaTdpN280ZUhralFvU3VFZmhYc2F0M2hJVnRHclp5?=
 =?utf-8?B?S0lLUnZRTFhNd2pWRkRsNHdQTTNnWks2Yk05eEUzK3NDM01xVjRuNUNURFFW?=
 =?utf-8?B?WXFqQ082TUlicFVJYWMxdjRxcmVDR2dWWkxEWlZLRnZITGt4Mytva3BBVGcv?=
 =?utf-8?B?TTQ5am9QRk1DNFRBY0ZvSzhJQncyMWg3VUFOMGE5RmlKL0dTdlRPRTlvY3lq?=
 =?utf-8?B?S2kzR1BnRnlwNnBqOXBxTUQrT0NMaERMTitLbEdjZVN2YXIveFNlYTF3Y2VP?=
 =?utf-8?B?R1B1UnF4bnF0NFZNVzdscjNIbmZFSTJXaTFVOWx2U0JGOUxSU3gycHN4Z1o2?=
 =?utf-8?B?Z2dsbzVpSlFlc3NSVGFtM1IzVHhmL1MwbURjZFdoUUtyVlZvbFVvVS9Hb2cx?=
 =?utf-8?B?M2JmSXl3SHZXV21oSTdJM0J5YlNKODVyR0lRM1p2aVltdlA4VzN4YWZGb0dN?=
 =?utf-8?B?dnZDZ2QvZGVsRkY1Y1Z5cjk5Y1NZNEwxTzg2eHAzeE8vd1FVVG4wREd6Zm1Y?=
 =?utf-8?B?ZEZqd2xWbjczVEFiTytMU0JRNXppMCtVUlQvQnNoREF3UDlyZmE1QjZEUXZs?=
 =?utf-8?B?K0ZOTVloeWxWY1R6UnQvSUFtaUc1akZpMFhYVVI4ZzZKZGhGc24vS3VPbWFy?=
 =?utf-8?B?ZGg4cUloNm5ybUpIckdSOGNndVZ6U3Z5K2MyUi9qeko4K2ZxbkgxdTNLWHVh?=
 =?utf-8?B?R3BZN3hHbHVxWUdjRkUrRzNzVGN6Q1QzZkFIbWR4ek9FY3BOUFdzc1ZRZ0h0?=
 =?utf-8?Q?InsnJlofzSf9fD8T01rCzMWrdcx2dQ=3D?=
X-Forefront-Antispam-Report:
	CIP:139.15.153.206;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:eop.bosch-org.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(1800799024)(376014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 05:51:44.5091
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f484411-1836-46ed-706e-08dddee47a88
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4;Ip=[139.15.153.206];Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509EE.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3875

Hi Matthew,

On 09/07/2025 21:09, Matthew Maurer wrote:
> This allows `File`s to own their data, allowing DebugFS files to be
> managed in sync with the data that backs them. Because DebugFS files are
> intended to actually own data and provide access, `File`s still maintain
> the same lifecycle for provided data when `CONFIG_DEBUG_FS` is disabled.
> 
> Signed-off-by: Matthew Maurer <mmaurer@google.com>
> ---
>  rust/kernel/debugfs.rs | 149 ++++++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 117 insertions(+), 32 deletions(-)
> 
> diff --git a/rust/kernel/debugfs.rs b/rust/kernel/debugfs.rs
> index e5b6497d1deb67671d22ffd90cd5baa855bb9257..a1a84dd309216f455ae8fe3d3c0fd00f957f82a9 100644
> --- a/rust/kernel/debugfs.rs
> +++ b/rust/kernel/debugfs.rs
> @@ -5,12 +5,13 @@
>  //!
>  //! C header: [`include/linux/debugfs.h`](srctree/include/linux/debugfs.h)
>  
> -#[cfg(CONFIG_DEBUG_FS)]
> -use crate::prelude::GFP_KERNEL;
> +use crate::prelude::*;
>  use crate::str::CStr;
>  #[cfg(CONFIG_DEBUG_FS)]
>  use crate::sync::Arc;
>  use core::fmt::Display;
> +use core::marker::PhantomPinned;
> +use core::ops::Deref;
>  
>  #[cfg(CONFIG_DEBUG_FS)]
>  mod display_file;
> @@ -63,40 +64,78 @@ fn create(_name: &CStr, _parent: Option<&Dir>) -> Self {
>      }
>  
>      #[cfg(CONFIG_DEBUG_FS)]
> -    fn create_file<T: Display + Sized + Sync>(&self, name: &CStr, data: &'static T) -> File {
> -        let Some(parent) = &self.0 else {
> -            return File {
> +    /// Creates a DebugFS file which will own the data produced by the initializer provided in
> +    /// `data`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The provided vtable must be appropriate for implementing a seq_file if provided
> +    /// with a private data pointer which provides shared access to a `T`.
> +    unsafe fn create_file<'a, T: Sync, E, TI: PinInit<T, E>>(
> +        &self,
> +        name: &'a CStr,
> +        data: TI,
> +        vtable: &'static bindings::file_operations,
> +    ) -> impl PinInit<File<T>, E> + use<'_, 'a, T, E, TI> {

Rebasing my test code from an older version of this series to this v9
(this is the most recent one?) here in rust/kernel/debugfs.rs and in
samples/rust/rust_debugfs.rs I get errors for each place where
'use<...>' is used:

error[E0658]: precise captures on `impl Trait` are experimental
  --> rust/kernel/debugfs.rs:81:37
   |
81 |     ) -> impl PinInit<File<T>, E> + use<'_, 'a, T, E, TI> {
   |                                     ^^^
   |
   = note: see issue #123432
<https://github.com/rust-lang/rust/issues/123432> for more information
   = help: add `#![feature(precise_capturing)]` to the crate attributes
to enable
   = note: this compiler was built on 2024-09-04; consider upgrading it
if it is out of date

rustc is

rustc 1.81.0 (eeb90cda1 2024-09-04)

I tried to work around this by adding

--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -36,6 +36,9 @@
 //
 // To be determined.
 #![feature(used_with_arg)]
+
+#![feature(precise_capturing)]
+

This seems to help for rust/kernel/debugfs.rs but not for
samples/rust/rust_debugfs.rs.

Any hint?

Best regards

Dirk


