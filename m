Return-Path: <linux-kernel+bounces-601310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BFF3A86C49
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Apr 2025 11:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B357444CDE
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Apr 2025 09:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE48919D891;
	Sat, 12 Apr 2025 09:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="iZ7cdHSu"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B8F182B7
	for <linux-kernel@vger.kernel.org>; Sat, 12 Apr 2025 09:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744451011; cv=none; b=jtJ6HfOJUaAcU/AMehFcvaN21Y+5dIbYoYul6CSawJtuUN6sAiz1mf354SltbhhR6Ycaq4lv//lHSeSrx8efTXczjT1YyfVbNmRYGyaLf2ducn99/mUEskUJHLNM5MAkfi0n2bQYpTb3Ty+9AfFBLOqwz/B2N8R9LG0sXwZsK1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744451011; c=relaxed/simple;
	bh=x1v2l7oqqlAfI/GC68sa1HqdSAgHXzmtd1fwhT2iFwA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B0KniRJwgyCO6+9PcltBMFo677W2XKh6M0kk92gaI0x1D6vYiC4O6oBKBAn2K6u/BeRBx6VEVU0S8leywIwExEBSj0E2psQmxnXRX03MUs3DwLjeCZNj0/NG17TkSiZzOYdzpHbiXdNlQ+UIo/3z2HE4FDIf2N9JSjemD1JQhaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=iZ7cdHSu; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1744451006; x=1744710206;
	bh=ucmrYC3ufp1mZH2DRfj1Rg3pyA//LyzJkVCSqxcMRTQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=iZ7cdHSuO4wLH1pw26372XmZR1wMfS/7Y4bBgSM1030NI8KsJrtmHvwQrNsTtc4ic
	 fziGRk7R+9AXbkcWN+UZ7fm73UqfvsNkMwHz2MCp7bX66YQIWUKCSaWKVZr8YMyu/L
	 ge7+9Xn57ATZa4BZl5Y4auEd5iNxBkYPKDnZqRqQO7AuKKOv1JVHXmWBESfH9dP/BN
	 OSV4/IocVpfNdFjpeyAXxd4BmcJyVDG7Tv+ITqjkOoOEYePFJajbkgd6tlGqad+6SL
	 YZhiK5c8IUOh8ziienKffGQuSRsbBD3UCaiAVrTOxwCzCw7Wu7yoCptR28O0z50FTq
	 JDfX7rNBxyhvw==
Date: Sat, 12 Apr 2025 09:43:21 +0000
To: Tamir Duberstein <tamird@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: check type of `$ptr` in `container_of!`
Message-ID: <D94K9PBZTT2G.289MISCO3AL2U@proton.me>
In-Reply-To: <CAJ-ks9kBpj1-_bwN_ncMc62indvviJv6zbpdJgd8JOf5o05a-g@mail.gmail.com>
References: <20250411-b4-container-of-type-check-v1-1-08262ef67c95@gmail.com> <CAH5fLgioEPTrh0vYt5zdmj8POCMyDdV+Bd=j_M3PZ-EdKLZtTQ@mail.gmail.com> <CAJ-ks9ngPKeoR86WX=qcuS8LtMafZuRXQt7+J9YRv+NVoSgr-A@mail.gmail.com> <D944ADIR8SAC.1CRNV5FJ99TFD@proton.me> <CAJ-ks9kBpj1-_bwN_ncMc62indvviJv6zbpdJgd8JOf5o05a-g@mail.gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 8c06f7cb04c2a98979bebb28fa7e77c041e52788
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri Apr 11, 2025 at 11:39 PM CEST, Tamir Duberstein wrote:
> On Fri, Apr 11, 2025 at 5:12=E2=80=AFPM Benno Lossin <benno.lossin@proton=
.me> wrote:
>>
>> On Fri Apr 11, 2025 at 5:41 PM CEST, Tamir Duberstein wrote:
>> > On Fri, Apr 11, 2025 at 10:36=E2=80=AFAM Alice Ryhl <aliceryhl@google.=
com> wrote:
>> >>
>> >> On Fri, Apr 11, 2025 at 4:31=E2=80=AFPM Tamir Duberstein <tamird@gmai=
l.com> wrote:
>> >> >
>> >> > Add a compile-time check that `*$ptr` is of the type of `$type->$($=
f)*`.
>> >> >
>> >> > Suggested-by: Alice Ryhl <aliceryhl@google.com>
>> >> > Link: https://lore.kernel.org/all/CAH5fLgh6gmqGBhPMi2SKn7mCmMWfOSiS=
0WP5wBuGPYh9ZTAiww@mail.gmail.com/
>> >> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
>> >> > ---
>> >> >  rust/kernel/lib.rs | 5 ++++-
>> >> >  1 file changed, 4 insertions(+), 1 deletion(-)
>> >> >
>> >> > diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
>> >> > index 1df11156302a..da9e36aa7967 100644
>> >> > --- a/rust/kernel/lib.rs
>> >> > +++ b/rust/kernel/lib.rs
>> >> > @@ -200,7 +200,10 @@ fn panic(info: &core::panic::PanicInfo<'_>) ->=
 ! {
>> >> >  macro_rules! container_of {
>> >> >      ($ptr:expr, $type:ty, $($f:tt)*) =3D> {{
>> >> >          let offset: usize =3D ::core::mem::offset_of!($type, $($f)=
*);
>> >> > -        $ptr.byte_sub(offset).cast::<$type>()
>> >> > +        let container =3D $ptr.byte_sub(offset).cast::<$type>();
>> >> > +        fn assert_same_type<T>(_: T, _: T) {}
>> >> > +        assert_same_type($ptr, ::core::mem::addr_of!((*container).=
$($f)*).cast_mut());
>> >
>> > I noticed I accidentally sent `::core::mem::addr_of` instead of
>> > `::core::ptr::addr_of`; will fix once we agree below.
>> >
>> >> Perhaps it would be better to wrap the type check in an `if false` to
>> >> avoid evaluating the expressions at runtime?
>> >
>> > It's optimized out at O1: https://godbolt.org/z/44Go5xnWr. Is it worth=
 it?
>>
>> Wrapping in `if false` definitely doesn't hurt, since we get better
>> debug perf.
>
> How's this?
>
> if false { [$ptr, ::core::ptr::addr_of!((*container).$($f)*).cast_mut()];=
 }

How does the error look like if you use the wrong input pointer? I'd
prefer we use the variant that creates the best error report for the
user. I could imagine that the function gives a better error, but I
haven't checked.

---
Cheers,
Benno


