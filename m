Return-Path: <linux-kernel+bounces-866451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 303AABFFCA9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E705C1A053F4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 08:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C282EACFE;
	Thu, 23 Oct 2025 08:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OGD9BSUY"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C0A2EAB78
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761206862; cv=none; b=TjzApf9T4P9WYqzGY7YzaNKyT0jh/SsJ6LqNCUTq6R0AUh10Y7T37VX/YNbGSsBDUrEejmM1iWLr8K8eySOeCbLDI7MFGZWPQ1LNB8Bi08Ea7qS1u/L8QLh2lftlLNTMNwtQHC4I1bB7CdWcZYAPB/XS0MVaT+9Ntc3R2Qmm3mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761206862; c=relaxed/simple;
	bh=x6XlH4rmQ/CE3ZuGLhJv9iLoNBE/XleJ0ctpIQFOpp4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O7RBqWHpPyOmGTTU69o8gRcMx+/ze2s4l/pko8nO0Q631CK3r/zdQZUcpPpfK0zoypM8VeIKRCsjAGg0GsbHbndUS/jnCdzUCRI1Lz+gaccHedRcPvkDrC6eM2urtMJAk7tLfVzDLRJ0gVGgGwGTMNnwqQhItwTNIpQfzlpTA4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OGD9BSUY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N6jb5j031877
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:07:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=8KBOd7N1OKL
	iYG+vESUSEumwgDK1Wzblv22t5BjCkZE=; b=OGD9BSUYkdsHfq3VHtFPabJsc9u
	UYlYcsPlkTqGGK2S8wI86fHNHN0RWetH1lYN2CCaDD/vghhdvjPgM47OvXWb/J7k
	7KX0Qx6WqENpeRCM9oqr+nqLOx48jjfd1lHV3lW6GYgwJmgoqaUoj1DGWwoBBzPj
	ggFWdvhWe9/41nl317bUTeciWMppkFRv/pkJ59g0lq3mcaAh5164P12yo0xkti/7
	TJKOe5jme+mSTa2fmNlXTqVXqB5FAQU+b4aluaiKD61gtj4T0aDVr5g5CsXGkrz9
	iqSJABmxx2BAj03e08XTQY70W8mAOED/8CcFXWNIEShH3ryXWRJRB911peg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v2ge7hg6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:07:39 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7810e5a22f3so1317016b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 01:07:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761206859; x=1761811659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8KBOd7N1OKLiYG+vESUSEumwgDK1Wzblv22t5BjCkZE=;
        b=HkiN8+o5MaGshIZiLXxGOzL6tURppUalOFcA+1UC/foAN2UAMuQ6pGqA9yS0DvzkaF
         8KgGgRoXSugOxB7rrN10UKoP61BjKG3AaXSxiwIbggTce42h07sL49WFpygfzFN+aPNi
         +qrrwSkmsbepKCyCgTLDxkeiNBfsd4T9qaEXNQFFvcQzVNhyGlh1TbUaLgVIf2MilJxq
         /VW2YjYm/hrOHpVzKL9lK9zL9GWP4SN3dL2T/MBlcECQi009NGDPgtNg0QJQpt1PVOLS
         /db9EfDxCtwU7ErgXxtX2EkGLhnW14QdPd5SFYBDToBHjeezcElsTl76NeJWbdDlQsK+
         z91A==
X-Forwarded-Encrypted: i=1; AJvYcCUb92fOTA2EgSqUUtFbT16I7zdHKIduju9htSlEg5Rzw22xZqMETF2HrnICFZc/69x1vZeCMFtYxzMp7L0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWH4av4qg29ULwVMefo5OtSYlul80qz1C2D3qR14/ufds0MI1v
	5sJ6Kw4RU8ynvPL8S6Oj9fwDkhguRhVDyoE153IwBIErsps3cA+p5j8FGMLTTm+35OxJmYfDkUX
	uC4aAGUG0lbjUxdssW4+2pdp71xgp0maGckdGKZJucLSEaHqEt2EFLNKgcp5jcyzHse0=
X-Gm-Gg: ASbGncsPxg3QLrbmWakmrdwgwImSUIvlh2ha5WUgX5HwBVuzaoIFl5TX/0f7EGHxO9z
	ohqnC1VDUdQqDK8oPbB961JJASL7txT/eAdQ6Xz1fhQ2daCWxWgYvpSKCvb5MlECs1dVllw781Q
	ZMlkKRnHC1aEG4dlUUR+DqlH6YG71SRbqJ9BRNiUOq9AMViSLFPydbZbZ1q5QsYOv1CGtjIhAad
	uTpUEEr1DVo3d52imsrslaTrvdvSdC32epekFX2iEXDY2EvB9bXYUilV+YMtNE5NgWxNOpkmFIm
	OVTDiO+O0Z0AfvVvHxf+ZK3HYTqU5ExiiKlEIkqbSdHiwgmLVH42ne/hCpH2pkDwo3NB92h7aPD
	u9s8qyOI7rsuykl5WCspLf7R0lZWrWoxmOXTwtjBR3+esY+6AYw==
X-Received: by 2002:a05:6a00:2ea3:b0:7a2:7b5f:4ce0 with SMTP id d2e1a72fcca58-7a27b5f4ed8mr378351b3a.28.1761206858622;
        Thu, 23 Oct 2025 01:07:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjN7fa3hxvdx44/dyiL/lnUELFXzcTVbvL2kEGiyf6x7H5jfmpkQeVPZyeTMdgcZNq0ouTxA==
X-Received: by 2002:a05:6a00:2ea3:b0:7a2:7b5f:4ce0 with SMTP id d2e1a72fcca58-7a27b5f4ed8mr378317b3a.28.1761206858186;
        Thu, 23 Oct 2025 01:07:38 -0700 (PDT)
Received: from yuanjiey.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a274a9cec5sm1676410b3a.20.2025.10.23.01.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 01:07:37 -0700 (PDT)
From: yuanjie yang <yuanjie.yang@oss.qualcomm.com>
To: robin.clark@oss.qualcomm.com, lumag@kernel.org, abhinav.kumar@linux.dev,
        sean@poorly.run, marijn.suijten@somainline.org, airlied@gmail.com,
        simona@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, quic_mkrishn@quicinc.com, jonathan@marek.ca,
        quic_khsieh@quicinc.com, neil.armstrong@linaro.org
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, tingwei.zhang@oss.qualcomm.com,
        aiqun.yu@oss.qualcomm.com, yongxing.mou@oss.qualcomm.com
Subject: [PATCH 10/12] dt-bindings: display/msm: dsi-phy-7nm: Add Kaanapali DSi PHY
Date: Thu, 23 Oct 2025 16:06:07 +0800
Message-Id: <20251023080609.1212-5-yuanjie.yang@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251023080609.1212-1-yuanjie.yang@oss.qualcomm.com>
References: <20251023075401.1148-1-yuanjie.yang@oss.qualcomm.com>
 <20251023080609.1212-1-yuanjie.yang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMCBTYWx0ZWRfX2rRf+ee4z7vQ
 WybquG/jKvkDBEcKfCysI79zV5lWFdpR5aiC71P3HjftoEOv8l5Mzpiv244v4hSfsZ49SEn3yzg
 zmiZrfsq3uTKY+BMj/vLTm1cLECKNAgMt2aPGELVDywdLahBDZSNTOgN4pe8K3iJ3QAP8clLSTT
 32oja2q+dHT6yj8RqKiunRUdxwRMBniaPDnn6TpwFlI11Je5/PD5+JR9jKMwhOG4m3eUDoNda2E
 h5995xDX+aWljn6LOR+S1FREHdSpfj2v1GdQKRHAtXTC/wNZTPSXlLaq1MWMHuKTSK0Hv3u5+Wu
 mUOb/T+s/ksLMqmfMUhrRi1Lpfi4uDFR+mIGeyQWOh04N8gPrWmn3EDPoJ7wXLTdtGhGMibclaE
 oopoPBXy/V8jbqPdxGOMjOENNYwg1A==
X-Authority-Analysis: v=2.4 cv=KqFAGGWN c=1 sm=1 tr=0 ts=68f9e24b cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=tNVMJPnUsVqa3Ada0T4A:9 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: VoRfeeDerXsnroEajiKPU3jueeWOh4cG
X-Proofpoint-ORIG-GUID: VoRfeeDerXsnroEajiKPU3jueeWOh4cG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 phishscore=0 malwarescore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180020

From: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>

Add DSI PHY for Kaanapali.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Signed-off-by: Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml b/Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml
index 1ca820a500b7..a6e044eed3df 100644
--- a/Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml
@@ -17,6 +17,7 @@ properties:
     enum:
       - qcom,dsi-phy-7nm
       - qcom,dsi-phy-7nm-8150
+      - qcom,kaanapali-dsi-phy-3nm
       - qcom,sa8775p-dsi-phy-5nm
       - qcom,sar2130p-dsi-phy-5nm
       - qcom,sc7280-dsi-phy-7nm
-- 
2.34.1


