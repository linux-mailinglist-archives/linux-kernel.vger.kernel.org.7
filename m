Return-Path: <linux-kernel+bounces-759420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6388EB1DD55
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 21:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31ADE18C7025
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 19:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28341273D80;
	Thu,  7 Aug 2025 19:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WY1PdHiQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A648F6E
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 19:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754593627; cv=none; b=Qa49vv3hLxd4qZuwPXbaLc8omUVa9OhLdjIK8wmPDiVBT75D1Jgig1VhLkiQLoI+XXa1210ILwGokQumWEahMfHv+82jK2J9mLJHWzVlC8LVSbcJ4jPqwkPh8HoDYbPBpYksv6brpse/pHAYiDN9B1LOAb/vXDasqy3Wfx1iKn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754593627; c=relaxed/simple;
	bh=IZ5iA6JYGuoHNF4GuuPrYx3oQWMdRk2C9aHIR53EzqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ESVTIOjI9qosjfkyNJytFGph0zmKQGkb/A+MCnWzM6K2YsyVeDAZoBocAG0zlgL2ZbY4hXzU2hlJWHV1OGZJNKvaRZzc917Q2AbAQV0JmADU1CWEubZ106U9jQG2Md2lnYF9co1s+sdNNDNrc1Gq3PKF+XRCHaq9iSr0R+axnPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WY1PdHiQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754593625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5kEVj7Z1DAt91MAc0QaZChc9CtmatHbPk+BvSKORivE=;
	b=WY1PdHiQOmydxAmjbZrMG04SggeUzjXiIn8JYFPs9eu/OWqpwsDfjPhJycG/d2hqXlT1BX
	h3EVzwKC+q0hENR3PiRrWd8AQzSAzmxPX62UP7zxtokgYpSxE+qjYaaYNV0Xnra32g+T46
	s+NTBKDJfV9pZPlfa9eXNdWsOe6HRrw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-fkUdhNY1OFa4mfnDQsgSaQ-1; Thu,
 07 Aug 2025 15:07:01 -0400
X-MC-Unique: fkUdhNY1OFa4mfnDQsgSaQ-1
X-Mimecast-MFC-AGG-ID: fkUdhNY1OFa4mfnDQsgSaQ_1754593619
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5073C195609E;
	Thu,  7 Aug 2025 19:06:59 +0000 (UTC)
Received: from chopper.redhat.com (unknown [10.22.65.111])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 63CF219560AD;
	Thu,  7 Aug 2025 19:06:55 +0000 (UTC)
From: Lyude Paul <lyude@redhat.com>
To: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
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
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v2 2/2] rust: time: Implement basic arithmetic operations for Delta
Date: Thu,  7 Aug 2025 15:06:36 -0400
Message-ID: <20250807190649.3078875-2-lyude@redhat.com>
In-Reply-To: <20250807190649.3078875-1-lyude@redhat.com>
References: <20250807190649.3078875-1-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

While rvkms is only going to be using a few of these, since Deltas are
basically the same as i64 it's easy enough to just implement all of the
basic arithmetic operations for Delta types.

Keep in mind there's one quirk here - the kernel has no support for
i64 % i64 on 32 bit platforms, the closest we have is i64 % i32 through
div_s64_rem(). So, instead of implementing ops::Rem or ops::RemAssign we
simply provide Delta::rem_nanos().

Signed-off-by: Lyude Paul <lyude@redhat.com>

---
V2:
* Don't forget to make sure that we inline all of these
* Drop ops::Rem and ops::RemAssign implementations for Delta, replace with
  Delta::rem_nanos() instead. It turns out that there's actually no way to
  perform i64 % i64 on 32 bit platforms in the kernel at the moment, the
  closest that we have is div_s64_rem() which only allows a 32 bit divisor.
* Actually use the kernel arithmetic helpers for division/remainders so
---
 rust/kernel/time.rs | 109 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 109 insertions(+)

diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
index 4bd7a8a009f3e..ddc4cf0d51dc9 100644
--- a/rust/kernel/time.rs
+++ b/rust/kernel/time.rs
@@ -265,6 +265,89 @@ pub struct Delta {
     nanos: i64,
 }
 
+impl ops::Add for Delta {
+    type Output = Self;
+
+    #[inline]
+    fn add(self, rhs: Self) -> Self {
+        Self {
+            nanos: self.nanos + rhs.nanos,
+        }
+    }
+}
+
+impl ops::AddAssign for Delta {
+    #[inline]
+    fn add_assign(&mut self, rhs: Self) {
+        self.nanos += rhs.nanos;
+    }
+}
+
+impl ops::Sub for Delta {
+    type Output = Self;
+
+    #[inline]
+    fn sub(self, rhs: Self) -> Self::Output {
+        Self {
+            nanos: self.nanos - rhs.nanos,
+        }
+    }
+}
+
+impl ops::SubAssign for Delta {
+    #[inline]
+    fn sub_assign(&mut self, rhs: Self) {
+        self.nanos -= rhs.nanos;
+    }
+}
+
+impl ops::Mul for Delta {
+    type Output = Self;
+
+    #[inline]
+    fn mul(self, rhs: Self) -> Self::Output {
+        Self {
+            nanos: self.nanos * rhs.nanos,
+        }
+    }
+}
+
+impl ops::MulAssign for Delta {
+    #[inline]
+    fn mul_assign(&mut self, rhs: Self) {
+        self.nanos *= rhs.nanos;
+    }
+}
+
+impl ops::Div for Delta {
+    type Output = Self;
+
+    #[inline]
+    fn div(self, rhs: Self) -> Self::Output {
+        #[cfg(CONFIG_64BIT)]
+        {
+            Self {
+                nanos: self.nanos / rhs.nanos,
+            }
+        }
+
+        #[cfg(not(CONFIG_64BIT))]
+        {
+            Self {
+                // SAFETY: This function is always safe to call regardless of the input values
+                nanos: unsafe { bindings::div64_s64(self.nanos, rhs.nanos) },
+            }
+        }
+    }
+}
+
+impl ops::DivAssign for Delta {
+    #[inline]
+    fn div_assign(&mut self, rhs: Self) {
+        self.nanos = self.nanos / rhs.nanos
+    }
+}
+
 impl Delta {
     /// A span of time equal to zero.
     pub const ZERO: Self = Self { nanos: 0 };
@@ -353,4 +436,30 @@ pub fn as_millis(self) -> i64 {
             bindings::ktime_to_ms(self.as_nanos())
         }
     }
+
+    /// Return `self % dividend` where `dividend` is in nanoseconds.
+    ///
+    /// The kernel doesn't have any emulation for `s64 % s64` on 32 bit platforms, so this is
+    /// limited to 32 bit dividends.
+    #[inline]
+    pub fn rem_nanos(self, ns: i32) -> Self {
+        #[cfg(CONFIG_64BIT)]
+        {
+            Self {
+                nanos: self.as_nanos() % i64::from(ns),
+            }
+        }
+
+        #[cfg(not(CONFIG_64BIT))]
+        {
+            let mut rem = 0;
+
+            // SAFETY: `rem` is in the stack, so we can always provide a valid pointer to it.
+            unsafe { bindings::div_s64_rem(self.as_nanos(), ns, &mut rem) };
+
+            Self {
+                nanos: i64::from(rem),
+            }
+        }
+    }
 }
-- 
2.50.0


