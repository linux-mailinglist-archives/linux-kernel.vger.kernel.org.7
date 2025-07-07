Return-Path: <linux-kernel+bounces-720246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A15BBAFB90F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 18:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 644654A614E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 16:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B132D23E334;
	Mon,  7 Jul 2025 16:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="j1FbE116"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3506223817A;
	Mon,  7 Jul 2025 16:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751906994; cv=none; b=k2DuVmSGi+Um5yWgich17f/dLNWyKeFgFtICAZvuzkXv0c7PpVACHIuKbLD3yga9H9++GT2UyXjBW7v9xRbr/8yKkcwl54OBrVjmqYQQuSxDqQM43PtdlaF49oqp5K5DZ6rYT4aRbt8X6Rzor7pSGJM31NoWPLrKNx9grj48VHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751906994; c=relaxed/simple;
	bh=Qz8v6cPHb2u2uf47/QYRFsu4w+OxY7kWX9SjdrHu/TY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kC0IWdqok8AlW4t5wOGSUEj/2wSbJ98y6MxT9UAcpJutiu6zwU0oF1tJlYaUgHzXaIHTuRvEpnRTcNNENzNRQhvBnYp4Zog/dwRnDw3fbIV6OGbQD/+ytof3cQS0xLHQexPxdBR7Nmsq/p6EYQ41UkGFfGl15P0xzrC4JHATe94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=j1FbE116; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=v4TLQmAGOcWD0y8Mnt5eC5Fpk/ELMiMig19bQQmdhOg=; b=j1FbE116GrdVoQK9ijrfRr8Hhx
	TKwzoBePZ7MsI/oHcKP5Cogld+t1KdRxusbn1hDlul5ZDEqw1WXz/dKOWKFwMq6fuGmURKHIYpwI6
	+k/xPiFDjgAE/5cedxZbeskedf3TXPbmX2GVW5nlLekqnESEMRxzQ1IXjXNCeZp6r3pXHZtw8NhAD
	kGrmjsG2uq9QxSjTCW+FSDeGYGqoya5bEPu7yCHelco4DfzNz3hpn/TC9QIOUNbr9lvrOzqWXZfT7
	wsRHwLxwbF/127nqi0xlgGT07+j2Jp5cAKlX5SDXdk9iZ9LMZUKqrGxAaZkUraoCJwKddFVrxBd7i
	sRSAtywA==;
Received: from i53875bf5.versanet.de ([83.135.91.245] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uYp1u-0004yl-N8; Mon, 07 Jul 2025 18:49:22 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: neil.armstrong@linaro.org,
	quic_jesszhan@quicinc.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	hjc@rock-chips.com,
	andy.yan@rock-chips.com,
	andyshrk@163.com,
	nicolas.frattaroli@collabora.com,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH 08/13] dt-bindings: display: rockchip: Add rk3576 to RK3588 DW DSI2 controller schema
Date: Mon,  7 Jul 2025 18:49:01 +0200
Message-ID: <20250707164906.1445288-9-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250707164906.1445288-1-heiko@sntech.de>
References: <20250707164906.1445288-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The rk3576 controller is based on the same newer Synopsis IP as the one
found in the rk3588.

Its external setting bits in the GRF are different though, so it needs
its own distinct compatible.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 .../bindings/display/rockchip/rockchip,rk3588-mipi-dsi2.yaml     | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip,rk3588-mipi-dsi2.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip,rk3588-mipi-dsi2.yaml
index 53384e47b507..75cd1c13fa52 100644
--- a/Documentation/devicetree/bindings/display/rockchip/rockchip,rk3588-mipi-dsi2.yaml
+++ b/Documentation/devicetree/bindings/display/rockchip/rockchip,rk3588-mipi-dsi2.yaml
@@ -12,6 +12,7 @@ maintainers:
 properties:
   compatible:
     enum:
+      - rockchip,rk3576-mipi-dsi2
       - rockchip,rk3588-mipi-dsi2
 
   reg:
-- 
2.47.2


