Return-Path: <linux-kernel+bounces-776459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9245AB2CD93
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 22:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4D067AD819
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 20:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC42131E113;
	Tue, 19 Aug 2025 20:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jCoVG/Ak"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C11231CA58
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 20:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755634435; cv=none; b=avbW0nJSc3HksKzwpbhASZ9qa4qOMKoqEKhgZuhD00/XNbpebrvLMnp43DYJlymVnIsnlYmb7KtnItp3V8Faj9rk3mk26UjkSCP0ui9dAVEeXuLGP90ZEUAs6x0lpqVPmoqxjKZ7rnKlnNZluNlMRemBXxPnHhQBf5OsZ2x2cRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755634435; c=relaxed/simple;
	bh=oUB4DEbHVfGCxLKhy6eY2WGpnvHRUMmCcLkpLpK4IXw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UHUNwhvNPLfaW4Ykkl/qFm2q2pX7OS0/5Ck5MeptKuANo2Y9xFsuW2cF8xza3lN4BGxamUGFElGeaVbSEh9iDYq4R/shjImxe1uIKuGgZqTbiD6Obg94K6/yj6JwsGaTKBqZuOchPnWwbnK263cH5I64uB/4tMJzg+Eph/tvHeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jCoVG/Ak; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755634432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YTxKzBWu7SwzckRCjBEU4GBcVb2m5Sem0nJkx5cVRm0=;
	b=jCoVG/Ak8Zi7C2Uehz0gOyjbFuGeXJZaZchnvV6+CDUhfgp92InD7kCNjxjj6iyuwjq8qZ
	u+E40q9qe4dBTRA4uW07vWAhcX07nUeluUNk6sCkllR1d0Yb7+Ak8J/0yEuLY4O9NL7gHO
	Vu74tGQ1o4fLcIKwPgwOGZjGeIPNZGI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-454-Xg9qKt8TM9qIEhRj-grsGA-1; Tue,
 19 Aug 2025 16:13:46 -0400
X-MC-Unique: Xg9qKt8TM9qIEhRj-grsGA-1
X-Mimecast-MFC-AGG-ID: Xg9qKt8TM9qIEhRj-grsGA_1755634424
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E43CA1800345;
	Tue, 19 Aug 2025 20:13:43 +0000 (UTC)
Received: from chopper.redhat.com (unknown [10.22.81.238])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B088E19560B0;
	Tue, 19 Aug 2025 20:13:40 +0000 (UTC)
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
Subject: [PATCH v8 0/7] rust/hrtimer: Various hrtimer + time additions
Date: Tue, 19 Aug 2025 16:05:51 -0400
Message-ID: <20250819201334.545001-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

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
  Version 7: https://lkml.org/lkml/2025/8/13/1875

Usage example:
 (keep in mind, I haven't rebased the example entirely - but the only
  differences there is a few comments)

  https://gitlab.freedesktop.org/lyudess/linux/-/tree/rvkms-slim/rust/kernel?ref_type=heads

Lyude Paul (7):
  rust: hrtimer: Document the return value for HrTimerHandle::cancel()
  rust: hrtimer: Add HrTimerInstant
  rust: hrtimer: Add HrTimer::raw_forward() and forward()
  rust: hrtimer: Add HrTimerCallbackContext and ::forward()
  rust: hrtimer: Add forward_now() to HrTimer and HrTimerCallbackContext
  rust: time: Add Instant::from_ktime()
  rust: hrtimer: Add HrTimer::expires()

Patches changed since V7:

  rust: hrtimer: Add HrTimer::expires()
    (needs re-review!)
  rust: time: Add Instant::from_ktime()
    (needs re-review!)

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

  rust: time: Add Instant::from_ktime()
    V4:
      * Turn from_nanos() into an unsafe function in order to ensure that we
        uphold the invariants of Instant
    V5:
      * Add debug_assert!() to from_nanos
    V8:
      * Change name of function from Instant::from_nanos() to
        Instant::from_ktime()

  rust: hrtimer: Add HrTimer::expires()
    V8:
      * Fix bogus safety comment I noticed after Fujita's comments. In expires()
        we're not guaranteed to get a non-negative ktime_t because of ktime_t
        itself, we're guaranteed to get one because a negative expiration time
        for a timer doesn't make sense.

 rust/kernel/time.rs                 |  22 ++++
 rust/kernel/time/hrtimer.rs         | 152 +++++++++++++++++++++++++++-
 rust/kernel/time/hrtimer/arc.rs     |   9 +-
 rust/kernel/time/hrtimer/pin.rs     |   9 +-
 rust/kernel/time/hrtimer/pin_mut.rs |  12 ++-
 rust/kernel/time/hrtimer/tbox.rs    |   9 +-
 6 files changed, 204 insertions(+), 9 deletions(-)


base-commit: c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9
-- 
2.50.0


