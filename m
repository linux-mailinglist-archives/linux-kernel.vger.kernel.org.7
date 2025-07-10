Return-Path: <linux-kernel+bounces-726594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B4EB00F0B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 00:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FE6E1CA8282
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 22:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDA329AB16;
	Thu, 10 Jul 2025 22:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cAx0cX8F"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCF31D432D
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 22:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752187914; cv=none; b=cdCBgcScU47+Bxbjn0T9xba2C7B9ydyiNMK8i70JR1gp/zThBVUGToHMbj6FJgrE0KKxojUhIZj7xMPb1hvIXMvHIcOTPJlYcPVTuWagtwm3qZvuZw08ZW4FO76DF75cdPBt6zxJEzz5IkQ79sEmcGjKXeTQ3X22r+HzM1NYv5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752187914; c=relaxed/simple;
	bh=uVeKJ8xBsRpkVuE4Q1BZswrNSbyNWSh8okxEnyGwfCc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uzZxUevH09m2RzB/y0/j5goOKemYoGANFFt/Y9YmG9hfdZsJ3R99Q8HJQUMdTJUmB2JPSnJO/ht37Jk/8YIec3ig3zwtVpUTPcafA6utMefFWj2QqOt9Rco5kIYXROHqOMF01bry0Dqd4Oczi15QsiyvkfqGiQ0X24ihWkhwigY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cAx0cX8F; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752187910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=O+Z1wrgBsDAZ+dNtmePreRESpDdntk9BeBWI/zMXSEo=;
	b=cAx0cX8Fh8N3VWvWhFjU4cU/MfaFyVf7fuyIrT6VzUrszwCK3usWzaowf0PptKGoN7OAVx
	bG55Xgj+9GmSqrud6PS9M6g3hbrsGmWS0cAW1JnOWdjAoXngwlGop7FvbbOoDVdsX1hLy1
	srInyNz9yieoF0nV9sa71tMxfQDBHTM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-538-2VNQnW15N4qoYaGp6dKjUw-1; Thu,
 10 Jul 2025 18:51:47 -0400
X-MC-Unique: 2VNQnW15N4qoYaGp6dKjUw-1
X-Mimecast-MFC-AGG-ID: 2VNQnW15N4qoYaGp6dKjUw_1752187905
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1868219560AD;
	Thu, 10 Jul 2025 22:51:45 +0000 (UTC)
Received: from chopper.lyude.net (unknown [10.22.88.104])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DEE76195607A;
	Thu, 10 Jul 2025 22:51:40 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: rust-for-linux@vger.kernel.org
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
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
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] rust: time: Pass correct timer mode ID to hrtimer_start_range_ns
Date: Thu, 10 Jul 2025 18:51:13 -0400
Message-ID: <20250710225129.670051-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

While rebasing rvkms I noticed that timers I was setting seemed to have
pretty random timer values that amounted slightly over 2x the time value I
set each time. After a lot of debugging, I finally managed to figure out
why: it seems that since we moved to Instant and Delta, we mistakenly
began passing the clocksource ID to hrtimer_start_range_ns, when we should
be passing the timer mode instead. Presumably, this works fine for simple
relative timers - but immediately breaks on other types of timers.

So, fix this by passing the ID for the timer mode instead.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>
Fixes: fcc1dd8c8656 ("rust: time: Make HasHrTimer generic over HrTimerMode")
---
 rust/kernel/time/hrtimer.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
index 8818775afaf69..e227fa95ab05c 100644
--- a/rust/kernel/time/hrtimer.rs
+++ b/rust/kernel/time/hrtimer.rs
@@ -398,7 +398,7 @@ unsafe fn start(this: *const Self, expires: <Self::TimerMode as HrTimerMode>::Ex
                 Self::c_timer_ptr(this).cast_mut(),
                 expires.as_nanos(),
                 0,
-                <Self::TimerMode as HrTimerMode>::Clock::ID as u32,
+                <Self::TimerMode as HrTimerMode>::C_MODE as u32
             );
         }
     }

base-commit: d4b29ddf82a458935f1bd4909b8a7a13df9d3bdc
-- 
2.50.0


