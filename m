Return-Path: <linux-kernel+bounces-875545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B999BC194BF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 473A53A577F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DCA6320CAC;
	Wed, 29 Oct 2025 08:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C3Tw5nHp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EuT9Z1XC"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB14E32145A
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761727920; cv=none; b=KH/QCGY0kP0vsyMtohoYRZ5XtcHjwcEGOaD8A6s8TbQDItr8lAJF56XUGO17WoYPFJECtXkSB/YQa3xH8I7lZyCzPLQpsmRSUhY/87tMceuT/tFgeuD9ODhquKLWrkSsQRlNE5C49CzU/R5ABhy2ET79j/q5I0oNcaiJW/OX4B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761727920; c=relaxed/simple;
	bh=fxALVBYM7qYW96U/dSw79twk6v0y6XKjhtJ/F/CsPC8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GqVtTmT2wv6d3WVfNr4YQ2qR9zxBOCb7vbe6ltMMZHj2MdjYdb/16fgS1uM2b2UeDDIPHZDgtj0cjKj1IhIXXfin2TzUSs6QvYFUKokauppbYk8x22LEwpNUKs41YRz2PKbc9ij0DwxvTKd+dcEu9XS65ifTOZwQmPCcE+K8QOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C3Tw5nHp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EuT9Z1XC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59T4v8ZU3692519
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:51:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IzFssouc9mamtc9gsC/kHechOIc88AvDywUnbNXgus0=; b=C3Tw5nHpALgj+0qW
	tXRn0MptmjOfd3RmVrEqCgzgzBoe4shjTzPAABkERvD/tBs2I7IIEBbyyO3WqWzf
	sST6p5zwrzb5H/KRn6nhZzkSLRWgyWkahBJJGzWJPBZ+z0gntxqqF8lgRZMMU1kK
	8FVa+V/nnTgyFr3H+pGrs0jJPKPWggpqOlHp/b3ITCwKbx4Tm5Ixqy2m9fXFBQWv
	hm/U8bMH/6nBNh+ytPSBVHHI0OKJNKHW4IEwctOfXIymZ0XSMW6iNsy3TLYUz1v5
	VzxiLCUSnpAvXm0rYg+tcBJArV6EBbnSeNcsfUIP0/aJ8+dU9r9DaZd4POJBH2yC
	T5sXnQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a34a2hv05-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:51:56 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8908a248048so1672793985a.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 01:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761727916; x=1762332716; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IzFssouc9mamtc9gsC/kHechOIc88AvDywUnbNXgus0=;
        b=EuT9Z1XC2pz4QfHyVGcCbBW2z0h0P85MNr1Y84+ax/tY7fvp/X3y3HFiZt2JJjoJuD
         K+vt6pfqwA4jQ+kjIV+dO+i3LfMS1tt0aNtiPL85FIzpN9ZD/I6goFw4YEwy8SmVsXf3
         V7n2jG4ReKpIpRi7qFzgWZyRfW16R4LR2+7RTiM7+OM9xws5igMoYlXcrnZZPBPWdjkh
         qdxHOQXhPh/0KDaJQFZUnNOzVq4HPot532ALeaao1D42bGWi/m88WHQhAmLq3LTbzQfV
         bWSuLadWi0eJ6CGHnxZOPPAgHo0m6n3T5CxvwH+2+sDiALgD7CTOeh+lwxo3O3Wt74lV
         iIQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761727916; x=1762332716;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IzFssouc9mamtc9gsC/kHechOIc88AvDywUnbNXgus0=;
        b=W/czkZP61SkbCOdQ32WQPWis71YxX2Gv3IDHriU7ojpKyQvtJiqJhwjo1C35md53aM
         77b54tM1oUJlV1QkCxR7aiVxxwE4tfpofIaV78lAiG5k8XxRcBzwDXXwT4EOL99EuO8l
         l21t0NVDMToLaxPGYElDnciGXZ2fqR6V0RjAK6Ow+nXy+NdyLYINKeJgc8rWmFPtvo8/
         hpXjsXQmjj7VCNwLlWZa+LVOU8yHt18BuEicPILd1PtcU5Vy+V8clXIjYNgLbqGn7qMB
         JoGY4zxROh5dQ8lYcJTpocz+dyDqtfvvJNRY8bRliwhRpPYbp59djhx+fZ/nRQq9/pAL
         kSDg==
X-Forwarded-Encrypted: i=1; AJvYcCW+pdHGmir8H1iKSLjSjaAnTefeHJHkHdCZpZJUxksCp5ktmv5If5IHzVgzxZL42ZgYvoMvkdFT99kWZFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNvruJw6tI1V3cy9nUyk/dYomc1yXUwRK3jQeZK2Gdw57CfRHZ
	cdaN53BuLbSLmAhHB/Ru3suliO1jFO5EuimCG7GrU1EHjTXVK2ttzA0y4erzXZl08F9pYIIh/yN
	/cdWW9cOsAr/iGoDt38uFFWsa2VGqoHpHt8YqiycBw1joLylegRFRavcHizwcpfv3WHw=
X-Gm-Gg: ASbGncv2SVJNmSNPV3HYo23SGq9xJdRxJvqsdGWRL8g7/CVn0QzPHOGAhJtv/gsBRGB
	jSC8weBdFS6HIPeI5TqfogPUEZUl7OvPsRlR7bZXFbDYm1QF+RAMd+sDe75wyBDEDBokKgfFnuo
	RF1r1CrA+ixGWW4kl1OWjJcE1gBx28Dk1MuPf3z66iOW/LWftyTD1Fgax3k7ZbC1/+0lcgkRFSj
	q1lWHhOhRnU3Nv7HBVFhdgcEc8LIUkgggIPUnOmVpCIxgAGjk6APFjJMODQxzj+esPeqCzQ0wI8
	h+RCaVFf2asmo7ffSeAJ/iK9UU4IA4cm72K8Y0J0rgqlu/A8MJaCf8o5entTCHgh3+HsSNVbXMq
	qYLQqTOT+uvk3XCjXO8yxjTU=
X-Received: by 2002:a05:620a:40d4:b0:891:a480:ee92 with SMTP id af79cd13be357-8a8e8f4b236mr263533985a.5.1761727916301;
        Wed, 29 Oct 2025 01:51:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFI2PPKXtce5YNBSyc9dJxl21ePvANeElFkhe5Zdk44ZWE7owVm6fkHwQ2Bv7PW0DPT8yoJzw==
X-Received: by 2002:a05:620a:40d4:b0:891:a480:ee92 with SMTP id af79cd13be357-8a8e8f4b236mr263531985a.5.1761727915839;
        Wed, 29 Oct 2025 01:51:55 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ed0817602dsm36760171cf.18.2025.10.29.01.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 01:51:55 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Wed, 29 Oct 2025 16:51:34 +0800
Subject: [PATCH v13 1/5] dt-bindings: display/msm: Document the DPU for
 QCS8300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-qcs8300_mdss-v13-1-e8c8c4f82da2@oss.qualcomm.com>
References: <20251029-qcs8300_mdss-v13-0-e8c8c4f82da2@oss.qualcomm.com>
In-Reply-To: <20251029-qcs8300_mdss-v13-0-e8c8c4f82da2@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Jessica Zhang <jesszhan0024@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761727898; l=1242;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=fxALVBYM7qYW96U/dSw79twk6v0y6XKjhtJ/F/CsPC8=;
 b=/VZVTs/VCe7bEotB+iOg1SXvQxgcLXB73EUedAC6ofipNZxQMOrmecv2X3OIP4zJJRWiOZ1v/
 sgCB+hAwthmDkZ9K/e9+jc+Sq+3GbOhUuqoe+dIa3hA7sgc7TMZb42I
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-GUID: 9JZK9JfV5ns0lwYGLnsRqLWMQvwvb1P2
X-Proofpoint-ORIG-GUID: 9JZK9JfV5ns0lwYGLnsRqLWMQvwvb1P2
X-Authority-Analysis: v=2.4 cv=PcvyRyhd c=1 sm=1 tr=0 ts=6901d5ad cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=0ru3Ub4c0dYyKLRCKckA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDA2NSBTYWx0ZWRfX+Hd+VhC9RGe+
 2IMNIDu2/CeC/RSqkT1dbBU/5OSxlOAJ+6Exqui/OGlffJ11lt7kZ+wqze6fjUUFVwjjoHC8+O9
 GDnSmFL2GH4JP9LlAaCpEp2v+QqTIM9RlIOCp51afZccYyv5AOQZe2nH+ptnKTIE7vRORdhJldO
 GrFGyBF+HVOIBrccZMKHmQBcq6CZhJAk6W5R+lNGcjhndyyNdHuM0RIUjPJo74Mc/i1qnk0+8z5
 yOUsw/0zNOUNPhGIwTvRGidlgPc8O6sM9cvKlSXgclNgMuca7nNlLRAgOM80Rp363JryPFgMaRc
 kO3LEW9AJrAM1mLwV47vp+hTElobBA+hqSUOJwu+zHYW+dDHREK3UCRpdf8vJKyXSdI9UbqfiGy
 1g2sh8LPkewkh5YLHR7yNV7fNzxF3A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-29_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 suspectscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510290065

Document the DPU for Qualcomm QCS8300 platform. It use the same DPU
hardware with SA8775P and reuse it's driver.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 .../devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml  | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml
index 0a46120dd868..d9b980a89722 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm8650-dpu.yaml
@@ -13,11 +13,16 @@ $ref: /schemas/display/msm/dpu-common.yaml#
 
 properties:
   compatible:
-    enum:
-      - qcom,sa8775p-dpu
-      - qcom,sm8650-dpu
-      - qcom,sm8750-dpu
-      - qcom,x1e80100-dpu
+    oneOf:
+      - enum:
+          - qcom,sa8775p-dpu
+          - qcom,sm8650-dpu
+          - qcom,sm8750-dpu
+          - qcom,x1e80100-dpu
+      - items:
+          - enum:
+              - qcom,qcs8300-dpu
+          - const: qcom,sa8775p-dpu
 
   reg:
     items:

-- 
2.43.0


