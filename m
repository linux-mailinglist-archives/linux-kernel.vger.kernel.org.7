Return-Path: <linux-kernel+bounces-793479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 824FCB3D417
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 17:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CCF7177B04
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 15:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6BB26E6E3;
	Sun, 31 Aug 2025 15:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nn3FK+LW"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF22525A631
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 15:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756653255; cv=none; b=aqyQ4YyBlM6QYOECSWkUYw1SIFlCNlrZaI+D+xIJoZS3NGACx9kA6zW5uqJkXZmzGfujByyFfK3Xmcvx+Af+B85yoaPiUmgIM463hsPBD3hUJPL6Fodu849ZZsLm69VrZG2NnLOKAXOcanuBnsf+VIjExlEdBJezf+5YnntUAn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756653255; c=relaxed/simple;
	bh=DGJyra+rwgJAphZIeTb6FsB1qNLlyBd7vZfq76WHVp8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qkUsIQ57VKXejTA6vxV/SZJCW5DuAkZv4DVJIrGoaA96KrXua5Fg2IcC8qaC43WcXJh4olJ0CG3VJJO48tV5T8IEx2Ary7lzenthHFZc8mnU3olwQ5jD4mnFwGoDmC4k9a3oE4reccPJXzB7C9VLTbTJ/qIiat89t+8wbtZSLE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Nn3FK+LW; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b0413cda0dbso15409966b.1
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 08:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756653251; x=1757258051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C5B22inhBsHQPQ7rSsv0dytfBGuA96Htpzu5sxp54L8=;
        b=Nn3FK+LW0t80ADXbkttn7niF3XoHFsfFPo9Uc/oUl395QO4nMaTYInRfE5I+/MHGwK
         /DYEo6994c2ugw6yQ6Ozo4P9GPYmDnAxIycBDVfPF0Le1bR7GzLPdDCsRSCrJY4mGo9e
         PCNSqRo/H9N1G4OYeK21jpaXWE4yZNCaNAT4tQ4umuZoVJnU9fCyJHyqN+q7ONuijJVK
         pWBfRmHxl0qwFJvn/oHmBx8eGzjF6ApEGvlg2Koiq9VnJNYLyCNp6QiGaiE9X2erU92b
         MYYVFzo3pJLbo03HiEbmLfRdK3GmH+vYYhziqOkqNsY/G21c/Y1UuLFVhcsCm0ZAUWlg
         uyGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756653251; x=1757258051;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C5B22inhBsHQPQ7rSsv0dytfBGuA96Htpzu5sxp54L8=;
        b=K1BxUW9CeMfoPNYwfZ7qSio5m5SiQZP9SN7yXxlnu4KubtnAPCdFhsByF6R30+QFGa
         KYIyPnHbITp+VjC6EPS4DUvwfri6TCMpU5NdfFfufg6fLwVCVLTFn4C8GIW+kFjth6K9
         s4CHu6u0eRKZ42Er2ObybEufG+dcyExTyEHn2Hqby8ATT6iqbXfJ6xJpoRXuBvxNA/kB
         C2cTAAi29W592KY29+yL14B3qovwJZ6sDfCYycj4ee6BkiXeOL/42zNYNOSWajyYzf1b
         ne/dwyJVSP7z/HQzAfsgaJAzs7szBbgq+Kym5ApF22GnGxVK3iJGfK1IICpBclO+A2Ct
         6l0A==
X-Forwarded-Encrypted: i=1; AJvYcCXk0XXxb6lNtdTfvTHstdLN63Y35MqYCAbmm7Os/YgIZvc/vDz2+Q2uKRWbQQ64KyCpb5+OEvDxtUkhiXk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlPdMJhA2JCJTdl/SXWrQSWFYIMitkLzfBuv3+Hee6KkkknxbQ
	Yu3IKyoSIInR3M6htn9wHY4C66LDqjFHirWU24ZHIL4hQjgrWRjTabUoL528Lb0TXRo=
X-Gm-Gg: ASbGnctv8d7PgcO4gevtG07SqF0PUVVheBJVep1Eg0MK0pm/i3KzJDFtj4Wgnu3dgbW
	i2qoGKddurRTIL6m/Qvu4ySAnR30PfxcERezxfvoMl+vE++tf8LwTMgJjNxUUmcGsLZ9gifCHTM
	YrNvV0mTqhpBPZxkMqfsqwRa2bq+qsuqEJnBStsFVN6r4K/4Nk9uSDw2wwbHnyoNxef58y36DWO
	lxXjcbD/G1MFCNzbX/HwbN6pMAiURRtTo3NtTG6+ZJRAVszu/KkieJzgIzO8mx+51IXbwNxITk6
	5tjS8+9mH/62qk72oXMbg3z9jfTEdi9dAiRVL6jeOvbpchp6auf4B6t9GS/kU+ol6SNcSZVuSvP
	51PeKAnq1zLWPO78u9TIK+oJBg2cOzmSv5Q==
X-Google-Smtp-Source: AGHT+IGYNSQVqee984CDJ+qU/cYBl5yGpRS0pEsogwANun04auLoq11OzPQ8DtrTICXP4aURf50JCw==
X-Received: by 2002:a05:6402:13d1:b0:61c:d24d:e2fa with SMTP id 4fb4d7f45d1cf-61cfe7eb745mr4818387a12.2.1756653250965;
        Sun, 31 Aug 2025 08:14:10 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc5306e6sm5345361a12.47.2025.08.31.08.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 08:14:09 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Srinivas Kandagatla <srini@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-sound@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alexey Klimov <alexey.klimov@linaro.org>
Subject: [PATCH] ASoC: codecs: lpass-wsa-macro: Fix speaker quality distortion
Date: Sun, 31 Aug 2025 17:14:02 +0200
Message-ID: <20250831151401.30897-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3285; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=DGJyra+rwgJAphZIeTb6FsB1qNLlyBd7vZfq76WHVp8=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBotGa5TMRfOjWazCtrTvyznajNWZMNJZ9mRXGNk
 7G54joliqiJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaLRmuQAKCRDBN2bmhouD
 181LD/9uEBEG/Ygk8wzpQieaPDZqEiuUDRuaegIE9lIa10NkNgHeqQzj130FzD6iKrpu6re7a1H
 VvpsJKQRl4WurWeou12C27HM77g6juxbdYWBR391W1NDlXKCsXriG4VOdxmgvPIv9N259gZ44dT
 aecIK1qgnPVVYDlZlVrpGBZ0XPZT+A9Zyf9a95BRDBWh88OIu4qBlCkR0k38OO4kV0/vFyYuygx
 BfB4hXeDrwGwb5IybkQCIGU61xaysjdRjaz3vdSyopMi7Q2WW4uhVST5pco4aW1B2KpUmk3uCGW
 UPLZE10HBUoXd+LrvcCJuNgqrJ2Ls6+ardjnyHV1Qt7X5gFEKefu95WDYEMR3mejNrHAIKdOQ+C
 7lTea2lxG2Yv53SA+iBsBUxqiGaArcyCelLhhZTwi/P5HrV74TjuxB5dvp8DHE0z+NZfEwxzQRb
 +lrzZ1CwzVDXJE1L89slqj7j6VaXfuD785KHSc1OGg9u2LjhdK4AKU1CQqSFi0LymonNUbOmOC3
 EeZ2py1NPqJqE7yUUOZifv2hQujFLZTJStFdznkWa7CbwiuY5lYF0EFZc+hjRdZ2a9iAUHiL/Zc
 421g5tW6MF3j4jfdnhgngH6lJ5nF66tM8NfSEj2zH1zYi2SyTXT96pD5zIC1gQqXg97dEzGN5Jf boPUPr+N8hTnioQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

Commit bb4a0f497bc1 ("ASoC: codecs: lpass: Drop unused
AIF_INVALID first DAI identifier") removed first entry in enum with DAI
identifiers, because it looked unused.  Turns out that there is a
relation between DAI ID and "WSA RX0 Mux"-like kcontrols (which use
"rx_mux_text" array).  That "rx_mux_text" array used first three entries
of DAI IDs enum, with value '0' being invalid.

The value passed tp "WSA RX0 Mux"-like kcontrols was used as DAI ID and
set to configure active channel count and mask, which are arrays indexed
by DAI ID.

After removal of first AIF_INVALID DAI identifier, this kcontrol was
updating wrong entries in active channel count and mask arrays which was
visible in reduced quality (distortions) during speaker playback on
several boards like Lenovo T14s laptop and Qualcomm SM8550-based boards.

Reported-by: Alexey Klimov <alexey.klimov@linaro.org>
Fixes: bb4a0f497bc1 ("ASoC: codecs: lpass: Drop unused AIF_INVALID first DAI identifier")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Reported via IRC.
Fix for current v6.17-RC cycle.

I will be investigating rest of lpass macro codecs a bit later.
---
 sound/soc/codecs/lpass-wsa-macro.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/lpass-wsa-macro.c b/sound/soc/codecs/lpass-wsa-macro.c
index da6adb3de21d..d7eec9fdaf9c 100644
--- a/sound/soc/codecs/lpass-wsa-macro.c
+++ b/sound/soc/codecs/lpass-wsa-macro.c
@@ -368,6 +368,7 @@ static struct interp_sample_rate int_mix_sample_rate_val[] = {
 	{192000, 0x6},	/* 192K */
 };
 
+/* Matches also rx_mux_text */
 enum {
 	WSA_MACRO_AIF1_PB,
 	WSA_MACRO_AIF_MIX1_PB,
@@ -465,6 +466,7 @@ static const char *const rx_mix_ec_text[] = {
 	"ZERO", "RX_MIX_TX0", "RX_MIX_TX1"
 };
 
+/* Order must match WSA_MACRO_MAX_DAIS enum (offset by 1) */
 static const char *const rx_mux_text[] = {
 	"ZERO", "AIF1_PB", "AIF_MIX1_PB"
 };
@@ -2207,6 +2209,7 @@ static int wsa_macro_rx_mux_put(struct snd_kcontrol *kcontrol,
 	u32 rx_port_value = ucontrol->value.integer.value[0];
 	u32 bit_input;
 	u32 aif_rst;
+	unsigned int dai_id;
 	struct wsa_macro *wsa = snd_soc_component_get_drvdata(component);
 
 	aif_rst = wsa->rx_port_value[widget->shift];
@@ -2224,17 +2227,22 @@ static int wsa_macro_rx_mux_put(struct snd_kcontrol *kcontrol,
 
 	switch (rx_port_value) {
 	case 0:
-		if (wsa->active_ch_cnt[aif_rst]) {
-			clear_bit(bit_input,
-				  &wsa->active_ch_mask[aif_rst]);
-			wsa->active_ch_cnt[aif_rst]--;
+		/*
+		 * active_ch_cnt and active_ch_mask use DAI IDs (WSA_MACRO_MAX_DAIS).
+		 * active_ch_cnt == 0 was tested in if() above.
+		 */
+		dai_id = aif_rst - 1;
+		if (wsa->active_ch_cnt[dai_id]) {
+			clear_bit(bit_input, &wsa->active_ch_mask[dai_id]);
+			wsa->active_ch_cnt[dai_id]--;
 		}
 		break;
 	case 1:
 	case 2:
-		set_bit(bit_input,
-			&wsa->active_ch_mask[rx_port_value]);
-		wsa->active_ch_cnt[rx_port_value]++;
+		/* active_ch_cnt and active_ch_mask use DAI IDs (WSA_MACRO_MAX_DAIS). */
+		dai_id = rx_port_value - 1;
+		set_bit(bit_input, &wsa->active_ch_mask[dai_id]);
+		wsa->active_ch_cnt[dai_id]++;
 		break;
 	default:
 		dev_err(component->dev,
-- 
2.48.1


