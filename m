Return-Path: <linux-kernel+bounces-853652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7972ABDC384
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 04:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AD323E7D0E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 02:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BFA07494;
	Wed, 15 Oct 2025 02:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FExM40WF"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0262609D4
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 02:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760496980; cv=none; b=OkqNUxd8TdjYkxLvYlIChxbDeMOKfRS1hDzLp6/vT4Rs7H4cjWfCP5r0gbyr8wB2ZGls0oQ/MnHWKBzg00rMKKrVkxOqzB2ZB+H8LPW/jIJhqYOvEAL+uWFSaTRf6oEErW995Qic6aks0i82SZlz43XRpsAzBQcDFf59uvM15fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760496980; c=relaxed/simple;
	bh=XiTtG+qO+1qC4sDF1M/ekkwzg3uVl6NdOygd3cj5Ljs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dycAmRs0fSra9BKruObTWT2jq0nFMjhwDGIOhDVBVqaquuI6avisgRvgf/ylSPSfSqhTjEi1eCyKlIlJArsDQCFX2q1j5Ewr8t3oC/J7AjNFXxN9MhFdkRq69UN5YhVFXnTvYuxjfgGrZci9yQjxSm4gBYn5w26ubncAOoExIr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FExM40WF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59F2sCxc016723
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 02:56:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aJhGwl0+NQVNf0CC7XanGxdHLIYfBFvJpssBFIXoLsA=; b=FExM40WFifCg+RYW
	niLqs05oveRren7c7gFaygxmSzaQsmIwPycTuh4rEDkm5jQ1zOmaVd/qQ3SMr6t1
	DLRTmGPekkDpRlMm3bPEJ71KT1q/ixXxSsrXOoj8o3EcEHqcr4SREhmeUDN7SG5F
	Ez7Demf0Z6Z6OunM7thRDtMycK4XnpmkhKiWgGM5DIkr9HIHMvSHHphAid3Q8wRw
	K540Oj6DUboZ9VoMOJXvGEAT6nGlQaf2hKVro5k433zFbh7skE4ryIw4l75Li96d
	XUTMGUQ7A2pHP13JHbGxsp6dWWn9N9AV6JpZGfBJd9tnjAm2ssGwFnE1bzW9Gkv9
	ERhUYg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49rtrt7r83-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 02:56:17 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-269880a7bd9so119435055ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 19:56:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760496976; x=1761101776;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aJhGwl0+NQVNf0CC7XanGxdHLIYfBFvJpssBFIXoLsA=;
        b=jr/4BE6uAstbLLVkOHu2t7dS0387mW4l7nY3+KQwfuhUkRrLtFylCQLQFQ4l0AVL7y
         kNoxt/v1Kf5NVb6mOGsd65NYeqHB3+dmKFywgHJ0FixtJ5dgNtLhVqAEv02m1lub/IKc
         3zc8qdu4o4dgukpT1yGeZM5q0lfATGqKRclDyoIfvzozEUosbZYZ8vPv6m7MIjM0kRUH
         4ho3p9jXRpGMmZBVRxrNKJL2JXLqFjXRi6yXgc2GAXofx7I3rbdcEN+oj4MJ1Gxr9fE2
         eYBT97ikQr606l0NN5s1U6DtXOzfe9iGxHrz0Wei3ShYDGhmrpzZ2Gv4LH6JsU9pnPUM
         iqBA==
X-Forwarded-Encrypted: i=1; AJvYcCXbb/wyaLP06/zFpP0QGzNVKmzR73zWvWuXKBh4jUs9QoM5cMtLWW5BSS63MX2amBduFoMon/07hQTaVPw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwovI8MZFQPOB9VnmnyFLuSLkksTdfH33PC5v15Y1FgFFdhHQkK
	9KQUqlFBnR2nm4h3WsE7PcZ6IaKBlmp6JzygZsqGfLTCqe5jPZ8zPLC3sTtz38fHSjlhcomzq8U
	Hm6lgbrxOjzXFFIvVqAAEG82JR2MGxpqsNPxrWz5+ZTKtzvetkfCziM0OdaojEw+wgGM=
X-Gm-Gg: ASbGncsqmkj1tgFHD2WRrBC97AzVjRihbtuae9pGxtm9kndLxDcpcwwjOqP7YZbGu0D
	OV9XIR2HhvLqDrH+SXIVaLbDjb7z9BflgAnw4KyX2Pm/Y7cdEurLfO6UbaDqQTH0mXF5VvFrXhH
	c8nkdulaPxd8kialIBos/ZRErH4IcbzpJTJG86tuxhOIPO6aG/PcXrFLPf00s5TCm/hOndOC2KY
	ECc5Uz6/xwFaAY21l4O1xqj9F+cXnRROGozyetBZ5BHLjQxJSOTk+6WP+dx9muADrvuZt/wSU3o
	sUHk5re1PWXDTyRQyLpMB8kaYUvqCTAGLzK7LgFkh1BRjByOtc/r7uOxje3xs7py3n25uB/PGu1
	lqjmiWNZ+ppGHn1BcfWw=
X-Received: by 2002:a17:903:2349:b0:290:56e7:8ca9 with SMTP id d9443c01a7336-29056e79048mr161148425ad.52.1760496976258;
        Tue, 14 Oct 2025 19:56:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJRTQ6zDYzFTd5M3LyFSpDAWS/PGQqXDN7RRKhxdpQPmV5rFDp/Fh2Y5nh1Wx3dPb/vjxm5Q==
X-Received: by 2002:a17:903:2349:b0:290:56e7:8ca9 with SMTP id d9443c01a7336-29056e79048mr161147975ad.52.1760496975823;
        Tue, 14 Oct 2025 19:56:15 -0700 (PDT)
Received: from hu-hangxian-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034de54d2sm179122855ad.12.2025.10.14.19.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 19:56:15 -0700 (PDT)
From: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
Date: Tue, 14 Oct 2025 19:56:01 -0700
Subject: [PATCH v2 1/6] dt-bindings: i2c: qcom-cci: Document Kaanapali
 compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251014-add-support-for-camss-on-kaanapali-v2-1-f5745ba2dff9@oss.qualcomm.com>
References: <20251014-add-support-for-camss-on-kaanapali-v2-0-f5745ba2dff9@oss.qualcomm.com>
In-Reply-To: <20251014-add-support-for-camss-on-kaanapali-v2-0-f5745ba2dff9@oss.qualcomm.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Todor Tomov <todor.too@gmail.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Atiya Kailany <atiya.kailany@oss.qualcomm.com>,
        Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: eZy8CpRdg2p5KUH2ZANqGT6XNtSLIBsW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDAyMiBTYWx0ZWRfXxnLSjJg3zK94
 UjnlDeS6AZ/tPq37l6H/b+VW1Qv52SB5N1UANzYz3AI0tE2wX809KjLX8W8mZ52hUx6I9+G5QJx
 g97EFWWi6zzgCef4uDNPqsK/j3dXYWR0NwRnj5VwCKXxAYyl3SgUwa2ThH2/BearoI//v6qKZ8a
 ah5GtjMTDr1NKtpqn8ApjwZywOMxbTuPpRFfK54p5tII/MoB9+NzDvoU4il4A3oXVXwqXXuMkSA
 FcW9L9ou0TLs+G/YwbOIXH/A0g2jd9FNA+GbjNj0sG+jjBWmfJHoVagbw8HJhaJhooAMqB63yZi
 4Vxr7myo0I/oQ+w6uYIwvTQsAHiZPTssUYtBUvyRUfYmJb/WxwJPawBmPrAPhhJwJkG+jfdScKW
 DL8V+Gk1vb5hCFZ3rsyR2FPao5j/qA==
X-Authority-Analysis: v=2.4 cv=SfD6t/Ru c=1 sm=1 tr=0 ts=68ef0d51 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=mZPZtqNPFm0sPOGUM0AA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: eZy8CpRdg2p5KUH2ZANqGT6XNtSLIBsW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510130022

Add Kaanapali compatible consistent with CAMSS CCI interfaces. The list
of clocks for Kaanapali requires its own compat string 'cam_top_ahb',
aggregated into 'qcom,qcm2290-cci' node.

Signed-off-by: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml b/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
index 9bc99d736343..0140c423f6f4 100644
--- a/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
+++ b/Documentation/devicetree/bindings/i2c/qcom,i2c-cci.yaml
@@ -25,6 +25,7 @@ properties:
 
       - items:
           - enum:
+              - qcom,kaanapali-cci
               - qcom,qcm2290-cci
               - qcom,sa8775p-cci
               - qcom,sc7280-cci
@@ -128,6 +129,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,kaanapali-cci
               - qcom,qcm2290-cci
     then:
       properties:
@@ -136,7 +138,9 @@ allOf:
           maxItems: 2
         clock-names:
           items:
-            - const: ahb
+            - enum:
+                - ahb
+                - cam_top_ahb
             - const: cci
 
   - if:

-- 
2.34.1


