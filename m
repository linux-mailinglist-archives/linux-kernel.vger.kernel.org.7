Return-Path: <linux-kernel+bounces-720447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93688AFBBE0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 21:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFB7B7B1D3E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 19:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C4426563B;
	Mon,  7 Jul 2025 19:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bVJB0nyi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABE61428E7;
	Mon,  7 Jul 2025 19:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751917693; cv=none; b=J/bVIWX6sU7hl3gFrz7B5iUcsIVJMsKvLugSaIbZ8T7IE/DJICJdbLIrCFB8NIEIswrn53bPHGsXFpeR24WN23c8N/ZADAvBESgqpduC1tn3gV5FtLsBKUIwDfrdJWD8WV9RUs7e28bJmMEv4dpwEBQhw+QdQ+784YYRKSbDPC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751917693; c=relaxed/simple;
	bh=ecdVWzxZIierHezK9JWfxYPiiYP/s+IBBE/NxnEUh0k=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=mGt6bYfitstygCdbjT4ptP4ptI40Fn7CIfE3NFNI8zj27gzEAhQsHUGn3KWPXylCoOlbPSb6A6itDUFKKrEXiI+OlN5Ad664FcPlGp3TIVGv6+/rwdLIfbVNEEgAkZIDvR1V3UrMM1cntRzXfa4Ug8E6wwHOMO4kCulgG3SXL3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bVJB0nyi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68626C4CEE3;
	Mon,  7 Jul 2025 19:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751917692;
	bh=ecdVWzxZIierHezK9JWfxYPiiYP/s+IBBE/NxnEUh0k=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=bVJB0nyiTvMUX98Qa8rWx97izZFRkRGX2NJ7U+Rk/j/xgMZaasL4jGUpwrcAuQ3IY
	 CfLExvGXJUC7g3NE82DhJeh3aIHOj/RlBXZmjVmrbMjKdT/D98rlo0VzzIfPfADB3L
	 7g7XM6+FKiMb0+bLlAMM9kuO/k5kFBoDC4/kgycmEQeWDsRpvUfwTsSqdI5BPTwz0P
	 pAiHBV2OYl8ohN7m88bYmSnXlaFwtPYm6Nt8X3SHQwxqR/13rsBJBevxxUaBGPJk/9
	 97jjqygPtRw4S8Ts4WrE2xDIqu157tSBkFhUvE9QVf1xBnmEPJtFw1uz2sfISu2FHg
	 GgBz9XsZWwmxg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 07 Jul 2025 21:48:07 +0200
Message-Id: <DB62ZN1LTO31.1HVWDLAWJWVM8@kernel.org>
Cc: "Boqun Feng" <boqun.feng@gmail.com>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <gary@garyguo.net>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>, <dakr@kernel.org>,
 <peterz@infradead.org>, <mingo@redhat.com>, <will@kernel.org>,
 <longman@redhat.com>, <felipe_life@live.com>, <daniel@sedlak.dev>,
 <bjorn3_gh@protonmail.com>
Subject: Re: [PATCH v5 2/3] implement ww_mutex abstraction for the Rust tree
From: "Benno Lossin" <lossin@kernel.org>
To: "Onur" <work@onurozkan.dev>
X-Mailer: aerc 0.20.1
References: <20250621184454.8354-1-work@onurozkan.dev>
 <20250621184454.8354-3-work@onurozkan.dev>
 <DASY7BECFRCT.332X5ZHZMV2W@kernel.org> <aFlQ7K_mYYbrG8Cl@Mac.home>
 <DATYHYJVPL3L.3NLMH7PPHYU9@kernel.org> <aFlpFQ4ivKw81d-y@Mac.home>
 <DAU0ELV91E2Q.35FZOII18W44J@kernel.org>
 <20250707163913.5ffc046d@nimda.home>
 <DB5XIWGZ8U36.1VB58YBJFL7OT@kernel.org>
 <20250707210613.2fd5bb55@nimda.home>
In-Reply-To: <20250707210613.2fd5bb55@nimda.home>

On Mon Jul 7, 2025 at 8:06 PM CEST, Onur wrote:
> On Mon, 07 Jul 2025 17:31:10 +0200
> "Benno Lossin" <lossin@kernel.org> wrote:
>
>> On Mon Jul 7, 2025 at 3:39 PM CEST, Onur wrote:
>> > On Mon, 23 Jun 2025 17:14:37 +0200
>> > "Benno Lossin" <lossin@kernel.org> wrote:
>> >
>> >> > We also need to take into consideration that the user want to
>> >> > drop any lock in the sequence? E.g. the user acquires a, b and
>> >> > c, and then drop b, and then acquires d. Which I think is
>> >> > possible for ww_mutex.
>> >>=20
>> >> Hmm what about adding this to the above idea?:
>> >>=20
>> >>     impl<'a, Locks> WwActiveCtx<'a, Locks>
>> >>     where
>> >>         Locks: Tuple
>> >>     {
>> >>         fn custom<L2>(self, action: impl FnOnce(Locks) -> L2) ->
>> >> WwActiveCtx<'a, L2>; }
>> >>=20
>> >> Then you can do:
>> >>=20
>> >>     let (a, c, d) =3D ctx.begin()
>> >>         .lock(a)
>> >>         .lock(b)
>> >>         .lock(c)
>> >>         .custom(|(a, _, c)| (a, c))
>> >>         .lock(d)
>> >>         .finish();
>> >
>> >
>> > Instead of `begin` and `custom`, why not something like this:
>> >
>> > 	let (a, c, d) =3D ctx.init()
>> > 	    .lock(a)
>> >             .lock(b)
>> >             .lock(c)
>> >             .unlock(b)
>> >             .lock(d)
>> >             .finish();
>> >
>> > Instead of `begin`, `init` would be better naming to imply `fini`
>> > on the C side, and `unlock` instead of `custom` would make the
>> > intent clearer when dropping locks mid chain.

Also, I'm not really fond of the name `init`, how about `enter`?

>>=20
>> I don't think that this `unlock` operation will work. How would you
>> implement it?
>
>
> We could link mutexes to locks using some unique value, so that we can
> access locks by passing mutexes (though that sounds a bit odd).
>
> Another option would be to unlock by the index, e.g.,:
>
> 	let (a, c) =3D ctx.init()
> 	    .lock(a)
>             .lock(b)
>             .unlock::<1>()
>             .lock(c)
>             .finish();

Hmm yeah that's interesting, but probably not very readable...

    let (a, c, e) =3D ctx
        .enter()
        .lock(a)
        .lock(b)
        .lock_with(|(a, b)| b.foo())
        .unlock::<1>()
        .lock(c)
        .lock(d)
        .lock_with(|(.., d)| d.bar())
        .unlock::<2>();

> The index approach would require us to write something very similar
> to `Tuple` (with macro obviously) you proposed sometime ago.
>
> We could also just go back to your `custom` but find a better name
> for it (such as `retain`).

Oh yeah the name was just a placeholder.

The advantage of custom is that the user can do anything in the closure.

---
Cheers,
Benno

