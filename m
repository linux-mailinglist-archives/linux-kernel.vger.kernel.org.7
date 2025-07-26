Return-Path: <linux-kernel+bounces-746794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 376D8B12B48
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 17:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 339C01C2330A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 15:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98502286416;
	Sat, 26 Jul 2025 15:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="dIJvb94s"
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022095.outbound.protection.outlook.com [52.101.96.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5DE191499;
	Sat, 26 Jul 2025 15:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753545291; cv=fail; b=mjI2NOFHJrXnKVvvCLQPq3fIHti98G0AHCJ8cDBRlmOEFXbCQj/zSyoVdSDKl475tblR2aI967UcxnFFNOYYMRcBnFlaQ0ePAprL2BM4/zc6VvTiaavN8aEXXKnlD47y+R9NlpIEVHRKt3TocCa5dcyTDRmZG2dLSR7CNQAJhMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753545291; c=relaxed/simple;
	bh=PeXfhEGl3+9mcSgdch+wYW7DoxSKoqJdFl3A4IblVD0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ULic2QAH2u+6ThEf+x9M4fKV2CHcsXcQZJNehvqlOQDUMjojlUbFnt3W3tVUAldY7MDD0kebgnZrfyQkgkDzxUlMEp0C4gW4+YbwvcpL0roOQZEc9hG/ADsisJbzjTfdnmxIq+R5wdQ6M6WgVR8uNf0ukjGNhtEUM5w5iCf68eg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=dIJvb94s; arc=fail smtp.client-ip=52.101.96.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zBmYqN3Iv8idVl+LR1cAiPZ5nvhd5KcfXqmLagZFCmGtqz2p6UNV6N7fzhIXLr3gflaJFwqaLZUqpvKUoyW3DS2vT64MDT/keyiA81e3MVt8ONb8dxkvvFgfbRKuiEZuip23DvEuMQ7T3SeImHACpfjO7lqLi7zhpQg5yR5dcg70to8QodAIqAp4J8y3QN6nVzUWtkE9zJxM/bTdnRF+TYFkkhNCEslqMBvV1kRinEdXHqF9WAD+DAnM2glQ8VdlxvkKIfAtpvTeqnkL1lLWlMOemqn68U2fdYoE7w4H0n19NGEVmsDstzAtWjSXfBtY/L/Yh9AHU7kvFIgrPHxtTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+sYHDLvx1QSV6y5K5KojyMmbMFrCjOYCbYkNwflqb0I=;
 b=UDLrH+0JKBks4+8vgLJJ0yWB0FxElRQIGy3Bu9tVJvYkE+47uwaoIHRFC2hRYA1Upn95xUfbjrLCVJMIvIPx2WZnN2EYDAZalwRICXyZCgPeaQrMeZDN/A28lZ6R9aX/fpmdL7uVAcD0CVbkwFdr2KHPwZ0HbXE91sdfIGlNCXXC1TcnxnGe4Z4ENYOvb4z4jzosZNCdK1FKsXvtLIUusEomGIAVV1UESIpimAKAE+FLXdqP0zgJnxQFOhfwNQOzYi3XAss1ex7VpyCSF49uU+Bp8D80I4G6O4mf052ftHcuu8W64p3Nju/8kWkFVhDWRQcCHDTWcNqsZJprHuUEKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+sYHDLvx1QSV6y5K5KojyMmbMFrCjOYCbYkNwflqb0I=;
 b=dIJvb94sfwFP2o/GzJPLTV35a1tnEMcBx3mLvi9lrmtEY+62V8KzHYPAFk6NuxJI55zw9kTXF8mmNBG+RgiKgqebKhpIotxGshrtltt1qKop0TV6WbCIGW/3dy0tiZ+j63Zc60xkhXmk3HaHTsA4YJ3pyqXjTiBLCUk1iT4vTA0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO9P265MB7475.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:3a0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.25; Sat, 26 Jul
 2025 15:54:48 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%4]) with mapi id 15.20.8964.024; Sat, 26 Jul 2025
 15:54:48 +0000
Date: Sat, 26 Jul 2025 16:54:46 +0100
From: Gary Guo <gary@garyguo.net>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Miguel Ojeda <ojeda@kernel.org>, Andrew Ballance
 <andrewjballance@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, "
 =?UTF-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin
 <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross
 <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
 rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 3/3] rust: maple_tree: add MapleTreeAlloc
Message-ID: <20250726165446.2768c6ee.gary@garyguo.net>
In-Reply-To: <20250726-maple-tree-v1-3-27a3da7cb8e5@google.com>
References: <20250726-maple-tree-v1-0-27a3da7cb8e5@google.com>
	<20250726-maple-tree-v1-3-27a3da7cb8e5@google.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0640.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::21) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO9P265MB7475:EE_
X-MS-Office365-Filtering-Correlation-Id: fb6d9469-f7da-4879-6180-08ddcc5cbf82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?un5tfqtLTG12glJztkcHYO//XwoJiBsj7zw8QRtgUbbN9pQbSRYTr6FoMfuo?=
 =?us-ascii?Q?80y4Prf812d9Mqs1TMdc+G3ztVN+Vvnhdin+f3Y8zV3Xaqf8yM98MYea9fSr?=
 =?us-ascii?Q?fkvs8N9C0/lrZZ4x3l/0MxNFlTSY2M2+jcN+rF+Px9eaKPBAtJySci5ZDmLn?=
 =?us-ascii?Q?6lUKKQtw1yEpzI7ULjllTwCvTsObYEVp5DihounKHmP0upVTQNKkUM/WLeMG?=
 =?us-ascii?Q?k7vRsnHMnPxAYksj7+gKg0c0yf+fo3E5COpdURyy4p8tsLhN3NDpZ0ovHBeB?=
 =?us-ascii?Q?Ml/gTI3FecniAEwgmX+vAus/rTbDD5f3fM6QUN6+ysv2uPWR1jZ7fx2SLPLp?=
 =?us-ascii?Q?GCs/eC5G7UAW1jy67WEvyro9PTffyU9Gw+uKw5rTjrCKObnMgoyjniC/hzrz?=
 =?us-ascii?Q?nMYVDEXINQKBoPgem65PtQiwqFT7L0cRcsJM0BCA3IvOM8dkODmkXpsg9sUQ?=
 =?us-ascii?Q?l2JNKOrzhjV+5J1WiomnQLNTgNQhHk5RsyrA8vXmhN47XYkZVlpjbZzhY86j?=
 =?us-ascii?Q?UAuDo0tpw5DXziZYb/uw0iebOwqPQS1NVDyCTDfCLOgLU+rCE+3TQ6ue/rnf?=
 =?us-ascii?Q?HRjSFEDllFqc7X3kNMncJeFjiet0L1o2zUoSUU5lcny77EYDv31K6WyrKoka?=
 =?us-ascii?Q?fLoh75UCvoEzqYdVbuE3piKe70v7aIY/LUyFxgopoBZN+tQyBolH7uYpN2+b?=
 =?us-ascii?Q?A4Ei8np8ivZbXzvyDZq5bnuewtQP50PDwlTMA50dXp5T7GZ4iPfe0mgoIBNA?=
 =?us-ascii?Q?ZXjpxERL2AipGPRe9pZ3nqqE8C0jIlx/u25w1QOgHLp6NSnEjDgzecoDlVNk?=
 =?us-ascii?Q?rsevapbO+iuPNH6sfvaGlxKM7oHWqrOQQWf8JKZnEMfyyvr5lfc+jWg12Deb?=
 =?us-ascii?Q?ev2DAQGOMoNoutcuiLe6lwRfVxUEFFKqF3rLU8YR95AJZprUbBeLqSbmnS+E?=
 =?us-ascii?Q?kZutPRmBuM5p/P6efRjVStETBx1xScejmEiRUAP4+GzCwVL4ZUFDE3RgNkcC?=
 =?us-ascii?Q?FCVyC/yizJHpVzSCclmrQ9z49ZSb16SszJxSMhSDpW3boIeOlIS8pPD3xQol?=
 =?us-ascii?Q?wPm8KnsOOqHi6Gp0LikIFBWJHg06RJCgQcwCEiWRU3ZOw5nxKZspU54QeNjm?=
 =?us-ascii?Q?7zB+TVIGVT7qJGGbM9fuLGN0YghxTMeCowR3JMo7sN7GHT08Flwv7eTUvWdZ?=
 =?us-ascii?Q?r4HfEm9XAKSOK/3GsbyfTFR49TsgsokgldBnn4dA19lpIOHksq0czrRSd6+4?=
 =?us-ascii?Q?AmIA77JKV7+LEq2PNDHwVaYFDtA9bFd3U9GpebOW/qX0hBG0uskvi7i9Ihvy?=
 =?us-ascii?Q?rHNTjzeclZN13Og7Zegn6YLJLs0iS4qJ7GOA7Olfti6v0sgwu5zZ+7YzAx1x?=
 =?us-ascii?Q?b/PbzJhPDRT+RdTssoEV+lesTBtd8BtWTaQmdeX5bLEBHVtr9Q591xBvJ+x6?=
 =?us-ascii?Q?MiwP343gorM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YDbRxPRdWH/AIskhD4rrugv2Pvo81LHJ1Hz7cLeXOw8hSldWNhw/k52o3SPL?=
 =?us-ascii?Q?RDGmDQskiiAGYOmcPZwKbdvEBp/2EYXzmX0T5fYY9NU/msON/usRt6QisBwj?=
 =?us-ascii?Q?lyXK9IF3PIpJmSwLhizCWFmnRFvphJqy3JkLxd1/rPecXpwv62GqEPDuoOha?=
 =?us-ascii?Q?lUtWQKz7agZy2DZ1aH54U/a9/06rde1rkBdHxEvV9V1SxZN5vRoqjD9i/GSZ?=
 =?us-ascii?Q?M3mo5hedWt7R1Ea0B3q+xqpKBje7PnBfaNxaENOiBUdVfFsWzAbZWZKJNXhk?=
 =?us-ascii?Q?91jhzU6w5aO7CayB2VSODm7V25HeVJoH21lBV7y/iKfVDk0XhhyXXVN55wPs?=
 =?us-ascii?Q?He+33JJ2VBFd7ZWFB66KwfGibB1vd5BiWK1qYsC0RQMZc9QuQQYQMs1qYo8p?=
 =?us-ascii?Q?fVu/jw0ify8cmTuF0mqC1shCfhyRoqrLvdQLIEqNM7gcryCtyttsUnijBhwc?=
 =?us-ascii?Q?AHIyP2M1+FgdIZFpNe4aUQf4G7ddFpVOb2CN2U7PdcrfDNnVp3gm0n4dGcuV?=
 =?us-ascii?Q?O8XTKDVdVPaqrtKSU51UmESO3f3IMS87ulkSdhhdg7gNVjEgKBRQAo7KfSzm?=
 =?us-ascii?Q?cHY8/yDGoDAVMOKofdth6wBWupl2lf0QWcsNMqeZvbavVHocn33rtdI9IC4z?=
 =?us-ascii?Q?oLWaigBFQfO5FJJrRJ4+zFeSSka1u0+aC1n0EQBSGnL1wpPVcWmzD1v1m+PR?=
 =?us-ascii?Q?/8uFXKNRmRt4kxkggi0yvAmNMdbqz7eZR8yoaX9gP9V/YUmwMJHYc/4CbyTg?=
 =?us-ascii?Q?va4tfMoPvVAsCyg8HoKwoPxAekJJMpslS6Dzqx5DiFd6Wc3ctblquCyWE0Ht?=
 =?us-ascii?Q?mZWuD1HddDYCnPW5zjtQfmPZyqtfQoPRdgi5cSPkfEPbAVf6x7BD1u1NEynn?=
 =?us-ascii?Q?P1JyWoXvGwUU64La1Epod3upHXhBvXwfitfNOdF4Q0OWcvJFCe+u2dOJ3haf?=
 =?us-ascii?Q?a2FKSnmKSBWWxoplHFrkEqDfugo2M64jRxJjxXQAq2P/1Sfp7DlzZmz45MrH?=
 =?us-ascii?Q?ViKVizsv6RzpX0KkNagAdI03Ushvco88vfm3D5qYET6uyz9LutbG/ZphejLL?=
 =?us-ascii?Q?95sOKUkYQMwTgGlg054IphUx+zyIBdJ43XYX+BZxyowbdraZYGmQ2jFXmRPj?=
 =?us-ascii?Q?FHHaZ56E01sOsv+O0yRnhZpRuwVnQDN6Ka87cy0SV1IShBiRxsflcXaDCRwR?=
 =?us-ascii?Q?0ukaCeHiiP30vKOWTVD0uzMQS9k3PKbsPUTUwe8Gtde337VCj5iIkWn14xDw?=
 =?us-ascii?Q?CGYcRoPISIA6Bc3Fou4CqMeeZjk5gn/KjL6f6ocnEYg037gBkPVi2N4M1ov4?=
 =?us-ascii?Q?l46xplvto/OAznk1vmu2263Lyq8KwCD/P5ulqwiiP0HnxYyN3TlEQEORBnET?=
 =?us-ascii?Q?TYD0mPoown595AbhKZE7ml5lqg9cvz7c40ByCb/aBb0inH/RZ9YECYfiSFbN?=
 =?us-ascii?Q?FOslDAiHM1imt6x9GSxMG7YnDwlHq1TytDeLIFrKwGJ/ZHe/ATCBJlJpaXUE?=
 =?us-ascii?Q?etjxNsL9rvd/mAM7A0MCmoKYq7OyqhVi0S1w6ZD+igCuosnyfHqtZM+Qv/6k?=
 =?us-ascii?Q?Z+2N2Z2yJ1TrpsMonzMYcdphEI57xjD7+eUeJ+u4SxUaWZ/4NjDexs+ySkGM?=
 =?us-ascii?Q?Ew=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: fb6d9469-f7da-4879-6180-08ddcc5cbf82
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2025 15:54:47.9715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /j4TeX7JMI6uABuUNCQcXsnxll4AMj0bhrURxjQkrGLt2AAWzRhMQJpMJ5jaAxHrCI57cKJftLvwPq/k0pX6Sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO9P265MB7475

On Sat, 26 Jul 2025 13:23:24 +0000
Alice Ryhl <aliceryhl@google.com> wrote:

> To support allocation trees, we introduce a new type MapleTreeAlloc for
> the case where the tree is created using MT_FLAGS_ALLOC_RANGE. To ensure
> that you can only call mtree_alloc_range on an allocation tree, we
> restrict thta method to the new MapleTreeAlloc type. However, all
> methods on MapleTree remain accessible to MapleTreeAlloc as allocation
> trees can use the other methods without issues.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/maple_tree.rs | 158 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 158 insertions(+)
> 
> diff --git a/rust/kernel/maple_tree.rs b/rust/kernel/maple_tree.rs
> index c7ef504a9c78065b3d5752b4f5337fb6277182d1..8c025d2c395b6d57f1fb16214b4e87d4e7942d6f 100644
> --- a/rust/kernel/maple_tree.rs
> +++ b/rust/kernel/maple_tree.rs
>
>  /// Error type for failure to insert a new value.
>  pub struct InsertError<T> {
>      /// The value that could not be inserted.
> @@ -378,3 +499,40 @@ fn from(insert_err: InsertError<T>) -> Error {
>          Error::from(insert_err.cause)
>      }
>  }
> +
> +/// Error type for failure to insert a new value.
> +pub struct AllocError<T> {
> +    /// The value that could not be inserted.
> +    pub value: T,
> +    /// The reason for the failure to insert.
> +    pub cause: AllocErrorKind,
> +}
> +
> +/// The reason for the failure to insert.
> +#[derive(PartialEq, Eq, Copy, Clone)]
> +pub enum AllocErrorKind {
> +    /// There is not enough space for the requested allocation.
> +    Busy,
> +    /// Failure to allocate memory.
> +    Nomem,
> +    /// The insertion request was invalid.
> +    InvalidRequest,
> +}
> +
> +impl From<AllocErrorKind> for Error {
> +    #[inline]
> +    fn from(kind: AllocErrorKind) -> Error {
> +        match kind {
> +            AllocErrorKind::Busy => EBUSY,
> +            AllocErrorKind::Nomem => ENOMEM,
> +            AllocErrorKind::InvalidRequest => EINVAL,
> +        }
> +    }
> +}
> +
> +impl<T> From<AllocError<T>> for Error {
> +    #[inline]
> +    fn from(insert_err: AllocError<T>) -> Error {
> +        Error::from(insert_err.cause)
> +    }
> +}
> 

This looks identical to `InsertError`?

Best,
Gary

