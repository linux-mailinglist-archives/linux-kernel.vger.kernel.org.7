Return-Path: <linux-kernel+bounces-725997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE677B00673
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 17:23:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 966C77ADCD9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 15:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F245278163;
	Thu, 10 Jul 2025 15:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P/uFT9xh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9085E277CA9
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 15:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752160881; cv=none; b=sh2SB7gZPQDQX9pJwEKp90tRn55/0yt4wLL+3sI2WRzPg/0AIW577kyiYul/lRnt3hhC1JoO/P2Pky+46ueHkUMBp4c4hGGZAPQgEvisDA8S0MP2ufeioVrQ7NHsxWxMtPyWlpDpzyONuDWAc+jjjh1RchKKH5ooRP+bL3P5d78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752160881; c=relaxed/simple;
	bh=gRYxCnwkm6+irA6938Yxi6DImy0GX438/iYdpVHvAEg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cktn81o0ly80WZsFhgl7C8yf8IHfEY31ETSERY7Bah9reyDpfQieTHGCXKRMMSwlJAz24qglMk1D4nBlWWR7jnJhTqLHeHq3zUed5uio6J1CaM9T7WrDloaZcF/H5Dyx6hjwTxadM/UBAs1SWGGSOZ5Nmr6HD3Ci4bvzu+G2t4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P/uFT9xh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752160878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jCRaT6dha/0glQCxVFquzDYHmbhYyDuNPuL1J0w4X+8=;
	b=P/uFT9xhlZyA7A8Qlg5akb/ck/XP/UpFNUHX8OlRhkfR8alCsZBakRHZKaRRUyj9GTgtZy
	WkwpBoL2UgV31As7k7XtJK40Da+M5S2UqNL/PVCZisefXBPVCS6DRcOdgb4KqX9DH2zoal
	8OGTzK0gKQE2/+WLl2n3USYPN4NDB68=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-YBCJHB1iMWmwWXfMrRVuZg-1; Thu, 10 Jul 2025 11:21:17 -0400
X-MC-Unique: YBCJHB1iMWmwWXfMrRVuZg-1
X-Mimecast-MFC-AGG-ID: YBCJHB1iMWmwWXfMrRVuZg_1752160877
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4a581009dc5so21118831cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 08:21:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752160877; x=1752765677;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jCRaT6dha/0glQCxVFquzDYHmbhYyDuNPuL1J0w4X+8=;
        b=WprMWhxOJtmgCk2VQci/T/EWyorNaiSLMT6R2CCjqyxn2JloTv5ZroCwH1Y2opkOQI
         xozWopSwzH31q6Cx/c4Qh24/t63K2qpqqLJddf39aJtMh6/miHi8Iw+5BV2Cq4oN2qcq
         UTGf+sYMnVqQUw+93PT6crQsMkwTt8g0k2d1Qj2P6C90ZoCwNdPpw9aA3JwI1WH5Dsux
         77bmoTPWe8EV2SOGQCHZxocdv/OnJqljDvJoUw8ZjXOnhtE0RpWZ/1kuGTDRf4nP2a0W
         k+vnbn3MOZjbGKyYN2YTfI8LeDXceVW/7DixKTC7cjOJ7WFj+oHskf/qaQZdo9JAGvDi
         pEYg==
X-Forwarded-Encrypted: i=1; AJvYcCVdtNSXPxP7NH2yP7IKb4ho2vr16md540RxG1eAwRLVNy31kg/dkEMowKGvxn6ORuN0JZk1njrxa011JEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ9Pvf3xIQ31MX0xfPh+kUPJq4dSonGK9GnPkH6UNljzXLrt30
	xMGId4cKRy5abWNChq3+orn7R7vcGazwSCEO/Ml/T/0xUNqBmPRXTJ4FolAPx1Dqrpr2MLUmrvs
	rzsXvunoaxUqtMgRg1TIP41UMVWi1KYnUYS5sa1kanmCnS1nwnF7Z8w6d4ywijaiVtA==
X-Gm-Gg: ASbGncs2KwyLTH/GWPHdj873dXLsxab6e2tO1F23BYNu7BGSV8iukobygspxiWYVGZ6
	eZDRWbEoYAInJ1IF82s9rm3S0uwp4+QORN0xQoTVzambh1FBxCn10uQCcvQQmQ+XFvzDJVSYGaL
	YoCLojHumoQugMmmilP5r3dKyUzvD/98Z//Pbp93puudj0XIlfgu3MaGfvsYcU150b+qe+WbnbO
	fNOh1ihy/BL+6bwmP8E5ySZ606I47HG6+hD7Z+oFpN7tbw/vzrfmkbub4BIM69MqL02GevKZrzC
	oY0wX38dxO9hXWmKUDYWodniRM8L2SRhWt7ObSgEa6AvzsGkorgJyzCnZ5+p
X-Received: by 2002:a05:622a:2e8b:b0:4a8:18ec:8ce4 with SMTP id d75a77b69052e-4a9e9ccb481mr50515871cf.21.1752160876769;
        Thu, 10 Jul 2025 08:21:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEktnXBUPzvGbZoA7Bfbi7aUOBKs0QSJoWa7pWCkvWbCkOdt87sQ9haOuMdpsEwCBfM0IV/Rg==
X-Received: by 2002:a05:622a:2e8b:b0:4a8:18ec:8ce4 with SMTP id d75a77b69052e-4a9e9ccb481mr50515221cf.21.1752160876213;
        Thu, 10 Jul 2025 08:21:16 -0700 (PDT)
Received: from [192.168.1.3] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a9edeee2c2sm9654471cf.74.2025.07.10.08.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 08:21:15 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Thu, 10 Jul 2025 11:20:29 -0400
Subject: [PATCH 09/15] rtc: m41t80: convert from round_rate() to
 determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-rtc-clk-round-rate-v1-9-33140bb2278e@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752160847; l=1772;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=gRYxCnwkm6+irA6938Yxi6DImy0GX438/iYdpVHvAEg=;
 b=kdySgV3nLQK/nOox4fwHOlhGEFmW0wqNr9VHY7vGwOwPSM+A7pKrKapXwM8vxkIukREKQD7cC
 HuxCZizP8wRCrbf5QFXxnXIAg7hjFGFve1Y1H3RLVpUJwKN6oL6+xHw
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

The round_rate() clk ops is deprecated, so migrate this driver from
round_rate() to determine_rate() using the Coccinelle semantic patch
on the cover letter of this series.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/rtc/rtc-m41t80.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/rtc/rtc-m41t80.c b/drivers/rtc/rtc-m41t80.c
index c568639d2151702440d726030e9f08a0eb514da8..719afb9de9a831a4f335f505e3a0eae5293ad6c8 100644
--- a/drivers/rtc/rtc-m41t80.c
+++ b/drivers/rtc/rtc-m41t80.c
@@ -484,16 +484,17 @@ static unsigned long m41t80_sqw_recalc_rate(struct clk_hw *hw,
 	return sqw_to_m41t80_data(hw)->freq;
 }
 
-static long m41t80_sqw_round_rate(struct clk_hw *hw, unsigned long rate,
-				  unsigned long *prate)
+static int m41t80_sqw_determine_rate(struct clk_hw *hw,
+				     struct clk_rate_request *req)
 {
-	if (rate >= M41T80_SQW_MAX_FREQ)
-		return M41T80_SQW_MAX_FREQ;
-	if (rate >= M41T80_SQW_MAX_FREQ / 4)
-		return M41T80_SQW_MAX_FREQ / 4;
-	if (!rate)
-		return 0;
-	return 1 << ilog2(rate);
+	if (req->rate >= M41T80_SQW_MAX_FREQ)
+		req->rate = M41T80_SQW_MAX_FREQ;
+	else if (req->rate >= M41T80_SQW_MAX_FREQ / 4)
+		req->rate = M41T80_SQW_MAX_FREQ / 4;
+	else if (req->rate)
+		req->rate = 1 << ilog2(req->rate);
+
+	return 0;
 }
 
 static int m41t80_sqw_set_rate(struct clk_hw *hw, unsigned long rate,
@@ -564,7 +565,7 @@ static const struct clk_ops m41t80_sqw_ops = {
 	.unprepare = m41t80_sqw_unprepare,
 	.is_prepared = m41t80_sqw_is_prepared,
 	.recalc_rate = m41t80_sqw_recalc_rate,
-	.round_rate = m41t80_sqw_round_rate,
+	.determine_rate = m41t80_sqw_determine_rate,
 	.set_rate = m41t80_sqw_set_rate,
 };
 

-- 
2.50.0


