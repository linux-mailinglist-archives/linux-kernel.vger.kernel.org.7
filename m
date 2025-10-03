Return-Path: <linux-kernel+bounces-841146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3AABB6598
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 11:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70BCA19C6A1B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 09:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 652D617A2EA;
	Fri,  3 Oct 2025 09:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H9m6ytHA"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F83C2C2364
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 09:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759482808; cv=none; b=M8/bTvaXztie52r2GsKAt1rMLyYaNiFXLcPkiCmSOtzJS/2bL3vnm7/EFGGp+mo0ItqPlv5MdWNi3N3NQlsS4m3HW+eCV2j+wpFRCCBlDxtiZunzVUW9vKhe/Z7QMRPOKDFsiLgX1ZxkCDLqy6mGj+Uc1UT7PD9+z7cTDk4BFC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759482808; c=relaxed/simple;
	bh=BQ6TpPNckvkGMLa8nCgEZ4uvHpMY2rXRo9al5sRYSZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IEFt+cKdV9RRk1Q4iHldv6NyDWICfcLx2MwUqXRq/a71ypSv3B5JTrOBlX7BtE4NXi0+xRMN9i2kUu2PXP4GFyzn0Hsgx7Py5vd8vLLrjXUQL0Xch76MeQfk3wTIm/3EkCUfvbnz754TSDGlUBlaPU3/z7oOTC9NmsmTQPDQhjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H9m6ytHA; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-28e7cd6dbc0so24313635ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 02:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759482806; x=1760087606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x3w4aXsrWjnUKMZk9fA+/Y2yLLmb0WxYC/X8uHWERpA=;
        b=H9m6ytHAkBbT9UF8YNCrhs+qRQsrDoFyjlWEUPZDk8GqNkCx3Ys75/PUdmBxhHg3Aj
         EwRwi1UJnOPSWPgge8QNzXKtcqvpRO5sRb3E3EKuN8LeGeKNzFfVzbPFDmcAUANPUIXA
         mCEtzi2JsRfkN++wKrlCfP7fboN3/mrZYGFYW51sPFPg69VifksBwvuuPC/hR3XGbcNW
         hUV6xjNlRsxoLUh2+isgVQeMrRHxBflNWQREvHtBFVFApeBmJYwDJvfPUaPUt9IRX69S
         bGmF/xxu58BSGdpa3zLFpD4NLQU1Wp4jysIBFGppmS7HNFDKKscMj6RnFhf/Kz9fp4W5
         GLmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759482806; x=1760087606;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x3w4aXsrWjnUKMZk9fA+/Y2yLLmb0WxYC/X8uHWERpA=;
        b=kef7hVAXCobQNuqZqMG6yJfFbTJHzyqBGRmeKwFirR0rlBMlDzvtICQ7rQlR7HgjM1
         0ajDCqAQoIaUV9idagHGbgtsnlmc5aE/cGwBF7aW42fdK8nGPZTzRxLDys+3b/h/VByS
         xhipE2CxfImrmn31FccpZclafrrPAckNXj2vvl1+wLJd/xHvNr6hvc3/YYFSLGiIjyWI
         FFoxzV5avDIHcpowx39bXHYTVec4op1t2MmP5l0cPgadBwOurKBMa7vhKJbyK1kycP+1
         QZ/JHroR0srskTdk/SoiF/TEVSW2mVF4fhqnTc+1vOTStdQfX3wXzbk31KyN5wWeTZEp
         pWgw==
X-Forwarded-Encrypted: i=1; AJvYcCUPVmm0B6FRnjFimsj3G2QCwDNJAQ0FP2uB1/NKhtRWeicg8jimqfZGImahYDJxkCGtXN+uwEk4tpSD2Eo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYBk5PkvtYkNAdL9bGSb+Ld2mums7VSYimq/ZTQrqn2NOOdGU9
	Ci7G2dOjTfk80+npRaA+qBsbIcDNZLxur/uYaNWqnTYSUoVQptLYlBY6
X-Gm-Gg: ASbGnctpHvUR7SSWZeY1ZVeQ+1M5OPXBJ4RfOq/u9gFIqLXlmBvbkwfEp9omnfOPVDy
	Mp90vMYDvrgTYT0nWwRX6q4TfUnjwFK5CZUkfp/NofHFmGEYzGIvx50fHhNaifUpPjTf9rlLPm/
	lgv+Am6ufNTyvYO3jibGbdgPUxoSQoj1ep4MEF56EqJuNQOj+AjzUg+2offA1aDfTTKsEgOkcow
	CNOLepl0r+dnyzR4j/9Iy5cGPUPPYgXs32eZjt3QeZ4hWQ6gKdQIhfewye2nAgjKBW1K8MAFnHO
	/MOkdthqpA0pALYxuuK4g3DkLopanSjyIjRcmMY93imwj6899xzTUjLlM3pXd9WEc+KwmQ486MC
	u0SJ4pjxhPUzhEYRKymc4vr/Uz3voXKB3CDLmFBd/+E6+P6araMqEr6kIk8c7y4UU7a1DhE89gQ
	8MQNY89Lk=
X-Google-Smtp-Source: AGHT+IGzKg6G62U1gFspKEbZb17bhknIhb1hepfY455zfW67yrMA+EkURag9iWvfAxy4fhg+YyajaA==
X-Received: by 2002:a17:903:11ce:b0:269:6052:3536 with SMTP id d9443c01a7336-28e9a67bf21mr29079145ad.45.1759482806263;
        Fri, 03 Oct 2025 02:13:26 -0700 (PDT)
Received: from localhost.localdomain ([185.213.82.42])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1d5674sm44210095ad.99.2025.10.03.02.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 02:13:25 -0700 (PDT)
From: Brian Sune <briansune@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sound/soc/codecs/wm8978: add missing BCLK divider setup
Date: Fri,  3 Oct 2025 17:13:04 +0800
Message-ID: <20251003091304.3686-1-briansune@gmail.com>
X-Mailer: git-send-email 2.47.1.windows.1
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


