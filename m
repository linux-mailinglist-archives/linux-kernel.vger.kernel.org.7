Return-Path: <linux-kernel+bounces-788086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E73D1B37F8E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 12:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D93017D990
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 10:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0CB8287E;
	Wed, 27 Aug 2025 10:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="AUHUz7qX"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFD4343D75
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 10:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756289569; cv=none; b=NyT20IHxopLXQX0Ae64I5I1xEQYowbGWE9MRmMRdEf05Rdi/D9+9OtbbA4imj+a0nQcRj+ihZB960RJaO7xzu0TjMKhFumVRZN+mzuYicPUE+/Vc5+1gIlmWteOc0VZ/92bXcp3YEa7DLDfDGomo/OPP2Mnk2gVSOyChgmYGKUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756289569; c=relaxed/simple;
	bh=bY5WwNBO5PYBaHej1taD178LBagbsiubDKZnbEwku/s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nJWDL5Is2Dl03yleUZI+XrMF+GK287lNTF2geBknYK1+Mo5npZLFU/W40nKmzQwNnl64c7EW2EQcWOv40vt8N9zl90HlaA5jlkGtjoNrl0gSNiaKhH/qJntunw6CvLLVthhIMHmMcv+kjt1n/0BxFYUQVP6xLo95p12KHQWWCSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=AUHUz7qX; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3c985f13d45so441004f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 03:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1756289565; x=1756894365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zFRtIOMOlVt9quw+Zl7Xq2CuHJgjIAx5v9rbJeyHOIg=;
        b=AUHUz7qX7k3OX0FZaTiedX7VsKw0X5XwyxbfliHkg/LAQ49166TDpNXFSIK7MraP/1
         ECSVtWudeDId513sLEUyzTlyGV2Pn+vFPNaMTLVvaUcZwkDFoB8v17CzYfgik+BP/KNM
         7MyUzt2C/6WutCG6Wg8KiwvNTYJNo7rYmJvFk4A6GGtAvXuh9kdoB6McwNb06+k7ojoi
         niydO3bp+vazgasMMQTvt7GUGRn0HC0lb84cjrq5iwtjkezy7kGy6KT6kTV36lcJzNPN
         cyF5+RBdHGLgOKP432e83Rgqbbg5B8DzJKikMqkz/CXUODWmpwLuOO6AkMaGVctDgbYT
         0MoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756289565; x=1756894365;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zFRtIOMOlVt9quw+Zl7Xq2CuHJgjIAx5v9rbJeyHOIg=;
        b=orcbPuTytVUQZFe2ToGx3zhJK3io9EUo3K0chKsilVVjcndvRoRCZSFVRFc0l4NaxT
         djO2D9iLD6s22yZzRFssBVdraM0ioCLMR5AjtJKXZ2aFELLdCRUiPbEYIOwu5BEb5h7v
         oTHuyHyuLLSpUv/wtPKwBlQ/DAtBhXZtL/tZD8PnfOE6MOPnWc4kjAHM0BM2wXxixFVH
         bEIAAalor4SGCKEwG0Zi13WGWNjyy1MLBdEDQiBjRgteabEkLEqj9h9suCqAzGV9xu2Q
         sAiKNzVpWt8V5V01EAwnRGjHJBTAtjT/fKme6r9WrWlOdSaSKUIr1IhR4Q1CCN2W++Eb
         /dow==
X-Forwarded-Encrypted: i=1; AJvYcCXUFGtq0BnwrlVH2PqdfvH2qfy4xJL3tej3S7i2LQHbT6QnQHghqUWZutS1Mqt2c8nclWVCwMKhEcvSOfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+7XVuxKApEY1R6Qyj8ynms6di53kTNCXSyLWnq+Mmwxr9exIs
	WMcdIqt8K7l4OaYQg/jZACdur65rILJhIbl4BemtfVj4crVHzdOw3mJJ2DnVULEipYU=
X-Gm-Gg: ASbGncs/1QgoW1wDJWGxqhiZyD1U1QZqDAPCxF5YQlyXs56fc7w6rflRIGL220L9arq
	+7peZfe81snN9aRawNGIM1l4fRuVLvR1RxD4mA0EC0nGMCEWEdi/L2H3A8Jam6FybwAzaXAk922
	SOK8rLf3g3+bW04fuyB7JAL3LS1do0KEqHFdBWmQFvQY1/iSNNiT2EjGV8JqAVcV+jqTInbbydV
	p/lajkcAydYqZvlCy7BOxJ79r4fj07Z0y8KfF7oGOEPSpX7Mx4epmZOIi8tma6YpX+/kDywabxg
	I97g/aSjww9qE1lzdo3E++ibaadT0Lqb0R2L1VG7lXoP+6m+bDz2pWYUGn+uJx9JBeBugZ2ZFmP
	CMsVmbXLUdhxTQnQ6hm2YYWNjGb2mWTqm/77UY5CJxdxh6Ry8una2tyfRxnj4ucFM9lVuBbwEuU
	C8yZLH/w==
X-Google-Smtp-Source: AGHT+IFzs67UoFo90c1/HL7nb+kD26OHdiYBdB60ODimSjNKeSnFTxsbkfwxtdbIw0bNW/Jnt6XESg==
X-Received: by 2002:a05:6000:2381:b0:3c2:e033:3994 with SMTP id ffacd0b85a97d-3cbb15cbc3emr3992816f8f.26.1756289564746;
        Wed, 27 Aug 2025 03:12:44 -0700 (PDT)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([2a02:2f04:6103:4200:a5a4:15e6:5b6a:a96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cc890b178bsm2695660f8f.52.2025.08.27.03.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 03:12:44 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: ulf.hansson@linaro.org,
	mathieu.poirier@linaro.org,
	rafael.j.wysocki@intel.com,
	wsa+renesas@sang-engineering.com,
	rafael@kernel.org
Cc: claudiu.beznea@tuxon.dev,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH] mmc: sdio: Drop dev_pm_domain_detach() call
Date: Wed, 27 Aug 2025 13:12:36 +0300
Message-ID: <20250827101236.927313-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Starting with commit f99508074e78 ("PM: domains: Detach on
device_unbind_cleanup()"), there is no longer a need to call
dev_pm_domain_detach() in the bus remove function. The
device_unbind_cleanup() function now handles this to avoid
invoking devres cleanup handlers while the PM domain is
powered off, which could otherwise lead to failures as
described in the above-mentioned commit.

Drop the explicit dev_pm_domain_detach() call and rely instead
on the flags passed to dev_pm_domain_attach() to power off the
domain.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/mmc/core/sdio_bus.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
index 656601754966..10799772494a 100644
--- a/drivers/mmc/core/sdio_bus.c
+++ b/drivers/mmc/core/sdio_bus.c
@@ -200,7 +200,6 @@ static int sdio_bus_probe(struct device *dev)
 	atomic_dec(&func->card->sdio_funcs_probed);
 	if (func->card->host->caps & MMC_CAP_POWER_OFF_CARD)
 		pm_runtime_put_noidle(dev);
-	dev_pm_domain_detach(dev, false);
 	return ret;
 }
 
@@ -231,8 +230,6 @@ static void sdio_bus_remove(struct device *dev)
 	/* Then undo the runtime PM settings in sdio_bus_probe() */
 	if (func->card->host->caps & MMC_CAP_POWER_OFF_CARD)
 		pm_runtime_put_sync(dev);
-
-	dev_pm_domain_detach(dev, false);
 }
 
 static const struct dev_pm_ops sdio_bus_pm_ops = {
-- 
2.43.0


