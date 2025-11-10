Return-Path: <linux-kernel+bounces-893355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BABE5C47241
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 95E854ECCA1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 14:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B443128DA;
	Mon, 10 Nov 2025 14:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zti/XGFK"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0B130F948
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 14:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762784518; cv=none; b=c7JkKPzumVxpELlrbWo7vWUT6Mznj+m11pGooH9ztIK9GSeCH0S38KjXz0aXKyjmmGTxc+DwbSUs9fKESyt36rfbjECwuxsFf3F0W/mxy/vWTshHjXQ5idOMIZ98YPIVIkLq7ZmlvK/Vna3YCcewdiMvAlFuJeyfgOxyoz0URrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762784518; c=relaxed/simple;
	bh=DYAmFEfeuAP/0kFyWrWK4qPN9NiVgcwUSbl++/cpyfM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sM/L8b9u2wtomJK5ZyUzArAGkg4SB08GWOBdb9oIzHh80zo0TEP+T87av/ep0NRwMoXw6amkPsUSgxmRy3ODGxDSrdHzLkfEwy+RdvMAwlCjPiZgo8ZT3TF4L9T0DmA0FlF66A1UTMQanjlXnuGjU7qgb9/ftH7CAv3YqjZQaQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Zti/XGFK; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-475ca9237c2so16634855e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 06:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762784513; x=1763389313; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZY1J2OCEXaFSYKftIBdHCuhEGEDWy75TTPwxAO8hqL8=;
        b=Zti/XGFKg3+aK3g5vdYS8Q4eZ9ZdRpUQc5iY8BPRLBq+QorA9BM4iXsn5Zg5tDxF/7
         wO0zQi5eOhYNxrXQ8inWXCb8TbMVE/+qEkJsDJdB11I8vZWJ2s4ttBr7q2znONi5fAh9
         gDNnYYqnauteqErdU0fc/+lfiBJp0gZeA+hbPEmNjigMUb7a82Pq/sYLFAnpqyL5eBz5
         w56oCa6vvptc8ohqnZQAxlo1WEzAYzZ3jerJzIPNU9DCjEDJSOTJAE6X+gu2bww5CpP6
         OrDya/CS9sc4b+1Fks+l9Vvr5kDWnZXlfJzw19PxY+gneLR/rq56Zm+QgeOMqOO3uZb6
         d6xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762784513; x=1763389313;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZY1J2OCEXaFSYKftIBdHCuhEGEDWy75TTPwxAO8hqL8=;
        b=mMuIkz0eci2T7AddvjAc8lyLuQQPgZ/vFhjZH2dtKGPuPPMAURwrWxRvugn2m8oWwO
         4G0IR//kv2Ti6bbKRIio6KA3rYxah1eChFGYwXP1vWBijRyuLAbyzOzEE7UHF0wDTtvk
         r7U5Fk4+3oVPQ66rJIy9kDKORA/CoKpH/QBICfqy8UIl0LChs0fG9FtLkAWWdzIBwaHD
         UUZxS2btPt9UQ2pkuno7NVBO4cBLE+VsevDjrm6iLULLfySYkzW5+J2msGQp8NqWF1CS
         R3yCBN9A9mmlgrFic19Rh5XHGyQekBJ8uqCs0xWF2gCJpFEsg8BgKGloMQZtuALoXeEN
         4DSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUADNia7ZQ+9wsR8mO1SSV8uvCKK1pzLCtbZnOdp8Zsct9ZYgzIEIXsp19L5QSweHqQ8xATz2tlefHUjBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRJYFoDKJ4CcpwMYvmj8sazQ4FlxSzrBFeCarrxROQq7GL41l6
	F3DgQKaV+Cs/3UhLwmN2s6kgprlg6gOIRaAE1zKkDxkuVg9F+8rGibWfRXPJNts2VUA=
X-Gm-Gg: ASbGncsxQwIeKfKofXHO7KH4imNRg+m/puyUZxt02jSvqS7XFm/cEldJcaafzg7FLNM
	TAdOIJ+rGHti9L6MFlXPC8jdm4hLOgfoodB8KyyL2JjaNUhoWIhk5GpCPDn3v4nnvMXQapjODKH
	1C6XtaGX2w5FEMknvWqqOTeB1yjhg0XsTRovdteG7+Lf1IhmfSmakHeapZdrtBeyd/KPyyZfMXG
	KdcyF7YciZJZC2da6yGXqYgFWhgq21nXFUZx2B+W8jimU6+/NlTwHw/c97Cj53afghuPLMIV+LG
	EUVb74RWC17K+avqNHrxczjcDXW2FigVHKIVn2YRp+rlKQdQh4qBrNLxendcRPLGpbOz3nlDNUU
	5VgU/FtYjs4EbZR0KMBSb4NeZnnfrf9w9Ma3wuTQNf+YpqBovCgqfwg+/n5T3pFfpRs3dN7Ja+S
	gW9xAsTt1FqHoCvPvDQDGFXRDWu30UUw==
X-Google-Smtp-Source: AGHT+IEH4+AQIaWKbE5EvSCIFcmC8+p5tN348VBTlGoPy1JRkvFmx0rN/o2SvoWUsZH+gxPapwjxjg==
X-Received: by 2002:a05:600c:4f12:b0:477:7d94:5d28 with SMTP id 5b1f17b1804b1-4777d945e9amr28381465e9.7.1762784512660;
        Mon, 10 Nov 2025 06:21:52 -0800 (PST)
Received: from gpeter-l.roam.corp.google.com ([145.224.90.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4776a953414sm104369435e9.0.2025.11.10.06.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 06:21:52 -0800 (PST)
From: Peter Griffin <peter.griffin@linaro.org>
Date: Mon, 10 Nov 2025 14:21:40 +0000
Subject: [PATCH v4 1/4] dt-bindings: clock: google,gs101-clock: add
 samsung,sysreg property as required
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251110-automatic-clocks-v4-1-8f46929f50b7@linaro.org>
References: <20251110-automatic-clocks-v4-0-8f46929f50b7@linaro.org>
In-Reply-To: <20251110-automatic-clocks-v4-0-8f46929f50b7@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Sam Protsenko <semen.protsenko@linaro.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>
Cc: Will McVicker <willmcvicker@google.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
 kernel-team@android.com, Peter Griffin <peter.griffin@linaro.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2969;
 i=peter.griffin@linaro.org; h=from:subject:message-id;
 bh=DYAmFEfeuAP/0kFyWrWK4qPN9NiVgcwUSbl++/cpyfM=;
 b=owEBbQKS/ZANAwAKAc7ouNYCNHK6AcsmYgBpEfT7cuxMR4Qavzcu+MI7MsZdjT2P9P9540K2u
 AVlNT15fnKJAjMEAAEKAB0WIQQO/I5vVXh1DVa1SfzO6LjWAjRyugUCaRH0+wAKCRDO6LjWAjRy
 urAED/45BejlCepbVCDe+A7TfLtxoX5YhABGdmn/AlqD2O6gyF+MbOS9CyyANOF83DbYgaCsKKF
 YYxOFPla+2sN9Bnv/2VwVjspMZJwYVevFqcizD60X15lQnDPKfzoazm9sfrHVBDT9Urt9KWR5sV
 ljKnOsdCF8PMecF0wCqRkCWr2TD0qMbTGDRgeSeaA9+e21MQJDMeG8RGetEOLbukXXBLa/CxT5b
 FQtVjQVr/B7R96scArWknrdhlo3UWW1A26h0xe1dPKx/C576IkL+BAjUeFhJPKcfagE/QM6/eN9
 u28znk9aQrKHH+641HL0QP+vnatOncd1eeek2rcTxptVoH2fEt9EomkSTUt50AyyUAOkOgSpYJd
 MtXNSLeFawKI9Mzi/CF4PipaK9GWaxD7Rv/XaA2I4CLVv4UQchW7042U/ET1NqKvRIeH5/K7iwV
 9kBvh0wnZgrwQh9cyrxwMRrPf/ilkbU/Zo+1RG91Hh8Y8TsFGi0MXDKSCdS4Y52+sKJSGsqdoZ+
 x+sD7HTizvoMDY4g/A5Zqxpqvq2CO4RiJlnLMunM8yOYdNzU3YuyLQWljcAoVI+rQNLsNH8dLww
 o+XtvEJmoxgg0tRWyH2TWbRjgHNwTyBr8BxnexvXHbG1D84gkV2BY3Nj//BvkX05xgpQ5itnxVU
 QwHqT1nFB0pvxTA==
X-Developer-Key: i=peter.griffin@linaro.org; a=openpgp;
 fpr=0EFC8E6F5578750D56B549FCCEE8B8D6023472BA

Each CMU (with the exception of cmu_top) has a corresponding sysreg bank
that contains the BUSCOMPONENT_DRCG_EN and optional MEMCLK registers.
The BUSCOMPONENT_DRCG_EN register enables dynamic root clock gating of
bus components and MEMCLK gates the sram clock.

Now the clock driver supports automatic clock mode, to fully enable dynamic
root clock gating it is required to configure these registers. Update the
bindings documentation so that all CMUs (with the exception of
gs101-cmu-top) have samsung,sysreg as a required property.

Note this is NOT an ABI break, as if the property isn't specified the
clock driver will fallback to the current behaviour of not initializing
the registers. The system still boots, but bus components won't benefit
from dynamic root clock gating and dynamic power will be higher (which has
been the case until now anyway).

Additionally update the DT example to included the correct CMU size as
registers in that region are used for automatic clock mode.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
Changes in v4
- Update commit description with additional requested details (Krzysztof)

Changes in v3:
- Update commit description as to why the sysreg is required (Krzysztof)

Changes in v2:
- Update commit description regarding updated example (Andre)
---
 .../bindings/clock/google,gs101-clock.yaml         | 23 +++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/google,gs101-clock.yaml b/Documentation/devicetree/bindings/clock/google,gs101-clock.yaml
index 31e106ef913dead9a038b3b6d8b43b950587f6aa..5ce5ba523110af3a2a7740b8ba28e2271c76bddb 100644
--- a/Documentation/devicetree/bindings/clock/google,gs101-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/google,gs101-clock.yaml
@@ -52,6 +52,11 @@ properties:
   reg:
     maxItems: 1
 
+  samsung,sysreg:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to system registers interface.
+
 required:
   - compatible
   - "#clock-cells"
@@ -166,6 +171,22 @@ allOf:
             - const: bus
             - const: ip
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - google,gs101-cmu-apm
+              - google,gs101-cmu-misc
+              - google,gs101-hsi0
+              - google,gs101-cmu-hsi2
+              - google,gs101-cmu-peric0
+              - google,gs101-cmu-peric1
+
+    then:
+      required:
+        - samsung,sysreg
+
 additionalProperties: false
 
 examples:
@@ -175,7 +196,7 @@ examples:
 
     cmu_top: clock-controller@1e080000 {
         compatible = "google,gs101-cmu-top";
-        reg = <0x1e080000 0x8000>;
+        reg = <0x1e080000 0x10000>;
         #clock-cells = <1>;
         clocks = <&ext_24_5m>;
         clock-names = "oscclk";

-- 
2.51.2.1041.gc1ab5b90ca-goog


