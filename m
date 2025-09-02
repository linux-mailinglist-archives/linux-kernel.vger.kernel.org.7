Return-Path: <linux-kernel+bounces-797308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 473E5B40EAF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 22:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9175F3B7BDF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 20:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2922E8B79;
	Tue,  2 Sep 2025 20:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="LkMlajey"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C582E7F0E
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 20:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756845896; cv=none; b=Bwyt8T+/JWklviFXx5ZCyvz6AwZG8saxIMju7yAcnnhVUUsV4yFB5K99zcr88qEjxaMuWeI18S7swsHBdKYIjq1lziTmABrVb4vWhoREspboV+sW62xTno7ErdpO9alxXHln6/IQWh9f5aEmn0Z0KfS2pzIxbig1Ae5Zje1bqkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756845896; c=relaxed/simple;
	bh=uAjAgXeRfa++7TzMQXDYJfWBDuyTpZXti/Fx/3Cs76Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MmSxMRUx/K1xJ0LKeQX/VwN+wJxLT09RQomMeVfpEnUPlceByCFcGyt3KfWLv/LU+SNY/jo44fEloTKfwvPW8yMLRsRCjPtEOoBiLncc0GAuSoj0H7rJuZOAOLwKasSqm9FonOZzDILCaIk4ROB93XcMyZ6EER2/UjHA5MRoBAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=LkMlajey; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1756845893;
	bh=uAjAgXeRfa++7TzMQXDYJfWBDuyTpZXti/Fx/3Cs76Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LkMlajey5rMhK3SiLl/e9e1G+zPnjm9acE7YS3qIdCLphhOI7k8+7Kp3zkpwoB4KC
	 RmlMF3Fe5k3wsxRp3Q0ylmVmAZcLAEnYcvz8tRPMWQ1cS8blpWAsLjS6RlRsVnryER
	 YtvjzGCQ9LinZ+F2cp9Ll8XT8Oos2hzpA+gk4Ra6GHbcSat1A/PUYagt7HaCwZ39+7
	 KVt7Vp6cHLRGQVzMUVf9cZ5Rb1G0RRkpH82d3cxIfNDP/pG4qFtr23U1ghSvS4wnWr
	 3cz/EFmi0Y4/cQ5A5jZBZp75CiliaDz4lznTVNgZ8RPSDXsYXcKIfKbiZVxuF/7nbN
	 LxChYZvas5Wxg==
Received: from localhost (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 254AF17E0579;
	Tue,  2 Sep 2025 22:44:53 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 02 Sep 2025 23:44:36 +0300
Subject: [PATCH v4 01/11] phy: hdmi: Add HDMI 2.1 FRL configuration options
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-phy-hdptx-frl-v4-1-7d69176373ce@collabora.com>
References: <20250902-phy-hdptx-frl-v4-0-7d69176373ce@collabora.com>
In-Reply-To: <20250902-phy-hdptx-frl-v4-0-7d69176373ce@collabora.com>
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
index f0ec963c6e84f1b7728acafc824dff191c6b873d..d4cf4430ee8f3bf0f18a109c5a7640293a4293b1 100644
--- a/include/linux/phy/phy-hdmi.h
+++ b/include/linux/phy/phy-hdmi.h
@@ -6,16 +6,31 @@
 #ifndef __PHY_HDMI_H_
 #define __PHY_HDMI_H_
 
+#include <linux/types.h>
+
+enum phy_hdmi_mode {
+	PHY_HDMI_MODE_TMDS,
+	PHY_HDMI_MODE_FRL,
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
2.51.0


