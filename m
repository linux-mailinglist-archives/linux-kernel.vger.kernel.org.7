Return-Path: <linux-kernel+bounces-784959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8085EB343E5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A71801886F05
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 14:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F1130499C;
	Mon, 25 Aug 2025 14:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ngO3Vd07"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8660A2FCC17
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756132035; cv=none; b=Vf+HCGvJY8SV7ncTgBoavgbEOGLNs+1uTHVOiGVPY5orw7wXWXdHyLsj3fVyA5CcNOFDIAe+wGSCPutaF+BmIIhMdKZLUVNtF0DvB8TCQ3gq5q99VcZwegzREW358zf8hAn1tYBWAVyDhzc1xiYl4WsH7xRY6Gp/2gCgHmQ5pww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756132035; c=relaxed/simple;
	bh=72WOcl72YOlZwt+/CKTosZbQzCnfjCTjpwRm9zwOmLc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fywmo4n5DWsWdYWTqSbC95zvMShqXxmMzweKpmmcYI9jaM1J1VF12Pe8qd0unlXNSYHz5kMCs6Hm2UYWizqPKp1PtliovYKhEcqf+vsQAZiGl7FZpvnrKTi5vwCRgPZQp9bVsK1O3OmcaJgjf+VJic5DLMdm3QS9FoKW3g4e8Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ngO3Vd07; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45a1b0bde14so24075145e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 07:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1756132030; x=1756736830; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xRqhnX04LSAiYdBNDlTGLugmcAxHcjqdN/6E4HSJk+A=;
        b=ngO3Vd07p8YnksEQNB5GsYMzc6Zee0Pf8MKA34nWuum+2k0KpX+HzIqstkJI5bXSiQ
         lDhDwPxhKa0sn7Jkmd4i5ZRAxZm7Pot5bmSMdpH/3c5aczmXjyne7l7EdOTRCiO9acwC
         Wjn+PnsjeNs1y46GF1qV/vwsdplUFPT4aVoL3T+O1sHTTCPtWVZQbfFgsNumbcIqXMR3
         xPUCF04ZWIbs1gInBniC6ivGskZYb/qoviiGUf/j9rh/RNFRPZVFNPgOibu2+Qcce+nu
         yyJ7Cc7nJ2bsAT46+eHA/nuFu6gnocqfff0jF5+nkzFv3xeLwLLQMKZFDLAtKwkgzP2W
         J6QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756132030; x=1756736830;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xRqhnX04LSAiYdBNDlTGLugmcAxHcjqdN/6E4HSJk+A=;
        b=FlXqzGClvY9JvKVHyCJ7/8lHjtWcanY6MwLFAHkqUR6eYkwFswLc2FV49+4vckwiJx
         WnbjFqyddOc0haU2VVuYQmzct/9otTlJtlTiOj5e8jVoVFGjkq2rxXtFANYaRk+O16u5
         fFPJAYKKUZCUVDJDc36BFpgdhV53PGJuNnGimvSe8bDY4c3fdn075npcCiHSxcyiCCyx
         hnBquiQGv8gCnP38mtdTLTD91KlJdNdcetkvsognE1K66YCsuEYwRNItXgkiFKEu7BTL
         Q/Aeq1WE7Pmc6ZcdDuwEEJPiRchLz2cmZcssfCMRGnVRD3Q7s+JjhRSt92zzGMkH/l1S
         UC3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWoaNtmK7f5+VXGBeKApnNqeCgSI2S6LN0osfHey4EWeTMm6cY/XTHt62wmSKiXBVGQITk17qM3KbxxZfA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXITMfzpNsHf0CIumRJeSGRhlB5MnB67pkJOukji6G54zvnnJN
	HF0tpS98nywDQCmY3W9pJWO0QloGDcH8eeAVK0jNT/39lMKtx8ah6ZoSG4H3KOZ9OMM=
X-Gm-Gg: ASbGncvNXGfsQr7DONSOXyMBClFyXbCWxTxYshS/JUXwH+KjUrmSClSWM1et5QlZ2JX
	MZGphNQf590ddPJaZNMpd6usJ9MVy9JJvr7W9uExuwx4slHqnFlourHBllyiWPYMqz16RfAHpsy
	vXVPyCrjXM4qjunnLMEYDu5qg//gNkYJPNMAxs3GbwcqgDQjbSQ6Qdrmjf4hzUXFq5JHjzenkHS
	tkZPzDrJ9O6yHvIB03NADcLEqfthmMVGdu8M9CsjqDyCOQI3gZmX1fe3pefwRw2z+txsykdHPZn
	LpmVE/K/Oip99GTGuOaBbKTKD6KtIPSC8MsWhKvTaaddUsb1U61Kbl1262L31867GfEqTS86mF5
	ZVYD0gjESko9dazy8TiCbRJwl57gumpZXgxlgmjnrDdOunU0=
X-Google-Smtp-Source: AGHT+IFiPKoRqUt+ns9QGMzAHG5ADHsWD9oCSqbjBX7AALemd/YQHEFsuSaB7N7pDSlpI8XFCAMjJA==
X-Received: by 2002:a05:6000:288a:b0:3c3:f134:28ba with SMTP id ffacd0b85a97d-3c5db2dcc73mr10078522f8f.28.1756132030376;
        Mon, 25 Aug 2025 07:27:10 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:b261:baab:ed3d:3cb6])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3c70e4b9e1fsm12634462f8f.14.2025.08.25.07.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 07:27:10 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Mon, 25 Aug 2025 16:26:31 +0200
Subject: [PATCH v2 06/12] clk: amlogic: drop CLK_SET_RATE_PARENT from
 peripheral clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-meson-clk-cleanup-24-v2-6-0f402f01e117@baylibre.com>
References: <20250825-meson-clk-cleanup-24-v2-0-0f402f01e117@baylibre.com>
In-Reply-To: <20250825-meson-clk-cleanup-24-v2-0-0f402f01e117@baylibre.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1121; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=72WOcl72YOlZwt+/CKTosZbQzCnfjCTjpwRm9zwOmLc=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBorHKzmtWoqm6bakWO4aKPSmFt40T0qw2eFXNA3
 VSI6WqYcXuJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCaKxyswAKCRDm/A8cN/La
 hdhKD/kBP+rn+onWFFONaftlxYdK3A/70krVdI9E8Ed4u2qVKwNTK8gYdu+FC++MQR3SyZUdB61
 jq56+0ekWz28V2fZ8FVwaH74fz4eoXQ3Zgme4vQUXSMw25zClzqCEdekFweiMZAkJjXhsrfC0so
 5SrtlSz7jU/EIIW9TTll7tly7/cVkiWdoPF0tBj6y2Y3GOy9+sYhx/CWCQUYvcNvbqIMKQ+oUn0
 NajUZsntJ4TkzY0REthSO/alUHbltx9JzK9mC7O/H9d4fdMm7RDm6YKq+qywCwU5N0uDwmUUmz9
 /dERanMgbXxJF+H/DFcgYrxYpl6oXoXVmb+mbHbXswsikTfoFRjpbj3InOl356uuRYqhhm4nDUo
 I9yJfXxWJkKpUNlYi72srABYcdjCC7RCouxjKNBDnZkDeEABMrx+n8V18+qAgStQlbGEc5HNVxf
 7EjAm+DfazEypaXlfLNuTFr5bXJOBgBDcRxFMXNn3CY709MnOhv+sQF2YECpppMZ5s8rBDu7oQC
 uN499gfY9WIKPtzkgmoIYCjaEVgizqzKNXpAgY4bFv9Plyo1rx8yS01hbj8tO7V6VpCF0SOKZWA
 uGG661IS0XryE9SfHYJJo2nwiOOP8qoNRti+7sL9KCjjkpfqr8GD57B7fvW4nQJAhcy1p9ZMT4F
 nmTT04JV8y9D3dw==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

On Amlogic SoCs, the rate of a peripheral clock should not be changed,
let alone the rate of the parent PLL.

These clocks are meant to be used as provided by the parent PLL. Changing
the rate would be dangerous and would likely break a lot of devices running
from the same PLL.

Don't propagate any rate change request that may come from these clocks and
drop the corresponding flag.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/clk/meson/meson-clkc-utils.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/meson/meson-clkc-utils.h b/drivers/clk/meson/meson-clkc-utils.h
index 0c228a6723bb2bddc0b9a4f92515f05850a5613a..3e1fb7efe6da1f5d8e55993541d12d40464a47f5 100644
--- a/drivers/clk/meson/meson-clkc-utils.h
+++ b/drivers/clk/meson/meson-clkc-utils.h
@@ -38,7 +38,7 @@ struct clk_regmap _name = {						\
 		.ops = _ops,						\
 		.parent_hws = (const struct clk_hw *[]) { _pname },	\
 		.num_parents = 1,					\
-		.flags = (CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED),	\
+		.flags = CLK_IGNORE_UNUSED,				\
 	},								\
 }
 

-- 
2.47.2


