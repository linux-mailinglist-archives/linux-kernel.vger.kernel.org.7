Return-Path: <linux-kernel+bounces-850968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A99D4BD4D16
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 18:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 30C99350C78
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 16:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E9E30EF7C;
	Mon, 13 Oct 2025 15:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UoViahLk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868EC30C349
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 15:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760370874; cv=none; b=YY8d7IRIZPvPJmQaanByxwfk8Kc4A6ZmpyiAYXkSFO1OPrnrsQNHYzxRP7Kl1VvoupvzwuhV9Fjla3zxaA1sKrZPWnXUtLgcTbPbY6GiBa1gaP4+ukBq0C0FmSSVYoHpWBGVjybtIwq6AbyOUIH6fADpB1pAwRf0yUN6sHgpJ2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760370874; c=relaxed/simple;
	bh=foIGyWrqMyymH0NNnQeXIY5UOAZIW9xQsIxg3P+q67k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aX0ReKyrpO1cWZldE6z8FjcWUla9NLfWmrqbE/S0QKHQGAX4I3sTLEEJsiqUlqo34MwoaEjk1/AZFk5kNR20ceLmAdICr/E5BaHT2jXYBn3yUf+dEArMVmMvw3jN5L3eQLD/2C2vPQMvOm12Rm8yQ4B1yr/GQvBW361aosLag7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UoViahLk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760370871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HJhEp2LAGRhkIca8lz9vxyIiHP8wRjw4VX8WQB4u9HM=;
	b=UoViahLkOXBBHd84tFpD01sU7SrxEYdaO36eHgNa8NiJ822SJF6Kr3gGZ8FBVnoKpyF2tb
	SxzAL1vbZ+XbhgHua7wcgpjDpr8wIS9Qti2w42pBFJJ7QHg9bzKi9dVwKRN++s3uzLluU9
	D1tQCC1xYbHGKu3+G/J/mUAFzSGjF/E=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-282-RvvP-grKMACg6WajSGWUOg-1; Mon,
 13 Oct 2025 11:54:28 -0400
X-MC-Unique: RvvP-grKMACg6WajSGWUOg-1
X-Mimecast-MFC-AGG-ID: RvvP-grKMACg6WajSGWUOg_1760370866
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B611B1800451;
	Mon, 13 Oct 2025 15:54:25 +0000 (UTC)
Received: from chopper.lan (unknown [10.22.81.1])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 054803000384;
	Mon, 13 Oct 2025 15:54:21 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: rust-for-linux@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Boqun Feng <boqun.feng@gmail.com>,
	linux-kernel@vger.kernel.org,
	Daniel Almeida <daniel.almeida@collabora.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v13 08/17] rust: helper: Add spin_{un,}lock_irq_{enable,disable}() helpers
Date: Mon, 13 Oct 2025 11:48:10 -0400
Message-ID: <20251013155205.2004838-9-lyude@redhat.com>
In-Reply-To: <20251013155205.2004838-1-lyude@redhat.com>
References: <20251013155205.2004838-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

From: Boqun Feng <boqun.feng@gmail.com>

spin_lock_irq_disable() and spin_unlock_irq_enable() are inline
functions, to use them in Rust, helpers are introduced. This is for
interrupt disabling lock abstraction in Rust.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 rust/helpers/spinlock.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/rust/helpers/spinlock.c b/rust/helpers/spinlock.c
index 42c4bf01a23e4..d4e61057c2a7a 100644
--- a/rust/helpers/spinlock.c
+++ b/rust/helpers/spinlock.c
@@ -35,3 +35,18 @@ void rust_helper_spin_assert_is_held(spinlock_t *lock)
 {
 	lockdep_assert_held(lock);
 }
+
+void rust_helper_spin_lock_irq_disable(spinlock_t *lock)
+{
+	spin_lock_irq_disable(lock);
+}
+
+void rust_helper_spin_unlock_irq_enable(spinlock_t *lock)
+{
+	spin_unlock_irq_enable(lock);
+}
+
+int rust_helper_spin_trylock_irq_disable(spinlock_t *lock)
+{
+	return spin_trylock_irq_disable(lock);
+}
-- 
2.51.0


