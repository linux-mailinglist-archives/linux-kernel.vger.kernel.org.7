Return-Path: <linux-kernel+bounces-725992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60778B00665
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 17:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 161BF1C85E3C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 15:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF37275AE4;
	Thu, 10 Jul 2025 15:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FcWTmnFA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDD22749D1
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 15:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752160868; cv=none; b=O0kx0i5JwUbCQf9+yWBQRP0wBFBybVHMSpkMM7D6BEc7wl3INdyZes/Itsk9lxhMSP7B+OWSjaVC1mYIJo2YzQdSJcwOOWNcJJS2gBlL5fJiVQ72Jdv2b0MDcZojhCKP8fMWEj+d1Kn0XyWUibYt81uAD2H1CPPc7jttvYeJXfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752160868; c=relaxed/simple;
	bh=nWaA+HGMB/hr+CPDhX2qLiaYTUyyKgsFz2YzXzkX8VM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lqcu7CUqI2FuNyN/fQx7kcX4nH2vHQ9w6p009AC2n55q/tSc8brTFlQX3oJ24us00QSu3+eToVJh2agpIIwjqdVg/Lr5T/pv5a8y+u+OjITvLFSjGItzdYBdT3GNL3UD1eIyqpkuiR9etw8bzpUTKBPcibYxL5lkxRI8EqNnc5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FcWTmnFA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752160865;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yG5bkOzZUY+xOdQihr3txHpC6oZgJ7hI28ABbFz0yUw=;
	b=FcWTmnFAJ8STy39JdiQE1NSGSvY8kEyRWGjubB/ywxnOL6UWeyVw13SgcF95GCrwxi/425
	/CaJJahgsasALKrmfR2/BPz5M/YGlt6qjfrkQi80Nc5P9KKvYBi2UOG0EMAFNi91wfl0+w
	luHDPx1MbAkBQXb0MoBhx+WPIsxejtY=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-KLJ21hcqNkaadSg_y6yQWA-1; Thu, 10 Jul 2025 11:21:04 -0400
X-MC-Unique: KLJ21hcqNkaadSg_y6yQWA-1
X-Mimecast-MFC-AGG-ID: KLJ21hcqNkaadSg_y6yQWA_1752160864
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4a587c85a60so23108111cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 08:21:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752160864; x=1752765664;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yG5bkOzZUY+xOdQihr3txHpC6oZgJ7hI28ABbFz0yUw=;
        b=YbGsRPhZ+moBUl2bg5XmbLLIKBPYjhMny+PiFodAyky9eVTa6SUoJ24SgT/60UkwIn
         P4eflVhO2r4c9byYAqD8xLv94JaQaNG6SDIfw0uzRdPfS+4xusfnEo4KTS/wJdmCULt+
         sJXq3VK8CS0rsVH7T5AaIIQp0ND1o9veBZu5fXOcIVjCJfdhvmav4xenBpxKSgY8+B2G
         MtYKY0G31fd280Xk8wK8Gezi+nyWZVsgiSL43jRr8tqE2aQbz3THP1Yk/HO8OM7Atd+T
         EHuhP39mT83P4CMLKg7rdClitq6va4tVEZUL9zkL9IXnt6NCRrsUQ7CJwDJAAYtgwP5j
         dYUg==
X-Forwarded-Encrypted: i=1; AJvYcCVZVKWa1Qq2QE+TL1mCmkbo3UNpnM3lLFdMPmIH7lUFUXiywKVdoAJJXTjnybf/0h4uy2DMhsDcByjfSrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy762ShzTDoZ03O6je5YiAlmyCdHmUBWhkhMLpcLkj7Khh39I05
	YG0EDiNs0HHQFTMZTJIi0fsJz1rs9xLG5sXHiy8GbXGcbInan1nQ4Qvz5ZxwXzVfAa6gF6n4t9C
	Jm57UdY2gz59LZfcfVrDuiVWy0tewoUadZA5nEHNtbwY0DsvVho32PEJsNyXCh1P3Jw==
X-Gm-Gg: ASbGncutVNm50c98i5fyCnE0c3nVysUppobe4pOKn5X8p44zWAZKcxDshgyja42n89O
	77HBJOAWcR/NiLVsSqLVJ+CycUYTqxQNkJhWV1Vw66qFjqhZbUMFwJo7svOIXgIH+tfQB2xSsIq
	C4zzBUOd99ruVq1b1tBFcY+HxLE10OLM9J6G2GZZihuYhJoJFvXM81soquv+2fgnvorySF0CD59
	eiQnCsJE4d34FTMARGSFRgauY5kbCx39jbeFEHZcrN2WPspnF2pvvMetiSAOsgaVlYil5KI76Gt
	GitXhdT6tNJQQ96iGctmPzjxNYBNV7cYSVb6Zvumwm5x0il6IHeoBzGdMhFo
X-Received: by 2002:ac8:5fc4:0:b0:48d:8053:d8ee with SMTP id d75a77b69052e-4a9f80b01e5mr13972261cf.36.1752160863627;
        Thu, 10 Jul 2025 08:21:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGbBjxTN72GrQJfmGHmh5GutnlL3Jy0awPkDx/UBr/xC/UFSavAHZjx8i1a7+m6MXPSWw2yHQ==
X-Received: by 2002:ac8:5fc4:0:b0:48d:8053:d8ee with SMTP id d75a77b69052e-4a9f80b01e5mr13971891cf.36.1752160863202;
        Thu, 10 Jul 2025 08:21:03 -0700 (PDT)
Received: from [192.168.1.3] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a9edeee2c2sm9654471cf.74.2025.07.10.08.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 08:21:02 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Thu, 10 Jul 2025 11:20:24 -0400
Subject: [PATCH 04/15] rtc: pcf85063: fix incorrect maximum clock rate
 handling
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-rtc-clk-round-rate-v1-4-33140bb2278e@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752160847; l=1097;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=nWaA+HGMB/hr+CPDhX2qLiaYTUyyKgsFz2YzXzkX8VM=;
 b=Lc/rH1BiGcSbq2l1trnogE3RK5bqbOllXcvhH/uU8m1h7QmCtOaFdEaqj+3itCdqF+FJ+ZtvD
 IuHO8XuPF2bBnY19Dh4DVmMOl8w+cCTosu7fjfV3J5ukBMCZo79gcY0
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

When pcf85063_clkout_round_rate() is called with a requested rate higher
than the highest supported rate, it currently returns 0, which disables
the clock. According to the clk API, round_rate() should instead return
the highest supported rate. Update the function to return the maximum
supported rate in this case.

Fixes: 8c229ab6048b7 ("rtc: pcf85063: Add pcf85063 clkout control to common clock framework")
Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/rtc/rtc-pcf85063.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-pcf85063.c b/drivers/rtc/rtc-pcf85063.c
index 4fa5c4ecdd5a340e6048b0d7d1d9590cff41e8fb..b26c9bfad5d9296ca8d2be3b5ecb04c19ac97191 100644
--- a/drivers/rtc/rtc-pcf85063.c
+++ b/drivers/rtc/rtc-pcf85063.c
@@ -410,7 +410,7 @@ static long pcf85063_clkout_round_rate(struct clk_hw *hw, unsigned long rate,
 		if (clkout_rates[i] <= rate)
 			return clkout_rates[i];
 
-	return 0;
+	return clkout_rates[0];
 }
 
 static int pcf85063_clkout_set_rate(struct clk_hw *hw, unsigned long rate,

-- 
2.50.0


