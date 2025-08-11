Return-Path: <linux-kernel+bounces-762594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B864FB208CD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9500618A2A2A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043752D3A88;
	Mon, 11 Aug 2025 12:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C2esKwGb"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C1D23B613
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 12:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754915528; cv=none; b=Y7Dx9nlqzo1F62UAEOBZtW2sOPKrx7rxnQcgItas/28CEF6iF8LIOjo6E+4azRmpAed2eqrWOe9TpxgxYMHL5VVImxup5IQsU7ZMEsBzdmThDn2FOJysCGS/7uCq6rd1I7ldMsSjHhE1OKqdr6RLUtcgxkHYkkmVqExR+r2xLgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754915528; c=relaxed/simple;
	bh=zzHfmtHVdGKVLDTeJmDuM0QQ2WoBFrZ74R1S49h3S4Y=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=oZxGUqahzs2hpL8Qc2QoCvOXQIReDLH3hBNx0L3NrWKcQZmUqzmSdCTEoIkQEaUVgBsgCaDzbFgfvG8B0MwElEpFXCcgmyc4hAh71T5OvC0mMMbSDZmuvjlEexWJ0waAgQkVLilCEN13J5F2uBoAYI27vfPQg4R6acD8nWpuLzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C2esKwGb; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3b79629bd88so1854049f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 05:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754915525; x=1755520325; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cBznQW2jozfPAknKzYDGUUpAByXONdMvspvsg7mmV1I=;
        b=C2esKwGbAJdaF1Gwl5quWE1O+KxHRed0WzfbZLra1uZugoDVJjWY4hTg+Zy2lqWqyA
         R0FTZACB2fbJq7d01BCMCU4l8wRWuTduzP3UpD+RNjgEUX27EKIYEPoXjcU+F/ZFxgVE
         jiFX0MPsrJCjMFmRINoueKsWQUAKPghrSFpFOGwsjO9ts5LE+GeiV0Vt82CYmAoYF6ON
         EZUV5oEkvVGG0uA/Syjnsor+Fl8L+vQrrBxNiKcZjJ/QoN45VZl6vbjHmSZdK8slO6YT
         0vwljPku4A3sPplhTgySBUb1+vprfYxEgB6spaPljRppuOr8ZDFi16yXYlHFPGiBEj0f
         RPtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754915525; x=1755520325;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cBznQW2jozfPAknKzYDGUUpAByXONdMvspvsg7mmV1I=;
        b=lKbq9OQjLAOS4x9FWIvFuTM+CUGt/9Ju4svAp8Tn6lFk19yZz3FzjvY9U9AeOLOJYu
         9DPdUVxychVmDRalQpGNxZzsWKWrrz+4YW03h3zyX2Ty1CHdS6Wg3P40YLzS0ghCX3hS
         OkfBe7C2cHoHVZH9OI44YLzVQNzw7Kis+v7JWjVvmbLHLKWrWfmmEIL5P0I8I9YHFV/5
         zYXnbnOInwtEeOHy+1cPmpX2BuuLxWJ3aupnGhEyULMDowuIosrNWImRWgDSpwggSNeA
         t6YoW9YlhOy82F7ZUuBAasQ+doMsM3m6o/x9rWzzMyBBFMWJGQRDrlqHmOFX9L4dDW2G
         TMWg==
X-Forwarded-Encrypted: i=1; AJvYcCW4fa3DBkP663UIMqza+qjg7UniIP2BYlZthx86TefW/hr7b3W1bvp9iwqdwvZ4//IO7Vtu8fpjiqE5Okk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWFu3Nu0mEbPZbWmxxqWw+yWKmD1NpTVei9/iqYlO0fE8j6DnT
	E1vt15M6pwUvhBIvQ37F10fonYT050hGF9fCm3GUcBBYAiSBCZHFYx/1TtHEEh0CgVV3ByIxQgH
	Mnf/5ocZnc/crHnJF+Q==
X-Google-Smtp-Source: AGHT+IG/Z7TLbDdRCiOWcvFypzhdjqXp/cd3cMWabRFYYCugnNAQDA35iDfdsoOmBv1cEO9jIyPklYpgoxPqh0I=
X-Received: from wrbbs8.prod.google.com ([2002:a05:6000:708:b0:3b9:afb:8189])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:24c2:b0:3b7:9b81:73f6 with SMTP id ffacd0b85a97d-3b900b55f20mr10096012f8f.54.1754915524996;
 Mon, 11 Aug 2025 05:32:04 -0700 (PDT)
Date: Mon, 11 Aug 2025 12:31:49 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIALXimWgC/32OQQ6DIBBFr2JmXQxg0MRV79G4AJziJAotWNLGe
 PdS3Xc3b/Lnzd8gYSRM0FcbRMyUKPgC8lKBnbR3yGgsDJJLxTuhmJ7JebaQL9McrF5DZKYRGlE
 11owayuUj4p3eh/U2nBzx+Sry9VyC0QmZDctCa1/lthYdi1bALzxRKs7P0SiLI/33eRaMswaFk Vop0Vp+dSG4Geuih2Hf9y+ZKdjh5AAAAA==
X-Change-Id: 20250715-align-min-allocator-b31aee53cbda
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=1536; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=zzHfmtHVdGKVLDTeJmDuM0QQ2WoBFrZ74R1S49h3S4Y=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBomeK6v4t7/LGcr8Z9JdjgvaB35kRT6S2yphLKo
 cZCh7QDQFSJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCaJniugAKCRAEWL7uWMY5
 Rn7LD/9eiMkB3/YXJ/np/GC3JyupWv/t6ucU2G1PY7FnRqFYjRG/uei0BWZ13TKDupvybhdbwWS
 KJwMtGcUsPUrcI6ix+QA6tqY4fufThS9TCd7WmO7MTdTsbgkvRULKC4st958E+QKQ8E09cX6ATy
 TPGL0oomYmc3HIHRoFqWEfz5GvgvzyzlJYCuoBTgeZbtT3i7ZBQnIZkxZJI+GeHLWBaGreBEwlS
 l2B43fHLS1o7Wswkfi+PGalOrE5uhkhZLzS/dX+z5BAV9qlcVYWR1jnu1PCYwLkKDXI1ZO8w16T
 B0qZ5sF2jfOKIygenezFHbeQN6VXxJxEvSMgJRf59W8gfoNMZWh2aygPpaZAWFVWMSGmULEbgm4
 vbuImfsCL9ecD07UEvs+0lz2PQoPRJkgPw484UHMvw1imeCm2xlX7FW/wza7SPL3Y1MfpYmpSoB
 XLEmHuZg0kjHp2b866rkvquSJmvvUbmBqeclTVr24qKAH0b0s4u0qeyupfLyGs1Mau6la52u4dx
 /Q1Lgw/3K3Hom/IYJ0O92K2VUJMJ8B9jl3F68wnPJT9ruh03jL3NBytDIbdyBSMPDjHdEQKnlLm
 miRCcr3IPs4H0nGzRIrbbvp7i3PU8anefCyibX+59e0vnQkXPfpMQBuI0Kb1jx4ZE/vblw5lR6h YrF4CikooKg396A==
X-Mailer: b4 0.14.2
Message-ID: <20250811-align-min-allocator-v2-0-3386cc94f4fc@google.com>
Subject: [PATCH v2 0/2] Take ARCH_KMALLOC_MINALIGN into account for build-time
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

Intended to land through alloc-next under the RUST [ALLOC] entry.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Changes in v2:
- Reword guarantee on `const MIN_ALIGN`.
- Change formatting of if/else in kbox.rs.
- Rebase on v6.17-rc1.
- Link to v1: https://lore.kernel.org/r/20250715-align-min-allocator-v1-0-3e1b2a5516c0@google.com

---
Alice Ryhl (2):
      rust: alloc: specify the minimum alignment of each allocator
      rust: alloc: take the allocator into account for FOREIGN_ALIGN

 rust/kernel/alloc.rs           |  8 ++++++++
 rust/kernel/alloc/allocator.rs |  8 ++++++++
 rust/kernel/alloc/kbox.rs      | 13 +++++++++----
 rust/kernel/sync/arc.rs        |  6 +++---
 4 files changed, 28 insertions(+), 7 deletions(-)
---
base-commit: 062b3e4a1f880f104a8d4b90b767788786aa7b78
change-id: 20250715-align-min-allocator-b31aee53cbda

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


