Return-Path: <linux-kernel+bounces-880710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D82C265D4
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 18:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DC8F2351F99
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 17:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586E7350A26;
	Fri, 31 Oct 2025 17:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="aD5hd/QZ"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23FE3054F7
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 17:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761931716; cv=none; b=J8K/pCXy5SQlmkR7aVtCXYheUaefY/Dq4KsLeDsxXdESRtJq8+kajJTMch4Vzp1U/6PWo2lsx2gi94drkf7TzM+EAUJ7EHbcUcgH2cnGu9sUhjeYxgKXvhjE3xMoOP4Rj+wueSFEkj5xwkwhis4zqImuRGv1lBKq7/OcSX4P2e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761931716; c=relaxed/simple;
	bh=pOlUZ/eYmURkI9UAYzXg8XzcXPBjNBMhjQguuGX/sPU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qv7XSbsYbdmPOv3+rnNfuEkKQBWDD905098T3K0t88JgjXqUrD5HrYDQRUIv7+U1uC30rX5wdWDzF5SXXgjUTqeV2I7iM8EhkjKlrncCUAtscHLZ1elvEzl1jZRkM+Q8lD0Z4WOcekXheWs+NqHvtOkyDIJbh9D0yDMTI5fImvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=aD5hd/QZ; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from mail.ideasonboard.com (unknown [IPv6:2401:4900:1c69:314e:ee86:ae6e:30:9d13])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3A5073A2;
	Fri, 31 Oct 2025 18:26:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1761931602;
	bh=pOlUZ/eYmURkI9UAYzXg8XzcXPBjNBMhjQguuGX/sPU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aD5hd/QZjuAu2DbdSCIPFQhjdZbcliqwShb3T5PBuEnYTMAShyXKMkJ+X8PMwRWrI
	 FKP1P4m0hVoyJC0nhaAgGl6dU8mBPg+Z3anTwd3j5e46b4aGQzfjGagdvDUcVCpRKs
	 SM0jPtD/9gOTtDhovWhGO/D7oBRNtr+wE90OySkA=
From: Jai Luthra <jai.luthra@ideasonboard.com>
Date: Fri, 31 Oct 2025 22:57:25 +0530
Subject: [PATCH 05/13] platform/raspberrypi: vchiq-mmal: Add in the bayer
 and gray formats
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-b4-vc-sm-cma-v1-5-0dd5c0ec3f5c@ideasonboard.com>
References: <20251031-b4-vc-sm-cma-v1-0-0dd5c0ec3f5c@ideasonboard.com>
In-Reply-To: <20251031-b4-vc-sm-cma-v1-0-0dd5c0ec3f5c@ideasonboard.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 bcm-kernel-feedback-list@broadcom.com
Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Phil Elwell <phil@raspberrypi.com>, Stefan Wahren <wahrenst@gmx.net>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Kieran Bingham <kieran.bingham@ideasonboard.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Jai Luthra <jai.luthra@ideasonboard.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3072;
 i=jai.luthra@ideasonboard.com; h=from:subject:message-id;
 bh=spTPBZUUYTCoXyLwYiPFicRWxsPp0oGfOuM0+6jDegE=;
 b=owEBbQKS/ZANAwAKAUPekfkkmnFFAcsmYgBpBPGYZjTE6iQ+/Z2roISP58pFWBX1/U/xtzJhV
 izcRsgqeX6JAjMEAAEKAB0WIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCaQTxmAAKCRBD3pH5JJpx
 RfqPEAC/u7t7MEC6xEzkyZzkuWCQII9Y7t6g7mP0O/cPj7eXyBH3pJaoo7Uw8tYMMJA16RFM4dJ
 1HmEFDNI+mR7Uwx1xXNXhpG8zDivegPfepY/+AXmXwqrkT2MysaIsKWSM519IU8fjgw1UbfoyAe
 4qIeZfHgGH9iZ4jclCh2A9zo13pb48/Z3qI4BxT8OXYVR+EcME+wEMTgTk5S/EvTYDgCGIt6bi1
 DroblV5lXv47lettfSxpsvWUwqe4kvxt1vynCJyduS6cV1mmooU77r38JoFlMt1PXUlC7akJfRZ
 n7zCksgq4E5Lpj+MdTjugHnLds+TZmDN4Tz8l54jv31jjP4uSayOe+mKOADJih7jhilGA3So6uN
 yJLPnWuTKuW5CVBvJxHw/GuQ9WNnaV2D5jc4+BYrdgAcf0b+Eo+V/Iot/RBdILePQmr7cuckaoN
 PrVPugMLoQdLHU/6v/HLClIMxCXBzXItswM64o+BhlzFiiG7XPlKWjj/uBui/8sQhdOMHdu09wD
 SKv6+lCAT1m21KtQSf84BNC9tyhqPVN6pKTuILldx0SfHdk8LrXmyti2g02waKD6UOhm0ZOeO9t
 soEytmYGldaBGX4zJ9y5azgF/DFf/OhKPQFGJltLFxNU4TgnL4S/o5LuoRJttke2JlReTmJFoj7
 2OKL32+/nLwqKZg==
X-Developer-Key: i=jai.luthra@ideasonboard.com; a=openpgp;
 fpr=4DE0D818E5D575E8D45AAFC543DE91F9249A7145

From: Dave Stevenson <dave.stevenson@raspberrypi.org>

The ISP and codec support bayer and gray formats, so add in the
encodings for them.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.org>
Signed-off-by: Jai Luthra <jai.luthra@ideasonboard.com>
---
 drivers/platform/raspberrypi/vchiq-mmal/mmal-encodings.h | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/platform/raspberrypi/vchiq-mmal/mmal-encodings.h b/drivers/platform/raspberrypi/vchiq-mmal/mmal-encodings.h
index e15ae7b24f73fd055806e2e88e5eec0e1b8bfe9d..826ed66deafd082f43539c5b4702a2e0b6a2fe95 100644
--- a/drivers/platform/raspberrypi/vchiq-mmal/mmal-encodings.h
+++ b/drivers/platform/raspberrypi/vchiq-mmal/mmal-encodings.h
@@ -69,6 +69,47 @@
  */
 #define MMAL_ENCODING_OPAQUE           MMAL_FOURCC('O', 'P', 'Q', 'V')
 
+/**
+ * Bayer formats
+ * FourCC values copied from V4L2 where defined.
+ */
+/* 8 bit per pixel Bayer formats. */
+#define MMAL_ENCODING_BAYER_SBGGR8     MMAL_FOURCC('B', 'A', '8', '1')
+#define MMAL_ENCODING_BAYER_SGBRG8     MMAL_FOURCC('G', 'B', 'R', 'G')
+#define MMAL_ENCODING_BAYER_SGRBG8     MMAL_FOURCC('G', 'R', 'B', 'G')
+#define MMAL_ENCODING_BAYER_SRGGB8     MMAL_FOURCC('R', 'G', 'G', 'B')
+
+/* 10 bit per pixel packed Bayer formats. */
+#define MMAL_ENCODING_BAYER_SBGGR10P   MMAL_FOURCC('p', 'B', 'A', 'A')
+#define MMAL_ENCODING_BAYER_SGRBG10P   MMAL_FOURCC('p', 'g', 'A', 'A')
+#define MMAL_ENCODING_BAYER_SGBRG10P   MMAL_FOURCC('p', 'G', 'A', 'A')
+#define MMAL_ENCODING_BAYER_SRGGB10P   MMAL_FOURCC('p', 'R', 'A', 'A')
+
+/* 12 bit per pixel packed Bayer formats. */
+#define MMAL_ENCODING_BAYER_SBGGR12P   MMAL_FOURCC('p', 'B', '1', '2')
+#define MMAL_ENCODING_BAYER_SGRBG12P   MMAL_FOURCC('p', 'g', '1', '2')
+#define MMAL_ENCODING_BAYER_SGBRG12P   MMAL_FOURCC('p', 'G', '1', '2')
+#define MMAL_ENCODING_BAYER_SRGGB12P   MMAL_FOURCC('p', 'R', '1', '2')
+
+/* 14 bit per pixel packed Bayer formats. */
+#define MMAL_ENCODING_BAYER_SBGGR14P   MMAL_FOURCC('p', 'B', 'E', 'E')
+#define MMAL_ENCODING_BAYER_SGBRG14P   MMAL_FOURCC('p', 'G', 'E', 'E')
+#define MMAL_ENCODING_BAYER_SGRBG14P   MMAL_FOURCC('p', 'g', 'E', 'E')
+#define MMAL_ENCODING_BAYER_SRGGB14P   MMAL_FOURCC('p', 'R', 'E', 'E')
+
+/* 16 bit per pixel Bayer formats. */
+#define MMAL_ENCODING_BAYER_SBGGR16    MMAL_FOURCC('B', 'G', '1', '6')
+#define MMAL_ENCODING_BAYER_SGBRG16    MMAL_FOURCC('G', 'B', '1', '6')
+#define MMAL_ENCODING_BAYER_SGRBG16    MMAL_FOURCC('G', 'R', '1', '6')
+#define MMAL_ENCODING_BAYER_SRGGB16    MMAL_FOURCC('R', 'G', '1', '6')
+
+/* MIPI packed monochrome images */
+#define MMAL_ENCODING_GREY    MMAL_FOURCC('G', 'R', 'E', 'Y')
+#define MMAL_ENCODING_Y10P    MMAL_FOURCC('Y', '1', '0', 'P')
+#define MMAL_ENCODING_Y12P    MMAL_FOURCC('Y', '1', '2', 'P')
+#define MMAL_ENCODING_Y14P    MMAL_FOURCC('Y', '1', '4', 'P')
+#define MMAL_ENCODING_Y16     MMAL_FOURCC('Y', '1', '6', ' ')
+
 /** An EGL image handle
  */
 #define MMAL_ENCODING_EGL_IMAGE        MMAL_FOURCC('E', 'G', 'L', 'I')

-- 
2.51.0


