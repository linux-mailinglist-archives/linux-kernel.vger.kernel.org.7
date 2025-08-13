Return-Path: <linux-kernel+bounces-767623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B596CB256E5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 00:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4232F1898858
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 22:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12AED2FE04B;
	Wed, 13 Aug 2025 22:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PBQxtPAy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0603C28B7D0
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 22:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755124985; cv=none; b=pY5iQYjgM5bZfF8UcdnH7r8nrvExQKUtewm839P0uGkCZKgX0Bhv6csV7RxoEWzhR/lgQ/si+atYJGHLa7Gn2UhZkO9MFTL0+tlI21gjBzmV6ALrZccTY5sjebi3x9gxaPbf6ngwpyWrggfAeYopl3Lf4eAhm/B5EdZCQsth9VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755124985; c=relaxed/simple;
	bh=cGzocKUoBI6UTn70F0nTaLrU4N7ktW3MYuKeH4Yf1cU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M1b9wywC60jZT9sEq3Cn8AP0dlK9INaZQlu9rYzbOE9hldqw6II92NMQj8E+KyqcwVoguhWxX0Aa0UnjmZ6PA8aJ0jFiwoIRk1LVfoTt6BuQCMkNI8EYxlNTzhZPqrb11IxacAkHJbuJ1L0VuYbLULfer348w2fuaQFZ/1YKAD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PBQxtPAy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755124977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TFcGwErUyOXtTf4B6AW+S39epG2JGx9NZxMwT4CcdiI=;
	b=PBQxtPAyszc7rpOu/r/MrBhXN+538X2Wr0E6EOwi6hrQHy13SQ5EopNUreP/OnYC66ulU0
	QCdDVSfGsorNjiA+yLh2O/F4gke8u1DesiQb/IRgM+8P9AE6keCzwlSac5uTtoIgAyzvQv
	I79oqieEKXB+yCa1wXWe7AG0MbA2gIA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-246-XoPSFZjAM7yeZ5-ioLctSQ-1; Wed,
 13 Aug 2025 18:42:54 -0400
X-MC-Unique: XoPSFZjAM7yeZ5-ioLctSQ-1
X-Mimecast-MFC-AGG-ID: XoPSFZjAM7yeZ5-ioLctSQ_1755124972
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E8F40180047F;
	Wed, 13 Aug 2025 22:42:51 +0000 (UTC)
Received: from chopper.lan (unknown [10.22.64.13])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B0BAE30001A1;
	Wed, 13 Aug 2025 22:42:48 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v7 0/7] rust/hrtimer: Various hrtimer + time additions
Date: Wed, 13 Aug 2025 18:42:15 -0400
Message-ID: <20250813224240.3799325-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

This is a collection of various bindings that I added to hrtimer when I
was originally getting it ready to be used in rvkms. I've mostly been
waiting for Andreas's hrtimer series to go upstream before submitting
these.

All of these are currently being used within rvkms for vblank emulation.

Previous versions:
  Version 1: https://lkml.org/lkml/2025/4/2/1474
  Version 2: https://lkml.org/lkml/2025/4/15/1750
  Version 3 (only a revision of one patch): https://lkml.org/lkml/2025/4/15/1780
  Version 4: https://lkml.org/lkml/2025/4/29/1715
  Version 5: https://lkml.org/lkml/2025/6/13/1785
  Version 6: https://lkml.org/lkml/2025/7/24/1390

Usage example:
 (keep in mind, I haven't rebased the example entirely - but the only
  differences there is a few comments)

  https://gitlab.freedesktop.org/lyudess/linux/-/tree/rvkms-slim/rust/kernel?ref_type=heads

Changelog down below

Lyude Paul (7):
  rust: hrtimer: Document the return value for HrTimerHandle::cancel()
  rust: hrtimer: Add HrTimerInstant
  rust: hrtimer: Add HrTimer::raw_forward() and forward()
  rust: hrtimer: Add HrTimerCallbackContext and ::forward()
  rust: hrtimer: Add forward_now() to HrTimer and HrTimerCallbackContext
  rust: time: Add Instant::from_nanos()
  rust: hrtimer: Add HrTimer::expires()

 rust/kernel/time.rs                 |  22 ++++
 rust/kernel/time/hrtimer.rs         | 152 +++++++++++++++++++++++++++-
 rust/kernel/time/hrtimer/arc.rs     |   9 +-
 rust/kernel/time/hrtimer/pin.rs     |   9 +-
 rust/kernel/time/hrtimer/pin_mut.rs |  12 ++-
 rust/kernel/time/hrtimer/tbox.rs    |   9 +-
 6 files changed, 204 insertions(+), 9 deletions(-)

Changelog:
  rust: hrtimer: Document the return value for HrTimerHandle::cancel()
    V4:
      * Reword to "Returns `true` if the timer was running."
  rust: hrtimer: Add HrTimerInstant
    V4:
      * Fix the safety contract for raw_forward()
      * Require Pin<&mut Self>, not &mut self
      * Drop incorrect UniquePin example
      * Rewrite documentation a bit (re: Andreas)
    V6:
      * Remove the reference to HrTimerCallbackContext::forward() until this
        function gets added.
    V7:
      * Split up Timer::forward() a bit, apply Andreas's SAFETY comment
        recommendations
  rust: hrtimer: Add HrTimer::raw_forward() and forward()
  rust: hrtimer: Add HrTimerCallbackContext and ::forward()
    V2:
      * Improve SAFETY comments for HrTimerCallbackContext uses (I forgot to
        mention that we're within RawHrTimerCallback::run()
      * Split forward into forward() and raw_forward() since we're going to have
        two contexts that we can call forward() from now.
      * Clarify contexts in which certain hrtimer methods can be called.
      * Make sure that we use a mutable reference for forward() here - just in
        case :).
      * Rename interval to duration
    V3:
      * Rename duration -back- to interval (now that I actually have read
        hrtimer_forward's source, interval does make more sense than duration
        considering the fact we return the number of overruns that occurred
        according to the given interval).
      * Rewrite documentation a bit (re: Andreas)
    V5:
      * Fix unbounded T on HrTimerCallbackContext
    V6:
      * Move reference to HrTimerCallbackContext::forward() in HrTimer::forward()
        comments into this commit so rustdoc doesn't fail.
      * Deduplicate documentation for HrTimerCallbackContext::forward()
      * Add missing changelog note

  rust: hrtimer: Add forward_now() to HrTimer and HrTimerCallbackContext
    V2:
      * Change from Ktime to Delta
      * Make sure that forward_now() takes a mutable reference to the timer
        struct
      * Reword this to point out that we're adding forward_now() to both callback
        context and mutable timer reference
      * Rename interval to duration
    V4:
      * Fix rust documentation for HrTimerCallbackContext (forgot to update both
        forward_now() declarations)
      * Use Pin<&mut Self> for context-less forward.
    V6:
      * Drop raw_cb_time(), use Instant::now() instead
      * Split out expires() from this patch, at some point it seems I mistakenly
        combined it with this patch
    V7:
      * Remove leftover comment about raw_cb_time from patch description

  rust: time: Add Instant::from_nanos()
    V4:
      * Turn from_nanos() into an unsafe function in order to ensure that we
        uphold the invariants of Instant
    V5:
      * Add debug_assert!() to from_nanos

  rust: hrtimer: Add HrTimer::expires()


base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
-- 
2.50.0


