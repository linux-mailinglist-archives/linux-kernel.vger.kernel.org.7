Return-Path: <linux-kernel+bounces-869429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CF1C07DD7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 21:16:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 314FB3B9E6A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 19:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045BB36B981;
	Fri, 24 Oct 2025 19:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="I37SDohO"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A9D36A60B
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 19:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761333360; cv=none; b=bXWUmx2c0pWaHIcBkwjWTAcTjU0nS3b43ZIpJlcsUJZ4Gabr0rNmeuEr6qgz2h3q6oc68YvclIziQ5N7HKWMY8AzAyV9sDNNPopuf5H/E3OndDVZXCOwFg8vVB1S2rljVAs/FLtCW25ZOhPyUfSB+zzX6ZBA2IRMpZydH29NHxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761333360; c=relaxed/simple;
	bh=spWtt1Pp8phvWIL1ongPyy50mYvbEr24rP0ZYo3c4jU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mml6KVpRUa1Nkb/DrGDEsHD13g5j7/LIV8T3eAMdlAgUcvZSpE1MzDrwK+yafde593CBNMzdVoD4t03f6+CdGMWYp2zxo5EFuPL9aC93Zp2n1wRjv8NGo+uwvr76Kdo/6SMRfE0eCMsnW+tcYBCNy3uJA60ZYS8CG1cfdc3Unpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=I37SDohO; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-430c97cbe0eso23372435ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 12:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1761333357; x=1761938157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L0sSxMmpgJlm+DBHdJiFvMNmeUcFKdKvsAUrpyjqesM=;
        b=I37SDohOU9gXF7NJEis/lD7PE6Cb0yg0cb2EtUkTzmu1gqJC/M/9EwwzAVD79LzyQ1
         JSmtxoPffj4bmpPR+gTe6qvMG7ij1T3tuzpWYB/EYqXoQybGN/Y2GPDxoXM4z78gMzlV
         G/XzUgTv0rw2TPhhyn4l5PpvgASVzD0uTSqhsspGk6Lv4W60NtsxHEXVRKQMmdF1vTcp
         Q9zBT0BIs5PW2euaZsJo/fJhM7Sd6f5pZZ6Qs5SpJIxxkktliyPf6jrUHdCitEIx5Gpz
         uW4s/3XxVuxEMJqYleEHkm6r7xzkd0nL4F93Z+JKXSFTtk88DT64GuGOblLntsBq3L1U
         EfnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761333357; x=1761938157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L0sSxMmpgJlm+DBHdJiFvMNmeUcFKdKvsAUrpyjqesM=;
        b=KsmnNBvpHflYbynRY1DbtLjFg6qz0E/Hdx9yOkAqBBEbY119K33ZeUgXvZkygZsPee
         loeCELxCd2NAAkbzD568VaKg+EiGnjUGW/xnaWUSsU5I76LaJ6z7Y6swbTQKttNq2I3s
         4xdpxx9yQrgmEH8nYKSpFNP9LfHlgtMf8bmYb+JDnjrmPLib/NCe+sUrOYX6mqdQv3kt
         7qNdtI6y0jIt0EnCSBWIEQOd6sj4zNr0ht0v+j5B2JgJqVvxpltT+b7omBO3ZxQeE05m
         GpY+jzMd6/kDKRya8bQ455yVJLjWjmLslxA4cOF+IVt9ekp/L4RppHkGJFsBI/0diNuw
         erEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJ4y1qaznf0Y5+u6MeMzbw8pUsRZ51vrkLIpkXizkfF+xielfH6agY3YD0OZsb85uCSdjhw4Obbte82ck=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8ztWiQuAJlkCJE9p/1PqhdbD/lj5T17qLgacy5xqKHqfyBYr6
	KBgEZSepdWCdXuNMFqaU8j6phJzeK8EowspGm6eXp241KTlbqS/uRUbf/TmWz65H5sI=
X-Gm-Gg: ASbGncsSpJfgN74oZR0XzmqckfyTomglA4hjW/89Ihnng2nPWUk4P2LfjAjgTYuxMQK
	TVGa3e08x71uobSZZ/CRmI3zhzEXRe969bKwjwEHNU+JxCTYO0yPI+Nfi+W7+78nm8Ij4V6C2tB
	hg2+jCzd3ujRUkPkmKSu+gtheNoLUq9RprmpB+p5/zhWbmx2SOvTc4uuBGcl+vXIaHVEV0LyDpf
	ZcVf7Gg3sN1VAU1lBs34puacgHUbf5ai7irZy4tcLoUKqteX9hxOANiY+Bfaw7tYv+Cn5PRw40A
	DzIVZFlFpJoFPFfpZ7WODV7WA8GqEk/CpQpRDz5eVM9Utg/WoT6L2vdRsPQ/Lv50yuTwJDSQJ4X
	Vf7gXx6llSMHnWT+BbLWGT/AI4pl1ZpqyRAEh+/CVuVToqz1KedvHCU3rbU6U95xaWQlHRrg6ma
	m1K+yrEiAebOe4205Az1TVeu+8pphuV5YwgS6QmEheqc1LiJ5oJNU1Ug==
X-Google-Smtp-Source: AGHT+IHFcHZhfeKTHaIT8TeTse7w8bjG9Loy1iIsFUAysOy7saMHPhRTlKWgTzZuCkFXEhYPt8zLNQ==
X-Received: by 2002:a05:6e02:2590:b0:430:9f96:23c7 with SMTP id e9e14a558f8ab-431dc13b52bmr101093185ab.4.1761333357439;
        Fri, 24 Oct 2025 12:15:57 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5abb7fdb7c7sm2427824173.44.2025.10.24.12.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 12:15:57 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	han.xu@nxp.com,
	broonie@kernel.org
Cc: dlan@gentoo.org,
	Frank.li@nxp.com,
	guodong@riscstar.com,
	linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 2/9] dt-bindings: spi: fsl-qspi: add optional resets
Date: Fri, 24 Oct 2025 14:15:42 -0500
Message-ID: <20251024191550.194946-3-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251024191550.194946-1-elder@riscstar.com>
References: <20251024191550.194946-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow two resets to be defined to support the SpacemiT K1 SoC QSPI IP.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Alex Elder <elder@riscstar.com>
---
v3: - The reset property conditional is now under allOf

 .../devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml  | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml b/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml
index 5e6aff1bc2ed3..46e5db25fb107 100644
--- a/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml
+++ b/Documentation/devicetree/bindings/spi/fsl,spi-fsl-qspi.yaml
@@ -11,6 +11,15 @@ maintainers:
 
 allOf:
   - $ref: spi-controller.yaml#
+  - if:
+      properties:
+        compatible:
+          not:
+            contains:
+              const: spacemit,k1-qspi
+    then:
+      properties:
+        resets: false
 
 properties:
   compatible:
@@ -55,6 +64,11 @@ properties:
       - const: qspi_en
       - const: qspi
 
+  resets:
+    items:
+      - description: SoC QSPI reset
+      - description: SoC QSPI bus reset
+
 required:
   - compatible
   - reg
-- 
2.48.1


