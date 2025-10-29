Return-Path: <linux-kernel+bounces-875521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A8DC19428
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E29B560454
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7382A320CCE;
	Wed, 29 Oct 2025 08:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="diyhMgSD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kqeS/cbh"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B437D320A0D
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761727164; cv=none; b=CxB0FfhHY2KeiwC0Pk/AdFLYxcXAm5AOJaMS7IHkfbLWrIKdyUwsUp09woS8YQvN4873Ib3q8elHpLpWQeN/xA1YFkBc/3VTboc1lX1EGqm2hs68M2+c8qqKX1GIgOAUERonEceFHjQ1nxjYWkkp7BVRDBzAFvl4nw2h0yujSUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761727164; c=relaxed/simple;
	bh=YVxhcaXTQE2kdQCpafdkbntvUWAijtEj8SyutweUyP8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=p4ZcwXPGu31n+6osjf6QVcQlfkHzBjMeJ8nRRL2UUih8OxZO3Ezut5lX4J/eL5Z6KUulwVOF3XNMwIHm7rtg7W447SDYqeRzAas9MrxLtW8yy/wH2HsELQdEzyN+7QQ2JHFak/9ZNa3WXzBOpLQHspjVZvi6m/lnDspPlS6F73A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=diyhMgSD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kqeS/cbh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59T4urkI3764246
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:39:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=sNBgwn67duVytbvZ+JF7p1
	ePAMjl/91R+GX2/HjwkOk=; b=diyhMgSDDKTuDXln6ISoVyeaD0nlo1B+v74NPv
	lJivOV5yWg1aFgAGCndA7X573gCJxnjixIy42zw5nM8ArRaWpv92iG1+xMQHjDfC
	MwTd4vxcJ6Fwec3I4b6t3AvHHomwoEogI5/zC61KarzQIj0DKK028IWQ2cL8RA0c
	YDCceU3eKlZdnJ8+W/NFe7no0GagINFv4N8Y0uJtnohJ36RXgUPVigO+DNpeG1ls
	2HW3JmTmL817GcDp4GATNeaqeIMHKwcKzEFJ7l4BUnLUtM+7jwSqigNUgQ91pRJW
	mDFYohT9Tj5r2nA462/kwnrxUxKvwXl5HnWALAgK0Z8WRwmw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a34a11tyw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:39:21 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-340299fd99dso1913614a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 01:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761727160; x=1762331960; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sNBgwn67duVytbvZ+JF7p1ePAMjl/91R+GX2/HjwkOk=;
        b=kqeS/cbhbF0DJ8m4lh0MMewNF8TBU25n6txb1ZsLGn/7dOrbGMMu73hGuwEWnjuzhE
         Cf8hECU8b/gprzdVQWWW6OCn6ZX7S0N0ZuO14eorwyKzjUyaizzlseAC8nHdUVYfH3at
         8G8pjXEcu3JTvIvwXnQTumphqgPZ7fA+RxuG3lS5Gt+JhfJ4l5uQtQwJ88c79shn97rg
         JyfmkL1/7gWKfgW+M4QO5YToj4/HWDoBOSjDh3h+pmQh6i0EZ4F8xdGRnD1tbGcAIPih
         E5tT9r/biePsh9kq0q/ghUSlWwt1JTw15LbiFqRophoCBy9TIL1TXeE6LJl6xExXtsxD
         pIfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761727160; x=1762331960;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sNBgwn67duVytbvZ+JF7p1ePAMjl/91R+GX2/HjwkOk=;
        b=Wws0pDI0to0rxq4EGJvBNcRl/jBLaPl2NLWUbjQJJiO1Zq7WrUqVdKWySy1A9qqgq3
         IU8TsLsQQhjDeflok6bznq/ja/YEyBcQlNmdLG9CPVZSIO7to1+tp4KYOgklXOzlIwfl
         b6BNAyGvKptrO//SHPaRudnCVkpzp/mV2dLLepTpDf4qTuMmWcOZb4j0ptuYJpRdU1yt
         +4A/i+82IOto4tGNQm/L2LtmM4troP1q36lk19Ezjjr3KWh20bLf3paLM19QEtBA51Tv
         GwJs94QE0kyb60YyZMS42sLxbmzDo6I6JpITf6w1Z20S/R001Pk3X45nmrggaqipu4Pq
         Vz8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVmC+Uqs1KTOqPvVWYr1J1wcKF2nxWkaSCrBOGXdqIK0D8E7wZrxiuVI2djIJJVWJFkkDltSBkouTxNZVg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy6JUdjbMm9J2koTUEPO6T5cM3j0Gz3GMg71caTiTa1kQL0MRT
	umOdVFzEAi/mh2vCKrK3WwGLl0CdRmktCb/o2JMaXV0ifel566YdCljl6jSmjxfbhavGVkG13fV
	f52Bs1m9ne8nNIbicLJ0ufJl0VFx9w05SMkD5MlzEM8UduaKbctcVY179FT0ixp3zQcU=
X-Gm-Gg: ASbGncsP9lT9Ez7yJMfuyX78ntrQC6SoI5zVju53HZQYydDfmCknjtBGW85VYOwWW9h
	fQ/pGsjVwFs4sFkjHcK+Z/znW2IZtbWQe1mWPsHcD6sN8ZZODV4XyvwwjidT91xXd/TS56Wg3Ii
	2dr4zFlKVr2enMrkNkOjWiiHaCEtnHTWbiQbr5hC8VNUbJwfSbPvWLJl3eV4ngKatt1Qp/W6TJn
	YgWzEydPapLqxn1+Wuoe5O9zBOoREkplBi24T0/VBYWm5b+MVASh+ZKZ7CcNZk4zTLUeiqJpMtM
	Q0bv84XV7f3KbqyiG6bcD4qmcrPMZuuMe1LiJz2zK6yHXXR5H//6FBwAjgIlzhCXOFKShKmevE9
	7bpFUsnbWrFfooqI4960bkQermof3wMYjE2Bnfxp/ACwHBacvhw==
X-Received: by 2002:a17:902:f610:b0:294:ccc6:ccfd with SMTP id d9443c01a7336-294dee1d1e6mr22969635ad.24.1761727160316;
        Wed, 29 Oct 2025 01:39:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiC0ghxyCDMRkuDpRLriggn3jkQhIdfOtGlVs5hwNwmV1z5dFKTu/i0LL2ag+APQf+7gFtrg==
X-Received: by 2002:a17:902:f610:b0:294:ccc6:ccfd with SMTP id d9443c01a7336-294dee1d1e6mr22969315ad.24.1761727159739;
        Wed, 29 Oct 2025 01:39:19 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498e4349fsm141948685ad.107.2025.10.29.01.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 01:39:19 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 29 Oct 2025 01:39:17 -0700
Subject: [PATCH v3] dt-bindings: usb: qcom,snps-dwc3: Add Kaanapali
 compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-knp-usb-dwc3-v3-1-6d3a72783336@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIALTSAWkC/z2Nyw6CMBREf4V07SVtkSiu/A/D4vYljdJir6CG8
 O8WEt1McpKZMzMjm7wldipmluzkyceQodoVTHcYrha8ycwkl7XgsoFbGGAkBealKxCK8700eOC
 1YXkyJOv8e9Nd2swKyYJKGHS3SrJArrXO0zOmz3Y6ibX884u/f5JQAcojb5xz2qE6R6LyMeJdx
 74vc7B2WZYvMuMcmMEAAAA=
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>
Cc: aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ronak Raheja <ronak.raheja@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761727158; l=2009;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=gZOzH0g70aJtkALwak5Bqgp+Oq+eYJFCuxGX681Vaj0=;
 b=pRlzO53OaO9KtMJH5Z07DZOgf+rhoicJmDAJMjfgp4QMHG+tkVU2/AFKb/2N4218HqY2u0VHE
 RRKgCUT7+KuBdBZObKlPPJN6l77VEFH1GxqsEC0lhzuFiJ5VmQTvJyA
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-GUID: 52aqAZAvPPTas-RcgQUtlNc4k3LrfroF
X-Proofpoint-ORIG-GUID: 52aqAZAvPPTas-RcgQUtlNc4k3LrfroF
X-Authority-Analysis: v=2.4 cv=A5dh/qWG c=1 sm=1 tr=0 ts=6901d2b9 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=A8WZL8nXqXftsXHg7HYA:9 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDA2MyBTYWx0ZWRfX4QUHenmd5WOJ
 elhdATk6prI4AV+hFA0KENBybWPLYt5tjCdnjqA3DAdYc+D1A7rjl6HaKV5V8ReEXIvxeumBobW
 2nrM85o/e0mnBdWAtCXQH0j+lg/EjPGR2PK2aw4xrl7q4AjZpgTIvEDlBJtQLT1YAi7soS560rj
 R1n8cfHzTUCsybf0vVZv4EFN/o2fsT4miUel+ZOGuV7qvjnu455GI0sDk3tmlFNLFJu8roC6KHa
 jT/7pn3cRfWO4jEtjQDvtC90Che/blgFxhTGcR5/GRDBiL2jmZ1LFgrRSNYm/cmA0pgwwwSYKXk
 L3AY6Vs4cg/Dd11BU2tfrdLLK0wZfzDpXLa36Hc7PFOBwjkQE3mda3V7wbvHU5c8azrv8osn1OT
 zuU03KD9fHO34yB9wy2nD3uGr449SQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-29_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510290063

From: Ronak Raheja <ronak.raheja@oss.qualcomm.com>

Kaanapali uses a single-node USB controller architecture with the Synopsys
DWC3 controller. Add this to the compatibles list to utilize the DWC3 QCOM
and DWC3 core framework.

Signed-off-by: Ronak Raheja <ronak.raheja@oss.qualcomm.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
Changes in v3:
- splitted from original series.
- Link to v2: https://lore.kernel.org/r/20251021-knp-usb-v2-3-a2809fffcfab@oss.qualcomm.com

Changes in v2:
- fix author name typo
- Link to v1: https://lore.kernel.org/r/20250924-knp-usb-v1-0-48bf9fbcc546@oss.qualcomm.com
---
 Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml
index d49a58d5478f..8d1ef81b3962 100644
--- a/Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml
@@ -32,6 +32,7 @@ properties:
           - qcom,ipq8064-dwc3
           - qcom,ipq8074-dwc3
           - qcom,ipq9574-dwc3
+          - qcom,kaanapali-dwc3
           - qcom,milos-dwc3
           - qcom,msm8953-dwc3
           - qcom,msm8994-dwc3
@@ -200,6 +201,7 @@ allOf:
           contains:
             enum:
               - qcom,ipq9574-dwc3
+              - qcom,kaanapali-dwc3
               - qcom,msm8953-dwc3
               - qcom,msm8996-dwc3
               - qcom,msm8998-dwc3
@@ -479,6 +481,7 @@ allOf:
             enum:
               - qcom,ipq4019-dwc3
               - qcom,ipq8064-dwc3
+              - qcom,kaanapali-dwc3
               - qcom,msm8994-dwc3
               - qcom,qcs615-dwc3
               - qcom,qcs8300-dwc3

---
base-commit: aaa9c3550b60d6259d6ea8b1175ade8d1242444e
change-id: 20251029-knp-usb-dwc3-1b0042da705d

Best regards,
-- 
Jingyi Wang <jingyi.wang@oss.qualcomm.com>


