Return-Path: <linux-kernel+bounces-816321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9797B57261
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 10:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22868440199
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 08:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30BF2ED174;
	Mon, 15 Sep 2025 08:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bnyvOUm6"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564CC2EC57E
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 08:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757923357; cv=none; b=aSVztkUMic+wUTsDffUwJPY+iYm+gpo7WyvA+ZGu+4aF4t1ewSlNMjYCq5KmYgGPJc2n2AaNtITzTlYWw3TgOmf/BuEJdpXAT5X3JnvhQRo0Z1ZF6jDz3KEhYOQg5f46tB4oTBzMWYthQPf1AJdVzHGFhcAiU3uUsOijZ8taoKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757923357; c=relaxed/simple;
	bh=oG1UDywpcR9M4x+yKBkhpkuBvFZfw89ujr3kh7eFaOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gfjjNVEwTX2/WeiCXH24c/l/LHhIvgg4SBHqI74xKtSW7SSjxf5V87V60XPx7YEpeI/pusJadYLFEopSKsAMkrYSdtJ7n8GU5b1FswS/SCBH5JueL8soTJ+7v6cu+Ii29qIFePr7WoN8kFQA2/AbrORkDvhyCWp7NrYZYwA5rG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bnyvOUm6; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5688ac2f39dso4590356e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 01:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757923351; x=1758528151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6u7DncElgdWGoBbTvsNYYCuvHQdiQcUMiPwI+0yQv1U=;
        b=bnyvOUm6EwhZ/kZDNcnJXawAGNBNUAXmQAzhhFwLaq5l1ksZg5WjQmcGcoWwfntRSI
         UwQAEqokjD2rX4W3uJ2U/dssBlqL9/ZpJ5LLfkKwVrWdRPHZ5wyEwuamOTPnozIHOM76
         qDA+fgGQ55q8oyAWMWgXx9V4sazgmNbXd/87ZUpCcJK/GZcSGcY/GgWTn+uo6DE+7osW
         j+tF1dQHcklIywFruPOf25H1wTA6khoafVVwXF1ZJkCW2fv+ucWfqSvEb0GF6fXdUtD4
         61nDoRs1Bo2cuhW5+vXUplXeYQstZZYiXRVAqCmKW4CSTcaQAAvUzS5dMbFomBifv9QJ
         //Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757923351; x=1758528151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6u7DncElgdWGoBbTvsNYYCuvHQdiQcUMiPwI+0yQv1U=;
        b=vq02bT++vdoypUiQG9jXWjvvrqFNw//2N+gUmLr0qNEu0tFqTYg2R7g67TmquRkkib
         pKGoRsqrMjwG8VOm932+YzQPIkuCQXWmZtfWmSsgBbLXGRz+RlHPpfA7omD/911MMNXK
         VVRHbRQZWt/5OUbx3TlmrtIDequFAbfO2SeiUo7t32RXTgTsCuYDRTE3CF+fskUMNasD
         +a0xMCpEZ8JmFZY6F9JH1vKZY5Q7TjmzQ6hqD8kRwG/bWFjqyzNAzhrKiUGLG3t6IyBv
         DbQ2eiV/vYRONAVn0IwE/OPF45jZ8vDSZFBURwNRCdgclpz3vvah8lmAIbqF0rNQTUXb
         4K6A==
X-Gm-Message-State: AOJu0Yz5+YhtPjtIkzJihSUvOsVmP8BTw/SG5XNdiR28u1xhvgBf8GsI
	dF3sOZ8byfpQqm7pj+pfsNfMs66NY4bG6K7OERY/JjqvxcrS4IO1W0g2
X-Gm-Gg: ASbGncsSku1NirfUA9d+miU/wVGsPM8DKyFsg5c4g6tfosr/eb8ItReAkTU1xcW+MDE
	WP47LW1VY4FWpjnj1uavSp/AiFZooyxUbe6Cu72CpNv0NqdTqJQeAwElKtwOcHwxpS9tr1HaGcH
	7Ra2Zd9x8kPAJ/GzIdDKKkzUo01UQM0KMMatJMYkQlnQCj6nu4WE2iJaKvvRlc3BBozqzyyavUL
	Ws5InQZHG/t2qoiB/Mq+yVXeNPTS3L1eTvEWUdtxv7x6gwAiQEqPa8JLKRskquC1xyb1yVXSq4C
	kZWMON7nCQanqscvwKdBQAAwRay27XM9qyc6RgUXMgjhZCOWpGhMKc1JeR+ZG5VfhlnqJLGpWv7
	yaD/w8CuGds7o2/cnC7iFzEht
X-Google-Smtp-Source: AGHT+IEIzb0MelnrDb6tsvBBgjhy3goeGAgHgtIY40U+klN3eLzXkD55yKXFZdzIpxBI7o+EErrCaQ==
X-Received: by 2002:a05:6512:3599:b0:562:d04d:fa05 with SMTP id 2adb3069b0e04-5704fb8634dmr2789250e87.54.1757923351191;
        Mon, 15 Sep 2025 01:02:31 -0700 (PDT)
Received: from xeon.. ([188.163.112.70])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e6460dec4sm3392381e87.103.2025.09.15.01.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 01:02:30 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <treding@nvidia.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Prashant Gaikwad <pgaikwad@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Dmitry Osipenko <digetx@gmail.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v3 07/11] dt-bindings: memory: Document Tegra114 External Memory Controller
Date: Mon, 15 Sep 2025 11:01:53 +0300
Message-ID: <20250915080157.28195-8-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250915080157.28195-1-clamor95@gmail.com>
References: <20250915080157.28195-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Include Tegra114 support into existing Tegra124 EMC schema with the most
notable difference being the amount of EMC timings and a few SoC unique
entries.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../nvidia,tegra124-emc.yaml                  | 431 ++++++++++++------
 1 file changed, 283 insertions(+), 148 deletions(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-emc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-emc.yaml
index f5f03bf36413..1aeff06c3efe 100644
--- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-emc.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra124-emc.yaml
@@ -16,7 +16,9 @@ description: |
 
 properties:
   compatible:
-    const: nvidia,tegra124-emc
+    enum:
+      - nvidia,tegra114-emc
+      - nvidia,tegra124-emc
 
   reg:
     maxItems: 1
@@ -29,6 +31,9 @@ properties:
     items:
       - const: emc
 
+  interrupts:
+    maxItems: 1
+
   "#interconnect-cells":
     const: 0
 
@@ -164,153 +169,10 @@ patternProperties:
           nvidia,emc-configuration:
             description:
               EMC timing characterization data. These are the registers (see
-              section "15.6.2 EMC Registers" in the TRM) whose values need to
+              section "20.11.2 EMC Registers" in the Tegra114 TRM or section
+              "15.6.2 EMC Registers" in the Tegra124 TRM) whose values need to
               be specified, according to the board documentation.
             $ref: /schemas/types.yaml#/definitions/uint32-array
-            items:
-              - description: EMC_RC
-              - description: EMC_RFC
-              - description: EMC_RFC_SLR
-              - description: EMC_RAS
-              - description: EMC_RP
-              - description: EMC_R2W
-              - description: EMC_W2R
-              - description: EMC_R2P
-              - description: EMC_W2P
-              - description: EMC_RD_RCD
-              - description: EMC_WR_RCD
-              - description: EMC_RRD
-              - description: EMC_REXT
-              - description: EMC_WEXT
-              - description: EMC_WDV
-              - description: EMC_WDV_MASK
-              - description: EMC_QUSE
-              - description: EMC_QUSE_WIDTH
-              - description: EMC_IBDLY
-              - description: EMC_EINPUT
-              - description: EMC_EINPUT_DURATION
-              - description: EMC_PUTERM_EXTRA
-              - description: EMC_PUTERM_WIDTH
-              - description: EMC_PUTERM_ADJ
-              - description: EMC_CDB_CNTL_1
-              - description: EMC_CDB_CNTL_2
-              - description: EMC_CDB_CNTL_3
-              - description: EMC_QRST
-              - description: EMC_QSAFE
-              - description: EMC_RDV
-              - description: EMC_RDV_MASK
-              - description: EMC_REFRESH
-              - description: EMC_BURST_REFRESH_NUM
-              - description: EMC_PRE_REFRESH_REQ_CNT
-              - description: EMC_PDEX2WR
-              - description: EMC_PDEX2RD
-              - description: EMC_PCHG2PDEN
-              - description: EMC_ACT2PDEN
-              - description: EMC_AR2PDEN
-              - description: EMC_RW2PDEN
-              - description: EMC_TXSR
-              - description: EMC_TXSRDLL
-              - description: EMC_TCKE
-              - description: EMC_TCKESR
-              - description: EMC_TPD
-              - description: EMC_TFAW
-              - description: EMC_TRPAB
-              - description: EMC_TCLKSTABLE
-              - description: EMC_TCLKSTOP
-              - description: EMC_TREFBW
-              - description: EMC_FBIO_CFG6
-              - description: EMC_ODT_WRITE
-              - description: EMC_ODT_READ
-              - description: EMC_FBIO_CFG5
-              - description: EMC_CFG_DIG_DLL
-              - description: EMC_CFG_DIG_DLL_PERIOD
-              - description: EMC_DLL_XFORM_DQS0
-              - description: EMC_DLL_XFORM_DQS1
-              - description: EMC_DLL_XFORM_DQS2
-              - description: EMC_DLL_XFORM_DQS3
-              - description: EMC_DLL_XFORM_DQS4
-              - description: EMC_DLL_XFORM_DQS5
-              - description: EMC_DLL_XFORM_DQS6
-              - description: EMC_DLL_XFORM_DQS7
-              - description: EMC_DLL_XFORM_DQS8
-              - description: EMC_DLL_XFORM_DQS9
-              - description: EMC_DLL_XFORM_DQS10
-              - description: EMC_DLL_XFORM_DQS11
-              - description: EMC_DLL_XFORM_DQS12
-              - description: EMC_DLL_XFORM_DQS13
-              - description: EMC_DLL_XFORM_DQS14
-              - description: EMC_DLL_XFORM_DQS15
-              - description: EMC_DLL_XFORM_QUSE0
-              - description: EMC_DLL_XFORM_QUSE1
-              - description: EMC_DLL_XFORM_QUSE2
-              - description: EMC_DLL_XFORM_QUSE3
-              - description: EMC_DLL_XFORM_QUSE4
-              - description: EMC_DLL_XFORM_QUSE5
-              - description: EMC_DLL_XFORM_QUSE6
-              - description: EMC_DLL_XFORM_QUSE7
-              - description: EMC_DLL_XFORM_ADDR0
-              - description: EMC_DLL_XFORM_ADDR1
-              - description: EMC_DLL_XFORM_ADDR2
-              - description: EMC_DLL_XFORM_ADDR3
-              - description: EMC_DLL_XFORM_ADDR4
-              - description: EMC_DLL_XFORM_ADDR5
-              - description: EMC_DLL_XFORM_QUSE8
-              - description: EMC_DLL_XFORM_QUSE9
-              - description: EMC_DLL_XFORM_QUSE10
-              - description: EMC_DLL_XFORM_QUSE11
-              - description: EMC_DLL_XFORM_QUSE12
-              - description: EMC_DLL_XFORM_QUSE13
-              - description: EMC_DLL_XFORM_QUSE14
-              - description: EMC_DLL_XFORM_QUSE15
-              - description: EMC_DLI_TRIM_TXDQS0
-              - description: EMC_DLI_TRIM_TXDQS1
-              - description: EMC_DLI_TRIM_TXDQS2
-              - description: EMC_DLI_TRIM_TXDQS3
-              - description: EMC_DLI_TRIM_TXDQS4
-              - description: EMC_DLI_TRIM_TXDQS5
-              - description: EMC_DLI_TRIM_TXDQS6
-              - description: EMC_DLI_TRIM_TXDQS7
-              - description: EMC_DLI_TRIM_TXDQS8
-              - description: EMC_DLI_TRIM_TXDQS9
-              - description: EMC_DLI_TRIM_TXDQS10
-              - description: EMC_DLI_TRIM_TXDQS11
-              - description: EMC_DLI_TRIM_TXDQS12
-              - description: EMC_DLI_TRIM_TXDQS13
-              - description: EMC_DLI_TRIM_TXDQS14
-              - description: EMC_DLI_TRIM_TXDQS15
-              - description: EMC_DLL_XFORM_DQ0
-              - description: EMC_DLL_XFORM_DQ1
-              - description: EMC_DLL_XFORM_DQ2
-              - description: EMC_DLL_XFORM_DQ3
-              - description: EMC_DLL_XFORM_DQ4
-              - description: EMC_DLL_XFORM_DQ5
-              - description: EMC_DLL_XFORM_DQ6
-              - description: EMC_DLL_XFORM_DQ7
-              - description: EMC_XM2CMDPADCTRL
-              - description: EMC_XM2CMDPADCTRL4
-              - description: EMC_XM2CMDPADCTRL5
-              - description: EMC_XM2DQPADCTRL2
-              - description: EMC_XM2DQPADCTRL3
-              - description: EMC_XM2CLKPADCTRL
-              - description: EMC_XM2CLKPADCTRL2
-              - description: EMC_XM2COMPPADCTRL
-              - description: EMC_XM2VTTGENPADCTRL
-              - description: EMC_XM2VTTGENPADCTRL2
-              - description: EMC_XM2VTTGENPADCTRL3
-              - description: EMC_XM2DQSPADCTRL3
-              - description: EMC_XM2DQSPADCTRL4
-              - description: EMC_XM2DQSPADCTRL5
-              - description: EMC_XM2DQSPADCTRL6
-              - description: EMC_DSR_VTTGEN_DRV
-              - description: EMC_TXDSRVTTGEN
-              - description: EMC_FBIO_SPARE
-              - description: EMC_ZCAL_WAIT_CNT
-              - description: EMC_MRS_WAIT_CNT2
-              - description: EMC_CTT
-              - description: EMC_CTT_DURATION
-              - description: EMC_CFG_PIPE
-              - description: EMC_DYN_SELF_REF_CONTROL
-              - description: EMC_QPOP
 
         required:
           - clock-frequency
@@ -318,9 +180,7 @@ patternProperties:
           - nvidia,emc-auto-cal-config2
           - nvidia,emc-auto-cal-config3
           - nvidia,emc-auto-cal-interval
-          - nvidia,emc-bgbias-ctl0
           - nvidia,emc-cfg
-          - nvidia,emc-cfg-2
           - nvidia,emc-ctt-term-ctrl
           - nvidia,emc-mode-1
           - nvidia,emc-mode-2
@@ -344,6 +204,281 @@ required:
   - "#interconnect-cells"
   - operating-points-v2
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - nvidia,tegra114-emc
+    then:
+      patternProperties:
+        "^emc-timings-[0-9]+$":
+          patternProperties:
+            "^timing-[0-9]+$":
+              properties:
+                nvidia,emc-configuration:
+                  items:
+                    - description: EMC_RC
+                    - description: EMC_RFC
+                    - description: EMC_RAS
+                    - description: EMC_RP
+                    - description: EMC_R2W
+                    - description: EMC_W2R
+                    - description: EMC_R2P
+                    - description: EMC_W2P
+                    - description: EMC_RD_RCD
+                    - description: EMC_WR_RCD
+                    - description: EMC_RRD
+                    - description: EMC_REXT
+                    - description: EMC_WEXT
+                    - description: EMC_WDV
+                    - description: EMC_WDV_MASK
+                    - description: EMC_QUSE
+                    - description: EMC_IBDLY
+                    - description: EMC_EINPUT
+                    - description: EMC_EINPUT_DURATION
+                    - description: EMC_PUTERM_EXTRA
+                    - description: EMC_CDB_CNTL_1
+                    - description: EMC_CDB_CNTL_2
+                    - description: EMC_QRST
+                    - description: EMC_QSAFE
+                    - description: EMC_RDV
+                    - description: EMC_RDV_MASK
+                    - description: EMC_REFRESH
+                    - description: EMC_BURST_REFRESH_NUM
+                    - description: EMC_PRE_REFRESH_REQ_CNT
+                    - description: EMC_PDEX2WR
+                    - description: EMC_PDEX2RD
+                    - description: EMC_PCHG2PDEN
+                    - description: EMC_ACT2PDEN
+                    - description: EMC_AR2PDEN
+                    - description: EMC_RW2PDEN
+                    - description: EMC_TXSR
+                    - description: EMC_TXSRDLL
+                    - description: EMC_TCKE
+                    - description: EMC_TCKESR
+                    - description: EMC_TPD
+                    - description: EMC_TFAW
+                    - description: EMC_TRPAB
+                    - description: EMC_TCLKSTABLE
+                    - description: EMC_TCLKSTOP
+                    - description: EMC_TREFBW
+                    - description: EMC_QUSE_EXTRA
+                    - description: EMC_FBIO_CFG6
+                    - description: EMC_ODT_WRITE
+                    - description: EMC_ODT_READ
+                    - description: EMC_FBIO_CFG5
+                    - description: EMC_CFG_DIG_DLL
+                    - description: EMC_CFG_DIG_DLL_PERIOD
+                    - description: EMC_DLL_XFORM_DQS0
+                    - description: EMC_DLL_XFORM_DQS1
+                    - description: EMC_DLL_XFORM_DQS2
+                    - description: EMC_DLL_XFORM_DQS3
+                    - description: EMC_DLL_XFORM_DQS4
+                    - description: EMC_DLL_XFORM_DQS5
+                    - description: EMC_DLL_XFORM_DQS6
+                    - description: EMC_DLL_XFORM_DQS7
+                    - description: EMC_DLL_XFORM_QUSE0
+                    - description: EMC_DLL_XFORM_QUSE1
+                    - description: EMC_DLL_XFORM_QUSE2
+                    - description: EMC_DLL_XFORM_QUSE3
+                    - description: EMC_DLL_XFORM_QUSE4
+                    - description: EMC_DLL_XFORM_QUSE5
+                    - description: EMC_DLL_XFORM_QUSE6
+                    - description: EMC_DLL_XFORM_QUSE7
+                    - description: EMC_DLI_TRIM_TXDQS0
+                    - description: EMC_DLI_TRIM_TXDQS1
+                    - description: EMC_DLI_TRIM_TXDQS2
+                    - description: EMC_DLI_TRIM_TXDQS3
+                    - description: EMC_DLI_TRIM_TXDQS4
+                    - description: EMC_DLI_TRIM_TXDQS5
+                    - description: EMC_DLI_TRIM_TXDQS6
+                    - description: EMC_DLI_TRIM_TXDQS7
+                    - description: EMC_DLL_XFORM_DQ0
+                    - description: EMC_DLL_XFORM_DQ1
+                    - description: EMC_DLL_XFORM_DQ2
+                    - description: EMC_DLL_XFORM_DQ3
+                    - description: EMC_XM2CMDPADCTRL
+                    - description: EMC_XM2CMDPADCTRL4
+                    - description: EMC_XM2DQPADCTRL2
+                    - description: EMC_XM2CLKPADCTRL
+                    - description: EMC_XM2COMPPADCTRL
+                    - description: EMC_XM2VTTGENPADCTRL
+                    - description: EMC_XM2VTTGENPADCTRL2
+                    - description: EMC_XM2DQSPADCTRL3
+                    - description: EMC_XM2DQSPADCTRL4
+                    - description: EMC_DSR_VTTGEN_DRV
+                    - description: EMC_TXDSRVTTGEN
+                    - description: EMC_FBIO_SPARE
+                    - description: EMC_ZCAL_WAIT_CNT
+                    - description: EMC_MRS_WAIT_CNT2
+                    - description: EMC_CTT
+                    - description: EMC_CTT_DURATION
+                    - description: EMC_DYN_SELF_REF_CONTROL
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - nvidia,tegra124-emc
+    then:
+      patternProperties:
+        "^emc-timings-[0-9]+$":
+          patternProperties:
+            "^timing-[0-9]+$":
+              properties:
+                nvidia,emc-configuration:
+                  items:
+                    - description: EMC_RC
+                    - description: EMC_RFC
+                    - description: EMC_RFC_SLR
+                    - description: EMC_RAS
+                    - description: EMC_RP
+                    - description: EMC_R2W
+                    - description: EMC_W2R
+                    - description: EMC_R2P
+                    - description: EMC_W2P
+                    - description: EMC_RD_RCD
+                    - description: EMC_WR_RCD
+                    - description: EMC_RRD
+                    - description: EMC_REXT
+                    - description: EMC_WEXT
+                    - description: EMC_WDV
+                    - description: EMC_WDV_MASK
+                    - description: EMC_QUSE
+                    - description: EMC_QUSE_WIDTH
+                    - description: EMC_IBDLY
+                    - description: EMC_EINPUT
+                    - description: EMC_EINPUT_DURATION
+                    - description: EMC_PUTERM_EXTRA
+                    - description: EMC_PUTERM_WIDTH
+                    - description: EMC_PUTERM_ADJ
+                    - description: EMC_CDB_CNTL_1
+                    - description: EMC_CDB_CNTL_2
+                    - description: EMC_CDB_CNTL_3
+                    - description: EMC_QRST
+                    - description: EMC_QSAFE
+                    - description: EMC_RDV
+                    - description: EMC_RDV_MASK
+                    - description: EMC_REFRESH
+                    - description: EMC_BURST_REFRESH_NUM
+                    - description: EMC_PRE_REFRESH_REQ_CNT
+                    - description: EMC_PDEX2WR
+                    - description: EMC_PDEX2RD
+                    - description: EMC_PCHG2PDEN
+                    - description: EMC_ACT2PDEN
+                    - description: EMC_AR2PDEN
+                    - description: EMC_RW2PDEN
+                    - description: EMC_TXSR
+                    - description: EMC_TXSRDLL
+                    - description: EMC_TCKE
+                    - description: EMC_TCKESR
+                    - description: EMC_TPD
+                    - description: EMC_TFAW
+                    - description: EMC_TRPAB
+                    - description: EMC_TCLKSTABLE
+                    - description: EMC_TCLKSTOP
+                    - description: EMC_TREFBW
+                    - description: EMC_FBIO_CFG6
+                    - description: EMC_ODT_WRITE
+                    - description: EMC_ODT_READ
+                    - description: EMC_FBIO_CFG5
+                    - description: EMC_CFG_DIG_DLL
+                    - description: EMC_CFG_DIG_DLL_PERIOD
+                    - description: EMC_DLL_XFORM_DQS0
+                    - description: EMC_DLL_XFORM_DQS1
+                    - description: EMC_DLL_XFORM_DQS2
+                    - description: EMC_DLL_XFORM_DQS3
+                    - description: EMC_DLL_XFORM_DQS4
+                    - description: EMC_DLL_XFORM_DQS5
+                    - description: EMC_DLL_XFORM_DQS6
+                    - description: EMC_DLL_XFORM_DQS7
+                    - description: EMC_DLL_XFORM_DQS8
+                    - description: EMC_DLL_XFORM_DQS9
+                    - description: EMC_DLL_XFORM_DQS10
+                    - description: EMC_DLL_XFORM_DQS11
+                    - description: EMC_DLL_XFORM_DQS12
+                    - description: EMC_DLL_XFORM_DQS13
+                    - description: EMC_DLL_XFORM_DQS14
+                    - description: EMC_DLL_XFORM_DQS15
+                    - description: EMC_DLL_XFORM_QUSE0
+                    - description: EMC_DLL_XFORM_QUSE1
+                    - description: EMC_DLL_XFORM_QUSE2
+                    - description: EMC_DLL_XFORM_QUSE3
+                    - description: EMC_DLL_XFORM_QUSE4
+                    - description: EMC_DLL_XFORM_QUSE5
+                    - description: EMC_DLL_XFORM_QUSE6
+                    - description: EMC_DLL_XFORM_QUSE7
+                    - description: EMC_DLL_XFORM_ADDR0
+                    - description: EMC_DLL_XFORM_ADDR1
+                    - description: EMC_DLL_XFORM_ADDR2
+                    - description: EMC_DLL_XFORM_ADDR3
+                    - description: EMC_DLL_XFORM_ADDR4
+                    - description: EMC_DLL_XFORM_ADDR5
+                    - description: EMC_DLL_XFORM_QUSE8
+                    - description: EMC_DLL_XFORM_QUSE9
+                    - description: EMC_DLL_XFORM_QUSE10
+                    - description: EMC_DLL_XFORM_QUSE11
+                    - description: EMC_DLL_XFORM_QUSE12
+                    - description: EMC_DLL_XFORM_QUSE13
+                    - description: EMC_DLL_XFORM_QUSE14
+                    - description: EMC_DLL_XFORM_QUSE15
+                    - description: EMC_DLI_TRIM_TXDQS0
+                    - description: EMC_DLI_TRIM_TXDQS1
+                    - description: EMC_DLI_TRIM_TXDQS2
+                    - description: EMC_DLI_TRIM_TXDQS3
+                    - description: EMC_DLI_TRIM_TXDQS4
+                    - description: EMC_DLI_TRIM_TXDQS5
+                    - description: EMC_DLI_TRIM_TXDQS6
+                    - description: EMC_DLI_TRIM_TXDQS7
+                    - description: EMC_DLI_TRIM_TXDQS8
+                    - description: EMC_DLI_TRIM_TXDQS9
+                    - description: EMC_DLI_TRIM_TXDQS10
+                    - description: EMC_DLI_TRIM_TXDQS11
+                    - description: EMC_DLI_TRIM_TXDQS12
+                    - description: EMC_DLI_TRIM_TXDQS13
+                    - description: EMC_DLI_TRIM_TXDQS14
+                    - description: EMC_DLI_TRIM_TXDQS15
+                    - description: EMC_DLL_XFORM_DQ0
+                    - description: EMC_DLL_XFORM_DQ1
+                    - description: EMC_DLL_XFORM_DQ2
+                    - description: EMC_DLL_XFORM_DQ3
+                    - description: EMC_DLL_XFORM_DQ4
+                    - description: EMC_DLL_XFORM_DQ5
+                    - description: EMC_DLL_XFORM_DQ6
+                    - description: EMC_DLL_XFORM_DQ7
+                    - description: EMC_XM2CMDPADCTRL
+                    - description: EMC_XM2CMDPADCTRL4
+                    - description: EMC_XM2CMDPADCTRL5
+                    - description: EMC_XM2DQPADCTRL2
+                    - description: EMC_XM2DQPADCTRL3
+                    - description: EMC_XM2CLKPADCTRL
+                    - description: EMC_XM2CLKPADCTRL2
+                    - description: EMC_XM2COMPPADCTRL
+                    - description: EMC_XM2VTTGENPADCTRL
+                    - description: EMC_XM2VTTGENPADCTRL2
+                    - description: EMC_XM2VTTGENPADCTRL3
+                    - description: EMC_XM2DQSPADCTRL3
+                    - description: EMC_XM2DQSPADCTRL4
+                    - description: EMC_XM2DQSPADCTRL5
+                    - description: EMC_XM2DQSPADCTRL6
+                    - description: EMC_DSR_VTTGEN_DRV
+                    - description: EMC_TXDSRVTTGEN
+                    - description: EMC_FBIO_SPARE
+                    - description: EMC_ZCAL_WAIT_CNT
+                    - description: EMC_MRS_WAIT_CNT2
+                    - description: EMC_CTT
+                    - description: EMC_CTT_DURATION
+                    - description: EMC_CFG_PIPE
+                    - description: EMC_DYN_SELF_REF_CONTROL
+                    - description: EMC_QPOP
+
+              required:
+                - nvidia,emc-bgbias-ctl0
+                - nvidia,emc-cfg-2
+
 additionalProperties: false
 
 examples:
-- 
2.48.1


