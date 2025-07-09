Return-Path: <linux-kernel+bounces-722641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB737AFDD4C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 04:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87FB71BC769E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 02:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6FD81A315C;
	Wed,  9 Jul 2025 02:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="vEBI9Nxx";
	dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b="Ors8ehsB"
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC02E7FD
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 02:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.130.44.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752027300; cv=none; b=oC33VXJddgGLaVtEJn27yKvNqKTRlCofw/rNZgFGvvA5NGgV7U6fhrPk8KFCdRDkodBnHYJsrZEy7ENAz2ot3CR088dPLQhJBdl2R5+Wl566zi2z3ticzr8AEV8Rp3m+FGakDZfk/iLX51xL8WK8LcRA7kicIHTaHYRExPYqzz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752027300; c=relaxed/simple;
	bh=Ei8LGnHLQKmWUzhY56R4dnEm+yzR2we+EK77ciKJ9A0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jKQanUQF3CXU2NOAUYW5dszSyoSBcl5ksV+AEOcqebj1lDECaWYwp+ZHdSuEkkAq3iGsNHkK2Hgnoy7omK4yH2INt0fHlXxPMWzIlSwFa07Rme+mZqek6jQOk7cmpeldTDCefSgTgGbM+taoXRhxg6TL7QQxeorIQrbM8DWt3A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com; spf=pass smtp.mailfrom=richtek.com; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=vEBI9Nxx; dkim=pass (2048-bit key) header.d=richtek.com header.i=@richtek.com header.b=Ors8ehsB; arc=none smtp.client-ip=220.130.44.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=richtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=richtek.com
X-MailGates: (SIP:2,PASS,NONE)(compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1752027296;
	bh=kyiDDBqJ0a4ZYp5mVtSCFXYgn/hQu3322reAZwp/92E=; l=1430;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=vEBI9NxxSRor9w2ZogMjNrW7GBQpgRFYItIaVcjNNZQ/+kUFflk5jMf0oiEjA3kn1
	 zZcILO1QFjro/a6ZB99n48EEweGzEfjIMJThH8VRC84nsaiamWPTR0C6pfPnysZxw/
	 o8JfYTtk3FUXH70YQFnUBUxsM3HXVLPyPOJtFg0hkaie31ZrSG69s0jLSdDD/KbNMP
	 mdRZLqYNW9Xh9Cz2kmN6lla+hs157MK/SGCjioMWgIkDyeShzJZDpVA2U3BrjBZvLk
	 5sYgr/8V8ziKZh209pmxyEKdY1hlj+wSjTeVb/3dm5jbRb4Mn+rfhur0Sy9XoR6xHC
	 1M7EAQyLvNvPw==
Received: from 192.168.8.21
	by mg.richtek.com with MailGates ESMTP Server V3.0(1128077:0:AUTH_RELAY)
	(envelope-from <prvs=12824ECC85=cy_huang@richtek.com>); Wed, 09 Jul 2025 10:14:53 +0800 (CST)
X-MailGates: (compute_score:DELIVER,40,3)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richtek.com;
	s=richtek; t=1752027293;
	bh=kyiDDBqJ0a4ZYp5mVtSCFXYgn/hQu3322reAZwp/92E=; l=1430;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=Ors8ehsBWJB5FVhxcpLobHVbqwGaixEfC67H8LPsfwyBKjlBPHOKPaePXeufXgTzI
	 SZJtbL39eOFVB+7wqLTitNz5L9sRi97WQ3QQr+st5sCI/xclN0sM082N0ROQt79tBH
	 rYC4iaPpGFVMjyczYKHbJlfwu6ohIa04A1ECKMPrQlpNBj6Ic8pFQeiFPiW+eta0MK
	 E0HlG2VljjrNXPQ6HMk6ZFKo3qiCB2vJ7taQbrkKsrF6o4KCQgsVfL4Ye0juxxM+3w
	 nharW0rbGpVH8SZOVnFIRIAjNqUUSZCDLSEhSD3aThhcIdoYzlkjOzh+7duitu/rP7
	 h6MfNfto2+/Qg==
Received: from 192.168.10.47
	by mg.richtek.com with MailGates ESMTPS Server V6.0(244594:0:AUTH_RELAY)
	(envelope-from <cy_huang@richtek.com>)
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256/256); Wed, 09 Jul 2025 10:00:21 +0800 (CST)
Received: from ex3.rt.l (192.168.10.46) by ex4.rt.l (192.168.10.47) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 9 Jul
 2025 10:00:20 +0800
Received: from git-send.richtek.com (192.168.10.154) by ex3.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1544.11 via Frontend
 Transport; Wed, 9 Jul 2025 10:00:20 +0800
From: <cy_huang@richtek.com>
To: Lee Jones <lee@kernel.org>
CC: Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, ChiaEn Wu <chiaen_wu@richtek.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>, ChiYuan Huang
	<cy_huang@richtek.com>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>
Subject: [PATCH] mfd: mt6370: Fix the interrupt naming typo
Date: Wed, 9 Jul 2025 10:00:48 +0800
Message-ID: <a6ab943f4660e39b8112ff58fa97af0507cd89e9.1752026324.git.cy_huang@richtek.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: ChiYuan Huang <cy_huang@richtek.com>

Modify the lowercase character to uppercase.

Fixes: b2adf788e603 ("mfd: mt6370: Add MediaTek MT6370 support")
Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 drivers/mfd/mt6370.c | 2 +-
 drivers/mfd/mt6370.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/mt6370.c b/drivers/mfd/mt6370.c
index c126ccb25d66..c7c2efe3598c 100644
--- a/drivers/mfd/mt6370.c
+++ b/drivers/mfd/mt6370.c
@@ -95,7 +95,7 @@ static const struct regmap_irq mt6370_irqs[] = {
 	REGMAP_IRQ_REG_LINE(MT6370_IRQ_FLED1_SHORT, 8),
 	REGMAP_IRQ_REG_LINE(MT6370_IRQ_FLED2_STRB, 8),
 	REGMAP_IRQ_REG_LINE(MT6370_IRQ_FLED1_STRB, 8),
-	REGMAP_IRQ_REG_LINE(mT6370_IRQ_FLED2_STRB_TO, 8),
+	REGMAP_IRQ_REG_LINE(MT6370_IRQ_FLED2_STRB_TO, 8),
 	REGMAP_IRQ_REG_LINE(MT6370_IRQ_FLED1_STRB_TO, 8),
 	REGMAP_IRQ_REG_LINE(MT6370_IRQ_FLED2_TOR, 8),
 	REGMAP_IRQ_REG_LINE(MT6370_IRQ_FLED1_TOR, 8),
diff --git a/drivers/mfd/mt6370.h b/drivers/mfd/mt6370.h
index 094e59e4af4e..dd9ccc0a53f1 100644
--- a/drivers/mfd/mt6370.h
+++ b/drivers/mfd/mt6370.h
@@ -69,7 +69,7 @@
 #define MT6370_IRQ_FLED1_SHORT		79
 #define MT6370_IRQ_FLED2_STRB		80
 #define MT6370_IRQ_FLED1_STRB		81
-#define mT6370_IRQ_FLED2_STRB_TO	82
+#define MT6370_IRQ_FLED2_STRB_TO	82
 #define MT6370_IRQ_FLED1_STRB_TO	83
 #define MT6370_IRQ_FLED2_TOR		84
 #define MT6370_IRQ_FLED1_TOR		85
-- 
2.34.1


