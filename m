Return-Path: <linux-kernel+bounces-873635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A03C144C0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 12:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B383A420EC6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52412304BC8;
	Tue, 28 Oct 2025 11:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FasfVChE"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF289212575
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 11:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761649882; cv=none; b=iIIppAykbJ70lRA/0ls6jb7BZItacgI4i5V/HTekA+9frWrcnp9PJXn7zoXafbn4QdMEKmkMbWjV8SPrtRPOqVuGTm4zoLzVpILlTy/zU3b8sfxF9PAaqt2hruB4wCm89t4RGVDphFPZQvh5OECPWs2my0R9trtFbsTD55tj2fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761649882; c=relaxed/simple;
	bh=4qzCYQcrCmvs1fI1Y2jGeN1q9TLaOaKK5NL7b0UxVTE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GTjRItanv8Lseilm3NOVje8s+GiMMrOwPpO2H39Otdq/WCNVKgmbcctLBwGx7bt59Un8lJAaN6eu0BMMiqkzPlDvC6i/1b/RaE4Gv7bYZ/ZmV5cSImQFsznM83dobPZCNgZRl3PRjgAd6CbpstTLS4oe0mZVQPuR13T5XVjE8oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FasfVChE; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-472cbd003feso4458575e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 04:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761649879; x=1762254679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NvBepMQaluNKHheiFuZLoEpaFoQ4R3PwHCfLsenXn0o=;
        b=FasfVChELow0zHK9NCh45bNPvfSrp0dgfoxwIPiRZjy3XQMxGw06xutf+9rwFL7vYz
         RhNHPbAtq9Y6dc0bws/vZhsnlGT3AwjxarnvJVe2fTsozTZ4bzraNM8jXfKhM8Fe1wXV
         FFRDALplmm+kMsZyxIrPF71Aoh+XtNkj31zAGBVXpFzW2IdoXBXH4/Qh29GWrJtXSqB0
         PJDNi2j7Pa6El818EAXatXihZ4+7EAa0klNyDKf5cA5OiZmFo2cxQoZBG4ol6pTW/lYw
         YXkgKoJrERa3/U6yhk/hfoEZAL5+cBQGz3vRBbos7EdynIsO22Xj+OJHbsJ1B4H8KnLY
         MFuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761649879; x=1762254679;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NvBepMQaluNKHheiFuZLoEpaFoQ4R3PwHCfLsenXn0o=;
        b=LlG2f+6AEQ/E3RjTKcrbC3l0xGOhTwB3s7N3n89Ot2F8UcJT6O6IpBi812GR0lDUSb
         qfSqeVS9vL9rSPtrSms+q/XXLc3s++wbAk7MObAPaM26EoQP+mHfaTPj4yC2LkT0b2he
         4nritOORRFziboeCBnKdYPIdVIvHvQHsxrW621KI+QFi7C3WFvl0YfwgM4DOHPQv2mq2
         oAsrfE7pihxjW3xEaBXrLTdqin8x66JqEkd9qLA6PEFNSQSI6R2zZjOM4Ja9wQnzrOdn
         y9H3InOHUpa9s7etRSpBYP6y34vLlmWxSqhcBRcRGrU88aPF2OJT/Q9jes58nXFkLL3v
         lJMg==
X-Forwarded-Encrypted: i=1; AJvYcCXA99IRXoQLSrQ5fiytp08JSCQQkYHUi4uydT2H7r3+d1keiRSBrBxGRCSE6vxJVd78cLbjJfSteP+/3eA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwRLL0s5pkBs5nuxyd/nZ75Jip1usy4sg73bYxH6uv4pziOL/W
	S9cC5Qv6GHYrVUVEkaQ80vGSXmVtf9GCxvwTCe4XZNiQRF2bq00Zpu7+pHXfEx2pH5w=
X-Gm-Gg: ASbGnctXHZ+mP5pAy1rs0MTUD31S8RHUI81DTr6N3mE3/8t0mfYeb/ZnuQYAORmzQLd
	M5PbyTw2XfqWBdxZD659bHrKs2UUgUijxvQI1l6+J0A64M4JLakISVQCEf9kG73IordLzjM/OkS
	29+AC7QteznHPsPgkae4lr7EJ1aFjvaoKcSTkiIKhEarGQwD+8LO8M37b7xzGk54Od1MJeguXHX
	5duPTQUAzqQKUVyqCLEs6/HJQEvuVx1jHuQyGP7diHmTpvi6SpJgy6ZA0L+twunWbb/sTXhWian
	lPHgF4hblqZEMTPcweUXAZibL2nWVPuK5X1tD6Gkih2iGKuX6L8HVGIkw3GtnD43yB3iAo0AJfr
	FPX9KtnzpxOlIW0bsuBUwGbrqDyw4On6BextqTiylDesX4WhCI7x46/WSPj5ywuiZ00qQ3OJPdM
	JXPmEtRhZdunH0xXqeM0zyxQ==
X-Google-Smtp-Source: AGHT+IGp17y0AcHm5V/8RFGmqH7SfEi8yaRv3lm/N2wuwDnD5uW4xhUCEWW3XzRmWpPyCMaaL9vIMQ==
X-Received: by 2002:a05:600c:3507:b0:471:1387:377e with SMTP id 5b1f17b1804b1-47717e787b0mr13605665e9.6.1761649879245;
        Tue, 28 Oct 2025 04:11:19 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47718fe6382sm17268505e9.4.2025.10.28.04.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 04:11:18 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: "Bryan O'Donoghue" <bod@kernel.org>,
	Robert Foss <rfoss@kernel.org>,
	Todor Tomov <todor.too@gmail.com>,
	Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-media@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] media: dt-bindings: qcom,x1e80100-camss: Fix typo in CSIPHY supply description
Date: Tue, 28 Oct 2025 12:11:16 +0100
Message-ID: <20251028111115.46261-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct description of the CSIPHY 1.2 V supply
("vdd-csiphy-1p2-supply"), because it supplies 1.2 V, confirmed with DTS
on the mailing lists.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/media/qcom,x1e80100-camss.yaml          | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/media/qcom,x1e80100-camss.yaml b/Documentation/devicetree/bindings/media/qcom,x1e80100-camss.yaml
index b075341caafc..b87a13479a4b 100644
--- a/Documentation/devicetree/bindings/media/qcom,x1e80100-camss.yaml
+++ b/Documentation/devicetree/bindings/media/qcom,x1e80100-camss.yaml
@@ -124,7 +124,7 @@ properties:
 
   vdd-csiphy-1p2-supply:
     description:
-      Phandle to 1.8V regulator supply to a PHY.
+      Phandle to 1.2V regulator supply to a PHY.
 
   ports:
     $ref: /schemas/graph.yaml#/properties/ports
-- 
2.48.1


