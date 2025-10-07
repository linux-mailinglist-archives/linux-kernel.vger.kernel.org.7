Return-Path: <linux-kernel+bounces-844174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD53BC1393
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 13:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A59E18947D0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 11:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36BB2D8789;
	Tue,  7 Oct 2025 11:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OAX1jHpK"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E559B19E7F9
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 11:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759836804; cv=none; b=SpMLqXXmUxAm5A1H5oBxA5o4H+2HHSOYWcGglDusS5anE5YPn0xd4DUbBErUL6V+DLQkEd9AF8q/ze3UAbtzR3TbrBiFe4cAsjINePS/2OrYhM4l1WR5dmAU3KiOOPc4z6/Kn+tSf2fyAwphuL0muUqPYyi0qvAmEpWa2o/x9jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759836804; c=relaxed/simple;
	bh=BQ6TpPNckvkGMLa8nCgEZ4uvHpMY2rXRo9al5sRYSZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EMBc0EFEzRBk3NUf3Ss/11iU5ge8px7gzco/gjbo7yy1GnhmxrAmC/NDTEJ2KoEK/+4yXgCTvmDzUmLZv3biKp9Uw0q99nsn0ulEUEaEEn/Ki7SxZHHZua2wqIepZtnoKuPoSIjHT20wuE2H4bv8ro3x7R/icNxyTOTtaA1E/YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OAX1jHpK; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3306d3ab2e4so7227697a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 04:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759836802; x=1760441602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x3w4aXsrWjnUKMZk9fA+/Y2yLLmb0WxYC/X8uHWERpA=;
        b=OAX1jHpKRJtWyhez2a7SDUMwu2IA+ag7Ico2bq3v0rMbKvVFDZbLIzTcFKRwIjz5+y
         Mglx201O6LVA54WpXzCIi+GgTJQ0ov46GNTrOGBzzB3pFOjf5rafDYZgRtL0CtyDMpLH
         zY/GjD93yfLr5wU75SJJpKbIc9eqJlFRVpNS+VboI5wHrV+L3+53yoHt2DDlC7Xa1JF+
         BGuf1jxBES3SSb39q29Dkd6Am/eAmQNA/gkWy/gNIZHNU6luQYtf6J5q7fDyI9vqubCB
         JjcRfEkFNo7XoseAfFu/Gtey+VNHrAUh4g3v+2PD9C7bA2YhOAR9uFkri/eYwxvxSy9F
         YXoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759836802; x=1760441602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x3w4aXsrWjnUKMZk9fA+/Y2yLLmb0WxYC/X8uHWERpA=;
        b=FOf+GtppGj6js1zcaMigtt/sq35vT4Fxyg9cxit+9ZLLnyKo4tE7s4GScKT+Ia8GEX
         sY79lvB3jYfsUCt3Ecrn/+vET5YZyyS8Hd7lYKTmq1otYtcpxZ/2i9z0UlyIaaMpbFa5
         oyoguX2qLDOAOmktHZ+kRtaX49VFXD8pqklsk+HItuUR0W2qb32eFBBdNovrq9uVJ+jm
         2TMyaqzMs7+qJB1h7fQLstKKuBr68sapwd/xddYFBW7CGZxGDEzwkW/3bb/WUpRM7Ni5
         6GjRKqRnCwYxmYFElX90b2FQhEgWr0WuRd2wG2ScIry7HeM/8kiSqktT5O3LXO7KAgt7
         b+MQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyKbLc73znt9Ui7YlnMgJ/NBxbvaOGSSTu8cNy/lOJWlkXRGAb6KzcHSm0OjP2d3DWIGsMuo4mOWzW69g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcKB6JnL5J6+Hs5GI0Hu+aCk9IK6PA781rGJHarD8R3mdm7Shn
	Eddn1on434o7q9iwXTcEaCdSfDWj9tGsLLc5cqlPRsFZoFT6v/qlEogd
X-Gm-Gg: ASbGnctvk5LTaj/cgfmukGjSJHoHelWesSGVisTsp42TfG5cE9J9Ppr69ruSzX4r+lp
	1TkUJh4ksc56WwnH2xDb06w98JDTOTAU0wkRECib8dVK681WpOnD5CfbReqn1PjVmlAtLlW+x45
	u5XUxqctXn05D6SMPVAs836SZoQyDd1TfKF6t9Z1FX+WSvJghfLIQ34CjMccxz4fXcZI4Pbm+hX
	cHanltUSMLApqEVuYxQYzxqv65EC90ui8epM7VqPXhSEhKY/scTO52/ZP1UpzEkA6PkNcxEBDza
	+4liGgZQHFf3AKZRwYzW2CFvorCo020eL32MYhgrRrQSf2gCMmPI7IHLZFeVTIPmUngTujEijKE
	3Pxoe3Zk5VbGvUA3wSZnKEXL5gV3I+ZXIGCNIeo6ULprVcRY5quVdeXUz4LUqa+oBI7hdgbQx
X-Google-Smtp-Source: AGHT+IE+UL1cP6d0S3MAkIVPTU/P8U3/4fJmyYEMKvYq9EHReB2W/wuHXQ/5+2e2rXcosyIhmY5g/w==
X-Received: by 2002:a17:90b:38c6:b0:32e:936f:ad7 with SMTP id 98e67ed59e1d1-339c27aeeeemr17456767a91.27.1759836801861;
        Tue, 07 Oct 2025 04:33:21 -0700 (PDT)
Received: from localhost.localdomain ([185.213.82.31])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339c4a32212sm14086209a91.14.2025.10.07.04.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 04:33:21 -0700 (PDT)
From: Brian Sune <briansune@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] ASoC: wm8978: add missing BCLK divider setup
Date: Tue,  7 Oct 2025 19:33:05 +0800
Message-ID: <20251007113305.1337-1-briansune@gmail.com>
X-Mailer: git-send-email 2.47.1.windows.1
In-Reply-To: <20251003091304.3686-1-briansune@gmail.com>
References: <20251003091304.3686-1-briansune@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The original WM8978 codec driver did not set the BCLK (bit clock)
divider, which can cause audio clocks to be incorrect or unstable
depending on the sample rate and word length.

This patch adds proper calculation and configuration of the BCLK
divider based on the sample rate and word width, ensuring the
codec generates the correct bit clock for all supported rates.

Signed-off-by: Brian Sune <briansune@gmail.com>
---
 sound/soc/codecs/wm8978.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/sound/soc/codecs/wm8978.c b/sound/soc/codecs/wm8978.c
index 8c45ba6fc4c3..2109c84f33df 100644
--- a/sound/soc/codecs/wm8978.c
+++ b/sound/soc/codecs/wm8978.c
@@ -717,6 +717,11 @@ static int wm8978_hw_params(struct snd_pcm_substream *substream,
 			    struct snd_pcm_hw_params *params,
 			    struct snd_soc_dai *dai)
 {
+	unsigned int bclk, bclkdiv = 0, min_diff = UINT_MAX;
+	unsigned int target_bclk = params_rate(params) * params_width(params) * 2;
+	/* WM8978 supports divisors */
+	static const int bclk_divs[] = {1, 2, 4, 8, 16, 32};
+
 	struct snd_soc_component *component = dai->component;
 	struct wm8978_priv *wm8978 = snd_soc_component_get_drvdata(component);
 	/* Word length mask = 0x60 */
@@ -820,6 +825,21 @@ static int wm8978_hw_params(struct snd_pcm_substream *substream,
 	/* MCLK divisor mask = 0xe0 */
 	snd_soc_component_update_bits(component, WM8978_CLOCKING, 0xe0, best << 5);
 
+	for (i = 0; i < ARRAY_SIZE(bclk_divs); i++) {
+		bclk = wm8978->f_256fs / bclk_divs[i];
+		if (abs(bclk - target_bclk) < min_diff) {
+			min_diff = abs(bclk - target_bclk);
+			bclkdiv = i;
+		}
+	}
+
+	dev_dbg(component->dev, "%s: fs=%u width=%u -> target BCLK=%u, using div #%u\n",
+		__func__, params_rate(params), params_width(params), target_bclk,
+		bclk_divs[bclkdiv]);
+
+	/* BCLKDIV divisor mask = 0x1c */
+	snd_soc_component_update_bits(component, WM8978_CLOCKING, 0x1c, bclkdiv << 2);
+
 	snd_soc_component_write(component, WM8978_AUDIO_INTERFACE, iface_ctl);
 	snd_soc_component_write(component, WM8978_ADDITIONAL_CONTROL, add_ctl);
 
-- 
2.47.1.windows.1


