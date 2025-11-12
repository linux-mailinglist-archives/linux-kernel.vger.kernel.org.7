Return-Path: <linux-kernel+bounces-897230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E07BFC5256A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 13:56:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B089F3AD21D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 12:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E190335081;
	Wed, 12 Nov 2025 12:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WC2gDkQv"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA811D514E
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 12:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762951651; cv=none; b=euawG1u3FGbh788vdgCvzEIuwG41qjN2Eaz8tTNEXGigceYAia0kASZqEXEYj3ai5V3VuBcRtUZGKslUx7IMwNOyQI9h55w/WaAJrGFiQmSE1Vp96TMR8eyXGyXpAs1s4JVsYeL+JQDf7/YQLi1yartu4VONo0wBIlb380RpNJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762951651; c=relaxed/simple;
	bh=2n8HdSv5SayIX1EfgXK6Du5r/vgt9PeVrpIrNSlopSY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=nOD6GFNsVWUW+Rz80xJ61dbZJ3SlID1Z/SyuAhytl5JgWk8S3cnu4Ikdpm+B7h0Lbj6nEf6RISUV6so0LbJjdwVHujLK7aun0ymG8D9rfjYdHBV7KJXjOpfDj7We7B0U5WhTLlcfS2o4JGfw+DDM15r6w2knvM4PeOe7IBvhY5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WC2gDkQv; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-47788165c97so4879265e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 04:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762951648; x=1763556448; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2UrJz/ya7w/jX+dqGnuzup5Ax8rXpHpLUNlpWz2VFM4=;
        b=WC2gDkQvFozJEqZJ20XZ/q+l0C/30x+UBqr8G7XrPqZx95VcFMSuCu0ytlhiZGn17e
         Mrhp+mD8m7ZzrSZ9VOTaWGEd/QIXGmofLKBbT0VwF0/dK+IzMTyroYobNEFjav7T8zux
         UCtBU0SdxL79oBRj7ihvxM+1o2dV/oO6etlxtW8ki+VcqVRnKqLnTAbRv7FjFnfeoUuh
         WKlTFPhxol3uTb4I6FBYz4LRYOSZeCNU8mcjqbUv11f69RZ13yvxqXH/yPNHo3EhOiJC
         z/LP02DbJ9ZmHDHEQgs9qxbmHcZsubmgC7O2BsFjTJNRB80sa66kIov5g/8QRSuUiNzC
         TNow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762951648; x=1763556448;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2UrJz/ya7w/jX+dqGnuzup5Ax8rXpHpLUNlpWz2VFM4=;
        b=Ydue8scZwT9zAnz93I8SffoOCzs1Mnqu2a4STYzXKY5CAZB/FFonA4FwKs7sqhoqmE
         LlLccliyhXuKCY7/WB6exxqGypaabpTewlRk8zGJpWtre2yqw8R4/7mgqboFyiY0fb/U
         5PVkZp1LHY/Nm0V5YXa/z251K3DhIGoGHGj5eKad3fH69T7UWVM70q5bAyP1DdhP/J3q
         D/vFDd/wxU8gGB7AXr1372In/VGmOMa/1yeGOZCRdnsSEXmoUb7OLDMe7mJ671RQFgWl
         pC0/Z6YfjraYlT56E1VnXdfHQyPqhx6uRyiIWiR+M3AfLkxsv1AzN3YzozkIgdbilPC8
         YMoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFUaRx6eBa//RkF6l9K4RNxJ7GKEevgRvO+PbtVULn2pzeRgRKkyL4gWY+fG99oC+WGsGsUFxIYhpcpLs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0awROEi0QjF38OVMFF56BK5eWxmxXAwP1+j6JWVcE0srKGPfF
	aSRL8Q8G+8mebAExWmP5bzbZqg7oh1yj5K3UqRL4JDa9sQUgxso/CzyLftnD2fx58TkwMSdCi6/
	MsQUisf62aeIOGVAvMA==
X-Google-Smtp-Source: AGHT+IFItrUMlFfVZrMNt1klGSo5x8E4e4b+SZ9Q4jVPSGMjAvvibJwOikgd0fhs6UZKXMa8Rb7tEIDFbO3yyXU=
X-Received: from wmmj3.prod.google.com ([2002:a05:600c:4043:b0:476:4b14:2edf])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1f88:b0:477:be4:7a52 with SMTP id 5b1f17b1804b1-477870b62d3mr23223145e9.39.1762951648167;
 Wed, 12 Nov 2025 04:47:28 -0800 (PST)
Date: Wed, 12 Nov 2025 12:47:18 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIANaBFGkC/2XO3wqCMBTH8VeJXbfYOTqnXfUe0cX+HHWQTqZIE
 b57K4JKr8bvwOfLHmyk6Glkx92DRZr96EOfhtzvmG113xD3Lm2GAiUIobjxvaOYnqnTA5daC1c
 VRW2gZskMkWp/e/fOl7RbP04h3t/5GV7XTwnFqjQDF7xUlSFbWecsnJoQmisdbOjYKzXjL4c1x
 8SpkOhAoS3QbHj2y8s1zxLPsER0uclQqA3Pvxxg8/k8cUmu1KrWBkz1x5dleQKt7MoqaAEAAA= =
X-Change-Id: 20251007-binder-bitmap-5aa0d966fb1f
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1978; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=2n8HdSv5SayIX1EfgXK6Du5r/vgt9PeVrpIrNSlopSY=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpFIHapYyNWfqDYTrDWcEnT8bOu1Kd15weYsrx2
 O9cKkNMABmJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaRSB2gAKCRAEWL7uWMY5
 RsNfD/4hL71j7QUu7yCG2Fe2Pxz+R0xsnwMr2wejV0AdM6+FtPPa3g5Lf72qwMbLmGuHWaP/rJX
 mA1vCTBj04OSXl+ZyWLIj2PHGHLjzUmMnG2fCl2BKFVbdECmn5e6fvP98KIcrWaOdi/3gSKSKIX
 54Rb8lamOsWkBqtERHuXYaQrSYoUv3pLZkEjZFILk9fzMyiitRMpG0UtHROxVaQvMh+f0XajjCL
 EzJ9Yi3wEz5DzQStuBsCmclzMKd6mL47Q6rGzcY/0NW/8G5M8J6IaXVqPGzwgGA21oeWjk0rsAF
 WvJMG+ToO+Cz5PavZRx19sfu1lTqjs4CGAUzT9plupT0Y6viHXdBYEDyjJ5GtjgnTGT1xO5lB8y
 0iCb7Q7V6CTxoEpiN+GDRvBwWoR+4yfD2mz1067HqqBdu+JbN3I/dO8wW1NBVQw0UoJeSYSJmWh
 /YAbydDHU2N7hYQ8cKABT/IqbDc6ch70XdqBblFbkhyWw7oPjWN8LeE+l8nhggRKc08/yhgbXMj
 YyUjZF+hreEEySOgq2DV9rijm+mSc2WXXaAUfQU/ZMwnR9Dh8IYD/CNnMNg0WEDcTmqt5SaLg6I
 zrfYznH2DJx253EYyLxx8/RHPv0b63FmcfDGgzxU3n7iSvmRNKPgX35mDVxHBd2GSS7XJUN1Xir FyYBJUqq33Yu2eQ==
X-Mailer: b4 0.14.2
Message-ID: <20251112-binder-bitmap-v5-0-8b9d7c7eca82@google.com>
Subject: [PATCH v5 0/6] Use Rust Bitmap from Rust Binder driver
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

See commit message for rust binder commit for details.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Changes in v5:
- Rename NO_ALLOC_MAX_LEN to MAX_INLINE_LEN.
- Update all uses of MAX_LEN/MAX_INLINE_LEN to reference the new
  constants.
- Link to v4: https://lore.kernel.org/r/20251110-binder-bitmap-v4-0-5ed8a7fab1b9@google.com

Changes in v4:
- Keep existing IdPool constructor (renamed to with_capacity).
- Undo docs changes that were due to the removal of the existing IdPool
  constructor.
- List id < pool.map.len() as invariant for UnusedId and mention it in
  as_u32() comment.
- Fix [`acquire`] docs links.
- Link to v3: https://lore.kernel.org/r/20251028-binder-bitmap-v3-0-32822d4b3207@google.com

Changes in v3:
- Also update documentation to fix compile errors.
- Use new_inline() instead of new_small().
- Reword commit message of "rust: id_pool: do not supply starting capacity"
- Change UnusedId::acquire() to return usize.
- Link to v2: https://lore.kernel.org/r/20251021-binder-bitmap-v2-0-e652d172c62b@google.com

Changes in v2:
- Use id_pool.
- Link to v1: https://lore.kernel.org/r/20251020-binder-bitmap-v1-0-879bec9cddc1@google.com

---
Alice Ryhl (6):
      rust: bitmap: add MAX_LEN and MAX_INLINE_LEN constants
      rust: bitmap: add BitmapVec::new_inline()
      rust: bitmap: rename IdPool::new() to with_capacity()
      rust: id_pool: do not supply starting capacity
      rust: id_pool: do not immediately acquire new ids
      rust_binder: use bitmap for allocation of handles

 drivers/android/binder/process.rs |  63 ++++++++++++++-----
 rust/kernel/bitmap.rs             |  43 ++++++++-----
 rust/kernel/id_pool.rs            | 129 ++++++++++++++++++++++++++++----------
 3 files changed, 171 insertions(+), 64 deletions(-)
---
base-commit: 211ddde0823f1442e4ad052a2f30f050145ccada
change-id: 20251007-binder-bitmap-5aa0d966fb1f

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


