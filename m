Return-Path: <linux-kernel+bounces-726519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33982B00E13
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 23:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E28F5C3C98
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 21:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104A7293C49;
	Thu, 10 Jul 2025 21:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jGkXf8bE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9979292B3A
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 21:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752183953; cv=none; b=JxiibyfdT4WhogWlfyZY0ffXvUYYp/MrILS3yfPJLQaIf1u01L6RyZ+T4Cive7yNW50UCFILlcP1FE/UZ0OJD6JaJi41SrmwrIEJ7fNKWI+pt3q4gri9i8n6eb1FVKw6IN4RJpaNM0pN/HsFFQOqBz9H5nxn4TwIa1hhqsXureM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752183953; c=relaxed/simple;
	bh=ndPCip5Ck49Ktpl48PQwNNnmNxNYrh2g8orjKuDJO9I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NdEbTGcMnTGbtrsVcNXDuZVRgxVzGdIl/OPcIBtgJZ4+pbTUl42NfrND1wPM0W+AKpC7DMp8TtWlVms3v9V9f7pw15X16X6C8L/vCfExYQnh9qT/cx3cULHGB+Xz0gOUYFoxohwloDqZNNANJB2XK6YYE7Ug2H+7e5QTziFwEQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jGkXf8bE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752183950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ONo+hxsTcQLvNwo/8GiZ2ZjWgPZLalbno8Kj8Xd4p3g=;
	b=jGkXf8bEktNRQnRlsFEdv+ROp+q+EF2TQpo0GEMAhrYZkxyWsB+S/1M4z9WGJ+GYQ+8LHl
	g8oVKNHfkuT1EosdErj5SVCUhCy/XQ1dPa/Zbh5mofSFc7AbtGWsHdVy+8/NdUI2YUdf44
	9AkpRQNggEUjTQwSOzmXQvM/xFz+ja0=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-cDfkcCgNOkiMXS-QHPiCjQ-1; Thu, 10 Jul 2025 17:45:49 -0400
X-MC-Unique: cDfkcCgNOkiMXS-QHPiCjQ-1
X-Mimecast-MFC-AGG-ID: cDfkcCgNOkiMXS-QHPiCjQ_1752183949
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-40b5955b907so1064277b6e.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 14:45:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752183948; x=1752788748;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ONo+hxsTcQLvNwo/8GiZ2ZjWgPZLalbno8Kj8Xd4p3g=;
        b=beDVvGuKkrziVMrPfUV1qO/PUAuZqS9EPf8NRuWpD1SyKrrQmMKSPASNMRsLNp0Wwh
         8TqmNG0faOsx8R2yaCqJclB87BQ+9HOZc9YNeV0k7oHTX6DNtmn02QpZZx5Sff1qyy56
         wyUs8dwn1IzBHgpZdk4n5sTOts/Y6Fc7zbKrQzPvOKpJ9GNq6xP/4kqqgk+UOEMJHzpa
         EXdt9lNDs8/LUGyeF+uffyUsXBEgqAsxmnMJJc51K9+1ePRsT0TMEP0FwvIPmzr7z10v
         iFt6D2SnT3lC25IEdR7k9qoRvCxpdpIO4RRPnu8hoYDuz8quy4g4aj51P8fQ4aoOKWvX
         dOvw==
X-Forwarded-Encrypted: i=1; AJvYcCVRzi5iInLVug8V3zv/PZV7MTIbapwzLKEBuI9mlpUwnzsi0B7DkaXArpC2d7e6We36FCc3AfIxaGsRlfw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPCIcm4krbfs+fjzrWT7Q27gX4h8p/66B/uOr+1fWg5zahzvPf
	40bfnWMpuhdNk2sCMuukyzOd8c/+mxBPv0HFU9zX8oc93VD9SZ7lALNxof5mgXp4nxZFw2r2Sxw
	C8kAalh1/uIphOYMUECpqxvILDLycmx2l227EmCXwbPKM2GVK4GSyuGzPG4SH3mD1bDXlfF6dOy
	wzffiGxteiUUoMHh5o9HYtcEuh9yKgxuXthIhH8JrcQM4wHJav/XU=
X-Gm-Gg: ASbGncvxNhB1I/YpVw+Nu/5N8+tAaLZb5ZLTtwKjCagSkU02b+fOLmJSuSOtrHkItjC
	e3YDU7GgQ+lEl6sO5glbEiNN2CI/6gvJdJ+WmKC2aIfaMaSRctS+QrqD0VmQ3LvYyk4ZiwIuMZi
	i5dcMvXeI7jGGaMWnjxNThee0IQy3vROL45CPdQSotG0Cub+7hbHkogsoUqnf78FFKRRbPfOLw1
	OrlG4DzU1QJe2mtrsNLaX486IByVnhlBq2ux+RyCiiJbJ3iExwLR2YHiiRxtrYwSXGonEfpEYJM
	IShK+ldVbaXZsCaeMPt+om/o0TwdShQ8dq7c+R/h+2In
X-Received: by 2002:a05:6808:3013:b0:410:f252:f7e6 with SMTP id 5614622812f47-41511df266bmr906382b6e.34.1752183948180;
        Thu, 10 Jul 2025 14:45:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmEibMp4jcs1PHg2/eDyFmepCD2/DXzIyOVJWa/cAmoDFj6xW1ug6RaX8Welo8ps5dQFbrew==
X-Received: by 2002:a05:6808:3013:b0:410:f252:f7e6 with SMTP id 5614622812f47-41511df266bmr906357b6e.34.1752183947879;
        Thu, 10 Jul 2025 14:45:47 -0700 (PDT)
Received: from [10.144.155.224] ([2600:382:8102:a87a:c1c4:9ad5:f0c:c0f7])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-41419baa00dsm345483b6e.22.2025.07.10.14.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 14:45:47 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Thu, 10 Jul 2025 17:45:14 -0400
Subject: [PATCH 2/6] clk: tegra: divider: convert from round_rate() to
 determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-clk-tegra-round-rate-v1-2-e48ac3df4279@redhat.com>
References: <20250710-clk-tegra-round-rate-v1-0-e48ac3df4279@redhat.com>
In-Reply-To: <20250710-clk-tegra-round-rate-v1-0-e48ac3df4279@redhat.com>
To: Peter De Schrijver <pdeschrijver@nvidia.com>, 
 Prashant Gaikwad <pgaikwad@nvidia.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Maxime Ripard <mripard@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752183937; l=2053;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=ndPCip5Ck49Ktpl48PQwNNnmNxNYrh2g8orjKuDJO9I=;
 b=B/q0XSluAhzG2nFJAiFhQSNqVVlC50DcZTETKcq2QmqaxKRPZ49PFzu2nTL38lQA+XOSSZi6N
 6ENwvYARumCC5WpD8mGIYKyWF6ZUOmIvrRzeqmhuGeLszK53Nx9Hdeh
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

The round_rate() clk ops is deprecated, so migrate this driver from
round_rate() to determine_rate() using the Coccinelle semantic patch
on the cover letter of this series.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/clk/tegra/clk-divider.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/clk/tegra/clk-divider.c b/drivers/clk/tegra/clk-divider.c
index 38daf483ddf171293666cea25179a9c8809d8c3f..37439fcb3ac0dd9ff672a9e9339ed6d5429dabaf 100644
--- a/drivers/clk/tegra/clk-divider.c
+++ b/drivers/clk/tegra/clk-divider.c
@@ -58,23 +58,31 @@ static unsigned long clk_frac_div_recalc_rate(struct clk_hw *hw,
 	return rate;
 }
 
-static long clk_frac_div_round_rate(struct clk_hw *hw, unsigned long rate,
-				   unsigned long *prate)
+static int clk_frac_div_determine_rate(struct clk_hw *hw,
+				       struct clk_rate_request *req)
 {
 	struct tegra_clk_frac_div *divider = to_clk_frac_div(hw);
 	int div, mul;
-	unsigned long output_rate = *prate;
+	unsigned long output_rate = req->best_parent_rate;
 
-	if (!rate)
-		return output_rate;
+	if (!req->rate) {
+		req->rate = output_rate;
 
-	div = get_div(divider, rate, output_rate);
-	if (div < 0)
-		return *prate;
+		return 0;
+	}
+
+	div = get_div(divider, req->rate, output_rate);
+	if (div < 0) {
+		req->rate = req->best_parent_rate;
+
+		return 0;
+	}
 
 	mul = get_mul(divider);
 
-	return DIV_ROUND_UP(output_rate * mul, div + mul);
+	req->rate = DIV_ROUND_UP(output_rate * mul, div + mul);
+
+	return 0;
 }
 
 static int clk_frac_div_set_rate(struct clk_hw *hw, unsigned long rate,
@@ -127,7 +135,7 @@ static void clk_divider_restore_context(struct clk_hw *hw)
 const struct clk_ops tegra_clk_frac_div_ops = {
 	.recalc_rate = clk_frac_div_recalc_rate,
 	.set_rate = clk_frac_div_set_rate,
-	.round_rate = clk_frac_div_round_rate,
+	.determine_rate = clk_frac_div_determine_rate,
 	.restore_context = clk_divider_restore_context,
 };
 

-- 
2.50.0


