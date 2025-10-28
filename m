Return-Path: <linux-kernel+bounces-873607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 885FEC143E9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 12:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EA661AA6549
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2FAF3090DE;
	Tue, 28 Oct 2025 10:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lstSjdWz"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3173054EA
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761648928; cv=none; b=jZa8rbJQ+3W8LCK0CMMZUqsCJIA80io4/stzt7U1LCqjJVpI0IjqB243osYc0Twz63TU9ut6WONVUX5//IBGarjiZeC3l5EoB9utew/LYeFpFAOAyJ+o+Jcb2SrCVMPGyGaRvuudpJypqBN0DgT/0Pu1IGxWcNwxjp1FXgL9oY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761648928; c=relaxed/simple;
	bh=UE6ywXPRJUbBb9cAsX9Hq9tzePOnoCU35bVTMfeOOMM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Zj2sMgNGhVFWKZK83Aw8AQ+NYTGHGoAdNp8MwZI2nks2U9o/1cfiON458Bz9Tl1hKIugjzNrmGSiSG8JPHN2TF79/rEzJoTTAVzf0FhrLfCAjRkS5a1UnBpsKajeihhLsTjLYw9SyBVH1elAxrzPb/rmN5hQLKUbE9r+aSUVU5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lstSjdWz; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4770c37331fso14709045e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 03:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761648925; x=1762253725; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=l0c6uBRSvj90qkJBe+2p1+Rf+B5WpDvsjaWD6176zos=;
        b=lstSjdWzjWj/HXRPOfILujShNm02vidO75hTI0TL6MEES1xnJAIa7MPmHQ3/2mvO8J
         9QEehavIc9u70sVgjvPoNv9csvg+0p8/2OzIjbGZR5a3G4Zxh4tN3wEMAII7Kk7I0Ywl
         A9b7NcDJyMahUYJ8qS6orIBCO3CNg0JIsQlQTilbMrcMl3G3iJ+N5Y+ydrAJMjzTeqbY
         l83WMwDOBARMx6WSYuLyedJm3QtBQ1UI1wFYvUYXmeGOgNwLv090xiZbS4a7ddDKDzfC
         msJRgMbV+OzX6rRqSM03i380MIaAruqGKeQkSV8sm6ErXExApTFfH616fFgg+jnocJ28
         AgEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761648925; x=1762253725;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l0c6uBRSvj90qkJBe+2p1+Rf+B5WpDvsjaWD6176zos=;
        b=X9FIachb/bM/M6ddQ17aamLLjcx7SQbeD4pK8hrxWKHfnofSdF4CJJOPVdYqQAx2xY
         uN00U+4rRGO90JXI6CuN08wkUsI+0RBXZLxbXht5K5bE4GeJ7A3dFiBBFTgCRiy7JT5U
         qT+wRxLG+/eESR6zsAxFyahbfrAEMJwNScF0dyVSJ8/yep8CFh5s8H3eAYKPMbdO++YE
         ESFOrOyvJBT/Fm+/VBd4kKUovZWig2lh7krWVEru78UuV4OUlEug+zxSL32LRHw6bFXJ
         ZZ1pNSx/ib1A+rBjS6ZZXwmsbQFiouT8/NnNwdK3ItaMITi1YyGIxvSI96+1lm6KPn84
         SxmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNQ4QsrEYmb7YZ6MioCsMyw6PnUleceo+/C0PN/CzwFfsHGMfFLC3HkWF7dxEVp6P8FgLK+acxT9fnzkk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU7WHMaWeu2cAd+NnoEcy75TdkvUgwbJyxDYQrU4s122Hw1tRj
	h/IJoOzAJY6QWwhGniXGkTUfJumoPqPuYTvbTr0FUm9KgkHVV9Fe6ELV78Xz2W9+hknW8fC7Mku
	uxsfYnsriBgTrgqvlNQ==
X-Google-Smtp-Source: AGHT+IFzmh1BhBeJBjuO029iK4qw9Ix8hlxGx7v2jqCs8ObbbTFbar6Lj/km5aPi04Jxsj1XyWO3V0iw5i78R5M=
X-Received: from wmbeq14.prod.google.com ([2002:a05:600c:848e:b0:477:15b8:8ef1])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:a013:b0:475:dcbb:7903 with SMTP id 5b1f17b1804b1-47717dfd41fmr25732385e9.9.1761648924955;
 Tue, 28 Oct 2025 03:55:24 -0700 (PDT)
Date: Tue, 28 Oct 2025 10:55:13 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIABGhAGkC/12MywqDMBBFf0WybkpmirF25X+ULvIYNVCNJBJax
 H9vlC5aV5dz4ZyFRQqOIrsVCwuUXHR+zHA5Fcz0auyIO5uZocAShKi4dqOlkGce1MRLpYStpWw
 1tCw7U6DWvfbe/ZG5d3H24b3nE2zvt4TiUErABb9WtSZTG2sNNJ333ZPOxg9sSyX81eGoY9ZJl mihQiNR/+nrun4ATDIn9+oAAAA=
X-Change-Id: 20251007-binder-bitmap-5aa0d966fb1f
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1293; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=UE6ywXPRJUbBb9cAsX9Hq9tzePOnoCU35bVTMfeOOMM=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBpAKEWT6pQMlXT7Pn1PIG6vgJTTJY+ROhWS9Q/J
 Oti+0jIpqKJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaQChFgAKCRAEWL7uWMY5
 RlmWD/wMZGxAE60Prw2gR0J7Slr1yBQGjdOaXVoqHfPaZ4/HDFGkFLIvwY/JvBdGge8xQzYQ4oL
 7kFYHBTR2biHfPzwmwFWpd8T98Tyj5u4Al9zKa1vRIympmoK+lQ9vEEDPqSAFkikhUek7pNJcEL
 JS9cyr9WoAHgSd0Zy8cFgnEb9zMFKM1Om9sR0cjgMlVFyrp+rROdEi+OFSR6grc+7+SnqKibMtz
 GmeT8G5lJBMz9Jx/oPT89ZDnmMZ++dIDFMuHIBobW7vPajJ3v1YDDg3kCLWFiqHGFeoKxbkmH9g
 eEBQzt/UOQqxFkwER8094RHv/BFYQDDfVghJrNMXq0syzoMAXn+Dkd7u+OWSpWaXyXbhwF4+mpJ
 bLLFoF1aYb9MSrgZJjb3hS9sSw4ErSmijyEmZC9jy7u9NJz7ppmw8ZXtOuOtzsjHhdpA3clVYeI
 4hBPSdTqRV2SWzeDH4s7lpg5N5/MujWOAmDGnP6FxBL3m/MpLiEq9IwkXmN9ZoqYpA/E8X1vuo9
 WT4xE4zf04VTSjo6GxW3eL/8Ck6s/K2VdU4ml7HuXfinW6WdCMW5E6BENAgU71M5KSMP3HcVXNl
 bf80MzJn4wuNNjUAsaRcF0hNnQHX/WFfuiIV8Gsdiqhe5TiIKkoCmo+qiHIyirMrNBA2T+Dugbu JNopozjhQw7PSZA==
X-Mailer: b4 0.14.2
Message-ID: <20251028-binder-bitmap-v3-0-32822d4b3207@google.com>
Subject: [PATCH v3 0/5] Use Rust Bitmap from Rust Binder driver
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
Alice Ryhl (5):
      rust: bitmap: add MAX_LEN and NO_ALLOC_MAX_LEN constants
      rust: bitmap: add BitmapVec::new_inline()
      rust: id_pool: do not supply starting capacity
      rust: id_pool: do not immediately acquire new ids
      rust_binder: use bitmap for allocation of handles

 drivers/android/binder/process.rs |  63 ++++++++++++++++------
 rust/kernel/bitmap.rs             |  26 +++++++--
 rust/kernel/id_pool.rs            | 109 +++++++++++++++++++++++---------------
 3 files changed, 134 insertions(+), 64 deletions(-)
---
base-commit: 211ddde0823f1442e4ad052a2f30f050145ccada
change-id: 20251007-binder-bitmap-5aa0d966fb1f

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


