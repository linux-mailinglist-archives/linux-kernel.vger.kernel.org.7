Return-Path: <linux-kernel+bounces-781004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B522B30C34
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 05:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E56351D025A3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 03:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E580B266568;
	Fri, 22 Aug 2025 03:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="lZpte2w5"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9920A26E712
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 03:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755832004; cv=none; b=ZqWIRdvb1ZtsFXVl3W4gqumwAr9v53gHV+Piz8m7Y2Zxt6/LlTh3ZTjI/f7dwguA/AwnR/OZAVdohgEBbOwElPqASAdaXyqk53qUFiQYw1ioBgC+kYa3JkOuvCklvv8we7w5+Bhv/xJ4JSCUZHSDpMs597H4pn74XbRA6gNhJJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755832004; c=relaxed/simple;
	bh=k16Ro7327MWHaqNkOpPs6wLh2gCwtpI8bM29orBEHX4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O69ewDuIDcqH4msTO0e5EHlD25LpXtg5xnJOvTi1QHfPWZ3LoBwq4P8LJmQvLdEXMbF6jMZriHLOFqBrgOiTSHFSHCnQWY7BrxDZxsWACyd9YJO0LUcXDqeFxiKJQ9hxyZaG0MS9C0SdK5EmqlBKRHnDqP9l8dkjIuMXJ8JEa74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=lZpte2w5; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-32326e8005bso1858670a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 20:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1755832001; x=1756436801; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aaYtJX2FWb8MRA+YGF1PwcizqXL95f52x/ivDYOROU8=;
        b=lZpte2w5A/e2BYmZqc8LzUUQOOPf5FzgfjJMhxnOiGa6ZtrADFkWLkKPN39xxaajfM
         TrBwf2s6IMff8wa1/JlbILAg40U4dgTLhKKxHavugDQw3Pa8/aruzIpD1iFuDlTqtEkP
         7rm+I3nzESX/tNql2rW+SewedQGL1kBjTN3oCmTOuF5N1u+EJzA690kFRySJ/b1nGliQ
         9iWmgt01JY38rTCYNMZp3yMr5NqYOiXEcQ+g8/9C+ALdtgYgZRbNrUERQQq4f8q7lhm4
         KomsulYJBNhg4eE0ea/BOYQ0iv0Y/2eCbISzksgtzclY6E7sE/B1B4yyiMQVa7dnRr5v
         FY2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755832001; x=1756436801;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aaYtJX2FWb8MRA+YGF1PwcizqXL95f52x/ivDYOROU8=;
        b=uhdXiCw2PiEo+ORtmPPQztO9FsGVqCtdN1092YFPZMih+k8qrSfmq8GzVgYlyFuROC
         QokcpaSdl5RChOd6uCnIEHPTeB3E91wF8yKy0a+fqDDfnzyh4NeIMXck/TT1efKG4tgi
         oRpBgzVujru0sOM+3aDZ2mWEfvfsBbzFou/LZ2RLlqYcMDgf+KjzkULIqwEs3WMv/dY1
         4ziEwj/ZhNy2jJupc0Ko0/w5HJzYV3Yq5WoweQonGt4CYKAsNMPA9Bft+nY7NeA1QjB0
         4mtpIOZVT6vQeOY+GokXp7yJJo+ULSLbix5CGtOFznRsga31AAsS6f8MpPBaKTpLA7gR
         I7wg==
X-Forwarded-Encrypted: i=1; AJvYcCWpxZhz2Wm/s1k7HMV1of8zPDK1w5S+KOVytM9aNtu4dQly5h/CnAnnbsXcmQfR665gDnitDkLwbDrg4Zo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRuMEgluJN+0v6tCa9NTjsHkiVss4K8xGp66pRMGYp0uOsU3fE
	bZx7GJEbb5JGVedMFchiPiZRUxTm3tT9jGXz21Xzy/Ta3jAE0Sb0jUi9nhBJcpMvOP0LGBdHLnX
	LdX9w0kGegqrk
X-Gm-Gg: ASbGncvNOPlpltHG7BhGnetML0qhd9YFNPxixxagkzmpPLoFQlfsQDl4+dc3EOGQLhz
	6yaAprYe1oj7d6nXhLVrBQpWaOAqAyDlAURkyUDdSLhRmtv0Pl532Ac8sbm9Pv5zvuQJ8c6/Nz3
	oadCCBnWC8c3PI3pGYAIl+Qly9mkrAJFkTRB1OaH9ld3tlCqSL9wCuYTfKoishvi7dNf9l4VynQ
	y0lxj9vs+LMNYtg0KL85lLve9/Ao8FL3+u08K+pOCHfDp92sEODRnqHrJK1UbbODBM/dw055CTi
	3NSyW4t2GDNAWz7WSy6e+Vq4JvapraxTaWy6kGAJtgShMhGC7z0dOADthN8SgH7YtCjaFmvvVwH
	r3F5+ZRX1LKQ4fekxeMbrdu3fM4jfXyfJ4A==
X-Google-Smtp-Source: AGHT+IHtoiI+ywaKLlu/wESYvwFaF1Wdo5+3G/aByEkmXZSAYsSzFIutpoI18vcBU1inhQ9OszGlwA==
X-Received: by 2002:a17:90b:2c84:b0:31f:ad:aa1b with SMTP id 98e67ed59e1d1-32515e3bfd0mr2287803a91.3.1755832000590;
        Thu, 21 Aug 2025 20:06:40 -0700 (PDT)
Received: from [127.0.1.1] ([222.71.237.178])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b47769afc1bsm2756777a12.19.2025.08.21.20.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 20:06:40 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
Date: Fri, 22 Aug 2025 11:06:27 +0800
Subject: [PATCH v5 1/8] dt-bindings: dma: Add SpacemiT K1 PDMA controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-working_dma_0701_v2-v5-1-f5c0eda734cc@riscstar.com>
References: <20250822-working_dma_0701_v2-v5-0-f5c0eda734cc@riscstar.com>
In-Reply-To: <20250822-working_dma_0701_v2-v5-0-f5c0eda734cc@riscstar.com>
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
v5: No change.
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


