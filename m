Return-Path: <linux-kernel+bounces-762436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49FD4B2068D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C4D018C0AE7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 10:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB066275B07;
	Mon, 11 Aug 2025 10:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XUvkGGxE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0611C07C3
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754909793; cv=none; b=DJEwyzdxK7QiSZn/7WOKj9PdJn9kquvVMMcwcz2gRfjWautArEyZPvYV9jymgbcDmeAvu4v4Aq3VenTX+hWkxlvrZ8J7QcazVc2G8ezzKCOtgVB2RNO92WPsRN9RBkNU6o0Cim1euByOuSmMsenl/7+7vMZtlVKsODJJ/0xigy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754909793; c=relaxed/simple;
	bh=cxbqZ4pGz5eouMzBVW3NyN413s0i735X+YyBDIP1KBA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=goGmsibTvoWi9O9/7GvapxnXfGV3Hxb3nx3CGjazH1SfU25PzISq1Yycy1GTLarMTPs0JiIbVhDFhpFiqjFINO3coo0yDl3UTlE0ZXBpAN84p0ukJfPdSAztbv3SAfSDE8v3kjz0C1/0IlPJ5aUuQTFNudtQbsPuuyFykPrFn6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XUvkGGxE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754909790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oItVFGO2Yky7AW4ur1CICLCJs15wxQxwvYfZhdFHqm0=;
	b=XUvkGGxEe+h1WmIbg/eyl2fCDWGsH82NDvxo0Pd+C72IHlKf56j9dvQz/tlJs1YK+Vn5N6
	77LGXvnSvCT46SKgtftFqcYRB0rx7gnbKGCHkD8qb7R/BQ6YLSHF+Z29uoDT1WucT2ESoK
	TCIF087SsfZw9+R3BIB3tSGGeoJUZqo=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-rMlTMhTKP_G5mvG0dUWE9Q-1; Mon, 11 Aug 2025 06:56:29 -0400
X-MC-Unique: rMlTMhTKP_G5mvG0dUWE9Q-1
X-Mimecast-MFC-AGG-ID: rMlTMhTKP_G5mvG0dUWE9Q_1754909789
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7e8072f828cso419676085a.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 03:56:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754909789; x=1755514589;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oItVFGO2Yky7AW4ur1CICLCJs15wxQxwvYfZhdFHqm0=;
        b=bL9ILLWgdZeiyCdv5JrpV/3W671JQr1L2/mIrBBw33KppgLVWsuXokR10O5kXdmggx
         e/zOxto9KyszqppmPhkrfHal0seGz65aZBdobMsMvnT2HdermBQKWf6wtO7IxzHghGeO
         C22fvl21QSZOuJIgYMGwge9QjFnw7pzUa71HLm+9Gzh0ovmJQjLnKkupQjING6CY7dhN
         GSudbnx5FfQ3dUpoEDusmNLxwvHHgxciYT8w5xopk+iC9cnZipmvpvnRS/WWCi5MtcxW
         EnMWqqHXqiTEiRBAlQsOghxALTXoAs51JdVgzr/Iso9K3WNfjpU/leFha0sFn8Dvz7P9
         TQiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoj5V+2f5HkiDBdy9U15KM84RBjkVUYk0FpRUkmVSfaUd4rQ1GVtuBiOFudKQx0KFCOzLC0b7PyxyvT8s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+Y/umJO+1zUnAXWm/yaWhYLARpKLDq3F2aWTquBs9f5ykomOz
	9tlLt2vTLv05sFjziF5EPKcO2iMeBLLfkcynMhNQeAuuHZOOWEf1+ztpreiwup302g3EBd/Bjek
	ousQV1mtgXi7gpDylNMG2nGvgUqAAdwXVATtIGsiJpCfMtDsOP0IJ4mIEQFhjrNIbsg==
X-Gm-Gg: ASbGncs6cicZMzjf6KIPGfSrHrAegpJCtuqws8YyrcGQOIQSIVVqMPWRu4l71KtWQlz
	GhWQHtohMrzduD3PGwDXjdrmKiH6rhxtOaPDrHcd/w1ybzje4ZeWWlwbjJLbonzloVOkNZFQ5Lx
	UGCjwk9jIoVSEJIzIqiNjUcFO9EEcpoyacA0xAEVsJZQ6rKog4ToW8j6V/OXROohcwPqYrzeB12
	hANIFfl1jkETimzyDJJy2m+5ix6Mxhz3x4fsmc/oMYUBSQQ9AEQY22wbVP1QaiyfY8Q+BhyFFNv
	U6kq0cscWvZBVO9aQqUM9efApLAJJ6lJcm+fIEPTL6osbA8P+dZQ0RnxWhKzOS9/2Nxmzt/d3aR
	Gb5s=
X-Received: by 2002:a05:620a:4482:b0:7e8:4fef:bfdf with SMTP id af79cd13be357-7e84fefc2camr275376185a.45.1754909788886;
        Mon, 11 Aug 2025 03:56:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGc+TLWI2xokcRtB+yecJngyy21noRPTcC3sO0sgVUYXnKnFuXDagMBjiVXOuloOtpZxIcGpQ==
X-Received: by 2002:a05:620a:4482:b0:7e8:4fef:bfdf with SMTP id af79cd13be357-7e84fefc2camr275371485a.45.1754909788147;
        Mon, 11 Aug 2025 03:56:28 -0700 (PDT)
Received: from [192.168.1.15] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e698de2df7sm1273446485a.80.2025.08.11.03.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 03:56:27 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Mon, 11 Aug 2025 06:56:05 -0400
Subject: [PATCH v2 1/9] drm/imx/ipuv3/imx-tve: convert from round_rate() to
 determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-drm-clk-round-rate-v2-1-4a91ccf239cf@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754909781; l=1689;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=cxbqZ4pGz5eouMzBVW3NyN413s0i735X+YyBDIP1KBA=;
 b=6DBm6LwfY0nfMA421HhZNkFETdBD0OvYJlukZJUarU0DQPM5TzD76GN5AVvolZqrFAvmrp1nP
 jvbNFGe7dHWC4XgQV+dlyA/bvSpVN7ZZvyR5/1pWXfn+rHkgHaXmtum
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

The round_rate() clk ops is deprecated, so migrate this driver from
round_rate() to determine_rate() using the Coccinelle semantic patch
on the cover letter of this series.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/gpu/drm/imx/ipuv3/imx-tve.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/imx/ipuv3/imx-tve.c b/drivers/gpu/drm/imx/ipuv3/imx-tve.c
index c5629e155d25aef5b43445bc18c6c90039c99974..63f23b821b0be66a8e8a379e1375ffd98552e72f 100644
--- a/drivers/gpu/drm/imx/ipuv3/imx-tve.c
+++ b/drivers/gpu/drm/imx/ipuv3/imx-tve.c
@@ -368,17 +368,20 @@ static unsigned long clk_tve_di_recalc_rate(struct clk_hw *hw,
 	return 0;
 }
 
-static long clk_tve_di_round_rate(struct clk_hw *hw, unsigned long rate,
-				  unsigned long *prate)
+static int clk_tve_di_determine_rate(struct clk_hw *hw,
+				     struct clk_rate_request *req)
 {
 	unsigned long div;
 
-	div = *prate / rate;
+	div = req->best_parent_rate / req->rate;
 	if (div >= 4)
-		return *prate / 4;
+		req->rate = req->best_parent_rate / 4;
 	else if (div >= 2)
-		return *prate / 2;
-	return *prate;
+		req->rate = req->best_parent_rate / 2;
+	else
+		req->rate = req->best_parent_rate;
+
+	return 0;
 }
 
 static int clk_tve_di_set_rate(struct clk_hw *hw, unsigned long rate,
@@ -409,7 +412,7 @@ static int clk_tve_di_set_rate(struct clk_hw *hw, unsigned long rate,
 }
 
 static const struct clk_ops clk_tve_di_ops = {
-	.round_rate = clk_tve_di_round_rate,
+	.determine_rate = clk_tve_di_determine_rate,
 	.set_rate = clk_tve_di_set_rate,
 	.recalc_rate = clk_tve_di_recalc_rate,
 };

-- 
2.50.1


