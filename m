Return-Path: <linux-kernel+bounces-829155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3705B96693
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 16:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D50EB17F34D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 14:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445AD25E824;
	Tue, 23 Sep 2025 14:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FEQT7DYo"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1341917E3
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 14:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758638733; cv=none; b=dD6Rb94uLITHFeDWF9hB/k5XMMPe64L3qkGC3ltQbJw0nh/HNGf/nKd7Jl4nr6ZND8qO/aFtP/qy5bI0m5sIGtCQbmMJxS7/6AUPHG4Saf32NQwlBDri79Bu6V2twZkM8sbKRI2lewiKnYELMONfNJ+PQQ+tIgvKrCT0gT4PlCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758638733; c=relaxed/simple;
	bh=BhWuoBkwSqw7NsnaFxyyeGWfpXdoxScAEzI75wSxdoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ePInMVCs7kH0oxQlOz4tUlN7uOeq9jvYtJx8ivoeWUdHl83Cbf0R5L5ZAflF6FrHA9a4K8fxu7tqBwLYANT2ZhIQ+hA7h8hygSmA0kGvZbYkmj5caErUjrL1oEgz0WDXdR8E08os3fP60C69mN5Z6j74OT09gskh4uanaO+woRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FEQT7DYo; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-46d25f99d5aso16200325e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 07:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758638730; x=1759243530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nZ1YIkKOG5ZcKxrbiXISvB8CTGBUs6wL4teYcebD1Q4=;
        b=FEQT7DYo2hX02tuLV5h9xVUq8L8/PTrNHeHKOao3zglT9cFp7OdON9cerOzn74Tz4L
         wMkKfzBxmkYGrSF8ZJniLluh2Eex33Tol/Qp1uHHO43oGX2/B+owFsyC/5znuntrSQFI
         Mg1PfoFHNWs+xuWXTNpfxs+s0jqydcU73fR2xxjM8bCwaUc2ouWuSR1YpT/CeA8/Yy5L
         OACGw0kTxn56QbLAA1WhwiK37IIpapXHz75I2jbfndtRksxvu3LdqKxsSqpLDZoybfJ9
         KMA2Vd3YBpfsVIa8VCrHDt2RSkriAEIcl4BGIOUG7J7E9/y+bWrbhmD0Ih6x9vxVBCsA
         MwMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758638730; x=1759243530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nZ1YIkKOG5ZcKxrbiXISvB8CTGBUs6wL4teYcebD1Q4=;
        b=I5wZIVayT0wAUG7iAkEVf9/JM56nZVLz9+GwJxTiptRxujrsFgEDL2wPQG6pg7QFNl
         y6HYBepaGA6yJUSoHjPRSqZx0cy/ViZzre3wBQvm1aszL3o7NbFwR1bwOQ8DwuJqBjdj
         EEuYR1z6W6P11U4QmHvO2oOjJlxLW0UWlC3lZIMxfxn5FZZ0tCWOJFHzFYt1Pt305Ir9
         ydyorPnB/0dKO6Eq3E7CX8yvXy3dHaSL/sPXErinYnkTbyNUPX0SklztNbb6UuIphA6s
         xAyVZgdiO4TPVVnoq+vUNpJBPd6blcoG+WcNOVKxZa1tmAcLlRBWWugFKEZgSIE6R5Q9
         MaLg==
X-Forwarded-Encrypted: i=1; AJvYcCW9/LkKDNvEt8+iCfCAC7XkXgSg/EfG15EvjHZri9hcmBbvqSh4QW2ulFdhII6CXy0NwO8HQNpOF/UXDKc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfcBEa2Zo4qX70uwYR1e2BeK+bRJw01Ip2aJcuZfrF5o+KMLSZ
	LWVFt33LSMkJ7ibtruYAYcKav9jemZN23F/0BA96X3+7BZLrBi3RJ5i5
X-Gm-Gg: ASbGncvrtac/T1GSsjDxhkRiJ6rN4EtsXvkuh5/CtFtyHtxuylSbj8qHAJc5bwnyyrU
	1/19idXdxBZdvf9vQ9/hgvW/5LWdCzg0Zq33nmbucLxQOi0K31xSV21XGPxC/gtzahUNos6+sv7
	2/l5PgAaEQX7jPrS/2SWLw7cAfVf4teIWIzMqau7ACltklFQbagEvg9PoYId5vd1y1q2N3JMSOV
	FLdPEBP2XZoh78Oj792m4DeNcPIVE6Y+x5XuWOQmbcbKV+pvaQdqT0CqDq6k8Pu+yYL/9umIokP
	8DjXcKmDoIk55fUSaW5LYdyxOnIVrHjC0alnyJWIa446ur0urV46ihny+jsK3hoXnZBNejM50Ij
	ES4LUF2y3HSdSUAZ3121HRi3S7PsZBR5dcw2rkQmiIbFXBbysoE3mZCfzAOqHdmlbGI+/ze1JSW
	j3Lw==
X-Google-Smtp-Source: AGHT+IGulPwH5fOVINKa0rDW3oB4wGGljY9HIdmcQhZBQGeWIV8NPJpIlAmFtXu7jcdUNxVdFZrEVQ==
X-Received: by 2002:a05:6000:2203:b0:3ee:11d1:2a1e with SMTP id ffacd0b85a97d-405cb2f1435mr2813593f8f.10.1758638729848;
        Tue, 23 Sep 2025 07:45:29 -0700 (PDT)
Received: from biju.lan (host86-139-30-37.range86-139.btcentralplus.com. [86.139.30.37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f0aac3fdsm238940435e9.1.2025.09.23.07.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 07:45:29 -0700 (PDT)
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
Subject: [PATCH v3 4/8] pwm: rzg2l-gpt: Add calculate_prescale() callback to struct rzg2l_gpt_info
Date: Tue, 23 Sep 2025 15:45:08 +0100
Message-ID: <20250923144524.191892-5-biju.das.jz@bp.renesas.com>
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

RZ/G2L GPT the prescale factors are continuous power of 4 whereas on RZ/G3E
it is power of 2 but discontinuous. Add calculate_prescale() callback to
struct rzg2l_gpt_info for handling this difference.

Reviewed-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v2->v3:
 * No change.
v1->v2:
 * Collected tag.
---
 drivers/pwm/pwm-rzg2l-gpt.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c
index d1baac37c771..0af3aaf1917a 100644
--- a/drivers/pwm/pwm-rzg2l-gpt.c
+++ b/drivers/pwm/pwm-rzg2l-gpt.c
@@ -90,6 +90,7 @@
 #define RZG2L_MAX_TICKS		((u64)U32_MAX * RZG2L_MAX_SCALE_FACTOR)
 
 struct rzg2l_gpt_info {
+	u8 (*calculate_prescale)(u64 period);
 	u32 gtcr_tpcs_mask;
 	u8 prescale_pow_of_two_mult_factor;
 };
@@ -138,8 +139,7 @@ static void rzg2l_gpt_modify(struct rzg2l_gpt_chip *rzg2l_gpt, u32 reg, u32 clr,
 			(rzg2l_gpt_read(rzg2l_gpt, reg) & ~clr) | set);
 }
 
-static u8 rzg2l_gpt_calculate_prescale(struct rzg2l_gpt_chip *rzg2l_gpt,
-				       u64 period_ticks)
+static u8 rzg2l_gpt_calculate_prescale(u64 period_ticks)
 {
 	u32 prescaled_period_ticks;
 	u8 prescale;
@@ -296,7 +296,7 @@ static int rzg2l_gpt_round_waveform_tohw(struct pwm_chip *chip,
 		period_ticks = rzg2l_gpt->period_ticks[ch];
 	}
 
-	wfhw->prescale = rzg2l_gpt_calculate_prescale(rzg2l_gpt, period_ticks);
+	wfhw->prescale = info->calculate_prescale(period_ticks);
 	pv = rzg2l_gpt_calculate_pv_or_dc(info, period_ticks, wfhw->prescale);
 	wfhw->gtpr = pv;
 	if (is_small_second_period)
@@ -498,6 +498,7 @@ static int rzg2l_gpt_probe(struct platform_device *pdev)
 }
 
 static const struct rzg2l_gpt_info rzg2l_data = {
+	.calculate_prescale = rzg2l_gpt_calculate_prescale,
 	.gtcr_tpcs_mask = GENMASK(26, 24),
 	.prescale_pow_of_two_mult_factor = 2,
 };
-- 
2.43.0


