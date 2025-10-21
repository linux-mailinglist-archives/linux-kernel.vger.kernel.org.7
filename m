Return-Path: <linux-kernel+bounces-863019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F290BF6CC7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 59CC150302F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3331A338902;
	Tue, 21 Oct 2025 13:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RWVksaxu"
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2E0334C00
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 13:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761053602; cv=none; b=HVJLmvdhK8RLuIcQFt/wq6Vc3Bdnc0X7N/eFre5vhcU6/8ll/PV0ydowFE4yaRTlH+UxM2bpXtpjAxnVNT/WDk0J8Jr6cFJLOCaLJR+++AeoreHiChUUGWkxTsneLdQkDEkIG8NQYj2+IONBeR5/DcWKB9a14W1KIboMztU80do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761053602; c=relaxed/simple;
	bh=0XwGJ7KDobiszudqfhO29Z8TfiNZOYymA4jTezIL42U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SXRKSqmtNPIBGOpGv9HMRRkqMfXhkmAVgH6RJ8294018Pjn7lBxBAV7Nw4fsdGwNRUKjYp5n1FTwpTS9a3S8CP7DEYfv9SZCaFOp+mx9i8NLx5s8e7wWn/mhiupNr+v0P6xDCTXFErQhf1S/jkp9Nqe77GOuOSqCh8cQzGwwqSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RWVksaxu; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-b41c67edce5so245536266b.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 06:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761053595; x=1761658395; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q6129u1iYIYEuovLQaBoD4UN49cUgQbvN63SjRIKPAc=;
        b=RWVksaxuMDqj72Zr0ENwr/mCn92KnmNJcMuaSYtcE/AFcaTf58anW+Aq5pQfrm8TtY
         QJ3sNntwX5qo9j2dvZ3/4sGoYCt1fFzSOl6WtrpnXWq4m+5ecjea0xCHaUyZtFcZbxca
         1PmoakPLyCId3iPZJ7ljJaAk8HXViOAOL8k6rXmCRg6RD5ZRRo7ic4sc8V1PwFjJ+e6k
         L7FYX5IehFgp0XsrUClsfiu6SRhqastBT/lLBGchm+GJ341NsDeafWd/00KBcar+PwHT
         YdQvVHO5EAbJ33RFR+h3hYgPqyDst/s/51ojjv5X5LV9y675VMkeTucPUxS+iVpDW4//
         ZcvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761053595; x=1761658395;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q6129u1iYIYEuovLQaBoD4UN49cUgQbvN63SjRIKPAc=;
        b=iR0qiIKAnOdp+0cEXigvY0JCpn8VBrv2cqWSc7QWGqCUwfZdm3iz7CYrSSKvKVAqlN
         68uykE1VImCVPEhrCOSVG34JN0deGNQ0w5o54I1vtgiaMiFQ0rfHeZIs248HtpOr34D8
         EprJNpk3CzlxnNNIp6TVS3aVsXt24KqPwRvVfd57jKbGUnkQwoNC4RmPeNe+uYiZ3deB
         sgslRnyf457yBzhAh9X/7SXyuJZP/vPm1zk4erAalcETvy2CGmK4CvsOOOy/5e9c9nd+
         f6b7DJ1TwypugTLvrTK6vBsQRMvOYm5/cJH2DarR3tHzNwU7BHNvqOfTlKsrgIGPWPlV
         DOAg==
X-Forwarded-Encrypted: i=1; AJvYcCUsFd0rUKeJHztkFSUVefZAPtjGWkOHRcVdXEGejcwPaDbiIkpDO+l/LDqTJ3BPRK0LcFl6wuB1kvA2vRs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE9bMprduvDrDW7ARYKzKEizpCHAWeJ02YYzKooR6sk78pGlmf
	ElO8R3vOeQaJ1OfGU+IdsV+obvQpxYxxB1mLl4/jPIk6BrlPB6M1ZngVYlrp22ZB2DuJZnjsVGB
	b5RHBK0jiXMsDNMbSpg==
X-Google-Smtp-Source: AGHT+IHthMiXGy80jMaZ8NO+FgSnNWOqiBcpthOR/vfMJffUIA/kav+FOdeCi5No06nwwHWSqxBb+3FBKrB/lAU=
X-Received: from ejbgv24.prod.google.com ([2002:a17:906:f118:b0:b48:5a27:695a])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:6a1e:b0:afe:b92b:28e9 with SMTP id a640c23a62f3a-b647423f370mr2051191966b.49.1761053595245;
 Tue, 21 Oct 2025 06:33:15 -0700 (PDT)
Date: Tue, 21 Oct 2025 13:32:44 +0000
In-Reply-To: <20251021-binder-bitmap-v2-0-e652d172c62b@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251021-binder-bitmap-v2-0-e652d172c62b@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1143; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=0XwGJ7KDobiszudqfhO29Z8TfiNZOYymA4jTezIL42U=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBo94uX6Ot6RnX1kq5rBoe1JUBm01b6sLrSgsNH1
 eKsmbT+mcCJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaPeLlwAKCRAEWL7uWMY5
 RjfND/9CZXLAKgrrXYLqvMdfR8KG2+6kgkJSVz/EOx4eNESv/IO6/C27XHCmPinb9KlxDcdav18
 aYSFcqBOpC46LSJbsy90DqSqte+m5GXPToraWHYXv82fGe4erjE3HsmuczbkSqj0NHbG4UZpaHh
 69juPv50aIuU2SP2hJsIWsbVvv3NZOEb9/RCVRWs94HrTrX0CeqGBEKPQPpzC7fAE+EC8cCvn06
 R6WaDVrVLumwC4szYX73+tymfucNpeYh6UkYKlYB6uPlnVFBExPuCnqGL+nZJ6pZ8/9AjUGwrRi
 2LyQK9ykynZk943Gi3dIKDt2PgFk7HlXmu7Qd3ylp69IzCWe0jLeZRa+2yj+B2m2LR0lchGfBp6
 JYVBwsoYEPsUZIGuiffHpPM9aPRghyptFWjLTV5OKlQdkEwqeELRm8WttpZTBavnbQajHZxdG7r
 ZGB1qWVLxoFGQ1HS6QlaffQcKJ+vABQUse+JfPnYrHHpkdhRw5qn3k55gn/atSodOjsUw+z1M/C
 16DGa6f0WEbf5p3T0goHvB1JeDJUIuVx/QMA9ph2GgZxEbkHWHreI+q0/5mZq642VU0b+VKlcu1
 lVyKhDshbxDEmhvsCdUcUcM1T30endAzOjHOcz+c+4GRbZmxo+pVlat/t6bzT50UlPa/PxqfuxD +OM1cn2CppoUvww==
X-Mailer: b4 0.14.2
Message-ID: <20251021-binder-bitmap-v2-2-e652d172c62b@google.com>
Subject: [PATCH v2 2/5] rust: bitmap: add BitmapVec::new_small()
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

This constructor is useful when you just want to create a BitmapVec
without allocating but don't care how large it is.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/bitmap.rs | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/rust/kernel/bitmap.rs b/rust/kernel/bitmap.rs
index 15fa23b45054b9272415fcc000e3e3b52c74d7c1..4ffe9eb0f208a3d62016e00297f5a0800aa33336 100644
--- a/rust/kernel/bitmap.rs
+++ b/rust/kernel/bitmap.rs
@@ -232,6 +232,16 @@ impl BitmapVec {
     /// The maximum length that avoids allocating.
     pub const NO_ALLOC_MAX_LEN: usize = BITS_PER_LONG;
 
+    /// Constructs a new [`BitmapVec`] without allocating.
+    #[inline]
+    pub fn new_small() -> Self {
+        // INVARIANT: `nbits <= NO_ALLOC_MAX_LEN`, so an inline bitmap is the right repr.
+        BitmapVec {
+            repr: BitmapRepr { bitmap: 0 },
+            nbits: BitmapVec::NO_ALLOC_MAX_LEN,
+        }
+    }
+
     /// Constructs a new [`BitmapVec`].
     ///
     /// Fails with [`AllocError`] when the [`BitmapVec`] could not be allocated. This

-- 
2.51.0.869.ge66316f041-goog


