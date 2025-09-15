Return-Path: <linux-kernel+bounces-817424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AFD1B58203
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 18:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD2A14C1DD5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 16:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B432877CD;
	Mon, 15 Sep 2025 16:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q3xE58ip"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C993D24DCE9
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 16:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757953680; cv=none; b=Q24XTgX8tlbiRnRyrbq0q9pZhBoqE96Tl7ehtSM0ZIwbBaEOokf1f7ahdqY0pUKGLBmYXaPwYam3erD3MeL27XKsGpFQyCyEVpFT2vRGdVhEchhuVvnm61OZ2Pv9ymTh2wWJx/kvZ5HGoNt8ZTVljBrvIGDKMk9rcBPsxFmhb0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757953680; c=relaxed/simple;
	bh=byM1gA6NVIvRuKX+ikW9/WDAziLBwNxEBiTHEmh/nMY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QkzVYxAfrta3LK45GXfOdGL1APcuS/VMtrf9fS4JK5LJ/3D4cKn2Ph3phJW1gl1B6RFYWnRSSz1Eg/mfpxXsNwLr2qkjIjdTDOqt+Zvl4DWXrMP4UGCaxepnJezCd8kC9E4IFQuhv7rUMfEw3Cwc1bZHDdjYYFm3BV4ayDIabHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Q3xE58ip; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3ebf23c0d27so372961f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 09:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757953677; x=1758558477; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=seV1ou3zNHbYzr8foh2H3pTmGgfBvTOop43lTeUOhsE=;
        b=Q3xE58ipTos/IEQRJV7dxxcfzkEXK7y8F5twR/h6sizkSdroW1OvfObKrVXR9MfEm5
         BkeoTNY/3lzh+frdlwpXQxNklRa8TvKQGT4CYzICoNoKwQ0zDCOu7xTRj2/eCtGYrZZN
         91xOK0Bi+WwG86u+XMt+wYHPn/HlERpP1ehTcmPTtbQShPOpxJA67IqdvUyHxwQ4UYeK
         VQc/2ZR9bgiWo1CBahcqzGICp+jwngYdbxtZBdHTRfRiylJrmYDFHDpB4VtbEfeTeaXi
         NOSjLO/t8qxts56KMRPWVhtyo1LMlZTQF6UcL5V/zRXVnPoPpfZNunQ5yLcwqHEDPjZ5
         cydQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757953677; x=1758558477;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=seV1ou3zNHbYzr8foh2H3pTmGgfBvTOop43lTeUOhsE=;
        b=vPqJTBKoQZ4yzCNa4MqRPi/lZ11qJ/Q4n+hJ7cFt/36YyCQOdBMDVCoNB7YRsgXRID
         zCrqI8ICdMV13Y7RrfsN008w5yluqCkqy+AE41O9ThamM1GvhRjLZDRMHd403QwJYjP5
         XC/GOiLK0qX/8f5cyxb8qCePTf/uCJngzqdYQkj0M3EamqWeKwTC+I2Q5qkM4hdI5q8u
         CEG+jAR661Mr1+SQErr6N4pIqCmKvQ3XcUA60K4tAN88RJA5Eird6PA5oVR7KuzwI5Qr
         s00IQckvQyRc/UE3MQRAbeL8z6oY0m+T59qW8aAKosr3fJ4Vfks+IRUg06XzxHODeyNz
         glSg==
X-Forwarded-Encrypted: i=1; AJvYcCXdK9oCz5nIM4S6ZPDqMG2O/tXT+nJwhCwsJIxRBNu75LldMK28dGAGxHC5ygpwGCSU5uQZSRqlU+rco0k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRfzr7+dVRcKmxPSjsuWzgccOS/kbjka3VVx2/k3+xGESyLwTq
	J7Hkk0+DSApRybrouI1XvALa0t01ON7g3iP+6U02wereALPgqmSv80wIZrafqKkKjHbff/UCs25
	B0vOJ
X-Gm-Gg: ASbGncsv+g0wRzfaRrliV/2dtOfiI1p4XW+fbGGWKAFrL1+7Ew2RpXMuL1mLC00mTdO
	FCW+Sdtlkh4E0yC+coYBicza2Bk/fWRwFGe+DKpIKAfZcPy8/7O7LJer2f7wY3waA7QNSC5VMJs
	DDGHd68ebvObd6PIFa7M/5tiharQCRpBNUiX0JfRu0fMlqT2LSzo69F8IRgnNOD50rVSXPK3uE0
	DUP0M5YyLTMIejIkf5X1EaPDcNH///refbh6bCYJ38uwm5vFyj8cYm/GpogEoOhAUtuxnKL3JLc
	H8Sz+tVpsHoe1DRkYwF87GdYhVdmbdLEWilmr8t2sg12etSDwkDzRJ0KRQQ3zh3WEBSz8VUiKX9
	/3NUaPPxtbnOMp8+CF7JrgVYrcldDV/HyIEbjKew=
X-Google-Smtp-Source: AGHT+IHfqSjdbY1hyVmBlldv6pS0JxrU4vVEyDVh7UVEJQC2k7uVsawo4o6Z0mdIDJELMnXHIe67JQ==
X-Received: by 2002:a05:6000:2509:b0:3e3:6b81:b482 with SMTP id ffacd0b85a97d-3e7657995f7mr12205876f8f.28.1757953676692;
        Mon, 15 Sep 2025 09:27:56 -0700 (PDT)
Received: from orion.home ([2a02:c7c:7259:a00:e60f:4b6c:1734:808b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e9a066366fsm7857989f8f.44.2025.09.15.09.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 09:27:56 -0700 (PDT)
From: Alexey Klimov <alexey.klimov@linaro.org>
Date: Mon, 15 Sep 2025 17:27:51 +0100
Subject: [PATCH v4 4/4] MAINTAINERS: add Qualcomm PM4125 audio codec to
 drivers list
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-pm4125_audio_codec_v1-v4-4-b247b64eec52@linaro.org>
References: <20250915-pm4125_audio_codec_v1-v4-0-b247b64eec52@linaro.org>
In-Reply-To: <20250915-pm4125_audio_codec_v1-v4-0-b247b64eec52@linaro.org>
To: Srinivas Kandagatla <srini@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, linux-arm-msm@vger.kernel.org, 
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>, 
 christophe.jaillet@wanadoo.fr, Alexey Klimov <alexey.klimov@linaro.org>
X-Mailer: b4 0.14.2

Since new audio codec driver is added the get_maintainers script
should catch the new files.

Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index fa7f80bd7b2f8bd2099acb9f38070498e7b1cc7e..b799748af2cbb47d048c70c7b30c9ad191199954 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20720,6 +20720,8 @@ F:	include/dt-bindings/sound/qcom,wcd93*
 F:	sound/soc/codecs/lpass-*.*
 F:	sound/soc/codecs/msm8916-wcd-analog.c
 F:	sound/soc/codecs/msm8916-wcd-digital.c
+F:	sound/soc/codecs/pm4125-sdw.c
+F:	sound/soc/codecs/pm4125.*
 F:	sound/soc/codecs/wcd-clsh-v2.*
 F:	sound/soc/codecs/wcd-mbhc-v2.*
 F:	sound/soc/codecs/wcd93*.*

-- 
2.47.3


