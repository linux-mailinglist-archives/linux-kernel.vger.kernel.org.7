Return-Path: <linux-kernel+bounces-726069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F02FCB007AF
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 17:53:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2B7C7BEA17
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 15:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41282279DA2;
	Thu, 10 Jul 2025 15:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q9Jk7hEw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7FB279917
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 15:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752162720; cv=none; b=t8A8hYdKjyHhgb3v5lYWUjpMSPvP2h1FLH4nX6PUteqBiD+vkTGbBgUYwW9Qr0jlyTvEGDtfuJWQCAjeMgAfQkezqHMOR95HzaGa0PZqWARfD/Se1Za0zPEGvRcSyjbEfk5wCV+wP6gzMRU89KPx65BmolMYM9ERVEx2alWDGFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752162720; c=relaxed/simple;
	bh=8GFCMbcp0w3lTxuo3uqIq1Kf0gj7x0opWqdcsmabL0w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SllyAaenLE50RWy5YbO1H6jwsWXmpCowS2cCEl0UuE/jDmarH06uZjNn+QA5lLkK8xTUYwUz23t2DKWy75BUhDPBQMR9CXb3OI4ofPGy06n6syMPQZqvvSE6B64pUcIgTrj/V9SRBJo3fcaKFGlp2yO0zJWoB60eV7BlL0YzbQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q9Jk7hEw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752162717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=roCXYQCCBXv294ZGhANYyUloWkKTg8ORl03eA1Oof+s=;
	b=Q9Jk7hEw6MCX1aXLODQkItu8w1WQVl2fs/ODuGdrMuPPIHue/j5NOazA+svC4AAp14tKbn
	DxqFASCvMYWXWE21c+KtDnow9t0jod22On9ss39W/bpSD18QEq0Wqt1N9h0yevz2TbkeJ9
	cJJ2CIaOyKbcjSBKJHyWIzR4VBRSjto=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158-IBfIFtydO3-IMNw1v2KnbQ-1; Thu, 10 Jul 2025 11:51:54 -0400
X-MC-Unique: IBfIFtydO3-IMNw1v2KnbQ-1
X-Mimecast-MFC-AGG-ID: IBfIFtydO3-IMNw1v2KnbQ_1752162714
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6fad29c1b72so17090166d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 08:51:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752162713; x=1752767513;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=roCXYQCCBXv294ZGhANYyUloWkKTg8ORl03eA1Oof+s=;
        b=Wym9fhDCk6q19pSO1hUfvQiFRDExpbvTHq2LM3nSVooh2L0rarL9u/g5rBi5qquzsf
         IvzDN86f84clsLPBhFTbx9jHITGyvJunkgbGLi2YtRgW8NeOOWpBsQ3p6OBiAW3XfFNV
         n61v9F22PxgXfCtaK2Ac60cfAl/z7zfdMT2A6qFcfE8PbGE2BKwc0PqWwfYf0nGgotgS
         feDX+b6z7nizC3S6FlAwS1nn9F5wD31QbYPiJsLmIAJh05YCkDZjt4B3riHnLcWDolKO
         9cS5ILYSiQvOEqbq5IjGTlt30AbpiTHtt6bG6Uk5TFHSSrRH5oRp9Y2IcYQUFMukQEbx
         BiNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWt9nSs7EXK8aoqvulkNeHkNHx/HLe5zmO7Q/SysyIGG07P/pWwlj9ePP8HoFxed9kU3hvAEsfeVPqg1f4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6kTsdToxJwf01bEb73DIT5IVr5lWgy0YtJXisByYtYhPqQgvG
	xGTFOHXNHQonO7ROlKX6JNB35um4YLB4GikdDyFaDtMcSDl0mE6IkDET3vAZbFBqhOX3LvHL7DO
	+Sgyx6bp3RfChSCMm+K9I2MSoPXXtTlLk8POWYrO8qGWn8vyS+aNntARf+xpjT2Cf+A==
X-Gm-Gg: ASbGncsJr2kgivVevB4RoOstLay71lk1Ukl7PvYs4s7QVV0cirT4MLeb9yNuFSBgV+S
	Ec0zeLRBBujTf2F3t6ASv0OPzKrFJOgU/SQPlqrkYC0mb4sLCCgxKgTXHQJV+jX0bt9zxUUTpXf
	257v0akldZUvHrTxXZEuYWlU4NGPXlGcZtquzZDjSrKzth5WINirEaxWhnTCXayaLg6gdgbWcJ0
	6+zqHnAvngRnkUxnd8G7tHVO02rUPLdTdX3Jc6mWB9futy9PCeQQcNsmY7hCUVs1nu8TdBw/R8h
	6CjH2Wjw1e8fDmiUeBnve0z0Lq6DwY2EATTJTmDhcroXxSZPJ2sLA+xJI6qq
X-Received: by 2002:a05:6214:2503:b0:702:d1de:7650 with SMTP id 6a1803df08f44-7048b904350mr109101746d6.33.1752162713150;
        Thu, 10 Jul 2025 08:51:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETv8kKkAF9gRKcsuP04l5OSaop0yTF67wtB5mlM/oS84I84ISgz+5x5RQyUV0R0LiOWXu3+Q==
X-Received: by 2002:a05:6214:2503:b0:702:d1de:7650 with SMTP id 6a1803df08f44-7048b904350mr109101146d6.33.1752162712560;
        Thu, 10 Jul 2025 08:51:52 -0700 (PDT)
Received: from [192.168.1.3] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70497d3940asm9475456d6.73.2025.07.10.08.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 08:51:51 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Thu, 10 Jul 2025 11:51:10 -0400
Subject: [PATCH 4/6] sound: soc: qcom: qdsp6: q6dsp-lpass-clocks: convert
 from round_rate() to determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-sound-clk-round-rate-v1-4-4a9c3bb6ff3a@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752162699; l=1297;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=8GFCMbcp0w3lTxuo3uqIq1Kf0gj7x0opWqdcsmabL0w=;
 b=C1NOkFYk4ZvkSlhR/nJT1ZMxm1WrhT5fr4V1f6MUwtgu1IwsGHRhGihPJyKm/qfChcPciMqRX
 jMkYCRRA7J1Bi4cmmruZSnKv3HXP26MoB05WHwsHZzBAvqaIhMzvhGA
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

The round_rate() clk ops is deprecated, so migrate this driver from
round_rate() to determine_rate() using the Coccinelle semantic patch
on the cover letter of this series.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 sound/soc/qcom/qdsp6/q6dsp-lpass-clocks.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6dsp-lpass-clocks.c b/sound/soc/qcom/qdsp6/q6dsp-lpass-clocks.c
index e758411603be5157e468e8c076620d7c18661bf3..03838582aeade389d9a2d90cf9f03fad835f0733 100644
--- a/sound/soc/qcom/qdsp6/q6dsp-lpass-clocks.c
+++ b/sound/soc/qcom/qdsp6/q6dsp-lpass-clocks.c
@@ -69,17 +69,17 @@ static unsigned long clk_q6dsp_recalc_rate(struct clk_hw *hw,
 	return clk->rate;
 }
 
-static long clk_q6dsp_round_rate(struct clk_hw *hw, unsigned long rate,
-				 unsigned long *parent_rate)
+static int clk_q6dsp_determine_rate(struct clk_hw *hw,
+				    struct clk_rate_request *req)
 {
-	return rate;
+	return 0;
 }
 
 static const struct clk_ops clk_q6dsp_ops = {
 	.prepare	= clk_q6dsp_prepare,
 	.unprepare	= clk_q6dsp_unprepare,
 	.set_rate	= clk_q6dsp_set_rate,
-	.round_rate	= clk_q6dsp_round_rate,
+	.determine_rate = clk_q6dsp_determine_rate,
 	.recalc_rate	= clk_q6dsp_recalc_rate,
 };
 

-- 
2.50.0


