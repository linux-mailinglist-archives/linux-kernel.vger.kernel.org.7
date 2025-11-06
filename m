Return-Path: <linux-kernel+bounces-889103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE8DC3CBC9
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 18:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D11D24FC9D8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 17:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF94F34DCEE;
	Thu,  6 Nov 2025 17:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="beM6iXGr"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E4F34D4CD
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 17:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762448774; cv=none; b=bchb/UPgwdcX2qNQByOuWqnuc/VFGCHVlhVBlP8EwD9x+qXQB1zzI/es6ppiv9XpPENRLORvVttz+qF0q+/JX5f8J2U0c+R7gdzLbXTKe3+ojri73FT3/k7/05wwch4mxB+uZrQBCLSZRTtFSOZgYBYxwQ8UCDIK5BN/zwMqi5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762448774; c=relaxed/simple;
	bh=Ly8zzWDq2H5KxZ3JO5w8PK/DzLvp+XmT9nBrLcr/RRM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U0LYwKj8p9PfT0KgWIR1DyaLYjBWDQojEubvYUgz7o8EtdwlL46telSHKkdfqnQOwAijWKbHoIrJ8uj56CudoaI8ohogholsSYa+7b96hVUFdjUeMg3lOQZIQ1be6A0FbN5TbGFJ0twXSNum9+AVmVEQBb8KGZaudQEucDpeWmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=beM6iXGr; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-640fb887e26so234230a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 09:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762448770; x=1763053570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SiD3EO1rNl1PZIk/GGWVSfbo4R6DA7FH3uGtcXk+fNc=;
        b=beM6iXGryiZi6x8KgRSwPGIT6UxI+yuleUvMYB2ouZbMRGotti0L7CeJJOvgTImMfO
         /gd7oWoEHPQC6fx8D96llTPtjiPeprMPypwFAs3VcOt9WzxG7coCpB0c3xEMRUb62aBK
         6d9cF6akWDL3RV6P9OWBUp1OpeL5aj0wJNr0uW6Zj03Q2Me4YtkqH/wqRNaGBnbHGpvQ
         3hGrij9D/xrHSKvMjXBFU0GFFZMqp8no3bZNAwA3pqaoFn2W23P7HSMRmrNlukcEMS60
         u9Fsg/xNBPUsnC+rReuH0j28QeiRel1xqXIKnkDu03UQRVLCKaBDm9WEla46zHa5D7S6
         5mjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762448770; x=1763053570;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SiD3EO1rNl1PZIk/GGWVSfbo4R6DA7FH3uGtcXk+fNc=;
        b=NMjT7qC2HYWaiE2Gnm3uUTTcEn/a0aab83Ue4GhA3SlIv2MwzbRZAFgszv4/830lwU
         CWpxqg/El3SwMz/crL3dPe+V2gZDsYGRvbwqXhq7gGQFFA+fM+urvRWAdGFbz9GmE6ha
         +wDff7es7k2Kd6eu6iIY8b+BUvVJ+0Y88YdWXrRd8qHQ+pRwhrwfwUZuSos4hQIZ9cbY
         gSpppGFTQoo2Jfy+XIojnNwJGoiJIQeUs+5H7TZfaUsE4Y1mBxHNZC1svbwbHIKPJdxO
         M7CU2fhS11M8OAhLiRxulSdR7l25j01qpv3XUI68pLOO+OG9TeGBjiASk+pVxI7IZoMO
         AQ3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUyG2nPy6j8yp3G9VZ8TGm9aPoyyasIPrx1QXyDzKUV2ms6dleX+XcwUFXP4pjZNMEAKxf+2OEM/sBr32Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNBGRUgRthm287FyDQy9hqB6MnUbzQDNPAKU2w00z6DEHplSCY
	csyXLTSpDNxFhcYl+cTfChLPJZj5LjvHRiakufKCUtbiOMJJr3XmvIBf1/zeAL3YVT4=
X-Gm-Gg: ASbGnct9KRMNFxXvji6j9xPw88LzyRf/BbgP6Wh3M9DtnQsBnifa+zQdpBmyE6stUqm
	Pr/1gyCj8nHNrTaCARQ5cNxkF3/RAejPGGGPBEv7eFKNRlh3kzTNoShd+xNVOYZDj+5PNUVhiba
	r/pP3k7itOEe/PEhY9Gq+f/uGEed52QGgjGvNiCNgwBKaUPS8p1kIfMnnS+5Q22hZqRow9s7pIv
	6R+Me0VXoZGqWjYCHvao2uXbiwhGlECZaN3QZ0dxVlW+vpmswEcs0/IEWc38RDeEBoFj2Nx7v6J
	wQfPYkRMajP2UE4SSwKV613kFEFQqvPzqyDHJ2Hmld1DhS94OiSha0UHp1GlHGBa04+wh5vn0sz
	3qNTdqqUDZRrhghuT58encdtuzvWyS6zReEBiijsa6VE1OWRg1dnnjBpLVrS88+yP+fhoMi5HiY
	ukGAxq3G7B/YbNJ0lp8owPFg==
X-Google-Smtp-Source: AGHT+IGDODSfRoR2BHtZkTmzc88EZHUFY0L8k5fsPa/cX950AkjWDwLIrCB/BW+c3xdPiiHowTZolg==
X-Received: by 2002:a05:6402:268c:b0:62f:3041:c7d4 with SMTP id 4fb4d7f45d1cf-6413f20f99bmr22030a12.7.1762448770423;
        Thu, 06 Nov 2025 09:06:10 -0800 (PST)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f713959sm2302957a12.5.2025.11.06.09.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 09:06:09 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] clk: sprd: sc9860: Simplify with of_device_get_match_data()
Date: Thu,  6 Nov 2025 18:06:08 +0100
Message-ID: <20251106170607.445196-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Driver's probe function matches against driver's of_device_id table,
where each entry has non-NULL match data, so of_match_node() can be
simplified with of_device_get_match_data().

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/clk/sprd/sc9860-clk.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/sprd/sc9860-clk.c b/drivers/clk/sprd/sc9860-clk.c
index cc5ed2dd8267..c106b6422649 100644
--- a/drivers/clk/sprd/sc9860-clk.c
+++ b/drivers/clk/sprd/sc9860-clk.c
@@ -2021,17 +2021,15 @@ MODULE_DEVICE_TABLE(of, sprd_sc9860_clk_ids);
 
 static int sc9860_clk_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *match;
 	const struct sprd_clk_desc *desc;
 	int ret;
 
-	match = of_match_node(sprd_sc9860_clk_ids, pdev->dev.of_node);
-	if (!match) {
-		pr_err("%s: of_match_node() failed", __func__);
+	desc = of_device_get_match_data(&pdev->dev);
+	if (!desc) {
+		pr_err("%s: of_device_get_match_data() failed", __func__);
 		return -ENODEV;
 	}
 
-	desc = match->data;
 	ret = sprd_clk_regmap_init(pdev, desc);
 	if (ret)
 		return ret;
-- 
2.48.1


