Return-Path: <linux-kernel+bounces-855209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C0FBE0847
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 21:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 89600507A05
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 19:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F793101D9;
	Wed, 15 Oct 2025 19:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WaQR0QkF"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C6630F94E
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 19:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760557481; cv=none; b=WMRy9rlxhXAofc4Lo3J7JmRFT6TTcPylFaPfeWRdwqeeT0+wk8vvlXSV/gEV6qsPoQPBub1Hz6rr7kr/51bLwkdWdpu7o2JhosB9omeG8CgsRidma3KCYUgq8M0l9Udi0HsWhqhNNktvmtEhuxkfHNn1Qie0KFNsBdAKXDFTwHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760557481; c=relaxed/simple;
	bh=Ovos97kB24kZOCw0iEoYD5BQRJ0nrfkGVhWD4gn4w48=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eXFvMsaSbYcbbicPHuvOH2jc9gu07m3WwMNxb2iZGWK6v1Eak68RLEwcyw9LdXjvH+2T4cnFcL2PpeaETEg3AAfV5WV3LmpXYLtCq12UCYWZYeinmiFwoWM0maPNQvLwgV7WJj8ZfyEa33hANdezTc6bK4iNzJlUOV0J1Cm7Yv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WaQR0QkF; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3fba2c43a16so187171f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 12:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760557476; x=1761162276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nVIjlBezqjwlP9ZoOZaGlXSxdWFyyZWMo+uLBCHG7JY=;
        b=WaQR0QkFUB22o6JI8kimLvvB4A3AffsyEYATtgctXLJDlAnHevN8FfDxNB2a7Y+qk+
         GdC0S6ulsfg94iOd2XaPgYi5gM1Pj4hlmLo8VSlAQG+CzJshA3WZMMOKL0EDjkPIbGRY
         jbJmVRjoqtcJSgg3WWs7TOdRGwYsP9O8f0eQygVEL5V0mbYQdDjgDHU6yLs2oCy1KW7M
         gjPVquPCq/SvKp1pHCqUBPtRQK2yFIMtaYx1KTlEqBX87VxI3H47iAuhkxX0ZQQCYC4+
         YiI+CBdyU4lmDM9Lv84NWtAT897jWRvG8w7FrmpwU7snEdH4NG3qW8mojGR+qg/fZEmj
         0lrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760557476; x=1761162276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nVIjlBezqjwlP9ZoOZaGlXSxdWFyyZWMo+uLBCHG7JY=;
        b=UTL3O5hq84pD4DFntTMUWZyNA9r61KR62FRngYDOqrNpN/LPcz3adu9L956DFOaNp4
         0JYx6VBJKD2WOpKOndvEe8osrQe0/iVW5DtckHa9qq4rdkNBrIdWTYTxLMi5M81a7SwD
         JQ+UzSKJxbF0k7qniC0o6j6BJlLJJWuo4bwSXH0AoeKSBAKhzuH8dekD31o2OInLG4Qm
         UTOPdNtcWpt85gINu6aqS1qQfAlse6cw+OYYkCtRa/bVaJ1wXn8oWSmY1evyUtLUf+z+
         9qo1jv6UkOIlR1c1ZYCJi/9Uqx/DAZD2THb6yAP8VRzoNTGvGu2Hd9ekF7473DjH8M4b
         7Fvg==
X-Forwarded-Encrypted: i=1; AJvYcCVrStcnteV/gj9g8LsrQsWlU3L9nyjEeocICaP6rO8RSmVnc3hNLBPkyInUcnqT1ICLwguZYFNcEQiMHH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB5B83+fNWJTOu6/5H9cboppWjlmZg3lKXyszRW8q30vvL8kRx
	zLTvWHkjBn0drVhjB4KegpDvCRORc30QPxb2knZ59dl6KDLVItgtjl0u
X-Gm-Gg: ASbGncvZrBGMuEATrBlT/oOP/bUynAlnzynf+ymVKwQJ8eoIMO8BIsQJw6uCILtXNWy
	uehH8hG0A27/qA075YQyDo8FiHb8nbiHCWQE5QfaNT0LDqi7Pn7LnOCWSsA65nVqzpdGwODzIvt
	nHovBF3ia4A1IOmNGDlJMBuoHzy7K84yh6WYqg2hXL4AYedRKx/TNiERZ1TcKFuTdft4vHm8pHI
	CAdqpQmftXg9Ro8aGsJHDbeXQxqwdHkhzDksKB0FepPbGjl/eeTXBVpEZ939RZeR2DX0QnOm6r0
	s5TBTkypO2/ZhF3w6MOZbkk7EGAlryTl/n89XTtw+4UIAqHo34y5NNV5aVlKJ7Wgva6N/1/6673
	jz1mBaD+M41dus6XqOIVYFAwQIrweviOsQqvpIX5VLJ43CF8Kf51q4Rz68OxjEbQnKqUreBjTUN
	hgtApP9048ShdZfwHYZFNkn1qI
X-Google-Smtp-Source: AGHT+IH6tauOTDHR+VcAhwFzraMEDMNNBSZcoJrb9benMQWyHWdHVYvdQh1SJMyTVrapg/9gVi7RVg==
X-Received: by 2002:a05:6000:607:b0:425:6fb5:2ac8 with SMTP id ffacd0b85a97d-4266e7dfc13mr10447114f8f.9.1760557476284;
        Wed, 15 Oct 2025 12:44:36 -0700 (PDT)
Received: from d25728c254ff.v.cablecom.net (84-74-0-139.dclient.hispeed.ch. [84.74.0.139])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5825aasm30291626f8f.14.2025.10.15.12.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 12:44:35 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dinguyen@kernel.org,
	martin.petersen@oracle.com,
	pabeni@redhat.com,
	rostedt@goodmis.org,
	bhelgaas@google.com,
	l.rubusch@gmail.com
Cc: arnd@arndb.de,
	matthew.gerlach@altera.com,
	tien.fong.chee@altera.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v6 08/11] dt-bindings: altera: add Mercury AA1 variants
Date: Wed, 15 Oct 2025 19:44:13 +0000
Message-Id: <20251015194416.33502-9-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251015194416.33502-1-l.rubusch@gmail.com>
References: <20251015194416.33502-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update binding with combined .dts for the Mercury+ PE1, PE3 and ST1
carrier boards with the Mercury+ AA1 SoM.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/altera.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/altera.yaml b/Documentation/devicetree/bindings/arm/altera.yaml
index 72cf04b22a08..73ba3cbff026 100644
--- a/Documentation/devicetree/bindings/arm/altera.yaml
+++ b/Documentation/devicetree/bindings/arm/altera.yaml
@@ -32,6 +32,9 @@ properties:
         items:
           - enum:
               - enclustra,mercury-pe1
+              - enclustra,mercury-aa1-pe1
+              - enclustra,mercury-aa1-pe3
+              - enclustra,mercury-aa1-st1
               - google,chameleon-v3
           - const: enclustra,mercury-aa1
           - const: altr,socfpga-arria10
-- 
2.39.5


