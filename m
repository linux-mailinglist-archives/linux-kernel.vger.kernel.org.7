Return-Path: <linux-kernel+bounces-659248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE527AC0D83
	for <lists+linux-kernel@lfdr.de>; Thu, 22 May 2025 16:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B70C1BC6E6A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 May 2025 14:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E428D28C017;
	Thu, 22 May 2025 14:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nr53kkY8"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9459228A738
	for <linux-kernel@vger.kernel.org>; Thu, 22 May 2025 14:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747922640; cv=none; b=PwDrO8QDJWMCsj8wfwaphX473mgdZeRE4sEfuxp8r7sXLUv+iX+cNT5GwNhs1ZOLk5VVXiGqklNm9KXTTcDUsjPSrmcAqnYlYCiu34g6U0H65/1bgwhfi9JR6Vyl5/TsKZQQ/EcwbHAnOvwajRxAiTfHLNqoasawZwlrJX0FBo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747922640; c=relaxed/simple;
	bh=1KVjcik5so/WTA64+96vM5LC1e61yVX6g4s+JpKmV2A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m5F99UlTSIQme6pd5IHkUFaqUSDJ+PI/+wnklaNwgHxQJUuamOqxXX5RakVgBWvCHP2sejdxg+XFvKlu2gwuicINGJHB7jWPZR5OnXZF+0XPz99XGHtg6DJRR4prAxaDakQvHI67SHQJGkT7xKt0VGf82tO/21xT15LbhrZRtyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Nr53kkY8; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b26f7d2c1f1so5962227a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 May 2025 07:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747922638; x=1748527438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WFeocyTJuLKPQZ0pWs7dDXWGd3yi1SWCmy79lHa62kE=;
        b=Nr53kkY86zoALfGxA53ksW5QSy+ajHUZXaZRfjooPddKw/li9wgH5eq+V1oLLO+rRm
         iRLgpmhc6vmk5x4k0SFWgqK9PGj4gvlCOxge0kyD298v4pqaBMA+TeafVfslFIWCxKmU
         LDVsRqaTMzqdLqv9oxDZabsx5Zu85/7cZdQJ+TlecLoiogvY5bH7jiK8CVHOmCeSeDGh
         I+WhuYf6ME+H95BgllFxtIpdZJTbCK6tNntVPiRC44+3Cb1BPKzlQbKv41/tm8UbO2Pr
         KlS42pSL3+LRp89uEqX2YaIhUwHGW3vOruWOTr96Y+TRJA27L92aFJr2b8T6sCRESYyK
         cozg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747922638; x=1748527438;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WFeocyTJuLKPQZ0pWs7dDXWGd3yi1SWCmy79lHa62kE=;
        b=eAf8y2TZszsDZDHtc9k1SJhQ+/WxPwkQd2O//uk3rDf1VXawrVl/Mke0Q02AuSj5xz
         Jd92xfKGwvNtW0kT6wn7TjOAvgKpMqXyCPVoQ1yjlEReSPBcDCXIHU5+MbCxhWX3nesg
         vVuyRYxVgyMraVdX/FoR7UgvtOMjNFqiY8yjrGrOnGIAZ4WtpxR/LsICBDlHAOfiGjHT
         mpYWGSDmYqXuezOJjOtwzOJ9kUz7K3hknMB1R1duLbU8m1Hpbl3odwPqfFNaTwYMURKB
         fkf/J1jd/uWupxt5Y0erbilm14ISGSLfYeQ5Y8j+ZAsOb+79sZdRHR4r+7XyJCEofDbB
         PRHg==
X-Forwarded-Encrypted: i=1; AJvYcCU6fMnelOaEWRB0aTRjT767smRyG0SA48R8Nj9ob91KpntvHcynnJEitjg9OW5rLnz0QGLeOgFkatSIOYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPJuqgJtFW0E6dPu6fqyuGRF7FwbZ0npE3i8u9gJHNdy45GGK7
	pMQrjPQuI4wvbAkIzjev4bzM9+lx0uqXaclO5MlIZEqRNF0QXMAPuVA3GjYfSeiu+ygd2q9Dshc
	CoI8=
X-Gm-Gg: ASbGnctiE/eW5UmJNorHFQctGT+ni0QjsqYL4MblSXCSVMuWdZ2gJV0G0rbRq9SiCnd
	l/5oAqVsqHYR1egfNbjlIZD+mP9AT6qWDhCllU9GUENS4ZVQmv3Kb2gd+pAHajqAmFpBfKVdQsI
	MkYz8Ofc3XHxHVgXEeLj/4yisH+6gePbbWwiVTA3z/QpKUBNoPkD01anO/5y8JH1Efyp+cNzLYD
	I4rf1vTYTEZCJFQ9Z/uh/UgobotVM4Fc29Z6Q8u9/Ia1VAWDBqf+xO/CQVO5q1Lypny3GljXaFI
	rJmn4MfttNLBZrQzLbskHcThlmHFaKi0JS+aift/gOXMiMFv9Issz/OR20WNhHyN
X-Google-Smtp-Source: AGHT+IG1vC5VzRGtucIyP67/HVoXG1ghss4YShEgmt/nznCRuiVBZrRT3C7b2kCpEHLM7q1bfdFeXg==
X-Received: by 2002:a05:6a21:3405:b0:1f5:9330:29fe with SMTP id adf61e73a8af0-2170cb40802mr32117847637.17.1747922627085;
        Thu, 22 May 2025 07:03:47 -0700 (PDT)
Received: from thinkpad.. ([120.60.130.60])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a98a2146sm11247499b3a.160.2025.05.22.07.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 07:03:44 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bartosz.golaszewski@linaro.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Jim Quinlan <james.quinlan@broadcom.com>
Subject: [PATCH] PCI/pwrctrl: Skip creating platform device if CONFIG_PCI_PWRCTL is not enabled
Date: Thu, 22 May 2025 19:33:26 +0530
Message-ID: <20250522140326.93869-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For platforms that do not use pwrctrl framework, the existence of the
pwrctrl platform device will prevent the enumeration of the PCI devices due
to the devlink dependency. This issue is reported on the systems using the
pci-brcmstb.c driver, which doesn't use pwrctrl framework and handles the
endpoint supplies on its own.

So, skip creating the pwrctrl platform device if the framework is not
enabled. It is only a temporary solution to the issue. The actual fix would
be to make pwrctrl framework feature complete (by supporting system PM with
WOL) and convert the drivers that already support system PM like
pci-brcmstb.c to use it.

Fixes: 957f40d039a9 ("PCI/pwrctrl: Move creation of pwrctrl devices to pci_scan_device()")
Reported-by: Jim Quinlan <james.quinlan@broadcom.com>
Closes: https://lore.kernel.org/linux-pci/CA+-6iNwgaByXEYD3j=-+H_PKAxXRU78svPMRHDKKci8AGXAUPg@mail.gmail.com
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Tested-by: Jim Quinlan <james.quinlan@broadcom.com>
---

Bjorn: Since we have merged patches that rename the Kconfig symbol from
CONFIG_PCI_PWRCTL to CONFIG_PCI_PWRCTRL for v6.16, we need to make sure that
those patches also rename the symbol in this patch once it gets merged in
mainline. Maybe merging this patch to pci/pwrctrl branch and rebasing the
renaming patches on top would also help.

 drivers/pci/probe.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 364fa2a514f8..7f5e91eafe56 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2514,6 +2514,9 @@ static struct platform_device *pci_pwrctrl_create_device(struct pci_bus *bus, in
 	struct platform_device *pdev;
 	struct device_node *np;
 
+	if (!IS_ENABLED(CONFIG_PCI_PWRCTL))
+		return NULL;
+
 	np = of_pci_find_child_device(dev_of_node(&bus->dev), devfn);
 	if (!np || of_find_device_by_node(np))
 		return NULL;
-- 
2.43.0


