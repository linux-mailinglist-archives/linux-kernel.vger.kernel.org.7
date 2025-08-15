Return-Path: <linux-kernel+bounces-770187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EFA3B2783A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 07:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D764A1C24192
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 05:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD1823D7F6;
	Fri, 15 Aug 2025 05:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="UpNj5DCJ"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A9E202C3A
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 05:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755235064; cv=none; b=PGt/hUMCX0C8Npepm8RzWuv/AHS9i8FnxnZzGGzfpZcwL3RNl7zl3poRwovAg8TMCkamv942QEC/Oo/jcyhjzYMuwF5RetUj9rA0zfVoeJKVAhkZCAxS+I+m1eWX/Qx4ROSMv6ySOCkgrub2d5urRdVTm+7sATZIew4K0BqbaDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755235064; c=relaxed/simple;
	bh=6QcJsvCWjNFQSfDTaVO5lPp4wDXAMgMQw/aQAKOTWjU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z/DFbaxc4Vpf5eETcrZKy43MdN0sRPHKH2hjQrOnzb5OKcHrBpmXzMUIwMiAngPVVqav6Tp7qlTrYerwRMcaFdL9WNT67azeq01SOVQ5Rzg+s10bFK+WfTSfQvAyMUHCK92WsfEW+TU6PlgL1MfMmjMCl7Rbs9y9+uGtohX0ca8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=UpNj5DCJ; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-32326e20aadso2177968a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 22:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1755235062; x=1755839862; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6vkEUWx4ApcUAYfHaiLA5bQPo+3iU22SJCSyaMQIr1g=;
        b=UpNj5DCJrVsu4Yr/ZAiZSHrRrp8wj7xIE9RjEJERgsOHaNu+upGn4QOPqhDz3+wgjr
         +AzCRxL6L3L1AVC3Z5QW/gYE7BXJ6zvL0+IedDtRT5K6CDq77tHDX5dAanEHhb0nl/U3
         +0ioenNlm/RHqHUs5w9LEXDEcLitFq1nIfROma8aqyBpTA8ev8ZCl5D3Omv8oQ+MEh/q
         oMvnGOOIYY771lLBQFLTABx0UH6JSSdZnAtmJPHTQmcYI8qWvg0zDiffZ/jf+kJSLLZP
         ko6sLwmzxI90Jxlz5dghoR4xPZtyKZ/dmzb5j2nHDYTqQYb0tsQIULoFyzig2QAlsLr+
         9e5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755235062; x=1755839862;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6vkEUWx4ApcUAYfHaiLA5bQPo+3iU22SJCSyaMQIr1g=;
        b=TguQKJA8uF8c4+y3kWqZGdmuoVh4Qof80082IyZYhavmXiBuFDRT+nSSKGfewS8MUo
         AwYAcrnwPTSbodo5VT9uxzp6IxZhokq5bs1TmlU/j740SSaB3RG4zi7aHBi9ErbRGBbH
         TpsSpkiRmrDFeL3LpQVsvq2eBLksKToDxFuPRbItFALnZP5T46ZPcdKV1CCUFQHsnRRH
         ev7H4Cwt5+ep4zgkanwHjU2Tzb8Tjq+awzEzXR4nSUBOLFeX6gwJymTzaQnNIpYH2c5k
         Aa0X72XflBpcI4hv2dpN8edGNu9WDoaCqt6NXDxk6cXueuFpyymXCswQf+lsFIsUN74N
         H69w==
X-Forwarded-Encrypted: i=1; AJvYcCWms2cX24t50CyVDXQWSk8L1MA+1jHg0EsfDfS8izITQ6wyDoGBGhtPsu3QAoVfuolV2vf+aydgEKGMrT4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrJDGjU6nPDq6VbtiFMDb8l2zTdSEe2vCPty1Un1iiXsSrI+T6
	9TnoOqMhsm9CCLFxh5e5cdc3WjK5nAPXIPRyHiEsjmrxQ9DM3zpaCcoU/0K5f9FCTvg=
X-Gm-Gg: ASbGncseQRFfRNsb1nUge5OTLtlfXzTW8Np/uJP1ZAOE+s/AygaUfpnJ7vhyGF18K11
	ipeN49E8oZD82RJgAqX8X+V7CtqvXwFnRdUiBxViSRLPVxwUNBm7Gq1t74SUyklgaferBL//GjG
	kA+xdHHpyo/ELk74lwRisc0Och5GBMfTi4OuzXMMWs+6tuJJzzHgFF0OMTT6ZqqlUpQngioJDh5
	JmLfhPoZ0l6cm3bOsp8VPsUFLiEDkqYVZRyjrxkZEqNsPBpngafKPhyRaEsRF2JD1+ramqi5dtQ
	KH7DbvAtIZDumLoDgAasoKWXogEyQDLhm7WwxTYKDRhZyLvr0uRhIKlHf9QCs8xd5nYfQzCu47z
	mfjOBucaaA6mWLKYe48Vf5Q==
X-Google-Smtp-Source: AGHT+IFTKeXgEnlIDy0KqXwtx+2VP65MxZYH7QZqWJoZ/KdOMgZpYOBqgpq6r0AT7UDzWXnhv2iXng==
X-Received: by 2002:a17:90b:5282:b0:31f:1a3e:fe31 with SMTP id 98e67ed59e1d1-32341ebd876mr1637598a91.11.1755235061634;
        Thu, 14 Aug 2025 22:17:41 -0700 (PDT)
Received: from [127.0.1.1] ([103.88.46.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-323439978a4sm373212a91.10.2025.08.14.22.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 22:17:41 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
Date: Fri, 15 Aug 2025 13:16:23 +0800
Subject: [PATCH v4 1/8] dt-bindings: dma: Add SpacemiT K1 PDMA controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-working_dma_0701_v2-v4-1-62145ab6ea30@riscstar.com>
References: <20250815-working_dma_0701_v2-v4-0-62145ab6ea30@riscstar.com>
In-Reply-To: <20250815-working_dma_0701_v2-v4-0-62145ab6ea30@riscstar.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, duje@dujemihanovic.xyz
Cc: Alex Elder <elder@riscstar.com>, Vivian Wang <wangruikang@iscas.ac.cn>, 
 dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, Guodong Xu <guodong@riscstar.com>, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>
X-Mailer: b4 0.14.2

Add device tree binding documentation for the SpacemiT K1 PDMA
controller.

Signed-off-by: Guodong Xu <guodong@riscstar.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
v4: Add Rob's reviewed-by.
v3: New patch.
---
 .../devicetree/bindings/dma/spacemit,k1-pdma.yaml  | 68 ++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/spacemit,k1-pdma.yaml b/Documentation/devicetree/bindings/dma/spacemit,k1-pdma.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..ec06235baf5ca3ecffe7dba9bb425b242985660e
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/spacemit,k1-pdma.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/dma/spacemit,k1-pdma.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SpacemiT K1 PDMA Controller
+
+maintainers:
+  - Guodong Xu <guodong@riscstar.com>
+
+allOf:
+  - $ref: dma-controller.yaml#
+
+properties:
+  compatible:
+    const: spacemit,k1-pdma
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description: Shared interrupt for all DMA channels
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  dma-channels:
+    maximum: 16
+
+  '#dma-cells':
+    const: 1
+    description:
+      The DMA request number for the peripheral device.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - resets
+  - dma-channels
+  - '#dma-cells'
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/spacemit,k1-syscon.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        dma-controller@d4000000 {
+            compatible = "spacemit,k1-pdma";
+            reg = <0x0 0xd4000000 0x0 0x4000>;
+            interrupts = <72>;
+            clocks = <&syscon_apmu CLK_DMA>;
+            resets = <&syscon_apmu RESET_DMA>;
+            dma-channels = <16>;
+            #dma-cells = <1>;
+        };
+    };

-- 
2.43.0


