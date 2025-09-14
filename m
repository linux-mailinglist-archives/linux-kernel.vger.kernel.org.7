Return-Path: <linux-kernel+bounces-815582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AADF4B5687F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 14:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 623553BE824
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 12:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86A026C3A5;
	Sun, 14 Sep 2025 12:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/rx6r0u"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827BF265298
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 12:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757852488; cv=none; b=NWmhz4Hjei3Kz8GeWtPZy9O3I8gvFl6GK+chWvNmQAjw+1nc3KWEhcGz5IBdv+JFjdxMzjwnddF9AP+AoUy1BDicPibs9ufCeRfJnEAFOIe7PRldbzDUfZibT2V7aQoGthjLrjFqJjxguA4dlwVfnQvNl4hfkBBYhn97dfWZWYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757852488; c=relaxed/simple;
	bh=hyEa/GySa/6Ls75v6+v9jFgXVHwsTBG2UIuaqEWAzoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O2V4P9jt8Nszm6BS/0bGBgiFh3QT1Li0n3KC6Xonq4u4Q1QGfPAYN5qA6L9xK9prWzhM+S8DfFgloN7mK4PaLQABGi98QPX4EeKaguGh+VAe2odlnw/PpKEpxFw/789fGxp2q3rDbIatXrOkoEZh28DacRiDDlrSwfz8vpbnSEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D/rx6r0u; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45dd7b15a64so29360105e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 05:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757852484; x=1758457284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I5V5EvIIFmYlE3GyO/jzMM5XnNife2k0lUvzm2HmsfY=;
        b=D/rx6r0uFSdJtz2w12P1kmfl/F1yXRfsAVUI8lEK+M0KNftzb2UkM0SFDtRIff4FSZ
         BUR9MNPr3NwBx0kqY2iX6M7wTXtLuKGN2kVZyqzRz5YU/5wg0I+aG4Ctq19VEqIfcwvL
         n01aqwHiRjH7zyi1/NsoRLHtL051eEktR5TRF0g/gUfR2oIyDKDrjZCjpkadEuH00zLj
         N/WqSoQ+pf8U+4VUm8GlmqpQR0fv0ldfTjEiAMJeNzUSoinQCWFYZ3B/ABlcOBsT7hFA
         6qbf2fP7FpBZwBtztwBTZqSKbEE+FjMMhTDdwkKv2ERD92CR40hF043bSXjKo1EbU65L
         oDHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757852484; x=1758457284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I5V5EvIIFmYlE3GyO/jzMM5XnNife2k0lUvzm2HmsfY=;
        b=LREK+25lpi4/eRGWZpN7Vrlpn9pv+1D4W5U6X5Z+jrbpiMHQfm9OtifNjT/msxUPNj
         umyyRMgyWIAMXhcKuHUoFq5ZW7vIP+FANtaxVRRKP1B1f6WqhsHGaMlgcIILJOqY+t54
         9UO5lVbxde5bMi2KEj7PFDluS5+nKifnEtBSDN3JHXSM2JVHkHfRwecaX0+2cqaF99Gv
         /FQz75xK/DOtwPo4o2aIbeQnCUJZ7T7Ump200rzv1qJvafCdEa/WlUJuTSaFscijyHMj
         zSxeL1UVgeNk1YeEXHoGRw53F+itOks2FF/h0dt57HzS1wlYIr4mAWS0EQOu207ReqpZ
         ntIw==
X-Forwarded-Encrypted: i=1; AJvYcCWMq3M+VpnafkV7MKwsDCCH6Q7UbScSRJB1abCDOnUIwj/t9N1pnm3SApAv0ch+dE5yiMpxwPXGrC3Rw6E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8pyp0YWzcxZbp55XP3xD4iOuB99DczAMXszvFw03a5kCNNShV
	rGDgP7EcWC750E87fPlt9flPs+ibJo+U7NLCsVHpId/QatQtRza9ITCU
X-Gm-Gg: ASbGnct2KjJ4at6oJ2j69tXa67JXNh5e5wI2HZVBj/v8XatHvTexKbSfV3VbbHVpM4y
	OQ2H/DCT6T3ZoZFmIaIFypjUm2BfjfG/SQV4gZ74Ajud97DREuVTJT9hXiiFR885QpTRggoceqL
	SZxVFnspm0Xj2LS1NoHeyM9YurIBjtjZo/7jsZ56nJR7NMIySuoDkaNzo6Og6Wsn17SQhq27m+h
	9dHYHd49r46badgkzjjlyBOHJf/fTKj493nh2tH8Elt3Bs1n26AmQomUOtCAYB4hidZJg3F7BPk
	p1j1yYMcmOqWJdJgASb71mH4SBH/u3yZ+phx4CLTGN/hh7Ljlq747MT/CyAJg+nfNp49N19FIws
	wjNC6Mz8yTAhXlsIRzVxDVhLsOH9lWm1hmHCfTg9WYP7C4ie7wAr6AI7zCvvKc+6breJZWrbQAA
	==
X-Google-Smtp-Source: AGHT+IG0ZXg0sjBbUNfdeanXFe0dMTX//arWD3IfNQ77haSimowawRn8wcMXpw44W5JXi1TEnscc4w==
X-Received: by 2002:a05:600c:468a:b0:45d:5c71:769d with SMTP id 5b1f17b1804b1-45f2126253emr91249815e9.8.1757852484220;
        Sun, 14 Sep 2025 05:21:24 -0700 (PDT)
Received: from ivaylo-T580.. (91-139-201-119.stz.ddns.bulsat.com. [91.139.201.119])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e017b4222sm136476615e9.20.2025.09.14.05.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 05:21:23 -0700 (PDT)
From: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/5] clk: samsung: clk-pll: Add support for pll_1431x
Date: Sun, 14 Sep 2025 15:21:15 +0300
Message-ID: <20250914122116.2616801-5-ivo.ivanov.ivanov1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250914122116.2616801-1-ivo.ivanov.ivanov1@gmail.com>
References: <20250914122116.2616801-1-ivo.ivanov.ivanov1@gmail.com>
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
---
 drivers/clk/samsung/clk-pll.c | 1 +
 drivers/clk/samsung/clk-pll.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/clk/samsung/clk-pll.c b/drivers/clk/samsung/clk-pll.c
index 6b3593445..e52e010ad 100644
--- a/drivers/clk/samsung/clk-pll.c
+++ b/drivers/clk/samsung/clk-pll.c
@@ -1420,6 +1420,7 @@ static void __init _samsung_clk_register_pll(struct samsung_clk_provider *ctx,
 	/* clk_ops for 36xx and 2650 are similar */
 	case pll_36xx:
 	case pll_2650:
+	case pll_1431x:
 		pll->enable_offs = PLL36XX_ENABLE_SHIFT;
 		pll->lock_offs = PLL36XX_LOCK_STAT_SHIFT;
 		if (!pll->rate_table)
diff --git a/drivers/clk/samsung/clk-pll.h b/drivers/clk/samsung/clk-pll.h
index c07d76121..964c35ddc 100644
--- a/drivers/clk/samsung/clk-pll.h
+++ b/drivers/clk/samsung/clk-pll.h
@@ -51,6 +51,7 @@ enum samsung_pll_type {
 	pll_4311,
 	pll_141xx,
 	pll_1419x,
+	pll_1431x,
 };
 
 #define PLL_RATE(_fin, _m, _p, _s, _k, _ks) \
-- 
2.43.0


