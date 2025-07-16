Return-Path: <linux-kernel+bounces-732973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF8EB06E54
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 08:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E05984A512D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 06:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F1C288C96;
	Wed, 16 Jul 2025 06:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="ioqrhQSl";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="I8V4MZYG"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48C8221FA4;
	Wed, 16 Jul 2025 06:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752649057; cv=none; b=KkVDD9Uc3dZMky67mCx5ZWOlyppGPUyUCLhra4VsuOpw1LW++ugF8Xlk2iczYMyiVKhpyuaS13RhdwAeJRg5O66ioOetGUQr8EE9mgFjftfCyuH0ZpSNXhUGtF5SEFd1yogIP/3unhPg4R2bHR8Vl7wxcA4o5rr0TQY5RjzxygM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752649057; c=relaxed/simple;
	bh=jz7Vn1pCsAI9BX8VZ6UKZS7PUpx3cLwCjt7aXe8fQPw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fh4KWP6uuMvZYSoEynUFk7bEvYP/7Vc6drglhCgfLJwA/s+Spq6YnHml3hLCGh8gHLqPxjaJuNEZpRc5mJ++XGjsjOkEOpP6uih7dW6o21JrlIO3GReV0EzfvXbP/OLaBIvIpk6t4XQVuAFF0mLpv6B83o9/TzVfpml5TJp4uS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=ioqrhQSl; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=I8V4MZYG reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1752649054; x=1784185054;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=A1/Eqm1yng1IpvsXpko7ER/SGIAyeAZDAEM7Mbp7Yf8=;
  b=ioqrhQSliHYlMBwbM5guPvKY1C/AKiaAaAdbJFuxObUfWxp2CgbWUSYE
   w/pnnFMFXAjbUcpjNIAJ5LVawWNa9uIsd/Cnoy2znuuAi73Rj1VbFiQeL
   JesiNeprZ57fx+TRl5UiyKqZud/Eu0GAA1FBy9gF4UBe7e6p7PDXJtRIy
   pDG79TLYN0n4LcmgDz6cxTKc4NfbzcKtcQDKrzy08Lx0JAEUbG28LTn7N
   rMnFDY7FfzZzj5nG8cs1VNot8njtMu80ImyvR1u1hbugwpianmybbITI7
   rF7XcMNz+Aw02tr+A/GeJoluJf7UW2AhysxJBvpYPYbmwNuVMByPDQJrT
   Q==;
X-CSE-ConnectionGUID: ZPRIw4eKT0qhAMS04NULCA==
X-CSE-MsgGUID: P3V5dzO7SLixGUW3IR/j7w==
X-IronPort-AV: E=Sophos;i="6.16,315,1744063200"; 
   d="scan'208";a="45231587"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 16 Jul 2025 08:57:25 +0200
X-CheckPoint: {68774D55-C-D85981A8-D5B36FBD}
X-MAIL-CPID: 58B03FAC3DF6EB8FCDC8EF7E0D1ED6E6_1
X-Control-Analysis: str=0001.0A006376.68774D8F.0002,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 96E8E16AB6D;
	Wed, 16 Jul 2025 08:57:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1752649040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=A1/Eqm1yng1IpvsXpko7ER/SGIAyeAZDAEM7Mbp7Yf8=;
	b=I8V4MZYGjVcXGaVTjpyriAnK5ObE67NkDxfytR/mt6SiBLgiDAjdKJ210zeuDQ6p1tss8T
	Gz9y9EKi8IQO74QFdyb+LYYcqszxvmQVaEXcSbXYD2zb1rpyqMKo2/H07C5olSH82YaBjv
	IuNRtXCFjWT1t+xbA1r6h9eny8M8/SqZBK7Io1EVQ5KQ+eRPvIL4G1te2/+fZevmYFSLRg
	DwDCLvvsS5oLlyjABOIvWIkWEHteOhv3fhDfMM84GkAT89rIEeQzXoiXb8SzReviaJ2qaY
	+YIcXr/BxHCWYKZjlU0+VITyowZkpwdDs7IaG/ANDajjJWzMF3BCmeKqjBUggQ==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Shenghao Ding <shenghao-ding@ti.com>,
	Kevin Lu <kevin-lu@ti.com>,
	Baojun Xu <baojun.xu@ti.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Peng Fan <peng.fan@nxp.com>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] ASoC: codec: tlv320aic32x4: Fix reset GPIO check
Date: Wed, 16 Jul 2025 08:57:07 +0200
Message-ID: <20250716065708.4041153-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

rstn_gpio being a GPIO descriptor the check is wrong (inverted) for
releasing the reset of the codec.

Fixes: 790d5f8ee6f2 ("ASoC: codec: tlv320aic32x4: Convert to GPIO descriptors")
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
AFAICT this bug was introduced on v2 of the series which changed the
validity check

 sound/soc/codecs/tlv320aic32x4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index 3b89980e9bcf2..7399080f8580c 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -1388,7 +1388,7 @@ int aic32x4_probe(struct device *dev, struct regmap *regmap,
 		return ret;
 	}
 
-	if (!aic32x4->rstn_gpio) {
+	if (aic32x4->rstn_gpio) {
 		ndelay(10);
 		/* deassert reset */
 		gpiod_set_value_cansleep(aic32x4->rstn_gpio, 0);
-- 
2.43.0


