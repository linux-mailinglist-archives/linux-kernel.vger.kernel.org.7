Return-Path: <linux-kernel+bounces-668612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C315AC9516
	for <lists+linux-kernel@lfdr.de>; Fri, 30 May 2025 19:48:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9972C5021FB
	for <lists+linux-kernel@lfdr.de>; Fri, 30 May 2025 17:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1964276030;
	Fri, 30 May 2025 17:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hzDz/6t6"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75D32777E1
	for <linux-kernel@vger.kernel.org>; Fri, 30 May 2025 17:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748627274; cv=none; b=eEIxF+i34/5XqDaaMsDfcZIg7pX466qJuHBdcRLo3lq80clAbtmW4c1wFO8cFEOXQpaxqKKVUeR5jcZjxhSMHy8QuF2PxF6cV94hgjT7efNKYzTlkcJob0IH5mlYZpYxWcU0wLzRL2U+iGDJsp8pNY/M15oRBXYOknjuNdyTmkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748627274; c=relaxed/simple;
	bh=vbi/w88bn+4r6GHhKzds4JbzH4QvFxghGPvM42LRrxY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DprYC5/cxn1xwnTI/HCOGC68imGqsVEwGfMIgALKgyiEvYDEU0Hm2dai0inwXRJuHeNHMouMkeptovbzlVhd4ls0f7pfeQwbyKztLQYYJ3C4cLCS3eW1JLAzFwLY+WjJfm+qav111xmeLEjIHAMbrFlvS3fVchspkPvmOnE3+pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hzDz/6t6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54UBuDhn024022
	for <linux-kernel@vger.kernel.org>; Fri, 30 May 2025 17:47:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	khHTbN2zgPVwjQ4DOJcigVbiT2iFKXeeDi/XqMYdWWs=; b=hzDz/6t65S1wibMR
	djbj9dgbbbD3ZjxdBgMypqOaYGObl6HkClu5ZvO9VkSntlVw8oXE8O9Y/V1enYAw
	Dv+60D1oWJtug7qWC4HZ8laqvoIZmeZXWR423QkAwSBSe3ZDGCLY84Xg6mr+SPFm
	ILmB7SThHfPsAD9mJKd+Rk/eTggp5tzLZPYLbZJuy/UwhOcPZ4Aoo2ONRADzycEz
	KMYYEX+dqK/NP1lej4oUTyWE+p3IyN5GIf1MSWT6tAMjGHG5+0Pt2CMsCFKrSdQ5
	MA/Q64HzgTwR5asc1OMLdP5ekoVULG50I8HjMM2PzdkhIwFD0NDZPv0sa1DywBCq
	ctke5w==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46x8d7enmk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 30 May 2025 17:47:51 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-311ef4fb5fdso2240315a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 May 2025 10:47:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748627270; x=1749232070;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=khHTbN2zgPVwjQ4DOJcigVbiT2iFKXeeDi/XqMYdWWs=;
        b=ZgoD2mmHuMTDPfL4yYG9p5P/wnf4d/aPkHjW97FAmNeATVLXVN2DPEF/fWVUeoDIfm
         ZRYY3tZ2O0GBkU/glvhMgVK7qS4E9ethBdoRRCC8yQP9Paq5PZfP8RTORi3jnQEzBpYE
         YQGpBmz004jrR3lptCKSU3/YZ8tQEV+0Hn8jwYKpnFqjTRCshPdPdsT+6i71EN5nEj2A
         CFGXEMLL8VgWyuu03XOF87kd+HemZfBRMNS1Mii1iUORnwaTDmVtgjOuO/b9g5Fy5iKG
         OoRBXwlz8PdcfTX1YNomkAPHhdxatSGnCsmYwbJBklc5z28yW9lx9lTrGyv+5kBgCwhC
         FDbA==
X-Forwarded-Encrypted: i=1; AJvYcCWc3LXXt6MIlNvwCjXaKEzSpGuvgIz4W2PEU6avA1VGi8f6SSySWLKEFNwGiU9PMoR+sVRLe3D0/W/zYig=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJpnrp+bJhp6mrHrhFsIoBskRlQtKui4gA6C0LVbuAJxWK+9pO
	L179zs7XoX+M0APFyGypb2zHR3LAALUUQrTUmIjvoDyuaiToANnyZPgGVfC3cL9Sh6ZofKauEoV
	WwzwT42cRns4sGshwIVWe01L46dppgBLA1H5+IbL1Ft2tGoCl+Ld2xDxC2H2D0PuKzPWTxJWLwn
	g=
X-Gm-Gg: ASbGncvhFILdcCpc83tBvRgbw0+h4VPnSIcdz0ovnVFcBYIfGfiojO6S7sLlhupQQHo
	L2Y9ESpNA8yfOJyndU5c7fF2jCM9x9jcLCZpqBJmMQY0Pd2d1IluejK/zwrPHZ2Y+QwfCPd2M7h
	8/S4SXnETE+j0uZPh+8DVmwz9P2Utpe4cNiC8/t9c1YQWfdGa810Wxi3IEVr911ISn1aYK+juw4
	u8oCSIqbcgcMhIYADnBjsZHME6sRDFa82EKlP4hYWTl3264oW9VRgi4CqdYBkF/DjU4eHL3//G8
	rKNzTwQSRWORxg3LSKtggkSt4F9mOYMN2pfwE+jGnoz723hPwpMmWZ/0ph44o6whE+PeYuUgoVD
	DtRM3Bow=
X-Received: by 2002:a17:90b:2dcb:b0:311:e8cc:425d with SMTP id 98e67ed59e1d1-31241506d31mr6547632a91.10.1748627269552;
        Fri, 30 May 2025 10:47:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFY5fQBi0vRSOCOnkgAQMMl8AKALo14A/FlLGJ+QUT9fRJlX8VlW7k9UeRk1c/HvjXaY7qvJw==
X-Received: by 2002:a17:90b:2dcb:b0:311:e8cc:425d with SMTP id 98e67ed59e1d1-31241506d31mr6547594a91.10.1748627269051;
        Fri, 30 May 2025 10:47:49 -0700 (PDT)
Received: from jesszhan-linux.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3124e399b0fsm1615381a91.30.2025.05.30.10.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 10:47:48 -0700 (PDT)
From: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Date: Fri, 30 May 2025 10:47:27 -0700
Subject: [PATCH v2 4/5] dt-bindings: display/msm: add stream 1 pixel clock
 binding
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250530-dp_mst_bindings-v2-4-f925464d32a8@oss.qualcomm.com>
References: <20250530-dp_mst_bindings-v2-0-f925464d32a8@oss.qualcomm.com>
In-Reply-To: <20250530-dp_mst_bindings-v2-0-f925464d32a8@oss.qualcomm.com>
To: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Abel Vesa <abel.vesa@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Mahadevan <quic_mahap@quicinc.com>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Danila Tikhonov <danila@jiaxyga.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Yongxing Mou <quic_yongmou@quicinc.com>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-64971
X-Developer-Signature: v=1; a=ed25519-sha256; t=1748627260; l=8267;
 i=jessica.zhang@oss.qualcomm.com; s=20230329; h=from:subject:message-id;
 bh=0r4My2lGG9ZWJ8k5yIrGP9vVqFB3vvLAR7AQaS0zYTQ=;
 b=pYDNza39ArfR3qQdonv9bRlqyRO8iYWgmyj2Z10EBP0qNfeAuA5obi82X86i+9DsAwAgUBcz5
 AIhRkK5NVNYDW1x9evvVyi1y7+F7vrz1j3PdEHmKtkDlpbrfc4XBf6W
X-Developer-Key: i=jessica.zhang@oss.qualcomm.com; a=ed25519;
 pk=gAUCgHZ6wTJOzQa3U0GfeCDH7iZLlqIEPo4rrjfDpWE=
X-Proofpoint-GUID: TGc_BIr9476gnyMRAsErndVEr4g1JUyK
X-Proofpoint-ORIG-GUID: TGc_BIr9476gnyMRAsErndVEr4g1JUyK
X-Authority-Analysis: v=2.4 cv=X8pSKHTe c=1 sm=1 tr=0 ts=6839ef47 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=iZctjB8Tiv542dVYzCoA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTMwMDE1NiBTYWx0ZWRfX7QxYKf20+ObV
 9m5zuP/hNkLPYAPzAosOMZJbByLReGlMUh9vLHTZNPXsJxEKgsjLhjCzzzmu6uoDZqnmHM0+l+9
 VgJCZhqgbG8X/Yt74cxcvv5wMWrdZoZynNz3j5dkrrecbgtNadAGePvdSfZUV4ioXj/AEUmpe+/
 /wyd6neh/VD7j/xRDCO6wcAcDfj7mya9bBP8kzTwdgGsMqeh1sT+R4HgBuBi3OOBC2B5YJOaxdv
 LTy1fGU8fYyMl9vp973Lwpuuagx/nHZ9EqneS0vQd4ximHT3epLUXi1RKqr0xdypbC1pouVumdG
 33c4i0SKNW5MUoBcriD/P7qJpqKCwo+QnAGSm6rwa0+WiK38EPtIsZ5MriOZbB7JLbWfNyEIJH7
 nBS/kN+zB7yxZhFFr+OB6YrYMQE7lxJsnaStsJN5D/DXhs65zLnkdDxPnXKJSB5mSil4PiY+
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-30_08,2025-05-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 adultscore=0 impostorscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 clxscore=1015 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505300156

From: Abhinav Kumar <quic_abhinavk@quicinc.com>

On some chipsets such as qcom,sa8775p-dp, qcom,sm8650-dp and some more,
the display port controller can support more than one pixel stream
(multi-stream transport).

To support MST on such chipsets, add the binding for stream 1 pixel
clock for display port controller.

Since this mode is not supported on all chipsets, add exception
rules and min/max items to clearly mark which chipsets support
only SST mode (single stream) and which ones support MST.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
---
 .../bindings/display/msm/dp-controller.yaml        | 36 ++++++++++++++++++++--
 .../bindings/display/msm/qcom,sa8775p-mdss.yaml    |  9 ++++--
 .../bindings/display/msm/qcom,sar2130p-mdss.yaml   |  9 ++++--
 .../bindings/display/msm/qcom,sc7280-mdss.yaml     |  9 ++++--
 .../bindings/display/msm/qcom,x1e80100-mdss.yaml   |  6 ++--
 5 files changed, 56 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
index a63efd8de42c..81ffc141e00d 100644
--- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
@@ -54,25 +54,31 @@ properties:
     maxItems: 1
 
   clocks:
+    minItems: 5
     items:
       - description: AHB clock to enable register access
       - description: Display Port AUX clock
       - description: Display Port Link clock
       - description: Link interface clock between DP and PHY
-      - description: Display Port Pixel clock
+      - description: Display Port stream 0 Pixel clock
+      - description: Display Port stream 1 Pixel clock
 
   clock-names:
+    minItems: 5
     items:
       - const: core_iface
       - const: core_aux
       - const: ctrl_link
       - const: ctrl_link_iface
       - const: stream_pixel
+      - const: stream_1_pixel
 
   assigned-clocks:
+    minItems: 2
     items:
       - description: link clock source
-      - description: pixel clock source
+      - description: stream 0 pixel clock source
+      - description: stream 1 pixel clock source
 
   phys:
     maxItems: 1
@@ -174,6 +180,32 @@ allOf:
       required:
         - "#sound-dai-cells"
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,sc7280-dp
+              - qcom,sm8150-dp
+              - qcom,sc8180x-dp
+              - qcom,sc8280xp-dp
+              - qcom,sm8350-dp
+              - qcom,sm8450-dp
+              - qcom,sm8650-dp
+              - qcom,sa8775p-dp
+              - qcom,x1e80100-dp
+    then:
+      properties:
+        clocks:
+          minItems: 6
+          maxItems: 6
+
+    else:
+      properties:
+        clocks:
+          minItems: 5
+          maxItems: 5
+
 additionalProperties: false
 
 examples:
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sa8775p-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sa8775p-mdss.yaml
index 951e446dc828..4fdb78a400c4 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sa8775p-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sa8775p-mdss.yaml
@@ -384,15 +384,18 @@ examples:
                      <&dispcc_dptx0_aux_clk>,
                      <&dispcc_dptx0_link_clk>,
                      <&dispcc_dptx0_link_intf_clk>,
-                     <&dispcc_dptx0_pixel0_clk>;
+                     <&dispcc_dptx0_pixel0_clk>,
+                     <&dispcc_dptx0_pixel1_clk>;
             clock-names = "core_iface",
                           "core_aux",
                           "ctrl_link",
                           "ctrl_link_iface",
-                          "stream_pixel";
+                          "stream_pixel",
+                          "stream_1_pixel";
 
             assigned-clocks = <&dispcc_mdss_dptx0_link_clk_src>,
-                              <&dispcc_mdss_dptx0_pixel0_clk_src>;
+                              <&dispcc_mdss_dptx0_pixel0_clk_src>,
+                              <&dispcc_mdss_dptx0_pixel1_clk_src>;
 
             phys = <&mdss0_dp0_phy>;
             phy-names = "dp";
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sar2130p-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sar2130p-mdss.yaml
index a1f5a6bd328e..e1b2788e2710 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sar2130p-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sar2130p-mdss.yaml
@@ -207,15 +207,18 @@ examples:
                      <&dispcc_disp_cc_mdss_dptx0_aux_clk>,
                      <&dispcc_disp_cc_mdss_dptx0_link_clk>,
                      <&dispcc_disp_cc_mdss_dptx0_link_intf_clk>,
-                     <&dispcc_disp_cc_mdss_dptx0_pixel0_clk>;
+                     <&dispcc_disp_cc_mdss_dptx0_pixel0_clk>,
+                     <&dispcc_disp_cc_mdss_dptx0_pixel1_clk>;
             clock-names = "core_iface",
                           "core_aux",
                           "ctrl_link",
                           "ctrl_link_iface",
-                          "stream_pixel";
+                          "stream_pixel",
+                          "stream_1_pixel";
 
             assigned-clocks = <&dispcc_disp_cc_mdss_dptx0_link_clk_src>,
-                              <&dispcc_disp_cc_mdss_dptx0_pixel0_clk_src>;
+                              <&dispcc_disp_cc_mdss_dptx0_pixel0_clk_src>,
+                              <&dispcc_disp_cc_mdss_dptx0_pixel1_clk_src>;
 
             phys = <&usb_dp_qmpphy QMP_USB43DP_DP_PHY>;
             phy-names = "dp";
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sc7280-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sc7280-mdss.yaml
index 7842ef274258..445224758d34 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,sc7280-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sc7280-mdss.yaml
@@ -380,14 +380,17 @@ examples:
                      <&dispcc DISP_CC_MDSS_DP_AUX_CLK>,
                      <&dispcc DISP_CC_MDSS_DP_LINK_CLK>,
                      <&dispcc DISP_CC_MDSS_DP_LINK_INTF_CLK>,
-                     <&dispcc DISP_CC_MDSS_DP_PIXEL_CLK>;
+                     <&dispcc DISP_CC_MDSS_DP_PIXEL_CLK>,
+                     <&dispcc DISP_CC_MDSS_DP_PIXEL1_CLK>;
             clock-names = "core_iface",
                           "core_aux",
                           "ctrl_link",
                           "ctrl_link_iface",
-                          "stream_pixel";
+                          "stream_pixel",
+                          "stream_1_pixel";
             assigned-clocks = <&dispcc DISP_CC_MDSS_DP_LINK_CLK_SRC>,
-                              <&dispcc DISP_CC_MDSS_DP_PIXEL_CLK_SRC>;
+                              <&dispcc DISP_CC_MDSS_DP_PIXEL_CLK_SRC>,
+                              <&dispcc DISP_CC_MDSS_DP_PIXEL1_CLK_SRC>;
             phys = <&dp_phy>;
             phy-names = "dp";
 
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,x1e80100-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,x1e80100-mdss.yaml
index 791de8a277cb..1ade6aed2e20 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,x1e80100-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,x1e80100-mdss.yaml
@@ -183,11 +183,13 @@ examples:
                <&dispcc_dptx0_aux_clk>,
                <&dispcc_dptx0_link_clk>,
                <&dispcc_dptx0_link_intf_clk>,
-               <&dispcc_dptx0_pixel0_clk>;
+               <&dispcc_dptx0_pixel0_clk>,
+               <&dispcc_dptx0_pixel1_clk>;
             clock-names = "core_iface", "core_aux",
                     "ctrl_link",
                     "ctrl_link_iface",
-                    "stream_pixel";
+                    "stream_pixel",
+                    "stream_1_pixel";
 
             assigned-clocks = <&dispcc_mdss_dptx0_link_clk_src>,
                   <&dispcc_mdss_dptx0_pixel0_clk_src>;

-- 
2.49.0


