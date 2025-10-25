Return-Path: <linux-kernel+bounces-869765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C0FC08AFA
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 06:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C2193B3203
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 04:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF7C275AE2;
	Sat, 25 Oct 2025 04:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0qv2fnc"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF76A267B9B
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 04:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761366764; cv=none; b=tuD1PDHJHWdTi1QfMsb1VQeT5Jn15GYMapgBrsYuMmu6/Vlk9y/YKDSTSNV94vZ99xwJ8PBAQReYRa9H6aPepTgcROMInPp6B9kd4baSBv2hcMULV3rZVgGQxGJw1WvmyJkpE84zyDM4qmAF3brwAThjVb1h7Z9p/sqiBtKZrZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761366764; c=relaxed/simple;
	bh=JFlSRxXwWBQ3XACpCIXATa+zwXHpyzhtFajoU+nnbIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dUabEoWY86NRzQ1lORKaDjHcJBehz6VbSvQD/Tn1HU26gvipX2D8EOamOIOTw5fU3NmB2EyqPO9EbCHbLDnzqpNVzSiVeAViWDJ01S2zTShTH4Zd2PcIrWgRcsOPO79JBE9sUgs31zo4FATEJs4NhZDGP0YLAYGPDa8hv3lEWMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d0qv2fnc; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3761e5287c9so32387381fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 21:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761366761; x=1761971561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i3+BmyLOtp7xUTMRQtQMY1TWwM+wvGI7ScMcGnjI6fc=;
        b=d0qv2fncNLrQWksm/Kj+aDzfPcFi280b/vHBqmfbPUYAPe9VIHu5mFSd1EnS6qX50A
         bs09pYFYEWVUvj5VtpQzthJUcX4JvPzxQhdc/TBgTZJAXlCajzzZTae6v38fn6JlYcfE
         o2IbEM19U86R1Jp+cECN/C5YpkIfxc/adSehpNUhVTTqezDgsFv5oUTsF2Q8OJIL2CGy
         eEgFHfN/exVu2ahSsDgSBuLIx82sFDXouAsZEYbSkQ0K8oVK9LI72CYEJr8EOlkhnYx/
         e356HZkn09YG0vnHTDnAudvLEZgpTfGS2LG5zTy45NTfu6Wy/vjKwk04ZswuJmjhQd/Q
         cTiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761366761; x=1761971561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i3+BmyLOtp7xUTMRQtQMY1TWwM+wvGI7ScMcGnjI6fc=;
        b=s4c+pmyY+My9sfaZ9sxGJhjT1I3LrSNnaPmZCR9KB7G3LmZGWPhuT2fF+djoqwCECh
         eL1E03Ix8MNMs2qrajmJBBqyNebGOQu1GTgDt6vrr4wf1MCQ+IzBcUfRomTIfQsu5Dm+
         GqzzR68faksArex7am6XXBsEYqdeQWagkF9QMUGHvv81Vc3vIUgRL3xcNyQunv9XcXqh
         StSkdopmBmhzKZyw+WS/pS/oZn0efutM1670XDn38oBrdOBw2e/XEhYAa4wc/J/WEHbX
         Njc/7g345QrvaM6U8fbHZrpIth7GrWmXhtPw7WfpWmrPijzZytKLiH9FtqK0ouCZ2M9h
         9OVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUp9+7Si9VOg8dJr/FpeA+pVHVYNVM5OAqff0riNeEHyuYHaAl5JrccF/TNY89R1zaNpa0GGr1jkxHq41g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV0sS4jhRlRe6/eN//js4z4C7q5BHAhCq9OzClzK40HTx7ZdUS
	v2frMOLqhl+WQyk84i5k0Sn2OG9rGLke+hel8VtSNtXHfIHroRR9+sLW
X-Gm-Gg: ASbGncucaiY8pA+H3n/O7iSXFx1nhCo3FXJMEYN0WcJQ3sl/08/hZazQtsafsOYxP3V
	bdlEBS9U+JHmS5SCpgXE0PEgksPB6qsfXF8IFSCTHIGXUDwvQJba/EULSI7mYhrKhQTHF8tw/BT
	MB+OyvX0ElDkHdrYm6LL/HpUGm6ckQPcGhDNP4BEzvvE+fQx7xsme4U822CS43vujpQsHvRqkol
	Rkr7aCicwKW9N7furNuvZa+HUdUNJGkwnrrErhQl5I1ezFXZxQW0RGpqDj+lTP+I8cAkACKgNUQ
	tr6f0pZIyMh6/2Ip42Ous26aIU9D1lmBy0rYjbGj5Qg/IX2679CviSP38m/vL7N06FpUxXad4if
	dy+WAjBY0tpYL0eKRnh5rm5zPA0+hUixtA8h24fCGGIXqiKFRSdzDw7+KdPRLE4Qqiw==
X-Google-Smtp-Source: AGHT+IEKvrwo7BMcvdLr8sMnPaVHb2OI/tgnv1kSKzQDgd1sc7jso2BrG2SWkbje2QobtPqCs0yKQw==
X-Received: by 2002:a2e:bd17:0:b0:36c:2367:b3c1 with SMTP id 38308e7fff4ca-37797a58f18mr88205231fa.35.1761366760931;
        Fri, 24 Oct 2025 21:32:40 -0700 (PDT)
Received: from junAIR ([176.106.241.81])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-378ee0ca7a0sm3409241fa.33.2025.10.24.21.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 21:32:40 -0700 (PDT)
From: iuncuim <iuncuim@gmail.com>
To: Vasily Khoruzhick <anarsoul@gmail.com>,
	Yangtao Li <tiny.windzz@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: Andre Przywara <andre.przywara@arm.com>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/6] thermal/drivers/sun8i: replace devm_reset_control_get  to devm_reset_control_get_shared_deasserted
Date: Sat, 25 Oct 2025 12:31:26 +0800
Message-ID: <20251025043129.160454-4-iuncuim@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251025043129.160454-1-iuncuim@gmail.com>
References: <20251025043129.160454-1-iuncuim@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mikhail Kalashnikov <iuncuim@gmail.com>

The A523 processor has two temperature controllers, but they share a
common reset line. Make it shared with the shared variant of
devm_reset_control_get(), and also simplify the driver by switching to
devm_reset_control_get_shared_deasserted().

Signed-off-by: Mikhail Kalashnikov <iuncuim@gmail.com>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/thermal/sun8i_thermal.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
index c02c398b0..aa496e1ba 100644
--- a/drivers/thermal/sun8i_thermal.c
+++ b/drivers/thermal/sun8i_thermal.c
@@ -344,11 +344,6 @@ static int sun8i_ths_calibrate(struct ths_device *tmdev)
 	return ret;
 }
 
-static void sun8i_ths_reset_control_assert(void *data)
-{
-	reset_control_assert(data);
-}
-
 static struct regmap *sun8i_ths_get_sram_regmap(struct device_node *node)
 {
 	struct platform_device *sram_pdev;
@@ -391,19 +386,10 @@ static int sun8i_ths_resource_init(struct ths_device *tmdev)
 		return PTR_ERR(tmdev->regmap);
 
 	if (tmdev->chip->has_bus_clk_reset) {
-		tmdev->reset = devm_reset_control_get(dev, NULL);
+		tmdev->reset = devm_reset_control_get_shared_deasserted(dev, NULL);
 		if (IS_ERR(tmdev->reset))
 			return PTR_ERR(tmdev->reset);
 
-		ret = reset_control_deassert(tmdev->reset);
-		if (ret)
-			return ret;
-
-		ret = devm_add_action_or_reset(dev, sun8i_ths_reset_control_assert,
-					       tmdev->reset);
-		if (ret)
-			return ret;
-
 		tmdev->bus_clk = devm_clk_get_enabled(&pdev->dev, "bus");
 		if (IS_ERR(tmdev->bus_clk))
 			return PTR_ERR(tmdev->bus_clk);
-- 
2.51.0


