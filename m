Return-Path: <linux-kernel+bounces-804104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D6DB46A06
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 09:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE6BC1C86319
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 07:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA0827A92E;
	Sat,  6 Sep 2025 07:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JDPgr7UR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DAF1C84A1;
	Sat,  6 Sep 2025 07:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757145392; cv=none; b=NxG6yvbwd1L9/uFoJGlxz/DghvZJGFVqe3ntMmwk5+/XrBVeeyUitp98qOvtzVzIRevRAmqg1kGgW7a2mkD2aGpzoIBEFWkVnbL5s3KIAGAUPzpDg2TMR9dM9F35xVD9gSqSP+yXOou3dFBVkGFtBg72IHHQhgI2NJu0gofQ3t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757145392; c=relaxed/simple;
	bh=6MpzkwaTQMjmEYFnZViHjiIwAE3okFT2YcFGwEWrMu0=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=fm/Mmk5kSUmRffXMOyrn7kvokR2O+bvyng9UoIuYQUIPf9LzsiG17ePdewH0C/SYgA63QX8UI6eKosROa6mFLbaaSymnswEgPOoAFx35G8ITPp+uKADtgQCk1JAawjUlbeqAnVw3/u9ofK9y41Z+JbRziYm0zCKgHXsRvfjAlDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JDPgr7UR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1806C4CEE7;
	Sat,  6 Sep 2025 07:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757145391;
	bh=6MpzkwaTQMjmEYFnZViHjiIwAE3okFT2YcFGwEWrMu0=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=JDPgr7URW8s7vw/k79cIlH8pPnGb6W1TRtu+NcgwNT+haAornpO/O5/b02eZY3tOw
	 vvzGi9grirM0MP4Oky1dwoVR4tRHa9eQDEUCTyinM4bPPHCwxcB+oGtX8brxFP4K0N
	 66cSVv1nOkSKtaW9mhxLnbkcWLyAVz0nkRXTmMY9+kaKmBxQjiRZOFdY7H5VNBURWz
	 xgD39ulj6KwxWdYWKrfNm63CPXIjTJLFNOwmKgaLwFreHeLB1wbzERLMRGH6HORPgT
	 MDZf/Yd+PsjNIB5vOkiWjf8fhc5o9GtXk5RcK9sxaHH+HPpsThbDaY6v41hpYnKIrl
	 6pWiNQqdJv05A==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 06 Sep 2025 09:56:25 +0200
Message-Id: <DCLK1YG1L5TZ.1VMGX131LII9V@kernel.org>
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
 <DCDC2M7N28X2.3Q8XYNEDOGK6A@kernel.org>
 <9c63dda1-0a4b-4131-a5e7-12ad2e88c6d6@konsulko.se>
In-Reply-To: <9c63dda1-0a4b-4131-a5e7-12ad2e88c6d6@konsulko.se>

On Thu Aug 28, 2025 at 9:22 AM CEST, Vitaly Wool wrote:
>
>
> On 8/27/25 17:59, Benno Lossin wrote:
>> On Wed Aug 27, 2025 at 4:24 PM CEST, Vitaly Wool wrote:
>>>
>>>
>>>> On Aug 26, 2025, at 7:02 PM, Benno Lossin <lossin@kernel.org> wrote:
>>>>
>>>> On Sat Aug 23, 2025 at 3:05 PM CEST, Vitaly Wool wrote:
>>>>> +pub trait ZpoolDriver {
>>>>> +    /// Opaque Rust representation of `struct zpool`.
>>>>> +    type Pool: ForeignOwnable;
>>>>
>>>> I think this is the same question that Danilo asked a few versions ago=
,
>>>> but why do we need this? Why can't we just use `Self` instead?
>>>
>>> It=E2=80=99s convenient to use it in the backend implementation, like i=
n the toy example supplied in the documentation part:
>>>
>>> +/// struct MyZpool {
>>> +///     name: &'static CStr,
>>> +///     bytes_used: AtomicU64,
>>> +/// }
>>> =E2=80=A6
>>> +/// impl ZpoolDriver for MyZpoolDriver {
>>> +///     type Pool =3D KBox<MyZpool>;
>>>
>>> Does that make sense?
>>=20
>> No, why can't it just be like this:
>>=20
>>      struct MyZpool {
>>          name: &'static CStr,
>>          bytes_used: AtomicU64,
>>      }
>>     =20
>>      struct MyZpoolDriver;
>>     =20
>>      impl ZpoolDriver for MyZpoolDriver {
>>          type Error =3D Infallible;
>>     =20
>>          fn create(name: &'static CStr) -> impl PinInit<Self, Self::Erro=
r> {
>>              MyZpool { name, bytes_used: AtomicU64::new(0) }
>>          }
>>     =20
>>          fn malloc(&mut self, size: usize, gfp: Flags, _nid: NumaNode) -=
> Result<usize> {
>>              let mut pow: usize =3D 0;
>>              for n in 6..=3DPAGE_SHIFT {
>>                  if size <=3D 1 << n {
>>                      pow =3D n;
>>                      break;
>>                  }
>>              }
>>              match pow {
>>                  0 =3D> Err(EINVAL),
>>                  _ =3D> {
>>                      let vec =3D KVec::<u64>::with_capacity(1 << (pow - =
3), gfp)?;
>>                      let (ptr, _len, _cap) =3D vec.into_raw_parts();
>>                      self.bytes_used.fetch_add(1 << pow, Ordering::Relax=
ed);
>>                      Ok(ptr as usize | (pow - 6))
>>                  }
>>              }
>>          }
>>     =20
>>          unsafe fn free(&self, handle: usize) {
>>              let n =3D (handle & 0x3F) + 3;
>>              let uptr =3D handle & !0x3F;
>>     =20
>>              // SAFETY:
>>              // - uptr comes from handle which points to the KVec alloca=
tion from `alloc`.
>>              // - size =3D=3D capacity and is coming from the first 6 bi=
ts of handle.
>>              let vec =3D unsafe { KVec::<u64>::from_raw_parts(uptr as *m=
ut u64, 1 << n, 1 << n) };
>>              drop(vec);
>>              self.bytes_used.fetch_sub(1 << (n + 3), Ordering::Relaxed);
>>          }
>>     =20
>>          unsafe fn read_begin(&self, handle: usize) -> NonNull<u8> {
>>              let uptr =3D handle & !0x3F;
>>              // SAFETY: uptr points to a memory area allocated by KVec
>>              unsafe { NonNull::new_unchecked(uptr as *mut u8) }
>>          }
>>     =20
>>          unsafe fn read_end(&self, _handle: usize, _handle_mem: NonNull<=
u8>) {}
>>     =20
>>          unsafe fn write(&self, handle: usize, handle_mem: NonNull<u8>, =
mem_len: usize) {
>>              let uptr =3D handle & !0x3F;
>>              // SAFETY: handle_mem is a valid non-null pointer provided =
by zpool, uptr points to
>>              // a KVec allocated in `malloc` and is therefore also valid=
.
>>              unsafe {
>>                  copy_nonoverlapping(handle_mem.as_ptr().cast(), uptr as=
 *mut c_void, mem_len)
>>              };
>>          }
>>     =20
>>          fn total_pages(&self) -> u64 {
>>              self.bytes_used.load(Ordering::Relaxed) >> PAGE_SHIFT
>>          }
>>      }
>
> It can indeed but then the ZpoolDriver trait will have to be extended=20
> with functions like into_raw() and from_raw(), because zpool expects=20
> *mut c_void, so on the Adapter side it will look like
>
>      extern "C" fn create_(name: *const c_uchar, gfp: u32) -> *mut c_void=
 {
>          // SAFETY: the memory pointed to by name is guaranteed by zpool=
=20
> to be a valid string
>          let pool =3D unsafe { T::create(CStr::from_char_ptr(name),=20
> Flags::from_raw(gfp)) };
>          match pool {
>              Err(_) =3D> null_mut(),
>              Ok(p) =3D> T::into_raw(p).cast(),
>          }
>      }
>
> The question is, why does this make it better?

No, thanks for sharing that function. Then the question becomes, do you
really need `ForeignOwnable`? Or is `KBox` enough? Do you really want
people to use `Arc<MyZPool>`? Because `BorrowedMut` of `Arc` is the same
as it's `Borrowed` variant (it's read-only after all).

If you can get away with just `Box` (you might want people to choose
their allocator, which is fine IMO), then I'd do so.

---
Cheers,
Benno

