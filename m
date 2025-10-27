Return-Path: <linux-kernel+bounces-871405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D312DC0D27B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D682F3BC89B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 11:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95292FAC0B;
	Mon, 27 Oct 2025 11:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aSg3R5sA"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5696329B8DC
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 11:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761564693; cv=none; b=WbJgoX/i8U4r4HSHXlcRnumr7XcQ3p0OjCAVkAs8kj/eMOCIna0v2aQlhzMpC70/fsoD1FrE7q89tHOZ+gmOpNqN6flbs3aOEKfyRs7jYpQw7+PVYvf5gs9MBg/q7waUB2O0X/lT51P55HhWpKZfzr/I/CRHYr7XrVViRww2c3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761564693; c=relaxed/simple;
	bh=LHPhOV0gpy6e0X3PqYPMlaEtQLXlGi+UHQ9Bc94bXXI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XQGcWuxRuzt6841tltr+6WPkcvhoT8962eMZ21A8BFX3qhGVjNoid1jUJ70VYBfxuPLxLP0iVjUORgHvQ4VAvG3b/3sRquLMssel7S2003uYLdit+PXKWztbVAxTTsKlXj78lAmzS607e8I2d4JHgF3+hmEo7yPXKyCrbjS5ME8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aSg3R5sA; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3f4319b8c03so625534f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 04:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761564689; x=1762169489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gkdBVE0BY9SVhHYsmymJ7t9CcB8wdxkdpKo/Zx6qBfk=;
        b=aSg3R5sAo6Gr7VQQbGOTTJz6FAZIhiQ9prZGGoeuV9ELd4fuJqDKSzuH3Mq741Ta53
         1N/L74M+W2UGdZiTyt7DQv4pf80BeVWnKNZGnIVxRzkykpIFamY4ntE/8usF5OP9+zit
         zTPndRNME7lhUYkbZ5e8c+WCnVJB4AAAaFXu2GdeqZCztn6wlf+I7pectQ8/rmL1y3W/
         8NxdEoRBYirL0/Su5MwX5hhHqK8QcFRrrQGupK2vYfaMLab+Fn9R30Q8layQrXL31mZ8
         AxP95kZ0xDraV4AjITG8Z9mul57OwtiBKIqS7gKpknF8FIKxlucYFVcGYf/vRScjPGlP
         zDsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761564689; x=1762169489;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gkdBVE0BY9SVhHYsmymJ7t9CcB8wdxkdpKo/Zx6qBfk=;
        b=u/hXE4zINX/cfx8CnhLx72Hu+uWxPW+2vygFe/AtaW7lgdYeMYg+rZnzAneuyFZPJJ
         QF4jBAGHP4+QKSthCgpsbJTcWYqy40zN+5/+DAOfsGKbKk/7wLGi0/eNJRGaM827yEnS
         cqEHQxe/H90NY55m6UaEEWnzlWIdsKR7MxKnIW95T99EXxEpB0o2T/Cyf7QF+hwH/zZt
         SW8rYeOL7NUPZu0V49b4UQwCOslSTme3OxFiBme2XNzYkIJ1teidYmoBw9Xuv/dEkppg
         srORFwMTMUWK5BUg3t4oM/tNwu6sOBiD76BRS9KUNaQ4/jwvYJksy89eBBYQsX5cSl+s
         hoLw==
X-Forwarded-Encrypted: i=1; AJvYcCU9kHz7EPtKOH8qDKvJrVhGudNWkz+XLU5avD16fwNK0w7wrGMTUtDLaGSTKZoY1ga5IMlADOC7mpEeGXg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPYtxvovaNU/oQkHzv6AH3B7FV59AxAEONEgRogxB0hhlcSd9/
	8adoKue3Qq7iGCLXaDoSRGSAykxqIiPU4M+K/nRnaBmgxGO2AG84tI01giPJ/epNWwE=
X-Gm-Gg: ASbGncs0m+8hfgGlTOW7gsl+ndYE+ppFrxBavjzsLGCt4tux1KNXDGXn3avie6fGrRI
	sI1T5+kEcAzXHTQe026kTjn4UCh3y8g6SlfOxM071ybRDdY5AtZ1POw2ZHoZ//sveSpCVyWzIFp
	G3JvZMar7a0J6FkT6m0hqeaEpHbhCm/kpXdFzkFgk2Qr61TglHluK+3IzVftP165EwtQRNc4h/j
	91fL+3MAs6E4dx7ynFMgcbx7zoOO4TaOslAYXh91PJ1pF2uOnSxWM42EqgGgeDie4B/mbQ6nBM1
	tnzsAEzedYSkaRPj+kW0YX9pumnSt0pLMeknv7s/eBrYP0qMB3W3KPviBVKRnCe0jpyrL9bxixo
	sIrBYLu8SLnOJ+AidRtqcWVLnSjeZWoaFNp2FbeExjN0UpafNVYCjQ+lWbum7FnnINzfZr7/BzT
	KmKd0O2s3PvqWWQOFv0KaDnA==
X-Google-Smtp-Source: AGHT+IGz6GD3y6+cDG8Os4GrrgdKI9eH0xfE/xqR67GYStPwZccvbqYVtGigldNSOQfDk9DvMczWPg==
X-Received: by 2002:a5d:55d1:0:b0:426:fff3:5d0c with SMTP id ffacd0b85a97d-4284e531afamr8104494f8f.1.1761564688605;
        Mon, 27 Oct 2025 04:31:28 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952e3201sm13885403f8f.47.2025.10.27.04.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 04:31:28 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Avri Altman <avri.altman@wdc.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Andy Gross <agross@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: ufs: qcom: Drop redundant "reg" constraints
Date: Mon, 27 Oct 2025 12:31:08 +0100
Message-ID: <20251027113107.75835-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "reg" in top-level has maxItems:2, thus repeating this in "if:then:"
blocks is redundant.  Similarly number of items cannot be less than 1.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/ufs/qcom,ufs.yaml | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
index 1dd41f6d5258..516bb61a4624 100644
--- a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
+++ b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
@@ -88,7 +88,6 @@ allOf:
             - const: ice_core_clk
         reg:
           minItems: 2
-          maxItems: 2
         reg-names:
           minItems: 2
       required:
@@ -117,7 +116,6 @@ allOf:
             - const: tx_lane0_sync_clk
             - const: rx_lane0_sync_clk
         reg:
-          minItems: 1
           maxItems: 1
         reg-names:
           maxItems: 1
@@ -147,7 +145,6 @@ allOf:
             - const: ice_core_clk
         reg:
           minItems: 2
-          maxItems: 2
         reg-names:
           minItems: 2
       required:
-- 
2.48.1


