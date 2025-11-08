Return-Path: <linux-kernel+bounces-891439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C9EC42AB0
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 10:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F13773A3C55
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 09:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7052F617E;
	Sat,  8 Nov 2025 09:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="X64BHdQ8"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F3F2F5A16;
	Sat,  8 Nov 2025 09:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762594620; cv=none; b=J6t3XqA5xqIUwE/Pm+AhLDNz1hpjrjdizteeh6hbfpmCEtS3EptNhzSBjlxcuovJMO3huJ/zSZ/bwhxtVJXaif46u1XXw4VUVR9XwcSC7SEoCH62nMQqhYV8/0oHG6kK/avw+saLu04ZzeZ45JlUXXN3Wn8+8L/mBcRt0c4OY4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762594620; c=relaxed/simple;
	bh=unblC2giKYD3uiatEYi0ZweERga9XTWzkHw2hg2KQNc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K/fQfoBgNoHQCF4/idhD7t2FKIdksHf2+9yiRUIJft7VQReZPLRNcmO7hvuD6+XTL9v2eiu3T4AClPIO7Lql23j8O/gefCz22xAezo0NcvHrhDjtXipXOtm8yCpilZJdkyVv4Ob6rMNhhmsuDjcy7ATos1Y5Wlj4H8ERpClT/4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=X64BHdQ8; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [192.168.0.172] (mob-5-90-142-135.net.vodafone.it [5.90.142.135])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 70FE7F89;
	Sat,  8 Nov 2025 10:34:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1762594494;
	bh=unblC2giKYD3uiatEYi0ZweERga9XTWzkHw2hg2KQNc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=X64BHdQ88uTtFzdNQg26B6iI1LJ2SKGnhiLqrUiBLytUJvWMG50bpFqcF03qkHq/h
	 c8BNSmIOGGvrkKF9gmZShfIquaHGRBQriAl1ly3T/W7DJeH4Fb50k1nF5NjIf4RRLr
	 yi50HfJqaZuq2aRx2Njg9FjIwARqgklIiGp6MHKA=
From: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Date: Sat, 08 Nov 2025 10:36:29 +0100
Subject: [PATCH v9 8/8] media: Documentation: kapi: Add v4l2 generic ISP
 support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251108-extensible-parameters-validation-v9-8-6a7e22aa57d0@ideasonboard.com>
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
 Michael Riesch <michael.riesch@collabora.com>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4236;
 i=jacopo.mondi@ideasonboard.com; h=from:subject:message-id;
 bh=unblC2giKYD3uiatEYi0ZweERga9XTWzkHw2hg2KQNc=;
 b=owEBbQKS/ZANAwAKAXI0Bo8WoVY8AcsmYgBpDw8mugHbUy0HBAmf2IJaIWqdb45XHTSwvOHZz
 fepfGtFCNKJAjMEAAEKAB0WIQS1xD1IgJogio9YOMByNAaPFqFWPAUCaQ8PJgAKCRByNAaPFqFW
 PIYJD/4tgmgxZ2K/fAYcBmL31WCcEuC6OcXRWYEHzJKigLlwX9n4NUsq1ghWyo9NpYbRHKkt3cb
 krkukRHzjenZuhRB7YnF4ctA6WPxz13ctcyQ9xxt5A1LaI4vcsUERA7h+iNOR7z460rEXnqnnse
 iIP3zFHdvthzmLdmxak/XB0So9BRUFf1scrDbNmPbLn0FG+CN7KdR8ZJDv4yUmqDrOoRgrtwHa1
 7s8TnBI10HbPXaI1/jdtms0uCmZUJWMc6Qs05Wx1YNjHDA2nZDHGX2nmi9CkCloraTSmD6QscXd
 az4RtNytADzN/gzG4/KaDRmDpN8+G415Vnpbyguz5huReu2ejz8aIP2QpHmV07DdyVToTKe5MiB
 HuPZ+pH8GSjq6Gkfx5GridMEfu9TGBJl/zsnE2y+TYBCFxmTjaoTL/erH9yUe6CmcQCx9Em8hHT
 Q2KAkgc1Znpk4cWyx2zCR5pNguzm7M6hRaXSYxZ483/L1SSJRDh/LA4xB8JHXTTbUykHl70d+Zb
 xkF2MNBSUHtrydAxRAH+HWXDtZk2tiHgIeHGmGSXElx78wFD0rXm1mOjMO3semHFLDwUxXUd4VH
 QypJe+I2cG8hn/enif50rVhru0ox2Vz/68HyKkinfKdWzHDlzfio4hbD+K23rdTSQvT7wiZ2E3i
 MUQiS8gCqaJH8og==
X-Developer-Key: i=jacopo.mondi@ideasonboard.com; a=openpgp;
 fpr=72392EDC88144A65C701EA9BA5826A2587AD026B

Add to the driver-api documentation the v4l2-isp.h types and
helpers documentation.

Reviewed-by: Daniel Scally <dan.scally@ideasonboard.com>
Reviewed-by: Michael Riesch <michael.riesch@collabora.com>
Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Signed-off-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
---
 Documentation/driver-api/media/v4l2-core.rst |  1 +
 Documentation/driver-api/media/v4l2-isp.rst  | 49 ++++++++++++++++++++++++++++
 MAINTAINERS                                  |  1 +
 3 files changed, 51 insertions(+)

diff --git a/Documentation/driver-api/media/v4l2-core.rst b/Documentation/driver-api/media/v4l2-core.rst
index ad987c34ad2a8460bb95e97adc4d850d624e0b81..a5f5102c64cca57b57b54ab95882b26286fb27de 100644
--- a/Documentation/driver-api/media/v4l2-core.rst
+++ b/Documentation/driver-api/media/v4l2-core.rst
@@ -27,3 +27,4 @@ Video4Linux devices
     v4l2-common
     v4l2-tveeprom
     v4l2-jpeg
+    v4l2-isp
diff --git a/Documentation/driver-api/media/v4l2-isp.rst b/Documentation/driver-api/media/v4l2-isp.rst
new file mode 100644
index 0000000000000000000000000000000000000000..618ae614ff79424a9edb23509644e89d57071b2a
--- /dev/null
+++ b/Documentation/driver-api/media/v4l2-isp.rst
@@ -0,0 +1,49 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+V4L2 generic ISP parameters and statistics support
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+Design rationale
+================
+
+ISP configuration parameters and statistics are processed and collected by
+drivers and exchanged with userspace through data types that usually
+reflect the ISP peripheral registers layout.
+
+Each ISP driver defines its own metadata output format for parameters and
+a metadata capture format for statistics. The buffer layout is realized by a
+set of C structures that reflects the registers layout. The number and types
+of C structures is fixed by the format definition and becomes part of the Linux
+kernel uAPI/uABI interface.
+
+Because of the hard requirement of backward compatibility when extending the
+user API/ABI interface, modifying an ISP driver capture or output metadata
+format after it has been accepted by mainline is very hard if not impossible.
+
+It generally happens, in fact, that after the first accepted revision of an ISP
+driver the buffers layout need to be modified, either to support new hardware
+blocks, to fix bugs or to support different revisions of the hardware.
+
+Each of these situations would require defining a new metadata format, making it
+really hard to maintain and extend drivers and requiring userspace to use
+the correct format depending on the kernel revision in use.
+
+V4L2 ISP configuration parameters
+=================================
+
+For these reasons, Video4Linux2 defines generic types for ISP configuration
+parameters and statistics. Drivers are still expected to define their own
+formats for their metadata output and capture nodes, but the buffers layout can
+be defined using the extensible and versioned types defined by
+include/uapi/linux/media/v4l2-isp.h.
+
+Drivers are expected to provide the definitions of their supported ISP blocks
+and the expected maximum size of a buffer.
+
+For driver developers a set of helper functions to assist them with validation
+of the buffer received from userspace is available in
+drivers/media/v4l2-core/v4l2-isp.c
+
+V4L2 ISP support driver documentation
+=====================================
+.. kernel-doc:: include/media/v4l2-isp.h
diff --git a/MAINTAINERS b/MAINTAINERS
index f9a86528a153f635a5a3db5ce9cf6854f699f47f..931b0fc72279a5ce2830d1ce5d2845ed1a2ae633 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26859,6 +26859,7 @@ V4L2 GENERIC ISP PARAMETERS AND STATISTIC FORMATS
 M:	Jacopo Mondi <jacopo.mondi@ideasonboard.com>
 L:	linux-media@vger.kernel.org
 S:	Maintained
+F:	Documentation/driver-api/media/v4l2-isp.rst
 F:	Documentation/userspace-api/media/v4l/v4l2-isp.rst
 F:	drivers/media/v4l2-core/v4l2-isp.c
 F:	include/media/v4l2-isp.h

-- 
2.51.0


