Return-Path: <linux-kernel+bounces-767625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3531B256ED
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 00:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53C013B0178
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 22:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22D32FE58A;
	Wed, 13 Aug 2025 22:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SYWXDP9S"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0AA2FE07A
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 22:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755124990; cv=none; b=TM3AVkMgRga+aNwiMxsrNsRpCi76fKv5wwRJiRT01rrOgp6T6VTHLlAKTGulHTrME8JD39mlWXPzTgL0PWMCw43hmx1DH113btR4+F/Ve1KeymLaPVNkE/SJANjqcpshtjFh5k3a3rz/ps6MHJ5Elm8VBmgXwBni92fEsfJLswk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755124990; c=relaxed/simple;
	bh=+wzIYFm7HBgKwCOSy9EFwHPyfPxep0WgbIxkXPongsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Crni2oNA5agYj2XwFogHNLmBNEinpuduF8X3r+yk8oJHsLO5VF5/cLkpFrUnOqYHLn0yNxc+WXqvHkSDmnaROEOa5rgZ+1m/TIuh331NXLhh/rthvg61e4rOOiiKyngUkyF7/miwoubOjOd6Npcwavspned06H4sRKTUnNadzGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SYWXDP9S; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755124987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4a7oEyPNBxhjMx3DnT1g8ru/QEOUUr1PYi92/P1Icd4=;
	b=SYWXDP9SAZwLQ6xfgDWgiJDNIvC7JOjA1QlJiDs3JlKxNRibd45zWbO4iY/jHWvUTO9jpW
	oTNtsWkOR3bbgHREtY0fmapLyNA90j1oVHf7FvkN60VluzHDj3IS4AfJ/cokEJ0tygk/4I
	qRart8Ov4iUwTmwyOXa57nEqrRe9t0o=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-594-ln4xpe6XOmqlbmG8PSvtpA-1; Wed,
 13 Aug 2025 18:43:03 -0400
X-MC-Unique: ln4xpe6XOmqlbmG8PSvtpA-1
X-Mimecast-MFC-AGG-ID: ln4xpe6XOmqlbmG8PSvtpA_1755124981
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 128FD1956094;
	Wed, 13 Aug 2025 22:43:01 +0000 (UTC)
Received: from chopper.lan (unknown [10.22.64.13])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0B96630001A1;
	Wed, 13 Aug 2025 22:42:56 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	John Stultz <jstultz@google.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v7 2/7] rust: hrtimer: Add HrTimerInstant
Date: Wed, 13 Aug 2025 18:42:17 -0400
Message-ID: <20250813224240.3799325-3-lyude@redhat.com>
In-Reply-To: <20250813224240.3799325-1-lyude@redhat.com>
References: <20250813224240.3799325-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Since we want to add HrTimer methods that can accept Instants, we will want
to make sure that for each method we are using the correct Clocksource for
the given HrTimer. This would get a bit overly-verbose, so add a simple
HrTimerInstant type-alias to handle this for us.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 rust/kernel/time/hrtimer.rs | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
index 6bfc0223f4f57..be1bad4aacaad 100644
--- a/rust/kernel/time/hrtimer.rs
+++ b/rust/kernel/time/hrtimer.rs
@@ -72,6 +72,11 @@
 use core::marker::PhantomData;
 use pin_init::PinInit;
 
+/// A type-alias to refer to the [`Instant<C>`] for a given `T` from [`HrTimer<T>`].
+///
+/// Where `C` is the [`ClockSource`] of the [`HrTimer`].
+pub type HrTimerInstant<T> = Instant<<<T as HasHrTimer<T>>::TimerMode as HrTimerMode>::Clock>;
+
 /// A timer backed by a C `struct hrtimer`.
 ///
 /// # Invariants
-- 
2.50.0


