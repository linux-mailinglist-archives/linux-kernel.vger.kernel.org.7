Return-Path: <linux-kernel+bounces-748641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D137B14428
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 00:00:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5605217F76B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 22:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0541F4CA9;
	Mon, 28 Jul 2025 22:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="v+W2wslr"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22DD137923
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 22:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753740009; cv=none; b=DnBXjbdrMDGYe/pTlZVmL3GzisSRB8FR/M2eop7RNpnGxJoDBf6Mly/g7CFR36zNfCvK33drKsYEcRfZPf5sKobXxwhyn146pJ3Fomp5NM15KtZ1NLK0XcKnSn85zl09R3hhcdfUfrXb5srCzKvNe1yzwfXG8ShItJiA9k7FX5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753740009; c=relaxed/simple;
	bh=/qAK7aYKKFRgAJnNBp3OG1T2f+7X1+5mXUXNzKDQxr8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JD1i8cREdAXbAqg3LBsjC3Beul3w6lQFi5jCzy5PvfUy2+zJIQBON4GnOMZBtcUjnM9CepLUXq41xO1lYxsL88OfTus2cfATXc1rD2KUdFQ+0zc2vyEBqQFCpIdJFBlBVIJGpSz655hvQxRNbw9tsrfqk4sCmHP3oau8Xk+Tm6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=v+W2wslr; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3e3cd27178fso12549995ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 15:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1753740006; x=1754344806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SW20ypPIfCwWzDyApEVu137flF7JF7gBm3arCQYvIbI=;
        b=v+W2wslr5hItGs6yCQ5c+558JTBleRDLv4njzriMThgLURHsc9qoj9mpVU7gnEtzmW
         Sm11lp2eGHrf4IYNSYxzUKBDiYNCMxcdpUhEA+CeuOKxdSfiT9rJjk/A6VGJUKTM6CIO
         ifJxFV9woud5CAqsOhuFOAlchAQxMQrvAPLtgrXV77v/tH6yqmTkqS0vKBbK5brBiOWq
         WprGIa6EC9YGSicNK2Xqo58q7taHmhOxEu6NXNoHcMOTSmvxk1xP5did2BJfZaxLxba5
         6CVy9frO1nUUIUje7kRFCaVkJynocM7OhbjGt29ygcMynmoueuSalidbiPxsSIVvnjrk
         pKbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753740006; x=1754344806;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SW20ypPIfCwWzDyApEVu137flF7JF7gBm3arCQYvIbI=;
        b=Y1xRjkARh+Y3COJhMLBn6wAdEs6NcM7w1lIdSUI22VMDmWQ0M/E/mW9bNE7D+PfKiK
         ao+vM/7zRcPufbYqXCrPTwJoCJQ7Ulw3j2pLBuKy0FznUN5WJH4M155OWLcFCY+k7bsO
         GLdFvsi18tnvuKbipy4bW+Z2C/9Kql5PP+xcql2VdyouqmPW2WklbB3ptVfs0icfgHml
         VnvbbdunT5XQMPrFCKzO2j1yeaxvfXHIjHBcPPJ0B5hXz5ZkOv1WM5VyslBtgMvuiekS
         aZ2eI7IG5f42e8hUSf2ulkwTbRg9SM5EYGl0rVw0ZO3JP63rZh5jRAuszLOEZuiDpq2i
         LeHw==
X-Forwarded-Encrypted: i=1; AJvYcCUfULR5a7SlkRyhSQP4FDDmV+1ctLgM3oJxbqfm8H8+anBbzRGyuDLjSBmFZvEi3eyVoexnWRjoQ4P3BwU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0Gigg6REx7ZXCeRP1oz5oOhvmCikY/U0yaWNxlUmzMaZOWlGU
	iZCI4LOmvojP6Cq0zR7+SRTT5tjTxgm34fLSAZBHFqDS7uW7OcH2xX/qYy7iJxzO2g8=
X-Gm-Gg: ASbGncuN6iLs9MBQVNWEyYiBQ4otn3NxMJzibyFP1QrsdTSWEAuVR6vBBhwuu6ZejQR
	6vajUUdir88hz4qk3no9Ht50QhNN398/OJr/uJZw09D641jsj/fSKB0+1i6hLyuaISYhsMeks7Y
	sypc7ofcFJXDYUGR+qlIj3N4+j6ZVmpCAjPJqwn7P7r32A9Ak1KB4ehMyPSDhzS2/1dC51D4Gkm
	QmKv7U0NVqxs5uPEk8s5NYsaSSXWU+ah26LjZDWoRFZzJ9ktCxsQVZuneTVOCMedVm2mSiizyk2
	p+fWik/tAw9xgdMAJ3ro/TN3NMeOTGFAeQJqSNRmDPtaol22uKt4KG49oxiSdYWVkwcltIsictM
	7f8WMIIchR+9AuZAfKDTwbvNSUEr/MPB/1Gsz/ReJ3khiMBrBeGsUdDA4mTyOQ6CqIg==
X-Google-Smtp-Source: AGHT+IEInGF/Uihao86Df5Hh8l2S/n6kOMKGVWM1LdBNeEbSuGAD9Xt1OLU4ny9gFPGHVpMlKG5tfQ==
X-Received: by 2002:a05:6e02:1d98:b0:3e3:d185:9163 with SMTP id e9e14a558f8ab-3e3d185932fmr133375445ab.20.1753740005684;
        Mon, 28 Jul 2025 15:00:05 -0700 (PDT)
Received: from zippy.localdomain (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-508c91c9fdfsm2167331173.4.2025.07.28.15.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 15:00:05 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dlan@gentoo.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	lkundrak@v3.sk
Cc: devicetree@vger.kernel.org,
	linux-serial@vger.kernel.org,
	spacemit@lists.linux.dev,
	linux-mediatek@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] dt-bindings: serial: 8250: allow "main" and "uart" as clock names
Date: Mon, 28 Jul 2025 17:00:01 -0500
Message-ID: <20250728220002.599554-1-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are two compatible strings defined in "8250.yaml" that require
two clocks to be specified, along with their names:
  - "spacemit,k1-uart", used in "spacemit/k1.dtsi"
  - "nxp,lpc1850-uart", used in "lpc/lpc18xx.dtsi"

When only one clock is used, the name is not required.  However there
are two places that do specify a name:
  - In "mediatek/mt7623.dtsi", the clock for the "mediatek,mtk-btif"
    compatible serial device is named "main"
  - In "qca/ar9132.dtsi", the clock for the "ns8250" compatible
    serial device is named "uart"

In commit d2db0d7815444 ("dt-bindings: serial: 8250: allow clock 'uartclk'
and 'reg' for nxp,lpc1850-uart"), Frank Li added the restriction that two
named clocks be used for the NXP platform mentioned above.  Extend that
so that the two named clocks used by the SpacemiT platform are similarly
restricted.

Add "main" and "uart" as allowed names when a single clock is specified.

Fixes: 2c0594f9f0629 ("dt-bindings: serial: 8250: support an optional second clock")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202507160314.wrC51lXX-lkp@intel.com/
Signed-off-by: Alex Elder <elder@riscstar.com>
---
 .../devicetree/bindings/serial/8250.yaml      | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
index e46bee8d25bf0..cef52ebd8f7da 100644
--- a/Documentation/devicetree/bindings/serial/8250.yaml
+++ b/Documentation/devicetree/bindings/serial/8250.yaml
@@ -61,11 +61,17 @@ allOf:
             - const: uartclk
             - const: reg
     else:
-      properties:
-        clock-names:
-          items:
-            - const: core
-            - const: bus
+      if:
+        properties:
+          compatible:
+            contains:
+              const: spacemit,k1-uart
+      then:
+        properties:
+          clock-names:
+            items:
+              - const: core
+              - const: bus
 
 properties:
   compatible:
@@ -162,6 +168,9 @@ properties:
     minItems: 1
     maxItems: 2
     oneOf:
+      - enum:
+          - main
+          - uart
       - items:
           - const: core
           - const: bus

base-commit: 0b90c3b6d76ea512dc3dac8fb30215e175b0019a
-- 
2.48.1


