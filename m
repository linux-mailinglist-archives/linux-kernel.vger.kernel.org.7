Return-Path: <linux-kernel+bounces-726068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C71BB007AD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 17:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 255694E6550
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 15:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9872027CCC4;
	Thu, 10 Jul 2025 15:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KyHjHqHj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BA527CB38
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 15:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752162720; cv=none; b=h1bnPtZKxRfB8NPKcihcWJZvyl2zK1uK1NrJwQi/OYT9rzAK36NpiHO/PooA1NJFqTfQ1LyX4lbkmYiGWi5E0EIkCEErPoz3WDdTY5tS/iIc1vwJPZTA7BAvi0nKVL4DOiR8LJ7VaJnjwvvd03KB/2Jv90xIJLtZrApK7vkr7gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752162720; c=relaxed/simple;
	bh=irsEjDFgWLJcIRLSdB719V4Ehwxr6Hq/ROabLh9M7vY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L9TN2OIiPGAP+Zv0XNR7L4ZBJhKfdq26w2+qDOzcMOn2ZdVYecWou1/QikyD0MEvN5WgNxOddOXIUNcsZYVUynL+DANhKd9stfEYIFHLUBKoXvNkIoOTcN2LTkSRzq7hng0rr/mv42pwiKGLx2OeNO0V/je47WmKorBcT8t7GfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KyHjHqHj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752162717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eG1BadWZpL7H715pVBNXXfvnkpwspQ8t98toz4xLpZQ=;
	b=KyHjHqHjjxi9eXT4dyrK4LLYS9CAF4H9wLEpLOWwRiR4uorNYJqVmyuiK+5LHLLXUnnCBp
	Kv3GqD0iqAS69ELL1NeLTuV8CgNAy7Zxc19pWz81j8vZ31J9nTAGBkXZjhiBzObRlJGziR
	0wHJKufKpPK/P0LCqW17D9TykLuD+9w=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-a6utXvnYNK6xR1qsb6WWFA-1; Thu, 10 Jul 2025 11:51:56 -0400
X-MC-Unique: a6utXvnYNK6xR1qsb6WWFA-1
X-Mimecast-MFC-AGG-ID: a6utXvnYNK6xR1qsb6WWFA_1752162716
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6fab979413fso18705036d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 08:51:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752162716; x=1752767516;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eG1BadWZpL7H715pVBNXXfvnkpwspQ8t98toz4xLpZQ=;
        b=TwP03R3TQJdq8mWnDwcjGcgflvoyDVYElzgEK5v80BPNph8EMlxxEsInm6uMpgY4lm
         qYQzGUwlxOJTnxuKAlsIUoIc/7RBHEYDIRTssJSUw2Xh/Gwt6aEKByZ0dsiWvlqxjTv0
         qpGocaGhRMI6+5LKU4FbyRT4XvKZK4wOokifRaTKB96YEnPVpZMNX5o5PRge7tw7+bv8
         tPikpw6UIiJG4L5QMczWbD5Vqrc06UGvhq2Xffj3EcI0KGhCgyw5KD72MMWt2AAxISro
         GAY7c5EEBZ7kkX3Nkb50FAmvKhB88JWzCFXoMmux+FUXK9SA4ordv2kFFSKAPlsFnr9A
         0xdw==
X-Forwarded-Encrypted: i=1; AJvYcCW42S4iCSdzxURS8ReXEvQYMoCP6jtYin4lfr1fX0BjfWXhXuvIAhhFSar31pfNHrmzEMMpr7dhh3A6MXA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4FslyoDtsEqDaDuwKhk/9q8Q1mMRM2Fwz0qE9ZdmDqpGdCcKV
	SgFYKn3IkLi7Y9S7yQ5Q6Vt584USfq0W0NM+8rCCjIxH3ZKx0yAs6+iTQhqQ6dSmiC0XJFCRkIP
	awJxNYLKqk827BG7ZX0n1hpLWE1I7Tae03rERszgw3oKADAOWmBhQM2f9rgLXv6R+KA==
X-Gm-Gg: ASbGncvVLxWaGfbc1VSg5DiswMpM6tQ/g0DyezAQwZXsFvT86s4lACRT7YKCmPdYibI
	Jk//qUh/7medC+It3UjEZ3dQOQEAsAEezUBElh4qOzYUm9exra5raIKTycJuvqpB9DvTdS1iTai
	8Jx669XAtRsAuqshn7KaqZWPt/F3+C65ujsNdsbhlUm9BIuCG9jFi/Y7Lz4QV9pDvhD1wDbZQwq
	0Bog828Bk3MvlxglhCn/Wi2baNmCzIx8XN7h7KhMybv825KUEKQCEJuKnTvUs79OxLLdUuulNN1
	58Wu8d7/0SWf6MHOp3GwtWGnTg987g+6Wx6RnNG9ej+Np9xXerddsMyNpDrp
X-Received: by 2002:a05:6214:2e92:b0:704:9588:f0b5 with SMTP id 6a1803df08f44-7049588f0d2mr46864546d6.16.1752162715896;
        Thu, 10 Jul 2025 08:51:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhATSlh+JJuRzkMWsk8YJM8HUQ4igJGizu8oIXouI4tsZbHB3hz8OxedljaxwZ18b6yh4tAA==
X-Received: by 2002:a05:6214:2e92:b0:704:9588:f0b5 with SMTP id 6a1803df08f44-7049588f0d2mr46864246d6.16.1752162715355;
        Thu, 10 Jul 2025 08:51:55 -0700 (PDT)
Received: from [192.168.1.3] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70497d3940asm9475456d6.73.2025.07.10.08.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 08:51:54 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Thu, 10 Jul 2025 11:51:11 -0400
Subject: [PATCH 5/6] sound: soc: stm: stm32_i2s: convert from round_rate()
 to determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-sound-clk-round-rate-v1-5-4a9c3bb6ff3a@redhat.com>
References: <20250710-sound-clk-round-rate-v1-0-4a9c3bb6ff3a@redhat.com>
In-Reply-To: <20250710-sound-clk-round-rate-v1-0-4a9c3bb6ff3a@redhat.com>
To: Support Opensource <support.opensource@diasemi.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Oder Chiou <oder_chiou@realtek.com>, Srinivas Kandagatla <srini@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, 
 Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Maxime Ripard <mripard@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, 
 Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752162699; l=1800;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=irsEjDFgWLJcIRLSdB719V4Ehwxr6Hq/ROabLh9M7vY=;
 b=w46CeQJbLms7jsanP0xDGuQgHsJotX9gQmmNfNXgBWY+HckWjmp9QYjCSEVuxHqbdfSej7iYE
 m2Ah4xmtB30AIx+iZaZOBsQNN8TYWOwYh9Bcz8BF3HVHSMRZ3eurvHX
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

The round_rate() clk ops is deprecated, so migrate this driver from
round_rate() to determine_rate() using the Coccinelle semantic patch
on the cover letter of this series.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 sound/soc/stm/stm32_i2s.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/sound/soc/stm/stm32_i2s.c b/sound/soc/stm/stm32_i2s.c
index 6037b7a9c97bf25621fccb1feb59c4caee3250ca..0e489097d9c1086efcd9e3d1013acffeb0a46d4a 100644
--- a/sound/soc/stm/stm32_i2s.c
+++ b/sound/soc/stm/stm32_i2s.c
@@ -461,20 +461,25 @@ static int stm32_i2s_set_parent_rate(struct stm32_i2s_data *i2s,
 	return -EINVAL;
 }
 
-static long stm32_i2smclk_round_rate(struct clk_hw *hw, unsigned long rate,
-				     unsigned long *prate)
+static int stm32_i2smclk_determine_rate(struct clk_hw *hw,
+					struct clk_rate_request *req)
 {
 	struct stm32_i2smclk_data *mclk = to_mclk_data(hw);
 	struct stm32_i2s_data *i2s = mclk->i2s_data;
 	int ret;
 
-	ret = stm32_i2s_calc_clk_div(i2s, *prate, rate);
-	if (ret)
-		return ret;
+	ret = stm32_i2s_calc_clk_div(i2s, req->best_parent_rate, req->rate);
+	if (ret) {
+		req->rate = ret;
 
-	mclk->freq = *prate / i2s->divider;
+		return 0;
+	}
 
-	return mclk->freq;
+	mclk->freq = req->best_parent_rate / i2s->divider;
+
+	req->rate = mclk->freq;
+
+	return 0;
 }
 
 static unsigned long stm32_i2smclk_recalc_rate(struct clk_hw *hw,
@@ -530,7 +535,7 @@ static const struct clk_ops mclk_ops = {
 	.enable = stm32_i2smclk_enable,
 	.disable = stm32_i2smclk_disable,
 	.recalc_rate = stm32_i2smclk_recalc_rate,
-	.round_rate = stm32_i2smclk_round_rate,
+	.determine_rate = stm32_i2smclk_determine_rate,
 	.set_rate = stm32_i2smclk_set_rate,
 };
 

-- 
2.50.0


