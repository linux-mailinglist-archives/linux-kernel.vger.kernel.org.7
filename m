Return-Path: <linux-kernel+bounces-738125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C0BB0B4C5
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 11:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9E3B7A7197
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 09:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9311EF36C;
	Sun, 20 Jul 2025 09:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="leUnF6WZ"
Received: from forward202d.mail.yandex.net (forward202d.mail.yandex.net [178.154.239.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B69A194C86;
	Sun, 20 Jul 2025 09:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753005334; cv=none; b=QHr+HZw7bol9tbrywK8owUDQ+h6Zj6qi0dIOoYYmiqw2Yi6JEn3SEC8Lc+1rs6vKKIPb+D9OsmuQhTrUcW2FfWmd88YxFxXF6qQD5f3xk2hU2hBJ/+/7ALpYHvfoezByc4to5UA4IH/WYpoZJCC8lLxBVGxIef4ke5gXb87rIDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753005334; c=relaxed/simple;
	bh=WkctRXxzP5UMPWQHUPe1aihz7uhRCVep2tbjby4NWu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NK3oPy/PpbNBZuiNcrgCgI5K1I44/5hU5x+hehLAnemUDqlhOo8vsO1rnjn2ic8B+ARSGMNPk77w7kmnBgJswPtbjfIYJRVMFmSS2DzSfDQppbsAm95qShdahCSvkfxiIWb6wUw/9INCUYSvcM+MkJ4XNFJPjFsbGDKh2cV318M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=leUnF6WZ; arc=none smtp.client-ip=178.154.239.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from forward102d.mail.yandex.net (forward102d.mail.yandex.net [IPv6:2a02:6b8:c41:1300:1:45:d181:d102])
	by forward202d.mail.yandex.net (Yandex) with ESMTPS id 078288AE08;
	Sun, 20 Jul 2025 12:49:05 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-88.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-88.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:e0cb:0:640:3e34:0])
	by forward102d.mail.yandex.net (Yandex) with ESMTPS id 4A7E4C0085;
	Sun, 20 Jul 2025 12:48:55 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-88.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id emMPSZxMxuQ0-qXoac0t1;
	Sun, 20 Jul 2025 12:48:54 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1753004934;
	bh=nElTx2N3XFovKfeAcDgMHY9SjrcZHcGdMY2vfvVQocA=;
	h=Cc:Message-ID:References:Date:In-Reply-To:Subject:To:From;
	b=leUnF6WZXVuUzVjrCN4LL64aALukOmc+Bc1MyenHcxzjhkHs1MCWQaM2L0fq3t6x2
	 0t7wFoa6dh5vZuDJ0i95XAYz8OeARpnG/HVwfT/LYuF02tAV9JQhLQKuxSIgUBDUJp
	 tfCtDqiJPejwsMr3VGPBSUBwg+onegncDOOqTACo=
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
Subject: [PATCH v1 1/3] rust: make `allocator::aligned_size` a `const fn`
Date: Sun, 20 Jul 2025 12:48:36 +0300
Message-ID: <20250720094838.29530-2-work@onurozkan.dev>
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

Makes `allocator::aligned_size` a `const fn` to allow
compile-time evaluation.

Signed-off-by: Onur Özkan <work@onurozkan.dev>
---
 rust/kernel/alloc/allocator.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/alloc/allocator.rs b/rust/kernel/alloc/allocator.rs
index aa2dfa9dca4c..aa2957fd585b 100644
--- a/rust/kernel/alloc/allocator.rs
+++ b/rust/kernel/alloc/allocator.rs
@@ -44,7 +44,7 @@
 pub struct KVmalloc;

 /// Returns a proper size to alloc a new object aligned to `new_layout`'s alignment.
-fn aligned_size(new_layout: Layout) -> usize {
+const fn aligned_size(new_layout: Layout) -> usize {
     // Customized layouts from `Layout::from_size_align()` can have size < align, so pad first.
     let layout = new_layout.pad_to_align();

--
2.50.0


