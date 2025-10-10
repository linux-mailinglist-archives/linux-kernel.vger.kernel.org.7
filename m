Return-Path: <linux-kernel+bounces-848233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D34BCCF8A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 14:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D51EE4FC488
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 12:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC542F3620;
	Fri, 10 Oct 2025 12:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c916d7s0"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F912F0C6C
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 12:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760100410; cv=none; b=U+owZyrbs3r1+B9jjRFbIXnx/s5Rn827yudnLYzO8EtTJPfez+HMSDxTjvViLMWlRypKPXmtwXtXr/bk9Htm0bRhl/scxF6/iXEWCkmOZjQdwibV+CUzguLhDUMW6XKaoj0fBj5NmdAT883fgs0WENi15Ok1KM9O+XPHfMJHn3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760100410; c=relaxed/simple;
	bh=t1lPRTLbJh3Ia3iHDBwP0Q/txEDKq77Cj8s7vCWLHB4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c/TntDRvr3AhF5g2RGBmtVum3P1Uw7dhoBgyxYaKaS4/OyroYDANs2Lj+il2kihSsDXOLI6vRiwL/G0CSLguUF/j1Thw+bRRGCOTTIAr4bIZ2ZH1xm1uUCRDvckm81JX4Xs9EojxgpRxzVmOEGf6ds69tMG8PvnGbUEDb5cT854=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c916d7s0; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3f2ae6fadb4so2364496f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 05:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760100407; x=1760705207; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6iPGUbK9frPbiRIF66lkOW8PKDoG2AW/288srP+02V0=;
        b=c916d7s06IG11NJ4RQXBFaCRGsnOG4rxBnsPRggVLBhIxXhjv5hDUkXcjwX2UgEdkz
         jhJPfk1S9n44DZZ91WKYVH2z+4KtJFNyiLtxEcjhKED+pj2U0ehPnRP6yOGzB4ZntcvD
         sw/k3iZbdV0H+izGzBRxe1AxV7hpiwk+QtyEvkJcqqoZSf6lDPGdfh4rmePe+Y95dcrU
         Dt76oYpYB3zdJ8aD/EnIdQbSZaL35CnH6K6owgaci+hHlpezsO87Ek5nlcHKTr4yXr/F
         DuyNjSsqz5Shjfk3w4VTcytgSlla2ge7sLifbPwDzqKcvPhNJXHoeJXDHOyjlEJXlZgJ
         eycw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760100407; x=1760705207;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6iPGUbK9frPbiRIF66lkOW8PKDoG2AW/288srP+02V0=;
        b=CEKi38MNwCA3xH2Kr6Srv1feAyqzhutws+T5MyvRAo+bUCV3rO6VRmCuEbasMgdSIn
         ahMegBRo/MBpn+4jyOM5VIWxZIae55EcyzpZc97cU+2OfDqsPssbjmpjM1oGlIq57JjC
         AFTqzYovHFibugP5VhhYBZay0BzFS2HHkjJGku1i3kIh3XafIYYIvFLzywK5Y7boRUUs
         73fWUQHwJCx4jz+gd6jc0GdtSrECUtZFM/6Kol1sfzhfiwJQG4KlEbCBRVz2RgpkKufL
         vBgIJ7jXhrAoGYQqbajEJlWBCmPHKVYTTDv+tCRpBIg25REx0TUCN3/VwGG1Tm697FHe
         wJfw==
X-Gm-Message-State: AOJu0YwtAtcEt+KsBw/4te4o3XYYA8UFDaj7SsP3H5PLG7RBgSE2bqtx
	IL3OVyilslDntf45vLQc6EztzxU0Y/RuSeixQH3KApc+wm+5vn7tWbrqRiLZRb8TZ0M=
X-Gm-Gg: ASbGnctDPkHFKbwzDHxgVZhCqtbooJ00as7ywKWUehrvi4wGsyNBpNzw2rVhbUbXndz
	nVVxhNvpBYparoJHl0V2ONRcDufaHazmcMDBALFIo7kVOB0IyMV6SQ7A86sM8Lrnko0EaOqxzgZ
	VUgnGsqN8XYTEqi9M40Z2sWujSvre7XySZc4wYphGuFriPjllNnfakCIRHETmKhZ1nzHGlvd/MJ
	+GkD//am0UjJ4b3IfQNvaQdo7iIGhkFzfwYvsssbCyeSis63qpFlJoJKaCeAIGQYvym0HXYrYMQ
	Qly6UudA7/wL5I1BTbjJwHTj/M/BWWIC//j0VHF/qTRKEJFyqZ8km9yaC/cbAJ6WyUz6g7Q7xBO
	5PhJhkhRYTMgZSFSAMRYely+qGIfdTf+JWkzroaYJxYFkczruYck4q2zdTNAECyJeebsgoufQbH
	uAKmSeUsZLjwXYZIETYWDseA==
X-Google-Smtp-Source: AGHT+IGDLF3Dn6ww4MqMyl8hynsTWVMXq6aUH6TJOkzwSsp0EMXTDsmcy1Rr53t1iniI2RiP834aMQ==
X-Received: by 2002:a05:6000:288c:b0:3e4:d981:e312 with SMTP id ffacd0b85a97d-4266e8e51f2mr6813063f8f.62.1760100406667;
        Fri, 10 Oct 2025 05:46:46 -0700 (PDT)
Received: from ta2.c.googlers.com (213.53.77.34.bc.googleusercontent.com. [34.77.53.213])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb484d056sm46376895e9.9.2025.10.10.05.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 05:46:46 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Fri, 10 Oct 2025 12:46:33 +0000
Subject: [PATCH v6 3/6] firmware: exynos-acpm: register ACPM clocks pdev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251010-acpm-clk-v6-3-321ee8826fd4@linaro.org>
References: <20251010-acpm-clk-v6-0-321ee8826fd4@linaro.org>
In-Reply-To: <20251010-acpm-clk-v6-0-321ee8826fd4@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-clk@vger.kernel.org, willmcvicker@google.com, kernel-team@android.com, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760100401; l=2732;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=t1lPRTLbJh3Ia3iHDBwP0Q/txEDKq77Cj8s7vCWLHB4=;
 b=qk3U65kSz815bNfHe5stxRu4BJ0qvWZNQmQfMvtFvJGNAjNj9MvxWPW5Jp4sLvaf2hRaK3Jlg
 J1pvueABQIEBkgK0U/NX3fwYmXMxSALpy5zS1E7Te84RmsjTueCqo4C
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Register by hand a platform device for the ACPM clocks.
The ACPM clocks are not modeled as a DT child of ACPM because:
1/ they don't have their own resources.
2/ they are not a block that can be reused. The clock identifying
   data is reduced (clock ID, clock name and mailbox channel ID)
   and may differ from a SoC to another.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
Tested-by: Peter Griffin <peter.griffin@linaro.org> # on gs101-oriole
---
 drivers/firmware/samsung/exynos-acpm.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/firmware/samsung/exynos-acpm.c b/drivers/firmware/samsung/exynos-acpm.c
index 9fa0335ccf5db32892fdf09e8d4b0a885a8f8fb5..0cb269c7046015d4c5fe5731ba0d61d48dcaeee1 100644
--- a/drivers/firmware/samsung/exynos-acpm.c
+++ b/drivers/firmware/samsung/exynos-acpm.c
@@ -177,9 +177,11 @@ struct acpm_info {
 /**
  * struct acpm_match_data - of_device_id data.
  * @initdata_base:	offset in SRAM where the channels configuration resides.
+ * @acpm_clk_dev_name:	base name for the ACPM clocks device that we're registering.
  */
 struct acpm_match_data {
 	loff_t initdata_base;
+	const char *acpm_clk_dev_name;
 };
 
 #define client_to_acpm_chan(c) container_of(c, struct acpm_chan, cl)
@@ -604,9 +606,15 @@ static void acpm_setup_ops(struct acpm_info *acpm)
 	pmic_ops->update_reg = acpm_pmic_update_reg;
 }
 
+static void acpm_clk_pdev_unregister(void *data)
+{
+	platform_device_unregister(data);
+}
+
 static int acpm_probe(struct platform_device *pdev)
 {
 	const struct acpm_match_data *match_data;
+	struct platform_device *acpm_clk_pdev;
 	struct device *dev = &pdev->dev;
 	struct device_node *shmem;
 	struct acpm_info *acpm;
@@ -647,6 +655,18 @@ static int acpm_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, acpm);
 
+	acpm_clk_pdev = platform_device_register_data(dev,
+						match_data->acpm_clk_dev_name,
+						PLATFORM_DEVID_NONE, NULL, 0);
+	if (IS_ERR(acpm_clk_pdev))
+		return dev_err_probe(dev, PTR_ERR(acpm_clk_pdev),
+				     "Failed to register ACPM clocks device.\n");
+
+	ret = devm_add_action_or_reset(dev, acpm_clk_pdev_unregister,
+				       acpm_clk_pdev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to add devm action.\n");
+
 	return devm_of_platform_populate(dev);
 }
 
@@ -746,6 +766,7 @@ EXPORT_SYMBOL_GPL(devm_acpm_get_by_node);
 
 static const struct acpm_match_data acpm_gs101 = {
 	.initdata_base = ACPM_GS101_INITDATA_BASE,
+	.acpm_clk_dev_name = "gs101-acpm-clk",
 };
 
 static const struct of_device_id acpm_match[] = {

-- 
2.51.0.740.g6adb054d12-goog


