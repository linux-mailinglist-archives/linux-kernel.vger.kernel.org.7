Return-Path: <linux-kernel+bounces-779214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB574B2F086
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 10:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26426A05C25
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 08:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC152EA480;
	Thu, 21 Aug 2025 08:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="XTHU4SQS"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21A32EA46E
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 08:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755763436; cv=none; b=Vlrndx3A1IaSpWRGKUu7exl+xftREJ7MOpmgbgV54TARRDh1uPNhZS+m9NJBT0Msk6ALszHeOuUF+61LXkyFFoz9A0qU8ZsWHxQAX6cWe06OhGyybfvuBmOK7AmeUiUVBl8g5MvKaI/8uIwrW1CBG99fNtLxk4sPy/o28nl19Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755763436; c=relaxed/simple;
	bh=zl9urWICH9QOFxPuxMWozGp3K4sPsX6l4y0Be2Ifb5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yexgtlf4YM6xwituryplXCzy37U6udYcQ291uE9368024Nc3rxT2hmMrsEVTlF7DJkhSstcCWVQTtQlEvTBAAa/6zaMS9SDRYA+UQ4SS22IXXX4EV2Kp3wFIRyPate/TrQx5rK+wYKLSMRUg0NZ+EIPQKYJsaC9t5/jiKuBsHPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=XTHU4SQS; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3b9e414ef53so490210f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 01:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1755763433; x=1756368233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8tkCmPvwD0G55+3Hz+PGIRzqfrV4CwxtOzw2jRg+jCU=;
        b=XTHU4SQS8brkMB/L5kn43Zo/gIu9ZBK1iLkFyvNKw7rbQ3i9Jau6fDNRYUlYUyAvbZ
         MXXgaHy68RL6C1c9LDrXVQkMmz4AWmzA74fa46XsqTLqAE0P+M3zeBvruF9w/YJvOkF4
         oxJ2Y2b1cIqeIb4L7SThXWTbZx+B1+4tEuK0G4h60XHBA/UP7QGWYQAbAApGxVMuJmAS
         4Q4zEUMohKD7bd9sBTL+r9iLIQ54LyYOGBeE6r1fAnHxiH5nJLOSfUn+XHUTqnNZN+uu
         sTOLJUORe6Romk9FKqSp6qKFwG0kjhXj3GZnhiKKjaPjRFch4gglcgW3LGNp6nJ4d9Qu
         KTnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755763433; x=1756368233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8tkCmPvwD0G55+3Hz+PGIRzqfrV4CwxtOzw2jRg+jCU=;
        b=POzAIR95eWUnU4AkmjS84P/l6hMX7+vumSCUGvSQLxwK67dyBVbeRMwmREWrgjnfvj
         QV26+KGH0TD5HdR3ggGL6uSODmGi4QypSe06jmmea0W4EctxsJjfzAenbBNQ/ZGWnrHl
         4N8rd7mmy7ATkLUPnkRSar6cdmEu1gkFiZovpqCkfoWo8DqXqgs2/gZ1VVt6AS9grCg9
         QEYvlk+UtcADTAu6xgh8irofVZ/FEglantCyQp1bDU8S8uap8Ayyg+eHPj89u5z+mHDv
         k+3NrEMlmTsG4bmkgEwkpEC22ifADNiCVHnxkfEySubI5d2ophpaNzPQr4pDBbuhv6y1
         DWjg==
X-Forwarded-Encrypted: i=1; AJvYcCV5gDIbIU6E2uWlHwwOlBzDuYyOHYPMPSib0VZX7uXIXwFxpPDWa6DGF7OYjq3SOukDhdFg2/qGQXGFKoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUbzxmWrr2g1IANdxJQeLeWEtQkSrIyLdMylcvWaPv8qy7hYrn
	p2awKlBUJkMN/u3B3RkB6+OnPT3ug0TfswL5PlBVfNWVbuIujaDW6WljvrwWT/9McnU=
X-Gm-Gg: ASbGnctQ8n0qwBoEzQbq9tBy/Nof1hPhfahEvFKfUCjaIVyBhyQZiEeLlBf4bFcd1vX
	mODuTD7IzDNWL3Z3IpmlwlfihMraN+lRCPjVxUJChsbFqBcnEQyOJcKNSP0vV36yfyzTBKRkfza
	jd4wG3/sG9L/txROcLv2hplO8ybY+ttHhDQuu/ECuWnGRum6AfzRG47wXs1rLvI+uUowUfMwQNF
	RcAI9ecJ6/1EE8CJzpJTlE8l3C4CIDo82MbAbFXr5EN6zxgDTOl0gDemucuj+hBZ1xFHYi5NiJ/
	hN08TOqMXaIBBuh7/d733sy1x59mBcOgvmQHGEMrNpW3Ve3qAQdcMGrPnVhq7drrbeVyWDg56ak
	GXdtT0qbHj47K5ehQiCrhKWgLXUPD4YvpYoqJUXpg8mDr0obuiVY=
X-Google-Smtp-Source: AGHT+IHxOvjpSJKD0XjWYHq10XV3QIWqZ96+Xmdgfaum7aOTVRU/X6sQmyVkYJBCNcnnXqHOGX0gTQ==
X-Received: by 2002:a05:6000:2483:b0:3b8:d30c:885f with SMTP id ffacd0b85a97d-3c496316b13mr1240711f8f.53.1755763433031;
        Thu, 21 Aug 2025 01:03:53 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b4dc155b8sm17356225e9.19.2025.08.21.01.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 01:03:52 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: mturquette@baylibre.com,
	sboyd@kernel.org,
	geert+renesas@glider.be,
	linux@armlinux.org.uk
Cc: claudiu.beznea@tuxon.dev,
	linux-renesas-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 2/2] clk: renesas: rzg2l: Register PM notifier to disable unused clocks
Date: Thu, 21 Aug 2025 11:03:32 +0300
Message-ID: <20250821080333.27049-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250821080333.27049-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250821080333.27049-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Register a PM notifier to disable unused clocks after system resume.
This is necessary when resuming from a low-power mode where the bootloader
re-enables certain module clocks for its own use.

To avoid keeping these clocks enabled after control is passed back to
Linux, call clk_disable_unused() from a PM_POST_SUSPEND notifier.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/clk/renesas/rzg2l-cpg.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/clk/renesas/rzg2l-cpg.c b/drivers/clk/renesas/rzg2l-cpg.c
index 187233302818..2ca32d7acaf7 100644
--- a/drivers/clk/renesas/rzg2l-cpg.c
+++ b/drivers/clk/renesas/rzg2l-cpg.c
@@ -24,6 +24,7 @@
 #include <linux/iopoll.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
+#include <linux/notifier.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_clock.h>
@@ -31,6 +32,7 @@
 #include <linux/reset-controller.h>
 #include <linux/slab.h>
 #include <linux/string_choices.h>
+#include <linux/suspend.h>
 #include <linux/units.h>
 
 #include <dt-bindings/clock/renesas-cpg-mssr.h>
@@ -150,6 +152,7 @@ struct rzg2l_pll5_mux_dsi_div_param {
  * @info: Pointer to platform data
  * @genpd: PM domain
  * @mux_dsi_div_params: pll5 mux and dsi div parameters
+ * @pm_notifier: PM notifier
  */
 struct rzg2l_cpg_priv {
 	struct reset_controller_dev rcdev;
@@ -168,6 +171,8 @@ struct rzg2l_cpg_priv {
 	struct generic_pm_domain genpd;
 
 	struct rzg2l_pll5_mux_dsi_div_param mux_dsi_div_params;
+
+	struct notifier_block pm_notifier;
 };
 
 static void rzg2l_cpg_del_clk_provider(void *data)
@@ -1879,6 +1884,21 @@ static int __init rzg2l_cpg_add_clk_domain(struct rzg2l_cpg_priv *priv)
 	return of_genpd_add_provider_simple(np, genpd);
 }
 
+static int rzg2l_pm_notifier(struct notifier_block *nb, unsigned long action,
+			     void *data)
+{
+	int ret;
+
+	if (action != PM_POST_SUSPEND)
+		return 0;
+
+	ret = clk_disable_unused();
+	if (ret)
+		return NOTIFY_BAD;
+
+	return NOTIFY_OK;
+}
+
 static int __init rzg2l_cpg_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1948,6 +1968,10 @@ static int __init rzg2l_cpg_probe(struct platform_device *pdev)
 		return error;
 
 	debugfs_create_file("mstop", 0444, NULL, priv, &rzg2l_mod_clock_mstop_fops);
+
+	priv->pm_notifier.notifier_call = rzg2l_pm_notifier;
+	register_pm_notifier(&priv->pm_notifier);
+
 	return 0;
 }
 
-- 
2.43.0


