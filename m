Return-Path: <linux-kernel+bounces-722267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 545E3AFD729
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 21:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61D6B3B6B16
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 19:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE33A226173;
	Tue,  8 Jul 2025 19:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="OTNtPggK"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8D62248B3
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 19:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752003420; cv=none; b=O4ERfd7ycjwyCAMUbSoLlGDGa5J5rrQ1ZhK/IhQnpaIZ26TGuHzdZEMTryWvbm2YuQWqESVnruuWC+bWA9YH+ijw6I/0m3mvWH9zB41zzYiern0Omuob1lsnvUav47SSgiCdlSUcqSUnI9ZbeV02lgRtPDKSfoZZzeIZtfkc0uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752003420; c=relaxed/simple;
	bh=DZ07FftUuUFoLz4dKR+5e4A2hHQAYJ90Yq5kFNKzni8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iiBqQYqWQpEhyy38TwNAaVmj6iLmdxFZrOEnKy1J8SALM7jgsXcber13dICE3Ehoas7BmpxgncNebPHuJP9P7Cv5qEMME+d2v3L+DP7j1UovyUaSq00QsEhAxAF5sHCZWAMKVLR8Yt7lsrblTq44OUEFU+IlKFtTbziSHkVUpiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=OTNtPggK; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1752003416;
	bh=DZ07FftUuUFoLz4dKR+5e4A2hHQAYJ90Yq5kFNKzni8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OTNtPggKXTdERxFhH4lMVJsacxQUgadDNNhkPIxUrp54Es9Ygo+Ju2DzkDW/3hl/n
	 OXpSL026NPDjW1S2N1Z/zmN2a7bGBwk0nAcCLm0V+F3XBAjvL/zwW8Sy3lAXh4+RL1
	 Xj32FGjTJJerinQegcP/ZEF2R032B6ikWEFJfcX/HO+KXUgB1m4ZoX0M1najg5TFtd
	 96P/9UXbypxjZkZMLU3qQZYZVmknqbrTWqEI/Hyfi1CIrKIuqQ0Klw6MTip9nCCYH3
	 ZmBUjV7okgCe2r6wlFJ9s5uobRdfYqS1neB8QT049AfPVKbxBhcIStXUcT8gf7dLbh
	 TAc1/7T9Mc92w==
Received: from localhost (unknown [212.93.144.165])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 6670D17E0FB8;
	Tue,  8 Jul 2025 21:36:56 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 08 Jul 2025 22:35:42 +0300
Subject: [PATCH 01/12] phy: hdmi: Add HDMI 2.1 FRL configuration options
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250708-phy-hdptx-frl-v1-1-cfe096e224f4@collabora.com>
References: <20250708-phy-hdptx-frl-v1-0-cfe096e224f4@collabora.com>
In-Reply-To: <20250708-phy-hdptx-frl-v1-0-cfe096e224f4@collabora.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, Algea Cao <algea.cao@rock-chips.com>
Cc: kernel@collabora.com, linux-phy@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org
X-Mailer: b4 0.14.2

Add support for configuring the Fixed Rate Link (FRL) mode for HDMI
PHYs.

For improved clarity, also rename existing HDMI mode to HDMI_TMDS.
Since this mode is currently not being used explicitly, no further
changes are needed.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 include/linux/phy/phy-hdmi.h | 14 ++++++++++++--
 include/linux/phy/phy.h      |  3 ++-
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/include/linux/phy/phy-hdmi.h b/include/linux/phy/phy-hdmi.h
index f0ec963c6e84f1b7728acafc824dff191c6b873d..0b26472d8defcc9ded142d4283e29861dc2b3746 100644
--- a/include/linux/phy/phy-hdmi.h
+++ b/include/linux/phy/phy-hdmi.h
@@ -6,16 +6,26 @@
 #ifndef __PHY_HDMI_H_
 #define __PHY_HDMI_H_
 
+#include <linux/types.h>
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
diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index 13add0c2c40721fe9ca3f0350d13c035cd25af45..04c84c1dbd6dac55fd04c54203cff4f9d939d970 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -44,7 +44,8 @@ enum phy_mode {
 	PHY_MODE_SATA,
 	PHY_MODE_LVDS,
 	PHY_MODE_DP,
-	PHY_MODE_HDMI,
+	PHY_MODE_HDMI_TMDS,
+	PHY_MODE_HDMI_FRL,
 };
 
 enum phy_media {

-- 
2.50.0


