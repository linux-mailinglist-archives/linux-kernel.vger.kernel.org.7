Return-Path: <linux-kernel+bounces-726804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 912CDB01174
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 05:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BDEB567B8A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 03:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C154C1A0B08;
	Fri, 11 Jul 2025 03:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BipYl5Zw"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69E619ABAC
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 03:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752202822; cv=none; b=l9BayxxgeX4i9x3J2lrFfhvlhX0cn9KlVnj9ZWQZ6Tjxwjb7xOtcMoYncmvniD5eT6kwKHCDpBaI8VQej1gFVwXmwDnnDRlUHVdffCMBwVDQul2LWMDe544ygimnr1kMPiiGUEEtaGjBc50Nhlcm+bjYdQ9bMMdfv/Z4W8K2MT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752202822; c=relaxed/simple;
	bh=5MIvJ0dgsrFZQooch+SFPSiVUKGE2pGyg4740J8aJX0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=haujEpbuD5+fNO3wh5TQ2BkK6I9goxdLfbg6GhewVPEFaq4XKXxbNYYL2ppF32fnyKpgMPPPOvy39vBX7GocNHZTVXwVFl8UswUVWBqPv5ThqVVKsFf3YJPNb9+lxAl/34nSL+7syzuhiZKHwIzeD0a1uDFm2OJinYBKvfS39Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BipYl5Zw; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4550709f04aso2278805e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 20:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752202818; x=1752807618; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PItV10s0cZSW+yN+a8jyJUy2gpJRDMCrOerQQhZoaU8=;
        b=BipYl5ZwCMkqSFqVnqRGFrqXP7lFCUjIYj+xiVYE513PcboaZxuwHUNVao5IQsXYKE
         R0cPwOJX8Ustpl88t0Q1Dh56XSS9o6+T7tgLnQYj0UNq9mem468DDHEY1xGg2NVHUUQ+
         ywvKxH3orTrHCMuT6tCnh1dY0MVE190bZrSZMbmsIW12l5Kn8OjbD0jsTlOv9wWaflEP
         L1HyeTG8w6rS3yPBRKbpUh7k/R28iVbIZv8xoSoR2pDfxBAWlnAVKLEWO0VeF6C+q9Tc
         4OqcL2uqrrkXAD8z2XrZ8Gk1pZJ8ZB2ZoCXTH7wtkuHumxG5AtAu4QdEtp4BpwULo1tJ
         Gvww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752202818; x=1752807618;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PItV10s0cZSW+yN+a8jyJUy2gpJRDMCrOerQQhZoaU8=;
        b=N1O+ONzvpIlD+2e5vxTnl3ju6Um2eWDCH86NSQxVnpn4MG9fv6GKPDYWUzHsHupyK/
         heHH+f7+hWFxcn/R4LPkkbejjJ4rXMzcqAmP4Z39iDwZ+GVUEhA3GY0eV6oCd8wxszef
         hzydeRsp9s8GyG6srIiDhTBttXDzI6ouOTdIzL3alqpMSL7G8/cBmDMKHpuphvgcqYXS
         6A2IG/q+wm7CGnjeTa6OUJtjVUT9jIA5AcZplHvXCydrNyodi+B2z67AJ9X0Iyyjr8Wz
         +UtwaZYNaWgaVg4ckDC5Z2vAIdxg32jxsDQO1MCc2JA8Nc0Q/Z7qaJk1kUTjWpwDExKu
         c8Hw==
X-Forwarded-Encrypted: i=1; AJvYcCXz9AODPxv0rrXZDRIP6GyQ8uB1rkHOTqNU0S5XP0vhJrcIC63MkDQdAflT8HSFWkyrTBiUSkXgK+3omN0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUSZnQN9XLpXB4CKsihh5Mx/bNRXEk5v4d2WLHK1UH9jmx57Gh
	ySPwfy9YH31qbeQvVoCBEGR3avCW2+HVapKzK/2wkW9y8ObO8WQ0I59MCRce7khXTlg=
X-Gm-Gg: ASbGncvFMa5hT3oHyunikp8lXJ0i6g9ylmvVNJersfI5fmls0pBzj8lGExQWGHx0ggB
	NhBjTQjlCPRE43XBA5oFDMCNRQwCD3nTa2EVIc9UzViNMZWEzXyg046fGF0Tj3oXOoMgo0KpO0M
	5FbV1T424y8MOhI33TtyJCL0j5lI3vZFhs4bikBku3QzTr7V0jYIdfdtSxNtnRCLJVqrBMiqrnO
	5Kowcri+RsAtV/HhFijkkpkFiPtuTeCHTgZwC/ep61K7aM2w7JA5yAgPPwi2W67DQM8VHvVdFUb
	eoqBes3kNpViOJPS7xjetLfhtSNiFgIqkGbMw1IkLrXL2yWuJrQPu5jidmAGTD96QOEqmVPEBlp
	1NDV3pUO8bbQrl3FTDFFWxRXk5W99aQ==
X-Google-Smtp-Source: AGHT+IGu2ldXw3cTzJ/uXsfrw6SXkpbJlU3IpHW7dkiNBEJvGWLqmXfnAmpjdfy8ipaz837wikLWnQ==
X-Received: by 2002:a05:600c:628e:b0:450:cff7:62f9 with SMTP id 5b1f17b1804b1-454ec2769e7mr8969525e9.22.1752202818181;
        Thu, 10 Jul 2025 20:00:18 -0700 (PDT)
Received: from orion.home ([2a02:c7c:7213:c700:e4ad:f2d9:9dd9:cbf2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d50fa9b4sm75424355e9.27.2025.07.10.20.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 20:00:17 -0700 (PDT)
From: Alexey Klimov <alexey.klimov@linaro.org>
Date: Fri, 11 Jul 2025 04:00:12 +0100
Subject: [PATCH v2 3/3] MAINTAINERS: add Qualcomm PM4125 audio codec to
 drivers list
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250711-pm4125_audio_codec_v1-v2-3-13e6f835677a@linaro.org>
References: <20250711-pm4125_audio_codec_v1-v2-0-13e6f835677a@linaro.org>
In-Reply-To: <20250711-pm4125_audio_codec_v1-v2-0-13e6f835677a@linaro.org>
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
 Alexey Klimov <alexey.klimov@linaro.org>
X-Mailer: b4 0.14.2

Since new audio codec driver is added the get_maintainers script
should catch the new files.

Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 41d95e7c60c629338fbab8e6b001029de3c4695b..3ef80be4f2b6dc07cda7a6418eddb7a07ff28962 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20221,6 +20221,8 @@ F:	sound/soc/codecs/lpass-va-macro.c
 F:	sound/soc/codecs/lpass-wsa-macro.*
 F:	sound/soc/codecs/msm8916-wcd-analog.c
 F:	sound/soc/codecs/msm8916-wcd-digital.c
+F:	sound/soc/codecs/pm4125-sdw.c
+F:	sound/soc/codecs/pm4125.*
 F:	sound/soc/codecs/wcd-clsh-v2.*
 F:	sound/soc/codecs/wcd-mbhc-v2.*
 F:	sound/soc/codecs/wcd9335.*

-- 
2.47.2


