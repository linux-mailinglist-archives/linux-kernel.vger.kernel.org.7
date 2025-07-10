Return-Path: <linux-kernel+bounces-726484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E83BBB00D89
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 23:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C60041CA4950
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 21:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C25A2FE398;
	Thu, 10 Jul 2025 21:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i0ABL9+P"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96B72FE39A
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 21:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752181893; cv=none; b=fz8oiYHoEUk7qjLDz4veLCXDJHM0iQxoYHcqqT2nOx/qE63L1GP2qFCDmY4FCEEZbU/6It/XmibXLDpXbIeLHMi/TjE+C1cvLBWYa23ddLwJX7iCyuP1zJiyW1W7QnjeUOYC/bA/4Ej8/WN0RgNdrVQcSHn8tK2PTbsp+iuvY4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752181893; c=relaxed/simple;
	bh=3XjDCzSMZEsGst/M49lew0bIUSlQF8Nx3FY6tvatUbc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GYSWEKDG9Dxbm86O7ng+kMctgdc7K+GDWjYNEJoJEivIVJpFTJQP21P30qegfajQHPQi06hx1F0x3boULtOKAX5wgLst3jovlykL+YpTd0IhlW5Adc1M6uyS9d4F0eAfhg/wdfaYIeKu95kSnPzO1NLPfN8jJ0I2S2DezYDNyJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i0ABL9+P; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752181891;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zz6/HNpI1gHN4fAaBunmqYHsn5vtfJJ4CRMBCE1FAzE=;
	b=i0ABL9+Pog1jTY1TOTLW+CJr43Su+9LZCq868rPGXnu0P5RolFt8OTI4Z1LDr4nsjwwi1U
	d/IOZ3HtYaMByGBoFVEOUrrQ9oTVUg5tHzg+OAGoAn8BALrYIyuOwxQdov/I5IAfKYx2OZ
	YnDeU/6WVYwqycIsyFojjh8+U1q9qU8=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-GaAdP4MGOTS3B4VY70hzEQ-1; Thu, 10 Jul 2025 17:11:29 -0400
X-MC-Unique: GaAdP4MGOTS3B4VY70hzEQ-1
X-Mimecast-MFC-AGG-ID: GaAdP4MGOTS3B4VY70hzEQ_1752181889
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-23689228a7fso20492895ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 14:11:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752181889; x=1752786689;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zz6/HNpI1gHN4fAaBunmqYHsn5vtfJJ4CRMBCE1FAzE=;
        b=pvPHTmas+xfQI1qqLW7kAAYhZZ9t2XpzUNnnTRK60SJHJNJrizNLsf96ZHuLAdKVoy
         b1+tcu1IGxAx6wjWDxl/E+ipri6M1rry497fMFSG/0eCjEF9r0CEjhHx97evlpzYp6F/
         oDniysMED9f6ZFqt4eEAh0t/Eqq5tm5/C6dFEXfGtOopYCQXLub6Yn4eONjn+0G/9D3W
         MLIpY73M7rENAIY4qxfomtv2r6MN9G8tlPFNYGDueAp6Zbk2phGA7jJGCgi1xbVHeuZH
         9XzQ6kauJluTmq5UGs+wxA8mE0m9cD4+/40j27gBgIiynuaxT5iGHcA0540LOlS/BVz4
         3gpw==
X-Forwarded-Encrypted: i=1; AJvYcCUd35/kvUIxGgJhvWfONVL0YaBweoGVkL3Z+1Ksl+/33pwIstruDj+qL4cdU1ONhxkWCn1YywIkFfHmzNc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiyW0pXvnIQMlgDL26rplDigi4rfv3opgTqjptEw/5mNVXWlr+
	nUdtNZ6JoYjDH/am/py2fbxti9rU66qeFUb9pbJsPR7XA341Hw/FvTEX9IkEsS2Wpc4pTgL9cXV
	gOYQ4F37p7ma8GQ0QWHMXkxBaHsg4hVzkiFUyK0pDqNfQtO5rgP4Wa25FeMUsO9zgoQ==
X-Gm-Gg: ASbGnctQakQaaYRF0mVnV0BMx3yoeykpo9WbbSnubvTUtDDitjT2IfcMeChUyQBNmmN
	SGIpDUhb7SzIOReDkfYV1FiEFelfcYxE3dlC1TC5MHFXYb+pPxRLpkNsZr+SnjfpHMQ2o/+o6xX
	k6+KkHhGaz3gHM6kxCVRVD/eINZerMg5AnvhzKgUJ5iO3wQQPNuuhKKN7gtqmZU9MIczVK0edpF
	Ub2+V8IiogCbxga8rRDxymqAfjP9kCHx0wQhFvCwHMnmefbfu5VCtdaRb0syzRmefishR2S5dVV
	IuEbqvD4wx/uQK5HX99CAdcQdyHn0o0zgHt9CE09ay97qg==
X-Received: by 2002:a17:903:3d0e:b0:23c:6cc2:feb9 with SMTP id d9443c01a7336-23dede9e0bdmr9187535ad.45.1752181888750;
        Thu, 10 Jul 2025 14:11:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH40itlo9Q3VPwkodph6SX00btge58CCSKjrR52Pux2HyjpRrEkkomBu7+5GLThfJJL/+J/yw==
X-Received: by 2002:a17:903:3d0e:b0:23c:6cc2:feb9 with SMTP id d9443c01a7336-23dede9e0bdmr9187315ad.45.1752181888452;
        Thu, 10 Jul 2025 14:11:28 -0700 (PDT)
Received: from [10.144.155.224] ([2600:382:7716:65ad:9491:c054:6f2d:80ed])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de433e51asm27790595ad.180.2025.07.10.14.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 14:11:27 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Thu, 10 Jul 2025 17:10:36 -0400
Subject: [PATCH 04/13] clk: imx: cpu: convert from round_rate() to
 determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-clk-imx-round-rate-v1-4-5726f98e6d8d@redhat.com>
References: <20250710-clk-imx-round-rate-v1-0-5726f98e6d8d@redhat.com>
In-Reply-To: <20250710-clk-imx-round-rate-v1-0-5726f98e6d8d@redhat.com>
To: Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Maxime Ripard <mripard@kernel.org>
Cc: linux-clk@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752181866; l=1427;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=3XjDCzSMZEsGst/M49lew0bIUSlQF8Nx3FY6tvatUbc=;
 b=cZExAeUB9HVwWRLw/pA+Ktj6jaDvyzLQbPvJc/XdM+3G/yEOb+NDOTlZV8oaiYClRWR49P9Cu
 xqOnNjF0BFoDoL6ivjtSPWRBoBq1R6/6yfsdfsJwfwgf2c4wsH9udFq
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

The round_rate() clk ops is deprecated, so migrate this driver from
round_rate() to determine_rate() using the Coccinelle semantic patch
on the cover letter of this series.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/clk/imx/clk-cpu.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/imx/clk-cpu.c b/drivers/clk/imx/clk-cpu.c
index cb6ca4cf0535bab2d9d519c46a84564711aaf209..43637cb61693845f54b3bd1b92f548b43bc30caa 100644
--- a/drivers/clk/imx/clk-cpu.c
+++ b/drivers/clk/imx/clk-cpu.c
@@ -30,12 +30,14 @@ static unsigned long clk_cpu_recalc_rate(struct clk_hw *hw,
 	return clk_get_rate(cpu->div);
 }
 
-static long clk_cpu_round_rate(struct clk_hw *hw, unsigned long rate,
-			       unsigned long *prate)
+static int clk_cpu_determine_rate(struct clk_hw *hw,
+				  struct clk_rate_request *req)
 {
 	struct clk_cpu *cpu = to_clk_cpu(hw);
 
-	return clk_round_rate(cpu->pll, rate);
+	req->rate = clk_round_rate(cpu->pll, req->rate);
+
+	return 0;
 }
 
 static int clk_cpu_set_rate(struct clk_hw *hw, unsigned long rate,
@@ -66,7 +68,7 @@ static int clk_cpu_set_rate(struct clk_hw *hw, unsigned long rate,
 
 static const struct clk_ops clk_cpu_ops = {
 	.recalc_rate	= clk_cpu_recalc_rate,
-	.round_rate	= clk_cpu_round_rate,
+	.determine_rate = clk_cpu_determine_rate,
 	.set_rate	= clk_cpu_set_rate,
 };
 

-- 
2.50.0


