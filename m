Return-Path: <linux-kernel+bounces-759552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4EEB1DF05
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 23:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F01A18961E7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 21:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B68257458;
	Thu,  7 Aug 2025 21:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qLq4yByf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58151DDA18;
	Thu,  7 Aug 2025 21:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754603082; cv=none; b=mx66fgDJ02LsqYVbLuIn7SxwhP+jghoIq1fy845Gks9ZYOpY/bUgyzcZmSoOpI+jLQ12D35UPA9N64mjoBui2vt7P3Cmq6icrn0HIH2uXZ4oQIks9qaqyKJye5Fm9CXsl9fPqfWob7NOSN9m45Snuhw+0MPm/WsKrGWAt7AMM3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754603082; c=relaxed/simple;
	bh=+DBg50Szd+rGRxJ8Bc8+14Qwysk4w0Ub9V4nfqyXPng=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bd/UE3MWTdMMypwkvwm03AnWWCawS9914Q5/vOWtZgKGb+tHrPThwBikLZSKI4CyHHePbxMoqVEnUCSXXTDU99cxdUAablVZI8BVixOas/OsEPcIDnIN5ew9/9Xp6qElDC1SO5Jw6+gMfCso6OTVS9e+UxWIEv8vN8HM2CIilsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qLq4yByf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56085C4CEEB;
	Thu,  7 Aug 2025 21:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754603082;
	bh=+DBg50Szd+rGRxJ8Bc8+14Qwysk4w0Ub9V4nfqyXPng=;
	h=From:To:Cc:Subject:Date:From;
	b=qLq4yByfFTTUMIgpVTPav3ckUdC2tFL3Dzf5pr4eGDYayIxoCIYwWyuHmlAjjrlZD
	 b1xOnVNYIvzxUqiQZqxCYc0eerWaXQptmHFRRUpi6XkuswpVCFAAZBVSI0OTmhRo+l
	 yxjmqKSWxg7auAq672/RgiP+IQ1DG9lHe1I12HXCQXhvHlq77ofngFC9mOFF5QFbMn
	 BI1tfcjVZ/theHodpUFFBSAEFVmGGyo6FV0erjfKUrf58HEap+Tl0ZQAk/haAa424S
	 c/MWnspjS81T5bvzGe9eoXyr5Db0o2ASvfE6T26SXl4VToleg6dq2bWuYv3J5kHL3d
	 hlepU1Om+NWiQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Scott Wood <oss@buserror.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] dt-bindings: powerpc: Drop duplicate fsl/mpic.txt
Date: Thu,  7 Aug 2025 16:44:30 -0500
Message-ID: <20250807214432.4173273-1-robh@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The chrp,open-pic binding schema already supports the "fsl,mpic"
compatible. A couple of properties are missing, so add them and remove
fsl/mpic.txt.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../interrupt-controller/chrp,open-pic.yaml   |  12 +
 .../devicetree/bindings/powerpc/fsl/mpic.txt  | 231 ------------------
 2 files changed, 12 insertions(+), 231 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/powerpc/fsl/mpic.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/chrp,open-pic.yaml b/Documentation/devicetree/bindings/interrupt-controller/chrp,open-pic.yaml
index f0d9bbd7d510..f748d42d2273 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/chrp,open-pic.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/chrp,open-pic.yaml
@@ -42,6 +42,18 @@ properties:
     description: Indicates the PIC shall not be reset during runtime initialization.
     type: boolean
 
+  single-cpu-affinity:
+    description:
+      If present, non-IPI interrupts will be routed to a single CPU at a time.
+    type: boolean
+
+  last-interrupt-source:
+    description:
+      Some MPICs do not correctly report the number of hardware sources in the
+      global feature registers. This value, if specified, overrides the value
+      read from MPIC_GREG_FEATURE_LAST_SRC.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
 required:
   - compatible
   - reg
diff --git a/Documentation/devicetree/bindings/powerpc/fsl/mpic.txt b/Documentation/devicetree/bindings/powerpc/fsl/mpic.txt
deleted file mode 100644
index dc5744636a57..000000000000
--- a/Documentation/devicetree/bindings/powerpc/fsl/mpic.txt
+++ /dev/null
@@ -1,231 +0,0 @@
-=====================================================================
-Freescale MPIC Interrupt Controller Node
-Copyright (C) 2010,2011 Freescale Semiconductor Inc.
-=====================================================================
-
-The Freescale MPIC interrupt controller is found on all PowerQUICC
-and QorIQ processors and is compatible with the Open PIC.  The
-notable difference from Open PIC binding is the addition of 2
-additional cells in the interrupt specifier defining interrupt type
-information.
-
-PROPERTIES
-
-  - compatible
-      Usage: required
-      Value type: <string>
-      Definition: Shall include "fsl,mpic".  Freescale MPIC
-          controllers compatible with this binding have Block
-          Revision Registers BRR1 and BRR2 at offset 0x0 and
-          0x10 in the MPIC.
-
-  - reg
-      Usage: required
-      Value type: <prop-encoded-array>
-      Definition: A standard property.  Specifies the physical
-          offset and length of the device's registers within the
-          CCSR address space.
-
-  - interrupt-controller
-      Usage: required
-      Value type: <empty>
-      Definition: Specifies that this node is an interrupt
-          controller
-
-  - #interrupt-cells
-      Usage: required
-      Value type: <u32>
-      Definition: Shall be 2 or 4.  A value of 2 means that interrupt
-          specifiers do not contain the interrupt-type or type-specific
-          information cells.
-
-  - #address-cells
-      Usage: required
-      Value type: <u32>
-      Definition: Shall be 0.
-
-  - pic-no-reset
-      Usage: optional
-      Value type: <empty>
-      Definition: The presence of this property specifies that the
-          MPIC must not be reset by the client program, and that
-          the boot program has initialized all interrupt source
-          configuration registers to a sane state-- masked or
-          directed at other cores.  This ensures that the client
-          program will not receive interrupts for sources not belonging
-          to the client.  The presence of this property also mandates
-          that any initialization related to interrupt sources shall
-          be limited to sources explicitly referenced in the device tree.
-
-  - big-endian
-      Usage: optional
-      Value type: <empty>
-          If present the MPIC will be assumed to be big-endian.  Some
-          device-trees omit this property on MPIC nodes even when the MPIC is
-          in fact big-endian, so certain boards override this property.
-
-  - single-cpu-affinity
-      Usage: optional
-      Value type: <empty>
-          If present the MPIC will be assumed to only be able to route
-          non-IPI interrupts to a single CPU at a time (EG: Freescale MPIC).
-
-  - last-interrupt-source
-      Usage: optional
-      Value type: <u32>
-          Some MPICs do not correctly report the number of hardware sources
-          in the global feature registers.  If specified, this field will
-          override the value read from MPIC_GREG_FEATURE_LAST_SRC.
-
-INTERRUPT SPECIFIER DEFINITION
-
-  Interrupt specifiers consists of 4 cells encoded as
-  follows:
-
-   <1st-cell>   interrupt-number
-
-                Identifies the interrupt source.  The meaning
-                depends on the type of interrupt.
-
-                Note: If the interrupt-type cell is undefined
-                (i.e. #interrupt-cells = 2), this cell
-                should be interpreted the same as for
-                interrupt-type 0-- i.e. an external or
-                normal SoC device interrupt.
-
-   <2nd-cell>   level-sense information, encoded as follows:
-                    0 = low-to-high edge triggered
-                    1 = active low level-sensitive
-                    2 = active high level-sensitive
-                    3 = high-to-low edge triggered
-
-   <3rd-cell>   interrupt-type
-
-                The following types are supported:
-
-                  0 = external or normal SoC device interrupt
-
-                      The interrupt-number cell contains
-                      the SoC device interrupt number.  The
-                      type-specific cell is undefined.  The
-                      interrupt-number is derived from the
-                      MPIC a block of registers referred to as
-                      the "Interrupt Source Configuration Registers".
-                      Each source has 32-bytes of registers
-                      (vector/priority and destination) in this
-                      region.   So interrupt 0 is at offset 0x0,
-                      interrupt 1 is at offset 0x20, and so on.
-
-                  1 = error interrupt
-
-                      The interrupt-number cell contains
-                      the SoC device interrupt number for
-                      the error interrupt.  The type-specific
-                      cell identifies the specific error
-                      interrupt number.
-
-                  2 = MPIC inter-processor interrupt (IPI)
-
-                      The interrupt-number cell identifies
-                      the MPIC IPI number.  The type-specific
-                      cell is undefined.
-
-                  3 = MPIC timer interrupt
-
-                      The interrupt-number cell identifies
-                      the MPIC timer number.  The type-specific
-                      cell is undefined.
-
-   <4th-cell>   type-specific information
-
-                The type-specific cell is encoded as follows:
-
-                 - For interrupt-type 1 (error interrupt),
-                   the type-specific cell contains the
-                   bit number of the error interrupt in the
-                   Error Interrupt Summary Register.
-
-EXAMPLE 1
-	/*
-	 * mpic interrupt controller with 4 cells per specifier
-	 */
-	mpic: pic@40000 {
-		compatible = "fsl,mpic";
-		interrupt-controller;
-		#interrupt-cells = <4>;
-		#address-cells = <0>;
-		reg = <0x40000 0x40000>;
-	};
-
-EXAMPLE 2
-	/*
-	 * The MPC8544 I2C controller node has an internal
-	 * interrupt number of 27.  As per the reference manual
-	 * this corresponds to interrupt source configuration
-	 * registers at 0x5_0560.
-	 *
-	 * The interrupt source configuration registers begin
-	 * at 0x5_0000.
-	 *
-	 * To compute the interrupt specifier interrupt number
-         *
-	 *       0x560 >> 5 = 43
-	 *
-	 * The interrupt source configuration registers begin
-	 * at 0x5_0000, and so the i2c vector/priority registers
-	 * are at 0x5_0560.
-	 */
-	i2c@3000 {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		cell-index = <0>;
-		compatible = "fsl-i2c";
-		reg = <0x3000 0x100>;
-		interrupts = <43 2>;
-		interrupt-parent = <&mpic>;
-		dfsrr;
-	};
-
-
-EXAMPLE 3
-	/*
-	 *  Definition of a node defining the 4
-	 *  MPIC IPI interrupts.  Note the interrupt
-	 *  type of 2.
-	 */
-	ipi@410a0 {
-		compatible = "fsl,mpic-ipi";
-		reg = <0x40040 0x10>;
-		interrupts = <0 0 2 0
-		              1 0 2 0
-		              2 0 2 0
-		              3 0 2 0>;
-	};
-
-EXAMPLE 4
-	/*
-	 *  Definition of a node defining the MPIC
-	 *  global timers.  Note the interrupt
-	 *  type of 3.
-	 */
-	timer0: timer@41100 {
-		compatible = "fsl,mpic-global-timer";
-		reg = <0x41100 0x100 0x41300 4>;
-		interrupts = <0 0 3 0
-		              1 0 3 0
-		              2 0 3 0
-		              3 0 3 0>;
-	};
-
-EXAMPLE 5
-	/*
-	 * Definition of an error interrupt (interrupt type 1).
-	 * SoC interrupt number is 16 and the specific error
-         * interrupt bit in the error interrupt summary register
-	 * is 23.
-	 */
-	memory-controller@8000 {
-		compatible = "fsl,p4080-memory-controller";
-		reg = <0x8000 0x1000>;
-		interrupts = <16 2 1 23>;
-	};
-- 
2.47.2


