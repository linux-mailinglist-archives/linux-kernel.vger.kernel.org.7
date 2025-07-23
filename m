Return-Path: <linux-kernel+bounces-742649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC5BB0F4D5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 16:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B34423BB985
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 14:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96AAE2F3653;
	Wed, 23 Jul 2025 14:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="j/Mx/3+x"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35822F273E
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 14:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753279452; cv=none; b=sntSVrBgIn4Zqc3sIXVQO5qh9sJaO+yjwD1R2615yxS1TXri8SURC7asz7J4vA7czNAXhAFy/fiMEkltBvMM905DoUF9J3ggeC7391g2XktS3SOrZWplYDp8wl3dzB1emQhQ1Fkpip2IJbWuiW6rcV2qyquFYNJyW/ubWg/w9p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753279452; c=relaxed/simple;
	bh=0DEgaxktWtylE9tS47CHiAD37SUMRWPVx+JL0++K0w4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DT8W7zsvNRj7oQqScf2ZMkaL1DNQtq5PTQgsEpj9TC9A94S8y1hrS4PXdOMseGpGHY0FJo5wua/t7189f//3FtAYuuRB3Us2VfIgdKCZyYBmXLxdth3A9blwqIPah0ThXN2aMORDdFjAoQeeEehk/xojz6VEKZEPLAxeY05AxRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=j/Mx/3+x; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ae36e88a5daso1164197366b.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 07:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1753279449; x=1753884249; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CBk3e+ZeNvt/w69kQtejS7uDHZHCYnTulCyNIFzv8gY=;
        b=j/Mx/3+xc/XSy5nydHMfiBdlGr7U38LNfvKfdufoxuXRNy5/pvHa/sTcLcN3HU8j3L
         UFdH3pQwEGMDh4e2L0NukJJ/Lym1TSPKzcZnj8pgfyb5YJrPQpNCk/WATy47ebJtVhs3
         K2Ln9tXAXbv3imWTEg4myxpgFAxEoyWbwjobRdRX2xG8aM95TAWkQh3gi4MLNui6PdYz
         LgM7hAPOcZ8ejCyzbCmwtMTcfiwdFHec7BwRCzg8WgKxfZ8LjV16Jwfvd0WHeLvnutXy
         OL4Xw4UXh4z4G7PnsznF06MM2H3ShvFoUCf0N3m2lNUaBoETGYNOWGymixRrI32RhdiL
         fN0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753279449; x=1753884249;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CBk3e+ZeNvt/w69kQtejS7uDHZHCYnTulCyNIFzv8gY=;
        b=wy7ajeTtFwfJ4WS53AqY/zV5lQZ6jd/dcRgXP8+Ynw+ZLMJ2a7cdr/4mwqF2VR4LG2
         yhXP54J+v6tQ2Re3zuFEMabUwm5Ag9xnnpNLJcfnvYqVUtAjyyiEr+zi6SQLZdfbtM7s
         ClqSpjpX3cVLvoOpaHIQwtOY699nDF2lqSPfSi4rAFKngX501ljJDAcxGWuNgbBO7FuX
         53Bij6HLFkHpb8lSrjEwJTFZXhThTu6M+Pp+yriUwpM2v+7ywDln7wbfWz8meJxCZPyL
         quL+T2e9o+yi7v4+hZxu2H/lrwIwzeHxUQa1Z71IzdBGdKRA1+X/3WlxbPQljx1QgHCL
         chsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYS4LNzUf+hxGZHYIoeHCyjp2h083TF7Iibh/a4ek2SXrA7bqcGAnzTDIab+sZCFmavF/E8xd3d7jOqLM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCmZTpxgYDgcYtHV+PCMid4sa2KLidrfQ/4uVYQxaC1X140VMp
	KGCYJNSfCN7Sk8a3VA2UrzEN5OjAywxMx6Fg8gYSMdUtKRxGB21FARnKlSViZ0Hn1Ic=
X-Gm-Gg: ASbGncuRsElPt+W2wh6HMo4Pr0/3iBM1GC0v3EOlqDv57uvt3Q+X0InXmKbafa1OvHd
	pty8lJ7gzpntvyvL+LqrrKVKZnSZ8S/74KfjBaRZM5Fv8o8EPBtV1N8EpnxljQq3E5CJTF6+ZCw
	SkQDezb7wi3fD+6OtpgBfxk0o1WNQ8LRD3b8USuf1cF43MYJRWjq8EkTxiYn6F/LpjhXOjT9ztt
	siofUGwXZz3igtwcOUNE0bj+FD/IpNlAwRO1jieE+b30dy5QlN82X0ZCmGdzlSmCHkQEzrSIGm4
	llU/608SZgbRl/2P+fn4+QcetNAINzgAq1198S617OQ13I1KTODg01o8c/gSGnDArC7ucTtDb1j
	cGZCVDXIUHsinWbQeNKEExgE2oX6Hm8ST18D48ATZ+MWb3ehUpr6e659GM7M048HzIJ8m
X-Google-Smtp-Source: AGHT+IFIf87TC3ZSe5JBmPzIIxrTRzYL4zD8nVpLsuTYwJfJNPVnPKmaSJbEvn9fuMpNBzzUCHRPOw==
X-Received: by 2002:a17:907:3ea6:b0:ae0:be38:64bf with SMTP id a640c23a62f3a-af2f9178962mr309369766b.58.1753279448707;
        Wed, 23 Jul 2025 07:04:08 -0700 (PDT)
Received: from otso.local (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6c7d46ffsm1054830466b.42.2025.07.23.07.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 07:04:08 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Wed, 23 Jul 2025 16:03:40 +0200
Subject: [PATCH v3 3/3] ASoC: qcom: sm8250: Add Fairphone 4 soundcard
 compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-fp4-usb-audio-offload-v3-3-6be84ed4fc39@fairphone.com>
References: <20250723-fp4-usb-audio-offload-v3-0-6be84ed4fc39@fairphone.com>
In-Reply-To: <20250723-fp4-usb-audio-offload-v3-0-6be84ed4fc39@fairphone.com>
To: Srinivas Kandagatla <srini@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753279445; l=935;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=0DEgaxktWtylE9tS47CHiAD37SUMRWPVx+JL0++K0w4=;
 b=hPyNXoVJuPYBMO+z6fAdDJs+EMudff8F0d7QdXv5K9C7/1HEfTM0wMp+5A3PFEbn7KuJ2hALH
 IImnnwDdPE8A7AM4nyhN1JunBzXdF5RT/1FdCq0Vv2juqAMDtAEm055
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

Add a compatible for the SM7225-based Fairphone 4 which can use this
machine driver.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 sound/soc/qcom/sm8250.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/qcom/sm8250.c b/sound/soc/qcom/sm8250.c
index 69c514fad0b1babafae4b61bb5ac944c6b4906dd..f5b75a06e5bd20e00874f4cd29d1b947ee89d79f 100644
--- a/sound/soc/qcom/sm8250.c
+++ b/sound/soc/qcom/sm8250.c
@@ -208,6 +208,7 @@ static int sm8250_platform_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id snd_sm8250_dt_match[] = {
+	{ .compatible = "fairphone,fp4-sndcard", .data = "sm7225" },
 	{ .compatible = "fairphone,fp5-sndcard", .data = "qcm6490" },
 	{ .compatible = "qcom,qrb4210-rb2-sndcard", .data = "sm4250" },
 	{ .compatible = "qcom,qrb5165-rb5-sndcard", .data = "sm8250" },

-- 
2.50.1


