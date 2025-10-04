Return-Path: <linux-kernel+bounces-841902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DAEEBBB87FD
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 03:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 70DDF4EF685
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 01:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E82E21CC5B;
	Sat,  4 Oct 2025 01:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bpId+tUX"
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A216218AA0
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 01:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759543008; cv=none; b=OYlMg3lHZDOx7sC7uIBpDXFzAA2C36NQNxUP80n1060SZO9ZBjb0xgGgHzmBmoBHccUN9UvWF+kUrqN3Ar6V49HSTbB5tpWd4+DxKkaBNI+YtY0WpISk+OAawCkisKjQIM9+85dFZMxAK/yfPkjkeZgxYwu3kVfNt/INtGcYJiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759543008; c=relaxed/simple;
	bh=9CQjQxJsutgII4B2do5o6K9A2olhaHHOafQzFjMKQdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gw2YJa1wI0i7krcXLwGU3W2IRpat8dfvmfjIA7sysQbVRf5AZIOnlqaO/2X++YDHF9UKHLTTI8P7/PJPI8BLxGr3QsWV3hwQDL+Rc0uD/2E5spZ3azZo1g2ut5JLzPWMnsNU2Gx5fZ9gZPd04+8HURl6X9NXvZllAroTajrSs0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bpId+tUX; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-78af3fe5b17so2468026b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 18:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759543004; x=1760147804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rK2RcAWNzYWhY12ieZZB4A3XwiOU33LzfFmZAdexkYc=;
        b=bpId+tUXTl8vYzIuKZF1w6YRzWBenvh+eBEOoxgv8eZSAKXelAiYBya3G29UMr+Z3i
         /iY457/zQerzA33mBRloILpLeBnCE7c8BkC24twMFupEz23aztG3bNavwfKL7VwIEALt
         QOfa3SLpe00jOollc88LW2j8EFrfqYT0mCEwCGUaS1dQFWA6iGtgcXdog6BfeX7EHNI/
         1A+vQV26SYt0b9wmrtnEMewT1VLyyFmsokyxD4OQ18Lla/xSU0BJQ5c71LfaVH78UjKk
         4PlQ6scdas70tUhDcWB9BzzCVQWgLo7ERYQCzjPwnKjWaQ9AxXz/7ftM4SCTxQTiUi/c
         HdNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759543004; x=1760147804;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rK2RcAWNzYWhY12ieZZB4A3XwiOU33LzfFmZAdexkYc=;
        b=tGFPmcA3BLVDWZGTq8SyOPrgxeQmZvlhPp7BIEEX/3CI/9wA4jb/yjG6UTAQ/98BYs
         0u0ayPmm1oqkMIVyVQJ32hufkdd4Ak9fRiqIEeolqgr4g1y0cUhV/HYAYxzwGuff5lsN
         C359/sVOT9+ojauDL6pzvpRuxGKLebqLIXQWRmdj4RhX2FQIoYVj/Ep4VhBn0buku7qc
         Q2yrgpQa7m1er1pCKI6s5FCnTQt3elUfRcuzEwSuG/Lhr669ywkwthHOIuofPBg82ulc
         PiWdEORYcspL/rXs+i69Ayx2oGNweFORAXZvEctvc+eumXNowckKCRGJDalJVSbz9AFl
         cgJg==
X-Forwarded-Encrypted: i=1; AJvYcCX7vNmVN1Q2ekREE3jXC7r3mLTuHTDl4Er6kSEmblh0AUQe++Urspk90QcECUAUpnrUsc+XnnlddQt/YYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeL/XV8V+Nn0aGYBoDjLKK2TcEpFjB7b8hhqapYn+qCRT3pC3Z
	x64QO3LP9aiNtGCKUbFHPs91giHx5moaFQvcbUbjBkRE+DpXvx6TxVJV
X-Gm-Gg: ASbGncvV8VPrpbJi615D/+YT5y2SAZw9gNuBYacLBwrZVXTeOSyIO2jh6HTpOzixPIO
	PCyLB0F39Ij6KkvOPgxO78+POHWg3wASTkqzv6pjqSt5XRiyO/gIs9IRHwROIubhwtgkvmX9AGw
	HluD6SprYBFBv6OqEgmhDrtdpR9jL45JHthfqtBowSa9G0YLpQf0YMpvokHFQtoGaRq0zMFbdMD
	lSzSAGC7c64e8NcMmRAI+/q2x5FQ/3tJ3mWEH+fl1OMwY4LtZZEuKMF6csLv/TvgWrW4P8gX2RP
	UUdMp+Sw3o/BeOUowQzxaxpirVcQ3tTo21rF16VqUrezq8YVwAVfqJrHP4hKkeTEYsoK+mnp45c
	q6jABIHlOk4rl6WwDjtCihNch0YU+XHLehAhTPRyLLGO8+t+NvdtB2InjXDGTqvkvcw==
X-Google-Smtp-Source: AGHT+IGLZrZ8Iq9T39sC4XilbTFNhZxJLoEviq80CK6g39OUwc/4C5+482Wqw0HUfzPUahIppnFM0A==
X-Received: by 2002:a17:903:ac3:b0:267:9931:dbfb with SMTP id d9443c01a7336-28e9a664f4dmr62292785ad.54.1759543004557;
        Fri, 03 Oct 2025 18:56:44 -0700 (PDT)
Received: from Ubuntu24.. ([157.33.197.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d134859sm63197485ad.57.2025.10.03.18.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 18:56:44 -0700 (PDT)
From: Shrikant Raskar <raskar.shree97@gmail.com>
To: jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	matt@ranostay.sg,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	Shrikant Raskar <raskar.shree97@gmail.com>
Subject: [PATCH 1/2] dt-bindings: iio: max30100: Add pulse-width property
Date: Sat,  4 Oct 2025 07:26:22 +0530
Message-ID: <20251004015623.7019-2-raskar.shree97@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251004015623.7019-1-raskar.shree97@gmail.com>
References: <20251004015623.7019-1-raskar.shree97@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MAX30100 sensor supports multiple LED pulse widths (200us, 400us,
800us, 1600us). These settings affect measurement resolution and power
consumption. Until now, the driver always defaulted to 1600us.

Introduce a new device tree property `maxim,pulse-width` that allows
users to select the desired pulse width in microseconds from device
tree.

Valid values are: 200, 400, 800, 1600.

This prepares for driver changes that read this property and configure
the SPO2 register accordingly.

Signed-off-by: Shrikant Raskar <raskar.shree97@gmail.com>
---
 .../devicetree/bindings/iio/health/maxim,max30100.yaml      | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/health/maxim,max30100.yaml b/Documentation/devicetree/bindings/iio/health/maxim,max30100.yaml
index 967778fb0ce8..55aaf2ff919b 100644
--- a/Documentation/devicetree/bindings/iio/health/maxim,max30100.yaml
+++ b/Documentation/devicetree/bindings/iio/health/maxim,max30100.yaml
@@ -27,6 +27,11 @@ properties:
       LED current whilst the engine is running. First indexed value is
       the configuration for the RED LED, and second value is for the IR LED.
 
+  maxim,pulse-width:
+    maxItems: 1
+    description: Pulse width in microseconds
+    enum: [200, 400, 800, 1600]
+
 additionalProperties: false
 
 required:
@@ -44,6 +49,7 @@ examples:
             compatible = "maxim,max30100";
             reg = <0x57>;
             maxim,led-current-microamp = <24000 50000>;
+            maxim,pulse-width = <1600>;
             interrupt-parent = <&gpio1>;
             interrupts = <16 2>;
         };
-- 
2.43.0


