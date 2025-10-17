Return-Path: <linux-kernel+bounces-858393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C95B0BEA8EF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 18:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FC7C188BE6C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91490286D53;
	Fri, 17 Oct 2025 16:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHT45T+A"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5587287246
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 16:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760717663; cv=none; b=RBzlVNsJ2QkGX5yhh6LGWGnoF4UVHo1hgYQxDl8Ns8vOQHlVrR3l4/YCvqlUHnlWJBtxUAtY1AEDBNWkTmF2UdpERdyrbTazR2JhQOmIcLA+oMukboGkax30Kkv2PAgRZrdAg5UDWEjGYW9MWmAJB1/VNWEgQBs4Wh6H/T+c+8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760717663; c=relaxed/simple;
	bh=Cd8oUm5Z29mj16djHEeq4ZCktxy2V2ujF5TAhVpwGz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WVq5IIXiGgwtGojXF+cNOmx2p4+6E6wPvowfszTPjVx4uaVRnUQZkI++CFM8uirwOTELpbCyrJCdQ/d0JNzSgMvhJlYPmpAO2cue/9AI8xbYzbNfeLqui6C7kOEqhtY7DPUOoWIQUt8sGflSic9jaBMJGLrejhNTU6FTcO0TFDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kHT45T+A; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b3e234fcd4bso353935966b.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 09:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760717660; x=1761322460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5wSXHZohsaCEhrjQuZ+j1mQRILOZAzer/gVJVPvJ/bw=;
        b=kHT45T+AyBZVKIT3Eolsi91cSDdzJS3bKfCPN3GpvKrruCYrDralWi3QueCwUSRVJH
         hXFG0ftuyF1GV5+ihYnusjFcxjRilpW5FF32LeC7fIK2xsF7A4O5//1WT4ZauDZ+ntsw
         RkYgdVuFi0WjXsatvUX6jW8dHQ2c9+9wbOi0i3qoIHzWJgyFSDA5H4C5HC9a2OOEqoTf
         dBlwaWEG6v4NxhdVMaljnXdz96Ov3qck87TzTx487Dy7zhod4E8bbrn3fEUdPTw72VL+
         AKq16PdmP1MJVYALYBHOcWX9bFunTb+udoWEfkISaYmyUkL3X6dEYR5nvZIF9hTcmvVJ
         TcEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760717660; x=1761322460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5wSXHZohsaCEhrjQuZ+j1mQRILOZAzer/gVJVPvJ/bw=;
        b=cT8CMkyZCB26Q9FWc3v/C4aDp2ntqQUrN29J3J12yeZEGDda1v7Zz2ChKQuvnk5Yk8
         KKzVQi2jkbTIW2aVF4EhH/4KW7n0fPXZQmrfgao1wW9zZZWHSWqBaLW4sEmZD+lP6aOn
         9i4LZTmR9k0BnYMM16EkfqB6LM0nv6Cn5Lz+VnXlvyHh2uVIuA3yrQTalod5q1Hi0xH9
         tt0ZMvB7a0JvJafXxQv+mw2SX5IXLWbBH/v0hZI12Q9f0m6xYzB5jMyz/KxQ1KSZzC3T
         cO62dWB6zdZgiO4FtGt8/juccmupBO6gFCx89beOmngmppu2Q7tF7dmQY0iUazdxu1I1
         f1Iw==
X-Forwarded-Encrypted: i=1; AJvYcCUYaMAHL1J5OUvYf2j814M+VugYW/xQkjZeTEL/n4lKeDjOIO/Xvx2PNKO9574M3oR/gK932r2gKvlToTk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/ue3ruyEVGst10YoTe7IpN+jhgLJkbDCXa+ZGsPRXPT1Gb3Rm
	jZBcVG3C8qVxvhSUnYCedYXVSeb4JJUaElUpGzauSunNAOmEjYPAXXl1
X-Gm-Gg: ASbGncu9T885vRBGmvJRDf7XkKILcxU5jfIObrsV6ZKkOCPluYpLMxLr8OcBHAE1J0H
	DdXhi0cEsHhrfdLtpIFFd3ei7WOYqAUjt2UOb0NFwzWg5NDjdFWjyGNjkUOogbxcc4jzcKuLQW9
	bsB1O8hTDOwGPg+tlpP2ScwvVp0jFN1Dn5BqSdPvdnaSN8IjLxLkYTdZC//d8DbCxRw6fc2Ht9C
	wubDYOR2zmR8xm6fMkmxaq/jJG7wpTpfjK4zOunhMKNjek0c78cA71dc2VvIn+yETSRq1UxNwPF
	VSd04fOp/m9hipNCH6hjfZrdf2JhUlh5PMcGo1f0AY3G5W/g3T18t9toepm5pCJ23nMe5ODvpXV
	zo3/cXbz3U9OlCG32U/FroflYZLBLNhd6OeldtJvtOyq5PtxS1Jgo88wxMkJN+3zH+99mVWpx5F
	OdgotSkhooHnlIBgl0+K8xozc7BW7Uy3hGORxCNPuMBrbL/LnK/0g=
X-Google-Smtp-Source: AGHT+IHeWvwzswQuS89QqwrkWJejRaA0kdyn1cZQjqE82QizymMChJ/7f4qYNAhj2tOmrYVSNDAksg==
X-Received: by 2002:a17:906:c116:b0:b1d:285c:e0ef with SMTP id a640c23a62f3a-b6471f3c342mr512675266b.26.1760717660204;
        Fri, 17 Oct 2025 09:14:20 -0700 (PDT)
Received: from ivaylo-T580.. (79-100-18-255.ip.btc-net.bg. [79.100.18.255])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65eb036706sm9606466b.41.2025.10.17.09.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 09:14:19 -0700 (PDT)
From: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>
Cc: Alim Akhtar <alim.akhtar@samsung.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-samsung-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] clk: samsung: clk-pll: Add support for pll_1431x
Date: Fri, 17 Oct 2025 19:13:32 +0300
Message-ID: <20251017161334.1295955-5-ivo.ivanov.ivanov1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251017161334.1295955-1-ivo.ivanov.ivanov1@gmail.com>
References: <20251017161334.1295955-1-ivo.ivanov.ivanov1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PLL is similar enough to pll_36xx that the same code can be used.

When defining a PLL, the "con" parameter should be set to CON0
register, like this:

PLL(pll_1431x, CLK_FOUT_SHARED0_PLL, "fout_shared0_pll", "oscclk",
     PLL_LOCKTIME_PLL_SHARED0, PLL_CON0_PLL_SHARED0,
     pll_shared0_rate_table),

Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
Changes from v2:
- rebase
- add r-b tag from Peng Fan
---
 drivers/clk/samsung/clk-pll.c | 1 +
 drivers/clk/samsung/clk-pll.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/clk/samsung/clk-pll.c b/drivers/clk/samsung/clk-pll.c
index 3c7333529..a509180a7 100644
--- a/drivers/clk/samsung/clk-pll.c
+++ b/drivers/clk/samsung/clk-pll.c
@@ -1544,6 +1544,7 @@ static void __init _samsung_clk_register_pll(struct samsung_clk_provider *ctx,
 	/* clk_ops for 36xx and 2650 are similar */
 	case pll_36xx:
 	case pll_2650:
+	case pll_1431x:
 		pll->enable_offs = PLL36XX_ENABLE_SHIFT;
 		pll->lock_offs = PLL36XX_LOCK_STAT_SHIFT;
 		if (!pll->rate_table)
diff --git a/drivers/clk/samsung/clk-pll.h b/drivers/clk/samsung/clk-pll.h
index 04b3fe97f..eddc4cd08 100644
--- a/drivers/clk/samsung/clk-pll.h
+++ b/drivers/clk/samsung/clk-pll.h
@@ -53,6 +53,7 @@ enum samsung_pll_type {
 	pll_1031x,
 	pll_141xx,
 	pll_1419x,
+	pll_1431x,
 };
 
 #define PLL_RATE(_fin, _m, _p, _s, _k, _ks) \
-- 
2.43.0


