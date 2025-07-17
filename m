Return-Path: <linux-kernel+bounces-735884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0CAB094DA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 21:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCC6B56360D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 19:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61439303DCF;
	Thu, 17 Jul 2025 19:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I9jiIIAK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549EC30112B
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 19:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752779937; cv=none; b=B4h0Sv5RDhj4ip3Qny8OK2mmHPWzKb8o7Q7w09eCX8tN/UWcoX9Opgx3ePLYQR50Gjq3YuJXYtdRKLYIg9PB0DBJh1VUfjOX7NgyUOfK0Mlot4kqrdCQtWsAUzhUpUMp9+1JREUIeLOjybBuJYmOy6xU9C0BnbD22JDcrVok7GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752779937; c=relaxed/simple;
	bh=Z/KsvQ6Y/wJKZS0BbwqV/seBZ03+nXz5MF2MZWzZ5v8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mNymqQmcIFzPr1XVa03NjKByaKra4TXDv0qnPSXxqXZ9p/oblFphcxFHLEykTe/udO4F5zUHfzVXPIvq/dbiEL77Dq6aGUCobFF1q2LKHnKEiBQI+uHnONCngcx0AzgP3SdF0O7tnrpEOcYj1J1D8W5F4lILOMjfm8NbVp/Kn6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I9jiIIAK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752779935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6jakQ+WDo02nJsU8eZCe9vTA6HfZAByvZlMl+Y4AFmA=;
	b=I9jiIIAKQ9Zn7n4GhoKND5g92EoPkICAeWu7BWHEM98QUZyIZVXumhJmt28wGxkaapo5np
	bRGvTDJsTZOE/5lESQ3AbsjDPgCLNcaV+CTp8cLseA8yJNC5nCSnRSYhIXXgF+bX79mHVr
	IMqw1vw/Guu/oRCMUTnVGk0osopYgQY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-9t667viRNlyPURMF1KDAMA-1; Thu,
 17 Jul 2025 15:18:50 -0400
X-MC-Unique: 9t667viRNlyPURMF1KDAMA-1
X-Mimecast-MFC-AGG-ID: 9t667viRNlyPURMF1KDAMA_1752779928
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 691FB1800366;
	Thu, 17 Jul 2025 19:18:48 +0000 (UTC)
Received: from chopper.redhat.com (unknown [10.22.66.69])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C5C1D196664F;
	Thu, 17 Jul 2025 19:18:44 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: rust-for-linux@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Boqun Feng <boqun.feng@gmail.com>,
	linux-kernel@vger.kernel.org,
	Daniel Almeida <daniel.almeida@collabora.com>
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Mitchell Levy <levymitchell0@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH v12 12/15] rust: sync: Expose lock::Backend
Date: Thu, 17 Jul 2025 15:15:51 -0400
Message-ID: <20250717191719.2076270-13-lyude@redhat.com>
In-Reply-To: <20250717191719.2076270-1-lyude@redhat.com>
References: <20250717191719.2076270-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Due to the addition of sync::lock::Backend::Context, lock guards can be
returned with a different Backend than their respective lock. Since we'll
be adding a trait bound for Backend to GlobalGuard in order to support
this, users will need to be able to directly refer to Backend so that they
can use it in trait bounds.

So, let's make this easier for users and expose Backend in sync.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 rust/kernel/sync.rs | 1 +
 1 file changed, 1 insertion(+)

diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
index f1e448e096ea9..ebf004193bca5 100644
--- a/rust/kernel/sync.rs
+++ b/rust/kernel/sync.rs
@@ -25,6 +25,7 @@
 pub use lock::spinlock::{
     new_spinlock, new_spinlock_irq, SpinLock, SpinLockGuard, SpinLockIrq, SpinLockIrqGuard,
 };
+pub use lock::Backend;
 pub use locked_by::LockedBy;
 
 /// Represents a lockdep class. It's a wrapper around C's `lock_class_key`.
-- 
2.50.0


