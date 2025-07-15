Return-Path: <linux-kernel+bounces-731964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE15B05F40
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 16:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB6C91C273C4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 13:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72DC02E92CA;
	Tue, 15 Jul 2025 13:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CXpv4I8h"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CBF2EF9D3
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 13:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752587204; cv=none; b=rElzYazo33n4ikXeGCXT3N9KMkFgAPWDU90ylen8bQASP7rO20Pw1WPEj2Ti+cbO4rXtCYwOkOewJOCXmYse5wEMdaO3Jwx11uZapd/seTYQ3xCUZd0lwYLRk18HRR/SfBb2DjftkDwZomfvgP2l+xf7NVirSS8MiYIe0E5cS5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752587204; c=relaxed/simple;
	bh=s5VZOQklE5Yi2oixqgin8j2KWQ7Dx7YJloRvpywwTVg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Ws39KVKm0aZKS4k0tGlQaZq9xXqc+psHyWrrheM+zerguJ8SmzNYieT20LHbMsgH6qf4+10/YNxZZKg1C6OAyXk/dt/9C4Ghm2Injf2+1iBQGI5iHcmmREP5B4N448cFdHtgJT84UTxFnYhch7Fm7uzUXwBFT9Fsy7FbtZZyfiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CXpv4I8h; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3a4f65a705dso3628491f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 06:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752587201; x=1753192001; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mp7ljrj/i/+VhGEY4C8q0OrC5+WTVbDqIPth4pd0v88=;
        b=CXpv4I8hHJ70E84S41Fffv0y7MYxLL4E4PVvbB3dkeoGCcKaingnauSjqJMJk7f+GC
         A9t8Fx7HpchQBk0zBGhERcpWlwlpUB4EfEN5K0JZN7hahLXZ3wxXRSp8CIn7ZtqxkBqj
         R9g/KGiAFnCUoYYOyqOx0t7qjLioaDMoJqic6Pqi6o1kSGd2nkuCrOAX/OB1oyQwy4Co
         YLs9C67IxLTQ8opAF/PSs4D2XSfK/0UpELYYj0wTU4TVwy+WTbn836pE/exuGXa3cEYC
         7TZmdV32D7v29wrRhJNcDaQ5VkOp97zkyNwX0kY7b25jLC/rFkZ0URkgDzimrRiNIIif
         Bdww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752587201; x=1753192001;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mp7ljrj/i/+VhGEY4C8q0OrC5+WTVbDqIPth4pd0v88=;
        b=VqJ1BqTcfSr+LROWZFhtImK8+wGAPEX4Cs0CH+stN6T4/g25FE23TogG94Iw3IQMwN
         sQ+N3u/SaokVxj4mDgGXxz/DqaP9SHWIUNyzuFXgGBX31i16JpvXK5Bd3D+kKLTzY6BN
         1pnRpLfwlsI3AyKPE9gBPXcpZhf5JPeQfDfKyt6dg2jwvyi4Tnyees5Ntl76K5kikF3T
         YQ7MfmyEDoxRtMw3Fd6kRW4F3j06dFlRv6ip0+Ho1Zswo0ZhmNYDHRIlP+fQK9tistXU
         mKRl9/0CXLJ5Xg53CdsnyW0YBCJAmyGExg4YDZ43yDqxzB2n5JfhNnHRlqo8c01JUi9m
         9Hfw==
X-Forwarded-Encrypted: i=1; AJvYcCUfcreBQT/kFb5Ax9l1RFy+FoCWdlpNFSPrfEh26BzVVUidIPmPkSH0/o4F877TE5wRuClbGvrMWZbIj3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcfxWeUWdK8QU+p7Nttk9l1pWMufBU/Mj2cdlUhDsaCvDJW3z9
	jUC/Vg/ok4O79IPbeiuS9PvwDxxw4yreSrqz5jjbYzs2FRyMOLvlr/LF2Qlyhrz5jGIH08iooXs
	xeSkIiH7WH0ybnH9wQA==
X-Google-Smtp-Source: AGHT+IH1oIRfbBdledKovGgVvW49tJmVg4gisne0JjGDWfhGlpXxto3LpYtUQaHtSDX8iB3Y+8zZMfaXssb1yh4=
X-Received: from wmbek10.prod.google.com ([2002:a05:600c:3eca:b0:451:4d6b:5b7e])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2089:b0:3a6:e1bb:a083 with SMTP id ffacd0b85a97d-3b5f2dd2e52mr14834538f8f.25.1752587201528;
 Tue, 15 Jul 2025 06:46:41 -0700 (PDT)
Date: Tue, 15 Jul 2025 13:46:33 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIALlbdmgC/yWMywqDMBBFfyXMuqFGCQV/pbiYxNEO5NFOYhHEf
 2+ou3sunHNAIWEqMKoDhL5cOKcG5qbAvzCtpHluDH3X2+5hrMbAa9KRU1she6xZtBsMEtnBuxm hmW+hhfd/9TldLPTZWrxeJzgspH2OkeuoZAl32UrVifYK03n+AGu7mHSWAAAA
X-Change-Id: 20250715-align-min-allocator-b31aee53cbda
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1282; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=s5VZOQklE5Yi2oixqgin8j2KWQ7Dx7YJloRvpywwTVg=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBodlvAW1uGuI8VV3ZaJchh2qeFswg3h6xxEFN0n
 suh4FlodWKJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaHZbwAAKCRAEWL7uWMY5
 RrhVD/9DIS3lODYHGPRiJdnhlQFerkUldW6WwGQGSQVZyaqFAx+mEPq7UBTzvVukZqQzzSNkV0A
 MY4NiNOXuwIeZ5Kk16GUQvHIIwM/8ZZ4tBnDNbiR358aVa2lS0HphIGuarJzAZvna/pGe/m+xTj
 ED5z3d6N3n1oxYYKW5mRISfd1jF8ewf4LbCybuwlqdLRqE6OozzWsYP6SVpZuuFkBFmu3MCqLQe
 jfWa8W2yhYjesdbo7dbW6ZF984uVRUG8LQwQcWVWiN91mDXpS8lhlKyzAAObHsfQqD2okMcKYR/
 ggr2MpmwfPCzS8AUVCkW+YYw5xg4PljuvobVyPj4BD9BeOCQ8pn3N17mhKzqKk1+P8zpSls83Qv
 HWhKZ20SYCs5tnFzu7tdt02bXoPH7wnPJKoVrYTVDeYR5/wVxvRFMgKtBSoqxNexAeFFj+dh+EA
 ED6D4fU4QsgjoeUrnk1dWz7cI774/JaPygvPfWBQFs8NM9Co0Wg7erQFxS7Ffadte0Yevg694+L
 EPT1IXDUU2ebPDH1RVfrGknLZV7IM7kg9Kql3zwd5I2LQzNQqiwL4FUCuPzvIybwlAKejVbEXs7
 kfrXxQ03tcjjar+PJmF9nAzAkpFi8JfDw8O6pOZe9kHJ1sHubj9/svP/x5891LyHrH+1RvEVtns bUrSKkt5laGpPfg==
X-Mailer: b4 0.14.2
Message-ID: <20250715-align-min-allocator-v1-0-3e1b2a5516c0@google.com>
Subject: [PATCH 0/2] Take ARCH_KMALLOC_MINALIGN into account for build-time
 XArray check
From: Alice Ryhl <aliceryhl@google.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, Tamir Duberstein <tamird@gmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, linux-mm@kvack.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

The Rust bindings for XArray include a build-time check to ensure that
you can only use the XArray with pointers that are 4-byte aligned.
Because of that, there is currently a build failure if you attempt to
create an XArray<KBox<T>> where T is a 1-byte or 2-byte aligned type.
However, this error is incorrect as KBox<_> is guaranteed to be a
pointer that comes from kmalloc, and kmalloc always produces pointers
that are at least 4-byte aligned.

To fix this, we augment the compile-time logic that computes the
alignment of KBox<_> to take the minimum alignment of its allocator into
account.

This series is based on top of rust-next.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Alice Ryhl (2):
      rust: alloc: specify the minimum alignment of each allocator
      rust: alloc: take the allocator into account for FOREIGN_ALIGN

 rust/kernel/alloc.rs           |  8 ++++++++
 rust/kernel/alloc/allocator.rs |  8 ++++++++
 rust/kernel/alloc/kbox.rs      | 15 +++++++++++----
 rust/kernel/sync/arc.rs        |  6 +++---
 4 files changed, 30 insertions(+), 7 deletions(-)
---
base-commit: a68a6bef0e75fb9e5aea1399d8538f4e3584dab1
change-id: 20250715-align-min-allocator-b31aee53cbda

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


