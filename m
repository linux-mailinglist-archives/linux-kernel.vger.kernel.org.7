Return-Path: <linux-kernel+bounces-885415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5728AC32D52
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 20:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C3063ABF40
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 19:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6512DF137;
	Tue,  4 Nov 2025 19:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lSr+U9qg"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0BE2C11CB
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 19:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762285088; cv=none; b=kTOEl1zc9RrAMwbKI6ZlkrViQ0/ro/27Grd00WcM/++SAoB3IRFDYkGCrCia+je83hJN2wA1K4u8MQzzeGVgk5nRY5JbglDFKpHUJJBsNRQRvEpLQ+a00FUkfz1o7e/j0GN4YQpkFVuRSwktEyyPFIc80kjYovWXJrm4ah41/20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762285088; c=relaxed/simple;
	bh=3pYC4Iey0LdseRucUJ2RjhbYeVK5q6IOowwADEtVzQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cBhPeop6OLxjva0vKSIGzlwC3z2PWvzArFa/FYD0TKQaetr6jWcOXh+dX33Va71ykW8o9Ev6lhA+5czWJbfkrTKDGOkW6EK9qCGfnzwpKju8wZpDs+iH2pF37bUx8WZzFB6kfonUIMf+ivcPjH6Fl0JB0/cZWby5P2yvrLFN6AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lSr+U9qg; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-42557c5cedcso3581426f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 11:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762285085; x=1762889885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fYgheLN32MsYWSBCELea5jaxOC/f7khm7azED0VQk/A=;
        b=lSr+U9qgvSUApP3hCVL9arkpEZ+pAsMel5kCqWI7emW7XTMMXanoDcz1tOEtQQS+Ns
         I9cG/if3YzrR4ifL7mZEQyXrPQCNGtuWBQvo0yEvrwyYhDOZ4SiOQr5ybkhxKPtD4MSL
         WjkjIO4E8tX/YbDg3ATgRt5NX99tW60ew6G4kbLc+lL4qIuVT/4NrezWjBX0hZg6cfls
         /equ1eKdzZLyAorzIO5e7OacGkS1gCtNp5JLEJHYe+SoGeFl66R/2TDQsW8ppU4wKfzX
         RMIv6VE33AzIQRE+Bfn6ei9NEvdAlxqZzZsn4AR6VyPhikJzlTZOL1SQWBMz+otXuaJg
         G2Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762285085; x=1762889885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fYgheLN32MsYWSBCELea5jaxOC/f7khm7azED0VQk/A=;
        b=LF/fd6McR/esBsnW4pojFkaAeJyQ61h8Xsmry42nEimMkURc7eQzMWv6al1rFJt4+y
         rqXYvK5ESgeBVNIFh+Om219b4P6sUJVcciQx9XuQtx4B7OBgV/6h4xKgVLIZgIqd9CiE
         kXruTEgOznfR3Gpw+lCcqKjl1bNZ0ExyLFxnrfzli2WvS2Tha6nHGDB5Ziu4JtCRy9En
         H+wuAvABwQ2prOwrf9uEQRQcve4Cr2/MW0WWWY1GRNleVKHFX2/txqK0x6fwwMjSslKA
         TV3iuAIv97rJuY6lEQ59jN/tx1RricjL1hFtlrWDn+moWmfCNZ/8zFBXqaaG2wJmJ4n1
         Qb7A==
X-Forwarded-Encrypted: i=1; AJvYcCWM15oC2cQxef8GhuCiAk/lvwype8mpMm9CBRZsWRKG6Vjj1+WkitYx/a2wRPZgNxuWXSBr+hSoK1qhgwU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH7JPrTJxQzMIFC5h82xHgqfIwnm8TtDWUoM8roIuOfNQwu5We
	Oc7Qf2CPqjcFSwmLFxSIxTmoyBe3K84w7zAX76IKzOiAmj0prww7JnJT
X-Gm-Gg: ASbGncugbRpSyQ7HHPZrFT2MYrTCW+r2yR+iV5zUwAT7zogLT5jiXZoAaSKvycPAZ4E
	DYruCrMEx47H4dfqPifNpLWS5fFjvH+bzykqN9A7b7cfyjeHCvRAR5drkgsBKs7R6AR6rreOmeX
	SjGHKSPrrTZtr74Lt6raT8vBePOHLimW87/R4KJVzZRurtp3EhnwVh0q/jxlLcRaqURQfBnQvf/
	niVxNpF/oyw7Xtv5TSJ5d828HHgs98/VO3bNvbSWsQEPN4bBSisEEBqlhbrmL9+jsGPpYtI28lq
	pbM0Tieh1gaaM4v6o/4YdHut8hJjlFp+Fbx9zfU4yPDUzIxCIpJyeVwcsfYvEMxNCYgpbWca1SG
	TgDSq/iRSj6TWW2VzllMjtkS56MNy8WVDh1kpGKrwVFqCzbgNQbOFxgNL2eN/DYPNY+u8+bSnat
	p/kYYsuiandlz3vR4QCQ==
X-Google-Smtp-Source: AGHT+IGkjMaYQNAOAYMzRxYOldsYeku+UMuN0PlwdK6jupihKC6msqilxvcotQ3WG/fqCuJVIjKe9g==
X-Received: by 2002:a05:6000:210c:b0:429:dde3:659d with SMTP id ffacd0b85a97d-429e3309ae3mr294212f8f.47.1762285084988;
        Tue, 04 Nov 2025 11:38:04 -0800 (PST)
Received: from archito ([2a01:e0a:acc:bb60:756b:64e3:20ef:1d08])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775ce3ef38sm5549195e9.17.2025.11.04.11.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 11:38:04 -0800 (PST)
From: Daniel del Castillo <delcastillodelarosadaniel@gmail.com>
To: Danilo Krummrich <dakr@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>
Cc: nouveau@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	rust-for-linux@vger.kernel.org,
	Daniel del Castillo <delcastillodelarosadaniel@gmail.com>
Subject: [PATCH v3 3/4] nova-core: Simplify `DmaObject::from_data` in nova-core/dma.rs
Date: Tue,  4 Nov 2025 20:37:50 +0100
Message-ID: <20251104193756.57726-3-delcastillodelarosadaniel@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251104193756.57726-1-delcastillodelarosadaniel@gmail.com>
References: <20251104193756.57726-1-delcastillodelarosadaniel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch solves one of the existing mentions of COHA, a task
in the Nova task list about improving the `CoherentAllocation` API.
It uses the `write` method from `CoherentAllocation`.

Signed-off-by: Daniel del Castillo <delcastillodelarosadaniel@gmail.com>

---

V1 -> V2: Split previous patch into two. One per reference to COHA.
          Added more details in Safety comment. Let me know your thoughts
          Kept the original map to avoid a temporary variable

V2 -> V3: Fixed compilation error.
---
 drivers/gpu/nova-core/dma.rs | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/nova-core/dma.rs b/drivers/gpu/nova-core/dma.rs
index 94f44bcfd748..9acbe2e4d4e5 100644
--- a/drivers/gpu/nova-core/dma.rs
+++ b/drivers/gpu/nova-core/dma.rs
@@ -25,20 +25,11 @@ pub(crate) fn new(dev: &device::Device<device::Bound>, len: usize) -> Result<Sel
     }
 
     pub(crate) fn from_data(dev: &device::Device<device::Bound>, data: &[u8]) -> Result<Self> {
-        Self::new(dev, data.len()).map(|mut dma_obj| {
-            // TODO[COHA]: replace with `CoherentAllocation::write()` once available.
-            // SAFETY:
-            // - `dma_obj`'s size is at least `data.len()`.
-            // - We have just created this object and there is no other user at this stage.
-            unsafe {
-                core::ptr::copy_nonoverlapping(
-                    data.as_ptr(),
-                    dma_obj.dma.start_ptr_mut(),
-                    data.len(),
-                );
-            }
-
-            dma_obj
+        Self::new(dev, data.len()).and_then(|mut dma_obj| {
+            // SAFETY: We have just allocated the DMA memory, we are the only users and
+            // we haven't made the device aware of the handle yet.
+            unsafe { dma_obj.write(data, 0)? }
+            Ok(dma_obj)
         })
     }
 }
-- 
2.51.2


