Return-Path: <linux-kernel+bounces-837298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2999BBABE6D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 09:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F095E3C2E53
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 07:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B6D2C11C7;
	Tue, 30 Sep 2025 07:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b="K4oxJtsR"
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C2C2BE65F
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 07:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759218664; cv=none; b=DGacwyME9MMj8/FTmQ1zvrXvKR6GUvdnq9quWy9NOeRyX0646KmEhTJdINFEIElhdX8iwgmJY52oQc334jbqM6TR5gfTOqpqJ44EwYVqiY8jJQO4VGG8yhdY74uwsQu4W5XbyRjTdACmifBreVFkMcI9geUSc5y4KEXP0QNjanI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759218664; c=relaxed/simple;
	bh=vi2rW0HFsywcmOwrE1uwDZpSS77cZqzVGwj3Sjfo8Tg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kj1mGjk8y+NAEjzcukMJrFCfR9gV0lnmj5W3WSnXJcxRsTJ0U/JGx6+BvRInMXW+OLqXB4kKyDqZ2JF3bEmRWzApSddK4dLkiDc1ZcCs6CPzZgKiBk/mYHswGFHnuGwz/U1N3D4AQw0hUlOUd0h9i0mJRv6aO6RoNOsYBjpu+M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com; dkim=pass (2048-bit key) header.d=huaqin-corp-partner-google-com.20230601.gappssmtp.com header.i=@huaqin-corp-partner-google-com.20230601.gappssmtp.com header.b=K4oxJtsR; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=huaqin.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaqin.corp-partner.google.com
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso5245205a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 00:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1759218661; x=1759823461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a/whcb5d7/6RJGlKNOHW7Q8j/jljATqJnqXZint8Jsw=;
        b=K4oxJtsR/vCVgBtvj65v7OLdYPor08syTPSCDfyzgcGxcdwpz63etD/eEHGnCHWBUF
         1mS1C9QORkaqEnrX51pWm/Ma1mVlI3sRtFSuiUB9JBkgqTnFv10txshahDqrMv4nV37i
         EVc2+PnuiCzjC3mjHJ/rm87XSTVGaQWiJFXnm9vTsFP7skvEnBHvAFTip/9TATAdq8NX
         P9BAePEmCYbu2lbDR7F4Pj3ieiqLClg+2u5rU2ZounV490amh8XZ5DcSQQtTzHd8pKTv
         VeMFWvGLkpAuVzIAhEdf0WG2PIYeFxnNn4uwYpLrmokTGqz9iiHzSo5zcDcwXGmfuOn9
         sJ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759218661; x=1759823461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a/whcb5d7/6RJGlKNOHW7Q8j/jljATqJnqXZint8Jsw=;
        b=W4nIsMK1uS04hZINWFmRXeFABKJWqk/rnGxQ8aPOF0yuPLOEDGi6PtUI2xsUf5sGw/
         qcoR3bff47WTQTlO+VbKpD+DDG2Em1XXFXf171+8iRvdTjQMSZM/9K6jw9aFd7vy7PCJ
         7r0akP+KI4BV4x+5Sou9sz682NJ2i4hv/f3iSR0dep2GxUZ6ffP/ClHO4wdmse5jJAO3
         D5k+qBDVjztNH9P5rbzEw7GzKN++VxKUDaswJmlMWZWeF/y0RnIpv8h3VexdCpUCi5io
         ocdEizKd6cf3/XniFFWP7eoFPCPNs/FoM1DMgGisHqwLK2DpcNFay7aVnRh2XcHrsoBq
         wvnA==
X-Forwarded-Encrypted: i=1; AJvYcCV7zsLIW/6ydA+AwwXj0W4S6aW7rBTwB6bMqTZIimt7g1+0E5GvaT5w6XBauwYyxQOC1SbrDox+G78cWok=@vger.kernel.org
X-Gm-Message-State: AOJu0YxusB9N72XCkCmPRiTOvuACLyP4gt4DPiHq5le8rHhl+KW0CZt1
	WEH288aE+JcxFgK+uFB3w+5z/LQrsxEVA0d/ADpZYrcy856ng1Pu0htYAnjwdByESK8=
X-Gm-Gg: ASbGncv/WO9Dwnm01jgUnN7JNlqUonM83rx+I/qHxcvvJxM5/yxNZALYIVcH8CQBwX7
	czoBRdUG08m5fMxVAV8Pc5jcO6nuNTNHpzWOx4fvRx2a0OYuwQQvbykP1lHgNjxAD9hTtMUm4wr
	aE7voE1ffzOtQwTNSU6aXsKtfotKYT6YyDGQSZ9rQCIXXUq6CRU235dBnhPhP96uRcks3I9x5BJ
	QR3/M5bXPNlfslwFuMd57E9z8of+9C0UX9G/l2hqAfkA0qtmNfzDC6771hUOCO9rl+O+ic/O1Ih
	8wPv8nT7CIMA+NM22o5oLhcQAGD2ZuWncMbcS3y5y4J1rtDlArDf35FbFD4NoAAn4iYbbHzQRqZ
	fl3xhXj8ONli6xmQ3VVnmPrJJDDkWJW4o1jkjJlTOOKWf+yWfVRaSvsdoCYf7bKRhDtglzYuBTi
	uK0vTg7KjN4fAlfle2114V7TLkFDwa5r/mmEQdf+s=
X-Google-Smtp-Source: AGHT+IE27yfFnalXswyaYjSz94Su9vVfjr1kOzMMqId+LH8jlsFm4Xvsohy1cY8MeUbkA9K+KofzuA==
X-Received: by 2002:a17:903:298b:b0:267:8049:7c7f with SMTP id d9443c01a7336-27ed49df3bemr209524225ad.7.1759218660594;
        Tue, 30 Sep 2025 00:51:00 -0700 (PDT)
Received: from dgp100339560-01.huaqin.com ([103.117.77.121])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed688223dsm152313565ad.86.2025.09.30.00.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 00:51:00 -0700 (PDT)
From: Langyan Ye <yelangyan@huaqin.corp-partner.google.com>
To: neil.armstrong@linaro.org,
	jessica.zhang@oss.qualcomm.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dianders@chromium.org
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Langyan Ye <yelangyan@huaqin.corp-partner.google.com>
Subject: [PATCH v1 1/2] dt-bindings: display: panel: Add Tianma TL121BVMS07-00 panel
Date: Tue, 30 Sep 2025 15:50:43 +0800
Message-Id: <20250930075044.1368134-2-yelangyan@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250930075044.1368134-1-yelangyan@huaqin.corp-partner.google.com>
References: <20250930075044.1368134-1-yelangyan@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device tree bindings for the Tianma TL121BVMS07-00 12.1"
MIPI-DSI TFT LCD panel.

Signed-off-by: Langyan Ye <yelangyan@huaqin.corp-partner.google.com>
---
 .../display/panel/tianma,tl121bvms07-00.yaml  | 85 +++++++++++++++++++
 1 file changed, 85 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/tianma,tl121bvms07-00.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/tianma,tl121bvms07-00.yaml b/Documentation/devicetree/bindings/display/panel/tianma,tl121bvms07-00.yaml
new file mode 100644
index 000000000000..e654b86782e6
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/tianma,tl121bvms07-00.yaml
@@ -0,0 +1,85 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/tianma,tl121bvms07-00.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Tianma TL121BVMS07-00 12.1" MIPI-DSI TFT LCD Panel
+
+maintainers:
+  - Langyan Ye <yelangyan@huaqin.corp-partner.google.com>
+
+description: |
+  The Tianma TL121BVMS07-00 is a 12.1-inch MIPI-DSI TFT LCD panel.
+  It requires multiple regulators (AVDD, AVEE, and 1.8V logic)
+  and an enable GPIO. Optional properties such as backlight and
+  rotation are inherited from panel-common.yaml.
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: tianma,tl121bvms07-00
+
+  reg:
+    description: DSI virtual channel number
+    minimum: 0
+    maximum: 3
+
+  enable-gpios:
+    maxItems: 1
+    description: GPIO specifier for the enable pin
+
+  avdd-supply:
+    description: phandle of the regulator that provides positive voltage
+
+  avee-supply:
+    description: phandle of the regulator that provides negative voltage
+
+  pp1800-supply:
+    description: core voltage supply
+
+  backlight:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: Phandle to the backlight device.
+
+  port:
+    $ref: /schemas/graph.yaml#/properties/port
+    description: Input port of the panel, connected to the DSI host.
+
+required:
+  - compatible
+  - reg
+  - enable-gpios
+  - avdd-supply
+  - avee-supply
+  - pp1800-supply
+  - port
+
+additionalProperties: false
+
+examples:
+  - |
+    dsi0 {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      mipi_panel: panel@0 {
+        compatible = "tianma,tl121bvms07-00";
+        reg = <0>;
+        enable-gpios = <&pio 25 0>;
+        avdd-supply = <&en_pp5800_mipi_disp>;
+        avee-supply = <&en_pp5800_mipi_disp>;
+        pp1800-supply = <&mt6359_vcn18_ldo_reg>;
+        backlight = <&backlight>;
+
+        port {
+          panel_in: endpoint {
+            remote-endpoint = <&dsi_out>;
+          };
+        };
+      };
+    };
+
+...
-- 
2.34.1


