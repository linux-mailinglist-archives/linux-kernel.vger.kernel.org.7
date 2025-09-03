Return-Path: <linux-kernel+bounces-799039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E26CEB4262A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 18:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D366117CB3A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 16:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394582BE024;
	Wed,  3 Sep 2025 16:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XfTtxFlY"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB71B2BD587;
	Wed,  3 Sep 2025 16:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756915323; cv=none; b=T1ZA4Ywm9ZX7N/cSpqxYS6Mal7BdUBDL3H1QcsOj7MxuF+cexCabFCUL33pHZBp5oYxRdttvOhmzH0UMNGA3whGM1mYz4VtE7g4+TPjBuTkJ2Qm4KlP+kvfkuNkNE45nR68Czt3bWd3OfIm5eeS7oXXZjfj0PNTk1mCwxxT+VQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756915323; c=relaxed/simple;
	bh=rc4WozWEWs5zGeQLqcAqbWgiF6WsVN4RwKuXwK/GUZ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FHbc0g+ORhb25GSw818FM738aswnQeSxfemJUtkJnYZLezvGwG6aTFj16bIwxsdBBzZvyPvBwPz9vg4S+31tQqa2GPPQR/+0FZ2tUJN9KQ8FcvVKg0jHtQ4WAw1mL6wbCnEZfxmqHg6dL+puDYK0YXpNIjJlcR+WGxRZ31czcB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XfTtxFlY; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45b7c56a987so643675e9.1;
        Wed, 03 Sep 2025 09:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756915320; x=1757520120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nIGKgUk4e2F1KaTf/F3NT2AbgpWxayl94aH/LiAOa8A=;
        b=XfTtxFlYIOuk3CCYSXobgwyo5lGurW18xhoBmkJMv88gK2LydHyzjc7pGwU8w7e/Fl
         3G/Hl/XvlyZ+Yh2wt5vxBaJ3DhgYYHrTBAP+WAEbx4OKakmjjR9rlBYsVIB1Hwe5sl0X
         FOeycFwIc9gK66fNaoXv3N911+thy60Mqyez0wZBfdww5MCLuJCw4r1k8K/NVRe/v9F2
         I/U+WnD9KeXfWEslBjvXJjV8gVcIFhIobMkhToeExhXE446H/hQIC7GMgFRL274suDe5
         rffosLQLO8lkjd2WXVv9+MdUi5Jmp3kEiEygwS4bO9dju7U3Zf4RGtOgVLfx9f9LNrKP
         wIFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756915320; x=1757520120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nIGKgUk4e2F1KaTf/F3NT2AbgpWxayl94aH/LiAOa8A=;
        b=Vzti/udLyOR6p71n+ksop/7oDKc164baGT7AR1BnS1WlA8ZODC+VDYrTwoWfqmeBLL
         z2zvq8RBoq7/NuiQ497y2WdxzJF1KRO4JA33U4ipWRj7HnHBYAt7oyQpsdQsrh4F8MDX
         TRK27th1nHG9qmfqRnclCXznTwompvROp+ho0sO/0WWbzCztveK3o1j9q//YpHYtLca3
         /tJKB3bomhj21xfIJho2YueUvZXH1tDN/TQ/Zwf0P2adSRGqmPnE26YC23DmGHCMz6Hm
         RqS00n4GmxLNZCjwBQ2hP+vBhb1Z4VMKnSGvOQpkhxh9bAenIzWZ2+j59jN5xnFVgkFq
         MP4w==
X-Forwarded-Encrypted: i=1; AJvYcCVQa2OOHgtgRyjWg2wRO4yHqzPk/soWsr9FZEvQHnk2Uvqm9Bw3JFME7rsIrAva6fwAHRd1wjkHoCDN5MJc@vger.kernel.org, AJvYcCWR8Kn7VoPZ1KOvCL/E3XgLtTaVV7viBtSj8oa8m9j3hox1MBq5raxds15FkknoYt0mXYn93nZpqapf@vger.kernel.org
X-Gm-Message-State: AOJu0YxfXBUlkWnYHlkQqlXkl8LGcFppCwtTdhwqZk/0tvZEZH5/SqJ1
	d7+jRRxoE9+wfMFGwV3vEz7URds9SKrIkFYdhX6SHzvsoAEzR+a6OzltiVoD+S4=
X-Gm-Gg: ASbGncugLCqTqlaKnDpKNG5pMvY1bpYRZmYO3w36thhISgyLvwL+N4RCFY5wPxXFLon
	Hi26SAjKO7EQpND+cH1aGjTcx/89ADEN6zm48fFfdmW1QIgMJveMVxMdkEKHuUhmXCQBabswcoZ
	5VQM8OuhPqjWa5IbJAQuNvMtb4yI9ocr7iK/qtRVo6pIFLq9tQF6+vJPkrITvGaHx/hiFoAEWXN
	3b0HUA3Q7dgVLLMBRlJvUxucSVsjU3PWN1lerGeGkYTCfwd938HxjrWvPxR7qGCuv0BaUkDa51F
	6OQJ6aEFg+sur0aki4lMbJWOLKuX0yXzfIYmFCrhj13dUCCJAzTdhiffGN2enlAOwfPZkh7oK3L
	N6Z4PfY2dWoXhOdIPPO4LeZPZKwB94Q/QYix6ybjHGJMaIr/Ff38=
X-Google-Smtp-Source: AGHT+IFSjDcvZ+L3P5EpI/RXSWIocigVjWsTX8B7yeXd9VBhQi+ythrgbmSVHPzzQ3do+qPl+HkOYA==
X-Received: by 2002:a05:600c:1914:b0:45b:88d6:8dbe with SMTP id 5b1f17b1804b1-45b88d6939amr120541745e9.7.1756915319710;
        Wed, 03 Sep 2025 09:01:59 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:e487:221f:e1b9:d63e:6ec1:3551:61a6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b8f6cd502sm61672745e9.1.2025.09.03.09.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 09:01:59 -0700 (PDT)
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
Subject: [PATCH v2 3/3] ASoC: dt-bindings: wlf,wm8960: Document routing strings (pin names)
Date: Wed,  3 Sep 2025 18:01:19 +0200
Message-Id: <20250903160119.83625-4-jihed.chaibi.dev@gmail.com>
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

Add a list of the wm8960 pin names to the binding's description to make
it self-contained and improve the user experience for board developers.

Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>

---
Changes in v2:
 - No changes, this file is already refering to device pins.
---
 .../devicetree/bindings/sound/wlf,wm8960.yaml | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/wlf,wm8960.yaml b/Documentation/devicetree/bindings/sound/wlf,wm8960.yaml
index 3c2b9790ffc..c8c786cb6c4 100644
--- a/Documentation/devicetree/bindings/sound/wlf,wm8960.yaml
+++ b/Documentation/devicetree/bindings/sound/wlf,wm8960.yaml
@@ -9,6 +9,28 @@ title: Wolfson WM8960 audio codec
 maintainers:
   - patches@opensource.cirrus.com
 
+description: |
+  Wolfson WM8960 audio codec
+
+  Pins on the device (for linking into audio routes):
+
+    Outputs:
+      * HP_L    : Left Headphone/Line Output
+      * HP_R    : Right Headphone/Line Output
+      * SPK_LP  : Left Speaker Output (Positive)
+      * SPK_LN  : Left Speaker Output (Negative)
+      * SPK_RP  : Right Speaker Output (Positive)
+      * SPK_RN  : Right Speaker Output (Negative)
+      * OUT3    : Mono, Left, Right or buffered midrail output for capless mode
+
+    Inputs:
+      * LINPUT1 : Left single-ended or negative differential microphone input
+      * RINPUT1 : Right single-ended or negative differential microphone input
+      * LINPUT2 : Left line input or positive differential microphone input
+      * RINPUT2 : Right line input or positive differential microphone input
+      * LINPUT3 : Left line input, positive differential microphone, or Jack Detect 2
+      * RINPUT3 : Right line input, positive differential microphone, or Jack Detect 3
+
 properties:
   compatible:
     const: wlf,wm8960
-- 
2.39.5


