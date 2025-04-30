Return-Path: <linux-kernel+bounces-626703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E46BAA464C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 11:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 675041C04D27
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Apr 2025 09:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B477221729;
	Wed, 30 Apr 2025 09:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wdu5M2BO"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B716621B9E0
	for <linux-kernel@vger.kernel.org>; Wed, 30 Apr 2025 09:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746003797; cv=none; b=nNdmx+43NRiRAbdW/zF4szS0fHU9CxFabHhg7jzGR1RzXYVt2CrSVYfWCyapvPQTYqh9uypyRgTRSPb4DxXxQ51t7KmTsX25bm0XPSwmF0cmY4ut73sjo1JRRhYSzhERvTCNrz/DlfW8mQv/GCFMvOc/EtNunsEQBFSY3WaQR/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746003797; c=relaxed/simple;
	bh=Cc1Ucs7d+DoVlcf66E1KPy7NQ5fP8mutIpm2TD0VDuE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wj8dIPmDJPPtuv10cCOXq/BqIYSxX4vV07ub7JRTmHileO4agqkIUWssxEmGsVmUDlE/VBLbqZ1UmUJpWT3x78DbDvP8eMnYLObKTL2zKzu6sBlPY3bjBRIcMVS4UgpbxQiJSo0zk74T9S3KwRb+JHdvvrtjXF2vYLFNP6x7aPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wdu5M2BO; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ace3b03c043so1110465066b.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Apr 2025 02:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746003793; x=1746608593; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rgc6ivQ4v0OBxVxiMV//REmkxOVzSIsF9RwMWgdL0S4=;
        b=wdu5M2BOvCYtLP31c+R4majTHgHEizvwMZ8fa7CnScROmmjq83XOx0ockoKXnhsj9M
         MifYakA9gftOFQo8n+lsZC9WLc2qBMSdRaVZdS7xXNMKD6YJhW4KLutHkOGCj61X1u6U
         IPercFCxtknFeXqvVnoJmzPmVhTgU2IGhYkjedetnAv+S103MpSLCsJL4LE+HqVbWj02
         bps+A8OHH6CiabIehAsMP0IVupMTGwzx+DRcLZF1IG4oVsRYbqnUfjcx8JigRxCfdMtO
         v3+gnDNgZzfHtmFg99pdDT1vsxRy0YeJpxntlJ85SEERSeyqz2aZ37NPnA8ICot0PUXE
         sa3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746003793; x=1746608593;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rgc6ivQ4v0OBxVxiMV//REmkxOVzSIsF9RwMWgdL0S4=;
        b=pgWphwr/ooFYWB8j1SLD1sHOikj0IPycmjC6TJN3RgZzVVRiB+sLX6TVtJgVH1Ghf2
         LqhKFaUzSdUGuQ9u597pyXtUlyWGbJE7qBgpbyZKt389EwDEHdxKwZpAIIXLFHddlOHM
         u7bODIvtMgiYez2tnuVa9me9OKrX/9rtdacKxEKYuzIj5z0AMAYeLzpGHVgWzFtkVd/K
         WoTUcw7VFc/t/8wnb6h6eW+HtqOR0AQmpz+Q11uoZzQjFkYRns8dIowWgg4l8avbPEYY
         hksBkq1dE1J+2jGMJf40k/7fLzzYNPg+OcvyE8SQ4rcvpdD+TkbIRcjhoR1xrT2Ptxbc
         P7Fg==
X-Forwarded-Encrypted: i=1; AJvYcCW4hwBOXrCuxy6WTrpu9hPbYVPlomYALSm6rSIUCXqEdGGxX38iaVajJocxzNJo/oaoVNe7qJTR7uhVcog=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1t03NYrbEaGp781n5mVtZg2YHqJHn8rDvtaou9VWW+bP6oEBO
	CRsy/l3QHjy3gxW1ZI+5KRq/QPxpWGpDuH2rZFMX1Ar7uPyLik9LeZ8wY/SQLh0=
X-Gm-Gg: ASbGnct8CvDGH/wzEp9o6tp5Z8JVxfubGPDG5YPibg6E9vT+1Yq4QuZE6OoPO3Ya+b0
	iBNDUZUTD976udnQPXPDzW2cRyn1nwyP6mrqX6UMl2pAk0yLOXavlk9CGhlygR+77qX3jO+uCxG
	N7aBIQJIVBRY+QjC8Dgscwa+Wwy6fkmTBMk0+Vx8SdxVh2eGvWMzikxwgvq+pBjSFty2B0BoibT
	8TFJCqgnzeiuAgI/mcnDyUaM7plk1g5iDh8bzpAxylko93Rbjq8u5okqudOPE4re8ulRUB/e7bF
	f3hieo12O4SPIBULNCRRm/jzKiQu7035bJdPchcyg9CT2kjFfZbwjFnZLkFCSVDaBCVBrKt+eR8
	T1xkjYpUbM65zwk89EMXq9NEW
X-Google-Smtp-Source: AGHT+IHh/frVfvYlJV1tmXFwo00h3A1apTHUNVvYyWOBXRDPAdhfFrheDXV2GwC9doZTSaZcj+ITqw==
X-Received: by 2002:a17:907:2d8a:b0:ab7:cfe7:116f with SMTP id a640c23a62f3a-acedc709fe8mr247900966b.46.1746003793118;
        Wed, 30 Apr 2025 02:03:13 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6e41bbb6sm889676766b.28.2025.04.30.02.03.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 02:03:12 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Wed, 30 Apr 2025 10:03:09 +0100
Subject: [PATCH v9 2/6] dt-bindings: nvmem: add max77759 binding
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250430-max77759-mfd-v9-2-639763e23598@linaro.org>
References: <20250430-max77759-mfd-v9-0-639763e23598@linaro.org>
In-Reply-To: <20250430-max77759-mfd-v9-0-639763e23598@linaro.org>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Srinivas Kandagatla <srini@kernel.org>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-hardening@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

The Maxim MAX77759 is a companion PMIC for USB Type-C applications and
includes Battery Charger, Fuel Gauge, temperature sensors, USB Type-C
Port Controller (TCPC), NVMEM, and a GPIO expander.

This describes its storage module (NVMEM).

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
v2:
* drop example as the MFD binding has a complete one (Rob)

Note: MAINTAINERS doesn't need updating, the binding update for the
first leaf device (gpio) adds a wildcard matching all max77759 bindings
---
 .../bindings/nvmem/maxim,max77759-nvmem.yaml       | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/devicetree/bindings/nvmem/maxim,max77759-nvmem.yaml b/Documentation/devicetree/bindings/nvmem/maxim,max77759-nvmem.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..1e3bd4433007341a11040f513bf444866b9e38a8
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/maxim,max77759-nvmem.yaml
@@ -0,0 +1,32 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/maxim,max77759-nvmem.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim Integrated MAX77759 Non Volatile Memory
+
+maintainers:
+  - André Draszik <andre.draszik@linaro.org>
+
+description: |
+  This module is part of the MAX77759 PMIC. For additional information, see
+  Documentation/devicetree/bindings/mfd/maxim,max77759.yaml.
+
+  The MAX77759 is a PMIC integrating, amongst others, Non Volatile Memory
+  (NVMEM) with 30 bytes of storage which can be used by software to store
+  information or communicate with a boot loader.
+
+properties:
+  compatible:
+    const: maxim,max77759-nvmem
+
+  wp-gpios: false
+
+required:
+  - compatible
+
+allOf:
+  - $ref: nvmem.yaml#
+
+unevaluatedProperties: false

-- 
2.49.0.901.g37484f566f-goog


