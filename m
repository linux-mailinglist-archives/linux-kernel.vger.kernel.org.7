Return-Path: <linux-kernel+bounces-811759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFFFAB52D84
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 11:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C12B01C85A69
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 09:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5B82ED15C;
	Thu, 11 Sep 2025 09:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bt5R3C4N"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8C02EA74D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 09:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757583816; cv=none; b=lCM6XlMtByl+Zkb9tCJY+ZgZoHxJZ3sUbK6KOp87pSc1p4zzcjwO9HO2fKPRxgRxkqpnx8ACHtSYFcAAn76FrRnUaBEFGcxM8BDJK1M7+SbvgH1lkwEmuWSHEwSZVqKZd1XrVTY2ps+a0sC5wwM7lCu5H9MxF26f3OeU0IjXnQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757583816; c=relaxed/simple;
	bh=56WhvEjp/PteZn0tyO9c/SCroF1xJwxk2BOxQgVeGvo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lKy40DNyX58J1OuSVWiM6szd8iwuSgPdHUEnDjXxAkVakjVrotVgiO5FX18NR/d9HhqDRUHCSeJUQMKmZakYgra8Ieh4KPXWLJnn3zYPuVvbsMd9em1lvV8lLKqWxc6I9aa8x3tN8BpWPfhaHq2NV4QSE2wvXxmjXAz9TnzEcU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bt5R3C4N; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45dd505ae02so705455e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 02:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757583813; x=1758188613; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3WpkGEUpfxQBkF0AFg2VeVRpKBfctEX+Z1irkwx05L8=;
        b=bt5R3C4N/krEXlprt3p+xl409XPbHQTiFkjxok0unzjv8pQ+zTFV/bIq+abB+IW2FY
         6ASEIjKwf1B94yQOhpmIVGkTP9cgD8z+0A2kHGl5sYeRHWJlHC6XJoZIdSu5U8kWdpoc
         IuGBbhwQxQ+LwiKhWtYQofMES5++yYld0GdQLZnVUGf2ky0Eua8VhQ9elaR8k2s/9yGz
         NrH4aLYQVp32ntcWGOVEq7dAy/ARup63fWc9UNKaGgYBjQPghgWDioeCa+N282r4EtXY
         xdmnEPG/MlAbdPB/1TlrU7znbDjQu7loxl9161c100S+7x8RM2ihkUX+kmzYM6Sg3Wov
         9H/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757583813; x=1758188613;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3WpkGEUpfxQBkF0AFg2VeVRpKBfctEX+Z1irkwx05L8=;
        b=M7mqTae8THS8sI7aAx6OH3CPXANEDgUbbvMflBfvOeF8NUl75ORZxA0hyt4Iac1dS3
         T8cHpA+oFKBi1lwerbjiHf7ZT9h/LD6UKsMdIJ4smvdX/012nu9MOIp/alZMXBKg/Fmf
         2+5jf534ZbhhkTUBib69YnlzlXXl1FwrmxcHAzANwXO143JSUN1WVouQBTe0qjOvfkFk
         G8/RP+grpzgfpksfww58tO+uq7OIXTsZgP7QMWWzaiwlsUDaC4BAKftgehDf00NcEu3d
         bllRkripbJcPz2+12z/H8zP/raCbwUHXo7PsqYgJ3nQpOtCATfDHK1nbu6TflFnn1K39
         Ez1Q==
X-Gm-Message-State: AOJu0YyYxMIEuifwfhXDxUysn2XIO1rFxfTCA/ngxV0ytB7hdraG9RaH
	8SPY/rJjLR3aVS4qNSiK1PkHgfau3d88V8h0kFBtwtGHRgKNqhXdbsI5WtQu4xEsTdw=
X-Gm-Gg: ASbGncszbs5jm9N41KdOEoLs2G6+OgPhLwWyr0u8ujRZvQH6Om/w1IruNfVEJKjuFA0
	JLxBAy/nMI+bQbfmV62l6xaqNSPsYoM4TScUJIzqFvwkjGENrKMogHexHodiyIopmbXxA5BD3z8
	UWaNW5zcrlzGjR36ZIHS+fq9iMkzTLMk6F8NZdrwjH2fRm2QooopiXXeIW49Q9ek5vA6VDekVmR
	oWizSIFXm7YjV3XUZDThh/cAe5tz41wezrQFV5OfA1Ik+bzpKl8KJVGLvaNDJI/Cq4xXmVwRti4
	B8kERKBGf4iZZEOCobhn0Me0jZsxavMvltH+XKz+cxXzJdS5yCxaO2gf2Bpar8KmZrkTKarderp
	g7SsfO7mVyisvwUKS+oixxcJObmDvwm7YH67EeJc=
X-Google-Smtp-Source: AGHT+IGOi8yePNpjL9Di2sL2vnUH2TM8QtjY6K907W0jyRKbUhHFCvXr5nWkzRUEpbuxYpHNK796lQ==
X-Received: by 2002:a05:600c:3508:b0:45d:ec41:e0d2 with SMTP id 5b1f17b1804b1-45ded9275a2mr42386125e9.3.1757583812634;
        Thu, 11 Sep 2025 02:43:32 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e76078fe3bsm1759218f8f.28.2025.09.11.02.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 02:43:32 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 11 Sep 2025 11:43:16 +0200
Subject: [PATCH v2 05/13] memory: tegra30-emc: Do not print error on
 icc_node_create() failure
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250911-memory-tegra-cleanup-v2-5-d08022ff2f85@linaro.org>
References: <20250911-memory-tegra-cleanup-v2-0-d08022ff2f85@linaro.org>
In-Reply-To: <20250911-memory-tegra-cleanup-v2-0-d08022ff2f85@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, 
 Aaron Kling <webgeek1234@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1222;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=56WhvEjp/PteZn0tyO9c/SCroF1xJwxk2BOxQgVeGvo=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBowpm1xGat8rkZCvILMqUYbZN3jt3PPw6hxPAdh
 THBB4Skd8mJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaMKZtQAKCRDBN2bmhouD
 1z1sEACZH4T1RNX6pSPNQRXKPTNegmtWwifR0vG5bf/r8FnbJ0aZzbDlYHhXhk0GDlP8YrVDiKz
 dA51H3u/TRAaOWIMEQAXVVEbOOuwPwDYzpIw/TUawL3xT8pvO/NjwKvO4CkBAZMy2OGbSYaZUyc
 ICG2I5hG3f7f8MwGtkt6ndD0A2EHcPSt6BOEyTgu975w9jQrHLzKQrwy2lOYtlEJYhLJ4eFPQ7I
 J1e2g3/efiL0FNZcRHmX9akTZGR3cAE1h9fuea/1uah2fpRl11kHF0JVV9rXodfWG3D4yWdBFkQ
 /iA+IrIAm7U0rM7SEykgTpb7bTpvTPabITxGxQD6UyPzR2CTXwKY0umkhyRFJ+3PCwNY8MvBBTx
 wjtTjk8W7/M9Bra8bSMmHaz6QvyKEoP16cRVA7klBrrTs9QBP2hLGDeZ5413Sj1+g+EfVnP6uYF
 aTq7tTKDTMICV/Ks1XdlOTkVqGCaDgJVxGQi6yUmpg2BvUbqm49+3mXojxTqv5jwt7qrPBqj0iM
 /KPg7h/nvvB2lr0no04+2GOxDjegZED3q6IG9xKR4HHJSqEuVY2g+gpwUGi1ScETcNFegbwyRjo
 rxbyR/pqPV/HMG/wSqMYq+6LNQDtzPAV7dx58sgryXqU/M3M9bFJ7TugjyMLWvRLMLGkgcEQDZy
 FV6QJn/vu77kGLA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

icc_node_create() is alloc-like function, so no need to print error
messages on its failure.  Dropping one label makes the code a bit
simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/memory/tegra/tegra30-emc.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/memory/tegra/tegra30-emc.c b/drivers/memory/tegra/tegra30-emc.c
index 921dce1b8bc6382ea66d70ad0f2a12283316ad90..c96aa63a5aa085a409ae7ec901d2a210748f5bcb 100644
--- a/drivers/memory/tegra/tegra30-emc.c
+++ b/drivers/memory/tegra/tegra30-emc.c
@@ -1534,10 +1534,8 @@ static int tegra_emc_interconnect_init(struct tegra_emc *emc)
 
 	/* create External Memory Controller node */
 	node = icc_node_create(TEGRA_ICC_EMC);
-	if (IS_ERR(node)) {
-		err = PTR_ERR(node);
-		goto err_msg;
-	}
+	if (IS_ERR(node))
+		return PTR_ERR(node);
 
 	node->name = "External Memory Controller";
 	icc_node_add(node, &emc->provider);
@@ -1565,7 +1563,6 @@ static int tegra_emc_interconnect_init(struct tegra_emc *emc)
 
 remove_nodes:
 	icc_nodes_remove(&emc->provider);
-err_msg:
 	dev_err(emc->dev, "failed to initialize ICC: %d\n", err);
 
 	return err;

-- 
2.48.1


