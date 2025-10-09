Return-Path: <linux-kernel+bounces-847460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC51EBCAE80
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 23:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DC1148062D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 21:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB119281509;
	Thu,  9 Oct 2025 21:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Ji/MK2/C"
Received: from mail-ot1-f97.google.com (mail-ot1-f97.google.com [209.85.210.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B122280325
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 21:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760044839; cv=none; b=e3hx8HW7WRuEyjk+Uav86z5ye0zbEWG8bLUtt5O0a3o2C58mKuGO+sBZ5OtaGgenvhanlNwUshCik072j8tfsrjHjiNEcvjBaG+gUA6LVsxQJTbBhT7I2VI6JL9IamXtgAvnfK/Pj3Hr6sM8Wbq3Q9kb5SmIaV+Dp9KEM0Sk+qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760044839; c=relaxed/simple;
	bh=9uEjTfrGnmGkJo/3RuxVzKWei7JsAvyM/X7u5LLvmQ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZFZcSLJjvf4GeKav59oX6nGhYC1kHKZKnVM9MepSVijcTb9pzmN8J7BKxHzzKomEv4HvU8Wsxr7YJL0NsiDNAU2ZnfgRUKK3bjssd/R8CwZcXyLXvx8hpqp45IWwE1y2DUqebxDUovHDnpDjEpJJZg6iuu3TpzXqYABNekvr7aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Ji/MK2/C; arc=none smtp.client-ip=209.85.210.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f97.google.com with SMTP id 46e09a7af769-7a76561c291so944618a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 14:20:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760044836; x=1760649636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LNCBeBBdkJ6krQ6n6YSc9TV1L3hgIbHKEJb0ek4nU4k=;
        b=cRrO3i8Y3q5D5tFhUiFqwo/q5mTnYxnGXoJHHC4zpPlp9DHtRX6TZZb5S3jnHNb0eJ
         8L9Mz01z9fqgwf7da7SSP2OeSgRYcn69JTFUqqMdYEGfVDfUxA4bS/iXYOjZhlF05cQh
         gubo1wHHPN7W4KNYHSDgfTM4HPoxXBLqSzMPwUD4b/uNZouQjG+GiyGXSz3WBUuaIPS7
         BWhrCfRfv581+RdUQA/2aH4T/mjlGjJlpZxEuSJPNU7myWSaLZz0jes6s3NkGTuPLoTt
         EcLrEABecQrmxIV45wvUq4syD8WHa5V4dhL+DY1CZHt4iwox50/hve6R1NguurXvi4Au
         bd7g==
X-Forwarded-Encrypted: i=1; AJvYcCWAta8gSClRaEfM5qkLkSwMiB7KQgdszTcncw0jj1ncDQxyOGMODppmnFA3HHnmWjQ9HHMpCGDfJpW/MjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9wv+TCDtLv233m5UUfHkEvri31AeWoddehRS0EuWW4IvTgJvt
	f0xWNdzPXD2GtFh4VcLKMlo4TjMJ6dibuCs9smPTGxMen5fRFdb48F07pjK/zAZpdOKdNWovZqT
	NZhesGYDqsjmbLg3nJmPGF3IQ/qFQu93aaLvRTS1sSmGmm6zlp7iczK16qtQQl5bgoIWOzCBKQZ
	eZr3Kgbnj5UuHZeFWRv4ZUDPaCpQx4XXJ7VUyAeqLTauEN3aCEP/3FtbNQ2N7ICAXR83VwKSOWC
	oFcMNgAhWt20VoO
X-Gm-Gg: ASbGncsnh9WUasew5Ls07WPD4Vl593XolpsZWrRViyWwOEukfb8P3JO9B4J7KdtZE/K
	HQnYPiQeMUkRLLAtnDpN0LGiqrjmZGe3bhZdbCZGN1KNYzl1teuRoO0pwHkz4aI9alykV1N8hAq
	wP9GbPgQeUkx/MnUAIxVNaaCqYvdcBFkmc0s6Rcq148oFqMCjUghKxyNBLQ4I1QIHFL/9pAOyPe
	E7wBqKsHNVTkesy16noDGkHDL3vZkwmTTVb4U98SCPC7QIBp0Eqy1AYvjHR8hmhPkDPr/Lgkk+6
	ZsEEaN2Nb2nx5u+ED67fUE70OAlPdDJsu3QgqOS4DVzT3ktgBs/jFYRpYwZdDIbsYCuzAkLBNDI
	T7bAT/34cFrnEHAq+1l1KTNms8NegfE4V9512N65V0WazLiPDcApg9qopv12Sn9cm/V1tn3maMS
	2ZkQ==
X-Google-Smtp-Source: AGHT+IGjwsrfUIo4HLhXaBiFnx4XdKvQVZ6Xhi3chy3Y2KfU0IDuA9MVqiFmzxaprQjkAiGZUYfjgF785rRQ
X-Received: by 2002:a05:6808:14c4:b0:441:8f74:f23 with SMTP id 5614622812f47-4418f741aafmr1450355b6e.61.1760044836628;
        Thu, 09 Oct 2025 14:20:36 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-72.dlp.protect.broadcom.com. [144.49.247.72])
        by smtp-relay.gmail.com with ESMTPS id 006d021491bc7-650181edb69sm7869eaf.8.2025.10.09.14.20.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Oct 2025 14:20:36 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-82968fe9e8cso524492685a.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 14:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1760044836; x=1760649636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LNCBeBBdkJ6krQ6n6YSc9TV1L3hgIbHKEJb0ek4nU4k=;
        b=Ji/MK2/C/bXTrPERNnUWrhYhRnb+LTvOh08Ir49ZtaNI2sT7M56FZEANne3cL43daE
         c+ujDAgkILPxKTGsMGdqP3MblZN/lBLVOb9XNAh8Sxb/aIcFBliDrwIF2ads9hy3NkYX
         lNtKGlsovgM9qLqEjSjg6nF4Gu/ckE7fVHUqs=
X-Forwarded-Encrypted: i=1; AJvYcCWWDNjD9//4S85Zcu+ls9b2vUnMFvFSLzI2spJcNKEZHCYp9Q3fbZTdv3D7z0f1RX87HeSefCLzmEWTTBU=@vger.kernel.org
X-Received: by 2002:a05:620a:462c:b0:85d:aabb:47b4 with SMTP id af79cd13be357-8834ff8dd75mr1273447585a.12.1760044835660;
        Thu, 09 Oct 2025 14:20:35 -0700 (PDT)
X-Received: by 2002:a05:620a:462c:b0:85d:aabb:47b4 with SMTP id af79cd13be357-8834ff8dd75mr1273442585a.12.1760044835103;
        Thu, 09 Oct 2025 14:20:35 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8849f9ae428sm274832685a.16.2025.10.09.14.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 14:20:34 -0700 (PDT)
From: Kamal Dasu <kamal.dasu@broadcom.com>
To: peng.fan@oss.nxp.com,
	andersson@kernel.org,
	baolin.wang@linux.alibaba.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	florian.fainelli@broadcom.com
Cc: bcm-kernel-feedback-list@broadcom.com,
	linux-remoteproc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Kamal Dasu <kamal.dasu@broadcom.com>
Subject: [PATCH v3 1/3] dt-bindings: hwlock: Adding brcmstb-hwspinlock support
Date: Thu,  9 Oct 2025 17:20:01 -0400
Message-Id: <20251009212003.2714447-2-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251009212003.2714447-1-kamal.dasu@broadcom.com>
References: <20251009212003.2714447-1-kamal.dasu@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

The broadcom settop SoCs have hardware semaphores as part of "sundry"
IP block which has other controls that do not belong anywhere else.
e.g. pin/mux controls, SoC identification, drive strength, reset controls,
and other misc bits are part of this block.

Adding brcmstb-hwspinlock bindings which allows the hwspinlock driver to
iomap only the 16 hardware semaphore registers that are part of all settop
SoCs. Hence the bindings shall use the common "brcm,brcmstb-hwspinlock"
compatibility string.

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


