Return-Path: <linux-kernel+bounces-830621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B431B9A23F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 16:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94A191B25C52
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 14:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE6C1E7660;
	Wed, 24 Sep 2025 14:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="jnyhz+dV"
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E6786329
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 14:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758722566; cv=none; b=iGgaS2TVOPQ/IGv228yd09L4ZbrMh5C9IBDQu8j9w+6LSdDvjPwNqol2qYEuPpnS6npxuhjS+pjUH74U1Zlx4XNNaDAl7Q83nhQb2St/Fz7E6pvGVGARw4P8EeimLMu96TNPQnKNpwZkjrHLWXXyJOtSwL9AvpvdNPUGGD12xsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758722566; c=relaxed/simple;
	bh=3IffwREs0vhmlCeCQYs5nhAVdpSXz4RSrQPdv05YxDs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JUpiiRvtdVV2wEXSP8DpeWL5Go5QE4JazZhULl/LEgEUVB952mnaaP3mcVH7oe4pcOnl0CmxrWGLPXuejozI4hdBiOAqgD9xyMnOuXvlSU4o/ZOdn7eQ/aSl7lGHWqnLv4zKKE86Iqsox257iV2dCcBZO6L5SdjEfbbLzatXyik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=jnyhz+dV; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from petrov-tower.intra.ispras.ru (unknown [10.10.2.58])
	by mail.ispras.ru (Postfix) with ESMTPSA id 67E5B402837E;
	Wed, 24 Sep 2025 14:02:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 67E5B402837E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1758722553;
	bh=T0+3uqja+AcM3h5mmWLoH6MCphRpuvic80vfhVRNM+s=;
	h=From:To:Cc:Subject:Date:From;
	b=jnyhz+dVVoAGjN7Ld89McMTj9+MUNsLcickFRlb5ZL9rAlGNExS+L8tKJs4uhjeyG
	 09A8bmFobZTnQZ1W4vXqaOiPltZjn3KJW8xBWMWvAM7DwAysMsMKyyb7bNujhxAvQX
	 yjE/LDFUpap7RBzBeY6T7POH1g/VD51pvBY7xIGo=
From: Oleg Petrov <o.petrov@ispras.ru>
To: Julia Lawall <Julia.Lawall@inria.fr>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Oleg Petrov <o.petrov@ispras.ru>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	cocci@inria.fr,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	Vadim Mutilin <mutilin@ispras.ru>,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH] cocci: drm: report devm-allocated arguments and fields
Date: Wed, 24 Sep 2025 17:01:26 +0300
Message-Id: <20250924140126.23027-1-o.petrov@ispras.ru>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add two Coccinelle rules: (1) flag a devres-managed pointer
passed to a drm-init function, and (2) flag a devres-managed
pointer assigned to a field of drm-managed struct. The mismatch
of the lifespan between devres- and drm-managed memory can cause
a use-after-free error. The rules' have high confidence.

badarg: Report when a pointer to devres-managed memory is passed
   as the second argument to several drm_*_init* functions that
   (a) have such rule documented or (b) are some simple wrappers
   to such a function.

badarg2: The same, but pass the devm-allocated pointer through
   an intermediate variable before passing to a drm-init function.

badfield: Report when a devm-allocated pointer is assigned to a
   field of a drm-managed struct.

Found by Linux Verification Center (linuxtesting.org).

Signed-off-by: Oleg Petrov <o.petrov@ispras.ru>
---
v1: Among drivers/gpu/drm, Coccinelle finds 7 functions (b) that call
functions (a). I included 5 of those in the rule. I did not check other files.
The functions are the same for v6.1+.
Patch https://lore.kernel.org/all/20240216125040.8968-1-e.orlova@ispras.ru/
fixes such violations in stm module. badargs are obvious from diff,
and the badfield is fixed in first lines where ldev is allocated.
 .../coccinelle/api/drm_dont_devm_alloc.cocci  | 124 ++++++++++++++++++
 1 file changed, 124 insertions(+)
 create mode 100644 scripts/coccinelle/api/drm_dont_devm_alloc.cocci

diff --git a/scripts/coccinelle/api/drm_dont_devm_alloc.cocci b/scripts/coccinelle/api/drm_dont_devm_alloc.cocci
new file mode 100644
index 000000000000..693977e98666
--- /dev/null
+++ b/scripts/coccinelle/api/drm_dont_devm_alloc.cocci
@@ -0,0 +1,124 @@
+// SPDX-License-Identifier: GPL-2.0-only
+///
+/// Find (1) devres-allocated (usually by devm_kzalloc) argument to drm_*_init
+/// functions or (2) assignment of devres-allocated pointer to a field of a drm-
+/// allocated struct (usually dev_private of drm_device). The mismatch of the
+/// lifespan between devres- and drm-managed memory can cause a use-after-free.
+//
+// Confidence: High
+// Copyright: (C) 2025 Oleg Petrov ISPRAS
+// Options: --no-includes --include-headers
+//
+
+virtual report
+virtual org
+
+// find devm-allocated (devres-managed) second arg for drm*init functions
+@badarg exists@
+position p;
+expression devm,e;
+@@
+// only devm_kzalloc is really used
+devm = \(devm_kzalloc\|devm_kcalloc\|devm_kmalloc\|devm_kmalloc_array\)(...);
+...
+// The kernel-doc comments (v6+) for these 5 functions
+// forbid them to use devm-allocated argument.
+( drm_connector_init
+| drm_crtc_init_with_planes
+| drm_connector_init_with_ddc
+| drm_encoder_init
+| drm_universal_plane_init
+// These are the wrappers found in drivers/gpu/drm/*.c
+// i.e. these call those above and just pass the second argument.
+| drm_bridge_connector_init
+| drm_crtc_init
+| drm_plane_init
+// drm_simple_display_pipe_init // does not apply
+| drm_simple_encoder_init
+| drm_writeback_connector_init
+// mipi_dbi_dev_init_with_formats // does not apply
+) ( e,<+...devm@p...+>,...)
+
+// same as above, but with an intermediate local variable
+@badarg2 exists@
+position p;
+expression devm,e;
+identifier vitm;
+@@
+// only devm_kzalloc is really used
+devm = \(devm_kzalloc\|devm_kcalloc\|devm_kmalloc\|devm_kmalloc_array\)(...);
+...
+vitm = <+...devm...+>;
+...
+// The kernel-doc comments (v6+) for these 5 functions
+// forbid them to use devm-allocated argument.
+( drm_connector_init
+| drm_crtc_init_with_planes
+| drm_connector_init_with_ddc
+| drm_encoder_init
+| drm_universal_plane_init
+// These are the wrappers found in drivers/gpu/drm/*.c
+// i.e. these call those above and just pass the second argument.
+| drm_bridge_connector_init
+| drm_crtc_init
+| drm_plane_init
+// drm_simple_display_pipe_init // does not apply
+| drm_simple_encoder_init
+| drm_writeback_connector_init
+// mipi_dbi_dev_init_with_formats // does not apply
+) ( e,<+...devm@p...+>,...)
+
+// find direct assignment of devres-managed memory to drm device
+@badfield exists@
+position p;
+expression drm,devm;
+identifier f;
+@@
+(
+drm = \(drm_dev_alloc\|drmm_kzalloc\|drmm_kcalloc\|drmm_kmalloc\|drmm_kmalloc_array\)(...);
+...
+devm = \(devm_kzalloc\|devm_kcalloc\|devm_kmalloc\|devm_kmalloc_array\)(...);
+|
+devm = \(devm_kzalloc\|devm_kcalloc\|devm_kmalloc\|devm_kmalloc_array\)(...);
+...
+drm = \(drm_dev_alloc\|drmm_kzalloc\|drmm_kcalloc\|drmm_kmalloc\|drmm_kmalloc_array\)(...);
+)
+...
+drm->f =@p <+...devm...+>;
+
+
+@script:python depends on report@
+p << badarg.p;
+@@
+msg = "WARNING devm-allocated argument in a drm-init; use drmm-init family (or drmm-alloc)."
+coccilib.report.print_report(p[0], msg)
+
+@script:python depends on org@
+p << badarg.p;
+@@
+msg = "WARNING devm-allocated argument in a drm-init; use drmm-init family (or drmm-alloc)."
+coccilib.org.print_report(p[0], msg)
+
+@script:python depends on report@
+p << badarg2.p;
+@@
+msg = "WARNING devm-allocated argument in a drm-init; use drmm-init family (or drmm-alloc)."
+coccilib.report.print_report(p[0], msg)
+
+@script:python depends on org@
+p << badarg2.p;
+@@
+msg = "WARNING devm-allocated argument in a drm-init; use drmm-init family (or drmm-alloc)."
+coccilib.org.print_report(p[0], msg)
+
+@script:python depends on report@
+p << badfield.p;
+@@
+msg = "WARNING devm-allocated field in a drmm-allocated struct; consider drmm-init family or use drmm-alloc."
+coccilib.report.print_report(p[0], msg)
+
+@script:python depends on org@
+p << badfield.p;
+@@
+msg = "WARNING devm-allocated field in a drmm-allocated struct; consider drmm-init family or use drmm-alloc."
+coccilib.org.print_report(p[0], msg)
-- 
2.34.1


