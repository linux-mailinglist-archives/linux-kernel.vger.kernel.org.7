Return-Path: <linux-kernel+bounces-798940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FC4B424E0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 17:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A0271899CD3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 15:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0216248F4F;
	Wed,  3 Sep 2025 15:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SWtsPmFf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853491339A4
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 15:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756912565; cv=none; b=S/ZenhZPx0xkp+jkfnevB7tOFZehxkS9J7t2BKrIBtDcDoF3gTosPytXdjJrA1+JacfDfLYrZ9x7ljpu9Hw7cJ3ZWOoNlj6+F6WAoWQWNk0UM/Fw22RrfZDL045mjWolFXVC1URHuTPsKOOO0GSmAIl7Kilz38mxnukwASq0ia4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756912565; c=relaxed/simple;
	bh=f7zeRbtjFE6oZbaxfqDkdxVp3qdgNoSMwDXWIe1dhQQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ea+y21efMRzSTs49p8ok6YfjpNo3VyXs8OffOzvX9JXahhZyLAac+BkLd+YXThf1R5nrw2Uei0pZfVsr2mXFOjL8WH3Wl67kUIliPO79BVvV6+JMiv+pJxjgxN8wbbtEWQr1umXj05OgZ20Ul9CQBjlIy67INDvaR3Van8dAi98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SWtsPmFf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756912562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A4HCy2NL7Blg6ktZUTQG7x2ot9qLktGXqBXqd0E8mS4=;
	b=SWtsPmFfGxADXZPo1A/j/qw67/61PYt3txLvd3zBvH7IhV4tZtvzZT/2dlqTaXL4vhRJ21
	AEGx4kMgHi53+D2eymCsDUSj2drTLn7WM7A2i6esFM21JXrQYdXbwXD6LbJFCnnnoZDD+p
	czHFvzxi5u3WXOFvWHQUR0cZpD7qoaI=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-0zx0lTpfOf6mWADxdDW6aw-1; Wed, 03 Sep 2025 11:15:59 -0400
X-MC-Unique: 0zx0lTpfOf6mWADxdDW6aw-1
X-Mimecast-MFC-AGG-ID: 0zx0lTpfOf6mWADxdDW6aw_1756912557
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-70dfcc58976so103518666d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 08:15:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756912553; x=1757517353;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A4HCy2NL7Blg6ktZUTQG7x2ot9qLktGXqBXqd0E8mS4=;
        b=OqsilR4yRGPwElGMnXOrwk62XfwXXZv85XOmRuaGUezWS72NAzXitCOAyZ/gZUJZy+
         q+pKJQvWmO2EtavTZzsSkyLPLHB/ghq+gYAApVPAOo9k5LoxKZAuKMZqCnYNEQIEVcMN
         RHE0wQXLkESGBflqIF2HPinBnezgcRxem9U5nX1pixcHzHbNgY8heY5FQpWiUOYICeRH
         iryVy74kPPfRIQSEpNnZHCjeN8MtAHGjE5GyCCOwvkJyYHhlYGc0mZw+pU312fZR+uN7
         z6KxtVJJqIgEHR7xS5IMBenCzC4iNRHEaE5Oe+WBjY8RQX+ylapIepIwcebNDMcRKBEP
         rCPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjoXv0vpg/XpzH/CCpp85UhmacVe86EsPNGOgdQwiekU3rXmyuX2BOEd5B4DgQmRgQG6CsMu8Zv+Yyi0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP8AmJ1uEGjmpVnsPF5J4WTDheKD46ad3Nfs7DHGb9SQdroYaS
	ul1mmeFBRiT410bgPHBsZYtUSxF3l3qNOni5sMEwf74Zlz1r1NXZLy2iF9hJ7987JF6QJcgGT9C
	42GsxStoPE36CjFblkFTnfJAmuhc5ykbxaQNvFdhzLagMql+FYedjAZsXX2/sJBBpdjdM2f/atA
	==
X-Gm-Gg: ASbGncu+8loRg9Ye1mhR6QWuDcvNMUBFyoNVsxh07CYf1cpFa0hyJAxIRfa7gmjzt8M
	MSy3MaCichr1MNHBVG79cXulwflQh3lGjvEzVNG5qLYRnZEb+R3UKyIbyVO3H0ABJItdEPNerU8
	+cfAy1LtwfyKH9/AJ7YnVfUTFlma+q2m7yBudMivbeP/sZhOFbsHqmtt95YDa4IDsJomk3AP6Ol
	v6kYnwi2Vbe+rS1wQonTSW0E+BIaUxD1WnHHJiKG3M1eW+RUasYM6gAod8s0JAnvbqMyJ0vPB4i
	m+B6upbdpkvevzmYOiKWI4quQas8/ubJIE573nIoqzrGeqLKGcIeKoo0EY0/moU2fY/gdiA9EGw
	=
X-Received: by 2002:ad4:5ce2:0:b0:71a:5b14:3cbe with SMTP id 6a1803df08f44-71a5b143fe4mr120710346d6.27.1756912552838;
        Wed, 03 Sep 2025 08:15:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFlQ9BdrI0T15lHuajgK3Ofx/Mn+DHDA/1mjdjP2xlPN5vgFUBDe96IRrxXSlBhDZltKM9h5g==
X-Received: by 2002:a0c:f118:0:b0:722:5704:daf6 with SMTP id 6a1803df08f44-7225704dbc7mr42110476d6.39.1756912541147;
        Wed, 03 Sep 2025 08:15:41 -0700 (PDT)
Received: from [10.12.114.224] ([2600:382:850c:786a:ff8e:13a:e47c:3472])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720ac16de16sm30827706d6.3.2025.09.03.08.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 08:15:39 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Wed, 03 Sep 2025 11:15:07 -0400
Subject: [PATCH v2 6/6] clk: tegra: tegra210-emc: convert from round_rate()
 to determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-clk-tegra-round-rate-v2-v2-6-3126d321d4e4@redhat.com>
References: <20250903-clk-tegra-round-rate-v2-v2-0-3126d321d4e4@redhat.com>
In-Reply-To: <20250903-clk-tegra-round-rate-v2-v2-0-3126d321d4e4@redhat.com>
To: Peter De Schrijver <pdeschrijver@nvidia.com>, 
 Prashant Gaikwad <pgaikwad@nvidia.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756912523; l=2321;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=f7zeRbtjFE6oZbaxfqDkdxVp3qdgNoSMwDXWIe1dhQQ=;
 b=KqIQakTxpJPpr1rcYh3sziesySXJxjBrI6+0TTX75xgEW8kKgKvFNHcGYKnxBX9/2bRbUKoda
 ZEdPYfU2taXC6VUs1K4llMiSTTFXWFnjCoqsRS44x/u1CUt0bBPlqa0
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

The round_rate() clk ops is deprecated, so migrate this driver from
round_rate() to determine_rate() using the Coccinelle semantic patch
on the cover letter of this series.

Link: https://lore.kernel.org/r/20250710-clk-tegra-round-rate-v1-6-e48ac3df4279@redhat.com
Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/clk/tegra/clk-tegra210-emc.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/tegra/clk-tegra210-emc.c b/drivers/clk/tegra/clk-tegra210-emc.c
index 672ca8c184d2c6e9a7f26c07d036f3359af42bc4..fbf3c894eb56e3e702f0a1f67511463dc9d98643 100644
--- a/drivers/clk/tegra/clk-tegra210-emc.c
+++ b/drivers/clk/tegra/clk-tegra210-emc.c
@@ -86,22 +86,30 @@ static unsigned long tegra210_clk_emc_recalc_rate(struct clk_hw *hw,
 	return DIV_ROUND_UP(parent_rate * 2, div);
 }
 
-static long tegra210_clk_emc_round_rate(struct clk_hw *hw, unsigned long rate,
-					unsigned long *prate)
+static int tegra210_clk_emc_determine_rate(struct clk_hw *hw,
+					   struct clk_rate_request *req)
 {
 	struct tegra210_clk_emc *emc = to_tegra210_clk_emc(hw);
 	struct tegra210_clk_emc_provider *provider = emc->provider;
 	unsigned int i;
 
-	if (!provider || !provider->configs || provider->num_configs == 0)
-		return clk_hw_get_rate(hw);
+	if (!provider || !provider->configs || provider->num_configs == 0) {
+		req->rate = clk_hw_get_rate(hw);
+
+		return 0;
+	}
 
 	for (i = 0; i < provider->num_configs; i++) {
-		if (provider->configs[i].rate >= rate)
-			return provider->configs[i].rate;
+		if (provider->configs[i].rate >= req->rate) {
+			req->rate = provider->configs[i].rate;
+
+			return 0;
+		}
 	}
 
-	return provider->configs[i - 1].rate;
+	req->rate = provider->configs[i - 1].rate;
+
+	return 0;
 }
 
 static struct clk *tegra210_clk_emc_find_parent(struct tegra210_clk_emc *emc,
@@ -259,7 +267,7 @@ static int tegra210_clk_emc_set_rate(struct clk_hw *hw, unsigned long rate,
 static const struct clk_ops tegra210_clk_emc_ops = {
 	.get_parent = tegra210_clk_emc_get_parent,
 	.recalc_rate = tegra210_clk_emc_recalc_rate,
-	.round_rate = tegra210_clk_emc_round_rate,
+	.determine_rate = tegra210_clk_emc_determine_rate,
 	.set_rate = tegra210_clk_emc_set_rate,
 };
 

-- 
2.50.1


