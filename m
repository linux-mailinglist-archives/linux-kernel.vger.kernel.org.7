Return-Path: <linux-kernel+bounces-891224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56BFBC422E8
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 02:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5981A3B0B7F
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 01:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2E92BE7A7;
	Sat,  8 Nov 2025 01:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qZXk8S6h"
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0646291C1F;
	Sat,  8 Nov 2025 01:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762563905; cv=none; b=o3JrTScH2ZBnbjm7YnGdK2Tw9lsOz7r2SWI9uU4b20p1eaUESEfzVaL0cYBiRXZsOeiyb14voAI3dfEw2ybVFmp+YCnYZKkVQFVhwvWF/wE1o+1sONRgamdXNseENn1d4I8ta9qCYzyW7j8IQCFGL7fQVZn+2yFyBlk7EV2pRd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762563905; c=relaxed/simple;
	bh=XOdseE9/IKpnPqUnYcv0ykIyPxhSwpljBV47AsF8HhU=;
	h=From:Date:Subject:MIME-Version:Message-Id:In-Reply-To:To:Cc:
	 Content-Type:References; b=oBNVZxYrkcWOczpb/+0FHrBq4Lrb8l3vCycbQXBlmUJmErZPLwdzyBEf8rr4X6Y2CNP7ksS0+eFRT8xqJs8/GRYeh8JtpbiAlEW3GPMnPKwdPAM3jy4VyWkneHGlASb3iwX83avv+sGy4k+brVmTpBWkejaZa6lSZ/PGWEu4wkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=qZXk8S6h; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20251108010455euoutp02b3ad76a4dc00463b81a9c4a02d5c628a~14oY0Iyr91808118081euoutp02S;
	Sat,  8 Nov 2025 01:04:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20251108010455euoutp02b3ad76a4dc00463b81a9c4a02d5c628a~14oY0Iyr91808118081euoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1762563895;
	bh=EZpgDuIWQDe3piA1lflo9cUpL7SQdX3ks9uifRxSrkU=;
	h=From:Date:Subject:In-Reply-To:To:Cc:References:From;
	b=qZXk8S6hBPrs2lVMoD49eKaLLxd45mFG9fmOvAFaYicCHiG/CjLxe9p11lL8n8g4T
	 6bVuT2Ogpsot3QoPAnFXkbiueITHfH+lNUywcem9WLjqegqqhIGyYajb4Oy5tmUYGt
	 yv7sT1HFCyEC6nCvyQA14wV3xw7GfwppSCWBUwSQ=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20251108010454eucas1p103697b195125d853bd9f4d40662b681e~14oYeOVC50742807428eucas1p1b;
	Sat,  8 Nov 2025 01:04:54 +0000 (GMT)
Received: from AMDC4942.eu.corp.samsungelectronics.net (unknown
	[106.210.136.40]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20251108010453eusmtip2f17ee4f4ef809e0111d98d420ce81c1d~14oXEeKei0912409124eusmtip2R;
	Sat,  8 Nov 2025 01:04:53 +0000 (GMT)
From: Michal Wilczynski <m.wilczynski@samsung.com>
Date: Sat, 08 Nov 2025 02:04:36 +0100
Subject: [PATCH RFC 02/13] dt-bindings: clock: jh7110: Make power-domain
 optional
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <20251108-jh7110-clean-send-v1-2-06bf43bb76b1@samsung.com>
In-Reply-To: <20251108-jh7110-clean-send-v1-0-06bf43bb76b1@samsung.com>
To: Michal Wilczynski <m.wilczynski@samsung.com>,  Conor Dooley
	<conor@kernel.org>, Rob Herring <robh@kernel.org>,  Krzysztof Kozlowski
	<krzk+dt@kernel.org>,  Emil Renner Berthing <kernel@esmil.dk>,  Hal Feng
	<hal.feng@starfivetech.com>,  Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Conor Dooley <conor+dt@kernel.org>,  Xingyu
	Wu <xingyu.wu@starfivetech.com>, Vinod Koul <vkoul@kernel.org>,  Kishon
	Vijay Abraham I <kishon@kernel.org>,  Andrzej Hajda
	<andrzej.hajda@intel.com>,  Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,  Laurent Pinchart
	<Laurent.pinchart@ideasonboard.com>,  Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,  David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,  Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,  Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,  Lee Jones <lee@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,  Paul Walmsley
	<paul.walmsley@sifive.com>,  Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>,  Alexandre Ghiti <alex@ghiti.fr>,  Marek Szyprowski
	<m.szyprowski@samsung.com>, Icenowy Zheng <uwu@icenowy.me>,  Maud Spierings
	<maudspierings@gocontroll.com>, Andy Yan <andyshrk@163.com>,  Heiko Stuebner
	<heiko@sntech.de>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-phy@lists.infradead.org, 
	dri-devel@lists.freedesktop.org, linux-riscv@lists.infradead.org
X-Mailer: b4 0.15-dev
X-CMS-MailID: 20251108010454eucas1p103697b195125d853bd9f4d40662b681e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20251108010454eucas1p103697b195125d853bd9f4d40662b681e
X-EPHeader: CA
X-CMS-RootMailID: 20251108010454eucas1p103697b195125d853bd9f4d40662b681e
References: <20251108-jh7110-clean-send-v1-0-06bf43bb76b1@samsung.com>
	<CGME20251108010454eucas1p103697b195125d853bd9f4d40662b681e@eucas1p1.samsung.com>

The voutcrg (Video Output Clock Generator) hardware resides within
the PD_VOUT power domain. In the new display subsystem model,
this power domain is managed by the top-level 'vout-subsystem'
parent driver.

Because the parent driver now handles power management, the voutcrg
node in the device tree no longer needs a 'power-domains' property.
This patch updates the voutcrg binding to reflect this by removing
'power-domains' from the list of required properties.

This fixes a dtbs_check warning that would be triggered by the
updated device tree.

Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>
---
 Documentation/devicetree/bindings/clock/starfive,jh7110-voutcrg.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/starfive,jh7110-voutcrg.yaml b/Documentation/devicetree/bindings/clock/starfive,jh7110-voutcrg.yaml
index af77bd8c86b12e667b79ffbaeae5f8a82e6d3f37..deff69037e5072002e06aa5a899f4488b7264f47 100644
--- a/Documentation/devicetree/bindings/clock/starfive,jh7110-voutcrg.yaml
+++ b/Documentation/devicetree/bindings/clock/starfive,jh7110-voutcrg.yaml
@@ -61,7 +61,6 @@ required:
   - resets
   - '#clock-cells'
   - '#reset-cells'
-  - power-domains
 
 additionalProperties: false
 

-- 
2.34.1


