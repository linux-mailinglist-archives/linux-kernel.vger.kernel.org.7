Return-Path: <linux-kernel+bounces-786214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79011B3569A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 10:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAEBB1B65D5E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 08:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D192F8BF7;
	Tue, 26 Aug 2025 08:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HGNy944t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2B52F8BC4;
	Tue, 26 Aug 2025 08:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756196466; cv=none; b=uhxFOHNnWUFF98ey7pMd1rR3a/3dM1pUz8AhvbV4saHKd/qt+/IkpUlHiNrDVcjhpPRtscTqZejRomzmyMWq74ZIDTpWWuIO2FbPdB/ZHAteXdRAlQFTctaWTQPfJR9bnFQznKiy/OdqYQsxhDaYFD9XozL+FVFrNUG27TeOBGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756196466; c=relaxed/simple;
	bh=VHtPe5jrCC23n5pXuxslMt4jtqxbQWQxIqRz+ykRYqc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CmsQiHQqfdjAYwK9c2zYYb39QTJEqFv4BPkujdaBGLyjvKbDsO3oeHfDzepl/nZeDGcSkz/Df8A0nQdgSwH6w1yhGiCr3qBjPHKn2Mz83HanwZpjp1rXszxi/xDTeI9VqUEYwKj2kosxaHrEfjtGKSEMdCcN5gbysTYKxrNy+uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HGNy944t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7165C4CEF4;
	Tue, 26 Aug 2025 08:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756196466;
	bh=VHtPe5jrCC23n5pXuxslMt4jtqxbQWQxIqRz+ykRYqc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=HGNy944tw/PICNv7AoXNC0FsSXtnZbGeCHi9OGTo65v0cSjqyPCJx3jLvlCbJC7v8
	 t4MwE8i7uS6CF3XbGr5hixkiJlbkQiwADfNjAs6Pm3F34BK69ETVkMjoV1Ns/A7FKM
	 F9j9sN4hqXU728ujPag2Ie5fT3+CesjF0QFkNIVYpr4IhXkJJa4d2WKACWXN6FZI2n
	 A0hPWPxEqf2WsC1/7UznfsDWq8q22LhPh9R934ft07dZj+PdxKSKUkCapVqd3HFjmX
	 SCCk8uImjWjfu37uk8vo6BB4kNd3WhqLT6oHpIUqVpAXsGqs4EFzRtD80QuV7ZMk0/
	 lA1futi7WAQRQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>, Lyude Paul <lyude@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, FUJITA Tomonori
 <fujita.tomonori@gmail.com>, Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, John Stultz <jstultz@google.com>, Stephen Boyd
 <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor
 <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6r?=
 =?utf-8?Q?n?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Trevor
 Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, "open
 list:DELAY, SLEEP, TIMEKEEPING, TIMERS [RUST]"
 <rust-for-linux@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 6/7] rust: time: Add Instant::from_ktime()
In-Reply-To: <CAH5fLgggbF2KWHazQ9rDeyVEjxg4LipfXA1qepPAhkkaHD4Mxw@mail.gmail.com>
References: <20250821193259.964504-1-lyude@redhat.com>
 <20250821193259.964504-7-lyude@redhat.com>
 <9xg5ZgDe4l4OXDVVwdu6JhDCXp6ox0Xzh4q2NU-SbGcTRu--I6ik0F0jtI_s46L6ieRFIpXWw8mkjNFiHAsOKQ==@protonmail.internalid>
 <CAH5fLgggbF2KWHazQ9rDeyVEjxg4LipfXA1qepPAhkkaHD4Mxw@mail.gmail.com>
Date: Tue, 26 Aug 2025 10:20:56 +0200
Message-ID: <87jz2qwl1z.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Alice Ryhl" <aliceryhl@google.com> writes:

> On Thu, Aug 21, 2025 at 9:34=E2=80=AFPM Lyude Paul <lyude@redhat.com> wro=
te:
>>

<cut>

>
>> +    #[inline]
>> +    pub(crate) unsafe fn from_ktime(ktime: bindings::ktime_t) -> Self {
>> +        debug_assert!(ktime >=3D 0);
>
> If you're going to have a debug assertion, perhaps it would make sense
> to check both bounds?

The upper bound is bindings::ktime_t::MAX, so it would be a useless check.


Best regards,
Andreas Hindborg






