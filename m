Return-Path: <linux-kernel+bounces-776461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F833B2CD9B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 22:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C028218851E5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 20:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C5B3431E9;
	Tue, 19 Aug 2025 20:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O3IHitd4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1120A341AB3
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 20:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755634441; cv=none; b=MkSLy+++BmO6IsJzAOY1Nz2nyr0zpOqs4jxvY+uKVHHkII+Kqihgo22/pY/6HqF3agKH+qiKbRTuacwPQAIkx0H/kxsJ3Z+J8VU1vx4gKHGLy2kxSAaudPHdRgiJdUHa3rJd2AU8tZvtfiXczp3tzZHrZj/y1eXft5ATs7gXJUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755634441; c=relaxed/simple;
	bh=+wzIYFm7HBgKwCOSy9EFwHPyfPxep0WgbIxkXPongsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KopulYq6Dc27sLHLjACoMgsVGWo3SJmJVUIkdc7VKGtxGK4V6Ggo8XvMSVf/RVH9OdK99nzOxMqnOMHKA7vuZhLi11L6zAcpiSJ8yg37hNdmgKWet5X4S1s8Z7xtWIzM9XdUEhRT7O/UQD2WFnXJIZQzCBkLRL2laP3CM9L9iic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O3IHitd4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755634439;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4a7oEyPNBxhjMx3DnT1g8ru/QEOUUr1PYi92/P1Icd4=;
	b=O3IHitd4zVW11blkt4+eXXvv8HmMB4mEBrcJCgULs9wQqejEw+VAeCLMJILpf8XZBafDjg
	NrbS7t6PpD9eESTls3SnRKzFp/apbfX3RUihnsY2mTxtJ1NRNXQxl7vF0/SG+tkGN83sTa
	TZapoMP39bVS3wrY/aKUDkuVyZOwdKY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663-uvItpLX5P5OW8SBA3YLgsQ-1; Tue,
 19 Aug 2025 16:13:55 -0400
X-MC-Unique: uvItpLX5P5OW8SBA3YLgsQ-1
X-Mimecast-MFC-AGG-ID: uvItpLX5P5OW8SBA3YLgsQ_1755634433
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 18998180035B;
	Tue, 19 Aug 2025 20:13:53 +0000 (UTC)
Received: from chopper.redhat.com (unknown [10.22.81.238])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1D14519560B2;
	Tue, 19 Aug 2025 20:13:48 +0000 (UTC)
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
Subject: [PATCH v8 2/7] rust: hrtimer: Add HrTimerInstant
Date: Tue, 19 Aug 2025 16:05:53 -0400
Message-ID: <20250819201334.545001-3-lyude@redhat.com>
In-Reply-To: <20250819201334.545001-1-lyude@redhat.com>
References: <20250819201334.545001-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

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


