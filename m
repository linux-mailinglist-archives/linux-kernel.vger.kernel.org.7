Return-Path: <linux-kernel+bounces-804962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F20EEB4826D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 04:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9347189EDA8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 02:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533D62236E1;
	Mon,  8 Sep 2025 02:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nSLTumgV"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D53013D512
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 02:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757296979; cv=none; b=stBmPj5JLe4zRtXBySgP6kYWN6rB7c6v083pi8yO+Ie2SD30lMMXSsj5mAHcd7oCL9jSOBoB0CTMFOVfDbmnyHq0SXTpWeXEvwQw4hQLibvrMvHe4+/ESdc9o45S/oVaM1uDV9OQLShA0hsstnFdRiBtSj0fPGBejtRXHX3myk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757296979; c=relaxed/simple;
	bh=7Lmwt8RPe9FYwcCsZot55MuF3UiAhcsArLukTTIDuFQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mgDSzY5sBx4rDA4ElB/Xe4tj+EcjTzTVz5MBQ5ZTRpIT5MxeAS7YVp/yZEDt10vehFu6ovbv44qouRgOLVTv95ctTt5XX/SkXzp1+X796OKxODE8E6qRlIWG1OHowC/FOMYwakd4qUzAV0Lu0JYQNZp1szJLQ5FWtg0YhkKQULo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nSLTumgV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 587MbDVx030332
	for <linux-kernel@vger.kernel.org>; Mon, 8 Sep 2025 02:02:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DShGhrjrqskk81shUEZqzaXPQnfD8BZ/czBlA9gz3OA=; b=nSLTumgVqQrTMDgw
	v2vrZb3bewD4HnzT8mf+QH+dTwiawtd8HWCq+n3HNFzzpqWhx4iUeGenxynk/Ysa
	b18YxHQyP0SCVuOjgrkV6EfA97WpFjexFI8uQhvntY3BHnt60J+HEgZTQFsd1uj0
	HNIbxcXmCt7fg5Xlt+eU2fG49g8RNAKf+qftRnE+2ylF/4C6FXObsI8HprGyJFKv
	8KUkgNy+7+onpdvLswb77mdhsn9JK4OJ99iaPzVW8pU7sYDS5Vy+uu4e6AJn9kXs
	tJRkkhB6JSzhYpnwzRLsDSengoVSA8OdNXKNE5VBhCVVhegT/UT49llSzW8n3huX
	i/Ix3Q==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490e8a2tsd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 02:02:57 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7722ef6c864so3568874b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Sep 2025 19:02:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757296976; x=1757901776;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DShGhrjrqskk81shUEZqzaXPQnfD8BZ/czBlA9gz3OA=;
        b=lVzAvBDlfSpZtmekrQpHHIUjlyqg3ZyOw/G9Ng7Nmo4VU9MpurlP+bKUa777t/XAg7
         Ib/aqHZQuRDHdsNKHPgjS6R8HKppMqdTb5jC40xsQGOxsp0sEmSqWMn5//FCGJKjXHM+
         gAbp+PUmWpr11sSL556zMB1RY3ilMRMZLJ39x0Q79Wz9YuOFWNWLqhV7YBLN1v1FE3A+
         EYWfelxO9q7E6bktQbb1hprmpBVsoIC9PLe+bv/C4rAa5sCN/VUOEMu3FYFoezXWuhwR
         kaQ2yIaYmvQyUMQIEndBtxkU2uq4RPRbjK/UD5eBv7VEB2qiPUdILGZwBaueL5vGGxTj
         6cpw==
X-Forwarded-Encrypted: i=1; AJvYcCUhLVdMf4opid8zRM9PVAKKqqhG46cp5q6Gr1EgZCSJ2yiKxai0rT2KlSaEIapjau0aSkTy+bFR1FHgOUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzHh/X54pdYHpqQGPW45NBXjG15Bmj8bOBmi4s6T8JrL9VVt63
	xlpAEG0J6W2vacaw5Xv0V5ogEiSQFU7HI8JoWDZaWzHFg/WXgY7Y7DEkZjT5ngh90QfOQVYVZPU
	0yHREGGgjUhYbb5Vb1X0RAIwfs4cR6JyLuoLiKZzp87EtXGDP0OPz7mTJcEK0M0Ncllo=
X-Gm-Gg: ASbGncuTWgbn12LDfG9C3jVviaZxGITG/Jx7wzyB9QACP+6Ykqz/bejvCzdDzkLeLHC
	CxdOa3LbNxBxBA0q8dS4hJ8mRvH7Pr2hZa0MdBTyh4sWNI3SNSX9sl7pJ44Cn+4Ghvpry0sJlKh
	GoikDRQPfmtIyPcH3+y5KZlXEczWVHm5ApVrlDCe5CTcBranVqe7QuboLJS6vXX9fn05avltEFp
	ajdOP502pksoKUfElsATiTjqj1tQ2UbkN9x8Ok/X51AhzLDl6sORngaAK1t/xBxaYZfPqnMeaPm
	9yanNGyMy9aeUFYD6wdN3k2Au+mKrkwLEi/vjo68bZ/PtEz7B6W1CSjnhRaA5oMAEgduif9ui7K
	fc1cmbkc9zE+lThc5PyzFKDk4+1Y=
X-Received: by 2002:a05:6a00:2316:b0:772:4759:e45d with SMTP id d2e1a72fcca58-7742de8f0e6mr7749326b3a.22.1757296976267;
        Sun, 07 Sep 2025 19:02:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE21drREBfGZ25w/CVQp8dbwRMeZLBum3GOWYMesmkAgDZBajK5madzZ26jtZiz8XqCEaW0eQ==
X-Received: by 2002:a05:6a00:2316:b0:772:4759:e45d with SMTP id d2e1a72fcca58-7742de8f0e6mr7749285b3a.22.1757296975797;
        Sun, 07 Sep 2025 19:02:55 -0700 (PDT)
Received: from jiegan-gv.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7723f4858e6sm24285076b3a.4.2025.09.07.19.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 19:02:55 -0700 (PDT)
From: Jie Gan <jie.gan@oss.qualcomm.com>
Date: Mon, 08 Sep 2025 10:01:58 +0800
Subject: [PATCH v6 6/9] dt-bindings: arm: add an interrupt property for
 Coresight CTCU
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-enable-byte-cntr-for-tmc-v6-6-1db9e621441a@oss.qualcomm.com>
References: <20250908-enable-byte-cntr-for-tmc-v6-0-1db9e621441a@oss.qualcomm.com>
In-Reply-To: <20250908-enable-byte-cntr-for-tmc-v6-0-1db9e621441a@oss.qualcomm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>,
        Jinlong Mao <jinlong.mao@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, Jie Gan <jie.gan@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757296940; l=1804;
 i=jie.gan@oss.qualcomm.com; s=20240927; h=from:subject:message-id;
 bh=7Lmwt8RPe9FYwcCsZot55MuF3UiAhcsArLukTTIDuFQ=;
 b=Dc6xN4+sy4FfyxjirI9U0M08+G8323SeEKPga96f9sV/F8cXG2ByJ9zM6mCw+w7GwLgMMn9ph
 uC0Q5GaMEQID8V3WMgEL8/BG4NUAMYkDXV5bzZFjrl78oC4ClcU6zkb
X-Developer-Key: i=jie.gan@oss.qualcomm.com; a=ed25519;
 pk=OZh7JyRifqJh4xmrcGgmwa8/LCS8O11Q+mtx4aZGmi4=
X-Authority-Analysis: v=2.4 cv=H7Dbw/Yi c=1 sm=1 tr=0 ts=68be3951 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=gSyxy6DGYGa4b6s9XCEA:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: SHZ7dk5XTYzifA0lmDroHUId21onbx14
X-Proofpoint-ORIG-GUID: SHZ7dk5XTYzifA0lmDroHUId21onbx14
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzOSBTYWx0ZWRfXwrX1JasBVOUn
 IdZv4yhkCX/dFI3CrTZR16ULrDp2Jd4636WmMnBxb29F1AqEPNvU9o332Yac6JQ4JjhvD8u8Qlb
 uML/14WHsTQ0nQ/7+e2uC/YrSg+6TAqrsdn52v7eFCV61E0E+kI25mGYKKgDYaXNavOPYk9NIsb
 3/W8QgqMfJpvwunhZiNw98V+0r7IhtUob0FHjao52kdVLQgFsDYsi9MfyiX/b697QLTnIgH3cd1
 e2hbl2skJvumxPptHk0QpfZnuqJIfbo27xMMQoCusjDpTDqa7D41qR+uyPr1KjD57aUY9DY5zwl
 rPxtHfhDM146a5qfB5DAdkXFbczAMrYGcFR287t8HuzMrRy+0ptyshP4p1DYnJAQqOAngtbkXLK
 W7TqoL+L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-07_10,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060039

Add an interrupt property to CTCU device. The interrupt will be triggered
when the data size in the ETR buffer exceeds the threshold of the
BYTECNTRVAL register. Programming a threshold in the BYTECNTRVAL register
of CTCU device will enable the interrupt.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
---
 .../devicetree/bindings/arm/qcom,coresight-ctcu.yaml    | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom,coresight-ctcu.yaml b/Documentation/devicetree/bindings/arm/qcom,coresight-ctcu.yaml
index 843b52eaf872..ea05ad8f3dd3 100644
--- a/Documentation/devicetree/bindings/arm/qcom,coresight-ctcu.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom,coresight-ctcu.yaml
@@ -39,6 +39,16 @@ properties:
     items:
       - const: apb
 
+  interrupts:
+    items:
+      - description: Byte cntr interrupt for etr0
+      - description: Byte cntr interrupt for etr1
+
+  interrupt-names:
+    items:
+      - const: etr0
+      - const: etr1
+
   in-ports:
     $ref: /schemas/graph.yaml#/properties/ports
 
@@ -56,6 +66,8 @@ additionalProperties: false
 
 examples:
   - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
     ctcu@1001000 {
         compatible = "qcom,sa8775p-ctcu";
         reg = <0x1001000 0x1000>;
@@ -63,6 +75,11 @@ examples:
         clocks = <&aoss_qmp>;
         clock-names = "apb";
 
+        interrupts = <GIC_SPI 270 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 262 IRQ_TYPE_EDGE_RISING>;
+        interrupt-names = "etr0",
+                          "etr1";
+
         in-ports {
             #address-cells = <1>;
             #size-cells = <0>;

-- 
2.34.1


