Return-Path: <linux-kernel+bounces-761359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2728B1F8C1
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 09:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D888F189AFC4
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 07:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3C023371B;
	Sun, 10 Aug 2025 07:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wv2c4Z2N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBCA1B0414;
	Sun, 10 Aug 2025 07:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754810314; cv=none; b=qNnRKDvi2V00RTxaVPX9OEza/DDsG2UZhYuQS7zt+z3fObjYFdjfp6ACsnlxmvGd48EeJXArL+TNIef08qIv4JOoxD7i7CqHG8e7NVPYSo0Ut0WN9jVv7GYDN/JDxKXSIPlHztZUQUXUOJ9xRpW9zIa4xbd69ITF3MeWpqQz5Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754810314; c=relaxed/simple;
	bh=m0LZvtspGkdKJD/bhIqp+thUQOSfHtX2J1mwExX8WQ0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sYUPPtgharsoDIirrwewXGkZh85dUX7WCs5qUl10gFaOnWyy00/9AXsJpZDdM7BZ17gPzHngW+kKHaRoPfG/0jfyVD5IClzsWlcQKLw8XfX0GK7EVaOAAfVQJRAxyzPTUMhZCQipNUunehqgxR1Qmhpj9k/zRvHp4RDaEXMn3uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wv2c4Z2N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78780C4CEF0;
	Sun, 10 Aug 2025 07:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754810313;
	bh=m0LZvtspGkdKJD/bhIqp+thUQOSfHtX2J1mwExX8WQ0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Wv2c4Z2NM9uceoZbPisKXZH6wEvYHqdz9zxPNyHOFbbNFxNN752Bo/kekPv7P6v3b
	 a1zmhCJ65cIyi7yy2OuZtpCBp2P4ihu0cpoIdUtuhR3nGeOJuHjhh76Bx6httNLfcu
	 1O72A5GvMiMAWt9iWMHN2ihFSzQwB7LFj2M7gabti5OzfBSxmJ66kHWQGn0+0TVqTw
	 qzVTf0/FXPTpL+7v8WK62AotXzSzNYNEkQE9NKUX8wJIKCQuVdB5un6miOEiUryWLz
	 s3GAmwPhQ8ZuJNPK7XTzPk2pRNCVDrSRTf3HUBJ8q7+2VonWo9K+94DaI0Ovmz0poN
	 5sW1BqQ+8AnPg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Benno Lossin <lossin@kernel.org>, Lyude Paul <lyude@redhat.com>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Boqun Feng <boqun.feng@gmail.com>, FUJITA Tomonori
 <fujita.tomonori@gmail.com>, Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, John Stultz <jstultz@google.com>, Stephen
 Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor
 <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6r?=
 =?utf-8?Q?n?= Roy Baron
 <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Trevor
 Gross <tmgross@umich.edu>, Danilo
 Krummrich <dakr@kernel.org>
Subject: Re: [PATCH v2 2/2] rust: time: Implement basic arithmetic
 operations for Delta
In-Reply-To: <DBXBRG094WRM.NF5B4VEE4C71@kernel.org>
References: <20250807190649.3078875-1-lyude@redhat.com>
 <20250807190649.3078875-2-lyude@redhat.com>
 <svb53oAEKDteq_fe9645of8UzIGnGcXC0HEIIeNsJIP_nuoKl7MzDUllEsinlM-ZwlGEDg-SXo8WzfZfko77TQ==@protonmail.internalid>
 <DBWUBK3RSCMB.F1FJ5V6NCOJU@kernel.org> <87sei25fm5.fsf@kernel.org>
 <si-Dx4VXjVeTjAmvGZrnzXAomCwGC7HjYn1eljRhu2VA2HAwN6SBhF0CZm7xKQavKb4QSOMv3njNQIkAIOWfTg==@protonmail.internalid>
 <DBXBRG094WRM.NF5B4VEE4C71@kernel.org>
Date: Sun, 10 Aug 2025 09:18:22 +0200
Message-ID: <87ikivhcg1.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Benno Lossin" <lossin@kernel.org> writes:

> On Fri Aug 8, 2025 at 11:26 AM CEST, Andreas Hindborg wrote:
>> "Benno Lossin" <lossin@kernel.org> writes:
>>
>>> On Thu Aug 7, 2025 at 9:06 PM CEST, Lyude Paul wrote:
>>>> While rvkms is only going to be using a few of these, since Deltas are
>>>> basically the same as i64 it's easy enough to just implement all of the
>>>> basic arithmetic operations for Delta types.
>>>>
>>>> Keep in mind there's one quirk here - the kernel has no support for
>>>> i64 % i64 on 32 bit platforms, the closest we have is i64 % i32 through
>>>> div_s64_rem(). So, instead of implementing ops::Rem or ops::RemAssign =
we
>>>> simply provide Delta::rem_nanos().
>>>
>>> We could still provide the trait implementations on CONFIG_64BIT? WDYT?
>>>
>>>> +impl ops::Div for Delta {
>>>> +    type Output =3D Self;
>>>> +
>>>> +    #[inline]
>>>> +    fn div(self, rhs: Self) -> Self::Output {
>>>> +        #[cfg(CONFIG_64BIT)]
>>>> +        {
>>>
>>> This pattern seems to be rather common in this patchset & in general I
>>> think I've also seen it elsewhere. We should think about adding a
>>> `if_cfg!` macro:
>>>
>>>     Self {
>>>         nanos: if_cfg! {
>>>             if CONFIG_64BIT {
>>>                 self.nanos / rhs.nanos
>>>             } else {
>>>                 unsafe { ... }
>>>             }
>>>         },
>>>     }
>>>
>>
>> Why the need for a macro. `cfg!` is built-in [1]:
>>
>>   if cfg!(CONFIG_64BIT) {
>>      ...
>>   } else {
>>      ...
>>   }
>>
>> The conditional expression should be optimized statically and the dead
>> part should be removed.
>
> AIUI the `self.nanos / rhs.nanos` won't compile on 32 bit platforms.

Ah, of course =F0=9F=91=8D

Best regards,
Andreas Hindborg




