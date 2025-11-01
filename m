Return-Path: <linux-kernel+bounces-881400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE6CC28230
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 17:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA182402059
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 16:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCA12FABE0;
	Sat,  1 Nov 2025 16:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="ORm5ffeJ"
Received: from forward100d.mail.yandex.net (forward100d.mail.yandex.net [178.154.239.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917A21EB19B;
	Sat,  1 Nov 2025 16:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762013478; cv=none; b=uHHCWJxsKttVwxIZ5gvOJmJu+AL/bZMVMzQMDzAIAOmCkewbbM/1JP6SVJl1rihCjvGcjJ4TQYcag2HggcP8rh21FJUwXFczMqFRBLsjeCfXIDctcVdRwSSCb69O35GZ4H6JClO174Bd2RrUh3k9GFQlSQNuY7oCP11kdvbCXoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762013478; c=relaxed/simple;
	bh=8iv9mQOsZo6OLK7PUBXqyFLWyIo/exM7gNteX7q7VYA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MP3LyXzSiQOIwLfsyUgz+TlUZaQMGXjMHBE0GlarrwX/eHfitk0LD81cTOJe2W589+8hn20uebMupkh1wGQitLew8it3P12P+TqbqvbJ+ztOZoC4WWPRLa7MwcRKYHJHBM0k0SwlvuQmEi3mICwxxjrEmdCECi0yqpqB28NtnZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=ORm5ffeJ; arc=none smtp.client-ip=178.154.239.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:d7c6:0:640:5e67:0])
	by forward100d.mail.yandex.net (Yandex) with ESMTPS id 497F1C0059;
	Sat, 01 Nov 2025 19:11:05 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id wAkixRhLDOs0-zba0L8m8;
	Sat, 01 Nov 2025 19:11:03 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1762013464;
	bh=8h+sw0hkyjue3/fDsR99X2njFvpM+5NSUCq7J0G0Cf0=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=ORm5ffeJpPO0RilvYhjd6yVOvueWsxVhZtBssDELAuQHL4dnGMYLNumNIO+22YzC4
	 cw6jR8xGufQVDXjY4EYhipBewmKEjYnAj4BdXqc8UHGEGugu31/AZO2Lg3qRLYT+jD
	 RvwLEHrU98XriBLOn1/QiRffmwB33EYUDVatnKeo=
Authentication-Results: mail-nwsmtp-smtp-production-main-99.klg.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: rust-for-linux@vger.kernel.org
Cc: lossin@kernel.org,
	lyude@redhat.com,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	peterz@infradead.org,
	mingo@redhat.com,
	will@kernel.org,
	longman@redhat.com,
	felipe_life@live.com,
	daniel@sedlak.dev,
	bjorn3_gh@protonmail.com,
	daniel.almeida@collabora.com,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
Subject: [PATCH v7 0/6] rust: add `ww_mutex` support
Date: Sat,  1 Nov 2025 19:10:50 +0300
Message-ID: <20251101161056.22408-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Changes in v7:
  - Split Class and AcquireCtx into separate modules.
  - Removed "Ww" prefixes from type names.
  - Renamed exec.rs -> lock_set.rs and ExecContext -> LockSet.
  - Removed transmute logic from LockSet (formerly ExecContext).
  - Improved various doc-comments.
  - Marked certain AcquireCtx functions as unsafe.
  - Added from_raw constructors for Mutex, MutexGuard, AcquireCtx
    and Class.
  - LockSet::cleanup_on_deadlock no longer triggers reallocations when
    reinitializing AcquireCtx.
  - Incorporated various minor improvements suggested on the v6 series.

Changes in v6:
  - Added `unpinned_new` constructor for `WwClass` and updated
    global macros.
  - Changed all tests (and docs) to use Arc/KBox instead of
    `stack_pin_init` for `WwMutex` and `WwAcquireCtx`.
  - Added `LockKind` and `lock_common` helper to unify locking logic.
  - Added context-based and context-free locking functions for `WwMutex`.
  - Added `ww_mutex/exec` module, a high-level API with auto `EDEADLK`
    handling mechanism.

Changes in v5:
  - Addressed documentation review notes.
  - Removed `unwrap()`s in examples and KUnit tests.

Onur Özkan (6):
  rust: add C wrappers for ww_mutex inline functions
  rust: implement `Class` for ww_class support
  rust: error: add EDEADLK
  rust: ww_mutex: add Mutex, AcquireCtx and MutexGuard
  rust: ww_mutex: implement LockSet
  rust: add test coverage for ww_mutex implementation

 MAINTAINERS                                   |   1 +
 rust/helpers/helpers.c                        |   1 +
 rust/helpers/ww_mutex.c                       |  39 ++
 rust/kernel/error.rs                          |   1 +
 rust/kernel/sync/lock.rs                      |   1 +
 rust/kernel/sync/lock/ww_mutex.rs             | 440 ++++++++++++++++++
 rust/kernel/sync/lock/ww_mutex/acquire_ctx.rs | 211 +++++++++
 rust/kernel/sync/lock/ww_mutex/class.rs       | 156 +++++++
 rust/kernel/sync/lock/ww_mutex/lock_set.rs    | 410 ++++++++++++++++
 9 files changed, 1260 insertions(+)
 create mode 100644 rust/helpers/ww_mutex.c
 create mode 100644 rust/kernel/sync/lock/ww_mutex.rs
 create mode 100644 rust/kernel/sync/lock/ww_mutex/acquire_ctx.rs
 create mode 100644 rust/kernel/sync/lock/ww_mutex/class.rs
 create mode 100644 rust/kernel/sync/lock/ww_mutex/lock_set.rs

-- 
2.51.2


