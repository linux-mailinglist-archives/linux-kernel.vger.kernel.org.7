Return-Path: <linux-kernel+bounces-761168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5EF3B1F532
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 17:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78AAD3BE818
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 15:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9DC2BE7BC;
	Sat,  9 Aug 2025 15:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GBFpHYKK"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C562BE632;
	Sat,  9 Aug 2025 15:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754752807; cv=none; b=XkyiweKFQ8V9cRCumm4qzAivdAk4eWeALfyBbZc1bedv8FNziLtkAS0vzpYhMvkARVSxbe/lvXv3p/lLjyafpmZKTOnVwBM283DdhkbFHzD5hBTfH3a4YNtbmy0x3i44N4ri4WWLjQSiRIn5MlA98wXgyu274gbuDBEaRU6dM8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754752807; c=relaxed/simple;
	bh=zE69J7iVRkRPHezfEuW053Wj+05v1LG9BKUsSUHztHw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MbXXOOaNR+ZTaOMllF7oNz6eu2eiZrDueAj27O+3HGzdHZGUIb0N9rznwCYC0tv6iUjzG/495XNKRxDQ0FggKvI7dky0BJZPkYz2PSWm1/zxof73nSJ2g/pClHQD/YL2VrL52AdwnSrNDbPBLjpaVH89G/c9mf47hgvTu7BAFeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GBFpHYKK; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3b77b8750acso1846963f8f.0;
        Sat, 09 Aug 2025 08:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754752804; x=1755357604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F2z37DtB7ki2BMrEIWUmQdKynw5LgE3LSUPH4IGC79o=;
        b=GBFpHYKKs8ps1K/NWJRWha8K02JtQJWk7MZCcSvwKYAmrIgRI8x+nJkXbRwFLd95o+
         Q+4fXbGgQOq69qTsp3pD1UsicpsA8mzQlNTL+xSZ9A2SrnkF3ZLKt8TXBMQLgvcV6mz7
         aB7DnuF6yhti9Ul22H8/zxPZghL3t+V9XWzijb8B6g+5OdxpItuqS1UYJpiODDsRn+d3
         qj1/6SEO7f3E77CX4Itl673ROyapgNzwEybeSLlS4wVRm+MPgPyEKGS+aQc9q6yjRHPh
         j/Gt9U+FFfRuiU9Ef7dABueYNfDEgnaipKJDA7fF93I638UeSzLcslIxA5gzbIZQWcEU
         G6Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754752804; x=1755357604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F2z37DtB7ki2BMrEIWUmQdKynw5LgE3LSUPH4IGC79o=;
        b=w1LGhM23tk/2B1c1UYXfSYzZPi4n5BgYlDtofTui0pqRdkwzkunLNkQl2y8I7GXgml
         2o64OXk1NTR1SxEXHf2xjuaUMk7sXRk4CjW4eHxaJo3iS/NUJJJW84rzOEsvRtKMcpmV
         JyG7JkAc5H9Llna7g7zvn2bV5wAhoQ/bgMKUObbSpMesRofLkGF6kI2+T1Dilst095SR
         XX6EQ85hp0brTZYiwi2/cPl5e6YhToBtZZHwzkfeV4zFELUKeJvrGe8ebGIylvxQY3ei
         ebRYpmvetEWk6rhbsdX1sgubAt2FssIPVsdgszHNoDdavLbmkpBS9gDkZYdUUp1S3NoQ
         GQbA==
X-Forwarded-Encrypted: i=1; AJvYcCUzkOFgdadkO4YWvR8Z3fke0kVGtDMyyss82OnsVxJ9gK1EkZ1X8G8awaUZLv8rqF/7dHKQLytQ5Cf3@vger.kernel.org, AJvYcCWi8OILLytE1WJ5MXBjZq2vds0/+qR/RrQyhWrQ/si7ZBV21GcOSBVdi7XmuOvmcs5bsXyiMdMnp4aZvit/@vger.kernel.org
X-Gm-Message-State: AOJu0YyfMOIwDnvLch3I3LeYv2Bs82bzx5vldzo7+m9Z1stxYgHf/fGP
	MpKh7rBY3zhcRu++L72BBgeJH1ArNKhob+MjOw8QGAeLiq8YCiebLRKZ9xF/yvA=
X-Gm-Gg: ASbGncsMMVrOtgCKaTixoncTCT9Of+hOlbQzu/X4r5/90Hd3z8DT/FvbOSW+/rYAQ6Q
	AJpDQ1gUC2rik4n8RNBJsAyeholQ1AHRo3706z8MHv/rJEwAcpxq+HgUDle4QomO/Tcg8BwnWvp
	II4mFD2ZdyocPMsBICNElvJmv4S1h7pZOpUfV8U8uPoFXhgy++tBRjSHFTnmLh55hOhgjUjVTsH
	Ar3C77GQuBdseTekbOa0xQREmhVZlnYlWSqWtqvR4tOd0f2GSeBQoGUqnBzTLpGtX60WYP6pEjm
	VDPlYWZo82Ele8zgGiSBpmO59a4hcfdqAxwzaHrQtAYbt67PnCkDqKDEM4vyrpOSIGylqxy4a98
	d1/9syoSw4hpVw0EGr9D4q7+ivNRiU2Cl9E4ffP38X+ju8L8=
X-Google-Smtp-Source: AGHT+IGusN9XKZd7es3KXwBzzyBcPCvZh2zlkHXnNJLYlOsbnMoW0ha4fXEs9ddU9RF0t5ans+UMFg==
X-Received: by 2002:a05:6000:2507:b0:3b7:931d:37a0 with SMTP id ffacd0b85a97d-3b8f97c46d9mr8230422f8f.9.1754752803443;
        Sat, 09 Aug 2025 08:20:03 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:e487:156f:b6b0:b8c7:9296:47d7:b0cc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459e583ff76sm178748185e9.5.2025.08.09.08.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Aug 2025 08:20:03 -0700 (PDT)
From: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
To: linux-sound@vger.kernel.org
Cc: lgirdwood@gmail.com,
	broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
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
Subject: [PATCH 3/3] ASoC: dt-bindings: wlf,wm8960: Document routing strings (pin names)
Date: Sat,  9 Aug 2025 17:18:53 +0200
Message-Id: <20250809151853.47562-4-jihed.chaibi.dev@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250809151853.47562-1-jihed.chaibi.dev@gmail.com>
References: <20250809151853.47562-1-jihed.chaibi.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The wm8960 driver defines several DAPM widget names that are used for
audio routing in the Device Tree. However, these strings are not
documented in the binding file.

This forces developers to read the C source to discover the valid
names, which can be inefficient and error-prone.

Add a list of the input and output widget names to the binding's
description to make it self-contained and improve the user
experience for board bring-up.

Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
---
 .../devicetree/bindings/sound/wlf,wm8960.yaml | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/wlf,wm8960.yaml b/Documentation/devicetree/bindings/sound/wlf,wm8960.yaml
index 3c2b9790f..c8c786cb6 100644
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


