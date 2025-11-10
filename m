Return-Path: <linux-kernel+bounces-892410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 87170C45083
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 06:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 290A93466A2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 05:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9BD2D738A;
	Mon, 10 Nov 2025 05:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="IzwP2xyK"
Received: from forward500a.mail.yandex.net (forward500a.mail.yandex.net [178.154.239.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6B525A2CF;
	Mon, 10 Nov 2025 05:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762753144; cv=none; b=ACJ8xa5po6NDsRLzzqv914d7xjN3rGtSw2qagGX1PY/aDN8qCVylWi62G0fIFEa9PcC4k75np70RkMgFPLEGmtenm1S62ze092wSq33HetDxc09F2YMF5e+oD0Ubcw+TPwyhfboRDoJniN0DVRB0EG1WD9LxaJAjyOqLS8eZo64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762753144; c=relaxed/simple;
	bh=E+Pm7pdDMh90+fF29fw6R0gB3tfpSocyxbkdzPQ9xP8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KavaGBAqQfV4yXm4xD76uW4GhAefLkXLv3mXxPKREibVoltIodRcrG6sXavMjFi9zRyNndYqetC1kj2IJKxroGfk7eUu2+7hp0OtfoD4nl4Mvjc7jtg9oEFcfmgcrUfj2Nc4mxfiz5XDDunw9CoV+7nHwAVB2NbxzMTk0MHyzVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=IzwP2xyK; arc=none smtp.client-ip=178.154.239.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-97.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-97.vla.yp-c.yandex.net [IPv6:2a02:6b8:c15:2804:0:640:a3ea:0])
	by forward500a.mail.yandex.net (Yandex) with ESMTPS id 3A840C8C09;
	Mon, 10 Nov 2025 08:28:24 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-97.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id HSFYr2nLPuQ0-UdKGMpmU;
	Mon, 10 Nov 2025 08:28:23 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1762752503;
	bh=biS8KNKz+z3Vv1nm/H1IA1VrosznGIxigi0eXn5deAo=;
	h=Cc:Message-ID:Subject:Date:References:To:From:In-Reply-To;
	b=IzwP2xyKy5gssoJPwzMCN5TWdI+xyp3AgAJJ5dKlu3IBwScHbIQNq+teoddVmpTX1
	 /u/6m9ikiV1HtfnDuBReBZYfrQL+E8YSAy3rbKKqGYA7FwPrb64sXt64uOBlsJJr95
	 jYWSH52/RMDU1laj69gII91nB2UF1UWh39opi2+0=
Authentication-Results: mail-nwsmtp-smtp-production-main-97.vla.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
Date: Mon, 10 Nov 2025 08:28:14 +0300
From: Onur =?UTF-8?B?w5Z6a2Fu?= <work@onurozkan.dev>
To: rust-for-linux@vger.kernel.org
Cc: lossin@kernel.org, lyude@redhat.com, ojeda@kernel.org,
 alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
 a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
 dakr@kernel.org, peterz@infradead.org, mingo@redhat.com, will@kernel.org,
 longman@redhat.com, felipe_life@live.com, daniel@sedlak.dev,
 bjorn3_gh@protonmail.com, daniel.almeida@collabora.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/6] rust: add `ww_mutex` support
Message-ID: <20251110082814.428ead91@nimda.home>
In-Reply-To: <20251101161056.22408-1-work@onurozkan.dev>
References: <20251101161056.22408-1-work@onurozkan.dev>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat,  1 Nov 2025 19:10:50 +0300
Onur =C3=96zkan <work@onurozkan.dev> wrote:

> Changes in v7:
>   - Split Class and AcquireCtx into separate modules.
>   - Removed "Ww" prefixes from type names.
>   - Renamed exec.rs -> lock_set.rs and ExecContext -> LockSet.
>   - Removed transmute logic from LockSet (formerly ExecContext).
>   - Improved various doc-comments.
>   - Marked certain AcquireCtx functions as unsafe.
>   - Added from_raw constructors for Mutex, MutexGuard, AcquireCtx
>     and Class.
>   - LockSet::cleanup_on_deadlock no longer triggers reallocations when
>     reinitializing AcquireCtx.
>   - Incorporated various minor improvements suggested on the v6
> series.
>=20
> Changes in v6:
>   - Added `unpinned_new` constructor for `WwClass` and updated
>     global macros.
>   - Changed all tests (and docs) to use Arc/KBox instead of
>     `stack_pin_init` for `WwMutex` and `WwAcquireCtx`.
>   - Added `LockKind` and `lock_common` helper to unify locking logic.
>   - Added context-based and context-free locking functions for
> `WwMutex`.
>   - Added `ww_mutex/exec` module, a high-level API with auto `EDEADLK`
>     handling mechanism.
>=20
> Changes in v5:
>   - Addressed documentation review notes.
>   - Removed `unwrap()`s in examples and KUnit tests.
>=20
> Onur =C3=96zkan (6):
>   rust: add C wrappers for ww_mutex inline functions
>   rust: implement `Class` for ww_class support
>   rust: error: add EDEADLK
>   rust: ww_mutex: add Mutex, AcquireCtx and MutexGuard
>   rust: ww_mutex: implement LockSet
>   rust: add test coverage for ww_mutex implementation
>=20
>  MAINTAINERS                                   |   1 +
>  rust/helpers/helpers.c                        |   1 +
>  rust/helpers/ww_mutex.c                       |  39 ++
>  rust/kernel/error.rs                          |   1 +
>  rust/kernel/sync/lock.rs                      |   1 +
>  rust/kernel/sync/lock/ww_mutex.rs             | 440
> ++++++++++++++++++ rust/kernel/sync/lock/ww_mutex/acquire_ctx.rs |
> 211 +++++++++ rust/kernel/sync/lock/ww_mutex/class.rs       | 156
> +++++++ rust/kernel/sync/lock/ww_mutex/lock_set.rs    | 410
> ++++++++++++++++ 9 files changed, 1260 insertions(+)
>  create mode 100644 rust/helpers/ww_mutex.c
>  create mode 100644 rust/kernel/sync/lock/ww_mutex.rs
>  create mode 100644 rust/kernel/sync/lock/ww_mutex/acquire_ctx.rs
>  create mode 100644 rust/kernel/sync/lock/ww_mutex/class.rs
>  create mode 100644 rust/kernel/sync/lock/ww_mutex/lock_set.rs
>=20

I forgot to include the Zulip discussion link [1], which I believe
would be quite useful. I am adding this as a self-review note to make
sure I include it in the next version.

[1]:
https://rust-for-linux.zulipchat.com/#narrow/stream/x/topic/x/near/547854930


Regards,
Onur

