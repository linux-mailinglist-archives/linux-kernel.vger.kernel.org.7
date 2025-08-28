Return-Path: <linux-kernel+bounces-790834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63560B3ADD2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 00:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04CB57B7E05
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 22:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64EB62EA746;
	Thu, 28 Aug 2025 22:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZUIvoBJe"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA20029B20D
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 22:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756421315; cv=none; b=qRuog1Bs+Ajb84ZiXaTdB/yaVkCOhcsrGZpDEVU5TeWcB6ymubyj/Qh/JTFGOy8u5sLt4Dt5fvvWSFgYpWhZ5Q+zmxhFtI/JPFgE6iyJ4LARHa4p7f8AcbOv6L/G/9GuARH14kqUGF73W7fQnAXfbwj5YxkAp2aZIrCDNWnCOok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756421315; c=relaxed/simple;
	bh=lBevXKdHONx87FeX9ms0nioXAmeKW3/lJZ9j12ovv/o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XFX34aUk2ZBe7KvmxWf6dzj7j3yX8AVSeWwBsG4T32X5Z4nCXa8BbEB//S7LM+O+PaBbPxfAEijN4T/V2RzEsTmowxU2CdDHsQOK+a8nvUSnYrsHb5k9q25tfUrYwUOIa7+RmRakGfMsSSXTUDFlobasCX8/pINJXuhlPMWOK+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZUIvoBJe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57SLWiGT006523
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 22:48:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	H010azYPB1dFkM9rbItrhry3MhtWqv6s9ueklIrUJck=; b=ZUIvoBJeZOkTjVNH
	BdeTWwQw9MJE3eS5Jb/1mmcRhaoxvmP00w7dfH9PDXurrZ/tu7xLqojnOK4Gh1xQ
	Q32U/ZTQUKNCQJw0xd6PrdN2viv7TKIRYKCLhL5UNctyYdJwjfltVX/l1Kim+4LJ
	GEL9oMXpJrWnFLGQUBRMM9fDA1noWep8HiFybFn49bDA6yz5JJTM+uvW8R0Ohy/T
	SYzcFXnkBKZ3R8DatrEYM9xuy6TjC4bz/Jf5swKiv7j9cfSJPkNhynTK/u+SslQb
	408NSYDWRCUOYHmd0Ll/XNTK6thnwRpbtw/h2i+HgAkgHr65L9+HCugGeXyVMLEC
	AeAWig==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48tbpgks62-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 22:48:33 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b2b3cd4d00so40333271cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 15:48:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756421312; x=1757026112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H010azYPB1dFkM9rbItrhry3MhtWqv6s9ueklIrUJck=;
        b=Ho9KRbZjWLmZPwst05wj3u7T9d2AtzmHZdh04lAHAHDrZ5ZVgZ8Zvc3icJayZn6h+L
         2gPmJxQcL5KWWCs87a/zqvmXoMei5nqeYy6IkgpXFcloj2UUwjAk4t/ysABh3W0Iayu/
         Na+jnvmeVFUA8CirVC2Wp/D/r8Uz8SEfJos8Q3ILLeuZrRaRQyUch4zrZtMIpRXW0FYx
         zQi3sJ2HNMibw5av4hJOn13kRykivfs8c+RrwuRoOiHOMTv2YkeLWGvExPCwoFVYFtyX
         QcsCJ8X1Vl8gSfdS2mmogePcgh5/fWkU9dd10Y3G1ZVig40rDUkigVOQfDXxvzod09Hs
         lBWg==
X-Forwarded-Encrypted: i=1; AJvYcCUpb/rb+/ACJ0UkZXacPvraqZ+y4lrL7/nuF+boL6rsBFeLAmYO3jHnqzTpR9Qdh4wM61EGBLZ2JuCxiak=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZoC4olQaUIJR6KOZunGru2ibJHGmyjv2lhRHWwIiBUmcQC1k9
	89Pm4kz99csNPcOhDNv7T+NibxYmJnqmnj9MdXrOm4jlMujCFnWMv39Qdk4cZCJb7BDE9EM6YlW
	TOVLI7KRyABE1B3ADM+owPzRUMqNVbee5aRiPR4M5aDcUrD23DjCaS3HzOI20qrpnEqE=
X-Gm-Gg: ASbGncsSMurHO+0M5RCXvQPYr9SCusiGK1cUqvi9P7ql+L28egM8838IiQhn6LEMePS
	2DiHAw3+d6dm9HgHSH/bpiYgrLP4Ihv8xuzSvIQKWdpU+ItjMPWTpACIHPJLjkor/ktJdEOZbpR
	JbF2wja1ZO/V67q6HqYvixOTNYWepMcQT/dTxGRHj1Yv09Hh10EE3xJNVUWF7yzj+TiP3Mr36L0
	lkiQP50GUCmrjkWJ03qrCRe0eePI5Z/vji1hXBajKT/hkrGNr7rUwpohCaZvlsReb5x+yGwlPRs
	yRkASu19hvhggjFLX/xsdKoXBtop9de94JC3gE0Fu03Dbwe7I0LDaLdgD5SqUS0O6AYMhDXllZQ
	mmVPZ3BELZrx3pxnJ2QfNeGxsRhvyEljGkl1v8ilw6MKwUq4LQsz2
X-Received: by 2002:a05:622a:2588:b0:4b1:dd3:e399 with SMTP id d75a77b69052e-4b2aab5676dmr361928311cf.64.1756421312201;
        Thu, 28 Aug 2025 15:48:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOO/erwDQbpF4Fb6KhxbS74zgMW6cQ9wfbbmzdHGrqUotbO/43B6vA9aYP5MQ8v61W+56RbA==
X-Received: by 2002:a05:622a:2588:b0:4b1:dd3:e399 with SMTP id d75a77b69052e-4b2aab5676dmr361928031cf.64.1756421311744;
        Thu, 28 Aug 2025 15:48:31 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f678452e1sm143807e87.85.2025.08.28.15.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 15:48:29 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 29 Aug 2025 01:48:19 +0300
Subject: [PATCH v7 6/9] dt-bindings: display/msm: drop
 assigned-clock-parents for dp controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250829-dp_mst_bindings-v7-6-2b268a43917b@oss.qualcomm.com>
References: <20250829-dp_mst_bindings-v7-0-2b268a43917b@oss.qualcomm.com>
In-Reply-To: <20250829-dp_mst_bindings-v7-0-2b268a43917b@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Abel Vesa <abel.vesa@linaro.org>, Mahadevan <quic_mahap@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1630;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=jRBkyHcr8xMj4BTwupyA6gCqxajStjyC+O9UZ5EGgLs=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBosNyxSi2897UPGWZ7+tGFFt87eM4WwDieX+9/d
 AYmK0GVlNWJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaLDcsQAKCRCLPIo+Aiko
 1cSSCACsQRdfjhH0Jaax+CrEha+9shhAT5RQvLhMX95pUZ2Y2o6Vhih/OvqKcCenfLYKTXOZ18F
 8oY6sJAu4UYge3f03Kp5+9J1rYLDRMfPiAsX+Po13rnS+sAflMR7Y9gGqZ7Q4eI5tG6XKUHxNcS
 ymj68EImGXDPxcj+tqACxj6MiRGFibqMCTea1hCoQIiYmjxpvAtPFAQHmc0BV79nQ9sviNijwMr
 6Yf8DfJeLIJpSNGrMnjQ0CPeEddn0VY+IaYoHzvmlcDXurmZzewpgykeUumiVfC3+/Z0rks4u7T
 y6UUq5jCI4/Umr0mY9xDWIymYe0VQaHgtrTltxNUWtTl44Gd
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: d236kQ0Ezo-VZRIIMQsl3QuVwt5eX5Nl
X-Proofpoint-ORIG-GUID: d236kQ0Ezo-VZRIIMQsl3QuVwt5eX5Nl
X-Authority-Analysis: v=2.4 cv=G7gcE8k5 c=1 sm=1 tr=0 ts=68b0dcc1 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=VjVaSBsDX57WhQYIrYsA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODI3MDE5OSBTYWx0ZWRfX1GDya1uk9bJn
 k210SFPAy038h4A08QAZ45k6aJb8WNzkwxMLgk5iNZObihMkuKuqyHwM/1RhmYT9G15eeAH/hHn
 bw0bEGOJqnLi2WYaIXCdlNiByQd43mnLErnNk3wKBvIMcqwg3OlwgWHXxzpHSbFqpsq9ZzmzDHh
 Fvz3YDeckNbt6hhqunoEQ5xDJ4paCi23bGgKXqGAL5GX6Kd6S282v+YSQvBDO9BICnaEsbuG79H
 fwjv+8mpawL1XSunzFzXb0KDZU7FSp3HkR0X7Km0Iaj5BR3aCj6H8j4iH1gk8eydUot/UIsWheR
 wG3eWN6vyRsbfxST3i9DBlIpojp7DPOH0/Yw+61AgnOPecVPQZzq4k6OvqoGLVot8jpwpkuNHgi
 4KkxoMw3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 clxscore=1015 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508270199

From: Abhinav Kumar <quic_abhinavk@quicinc.com>

DP controller schema documents assigned-clocks and
assigned-clock-parents. However these assignments should not be a part
of the ABI: there are no actual requirements on the order of the
assignments, MST cases require different number of clocks to be
assigned, etc.

Instead of fixing up the documentation, drop the assigned-clock-parents
and assigned-clocks from the bindings. The generic clock/clock.yaml
already covers these properties.

Suggested-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 .../devicetree/bindings/display/msm/dp-controller.yaml         | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
index 6316c929fd66588b83d3abaf01d83a6b49b35e80..afe01332d66c3c2e6e5848ce3d864079ce71f3cd 100644
--- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
@@ -86,16 +86,6 @@ properties:
       - const: ctrl_link_iface
       - const: stream_pixel
 
-  assigned-clocks:
-    items:
-      - description: link clock source
-      - description: pixel clock source
-
-  assigned-clock-parents:
-    items:
-      - description: phy 0 parent
-      - description: phy 1 parent
-
   phys:
     maxItems: 1
 

-- 
2.47.2


