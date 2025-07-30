Return-Path: <linux-kernel+bounces-750377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B753B15AA1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 10:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EE625A31D1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 08:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A0F29AB02;
	Wed, 30 Jul 2025 08:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vt0W6Bef"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DF729A31D
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 08:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753864121; cv=none; b=p9TrMc2hBzEOWCOMP0IvhhnP0GVtYq3RGZXP1bExujHi+gs3ngBncindaFGycvDOcWvcyp4C9yXHMwJd7OT2Hzi1JvJKMMbke9Prg8AdfzLxTAnzo5H9uOT6eZOFhBSnOFq++c+Ybss+stSU5SsCTVfJ7VmF8eY7ARCR/Pqv0Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753864121; c=relaxed/simple;
	bh=sRcDVunfGRLL2yhvCf8uI7kfBchpKqxSbo/lblxkRDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eCtbNIW0SBjb8jfximLT3/suqwM5hPmhE/1jwS/rkchBo4bXFouXsrW3zyqOUEUsTI1GwLo+3lLvcYxGj7Hb/HbECxxtGEqYsEfXoGqHqoHiNW921/PhiAj6BogF9z4z0NLrKQ3kfGZHRwB71Mh9GcD/SPRyjMAlhf3URtVHSFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vt0W6Bef; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-451d3f72391so59397275e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 01:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753864118; x=1754468918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8pP62+ReuSDmrI/Nghq7ZWC049e64GpNNqSaJZ0ig0A=;
        b=vt0W6BefcsTbAnMuXvvIPBdfjMYTwKCGR2u2ZVV2Gl/qra+exmSbcHdDwlIOjIewlE
         8KOsr3DH3wJfoBsyd20rjUAwliAVMWsuks9T5cECiNCwaTDQ7/1p0IQbLnp7x/YOl8OV
         vkQy86I1N51Ct8hI+zMLdTLVFMA9nF8ndNSAhCWXVzqhD5WzDAQ/HBALQtBFcIiXFAWK
         hKkijdzzzIf7AHywUG1BfyS0XRjqKwGoEYRckO5fIE+WFcNVSVG1Plj1Kpqj1P02gNCP
         rhPtgxmd8uVZoFwSxomTB6L6HXyT8Znd4ARRW6nZ6LPGWT0GuZRnZHUu3o1PgOtcK/OG
         iW0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753864118; x=1754468918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8pP62+ReuSDmrI/Nghq7ZWC049e64GpNNqSaJZ0ig0A=;
        b=g4E866GFhxTWKgQioRLjEZcz+Mj2ZjZ5GL2t+Oj9+4V7c2cGmNrbeLpzgGO2NLoZn5
         V/fee/hXN6oRXTMxNvm3NSTXYIx+9P0DyJJOp7Zolkcw5yIp+udh5odRUM6WvIewjCv6
         Th7DnEpmyGKPI4n7V1fTHfMVnT+MkPj0F9jvNyCJP2JHwZulQ1nY2cfb2PmTuN1DXHed
         WsULQSm0V8sVraj8Jlb7aBZp6dXtZOBIDBODzO6E2X4suaiNVDCRFt03A7OKT+ZdTJT6
         /kwG13r6t3XydDAqcLQtoVTlg8ZAX9AZNOm7NstghV2BgEzGQAXKJkvCO5CWaQJ0xXd9
         DoFw==
X-Forwarded-Encrypted: i=1; AJvYcCUfgnnfge51qVADU2iawgn8E12uSL1QJm7vClxA7iM1Uu53wqgiX2XSsoHXAIhOpp2gYWk1Rk7q9nnGRVs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDHQsxAvGy+xf8wWCbbpGmTn303liBsdZABn1t84Mlh5Q2yEmy
	cb48OEJuyC9ldL9HVn1TeCoGUzAvnrlMEV3NgtaDTw1tJ4Hsuq3mQiEM3E+VoRo5qqI=
X-Gm-Gg: ASbGncudiWRIxMAgYcB2aFnVfe5UDqMmx7tnlcxmDNt6ez0/onrCVbz9huQsVeyRJ/U
	7274lOfKdvd2fPXxiDCZjG9Ji3RbpBzrbMf0lNemBEBIHV9uem7+jXjUnG3Z9IfUix+tbXDYX88
	YL47JVQpHOoCCaEcT6c3VqWY6j0FVBIvea+220ZNos9/dEOywJe4TpXNzRddnqnLQDi1U8dtrD9
	r38n693h+yWYl0JxSxvJ2oHUJ/UMxRtP4PtG9/sPnjpZf5w0gtEre2VA9WHUISL38P0YgdI6BLq
	xm4Sjp+USeZMTwmUugvZLjI1FlXdFb49Rkjypip00FLLTgJar1lrHX4oPsO4WFl6//IUDf2NDiG
	foY3/iB6KoDt7dLxdbPiLMpJUmK25BqRcUGrLUNXaRKgjWP3J
X-Google-Smtp-Source: AGHT+IFJmr5qdka995uu9nQqfsByhZWOAnA7A7dfqcdi1Sc/fyAe6HxceXMGyrYqD+09oG7Kh1IQtA==
X-Received: by 2002:a05:600c:348d:b0:44a:b478:1387 with SMTP id 5b1f17b1804b1-45892bbf671mr22918445e9.17.1753864117938;
        Wed, 30 Jul 2025 01:28:37 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4588d873f80sm41992125e9.0.2025.07.30.01.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 01:28:37 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: daniel.lezcano@linaro.org,
	tglx@linutronix.de
Cc: S32@nxp.com,
	linux-kernel@vger.kernel.org,
	ghennadi.procopciuc@oss.nxp.com,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
Subject: [PATCH v2 19/20] dt: bindings: fsl,vf610-pit: Add compatible for s32g2 and s32g3
Date: Wed, 30 Jul 2025 10:27:21 +0200
Message-ID: <20250730082725.183133-20-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730082725.183133-1-daniel.lezcano@linaro.org>
References: <20250730082725.183133-1-daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Vybrid Family is a NXP (formerly Freescale) platform having a
Programmable Interrupt Timer (PIT). This timer is an IP found also on
the NXP Automotive platform S32G2 and S32G3.

Add the compatible for those platforms to describe the timer.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 .../devicetree/bindings/timer/fsl,vf610-pit.yaml          | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/fsl,vf610-pit.yaml b/Documentation/devicetree/bindings/timer/fsl,vf610-pit.yaml
index bee2c35bd0e2..2aac63a58bfd 100644
--- a/Documentation/devicetree/bindings/timer/fsl,vf610-pit.yaml
+++ b/Documentation/devicetree/bindings/timer/fsl,vf610-pit.yaml
@@ -15,8 +15,12 @@ description:
 
 properties:
   compatible:
-    enum:
-      - fsl,vf610-pit
+    oneOf:
+      - const: fsl,vf610-pit
+      - const: nxp,s32g2-pit
+      - items:
+          - const: nxp,s32g3-pit
+          - const: nxp,s32g2-pit
 
   reg:
     maxItems: 1
-- 
2.43.0


