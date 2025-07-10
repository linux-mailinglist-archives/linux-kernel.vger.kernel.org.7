Return-Path: <linux-kernel+bounces-725998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3317AB00679
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 17:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 698271620E4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 15:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F867278761;
	Thu, 10 Jul 2025 15:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F5NAG2/j"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB40278162
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 15:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752160883; cv=none; b=PG0GQFi9caGcb8psg3Nbod2DwNJOOfAH1R7khj5cIIwcs6t7gkMnV7xbyaWQdMyY0YrDvZtchtTsSkgp+YDFbxS2/eXoddJ1My/q+UnXhCjcp/DwuBBXquW9toXFz52BsM96qiks0XIiWWnQSvtVU0kH9Yn1VIEIPYdtmOnyD/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752160883; c=relaxed/simple;
	bh=UPXy6/C/RD79zBD8+YjC+4PQ2wHdzGnij5BrRNttYFg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OXjc/twxXR/vTZN+rtKyPZ5htyS0H9Wl0GNqCR4EfZa3qfEjoLiD7HJIOxXm54cRu2H9kdGDrt5UKuykX4Jgzfrw17v8pJL539EeooATbvmndHIzyQ0fEnfqnrEM5ntMQRbOVfn7l9l31R2+a/lCAwG3FE/G4EsXLrhMKL6vCxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F5NAG2/j; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752160881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8TcSjx0C2BwMhGthThgDZI0WYIDHS3xoAOaKbpomAhE=;
	b=F5NAG2/jFx3ypDYZCeAKzWOtPfNQp9Gq9DqzoPR++xBk0iUD6V95Roc4HYyViRFHyYfrMc
	651vt70bsZB7hB5IencFlDFtRUr6b0m1fbGOSzz3tMSDTKxlY08U/rAtyMMutpdewVhKvH
	K2R80l/e1JKoYbgTupNMX87k2GzRyEA=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-5o04CuLXOJyQNM2HjHBcwg-1; Thu, 10 Jul 2025 11:21:19 -0400
X-MC-Unique: 5o04CuLXOJyQNM2HjHBcwg-1
X-Mimecast-MFC-AGG-ID: 5o04CuLXOJyQNM2HjHBcwg_1752160879
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4a819c5fe7bso21832831cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 08:21:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752160879; x=1752765679;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8TcSjx0C2BwMhGthThgDZI0WYIDHS3xoAOaKbpomAhE=;
        b=EW22YC8z22gU5gcDq24GPwLyygKZx4uotdDXO0pNE5RxSCBJ7K7VbPATwNs8mbqMEo
         Q0R+jC4YydvzpAibg821bSt8H7Bq6ulPdUij+gsIno2PpCorKSC6MQMW0l3A+3tXWtzL
         AxK6VcGR8RB3P71Fa7WOmY1kT9w9pukKQdGN7qq1/N/RrdAA0b5TK0veB1t40jX+rbjv
         ye0eCp+tWJotc+dYQJnbKWmbS1B6kROYNayA83X11zTBp4XuXgFiZg9BBLM+NXcPxHor
         idM8FBSIoS5/B8w2cd7IBElIgzgbwWl6tc1FfCTDC5WBybrCZNRpqYddnSaMJnCF7R6A
         vCSg==
X-Forwarded-Encrypted: i=1; AJvYcCW31nQ88a2mIcUkh4Je/V8JVknh1pYnATzDjPaDKA+kEANMLuRwS/q+EidCAX+2kEBPyEW11D8rvPShNOw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZdZl9tH2QdjSWJV9g5+xVUPaN+uur/YernojP1JWJVLCuy0/0
	SCOxIMTo+8aiCRpQqOx/Jr6kaImvqJefjOpXZL+yPWoJo97uvERjysh64WzpGPLyffmmw1+kuT3
	vShSpr/lefmW4tZRT8/p6ZHxgzPEO4dPQXQSzaD+Z8QB4+KF2IhSsogGiZ8oryxNrrQ==
X-Gm-Gg: ASbGncvCiv50m3WSoOaSVFKS+s6X+UzAKg4vBtdEIETb8rQoUllf9KQ3lxSNRhp2IHk
	CMpUNab5ek3p8buMUFRntgcY/91yGz8XUz0/Py+ccEH+pTQ+XXaAdl8tocqZTDmynQTuGkC8Cee
	+5PPHlcOxKZJVAcHdF95IMfOL2tsyr9SbbZgGB5dRniFXkP4A+wLFgiUhrY0B3c8fd9MGCo8RGr
	coX8ZlBhoGiMJcIAt+Rkbk/xT2RHlrvF/DgqkbxAsWds8VfQkODLnwTaTLaO3lNm8OzvZ5vW6k4
	h9TjtjmpTWxmDdC4QWQXcEgQXl4Ba+Ybm1mkgApffGLAP0Nmtb3M5inrRlNp
X-Received: by 2002:a05:622a:2cd:b0:494:9455:5731 with SMTP id d75a77b69052e-4a9dec1f0b4mr69146491cf.7.1752160879124;
        Thu, 10 Jul 2025 08:21:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOYaK+S6nKLNB0+onalYZ18FMGM4SU1Pk1Rw8vuZDxj3sx1uTSsbM+HxfhIu/O6GetrMHApA==
X-Received: by 2002:a05:622a:2cd:b0:494:9455:5731 with SMTP id d75a77b69052e-4a9dec1f0b4mr69146151cf.7.1752160878737;
        Thu, 10 Jul 2025 08:21:18 -0700 (PDT)
Received: from [192.168.1.3] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a9edeee2c2sm9654471cf.74.2025.07.10.08.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 08:21:17 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Thu, 10 Jul 2025 11:20:30 -0400
Subject: [PATCH 10/15] rtc: max31335: convert from round_rate() to
 determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-rtc-clk-round-rate-v1-10-33140bb2278e@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752160847; l=1704;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=UPXy6/C/RD79zBD8+YjC+4PQ2wHdzGnij5BrRNttYFg=;
 b=VczBglJXF7c0OhaNV6IcNJHendkDjPzxJK9SOdtvRnVBdd83JQDd6pRndtaJb0pB6PnPQgE6n
 YzmdtsurZ5VCbLJUyfz/1pItIEplDMwKOk1THQ06/VWvI4nd8eqLOL0
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

The round_rate() clk ops is deprecated, so migrate this driver from
round_rate() to determine_rate() using the Coccinelle semantic patch
on the cover letter of this series.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/rtc/rtc-max31335.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-max31335.c b/drivers/rtc/rtc-max31335.c
index a7bb37aaab9e6e315db70bc6bc0dbaa553fdecfa..dfb5bad3a3691d0968bac78cbc9d54a2ea7662ba 100644
--- a/drivers/rtc/rtc-max31335.c
+++ b/drivers/rtc/rtc-max31335.c
@@ -497,15 +497,17 @@ static unsigned long max31335_clkout_recalc_rate(struct clk_hw *hw,
 	return max31335_clkout_freq[reg & freq_mask];
 }
 
-static long max31335_clkout_round_rate(struct clk_hw *hw, unsigned long rate,
-				       unsigned long *prate)
+static int max31335_clkout_determine_rate(struct clk_hw *hw,
+					  struct clk_rate_request *req)
 {
 	int index;
 
-	index = find_closest(rate, max31335_clkout_freq,
+	index = find_closest(req->rate, max31335_clkout_freq,
 			     ARRAY_SIZE(max31335_clkout_freq));
 
-	return max31335_clkout_freq[index];
+	req->rate = max31335_clkout_freq[index];
+
+	return 0;
 }
 
 static int max31335_clkout_set_rate(struct clk_hw *hw, unsigned long rate,
@@ -554,7 +556,7 @@ static int max31335_clkout_is_enabled(struct clk_hw *hw)
 
 static const struct clk_ops max31335_clkout_ops = {
 	.recalc_rate = max31335_clkout_recalc_rate,
-	.round_rate = max31335_clkout_round_rate,
+	.determine_rate = max31335_clkout_determine_rate,
 	.set_rate = max31335_clkout_set_rate,
 	.enable = max31335_clkout_enable,
 	.disable = max31335_clkout_disable,

-- 
2.50.0


