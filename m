Return-Path: <linux-kernel+bounces-742499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2694DB0F270
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 14:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF6325811F8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 12:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C592E6D09;
	Wed, 23 Jul 2025 12:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hammernet-be.20230601.gappssmtp.com header.i=@hammernet-be.20230601.gappssmtp.com header.b="adq+sBzs"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316872E6D00
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 12:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753274552; cv=none; b=qldtszcwZH+SGWUCzaqwOsouKWzbplCuC1SazbcLGyBxYY48+uqJN76InXTElKUPPgdg1jophOFGjxY/MAgMc16KTHsuNsFVXnfkNa5fzFdqqYvH3hQVxIdSR15Kn51qoA0SRxoOvIIjeySdobSs/x+uHjwmkSs5Nek2p4MtCFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753274552; c=relaxed/simple;
	bh=Dd6wnE/Sf3IOuD9VVTmszqaQpg6KTb350GWEM4m2a0A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sCuzsBQHFt96jPZfyYbaZFnVWigAoMC2Vt6FxAYVLO8FHVB1iUZGebuibzC72yHJC38O5c5UWnk+AVw4XuTBxOLSKVCQvYq8HndgxzIzcNpSikXIPoiMMF/qgujb1grXIcRx3zSgx2QqcPBcIGdrZd1cllciAUOCEvvFicTR8rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hammernet.be; spf=fail smtp.mailfrom=hammernet.be; dkim=pass (2048-bit key) header.d=hammernet-be.20230601.gappssmtp.com header.i=@hammernet-be.20230601.gappssmtp.com header.b=adq+sBzs; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hammernet.be
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hammernet.be
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-451d41e1ad1so47085155e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 05:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammernet-be.20230601.gappssmtp.com; s=20230601; t=1753274547; x=1753879347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4veeSt022yF8JfTtf9KGz2ZcsYPnUB3umlBs+pcOABk=;
        b=adq+sBzsX2QMywd2bDEaVXm1r0u4x+qCXUMjvE7wU9fO0SmwY9nXrdJKQHAgbvp2Vm
         spgcdjfy54+DCr/BVX4+CEkqimnviRyW18bvHRvLi/b2fxxkOcJiED1Kb3VuaIyeGqxF
         B6xT2IN8NeZRQkkT5iXSzHMQz0PVrF83v6xuohNOrAad8LGzxJqCAEqwWsyv3ysKYPEw
         xCf4jnGJ7Y6izwbH2jxGgN8PFArT6OqGyIZPNdd0vdvBjYPUJySr9VFLP1lW3V70rOCV
         GJcNzRf/gKGVK7Py6mVVDsbQcYaBNxT0gLdKR9LqU16lfpcL9pwCUsC+qBGAGuO2stuN
         ZmlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753274547; x=1753879347;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4veeSt022yF8JfTtf9KGz2ZcsYPnUB3umlBs+pcOABk=;
        b=edZ5QaHr5wELv12VRvDSqez1gr+J8WyvjzMZZtbdMOVLevZwIlNYIAByJgAiQz7oK8
         u4hh5ZPHSar91aFe3+GuS2yNSmqEu8bRd0lcSsLfN3Tw6Pu8DIWYGrtFLRLHXczrQIPs
         IqfTUveW3oxeyBmlO7GuVwWWBFLboXXY2oVHapAjUpKt3gPlJlObYMbnvTz7cG3bSZ9h
         EDJUZKaMasw3jv+N9JwcilzOD8/09kblnztq13C7TvXydShZ0VZIRp0WnyoEAPYIXc8a
         QDFVLm+HT1LfA5c1aIgzsJ5Opd9ewT9xSoeGRwV6Ym+jmiEd3JYnzdoGQcVoSG4RgGht
         DQmw==
X-Forwarded-Encrypted: i=1; AJvYcCXCTV59ubI6mdBSf41hUbLA4rCB4c6Ef2K/pUBxq6SXwshD35dSBbN4Kd3L7fdqICiu0nosR/eJiuBCmlI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+ueadgjGDUm6GTYxYQqhPzMduo1Rfg4MEBqmAZxOrOPDDiRdg
	SCGVwCtAVGQq6lnJMERb7c+XgbccJjbw1/HywEJd+A9sPdi5yWUVChxSSeYOXQiuBUR6Q69saCm
	otvjr5H7q/w==
X-Gm-Gg: ASbGncuLTVUXLg/xGDQ4qtDISJCjGsK32C+bf9bMZ1yzWn1c0GSX1C3ERQXY3MYoTXJ
	awkzhNE/wrHZudTOhD3QjFTsZr2FIYEXMT1ezrm505igtdENzL2SPrto4XQ9yKdrzBHB0hA5ejQ
	bZIB6Nj4MLjddisZhnyVBEZpFMN2f3poOABj2LeE/+AZcSfpLezA2MYZyYN0bCqhIrIhoD7YJ+K
	zBSovi+co9TZfGa/DOdP6ZFCWIEIhCJG4BvP3xjcEC2ZlJ1zFeUJs7thxfcnvSmWqyx0d1SavTI
	ACSdXGloLjKQho2aIyoF8KuQrJYgcKxuakaBjViUq8vVqCtSWky1+zeawtgCYUum89QQq9//NGj
	1kF74TPU7VQz/95q9NUsd3GtcJ0OwvOipXGK10QLJJwGpQnGOeg==
X-Google-Smtp-Source: AGHT+IGbJ4sHUsE4vetWaUrzV0GCHvxK9m7lFsG6KCeg9nkDSwfu/KGJ+XeTwbxg+UQe31rImyB2lg==
X-Received: by 2002:a05:600c:4e47:b0:456:1560:7c5f with SMTP id 5b1f17b1804b1-45868c9d3c0mr26871425e9.14.1753274547109;
        Wed, 23 Jul 2025 05:42:27 -0700 (PDT)
Received: from pop-os.telenet.be ([2a02:1807:2a00:3400:7fcb:5e01:8f11:1009])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458693ab0besm22035165e9.36.2025.07.23.05.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 05:42:26 -0700 (PDT)
From: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
To: sboyd@kernel.org,
	dlan@gentoo.org
Cc: skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-clk@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
Subject: [PATCH] clk: spacemit: fix resource leak in spacemit_ccu_reset_register
Date: Wed, 23 Jul 2025 14:40:20 +0200
Message-ID: <20250723124020.60897-1-hendrik.hamerlinck@hammernet.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function spacemit_ccu_reset_register() allocates memory for an
auxiliary device. If auxiliary_device_add() fails, it skips cleanup of
these resources, resulting in leaks.

Fix this by using the appropriate error handling path.

Signed-off-by: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
Fixes: 988543522ebd ("clk: spacemit: set up reset auxiliary devices")
---
 drivers/clk/spacemit/ccu-k1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/spacemit/ccu-k1.c b/drivers/clk/spacemit/ccu-k1.c
index 65e6de030717..5bb85e32c6cf 100644
--- a/drivers/clk/spacemit/ccu-k1.c
+++ b/drivers/clk/spacemit/ccu-k1.c
@@ -1059,7 +1059,7 @@ static int spacemit_ccu_reset_register(struct device *dev,
 	ret = auxiliary_device_add(adev);
 	if (ret) {
 		auxiliary_device_uninit(adev);
-		return ret;
+		goto err_free_aux_id;
 	}
 
 	return devm_add_action_or_reset(dev, spacemit_adev_unregister, adev);
-- 
2.43.0


