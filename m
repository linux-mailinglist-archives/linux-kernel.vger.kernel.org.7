Return-Path: <linux-kernel+bounces-777247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E891EB2D746
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 10:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18F273A272E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 08:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4CF12DC349;
	Wed, 20 Aug 2025 08:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="QufDc8xI"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AD62DAFC7
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 08:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755680176; cv=none; b=gZOj2nF+W0yZ2N1D1h9neZNWgsdzVS6lfnYrcDsPaD3pDyAkqf37PSi6Sk3VJL/Mgpa2V/3uGfR7q+31H6m/8DQXrMw1qLMAGCux07H/p3qQB1RzpbhhJPiPpE/kI6gzs3y7ahbIcJH1DtdtczltpiIFR1hTG7I5vjkgKVeyGy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755680176; c=relaxed/simple;
	bh=Eqahkamg13uwXjpD2HqVe8PGEmKJKZBW1G6dF/3Hy5o=;
	h=From:Date:Subject:MIME-Version:Message-Id:In-Reply-To:To:Cc:
	 Content-Type:References; b=sTp6Z0IYdhtyKIzvCQSKIvLtd/14B56QrQNUk8YfR8mElPGn/bjOvJy6smmEX6JVzv82pOZssPeTReLN4m4ONlJCvmjRu92gMbiL7VsPj9aqCl0+9G+qZ2ArphxV6MlLdWKJ3ZZh5qmCOhOhrxwEopieoKNd+1kOp55CnYU6YsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=QufDc8xI; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250820085612euoutp01cbb8e242da9f40bd400c756a21c0b1f8~dbdCrzAMK0776807768euoutp01u
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 08:56:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250820085612euoutp01cbb8e242da9f40bd400c756a21c0b1f8~dbdCrzAMK0776807768euoutp01u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1755680172;
	bh=o9pup7lxdlJYj1WCugUFlZF6W3E8/CCvLfzm1q+9rG4=;
	h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
	b=QufDc8xI4smr/1tvhd+SQFha5cIatKLD68bYKP9t8/viN5Yv4cLSeqkF12kCcGupA
	 u2ftjM3OCojP1cFELRvPstlvMqTrnirsY2W8nmDy8j3zJM3yIF077/rLWv/8eCSSNn
	 vZMJsMzC7o6pg5OJ0wOdTWHNcvNA3aVgv1Q9Mod0=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250820085612eucas1p1ae19fd1baf24a0c445d1d439f944a2a7~dbdCKCdpp0935209352eucas1p1r;
	Wed, 20 Aug 2025 08:56:12 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
	[106.210.136.40]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250820085611eusmtip15bff8603433a6dbae2aca87e78707bdc~dbdBKMNHw3025430254eusmtip1S;
	Wed, 20 Aug 2025 08:56:11 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Wed, 20 Aug 2025 10:55:56 +0200
Subject: [PATCH v12 4/4] drm/imagination: Enable PowerVR driver for RISC-V
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-apr_14_for_sending-v12-4-4213ccefbd05@samsung.com>
In-Reply-To: <20250820-apr_14_for_sending-v12-0-4213ccefbd05@samsung.com>
To: Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>,  Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor Dooley
	<conor+dt@kernel.org>,  Michal Wilczynski <m.wilczynski@samsung.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Philipp Zabel <p.zabel@pengutronix.de>,
	Frank Binns <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,  Maxime Ripard
	<mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,  David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,  Paul Walmsley
	<paul.walmsley@sifive.com>,  Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>,  Alexandre Ghiti <alex@ghiti.fr>, Ulf Hansson
	<ulf.hansson@linaro.org>,  Marek Szyprowski <m.szyprowski@samsung.com>, 
	Drew Fustini <fustini@kernel.org>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org,  Bartosz Golaszewski
	<bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.15-dev
X-CMS-MailID: 20250820085612eucas1p1ae19fd1baf24a0c445d1d439f944a2a7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250820085612eucas1p1ae19fd1baf24a0c445d1d439f944a2a7
X-EPHeader: CA
X-CMS-RootMailID: 20250820085612eucas1p1ae19fd1baf24a0c445d1d439f944a2a7
References: <20250820-apr_14_for_sending-v12-0-4213ccefbd05@samsung.com>
	<CGME20250820085612eucas1p1ae19fd1baf24a0c445d1d439f944a2a7@eucas1p1.samsung.com>

Several RISC-V boards feature Imagination GPUs that are compatible with
the PowerVR driver. An example is the IMG BXM-4-64 GPU on the Lichee Pi
4A board. This commit adjusts the driver's Kconfig dependencies to allow
the PowerVR driver to be compiled on the RISC-V architecture.

By enabling compilation on RISC-V, we expand support for these GPUs,
providing graphics acceleration capabilities and enhancing hardware
compatibility on RISC-V platforms.

The RISC-V support is restricted to 64-bit systems (RISCV && 64BIT) as
the driver currently has an implicit dependency on a 64-bit platform.

Add a dependency on MMU to fix a build warning on RISC-V configurations
without an MMU.

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 drivers/gpu/drm/imagination/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/imagination/Kconfig b/drivers/gpu/drm/imagination/Kconfig
index 3bfa2ac212dccb73c53bdc2bc259bcba636e7cfc..682dd2633d0c012df18d0f7144d029b67a14d241 100644
--- a/drivers/gpu/drm/imagination/Kconfig
+++ b/drivers/gpu/drm/imagination/Kconfig
@@ -3,8 +3,9 @@
 
 config DRM_POWERVR
 	tristate "Imagination Technologies PowerVR (Series 6 and later) & IMG Graphics"
-	depends on ARM64
+	depends on (ARM64 || RISCV && 64BIT)
 	depends on DRM
+	depends on MMU
 	depends on PM
 	select DRM_EXEC
 	select DRM_GEM_SHMEM_HELPER

-- 
2.34.1


