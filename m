Return-Path: <linux-kernel+bounces-863017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E537BF6CB8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29E573B5F13
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384753385AD;
	Tue, 21 Oct 2025 13:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iNtHh23p"
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BB9337BBF
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 13:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761053600; cv=none; b=nlXbuOY/mM5c6BCI2M0mQkTNd3QHBt5/KN1wbfXLxEZ4aCh5OEVUS5SwDVfm7OA63B3C2Kta8aN0VSxLmGxanKAf9bKE4AMTw/qYLGBUQbwiXlaifWQ80AfXNvnoZcvrkV5Jl/fKtAHHp8IPbnQfI2do7S99BpEJ19JBxndhpmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761053600; c=relaxed/simple;
	bh=A6RxU3d407/h6ii7XA5cbZXcWxUMs4eZ4XcLn/vNduI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=EA6xa4u1/cp75IreKY+MRS/ErWALYXG9pa/xJpJELPkkitJPvEnXqJMlgADNN1XZ4ol7YzQ/4EW6Vjvw6f6RMyT8Irn3H2nGaoFhvBZx8/1DlyeUKXKgsSohu3lMM1k6/QhL77K0+3luDKLnMHl5blWpqgnvzdYg9D0yTOR5EYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iNtHh23p; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-634700fe857so7143829a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 06:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761053593; x=1761658393; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Q3GWSfwNwQBfdouK4tXiIN+11u7Lf2cS+u2+hUWWhFA=;
        b=iNtHh23p4uoutYR9NrO0dgCGrosQ9MznRiBDh1mHyCSOHwsormjzzauLAImCCifHDj
         /fgHpw/U6LC4B34RECCathpyAP0stmfLCOpbNpUXTp42ew7ALDptrt6vN1Rnr642Qeso
         CdE1P2YS2Ne5K/jnfA01CzM/KUGdVHLt4DpXwYfBQs7/ohqEcpx3b7yQpylrsl7BPPXX
         ZMiPQL0IYOu4+oy56GswU67h7Rt09ND1EgvkBJUvhLx3qiABTjX8HThfMH+pyXyolrhQ
         yDiLqWCk60erNVILgWz/Bt1DZxdtho62NlDWT41GYxZokFGE3XXiB8SnCk4jVFo34JX+
         xJkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761053593; x=1761658393;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q3GWSfwNwQBfdouK4tXiIN+11u7Lf2cS+u2+hUWWhFA=;
        b=NuJnFkODvY+PBwOCswS+6xffovATlCdlbQm99HwOBfFPM1onjujaOIs25jDzttHdCD
         yeMzgR3s/JGzfWJegHRj+YJzekSJKxgM6F63Gh2RVtXz2VKsR7osVu/wE6UfoaNW+/na
         7F+Ul4HuHcK6YmY+ykpMiX7ZbAgrv65iXGTI5+F7JWu+1ZMC/f9en7OJ1bzpoLRlTco5
         dI1E9IeaYKIy1kRhBgDpzyGmGfIx+qnuWcWlj5pXaFjevllVEQKct0mlkMe1c8qL8AHw
         GZc1DJq17odYilUp9z07QwkMReop2cito/OSqReeekYUmexuRj6h9bViwG47jWVP+cpO
         I7zA==
X-Forwarded-Encrypted: i=1; AJvYcCV36Q5LuyC2zQKmjFelkQv9/IUpWZbZAUT+XUqod3hqwgEgUmfibRMwg3/lc64RUVzLaJXqhDQGfqojRio=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz08YfL/5xIbHn+ZthwpdpurOXfAO2rIFI4Vj7A1mriv6uuS8Xb
	PLsyVTU/vxltKNpLC46d5tQqUvS5IN5miG5SRsALKeoGr1+70QQqZ9ESmHAfMVh+IMyvzRVMP9f
	AS1b+VH3TtKJMIyy6lg==
X-Google-Smtp-Source: AGHT+IHzmq2GHxre9p7+AJiZ4NDjk5oFvnPBMZ24Sk1vhlDL3Q/7BVSNl0luNyHwtZk6i0LzY8aisFR+Iua2fq8=
X-Received: from edbin8.prod.google.com ([2002:a05:6402:2088:b0:634:544b:a748])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:aa7:cacf:0:b0:634:bff4:524c with SMTP id 4fb4d7f45d1cf-63bfde71e89mr15507759a12.9.1761053593075;
 Tue, 21 Oct 2025 06:33:13 -0700 (PDT)
Date: Tue, 21 Oct 2025 13:32:42 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAHqL92gC/13MQQqDMBCF4avIrJsyCahNV72HuIjJqAM1kURCi
 3j3ptJVV8M/8L4dEkWmBPdqh0iZEwdfQl0qsLPxEwl2pUGhqiViKwb2jmI522JWURuDTjfNOMg
 RymaNNPLr9Lq+9MxpC/F98ll+vz9J4Z+UpUBxa/VAVlvnrHxMIUxPutqwQH8cxwfCeQoQqwAAA A==
X-Change-Id: 20251007-binder-bitmap-5aa0d966fb1f
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=982; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=A6RxU3d407/h6ii7XA5cbZXcWxUMs4eZ4XcLn/vNduI=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBo94uSpJuEuRzWjpydbbzUkJLHpKSB/EiarGT+B
 SGkcCaCnUKJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaPeLkgAKCRAEWL7uWMY5
 RtklEACMQyajm/O2FGQdoPengjeaibNJB9dn+nzyuJ8a5H5/5lc0frf+RA33vyPkjUAe0io2+5I
 09j+p2RhYUEOdlNZv/umjqQty8Y4TIORlAdLDpcQMGMaOMTj1tha7qgD1T2MaSS1HgYWbQFi8fQ
 GJYlfSfZAYRMWCIpOPPeQAXhBNScLXLT+O161tzQkaa0eSFs3Ovwlz0S0MxK34D5aXEDQtK1yS/
 bfiBvBCi/VLy33xaI0xwLhUo0fdk3GTbypOHM3tLkqeQvxOmtgfIyIeVEscZwrSnXhitbYrdHzV
 yRm8tta0k3HUkAbH9qUNk3qTf72WMdkGfV2RH/NBXJcP+VZL6dXWw5eyS5ViKl8xKfq6p3Yq6qc
 o93vg+8yzSGPZaMmQavcb2Gnud2rrGdZMpVCR0dAVReCXDGZRRNK7dfGu0tCttVj7iM97dLOMuN
 ynwzv0SrWr1AVC6zjlu85YZyouGlkeb85pJAvSkRe6/YXGGG+JNKUAR2rWmkTz9rR6EpJA0oZQT
 IbIKeq1/A1s4NLybmk5qQ+yD2WaddyEJcdDbfSDf4j9rgnSDNGk1xo/b/t+eXehRlMxsO5zAvgM
 4NpagMrqG8iImYsM9itKa4zrjMmudSBeRr17rfGnOPAgCeMMJuxroqHttcMR2jCULjoF5UFtXCs 1tb9GkbRdZyLTug==
X-Mailer: b4 0.14.2
Message-ID: <20251021-binder-bitmap-v2-0-e652d172c62b@google.com>
Subject: [PATCH v2 0/5] Use Rust Bitmap from Rust Binder driver
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
Changes in v2:
- Use id_pool.
- Link to v1: https://lore.kernel.org/r/20251020-binder-bitmap-v1-0-879bec9cddc1@google.com

---
Alice Ryhl (5):
      rust: bitmap: add MAX_LEN and NO_ALLOC_MAX_LEN constants
      rust: bitmap: add BitmapVec::new_small()
      rust: id_pool: do not supply starting capacity
      rust: id_pool: do not immediately acquire new ids
      rust_binder: use bitmap for allocation of handles

 drivers/android/binder/process.rs | 63 +++++++++++++++++++++++++++-----------
 rust/kernel/bitmap.rs             | 26 +++++++++++++---
 rust/kernel/id_pool.rs            | 64 ++++++++++++++++++++++++++++-----------
 3 files changed, 114 insertions(+), 39 deletions(-)
---
base-commit: 211ddde0823f1442e4ad052a2f30f050145ccada
change-id: 20251007-binder-bitmap-5aa0d966fb1f

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


