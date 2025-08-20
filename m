Return-Path: <linux-kernel+bounces-777548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B280B2DAC4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 13:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 086697278D7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 11:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70BF2E339B;
	Wed, 20 Aug 2025 11:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j+c6f9wv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113FA23909F;
	Wed, 20 Aug 2025 11:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755688709; cv=none; b=kRVcwlJe9EDCuw9qVFuEvpHLLtHJ/Xo+9Ctkth8M+rMeJ2MDU4EQTNNdYfLS2x5D8/B1r7GRk2Aiu2aNKrBYDqHDrFvMtZPcGoBAeygbfkpouk24sNztWZ07wQeOf+Gf3G4jGqqWaHfIas+HQppz+Iu87rjMyyD6rVz9uVvv9nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755688709; c=relaxed/simple;
	bh=NvKhqfHAjC7nxN4srjgB/PPxA3etfbhzLv69VOVPOKA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=OvdWTeOFpWmkFuOHoQK4lyiPDyTFq8nZZF4EH3UNsTdDpZR/Og8+9fpciM/xFZkIGwgWmYiXxPiGi35P7Snr+B1oY1jd90vUDdVQpj7iiQThqxdoTciEYH9NoOdZH37aVVY9qkHE7+gkiVNuHpvBy0Cw8ynFs4Vwl1feYcF96LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j+c6f9wv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D925C4CEEB;
	Wed, 20 Aug 2025 11:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755688708;
	bh=NvKhqfHAjC7nxN4srjgB/PPxA3etfbhzLv69VOVPOKA=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=j+c6f9wvQwsckWE4213N/FIFio0R3U3278n1yw8riaV8XMnaYGLGdoxefVtOkrFMS
	 vXn/Q+ukin9JH+3jKvILqVQeba6kwSB5woWp05xEtWysf1puQDnonLq8Ct4dReKyCa
	 nRSmhZPVT0Z95FeeARd++Wv1WPPLU/W1CFZWUehCJBdOgYEgExzjFcTKr036SNgPUn
	 TuH6ck7UUMIzZsj0CdxgCrnEw2XRcxk8cyt98gEuzFGIGO9CMIeHqKwRIw8Ug1BTeK
	 7dd4MBMzVvWabZP1rtovHfDU4+lR0aUpzFuFt3xneVd93sgcKYE1YzzxAOkxTCYsLZ
	 2oqRJ+TxWEzqQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 20 Aug 2025 13:18:23 +0200
Message-Id: <DC77PBXCZP32.1FJ6BGM9YV27H@kernel.org>
Subject: Re: [PATCH] rust: zpool: add abstraction for zpool drivers
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 "Uladzislau Rezki" <urezki@gmail.com>, "Alice Ryhl" <aliceryhl@google.com>,
 "Vlastimil Babka" <vbabka@suse.cz>, "Lorenzo Stoakes"
 <lorenzo.stoakes@oracle.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>,
 "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>, "Bjorn
 Roy Baron" <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>,
 "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor Gross"
 <tmgross@umich.edu>, "Johannes Weiner" <hannes@cmpxchg.org>, "Yosry Ahmed"
 <yosry.ahmed@linux.dev>, "Nhat Pham" <nphamcs@gmail.com>,
 <linux-mm@kvack.org>
To: "Vitaly Wool" <vitaly.wool@konsulko.se>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250820091543.4165305-1-vitaly.wool@konsulko.se>
 <DC76DSYUY978.3NR8S2K13I9RX@kernel.org>
 <C642BA32-4EA5-4843-9625-5DBF40A42C6C@konsulko.se>
In-Reply-To: <C642BA32-4EA5-4843-9625-5DBF40A42C6C@konsulko.se>

On Wed Aug 20, 2025 at 12:44 PM CEST, Vitaly Wool wrote:
>> On Aug 20, 2025, at 12:16=E2=80=AFPM, Danilo Krummrich <dakr@kernel.org>=
 wrote:
>>> +/// zpool API
>>=20
>> It would be nice to have some more documentation on this trait, includin=
g a
>> doc-test illustrating some example usage.
>>=20
>>> +pub trait Zpool {
>>> +    /// Opaque Rust representation of `struct zpool`.
>>> +    type Pool: ForeignOwnable;
>>=20
>> Something that embedds a struct zpool, such as struct zswap_pool? If so,=
 isn't
>> this type simply Self?
>
> I think ForeignOwnable provides a good representation of 'struct zpool=E2=
=80=99 and it=E2=80=99s convenient to borrow it, as done later in the patch=
.

ForeignOwnable is not a representation for a specific type, but rather some=
thing
that originates from the Rust side and is owned by the C side. But that's n=
ot
the case here.

Regarding the "convenient to borrow" part, why can't Zpool::create() return
Result<Self> and e.g. malloc be defined as

	fn malloc(
	   &self,
	   size: usize,
	   gfp: Flags,
	   nid: NumaNode,
	) -> Result<usize>;

i.e. why does it need to be ForeignOwnable in the semantic sense of the tra=
it?

>>> +    /// Make all the necessary preparations for the caller to be able =
to read from the object
>>> +    /// represented by `handle` and return a valid pointer to the `han=
dle` memory to be read.
>>> +    fn read_begin(pool: <Self::Pool as ForeignOwnable>::Borrowed<'_>, =
handle: usize)
>>> +        -> *mut c_void;
>>=20
>> Why does this return a raw pointer? I think this needs a proper type
>> representation.
>
> The zpool API wants a raw pointer here so I decided not to overcomplicate=
 it. I thought of using NonNull<[u8]> but it doesn=E2=80=99t seem to be a g=
ood fit. We=E2=80=99re basically returning a pointer to a place in memory w=
hich is guaranteed to be allocated and owned by us, but it is a raw pointer=
 at the end of the day. What would you recommend here instead?

I don't know the exact semantics behind read_begin(), but we should at leas=
t
encapsulate the pointer into a new type and restrict its lifetime to the
validity of the encapsulated pointer, such that it can't be used in the wro=
ng
way.

More general, if we don't cover such things and use raw pointers for conven=
ience
instead, we may not provide enough of a benefit compared to what we can do =
in
a C API.

>>> +
>>> +    /// Finish reading from a previously allocated `handle`. `handle_m=
em` must be the pointer
>>> +    /// previously returned by `read_begin`.
>>> +    fn read_end(
>>> +        pool: <Self::Pool as ForeignOwnable>::Borrowed<'_>,
>>> +        handle: usize,
>>> +        handle_mem: *mut c_void,
>>> +    );
>>=20
>> Same here...
>>=20
>>> +
>>> +    /// Write to the object represented by a previously allocated `han=
dle`. `handle_mem` points
>>> +    /// to the memory to copy data from, and `mem_len` defines the len=
gth of the data block to
>>> +    /// be copied.
>>> +    fn write(
>>> +        pool: <Self::Pool as ForeignOwnable>::Borrowed<'_>,
>>> +        handle: usize,
>>> +        handle_mem: *mut c_void,
>>=20
>> ...and here.
>>=20
>>> +        mem_len: usize,
>>> +    );
>>> +
>>> +    /// Get the number of pages used by the `pool`.
>>> +    fn total_pages(pool: <Self::Pool as ForeignOwnable>::Borrowed<'_>)=
 -> u64;
>>> +}
>>> +
>>> +/// Zpool driver registration trait.
>>> +pub trait Registration {
>>=20
>> I think you should use the kernel::driver::Registration instead, it's
>> specifically for the purpose you defined this trait and ZpoolDriver for.
>>=20
>> As for the C callbacks, they should go into the Adapter type (which impl=
ements
>> kernel::driver::RegistrationOps) directly, they don't need to be in a tr=
ait.
>>=20
>> This way a new Zpool Registration is created with:
>>=20
>> driver::Registration<zpool::Adapter>::new()
>>=20
>> This also allows you to take advantage of the module_driver!() macro to =
provide
>> your own module_zpool_driver!() macro.
>
> There was once a problem with that but I don=E2=80=99t remember what the =
problem was :) I=E2=80=99ll try that one more time, thanks.

I'm pretty sure this should work out well (just like it does for driver
registrations such as PCI, platform, auxiliary, I2C, etc.). However, if you=
 run
into issues, please let me know, I'm happy to help out resolving them.

