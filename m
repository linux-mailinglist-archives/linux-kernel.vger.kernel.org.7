Return-Path: <linux-kernel+bounces-843669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C92A7BBFF52
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 03:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C78624F2D62
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 01:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 730992147EF;
	Tue,  7 Oct 2025 01:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Znpi7wxs"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0761FAC34
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 01:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759800377; cv=none; b=W81PEZOW+PgABC8SFl/jyP4Qn4W8k+okmmg0CfUd9nuQfNVqtPuFu4dyIq88JQtdHcsxKWVC6w2sH/h6kg1SMfA7Ze7NmvOjQuhCDUC/Myja1kZ/Y82MoWeXZGHrQpLmlLmYa3/fRyPd5sofXL265fReykO/GSvcNezjMcmI3t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759800377; c=relaxed/simple;
	bh=6ffmg2XA9jcgewH/j6PAyG0UVV/H+4UiGg8CzD2bW8c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fRliSywT1r3s3cUJpV5CRK99Ae0moGinbuJ4nDQtF/yxlJ7xV/UJkXIZMamM9E9MtcVz9lzZj5Lps8mM/3rvj+9A++3rYLpTxiA4HxioAXPYjPXyHHMPkTXiI797YVmpGJVmrSPARufMUeFlM7hOZsYufZFVdz/T8ciL8dmFcjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Znpi7wxs; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-46e384dfde0so63448395e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 18:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759800374; x=1760405174; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J22zbKLN45yOF238j0MViKbz+/v5EiBK0GTdWMuYd70=;
        b=Znpi7wxs2kbcUaWQ+jFgaL4N6Hn5p5tavSJ1MRaNg5J9cMW/DbqoHQe9xUFgBkWwBh
         +21cE3mbGYvS+tU40+98yzwcaFbC7V3Gfj6qXrvqB5xmgsxLD5fJu0/cfMrXu+dBgujN
         Jt35kOvL26skg4cI5BxJ9rfmwlZ+7y150E3XzlhvJef20ITlcCZztJi6bykLFj8tJdR4
         1Kt8DHDObmq6vQauBgEqcQ+ncdxtnVvKmPu7WA+RkrAaFkkBVmFKF3JV0x4uMKmG3ok8
         rUrcr959dg4qbaQgJYIf08Kj4YtOW6LvYJA2Np5GbafOMdc0kUGZ+jJg17TxsDAUKVe7
         4KFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759800374; x=1760405174;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J22zbKLN45yOF238j0MViKbz+/v5EiBK0GTdWMuYd70=;
        b=dCwb9WgBuc4ce21xDw3lEZzuQGMcwaHN5nSXKiBKAjuz7EFO9lBhitn7WKfXvUZF1q
         1sU6IT1jC9c1xo2embBy5I39C/xXJNG5vzj7HEFXdJ8+nE7dPLRak9w/jJHjskupIkO/
         oe2rxnfQgtJdsV8hSsFIjq+rxBnlzUJ/IznsGwPjFwHBlk61ZMcgf/OOIsZDOhHEqf2+
         UzgUeettEzD60UQ6L9GyemB+JH8BytpOgbadRqW4jH/3BiA/Hclzbm0Ro0F9zoEyN81O
         W/XUjjWdhOkbes33hbVC2BUxYF5NtmpY8IzpAzfclOZVIQq9WbFEoOy1aDNPtunloBHl
         /hKw==
X-Forwarded-Encrypted: i=1; AJvYcCXVZPlpyp47gU9Sju04Hn6Czx/BIMfNxhKVzfdO+POOrsKV9CJgp/qe+VroZwefbsfmJmi483rnPDlwipo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAbghWzPFSsEdq+paC8Ji+hDWzQLy5XqIqlZhgw/q9snDRTAHN
	MHkETbZO6tNrrgV8j5n/E9DBoz7M9g2YN1Ut2VpyrsTEwXSMyNKGX3rrBToIpdmhkC4=
X-Gm-Gg: ASbGncthN3VoRbF/JCqJ81qg9jm11adxsJKDAH5F5Ys13qvoAhahLxhvNuyF4050osz
	iV0Dss59r147bn1mJA7H/dH1f4cC7lFjx/ueRlesrLtSTwqLu8BurGtRc/rsSKAWGpBoSsYms94
	FLqOoTso0QF31Tsp5/PR5RY1Rm+0RYsAiFhIWh+KkBaQ+jER3nmw1qVPiZgPmc4Vjbgy+BzxN3E
	ygS+EqOwDrCALzjgFBK1idQnQAtFTq41lDvaVHKoGqIF2EQjqZmd/3Scl7UFwB/lsHQb5yGHoqt
	XNhz/2U5kjn1Qo9aPGbFwAaNu4o5ky+j2DuIYBQLSgEMjxOgo02fupc/uBpDS/G73vAtVnGTTex
	SMWjXESn3Jng7p2RozPjxh4wm7mtIu0QQdq5CWrRNOWOu2CvNJLxLnrlJzyzNnJXqkJvJ0k/prB
	1k2A==
X-Google-Smtp-Source: AGHT+IEiz856XiSIMY0NkShrDp6YxZCYEJvBvhcMBG4LXiiI67BJKwpsD2QzWSuAygSdYHT/mIao1A==
X-Received: by 2002:a05:6000:2082:b0:407:7a7:1cb6 with SMTP id ffacd0b85a97d-425671c612cmr9480955f8f.55.1759800374073;
        Mon, 06 Oct 2025 18:26:14 -0700 (PDT)
Received: from orion.home ([2a02:c7c:7259:a00:22ae:baa0:7d1a:8c1f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fa2d52a71sm7410915e9.1.2025.10.06.18.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 18:26:12 -0700 (PDT)
From: Alexey Klimov <alexey.klimov@linaro.org>
Date: Tue, 07 Oct 2025 02:26:08 +0100
Subject: [PATCH 2/2] ASoC: qcom: sm8250: add qrb2210-sndcard compatible
 string
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251007-qrb2210-qcm2290-sndcard-v1-2-8222141bca79@linaro.org>
References: <20251007-qrb2210-qcm2290-sndcard-v1-0-8222141bca79@linaro.org>
In-Reply-To: <20251007-qrb2210-qcm2290-sndcard-v1-0-8222141bca79@linaro.org>
To: Srinivas Kandagatla <srini@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Alexey Klimov <alexey.klimov@linaro.org>
X-Mailer: b4 0.14.2

Add "qcom,qrb2210-sndcard" to the list of recognizable devices.
Use "qcm2290" as name to let UCM to use it later. QRB2210 RB1
and other QCM2290-based boards can use this sndcard compatible.

Cc: Srinivas Kandagatla <srini@kernel.org>
Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
---
 sound/soc/qcom/sm8250.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/qcom/sm8250.c b/sound/soc/qcom/sm8250.c
index f5b75a06e5bd20e00874f4cd29d1b947ee89d79f..bf71d9e4128873fd956750e71311a357d60099a8 100644
--- a/sound/soc/qcom/sm8250.c
+++ b/sound/soc/qcom/sm8250.c
@@ -210,6 +210,7 @@ static int sm8250_platform_probe(struct platform_device *pdev)
 static const struct of_device_id snd_sm8250_dt_match[] = {
 	{ .compatible = "fairphone,fp4-sndcard", .data = "sm7225" },
 	{ .compatible = "fairphone,fp5-sndcard", .data = "qcm6490" },
+	{ .compatible = "qcom,qrb2210-sndcard", .data = "qcm2290" },
 	{ .compatible = "qcom,qrb4210-rb2-sndcard", .data = "sm4250" },
 	{ .compatible = "qcom,qrb5165-rb5-sndcard", .data = "sm8250" },
 	{ .compatible = "qcom,sm8250-sndcard", .data = "sm8250" },

-- 
2.47.3


