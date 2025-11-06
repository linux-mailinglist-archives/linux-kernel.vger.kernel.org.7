Return-Path: <linux-kernel+bounces-889527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6B4C3DD6D
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 00:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A63C034D22A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 23:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95ED13559E5;
	Thu,  6 Nov 2025 23:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="REnJBDNd";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CanFcUfK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4413559DC
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 23:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762471625; cv=none; b=n27GndlVc+612lAKIre89wlnTcYPGJJgD38A1Bzva0giYFz8lb2k6nBYHvMDQmTRHxaKrJj//DlyLX0hZJmVKLkRtscNl6gjbN3QYbn8y3IqLFoAigb54sH85dUqmar0rzNZ3tzUsqrOcvR7S1IkdoU2nbzrqAasYrVLMBvJnuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762471625; c=relaxed/simple;
	bh=pGum4msvOB3xDDFVObf0RbWafZEF5jMmYiXTVfgLr2I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MSnv2RPwRc9Lo0c1/9wn2mbU4ACOFHejuaBEH26afLQR8XcBGeOBM6xjPQ9BnDSDXFzNV15VHN5ew0O2+BdgTjE8HyMslsyXZtdErlvpZNQWpgFRjumJrrW8/dUuczTiT1FNO0AkaBuqmsDkP0Cf2Fr7KRxp+GOnaqlGzr1sw+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=REnJBDNd; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CanFcUfK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762471623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WZVea0Mun92OWS2efd7OZNCrg3R5Kgv6X7v7bFvHs04=;
	b=REnJBDNdHw2yfQVMfGil+YuJgsKIBh0ecHvcr4wXUREiJUrT8EpVT5Vbgpah7fkwSOYX23
	tlcJXRRgUs6vZb3yCOp9Ud0VP8Z/qI2G+/oGajRTq1T1FOxXQfYS+ZkYSXaroPzJ2eEOG/
	YQmPKKssqIlTfCLFYRL0kgbkO6gS1rs=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-Nf8d6JjpNVOILOnKnAR_bQ-1; Thu, 06 Nov 2025 18:27:02 -0500
X-MC-Unique: Nf8d6JjpNVOILOnKnAR_bQ-1
X-Mimecast-MFC-AGG-ID: Nf8d6JjpNVOILOnKnAR_bQ_1762471622
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-880441e0f93so5340506d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 15:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762471621; x=1763076421; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WZVea0Mun92OWS2efd7OZNCrg3R5Kgv6X7v7bFvHs04=;
        b=CanFcUfKFQdKLXVvEw2UONjFN+33BVGRd7Kt1tjnqjtcxVZmzmvZkvo+IVj/OoxSAF
         7JNhVpXlaApO1emtSXubAm6Te0YzLEXy3QITb/vUr7mHcCmz4Xd5mgzojCZVFaT2sBjM
         CugtUiGW7IQBHBKZx3nCPA/gmYk7gCvnbO2DQptozHN6ApJt0wEfR68myJk9ap2TfqQ1
         9ihQaJNmq9cNp7LPO4MwsNeQpawj3DwJ5lffNJ+im5Lz4nVTcJAPqq3fPfb8e7en4Ucw
         DxMIGjC15mv/viE+fZ6QmT3I5YeVhqv7vEK6b44u9Hp8Y6qbTbZzTriTbhmcZeBCW9uz
         AbHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762471621; x=1763076421;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WZVea0Mun92OWS2efd7OZNCrg3R5Kgv6X7v7bFvHs04=;
        b=vw3WtFehzMLsz7OAg+tiB4VteXV7Nj3zpnYplck/81G7xx8uhQ4vIqXeyzfk+IDEWR
         qbWOdj7edy8S6kv4xQ4QdXmNWo+Br5HsxuCjdbTk2IhjN2wQuyiUIK11ImHp0KSwx6EL
         K+9U+VUwcLu1xEPFoZMHdgyrLNF2Ln8PvIyqOIMRtRn9bD/iRTBBmJsd0YDqZhxG3rEw
         6QdE399iw5ogmwVgogZCK+wg2tqKwqxmjI9q8ATS2VRlvkyNDMiSSGpVKPGnrJmXmtLK
         a2ZXyxNBFJJ2DObkmfUD7NJZcw1nm7IrEi/YAW1sZ9pVNBIL8MXExL+IEL4iClAwUbwc
         zYEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXjOEyRXdN77TCwka2jTWljg3OQ6JYYz90kK0KBdpE1kJX7x7JrIaYIZjj6qBSBoE/jhvnfefwhiI2JAM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx720ntA1R7WV5K7IervS3c4OezH1VRaKEdW0X/L62yM/r85KH3
	XCkvKRZCjdjHj27IGMomdFR0610nto+kYwpF3+u5qH7Kt9u78Xun4W24klCwIWmXI+cWEEDFSJR
	Em0UqoHKF1guNaUFr6HVXioyUHPIbL7ihj5GhavCiMe+P5ZPzttpXSHWXTO1knXXedTvVP/17dg
	==
X-Gm-Gg: ASbGncsFe8DuIm6KuEMr6rvVpMnGMU59o/6ANeUjjRd1in1YhXcv+iIycjGNqM3nYOc
	ZDYCII4FCgpTUDGJq9Q69kz9esNVh4g8AK621Ibn1u0oa/cC1xU6YoH7fHdEEecv1t2ErMydj9/
	GsavFwCYc/3raCO1HCwd2YjFIPaQh7QVJ/wPKjAhX/+6iKn+gjwKimjxdPI6ioCxvurdfLUXLCR
	D0ZPvAuGWvfCKeYcO8RFWc3o/m7r8/FIEZZLwq9gjEUV69lkOulKyA5Mb/i4GBPjoY+QXloV+78
	5SHHPyY0N7/hA0DrtXY+6h+JH7bod6Iq1gYLUfAKl0e5NmZypakKQQIKKOXL4m+XWhfGoQjak4g
	PYTA+y1xYHqzHmVc6KhPG1HoBv9IeEuT1YsRxr6MbPA==
X-Received: by 2002:a05:6214:4110:b0:880:53a7:a445 with SMTP id 6a1803df08f44-88151e4bc49mr17960386d6.2.1762471620706;
        Thu, 06 Nov 2025 15:27:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHtHpA4COaBy2TQDBCCELqXAf0sfk+lQ3jKjHR4cm3lLWRVAj13ngGgT8ax+bpg/JoDlCOeww==
X-Received: by 2002:a05:6214:4110:b0:880:53a7:a445 with SMTP id 6a1803df08f44-88151e4bc49mr17960216d6.2.1762471620343;
        Thu, 06 Nov 2025 15:27:00 -0800 (PST)
Received: from [10.197.115.224] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88082a3aa91sm27389196d6.56.2025.11.06.15.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 15:26:59 -0800 (PST)
From: Brian Masney <bmasney@redhat.com>
Date: Thu, 06 Nov 2025 18:25:52 -0500
Subject: [PATCH v2 RESEND 6/9] phy: mediatek: phy-mtk-mipi-dsi-mt8183:
 convert from round_rate() to determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-phy-clk-route-rate-v2-resend-v1-6-e2058963bfb1@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1507; i=bmasney@redhat.com;
 s=20250903; h=from:subject:message-id;
 bh=pGum4msvOB3xDDFVObf0RbWafZEF5jMmYiXTVfgLr2I=;
 b=owGbwMvMwCW2/dJd9di6A+2Mp9WSGDJ59RaqnVC7xubvIvpuN3fZv7sHddmfyK78rtPpal0bY
 a34zmpPRykLgxgXg6yYIsuSXKOCiNRVtvfuaLLAzGFlAhnCwMUpABM55MfwTzdcOk1ownJ5dj3F
 lEqP2+cWf1utHLvJU8rLrrGyvaomjeGfmciaJ0/c/+l5/550WeiIRfKndL0k6eYkX0bZkg35Iam
 MAA==
X-Developer-Key: i=bmasney@redhat.com; a=openpgp;
 fpr=A46D32705865AA3DDEDC2904B7D2DD275D7EC087

The round_rate() clk ops is deprecated, so migrate this driver from
round_rate() to determine_rate() using the Coccinelle semantic patch
on the cover letter of this series.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8183.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8183.c b/drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8183.c
index 553725e1269c9d7ad88f89367dfa1cf367aaf1ce..a54d44ef70ab49937d210f04fdf42300e8e5f2de 100644
--- a/drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8183.c
+++ b/drivers/phy/mediatek/phy-mtk-mipi-dsi-mt8183.c
@@ -97,16 +97,18 @@ static void mtk_mipi_tx_pll_disable(struct clk_hw *hw)
 	mtk_phy_clear_bits(base + MIPITX_PLL_PWR, AD_DSI_PLL_SDM_PWR_ON);
 }
 
-static long mtk_mipi_tx_pll_round_rate(struct clk_hw *hw, unsigned long rate,
-				       unsigned long *prate)
+static int mtk_mipi_tx_pll_determine_rate(struct clk_hw *hw,
+					  struct clk_rate_request *req)
 {
-	return clamp_val(rate, 125000000, 1600000000);
+	req->rate = clamp_val(req->rate, 125000000, 1600000000);
+
+	return 0;
 }
 
 static const struct clk_ops mtk_mipi_tx_pll_ops = {
 	.enable = mtk_mipi_tx_pll_enable,
 	.disable = mtk_mipi_tx_pll_disable,
-	.round_rate = mtk_mipi_tx_pll_round_rate,
+	.determine_rate = mtk_mipi_tx_pll_determine_rate,
 	.set_rate = mtk_mipi_tx_pll_set_rate,
 	.recalc_rate = mtk_mipi_tx_pll_recalc_rate,
 };

-- 
2.51.0


