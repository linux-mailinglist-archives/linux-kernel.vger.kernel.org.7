Return-Path: <linux-kernel+bounces-824263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F41B8886C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 11:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DB79524AAE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 09:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392FC3016F1;
	Fri, 19 Sep 2025 09:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HdbmJC25"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A012FDC4E
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 09:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758273190; cv=none; b=LTCGXcPoeGUvfxFirdcRVM20thS+2BeH1NKjjCQjQLkMFISgnBoMCGmZLG92SU9WY8n6nnge2h2hgMxO5jJ32Q27M5KCRhsnb1pRdk1TFT5awfAjFArrB9IyYbh7MYIMN4nJMMgSTaxMCCkH5Zt84YJ88jRQVF6Z2t4kkK7g7HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758273190; c=relaxed/simple;
	bh=Lzovmfm5FiaEorEh9d/YkmbdKQ4FW9Q9fpLfGCU4K1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TxX5MgdpZ0fy6mnGtLOk+MDjTx/TMXsZFr4z9thUAyG6T69d9OYOjJqVqBkdPJFymCc85tw0g2GXzyED6hJ3KPN3DgXC3eH7WupHwAJ7AvwNrD6Tdm7ADaul32VdG4n5OtuMu0rAvFNCHgTPFi3S6wdzIjF4XPzEwX6bNQMGQ/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HdbmJC25; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4b548745253so30569341cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 02:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758273187; x=1758877987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kIwF6rXqWhVto9ZPqUAqlWxtbpHvuz3MRQbuOi5HJu4=;
        b=HdbmJC25TshYjud28rUPQqyU3sfKngH067nsd6b7RiZRMLUyz3SUNGdBNBmDJBjS8V
         Cg4AMRH2zIr4qwoXRLUYxMxEnteJjFkSRKzgz5Th60x6uXmijHvo3/AnVj3kmXAyHtpA
         rhcEQ+eferXCJfTFM5Jxy2apoyitg0bYSXSRWMbqtvhbpH6BGZOuhZuVR/ggMWUmuf9F
         tNgymEjhu1/SyYqBulq9R7l0ZVcZyWcPtnq9dGRy8mVzRtQK3UKzYcg0iVGnlT2WQTXr
         t01PwTWiXMoQ36zdsMpwYl/0DZ23OpvraxlnEJh4qZ2Tqx4I2ToBhYESLdXGr7bVjBMy
         0qtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758273187; x=1758877987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kIwF6rXqWhVto9ZPqUAqlWxtbpHvuz3MRQbuOi5HJu4=;
        b=u4eVuSMsaXoJFY0ReYR94vhzjU5qRx+4uvJoxkNi1B1eSJz7jL+crnZKzT2Sso4IY9
         bNAqvzcLU+5zX+l1YxHyGNfMuDucGyijjsGT86bGUI4gRNmEBn6RlAe8reqro91hhnfT
         5LHRBfWl6LBFTBV1KH89SWkYK+F4tpikVGrePjI5KUEaBwfF3IoyLfiICIs5U5fUeDFo
         2lpS/C58zhEszOiz/nvlLTJT4FFBFFyD8PyD+SmdN4hyvUqDJoJlNMz0wngoAc2w/ma7
         b6lRziiuQr4KzhJEjcYl8Xw4heXzBwljrkOXzBvViOsRekETDP/GEQ47NS4cJ9MPgQjA
         he9A==
X-Forwarded-Encrypted: i=1; AJvYcCVPyysYBH3ygtcfid6WynPhJ2YA5biiWPQB4PWpjkpSL4zUbz+P602q13lvRwGBVWpuUyveL71//Hq0uF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEpKNtCXo8MXGEdkiewSIYzCKek2BbuGWgHMVpKkOicqJfo0XX
	9HuKv3s0gpJiDe5jPTnPcwTgMtXVJy5eg9xKmJJGnTlGXhKgNbYhcfuK
X-Gm-Gg: ASbGncumpDxDC1YLPiKL0T0klQ+ze63Afx5gebWi5QguS1HnEeHYp+L9z2MTfXlIC1i
	3HBNFyssSBXGEDck2PDCopnBqr1I3U66Bt8SV0a/el92EkNdsJnKHa1tENg875G6oOH4WnreQAp
	8X7skHHjtWkGqIozsK5d4fLP+PSu/yl+Kef8AwhKfOsytR75B5NiPT5aIZL51JcCZdVdz0nHik/
	oA/+j8TGEXc+wtzf+Ad+rxJWob9FeMb8CRCFikcyfYTQtXyO/a9qRThB0r3PsXuJXl6BwzNeQY6
	KIVnQH4KGaEXfV5otm3UytndkTJM9NBJ9rFogYWK0qWBdddztjnEJ6w/4oZOILD+r3td2fXqf9p
	0WrlQWRkolLrrxnKkafYEC5L8gEiVRhkirmzcPH5rMBdnwsvu7feac90bhJpBVUYEV9qWcoGyYq
	14osHM0Aews/Vr
X-Google-Smtp-Source: AGHT+IGADpUlc4d6GuGOP+3nLljBkz9sqj/QHSoZhghqe3A6PffXI/lWFd81SOfDZ9Hd2vishRWIPA==
X-Received: by 2002:ac8:5dd1:0:b0:4b4:96a8:f79c with SMTP id d75a77b69052e-4c073c99e35mr31025171cf.79.1758273186690;
        Fri, 19 Sep 2025 02:13:06 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4bda2c6d0c5sm26674071cf.21.2025.09.19.02.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 02:13:06 -0700 (PDT)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id DBC8AF40066;
	Fri, 19 Sep 2025 05:13:05 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 19 Sep 2025 05:13:05 -0400
X-ME-Sender: <xms:oR7NaJMN8NIqYmxob3emmAK2QMQoXI8w0UgL_7fSePTA3eCwKW1RkQ>
    <xme:oR7NaBsiOK2_J3CiVO3uKdiLh9b728UehfAyglLpUQvo5f7A2EC1cF1VtJY59qJ7y
    7J9cFT8rHp0tSYcBg>
X-ME-Received: <xmr:oR7NaGUWcuZ9Fiy3wXwYhsNRVQowuvaqTIphspswsW-n7wztpQZIgg6C6zej>
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
X-ME-Proxy: <xmx:oR7NaAQu4uJyjW7e7z1Oj2ucAAiRAfL6szDlmSejkVLIWYH6jMqy8w>
    <xmx:oR7NaMIZyAaQOOwbbEN6uiT1dXxQ6TGlNt9WJMXFo00Y4WwrXscIqw>
    <xmx:oR7NaJ38miBjo4tiIWVqaTyO9madhc_aUBbrT8L5538tgPpb9Kuc7g>
    <xmx:oR7NaHIzCujDbDjjLbzXT_1WPIgnO_P51Oe8571E7o1EQg2miLHeCA>
    <xmx:oR7NaBl1ckk6cKCh5DTnvEXjyJ23FYv3bbqfDhl7VL3UWzpt5fzE6UO6>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Sep 2025 05:13:04 -0400 (EDT)
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
Subject: [PATCH 2/4] rust: lock: guard: Add T: Unpin bound to DerefMut
Date: Fri, 19 Sep 2025 11:12:39 +0200
Message-ID: <20250919091241.32138-3-boqun.feng@gmail.com>
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

A core property of pinned types is not handing a mutable reference to
the inner data in safe code, as this trivially allows that data to be
moved.

Enforce this condition by adding a bound on lock::Guard's DerefMut
implementation, so that it's only implemented for pinning-agnostic
types.

Link: https://github.com/Rust-for-Linux/linux/issues/1181
Suggested-by: Benno Lossin <lossin@kernel.org>
Suggested-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
---

Notes:
    SubmissionLink: https://lore.kernel.org/all/20250828-lock-t-when-t-is-pinned-v2-1-b067c4b93fd6@collabora.com/

 rust/kernel/sync/lock.rs        | 5 ++++-
 rust/kernel/sync/lock/global.rs | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index 27202beef90c..b482f34bf0ce 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -251,7 +251,10 @@ fn deref(&self) -> &Self::Target {
     }
 }
 
-impl<T: ?Sized, B: Backend> core::ops::DerefMut for Guard<'_, T, B> {
+impl<T: ?Sized, B: Backend> core::ops::DerefMut for Guard<'_, T, B>
+where
+    T: Unpin,
+{
     fn deref_mut(&mut self) -> &mut Self::Target {
         // SAFETY: The caller owns the lock, so it is safe to deref the protected data.
         unsafe { &mut *self.lock.data.get() }
diff --git a/rust/kernel/sync/lock/global.rs b/rust/kernel/sync/lock/global.rs
index d65f94b5caf2..38b448032799 100644
--- a/rust/kernel/sync/lock/global.rs
+++ b/rust/kernel/sync/lock/global.rs
@@ -106,7 +106,10 @@ fn deref(&self) -> &Self::Target {
     }
 }
 
-impl<B: GlobalLockBackend> core::ops::DerefMut for GlobalGuard<B> {
+impl<B: GlobalLockBackend> core::ops::DerefMut for GlobalGuard<B>
+where
+    B::Item: Unpin,
+{
     fn deref_mut(&mut self) -> &mut Self::Target {
         &mut self.inner
     }
-- 
2.51.0


