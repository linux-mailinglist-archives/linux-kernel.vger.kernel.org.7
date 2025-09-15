Return-Path: <linux-kernel+bounces-817442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E928BB58238
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 18:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61115201E21
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 16:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4262836B4;
	Mon, 15 Sep 2025 16:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mu/0jxRE"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3763B277028
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 16:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757954204; cv=none; b=ArZeFzZJmtoU4hWYiP+Qc3DJy79pfZNRBfCCph+2ERrU+rSWmuU+hsMIUTgbO9xzLe5XnZTTaslRH4si+scTqMMOhpzmfyZ3Nz1QnF3hWhs5VKJe256d117RoJ5ZGxApX9dDk2s9uEFqmO7UJKTZwjxPbueauDK+ZcsDrGmEIz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757954204; c=relaxed/simple;
	bh=rDWLxp6tmGy89TUxrq+v7glS2m9ke2bHRuQBeHmGTns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pLTM/IrJYM6UK2b4ISvdxxLC4SNgxwvlZ5+ZYG5hNAxXC0NqSwm7o+KOWBPslTkUE6AldAi/ESdRYNoIV+93/IYb2FCYVErfdPgts8H60yjQCZFsc2DJoJ2GPzBDkY46prOtqbYuPGUaxi9IaLQxZy9qY4CKINiSNp0PSrCLYYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mu/0jxRE; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3e9042021faso1380024f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 09:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757954200; x=1758559000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7OJ3rWm1NdBVBDGSPXlmB4CHoSkVBFKI7NjDh4TZsv8=;
        b=mu/0jxRE7SNdVRabpCMVCRH0wq8ZfsJ3qJDGacQ6Iawy4lzClqq/W0BJOFTRkdyfr4
         WHAEaCxkZ/Gc13TkNktOX0pFap9a43kiMuzg9BwAKe4ApWaTNKy0P51pwi6us3njl3DT
         QF5oLdrgiw6JLjakK4XNJhnnCTGninwxOaE4Vz7D+mTzrZtWoYnLYtcXfU7zDJK8w0Mx
         xZGbHn/obFn9YPdYLzRIgchZULj09n/lXD0KUu1i1NklfAx4P9Jv2IGCwSPUAOSpVyfQ
         f0QP3/0DGmPaPs8J8YfF8m4WvBJ9zsdjYAaDTQWOZvEJIk08x6Hx4iLSutvq0ngjSVcd
         VzvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757954200; x=1758559000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7OJ3rWm1NdBVBDGSPXlmB4CHoSkVBFKI7NjDh4TZsv8=;
        b=vQZNJZ+BI3iQ2p+lDkWaixN5R3xzUSaBW6fCIj5af8xlfUVyQQ9EI5Cot/rFiJjDbF
         PCZVh/rnIzSxwGpVC9WW6eQI55fRUAHbNKhGMB722QIgMr/4MC1ajuRZzvRKhhrxlNVi
         08HlEQI3UOF2915e1LvRM8vlKCqt5C0LUmpK7bo4a2mKAQoTHr/w3cQza1q0fVdIcKNM
         tgT7OA3Ck4f4aVN3FcnGxLTwXu4ZhyF0vRe1EvbAhFw6q4JV19K7Z1UGYolBuhPFm8bV
         Vpf06NkAQAomBJMY9wf82yKzoipnB34TiOTwOnShyNrSxzc0AM3UFFXDMdOIKMf8cOov
         pi/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUMbORB6QxMY/QLpq6yYagXob8SFZuEvDHIECroeA2tMjp3eXLbPIByiE1IwlPBJ1f3dmNtP2ypVD4WrFM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPny8Mnslix8u+3twqNJf4gVV86J4ni542r0sxWqiAG3USQpYM
	AYWYuMRJsHIVDNY3rHOcqQ28pdkmuRqek6imo08dgIGO60LXkpv93tCg
X-Gm-Gg: ASbGncsRDRG09PN6TngGd8QhMipTn6IBWSloblN9JTRC7CZbq3u/t5/sueZQ5YPfThn
	11wymlFVtkmDWGAajfSFzGYKghtwaL7zrfFRpgfifwI88DSZYG0zbepQCw2u23HLa55o7TUqHrs
	90MngMdh64HIjfjbNnJgMs8jYrJT5gbQI3D+/61xfz2v/kMZMcChK/8jQz5rc1n8uEBlfo695o0
	9BdMKesnZuZLpkvDLZg0Bszqv3drHRF88GMks33pI0yh87NIaPwsZC8gpNq23XEO3XCtzBhD+Wv
	YeKqTDxLA3NDcJ0PQPhh7TEb7es93xiQ67v9u/o/jhKBb+G1LIjjHYsU3RiDovDWeeFmuViRLwa
	+PYm5SumWP2XSwEyn4Bf9aiPvw/hG3m9y/OppYr/IXwMoJmY2OrqbR8jAuI/fYPqfk1c2hiLN7r
	pX7w==
X-Google-Smtp-Source: AGHT+IED6gF8qcEvOi7QA8TOlT4uJTio9AlnSyt9wukyF4ICcxPu7tcLpX/0qcZhpWhffKIb1KG2SA==
X-Received: by 2002:a05:6000:230b:b0:3d4:2f8c:1d37 with SMTP id ffacd0b85a97d-3e76579656amr13722725f8f.26.1757954200319;
        Mon, 15 Sep 2025 09:36:40 -0700 (PDT)
Received: from biju.lan (host86-139-30-37.range86-139.btcentralplus.com. [86.139.30.37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e8f4d644adsm9521728f8f.52.2025.09.15.09.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 09:36:40 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v3 1/2] pwm: rzg2l-gpt: Reinitialize cache value
Date: Mon, 15 Sep 2025 17:36:30 +0100
Message-ID: <20250915163637.3572-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250915163637.3572-1-biju.das.jz@bp.renesas.com>
References: <20250915163637.3572-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Reinitialize the cache value to 0 during disable().

Fixes: 061f087f5d0b ("pwm: Add support for RZ/G2L GPT")
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v3:
 * New patch.
---
 drivers/pwm/pwm-rzg2l-gpt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c
index 360c8bf3b190..b2452e50d618 100644
--- a/drivers/pwm/pwm-rzg2l-gpt.c
+++ b/drivers/pwm/pwm-rzg2l-gpt.c
@@ -190,8 +190,10 @@ static void rzg2l_gpt_disable(struct rzg2l_gpt_chip *rzg2l_gpt,
 	/* Stop count, Output low on GTIOCx pin when counting stops */
 	rzg2l_gpt->channel_enable_count[ch]--;
 
-	if (!rzg2l_gpt->channel_enable_count[ch])
+	if (!rzg2l_gpt->channel_enable_count[ch]) {
 		rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTCR(ch), RZG2L_GTCR_CST, 0);
+		rzg2l_gpt->period_ticks[ch] = 0;
+	}
 
 	/* Disable pin output */
 	rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTIOR(ch), RZG2L_GTIOR_OxE(sub_ch), 0);
-- 
2.43.0


