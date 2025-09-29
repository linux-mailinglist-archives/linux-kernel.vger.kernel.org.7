Return-Path: <linux-kernel+bounces-835629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 944B3BA7A39
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 02:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5552F3B1C30
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 00:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3AA2157487;
	Mon, 29 Sep 2025 00:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fE45z1bn"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA803A8F7
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 00:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759106799; cv=none; b=HdOLxC43XLMkKKv6JhKHq4YlpxBzRA9EC76liyF78XhD48g9CFSYFbGz5sjxah5OneKe++rm/UTDJWBfMcbnnxchBKeiu8Yp5fce5rfCMdtqDe84PcWJwNNmNoaJoSNXBg6J6/jVuyNRSAOm4cylUGyWsdGUcLvnKBB32CpBh6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759106799; c=relaxed/simple;
	bh=rdX5rxOFR4bMFbQQD4C1LhnbWJzkYUPr5Gt8qv0mVnM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uLF60Ma0+TWwiaahp88U6xr1KpsF6NfAB9dJCLhT1R34TYjOwc0K+ifRnlbb/evZo73KKcS9Vv7oRJNAs8S1PGy1WAvjp9Xz8BCjbRAPA/6rxkQ6PisNjcLjPE2TIOq3rpXq+G7HZujNTf9cqtDD3bz4oU3UkqRqih48ohYuQOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fE45z1bn; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b5507d3ccd8so3554533a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 17:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759106796; x=1759711596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QFHbiqQfhUKp1tZTIjHf7LJ+06KegZD5xVXk100wkJA=;
        b=fE45z1bnTZfZ0A+fscHZyYq0fSwu8PZG+NK2Gk8bnKN93+RypdriSFILVeMJ8Lrs57
         nCm0afziN2g6YUiA9PUWZuPxNa61bsN+/UnOpc6AaQgsalrfDn+2Byok/5eJQ/RgHKYn
         jb8lgcb66COAh/3U8L+R/g7Tjz51ezMYj/o44VJTF8A4IzpglM04+5LFLr3TGnaqZGHp
         4IJWW/qIgCooHpdFLI/5gkJTB34Kjyn8ci5pHt71MNhEKZidEBO91ReCSAGma0zU4R5S
         F15IKFVJ6qRbqpXG0lJ1qH5pVXbOXYgs0B8Y2OVvwHUIlh/Ig9ncYRnJGi+WuY4UEb8q
         FRug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759106796; x=1759711596;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QFHbiqQfhUKp1tZTIjHf7LJ+06KegZD5xVXk100wkJA=;
        b=UTJCDA25H/C0wybU3m5BqA//xN3Qyo5Khy3qG1ulq2r6cKI13IyS40wPeo564M5Y0m
         2kIhyX+kINPU+ynO6x576i85fp+g5f64n5bd5BPL8WIGDCnjbL8R/plirvYxu0FIkIVP
         ZUnN4WX3hsnu8lLjdtxyTbeCKiSgYtZ26SJ9TtnWTzeOITfz/bjoV9P2Kc+b+NBgzkFJ
         xD8pgg/Qen7zSqQFKQBuL8hBF1DJIVamO/bs/ai9W4cmAfgbow6x4DKLgfOvCDdi39Zq
         g65QV+o9K4DYSXwssKQFxXq/pJvK0ru/4tG72uwYzObByTam3Xr/w3/nBdJwL8z/ydsA
         Q7BA==
X-Forwarded-Encrypted: i=1; AJvYcCXjrkLYBecb8nnl9ZKYmYqevwvxPhjiZJHq3RlDh+oHukWXTmjULp/6qoAK6tmSYdBMhjp63ByA8udFK5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyISzRmmouHi6jhi94HTM6dQeD9sgJywKJjPpqGeExzSY2YAEM4
	YRrXj/mKLCLTfe0OIhGas+/kDLyEMn45bteHcs+O4YKIf5jUibAqJJUD
X-Gm-Gg: ASbGncudn7zHkLcB4b5cuIqzboBxrIlBzuF/0U22zPyx1Yjw6Aq36HPBnj6LDLlSCTo
	AO19ifPv9NZyDAZbp/a4PEBqkCOU8a9TicMKaFjFI+2QmM5tR+k9z1/lfOPoM/6D1nQ90dNt/Pn
	MljLKMMmD6/HMSIqWYC7gYgM9RVsO5BDRrUj6f5sW0mAyun5ZJOlA2TWyxrs5QPymEHIrKaWaz8
	Yis9bop3UlEYO7UcJu9I/E2+QCphGv7j4I4EH0bqJ7TPhP68TiyU6HnZEBaVSkyPFMZa5KFYsmt
	+jKUVTw2XXEE/S4TsELD/1kflroUaUcIfojCVs91UkkOZ+sT5Cj4QXCyzZaipcIvczhfddtMEXm
	QqIhj5boJkleR3i9EJ51j3g7E5mJMLEp7Rw==
X-Google-Smtp-Source: AGHT+IEYlOtRagpQCwasN9hrI6/tZf+R6mLErlpBo5fsnQRiR18Dra82gS14Ip3nHZa4PSt+uxMcgQ==
X-Received: by 2002:a17:902:8208:b0:274:aab9:4ed4 with SMTP id d9443c01a7336-27ed4a670f1mr118045785ad.57.1759106795744;
        Sun, 28 Sep 2025 17:46:35 -0700 (PDT)
Received: from fedora ([172.59.161.218])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6882290sm110877515ad.76.2025.09.28.17.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 17:46:35 -0700 (PDT)
From: Alex Tran <alex.t.tran@gmail.com>
To: oder_chiou@realtek.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alex Tran <alex.t.tran@gmail.com>
Subject: [PATCH v1] ASoC: codecs: rt5670: use SOC_VALUE_ENUM_SINGLE_DECL for DAC2 L/R MX-1B
Date: Sun, 28 Sep 2025 17:46:25 -0700
Message-ID: <20250929004625.1310721-1-alex.t.tran@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAC2 L/R source selection fields (MX-1B [6:4] and [2:0]) contain non
contiguous values due to reserved bits documented in datasheet (page 66):
<https://www.elinfor.com/pdf/RealtekMicroelectronics/ALC5670-VB-
RealtekMicroelectronics.pdf>

Switch from SOC_ENUM_SINGLE_DECL to SOC_VALUE_ENUM_SINGLE_DECL
to handle discrete values.

Signed-off-by: Alex Tran <alex.t.tran@gmail.com>
---
 sound/soc/codecs/rt5670.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/sound/soc/codecs/rt5670.c b/sound/soc/codecs/rt5670.c
index efd26082f..4c75a3e71 100644
--- a/sound/soc/codecs/rt5670.c
+++ b/sound/soc/codecs/rt5670.c
@@ -1153,25 +1153,29 @@ static SOC_ENUM_SINGLE_DECL(rt5670_dac1r_enum, RT5670_AD_DA_MIXER,
 static const struct snd_kcontrol_new rt5670_dac1r_mux =
 	SOC_DAPM_ENUM("DAC1 R source", rt5670_dac1r_enum);
 
-/*DAC2 L/R source*/ /* MX-1B [6:4] [2:0] */
-/* TODO Use SOC_VALUE_ENUM_SINGLE_DECL */
-static const char * const rt5670_dac12_src[] = {
-	"IF1 DAC", "IF2 DAC", "IF3 DAC", "TxDC DAC",
-	"Bass", "VAD_ADC", "IF4 DAC"
-};
+/* DAC2 L source*/ /* MX-1B [6:4] */
+static const char *const rt5670_dac12_src[] = {
+	"IF1 DAC", "IF2 DAC", "TxDC DAC", "VAD_ADC"
+}; /* VAD_ADC or TxDP_ADC_R */
+
+static const unsigned int rt5670_dac12_values[] = { 0, 1, 3, 5 };
 
-static SOC_ENUM_SINGLE_DECL(rt5670_dac2l_enum, RT5670_DAC_CTRL,
-	RT5670_DAC2_L_SEL_SFT, rt5670_dac12_src);
+static SOC_VALUE_ENUM_SINGLE_DECL(rt5670_dac2l_enum, RT5670_DAC_CTRL,
+				  RT5670_DAC2_L_SEL_SFT, RT5670_DAC2_L_SEL_MASK,
+				  rt5670_dac12_src, rt5670_dac12_values);
 
 static const struct snd_kcontrol_new rt5670_dac_l2_mux =
 	SOC_DAPM_ENUM("DAC2 L source", rt5670_dac2l_enum);
 
-static const char * const rt5670_dacr2_src[] = {
-	"IF1 DAC", "IF2 DAC", "IF3 DAC", "TxDC DAC", "TxDP ADC", "IF4 DAC"
-};
+/*DAC2 R source*/ /* MX-1B [2:0] */
+static const char *const rt5670_dacr2_src[] = { "IF1 DAC", "IF2 DAC",
+						"TxDC DAC", "TxDP ADC" };
+
+static const unsigned int rt5670_dacr2_values[] = { 0, 1, 3, 4 };
 
-static SOC_ENUM_SINGLE_DECL(rt5670_dac2r_enum, RT5670_DAC_CTRL,
-	RT5670_DAC2_R_SEL_SFT, rt5670_dacr2_src);
+static SOC_VALUE_ENUM_SINGLE_DECL(rt5670_dac2r_enum, RT5670_DAC_CTRL,
+				  RT5670_DAC2_R_SEL_SFT, RT5670_DAC2_R_SEL_MASK,
+				  rt5670_dacr2_src, rt5670_dacr2_values);
 
 static const struct snd_kcontrol_new rt5670_dac_r2_mux =
 	SOC_DAPM_ENUM("DAC2 R source", rt5670_dac2r_enum);
-- 
2.51.0


