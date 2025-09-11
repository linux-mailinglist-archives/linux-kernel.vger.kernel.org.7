Return-Path: <linux-kernel+bounces-812722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE0BB53BD8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 20:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89C6A5A11F7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 18:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66EB82DC79E;
	Thu, 11 Sep 2025 18:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l/tMESuH"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F632DC777
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 18:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757616460; cv=none; b=MijJB5o1WpA9Posh1gOoG1J4i7mcbGJo07T/KnTCHxyyH8IKHSHEO/VVNOlMNQqwQ9QujoqEdkN28NnVL6vSm5hkljOIWXahVIs5vAoHTOlSrWxSiseTV0Libtwmq0T3plL/FCPzhse5SJp8N0HDr4vRNh5zryVu7Kji6ES7zJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757616460; c=relaxed/simple;
	bh=3M9K3F1kTJYmrAesnwnHviXjE3PWS9elA9lI7mW4vXw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D6W/wagsO7M3fFtYeGRirGh0s67cYUG25za2SuWfZCKdkEC1iuVnUSFiG6eesdJU4TNFpt+nAtlW7gquRv6SViAr5DIy6iqsSbsyQgbeN+dhqFkz1WsHcMEdGS88fGmVYmpgoaY0bevMRZN4rqyPUN1KvvLb5tG/4ti+HoZBYow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l/tMESuH; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3d5526596c8so35835f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 11:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757616457; x=1758221257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W2UE2EJKPpq1S9gnJdsu0dJ1Z4DfGYOoCX7LvS+GczM=;
        b=l/tMESuHg8zfuk/bnBqsyeu9ngdG8Gy6pbn3vFrO7Y/ti4htrfKf2TJMXCKDptskWQ
         SdWNNJ3RH4y96CwdrSnXgc9zIDz3jOGrCe0yVgJvPBklUWult9aPWX/iYJOnFrV0pebQ
         z3qgQsN33B07X9+KKwDjwVF99hAU5fpDs+7XV6vd1L2U6jBMmurFOmLpnBOpwQdqmrd/
         fvDNA8yi4N3PdJyDS1IIOa+TK4um9kEih7tlrL1Zvm2fGWA5VZeKEoDNZG/Yi+UmBOQ/
         DY8US42C+W7dSC6JSnYX4pg97R1vJUGrjLk4MzH/ikqKly33lcQBJIFbH3Mv89/H7cZ4
         kfug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757616457; x=1758221257;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W2UE2EJKPpq1S9gnJdsu0dJ1Z4DfGYOoCX7LvS+GczM=;
        b=Yoih8dBMMiCka9HPycYabSGWDTQk7DWMiUQtLLXIhC8S/k/RKMBUzdrnnsHvzNTpCm
         nftsUOr21IG6TW2eErEuBKL68DImeFx16EHVtfNlgU944ZOc7d1NiDBAa9S4p1vGD0gM
         j1DPlx9gpPaSKXIbi0Sx+rh4QI7G5q8SIeCRbFUvxXcAqV622hY2R0uw1iLbuw6tqxuP
         JXcq09xdS2VFxMjQRMV1bLiPqqK0J0Yipx01erdTh8LFH4ZrLH0lt+N/SIfyKDLS8Amt
         BBEHjly/54TuE/t+pyI7btxuuOVYxGZXG/BFbtcYuurJ6P50yESttA7fkAFGR0fHF6h7
         lixQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBUc9h53D2TwcJMyM6jBBBffIL3RxECR+LH5aUQt1GgQqM0s0LynwgdarEy1VA8bDD11uAzeGCYvbONoo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWKpbNLLBDI5bBsjiBY5YTbMF6z1jYDVBNpi8h3uZy4xdnoNTK
	P+dns2eayIF43BqU9S5okq9nKy3K1/hSUCKz+ktjjmPO9OIwKflO5A8y5zyTkgfNlG5y2G48tDE
	RznTs
X-Gm-Gg: ASbGncsIIBUGRMI1QQG5PrudNQoQScXigoET3l+UFm9kTb8NU4oUcCkKI4m0kXv4Fzs
	UdCZQldLRSSIDzy6Hc1c7+Irjw7jVQ8wjlA2xz74ejf8zcWj2V5tijaS/2xrjd9dYPAzDlKVhWb
	qNUtZCNXXJMJ9M324ijgK5nbnGMa5PL6ZuAUdt0oawuRcd28GKRrPNqJr3rBWW6JGb2V8kQTvRp
	7hxs1wHiYXZh8GD6RDRSAKx2YZZeWJKhaK/fbrsVI7W/7sqM/kBQ4R4YXU/MID+lqPexlqbEshQ
	LnrTp0IH+xoj26yH19V9R/Lv1s30owSi5BPK+JaOyLwGDx/oTvmIxdb87EXz/sBF5K3GIyXGdv8
	Pa3goF01WcF4kkfBZ5oJXVGlLUtYksIC43GnAnIY9YH8Z
X-Google-Smtp-Source: AGHT+IFUaxkecG3V9o6+bVPeZDWAqajmD00QZvBD8CYcgBRH3e9Vfm6uVKqxAjJUMo1/Cyhpr4sgzg==
X-Received: by 2002:a05:6000:4023:b0:3e0:2a1b:7b07 with SMTP id ffacd0b85a97d-3e765797d70mr178766f8f.3.1757616457114;
        Thu, 11 Sep 2025 11:47:37 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e760786cddsm3562001f8f.14.2025.09.11.11.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 11:47:36 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	cocci@inria.fr,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH RESEND] coccinelle: platform_no_drv_owner: Handle also built-in drivers
Date: Thu, 11 Sep 2025 20:47:27 +0200
Message-ID: <20250911184726.23154-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1522; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=3M9K3F1kTJYmrAesnwnHviXjE3PWS9elA9lI7mW4vXw=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBowxk/vGxcb5jgZY8zT8BEND0CwtbRzOckZpklU
 FK+TSDrIbiJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaMMZPwAKCRDBN2bmhouD
 18NREACIejZutmdOQHrpyXcdsUsoWqL3HKIhXmLRZthH/fTdLEwPgmsZrl7wBJNHQbBo4lX1icG
 +vqD6mf7aLW2Cc/HC6Ghc9dFv3+9tP3ef9GwHuD62rmZhykBYqixnPuDJvYBbgRoh3IWEEKLt+C
 P+3wRiMj7uzP2Q2ECEjusXQ3kB49EW9A5eRYAm4xYsGXgzz3x8tPafrcJxD4arLVlHcPA/xQkyR
 RAqIbF/xKADBwJqDdXzez+HmTgEKbK8bxLRQbj2cin2iiseNAWMzSD6LAjixduXOjyEHzu+hDBL
 9n7gIDEa9cShB4m7dY4PPF1O8yXgln2759iAYnLQBNNcu4yKTNR1wE5hX1ltB4HInf0dAxvOeny
 GBuM9oBXw4X07HNQlABfug5Hon7t7MbypfKKOyyYBz5I8KVd9zHg+2lX/27P6duuM5Hkb403J4f
 KXb7rNpvb0qTIazYBOTGr4KPVDbVJinlmQGWn0ESCOUHovgZZhTvGXEjo9fkGkomQwhG/A3uWBU
 m0WH85MlHGFJ7Bu1hAA2HwRDd3sRjGyVVkLi4i0A9sOuXXJ7KXjspp6Kd8klRQ4/MwBijHymHL+
 CIM9YMsmVGfgkgcVVZrneAUNxOXnXB9pefyw4R8YGVd1vMipsCtm2WYTipISuTRy1vO3PJNduM0 uUdaXy9qagGQ8Qw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

builtin_platform_driver() and others also use macro
platform_driver_register() which sets the .owner=THIS_MODULE, so extend
the cocci script to detect these as well.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Resend of resend, so I think Julia does not pick up Coccinelle patches.
Andrew or someone from KBuild maintainers, maybe you could grab it?

previouos tries:
https://lore.kernel.org/all/20250104141414.114971-1-krzysztof.kozlowski@linaro.org/
https://lore.kernel.org/all/20250501145810.73031-2-krzysztof.kozlowski@linaro.org/
---
 scripts/coccinelle/api/platform_no_drv_owner.cocci | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/scripts/coccinelle/api/platform_no_drv_owner.cocci b/scripts/coccinelle/api/platform_no_drv_owner.cocci
index 8fa050eeb7e5..5e869858bda8 100644
--- a/scripts/coccinelle/api/platform_no_drv_owner.cocci
+++ b/scripts/coccinelle/api/platform_no_drv_owner.cocci
@@ -10,12 +10,21 @@ virtual org
 virtual report
 
 @match1@
+declarer name builtin_i2c_driver;
+declarer name builtin_platform_driver;
+declarer name builtin_platform_driver_probe;
 declarer name module_i2c_driver;
 declarer name module_platform_driver;
 declarer name module_platform_driver_probe;
 identifier __driver;
 @@
 (
+	builtin_i2c_driver(__driver);
+|
+	builtin_platform_driver(__driver);
+|
+	builtin_platform_driver_probe(__driver, ...);
+|
 	module_i2c_driver(__driver);
 |
 	module_platform_driver(__driver);
-- 
2.48.1


