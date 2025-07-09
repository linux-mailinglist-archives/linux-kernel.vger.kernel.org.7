Return-Path: <linux-kernel+bounces-724485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE850AFF37C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 23:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06CAC5C10DD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 21:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0870B24166C;
	Wed,  9 Jul 2025 21:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="QOzwNTGT"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0B723FC41
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 21:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752094920; cv=none; b=Kc5kh5riLUocYyi9x8p8Pb65s0uJynQXbN8MlZYsuQ6s27gon7iszrUHG5DPFfn2CvXyCmylZU1t9hYqPxohRJlQFJkV8Mx6Kc20vH56+v5TRfY3j6w7kGF8ErWjBFuLCeWfHCW45xiqjsj0Ir8styeTYd7G1pOTtYe9BmvmnQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752094920; c=relaxed/simple;
	bh=gj4rXTi5xhvc6UX7OZe6K8Cx8rlffm0qUchexNCC4L0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OeqS7ul6yzp6KwCLns4V2IWceovFGMP8hZxTaOiHkC79qNrEGNgZtyGy7AF31GGh2dHdd4j7LXKepp5vG7wwTsmM43DwufGWL8DfqhzGKdjqjnLVX63mVgcZ/6PaOKNcX8yoSvi5mmbwg9M7CaP/loOdH/gcfBs4P0Bey+jokrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=QOzwNTGT; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1752094917;
	bh=gj4rXTi5xhvc6UX7OZe6K8Cx8rlffm0qUchexNCC4L0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QOzwNTGTx2d2bChm/U3AiN+eDoeE5lerP+YJ8iftJHiIkbrhlx5JMSX4dRwUdrNn9
	 gSXfEW5mZn0lZwng5LeMZN1xuyeyxiI38IEIcveJwqpn6Xgd9WxGVB7ihOTtmuybLj
	 HHaMh1faYqcCSWN+CHlSjjjErh+TS69BXnaFWhhhWDeeRakKEKLH0Dg2Ir7sHteDe4
	 B+FXBnTM6Powebnj3djLCbiLhmeBl0qnKS49HGbKjnGwH7nQcQrYVMybQ2YxA2vH7r
	 UsfHUNBW8VwKnY4mNZpEr6AmHQm2Xtgdsd5YMqCshIZZO5aBsaKL7uOiXb5WirB6S2
	 3dY1syTmRzdAQ==
Received: from localhost (unknown [212.93.144.165])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 3135617E0497;
	Wed,  9 Jul 2025 23:01:57 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Thu, 10 Jul 2025 00:01:17 +0300
Subject: [PATCH v2 6/6] arm64: defconfig: Enable DW HDMI QP CEC support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-rk3588-hdmi-cec-v2-6-f5884be34bc1@collabora.com>
References: <20250710-rk3588-hdmi-cec-v2-0-f5884be34bc1@collabora.com>
In-Reply-To: <20250710-rk3588-hdmi-cec-v2-0-f5884be34bc1@collabora.com>
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

Enable support for the CEC interface of the Synopsys DesignWare HDMI QP
IP block.

This is used by all boards based on RK3588 & RK3576 SoCs.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 739b19302865fe8edc54911213321d6f1278aae4..0363ba916e0ed7e7d9dc1169f447f3726580de18 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -958,6 +958,7 @@ CONFIG_DRM_CDNS_MHDP8546=m
 CONFIG_DRM_IMX8MP_DW_HDMI_BRIDGE=m
 CONFIG_DRM_DW_HDMI_AHB_AUDIO=m
 CONFIG_DRM_DW_HDMI_CEC=m
+CONFIG_DRM_DW_HDMI_QP_CEC=y
 CONFIG_DRM_IMX_DCSS=m
 CONFIG_DRM_V3D=m
 CONFIG_DRM_VC4=m

-- 
2.50.0


