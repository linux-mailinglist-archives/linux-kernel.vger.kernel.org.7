Return-Path: <linux-kernel+bounces-863021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 322CEBF6CBB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E72C19A49E3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982A3338931;
	Tue, 21 Oct 2025 13:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Bgyzk8Qp"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D5822B8CB
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 13:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761053606; cv=none; b=d6PwqP20CfY4csn8J56Fw/BFdys2C3+8wYafbuZCWYy0FTHMBKdAQ/sCtEgUN6hH3F1cigm0McznhoZHqmy65NYHwDDs1AmfTfIm4wNcCWaHcQOqhbB/udpFo2OjZBBf4Y4dps54PTd/RSR01dvpAM/0yfEzN5MhFc4iW8ffGnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761053606; c=relaxed/simple;
	bh=qytksjZdLTISpFuZRyMOiiFkZgrPPHjKD+Mj5pS8yUg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UQYSzos6XA0zrGyzm65uDOEVqkN3xPd14VXBzn0R87hGNzUvQV1Ut6ujW3LMe0r6BhZ/mu01/j/xVZ9vsUqZg/vTpRP1jCW9n+RlyJHKTiCMfora0XmX7Ot6S15jdwl72tffBzmQNQFQaPJo0qRNLQMeO5sYcJdkVSLr4OTrQVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Bgyzk8Qp; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4710d174c31so56784875e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 06:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761053598; x=1761658398; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=W7fDpabke6WhS46tT+T5FNys2Yr05OPqGRGg3toBdss=;
        b=Bgyzk8Qp4xj47h46EXJA25pSISKghqSGZO6GhqEKpYVQEcsqBdK/Ubix3wx9iu0lE5
         GgTilxXMZ1p0Pa38nL6FmNFVf/XCwyTATY9f4kMwHzTO2U2G+pV+HkXrqcA4gu0xZ0S9
         Q0ycWtwynqGQxATB9OtrYMtBRuqoWc46HC7IUTNY5bb0tuY8qIB+xSD0rgpC7i2jIUc4
         86Y+afobBhnD2wozWllDXWo+I+IfVoln/sCDOxoO/0sP6uGomdmjvlhgrB+PlvdGHqhn
         9tUqZIos9Opz5IiCwB973Fa+UgubKPaO4/+zSgU7x040jqGL4paMTOreyo4+TwLO2HTu
         WOSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761053598; x=1761658398;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W7fDpabke6WhS46tT+T5FNys2Yr05OPqGRGg3toBdss=;
        b=KrGm4UfP/GKXpG4Rxvqj2mjeqm/PRBkqmeA1Aq7FhbeD04tbNpToKB3vNXBu0GR5cy
         z/m29+vkQ8H7VcQok2yrqjbFMZ1GRO2JtqOQi5oelKSpjx0DiG/wLz2pbuWpnwNB2Vqu
         0OT1mg5NL21eNDq6SrcB6nd4oIA2POBGVDW1NYsvUjR9YB9EKcHyUYKzYP0cZUVwyUq7
         XB4IwhACzQOnNxRGJNtvoUu85rM3TwLSFjoc0ulAV+r7mHWNUPOTWMY1cM36MgCVGX06
         zTdheG+uo+U8S0p6ofcpgIlqs2Mp91kDAVVu6nn6dghai5oNlzG/oYnsZY+U6KLQHe0J
         97jw==
X-Forwarded-Encrypted: i=1; AJvYcCUaZrR6c0ZnH7XrymChpwwb+BOVkTlWjT+Mddw00Suhtsl6JKF5TI8ROj9QVgzVlq62CGt+nwMx0P1nQBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXukWVfgx7hXQwpyNuc16U2H72IU2q4U+ZtBMT7DW8JQ7BZCfX
	w9xnp+lSS/w02B7u49GliT4gPycLJUe3MyfWHxonU5GgdEKm/PBTj3bvIfl7nxU5Rzu4hEXqUPC
	Enk6Dju5c98n6hFir4A==
X-Google-Smtp-Source: AGHT+IHcH4JhLZmZhIV8KyVieSRjmkESC/bOub8ErG0T1qjHYU7NkdwZHbw5zRM/BUJluwKrwaIhdK6rgh5vdFU=
X-Received: from wma6.prod.google.com ([2002:a05:600c:8906:b0:45c:d828:e351])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4e0b:b0:46d:27b7:e7ff with SMTP id 5b1f17b1804b1-4711791f4e1mr119704175e9.36.1761053597714;
 Tue, 21 Oct 2025 06:33:17 -0700 (PDT)
Date: Tue, 21 Oct 2025 13:32:46 +0000
In-Reply-To: <20251021-binder-bitmap-v2-0-e652d172c62b@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251021-binder-bitmap-v2-0-e652d172c62b@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2867; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=qytksjZdLTISpFuZRyMOiiFkZgrPPHjKD+Mj5pS8yUg=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBo94uXiyeb+mK6EdxYRp+Hcgh6FeizN0nxE/D5L
 mEzRRFiCEyJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaPeLlwAKCRAEWL7uWMY5
 RnDFD/91iGIfnnaWvFEPSgghqmXHMRCCEYUUtXrbWuW+fb6NiAuTxkp7WW0mYI2qzaFIxOA7pHw
 DoHwg5ejs0NfdiljayEuy98e5XozbobC88QBzU0cCEp7jPBN+bzQtR2Zp5fbL16JF7+jRvANoDb
 fqs+SsBT0KuMgBbgEamRsvc9V0DsbRws9TNxQGSYFHHyuZw7wO4lFeqw6zxpZU/gmkMIlT2ZbSe
 JOHEfSvl5kWfFm9+4EoULvC995qzbpkP505x5hvXdfzLpDoQdMKqhY4UOcZelGiV9YeYSkchsaK
 AoDLfwbfSKudmTAeCJL5gJMutgxbb2FcI6lPhhYFiMEWiX93E1IcKBWBKoXdOqab0Al1f7iKOCf
 PLOTkNGXj4G4EGWl679ve40KJz7KTWOubKOGZt7/sd9qPn4s5rDRxS/dcyZ22TfGaPYo0hH5Z3M
 Kphh8rJzhn5dX/OBYyuRjEZZbu0KnOOt4LrFteCxsN2TQtKjYdp5/yaBci42Wh8wtqzXsFkXkwn
 SDemlcFVTPBysMm58t72SaKywIr2E8urVfIM2mnsXg+2lvwjO1niu8LnjZ4x6zx88QKVcBkxVPI
 P4OAfTqbJFItDSsmrVJ2XL7UOlHX8B9NkTKKoLhd09yp2SI6jFykcBqm9F7nsz6uHiLqutODFfl HGKYPhMQhZ1n6LQ==
X-Mailer: b4 0.14.2
Message-ID: <20251021-binder-bitmap-v2-4-e652d172c62b@google.com>
Subject: [PATCH v2 4/5] rust: id_pool: do not immediately acquire new ids
From: Alice Ryhl <aliceryhl@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Yury Norov <yury.norov@gmail.com>
Cc: "=?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, 
	Martijn Coenen <maco@android.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Christian Brauner <brauner@kernel.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Burak Emir <bqe@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

When Rust Binder assigns a new ID, it performs various fallible
operations before it "commits" to actually using the new ID. To support
this pattern, change acquire_next_id() so that it does not immediately
call set_bit(), but instead returns an object that may be used to call
set_bit() later.

The UnusedId type holds a exclusive reference to the IdPool, so it's
guaranteed that nobody else can call find_unused_id() while the UnusedId
object is live.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/id_pool.rs | 44 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 36 insertions(+), 8 deletions(-)

diff --git a/rust/kernel/id_pool.rs b/rust/kernel/id_pool.rs
index 126e57f34c3407cb1dab3169417f01917e172dee..053ca417e8513fc33afc84c194d7899eafac8fec 100644
--- a/rust/kernel/id_pool.rs
+++ b/rust/kernel/id_pool.rs
@@ -199,18 +199,16 @@ pub fn grow(&mut self, mut resizer: PoolResizer) {
         self.map = resizer.new;
     }
 
-    /// Acquires a new ID by finding and setting the next zero bit in the
-    /// bitmap.
+    /// Finds an unused ID in the bitmap.
     ///
     /// Upon success, returns its index. Otherwise, returns [`None`]
     /// to indicate that a [`Self::grow_request`] is needed.
     #[inline]
-    pub fn acquire_next_id(&mut self, offset: usize) -> Option<usize> {
-        let next_zero_bit = self.map.next_zero_bit(offset);
-        if let Some(nr) = next_zero_bit {
-            self.map.set_bit(nr);
-        }
-        next_zero_bit
+    pub fn find_unused_id(&mut self, offset: usize) -> Option<UnusedId<'_>> {
+        Some(UnusedId {
+            id: self.map.next_zero_bit(offset)?,
+            pool: self,
+        })
     }
 
     /// Releases an ID.
@@ -220,6 +218,36 @@ pub fn release_id(&mut self, id: usize) {
     }
 }
 
+/// Represents an unused id in an [`IdPool`].
+pub struct UnusedId<'pool> {
+    id: usize,
+    pool: &'pool mut IdPool,
+}
+
+impl<'pool> UnusedId<'pool> {
+    /// Get the unused id as an usize.
+    ///
+    /// Be aware that the id has not yet been acquired in the pool. The
+    /// [`acquire`] method must be called to prevent others from taking the id.
+    pub fn as_usize(&self) -> usize {
+        self.id
+    }
+
+    /// Get the unused id as an u32.
+    ///
+    /// Be aware that the id has not yet been acquired in the pool. The
+    /// [`acquire`] method must be called to prevent others from taking the id.
+    pub fn as_u32(&self) -> u32 {
+        // CAST: The maximum possible value in an IdPool is i32::MAX.
+        self.id as u32
+    }
+
+    /// Acquire the unused id.
+    pub fn acquire(self) {
+        self.pool.map.set_bit(self.id);
+    }
+}
+
 impl Default for IdPool {
     #[inline]
     fn default() -> Self {

-- 
2.51.0.869.ge66316f041-goog


