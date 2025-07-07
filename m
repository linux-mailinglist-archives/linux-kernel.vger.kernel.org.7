Return-Path: <linux-kernel+bounces-720248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35AA3AFB911
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 18:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D768B3B4FD2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 16:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF7023F294;
	Mon,  7 Jul 2025 16:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="xFE7ieg1"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35178238C0B;
	Mon,  7 Jul 2025 16:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751906994; cv=none; b=aQyeTE7oGCwLkp2VHVJdn8D4vnBsyBPXuLJ+tXBzYgvgnV1dGTpCIT/7H1jILaXkk8NyphqAhg3xAJJuGNF9lhwRp4NImjIyrtul6iQdAgi7LDHXxDZWFYR8t1BdDzSTlxunbnBnY1aVpzb/7CQGKzgdHnq62UxNvea8mYQpQ2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751906994; c=relaxed/simple;
	bh=52viFAZJ8UYiRXJq5iPPw9TJSPEjTDrml2cgaELVvis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qBJ4yPExUbbumcrncSrP3CD7OHtXsz3F+0C7QL4JALaUpI81rPAczMZcKz3zGYv4qFVlPx+qyWVAj9AF2NvF2WuwprWVTkxKPt6lIKwuWMm+TGR6Menm1Z8Fji9Hz7yMwdUw2q32FuvmsKjNxkDQ6IoWpezB+UyhF9yVG3UtdmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=xFE7ieg1; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=mKluaDJd+46jb4+9m6pp57pzlsEm486O32TbldwJjns=; b=xFE7ieg15stL2Ic38IK9roETXO
	GwgASLdwpgFTXckUhYRuw9ufnTPtZ7/tWfd1j7ncxukdXdaTA20VZAtGBLmOqc0SCcxeCQzomI0bB
	jW2nl6jm+qUWw1wtLx0WS8glwErm6RaRaI2tudhuW+Qfoy6IfV3gHhSuCf/F+h631QSG4O7swzHgw
	4mMRv9GYNYuq089+qDFm2j4943EEMCPHyBW/ki1V4s1rHL3Ji86WwStzzejf+0xjU+p/Vn3aiL6ps
	zTztLIZBPcQ4rJHsQipktHzAnaED4Eg5OstpP81o3aSyipXJjBggMEDrOKtASxG11UpxRSHE66lgy
	2DD449iA==;
Received: from i53875bf5.versanet.de ([83.135.91.245] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uYp1t-0004yl-Tr; Mon, 07 Jul 2025 18:49:21 +0200
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
Subject: [PATCH 07/13] dt-bindings: soc: rockchip: add rk3576 mipi dcphy syscon
Date: Mon,  7 Jul 2025 18:49:00 +0200
Message-ID: <20250707164906.1445288-8-heiko@sntech.de>
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

RK3576 CSI and DSI support requires the GRF for its DC-PHY.
The "general register files" provide additional setting-bits
outside the regular ip-block reg-space.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 Documentation/devicetree/bindings/soc/rockchip/grf.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
index ccdcc889ba8e..d4fda4ee33e4 100644
--- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
+++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
@@ -31,6 +31,7 @@ properties:
               - rockchip,rk3568-usb2phy-grf
               - rockchip,rk3576-bigcore-grf
               - rockchip,rk3576-cci-grf
+              - rockchip,rk3576-dcphy-grf
               - rockchip,rk3576-gpu-grf
               - rockchip,rk3576-hdptxphy-grf
               - rockchip,rk3576-litcore-grf
-- 
2.47.2


