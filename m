Return-Path: <linux-kernel+bounces-604438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D99A3A8946F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 09:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 823FA3B0823
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 07:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93505268FF4;
	Tue, 15 Apr 2025 07:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZELVIMeb"
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96B7634
	for <linux-kernel@vger.kernel.org>; Tue, 15 Apr 2025 07:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744700989; cv=none; b=b25LTeFKmt5ITiE+rsMxx4NZUd1sMSi+QFH0oWC/1j7Y3rwIUPpqpiUipV3NNN81yf7M8bd1qh9gogC23s/+i9l+BEUJeT23Snt4SglgAlIZ6P3OVYFDhZJN32EixRXpQdvFHS/7XZbNga45gQi1E2UdCvIKluI1e1+N5QjNUQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744700989; c=relaxed/simple;
	bh=/8P/xLSMj/KQXAUxbACwRA390xXl77sG2wWF0zjr1vs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UgX9PP5aHtOiGH/d/izlDoajNYIIwuIRTxq1aYa/6vshw+dLI5yGsTE07wfFYvRg/fRgT36vywt/dAzkR4ht7j6CQhH0UaUVWI7QjQVzS+Ld8TwMm65ZSgLunZhOyXZPl+kj4lj3O1xw52y8nnu/jMxXjbWFRMYlGrYHVtTTk4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ZELVIMeb; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53F79MoT2403775
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Apr 2025 02:09:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1744700962;
	bh=MgDXnjyVZlpStO44bqEYevY9Nn+8PUgujzMmn5CY9zE=;
	h=From:To:CC:Subject:Date;
	b=ZELVIMeb4vWYM3lMXp4yvTURKOH2k39GgdQH7HAwIaxjKPMoqlXPswGaPJ1E5kiAO
	 101qr9yfm3da/nArxekTBa3NdxIHEqSDT9QqX8D81XejAYhKil0q4Xk0ccibwsUxtu
	 HSQIT6bISBvIJrru4QpT8rMwrKpbyZuvrRIXmIWo=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53F79MKe082251
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 15 Apr 2025 02:09:22 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 15
 Apr 2025 02:09:21 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 15 Apr 2025 02:09:21 -0500
Received: from LT5CG31242FY.dhcp.ti.com (lt5cg31242fy.dhcp.ti.com [10.85.14.150])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53F79Hpu014712;
	Tue, 15 Apr 2025 02:09:18 -0500
From: Shenghao Ding <shenghao-ding@ti.com>
To: <tiwai@suse.de>
CC: <broonie@kernel.org>, <andriy.shevchenko@linux.intel.com>,
        <13564923607@139.com>, <13916275206@139.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <baojun.xu@ti.com>, <Baojun.Xu@fpt.com>, <robinchen@ti.com>,
        Shenghao Ding <shenghao-ding@ti.com>
Subject: [RESEND PATCH v2] ALSA: hda/tas2781: Create a common header for both spi and i2c tas2781 hda driver
Date: Tue, 15 Apr 2025 15:09:13 +0800
Message-ID: <20250415070913.679-1-shenghao-ding@ti.com>
X-Mailer: git-send-email 2.33.0.windows.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Move the common macro definition of kcontrols into a common header.

Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>

---
v2:
 - Follow IWYU principle, add sound/asound.h into the header file.
v1:
 - Revise the year of spi and i2c tas2781 hda drivers.
 - Create a common header for both spi and i2c tas2781 hda driver to define
   the common macros and declare the common functions.
---
 sound/pci/hda/tas2781_hda.h     | 44 +++++++++++++++++++++++++++++++++
 sound/pci/hda/tas2781_hda_i2c.c | 29 ++--------------------
 sound/pci/hda/tas2781_hda_spi.c | 35 ++------------------------
 3 files changed, 48 insertions(+), 60 deletions(-)
 create mode 100644 sound/pci/hda/tas2781_hda.h

diff --git a/sound/pci/hda/tas2781_hda.h b/sound/pci/hda/tas2781_hda.h
new file mode 100644
index 000000000000..fc741fac419a
--- /dev/null
+++ b/sound/pci/hda/tas2781_hda.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0-only=0D
+ *=0D
+ * HDA audio driver for Texas Instruments TAS2781 smart amp=0D
+ *=0D
+ * Copyright (C) 2025 Texas Instruments, Inc.=0D
+ */=0D
+#ifndef __TAS2781_HDA_H__=0D
+#define __TAS2781_HDA_H__=0D
+=0D
+#include <sound/asound.h>=0D
+=0D
+/*=0D
+ * No standard control callbacks for SNDRV_CTL_ELEM_IFACE_CARD=0D
+ * Define two controls, one is Volume control callbacks, the other is=0D
+ * flag setting control callbacks.=0D
+ */=0D
+=0D
+/* Volume control callbacks for tas2781 */=0D
+#define ACARD_SINGLE_RANGE_EXT_TLV(xname, xreg, xshift, xmin, xmax, xinver=
t, \=0D
+	xhandler_get, xhandler_put, tlv_array) { \=0D
+	.iface =3D SNDRV_CTL_ELEM_IFACE_CARD, .name =3D (xname), \=0D
+	.access =3D SNDRV_CTL_ELEM_ACCESS_TLV_READ | \=0D
+		SNDRV_CTL_ELEM_ACCESS_READWRITE, \=0D
+	.tlv.p =3D (tlv_array), \=0D
+	.info =3D snd_soc_info_volsw, \=0D
+	.get =3D xhandler_get, .put =3D xhandler_put, \=0D
+	.private_value =3D (unsigned long)&(struct soc_mixer_control) { \=0D
+		.reg =3D xreg, .rreg =3D xreg, \=0D
+		.shift =3D xshift, .rshift =3D xshift,\=0D
+		.min =3D xmin, .max =3D xmax, .invert =3D xinvert, \=0D
+	} \=0D
+}=0D
+=0D
+/* Flag control callbacks for tas2781 */=0D
+#define ACARD_SINGLE_BOOL_EXT(xname, xdata, xhandler_get, xhandler_put) { =
\=0D
+	.iface =3D SNDRV_CTL_ELEM_IFACE_CARD, \=0D
+	.name =3D xname, \=0D
+	.info =3D snd_ctl_boolean_mono_info, \=0D
+	.get =3D xhandler_get, \=0D
+	.put =3D xhandler_put, \=0D
+	.private_value =3D xdata, \=0D
+}=0D
+=0D
+#endif=0D
diff --git a/sound/pci/hda/tas2781_hda_i2c.c b/sound/pci/hda/tas2781_hda_i2=
c.c
index 29dc4f500580..9d94ae5fcfe0 100644
--- a/sound/pci/hda/tas2781_hda_i2c.c
+++ b/sound/pci/hda/tas2781_hda_i2c.c
@@ -2,7 +2,7 @@
 //
 // TAS2781 HDA I2C driver
 //
-// Copyright 2023 - 2024 Texas Instruments, Inc.
+// Copyright 2023 - 2025 Texas Instruments, Inc.
 //
 // Author: Shenghao Ding <shenghao-ding@ti.com>
 // Current maintainer: Baojun Xu <baojun.xu@ti.com>
@@ -30,35 +30,10 @@
 #include "hda_component.h"
 #include "hda_jack.h"
 #include "hda_generic.h"
+#include "tas2781_hda.h"
=20
 #define TASDEVICE_SPEAKER_CALIBRATION_SIZE	20
=20
-/* No standard control callbacks for SNDRV_CTL_ELEM_IFACE_CARD
- * Define two controls, one is Volume control callbacks, the other is
- * flag setting control callbacks.
- */
-
-/* Volume control callbacks for tas2781 */
-#define ACARD_SINGLE_RANGE_EXT_TLV(xname, xreg, xshift, xmin, xmax, xinver=
t, \
-	xhandler_get, xhandler_put, tlv_array) \
-{	.iface =3D SNDRV_CTL_ELEM_IFACE_CARD, .name =3D (xname),\
-	.access =3D SNDRV_CTL_ELEM_ACCESS_TLV_READ |\
-		 SNDRV_CTL_ELEM_ACCESS_READWRITE,\
-	.tlv.p =3D (tlv_array), \
-	.info =3D snd_soc_info_volsw, \
-	.get =3D xhandler_get, .put =3D xhandler_put, \
-	.private_value =3D (unsigned long)&(struct soc_mixer_control) \
-		{.reg =3D xreg, .rreg =3D xreg, .shift =3D xshift, \
-		 .rshift =3D xshift, .min =3D xmin, .max =3D xmax, \
-		 .invert =3D xinvert} }
-
-/* Flag control callbacks for tas2781 */
-#define ACARD_SINGLE_BOOL_EXT(xname, xdata, xhandler_get, xhandler_put) \
-{	.iface =3D SNDRV_CTL_ELEM_IFACE_CARD, .name =3D xname, \
-	.info =3D snd_ctl_boolean_mono_info, \
-	.get =3D xhandler_get, .put =3D xhandler_put, \
-	.private_value =3D xdata }
-
 enum calib_data {
 	R0_VAL =3D 0,
 	INV_R0,
diff --git a/sound/pci/hda/tas2781_hda_spi.c b/sound/pci/hda/tas2781_hda_sp=
i.c
index 399f2e4c3b62..c6be2be1b53e 100644
--- a/sound/pci/hda/tas2781_hda_spi.c
+++ b/sound/pci/hda/tas2781_hda_spi.c
@@ -2,7 +2,7 @@
 //
 // TAS2781 HDA SPI driver
 //
-// Copyright 2024 Texas Instruments, Inc.
+// Copyright 2024 - 2025 Texas Instruments, Inc.
 //
 // Author: Baojun Xu <baojun.xu@ti.com>
=20
@@ -38,38 +38,7 @@
 #include "hda_component.h"
 #include "hda_jack.h"
 #include "hda_generic.h"
-
-/*
- * No standard control callbacks for SNDRV_CTL_ELEM_IFACE_CARD
- * Define two controls, one is Volume control callbacks, the other is
- * flag setting control callbacks.
- */
-
-/* Volume control callbacks for tas2781 */
-#define ACARD_SINGLE_RANGE_EXT_TLV(xname, xreg, xshift, xmin, xmax, xinver=
t, \
-	xhandler_get, xhandler_put, tlv_array) { \
-	.iface =3D SNDRV_CTL_ELEM_IFACE_CARD, .name =3D (xname), \
-	.access =3D SNDRV_CTL_ELEM_ACCESS_TLV_READ | \
-		SNDRV_CTL_ELEM_ACCESS_READWRITE, \
-	.tlv.p =3D (tlv_array), \
-	.info =3D snd_soc_info_volsw, \
-	.get =3D xhandler_get, .put =3D xhandler_put, \
-	.private_value =3D (unsigned long)&(struct soc_mixer_control) { \
-		.reg =3D xreg, .rreg =3D xreg, \
-		.shift =3D xshift, .rshift =3D xshift,\
-		.min =3D xmin, .max =3D xmax, .invert =3D xinvert, \
-	} \
-}
-
-/* Flag control callbacks for tas2781 */
-#define ACARD_SINGLE_BOOL_EXT(xname, xdata, xhandler_get, xhandler_put) { \
-	.iface =3D SNDRV_CTL_ELEM_IFACE_CARD, \
-	.name =3D xname, \
-	.info =3D snd_ctl_boolean_mono_info, \
-	.get =3D xhandler_get, \
-	.put =3D xhandler_put, \
-	.private_value =3D xdata, \
-}
+#include "tas2781_hda.h"
=20
 struct tas2781_hda {
 	struct tasdevice_priv *priv;
--=20
2.34.1


