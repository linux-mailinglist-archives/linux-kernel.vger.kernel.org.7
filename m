Return-Path: <linux-kernel+bounces-746793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C37B12B43
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 17:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D1DFAA2352
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 15:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936C2286D79;
	Sat, 26 Jul 2025 15:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="Uo+/d+LQ"
Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021124.outbound.protection.outlook.com [52.101.95.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2919628643F;
	Sat, 26 Jul 2025 15:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753545033; cv=fail; b=evR/xQlYYdjsTnDuVw4QFZemR8M/ph92QHFacuL/xi0uxu8VGcuqXr2lq5RKVF1VZjB1LTTQFcHiP8THcYvJpQ5749S6IaSpHYnQpMgV5yUZRu/k7i7S9eAC5QtN6ylQSDhhin+szAVqo+ertlm9iFnB+KFTdTS8tk2ELl03wFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753545033; c=relaxed/simple;
	bh=uxi6d+lcMOKPmOaoj2jCU6fcR3w9Lg4xUiZ2bQxMQMk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e/+SE39Px1jNOanFt1I2JQh6LZjh44P+v9LTPRbbPRacaTDfWSmdzwCZYh0OosmaH1VoUfdIxwWR2tELiPHTo7dCpVQlOO4lUXXL/TiyBLimcjjLE8FJVGOguVPNrrMWuptdCeTmD9Pt/cwNdEFvxoy6SyUjGwnguP0GvPBS728=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=Uo+/d+LQ; arc=fail smtp.client-ip=52.101.95.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JHcNPEMlPge8TubxDtzq4CgxiRX4Fi4msyHwwbi6W681iZTl9JRyQBRMcooWiQNXo2zb3KWlV2WOnmlFKHw4RZg0Wfe2gGeF5NqeKflTY3nNBW6d1QeJBo0V9xgSRVL9XhD4O4/EivGNzitVvkBHOO6423d3tTE4tsEKRrvxPseD5aXai6oXOtjtBjehRefd34t3C7tAD6cZ9LH+WWR2zN/+h0rsHr+s0CZkY1gb2JgMirEqm8Dt8zYWBUm2W/0spZJrYN+ZoFXN+6V4HrggxyEJtrDAPE8R2ZRMV6l42uhenpTDtxybQgHfqMxbMy+w0uW3dNFb+7MSNbvUm//Ugw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ytHTFknUpfOwh2UivRZEvcOG8i6S/tGf+DWuY00ygmQ=;
 b=dEGzhNe2lWHEriir3G+3ZwA+3fPGwjkgGYeTGH682Czyr8nFh+iWWRTrWG12y2MkXCeM1JMpc4RqbHcgU4Ng6URVWWWtPuKbKgfIezbrZuJQp3QVTuH35KTm/N3xcdBfJIp+IJOo1kPT4EU2cj86RsNyEaMQCGUXmOD6NfttpHbhhCcloazji2Fhg2hTrWAryvTbMYbdEq87LiOp8oW5vfsH+IWTIYrZXNc3IC48DGCDa0c7TgyFSb2SwcvZrjqgF23Uc+5RZ3ciXljTchiEByz6Ih1PRDABFw4syFLxY3m2ip5n/Fe74M6N9sPVpu1ssc2Wt3qtan5DzsVT5jx5Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ytHTFknUpfOwh2UivRZEvcOG8i6S/tGf+DWuY00ygmQ=;
 b=Uo+/d+LQPv5dWyOn5RriTUYAYNyd0EX0tgyAb5+RbZHX6OicE3ptTb/1xwtfbchp2AW0G3PtD+x+WSGWHC9fby0pPaSvLMALimpmcPCQwYB0HJwWpv/PvmRhFgRy/d8rFxOstNfJo0ntnNzNr5TklLmKsK/TFz5z7kvxiR7Q4MA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO9P265MB7475.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:3a0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.25; Sat, 26 Jul
 2025 15:50:22 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%4]) with mapi id 15.20.8964.024; Sat, 26 Jul 2025
 15:50:22 +0000
Date: Sat, 26 Jul 2025 16:50:20 +0100
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
Subject: Re: [PATCH 2/3] rust: maple_tree: add MapleTree::lock() and load()
Message-ID: <20250726165020.46880c31.gary@garyguo.net>
In-Reply-To: <20250726-maple-tree-v1-2-27a3da7cb8e5@google.com>
References: <20250726-maple-tree-v1-0-27a3da7cb8e5@google.com>
	<20250726-maple-tree-v1-2-27a3da7cb8e5@google.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0319.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::19) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO9P265MB7475:EE_
X-MS-Office365-Filtering-Correlation-Id: e634dc82-d01e-4458-e16e-08ddcc5c211f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kdJ8+DVP9ee9OMJs/3TsUM12COujCrMPxs3x2Jw58zahjY9oSU2c5wnRV/YL?=
 =?us-ascii?Q?LDFXvKt3iw9uhKtX1R5S4SDv5VL/rdkAJXp0Lvq/wgRejiMtcUCtRD/cyDSu?=
 =?us-ascii?Q?6estirCXqBuIxG0uB/0oUygVz0my0zwexaxXYxjn1FwQnDXnAbs54mH+q2Wk?=
 =?us-ascii?Q?FSUePDJ6sk8Wi+KEaU0d7UcslaxXZaQkzCDcuYJqwE7ZauI6LiCASLuoZBBV?=
 =?us-ascii?Q?CHntPAeEn9qmggiAM+5G89hREomIw78VcuX+zhHpgU9ZTj3FCNoZIsyvoWaQ?=
 =?us-ascii?Q?VPsgkA6kRGvi//sDgclvi8dSPGe82MSsti7cX/QOySTOpsoqUawO2nhVu6o8?=
 =?us-ascii?Q?uCe+dq9RpJqcXiO/R3Lv5c+f/d/q26mWqe/QLjoK3OedEzyJEqAFFZcLCRN1?=
 =?us-ascii?Q?yNIUBNEDVgPE3lLr1ttUOmt31emjj9gm8AEEw90LAxI4dOdpSxFf9KAf1Tco?=
 =?us-ascii?Q?1VqvZRi1vLDA11Jesae92FG4B978zrPUkOf75/krOOLyzZ+MC0PPyNLQhumG?=
 =?us-ascii?Q?iHwJFUNWiNY1SZCSb5f3y4Ax2YtbE6/qetZ8LaBAmB7DUjqOWGFvmRjTFXDj?=
 =?us-ascii?Q?qs3isBxgkEinZYPpuJUX6wuNnTnSz0ru7DjNw8Z/c98yEy0ShWbzpa6tV7Mz?=
 =?us-ascii?Q?gc9cAbj0mz0zEqIMGsbtGPeRhQ9/Z0uvcU9vw4mHBx4DuVTOqda1hhJGYnKn?=
 =?us-ascii?Q?v4dTKGGvtpMcIRlX2tHKSEbG+nuYg6pFeKtxc/kjCGF21jzZpEPj3d73x7dQ?=
 =?us-ascii?Q?vJUj5aaMDHpv8xDQJqcie4eRyQclQL3JxXrCcZj3iyByoFN/AoVVCBs1u0Wr?=
 =?us-ascii?Q?BCuFbZUNR1GL7uQ1CtjaYfd6WfIoDtJ/lNxWyQAsLF6zaWQzvnKjVf1+pBDY?=
 =?us-ascii?Q?hkeR73FmveBWsIqJb0Kh8G+xI032QrZStwgY+8BRXzu9dyfXb+KoKhKEOPFl?=
 =?us-ascii?Q?R5+JcSMMnmkRjwMpRzjZz+LYlZuYHXFIq4mYbVyN0XlwmD4BBK50EJFw3nJX?=
 =?us-ascii?Q?kJaVq5hQEhBzxQkIrnfy321uMDmWhVLHmUfq7VoolESc4ibAzFI5RpZfB6K0?=
 =?us-ascii?Q?nSMIkCxLL0b3+CuaCzww/1EDHW/+OnZC5AChBSTyh6Xf8LtsQsuivf6hYK3j?=
 =?us-ascii?Q?heWbMahBvRd0eZowgrMU6zRx2+3YSuO3mXoAGcFbgvXJDVVTiGfxI8wOBIkN?=
 =?us-ascii?Q?nBCk9xNPmpVIooe0Z26/w2q9Ou2DF4OgEp8HizG89iHEjEHsL3iCReC0/ZXk?=
 =?us-ascii?Q?fRhFHOxZ3xeR9CNJzkSUOagPMTQ3eUR01OorZPYPpwLW4LxazpxzChXTX88x?=
 =?us-ascii?Q?MwR0TlfYOrJ7s7CKmnCyEYu/oOHtVFJdE8Z2lNfB6SREXFiarstQYrySRGxc?=
 =?us-ascii?Q?diAnya6hvk0zrPmWp7clKmt4GxZic7R/g7NgeXUU7s9D60Nm46/9VvDY3iHB?=
 =?us-ascii?Q?TJBI4Ijq4l0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V+oaDqI8O3iVOegBVXCy5yWEkOTv2vVjNzBehbWYxPCZuFsOlG8giZVF4N2Q?=
 =?us-ascii?Q?X9PWGrQ34zaIG3MZ8WOiwhqFCYEebZMiiOkOosJjzchqZNckue0YM0rlYlba?=
 =?us-ascii?Q?ElKVHYZEEjxvg1AfhoywKNnZFXEwFArF94TbUAFILax3sqBwy+tmKmllWtwh?=
 =?us-ascii?Q?//Vnps1mMhWXHlAd0KFojFtL67VRAQbJpTTZfEBOFT9awNM022onvhrPZuyN?=
 =?us-ascii?Q?1XNRTVNMavpABiohO/RNUkWmdy1iY5pw92EkRXUDki5jZ90lFlc4+4rF+5dD?=
 =?us-ascii?Q?Ee8J6HuwDKUipKKr/QWMsVN06KW7+pzG0s7v8F4HVK/5tHQHURNW4wOYLVo/?=
 =?us-ascii?Q?XAc5CCU/U6jONsWjArFtEe4xNx/2S0y6QOdQCIDRnu8G/qw6Nl6Nf8ciFoaX?=
 =?us-ascii?Q?hkKTASEIjX45hkDTnP8FPxY0etAnmvNDOfeoMzidvfVPY+mMPiL/lp09nzvR?=
 =?us-ascii?Q?gd4RNDyPhBDUtXmK7ctY7MoNcDigA3+vqPDr5Mo7ytreIcp7oqtsI+TL7bJl?=
 =?us-ascii?Q?aN1Xg03+qcYtAAKJ0d/tiUE3wPBaeijXCR1A6nXl6KLJqBPHom+VN+2fJPvr?=
 =?us-ascii?Q?nPw295Ag8YEesMtor/SVCsT5hBgVEy8hF2IPopKk/TiFTK9k5Xry2WQKhgYe?=
 =?us-ascii?Q?vC5XiE6xfJUFQlj+X6tMpplRul2CLFLYQfUMtkS7fmIhvhqT8O+rkmWtqHL2?=
 =?us-ascii?Q?wFdYGaZb3DVE2dTE2mWNHE9hxrr5q1V6cmdXSijwUvGTmn9f490zaCgkAWIw?=
 =?us-ascii?Q?oYgYJ5gTJJrQIzNn86V/pK3w2kPkmpriP2F/u+lq+8HnYff5KFUilpcCUj1N?=
 =?us-ascii?Q?5rRjF1FyRq345Y8mVWzyEFKc3fX7HSRpbabtLQiWAsSe0IPr154DtJ1nLjYo?=
 =?us-ascii?Q?O1Q/mWE/pqL86S5aylgVgmbORbOFrpMMHoQD9G9eP2TL7/do6GU0VvWSAuKu?=
 =?us-ascii?Q?gDk6r17K5k5pTPeTWl7RoHkUyJjqNz2OieV5yIIqXkeOyowRclYnGZsOgg6C?=
 =?us-ascii?Q?+jBcka3iMwYm4r5pChzhaW4Z8ALejYN8/TALSc9oQ3M4EqLlzjFPvFRaK6OR?=
 =?us-ascii?Q?DJ/GJHW7N6+iwXps7EfnC8BSfTDMtcMHIdiAZi+2JHfLPZmqSP+3Fl7rWxas?=
 =?us-ascii?Q?bslQFp6ecOm+7x7E7WAAZ/BmSIpwgKPFGQTFeilXlDE2vs5Ht+1qQ2XIC95S?=
 =?us-ascii?Q?oIM2SrBfDk7Fm8104ORkPVlB5u1WEeulckyWwvwQ6MT4vhVdYyEkWStXt5sb?=
 =?us-ascii?Q?XHTqxApOJ+i3KgHSPNbtRzF2CoowZ/UvQ/4p+YqujPyi+5IvKn/O9leQ2USq?=
 =?us-ascii?Q?aaG1tEiJBHa2jfatS8WgTemTXbCIFWPv8YbbsBEAyUsswD31BG/SglC452az?=
 =?us-ascii?Q?Z2aOB6oX7pTyJOIRRHA4oaOEqiD/SzJklAoun9OKOvtKTCf2VBsRLr7E+Wdo?=
 =?us-ascii?Q?f+KBW49geBeqNSmVC4A+FPPWnpJhvMJxMKIloXm1c4ANzyrygRDTWTUNk/bx?=
 =?us-ascii?Q?tM50qrEyOP4T9/JT6MSY8fFjJWG8NHdakqEMtA338KcEor3wmwpuCZELOVd0?=
 =?us-ascii?Q?DAYvehpEGyUZrf5jOy/Z2vZTTbxOyZEEL3ZNBo0YhG5SnEPQWIviObJxY3O5?=
 =?us-ascii?Q?zw=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: e634dc82-d01e-4458-e16e-08ddcc5c211f
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2025 15:50:22.2804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8z2k3C1kQT/4il6Y90vz1onpyRRjDyxsJOkFMetm8Tts/ztDO5PQVIPbJZBm2Tf166kprSzHC5Y2nuSd0oPfQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO9P265MB7475

On Sat, 26 Jul 2025 13:23:23 +0000
Alice Ryhl <aliceryhl@google.com> wrote:

> To load a value, one must be careful to hold the lock while accessing
> it. To enable this, we add a lock() method so that you can perform
> operations on the value before the spinlock is released.
> 
> Co-developed-by: Andrew Ballance <andrewjballance@gmail.com>
> Signed-off-by: Andrew Ballance <andrewjballance@gmail.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/maple_tree.rs | 94 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 94 insertions(+)
> 
> diff --git a/rust/kernel/maple_tree.rs b/rust/kernel/maple_tree.rs
> index 0f26c173eedc7c79bb8e2b56fe85e8a266b3ae0c..c7ef504a9c78065b3d5752b4f5337fb6277182d1 100644
> --- a/rust/kernel/maple_tree.rs
> +++ b/rust/kernel/maple_tree.rs
> @@ -206,6 +206,23 @@ pub fn erase(&self, index: usize) -> Option<T> {
>          unsafe { T::try_from_foreign(ret) }
>      }
>  
> +    /// Lock the internal spinlock.
> +    #[inline]
> +    pub fn lock(&self) -> MapleLock<'_, T> {
> +        // SAFETY: It's safe to lock the spinlock in a maple tree.
> +        unsafe { bindings::spin_lock(self.ma_lock()) };
> +
> +        // INVARIANT: We just took the spinlock.
> +        MapleLock(self)
> +    }
> +
> +    #[inline]
> +    fn ma_lock(&self) -> *mut bindings::spinlock_t {
> +        // SAFETY: This pointer offset operation stays in-bounds.
> +        let lock = unsafe { &raw mut (*self.tree.get()).__bindgen_anon_1.ma_lock };
> +        lock.cast()
> +    }

Could this return `&SpinLock<()>` using `Lock::from_raw`?

I guess it has the drawback of having `MapleLock` needing to store
`ma_lock` pointer but the guard is usually just all on stack and
inlined so it probably won't make a difference?

This way you remove `unsafe` from `lock` and gets a free `drop`.

> +
>      /// Free all `T` instances in this tree.
>      ///
>      /// # Safety
> @@ -248,6 +265,83 @@ fn drop(mut self: Pin<&mut Self>) {
>      }
>  }
>  
> +/// A reference to a [`MapleTree`] that owns the inner lock.
> +///
> +/// # Invariants
> +///
> +/// This guard owns the inner spinlock.
> +pub struct MapleLock<'tree, T: ForeignOwnable>(&'tree MapleTree<T>);
> +
> +impl<'tree, T: ForeignOwnable> Drop for MapleLock<'tree, T> {
> +    #[inline]
> +    fn drop(&mut self) {
> +        // SAFETY: By the type invariants, we hold this spinlock.
> +        unsafe { bindings::spin_unlock(self.0.ma_lock()) };
> +    }
> +}

