Return-Path: <linux-kernel+bounces-798646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F98BB420B2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F6A318823D2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 13:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC293019DA;
	Wed,  3 Sep 2025 13:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="m4Bn+KQM"
Received: from forward103a.mail.yandex.net (forward103a.mail.yandex.net [178.154.239.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82323FB31;
	Wed,  3 Sep 2025 13:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756905222; cv=none; b=YQMo0oVH4pnIrCEVWuZn8A6GWbE4UtHMlVW4p+qJmxcCEhhvoYx/tcwnBfyGygRJ4hUB2OP623vgM+2vx+WERYFHMYPokZLT/vCtdo+Fy2EbH1dBIUVsSLmpiBA8gYPcrff6V7OxIUOJJlYs+BtmAPhdieCK+gGLfA7ojo7qM7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756905222; c=relaxed/simple;
	bh=A6IBELFMIkON13x71SnqD06RwJqzmAMG+IDrm21Y/q0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rLCEJZDbNIpyRP6r3fvvbPJWAmFVOeTLqtgXjmPgnqrAVT6akJ7DsZAMaUmRDDpY3KJoFJ0IInAhU4mxoC8y8Iflw/pqPGafPkBP9st4sMYAahcsXSLzit4wdsOrWJvndAqveXgK1RkdvqSfQSBK0cDTyk9Y9z7PIb6fqs9WLt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=m4Bn+KQM; arc=none smtp.client-ip=178.154.239.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-60.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-60.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1d:3e17:0:640:f9aa:0])
	by forward103a.mail.yandex.net (Yandex) with ESMTPS id DCAA88066B;
	Wed, 03 Sep 2025 16:13:29 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-60.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id GDgKkBDMquQ0-Fm20CmGx;
	Wed, 03 Sep 2025 16:13:29 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1756905209;
	bh=bfOdb4jdKNyizplAoWR9Y0B8m9L2RT3NJd+kGdGO29Q=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=m4Bn+KQMnJIWtvQ7agSMSGcR4MJFaMzhhHoR2bLoiPVGZG50vvUpPa+BtW3UPHl0p
	 rPVVoHKkWmKrrOEHGhwBVJn9PX4VP1QxuP5aYvQ4rZT12g5GMWjM5XiAYHv4NsDol4
	 g/tdoVrFdIQsXojEz0Z9RRwEylq7++aenimhNr/o=
Authentication-Results: mail-nwsmtp-smtp-production-main-60.vla.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: rust-for-linux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	lossin@kernel.org,
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
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
Subject: [PATCH v6 0/7] rust: add `ww_mutex` support
Date: Wed,  3 Sep 2025 16:13:06 +0300
Message-ID: <20250903131313.4365-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Changes made in v6:
  - Added `unpinned_new` constructor for `WwClass` and updated global macros.
  - Changed all tests (and docs) to use Arc/KBox instead of `stack_pin_init`
    for `WwMutex` and `WwAcquireCtx`.
  - Added `LockKind` and `lock_common` helper to unify locking logic.
  - Added context-based and context-free locking functions for `WwMutex`.
  - Added `ww_mutex/exec` module, a high-level API with auto `EDEADLK`
    handling mechanism.

Onur Özkan (7):
  rust: add C wrappers for ww_mutex inline functions
  rust: implement `WwClass` for ww_mutex support
  rust: implement `WwMutex`, `WwAcquireCtx` and `WwMutexGuard`
  add KUnit coverage on Rust ww_mutex implementation
  rust: ww_mutex: add context-free locking functions
  rust: ww_mutex/exec: add high-level API
  add KUnit coverage on ww_mutex/exec implementation

 rust/helpers/helpers.c                 |   1 +
 rust/helpers/ww_mutex.c                |  39 ++
 rust/kernel/error.rs                   |   1 +
 rust/kernel/sync/lock.rs               |   1 +
 rust/kernel/sync/lock/ww_mutex.rs      | 634 +++++++++++++++++++++++++
 rust/kernel/sync/lock/ww_mutex/exec.rs | 324 +++++++++++++
 6 files changed, 1000 insertions(+)
 create mode 100644 rust/helpers/ww_mutex.c
 create mode 100644 rust/kernel/sync/lock/ww_mutex.rs
 create mode 100644 rust/kernel/sync/lock/ww_mutex/exec.rs

--
2.50.0


