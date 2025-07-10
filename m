Return-Path: <linux-kernel+bounces-725988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11802B00658
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 17:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A49AD58756E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 15:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4B9274B39;
	Thu, 10 Jul 2025 15:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LrkRxx9c"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7E32749C3
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 15:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752160860; cv=none; b=K0v9xePvRoCXkoDKMhVmXoJJM1x62u3f85XpBZTfAlKIgmK+C2BiB4nK1ZbcTRUVmP4ADeQD3zirk6FJi9v4JzDL/gz0gkXukshcNm7NRL6NEUt0kGFoiot2Kz0oMygmIRRW500wE0IL/ovKJapMn3ci0PNy8jEWUHeWRuqFZBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752160860; c=relaxed/simple;
	bh=wnFIaXx40Vz/ClvnEh6f8bTkAdbeJwxG+N4rRNHdiSk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ahdAVVR/MoJOsiJ2tY4bFnZezSR2XZn2kkFnTm2zcLhGfbsAiM2LohM788T+Xu8OsxAPnTGhx3YPYUrgijyGtr3aAmWDCxr50gyLmn+WAsXlaHOvyNrX1S5Fc9xS4cZOgBmX1lCn1TkkCzsQxU7Y5Vv++3NbTT5lICgwvPZAWoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LrkRxx9c; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752160856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LHPBpe2ME5Me1EAnJ5XGIYrRbZqrmoRVe5YJ3r8jZqs=;
	b=LrkRxx9csUNkBQb7nG+NYro2dI/ar71p3cmElZ8B3yQzG+LMYgBBfiARhYd+KsknVoqy5p
	rgZV97kCxOmqUUM+Ri/w+HV1GamZskBLeWLwLGgey9PKkwMgzgJT4G29pt22QS5+/fCCYL
	SyzeNUX5PMRMrP0kXW1IIcgc46w1/TM=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-5b1dSGVzM86X34-68PSa6w-1; Thu, 10 Jul 2025 11:20:55 -0400
X-MC-Unique: 5b1dSGVzM86X34-68PSa6w-1
X-Mimecast-MFC-AGG-ID: 5b1dSGVzM86X34-68PSa6w_1752160855
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6fac216872cso23568886d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 08:20:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752160855; x=1752765655;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LHPBpe2ME5Me1EAnJ5XGIYrRbZqrmoRVe5YJ3r8jZqs=;
        b=L7aiHvqe9Kf9p0oapjgleFNkGye5puW19uSFWwMKWBMldX5CphYzS6pdo6TtNgQc+E
         g0z+64cQOldFPGQPAvW55FXzjdKkNTFRskCE6l32qhx8ny7DdbHyiVFqkxLdq/TeKYPW
         iA5JyoyyVTIyQoG+FsfICadYeqyL+iR3lGw3ns9WWQVEqXRNZP+9GGyCigAbUcu+UiWU
         xOUDx468UCwSkojNhxM9GrnTMRJVJw7g7Pj4Q77TtCO5tyjnPVY2lkWCcQHf+HoIfpDl
         xyZsnNhgHrRuzoLHpq6cwQCGUGO+B9owwXkSlWWo7UFY5yPx91FTXsbNS6pHNaf6BrhL
         +hyA==
X-Forwarded-Encrypted: i=1; AJvYcCVqxXbCU5uGgdj7Fs0lXrV2yI/dy2IqSD/gR6Q/zQcmk7IaIatb7OFpBeCn0+El1LJzTnF2h7o0I+SF88U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXXniTMtYvRs6BdCpwLH92Ayx8vIlpcv2vS9Z1PbpVYwRWL5BR
	XkT7EpHs3+7j+OZ/OEOKU/Yh3+6fDgljUADqrMyl8ABuvG9Q2LOp4ZlOIzXcwuDGhqHK790/IqV
	1RrmNQ9q5foqo+P1uT7w3mlQI4EBcb1xxVVEN4JxtywNv1pSY9m6bC2tuS0NWg1RljA==
X-Gm-Gg: ASbGncsTOpBNG4bNP5i9U4+6cIXkpNUsKAlqlXoQNnR2mp66SMY5L80Z8tjdOfGDSD+
	jNZaHhjpqExGHFeMeg09QwMw2chI8W7Ui0RKciVc+LWNDfrbDocmuACdV2Wjoj1x+4j2zqfxhqL
	mfisk4U+RkVSxFITACRSjh6sjfADDZiYScvxI3+c1rYY92Dz6K4xHUtZNf7qN0oOTc4hNs2/i4Q
	B/rJg9KpoMZzX/tjsq3//LXt/0ipLQZjT9g6bxmg+GWkHbsMWi1czvZ5kwZdAkfLjKP8/OBvb4m
	EAQkxpJNJ4BfxCDM9Sc2yIyDqQwnoUwbcfE0vyU3N0iEcAAskDXgavf7leWT
X-Received: by 2002:a05:622a:101:b0:4a9:e276:2fb7 with SMTP id d75a77b69052e-4a9ec7ca38amr47392641cf.29.1752160854890;
        Thu, 10 Jul 2025 08:20:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDLcNv2lDHhPRuPa3PBLGRvRknazi0MkGkMJ3jjn/hzszBgqiL8MPXlo3Ug0921v1/TzKKEQ==
X-Received: by 2002:a05:622a:101:b0:4a9:e276:2fb7 with SMTP id d75a77b69052e-4a9ec7ca38amr47392181cf.29.1752160854435;
        Thu, 10 Jul 2025 08:20:54 -0700 (PDT)
Received: from [192.168.1.3] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a9edeee2c2sm9654471cf.74.2025.07.10.08.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 08:20:51 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Thu, 10 Jul 2025 11:20:21 -0400
Subject: [PATCH 01/15] rtc: ds1307: fix incorrect maximum clock rate
 handling
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-rtc-clk-round-rate-v1-1-33140bb2278e@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752160847; l=1091;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=wnFIaXx40Vz/ClvnEh6f8bTkAdbeJwxG+N4rRNHdiSk=;
 b=+A8YUXgylGkUHOwIsLqyv4get20Ku0mnYqFwH3tYHrj3MlQDQaPOSNxpmXm2HBwGJcu7rJVBN
 2qwZqI6Hq0xA8ZZ0bQnzaWsxGGatsZPg2KaA+vl4sQUtpFK6xQIbwo6
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

When ds3231_clk_sqw_round_rate() is called with a requested rate higher
than the highest supported rate, it currently returns 0, which disables
the clock. According to the clk API, round_rate() should instead return
the highest supported rate. Update the function to return the maximum
supported rate in this case.

Fixes: 6c6ff145b3346 ("rtc: ds1307: add clock provider support for DS3231")
Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/rtc/rtc-ds1307.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-ds1307.c b/drivers/rtc/rtc-ds1307.c
index 5efbe69bf5ca8cbc2a325cf2797afcd14f3760bf..c8a666de9cbe9163ab7e112b01b99d97c94970d3 100644
--- a/drivers/rtc/rtc-ds1307.c
+++ b/drivers/rtc/rtc-ds1307.c
@@ -1466,7 +1466,7 @@ static long ds3231_clk_sqw_round_rate(struct clk_hw *hw, unsigned long rate,
 			return ds3231_clk_sqw_rates[i];
 	}
 
-	return 0;
+	return ds3231_clk_sqw_rates[ARRAY_SIZE(ds3231_clk_sqw_rates) - 1];
 }
 
 static int ds3231_clk_sqw_set_rate(struct clk_hw *hw, unsigned long rate,

-- 
2.50.0


