Return-Path: <linux-kernel+bounces-815755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBEBFB56AD1
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 19:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92ECA17C729
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 17:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7A82DF142;
	Sun, 14 Sep 2025 17:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="CF7mrgTM"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C0E2DECAA
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 17:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757870185; cv=none; b=OSDadUjiPzDuWgYkBQa+BZRdC6C3FH2OuAwEIEotNMOTkZkLE8VAAg65Atmyxh73AyTAU5/eDDDu24QSi0tgzNbHZeVXp5CuWKdqR8y2nImBCQC5MH1fWpBIIN5xMnyjFZGs1YT3Hytw+nfujPrTTUavAWjdnJrLLhSWxPtHG5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757870185; c=relaxed/simple;
	bh=RJXStlwzS4+/UQXUO3hnO45i3KP2svoFAvMb0SbrmwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TwLOOaW0501Ip+aTxj0/NXbSZ7q72GAv6yUmOtyl2K4/I+22Cy96kHCtUIsNDFmtsHa7qLTVAYp7cFQnrjuDvjWmBe2dWJv71AjoSK8FUfvv/3YStyQ9A+/szQE1SwwGXgOm+RGb2iDJZpvBJjcMeBY8jr5tV/b70FPD9dJMrqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=CF7mrgTM; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b0787fdb137so511049466b.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 10:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1757870181; x=1758474981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WMdgI0iZ2TvocV4JZ7DyZgorR1pQL3heQi0CeqfMARw=;
        b=CF7mrgTMDalZ3SCRHrEyOUgyTsYwPAy+4kpAHCl27Wnnrgm62ESOw4PGIK15JJy1g4
         Yxv+FreXh0s7xbb99bAbtIXu+RG0Nq+ORO5LAVOfvhteDUojSKyeh1zYuI0kVGx39Qhr
         AnP3Fn65Nv0oGyGZWCMVB1fhA8XG2JRmO47AM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757870181; x=1758474981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WMdgI0iZ2TvocV4JZ7DyZgorR1pQL3heQi0CeqfMARw=;
        b=R+D1jQtLfnoybkN3RUxBpW3S424wgirgGle0haUcZt/qZpydOt3zuzG2cXMU1GzMND
         IQgaNC3Ong9Wq55M9nu2yIVuv/HK906Orgs4k+bDp9fuC8LtndW/UQ90k7laOysXfmnr
         FJuO5QAzBkk5TKgqCFgE71iKxI7JGTuaOrw7BKwd8dEGeUZyhw1RvtBe76Gdo9qDMotM
         wcrg/86q7jqUjLyGiiHtv/CmRlkt7WFsIUkxtuYR0om8NQOWzPOz8SuKIsQ60ycheM6f
         r6RxBOHKfS8JdTNsBPq72sJB0O98t7BLZ4GStL80B3ZqD1zg3J6Fdk5UAOt+zDiqF8F4
         7a2w==
X-Gm-Message-State: AOJu0YyqmTLgob/cAZsS/P5ZbQLmqYvEG4MejmWqqtAszKsw3U4fORXB
	ehAOo9rtBGCt46Q40G+vfh2uSzh6cwz0/u5wdSDQ363hXOiOWhy0aB7CwU0oaGU9+TlCfQMmHZe
	CbUEK
X-Gm-Gg: ASbGncuT4GsBKt9jmeWmuzMsVTbs8KKlxe7ohG1d3VfDoOODVdfEAxZMRPchefR5jmT
	R3g/DiyTKvwNy0Jn2llQWDttc55TZjCmCALQwftg1znj3TQEVzLIt/GLhl7yvJKulUBqgxKABCv
	TQYOWCYVX2KAAKIvQsiHczTlvh26nXn38RTB0cFKlGkLzr5zC/PNcPWWW2xxwncJ1v4doPkB6k5
	sGB72JAcxmIhwEOCXqo2oe8bx/o4v+xT0lqgg3jc6fRHJ9Ca/ldMpvgZfTVmUxHUVTQN86agxwA
	7JAsVDktcbxJqVfRfMhvFTOGpCyhZBcqeLQWeEw4cwHGwqhXLYYrRUFsGcR4dkH+G4Ub6HrOjd/
	hB6NL0Lg82Yp2bVVugdB0p0CHe17fLz6Z5NeB31RVb55MtVlTUPH4h23ZbSLM6wpsZMNQ5lazbH
	X+kTtFs4FYG+gPpZ8vGyp8EsR8YbUGu03svZt2A/AJBugF92nsvl6+0b1NebCoRWoX
X-Google-Smtp-Source: AGHT+IHfjFWKG/mF8+Rc9t6eyI85z35rKOGB32yV2tBXoq5uOjqdENe0BpELyw7Da4eiS0RVUPNPpw==
X-Received: by 2002:a17:907:c08:b0:b04:3a46:c4f2 with SMTP id a640c23a62f3a-b07c383f1bemr990265066b.48.1757870181371;
        Sun, 14 Sep 2025 10:16:21 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-56-38-125.retail.telecomitalia.it. [82.56.38.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b334e76dsm776980466b.102.2025.09.14.10.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 10:16:21 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: Frank Li <Frank.Li@nxp.com>,
	linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-input@vger.kernel.org
Subject: [PATCH v2 4/6] dt-bindings: touchscreen: fsl,imx6ul-tsc: support glitch thresold
Date: Sun, 14 Sep 2025 19:16:01 +0200
Message-ID: <20250914171608.1050401-5-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250914171608.1050401-1-dario.binacchi@amarulasolutions.com>
References: <20250914171608.1050401-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support the touchscreen-glitch-threshold-ns property. Unlike the
generic description in touchscreen.yaml, this controller maps the
provided value to one of four discrete thresholds internally.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

(no changes since v1)

 .../input/touchscreen/fsl,imx6ul-tsc.yaml         | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/fsl,imx6ul-tsc.yaml b/Documentation/devicetree/bindings/input/touchscreen/fsl,imx6ul-tsc.yaml
index 678756ad0f92..310af56a0be6 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/fsl,imx6ul-tsc.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/fsl,imx6ul-tsc.yaml
@@ -62,6 +62,21 @@ properties:
     description: Number of data samples which are averaged for each read.
     enum: [ 1, 4, 8, 16, 32 ]
 
+  touchscreen-glitch-threshold-ns:
+    description: |
+      Unlike the generic property defined in touchscreen.yaml, this
+      controller does not allow arbitrary values. Internally the value is
+      converted to IPG clock cycles and mapped to one of four discrete
+      thresholds exposed by the TSC_DEBUG_MODE2 register:
+
+        0: 8191 IPG cycles
+        1: 4095 IPG cycles
+        2: 2047 IPG cycles
+        3: 1023 IPG cycles
+
+      Any value provided in device tree is converted to cycles and rounded
+      up to the next supported threshold, or to 8191 if above 4095.
+
 required:
   - compatible
   - reg
-- 
2.43.0


