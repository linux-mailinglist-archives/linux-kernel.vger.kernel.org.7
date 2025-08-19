Return-Path: <linux-kernel+bounces-775425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C77B2BF0A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 12:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E3BA6832DD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 10:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3DC0322C6B;
	Tue, 19 Aug 2025 10:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hl1ZCFcs"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0CF1E5207
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 10:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755599694; cv=none; b=YFsLAM4msFSV/B1j+yA5Ad3wuZ89TN8Bd3VVlgCwsQBDNFi1d4JC1k9GwKuaeZdDG3uUrTMoUfM+BpCEeNn4Nk9w7ZS4SCDx+bM02x8G43nuPWYfwZzEDrEGs61R/VLiw+pO7nfx3viPexk8lGZoXK6gPhcq43AlQ9/I6vEi4R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755599694; c=relaxed/simple;
	bh=WpPROqoo0BnpflYnwbdZ3+4XjUHFfPcbIfG6DdIRDRg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tV03FvDZEOUed1DhxJk8+lTD78hM7qS3Dy0Us8o8CZF+8vg8ZhOp8HNNQysd9WPPsRn7+7ac1VwDF1x5d4yuAYTpLI8yoTxX9n2JBY99CsQBGi9lnjlLUALRWsbrSAekNRzaRklCRBFGTd9y5dD924WhaHKc8eZ4BPTupzhRsa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hl1ZCFcs; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3b9d41bda7bso3128782f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 03:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755599691; x=1756204491; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nUpwGXtPsuYcZiqgPmHlEahRTTleAV9z3vih0hihcig=;
        b=Hl1ZCFcsBQOK/6ypaOZaBfKYBT9fGJNySR0V4CtxEQ2y96allbEBO6/+u8nlUBf3L1
         Uhjo94UB+Vz+OzTviGBbCY5nVAbzQcubWWcgB+FPR/supe8zLJc7pmWHY35jTzwLCNQ0
         IsyfTOEubABkkX2z0EAgQXv73K/Drwt8uatLdhW38pdfzsum+2/8sXY5ecM+1L2YoHFq
         TuyTkhh0/E2VPQqNW23jri5R5FK27pGJoWvQnMuAruq894j9M7fh3nmau7WwiZ7Euk8X
         MEzFqYshsLFTs3ptUuH6ogLZZzdIJH2byy1YK9t+2YHxnWExNmdlide0JAn45W1ie1fP
         CG5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755599691; x=1756204491;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nUpwGXtPsuYcZiqgPmHlEahRTTleAV9z3vih0hihcig=;
        b=X00XjfMIG4c5HEa7PA1/k2vyxuEqceTwbhmaNjFB3RMzI7wWwFYYVPmjM92WWGz+U7
         2NsdXEoYnxXJfLDOfbDRqW5DRIbD984X0d8Fa2gl6LfFoFLE7amZc2gZ11sarN9wJHUU
         7IV8+O9kAE5MeAYJI0Extu26nATThfrglnhqSdKrNF6JHCLNk+a2NC1a9QYgH9C7OZEP
         nO6S5HCZX+VwjhHUX+f6UUrnr8TIV8BdmCrV0zR90KDir8HQ6ETVVPhE1p4yEI3P4aPY
         PlvRVvEzkoFjMQHiH2eus8hsy/rsQqM/bzBPZ/jqPJedhtB9g6Zh39MHzVkfIWniIfZ1
         xoHw==
X-Forwarded-Encrypted: i=1; AJvYcCXlY7oFG4ouS4RvT5m9CLIZQGFPbb7gx9cENQs8E1OpJj2Xd23vX542EFe1gv/LuxM/qKOqOqq7ZJK1zPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNCqqNQMkciKtWwPL6qOvVDbToV0oTudLSgd6f7d6gxZx4UCkm
	yuvrmfxW7jsg1BuqF/vk0Y7eyeioR8AE7jDhoFlb5sDgandCDHydSE/XqNGagq2GMsyD5j9MK+X
	3op2BSSKakoDVS4zPdQ==
X-Google-Smtp-Source: AGHT+IGwEKfiF+9R3ev4WMuyEM9qUSGM02LhWEvdJ6r8tdnWL1vLQrgTalKgDTZQ4mIrG4nr5x4DKyVjTzGONUA=
X-Received: from wmv20.prod.google.com ([2002:a05:600c:26d4:b0:459:dfcf:15e4])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:588b:0:b0:3a4:f72a:b18a with SMTP id ffacd0b85a97d-3c0eb420967mr1536920f8f.26.1755599690768;
 Tue, 19 Aug 2025 03:34:50 -0700 (PDT)
Date: Tue, 19 Aug 2025 10:34:41 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAEFTpGgC/23MQQ6DIBCF4auYWZcGsBTTlfdoXExxxElUDBjTx
 nD3Utdd/i953wGJIlOCR3VApJ0Th6WEvlTgRlw8Ce5Lg5baSKvvYsZ1IrFFIqFwkI2s0Rl9g3J YIw38PrFnV3rktIX4Oe1d/da/zK6EFNpi3aN1r4ZM60PwE11dmKHLOX8B3RzkYaUAAAA=
X-Change-Id: 20250726-maple-tree-1af0803ac524
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2199; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=WpPROqoo0BnpflYnwbdZ3+4XjUHFfPcbIfG6DdIRDRg=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBopFNIbiYozs7ReLuZ9YQ5+qDzKU7SUGnD5DTvo
 nA+LqKnJhOJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaKRTSAAKCRAEWL7uWMY5
 RsWYD/9u80fITsQA/OqvOLTayeWvQaATgmkD9aebtT0oG7GJK1+QwKLoQysRbw0BPu8GOLH73CS
 0FRJ559/nmiTlynnEUBo9V4j51BmTYMW9RJNAJxwaEVjBPqeoo+2vwW2NQHo81RaVowtTRRcgXr
 DJf6yXXKNboZiSj/rLnfmiBdYOBTcAJeVXJ4OQhis7N4li2Na4oXz/giSV1f4LbvyGXit9+wZoQ
 1ni7ozAUJhy/pQlNAM1AZepp+GIC8iILM+J32wiksj9EdUP9G7xtJsmc0SWxfxYzPuTR1hCXAUN
 Ucn3KXq+LCnXLKx3O0Tkuai5bvmZBfHm5WiYeCaoA8H43sY96LSe7dI0Ak8oyp1IXEaa5Idrj8e
 v23isVK3NTyWp81zf5lXz1zdxQpQwC5ygYDEjc+1yDWqWfyhIYa+k4o1bsLiVqtvMUEHL5PsvE7
 Z3w+pIRKKKW1RoAs58d6aEbDTowinvA9R7rAyETLI+sMA5f0BwQ0YsdrqMSTEys0kXQlq0OhpwG
 Xa/KB9svBXJ00dycsyeTpusllO+JC4JESEZkQdPEX/nxX1eroHG1u80ZpZsYy3bh+RS0dXff5vC
 5DbyZ1gaXqDC7DZr0z3VVPMWo+2u/nfqFIoay9XthxSrZIVStTYwhCvQLaDJaQiW+voH9cynlx/ /FL1CA+ZzRcHdSQ==
X-Mailer: b4 0.14.2
Message-ID: <20250819-maple-tree-v2-0-229b48657bab@google.com>
Subject: [PATCH v2 0/5] Add Rust abstraction for Maple Trees
From: Alice Ryhl <aliceryhl@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Andrew Ballance <andrewjballance@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org, 
	maple-tree@lists.infradead.org, rust-for-linux@vger.kernel.org, 
	linux-mm@kvack.org, Alice Ryhl <aliceryhl@google.com>
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
Alice Ryhl (5):
      maple_tree: remove lockdep_map_p typedef
      rust: maple_tree: add MapleTree
      rust: maple_tree: add MapleTree::lock() and load()
      rust: maple_tree: add MapleTreeAlloc
      rust: maple_tree: add MAINTAINERS entry

 MAINTAINERS                |  12 +
 include/linux/maple_tree.h |  11 +-
 rust/helpers/helpers.c     |   1 +
 rust/helpers/maple_tree.c  |   8 +
 rust/kernel/lib.rs         |   1 +
 rust/kernel/maple_tree.rs  | 640 +++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 669 insertions(+), 4 deletions(-)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250726-maple-tree-1af0803ac524

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


