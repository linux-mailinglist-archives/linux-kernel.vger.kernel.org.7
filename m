Return-Path: <linux-kernel+bounces-891432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F9FC42A6E
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 10:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DACA188A947
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 09:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3652EC08C;
	Sat,  8 Nov 2025 09:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="rO0DfbWr"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F4427F4E7;
	Sat,  8 Nov 2025 09:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762594606; cv=none; b=q0EXfsh7iWWM7zJGM/9uaY2dMOoqQV1SslQqYIcDyt/w3avkv01RNfH6EVIYGhbP0lndLe6IEqX03G0ZgdQOuNE0HEwElFpyYGQRFzlroc3kvrxbpIcLhHgn5VL+cVs6mThSq85EjG0YDzU4NS50zIShthe1kZ4Ggxf4tRgak3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762594606; c=relaxed/simple;
	bh=BLauyWgclUw8G3IPAW8WN28EBqbVDl7XpGY054U/ub8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c3N8MEEUYwUm5ZMbqfICdC9VTq9bsOce6HgpbO2dF/ieLsaAoBxcOVNmQCcklJOurZ0AzllzaUqb3kfXChx0s0TX+m0G3juFMJxz+rxtKm9MQdA4eJIr39PnQ/DWpKlxX33b+iFxkF9OJO6iKE4zXBOPjMq/YNfyneSy45hfGJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=rO0DfbWr; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [192.168.0.172] (mob-5-90-142-135.net.vodafone.it [5.90.142.135])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id BA22EE1F;
	Sat,  8 Nov 2025 10:34:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1762594485;
	bh=BLauyWgclUw8G3IPAW8WN28EBqbVDl7XpGY054U/ub8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rO0DfbWrGyc0wDGGl4oY/+Imy66F2S/Z5Ut+UMR/uNK/VbglYNuEgHffxeVfaFkDC
	 frJlCASTpIPnMxyolZeAebXUA9ltYKbJSZPArHIyYDen7GORItFRXbc8v+tPy/pMZE
	 kVN3yY35bqAa28ip6x5aI0x9+mRlTeTeWi2YPr/U=
From: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Date: Sat, 08 Nov 2025 10:36:22 +0100
Subject: [PATCH v9 1/8] media: uapi: Introduce V4L2 generic ISP types
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251108-extensible-parameters-validation-v9-1-6a7e22aa57d0@ideasonboard.com>
References: <20251108-extensible-parameters-validation-v9-0-6a7e22aa57d0@ideasonboard.com>
In-Reply-To: <20251108-extensible-parameters-validation-v9-0-6a7e22aa57d0@ideasonboard.com>
To: Dafna Hirschfeld <dafna@fastmail.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Keke Li <keke.li@amlogic.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, Dan Scally <dan.scally@ideasonboard.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Antoine Bouyer <antoine.bouyer@nxp.com>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 Jacopo Mondi <jacopo.mondi@ideasonboard.com>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
 Michael Riesch <michael.riesch@collabora.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6466;
 i=jacopo.mondi@ideasonboard.com; h=from:subject:message-id;
 bh=BLauyWgclUw8G3IPAW8WN28EBqbVDl7XpGY054U/ub8=;
 b=owEBbQKS/ZANAwAKAXI0Bo8WoVY8AcsmYgBpDw8lTUZllRl/YkTq/v6bnfhFzsif8H7Xopty6
 jIugFC8SFOJAjMEAAEKAB0WIQS1xD1IgJogio9YOMByNAaPFqFWPAUCaQ8PJQAKCRByNAaPFqFW
 PH3XD/0T6mQJOBZWmFAHRJbbEdggAIMFbJ37jbwVfaDWYZvHtXrnNKhgCFD3CetsE2QMUbjJLya
 IsUoZnuJoGdXSfiHhTBQEQ6RiZ9QVTsmaZU/r68MzO8kQp/8V9l7L8SO4myJHrwcwhg7djLvPDd
 NcN2VUcFeWa8cA13ues+rBdM0p6JBeZDeJzT1x0ziOZ0Ywb1o8uYvNbSNL5PhophrHC2ciqorNs
 fxdMrxxXS7V9dou+ptOk5mK7q1iUtcMprjZRXPSL1F4HyDmNLFfPPTy8R25FF5CX0Udqm1JDnLK
 82eIHkNguCfYwjvZeVigmqIQhX5E89g6h+XjO28OfauHhinDtq4xPtwrkMwGV6FEjGI3HqVIaIR
 HfKwYW1AALSG/v0JjRH2Ue7RG3t1HpU+5izeYw8RzGzlGsJZaDOfHFCgwOEb2cJakc2qAOPPIFF
 6iyVej/OQTLONqDMuX/yR2bFcC9yTI7r1pbNmlg910v5zB8d4mSzVFqFyX5cR8WhMQ4EuPw9C/m
 wEC2UfJFaRitejILy1y7ubOBYpY2sa/o9HVjswKHqHbnI3W49p1LsNEdZTMkW092svqCCHiLIX3
 lLF59XMmPFi/OyMAdKNkzuXzP/UNouDjLebJ8iIBbSyZruQ2dbjjCNHWgXMhyhLmv2zaL6WvmkH
 5VJhcZjb31JD07A==
X-Developer-Key: i=jacopo.mondi@ideasonboard.com; a=openpgp;
 fpr=72392EDC88144A65C701EA9BA5826A2587AD026B

Introduce v4l2-isp.h in the Linux kernel uAPI.

The header includes types for generic ISP configuration parameters
and will be extended in the future with support for generic ISP statistics
formats.

Generic ISP parameters support is provided by introducing two new
types that represent an extensible and versioned buffer of ISP
configuration parameters.

The v4l2_params_buffer represents the container for the ISP
configuration data block. The generic type is defined with a 0-sized
data member that the ISP driver implementations shall properly size
according to their capabilities. The v4l2_params_block_header structure
represents the header to be prepend to each ISP configuration block.

Signed-off-by: Daniel Scally <dan.scally@ideasonboard.com>
Reviewed-by: Daniel Scally <dan.scally@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Michael Riesch <michael.riesch@collabora.com>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
---
 MAINTAINERS                         |   6 +++
 include/uapi/linux/media/v4l2-isp.h | 102 ++++++++++++++++++++++++++++++++++++
 2 files changed, 108 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8aec054a6ac7280d11356737787d4b63a4bd5584..8989e7e00d86d0c13c4c0b7e5c7eb9481b65861f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26855,6 +26855,12 @@ F:	drivers/media/i2c/vd55g1.c
 F:	drivers/media/i2c/vd56g3.c
 F:	drivers/media/i2c/vgxy61.c
 
+V4L2 GENERIC ISP PARAMETERS AND STATISTIC FORMATS
+M:	Jacopo Mondi <jacopo.mondi@ideasonboard.com>
+L:	linux-media@vger.kernel.org
+S:	Maintained
+F:	include/uapi/linux/media/v4l2-isp.h
+
 VF610 NAND DRIVER
 M:	Stefan Agner <stefan@agner.ch>
 L:	linux-mtd@lists.infradead.org
diff --git a/include/uapi/linux/media/v4l2-isp.h b/include/uapi/linux/media/v4l2-isp.h
new file mode 100644
index 0000000000000000000000000000000000000000..779168f9058e3bcf6451f681e247d34d95676cc0
--- /dev/null
+++ b/include/uapi/linux/media/v4l2-isp.h
@@ -0,0 +1,102 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Video4Linux2 generic ISP parameters and statistics support
+ *
+ * Copyright (C) 2025 Ideas On Board Oy
+ * Author: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
+ */
+
+#ifndef _UAPI_V4L2_ISP_H_
+#define _UAPI_V4L2_ISP_H_
+
+#include <linux/stddef.h>
+#include <linux/types.h>
+
+/**
+ * enum v4l2_isp_params_version - V4L2 ISP parameters versioning
+ *
+ * @V4L2_ISP_PARAMS_VERSION_V0: First version of the V4L2 ISP parameters format
+ *				(for compatibility)
+ * @V4L2_ISP_PARAMS_VERSION_V1: First version of the V4L2 ISP parameters format
+ *
+ * V0 and V1 are identical in order to support drivers compatible with the V4L2
+ * ISP parameters format already upstreamed which use either 0 or 1 as their
+ * versioning identifier. Both V0 and V1 refers to the first version of the
+ * V4L2 ISP parameters format.
+ *
+ * Future revisions of the V4L2 ISP parameters format should start from the
+ * value of 2.
+ */
+enum v4l2_isp_params_version {
+	V4L2_ISP_PARAMS_VERSION_V0 = 0,
+	V4L2_ISP_PARAMS_VERSION_V1
+};
+
+#define V4L2_ISP_PARAMS_FL_BLOCK_DISABLE	(1U << 0)
+#define V4L2_ISP_PARAMS_FL_BLOCK_ENABLE		(1U << 1)
+
+/*
+ * Reserve the first 8 bits for V4L2_ISP_PARAMS_FL_* flag.
+ *
+ * Driver-specific flags should be defined as:
+ * #define DRIVER_SPECIFIC_FLAG0     ((1U << V4L2_ISP_PARAMS_FL_DRIVER_FLAGS(0))
+ * #define DRIVER_SPECIFIC_FLAG1     ((1U << V4L2_ISP_PARAMS_FL_DRIVER_FLAGS(1))
+ */
+#define V4L2_ISP_PARAMS_FL_DRIVER_FLAGS(n)       ((n) + 8)
+
+/**
+ * struct v4l2_isp_params_block_header - V4L2 extensible parameters block header
+ * @type: The parameters block type (driver-specific)
+ * @flags: A bitmask of block flags (driver-specific)
+ * @size: Size (in bytes) of the parameters block, including this header
+ *
+ * This structure represents the common part of all the ISP configuration
+ * blocks. Each parameters block shall embed an instance of this structure type
+ * as its first member, followed by the block-specific configuration data.
+ *
+ * The @type field is an ISP driver-specific value that identifies the block
+ * type. The @size field specifies the size of the parameters block.
+ *
+ * The @flags field is a bitmask of per-block flags V4L2_PARAMS_ISP_FL_* and
+ * driver-specific flags specified by the driver header.
+ */
+struct v4l2_isp_params_block_header {
+	__u16 type;
+	__u16 flags;
+	__u32 size;
+} __attribute__((aligned(8)));
+
+/**
+ * struct v4l2_isp_params_buffer - V4L2 extensible parameters configuration
+ * @version: The parameters buffer version (driver-specific)
+ * @data_size: The configuration data effective size, excluding this header
+ * @data: The configuration data
+ *
+ * This structure contains the configuration parameters of the ISP algorithms,
+ * serialized by userspace into a data buffer. Each configuration parameter
+ * block is represented by a block-specific structure which contains a
+ * :c:type:`v4l2_isp_params_block_header` entry as first member. Userspace
+ * populates the @data buffer with configuration parameters for the blocks that
+ * it intends to configure. As a consequence, the data buffer effective size
+ * changes according to the number of ISP blocks that userspace intends to
+ * configure and is set by userspace in the @data_size field.
+ *
+ * The parameters buffer is versioned by the @version field to allow modifying
+ * and extending its definition. Userspace shall populate the @version field to
+ * inform the driver about the version it intends to use. The driver will parse
+ * and handle the @data buffer according to the data layout specific to the
+ * indicated version and return an error if the desired version is not
+ * supported.
+ *
+ * For each ISP block that userspace wants to configure, a block-specific
+ * structure is appended to the @data buffer, one after the other without gaps
+ * in between. Userspace shall populate the @data_size field with the effective
+ * size, in bytes, of the @data buffer.
+ */
+struct v4l2_isp_params_buffer {
+	__u32 version;
+	__u32 data_size;
+	__u8 data[] __counted_by(data_size);
+};
+
+#endif /* _UAPI_V4L2_ISP_H_ */

-- 
2.51.0


