Return-Path: <linux-kernel+bounces-810793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD65AB51F80
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 19:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76FAB544572
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 17:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097A523F42D;
	Wed, 10 Sep 2025 17:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="Ef/vhrsX"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCE93375A4;
	Wed, 10 Sep 2025 17:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757526908; cv=pass; b=k56ZpgidF3A4qtMa5Awv89AYmTRhRgLEhTz4x2reOJzVb9wWE2JZOIN4b8oPiIEzpIgWGemWdXjycvVGL9v1NVSjUrztWgTPFeX9dtrWxe9O+8PKLJ/WUoYhNIUIku89R2yGzO7j4UzgfOb+O6OOe2zBIqyDhH9ZAPnnfsO5jOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757526908; c=relaxed/simple;
	bh=1r2vJfXxwYY0GRwjDws1s2atasYx4IoNwigdh3SWqE8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=BFVDslSwzwajhTGFm3DpMHV35YLEJfJU4omoBuhEXHPuFfLmUX4TD8zezxHBxjf9/yuyLAliAFRCd/YhgVrUkhi43B2m1ZNSEV/1AGsox1lnC7f6NefowGL6W0TQmNN39GVFfWOIc1b+AmXHq4gRb/dElExEKyK/dPQi6bfX4/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=Ef/vhrsX; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1757526888; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=l9mxE99YmK1SnQtfLQtzWvFzFJ+NWYV6K4uLIPYsh+8s9n4Ts6pcn24a1oG/zTOul0kBhWtZGkWXOl+QpaCIN0FX82d2ZQzHGV6fpPUESvx4wRsSSAL0XAvIWWcUPtaAWSA5CS/1tc8Z9aKRgjjCtWqLW3q3A0otUrU31Xv7a7w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757526888; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Q2G7IQhL12T9kcwEmNSUde2HVMv84QTPT1zPY0Tl/wU=; 
	b=nbh5Kk+4cJLF9E1Ia+Q1tCyvGZySKzp7RCqMdsGEpVWgzJJ7gBuAW4htP4YTBJo6+7hh1UOtFUSrTB74CTjf+zgxQytU4Yu6XuNMJtKO/S4PXeohKR+22SphTZDqS7fRjEX1zg9gSpGTA3ff9BtiIVpgD+JacryetjlCa/O15h8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757526888;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
	bh=Q2G7IQhL12T9kcwEmNSUde2HVMv84QTPT1zPY0Tl/wU=;
	b=Ef/vhrsXpkON0zy+CP/5wFIc8mJ7WqDBuePchn0pBbZ3o0r91AwGul/Aw2RcfPgO
	be2gredx5zx7PKagoZEgqxc08fIfUHqLfsM8GQ8G/VLAl4vPhYBEGxqu76rtQRslZ5p
	Nkf3lH54aXsYH6HeIheUbLNkTL8rfYgRR9y18AUY=
Received: by mx.zohomail.com with SMTPS id 1757526885756431.32065045260094;
	Wed, 10 Sep 2025 10:54:45 -0700 (PDT)
From: Daniel Almeida <daniel.almeida@collabora.com>
Subject: [PATCH v3 0/2] rust: regulator: improve the ergonomics of Rust
 regulators
Date: Wed, 10 Sep 2025 14:54:30 -0300
Message-Id: <20250910-regulator-remove-dynamic-v3-0-07af4dfa97cc@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFa7wWgC/43NQQ7CIBAF0Ks0rMUAhgquvIdxMcC0JWlLA0psm
 t5d2o2JC+Nu/k/+m4UkjB4TuVQLiZh98mEs4XSoiO1gbJF6VzIRTEimhKYR22cPjxDLNYSM1M0
 jDN7ShkNtlGWWG0bKfIrY+NdO3+4ldz6V1bx/ynxr/0Azp4w6NFILJlGhvtrQ92BChKMNA9ngL
 D6YZuoHJgqG8iwBhXVYwze2rusbnfGFyhEBAAA=
X-Change-ID: 20250829-regulator-remove-dynamic-f1a6b8c0c1b0
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.14.2
X-ZohoMailClient: External

This small series comes after some extensive discussion on a few minor
changes that can improve the current Rust regulator API.

Patch 1 removes Regulator<Dynamic>, as we have now established that
there is no usecase that can't use the safer Regulator<Enabled> and
Regulator<Disabled> APIs instead.

Patch 2 makes "devm_regulator_enable_get" and
"devm_regulator_enable_get_optional" available in Rust. This comes after
realizing that a lot of drivers simply care about whether regulators are
enabled for as long as the device is bound.

Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
Changes in v3:
- Rework the docs (Danilo, Boqun)
- Pick up tags
- Link to v2: https://lore.kernel.org/r/20250908-regulator-remove-dynamic-v2-0-e575ae2cde6a@collabora.com

Changes in v2:
- Picked up tags
- Rebased on regulator/for-next
- Renamed enable() and enable_optional() to devm_enable() and
  devm_enable_optional().
- Renamed patch 2/2 to pick up the above change
- Added more docs and links where applicable (thanks, Alex)

- Link to v1: https://lore.kernel.org/r/20250829-regulator-remove-dynamic-v1-0-deb59205e8e9@collabora.com

---
Daniel Almeida (2):
      rust: regulator: remove Regulator<Dynamic>
      rust: regulator: add devm_enable and devm_enable_optional

 rust/helpers/regulator.c |  10 ++++
 rust/kernel/regulator.rs | 148 +++++++++++++++++++----------------------------
 2 files changed, 70 insertions(+), 88 deletions(-)
---
base-commit: 59e8e7b7f2206d7097e43266722b625715720dfa
change-id: 20250829-regulator-remove-dynamic-f1a6b8c0c1b0

Best regards,
-- 
Daniel Almeida <daniel.almeida@collabora.com>


