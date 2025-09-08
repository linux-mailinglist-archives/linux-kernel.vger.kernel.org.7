Return-Path: <linux-kernel+bounces-805917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FC7B48F4D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 15:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C70463A5F95
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 13:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43C0663B9;
	Mon,  8 Sep 2025 13:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fUCz31aE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2594A06;
	Mon,  8 Sep 2025 13:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757337766; cv=none; b=R5gD2md2ZrPdo4rq/VZ6B37qVwFzgwq8wSpOGjT+0yLIUNPBbvYV8jLmQEX4MS/WoHvwlsDGOpdTqCGko741sC+mnAcFrFySjvGT3x9Xc3mPzx2c0AdGDpofLCCHZeftTOirmi5jW+onol1O1D4ETVBthn9L2YGOjFUr/Hvww+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757337766; c=relaxed/simple;
	bh=oGMXLolCMDVFp1mzpmZLsQtGcdLcEDD0RTT5IraeD98=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=QcR5hWzASmJg3LNOxLZinFQmH4TDMxvbWAJME3v5XoVmvwa7MxL/uZ6rDNXf1PpSo5rolVv55Yx9lfexdMucJdyy1c3SaM+E/BlaP//q3xGyvnRpQePkyLM1ScODeuVxrSWmrtjXhw8eJx6iVU0I/HlxWtC2F9TVnKEcOxJB8xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fUCz31aE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04276C4CEF1;
	Mon,  8 Sep 2025 13:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757337766;
	bh=oGMXLolCMDVFp1mzpmZLsQtGcdLcEDD0RTT5IraeD98=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=fUCz31aEhKMazmVeuIhP3Vg8oSJMlOUcTQUhtb9AbjKSIakE1rzGRCZubx+EkWbIv
	 eeOeDG92oNZjKpQ+L5W3AoUljesDEDVeSsITBuhSjiNJ1xvMVeq2Wg8JQE9vtlSGrm
	 QQTyQzkbR6eWVYhPcQKA5//eHAzfAQMBVk9v+448yPedeBPucdXGr7lB9p3fZx+Lqv
	 dE+IoUPSlcPO1vrl80Ci4kJJc2gqYlHjqpY9IahU0vX1Q5I2hwmi/pe+31hgi9vtFh
	 CPqC5LojP99iNVZPBTrL3Y7b6X1cZ1tbMf5qjePmWg1jRsE0qyLNPsAUu/x1Ji8x5L
	 +VU/AuMSW55+g==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 08 Sep 2025 15:22:41 +0200
Message-Id: <DCNG8UF8XFT2.12S9I7MBNV5PX@kernel.org>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v11 2/7] rust: debugfs: Add support for read-only files
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
References: <20250904-debugfs-rust-v11-0-7d12a165685a@google.com>
 <20250904-debugfs-rust-v11-2-7d12a165685a@google.com>
 <2025090807-bootleg-trophy-a031@gregkh>
 <DCND3LBZ0Y2J.377ZTOSOUXMOB@kernel.org>
 <2025090849-tweak-conductor-f642@gregkh>
In-Reply-To: <2025090849-tweak-conductor-f642@gregkh>

On Mon Sep 8, 2025 at 2:48 PM CEST, Greg Kroah-Hartman wrote:
> On Mon, Sep 08, 2025 at 12:54:46PM +0200, Danilo Krummrich wrote:
>> diff --git a/samples/rust/rust_debugfs.rs b/samples/rust/rust_debugfs.rs
>> index b26eea3ee723..475502f30b1a 100644
>> --- a/samples/rust/rust_debugfs.rs
>> +++ b/samples/rust/rust_debugfs.rs
>> @@ -59,6 +59,8 @@ struct RustDebugFs {
>>      #[pin]
>>      _compatible: File<CString>,
>>      #[pin]
>> +    _test: File<&'static CStr>,
>> +    #[pin]
>>      counter: File<AtomicUsize>,
>>      #[pin]
>>      inner: File<Mutex<Inner>>,
>> @@ -140,6 +142,7 @@ fn new(pdev: &platform::Device<Core>) -> impl PinIni=
t<Self, Error> + '_ {
>>                          .property_read::<CString>(c_str!("compatible"))
>>                          .required_by(dev)?,
>>                  ),
>> +                _test <- debugfs.read_only_file(c_str!("test"), c_str!(=
"some_value")),
>
> Cool, but again, we do not want to ever be storing individual debugfs
> files.  Well, we can, but for 90% of the cases, we do not, we only want
> to remove the whole directory when that goes out of scope, which will
> clean up the files then.

This API does not work in the way that you have a struct storing the data y=
ou
want to expose *and* another one for the files with the data attached.

The File type contains the actual data. For instance, if you have a struct =
Foo,
where you want to expose the members through debugfs you would *not* do:

	struct Foo {
	   a: u32,
	   b: u32,
	}

	struct FooFiles {
	   a: File<&u32>,
	   b: File<&u32>
	}

and then create an instance of Foo *and* another instance of FooFiles to ex=
port
them via debugfs.

Instead you would change your struct Foo to just be:

	struct Foo {
	   a: File<u32>,
	   b: File<u32>,
	}

If you now create an instance of Foo (let's call it `foo`), then foo.a or f=
oo.b
dereferences to the inner type, i.e. the u32. Or in other words `foo` still
behaves as if `a` and `b` would be u32 values. For instance:

   if foo.a =3D=3D 42 {
      pr_info!("Foo::b =3D {}\n", foo.b);
   }

The fact that the backing files of `a` and `b` are removed from debugfs whe=
n Foo
is dropped is necessary since otherwise we create a UAF.

Think of File<T> as a containers like you think of KBox<T>.

KBox<T> behaves exactly like T, but silently manages the backing kmalloc()
allocation that T lives in.

With File<T> it's exactly the same, it behaves exactly like the T that live=
s
within File<T>, but silently manages the debugfs file the T is exposed by.

