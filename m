Return-Path: <linux-kernel+bounces-860352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69034BEFEE4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 10:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9BC018818C1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 08:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468A22ED159;
	Mon, 20 Oct 2025 08:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="rDUON071"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD0A2EBB83;
	Mon, 20 Oct 2025 08:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760948758; cv=none; b=AZreA4gqVF29hfeqZdd+o6I4BDfF7H1zwK1kQAprNBQfrFEfIqo3VtVr7/Lt1a7Uh4sWZ5oN/cY+S0T8o0Pz6+fkiUa/hN6it3vytSeQz+l/ZqNod0I3KalVux4lS7W5UsclLTwSuQu2tsVo836CLyv1vy+Xo9R5YLriyK82ZqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760948758; c=relaxed/simple;
	bh=/gxeUA1jdaPgPonhUNQ/hUeXtjlt6Y5g/z3ex2qsPcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gghxPqGv8JwleLBcEeP2TQrI7HNDx0r1SM1huWNSDYlySPlswVNaOpsxLm8AGXyjNyt8bSGEDArEdyrrY2jjHc7Q7R1obUuPAgIqjqvCMCM2wUAcml1PYU/VACEJUbqqbruw65pjy4C/4qT2QeM1DjmEHZOI4f6dpQkI7aTdY64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=rDUON071; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type;
	bh=CSwYSi0Xsz6tuPWeN+n3HczJ/oB9p6CTq0FVpTz/uaI=; b=rDUON071VRbe/08gmHCk5RdYAL
	xRLUZXgv4qI3q0MXbZaqLw0BDKEq35NvtlrTQPtKZIOhDFr2tsQ4DGIoPim3KWPIy2n/2QUJkblGA
	ZwYWKGFjcpTIt0gk4TAXd7vmPxOGdztVOH+5fxFjl8RS8oRrEOLMEBjLlbtloxGotqXlevqEQUzKI
	mM3Hnn4lCdtV5iDEaJEcixDmmeCHOJXZeHN6RZXUH/s5VKOa+NtoTE5JrNhZ2yd4i6maSYYVK7H6Q
	Bg/wiwNNONUN1IB74uWCGHV1Xo/N8QPvbVST/IGKwqJCQpO9w9eUcw01sML9idmV4brpV9KxG8VBg
	tpGXMCyQ==;
Received: from [141.76.253.240] (helo=phil.eduroam.local)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vAlCy-00078O-U0; Mon, 20 Oct 2025 10:25:36 +0200
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
Subject: [PATCH 3/9] soc: rockchip: grf: Add select correct PWM implementation on RK3368
Date: Mon, 20 Oct 2025 10:25:02 +0200
Message-ID: <20251020082508.3636511-4-heiko@sntech.de>
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

Similar to the RK3288, the RK3368 has two different implementations of
the PWM block inside the soc - the newer one that we have a driver for
and that is used on every soc and a previous variant that was likely
left as a fallback if the new one creates problems.

The devicetree already is set up for the new variant, so make sure
we actually use it - similar to the RK3288.

Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
 drivers/soc/rockchip/grf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/rockchip/grf.c b/drivers/soc/rockchip/grf.c
index 344870da7675..963cdea01ce7 100644
--- a/drivers/soc/rockchip/grf.c
+++ b/drivers/soc/rockchip/grf.c
@@ -91,6 +91,7 @@ static const struct rockchip_grf_info rk3328_grf __initconst = {
 
 static const struct rockchip_grf_value rk3368_defaults[] __initconst = {
 	{ "jtag switching", RK3368_GRF_SOC_CON15, FIELD_PREP_WM16_CONST(BIT(13), 0) },
+	{ "pwm select", RK3368_GRF_SOC_CON15, FIELD_PREP_WM16_CONST(BIT(12), 1) },
 };
 
 static const struct rockchip_grf_info rk3368_grf __initconst = {
-- 
2.47.2


