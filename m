Return-Path: <linux-kernel+bounces-824342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D69B88BB2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 12:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36D3F1C2503D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 10:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF342FC01B;
	Fri, 19 Sep 2025 09:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="ljLPR3hH"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806042F5A17
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 09:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758275963; cv=none; b=fUL8WoVWGgHSz43oTYulvsVfnHM/iGT3XjGP49nK0zQ34TGczi+NEcOehGPmkI/+Csxvgr7BCHyQLafk/n2QtMYs27Dk8l8WS255UC3HpNJIHdPzpSceWO5KaUugxlfLuYwH5KV3HmyJZJC+Qe+Updq9g09+RQMvROcj2kyGj2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758275963; c=relaxed/simple;
	bh=vbP03XlE1h7xnXHsE6YxSmU4t7foc5GMAXHOnth1Kak=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DQMhTC1Rev+Wgb/f27PcManpI+owy/2qUxNbTb8YzcO1+JpYHbk/Bj2V4j6jBpkKRjBtc82TkoL7YqASh2XTJPQIFj08Uyie1WCAcgQWiTzenEyvQ1exnUzmHaJnKlNXhIefZH7XdnpEciqdFMc8qSFHuSiBvAwVK38hV7DVQjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=ljLPR3hH; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-62f92a83e7fso4125709a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 02:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1758275960; x=1758880760; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HRCjBM+UZmtDkzaHBLv8yNwvYcdqAmpzBt7Gyq2DkH8=;
        b=ljLPR3hHzSJXcJkUGL+iM62KIUPeW37CxYkOshGTYxeCiUOHiN9PY2r0PrSwCj1cUh
         BAphtPA3BKJcN6atFC39OCHXAjVU29ubGTvrG87/BziM4hAMHrlCqcjInisWvVR2XwL5
         yqHi0sEgurQ89N8rRfSrF9T2VEYRNiKIWw0seIcrQbMl5zg2/BhOyFlpNbzPKl9kDTzv
         6R60C2qXmWR5QJsOsuWeJ+m5Iw6koacaRCu31tM4HDPCZM+hGze3B2ABpoXIFfpf0OGT
         l22Kyrh1XkJP4oY9XUbVC/gX+m0dYMwqOvj7e5Mtns9wpwHwyg/Mf0KmMlUcANqq2apD
         I/mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758275960; x=1758880760;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HRCjBM+UZmtDkzaHBLv8yNwvYcdqAmpzBt7Gyq2DkH8=;
        b=OODNEsUQirDxySM3U8JzfSJWOE/J90FqN/r2uc7qMLCeVDIeiGfgmRiYPRLLSbiJdO
         kga2cs0jOu2Hkcfwcp7i4MF3TfXiCqtJydLhi+l41LKk91Rwh0kisyXIDjPqqwZYC1/O
         1c/obPL1ql/ZaCWKouc4ewJFjf027at2UpFjDv2iF5pxxKizxWEsFuQ5LKZf7i1qC1K0
         lydykZCBDYQxgM6fbz/nj7feZhOP2bDdx+Zl6DN/xKLr0mBtwjQf+3O2tZTOR7LMdzb6
         M+b2zx/hBpjVhAujJKS1wvbJslzEjUUK3hjoA8T8CMX74dLSJLKbHO+A99bGm+Rb5D8a
         xV4A==
X-Forwarded-Encrypted: i=1; AJvYcCWGpToWKmCFJ42wvb7aczDperN8IJkW+JNiKDAPVcrI51YND3V69enOKGkZNTXlEvLgBXw41yAccEoKhCw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxgmb8NXuUqBRKFcf8It3X8pX9QMBfhlOvti3j7PvydFWqTrhw
	ZcGts2Eh2rA9qxebsEjW7JKmyFyU25KRzpcG/QcxbBPF5PLEibOv5hzWrAyrAxUyEtI=
X-Gm-Gg: ASbGncuBr5Mt1nZyEnWt2RpAuLQpZbpWKh/9hbrhYEZXyFY28yEF5Fcolei8D3F4CmK
	8ELH6FGRFuYYNeqzf/+Ze7KgZp2io8y4V+qTnp5ymbnzGZcR0sTWNALYb3sUkmLL+J2iva3c1Sl
	NSO0kzIA62unFn4ceXOZUZlFD04JX+g9BlvMCObld8C7Cc63aqKTU8cSgWBLBFlZLlVQzAMmoyD
	r5L8MySmJn/xkWyCE2jGf7B8F8fO2KJ/l6JhwFs3jKUptAsgpz2xnd0HHti+FaQJIe1N8+vpCrT
	kFcN0FgDQG2kH/OIap9Y+9M4d5XIw9nHDjrrcucxAiK6pfJmnGiafCKVYHyfYv7GLI1Jbiti2x+
	WbLN57A3NZJEzDb+dbSlMy64evYWpnHQUAwsuyCx3w30Mxp9sWlDUPUyLPfBV8YctPmaqRw==
X-Google-Smtp-Source: AGHT+IFgmVd41y35n12dNNDHlT8B0lvOLEpxp28IQxQRb5l7rrryU13J2m4N5veYjKoNAlTvU8u3FA==
X-Received: by 2002:a05:6402:20cd:b0:62f:a06a:5359 with SMTP id 4fb4d7f45d1cf-62fbe458ab3mr2516436a12.11.1758275959599;
        Fri, 19 Sep 2025 02:59:19 -0700 (PDT)
Received: from otso.local (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62fa6f03008sm2972107a12.7.2025.09.19.02.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 02:59:19 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 19 Sep 2025 11:57:24 +0200
Subject: [PATCH 2/3] clk: qcom: dispcc-sm6350: Add MDSS_CORE & MDSS_RSCC
 resets
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250919-sm6350-mdss-reset-v1-2-48dcac917c73@fairphone.com>
References: <20250919-sm6350-mdss-reset-v1-0-48dcac917c73@fairphone.com>
In-Reply-To: <20250919-sm6350-mdss-reset-v1-0-48dcac917c73@fairphone.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758275958; l=1177;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=vbP03XlE1h7xnXHsE6YxSmU4t7foc5GMAXHOnth1Kak=;
 b=oKNSfmdNf301nQfc/PDdXbR7+ZlQdp0XSLyKqYLiOBuBW9hrNj940/clNKq7jd1x61ljxPbO4
 4Zuv5gmqejyAEbeikZjWbZe8LVq/5JdMsfAnMcmLjFGp5mtmJrE06iX
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Add the offsets for two resets inside the dispcc on SM6350 SoC.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/clk/qcom/dispcc-sm6350.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/clk/qcom/dispcc-sm6350.c b/drivers/clk/qcom/dispcc-sm6350.c
index b0bd163a449ccd2b27751e32eb17a982facf07d8..5b1d8f86515f251d90e01a4f3cb3b5582b5db683 100644
--- a/drivers/clk/qcom/dispcc-sm6350.c
+++ b/drivers/clk/qcom/dispcc-sm6350.c
@@ -679,6 +679,11 @@ static struct clk_branch disp_cc_xo_clk = {
 	},
 };
 
+static const struct qcom_reset_map disp_cc_sm6350_resets[] = {
+	[DISP_CC_MDSS_CORE_BCR] = { 0x1000 },
+	[DISP_CC_MDSS_RSCC_BCR] = { 0x2000 },
+};
+
 static struct gdsc mdss_gdsc = {
 	.gdscr = 0x1004,
 	.en_rest_wait_val = 0x2,
@@ -746,6 +751,8 @@ static const struct qcom_cc_desc disp_cc_sm6350_desc = {
 	.num_clks = ARRAY_SIZE(disp_cc_sm6350_clocks),
 	.gdscs = disp_cc_sm6350_gdscs,
 	.num_gdscs = ARRAY_SIZE(disp_cc_sm6350_gdscs),
+	.resets = disp_cc_sm6350_resets,
+	.num_resets = ARRAY_SIZE(disp_cc_sm6350_resets),
 };
 
 static const struct of_device_id disp_cc_sm6350_match_table[] = {

-- 
2.51.0


