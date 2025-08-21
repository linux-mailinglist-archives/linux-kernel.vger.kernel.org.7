Return-Path: <linux-kernel+bounces-779461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 387DDB2F463
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 11:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 768061CE18F9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 09:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9072F28EC;
	Thu, 21 Aug 2025 09:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PsAE+VEE"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F9D2EF65C
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 09:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755769495; cv=none; b=kRnJTZNIob7hugSz0cuCrukw3wj+qEqlTqfF6Madgneuh42UtW9Go9/OQyTL4WD4J2rR8598CIm6SkceohexRq5Kqsg3/piFc252zmjpOan90uiCywsSVbRgtQc7PXdh5TBF3xxYVvtHc+pCr26u3+WC4neM7za4/MAI4/jsIGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755769495; c=relaxed/simple;
	bh=OYLGPSROlM94Y8YMfz+cAy5T78h70o72gHxUfKcZJ3k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YMggQnRf2AE51x0TczTVES6QEk+ipCJ3x3UprjRPkMgU51qsEKPSwFJGXIsGD+2wKvtOxWql1cuL9qlHy9KCrZLm4ouMSnsXPLxt3bdbRwZa+uaA153sm379H2pSxwuHui7nGFVjak8/02Ue1URRrlCvoGLhI4kLfVCs6OcwEqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PsAE+VEE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57L9bEt0015298
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 09:44:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4HB2uUgg4ObiGLYTjYfuAXBTtDoOjkuI+b7+MZ1F1B4=; b=PsAE+VEEmmQF2Sau
	/CClwvxDl/DVGgLZhQ/XD1sWcoKBxNTTz9sQJXrP98irkOvGQYP/k+Jj+T6NduYf
	AKOsLLeR0+oa3KLCTZ3ANXwFZFbZYHcaz6QR+NVZYqtZkiKOBFX/bYSNomh6m9S4
	GyZscyNIxj6Tbmn6u7zYDp0mIUfLA0GsIMoBm/zdhFa9Q1ALMoMwyFyVnfMyU+aj
	Y7EqOibQw+QMRhI8tm0MhxipKpFrnNLwCr12bZ6MuY7Nn56hlqN8Y5ej+/jcIiVW
	nmp+HEQ+4gwY2oE9O0KzLgwCNhmp+0Rd/nZQfsoRG93uYb4IyuGryeCtifbon48R
	iHGCyg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n52cmy9u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 09:44:53 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b47174b2582so1399923a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 02:44:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755769492; x=1756374292;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4HB2uUgg4ObiGLYTjYfuAXBTtDoOjkuI+b7+MZ1F1B4=;
        b=UakJopdh1cNscLDhUMYMIIKyDb0d5y9vX4ITbWQththy8bs8EOY7ATvv7UijZ68xXy
         NCGpMv4f9rWxdurfOp7+ugiC7ugEubSi8oGPzKONejmRJ24tr6Jerj6nijXKcj5uzwRj
         lXDTWm1Ii5BITZtKwZTY9kKUhlEcnSuDwDCfqSsDVLmREZJJZ6/2XMQR6rYfqtdAgQxk
         tKdcRBxzkHpuViq1PbskQmgP5L7Uh9YuAVKXGek/whfOFyuQrgw32ZAONel//RHQqGnn
         qIRRzcoOtpOn1kZcMGKeXZnMhfbU4EYVojzDTl2/7P+5dtEQYOawe4OaqP0LpQugYutr
         eauA==
X-Forwarded-Encrypted: i=1; AJvYcCU8CBJRXoBdzI9Hj2JNJnM847nmnIaZRk9FtM9c4bwSFdVA6e1T9scwiIJjOu5KGq24QbiE8JDYOkKY1gc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXS6NnKi292/wcvSgDJq6bwt6nK2/uZQNAhXGbVgcTx1R0hheO
	OJxRzPDkxMJ2dNukowZYBOGSs+zZNgFt596pajriNdQiClW3B2PDOXNUaymItg8+gL53/Pc8UO8
	x1AEnV4buuJzawON/1x/9IGjuLfnNS/sBc+5YyrkxD6TwBawyiSyIOBgw9EF5UnkSbJc=
X-Gm-Gg: ASbGncuXHBFXgmmreb6Exjkw6nbccjDv+ViL8R5Mf1TqAObMf3s/sfnE5ypM3/GLaH1
	Ff+gQ9l5MnIGhh8zI5djjKiZ9DOxAUvFSHMzalx8s588HhUdRP516CodZrwDj3CGFRJ/LPh3Bz2
	DxR/p/BG3V/DqP++i+Yn5lqHT7MjA24qPnKZH06PL1EaupFUr3MkKY0jg8Ke/IBmc6EskeYUkTb
	DtZHXkD7kG/S/1Fhy4qF2+cBQYAWdCRmnZI/ioLaGKnTGkGuVbIf2u2/RgB1oUXNTvDWMuptkK4
	mpP/z2ie+wEhquJwfrIGyI5/9Puatw/qxEtruaA6Fw8HqsIfYit8jHrBwTR/lP2Pi6PBYyR03UQ
	icW/bnitOhj+DCZY=
X-Received: by 2002:a17:903:384c:b0:240:640a:b2e4 with SMTP id d9443c01a7336-245fede0b63mr26328245ad.49.1755769492403;
        Thu, 21 Aug 2025 02:44:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFx4GHGVHvitiI3tfieiXs12r8JEwBYJ5VY9Fy1i8PQK7RHyuxBxDvyosnXBfmKrzsdVv4Pvg==
X-Received: by 2002:a17:903:384c:b0:240:640a:b2e4 with SMTP id d9443c01a7336-245fede0b63mr26327955ad.49.1755769491957;
        Thu, 21 Aug 2025 02:44:51 -0700 (PDT)
Received: from hu-wenbyao-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-324f23d853esm1426078a91.6.2025.08.21.02.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 02:44:51 -0700 (PDT)
From: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
Date: Thu, 21 Aug 2025 02:44:28 -0700
Subject: [PATCH v2 1/4] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy:
 Document the Glymur QMP PCIe PHY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-glymur_pcie5-v2-1-cd516784ef20@oss.qualcomm.com>
References: <20250821-glymur_pcie5-v2-0-cd516784ef20@oss.qualcomm.com>
In-Reply-To: <20250821-glymur_pcie5-v2-0-cd516784ef20@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Wenbin Yao <wenbin.yao@oss.qualcomm.com>,
        konrad.dybcio@oss.qualcomm.com, qiang.yu@oss.qualcomm.com,
        Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755769489; l=1596;
 i=wenbin.yao@oss.qualcomm.com; s=20250806; h=from:subject:message-id;
 bh=5L5bgft0hY3UL+GD99tTktGev1AZdAzNOUPNY/hYCs0=;
 b=pdeoV5QDRCXDZmT9xtvFBUXUQoDPeo+E8tde+yev8M/WcSKq0u8DjWSJEglrEvd5uQ4Qi4ve7
 fEhDoOWl3GJB8NBi/EMSt+TPtD6W0ZX44pFzz4lXdUPAwolbJYpl/ij
X-Developer-Key: i=wenbin.yao@oss.qualcomm.com; a=ed25519;
 pk=nBPq+51QejLSupTaJoOMvgFbXSyRVCJexMZ+bUTG5KU=
X-Proofpoint-GUID: dFhdz1ZdBZhix5_eUGAiUj9Hhj6HS2sX
X-Proofpoint-ORIG-GUID: dFhdz1ZdBZhix5_eUGAiUj9Hhj6HS2sX
X-Authority-Analysis: v=2.4 cv=Xpij+VF9 c=1 sm=1 tr=0 ts=68a6ea95 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=prgL3jgsdPShhDvlN2UA:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX8nWrPwFtfC+/
 iCOb64fvIBhWQ1Dd8MiDP6fCIrQQCpBZZL+Mxs1uKwYkGF4ldrJA4DXt6GeAok0Fvfy0XjOudt9
 nt9lnL8UUDZzHSWG1v6xk3q7am9BBqGw6s5lvmKpqADJnsP9ATiodXAMKtBe5P5uHpe164He9vA
 qM45w5iisPEASdlH5mEKMUcaNaWXtT0xU/apWlg332qPW11yfzV6Zeioqa37bJHoEH2SJ4HFAjQ
 5dO01mM6lL/xUnsmi+TlveR6NkhFDJ4+vryaoo7qHmrpf7oVEm2mVuTTmdqHa4MTy0YjjCA56pa
 kjehJcQ9iISnLnEpXXD7K9+bhsfSwgLk9h5esXJMRh+1MebEmYVA6JBnsf1Foi8CRk4nXQh6pJ8
 hqurBS1B/+acdXdO0obC+kGjhzWF6w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_02,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 impostorscore=0
 adultscore=0 spamscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

From: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>

The fifth PCIe instance on Glymur has a Gen5 4-lane PHY. Document it as a
separate compatible.

Signed-off-by: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
Signed-off-by: Wenbin Yao <wenbin.yao@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
index b6f140bf5b3b2f79b5c96e591ec0edb76cd45fa5..61e0e2f7ec7f9cb08447e4cd9503698c0a2d383a 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
@@ -16,6 +16,7 @@ description:
 properties:
   compatible:
     enum:
+      - qcom,glymur-qmp-gen5x4-pcie-phy
       - qcom,qcs615-qmp-gen3x1-pcie-phy
       - qcom,qcs8300-qmp-gen4x2-pcie-phy
       - qcom,sa8775p-qmp-gen4x2-pcie-phy
@@ -176,6 +177,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,glymur-qmp-gen5x4-pcie-phy
               - qcom,sa8775p-qmp-gen4x2-pcie-phy
               - qcom,sa8775p-qmp-gen4x4-pcie-phy
               - qcom,sc8280xp-qmp-gen3x1-pcie-phy
@@ -211,6 +213,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,glymur-qmp-gen5x4-pcie-phy
               - qcom,sm8550-qmp-gen4x2-pcie-phy
               - qcom,sm8650-qmp-gen4x2-pcie-phy
               - qcom,x1e80100-qmp-gen4x2-pcie-phy

-- 
2.34.1


