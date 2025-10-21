Return-Path: <linux-kernel+bounces-863511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAFF8BF805D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 20:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFF51408417
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 18:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C85350287;
	Tue, 21 Oct 2025 18:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="sh1xbfEs"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704A8350292
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 18:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761070194; cv=none; b=oNpYYJqrauU1eURHxxqcb0TtKI/k/zy2lT8d8D7zKwSi3ORBWG5eg+qFBRWySAeRlHp+JcpYXSKkeZMpcVwfQPtmDRefWax4tvoAHNW9kQgJbkdK0WIy5rgfBnPPRdgkEjz7cCclUoYVHJlA5JT9zjJW/LLV3WLtEw4zZKkEIE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761070194; c=relaxed/simple;
	bh=2Eq9A/AKwnR3gDsuZiWxdapYlfrJ603IEtmRzywXGso=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B/+Co129J4FXmwoVws0DJFCCFuCWnQ/gjVp9Wa2fS1llKqukCH1B4DjSqxF0HcddlLDV1tS4sJreTaAUkSgIsq8sh5C8Iy67ONyp1NZzlVXR1hD2jqjmW8f+CguqT+3mJ309XdjbfvPaO9BL0a5rCC7OBSjrSHfU+JT1R9rPhBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=sh1xbfEs; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b5a8184144dso965059666b.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 11:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1761070191; x=1761674991; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fZfW33wDtMvPrY5GE5lKPaP3JYy6uTE6Yvy/BumW9Tk=;
        b=sh1xbfEsyxanZhnJmfRlO51HBynpowWXhNcWWzxCls8DOoxtH+tF+SMuDv4h0N+zIw
         Q9VFMeD5DXWVUxy7814uTRkzm03NGgEXi+uiAaiU8oi8awVUu4tBhavwhUpEF/Tw1TXl
         HQvEuZN3qsGAq/3ST+y50EfczyPtH4Xp9g+zhDYCRTMRUBTjBmbM7puP+8R0nBoFDZqZ
         XNqUQVrb2WvXEgk0rQN+jUU8+q3EHHa5JQO7oyUP1CNIA5UFkGwAFbE6u0daksFN5TSr
         IHk+SaXCU7z1lWtlGyUuHpQBKYUeqv5M0DHDYFvCl3PprphxtMvr5idP92uN9yrRmj/O
         oVcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761070191; x=1761674991;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fZfW33wDtMvPrY5GE5lKPaP3JYy6uTE6Yvy/BumW9Tk=;
        b=vRSnuYKqVg0eXq/SadAokAxHlErabmxHXFsegBQmwyJaBxahxOVG/C9uGXEi3Qie2Y
         97+MZgnmXgA6it6idY1lRqqzMluktLLYadP8hSGx6Y9DINAgQ77MH87me1gL22FqJpc3
         we+TWuL+KE2yaPPCCqW/iCQRWdh78avceNPY9Oel7BmhKZH3/jMR4n1FcSeXFc97dUyn
         f0JQLJR+BRVd0wmzSUSdk2d+nKePQmkxhzB9u90Yijhw0soeJ/UYt8TNp+mVII7WkprN
         OQ+DEJ/RgSN1W+gzVThDNShedzOSjjN4nAmBseXW6p5VyA8NHuX+7nRSKzM5ecFZjQEb
         /cdA==
X-Forwarded-Encrypted: i=1; AJvYcCX+4Ep3Zv1uyVm6H/egfnUSmbvH/4sD9k0bp8ww7XbtHHlIfqGnNsHoNuYBXiE0cdXsNW+YMM4RS3O/+tU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqewqFCDns1EJysjxitiMJYC9S0cov7ZtRQsLxDQ8z250Gm1X3
	SsU+vV2FtGs/jHsFw8OFwjwke963KZ9MCBIB6Zfy9G78ANRs+sqxr4I6B4k6Y2jd5Ow=
X-Gm-Gg: ASbGnctScNAbaua2cnerKFt9J71xoaEsfxoqZ94uK1W+bWDFmwGJxKRZlLUoCs831h0
	fejd8MRkc5tJEm/ZytIOXa4Uh7GMmmuYoa5XU4uVfi64VV68Yeb/pAlHW/0rt7ivHOz9+D4N5kC
	e/E43TjM23PAv2OqEsw/7AUvOJ5RiTfMmEnLcUauUM/kmGl2dwwAaNY/i7nmASnuIiJ4zlt5B5x
	hIPdi3qz4NlZiOXCK+ynuN+MejHb9/dGZY0etmFOzIB/VYBkbT6yM0B2fEtYOwVVaUGlR4VA7HF
	JsgR+VC99t0nb6N7QQGeihx+Rtfj6G1gnp++OY+s72GMQhr5CrWYnfOWl+5IgxvzsYOLgmnAK5S
	Cpe9AxWQOiQdNFRSXqnEexb3ZZAdub9V4d3L9+DLK5AebaQYNYKLhT+rAuVQLPl25SVP3EgFol6
	tGHg78JfI=
X-Google-Smtp-Source: AGHT+IEtlpg7hHwYviAs9wYaJ8CDpbBGpkeU1rbRL5K3RYBz0JwLkuE1x94/3J0jWIixwOjEj4tdUA==
X-Received: by 2002:a17:907:9288:b0:b3c:a161:6843 with SMTP id a640c23a62f3a-b647403a56amr2215928266b.4.1761070190578;
        Tue, 21 Oct 2025 11:09:50 -0700 (PDT)
Received: from otso.local ([213.208.157.251])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e8393778sm1116758166b.24.2025.10.21.11.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 11:09:50 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Tue, 21 Oct 2025 20:08:55 +0200
Subject: [PATCH 2/2] clk: qcom: camcc-sm7150: Fix PLL config of PLL2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-agera-pll-fixups-v1-2-8c1d8aff4afc@fairphone.com>
References: <20251021-agera-pll-fixups-v1-0-8c1d8aff4afc@fairphone.com>
In-Reply-To: <20251021-agera-pll-fixups-v1-0-8c1d8aff4afc@fairphone.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 Danila Tikhonov <danila@jiaxyga.com>, 
 Taniya Das <taniya.das@oss.qualcomm.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761070183; l=1299;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=2Eq9A/AKwnR3gDsuZiWxdapYlfrJ603IEtmRzywXGso=;
 b=f6OVJw7dVaXmR3bN8+qrmYA4vRl/NtjHLvMpHGDllO4eZ6Umrt9okj7FpWsAidTFfMYCwvrIZ
 iLD5F0UgX4PAioKrJoBKaV0jcuvrWD9MRfX9FRK+H0QYJ90gLRud5yX
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

The 'Agera' PLLs (with clk_agera_pll_configure) do not take some of the
parameters that are provided in the vendor driver. Instead the upstream
configuration should provide the final user_ctl value that is written to
the USER_CTL register.

Fix the config so that the PLL is configured correctly.

Fixes: 9f0532da4226 ("clk: qcom: Add Camera Clock Controller driver for SM7150")
Suggested-by: Taniya Das <taniya.das@oss.qualcomm.com>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/clk/qcom/camcc-sm7150.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/clk/qcom/camcc-sm7150.c b/drivers/clk/qcom/camcc-sm7150.c
index 4a3baf5d8e85..590548cac45b 100644
--- a/drivers/clk/qcom/camcc-sm7150.c
+++ b/drivers/clk/qcom/camcc-sm7150.c
@@ -139,13 +139,9 @@ static struct clk_fixed_factor camcc_pll1_out_even = {
 /* 1920MHz configuration */
 static const struct alpha_pll_config camcc_pll2_config = {
 	.l = 0x64,
-	.post_div_val = 0x3 << 8,
-	.post_div_mask = 0x3 << 8,
-	.early_output_mask = BIT(3),
-	.aux_output_mask = BIT(1),
-	.main_output_mask = BIT(0),
 	.config_ctl_hi_val = 0x400003d6,
 	.config_ctl_val = 0x20000954,
+	.user_ctl_val = 0x0000030b,
 };
 
 static struct clk_alpha_pll camcc_pll2 = {

-- 
2.51.1


