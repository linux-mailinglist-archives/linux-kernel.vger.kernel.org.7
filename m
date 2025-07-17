Return-Path: <linux-kernel+bounces-736066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D88A8B097ED
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 01:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 519831C448B8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 23:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178AC276050;
	Thu, 17 Jul 2025 23:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C9wsBCea"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E5526E71B
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 23:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752794936; cv=none; b=ZOjW1Lw4nNZOKBFagEh3RnUzamqyEJl6+MtXH2a/y+kXySoamYJFx4WjCmDqIo90gxNNV/cfEMikz1NzlgIPkEAL7Su9seZsGcGJH1TD7JxXiMZb2/VHmkPMakJPU7wLxB/KoMPWOcBUhURY4T9oNgEod8v2oO88565ieSNzMTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752794936; c=relaxed/simple;
	bh=udsEqVV7LdT+uN+5FwPOiwEpbQETrk12bfALCusLhWs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tkEcYcJjuIWrK83RI98pSDNbBFgC/zT80C6CH0P56aZOi9F9/vTny6IFVu3asbP1ziQ3ACP9zJKx4G7B+o+TlZmMvlMDz3W7Yoa02jU/KwDMFKMarKaM0SIFLQhZphmCpQV/AlLpN01RDQnEtoMqXxCPSevypil4+8r6wTDjGxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C9wsBCea; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HNRXYp020753
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 23:28:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7ybo7EjvadG+e2xPAFSbem9WLo3NezVcN9Dxj9pnt8I=; b=C9wsBCea/5SUZ+We
	gMDDAN/IrVHf8MOMSvjccfInrfRQbC1WLA+fpoWpySPF4RC+2ogHOupUU/BtVq02
	D8ABSbJfX2344KRXK/syqvq2tjOgYUIXTdRPQ+8lQOn2q8jRRlniW5OULkD5whBO
	T3xe29sFysQEgVdAYrXTMetJzZayJhgav8IGj458mZJ6wQMyBKRdrWa6PKlarhQE
	LnbAtLNa17JRN/dxlt0Tf3rGie2W2n73HsOfUd9Uemw0lhPusSkB+pmGMF+YeGmS
	xOIl5WVlGaieKbm9co4ErR/Ty7ld4b6vbDLOZc8+I5P39UCwnT6H87svQsqAhZo9
	JzNncA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5dpmh6d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 23:28:53 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2349fe994a9so11855235ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 16:28:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752794933; x=1753399733;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ybo7EjvadG+e2xPAFSbem9WLo3NezVcN9Dxj9pnt8I=;
        b=fNzRszpqKI1ujryjeLhAQRILm6rF1nKvLMzi8qqwLW7px7rZAy/uFSX8iuJw/TOTuH
         qu7avTBOMpt0Bz340a48A9NNrMBcOmJWtI97pmXLwf+8HYItzOp9NeQtih5H6YXWS9+O
         G9RRjDZcQoa/hnTsrd8QcJ8UoppTFec87EbES9+yVa+iBXJDFXkZt5PBnDcXlsRnWMZg
         mwk4rKRBtHDN0jJhYQfmKAXp+Qf0mWTPa6jkBDOXgberNS30cwGz40rudX7aiZpmMNIg
         ZJDqrCXDXPKMFJ+2BHiJnM4SdS8uU0/Dx0+cW0dnAhWoiISmSAMW3HBmsVuvxLNoL/KR
         DEdA==
X-Forwarded-Encrypted: i=1; AJvYcCUWSfjR90rMfepCbtV/MR5bQiBp9nGO2RnPzjf6gkS7mrQotwhw7aXwmk/6QfAklDRYkR9CvYngePyKV7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWEHkjQfuzAeRqra2FJtI1Ahw9SRUC3Wf7v/gpmj2yZs84EHWW
	LKCXeQi5+I5FrggCf3P/BCx3SB84QRy7XQYTSYSxF+yAtgqEWtGDL7QHwA/oFoeamx12feEOjVv
	leiZ2vJTkj+n7WoXL6ouVxV4JXuAwjU2k7wQRU4y69EviPkokNtvgIo4v06qRUNy7ntc=
X-Gm-Gg: ASbGncta+lySddkNDGgNFw86a90aWNjM7PBmDcaMaOmeogs0+z+fsaEZXEMAt7TLJKI
	iX7f58sbP6mJAgTHHMiL//Cn/nGtgI+NJR4MBToUx6n9KnRIFhWZ+uh2RKXcvd0aYRkO5LExnko
	nNHplhMTzpn/O7UaGzd64ba8yJ5Z/+9cg0RiD4cmMvIWdsTm7pjDaH9WGG16+YRXfmiEXBd5+yM
	2NN/e+Gq0sFgl5uqddao4M3BDv1Xt/4lxtlB4KdaR0ur6O12YDUrlHrkUd2TiQCZsUgbBD9LQuO
	7H1ZGNBAC+aTLJXU1pKGwoF6fRw7Vuq9us1QfCXQZj977VRcXCMBRAMEJIvjPoQ6dIM/67DQP5Q
	hljtARi+Fd2FaNrnCB+Xa5/t6
X-Received: by 2002:a17:902:c947:b0:23e:1aba:410e with SMTP id d9443c01a7336-23e25684a2dmr131959115ad.2.1752794932566;
        Thu, 17 Jul 2025 16:28:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOFsGsD60KTJbjRpb7CmKQ6G/KVM9LZO/JS8BWAYceDSZWFciCkRmX/JdxbdEmCVpfQnmDVw==
X-Received: by 2002:a17:902:c947:b0:23e:1aba:410e with SMTP id d9443c01a7336-23e25684a2dmr131958845ad.2.1752794932095;
        Thu, 17 Jul 2025 16:28:52 -0700 (PDT)
Received: from jesszhan-linux.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b5e3cb7sm2002195ad.17.2025.07.17.16.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 16:28:51 -0700 (PDT)
From: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Date: Thu, 17 Jul 2025 16:28:43 -0700
Subject: [PATCH v3 1/5] dt-bindings: Fixup x1e80100 to add DP MST support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-dp_mst_bindings-v3-1-72ce08285703@oss.qualcomm.com>
References: <20250717-dp_mst_bindings-v3-0-72ce08285703@oss.qualcomm.com>
In-Reply-To: <20250717-dp_mst_bindings-v3-0-72ce08285703@oss.qualcomm.com>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>,
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
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Danila Tikhonov <danila@jiaxyga.com>,
        cros-qcom-dts-watchers@chromium.org,
        Rob Clark <robin.clark@oss.qualcomm.com>
Cc: Abhinav Kumar <abhinav.kumar@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Yongxing Mou <quic_yongmou@quicinc.com>
X-Mailer: b4 0.15-dev-a9b2a
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752794927; l=2566;
 i=jessica.zhang@oss.qualcomm.com; s=20230329; h=from:subject:message-id;
 bh=9wdF66K4CeeQceORgBagEdldT12aDYJZI4HWG2A/5Zo=;
 b=JXB49Mx5GPk/Liru+c42GTK0DPlFLUxRjo+Hug76DtT7FgEsdc5XCT7b67DDFF0rkAtfN5RR0
 4BxCu7l3FRlA71wmUkiYi/DBhDEFVlhPdfUpaixEMBP/IBxggCMbO/M
X-Developer-Key: i=jessica.zhang@oss.qualcomm.com; a=ed25519;
 pk=gAUCgHZ6wTJOzQa3U0GfeCDH7iZLlqIEPo4rrjfDpWE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDIwNiBTYWx0ZWRfXzEXUnBT10QFj
 R+KHnFjPinkd/bZQReF4dreZIk2j5Eh82cgY6AJSFIMzRQefA/WHnlhczwjulTHxMIbZ+Jh15xE
 WnxEP8eKcjR/IGskGLdZRmLiyImju5IIepMJoQrktLmEHHk63duVuBNJkh7YJF9jlX41PIomzNk
 3My4/VNrZcjVgdjkIWtr/FUmt1lD3N67PiR1lt2bbCEDnqYfZQbL8bDq8YRaYm9yPux0v5hFxpL
 BcX1lVBsypf5vQ7vARUFmC3zeoGHtFqN05hNwx3yEtJKO+sTYT6YRaUn16pA3FhBcfuBBGyJvx2
 CRYFB7wNymn/+hhZX0bpV6iefXv0TNeECFvABwpm3+yB9cepvZ6P8UHGMBSXWgOzfkCrJCQfPsu
 nSQ6LRnYJOXq5aEAqwJu3jR1ufhoK96ELzm84+0D2bYxz6wNpD42W1L6X3kipBMigr09z6CH
X-Proofpoint-GUID: ebIIbkN6HoWftU4aj6DAE9DXFcioyMe5
X-Proofpoint-ORIG-GUID: ebIIbkN6HoWftU4aj6DAE9DXFcioyMe5
X-Authority-Analysis: v=2.4 cv=Y+r4sgeN c=1 sm=1 tr=0 ts=68798735 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=COk6AnOGAAAA:8 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=cmjLwvqn_fhjV4Buc7kA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_04,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=734 phishscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 impostorscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507170206

From: Abhinav Kumar <quic_abhinavk@quicinc.com>

Add x1e80100 to the dp-controller bindings, fix the
displayport-controller reg bindings, and drop
assigned-clock-parents/assigned-clocks

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Reviewed-by: "Rob Herring (Arm)" <robh@kernel.org>
Signed-off-by: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
---
 .../devicetree/bindings/display/msm/dp-controller.yaml    |  2 ++
 .../bindings/display/msm/qcom,x1e80100-mdss.yaml          | 15 +++++----------
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
index 9923b065323b..4676aa8db2f4 100644
--- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
@@ -29,6 +29,8 @@ properties:
           - qcom,sdm845-dp
           - qcom,sm8350-dp
           - qcom,sm8650-dp
+          - qcom,x1e80100-dp
+
       - items:
           - enum:
               - qcom,sar2130p-dp
diff --git a/Documentation/devicetree/bindings/display/msm/qcom,x1e80100-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,x1e80100-mdss.yaml
index 3b01a0e47333..0e699de684c8 100644
--- a/Documentation/devicetree/bindings/display/msm/qcom,x1e80100-mdss.yaml
+++ b/Documentation/devicetree/bindings/display/msm/qcom,x1e80100-mdss.yaml
@@ -170,11 +170,11 @@ examples:
 
         displayport-controller@ae90000 {
             compatible = "qcom,x1e80100-dp";
-            reg = <0 0xae90000 0 0x200>,
-                  <0 0xae90200 0 0x200>,
-                  <0 0xae90400 0 0x600>,
-                  <0 0xae91000 0 0x400>,
-                  <0 0xae91400 0 0x400>;
+            reg = <0xae90000 0x200>,
+                  <0xae90200 0x200>,
+                  <0xae90400 0x600>,
+                  <0xae91000 0x400>,
+                  <0xae91400 0x400>;
 
             interrupt-parent = <&mdss>;
             interrupts = <12>;
@@ -189,11 +189,6 @@ examples:
                     "ctrl_link_iface",
                     "stream_pixel";
 
-            assigned-clocks = <&dispcc_mdss_dptx0_link_clk_src>,
-                  <&dispcc_mdss_dptx0_pixel0_clk_src>;
-            assigned-clock-parents = <&usb_1_ss0_qmpphy QMP_USB43DP_DP_LINK_CLK>,
-                  <&usb_1_ss0_qmpphy QMP_USB43DP_DP_VCO_DIV_CLK>;
-
             operating-points-v2 = <&mdss_dp0_opp_table>;
 
             power-domains = <&rpmhpd RPMHPD_MMCX>;

-- 
2.50.1


