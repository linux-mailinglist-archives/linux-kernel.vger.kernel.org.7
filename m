Return-Path: <linux-kernel+bounces-726002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 365F1B00688
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 17:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E36EB160322
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 15:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FF1279DA0;
	Thu, 10 Jul 2025 15:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KNYuRFz9"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DDE2798F0
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 15:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752160894; cv=none; b=JWljF8gybYZpbwgdMsk7HyhPLFclv+DArj5WFsOa6erKANbRmVPJXfIf9jB+ZeEacNJuhNnMN8UZm6WtvbEsxIkT0l1QXGgxJZByX60lz8m/7a1LIO6Quo4AsdaKsIriyLd/lGmH7+eH2XAdtUGJ/CLUc3s6kPBO86peptFT5uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752160894; c=relaxed/simple;
	bh=1K6+kw78MFrCZuqcS+uDVaMjkGSwFqJNnx34G76ScJw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U1eRToJ6Pdq42oeMGSx0C0wJ++akAnagfENL87+k6QEiYqD22DsvMU2mca/SsG1HczrPkzPT3xmUf5M78/eWOxqQkd0p4439Xhms1ruUYTxKMtjA/1sxbfXw/mpZZk8bzOj8Tn5qCVKhCsKbkoQO7rq2Y35Jz+n8TiAfeZ1dGeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KNYuRFz9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752160892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kM4qis1G6x/IJ9CWKOJFCIPRe8ZKC/8LK84o4mYpD5Q=;
	b=KNYuRFz9L60ub8CSLFwHUu3vpsezmpyNnheTpJAVZphV/8PBS7Bna55TwXWvy7skuXmIYN
	hsm6+l9mrYsdcp/HSc5wSh5lDiyC6x/Gc5BHNK+6gpxZtuZUMB9JjBjNTD5GhDErvwRAjz
	NpDyQeXGAmrd1M7HkJb/cazO0U868tk=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-_MolQNqJNDKvYu3u4dzOww-1; Thu, 10 Jul 2025 11:21:30 -0400
X-MC-Unique: _MolQNqJNDKvYu3u4dzOww-1
X-Mimecast-MFC-AGG-ID: _MolQNqJNDKvYu3u4dzOww_1752160890
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6fb1f84a448so11376096d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 08:21:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752160890; x=1752765690;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kM4qis1G6x/IJ9CWKOJFCIPRe8ZKC/8LK84o4mYpD5Q=;
        b=UOE9x47nCH5+yIcCzwe0WuhIsZWIsOaAkYJH7rr7ZaKKNbWMbpXhSIFrornmUf+m00
         M/DQyBny3ssdFyQCPqDL6cyJfIozamz+6hJK/5iCLS5vSL6LAxCDMRNSH0CQd+5w/99B
         /2c+rIlTqco0OWLZq/cHZYhJbw3mQf08o1rofldETXHOnPmBH0TBn2Mkh2R54DU7IuKZ
         ywPo7kUXfLRtOn1EGHH5TdYqk7cBRxC3p+MzYvqcivI3jtD3jvdry/5TsRYVkelhDJoH
         wzI2swyXyQgLfMT1FA4hVP4z/i8FI4lPt81D33HGBagLBP3izcE3hPjiZCSemijilJVh
         NrOg==
X-Forwarded-Encrypted: i=1; AJvYcCX/rMF+sARuSDsEKxgT8ta/++x4F4F/T54jc87YmYky/zfvbPI9641CRFqrYVWTEYIXvmhLR6q8PuZncbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTobZCzLtmjTz/O8S6ZZIH1V7GtHlIy/YD2f2Xo7ac/xrXz8lM
	+E9YjIHlJeYk9lfbb3pgcDMCWiyvp57zop7WU6BEzIUE6ZWGyhhBfbzIIZ9kszG0qFhAZoxSvCw
	iZwxT90Sg6UfeNF0p9KyAoMhckY1io25iLMYqo7mmjk8Ep5q6/90iwsnidWwxWgGkng==
X-Gm-Gg: ASbGncvPQsGVRy5H2amgxSsKL6HLvJiB0MRVbHkkM+T5cSGLYv4UnD8tkufnX/X/5Ef
	hWmvNQkpefm2UxCbKse/eUwWcEttxlgsnCk17aCuCJER3bnZZgD8ZBh/8OCeGgF92oxp0Uucjie
	uT3DvrY1jbeHAh1G7YlxaeLweoqGYR3fdYgFKsFZQCAnNfmxW20CCzFmXh4rbwPBPvK1pysCTy5
	bqSoAKSBKVsy7/fO4b0A7qvRVCF5A8jwfxtLwWWJwVSuR7yBfmQHu8N9TJcLnu7oiD8ZpkRr7zM
	F+CzPY8Iu8JoPMbAjdu9I4uqLFBETMN9crhPRq9Q0I6lO1ELQHNsrDqXJ9k/
X-Received: by 2002:a05:622a:578e:b0:4a5:afa8:b3f with SMTP id d75a77b69052e-4a9ec71135fmr53584771cf.3.1752160890230;
        Thu, 10 Jul 2025 08:21:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELn9Yyxrnbnbzv+8WIZ291jXoQKfvhFR4df1+Ujd1Pr0EttvM1cwH6sXYLpUMcViqOsgHoPg==
X-Received: by 2002:a05:622a:578e:b0:4a5:afa8:b3f with SMTP id d75a77b69052e-4a9ec71135fmr53584041cf.3.1752160889737;
        Thu, 10 Jul 2025 08:21:29 -0700 (PDT)
Received: from [192.168.1.3] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a9edeee2c2sm9654471cf.74.2025.07.10.08.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 08:21:28 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Thu, 10 Jul 2025 11:20:34 -0400
Subject: [PATCH 14/15] rtc: rv3028: convert from round_rate() to
 determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-rtc-clk-round-rate-v1-14-33140bb2278e@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752160847; l=1645;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=1K6+kw78MFrCZuqcS+uDVaMjkGSwFqJNnx34G76ScJw=;
 b=SGK3029kP4/euTyn5/BgsABWH/oduagDLrCnI0mn6/tcnTK4jthZhARW1z/WusOrcyzA0u+qN
 OAx2xRUZGWcBPB//y/aWqeri4puyAzBmXlLt3nrF5Xeb60q8feOxkwU
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

The round_rate() clk ops is deprecated, so migrate this driver from
round_rate() to determine_rate() using the Coccinelle semantic patch
on the cover letter of this series.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/rtc/rtc-rv3028.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-rv3028.c b/drivers/rtc/rtc-rv3028.c
index 278841c2e47edfefd339f04bf5193f6970ba0c65..c2a531f0e125be7514fb3ad2b11fdb670fb47a16 100644
--- a/drivers/rtc/rtc-rv3028.c
+++ b/drivers/rtc/rtc-rv3028.c
@@ -731,16 +731,21 @@ static unsigned long rv3028_clkout_recalc_rate(struct clk_hw *hw,
 	return clkout_rates[clkout];
 }
 
-static long rv3028_clkout_round_rate(struct clk_hw *hw, unsigned long rate,
-				     unsigned long *prate)
+static int rv3028_clkout_determine_rate(struct clk_hw *hw,
+					struct clk_rate_request *req)
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
 
 static int rv3028_clkout_set_rate(struct clk_hw *hw, unsigned long rate,
@@ -802,7 +807,7 @@ static const struct clk_ops rv3028_clkout_ops = {
 	.unprepare = rv3028_clkout_unprepare,
 	.is_prepared = rv3028_clkout_is_prepared,
 	.recalc_rate = rv3028_clkout_recalc_rate,
-	.round_rate = rv3028_clkout_round_rate,
+	.determine_rate = rv3028_clkout_determine_rate,
 	.set_rate = rv3028_clkout_set_rate,
 };
 

-- 
2.50.0


