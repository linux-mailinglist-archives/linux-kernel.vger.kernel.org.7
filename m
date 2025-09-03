Return-Path: <linux-kernel+bounces-799259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97384B42918
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 20:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C15A1671C1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 18:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4EE36999A;
	Wed,  3 Sep 2025 18:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="gf3FK+2V"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9BF36933B
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 18:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756925504; cv=none; b=i9F4cl+TItq60Ss9Hg6R4SlZDw/bfx7o2QDoOZgOWppUc4bFTI2aalDqRZXwmuQr4iD7oUjaCLXIqCQvvy6b92lE1LOlKt0UMLFmczKjoDIU9vwnPK4KKwwO1I1JUtvPLasedTBX+KR0BWRsTAx5qMDEBiV/efkdBcbMvsDJkSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756925504; c=relaxed/simple;
	bh=YnhD0OKVZkq8xMeukg7WRlgfoZMiD/56bfTry9LelCI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OXj2WuB34NSC+ItOsALix+ZpMJYXuWXvaCH2hCHA38/aljHJvA2hUlsNitVnn/secB16quMKkO9byjLogE35ke4R7/+4L9iexBHMfI7zXuRj3TzcUvWCqAA7uLV9Gm41cQczx3iPsDuJAx45JWx1edLd6/Nuvy6G0vfrZIG4thc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=gf3FK+2V; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1756925500;
	bh=YnhD0OKVZkq8xMeukg7WRlgfoZMiD/56bfTry9LelCI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gf3FK+2Vp2Hp/DNu0P6ZOfHVs++FmxovFYxyW6oWa9UFCCzgMB7ACqQmE3PGZxA7p
	 uLMyCvM1YR54mi/f/kp4+bjKwBKybEhg+vnRRNYUqFZDn2S77WDnWWGw489DH4rJ8s
	 Oki4oTP9YJRMogXeJa13bSde7zCqf04L3eAAms07w3OADXWqIrVYqm6Dh8xWTr2WcG
	 nzHkcwbxA4iUuTYyj+xo4ODjrlLoj1GVB1CK2DYmQsY75HB9Mdzhn01e9yHssrMcnX
	 4F/wogylIizz9d1+xG28fZ1015E18mV1w6dm/ExJi21yMV4uiGHUXGVp1INmtMPujX
	 kcUt+qKCRIqdw==
Received: from localhost (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 7F24017E138B;
	Wed,  3 Sep 2025 20:51:40 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Wed, 03 Sep 2025 21:51:04 +0300
Subject: [PATCH v4 6/6] arm64: defconfig: Enable DW HDMI QP CEC support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-rk3588-hdmi-cec-v4-6-fa25163c4b08@collabora.com>
References: <20250903-rk3588-hdmi-cec-v4-0-fa25163c4b08@collabora.com>
In-Reply-To: <20250903-rk3588-hdmi-cec-v4-0-fa25163c4b08@collabora.com>
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
index acb6807d3461384929e84f4c939fcd00c4b509ae..346ef79c1ddd0a317f0b9a8056c680c29a4e0baf 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -966,6 +966,7 @@ CONFIG_DRM_CDNS_MHDP8546=m
 CONFIG_DRM_IMX8MP_DW_HDMI_BRIDGE=m
 CONFIG_DRM_DW_HDMI_AHB_AUDIO=m
 CONFIG_DRM_DW_HDMI_CEC=m
+CONFIG_DRM_DW_HDMI_QP_CEC=y
 CONFIG_DRM_IMX_DCSS=m
 CONFIG_DRM_V3D=m
 CONFIG_DRM_VC4=m

-- 
2.51.0


