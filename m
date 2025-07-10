Return-Path: <linux-kernel+bounces-726144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70227B008B6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 18:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD10C1716B5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 16:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E1B2F2719;
	Thu, 10 Jul 2025 16:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h4paDYuS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07DE2F2360
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 16:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752164889; cv=none; b=bNoA2vLxUMs/hyDvuEc544gO/2SJlh+o6wayMqzuJbOTDHtmseSFoPSTVsTgOs9pumwdQ9jomwHdRLV0HPoCc60hIFLdTu3cYDbBlG4zIj9Nc7yjb4J4xR7+gBLw2bvV7e9UYm1hwyP+v4C+sWRPeZmByxUthz34vBBfTZ3daNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752164889; c=relaxed/simple;
	bh=BdI4rced+HRKEB2cmVryNQG/zmpG45m97LWG2DtYv+I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uHil17Tt1BavF/vZKQ5+gBiBTW3VL4XmCy9BQWbD32B+H0Nx0J01i9LX9VZIg4VUpfcfh97A+UJllCwtoyvrubDzGeNhUU7L63lFxxPzJhFw8wFWQo+IN8KiCuoAzU2DeL335KwhkVDR52UJpTYzAFI0YmlW2/rgj2jipmzHVfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h4paDYuS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752164887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8Xtq1jz6n71Dy+bt87oxFW7ajsd8mfrICRfv5Quboec=;
	b=h4paDYuSUGip6ZT8Rdb/DeLw5S5TpctczzxGAU+z7WmyIZGvAqVuGlZkPaOLIS3vbTgyr/
	E1aS1xGbuye4aIEsuxqFghENdtzNIvCnxE6tFC1w4mrsTUPlXZiKP2Eoxl+8JFVS4/5jdF
	XXJp7zkzYGn75gmGvhviUWn3ZTrGrg8=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-u_rArvTbMo6bcFjuE52v-Q-1; Thu, 10 Jul 2025 12:28:05 -0400
X-MC-Unique: u_rArvTbMo6bcFjuE52v-Q-1
X-Mimecast-MFC-AGG-ID: u_rArvTbMo6bcFjuE52v-Q_1752164885
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7da0850c9e5so198676285a.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 09:28:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752164885; x=1752769685;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Xtq1jz6n71Dy+bt87oxFW7ajsd8mfrICRfv5Quboec=;
        b=lJCFiZBrFVtaxE8QnNaiUe6lqiOMGFn8Y3fBH55o/Ge6tLCg54avn1z9JLljqf5wWO
         Wtq4GJJ/bImjxZig5YxxsQwMvo6VuTny7m0OrK2M56jW0xFsQfgfSVoZBV0+ocmw6FSz
         iQ8pek68jbovEiCp8haz6u//ngvapYRtUrwyjvo28+2qyRaYYAZ2G5UbgdLHb/0f1iBg
         7BuxBhVnpIuaB7pNglbUfCJ5cCAewIlhupxNdsQU7RXGUqbysm7463LtyrgcL7uwVBbq
         fxa/OKdJVxuaoK1uzTr13NRjyYEZaCPdPd5ckflHR6PtruFVbAqTg9po4qeJHh/NqpVM
         uPyw==
X-Forwarded-Encrypted: i=1; AJvYcCX3xb9LP1RUua+w3wImC20VB9gjk/iMpNPspuM+mBci3AGr+z5MlNu7P7FoPlDKHlxkERiQW/TVdbooluY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrAFS72KKa833rDYoSRcj/J0FP5MqC+XnlyCis8s0/FmZc3yIO
	UdcpToCRqVdmLUPGnJp0zZ0xuwqEPI6dFzoMforC7lR4iiu/cX1tB7ZOK4gkwIs8g3p+QXRqK4P
	CgppD9z6a3f8QLCfKitNraytpKeOqSIAaZN//aV2ZT9Q03CY7j3VXuDp0WuRHZ+Q9Ww==
X-Gm-Gg: ASbGncvVnQOcfoqwUVBL3KRct8NB+/e0keLcuhzQVXTWV6nDcQ2qhayHBmaW8hXy73Q
	oa/TY0pyLZyplxKRP/7jmDkNy8m09xJdvVvrMIFMSHFXbSaeoF3Cx+pZQOsmVnG3Az0EnwgRZii
	MsIqYXiEhQLOXDtNuseM7lbTEDrWP478S9m47iCDAXxje5hWa5ke4oab2tqt+8tQXWSrKysKLQG
	SAf80pkh7oT9O6bMj/UtX6IMGN6Bfe3Ie1aERnL3bM20xbbB6ZR1EJKKGGOE1Y5X4JJbaMp6Y5f
	yGaWgCyiFGylq4uy2gbU2FyNZfIaZf1hACFAr2keobisw3EV/xS9NT5YmI+E
X-Received: by 2002:a05:620a:44cb:b0:7d0:97b1:bfa with SMTP id af79cd13be357-7dde99531bcmr30407085a.8.1752164884661;
        Thu, 10 Jul 2025 09:28:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELaboKc3+hjD+wF+4ZlA27Ur9xvHDNgGpesankgXOM9I1Jmb0Ok1BCSCTBE3suBwc7QsxRkg==
X-Received: by 2002:a05:620a:44cb:b0:7d0:97b1:bfa with SMTP id af79cd13be357-7dde99531bcmr30403485a.8.1752164884325;
        Thu, 10 Jul 2025 09:28:04 -0700 (PDT)
Received: from [192.168.1.3] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7dcdc5df99asm113487685a.49.2025.07.10.09.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 09:28:02 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Thu, 10 Jul 2025 12:27:33 -0400
Subject: [PATCH 7/7] drm/msm/hdmi_phy_8998: convert from round_rate() to
 determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-drm-msm-phy-clk-round-rate-v1-7-364b1d9ee3f8@redhat.com>
References: <20250710-drm-msm-phy-clk-round-rate-v1-0-364b1d9ee3f8@redhat.com>
In-Reply-To: <20250710-drm-msm-phy-clk-round-rate-v1-0-364b1d9ee3f8@redhat.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maxime Ripard <mripard@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752164864; l=1782;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=BdI4rced+HRKEB2cmVryNQG/zmpG45m97LWG2DtYv+I=;
 b=TGLhjj+IbzrNkeyKAWH/BPgTzIXuHRUMwL4erGFA0ZAfeBxyeP21kE2dmaW8XV4SrlkFC/vcy
 qZPJbO/GVg3D/lDY67azp4PfWKp8qH7F1AEDRFbNeKNdzHsxXleu+Nf
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

The round_rate() clk ops is deprecated, so migrate this driver from
round_rate() to determine_rate() using the Coccinelle semantic patch
on the cover letter of this series.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/gpu/drm/msm/hdmi/hdmi_phy_8998.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_phy_8998.c b/drivers/gpu/drm/msm/hdmi/hdmi_phy_8998.c
index 33bb48ae58a2da13b7e90ff419c6e05fec1466af..7d6381553eb8cb5b18b898a734d928d34f98ebb0 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_phy_8998.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_phy_8998.c
@@ -646,16 +646,15 @@ static int hdmi_8998_pll_prepare(struct clk_hw *hw)
 	return 0;
 }
 
-static long hdmi_8998_pll_round_rate(struct clk_hw *hw,
-				     unsigned long rate,
-				     unsigned long *parent_rate)
+static int hdmi_8998_pll_determine_rate(struct clk_hw *hw,
+					struct clk_rate_request *req)
 {
-	if (rate < HDMI_PCLK_MIN_FREQ)
-		return HDMI_PCLK_MIN_FREQ;
-	else if (rate > HDMI_PCLK_MAX_FREQ)
-		return HDMI_PCLK_MAX_FREQ;
-	else
-		return rate;
+	if (req->rate < HDMI_PCLK_MIN_FREQ)
+		req->rate = HDMI_PCLK_MIN_FREQ;
+	else if (req->rate > HDMI_PCLK_MAX_FREQ)
+		req->rate = HDMI_PCLK_MAX_FREQ;
+
+	return 0;
 }
 
 static unsigned long hdmi_8998_pll_recalc_rate(struct clk_hw *hw,
@@ -688,7 +687,7 @@ static int hdmi_8998_pll_is_enabled(struct clk_hw *hw)
 
 static const struct clk_ops hdmi_8998_pll_ops = {
 	.set_rate = hdmi_8998_pll_set_clk_rate,
-	.round_rate = hdmi_8998_pll_round_rate,
+	.determine_rate = hdmi_8998_pll_determine_rate,
 	.recalc_rate = hdmi_8998_pll_recalc_rate,
 	.prepare = hdmi_8998_pll_prepare,
 	.unprepare = hdmi_8998_pll_unprepare,

-- 
2.50.0


