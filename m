Return-Path: <linux-kernel+bounces-740664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09275B0D771
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 12:37:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6879B3BE217
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 10:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23DC22E2F14;
	Tue, 22 Jul 2025 10:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Um0vZbyW"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9380E2E1723
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 10:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753180640; cv=none; b=YRjK5/bE9M2GPBcyNuq4A/6WK4p+JHw2ZfZsRCTaeTEee57VFiFS/AHpq2vvEXPEwRq5Qh+pwoE+hkiQTIb8St9YiHQ+XsGcTsY4kYfYbEKYn0n+70v9PuC/INCwwgiei6DwtM1ptb0lIK7g2iMNuffDPiM0SoiGm1ZewdQzExA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753180640; c=relaxed/simple;
	bh=6DM9dMZAtcwlDKvhQvsmdFJDn+355Evyd4COdeLDukI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Whl+8B2kVk2MpI9QoFTXosQTFQRCa1UHm9QvqTklGdnno1H1Kl0qEZBH1brfdTTRXBHyyC273hWUdfxS3x3yNyv4VTTJzREUTsWrudKrAGdz75v3tlnVmemfdcxjGl0EIqIznZO46OV9WJ8wGV7aVGvFai436pWkTkDV4kA5Eq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=Um0vZbyW; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ae3b336e936so993625066b.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 03:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1753180637; x=1753785437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GtY6xQODciaFQXT13QEjMt2xFfxEtt0WYueluTMBhAE=;
        b=Um0vZbyWwagJoJVoyvzt10dufXbWiL9BGSf+gyy83x4GxniBv0Oh/KyASUkabJNAUv
         yqKz8yorgGOLhv3OffBbkgUhnovWOstmmvFbET8yAwMMQmzo3YJ9Am9WfQDFuHX1GGOj
         yG3YRxoz4ZeHiLmsNaqE9EDhg1eVta4sUyq4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753180637; x=1753785437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GtY6xQODciaFQXT13QEjMt2xFfxEtt0WYueluTMBhAE=;
        b=uKJLECcBrJNbcpo3zxrVbX4v+F4660eGrppzXd/NeZluEScWIG2wcDySGsbljzlq9s
         +u6N+TASgwhdNE5uxY4PTjCXzaTxyf7Tr+UCM377Rfw0pT4/Z68pFrBc84Gcdv3IU20r
         vPO1Na/3cTQzLTCL8y7xWMkV40OAZJf0ct5r3PkZI7dG7cT3Z75XvDhRY2n8Xz6gxB4K
         OC6Ox3EdCsDafVF/ThYADJR1bYZIHPOtEecQZa6gYjjg7UjuZ0smXEdEMV35vZL5argg
         t0cgFfLmcCA5wZ5fSLd4DR84PS0PVOVOdv1rx0kh3UfCTtd6/kHzUSL3R2S2UeOjsNhs
         MczA==
X-Gm-Message-State: AOJu0YwKilGduhBp5TLgoFkhmGRA7mcbD+EvG3zJlLohMWODL+maPpm5
	3pOO2jlk5ZjGGgP5Tvt1UdP28RqUxA7ER4z/TA7A3bCin9KeiwVWjH2xnZAulBFAPRQI7hz+JNC
	OKm+5
X-Gm-Gg: ASbGncvVNuBxutXElpRmykyXo9bemm6kdqqtmueEvwpEHSTzm/GW7wm6yL/2Su0SdEd
	2T+vftk74WUWheoklO7zPvowyja/XihtOZMG6yae4T7hMU5+OWnyot1D5ETpIubIRT7lgU0UE/3
	YiXvETpFDgEOdGZZoiRP5rDNuoPrlMoPbOrnzjIc4+M6mjn+9MBzDUsM3F3gj5f3ZJfV2rzQAHN
	pE34lMQyAt7WYL6D0GhubgSbXuhxkyryEERQoQm15vZwL2fDJdjNZEPbNEMdRCCNDnZkDtyH1wa
	DDedxH1eJEYKEza7kK7F5gtFqUM+NJkDZMT6WfKkRCVttJ138S3/byjdiNMkXuBxq+Olz7OP6Ad
	19H/gioLFOC/2pININU+j9ULJmFP4GfNR1l6cj5gVdQJERF/OSf4iDXlsd8I=
X-Google-Smtp-Source: AGHT+IGaHOYHJrE7/OlnHeCdJT7X6M+1OGRNxK7Jx2o38iPchbY1YGECx/VXRXtQUdO2o2c/K0RoAQ==
X-Received: by 2002:a17:906:9fc9:b0:ae3:cd73:e95a with SMTP id a640c23a62f3a-ae9ce0d2aedmr2549138266b.36.1753180636628;
        Tue, 22 Jul 2025 03:37:16 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6474:ebbf:2bba:d7b0:8e79:c982])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6ca310e2sm844568766b.79.2025.07.22.03.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 03:37:16 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
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
Subject: [PATCH 2/4] dt-bindings: input: touchscreen: fsl,imx6ul-tsc: add fsl,glitch-threshold
Date: Tue, 22 Jul 2025 12:36:16 +0200
Message-ID: <20250722103706.3440777-3-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250722103706.3440777-1-dario.binacchi@amarulasolutions.com>
References: <20250722103706.3440777-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for glitch threshold configuration. A detected signal is valid
only if it lasts longer than the set threshold; otherwise, it is regarded
as a glitch.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 .../input/touchscreen/fsl,imx6ul-tsc.yaml      | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/fsl,imx6ul-tsc.yaml b/Documentation/devicetree/bindings/input/touchscreen/fsl,imx6ul-tsc.yaml
index 678756ad0f92..2fee2940213f 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/fsl,imx6ul-tsc.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/fsl,imx6ul-tsc.yaml
@@ -62,6 +62,23 @@ properties:
     description: Number of data samples which are averaged for each read.
     enum: [ 1, 4, 8, 16, 32 ]
 
+  fsl,glitch-threshold:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 0
+    enum: [ 0, 1, 2, 3 ]
+    description: |
+      Indicates the glitch threshold. The threshold is defined by number
+      of clock cycles. A detect signal is only valid if it is exist longer
+      than threshold; otherwise, it is regarded as a glitch.
+      0: Normal function: 8191 clock cycles
+         Low power mode: 9 clock cycles
+      1: Normal function: 4095 clock cycles
+         Low power mode: 7 clock cycles
+      2: Normal function: 2047 clock cycles
+         Low power mode: 5 clock cycles
+      3: Normal function: 1023 clock cycles
+         Low power mode: 3 clock cycles
+
 required:
   - compatible
   - reg
@@ -94,4 +111,5 @@ examples:
         measure-delay-time = <0xfff>;
         pre-charge-time = <0xffff>;
         touchscreen-average-samples = <32>;
+        fsl,glitch-threshold = <2>;
     };
-- 
2.43.0


