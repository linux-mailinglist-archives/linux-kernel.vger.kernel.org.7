Return-Path: <linux-kernel+bounces-777506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4865B2DA46
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 12:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD63A5809C6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 10:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606CD2E2EE5;
	Wed, 20 Aug 2025 10:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="dcpOQ2Sw";
	dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b="S3GRi89e"
Received: from mailrelay-egress16.pub.mailoutpod3-cph3.one.com (mailrelay-egress16.pub.mailoutpod3-cph3.one.com [46.30.212.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438902E2DF0
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 10:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.212.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755686697; cv=none; b=rqjPPOvPLEyhbLADcTx0qgU7gN3qHL9z0JdAF437B8CuY7Q8+SdAKnHHUcTOe/1+26n7Rbvm33Lpjf3iaAvxjM4/16CCZFisP3AphkO/sC7uy+s6d+OWB7WHVxLdoOnPZuj68v2XSeFtLUjdx3qySdDHlb/pjs29uyS8xXTtGwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755686697; c=relaxed/simple;
	bh=T3aJmuUr0MZGftpSD0I8Fmw2jpB/+WoQqnGYBLd2UeU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=TGSSVdcty8h1KMSh+CNY6gmRwS2t2VX3j4NuFlIEP8yDI4SPJMmH4ltQL5N2S/wnqpdlWJtCrfpE/QWuLI/8Z82uLKRX1FOl+8gaK2WSob369IdonYTdFC7+ktoQ4I8RwjxUAACb3rQBjZ8cFrN2YKg/blHW8+21KfHFvQ9tPwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se; spf=none smtp.mailfrom=konsulko.se; dkim=pass (2048-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=dcpOQ2Sw; dkim=permerror (0-bit key) header.d=konsulko.se header.i=@konsulko.se header.b=S3GRi89e; arc=none smtp.client-ip=46.30.212.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=konsulko.se
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=konsulko.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1755686692; x=1756291492;
	d=konsulko.se; s=rsa1;
	h=to:references:message-id:content-transfer-encoding:cc:date:in-reply-to:from:
	 subject:mime-version:content-type:from;
	bh=2tiUiB8q0YOnLg67Qp365JxZm1Sl6QxoVrMSfZD+sO8=;
	b=dcpOQ2SwKg2XglwCK3AVxr8/JzWZ9aHHRraMR4Bs9s177KDw06SpeyTxtKqenk8KoAU8Y7QRNX5iB
	 EiMJnUocYfd2T82I6RMxbLpQWJOfdrpL1cNvLTBHg4YdEpibGbRUHXs2bOMK0GPN0LGrfcCvo1cNVr
	 cSB+CA13d299oPlS4lqb/lBm9AGIWNy7m2hUNHd71NzEbMqmcqsY0+1o90Q2nXEUDdcGGsai7NjTnm
	 xUHR7BnHVB+jq2y+qEMXUrEcQNjY3gSmVa3M4WOdoMe88ECQSKDu1fsHZIrLMhA7jAkhCkBIyg30Rt
	 eJgY7vcYv/4D71qRy3f+WiQiKwsaNJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1755686692; x=1756291492;
	d=konsulko.se; s=ed1;
	h=to:references:message-id:content-transfer-encoding:cc:date:in-reply-to:from:
	 subject:mime-version:content-type:from;
	bh=2tiUiB8q0YOnLg67Qp365JxZm1Sl6QxoVrMSfZD+sO8=;
	b=S3GRi89einGv3S1dx2oc0icvKPUMo+SCJP2yC29Rw96r2H7Tm8TFwPTCzC8H0rnbJa96FXw/65DgE
	 IkJV71VCw==
X-HalOne-ID: b2968fe3-7db2-11f0-8e86-f78b1f841584
Received: from smtpclient.apple (c188-150-224-8.bredband.tele2.se [188.150.224.8])
	by mailrelay1.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
	id b2968fe3-7db2-11f0-8e86-f78b1f841584;
	Wed, 20 Aug 2025 10:44:51 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.200.121\))
Subject: Re: [PATCH] rust: zpool: add abstraction for zpool drivers
From: Vitaly Wool <vitaly.wool@konsulko.se>
In-Reply-To: <DC76DSYUY978.3NR8S2K13I9RX@kernel.org>
Date: Wed, 20 Aug 2025 12:44:40 +0200
Cc: rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Uladzislau Rezki <urezki@gmail.com>,
 Alice Ryhl <aliceryhl@google.com>,
 Vlastimil Babka <vbabka@suse.cz>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 Bjorn Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Yosry Ahmed <yosry.ahmed@linux.dev>,
 Nhat Pham <nphamcs@gmail.com>,
 linux-mm@kvack.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <C642BA32-4EA5-4843-9625-5DBF40A42C6C@konsulko.se>
References: <20250820091543.4165305-1-vitaly.wool@konsulko.se>
 <DC76DSYUY978.3NR8S2K13I9RX@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
X-Mailer: Apple Mail (2.3826.200.121)



> On Aug 20, 2025, at 12:16=E2=80=AFPM, Danilo Krummrich =
<dakr@kernel.org> wrote:
>=20
> On Wed Aug 20, 2025 at 11:15 AM CEST, Vitaly Wool wrote:
>> Zpool is a common frontend for memory storage pool implementations.
>> These pools are typically used to store compressed memory objects,
>> e. g. for Zswap, the lightweight compressed cache for swap pages.
>>=20
>> This patch provides the interface to use Zpool in Rust kernel code,
>> thus enabling Rust implementations of Zpool allocators for Zswap.
>=20
> Do you work on such a user? Do you have code using this API already?
>=20
> More specifically, do you plan to re-implement Zswap in Rust?

I don=E2=80=99t plan to reimplement zswap as a whole, just the =
allocation backend for it. I do have the code but it=E2=80=99s not quite =
ready for submission yet. However, it does work and is publicly =
available at =
https://github.com/vwool/linux-mm/commit/6fde78b24c8f8716c17ffa20cec390b51=
6c7882b
>=20
>> Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.se>
>> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
>=20
> If Alice contributed to the patch you may want to add a =
Co-developed-by: tag,
> otherwise this doesn't need her SoB.

Will do, thanks.

>=20
>> +/// zpool API
>=20
> It would be nice to have some more documentation on this trait, =
including a
> doc-test illustrating some example usage.
>=20
>> +pub trait Zpool {
>> +    /// Opaque Rust representation of `struct zpool`.
>> +    type Pool: ForeignOwnable;
>=20
> Something that embedds a struct zpool, such as struct zswap_pool? If =
so, isn't
> this type simply Self?

I think ForeignOwnable provides a good representation of 'struct =
zpool=E2=80=99 and it=E2=80=99s convenient to borrow it, as done later =
in the patch.

>=20
>> +
>> +    /// Create a pool.
>> +    fn create(name: *const c_uchar, gfp: Flags) -> =
Result<Self::Pool>;
>=20
> This shouldn't be a raw pointer, but rather &CStr.
>=20
>> +
>> +    /// Destroy the pool.
>> +    fn destroy(pool: Self::Pool);
>> +
>> +    /// Allocate an object of size `size` using GFP flags `gfp` from =
the pool `pool`, wuth the
>> +    /// preferred NUMA node `nid`. If the allocation is successful, =
an opaque handle is returned.
>> +    fn malloc(
>> +        pool: <Self::Pool as ForeignOwnable>::BorrowedMut<'_>,
>> +        size: usize,
>> +        gfp: Flags,
>> +        nid: NumaNode,
>> +    ) -> Result<usize>;
>> +
>> +    /// Free a previously allocated from the `pool` object, =
represented by `handle`.
>> +    fn free(pool: <Self::Pool as ForeignOwnable>::Borrowed<'_>, =
handle: usize);
>> +
>> +    /// Make all the necessary preparations for the caller to be =
able to read from the object
>> +    /// represented by `handle` and return a valid pointer to the =
`handle` memory to be read.
>> +    fn read_begin(pool: <Self::Pool as =
ForeignOwnable>::Borrowed<'_>, handle: usize)
>> +        -> *mut c_void;
>=20
> Why does this return a raw pointer? I think this needs a proper type
> representation.

The zpool API wants a raw pointer here so I decided not to =
overcomplicate it. I thought of using NonNull<[u8]> but it doesn=E2=80=99t=
 seem to be a good fit. We=E2=80=99re basically returning a pointer to a =
place in memory which is guaranteed to be allocated and owned by us, but =
it is a raw pointer at the end of the day. What would you recommend here =
instead?

>=20
>> +
>> +    /// Finish reading from a previously allocated `handle`. =
`handle_mem` must be the pointer
>> +    /// previously returned by `read_begin`.
>> +    fn read_end(
>> +        pool: <Self::Pool as ForeignOwnable>::Borrowed<'_>,
>> +        handle: usize,
>> +        handle_mem: *mut c_void,
>> +    );
>=20
> Same here...
>=20
>> +
>> +    /// Write to the object represented by a previously allocated =
`handle`. `handle_mem` points
>> +    /// to the memory to copy data from, and `mem_len` defines the =
length of the data block to
>> +    /// be copied.
>> +    fn write(
>> +        pool: <Self::Pool as ForeignOwnable>::Borrowed<'_>,
>> +        handle: usize,
>> +        handle_mem: *mut c_void,
>=20
> ...and here.
>=20
>> +        mem_len: usize,
>> +    );
>> +
>> +    /// Get the number of pages used by the `pool`.
>> +    fn total_pages(pool: <Self::Pool as =
ForeignOwnable>::Borrowed<'_>) -> u64;
>> +}
>> +
>> +/// Zpool driver registration trait.
>> +pub trait Registration {
>=20
> I think you should use the kernel::driver::Registration instead, it's
> specifically for the purpose you defined this trait and ZpoolDriver =
for.
>=20
> As for the C callbacks, they should go into the Adapter type (which =
implements
> kernel::driver::RegistrationOps) directly, they don't need to be in a =
trait.
>=20
> This way a new Zpool Registration is created with:
>=20
> driver::Registration<zpool::Adapter>::new()
>=20
> This also allows you to take advantage of the module_driver!() macro =
to provide
> your own module_zpool_driver!() macro.

There was once a problem with that but I don=E2=80=99t remember what the =
problem was :) I=E2=80=99ll try that one more time, thanks.

>=20
>> +    /// Register a zpool driver.
>> +    fn register(&self, name: &'static CStr, module: &'static =
ThisModule) -> Result;
>> +
>> +    /// Pool creation callback.
>> +    extern "C" fn _create(name: *const c_uchar, gfp: u32) -> *mut =
c_void;
>> +
>> +    /// Pool destruction callback.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// The caller must ensure that `pool` is a valid pointer to =
`struct zpool`.
>> +    unsafe extern "C" fn _destroy(pool: *mut c_void);
>> +
>> +    /// Callback for object allocation in the pool.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// The caller must ensure that `pool` is a valid pointer to =
`struct zpool` and that `handle`
>> +    /// is a valid pointer to usize.
>> +    unsafe extern "C" fn _malloc(
>> +        pool: *mut c_void,
>> +        size: usize,
>> +        gfp: u32,
>> +        handle: *mut usize,
>> +        nid: c_int,
>> +    ) -> c_int;
>> +
>> +    /// Callback for object release.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// The caller must ensure that `pool` is a valid pointer to =
`struct zpool`.
>> +    unsafe extern "C" fn _free(pool: *mut c_void, handle: usize);
>> +
>> +    /// Callback to prepare the object for reading.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// The caller must ensure that `pool` is a valid pointer to =
`struct zpool`.
>> +    unsafe extern "C" fn _obj_read_begin(
>> +        pool: *mut c_void,
>> +        handle: usize,
>> +        local_copy: *mut c_void,
>> +    ) -> *mut c_void;
>> +
>> +    /// Callback to signal the end of reading from an object.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// The caller must ensure that `pool` is a valid pointer to =
`struct zpool`.
>> +    unsafe extern "C" fn _obj_read_end(pool: *mut c_void, handle: =
usize, handle_mem: *mut c_void);
>> +
>> +    /// Callback for writing to an object.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// The caller must ensure that `pool` is a valid pointer to =
`struct zpool`.
>> +    unsafe extern "C" fn _obj_write(
>> +        pool: *mut c_void,
>> +        handle: usize,
>> +        handle_mem: *mut c_void,
>> +        mem_len: usize,
>> +    );
>> +
>> +    /// Callback to return the number of pages in the pool.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// The caller must ensure that `pool` is a valid pointer to =
`struct zpool`.
>> +    unsafe extern "C" fn _total_pages(pool: *mut c_void) -> u64;
>> +}
>> +
>> +/// Zpool driver structure.
>> +pub struct ZpoolDriver<T: Zpool> {
>> +    inner: Opaque<bindings::zpool_driver>,
>=20
> I think this needs pin-init, another reason to use =
kernel::driver::Registration
> instead. :)
>=20
>> +
>> +    /// Zpool callback functions that a zpool driver must provide
>> +    pub callbacks: T,
>> +}
>> +
>> +impl<T: Zpool> Clone for ZpoolDriver<T> {
>> +    fn clone(&self) -> Self {
>> +        todo!()
>> +    }
>> +}
>=20
> Cloning the driver structure? Why? Please also consider that struct =
zpool_driver
> needs to be pinned.

Totally unnecessary, I agree. Will remove.

Thanks for the quick review!

~Vitaly


