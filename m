Return-Path: <linux-kernel+bounces-802020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D299B44CD3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 06:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F235F585580
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 04:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BDF2701B8;
	Fri,  5 Sep 2025 04:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aR5Lnxsa"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7090F283FD9;
	Fri,  5 Sep 2025 04:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757047333; cv=none; b=b8v61nMLiod2T5TvNkRI29Tz98qp9gOAuzdnFbwOpqMcHSFK/JR0T8UEtofmIF8+8rYUQQUdBOKNu/gHNEMAh0zeVcmWJ0UD7+QL4Cclhn2POQUVJ7a01D1jMWbM2PUhT3GZxcFj7APV7AaU7H+KWDbL3mBmSWLytxkhUgT2v/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757047333; c=relaxed/simple;
	bh=XpJx8EmlQYxj2hvieb16p7MhjiUVazjqoJkBANLzcX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C4Egf9n45iYGoaOTffUYurVYDUtv8b8VlSPosTjBslTHomK0V2RRjF5S8iEDxbVyG3JVt3juZ8NTYosHDW8tP86EIBHOAh5VZTUpSpVVkcc9XhSRIYgKvh7A7QnDV5IEn/5JZb/AQNRpL/v/wjT6q23W4gdFc/U/y5KR3Migt7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aR5Lnxsa; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-80cc99fe980so183820385a.2;
        Thu, 04 Sep 2025 21:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757047330; x=1757652130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jzkDuJy3hguJhMC9EAEsLKaCQ7lEpDB4B9a9tQf3+vQ=;
        b=aR5Lnxsa6knH7qGdmKMaz9Togpcp9/SzNc3AqZuLWnwQ75Bz1sZQ6GeCDHsmADFuT4
         VaVNaEFjbSa7FcoRGgAX++hZcYlYBhw/pIlyORpiy1EgegsmFHXyRSa/J8SPOUWq6PnY
         77C0ICpxqdWLLPbCjf5IPzJRc8t+1yJdIH6enpE2uBqXEotKTQXjFmyuyf1kqz0kqC0I
         IAAGljck2fLRNfR2vRP3H3pVom0PPgtw6EwCGGm60q6V/3GCw9UiUq79tkoE79pOGAFH
         ezolSsdSwMVCY/VX+ctRCN80sHKP//OJnjlc85PGdXgl06jkRSpKTBX6/zPGTBc/8Eej
         53aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757047330; x=1757652130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jzkDuJy3hguJhMC9EAEsLKaCQ7lEpDB4B9a9tQf3+vQ=;
        b=wNL8gJfBHBVDhX4/KU8gPxoSLbmP5yaPHcIo+zMtDx2vpiQ2ErBqWVuQHMTRU/VO8M
         AqVHGNjCyMPh3fVw4NKwdzlwrN5kFqO5Zskurj8DDb6bFbaumY+gQ0CPW1VvreOWOfUz
         7+D1VDW/a89fVKt5IgsD3SJTSeXPUbG64Ccup8FmRNZgh+FWPPFKLN5R6XdwqQ9m8Aox
         /beLG8vw2rkEuffk4NCNLmwBUl40VNf5hch6G3t8nCioxJdE0hhtxe98C5hcJleGgpzt
         Ob82EhEc+B1XMtPo2yc1j1dZ0VcTbfXFHrjs6PXZ4yER3FtL22011aMD8vsAvhSD3lRo
         YGpw==
X-Forwarded-Encrypted: i=1; AJvYcCVmyhGisgyMn3l0VqVm5caJ/2TL9G4sROWERtMeyMNn5ETW5I/j2EI6z++Qn9cVZoQAH77eDQGgtHKOyjc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzThp+seLJB22lsKuBTJUzWbXXF+j43SfTTLFXy1EVMh7eJdEdE
	topqyIuuJDIuQ4fL+0KIoD4GgUJ8BR0A5ziIqDbaO0rgAe15bXp318o5
X-Gm-Gg: ASbGnctuWrYaHbtuEcVXvjJvyuUNROoxqcwRqbqMJcGapdJDoswswTokwWsMCYp149p
	WDhj7n5BJSX0UXV69rY+5fIrGdtuB1AX83fIdfZCpY52UQQZJUKhYgVLDW5Vfdcgo9IaI+vFeCm
	TEd1f8UkmlWRQYGar1XV2+PTSVnxgG0CrJVc/ijtI9nyRF0Z2xYRpw2p4QcnmmgK7GBoy3sQ7h1
	wigAM8ma6J9DElU+WheySzCtAJRywUqeKLT5Mr9iv34q1f/6r0y92HRw6tWflaUNMPu3oOgbit0
	3ZuHO4Jfy8I4ChBcNvikjgNJsPreAFaKnjw0wnAtCmzTFSLa2q6gF99uXPMr5zwrcefZ7+mMUmW
	JS4GLFOrW8dB8JnIuDw9vvpJH6qCHEiALACgf5lqZd2AaVwrfpn6rQ/04HpHKn9TikmkHJtgMxf
	3IFPEcmQAkrOqRFhEaKDnv4MV3IeubR0tAsBYOmqle2T7J
X-Google-Smtp-Source: AGHT+IFMXSRO398LMA96TN5UtmIZck69+1ioD0dofhD06I4QR25Hund9hAN7YflKnxIU9gtTadLy8Q==
X-Received: by 2002:a05:620a:4586:b0:80a:aecb:b33b with SMTP id af79cd13be357-80aaecbb3b0mr1081912085a.55.1757047330267;
        Thu, 04 Sep 2025 21:42:10 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b48f7823casm41550161cf.42.2025.09.04.21.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 21:42:09 -0700 (PDT)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 7AA7EF40066;
	Fri,  5 Sep 2025 00:42:09 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 05 Sep 2025 00:42:09 -0400
X-ME-Sender: <xms:IWq6aON6ITh9TERlMscmMhJTQsD3hn-Tb2Wll--tuetLXhmymDrViw>
    <xme:IWq6aOT1vrtKC2PWUNQmOk-hxbS-ukgToUH5Pa_nFaNE85xugze6xtpWgd3-eQAvC
    mJtmRY5Hy8jXYu-OQ>
X-ME-Received: <xmr:IWq6aJ6OmIL1K-pDQUfzRAgirokFuFQQEddNHCzCwP13H2RUxgYZTHNIKivvSa6LZahz-7bvJI6pioFD3ho-nf_oYNvKpGgd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhunhcuhfgv
    nhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtthgvrh
    hnpedtheffuedvfefgleeiiefffffffedvkeehvdfggeduvedvgfektddvfedvueejgfen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhpthhrrdgrshenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgr
    uhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsoh
    hquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghr
    tghpthhtohepvddupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehruhhsthdqfh
    horhdqlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhn
    uhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlkh
    hmmheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopeifihhllheskhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpd
    hrtghpthhtohepmhgrrhhkrdhruhhtlhgrnhgusegrrhhmrdgtohhmpdhrtghpthhtohep
    mhhinhhgoheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhglhigsehlihhnuhhtrh
    honhhigidruggvpdhrtghpthhtohepphgruhhlmhgtkheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:IWq6aBZVetOAdRyQBmhW9nl5sHcvCDKleiQugDlN47zsBJUQFCTe_Q>
    <xmx:IWq6aNab9b0wAzYzTeQ0rXCLf6Boh_LTfEzuOryNW7cz1hgzEpCsDQ>
    <xmx:IWq6aE1lSuQY8DJ4B6e5ZHl-qJfsH8H4NJQIAy3O7q0d8HsDpbliKA>
    <xmx:IWq6aFaTaghor56sGEV84sneU3xpShdCZecbiV-V8kos7WrazFzlgw>
    <xmx:IWq6aJlWQNNnF3ZCU31rtyIlXJc1Bl1l7g_iF65OFlAAFQAc1CjZNlLN>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Sep 2025 00:42:08 -0400 (EDT)
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
	Alexandre Courbot <acourbot@nvidia.com>,
	Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH 11/14] rust: make `Arc::into_unique_or_drop` associated function
Date: Thu,  4 Sep 2025 21:41:38 -0700
Message-ID: <20250905044141.77868-12-boqun.feng@gmail.com>
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

From: Gary Guo <gary@garyguo.net>

Make `Arc::into_unique_or_drop` to become a mere associated function
instead of a method (i.e. removing the `self` receiver).

It's a general convention for Rust smart pointers to avoid having
methods defined on them, because if the pointee type has a method of the
same name, then it is shadowed. This is normally for avoiding semver
breakage, which isn't an issue for kernel codebase, but it's still
generally a good practice to follow this rule, so that `ptr.foo()` would
always be calling a method on the pointee type.

Reviewed-by: Benno Lossin <lossin@kernel.org>
Signed-off-by: Gary Guo <gary@garyguo.net>
Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/r/20250723233312.3304339-3-gary@kernel.org
---
 rust/kernel/sync/arc.rs | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index 63a66761d0c7..4ee155b43b2d 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -321,7 +321,7 @@ pub fn ptr_eq(this: &Self, other: &Self) -> bool {
     /// use kernel::sync::{Arc, UniqueArc};
     ///
     /// let arc = Arc::new(42, GFP_KERNEL)?;
-    /// let unique_arc = arc.into_unique_or_drop();
+    /// let unique_arc = Arc::into_unique_or_drop(arc);
     ///
     /// // The above conversion should succeed since refcount of `arc` is 1.
     /// assert!(unique_arc.is_some());
@@ -337,18 +337,18 @@ pub fn ptr_eq(this: &Self, other: &Self) -> bool {
     /// let arc = Arc::new(42, GFP_KERNEL)?;
     /// let another = arc.clone();
     ///
-    /// let unique_arc = arc.into_unique_or_drop();
+    /// let unique_arc = Arc::into_unique_or_drop(arc);
     ///
     /// // The above conversion should fail since refcount of `arc` is >1.
     /// assert!(unique_arc.is_none());
     ///
     /// # Ok::<(), Error>(())
     /// ```
-    pub fn into_unique_or_drop(self) -> Option<Pin<UniqueArc<T>>> {
+    pub fn into_unique_or_drop(this: Self) -> Option<Pin<UniqueArc<T>>> {
         // We will manually manage the refcount in this method, so we disable the destructor.
-        let me = ManuallyDrop::new(self);
+        let this = ManuallyDrop::new(this);
         // SAFETY: We own a refcount, so the pointer is still valid.
-        let refcount = unsafe { me.ptr.as_ref() }.refcount.get();
+        let refcount = unsafe { this.ptr.as_ref() }.refcount.get();
 
         // If the refcount reaches a non-zero value, then we have destroyed this `Arc` and will
         // return without further touching the `Arc`. If the refcount reaches zero, then there are
@@ -365,7 +365,7 @@ pub fn into_unique_or_drop(self) -> Option<Pin<UniqueArc<T>>> {
             // must pin the `UniqueArc` because the values was previously in an `Arc`, and they pin
             // their values.
             Some(Pin::from(UniqueArc {
-                inner: ManuallyDrop::into_inner(me),
+                inner: ManuallyDrop::into_inner(this),
             }))
         } else {
             None
-- 
2.51.0


