Return-Path: <linux-kernel+bounces-829156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D8BB966BD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 16:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21E083B0460
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 14:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6ABD24635E;
	Tue, 23 Sep 2025 14:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UOrjEdl9"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC62253944
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 14:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758638734; cv=none; b=AWD9Ys1WGZgici/CB2UjYMux8kX/sCN0CLfYabowr0nbEMFWD+XpFQ6hwSU+KTihlhPZ335DtKcYIPzgUni85+Y4IUswhF3XCjCKros/k098SS33Q2KnTjDlpb55HF39mV+8JSScJml8qb6r7PxbmaBEbc0A3RjjAhxwgvkyL2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758638734; c=relaxed/simple;
	bh=9KLJ4BwtbpJm/9b4WxuSUtjekeadp6ZfsZa6/vsycek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kDmjeERsl6rY5CAs63R9sE5Izk3C9ZJy+sCw81Mdvxs+NRjaUpqT79RQt/MovSzVzo6E6Z0HEmn2EAqDqFOvGKhAHzfKFRTnq5D1jRlnoPrH0VOar/Ixo30s+oCfIjP4zzhUaEXsESDypXkhF0YziaDDo/BY+f9m26Y3jVPIv0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UOrjEdl9; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45dd505a1dfso40578645e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 07:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758638730; x=1759243530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iJzzrWzUCil64+RXOrKpLt8hJS1/JsUfq3sdCZB4Iv8=;
        b=UOrjEdl9MFT2vIinolk9C2fNfVlEjjKV7oPzOEaofVrCEaCssC5nkdzit14konTK1j
         GXTskkJ37uFUwkwNW0bVB8cBrUCmhE+qy8b3DJkOmhXNLigCAn7hjbRruXsFwuwwxUSV
         ehNAIwWuOvc25j2RZdlp3drm30XaT6+e8i2QKOwCP53pDauF/xxPm0iGSvvC7YgbdpzV
         vYNLYiaCzL/YBJ+P4an8Uewxc+okqdwo3fwCuYWwQDkz6GZXl0HxcrlARp1LyfStu9qE
         MAat8SNwfBGy2+dRafzJ560Rorhxi9lH843QTDRjFz3vf6bWyRpQCw7mWLSdgTZuhRW4
         duKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758638730; x=1759243530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iJzzrWzUCil64+RXOrKpLt8hJS1/JsUfq3sdCZB4Iv8=;
        b=JR1CwQV6BKlxEBj08LdKxSmwt4404OMcNBf5ANfmFO3uS2C1cfjUuPkMtbhrWblT/G
         q/3ajerrX5HADpw3kv05GBP2oqd2kRGlwv08ulXKRcxdhr5ZlFO5OGNG+xpW3fH/Yhn+
         QEoepH80HDUt2tetQmDSUGutJLniTGJnOVRTMhcbBGkWCQssBOsmVOCXbDuMxmMohY93
         5uGIM4qoG4upeSG7drw5hErC6B5tuqT2NrFVQXrvIOnX1c03vRCj8S9Jvqu96eqstAs6
         HeB26Nh9H4CWNzF+8R7ZlSXLfpzDIoFPZ/0KeTC45ZIooBb4MG5OS1MsVJP5CmJ1PNPx
         Pj6w==
X-Forwarded-Encrypted: i=1; AJvYcCVUhJl8Ws1pTgAvQgYJiES82ti1NcfQ/6I5l1y7PZyj/sCZL3wG7+ZkmUGFTT+W99BkM6ziJxsXGEpWyTo=@vger.kernel.org
X-Gm-Message-State: AOJu0YywhQXrE6v3ydMpzSwJYLjltPzZVVwEil1isIY3sl+us3B3Gz9S
	LCOcxbjGZOvX8kL5MTDCHc/sMSkKGuCcH2RZcvyU4C4KKcwHR3fsfCFN
X-Gm-Gg: ASbGncvUhBgmtnhfppICIQ360vp60aCMBDdPPur7S6EjWfMZY0C55aqKWRPC3uY/JaA
	748+yblbs+cSBvcu5bVM2oIu4wH/JosWXc1oC7vPW9kxn39hi5Td3MDaUXgvfFw0RKuVDiAoSgY
	/YpX6m2lCHcx9FIz8q4KBIIYZiltoPEbW4uWSpH7ecQRIZr5R/i0FAahdXAYl1vUdnSMKLiYOsR
	lB7MLDRkoF/IJXdYUAtT1xG9P7XoI6kvAfXLU8yPcDFPWHoPMhJ+r341RbBN7OpZ2uDkD7JpVV5
	CRk2i4QvQASmFLtficleRJNWXul8bC3uCFwe4iBCci+aa1KjP4NxLUpCnflWVTcVArH6FtPX56M
	ZEeW57tVVvOtNFyr2w7cXftLfYN5qMB4ezk2XYXuwW2QIBx9N9szX3Z842ojwAcpWazjkFgyQ5V
	7d5A==
X-Google-Smtp-Source: AGHT+IF8SaV47gPXwoIWR6PYZsGf9RNwLPvhOV3otS7XPoc5em+Mo1XsY9TmdJAjeAKHts9TAgBzRw==
X-Received: by 2002:a05:600c:154e:b0:45f:29e4:92fc with SMTP id 5b1f17b1804b1-46e1daacd4emr26901375e9.20.1758638730444;
        Tue, 23 Sep 2025 07:45:30 -0700 (PDT)
Received: from biju.lan (host86-139-30-37.range86-139.btcentralplus.com. [86.139.30.37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f0aac3fdsm238940435e9.1.2025.09.23.07.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 07:45:30 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>,
	Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Subject: [PATCH v3 5/8] pwm: rzg2l-gpt: Add RZ/G3E support
Date: Tue, 23 Sep 2025 15:45:09 +0100
Message-ID: <20250923144524.191892-6-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250923144524.191892-1-biju.das.jz@bp.renesas.com>
References: <20250923144524.191892-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Add RZ/G3E GPT support. It has multiple clocks and resets compared to
RZ/G2L. Also prescale field width and factor for calculating prescale
are different.

Reviewed-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v2->v3:
 * No change.
v1->v2:
 * Added link to hardware manual
 * Updated limitation section
 * Collected tag 
---
 drivers/pwm/pwm-rzg2l-gpt.c | 46 +++++++++++++++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c
index 0af3aaf1917a..087bc3c0778c 100644
--- a/drivers/pwm/pwm-rzg2l-gpt.c
+++ b/drivers/pwm/pwm-rzg2l-gpt.c
@@ -6,15 +6,21 @@
  *
  * Hardware manual for this IP can be found here
  * https://www.renesas.com/eu/en/document/mah/rzg2l-group-rzg2lc-group-users-manual-hardware-0?language=en
+ * https://www.renesas.com/en/document/mah/rzg3e-group-users-manual-hardware
  *
  * Limitations:
  * - Counter must be stopped before modifying Mode and Prescaler.
  * - When PWM is disabled, the output is driven to inactive.
  * - While the hardware supports both polarities, the driver (for now)
  *   only handles normal polarity.
- * - General PWM Timer (GPT) has 8 HW channels for PWM operations and
- *   each HW channel have 2 IOs.
+ * - For RZ/G2L, the General PWM Timer (GPT) has 8 HW channels for PWM
+     operations and each HW channel have 2 IOs (GTIOCn{A, B}).
  * - Each IO is modelled as an independent PWM channel.
+ * - For RZ/G3E, the General PWM Timer (GPT) has 16 HW channels for PWM
+     operations (GPT0: 8 channels, GPT1: 8 Channels) and each HW channel
+     have 4 IOs (GTIOCn{A,AN,B,BN}). The 2 extra IOs GTIOCnAN and GTIOCnBN
+     in RZ/G3E are anti-phase signals of GTIOCnA and GTIOCnB. The
+     anti-phase signals of RZ/G3E are not modelled as PWM channel.
  * - When both channels are used, disabling the channel on one stops the
  *   other.
  * - When both channels are used, the period of both IOs in the HW channel
@@ -153,6 +159,27 @@ static u8 rzg2l_gpt_calculate_prescale(u64 period_ticks)
 	return prescale;
 }
 
+static u8 rzg3e_gpt_calculate_prescale(u64 period_ticks)
+{
+	u32 prescaled_period_ticks;
+	u8 prescale;
+
+	prescaled_period_ticks = period_ticks >> 32;
+	if (prescaled_period_ticks >= 64 && prescaled_period_ticks < 256) {
+		prescale = 6;
+	} else if (prescaled_period_ticks >= 256 && prescaled_period_ticks < 1024) {
+		prescale = 8;
+	} else if (prescaled_period_ticks >= 1024) {
+		prescale = 10;
+	} else {
+		prescale = fls(prescaled_period_ticks);
+		if (prescale > 1)
+			prescale -= 1;
+	}
+
+	return prescale;
+}
+
 static int rzg2l_gpt_request(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct rzg2l_gpt_chip *rzg2l_gpt = to_rzg2l_gpt_chip(chip);
@@ -459,6 +486,14 @@ static int rzg2l_gpt_probe(struct platform_device *pdev)
 	if (IS_ERR(rstc))
 		return dev_err_probe(dev, PTR_ERR(rstc), "Cannot deassert reset control\n");
 
+	rstc = devm_reset_control_get_optional_exclusive_deasserted(dev, "rst_s");
+	if (IS_ERR(rstc))
+		return dev_err_probe(dev, PTR_ERR(rstc), "Cannot deassert rst_s reset\n");
+
+	clk = devm_clk_get_optional_enabled(dev, "bus");
+	if (IS_ERR(clk))
+		return dev_err_probe(dev, PTR_ERR(clk), "Cannot get bus clock\n");
+
 	clk = devm_clk_get_enabled(dev, NULL);
 	if (IS_ERR(clk))
 		return dev_err_probe(dev, PTR_ERR(clk), "Cannot get clock\n");
@@ -497,6 +532,12 @@ static int rzg2l_gpt_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct rzg2l_gpt_info rzg3e_data = {
+	.calculate_prescale = rzg3e_gpt_calculate_prescale,
+	.gtcr_tpcs_mask = GENMASK(26, 23),
+	.prescale_pow_of_two_mult_factor = 1,
+};
+
 static const struct rzg2l_gpt_info rzg2l_data = {
 	.calculate_prescale = rzg2l_gpt_calculate_prescale,
 	.gtcr_tpcs_mask = GENMASK(26, 24),
@@ -504,6 +545,7 @@ static const struct rzg2l_gpt_info rzg2l_data = {
 };
 
 static const struct of_device_id rzg2l_gpt_of_table[] = {
+	{ .compatible = "renesas,r9a09g047-gpt", .data = &rzg3e_data },
 	{ .compatible = "renesas,rzg2l-gpt", .data = &rzg2l_data },
 	{ /* Sentinel */ }
 };
-- 
2.43.0


