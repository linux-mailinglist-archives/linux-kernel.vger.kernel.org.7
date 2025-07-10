Return-Path: <linux-kernel+bounces-726240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03177B009F0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 19:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FF2D1AA6FC8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 17:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6122F19BE;
	Thu, 10 Jul 2025 17:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RebL/muY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F12A2F199D
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 17:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752168574; cv=none; b=kNL0G7UkpF7cjqulpsac2w8tS/Rz0H8wYYSyzHJEKmXIOHzOnmF95xITQJjrGa7Az4v8p+vWBShzK1ULrq0xXVfka8/Rtm5hz7minP/EIE1k3XF/As+m55J+OuF7y6fOShVaRoqkN9kV3jhgYtMTdHaUx2gFwaxAanbzct270m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752168574; c=relaxed/simple;
	bh=WMrCazWchDLAQl5gpNER6db4hCnZ+Unq2+JqAICztBw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SGG3JmJzWtojWPXCWS7N//hgVOtx658bpaQDwo4IWBusnmrdxtO0GPHDo+LNGqRm2zqXk+t5Zdx16Cyzbg2GQXcGxh51/dWRedYb1ZqiGaN7wNkBUXDAM5Xv/jZt8LZuY30Xj90OiDqHhw3ZP8Git8/odohCKYBcM29NOnQ1jCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RebL/muY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752168572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lsnr9i/G5KOz/D0uLE6KP6XoTOJ1u4OANp7MilYPv0g=;
	b=RebL/muYjg5mb3ZLh4Usq8J5sE5Jetlx7cL9sOCe2d8sZCDS+8odbeEeUJbf7NCUSMUw3+
	LziHSbsc7fXIGgEzX0+bN3/4yHDmrK6609Ta2t1zaR/L6ZyK0mo/9VZ/ftQc/KvAckYLg1
	TZ4nF7TGHwSSg7QoNko+4wcu1ImjgNc=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-c0SrmhUsMkKmLTWwOuyTfg-1; Thu, 10 Jul 2025 13:29:31 -0400
X-MC-Unique: c0SrmhUsMkKmLTWwOuyTfg-1
X-Mimecast-MFC-AGG-ID: c0SrmhUsMkKmLTWwOuyTfg_1752168570
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7d097fd7b32so266660285a.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 10:29:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752168570; x=1752773370;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lsnr9i/G5KOz/D0uLE6KP6XoTOJ1u4OANp7MilYPv0g=;
        b=SUtQnIz1nGw+ztXP5d1UMW1A1I88ZKBA5jl2x4MV7DaxUjqSK4GtBCQ2rYhkNE3Rwv
         Z7O2h1LSNcgYddTa918gDdgQToS1GK61hYcF3dHtHv1ftT9v2rYUAJ1aTR4hhYJmEjsf
         fZBsv01WeJf0u95MrNr8CuJenhEX3S64LQKi8o8C0jtc8AJ7R500Rzihu82HBnYr8I5P
         PLl2eIBhZ86GGWllXfKjuzr9vR5mhjs2anp/bqtK4IlneStbZGFMItF+grwADY5yTVeg
         JFPFhihdo7x9iU3Wi/pU8dYyjkA8CmcOHmK7LJEUNb53VIzII4+jTdkbcS3xhrF+tBm6
         neBg==
X-Forwarded-Encrypted: i=1; AJvYcCUjV+SbAL/gSUrCZjdtAxKfJKz0UisNJJGzx7VKZsYRl6eV8yrT2W+ez7rtNlqZuUIt1BAStP6X+ylXe/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKtLAdI80wr2p/E9/FqgDeGD45S2HfNl/TnxDMWXGFvBfQPFqM
	vkc6rVd6DQ0vf7+JD/pr2JiQDWE2Uq8bZ0OQSi1TMMY/ajmS0tLHuP0AC2qjXJOdHNuam545R+P
	rLFhoE2tvjcDdRK5bTXTjZvOrvjN/P7AMOw3xbgkyaWX0wsG+e8rSu4Uu/S8TTdPhEA==
X-Gm-Gg: ASbGncukiQB3IMxJE7YcB7qBR5eAUiYTp+RCjrxUYnZm/xO6OpY+Qbubq/SnFOG9RWo
	Mf0fVfuD+beF84Klvn1/EMz6O/fkh8WFsBsRBaAV8utWGP1/N8h7CU0zZKnEf2cAfCNcIAGEE7n
	g1IE5l++S9AeIP0NFY8m44bsxEKYU196AqLPRupYCqZUMC/pg7m6kkQsTR/gOypS6/mI8pqDNyS
	cx8E0O/wCWZdiNHcIDwvSsG7zzjtL797vwSoIxEYjfgKK7DyhctTE4JR6X3hPtuDM0gvvDBCC+Y
	yBGBaO3sKSZYsF4zO/i23zp5z7NYAdtVv5aMba+POJIC96iAsMcsqNjJ41xF
X-Received: by 2002:a05:620a:4549:b0:7d4:114:f81d with SMTP id af79cd13be357-7dde6f4340bmr52050085a.0.1752168570292;
        Thu, 10 Jul 2025 10:29:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWiAcWeA8eOcbhpjOcMfgYGQR5D4tEEyp87OcofWurB2Y1jQqxPwOPkFMLhYwntjM7d4D0ag==
X-Received: by 2002:a05:620a:4549:b0:7d4:114:f81d with SMTP id af79cd13be357-7dde6f4340bmr52045285a.0.1752168569774;
        Thu, 10 Jul 2025 10:29:29 -0700 (PDT)
Received: from [192.168.1.3] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7dcde806297sm117728785a.82.2025.07.10.10.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 10:29:28 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Thu, 10 Jul 2025 13:29:08 -0400
Subject: [PATCH 3/4] media: i2c: tc358746: convert from round_rate() to
 determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-media-clk-round-rate-v1-3-a9617b061741@redhat.com>
References: <20250710-media-clk-round-rate-v1-0-a9617b061741@redhat.com>
In-Reply-To: <20250710-media-clk-round-rate-v1-0-a9617b061741@redhat.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Julien Massot <julien.massot@collabora.com>, 
 Maxime Ripard <mripard@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752168561; l=1651;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=WMrCazWchDLAQl5gpNER6db4hCnZ+Unq2+JqAICztBw=;
 b=fYpewLIZ/V2pkgHqVX+lhdLXTPhtuLwGx/sgfiX0IaFbSuK6Kc43DNtKiLRcvVGj8/2B7/KMy
 Dk8bkPxiRHJDs+PiaoRWIq/LCqTUeS9OYYzMAemsjhzn9k4XGWbnRJI
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

The round_rate() clk ops is deprecated, so migrate this driver from
round_rate() to determine_rate() using the Coccinelle semantic patch
on the cover letter of this series.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/media/i2c/tc358746.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/media/i2c/tc358746.c b/drivers/media/i2c/tc358746.c
index 143aa1359aba51c2a36e8800e7c1149698268ca1..952470767b1e4b4c6e919fc5fec1ab5338c52409 100644
--- a/drivers/media/i2c/tc358746.c
+++ b/drivers/media/i2c/tc358746.c
@@ -1226,14 +1226,16 @@ tc358746_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
 	return tc358746->pll_rate / (prediv * postdiv);
 }
 
-static long tc358746_mclk_round_rate(struct clk_hw *hw, unsigned long rate,
-				     unsigned long *parent_rate)
+static int tc358746_mclk_determine_rate(struct clk_hw *hw,
+					struct clk_rate_request *req)
 {
 	struct tc358746 *tc358746 = clk_hw_to_tc358746(hw);
 
-	*parent_rate = tc358746->pll_rate;
+	req->best_parent_rate = tc358746->pll_rate;
 
-	return tc358746_find_mclk_settings(tc358746, rate);
+	req->rate = tc358746_find_mclk_settings(tc358746, req->rate);
+
+	return 0;
 }
 
 static int tc358746_mclk_set_rate(struct clk_hw *hw, unsigned long rate,
@@ -1250,7 +1252,7 @@ static const struct clk_ops tc358746_mclk_ops = {
 	.enable = tc358746_mclk_enable,
 	.disable = tc358746_mclk_disable,
 	.recalc_rate = tc358746_recalc_rate,
-	.round_rate = tc358746_mclk_round_rate,
+	.determine_rate = tc358746_mclk_determine_rate,
 	.set_rate = tc358746_mclk_set_rate,
 };
 

-- 
2.50.0


