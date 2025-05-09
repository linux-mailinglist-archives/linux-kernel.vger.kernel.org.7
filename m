Return-Path: <linux-kernel+bounces-641443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35571AB11C2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 May 2025 13:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EEEA1C20DB0
	for <lists+linux-kernel@lfdr.de>; Fri,  9 May 2025 11:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3504E290097;
	Fri,  9 May 2025 11:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VbKpSBFk"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7508D28FFE7
	for <linux-kernel@vger.kernel.org>; Fri,  9 May 2025 11:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746789054; cv=none; b=ljGw47Idlj6TvmaT+nYXbelQWzaiNZ0qZgqlWncyVqCrt+/mHh1csVN6Dhh5EKrPHUs2DZCqkHGLssEm9NnsS+eL7l68Z00EmzkkA5vaxGPDUwQmTMc5ImXfnhycvLqfCHEvCRxYomeQk26gSXp6LCXRAAMw5XC4WVfysbdVwYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746789054; c=relaxed/simple;
	bh=8CaEh7rTGRljg/YVmrFSiIKmc7JioYgpekYwHFjXz2Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XU6E+1ONNQeVoRpTToWKw7QVji1+UMV4C1JJ7WCwZDMd2KG7BvUEeBQICSWEJGPfFBhJwU155XQ/YW5BHmHw87sxWQPHDGhUe7rpjVQoRhciNF4izbhOiFJHEKwjT6z2poiWawtbXZDqXnX5Nh7UVBsNiSlSQ78MmAfeEBZ0m7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VbKpSBFk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 549Aq25L025122
	for <linux-kernel@vger.kernel.org>; Fri, 9 May 2025 11:10:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=+WDWhrRwH1F
	OoDzqHlWd0iECjjlqD4m23ChLyP3KnZU=; b=VbKpSBFkQhYImFlcWVKfZ38dzSr
	0dkXMWo9lBE9QOoXP5wht312Vjukr0fvhpoZkajfsdJXWFkT4SWYHXYZxmBEDEEx
	UdflJYeHLXnVWds+gc3N78d8ltUysNHIi2jna152pPLhNWFWk7jE4X6eOXJf+zRl
	NfMEZOBN2dWzL+nHeWQ1HwNuetSr9ygzsRdsdXSPWbN3TUjW4ZLXB21xUBlEQrJB
	5Ul1/KWzge3bAOcZ37v8jkQf0ZWV1EmXPYK9sr6I2/xtOAVvpeLycsYx4gyfNWAJ
	bFuqLJh2c6RCvXv5PyvtZCJszIRV7oSbHWzNYhBtBmD9RK51+b9sZrsc6Eg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46gnp14gg3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 09 May 2025 11:10:49 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-736cd27d51fso1841805b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 May 2025 04:10:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746789049; x=1747393849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+WDWhrRwH1FOoDzqHlWd0iECjjlqD4m23ChLyP3KnZU=;
        b=sX7fsyaF98G7m6IEdoSeCgxrf2NLrZXuWOvchb+RtNjOipcqphD4CSP+/gGji2f6CX
         NRKF7bgBXBinKLmfrdDtTE1MwFuyboYgr4X6UkLpFN3J37LoFodrpyJvpyz7F72a/H35
         EJ7bq/Q7yzyg4arQ2AKnFvJMU4NSdpZH9TsdCF4dqY02l/UqCCEQCAWHlVIMIGTvWoq2
         BLB4EL6IB856cBhwL1M0H/rRq5HkkMigANnrGrwuMsWNAFpo4e2H3ZHKpg/i8SKLjBZN
         BSF4EBP9Vli8LSmaiQMYKTl134+vennpoF68SU9uf+JlT/pqwByjSR5c9knsaq+sz77G
         rzfg==
X-Forwarded-Encrypted: i=1; AJvYcCV3B6xGndt0k+L05p6PjDAZSokFzJUAOgLx9yUwunZrZRHfDKx0G2VJIwDj8KJ7xv32gWJzIWhDmAsfnxg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL2cVCh8bQw6WJZdb9rwB5HGW3ewK6tDtnG+Kgi/f97so6pzlL
	kiXI/t3lfrdNtogt2eP0D45rfjbX7xBXFMfpQuL9Z/p7fbZrubzWB9wELTcsBXq72/q+Vcd2gsM
	HZwuF1LaJUQWrXJeWoS1LkR7KOqvMexc5dW6PFIpMJLHk2HE2Cfx2CQnS6VUOch4=
X-Gm-Gg: ASbGncv8XJTqm28baKxEVv5AmkqPH3zerU1Ei8maq0XDhX1DmxuCweWTZEtMeYw/H/o
	RlkyszjL5YAW4Gra/DKHIk+rdaR9Nv62NfVWp11+S5tuHxZQulzWmxD1VO12sidyHLsCGqZ0dUk
	kj7woUybnvPtHYRs2+bhSTfS67jssZdDEJEfWTcSwVCBsq4qkOEiWWal56glU3P8k+iIDuTz6qQ
	7c/+SN40bCzKgZ92f2v5UOCC+5mjc6FhkXUv1CNLi+8XVYlhrTBSXW4JGdll87/+xKwGx0FueJ/
	eT0SYFyKC19xVZoJmTXTxRCDjb6s/N4f5YsFjdK+mCOUMRw=
X-Received: by 2002:a05:6a00:198b:b0:740:9abe:4d94 with SMTP id d2e1a72fcca58-7423c057660mr4163460b3a.21.1746789048268;
        Fri, 09 May 2025 04:10:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJ7+AY5WcTax/AYpuUdzuxxKsVj+Zoyc8HEMsaFj2SSHWNCCTnEKjU0tZEhQQKJyq1/dCrjg==
X-Received: by 2002:a05:6a00:198b:b0:740:9abe:4d94 with SMTP id d2e1a72fcca58-7423c057660mr4163387b3a.21.1746789047640;
        Fri, 09 May 2025 04:10:47 -0700 (PDT)
Received: from hu-jprakash-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74237734c4asm1556223b3a.57.2025.05.09.04.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 04:10:47 -0700 (PDT)
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
To: jic23@kernel.org, robh@kernel.org, krzysztof.kozlowski@linaro.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, agross@kernel.org,
        andersson@kernel.org, lumag@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, konradybcio@kernel.org,
        daniel.lezcano@linaro.org, sboyd@kernel.org, amitk@kernel.org,
        thara.gopinath@gmail.com, lee@kernel.org, rafael@kernel.org,
        subbaraman.narayanamurthy@oss.qualcomm.com,
        david.collins@oss.qualcomm.com, anjelique.melendez@oss.qualcomm.com,
        quic_kamalw@quicinc.com
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        cros-qcom-dts-watchers@chromium.org, jishnu.prakash@oss.qualcomm.com,
        quic_skakitap@quicinc.com, neil.armstrong@linaro.org,
        stephan.gerhold@linaro.org
Subject: [PATCH V6 3/5] dt-bindings: iio: adc: Add support for QCOM PMIC5 Gen3 ADC
Date: Fri,  9 May 2025 16:39:57 +0530
Message-Id: <20250509110959.3384306-4-jishnu.prakash@oss.qualcomm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250509110959.3384306-1-jishnu.prakash@oss.qualcomm.com>
References: <20250509110959.3384306-1-jishnu.prakash@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDEwNyBTYWx0ZWRfX8pYueNhNrk1T
 AU7XxAawcMBJ/QRAfCXSZnxVbdsL5bO4BuB/YtK274H0ae0Kba+5PLETPm6yjZ6/NZxPZYaEnq5
 jxi/gBl22PbRF83qFQMqEfMYcQgvp61X5Z0q3sSQZ6h9LUUaV/k7nVaeclPSsUjmRs9ve2BkaF+
 wymslE+q0aLckPb2/Okv1zXO6TJsOqizPkqfbqhuLp+OqIG+ZaB0b0olNQw7GfKO5t5mrOoyiYp
 bxcBQWoJ9Jdqip7l0PZaVoynVqi3QRwlsUYwJzuPBu40iJpftfT2kGNi452Ps+6f4Pl+Q4Tah3T
 fkfwGOOPdLEQdB4OkzIz4v3Vz6g72igzOIMLpMy1l5UR1xplicUxGndHWl7WAOxELw8CApLM5kW
 1TjEaVgNAegnq89aulTa5XaFMbmRkiAw+y2En09fvuhfwctachWEaE3u6CxRfK8WZqEhsLQp
X-Proofpoint-GUID: QS2mW1azOEym_hMwjkimD5rkPurbGyIF
X-Proofpoint-ORIG-GUID: QS2mW1azOEym_hMwjkimD5rkPurbGyIF
X-Authority-Analysis: v=2.4 cv=W4o4VQWk c=1 sm=1 tr=0 ts=681de2b9 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=dt9VzEwgFbYA:10 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=YH1f5hHw8AKfGPTg1mkA:9
 a=OpyuDcXvxspvyRM73sMx:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-09_04,2025-05-08_04,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 suspectscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 mlxscore=0 adultscore=0
 clxscore=1015 malwarescore=0 impostorscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505090107

For the PMIC5-Gen3 type PMICs, ADC peripheral is present in HW for the
following PMICs: PMK8550, PM8550, PM8550B and PM8550VX PMICs.

It is similar to PMIC5-Gen2, with SW communication to ADCs on all PMICs
going through PBS(Programmable Boot Sequence) firmware through a single
register interface. This interface is implemented on SDAM (Shared
Direct Access Memory) peripherals on the master PMIC PMK8550 rather
than a dedicated ADC peripheral.

Add documentation for PMIC5 Gen3 ADC and macro definitions for ADC
channels and virtual channels (combination of ADC channel number and
PMIC SID number) per PMIC, to be used by clients of this device.

Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
---
Changes since v5:
- Added more details in binding description explaining how number
  of SDAM peripherals used for ADC is allocated per SoC.
- Renamed per-PMIC binding files listing ADC channel macro names 
  and addressed other reviewer comments.

Changes since v4:
- Added ADC5 Gen3 documentation in a separate new file to avoid complicating
  existing VADC documentation file further to accomodate this device, as
  suggested by reviewer.

Changes since v3:
- Added ADC5 Gen3 documentation changes in existing qcom,spmi-vadc.yaml file
  instead of adding separate file and updated top-level constraints in documentation
  file based on discussion with reviewers.
- Dropped default SID definitions.
- Addressed other reviewer comments.

Changes since v2:
- Moved ADC5 Gen3 documentation into a separate new file.

Changes since v1:
- Updated properties separately for all compatibles to clarify usage
  of new properties and updates in usage of old properties for ADC5 Gen3.
- Avoided updating 'adc7' name to 'adc5 gen2' and just left a comment
  mentioning this convention.
- Used predefined channel IDs in individual PMIC channel definitions
  instead of numeric IDs.
- Addressed other comments from reviewers.

 .../bindings/iio/adc/qcom,spmi-adc5-gen3.yaml | 155 ++++++++++++++++++
 .../iio/adc/qcom,spmi-vadc-common.yaml        |   4 +-
 .../bindings/iio/adc/qcom,spmi-vadc.yaml      |   2 +
 .../iio/adc/qcom,pm8550-adc5-gen3.h           |  46 ++++++
 .../iio/adc/qcom,pm8550b-adc5-gen3.h          |  85 ++++++++++
 .../iio/adc/qcom,pm8550vx-adc5-gen3.h         |  22 +++
 .../iio/adc/qcom,pmk8550-adc5-gen3.h          |  52 ++++++
 include/dt-bindings/iio/adc/qcom,spmi-vadc.h  |  81 +++++++++
 8 files changed, 445 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/qcom,spmi-adc5-gen3.yaml
 create mode 100644 include/dt-bindings/iio/adc/qcom,pm8550-adc5-gen3.h
 create mode 100644 include/dt-bindings/iio/adc/qcom,pm8550b-adc5-gen3.h
 create mode 100644 include/dt-bindings/iio/adc/qcom,pm8550vx-adc5-gen3.h
 create mode 100644 include/dt-bindings/iio/adc/qcom,pmk8550-adc5-gen3.h

diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-adc5-gen3.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-adc5-gen3.yaml
new file mode 100644
index 000000000000..40eb20b9d9de
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-adc5-gen3.yaml
@@ -0,0 +1,155 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/qcom,spmi-adc5-gen3.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm's SPMI PMIC ADC5 Gen3
+
+maintainers:
+  - Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
+
+description: |
+  SPMI PMIC5 Gen3 voltage ADC (ADC) provides interface to clients to read
+  voltage. It is a 16-bit sigma-delta ADC. It also performs the same thermal
+  monitoring function as the existing ADC_TM devices.
+
+  The interface is implemented on SDAM (Shared Direct Access Memory) peripherals
+  on the master PMIC rather than a dedicated ADC peripheral. The number of PMIC
+  SDAM peripherals allocated for ADC is not correlated with the PMIC used, it is
+  programmed in FW (PBS) and is fixed per SOC, based on the SOC requirements.
+  All boards using a particular (SOC + master PMIC) combination will have the
+  same number of ADC SDAMs supported on that PMIC.
+
+properties:
+  compatible:
+    const: qcom,spmi-adc5-gen3
+
+  reg:
+    items:
+      - description: SDAM0 base address in the SPMI PMIC register map
+      - description: SDAM1 base address
+    minItems: 1
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 0
+
+  '#io-channel-cells':
+    const: 1
+
+  "#thermal-sensor-cells":
+    const: 1
+
+  interrupts:
+    items:
+      - description: SDAM0 end of conversion (EOC) interrupt
+      - description: SDAM1 EOC interrupt
+    minItems: 1
+
+patternProperties:
+  "^channel@[0-9a-f]+$":
+    type: object
+    unevaluatedProperties: false
+    $ref: /schemas/iio/adc/qcom,spmi-vadc-common.yaml
+    description:
+      Represents the external channels which are connected to the ADC.
+
+    properties:
+      qcom,decimation:
+        enum: [ 85, 340, 1360 ]
+        default: 1360
+
+      qcom,hw-settle-time:
+        enum: [ 15, 100, 200, 300, 400, 500, 600, 700,
+                1000, 2000, 4000, 8000, 16000, 32000, 64000, 128000 ]
+        default: 15
+
+      qcom,avg-samples:
+        enum: [ 1, 2, 4, 8, 16 ]
+        default: 1
+
+      qcom,adc-tm:
+        description:
+          ADC_TM is a threshold monitoring feature in HW which can be enabled
+          on any ADC channel, to trigger an IRQ for threshold violation. In
+          earlier ADC generations, it was implemented in a separate device
+          (documented in Documentation/devicetree/bindings/thermal/qcom-spmi-adc-tm5.yaml.)
+          In Gen3, this feature can be enabled in the same ADC device for any
+          channel and threshold monitoring and IRQ triggering are handled in FW
+          (PBS) instead of another dedicated HW block.
+          This property indicates ADC_TM monitoring is done on this channel.
+        type: boolean
+
+required:
+  - compatible
+  - reg
+  - '#address-cells'
+  - '#size-cells'
+  - '#io-channel-cells'
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/iio/adc/qcom,pmk8550-adc5-gen3.h>
+    #include <dt-bindings/iio/adc/qcom,pm8550-adc5-gen3.h>
+    #include <dt-bindings/iio/adc/qcom,pm8550b-adc5-gen3.h>
+    #include <dt-bindings/iio/adc/qcom,pm8550vx-adc5-gen3.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    pmic {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      adc@9000 {
+        compatible = "qcom,spmi-adc5-gen3";
+        reg = <0x9000>, <0x9100>;
+        interrupts = <0x0 0x90 0x1 IRQ_TYPE_EDGE_RISING>,
+                      <0x0 0x91 0x1 IRQ_TYPE_EDGE_RISING>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+        #io-channel-cells = <1>;
+        #thermal-sensor-cells = <1>;
+
+        /* PMK8550 Channel nodes */
+        channel@3 {
+          reg = <PMK8550_ADC5_GEN3_DIE_TEMP(0)>;
+          label = "pmk8550_die_temp";
+          qcom,pre-scaling = <1 1>;
+        };
+
+        channel@44 {
+          reg = <PMK8550_ADC5_GEN3_AMUX_THM1_XO_THERM_100K_PU(0)>;
+          label = "pmk8550_xo_therm";
+          qcom,pre-scaling = <1 1>;
+          qcom,ratiometric;
+          qcom,hw-settle-time = <200>;
+          qcom,adc-tm;
+        };
+
+        /* PM8550 Channel nodes */
+        channel@103 {
+          reg = <PM8550_ADC5_GEN3_DIE_TEMP(1)>;
+          label = "pm8550_die_temp";
+          qcom,pre-scaling = <1 1>;
+        };
+
+        /* PM8550B Channel nodes */
+        channel@78f {
+          reg = <PM8550B_ADC5_GEN3_VBAT_SNS_QBG(7)>;
+          label = "pm8550b_vbat_sns_qbg";
+          qcom,pre-scaling = <1 3>;
+        };
+
+        /* PM8550VS_C Channel nodes */
+        channel@203 {
+          reg = <PM8550VS_ADC5_GEN3_DIE_TEMP(2)>;
+          label = "pm8550vs_c_die_temp";
+          qcom,pre-scaling = <1 1>;
+        };
+      };
+    };
diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc-common.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc-common.yaml
index cd087911ee88..1531153e6ea8 100644
--- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc-common.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc-common.yaml
@@ -17,8 +17,8 @@ properties:
     description:
       ADC channel number.
       See include/dt-bindings/iio/adc/qcom,spmi-vadc.h
-      For PMIC7 ADC, the channel numbers are specified separately per PMIC
-      in the PMIC-specific files in include/dt-bindings/iio/adc.
+      For PMIC7 ADC and PMIC5 Gen3 ADC, the channel numbers are specified
+      separately per PMIC in the PMIC-specific files in include/dt-bindings/iio/adc.
     maxItems: 1
 
   label:
diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
index b0ccad00c1a6..b77af38440fe 100644
--- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.yaml
@@ -15,6 +15,8 @@ description: |
   voltage. The VADC is a 15-bit sigma-delta ADC.
   SPMI PMIC5/PMIC7 voltage ADC (ADC) provides interface to clients to read
   voltage. The VADC is a 16-bit sigma-delta ADC.
+  Note that PMIC7 ADC is the generation between PMIC5 and PMIC5 Gen3 ADC,
+  it can be considered like PMIC5 Gen2.
 
 properties:
   compatible:
diff --git a/include/dt-bindings/iio/adc/qcom,pm8550-adc5-gen3.h b/include/dt-bindings/iio/adc/qcom,pm8550-adc5-gen3.h
new file mode 100644
index 000000000000..9940715683b4
--- /dev/null
+++ b/include/dt-bindings/iio/adc/qcom,pm8550-adc5-gen3.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2025, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_QCOM_SPMI_VADC_PM8550_H
+#define _DT_BINDINGS_QCOM_SPMI_VADC_PM8550_H
+
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
+
+/* ADC channels for PM8550_ADC for PMIC5 Gen3 */
+#define PM8550_ADC5_GEN3_REF_GND(sid)			((sid) << 8 | ADC5_GEN3_REF_GND)
+#define PM8550_ADC5_GEN3_1P25VREF(sid)			((sid) << 8 | ADC5_GEN3_1P25VREF)
+#define PM8550_ADC5_GEN3_VREF_VADC(sid)			((sid) << 8 | ADC5_GEN3_VREF_VADC)
+#define PM8550_ADC5_GEN3_DIE_TEMP(sid)			((sid) << 8 | ADC5_GEN3_DIE_TEMP)
+
+#define PM8550_ADC5_GEN3_AMUX_THM1(sid)			((sid) << 8 | ADC5_GEN3_AMUX1_THM)
+#define PM8550_ADC5_GEN3_AMUX_THM2(sid)			((sid) << 8 | ADC5_GEN3_AMUX2_THM)
+#define PM8550_ADC5_GEN3_AMUX_THM3(sid)			((sid) << 8 | ADC5_GEN3_AMUX3_THM)
+#define PM8550_ADC5_GEN3_AMUX_THM4(sid)			((sid) << 8 | ADC5_GEN3_AMUX4_THM)
+#define PM8550_ADC5_GEN3_AMUX_THM5(sid)			((sid) << 8 | ADC5_GEN3_AMUX5_THM)
+#define PM8550_ADC5_GEN3_AMUX_THM6_GPIO2(sid)		((sid) << 8 | ADC5_GEN3_AMUX6_THM)
+#define PM8550_ADC5_GEN3_AMUX1_GPIO3(sid)		((sid) << 8 | ADC5_GEN3_AMUX1_GPIO)
+#define PM8550_ADC5_GEN3_AMUX2_GPIO4(sid)		((sid) << 8 | ADC5_GEN3_AMUX2_GPIO)
+#define PM8550_ADC5_GEN3_AMUX3_GPIO7(sid)		((sid) << 8 | ADC5_GEN3_AMUX3_GPIO)
+#define PM8550_ADC5_GEN3_AMUX4_GPIO12(sid)		((sid) << 8 | ADC5_GEN3_AMUX4_GPIO)
+
+/* 100k pull-up */
+#define PM8550_ADC5_GEN3_AMUX_THM1_100K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX1_THM_100K_PU)
+#define PM8550_ADC5_GEN3_AMUX_THM2_100K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX2_THM_100K_PU)
+#define PM8550_ADC5_GEN3_AMUX_THM3_100K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX3_THM_100K_PU)
+#define PM8550_ADC5_GEN3_AMUX_THM4_100K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX4_THM_100K_PU)
+#define PM8550_ADC5_GEN3_AMUX_THM5_100K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX5_THM_100K_PU)
+#define PM8550_ADC5_GEN3_AMUX_THM6_GPIO2_100K_PU(sid)	((sid) << 8 | ADC5_GEN3_AMUX6_THM_100K_PU)
+#define PM8550_ADC5_GEN3_AMUX1_GPIO3_100K_PU(sid)	((sid) << 8 | ADC5_GEN3_AMUX1_GPIO_100K_PU)
+#define PM8550_ADC5_GEN3_AMUX2_GPIO4_100K_PU(sid)	((sid) << 8 | ADC5_GEN3_AMUX2_GPIO_100K_PU)
+#define PM8550_ADC5_GEN3_AMUX3_GPIO7_100K_PU(sid)	((sid) << 8 | ADC5_GEN3_AMUX3_GPIO_100K_PU)
+#define PM8550_ADC5_GEN3_AMUX4_GPIO12_100K_PU(sid)	((sid) << 8 | ADC5_GEN3_AMUX4_GPIO_100K_PU)
+
+/* 1/3 Divider */
+#define PM8550_ADC5_GEN3_AMUX3_GPIO7_DIV3(sid)		((sid) << 8 | ADC5_GEN3_AMUX3_GPIO_DIV3)
+#define PM8550_ADC5_GEN3_AMUX4_GPIO12_DIV3(sid)		((sid) << 8 | ADC5_GEN3_AMUX4_GPIO_DIV3)
+
+#define PM8550_ADC5_GEN3_VPH_PWR(sid)			((sid) << 8 | ADC5_GEN3_VPH_PWR)
+
+#endif /* _DT_BINDINGS_QCOM_SPMI_VADC_PM8550_H */
diff --git a/include/dt-bindings/iio/adc/qcom,pm8550b-adc5-gen3.h b/include/dt-bindings/iio/adc/qcom,pm8550b-adc5-gen3.h
new file mode 100644
index 000000000000..1226597c02a7
--- /dev/null
+++ b/include/dt-bindings/iio/adc/qcom,pm8550b-adc5-gen3.h
@@ -0,0 +1,85 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2025, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_QCOM_SPMI_VADC_PM8550B_H
+#define _DT_BINDINGS_QCOM_SPMI_VADC_PM8550B_H
+
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
+
+/* ADC channels for PM8550B_ADC for PMIC5 Gen3 */
+#define PM8550B_ADC5_GEN3_REF_GND(sid)			((sid) << 8 | ADC5_GEN3_REF_GND)
+#define PM8550B_ADC5_GEN3_1P25VREF(sid)			((sid) << 8 | ADC5_GEN3_1P25VREF)
+#define PM8550B_ADC5_GEN3_VREF_VADC(sid)		((sid) << 8 | ADC5_GEN3_VREF_VADC)
+#define PM8550B_ADC5_GEN3_DIE_TEMP(sid)			((sid) << 8 | ADC5_GEN3_DIE_TEMP)
+
+#define PM8550B_ADC5_GEN3_AMUX_THM1_BATT_THERM(sid)	((sid) << 8 | ADC5_GEN3_AMUX1_THM)
+#define PM8550B_ADC5_GEN3_AMUX_THM2_BATT_ID(sid)	((sid) << 8 | ADC5_GEN3_AMUX2_THM)
+#define PM8550B_ADC5_GEN3_AMUX_THM3_SMB_TEMP_V(sid)	((sid) << 8 | ADC5_GEN3_AMUX3_THM)
+#define PM8550B_ADC5_GEN3_AMUX_THM4_USB_THERM(sid)	((sid) << 8 | ADC5_GEN3_AMUX4_THM)
+#define PM8550B_ADC5_GEN3_AMUX_THM5_OPTION(sid)		((sid) << 8 | ADC5_GEN3_AMUX5_THM)
+#define PM8550B_ADC5_GEN3_AMUX_THM6_GPIO10(sid)		((sid) << 8 | ADC5_GEN3_AMUX6_THM)
+#define PM8550B_ADC5_GEN3_AMUX1_GPIO1(sid)		((sid) << 8 | ADC5_GEN3_AMUX1_GPIO)
+#define PM8550B_ADC5_GEN3_AMUX2_GPIO5(sid)		((sid) << 8 | ADC5_GEN3_AMUX2_GPIO)
+#define PM8550B_ADC5_GEN3_AMUX3_GPIO6(sid)		((sid) << 8 | ADC5_GEN3_AMUX3_GPIO)
+#define PM8550B_ADC5_GEN3_AMUX4_GPIO12(sid)		((sid) << 8 | ADC5_GEN3_AMUX4_GPIO)
+
+#define PM8550B_ADC5_GEN3_CHG_TEMP(sid)			((sid) << 8 | ADC5_GEN3_CHG_TEMP)
+#define PM8550B_ADC5_GEN3_USB_SNS_V_16(sid)		((sid) << 8 | ADC5_GEN3_USB_SNS_V_16)
+#define PM8550B_ADC5_GEN3_VIN_DIV16_MUX(sid)		((sid) << 8 | ADC5_GEN3_VIN_DIV16_MUX)
+#define PM8550B_ADC5_GEN3_VREF_BAT_THERM(sid)		((sid) << 8 | ADC5_GEN3_VREF_BAT_THERM)
+#define PM8550B_ADC5_GEN3_IIN_FB(sid)			((sid) << 8 | ADC5_GEN3_IIN_FB)
+#define PM8550B_ADC5_GEN3_TEMP_ALARM_LITE(sid)		((sid) << 8 | ADC5_GEN3_TEMP_ALARM_LITE)
+#define PM8550B_ADC5_GEN3_SMB_IIN(sid)			((sid) << 8 | ADC5_GEN3_IIN_SMB)
+#define PM8550B_ADC5_GEN3_SMB_ICHG(sid)			((sid) << 8 | ADC5_GEN3_ICHG_SMB)
+#define PM8550B_ADC5_GEN3_ICHG_FB(sid)			((sid) << 8 | ADC5_GEN3_ICHG_FB)
+
+/* 30k pull-up */
+#define PM8550B_ADC5_GEN3_AMUX_THM1_BATT_THERM_30K_PU(sid)	((sid) << 8 | ADC5_GEN3_AMUX1_THM_30K_PU)
+#define PM8550B_ADC5_GEN3_AMUX_THM2_BATT_ID_30K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX2_THM_30K_PU)
+#define PM8550B_ADC5_GEN3_AMUX_THM3_SMB_TEMP_V_30K_PU(sid)	((sid) << 8 | ADC5_GEN3_AMUX3_THM_30K_PU)
+#define PM8550B_ADC5_GEN3_AMUX_THM4_USB_THERM_30K_PU(sid)	((sid) << 8 | ADC5_GEN3_AMUX4_THM_30K_PU)
+#define PM8550B_ADC5_GEN3_AMUX_THM5_OPTION_30K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX5_THM_30K_PU)
+#define PM8550B_ADC5_GEN3_AMUX_THM6_GPIO10_30K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX6_THM_30K_PU)
+#define PM8550B_ADC5_GEN3_AMUX1_GPIO1_30K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX1_GPIO_30K_PU)
+#define PM8550B_ADC5_GEN3_AMUX2_GPIO5_30K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX2_GPIO_30K_PU)
+#define PM8550B_ADC5_GEN3_AMUX3_GPIO6_30K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX3_GPIO_30K_PU)
+#define PM8550B_ADC5_GEN3_AMUX4_GPIO12_30K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX4_GPIO_30K_PU)
+
+/* 100k pull-up */
+#define PM8550B_ADC5_GEN3_AMUX_THM1_BATT_THERM_100K_PU(sid)	((sid) << 8 | ADC5_GEN3_AMUX1_THM_100K_PU)
+#define PM8550B_ADC5_GEN3_AMUX_THM2_BATT_ID_100K_PU(sid)	((sid) << 8 | ADC5_GEN3_AMUX2_THM_100K_PU)
+#define PM8550B_ADC5_GEN3_AMUX_THM3_SMB_TEMP_V_100K_PU(sid)	((sid) << 8 | ADC5_GEN3_AMUX3_THM_100K_PU)
+#define PM8550B_ADC5_GEN3_AMUX_THM4_USB_THERM_100K_PU(sid)	((sid) << 8 | ADC5_GEN3_AMUX4_THM_100K_PU)
+#define PM8550B_ADC5_GEN3_AMUX_THM5_OPTION_100K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX5_THM_100K_PU)
+#define PM8550B_ADC5_GEN3_AMUX_THM6_GPIO10_100K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX6_THM_100K_PU)
+#define PM8550B_ADC5_GEN3_AMUX1_GPIO1_100K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX1_GPIO_100K_PU)
+#define PM8550B_ADC5_GEN3_AMUX2_GPIO5_100K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX2_GPIO_100K_PU)
+#define PM8550B_ADC5_GEN3_AMUX3_GPIO6_100K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX3_GPIO_100K_PU)
+#define PM8550B_ADC5_GEN3_AMUX4_GPIO12_100K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX4_GPIO_100K_PU)
+
+/* 400k pull-up */
+#define PM8550B_ADC5_GEN3_AMUX_THM1_BATT_THERM_400K_PU(sid)	((sid) << 8 | ADC5_GEN3_AMUX1_THM_400K_PU)
+#define PM8550B_ADC5_GEN3_AMUX_THM2_BATT_ID_400K_PU(sid)	((sid) << 8 | ADC5_GEN3_AMUX2_THM_400K_PU)
+#define PM8550B_ADC5_GEN3_AMUX_THM3_SMB_TEMP_V_400K_PU(sid)	((sid) << 8 | ADC5_GEN3_AMUX3_THM_400K_PU)
+#define PM8550B_ADC5_GEN3_AMUX_THM4_USB_THERM_400K_PU(sid)	((sid) << 8 | ADC5_GEN3_AMUX4_THM_400K_PU)
+#define PM8550B_ADC5_GEN3_AMUX_THM5_OPTION_400K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX5_THM_400K_PU)
+#define PM8550B_ADC5_GEN3_AMUX_THM6_GPIO10_400K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX6_THM_400K_PU)
+#define PM8550B_ADC5_GEN3_AMUX1_GPIO1_400K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX1_GPIO_400K_PU)
+#define PM8550B_ADC5_GEN3_AMUX2_GPIO5_400K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX2_GPIO_400K_PU)
+#define PM8550B_ADC5_GEN3_AMUX3_GPIO6_400K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX3_GPIO_400K_PU)
+#define PM8550B_ADC5_GEN3_AMUX4_GPIO12_400K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX4_GPIO_400K_PU)
+
+/* 1/3 Divider */
+#define PM8550B_ADC5_GEN3_AMUX1_GPIO1_DIV3(sid)		((sid) << 8 | ADC5_GEN3_AMUX1_GPIO_DIV3)
+#define PM8550B_ADC5_GEN3_AMUX2_GPIO5_DIV3(sid)		((sid) << 8 | ADC5_GEN3_AMUX2_GPIO_DIV3)
+#define PM8550B_ADC5_GEN3_AMUX3_GPIO6_DIV3(sid)		((sid) << 8 | ADC5_GEN3_AMUX3_GPIO_DIV3)
+
+#define PM8550B_ADC5_GEN3_VPH_PWR(sid)			((sid) << 8 | ADC5_GEN3_VPH_PWR)
+#define PM8550B_ADC5_GEN3_VBAT_SNS_QBG(sid)		((sid) << 8 | ADC5_GEN3_VBAT_SNS_QBG)
+#define PM8550B_ADC5_GEN3_VBAT_SNS_CHGR(sid)		((sid) << 8 | ADC5_GEN3_VBAT_SNS_CHGR)
+#define PM8550B_ADC5_GEN3_VBAT_2S_MID_QBG(sid)		((sid) << 8 | ADC5_GEN3_VBAT_2S_MID_QBG)
+#define PM8550B_ADC5_GEN3_VBAT_2S_MID_CHGR(sid)		((sid) << 8 | ADC5_GEN3_VBAT_2S_MID_CHGR)
+
+#endif /* _DT_BINDINGS_QCOM_SPMI_VADC_PM8550B_H */
diff --git a/include/dt-bindings/iio/adc/qcom,pm8550vx-adc5-gen3.h b/include/dt-bindings/iio/adc/qcom,pm8550vx-adc5-gen3.h
new file mode 100644
index 000000000000..03a353440325
--- /dev/null
+++ b/include/dt-bindings/iio/adc/qcom,pm8550vx-adc5-gen3.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2025, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_QCOM_SPMI_VADC_PM8550VX_H
+#define _DT_BINDINGS_QCOM_SPMI_VADC_PM8550VX_H
+
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
+
+/* ADC channels for PM8550VX_ADC for PMIC5 Gen3 */
+#define PM8550VS_ADC5_GEN3_REF_GND(sid)			((sid) << 8 | ADC5_GEN3_REF_GND)
+#define PM8550VS_ADC5_GEN3_1P25VREF(sid)			((sid) << 8 | ADC5_GEN3_1P25VREF)
+#define PM8550VS_ADC5_GEN3_VREF_VADC(sid)			((sid) << 8 | ADC5_GEN3_VREF_VADC)
+#define PM8550VS_ADC5_GEN3_DIE_TEMP(sid)			((sid) << 8 | ADC5_GEN3_DIE_TEMP)
+
+#define PM8550VE_ADC5_GEN3_OFFSET_REF(sid)			((sid) << 8 | ADC5_GEN3_REF_GND)
+#define PM8550VE_ADC5_GEN3_1P25VREF(sid)			((sid) << 8 | ADC5_GEN3_1P25VREF)
+#define PM8550VE_ADC5_GEN3_VREF_VADC(sid)			((sid) << 8 | ADC5_GEN3_VREF_VADC)
+#define PM8550VE_ADC5_GEN3_DIE_TEMP(sid)		((sid) << 8 | ADC5_GEN3_DIE_TEMP)
+
+#endif /* _DT_BINDINGS_QCOM_SPMI_VADC_PM8550VX_H */
diff --git a/include/dt-bindings/iio/adc/qcom,pmk8550-adc5-gen3.h b/include/dt-bindings/iio/adc/qcom,pmk8550-adc5-gen3.h
new file mode 100644
index 000000000000..88fed365cc9e
--- /dev/null
+++ b/include/dt-bindings/iio/adc/qcom,pmk8550-adc5-gen3.h
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2025, Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_QCOM_SPMI_VADC_PMK8550_H
+#define _DT_BINDINGS_QCOM_SPMI_VADC_PMK8550_H
+
+#include <dt-bindings/iio/adc/qcom,spmi-vadc.h>
+
+/* ADC channels for PMK8550_ADC for PMIC5 Gen3 */
+#define PMK8550_ADC5_GEN3_REF_GND(sid)			((sid) << 8 | ADC5_GEN3_REF_GND)
+#define PMK8550_ADC5_GEN3_1P25VREF(sid)			((sid) << 8 | ADC5_GEN3_1P25VREF)
+#define PMK8550_ADC5_GEN3_VREF_VADC(sid)		((sid) << 8 | ADC5_GEN3_VREF_VADC)
+#define PMK8550_ADC5_GEN3_DIE_TEMP(sid)			((sid) << 8 | ADC5_GEN3_DIE_TEMP)
+
+#define PMK8550_ADC5_GEN3_AMUX_THM1_XO_THERM(sid)	((sid) << 8 | ADC5_GEN3_AMUX1_THM)
+#define PMK8550_ADC5_GEN3_AMUX_THM2_GPIO1(sid)		((sid) << 8 | ADC5_GEN3_AMUX2_THM)
+#define PMK8550_ADC5_GEN3_AMUX_THM3_GPIO2(sid)		((sid) << 8 | ADC5_GEN3_AMUX3_THM)
+#define PMK8550_ADC5_GEN3_AMUX_THM4_GPIO3(sid)		((sid) << 8 | ADC5_GEN3_AMUX4_THM)
+#define PMK8550_ADC5_GEN3_AMUX_THM5_GPIO4(sid)		((sid) << 8 | ADC5_GEN3_AMUX5_THM)
+#define PMK8550_ADC5_GEN3_AMUX_THM6_GPIO5(sid)		((sid) << 8 | ADC5_GEN3_AMUX6_THM)
+#define PMK8550_ADC5_GEN3_AMUX1_GPIO6(sid)		((sid) << 8 | ADC5_GEN3_AMUX1_GPIO)
+
+/* 30k pull-up */
+#define PMK8550_ADC5_GEN3_AMUX_THM1_XO_THERM_30K_PU(sid)	((sid) << 8 | ADC5_GEN3_AMUX1_THM_30K_PU)
+#define PMK8550_ADC5_GEN3_AMUX_THM2_GPIO1_30K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX2_THM_30K_PU)
+#define PMK8550_ADC5_GEN3_AMUX_THM3_GPIO2_30K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX3_THM_30K_PU)
+#define PMK8550_ADC5_GEN3_AMUX_THM4_GPIO3_30K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX4_THM_30K_PU)
+#define PMK8550_ADC5_GEN3_AMUX_THM5_GPIO4_30K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX5_THM_30K_PU)
+#define PMK8550_ADC5_GEN3_AMUX_THM6_GPIO5_30K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX6_THM_30K_PU)
+#define PMK8550_ADC5_GEN3_AMUX1_GPIO6_30K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX1_GPIO_30K_PU)
+
+/* 100k pull-up */
+#define PMK8550_ADC5_GEN3_AMUX_THM1_XO_THERM_100K_PU(sid)	((sid) << 8 | ADC5_GEN3_AMUX1_THM_100K_PU)
+#define PMK8550_ADC5_GEN3_AMUX_THM2_GPIO1_100K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX2_THM_100K_PU)
+#define PMK8550_ADC5_GEN3_AMUX_THM3_GPIO2_100K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX3_THM_100K_PU)
+#define PMK8550_ADC5_GEN3_AMUX_THM4_GPIO3_100K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX4_THM_100K_PU)
+#define PMK8550_ADC5_GEN3_AMUX_THM5_GPIO4_100K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX5_THM_100K_PU)
+#define PMK8550_ADC5_GEN3_AMUX_THM6_GPIO5_100K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX6_THM_100K_PU)
+#define PMK8550_ADC5_GEN3_AMUX1_GPIO6_100K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX1_GPIO_100K_PU)
+
+/* 400k pull-up */
+#define PMK8550_ADC5_GEN3_AMUX_THM1_XO_THERM_400K_PU(sid)	((sid) << 8 | ADC5_GEN3_AMUX1_THM_400K_PU)
+#define PMK8550_ADC5_GEN3_AMUX_THM2_GPIO1_400K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX2_THM_400K_PU)
+#define PMK8550_ADC5_GEN3_AMUX_THM3_GPIO2_400K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX3_THM_400K_PU)
+#define PMK8550_ADC5_GEN3_AMUX_THM4_GPIO3_400K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX4_THM_400K_PU)
+#define PMK8550_ADC5_GEN3_AMUX_THM5_GPIO4_400K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX5_THM_400K_PU)
+#define PMK8550_ADC5_GEN3_AMUX_THM6_GPIO5_400K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX6_THM_400K_PU)
+#define PMK8550_ADC5_GEN3_AMUX1_GPIO6_400K_PU(sid)		((sid) << 8 | ADC5_GEN3_AMUX1_GPIO_400K_PU)
+
+#endif /* _DT_BINDINGS_QCOM_SPMI_VADC_PMK8550_H */
diff --git a/include/dt-bindings/iio/adc/qcom,spmi-vadc.h b/include/dt-bindings/iio/adc/qcom,spmi-vadc.h
index ef07ecd4d585..73efd8fda4b2 100644
--- a/include/dt-bindings/iio/adc/qcom,spmi-vadc.h
+++ b/include/dt-bindings/iio/adc/qcom,spmi-vadc.h
@@ -1,6 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Copyright (c) 2012-2014,2018,2020 The Linux Foundation. All rights reserved.
+ *
+ * Copyright (c) 2025, Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
 #ifndef _DT_BINDINGS_QCOM_SPMI_VADC_H
@@ -300,4 +302,83 @@
 #define ADC7_SBUx				0x94
 #define ADC7_VBAT_2S_MID			0x96
 
+/* ADC channels for PMIC5 Gen3 */
+
+#define ADC5_GEN3_REF_GND			0x00
+#define ADC5_GEN3_1P25VREF			0x01
+#define ADC5_GEN3_VREF_VADC			0x02
+#define ADC5_GEN3_DIE_TEMP			0x03
+
+#define ADC5_GEN3_AMUX1_THM			0x04
+#define ADC5_GEN3_AMUX2_THM			0x05
+#define ADC5_GEN3_AMUX3_THM			0x06
+#define ADC5_GEN3_AMUX4_THM			0x07
+#define ADC5_GEN3_AMUX5_THM			0x08
+#define ADC5_GEN3_AMUX6_THM			0x09
+#define ADC5_GEN3_AMUX1_GPIO			0x0a
+#define ADC5_GEN3_AMUX2_GPIO			0x0b
+#define ADC5_GEN3_AMUX3_GPIO			0x0c
+#define ADC5_GEN3_AMUX4_GPIO			0x0d
+
+#define ADC5_GEN3_CHG_TEMP			0x10
+#define ADC5_GEN3_USB_SNS_V_16			0x11
+#define ADC5_GEN3_VIN_DIV16_MUX			0x12
+#define ADC5_GEN3_VREF_BAT_THERM		0x15
+#define ADC5_GEN3_IIN_FB			0x17
+#define ADC5_GEN3_TEMP_ALARM_LITE		0x18
+#define ADC5_GEN3_IIN_SMB			0x19
+#define ADC5_GEN3_ICHG_SMB			0x1b
+#define ADC5_GEN3_ICHG_FB			0xa1
+
+/* 30k pull-up1 */
+#define ADC5_GEN3_AMUX1_THM_30K_PU		0x24
+#define ADC5_GEN3_AMUX2_THM_30K_PU		0x25
+#define ADC5_GEN3_AMUX3_THM_30K_PU		0x26
+#define ADC5_GEN3_AMUX4_THM_30K_PU		0x27
+#define ADC5_GEN3_AMUX5_THM_30K_PU		0x28
+#define ADC5_GEN3_AMUX6_THM_30K_PU		0x29
+#define ADC5_GEN3_AMUX1_GPIO_30K_PU		0x2a
+#define ADC5_GEN3_AMUX2_GPIO_30K_PU		0x2b
+#define ADC5_GEN3_AMUX3_GPIO_30K_PU		0x2c
+#define ADC5_GEN3_AMUX4_GPIO_30K_PU		0x2d
+
+/* 100k pull-up2 */
+#define ADC5_GEN3_AMUX1_THM_100K_PU		0x44
+#define ADC5_GEN3_AMUX2_THM_100K_PU		0x45
+#define ADC5_GEN3_AMUX3_THM_100K_PU		0x46
+#define ADC5_GEN3_AMUX4_THM_100K_PU		0x47
+#define ADC5_GEN3_AMUX5_THM_100K_PU		0x48
+#define ADC5_GEN3_AMUX6_THM_100K_PU		0x49
+#define ADC5_GEN3_AMUX1_GPIO_100K_PU		0x4a
+#define ADC5_GEN3_AMUX2_GPIO_100K_PU		0x4b
+#define ADC5_GEN3_AMUX3_GPIO_100K_PU		0x4c
+#define ADC5_GEN3_AMUX4_GPIO_100K_PU		0x4d
+
+/* 400k pull-up3 */
+#define ADC5_GEN3_AMUX1_THM_400K_PU		0x64
+#define ADC5_GEN3_AMUX2_THM_400K_PU		0x65
+#define ADC5_GEN3_AMUX3_THM_400K_PU		0x66
+#define ADC5_GEN3_AMUX4_THM_400K_PU		0x67
+#define ADC5_GEN3_AMUX5_THM_400K_PU		0x68
+#define ADC5_GEN3_AMUX6_THM_400K_PU		0x69
+#define ADC5_GEN3_AMUX1_GPIO_400K_PU		0x6a
+#define ADC5_GEN3_AMUX2_GPIO_400K_PU		0x6b
+#define ADC5_GEN3_AMUX3_GPIO_400K_PU		0x6c
+#define ADC5_GEN3_AMUX4_GPIO_400K_PU		0x6d
+
+/* 1/3 Divider */
+#define ADC5_GEN3_AMUX1_GPIO_DIV3		0x8a
+#define ADC5_GEN3_AMUX2_GPIO_DIV3		0x8b
+#define ADC5_GEN3_AMUX3_GPIO_DIV3		0x8c
+#define ADC5_GEN3_AMUX4_GPIO_DIV3		0x8d
+
+#define ADC5_GEN3_VPH_PWR			0x8e
+#define ADC5_GEN3_VBAT_SNS_QBG			0x8f
+
+#define ADC5_GEN3_VBAT_SNS_CHGR			0x94
+#define ADC5_GEN3_VBAT_2S_MID_QBG		0x96
+#define ADC5_GEN3_VBAT_2S_MID_CHGR		0x9d
+
+#define ADC5_GEN3_OFFSET_EXT2			0xf8
+
 #endif /* _DT_BINDINGS_QCOM_SPMI_VADC_H */
-- 
2.25.1


