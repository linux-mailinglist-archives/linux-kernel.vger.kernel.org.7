Return-Path: <linux-kernel+bounces-726110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC4EB00843
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 18:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28D6B1893A83
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 16:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB792F0E47;
	Thu, 10 Jul 2025 16:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Va3tGZy6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2DF2F0E30
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 16:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752163715; cv=none; b=p/NRk9ppt024yL1WzV0PMD/oWexcuiACgSLQc4XJFYX7yWXtDGgSn3xn8B5eVWvHsvLs+advNQH6VhPoOdckoqraycRQpbxT4dQO7fUcs5r38B1Zkf6Eq+H0RB+jvheJC9+fGTEfzVrjGMuyucUIXkUvsJqm8qTSowZTmwHGEVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752163715; c=relaxed/simple;
	bh=pMJI6s5tTYu1BzJU7vvw5Y0iwaNTd3NH6yMHjsN8/cM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kaazIbliLc+FPnF3ZtHsuflLTrNfaeMvocWMXM77Kmr/dEvlVu61urhDVXi+1UM4V8EjQ/iETkLGBafZkz2R7tbAOGEDRB/87ShDfvktuuDcc+ezHysNsRZxqrtP5hoS7mETbr59dda9yvzVC/obak3+aoopqBt/OiJOo51fKNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Va3tGZy6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752163713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jTOJwZJsmHoGcZ8h71+3z1fiOauF+CUgacJvRTAcORU=;
	b=Va3tGZy6ZyLNaAJRT7Uis2LLaBtc09g0SwBkpyWRN2128gEofuF5DNiadVXq2i2nEWHGPD
	3TOJueo8DYHy4ScKDDbTVeLU18PQZyUru0Kn4FXOUgRARVZayTJEoK8aooVi7l8XH20+EG
	3yXwWymC8LU0vIQrHtxHZvjG6kj1q8U=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-7UIVC-AtP8GWFkkGsfk4iw-1; Thu, 10 Jul 2025 12:08:32 -0400
X-MC-Unique: 7UIVC-AtP8GWFkkGsfk4iw-1
X-Mimecast-MFC-AGG-ID: 7UIVC-AtP8GWFkkGsfk4iw_1752163711
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-7048ed0751fso24494546d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 09:08:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752163711; x=1752768511;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jTOJwZJsmHoGcZ8h71+3z1fiOauF+CUgacJvRTAcORU=;
        b=iSkjdRIuL1XupKMO/iAzOAEdwo2mmiFAweacqo9dk11sLdBFbWeKJRt72pC/lOtk2O
         txZLOzyEaCiMJFdbrQLRZYFMl8hddc9ZGDRAFFsXzIucWkNiQi1J4Z4xYjqqHQirHQQ6
         MmTYT93t3d4faudMr6kMV+1jy6FNKfcxmUoXlNH85InfocaYITPHcNsRe0Bny2OXZsi5
         tLAg5HB03/UKjc7RwEEmNsPM2krrOGYPawck0BYDHvrWVJqlJ5COSf131RlzRydtGw1C
         LSmyjZn6zwstoy8mdZlzIvuez307JwEXlIsLhv8KZmz3Z37v8XKux70HDGKn08eRDuVR
         exrg==
X-Forwarded-Encrypted: i=1; AJvYcCWjCaIN6j5VIWhl46EcdNcn5kplxsd8bth85rpac4cDS1vPfeH1Hx1ItMPhmxYCYNRujAyCRjhc0gtIvAE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRgAcDb4MK9eVp4N47I7i4LH/OXU0Xd0HDFANOMiJcrISKORyy
	AtITHyTKwxglLSkc9HqgOOkridrAygtqqUknMn/dPMET+yQ39Xyf67CflDE0m76kUP7DlhGZ3Bh
	cKg4YQf8Zize0P3vduuXl/x+JFu1BvCkq79OXlqpCFe2gMtbU62ilcdM2Ta9ePa6eJw==
X-Gm-Gg: ASbGnctTWKfIHnYS2jcUscigGEE2o4iVLPwCoK52GAcGfvcNz82pH5yWVkj9vFJKIbH
	JndJb7iGd/GoDzHpVKcnnumNVFqUJmj4pu2oa8dYhCe61ccWzcAvoazZtvBwgxFPHllYb4plnIg
	PvWCXpniDLkGMT+9JNb+xgA1LYz99GHB1dD/Eid4jZe+mm0iS4rL7YKg/ipQLtahXSJRmAqZu/X
	Db2Zym2JZsOhXTtANPiMpSzQiuwnEbXtlmwULD45/Zw4uPlE87iE842yQWSxz2N3t5h7uU3/lvc
	zxlq0G2aFMqIavNLb1K9/o8U4QOJoYBPFH9CTwiKnS5VIXMQ/8q57aI9NKC/
X-Received: by 2002:a05:6214:468f:b0:704:885e:bebf with SMTP id 6a1803df08f44-704981edb41mr38252236d6.33.1752163711096;
        Thu, 10 Jul 2025 09:08:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlqOGrQN8krksQLxHGl7XCXnHCMvXuYKuTeyW1zhM5hweEhYitnN6UMrP83jETXzN/T64C2g==
X-Received: by 2002:a05:6214:468f:b0:704:885e:bebf with SMTP id 6a1803df08f44-704981edb41mr38251666d6.33.1752163710538;
        Thu, 10 Jul 2025 09:08:30 -0700 (PDT)
Received: from [192.168.1.3] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70497d39749sm9670216d6.58.2025.07.10.09.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 09:08:29 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Thu, 10 Jul 2025 12:07:19 -0400
Subject: [PATCH 9/9] phy: ti: phy-j721e-wiz: convert from round_rate() to
 determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-phy-clk-round-rate-v1-9-0ff274055e42@redhat.com>
References: <20250710-phy-clk-round-rate-v1-0-0ff274055e42@redhat.com>
In-Reply-To: <20250710-phy-clk-round-rate-v1-0-0ff274055e42@redhat.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Heiko Stuebner <heiko@sntech.de>, Maxime Ripard <mripard@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752163685; l=1629;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=pMJI6s5tTYu1BzJU7vvw5Y0iwaNTd3NH6yMHjsN8/cM=;
 b=0nPrE2c6cl5ohekNJUp1MPpsItdutqAcWnGrmBosgKM0YvNyBYPz4zo1bZfpAq6S3ivaSbkgi
 TWd7oICIP84Cvj784x11Hev/+JYsi8/Mx0kVOHPtXnwdacpkl9MVEHt
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

The round_rate() clk ops is deprecated, so migrate this driver from
round_rate() to determine_rate() using the Coccinelle semantic patch
on the cover letter of this series.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/phy/ti/phy-j721e-wiz.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/ti/phy-j721e-wiz.c b/drivers/phy/ti/phy-j721e-wiz.c
index ab2a4f2c0a5bf3aa4b77045f4da8b0ddcc079f7a..12dafb2bd49bc33c13dd49246bc26df082e3dd40 100644
--- a/drivers/phy/ti/phy-j721e-wiz.c
+++ b/drivers/phy/ti/phy-j721e-wiz.c
@@ -934,12 +934,15 @@ static unsigned long wiz_clk_div_recalc_rate(struct clk_hw *hw,
 	return divider_recalc_rate(hw, parent_rate, val, div->table, 0x0, 2);
 }
 
-static long wiz_clk_div_round_rate(struct clk_hw *hw, unsigned long rate,
-				   unsigned long *prate)
+static int wiz_clk_div_determine_rate(struct clk_hw *hw,
+				      struct clk_rate_request *req)
 {
 	struct wiz_clk_divider *div = to_wiz_clk_div(hw);
 
-	return divider_round_rate(hw, rate, prate, div->table, 2, 0x0);
+	req->rate = divider_round_rate(hw, req->rate, &req->best_parent_rate,
+				       div->table, 2, 0x0);
+
+	return 0;
 }
 
 static int wiz_clk_div_set_rate(struct clk_hw *hw, unsigned long rate,
@@ -958,7 +961,7 @@ static int wiz_clk_div_set_rate(struct clk_hw *hw, unsigned long rate,
 
 static const struct clk_ops wiz_clk_div_ops = {
 	.recalc_rate = wiz_clk_div_recalc_rate,
-	.round_rate = wiz_clk_div_round_rate,
+	.determine_rate = wiz_clk_div_determine_rate,
 	.set_rate = wiz_clk_div_set_rate,
 };
 

-- 
2.50.0


