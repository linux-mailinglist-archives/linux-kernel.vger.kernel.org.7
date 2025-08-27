Return-Path: <linux-kernel+bounces-788608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66E00B38736
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 18:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F27D43A6745
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 16:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C0730749E;
	Wed, 27 Aug 2025 15:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/nKrlgt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80062302CAC;
	Wed, 27 Aug 2025 15:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756310395; cv=none; b=GD49iLBAEABf7k5zbAI6DtWFvD+O5FWCOITD6pnJypqluLFBozhnc8AX39kQUcKITAQX+M7k2ovqjLgpNIPWEQPPADQ1PHRiG0y6ZAoYWgtN00upzAFsxgdGB2rxnJlKo9IkdXktTdbXv+AJ3NtqfW8QpvuDd3OCDHgIrjElmrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756310395; c=relaxed/simple;
	bh=J5+h5UrziIldL/6ShiAr1mBz3pMe+bEDgeuau7q6E0s=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=OSNTJWiP2IsMYLCpFrUmHLsd4U37hmWFe3Aa/qgF293GX5QCs/dXIbs0jmzg1jPDNd+KJ/7JixkD6rOhTlnM4+HhfWDStkejE30ZNm+j758dX/X4EC2VTMFZmqprOB9rQgHfLKL//GS/XOSpuBhtYC5jf5/khag/vCCmpL8wseM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V/nKrlgt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74664C4CEF0;
	Wed, 27 Aug 2025 15:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756310395;
	bh=J5+h5UrziIldL/6ShiAr1mBz3pMe+bEDgeuau7q6E0s=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=V/nKrlgtdnqj1+XgGOuPsNiHcsH6n/RYGVSCh0CsufP7uQ5rxG7hZ3xRlonzuzx8v
	 Jr/UF2Lckz6aO+anmWy5Mo6vEN5SyJf8xRF4FNLdFTKef/3ClapU8Q/n1DO/1E4jEC
	 rO44R+cuU2A9o2Co9egJnAjUjrUNA8unH1v/ccjhvzvBGV57YewafNjg2juzwxodGj
	 +HNMaUulAd6UPsOqvJh62js65XsTrLD/MQw4AFGdD6JjcpwCSF+eTmipNWaFyiUX6H
	 LbX9FDQlyKiXNraafiWq4IWQIqJItXP4viGa99FIeCd8nNV0O6YScYKVnm3OLgIDuf
	 xqvYjxL/ZyYAg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 27 Aug 2025 17:59:49 +0200
Message-Id: <DCDC2M7N28X2.3Q8XYNEDOGK6A@kernel.org>
To: "Vitaly Wool" <vitaly.wool@konsulko.se>
Cc: "rust-for-linux" <rust-for-linux@vger.kernel.org>, "LKML"
 <linux-kernel@vger.kernel.org>, "Uladzislau Rezki" <urezki@gmail.com>,
 "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Vlastimil Babka" <vbabka@suse.cz>, "Lorenzo Stoakes"
 <lorenzo.stoakes@oracle.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>,
 "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>, "Bjorn
 Roy Baron" <bjorn3_gh@protonmail.com>, "Andreas Hindborg"
 <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>, "Johannes
 Weiner" <hannes@cmpxchg.org>, "Yosry Ahmed" <yosry.ahmed@linux.dev>, "Nhat
 Pham" <nphamcs@gmail.com>, <linux-mm@kvack.org>
Subject: Re: [PATCH v4 2/2] rust: zpool: add abstraction for zpool drivers
From: "Benno Lossin" <lossin@kernel.org>
X-Mailer: aerc 0.20.1
References: <20250823130420.867133-1-vitaly.wool@konsulko.se>
 <20250823130522.867263-1-vitaly.wool@konsulko.se>
 <DCCIRTHGQFNX.1M8GXO4TYA7DF@kernel.org>
 <DFA3B588-3650-42DA-8875-7AB7D20A2BCA@konsulko.se>
In-Reply-To: <DFA3B588-3650-42DA-8875-7AB7D20A2BCA@konsulko.se>

On Wed Aug 27, 2025 at 4:24 PM CEST, Vitaly Wool wrote:
>
>
>> On Aug 26, 2025, at 7:02 PM, Benno Lossin <lossin@kernel.org> wrote:
>>=20
>> On Sat Aug 23, 2025 at 3:05 PM CEST, Vitaly Wool wrote:
>>> +pub trait ZpoolDriver {
>>> +    /// Opaque Rust representation of `struct zpool`.
>>> +    type Pool: ForeignOwnable;
>>=20
>> I think this is the same question that Danilo asked a few versions ago,
>> but why do we need this? Why can't we just use `Self` instead?
>
> It=E2=80=99s convenient to use it in the backend implementation, like in =
the toy example supplied in the documentation part:
>
> +/// struct MyZpool {
> +///     name: &'static CStr,
> +///     bytes_used: AtomicU64,
> +/// }
> =E2=80=A6
> +/// impl ZpoolDriver for MyZpoolDriver {
> +///     type Pool =3D KBox<MyZpool>;
>
> Does that make sense?

No, why can't it just be like this:

    struct MyZpool {
        name: &'static CStr,
        bytes_used: AtomicU64,
    }
   =20
    struct MyZpoolDriver;
   =20
    impl ZpoolDriver for MyZpoolDriver {
        type Error =3D Infallible;
   =20
        fn create(name: &'static CStr) -> impl PinInit<Self, Self::Error> {
            MyZpool { name, bytes_used: AtomicU64::new(0) }
        }
   =20
        fn malloc(&mut self, size: usize, gfp: Flags, _nid: NumaNode) -> Re=
sult<usize> {
            let mut pow: usize =3D 0;
            for n in 6..=3DPAGE_SHIFT {
                if size <=3D 1 << n {
                    pow =3D n;
                    break;
                }
            }
            match pow {
                0 =3D> Err(EINVAL),
                _ =3D> {
                    let vec =3D KVec::<u64>::with_capacity(1 << (pow - 3), =
gfp)?;
                    let (ptr, _len, _cap) =3D vec.into_raw_parts();
                    self.bytes_used.fetch_add(1 << pow, Ordering::Relaxed);
                    Ok(ptr as usize | (pow - 6))
                }
            }
        }
   =20
        unsafe fn free(&self, handle: usize) {
            let n =3D (handle & 0x3F) + 3;
            let uptr =3D handle & !0x3F;
   =20
            // SAFETY:
            // - uptr comes from handle which points to the KVec allocation=
 from `alloc`.
            // - size =3D=3D capacity and is coming from the first 6 bits o=
f handle.
            let vec =3D unsafe { KVec::<u64>::from_raw_parts(uptr as *mut u=
64, 1 << n, 1 << n) };
            drop(vec);
            self.bytes_used.fetch_sub(1 << (n + 3), Ordering::Relaxed);
        }
   =20
        unsafe fn read_begin(&self, handle: usize) -> NonNull<u8> {
            let uptr =3D handle & !0x3F;
            // SAFETY: uptr points to a memory area allocated by KVec
            unsafe { NonNull::new_unchecked(uptr as *mut u8) }
        }
   =20
        unsafe fn read_end(&self, _handle: usize, _handle_mem: NonNull<u8>)=
 {}
   =20
        unsafe fn write(&self, handle: usize, handle_mem: NonNull<u8>, mem_=
len: usize) {
            let uptr =3D handle & !0x3F;
            // SAFETY: handle_mem is a valid non-null pointer provided by z=
pool, uptr points to
            // a KVec allocated in `malloc` and is therefore also valid.
            unsafe {
                copy_nonoverlapping(handle_mem.as_ptr().cast(), uptr as *mu=
t c_void, mem_len)
            };
        }
   =20
        fn total_pages(&self) -> u64 {
            self.bytes_used.load(Ordering::Relaxed) >> PAGE_SHIFT
        }
    }

Also using a `usize` as a handle seems like a bad idea. Use a newtype
wrapper of usize instead. You can also not implement `Copy` and thus get
rid of one of the safety requirements of the `free` function. Not sure
if we can remove the other one as well using more type system magic, but
we could try.


>>> +
>>> +    /// Create a pool.
>>> +    fn create(name: &'static CStr, gfp: Flags) -> Result<Self::Pool>;
>>> +
>>> +    /// Destroy the pool.
>>> +    fn destroy(pool: Self::Pool);
>>=20
>> This should just be done via the normal `Drop` trait?
>
> Let me check if I=E2=80=99m getting you right here. I take what you are s=
uggesting is that we require that Pool implements Drop trait and then just =
do something like:
>
>     extern "C" fn destroy_(pool: *mut c_void) {
>         // SAFETY: The pointer originates from an `into_foreign` call.
>         unsafe { drop(T::Pool::from_foreign(pool)) }
>     }
>
> Is that understanding correct?

Yes, but you don't need to require the type to implement drop.

---
Cheers,
Benno

