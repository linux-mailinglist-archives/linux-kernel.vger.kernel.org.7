Return-Path: <linux-kernel+bounces-824265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7C4B8886F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 11:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 480685A09C4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 09:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6CC307491;
	Fri, 19 Sep 2025 09:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="di82UDSw"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A4C2EF64F
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 09:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758273201; cv=none; b=UfItoyHXVaf8VcRIiqRPtKY4zYw5OXvaODpuAe1KQ+3+zfjRVo1+R09MTNr1HpREMkQmcWzPLz5pPCiwc9UAb/s4eDwkEFo9LH8Mb9bnV9j8TXFXuq1COUf5F0GtBCOR1xJWgzpFg5dQBh5zaP46Gvl62qQl4Rm1vkrQZ+iVUYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758273201; c=relaxed/simple;
	bh=qiImjsEzOnaVKlSA0NmMABN9A4Q0NbEvUqksJ6TQ7Vg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y948XWeit2gCW1hI0GfsiS92LAiNe+rj2W12hKkeFtiG6SJ4A59AMnoam+4Ly71IAc1/8Vxhd1DGUvV050K9TnOAI0IJJXhFrj3cC2rgmOFQ+6UX0CW010E7FpmxqCd1TD5fqphzoRRiFzCwBMD5eWkFtqGyXDkHicojbcj8eos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=di82UDSw; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-78f58f4230cso15782616d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 02:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758273198; x=1758877998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HC7c63QfQ23In6I7fvHeR2uJH3BX6Ddk3KhkxkSWOaw=;
        b=di82UDSw1Ujorkjr5j1iFvqsxFzI6TpG8UvnCWoEYTV/yi4iSgNCZrePM1tJqYQgKn
         a/gOoUYZqGWMkRY5BbIStmEFAvhVV53M7XpKOQycfQkMY79RFdSOT8uY4EZk+ncik3YP
         4pExHcCuLv0ZDf+W1lkTc0NxMq9706qW9wH1XY0f+9RlcDo5LoHVBC5Kj9X80fuJT2Rm
         lEW5TANsWIzcGemzDz/0NS5Ek7Yb4jO65988YvXWmlZtilQxT/Tz9asi5RPbZHI1r1U/
         aHTLP8+TWRC+L9WL80ocJ2drlmrNCKiyeYu9gm3HDWtPw4TzbDv1Ip/jyu3dn7GWSSoW
         /iyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758273198; x=1758877998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HC7c63QfQ23In6I7fvHeR2uJH3BX6Ddk3KhkxkSWOaw=;
        b=fWMKO62BDg9YYCuexAG2LiVlvGH2cDomRB4soHPNGQPKBj+ytgLLYg3aAytDBp8dZP
         /Pg2/RGUp/NZcJQHs+3pQ0JFlwOMj3rfRDNmzNHggdA1QgvpzGj1F+7p0PJBw4IwVLsO
         MdNOD0Y2mmeat1D8FtzsGm6Xl3Kr4Av73/G6yCesent/2N9ZBBrK9MfAXNtL2QUi+o0o
         0qPEr120dqNT4METM2DFQlKqihTRZu0u/0rj3SdGWrpZ7zAeRI0YCl1oLxsSCrM2Pilw
         pE/TgLpLOTUbBqA3SxSuakEsDlR0USnSBoUizsZ88RK/28xT64FayKiJshHtl142d59J
         MdvA==
X-Forwarded-Encrypted: i=1; AJvYcCW2P3ZrnpKfDTC3U9JdZVkBXi0opl8h+Bwxio27kwP1SJpT9vZgcMEYDC6eYguid3BbaaG4rdwPYBFCk74=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsoQ32J3LcIsNUH2JKX9n2E9J/X4QXQhYdj3jpCV0OvCDNj4F/
	6vbCJwKla4TsbxUbS5xqJNOW2+yxwVHPQMBXV7j+klEgoPUIMKrAFCHp
X-Gm-Gg: ASbGncsUWhc229nxRiuwCdKAcyMLeZsTQc3+NsdC/w+BjBiEYseIDTOpVThsnEtOhlQ
	3AQW7MIfjN+8khE9z+DwY4J7RlU/7yRzPdt5UCRTmjhnCAXiK1YzW/YrBTCZ0M4ep+cS3z0fSyx
	YV6iEi3cjTqFjgDh2W3PcVXj257imyWVCom1K6ZWqJWKVq+ljb1ExBzyuBHMVQ05AHmauVoPSSC
	41hpVTtS72RG7JJEZ9EuLM1qxouITY4Z56PyD4mt7ZF5tT1TQmR5BaPet8qzdDSNQkC2F9LRXKm
	NcAcVbLHzERhEqSLVv7aVEEkY1tDJ3uHV8IC6TIFmXtG/7PHuEnFrxbCcoRl0yBL1GiRlSkerji
	LrWiLHKvLG0ZokhQ9yl6bfJbKp7kPNG9jT2p4Ei0aqStgaATn3r69of3uWN3ifTx5CJ14FmHa5T
	Lvjpt4py4dh/ff
X-Google-Smtp-Source: AGHT+IFZ8F2wXi48IVZenpQOrH5DZrRMNXs/JXKEj22vTrsl2NFuYo7YHquPhCVcBtbRl/WONq7N2A==
X-Received: by 2002:ad4:5964:0:b0:768:d8cd:17e5 with SMTP id 6a1803df08f44-799197edf17mr24758906d6.40.1758273197932;
        Fri, 19 Sep 2025 02:13:17 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-79351f71705sm25966476d6.39.2025.09.19.02.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 02:13:17 -0700 (PDT)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 1E63BF40066;
	Fri, 19 Sep 2025 05:13:17 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 19 Sep 2025 05:13:17 -0400
X-ME-Sender: <xms:rR7NaHjsQFcs5aDTv2VXVLNdXb9_pxMP_1Bx_ndi5MAZw-05I27sMg>
    <xme:rR7NaJzHBL1KHIatq7JOzdFjN31GWe6o5KpQpTIo142PuHO4_g56NOvps8PnL098S
    1N_Fyj-nwBSzt5NKQ>
X-ME-Received: <xmr:rR7NaFJ0Mu7EIWl08DNB_-kBf6A7gzBliS93rGueFk99Csc-zSWhIJEUH0vq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegkeekvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnheptedtteegjeefffeileevheeguddvleekfeeigfevgffhfeetieekgfffhfeiledv
    necuffhomhgrihhnpehgihhthhhusgdrtghomhdpkhgvrhhnvghlrdhorhhgpdhlohgtkh
    druggrthgrnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghe
    dtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhes
    fhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedvtddpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepphgvthgvrhiisehnfhhrrgguvggrugdrohhrghdprhgtphhtthho
    pehmihhnghhosehkvghrnhgvlhdrohhrghdprhgtphhtthhopehtghhlgieslhhinhhuth
    hrohhnihigrdguvgdprhgtphhtthhopehruhhsthdqfhhorhdqlhhinhhugiesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlkhhmmheslhhishhtshdrlhhinhhu
    gidruggvvhdprhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epphgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhonhhgmhgr
    nhesrhgvughhrghtrdgtohhm
X-ME-Proxy: <xmx:rR7NaO0ZqSAf2bLVlVfPY-9p8MKJ0n4DE0ZunMaGiFEkyJ8KzDkd9g>
    <xmx:rR7NaPfhOZWOxHWcUGv4Dh0JNMQ5I3bh7l4tAU28fgIGRB36ur__hQ>
    <xmx:rR7NaC7ZyIctnTg-ZNs7AKVz7qALDWyuyPxCsmjRG6t3BcVssH2X_A>
    <xmx:rR7NaC9jZx5ajRr_dVnJSy_lMdlyfVFKaC18LPeB2f3xVyDdBVTydA>
    <xmx:rR7NaJKWPxC0lm3eY3mVj6hWnz4-sTBchNKI7Az-4iZKZk9X1nKHGi_b>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Sep 2025 05:13:16 -0400 (EDT)
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
Subject: [PATCH 4/4] rust: lock: Add a Pin<&mut T> accessor
Date: Fri, 19 Sep 2025 11:12:41 +0200
Message-ID: <20250919091241.32138-5-boqun.feng@gmail.com>
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

In order for callers to be able to access the inner T safely if T:
!Unpin, there needs to be a way to get a Pin<&mut T>. Add this accessor
and a corresponding example to tell users how it works.

This requires the pin projection functionality [1] for better ergonomic.

Link: https://github.com/Rust-for-Linux/linux/issues/1181
Link: https://lore.kernel.org/rust-for-linux/20250912174148.373530-1-lossin@kernel.org/ [1]
Suggested-by: Benno Lossin <lossin@kernel.org>
Suggested-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
Reviewed-by: Benno Lossin <lossin@kernel.org>
[boqun: Apply Daniel's fix to the code example, add the reference to pin
projection patch and remove out-of-date part in the commit log]
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---

Notes:
    SubmissionLink: https://lore.kernel.org/all/20250828-lock-t-when-t-is-pinned-v2-3-b067c4b93fd6@collabora.com/

 rust/kernel/sync/lock.rs | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index 9242790d15db..cb00fdb94ffd 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -245,6 +245,31 @@ pub(crate) fn do_unlocked<U>(&mut self, cb: impl FnOnce() -> U) -> U {
 
         cb()
     }
+
+    /// Returns a pinned mutable reference to the protected data.
+    ///
+    /// The guard implements [`DerefMut`] when `T: Unpin`, so for [`Unpin`]
+    /// types [`DerefMut`] should be used instead of this function.
+    ///
+    /// [`DerefMut`]: core::ops::DerefMut
+    /// [`Unpin`]: core::marker::Unpin
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// # use kernel::sync::{Mutex, MutexGuard};
+    /// # use core::{pin::Pin, marker::PhantomPinned};
+    /// struct Data(PhantomPinned);
+    ///
+    /// fn example(mutex: &Mutex<Data>) {
+    ///     let mut data: MutexGuard<'_, Data> = mutex.lock();
+    ///     let mut data: Pin<&mut Data> = data.as_mut();
+    /// }
+    /// ```
+    pub fn as_mut(&mut self) -> Pin<&mut T> {
+        // SAFETY: `self.lock.data` is structurally pinned.
+        unsafe { Pin::new_unchecked(&mut *self.lock.data.get()) }
+    }
 }
 
 impl<T: ?Sized, B: Backend> core::ops::Deref for Guard<'_, T, B> {
-- 
2.51.0


