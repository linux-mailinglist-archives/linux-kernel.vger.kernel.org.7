Return-Path: <linux-kernel+bounces-727857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE620B020B6
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 17:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FBD0178A58
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 15:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189E52EE5E9;
	Fri, 11 Jul 2025 15:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="fjhXEZej"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E01C2ED842
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 15:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752248560; cv=none; b=qoVsZ1uNiGlsQurVfQj1OsvnUkRpCwibQjGTt6TEYkH4kxlfq6yW7TrOPfSZQxpVR6kMAsm2HgAsDRAWKk9QgtLjHxekzUpF7wO6WH693qZ1iFV2QjQBwd7HpYKAUauYntHZDj3Iku5X9rUycK4JAPT7j+EwSjeqDhnbkQ0hqDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752248560; c=relaxed/simple;
	bh=BAc/sjOJ52MzyENBcYQWdmAAONlg0iiGCQeVh9n0u0k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JAIFmgfgJdCr9GYfeSyunU9xP8ZP7qWFsQcqIi7lQKfC24Lsi5pJmg0tzSQV87lpzPJi2CV1Hc2Lq8+l/ATYmCU4Hh50EjHBntTxRahC4d/cOiKmHSJnCx+Kv5QJI9gyRDaxs+wWd2LVbNqipTf+EPzpTaiMlnqg0PpvdOpDCzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=fjhXEZej; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-747c2cc3419so2206580b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 08:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1752248557; x=1752853357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NH82M7Wpg8q915gzukGl/UR0qvoygGIK5SM365nsKWY=;
        b=fjhXEZejfbdArU7rLAYnHOzEQglV939ytD/F+dk5J8EtPNZqNNOS6ivd9O/jxpvqxM
         P+LHrkhNl/h7uayPdxIF1t1OvH+g+JEVvGcbhN3fpqbPfJ1YXCr3OqjzKZtFNVFks+Y8
         OruUNRnEP+vkN9/9h9m7sTkYqlmjk75bBYQjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752248557; x=1752853357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NH82M7Wpg8q915gzukGl/UR0qvoygGIK5SM365nsKWY=;
        b=c7ppoWMlkkSb8MWT9+3oPnWdjhuUkep2jbPaWsKV/MyhUtbq/5yU8uIkhA8PL43Iiw
         p3cVxTXH4Dp67nbC/BoCRnPMOpKRTjoHrrxcjI8mDhEEQ2BeOvC1rb3bJlYLx4/sCY5k
         /E3XISQmwZgc1Qx4/39oS26TKcBfY/uWKHG78zorFwRuHN3aIX5jaKESJeVfrpVMi5nN
         38qrMN1OuwdJwCaL61wsiL7aHSq1QJ8m3e5YG6ZQVLlHGZDkjwGd8mYnofy3Z50v7bwJ
         e8L7s1JEBTgsLX3rau561iQNfxp42RpvwpSs3/ZsnlPkIcGMUVHQ1E7PoaBejxlW7K4d
         CdLA==
X-Forwarded-Encrypted: i=1; AJvYcCXXNZkRTGOcohNq8OG44NFcl1CNjLqFncHS462GE4yB/fzVD7T2e/NXFmgPa3kjK8A/qDtBtdODGRQcmTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtsfHStmAWwX9RohkujMKO0vM81ab1P9LWYqZPBqNGbP+u+E64
	CqWUDUz0U49iWg02jfLCJGhDXg1cHPQPfHSzhrXMMISWC9B1cf/drGrmLgPdyl8J3Q==
X-Gm-Gg: ASbGnctUjwFCaQf3407eoqeAj8tjBrge0bI7NrPBKSSLBl6g+pppBbsEc+y3jI3dK4e
	/nMLWR6tlTS1SYuyZX0qZ8Q8VGbsGueVYtt9AM1vFxIYQEa9uI+0MLc8g4QDsSCFgpkXTsc0ly9
	5l1Lhdy8uKapepNRSf/2MpRWetFbWp9/+CcM+PR+RpX0O26U1hiMhAw4TcGCO+qGECdhRinJFQm
	NWaTshrkip+m7c/TE56MZ+cMW8EB3KInaa4+TsD/4ydqDcSCrOaNUGCkfEZVWq6ig50CfxXQQ3F
	3gddTucvb4in+3PQ8ZRmjRmEOEBmDg6SZmbjlV6E4kWicIcD6oz/TF/bq90IQLljTFDAGxDkNMA
	FG7SH9jBCmHCkgaOgz3yLBisO0Wtb85ZB79enHFf5bcxqcUu7BdsmSObQWg==
X-Google-Smtp-Source: AGHT+IGikmpmpoiahS6C039EIM4FWOINmFiK6nKg81tKKKY6N2Q8zXv85yrb97AEzFO3cAhGLIqJ9g==
X-Received: by 2002:a05:6a21:48b:b0:22f:8484:5ac2 with SMTP id adf61e73a8af0-23120df88c2mr6194764637.38.1752248557400;
        Fri, 11 Jul 2025 08:42:37 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9dd5ccesm5762420b3a.27.2025.07.11.08.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 08:42:36 -0700 (PDT)
From: Kamal Dasu <kamal.dasu@broadcom.com>
To: andersson@kernel.org,
	baolin.wang@linux.alibaba.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	florian.fainelli@broadcom.com,
	ulf.hansson@linaro.org,
	adrian.hunter@intel.com
Cc: bcm-kernel-feedback-list@broadcom.com,
	kamal.dasu@broadcom.com,
	linux-remoteproc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	Kamal Dasu <kdasu@broadcom.com>
Subject: [PATCH 1/4] dt-bindings: brcmstb-hwspinlock: support for hwspinlock
Date: Fri, 11 Jul 2025 11:42:18 -0400
Message-Id: <20250711154221.928164-3-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250711154221.928164-1-kamal.dasu@broadcom.com>
References: <20250711154221.928164-1-kamal.dasu@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kamal Dasu <kdasu@broadcom.com>

Adding brcmstb_hwspinlock bindings.

Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
---
 .../hwlock/brcm,brcmstb-hwspinlock.yaml       | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwlock/brcm,brcmstb-hwspinlock.yaml

diff --git a/Documentation/devicetree/bindings/hwlock/brcm,brcmstb-hwspinlock.yaml b/Documentation/devicetree/bindings/hwlock/brcm,brcmstb-hwspinlock.yaml
new file mode 100644
index 000000000000..b49ead166b1e
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
+  "#hwlock-cells":
+    const: 1
+
+  compatible:
+    const: brcm,brcmstb-hwspinlock
+
+  reg:
+    maxItems: 1
+
+required:
+  - "#hwlock-cells"
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    hwspinlock@8404038 {
+        compatible = "brcm,brcmstb-hwspinlock";
+        #hwlock-cells = <1>;
+        reg = <0x8404038 0x40>;
+    };
+
-- 
2.34.1


