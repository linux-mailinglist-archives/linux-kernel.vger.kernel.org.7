Return-Path: <linux-kernel+bounces-868357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D48C0509B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 10:27:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 494D83B3B24
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 08:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494BF304BAF;
	Fri, 24 Oct 2025 08:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eaLng0N+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACC1304969;
	Fri, 24 Oct 2025 08:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761294316; cv=none; b=qymupwaTzhTxBhDspPpnMwyW5L7diF1WFO4OC2NS82wXDyWzKgSG8eimwXFzok063a1dp9VVVL0jq2WL+RYv/EtB57KUC0wGIOsJ32ELaZIWa/EDaAxrJQJJFkV52Su80vBlUvekezgw77PauXtb3ILN/vutKPSDySIsShu7ksc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761294316; c=relaxed/simple;
	bh=SXBdpcMk2TDYEoZXQ/iMgZKyh1Q8zdM0q3pF+Ul1UgY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M+iVZtC/FS1V2ZhsfMeRQE1KgYcAvyYSvnQoH/Ndu6A/d1mH2xrcVLI3fC/8bUaby3ANum4ihWBhn8Gdyq4oXy4wgPbHAP5/crjJxgnQ9eEx00N68OBk6NrnIwp9Clj38JPUP2yAeudr06KbWt1lVPNL4qE0pZYX0/x0/Ty5fLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eaLng0N+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA050C4CEF1;
	Fri, 24 Oct 2025 08:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761294316;
	bh=SXBdpcMk2TDYEoZXQ/iMgZKyh1Q8zdM0q3pF+Ul1UgY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=eaLng0N+ouTdoVQeWVRFNjvUdJ3i6m3xg8pLrwM1gC41ZXzXCchS/jeNWi/o+oyNI
	 FS5e8SYTAIHtC39Ml9ANl1EOG3uBlTkb3VSJ90TxJKwW4HTOMdFoE6KXNgvvdrhKiz
	 gpVTS+jnuKenw3fakJJK1mbgDAHtDfQzeThAxLxekq7OtZ9nGUh8nh4VD2cFfCAzCC
	 1y0YI4tsZELZiBgVM+udKTvVlgWOHJ7TFgh9AlXrnDJrt3j5pRz1BDIl2LI8bAsivY
	 I4KdL/xXk6drMbKUvV6mK3Ci2lMeFH6MVVTWAj10XhK/xDlfWoApmx08E0WSA1RMRF
	 N2TRGxoQv/oHA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>,
 daniel.almeida@collabora.com, alex.gaynor@gmail.com, ojeda@kernel.org,
 anna-maria@linutronix.de, bjorn3_gh@protonmail.com, boqun.feng@gmail.com,
 frederic@kernel.org, gary@garyguo.net, jstultz@google.com,
 linux-kernel@vger.kernel.org, lossin@kernel.org, lyude@redhat.com,
 rust-for-linux@vger.kernel.org, sboyd@kernel.org, tglx@linutronix.de,
 tmgross@umich.edu
Subject: Re: [PATCH v2 2/2] rust: Add read_poll_count_atomic function
In-Reply-To: <aPeTFMeVoIuo8Lur@google.com>
References: <20251021071146.2357069-1-fujita.tomonori@gmail.com>
 <20251021071146.2357069-3-fujita.tomonori@gmail.com>
 <DDO06754OMN5.G0AN9OCWTFLW@kernel.org>
 <h4wUwTMyHx85K0_CDEI0TkQoZFaEof5pJhADCtIUn01egSGxEcBVfQ6Y613ocOd0gU_j6X9g1agE9ealXqnE-A==@protonmail.internalid>
 <aPeTFMeVoIuo8Lur@google.com>
Date: Fri, 24 Oct 2025 10:25:05 +0200
Message-ID: <871pmshfku.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Alice Ryhl" <aliceryhl@google.com> writes:

> On Tue, Oct 21, 2025 at 02:35:34PM +0200, Danilo Krummrich wrote:
>> On Tue Oct 21, 2025 at 9:11 AM CEST, FUJITA Tomonori wrote:
>> > +/// Polls periodically until a condition is met, an error occurs,
>> > +/// or the attempt limit is reached.
>> > +///
>> > +/// The function repeatedly executes the given operation `op` closure and
>> > +/// checks its result using the condition closure `cond`.
>> > +///
>> > +/// If `cond` returns `true`, the function returns successfully with the result of `op`.
>> > +/// Otherwise, it performs a busy wait for a duration specified by `delay_delta`
>> > +/// before executing `op` again.
>> > +///
>> > +/// This process continues until either `op` returns an error, `cond`
>> > +/// returns `true`, or the attempt limit specified by `count` is reached.
>> > +///
>> > +/// # Errors
>> > +///
>> > +/// If `op` returns an error, then that error is returned directly.
>> > +///
>> > +/// If the attempt limit specified by `count` is reached, then
>> > +/// `Err(ETIMEDOUT)` is returned.
>> > +///
>> > +/// # Examples
>> > +///
>> > +/// ```no_run
>> > +/// use kernel::io::{Io, poll::read_poll_count_atomic};
>> > +/// use kernel::time::Delta;
>> > +///
>> > +/// const HW_READY: u16 = 0x01;
>> > +///
>> > +/// fn wait_for_hardware<const SIZE: usize>(io: &Io<SIZE>) -> Result {
>> > +///     match read_poll_count_atomic(
>> > +///         // The `op` closure reads the value of a specific status register.
>> > +///         || io.try_read16(0x1000),
>> > +///         // The `cond` closure takes a reference to the value returned by `op`
>> > +///         // and checks whether the hardware is ready.
>> > +///         |val: &u16| *val == HW_READY,
>> > +///         Delta::from_micros(50),
>> > +///         1000,
>> > +///     ) {
>> > +///         Ok(_) => {
>> > +///             // The hardware is ready. The returned value of the `op` closure
>> > +///             // isn't used.
>> > +///             Ok(())
>> > +///         }
>> > +///         Err(e) => Err(e),
>> > +///     }
>>
>> Please replace the match statement with map().
>>
>> 	read_poll_count_atomic(
>> 	    ...
>> 	)
>> 	.map(|_| ())
>>
>
> IMO, this should instead be:
>
> 	read_poll_count_atomic(
> 	    ...
> 	)?
> 	Ok(())

It does not really matter to me. Why do you prefer one to the other?


Best regards,
Andreas Hindborg




