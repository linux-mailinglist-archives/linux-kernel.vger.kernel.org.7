Return-Path: <linux-kernel+bounces-786319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4B2B35841
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 11:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7DBB1885EFB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 09:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75FB230EF94;
	Tue, 26 Aug 2025 09:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qj9QX874"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA37303CBE;
	Tue, 26 Aug 2025 09:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756199365; cv=none; b=uqnGjX1j1YR8Jb+Gg4vMGxcZwCzAco3qhVkp64To1B8CbvYnje4XE3M1ISNOPPx5JuPI5dFM/JOVJfjnWlHiAIu3RLjq8XncoqJL/Oorp0YWhv0w7r3MGFsv+AKCs+ePyGA6GoTzB+SQKF3yia2/dblwiuX5wrpHh5UveVem2KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756199365; c=relaxed/simple;
	bh=qqZ+4hKPT8rN5AgmTjs1NipGWXklGnPgQ+hMYuZ1wyw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p4INS/vPiA8Q3tOuPzmbL0T8zVZF60JJgOVTlawHy9V+xu4SjkvK2dI8i/A1fN49CLbKBSBJV1wJ+WSZ6y8Ul6Ik7DDF2D8e+dZAbxZPlvTp25yNQQViFWQ8f4ok3wMhqfj4ECLwqabyW73war8wVEbIgj4ncoEw3bQd8R8Of/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qj9QX874; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 376F5C116B1;
	Tue, 26 Aug 2025 09:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756199365;
	bh=qqZ+4hKPT8rN5AgmTjs1NipGWXklGnPgQ+hMYuZ1wyw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=qj9QX8743fpls2iUfokeaf5/PF2tw5HHC3+TYMVQoOzBmR4BnwCngf/ym7GKeWmzT
	 FpVepAkBxjx4238ejpdVFULguLtuIxItkCqPLaOBYrsMvURrEjwwQeeatGeCCmtu7O
	 uROvPiwF3TIJZIcFWRqSQrCPL3wUdHGW2l4Ys8D9Nwdr3nzktybMeVszTNKPv2Dk5P
	 E3Cev+5Y2nqmBsbmZsdaYV9VD0LYjqLFSg65BdLlodSvOEtZnV3N+NUrOAbY01JFsB
	 AZ2kzwFRQsaTXDQS7U4aWUIT8UFnmu/MbOAwsPXnplFs5i7WEa3KWkOlf5/pP8/uYj
	 CmnTgsoO4KuVw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>, alex.gaynor@gmail.com,
 ojeda@kernel.org
Cc: aliceryhl@google.com, anna-maria@linutronix.de,
 bjorn3_gh@protonmail.com, boqun.feng@gmail.com, dakr@kernel.org,
 frederic@kernel.org, gary@garyguo.net, jstultz@google.com,
 linux-kernel@vger.kernel.org, lossin@kernel.org, lyude@redhat.com,
 rust-for-linux@vger.kernel.org, sboyd@kernel.org, tglx@linutronix.de,
 tmgross@umich.edu, acourbot@nvidia.com, daniel.almeida@collabora.com
Subject: Re: [PATCH v1 1/2] rust: add udelay() function
In-Reply-To: <20250821035710.3692455-2-fujita.tomonori@gmail.com>
References: <20250821035710.3692455-1-fujita.tomonori@gmail.com>
 <ub8ohgErgUJB1KWyrSWn18gSQiyiIJ4Py133yi5fMR68ZG2zeWokoP7kULU7voBjry46A7GZUSrHuCQn0C_DZg==@protonmail.internalid>
 <20250821035710.3692455-2-fujita.tomonori@gmail.com>
Date: Tue, 26 Aug 2025 11:09:12 +0200
Message-ID: <87bjo2witj.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"FUJITA Tomonori" <fujita.tomonori@gmail.com> writes:

> Add udelay() function, inserts a delay based on microseconds with busy
> waiting, in preparation for supporting read_poll_timeout_atomic().
>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> ---
>  rust/helpers/time.c       |  5 +++++
>  rust/kernel/time/delay.rs | 34 ++++++++++++++++++++++++++++++++++
>  2 files changed, 39 insertions(+)
>
> diff --git a/rust/helpers/time.c b/rust/helpers/time.c
> index a318e9fa4408..67a36ccc3ec4 100644
> --- a/rust/helpers/time.c
> +++ b/rust/helpers/time.c
> @@ -33,3 +33,8 @@ s64 rust_helper_ktime_to_ms(const ktime_t kt)
>  {
>  	return ktime_to_ms(kt);
>  }
> +
> +void rust_helper_udelay(unsigned long usec)
> +{
> +	udelay(usec);
> +}
> diff --git a/rust/kernel/time/delay.rs b/rust/kernel/time/delay.rs
> index eb8838da62bc..baae3238d419 100644
> --- a/rust/kernel/time/delay.rs
> +++ b/rust/kernel/time/delay.rs
> @@ -47,3 +47,37 @@ pub fn fsleep(delta: Delta) {
>          bindings::fsleep(delta.as_micros_ceil() as c_ulong)
>      }
>  }
> +
> +/// Inserts a delay based on microseconds with busy waiting.
> +///
> +/// Equivalent to the C side [`udelay()`], which delays in microseconds.
> +///
> +/// `delta` must be within `[0, `MAX_UDELAY_MS`]` in milliseconds;
> +/// otherwise, it is erroneous behavior. That is, it is considered a bug to
> +/// call this function with an out-of-range value, in which case the function
> +/// will insert a delay for at least the maximum value in the range and
> +/// may warn in the future.
> +///
> +/// The behavior above differs from the C side [`udelay()`] for which out-of-range
> +/// values could lead to an overflow and unexpected behavior.
> +///
> +/// [`udelay()`]: https://docs.kernel.org/timers/delay_sleep_functions.html#c.udelay
> +pub fn udelay(delta: Delta) {
> +    const MAX_UDELAY_DELTA: Delta = Delta::from_millis(bindings::MAX_UDELAY_MS as i64);
> +
> +    let delta = if (Delta::ZERO..=MAX_UDELAY_DELTA).contains(&delta) {
> +        delta
> +    } else {
> +        // TODO: Add WARN_ONCE() when it's supported.
> +        MAX_UDELAY_DELTA
> +    };
> +
> +    // SAFETY: It is always safe to call `udelay()` with any duration.

Function documentation says it is overflow and unexpected behavior to
call `udelay` with out of range value, but above comment says any
duration is safe. Which is it?


Best regards,
Andreas Hindborg




