Return-Path: <linux-kernel+bounces-815596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A81E3B568BD
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 14:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 583301736C7
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 12:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC5A26B085;
	Sun, 14 Sep 2025 12:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LHpsT/Hc"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C2925F99F
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 12:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757853761; cv=none; b=upJps5VsD/MKCSvsiW63+wGIcI4M//ZBEF/1o0A7uiTDs9Tene75XgvN1UQK5kzQJ+Si6nRtk/6Uwgt1l5QKQZzLOWP7DHPE7mJ3sCIZpWePaE60jKHhcwwMWYwlTD9SKpX76AORZXnS20aHPBz3cs0mTi1oi9TWbhwfn4UXauk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757853761; c=relaxed/simple;
	bh=y0sCz1ox1pdVdqC9lyNwJysTnUl+q01sDp++N8XGWHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F45vEjjRCUgqA3el+gJ1OypP8S6jETuJDgcoUOJZ3LdrmMP0MXN+DdPSgKOc2ujzsWLSxJD71eBdy6ZkqGTIQDHSvTy3etd6dO/yMjyOY04uNy0gMEo4ZfsGaqyjtaqMZDS0aCcB13r7BNwlofFtfMlyvDUCljVQwXf4kOM+ito=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LHpsT/Hc; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45ddc7d5731so23950215e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 05:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757853758; x=1758458558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7YlK8x1e1nNbpl5BkBqgVftDE3O74o0MrUDh59tTEnY=;
        b=LHpsT/HcJwdMOk1R6v1K7d7gfNZL5c3gCpcFNPMt6d/dhj7g8tpFb1tGLNTj9/Ve/0
         4Wgp6OMRrhSi5AcxzZGkw4WsmKROi0hKkJnUsuHcASVoKvqIV00p+HLaLFYDBlSOAMQz
         W8H3vGNWgfeV4j6fc698DcIvqhblHNOAzWZDGOzVuhrOMCBWjj/w6Iyf+9f9i/CpfcUt
         9LAWiHnpwJampHPy+xoKhT71YUY5H4uAQ7KSk3MRkc++BQQScNwaVDEUIEZmu525vfWm
         mHNLnXfotArsYxsp5Bu6paQiLgGeCHYoZfQQogcv2CPaKGvt52l9R5zI9wBsPkuNY3X8
         p8+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757853758; x=1758458558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7YlK8x1e1nNbpl5BkBqgVftDE3O74o0MrUDh59tTEnY=;
        b=dkQs7m4o63DxNDVLpLkjlQGcNBYZ1Z6+XHtZ/YDxAS5FpEDmB/wvjN9yrlwxsqzTqP
         w7/0KFJ6mA8ZKI0wHdu9GQ7nn2AZSX5wvCzmTjm0m8tSFDPXKuJAcgMoCeIlwKdtqbPp
         dmUipFwH8v7JZ9bggdIvb+MFEtP9WE2gAmDNQo/3IDfArvJ8VQGr8spt1l8eGhpuSp0q
         JOYSmI9RHUfFnaZRnPEy4/TDqG59z86oKBP9rj10mHqsSZcGkcveXv2odueFNK3UYmei
         3nyEdsIZE/uEhgDnSQLPugqiQe9XQgWnXOl9CFCevAM/t9HmMsheDIUZ/KExjt6racx3
         TMXw==
X-Forwarded-Encrypted: i=1; AJvYcCV5wYvVoTozqCtd1g8iqI3k/Ons0YIdTJ8wqFsO8uciA/TzuMHMViskDrppcREMTLIwzwyVNr8/79BEIpk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIGtCd9j6MjJPdqyqxOcufe1ZGd7OKjgrAQImC82mK12BY/q6R
	Wntymy0X71GnkOTSKkztNxRWFtXhCpVLlfzs0/+LxZjo6/2n+drp+a7E
X-Gm-Gg: ASbGnct4eRAUnwKNboZrJsE+1KBxsTLIp6SOImfvfNPqQMh+Zaw7VfNgTZwo1x8s8+I
	L2fQcha2DPJWCzNtTT6mQHYXppH6ycweTpEKsBaViM04NWYMZ0KWr6XV1LNozLlE1irdGENFjrn
	uZ+bY74nY3MjmMjrRr512W/OwjJlSzaMKk03Uprp4tvXFMVIMQUT0Qs6UwIfosci31BhGYI6wT1
	sTFDE4l+JKQIO0aWrAfpmxlrxeGoe8fxLDj5O7PZFCn+CQ5fUN3MoKrOaietDcIlbHg0+7hr1Jt
	+L0xVzhO6L0ulqUuKu4Q75P+42vBtO0opZ9Py2riQrG4tFN+mycqqmztaxmMqR7ccS9uvkCLcXN
	I+VT6hzp8YEyqt0rIzNkqV3tgL3lVUWBoWGqGrwFMpfQRlmyEO04wbwO7bWOrvYrPgxA+prvmRy
	Be0/U0L3zz
X-Google-Smtp-Source: AGHT+IELVFIlesJEmaJQpWXNNvn35JfGIecuwQDqOHfPhALJRBcTy5rG9hu4+nxlOgJqxNq0ak5Xxw==
X-Received: by 2002:a05:6000:178c:b0:3de:78c8:120c with SMTP id ffacd0b85a97d-3e765a139bdmr7119284f8f.38.1757853757902;
        Sun, 14 Sep 2025 05:42:37 -0700 (PDT)
Received: from ivaylo-T580.. (91-139-201-119.stz.ddns.bulsat.com. [91.139.201.119])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e9511abbccsm3727773f8f.9.2025.09.14.05.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 05:42:37 -0700 (PDT)
From: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	=?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/7] regulator: dt-bindings: add documentation for s2mps16-pmic regulators
Date: Sun, 14 Sep 2025 15:42:21 +0300
Message-ID: <20250914124227.2619925-2-ivo.ivanov.ivanov1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250914124227.2619925-1-ivo.ivanov.ivanov1@gmail.com>
References: <20250914124227.2619925-1-ivo.ivanov.ivanov1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The S2MPS16 is a PMIC found in exynos8890 devices, which controls voltage
regulators - 38 LDOs, of which 11 are used for CP, and 11 BUCKs, of which
1 is used for CP. Provide documentation for devicetree definitions,
regulator naming patterns, etc.

Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
---
 .../bindings/regulator/samsung,s2mps16.yaml   | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/samsung,s2mps16.yaml

diff --git a/Documentation/devicetree/bindings/regulator/samsung,s2mps16.yaml b/Documentation/devicetree/bindings/regulator/samsung,s2mps16.yaml
new file mode 100644
index 000000000..ede87d3b9
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/samsung,s2mps16.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/samsung,s2mps16.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung S2MPS16 Power Management IC regulators
+
+maintainers:
+  - Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
+
+description: |
+  This is a part of device tree bindings for S2M and S5M family of Power
+  Management IC (PMIC).
+
+  The S2MPS16 provides buck and LDO regulators.
+
+  See also Documentation/devicetree/bindings/mfd/samsung,s2mps11.yaml for
+  additional information and example.
+
+patternProperties:
+  # 27 LDOs
+  "^ldo([1-9]|1[0-3]|2[5-9]|3[0-8])$":
+    type: object
+    $ref: regulator.yaml#
+    unevaluatedProperties: false
+    description:
+      Properties for single LDO regulator.
+
+      LDOs 14-24 are used for CP, and they're left unimplemented due to lack
+      of documentation on them.
+
+    required:
+      - regulator-name
+
+  # 10 bucks
+  "^buck([1-9]|1[0-1])$":
+    type: object
+    $ref: regulator.yaml#
+    unevaluatedProperties: false
+    description:
+      Properties for single BUCK regulator.
+
+      BUCK 10 is used for CP, and it's left unimplemented due to lack of
+      documentation on it.
+
+    required:
+      - regulator-name
+
+additionalProperties: false
-- 
2.43.0


