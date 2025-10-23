Return-Path: <linux-kernel+bounces-867758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87041C0371E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 22:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FC141AA01C5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 20:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7D5274B37;
	Thu, 23 Oct 2025 20:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ItMuDfsE"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AF023C50F
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 20:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761252720; cv=none; b=QjC4UOnCIhcrMsB3XXr7jnF9dxhklhuzX96t8W+YiGexY6DYWlkwWwFj/xgqZVGPzDn/j64Pc2u6e4Zn0L0oZO6dQP0d+fXxTrjmi/VtmKuyA3YLFgrEdEnC5XgX/4ZuXw7NiYnCYeSj2RBOamipxLN5d/apbQRb0ApgIWNzOC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761252720; c=relaxed/simple;
	bh=DbEVDp/1daO+lIxwr/wlCt81cejMYnz/EAuVZ6biFZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZUipTpG87KNCxdggovcS7JEECDBhoeVgdV3rjYetTphSJhFv33eCK/YqP4M2lmDkJxTefWv4CPul7xdOsTlwaNcaFSuRhZlmc4gHSQjbMzs3ogB9232K6P7rCpqz6DZTvAOE6O69m6k13mlUoeVY1ibyDsdWSqv7XRlnQR7hIBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ItMuDfsE; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-63e076e24f2so2681740a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 13:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761252716; x=1761857516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4UlHNTGv7yFHhaTac79ENYscEry1rz6cX/llqQj2Xi4=;
        b=ItMuDfsE40bhK4d0C1KnUxRcaqHSxB66UXgLtYAMWZs4GHdHYnss1q+ghF62UTzYg7
         UGn5teQvECvyJrXN/4oCZqO4wx1gQ5FJwjlrdDYNO9tkzYZ3qon4QkAgECxwtTx7EbwH
         hLcH7Vh+9jhLTxuLdL7p6hR71q3hGBRKvSeOebudrMl6EaOZUlY2SE1rEiLWlccLiVGo
         VTK/NMyoWEL44vqAoRBvFaxIrEWQlLWCu8HJBAMlRV9j1SEZzKFpCF2jxxmrIfDk48fM
         3GnRxe1zvy+kq7XdB4leG5QjkYD4G3+mlOYN60ckuTd6gM1L1PVH6ZKrC/g6NTVjdQUC
         aKcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761252716; x=1761857516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4UlHNTGv7yFHhaTac79ENYscEry1rz6cX/llqQj2Xi4=;
        b=ikvnAQsYaTDrVcSAyknldAD192DcveeYO1CfvPcyvK/I7nWWmLpE+LAjM7SlfA6LG+
         Q69zI4mnsC2UGppujjiJW/F2aBMYxrxWtLcBnMlKg+O/W5in7QcJDxA0QdpZGQpRuZ7y
         Ly185Ha0JdE3WTz6MqXnMvH2U2G9ifhZvu/Iq+LWHJr5pf24TUO+bRXiAoyiU+onlJKM
         9XW6CGUH003h1iLYaF/nf1HBtl+4TrESqP6jdrV6NWqk7A64JQkMsTPND5lQDZSnnL9T
         6nl/YiloGfkmYCtcwZyrOfm1acAldUg0l2SOE0cce3doPepUxgFtDmbWckvWK8xGZIjC
         w9zw==
X-Forwarded-Encrypted: i=1; AJvYcCV5C3qAlYinRLSNY25WgFuQ0t60++ufLIftw6pL10IjSU6pwuyISAUlfE0EKN5zFQYsP6O2OWON/6Ryr74=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4sxoGA/luYsyIZSOBPIGnlYZRnoywlERfgDBIjOzTlX+6DsY5
	s9emHEn14liMsJG0gRor0UDwzNFG5TidxauIoE1O4ECC6osk6PCVmjz/
X-Gm-Gg: ASbGncs1y42GMYsWNh3EfukGJt6D5AH/CdG8TkGg4wWB7ZxNqmyIqcqxX/rxIQbPcKo
	Woj74CLOdQ+J6cZZOyDSDNTf/sn+YxweuR/qG5xdJMd376TinZevt16+ROKMiCwpHWQ68KZfH5e
	cYpOGq5teKLHNjvFwZXXn4dS4427q8RQBuzLPCQ7kbUq75Juv7EjKzefc9h/oD6JzwvjuFh2gnY
	1pQIZ9lDGNuyGqtSvqCVCqzp3jpC+4fLqc/E8dI1agrWezrUJZYOafP8wlu7ZfUP1C1EnDxIurY
	rgAnx/S9o+8ZKKa+x+86vfo/c0kJ7rhz1vNqQMdZL4JC3pKW9fcniTpy2R6iWwKt4VTmy8pBIk+
	2ewr6Q1Il87QSkJXPlwNGmh/slmdGokZZ0xpXTbdqhbuWbIB3XzrQnY8gp6OeEfbNIlXjMx1di0
	jK0aCYyH67aLfwk3NWHg==
X-Google-Smtp-Source: AGHT+IFX0S8naZatH+IeZ+gFwMfUpBUu0mzJ5xLs/IvrcDwpmdXZobGQxw0XYiP34F1iyLjV8n51aQ==
X-Received: by 2002:a05:6402:50cb:b0:63b:ef0e:dfa7 with SMTP id 4fb4d7f45d1cf-63c1f62ccccmr27493360a12.6.1761252716410;
        Thu, 23 Oct 2025 13:51:56 -0700 (PDT)
Received: from archito ([2a01:e0a:acc:bb60:756b:64e3:20ef:1d08])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e3ebb3299sm2564120a12.2.2025.10.23.13.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 13:51:56 -0700 (PDT)
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
Subject: [PATCH v2 2/3] nova-core: Simplify `DmaObject::from_data` in nova-core/dma.rs
Date: Thu, 23 Oct 2025 22:51:36 +0200
Message-ID: <20251023205146.196042-2-delcastillodelarosadaniel@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251023205146.196042-1-delcastillodelarosadaniel@gmail.com>
References: <20251023205146.196042-1-delcastillodelarosadaniel@gmail.com>
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
---
 drivers/gpu/nova-core/dma.rs | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/nova-core/dma.rs b/drivers/gpu/nova-core/dma.rs
index 94f44bcfd748..620d31078858 100644
--- a/drivers/gpu/nova-core/dma.rs
+++ b/drivers/gpu/nova-core/dma.rs
@@ -26,18 +26,9 @@ pub(crate) fn new(dev: &device::Device<device::Bound>, len: usize) -> Result<Sel
 
     pub(crate) fn from_data(dev: &device::Device<device::Bound>, data: &[u8]) -> Result<Self> {
         Self::new(dev, data.len()).map(|mut dma_obj| {
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
+            // SAFETY: We have just allocated the DMA memory, we are the only users and
+            // we haven't made the device aware of the handle yet.
+            unsafe { dma_obj.write(data, 0)? }
             dma_obj
         })
     }
-- 
2.51.1


