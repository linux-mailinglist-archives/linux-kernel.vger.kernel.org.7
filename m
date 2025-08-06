Return-Path: <linux-kernel+bounces-757832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1177B1C733
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 16:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A0EE1884D14
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 14:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DAF28CF45;
	Wed,  6 Aug 2025 14:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TXRsvFVf"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7111328BA98
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 14:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754488836; cv=none; b=r/aVgVWFY89hl5zHz3+SGWOpodc80MmRgqR3q0SZ2B8Xyp/4GkQ5ULnnIJxJEyrE2dvuWsIasFR7HWvw/JwYSSRTo506qci0+6JoT46RT36IohnecKqI1ZLKogoOJFidFa8Czjqx9sKmvtTXSDOvLPfj6wJMVisrMroFhj1PN8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754488836; c=relaxed/simple;
	bh=1e0Vl0DLzBwJ1AEPVtS966+I1J911xIBcPy784b2oeg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nt4pMQo9iE5aFAsiFmHgPxWIwX9ryAolNWBZT/bJ1Zmx0BhriO6UDgSQpcyuVeqdTY6Lk3XNPRtObo9QsnYXxonWQUWB9imUohy9Kuq9Opv/wpdD2azzYAY81XuF1arBYWH3GiSQmm+qef9iNlIJVPykpmp3/23c4mC5XLn+0b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TXRsvFVf; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3b783d851e6so5799183f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 07:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754488832; x=1755093632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S02Ags7WvqYe7LIFO8GxG705rWR0j/aMg3rhghXyds8=;
        b=TXRsvFVfVY220CPqMlInmShETRQpmZej6tRQe3dMved5lK2YaOpiXmUaooYIoIMsbI
         7ODb5DsWIMV5skC9U1xsuLoZN5mGkmaVHxsHYjYKm5+TlQbdN0FKXZPUJbRSSg0wpPXR
         YQ6VOC3jLyQllnaOnPWXfLQJEcM6kNb4rvobZe0k/I/DCE5iIvOkgHjhGCV0L4ORCcQZ
         u4WrQbMB5g4mojXDZMhtXQ6KFCBauzYGp9kwjwu0rD5K8MhPMjZdcfpybkpmEMduMwuo
         JVECkspqS8ODh+xCaV6HPCO1O6QblxoEshYp8l3PuJINi4HXKoDrULuB3iSlhhgdFWse
         Ojxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754488832; x=1755093632;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S02Ags7WvqYe7LIFO8GxG705rWR0j/aMg3rhghXyds8=;
        b=OpPcxyBsSCmMN+LXb042kNvtGqmkdPnoZ5fP+LdgDNTK9ytoaRcNDpAyPUFRJmJZTP
         eegrWlinFGHIo2Nh4EohRZCAxLKp2jHC/DFVGxwEnS42DbLmaj1qGKfd5j6MPLHxCrXz
         qFzNjrig6jnioXgAy1kdPEahtGaySo4eXRAQ6qAS3Lv2yakG+sIVAVNJuRC9u3lfaCyB
         6k71AVB0EaQpSuf/UC1Y5uMPGkepVXXJ4FjgVYakAC/6mbjagrBWOCDnbj/QGqWLSWmq
         54A2LrU1V57DcFJB6T21FVsgfoAokbbJqXEz807meP3Bv++CFDvtdFqE4kykmU5u75Tp
         oIaw==
X-Forwarded-Encrypted: i=1; AJvYcCUg6uV2N/4qTcupCGWcWv4mqwFvVIISndYBJqxQiPd077pLtmBb9ZiHD1iLiDg6f1WllIfcgPLvHDOzKrk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy5cLSBRSBtyikGDF/9SttRlCFl7GA378lHBILwDreCEAQ7RY6
	rqwwu50czVw56R9c9IESCQC1XiAw/5R5jCOFMBE8USwQLfWt9Yss52sEbBsHUQk0k/vIvPQ2igE
	2hirI
X-Gm-Gg: ASbGncvbc7yyJ/vkYMwfz4M7p4k+/U2omd/RvmdNSZR1bO4kn3U3PJuX+ubNU4Gt2Zy
	HDlld0uZwEvi9eScXEs7k3b3b1HbXsRMLsiWBN0rT+jXVZ1eSdaIoCGhlc7HR7/ED7W/HT84HDg
	Mb3DfSpXJfr9JtJAIhbeRy3OSplHrJTI3ZbNIXLvDsHxOOf2TNY4MMpHRYUMDOj5Yte18QS1DXw
	IeQjndL8IkzDGowBijrm0/fit5Z9jNvn/AzlwsgjodwqLD4DiZAVEJagxcJwR3EpAkD5YBzm3j7
	+QItNKCzF77iwgIfF4044HubsfsOEwNihIDqln8XLtEiMAi1945v8KeEmXWoXNQ4zu1Dt9uhgrv
	nB/S1KxLOLauinKQDVNnM9dnEnQFrM45xDg9ir8Cawdk=
X-Google-Smtp-Source: AGHT+IETmAlWMwJ2qjfxtHRSSLJlNaDSRStt3AyM41fvjsH5fd9IH28npg8xRcL+NtabnZE8k9FKKw==
X-Received: by 2002:a05:6000:22c7:b0:3b5:f0af:4bb0 with SMTP id ffacd0b85a97d-3b8f48e046emr2027583f8f.23.1754488831620;
        Wed, 06 Aug 2025 07:00:31 -0700 (PDT)
Received: from localhost.localdomain ([2a00:2381:fd67:101:6c39:59e6:b76d:825])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459c58ed07fsm147276365e9.22.2025.08.06.07.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 07:00:31 -0700 (PDT)
From: Alexey Klimov <alexey.klimov@linaro.org>
To: linux-sound@vger.kernel.org,
	srini@kernel.org,
	broonie@kernel.org,
	lgirdwood@gmail.com
Cc: perex@perex.cz,
	tiwai@suse.com,
	neil.armstrong@linaro.org,
	linux-arm-msm@vger.kernel.org,
	krzysztof.kozlowski@linaro.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] ASoC: codecs: tx-macro: correct tx_macro_component_drv name
Date: Wed,  6 Aug 2025 15:00:30 +0100
Message-ID: <20250806140030.691477-1-alexey.klimov@linaro.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We already have a component driver named "RX-MACRO", which is
lpass-rx-macro.c. The tx macro component driver's name should
be "TX-MACRO" accordingly. Fix it.

Cc: Srinivas Kandagatla <srini@kernel.org>
Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
---

v2:
  - added tag from Neil, corrected Srini's email;
  - changed commit description (reworded).

First version: https://lore.kernel.org/linux-sound/20241016215930.1144527-1-alexey.klimov@linaro.org/

 sound/soc/codecs/lpass-tx-macro.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/lpass-tx-macro.c b/sound/soc/codecs/lpass-tx-macro.c
index 40d79bee4584..1da34cb3505f 100644
--- a/sound/soc/codecs/lpass-tx-macro.c
+++ b/sound/soc/codecs/lpass-tx-macro.c
@@ -2229,7 +2229,7 @@ static int tx_macro_register_mclk_output(struct tx_macro *tx)
 }
 
 static const struct snd_soc_component_driver tx_macro_component_drv = {
-	.name = "RX-MACRO",
+	.name = "TX-MACRO",
 	.probe = tx_macro_component_probe,
 	.controls = tx_macro_snd_controls,
 	.num_controls = ARRAY_SIZE(tx_macro_snd_controls),
-- 
2.47.2


