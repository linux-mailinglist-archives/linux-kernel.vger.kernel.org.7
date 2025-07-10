Return-Path: <linux-kernel+bounces-726488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BC1B00D97
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 23:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2A3C56728D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 21:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF452FE374;
	Thu, 10 Jul 2025 21:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LjY0M+CA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A752FE308
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 21:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752181912; cv=none; b=rvH2Pqta+3Il4pwJV040oqW+vURQpBC94VZ5YAso2Wh0Ivrcxjm7rvjhYyPUSpdM9fQHrAoEeHZKa1CzRbHJFiV9dfKCxMwKuEF1sl+B7u7pm7+XZ/Xm9+69VhA3YPadFZrM1QV4eeVdVT4K0fjTXjfknb1h5JQbHVxc+WdKMCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752181912; c=relaxed/simple;
	bh=Z9Uj9Ryz7NpcBIB9QkaT0/fa95nPsbwVCXock5kE31I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YzTWtypLo0H1RGgwxyQQ0w09DUkxG+Uv5TbCCqXgKUSv66m34Upzj3YnhNWxXr4WDdj3Fee3Dj9BqV+DQna7aQzcGSz00ZGMsNEr/5fY+fsj8cB1etcNLbrUv3pxaK8irBMaij/fn18mh7NTFdtuYa9RjcMU/3XHzeoiQWfnd18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LjY0M+CA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752181909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6wMxlB9MZ68orKi/UWzRs6IFytl0SMGxxkXzUhmjEdQ=;
	b=LjY0M+CAv4q3KCLJ3oBa6CtdhcijoC+frTvwdCb+qtPT+0LLNSoFgCgLa1+ywzE6U708UV
	9zhLAxmywq8G+UO3ACDu2hC07LoparaDfle5uhVDmw9APObtYV+LWVkS5TWCWoMNx9PqBz
	oK85QtIosa9E0CceNF/ml5xLUj+jQM8=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-BqD1rinpMJy7SdkVZWjXGg-1; Thu, 10 Jul 2025 17:11:46 -0400
X-MC-Unique: BqD1rinpMJy7SdkVZWjXGg-1
X-Mimecast-MFC-AGG-ID: BqD1rinpMJy7SdkVZWjXGg_1752181905
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2349498f00eso21475645ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 14:11:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752181905; x=1752786705;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6wMxlB9MZ68orKi/UWzRs6IFytl0SMGxxkXzUhmjEdQ=;
        b=GDtadtqfJ1WWCZLCCopCBf2wHCPp6H8hOZpSltUN4kraPORjuTVhn3oWKKLrxiGVOa
         6kUSPmIAlIfbWEk9LEFVGdnD9+5j7oizIq/9MMNW1/rw3RoHDkZSoJGSx5XJqokZS4dW
         p+VEIaQeVUhdKNoqP7vCoQZaiSgs7YQ61NA/bxEzOK3DV7ATIqMddzIPgn6otD5MOi7v
         Gon0KaMeRnKDmJjVST8/nsOO/S3Z1oXz5jfQ57HGbrCqkO9pLCYHRS+qE2ftiWeg9pBX
         K4MdxyQXXe9VRX1EnRVKAJJoAk4Rn3uqEnYSv6bTE0/fiahVlkS7/4dSwF+zhKA8iWmx
         sdpg==
X-Forwarded-Encrypted: i=1; AJvYcCVX7WqNOlVaBy4WYJe+TGhgCbuUOzf1h9KU2kW8Mv8f7JixOLCwe1kYfb8VmcIHeklDLD754dK/i/luV9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzZoVCQcp1iH0g0iPMae3oJfTaoAjtWXnz6+4l69OLnsX1ustn
	+pb5Z8S1g8aWl8+evB2Xi7FTXy7/YC0IBRpaNTjWM7ZXbojSuaJkf5V/6R0ZOUFcxBMBgyEyoqN
	330Btrj2JrvSVo6QYbL0nuMe0U/M5/advlE5mN1PX8fYJ63F8pAv+tWIm/1NU46qkfg==
X-Gm-Gg: ASbGncuVNaGbd0Ihqw1qc9g8hwRoAlJgK187guNMPPUhdhCPAgQtTl/d4XrFKieHodK
	w7qmylOcColokLaaZM1lStpqxXIqglPIeR0NxLRCNSTWGdYj+ulaqv6tBg3Xm9EWQqh5BLnLLKy
	P1+R/E/nz+5j9z5bInmepbdVngQ+zuGh2od749CpqtdbjkZxMoaOcc+EOsJGYzRxhlVrUob7ZYz
	vgcT93WOyVAzwDh2CvVBSpE/tYl/uNuVaZBJ8HykoPhc5CXkjd21yytr3L7SQh2wWPgYj47nV0j
	vm4wTWQ6mG9OPMWYxueU0s1SS7mCSalLtED6t8e4Bl0IRg==
X-Received: by 2002:a17:903:2286:b0:231:9817:6ec1 with SMTP id d9443c01a7336-23dede5b1camr9198185ad.17.1752181905402;
        Thu, 10 Jul 2025 14:11:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGroYVRzkeih8y5j6Ie9SEEmZ3kfxnIjBvUsUsEOP6IfwHOfSj6KsTc2VE9xDkcqDujs4HIQ==
X-Received: by 2002:a17:903:2286:b0:231:9817:6ec1 with SMTP id d9443c01a7336-23dede5b1camr9197865ad.17.1752181904996;
        Thu, 10 Jul 2025 14:11:44 -0700 (PDT)
Received: from [10.144.155.224] ([2600:382:7716:65ad:9491:c054:6f2d:80ed])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de433e51asm27790595ad.180.2025.07.10.14.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 14:11:44 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Thu, 10 Jul 2025 17:10:40 -0400
Subject: [PATCH 08/13] clk: imx: pfd: convert from round_rate() to
 determine_rate()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-clk-imx-round-rate-v1-8-5726f98e6d8d@redhat.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752181866; l=1703;
 i=bmasney@redhat.com; s=20250528; h=from:subject:message-id;
 bh=Z9Uj9Ryz7NpcBIB9QkaT0/fa95nPsbwVCXock5kE31I=;
 b=+e2l99hJrkomUi1x/QO1jHP0TlIqBGTOsAEf4gqKRSSSU7Bv5oOTumLrGf/XmrQ4c+hLQ7k7v
 OvjZou/OgaEDDrvA/1mdGibI94pnaOY+YblxFxdbczcHsxklPFhyqzb
X-Developer-Key: i=bmasney@redhat.com; a=ed25519;
 pk=x20f2BQYftANnik+wvlm4HqLqAlNs/npfVcbhHPOK2U=

The round_rate() clk ops is deprecated, so migrate this driver from
round_rate() to determine_rate() using the Coccinelle semantic patch
on the cover letter of this series.

Signed-off-by: Brian Masney <bmasney@redhat.com>
---
 drivers/clk/imx/clk-pfd.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/imx/clk-pfd.c b/drivers/clk/imx/clk-pfd.c
index 5cf0149dfa15aab8b4cee47c8120753e3df45dac..31220fa7882b601f3535ad125114dba1eec95a9f 100644
--- a/drivers/clk/imx/clk-pfd.c
+++ b/drivers/clk/imx/clk-pfd.c
@@ -62,24 +62,26 @@ static unsigned long clk_pfd_recalc_rate(struct clk_hw *hw,
 	return tmp;
 }
 
-static long clk_pfd_round_rate(struct clk_hw *hw, unsigned long rate,
-			       unsigned long *prate)
+static int clk_pfd_determine_rate(struct clk_hw *hw,
+				  struct clk_rate_request *req)
 {
-	u64 tmp = *prate;
+	u64 tmp = req->best_parent_rate;
 	u8 frac;
 
-	tmp = tmp * 18 + rate / 2;
-	do_div(tmp, rate);
+	tmp = tmp * 18 + req->rate / 2;
+	do_div(tmp, req->rate);
 	frac = tmp;
 	if (frac < 12)
 		frac = 12;
 	else if (frac > 35)
 		frac = 35;
-	tmp = *prate;
+	tmp = req->best_parent_rate;
 	tmp *= 18;
 	do_div(tmp, frac);
 
-	return tmp;
+	req->rate = tmp;
+
+	return 0;
 }
 
 static int clk_pfd_set_rate(struct clk_hw *hw, unsigned long rate,
@@ -117,7 +119,7 @@ static const struct clk_ops clk_pfd_ops = {
 	.enable		= clk_pfd_enable,
 	.disable	= clk_pfd_disable,
 	.recalc_rate	= clk_pfd_recalc_rate,
-	.round_rate	= clk_pfd_round_rate,
+	.determine_rate = clk_pfd_determine_rate,
 	.set_rate	= clk_pfd_set_rate,
 	.is_enabled     = clk_pfd_is_enabled,
 };

-- 
2.50.0


