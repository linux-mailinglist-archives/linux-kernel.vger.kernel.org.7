Return-Path: <linux-kernel+bounces-811081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4927B52432
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 00:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0B5016E2DA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 22:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06CD30FC06;
	Wed, 10 Sep 2025 22:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="BcgNnm3N"
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021128.outbound.protection.outlook.com [52.101.100.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335E52C0272;
	Wed, 10 Sep 2025 22:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757542900; cv=fail; b=T8wyiA/qiAz0MYcbWpll7B4iMvxOtpBEH/B5RtAzJdEafQzShYRSY/Gc8mkBSKtm01z0so4ru4TsXvPC1BDPQ79uhPkjgn8LPzpfSh91mzuGzjIa9wMjCIKS91t8dD4l+g1F4+atPRV97KPCBQimKVQcHBTpRerioxhQ7VyVNO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757542900; c=relaxed/simple;
	bh=FerFD/zJEW/fkvVHTvuM2WyHJEoUM5c0Z/oq4Zk+gKI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FNUO8AsK5+GN7FGTlLERdIp+5uuxeGjxoIoDT/4vqNQ1ydTPpq4p27ZLpFwnf+tQnIUl4/PC2/K/okLBRcTov2FAhqk5zEOH6Pkp/NUqgLGkvvfcdrned4RhaVviBpt97PMHmtsBkaK+sqIoTjONTgwwi8ZBgPIqn+WRqFBcwJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=BcgNnm3N; arc=fail smtp.client-ip=52.101.100.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UlTAAXPYHeVl7Kuk/tcCujRQcrbe8GK7mpApqjU4l+H6UeYv5cjyycDUF/WwB85hzEy3sf2yQvmjcKug1CFVu3KZmI9L1dUChKE5gZOkXM9BtlFo5yH29IIOKo5Ncwz12vvmzg64nuhP/aRDymyNdrpSbHOvStcTzvMUcJJbj0wpYHoxeWytcom6JKJbTJIQ99IGgLXEQsEEmO9Yiatdb77qcs6PKXezVd0Atzvv0T577UainEmpIpGfzIWXbhoU0ztdtg2oLjuvUdwJ/M/FB0XpfUp7AO9fpod/mrxLr4/T85Og5m/nX8As1D0f6auryqHAFhYYixSJPrbXvPFPjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JFYgZM6zC0aTzaYdJnaGmwX581EVENYyIc1kWHp0P54=;
 b=fm/QGn/dFGok9RrHfBzuiMS7NusoZwM0reVzwJ08PqnvAHF9FxiGejPan508YYvDTBp68ntGpVfk1hiJ5G6uxa2DcUxCK93RXmsmJv9VhB5VW1vtu35R41eHpH8RPO/pfWqRMwg11rBVac+DDT47lUjG1DlMpi7yeLuk1lKoNJBXR5jpyxEP4U0N8JhB8fhOcP3b/ID2x+MTcIUzQOlKjV4HLnCE5NdhPE/LnSiV64TYO0vOziVeRRUDheVH+M5dqhGaBmD6s0laJjzMx4fhPE9IcqA8vjDw3r8zgKXmi4d7MMcsXE1GEuI1xaUSDrRlWfeujm+z0EDh8zKzvqIbEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JFYgZM6zC0aTzaYdJnaGmwX581EVENYyIc1kWHp0P54=;
 b=BcgNnm3Nhf2sRrwTcqj0jswTOOwR8swfxRqSFPKrjo/QtzAKEOcalivky4e7PZuwx6GDCWdvpMxeUGUad/AdPY4XiU8uR/jFRTp4Mzhnk9Fwpx0di3rQqiRmqaW/PzasJ4mNZ6qK3LrMgtnImCEKLx6eqwwDmpg24FzYc2g5FYY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CWLSPRMB0017.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1e7::6) by
 CWXP265MB2151.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:75::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.22; Wed, 10 Sep 2025 22:21:36 +0000
Received: from CWLSPRMB0017.GBRP265.PROD.OUTLOOK.COM
 ([fe80::dbab:6b2e:209f:660a]) by CWLSPRMB0017.GBRP265.PROD.OUTLOOK.COM
 ([fe80::dbab:6b2e:209f:660a%5]) with mapi id 15.20.9094.018; Wed, 10 Sep 2025
 22:21:36 +0000
Date: Wed, 10 Sep 2025 23:21:33 +0100
From: Gary Guo <gary@garyguo.net>
To: Benno Lossin <lossin@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, =?UTF-8?B?QmrDtnJu?= Roy Baron
 <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice
 Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo
 Krummrich <dakr@kernel.org>, Fiona Behrens <me@kloenk.dev>, Christian
 Schrefl <chrisi.schrefl@gmail.com>, Alban Kurti <kurti@invicto.ai>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: pin-init: add code blocks to `[try_][pin_]init!`
 macros
Message-ID: <20250910232133.37ce4fb0.gary@garyguo.net>
In-Reply-To: <20250905140534.3328297-1-lossin@kernel.org>
References: <20250905140534.3328297-1-lossin@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0134.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::26) To CWLSPRMB0017.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:1e7::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLSPRMB0017:EE_|CWXP265MB2151:EE_
X-MS-Office365-Filtering-Correlation-Id: a7825666-c5b7-4727-bf21-08ddf0b86784
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fqHTxTetZInT+zNa64HR+A3KClOOydjCnit2Fd5fX/YVqIA5MMxjIjbMPLK9?=
 =?us-ascii?Q?vDNQUePdPzDXMpvYIr0RgBi/WX0h2AGXwJhrEtiObBC0raNruK6wLNTb8f3F?=
 =?us-ascii?Q?B6c2v7qdFgf6Zcc24yjOpqURgumjVWonmnW0ydJt8uwGzYECXzK0tDUNrsLo?=
 =?us-ascii?Q?Z2pcuhIYQBApVEPVGjxSlhbKDUNVpRM0k+hqVuAQH3RbZHaf6mfWWv4Oqni6?=
 =?us-ascii?Q?Ypv9Wkm0/d8i/Ny9fJLPKdud8te5b/WoNu1/0ICVN3etafSgbp8Ek4cBcGqo?=
 =?us-ascii?Q?HWhQOh8VdBVVdzDnyz/6kPO0vqOKVFeXLWB8+bqAIVuWRcZyJbNYUCzBDMHT?=
 =?us-ascii?Q?hdTgNzeBH7/XcWsye+s3qYHrpRzCNPI1GSADn/+/0sw6hY7Ysxu6FkP0TUlM?=
 =?us-ascii?Q?Xpt/0fMiXvxjc+Oe2g2OR32X1WvWGGCA2uXnHUMDs0MKAnDqLdgzRyQyorH3?=
 =?us-ascii?Q?5nJMg2z9kJrlZTRMmHZ8CW+i+7V/9u4Ez488K2nuTHhHY8G7LGmxLHKnxenX?=
 =?us-ascii?Q?UGl1gKbAukN0Ld0+Pgbc6MIOZ/TP9vDSFMwYItqXdIXXVLmnpcNN4PNfceH1?=
 =?us-ascii?Q?UPXoF5qVDosnJAVrjnR2rDSgmMVzmqdDThZSM8Y+QkbqB+isnYFMXB2CwEuY?=
 =?us-ascii?Q?TYJ+42BB4KWhXU722MvH10cTgdKMiEFotbVVmguwX+s22JnYCFUnj70zxfa2?=
 =?us-ascii?Q?fwa60G75izvcvXAbyumrIWolpXUbiTd/J9ce/LZif2bbDFQ3XxBsek9rRxgn?=
 =?us-ascii?Q?GDGGOSt2zqo0SSYW7sBCwFsuxJeDf+qYBZaZgxbKetV92dToXqfOWaMkayIH?=
 =?us-ascii?Q?iiDotf86+APMqjiNDdv5ja3MN/zQvK/sYAM2VPI3SsgOxz4joL5CJxVEyC12?=
 =?us-ascii?Q?+NpRfeplMGeKJor00AJfIG/KfMAN5Zx4O6BLBnKs1vZX1zNO/TjxVx4QZs2j?=
 =?us-ascii?Q?ghHIO2croawsuRgnZNWoZthqaIYdZwolPnErn3mwADcMjeIQm5c3QXhD5eyC?=
 =?us-ascii?Q?0OX+T6iAC9JxzbRbe0QYJVxscvy/BhF2XfcmhMDtcridgWxlW4FJW7x8lUfi?=
 =?us-ascii?Q?gOYmrhNGPz+yePCAzIpg/Sl7rfWttA/qi5jaOWN3jvR3FKp7olC1W+Zntsdy?=
 =?us-ascii?Q?ZKmFVeMjTn2OcEOpMhwq0NvTy5dJGjyx1zYHGLZRRCzteJIeD4THTo6teI0J?=
 =?us-ascii?Q?fyn2ZY8K2+ZsGZ2zqxE3dHEpvIzijYrT4kcAyT7sjRD4tk+1GTEHcCXf61Z5?=
 =?us-ascii?Q?PfgmGaXI+X0yeppZoZxkmplradSWyo1S6dR2F8FNpikYdGEJcLzWRaubTBpO?=
 =?us-ascii?Q?48lRESOJKPhycJiTm7pgi7HTxHyncuCqvHOBbg1nmGN3KujLh6zSC/Ag97an?=
 =?us-ascii?Q?ZhcDH89yixUOHvxLUURW8gcowzMYyZ+ssunPgoncDpX1U+xX7f0KfXOToqre?=
 =?us-ascii?Q?t0ar8Dpuh9I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLSPRMB0017.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(10070799003)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?x7lWOG/SSgPKnJnrrRYxHSCdpgib+Kk7kVDWdcXsJVOkmCvEP7MoCb1EvwFl?=
 =?us-ascii?Q?khUB9eK8O9+G090TaffjSKxZ7tYmOPi2FKUA5Lb9pZOCxkGX8jnqvdpPyb+1?=
 =?us-ascii?Q?0UEg2TWGbDAIu9av+9DcAiQn1lcPONLS5kbQ2oeaAPHi6VNk9b0M826ZxH+E?=
 =?us-ascii?Q?+vrNku/FR7JLkgHkYQH9Cmyf/jHtAVuixUnaHijN9+TBU7tg9r61vCljXeD8?=
 =?us-ascii?Q?uh2RtEfsISAuvU8dlAepbU6pPb4StboSeyrD2DaMA2wo0CSz3O8+PPr4s9M4?=
 =?us-ascii?Q?xN2S7NP6z+/lJtiYoVSCnb0UYKRJbamV4uHXuU5MiiIvNTUlFkFvilnkMomd?=
 =?us-ascii?Q?qM2x7rq0H/CWz2yv5vmbQo3HU8AgkTH67RMMDSEIAEAmLOtZ4FopBi6sgFKs?=
 =?us-ascii?Q?Su2fA30byqCitxSiXLZKUlOSvRm2tqkUVeuw05DJQ5N4Nl2eIoRDs64lT36q?=
 =?us-ascii?Q?XeHkhtaO1wkwKHGVqMIbvxAY26jSNwFEYl5mnlhXhoQArmBkll+KjSKl5Imy?=
 =?us-ascii?Q?vWbUuIXa33YkEse99ij6tn2WmNJC3a1VNbl3rs3412R+GBKOQQNfoGC86m1r?=
 =?us-ascii?Q?m2neRQGtCwFtneRmopVz58GxC/tedKNyIy560xDI5Vo/Lvneyi0+vhdW+tD/?=
 =?us-ascii?Q?6vd+xHQ4eD/0jtpde4jxBoqU+CndF5OuRNDQW5sFQI0NxIcFHEbpDa5YvBc4?=
 =?us-ascii?Q?Ak0+bgndQlB3K9sfsWdRuQAh13a+1JUz129xHWg2+zD0o5bwyScNthFv3VMp?=
 =?us-ascii?Q?UYeYj3XLp8JvRKo/B8AWESFeigHOCNrFAq9NWYr3BfMyk1JLrfBTR9g5CiUY?=
 =?us-ascii?Q?9Iwz4TJKxUNCGqTcuKe98RDEjOf9uZ2ag9kDZcHUjWeSjSXH0LAHJqGQ8gKQ?=
 =?us-ascii?Q?ARXrVFZTsTi6CbZLCLbnU9pl3WFu+DcZuaGA+JkerQDaKKBxTWnjYVs4DFS9?=
 =?us-ascii?Q?VmGqw3s6jSo/92hLoX6B0IlCVD2Fz6JMOvxozYHws1J0EVrsAIuJgGUd6b/Q?=
 =?us-ascii?Q?Wng2wHHRKeTe42VQia/s1UC9AlXEqFOMAn7DxLnKwoHHN+d88A4kwdI2/2fV?=
 =?us-ascii?Q?tSeco4GqZ+Hc4wyEm0GuuIrNTEwe/Fgbx/daaNVWftVk5zF4VzGvnWx/iY4S?=
 =?us-ascii?Q?rxil/8rVif2XNhOLXLLW00NWgUai7euIjXqHZJOFVbHtsLDmOkMQBHJayX9I?=
 =?us-ascii?Q?zDi5aTLJh27w6W3lw5suny9ZE7A++DF/2bLWtM5h1XWvIyrEvaOPrk/e1C+q?=
 =?us-ascii?Q?tzESIyTO3ziRgktwh/OnANsoJQz0x9J3YhZyvVKpDIq9q+Wws399mdGng3hd?=
 =?us-ascii?Q?X1QhTVfnPfkNbnf+QoFx24idrKCklMtvydiAY/jpmmp79hreW2B71TyPFGyW?=
 =?us-ascii?Q?wdytS08w7uoG86Za5rh1LylUY7ykFetHQPEBKDl7QG6OVy+pVeDeC7BLHd7d?=
 =?us-ascii?Q?it4YfjJS4yrDMxzlKyGX6qaAFsOpMG/Vp+3S6i4+MuKQq3ua16k9oAUFLfjH?=
 =?us-ascii?Q?faURoblqJ1bLsHJro92y/joelzcvM6mcvZynUOPyDiZbcQTZ99QdRo7tjB9u?=
 =?us-ascii?Q?y8+wdwKyWc2clHo/qUtfJfVYRSkHC5prkNQFZnhZ6R+hgVTBlL2JtJml+XCe?=
 =?us-ascii?Q?SA=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: a7825666-c5b7-4727-bf21-08ddf0b86784
X-MS-Exchange-CrossTenant-AuthSource: CWLSPRMB0017.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 22:21:35.9139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ufqw4xHoFjdbq6usQdlEaLYLjqWT5hkQH/eBaUqTtqkqc+xgaHm8417RkNaOanvK51oGHOuX+PV/inabvb6syg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB2151

On Fri,  5 Sep 2025 16:05:31 +0200
Benno Lossin <lossin@kernel.org> wrote:

> Allow writing `_: { /* any number of statements */ }` in initializers to
> run arbitrary code during initialization.
> 
>     try_init!(MyStruct {
>         _: {
>             if check_something() {
>                 return Err(MyError);
>             }
>         },
>         foo: Foo::new(val),
>         _: {
>             println!("successfully initialized `MyStruct`");
>         },
>     })
> 
> Link: https://github.com/Rust-for-Linux/pin-init/pull/84/commits/2880a9b898336e2d54f80715f00ce00f21f74d2f
> Signed-off-by: Benno Lossin <lossin@kernel.org>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
> I originally wanted to do some more modifications to the syntax of
> initializer macros, but I didn't have the time this cycle. See
> 
>     https://github.com/Rust-for-Linux/pin-init/pull/69
> 
> For the development of that syntax, it's probably going to be like a
> closure where in order to support formatting via rustfmt. But it still
> needs some disucssion around removing `<-`.
> 
> That change would allow having a `let` that binds a value for use in the
> initializer. IIRC @Alice, you needed that for something.
> ---
>  rust/pin-init/src/lib.rs    |  2 ++
>  rust/pin-init/src/macros.rs | 29 +++++++++++++++++++++++++++++
>  2 files changed, 31 insertions(+)
> 
> diff --git a/rust/pin-init/src/lib.rs b/rust/pin-init/src/lib.rs
> index 62e013a5cc20..8b556b0e106a 100644
> --- a/rust/pin-init/src/lib.rs
> +++ b/rust/pin-init/src/lib.rs
> @@ -740,6 +740,8 @@ macro_rules! stack_try_pin_init {
>  /// As already mentioned in the examples above, inside of `pin_init!` a `struct` initializer with
>  /// the following modifications is expected:
>  /// - Fields that you want to initialize in-place have to use `<-` instead of `:`.
> +/// - You can use `_: { /* run any user-code here */ },` anywhere where you can place fields in
> +///   order to run arbitrary code.
>  /// - In front of the initializer you can write `&this in` to have access to a [`NonNull<Self>`]
>  ///   pointer named `this` inside of the initializer.
>  /// - Using struct update syntax one can place `..Zeroable::init_zeroed()` at the very end of the
> diff --git a/rust/pin-init/src/macros.rs b/rust/pin-init/src/macros.rs
> index 9ced630737b8..752e77db998c 100644
> --- a/rust/pin-init/src/macros.rs
> +++ b/rust/pin-init/src/macros.rs
> @@ -1202,6 +1202,21 @@ fn assert_zeroable<T: $crate::Zeroable>(_: *mut T) {}
>          // have been initialized. Therefore we can now dismiss the guards by forgetting them.
>          $(::core::mem::forget($guards);)*
>      };
> +    (init_slot($($use_data:ident)?):
> +        @data($data:ident),
> +        @slot($slot:ident),
> +        @guards($($guards:ident,)*),
> +        // arbitrary code block
> +        @munch_fields(_: { $($code:tt)* }, $($rest:tt)*),
> +    ) => {
> +        { $($code)* }
> +        $crate::__init_internal!(init_slot($($use_data)?):
> +            @data($data),
> +            @slot($slot),
> +            @guards($($guards,)*),
> +            @munch_fields($($rest)*),
> +        );
> +    };
>      (init_slot($use_data:ident): // `use_data` is present, so we use the `data` to init fields.
>          @data($data:ident),
>          @slot($slot:ident),
> @@ -1351,6 +1366,20 @@ fn assert_zeroable<T: $crate::Zeroable>(_: *mut T) {}
>              );
>          }
>      };
> +    (make_initializer:
> +        @slot($slot:ident),
> +        @type_name($t:path),
> +        @munch_fields(_: { $($code:tt)* }, $($rest:tt)*),
> +        @acc($($acc:tt)*),
> +    ) => {
> +        // code blocks are ignored for the initializer check
> +        $crate::__init_internal!(make_initializer:
> +            @slot($slot),
> +            @type_name($t),
> +            @munch_fields($($rest)*),
> +            @acc($($acc)*),
> +        );
> +    };
>      (make_initializer:
>          @slot($slot:ident),
>          @type_name($t:path),
> 
> base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585


