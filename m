Return-Path: <linux-kernel+bounces-862710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 296BEBF5F6A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A23223533FB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 11:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7782F290E;
	Tue, 21 Oct 2025 11:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ko5PChQT"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C112E7185
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 11:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761045063; cv=none; b=M1EdraglXHDPr4ZX7JnJaazEUdW/CDB4APRJBtaZIAdKf9qH8vsRXobnaC9eu/76roL8zkhxrGZF6XX6STu5EOKjOeoG7G5CSBa/1VB5k++im3L+QEWEbxek7R16IAy+A1Cf/fX81sKAWPPvaVoDTjPtwm/n6+Zvmn6hPSTV60s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761045063; c=relaxed/simple;
	bh=rx99oBPed2XJKc5oyfumby0hPyGNK0fC4ws05bQ8ryI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uihxNtxztpyu+E/uMALReV4IvHdZLCpaKnMJ5Az4uqqezrtsfM6HFT5VKz+deeK35i+ZXkeMZMD0vKdQ6UJvHy447nWzdgTLb8b+0nTl1BkpuisGgapxhO+nny4ZOyp/WlXpO9M8VONZ+OZttTHQbiRS0cggzxW63l7qGMWUx9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ko5PChQT; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-427054641f0so805242f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 04:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761045059; x=1761649859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JZxh2RHqPkMdvbwb2L7q+GZUxl/+aVRyGR8X3MbWpuw=;
        b=ko5PChQTG5U4GLD9ym5HO0hJe6ioEBrROyasQr9lQHS+GJ1T5O4FFt5osxsGi/9jtK
         eTfnrmALGE1s0sdBEG3gJHnvYnHjViMnrG7GPOgco/o65Km5CJLiNL4yHLPJl5PnsWlA
         DonJSCwA1HdWMiKfrYeGng7S2H8vWeZbITW6bUxp3enH65HIYCvsLoJOJdYUX6m2cUqk
         JpiTmX/hj2J8kpan5PEmuxMSKseSV2p5u+fMhrcuDpongFenuDEJBA7oRQgBjq7jhZeS
         hVkurbMMTzNstBfufa2iX8RbRkMTPqAbiGRg0vKon8Dsz+JQlM5jENQXCdcuTTguNAXJ
         dG5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761045059; x=1761649859;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JZxh2RHqPkMdvbwb2L7q+GZUxl/+aVRyGR8X3MbWpuw=;
        b=PKIB0zui0sdICV8hg/mfkTY/SujgWqwIwJoFYmSzzbOZkH9gYA5CcfGww+8s7z+7tN
         e/KvFRZWKweCMOLyoaWds1jDNlc+UfP2C8X9UAPg2GOVgpEuCxMQ3uQktJjV1w7rUz98
         NvWLCpTVHv0FwVeMw4MXxy8y6rZ3ANlQOIefL+YpDmRq1OrIYbmUFV8ySxzcAyLiIS3j
         sty2MEY/+9yLsKGrolXLkd0+f55inQ57I7p4dYxT110EJzRwpaTIPaezlSU63i9PkdwK
         SyJzuXC+yjZAe4AjNozIZKThE7hf1A8ABVegaHyr7dbPm/ANiUY4sM0xuNHQd+i/znt8
         Lx/A==
X-Forwarded-Encrypted: i=1; AJvYcCXHg+qeQ4SEwEJHnNTjip7mLYMoV+L/+hfXCpp9JUhgydZ1+hXCQY46OTudukGu3I6CkpAsoRkmEr0kji8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6qJaf6KUdauwkkxYUZ/4tvaRKWGhnFqT1sZ5CvSA1C8aG7URE
	3vi2ImVRKjcLSAFsZcBcq54Gj/Cf6MXQR3dA1/VlUi2DoBdRKf5ORoBYulEqAGVSE/w=
X-Gm-Gg: ASbGncvzrHjg8wMbv32qdCYTaXvQLek7yr6BehyMdP4YIbBMa8w/W7yab7j9JJR7Bzh
	Z66fkUHkCfvWaRwEdHDjJllr0BizLEKALeY6Mf/OysUqcVG/TNQgJ6HfMhMfSOBA19LnaHHyLt2
	gRCvBzNqDsxlW9rjgZ25TEcocphTNjTruKqGG4jdP/298uDZQ/78daNT+NXYBtcZ6Jy9OHfH+ug
	AsPW0OcpeHDunYw+lLu5btK++qoRpXCU5/OWhwVquFL7aVz57AFbgy7c6FouSN/VMwyT3H+2+YP
	rlfYgE1Dp9HQab3+Uf+hCc5yCyCst9fvlEoY8KJS0UXlO7CAYNAnkuUQipl34SZEhG3dl68ALkl
	58I1+7erI1pehxNYtZLLKZvxfegaFG1LqHXwCKDfzEyNAhS5JeC7B8hGcZW0s6BujC7luhvEHIu
	QhJxf/4+PP+nAB1+yA0PCo7tyZRTgqqkY7
X-Google-Smtp-Source: AGHT+IGVDBYsOBdDa5NG0DSZa5Yr0ZnxdYzLYQZD37fgSLb7c/VmYVbHh3NUBKG7BjssK7ci3BmYKg==
X-Received: by 2002:a05:6000:2311:b0:427:52a:7ca4 with SMTP id ffacd0b85a97d-4284e52da1fmr1195908f8f.4.1761045059441;
        Tue, 21 Oct 2025 04:10:59 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00ce06bsm19510485f8f.45.2025.10.21.04.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 04:10:58 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Kuogee Hsieh <quic_khsieh@quicinc.com>,
	linux-arm-msm@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	freedreno@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] dt-bindings: display/msm: Reference DAI schema for DAI properties
Date: Tue, 21 Oct 2025 13:10:51 +0200
Message-ID: <20251021111050.28554-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DisplayPort nodes are DAIs (Digital Audio Interfaces): they have already
'sound-dai-cells'.  Reference the common DAI schema to bring common
properties for them, which allows also customizing DAI name prefix.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/display/msm/dp-controller.yaml         | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
index aeb4e4f36044..08c273f707c1 100644
--- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
@@ -198,6 +198,7 @@ allOf:
                 - qcom,sa8775p-dp
                 - qcom,x1e80100-dp
       then:
+        $ref: /schemas/sound/dai-common.yaml#
         oneOf:
           - required:
               - aux-bus
@@ -295,7 +296,7 @@ allOf:
           minItems: 6
           maxItems: 8
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.48.1


