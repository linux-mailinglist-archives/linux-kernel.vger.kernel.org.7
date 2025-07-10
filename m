Return-Path: <linux-kernel+bounces-725993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D58CB00669
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 17:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 187607B9EBF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 15:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76F9276030;
	Thu, 10 Jul 2025 15:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fDxBwEe0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FEC27585C
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 15:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752160870; cv=none; b=sqUg50DI45nhkbUnQasZ/rOVig+Q9thnFGg+doJ1PLTEzyrrQpHqAw4mYoeXpbekTvlVIjUacU4Se2/2X5DwwHv40OX3Knau4+uGrL0Nsob8B1ab5TmMM/mSfd2/rvKdtr0uFYzvshnk2MUsAht9FGYcAstSw1pNuKvkDVC0k1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752160870; c=relaxed/simple;
	bh=PB+j173ZUCvMx00QR0amUhQt36vO0IOlAp4XxnvHyoA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ba82APJO9ITNqEkD3zucmqsGfHCscsjufL52aR0+5XjpAGIbEQPKs3sx5e2xrRxbh/rXRIWBQAKhC/g/hDTJ177uu9Xq2w5/AQQoNQyi2I9D5fvTeIvJ7QDewAuZGEOz/ttY0fiM93/+lB73BqPKAunvbWptmCPCMkJWbNb9xAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fDxBwEe0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752160867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cWgai9je4M+dBmQHfs2DnCFlZRU+HmuUrj6HyZ1DawM=;
	b=fDxBwEe0rT/IoXqzzq2CUhTwB/dMlYMa0Pigk5Eh1wA5fHNViMjDS/v+JJysEsoscBiVrr
	F+oHbZoalOvMcV3PawIbztyU1s74PDo/hSVS8HU7c/0qh5RMkKT3JAjIo9VC/6Pb/ms1Fl
	mixjEp8n1OZq5zLHM/9Sg1LSPTYksOQ=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-Ko5AfLXeOD6IowSMSIQi6Q-1; Thu, 10 Jul 2025 11:21:06 -0400
X-MC-Unique: Ko5AfLXeOD6IowSMSIQi6Q-1
X-Mimecast-MFC-AGG-ID: Ko5AfLXeOD6IowSMSIQi6Q_1752160866
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4a57fea76beso20724731cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 08:21:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752160866; x=1752765666;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cWgai9je4M+dBmQHfs2DnCFlZRU+HmuUrj6HyZ1DawM=;
        b=aMXf+l6FzVEyLfvCTqwq5L1OL/zesTJ+/+j6sb7zCKP4sxFneJR1Jo6yY4T1MLrJif
         OTjntvZxjHx6inb3Zwk475ea0k592VJHGjfijOL6vCa7TyV1VilFJDzIn3TbawYudtJ/
         n3UENAd0Xg3/C9jdJEHOnpVknpZZgzpKveaYW/GMSNbuEyGtZyIZKOhJxODGlRpyEVK9
         iS4HqZDDTEm7bINgir1qORw/ipbjMo563v4w8/WRTddq3w4IAwrstgyVuOZcOTUZe/Ct
         sMCMRED+9t5oHGRW8Z7h5/HyPw5WBQUjaaUerV1fKiFcqtMWakJtQ86UaxOuJWfQJcPK
         y9PA==
X-Forwarded-Encrypted: i=1; AJvYcCUz3NlzRN7jp++mKIwuRIHxrhYH4OOQCCuqKkDwfUXebaGSPLkCHcIehf+g7OKKSfVSM5taRFi3Ql9Fkvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKmH/hQGIZpNUNQnVMmTWgeQwRJkgWLU2SyCmzQN0iFq4J7GiV
	7EpxtLRJWquQDsOpfK5iAhw580WPzAA1auj8MLN64TXfHydKOaaIf09YcoNb9Q+47rpdtxklCi5
	0FNlW/j0b/0Qd8CmJd2XVbFszIcXvJ8FCDls+g7hpkzk+yTy/sRPKRg4FOz9l0lYa1g==
X-Gm-Gg: ASbGncvj1CAKgEZFlsV0x3bXXhM5jhePh1KR3PIx2Uy2uDHyBMc0OskqpplvaMn5HLs
	xnSwwL+1Re1fUJlLofr3hloexrTyvzDLrLXxBezoQ/18WyNwIFmviufiNj3PSYQgM9IwGyEkKBS
	N+m6Ok7RShfw2bf84QzzV5v/vagQ6N65DDLYlXNlr2SkmmlBQPLOeHgQo8J0U4XI6nqQl5neLVg
	bGhhkMvxZN8TL2G5OwGyGzf7VeKQvtd7KfKolcSR9Xwa4cmiafqtZczrxbcMjpPsiI0NoPFC6wW
	burKluq5SOFPPgR2ib3Q9IgfYukOsRT02/OAH5tJCmED0UFt6F7ikgLi30Cg
X-Received: by 2002:a05:622a:211:b0:4a7:5c21:d4d with SMTP id d75a77b69052e-4a9dec28dc5mr103787061cf.3.1752160866012;
        Thu, 10 Jul 2025 08:21:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGi78LTzsYtSVkKEALzl93XPTGvuqLAQzDkHoOcxcArk4oREKyBP6wLdcXeCmuUpcKwg+gWg==
X-Received: by 2002:a05:622a:211:b0:4a7:5c21:d4d with SMTP id d75a77b69052e-4a9dec28dc5mr103786631cf.3.1752160865622;
        Thu, 10 Jul 2025 08:21:05 -0700 (PDT)
Received: from [192.168.1.3] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a9edeee2c2sm9654471cf.74.2025.07.10.08.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 08:21:04 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Thu, 10 Jul 2025 11:20:25 -0400
Subject: [PATCH 05/15] rtc: pcf8563: fix incorrect maximum clock rate
 handling
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-rtc-clk-round-rate-v1-5-33140bb2278e@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752160847; l=1071;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=PB+j173ZUCvMx00QR0amUhQt36vO0IOlAp4XxnvHyoA=;
 b=SZd0Tpd6HF4yy+Mmrqrn3tbJsWSKYgTwu87RGcBvNECkHFO1D/v+Vw/xZqNbu+/k2SLWi8+ZB
 mcLVNVwJoO3DhAIo51s6cEWtuxqa7l/mVXZpDVSt8sXgmkm5TMyGPgA
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

When pcf8563_clkout_round_rate() is called with a requested rate higher
than the highest supported rate, it currently returns 0, which disables
the clock. According to the clk API, round_rate() should instead return
the highest supported rate. Update the function to return the maximum
supported rate in this case.

Fixes: a39a6405d5f94 ("rtc: pcf8563: add CLKOUT to common clock framework")
Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/rtc/rtc-pcf8563.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-pcf8563.c b/drivers/rtc/rtc-pcf8563.c
index b2611697fa5e3adc61f687e39385d10736dec677..a2a2067b28a127bafec66328cd75f50aa4277986 100644
--- a/drivers/rtc/rtc-pcf8563.c
+++ b/drivers/rtc/rtc-pcf8563.c
@@ -339,7 +339,7 @@ static long pcf8563_clkout_round_rate(struct clk_hw *hw, unsigned long rate,
 		if (clkout_rates[i] <= rate)
 			return clkout_rates[i];
 
-	return 0;
+	return clkout_rates[0];
 }
 
 static int pcf8563_clkout_set_rate(struct clk_hw *hw, unsigned long rate,

-- 
2.50.0


