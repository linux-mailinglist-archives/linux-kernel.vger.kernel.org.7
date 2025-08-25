Return-Path: <linux-kernel+bounces-785671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DAE8B34F5F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 00:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 312B21B2607B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 22:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B484D2C0F97;
	Mon, 25 Aug 2025 22:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HUxXQ1Ce"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE5C2BE04F
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 22:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756162642; cv=none; b=WSLBYBM5IzKD4VruDPbjtTEYiZ3yw4ksb5/iGyDwP5ZJGsPzdiAKHLIP+8NXHqk4zZK5qV4doLNCqesFCFxZAMRp4nsQCP8BeRU86mY6f4zvTeAZ/h/O2DemogtY7mr32FnPm1QAx8Dvt9RAIEYo0YiZzePWqzzWOUFi7cGa4Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756162642; c=relaxed/simple;
	bh=n+eq93EFZerFCaRW/YU5rAe56h3L7pAing8rZOS9aIo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HcZaa5fBkq1/a0uuJsh3xFCLhqXBbyib1nUfbytUyB4yJG7cJnZlaodpSXrHsKOxVuKwBp52pDV4Whx3ejIA6JeFVYc2KLOrHHWuTBpr8974/rJfUqMcpZkRPoDd6AoRk/HJ/owF13HM+PNzFLK0Sy9XWG4/3RBkWKczCy+DXh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HUxXQ1Ce; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-76e6cbb991aso4287176b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 15:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1756162640; x=1756767440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k5YulMZOBNM7qvzrKYRTd+kawswMfatbXk3R7yzHh5Q=;
        b=HUxXQ1CexVBNSb9y4pxOc2hUVIgVO1IolJw0d6JOodexjFPanShGn2aY3ym2SqzFHQ
         rVQmL2W+7HGeegKJ8LcHW/S/rpjQrWBMtZS2rGz6c+J7+Mno3t97mEatKZJLjsWNk38g
         6OufbNk/DuvaVKAgTFv8HY8x4B4oop6815FgY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756162640; x=1756767440;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k5YulMZOBNM7qvzrKYRTd+kawswMfatbXk3R7yzHh5Q=;
        b=FucSyWIbfTguNAL259GNw4CD3hQraEa9MKgQWjA4M/VGZH9eBN4kKr/0CNKFg/vHg5
         BvBPOBYRxFZyXlOPgs75Ptc7VG7iMtLY1nTU4JBYgQvHq55osTznYLLs9yPi9qenWzdr
         hEiChQhX0NWMcawulV1Lw8Os34mF9v3otFumpcfWwWrZKBmAPuKi5NL6J5saF4JuA+9E
         ocdMYGau9OviCEbRVzxvvH8Qb23WUoqe25IewVZgIhoPy3xQlX/ycBwqBuL4SkHmwnh6
         d5XJ4GdMHLInZ5KUcgm4IKfaaLwX5pd6bd/u2naoQWr+6OoeB7iymQQuzjtnO0RCwVtm
         EX6Q==
X-Forwarded-Encrypted: i=1; AJvYcCU/K3DM04yEyFN8FJ9ACqPIZ/iuxj6s0Iuv6xPwXwwosOEFsGbOD+En2qVkjTkqEDKBUdUAKJr7HbuVfJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi8hjpn1hFQyrf57obRCqbHQ16B59ApB0p5yUpLYlVcC0mqEXX
	4mpLxpnmw3Md7URbuZ/9jBsdmRm5x7/0+fRIZeqJC/PI89YfjqQEnKhQIcGkqPuTLQ==
X-Gm-Gg: ASbGncuCeHsfVRD0iI7jx63gr7U7TVZc1wdZ8P4xWjj9YgWn9XMqmQyutM/BxJQoUv0
	qObmk6CGtBvt3jxenDnt/uExosqwxijC1qaDKeCHNz9c1VGLeUghBrgOJPvs4ODngYx6aAxYUPP
	l7iJpwm9ev+6bgGbMlCi+fceeWrcNw6aMVAhhWlpSibNMzm7dHpPY4fGiApJKxbbTrcbS28ARJS
	zqrNDHcFlavo9yXApQ9FgFkCPrQcXYrY3N9Y64bTJkxH/8vaOB2ASRIb/AbFBQms4QCPC80SJh1
	DtgpFSn1IOrfizRatMaPraZJWoKnCxQ61tu0E/GKMqZIuBeEU/QxoCWwC/Nklifrbh41OIYROKM
	UbA5MzC1qvM2fCU+SboUvJ3TycG43TohzNBVi+YQrKrRzWnyQjE+SXrQ22kMcyQ07ltJd
X-Google-Smtp-Source: AGHT+IE+HIZBtyyFvl4JXHn3tOLjF4u9v/mAZN6MHNUlS7TTvkI/So/QqLFhw5/+roUTI74EBRpCWQ==
X-Received: by 2002:a05:6a00:4b55:b0:76b:fab4:6456 with SMTP id d2e1a72fcca58-7702fadbb34mr16821506b3a.21.1756162639731;
        Mon, 25 Aug 2025 15:57:19 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:230e:95:218f:e216])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7704fb69542sm6529922b3a.94.2025.08.25.15.57.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Aug 2025 15:57:19 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Georgi Djakov <djakov@kernel.org>,
	Odelu Kukatla <quic_okukatla@quicinc.com>
Cc: cros-qcom-dts-watchers@chromium.org,
	Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	devicetree@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v2 1/2] dt-bindings: interconnect: qcom: make sc7280 aggre{1,2}-noc clocks optional
Date: Mon, 25 Aug 2025 15:55:56 -0700
Message-ID: <20250825155557.v2.1.I018984907c1e6322cf4710bd1ce805580ed33261@changeid>
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We've found that some device firmware does not expose all the QoS
resources necessary to manage these interconnects, and that the driver
code that starts using them crashes. Leave 'clocks' as optional for
qcom,sc7280-aggre1-noc and qcom,sc7280-aggre2-noc instead.

Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

Changes in v2:
 * new in v2

 .../interconnect/qcom,sc7280-rpmh.yaml         | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sc7280-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sc7280-rpmh.yaml
index 81c3dff53992..5dbd0563ac17 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,sc7280-rpmh.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,sc7280-rpmh.yaml
@@ -82,17 +82,17 @@ allOf:
           items:
             - description: RPMH CC IPA clock
 
+  # QoS clocks are only valid for aggre{1,2}-noc. Some TZ firmware do not
+  # expose even these, so they remain optional.
   - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,sc7280-aggre1-noc
-              - qcom,sc7280-aggre2-noc
+      not:
+        properties:
+          compatible:
+            contains:
+              enum:
+                - qcom,sc7280-aggre1-noc
+                - qcom,sc7280-aggre2-noc
     then:
-      required:
-        - clocks
-    else:
       properties:
         clocks: false
 
-- 
2.51.0.261.g7ce5a0a67e-goog


