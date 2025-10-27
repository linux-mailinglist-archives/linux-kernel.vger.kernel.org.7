Return-Path: <linux-kernel+bounces-871912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 637B1C0EC73
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 16:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE58619C37A9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 15:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF771E1DFC;
	Mon, 27 Oct 2025 14:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ggSejgAb"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B728830BF6D
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 14:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761577185; cv=none; b=dGzaa0LpcAC3kSUvVhTGp7BWaYk4ri72wjRwvJuUUkiarIJZWGoNXI4NWUuP5ZfSOxHFosq8Bb1buFEVmNvMJ3opXo4BNaP+Q2kKdALIXwrBquZg9ctMJK2jzFwbq1Hihm8Z/n1ubR61sQrgYXJeX8iuebjFHIP43xzUd8BHzbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761577185; c=relaxed/simple;
	bh=MdFy/rEtddPgNfs1nNoPDNK3EzZtOK6/402QnuCksD4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EgKeRiZWlQ1lUdE/nXtqtnwyKuPrk8DVTZscbqBAfEhf9vXlSpQS3UDRe5L7G/BbIYksfcCHseAdThIcDsV4nbP3IZzTf3owkd0gDmxT9RYqPw9v5O/c7dSeXr7x/3E0eqT1DN+MPtiyIyHu7WVWog6tjH03R2EdPlqNqrlFjeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ggSejgAb; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4270a3464caso2277666f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 07:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761577182; x=1762181982; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qz/PnsLNKphGj4wu5t6w0DkX4PTYLFQZn42Nmg+SPjs=;
        b=ggSejgAbJfWX4fnCUmNyLk22iPyTvKUQWeK2LMZJbdCg+TF9p/OaM0yYttwWqlPzEW
         8Ar4AMzyhzBXBeazU2MlrYpI4vylmwbm+KCNPAgvwz/OZxOH90n9hvSBaSxR1gqOFl6v
         B26KZBLKt+vQyYXjySbjCKhvua+ODJ+a+YYeByBjjzvW4of4VnpoTCSKBSOxm5z5Az/c
         JT6LUQwXV7ijrWiqUBHIUxUQx2HfDPMRiZxFOc5WZdkAgJOoJqYBcIOM2wZWp8+A97HD
         feaaTFJDZtcAQxD24g+eFdgygOER/EhmjzS5XBBrMbeulAnc7jGPcH/F3D5kQXjIaXBt
         2OxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761577182; x=1762181982;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qz/PnsLNKphGj4wu5t6w0DkX4PTYLFQZn42Nmg+SPjs=;
        b=ajHpBlMIIdDGWidhk/LY9FWYzamUZmIZV4mcGf/m1dqUZqUrzA+zzuUu0CscCLeZht
         cRfc4sEgWL3zs8GnblQ+eZYsRb3JiUEpFayskjnDDByNTCNxBU1Va6iZWcT9z1nDpuFi
         u0WxwKU/3SvN15QVYoQmckifPzljTydvooUzOj7aX3P5pLu4a/OKCEpZalxIEGcgJJyP
         cPcjnplyeb/9nKfyrdzlwAzaXSSM4dyG7kbdSb5+NqxHuEzEibY+yJVeCKajKDvWYimx
         BB+30d8FrpJUwsSNJsPd4Nseg5oV2vzx9BAf1acpndshotX2gQd+JQ+Cs70vb/mn/tMH
         tVJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSUEMArk0BEMMcHkjjIzSxCUvpVcy+Ul+Cv66/Y1TSWozMu3z00pL8Ud2uiSxHV67bnaoQ1JI/MFU0bag=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw01OvEm4Q1C/JuKGred7Y+l0aBTsyXSLlP7GoRzAkzVg8LsV8m
	oEJ3rDPy3WD2EbHwjTwNBU1SHGeL9Pd//r2P4UsDVa0wI/ptqp6l3ARaEcZdKSdQbk4=
X-Gm-Gg: ASbGncvO6OttuwMOLHpp3c2aw1yBaIHJmEt/8GpBbDJc884CIJJ+4sFqgARoLLZgS9M
	0mKUUAYkaJPhbZduZt2OfD+WspRgPzSOg2FjMiLlDkQFaJZH9rWCNdiolPRQrrVqFwYBI8qPokR
	rhEVJIuC5mp5Smh+ojDg2ydUIuBBCHk0gJN75yrS6TdjxUhhEnjYCW6BQhWU8RLrChqhnqwq75Z
	zoYYWoUQEni2D86WhhM1AJI/+LBoX1O/Ym3NKC6gY6tx5Y5S1/Inxeig1sxZsv15h7fTWUUzKPU
	lCx6w9pbI6bbIM672nefLFsR7jO8yO3o+YBH6pG/UK/R5mZvzXohQQT5bZeqBfiJx9NYFAXV+no
	FCNd/OcZkAATLjlPlDOnaVSiW4eRCYPAaOefo3YdsMltLKHMhlWlni0DRsgwJ6h7NpQ8AILl3x1
	dEaAQ9N9bY7430j8kRK7I=
X-Google-Smtp-Source: AGHT+IHZ1yK3U3yLoTg48R/GGPo48EabRX1eTv4WbvErGehFypuSM3j72H7Y4kWByXl9POqbwjJEhA==
X-Received: by 2002:a05:6000:2913:b0:427:526:1684 with SMTP id ffacd0b85a97d-429a7e52f6bmr21760f8f.25.1761577182057;
        Mon, 27 Oct 2025 07:59:42 -0700 (PDT)
Received: from hackbox.lan ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952df682sm14624801f8f.43.2025.10.27.07.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 07:59:41 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Mon, 27 Oct 2025 16:59:20 +0200
Subject: [PATCH v3 3/7] dt-bindings: display: msm: Document the Glymur
 DiplayPort controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251027-glymur-display-v3-3-aa13055818ac@linaro.org>
References: <20251027-glymur-display-v3-0-aa13055818ac@linaro.org>
In-Reply-To: <20251027-glymur-display-v3-0-aa13055818ac@linaro.org>
To: Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kuogee Hsieh <quic_khsieh@quicinc.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1535; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=MdFy/rEtddPgNfs1nNoPDNK3EzZtOK6/402QnuCksD4=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBo/4jPJrs6Mwp34I2Ad0O3U77kUDk5w/G3R8kzf
 3wInFUrPCeJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCaP+IzwAKCRAbX0TJAJUV
 VkAtD/9nAvhuxwMJ3BBEh2tiRZWzt90TFdkB5yBTJWcG6+7Q0LBRD/olmatidL6r/FQunDmcTWM
 sCbv+VJT5Voj6Bta7FooqGBd7sBQTY9cNaZOTJboyf8bfXClhizkT6WrBVJybhtbLLVmi0yvUcV
 B9EBoZ3fxJHUUH/P88q4jkk/4reIEhxN8uqCN5f+iA3c9dU1JYzx6pJXJouGJTaMUYBs+5685w1
 Tdzwcw7dHa7t8QGEfYxlzDKHt5gRTGYfQyvVd9dBsa6ytuMWj5DfE5B6KpP4JDZN7X6GJGlOQAJ
 veD6SaN8w+waDj6ubGo6iV+zrgkCOwkkwVrS/S0rc9cN73+33ftalWvYIpZhmrjqh6EKKrU8SNM
 /7u7w1E2+j16HzlLCtuw+zP+/nDGPnzMJhiyJvOcC+2bmRoLrH22+tZnsNfSUz/LedVG1/fRpsV
 M/eagK1ys58BZrCCvwPJyIE8etDROmJ9+HGSScm1BueZlIK5IotiwN+4jBNUgfxDYtLFUZfPakf
 Rpl9TnNAEE0qjCofLK7gzk3DerpjtMzhdt8TV5m2QbhAzh1BYxr0cek7eRpIXb2tby00u3IKgXx
 2lDq0Sp2y2TQnrXi3QH1ITp0PgHKNqvOaH+jlYEMkmyBaDXCSZT8fa+NxenrkFd1NCS54C/7Bw1
 NOYUMCsivtUcn5g==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Document the DisplayPort controller found in the Qualcomm Glymur SoC.
There are 4 controllers and their new core revision is different when
compared to all previous platforms, therefore being incompatible.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 Documentation/devicetree/bindings/display/msm/dp-controller.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
index aeb4e4f36044a0ff1e78ad47b867e232b21df509..26f5043748c166aa44be4e62445a63106edf9578 100644
--- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
@@ -18,6 +18,7 @@ properties:
   compatible:
     oneOf:
       - enum:
+          - qcom,glymur-dp
           - qcom,sa8775p-dp
           - qcom,sc7180-dp
           - qcom,sc7280-dp
@@ -195,6 +196,7 @@ allOf:
           compatible:
             contains:
               enum:
+                - qcom,glymur-dp
                 - qcom,sa8775p-dp
                 - qcom,x1e80100-dp
       then:
@@ -239,6 +241,7 @@ allOf:
             enum:
               # these platforms support 2 streams MST on some interfaces,
               # others are SST only
+              - qcom,glymur-dp
               - qcom,sc8280xp-dp
               - qcom,x1e80100-dp
     then:

-- 
2.48.1


