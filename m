Return-Path: <linux-kernel+bounces-862331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3D4BF5056
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 09:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 283794F1477
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 07:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DEDC2848A2;
	Tue, 21 Oct 2025 07:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="zzlF/GQw"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB5B22579E;
	Tue, 21 Oct 2025 07:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761032611; cv=none; b=j9J7TwVuBKlFi2nRrlTJNqsiBM5iM3Rhj1+3tFDk7aDxET8YwZkiddLiJ5FTaAwSyqPvXYJU83p+BCOK+A1WJw8ipeeCoHmZa6GeeLjykCeiI07kftisWBG/5AeNwfNPkVmAaJB1ovlb19xuggmR1VbcFKhEXzxvFfdgbEyx7pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761032611; c=relaxed/simple;
	bh=g9ZHrtgCu19pxECRrEzDTMEJRWQ2BNx9AdxH6gqHpF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jcvejEpqfJMA+xH85WhWpsPFFXGFBAy0lGlbF4QDgz37TY/+tLUKoty2v2RtDCV3qg2Z3nAOk+YpJxDOjqeD2gX+Vxt6STVvr84oVKblOGRDd8EuKrG+MynFTKCSGNzNhiuq9f7PggfZWLnLx9IlHNjwVCLyyGnfjEnyEFVA2kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=zzlF/GQw; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=AP5GZTY+6u3putkH9wiit+MCCXjcLlm9TffEsIJtyyg=; b=zzlF/GQwOQQvsH29acgbHn7dAx
	ACbGisNDNz3tl3h2hrkFyVvLWA7oGx+H+Mjp9DE5lsHALp/RE3JLcsKaUW0c41i9v1/4crFVVedG2
	AlMSHCTLWmg0ZUJiaGLcwNPRcaW+pIXnCMdDKCKMjz0bNglzD62Dy9PAE9AYVWanGk4uF3AsL08f9
	MCkKHHAX6WVwftxB2eModVhyUOeW9OlIqjeUIJljygAa8bS7J7I4H4CN8alGbp8VIRwOlTCk95b97
	GzbLFTjxfpAMAwe3p1gEhed5lRb6+VwZJGuv+dES2UvxABVI9HXUFrUFAevlrxM54coSPlW7qmrR/
	AecrvQkg==;
Received: from [212.111.240.218] (helo=phil.guestnet.ukdd.de)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vB71M-0000uy-Mp; Tue, 21 Oct 2025 09:43:04 +0200
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
	Heiko Stuebner <heiko.stuebner@cherry.de>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 1/9] dt-bindings: display: rockchip: dw-hdmi: Add compatible for RK3368 HDMI
Date: Tue, 21 Oct 2025 09:42:46 +0200
Message-ID: <20251021074254.87065-2-heiko@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20251021074254.87065-1-heiko@sntech.de>
References: <20251021074254.87065-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Heiko Stuebner <heiko.stuebner@cherry.de>

Define a new compatible for RK3368 HDMI.

The RK3368 HDMI also uses a PHY internal to the controller, so works
similar to other controllers, with the exception that the RK3368
only has one VOP, so there is no source selection needed.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
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


