Return-Path: <linux-kernel+bounces-744210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3ABB10988
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 13:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA0021C87F30
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 11:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73B62BD5AE;
	Thu, 24 Jul 2025 11:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FdcmFAEe"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816321853;
	Thu, 24 Jul 2025 11:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753357748; cv=none; b=uLCYZqQjOIgArfUXRY2Y2TPwlyzWJIzrOxiN9ulmFtvX7vLOFaW65jd9g2+70/POi2BA7jDEuMvAGsQDFH+DBqjSjm0wSMasPQ+XpPQ3BXZGH82qxmPm4EjpnSJ6dCZk8ghE82RtBt9SrvvZnTg2ACXPr/1kb7DXBC1fXRiGonY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753357748; c=relaxed/simple;
	bh=abOShQ5VlvwVGSJ6AB+sEk1VHjz4dlHs5LJcayZwDfE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PVniIIuXtiGjrtIeTtwTGcHNcNFHgkFm5XclgJNZI0eHmlLONf8y6yajNrfU5HPKzrF9uk5pQljhyfM/hsBgfET4JgAS74o8CzKPheg+qKIK0AU+SiXR4H39oSo0Esx/YoqovaxC/Gwx6aUc9+H7jGV6R4S5U3oq/ovw+eO2/Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FdcmFAEe; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a4fd1ba177so620762f8f.0;
        Thu, 24 Jul 2025 04:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753357745; x=1753962545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=odmYbKO993NxcWEpTO6zguNEI5nHkuOupq9/kpSUARA=;
        b=FdcmFAEeN8QIYUaHpkgz4yJONtPwGdRUmPSjScdGX+jdv8vL3L5zywCVMnJK5PCUBN
         4PSRj6Le6DP88tqgVEzAgxlKwb2ghBe5igQqFxW0Y2pYdKT9xxKK26qG6GvLA9NIAgBI
         hFksDnFsccgxF+3tT343Bpa3dbtXrvEbQAlFIF2nGOcGILgsaC2lpOO7Spu/hOirotWO
         +kEIyqY3ugVnLb+0W2+QhICWumh7b8iTY1zpelq0pytBnLfd+vCrQ6uvx3Fgn+SEdvMG
         F+skN9EG67uoTEdeX8ZtzNnAm2CPc3gcGrIh4fP5E9eyaSz16vKBayAC3kbDFwK0mSav
         i0+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753357745; x=1753962545;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=odmYbKO993NxcWEpTO6zguNEI5nHkuOupq9/kpSUARA=;
        b=AFCb1Sr8hV3zcESIIweakJTwjOZ/BuY8eIYqT4enXUepGpW3kETYsaCGCNFaIaPSMt
         pDzT8gpKE/kyvFqqu710otZfyGrwD5KMpqsd/j8tqW/m2OAoQxZpDMCrBG62nHnJ+WMM
         DsAnYL7mxLIqUdG0F1cwERJPu+6QewSf/j0dqqhOq5qbdqylvrsL51cofWaU/r40szEc
         6P4Fi9/NOajkgpbEEKRynA4XiADHyRqqqb2vNTppLPuxTVsa5xAqRn4CVkh/ibGUXak5
         YQRbyJmeCMjlEmTAohEcBnOTi1aGlyNTFJFcqdI1lEgX2bmvhUqpBj959Yi0GyjMxDHY
         bHRw==
X-Forwarded-Encrypted: i=1; AJvYcCWDBO1h4s/VdLoOtf2k3HHTgW6gX6sNQZS+hw5+QAFGy02sqdfaoJKNGb2lHGkRLQ2/wtNXpoo/IzzYdk8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNBux9Sr1fpmKJkALdxh/wsmjX94E01+Hh0SI0qaEE8a/00oF7
	9PROcTROXCtE/k9JtrcspMI71JDYHgD+odpAzwDHNbsNtGUyHWUpO9s0
X-Gm-Gg: ASbGnctRt/ELMLxU8t4WLqffbEv/Od+EN2KRGEYPehjhjLLXAdRWSn3ysS28997DyXg
	7A7PFnanWoYGe9btmTxtaE0r3blvdeW01PgwjmUAr7t9rstpMv7MpoBaTvAgZ2NoTdy/T6heTgs
	RUDzoU8R65iXxZlX6ys4bbPHNXUxnJSQIs9npyFWG7lh+hM66cJFJZLjPkb+4IKUgq+7MhpAEFN
	QTRimBWvdi9Bw9oNUBqTwU03VhIwW/vdGtEu3GNbN47zhmdX7GQpb4OltpJwc01pml0Yb2NlKfm
	XdREW5NfVZiMESV6uSMpgcqQP9YT5G8KbQLuqDD3uUp/qj4NmxQ1hvWiKAhR+Z3PGqFBqtWHkdZ
	4weCQD+TQLjgc99M/egMj
X-Google-Smtp-Source: AGHT+IEgfaPVKq/DjehMIBnrjBayXpQZKOBR49FXizcPSeI0nOTLp5DVN96/5/+8kz+MV5eS9OEGfg==
X-Received: by 2002:a05:6000:4007:b0:3a4:e238:6496 with SMTP id ffacd0b85a97d-3b771356fa0mr1567580f8f.18.1753357744674;
        Thu, 24 Jul 2025 04:49:04 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b76fc6e5e1sm2002425f8f.28.2025.07.24.04.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 04:49:04 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] regulator: mt6370: Fix spelling mistake in mt6370_regualtor_register
Date: Thu, 24 Jul 2025 12:48:32 +0100
Message-ID: <20250724114832.146718-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The function name mt6370_regualtor_register contains a spelling mistake,
fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/regulator/mt6370-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/mt6370-regulator.c b/drivers/regulator/mt6370-regulator.c
index 27cb32b726e0..c2cea904b0ca 100644
--- a/drivers/regulator/mt6370-regulator.c
+++ b/drivers/regulator/mt6370-regulator.c
@@ -320,7 +320,7 @@ static int mt6370_regulator_irq_register(struct mt6370_priv *priv)
 	return 0;
 }
 
-static int mt6370_regualtor_register(struct mt6370_priv *priv)
+static int mt6370_regulator_register(struct mt6370_priv *priv)
 {
 	struct regulator_dev *rdev;
 	struct regulator_config cfg = {};
@@ -363,7 +363,7 @@ static int mt6370_regulator_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	ret = mt6370_regualtor_register(priv);
+	ret = mt6370_regulator_register(priv);
 	if (ret)
 		return ret;
 
-- 
2.50.0


