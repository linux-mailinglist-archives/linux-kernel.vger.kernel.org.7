Return-Path: <linux-kernel+bounces-827047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF20B90012
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 12:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECC7D422CB3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 10:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739572FE076;
	Mon, 22 Sep 2025 10:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="seRAZPIT"
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022075.outbound.protection.outlook.com [52.101.96.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACB2287244;
	Mon, 22 Sep 2025 10:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758536980; cv=fail; b=S5x2W4Z7D92uLhdo9J07Lq79dF8sRM2econxiwPE243HROqsC4c190gA1SJ33pb0CavYVX/8JDOn7dPaAvy6+VIWjGEe4fQNNUTKEALWC76qtYuNxuD9/Be0de1JOYa47U7KbnE9hKoce+e7fV2vRMJV8DfdxVVPZcBBno0PGt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758536980; c=relaxed/simple;
	bh=snj2T7DUgIakhWfBQtBVY1LuxUG43jZgOl6RXdmbgTo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BM9a3NYOZv5hvVKF9GAOg6jQyrDLN8UCAk1m8YwU0VBTAUN/MxwhJUs/EG9E3QnHUYvZD2uEpk0cV/YlVsgTDtkX5KdB0r3+K34osfshoZ5aHNhI2FlqMqBfHyiSk/WpiliOL+UrVjEL7Puts3uiSuBZPADuBwwaxJd0QkmyKGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=seRAZPIT; arc=fail smtp.client-ip=52.101.96.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X27NqyVVfyz1U8pV2J+5+THgWnI4PvNw/YYd78NAUr1ucx6ulP3ZoMHmE6tYJ2SWxEJHkevnes3NGPAa1625JleCwuZUITFpJR867jIJfOE6sIMf0dFHYOfXoXuVQwaOxxHp37PalZpzh/W83I9fTFoa/TvOW4ZhiM4fE0OiJFHUqYJ+t24L6f5jtt12wjyC5p88L9+ydUgSa65U8av6EidSvdHvpThCmK5Lb1gW+q4x9DwfkZz42gZIvsE1jv2BEhM0shxLSJP6eNvIW7XazqoNBHueaIpYrSkH05e1HxRsPmFKVr9NdrHzA/8tQuX8y4o50uNakRIIemJJ+xJRvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hKslol1RbonCZ567DY57tFdiqVdBO76b2L+7hn33wws=;
 b=pnnh9ASw4CsYGrlhYA+FdMMLI8nbY6bjXKwMMp7nPTLMEQ9iEGl6ic6G+U8CFZsbMB3oPeG1AcFtWgbmRWHvuzIvclmmCvidXS9pAkq7nXqPQxjarbhyVdaO1CbIAx9L45RiSP+PzCcJn0DbfOgKXYfOh8T2vklwTeJXAGwKZWNo2mqTxQMFz+eUsjFJKoIk/IeLImq1Rv17IagrNC1ovnqzNAXEAlXxVWfTuRDp6mJ2OxZXt4omb4VZw4bGLKoPhlgmioU5LFO59cwKpJweq1XbgVIUSpt7SXCTpgqagQyFLeLPJHMVnQVm2t83Zza6MDkMPMjpHU/zOKcQniskxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hKslol1RbonCZ567DY57tFdiqVdBO76b2L+7hn33wws=;
 b=seRAZPIToGFTi7Ac0YTpZeLVWOhY3qulwwn+HKYnQU+hioPjotfHZWdYqUrrSCULJxIw3n4JwuJYj9qomYp1FF4GTBCQY0pfl2GOwWqdrefQ+DPElxk55keR7INYiASQY2fvDhpEUk/XrAXHXZi/qVDVpJgNeSEtbDPCAUJaR1Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO4P265MB6400.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:2d4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Mon, 22 Sep
 2025 10:29:29 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%6]) with mapi id 15.20.9137.018; Mon, 22 Sep 2025
 10:29:28 +0000
Date: Mon, 22 Sep 2025 11:29:22 +0100
From: Gary Guo <gary@garyguo.net>
To: "Benno Lossin" <lossin@kernel.org>
Cc: "Joel Fernandes" <joelagnelf@nvidia.com>,
 <linux-kernel@vger.kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex
 Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>,
 =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 <acourbot@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH] rust: print: Fix issue with rust_build_error
Message-ID: <20250922112922.0f57fbf3@eugeo>
In-Reply-To: <DCYAIOO2W2KT.1CANHTH6GRVO@kernel.org>
References: <20250920161958.2079105-1-joelagnelf@nvidia.com>
	<DCXWEV3YO443.2EUZL32P96Z0D@kernel.org>
	<20250921004517.GA2101443@joelbox2>
	<DCYAIOO2W2KT.1CANHTH6GRVO@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0553.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:33b::7) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO4P265MB6400:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e55f665-af19-4c80-3e02-08ddf9c2e7fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yOnc7e8pYNkBVeh3AcWYQbdkwmcjMahbL94XnA5ifg0bbEdmgzjzMKkMdt+H?=
 =?us-ascii?Q?mi2mpPz5tzW7iO1KzH1hrIiN0EVgp/lBbnKm36OxBbtJAb9ftRyTLdHin3MF?=
 =?us-ascii?Q?/HwhD+NFPr47Fgr3Iua0UnpH1WgbYVDgA4YxKvbte1tAngP+6siCgQnb5qhi?=
 =?us-ascii?Q?tA5yhC25CM0t3CA8eTCamvxRb5AZvem1j2LKk1rKRIhzvSGrI/kP0bVtq9Mq?=
 =?us-ascii?Q?skzxRS5fKH6+w0YA8/y4yD86QfBXfd8qIw+t3sUZp1zuH+5EjLbh0szxoIZW?=
 =?us-ascii?Q?3I+UNxKD2dpQbZVHlrCv9PpHXqHAhGUCAIPFzMuiNNhvlE5xTM0N76Bh9FS6?=
 =?us-ascii?Q?r1SLEwo14qmePOIc19FGfuU62pbGz8Uq78hX1Toi4dq0ki/0ZbNRmWY0I2tC?=
 =?us-ascii?Q?EIS74ta2XPEd+TNv1B8GpnJDDmljs/rDHsrZstfnSWSSm4pLL12+jqvn0pMN?=
 =?us-ascii?Q?FbMpQXkw9cFWzjBhrO4aRIHVIzy1d/zT0NuhFaw+vszgfgkQ4fPi5aboxF/E?=
 =?us-ascii?Q?oDan8GX/Ktsn2GH9AZ8hnVnTRkDnk0palpmkCGgZdDmjmyPt6KGBgcKMA0m8?=
 =?us-ascii?Q?OTF5Vvc7bAFIhqa8hypvZ09JEcz5JvyQJFldWWPa6/zz8L2hYBCmmDV0tBtm?=
 =?us-ascii?Q?AvAsMjqnRQf09qlUsmTADXS8O1YHZuJ3hHvX1g+K+jB0SBBkq5PqgdUjEOqy?=
 =?us-ascii?Q?PU4YoSbFoZQZz16VF59wawq93jqSXm/eLvd8+FymypCBuGVW9a1ZaGIeZXLU?=
 =?us-ascii?Q?TcfRKT9nDIQ3AeisxdeJ8XvKHO6jXL997MvG46T78TzeEd1FyglFKyLAxXwU?=
 =?us-ascii?Q?xeHGTwPviNxROWXBeKVk5Q6tY6eiW+yc37LZ4GqA1X3CZ/bgwusjtYwQAlcC?=
 =?us-ascii?Q?r0yec5WOMCn2CfnPZKMdLBr/A14NOUAoTn6tpW494aj8dIwuA9GYg1qQrorH?=
 =?us-ascii?Q?XSGSA2pPiGh2zTBT2zdlfsn0c9s75FEAzEI6wu7gsQnMlbl7ND7U9SYFRXRc?=
 =?us-ascii?Q?jQ/RQDcDjWXd9oROdJ1dLh1x7T/RcWktOCwwfQujD8fyj6qhm8kBvg/CMSM8?=
 =?us-ascii?Q?VedG0K9wZ/FQJhZSKxuoTWCcIaBVudHCgQJxvS4Nq9nt2gon4XN+/ZUZigTf?=
 =?us-ascii?Q?vrlUiyjncETaG4s5srnUZcZlI0NL6AsxBZBAoP7d9NZP7XdLrKfC9IBlELfG?=
 =?us-ascii?Q?ZgebBgr9BkfqKcJH04GuhiMdaGJCr/A3MbnbFTGIJQ5GZEYHVFIk3xDAVNNQ?=
 =?us-ascii?Q?9kcoGoKVoeNBhMQxhq2r5NuSrErnFnkgWqLOllj/xo2fTQ12GJ/F+6dXoIhd?=
 =?us-ascii?Q?m4PnOpu+FHGgDP0P1zELYkjxPVmQneNl6P1WFgePA//STvkUHLfJCBowOlD4?=
 =?us-ascii?Q?oxkuhmU0DPzNMxUNfdWkEyqKuHZaVLKAy9G0h/AXAm7+ZjNV8T3BAN8pxbTf?=
 =?us-ascii?Q?6fJVdoOULTo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jmIgfihXLnMG+N308FNefmNgbs5YVzwgTKXcKI9X9i9CcDxXVNVgy2+z4VUZ?=
 =?us-ascii?Q?GFjIfdwdCZdrf5SSKvzxSx90nd/+OllvKiRenC0hj3tPo5SbAJK7wYt39VPF?=
 =?us-ascii?Q?WVOX8PHGROIlixYhCtGeqn1XIg2VbhEhpBbT3dtHoZgaDEptYjJwg9EptFJP?=
 =?us-ascii?Q?RT2FzE0T+JHM62zpYTOL7JzN9jJ3NOczBGvxFr74DHI0gkqD4IBZmpOnaQn0?=
 =?us-ascii?Q?lEHPv30rjV5gY3lHq4nUufvtq9H7nMHrLrAo5ZFBZ+u05QukaBB6V5bgekxN?=
 =?us-ascii?Q?Tq6dx1JOsma9j7QUIou98WrLV+X0pHVZSXL7iGDVEhVXvaK8608RWp/Vhyhv?=
 =?us-ascii?Q?FSdSq8Z/CXGvwc1E75+2PdRiEjzHlG+g7xt8ucgGKo7Km7TVFqpWDoWBXY6U?=
 =?us-ascii?Q?DvAxof/cIQTUH8EXcR8kGyc7axpssXAKQUVCdkeV8Irif961rsp/jMnR5WMt?=
 =?us-ascii?Q?PdhZ3qqp+HamawfauR+tVQUJJniM6QeP9qTx/nJva+JBeUxU9UBPT/Pa4KCk?=
 =?us-ascii?Q?PzdN5n47LuCThRekfRiWvg+DYyq2UvQk/tSp879zS/ha3K0weCvt8h/i5PTC?=
 =?us-ascii?Q?FVms/x8WL/t8NF/BkznKJhGVigRihlsrWfPyebNDhpJJmvoT9B4/jEhBXlFX?=
 =?us-ascii?Q?/ybcMzAQ994Ysa4jiGZt9KhbVBSdrSBfKwWT/2Jl4OgyG1c7uRkD3ZW6mvsE?=
 =?us-ascii?Q?TFEd2FAb7wiX8nneClqJ5eG09rI6pNeVQ7uMkQnv6Q9aRGfaxWqXK/ekWwnN?=
 =?us-ascii?Q?sX2ECo17HlZBrVYXIA/emF1D0tLW1f2Rh4lIHFxR3RN2+/rVaza6I8P4WDBY?=
 =?us-ascii?Q?lhp032le+zNytIow/HwN/C2LVWNlekflSify66flaiJIhmyClda8E7GNakNR?=
 =?us-ascii?Q?VOmB9Zl+6sPYOmpDrR2f8YS+3RIpHzUzk9cp2Z+n96lQVA45WT2u+CzlIMuV?=
 =?us-ascii?Q?pjluwH23Jcfgd85iPKblLFgROyNQJyVR5mkap0H+6D07J1yvSgzbQWUL/D10?=
 =?us-ascii?Q?7Ae7HSB1JHLYR3TaenFCNGdS/E0MWNXptITmE2LfeI6BqvYYZl9UB6Beo/7Q?=
 =?us-ascii?Q?6m+vUILc4N9P/PHGtL3ACF6r9Wm18XIehbrPNgAw/W09RrpK9QbmgkYQzq9O?=
 =?us-ascii?Q?S8EP15wAcUjwWebeYNf3Cnp7wAKx3ho1w/4/ddJAQuo8nY6+dD3WDalqeL6Q?=
 =?us-ascii?Q?iaLW3rNgY34QdPq/dp4JAsodR6/jWrxCkfmJVepGp52UHmDCHN7F2Yw4QOaH?=
 =?us-ascii?Q?rlaH9yxl+gaZdH5vRn1ySMQnZOzR9XXOV0NXO2NeIx/E4KEaQP/V/zP4jEzM?=
 =?us-ascii?Q?k/msZGlCT/parziS83HVuA4ifjxCTvS/yZz5R5jER+aSakoNnHnOG6x95cA7?=
 =?us-ascii?Q?llrpdzr+vhVYxoWPuMFUhpcD2r0yykTxztfvLh+VKu0DlW2P8g0bb/judjiH?=
 =?us-ascii?Q?R4qz0IUMcIAJ1+iIixnPtHsPzhiNfTs6H5qAKttwrkUPqCH14MkXx7dGSkNu?=
 =?us-ascii?Q?I3gWswc01xKsD3oLCDAcOZH4g/1CEB3mHBUoRIgrO9OJdzUeQiG5QHL220tc?=
 =?us-ascii?Q?Ald+dFlY5ViXjFKTGH1gvcRcrUOSyZ/iERPmdDmn?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e55f665-af19-4c80-3e02-08ddf9c2e7fe
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 10:29:28.3448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7xiN3EOWINLwA9hV/2xA41hSjbfSjJ29sgAaznoU8R4TMPBPJhhm6sEQzdTbcbmmM6JEvLQKRJPaCuGoa4uCEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB6400

On Sun, 21 Sep 2025 09:12:45 +0200
"Benno Lossin" <lossin@kernel.org> wrote:

> On Sun Sep 21, 2025 at 2:45 AM CEST, Joel Fernandes wrote:
> > On Sat, Sep 20, 2025 at 10:09:30PM +0200, Benno Lossin wrote:  
> >> On Sat Sep 20, 2025 at 6:19 PM CEST, Joel Fernandes wrote:  
> >> > When printing just before calling io.write32(), modpost fails due to
> >> > build_assert's missing rust_build_error symbol. The issue is that, the
> >> > printk arguments are passed as reference in bindings code, thus Rust
> >> > cannot trust its value and fails to optimize away the build_assert.
> >> >
> >> > The issue can be reproduced with the following simple snippet:
> >> >   let offset = 0;
> >> >   pr_err!("{}", offset);
> >> >   io.write32(base, offset);  
> >> 
> >> I took a long time to understand this and I think I got it now, but
> >> maybe I'm still wrong: passing `offset` to `printk` via a reference
> >> results in the compiler thinking that the value of `offset` might be
> >> changed (even though its a shared reference I assume). For this reason
> >> the `build_assert!` used by `io.write32` cannot be optimized away.  
> >
> > Yes, that's correct and that's my understanding. I in fact also dumped the IR
> > and see that the compiler is trying to reload the pointer to the offset. I
> > feel this is a compiler bug, and for immutable variables, the compiler should
> > not be reloading them even if they are passed to external code? Because if
> > external code is modifying immutable variables, that is buggy anyway.  
> 
> It would be great if you could add all of the extra info that you looked
> at into the commit message here. So all of the code to reproduce the
> issue, the IR you looked at...
> 
> >> > Fix it by just using a closure to call printk. Rust captures the
> >> > arguments into the closure's arguments thus breaking the dependency.
> >> > This can be fixed by simply creating a variable alias for each variable
> >> > however the closure is a simple and concise fix.  
> >> 
> >> I don't think this is the fix we want to have.  
> >
> > Yeah its ugly, though a small workaround. IMO ideally the fix should be in
> > the compiler. I want to send a proposal for this in fact. I looked at the MIR
> > and I believe with my limited understanding, that the MIR should be issuing a
> > copy before making a pointer of the immutable variable if pointers to
> > immutable variables are being passed to external functions.  
> 
> ... and definitely the MIR.
> 
> > If I were to send a proposal to the Rust language to start a discussion
> > leading to a potential RFC stage, would you mind guiding me on doing so?  
> 
> I agree that this should be fixed in the compiler if we aren't missing
> some attribute on one of our functions.
> 
> Note that this probably doesn't require an RFC, since it's not a big
> feature and I imagine that there isn't much controversy about it. We can
> mention this in our sync meeting on Wednesday with the Rust folks & see
> what they have to say about it. After that we probably want to open an
> issue about it, I'll let you know.
> 
> >> In fact it already
> >> doesn't compile all of the existing code:  
> >
> > Oh gosh, I should have run doctests. I just did a normal build. Let me see
> > if I can fix this closure issue.  
> 
> We might just want to live with this until we get the compiler fixed. Or
> is there a different workaround like this:
> 
>     let offset = 0;
>     let offset_pr = offset;
>     pr_err!("{}", offset_pr);
>     io.write32(base, offset);

I suggested to Joel during Kangrejos that just

	pr_err!("{}", {offset});

should work, as it would create a new copy.

Best,
Gary

