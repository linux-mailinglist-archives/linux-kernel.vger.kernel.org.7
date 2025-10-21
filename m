Return-Path: <linux-kernel+bounces-862897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3B9BF6799
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 14:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11CBA19A1200
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3FF32ED20;
	Tue, 21 Oct 2025 12:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="id0bkVuL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3F432E743;
	Tue, 21 Oct 2025 12:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761050140; cv=none; b=WiFNyJjcNPJpdXddTudVHlmNF4g76C11klsIcrvv9irW//AT7Nlv4EJNT4A1MqqXx/dDdE+/K9UHl2Z2WGAIB2xxFEsjMEgcXbiWXt4jUg6RwNDz7Sgps+eYWZJ6ZFhpDj2j18lO4IRqjQY9xLgOcrEePSo7gZBveEj56RUdf6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761050140; c=relaxed/simple;
	bh=pO6MO9yCyx9ImFV9D2+s71VvtDh5hx9b//djs7oC+A0=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=f2Pi+zgY7uaHhKms4fzJrl8zuJr48Vs/zwiXJ8JITJn95zsc9I3KieLlY+eXQFjIdy2hTFJuuDw9S9C7aOUczd5vUrJad4iJeBAYybjLC9EAm2AqVF9YQXpZBTXJ28rZPnPTR+gr4McsIIPb1Favgm+WGgeiZFIt1/s8i1fR0BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=id0bkVuL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11781C4CEF1;
	Tue, 21 Oct 2025 12:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761050139;
	bh=pO6MO9yCyx9ImFV9D2+s71VvtDh5hx9b//djs7oC+A0=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=id0bkVuLBAeOaohiymVTtBnioLPXXXoRjvv8tqFi1FgvUSWWvH+JaSFuB8PNOHu5j
	 +HurPlp6370FObJoNenqg+3PV96lxhtTaLi9HASVUJG35dVj0vLESHMkoT2toPuSFY
	 ZRHqMMzeB8F8EBsF5Hk7/yjncp1CimepNcJlF70YugXD063l+qDAhNiEz4c0Zmwa8W
	 jjI2za8Ko2WZDgQ1M/E8jpjqqctdMehynYHzfAmOrrqPEG2dUjqOTQ+13oOJn/LUJt
	 /RgRlYFocRlj//3WQF3AK0Ij+gBeCpLOMDRJXFqQGSKelzAT8ErofCH/g8yMlZzAU2
	 A+b4bluKz+7nQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Oct 2025 14:35:34 +0200
Message-Id: <DDO06754OMN5.G0AN9OCWTFLW@kernel.org>
To: "FUJITA Tomonori" <fujita.tomonori@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 2/2] rust: Add read_poll_count_atomic function
Cc: <aliceryhl@google.com>, <daniel.almeida@collabora.com>,
 <a.hindborg@kernel.org>, <alex.gaynor@gmail.com>, <ojeda@kernel.org>,
 <anna-maria@linutronix.de>, <bjorn3_gh@protonmail.com>,
 <boqun.feng@gmail.com>, <frederic@kernel.org>, <gary@garyguo.net>,
 <jstultz@google.com>, <linux-kernel@vger.kernel.org>, <lossin@kernel.org>,
 <lyude@redhat.com>, <rust-for-linux@vger.kernel.org>, <sboyd@kernel.org>,
 <tglx@linutronix.de>, <tmgross@umich.edu>
References: <20251021071146.2357069-1-fujita.tomonori@gmail.com>
 <20251021071146.2357069-3-fujita.tomonori@gmail.com>
In-Reply-To: <20251021071146.2357069-3-fujita.tomonori@gmail.com>

On Tue Oct 21, 2025 at 9:11 AM CEST, FUJITA Tomonori wrote:
> +/// Polls periodically until a condition is met, an error occurs,
> +/// or the attempt limit is reached.
> +///
> +/// The function repeatedly executes the given operation `op` closure an=
d
> +/// checks its result using the condition closure `cond`.
> +///
> +/// If `cond` returns `true`, the function returns successfully with the=
 result of `op`.
> +/// Otherwise, it performs a busy wait for a duration specified by `dela=
y_delta`
> +/// before executing `op` again.
> +///
> +/// This process continues until either `op` returns an error, `cond`
> +/// returns `true`, or the attempt limit specified by `count` is reached=
.
> +///
> +/// # Errors
> +///
> +/// If `op` returns an error, then that error is returned directly.
> +///
> +/// If the attempt limit specified by `count` is reached, then
> +/// `Err(ETIMEDOUT)` is returned.
> +///
> +/// # Examples
> +///
> +/// ```no_run
> +/// use kernel::io::{Io, poll::read_poll_count_atomic};
> +/// use kernel::time::Delta;
> +///
> +/// const HW_READY: u16 =3D 0x01;
> +///
> +/// fn wait_for_hardware<const SIZE: usize>(io: &Io<SIZE>) -> Result {
> +///     match read_poll_count_atomic(
> +///         // The `op` closure reads the value of a specific status reg=
ister.
> +///         || io.try_read16(0x1000),
> +///         // The `cond` closure takes a reference to the value returne=
d by `op`
> +///         // and checks whether the hardware is ready.
> +///         |val: &u16| *val =3D=3D HW_READY,
> +///         Delta::from_micros(50),
> +///         1000,
> +///     ) {
> +///         Ok(_) =3D> {
> +///             // The hardware is ready. The returned value of the `op`=
 closure
> +///             // isn't used.
> +///             Ok(())
> +///         }
> +///         Err(e) =3D> Err(e),
> +///     }

Please replace the match statement with map().

	read_poll_count_atomic(
	    ...
	)
	.map(|_| ())

> +/// }
> +/// ```
> +pub fn read_poll_count_atomic<Op, Cond, T>(

I understand why you renamed the function, but read_poll_timeout_atomic() w=
ould
still be accurate -- it does perform a timeout in every iteration. Let's ke=
ep
the original name please.

> +    mut op: Op,
> +    mut cond: Cond,
> +    delay_delta: Delta,
> +    count: usize,

Maybe retry would be a slightly better fit compared to count. If we want to=
 be a
bit more verbose, I suggest retry_count. :)

> +) -> Result<T>
> +where
> +    Op: FnMut() -> Result<T>,
> +    Cond: FnMut(&T) -> bool,
> +{
> +    for _ in 0..count {
> +        let val =3D op()?;
> +        if cond(&val) {
> +            // Unlike the C version, we immediately return.
> +            // We know the condition is met so we don't need to check ag=
ain.

NIT: Just like in read_poll_timeout() I think this comment does not carry m=
uch
value, but I'm fine if you want to keep it.

> +            return Ok(val);
> +        }
> +
> +        if !delay_delta.is_zero() {
> +            udelay(delay_delta);
> +        }
> +
> +        cpu_relax();
> +    }
> +
> +    Err(ETIMEDOUT)
> +}
> --=20
> 2.43.0


