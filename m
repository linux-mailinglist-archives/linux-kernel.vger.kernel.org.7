Return-Path: <linux-kernel+bounces-780207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4920BB2FED0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 17:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45A197B4368
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 15:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A002341AD9;
	Thu, 21 Aug 2025 15:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LhLcjB6R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060E22D0620;
	Thu, 21 Aug 2025 15:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755790804; cv=none; b=JpvHDghSNOsGYF1hOVoN29sbSsXqcoYzIMnf48PLS1A+AcRV1LemdZz5KKertaF3c23le+dA305UmzNI2uprUvJRenHb2bZUOhlbD++3XSfpDzWGPNwPyeoWnhDZPGoTc6FR3eGBQ7rWVLOmV7zYGr+4zD3La5D4AvhaElEp3Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755790804; c=relaxed/simple;
	bh=9jDoVQ1/z0pxLrrUKQFvuFlzCV4MYmq0sO+xpriK97c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pdf/yFFtSoUN5uwUq8Y8NEuLbhIIMTwfZc7VnUom1KFB6fuuFjSSF+PgiGcYZ7o7AclQApe37jPQBUQ8Nbbx5Kk5KD+r1jc6wmn23I9G/nzzdfobN1VScUl3DUFYpIYck6l7CYlsB4KFG/NbfdQmDeGmMkE+urDAV3scYIJIhVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LhLcjB6R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 752C7C2BCB8;
	Thu, 21 Aug 2025 15:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755790803;
	bh=9jDoVQ1/z0pxLrrUKQFvuFlzCV4MYmq0sO+xpriK97c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LhLcjB6Reg3+JMHJNyU7msIaDCdB8DHH5hCnQOy77QlG0uVvelenxdBkXFCEgICoS
	 9Lwb8I3MCJxO00NIG91hUHC4Wvb5ap2z4mh79xKZ/Eg9lP5VvLXs8Vbtq1e+lP221X
	 E/rz0KhuMwr5LYr9gLBrofaFOlUh5ljPVPMWyDHoc+LHFI+WeDB3o+L/xbFT8CHczc
	 saMOpBDeyys99H71m6ML8F8gR6Bk7eyVOG37cT9pNrgCNfYnnG/Dg6m3CwRMzevehO
	 +oF7qY/bNNaEv7Ijgd6adK+eYHKTIbwhauqaRnIsW5HyWS5XARfxSKIyUO1iWwrRtd
	 6en06OiDEpVvg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A6A8CA0FE1;
	Thu, 21 Aug 2025 15:40:03 +0000 (UTC)
From: Sven Peter <sven@kernel.org>
Date: Thu, 21 Aug 2025 15:38:59 +0000
Subject: [PATCH RFC 07/22] usb: dwc3: apple: Adjust vendor-specific
 registers during init
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-atcphy-6-17-v1-7-172beda182b8@kernel.org>
References: <20250821-atcphy-6-17-v1-0-172beda182b8@kernel.org>
In-Reply-To: <20250821-atcphy-6-17-v1-0-172beda182b8@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Felipe Balbi <balbi@kernel.org>, 
 Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, 
 Neal Gompa <neal@gompa.dev>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, asahi@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org, 
 Sven Peter <sven@kernel.org>, Hector Martin <marcan@marcan.st>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2771; i=sven@kernel.org;
 h=from:subject:message-id;
 bh=Ikp6czp+quI9KYT9CWH9WFMemYOvMSa7Gr19hm1ueGQ=;
 b=owGbwMvMwCHmIlirolUq95LxtFoSQ8Zy2xVS+teCv0fd52+62njLwutKT41zZ+O9/bz75wlvL
 pgvVt/dUcrCIMbBICumyLJ9v73pk4dvBJduuvQeZg4rE8gQBi5OAZjI1B5GhjadZ9FrY78wRmp7
 NX++XLy80071lkXGivInUwP1uPbLRDL8T9LQdmuR5mrdu8jPKO/k4vYE4eU37k1duEylI+kKj+o
 NFgA=
X-Developer-Key: i=sven@kernel.org; a=openpgp;
 fpr=A1E3E34A2B3C820DBC4955E5993B08092F131F93
X-Endpoint-Received: by B4 Relay for sven@kernel.org/default with
 auth_id=407

From: Hector Martin <marcan@marcan.st>

When tracing Apple's dwc3 driver under our hypervisor and comparing its
MMIO access with their kernel debug output these vendor-specific
registers have been identified. We don't know exactly what these do
or why they are required but without changing these parameters sometimes
USB3 devices don't work or take an additional 5 seconds to be recognized.

Signed-off-by: Hector Martin <marcan@marcan.st>
Co-developed-by: Sven Peter <sven@kernel.org>
Signed-off-by: Sven Peter <sven@kernel.org>
---
 drivers/usb/dwc3/core.c | 17 +++++++++++++++++
 drivers/usb/dwc3/core.h | 18 ++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index f8013ba2bdc22fa5e719df0841b12b84d9465b62..e018e80778cf39a9981d438c7e54534b26cddf63 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1366,6 +1366,23 @@ static int dwc3_core_init(struct dwc3 *dwc)
 	 */
 	dwc3_writel(dwc->regs, DWC3_GUID, LINUX_VERSION_CODE);
 
+	/* Apply Apple quirks */
+	if (of_device_is_compatible(dwc->dev->of_node, "apple,t8103-dwc3")) {
+		dwc3_writel(dwc->regs,
+			    APPLE_DWC3_CIO_LFPS_OFFSET,
+			    APPLE_DWC3_CIO_LFPS_OFFSET_VALUE);
+		dwc3_writel(dwc->regs,
+			    APPLE_DWC3_CIO_BW_NGT_OFFSET,
+			    APPLE_DWC3_CIO_BW_NGT_OFFSET_VALUE);
+
+		u32 link_timer = dwc3_readl(dwc->regs, APPLE_DWC3_CIO_LINK_TIMER);
+
+		link_timer &= ~APPLE_DWC3_CIO_PENDING_HP_TIMER;
+		link_timer |= FIELD_PREP(APPLE_DWC3_CIO_PENDING_HP_TIMER,
+					 APPLE_DWC3_CIO_PENDING_HP_TIMER_VALUE);
+		dwc3_writel(dwc->regs, APPLE_DWC3_CIO_LINK_TIMER, link_timer);
+	}
+
 	ret = dwc3_phy_setup(dwc);
 	if (ret)
 		return ret;
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 98e748cc348dfd9de1962c93fcf9f6a6690c2388..1caa46ca8b2ffb74dd3e58b174122e8f8216dd48 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -181,6 +181,24 @@
 
 #define DWC3_LLUCTL(n)		(0xd024 + ((n) * 0x80))
 
+/*
+ * Apple Silicon dwc3 vendor-specific registers
+ *
+ * These registers were identified by tracing XNU's memory access patterns
+ * and correlating them with debug output over serial to determine their names.
+ * We don't exactly know what these do but without these USB3 devices sometimes
+ * don't work.
+ */
+#define APPLE_DWC3_CIO_LFPS_OFFSET 0xcd38
+#define APPLE_DWC3_CIO_LFPS_OFFSET_VALUE 0xf800f80
+
+#define APPLE_DWC3_CIO_BW_NGT_OFFSET 0xcd3c
+#define APPLE_DWC3_CIO_BW_NGT_OFFSET_VALUE 0xfc00fc0
+
+#define APPLE_DWC3_CIO_LINK_TIMER 0xcd40
+#define APPLE_DWC3_CIO_PENDING_HP_TIMER GENMASK(23, 16)
+#define APPLE_DWC3_CIO_PENDING_HP_TIMER_VALUE 0x14
+
 /* Bit fields */
 
 /* Global SoC Bus Configuration INCRx Register 0 */

-- 
2.34.1



