Return-Path: <linux-kernel+bounces-745930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4CE6B1209D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 17:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AA735A4622
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 15:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332BB2ED877;
	Fri, 25 Jul 2025 15:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KRByOjHn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F49218991C;
	Fri, 25 Jul 2025 15:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753456046; cv=none; b=rgtpM6uvLOQcD9MpGO2dV1GVKxhHl54d+jf+OL8rZLGzTxqRCaYY5ng4dG8UESTLmPzmQ3r4w8qFAJErZTSGFVIFpA2CW5hIP74lnkTPNdFANoSN8FoiZeCYJ/I8fk8ZSXelDrQ8jXwKYzEK1kaR+vpXMp4ojdNbV2B1+JiERL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753456046; c=relaxed/simple;
	bh=Ba1sOIBAzvxqki+3uQJqRL0TrBLWOJfMHJfhHCh42yw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DXYny/EK1g78z8vu9iMgF6TkOE3SctDWWEoyZ54oK3EosEpeDhEHubbltuRmC2NZwJ3ka0BXXtfwnoM9thrf5xjchdPg7ybW2AZjAlbOasU2kZomgRp/UrAvewoSF7b0KEgv9tkNRfCGrvKXxia5A+IUGKNVfZpLEZb/spkiOsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KRByOjHn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77589C4CEEB;
	Fri, 25 Jul 2025 15:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753456046;
	bh=Ba1sOIBAzvxqki+3uQJqRL0TrBLWOJfMHJfhHCh42yw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KRByOjHnYwZHgkjq4FRbprKJ5mdkn1qxfstLphLZGMBffWql3nQ1t4HMNQfvegH/j
	 t/WEx6jJ+k7dostiBqmXmsBs+/spHyauVtlanb6/E2GWLWGy39ICBle2pNWN2BB4eE
	 VjScY0QcW4UAIoUu+RzAoQ/LMagEKAvflEWK2FQjoHbXNX+s1kv79jZAhG0neUAyNp
	 Nf/fn4txUHeT6ENIG6hkXGUHHWO83UqJvPXfeXpqBu9FEpJmVIaazCD6Cz+pxsvtnO
	 983PaaxwT+G7ry4zjhpxLFGrptg5jt5fmQmd+bo04m/yBDoFfwD3u6O69mi0udgiI1
	 I2/J0OItegL1w==
Message-ID: <a05133e0-0331-46ce-ab50-c423e40a3879@kernel.org>
Date: Fri, 25 Jul 2025 17:07:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rust: transmute: add `as_bytes` method for `AsBytes`
 trait
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Abdiel Janulgue <abdiel.janulgue@gmail.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Robin Murphy <robin.murphy@arm.com>, Andreas Hindborg
 <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 "Christian S. Lima" <christiansantoslima21@gmail.com>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250725-as_bytes-v2-1-c6584c211a6c@nvidia.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <20250725-as_bytes-v2-1-c6584c211a6c@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/25/25 3:08 PM, Alexandre Courbot wrote:
> diff --git a/rust/kernel/transmute.rs b/rust/kernel/transmute.rs
> index 1c7d43771a37b90150de86699f114a2ffb84db91..d4036986a3d7fb97e5da3e121e9590ad23b784e9 100644
> --- a/rust/kernel/transmute.rs
> +++ b/rust/kernel/transmute.rs
> @@ -47,7 +47,16 @@ macro_rules! impl_frombytes {
>   ///
>   /// Values of this type may not contain any uninitialized bytes. This type must not have interior
>   /// mutability.
> -pub unsafe trait AsBytes {}
> +pub unsafe trait AsBytes {
> +    /// Returns `self` as a slice of bytes.
> +    fn as_bytes(&self) -> &[u8] {
> +        let data = (self as *const Self).cast::<u8>();

I'd probably use from_ref() instead. With that,

	Reviewed-by: Danilo Krummrich <dakr@kernel.org>

> +        let len = size_of_val(self);
> +
> +        // SAFETY: `data` is non-null and valid for `len * sizeof::<u8>()` bytes.
> +        unsafe { core::slice::from_raw_parts(data, len) }
> +    }
> +}

