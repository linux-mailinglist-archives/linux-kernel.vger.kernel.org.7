Return-Path: <linux-kernel+bounces-748052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4F4B13BFA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 15:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3E8117E2C9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 13:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FDD266EFA;
	Mon, 28 Jul 2025 13:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="gX1IxWHK"
Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020123.outbound.protection.outlook.com [52.101.195.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1738526A0ED;
	Mon, 28 Jul 2025 13:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753710612; cv=fail; b=DlRJmWdAmx8rWNaL2IU8NWrC+wJ77BWENPaihxbRfY/kdsemhId1QmrnwMB8z48GRYejtvIUengubttdrliWCv8Ew1BrxKBMxHGtFpDhsCHq8pkvDGCjY4KqzQ0lZCfHyhUslQ2zDAQlz6DMAWboL2TT3syYx2qBR6rxeuTplhs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753710612; c=relaxed/simple;
	bh=buVAc0G3e/LtvftMvEoNXJGORzpFducnqGrPLOfuXNw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qvk0Q3PmX6NRQPk1EBPfTOz0O7u3Ph8OFO4OvcZx/Ni6kZmfbbUWkmNO+EWZFQepziZSowzGvyWZ3evAaR1PuvjxSlkOO+bDS3amXIuBCzQJmAZbeBMTWFLae4anlwgUWFwt4n8TaaLM+/aLEKD+Q0+K/I6Of82hYN0lSqkZb8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=gX1IxWHK; arc=fail smtp.client-ip=52.101.195.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WfkJS694KHIQL3cwKn/l1LbcAPOAOn13lSY8l/9KuYLOXRmUVD5lV0HVQLiBqU9Lq93+YG0r/Ey93Id+GuNDBrB++SEhNN7x3U702v+BMXMxQpzjr6plLGTiW6+3g0ViR5AZXrvrzRtXa078XSTSfFv2sjfDKXHRVXUJUZwlVytnykB2p0h6BGhFEw7CuWlX/GUSH7+i2IVo3y5hRZEgOcr7e2Rw9REQnCoBIL26NwVJJw1l2vusiUXz3yFdWKfpPZPs1/BUXctbNC84RS0F45a+RpHiRX9SEqK/AU9OMPM2N1PSQUgGkADw33pH7VsqYiwQ/El/If1/VhmmA+a+Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5HYW6n8GSO/DStIgIKF3gcleaJGlyBGmGIJEpKbAyMU=;
 b=dq3+Bc70wYlln6MKbdoGfk8BHpTBAI2ZKPmbaUfX0sDIexHDgd0wFfoDl7Uf68YKp17Xl/6DLYFbc7ueazcSgE/O5CGEFM1rKB8C9pVMoZFwMwWOPuc6+IqwxNUGUboKgGASnK8ouC/J/7Kmr5jsXHxwIWMmfQeXiYP7iTkpCwISsPY/LphbFYpHOfTriNPp+0Wh97a3gyuQTkm2cBhsAo/gGyVPy77SwCLFDs+sBSUnA8mfGzkn/cG8/Qll14iqZSSkBrkoePOq4hsbQXtSfsfbt3zCNp/w2hywbF/NqVmqp3vcO5Op4KjRhz3TAshBb197+BgyMRjJ7KHnacG1qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5HYW6n8GSO/DStIgIKF3gcleaJGlyBGmGIJEpKbAyMU=;
 b=gX1IxWHKvG00X57kzCHvkUwM5o28xR5c1s7G+NW/cDCc+SxclzNN8zROTl0+fa75lSwYOtj9KzoUyBg8D/ZkdrtvpzT+TSrDOYLurRVh7nW6Dr+j3iaWZlQKTqFbprReFSDvj4/g3bKup+YyFlo/Za+/M+8ZTp8NiMzrMevAsiE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO4P265MB3533.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:1b9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Mon, 28 Jul
 2025 13:50:07 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%4]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 13:50:07 +0000
Date: Mon, 28 Jul 2025 14:50:04 +0100
From: Gary Guo <gary@garyguo.net>
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Abdiel Janulgue <abdiel.janulgue@gmail.com>, Danilo Krummrich
 <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, Robin
 Murphy <robin.murphy@arm.com>, Andreas Hindborg <a.hindborg@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun
 Feng <boqun.feng@gmail.com>, =?UTF-8?B?QmrDtnJu?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, "Christian S.
 Lima" <christiansantoslima21@gmail.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 0/2] rust: transmute: add `as_bytes(_mut)` methods
 for `AsBytes` trait
Message-ID: <20250728145004.51f10d0b@eugeo>
In-Reply-To: <20250728-as_bytes-v4-0-b9156af37e33@nvidia.com>
References: <20250728-as_bytes-v4-0-b9156af37e33@nvidia.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0057.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::14) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO4P265MB3533:EE_
X-MS-Office365-Filtering-Correlation-Id: fb095374-677b-48f4-c39c-08ddcddda9a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cS4bUAJvvpJ5i2w7yOUUjRj5rnE3CgUtgy2hpm6/LumCWPc0NEV8KUkbIPs9?=
 =?us-ascii?Q?fAN1tfeYLeCU8BFNd77Lwcag5NsL2rx2K2nyslESiEXgJ2ic1tQHyvKOcn7e?=
 =?us-ascii?Q?c5fA4UwL+JTuTLW7mKso+IUCiWnegDh8Y1ii7YhOe69uab9NXQnemwyeXGqk?=
 =?us-ascii?Q?WosK+85+b9iHGZeaZKOR0w/FGCz2CuHlL7QWrzxT5VKKODtXDT8atrT5YLNA?=
 =?us-ascii?Q?CUYy1fvXAuUhaYaRw4ErrB4SnrE/zCDd+UDRghpFzF5ZJkCzBI8gpDxtnAR+?=
 =?us-ascii?Q?45peocWH/Bl0az/uwsy3jCOW1+k0ZNTnlxZlxm9DKFDS3nr73YIVcnDcOoQG?=
 =?us-ascii?Q?nvWEs797ZLe+KjbNIZz/zrqrRppMCoXmDDcp4UsLJJWNtfyoypj5zcXhG5va?=
 =?us-ascii?Q?qbCjoHtN/IVBc4Cp1mvrhPqnVthF+D8+yRdPYQGgk0gtj1BNtUfXQ8WbF5Je?=
 =?us-ascii?Q?gCfXw5ys/3wEt5wmutleeaxlSepDWBP+WdRbYA1SALjSsJVuu4q40UbgdykH?=
 =?us-ascii?Q?U737+aiFd0WiaxquKr8SIX93hR6pz8/XunLeBdKmn6W0lEe1Zeu1FGpM9c+c?=
 =?us-ascii?Q?JBVAEhnEqFXrYPTnKIf0LLDzPi05t11Mye/ZeMc/piA/YZUMcRTsMtNt5qBs?=
 =?us-ascii?Q?PgksfRz/TiXf7Vid2dVoEzRiQtApJmN+9UFWAgVrmYB2cYb637NxptnOoQgE?=
 =?us-ascii?Q?YD+B5PViOps/AXC4bDnWf+fIJPs4YiLwlz4dLzMIGdhE6kaCXXIn57pK4m2t?=
 =?us-ascii?Q?8x7RMM6ot+AWinfHU7+990DY0geDpLMm1SbFc+Fd3T7aChhqZQH4NvkAm9jN?=
 =?us-ascii?Q?cLKqWqyDxINqDj4u8J8iizlBV6gR/+ZcVSz1UZqjNyVSpqMukie54DozNxMO?=
 =?us-ascii?Q?sSKmnynvjEKqoJigI3L0Ag2U3fL32V5jfRAJwiu/iek9DI9IlD6UumuUKBbu?=
 =?us-ascii?Q?x/cAUPbcJ6zis4fMKqFgu1eNS+e4w0o0n0z72fbgY7XeXoyDBF/Kc5V8a4XZ?=
 =?us-ascii?Q?qTq/0ew0KEEBgNtTduGU5Q/I1mSGqm//9h7oZxC3q3EiRLqo+pqInLR93VTm?=
 =?us-ascii?Q?0Uu45YPtybZ7IK+bODxFJ7n6vj5IuSoU3M6K02H6YljDaFEiLzviqZFVN6ie?=
 =?us-ascii?Q?FHJPE6jYtcOX2p1sg4J1akNKKk0i1g8hXuL7KswMMbG0+FWgoB8P9A++qXoY?=
 =?us-ascii?Q?AyHDN7zRa2WuEJ/KUltdidp3HpZbsxd8Ky/cJ25usaoVUFVjxT/rmq9Fw6Rm?=
 =?us-ascii?Q?vdyG30zFGvR68hAkD0dTHUZe5srDknJuD5s0NNHdXwgW5KdKSwNRogxssOHM?=
 =?us-ascii?Q?8kw5NwGanYxrJElG1U11hc/8e5L9tgvi4kjrIHdGnPjQEq1u/HLM2Z+Ik1nq?=
 =?us-ascii?Q?p8Eb7lsJgC3508KFuj2XbDWuuv/Uo8K+FGzywUEU4pKhvEIIcrWzzdyVhO0B?=
 =?us-ascii?Q?25PzdXmYTIo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GP46+UWM1mbmyEYrREHY4tzOBxWlbOjz3Xb9pBOPL6GTwaUvFBMXYz5wfA5m?=
 =?us-ascii?Q?/w7n3cDO+MiLNqCDBjuMSxzzhtyXhF6/Go1fKGZmdYAbDirW7cyOdhOspiiw?=
 =?us-ascii?Q?6QaibbPRP74J0Da/EkulJpbTEZf83GHIdln9fT9KTg8t9RIsHRE03/s+ldFv?=
 =?us-ascii?Q?l/WLtHlr+aXADu0feUVTJNLc+IIs7Ud4sH8V5LDOthVFpJBT9hu78sZiju1n?=
 =?us-ascii?Q?h50M7PoKW8dlc1QEuxmtoPbKhUmQOhLMfo/DXSweY8cCLnDxPL9GqgfaGHBu?=
 =?us-ascii?Q?h/IZO404140lPrYIiICZBhBdt7Tm4OTXSjEjs9uaWjDefs+NzwSQMrytyRRJ?=
 =?us-ascii?Q?pciDFl+yXYr1npuDvKjzPPK2JPaR9bMNxJzzgClpdG9Cb389wgW+Af2BS9YR?=
 =?us-ascii?Q?dcXFfnYG0+UoxFDBZwxhNCkwey0sfEQWZ7JEtAH6MvDoVDaz4BFWu/z1ufPl?=
 =?us-ascii?Q?61hHBdBYSO3pGbjEvYD4R6nli8jB0KBwuwrbPE7nTJS7voLP5yhhWZn/GHl6?=
 =?us-ascii?Q?/0cCHR4STLqcW4i+x2rmPGufce89RRRx7Bh85861Ioj4dJw+XuNzYN0jBKvR?=
 =?us-ascii?Q?w5QC+6mQo4RZTIrNWrfa4jmSLVNGU0ils9tIsXYurvp8lwAYYgISXGBSd/lR?=
 =?us-ascii?Q?wpeKKeaFB4nt+lnEEd/Di2pNT2mPjt5ge+v36rOIQGw+8HHJdHgbmshbXiF8?=
 =?us-ascii?Q?5u4Q370o85tcH6jl23JL0dnRfjmJ9Hne/VzQkF+PoabpcuGCxQkKSUIQ9G5R?=
 =?us-ascii?Q?REwOVuyMgztYlSCEkMpXeop2Ws97VqeA6BfxUqG/GXd9AjzWha3SUT1/WW5l?=
 =?us-ascii?Q?/cD8CeHHvZ6m8v9mLUKEC5xgMa7EY1Awr9hYIbxy7/x7WuGRDm5n7mf1SJX+?=
 =?us-ascii?Q?L3Vgxf7t7FtC3roXp+kwU4LUEsC6gbQbX2VXC77NoTZGazfZsbrkNvl5I1lI?=
 =?us-ascii?Q?DDWdEmvSM4wbiVtx0EjyUa1RLpo3XxHxHd6wNGbcNLnfv/nGDfuyxMPzso5p?=
 =?us-ascii?Q?u+YgiLiD1t37dYA+o2qxRff+VLpqpwlYX736jzurSUxcE/O4FPwyulcHckM1?=
 =?us-ascii?Q?UoFG5yz/oBuSp6Fjni3JMiIwHeZuWrfwuItLAKRJMRizD7ImgcGiHLVauJLS?=
 =?us-ascii?Q?Xjc0Q3C5JvXvbYsT1fDwekRWZoEYz1nANkKLKvh5EAiu+nUgcovbUznhlOLg?=
 =?us-ascii?Q?neIkIK00AtCU1GGH41TkO3qI+e+mVo92XMgXKSfFWBFGfY6+3PxwW0RQWtcJ?=
 =?us-ascii?Q?A3bw/v5WsvSnXCyFKMKxo5TuzUQ0G/6SwSZ2+J0uLNYxndIQ85zk3EuU/aI1?=
 =?us-ascii?Q?Q79N6tNbquMnZr3ylW8bG7IiMCToFQ/1wXNc9Gcbiv0F2HxYU63LuNZdxGJ9?=
 =?us-ascii?Q?hhNmf4lHA0JJljR7tzm2PlAcnJFQ74Ix1DGRJvAdqVwetlujWt+2ulk0aYE8?=
 =?us-ascii?Q?ipVF2mx9qnyUPayUY0WZcEkFATdHiRtfp33f7mOsOua9v9uw69fp5K6Kvi87?=
 =?us-ascii?Q?YqAFur5nOPt2JJONxLKykIRlTVMWqfFgFWdxop4BNioqMZxYjmYoQmH+77sJ?=
 =?us-ascii?Q?o7xf4Tg7N1FV4HLWdvjQygRf3j+QSomYgrnvPArn?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: fb095374-677b-48f4-c39c-08ddcddda9a7
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 13:50:07.6175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 49seZXiyaDBFwHF32DWf6qwQJm48h9cV0fEsBajcmtDJkPuLX86BaBYbYM9V58w5j2xFXKyOD/dH3mq9rxcTCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P265MB3533

On Mon, 28 Jul 2025 21:47:50 +0900
Alexandre Courbot <acourbot@nvidia.com> wrote:

> This is the sister patch of [1], providing an `as_bytes` method for
> `AsBytes`, and an `as_bytes_mut` accessor for types also implementing
> `FromBytes`.
> 
> It is going to be used in Nova, but should also be universally useful -
> if anything, it felt a bit strange that `AsBytes` did not provide this
> so far.
> 
> [1] https://lore.kernel.org/rust-for-linux/20250624042802.105623-1-christiansantoslima21@gmail.com/
> 
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
> Changes in v4:
> - Add the `as_bytes_mut` method for types also implementing `FromBytes`.
>   (thanks Alice!)
> - Link to v3: https://lore.kernel.org/r/20250726-as_bytes-v3-1-eb7514faab28@nvidia.com
> 
> Changes in v3:
> - Use `ptr::from_ref` instead of `as *const T`.
> - Link to v2: https://lore.kernel.org/r/20250725-as_bytes-v2-1-c6584c211a6c@nvidia.com
> 
> Changes in v2:
> - Use `size_of_val` to provide a default implementation for both `Sized`
>   and non-`Sized` types, and remove `AsBytesSized`. (thanks Alice!)
> - Link to v1: https://lore.kernel.org/r/20250725-as_bytes-v1-1-6f06a3744f69@nvidia.com
> 
> ---
> Alexandre Courbot (2):
>       rust: transmute: add `as_bytes` method for `AsBytes` trait
>       rust: transmute: add `as_bytes_mut` method to `AsBytes` trait
> 
>  rust/kernel/transmute.rs | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
> ---
> base-commit: 14ae91a81ec8fa0bc23170d4aa16dd2a20d54105
> change-id: 20250725-as_bytes-6cbc11f2e8c3
> 
> Best regards,

Reviewed-by: Gary Guo <gary@garyguo.net>

