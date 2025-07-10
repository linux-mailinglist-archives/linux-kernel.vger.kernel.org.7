Return-Path: <linux-kernel+bounces-726003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC15B00686
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 17:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C2B13B089F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 15:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01FDA279DBD;
	Thu, 10 Jul 2025 15:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eOIpIwe9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB4D274FE3
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 15:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752160899; cv=none; b=tPpmOefqKN92UFNLoqsPiwx88qZSKPIwGzLXF614pGyL3i61Qwmp2xUDej/HLG70SYg287whRgaAjlTh3FEUmDQjr/GKTZ+/hI5CWWPg/C6BGy3is4skukofPJlrAwn8mtHcIEs5K2SVq97w34uI43vjzu8Y3AD30AqrjFX93XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752160899; c=relaxed/simple;
	bh=5ZVOk+ZOrENo582GUq8LCq+7YYXjCzCCpjXuZ1lV7ck=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QIaeYbMLty3ARmIBp529lUW6zbrMAzEmu3a9qbWgAWLOS0vPoqrZs2gZiV6ssIBtahXLZ2CngzGlEOJgLrxunv93poau/dBfTeU9K2lIaKYPIjekygu+9su+Dmc8urc1AEQkmm8u2jklFMAXWtGdexyhdCces8yIVTVzspn/fsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eOIpIwe9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752160895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2dw2Z+Nvvv7e9dl6Tk8Gm4QoVSZGDUeLTWDCuXgyoEs=;
	b=eOIpIwe9JjJlLZlX5JSk19rt3BL70IZNSFJGXLig9Deqa2pT7Zq7ipEzykuZPhqxSFgvhN
	aYfjPA8IXLSYpCYAY8lCt/eYEAGDAVqeqAXBpG/QUJ4lTSVZ5LaOm9/RHSKy0WJrPcTxAI
	qlLg3mPp4fROhFvZEpCMYdhD/q4FMg4=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-Df1HJgw_O3e-3agtS2SlsQ-1; Thu, 10 Jul 2025 11:21:34 -0400
X-MC-Unique: Df1HJgw_O3e-3agtS2SlsQ-1
X-Mimecast-MFC-AGG-ID: Df1HJgw_O3e-3agtS2SlsQ_1752160894
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4a43988c314so20372891cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 08:21:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752160894; x=1752765694;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2dw2Z+Nvvv7e9dl6Tk8Gm4QoVSZGDUeLTWDCuXgyoEs=;
        b=mkHwvTB0fpdeBmjY1kdWz97y+OQPCAImZhc2C7s8JdaiyLzxU4Cbq09zvUUaV0bhNN
         4xbdm9pdMAABMFcsUCDu1DS0oCHSKHjihkHMChbIUrcugLNmblaKC3OOCa7/03StF4uf
         nFumieI2h+Z/dnCwTQflit4YdnhS9Q2oTLz4bnbw92FBU+q6IQnUrKGbExkoXSnSfCPf
         jfRRlyuauwKOraOKfNqb1RRYZUqoJDbajmYNwhZCjBUVLhh28BwaRaYxWPFnsuiOBE5g
         BvvMZ2b9URdSInfxCLZpNcgLuoUsFBX6/dT3Qmf0pVODZustiyQ5KzmW8hK5BHn45iy5
         dfeA==
X-Forwarded-Encrypted: i=1; AJvYcCWC+90lXG+rb3NzXa62DziMFexL7bzJA+togUzDbqBYWogtMWk1IAixmzyFT1NGgrJX2m8pSNECvkQ1NXs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpZxsF0TdfKqnvkSXNH+jdAvF6uTzF1PTANLubReQopi3kf5az
	n/s1cR1bZhO9n43oLy0UZI8AN+1IGGEoDv+n1PGK9jAEajdmRZmeN75uTuZpPEmX9fFLo8up5cs
	DtEZDbYlSvyXW/CzNKca7qoCpOoXH6zxVjlIVOu2QTCembHOCQEd1vtTAXNb/e3aluw==
X-Gm-Gg: ASbGncupo8V+vzgoTHp3sqGVhuH5kOIABWd19/KCCeg2hT+DBxD1gAfLhqi2gETs7Yb
	ttetfEFwaV44xzvg3Td9jiWcs6DSNscdvJGkbfKCgd8TvSl1q3KAIGvzoultOfIz/FuKMU4d2LC
	QnnCQP2YpxVqXbYuGspueW2MewqQcPRbJA2q1bi8NBVtmqCLHEZukL5kv+RTfn/+YlJb/4UOiix
	AtB9gIYgzZNPUf+vUApAJcVmoQtxCZPUfczWAEOXeAblNuuyUfGCRoUqrf28efSCOAizmvuyGJO
	1F1rQZna5xZVPna0wR+HRkNnfUrxi0OFG/bhWUecGLhiroCRvn7ObD805Oku
X-Received: by 2002:ac8:59c3:0:b0:4a5:9b9c:2d9f with SMTP id d75a77b69052e-4a9e92fb39bmr60789651cf.2.1752160893926;
        Thu, 10 Jul 2025 08:21:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEssxFzmy5DZaFLWrhwRKaLprHY91yPLmVxKn2VUF7H3TGYR0HmxKyVMLk0dM4mEtgHsRmiqw==
X-Received: by 2002:ac8:59c3:0:b0:4a5:9b9c:2d9f with SMTP id d75a77b69052e-4a9e92fb39bmr60787681cf.2.1752160892253;
        Thu, 10 Jul 2025 08:21:32 -0700 (PDT)
Received: from [192.168.1.3] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a9edeee2c2sm9654471cf.74.2025.07.10.08.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 08:21:31 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Thu, 10 Jul 2025 11:20:35 -0400
Subject: [PATCH 15/15] rtc: rv3032: convert from round_rate() to
 determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-rtc-clk-round-rate-v1-15-33140bb2278e@redhat.com>
References: <20250710-rtc-clk-round-rate-v1-0-33140bb2278e@redhat.com>
In-Reply-To: <20250710-rtc-clk-round-rate-v1-0-33140bb2278e@redhat.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Akinobu Mita <akinobu.mita@gmail.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Heiko Stuebner <heiko@sntech.de>, Andrew Morton <akpm@linux-foundation.org>, 
 Avi Fishman <avifishman70@gmail.com>, Tomer Maimon <tmaimon77@gmail.com>, 
 Tali Perry <tali.perry1@gmail.com>, Patrick Venture <venture@google.com>, 
 Nancy Yuen <yuenn@google.com>, Benjamin Fair <benjaminfair@google.com>, 
 Mia Lin <mimi05633@gmail.com>, 
 Michael McCormick <michael.mccormick@enatel.net>, 
 Heiko Schocher <hs@denx.de>, Parthiban Nallathambi <pn@denx.de>, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 Maxime Ripard <mripard@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-rtc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org, 
 Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752160847; l=1946;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=5ZVOk+ZOrENo582GUq8LCq+7YYXjCzCCpjXuZ1lV7ck=;
 b=DT4kedVd9JHLVr7GcGFwVFd+HuL+eV6cYmrDz6pnKaO4779AT/8pJh1xVZGoHYgcUbXEwBISq
 HkwA/DTaq7wAhW2EXESEGcFAJ+P+8vXhpwlHpiLGX//6sA6oikBaxHi
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

The round_rate() clk ops is deprecated, so migrate this driver from
round_rate() to determine_rate() using the Coccinelle semantic patch
on the cover letter of this series.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/rtc/rtc-rv3032.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/rtc/rtc-rv3032.c b/drivers/rtc/rtc-rv3032.c
index 2c6a8918acba50e57ed923db0834c7c4620ef2cd..b8376bd1d905be63afbcbc688825c0caff74a3b5 100644
--- a/drivers/rtc/rtc-rv3032.c
+++ b/drivers/rtc/rtc-rv3032.c
@@ -646,19 +646,24 @@ static unsigned long rv3032_clkout_recalc_rate(struct clk_hw *hw,
 	return clkout_xtal_rates[FIELD_GET(RV3032_CLKOUT2_FD_MSK, clkout)];
 }
 
-static long rv3032_clkout_round_rate(struct clk_hw *hw, unsigned long rate,
-				     unsigned long *prate)
+static int rv3032_clkout_determine_rate(struct clk_hw *hw,
+					struct clk_rate_request *req)
 {
 	int i, hfd;
 
-	if (rate < RV3032_HFD_STEP)
+	if (req->rate < RV3032_HFD_STEP)
 		for (i = 0; i < ARRAY_SIZE(clkout_xtal_rates); i++)
-			if (clkout_xtal_rates[i] <= rate)
-				return clkout_xtal_rates[i];
+			if (clkout_xtal_rates[i] <= req->rate) {
+				req->rate = clkout_xtal_rates[i];
 
-	hfd = DIV_ROUND_CLOSEST(rate, RV3032_HFD_STEP);
+				return 0;
+			}
+
+	hfd = DIV_ROUND_CLOSEST(req->rate, RV3032_HFD_STEP);
 
-	return RV3032_HFD_STEP * clamp(hfd, 0, 8192);
+	req->rate = RV3032_HFD_STEP * clamp(hfd, 0, 8192);
+
+	return 0;
 }
 
 static int rv3032_clkout_set_rate(struct clk_hw *hw, unsigned long rate,
@@ -738,7 +743,7 @@ static const struct clk_ops rv3032_clkout_ops = {
 	.unprepare = rv3032_clkout_unprepare,
 	.is_prepared = rv3032_clkout_is_prepared,
 	.recalc_rate = rv3032_clkout_recalc_rate,
-	.round_rate = rv3032_clkout_round_rate,
+	.determine_rate = rv3032_clkout_determine_rate,
 	.set_rate = rv3032_clkout_set_rate,
 };
 

-- 
2.50.0


