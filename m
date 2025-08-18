Return-Path: <linux-kernel+bounces-774311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75309B2B110
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 21:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73031176815
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 19:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1AE2750E6;
	Mon, 18 Aug 2025 18:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qBdwTp1U"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8240E274676
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 18:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755543564; cv=none; b=MPMAdjSFclEHDRX19cyo0ONfOGvjoQOyCnAJtWv9veybaMeqxxbI6Vk9RCXvG4nliCoMsMLw/2CgOwleQzVLmfjKuo+relQiiNtQSogOrroBZoOWTJVWuWiKaiJKMdcl4GIE099SCI3/dV3uw/dALG+L1CAizn1IABihRAtimIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755543564; c=relaxed/simple;
	bh=KCf8mGsR1gsCa0BBbnSNhtvNKeu0P1lUjsNkZEwyXIw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nBy0XjgdMK5mH7Kb2Ws7A/pRVSnwRwFkguyHSS7PGtpSTLw0bc8hl5eNs06vP76Q78g6Oa92NHkooQhO/oNJbUAJ6quWrdgcusphiI4bvchd2Ft2pC6uoi+cu1FQsKbne0rySiOMhX7xabpgcfUTqRTwN4Z+oph0GmHOlbZ6b4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qBdwTp1U; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1755543560;
	bh=KCf8mGsR1gsCa0BBbnSNhtvNKeu0P1lUjsNkZEwyXIw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qBdwTp1UmdtCTM/gTRlV/HAWeIePLu9Z/CsHMoAXn36HP3/5CCoRZr0WRc+AFkgKo
	 2jfvO30/CxA2cUWZVnwTsltW4wzMS5IY6jSnIXPUmc3uEhx7Len/hIEUMZCzF2Gq5C
	 JggHOykGcHWJBrTtFBP3jT9NgwIPPbgt3JGofd94xJ6m0jIM4SwwEsH1IaG5B49C+U
	 e3zyFR5mMs8BbJpbRMq3qVrFfcPd0/8B39WT8N+BFnbfpH5vASj4RluVyD8LRQUUKs
	 c+znXeVDzrcnTyYLTcAM40x8fSBs1ulyJ4cFvI771/BY2oNAZg1WnV/gEfgiN8gM/r
	 NdABcdUc3oBmg==
Received: from localhost (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 9EC5317E04C0;
	Mon, 18 Aug 2025 20:59:20 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Mon, 18 Aug 2025 21:59:01 +0300
Subject: [PATCH v3 01/14] phy: hdmi: Add HDMI 2.1 FRL configuration options
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-phy-hdptx-frl-v3-1-c79997d8bb2b@collabora.com>
References: <20250818-phy-hdptx-frl-v3-0-c79997d8bb2b@collabora.com>
In-Reply-To: <20250818-phy-hdptx-frl-v3-0-c79997d8bb2b@collabora.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, Algea Cao <algea.cao@rock-chips.com>, 
 Dmitry Baryshkov <lumag@kernel.org>
Cc: kernel@collabora.com, linux-phy@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org
X-Mailer: b4 0.14.2

The HDMI 2.1 specification introduced the Fixed Rate Link (FRL) mode,
aiming to replace the older Transition-Minimized Differential Signaling
(TMDS) mode used in previous HDMI versions to support much higher
bandwidths (up to 48 Gbps) for modern video and audio formats.

FRL has been designed to support ultra high resolution formats at high
refresh rates like 8K@60Hz or 4K@120Hz, and eliminates the need for
dynamic bandwidth adjustments, which reduces latency.  It operates with
3 or 4 lanes at different link rates: 3Gbps, 6Gbps, 8Gbps, 10Gbps or
12Gbps.

Add support for configuring the FRL mode for HDMI PHYs.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 include/linux/phy/phy-hdmi.h | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/include/linux/phy/phy-hdmi.h b/include/linux/phy/phy-hdmi.h
index f0ec963c6e84f1b7728acafc824dff191c6b873d..83330d359e3ae345554f20429519da14506b8ab5 100644
--- a/include/linux/phy/phy-hdmi.h
+++ b/include/linux/phy/phy-hdmi.h
@@ -6,16 +6,31 @@
 #ifndef __PHY_HDMI_H_
 #define __PHY_HDMI_H_
 
+#include <linux/types.h>
+
+enum phy_mode_hdmi {
+	PHY_MODE_HDMI_TMDS,
+	PHY_MODE_HDMI_FRL,
+};
+
 /**
  * struct phy_configure_opts_hdmi - HDMI configuration set
- * @tmds_char_rate: HDMI TMDS Character Rate in Hertz.
  * @bpc: Bits per color channel.
+ * @tmds_char_rate: HDMI TMDS Character Rate in Hertz.
+ * @frl.rate_per_lane: HDMI FRL Rate per Lane in Gbps.
+ * @frl.lanes: HDMI FRL lanes count.
  *
  * This structure is used to represent the configuration state of a HDMI phy.
  */
 struct phy_configure_opts_hdmi {
-	unsigned long long tmds_char_rate;
 	unsigned int bpc;
+	union {
+		unsigned long long tmds_char_rate;
+		struct {
+			u8 rate_per_lane;
+			u8 lanes;
+		} frl;
+	};
 };
 
 #endif /* __PHY_HDMI_H_ */

-- 
2.50.1


