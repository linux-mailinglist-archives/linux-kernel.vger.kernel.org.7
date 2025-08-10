Return-Path: <linux-kernel+bounces-761647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3CBB1FD04
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 00:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38F9F18982D0
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 22:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A3A2D8DC0;
	Sun, 10 Aug 2025 22:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D2kM4GYt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C422D8DCF
	for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 22:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754866695; cv=none; b=GegrfkYJXjPeeDTmQxkM80KxRd2ZBR8KLMxJkcTdLniO/1v2irhNBIO8AMTJwdXDpE4Bb7QsrW2N5wU8v6tqpapKouU9axi+nvDOxPTOxltL5RG5DL7ke03DLk4JgO6AwdHd47stFgMx0NGdLNqANCizCrXgBWZzlBJxzvFqH6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754866695; c=relaxed/simple;
	bh=b3lpeRdsfILZNbKt0s4jDvsKWYmd9ZM6thqzD9ovEpA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nScwgQUnXHve7m5Rtnnss/QOhWan3n9KWcQb0v4TuvHsmfWR4E4LJieXBs325EK2RO3Om5DYjWSdDGWrMeY9TADsj7jdulmZL/AVdpcqFcBlQRp+FS7jffs1pd1tAEtYEeR87wNch+aHQu7D8L4rYX75moVHL/BjriIBogbSU4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D2kM4GYt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754866692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FbrTb5TIWzNpxLExdP2beMCh0zMQGTK+0dHd5wdG15k=;
	b=D2kM4GYtpy3MRtgGqEIc73oaruJOEH5xA+MD5zSi2oR3aKMcCc9+MdOSLk12qiBL8v5MuB
	NeMIMe4KNmxCPrAGR3TjljxLmpM5GmAmMhj8DTCFuc+TMxy2IUgeTpRCyYzUvKVyx8vBG4
	HNclJAcJUJtyp7KcEl/1RqDeocrY4+s=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-N5EiRmIAMz2PSSsJPhoOPw-1; Sun, 10 Aug 2025 18:58:11 -0400
X-MC-Unique: N5EiRmIAMz2PSSsJPhoOPw-1
X-Mimecast-MFC-AGG-ID: N5EiRmIAMz2PSSsJPhoOPw_1754866691
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7e7ffcbce3bso1229839385a.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Aug 2025 15:58:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754866690; x=1755471490;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FbrTb5TIWzNpxLExdP2beMCh0zMQGTK+0dHd5wdG15k=;
        b=Odo7W4KrTI+LkcpOe4HNbSRcubattrUcqOMaeg+7pVhHOcenOzJzQigFZ2F6z5z7EI
         3a3Iv0uq0sI2V0tum3Ri09G169T9/y7iTpPaGiBSp6XsAcnq1wGiz21jaU4q89hQwr2V
         FmtCqWBgAvG4EIkAJRKSnSrA5BLRxC1XTooFvi1JS0IgqajYuwX1swqEYDP1WimCBBBE
         hyahuLDaGW8OBGv1ad2cjxvW5o16p4g2x05Bk9g6XtcwZ+DmCjQeQdl19+V7E7N1lgTL
         5Yz/atTgkkrnd7PNEL9Z4oATaQfY+C68yZb9bN6sM08Jf8wr1clRq8O+53dy7A5/3C9n
         4hcw==
X-Forwarded-Encrypted: i=1; AJvYcCWznnz4TKE9wAez9vXC54s6qjEONCGYthGxnCcrIKeJf3HTo9pTfblZzs1jY0Nv62bL/4aj7klSW+pwuDs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUMITTyBIrQCi8thgv8SlU8cR2NkGjajWU79hen88luNd527cj
	d4bulM+sP8+b2nPQJ3LMq43CTAxX+H4zqIdjmIYM53h2Xm98IPX77V+WnQ4GpqqO2Hx9o3V//ss
	4FzSiWwVnfB3eHAKJ1KCp6IzRkFAT7D3YH2fEstn4/e2YApNz5tQADU2nAPl8WfiEbA==
X-Gm-Gg: ASbGncuTWsJHBDnZpCKGOetUyjgBK9P8FNnAOvFmPekWLK+4aooHnQLBYYcTy7aVvGc
	I3w/C7wxXc6p4b9mGxytRT1VTBmKoZMXTVukDQPQdKpsobQB1iWWGRWnyI5df6iyKlmg3YJk0Aj
	cbUfohkwx+8YyEBkPbx6pv/VQtMOpgfd4idx/t4LyMMbVuTrXODhqYA4haKpI9c4IQ5C8HdoY1q
	fl9FH8fAU8PkCFxLM1ZLI+0FM4VqzExotEmguRmf0QdZbanOhwipifb0QfueEu9ORqtK2jP1Rje
	hmw5a3rLPFAfj1STaBVr+nQb2WHYo2kt/PGeUpyN0mntTn8xkq15OK+SP1MYWWUR01UyciGUODf
	R+Kzp8Q==
X-Received: by 2002:a05:6214:2469:b0:707:48b6:bcd4 with SMTP id 6a1803df08f44-7099a51356fmr150862576d6.48.1754866690662;
        Sun, 10 Aug 2025 15:58:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGUGt1AwSBne/o9+rNR3LtSm/WoA2RbHO8v9LNVgg4wnAMJx+OP+IR27C+Pk0SSrEVzMCAAA==
X-Received: by 2002:a05:6214:2469:b0:707:48b6:bcd4 with SMTP id 6a1803df08f44-7099a51356fmr150862326d6.48.1754866690271;
        Sun, 10 Aug 2025 15:58:10 -0700 (PDT)
Received: from [10.144.145.224] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077cdd9916sm144266336d6.61.2025.08.10.15.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 15:58:09 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Sun, 10 Aug 2025 18:57:31 -0400
Subject: [PATCH v2 7/7] drm/msm/hdmi_phy_8998: convert from round_rate() to
 determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250810-drm-msm-phy-clk-round-rate-v2-7-0fd1f7979c83@redhat.com>
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
 bh=b3lpeRdsfILZNbKt0s4jDvsKWYmd9ZM6thqzD9ovEpA=;
 b=bPI+bgndtQjl8U/B8CPlCWIm4ICh/KSI/9pQqEc+JGzlNlWdm7ffMObXa6FktebNdwMw2IQ7l
 yRXvUD2K69rChwg8WTjpcfmYgZ91P/5xMLfzNQFm4R78kNC3NkqT/fj
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

The round_rate() clk ops is deprecated, so migrate this driver from
round_rate() to determine_rate() using the Coccinelle semantic patch
on the cover letter of this series. The change to use clamp_t() was
done manually.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/gpu/drm/msm/hdmi/hdmi_phy_8998.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_phy_8998.c b/drivers/gpu/drm/msm/hdmi/hdmi_phy_8998.c
index 33bb48ae58a2da13b7e90ff419c6e05fec1466af..a86ff370636972168124da19e114f0acab2249d2 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_phy_8998.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_phy_8998.c
@@ -646,16 +646,12 @@ static int hdmi_8998_pll_prepare(struct clk_hw *hw)
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
+	req->rate = clamp_t(unsigned long, req->rate, HDMI_PCLK_MIN_FREQ, HDMI_PCLK_MAX_FREQ);
+
+	return 0;
 }
 
 static unsigned long hdmi_8998_pll_recalc_rate(struct clk_hw *hw,
@@ -688,7 +684,7 @@ static int hdmi_8998_pll_is_enabled(struct clk_hw *hw)
 
 static const struct clk_ops hdmi_8998_pll_ops = {
 	.set_rate = hdmi_8998_pll_set_clk_rate,
-	.round_rate = hdmi_8998_pll_round_rate,
+	.determine_rate = hdmi_8998_pll_determine_rate,
 	.recalc_rate = hdmi_8998_pll_recalc_rate,
 	.prepare = hdmi_8998_pll_prepare,
 	.unprepare = hdmi_8998_pll_unprepare,

-- 
2.50.1


