Return-Path: <linux-kernel+bounces-758212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04BF9B1CC8D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 21:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B420D3A646C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 19:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76D329B78E;
	Wed,  6 Aug 2025 19:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VCUrCGtW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2114DA926;
	Wed,  6 Aug 2025 19:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754508633; cv=none; b=HDzFLkOnC+8VlDv03XYDH+du4B5uc1N6zjN10+F9QkpeyM1BQnxqor11Hnu1WaZJrguGfvjmkC4Ukm3SkcpUI0CFxSyrgTr21YssGzxJU5wKqAnIw72wcp95fOvFN06rzAAs7KUYmNvr31Zz+/bel167U0xRAwO6IvPlnTxdDPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754508633; c=relaxed/simple;
	bh=CHfJz3Zr+ZhgCEc+c+mDKHsLH+szpTh2gjLypLcgmv0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=B0EL7KMOIKKUByvRjNi2keHQ0LJhR2vWKbWqmsZZvKB14ikQywU0YLjY5gf30x7rnNNyJ4oljnHMLJHh8aDW0EzuPhdke0gTIMde525V3GkaE1K2sR/6g1spyOuHkopVX9mskawrz2qKPE5k32PT8B4fQbbo9bCvyoHlN7JS3ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VCUrCGtW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AAA6C4CEE7;
	Wed,  6 Aug 2025 19:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754508632;
	bh=CHfJz3Zr+ZhgCEc+c+mDKHsLH+szpTh2gjLypLcgmv0=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=VCUrCGtWZEanuhudesu+gJ1KnFzqzRYINuiVIfcGvSXToSM0vh+o106ErxxekrAJ+
	 QxC9+s8JRS+83wP/WkRkJVaiffsp/9KxpdPBh7AGmBELwk+PvGxDYOVPzSzBw8JyUx
	 ElVu9Rjpo9pJuZg+fg5f9+DyVcDLfBX2hzLCGZGAQii/yYGgJOSItIPtC+1hJS479e
	 zN83qD2Revz3i336D3rVMRAm/8dnKdGaBIZoCeFJdkON9P13agr34h997GbMfL220J
	 ByJ0WQ3ooE81wVUMqUOpyTHUKAouiSobORp+4MuJf5EgcdMuAEm4U6X7nSQix/RTt/
	 44kCinnQmc1zQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 06 Aug 2025 21:30:27 +0200
Message-Id: <DBVLEGFYBWKE.2RW8J853CJHTY@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <ojeda@kernel.org>, <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>,
 <gary@garyguo.net>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
 <tmgross@umich.edu>, <dakr@kernel.org>, <peterz@infradead.org>,
 <mingo@redhat.com>, <will@kernel.org>, <longman@redhat.com>,
 <felipe_life@live.com>, <daniel@sedlak.dev>, <bjorn3_gh@protonmail.com>
Subject: Re: [PATCH v5 0/3] rust: add `ww_mutex` support
From: "Benno Lossin" <lossin@kernel.org>
To: "Lyude Paul" <lyude@redhat.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>
X-Mailer: aerc 0.20.1
References: <20250621184454.8354-1-work@onurozkan.dev>
 <20250724165351.509cff53@nimda.home>
 <ec32fc5f5a8658c084f96540bd41f5462fa5c182.camel@gmail.com>
 <20250806085702.5bf600a3@nimda.home>
 <539d3e0da773c32a42b4ab5c9d4aa90383481ff6.camel@redhat.com>
In-Reply-To: <539d3e0da773c32a42b4ab5c9d4aa90383481ff6.camel@redhat.com>

On Wed Aug 6, 2025 at 7:37 PM CEST, Lyude Paul wrote:
> On Wed, 2025-08-06 at 08:57 +0300, Onur =C3=96zkan wrote:
>> Thanks for the feedback! Supporting single locks is easy, I just
>> didn't think it was a good idea at first but it looks like I missed
>> some cases.
>>=20
>> I can implement two types of locking functions: one on `WwMutex` where
>> `WwMutex::lock` handles a single lock without a context, and another on
>> `WwAcquireCtx`, where `WwAcquireCtx::lock` is used for handling
>> multiple contexts.
>>=20
>> e.g.,:
>>=20
>>     let mutex =3D WwMutex::new(...);
>>     mutex.lock(); // without context, for single locks
>>=20
>>     let ctx =3D WwAcquireCtx::new(...);
>>     ctx.lock(mutex); // with context, for multiple locks
>>=20
>> What do you think?
>
> Yeah I think this works great! One thing I'm curious about: as was previo=
usly
> mentioned in the thread, when there's no lock context a ww_mutex is basic=
ally
> identical to a mutex. Which makes me wonder if maybe it would make sense =
to
> actually implement ww_mutex as a kernel::sync::Backend exclusively for ct=
x-
> free lock acquisitions, and then simply implement locking with contexts
> through WwAcquireCtx. That way we at least get to reuse some of the locki=
ng
> infrastructure we already have in rust without overcomplicating it for
> everyone else.

We're going away from the generic lock framework, so I don't think we
should add any new `Backend`s.

---
Cheers,
Benno

