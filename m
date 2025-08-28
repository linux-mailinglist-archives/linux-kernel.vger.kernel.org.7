Return-Path: <linux-kernel+bounces-790012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 649B1B39E3F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 15:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A51A87C14D7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 13:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51AA3112C8;
	Thu, 28 Aug 2025 13:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="x8quDUAV"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDAF30F805;
	Thu, 28 Aug 2025 13:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756386677; cv=none; b=mKYoCu63V/msoSKy/UkQzjyXFwfbBc/U5WRLakC5OjMYcHNTDvFmeeJllEtzbzUqviasjIMdfsJ3o4kfh11hGs1lpFoowc5ghRE1BiqY2Leu+c32TqlOsCW0HzJfos0qfIXYUftIPjm5IHlE2Wa8bg5AxYcBoSgVLXXGE0RCIyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756386677; c=relaxed/simple;
	bh=4PYC1qUkrAYcrCwvpR7nTOEmrS9nOfQ6ybhrGkKi5SM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uIVXWkgFHkdgGgIJnp0waBQS3Zr9iGxyG5Q3Sf/WjeVsaIw5gLscExqPTT+3cs47MLq0j9wbMNTz3ljlP8jJPPoFhU8vg3XhYd4ZtD4aR7YWxoBoI19d8Xcqmm44mNSBvTofE9oVBprdKN96bKYMOTP1Pwm99YMd0tupoGz3uFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=x8quDUAV; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
	Subject:Cc:To:From:Reply-To:Content-Type:In-Reply-To:References;
	bh=3tyat0CIDgWc47dqO8BykJDn/dhLK7zoSe+DV7NUmbI=; b=x8quDUAVkQG9AXuFi+lkThBD2o
	pRdCDBPdbBqQkUG5cSwKvDbPpJKk2ymQkhfN7hxCoofs30dn6m9SiK1GwafLhmEinE+iRua6v3Hjx
	bXL3bLR4h8tsO37W2KIaCUE9qE1bAhC3kUXRbNDCvoUm7MJja+TbfOzVbE7948EJ5ZNn5HLUatkWO
	XqdNGnPdk08WoM9MH/mmdzD4YLS1qwJLLljZynmzdGg+pkxKKLORmDgQKxRQiQw5Hv5mzgAKw58uW
	gcEDdGliidHwXpSMx/FmsnEjYMSPSvI4cFLQJC4sZatINPdgye9D/PGo+l7yVnrNhhESQnIHcVZbf
	hog/Ye6Q==;
Received: from [185.205.242.134] (helo=phil..)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1urcPF-0007wG-HJ; Thu, 28 Aug 2025 15:11:09 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] dt-bindings: soc: rockchip: add missing clock reference for rk3576-dcphy syscon
Date: Thu, 28 Aug 2025 15:11:07 +0200
Message-ID: <20250828131107.3531769-1-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The rk3576 mipi dcphy syscon controls a clock, so needs to allow the
clock property. Add the missing entry in the list for it.

Fixes: 0e3f3d7c7ae3 ("dt-bindings: soc: rockchip: add rk3576 mipi dcphy syscon")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202508271156.z3wDB6bX-lkp@intel.com/
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 Documentation/devicetree/bindings/soc/rockchip/grf.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
index 6a94c271a6b1..1d0f35e26311 100644
--- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
+++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
@@ -301,6 +301,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - rockchip,rk3576-dcphy-grf
               - rockchip,rk3576-vo1-grf
               - rockchip,rk3588-vo-grf
               - rockchip,rk3588-vo0-grf
-- 
2.47.2


