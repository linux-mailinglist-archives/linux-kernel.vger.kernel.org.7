Return-Path: <linux-kernel+bounces-615932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2351DA98451
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Apr 2025 10:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A83C81739DF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Apr 2025 08:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1011EF0AA;
	Wed, 23 Apr 2025 08:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="JQ6dxKwv"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EDA1EEA4E
	for <linux-kernel@vger.kernel.org>; Wed, 23 Apr 2025 08:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745398419; cv=none; b=A9qzaQ253F6ooaPBCkKIxvqnIYmCVyfNQTegiybqNTIMf2AADuCHS+0OkqV+ORgkjyrswWjJZn00Y/AHPyKZBxUIDX0w1pGr4ti5dO8fLTHaTa4ndNJtm6wf8wdBnGG4+lc0uwYxqlpfH/0HiTpobrVE5VQsDBEecoOmXe2qoro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745398419; c=relaxed/simple;
	bh=hUNBaFmuryLSiqonZBkXEQtsg15gF7AsUoqNj03E6vE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dYu/pOHRWeO2xYNvqFIvw0d49/SmXpNORhIVLMEIbZ3ngmvR0904e8kWK1S5Ip6+lmlvVs995I3LXsomfKiPhPXeAzTwOB630+jY3fnulvmKjlyTO8MmRzLC7ee9FS6kTiinwHJ9yE6/UPaCdCHy8Z4aV4/I0C/V2Dkrw2vaK4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=JQ6dxKwv; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-739525d4e12so5231274b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Apr 2025 01:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1745398417; x=1746003217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LngBqhidQc5hV1qBfQLiTbBvW0cuTKWWOhZLN1xZqc8=;
        b=JQ6dxKwvOwkmyAiLmgHwQFoMfPAnPLetBUM1FV/32jWM7AEqN5hfxuptGmUpzw/Hqb
         uLKcelV36tXW51+sA8QPfqbyB9wwHi2b+8ZYQHT6EiDfL2qCaRv2FBtTpD9fa2whAKiR
         4h0g2djK4S0IpMk+tElEdp5N/7u1fFS7FW47qWdcUHv3AYSKyxhbYjqNB6rfktSpZ2fO
         EAI+Ig3e2CG2pLHRyvMQLQXIn1NTmnrIa/vv0WbktmW7aMEUtl9zDEdizdSFE/uMGaem
         aVkrqCDy5o4jKJcy1Cy/ATvGIFyUm9cWyhMITXpnCoVlArqQW8jXw1EplAYCx3CzSuGL
         1krA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745398417; x=1746003217;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LngBqhidQc5hV1qBfQLiTbBvW0cuTKWWOhZLN1xZqc8=;
        b=uPaxae/ttjpaJRA/ubM1UlhSbT9qXN37zH3krOVbtUoAnzltTi3ZEOAUnVfW094hNl
         gA2bGZ+HfYmwsfyV1a9d9lf9SJlD0HysPmmi4GTfTIASKBLXi64eooxj1CzKtu4/Zu4M
         zD75PdfQNmGWI8/8IkUDfXryt6F4AbZFNyDOwBaoMIg/gwBYxex8AVndJL+uhMhwVs3Y
         F4kn06/v2wkTYdKwn+erjjkBgOR4UPw0eezlVwSh5RzXP08EzvMfjbFeZIJcrB4TnQAH
         49Dbwh5sMC2rRCl+x1iQFAsgVW5es/B2OxduUeoI6/i8AiYcdeW66Q02+Opxi40C4BpY
         wygA==
X-Forwarded-Encrypted: i=1; AJvYcCUNwToQONq95yS6h1V/GPLP6iV+FRKuNq5Pf2tHusnvPDao4kMQQUUu3amWqT/O1QZzJbFT7w7rQADtCno=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPvdBHQj10Ns3a9gexdKS+cjO27/9CUaF3rAvNKtSasx6F/LLp
	FcxDRp+RmbDWsJyDvya7wUGuuJF+h3NIi+Ljy0heUKBY5BFtZHalA4UVOlOZ660=
X-Gm-Gg: ASbGncsPtlwWm57K3i2zLBxIiRccZtP2GxDgBGzri/yCekaE/J35mSkQPnP5PIHYTzB
	AVE5JuCL20feMUaHT0E+6cngfUXhywjskVpFVhPofsUtNxbEHBKJ7F57eNUYFW7RCvnnVBmuURK
	BtfUPs2gdQrasuOo+vMCkPz2H061t/DOKfmSVeQf4onFE1hiotKG8zJc36/uDk5FhNlLjcw6/Gz
	9W2d79HJfoeiZuXKlWpVjH64mJSs71HTfuG8pGxFkUIFBN2NmrZFIRtE4dVGoeDUqyZd9q9jbfE
	0Uk8w96tQtspBRL3J/nZR3euQkn3CzTqbyPFTus3Mk8FIxINqQXbydIaIBT/JhlELb2rE0n40BI
	oNg==
X-Google-Smtp-Source: AGHT+IH4EncUbMMGGTtovqXpM8KAlC3PBKqbv9V/w3rD+eU+bA8Nfqf+e+yTH9MYeA3b8C72khucXg==
X-Received: by 2002:a17:90b:51d1:b0:2ff:6788:cc67 with SMTP id 98e67ed59e1d1-3087bbbb5damr22248851a91.34.1745398417053;
        Wed, 23 Apr 2025 01:53:37 -0700 (PDT)
Received: from hsinchu36-syssw02.internal.sifive.com ([210.176.154.34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309dfa5f880sm1047611a91.38.2025.04.23.01.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 01:53:36 -0700 (PDT)
From: Nylon Chen <nylon.chen@sifive.com>
To: Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Samuel Holland <samuel.holland@sifive.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	Nylon Chen <nylon.chen@sifive.com>,
	Zong Li <zong.li@sifive.com>
Subject: [PATCH v13 5/5] pwm: sifive: clarify inverted compare logic in comments
Date: Wed, 23 Apr 2025 17:04:46 +0800
Message-Id: <20250423090446.294846-6-nylon.chen@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250423090446.294846-1-nylon.chen@sifive.com>
References: <20250423090446.294846-1-nylon.chen@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The reference manual says "pwms >= pwmcmpX -> HIGH", but in Figure 29 pwmcmpXcenter
is forced to 0 via an XOR, so hardware actually outputs HIGH when pwms < pwmcmpX.
Thus pwmcmp holds the off-period count, and the driver must invert it
to expose a normal active-high interface.

Co-developed-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Nylon Chen <nylon.chen@sifive.com>
---
 drivers/pwm/pwm-sifive.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
index 4cf3e715fd84..84a7f79589df 100644
--- a/drivers/pwm/pwm-sifive.c
+++ b/drivers/pwm/pwm-sifive.c
@@ -4,11 +4,28 @@
  * For SiFive's PWM IP block documentation please refer Chapter 14 of
  * Reference Manual : https://static.dev.sifive.com/FU540-C000-v1.0.pdf
  *
+ * PWM output inversion: According to the SiFive Reference manual
+ * the output of each comparator is high whenever the value of pwms is
+ * greater than or equal to the corresponding pwmcmpX[Reference Manual].
+ *
+ * Figure 29 in the same manual shows that the pwmcmpXcenter bit is
+ * hard-tied to 0 (XNOR), which effectively inverts the comparison so that
+ * the output goes HIGH when  `pwms < pwmcmpX`.
+ *
+ * In other words, each pwmcmp register actually defines the **inactive**
+ * (low) period of the pulse, not the active time exactly opposite to what
+ * the documentation text implies.
+ *
+ * To compensate, this driver always **inverts** the duty value when reading
+ * or writing pwmcmp registers , so that users interact with a conventional
+ * **active-high** PWM interface.
+ *
+ *
  * Limitations:
  * - When changing both duty cycle and period, we cannot prevent in
  *   software that the output might produce a period with mixed
  *   settings (new period length and old duty cycle).
- * - The hardware cannot generate a 100% duty cycle.
+ * - The hardware cannot generate a 0% duty cycle.
  * - The hardware generates only inverted output.
  */
 #include <linux/clk.h>
@@ -113,6 +130,10 @@ static int pwm_sifive_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	u32 duty, val, inactive;
 
 	inactive = readl(ddata->regs + PWM_SIFIVE_PWMCMP(pwm->hwpwm));
+	/*
+	 * PWM hardware uses 'inactive' counts in pwmcmp, so invert to get actual duty.
+	 * Here, 'inactive' is the low time and we compute duty as max_count - inactive.
+	 */
 	duty = (1U << PWM_SIFIVE_CMPWIDTH) - 1 - inactive;
 
 	state->enabled = duty > 0;
@@ -161,6 +182,7 @@ static int pwm_sifive_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	do_div(frac, state->period);
 	/* The hardware cannot generate a 0% duty cycle */
 	frac = min(frac, (1U << PWM_SIFIVE_CMPWIDTH) - 1);
+	/* pwmcmp register must be loaded with the inactive(invert the duty) */
 	inactive = (1U << PWM_SIFIVE_CMPWIDTH) - 1 - frac;
 
 	mutex_lock(&ddata->lock);
-- 
2.34.1


