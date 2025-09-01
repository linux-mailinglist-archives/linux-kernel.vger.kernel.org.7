Return-Path: <linux-kernel+bounces-795305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B65B3EFA5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 22:29:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A7A8167C84
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 20:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62BFF26FDB6;
	Mon,  1 Sep 2025 20:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c1dzBGfJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA5D26E173;
	Mon,  1 Sep 2025 20:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756758557; cv=none; b=ljpneDympNMohNKhQUIdyInriGLy/gGbNx26OBzlNNZLp1o6DutlCrDJJ4r6e9BaHfxFPdJKgvQTPkaco4FEjaCtzRNT//OdKekiy31jEK02rNhferEyZO5h9f3HuFPuHqJ8VezOT9aswzdnnQ2Ln9BNUqt6LmBarGSXg7NcwiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756758557; c=relaxed/simple;
	bh=XSYHV22awvja2mSmk3TOqUCpr/T7KqGsGMSppJry2kE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k5TsgkN9pErZA+TVXyBYQxkS3vKnFokhlhVuJOfyBeyszzdLY5K1gT+1e4p+fv6AiildOsbmY1q4QphPA9Jf1pAnFw1su8/ViLloj3rTCnTpSr5hGmMZzHuV3Xgc/kV5y/2+yJTlvkiwYz8apJZOh7VDDgDKAH9lSkowdKXE8Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c1dzBGfJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50358C4CEF5;
	Mon,  1 Sep 2025 20:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756758556;
	bh=XSYHV22awvja2mSmk3TOqUCpr/T7KqGsGMSppJry2kE=;
	h=From:To:Cc:Subject:Date:From;
	b=c1dzBGfJiCN9+pKiTRE1eyR325/P7PthJNkDDf4IBUmDyHzhN3hwpyuqTMbXsmjB1
	 kScNk2z9VRBwzbeDVvgrYZes06a3yjmkzJ2SUAYFgkBou44MHA2yFxHPoCSgt+H2Gb
	 14eP44p1TNZR9vLNpp6NvvzsBCpCPCGPYCC8S13rVUNOn8fOQI/oXlTDi4JAK+Njdw
	 ib4oP4B+jM+Qt9Z1G6xhiGzIpVAIfW4gvwyrTjkqwJNY/7PqJlv+RtteIzJN7QYj5T
	 AnnMmC3Baz8cpKWFNhuSWVuD3WzDiPreqZ9XQdA7wu2Q46bT7Iv8dduAs14k5wTmUh
	 xOrIMjFX9gHbQ==
From: Danilo Krummrich <dakr@kernel.org>
To: aliceryhl@google.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	acourbot@nvidia.com,
	daniel.almeida@collabora.com
Cc: nouveau@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH] MAINTAINERS: Add drm-rust tree for Rust DRM drivers and infrastructure
Date: Mon,  1 Sep 2025 22:26:39 +0200
Message-ID: <20250901202850.208116-1-dakr@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Multiple DRM Rust drivers (e.g. nova-core, nova-drm, Tyr, rvkms) are in
development, with at least Nova and (soon) Tyr already upstream. Having a
shared tree will ease and accelerate development, since all drivers can
consume new infrastructure in the same release cycle.

This includes infrastructure shared with other subsystem trees (e.g. Rust
or driver-core). By consolidating in drm-rust, we avoid adding extra
burden to drm-misc maintainers, e.g. dealing with cross-tree topic
branches.

The drm-misc tree is not a good fit for this stage of development, since
its documented scope is small drivers with occasional large series.

Rust drivers in development upstream, however, regularly involve large
patch series, new infrastructure, and shared topic branches, which may
not align well with drm-misc at this stage.

The drm-rust tree may not be a permanent solution. Once the core Rust,
DRM, and KMS infrastructure have stabilized, drivers and infrastructure
changes are expected to transition into drm-misc or standalone driver
trees respectively. Until then, drm-rust provides a dedicated place to
coordinate development without disrupting existing workflows too much.

Cc: Alice Ryhl <aliceryhl@google.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Alexandre Courbot <acourbot@nvidia.com>
Cc: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 MAINTAINERS | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fe168477caa4..1cd6597c7f1d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8079,7 +8079,6 @@ F:	Documentation/devicetree/bindings/gpu/
 F:	Documentation/gpu/
 F:	drivers/gpu/drm/
 F:	drivers/gpu/vga/
-F:	rust/kernel/drm/
 F:	include/drm/drm
 F:	include/linux/vga*
 F:	include/uapi/drm/
@@ -8096,6 +8095,16 @@ X:	drivers/gpu/drm/radeon/
 X:	drivers/gpu/drm/tegra/
 X:	drivers/gpu/drm/xe/
 
+DRM DRIVERS AND COMMON INFRASTRUCTURE [RUST]
+M:	Danilo Krummrich <dakr@kernel.org>
+M:	Alice Ryhl <aliceryhl@google.com>
+S:	Supported
+W:	https://drm.pages.freedesktop.org/maintainer-tools/drm-rust.html
+T:	git https://gitlab.freedesktop.org/drm/rust/kernel.git
+F:	drivers/gpu/drm/nova/
+F:	drivers/gpu/nova-core/
+F:	rust/kernel/drm/
+
 DRM DRIVERS FOR ALLWINNER A10
 M:	Maxime Ripard <mripard@kernel.org>
 M:	Chen-Yu Tsai <wens@csie.org>

base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
-- 
2.51.0


