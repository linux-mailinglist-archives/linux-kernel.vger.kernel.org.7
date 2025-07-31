Return-Path: <linux-kernel+bounces-751559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3B1B16AE1
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 05:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FE683A4694
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 03:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632BC238C21;
	Thu, 31 Jul 2025 03:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fAov2Gq3"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C0C2E3714
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 03:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753932708; cv=none; b=YYIGuNpbyKSDLOjLfObpsIf+TgxgoBWUDZiecEP2ZeEboVElgfB66CdxEFShiT1/OpmWT49ftfg0HQbarOG3SVbhMBCteD0Fbj6x5xKlYAA74u+8hH8cN7RzAaAgjSJ6yifr6XEmtRuyGC+olpdcELgK3RFuIOmpeQ2T9n61y4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753932708; c=relaxed/simple;
	bh=1nfJG4yTPOri3CSekW6ZJJDtBbYVtJ/3pOTS3syj5Hk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TiwFeCb+lFufEGY/a8Lm7bOW54ajBZs82wl+jPA/KkUcf8j8b1csJiW07mGcWAJ8J2r+PU0loNsXNLhd+XhC2XLPgf3VVk2re4VLjiJge+/0G859fLFtE2w0HyP+46EvAuAUVPR3I2CKrVimH3XZDWDnKXH9M5xndgvlETNatIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fAov2Gq3; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2403ceef461so5046625ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 20:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753932706; x=1754537506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zc88pDALxLD2kIIkVNiEOFUmS5xqiuHdZeb5OdPQjv8=;
        b=fAov2Gq3MzFer9ZtfHn7hfuuLBJbMIT/MefWbcQR5jW0behdsiybQVw591GmPeuqyb
         MXx+4ZRHFwBGFU7fxyg4JAH/tya1lhTJqP1R1M2M/P//fRqzjmkaHan4TCHbMz66XYm0
         xI9EljWZjOXJmxn46CeiXzcibq1ROC8BZzYGuY3/vYJ/gwo62LUtduQie9QbLbUg+RFq
         OfKn6D0lj4GkW6b6gqc63SaPZStGvNR83vVviaQYWTyVSefACWsPfbPJw7xtEe1t7EUs
         3pygGPpI1noQC4Kqj7Be8NrVQcf5Y4h2Xh+ZKf+XzN3rpZSUxnQQ21wrtXSKS6qYrhJb
         ax3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753932706; x=1754537506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zc88pDALxLD2kIIkVNiEOFUmS5xqiuHdZeb5OdPQjv8=;
        b=OlwofQrVv0QR45hYB+f7vzGATpVC/LTcAWeJA8mQcoleBuC+Z72kXtg8AJ/sGKB+4k
         cXoNBoLKMEAmWg54YZ+k0bkpmZgLqtu3jLxJ40fkzlXhLUBNbk5sjw8MagR0IdD37FHw
         lKvPyZHM46vnnnzYdzFzsk2k9UM2CJjotzcwyfg4njuvDUHpJT1rcW8VTJPQNWGCUexS
         4kNO4RkGpXZscuiGpnicVk6lT/fW7h8dePwBmpZNF+6KlHMu66vpLxPdkrw6gTQMwcmb
         8A5RUM3fA61KKXgUfakBfEkJcK4TR0rw+c8SAvzb6k3OhvU6sJYTrWLHjKl6oPImr5Zw
         waow==
X-Gm-Message-State: AOJu0YxXygvWfcl4ur/SQfxQQJki0hxJWwVQQWzmL0n2GXgPwpm1y9fM
	ChqAHvRPRHE2iT5D5qS9sGwRtAdvEHJkLW+To/G0vGBVfS/+MJ2NOIpL
X-Gm-Gg: ASbGncuZs8rLQszlLWFGlXDxrBq5BaCOswccWKipRMSWPtqTzSU4o9yvTuftszZKBoX
	qj2/TA4bHbSfz95dlxEYwLlwKPNsmSwK9DiCFranR1Tn44sdI58JU3aOMuYnOnRCpcS36ROVpM1
	uIeQV4gZHp03igoDzN45wS3Rffg7PPbusXs8BszqMIZvHYKQenlXFNqqKYiAvHu0UUIR6dbvNOf
	sltdLtSB/DlBamG0IBl6sUSSIa5hWGzsUZEbmvNQ5OPzY+of/UhWX1ZM1kJUU3+M7TG34l7rokO
	j5hvFjn5drouX2WDWDHz9L9ppW40S2goXtP8j4q1AWUdj8UmoLpShWN0WChXorha7KD8xfVrjmO
	jpWJir7HXxBtAopRSgp8cRvMT+lx4UIZEctU4rc9dHqmvXzPWr7qBeIpN+HYI5oDL
X-Google-Smtp-Source: AGHT+IHQ279htWhxE31+fZ8xNbCc06b+UVpK5/HR7w+6d+vlGQO/mbKIoxrJARH/bAnfWz5iWp5YQQ==
X-Received: by 2002:a17:902:d4cb:b0:240:52d7:e890 with SMTP id d9443c01a7336-24096bb30e1mr90175125ad.47.1753932705598;
        Wed, 30 Jul 2025 20:31:45 -0700 (PDT)
Received: from CQSWSUNAO.transsion.com ([107.155.12.245])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef48fbsm4970925ad.36.2025.07.30.20.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 20:31:44 -0700 (PDT)
From: Ao Sun <aosun718@gmail.com>
To: linux@roeck-us.net,
	matthias.bgg@gmail.com,
	p.zabel@pengutronix.de,
	wim@linux-watchdog.org
Cc: linux-kernel@vger.kernel.org,
	geng.sun@transsion.com,
	Ao Sun <aosun718@gmail.com>,
	Jiazi Li <jqqlijiazi@gmail.com>,
	"peixuan . qiu" <peixuan.qiu@transsion.com>
Subject: [PATCH v2] watchdog: mtk_wdt: Use NOIRQ_SYSTEM_SLEEP_PM_OPS()
Date: Thu, 31 Jul 2025 11:31:36 +0800
Message-Id: <20250731033136.3914-1-aosun718@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2bf292d6-0f51-473c-bd44-f129a0b2a7ab@roeck-us.net>
References: <2bf292d6-0f51-473c-bd44-f129a0b2a7ab@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During the device resume process, an interrupt storm occurs after
interrupts are enabled, preventing the watchdog device from being
resumed and functioning.

To ensure that the watchdog is resumed and executed before interrupts
are enabled, Use NOIRQ_SYSTEM_SLEEP_PM_OPS().

Signed-off-by: Jiazi Li <jqqlijiazi@gmail.com>
Signed-off-by: peixuan.qiu <peixuan.qiu@transsion.com>
Signed-off-by: Ao Sun <aosun718@gmail.com>
---
Changes in v2:
 - remove extra space, and align multiple lines.
---
 drivers/watchdog/mtk_wdt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
index d6a6393f609d..7dc53409cf99 100644
--- a/drivers/watchdog/mtk_wdt.c
+++ b/drivers/watchdog/mtk_wdt.c
@@ -327,8 +327,8 @@ static const struct of_device_id mtk_wdt_dt_ids[] = {
 MODULE_DEVICE_TABLE(of, mtk_wdt_dt_ids);
 
 static const struct dev_pm_ops mtk_wdt_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(mtk_wdt_suspend,
-				mtk_wdt_resume)
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(mtk_wdt_suspend,
+				      mtk_wdt_resume)
 };
 
 static struct platform_driver mtk_wdt_driver = {
-- 
2.34.1


