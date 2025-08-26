Return-Path: <linux-kernel+bounces-786359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03977B358D4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 11:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BAB220265B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 09:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D6B30E83B;
	Tue, 26 Aug 2025 09:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WcSqqbhV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11884309DB0;
	Tue, 26 Aug 2025 09:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756200383; cv=none; b=Z4sFZzgD8HuhnEp6wxb9F9nwbNJSmaW/Tn17pQ1FYmPXMMQymisBy6xIY3Ls+BRVMO8geJWjO3k+xp6/wJ8dLOcEggX7WDKusXNb48ssyrNr9x4E6X6TwSDDJJJXpwZECg5bPkjv0zhHIrxjBDUqnGwUj8KlkfYJlTvUOq9agjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756200383; c=relaxed/simple;
	bh=Bkt8fJuWzROj7pPEelF2AAHUdhHQsBURguKd2y6Qf50=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A+q0UGYuVhB56uBttW5E12UTGFuRlaGkdLiQ21awkyWV7xBHt5tYIhISat3hoNfY4vdLcgeWHjqlBOeZQ/ezrMUR2IJVE9BiGtFquVeFZdFmEFL2ftF6bRVJPWm7uSEyL9z1s5zXNHwMbE0YkcMziQJ7KPPI2cdTXjFWxuqh9dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WcSqqbhV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C3A7C4CEF4;
	Tue, 26 Aug 2025 09:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756200381;
	bh=Bkt8fJuWzROj7pPEelF2AAHUdhHQsBURguKd2y6Qf50=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=WcSqqbhVLuzmRaJP1n8QJOC4xhWTw0aD50ie0WLIEDq/MzDwD6QiqwqIlumcpfJwQ
	 lqNGtS3ekBLw8dd8BSQL5i5H0p7XMJrnkDK/QlHWeqS8JP/UbI3cpUnPLgP5XzSC69
	 bMNCbLV8jkkbSk2DL1+934X++jb+knndKUGdPiw/98AtF+JuBYYaAiNzRa7NbF1QZw
	 tauMUIJPSvOb+3pOS05KEhlwyX1edI9GGJcrOhCtaXvRm0YAaeU1SsM7ITYoYJNZmn
	 Lbc+gLyBqBxw2dbrt6MlcbllY0/UL4HT9qSkeZNWa15ve8ZTRW5C1pHXZZEOpcXHhX
	 7e315v8aUh/2g==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Lyude Paul <lyude@redhat.com>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, FUJITA
 Tomonori <fujita.tomonori@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Frederic Weisbecker
 <frederic@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, John
 Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda
 <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo
 <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno
 Lossin <lossin@kernel.org>, Alice
 Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo
 Krummrich <dakr@kernel.org>
Subject: Re: [PATCH v3 2/2] rust: time: Implement basic arithmetic
 operations for Delta
In-Reply-To: <20250820203704.731588-3-lyude@redhat.com>
References: <20250820203704.731588-1-lyude@redhat.com>
 <s9fREpnlAH3Va4eMIXOjl8RlMjCout3IAKF0312rfm4wug7MABy8q5aZPAdCMRL-LmMmuB-vcAcMRpLcz-MrNQ==@protonmail.internalid>
 <20250820203704.731588-3-lyude@redhat.com>
Date: Tue, 26 Aug 2025 11:26:07 +0200
Message-ID: <875xeawi1c.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Lyude Paul" <lyude@redhat.com> writes:

> While rvkms is only going to be using a few of these, since Deltas are
> basically the same as i64 it's easy enough to just implement all of the
> basic arithmetic operations for Delta types.
>
> Keep in mind there's one quirk here - the kernel has no support for
> i64 % i64 on 32 bit platforms, the closest we have is i64 % i32 through
> div_s64_rem(). So, instead of implementing ops::Rem or ops::RemAssign we
> simply provide Delta::rem_nanos().
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg




