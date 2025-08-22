Return-Path: <linux-kernel+bounces-781775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B650DB31696
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49FE25A19EC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7E22FA0D4;
	Fri, 22 Aug 2025 11:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F1W11D/J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEAF21B8E7;
	Fri, 22 Aug 2025 11:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755863078; cv=none; b=C9dygw10pVI40VKwsJp56ppYbUKINqIxhrueRx8zFy2oZpCu/g5fAXl50jBspe3ThLSYgawp7GqUJxv7VSqycan3IrPLGnosOsIbl5KGWnNqDMvwHlegZ0grcak3P/jUR7verc403/Sc57jTyvZ/x1pbdoD8U68T6bdZSxU/vG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755863078; c=relaxed/simple;
	bh=Ehes+TywfQ8xDxHjBhYwV5+QsAnE1nz2pIE2gJ1LGto=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=Us4+CZ65LjTuwFojLjJSTzCOR5Blp/7R1MRzNTa2pN51bfNgt2ZVGH9qPDvPNnQknxMQ9DplBFWL8N8yBLxN3l+xAZ/LBCOqWChUcsiV0nmJc/j5bJk7FwccFhoDR2sxbU4VDlbRcSNcP32jzyP6xyrH95+8G0i2iPJ0tMaiwxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F1W11D/J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72C73C4CEED;
	Fri, 22 Aug 2025 11:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755863077;
	bh=Ehes+TywfQ8xDxHjBhYwV5+QsAnE1nz2pIE2gJ1LGto=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=F1W11D/JM+EVtZrd92D8APNnrRop1qUdCnOCAAI9gsr6pFiXkKFWqTBytD/QTtUyd
	 iBoNrJwEsu1fXNzWoKiBt1n1lVURchROVLD1cmjvzUhwTGQo40OjJtpfs8Fn81qRCX
	 YrxCtcPh8l7cCgzF11ttjKLP7uQtXBH7CbMUhV832gEqDJekFDAwxYLfCLviOwEN08
	 jvy73WQG+l5k04vvDHgGb9Qsslni5m/A7j39xE2gAnfBaez53gEEFFLYyvI/jSnG20
	 aj5o8tCaNHsYYggUwZC9CDcmvPC5wkstUB2bh9p5HFiKLhkC3J7R4ouC1v5AaScFSH
	 9OPNIZrlm0weg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 22 Aug 2025 13:44:32 +0200
Message-Id: <DC8XIFWZN1SE.ZZP90D2N843X@kernel.org>
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
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 2/5] rust: maple_tree: add MapleTree
References: <20250819-maple-tree-v2-0-229b48657bab@google.com>
 <20250819-maple-tree-v2-2-229b48657bab@google.com>
 <DC6DC244ZIUL.304JSP7JFDE9Z@kernel.org> <aKRx8xsY8CpzbeEm@google.com>
 <DC6F7BN2L19O.1APQU9KWZV7H5@kernel.org>
 <CANiq72=xdryEKzo73-1vaBqGNNme2kRU0atP5PYOnOOXjNxZZg@mail.gmail.com>
 <DC8WOHIEAHQD.21VWTH8VI8QG5@kernel.org>
 <CANiq72=ZZ7+tMi_XsRKunGAqm_v+kehFqzpEMMqm2qcTvzA9Mw@mail.gmail.com>
In-Reply-To: <CANiq72=ZZ7+tMi_XsRKunGAqm_v+kehFqzpEMMqm2qcTvzA9Mw@mail.gmail.com>

On Fri Aug 22, 2025 at 1:26 PM CEST, Miguel Ojeda wrote:
> On Fri, Aug 22, 2025 at 1:05=E2=80=AFPM Danilo Krummrich <dakr@kernel.org=
> wrote:
>>
>> We should probably check if we can get a clippy warning in place for thi=
s.
>
> There is https://rust-lang.github.io/rust-clippy/master/index.html#unwrap=
_used,
> which covers all cases.

Great! I think there's a lot of value in getting this enabled.

>> we could also write
>>
>>         assert!(tree
>>             .insert(100, the_answer, GFP_KERNEL)
>>             .is_err_and(|e| e.cause =3D=3D InsertErrorKind::Occupied));
>
> If we want to use the Clippy lint, i.e. go hard on avoiding all kinds
> of `unwrap()`s, then that is fine.
>
> But I wouldn't do it just for the sake of avoiding a few
> `unwrap_err()`s within `assert!`s

Why not? I mean, the above is cleaner and more idiomatic with or without th=
e
lint enabled. As mentioned, it's even the showcase that has been picked for=
 the
documentation of Result::is_err_and().

> I don't think there is going to
> be a problem of having a lot of people concluding it is OK to panic
> the kernel in general just because they see an `unwrap_err()` within
> an `assert!` -- the `assert!` itself could be also understood as
> panicking, after all, and we really don't want to ban `assert!`s on
> examples.

I didn't mean to say that people conclude it's OK to panic the kernel.

But especially people new to the kernel starting to write Rust drivers may =
not
even be aware of this fact. If they see some unwrap_err() calls in examples=
 they
might not even thing about it a lot before starting to use them, e.g. becau=
se
they're used to it from userspace projects anyways.

> Now, if we do get something else out of it, like enforcing no
> `unwrap()`s (still bypassable with `allow` etc. if needed) and thus
> removing a class of errors, then that sounds worthier to me.

I think we should do this; I really think otherwise we gonna see a lot of t=
hem
once we get more drivers. It's just too convinient. :)

