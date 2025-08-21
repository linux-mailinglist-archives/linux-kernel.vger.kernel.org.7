Return-Path: <linux-kernel+bounces-780512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC30B302F1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 21:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 747D7567C0C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 19:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F79236A8B;
	Thu, 21 Aug 2025 19:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eRPshXpy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEC17FBAC
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 19:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755804812; cv=none; b=fiTu7sjOiSHF1pqlz09Dc2jdQ0VjhBKCxt7ewmEk8FOSV38+Z71VLs2Jy2V/sfMYUene7O2vJhESPeaDZCumJHcmhuyRivihWMSiP8Go31fSnPATSg0m/AD5gKnElGrOdU9CQnSLbhbEB6pieYPJeMNrgm1tx+Zoi1NJZsPUbBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755804812; c=relaxed/simple;
	bh=qlwaWio57GqLMA9Fb4mvAHFlhGAkvsC98uuNEQObk/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hUq2mDQCq4ombNrUdDtgjTDN2l4l4aS8E7kEO1Nz6v3RuwPs6M7/KShQVEKDak9HpwfmgunsACNdDckYA5skZMuOpAzaJyJZ1uM/XM5TGrYYKpg3dhJ2GCL8IQ3KPGQiI6vw8TvSENCf83TsvkbC+rBtbm5WQnPvYmHvLtlyo4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eRPshXpy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755804810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BLWwbEpsyDLokTeeRPGfQvr4ehtZaUWiSPjkeJIZb9w=;
	b=eRPshXpyZtK6MBElBbXyEXkgHgOToNP0k5LcDwKuyD+gr77G7nFE35AlYCLajr07+tHAqj
	GG2Rnv8IFoYTMyvycVlwmcY0TMPJ5VKXkglKPEjkFJG41OUvRcFeJyDjHTtXOZ+klXgHbi
	4nYfF/lgUbz2Xb48haOCZovYwixtqLg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-124-HtXK0WiUOMybVkIS9GR2gA-1; Thu,
 21 Aug 2025 15:33:23 -0400
X-MC-Unique: HtXK0WiUOMybVkIS9GR2gA-1
X-Mimecast-MFC-AGG-ID: HtXK0WiUOMybVkIS9GR2gA_1755804801
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CFFE0180028D;
	Thu, 21 Aug 2025 19:33:20 +0000 (UTC)
Received: from chopper.redhat.com (unknown [10.22.89.200])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C9E38197768A;
	Thu, 21 Aug 2025 19:33:16 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: 
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
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
	Danilo Krummrich <dakr@kernel.org>,
	rust-for-linux@vger.kernel.org (open list:DELAY, SLEEP, TIMEKEEPING, TIMERS [RUST]),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v9 1/7] rust: hrtimer: Document the return value for HrTimerHandle::cancel()
Date: Thu, 21 Aug 2025 15:32:41 -0400
Message-ID: <20250821193259.964504-2-lyude@redhat.com>
In-Reply-To: <20250821193259.964504-1-lyude@redhat.com>
References: <20250821193259.964504-1-lyude@redhat.com>
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
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>

---
V4:
* Reword to "Returns `true` if the timer was running."

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


