Return-Path: <linux-kernel+bounces-845752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67102BC6055
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 18:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9105F3AE3A5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 16:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F95729E0E5;
	Wed,  8 Oct 2025 16:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zvwg+TRT"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4A229D27A
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 16:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759940858; cv=none; b=DbIXsWJPTPs3F2XZQHB34ckiybVV0iGDu/Mf17LBJgNGErIPKLIhtfHwF/6d/I+2gpw2XAxfpri0s5kaujG6uGnOZ5Y2+ekPHEvucYtqoJv6A6p8oj+mLfiOorNvn4PlLKRV/2NU62NjtPulH0vIQLwTzWs+VsWpjp4k/UH9SkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759940858; c=relaxed/simple;
	bh=3OXuR6x1cne1LuLPDoL64UARuq73uPDb6J+/mL6/TYM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZLPQu23ChMu5ge/H7Da+hgcaPqny6K2k+YzU3TU1Lx23TjWh+39x5W3kCQnWydGCM4E5/wfy7Q+hTrzhT18yywL9EosXgII/64flYfYwe2pV66LC9tAxFsBwp5nreLA8mmCCJRfoEwKKCJtHkbv4Tk7eiT/RK8uwXQFbtGEOMm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zvwg+TRT; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7800ff158d5so6544812b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 09:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759940856; x=1760545656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NdFhkBR1PcRYFVfhAlZWxz9why5n4pV8oLNBu5zdtXY=;
        b=Zvwg+TRT4yP7J81L4jH2JjGfsfJjBM0qAheYVuN9oqi1ARazaVzLhpsF2OlaXAUM8M
         hshcdyfkYOdXXeb8TVkcS4GSVviIJ1EcGgzGFKHxAbem5s57+XZLew+vQ1F4EijbcCmU
         N0+SN9qbux1TsnQVHCgQ+dS3u1ztFhHFpiRZYkyxluzsOfKvuX7/N4BbL+nNWoWfhh5n
         7XQxQek21LCT+O95fGLXHAQWGm8cJ06GpbKd7txolrhKEJUVFUOG7AxxBBtOiH32nJOk
         gzu3+Z9XEDdNGsT5J4i+HVdIbxj5kEkR74Wyl6xcQmIGCCmHut56RVQuwOuKC77ipOaO
         arxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759940856; x=1760545656;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NdFhkBR1PcRYFVfhAlZWxz9why5n4pV8oLNBu5zdtXY=;
        b=ZuWdZ0u0uFUiOr13/lRNLRbqVKwcKGsgkKBPq+O4QDNiCwbgQeblNkdskHUf5UuYkF
         OHCeXEGc/Q8ddK3bncOXx8c5qozBHNE6gtz+Ift+wmBYvUswk30nEvU439aZlFQmeTCL
         XnwhsQxwx6vF1kdl9w3Rs6S2C68e+8ETQdQzKCOVKAm49W08pU3MljcudqsRUIT5zhWf
         hF7rF6cKo3yWYmfdE3Xwkvq2X6DjhK/qgAEG2OnjQ5CkGhBXLyDp1X1Fhrl/CfPLTr25
         nBJuSVmpVRTSzb4Am0VB9NO1VCfnoQ8PQpuRFEqFnJHgw7dPCeVu7Dsnv+Bi1J9/R7Kb
         x6vw==
X-Forwarded-Encrypted: i=1; AJvYcCXxbqy7BoTYDJsNxtIaZ4PB82uwY8yCEQKtA2gzUkRf/+5kVC5HML4QJ4VGzZG5cuxTSohmReHHhqBPwKc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5B4HTUrSEldi3IwtFV/kGnl8qEmWNLItCY+hcfyDxuJVOJQAN
	GlIQ+ojOM+3pRkgAJO7m0R0vQBnwJrE3pYappEjN5WTVwigFMFVPijwM
X-Gm-Gg: ASbGncuwk1AfBHAke1VmZt6GPBKzhGObXibu7oAPG9CNVlFqXnTvF7BqnZokSPlACKR
	xDdm3bbjqvdLJzT6jaICtKSWnxc/k5j0gSVRa524igY+bakusXEv4Qo0P6vgdaMz7k47tXX8Exu
	377ofvbZ17x9Mhpe2rCklKtX58rA4NntudhUJiqPPPZNrk1jZlC8IY7TfWGEt/v51q0GI0nsUWG
	tq6rvAERGn933M+dFlFvjzCdASOE4Fl885JpmOsIh5RSlCkfAmpSbKX4ksZJg/99A4EndEQ+vvH
	l4aSAgKIZx9bnbMU022g7/o+qOZUPgOfVVYnpqkK64xO5bXrmJm1lFCpyK8ElkpvR2Qx9wceboO
	t1nUc1JrujuGCsodafUntR51a28WJS8hU+pdljJBpSWsmt0Fxhnl4Dyoo7hrAtDlKFd1Woe6i
X-Google-Smtp-Source: AGHT+IGIDMHJS9uSnRI5d6+ZuW+SpcTwXd+6qoqDjXwMnJYilH2VooX7wIw5WlvG0u0iIPvrIEtOFQ==
X-Received: by 2002:a05:6a20:958f:b0:32b:83ae:e9ac with SMTP id adf61e73a8af0-32da80db4cbmr5236589637.12.1759940856013;
        Wed, 08 Oct 2025 09:27:36 -0700 (PDT)
Received: from localhost.localdomain ([185.213.82.31])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6099f3b9c6sm18538746a12.23.2025.10.08.09.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 09:27:35 -0700 (PDT)
From: Brian Sune <briansune@gmail.com>
To: Charles Keepax <ckeepax@opensource.cirrus.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5] ASoC: wm8978: add missing BCLK divider setup
Date: Thu,  9 Oct 2025 00:27:19 +0800
Message-ID: <20251008162719.1829-1-briansune@gmail.com>
X-Mailer: git-send-email 2.47.1.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In previous WM8978 codec driver versions, wm8978_set_dai_clkdiv
might not have been called for BCLK, leaving the bit clock
divider unconfigured. This could cause incorrect or unstable audio
clocks depending on sample rate and word length.

This patch adds a check in wm8978_hw_params: if the BCLK divider
has not been set via wm8978_set_dai_clkdiv, it is dynamically
calculated and configured at runtime.
This ensures that BCLK is always correctly set, whether the
machine driver configures it explicitly or not.

Apart from this core patch, due to request from Mark Brown and
Charles Keepax. Overclock BCLK setup is applied, and dropped the
possible lowest error BCLK result. On top of the overclocking,
warning message is given to user as a reminding.
This patch author do not agree with this design nor
concept from first place!

Signed-off-by: Brian Sune <briansune@gmail.com>
---
 sound/soc/codecs/wm8978.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/sound/soc/codecs/wm8978.c b/sound/soc/codecs/wm8978.c
index 8c45ba6fc4c3..73ceca9782ae 100644
--- a/sound/soc/codecs/wm8978.c
+++ b/sound/soc/codecs/wm8978.c
@@ -99,6 +99,7 @@ struct wm8978_priv {
 	unsigned int f_mclk;
 	unsigned int f_256fs;
 	unsigned int f_opclk;
+	bool bclk_set;
 	int mclk_idx;
 	enum wm8978_sysclk_src sysclk;
 };
@@ -590,6 +591,7 @@ static int wm8978_set_dai_clkdiv(struct snd_soc_dai *codec_dai,
 	case WM8978_BCLKDIV:
 		if (div & ~0x1c)
 			return -EINVAL;
+		wm8978->bclk_set = true;
 		snd_soc_component_update_bits(component, WM8978_CLOCKING, 0x1c, div);
 		break;
 	default:
@@ -717,6 +719,11 @@ static int wm8978_hw_params(struct snd_pcm_substream *substream,
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
@@ -820,6 +827,32 @@ static int wm8978_hw_params(struct snd_pcm_substream *substream,
 	/* MCLK divisor mask = 0xe0 */
 	snd_soc_component_update_bits(component, WM8978_CLOCKING, 0xe0, best << 5);
 
+	if (!wm8978->bclk_set) {
+		for (i = 0; i < ARRAY_SIZE(bclk_divs); i++) {
+			bclk = wm8978->f_256fs / bclk_divs[i];
+
+			if (bclk < target_bclk) {
+				if (min_diff != 0)
+					dev_warn(component->dev,
+						 "Auto BCLK cannot fit, BCLK using: #%u\n",
+						 wm8978->f_256fs / bclk_divs[bclkdiv]);
+				break;
+			}
+
+			if (abs(bclk - target_bclk) < min_diff) {
+				min_diff = abs(bclk - target_bclk);
+				bclkdiv = i;
+			}
+		}
+
+		dev_dbg(component->dev, "%s: fs=%u width=%u -> target BCLK=%u, using div #%u\n",
+			__func__, params_rate(params), params_width(params), target_bclk,
+			bclk_divs[bclkdiv]);
+
+		/* BCLKDIV divisor mask = 0x1c */
+		snd_soc_component_update_bits(component, WM8978_CLOCKING, 0x1c, bclkdiv << 2);
+	}
+
 	snd_soc_component_write(component, WM8978_AUDIO_INTERFACE, iface_ctl);
 	snd_soc_component_write(component, WM8978_ADDITIONAL_CONTROL, add_ctl);
 
-- 
2.47.1.windows.1


