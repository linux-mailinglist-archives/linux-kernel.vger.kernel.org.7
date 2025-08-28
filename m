Return-Path: <linux-kernel+bounces-789224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32720B39262
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 06:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB1107C13C2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 04:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68F32144D7;
	Thu, 28 Aug 2025 04:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b="Hd44Ke+3"
Received: from ironport.ite.com.tw (219-87-157-213.static.tfn.net.tw [219.87.157.213])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0A5265CA4;
	Thu, 28 Aug 2025 04:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=219.87.157.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756353812; cv=none; b=kESc6K/I+IWAY9gudaDHMiGuwjqko1aA1Kd7WL+tUNQwUUuDvDT4pIYjBrBnqAc84LtBnrL9F47gfxizhQ1AYRaEtsJQmiXjRbOVMMcxdPX93meYoACo3x+uc/MXWUR16l3U195Ho6I/EgUQab/3HgryUrFupTNcnTza7LKcOAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756353812; c=relaxed/simple;
	bh=OB4EAjXKghqmmJsht+EMIjwxC9vVhtVzs0OtpNzbruI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=c9nFd63XETh+ezvxvOj3cziKsutmB69ox9ukyuW2jPfsf/IwXyVaOMkNYuJaQbNb6tOwZ19+PqxtskQfXnnQkwfapxkPNMC+B28l7LYGHQoS5Qj5EpGbZqIvnzGxF0XAj3xaj3cTN/xK0cuk/gptv0uz0FZKr+AFgAyllfR8b70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw; spf=pass smtp.mailfrom=ite.com.tw; dkim=pass (2048-bit key) header.d=ite.com.tw header.i=@ite.com.tw header.b=Hd44Ke+3; arc=none smtp.client-ip=219.87.157.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ite.com.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ite.com.tw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=ite.com.tw; s=dkim;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=5i32xVWzp1ZgAbyeSFx2eN0Rw5Nb3gh7i2Zbl7txSXs=;
  b=Hd44Ke+3nje0Kq5uOVJhlEKXJ+tfwTt1TQRfHoXC+jwWJfWVytl+JHjx
   EWnSkvTA7CDyO3H1868IcGBlZdd4suQCYmzOhs//mXcmXvOkSXNN9u/u5
   KjeI1Zcwq+MYecFcU+SZ6cQCkRZ24qFlBNLlyvMtrNa2JRCHtF5Tktsuj
   7W8Mf46aLEZOkDy/HMVZ8cOT0Qbr2O+9d6jnkVGBvkHL+NS5NG3SWn9K4
   uxmdcT2ZMI9xpKZ0Y4Q+r4xfraWUwzfk9rpzP4BY7kgTnMfj0Ks/70Oha
   UVv7n8GdYJIx6dATJU2PUmAVcmrLfjEmLV6WWC9+iL8IrIKcljsckk8Ew
   Q==;
X-CSE-ConnectionGUID: GyMaAGshRJWnVk2KcR3shw==
X-CSE-MsgGUID: 13321c+KSSGPEaBr3haUMw==
Received: from unknown (HELO mse.ite.com.tw) ([192.168.35.30])
  by ironport.ite.com.tw with ESMTP; 28 Aug 2025 12:02:15 +0800
Received: from CSBMAIL1.internal.ite.com.tw (CSBMAIL1.internal.ite.com.tw [192.168.65.58])
	by mse.ite.com.tw with ESMTP id 57S429PX028070;
	Thu, 28 Aug 2025 12:02:09 +0800 (+08)
	(envelope-from Pet.Weng@ite.com.tw)
Received: from [127.0.1.1] (192.168.72.40) by CSBMAIL1.internal.ite.com.tw
 (192.168.65.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 28 Aug
 2025 12:02:08 +0800
From: Pet Weng <pet.weng@ite.com.tw>
Date: Thu, 28 Aug 2025 12:01:20 +0800
Subject: [PATCH v2 3/3] MAINTAINERS: Add entry for ITE IT61620 MIPI to HDMI
 bridge driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250828-it61620-0714-v2-3-586f5934d5f8@ite.com.tw>
References: <20250828-it61620-0714-v2-0-586f5934d5f8@ite.com.tw>
In-Reply-To: <20250828-it61620-0714-v2-0-586f5934d5f8@ite.com.tw>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756353731; l=1089;
 i=pet.weng@ite.com.tw; s=20250702; h=from:subject:message-id;
 bh=OB4EAjXKghqmmJsht+EMIjwxC9vVhtVzs0OtpNzbruI=;
 b=EOii9uEGakuF9g9P3b0vqIAS3c/C8LTpUjtNyPWI7qczi6B2/VbCQGvOpmeJP8ZL4+bGqRpI5
 Tt4bf95rD3bBaxWfJFLSJEXm8ygWljyR2lk373LtSB21SclrUJQF5v4
X-Developer-Key: i=pet.weng@ite.com.tw; a=ed25519;
 pk=wd08uBtTLb93x2ixbKVNsxiZPdMh1Ov4z5klodh2bqo=
X-ClientProxiedBy: CSBMAIL1.internal.ite.com.tw (192.168.65.58) To
 CSBMAIL1.internal.ite.com.tw (192.168.65.58)
X-TM-SNTS-SMTP:
	3E2A61BA08F6FA45881083E07CB89951BBD95433E7A70B275EE3B9DAE98C751C2002:8
X-MAIL:mse.ite.com.tw 57S429PX028070

Add a new entry for the ITE IT61620 MIPI to HDMI bridge driver to the
MAINTAINERS file, include the responsible maintainer, mailing list, and
file patterns.

Signed-off-by: Pet Weng <pet.weng@ite.com.tw>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cfa28b3470ab6d2f7cbe8161c3f415853a7ce9bf..5e9aaa76b788c790fc487bba1062a987c538ff67 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13074,6 +13074,14 @@ T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
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


