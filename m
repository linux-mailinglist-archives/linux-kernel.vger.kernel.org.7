Return-Path: <linux-kernel+bounces-797310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2936AB40EB1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 22:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 671525E7A4C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 20:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153243570AE;
	Tue,  2 Sep 2025 20:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="dGH16vcU"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F3E2E8892
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 20:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756845898; cv=none; b=rHDgHKlVF2C7k1aHz6yXVdA8OdNTtnAm/b/wn5L2xGNhnZOAXnnG24vw+/FklzVMg2Tf2hY5aTt4E5lqO04/wH+422Y92ILaeCN4PmK7t6m7hQUiiBAF/XC74fL7r34luq3xwxGk1u0RRyVS/1LKFcem87V5qld0k9Bpn7Ff0gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756845898; c=relaxed/simple;
	bh=fIVDagT/zvHJ/25XzWd6tRmN6zW80gwREUlw0C5elnQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G1/gz5ZvnB1tFoVDbkhFeHHwdsqtSaPPPBFXQUMIBf6KmXvEarqjSuLPDVGkNQPfVvPAFLIS95M0Els6qmeCdclHyTdDOQXSuLM8MIddKRG5o0QaqlGQ+O2VE3IBUgipEqL7FnJ956iJtlf45E6hA8QEp4EYAQMKiVx9hTpEZ18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=dGH16vcU; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1756845894;
	bh=fIVDagT/zvHJ/25XzWd6tRmN6zW80gwREUlw0C5elnQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dGH16vcUJKri3ZnuQqWJwg2yVJr+z1vpCDhnHxSB7SGsYcHbzXuKrFm+rtBxtlgFy
	 0fbwVvtfl1HiNF6NgxTmIYVlEKRdgJHEL1i/SIEIvTrG6k0xtZuMc+OUjuBNPbQCqU
	 gBr1tbLQesVCeIWYsw4CVfJCfTTveWcDHs7b43udFwrxlzmU29CGxXX/UwiPIA4FLc
	 7i3MrmkybMHnJZqk9o4OGe/GbekAyfuDuuRQpYQaTpWxoYERyVENgvvtZ+4jEWdtI8
	 +K3LSCF2REAyhXnMEOVsvYlVJZ7wgzeQfRYhY953jUMIsjNMKpkt/xGyGnoeU6EBy+
	 IgYrJUraqkQGQ==
Received: from localhost (unknown [82.79.138.60])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 03DE717E129F;
	Tue,  2 Sep 2025 22:44:53 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 02 Sep 2025 23:44:37 +0300
Subject: [PATCH v4 02/11] phy: rockchip: samsung-hdptx: Use usleep_range()
 instead of udelay()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-phy-hdptx-frl-v4-2-7d69176373ce@collabora.com>
References: <20250902-phy-hdptx-frl-v4-0-7d69176373ce@collabora.com>
In-Reply-To: <20250902-phy-hdptx-frl-v4-0-7d69176373ce@collabora.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, Algea Cao <algea.cao@rock-chips.com>, 
 Dmitry Baryshkov <lumag@kernel.org>
Cc: kernel@collabora.com, linux-phy@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org
X-Mailer: b4 0.14.2

rk_hdptx_dp_reset() is allowed to sleep, hence replace the busy waiting
with usleep_range(), to allow other threads to run.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
index 29de2f7bdae8a31958e31b0a64281532fd76e64d..b7af27eac293c46647c3abbcb7128939d4ee012d 100644
--- a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
+++ b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
@@ -1074,7 +1074,7 @@ static void rk_hdptx_dp_reset(struct rk_hdptx_phy *hdptx)
 	reset_control_assert(hdptx->rsts[RST_INIT].rstc);
 
 	reset_control_assert(hdptx->rsts[RST_APB].rstc);
-	udelay(10);
+	usleep_range(10, 15);
 	reset_control_deassert(hdptx->rsts[RST_APB].rstc);
 
 	regmap_update_bits(hdptx->regmap, LANE_REG(0301),

-- 
2.51.0


