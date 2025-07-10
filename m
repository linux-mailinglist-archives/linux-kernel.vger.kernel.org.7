Return-Path: <linux-kernel+bounces-726482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF3DB00D86
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 23:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E543E565CC3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 21:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC6C2FE30B;
	Thu, 10 Jul 2025 21:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fPZQMMEV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516232FD89C
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 21:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752181886; cv=none; b=rRqslvGHCkXt+Mwf11SkiCFF3dCJlefWyS+G6D4gDZ4rKohu2yaZJnx19qbTjP5dL04ccwwKHFhZ8lzke32fkKz8Izn7GgWfdhHGqAP5/7ql1+3ISmEIopepZTiDDrK7weTyHcRuuwAifk/rtZYHI9P2D1yBp1saoi+PsdM3l7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752181886; c=relaxed/simple;
	bh=W9rMxhG+HCQaTapcDP0EemGdUyiHL/4QZlLhjcozpqg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ii4hT6GIgCRA17YIMzlaj0YKiHneCk6bwc3gvXnedga6nekTrQl9EdKLpbHWBirlHPIllFIPMiiurugd2wwF9q4xl2/IAZ64MhwFLeXZMRtvVe9cf0QTAK3RL9M/myfA88Ru5OQOYCsn49Qx8sAP7ErrFcbm0kuJmXdEgVVJPXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fPZQMMEV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752181884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IMHMdgb5Ozof1oVF3d9/wmVqM+1K8QcysVII+1gO/dg=;
	b=fPZQMMEVy2XkqnaByZ+2ABbm0djChnkxXcDJct/jjWIdz+0CDCDFg1rn3YD3d4X9sLEun0
	Vl/XAbxPsCDuvQsIOf8p+zvpi6R0UK86mgkqZEqBIU05pnF0LsOmCF8lN0ylWMlQg6CBOT
	t1kX0deWb/19fjjwQE3MravsWzMRY/M=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-cnKUyFzDNX6rbuXGF06k3Q-1; Thu, 10 Jul 2025 17:11:20 -0400
X-MC-Unique: cnKUyFzDNX6rbuXGF06k3Q-1
X-Mimecast-MFC-AGG-ID: cnKUyFzDNX6rbuXGF06k3Q_1752181880
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2355651d204so13972375ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 14:11:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752181880; x=1752786680;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IMHMdgb5Ozof1oVF3d9/wmVqM+1K8QcysVII+1gO/dg=;
        b=mnW8UihtZ+7xb8ywswyocEImkC30KB8bG6ID84pxc5Dp6d3RU9doYU9ERIxk2ORPol
         EDSWOweYxacVjwG33k737lVrQ00Ao7469d/tEdw9dPns3oHzOLhv5bl0dBfPmFFHcvEL
         vRK3qCffLyQK+R2pcffyQlm/gL8jTQs+MaN81LiMFjPLbr08Tre0iFYuFFQhYEeCBszF
         SCr4Tgpztjv4eTa3LblisUn3V1NVIM60ksFf1X3Ya8lqdOmJrAQlvHULzUWV63htnOBw
         zeDGrmwtDd7Sphc7wDK72dnJeFWO7MlFZBD57wogDZBi4c6yQPhWZ6foa9qNNklNL0d3
         xUYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvmNZ8EmfCwM+aZ7ppo/jcI+VuBJGULG92Z02B7KntL6h/FX1DEqAoUntPbmU5wC4cv/kQ/ieJsCfXcxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtCijTInoGJj2L0ECXbx30Xr3a5gBjKyqtOf0PvzJjYS3Avuze
	Qd/xn7n5jNS86CTmdbKIHi9N7eVUk6apF31hczbi8vmxlmVr2Ig2d17AiR4Yxk1f5hm3ceIJv2a
	bcVMzT6YWuPvGICOY5d8NjOUmH+CxAvu9v+TgvA7xz0ckWULnG7SpjkMAXWoCrXkg6g==
X-Gm-Gg: ASbGnctlV7MsF8NK5eCXlfXbA2qBxhtSzAoNZT+elVCqGwIcAqN3PiCEObOefZeePe6
	rGjqKFHEcO8Fh6L00JSQjqYRp43kDtWVjaXV4r1JMZJyMdibZrP07IwDWrbxHxDJDU5oY2d5iII
	IgVFjTanRgBZ/oHKLzFio7bxkBZkKh613MVAHKL1cA1AXJ5uZiLpTLVKvRvy0P7nytvEb9qrQNb
	+jo/QQdUjqbKmRTfwtkFseRGHaCEgcj898anhOjRnQsYNl+K0AUh6zOP0TTXmacOIKSNPdCC3/O
	019AKpFVl9WmxfN8DH4+vuBV/iNRdZV0d1o1z3RrFaB7SA==
X-Received: by 2002:a17:903:4291:b0:236:6f5f:caaf with SMTP id d9443c01a7336-23dede396bbmr7262235ad.15.1752181879791;
        Thu, 10 Jul 2025 14:11:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHNiFYs8CFWRvSPbrkmIE4I8ntC8YkoPHeEDzjwj0c3EHunXltU+7bpHWVRTS4Tk67n9W2tA==
X-Received: by 2002:a17:903:4291:b0:236:6f5f:caaf with SMTP id d9443c01a7336-23dede396bbmr7261905ad.15.1752181879329;
        Thu, 10 Jul 2025 14:11:19 -0700 (PDT)
Received: from [10.144.155.224] ([2600:382:7716:65ad:9491:c054:6f2d:80ed])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de433e51asm27790595ad.180.2025.07.10.14.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 14:11:18 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Thu, 10 Jul 2025 17:10:34 -0400
Subject: [PATCH 02/13] clk: imx: composite-93: remove round_rate() in favor
 of determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-clk-imx-round-rate-v1-2-5726f98e6d8d@redhat.com>
References: <20250710-clk-imx-round-rate-v1-0-5726f98e6d8d@redhat.com>
In-Reply-To: <20250710-clk-imx-round-rate-v1-0-5726f98e6d8d@redhat.com>
To: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Maxime Ripard <mripard@kernel.org>
Cc: linux-clk@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752181866; l=1593;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=W9rMxhG+HCQaTapcDP0EemGdUyiHL/4QZlLhjcozpqg=;
 b=p2JvBhXGzB9Q3sTJCTzm0qM4XowHtLIbgUuGE85J8qpMRH1G/aHuClA7A/B83bKS/w2DVERZJ
 SrV4qAgn3aMDET2A7EtLIFuerX32CaXdZX7mJGyO9y00Vbcn4xmkqzv
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

This driver implements both the determine_rate() and round_rate() clk
ops, and the round_rate() clk ops is deprecated. When both are defined,
clk_core_determine_round_nolock() from the clk core will only use the
determine_rate() clk ops, so let's remove the round_rate() clk ops since
it's unused.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/clk/imx/clk-composite-93.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/clk/imx/clk-composite-93.c b/drivers/clk/imx/clk-composite-93.c
index 6c6c5a30f3282d4d128751147714bf24b64c52f3..513d74a39d3bd391c61db2e9a5b7752af611d3b0 100644
--- a/drivers/clk/imx/clk-composite-93.c
+++ b/drivers/clk/imx/clk-composite-93.c
@@ -98,12 +98,6 @@ imx93_clk_composite_divider_recalc_rate(struct clk_hw *hw, unsigned long parent_
 	return clk_divider_ops.recalc_rate(hw, parent_rate);
 }
 
-static long
-imx93_clk_composite_divider_round_rate(struct clk_hw *hw, unsigned long rate, unsigned long *prate)
-{
-	return clk_divider_ops.round_rate(hw, rate, prate);
-}
-
 static int
 imx93_clk_composite_divider_determine_rate(struct clk_hw *hw, struct clk_rate_request *req)
 {
@@ -141,7 +135,6 @@ static int imx93_clk_composite_divider_set_rate(struct clk_hw *hw, unsigned long
 
 static const struct clk_ops imx93_clk_composite_divider_ops = {
 	.recalc_rate = imx93_clk_composite_divider_recalc_rate,
-	.round_rate = imx93_clk_composite_divider_round_rate,
 	.determine_rate = imx93_clk_composite_divider_determine_rate,
 	.set_rate = imx93_clk_composite_divider_set_rate,
 };

-- 
2.50.0


