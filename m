Return-Path: <linux-kernel+bounces-853746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4C2BDC83B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 06:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2EC47500A3D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 04:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9052FF663;
	Wed, 15 Oct 2025 04:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JH2ZtRT8"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003EF2FE56A
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 04:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760503176; cv=none; b=NPcl2A6DaX3ndzfJJmlSR5vRSzoChynlnIuAhfYpOmSiQaq8OXVyErocFHWyywLhJxpFD5xkdnewpxVafig4ZVEcxaXGv2JBzoZ/E2OWUAiKKt+HtOYqansfXwNEbAWLHAewihH0txEB0q1vIErn7SpI1Vc5vHNEGPV6uakPhDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760503176; c=relaxed/simple;
	bh=R3BNXlzor3OWM1UHW0bocrQrgSVBuB1WLn0clYEcPVU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=soFgKz3DSIQkSi/qjDBS22TVpby1OVZvlqc52iJSSOIXmUICSPPbJiGVz9m7WTFXScEEh1VajDDjzA4vCNHD8Caj6S149xetYI990sN8AYDTlpBrnf2pnkqUIAms0MsnjgRLEQzN58w9vgYWb3knJepqfDw7EqabWZAFc4IGL7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JH2ZtRT8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59F2sCAi016723
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 04:39:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PIWnFWN9JswVjgeJAZVSk7CUtGSis2EJBGP3G7aJZqM=; b=JH2ZtRT8ZNdz9xiq
	AW2vvYos1zoieDf+tY3EZfn3FiZaR949bUCAeSrSS8bmV3tbRtr5fSPLDfngJBJP
	gJtgaMm1cH82nF/CFktTCWL3rXukYTz6rJ70xx5AdtYMEXw55Abe5WCBJlhTQqkD
	KR6lqMC7dhOlnpjBdESbXdzn2Y0QU6K/zBQ/X1vxAnY/mPW6oO6S2JUpTDHDm74r
	tbLzPWUQEZpM2/uukOS9VBtdmky4ENhnNH4l111rGiIca4FwUFkCTjQUAPrfZ9I2
	t/Pvhp0J7XWhu+tm5RHMvLWzWJ6Z8oxsBj0GR1VDwgS/Q9qnH9oLWNmliFGjysuE
	j8U75A==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49rtrt80ad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 04:39:33 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-32eb18b5500so15769483a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 21:39:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760503172; x=1761107972;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PIWnFWN9JswVjgeJAZVSk7CUtGSis2EJBGP3G7aJZqM=;
        b=WRvYOvyTW/v2FGr1zEPs2NxAtCs92QdVTSkSWxoAXZOy602BmFxZjwWaTNMqUb1ymB
         ZclsXWSnEibfUUP1/DhAHmzw7P8/NoE1jXZZ8atowneLWTRLKlOeknc7MpKMtLLLQPc3
         CCWSqD2oTQwzFLpoBpb1IiIR8mFMYRysj99Nx+pnLyVcG7JETCmSjaADfBgoiNtoJ1zX
         Q9bgG5aL6I4Vuv8EJQ/jC3YTyYGwzgvYnEzdOIdM9LOPFv5bf1rdD8dED8zqc0+LE9c7
         93QPfDEFM+vmfkJPYZEwGsM/dQIF+auKegVjZcPS/KcklabnMkOLgmWiR/l8/hWgIObv
         65bw==
X-Forwarded-Encrypted: i=1; AJvYcCXUFuJIRRL2WqzCHh0iE7zPLBrOiojLSMaJtfncVTNFTzQbsBOy4wHApHZM40MgxggYk+QxSRnuqrRhveA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKJrzPIB4o9VGIyPQY9wcFvPkWcsPkCwy62PAM8wQwNeEjExWy
	G2+Wm5QfpzvIrQ1vkIGhqonDY/DlU9eCufzt3TSZmKEDL9WTXJoV7f2/zxfvDKd7x7i7RHYYyi1
	JPxIpk311UHp3vePsAAvDGtnrCPJUTlo7+2M4q+zzYSvU+WMZ/baa+pXpVuBEwpyBX0w=
X-Gm-Gg: ASbGncsvic+k9Yaf7y6FIlBkuwgt02ShbjiQVwfU487ZIn6a5C50aowB4uOLowJjtwU
	QiPXjvnw71DhGyV5kf5MK9hds4yKCZ1Dy05LwOsYhKnfSxDPeHEJX0V4L0lLsjqvGam7fW2swFA
	lU0QwaCNsaAmMhTjTY9aQJkdsHDxYI67DNh6qf9DfVmb9RI2DWOZ3ny0A+ljKkcaeZeu7OJSlKM
	nZdjOZzgVq4shFHmCt7jARLXMfA1VhsXlsEmY6W8bxtcynU6Mji3c8Kh9NS9YFnIMzPO4U0JHLl
	9wbQ1MgS/KmI7eJ3vII72gNTdjXwmtz9gyavb4BJUj9Q4Hn2RCJI08EsoJPnJagd/ihgYYg6454
	D
X-Received: by 2002:a17:90b:3890:b0:338:3156:fc44 with SMTP id 98e67ed59e1d1-33b513758bbmr37056546a91.18.1760503172035;
        Tue, 14 Oct 2025 21:39:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGvgRTzb7knqpzNaPhY0yhlNG4N72VqZ7xUOrGAMsJmJgROcSWjkXAQgsIq6bZw5DGhL979w==
X-Received: by 2002:a17:90b:3890:b0:338:3156:fc44 with SMTP id 98e67ed59e1d1-33b513758bbmr37056487a91.18.1760503171499;
        Tue, 14 Oct 2025 21:39:31 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b9787af5asm705406a91.20.2025.10.14.21.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 21:39:31 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Wed, 15 Oct 2025 10:08:21 +0530
Subject: [PATCH v16 06/14] dt-bindings: arm: Document reboot mode magic
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-arm-psci-system_reset2-vendor-reboots-v16-6-b98aedaa23ee@oss.qualcomm.com>
References: <20251015-arm-psci-system_reset2-vendor-reboots-v16-0-b98aedaa23ee@oss.qualcomm.com>
In-Reply-To: <20251015-arm-psci-system_reset2-vendor-reboots-v16-0-b98aedaa23ee@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760503106; l=2577;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=SmkKRQQh3S8Gtdgd1oOIc80Ljvpw2jelYZ428aYXpJY=;
 b=xFWNl2F0ikA8PPaXC182saCjtRr1XUwFnvtiVQhNheBP+zjdeXpRqUdgNHkvYcVkRoh0+o1OY
 5Hbgz914qE4Dyp3XBaHoDUpnGA8R0G/mmiGUlTxticmhUydrCTYhxBU
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-ORIG-GUID: 3odKvzAc6CZwFQhji6F2IOE-KcWId8mu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDAyMiBTYWx0ZWRfXycMh97pB22Nr
 b+or4HimSQH+HtRWcwcok8hM+iO5Z5rYLX5GNN7vabhD5koMrKtcuB9DjlR+Bvjf3EIFdsDze1Q
 /qzux75fMzuGlfEFcx74YoS28KVlEAk4+iy42V+ZyWFO3onWxU2VsVQGGKXoYhUKte1Vi4YCVd1
 xCOzV5p1GLYpyU1MkMO1D7dVk8miQ6NLQOiyqQjvBHkStHwt2X0QHA5fM5uwCjJp81fRsg9n3bx
 HOOH4k/nRoFYHF2o0viSRj9/jfqPMhPPbyof+DPWiZaNNRZ0xObmk/ubumdSP9lZJqq2GQ7lbGS
 3pEKqUq2YuWDYHSKHCAmnbFws2mGU2V5Tcxsnk+QtgZXBh3jOB4LZPb2y/fwidTc57CCFWSAg/L
 DCzjxJWu3lP/tWyrePaIsrqBrSAn5A==
X-Authority-Analysis: v=2.4 cv=SfD6t/Ru c=1 sm=1 tr=0 ts=68ef2585 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=UInjrUrXc7y1C1sAkbYA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: 3odKvzAc6CZwFQhji6F2IOE-KcWId8mu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510130022

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


