Return-Path: <linux-kernel+bounces-799037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 951DCB42626
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 18:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36EBC1758C9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 16:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7462BD024;
	Wed,  3 Sep 2025 16:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eqr1k+Zn"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B8E29C35A;
	Wed,  3 Sep 2025 16:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756915318; cv=none; b=HVItg2QVy/O92uVYs6YT/Rwd0BHqpL6RBvCCCGskT6gw7g0qScaayEVOG/sf5+L1lU7YzUnhzR4aE9U7DIKMCYxgtqjVt/BXQe8egR91FpMSBRVNv712DXFzbSAVHgH9qnRfLx61Fo4UyK4EIgzVzk79+CTXGcF4FWJegor6i9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756915318; c=relaxed/simple;
	bh=Z0Hjancctt0ilndRr3zD7NOgxn+UNXU+BwjkWHrEcpM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qAXc/9Ki3lQmuKl4TXJElYwLqB0WKUOPE8dopM5teiFiAVnmbVbDSTCFkTVQRhXAO8orJbxU/oj4q3HZCG0VsQ3BlCzTGhBbg55Gdf7vW5nByw7GQCN2CXdzq9mjotgoVKgQ5/xbY0ZkJRvyQsw9Cs8hEz5l697hUSi62GGHuRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eqr1k+Zn; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45b86157e18so813785e9.0;
        Wed, 03 Sep 2025 09:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756915315; x=1757520115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HNeAhhuUFQT3U8NdFXCzWZ3aUxmWc6RHuaI08sj+6zc=;
        b=Eqr1k+Zn/3vbDC0ZcG8su9q6M0O5ysxxaQm9cB8YiO9z8pMZvH83JPNszK8KFLaKWb
         31Ml/6X8foHYPcXPngjNhwz0CbIw5SM4Z7SUfaEQZhiJPHpfY3uVWcXeggU5R5pmSEWz
         p5ce3kitVNx4UJfN+KOJzqBLWMpMaMqwRsNt7hPraPEthy33M8qEYFjvp8j8Z+12Nmbc
         gww5x5ZHMl7ZixixaTEci0KZOL9iczc8aX+3AvL7YXMKJqk//Oi5LYnpe8lL7d3+ms49
         ntl5AYOCVDa6kJtV0NPQ+ibHpo3k2mZRNAN1aT04LfMqyq8q85SypV3w0ecRFdakxAeJ
         CJ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756915315; x=1757520115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HNeAhhuUFQT3U8NdFXCzWZ3aUxmWc6RHuaI08sj+6zc=;
        b=jb7vMLy/kItZ4Ux+xYI6BgneZuFthNqNkpyaQqfd9d0YKBdxruX57MfPFeuc0OUidz
         rbfvW9Xp/jEsfgadpq/ZyVX2P9894lbRNAcbthtri3w7DYR3kWDefSuA20/uR/Np3Mmd
         ean6O+XKnmai5+D/dZbx7OjTlzQB0N7C2e+HqwwvXOGNWMmIxOQOOIEyjTMQMv/LJr5I
         H21g4yzBGMfm6BWB4YwmYfzz87Y2GEakERmFfvyev8cVgTgm0VDwtykyjMTsMeoGfhiV
         Flkli9v4JgXmZ58xhSQGGMNj+PM3UM5eH9lEx4aSVNzLL13uxRFvNy0yftYO63gh9ADu
         Jxug==
X-Forwarded-Encrypted: i=1; AJvYcCUWL0kiCuYqBSKtC5G42CygPQrzTFGrrcJVyKB8i3WagS/qCcjfU57WwVyrVAP8y2+yB7ELK1rhtgRp@vger.kernel.org, AJvYcCWVtybLiOSZ+adTNjhyr6Ce3UHAKged28NEwsanKbKcrfM8M57s/KP7Yb3zYPwgMsnKPcGb+ITizwV7ii78@vger.kernel.org
X-Gm-Message-State: AOJu0YxY6Oqo/AxLpI4gYz/sB2Z9BScEgDst8wkQYbO+ah3DMbHHAXkd
	ciMM4y3lEMk/CXEaj+rWxQ6tTfIL2CkW63ZcNWzoEdqdMgzqCa1L1ArPc+fK3W8=
X-Gm-Gg: ASbGncsTcYulHmx6wr7hheePH36CecSxcWttRJuCcz+pMVr7bnCFHqsKM4tKJ3hogxn
	r7k5M1hRkuJ85GgixV6tKMIjgPcSvWZ7TU7pqNUBsvBwFjsH67YiWom2YZjdw7aEVhgZnKlpJnw
	QaLaiqL4o2FQzqy2W5axcM+/+BmOn6+W2jQ4sj1VAlWBOt5N2dTTkqN97vXcBrW8HykTmcm8FQK
	zEjUAvIZZzxDCwuZkirOKZJhYiVHHlUMRGo6rHVZYz+vWDgqHIBDJvjXwEVFjN98NNnMPWnw6P7
	esMcAvVottIlWLHhHpEoEe/PB8VyFpWFveVpSfIxvZqFj2Wr4dEuDzkul+Z7hKaZ6632e92H5+/
	02WCpktHBPQYeELvGi9r4h9c4Km/WMbAqF/7i+3BgOwOpvFPowxY=
X-Google-Smtp-Source: AGHT+IFlFHmmdAIMOqIU1iQyGrxZkybaYxwUD5vZ1gAoOdHYMLqloZC9BUWXp4jHfGP/T3WGec9m2g==
X-Received: by 2002:a05:600c:1c8b:b0:45d:98be:ee95 with SMTP id 5b1f17b1804b1-45d98beefd5mr5063495e9.3.1756915314649;
        Wed, 03 Sep 2025 09:01:54 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:e487:221f:e1b9:d63e:6ec1:3551:61a6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b8f6cd502sm61672745e9.1.2025.09.03.09.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 09:01:53 -0700 (PDT)
From: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
To: linux-sound@vger.kernel.org,
	krzk+dt@kernel.org
Cc: lgirdwood@gmail.com,
	broonie@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	drake@endlessm.com,
	katsuhiro@katsuster.net,
	matteomartelli3@gmail.com,
	zhoubinbin@loongson.cn,
	KCHSU0@nuvoton.com,
	patches@opensource.cirrus.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shuah@kernel.org,
	jihed.chaibi.dev@gmail.com
Subject: [PATCH v2 1/3] ASoC: dt-bindings: everest,es8316: Document routing strings
Date: Wed,  3 Sep 2025 18:01:17 +0200
Message-Id: <20250903160119.83625-2-jihed.chaibi.dev@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250903160119.83625-1-jihed.chaibi.dev@gmail.com>
References: <20250903160119.83625-1-jihed.chaibi.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a list of the es8316 pin names to the binding's description to make
it self-contained and improve the user experience for board developers.

Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>

---
Changes in v2:
 - Rephrased description to refer to device pins instead of the
   driver.
---
 .../bindings/sound/everest,es8316.yaml           | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/everest,es8316.yaml b/Documentation/devicetree/bindings/sound/everest,es8316.yaml
index e4b2eb5fae2..81a0215050e 100644
--- a/Documentation/devicetree/bindings/sound/everest,es8316.yaml
+++ b/Documentation/devicetree/bindings/sound/everest,es8316.yaml
@@ -12,6 +12,22 @@ maintainers:
   - Matteo Martelli <matteomartelli3@gmail.com>
   - Binbin Zhou <zhoubinbin@loongson.cn>
 
+description: |
+  Everest ES8311, ES8316 and ES8323 audio CODECs
+
+  Pins on the device (for linking into audio routes):
+
+    Outputs:
+      * LOUT:     Left Analog Output
+      * ROUT:     Right Analog Output
+      * MICBIAS:  Microphone Bias
+
+    Inputs:
+      * MIC1P:    Microphone 1 Positive Analog Input
+      * MIC1N:    Microphone 1 Negative Analog Input
+      * MIC2P:    Microphone 2 Positive Analog Input
+      * MIC2N:    Microphone 2 Negative Analog Input
+
 allOf:
   - $ref: dai-common.yaml#
 
-- 
2.39.5


