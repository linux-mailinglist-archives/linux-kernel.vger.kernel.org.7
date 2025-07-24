Return-Path: <linux-kernel+bounces-744808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCECB11131
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 20:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 368835A2913
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 18:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C39224228;
	Thu, 24 Jul 2025 18:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dOhTcOUk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9ACF2135AD
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 18:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753383174; cv=none; b=IPJCwtfBT0s8dpytA6DB3qp/+0bYpMUo22iNc08NI5oa+TZeED1N/XMOZYz33/mV8BdmYBEgItEdDcj3S1zD6RquTtZsQ6Ew8txysGMHOAqy0+cp1Wdyjmo1kQ7GoX07QLVyiVue4SlJByHlGMIeyOZQvBc7pXXYlcLsFGbDt58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753383174; c=relaxed/simple;
	bh=Mc3rWMMaytq+BMv7z9nIj4IY5sYmoN610zORz4cBroo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UNAL7hc6VAl3vjkxx5l1ds8q7GngrbcAXPbbzOEGWy58KZ53Akp6Hc7SC5CRAsIglLQWmgqfyHi1BH1EuY5YVpD0tn/bKhvUzfL3V/Y531Reuo1/nTDnJLudXZNrBmlwiRtKi6F+TllJCn8wsVHBKvK0yzEU08tDFDPoSMp+dTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dOhTcOUk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753383171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KwVDmCmYVZN6ImwcpxRuuiECBLrfVSkQ1shmopmWmW0=;
	b=dOhTcOUkHVDQOSnJZhPykD73w9Wm86uX1h/ggFsfBhj2li114Y9/ueXw4wcLTD2rLHy21C
	yFDu/M4yM4Aa6zi61Lrp0qZ045mexe41n3Hb1KleXdlpe7E3xPGhhKo+6m1aA6kjVt1xeF
	oD9+65xhyTmvdU1UU7dvIXONvybWRTI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-ytbLY9HDNjCZwQAz1VjnbA-1; Thu,
 24 Jul 2025 14:52:50 -0400
X-MC-Unique: ytbLY9HDNjCZwQAz1VjnbA-1
X-Mimecast-MFC-AGG-ID: ytbLY9HDNjCZwQAz1VjnbA_1753383168
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 74914180034A;
	Thu, 24 Jul 2025 18:52:47 +0000 (UTC)
Received: from chopper.lyude.net (unknown [10.22.88.223])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2F132195608D;
	Thu, 24 Jul 2025 18:52:44 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: rust-for-linux@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Boqun Feng <boqun.feng@gmail.com>,
	linux-kernel@vger.kernel.org,
	Andreas Hindborg <a.hindborg@kernel.org>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: Frederic Weisbecker <frederic@kernel.org>,
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
Subject: [PATCH v6 1/7] rust: hrtimer: Document the return value for HrTimerHandle::cancel()
Date: Thu, 24 Jul 2025 14:49:27 -0400
Message-ID: <20250724185236.556482-2-lyude@redhat.com>
In-Reply-To: <20250724185236.556482-1-lyude@redhat.com>
References: <20250724185236.556482-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Just a drive-by fix I noticed: we don't actually document what the return
value from cancel() does, so do that.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>

---
V4:
* Reword to "Returns `true` if the timer was running."

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 rust/kernel/time/hrtimer.rs | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
index 144e3b57cc780..6bfc0223f4f57 100644
--- a/rust/kernel/time/hrtimer.rs
+++ b/rust/kernel/time/hrtimer.rs
@@ -324,6 +324,8 @@ pub unsafe trait HrTimerHandle {
     /// Note that the timer might be started by a concurrent start operation. If
     /// so, the timer might not be in the **stopped** state when this function
     /// returns.
+    ///
+    /// Returns `true` if the timer was running.
     fn cancel(&mut self) -> bool;
 }
 
-- 
2.50.0


