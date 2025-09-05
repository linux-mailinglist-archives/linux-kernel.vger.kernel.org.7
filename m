Return-Path: <linux-kernel+bounces-802016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6659B44CCE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 06:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1800DA46D87
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 04:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C99F27A909;
	Fri,  5 Sep 2025 04:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E4c8cay6"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73704277028;
	Fri,  5 Sep 2025 04:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757047326; cv=none; b=oCPbWoycXvlnn3oMVg7O9e9R+WyKvCoZxiRKFLudlhTJYb5usPCIrDEvLMqQcouTtDgrgZ2NsD2Ymbb1PNn0JUpcc2hnjmxNpVVZVHjBHziqNEFP7zw1+97VNU4Z/0V3MTSDn+aIGwVo92FA6c+j7YtPjsfMpp+r4uYXptR+CoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757047326; c=relaxed/simple;
	bh=cIwCw8ri5yu72PQ+HU7IQjAWQp4V6hhuqnXQUXgcnmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DX3XiQ1xu8GZmOZHmwhphHB3WeTNzeW808MuOS0eEfT4VzIptI2LTpGLNW27Aor3oPzrqxMeimFg4Q304/eBErOo5RcTPI8YKmx2/Kbp3bF0PUKrGJajX+efUqEaeggkKVGqQ9KKo5JirP+QsiAYa1aYcgmjROX0XFmHDKzeqUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E4c8cay6; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-72238e9f8ffso15138506d6.2;
        Thu, 04 Sep 2025 21:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757047323; x=1757652123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jGRXCvAdf9rQDwGdmHhB4qan/VLBpVYM9P1wrloCxm8=;
        b=E4c8cay6NALBCZ2n1PvbaRwGAgn7MqCvQ5oN1dMnXVvr+oPetnRl5JF88nfRRA4GQm
         LYRPYpCQf3RuBZTIyIvM21hvcs5iuUqRBke/H1KwqUVTV3tC9Hsyu3PzKAUdPv8K3LmF
         ZIOAVm78ViHG7oechjJPC5uj869ELxzIci2OCmviV7f1Y+Y+ju+bBzHHryaCAZDiwnOl
         zJ1oBwOmgmskQQjDxm9c1fO9i1VyseAwt1y9IUgJFR3Sln1oiYpzzMxgbk6d3MbXCLC9
         2ZpqWM2kuyl2piQEZ/gdIAOqeI0cdXRG8AlGm4EwBc6H4+zSdg9EUSOgH5PXZwa8mNuW
         6tEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757047323; x=1757652123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jGRXCvAdf9rQDwGdmHhB4qan/VLBpVYM9P1wrloCxm8=;
        b=jlMEl/PBuUg2KpCKgDlTJhKhser/cKy6/rAV8MABPv62HNSeusO0zWumCNv5CZeFZz
         KjVbp69WDAhrrGrNT3chUaWw9bBFgNAlMwHXQLNP5HgtHDl8XQGsM6/+kLsCaMbEaHXX
         vcu+/bHji1CS4w8HaHmvrUAJSn6KhPcfgtyVYrVUwr8RVmSg5dEHJvs69cxSGWrpkcaI
         npAFZO9JCQwqtrqm22HELjLkZG+vmth2dROA63/1meW6SrY5EOdDgvnG2HMMnKO0fHUJ
         Xi1W087kwzeWLM16+200eT+rtiSQaUuEEHi03ohGhCrCioVAQW6U25SWKeFAcJbYGhhb
         Iksg==
X-Forwarded-Encrypted: i=1; AJvYcCXlprGxYaq5tDsSt94vDjUvl4lD9DUroHTjVnjH0iyZCDDZ+ocGlvVdGW9CIzRk4mLw8m/YWJqeFA/Akg4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBYP9VBYONnMJMu1NvB+a1U8Oeq3I+tXxmQ0mcO4+WC3GKdw61
	zyHu9jAjZpz+y/uxT+pigApGwxQulY6OYObUpI0L8wv0g+yiq7ikPFtV
X-Gm-Gg: ASbGncvSzCMo7oQ8rAfJYFp23hwZckii5HftUAUb5tSzvHHmAJK64tMlqghja+GGXG0
	T/M/7bpxoRj3WoOs31EwCyAsHQ+oiaKUBel/fWyhVNhwwCbdi6aXgvgREXZTryMYc338jEcoO7g
	hV1+ddkeiLwAGdE4mrugYkZsanzaDcZin8419OSO3HM2SbrazfhPejdKTC/OZz8f8MK/cnfsYgV
	K/RoRvUJ+SFuEDXbnsLL6JFGMHrUGDbKrpwNQ+/weFLtjVXTmIsa3IH5j2eV5FWxK9XxEvM16R9
	LwIG0tqAjK1Y1jEkZsqJsRqrkTXSlAYzBiRDkBzBw+cQhAN7DsLSYUJDp+4A4jN+9Xec1boCvOB
	r+vh1AzEQicbtgkBz260ojF7EB1lL6nxBceKmdYklaeHGDomMRLE9y/4dMOTYEFmkFjeDjgfyYr
	LiJHdHXPbPmZ/LGXirb8w7DKk=
X-Google-Smtp-Source: AGHT+IHeGa/hifMiPYeAI3f5yPt/m/6tT3nOmmo9PQP22OrVz0iXxYDTUnjYb/5mNd+7VqNF/FpgJw==
X-Received: by 2002:a05:6214:2282:b0:710:9749:aeb8 with SMTP id 6a1803df08f44-7109749b4b8mr204940256d6.14.1757047323400;
        Thu, 04 Sep 2025 21:42:03 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720b4665fcbsm58231246d6.37.2025.09.04.21.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 21:42:03 -0700 (PDT)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 8D79AF40066;
	Fri,  5 Sep 2025 00:42:02 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 05 Sep 2025 00:42:02 -0400
X-ME-Sender: <xms:Gmq6aGenpJ8Mhwj7VxJqwjCUMBiJv5Ia5j7k0Upg9pejOzj-UBIj5w>
    <xme:Gmq6aN63iZU88Ss0bazI1YtXhSKZJyFAdOTgWbUQkjKZhNWgOcALiAfFSJI0SkMUG
    vIEypeqLWKNXTpPKA>
X-ME-Received: <xmr:Gmq6aJSn775DA1rsHIrnFYyRmzTczUMHMrQzx3hyI6C_IlmIAIUgqs0HQ1N6zKF5I8uF9TqnojXHRdI4ViJkZkyn-SR_opKJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcuhfgv
    nhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtthgvrh
    hnpefghfffvefhhfdvgfejgfekvdelgfekgeevueehlefhiedvgeffjefgteeugfehieen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhs
    ohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnh
    hgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedv
    tddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhhushhtqdhfohhrqdhlihhnuh
    igsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhn
    vghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhkmhhmsehlihhsth
    hsrdhlihhnuhigrdguvghvpdhrtghpthhtohepfihilhhlsehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhope
    hmrghrkhdrrhhuthhlrghnugesrghrmhdrtghomhdprhgtphhtthhopehmihhnghhosehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehtghhlgieslhhinhhuthhrohhnihigrdguvg
    dprhgtphhtthhopehprghulhhmtghksehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Gmq6aAcLdew77S6MnTrqXZGh0vN-gluanLUCvUE6mIdX1oxxWKsoaA>
    <xmx:Gmq6aJSSjdKy4w_l8uCUNMnUTlNKKVjvs64hkxB95-SyVY7oD7Zrvw>
    <xmx:Gmq6aJOCMlpYhdlrOqkeIakYoWq6hlwb-H_Am6jliAxqEetlgSk6Sg>
    <xmx:Gmq6aMVeZGwPC2SwbuzWe9CDgmRRGg58Ut3Flsl3KYsPdC8ThEttlw>
    <xmx:Gmq6aJZlNwastp4sma6krpJBzfBIEjGFJLmy-6b8SXNDlK_6y1wVJdT_>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Sep 2025 00:42:01 -0400 (EDT)
From: Boqun Feng <boqun.feng@gmail.com>
To: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lkmm@lists.linux.dev
Cc: "Will Deacon" <will@kernel.org>,
	"Peter Zijlstra" <peterz@infradead.org>,
	"Mark Rutland" <mark.rutland@arm.com>,
	"Ingo Molnar" <mingo@kernel.org>,
	"Thomas Gleixner" <tglx@linutronix.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	stern@rowland.harvard.edu,
	"Miguel Ojeda" <ojeda@kernel.org>,
	alex.gaynor@gmail.com,
	"Gary Guo" <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	"Benno Lossin" <lossin@kernel.org>,
	"Alice Ryhl" <aliceryhl@google.com>,
	"Trevor Gross" <tmgross@umich.edu>,
	"Danilo Krummrich" <dakr@kernel.org>,
	"Andreas Hindborg" <a.hindborg@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH 07/14] rust: sync: atomic: Add Atomic<u{32,64}>
Date: Thu,  4 Sep 2025 21:41:34 -0700
Message-ID: <20250905044141.77868-8-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250905044141.77868-1-boqun.feng@gmail.com>
References: <20250905044141.77868-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add generic atomic support for basic unsigned types that have an
`AtomicImpl` with the same size and alignment.

Unit tests are added including Atomic<i32> and Atomic<i64>.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/all/20250719030827.61357-8-boqun.feng@gmail.com/
---
 rust/kernel/sync/atomic/predefine.rs | 95 ++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/rust/kernel/sync/atomic/predefine.rs b/rust/kernel/sync/atomic/predefine.rs
index a6e5883be7cb..d0875812f6ad 100644
--- a/rust/kernel/sync/atomic/predefine.rs
+++ b/rust/kernel/sync/atomic/predefine.rs
@@ -27,3 +27,98 @@ fn rhs_into_delta(rhs: i64) -> i64 {
         rhs
     }
 }
+
+// SAFETY: `u32` and `i32` has the same size and alignment, and `u32` is round-trip transmutable to
+// `i32`.
+unsafe impl super::AtomicType for u32 {
+    type Repr = i32;
+}
+
+// SAFETY: The wrapping add result of two `i32`s is a valid `u32`.
+unsafe impl super::AtomicAdd<u32> for u32 {
+    fn rhs_into_delta(rhs: u32) -> i32 {
+        rhs as i32
+    }
+}
+
+// SAFETY: `u64` and `i64` has the same size and alignment, and `u64` is round-trip transmutable to
+// `i64`.
+unsafe impl super::AtomicType for u64 {
+    type Repr = i64;
+}
+
+// SAFETY: The wrapping add result of two `i64`s is a valid `u64`.
+unsafe impl super::AtomicAdd<u64> for u64 {
+    fn rhs_into_delta(rhs: u64) -> i64 {
+        rhs as i64
+    }
+}
+
+use crate::macros::kunit_tests;
+
+#[kunit_tests(rust_atomics)]
+mod tests {
+    use super::super::*;
+
+    // Call $fn($val) with each $type of $val.
+    macro_rules! for_each_type {
+        ($val:literal in [$($type:ty),*] $fn:expr) => {
+            $({
+                let v: $type = $val;
+
+                $fn(v);
+            })*
+        }
+    }
+
+    #[test]
+    fn atomic_basic_tests() {
+        for_each_type!(42 in [i32, i64, u32, u64] |v| {
+            let x = Atomic::new(v);
+
+            assert_eq!(v, x.load(Relaxed));
+        });
+    }
+
+    #[test]
+    fn atomic_xchg_tests() {
+        for_each_type!(42 in [i32, i64, u32, u64] |v| {
+            let x = Atomic::new(v);
+
+            let old = v;
+            let new = v + 1;
+
+            assert_eq!(old, x.xchg(new, Full));
+            assert_eq!(new, x.load(Relaxed));
+        });
+    }
+
+    #[test]
+    fn atomic_cmpxchg_tests() {
+        for_each_type!(42 in [i32, i64, u32, u64] |v| {
+            let x = Atomic::new(v);
+
+            let old = v;
+            let new = v + 1;
+
+            assert_eq!(Err(old), x.cmpxchg(new, new, Full));
+            assert_eq!(old, x.load(Relaxed));
+            assert_eq!(Ok(old), x.cmpxchg(old, new, Relaxed));
+            assert_eq!(new, x.load(Relaxed));
+        });
+    }
+
+    #[test]
+    fn atomic_arithmetic_tests() {
+        for_each_type!(42 in [i32, i64, u32, u64] |v| {
+            let x = Atomic::new(v);
+
+            assert_eq!(v, x.fetch_add(12, Full));
+            assert_eq!(v + 12, x.load(Relaxed));
+
+            x.add(13, Relaxed);
+
+            assert_eq!(v + 25, x.load(Relaxed));
+        });
+    }
+}
-- 
2.51.0


