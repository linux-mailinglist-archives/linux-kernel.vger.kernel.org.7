Return-Path: <linux-kernel+bounces-825940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 311BFB8D2B9
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 02:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C61FA3B05E9
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 00:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3BF2030A;
	Sun, 21 Sep 2025 00:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rYCmiVGl"
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011033.outbound.protection.outlook.com [52.101.52.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B629F9E8;
	Sun, 21 Sep 2025 00:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758415524; cv=fail; b=Qo8ZM1Q03ymtunNltvtTOcDK9BDz6vCT/pqzhII87tVVqlHK69go8Mgasd3oAvscMUzm65C5m73tKUky0WJXQiha35Kr12kBKhTID1aBcrvRNf7CTba/bZnxjZTP6Et68+4zS/7s1v+m2uRrKia7yXfqPx34o3+lqVpEXdo48I0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758415524; c=relaxed/simple;
	bh=A0GLNPkgjqC2ertUZN0kN9RRIInUGD+/J/OwyP+xJJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Dn5unDwZPhqSwQHaC80kIFEQX3kTCOdeQUHbQlE6U3CQcwOzcTJQcopiwe7sqGX7s6yuBAuAPeYovSF4uFl9pbEyPPeUeWPaI/dX7UwGLminFLU9bEwJT3OLxUbnrJSvt6NMn+K9yfCbFfv437jTRbmZgA7mResIdIY2s81/FPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rYCmiVGl; arc=fail smtp.client-ip=52.101.52.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NcYW4NMRqGwhDthzmA1j4GE6QD67b33erONsatyIZ0vnfOsdI0tAA74NUt46LqZD6tLUhTEliUWBX/MLRcHN+ZJiJFiRj5PGkwlLf1CaQCtdwIAGs5OkEpqCGKuyXthBBVCXmA1iN75mpK0Q4VzBs5zDe1afXFyMXV+/oADIS/zgAOk0q49Aer9RsF+sbvRHP6Qr45JICxTUQ8p0gFM84hCxeGass2qAG/T/0dHum0qm0ZIjAqgpJYtlhI3VAnbkKNuxSmdWitde0EQZco61d17uGpY0OysONzpeXW5Vi271XKAsfejFrQ9Ok1tMZSPKtzq7vlOmVRGMCPspS8Ky5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nk9cCzxyE3mNYL0JI4tP1MINf0deRD8ySnu0NHQ4U0s=;
 b=lpBSVQIHgLAduGYshzrvjEYCfWZ7Jnf08aEqKFNAtMcDXZb3lRY/yjDiThqebfYlcBF09xLWhZlMPjRYkw21b16pX8gjsCH8EseG6YWUjvFHDwbYspxirQMI/QzoSwXB6mKeA6pY3WD2SMKFvlMbGLjs5QqOsDcs0SNSa4kZ4VXAdQpTM0lHDqbDzoQ7g/xmCbeRhDB+hYDCi+um/TGwGB0pXnVysK9czLuvsIv3YDs5/EiWENRVi3rtNYs1Jfuq7hm1oG7fu0si9Gn949Kk4HVJNPUkTTs2mxzt8kdEYQJ0KMdLvsXkSrOmGiK60F8ejBL4tjgrSUmDREUNKAQKsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nk9cCzxyE3mNYL0JI4tP1MINf0deRD8ySnu0NHQ4U0s=;
 b=rYCmiVGl21HhQYGSiQqrGPt1AaZkTG+MVeOak0Z8o/wXC3iIaqWKrmxXwENt6Q2L+3HO9JjNeDT560f1+1FY4Pz1A7f0cQ6pl0bScClgKE90hdgallBHyugm0bVJTk6VKAEGtETRh5tR1ggD1cocuy7HI1VeJdUtn8vJf41XCJ0lo3Pyo7gUEVMvUekjFdc+2reIfyfcRad1cahKOq9OSvmilJW+pdHZVaavVCAFlvY3oZj0LOvUMHy6AbbTPzUJm/RraHHtTdlcNfFW9fkj2YqOF+PiJh2xZZIlBnHtzDCzjzW0a0tDU6dgOO7JkiJ4/wTACZA/E4KZId/kDLq6XQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by DS4PR12MB9585.namprd12.prod.outlook.com (2603:10b6:8:27e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.16; Sun, 21 Sep
 2025 00:45:19 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%3]) with mapi id 15.20.9137.018; Sun, 21 Sep 2025
 00:45:18 +0000
Date: Sat, 20 Sep 2025 20:45:17 -0400
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Benno Lossin <lossin@kernel.org>
Cc: linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, acourbot@nvidia.com,
	Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] rust: print: Fix issue with rust_build_error
Message-ID: <20250921004517.GA2101443@joelbox2>
References: <20250920161958.2079105-1-joelagnelf@nvidia.com>
 <DCXWEV3YO443.2EUZL32P96Z0D@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DCXWEV3YO443.2EUZL32P96Z0D@kernel.org>
X-ClientProxiedBy: BN9PR03CA0113.namprd03.prod.outlook.com
 (2603:10b6:408:fd::28) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|DS4PR12MB9585:EE_
X-MS-Office365-Filtering-Correlation-Id: 299cb321-7597-4b95-e43f-08ddf8a8234a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4Qi5CxciovMdJn1mrkowFa7/aM4BzfO0O2TzUOlm73XHv4SEm73hwrr2nQ+4?=
 =?us-ascii?Q?dlAqloIy51HJO6eoxtU+Q8L0uobPEzV3HXc7KfVXhl75zQv+7u2D3wG7xpVX?=
 =?us-ascii?Q?RmeJXrpp2lmopjuFVhplZNUaN/c6esjmRj4sRkQ2/NEL7BhiYrZ/+aCmixN9?=
 =?us-ascii?Q?RhdKauZv4llIDlyBMpKmAjjcjZbn+ugrQP7Uf8NLXPalL4SLNcSuGIjzrtJa?=
 =?us-ascii?Q?HbVvCeZoPFTUmb7dzsA5q2DQaFA11yAUyRt0td40UfCrSUZE7mSsrne20rT3?=
 =?us-ascii?Q?l45KO/F/HIlsl8vTVpdmn7fUNkrJFtoXQFRFGPo1TQy7FSJkavybefacaSjx?=
 =?us-ascii?Q?olwYdtr2Uu+V1vgrmdx13fhDhh8fIGaU5KGNLk95qh9KMGYjjIL5Iaa4Wo3S?=
 =?us-ascii?Q?ySy9Pt8ZgUMF7r8VSFkEjY2VtcJ7C2XSkS6WGPpak8nYY7OSSdUTNYHxuC/6?=
 =?us-ascii?Q?3fv6e8YmG+HjpXToCeOIHA6wmT7rCVdNgCRbe+8FvX4NblkHniHcnqS/FaOi?=
 =?us-ascii?Q?J8AmfjRpKcZ3Ndf/isQDSlfv1ahafHdtHuHJciD0FceIUvFrSrzOdUGVf+6U?=
 =?us-ascii?Q?jEUZnEu84msF9Uue33S9UISWk5skflwukIJFtP66nzgm+6qfQGSsSX7Q6IcB?=
 =?us-ascii?Q?6zXQQe7wRv75CDi5cbKkvz+H6us54HE0Bg4AXc9kuy0gHpvt5oC1uduaUOQo?=
 =?us-ascii?Q?u2vpR2JgaLw5xJtXfX9yltT+jTxZQBf/2fs16zxR3bX3sNaNaJwJdPlLK6HJ?=
 =?us-ascii?Q?8Ii1Io6joS7z7NQLZy43vlbKXaOJ65JuDQ+iM6SPuvD9eXLfQBPKwNR5wCch?=
 =?us-ascii?Q?DxRxU8hb7JLQCZTUwKuCafjV44ojCfKoR5uI8A2RnyNeRRfx5rKSKo3M7E0v?=
 =?us-ascii?Q?F8yYoOKx8OpuEZTFtjWxxyYSr2VipgQP5E0BltdQzmqpsV1BtBO2XRRwS0gT?=
 =?us-ascii?Q?VlhUwLPiCPyuUyfzDTyEGMMk3Xr/k2xPb1PugVaE1NTm7WdaFCNdcVLJsdcV?=
 =?us-ascii?Q?y5PzZ87GFgyayJeA7dNj9G4rITtOMEwGYNiva/YgJwxFGkBg51FsJcM81Llj?=
 =?us-ascii?Q?FIcWZbloRcTJsBqrq04kYlIVonkSqEIXvrJWM4renf9WawRKK8An3h9PLN84?=
 =?us-ascii?Q?wTvu5OFGy3Ddb70oZK5+Cow8x8IWTYP93onBJ6J3VvhyQBPFKDdI75WMFL5H?=
 =?us-ascii?Q?J3Ji6gEvwWBd9LhgivHxAex8qQpWIYZJqIzFskk/XBdD0+E0seuVdeHGCciJ?=
 =?us-ascii?Q?L1h+Fjz76XzI0MdotbEEGDdSndwqrEYgtW+zZPGGP0EhWN3GMknNxgQs1y46?=
 =?us-ascii?Q?+tbaoEpsPvY2xnNb1NaecS5vKRFVJLaReDcxswBDt2yRvH2Q31xhjrlMAruD?=
 =?us-ascii?Q?Hr7UHkJDa0zt6eUr9Df5fYufD/XEcW4ovB7/fXF0zGZbjwl5riyS+6QYI0eP?=
 =?us-ascii?Q?v9942q3tQug=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xCxvHCCzK7uRMI0wV0gxSg574MnvXdn3Ca3nWQavadbSwvHplYKwhmqwWR4U?=
 =?us-ascii?Q?R8bWslo30bsYdFFiQU9qtQ0ClT9u5souhTKaUVSYe7kCypeDnn953lhMDjlW?=
 =?us-ascii?Q?xIHOUHHlPWmjmxkdWqNLTWHFor+/cMoMoicreFi0yFEuoOl4ImQWOiH9S3Mv?=
 =?us-ascii?Q?kd+nCJi2xX/xadBFHYTMcu6hUOjQH06XcPTEu88jfzeng8w2iqBaG3Iib2lP?=
 =?us-ascii?Q?KKve4cxs9DD8hHqM6LgYX/GEXgRoUTulLljnGpyGYGwRUp5vX9k8Sn4CzS0N?=
 =?us-ascii?Q?DJsbbuFnFvVWdj4t3S4tGSHQ6zR24HzAYJKsGxEc0zfEDySxMwzG6YsMfKJg?=
 =?us-ascii?Q?RqAVOmaUHeqq+Sayu8OoiPlfUTusdvWlYgLXyEk3m1W7romcUVdGHefsAPfw?=
 =?us-ascii?Q?C1sPg0nEleNELNhfB3O0vSZ1oaFJPdKzNMvqf2ewcic7BmVAgdPR9mDCuN7t?=
 =?us-ascii?Q?Bmy2WrvYgTrmeVMe7Q10JEpo/BFihW7uec2rq55fy0SFgLHGp6HzWMHA8WCm?=
 =?us-ascii?Q?fw3gLcamDhB5r7KemWQscM6Ta3UVwGpD0hN5q/+7JEwa57at4fpPNHbqux6+?=
 =?us-ascii?Q?RcTAlX7FDOq4ZCtUXXAPkaQneKSIX35089GHB55O/EZRC9UTjQPVJY32OCo2?=
 =?us-ascii?Q?P0xBJcJ1WuNm3Fh0ahbCcLU7s/dv76SmVqOLskLXm24z4PiwQOLhU7KUb7X4?=
 =?us-ascii?Q?Yly3olHMZHqD/2aA3eKuwbR8T9lqnGCO9ci35Sq+0kHq60KVGmSwWqmhUcFk?=
 =?us-ascii?Q?yQorQv9akjG8AJKhI09Z52mlWPVnyebAsRPKNrg6orVJhL+bkpwcvryy31mm?=
 =?us-ascii?Q?Bk7GPfp7E4dPsVWfalfQWnIAq+AIqlrujUtC/c7czKRf10XcIRhoGdewQkyg?=
 =?us-ascii?Q?niY4dd51zfVOfhOkG+EHKhj/yaYZcBIMIVRHZvBV5x3fUJg9+KVsWRvX86X5?=
 =?us-ascii?Q?+cbOV6U0b3UjENwr80mS59/LmXAmphWjne/9bCLPuX2LT9KYwA1i4C3JzaVM?=
 =?us-ascii?Q?CIAGhcSDu7y9kPKKEbhRX8X3mniRxPDWwr1OSt/LxxrFJApOSEs1+LxExkiK?=
 =?us-ascii?Q?v+96Ysx0KQOvgogE6NhuWQOfbGuPEqlHFalxjlFmH4dSx94GvpyLECssI+WC?=
 =?us-ascii?Q?9Wo3FErTLgX1h8ho/lwMLIigtwM4WI7CaWfTKlPwzewK80bM2Uh7vMQLsoJU?=
 =?us-ascii?Q?HQW/42AiF6uF73aOKUWA0PpMPWLGXJAhBmD7A7TRDjpETLAYCVUrWwHaTX99?=
 =?us-ascii?Q?9+29QTBwsBXEE+HQhe95oMSKM6MaKnGzK6rMOhP+HFPet8CPYVpmKkezji13?=
 =?us-ascii?Q?M+EgYOeTdHIfRHTnjv9dqv0y6SobnfObliKADmaT/aMfF/KmE+jwpXY6mwXp?=
 =?us-ascii?Q?8Cl9YDROjAYa66iZSaEJPO6McMZpzgwIN9Vi6BZx1c+Uobnz7kYd6Lbr0O41?=
 =?us-ascii?Q?ey04ZyWV4pgi+4Hvp3KpZIQI6EqLT17p1EaJ8Fpz3iXh43UwO4+x8BteiIYZ?=
 =?us-ascii?Q?H9cgI+tDcqRQNGW/nDZo23AyqFoldyl+xb7oJOBsgTNYEO/QEvw8mDc3Y0e4?=
 =?us-ascii?Q?Nb8L73+diuMrxC+8cAim0QOH2cY6SgtxS5GG86zb?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 299cb321-7597-4b95-e43f-08ddf8a8234a
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2025 00:45:18.8330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QmA4hHe/koSyH72ZRr0E1JrU0rkpOPXc9kK5Vh5vLMmko127rJ61e7rmVdpLC11LRuOFXSRPoyFuGXJSyF9WEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9585

On Sat, Sep 20, 2025 at 10:09:30PM +0200, Benno Lossin wrote:
> On Sat Sep 20, 2025 at 6:19 PM CEST, Joel Fernandes wrote:
> > When printing just before calling io.write32(), modpost fails due to
> > build_assert's missing rust_build_error symbol. The issue is that, the
> > printk arguments are passed as reference in bindings code, thus Rust
> > cannot trust its value and fails to optimize away the build_assert.
> >
> > The issue can be reproduced with the following simple snippet:
> >   let offset = 0;
> >   pr_err!("{}", offset);
> >   io.write32(base, offset);
> 
> I took a long time to understand this and I think I got it now, but
> maybe I'm still wrong: passing `offset` to `printk` via a reference
> results in the compiler thinking that the value of `offset` might be
> changed (even though its a shared reference I assume). For this reason
> the `build_assert!` used by `io.write32` cannot be optimized away.

Yes, that's correct and that's my understanding. I in fact also dumped the IR
and see that the compiler is trying to reload the pointer to the offset. I
feel this is a compiler bug, and for immutable variables, the compiler should
not be reloading them even if they are passed to external code? Because if
external code is modifying immutable variables, that is buggy anyway.

> > Fix it by just using a closure to call printk. Rust captures the
> > arguments into the closure's arguments thus breaking the dependency.
> > This can be fixed by simply creating a variable alias for each variable
> > however the closure is a simple and concise fix.
> 
> I don't think this is the fix we want to have.

Yeah its ugly, though a small workaround. IMO ideally the fix should be in
the compiler. I want to send a proposal for this in fact. I looked at the MIR
and I believe with my limited understanding, that the MIR should be issuing a
copy before making a pointer of the immutable variable if pointers to
immutable variables are being passed to external functions.

If I were to send a proposal to the Rust language to start a discussion
leading to a potential RFC stage, would you mind guiding me on doing so?

> In fact it already
> doesn't compile all of the existing code:

Oh gosh, I should have run doctests. I just did a normal build. Let me see
if I can fix this closure issue.

> 
>     error[E0277]: the `?` operator can only be used in a closure that returns `Result` or `Option` (or another type that implements `FromResidual`)
>         --> rust/doctests_kernel_generated.rs:3446:70
>          |
>     3446 |     pr_info!("The frequency at index 0 is: {:?}\n", table.freq(index)?);
>          |     -----------------------------------------------------------------^-
>          |     |                                                                |
>          |     |                                                                cannot use the `?` operator in a closure that returns `()`
>          |     this function should return `Result` or `Option` to accept `?`
> 
> (originating from `rust/kernel/cpufreq.rs:217`)
> 
> Can't we just mark the pointer properly as read-only?

I found no way yet to do that. If there is something you'd like me to try,
let me know. But even if the pointer is a C const pointer, LLVM seems to
always want to reload it.

Thanks!

 - Joel


> 
> ---
> Cheers,
> Benno
> 
> > Another approach with using const-generics for the io.write32 API was
> > investigated, but it cannot work with code that dynamically calculates
> > the write offset.
> >
> > Disassembly of users of pr_err!() with/without patch shows identical
> > code generation, thus the fix has no difference in the final binary.
> >
> > Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>

