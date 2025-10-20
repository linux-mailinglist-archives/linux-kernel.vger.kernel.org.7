Return-Path: <linux-kernel+bounces-860351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22EC4BEFEE3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32A8D189DE18
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 08:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F282ECE91;
	Mon, 20 Oct 2025 08:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="k9it5ZHm"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26EA2EB866;
	Mon, 20 Oct 2025 08:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760948758; cv=none; b=JR9chtq3fBbP/fn0xxu0kju0w18MFUDp9T7x7OmHlodADoWRgIyOs/D6Os8VhDKXhAvDewQPwiewGLyWDZsWh5n0h31YQWFBRemi/j3TjVgws8V4cdD45/cjHDl4vSzHNB/h3VaMUOrafxEuVSGRwcPRE/dkQHe9NOy09HL/RaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760948758; c=relaxed/simple;
	bh=sAgwcNFc2AId1oo1XXYtDpMKpVhBMVzmc5VdQ3ghmVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XA37qOSBPkiSidWXrJ/PWBdEczulK6Jxp36kaAFLb/Drt5mFBmC5VLfB55ckqnGTE9UtFbsQOhNEfRBE49vUjenypC+/C4O5tD+Qyqtdxfgn4YFgnEpIHLO/BaGJHe6yeUjogCLZEJ/cvh7JRQl1OTA3fJj7vVydh6iQCLStttg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=k9it5ZHm; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=supjnpNMV7Z5sSchIbn6T4QPTuHy+8pmLkLub0pKm28=; b=k9it5ZHmjQwVid1an6ahRrTmbB
	tXvMQ06DehkUHQfFj+NpQ8prsIUcj1UdWUBkn4iMq3dvox0qyBVuVCpkMruHeKJrPqqM4nLg6tcxe
	MAexHvCXbT2VZFtq12VlLW4uqaldMiGuIr1/ugPSaimeco4aHh3YE40jXO3PQGwvOG+q9uJccVHFx
	+F46v+YbnD0GqhRMKhLel95ohkc8Ml/AXhTyUSUtsIbPoSmjwrnCImWFbq5hNhA1dGj72dEb/zXnO
	1HsMPiZVsGwcMP+NXQp1TSY3T41RDm60gydq7deZmJNRtQQajw+4D+hjJDEInq0kor4QMm4heKFEo
	toaWAhKA==;
Received: from [141.76.253.240] (helo=phil.eduroam.local)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vAlCy-00078O-30; Mon, 20 Oct 2025 10:25:36 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: heiko@sntech.de
Cc: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	quentin.schulz@cherry.de,
	andy.yan@rock-chips.com,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	cn.liweihao@gmail.com,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH 1/9] dt-bindings: display: rockchip: dw-hdmi: Add compatible for RK3368 HDMI
Date: Mon, 20 Oct 2025 10:25:00 +0200
Message-ID: <20251020082508.3636511-2-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20251020082508.3636511-1-heiko@sntech.de>
References: <20251020082508.3636511-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Heiko Stuebner <heiko.stuebner@cherry.de>

Define a new compatible for RK3368 HDMI.

The RK3368 HDMI also uses a PHY internal in the controller, so works
similar to other controllers, with the exception that the RK3368
only has one VOP, so there is no source selection needed.

Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 .../devicetree/bindings/display/rockchip/rockchip,dw-hdmi.yaml   | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-hdmi.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-hdmi.yaml
index 9d096856a79a..29716764413a 100644
--- a/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-hdmi.yaml
+++ b/Documentation/devicetree/bindings/display/rockchip/rockchip,dw-hdmi.yaml
@@ -23,6 +23,7 @@ properties:
       - rockchip,rk3228-dw-hdmi
       - rockchip,rk3288-dw-hdmi
       - rockchip,rk3328-dw-hdmi
+      - rockchip,rk3368-dw-hdmi
       - rockchip,rk3399-dw-hdmi
       - rockchip,rk3568-dw-hdmi
 
-- 
2.47.2


