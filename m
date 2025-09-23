Return-Path: <linux-kernel+bounces-829129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E47DB9658B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 16:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8738618891F8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 14:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5E9257842;
	Tue, 23 Sep 2025 14:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="O8TbWdkV"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AF51EE7B7
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 14:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758638280; cv=none; b=OHO8WDueolQMc2yi3MKpfQW2zz59P2KYHmDIjLAhT5MeSbBrBIuS5mIDUKJPcUSLIt25z+sCHdZvbagdZNqaINwMeRYbgKqzpkACn0mv5sb8bRx3A9AvuV2pWYWmxT/di464UQpvHx7QgjY02hU2Ix3Vj+CNpLDSfi1PQa+XEXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758638280; c=relaxed/simple;
	bh=IAi/8O8/rULM+WO/P3gj9Rt/deukKZIeTgVaOnY7B+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U0hkIOID/aRcBAG9ELKGPfQHpQnCkkR/5UhgSHdXfRsDXToFQCUq1PDKriO5fLEMGOIRgbE0zS6vgQn5oUzXAgo8BC1ayTi4XrM36Z0i6xX0qmZkIW0vdR1kSfgsyrjr7EthEFxr2eFnFOIwNdf82rmOk+yvS0jqhwnPOMsax5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=O8TbWdkV; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b3164978f11so76387966b.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 07:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1758638276; x=1759243076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OUcTQ2up2eOa5np9juHes8kBZBD61IeSVgwAmot8YUQ=;
        b=O8TbWdkV7XA9I12YiAcfwvbRarhww+y0EKzGH1gqzy2lyynkFi5ckxJ+Bn6bUTP5MV
         tOtaPawLMgAnYO+31lC/XpfNwyNhJV4M04b7wa3pwUOj5IcWDiWgCfJbvi+y/3/j33QL
         7jWyufzgkCEEz1pGociINjv5egzsHShdH2DzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758638276; x=1759243076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OUcTQ2up2eOa5np9juHes8kBZBD61IeSVgwAmot8YUQ=;
        b=m1sV1Dv5Ah948cL1yuOI+piavPjWcpU9DK/X84e6iiHJWyeM7P27PAqfpdFZYk0tmq
         njpaGp4RmgSrot7y5iE3ZQCLbxf5SEbK0Jvrb/8VX4zij3TQxwmwBwavPhDo/PMulq/7
         M8Xz9t5dgYUhAL1Sv/ec3RYUoAh4Rl1eZusQNmj9a/xKLLjUmr7sdr0MGksRnPbjq2Ki
         I/KHnttG9AbAUMCrWv9GPlvhwMq1PZkvCdRMSND3uH1PZj5GA62d8rRu52i5I7EkcY5J
         q1TNX7J7eMB8fa/sZFkqsUZyo9myeISIj7R1mMsoHnHfLRZck+KzWk+7SCqDWM7ydMdQ
         asJw==
X-Gm-Message-State: AOJu0YyZog+i7LvcUlsduCi+nIRKgFnmkccWOThDW8fLeJ4sNnKOTWa9
	dQjPcolRfO5wyH9gbZdQtcTdTxX5nWCKRSoS9B/DtwWub542/HafF5j5wVHQ/YxWaSfencNSwOM
	JXw/V
X-Gm-Gg: ASbGnctOkdj8KY+yCX8M2xl990UxFDJfOXhXgPuOi7BOqzZwTwhTAo6XRr5Cij5KOHj
	LT6KZfiAiaikWVwXAUinOBctUW8kyJXh3NFBMqDuRxR9a043MebGtdNjCiorKBzu/jWLyJdgMI7
	QXqsx5gkeNv8nXQ872F5V28XIm6mYmn025ybfD+KeSaknJwMZiDSu2/MVpPDjAlF+z6uOdmYcwi
	P986dxlnRSpFze0MeRFmpPDjtl+yoIGcTpT/0xPted5J/pwklFGtiluZT/RFOcKLFuPGUSbYmN6
	2/zZSQfX0OHmFB5zoOFJLrUA48J/YglaJSwvxXaWd2PlZ0s+DpcSEKTs8ExiQsPgcYnf3wg8mvt
	zdhbkaM1hkNDWIaUdGBFalemi0AVMJNw+LWrycZEHTpn1yRAFNk7fZPB/E6EXzxvin76oAYcHVi
	dCv2it3gKU4iFuWZHdM7SJzZtno0j0TDWcOqntR59gsVFenFP40MR5IgJ1YfnO0cGx
X-Google-Smtp-Source: AGHT+IGDPnG7HtZZOzHzDzOnTvQCbphPIOssxaWdLijuYXdOKqbHAb1gXG6TbG+I7cy+yOigXJi2Ww==
X-Received: by 2002:a17:906:f58a:b0:b2a:dc08:5914 with SMTP id a640c23a62f3a-b302ad3922bmr273199066b.45.1758638275808;
        Tue, 23 Sep 2025 07:37:55 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-82-56-38-125.retail.telecomitalia.it. [82.56.38.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b2a2a5f6c7asm665204666b.28.2025.09.23.07.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 07:37:55 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Frank Li <Frank.Li@nxp.com>,
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
Subject: [PATCH v6 4/6] dt-bindings: touchscreen: fsl,imx6ul-tsc: support glitch thresold
Date: Tue, 23 Sep 2025 16:37:35 +0200
Message-ID: <20250923143746.2857292-5-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250923143746.2857292-1-dario.binacchi@amarulasolutions.com>
References: <20250923143746.2857292-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support the debounce-delay-us property.

Drivers must convert this value to IPG clock cycles and map it to one of
the four discrete thresholds exposed by the TSC_DEBUG_MODE2 register:

  0: 8191 IPG cycles
  1: 4095 IPG cycles
  2: 2047 IPG cycles
  3: 1023 IPG cycles

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v6:
- Rename the property to debounce-delay-us.
- Update the commit message

Changes in v4:
- Adjust property description following the suggestions of
  Conor Dooley and Frank Li.
- Update the commit description.

Changes in v3:
- Remove the final part of the description that refers to
  implementation details.

 .../bindings/input/touchscreen/fsl,imx6ul-tsc.yaml | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/fsl,imx6ul-tsc.yaml b/Documentation/devicetree/bindings/input/touchscreen/fsl,imx6ul-tsc.yaml
index 678756ad0f92..a99280aefcbe 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/fsl,imx6ul-tsc.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/fsl,imx6ul-tsc.yaml
@@ -62,6 +62,20 @@ properties:
     description: Number of data samples which are averaged for each read.
     enum: [ 1, 4, 8, 16, 32 ]
 
+  debounce-delay-us:
+    description: |
+      Minimum duration in microseconds a signal must remain stable
+      to be considered valid.
+
+      Drivers must convert this value to IPG clock cycles and map
+      it to one of the four discrete thresholds exposed by the
+      TSC_DEBUG_MODE2 register:
+
+        0: 8191 IPG cycles
+        1: 4095 IPG cycles
+        2: 2047 IPG cycles
+        3: 1023 IPG cycles
+
 required:
   - compatible
   - reg
-- 
2.43.0


