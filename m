Return-Path: <linux-kernel+bounces-850916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06847BD511C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 18:32:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 752C3425FC5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 15:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B99B313270;
	Mon, 13 Oct 2025 15:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="DDrxncu7"
Received: from mail-io1-f65.google.com (mail-io1-f65.google.com [209.85.166.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99253128C9
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 15:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760369737; cv=none; b=pGWgqyk1EE6rxkM9cTYtxRmxck/HHddmCGNpGoUBStqE94lE+OqjesOVufT8kBL7CNn5oRV22mPPK6JhQkV1JH7ocD6y+bwNgdmFnsdouWCehdUYmtFHFiC8et26jKYlQc7UpeuGPc3Lhn1AM08wD8Kh5SP3rwjKfsn9QpYBQ3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760369737; c=relaxed/simple;
	bh=hkeK1J/xegPc5qIcOqDK54lS/unN+bKpCdPA2OuYM+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VhVaT8Dghmd7vPZi/L3etazuXmVoeO2uMuyGKFdvscOlvP+/z+2jo6o8g1S99oz6gNRXi7jeXbItEJff0Q7ULhvC0386bpa/rhdUHfQZF80vFVzV8kdYsL6Pf4BilNG7s8KRtfbq+5Neu0O0TO0+MxAwng4fne+RQRKJfLwO6NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=DDrxncu7; arc=none smtp.client-ip=209.85.166.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f65.google.com with SMTP id ca18e2360f4ac-93e2d26fc82so242974039f.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1760369734; x=1760974534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ItZ4QqP7CdgD+87y0OCgM795Wvqv9yPDWR/uT7250ws=;
        b=DDrxncu7OIS7Sber7v9EsFaCJa+SDfC9HCiEDpn8eFRSI0PHkoa1UJI+JmMLlaYmqR
         V92aNMjQPUBLqu6LGbkyL/EysPJBL9Ce+nhQAxaC+u5U63FVTGBvxa4v0mMhDbzOaf0S
         oxzCtTjvxx6MwvYzVqXgvT3Uf6sS0M4ktEpYqgyqtCWgAj/uZjiNb5OsvLrybQLGbfDW
         1gil3egM9UuBoxhECvHMTyUoOTc8qxYXagXK5CUG6a852mnEYblgYYrarE0vwq6xG0lD
         EwH+2VuqhJTtYPR7n2sdLBEwMiY+RgyljHADH+Emo7Z4ClWyacsypSy3ZSUzfjjb83Dp
         H0pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760369734; x=1760974534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ItZ4QqP7CdgD+87y0OCgM795Wvqv9yPDWR/uT7250ws=;
        b=rGXivkqX6GAL3ePd9GywqKfL8kd6GQjbglW7HuyqJwecaDDFh1eJOx7Ql5KzlHXO/X
         qn0grW8oFbGFHU9eRoklM4XLl9V0A4lJRWDr7NBV/QFWob9oquJlSRCvrvBR/Vk1TZRa
         46vIIGNAgQ7aeLdRl98Uk/ohpBDJPDlHvqZaDfbzGjt3rgNGPxZcxH3tyJduOGGcT5Ov
         10jiC/0kbHmZyGY27lH4jK08NI2UEPX7wJWoFuncENmLUMNYiwou2rljMELslLZxYn+i
         VmGnrHi++JeTxb+iXIAQ3+ReBGfkoWpxbt0ppyYLxmJfxdwrtnEs1lq3vn6JyRvXY61j
         g9Fw==
X-Forwarded-Encrypted: i=1; AJvYcCW3cPhudRJnWmAR40cqVfVAggNpgS9lka9L8kagPahzQ7iYft+qsR1Iy4encVX8ZqRgzZysaR7M/omWYI4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXOcKaWant5nnn9BcXLPTJHOyxKD28MkDxqXSjW7qbeNwL4BzF
	+ycu7Csoh+J5tSm1jvP96Si/ftMMPZ1tbHfPi2bIcIbQpjiqxhCu//d90LNRK9+aUv0=
X-Gm-Gg: ASbGnctAyMXh+vE+fmbA0f/OJXSgaa4OV8BEYkD/h/PSedq91nM6h0IUa9J/XpOKEAZ
	0HVqHVgr7ME6Ztm5qwQOsG1WoLqA1DjgaFd3hgstEMjxQz+6c3W5oip+DkpBkxAzlnP8YdTibpz
	UEVy+e2NnlgUMBaiGbQV3AMqmPz7gSl8ttxW8eGGv4qyaweynazowPZBRfQ6WODMwuHTnoOaieO
	Ep7MXzDmwDN/LeJaR3ex099mkE63j4frgm4x668pV4W2ficP57Gq0/wzH/48UbdztyTSVbQC5rq
	E7QZsCVqlUPiYdZ5sVKe4Tx8PQDASlQQBVPpp9Aiu22R7T1ncyHaby9gP7urnfbodhsD0m6E/K1
	85wpxFWEtGrxvCnG/PgGenlM5AZGWQb/enRm/TrGSQH/0+NWRolHxp4Pw+yucCoGi/gU48uzHSm
	JxepwBCriSa7h11clO8Zk=
X-Google-Smtp-Source: AGHT+IFmberiHinW0psgBSVXvfzyFWo7xiMin2ObR4QgSx+XvFz7VLt0jdPRSfZZaq11AbbGpmoe2w==
X-Received: by 2002:a05:6e02:1808:b0:42f:a6cf:8afa with SMTP id e9e14a558f8ab-42fa6cf8cc8mr116550035ab.19.1760369734595;
        Mon, 13 Oct 2025 08:35:34 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-58f6c49b522sm3910266173.1.2025.10.13.08.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 08:35:34 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	vkoul@kernel.org,
	kishon@kernel.org
Cc: dlan@gentoo.org,
	guodong@riscstar.com,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	p.zabel@pengutronix.de,
	christian.bruel@foss.st.com,
	shradha.t@samsung.com,
	krishna.chundru@oss.qualcomm.com,
	qiang.yu@oss.qualcomm.com,
	namcao@linutronix.de,
	thippeswamy.havalige@amd.com,
	inochiama@gmail.com,
	devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-phy@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/7] dt-bindings: phy: spacemit: introduce PCIe PHY
Date: Mon, 13 Oct 2025 10:35:19 -0500
Message-ID: <20251013153526.2276556-3-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251013153526.2276556-1-elder@riscstar.com>
References: <20251013153526.2276556-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the Device Tree binding for two PCIe PHYs present on the SpacemiT
K1 SoC.  These PHYs are dependent on a separate combo PHY, which
determines at probe time the calibration values used by the PCIe-only
PHYs.

Signed-off-by: Alex Elder <elder@riscstar.com>
---
v2: - Added '>' to the description, and reworded it a bit
    - Added clocks and clock-names properties
    - Dropped the label and status property from the example

 .../bindings/phy/spacemit,k1-pcie-phy.yaml    | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/spacemit,k1-pcie-phy.yaml

diff --git a/Documentation/devicetree/bindings/phy/spacemit,k1-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/spacemit,k1-pcie-phy.yaml
new file mode 100644
index 0000000000000..c821f6cafcdae
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/spacemit,k1-pcie-phy.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/spacemit,k1-pcie-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SpacemiT K1 PCIe PHY
+
+maintainers:
+  - Alex Elder <elder@riscstar.com>
+
+description: >
+  There are two PHYs on the SpacemiT K1 SoC used for PCIe (only).
+  These PHYs must be configured using calibration values that are
+  determined by a third "combo PHY".  The combo PHY determines
+  these calibration values during probe so they can be used for
+  the two PCIe-only PHYs.
+
+  The PHY uses an external oscillator as a reference clock.  During
+  normal operation, the PCIe host driver is responsible for ensuring
+  all other clocks needed by a PHY are enabled, and all resets
+  affecting the PHY are deasserted.
+
+properties:
+  compatible:
+    const: spacemit,k1-pcie-phy
+
+  reg:
+    items:
+      - description: PHY control registers
+
+  clocks:
+    items:
+      - description: External oscillator used by the PHY PLL
+
+  clock-names:
+    const: refclk
+
+  "#phy-cells":
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - "#phy-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    phy@c0c10000 {
+        compatible = "spacemit,k1-pcie-phy";
+        reg = <0xc0c10000 0x1000>;
+        clocks = <&vctcxo_24m>;
+        clock-names = "refclk";
+        #phy-cells = <0>;
+    };
-- 
2.48.1


