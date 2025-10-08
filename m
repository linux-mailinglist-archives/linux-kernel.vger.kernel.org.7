Return-Path: <linux-kernel+bounces-845019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 615BDBC34B4
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 06:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6342B19E0688
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 04:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDFFB2BEFF0;
	Wed,  8 Oct 2025 04:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="qMHa/TXN"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D542BE036
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 04:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759897538; cv=none; b=XZ7okkrJ+oH5dK9ZVCvJul8ZMpA/rH8RPs2Fl0jQJ5uNT6TQaDmoiGKVTLUYCjOPvXm8x6S1AHBx6cfvUxHuHH254eHj5mXADz/fEs1JVKrhr+Khm/IKCahAaahrw9BATShTctqurNMxFJcTUQG9Tn6NrKuLivH627KOFEDFhSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759897538; c=relaxed/simple;
	bh=D76b8g5MMMam1XG5CeoG+dRqRhsn10Qo6IX3BhaGdcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ArpBfquaChXaEFJE2NHhATqQ72KBupPlfD940BoXmblimLJwJbyD6FAJFJRjFZ6Cf4WD4qgyWURzNJPueyQdke7iizkCpvnaLO+uKjHe6H17qfeM5vOrpzsBsFlXtIIVgNHvZv/DJ8VF5bHDNUd5gcQDCydrnIljKoXVfuWuAlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=qMHa/TXN; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-afcb7322da8so1458332866b.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 21:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1759897534; x=1760502334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VZ9SuUW1UzNO7L8W8R87ast4mEdS/6k2/bbpjsln1KA=;
        b=qMHa/TXN8ASIciEhpmYTr7YPe+zB/Hi5L70iBuruZMTa2P5FF/EA6JxGS8wRNGk1Fz
         zhtp21naDkOWSgf4bO3TKsV9KD9zy4mQWbkEwRebo8226TzxgFRecu2DrFW35BOkr3Ml
         h/SGbe1aUSLtNsrG0wSc4bvtaFSl5tzy7CC8Bw7sv/1B79JBn3j3EyaBb0xbVsHOBS9R
         JHh9cbVDSUDdDDc2lSi76zWlAtdrnSKwu1L8Zv+isJ8HGm40+5EfFevMM98rEQPbQyNQ
         FVvBKuSpziHjlNl6iWMcviEO3zChVrOTd2+TFVP8F8IHUxI+irLRQVfJUumflkD30Hjg
         elaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759897534; x=1760502334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VZ9SuUW1UzNO7L8W8R87ast4mEdS/6k2/bbpjsln1KA=;
        b=Tm5Bf0+skMPGZqdIG5ctChwiRP2ZOsBI9JGJ5ivEE5Klfy/rQFbL9E/Z+q3Jcd4o3D
         mkEB+LNmgCt9Q2IkaIoqOFbM40v/M5I6JkVYnrzf6ABKCaWivedbt62CPeYa8SfsbFct
         GwYGU8OcqskM6YoznzHXHAWY1jaU4vppYI/p8jGhYZuLI+gn4awUYYwrfK9H//61Kp7D
         /UuhHlARTpjDSdeNu+6fdIkEwH0hvDt8UlrtBR0Yh+x2kHmXHECH9Le7a3/yXvOjJ117
         nZl+LlhNjgXoxQEOV8nDfk/dpylh1fnD8PL/CxG1xizl4C8cQEARr88WN0aUl3oHyN40
         1ilg==
X-Forwarded-Encrypted: i=1; AJvYcCVEqZWcUS/TGyTKwVSEK9WKbRglm3crXhcXI732nYUC68RlOi8vxnhrxncZUl8/vfEC48t65gU8EWngJsM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI8cVg1nzXFhv0pidB4kD4IxkNu56VnJx76/lemTjwT05KiREz
	aUSX0B5096gwx2LdXQ8kg9LGCVpq2a6sL8ESAiiyLR8tuIraggxchHYorGb6DkEJ/yRDXsFvzVQ
	nbxXr
X-Gm-Gg: ASbGncvb12vzTxUHC3u6sG4tSWTYe4sHa0LGzLUmn8Z02bxF+bP7f9a7pj0tAGOanAp
	mgnFjjCDTNMlMU7aXwpkBMDw5EcbYqoXm4NFX6l7+NXBS8qJzAdYx1PvtGTSaenacAng7K6dfTX
	r/MoC0Tcf6kgohdsraB2/G5FhcDFR2oT1W+NxsZvLpZsPdJe3fNCWEfIPElcJuNegQbubpCKLC9
	oOsQJCTYEzq7TnCEr2h9XBRC2F8CKCTLlwALlQZAATEM51jo4rqrCch9f5QiYL88u3FgJOoioNC
	/nQAjkaVovxZSt0R88Q1VizM1yKPkCy3RN/lb5unLgGoiEkk53ckosEdbubEArfM3hlZLQHOhnd
	zojhPvOeiRSkIDvS87YQMQqgxtXbhVQN3crE2T6CWH4exLsrtuqwmDT/kqX/k1JwfZX5cGUXr7u
	0=
X-Google-Smtp-Source: AGHT+IEZSlz/EKrFkQ8tGzGGZjHV3u81jhu2PpcsjCGbnFA9tn7eJ3yvjQACOpvp1GYcqUvP3wSQMQ==
X-Received: by 2002:a17:907:2d8a:b0:b09:2331:f14d with SMTP id a640c23a62f3a-b50acb0e556mr182268866b.64.1759897534049;
        Tue, 07 Oct 2025 21:25:34 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.59])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4865e77427sm1583124466b.36.2025.10.07.21.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 21:25:33 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: wsa+renesas@sang-engineering.com,
	ulf.hansson@linaro.org,
	p.zabel@pengutronix.de
Cc: claudiu.beznea@tuxon.dev,
	linux-mmc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 1/3] mmc: renesas_sdhi: Deassert the reset signal on probe
Date: Wed,  8 Oct 2025 07:25:23 +0300
Message-ID: <20251008042526.3312597-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251008042526.3312597-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251008042526.3312597-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Deassert the reset signal of the SDHI controller during probe to avoid
relying on the previous bootloaders. Without deasserting the reset signal,
the SDHI controller will not function.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/mmc/host/renesas_sdhi_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index f56fa2cd208d..c4aaf534868c 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -1103,7 +1103,7 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 	if (IS_ERR(priv->clk_cd))
 		return dev_err_probe(&pdev->dev, PTR_ERR(priv->clk_cd), "cannot get cd clock");
 
-	priv->rstc = devm_reset_control_get_optional_exclusive(&pdev->dev, NULL);
+	priv->rstc = devm_reset_control_get_optional_exclusive_deasserted(&pdev->dev, NULL);
 	if (IS_ERR(priv->rstc))
 		return PTR_ERR(priv->rstc);
 
-- 
2.43.0


