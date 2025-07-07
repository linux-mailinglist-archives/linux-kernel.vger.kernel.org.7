Return-Path: <linux-kernel+bounces-720242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF64AFB908
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 18:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9A057B0908
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 16:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B22B2367B3;
	Mon,  7 Jul 2025 16:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="rblIXFTo"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4E0233D7C;
	Mon,  7 Jul 2025 16:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751906990; cv=none; b=hXc9hKkZ6cjRPHuafodQtGmEpexmppJHvYSAOUkJmzpJvbBNsGAMCPfhurdWv/V/uKAZPEZxc0sE5cvBmXe+ENeOUsq/l1ieJZ2jzXQjnIiRdtWgFeDu1eExB2mLdqSzI7plWndpo2xTvvArDhWnIJIZnGYVIWxncxN8n0khyZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751906990; c=relaxed/simple;
	bh=/3CwDimBmAAFenMGSw7r5KRs4qtqpBFYctyMFe1V+IE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eb7pUBp1H2C2iAUQHneuMhXKuq/sJluYJfo2dV0crS9WK+WFUYTrfYHwsAcnuRZhiCZJuNcjCdrPg8w1P386pSy26PTdf/me/QtWY8hSfcheYggKfAxbbm01ORVaiBw87NbTq3YBf11EckW6ySsJ7UV4qwKWGHqd3IArtrj8zAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=rblIXFTo; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=Sab3PBZsYV+Qg8JG/2ark+p+RM4PexQTwQc3BCtUEOQ=; b=rblIXFToZUEfu3MV05/8H8SEQF
	bYqLZZeXf7U1nmiPSumzkIidH3TEM89H9qDFc5mRLV8/3T0VJn3UPBBk8qmmR0CSZt5lyqQSTpfzY
	EKAshbgRKHRsEIfnvv1DJX9zOoYcXLFVb0F26SuTIcqPJCRSVcQBjsLglVVkI/6wY2ATTGswflbBD
	97lRqb3sCXs2RUXOVeeYKAZ4Ihrw4ESCnJyVLpJC7Cw9kNIKzDHJUBaITGHPJRLqfj/jiGvfaTih4
	sI/AFWak2UsTXo/s7Z3lGt7LYHdH4Su8vcUaBwYclo/GZJqrmn4bRWw4ortlYD9CkWTz1oE4loYy7
	eaqaf+5w==;
Received: from i53875bf5.versanet.de ([83.135.91.245] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uYp1p-0004yl-JE; Mon, 07 Jul 2025 18:49:17 +0200
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
Subject: [PATCH 01/13] drm/panel: ilitek-ili9881c: turn off power-supply when init fails
Date: Mon,  7 Jul 2025 18:48:54 +0200
Message-ID: <20250707164906.1445288-2-heiko@sntech.de>
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

The prepare function turns on the power-supply regulator first, when
preparing the display. But in an error case, just returns the error
code, but does not power off the regulator again, fix that.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
index 28cd7560e5db..d7a17dca2a9c 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
@@ -1292,7 +1292,7 @@ static int ili9881c_prepare(struct drm_panel *panel)
 						      instr->arg.cmd.data);
 
 		if (ret)
-			return ret;
+			goto disable_power;
 	}
 
 	ret = ili9881c_switch_page(ctx, 0);
@@ -1304,18 +1304,22 @@ static int ili9881c_prepare(struct drm_panel *panel)
 					 &ctx->address_mode,
 					 sizeof(ctx->address_mode));
 		if (ret < 0)
-			return ret;
+			goto disable_power;
 	}
 
 	ret = mipi_dsi_dcs_set_tear_on(ctx->dsi, MIPI_DSI_DCS_TEAR_MODE_VBLANK);
 	if (ret)
-		return ret;
+		goto disable_power;
 
 	ret = mipi_dsi_dcs_exit_sleep_mode(ctx->dsi);
 	if (ret)
-		return ret;
+		goto disable_power;
 
 	return 0;
+
+disable_power:
+	regulator_disable(ctx->power);
+	return ret;
 }
 
 static int ili9881c_enable(struct drm_panel *panel)
-- 
2.47.2


