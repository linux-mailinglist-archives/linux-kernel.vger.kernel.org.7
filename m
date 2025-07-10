Return-Path: <linux-kernel+bounces-725996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65953B00672
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 17:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60E021894B07
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 15:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FA6277CBA;
	Thu, 10 Jul 2025 15:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hUe9MUUH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF048277C88
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 15:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752160878; cv=none; b=ESEBdkKNWRW8VHq5CaT8g8c7fmYhkS53WNo01AN1O5kTaxHGpDWD+rF7Wjw96XhBIkueFYKQWiqgTWoFZlvQa9UQmt1DhGqAXeqtckmCKi61HOj6ZCF7HZ0CTS/X6XbkHe4TIVqSDq3XrRv2+Pn9/yLzhXWHE5n6S6QJpSe6EKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752160878; c=relaxed/simple;
	bh=HosgLre4sOV32zuup5VY1mXTPGrX7i+9z9+0wka2BHE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k1IOS0CnFpuAv/0mUPZD8q8sxnl8biaB0kXcnU0ag6HgmVBEB7XPxUo9Pcl3ZK/S/EhPcnZae1ZhEkLUSzYarWwJIZIXY2AnaT5JUCJX6CSElt8HjwOHwFXJ7O++HSpdAfMM2whSGupZwPD0OEvVNN6M0i73pg1588LffJkvhmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hUe9MUUH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752160876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yh9qOs9b+m1+CWu/fchTdf6WvDYvTJKqRPUm/8N3WTo=;
	b=hUe9MUUHs39cU1xVZkD0KITJpujYwcPsMwsvg8dZ1NL5beplwpjw0d9h4IHyxvPi9vMD7h
	ZSQLB+xt0yR0pM5OrSPs/O9esRVypPoKKjnRfDP9Xh9goFlgkERtHU6aQR3ovstLiFIGkG
	CkkSfqMX7HAChdgZ9pZpq5/fWRdWVRI=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-0JnRnBgfOO6ug5tYw1pXZw-1; Thu, 10 Jul 2025 11:21:14 -0400
X-MC-Unique: 0JnRnBgfOO6ug5tYw1pXZw-1
X-Mimecast-MFC-AGG-ID: 0JnRnBgfOO6ug5tYw1pXZw_1752160874
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7d40185a630so208512885a.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 08:21:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752160874; x=1752765674;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yh9qOs9b+m1+CWu/fchTdf6WvDYvTJKqRPUm/8N3WTo=;
        b=mDd4iHPLLaX1NETNALenCFKDZ4Adk7h+qGxOV7V9h6kvxCCl+l0VjZIJVxApk9Qdfk
         f7nAJgz9cu7q0BwAc1yUNeAwKoRieQyXN6wAinFNYfqmzknqDyoX0/MZE/RMThaOXwVk
         11Nea5idf8QlTycWE8cqsy+yBD2lamsyHr32ifegpzVtQ3LMatZPEX8GfbD2JRiHStRV
         iggFDZluvnRgy5C8+rO+tqPfDxYPenaXlIbM9uUKz9UusRr1DzSefoNuHHseX1UyXXnm
         lEK45qphY9DAn7Wk9uwXdh3SPVLIpVnxApndAMeHJDxXXhKAq1Ukcrf0ueZPcb0PVQ/E
         daRA==
X-Forwarded-Encrypted: i=1; AJvYcCVD2RCrQEEkTafZXF0BmS2NKNYue2f5S8/KTrJ0rPUHW2HViZGgg1RjMRrRrslkol1SQU5BZHpyzbMItJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFyal+npXoBaawHJxOO8uD/0gjpLgOoHLjAv/ChWLOOL4V1i2M
	1VsEvlRSiqDmLGQu/wSH39OX0qjdeP2wW0uDb+jSrSOSW+68hhRPsMdqzqwf0YZTjFSCBh+Swut
	DWycElTEPrcwJZbCYvi96a/pnrdIvOlhb0wjtgTcZMsgQZtDxIbfPJ4/Vm0wxA4Ctjg==
X-Gm-Gg: ASbGncsLGKinhB4ri+H/NqUl9581fLgeMRyPxunNgST9zGIvbW1VHAf2nlGhnoEFgWC
	LKsiXEukHR2N0cJAcaSs6lX85T3Tyko/iQgwjR1rOWk7s4/V4a62MAQUJnEYeQ3XZv95/5hb3Ya
	T48JBtjgpBPUAG1hb3DqS6IppoNpSTv1JHxIj6WBYzoRJAOTHl0akVNUkv8TgA3SA1EZT+y2oc5
	9DcAI/6ZWOUFVuEPx3B4pOm3d1ux9uOGnftbEgeT1pSX1xwRhXQELbkUjuh7GgohpVPSkmkvIIb
	L4xNpMWpXJAPCFgi/wGSS4xqJGWu+HMC+tuYZCZfqgyVCIZmWA/8qNRt/sSJ
X-Received: by 2002:a05:620a:4414:b0:7d4:277c:7116 with SMTP id af79cd13be357-7dcccbae331mr486939085a.51.1752160874110;
        Thu, 10 Jul 2025 08:21:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5eH9L7io++DOG6EoLD7uLEBnCEDCHEDGmoS7FTL8+M99Rr9LdDHR9Ug5tFrdjn3kFCzmWmg==
X-Received: by 2002:a05:620a:4414:b0:7d4:277c:7116 with SMTP id af79cd13be357-7dcccbae331mr486932985a.51.1752160873576;
        Thu, 10 Jul 2025 08:21:13 -0700 (PDT)
Received: from [192.168.1.3] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a9edeee2c2sm9654471cf.74.2025.07.10.08.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 08:21:12 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Thu, 10 Jul 2025 11:20:28 -0400
Subject: [PATCH 08/15] rtc: hym8563: convert from round_rate() to
 determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-rtc-clk-round-rate-v1-8-33140bb2278e@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752160847; l=1660;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=HosgLre4sOV32zuup5VY1mXTPGrX7i+9z9+0wka2BHE=;
 b=ub/cp96oaMsM4GvzWf+fAuWAKwOmG1F2KhV0jGfn1QS+ylEuMZ1/zZzX8TbakzDsX+uDxdWl5
 YBJs96EaePoDm7hbah3U9wXmseNz+pETLmzurmldCyeTiHswKmzq9vD
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

The round_rate() clk ops is deprecated, so migrate this driver from
round_rate() to determine_rate() using the Coccinelle semantic patch
on the cover letter of this series.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/rtc/rtc-hym8563.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-hym8563.c b/drivers/rtc/rtc-hym8563.c
index 759dc2ad6e3b2ad57072b35a2642ec5bb78cd98c..7a170c0f97109f9a2bc08946845cb8bb5a377bd7 100644
--- a/drivers/rtc/rtc-hym8563.c
+++ b/drivers/rtc/rtc-hym8563.c
@@ -285,16 +285,21 @@ static unsigned long hym8563_clkout_recalc_rate(struct clk_hw *hw,
 	return clkout_rates[ret];
 }
 
-static long hym8563_clkout_round_rate(struct clk_hw *hw, unsigned long rate,
-				      unsigned long *prate)
+static int hym8563_clkout_determine_rate(struct clk_hw *hw,
+					 struct clk_rate_request *req)
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
 
 static int hym8563_clkout_set_rate(struct clk_hw *hw, unsigned long rate,
@@ -363,7 +368,7 @@ static const struct clk_ops hym8563_clkout_ops = {
 	.unprepare = hym8563_clkout_unprepare,
 	.is_prepared = hym8563_clkout_is_prepared,
 	.recalc_rate = hym8563_clkout_recalc_rate,
-	.round_rate = hym8563_clkout_round_rate,
+	.determine_rate = hym8563_clkout_determine_rate,
 	.set_rate = hym8563_clkout_set_rate,
 };
 

-- 
2.50.0


