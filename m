Return-Path: <linux-kernel+bounces-726257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 665DBB00A41
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 19:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1C75641AE8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 17:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6997D2F235B;
	Thu, 10 Jul 2025 17:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MxdvLNWC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4848A2F1FF3
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 17:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752169416; cv=none; b=fjIPS0Lz6ZAx3qSFxqui1vx3Ls9xloCVg6fW/zGk/qhgDp+VitNUOTq6XGYYw8uK+NM3DKdnLr/2xLDvfUZe9gxL3VK1BzaXpAYRO8rw0RSxrSURKZIuKZpamKODp4Ki/V7zU8KuBOx9d/3cf6TirigqbUbY8p+Ra1XbRpdj5WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752169416; c=relaxed/simple;
	bh=Uzde4F/sfQBVHQNcjDIBT9HB34JjyGuqbe7jNdblqLw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lew+EeYuciQsa0xtXAGCiF/dwcTeMmHXNqz6p4xeZTyptDjA6gZKtxfq5umwczYuPdOu+Kc3pYOANxYHu4xbNORCyvbef8u4RRKxk1/gHqMl5c73glNAFkzSIbRmYD1lT5O0PrFHjM7G3jp9HGegchQraXdz/tUn7kxkaEQJTuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MxdvLNWC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752169414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e37lSQKt1hx5PQsR5CacpUsq2th6rpfG9r3kIy+fF3Y=;
	b=MxdvLNWCCDxudfCHkneSAo0mkKlPVrzsXXgsZ7dc3gVJHi/N8MqzjIePA3bX1/WYpwBnUN
	OiibdNOZVJ5w5CTGEi08iRLSh6TSqhpydJSmxHQs/+0MINT0TEH5XIumSqa9EcpdPx+ADL
	1yY60XJYmskihHQYAYTM9NCZkGpBfMs=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-3eFR2dNyMfm_JFvgbNxnjg-1; Thu, 10 Jul 2025 13:43:33 -0400
X-MC-Unique: 3eFR2dNyMfm_JFvgbNxnjg-1
X-Mimecast-MFC-AGG-ID: 3eFR2dNyMfm_JFvgbNxnjg_1752169413
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6fab979413fso20156976d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 10:43:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752169413; x=1752774213;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e37lSQKt1hx5PQsR5CacpUsq2th6rpfG9r3kIy+fF3Y=;
        b=Chw4s3fONn7H54aXgBLfYgTMRb+Cx8/T2qtcd8t6Uz4YQTfp/MDWKh2xR4+Gu+n/ZU
         T1nvbx+h2vEdrXU/2GRcXIhOCOfGjuy4G4tTzQzBdQIXgkes1G6Q4QEp9tZQT9zOT5za
         JGfBhtZmVHX/DhAUciiyFodogMBgv4V+aXzC+va4ibg6SCWK0b6Eb6OqScwbyVd4D4MH
         ymCptVOtrG7dNB8RieApn69MdUpeMZ6ghMVqkArO/UcAm+qaNs3g15YQrCSPdonTIDE6
         AXIbZ72Zl7QuMRHcDZv1vzKZbPC+t0xlINjR/3L017655zbGVBeyD03WJHGedIJrJZO7
         6NPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhqWP6sfAbMKffzmdTEJgIHOLl1ztA9zL4VS/wbha4Ga/g3FQjs/eQ5YqNFt0mZdfGVSsH9NUIRGsqh3s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJMo/+IKRfUwZEzb2m0JKyeQmX2PRtOQrbGoVN/dPoQAmzor5Z
	gJDjyxWeV8uKTrowXzbZ4702sRtNxi/rw+PghGt7ruYdMXWD7WFGpMeKhq23gH0ZYbRWSDpMfkA
	B8FP6SUxnGQww2kanf50WzDQmlpNso5u7JUVJ59dBQ+oIPk3bq/H9wQoG7l7ekdKwRw==
X-Gm-Gg: ASbGncvftgk8sHy7ImY1/nZzsNjieShA7K//t7rftVb3pzqbqCh/nHXPqueN33z+Dp8
	GJ+sCrhbJ5JbnHyuZzUuEarAzMpv0Rnthff6mmAtslmBwUio54LVXZZHLbNsheVOKVZgjq0aI+S
	nW5u0XSaup29lihSwBPYXymfJYMI04YqphQPRwylBzpDgMgLxdvL9XVmLM1b6HM5hVFhzSQDe8Q
	KSLi4FlC98m8KUWXVe5H5CyOwjg9WK80VSgAgahCXHZhM9hZ2oLi9Q5ec45xDXPxhsH3TiI4nHD
	6emmQKFwjfaSXgRf0MOC3+w2BsASJ3TulwTL/6MxuLlqjd5C+AHUxBWSqkEq
X-Received: by 2002:a05:6214:5d89:b0:701:775:70b8 with SMTP id 6a1803df08f44-704a3a4449cmr3581036d6.38.1752169412801;
        Thu, 10 Jul 2025 10:43:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpu8L3YGRW12uiQDpOxMNgeR30Y84ZsZlrx/wXIc8LbcnhH9LwZm0nYnuoy1dfBl7P78vOQw==
X-Received: by 2002:a05:6214:5d89:b0:701:775:70b8 with SMTP id 6a1803df08f44-704a3a4449cmr3580236d6.38.1752169412340;
        Thu, 10 Jul 2025 10:43:32 -0700 (PDT)
Received: from [192.168.1.3] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70497d71419sm10652876d6.86.2025.07.10.10.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 10:43:31 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Thu, 10 Jul 2025 13:43:06 -0400
Subject: [PATCH 5/9] drm/pl111: convert from round_rate() to
 determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-drm-clk-round-rate-v1-5-601b9ea384c3@redhat.com>
References: <20250710-drm-clk-round-rate-v1-0-601b9ea384c3@redhat.com>
In-Reply-To: <20250710-drm-clk-round-rate-v1-0-601b9ea384c3@redhat.com>
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
Cc: dri-devel@lists.freedesktop.org, imx@lists.linux.dev, 
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 freedreno@lists.freedesktop.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-sunxi@lists.linux.dev, Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752169393; l=1663;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=Uzde4F/sfQBVHQNcjDIBT9HB34JjyGuqbe7jNdblqLw=;
 b=0pYUMWvjxgx4WfuoWRCVGEVL5ZYYPMN0neD5N8OcfZKIHag1vghAK3SLtnfFRHjfYafmDTVi+
 fTHFTPespiOCXPSLsOLNifbUMGk0HbP0Ww4Oh/+lSRoq6wnUOICkRwy
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

The round_rate() clk ops is deprecated, so migrate this driver from
round_rate() to determine_rate() using the Coccinelle semantic patch
on the cover letter of this series.

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
2.50.0


