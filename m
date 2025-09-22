Return-Path: <linux-kernel+bounces-827333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A1E5B9175E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A51003BC003
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 13:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFDB3101B6;
	Mon, 22 Sep 2025 13:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dDd//0gJ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BAB30FF3B
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 13:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758548490; cv=none; b=Ke7eZtOfPDw3qnW1wVl2To3TIwqgj2EGmB74hxX/MV3M/yL0HGjpqXpSPE6JoIGNH/vJI1iuQKyq+hKDnHF3rJZ8fSvSWJyq581+8uiZJrRmdATpM1wZxS5MZLPACq88/QXDljHdIGj8pqPJDPImRK0MSVHvtk7hM5p+VrjCNO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758548490; c=relaxed/simple;
	bh=R3BNXlzor3OWM1UHW0bocrQrgSVBuB1WLn0clYEcPVU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IsrJvTIbuAFMW3Zdx/2bdSanTUQTgQHAvZETPZJVtVBII8ax66c6gsLDMiWb/Q5NORTzJYVPWYJkVgleyZIrMAlpv7HGwb4Z92XF+r8c7W5IIAmo/NFg3Ak74tAVRJaJcgABgMMsFEMSLjiRHTG1G69vKVhrA82VCpjRw2JoLwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dDd//0gJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58M8x9o2008593
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 13:41:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PIWnFWN9JswVjgeJAZVSk7CUtGSis2EJBGP3G7aJZqM=; b=dDd//0gJ0/kkvliw
	mQcChpU452MYo9eFEYDB4MkQikrDUyije6EDRTXHpDzBryE6UemVVLWWHC6Zk/Ik
	aoFcDATml5Tnkf8OaRMkOLnvowbPSNqnxSmvIpPRJxX1yrew29jXlRmTK2hUy3r8
	A6wslEqZmER6TqBxsw/5U3eccEWNotIyqkEE0SFUAUcqqVuPkaBqiL346YnTF1z8
	zUwPIbQkFkK+KkemjwD9NX935aYLW77H5j7PDyZfw3WFDTLIVtsNkxmt9aUc0Ydb
	EHtM1m6xiraiXtM5uHUqQVj+hi3sQniKfPfIJdcNCIkEM4smVUikYu/jJZoltGwr
	OofuhQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499kkhmxww-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 13:41:27 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-24456ebed7bso54335655ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 06:41:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758548486; x=1759153286;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PIWnFWN9JswVjgeJAZVSk7CUtGSis2EJBGP3G7aJZqM=;
        b=ngIivYedzWKz2uF/zN394s95TLp+6LQKPuf3bCoosodNYnqkggi2GunMqcMg2XUb5g
         ngcSm3WomRxLXAynifI5HAEhoVvc3Ji04+O/aL+yDfDJ28qlMdfXQxbPj6BOW5o2TUqp
         /hnJ+XIICZbVB78OLNN2nJ5kmvT9JhBsg47N+w0qft5vrGaYrhwcXoQsLfVEqbTvR3K3
         ts04IIYhPAUV6vkDIVvCthkWXaz7p4dCTrf6XIPLWyn6dE5CRCKgffhRQ4ra8RY7GA1S
         UQeS4D2dviQRoWS9HQvyHJFf9UdZZ2o+s1SENbGtV72fb0vYr1XqhwkMFcHqXAUO3AGh
         zU7A==
X-Forwarded-Encrypted: i=1; AJvYcCXx7lZaq0BxUjuKV+Tk/nH41BIQScqLgot+j3UyVVPNuUkuyZV/BsDGyncAIeDcn0DmSaax9Yade5j1N50=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+75DDnw6eLqy5k5EcJNO5kaiTNXnvO07yulY3p8FqcRPN5eqG
	HsuBlQO2ifvZTt40rHtx/kAryON+/dYkWVd8IzHIHpSxMdzRfvks/eGnErrv+ncB8PUcm+P6qe9
	5Qhr10dIWZ9PXF6KFr/Qw658qy1Yxrw8Gxv/sQPutcz7UUTBLp/jswyP3wcjx/iH7TFA=
X-Gm-Gg: ASbGnctYHp3U3rH2VkusI9E6LQzh0Cm1T1yuVl5okzH2CsRWdUAP1qrvPDbA8pHBn/0
	+QyBq3SsBW02thn3hgJyr1+SFj5FqSSgo1/Hc8ipvPJBsykAxR+SCyn5rzHHGRvQ8qxE500m4vZ
	fKJ9hSAIOnGqWHftlJ0ZvF3gDOeDGOFF9UFYtIEDkntIsUrSy7lLfCoTPDQsGDdfN+Jfud7z3Lv
	J0GlXnoKcZBmXxVSa07ROSPqb4XkygtUuKncGDDEki6ioOtv4zVQpAf0Wo9SlTC6G3vb0AsNvvA
	/9UGY0URtziyDWay6xBeFTSMTAZRVFlG7JkSb69KNfvhu6myxJKDts5+ZhpqpiEGZWrDbFaC7kC
	u
X-Received: by 2002:a17:903:18e:b0:26e:7ac9:9d3 with SMTP id d9443c01a7336-26e7ac90c41mr134693545ad.18.1758548486349;
        Mon, 22 Sep 2025 06:41:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECJWJDojyXBjsBbEa7hEjwrxc9WYv0/zCgrWii3r2CuVqCDvWfZmFkwNzUJptObbkGXcARkQ==
X-Received: by 2002:a17:903:18e:b0:26e:7ac9:9d3 with SMTP id d9443c01a7336-26e7ac90c41mr134693005ad.18.1758548485876;
        Mon, 22 Sep 2025 06:41:25 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698016c13asm134246755ad.46.2025.09.22.06.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 06:41:25 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Mon, 22 Sep 2025 19:10:16 +0530
Subject: [PATCH v15 06/14] dt-bindings: arm: Document reboot mode magic
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250922-arm-psci-system_reset2-vendor-reboots-v15-6-7ce3a08878f1@oss.qualcomm.com>
References: <20250922-arm-psci-system_reset2-vendor-reboots-v15-0-7ce3a08878f1@oss.qualcomm.com>
In-Reply-To: <20250922-arm-psci-system_reset2-vendor-reboots-v15-0-7ce3a08878f1@oss.qualcomm.com>
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
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        John Stultz <john.stultz@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Andre Draszik <andre.draszik@linaro.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        Elliot Berman <quic_eberman@quicinc.com>,
        Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Elliot Berman <elliot.berman@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758548419; l=2577;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=SmkKRQQh3S8Gtdgd1oOIc80Ljvpw2jelYZ428aYXpJY=;
 b=vLj0922EjIbkbMbR+tqY47qh1UHzIiJOZnJu5uAsC3pDrEZ1BMq1hZ/Sen1hgB2OFsr79Qcsn
 2BVNWRyGH7vC6AoW944ox7b2Qjq1qN+eQL7hQ/x1SwnmHchfyFmBDQD
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-ORIG-GUID: QmyvS4ow9EhmsXIZnrM_KExS1jkypBoi
X-Proofpoint-GUID: QmyvS4ow9EhmsXIZnrM_KExS1jkypBoi
X-Authority-Analysis: v=2.4 cv=JMo7s9Kb c=1 sm=1 tr=0 ts=68d15207 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=UInjrUrXc7y1C1sAkbYA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyMiBTYWx0ZWRfX+/1s1somhrUs
 RPhn7ArEt+Ifnpy1SItISuyYJLjDoN83RPoQxVrHKGHmDlEhvObaWbLVVCfutZMcMqIT8fTde74
 vsYnV1476bkbKLnukccmJ9BDM3BSHYH6op9UCUZxtP+fBzfUCzq5wCd9bgLU+0/o0SgUDd9HJzP
 /U+dG7zoNvL1VWHKVO3IsLQkp+zhmPUNoi7Domqy08M9pEI+RClj4w6xg1GFpbU6lHJEStcf796
 NnPbUwqRvwuWDX81U5Gv0yU8PCzo2s8B84tB9i2IjuTDTB09HxSIJzrzTIiXNEhg5sj9oNnLe2q
 e6QkdTowv1dFUwu6esJ42ANRUYW1d2kJwoKEy8Mf9qi/t/dYTIWrTFQ6BijpWlCOzrlGjxyE3De
 mmDIG1W+
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 clxscore=1015 adultscore=0 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509200022

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


