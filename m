Return-Path: <linux-kernel+bounces-889524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 267E5C3DD4F
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 00:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9F9BB345B14
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 23:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C2D3502BC;
	Thu,  6 Nov 2025 23:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H9IXuxLW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lYyowWFt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1522DF709
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 23:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762471610; cv=none; b=srBEbltMy0iF92EpCoc4PgWNxSU/3gtYnsUsNEdOEWqdqN2RSSqAcO2WEefPuQ1xxJ+MHM1xn6nsJZJwbVpedsKsD2WqBU+CEwfwxpr0LLr7lgTF0M7FawEZ6ebp1pWUMZAN+Z4kbx81x2756T7A2S3wFVLlcPR/sg6JzB/n99k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762471610; c=relaxed/simple;
	bh=N8o/S8JYpE+P94OMt6ofvyUqz51LnCLNCgONjtOPtQk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K+RMQldlLb56/YMjeG/oN7jDkK9IgTTPIE8Cis+lMdrCeqIitFdBymw7lzRH3vjNJa2ccRu8+d8T6o/pnMNQuJfIAHsZqXEWO9g7rabbRmgIc1rl3plWA4a/5RLvQzgteeEPG+CRAjkoxSokuPA99i4Q5VNAy9gsMy1j8mSOpck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H9IXuxLW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lYyowWFt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762471607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=akq4xHfr7o1c6LF1BQGU3I527bH0Z+3rmigIHrwqrio=;
	b=H9IXuxLW2qWZOzujRWilzz7kcv8xReRtaKgJJlDtkuD0hD8nGy6qN3190DjYWFRV8/6coh
	mb494Q7xPxSM3xSJHSuvRu62AMM0f++cIWSFBu1YkBYGBbEGB69gkpW+5OMJGdDlVl2JIX
	a1hklEnJGM9TlmNZxlVJ5Bi7ej3vRNg=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-Puc_LhP0Nu-yML0EY34LKw-1; Thu, 06 Nov 2025 18:26:46 -0500
X-MC-Unique: Puc_LhP0Nu-yML0EY34LKw-1
X-Mimecast-MFC-AGG-ID: Puc_LhP0Nu-yML0EY34LKw_1762471606
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-87fb496e4d1so9026856d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 15:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762471606; x=1763076406; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=akq4xHfr7o1c6LF1BQGU3I527bH0Z+3rmigIHrwqrio=;
        b=lYyowWFttviM/tUT33CbDnBTQM+7UxwEMMEEBYTA1lze6zOkLi9q5VbmeaWDTA6479
         tCTAItm878LZVmHAd9h6GIlcjyIVmw6F/1sHHyQr/UIJ36xZJr8atMTkpKljGQeZA9ND
         APismu2rp+CbvX+J1olVVV/T7lN1Pmu9tS3FPBe/WQtH38RqJQReUDiXMfHDTzBHsT/h
         /WKUPaEaicIEYcwdWVMmHnhpK+qiCZY54VLld0L0ISHH9UegYWwzj5/+coZmYqoazjpe
         0UIAxzu2MZY0nO/DnCdVMYNE8KYKtnB7q9eB8Rs7NhxMURWVoxKsIcqz1wqyxawuEQ8P
         x4MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762471606; x=1763076406;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=akq4xHfr7o1c6LF1BQGU3I527bH0Z+3rmigIHrwqrio=;
        b=Aqt7zCJ/SY6EOBzGzA/D8e3JjWsAZUe6ezlHTBBIoPz6kpOmV/tfxcpdc0YN2ka8Zp
         tNg0Aid6KXQxZT/z6XkBaPClPXOxdDj4cQe7+nysYYkNYnpldhWwhnFxbUwctfQyJV5N
         aaDdc5XaQDsA+8tyjB1WkvutCJ61kFwvX9w5w7cJ5Ya2292XE6zY4iOZ0Y1k7uSDZEF/
         spJhH9qGVBGYLqc8ngFQpbu8Fml1bNilL6CliI3T7gTos20qqSdFsmQo4PCK7Gtak3Zb
         xDh/MKvRYLg+7pl1VQvGFqiQOWZ11LU1MnYZb4a7eqUYvxH2pDO2wGdG8KT8wyOR3rvb
         yQfA==
X-Forwarded-Encrypted: i=1; AJvYcCVyXTJAJyMb3gk9Ipygwe/JR9jQrv5/F8COPerhDKmDCk+zHMnsTKX+xJCT1jg66KT+c+bFyYW+m9obbtY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyWRlVoXF42AJHFxnwukuuddz93P6H/kNo+nmiW959zwovusOY
	uzofI5oPAv00r4vjjNXprbWpkAZaTJS4hp2rjuXrG8RAInSPpFstiKVN2YVhLL+UgA7ttaSekpR
	mv9bQj2jbz4g+Rs0HkYGMPvo2grBAtQMT/5aKmNR30jCaL3pK/Yh4pcr4iTGDoR58eg==
X-Gm-Gg: ASbGncvLrI+ImmylTOrrSncb0GMjyJxQWleldj2fsugnFwXnLAvRDTscCVkjZllJIm/
	EGJAaxP9gMuTAdHs/I3q1k3IHeBArQjMoYj8RkY8/3Vag2+R53ifdbPT/GN20Tf86vc4VWcksqt
	Ryc/+D5Knb7wcxIcG7VKFaLwZxNtK4jZQ3yfa09LfqFNXLJZcO1al5Ev2w2lct+KzVb/fyYHP6c
	NAW1rpq8SKnvcBQfZ2wOSFJreep/KU7WWlrNx0Xg0rwn/ctI5dVp2DkRrQqBpzKdl4zH/yrVLDq
	HwwA12buMNjH651UvmpkIYWvms5mAIqxCa6bAKfif1NgTIADjzSM1On0oWm2aGkRYIc4JVoYtJP
	xYCOKKSetxOzqKwdBZZ8k9w+Op1s0rz1R4rfJ8x+W5w==
X-Received: by 2002:ad4:5ced:0:b0:796:5c30:b079 with SMTP id 6a1803df08f44-8817678d8e7mr19316096d6.43.1762471606048;
        Thu, 06 Nov 2025 15:26:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFHwlRC8CZ2UFXaZBcGupUhAP3gsyq39my6h5pJeWpOeH+fDN/RFDAKGIUl3UBkcMQENq+LCg==
X-Received: by 2002:ad4:5ced:0:b0:796:5c30:b079 with SMTP id 6a1803df08f44-8817678d8e7mr19315736d6.43.1762471605711;
        Thu, 06 Nov 2025 15:26:45 -0800 (PST)
Received: from [10.197.115.224] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88082a3aa91sm27389196d6.56.2025.11.06.15.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 15:26:45 -0800 (PST)
From: Brian Masney <bmasney@redhat.com>
Date: Thu, 06 Nov 2025 18:25:49 -0500
Subject: [PATCH v2 RESEND 3/9] phy: mediatek: phy-mtk-hdmi-mt8173: convert
 from round_rate() to determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-phy-clk-route-rate-v2-resend-v1-3-e2058963bfb1@redhat.com>
References: <20251106-phy-clk-route-rate-v2-resend-v1-0-e2058963bfb1@redhat.com>
In-Reply-To: <20251106-phy-clk-route-rate-v2-resend-v1-0-e2058963bfb1@redhat.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Heiko Stuebner <heiko@sntech.de>, Stephen Boyd <sboyd@kernel.org>, 
 Maxime Ripard <mripard@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1767; i=bmasney@redhat.com;
 s=20250903; h=from:subject:message-id;
 bh=N8o/S8JYpE+P94OMt6ofvyUqz51LnCLNCgONjtOPtQk=;
 b=owGbwMvMwCW2/dJd9di6A+2Mp9WSGDJ59RY8/PBwxpQIzmk34ntPmseIsDDNz1O4qinfnm5ye
 e/uLa+0OkpZGMS4GGTFFFmW5BoVRKSusr13R5MFZg4rE8gQBi5OAZgI/3lGhl3u+fZzhdU+/Dze
 fFh16+5wt2rZRwu4T3yXfO8lq/V7uinD//wHB3T5l/r0mnFP1Vf89iOU+XbonQtZOUZNP5rz76e
 cZgAA
X-Developer-Key: i=bmasney@redhat.com; a=openpgp;
 fpr=A46D32705865AA3DDEDC2904B7D2DD275D7EC087

The round_rate() clk ops is deprecated, so migrate this driver from
round_rate() to determine_rate() using the Coccinelle semantic patch
on the cover letter of this series.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/phy/mediatek/phy-mtk-hdmi-mt8173.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/phy/mediatek/phy-mtk-hdmi-mt8173.c b/drivers/phy/mediatek/phy-mtk-hdmi-mt8173.c
index d04758396046363ab9edc584ae10bf31e9c5fb0f..58c6596c8c20bdacf96a97709b8f5709f447e85b 100644
--- a/drivers/phy/mediatek/phy-mtk-hdmi-mt8173.c
+++ b/drivers/phy/mediatek/phy-mtk-hdmi-mt8173.c
@@ -118,18 +118,18 @@ static void mtk_hdmi_pll_unprepare(struct clk_hw *hw)
 	usleep_range(100, 150);
 }
 
-static long mtk_hdmi_pll_round_rate(struct clk_hw *hw, unsigned long rate,
-				    unsigned long *parent_rate)
+static int mtk_hdmi_pll_determine_rate(struct clk_hw *hw,
+				       struct clk_rate_request *req)
 {
 	struct mtk_hdmi_phy *hdmi_phy = to_mtk_hdmi_phy(hw);
 
-	hdmi_phy->pll_rate = rate;
-	if (rate <= 74250000)
-		*parent_rate = rate;
+	hdmi_phy->pll_rate = req->rate;
+	if (req->rate <= 74250000)
+		req->best_parent_rate = req->rate;
 	else
-		*parent_rate = rate / 2;
+		req->best_parent_rate = req->rate / 2;
 
-	return rate;
+	return 0;
 }
 
 static int mtk_hdmi_pll_set_rate(struct clk_hw *hw, unsigned long rate,
@@ -223,7 +223,7 @@ static const struct clk_ops mtk_hdmi_phy_pll_ops = {
 	.prepare = mtk_hdmi_pll_prepare,
 	.unprepare = mtk_hdmi_pll_unprepare,
 	.set_rate = mtk_hdmi_pll_set_rate,
-	.round_rate = mtk_hdmi_pll_round_rate,
+	.determine_rate = mtk_hdmi_pll_determine_rate,
 	.recalc_rate = mtk_hdmi_pll_recalc_rate,
 };
 

-- 
2.51.0


