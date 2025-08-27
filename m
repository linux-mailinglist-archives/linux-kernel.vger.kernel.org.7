Return-Path: <linux-kernel+bounces-788076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 955A9B37F7B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 12:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A922E1895973
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 10:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D87321F31;
	Wed, 27 Aug 2025 10:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="kp4DUOie"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BCE27700A
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 10:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756289154; cv=none; b=aKt61zqf/2T7hpt5Ba4wuOAsIheaIgEuFiKQwJY6NDQw3F2UuPAmsF38LU3APOEjExTLYnOgQUpv416gg8vS6yNiPx3Zc5GCFA25H4qQ3KPBK6ZlWF7C4MpY6A54RGOuXwmYRZWkxTFwdNeo93C/iKlPlycllyK2ytZqPnWHq1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756289154; c=relaxed/simple;
	bh=92CTkaQy7d7EzkT6gcawHTzk9/zChgZgG/5T9P750ug=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c5rOJesZVvUJtEzVnZPW10+o698UhElm7EGFkJJx8tZvb3MbMcFkmn5Xw20Eu/to3ZCFxxSCuse0w7Yzls+iF0aee3LE4+hbPQYTxAXI4aWrHe1jTPfqkV9eUiUFLPIrXDtShfixmoWV0E75IRU2WC4IC07XzMfOBSQsfBrGFCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=kp4DUOie; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45a1b05fe23so36734895e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 03:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1756289151; x=1756893951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xdwnwu4m2poY+bhx4tDFQHcHU8/2TAEFrTcsGU13aIo=;
        b=kp4DUOieG0RUyZC8iV6q1ggajXIPbHmjttPSv080KyhEk3Vbmz59qZHlvvrZYcNOJ3
         LouUF+bhYidNSu+8+yFjf9Ky5A1zU3r6gvWyA02QFO5yqkLnT+R0FIjRgswY5v1G2o4p
         kLyU1UOUZ+8XEtLz9TNJZWluIf7KEnIUtwG2YfCsfBA5bxMw2L++5arw7ZfmSy3AUOu7
         LBxlsCZCmU38rjQvR+g883e6xZBHFE089S7HyaYGN9V9LJacGb/8NvzlF+qEZ6wAijq0
         6cdqNOPiuvlvrdaM+IN1XsNhKm8s9dozDkdL3bGAjvwdgI0B3QoNVTZdyTydkPOZFYPr
         VI4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756289151; x=1756893951;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xdwnwu4m2poY+bhx4tDFQHcHU8/2TAEFrTcsGU13aIo=;
        b=GDfM0SKPbvp4nieIU0DPRLlS55QyzxBCFLDB0ganS8oD8NG3+WbCBA/zUVINTNzq8o
         +SMYpzw4t+MFLmiKNFgHdwFzev0ooLTkrRT4bz722P5VugUK6VG8aFlNjNUhsMula0XI
         JPiCmDku3eBk9Mdw664TQp4TIXE8SlZGg/DJZEIopzZtDsg39uCYrcMCkcbrLZUxSosS
         JhJJ3y5UaxVQOprcZHmwAbmVTQkNvKaRZimXMgiFOiOnw6FkydKxQRwwPK+h0IRrrnL6
         w4VPh49a4P8SsQ0Uf/dB8djqlOpNPjDZSFByAo2iyKWv9jjIGXF4Y+GCk+IgheVOfXIm
         WECQ==
X-Forwarded-Encrypted: i=1; AJvYcCVv1lj1fYcrJJoCUe9IxuecyPpk5i8sxhpfm2O21Yg1bhTzFR2SL0z87DRDOQmey8L5VFuJxdYs2cJo+hs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbfcmdxciN5TGu27qJvafaqUgbnoRlf4Afs59W9r+mrsdshboi
	zJpcPsMzIP0ZeTa36aDrDAQeliZZpdSli4GtqSVeWDPMCFz6uddsRcC7hC2XkJeSVXU=
X-Gm-Gg: ASbGncuNvSv3HsFNAENRaamu15dcQGdgfzzapKABUomnP4V4LprAG69H3yQ5P+jZt9g
	1l83f5wc/j1R9cM+zqe5naEYGpHOaPu+zyHei7IcOVHawuh6+PpKf6eWhYKfqZlIRIsX38Z3N45
	TjkYuR6haG/oMXXGrLhnT4LMGOoUMA26/T11fiDjEsrJfMSB/KIU+W4ZT/FMGHATF+I9/DM5Zcm
	k8rn9L87Eb3QYEETqINCX9GmYunRe4H9or3w17pe8Mi4dbU7X6RaqfoIwDmK1xX/SIOVpYjW5cX
	WodQpWghsfVsg2Cr86n2fTf6BYkNGLVROsy6BOxUQUIrl/tPnEiJo3iT6kZXK8JBLCdHgK7a8Dv
	KwOG3K7QQ/iEVFR7yTvxWnjORht6lIg88gEZsffJt20npkoxFF/ECqUu3wttMfsWZg9O1J0ucWJ
	RUaSX0DuNk+Jz+r27m/gt7biDrio4=
X-Google-Smtp-Source: AGHT+IEtZ+BXU5M1yHVaebniePLRatXITWo3d6guRg2Xa8Mmbg9iEVO0ljf4M/MaOOS/3BWmeaBxlA==
X-Received: by 2002:a05:600c:35cb:b0:458:affe:a5c1 with SMTP id 5b1f17b1804b1-45b5179f455mr170821875e9.5.1756289150864;
        Wed, 27 Aug 2025 03:05:50 -0700 (PDT)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([2a02:2f04:6103:4200:a5a4:15e6:5b6a:a96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cc7b699d5dsm2818037f8f.48.2025.08.27.03.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 03:05:50 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: gregkh@linuxfoundation.org,
	david.m.ertman@intel.com,
	ira.weiny@intel.com,
	leon@kernel.org,
	rafael@kernel.org,
	dakr@kernel.org,
	ulf.hansson@linaro.org
Cc: claudiu.beznea@tuxon.dev,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH] driver core: auxiliary bus: Drop dev_pm_domain_detach() call
Date: Wed, 27 Aug 2025 13:05:41 +0300
Message-ID: <20250827100541.926350-1-claudiu.beznea.uj@bp.renesas.com>
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
 drivers/base/auxiliary.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/base/auxiliary.c b/drivers/base/auxiliary.c
index 12ffdd843756..f65ba30d0617 100644
--- a/drivers/base/auxiliary.c
+++ b/drivers/base/auxiliary.c
@@ -217,17 +217,14 @@ static int auxiliary_bus_probe(struct device *dev)
 	struct auxiliary_device *auxdev = to_auxiliary_dev(dev);
 	int ret;
 
-	ret = dev_pm_domain_attach(dev, PD_FLAG_ATTACH_POWER_ON);
+	ret = dev_pm_domain_attach(dev, PD_FLAG_ATTACH_POWER_ON |
+					PD_FLAG_DETACH_POWER_OFF);
 	if (ret) {
 		dev_warn(dev, "Failed to attach to PM Domain : %d\n", ret);
 		return ret;
 	}
 
-	ret = auxdrv->probe(auxdev, auxiliary_match_id(auxdrv->id_table, auxdev));
-	if (ret)
-		dev_pm_domain_detach(dev, true);
-
-	return ret;
+	return auxdrv->probe(auxdev, auxiliary_match_id(auxdrv->id_table, auxdev));
 }
 
 static void auxiliary_bus_remove(struct device *dev)
@@ -237,7 +234,6 @@ static void auxiliary_bus_remove(struct device *dev)
 
 	if (auxdrv->remove)
 		auxdrv->remove(auxdev);
-	dev_pm_domain_detach(dev, true);
 }
 
 static void auxiliary_bus_shutdown(struct device *dev)
-- 
2.43.0


