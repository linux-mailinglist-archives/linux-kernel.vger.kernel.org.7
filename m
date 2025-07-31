Return-Path: <linux-kernel+bounces-752332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09CC4B17427
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 17:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EE277ABFFD
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 15:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B97021C165;
	Thu, 31 Jul 2025 15:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rYNIg5RZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68911E835C;
	Thu, 31 Jul 2025 15:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753976986; cv=none; b=YZu5Lp+6Wu20jEimath/NvP+O8EetsyDOTrYqyKiafyBwEClSTt5mqnKOMYvZvAKZiDb/VhOoSTU5IfLmgjPC1ly5BcLiwCsLMlxRl480TwNUpKqx8CbGYK7i9KyyaNDJ5Z2wiJQqJkWEctUCQhYP92WpqdxHBswQU5F2eLPTas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753976986; c=relaxed/simple;
	bh=2foXzLUbcLlOFhsxqoB4OFU/K2Gw1RJLAqLvJ8zuC4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q1t0Z4tuUiTFiW25ydwzMM4dX/bW5tIPVaGgQfj2aWaK8yj7GTkC22ja0Rva3/WXwFQfhFlw7c6M0SH5M5t0kE4vVXQ+PqnyQIwobFBlQXMhcr5iNp/yLHbDAeIzTUXbV6/XJfIHcdzlAAJmIXr8TDR2JuJSmaka+ZDcE8JE5nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rYNIg5RZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE135C4CEEF;
	Thu, 31 Jul 2025 15:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753976986;
	bh=2foXzLUbcLlOFhsxqoB4OFU/K2Gw1RJLAqLvJ8zuC4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rYNIg5RZY61hQko6uvctqhWsnSpHp/10vuTOBp1HVYI9OR9oy826wUPat+pdZ0jSa
	 7u6UYmFaVk8HpPIaOzSAwG/2XbWOajAg/a2ta3QBg6arjea28wY9RwSB0O6G8dpBmy
	 0a01GUaKlbeqpmf5xnyuem64iykjbTd1ttOfz90+4DUDZkjBIiMqzLji3NkP9gTmNn
	 NqYb6san8e5ve5bsMAGZ1MUvhHvY0IbinNvsgvK39m+kXxYGjU68T3bVnUPLTybCDA
	 PSHJwtwMQfk7HJlGRiwJaMR55n50lG28R+FRz5JHLp8HtniDl6w2085N/KuDEQsbuY
	 1c6GJsHbNd/hA==
From: Danilo Krummrich <dakr@kernel.org>
To: lorenzo.stoakes@oracle.com,
	vbabka@suse.cz,
	Liam.Howlett@oracle.com,
	urezki@gmail.com,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: rust-for-linux@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 3/4] rust: drm: remove pin annotations from drm::Device
Date: Thu, 31 Jul 2025 17:48:08 +0200
Message-ID: <20250731154919.4132-4-dakr@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250731154919.4132-1-dakr@kernel.org>
References: <20250731154919.4132-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The #[pin_data] and #[pin] annotations are not necessary for
drm::Device, since we don't use any pin-init macros, but only
__pinned_init() on the impl PinInit<T::Data, Error> argument of
drm::Device::new().

Fixes: 1e4b8896c0f3 ("rust: drm: add device abstraction")
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/drm/device.rs | 2 --
 1 file changed, 2 deletions(-)

diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
index d19410deaf6c..d0a9528121f1 100644
--- a/rust/kernel/drm/device.rs
+++ b/rust/kernel/drm/device.rs
@@ -54,10 +54,8 @@ macro_rules! drm_legacy_fields {
 ///
 /// `self.dev` is a valid instance of a `struct device`.
 #[repr(C)]
-#[pin_data]
 pub struct Device<T: drm::Driver> {
     dev: Opaque<bindings::drm_device>,
-    #[pin]
     data: T::Data,
 }
 
-- 
2.50.0


