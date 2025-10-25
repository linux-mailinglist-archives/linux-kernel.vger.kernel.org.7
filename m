Return-Path: <linux-kernel+bounces-869667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7FD9C08779
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 02:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DAA81AA0AE3
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 00:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6BC20DD51;
	Sat, 25 Oct 2025 00:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AkQv0Szv"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E137E1F4C92
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 00:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761353281; cv=none; b=XbZCcQtvsMffibJR+DJR3RzqIf/HEYltOqiNXyjAIcVcvp0Py1m622Z3LW0Y47fHQwFMNqwLC/0t87xC4OYr73ACWgjEGovd+91WAl4jmiIdtvVnEpU81+rP/+dSb9gHI1ZCeWv2s4HGWgavx/0k8vS0TLbMJtDUmJtARX1uiDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761353281; c=relaxed/simple;
	bh=Gtdks5sRRWP0qS8krG8tAarK9vtdzRhuSLSFgbJ+Fo4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RfE+4yphs/kmR77HtyuBMon2l/4AKul9uskstILf8HHLgjqnM+IM+5c1Lptg3lHN3UifBci6NKPiVv4C3D+B4v57Rw5jITIRLqEcyjsk5m45XNmhBA6iVPqvxIJhPkw+zpueB3sNlM+3BE2vCZAqlFbxFNWvI3Yz3QD1ugiI2TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AkQv0Szv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59P0lv5K006748
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 00:47:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FpyZ/jEjKaSYlOYj3phtrHzSdLTemRurqojrELo3sr0=; b=AkQv0Szv4Ej/OXo/
	AZPNHECa5l27fFbHMTS0AJgXWLFeUG0neqXN5Yy2WPy9yD0RzMdt8M+CN7SE9vwb
	RxQIf6A1RZsmT7jvnkbx2j+MdAodPa9VJ9Z/zppXJN0CGBocTL0smF71uUEHAFMp
	CxdJATyDdZ1MHsw2gkzHV5etUTMZZ/b/rKH2ZhDbxQdwTVLyATRL46V6jPJoa9tH
	e44acU+qmwjeHqM7u0Tr4E9aLdQE8fXsG2puvJy41bjVfug42t1kOe45RqidrKCy
	nFkkuq6/6tJaCUNAXAzyW4WeyNEJTjDGEQj62ZHUnEizWD+TTYQOzUDx3qXlhGLm
	dVjU0w==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a0kwn015e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 00:47:58 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-33bcb7796d4so2599180a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 17:47:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761353278; x=1761958078;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FpyZ/jEjKaSYlOYj3phtrHzSdLTemRurqojrELo3sr0=;
        b=P13Av1Nw3nhMaL3AXD2rbRLfpDzynQiudiXLLx1TJv0K5cW41u+zIbeJNFTjH4XaNQ
         fBt3/jtvKwN+glJgpgHRSz8wQjLYWfDbkAUFK9xRQhrONbxM5AbyzCCYeegFlnkimQPO
         A0CI4kNWnFpbDRItrrsY8z5LBgA8Fnoh2Jmjz+3L9nYpdlHWMjaj3gdPqM8UuOwrt88H
         t5taUxFD7VrzFAZuaqnvelY9HNyL0/Eb3/YjuxzEbwVSE/699i8FDZvTwVL8IyKhg19Q
         oITYz049NmW5nhV6gzynDtGRUojP2DkLcmqiyPkAVz4Ryj8dumAIjh/1aRAkirBkrGLP
         Em8A==
X-Forwarded-Encrypted: i=1; AJvYcCXUh4fjXxo03gm98cY/0Ahy452QTZgCazHiSxPnxZl0jIfAVRMneBMoIPF0399aazFfHEaBKAa092bwXMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtDhFXB5CnWfttVhJ7ffmM24DamB51/T9gwjTlpt4hIjRNlRCM
	V149IndZFYaYsjP8lAsKODvzpCGcd5PURUCIzuWK3W37Mrj5VSpGwSv3mXvfq6z8ZF9pShcT5V7
	ZCiiZ7IxuEcVmmtS3rGbKhuPn0cPCv9Xrc9XJRH0cFAUM869l8WvjH8vXrip7PbtCe4A=
X-Gm-Gg: ASbGncvDWAPkLDx2fzIHAuU/+YyVB0PiPEQ/Nkyi8daxqSR3kKBjUxuoEqeXQm2mHJR
	24qjpd2rE53bwwBPIWOAUuLq+uIOe21ddUm+r8QVgjPlKkI4QVnCCNLYGfz+lqUN72dQrC30XXe
	0WGu0fEoUMSUGivXA/pKlFuYm//kbddklWmHvSWjUEnTmGSYlwpV8LqYfeJ/WX+zPO3jZUDKr4p
	g+I9IEUoRzPAAiA0j2sb9U7qsup6Hwj4snR3wihLYSoatGMrjBNuGu7fBUeowWAx7vNXtGNHWGT
	lD+QlwHDOL1L4HdRYEFzIu+MpELNyxyRRS9LCVsz2Ov5/RLFLTI7OJZ2NQ3n35fxYBU8Zl7vzA+
	U0qrQsIaV10OZIeeBPY0p+Si3bhb0ruOc/pmyPPa7L6Kun4bnhxo=
X-Received: by 2002:a17:90b:2788:b0:33b:c995:5d92 with SMTP id 98e67ed59e1d1-33fafc44ab6mr9447525a91.32.1761353277719;
        Fri, 24 Oct 2025 17:47:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYH/5TsIqZuEFZIG1UZ4ueu672sDXLlIYwgUMrBT51DhoBhrAhbJdQmAPUmoGjktbLGq4fuQ==
X-Received: by 2002:a17:90b:2788:b0:33b:c995:5d92 with SMTP id 98e67ed59e1d1-33fafc44ab6mr9447502a91.32.1761353277293;
        Fri, 24 Oct 2025 17:47:57 -0700 (PDT)
Received: from hu-wcheng-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed3eca8dsm167352a91.0.2025.10.24.17.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 17:47:56 -0700 (PDT)
From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
Date: Fri, 24 Oct 2025 17:47:41 -0700
Subject: [PATCH v6 3/8] dt-bindings: phy: qcom-m31-eusb2: Add Glymur
 compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-glymur_usb-v6-3-471fa39ff857@oss.qualcomm.com>
References: <20251024-glymur_usb-v6-0-471fa39ff857@oss.qualcomm.com>
In-Reply-To: <20251024-glymur_usb-v6-0-471fa39ff857@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Abel Vesa <abel.vesa@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wesley Cheng <wesley.cheng@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=MJ1tWcZl c=1 sm=1 tr=0 ts=68fc1e3e cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=mc96eN7qxqRGlWWVoSgA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: fwfKSvWpK215WuQEDV_vaFw9_hKztg94
X-Proofpoint-ORIG-GUID: fwfKSvWpK215WuQEDV_vaFw9_hKztg94
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDAwMSBTYWx0ZWRfX4hgaTzM/9Ssb
 yA4uAb9dM10m02i4z6QChHIsIRwJQ5BXwETbZyyueQHJlGO9zS6Akc5P+tHFlU9H9SOTV6I1S88
 R6E8D57XlXgt8LBQea56fRThiY6IKAdnvJ7/IdZ3N/3ShI83Cuu2oaIbuTLx5hZW6aZPuZAb0Nn
 uOPZIMFCdFF8ZZkTMygf+DeFkxYoc0ZU1xhup8CFgeut/WJaM2abFlcmmRSMSNZA7SvnX7qt4y5
 71qzSbYoz7j3FUephvricH/LrvuOFmDxw0gLbnYbCVJHgK5d1ZBudeB8KDcP4G5PqBh8ZMPwF3e
 lBvYuSyka8EDrjzOpfv0GV3jknVxAc/Sb8CTBT6v9qAv6l+mNZSNipz0p4AvN7+BWh0cJ7M2kZQ
 Oq5+r7XpZ4GSZQ+sVI2fRHdF8aXuug==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_05,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1015 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510250001

Add the Glymur compatible to the M31 eUSB2 PHY, and use the SM8750 as
the fallback.

Signed-off-by: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/phy/qcom,m31-eusb2-phy.yaml | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,m31-eusb2-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,m31-eusb2-phy.yaml
index c84c62d0e8cb..409803874c97 100644
--- a/Documentation/devicetree/bindings/phy/qcom,m31-eusb2-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,m31-eusb2-phy.yaml
@@ -15,9 +15,12 @@ description:
 
 properties:
   compatible:
-    items:
-      - enum:
-          - qcom,sm8750-m31-eusb2-phy
+    oneOf:
+      - items:
+          - enum:
+              - qcom,glymur-m31-eusb2-phy
+          - const: qcom,sm8750-m31-eusb2-phy
+      - const: qcom,sm8750-m31-eusb2-phy
 
   reg:
     maxItems: 1

-- 
2.34.1


