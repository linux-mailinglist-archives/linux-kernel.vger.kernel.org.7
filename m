Return-Path: <linux-kernel+bounces-762440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8C3B206A5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA81518C0D7C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 10:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F14828B7DA;
	Mon, 11 Aug 2025 10:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M50D6U3V"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B7A28980F
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754909807; cv=none; b=t6GqOiioPBlZkxLIBIvgN/tyiT76DwAQHUzUCJlZUtBtW4FSAzPto53k20Sf9CAvXZkx+ubuNf+IwMfeaQHEZ+zrAsdw7XcebajYKw95s4rVhJsu2v5It7N7frHlm7aLZarQNnIkn60zq+VQ+HAHRfK+LttfuZHhaZq1bUA4Ubw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754909807; c=relaxed/simple;
	bh=zjPZ3dnO6gZ6FQi2ZfbbqSAvbJwyf4CBg6JGhX8DcxM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nvX/ooYvtkF084sJd+fUaVK91lcoqF9MEB3s7x8ZvBL5fdfcyU6n7yvGszVHzv3KTMGS3q0RvSgRz6BKYyTilB4PNRWxrVSmqXgwvWpNzyQ5bXtP+Rm5rFK5kNOBRYQTMmjN8m0CvEFOH65TqjATJ+BagkYbuNnU4ufe9+YNrb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M50D6U3V; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754909803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wT9Dbxfb4kVAT42wH+rZD3vwBa5NQ+w/1wzXJJwlqX0=;
	b=M50D6U3VZliH6yNLTkh1JDR2fkGhSYetpLpYy1CHXkf5Symtj/vS+cdrJISrVHalx+KkQi
	z8Xvk5hlxdUtjvmGQmt2LdEJ5n5Q5Cm9MYRF3DYRl5Z2/hA35LLQsRk32O40IPgy/DMpvK
	BQTq3aKKn1mEHqismY7BiNkexV4gMiY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-TaEEtO52OymXe2tcKChDEw-1; Mon, 11 Aug 2025 06:56:42 -0400
X-MC-Unique: TaEEtO52OymXe2tcKChDEw-1
X-Mimecast-MFC-AGG-ID: TaEEtO52OymXe2tcKChDEw_1754909802
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7e7f74baf26so992964585a.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 03:56:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754909802; x=1755514602;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wT9Dbxfb4kVAT42wH+rZD3vwBa5NQ+w/1wzXJJwlqX0=;
        b=Fn9oq9spHdkl5bxJeJlsodrm6JCDKKfLXQfEnqYo2bRRvpJXYCT6ujxWsHT499tesu
         nPpa0QGsrn1dNrM6J8MjMiGSTTC61RJSqOkcVi3o/rdcCPrabqBqB8zyJDqgHx3sDqrc
         RbRZnO4PRCEoTVh4vuuag4UmVmhjZwpvq8vD2UaZz6QcqX3ocn7YxFRAWol5ZuBHW+zh
         DfuZu4JN6d1JOei2kQSuPwhY4zVsC0JROQVCa50I8OesMXyP34DA3LJLeMVCNfFY1K3t
         i46IMdJcbzBL+A48IPLgn2gI1GFrbZHtfTAkirJqNvb6li20RJgn5AXQD3QQHSLiam2R
         VFgw==
X-Forwarded-Encrypted: i=1; AJvYcCXYJmKwLbme1+3K4s0cBf3jqrzRcj5Js2b3uIRs4R+6n+oM0MwWFrp+AKNP2kqPeJch6r3VRMD1CO5Vy5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi/8+2aIZO37XfLc7ZPJlxtaHpfE5EcpW/EBcIfw3iAtf7yX3k
	NK9IPv2L//3jtZQmP80Y1EcVGzRqFvPabWHCUyq733t9aBkEWFC8OAP5gLyXQBkFRjCj15rZy1M
	VzM1jt8TUQntatky0GBFunjMSCHa3JLgD3CEZlSG9saE1LrvXgF+I0NJdeYGM+vceWg==
X-Gm-Gg: ASbGncuDc5bNVvWfHa04ZzSb9zDr73ToVDDw2HuLkSZkmqmWAnl03RmhWrvwhn7DWby
	0ml3+O888i3vLLadW7//yQ+qXRa5dWp7rg/Cso2o7sMZTzfd8Lwm/3lGEbHIQ0PRhFs+hu341GZ
	VGa46wthR2cCYXAZubQKP81vTTnZL8YxF0D1mKFRC7LSQLvdLnesC67x9aB2IQ/PKAbTWi3hgQ4
	XsVS/sDnH17107othnhT3LL9B2qv0TapPZ3/KXA1ZarclaSx/vQwe7AIfYJM27ujFVbhN9KqUaR
	Uk/CRxGinu8WUmjokxn/3Cl6QFbDmcfj+hRcPurYToMXSVcmEqp2nletfg2gq4mph37UsZrfA+e
	Lbtw=
X-Received: by 2002:a05:620a:45aa:b0:7e8:2151:9bbd with SMTP id af79cd13be357-7e82c6834edmr1680335685a.25.1754909802016;
        Mon, 11 Aug 2025 03:56:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHn4J1YPALYk3sfXKt4CIgszP9xA12/nZjPecmiJUzpdOL3Mq3At3CKB2rvFttPLfHNTO7lJg==
X-Received: by 2002:a05:620a:45aa:b0:7e8:2151:9bbd with SMTP id af79cd13be357-7e82c6834edmr1680329285a.25.1754909801517;
        Mon, 11 Aug 2025 03:56:41 -0700 (PDT)
Received: from [192.168.1.15] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e698de2df7sm1273446485a.80.2025.08.11.03.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 03:56:40 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Mon, 11 Aug 2025 06:56:09 -0400
Subject: [PATCH v2 5/9] drm/pl111: convert from round_rate() to
 determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-drm-clk-round-rate-v2-5-4a91ccf239cf@redhat.com>
References: <20250811-drm-clk-round-rate-v2-0-4a91ccf239cf@redhat.com>
In-Reply-To: <20250811-drm-clk-round-rate-v2-0-4a91ccf239cf@redhat.com>
To: Philipp Zabel <p.zabel@pengutronix.de>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Yannick Fertre <yannick.fertre@foss.st.com>, 
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, 
 Philippe Cornu <philippe.cornu@foss.st.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 freedreno@lists.freedesktop.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-sunxi@lists.linux.dev, Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754909781; l=1718;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=zjPZ3dnO6gZ6FQi2ZfbbqSAvbJwyf4CBg6JGhX8DcxM=;
 b=NJqHQ2ssaD4y0rqVbCbujpIrqzdN3VuMWj9ghDV3lWlNDbiI/oggFqGjuVCZHps19PnD896Q0
 9FdZ8qhj9mUBZ/GerZTn1O4AjtYG03lLvn79VW/TKhLY3AumrqAiB+P
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

The round_rate() clk ops is deprecated, so migrate this driver from
round_rate() to determine_rate() using the Coccinelle semantic patch
on the cover letter of this series.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/gpu/drm/pl111/pl111_display.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/pl111/pl111_display.c b/drivers/gpu/drm/pl111/pl111_display.c
index b9fe926a49e8bb42116ac382010829e333edbf8f..6d567e5c7c6fd559ba369a2761d3c402a14c6fe4 100644
--- a/drivers/gpu/drm/pl111/pl111_display.c
+++ b/drivers/gpu/drm/pl111/pl111_display.c
@@ -473,12 +473,15 @@ static int pl111_clk_div_choose_div(struct clk_hw *hw, unsigned long rate,
 	return best_div;
 }
 
-static long pl111_clk_div_round_rate(struct clk_hw *hw, unsigned long rate,
-				     unsigned long *prate)
+static int pl111_clk_div_determine_rate(struct clk_hw *hw,
+					struct clk_rate_request *req)
 {
-	int div = pl111_clk_div_choose_div(hw, rate, prate, true);
+	int div = pl111_clk_div_choose_div(hw, req->rate,
+					   &req->best_parent_rate, true);
 
-	return DIV_ROUND_UP_ULL(*prate, div);
+	req->rate = DIV_ROUND_UP_ULL(req->best_parent_rate, div);
+
+	return 0;
 }
 
 static unsigned long pl111_clk_div_recalc_rate(struct clk_hw *hw,
@@ -528,7 +531,7 @@ static int pl111_clk_div_set_rate(struct clk_hw *hw, unsigned long rate,
 
 static const struct clk_ops pl111_clk_div_ops = {
 	.recalc_rate = pl111_clk_div_recalc_rate,
-	.round_rate = pl111_clk_div_round_rate,
+	.determine_rate = pl111_clk_div_determine_rate,
 	.set_rate = pl111_clk_div_set_rate,
 };
 

-- 
2.50.1


