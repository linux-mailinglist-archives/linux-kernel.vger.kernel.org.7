Return-Path: <linux-kernel+bounces-792407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 880EEB3C37B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 21:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B45E164E0A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 19:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86278243946;
	Fri, 29 Aug 2025 19:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FlSw3ZzH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8C91F8BA6;
	Fri, 29 Aug 2025 19:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756497482; cv=none; b=t0gqDnhHLeKLwGA1QOY26BlCt6EyeG9juZZL99AiLf7s8hj5VWg4z25+KjodhPdmh/lj+yEcN2/boHnI2CliVc7Pmk5yQiHCzYwKhaUIZsyK/seGXRHNSVaItDYIIVpOrr5c+HDI6obKz792SrzRYuAqSK4RLxI8Gzc2mFsz+d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756497482; c=relaxed/simple;
	bh=Q0kzLsEA0EB/XYFScsmr4iZcUDAd2NYoZW7jd7rkEcA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cSzS03R4DTrV1VVO+2DmEjEj6S40AyFGQmBupDI0NZoQuNL2wOeRZNOtodSvbrZ1YfVj4k2uMobbIvnWLZ8nfK5k1gq1EwB9nmVcFU9aM8qdv0smFj7JMWkBO9d1jzAZh3IjOzoAd8xW4EdvjMTfoP6RkisnVDwYkDsfM4r1WUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FlSw3ZzH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8345C4CEF0;
	Fri, 29 Aug 2025 19:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756497480;
	bh=Q0kzLsEA0EB/XYFScsmr4iZcUDAd2NYoZW7jd7rkEcA=;
	h=From:To:Cc:Subject:Date:From;
	b=FlSw3ZzHTEBaOgjVyVG7F5oZ9Yh7cRYazSb45eZlboWephwGO+HBtL6cyexaSEvIS
	 ha/duZq9C1YxIQmGhhZF3XagGwsCZIufb69u+1Up8PLmWfx2nIz2XvcbR7te9/6giv
	 kn6yLvuLw8zC5eSg15l9xC2fAAjUDFwk3JlNXvZdD9zZK4GigcKOZZBRBmtSMCOhtU
	 FRjSNgVL2q5FXXo1QzgKi8A9kueMz9dbVMDCY7GUuGKjbDO3OyreZQDI0wkGcOic9K
	 YjNxjvH18rfQ3mbt05dMHtwLPhPTOLmrx6Pnk1j4KCYDkueuZOKQrKdj47UbPD+U/X
	 Vxe4WNMAQCGtQ==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] rust: device: fix unresolved link to drm::Device
Date: Fri, 29 Aug 2025 21:57:42 +0200
Message-ID: <20250829195745.31174-1-dakr@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

drm::Device is only available when CONFIG_DRM=y, which we have to
consider for intra-doc links, otherwise the rustdoc make target produces
the following warning.

>> warning: unresolved link to `kernel::drm::Device`
   --> rust/kernel/device.rs:154:22
   |
   154 | /// [`drm::Device`]: kernel::drm::Device
   |                      ^^^^^^^^^^^^^^^^^^^ no item named `drm` in module `kernel`
   |
   = note: `#[warn(rustdoc::broken_intra_doc_links)]` on by default

Fix this by making the intra-doc link conditional on CONFIG_DRM being enabled.

Fixes: d6e26c1ae4a6 ("device: rust: expand documentation for Device")
Suggested-by: Alice Ryhl <aliceryhl@google.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202508261644.9LclwUgt-lkp@intel.com/
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/device.rs | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index 5902b3714a16..a1db49eb159a 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -138,7 +138,9 @@
 /// }
 /// ```
 ///
-/// An example for a class device implementation is [`drm::Device`].
+/// An example for a class device implementation is
+#[cfg_attr(CONFIG_DRM = "y", doc = "[`drm::Device`](kernel::drm::Device).")]
+#[cfg_attr(not(CONFIG_DRM = "y"), doc = "`drm::Device`.")]
 ///
 /// # Invariants
 ///
@@ -151,7 +153,6 @@
 /// dropped from any thread.
 ///
 /// [`AlwaysRefCounted`]: kernel::types::AlwaysRefCounted
-/// [`drm::Device`]: kernel::drm::Device
 /// [`impl_device_context_deref`]: kernel::impl_device_context_deref
 /// [`pci::Device`]: kernel::pci::Device
 /// [`platform::Device`]: kernel::platform::Device

base-commit: 1b237f190eb3d36f52dffe07a40b5eb210280e00
-- 
2.51.0


