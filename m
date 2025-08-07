Return-Path: <linux-kernel+bounces-759100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D97FB1D877
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 15:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA230723B6E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 13:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B772571A1;
	Thu,  7 Aug 2025 13:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rbh2ca7X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6982516F8E9;
	Thu,  7 Aug 2025 13:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754571684; cv=none; b=dAFcLWsw/RdrtvP6nseKtfuaj6pc9OduBOV8OIphQ8no4IS1Co8BTEmTpJEy3uCz7dt3X67eeBvyOe7m9RFM7mVzA+RHtj3cF5rSaBpOWeY6VCxboIIKZUgSVjNqmV5cCANblH4GSlHleZaprT093htHR/ND22HXEKJ2nGTtabg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754571684; c=relaxed/simple;
	bh=1zr6+DjuR7FSKkZ5IlMn3ByBcRGIQ5WJgEoFapMeqsY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H+oEQUrxH3Dv947VLrVfB17eyNERsIDXdlb8wANRWkyRg+Sm4OjU7jTrIL4A8VpKblInXkcJtIEYhnTOuU2AE/9KmUVZn49nR6N3DV+12br7u3H5p5rjyPE1dumhyHYq5uAGtaHtlVUwPTzaljxukJ1heuXqPsqIUFG3npMgB58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rbh2ca7X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4610AC4CEEB;
	Thu,  7 Aug 2025 13:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754571683;
	bh=1zr6+DjuR7FSKkZ5IlMn3ByBcRGIQ5WJgEoFapMeqsY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=rbh2ca7XfjERVFFQEjZrZF4ZXzkZvt/NDnPvz+cjh8Y11erlpKfjniP5Nrf9ysUpm
	 YGg+HDMs7z1mL1ZCzBdFzEHXi8BAS8Vci1C084TjRSg4CBerw0XiL4cKFfYRo0dUu6
	 YB2pDM9zOmsGd+LlrjN3GOC8rZGiErr5mvRTtSE8A2qwJ0GeZOYTn17REVK51XbZF4
	 IW3Ujbcefu6m3QAIzz0Q0YIdzKbxqdJUynlqtJ1XJMRUBsW5+rVFbhth7X5kRBpJ9D
	 aEQxEc9gx3AHU1ehmGckNniBWiztQGXRC0CYPF3p6PsALVrTo7PXmqFmdAXEavODY3
	 QBgZPEKnJtMvw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Daniel Almeida <daniel.almeida@collabora.com>, Lyude Paul
 <lyude@redhat.com>
Cc: rust-for-linux@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org, FUJITA
 Tomonori <fujita.tomonori@gmail.com>, Frederic Weisbecker
 <frederic@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, John
 Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda
 <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo
 <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno
 Lossin <lossin@kernel.org>, Alice
 Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo
 Krummrich <dakr@kernel.org>
Subject: Re: [PATCH v6 3/7] rust: hrtimer: Add HrTimer::raw_forward() and
 forward()
In-Reply-To: <4A89EA6C-7683-42CB-BA0E-0ED538480991@collabora.com>
References: <20250724185236.556482-1-lyude@redhat.com>
 <20250724185236.556482-4-lyude@redhat.com>
 <XtI68GvjNcx7s5O1wLlv81A-ruocqtapNPqRuyT38M9zQNeeg9pnjdoZ6X93-nqy-R4h3b2AW99YcAhVc-ap2Q==@protonmail.internalid>
 <4A89EA6C-7683-42CB-BA0E-0ED538480991@collabora.com>
Date: Thu, 07 Aug 2025 15:01:13 +0200
Message-ID: <87jz3f70bq.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Daniel Almeida" <daniel.almeida@collabora.com> writes:

> [=E2=80=A6]
>
>
>> +
>> +    /// Conditionally forward the timer.
>> +    ///
>> +    /// If the timer expires after `now`, this function does nothing an=
d returns 0. If the timer
>> +    /// expired at or before `now`, this function forwards the timer by=
 `interval` until the timer
>> +    /// expires after `now` and then returns the number of times the ti=
mer was forwarded by
>> +    /// `interval`.
>> +    ///
>> +    /// Returns the number of overruns that occurred as a result of the=
 timer expiry change.
>> +    pub fn forward(self: Pin<&mut Self>, now: HrTimerInstant<T>, interv=
al: Delta) -> u64
>> +    where
>> +        T: HasHrTimer<T>,
>> +    {
>> +        // SAFETY:
>> +        // - `raw_forward` does not move `self`.
>> +        // - Self is a mutable reference and thus always points to a va=
lid `HrTimer`
>
> I get what you're trying to say, but IMHO using the word "mutable" here is
> confusing. Mutability has nothing to do on whether something is valid. Th=
is
> should be rephrased, IMHO.

Having a reference to something implies validity. We could do:

  The coertion of `&mut Self` to `*mut Self` results in a pointer to a
  valid `Self`.


Best regards,
Andreas Hindborg



