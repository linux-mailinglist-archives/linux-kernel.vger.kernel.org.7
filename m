Return-Path: <linux-kernel+bounces-726651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11CE7B00FD3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 01:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 226941CA752C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 23:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1789307AC3;
	Thu, 10 Jul 2025 23:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SZlGlZz8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC013074A1
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 23:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752190965; cv=none; b=WrvSxxOfWqpIJi4Z+kAqheOxIwurOo6OwUbGH0B4fzVpYIVrBGgdCNr5Fk6j2Gw6aNBGmsCs/WCokjdmjFCIHWPYQRAI+8C7YEST0bF+9PWUSIeTbvAXOuANAYV3EBtn7lrgRazEVnE8ANdgk3fE/frl8G7FL3a93egxm76Esd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752190965; c=relaxed/simple;
	bh=jwHUuIfJpkKtUxi73mEQY+91PJvNh9g5xkFpUZRiga4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K3ZH6qvqxtd6kOZGw8JnuA5XbenqgN3nWdJTwWiC0KG0bPMoI+jGY8rDtIJFrPwLtTcNpszI4BuGQsTo3WvvD/3cQXXSeZehH61rZlP3w/wjJxt+NDLdD7tyeFhy10Di4quMJSN8m0u8A0+ZN86llyLSJspe13GLCmzVhwViX/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SZlGlZz8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752190962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zzcdkHd9gFbf4QypMItIoKQ58RyRYzqIMuQJ/GqwgQs=;
	b=SZlGlZz8vRD5dg6oHkP2LdXGUo4OeMBz28p7JsRA7pjIEMJ1rJ8irlr2/cxKYbiMpjXeTn
	8Se+7u+gCVr3VWitF/YZrybNV0/trVPxJe553euzJmWr3F5bj6scU/Zs1pulrKobnSKjWH
	PNBHhPqgdwJVOi/aMaUfSwHhkETAsrU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-IeRVmUssMG-3GkKx2LTwQA-1; Thu, 10 Jul 2025 19:42:41 -0400
X-MC-Unique: IeRVmUssMG-3GkKx2LTwQA-1
X-Mimecast-MFC-AGG-ID: IeRVmUssMG-3GkKx2LTwQA_1752190961
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-704a8024e6aso865156d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 16:42:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752190960; x=1752795760;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zzcdkHd9gFbf4QypMItIoKQ58RyRYzqIMuQJ/GqwgQs=;
        b=uY/gbZC6HvESYCHNwCV/7FmMXMgofNSJi09Q6y1oIbFsQ29mRoB0hpfmPmwMN6e5tl
         buyrroRfwQe140zQ0rYB1oQaQODx/hCuxPwuwoLZUKUngkqpyfE4SMqcdVJeEjmrS1tk
         uDcWqHr+NYiM22arPtmoDR20k1bO2KzUmniv4s/eyFovJbPPFCI1Cex+qOczNvjvcjOK
         oSCNGxtFgyc4COhuyu2HLZn6OXyrYyejByH2NR6SLN3XX0D/UV75y2SiZyimaWOVmmy0
         RCx4zxnMe2xFzPKehA71wa1xaUgHBPTELEDV6ci1tGtoY2fV7lNSbEg0kYZ/yqC5JGCJ
         enWg==
X-Forwarded-Encrypted: i=1; AJvYcCUnW+6s0zLULW7DyPPFLzNdRcRxZQiHzdXpbaYM5+scRqRYkbvhcgb9km0jM7oO6mQxZnRJCX49esRj55M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyK0ZNlDSlNDpJf/N7PwGFvBdS+nMAwNRAQh8iE4vQ4T+G7RLv
	ECPLXAKQVYsbKxkVI0xM7qvcYGVC+JSrdUZf9Mi0PAiBUTFKrBKBoZ7A0tzeek2yCnfoPbzVGOn
	4nHAyppeAypw5hqyPsotcbLKGISnr06JRlJHp1puQNiexaxCfXfxET2B+P8xglnf08GhKmLnnNi
	s7
X-Gm-Gg: ASbGncuja2k/tHClKGimUC498a95zKj4QE0MoEmrAeDdfmRyypTXcMLyVB3WdbJRkW6
	i/sYu5q6D0Nud1bSWmZdhnr6RqqTlFoCN54EZn1XPJHi918KozudwmTtedhl5Kiz7go1RV22DIn
	7je7QZr7zk9jkw7fH5AufUYDaLKRYkzZin2O8KhgjOe77NNnozUFXTvmODtVz/sbJ7jKJW/rSjq
	IdoIh8PRRTGYAfS/1NRmxaM7koL4tRBWXa+24c57nEIOxOGsn9GNhbVKA60Q8RPZWQ7chxLIvmq
	EwT54H2JBfXG0VnId7YNPedyfFgyz4nY794C+jzecNZojA7rwI/bOtWAT+imfA==
X-Received: by 2002:a05:620a:284b:b0:7d4:5b68:2646 with SMTP id af79cd13be357-7dded1ef04dmr206088985a.57.1752190960357;
        Thu, 10 Jul 2025 16:42:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4Qf90w3WAIU2WDAVl84idxN1ukujHZknm9tJ2hmS373+cRWGc+ayHL6trz95Fv5oRIp+Mrg==
X-Received: by 2002:a05:620a:284b:b0:7d4:5b68:2646 with SMTP id af79cd13be357-7dded1ef04dmr206086485a.57.1752190959849;
        Thu, 10 Jul 2025 16:42:39 -0700 (PDT)
Received: from [192.168.1.15] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7dcde422e03sm153989385a.69.2025.07.10.16.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 16:42:39 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Thu, 10 Jul 2025 19:42:18 -0400
Subject: [PATCH 3/3] ARM: versatile: clock: convert from round_rate() to
 determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-arm32-clk-round-rate-v1-3-a9146b77aca9@redhat.com>
References: <20250710-arm32-clk-round-rate-v1-0-a9146b77aca9@redhat.com>
In-Reply-To: <20250710-arm32-clk-round-rate-v1-0-a9146b77aca9@redhat.com>
To: Paul Walmsley <paul@pwsan.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Janusz Krzysztofik <jmkrzyszt@gmail.com>, Tony Lindgren <tony@atomide.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Andreas Kemnade <andreas@kemnade.info>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
 Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Maxime Ripard <mripard@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752190949; l=1416;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=jwHUuIfJpkKtUxi73mEQY+91PJvNh9g5xkFpUZRiga4=;
 b=BvPcx1n0mHxD2gopIAIHjnh1g8w2Bjp39wDL14lGnKxt1a2WhjWjIRkC4v+Ur+bh9HIHtBv/h
 TZtY3GXOwDxDw5NimZx9GggwdDZr1X0VaLAtH8tcwEpCQzCkO8UueKy
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

The round_rate() clk ops is deprecated, so migrate this driver from
round_rate() to determine_rate() using the Coccinelle semantic patch
on the cover letter of this series.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 arch/arm/mach-versatile/spc.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-versatile/spc.c b/arch/arm/mach-versatile/spc.c
index 790092734cf6155daa63c44a1e5af00ecef30737..812db32448fcd415fa1a60f8bb971661369151e1 100644
--- a/arch/arm/mach-versatile/spc.c
+++ b/arch/arm/mach-versatile/spc.c
@@ -497,12 +497,13 @@ static unsigned long spc_recalc_rate(struct clk_hw *hw,
 	return freq * 1000;
 }
 
-static long spc_round_rate(struct clk_hw *hw, unsigned long drate,
-		unsigned long *parent_rate)
+static int spc_determine_rate(struct clk_hw *hw, struct clk_rate_request *req)
 {
 	struct clk_spc *spc = to_clk_spc(hw);
 
-	return ve_spc_round_performance(spc->cluster, drate);
+	req->rate = ve_spc_round_performance(spc->cluster, req->rate);
+
+	return 0;
 }
 
 static int spc_set_rate(struct clk_hw *hw, unsigned long rate,
@@ -515,7 +516,7 @@ static int spc_set_rate(struct clk_hw *hw, unsigned long rate,
 
 static struct clk_ops clk_spc_ops = {
 	.recalc_rate = spc_recalc_rate,
-	.round_rate = spc_round_rate,
+	.determine_rate = spc_determine_rate,
 	.set_rate = spc_set_rate,
 };
 

-- 
2.50.0


