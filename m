Return-Path: <linux-kernel+bounces-805948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB62B48FCF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 15:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3BBC16B4E8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 13:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A10C30BBAD;
	Mon,  8 Sep 2025 13:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f4uO2Niz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637D830BB98;
	Mon,  8 Sep 2025 13:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757338611; cv=none; b=dFj4A33AgOEAsxylDqHBFeoa9zUCvkAQy4g+kPYe5JCwAQngzVZyuo1vfuapZ7F/BsGAs5d2Yo3EYNvEkA50V6rlqqLC5g3+VE40XvMiJG/Z+n5YxL7aSQWUwtr69hwCLA2Y8wtAZ5PZcJiQ9W3zP502Mlcir5U7ZG5yOGB8oLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757338611; c=relaxed/simple;
	bh=5lU8gVbHblVclIeOcJyDUa45kKYlu4Sb2GLZZ/KkqcI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=AkqpvOB3KojI+o3cl4MwkuRa04Ij3zY56lVpYJ3JytGnX3+D7f1uoB7gtANeXfs5rZwDd3bM34mf1LedBxS946dLg0uBWfH37E9zoftPFqQ4IaCS7J4be6/+J5rB52eH9BOv8EKCzBflvVxI1TDmw+COSdfljATF3TmW5WtKtto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f4uO2Niz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B79AFC4CEF1;
	Mon,  8 Sep 2025 13:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757338610;
	bh=5lU8gVbHblVclIeOcJyDUa45kKYlu4Sb2GLZZ/KkqcI=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=f4uO2NizCkIE0zMyW/RTTYZqj/KbCVF9sOnfdiwlvHzuzMdMA7XfJmMQQo4Kk9RwD
	 fJeaYfvPjU+DjMuxoboc0G7Wm6puylzjSwmAr4C+B14Q5aqEtaf34S3RdBk8o8PQwx
	 ciHyja6HyQ0cHyawGYnARwTQX4OQ3E2PTO5PS1SgL7kvcirKtcTBm+d5/Q05rkbOcX
	 1jYH285lZ4wYcueLgSLvwItbbT5zo0a9UdKUkBN89USx01ITKL0Dn4Z0Gjo5ZuZ1Fu
	 i+PJoO2tVSfGb2z9sxRchsFG0OQ1HQkXUHy00l5LpsHk99oNuqWD3Vi6K1U9sjtgIP
	 saYJ/cYjolJzg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 08 Sep 2025 15:36:46 +0200
Message-Id: <DCNGJMN80Z34.1O45B1LM9PB2S@kernel.org>
Cc: "Matthew Maurer" <mmaurer@google.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Sami Tolvanen" <samitolvanen@google.com>, "Timur
 Tabi" <ttabi@nvidia.com>, "Benno Lossin" <lossin@kernel.org>, "Dirk Beheme"
 <dirk.behme@de.bosch.com>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v11 2/7] rust: debugfs: Add support for read-only files
References: <20250904-debugfs-rust-v11-0-7d12a165685a@google.com>
 <20250904-debugfs-rust-v11-2-7d12a165685a@google.com>
 <2025090807-bootleg-trophy-a031@gregkh>
 <DCND3LBZ0Y2J.377ZTOSOUXMOB@kernel.org>
 <2025090849-tweak-conductor-f642@gregkh>
 <DCNG8UF8XFT2.12S9I7MBNV5PX@kernel.org>
 <2025090817-attendant-ungodly-78f6@gregkh>
In-Reply-To: <2025090817-attendant-ungodly-78f6@gregkh>

On Mon Sep 8, 2025 at 3:30 PM CEST, Greg Kroah-Hartman wrote:
> On Mon, Sep 08, 2025 at 03:22:41PM +0200, Danilo Krummrich wrote:
>> On Mon Sep 8, 2025 at 2:48 PM CEST, Greg Kroah-Hartman wrote:
>> > On Mon, Sep 08, 2025 at 12:54:46PM +0200, Danilo Krummrich wrote:
>> >> diff --git a/samples/rust/rust_debugfs.rs b/samples/rust/rust_debugfs=
.rs
>> >> index b26eea3ee723..475502f30b1a 100644
>> >> --- a/samples/rust/rust_debugfs.rs
>> >> +++ b/samples/rust/rust_debugfs.rs
>> >> @@ -59,6 +59,8 @@ struct RustDebugFs {
>> >>      #[pin]
>> >>      _compatible: File<CString>,
>> >>      #[pin]
>> >> +    _test: File<&'static CStr>,
>> >> +    #[pin]
>> >>      counter: File<AtomicUsize>,
>> >>      #[pin]
>> >>      inner: File<Mutex<Inner>>,
>> >> @@ -140,6 +142,7 @@ fn new(pdev: &platform::Device<Core>) -> impl Pin=
Init<Self, Error> + '_ {
>> >>                          .property_read::<CString>(c_str!("compatible=
"))
>> >>                          .required_by(dev)?,
>> >>                  ),
>> >> +                _test <- debugfs.read_only_file(c_str!("test"), c_st=
r!("some_value")),
>> >
>> > Cool, but again, we do not want to ever be storing individual debugfs
>> > files.  Well, we can, but for 90% of the cases, we do not, we only wan=
t
>> > to remove the whole directory when that goes out of scope, which will
>> > clean up the files then.
>>=20
>> This API does not work in the way that you have a struct storing the dat=
a you
>> want to expose *and* another one for the files with the data attached.
>>=20
>> The File type contains the actual data. For instance, if you have a stru=
ct Foo,
>> where you want to expose the members through debugfs you would *not* do:
>>=20
>> 	struct Foo {
>> 	   a: u32,
>> 	   b: u32,
>> 	}
>>=20
>> 	struct FooFiles {
>> 	   a: File<&u32>,
>> 	   b: File<&u32>
>> 	}
>>=20
>> and then create an instance of Foo *and* another instance of FooFiles to=
 export
>> them via debugfs.
>
> Ah, that's exactly what I was trying to do.

But that's bad, then we're back at the lifetime problem from the beginning,
because the File<&Foo> then somehow needs to ensure that the instance Foo
remains alive as long as File<&Foo> or the backing directory exists.

So, you eventually end of with Foo needing to be reference counted with its=
 own
memory allocation, which horribly messes with your lifetimes in the driver.

You don't want a a field to be reference counted just because it's exposed =
via
debugfs.

>> Instead you would change your struct Foo to just be:
>>=20
>> 	struct Foo {
>> 	   a: File<u32>,
>> 	   b: File<u32>,
>> 	}
>>=20
>> If you now create an instance of Foo (let's call it `foo`), then foo.a o=
r foo.b
>> dereferences to the inner type, i.e. the u32. Or in other words `foo` st=
ill
>> behaves as if `a` and `b` would be u32 values. For instance:
>>=20
>>    if foo.a =3D=3D 42 {
>>       pr_info!("Foo::b =3D {}\n", foo.b);
>>    }
>
> Oh that's not going to work well at all :(
>
> Think about something "simple" like a pci config descriptor.  You have a
> structure, with fields, already sitting there.  You want to expose those
> fields in debugfs.

This is more of a special case that is addressed by the Scope API in patch =
6 and
patch 7, so we should be good.

>> The fact that the backing files of `a` and `b` are removed from debugfs =
when Foo
>> is dropped is necessary since otherwise we create a UAF.
>
> That's fine, but:
>
>> Think of File<T> as a containers like you think of KBox<T>.
>
> Ok, but again, you are now forcing all users to think of debugfs as the
> main "interface" to those variables, which is not true (nor should it
> be.)
>
>> KBox<T> behaves exactly like T, but silently manages the backing kmalloc=
()
>> allocation that T lives in.
>>=20
>> With File<T> it's exactly the same, it behaves exactly like the T that l=
ives
>> within File<T>, but silently manages the debugfs file the T is exposed b=
y.
>
> And what happens if debugfs is not enabled?  What about if creating the
> file fails?  The variable still needs to be present and active and
> working.

This is the case, the variable will still be present and active in any case=
.

