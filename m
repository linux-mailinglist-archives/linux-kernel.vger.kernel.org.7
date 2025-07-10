Return-Path: <linux-kernel+bounces-726239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F35A6B009ED
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 19:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48F3A5638D8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 17:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95DB52F19A6;
	Thu, 10 Jul 2025 17:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QlmLD109"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4FE2F0E49
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 17:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752168572; cv=none; b=DrekmN0DPoHflc+4TanGL68TXi39RUlQRuK3rqnYLtKvey74imftMBuElBBc9H3kKlhHgQ0+e73jdN2eHyt7YGUopp8l+a4GUCXlotd8WYk1mFtPB2fDCoJmmpQP+D3ZOcIAluFrCWt9drL+hbGkbLGI15ywE+6fJYhMg3kpAdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752168572; c=relaxed/simple;
	bh=XlP4JTqNj7IvkmiHr9tqG1K/XSMbOVFkEEzDSArtTGE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UYyv2vLrI09skbOOa9vnFoUL9/E57wwvx+vx5Of1frgzizqKkIZ7uDhjJ+OZx1q1Hr2QIJpuJYvgUpKYdvAV3MdH/K+ULAKUFksSmIKOtirveJgRuIBWys1dCIwudEMlL49sRCOY4YptcW4WXmaTHZH+zy/4Vc+6E1kOdaMSiGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QlmLD109; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752168570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sJ8oLNxWrU/sJ7CRad317hP+3603UtC2qk2fILpYrUQ=;
	b=QlmLD1092FCeMtumw5KlcRA+pTsfsCmB8rAZvaxl9DQMF6vIvHviKInR04UCDvUhxJeRg9
	0E5y/FdQtJx8ParPGWmdAAf8bYdih67zZQWxW6lVQAvxS/AHS6nMWVTn2IkkB5/KJNvhEp
	ZS4NLi6ITcGUW3aPTH2fnBPhOY8xkvY=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-tOzsedOEMG6dQzCDJrNZ-Q-1; Thu, 10 Jul 2025 13:29:28 -0400
X-MC-Unique: tOzsedOEMG6dQzCDJrNZ-Q-1
X-Mimecast-MFC-AGG-ID: tOzsedOEMG6dQzCDJrNZ-Q_1752168568
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7d3f0958112so186343785a.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 10:29:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752168568; x=1752773368;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sJ8oLNxWrU/sJ7CRad317hP+3603UtC2qk2fILpYrUQ=;
        b=IxHg8nIf95IYCuVLU1uboZIve3wK+KKOiPwQbnjRK1CrlGvqg1CQREvMgVlhP2hO5p
         7uucuP5RccUh+0KJAcCzAsva9n+5brtMqa7LtauNQ1FxEQqaTBwceIsv+OY5t7ODisdI
         ogtHq2q0LWbkzrT15f9xiizl1+tatq6gJYiXfoyNc4y4v7IjcfgSLUvJZ4jN/hQvCXZp
         kkcchQZDfYYaipOVygeg54kad6ybw0ePgeG97ZSDOdeXIeE4sxZc2VHDQMzuXHtV09wr
         DwlPGV4/7YrwqqpEv7DJppo9Q2nghnwmWdkD0mvsYXaZetkLl4SOrs3OA/S0s3pEWCDo
         qiZg==
X-Forwarded-Encrypted: i=1; AJvYcCVnqaB21Bwy+mHkDtFyyRIR1w0CPqeg3uTn6p3gd5OKgJJnuf/Qo5RNugySMiw3ZxL67S8uOVAW6wy5XtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+N1zx7xLnMeGvBWGxzzD3Yg5cLrxpWGPf23+xqpQHYsD1Kptl
	7ZSdRRv3FtevniAL16RmzKIVzDiyLhKdFJ45BcIXfEJH5ojQsVBgATEn8Hs+DZsGvmAqmnQGR9T
	RLb5H4xlXKxNGXLHJQzwjwuxcHIc9EziWJZUauabQmss4Kky4F5RR2HvHKCpiG+WCGg==
X-Gm-Gg: ASbGnct2rUI8KBw3NtgyVtwx9cWBeMF/efbvInccjmz6jqml1o15qmTKLBmezVJuyDz
	vuwVjc3y51jVBF0xrKd5+sPX3+lxAAZz0EWfIAiwYvEcXwkSLJRmZp9lE3bkuDxw9MMsqo+ApAV
	W5RCAHUpJzYqIYWBTGJQLcOhNU5iHhCYUJ5YKl7FBh1XtuWths/T7EIwYYI78AFLB0rJIz8/aTu
	RswH6Pd2rs0QW5gD1prQLtlP+ucTTO1T1r1K2CTSGP55T/fLktmaFgJnnqTd0cRJrIbQy/ZriuO
	GxcSs2Yw9JEEFOgSJNL78OPXosFbcrlW4lMlMbj/IPRyZ414e1boIajTtTyt
X-Received: by 2002:a05:620a:424f:b0:7c5:4b18:c4c3 with SMTP id af79cd13be357-7ddec176d88mr56986585a.30.1752168568018;
        Thu, 10 Jul 2025 10:29:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEASrri2Ld/AclC/23zcGLdVmOlP5lvu7yYNmYy6RQLVdGij7562wfMkwtg24N0RU6BEOMwFw==
X-Received: by 2002:a05:620a:424f:b0:7c5:4b18:c4c3 with SMTP id af79cd13be357-7ddec176d88mr56981985a.30.1752168567532;
        Thu, 10 Jul 2025 10:29:27 -0700 (PDT)
Received: from [192.168.1.3] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7dcde806297sm117728785a.82.2025.07.10.10.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 10:29:26 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Thu, 10 Jul 2025 13:29:07 -0400
Subject: [PATCH 2/4] media: i2c: max96717: convert from round_rate() to
 determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-media-clk-round-rate-v1-2-a9617b061741@redhat.com>
References: <20250710-media-clk-round-rate-v1-0-a9617b061741@redhat.com>
In-Reply-To: <20250710-media-clk-round-rate-v1-0-a9617b061741@redhat.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Julien Massot <julien.massot@collabora.com>, 
 Maxime Ripard <mripard@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752168561; l=2000;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=XlP4JTqNj7IvkmiHr9tqG1K/XSMbOVFkEEzDSArtTGE=;
 b=IZPrkyx5Mx/8rBmNEE2ncfwsaqrkNnJFwwc7DbA4LaSSjI43xyS4g6weDKPwkio7sUyOo7nCy
 eIITtwSJALwADRT1UZ4AYdPz7Y6HuPxE/mWTpvF7wnFYYBBRCfgrPZA
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

The round_rate() clk ops is deprecated, so migrate this driver from
round_rate() to determine_rate() using the Coccinelle semantic patch
on the cover letter of this series.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/media/i2c/max96717.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/media/i2c/max96717.c b/drivers/media/i2c/max96717.c
index 015e42fbe24629cc0268825ec640532a145e563b..17625fa72367bcce59b2178b8ca4fba795187d11 100644
--- a/drivers/media/i2c/max96717.c
+++ b/drivers/media/i2c/max96717.c
@@ -782,21 +782,23 @@ static unsigned int max96717_clk_find_best_index(struct max96717_priv *priv,
 	return idx;
 }
 
-static long max96717_clk_round_rate(struct clk_hw *hw, unsigned long rate,
-				    unsigned long *parent_rate)
+static int max96717_clk_determine_rate(struct clk_hw *hw,
+				       struct clk_rate_request *req)
 {
 	struct max96717_priv *priv = clk_hw_to_max96717(hw);
 	struct device *dev = &priv->client->dev;
 	unsigned int idx;
 
-	idx = max96717_clk_find_best_index(priv, rate);
+	idx = max96717_clk_find_best_index(priv, req->rate);
 
-	if (rate != max96717_predef_freqs[idx].freq) {
+	if (req->rate != max96717_predef_freqs[idx].freq) {
 		dev_warn(dev, "Request CLK freq:%lu, found CLK freq:%lu\n",
-			 rate, max96717_predef_freqs[idx].freq);
+			 req->rate, max96717_predef_freqs[idx].freq);
 	}
 
-	return max96717_predef_freqs[idx].freq;
+	req->rate = max96717_predef_freqs[idx].freq;
+
+	return 0;
 }
 
 static int max96717_clk_set_rate(struct clk_hw *hw, unsigned long rate,
@@ -847,7 +849,7 @@ static const struct clk_ops max96717_clk_ops = {
 	.unprepare   = max96717_clk_unprepare,
 	.set_rate    = max96717_clk_set_rate,
 	.recalc_rate = max96717_clk_recalc_rate,
-	.round_rate  = max96717_clk_round_rate,
+	.determine_rate = max96717_clk_determine_rate,
 };
 
 static int max96717_register_clkout(struct max96717_priv *priv)

-- 
2.50.0


