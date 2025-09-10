Return-Path: <linux-kernel+bounces-811080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 457DFB5242F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 00:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A9401BC3CEF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 22:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEDC03112D6;
	Wed, 10 Sep 2025 22:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="kCGBfrCW"
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020119.outbound.protection.outlook.com [52.101.196.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0D02EB844;
	Wed, 10 Sep 2025 22:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757542839; cv=fail; b=UTbP1vAP2CxJwD4ggryReDLjtYwWwTfryGfBusGVADx8oek+qnb/LITy61CSEWRY3HbJuvYmDuiEy1GueDURvTOhQjdi62b4y3oJZzzpUBfh8rLJlRwaGv40jdz1OBHpJifuOKuM0sGGgwSy903DYYiljyLQz1EW4toKjVB7Bso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757542839; c=relaxed/simple;
	bh=f+KGu+Lgkvrc25ORAgoVess2zm9MC5IVd32BPMZ0Cf0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CEHI2l/RZJ0Hp75R6c9haUeDxRDMaMlp8p7FcyQmwESKQW7ISCPA6z4ZlaFi6QmtiCctqzh28gq99wL1GFCr/JM2UORlUYwXP1F5kJD5xuWNbZKVnGwcUOwvqr6gTtYIMUyU9pbwVBHcz9Sh7FA+EBK/HWbiZ1WfOWvCCDgQVAk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=kCGBfrCW; arc=fail smtp.client-ip=52.101.196.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g3bJhQo3Y0+GbjCwTICQTjwfQdy5JvoJpD0j4DwRMw8k73Rwi8tl5IWjP3dZyz8atA5TlaCkjaBNZvB0f3KI20ZE0ne3eHuQ6u15tDbjKsemiGOgq5f17MH6KlETHxpS3RxM5KWjrPbVOP0zjzOeMC2C9mouYKx2o9LdErpHEryCFnmL+Sqm82bjVzU7HXF4EXh1jDVuUqG/F23C6pHjJZuz6aYH6Zl9D4O51i4Qb5hLafKstCc5EX2zLYg5YUemfnsWVNVrpeRj1291fHWsuIUpqX6rz+Lzi1juloy1RqLQlCyiWXHwBvZezGAHHvJ9zsGYT8j6KDdiPhTzVJ+0vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DiE05x4FB90MAUyHouCHmT76VjniUuQWb/uBQi+VdjE=;
 b=symYM91HamBlButliKkGjzhq6PZ1PbsIf6T35K3BjhQHg7tcuvYeI1rC1YGADnI2FwekBmp66CYZLbPGJ9aRDAb/x1UZjX8OmIEA0ZqA4KTlNbMe72F/WCJN99ctcT0PKS2CpKyrdDRS3runu+2WGtYSEDbUt6HPnQJKCVM4eookJd71qga7B+wS5wlc/zrf4iD8HXWa3qT4mAiEE4AQ8PW0IEvrgEEDfgqHTtkmj90vwXIswLiZvcymB6P2EzP0k+vx8wke4Zq+O/E+n5UHyywNnJ1/4wvlyMwO+Wu3teGHYESzCCvyO8l9ZK+ZL/BgfHE2GycAU1D11DvX6CEj8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DiE05x4FB90MAUyHouCHmT76VjniUuQWb/uBQi+VdjE=;
 b=kCGBfrCWMGVUXL+dcdl3rjhMIR1sAr1TMvUY0FYhMPrWdasFRvJ+RPXom12oRXzrSh0uBKWekrPmX0A374xv//80k7Ed9FMuT4APPvTIau91rwybnVBuvRYQVcrcbyn3ambMrwyyd6+ASc55g0mrazYPpLPt+4WYJda+YQYWoK4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CWLSPRMB0017.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1e7::6) by
 CWXP265MB2151.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:75::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.22; Wed, 10 Sep 2025 22:20:33 +0000
Received: from CWLSPRMB0017.GBRP265.PROD.OUTLOOK.COM
 ([fe80::dbab:6b2e:209f:660a]) by CWLSPRMB0017.GBRP265.PROD.OUTLOOK.COM
 ([fe80::dbab:6b2e:209f:660a%5]) with mapi id 15.20.9094.018; Wed, 10 Sep 2025
 22:20:33 +0000
Date: Wed, 10 Sep 2025 23:20:27 +0100
From: Gary Guo <gary@garyguo.net>
To: Benno Lossin <lossin@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, =?UTF-8?B?QmrDtnJu?= Roy Baron
 <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice
 Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo
 Krummrich <dakr@kernel.org>, Tejun Heo <tj@kernel.org>, Tamir Duberstein
 <tamird@gmail.com>, Dirk Behme <dirk.behme@gmail.com>, Alban Kurti
 <kurti@invicto.ai>, Fiona Behrens <me@kloenk.dev>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] rust: pin-init: add pin projections to
 `#[pin_data]`
Message-ID: <20250910232027.332a840a.gary@garyguo.net>
In-Reply-To: <20250905171209.944599-2-lossin@kernel.org>
References: <20250905171209.944599-1-lossin@kernel.org>
	<20250905171209.944599-2-lossin@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0376.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::21) To CWLSPRMB0017.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:1e7::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLSPRMB0017:EE_|CWXP265MB2151:EE_
X-MS-Office365-Filtering-Correlation-Id: d19dd6bb-6258-4e03-2a99-08ddf0b84228
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?x/PGJt4M5aUnWv+dA64PVmUmdbWA1+RkSh/Ev5WQGqhlUZiiDrLJo8Bbb6Ag?=
 =?us-ascii?Q?OUkCyvbBv8cyWQ3kENvLlankbm6v7B1mxDRpJOnABno14qi/BP2QqRcKeU9H?=
 =?us-ascii?Q?IeME7D6Ujim4cUxobpTH086VXz/A1MamW3The7tCWdmWroLVzI8yfcvN0sxr?=
 =?us-ascii?Q?QiCpHF66UIYIb2TiVh9N7VCSHSZYMxi5WO6O0bYJgp8CJUbgITwXbUa1Gb8K?=
 =?us-ascii?Q?iDokPzRGGKo3iqUx2yFoBGv4s0b3p8xPB6Bgmf/KIAQT07tkO/NU+zrbKtlY?=
 =?us-ascii?Q?rVqPxu/LfVm97Ery/i+mhSsPbEyr4UJGOXaZKVcyyoRWf8LaXk2GDXA6JmWL?=
 =?us-ascii?Q?o3EDyzh8P5pdi907Gg1MYkjU6vR2RSqm3O80RD1RplwtdkA+34z5//kVHeGA?=
 =?us-ascii?Q?6J3JMc1UP9KkZmn9+KrUKjylDyo3XL6t6QSDYEbGEkHPNzyKQH0gBjvqtil/?=
 =?us-ascii?Q?oKnT8dNzCUzTN67a8hH1Fu6zYW7lxewswxOIqvvDTAM99t/6EWLCpr7QbvF5?=
 =?us-ascii?Q?evA/6f8eaY9plJLBd6TV1vE4NfYzB+VEml7qpxNe5y2CJtAQ6mxcdr5efdzx?=
 =?us-ascii?Q?I3W3hQngHyfpdCUSIRN+h1F44Zb+rkFLLqxV6Ykc2t7m1dG2lWguA4gvX90W?=
 =?us-ascii?Q?cF3nOxYTtheWW85DY4qoG2O8LmSC/NonO11Dx1WLsm8Jm1a6Z5IOwXuKcHy+?=
 =?us-ascii?Q?DelJQrZZZ64RSqO99zmcKCFSCqoglgK18X13G6utF6RwIGnxF4O22aUUNtYF?=
 =?us-ascii?Q?zav021KtDTxysLgcWzqa+Ij943q2bPCwRHBuKkZwh4X5y/Zw6hRcdNe/Tz9y?=
 =?us-ascii?Q?EVQo/bZL8EjGWQuEyttYpAnELWdOCMtEgXAQjROeaFa2w9KSVWfOU0CbY6/t?=
 =?us-ascii?Q?FUX7JbzU/o8RQnhUFTPT3hUVJNSS32iTPCrhMZMdWmB6nesqTsvjiTgU6qnz?=
 =?us-ascii?Q?pP9QBIsz/l2jLMNcEx0wKcZzU0vKyvh9uBnfdruPV3+HUbffbbKZazm6qQ7t?=
 =?us-ascii?Q?//KbmVnKH/j9JyZkY4dqcllBMEal3Hs8JndSgTDG+vl6lHE89JDOD7hKM8bS?=
 =?us-ascii?Q?Ck5+Ivi/Yfs6G909TIAJ2YvIdnQsjK6uRzPzwLcouxhl0goSMe87TdjIDMMf?=
 =?us-ascii?Q?5dUEsU9ic6F1eGNOw+OMDNEFDTvX9kGO8i3srTUN8Bv3U/4RHfFIFce0tkvn?=
 =?us-ascii?Q?r4U2HMWOiBWZzmeya7xKYa5imY5XXbvenXNqBfN5OGWQBViBZW5hAJOBxVe7?=
 =?us-ascii?Q?EnKex2E/KqTcuaqVC598NJC+NUJZq90u+AGX6YhfEFfUGzQNGp/avnQMp12p?=
 =?us-ascii?Q?Jvci7im4yalnNCJVTgJHv1CauoOD+Lj+SpCbnz+UarusGl99Kf2gETxU+u8A?=
 =?us-ascii?Q?gKO3ZoqXX1xQsg2IxBTjftIhJrlfjMUyzRsScHpW4QDVI+zzuE/boyWqEufa?=
 =?us-ascii?Q?684Ny/P9iHY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLSPRMB0017.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(10070799003)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tbF5V1aQ0oGQKawvt4lEG6HwJrIqsYjrB0G7I9H/k+ND5f78Ac5apQtgOqYv?=
 =?us-ascii?Q?txpOJO7j7dGdvgQXCODz+qdajGQ6BOFiBv2uXNHcnKTMaH40osVvQhGORWH8?=
 =?us-ascii?Q?4IOUno6sE0ld9MGlUcSQTc/3P1qIq2tkuJUdYJmlD4biBzWFUh0RGG+kUPo8?=
 =?us-ascii?Q?geuCL+mjowlo1IWrp6DnSbJkXRSxz165+y4uYXRFxpZ372qS5VYIN9OOjek5?=
 =?us-ascii?Q?ejSkNLZm+zFhkHgu4X16ngSCfGDJodaGlcpSJUfcBnTRCoBIhEhaDil69hKv?=
 =?us-ascii?Q?gP5ttgVyNiDrKmQKJNX280GxQuh+6Krwq20FAWVlribHvb4xmj/s1XrvWRet?=
 =?us-ascii?Q?Dg6gPXaxcLJpuJaaOJTdoByBhbpEJQS8MFvZzE1PFgC0spIWFTRxyWawbGNK?=
 =?us-ascii?Q?xcjyEJW8jobWxDszZRlPZbcfwb6qySfJgqpBPbogaZ9NcWwWqbRySS6VwKM3?=
 =?us-ascii?Q?BCU6GGDdXD/1WKoSDu2JsTJNpy6YxXU5YGzuZWFogokIBTVOS4qzU35LwJYH?=
 =?us-ascii?Q?/xlv8MIwZo+b5kDv0dISNWGtHmEMqAPKTihBbkm/z+esQ9hfv7U/FQwwlddd?=
 =?us-ascii?Q?h9wOtK+k3kGLIo6e+fKWy47L1fDE7tkqvbeCkYd2sCYWHGS5HIQgR0SitZhu?=
 =?us-ascii?Q?y/IADPXiT5jygz5xtwMmYws5ZLMZ1Bn5id/DvE0XfdZozo8O+N+kUnrpf08x?=
 =?us-ascii?Q?odPEkacqE7XoJ+1MPmXerxNT7SyfeC39x2fnGWkwAowkAqq4w7iZPLbcLgyk?=
 =?us-ascii?Q?sGKhrbH1syeisQTCepaaKbCIe9J1TigMLcOdmpZ64Ai2Xd0g/Z0Gyx09UcU2?=
 =?us-ascii?Q?Vq80FR1UcsORuhWTbk9d4F4ISKOlMQ/ZFUf31wmCK9QEbF5OCTEJbzOxmeE2?=
 =?us-ascii?Q?nFF5uPlrPeHlIL9bXp6QZJ/p2oWP8liZuHRlcXbGbtskrKN96daKLkxIRsjj?=
 =?us-ascii?Q?uwM/zwr2Uyow6PyubtGAmJZTo5ZPqnUnt2HHX6I3tQytuP+BL+9i+0fMXQ4x?=
 =?us-ascii?Q?SC34+Z/1Y/fwmE3HR5bA6Byf9e/ifedwHV5JG3OX6putMXy/qDFls75hPPpu?=
 =?us-ascii?Q?5vdsj2e5dtNzjLr8efe5tJaK1dG9VBFTxeGkWFG5ZIACHmkEcy3amO3r5Tva?=
 =?us-ascii?Q?WB3isr09dOSPgG2gYggHkMdgLUJt8R6v8ucO4K+RoOW8uwm4QA+jJMm94AES?=
 =?us-ascii?Q?LxmUzv6p6H+iw7IEObq/38wV1OT7bQ688q9hPnCy9sUhYwD/y3+GAoYRYinG?=
 =?us-ascii?Q?LS5d0ZpyBMkKvYmnH4zQstZqybU2KWfpTmuUAZO/EXpeyd4iCRdMun/RAMDB?=
 =?us-ascii?Q?iqCYZuJLy90fdxV0LMJCL0hkRDGQR6wdnWgo9GwqsqQZx/JOOWqPZ4Z/ShPx?=
 =?us-ascii?Q?nKrePlwcEV2PLs1fKYXQ8s0+EX6AlJzkuQrUnk8MAgiu5pt+k48ADUYxGGPe?=
 =?us-ascii?Q?DagGpAu6sYYPM4ray0ykw097jby5XDTXFmqlLqGoIbzwhR1Do+DlkXIvS8Fj?=
 =?us-ascii?Q?V1IdZD9iHLkCKlBEnyHaaJeQZJsGIkb6yI4DFaw8z3AT3bgdcH6Il9LjQaFG?=
 =?us-ascii?Q?mu0VdqMzlGL4blG3xhQROBectfKPSLJ3fGboi5957C19ccAZBtR9qaZTNEAT?=
 =?us-ascii?Q?2Q=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: d19dd6bb-6258-4e03-2a99-08ddf0b84228
X-MS-Exchange-CrossTenant-AuthSource: CWLSPRMB0017.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 22:20:33.2924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: buaWZaEVaGOHg5rZuBn998bAMt8jQlaQoPWQ6GxXfgWkFhkvde51YLiBlR0uiI39OUYAsGvOUtlx6XzU53fyAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB2151

On Fri,  5 Sep 2025 19:12:07 +0200
Benno Lossin <lossin@kernel.org> wrote:

> Make the `#[pin_data]` macro generate a `*Projection` struct that holds
> either `Pin<&mut Field>` or `&mut Field` for every field of the original
> struct. Which version is chosen depends on weather there is a `#[pin]`
> or not respectively. Access to this projected version is enabled through
> generating `fn project(self: Pin<&mut Self>) -> SelfProjection<'_>`.
> 
> Link: https://github.com/Rust-for-Linux/pin-init/pull/75/commits/2d698367d646c7ede90e01aa22842c1002d017b3
> [ Adapt workqueue to use the new projection instead of its own, custom
>   one - Benno ]
> Signed-off-by: Benno Lossin <lossin@kernel.org>

LGTM, make sure to remove the spurious comment that Alice mentioned.

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/workqueue.rs    | 10 ++-----
>  rust/pin-init/src/macros.rs | 60 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 62 insertions(+), 8 deletions(-)
> 
> diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
> index b9343d5bc00f..6ca14c629643 100644
> --- a/rust/kernel/workqueue.rs
> +++ b/rust/kernel/workqueue.rs
> @@ -356,18 +356,12 @@ struct ClosureWork<T> {
>      func: Option<T>,
>  }
>  
> -impl<T> ClosureWork<T> {
> -    fn project(self: Pin<&mut Self>) -> &mut Option<T> {
> -        // SAFETY: The `func` field is not structurally pinned.
> -        unsafe { &mut self.get_unchecked_mut().func }
> -    }
> -}
> -
>  impl<T: FnOnce()> WorkItem for ClosureWork<T> {
>      type Pointer = Pin<KBox<Self>>;
>  
>      fn run(mut this: Pin<KBox<Self>>) {
> -        if let Some(func) = this.as_mut().project().take() {
> +        if let Some(func) = this.as_mut().project().func.take() {
> +            // if let Some(func) = this.as_mut().project_func().take() {
>              (func)()
>          }
>      }

