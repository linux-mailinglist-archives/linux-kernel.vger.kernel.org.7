Return-Path: <linux-kernel+bounces-812432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68816B53813
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 17:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 225F316F4B1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 15:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFAE346A15;
	Thu, 11 Sep 2025 15:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="meVHTyeE"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8E6342C92
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 15:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757605425; cv=none; b=UVLF2Sp9GZtjwHp79F3BnPDuzxjfl2UaJRCXI4pzXbNG78VCp7RnvvRDHXDsR5ov9mbwb2vYpVwOHjG9WlfL1as3i1BJVMul/9gTPMLVSG3meTsMY7C6s9oQB3GhdjBo8tOvJYmblo9Q89O2bSRe4MiE4+NzznFkhdNcwQQb1uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757605425; c=relaxed/simple;
	bh=mtYEVqFfYfhoSwbzEKp/cEepkdVMf6SyvuyKmyLLU8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q3s+Oi0/X91bFrEHETufR7FU0/QN+aK+HH+98L6wjo4rtgqN8sq1BrILkOF8RDznTbJMS0cs+wRsVANNUPxF5Ig+I1Wsby2ae3M86ktsRBCDDpNZkmK4uua6YqoKhilM2vJgEghUlt4RN6fNUFsmArZcmDAZrcZpffdghnk20Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=meVHTyeE; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3d19699240dso1171894f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 08:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757605422; x=1758210222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z0oQTNxrqqvW11nhsresLiX6PlYtqN+ZQ8oB9MyzMxA=;
        b=meVHTyeEELUoRUkVauw8teFM+wZQpnAa3NNlzlLfsB18EAfiNVETE7IepV7imAoV+0
         ujNYdcrqwXLOGiC2zgpCoHB1f9Q/Oeu/+QRCdosJ7B4/CoICarCezHgzW7wR3PnYXKzQ
         IzprcfLw9q39xGfkgKbHsRU9wQGcn2OV9qshdCUWsVKiMbTrRb15bSnU2fAf47HjyUYY
         FDMJz2Bv17XTkmyf7EIkAQ5QXFcBbhEvEaj3yci9GBoSrNArfjvBOHNRWUUrdjIhCDNm
         D2AmtoGy/xIcY4jK8MBURSQgpujsTJJwqHjt3/rQ7O8e+lPj6IJ85uneUL4jL2fBOS+G
         Gfvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757605422; x=1758210222;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z0oQTNxrqqvW11nhsresLiX6PlYtqN+ZQ8oB9MyzMxA=;
        b=pJHf+DcRQvVeH4TV92Q8DzGj5FSv7TBifKiGwqc/0UJjgykx2ZETdg5nMDBZpX4vze
         Uo8WfZlhLkrTnBAauCN/OxYCc2GKi09J23xXkn3qjC5LVc9QT8nQ6wXS1cN2W8k89zco
         AKwaf3lf0zKCuvIO8Vaugu1W86lsMcerCNAaThIYO81+YxDrE5OJVnc4MuFSa8PZQLk2
         4tNoZnUhnef3vaV/lg6n8zlIDThJjL6uK7fCLSn1ajjGU8wnJPX6RFa3ho/Ebv5EVQnD
         Dq5XXuKQGztneNvbbpCvHZxFR6kUoHUchtsvNkfp657umCE+wsq1QlJtxqwtVObCYVP7
         PdyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJj/3PSsIGR0Ap+2v6cKkAsCK5Z7f+H7nnqsF+rWtepamk/ZngrQTyAMgON4ji4h7b8+YVMzGwJM8kbIc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLJ3taIokne7wukNDk+XI0DcoCZg0BGBE2A6DWq0/fNDF1GzmG
	Z5eGZnz2/kPJz5RO53t5CZDNVYvMjglQOGP5/ooz34RHibHN9IO3xP134UTrEWfHjrk=
X-Gm-Gg: ASbGncvKXpJHFALb4GYwM7u2fyQU7Jae9sPU+3SA8QmSHFTwpWIT26GGaJ2nrNpoDbh
	wq2LrqDPx5rJccPbT6dCAPRUimHR7EGiqzdzyPzeD5pi39YeDk5DxURtpx5DTc6BDJ+IMyg15/f
	E0tYgjwRB4XPKBEq2fJMTx4gmm/KOyeYlegJhkk+z2/CxrWBaPLRrvizutLcvvkQ95bfEFlCyDg
	dFReugjk6NWA9KIfGxYDyhUgLNfsJZ7+4D0PLGA96GFKMY0e1wIHJ9Ut8kwf/OFPblwDGe+lKFl
	kxgu1OINl6nq8xXKmlYuNVrVpXTzonR9oJs+zaUMmdngcUjNXq8zKk12jfU9VGzahcAjgIqy0sb
	3gWxW8nZp3KDKhMgHc5WXuCtKuBgJmEHVDOcu5so=
X-Google-Smtp-Source: AGHT+IFh15zztkJ1zOO4/RN3ASTtgLJC2rMLFG5k5RSkaslNY3P4anVKOXAQFo82PonNF26Qn1N8Xw==
X-Received: by 2002:a5d:5d06:0:b0:3bd:13d6:6c21 with SMTP id ffacd0b85a97d-3e75de70d33mr4111569f8f.0.1757605421647;
        Thu, 11 Sep 2025 08:43:41 -0700 (PDT)
Received: from orion.home ([2a02:c7c:7259:a00:8a3c:25ae:f06c:6781])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e0185be34sm16847985e9.4.2025.09.11.08.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 08:43:41 -0700 (PDT)
From: Alexey Klimov <alexey.klimov@linaro.org>
To: srini@kernel.org,
	broonie@kernel.org,
	lgirdwood@gmail.com
Cc: perex@perex.cz,
	tiwai@suse.com,
	srinivas.kandagatla@oss.qualcomm.com,
	neil.armstrong@linaro.org,
	krzysztof.kozlowski@linaro.org,
	linux-sound@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: qcom: sc8280xp: explicitly set S16LE format in sc8280xp_be_hw_params_fixup()
Date: Thu, 11 Sep 2025 16:43:40 +0100
Message-ID: <20250911154340.2798304-1-alexey.klimov@linaro.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Setting format to s16le is required for compressed playback on compatible
soundcards.

Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
---
 sound/soc/qcom/sc8280xp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/qcom/sc8280xp.c b/sound/soc/qcom/sc8280xp.c
index 73f9f82c4e25..5d10b1c5909e 100644
--- a/sound/soc/qcom/sc8280xp.c
+++ b/sound/soc/qcom/sc8280xp.c
@@ -7,6 +7,7 @@
 #include <sound/soc.h>
 #include <sound/soc-dapm.h>
 #include <sound/pcm.h>
+#include <sound/pcm_params.h>
 #include <linux/soundwire/sdw.h>
 #include <sound/jack.h>
 #include <linux/input-event-codes.h>
@@ -82,8 +83,10 @@ static int sc8280xp_be_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
 					SNDRV_PCM_HW_PARAM_RATE);
 	struct snd_interval *channels = hw_param_interval(params,
 					SNDRV_PCM_HW_PARAM_CHANNELS);
+	struct snd_mask *fmt = hw_param_mask(params, SNDRV_PCM_HW_PARAM_FORMAT);
 
 	rate->min = rate->max = 48000;
+	snd_mask_set_format(fmt, SNDRV_PCM_FORMAT_S16_LE);
 	channels->min = 2;
 	channels->max = 2;
 	switch (cpu_dai->id) {
-- 
2.47.2


