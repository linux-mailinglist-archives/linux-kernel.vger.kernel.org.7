Return-Path: <linux-kernel+bounces-842687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19FA8BBD4DE
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 10:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 168D83A6449
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 08:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D27925BF14;
	Mon,  6 Oct 2025 08:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q8EqqQnG"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEE42472B9
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 08:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759738036; cv=none; b=NF56fQPxuCz9o+DaA6LgPUjCx1mjAAUelRZljrPWG7TLKCYEkwe6tJ6SzmN6EQjko5WDp6k53iJjChTIfr2vlj6uRNpaxnCtEEouq+vQmVe+E/X8MHTtLwFAyGYiYIxKprKhhmGE/XLe24H+bzKAYnZZ1XVOLpheh6GtsHl2ktU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759738036; c=relaxed/simple;
	bh=BeDMN8uWVJklyLJj+1L2d060Z8oyIimOZuMRkiyfk5Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JpGSoHdQZIdz6LDwf2D+al7YgOKpNYYUU1QfR/16Q+LfmR5Ot2I+ulNuNj9Z+nam+We5apBShL/gzDy5YrmdMdrp8vRNvvJE/IO2V++K4a8W/0H/TUuV1Du1pHrNz0kSONFYeMhtsMDA7DB0DR7l6ErzeNgJgQMLndZiRRKUWDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Q8EqqQnG; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b457d93c155so815447666b.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 01:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759738033; x=1760342833; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4qerrj6UX/Z0xW9m5oFGqvhu+d9Lea7yfQjzYQpDbWQ=;
        b=Q8EqqQnGHw2OXBYfLaTWVJdNOT9xt3d34i4puk6Hycq+zg2cwBTRl0NK+1P01Y46cB
         BK7A7FvnHK2J6zKcovlK3DND7OZLXf3UBpGWXtc1vmu4G8y3hTjWPia1hAZBCA4WARS2
         SHHaBJStjAcM+TCVw9Qn0t3jWulHCx3rEjr173r6+lIUUdxnWtqdDguE0senQaBY+h5V
         0D6IKhlLgw864dKilPn00R9ANuIqfN58Yctn24poQ8aEdSHvJ0uGx8nLJpygmAd+wOIr
         WlwCL0PmvXuan6ef9Jxg0x9CF46ImmnyaUdTQZL2RZc/o6NkrCg1PQK+VCWm0KQgn2w0
         g6vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759738033; x=1760342833;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4qerrj6UX/Z0xW9m5oFGqvhu+d9Lea7yfQjzYQpDbWQ=;
        b=Mn3gQlDO3yK2wl+kCu1UzDZkscA9+QbhOtnGpdGLGf5WA0OmV2HJMn3Yi6HsKZ2VYN
         J2WgKClVwVJgEVSPDkOppekTrnQTb8lQa1K0pU5jK/Y89kTsjWBxm4bTX1bmWL4kZzde
         gMf/Mj0Og9t6xJHZXLM4b//ygmn7mF55NJ4LLb57PjXWlVNgWGjEEBN5qs5/QNacxTbL
         h24fssrxDgNEDd0nUJmxMz4bNKUl4d1FL8AV/xN7kzMyjY13KnuKn7ui1rLQuv9O/dlm
         86h49763XN0nOvP7Mm6I4T0Eb7QTcnpZE+3xSlJ9p5rOs4AIPmNyYR10qWfdHVjAbwqi
         kl3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUJuC07gvMdmzrLzImijkqlPFukFaxvCxH3YSPOsWCExLKv7uYifkGZ5n1CfoiBrn0O2gYf6LD9A42aJsg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoY+HK85W80Rb3gGzRam8963vkUNahrCSLS7qEehazY7aCJf7+
	BGywON/W0BrQDtk7hQnmqKpdKOPJ4A175FTo6T+xKsVPBxX73bxNToJ0tCUA9sjiG9g=
X-Gm-Gg: ASbGncs8v1waus6XXQgGDGCdk0g6+GCU1yAteG5Gy2uiia4yBY9lhMZTHxwg5nhr9Np
	uJuq7rMIauBoZm0SX3w5jEsYCZweUvIQ6UQtvAkOdslVCWfFxDeD/X8QrX0dNMSvXYdgDgKg1+a
	6MLvUV1/Gxf8+mDcKKQ3zB7y+Y8hOG2p4ydX+bUaBa+veRhbh+I6NO0kJ/lS2OwoUg+2K53UhgT
	gfbpwdvPivTRMAjMHtHWNtAfYwk44FFzY6CRAHSsDcPDJuxLUKS3xZlPtKj9mg32RSILJZ8FTnc
	TeAD9Yjo0WLDHXxlSUvyyl3UASoO3ygyISOVUpZkZJgaL4YzGxpzAS3+9iFemR56X81qFgYNYhN
	4KbpiJSjGEyGUeRpku8r9JJPSzPlwd4EEvRi0xQsbZpGR6gBKVje/JVrSH9TM3J6x1BifBJVS3c
	9OTmvgsnegKnfAbnn0mxz3MPjWxO6IcUg5T55xjoo0
X-Google-Smtp-Source: AGHT+IHPnvEx2+1A8spGyxDZCYqGJPXGgpZv7W3X/UPXBelvQzXyrYlDdDiI9fhuch4s1Ysd9y+b0A==
X-Received: by 2002:a17:907:86ab:b0:b47:c1d9:51c9 with SMTP id a640c23a62f3a-b49c3f7d31emr1499754266b.62.1759738033192;
        Mon, 06 Oct 2025 01:07:13 -0700 (PDT)
Received: from puffmais2.c.googlers.com (224.138.204.35.bc.googleusercontent.com. [35.204.138.224])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b4869b4f1d1sm1073772766b.71.2025.10.06.01.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 01:07:12 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Mon, 06 Oct 2025 09:07:12 +0100
Subject: [PATCH] phy: exynos5-usbdrd: fix clock prepare imbalance
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251006-gs101-usb-phy-clk-imbalance-v1-1-205b206126cf@linaro.org>
X-B4-Tracking: v=1; b=H4sIAK9442gC/x3MwQqDMAwA0F+RnA00Za2wXxEPbc006Ko0bCjiv
 6/s+C7vAuUirPBsLij8FZUtV1DbQJpDnhhlrAZrrCNjPE5KhvCjEff5xLQuKO8Y1pATo7ccH9x
 5Gp2DOuyFX3L893647x9CN6EgbQAAAA==
X-Change-ID: 20251006-gs101-usb-phy-clk-imbalance-62eb4e761d55
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-phy@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

Commit f4fb9c4d7f94 ("phy: exynos5-usbdrd: allow DWC3 runtime suspend
with UDC bound (E850+)") incorrectly added clk_bulk_disable() as the
inverse of clk_bulk_prepare_enable() while it should have of course
used clk_bulk_disable_unprepare(). This means incorrect reference
counts to the CMU driver remain.

Update the code accordingly.

Fixes: f4fb9c4d7f94 ("phy: exynos5-usbdrd: allow DWC3 runtime suspend with UDC bound (E850+)")
CC: stable@vger.kernel.org
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/phy/samsung/phy-exynos5-usbdrd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/samsung/phy-exynos5-usbdrd.c b/drivers/phy/samsung/phy-exynos5-usbdrd.c
index a88ba95bdc8f539dd8d908960ee2079905688622..1c8bf80119f11e2cd2f07c829986908c150688ac 100644
--- a/drivers/phy/samsung/phy-exynos5-usbdrd.c
+++ b/drivers/phy/samsung/phy-exynos5-usbdrd.c
@@ -1823,7 +1823,7 @@ static int exynos5_usbdrd_orien_sw_set(struct typec_switch_dev *sw,
 		phy_drd->orientation = orientation;
 	}
 
-	clk_bulk_disable(phy_drd->drv_data->n_clks, phy_drd->clks);
+	clk_bulk_disable_unprepare(phy_drd->drv_data->n_clks, phy_drd->clks);
 
 	return 0;
 }

---
base-commit: 3b9b1f8df454caa453c7fb07689064edb2eda90a
change-id: 20251006-gs101-usb-phy-clk-imbalance-62eb4e761d55

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>


