Return-Path: <linux-kernel+bounces-882070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5769C298B7
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 23:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B8303AEA5D
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 22:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C70241664;
	Sun,  2 Nov 2025 22:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D/mZRqBe"
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011067.outbound.protection.outlook.com [40.107.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F188C1F;
	Sun,  2 Nov 2025 22:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762124127; cv=fail; b=OYLcE4C2l+5ghywMl1P3E3qiDM1QDvPMOo4nzLyGC3zfKdmVS1CmDi4UJKub42lrO5F/YbcDx+L7S5FkRmkvkif7uapObP3bJ3TDpemMg5XrUO1KyjPhvuVk0sIo7EV4SyXc5KkBl5lAcv9nuwFHTIQOzmZ0KJddYzm08UPfZNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762124127; c=relaxed/simple;
	bh=Lxk7d8hmlf4evPkeszVESzrUgb53KV+/niYeaRMWIzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XEDmJnXX0ngTtgDEAtPBBpjl/JNIicNjM5LWaR0hQoKREWG3748OjlfIpM5nrB3DMczup0g2T2hM62h2JKD7oWs/xU1FD+LRAxeWZDB4jDimLQTbP2ye675n7jIMIadar+ZYEQuO75HU95Q8AvC6bU9rlX23KngOwb4lImTqVmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=D/mZRqBe; arc=fail smtp.client-ip=40.107.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=We9k9RuTChO9sl2of/P56ZV7rqM3YVJW5HWU1UETXOg0CUy1RCB8wDnyN24URUMyDFULU4ZcGhs+2shX0vmUmZlqBz7DoJVpIaEH9intsm+LyLFnSjpquWTfNbN35/mL/0K7p0ETczFFHH6yzuAPCD9H91YyNx+sfq/299jPY3diwIghj7SZscNqMqO8hDSNTGuCopTLPazmznzCE2DXphL4GSbD3Q6++6WnsM7PCpB5nKrHmmUGJmuFqLHjJlLcRbYFOaLr0BfYJ+3UfYw2eeyQmAvKOB8/Hzlg0TiaBN/zW+Jt9f2AgNdAzxQyA3yfrWndMj/J8MMlhPBzeC8fKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/71T7wA2H5WjuexNLcR2V5W5mEjLtBDN7brjStAkOdY=;
 b=RUbex5Mzjur2LWZjXWuCKMGOkDLweaAHMsoH7rjiG+QlKW0qftceB98+refqvC68LKmJnRBzf8UHbC7BeHdxUO0tq9BeQrs70chRRszsC4OJ5VmGCGh5UaE/EcEe0qovuchKXKBPy1ynyVJFxEsHHsCStzJnjytNRKcQnk89W4JDENRog8O87kPCWctmkxPf2P8OOr3hc+ObNxQ0gWFUOsVdTa/A75HTRc6kVNYsuWSOY4p+5r9yQDEXmQKK9rOfBlXh3BgpWAgmCbu0m1ROeBDr+nBcobSGvqsMOzHkS45xhYPhr13ICE4WFgZ/l/KfdnO7v7YQn9UTXNnhImKQKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/71T7wA2H5WjuexNLcR2V5W5mEjLtBDN7brjStAkOdY=;
 b=D/mZRqBeta3l/Bow8Qs/FOs07lTfIFraRWKoSJ8W82zonMdZ4QcM+Uhjlc6GyBmZYOrxsmgGiZodkE4zv/13meomX2tD6Tana5vMOIHADizgP58EDGjBcxjBF/NNGjjj2N4no064dKU6MUUFVKOHfHBnjOZZeunA1aKK44SfOOYKG7NgbqwPVOIUGTsv/JWYKsg0Ln2FrhnSBupTx3Eg4p9Exql745tWebCj54W59Rxl/nkQcqhuVIQsGgHc6fXJxxf8FIX5Yh5vXeXPMqLbGkqJzOC8OzFzgLvIUGWIky/Dg+RGv/ANqv9avULPw7ECicWgdcGEu+LmeDTmETSwQg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by SA5PPFB2BF91BC0.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8de) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Sun, 2 Nov
 2025 22:55:22 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9275.013; Sun, 2 Nov 2025
 22:55:22 +0000
Date: Sun, 2 Nov 2025 18:55:21 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Zhi Wang <zhiw@nvidia.com>, rust-for-linux@vger.kernel.org,
	bhelgaas@google.com, kwilczynski@kernel.org, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
	aliceryhl@google.com, tmgross@umich.edu,
	linux-kernel@vger.kernel.org, cjia@nvidia.com, smitra@nvidia.com,
	ankita@nvidia.com, aniketa@nvidia.com, kwankhede@nvidia.com,
	targupta@nvidia.com, zhiwang@kernel.org, alwilliamson@nvidia.com,
	acourbot@nvidia.com, joelagnelf@nvidia.com, jhubbard@nvidia.com
Subject: Re: [RFC 1/2] rust: introduce abstractions for fwctl
Message-ID: <20251102225521.GN1235738@nvidia.com>
References: <20251030160315.451841-1-zhiw@nvidia.com>
 <20251030160315.451841-2-zhiw@nvidia.com>
 <DDYFAJCBT3UR.10Y0XJDLPKYZ6@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DDYFAJCBT3UR.10Y0XJDLPKYZ6@kernel.org>
X-ClientProxiedBy: MN2PR01CA0066.prod.exchangelabs.com (2603:10b6:208:23f::35)
 To MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|SA5PPFB2BF91BC0:EE_
X-MS-Office365-Filtering-Correlation-Id: 309dc1b1-2157-4da8-cfde-08de1a62e763
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HkeIflv3p326Uto6vuYZao1z+Ual18wX6TBRB0PnGT48V7rCvg+d0S+BrgIV?=
 =?us-ascii?Q?+cGuo1PSDi+IL3Zr5hQc5xVGHessPMGRaqMGpvLRDKDtY+f6F9b/b7uVzw7R?=
 =?us-ascii?Q?bxi1ixU3TPqsqk9Q10TFfchbvDJoEZ4kSYOfzycZc+tCrbNOTgKDts2JPh1z?=
 =?us-ascii?Q?yNR6n5ZbJb9hOkKWSolZ7PZtUFauC/LYXL7arB9iGI1646bE6q7T6DhHWFEs?=
 =?us-ascii?Q?2tO9VtNp/8RLWA18JjVMZd5UiCrTAzw6/7EQfF9oc2eREFIglacBhw2Y/SAw?=
 =?us-ascii?Q?53DDEVrIBupbndQ1BKYB6dqC9HuzVfDDDmrmFeiPV4MvCQn/4BHfrt4wPz2x?=
 =?us-ascii?Q?hZMZevL4owxLkuQCbE/leARgsXScePeBJ+mjp6b22Pf/6qFFzNhLkTsR6e22?=
 =?us-ascii?Q?+h4navQ4JWXJF7CJB885UJJpvRWk1ogR4T1hPNdASvR8wZEg/OSoqtzGx9J5?=
 =?us-ascii?Q?TqYpvu3CDCNR/5o+moserAw71pRIgRNmZDL/5DU9JeOGSfBi8NmnBtvsLiRN?=
 =?us-ascii?Q?KvW8OnGheFbxFMEzDxH7qE53AnpMo4y8Leo7yX1UvFj+A0Ws+6/F9RG2X6j3?=
 =?us-ascii?Q?kFLpk6IzGdnvoH5TIYk9gZWTvnUlRaZ9Hl+VV+tr2ACiz5EE+D7PKbTC9RYl?=
 =?us-ascii?Q?/zBRTQpeeaXIdWoFILs0onAkLm2BQGNXtyXO7P6djW462fxNSmrBWKyZqJox?=
 =?us-ascii?Q?LD6o9GGCEn46TD1xQIT2YQQEo8khzu4v7EMkJ+ipE8bRtI/Cur3kApJ+9eVS?=
 =?us-ascii?Q?aQ8WFAdXqE9iOy9a2zOyhQsWSUzaMCFNKpuHrFwEIPZSOVTrcDqzt5lPEeaH?=
 =?us-ascii?Q?tG/S9MJEWpX2PHdaMXLzDxZqUw6NTmnlQaiiBbGYyJuT47HkT0PIuyPW6MVk?=
 =?us-ascii?Q?v+FuZrE7jSeetOIik+G7u11g+XBS4Dcpm03eeFnpn8/jGFXqkb8tH5oZJYVu?=
 =?us-ascii?Q?IDLFCIWIE+dUy07fjRQhCk85zZ4V67kcHswOpf+TAGNk2H+0J0LlqcT2k/Yh?=
 =?us-ascii?Q?ZfOMvHiy1wB/vNrD7HP0uaIXeeG54Jp+pxiD3SfgaR59orVjghSMM0JbLLJb?=
 =?us-ascii?Q?DtYbLA4uQxdF7feiBFvSqD1RVcwtqcKlm2N5Qm4KKD+CgQaqb+jcFJZBXZk/?=
 =?us-ascii?Q?PKAbUfOmF+nsnvEq1AVZJ8CVdDdkCk78Y2mzJQxsy4e5P6LrX35g0FI0k1bX?=
 =?us-ascii?Q?UsEBY8nfW/bar5f6Xm+1lGsg7QPMZUsTHe2DMaaOy/HsBoOEqkD2IbsDo7YF?=
 =?us-ascii?Q?XODc86ekPHRRoe0YUURvnauJ/6EE5IMMLeBqPND5Tvn5VAZpGMZoDp3wBygt?=
 =?us-ascii?Q?tWWP8bBKlcwKlXLaDy7vQulIXP7N0/JaLxJRKXYADW0kTlj5ax/1b97sEqxc?=
 =?us-ascii?Q?PXZRDW75Y8J2Tj8kN8BKA4dE/i8VO5l9VGCpMVGiR5ciKAdcdjxZVuC3yHzV?=
 =?us-ascii?Q?5T+IZMxRgG6OKyGLY0x+3XKsDe/JNBDd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RXIb/4/jdONLJCcbIwMHCuIT6INhQpUsIWCuYdPxw1/00YULytXxv0vuOtyR?=
 =?us-ascii?Q?g2JZGf5Lx8TMhb3P/vPZ0mQ95mDK5/nlZYjJrs/R166cDgSdJK8rHlQSfvnO?=
 =?us-ascii?Q?Cqbxr/58UOypPEtP5Cf9qyvWAvHpfEi9o3qqyA4Ebhb4D5CaVLJx9UHFEGjH?=
 =?us-ascii?Q?Fcu85n2+gF0rrV0IPfvNEXBBoilZ1w6kMrY+8TxFwtCw0iwMJeh/42C5jarO?=
 =?us-ascii?Q?wvVXJ1h6rQBJQsPekasFVCvO5dSso/ZKeWmsjVNfNbSDJZT0EU07MQr/gVRD?=
 =?us-ascii?Q?bjQ2gJDWo69uaJX11C9nKBgDLEV5tpjSitRb3JIBBGNSTHtyEL4GSEX56Gv7?=
 =?us-ascii?Q?9Gv/T8n3pW/7CJIzQlIpwHHN1Iv/UfpWYzJGA5l4EppoRQWh8HxAFmFg7hjs?=
 =?us-ascii?Q?H/7d+HEIMKJpVZQsb/bAd7+bY3VLDvW0cUFPCbdDt7EFI9zMFq6IeRHBsK02?=
 =?us-ascii?Q?L26ZuFM6oFXbNyD+2454WIYuvgSaBQZLdHlGzJcYc7hNRwta66EELwbEoqQi?=
 =?us-ascii?Q?25KHiYY68P+Bkxzjycf/LfhVorHAZkapFS1YbPH2QNTnh4BRzUYwnu7+UIFH?=
 =?us-ascii?Q?YqcZ1l7nhBnuhrR/eae+tRAN7FN3cNIBkEhU9D+Y4NF2T49iwRyluT5QScQ3?=
 =?us-ascii?Q?+Rnw6vPnhOcVNdG7Es+Bg0h3N8lDtlrNn3LKWitMULqXNossz8zZb20WMwvo?=
 =?us-ascii?Q?dvxW7voRUytO4BhCQd2yaUlxIkwVKxg2wWlL1mLeAPSuqycKcGLBRCT6aB0z?=
 =?us-ascii?Q?WXv63HVqrPeT5LW0KQLneL/L27LhjofVqThThBM/ffXtFVsVrtMusiQ3X1AL?=
 =?us-ascii?Q?MD5XH2L7aNlkw9PMC0XLEJ8rx4pzIq1JOovZF63jJVtw2evDTJm9OOp9bErE?=
 =?us-ascii?Q?cL2hk4G7yJBFcssGO9CFrYs1YKk1sgCqCcurxMPacSBoy0VAMnxyOvKMY7Sh?=
 =?us-ascii?Q?TDQ7MopchKKmw98F76NMZukcrGr5COKYmTKnhKgEnoAfgInVxwDNIDBgEvmO?=
 =?us-ascii?Q?dQNQIvj+pdu7QcO8oTzsWh1UGPEdAruUzU+tJOfuobSs6OTefvRTrLii/e81?=
 =?us-ascii?Q?mSGF7NAyj1zHqcRC7QdKozHV9txI5OeqjR3RGqdt5GqMgwoKEvh3qm0sFPoj?=
 =?us-ascii?Q?/JN2ZG+KKIDm/pVaQGmUgFspUN2aIUUqf5cw8X83Dy3syUUE0TTTWe/XEsfg?=
 =?us-ascii?Q?h3HZvyHxRwY6CYqguS6eeRw4dvCc3KsZSR3F4tTjlwKcJpahHxt+akIvd3H/?=
 =?us-ascii?Q?EZ/G1qHvW+LCJ9wa7SSINom65+ygojs51Qpj60BKhtSVRBKGHgowhOB8/r/E?=
 =?us-ascii?Q?DGcMb+pIm4YM+nWKH6OdWVav68Nq8tacp5Hj5vGMWxz6g9bggEWHzK5DKBEl?=
 =?us-ascii?Q?iLuML2cpEaewuIEJ5xy6EWERw/4U2bGOWWI5taxBben6yNHCUX8QsZIUZ4x+?=
 =?us-ascii?Q?IJIOj5oDjJQSEMZV04Yw7ncMJT1yJoszZr8kbJyjKqUFU5H5bEpRYFfD/4db?=
 =?us-ascii?Q?FJAqTPkkH2rjaaXGDMNkxjOWgqpu2TmACzIJryXdWHLzGHzHlqImmlCGe2Xt?=
 =?us-ascii?Q?LTCJQ90YFsPq5uvwvRg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 309dc1b1-2157-4da8-cfde-08de1a62e763
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2025 22:55:22.5875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rEFLyO11EEsdx8wymJMBP3QUG4/Q+HE/TeKDHy8IoR4sJlEFxpGv5kjO+jyue6NT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFB2BF91BC0

On Sun, Nov 02, 2025 at 07:33:10PM +0100, Danilo Krummrich wrote:
> On Thu Oct 30, 2025 at 5:03 PM CET, Zhi Wang wrote:
> > +/// Static vtable mapping Rust trait methods to C callbacks.
> > +pub struct FwCtlVTable<T: FwCtlOps>(PhantomData<T>);
> > +
> > +impl<T: FwCtlOps> FwCtlVTable<T> {
> > +    /// Static instance of `fwctl_ops` used by the C core to call into Rust.
> > +    pub const VTABLE: bindings::fwctl_ops = bindings::fwctl_ops {
> > +        device_type: T::DEVICE_TYPE,
> > +        uctx_size: core::mem::size_of::<FwCtlUCtx<T::UCtx>>(),
> 
> The fwctl code uses this size to allocate memory for both, struct fwctl_uctx and
> the driver's private data at the end of the allocation.
> 
> This means that it is not enough to just consider the size of T::UCtx, you also
> have to consider its required alignment, and, if required, allocate more memory.

Yes, the container_of() relationship must be such that the core struct
is first in the memory and any driver data is trailing. The C version
has a static_assertion to constrain this.

> All other callbacks should be correct as they are once the alignment is
> considered.

Yes, only alloc and put/free make this assumption.

Jason

