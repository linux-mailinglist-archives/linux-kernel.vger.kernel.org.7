Return-Path: <linux-kernel+bounces-813561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9183B54781
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 11:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6F66461FA7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 09:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA63A2D7D2F;
	Fri, 12 Sep 2025 09:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EGyzpvQi"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBE028643C
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 09:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757669059; cv=none; b=IKvzkcNs+o/M0MTkOZYyg/3lyyaj9AuuhQOar0XWIZ+u0Cjdtb2tH0RwS4nqsBc2nLjLFpepiGwu8GSQQko0uXulwQA1bppDNCzoXF8qShP/Vo2JUvIF0s0BQf4D86KB6zWUviwPw3BDQYf6wPwSCHeQ5IiAirDTXJWNA0WS+CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757669059; c=relaxed/simple;
	bh=tRJzunUVe2K3c4/6UwQXO9iXv15BUdIvNnjbOzjw+oI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kWgi4k5fB9A21xCWqKN3aeNY0PImTGGekNaC5G0V5kSv9mo8xAdXrdrXJqZ5FnKZD3x4mhXK8iQp1rs+kvkTA+D/llGTTxjYVCAMccM6IJRWiyEXHlMSZvfys/iKZIzLwXrZe2QUGz3ReZTwAbfUEPVIBrn+dvAEFFJ9/Z59ciA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EGyzpvQi; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45a1b0ce15fso2971135e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 02:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757669054; x=1758273854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FOviwQVOZASYbKzQVeCxPKzOJy49KCwq9xAVTlkhfD0=;
        b=EGyzpvQimNSq5Y1cIanyFi8HtrkHB3RIIv/OLb60Hxn5mQJ/vWrcBnNlyb6bwNuBHD
         0M0Ehv4XplEqS7Xme5MKZi0KqN++B3PeGereHGeXL8Dd1HzQN5UclJM9UxXrzqXD7IpS
         QVSEqVa+yt4lh5G5YM2R/BmJ1+n7qKSJpNEj/O/zg5ZyMqXMMD2y76MFmv1Iwq3gBHPg
         8kG1bSVrSRJ4H2sDbbT7rdumzuo1uvsKRKDvccOKvjXYAaS5dnj0tYFMYxUq66RJXGzS
         OsnryTDUIt8Wnnq+HfHOlGdPZCRABn+9BHUxIkHin4yo40jzuArUd0y+qJZNIC3k3V1U
         44hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757669054; x=1758273854;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FOviwQVOZASYbKzQVeCxPKzOJy49KCwq9xAVTlkhfD0=;
        b=MOT33adC9Bi3MeLyBHhJqtALo577F7pO1o3iyjRdgweeelNvKEqc1lqU5bFRXjNbXh
         /B0NYdKvWkahl6pqegNYxCcA/egZGZjmMUKnPLe2TTPOmL85AEtbR4uj3ba2WJPnBpol
         NhwRBAYJBcIXVd8mE/mEyZ6ZzFRlwGEZGfeyCnDlUV7vC5PMH25I7zghc/FwRTwlT/E3
         9UP0NDgaX56KKcpaz+g/N0RDhFlT6LMDYcEchYEZWQXfxEPPdJFmZuJas9qqoZmZVhc3
         BeNRIfS2J3L6NWWc3AycPWlcDkQmo7uS34/qYZgrFTxhBQL/NF0DKAiGozzuo+Rd0MAo
         OYDA==
X-Forwarded-Encrypted: i=1; AJvYcCVV+NIqG6Ew2Oun7lY82VrxwSdfJiEouKJzp2jcPi8Q3JsM1QG0eqqLdSTQGNUttGfmmZ/7pM9JdpDmy/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBmNO2PTywQhgxMxmnfxtNQ8/4jorHNTclBY5R9gO6KVzPePfT
	/a5oMsNhkTTI/DvLJmFKtRVPfpy/9wEd1lkN/6ue8a1H2YVXohTD/MpLcu9Cxm9byP7J9qiCvT3
	nQFcQ
X-Gm-Gg: ASbGncuuvB0rIjbatrqLwpmCWYFSqZaUMdtPwMxr+baqTE0f6H3KhjecT0yxfkL8U9l
	UZeY93nZKMgD+t45xdzl4hubWvcMf+NsXep8FS+kqIg+5vpXmDTZaNQLIdCq8kNoqcVppmZN9iJ
	a6bVRrpS5Mj18bG6Vn431CyqPcd+Z2QXFgM51cgmd705FxYPuHtcA4YkI0q4CbGi/fRSdOOnB+H
	TZy5XOtpSxDk0+0DtgDlrS+O+m6w4BtnQxNoaCTmmGnu8XsNmt2ajiKAk5Lwb2FYVNXMAngg6db
	JKmD1b+G2chLjV7NhoFUShfrvNnzUOQ+869WazZfVF98a0uTNFis2nbaeC5h8h33cZC//lt+aZ9
	/3nP4loqpR19wFPFvMoRfLniouJKCdLJh8PUhDqpQx4WY
X-Google-Smtp-Source: AGHT+IF2RKjPHU5PyyMu6nXLRqroWat3tSIrw2IuPNtUNZFe81YtcX1shc8aVwj2VyT1I6rhWLSpow==
X-Received: by 2002:a05:600c:4691:b0:459:dfa8:b866 with SMTP id 5b1f17b1804b1-45f214afb6dmr12047775e9.2.1757669053738;
        Fri, 12 Sep 2025 02:24:13 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e015ad780sm29696035e9.10.2025.09.12.02.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 02:24:13 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] gpio: of: Simplify printks with pOF format
Date: Fri, 12 Sep 2025 11:24:10 +0200
Message-ID: <20250912092409.162426-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2855; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=tRJzunUVe2K3c4/6UwQXO9iXv15BUdIvNnjbOzjw+oI=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBow+a5cIPMku6YiL8z9OgIg+yldDDyqIzmeH9cC
 GJ+vyRmeBSJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaMPmuQAKCRDBN2bmhouD
 15oLD/9Vd4aatYqHVI+A/qBGNkv0k7CR9r+TT0RPFwYSBCvP/OVRLaG3QpPCl+5s5USMX3amPK3
 lBzwZ7bOBJYBoC02q0GV1evQJUO9qvoErzm6jLlKs1F//UJEjZef4iVu/y1YV6ah6A4GTVfPEfm
 ORLtAIqksjmI7bQ6tiWUW+z4UXROAzbf9w3TCsNKXI+ARdwv/3AczExXtVSrTd53ky4oooHGL4Q
 otjZe74jWZjYJ6S8eKxzkLUuEP5c8Xd3k7gU+w8XswafssszqNnSOXPgtDcMwuSQVABxphMQVR+
 DLO5urLYI2SuxAWlN9r4IkRRQjMJoodWYzQLrqoLNn8B20G1aLSPzENyQmOjOn/DEgJFaJ+qS9F
 WtWdx6QxGWGKRhTG70CbnHegjfkNPp+ldZEbOqx02c4y8PoYq6csaPHXzMZ0Q1oKscVTQ6BKq7D
 41gXOU6MhBEVCM9DxCMy0VgWaHoZsefybUvwYdHdacAs1jNmuRessEgWdII/UjGJkj6IT4TYseE
 v0k8K9Z1QQRXfIYLF1F739Ar2WX2vZBSMJYpTONdgYArCknQsQMxDfWXpx0eh3uQFQGrhRIKL4n
 ObcMi4UiCpsOqKoXWJ+aI6Um1eZ2OW/m/J7zB/2zjLNzztDCA1SRwgXJb+tZLe2NvGtAqCcSg46 kG75Q69AXQns6gg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

Print full device node name with %pOF format, so the code will be a bit
simpler.  Code already uses pOF in other places, so this also unifies
with the rest.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/gpio/gpiolib-of.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
index 37ab78243fab..bf17658623b9 100644
--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -160,14 +160,12 @@ static void of_gpio_quirk_polarity(const struct device_node *np,
 {
 	if (active_high) {
 		if (*flags & OF_GPIO_ACTIVE_LOW) {
-			pr_warn("%s GPIO handle specifies active low - ignored\n",
-				of_node_full_name(np));
+			pr_warn("%pOF GPIO handle specifies active low - ignored\n", np);
 			*flags &= ~OF_GPIO_ACTIVE_LOW;
 		}
 	} else {
 		if (!(*flags & OF_GPIO_ACTIVE_LOW))
-			pr_info("%s enforce active low on GPIO handle\n",
-				of_node_full_name(np));
+			pr_info("%pOF enforce active low on GPIO handle\n", np);
 		*flags |= OF_GPIO_ACTIVE_LOW;
 	}
 }
@@ -347,8 +345,8 @@ static void of_gpio_flags_quirks(const struct device_node *np,
 	    of_device_is_compatible(np, "reg-fixed-voltage") &&
 	    of_property_read_bool(np, "gpio-open-drain")) {
 		*flags |= (OF_GPIO_SINGLE_ENDED | OF_GPIO_OPEN_DRAIN);
-		pr_info("%s uses legacy open drain flag - update the DTS if you can\n",
-			of_node_full_name(np));
+		pr_info("%pOF uses legacy open drain flag - update the DTS if you can\n",
+			np);
 	}
 
 	/*
@@ -625,8 +623,8 @@ static struct gpio_desc *of_find_gpio_rename(struct device_node *np,
 		legacy_id = gpios[i].legacy_id ?: gpios[i].con_id;
 		desc = of_get_named_gpiod_flags(np, legacy_id, idx, of_flags);
 		if (!gpiod_not_found(desc)) {
-			pr_info("%s uses legacy gpio name '%s' instead of '%s-gpios'\n",
-				of_node_full_name(np), legacy_id, con_id);
+			pr_info("%pOF uses legacy gpio name '%s' instead of '%s-gpios'\n",
+				np, legacy_id, con_id);
 			return desc;
 		}
 	}
@@ -660,8 +658,8 @@ static struct gpio_desc *of_find_mt2701_gpio(struct device_node *np,
 
 	desc = of_get_named_gpiod_flags(np, legacy_id, 0, of_flags);
 	if (!gpiod_not_found(desc))
-		pr_info("%s is using legacy gpio name '%s' instead of '%s-gpios'\n",
-			of_node_full_name(np), legacy_id, con_id);
+		pr_info("%pOF is using legacy gpio name '%s' instead of '%s-gpios'\n",
+			np, legacy_id, con_id);
 
 	return desc;
 }
@@ -687,7 +685,7 @@ static struct gpio_desc *of_find_trigger_gpio(struct device_node *np,
 
 	desc = of_get_named_gpiod_flags(np, con_id, idx, of_flags);
 	if (!gpiod_not_found(desc))
-		pr_debug("%s is used as a trigger\n", of_node_full_name(np));
+		pr_debug("%pOF is used as a trigger\n", np);
 
 	return desc;
 }
-- 
2.48.1


