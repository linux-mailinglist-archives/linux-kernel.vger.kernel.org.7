Return-Path: <linux-kernel+bounces-756337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B6AB1B2E8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 13:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 405AF3A65B7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 11:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0162261595;
	Tue,  5 Aug 2025 11:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="c/1oRSWr"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A15156237
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 11:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754395011; cv=none; b=EdTDmqx9oxA4HLSekILq4LWMAjSdK2e8tLFXaipM8IrguKkFJqJaeKwJc2n0eAbPbSW7CZhmNv4hqBIfIdUalqfPYBdnLIRsmZmqSU8YqSpE01LDjTdjDElEjp48aP3mODvkbRXjNyRyCvzho666SkCLrvwETWC5i+kiqJfM+uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754395011; c=relaxed/simple;
	bh=DZ07FftUuUFoLz4dKR+5e4A2hHQAYJ90Yq5kFNKzni8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=paN2tdTFDvZ9YjxLJSHdYu8/wEFxz3tedKSo5Ch336z7QFF9LOPsXzeBDPR4dhVJWdZQiv+dheG0WrBY7LaS47FiW+1Mujhfts+w1eKMYjLTFYAQpr9wIj68rBmItuNrjnKZUAP8IsFi4OwbobB7RZ9TyTaj/IrzBBz5FwU4vgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=c/1oRSWr; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1754395007;
	bh=DZ07FftUuUFoLz4dKR+5e4A2hHQAYJ90Yq5kFNKzni8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=c/1oRSWrpeHE60SQo6gv5/qr2h5LhvziJWTrZuyaYoTU5xikn0lfi7c4RkAeemk9+
	 /lI6oa11m0LaN5SfSQl4CMCHYUazAQlt/xhdyP42I1S6P2WX/OALZMsh/5P0y5ffqi
	 m2EvsemH6FLAcDWmH3YgJmEuH7QtycXVsag+POEbveILQu2daJjgPp1Q4xVfuAJFtG
	 1zt4sVEwoX5SAAKzm0qgLVaAczzNkmepTlQBQGnQXZlod8suyMB0so6rYs8jkRbnvW
	 lZgOMRTRx2KJnqUJsVw1BTApJIrKMmZBlfCp/NwxAQMXsFBYYfiwaLjB98ZGhZZShs
	 qeXoMzYmFU8eA==
Received: from localhost (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 5FF2A17E04DA;
	Tue,  5 Aug 2025 13:56:47 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 05 Aug 2025 14:56:43 +0300
Subject: [PATCH v2 01/14] phy: hdmi: Add HDMI 2.1 FRL configuration options
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250805-phy-hdptx-frl-v2-1-d118bd4b6e0b@collabora.com>
References: <20250805-phy-hdptx-frl-v2-0-d118bd4b6e0b@collabora.com>
In-Reply-To: <20250805-phy-hdptx-frl-v2-0-d118bd4b6e0b@collabora.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, Algea Cao <algea.cao@rock-chips.com>, 
 Dmitry Baryshkov <lumag@kernel.org>
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


