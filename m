Return-Path: <linux-kernel+bounces-720240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C526AFB904
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 18:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B61A4242C9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 16:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F57D22CBD3;
	Mon,  7 Jul 2025 16:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="yWuK4Eyl"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F418233736;
	Mon,  7 Jul 2025 16:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751906989; cv=none; b=RewTBElBmkx51qFg/pF18G9ZVV5VXj5c23HGhxdOnIeppjL2NbS+WWo4ghceMdDxNHAkTz9nUg+afdSDKXodafX5pvwWTGGwFsplp7DKp/v1d0ufS/wf3jceEMhXSn+I6VKLEvu2QpW7uvttV+5IzAUEqAtKuEAQkACBpKG20t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751906989; c=relaxed/simple;
	bh=4S0LeobjDGyc9lgYqGWhAm3UdJgbs2RY9qdSzCyZ6nw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oWeDHOppuAjme9k38qRLkBFHuAqL4wnAySQKDryB5cKCh6rTsrHOQFPGlBTS1ra0Nu7UqOzXDY1Fjox7mFo2/e3/XZLMpX8vxef4Sw6+igYEgXOLzX4UQwYSHpnT1vnfHqY4VNzxwzKyCF/+4ESIywUI2dU8sJGjzEF1MhfiUeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=yWuK4Eyl; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=z3oo4jp/mWDXJM4loc/Z9mF5O/3QC0Xa5p4jSoWlt2w=; b=yWuK4Eyl5vZRgqKAYAhhf5a2V2
	YlX0Lw/Wa+sVwk/B4wvKfqvE8w+bOUD34xSSmYZuyU8sOqi5nRT+hINz0n1t8yzFGR0MqP3z/7HNu
	e9R8o3Fno1t8YK6atx1BeLyYAX60Dd/5oLfDwuPATN7z2bXqHI/sfs3ayd+uhPiMDWII9ySdIOhi9
	9o1yw4343jaz2Ww6Ls3Adlbn42d3HnYgofQc2mCB6VB6xa0c8BPEi6+FbvIjGiw+COVFiEv9n1Str
	iFMwmDlj5hlBO57U8/27o98u3pFzWrl0vamF83rE9yPF0ItjoFVCAC/qPyuJV1I8D5jzWxKEhsW2/
	So/tIGJw==;
Received: from i53875bf5.versanet.de ([83.135.91.245] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uYp1s-0004yl-Ea; Mon, 07 Jul 2025 18:49:20 +0200
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
Subject: [PATCH 05/13] dt-bindings: display: ili9881c: Add Bestar BSD1218-A101KL68 LCD panel
Date: Mon,  7 Jul 2025 18:48:58 +0200
Message-ID: <20250707164906.1445288-6-heiko@sntech.de>
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

Document the compatible value for Bestar BSD1218-A101KL68 LCD panels
that are based around the ili9881c controller.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 .../devicetree/bindings/display/panel/ilitek,ili9881c.yaml       | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml b/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml
index baf5dfe5f5eb..79064f9dde23 100644
--- a/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml
+++ b/Documentation/devicetree/bindings/display/panel/ilitek,ili9881c.yaml
@@ -18,6 +18,7 @@ properties:
       - enum:
           - ampire,am8001280g
           - bananapi,lhr050h41
+          - bestar,bsd1218-a101kl68
           - feixin,k101-im2byl02
           - startek,kd050hdfia020
           - tdo,tl050hdv35
-- 
2.47.2


