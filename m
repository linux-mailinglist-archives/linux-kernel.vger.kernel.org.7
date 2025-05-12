Return-Path: <linux-kernel+bounces-644151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBDCAB37AF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 14:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC68E460015
	for <lists+linux-kernel@lfdr.de>; Mon, 12 May 2025 12:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFFAF29552C;
	Mon, 12 May 2025 12:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="YXxeFWMq"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFBEE2920A8
	for <linux-kernel@vger.kernel.org>; Mon, 12 May 2025 12:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747054072; cv=none; b=mlmuvhea4zMqqpEklnHhmVdMsi1pFDnRMcvmYEYgvsyuLZIPR2ZlKzJAV53WH2jGRW0F3Vz9e0kaqUlZL8Tslf8YCvcL/38Z7JR/QvKLj0UtH4S2sclbADL172XVlnytJ+IGoaQ0YWbUKVNZ3c7rmzNxja3FLZ+ELkZ9PlZdOQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747054072; c=relaxed/simple;
	bh=CguizQ4yTMFm83+hGjc98jh2INAj50rnlcb59ypO+2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JuHCGIr18WS48FkBDzr3pQTVY/BzrsQ/fwe7An2X67h59OZwDDrmAivV3OYTU15PalNPQK3aENAUFI+Ar+ytVIOyEDh2wlG+tt7T9ti2FyFE5EZM2wDOFPnv14k6kCqnbfUvs89HYlG3vRBhYYWvO5HmoYC0OKNzzLqzopg2u4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=YXxeFWMq; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=ck
	0Oa6Hq1RQ1X+FOIxxUqrsCrvgqpQ03ONEP831KWyU=; b=YXxeFWMqp2G21M7k8n
	d0sl7XHelAhyRhuHaW0wKr/ikCC4CPKZirbQUsAnQ8kfPXyIFc0ezL2D9HsHxtq5
	CdolXmRc83opYm5EFTrTTzE9zvgnZQ3Hu9P5DXL/O5CEBkxdtyYhQ1005lmsN4A5
	4qhhrssf/ZGThy7Ldj2O08kbI=
Received: from ProDesk.. (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgC3chWY7SFoQ+_OAQ--.62400S9;
	Mon, 12 May 2025 20:46:28 +0800 (CST)
From: Andy Yan <andyshrk@163.com>
To: dmitry.baryshkov@oss.qualcomm.com,
	heiko@sntech.de
Cc: jonas@kwiboo.se,
	Laurent.pinchart@ideasonboard.com,
	mripard@kernel.org,
	neil.armstrong@linaro.org,
	hjc@rock-chips.com,
	tzimmermann@suse.de,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH v5 07/10] drm/rockchip: inno_hdmi: switch i2c registration to devm functions
Date: Mon, 12 May 2025 20:46:08 +0800
Message-ID: <20250512124615.2848731-8-andyshrk@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250512124615.2848731-1-andyshrk@163.com>
References: <20250512124615.2848731-1-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgC3chWY7SFoQ+_OAQ--.62400S9
X-Coremail-Antispam: 1Uf129KBjvJXoW7AFWfXryxWw4Utr43Ww47XFb_yoW8ZFyfpr
	W7AF4YgrWxZF4vgr4DZF4kCF1ayay8GayxWFWIgwsakwnxWry5tFyrXryS9a45A3srXanr
	tr4vq345uF1UKaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j3189UUUUU=
X-CM-SenderInfo: 5dqg52xkunqiywtou0bp/1tbiqA1LXmgh6hVM3wABsU

From: Andy Yan <andy.yan@rock-chips.com>

Switch from i2c_add_adapter() to resource managed
devm_i2c_add_adapter(), which will make the cleanup code more simpler.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>

---

Changes in v5:
- Split from PATCH 9/10

 drivers/gpu/drm/rockchip/inno_hdmi.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
index f362803060796..776a2aa74e49c 100644
--- a/drivers/gpu/drm/rockchip/inno_hdmi.c
+++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
@@ -1230,10 +1230,9 @@ static struct i2c_adapter *inno_hdmi_i2c_adapter(struct inno_hdmi *hdmi)
 	strscpy(adap->name, "Inno HDMI", sizeof(adap->name));
 	i2c_set_adapdata(adap, hdmi);
 
-	ret = i2c_add_adapter(adap);
+	ret = devm_i2c_add_adapter(hdmi->dev, adap);
 	if (ret) {
 		dev_warn(hdmi->dev, "cannot add %s I2C adapter\n", adap->name);
-		devm_kfree(hdmi->dev, i2c);
 		return ERR_PTR(ret);
 	}
 
@@ -1316,7 +1315,7 @@ static int inno_hdmi_bind(struct device *dev, struct device *master,
 
 	ret = inno_hdmi_register(drm, hdmi);
 	if (ret)
-		goto err_put_adapter;
+		goto err_disable_clk;
 
 	dev_set_drvdata(dev, hdmi);
 
@@ -1330,8 +1329,6 @@ static int inno_hdmi_bind(struct device *dev, struct device *master,
 err_cleanup_hdmi:
 	hdmi->connector.funcs->destroy(&hdmi->connector);
 	hdmi->encoder.encoder.funcs->destroy(&hdmi->encoder.encoder);
-err_put_adapter:
-	i2c_put_adapter(hdmi->ddc);
 err_disable_clk:
 	clk_disable_unprepare(hdmi->refclk);
 err_disable_pclk:
@@ -1347,7 +1344,6 @@ static void inno_hdmi_unbind(struct device *dev, struct device *master,
 	hdmi->connector.funcs->destroy(&hdmi->connector);
 	hdmi->encoder.encoder.funcs->destroy(&hdmi->encoder.encoder);
 
-	i2c_put_adapter(hdmi->ddc);
 	clk_disable_unprepare(hdmi->refclk);
 	clk_disable_unprepare(hdmi->pclk);
 }
-- 
2.43.0


