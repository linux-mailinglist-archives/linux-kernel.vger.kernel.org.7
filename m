Return-Path: <linux-kernel+bounces-857289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA80BE66C1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 07:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9812C4F4AB9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 05:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41AC21FF49;
	Fri, 17 Oct 2025 05:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="Muf2OWsw"
Received: from forward501d.mail.yandex.net (forward501d.mail.yandex.net [178.154.239.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12404334686;
	Fri, 17 Oct 2025 05:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760679075; cv=none; b=jE10EKIvFqAKqIncgDYMaJAPOOTD3Ls1ghz0pyzQpBLrKXjoGKDnYdQL3JPYwWIceFLqE8AkDNzcq+gy38/PrSGqnzRTug6dOmEhfGAzEqatTjMj/9J+qg3NFZl1En+GWiwgn5YAmgxAqPRB1gFpljx6ZeNvPFO5vgnuGkthDQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760679075; c=relaxed/simple;
	bh=zurkQXd73iOxFPNlY28GMQwOUwVAyJh3YsqSeKinVBI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZoC9X/fOGMvBWHBhwV6ToC5Cg36s0c3DZRaCCbt+7qRN3gdBTa3FN/RFMJ6P3sCLRBo9eMG6c9xXf3TykYv0AvZAd8a6QB+wWjJNNHpTYJ/XLtER2lHzZw5ATgJaQsfe4VA6r1kCZ8vWXHpGkOVLtbQ8DWSBs2cnciQ7A7JCZSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=Muf2OWsw; arc=none smtp.client-ip=178.154.239.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-94.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-94.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:2646:0:640:add0:0])
	by forward501d.mail.yandex.net (Yandex) with ESMTPS id A66B3817AB;
	Fri, 17 Oct 2025 08:03:42 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-94.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id Z3KcDv4LxuQ0-zG6YubSH;
	Fri, 17 Oct 2025 08:03:41 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1760677421;
	bh=N/70zilmjWSlGxxVYOa75HnCzjr/K5vl/WtNoIkvemo=;
	h=Cc:Message-ID:Subject:Date:References:To:From:In-Reply-To;
	b=Muf2OWswgGlQONxbsKtucbK1BulemXI0oCIGb18Z/89xVDec2mWLcfjEBm4RGsblF
	 sMsPMu6cszUNRpQNn/pEmfnDVpjynHzVksLhp65DGY/wzpdm3R/gRJ7yrhVnxysuEf
	 zadvgye9ZsGva8nPffL83F5+SRowD9zRvwGtOqDQ=
Authentication-Results: mail-nwsmtp-smtp-production-main-94.klg.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
Date: Fri, 17 Oct 2025 08:03:32 +0300
From: Onur =?UTF-8?B?w5Z6a2Fu?= <work@onurozkan.dev>
To: Lyude Paul <lyude@redhat.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 lossin@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com,
 boqun.feng@gmail.com, gary@garyguo.net, a.hindborg@kernel.org,
 aliceryhl@google.com, tmgross@umich.edu, dakr@kernel.org,
 peterz@infradead.org, mingo@redhat.com, will@kernel.org,
 longman@redhat.com, felipe_life@live.com, daniel@sedlak.dev,
 bjorn3_gh@protonmail.com, daniel.almeida@collabora.com
Subject: Re: [PATCH v6 0/7] rust: add `ww_mutex` support
Message-ID: <20251017080332.121c65a5@nimda.home>
In-Reply-To: <132e722c81391a7b99e340404374b5903a4759c3.camel@redhat.com>
References: <20250903131313.4365-1-work@onurozkan.dev>
	<132e722c81391a7b99e340404374b5903a4759c3.camel@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 16 Oct 2025 15:47:09 -0400
Lyude Paul <lyude@redhat.com> wrote:

> Hi! One thing I realized I forgot to ask the last time I reviewed
> this: one of the things that seems to be missing is the ability to
> use this API with locks and lock-acquisition mechanisms that already
> exist on the C side of the kernel.
>=20
> I think the simplest equivalent to this I can point to is how we have:
>=20
>  * Mutex::from_raw() (but only when the type protected by the mutex
> is () )
>  * Guard::from_raw()
>=20
> For ww mutexes we should have both of these as well, and also
> ::from_raw() for WwAcquireCtx. This being said - as far as I can
> tell, it doesn't look like it would be a big change for this series
> at all.

Sounds doable, I will make sure to include them in the next version
which I will be working on pretty soon. I couldn't allocate enough time
to work on this due to other priorities.

>=20
> Also - thank you for the work so far :)

My pleasure :)

-Onur

>=20
> On Wed, 2025-09-03 at 16:13 +0300, Onur =C3=96zkan wrote:
> > Changes made in v6:
> >   - Added `unpinned_new` constructor for `WwClass` and updated
> > global macros.
> >   - Changed all tests (and docs) to use Arc/KBox instead of
> > `stack_pin_init` for `WwMutex` and `WwAcquireCtx`.
> >   - Added `LockKind` and `lock_common` helper to unify locking
> > logic.
> >   - Added context-based and context-free locking functions for
> > `WwMutex`.
> >   - Added `ww_mutex/exec` module, a high-level API with auto
> > `EDEADLK` handling mechanism.
> >=20
> > Onur =C3=96zkan (7):
> >   rust: add C wrappers for ww_mutex inline functions
> >   rust: implement `WwClass` for ww_mutex support
> >   rust: implement `WwMutex`, `WwAcquireCtx` and `WwMutexGuard`
> >   add KUnit coverage on Rust ww_mutex implementation
> >   rust: ww_mutex: add context-free locking functions
> >   rust: ww_mutex/exec: add high-level API
> >   add KUnit coverage on ww_mutex/exec implementation
> >=20
> >  rust/helpers/helpers.c                 |   1 +
> >  rust/helpers/ww_mutex.c                |  39 ++
> >  rust/kernel/error.rs                   |   1 +
> >  rust/kernel/sync/lock.rs               |   1 +
> >  rust/kernel/sync/lock/ww_mutex.rs      | 634
> > +++++++++++++++++++++++++ rust/kernel/sync/lock/ww_mutex/exec.rs |
> > 324 +++++++++++++ 6 files changed, 1000 insertions(+)
> >  create mode 100644 rust/helpers/ww_mutex.c
> >  create mode 100644 rust/kernel/sync/lock/ww_mutex.rs
> >  create mode 100644 rust/kernel/sync/lock/ww_mutex/exec.rs
> >=20
> > --
> > 2.50.0
>=20


