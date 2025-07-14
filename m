Return-Path: <linux-kernel+bounces-729320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABE0B034EB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 05:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B86361763C1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 03:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DC71F0994;
	Mon, 14 Jul 2025 03:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b="FONcMrMM"
Received: from ironport.ite.com.tw (219-87-157-213.static.tfn.net.tw [219.87.157.213])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1060B1DEFDD;
	Mon, 14 Jul 2025 03:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=219.87.157.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752463129; cv=none; b=vGBWcVIkJyoqLoAdLg3EM2wg53w2Ig0dHl6tvYzfnFvyK60eEBbnxmcFeCVHpNgSLYv6wWw2DRU+FsZIuwM5QAdz5K1GFPWGu3964cAiq694jXLR9kiTTYPuD0OQGAIw0NbE6VbQQWxE5Bk7vSElMKeIHoKtOwNXArpY6Hsb4H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752463129; c=relaxed/simple;
	bh=+IFvH11m36wvX0dCALImUQ3my/Mqt5qCzewvfCRgKGM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=h9TVFIFi/NQwQTgOGKNNTgU8CHc4EHvQ1OTE8s9DTYzvrrSGeIaD5kjiPu8EPNiIveoTcQBJivDMEEG1wlwCBSgY1xR8+ATJqL/v8q4/5xhi8gSri+/zP8yteD0IZ7+z4iJr8Hn6BvgYS0v7cOhGhlHM+pWX0yYPUj58bS+Nwzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw; spf=pass smtp.mailfrom=ite.com.tw; dkim=pass (2048-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b=FONcMrMM; arc=none smtp.client-ip=219.87.157.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ite.com.tw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=ite.com.tw; s=dkim;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=+xKvYziZy9Gvntr50dLc06twjRMEnl6NNaXi41ccQvM=;
  b=FONcMrMMeEocmjGflfvKNWXcbIvgkCGNGMLW4VTv2PVAnRS0s6aIj1iB
   Ne9832qQGTNG2gZp/cunMqXwqEMED2/oMA8noSIg6owtT6xpwDAXR6sfA
   Q/qK24v3NnSYUfOLSLEq2gUA+4MeXNmUBUx3IIMAoVU2VGOYzSi6klJeP
   ZisuY4ZzVfbFFg24HGdmfuM8dJgQ4NP6MV+J2d9OzDLRKnSD+8jZTvSIH
   0PdiY6nfOKRsKKmhvxiJvQ4fTrsbRMYEoD8UUaIzpMA04P99+g3NLd23H
   +OLlOKrUNRyw/lZZa1L6PvuwqT/tzCEMgR7m5hwCCtLJ5U78XEZWzn0+X
   A==;
X-CSE-ConnectionGUID: o8EzQnz0Smqvo5vWA+sUsQ==
X-CSE-MsgGUID: 5SExJrQvQ0uZ9tNK+eq2ig==
Received: from unknown (HELO mse.ite.com.tw) ([192.168.35.30])
  by ironport.ite.com.tw with ESMTP; 14 Jul 2025 11:15:24 +0800
Received: from CSBMAIL1.internal.ite.com.tw (CSBMAIL1.internal.ite.com.tw [192.168.65.58])
	by mse.ite.com.tw with ESMTP id 56E3FIb7091142;
	Mon, 14 Jul 2025 11:15:18 +0800 (+08)
	(envelope-from Pet.Weng@ite.com.tw)
Received: from [127.0.1.1] (192.168.72.15) by CSBMAIL1.internal.ite.com.tw
 (192.168.65.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Jul
 2025 11:15:17 +0800
From: Pet Weng <pet.weng@ite.com.tw>
Date: Mon, 14 Jul 2025 11:14:34 +0800
Subject: [PATCH 3/3] MAINTAINERS: Add entry for ITE IT61620 MIPI to HDMI
 bridge driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250714-it61620-0714-v1-3-3761164d0b98@ite.com.tw>
References: <20250714-it61620-0714-v1-0-3761164d0b98@ite.com.tw>
In-Reply-To: <20250714-it61620-0714-v1-0-3761164d0b98@ite.com.tw>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong
	<neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart
	<Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej
 Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Hermes Wu <hermes.Wu@ite.com.tw>,
        Kenneth
 Hung <kenneth.Hung@ite.com.tw>,
        Pet Weng <pet.weng@ite.com.tw>, Pin-yen Lin
	<treapking@google.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752462909; l=1089;
 i=pet.weng@ite.com.tw; s=20250702; h=from:subject:message-id;
 bh=+IFvH11m36wvX0dCALImUQ3my/Mqt5qCzewvfCRgKGM=;
 b=kLIzaRsXKxETsQFi2MKlQgl341RfCbkH1jTZyI2G128bOqSoeRi91F4hAl1MpUnIDRFbcsxG7
 IN6NI7ijy/8AXxC13P9Pq9PEv8RfsEKk8v5b7VV8ofxRvkKy08JIBzu
X-Developer-Key: i=pet.weng@ite.com.tw; a=ed25519;
 pk=wd08uBtTLb93x2ixbKVNsxiZPdMh1Ov4z5klodh2bqo=
X-ClientProxiedBy: CSBMAIL1.internal.ite.com.tw (192.168.65.58) To
 CSBMAIL1.internal.ite.com.tw (192.168.65.58)
X-TM-SNTS-SMTP:
	AB5C484DFF45214EE4E133440795F671808876017C9EE7F203A2F1E899FFF2072002:8
X-MAIL:mse.ite.com.tw 56E3FIb7091142

Add a new entry for the ITE IT61620 MIPI to HDMI bridge driver to the
MAINTAINERS file, include the responsible maintainer, mailing list, and
file patterns.

Signed-off-by: Pet Weng <pet.weng@ite.com.tw>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ee2ef9d9db2ab3a2b462aaa1a7a473018c70596d..3a7167ac8a840321d2c5b0f230e3e29f72ced0b8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12916,6 +12916,14 @@ T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
 F:	Documentation/devicetree/bindings/display/bridge/ite,it6263.yaml
 F:	drivers/gpu/drm/bridge/ite-it6263.c
 
+ITE IT61620 MIPI DSI TO HDMI BRIDGE DRIVER
+M:	Pet Weng <pet.weng@ite.com.tw>
+L:	dri-devel@lists.freedesktop.org
+S:	Maintained
+T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
+F:	Documentation/devicetree/bindings/display/bridge/ite,it61620.yaml
+F:	drivers/gpu/drm/bridge/ite-it61620.c
+
 ITE IT66121 HDMI BRIDGE DRIVER
 M:	Phong LE <ple@baylibre.com>
 M:	Neil Armstrong <neil.armstrong@linaro.org>

-- 
2.34.1


