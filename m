Return-Path: <linux-kernel+bounces-782748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAF1B324B9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 23:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A04A0624C0F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 21:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BAE429AAE3;
	Fri, 22 Aug 2025 21:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hO65IyFw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC581A9FA7;
	Fri, 22 Aug 2025 21:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755899390; cv=none; b=jnFFUDlyslcOwGGpBpfXol+CJ7dKRqmx6Dm1BlsGblGv+nhB/1vT90+bYkZa2ghHedqGA8CWEWXDYMS4OdgGegtRCObdw+Yr0U9QOSjZ//hOLGcCn6i7KYP+RgLWRV/v4g5EfFkJHLWaSi25R6pgG+FQSLeDMSIZ0e/SflEswNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755899390; c=relaxed/simple;
	bh=wXrPR1g3JpzZb33O4hssEbGQZzGeBolfT7rXw5mzIzE=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=RkEKFdWEH2KPURfoC1x7lk9cSB9pFeFeu/ofBKSaZyiPk/LZ36VvSwhvL8mSDi/ScsryeC4bDYZMc5U6v5tUU/ZEVboaGpobEtw9gTNbNooi9DUSXMlnkp8vU8/yZTStzVd77RvIxiwgHm4q08nM6ahLH3TtyWO3CcW2GXZQAQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hO65IyFw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E199FC4CEED;
	Fri, 22 Aug 2025 21:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755899390;
	bh=wXrPR1g3JpzZb33O4hssEbGQZzGeBolfT7rXw5mzIzE=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=hO65IyFwXuDZm/j1t+2HMXodd8geddF/a5rOL79Hyx9QgKrmUzsYjy8eXDjz3bhZm
	 BXUW9EvwA3AE9inv5x2cBSgCEdXw1Qikj/DCqrnSXqaPj6bndG8GdhOOOhgUlSaWUm
	 +bMvTZzULtWXqBFHDsdqwtz5tMQQMfvAx8mGZgrNY5tH2yOj44VY89IxZ+iofv29FA
	 sD/93HtObxM/3ltOyXIeoEbPtRXEG2pTp1+WY0VGnrtUqLmNVzdqd/j1XDTsdKsUFB
	 C5WBeVGq/hy4r2SYe5bqet6os814yqiR1kA0YbHnqYYwXyQeJy+DsRJmgq3C99cTjt
	 fd1MK3ZNpVtlg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 22 Aug 2025 23:49:45 +0200
Message-Id: <DC9ADTLUFTUC.8OVFMY20FXLF@kernel.org>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 2/5] rust: maple_tree: add MapleTree
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Andrew Ballance" <andrewjballance@gmail.com>, "Boqun
 Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, <linux-kernel@vger.kernel.org>,
 <maple-tree@lists.infradead.org>, <rust-for-linux@vger.kernel.org>,
 <linux-mm@kvack.org>
References: <20250819-maple-tree-v2-0-229b48657bab@google.com>
 <20250819-maple-tree-v2-2-229b48657bab@google.com>
 <DC6DC244ZIUL.304JSP7JFDE9Z@kernel.org> <aKRx8xsY8CpzbeEm@google.com>
 <DC6F7BN2L19O.1APQU9KWZV7H5@kernel.org>
 <CANiq72=xdryEKzo73-1vaBqGNNme2kRU0atP5PYOnOOXjNxZZg@mail.gmail.com>
 <DC8WOHIEAHQD.21VWTH8VI8QG5@kernel.org>
 <CANiq72=ZZ7+tMi_XsRKunGAqm_v+kehFqzpEMMqm2qcTvzA9Mw@mail.gmail.com>
 <DC8XIFWZN1SE.ZZP90D2N843X@kernel.org>
 <CANiq72nJiJ4K6jy17x-YRYnJpjqTnohYWvoFrLkYQp0X4tLL=w@mail.gmail.com>
In-Reply-To: <CANiq72nJiJ4K6jy17x-YRYnJpjqTnohYWvoFrLkYQp0X4tLL=w@mail.gmail.com>

On Fri Aug 22, 2025 at 11:22 PM CEST, Miguel Ojeda wrote:
> As for being clearer, what we want to assert is that the cause is a
> given one, so `assert_eq!` seems like a natural choice (and it isn't a
> case like `is_none()` where there is an advantage). Plus it means it
> is able to show both sides if it fails. So it is not a clear win-win
> in my eyes.

As for

	assert_eq!(foo().unwrap_err().kind(), ErrorKind::NotFound);

vs.

	assert!(foo().is_err_and(|e| x.kind() =3D=3D ErrorKind::NotFound));

the only thing I can think of is that the former fails differently for when
foo() is Ok() vs. the error kind does not match. I assume that's what you m=
ean?

If so, I agree it's indeed a downside.

>> But especially people new to the kernel starting to write Rust drivers m=
ay not
>> even be aware of this fact. If they see some unwrap_err() calls in examp=
les they
>> might not even thing about it a lot before starting to use them, e.g. be=
cause
>> they're used to it from userspace projects anyways.
>
> We still have the issue that they will see the `assert!` anyway and
> thus can easily think panics are OK. I understand what you are saying:
> you want to minimize those cases anyway.

Yeah, exactly. Another reason I'm less concernt about the assert!() is that=
 I
think it's generally more more associated with test cases than unwrap(). Bu=
t
this one might also be just my perception. :)

>> I think we should do this; I really think otherwise we gonna see a lot o=
f them
>> once we get more drivers. It's just too convinient. :)
>
> A potential middle ground is to apply the lint in normal code, but not
> in examples.
>
> Or, even better, we can actually only allow it within `assert!`s,
> since it is a custom macro I wrote for KUnit and not the real one,
> i.e. enforcing what I suggested above [1].

I think this would be a great solution; thanks for pointing this out.

> Another one is a lint that just affects `unwrap()` and not
> `unwrap_err()` -- I think the Clippy one doesn't allow it now, but we
> could request it. It could be combined with the above so that only
> `unwrap_err()` is allowed within `assert!`s.
>
> We could also go the C way, warning in `checkpatch.pl` about it like
> it does `BUG_ON`.

I think your suggestion above is perfect, whereas I think this one is likel=
y to
still slip through.

> What I like about the Clippy approach is that it can be locally `expect`e=
d.

Agreed!

