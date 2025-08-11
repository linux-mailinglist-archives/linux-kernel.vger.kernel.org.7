Return-Path: <linux-kernel+bounces-762416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 716A5B20649
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8520817BA5A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 10:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9775283CB0;
	Mon, 11 Aug 2025 10:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M8H+K/hQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2325C283695;
	Mon, 11 Aug 2025 10:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754909240; cv=none; b=dNNkUU30JAiajo74FP+ls/ipYEu4yd7XKWzknpbU+FY2VeErfabvTP7GANyNJUDrkuCtO2XDemO7Lxy8neUq8VQ6SK8584CJRbe0MpF5Gzl4GhXV+aB+7STZSohaHSmUvQEGiKR4Vkx0ys5flmgcJEc4up/fzJ+n06SQVRvoevY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754909240; c=relaxed/simple;
	bh=cBR5dgtLg6ItwRpBd2lNHF0XtNlSGctZGm/Qe2yRzE0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H6YEcO+J+mOK54JpaHHY6ZGXEanYtXMfcelJG7MJ8D82znTO4lehYaRHRyWV0N0FgKAM1vMiwjVnnCalJcsSsRQxOexLd9vwVC501nbIIcymo2ghB+CNmyzHTi6RmhrPEvlkA4zkxqUJiJIWmvAd/uWYeS9AGao8qtv/km673VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M8H+K/hQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE059C4CEF6;
	Mon, 11 Aug 2025 10:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754909239;
	bh=cBR5dgtLg6ItwRpBd2lNHF0XtNlSGctZGm/Qe2yRzE0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=M8H+K/hQx6MUsJcTv5rkLS7b/sGAgeGoRnO1lHUMTVeYaroyctZN9lwK2vW3UMA5S
	 VTgOacvGgKgw4tyyjwjY670wlWl3sAjLv3Uutxj2dA6dgHjjLt69ft8o0PGrj1/WFv
	 fouyMuTwlDMcY/guI4F3j7MLB64QxIUl2s2lmWcQw6rVFy/0CdyasVuphk3Malk7tD
	 Gvfv/oAVVlz+n7UPMMgX/BxYv4197TIy3KRa+oHiCV6Ny+0HOPLOy8O1Wt8QTZW54n
	 VJOgzvZ6MWg5n2x/wdLN6PeiSVghMq38KP0RkP4fllKPzUq6V7Uu9lJC5YSJ2lNfwJ
	 qoZofIXH9zfjg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>, alex.gaynor@gmail.com,
 ojeda@kernel.org
Cc: aliceryhl@google.com, anna-maria@linutronix.de,
 bjorn3_gh@protonmail.com, boqun.feng@gmail.com, dakr@kernel.org,
 frederic@kernel.org, gary@garyguo.net, jstultz@google.com,
 linux-kernel@vger.kernel.org, lossin@kernel.org, lyude@redhat.com,
 rust-for-linux@vger.kernel.org, sboyd@kernel.org, tglx@linutronix.de,
 tmgross@umich.edu, acourbot@nvidia.com, daniel.almeida@collabora.com,
 Fiona Behrens <me@kloenk.dev>
Subject: Re: [PATCH v1 2/2] rust: Add read_poll_timeout functions
In-Reply-To: <20250811041039.3231548-3-fujita.tomonori@gmail.com>
References: <20250811041039.3231548-1-fujita.tomonori@gmail.com>
 <Iv9M9a9F8T9S94p9QgZ9kCFVfc3vMnCAzIx0RGc7nNZ7uZPDENFeH-lvGH6cXIn-DOoU0K-ccURCAgKm7d8aUQ==@protonmail.internalid>
 <20250811041039.3231548-3-fujita.tomonori@gmail.com>
Date: Mon, 11 Aug 2025 12:47:07 +0200
Message-ID: <87y0rqf844.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"FUJITA Tomonori" <fujita.tomonori@gmail.com> writes:

> Add read_poll_timeout functions which poll periodically until a
> condition is met or a timeout is reached.
>
> The C's read_poll_timeout (include/linux/iopoll.h) is a complicated
> macro and a simple wrapper for Rust doesn't work. So this implements
> the same functionality in Rust.
>
> The C version uses usleep_range() while the Rust version uses
> fsleep(), which uses the best sleep method so it works with spans that
> usleep_range() doesn't work nicely with.
>
> The sleep_before_read argument isn't supported since there is no user
> for now. It's rarely used in the C version.
>
> read_poll_timeout() can only be used in a nonatomic context. This
> requirement is not checked by these abstractions, but it is intended
> that klint [1] or a similar tool will be used to check it in the
> future.
>
> Link: https://rust-for-linux.com/klint [1]
> Reviewed-by: Fiona Behrens <me@kloenk.dev>
> Tested-by: Daniel Almeida <daniel.almeida@collabora.com>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

With the example removed:

-///
-/// ```rust
-/// use kernel::sync::{SpinLock, new_spinlock};
-/// use kernel::time::Delta;
-/// use kernel::time::poll::read_poll_timeout;
-///
-/// let lock = KBox::pin_init(new_spinlock!(()), kernel::alloc::flags::GFP_KERNEL)?;
-/// let g = lock.lock();
-/// read_poll_timeout(|| Ok(()), |()| true, Delta::from_micros(42), Some(Delta::from_micros(42)));
-/// drop(g);
-///
-/// # Ok::<(), Error>(())
-/// ```

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg



