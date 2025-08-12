Return-Path: <linux-kernel+bounces-764345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55AC9B221CC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 10:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A00DC720F94
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 08:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9805D2E284E;
	Tue, 12 Aug 2025 08:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fwMMmEsi"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBCD2DCF7C
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 08:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754988298; cv=none; b=eZ71d2yEGVkOjgyj6J+OSFKt1ATbnQt8TPEmHuzFcupWyGm9qrmrA9yidXDcq0NVmiYRW4DXI+8y7qRc40UhsXM0SoYubiKVPReErlsQDzOGGrMnzTQTdT/PSv+baB3B8UO6efsNHfuBtE7FkS7aD/R7NQVS6TIG9T3j+xAO+TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754988298; c=relaxed/simple;
	bh=yUEBG3s2Iox5Z1YnWor/+RVWc+Tlit/BIkynfNjn8u0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=cJFxckfL81JU0tfhj9tfPk1CQL3sebgzXy3wks64lOTwi92qvPKP7RPx51XtVTWfRNCFu8DPnAcd7Rzr3VGSt/dJtsbc3PIGd2xviJXZfkT9pOtvHTjRE5ypsV7f0ZwZmRLRw5Dgo0G3HZyb2juoGv9FW4Bw8bLEIbkeNijnu2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fwMMmEsi; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-af93c3bac8fso735705166b.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 01:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1754988294; x=1755593094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=UIMOvue31dwc/J4aquxw833RlbJuhQchriCV8fOzVLE=;
        b=fwMMmEsiVc+pLmQmqeEk98Y6Bpb8sbp7eqUEA5l3qqW+nsDnCJZKbXskaAs5/Gb8+E
         mCQnO7LKfyzy9w3nTl355jSCdt8YgrTUivBHa6YRLNYn8qwTslua/Oxf4v3bCTjFsdgM
         hXQV+O/JyWkylrjYLgYp/706HrGhvYx8ICmSEiPHdg85A6Pa8zn3rMe8W5M/nKNe2hWl
         IoVIHhUn9u9EtCPwfkXrfXgf4tB7U276Dvv86fDq1mhyn99wsMDgi99+dpNoOOHcLDnn
         j46gIsVBp9TyEjpU2itO8FSnxZpu7oeCUcQcBOxsqDWuG9g6Y8p866mX4+NMKLl3WD2j
         k/Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754988294; x=1755593094;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UIMOvue31dwc/J4aquxw833RlbJuhQchriCV8fOzVLE=;
        b=gTxVRvNEP00PbngOuSwoyrosRW7GQC+gb1j8Q0JAHShmtYbvfUgdHhqOhTMmZsGpzf
         s0RnXGvCgWV9OMJH0snG06MvEUg0AZOuzqdEfMCn3EWIXzBWwD/wlRCBL7Zp26RWvoaY
         n6D6KDh1zpzR1qtDuk0nRVPZuJ6BJ0mjiw+QWch8ck9Z/G3mbJYfBO7T9vGq4ei5VZ55
         vP6AKkx18kThMqxCWjrNpQtB803qVQ6VK6IrYxPwmrVa65xjKbFHOt0DeIUwDkIHB/E5
         a8icQIztJt80fNDNtK13qTXIP9/CWj0+6k8bE9nAyhGopJek3dPErBCL8PcE5xw8j2RG
         DHPw==
X-Forwarded-Encrypted: i=1; AJvYcCWUpuqcKvknqPumw+ojtM/TIAEvJOCcqTk1omILNJ9zvz9JAxUq6Uza35Re2GEtd8VJDpji8Gu2ELRu3QQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLVFfSJnk4AKzt/O/Xe+RdfEpWpQE5WN8zB3SitxgV47jxeh6N
	taVckxdeFCjufk5OYuMtLKdYh6Mo5GNfoCCQIQanarqVN864DeZu4lYIMc5I1nLafFU=
X-Gm-Gg: ASbGncuRm71pkUHW6k4EONeJ50pqn3L6EJTG+JcW+NnFTJXYsfTdP8lpMDBaDRogacu
	BocfTvvmO0dA2Sf2woVMFUK+3tRYCco3+2sI1YrT8s01ol+32iQH7xoyNQxGn0KXZW9mIwNZgTU
	6tDqs7AfxPdD5SQpqN1JIUMOMTx8b2Ui9cTukx4BOn92ZNiaLujJH99Q4+x17LWaUX7P7mdgAfh
	fdHMvddaszW/ww2Ichg54iE4uCqjpJzoR+sAAfXxISPH3qV50u7f3XtEHC2ejUIEWULU7rucPiG
	s1k241SF+O7TEO0wlduQpPck+LATNdvTKPZ2w2rq3Qg8yFYVOBPHjtO2iYyWQoIKW7SxiSVDH9i
	irDVAGcPPetvnJRCek/Dj0sbceiTGg9NvLnXzGjpMzs3/jnFl1iA6+YQuZMt/jMEJAw==
X-Google-Smtp-Source: AGHT+IHGS28WyNhkMEqCYl++k5tXKsI+SYF4vISQjhRE5gJkG3IUVoDSvuT7pIyGxqFMWkpcex+/TQ==
X-Received: by 2002:a17:907:3f94:b0:af9:14cf:d808 with SMTP id a640c23a62f3a-af9c654272amr1559960166b.55.1754988293947;
        Tue, 12 Aug 2025 01:44:53 -0700 (PDT)
Received: from localhost (host-79-44-170-80.retail.telecomitalia.it. [79.44.170.80])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a078afbsm2158282666b.4.2025.08.12.01.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 01:44:53 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	andrea.porta@suse.com,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	iivanov@suse.de,
	svarbanov@suse.de,
	mbrugger@suse.com,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Phil Elwell <phil@raspberrypi.com>
Subject: [PATCH] dt-bindings: pinctrl: rp1: Describe groups for RP1 pin controller
Date: Tue, 12 Aug 2025 10:46:39 +0200
Message-ID: <20250812084639.13442-1-andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DT binding for RP1 pin controller currently lacks the group
definitions.

Add groups enumeration to the schema.

Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 .../pinctrl/raspberrypi,rp1-gpio.yaml         | 35 ++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/raspberrypi,rp1-gpio.yaml b/Documentation/devicetree/bindings/pinctrl/raspberrypi,rp1-gpio.yaml
index eec9a9b58542..af6fbbd4feea 100644
--- a/Documentation/devicetree/bindings/pinctrl/raspberrypi,rp1-gpio.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/raspberrypi,rp1-gpio.yaml
@@ -72,10 +72,36 @@ $defs:
       pins:
         description:
           List of gpio pins affected by the properties specified in this
-          subnode.
+          subnode (either this or "groups" must be specified).
         items:
           pattern: '^gpio([0-9]|[1-4][0-9]|5[0-3])$'
 
+      groups:
+        description:
+          List of groups affected by the properties specified in this
+          subnode (either this or "pins" must be specified).
+        items:
+          anyOf:
+            - pattern: '^gpio([0-9]|[1-4][0-9]|5[0-3])$'
+            - enum: [ uart0, uart0_ctrl, uart1, uart1_ctrl, uart2, uart2_ctrl,
+                      uart3, uart3_ctrl, uart4, uart4_ctrl, uart5_0,
+                      uart5_0_ctrl, uart5_1, uart5_1_ctrl, uart5_2,
+                      uart5_2_ctrl, uart5_3,
+                      sd0, sd1,
+                      i2s0, i2s0_dual, i2s0_quad, i2s1, i2s1_dual, i2s1_quad,
+                      i2s2_0, i2s2_0_dual, i2s2_1, i2s2_1_dual,
+                      i2c4_0, i2c4_1, i2c4_2, i2c4_3, i2c6_0, i2c6_1, i2c5_0,
+                      i2c5_1, i2c5_2, i2c5_3, i2c0_0, i2c0_1, i2c1_0, i2c1_1,
+                      i2c2_0, i2c2_1, i2c3_0, i2c3_1, i2c3_2,
+                      dpi_16bit, dpi_16bit_cpadhi, dpi_16bit_pad666,
+                      dpi_18bit, dpi_18bit_cpadhi, dpi_24bit,
+                      spi0, spi0_quad, spi1, spi2, spi3, spi4, spi5, spi6_0,
+                      spi6_1, spi7_0, spi7_1, spi8_0, spi8_1,
+                      aaud_0, aaud_1, aaud_2, aaud_3, aaud_4,
+                      vbus0_0, vbus0_1, vbus1, vbus2, vbus3,
+                      mic_0, mic_1, mic_2, mic_3,
+                      ir ]
+
       function:
         enum: [ alt0, alt1, alt2, alt3, alt4, gpio, alt6, alt7, alt8, none,
                 aaud, dcd0, dpi, dsi0_te_ext, dsi1_te_ext, dsr0, dtr0, gpclk0,
@@ -103,6 +129,13 @@ $defs:
       drive-strength:
         enum: [ 2, 4, 8, 12 ]
 
+    required:
+      - function
+
+    oneOf:
+      - required: [ groups ]
+      - required: [ pins ]
+
     additionalProperties: false
 
 allOf:
-- 
2.35.3


