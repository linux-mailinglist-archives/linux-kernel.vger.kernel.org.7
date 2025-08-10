Return-Path: <linux-kernel+bounces-761646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E0BB1FD01
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 00:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 801AA7A6DC3
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 22:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB892D948C;
	Sun, 10 Aug 2025 22:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zqz+NHMQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52EE2D8DD0
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 22:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754866691; cv=none; b=kORBz1CZfCDG/Emu5J2FcNRaZYrSpvw1Kv+2yCEk0l1s9n6xZt5ZlRAmHhOHhIiDIbr76UNJ+AdwywxXfNh/OTm8MtdYy0cB3o7OVr+1zHWjHcychKbeQK24hJN3ZG+b6jH8YbOA4hyTTnU/wsPfz3XB9xYrJI8/Oi5EruAsh+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754866691; c=relaxed/simple;
	bh=09r1lPX7B14MLSuVQJ4dsJkrsJaORU9d2LSd/fRzU/Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kxZI4O7bkeZ43ydqoAXot5UZCow5DO1nmZWOxXt/wfF4jMfFZhC1mUsWmicsM++DK6B8+cih3dlP7UjiIMMG3u3tgxWA139BvaVwdM1sr1m3xKWn5/1yUvDdXa+ToMFZG/KFSN5N4tzCPFgP0kQr5RwXivQ9h0xmdvRNjGJaY1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zqz+NHMQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754866688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fp8kcGzYjp0wtOJJXm9d94iWK2Lu7bI5800+AHFvd0g=;
	b=Zqz+NHMQMlAMLdtcFzqxnidA6dCBb/wXSZS25bH+/2m+EM8oiUY2kvPWvs6KyB7U5mjoYJ
	71prUimDXUxFaNSz6ShgTzVsSCnkhG53R1eYOXVMijYolCUv2yKG+nczJn5QOgBn99wzsz
	IriGlQadQUToPNq9QeNKoLUlWvuQ+UM=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-J9Tl4p6yN4628pqmg5Gtbg-1; Sun, 10 Aug 2025 18:58:07 -0400
X-MC-Unique: J9Tl4p6yN4628pqmg5Gtbg-1
X-Mimecast-MFC-AGG-ID: J9Tl4p6yN4628pqmg5Gtbg_1754866687
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-7073b4fb53eso80773336d6.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 15:58:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754866687; x=1755471487;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fp8kcGzYjp0wtOJJXm9d94iWK2Lu7bI5800+AHFvd0g=;
        b=PKf8U20gF6xeje5h4UjLYfmFvlUNZpw9EQ/gPRHbhnnzPnjsSWcdZf4uDdnHhhBEnX
         1F2O8YVXHKN40pWF1147QD0ODJmlLJRSJPCzLP/sZ4EM0r7P4b3ijek/4V8IgikCOyJT
         y7Igxh+blfcGHRjFdW4yC+46ye+e4DFyjZysXzJRoF2a1Amxlkn3nv8+pj6p1LzoQDV3
         SdPWtaRjYdKfyGJHvh/q5ZyTK/9w8q9i9fgteJfDv54MTZYS2rsdKoLE+eIdX7D5y6XC
         pz81XiWNudijoswsDETcgQbbXgJyJSoI1Pm8GuIdEw78VcrZ/gvflZ0WZlmP3EZdA1gi
         5V9g==
X-Forwarded-Encrypted: i=1; AJvYcCWNh6MHbjjCKz3IhCnwpqCx6cbGIGhnOQA2cusqDqNsPnd/CGBU4vJmRNcbpC424nSgkuPxHik6lunFQbA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxX9yLmL8guqTi4KCkcv9p9GXbPgpqnbj/nTazorsVTZG5X5nkA
	/aWbgA+rGoE4drsI4tpzfW74mC/Rd3VS5uVHq6nZTCmqdPQ7beCi18rIONpz60UVn1XoquTAIYm
	sXa6QlH/OM9Jk6EGkVA0c9q5uNgFX6mN6bEsqGs5tw53SWVPkppShZtX5dnG14+Ne+w==
X-Gm-Gg: ASbGnctj7UD9b+KdOgmMAYRHqUfly4nxQeZ1vLk9nQZ6Q1hnTEuCxPDIJPu1K5ojRAl
	gJdsre5srQWyB2Jo6VDDHwrbhG9JV0ZE+JG8DonMgCeYIMUV3/e9HsGoYpzOidlQIKN52ZVYZgc
	cHi1rj41jknJuODcnxazfJuFvffPemjZR9cmOc1XE2LiQmpGzbrNbRx5NY8KGCPNLd81Pd5q06B
	Zbq4Mh52IATM5WczBxBQBXfX5G+RJWKfn2hHzNIWsoVKx0KSIocKboQ+Z9gASjHxdAgLp2cK3B0
	LpkfsgEsWPcEsAa55gnBT+HNe8R0JOoYS8hyavgvH0WrmRDLjkO/eFH9ZDFfZVmLLWutwLiuIA4
	bR1VdIQ==
X-Received: by 2002:ad4:5ced:0:b0:702:d6e2:3894 with SMTP id 6a1803df08f44-7099a283fc6mr144909886d6.9.1754866686901;
        Sun, 10 Aug 2025 15:58:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+GPlWVCW9ekKhJg+4g3e28+6oQCiHZCjU/hLom4Wlvy0t+z7ug+DcZyM9qyvldH93bCaBnw==
X-Received: by 2002:ad4:5ced:0:b0:702:d6e2:3894 with SMTP id 6a1803df08f44-7099a283fc6mr144909686d6.9.1754866686533;
        Sun, 10 Aug 2025 15:58:06 -0700 (PDT)
Received: from [10.144.145.224] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077cdd9916sm144266336d6.61.2025.08.10.15.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 15:58:05 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Sun, 10 Aug 2025 18:57:30 -0400
Subject: [PATCH v2 6/7] drm/msm/hdmi_phy_8996: convert from round_rate() to
 determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250810-drm-msm-phy-clk-round-rate-v2-6-0fd1f7979c83@redhat.com>
References: <20250810-drm-msm-phy-clk-round-rate-v2-0-0fd1f7979c83@redhat.com>
In-Reply-To: <20250810-drm-msm-phy-clk-round-rate-v2-0-0fd1f7979c83@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754866653; l=1762;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=09r1lPX7B14MLSuVQJ4dsJkrsJaORU9d2LSd/fRzU/Y=;
 b=Ltcr7gblllRTjthopo3qUDdfH31xXqXg3Eunr1kVSjwIRzMGT80F8gmAILsYimdJaEURAIIXT
 DQUfMhrW4ldDGWChbsCXStaOBBf3jn9wUuWO/HCkvaN+TS3qKQngYao
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

The round_rate() clk ops is deprecated, so migrate this driver from
round_rate() to determine_rate() using the Coccinelle semantic patch
on the cover letter of this series. The change to use clamp_t() was
done manually.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/gpu/drm/msm/hdmi/hdmi_phy_8996.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_phy_8996.c b/drivers/gpu/drm/msm/hdmi/hdmi_phy_8996.c
index 8c8d80b59573a37a4008752b16e094a218802508..36e928b0fd5a319b6a12b9be52705c067d51c20b 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_phy_8996.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_phy_8996.c
@@ -629,16 +629,12 @@ static int hdmi_8996_pll_prepare(struct clk_hw *hw)
 	return 0;
 }
 
-static long hdmi_8996_pll_round_rate(struct clk_hw *hw,
-				     unsigned long rate,
-				     unsigned long *parent_rate)
+static int hdmi_8996_pll_determine_rate(struct clk_hw *hw,
+					struct clk_rate_request *req)
 {
-	if (rate < HDMI_PCLK_MIN_FREQ)
-		return HDMI_PCLK_MIN_FREQ;
-	else if (rate > HDMI_PCLK_MAX_FREQ)
-		return HDMI_PCLK_MAX_FREQ;
-	else
-		return rate;
+	req->rate = clamp_t(unsigned long, req->rate, HDMI_PCLK_MIN_FREQ, HDMI_PCLK_MAX_FREQ);
+
+	return 0;
 }
 
 static unsigned long hdmi_8996_pll_recalc_rate(struct clk_hw *hw,
@@ -684,7 +680,7 @@ static int hdmi_8996_pll_is_enabled(struct clk_hw *hw)
 
 static const struct clk_ops hdmi_8996_pll_ops = {
 	.set_rate = hdmi_8996_pll_set_clk_rate,
-	.round_rate = hdmi_8996_pll_round_rate,
+	.determine_rate = hdmi_8996_pll_determine_rate,
 	.recalc_rate = hdmi_8996_pll_recalc_rate,
 	.prepare = hdmi_8996_pll_prepare,
 	.unprepare = hdmi_8996_pll_unprepare,

-- 
2.50.1


