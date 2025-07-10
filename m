Return-Path: <linux-kernel+bounces-726649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 347CEB00FCC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 01:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFB7F760EBB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 23:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E172E4244;
	Thu, 10 Jul 2025 23:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i64FZEJh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5520295520
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 23:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752190959; cv=none; b=R7Hz9Y9JM64hJXKzF7jCUH5Mu2nbbYQKtn7ATYLt6W6f76EiyDrUZOFgrzafC31rrwb6mAtfx9qc/DAVj+dWXm3UGAYBO3+Xf4s+9xysv+Jk0koSwSEcWbuukLAFt8rYoPs9TXYGWdtJxuPmMdm4qYCDQQx76Nt5zX8YGNIyifg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752190959; c=relaxed/simple;
	bh=Mg6lKUg0ZmZeW6JyF1mVcF9O9A9v/XbSlh+3Q+sOozQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TMv0xUozk1qVOmpJ0y184La9hzu1O04AJ7DBaEC5LZBaCu0Cg/snfTQHjfnyXLYqJR8CFlSU3Wd2SBQ8sF++GbnLZKRJKROLfRmzXcGRckyPf9OJlSECuDPhswIvjQ1CnWVMQIRKdyuR/y1W0UbNtpp0YOCuQKhCPjRBCa9p5Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i64FZEJh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752190956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C+vFXF+6sAs+f0qJzoysFGKJfCbzyDXKLN+W95anZkc=;
	b=i64FZEJhXjGvXhvXLvzkdKrU6uCY2hCWbUdiQiI7LrYJo3zQAc/t4hPXMMLMlrXj683rKG
	NOul4WVh9h8Yv1st91sOe+T/IZQpR7M7EwQrfi1cIyahY9m7w6T6nyb+F52Y9reoc+Owkx
	iwJqFS/a6KL+ejnTE4mO/L70pv6CVFs=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-2fVu5uOQOFq-69EJEd6-dw-1; Thu, 10 Jul 2025 19:42:35 -0400
X-MC-Unique: 2fVu5uOQOFq-69EJEd6-dw-1
X-Mimecast-MFC-AGG-ID: 2fVu5uOQOFq-69EJEd6-dw_1752190955
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-7048ed0751fso30478776d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 16:42:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752190955; x=1752795755;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C+vFXF+6sAs+f0qJzoysFGKJfCbzyDXKLN+W95anZkc=;
        b=uJAVITSsF1WtYb9AwMS/85vU+npzzKCXiMgULW01h9+QLrWKO5R8MrgcmP91GWEQ7P
         oOl0xlDONYN6Yzu3H3/AyHRi6/JrKfSoI/GvoRi8UTTJV4XsMNW9uBKuo2JfTMzgvLyp
         70vKezAEO77ORgYdVllbvTl5Sw5SSHp9FS80Ce1sv1v3V+XDzdHmiWg3S4FTFCc5dnsK
         ez0e2x/GfH2Ih2TJV8e0OuPEkDxRX5EJm6Adr+ZgSFUP5D9Vb4eHz5R6IU3yb9+9xAPF
         G6lyPrWDBe9wdD5xbUGUb2PBGat7F/FmOdv+g3b13pyIviULYT7+FyN4o7dlJAwJoRMz
         0hjA==
X-Forwarded-Encrypted: i=1; AJvYcCUKaQjX/R8hWr0cjXhOTyDDE6mO+/qp1HkMDH0tHoCUbIJPbx70X4kiHkPEMx3Oa4mYGKCLhgs4UiceAiI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7Z4EVr0igeN6xZTqWZ6NI+HV5UZWbCIBrg4YtENE1UxC3Yqfk
	jxzCKlcpnWIUr4I4Ytxmxlqi/amJq2f238bUjLXrHJI/hVsJq1VMu5n9EAHBBv8fNq2fG08fSg0
	nWkTph7UoNTPhulc/ZOpRSIlvfOjTms8D9LmPix4MubrAu0vpTL2OBVjadUbaZF/2LQ==
X-Gm-Gg: ASbGncucR6LM4pubctEuStksLf1u0envv6aqj7gR6yaVxK035QQ9oApcPjDw+G2ocQ8
	PuG/ishITgwpJ0ZhXy1UuOMzc5dg+QKmTnB+D6HEPRangzTI8FuMSLS/LVfcXSPsyiR+YCFL4YQ
	LGKERdifwr2c6WnqsQP61nRvEW9+Zq/OqcRupOaeTC+A8xmQDFVAsd7peVtGG8/29mOT6EbOJXm
	J4Hz7t/uEcSpy7OAi002D5WMhxa4Tm0EXnkj5fqRVr+wlWwjvducvM15l+xQG1fVCaDAobUKjQ+
	2/CcHVLAl5vi1/tt4DphxoHkHINYa7576ciLuDCoImaatTbmumkca9D8GsrLnSNvkhkuSTq0L0/
	sHzE=
X-Received: by 2002:a05:6214:2b0f:b0:6fa:ab49:4482 with SMTP id 6a1803df08f44-704a39c69b2mr21404166d6.35.1752190955043;
        Thu, 10 Jul 2025 16:42:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFumn70XFYKB3ncuCZuDvnrY3eq7TQ8pExUAVWgvlsUQZnKHPa4PRg6OW5Hg6N9pNtleWcQuQ==
X-Received: by 2002:a05:6214:2b0f:b0:6fa:ab49:4482 with SMTP id 6a1803df08f44-704a39c69b2mr21403936d6.35.1752190954732;
        Thu, 10 Jul 2025 16:42:34 -0700 (PDT)
Received: from [192.168.1.15] (c-73-183-52-120.hsd1.pa.comcast.net. [73.183.52.120])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7dcde422e03sm153989385a.69.2025.07.10.16.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 16:42:33 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Thu, 10 Jul 2025 19:42:16 -0400
Subject: [PATCH 1/3] ARM: OMAP1: clock: convert from round_rate() to
 determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-arm32-clk-round-rate-v1-1-a9146b77aca9@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752190949; l=2053;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=Mg6lKUg0ZmZeW6JyF1mVcF9O9A9v/XbSlh+3Q+sOozQ=;
 b=ov92GEq3BT5OONUOsWz17TkRNeO7aRt0ZTlbqbGGEi2UetR1fyivK2G2OnOxYZ6sBy6ucti7a
 gdJoDFLK4SjCrEBjFyAn/syo/iDX4IRPGYT5L0Z4Z0c9YriPb7H9LJX
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

The round_rate() clk ops is deprecated, so migrate this driver from
round_rate() to determine_rate() using the Coccinelle semantic patch
on the cover letter of this series.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 arch/arm/mach-omap1/clock.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap1/clock.c b/arch/arm/mach-omap1/clock.c
index 83381e23fab983522ca01b8feffb861b02fee730..afc6404f62d39c4ddbac6f1ee04d889be6c47186 100644
--- a/arch/arm/mach-omap1/clock.c
+++ b/arch/arm/mach-omap1/clock.c
@@ -705,14 +705,21 @@ static unsigned long omap1_clk_recalc_rate(struct clk_hw *hw, unsigned long p_ra
 	return clk->rate;
 }
 
-static long omap1_clk_round_rate(struct clk_hw *hw, unsigned long rate, unsigned long *p_rate)
+static int omap1_clk_determine_rate(struct clk_hw *hw,
+				    struct clk_rate_request *req)
 {
 	struct omap1_clk *clk = to_omap1_clk(hw);
 
-	if (clk->round_rate != NULL)
-		return clk->round_rate(clk, rate, p_rate);
+	if (clk->round_rate != NULL) {
+		req->rate = clk->round_rate(clk, req->rate,
+					    &req->best_parent_rate);
 
-	return omap1_clk_recalc_rate(hw, *p_rate);
+		return 0;
+	}
+
+	req->rate = omap1_clk_recalc_rate(hw, req->best_parent_rate);
+
+	return 0;
 }
 
 static int omap1_clk_set_rate(struct clk_hw *hw, unsigned long rate, unsigned long p_rate)
@@ -771,7 +778,7 @@ const struct clk_ops omap1_clk_gate_ops = {
 
 const struct clk_ops omap1_clk_rate_ops = {
 	.recalc_rate	= omap1_clk_recalc_rate,
-	.round_rate	= omap1_clk_round_rate,
+	.determine_rate = omap1_clk_determine_rate,
 	.set_rate	= omap1_clk_set_rate,
 	.init		= omap1_clk_init_op,
 };
@@ -784,7 +791,7 @@ const struct clk_ops omap1_clk_full_ops = {
 	.disable_unused	= omap1_clk_disable_unused,
 #endif
 	.recalc_rate	= omap1_clk_recalc_rate,
-	.round_rate	= omap1_clk_round_rate,
+	.determine_rate = omap1_clk_determine_rate,
 	.set_rate	= omap1_clk_set_rate,
 	.init		= omap1_clk_init_op,
 };

-- 
2.50.0


