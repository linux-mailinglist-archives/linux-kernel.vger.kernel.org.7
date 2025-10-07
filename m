Return-Path: <linux-kernel+bounces-843688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47684BC0005
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 04:04:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 314F0189AD98
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 02:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31AC1F584C;
	Tue,  7 Oct 2025 02:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P6dMf0Yu"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597D120010C
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 02:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759802624; cv=none; b=P66JHmYJ5mHYC3TAoPbycqDR3BHItCWvC7IkYkhkn+2y0NVfbvezEQR5zxVaMA8BrHlYf7g4X7R9c1yjr3h9o3hXDGQ3iH+6kZgDAZpIIkbyYrjuMsxoBRKnh0jWYxCvA4ia73COXYtF3P30c/hd0d8sX/IaVZL+7GO0tvkpnds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759802624; c=relaxed/simple;
	bh=VXDNFmwIX3pmm1RNqu8UxbDnHVOaIoAOH+SdXHl9U1Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=reo4aZRucJ0WtF8Z0ZdS6tLRLc0d9mUadLS7QT0aOIq7f3XCNUFB0m9/wMUGhogMgPbEaSLSe8LjriLLgElSNavp00Zt3+GSyPBPcVvBujeoMEszg8MTJaN6GsAYxQe3a9MOBKh+PRiiNLkyp8j4q0s8YBGuLJ8X9qkqf7k9F08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P6dMf0Yu; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-368348d30e0so52887751fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 19:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759802619; x=1760407419; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UvT/TglfcrWJfggrZckfEyOiFactKbMJClmt0smjuQk=;
        b=P6dMf0YuELYRqNoGYIgZr84JxxAVk5xfCM60fpv/wntkCGGjJRbz0GpMtMsyyT7nqt
         hb7281rzJ5JEiAFLZU98m58tKKI8qLOt2vLNpGfXH0i6Pc+OaFY+ftqOwTO8GZX78UL0
         cCemFH3UOfBS4YCAhL16qgA7Vg2DneehwLf0zbzd27cwCVs1S+VzNNTXm5fPjEv5W+la
         yPj1ZSsMzENWwD2rEwen19VZKnitTzJT6aF0AvyXp60pmtLkWW3kMO5iUNZq50BhbfP9
         SP8lGUy1+Bk00QjoERJQH3ST5L7TEAscuD217s3TQE4b6DXOxFSo8EYWrsDn4IG6baYY
         kRyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759802620; x=1760407420;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UvT/TglfcrWJfggrZckfEyOiFactKbMJClmt0smjuQk=;
        b=e4gH3q4LLR9tOZTW1EsNY3VN5kG0ix9nUih1L9e3+qgviAf56392ownaGmlc+ZAicz
         YrJzT28m2XrzYIfAw4rFRZUU9Df+Y9Bg8FKJSViCIfv87H7HIBXO8Bdh7F+SOa5qnTG3
         P/GRtgut+SdN+bVcH6MOvrrxdayFprceeqmhC3KlyJvFVqB/kuQSAvtLXbMfr50ADwHj
         tV6EcD2pQj1drw3iAwyaIp2lSd6UTEfq2sVLJ0AdlbUrdeL2+v0aE4nzzxocsbbJVjtW
         ywoJrP5vw2jqILCWDVd0LPyXIaEhLZ2+tXkSJ9AUUQLmBuc2Iax0rQVcDnFBAaZOQt+7
         Qo/g==
X-Forwarded-Encrypted: i=1; AJvYcCXO1yB5mzZHpJ7Kd29BIikVROTMYQT+t6wlIKQneeJZIsakdE8UjDQYg0R7FBDPRLEJlOPOcTtTbgA5yQg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMerJvVvs8DWSbg8+R+YuDdK31Nie9In75medym4Gh/1XaG8VL
	LYI50RvxNt3DdhJsGHJ6+FqmHNo04Q156tmKeA56zHDufZYu9DvNIF2KId1ltdlJKpI=
X-Gm-Gg: ASbGnctETMKI4nacfKekd94VqkyBBS8PS8ju9yNr2uWsy1hkLlfO1W3kNLAyOjW3xT2
	AoQMAKHHyaZrYD2W0Lcu9wVSdHE22uc7tMVsNSGpqOard/VvXNUVF/r/HqlkxUl1ZdBrou4N2Gn
	5jD30wWJ5zdaLZ0ADXQtOjtJbz4q9BzJa6Anjl3q6K1VqEi50BGQ1NfIl7PSF29fQKE/azMSN6r
	t1a7abTF7bber6CBbMlnITVGlrY2mOsH6wYYNP0V2I3KJjpwqazfXgwKCZlLWRKdXHTyZsrti9d
	4sZURrsRrOXINUh8q+6Ah+tr5Ckny46lMMcEaUs3Jg7bkKaSDzHEFPrcbbXMuWl5xJKtqIH9ivo
	Yy57PWBNF7ycghgbJ7O500PA3/2t2T9uxaNpNnjNWP5xg2q6Q2CoZBKtKN3YJo93VctM=
X-Google-Smtp-Source: AGHT+IE6kE+08lGifMlbSFxL63V0GVp/y1UlrRZI3ChDCaIR4Mc4TOIHRtBHsz2zClThQzzpsuDRMQ==
X-Received: by 2002:a05:651c:1992:b0:372:9992:1b0 with SMTP id 38308e7fff4ca-374c3823058mr35559001fa.31.1759802619600;
        Mon, 06 Oct 2025 19:03:39 -0700 (PDT)
Received: from orion.home ([2a02:c7c:7259:a00:22ae:baa0:7d1a:8c1f])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-375f3b81e45sm5150391fa.46.2025.10.06.19.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 19:03:38 -0700 (PDT)
From: Alexey Klimov <alexey.klimov@linaro.org>
Date: Tue, 07 Oct 2025 03:03:29 +0100
Subject: [PATCH v2 1/4] dt-bindings: pinctrl: qcom,sm6115-lpass-lpi: add
 QCM2290 compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251007-rb1_hdmi_audio-v2-1-821b6a705e4c@linaro.org>
References: <20251007-rb1_hdmi_audio-v2-0-821b6a705e4c@linaro.org>
In-Reply-To: <20251007-rb1_hdmi_audio-v2-0-821b6a705e4c@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 Srinivas Kandagatla <srini@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-sound@vger.kernel.org, Alexey Klimov <alexey.klimov@linaro.org>
X-Mailer: b4 0.14.2

Add a compatible for the LPASS LPI pin controller on QCM2290. It seems
to be compatible with sm6115 LPASS pinctrl.

Cc: Konrad Dybcio <konradybcio@kernel.org>
Cc: Srinivas Kandagatla <srini@kernel.org>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
---
 .../bindings/pinctrl/qcom,sm6115-lpass-lpi-pinctrl.yaml           | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm6115-lpass-lpi-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm6115-lpass-lpi-pinctrl.yaml
index f4cf2ce86fcd425b7522918442de25c836bf24f0..ec1cd684753ad22050ae349a2e7acbb2545a9070 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sm6115-lpass-lpi-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm6115-lpass-lpi-pinctrl.yaml
@@ -16,7 +16,13 @@ description:
 
 properties:
   compatible:
-    const: qcom,sm6115-lpass-lpi-pinctrl
+    oneOf:
+      - enum:
+          - qcom,sm6115-lpass-lpi-pinctrl
+      - items:
+          - enum:
+              - qcom,qcm2290-lpass-lpi-pinctrl
+          - const: qcom,sm6115-lpass-lpi-pinctrl
 
   reg:
     items:

-- 
2.47.3


