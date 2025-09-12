Return-Path: <linux-kernel+bounces-813071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8E5B54069
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 04:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18D603A846F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 02:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02AD51F2371;
	Fri, 12 Sep 2025 02:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mRNW4smC"
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE7A156661
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 02:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757644545; cv=none; b=g9L7ueriZ0qMbClPKBwXymGF6415nNUS8jqa1SSpxKP3UlXGjwbB0at6HqjZ4DU72KLfQ38HTM3yoyxABZ0577ELhpWLqtKsacPmypdcqkdd5m9YvVOqLHSo0d0y7rsntPlL3oNMKvJrhg11/jDEsjHD7xpJSEc6SrjkRA6jY7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757644545; c=relaxed/simple;
	bh=ne/AJ08EINCLHq1YL8QOv01wvisw6A7Ct54Qvu1CzBE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FS0VKLQw4E7oBPaATvmI9Gj1MdCv0ilWQgNbUZS7BrNMe9i43iJwVEjr1ZowfxCHsOoI5E3kXBtaB23Cm2J2w2TcV1J5XVoZw1vH9sMp+wimCKi38ZddzPOeEk30iQjG2/tV1q0qgZiiz7cAi7Ed6h3cFpWj3HIVnDcPtf7RRF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mRNW4smC; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-74381e2079fso1511602a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 19:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757644543; x=1758249343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0XFM07Z5n/PQZ1U15JfmMTCdL390KHJnWHFIuZFK96s=;
        b=mRNW4smCIN18Aar/uf+ApBp7CgTwGDU/VmpytkYxLux4yNKAEV96XBfM17rI7W3FfI
         tb1Y6Qc8WEH6XWAb5VnLYnBZhZ6AoKpa25FkQX7OSPNUTXooOYoaegTIrhq0nykQR7HI
         hIjJSgLDY+dLhEo6htcfE7lFwrJQALrkAebfC2bVaEgnwBSM1u/KXYmDbk4wNOrqiCe/
         STNOJQ7GOC0ldoqfHZ5kvbeBA8SsB5Bpudw8CFvqzJ0+0GgV/SUNrPFnVIZGk3I79kO4
         0AtRVFa4SOfHnSpmGVYLgWjZGvTwoyPlcZ+Mm5K0bP2isPN+TLY6YtTMHuZOU/UF/03H
         dpbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757644543; x=1758249343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0XFM07Z5n/PQZ1U15JfmMTCdL390KHJnWHFIuZFK96s=;
        b=u3hghkbtOQ/iLkVOZIMehzYhMs8BFfDgWZXOXVB9rfvw7u2XepSqFUSrUDCYE/vvDF
         NvVl8oPnj5hgXTKO29R9t7gdQKyf8ATTnobgfrY2SOq6dq1ve9I+9x6C39dHuPBRxXKl
         ocpnxDZEeqTxkX+Zwd8PMngsjei2fwDUXICzAz8+oKFFIKl9h//cnzhJnug29jzLwj4f
         C1TVwJZqF3Pm0CwJl1yDX6qFkMcY5FORs7NM6yaCSshbsl3t3Gj/c278sngDzjF64mdx
         1HghE/nrHE33/aTMxC2Wi1V0IHezmyWudfal5TWhtCB9q7lPOmrYFocpSW7Sz+KGtp47
         rqkA==
X-Forwarded-Encrypted: i=1; AJvYcCUSkQuvD98+VHFH1EZGyDWMUZV/JRaN2QYJuIt5GYUwRWa2zJRoEAvFHh9Bx9YiKr3vCPjlTdn/Xnwscxc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmNcoO7Gie9nHqi/7btUUIbqAtC34doGuoKqHhv/MQ2EORbKs1
	Vp7sD7YNejpr2Pjrp7gnbhNYQOR3DaR19ImoD2ncyz+Z2V40yF2n/0hl
X-Gm-Gg: ASbGncv8yT1OJQ6A6MWCLL0bADIa21LVTEg7O3s55EKKplOZDtjioYuJUD2DtLre6RO
	iM0cveoBMazSzBhiZBncdmtKCCrGoFObs0kjCaNiZemOE8lD2xKhgn1xuU1oRImYUKYK0VTU1og
	SgGWIWeX/mYtml7w6bSUUbsTMLsd1ySImhVbVayJ8dsFixyL4DWCKx+Jm2Xir4bciW2UpCISPAN
	wnXjgYLmJ6vCBjzCeirSpMQPyJGcOe55yevN1Ol7Y7Ab7jTnyutUQCHAyNXUaMEYMyU6z1zxyf+
	5obnmhVOA+WOs1ZZ1Uo6QAMSteUwa7ewh5KCJ9JWdFvqcx3py8waxY3VgOxNIXyqMtBidXQhIB3
	ahEJR6Gimnd5Q2v1dMRMUQaZ6YpJwn40L
X-Google-Smtp-Source: AGHT+IHQMNFCh86X7WUtfRMJW33oGIfkq7JFshCaD1qyzjsyBvpS3iS1S6F89Dx5xJzPUg1mM6pJVA==
X-Received: by 2002:a05:6830:67d5:b0:744:f0db:a199 with SMTP id 46e09a7af769-75355abff0emr852539a34.29.1757644542764;
        Thu, 11 Sep 2025 19:35:42 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7524be797e6sm739170a34.29.2025.09.11.19.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 19:35:41 -0700 (PDT)
From: Chen Wang <unicornxw@gmail.com>
To: kwilczynski@kernel.org,
	u.kleine-koenig@baylibre.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	arnd@arndb.de,
	bwawrzyn@cisco.com,
	bhelgaas@google.com,
	unicorn_wang@outlook.com,
	conor+dt@kernel.org,
	18255117159@163.com,
	inochiama@gmail.com,
	kishon@kernel.org,
	krzk+dt@kernel.org,
	lpieralisi@kernel.org,
	mani@kernel.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	robh@kernel.org,
	s-vadapalli@ti.com,
	tglx@linutronix.de,
	thomas.richard@bootlin.com,
	sycamoremoon376@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	sophgo@lists.linux.dev,
	rabenda.cn@gmail.com,
	chao.wei@sophgo.com,
	xiaoguang.xing@sophgo.com,
	fengchun.li@sophgo.com,
	jeffbai@aosc.io
Subject: [PATCH v3 1/7] dt-bindings: pci: Add Sophgo SG2042 PCIe host
Date: Fri, 12 Sep 2025 10:35:32 +0800
Message-Id: <2755f145755b6096247c26852b63671a6fea4dbf.1757643388.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1757643388.git.unicorn_wang@outlook.com>
References: <cover.1757643388.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

Add binding for Sophgo SG2042 PCIe host controller.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 .../bindings/pci/sophgo,sg2042-pcie-host.yaml | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/sophgo,sg2042-pcie-host.yaml

diff --git a/Documentation/devicetree/bindings/pci/sophgo,sg2042-pcie-host.yaml b/Documentation/devicetree/bindings/pci/sophgo,sg2042-pcie-host.yaml
new file mode 100644
index 000000000000..f8b7ca57fff1
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/sophgo,sg2042-pcie-host.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/sophgo,sg2042-pcie-host.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sophgo SG2042 PCIe Host (Cadence PCIe Wrapper)
+
+description:
+  Sophgo SG2042 PCIe host controller is based on the Cadence PCIe core.
+
+maintainers:
+  - Chen Wang <unicorn_wang@outlook.com>
+
+properties:
+  compatible:
+    const: sophgo,sg2042-pcie-host
+
+  reg:
+    maxItems: 2
+
+  reg-names:
+    items:
+      - const: reg
+      - const: cfg
+
+  vendor-id:
+    const: 0x1f1c
+
+  device-id:
+    const: 0x2042
+
+  msi-parent: true
+
+allOf:
+  - $ref: cdns-pcie-host.yaml#
+
+required:
+  - compatible
+  - reg
+  - reg-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    pcie@62000000 {
+      compatible = "sophgo,sg2042-pcie-host";
+      device_type = "pci";
+      reg = <0x62000000  0x00800000>,
+            <0x48000000  0x00001000>;
+      reg-names = "reg", "cfg";
+      #address-cells = <3>;
+      #size-cells = <2>;
+      ranges = <0x81000000 0 0x00000000 0xde000000 0 0x00010000>,
+               <0x82000000 0 0xd0400000 0xd0400000 0 0x0d000000>;
+      bus-range = <0x00 0xff>;
+      vendor-id = <0x1f1c>;
+      device-id = <0x2042>;
+      cdns,no-bar-match-nbits = <48>;
+      msi-parent = <&msi>;
+    };
-- 
2.34.1


