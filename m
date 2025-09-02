Return-Path: <linux-kernel+bounces-795867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C03B3F8C5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0935D189F362
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E1A2E8DF2;
	Tue,  2 Sep 2025 08:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e7F3UMar"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A00228935C
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 08:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756802127; cv=none; b=mNWBBJXKHH770xIV7zC5nuNpP+8tH5rRhsSnWYdD/8BnvQ1+JvlUftEmAzrp9PJrnjhVHYkhRxoRRXcRNu8C4pEE1BdzuRyYDokMetumytbfAiKhxmmRXa2oK9F3DJITmqhg0oV37Z34o0jPqN96dk+ic/bqjGDrBQfN8Mwbc68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756802127; c=relaxed/simple;
	bh=LU9/zAm/vd85kZy9FSstWyTgOt4MnvxmhM4IBC07EMM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=eEfCKzQb6a3V51PuL+BVPf0VxlWQIvXJ9+th5PCLle+lPag8alGIKeygbD/1vAgV1IDTkC+hLn3u+stCY5ZMT42+Q3YtbxkF2CBXqh9i4HrUEDgjGfOkeqdSnwOWE33iDGYNgOwy3knpU14gqf4BKOE8Bot6fDszgEWghgeEnb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e7F3UMar; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45b9ca27a11so65945e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 01:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756802123; x=1757406923; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=L7MxrkiSkI0tgwRsjoY6xKHPjr8GHGYJw9pm6oGclAM=;
        b=e7F3UMari3qKBuHIu6USN8s/gdI6PdqhVdICx3hxBEYpLA8LwLRMYCQPjvTq+1oObp
         OahSNIroXT+0qP43ge2JIm4X64vUfXDONdDTc/wxqwTr/3xJkZ3N+MZXRO+axecXS+Zx
         fPFCZaZTLtXYVzFOiRji5W1ULV50sTheN79i0YJZBGOZ/WoyzB3WGKcSpIM7Rmh8PTIH
         0ZGHTT3EccHvbBp+etpxmXn1YdXcQa6g08874dwcPCNSxLO38hLmR0lNWYSI/FNJ9h+K
         gH0lSspshcVDghZiu/XaarNhs2tCNDL9hwxCXiRY8TMQNJz6IdZwhcBwLO150Vr4tNbZ
         D3Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756802123; x=1757406923;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L7MxrkiSkI0tgwRsjoY6xKHPjr8GHGYJw9pm6oGclAM=;
        b=FaU9AKjjYAu5eCsvnSTdwcattKamz32NaoK691tuLx9nDIIxU1KkqytVYo2YFznUF2
         01b2+frrVRsDO3am8yjTLAdQhw2SN3k7dNUtnhvUnLjUrFpJX/h33UvkNmpEoYlQ6/vs
         K+ICSmNaFmKFuyELfhb5SfgrUJNjMfkEcqh8cQSUr52J8mKbB1QLN38aorx9oI07GvlG
         OjPfKoK4PzOuholMMRjl9KCEOHz87Gx2DTn6dK6BLE2L6O3VlCxenK+M7VWTzas8Bzbs
         5+OuKfQaHueyw8b6NgNO7DXHtgkswX/mjqToB83mSDvnc56hE2kzOxBv9QebVUaAjiKz
         1vOw==
X-Forwarded-Encrypted: i=1; AJvYcCXLkHSTW5Yj2ppb2IOpNyRwMZ0QTeGhiXOONMED+H0aobbmMEBe6lKdzkFpTzNaoNSB4PP5BqQUrWhfjy0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbQboWrSuagLey4tUQ3WOhuYaJsGCERFUzERcXCrh/ktJ+5GgA
	Yt3AWCzjagtlTBc7JhkzHqWWi8ecnfycHkiwi7ADAKVTi4SOgUSV4PYHcA78DnRDTNZPMiFJzFX
	0G+Fzp6U0pmbyM3VWjA==
X-Google-Smtp-Source: AGHT+IGYaRH6+3dhGuOGyDm3NHBh3pZKdOxTCGZaMq2CbQ+83FErPxgEzC8uU7DS45ZE9EKybSIqQ/NQhW9R+YU=
X-Received: from wmqa17.prod.google.com ([2002:a05:600c:3491:b0:45b:81de:b730])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4817:b0:459:d577:bd24 with SMTP id 5b1f17b1804b1-45b84c3afa3mr61041265e9.7.1756802123520;
 Tue, 02 Sep 2025 01:35:23 -0700 (PDT)
Date: Tue, 02 Sep 2025 08:35:10 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAD+stmgC/23M0QqDIBiG4VsJj+fQv0y3o93H2IHaXwmVoSEb0
 b3POhnBDr8PnnclEYPDSO7FSgImF52f8igvBbG9njqkrsmbAAPBJNR01POAdAmIlOuWKVZqK6A
 iGcwBW/c+Ys9X3r2Liw+fo534/v7NJE4ZBanLRktrFIpH53034NX6keydBD+r+O1kYbdwM5Wqh TTanOy2bV8p8T0F4QAAAA==
X-Change-Id: 20250726-maple-tree-1af0803ac524
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2500; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=LU9/zAm/vd85kZy9FSstWyTgOt4MnvxmhM4IBC07EMM=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBotqxF/MbEuU83/mRGGj7liymTFS5P03Cv5j9Sb
 l7IyhjbakKJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaLasRQAKCRAEWL7uWMY5
 RnpKD/wMzs5gx8XfxeVmrJZBN7vjM0CxZyDAo3sGUyFY88ICB/YyiCVEA+P9JV4ZYiNGFIgEHIO
 3SvKLxaFADlTBrFI3SSW8QpuHj/ZMmLMZ+OGY2kJVGVb/v/cfwG/9CN8oAs/S9G5ms0u+CSGAOo
 qePBflkakDDtybP8cJoqrsu8fGO0oWh4Uv/qG0nPYySKMy5wi2Lyz3AG6cEy4gwvj07iA/NOUzd
 tgZ0KeINY9RbUD0+F9wTOlMJ6RTbyCFWRvTamk0Ttg35D+rC0A/C82qt+0HyVKKa7awhDAlxmJT
 +Wv0vzdoUcEM5YsgmuxOQ+jjCajTt2kuDmWm9y6zQl5CM/90dzZ4HlrLfaKavlOHtfAWcWh9bQo
 of/gVUgrjVlfSMVR5EJcudng0IXbf5O5Rn/4eE3HK9KQCqI2vGs5kKc3hktcY6gm83AMgAkfzDN
 sBtwAXe+31yAP4wtF43rYtsCmDzpM8X3ai8FRu9JeUio8gDw2Vw4BXOPO01ij+zBbu1sPfERD3y
 707JwJkCksfNpgAjsQLXRwzhGGkrtlwEoKYEBJ5aXSQP3V7ke+PpCvTuJUcR1/6pwOvx2mT7B9l
 fbWGRPBeJi/v56sEeeAfuzWfYxHmStPXZvnVIdikESCvZfUDZuXHJKfb8F2hrJhLlL2AlZgTUDD wczU/gyuD6+gJKQ==
X-Mailer: b4 0.14.2
Message-ID: <20250902-maple-tree-v3-0-fb5c8958fb1e@google.com>
Subject: [PATCH v3 0/3] Add Rust abstraction for Maple Trees
From: Alice Ryhl <aliceryhl@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Andrew Ballance <andrewjballance@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org, 
	maple-tree@lists.infradead.org, rust-for-linux@vger.kernel.org, 
	linux-mm@kvack.org, Alice Ryhl <aliceryhl@google.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>
Content-Type: text/plain; charset="utf-8"

This will be used in the Tyr driver [1] to allocate from the GPU's VA
space that is not owned by userspace, but by the kernel, for kernel GPU
mappings.

Danilo tells me that in nouveau, the maple tree is used for keeping
track of "VM regions" on top of GPUVM, and that he will most likely end
up doing the same in the Rust Nova driver as well.

These abstractions intentionally do not expose any way to make use of
external locking. You are required to use the internal spinlock. For
now, we do not support loads that only utilize rcu for protection.

This contains some parts taken from Andrew Ballance's RFC [2] from
April. However, it has also been reworked significantly compared to that
RFC taking the use-cases in Tyr into account.

[1]: https://lore.kernel.org/r/20250627-tyr-v1-1-cb5f4c6ced46@collabora.com
[2]: https://lore.kernel.org/r/20250405060154.1550858-1-andrewjballance@gmail.com

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Changes in v3:
- Change examples to avoid unwrap(), but not unwrap_err().
- Remove spurious MAINTAINERS change.
- Fix unnnecessary imports.
- Drop lockdep_map_p patch from this series.
- Reword MaState type invariant.
- Various docs improvements.
- Rename mas_find() to find().
- Add to existing MAINTAINERS entry.
- Link to v2: https://lore.kernel.org/r/20250819-maple-tree-v2-0-229b48657bab@google.com

Changes in v2:
- Add MaState abstraction. For now it only has a mas_find method. And
  use it in the destructor.
- Duplicate MA_STATE macro in Rust instead of using a C helper.
- Change maple_tree.h so that cast in ma_lock() is no longer needed.
- Add #[must_use] and #[inline] annotations.
- Rename MapleLock to MapleGuard.
- Change errors to use AllocError.
- Add MAINTAINERS file.
- Link to v1: https://lore.kernel.org/r/20250726-maple-tree-v1-0-27a3da7cb8e5@google.com

---
Alice Ryhl (3):
      rust: maple_tree: add MapleTree
      rust: maple_tree: add lock guard for maple tree
      rust: maple_tree: add MapleTreeAlloc

 MAINTAINERS                |   4 +
 include/linux/maple_tree.h |   3 +
 rust/helpers/helpers.c     |   1 +
 rust/helpers/maple_tree.c  |   8 +
 rust/kernel/lib.rs         |   1 +
 rust/kernel/maple_tree.rs  | 648 +++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 665 insertions(+)
---
base-commit: 1b237f190eb3d36f52dffe07a40b5eb210280e00
change-id: 20250726-maple-tree-1af0803ac524

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


