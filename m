Return-Path: <linux-kernel+bounces-736900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB19B0A4E4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 15:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9C384E0C17
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 13:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA8C2DC32E;
	Fri, 18 Jul 2025 13:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AOHStwwO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64152D97BF;
	Fri, 18 Jul 2025 13:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752844477; cv=none; b=BvTHJyAc5bTTNJPSpn22N/hMV+f0eaM1FEfXquodvadBd/ym0voxk7YXj8A0Q3vgqymdXJWlTnA4+a1+rxWB6srG6kwj84JEADogX9Y6nvYp6J3vBVVRZ/G5/z5IfSTa0Dca8kUGhs6ptCiHxc3fr7Xk0m+Ip2vJAswVwHTVHss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752844477; c=relaxed/simple;
	bh=srIBcvlIBdZnSOGUwyyuvReVIxTYEiGoGoFQUMxwiXY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=EZuNNem8CSSER3+Lzb4fFzPkGzwKXI+ZUWAq5PkO2wPxN4zR42DqezuWpNaaFKjGS6SUWWjIw2HsH8uLiss1sPEfN92gKMsKVYGgxTFqkFBBV1Z8cKHhbPmsPAulUBQ3W9IrkMf9Uf9kXOOHroL1jGZhwrBjJzf1xMVfeEtsRwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AOHStwwO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5E85C4CEEB;
	Fri, 18 Jul 2025 13:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752844477;
	bh=srIBcvlIBdZnSOGUwyyuvReVIxTYEiGoGoFQUMxwiXY=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=AOHStwwObJcXKUvCQXJFDR9VakXCy9GKcB/r3RjnFLAECVEolMhKXTSMYGx29cXZ8
	 w+bdTPnGE/liOITa8NzqNVyDqJ3ANHElPe150LLKKCjjQEX1WrX3DXkeuipJnF/0xE
	 EaD6IVVXd7V1yf705d/wqs+p6WotgdzMthy7AXEcUlYXq3p55ecsPAIp3897aohKfZ
	 p749NVNXMw7RYQiVeVKnwvXy++BQAsvkW6evOLFWCI3fEbCTNk8Py0F3y1O5rc346X
	 PZBHHhl26FVx9pqax2MSEPY5bS1f66B8L+ON7qd9h8U/H3wzDzbGxxNaTmiy8Qkw+S
	 YM9PUJHgC50Nw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 18 Jul 2025 15:14:32 +0200
Message-Id: <DBF7IACHZEUW.29EHD3V4OF5GA@kernel.org>
Subject: Re: [PATCH 1/3] device: rust: documentation for DeviceContext
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: "Alexandre Courbot" <acourbot@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250717224806.54763-1-dakr@kernel.org>
 <20250717224806.54763-2-dakr@kernel.org>
 <DBF6M9BZUX3C.2VXBZJKQYGN84@nvidia.com>
In-Reply-To: <DBF6M9BZUX3C.2VXBZJKQYGN84@nvidia.com>

On Fri Jul 18, 2025 at 2:32 PM CEST, Alexandre Courbot wrote:
> On Fri Jul 18, 2025 at 7:45 AM JST, Danilo Krummrich wrote:
>> Expand the documentation around DeviceContext states and types, in order
>> to provide detailed information about their purpose and relationship
>> with each other.
>>
>> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
>
> Thanks, that's a welcome clarification and I think I finally understand
> the Rust device model after going through this series!
>
> A few minor nits/questions below.
>
>> ---
>>  rust/kernel/device.rs | 63 +++++++++++++++++++++++++++++++++++--------
>>  1 file changed, 52 insertions(+), 11 deletions(-)
>>
>> diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
>> index ca82926fd67f..d7ac56628fe5 100644
>> --- a/rust/kernel/device.rs
>> +++ b/rust/kernel/device.rs
>> @@ -311,28 +311,69 @@ unsafe impl Send for Device {}
>>  // synchronization in `struct device`.
>>  unsafe impl Sync for Device {}
>> =20
>> -/// Marker trait for the context of a bus specific device.
>> +/// Marker trait for the context or scope of a bus specific device.
>>  ///
>> -/// Some functions of a bus specific device should only be called from =
a certain context, i.e. bus
>> -/// callbacks, such as `probe()`.
>> +/// [`DeviceContext`] is a marker trait for structures representing the=
 context of a bus specific
>> +/// [`Device`].
>>  ///
>> -/// This is the marker trait for structures representing the context of=
 a bus specific device.
>
> Shall we say `types` instead of `structures`, since these are ZSTs?
> `structures` carries the hint that they will contain data, when they
> don't (but maybe that's only me :)).

I agree, 'types' is better.

>> +/// The specific device context types are: [`CoreInternal`], [`Core`], =
[`Bound`] and [`Normal`].
>> +///
>> +/// [`DeviceContext`] types are hierarchical, which means that there is=
 a strict hierarchy that
>> +/// defines which [`DeviceContext`] type can be derived from another. F=
or instance, any
>> +/// [`Device<Core>`] can dereference to a [`Device<Bound>`].
>> +///
>> +/// The following enunumeration illustrates the dereference hierarchy o=
f [`DeviceContext`] types.
>> +///
>> +/// - [`CoreInternal`] =3D> [`Core`] =3D> [`Bound`] =3D> [`Normal`]
>> +/// - [`Core`] =3D> [`Bound`] =3D> [`Normal`]
>> +/// - [`Bound`] =3D> [`Normal`]
>> +/// - [`Normal`]
>
> That graph is super helpful. The last 3 lines look redundant though,
> since the graph can be followed from any node.

Yeah, it's indeed unnecessarily redundant.

>> +///
>> +/// Bus devices can automatically implement the dereference hierarchy b=
y using
>> +/// [`impl_device_context_deref`](kernel::impl_device_context_deref).
>>  pub trait DeviceContext: private::Sealed {}
>> =20
>> -/// The [`Normal`] context is the context of a bus specific device when=
 it is not an argument of
>> -/// any bus callback.
>> +/// The [`Normal`] context is the default [`DeviceContext`] of any [`De=
vice`].
>> +///
>> +/// The normal context does not indicate any specific scope. Any `Devic=
e<Ctx>` is also a valid
>> +/// [`Device<Normal>`]. It is the only [`DeviceContext`] for which it i=
s valid to implement
>> +/// [`AlwaysRefCounted`](kernel::types::AlwaysRefCounted) for.
>>  pub struct Normal;
>
> `Normal` as a name can be interpreted in many different ways, and in the
> case of a device context it is not clear what the "normal" state is. I
> think it would be helpful if we can elaborate a bit more on what this
> implies (i.e. what concretely speaking are the limitations), and if
> possible why this name has been chosen.

It's the context that does not guarantee any specific scope. But that's als=
o
what the documentation says.

I also wouldn't speak of limitations, it's just that it doesn't allow to ma=
ke
*additional* assumptions compared to other device context types.

Yet, if you have suggestions on what to add specifically, please let me kno=
w
(maybe simply my previous sentence?).

Regarding the name, "Normal" seems reasonable for the device context that d=
oes
not guarantee any specific scope. We could have also named it just "Default=
".

I think "Normal" is fine, as in "it's just a normal device reference, no
specific scope guaranteed".

