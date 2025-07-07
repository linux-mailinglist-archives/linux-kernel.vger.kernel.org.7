Return-Path: <linux-kernel+bounces-720145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F76AFB793
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 17:39:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E64BF3B41D0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 15:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEEB81E8322;
	Mon,  7 Jul 2025 15:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q+khIQHn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481081E0DD8;
	Mon,  7 Jul 2025 15:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751902788; cv=none; b=Aeu8s8KFP2TIgcZtLItuvdlH7VrEbNHOjMX7haU4316rrKwBBhxIaTG3smTdILkWyUjAcvZlePsPaElmOA7eUyrma3DYnStjB2JXrjnNkaMIfemaluMGKqDM6rvdvy0LXoZ610XJl4BVilH+UGwvrw3pqwA7lXNlEVionH4HooI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751902788; c=relaxed/simple;
	bh=HmhTiVa00MgpfKHIrYzKLuieWi+vDw23ICdBOehXfc0=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=iM4fTUGpA9q+IB4IFEbovF6hkdNmPUF7YkPX5ueRgEu6yxDvRzp2fb+x5h82J9w130XgS7RkWo/VZxx3fLLOkYSGu0LcRTfEhPOCH9gxdwuJZGrYICrMDPwDxsjgd2+pIRqSCJAbg9cgfw7A+8ZAZsFbkb7KlBeJKIP94728Qy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q+khIQHn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AF3EC4CEE3;
	Mon,  7 Jul 2025 15:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751902787;
	bh=HmhTiVa00MgpfKHIrYzKLuieWi+vDw23ICdBOehXfc0=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=Q+khIQHnpnzCtLIonNrjn2fqLEK8U67EA0IXvjUfI9MIDprrRurhQEpxmZUpFavpz
	 YQ2CCaHi/gQ2QjtlYwyN+/pW9O/tp0bas+VhQsqADyUM/yYDl0hua9rpm5vfOBb3nK
	 irJNdMgvHZwbf5/ZXpQ1KfvngmDWINFVkER+VLgMd/NjsAWDodf2EdAzwhZPh5Gj/3
	 CW026f9ry3ElvwHxwk0vuhyzUlVtvRVE1m6clRUNYtHxRJzf2MY8DtvSp/QrW6XqZj
	 o+6lzARLXmn+8CcPeUH+gUGDtqE5Fkm5GIzGVhKy6dm00ZNfKu4jYVRSi85HHHnVI3
	 iBfbMdjzJgWeg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 07 Jul 2025 17:39:43 +0200
Message-Id: <DB5XPFYBATZZ.5EH3TWGPHTDB@kernel.org>
To: "Andreas Hindborg" <a.hindborg@kernel.org>
Cc: "Oliver Mangold" <oliver.mangold@pm.me>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Asahi Lina"
 <lina+kernel@asahilina.net>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v11 4/4] rust: Add `OwnableRefCounted`
From: "Benno Lossin" <lossin@kernel.org>
X-Mailer: aerc 0.20.1
References: <20250618-unique-ref-v11-0-49eadcdc0aa6@pm.me>
 <20250618-unique-ref-v11-4-49eadcdc0aa6@pm.me>
 <DB1LPFAX66WG.1QL5JDCWI7RN4@kernel.org> <aGuAR7JCrlmzQrx4@mango>
 <gFz7glX0UIHGffQdm4_vD_XkT5GZEKB0Lx0cd8-TCR8glMzIIY7VBIvppFVr2RURNBnGx9lKJqrE5av7xSUcbA==@protonmail.internalid> <DB5PX74OB3DX.1UNT8MIBWNC2G@kernel.org> <87bjpwqmo5.fsf@kernel.org> <gUxXEpuPZ0HXQ-cptykcSOV4dVbZNFvDq4Ey5YR1GT8exNFK0qhYAg4HFgWTvTpDk8HXMGl5XThvR7f4m-T6Sg==@protonmail.internalid> <DB5SRE5S7AR3.QUF369W9JYGJ@kernel.org> <87zfdgp253.fsf@kernel.org>
In-Reply-To: <87zfdgp253.fsf@kernel.org>

On Mon Jul 7, 2025 at 3:21 PM CEST, Andreas Hindborg wrote:
> "Benno Lossin" <lossin@kernel.org> writes:
>
>> On Mon Jul 7, 2025 at 1:12 PM CEST, Andreas Hindborg wrote:
>>> "Benno Lossin" <lossin@kernel.org> writes:
>>>> Ah right, I forgot about this. What was the refcount characteristics o=
f
>>>> this again?
>>>>
>>>> *  1 =3D in flight, owned by C
>>>> *  2 =3D in flight, owned by Rust
>>>> * >2 =3D in flight, owned by Rust + additional references used by Rust
>>>>        code
>>>>
>>>> Correct? Maybe @Andreas can check.
>>>
>>> We have been a bit back and forth on this. This is how we would like it
>>> going forward:
>>>
>>>
>>> /// There are three states for a request that the Rust bindings care ab=
out:
>>> ///
>>> /// - 0: The request is owned by C block layer or is uniquely reference=
d (by [`Owned<_>`]).
>>> /// - 1: The request is owned by Rust abstractions but is not reference=
d.
>>> /// - 2+: There is one or more [`ARef`] instances referencing the reque=
st.
>>
>> Huh, now I'm more confused... Could you go into the details again?
>
> Well, there is not much to it. We found out we can alias "unique" and
> "owned by C".
>
> We initialize the refcount to 0 when we initialize the request
> structure. This happens at queue creation time.

And IIRC this refcount is only on the Rust side, since you store it in
some private data, right?

> When C block layer hands over a request for processing to a Rust driver,
> we `debug_assert!` that the refcount is 0. We unsafely invent an
> `Owned<Request<_>>` and pass that to the driver.

And you don't increment the refcount?

> The driver has the option of `into_shared` to obtain an
> `ARef<Request<_>>`. We use this for remote completion and timer
> completion in rnull.

This operation will set the refcount to 2?

> In most drivers, when the driver hands off the request to the hardware,
> the driver will stop accounting for the request. The `Owned<Request<_>>`
> is consumed when issuing to the driver, or the driver could simply drop
> it. Refcount goes to 1. An ID is passed along to hardware.

And with the current API design it must let go of all `ARef<Request<_>>`
because otherwise it can't call `end_ok` (or some other method?).

> When a completion comes back from hardware, it carries the ID. We use
> the C block layer `tag_to_rq` machinery to turn this ID back into an
> `Owned<Request<_>>`. In that process, we check that `refcount =3D=3D 1` a=
nd
> if so, we set refcount to 0 and invent an `Owned<Request<_>>`.

(because if not, this would be wrong)

I have some idea what we should do for the safety requirements of
`Ownable`, but still need some time to write it down.

---
Cheers,
Benno

> There was simply no need to have two separate values for "owned by C"
> and "owned by Rust, not referenced".
>
> Best regards,
> Andreas Hindborg


