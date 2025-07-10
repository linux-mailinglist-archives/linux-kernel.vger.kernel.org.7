Return-Path: <linux-kernel+bounces-726000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A4F8B0067F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 17:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 989ED189A991
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 15:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E17279795;
	Thu, 10 Jul 2025 15:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="agSibTV6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B30274FD0
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 15:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752160889; cv=none; b=tx4CsDstEH38W66MaXmRe+UqmIR6iIRrH3PABY7lgFDnIXuvmsZfETfhqF6q8rg19QwsP8EJC4fDkL/Rc9BzXIHlrmgurUivevruk/LyDw3i/H22gWsTSJi/Ya/YsTFRCDuPf5ooS7RdHYuKKI7KtqlGu3R2zVuZwsfbBOAEn44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752160889; c=relaxed/simple;
	bh=CKo9LaRRqcp1kervDO8TcSEMoHxesfYK30Hcksflj70=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Mr4z2Q7pmOoCjheBdOP/5M+nn6fvYy9D06xha03GnPEYJ3fitpCaJ/2wBw2M6OFgp57f4cw7SpMhl7fPgAGKA9GtN5FVVCK7P33laEEPZYPonuWmMZwpScoEM4jj1wcTVSeGSFKUP/9r0E/B5QVrGZ7RQRD+gu0LSH/GAqSwvFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=agSibTV6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752160886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YHrxzt6oBAK7nbUlAaS6YSCPJAz4yjcPZzUXcr60eqQ=;
	b=agSibTV6pMwZOo/oBUfRuxu7MsCoTpGW0QZ+WqY0q5S/bcrZ2OsDp672oUodYfPgQoBDrQ
	naW86nAGk1c//WUzT1RGfCiIeoaDZcXoKZ2Ry8V1p2BfOcS0mUFbt3aPLyJhwdyt+d2di1
	Uiv0kNANgbD7SDj3jjLcQO/DhynjoLs=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-s4D5Z49zOheE4agAjOlPWg-1; Thu, 10 Jul 2025 11:21:25 -0400
X-MC-Unique: s4D5Z49zOheE4agAjOlPWg-1
X-Mimecast-MFC-AGG-ID: s4D5Z49zOheE4agAjOlPWg_1752160884
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4a9764b4dc9so19942051cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 08:21:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752160884; x=1752765684;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YHrxzt6oBAK7nbUlAaS6YSCPJAz4yjcPZzUXcr60eqQ=;
        b=GQLXnORzb2igq1lS9GJLL6oyspLMHms+Ogc7sISPhkyFxw4jesxqWb8XMSKBx2A7We
         f+ZnR5BtIJVZ7PomKEEjopQHlZq4lb/giTNTLsGF6T/L/J9P84mN2xMMfHHV3bkjuI78
         MLB/8sBGXr/zJ88tvu4ee+JCmv81x0Stp+2e8pirTNlUAFMWsmG9OluIKm5C9+DeoX7M
         4afw9U9zs695B7a4rFAh/XD3pi/Nknh0i/pgOBHTZu/4m7E9Q/YD00Gd6ROBgJpE31Za
         EN6D1xOfIyztIedkF/qtGVgz4pjnLJNPCyEyrB3tQY4ypQKNb2/pGiu5DMX/dNNUKiEy
         CCHA==
X-Forwarded-Encrypted: i=1; AJvYcCX8QR7zseBelOPbuM7zC0klNf51hWYkzKqkdxu73eqEg7BKN+QcV+xEqELicdGsuy11nkjiItfw9qFq7II=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoyVNnm0yYDGR+atNZjCWcxpOgaGqHrQmdnN3s9Nl05RotQyfq
	2Kw1aVIJoIROD4UPQsm+52fjHhBWHVVqKmJu7oFow/CaK0J1VZf3xvrWaJv7CX1NKw8YLch3TLH
	9W0T7mmw5HMRG6b9k22CKeHsbEwqmBAPrlDvNuY0tXQYENe8qu43Xyc5nF7BDHteB7Q==
X-Gm-Gg: ASbGncvB5jZIwRioVmAipWNFf+JiFgb6LjOSdcAUSoD2Uem0/ZmaEHPZIKqVEcHGl6v
	rz2W4s/OPwjE/AN9N2oBH4u6BFEHa2iDBr4Ew43rYW8/3IjmxhNZPrEfEIhi6iqHXvR33Z3ZdA5
	+bKI7JBAO8xrEMDqYPFLQh8HML/h8imOndU94gKY9YHY/tbneJlerFKaPr5E3nrlQcC/hdop2ZZ
	8gHpsC4Yog4INooI6e1nPTdWUpG8Iu9A7/2sEFRdnsNabQEB8wL21EVemKBjO51IOJ2qFGqXxUd
	LDsR+cWdwjsH58sPmhorq1g7zqTOmyACqoWFinnBMadwYS4fEZW7UeNkPtPD
X-Received: by 2002:ac8:7dc9:0:b0:4a9:957e:abfa with SMTP id d75a77b69052e-4a9ec768310mr46701641cf.20.1752160884382;
        Thu, 10 Jul 2025 08:21:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExNE2eoKe+QdzlIFX9zvN4NAZlfmpgtS7RXKYKxt1/AsAPcsp5gHofzn/kMZ5xQTYoVqGvIA==
X-Received: by 2002:ac8:7dc9:0:b0:4a9:957e:abfa with SMTP id d75a77b69052e-4a9ec768310mr46701151cf.20.1752160883963;
        Thu, 10 Jul 2025 08:21:23 -0700 (PDT)
Received: from [192.168.1.3] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a9edeee2c2sm9654471cf.74.2025.07.10.08.21.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 08:21:23 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Thu, 10 Jul 2025 11:20:32 -0400
Subject: [PATCH 12/15] rtc: pcf85063: convert from round_rate() to
 determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-rtc-clk-round-rate-v1-12-33140bb2278e@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752160847; l=1678;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=CKo9LaRRqcp1kervDO8TcSEMoHxesfYK30Hcksflj70=;
 b=9VCibQW5+lIsm2ZJtIf/1irsi8yh8liaiSDjxvieKKChnEbb58K3vG9919ehBKwAvx8GcyTT1
 a3/d+7m2/QtCzE6zvrB6HQv5fQ3ZG9FGj7pXg48gJgO0YwcR8r1xjEv
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

The round_rate() clk ops is deprecated, so migrate this driver from
round_rate() to determine_rate() using the Coccinelle semantic patch
on the cover letter of this series.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/rtc/rtc-pcf85063.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-pcf85063.c b/drivers/rtc/rtc-pcf85063.c
index b26c9bfad5d9296ca8d2be3b5ecb04c19ac97191..779fd627262bde8429ae48735ca591747f871025 100644
--- a/drivers/rtc/rtc-pcf85063.c
+++ b/drivers/rtc/rtc-pcf85063.c
@@ -401,16 +401,21 @@ static unsigned long pcf85063_clkout_recalc_rate(struct clk_hw *hw,
 	return clkout_rates[buf];
 }
 
-static long pcf85063_clkout_round_rate(struct clk_hw *hw, unsigned long rate,
-				       unsigned long *prate)
+static int pcf85063_clkout_determine_rate(struct clk_hw *hw,
+					  struct clk_rate_request *req)
 {
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(clkout_rates); i++)
-		if (clkout_rates[i] <= rate)
-			return clkout_rates[i];
+		if (clkout_rates[i] <= req->rate) {
+			req->rate = clkout_rates[i];
 
-	return clkout_rates[0];
+			return 0;
+		}
+
+	req->rate = clkout_rates[0];
+
+	return 0;
 }
 
 static int pcf85063_clkout_set_rate(struct clk_hw *hw, unsigned long rate,
@@ -482,7 +487,7 @@ static const struct clk_ops pcf85063_clkout_ops = {
 	.unprepare = pcf85063_clkout_unprepare,
 	.is_prepared = pcf85063_clkout_is_prepared,
 	.recalc_rate = pcf85063_clkout_recalc_rate,
-	.round_rate = pcf85063_clkout_round_rate,
+	.determine_rate = pcf85063_clkout_determine_rate,
 	.set_rate = pcf85063_clkout_set_rate,
 };
 

-- 
2.50.0


