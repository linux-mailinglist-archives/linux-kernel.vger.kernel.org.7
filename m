Return-Path: <linux-kernel+bounces-829157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBE8B966C0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 16:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FECD3B2DE6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 14:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF40263F2D;
	Tue, 23 Sep 2025 14:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AwUF5Wkz"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4684B1E8332
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 14:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758638734; cv=none; b=TflogKhg9wDq7vKEbOHWeZOwhKa/AHds0wE3SWzus16YGnM5eRsDAkdLHB7LKlO1xYpkiOYyZmz8ZCccFOy7HZMinh7B5hiF5Rtzdc1f7HeqN9BNjr0dt3NNCA0b7kt/vulgYq9/kuzynSQ6Gu5ruLPr5Ow3EuxsiKfU7aqeyUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758638734; c=relaxed/simple;
	bh=PzTUGS3rsi6YZUQn0pGItTVR2WZEHdiGxiZsu870EA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UqIZoX52iax0xuvjaQhYCns3yFqntWhAZGj0ij9vxdUGeowYY/SOKx4I0qqm/ybFqhaYPXxcItwdJRjS8ooEMg8dT/r66LEzHfEd/eIheLS2UJvP0I0DREklF1AB6P/EGdeZpsQemdMGZu9c3yVp8y/zbEaa4arB44xAayWeBlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AwUF5Wkz; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-46e1cc6299cso9761895e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 07:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758638729; x=1759243529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4anwDx9v8HakV13d09macXf0BjQ85fB9OQZaHSABwj8=;
        b=AwUF5Wkz6XghTj5KI+h0SCDJbB7WQCUfkUyJIV2XSLgXo/Iu+z/20jfOF6r0zXqsx0
         nl3W1gIXM2QJoJucqRyUplTBxVieVhDQIGv+yCgMoiDePMGustSd9+wK12ORx4jqNe/4
         DDdszVstt3D38054YvKcBhkdCH/RA+EbXhMJoOuANTg6hJs0VAAmm02SV2PRVqkNltEJ
         UOm2jZN3hpq1QtSYYXJrBOHwTRPMOWIVFfWsH6bfpqjTmodsjPSJx8WKM/jhsV7MnYFS
         2nB8Oyr5kXySerFfYLk9o9nSuUiSHDTH6xnOB4Z2hIlfURX/EaVZNTcVKr23pHIFlbda
         vSHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758638729; x=1759243529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4anwDx9v8HakV13d09macXf0BjQ85fB9OQZaHSABwj8=;
        b=Aiab3KW+tqkvQjq88Tp/onQPJnlQ/GZK58uEzK1CtJIpXB0I1hnNmSqhH7TmaVclNt
         CbYXaRcZGjAcJ+OGd+M12EXQjiV/LUOGUICwFDZveQDt5ULaQj+OVvcBftLm3aQD3hbj
         VQsld3MJOKi7Ay7sB1J5lWcoR921S0t2jMjPfzx9eJw4giBLT31x5s0bo4mrZvdI72oX
         nHatQpy3ss6FySr9jVOssSz1otqerlyW7ITeiohTkgWIyCbzBVzKenAxbizsbaRJkcZF
         8iSH3r3rQqGM5dJuHJrlgVjtI5wQhERdBIvj3jQ/Be4Fm+8dkmPh1smokkvmh0crOEky
         oEKw==
X-Forwarded-Encrypted: i=1; AJvYcCWiQLfeYJ01t5yY/DKfLAlJUZiJKFVoaFMiaIhOd496HvVhVQiVMgGUPQCJDGOTVD7UlVWLjFKgLKJJl1M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgrkSzrxkVJMdXosAqoOGJmh1WpnCHt1JK3qX5k7ewd0DLMjHU
	PU+pzZ0vHwNux7J6Tv9NbaSGRZQ/m6KzZlNv2r6FdB2g4QLiGfAcVwUV
X-Gm-Gg: ASbGnctkpYoKEWUU6YY2YzxZTHfG34xHigBTZUrV2G+9XcjAzthesyYYEtppND4nfEK
	cgC+x4ZZwjYH6uBQ43tdEod0DeHSF6EbRWETUzjhHWhfOy6sRB3EjTUcL/tzIN4ZI/P8snCQGk/
	Lz1M40CI1/fN3avVe/qs3uycxj5EonaizrCRuVoHZSg9PVLm7zrOUGjAjHZWX0xKqGgsboQ1tt+
	rzeG6bum4YO4Aqmku751Rl7/3s8ycNs6qSsCTtj9Q2kuIYk4n+AY/iEGRKbZiW6gmTpmr6Lnd4f
	21SvbCvQ2nS4w1ojaTY/Nr0v/eRQQNW0HEFDvzSoDyW5sY9dujub1ZScBQaYSUv0z9TQoEXRcBr
	/KpUf+VxVq8TGZ0Un91ZOGg8CfHgkMce7yvEdFW9QXUP86RQLvGWQp0av2Cl4CPIQHbxNxbch+E
	pQlg==
X-Google-Smtp-Source: AGHT+IEoPP6mKCiiA6RwSLS+InzvMGsDizgIiADIxBNHLgXuqyF6vVEwKBgbDeUyQkGB/UlkMhrHkg==
X-Received: by 2002:a05:600c:3152:b0:45b:7a93:f108 with SMTP id 5b1f17b1804b1-46e1d994a15mr31555955e9.3.1758638729239;
        Tue, 23 Sep 2025 07:45:29 -0700 (PDT)
Received: from biju.lan (host86-139-30-37.range86-139.btcentralplus.com. [86.139.30.37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f0aac3fdsm238940435e9.1.2025.09.23.07.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 07:45:28 -0700 (PDT)
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
Subject: [PATCH v3 3/8] pwm: rzg2l-gpt: Add prescale_pow_of_two_mult_factor variable to struct rzg2l_gpt_info
Date: Tue, 23 Sep 2025 15:45:07 +0100
Message-ID: <20250923144524.191892-4-biju.das.jz@bp.renesas.com>
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

RZ/G3E GPT IP has prescale factor power of 2 where as that of RZ/G2L is 4.
Add prescale_pow_of_two_mult_factor variable to struct rzg2l_gpt_info for
handling this difference.

Reviewed-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v2->v3:
 * No change.
v1->v2:
 * Collected tag.
---
 drivers/pwm/pwm-rzg2l-gpt.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c
index 1d09fb01c72f..d1baac37c771 100644
--- a/drivers/pwm/pwm-rzg2l-gpt.c
+++ b/drivers/pwm/pwm-rzg2l-gpt.c
@@ -91,6 +91,7 @@
 
 struct rzg2l_gpt_info {
 	u32 gtcr_tpcs_mask;
+	u8 prescale_pow_of_two_mult_factor;
 };
 
 struct rzg2l_gpt_chip {
@@ -229,6 +230,7 @@ static void rzg2l_gpt_disable(struct rzg2l_gpt_chip *rzg2l_gpt,
 static u64 rzg2l_gpt_calculate_period_or_duty(struct rzg2l_gpt_chip *rzg2l_gpt,
 					      u32 val, u8 prescale)
 {
+	const struct rzg2l_gpt_info *info = rzg2l_gpt->info;
 	u64 tmp;
 
 	/*
@@ -238,15 +240,18 @@ static u64 rzg2l_gpt_calculate_period_or_duty(struct rzg2l_gpt_chip *rzg2l_gpt,
 	 *     < 2^32 * 2^10 * 2^20
 	 *     = 2^62
 	 */
-	tmp = (u64)val << (2 * prescale);
+	tmp = (u64)val << (info->prescale_pow_of_two_mult_factor * prescale);
 	tmp *= USEC_PER_SEC;
 
 	return DIV64_U64_ROUND_UP(tmp, rzg2l_gpt->rate_khz);
 }
 
-static u32 rzg2l_gpt_calculate_pv_or_dc(u64 period_or_duty_cycle, u8 prescale)
+static u32 rzg2l_gpt_calculate_pv_or_dc(const struct rzg2l_gpt_info *info,
+					u64 period_or_duty_cycle, u8 prescale)
 {
-	return min_t(u64, DIV_ROUND_DOWN_ULL(period_or_duty_cycle, 1 << (2 * prescale)),
+	return min_t(u64,
+		     DIV_ROUND_DOWN_ULL(period_or_duty_cycle,
+					1 << (info->prescale_pow_of_two_mult_factor * prescale)),
 		     U32_MAX);
 }
 
@@ -257,6 +262,7 @@ static int rzg2l_gpt_round_waveform_tohw(struct pwm_chip *chip,
 
 {
 	struct rzg2l_gpt_chip *rzg2l_gpt = to_rzg2l_gpt_chip(chip);
+	const struct rzg2l_gpt_info *info = rzg2l_gpt->info;
 	struct rzg2l_gpt_waveform *wfhw = _wfhw;
 	bool is_small_second_period = false;
 	u8 ch = RZG2L_GET_CH(pwm->hwpwm);
@@ -291,7 +297,7 @@ static int rzg2l_gpt_round_waveform_tohw(struct pwm_chip *chip,
 	}
 
 	wfhw->prescale = rzg2l_gpt_calculate_prescale(rzg2l_gpt, period_ticks);
-	pv = rzg2l_gpt_calculate_pv_or_dc(period_ticks, wfhw->prescale);
+	pv = rzg2l_gpt_calculate_pv_or_dc(info, period_ticks, wfhw->prescale);
 	wfhw->gtpr = pv;
 	if (is_small_second_period)
 		return 1;
@@ -299,7 +305,7 @@ static int rzg2l_gpt_round_waveform_tohw(struct pwm_chip *chip,
 	duty_ticks = mul_u64_u64_div_u64(wf->duty_length_ns, rzg2l_gpt->rate_khz, USEC_PER_SEC);
 	if (duty_ticks > period_ticks)
 		duty_ticks = period_ticks;
-	dc = rzg2l_gpt_calculate_pv_or_dc(duty_ticks, wfhw->prescale);
+	dc = rzg2l_gpt_calculate_pv_or_dc(info, duty_ticks, wfhw->prescale);
 	wfhw->gtccr = dc;
 
 	/*
@@ -493,6 +499,7 @@ static int rzg2l_gpt_probe(struct platform_device *pdev)
 
 static const struct rzg2l_gpt_info rzg2l_data = {
 	.gtcr_tpcs_mask = GENMASK(26, 24),
+	.prescale_pow_of_two_mult_factor = 2,
 };
 
 static const struct of_device_id rzg2l_gpt_of_table[] = {
-- 
2.43.0


