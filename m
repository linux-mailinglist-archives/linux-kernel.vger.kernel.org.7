Return-Path: <linux-kernel+bounces-767727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18583B25823
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 02:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8CDC1C0599F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 00:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD031CF96;
	Thu, 14 Aug 2025 00:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xM+SuKEC"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80653B1AB
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 00:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755130510; cv=none; b=omhJNnzhkr29s1Pno3+dZCbG2LjNGn3/YMIqNk2+DdZRSwabcJ6auY/zP79y3A+TnWdvl8PZMX+YL38CYhOYz3sw79gQV6qTg3s2GHXqps1//cGju+UCHGr/5Bi8CKovrU8/+0r0TjuSK118oKMna72B0T28LsfIWImySIGkTJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755130510; c=relaxed/simple;
	bh=8ePI/6PJhtyF7LbcZnUAOksK1ilWu/10/PFT3euQFOk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L9Ckjv6jMD+KY03y6r/e8aeC9otTNtHqBR898z1qgc3mP16MAVnS7xaBTf8snXMsWqKz22rWmR8YKGhbJg6agR3LR43SnRHnCmgfX62I0mQM/0PO54/2d+1QNu1vTJXBYcNLDg3LU8WKnAsrBGRQgaZ8YNBYqdrqQomNkDNUV8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xM+SuKEC; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45a1b098f43so2149735e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 17:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755130506; x=1755735306; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U6UxVKvq2fCGJ3yq55OqNS+Mb+WIhaHcEFYrRTU8vuo=;
        b=xM+SuKECAUlddOSOg1oxenE54FWdPbRj9L64yX0zLxqrFmQSzt19h1O8gHaCHdQEUb
         CBIIA+tv/8+oicr7RTQHej/qoVGFny3XWBuEEQpd7mNlp0PXDkFPVJugrW31UONNQSG/
         GPIOEalpXBWUGrHaSsKCaSPmLNv/+Z/cRGhyYyAK4ypvIWSbo2HX9ptINJHg5jwKdPte
         rV/7enECdLz0uDsjQVkhHh8sIkJuurTBK4lNbnEwb9un0dvAxEZ5BIb8ZagEscu10ArT
         8tGRDW4Rd1T0niIMsOADsiPOfHKWyS/gd7vXMcQnLNQV+wBsciHRRu6XNpzKsrt5ZEwF
         CzIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755130506; x=1755735306;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U6UxVKvq2fCGJ3yq55OqNS+Mb+WIhaHcEFYrRTU8vuo=;
        b=u2Au/S2KLZ5wy0IqzFjBFc30R3Mp+300sy212pV6HE+g0OgPjoyvkuSD8oo5dUoUrL
         VxYDEDtKO9xgEhdDnu5GgBA02kgp7UJ77Mp6Zb7TlQFNqg0RkHyqGc4qcR6zImbiI8s+
         A4oBEOadGs7j8GRhttGoxqndsdOI64mHJ3cPROTbHRYkEk1OTDhltrHTnjc8+0On0q7y
         3ogVtkQ8W/PGomtbhOs+zISiqm7HYGF6Y77/d8U8YxSOLfl/XS8vhLZFQyTYo245nFbO
         hH7bjux8ByVeJefsaNYNbwHNMJQaGkGfVaD88vRbpJb5c5GDxblQDDxrT30PpRRGmo9/
         0n0w==
X-Forwarded-Encrypted: i=1; AJvYcCWHJiTR1JWz02RRLl8J8QbV8aXYgAGRvm+QgttTUEyOe2HkRDyC/BMq20EoN2lYXFs5gPlgsyCZ7Hu7D8g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5CeFUKbctIm1mTM0288M4z5/9RaqgG6LqafwBTPBMHvBloFpz
	8TESOnlZsfUWUi5BT0DlSllJtxhrSk3238sPB0Q39u7Bin0pII5qrX09FMfMrvFlhuxib5boVBK
	CTio2
X-Gm-Gg: ASbGncuJPyTp3ECK/BNyEfTl0jiKLsThjfolrCrmZ5fLd8hMUP6jcg0cCQ9SO+0sjA8
	E9yF266pyNf0m9OYszyqCQC3vYHSVnPFlelfxIkOXX24iruxy0+8lof5tCM6dUfSz+f7FEuTlNZ
	YQDe2Q0YgONdNFhT9BgCM27YbVHbjLLROV/PZvbsWocm7RU3clDbmmzCsdns8EvUcs3t7YcvXit
	+L4qd1wj9fBIriKUl8NfYcO0TPu9OFkVznG/sjLXJ/1AyApPo5sgUEHWhVne22NbHppnJqz9XK9
	tQ6bVOJpKPULHz5mt7/QXiAFVUx7fyHEYNCQ/RWeHOkJGajjboeE5LopJmLy4fY5nl0QE+Y7Qeq
	IbEKQZ+1FZVGJlvuR3Qq9uLcViJZC
X-Google-Smtp-Source: AGHT+IGqtVXj99eU88bSXdfAnC/1JtxDDSo2fqotoTnpGOovuJhcvJB6U+7t8TNsncfurTkkQhDPvw==
X-Received: by 2002:a05:600c:8b4b:b0:456:1006:5418 with SMTP id 5b1f17b1804b1-45a1b61eaf8mr5434535e9.13.1755130506083;
        Wed, 13 Aug 2025 17:15:06 -0700 (PDT)
Received: from orion.home ([2a02:c7c:7259:a00:7f3a:5ab2:26aa:831f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1a540e1esm18449065e9.28.2025.08.13.17.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 17:15:05 -0700 (PDT)
From: Alexey Klimov <alexey.klimov@linaro.org>
Date: Thu, 14 Aug 2025 01:14:49 +0100
Subject: [PATCH v3 3/3] MAINTAINERS: add Qualcomm PM4125 audio codec to
 drivers list
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250814-pm4125_audio_codec_v1-v3-3-31a6ea0b368b@linaro.org>
References: <20250814-pm4125_audio_codec_v1-v3-0-31a6ea0b368b@linaro.org>
In-Reply-To: <20250814-pm4125_audio_codec_v1-v3-0-31a6ea0b368b@linaro.org>
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
index 0e1bb91b76598edbd67c8a174d2d41f6c531fa85..feef290ae7fb09488cd4946fc9bc2d4203f7c2df 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20465,6 +20465,8 @@ F:	include/dt-bindings/sound/qcom,wcd93*
 F:	sound/soc/codecs/lpass-*.*
 F:	sound/soc/codecs/msm8916-wcd-analog.c
 F:	sound/soc/codecs/msm8916-wcd-digital.c
+F:	sound/soc/codecs/pm4125-sdw.c
+F:	sound/soc/codecs/pm4125.*
 F:	sound/soc/codecs/wcd-clsh-v2.*
 F:	sound/soc/codecs/wcd-mbhc-v2.*
 F:	sound/soc/codecs/wcd93*.*

-- 
2.47.2


