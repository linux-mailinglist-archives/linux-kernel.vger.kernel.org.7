Return-Path: <linux-kernel+bounces-836792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACFE5BAA925
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 22:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E9D63AE54E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 20:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D44E24EAB1;
	Mon, 29 Sep 2025 20:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="AcWX30Sb"
Received: from mail-qv1-f98.google.com (mail-qv1-f98.google.com [209.85.219.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E688324467A
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 20:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759176423; cv=none; b=lC0nBk8zTK0eGSG1x5cVy1YbEfO/2mXVow1S2uIAfKoF+7pE5EcOyZUy4Ame56+hOo5ieEBz87lalaSeRw2xDUz41wYtOhPscxbifHU/TCtyvKDTl92oN95EaZxHK+R62lcfIM44ravQ9RpehrhJ3GLMgJrbd7wePdOWDIDTt8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759176423; c=relaxed/simple;
	bh=twWts/BBJvvdpMllhwwy0sPWeHXBhThVVr0F+f1kI8U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KiML3TK1luTvgK/z/gvCjgh5f1nPMCqsBU3uhvjz/CSp7VXodoEg3ZP90vMgD2sXAOG9FnDlpvz4pN15/Wg0seQOaJvocZzCmtnwXph05oJ+WwSajcHrwi3AziKpDlZkkO2nckI2bLh9F8LG7xNVuQCTBKtpPliOOw1oaqhaQdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=AcWX30Sb; arc=none smtp.client-ip=209.85.219.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f98.google.com with SMTP id 6a1803df08f44-78e4056623fso39201446d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 13:07:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759176420; x=1759781220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SqovZHXYm5Oo5CU4XtE9N0uxOF2JJp5QxUlgkpF6rV8=;
        b=b1+UmQCuuz7/i6zpEn1pPQuWdDkkXliVoQYJwjvXfjprrv+GLB/P1Wpa4AEN1EAE1I
         1T2HiJ2GM9EkGFhbd1hPzDr2KuWnopi/nZdZWjRuGvdt7vFzdCADdRShD0WWsY63NMSV
         b2nODWKyyjT/nd/Ol2ANyr15miE9Urqa71WoJNuQIgtc8rdQwJm4V63liGoBVRUyJuOq
         UOv/2Tg7qA5OV/KWdPIU7G64/Kjo2HbY8PSoGfRcGBLvoB7G6EnzIiu2hxy+ODpe63un
         MyqWmYjqEVtAWrEewUslZ3g7iJhzHZ+vxOtf6C5V9bJnFoiJ/AybL8xw/Qw5AkjcaHRK
         xFKg==
X-Forwarded-Encrypted: i=1; AJvYcCUHbPRBliyTFJegz/bAo/ojRvFFwWwiAkWI6V+8y91yDfuIb19R/d2IdHdNziwyfeX1IDCa6oRlR/NQU88=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKAUbsNvouSRWKSVotReq0z+E6Ttx710khzXwEIPIGaNyOV6Nf
	Xk4CQaYzAnZLhmXlq5XTs7sh9KYiY8RRE90M6i39l74eph+511eQfkyP++VZG/D6V6Hp+smAJty
	j3w/xcIWGlHuGgtN6X5XJ7gF4b0q9M4w5nlEvVGG1M5wWb9Sat/1iyWaJHUk0ZgGVPXrjU8cRFq
	lKGoIAxa6mwxb5qghj767WWhkg0K3UnKON/PDXtVwmPgkyCDOUzYyuHWsJeCHJRPq1AYFHQ+wHJ
	T26YCUDgc6I4Voo
X-Gm-Gg: ASbGncuqdwXpOn5e7hFJjKXG8eOWBZTZCdYcBD1O85+VCgew8mk1NXNACbMyXdpFfyE
	NnOcCGdM02yeFVKizG9ic99izqhj9P/ajyBfb1n3Tb02721AuG9FXbsdBtypm4Fu121yuyacMUl
	45e2ply3+ilNsl73bqWmFcHVT05d8P9vH4TN1Eafn1qhZf8YgXg1UTeLM6t4r3qbhIIU30DQB5Z
	q4PGTh+awgi2klRDpe22Ztga1Lc00iFqYQ7PPbilGVJLptLhESoDg+CTfgRcKh/lduF11N8mshS
	wNhY5ZTUbIATV5E26NN/RFa9Yqz5VXah3avNdXOXl8a5Ha6dW2WUvZNagV/fn6TJrE+5Bv34OCk
	Qz5smwG4mo3nEIWwWe7LAuZLd/j//HIDYdw7FTRFqyI1CEs3n4aOZTDtORX0R8nIEr1sRGeajlI
	w=
X-Google-Smtp-Source: AGHT+IHlhwA3rcVB7IHq+Z76shHZlzAubO+HfWPC3q59k53WaATjo0aWHGrwUsMoB0U3bsl2bZXF9Odq70q0
X-Received: by 2002:a05:6214:f67:b0:786:547:4946 with SMTP id 6a1803df08f44-7fc32000fccmr261681306d6.30.1759176419778;
        Mon, 29 Sep 2025 13:06:59 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-801394a2e29sm8571376d6.14.2025.09.29.13.06.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Sep 2025 13:06:59 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-33428befbbaso6097372a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 13:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1759176418; x=1759781218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SqovZHXYm5Oo5CU4XtE9N0uxOF2JJp5QxUlgkpF6rV8=;
        b=AcWX30Sb4MixKf5OPVH/ouwOz4I4lTpb4NnocywYzKUhQyJQ/SSIS8aQ5RX2l1lVyC
         g7e2MtAjqusqGGih9sup9aMg8wmZ8NtsZ9WEhTZ3pUxSQF4rq28sWjb9F5+UYPBr17/E
         h6KT6MvOdDyGfC0kdGgVf6OvmRuOtHPxmaVU8=
X-Forwarded-Encrypted: i=1; AJvYcCWdsYdXmsKhMM74svHWrv8WBQkCvi78sv7nvNSTQRttkT6LHN3Lxm3ESX3gRxI11lB8UIeNIkbZ/en4V38=@vger.kernel.org
X-Received: by 2002:a17:90b:1d06:b0:336:9e78:c4c1 with SMTP id 98e67ed59e1d1-3369e78d5c6mr11368270a91.15.1759176418516;
        Mon, 29 Sep 2025 13:06:58 -0700 (PDT)
X-Received: by 2002:a17:90b:1d06:b0:336:9e78:c4c1 with SMTP id 98e67ed59e1d1-3369e78d5c6mr11368259a91.15.1759176418122;
        Mon, 29 Sep 2025 13:06:58 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33838735194sm2121479a91.22.2025.09.29.13.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 13:06:57 -0700 (PDT)
From: Kamal Dasu <kamal.dasu@broadcom.com>
To: bcm-kernel-feedback-list@broadcom.com,
	andersson@kernel.org,
	baolin.wang@linux.alibaba.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	florian.fainelli@broadcom.com
Cc: linux-remoteproc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Kamal Dasu <kamal.dasu@broadcom.com>
Subject: [PATCH 1/3] dt-bindings: hwlock:  Adding brcmstb-hwspinlock support
Date: Mon, 29 Sep 2025 16:06:24 -0400
Message-Id: <20250929200628.3699525-2-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250929200628.3699525-1-kamal.dasu@broadcom.com>
References: <20250929200628.3699525-1-kamal.dasu@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Adding brcmstb-hwspinlock bindings.

Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
---
 .../hwlock/brcm,brcmstb-hwspinlock.yaml       | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwlock/brcm,brcmstb-hwspinlock.yaml

diff --git a/Documentation/devicetree/bindings/hwlock/brcm,brcmstb-hwspinlock.yaml b/Documentation/devicetree/bindings/hwlock/brcm,brcmstb-hwspinlock.yaml
new file mode 100644
index 000000000000..f45399b4fe0b
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwlock/brcm,brcmstb-hwspinlock.yaml
@@ -0,0 +1,36 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwlock/brcm,brcmstb-hwspinlock.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom settop Hardware Spinlock
+
+maintainers:
+  - Kamal Dasu <kamal.dasu@broadcom.com>
+
+properties:
+  compatible:
+    const: brcm,brcmstb-hwspinlock
+
+  "#hwlock-cells":
+    const: 1
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - "#hwlock-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    hwlock@8404038 {
+        compatible = "brcm,brcmstb-hwspinlock";
+        reg = <0x8404038 0x40>;
+        #hwlock-cells = <1>;
+    };
+
-- 
2.34.1


