Return-Path: <linux-kernel+bounces-747162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6D8B1308E
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 18:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E94243A1624
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 16:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313C421D3DC;
	Sun, 27 Jul 2025 16:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OZynjd0b"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDCB2248AE
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 16:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753633553; cv=none; b=fyRgN3iOyihCfWA5ZqHSmxDYWQ2cIvpOYNmikQM3jsY1AwRr0j8cTy7BCh59wfSjeJAvV9ZDgr7PxtOL83CVzZQ+ibhm3Fz6T1vg5LELcpAfmHEspmfEUbC50iJo6tKRq3DQE7yAWfX6YQCOoI9966kpabTNElzx/XOE0C63Jo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753633553; c=relaxed/simple;
	bh=TXtx922bW7Cthax35l5eL6qlXJtqJfd163vx/p8QQUw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jiClPvg8BfHB7LTLmvk1Vkv+9qqT669Cfem+vOgjBvtlNtvxOtspWh9MjdrXhbnC7VOsqWUE1neBO2yguNC9bQw9pZYyiubk5orrc7KSptRcf+SxpWPljDLq/mKMx9sEfrjkk/A1Jq5lx7m+YqRbDUXX6hZZ0ltSnbmYyCNjxl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OZynjd0b; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56REP07G031953
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 16:25:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dVmI/zpQBLHcmY6/km9+lnVLqKzUs1cGOy2afpNbw1A=; b=OZynjd0bEGHbnJJ3
	IWW/B+kDbmJVKigmjkl1uTDl5LCq3FVamQjo/ab340CcnS6W4wYsKSqRSuDZ2xkI
	uz8pouY58AIthEQHNdVJwGEj59ZvtTQXhmLF02qtSg7q8eiTg4WaYmnR/CIQ5D0B
	1ZqsG+u5s4c+Jsx5dpDME/gZh48EggAr8o15CvWkLUA2/YO78dQ34EX0bxrsGKGw
	OZJ21VI9E33OgyfTJcE+YqK9O+ShZptev+nOH/8JKUHXN4NtqY4X98m+vKoXn8rh
	yUXH9MTJfN6Mi7Y6Nv9MoR3L0UOP9zON8kbAUOP/PewWsFd1oJ4Vb2E9CEwYx3J5
	Ylt8dw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484pbktb79-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 16:25:50 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b00e4358a34so2468424a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 09:25:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753633549; x=1754238349;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dVmI/zpQBLHcmY6/km9+lnVLqKzUs1cGOy2afpNbw1A=;
        b=h/NyXNCr+36VRNxuDQYWYiZjAGt4iyiqUrSSkkq4iL8TcVShILL8i11E30T3sASZMV
         OZlUoJuLSRVd/zYbVzJVv9vjJnBbRbMFiCUBLHVgVoqTx/GwnGH8ETF6gRDPN3sm2t6n
         E6X9APb6vzse9L5vRmVEL5vm9yBjpiI8ZkbQU025zRfGEPjZtrmxsTxgQZUg1EqB9YE4
         Lav7DlkDE0vjFMkv67iNsSDo1nOdsf45pVAnDPppydv2KJ5etejSRmvz/Nsis1GYHVaw
         tFPqtTae4bp90ICc0FXO5cyeJ6uivpZsUprBG2uHzUY4wVtnvoUadAcEsWzW3I0dKUTD
         itYA==
X-Forwarded-Encrypted: i=1; AJvYcCUNU3Vb0iuhuYI5gJEMB4WMOCmlTCLb/8zfZOxO17n7YEVlhqZVLySMMgg3RQ/g8o2QNp1NkUSxHz9tIRE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCGW5jHtFHik1og25KVtVIcJ2YXep7DewBlZ06F7IpDjQLgJ/z
	J6Ks2E+Wp459MnBoPgruTG5n/Ku4RB7Nj6dQzkCGriYDy948+3PYN3skKtxTwvt1Sd3TSqmuHa6
	e3EE0hzM2glC9GQRNhd2ZQrgpmNue3Riqe1FY3jWEuP0vE+ToBRz+vDMdVZolWfRX9XU=
X-Gm-Gg: ASbGncuq/URxxoJjlh2ELo9BwiPG4QvGax0xAWh5upTP0n6y66ZDw3R7uMOhzD+RfDY
	4E7amHxTHPyIncpC6PLTbCtbWn9xN2MFi14Ma5GJzs9Mral1q/dV9YCy3D64k2Fp+OaEGAO5M5f
	tx+2CwxbMi9TX+agYTR3WuTsoWOwfnaQ8z2si8bv5GiozWaI3Kbd6N5H4PqbBdjJbQe8qt/KJ2d
	AMPF85Etfu4nfaENz++TGnAm1fgfwcgnQCffSqxJzwkPsqX8KLzGXdKYbKmtI70E6tIkDJFaaDh
	1iMPeAupo2XISM1XYNJ39qJ+gEZGpug0bFvtreom7O8yIunekju+TpoBospUalnGipdbjejrBvX
	V
X-Received: by 2002:a17:903:1107:b0:23f:d903:d867 with SMTP id d9443c01a7336-23fd903d9fdmr68042015ad.35.1753633549291;
        Sun, 27 Jul 2025 09:25:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEL3wWdtZ6aYUyxBwD4I04sxzmNGeS8xOyoLA0/pGD4nypDDQZu/utCQqLS7ndqtErXNjHKbw==
X-Received: by 2002:a17:903:1107:b0:23f:d903:d867 with SMTP id d9443c01a7336-23fd903d9fdmr68041555ad.35.1753633548710;
        Sun, 27 Jul 2025 09:25:48 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fd9397ebbsm29110325ad.210.2025.07.27.09.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 09:25:48 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Sun, 27 Jul 2025 21:54:49 +0530
Subject: [PATCH v13 06/10] dt-bindings: arm: Document reboot mode magic
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250727-arm-psci-system_reset2-vendor-reboots-v13-6-6b8d23315898@oss.qualcomm.com>
References: <20250727-arm-psci-system_reset2-vendor-reboots-v13-0-6b8d23315898@oss.qualcomm.com>
In-Reply-To: <20250727-arm-psci-system_reset2-vendor-reboots-v13-0-6b8d23315898@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753633495; l=2577;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=Pb0JW5FgpXpfFWALyentRdrGNmebMgVj4WCNzS0Y1bY=;
 b=q2Cpgc5X/5vvp5IW+bSMM73MNGrPdxZ9TyGWHgnn7fEPw/7YCTssgw97rASyUi8M1FNatC4RE
 D62Y1b8i1PMAAg0ElzQjqtUuEhXWnmNzMVrBj50GG82dX0mbqehtdl0
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Authority-Analysis: v=2.4 cv=LsaSymdc c=1 sm=1 tr=0 ts=6886530e cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=UInjrUrXc7y1C1sAkbYA:9 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI3MDE0NiBTYWx0ZWRfX5eTsiFiqPnLw
 ZtqgHi6UbdTv2FGdaF6y1iKqcADVwL9NALrfm2RJRnI5YgK5vf81e/rKAJjaQdKRCpW3t7VUVj3
 7ks0nb0aQ+xsF3S3AjOB0Lc5szGE6qzSghhRwGCETs47jw3S8hxvpAB+7C5BVTQqU+HkIjusUE4
 r5pko6DjNrbYLLdx9qgtRYAPV/AgSW8/pZfvN+Xz2+UPy8bBT/1JBCAXIsNVF4Xsq3keaJ/GOeI
 lBHpmmtgN/d/XAt1ay0610IdzPi17q9VHTeI/lFlCavZ0XHQI1ZUjMvgjkQZsxoS14vjuBJSIPt
 4iD7CFHITbBNO8Ni1wZaX/CAJQOtACVlexWYrwu/K1U7XmKmCfV3HI+VH/EernRAuCSxACUjaXU
 EjzIoMOjTTwA7zQlmwySqrIQiw1Md1yP/5GPqXlTRLkQ37i37sTOSonaJQVA5ZVJn35trEnD
X-Proofpoint-ORIG-GUID: 1j--TDbcwLsa7or2R3LnbxFePVQ5TmUv
X-Proofpoint-GUID: 1j--TDbcwLsa7or2R3LnbxFePVQ5TmUv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-27_05,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=999 spamscore=0 phishscore=0 suspectscore=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 mlxscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507270146

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
index 7360a2849b5bd1e4cbadac533c1a7228573288d4..da3a584c76b48e313a5d4cb7c8e0c3a3628fd1bb 100644
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
+        reset-types: false
 
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


