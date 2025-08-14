Return-Path: <linux-kernel+bounces-768668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC276B263DE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 13:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FC451BC6AEA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB11D2F9995;
	Thu, 14 Aug 2025 11:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="Gfa5p8wi"
Received: from forward502b.mail.yandex.net (forward502b.mail.yandex.net [178.154.239.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7612F39B0;
	Thu, 14 Aug 2025 11:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755170002; cv=none; b=BOEGkyILYI3dO71bhxUc45x3YzrsYlpkde3Cgw+hjjIccM/wDiQMa2XWke+wiqXJypOkl5zUIcknxNQZ4DmpPEOSOTUvJZ257ICFjY9ijK+9GghAWuMenI3M3qxvI3Rrb8+fi3izEaBzsXj1t61qTcKX7uEoMwl4KLsjXXkc/yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755170002; c=relaxed/simple;
	bh=QUf+e8mGFmp4R9iaiw2ffiP3FzPBz8aJfm7RNczEDuU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MrFCotHgvmQj36EmCiEqChh/zerqOVFFEIrpEn8zeFOzHz92LNEBB5Tcfs2OQM8zx+/4H7Xot2R9Hfto66gKMxWWrdNVxQUBUrnfMj19yjFoHYVqq++KgdfXWvo7FuOb14NC3920l3svDj+B99IzEPXWJ+xTZ0BKkU0nxt6j8J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=Gfa5p8wi; arc=none smtp.client-ip=178.154.239.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-58.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-58.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:8a87:0:640:e337:0])
	by forward502b.mail.yandex.net (Yandex) with ESMTPS id F394F814DD;
	Thu, 14 Aug 2025 14:13:09 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-58.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 4DKt3k5MjeA0-unGSD69d;
	Thu, 14 Aug 2025 14:13:08 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1755169989;
	bh=NKs0LY7puTyBVFgHxPIxQbuSVDg6IS5wnJAPQmXhHw8=;
	h=Cc:Message-ID:Subject:Date:References:To:From:In-Reply-To;
	b=Gfa5p8wiPBvDNSEbxyCKKpFH+/9b+0SZ4pISooJqs8YHHhA+zd+DgR1WJxNcPJZ4P
	 9qIJRu932Ux6jnQuxljl0xZ8jqTFvOKqSeFLYv7A98WHogzEfqcFvN38UQ7pywyAJ6
	 lLS5tasd+BFQDPG1Db0y8oa8S0U5N3v5FT/JSmQw=
Authentication-Results: mail-nwsmtp-smtp-production-main-58.iva.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
Date: Thu, 14 Aug 2025 14:13:02 +0300
From: Onur =?UTF-8?B?w5Z6a2Fu?= <work@onurozkan.dev>
To: "Benno Lossin" <lossin@kernel.org>
Cc: "Lyude Paul" <lyude@redhat.com>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <a.hindborg@kernel.org>, <aliceryhl@google.com>, <tmgross@umich.edu>,
 <dakr@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
 <will@kernel.org>, <longman@redhat.com>, <felipe_life@live.com>,
 <daniel@sedlak.dev>, <bjorn3_gh@protonmail.com>
Subject: Re: [PATCH v5 0/3] rust: add `ww_mutex` support
Message-ID: <20250814141302.1eabda12@nimda.home>
In-Reply-To: <DBVLEGFYBWKE.2RW8J853CJHTY@kernel.org>
References: <20250621184454.8354-1-work@onurozkan.dev>
	<20250724165351.509cff53@nimda.home>
	<ec32fc5f5a8658c084f96540bd41f5462fa5c182.camel@gmail.com>
	<20250806085702.5bf600a3@nimda.home>
	<539d3e0da773c32a42b4ab5c9d4aa90383481ff6.camel@redhat.com>
	<DBVLEGFYBWKE.2RW8J853CJHTY@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi all,

I have been brainstorming on the auto-unlocking (on dynamic number of
mutexes) idea we have been discussing for some time.

There is a challange with how we handle lock guards and my current
thought is to remove direct data dereferencing from guards. Instead,
data access would only be possible through a fallible method (e.g.,
`try_get`). If the guard is no longer valid, this method would fail to
not allow data-accessing after auto-unlock.

In practice, it would work like this:

	let a_guard = ctx.lock(mutex_a)?;
	let b_guard = ctx.lock(mutex_b)?;

	// Suppose user tries to lock `mutex_c` without aborting the
	// entire function (for some reason). This means that even on
	// failure, `a_guard` and `b_guard` will still be accessible.
	if let Ok(c_guard) = ctx.lock(mutex_c) {
    		// ...some logic
	}

	let a_data = a_guard.try_get()?;
	let b_data = b_guard.try_get()?;

If user wants to access the data protected by `a_guard` or `b_guard`,
they must call `try_get()`. This will only succeed if the guard is
still valid (i.e., it hasn't been automatically unlocked by a failed
`lock(mutex_c)` call due to `EDEADLK`). This way, data access after an
auto-unlock will be handled safely.

Any thoughts/suggestions?

Regards,
Onur

