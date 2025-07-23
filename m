Return-Path: <linux-kernel+bounces-743139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 354F5B0FB1C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 21:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8AC57A8FF3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 19:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C105223DFD;
	Wed, 23 Jul 2025 19:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bqQTyOca"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6072E630;
	Wed, 23 Jul 2025 19:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753299967; cv=none; b=uWnVgJ7wxQmq2jj5FnNPQ8xyv9eNwWPWevmf6hTcpz3jf3BToiYKab1MJ12NIhdBO2uNIDGK+C98gQON63KEGWL+e/EFnix6k5LQpsvpMMHFc5uGitc3KmbCainFJjOI59NW491tY/4OyIZFNoLTvpG1YT67REIoJu1uSoqHGf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753299967; c=relaxed/simple;
	bh=GBzigl9chBPCdko0Xg4/U1Rduruvdu/cT0GVi+vnvG0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=u8MKv4OPFjn7mt+JxusxHy/qwmlrC8QXsq5gjPa6JABlXSKsyQtS/UMLfP3rMXHa63bvm7P/nF0QTk3MARfzgwrjpeWzng8v+fy77z3qqFSiABhwMaHq2qMUJH0C0zH8Ktajvb49hxpreOQ8ogFaYh+PYm/+srhMjtno315BOhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bqQTyOca; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AB30C4CEE7;
	Wed, 23 Jul 2025 19:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753299967;
	bh=GBzigl9chBPCdko0Xg4/U1Rduruvdu/cT0GVi+vnvG0=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=bqQTyOcah9FLWIWXPi633iJeWC20utx5R4UCxwthvXSbops8iCR1tLqu4wGMuYSim
	 +8CkWu+Q8ppnYKB/uqAzmgQQxaY2jpNFX8k41lZzr0nfWOijS7O6YAISPP8RDsr50P
	 kfslEzv+0kzwHUh1QCO3WIS7hveT5QRhJDrQeYGLt2pcvZ91lQf0qtcRAXRK6mc/Ad
	 y/qNqtFvWQIT2Gd+PCMb1u3TOMD7BS73inHfSArqzkW9zRCBB3Y7l+IPtjVEv64rxs
	 sIqFmmteHo3v71t87Jp5ivyANS5jJf0ljX+0Volou9rpqbjN1j6iu0WsyUMRpKBDqK
	 tLW+Jjr8F84/w==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 23 Jul 2025 21:46:03 +0200
Message-Id: <DBJOYRYFZJ5I.26IFPSP138T23@kernel.org>
Subject: Re: [PATCH 1/2] rust: sync: refactor static_lock_class!() macro
From: "Benno Lossin" <lossin@kernel.org>
To: "Boqun Feng" <boqun.feng@gmail.com>, "Alice Ryhl" <aliceryhl@google.com>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20250723-lock-class-key-cleanup-v1-0-85fa506b8ca4@google.com>
 <20250723-lock-class-key-cleanup-v1-1-85fa506b8ca4@google.com>
 <DBJIDFSMYASO.3VRN4ZZEUI8EX@kernel.org>
 <CAH5fLgjWFa8TjTL+rfv7Zd+OQqhkKqWvyTkGf60pMUyQ=c4sXg@mail.gmail.com>
 <aIELxq_iVMfjszkh@tardis-2.local>
In-Reply-To: <aIELxq_iVMfjszkh@tardis-2.local>

On Wed Jul 23, 2025 at 6:20 PM CEST, Boqun Feng wrote:
> On Wed, Jul 23, 2025 at 05:01:39PM +0200, Alice Ryhl wrote:
>> On Wed, Jul 23, 2025 at 4:36=E2=80=AFPM Benno Lossin <lossin@kernel.org>=
 wrote:
>> > On Wed Jul 23, 2025 at 1:49 PM CEST, Alice Ryhl wrote:
>> > >  impl LockClassKey {
>> > > +    /// Initializes a statically allocated lock class key.
>> > > +    ///
>> > > +    /// This is usually used indirectly through the [`static_lock_c=
lass!`] macro.
>> > > +    ///
>> > > +    /// # Safety
>> > > +    ///
>> > > +    /// The destructor must never run on the returned `LockClassKey=
`.
>> >
>> > I don't know how lockdep works, but Boqun mentioned in the other threa=
d
>> > that it uses the address of static keys. But AFAIK there is no mechani=
sm
>> > to differentiate them, so does lockdep just check the address and if i=
t
>
> In lockdep, we use `static_obj()` to tell whether it's a static obj or a
> dynamic allocated one.

So the code below will go in the non-static code path. Why doesn't it
need to be initialized/registered? (but other cases need it?)

>> > is in a static segment it uses different behavior?
>> >
>> > Because from the safety requirements on this function, I could just do
>> > this:
>> >
>> >     // SAFETY: we leak the box below, so the destructor never runs.
>> >     let class =3D KBox::new(unsafe { LockClassKey::new_static() });
>> >     let class =3D Pin::static_ref(KBox::leak(class));
>> >     let lock =3D SpinLock::new(42, c_str!("test"), class);
>
> This will trigger a runtime error because `class` is not static, but
> technically, it won't trigger UB, at least lockdep should be able to
> handle this case.

Could you go into more details? What is the "technically it won't
trigger UB" part about?

---
Cheers,
Benno

