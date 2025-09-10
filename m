Return-Path: <linux-kernel+bounces-809339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF68B50C2D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 05:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1889F17C9D7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 03:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB9E263F54;
	Wed, 10 Sep 2025 03:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1lLdInW"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903A11F3BAE;
	Wed, 10 Sep 2025 03:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757473566; cv=none; b=a5WdrYq+6sJHvWSYJKHmYeQTKOsODCQyuG5qidsUPhRgJOCxSCYuOxOKiXnnOkOu6Zru60kyU0fuMi5NtgBB+sQEUujaSixNIT0772kAJ/I12ARuxB9vy1Ch8a4dOTCDBkXODl5fSjmX4RiK66h/FOtwuVrz1KJA32zzp3w7CE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757473566; c=relaxed/simple;
	bh=x7Nhy2p6x6dpnDCTAhpQcAybiGnaauxFUjBRMxr2l9E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fGLCkvIGnmgNkiKiLMgjHq4NMkdDb7IZODgZr0l6mG7mp199QyW78ajNS8v1HOHAfXy9U89ctusNgWTxRckqpYAobbxbBuS4mgfIa134jV9NY1/G8grGR084jMdPsS9bDMLOMLZiUEYTxUa7npupiqIjTXQM4CycrGAprdz4xOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C1lLdInW; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7723f0924a3so8301015b3a.2;
        Tue, 09 Sep 2025 20:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757473564; x=1758078364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lApSKWlbDDCVaUIvBgJHVYgBpeBz7q+50mzfJPpQ9Tw=;
        b=C1lLdInWaYRmRZzsxhUQl/S73bAoPIuQ/Qqkp4aax5RsKPQd+fHTg1SSFb8/V569Av
         0vHo3Njz9ukUr0eL7AOPyC/STZN84Vihw0CnVRqB1CQu6RLRFQs+k6t7TgWWKDxG4z6b
         D508VcsYE2V61rw1w7vKMF/ZlIU6dH4wbQFO27sTFxxfnQVx4ftKMo5OWSrx9Hcx1jIO
         PDoKLV53tD8RTJ0NHGAhwtrwcM6bmrmhJN3KPC5vQ7VJtbyKu1NLw1Krcbb/ExIZcULI
         Fb8zSaJfVEYCChDnaUqzVcxgXXI0FgCjoe8gQcu596HhroAu9oULU0wU8zzdcnJ/RKqj
         bSMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757473564; x=1758078364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lApSKWlbDDCVaUIvBgJHVYgBpeBz7q+50mzfJPpQ9Tw=;
        b=rg9eVK/14UpBkhAh3+AFmhrrFUHgQrJkHlcUJ06vso66PblxJc6oCAuofPfF7XirPo
         k3sGyF6ia8ptO3uZUjvXWXrPYXGwdM2ziY3i0IroWUmFFYbUw1haNsHdBWu9jA2b493a
         Qwd35rDlgwtSMNMr2RWpjLHzJkirLhd4vp9ffX6fkwIO9tkN62fAxF1tFuLDv1ul9tdf
         +d6o74RmfDzyOr6Am9+ew2JlDvyAnOBTimSteQIRayl2GNsNsF/ctiEDIgyWwFGzvvrm
         3HyhIHZ67Hwuosx5Mve9CAjlC8hmQsK18XgZMZWZEuxajF/eX0hm8UyoskY/FwbaB2vn
         vb1A==
X-Forwarded-Encrypted: i=1; AJvYcCUuiBhMrp2HJ2HuVZR8iDlvSdayCPRjrYsumisdP4sc6EmsY1aa0jT0By1l3TnGW7iVdyXviqFzsyZJ0Q4y@vger.kernel.org, AJvYcCWfPUeiNOEawgXOn3itKkZ0SZITF42zZYOPQOJOLSDFEnyBFBTZ+woKrBJzfxUu8uwZnXLd6y7TAawK@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3rdmCtG9BWm60sY7NCubhFUmsRQCbeyBTP3WmvUNP7d6z3Gni
	+Ye0WX2V5INF+R3gttqDMP32ULglNUzsUTTjepWkvprw4NnScmt43IPl
X-Gm-Gg: ASbGncvSTjcWp+PhSVwRSnXvcMiJYoS+ir2N4atx7UZlAc0RsnBy9ULXDhBdcJF4Y3E
	6nIyFwS1mZvlm1b9aEQSAhOygKfetEY1RToj2bTGyJ/tgPBesXT9F9VceAYtkc8AKetDbEEEaoP
	h+S09FnKsYw0qOkdnEe8jYlTeIjQupGcLSJvpXzJvVV3Q356dDn9NAMpQTFFKrUZczX32FEqIAR
	1huyKyyabhhnAbxcyX8gRQ+hQ4cEW2KvX/S+jrG6xtYaKzIrK8r0q+7IEO86L6FN0BCidd5524E
	AYdC4s3FzOnXQaOVziYyXfjt0OkLUHyisyezJVq/JHIHG0PoL25aQAtzaE1IbI7EMtqF1A1XSVv
	DjEnc0rpUNMSPftk6rarlkF9gvqwqmQR00Wu+TwVuJvZmNpxGECwWU9uWucak4Ecj+QYPLIYH65
	z1cjyAnxmLxyWTiEViAWhrv1AuwpHIs5Qw0xHX9/RDzySN6Mghbg3ksPY=
X-Google-Smtp-Source: AGHT+IHCY2/ZUuieJa6b8+0cszmNX36/5F/Lrag0799NXHCWBy1pFhZxsR4kZ6/iF+Li0mFGFmNmFw==
X-Received: by 2002:a05:6a21:998d:b0:24e:e270:2f5d with SMTP id adf61e73a8af0-2534547a6fbmr21524873637.43.1757473563820;
        Tue, 09 Sep 2025 20:06:03 -0700 (PDT)
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-774662908a5sm3512047b3a.60.2025.09.09.20.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 20:06:03 -0700 (PDT)
Received: from hqs-appsw-a2o.mp600.macronix.com (linux-patcher [172.17.236.67])
	by twhmp6px (Postfix) with ESMTPS id F16A2800FC;
	Wed, 10 Sep 2025 11:10:36 +0800 (CST)
From: Cheng Ming Lin <linchengming884@gmail.com>
To: miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: tudor.ambarus@linaro.org,
	mmkurbanov@salutedevices.com,
	Takahiro.Kuwano@infineon.com,
	pratyush@kernel.org,
	linux-mtd@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alvinzhou@mxic.com.tw,
	Cheng Ming Lin <chengminglin@mxic.com.tw>
Subject: [PATCH v2 1/3] dt-bindings: mtd: spi-nand: Add enable-randomizer-otp property
Date: Wed, 10 Sep 2025 11:02:59 +0800
Message-Id: <20250910030301.1368372-2-linchengming884@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250910030301.1368372-1-linchengming884@gmail.com>
References: <20250910030301.1368372-1-linchengming884@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cheng Ming Lin <chengminglin@mxic.com.tw>

Add a new boolean property "enable-randomizer-otp" to enable the
randomizer feature on supported SPI-NAND devices.

Signed-off-by: Cheng Ming Lin <chengminglin@mxic.com.tw>
---
 Documentation/devicetree/bindings/mtd/spi-nand.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/spi-nand.yaml b/Documentation/devicetree/bindings/mtd/spi-nand.yaml
index 77a8727c7..432bc79e9 100644
--- a/Documentation/devicetree/bindings/mtd/spi-nand.yaml
+++ b/Documentation/devicetree/bindings/mtd/spi-nand.yaml
@@ -21,6 +21,10 @@ properties:
     description: Encode the chip-select line on the SPI bus
     maxItems: 1
 
+  enable-randomizer-otp:
+    description: Enable the randomizer feature
+    type: boolean
+
 required:
   - compatible
   - reg
-- 
2.25.1


