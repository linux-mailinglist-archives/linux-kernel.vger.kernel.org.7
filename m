Return-Path: <linux-kernel+bounces-824264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A44B88875
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 11:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83B467B2BA3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 09:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF9F306D23;
	Fri, 19 Sep 2025 09:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="foOFT6sQ"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF36302154
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 09:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758273192; cv=none; b=kvNobzbXqySgsYP20xdSJRj5rMHVSC8qBu+yhmApDyJmU3aCaRLPSTFLU+n1emC/B2dKomO3UEd1JZ5vbBRq/bqz1jcHzNTlxalqnh64KrULSvjvYcM7tRNyZYNx/5mnGA2kQlflKgPhb6r/k/URngO/SFF+8YQt67N+Cmu3wP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758273192; c=relaxed/simple;
	bh=6iII7fOYlyuZ8eQyG3nIT1ClvaKOibtuYRtJwPDwqjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uW7ayLwKcwchJzVJ4VeMgoDmkhLia9Nk7BEavEYWw+cEW+FTjYObtxTVQd5LrBsCPs9lCe39VyehX7bWqynxohWGYqCHR+PxSCSS7g7/2kyK/1q0QN8UvzjQvphuuEJ7Ae/cpWtRDQ3Vhht7bXV/JOHAZ7C5Td9I537rdb0wfPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=foOFT6sQ; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-77dd76f6964so29155276d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 02:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758273190; x=1758877990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Tz+hRdDjBJIiUvT5QMJv4FOcC6A5SLAQN/E0smv/a6w=;
        b=foOFT6sQj+DqYplwDHoXOA6+ovMEpwod5lZoF3zjF+rG7AcnsMuD7kqnfPsr8Uxqfa
         xXMHRKxFdHQoUWC/jeXWMNEz5ZLnRpVwM7vAeRaYi/RA1INo1mEaEiRDZVg0Wh1oNhLa
         SsUbkeZivDQQi04wq2I1o3yhHzl4ig2dY+uC95g05B+wrA6QaJIqBj7uE5jppZH48w9H
         xgH8enZXAFCZzFUdoW21GoXtrMhkLwYyz8yVbtO5RfjjoetF1QRGXnbPre2K4BDt3mxb
         GAh1Rcayg1Sw76zj9ywf8yDyCemAaY+haDnNC3MnKqPtJzPFVmGRw7MS+LyZeKFllKHz
         cEug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758273190; x=1758877990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tz+hRdDjBJIiUvT5QMJv4FOcC6A5SLAQN/E0smv/a6w=;
        b=GOxWsMUYxjE7oPnCnu4dI6o9DOjh8m3upBwWzDVxJ7vQYHlBz+RpY1JMWawULinVEz
         G4dKj7rWJlKrjgcuEAVTJx5WwRew5QlTPsqTw/wTknvSSlRzrqNhC9dMr1/5gL1bf3/E
         k86UgrhbqzXd9bti9e7MmmENvyxzKfg8i62CxtXQd3OlB5XDFLPgTFQyyI4WhQ2OZ1WP
         FFhSNyR27aM6ufLLHYTnwB3PlWO2tYnokWZ6BPZxZi4oqpDlpAW90JriPGlzjXOJomR5
         /Cqsjm7zayjVICYykv12E4A2Qi/ZvE6JuPBX9StmxQtsWZY6D6Qp22ALnrlsc1nAcP0C
         UkFg==
X-Forwarded-Encrypted: i=1; AJvYcCWm7yglHP7+JdZcweAyWMaqSJv6g5FmdavOmqo05FKNfogk8Io5ay8SoP2L8wn3P7A3jPlcu6Qk8fQqbUA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/591cyB0gW94WJIm4ta4EfVV1Y5oFhiLsR4582/K5bKb9M83I
	VwBkrZ41M+zTVUCBakhwE9dCRpEdC+yx4stvB07oGSQYYsnCoqhiW/vs
X-Gm-Gg: ASbGncs4GRPrZTQgmSOeNaLG3T2cYR3TMl1djOrV38vh1y3APzuZJk23SJxoZLN+PJt
	lcpqObK4XIcGGOPDybmVezVfIhfigpr7LzA7DvbvQfm/bZezMqZd17cdk8AbTcsY5D9EXgqz5bQ
	Ne7oVl23Frgn3lPYyNoTdYrNmG7mfbXj8N75ItaqAXLHzqeljNZuJJz16ENzmghZd9sdH94+AkA
	4b94PTCuIdm6rP9kYvdce5OB4eUyadby8JlZanINm9CZ7pocpgEnNIZS2DyLYMa5q6gkwttM462
	N/fdOUYGTt2WRzXKR5Q4ISL9azhkBxVG5XzxDLJBz2fnbXH/b3JbPYomgRsvUKwBnBzANYSrZwI
	eNYVMd7OXAbNNspwnaBb6oqVGizthJXd+dNUBDHN2lOX1xYLAMi+H7qSOxpJeNer9mhXN2nrJqr
	Gh4WH6XDAv0xIZ
X-Google-Smtp-Source: AGHT+IGHdHKieKTrB7753iPEOZIDAZM2fgg6Vs6HuQORCmBrQ4D7MJr31cHmfl/qBr2eF2H/N1qLqg==
X-Received: by 2002:a05:6214:20ce:b0:783:f54f:418a with SMTP id 6a1803df08f44-798bc7bf0damr31065416d6.15.1758273190002;
        Fri, 19 Sep 2025 02:13:10 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-793533ac961sm25881696d6.50.2025.09.19.02.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 02:13:09 -0700 (PDT)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 23359F40067;
	Fri, 19 Sep 2025 05:13:09 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 19 Sep 2025 05:13:09 -0400
X-ME-Sender: <xms:pR7NaJ9vvqlPSPZVQI4woMsaoR7l4rW-L2WFWW2oKRT_0My_lUHWqg>
    <xme:pR7NaDepPlq-HU1FNcfjpUctnlMpvU7OmDVRaeMe5omY9E98kexaEi-AyMjLZQ_Sg
    8fvcoz4yUPJCLbyOA>
X-ME-Received: <xmr:pR7NaFHFbEUxVE7i4IHtSN72OsT9p9FTH9VodAeRJUI4pMCTiUfMOYFFsZYC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegkeekvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhepkeetteejgeduieekudejfedvvddtiefgieffffeljeefieehiefffedvfeffgfet
    necuffhomhgrihhnpehgihhthhhusgdrtghomhdpkhgvrhhnvghlrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgv
    shhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehhe
    ehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
    pdhnsggprhgtphhtthhopedvtddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepph
    gvthgvrhiisehnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehmihhnghhosehkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehtghhlgieslhhinhhuthhrohhnihigrdguvgdprh
    gtphhtthhopehruhhsthdqfhhorhdqlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehlkhhmmheslhhishhtshdrlhhinhhugidruggvvhdprhgtphht
    thhopeifihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvthgvrhiisehinh
    hfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhonhhgmhgrnhesrhgvughhrghtrdgt
    ohhm
X-ME-Proxy: <xmx:pR7NaICwVnZDWc0eKAy4CfK5fVJSdQoWW5WJojmvifpQ0K0kgXtQEQ>
    <xmx:pR7NaI4Q707xbhl04XCPj-_X3SuuRVViDg6xu3ceu0Fg0kn7riUMvA>
    <xmx:pR7NaHlZ_UZaZVEqKl1e-IJOSCEJXE4KdkRB59LKAnJFAswiagiYvQ>
    <xmx:pR7NaB5lKQJ0fX7J8gPH2OoF77NZM-7fFOvSZT_UbJN2frfsnFR6HA>
    <xmx:pR7NaFUj62H3yUKLNnqHZ-r3cqK3kssWrjY2HwjGtH8Zcb7aK6DvEkF6>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Sep 2025 05:13:08 -0400 (EDT)
From: Boqun Feng <boqun.feng@gmail.com>
To: "Peter Zijlstra" <peterz@nfradead.org>,
	"Ingo Molnar" <mingo@kernel.org>,
	"Thomas Gleixner" <tglx@linutronix.de>
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lkmm@lists.linux.dev,
	"Will Deacon" <will@kernel.org>,
	"Peter Zijlstra" <peterz@infradead.org>,
	Waiman Long <longman@redhat.com>,
	"Miguel Ojeda" <ojeda@kernel.org>,
	alex.gaynor@gmail.com,
	"Gary Guo" <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	"Benno Lossin" <lossin@kernel.org>,
	"Alice Ryhl" <aliceryhl@google.com>,
	"Trevor Gross" <tmgross@umich.edu>,
	"Danilo Krummrich" <dakr@kernel.org>,
	"Andreas Hindborg" <a.hindborg@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH 3/4] rust: lock: Pin the inner data
Date: Fri, 19 Sep 2025 11:12:40 +0200
Message-ID: <20250919091241.32138-4-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250919091241.32138-1-boqun.feng@gmail.com>
References: <20250919091241.32138-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daniel Almeida <daniel.almeida@collabora.com>

In preparation to support Lock<T> where T is pinned, the first thing
that needs to be done is to structurally pin the 'data' member. This
switches the 't' parameter in Lock<T>::new() to take in an impl
PinInit<T> instead of a plain T. This in turn uses the blanket
implementation "impl PinInit<T> for T".

Subsequent patches will touch on Guard<T>.

Link: https://github.com/Rust-for-Linux/linux/issues/1181
Suggested-by: Benno Lossin <lossin@kernel.org>
Suggested-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---

Notes:
    SubmissionLink: https://lore.kernel.org/all/20250828-lock-t-when-t-is-pinned-v2-2-b067c4b93fd6@collabora.com/

 rust/kernel/sync/lock.rs | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index b482f34bf0ce..9242790d15db 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -11,7 +11,7 @@
     types::{NotThreadSafe, Opaque, ScopeGuard},
 };
 use core::{cell::UnsafeCell, marker::PhantomPinned, pin::Pin};
-use pin_init::{pin_data, pin_init, PinInit};
+use pin_init::{pin_data, pin_init, PinInit, Wrapper};
 
 pub mod mutex;
 pub mod spinlock;
@@ -115,6 +115,7 @@ pub struct Lock<T: ?Sized, B: Backend> {
     _pin: PhantomPinned,
 
     /// The data protected by the lock.
+    #[pin]
     pub(crate) data: UnsafeCell<T>,
 }
 
@@ -127,9 +128,13 @@ unsafe impl<T: ?Sized + Send, B: Backend> Sync for Lock<T, B> {}
 
 impl<T, B: Backend> Lock<T, B> {
     /// Constructs a new lock initialiser.
-    pub fn new(t: T, name: &'static CStr, key: Pin<&'static LockClassKey>) -> impl PinInit<Self> {
+    pub fn new(
+        t: impl PinInit<T>,
+        name: &'static CStr,
+        key: Pin<&'static LockClassKey>,
+    ) -> impl PinInit<Self> {
         pin_init!(Self {
-            data: UnsafeCell::new(t),
+            data <- UnsafeCell::pin_init(t),
             _pin: PhantomPinned,
             // SAFETY: `slot` is valid while the closure is called and both `name` and `key` have
             // static lifetimes so they live indefinitely.
-- 
2.51.0


