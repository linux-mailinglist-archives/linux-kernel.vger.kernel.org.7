Return-Path: <linux-kernel+bounces-827020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B025B8FE91
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 12:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FAD41659EC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 10:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5852FE566;
	Mon, 22 Sep 2025 10:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rfc1Ya1c"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAF42F659C
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 10:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758535585; cv=none; b=f8DOAki9FKMDxjKAB+RZzckNAmTREyur9HTwm99mCzotRSei7VAlYgCotqzRffFqaBbhD6z6d8ookR7m3w69bkDzNS9VRuUK68VIDUWp50CFEAVny/nPAlFDkWKXcA7F9JJ6lfnw+88S58BW77a2gy+5EZKnIwiJron/ZKq+XXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758535585; c=relaxed/simple;
	bh=KcqNz+oFGlUyIngywh1gkusVO3lZGzNZNpQmz6FCtIU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aFjVi08FbEaWmaXI3++Y3V5iQCLQKcqju16sN0OsS2g2I4gNpeIaZu/DQgu4M7IZ5i2iDcNXKgpCmGbGQk7/TuJuOzgsiMa056RmZd3WXzxruigzX1zxgtBGgpsyr3+qXdEpo/1+bebqBMfVCsheBjwOo1VLEe+FR1CPVY7Z8UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rfc1Ya1c; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-46cf7bbfda8so6148035e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 03:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758535582; x=1759140382; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SBuh28KbXIrgcfSkQ8KjquzRGwut7m7Az0UK1qF6ohQ=;
        b=Rfc1Ya1c/MNwkEb/WMTsh+Jr6AeEZ6wAecAAq6a0cryAA2GZSImEb4Y22PTgFZ8qeA
         Vt2IviqJkKDAi7HmzTLjcRFnEgIrfGXnc6avJQu3c5HlvBZhgfpSZ1k380yMiAssjIg7
         L6MtOKJjAbwPRWc1kBdUbU0ejy1dugGGpQrNX6g2aq/eRAZXy2XDVRQ7Yq2v7SoCgkuG
         wNeDGAl3KNWdiIsNDrzGg+Jof3aYjQWwKpA/y4fr3X50JkGLfCi70n/mSFH/+uTpQvmL
         aAkXmt2OU2VxB+w3FbXSBexN3d2ysGmhutzn0BOrCPcIevJK5YSggeB/XeLq8qTsAxTD
         qlMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758535582; x=1759140382;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SBuh28KbXIrgcfSkQ8KjquzRGwut7m7Az0UK1qF6ohQ=;
        b=TWs9Qfz6ChOZ2MXd9JmxUbd+jYXH0OfzR2TQ2dJh5MxUfbvm772NdztkXGg5g79rkn
         8xcavqhN1Gl0klXnq2bF1lFa2ZuBESs0q4Y1BIxTzEF1MtLa1ifzFfx/9iayFAHR5vBR
         zQ/T/jFiOOH6++3XePNb9O3Y0f0yMdQEI0Nsa4rr1UXR4b4akci17Zg06O/ibCOmrhMs
         tlM41lxf9ZFe4iw6nwXgp0B5HL8AQ3ZRgWOxyGPSZtyxjhgUG3VBeU2LrpizjuUtDT1o
         Du7NxyV+wc26iGcbIgnrZKtuib97F4Dek72TG8ZtuhPiuTWg717zI658od6W4qf/aRNw
         Wuuw==
X-Gm-Message-State: AOJu0YxoHsTvUtLk1X+Hh8q3+4AYjTcWpra2OzTLu9uW1QBi9aUne6J5
	17sT2D5b6vrvWaKRxS8blFSEThIz2+kSwc5EVG3PNpyTc7JFrqhec0yZ
X-Gm-Gg: ASbGncvPJOP4ExNzd6nA8XbbCupvPugKXbcZNyW9EW1sK4Jc8tbQCxOULW8JGuEZ2+6
	aM8DO0PKpkvQGqscureALJRPpTBruXE6iaozOletgAr6mgnioZBKZ4sXiXGfs2EwEIjiGwf+4ED
	XDo7PY1XLKMTBnEBFdOSlorPB16CsqAUr5/+0vYC7ZjNU6TWhRyV/mVvbCpbsnVCuCTOLQEbgZj
	J9n16WM0rVxpBhoFUqgnIOwNQEIROBh65PuGaJiOAtY5/16APUopVH+5OmnKzLVjvbKhDTnk3jL
	hLyL8wFlTJkHfWlzGTY12gTTLt0abjB+GoGmQGUSTg+eySbknqqR+M5y8qShS4G49JGUaSMqrLY
	D+VWU8Tz9a7ctOfU56ilo5b4l0lxPwUJTWUGcfhTEj1+t/RmLlkrc3ctvdJZWqkKeo1qNfnXsYt
	VcNOOjJaGEqYa9j7nT
X-Google-Smtp-Source: AGHT+IEHy+Y2fzQAk3dZV6QahdRxDSlEBeTRexcfOlN/UPgG/shF6Jti+KLhEJkls/9J12eMEfDQeA==
X-Received: by 2002:a05:600c:b8d:b0:45d:d287:d339 with SMTP id 5b1f17b1804b1-467ebbbfd0amr108011225e9.25.1758535582246;
        Mon, 22 Sep 2025 03:06:22 -0700 (PDT)
Received: from localhost (2a02-8440-750d-3377-171e-75f8-f2d4-2af8.rev.sfr.net. [2a02:8440:750d:3377:171e:75f8:f2d4:2af8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f527d6cdsm221293315e9.12.2025.09.22.03.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 03:06:21 -0700 (PDT)
From: =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>
Date: Mon, 22 Sep 2025 12:06:15 +0200
Subject: [PATCH v7 2/7] dt-bindings: memory: introduce DDR4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250922-b4-ddr-bindings-v7-2-b3dd20e54db6@gmail.com>
References: <20250922-b4-ddr-bindings-v7-0-b3dd20e54db6@gmail.com>
In-Reply-To: <20250922-b4-ddr-bindings-v7-0-b3dd20e54db6@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Julius Werner <jwerner@chromium.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, 
 =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <legoffic.clement@gmail.com>, 
 =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>
X-Mailer: b4 0.15-dev-0dae4

From: Clément Le Goffic <clement.legoffic@foss.st.com>

Introduce JEDEC compliant DDR bindings, that use new memory-props binding.

Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
Signed-off-by: Clément Le Goffic <legoffic.clement@gmail.com>
---
 .../memory-controllers/ddr/jedec,ddr4.yaml         | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,ddr4.yaml b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,ddr4.yaml
new file mode 100644
index 000000000000..bf1dae15b65b
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/ddr/jedec,ddr4.yaml
@@ -0,0 +1,34 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/memory-controllers/ddr/jedec,ddr4.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: DDR4 SDRAM compliant to JEDEC JESD79-4D
+
+maintainers:
+  - Krzysztof Kozlowski <krzk@kernel.org>
+
+allOf:
+  - $ref: jedec,sdram-props.yaml#
+
+properties:
+  compatible:
+    items:
+      - pattern: "^ddr4-[0-9a-f]{4},[a-z]{1,10},[0-9a-f]{2}$"
+      - const: jedec,ddr4
+
+required:
+  - compatible
+  - density
+  - io-width
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    ddr {
+        compatible = "ddr4-00ff,azaz,ff", "jedec,ddr4";
+        density = <8192>;
+        io-width = <8>;
+    };

-- 
2.43.0


