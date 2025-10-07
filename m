Return-Path: <linux-kernel+bounces-844346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F642BC1A23
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 16:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AA4C334F776
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 14:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA16B2E3360;
	Tue,  7 Oct 2025 14:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HPvQRLlL"
Received: from mail-pf1-f225.google.com (mail-pf1-f225.google.com [209.85.210.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4B02E336F
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 14:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759845911; cv=none; b=NVLYaL96wT2Gd0luor7QVu0LFoeXMV9t+/zAFdmOTtMhlV8OkgQSzjG3jEzR1eG1b4wjTe+w6ch5Pi1YgU3LkObdqc90dKMSAtZb2FIGj1BD1SLfI3XDCwBw1oPJtc/DovO3M77uJJjrVXiBLxWmn0JvZuB0CyK8mn/hd2gKg+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759845911; c=relaxed/simple;
	bh=Rk6f7wi+QRbO64RAAHsaYdej9yZMvSjKm8kZyMLaGdM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ND+3vvUOTW974BL4GfvgeTEXVu9Km7zg3kJER2DJxFqqhnLidM0g1oxyB0JP1j6mJDHUm/SxGM259/rbR4Ju6HTWGaXitMFYbJ2jMSSI8pGQZnLa2dpbLLB1k/c+hrr3+8jwH5NXoCqUSB4tXZcHE3qyTADYuG7dcYdVx0q+NAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=HPvQRLlL; arc=none smtp.client-ip=209.85.210.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f225.google.com with SMTP id d2e1a72fcca58-7835321bc98so6083162b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 07:05:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759845909; x=1760450709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6qxUFkx3TIQhAfsBZkcTY7Gt7i9ylaZPTGmpdbY/RyQ=;
        b=Y5rtstUo64Zdqnhk37hFIffKoTxBlKNRVm/s/NnI5MeKcwxTzGAG9SmZXmPe6mcPgP
         vVtj4mImNdKLCdSdR/NyI2CVjrNOUnqnsReXMTJQVzvatHTReYUi0nqLvkApgXl5iAtm
         8R1WbVZtAJ8p2GIOd/aFXwD/PFRxFneqCxVAVo5YDlSH4JLK93xL7Ll7YqA3uEKbNQg2
         6o6+1/R2LB+ONFujnaqJB4R0CZyIH6bHAOcKaelZH406t5lvRLWPqnVJ6MC9pYDSnOz1
         oZgpiBmDnkzwh/VjGgAkblmav9MDkleKItljJPZjtDs0mVfO7C9F6lBZahbCJYotaq/J
         bhgA==
X-Forwarded-Encrypted: i=1; AJvYcCWZjBI06nI1qcGQQlKMqt7ek4/+u8Zp+je1vORtfC2ySjQuE2tyo+hauYBZ3cmRYHvYNzBRQGe7FsQTkDA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0/3HICQ6RDA3vG6xFyjw7a7T11AgYsQXjtNPtfFcZvHfvERyR
	IHkODnljNF0szaiuCa/Dz+88TCW/VlOYh3aVHLYCjtTyazJvcu5xgMSMWjKSzcwLLG718Ldpn30
	EfMS46NXR8plf2u8qsoKzXYDuxld0DwoCnoaPAPy6tpyxQpkBcGQxs6qXhbYLRuiM1J0YBMwyuq
	PYmCc6KhTDITFWIJw1HIRSvtJnYm9kpqvCnutuN/sBQGqKuwtAVbltLTw+Wxrhi3fkpw7rV04wU
	JPLLlHJOUkr4wF/
X-Gm-Gg: ASbGncuMy4WksZCem9kUx3Ry3InAlEDmyrOM3SjhDqHyy6G8e8SzGBCGNnrEo1+0SCR
	1xIMxD1ry6RkH+Swl3RSFmzl6UJXEMod1zVKQp1wsOIZ7GzE6SeGV9ATdXEAv8kQmhP9a8rApie
	IZTwyE3KTs3XOyG2BKUcf3DXn0SWjUi6rQ9RYLjJkc8xAobV9OpjV/onwpSDZzISmWOH6KJyUWF
	ZUlwJ7+T9E5oj06B7iIG7+g9CEGn/k7pp4LYRD1Z4UiyNA1l1jtfx2vywtZxK96VP7QZwBzbnls
	1V/w+lysevHf1991sRPdSMHKS2xXr8Qc5MEEdb2/AXSyuGo/gHUm/LwF73z8L9urDLUPK9TYZJI
	v6N3UMYvQkOWhIsvs6Je9IronEBLuf8CQjMl08SzAi8p/Km2vUl29tznYRmWV3Bmcdm7if9tkD2
	9zVkD8
X-Google-Smtp-Source: AGHT+IHaIKmA/nAZycxnSUBtvz+sPmRCm6fDH+OuuRUps3tuj9PYJxZeEbFy7IdkJVAesfQZcNnaxRQbC/QB
X-Received: by 2002:a05:6a21:e083:b0:2e5:655c:7f84 with SMTP id adf61e73a8af0-32b62118a17mr17153103637.54.1759845909020;
        Tue, 07 Oct 2025 07:05:09 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-b60999c5f4asm884710a12.6.2025.10.07.07.05.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Oct 2025 07:05:09 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8741223accfso138425496d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 07:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1759845907; x=1760450707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6qxUFkx3TIQhAfsBZkcTY7Gt7i9ylaZPTGmpdbY/RyQ=;
        b=HPvQRLlLTn07H5FzHfQUPtQqEKPqXXBfNYafAdp7bstbflAId8xladmAMsinZvhG7J
         qYCDohPEUg7qVTH5X/BmYTMihpsFQSJZhMXMxbty6+fwnQHpdhRsvpnTj1GB7wpOICqG
         vm+Hh6D8FO0CURkZCdulixd/ALBT+qG/MV3Uw=
X-Forwarded-Encrypted: i=1; AJvYcCUcYlf05oJi0dOOV03+vg+wYQtK2arrT4GGirmloPtNB7ez9xfXvMgIfvLlaZHFzK6biLza6Gj144N89uQ=@vger.kernel.org
X-Received: by 2002:a05:6214:1254:b0:70d:6df4:1b21 with SMTP id 6a1803df08f44-879dc87fd21mr239627936d6.62.1759845905204;
        Tue, 07 Oct 2025 07:05:05 -0700 (PDT)
X-Received: by 2002:a05:6214:1254:b0:70d:6df4:1b21 with SMTP id 6a1803df08f44-879dc87fd21mr239626916d6.62.1759845904420;
        Tue, 07 Oct 2025 07:05:04 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-878bae60b67sm142718956d6.9.2025.10.07.07.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 07:05:03 -0700 (PDT)
From: Kamal Dasu <kamal.dasu@broadcom.com>
To: andersson@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	florian.fainelli@broadcom.com,
	ulf.hansson@linaro.org,
	adrian.hunter@intel.com
Cc: bcm-kernel-feedback-list@broadcom.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	Kamal Dasu <kamal.dasu@broadcom.com>
Subject: [PATCH v2 4/5] mmc: sdhci-brcmstb: Add BCM74371 support
Date: Tue,  7 Oct 2025 10:04:32 -0400
Message-Id: <20251007140434.606051-5-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251007140434.606051-1-kamal.dasu@broadcom.com>
References: <20251007140434.606051-1-kamal.dasu@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Added "brcm,bcm74371-sdhci" compatibility to the controller driver.

Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
---
 drivers/mmc/host/sdhci-brcmstb.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
index d25bf71d79f4..42709ca8111d 100644
--- a/drivers/mmc/host/sdhci-brcmstb.c
+++ b/drivers/mmc/host/sdhci-brcmstb.c
@@ -299,6 +299,11 @@ static struct brcmstb_match_priv match_priv_7425 = {
 	.ops = &sdhci_brcmstb_ops,
 };
 
+static struct brcmstb_match_priv match_priv_74371 = {
+	.flags = BRCMSTB_MATCH_FLAGS_BROKEN_TIMEOUT,
+	.ops = &sdhci_brcmstb_ops,
+};
+
 static struct brcmstb_match_priv match_priv_7445 = {
 	.flags = BRCMSTB_MATCH_FLAGS_BROKEN_TIMEOUT,
 	.ops = &sdhci_brcmstb_ops,
@@ -324,6 +329,7 @@ static struct brcmstb_match_priv match_priv_74165b0 = {
 static const struct of_device_id __maybe_unused sdhci_brcm_of_match[] = {
 	{ .compatible = "brcm,bcm2712-sdhci", .data = &match_priv_2712 },
 	{ .compatible = "brcm,bcm7425-sdhci", .data = &match_priv_7425 },
+	{ .compatible = "brcm,bcm74371-sdhci", .data = &match_priv_74371 },
 	{ .compatible = "brcm,bcm7445-sdhci", .data = &match_priv_7445 },
 	{ .compatible = "brcm,bcm72116-sdhci", .data = &match_priv_72116 },
 	{ .compatible = "brcm,bcm7216-sdhci", .data = &match_priv_7216 },
-- 
2.34.1


