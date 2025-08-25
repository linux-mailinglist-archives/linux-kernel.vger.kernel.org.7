Return-Path: <linux-kernel+bounces-784648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0A3B33F0A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 14:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9F34207937
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 12:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB0A2C0F73;
	Mon, 25 Aug 2025 12:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="Oc+BeMLB";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="pIMB0pyT"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDE926FA57;
	Mon, 25 Aug 2025 12:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756123939; cv=none; b=SMN3vYTqV5OH/gxISmIjjOzMgXUPHkMK2fBa0GsFbXnz51fiMwVZ8B3cQHpFG3+BlEECv7e8r4XyuqSEGSBBumvHo+lvKxIx2g8NL9+Lf82Py9VkJFlJUwdOPqc757fc+8ai7ysPKL8u1yxKbZJ0EoURLrg+jyAYt6LkIemGuCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756123939; c=relaxed/simple;
	bh=4U9bVvwz/4NvnHCdp11J+Yuh+x5MC1T9tjtfK8agXDA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rr9zxQYkbaOnE9mtxt/+fC1OOv0UImnSp6jWi4DgMeWe52fhTQhQk0KKBtd1IK+yHbuyLqHN5QIu2NU7oonpB1L3LYZL8fZxM/9o5fiQKJL7xLSr3I5wye48G2aIUWZ6u/q2eiiO8pDhy9IbvXQUUS7mV9pQ29Cwtr89N7pxwP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=Oc+BeMLB; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=pIMB0pyT reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1756123935; x=1787659935;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=X9+y2O9OmxOxX/zEOIoBycF6UqAOtVG8eEXojOig4yI=;
  b=Oc+BeMLBf/UQWJdxGuUX8ZY9amXmC5GUih0HUagEk5wvAon/MXACJDaY
   Tw60d3JCVZD3QHpItYnqisTLCKWbSgddPE+21NBeGl9c0Jgg3qr3h/2UG
   4uMShrWHfTR6sCZhAIfmmEbEdKGt1C6uPtxIzi4sTbe7gsQwnBz1qfAqB
   jyNQVAIzepGoeUouQ4aUMgsemF9xBksvASM7L2DFmcHCKOh9OYW7GcAYx
   5U+GYBIapdnyGOYDN6gGCN3DRQYCqyV7DE4AI9mFWz4PrAfU9BYWCCdVO
   Zs49RTw2g3IGFDW3aAF9EB0omJz+sWm4wpz8GJ7XLLmjfSy2Xc+HQVufl
   Q==;
X-CSE-ConnectionGUID: zg0bytcDSRGhJ3iD8qtdkQ==
X-CSE-MsgGUID: VvlUDMQLR42OVmmbK81Exg==
X-IronPort-AV: E=Sophos;i="6.17,312,1747692000"; 
   d="scan'208";a="45893167"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 25 Aug 2025 14:12:10 +0200
X-CheckPoint: {68AC531A-51-20CAA7DA-EC9DC758}
X-MAIL-CPID: A576D94F7D758DC4C925CA782C60CC17_0
X-Control-Analysis: str=0001.0A00211C.68AC531E.002E,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0369E1637A2;
	Mon, 25 Aug 2025 14:12:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1756123926; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=X9+y2O9OmxOxX/zEOIoBycF6UqAOtVG8eEXojOig4yI=;
	b=pIMB0pyTfFwshsr143kAZ41f239nMkXUqMRUe4chYF1iddy0ODQhW9wmej8XHPlcED7q2N
	hGfaZSIi72fmNUqukxPQAiZLTFkewChZtRCxcCglv2wP7BvaS6l3QcTdWn+O3j54h28otw
	8hBU20ZFVoWV2xx9X1Xwcm6Reqb3Vt79zxVXV2pmd6x4aFwaPe1D/0UW6Vi9Pl49xYK0Sm
	yDKQ7z58GmGLxUIighQdvHrNTQDNSQKOjDDTFSHxboCwq44e7lt7kaOv1ghowH2CV7SoeW
	7XnGnVUvWWugPnQwT2KkFgHkICCuK3KtnauUS4djAszRUPNARSeFAcDG8fMLzg==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Shenghao Ding <shenghao-ding@ti.com>,
	Kevin Lu <kevin-lu@ti.com>,
	Baojun Xu <baojun.xu@ti.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Stein <alexander.stein@ew.tq-group.com>
Subject: [PATCH 1/1] ASoC: tlv320aic32x4: use dev_err_probe() for regulators
Date: Mon, 25 Aug 2025 14:11:38 +0200
Message-ID: <20250825121139.2150099-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>

Avoid error messages like the following when the regulators have not
been probed yet:

    tlv320aic32x4 0-0018: Missing supply 'iov'
    tlv320aic32x4 0-0018: Failed to setup regulators

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 sound/soc/codecs/tlv320aic32x4.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index 7399080f8580c..715a07ab97b9f 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -1277,8 +1277,8 @@ static int aic32x4_setup_regulators(struct device *dev,
 	/* Check if the regulator requirements are fulfilled */
 
 	if (IS_ERR(aic32x4->supply_iov)) {
-		dev_err(dev, "Missing supply 'iov'\n");
-		return PTR_ERR(aic32x4->supply_iov);
+		return dev_err_probe(dev, PTR_ERR(aic32x4->supply_iov),
+				     "Missing supply 'iov'\n");
 	}
 
 	if (IS_ERR(aic32x4->supply_ldo)) {
@@ -1286,12 +1286,12 @@ static int aic32x4_setup_regulators(struct device *dev,
 			return -EPROBE_DEFER;
 
 		if (IS_ERR(aic32x4->supply_dv)) {
-			dev_err(dev, "Missing supply 'dv' or 'ldoin'\n");
-			return PTR_ERR(aic32x4->supply_dv);
+			return dev_err_probe(dev, PTR_ERR(aic32x4->supply_dv),
+					     "Missing supply 'dv' or 'ldoin'\n");
 		}
 		if (IS_ERR(aic32x4->supply_av)) {
-			dev_err(dev, "Missing supply 'av' or 'ldoin'\n");
-			return PTR_ERR(aic32x4->supply_av);
+			return dev_err_probe(dev, PTR_ERR(aic32x4->supply_av),
+					     "Missing supply 'av' or 'ldoin'\n");
 		}
 	} else {
 		if (PTR_ERR(aic32x4->supply_dv) == -EPROBE_DEFER)
@@ -1383,10 +1383,8 @@ int aic32x4_probe(struct device *dev, struct regmap *regmap,
 	}
 
 	ret = aic32x4_setup_regulators(dev, aic32x4);
-	if (ret) {
-		dev_err(dev, "Failed to setup regulators\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to setup regulators\n");
 
 	if (aic32x4->rstn_gpio) {
 		ndelay(10);
-- 
2.43.0


