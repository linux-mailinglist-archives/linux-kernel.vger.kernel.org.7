Return-Path: <linux-kernel+bounces-882608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC49C2AE1F
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 10:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 055984EE5D2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 09:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76542FABEB;
	Mon,  3 Nov 2025 09:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rcQvNyY2"
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013007.outbound.protection.outlook.com [40.93.196.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9461919309C;
	Mon,  3 Nov 2025 09:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762163770; cv=fail; b=ZcCnorElBeEE9KP8sNQKoz0R8H2V6sQGpA+p6syRueoFFrW6HbP5UGRiIznew56wGGbGTXGkeWrmx01u/dqYwf7ooq7Y0fvLY6WEEvmR2JsROAmXnDs11BpdITkxDwlcWsv81salrCSaWnHErA4rlBL7aOn1cpIau6xGt2k7vnI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762163770; c=relaxed/simple;
	bh=TmQz0cFcimS3DKGSkoOScrjyBArYTaLGVm0RZshXv6c=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xtu9+5ZTZsfTk/k+fH5EWrd4r7YC68fiGPK5QpsgExR68Osxj8CY8qsqZLFag2coXi6xpsUISZrDyP4QapVfSERZlIrW1S4dRlcAKf8/10GyOc9VRaw8pfc5Br5UIY/69WBRLFiS3UOgpWewztLA8MZ5VP15D+zbTkfY3M/BM58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rcQvNyY2; arc=fail smtp.client-ip=40.93.196.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WjYFoCTuPrazsQWZSPUslddx+q3ffJkngFdnl4j5r30n2EbGOcJgY5ujbNbor47gTWA4s5kjM/4lFue731VGuJ+t0rOPEZgAX0UWzkQnXAVDAdTqQjq1N/CzRl8WjwPH4NEuxjFLTcQTF+hTvDDe+XbiOCpH57Q7kveeHsjm1nYEcZ7Ol6VZPc8Q5NJzXQaRalBJRAKV4UmChDl/5x2TPuCqy/ra/888bnIyVGq2AVBXPWAAXeXD1mreljC5bqfJNjKszOrxMSr1nSmRZ43iq9czZ5OL2Dma8zHkLWnERtxXirjs4qTSUVSXY7XU+PbEenbwuHGPPe2+6LTt4W1r/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EKhgeOopWOipFwud56PVBB3piY+3Pdv+hzH3P58OoPY=;
 b=PKsMCk+iSWs5PwKa0Y1qbQZfGYW1ous1Q0H/GLceHaLQtSv5qn3gxwUOn0+A7C8u+BIEJtqU6Au4AX2I5Id42TNEZa3NUogLyog0Gs6w/3+j9E8hC92+hADyF8AIIytT7TsZEyQhItfUpd76yVTYYECej/9E/b2/SlsM847SjcG8dbtgp/BPtvzlqaVslxcvoWeDe2+NomF9nPk6XwQcWRP+vzkc3AKq4qyjix2Ks5rXLoKqLRo/Y5tuzkiw8zB0eI5JvmV6trzdK9XJyEDPyyG+i3PhAYMWy1KEGvfrsorHduzmfVzVxZWL4ZCMTZ2i74P0wNijAntsTdnO7A8pZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EKhgeOopWOipFwud56PVBB3piY+3Pdv+hzH3P58OoPY=;
 b=rcQvNyY2Sx4ST9MC8f0WXcAZTCKlCBsJ6fhiZdxLmsjIKUH0PtviX3UlI77+4SRMZg+GONlnhwQk7nT1oXFzyP2lN6roq8ebBUsybVKQPfW4wnhlwDoPpqRoKfvwsajGcqmsxpAEI84G+i+w+mxludsc5v5JObyCj2BhFI8rBNdVfedjK6kvcJtirWVsIX8SNirly8W1Ry638sUJcRmvWYXXaVDxVqrrdvW36ooLfWp9TIU/xqy72L5MoEoZGIv/U+5mrtdJFmRlYrsnDqNgmzgIc9ywVr4UjcLFNTL02ejRODps0qw+eMubMpoocrIwsczhXA16he360NFeFCVhtg==
Received: from CH0P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::13)
 by SN7PR12MB8789.namprd12.prod.outlook.com (2603:10b6:806:34b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 09:56:02 +0000
Received: from CH1PEPF0000AD79.namprd04.prod.outlook.com
 (2603:10b6:610:ef:cafe::ad) by CH0P220CA0011.outlook.office365.com
 (2603:10b6:610:ef::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Mon,
 3 Nov 2025 09:55:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH1PEPF0000AD79.mail.protection.outlook.com (10.167.244.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Mon, 3 Nov 2025 09:56:02 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 3 Nov
 2025 01:55:50 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 3 Nov 2025 01:55:50 -0800
Received: from inno-thin-client (10.127.8.11) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 3 Nov 2025 01:55:44 -0800
Date: Mon, 3 Nov 2025 11:55:44 +0200
From: Zhi Wang <zhiw@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
CC: <rust-for-linux@vger.kernel.org>, <bhelgaas@google.com>,
	<kwilczynski@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
	<boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
	<lossin@kernel.org>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
	<tmgross@umich.edu>, <linux-kernel@vger.kernel.org>, <cjia@nvidia.com>,
	<smitra@nvidia.com>, <ankita@nvidia.com>, <aniketa@nvidia.com>,
	<kwankhede@nvidia.com>, <targupta@nvidia.com>, <zhiwang@kernel.org>,
	<alwilliamson@nvidia.com>, <acourbot@nvidia.com>, <joelagnelf@nvidia.com>,
	<jhubbard@nvidia.com>, <jgg@nvidia.com>
Subject: Re: [RFC 1/2] rust: introduce abstractions for fwctl
Message-ID: <20251103115432.5b593934.zhiw@nvidia.com>
In-Reply-To: <DDYFAJCBT3UR.10Y0XJDLPKYZ6@kernel.org>
References: <20251030160315.451841-1-zhiw@nvidia.com>
	<20251030160315.451841-2-zhiw@nvidia.com>
	<DDYFAJCBT3UR.10Y0XJDLPKYZ6@kernel.org>
Organization: NVIDIA
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD79:EE_|SN7PR12MB8789:EE_
X-MS-Office365-Filtering-Correlation-Id: 201f5586-af55-41ba-65a0-08de1abf32ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EkUSdxRuHUFPb2S5a8wzhna+JoCBJuKrsqrjHNFgb6Q6/Rf30djkbEG2OHuv?=
 =?us-ascii?Q?M5mWSOiOIv5og//+s111LhZ6LqWygsbZHrNAh/QgScSLlM4Ssu/DmNyiXxun?=
 =?us-ascii?Q?NQYxgc2XvWv2fwGBU9WLe4twlZpboGqAk8cMMUKQU0bYkGThP0oQ5DeJfrCS?=
 =?us-ascii?Q?30pL96vhUH4XNb+Yx5yW8iYmlpqEVfa52kBwuUwkdMJwbo2OXXGFtmL4lQ4/?=
 =?us-ascii?Q?DY3mLIl0adiRxtpCI5V5PStZVl0gIk8JvD+038+1oV+UDXF648pYlWp6E8vp?=
 =?us-ascii?Q?Tva4LOJTdyQ2XojZcOyO1W/Rg2Y7eXEfF2HQ7JgL4q4UrJaT9lt5IIHR2pxJ?=
 =?us-ascii?Q?xLwAP3/RHq2F/dAUUs+MgqM1WQ4V6Bv2LPGoY7+wm3kB8QSREqbUijq903AF?=
 =?us-ascii?Q?fM2Dy50jSCFcDh0P8HqDT9k78+ZpHHaX8PbK4TtlDU5b5yyvH+czUzsFvkfA?=
 =?us-ascii?Q?q3nHwlMNLn/MSNu686QwCTDluq/F3pLE/VYQdBBOog4Sl5j3DSKqMx3qzoXD?=
 =?us-ascii?Q?VSWSm6bFQH8J6q1tsTfDCeNTXa9eWyyUSQ5yZ2XWawENgLXn2BU9asSe4KzU?=
 =?us-ascii?Q?V673t/5HMT1wonY5lgFvIiCK4BM0NQKGp6aMlDx+CSIdLgNFMEf8y27vioCo?=
 =?us-ascii?Q?MYOYiV1sSStksUCoUlxKoSmGe0rBi0TxGDTEXYZ2CoLf4mp0BeJTxdyiT0yx?=
 =?us-ascii?Q?LscWT3dTUW5o7+WNs7O1lc1TKooHE8sejDvctSFBIuEd1VFlMmyZkz7V+jRk?=
 =?us-ascii?Q?MDDUZLoZb0OkK+Dnu9MmvkCSQUuCkxBLzL6fd7FE/OlNQLJy4peZhxI1n5NU?=
 =?us-ascii?Q?j9IljLgwKtwmwsrtu/DyGPTHVaBhpO6K6tC4qKLGMtM6k/RZ1GjNW+VV6/jP?=
 =?us-ascii?Q?Ojbf+uomHYnkfzP7tIH03YBw9/pNAmT1isE+r7sBlLDtZjuzJ9BUbS1BVvMN?=
 =?us-ascii?Q?kK4WXbVgLLBhopH1PY08iiT+vFS7KGITiK3GVw7t/1q7FSUQvCgShamlaDHm?=
 =?us-ascii?Q?CP5z/Bl66EDdkEZyWgq5gFCQHlyG7hg7JXlqqba45BZJkuFMI4mYahFnbVPB?=
 =?us-ascii?Q?oo1YfqbDG4zB2SjSpRJ+mm8Nm6pQG+DKNhJR/TlF2GJrxpdp7QlMt8Ca1oNz?=
 =?us-ascii?Q?MmkI3Ib0uK4uyIWI/Opzk7vCnQBrOu6bWNf5HM9CAvzJeNsnxkLNBb4F4Z71?=
 =?us-ascii?Q?V6LmmewpjOCrtRbydpghfgw+J+mGL3M77rTTVNWcdTlFzxTXBqDeP4IGqyHO?=
 =?us-ascii?Q?aquz5EQD5diPdnChRSM6SER+0E/XrbLbv9GDvf3JVLWAPokFY7R568afIQjD?=
 =?us-ascii?Q?atbLk+F1URmAuFXOKfrNU1Kbfw3qJcxQWib2vb3bmSFm1nEyvYZ5tQslBNQH?=
 =?us-ascii?Q?nOOT1UMxEmoi6yKcyqWcWKrsJo6OyxKXelKpBZz6uSEUX1m77TAQcyPMZWXd?=
 =?us-ascii?Q?NYc+rUAdH3asc5s395HK0jgAANw3sy0gavEmSfeAEQGMDqWIYUVZTsZGGlhJ?=
 =?us-ascii?Q?uBIdFVGQHk40XkbdMLQZEdOxPpE8LQO6RBA5QUTntOpCrCH9J5Mx+w6MKPfT?=
 =?us-ascii?Q?0KepkxNerUC7PLnddXE=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 09:56:02.7271
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 201f5586-af55-41ba-65a0-08de1abf32ee
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD79.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8789

On Sun, 02 Nov 2025 19:33:10 +0100
"Danilo Krummrich" <dakr@kernel.org> wrote:

> On Thu Oct 30, 2025 at 5:03 PM CET, Zhi Wang wrote:
> > +/// Static vtable mapping Rust trait methods to C callbacks.
> > +pub struct FwCtlVTable<T: FwCtlOps>(PhantomData<T>);
> > +
> > +impl<T: FwCtlOps> FwCtlVTable<T> {
> > +    /// Static instance of `fwctl_ops` used by the C core to call
> > into Rust.
> > +    pub const VTABLE: bindings::fwctl_ops = bindings::fwctl_ops {
> > +        device_type: T::DEVICE_TYPE,
> > +        uctx_size: core::mem::size_of::<FwCtlUCtx<T::UCtx>>(),
> 
> The fwctl code uses this size to allocate memory for both, struct
> fwctl_uctx and the driver's private data at the end of the allocation.
> 
> This means that it is not enough to just consider the size of
> T::UCtx, you also have to consider its required alignment, and, if
> required, allocate more memory.
> 

FwCtlUCtx is defined as below:

+#[repr(C)]
+#[pin_data]
+pub struct FwCtlUCtx<T> {
+    /// The core fwctl user context shared with the C implementation.
+    #[pin]
+    pub fwctl_uctx: bindings::fwctl_uctx,
+    /// Driver-specific data associated with this user context.
+    pub uctx: T,
+}

I assume it should be equal to C structure as below and with #[repr(C)],
the handling of layout and the alignment should be as the same as C
structure.

struct FwCtlUCtx {
	struct fwctl_uctx base;
	struct my_driver_data data;
};

uctx_size: core::mem::size_of::<FwCtlUCtx<T::UCtx>>() should be:

sizeof(FWCtlUCtx).

Do we need anything extra for alignment? Or some parts of the flow
doesn't respect the #[repr(C)]?

> > +        open_uctx: Some(Self::open_uctx_callback),
> > +        close_uctx: Some(Self::close_uctx_callback),
> > +        info: Some(Self::info_callback),
> > +        fw_rpc: Some(Self::fw_rpc_callback),
> > +    };
> > +
> > +    /// Called when a new user context is opened by userspace.
> > +    unsafe extern "C" fn open_uctx_callback(uctx: *mut
> > bindings::fwctl_uctx) -> ffi::c_int {
> > +        // SAFETY: `uctx` is guaranteed by the fwctl subsystem to
> > be a valid pointer.
> > +        let ctx = unsafe { FwCtlUCtx::<T::UCtx>::from_raw(uctx) };
> 
> Considering the above, this is incorrect for two reasons.
> 
>   (1) FwCtlUCtx::uctx might not be aligned correctly.
> 
>   (2) FwCtlUCtx::uctx is not initialized, hence creating a reference
> might be undefined behavior.
> 
> I think the correct way to fix (2) is to only provide an abstraction
> of struct fwctl_uctx as argument to T::open_uctx() and let
> T::open_uctx() return an initializer for FwCtlUCtx::uctx, i.e. impl
> PinInit<T::UCtx, Error>.
> 

Nice catch. With this approach, we can force the driver user context to
be explicitly intialized and start to be tracked in the safe world.

> All other callbacks should be correct as they are once the alignment
> is considered.
> 
> > +        match T::open_uctx(ctx) {
> > +            Ok(()) => 0,
> > +            Err(e) => e.to_errno(),
> > +        }
> > +    }


