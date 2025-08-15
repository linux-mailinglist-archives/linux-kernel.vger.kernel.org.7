Return-Path: <linux-kernel+bounces-771044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F6D2B28216
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 16:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 201D51D0535F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 14:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E7B262FC7;
	Fri, 15 Aug 2025 14:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TqQDhu5N"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A263B2264AA
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 14:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755268641; cv=none; b=ERm4Tfth/h/Fjq/fzhm30QvTj+a0Z7lyhmRGfkxzXONVCZXBZmDm9MiYpubCM8bJYdCJwbQg5dsxjaKhDawBP3MG2eXbox7tZ0Z757ZkEmdaHkyJ/uAxSW6b88PNvIAcUdVx2VPJhuY9nN4gIKE3XYcOnKVTC4YRQgSWR9koABQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755268641; c=relaxed/simple;
	bh=R3BNXlzor3OWM1UHW0bocrQrgSVBuB1WLn0clYEcPVU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LqsDRH69DjokeMY+DxVs+KnppfaOeCA/h6SSvaqbfj2lq7y4Nm7lFY8sa971q8T6aeUIQD1VvCNLFvIB4bmMuJIb96VX6QFE55nffm2MPnRpG+QYveRUIQBj9S3SpXrxVU31/xAl5mLmNvnvMJBdTSUMm8S2kOWTycKFCu2bkp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TqQDhu5N; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57FEIlsL017485
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 14:37:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PIWnFWN9JswVjgeJAZVSk7CUtGSis2EJBGP3G7aJZqM=; b=TqQDhu5NO39E3C9c
	DlAWrzjgii60srxIcxtdQyWR3wXwcyKy9JAwK0Wkm68iH40LRlh4KF0IrrRmhpXr
	6qFAGIJlaLFBGp7JjQUdRqZLfsXN7WRXhs7Xlm2ZTFtbq5352fFbqIiMDh26xN13
	ThczYxNAiAWCrLaa7K8ni610KyzVaIo6QiIvBA33rjsw/1A3TntedMJwrz/fTFYK
	/rruBS/CdTEwRshhZTH7JB5THD4K/PYqwPIT6cSJ2v2WA5NDCBSTXCDOtSS0+1Cg
	DZGcn8ZPjpYxUoLBpIetD3zs3PVyvbG9Kwo0SwF2Px2+vy9drgX/osuS7JZ8kfxv
	mf+r1w==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48eqhxhfxe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 14:37:18 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-76e2e8908fdso1688362b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 07:37:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755268637; x=1755873437;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PIWnFWN9JswVjgeJAZVSk7CUtGSis2EJBGP3G7aJZqM=;
        b=t99XKrsKwtfb5hTEf6/P6CRLQzqhPsbZKVRFq6vCRE1sokpIVtTf9Jr8Cj4Gm3W/Ry
         /95+VQa03ZYNNaUUS3xZDq1xREvAAiS/9Ernl6mA6NQHqI0XsubWjSPvKLrOIlYt0MbA
         XpY4Lohts3iVD9c4TR9Sj6TCVZ3Wt+bX0j/U/EPCdma9DuQ73kVmtXS++2+UTMtH6qFX
         hFMNwv77kyzzQlk5fO/AXPyjNKGln6nX5jids41UojyOgTPug4V91hFJhPeWXOQunzOx
         0e7uJhQUnGeTBH/7EmGPTZPd9Ck1dNV28ZrxIwwFTn5ymJAO7XRVskQE88uQpxw4VAIR
         qdnw==
X-Forwarded-Encrypted: i=1; AJvYcCX+1TCye3YJSXyxN+IP+Q7HOL93oTa09qjp9ppYB5RrUS5jKTOh3R4FAwOGEfylepIXz5lx9BiP/Cs+uuA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDll2gtzU2IfTOl9NusRUInPmO2g4Ew5Ci59QpdK+ugXPXMv2+
	xICXzgQLyO5s8twE8QYKyKE+qUEQtBOc9+WXU84Fuzd6GfygYhWsM7z1NwLy+JE0YDya7RAE8qN
	SsXv1vOFQy8ODZTu9/hafRjWsfcYfMCop2lZQKo0FNdSD9sdhz+3Hws3g9FVTMc7iTNU=
X-Gm-Gg: ASbGnct8OfftSeshFD67caUe1fFsh3q3GV5XCI9yDSziyoihVQdlkKugCgHwkRqBPar
	Q/EyejphjOndhpe1dWg7C4BzBOAhjuDumtOqx6Qb/jxAuMNcSEmOtz9oNrG05QhZ0uzEMTdBnrw
	cxXBwvOLRl+LSm2D5z738egZk4O12UhYuUXEOHMKwHtOKoUpGyg7HEKyPU50UPZSoA/EvhVP2Y/
	jfBE4r0nfe8DdqRMzTKQMNak7tgY3nmHVazy+NBHP3G96fhqvxeSrwSmTyiLXt8aDe4EsfglYNV
	sYqAE4T0Fpt+ehasJ2LUlTBDMPXfQ8cGVPbpyvGc0i8A6uFMolrzdidjaUfYgehEL34RLePisB0
	B
X-Received: by 2002:a05:6a20:a11e:b0:21a:d1fe:9e82 with SMTP id adf61e73a8af0-240d2f2190dmr4142982637.30.1755268637293;
        Fri, 15 Aug 2025 07:37:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgsIwndiwgMO/4XCfpnGqesl5qjzt37SrqS5fvAaqtJVwQCB8jw+J4FEIU2+q5voDUoc+zew==
X-Received: by 2002:a05:6a20:a11e:b0:21a:d1fe:9e82 with SMTP id adf61e73a8af0-240d2f2190dmr4142925637.30.1755268636830;
        Fri, 15 Aug 2025 07:37:16 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b472d73619fsm1437576a12.39.2025.08.15.07.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 07:37:16 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Fri, 15 Aug 2025 20:05:11 +0530
Subject: [PATCH v14 06/10] dt-bindings: arm: Document reboot mode magic
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-arm-psci-system_reset2-vendor-reboots-v14-6-37d29f59ac9a@oss.qualcomm.com>
References: <20250815-arm-psci-system_reset2-vendor-reboots-v14-0-37d29f59ac9a@oss.qualcomm.com>
In-Reply-To: <20250815-arm-psci-system_reset2-vendor-reboots-v14-0-37d29f59ac9a@oss.qualcomm.com>
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Andy Yan <andy.yan@rock-chips.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Vinod Koul <vkoul@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Andre Draszik <andre.draszik@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        Elliot Berman <quic_eberman@quicinc.com>,
        Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Elliot Berman <elliot.berman@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755268580; l=2577;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=SmkKRQQh3S8Gtdgd1oOIc80Ljvpw2jelYZ428aYXpJY=;
 b=L8V9bS20yn3EMfaNLrrEhrT1+PY4b++HwWpE+s1j0w7TmzQIDivAmjeMLzPy07SYrEuOq9kBl
 YPAwB3Zz27LC1Og4aQqxUCjphfUPn6ESHta7Z0UgqDXniNuFgLUnQoZ
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEwMDA1NyBTYWx0ZWRfXyzgmqkuHzBfN
 HMytdmGrDkcRHuvsSTjwDw6Rkg/jbLWlpfToAWK38s9ohpmxvTB1b3yvsTaYGOICkNKm4auSYXA
 TyWHOCbwU8IK2OCH1pr0kvkanD1Lo539pwPf1lZqmg8M5R9XH4QkcSFc9+nm71GXeUwzCrO5oBI
 NFy2mH2NLSl7GLyFdEl2SQtZlZE2uhc4M9CkM86r12Rhd+8w7MN4+HCamOgQMD0pxuN1pSl5IJL
 qpI2lbp73HCiN6nFjl9wD2pN0DOhL2XNduL0zcrnTqZAPvxAi71G3LBiinGLBWfGPlj/wKSKzNm
 cdGLrL9tVk6+2jUeVH7vl/U5TAje/0Jt/fw/4xS+OJpAmIZfCmr717G+c7J7l712Fq9w7mn7aef
 PELPDOPq
X-Proofpoint-GUID: 33sb9jbLbrIHYq86gzrNI9A4t1pnLKyd
X-Authority-Analysis: v=2.4 cv=aYNhnQot c=1 sm=1 tr=0 ts=689f461e cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=UInjrUrXc7y1C1sAkbYA:9 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: 33sb9jbLbrIHYq86gzrNI9A4t1pnLKyd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-15_05,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508100057

From: Elliot Berman <elliot.berman@oss.qualcomm.com>

Add bindings to describe vendor-specific reboot modes. Values here
correspond to valid parameters to vendor-specific reset types in PSCI
SYSTEM_RESET2 call.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Elliot Berman <elliot.berman@oss.qualcomm.com>
Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/arm/psci.yaml | 43 +++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/psci.yaml b/Documentation/devicetree/bindings/arm/psci.yaml
index 7360a2849b5bd1e4cbadac533c1a7228573288d4..eca38f8747d320e8371c1dc37cee2287d71821c4 100644
--- a/Documentation/devicetree/bindings/arm/psci.yaml
+++ b/Documentation/devicetree/bindings/arm/psci.yaml
@@ -98,6 +98,27 @@ properties:
       [1] Kernel documentation - ARM idle states bindings
         Documentation/devicetree/bindings/cpu/idle-states.yaml
 
+  reboot-mode:
+    type: object
+    $ref: /schemas/power/reset/reboot-mode.yaml#
+    unevaluatedProperties: false
+    properties:
+      # "mode-normal" is just SYSTEM_RESET
+      mode-normal: false
+    patternProperties:
+      "^mode-.*$":
+        minItems: 1
+        maxItems: 2
+        description: |
+          Describes a vendor-specific reset type. The string after "mode-"
+          maps a reboot mode to the parameters in the PSCI SYSTEM_RESET2 call.
+
+          Parameters are named mode-xxx = <type[, cookie]>, where xxx
+          is the name of the magic reboot mode, type is the lower 31 bits
+          of the reset_type, and, optionally, the cookie value. If the cookie
+          is not provided, it is defaulted to zero.
+          The 31st bit (vendor-resets) will be implicitly set by the driver.
+
 patternProperties:
   "^power-domain-":
     $ref: /schemas/power/power-domain.yaml#
@@ -137,6 +158,15 @@ allOf:
       required:
         - cpu_off
         - cpu_on
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              const: arm,psci-1.0
+    then:
+      properties:
+        reboot-mode: false
 
 additionalProperties: false
 
@@ -261,4 +291,17 @@ examples:
         domain-idle-states = <&cluster_ret>, <&cluster_pwrdn>;
       };
     };
+
+  - |+
+
+    // Case 5: SYSTEM_RESET2 vendor resets
+    psci {
+      compatible = "arm,psci-1.0";
+      method = "smc";
+
+      reboot-mode {
+        mode-edl = <0>;
+        mode-bootloader = <1 2>;
+      };
+    };
 ...

-- 
2.34.1


