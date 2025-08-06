Return-Path: <linux-kernel+bounces-757127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA860B1BE0B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 02:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A15F628024
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 00:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2859C1547CC;
	Wed,  6 Aug 2025 00:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="HWG913fG"
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DA9481CD
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 00:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754441505; cv=none; b=A75BoWKEy31NI+lQvttt6ThIry+zOveij0av6O8MAZ7SdPWp3VXKyG5cz/pMbUiLky0CdlQNA2zicXALEgO9d5+0WU+HCLlrwnySNLNPFlqgr+BjWn8ypsN079DO+WtZcTH9X/GV5m0aXKKpc5g8rn+CULox3GQbyTvHxhB5vcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754441505; c=relaxed/simple;
	bh=xmeqXOs37C2Uo6fJropR0xPJ6eHARpct22W1Mr+ErrE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FfpOB+OVMomyU4rrmv9+QyvKL8tQcUS+V6pB/L/37iYAoJ8jzgtQCA5w52liVX8JbmScJ3DkYdZuaPO6zZDZ1NGHbXNUzFeuFhYhgLogoTpPhAi3rAC/IamirzBld6fXEsdSZqU64ZRj0XLGjRsNdFfIKvQYdPf+lQJSplP5GPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=HWG913fG; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id B84452C0117;
	Wed,  6 Aug 2025 12:51:34 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1754441494;
	bh=274Pjly+eIg7z3TSRuymxG/YIXr8M4S/eYN36UIcutk=;
	h=From:To:Cc:Subject:Date:From;
	b=HWG913fGVNDVGTHW4YVpLXWcRCKnkhhyow1uQshXNxkChD6vP6f38dN6Cceq7gi0F
	 fcxinMxsqhi6ToqVEI60XF8aO+ezd4jCULeiZpNZbv/OwWEVqmPCOjz7AZXOyaDGQI
	 TzeNPedHr5oDw429PXOqqhthn19n2dpvR/JqIjY8xVmg27YnnXXBuLUhlhyzAJfMNX
	 2hrFO9Bx6bTTcR05FjCLwmfegbUmlFkPxurmfbq/efxu1drZN7cL4hv0kA6v2tj6tB
	 DmkttkXXGCk7ktoypM/ExHJT/pIVIpf6KQ+lFBlq6AzdthvJ8d/VpInZeITRITrlBi
	 1F99V+9T1ZM0A==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B6892a7160000>; Wed, 06 Aug 2025 12:51:34 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id 3D40413EE2B;
	Wed,  6 Aug 2025 12:51:34 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id 38531280564; Wed,  6 Aug 2025 12:51:34 +1200 (NZST)
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: jdelvare@suse.com,
	linux@roeck-us.net,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH 1/2] dt-bindings: hwmon: ti,ina780a: Add INA780 device
Date: Wed,  6 Aug 2025 12:51:26 +1200
Message-ID: <20250806005127.542298-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=dtt4CEg4 c=1 sm=1 tr=0 ts=6892a716 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=2OwXVqhp2XgA:10 a=gEfo2CItAAAA:8 a=sozttTNsAAAA:8 a=0gANWJHp95hC6gXnOXgA:9 a=3ZKOabzyN94A:10 a=sptkURWiP4Gy88Gu7hUp:22
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

Add dtschema for TI INA780 Digital Power Monitor

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 .../devicetree/bindings/hwmon/ti,ina780a.yaml | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/ti,ina780a.ya=
ml

diff --git a/Documentation/devicetree/bindings/hwmon/ti,ina780a.yaml b/Do=
cumentation/devicetree/bindings/hwmon/ti,ina780a.yaml
new file mode 100644
index 000000000000..fa19d621b27b
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/ti,ina780a.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hwmon/ti,ina780a.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments INA780 Digital Power Monitor
+
+maintainers:
+  - Chris Packham <chris.packham@alliedtelesis.co.nz>
+
+description: |
+  The INA780x is a digital power monitor with an integrated current sens=
ing
+  element.
+
+  Datasheets:
+    https://www.ti.com/lit/gpn/ina780a
+
+properties:
+  compatible:
+    enum:
+      - ti,ina780a
+      - ti,ina780b
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+allOf:
+  - $ref: hwmon-common.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells =3D <1>;
+        #size-cells =3D <0>;
+
+        hwmon@40 {
+          compatible =3D "ti,ina780a";
+          reg =3D <0x40>;
+        };
+    };
--=20
2.50.1


