Return-Path: <linux-kernel+bounces-738124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E65DFB0B4A0
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 11:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 372A23BE0D3
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 09:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1CA1EB5DB;
	Sun, 20 Jul 2025 09:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="KqHOPbq9"
Received: from forward101d.mail.yandex.net (forward101d.mail.yandex.net [178.154.239.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3047A3E47B;
	Sun, 20 Jul 2025 09:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753004948; cv=none; b=biN3UXPs/EEwTItOJHsGgx3AdFnHNC1mXtN+BPchDNCcl6U3oZSFMiGmYQMUNLdJKyejcr2iLOVNGB0Qz/eKPF0gJbFSTB68vBbVoh/Uv7bMYQ/9LR0wzlVq8FWiokSv1z6kwASvSF0hIy2HNgGXdgIYRT8dwcbQ4AvaSbhcvX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753004948; c=relaxed/simple;
	bh=5UZq8o2tZMaz57LTKRhjQIIxekTht7F9HPgjC3yqVmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cGBmMSv31zIoX2IAkXojAPnlY/0nf90064f4dANRbjO5uVaqpWPwbzFG7N3i6ccoLKOg7wD7bPRQwdVenEFd1aN2KNpDC8BM7uyoZ4ItUVoBYej+0WkH57LBMtE3hSYyTkgZ+eX7+hcAyWDpcrUU9FV77oUJhF/1mr2CQ5SleB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=KqHOPbq9; arc=none smtp.client-ip=178.154.239.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-88.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-88.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:e0cb:0:640:3e34:0])
	by forward101d.mail.yandex.net (Yandex) with ESMTPS id 756B6C007C;
	Sun, 20 Jul 2025 12:48:57 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-88.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id emMPSZxMxuQ0-bzqCHCfc;
	Sun, 20 Jul 2025 12:48:56 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1753004936;
	bh=vWhHrl/YmXwHFiS0lkmPC0s7uWQw+igTRt8CUNSHBf0=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=KqHOPbq9QnyddGfd/giTXc2+ZF+C/vMea6INkthfWjsidae0LlLvXS1G+uhrUhVoG
	 OhqmZ2ur6H5hFmAt3wNfm5wVTNk6JrEBF/J7mM87O5feDh0RxB3gHJq6iIXZXa/sV5
	 g8oE+c0+j6z7vpcd5A0JZ5zNDC+INkxVC/nMDJ9g=
Authentication-Results: mail-nwsmtp-smtp-production-main-88.klg.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: rust-for-linux@vger.kernel.org
Cc: dakr@kernel.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
Subject: [PATCH v1 2/3] rust: make `ArrayLayout::new_unchecked` a `const fn`
Date: Sun, 20 Jul 2025 12:48:37 +0300
Message-ID: <20250720094838.29530-3-work@onurozkan.dev>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250720094838.29530-1-work@onurozkan.dev>
References: <20250720094838.29530-1-work@onurozkan.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Makes `ArrayLayout::new_unchecked` a `const fn` to allow
compile-time evaluation.

Signed-off-by: Onur Özkan <work@onurozkan.dev>
---
 rust/kernel/alloc/layout.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/alloc/layout.rs b/rust/kernel/alloc/layout.rs
index 93ed514f7cc7..52cbf61c4539 100644
--- a/rust/kernel/alloc/layout.rs
+++ b/rust/kernel/alloc/layout.rs
@@ -80,7 +80,7 @@ pub const fn new(len: usize) -> Result<Self, LayoutError> {
     /// # Safety
     ///
     /// `len` must be a value, for which `len * size_of::<T>() <= isize::MAX` is true.
-    pub unsafe fn new_unchecked(len: usize) -> Self {
+    pub const unsafe fn new_unchecked(len: usize) -> Self {
         // INVARIANT: By the safety requirements of this function
         // `len * size_of::<T>() <= isize::MAX`.
         Self {
--
2.50.0


